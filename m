Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1971C4828C
	for <u-boot@archiver.kernel.org>; Thu,  1 Feb 2024 13:25:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EFE0187B63;
	Thu,  1 Feb 2024 14:25:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="zFRq8UPL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 539F287BD1; Thu,  1 Feb 2024 14:25:24 +0100 (CET)
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com
 [IPv6:2a00:1450:4864:20::42d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 58E3687BD6
 for <u-boot@lists.denx.de>; Thu,  1 Feb 2024 14:25:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-3394b892691so461133f8f.1
 for <u-boot@lists.denx.de>; Thu, 01 Feb 2024 05:25:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1706793922; x=1707398722;
 darn=lists.denx.de; 
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=E3mKobpOwgJFDZVRSWQkfDUGxbU28m3CcdpQ+W/GepE=;
 b=zFRq8UPLlId7aZyJU3rzOd6hrVKrTqz+AaideDywl8XPWe9nZHOZXiJli2vfRxinMN
 tHkjITJ1aUfDcnqnyJBFyVPApD0RIiG7o3yF+aLIOcw+H2nUV1V08idGKmF1vEKygtvH
 fPuCW3ye/9QIgWft3mX2jEtI4TbSLlLLFN4IbF7YwjXwn/I2ZCs6HKZP1nIMbKa6hf+/
 a/Tio9HRdLHz+GFv5FRzuUN97aYyi5htjApmH2VPC4WSaHLz1+beZp1F4++hhodWnjj6
 nZw18SQKN7z7be4jXqLisEymCk4oGVlpHWK1LvoWsdINlda4LqJV6PYC3vnuyBzKo+W6
 5gUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706793922; x=1707398722;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=E3mKobpOwgJFDZVRSWQkfDUGxbU28m3CcdpQ+W/GepE=;
 b=KeNOnC8ZnG+RHXMf373UKwDW+SZ3MndoU925Usf8opM90SQlGE4fgepD4XfOF2Oc6E
 7h2RzhJvilEahi8Yxu60slgocF1zwe8U57jx1tANtkFJd8g8JteY3s9rJkV4WbU7+oAx
 /E4cSJ2Td7wh+vMUlUgl8ZHB3EJOsTwsGjyk438Y1hMgLjnsNSq4Ll3+J9PTRhdY4Q7r
 s1RDOGvlNflIA6po2SmS08q3Yl1diG3veJdgoHUukBLYtgWwvYNiV3fD/WdKgbfLXW1a
 wHzQP7V3O4cF+ZTgiaj593n4ytFIprhav5RhEf6ICqmWLpQZnCo3um8jnzx/0uGP8ZG8
 vYnA==
X-Gm-Message-State: AOJu0Yzk3GEi09D/r8iYeObMiBnT3CtKBtJJ4N990SD+eSFItKEyUra3
 edz/keV3KoZhQYSsjFL+KD0q6dNb011eal9s3RksVJVdahJk/8HzHPjeG8n3PD8=
X-Google-Smtp-Source: AGHT+IG2MP65iKFOxtSeRwJfRIQh+ZH2uF6yNQPw7ZEOaBpIq9TTZfEd7twvwxkjYJmbd6pOQjBdag==
X-Received: by 2002:a05:6000:12ca:b0:33a:d28c:222c with SMTP id
 l10-20020a05600012ca00b0033ad28c222cmr6888326wrx.11.1706793921637; 
 Thu, 01 Feb 2024 05:25:21 -0800 (PST)
X-Forwarded-Encrypted: i=0;
 AJvYcCUYL0pmQYAPo4maDEKJ6Wjn5a4ojUFuSMz+rFT6mrhX3xhKpCydpINQRzJ7GWjq1nx+zU7ikkBja/jr4Y14vc+6piEx5UumcIm5qtQ8NFQdLfb0ZqAXHJtMSs4Hheg+egwHYsmny7XlE1cufVlMBKdplwAInwPE+y1zr4H11qXxB4SNzw+nEIqdwqUMZ1/nqI4Q7g==
Received: from localhost ([82.66.159.240]) by smtp.gmail.com with ESMTPSA id
 ba15-20020a0560001c0f00b0033ae54cdd97sm13916055wrb.100.2024.02.01.05.25.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Feb 2024 05:25:21 -0800 (PST)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Caleb Connolly <caleb.connolly@linaro.org>, Marek Vasut <marex@denx.de>,
 Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>, Caleb
 Connolly <caleb.connolly@linaro.org>, Neil Armstrong
 <neil.armstrong@linaro.org>, Sumit Garg <sumit.garg@linaro.org>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH 2/5] usb: dwc3: select DM_USB_GADGET
In-Reply-To: <20240131-b4-qcom-usb-v1-2-6438b2a2285e@linaro.org>
References: <20240131-b4-qcom-usb-v1-0-6438b2a2285e@linaro.org>
 <20240131-b4-qcom-usb-v1-2-6438b2a2285e@linaro.org>
Date: Thu, 01 Feb 2024 14:25:20 +0100
Message-ID: <87eddwmi4f.fsf@baylibre.com>
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

> DWC3 platforms depend on DM_USB_GADGET for gadget drivers to work,
> otherwise compilation fails due to no implementation of
> dm_usb_gadget_handle_interrupts().
>
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>

Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>

> ---
>  drivers/usb/dwc3/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/usb/dwc3/Kconfig b/drivers/usb/dwc3/Kconfig
> index c0c8c16fd9c2..8a70bc682322 100644
> --- a/drivers/usb/dwc3/Kconfig
> +++ b/drivers/usb/dwc3/Kconfig
> @@ -11,6 +11,7 @@ config USB_DWC3_GADGET
>  	bool "USB Gadget support for DWC3"
>  	default y
>  	depends on USB_GADGET
> +	select DM_USB_GADGET
>  	select USB_GADGET_DUALSPEED
>  
>  comment "Platform Glue Driver Support"
>
> -- 
> 2.43.0
