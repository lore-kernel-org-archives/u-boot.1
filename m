Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EB77E77198
	for <u-boot@archiver.kernel.org>; Tue,  7 Jan 2025 14:23:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 71255801FD;
	Tue,  7 Jan 2025 15:23:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Q1oa6yS3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A4A9B805E9; Tue,  7 Jan 2025 15:23:33 +0100 (CET)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 365418007D
 for <u-boot@lists.denx.de>; Tue,  7 Jan 2025 15:23:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4368a293339so123665065e9.3
 for <u-boot@lists.denx.de>; Tue, 07 Jan 2025 06:23:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1736259809; x=1736864609;
 darn=lists.denx.de; 
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=c0nNfZk2RDhQUqXmshWctOtEimPT2mFKexe/AJVVOKo=;
 b=Q1oa6yS32pQv3FxI+o0Qiq4qRsbg1mVZwjjdgqUtZCoD+l1jzR63HjH1rqz2JLMQgr
 kLSzTlbIlfMQ6ToLQmJwPdX8R/QGz07j8qk0/6P7P0u3DeVW8UfEjMYVj/2DPyDb6PAB
 16uhkJDk05wLBbJ4q7mzmY2RseIgDL4C3niEwja14JwRSRGaCcWvesUwFgV4IWTHjKnh
 pVaGBYOEApW7dXEwPS4cLjiE0RP/9WjJtByHw9/vTu8RlqxvKciFxg3es0UsDhjjGRNm
 9URTRl2L+nPqedYl0Pm8CIsg2lN13wbKMT3VoTGD7gKSfPFkoGlD/fuLNhpPfBrT78il
 63tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736259809; x=1736864609;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=c0nNfZk2RDhQUqXmshWctOtEimPT2mFKexe/AJVVOKo=;
 b=fC7mvzZxHnZyqrJQYHfgLjiLnO8NRqzUSLanORAgi4pftDGe/4ssxI1GoLWQahD5YF
 2uacyZckFtO9jgouXZeGi706u7pygGT2wVbwxtCc1wuUNfUaOSAuqiPnIOTJTQ2b23RD
 GjSOh+izv/kBriYBUCi0YEkUmPRCoLYSokSFocrvk2Z2pfbYxutiU1t0bmu4N+nkPwwJ
 1WNbjGV3e3mY7lvbxu14c+7T2yJcrXIVc/TNm/srrSWAe0I9Tx0CWoSwa6wzrY84v1KM
 Na+naGpm85kvWi7Yyh3dJrAw+EEdeo3tw4936y69ctKAThgVpMO+F2uOZZvqOJL0OhHL
 5Wqg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUuyGWkX4j7GYw69et9UOyJKVRpq+Gbb3vaLZam3hdXcMtCyIsG7YNocyOiWC/0Ga3naNNkqvM=@lists.denx.de
X-Gm-Message-State: AOJu0Yx2NAT5cxhdzqeTsXNjuQRPIGfistP/sRPd0u9BDl+4UlSxWmVT
 Ac4Z7S6gVsMk6iM5OhuEIbtVplX+/wposLQjfdUrJwtnJDBH3RPShJ35yAHgtTjo29sHAj3hVNF
 8
X-Gm-Gg: ASbGncu7DrOudyBUx7t9cxTKrS1yw+cQtSGGtv2bKI9iMIV492VQQ1IKIxQKP9+tH1r
 wxg/2+vC/HZQVBbhwZCmTx1rnD/lPbNdPukzF5MW1k+EfqIikchHva2MnUacSK4i93tI2yqEThF
 l0IAjyZeZXVAv1FJxndgBqN8FgMscl9is5YghS22sSPfNnjdyR0hdTs5FiLesWIRP/jq6YJK0W5
 WR/6XA3OUADa+sG7IZEkG5W2CEfYSsExRIF5h40q7wDJeYBfBxsa/MZWZfgH5ASjA==
X-Google-Smtp-Source: AGHT+IFleWuax8YATdy5hh17BHUu/ORgfPmC1tqLscfGbu+jlt0Cutcdn3cFotRnYCbzxZFkYUQI5A==
X-Received: by 2002:a05:600c:1990:b0:435:294:f1c8 with SMTP id
 5b1f17b1804b1-43668b93834mr424425785e9.28.1736259808428; 
 Tue, 07 Jan 2025 06:23:28 -0800 (PST)
Received: from localhost ([2a01:cb19:95ba:5000:d6dd:417f:52ac:335b])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43656b42757sm640656715e9.39.2025.01.07.06.23.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jan 2025 06:23:27 -0800 (PST)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Jonas Karlman <jonas@kwiboo.se>, Marek Vasut <marex@denx.de>, Tom Rini
 <trini@konsulko.com>
Cc: Jonas Karlman <jonas@kwiboo.se>, u-boot@lists.denx.de
Subject: Re: [PATCH] usb: dwc3-of-simple: Remove Amlogic and Rockchip
 compatible
In-Reply-To: <20240121203818.2075381-1-jonas@kwiboo.se>
References: <20240121203818.2075381-1-jonas@kwiboo.se>
Date: Tue, 07 Jan 2025 15:23:26 +0100
Message-ID: <87bjwid7oh.fsf@baylibre.com>
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

Hi Jonas,

Thank you for the patch.

On dim., janv. 21, 2024 at 20:38, Jonas Karlman <jonas@kwiboo.se> wrote:

> Remove the rockchip,rk3399-dwc3 compatible from the dwc3-of-simple
> driver now that all boards have changed to use the dwc3-generic driver.
>
> Also remove the amlogic,meson-gxl-dwc3 compatible, it is no longer in
> use by any device tree in mainline linux or U-Boot.
>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>

Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>

> ---
>  drivers/usb/host/dwc3-of-simple.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/drivers/usb/host/dwc3-of-simple.c b/drivers/usb/host/dwc3-of-simple.c
> index f9df59d2e5d7..de1797d02ec0 100644
> --- a/drivers/usb/host/dwc3-of-simple.c
> +++ b/drivers/usb/host/dwc3-of-simple.c
> @@ -90,8 +90,6 @@ static int dwc3_of_simple_remove(struct udevice *dev)
>  }
>  
>  static const struct udevice_id dwc3_of_simple_ids[] = {
> -	{ .compatible = "amlogic,meson-gxl-dwc3" },
> -	{ .compatible = "rockchip,rk3399-dwc3" },
>  	{ .compatible = "ti,dwc3" },
>  	{ }
>  };
> -- 
> 2.43.0
