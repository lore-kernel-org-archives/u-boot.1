Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77E69C4828D
	for <u-boot@archiver.kernel.org>; Thu,  1 Feb 2024 13:37:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A0B7E878D0;
	Thu,  1 Feb 2024 14:37:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="UpEeTlDg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B908487C34; Thu,  1 Feb 2024 14:37:06 +0100 (CET)
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com
 [IPv6:2a00:1450:4864:20::42a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D5E35878D0
 for <u-boot@lists.denx.de>; Thu,  1 Feb 2024 14:37:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-33aeb088324so619851f8f.2
 for <u-boot@lists.denx.de>; Thu, 01 Feb 2024 05:37:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1706794624; x=1707399424;
 darn=lists.denx.de; 
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=KMFn6klIEYqB6MnRqj/0U30NLKZWFePC7J5RobnIxew=;
 b=UpEeTlDgdM/5NSWo9j6K5cMAk7qDxIkGnMMeNJvyCRBuGllshbXi2q+Fw+qMi7Rd3X
 sqW11/JJDbWlKvXDk9vjHD/fI18QVEXhfoivbKyIwmwOh2lHhRqF/GATEhVdAOM7bHYE
 AX60w1JJziWYi5Wst6IFEYD9r6rHozO3jlWizf3cx0p/7TryXR4YxNmpiIbl6NaMqpm3
 sGR91LoxEKiB9BUrxVXfN3PyaukjNzHst/wMoaGoiE6pzhS9IOGpCwaMOP8JLchHeLl/
 HUiz6nvTcvijd4FojzGy2iEP9uk6FE75CByJp2ZGpVh/mb9d7B3YfMYOvWamDXyTJdQb
 Q0Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706794624; x=1707399424;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=KMFn6klIEYqB6MnRqj/0U30NLKZWFePC7J5RobnIxew=;
 b=lISRizFYRl0+joWY4+/bUF7zp2zlxJEd4a8xXDQggsUtlsiYNGefDa8u6YpQsFSXu5
 mF6hxW6tXpIuyeANae6xyDTkiJ36KcVaCuhwHNPDEatFznIZ49kqySnIM6czjfEmI9B6
 Mq0H97p+FxafhG7WeTozAuNPiiZwq9Rr+8ygHlPCvFusQ1mSomMKX1FaGnJUBfBxLTzp
 6WGAPIqjfmdSsXzFkZboHGpUCgF+3Lb0JV/ACaa3q/wQRqGxQcwtsAQbF+ojzN8zBYtz
 mZZXQz/0NvAKCWTnMPTz3CwCTOrf3aCXuPWr/Ao28d6TZjM5nt5FPtU60xdT72UHMn7R
 QtFA==
X-Gm-Message-State: AOJu0Yz+NjqZwrBVVQcOZs8PkfSIYDtNCTS3EMMa69CMYNjg17i8QWpg
 o57Y/vCj2qXW0zn99F/WLTSxtoMUbxCSbrKzUObpeJZ/qF4g3WVklW0SseRvZYE=
X-Google-Smtp-Source: AGHT+IErL78W4G/+SvdYsrFk2YIA79c7aPve07VcLVjUfUc6KyqeIj9vjPXoZLZ3e7911n86qDVVbw==
X-Received: by 2002:a5d:5448:0:b0:33b:1a0c:abe0 with SMTP id
 w8-20020a5d5448000000b0033b1a0cabe0mr944914wrv.8.1706794624111; 
 Thu, 01 Feb 2024 05:37:04 -0800 (PST)
X-Forwarded-Encrypted: i=0;
 AJvYcCVNn6fslj2ZRtcJEJ6SaCkJk3tlqB/D60mye7l3oFVjNCd5HqXKcUSPpOdoGnrxxykX7tDtedUQcQ8NMldgBbLTiCGG+OuA3pV8OqV5zkH36lS6KQAXRsA2fl1dculN7ilvHdOEad9h7zu5YXCWQRmGZE40iJ5EjJAbYXHorme4a4jWWifKeKopbDTyj4MlkF4PAA==
Received: from localhost ([82.66.159.240]) by smtp.gmail.com with ESMTPSA id
 bu16-20020a056000079000b0033b0797cc14sm3790297wrb.51.2024.02.01.05.37.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Feb 2024 05:37:03 -0800 (PST)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Caleb Connolly <caleb.connolly@linaro.org>, Marek Vasut <marex@denx.de>,
 Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>, Caleb
 Connolly <caleb.connolly@linaro.org>, Neil Armstrong
 <neil.armstrong@linaro.org>, Sumit Garg <sumit.garg@linaro.org>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH 3/5] usb: gadget: CDC ACM: call usb_gadget_initialize
In-Reply-To: <20240131-b4-qcom-usb-v1-3-6438b2a2285e@linaro.org>
References: <20240131-b4-qcom-usb-v1-0-6438b2a2285e@linaro.org>
 <20240131-b4-qcom-usb-v1-3-6438b2a2285e@linaro.org>
Date: Thu, 01 Feb 2024 14:37:02 +0100
Message-ID: <87bk90mhkx.fsf@baylibre.com>
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

Hi Caleb,

Thank you for the patch.

On mer., janv. 31, 2024 at 14:57, Caleb Connolly <caleb.connolly@linaro.org> wrote:

> To actually use the gadget the peripheral driver must be probed and we
> must call g_dnl_clear_detach(). Otherwise acm_stdio_start() will always
> fail to find a UDC on DT platforms.
>
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>

Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>

> ---
>  drivers/usb/gadget/f_acm.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/drivers/usb/gadget/f_acm.c b/drivers/usb/gadget/f_acm.c
> index de42e0189e8d..ba216128ab27 100644
> --- a/drivers/usb/gadget/f_acm.c
> +++ b/drivers/usb/gadget/f_acm.c
> @@ -623,12 +623,21 @@ static void acm_stdio_puts(struct stdio_dev *dev, const char *str)
>  
>  static int acm_stdio_start(struct stdio_dev *dev)
>  {
> +	struct udevice *udc;
>  	int ret;
>  
>  	if (dev->priv) { /* function already exist */
>  		return 0;
>  	}
>  
> +	ret = udc_device_get_by_index(0, &udc);
> +	if (ret) {
> +		pr_err("USB init failed: %d\n", ret);
> +		return ret;
> +	}
> +
> +	g_dnl_clear_detach();
> +
>  	ret = g_dnl_register("usb_serial_acm");
>  	if (ret)
>  		return ret;
>
> -- 
> 2.43.0
