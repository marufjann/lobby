from django.http import HttpResponse
from django.shortcuts import render


def index(request):
    context = {
        "title": "Home - Главная",
        "content": "Магазин мебели HOME",
    }
    return render(request, "main/index.html", context)


def about(request):
    context = {
        "title": "Home - О Нас",
        "content": "О Нас",
        "text_on_page": "Наш магазин предлагает стильную и качественную мебель для дома и офиса. Широкий выбор, современные решения, комфорт и долговечность — всё для создания идеального интерьера.",
    }
    return render(request, "main/about.html", context)
