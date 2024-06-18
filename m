Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F4DBC27C4F
	for <u-boot@archiver.kernel.org>; Tue, 18 Jun 2024 12:04:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9A8B188271;
	Tue, 18 Jun 2024 14:04:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="s9EpMh+X";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B1BAF881CE; Tue, 18 Jun 2024 14:04:28 +0200 (CEST)
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com
 [IPv6:2a00:1450:4864:20::12b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9438888271
 for <u-boot@lists.denx.de>; Tue, 18 Jun 2024 14:04:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-lf1-x12b.google.com with SMTP id
 2adb3069b0e04-52c7f7fdd24so6677774e87.1
 for <u-boot@lists.denx.de>; Tue, 18 Jun 2024 05:04:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1718712266; x=1719317066;
 darn=lists.denx.de; 
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=l0GZEzuLhKb/RCwQNc11WZ+dsFF/l9AsK4g7VbYXqIM=;
 b=s9EpMh+XpH7hPUJAsk+cucwpQMtbVvvznNcp0c+HTBr1//7+8XNP6LkqyQPLMwhPY/
 nzYmBM/txQDBoqQXcTRdMxG7O7YeTDy8OcXMmjW8ZXcTGcrRoQOcb4JMf8EUIUDE/SLb
 32v6x4I9xPcBHTl9LMF/XajuPetbw2Qn5wVMx5HdQ2m56WgqHUJei8z13ibzZVQHl9Bv
 dajeLbmJmYgTeqP/xOWIf0FJY39wPpjPgmBOaPxNQnOaC/yPkH369u7OxbeXeuJpbWEN
 gLwPjW5yX8wHvbq/ICEPPbKJkM/4Ku7yGK9V3P/CBQov3h+uGor//Adht5uG83zpA5/C
 0i3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718712266; x=1719317066;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=l0GZEzuLhKb/RCwQNc11WZ+dsFF/l9AsK4g7VbYXqIM=;
 b=UnnIAwgjiGZXMhRA9hHmHKQfSAMDeZNsU4TrLnAppID4YeETMbXsa5kWnpkUPD541N
 7lLUNcXWdQ1mHe8/UWxXqdqxGLNMOJOIvBLFvo03txUjNcRw2H/FR+Iz4PsbO50pX/pv
 y8tB3nyPByfw+4fnuJuaaaEPx7metZB9Km9VG/4UvnxIA5hs6KxW7NI2DKfl6qyClt0L
 wakVG9OIBGWCVGGuzsT18rLD83Qip4vUi6wR4HccVKKXyalV0FzTb0nUXaKO1g8+UPg2
 5wq6R7lRJbq3STh3yeyRiKUGykpXl8vZC4Tl/UXQQBkbaXalIVOXwBSvfzYaN6dMffIH
 qOwg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXPl9N2E11olMJk2mWFeX+xN3A70kqF/3CHx+ZWIjIMZ4zgHPV6unnYUERPIkyeoZFnQDyL6FgO/9q8XT4qUstaORe1+Q==
X-Gm-Message-State: AOJu0YxuH+Zogoj15hpve7D6SrG27TDAOu2KxQMMFUtFWvDLE/HujHCc
 DIzkHXYumQOHQlt1qHX9p/J8haG176UW5qge6qtbj6oa90wvX/r++FH4JSQZZOQ=
X-Google-Smtp-Source: AGHT+IHuKadjVGU3Mklp7hrBmf1nIEomC/K6EwlhUrKgZm0FnLejszhcS7Hy8pn48XCKHZEw9d5gYA==
X-Received: by 2002:a05:6512:280c:b0:52c:a06a:a118 with SMTP id
 2adb3069b0e04-52ca6e64e99mr9603397e87.15.1718712264564; 
 Tue, 18 Jun 2024 05:04:24 -0700 (PDT)
Received: from localhost ([82.66.159.240]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-422f602ee95sm190725365e9.13.2024.06.18.05.04.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Jun 2024 05:04:24 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>, Marek Vasut
 <marex@denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, Bin Meng
 <bmeng.cn@gmail.com>, Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
 Dragan Simic <dsimic@manjaro.org>, u-boot@lists.denx.de, Heinrich
 Schuchardt <heinrich.schuchardt@canonical.com>
Subject: Re: [PATCH v3 1/1] usb: informative message if no controller
In-Reply-To: <20240618095857.58088-1-heinrich.schuchardt@canonical.com>
References: <20240618095857.58088-1-heinrich.schuchardt@canonical.com>
Date: Tue, 18 Jun 2024 14:04:21 +0200
Message-ID: <87ed8uihiy.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Hi Heinrich,

Thank you for the patch.

On mar., juin 18, 2024 at 11:58, Heinrich Schuchardt <heinrich.schuchardt@canonical.com> wrote:

> The message 'No working controllers found' provides no clue that this
> refers to USB controllers.
>
> Provide a message that refers to USB. Use log_info().
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>

Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>

> ---
> v3:
> 	plural controllers
> v2:
> 	add 'found' at end of message
> 	keep printf
> ---
>  drivers/usb/host/usb-uclass.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/usb/host/usb-uclass.c b/drivers/usb/host/usb-uclass.c
> index a1cd0ad2d66..e16432a1516 100644
> --- a/drivers/usb/host/usb-uclass.c
> +++ b/drivers/usb/host/usb-uclass.c
> @@ -388,7 +388,7 @@ int usb_init(void)
>  
>  	/* if we were not able to find at least one working bus, bail out */
>  	if (controllers_initialized == 0)
> -		printf("No working controllers found\n");
> +		printf("No USB controllers found\n");
>  
>  	return usb_started ? 0 : -ENOENT;
>  }
> -- 
> 2.43.0
