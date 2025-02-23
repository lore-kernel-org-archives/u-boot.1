Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9367C021B2
	for <u-boot@archiver.kernel.org>; Sun, 23 Feb 2025 12:45:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0BF6280F67;
	Sun, 23 Feb 2025 13:45:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="e0zLd1fR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D642280FB6; Sun, 23 Feb 2025 13:44:58 +0100 (CET)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B0CA280F56
 for <u-boot@lists.denx.de>; Sun, 23 Feb 2025 13:44:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4399a1eada3so31011215e9.2
 for <u-boot@lists.denx.de>; Sun, 23 Feb 2025 04:44:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1740314696; x=1740919496; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fIpG476gFgxkQUXJbLJeGZ8a/c9BZar43/VrfJLi6jI=;
 b=e0zLd1fRhDFHd+46NvMgK7j7YI1OuXNch06490i8tYEfWj2OckDP4iuOfj9cMOK+JL
 S/8ERaOj8khPV6AgawYVLfmzdcW3E1Ojme34wP8ScIYmWpFMKEMsbgruiGNdnMeKdAbl
 3p3xgfoC10YPeLdydZ1FHQP5QxD/JjuC4rvPiCEcboncW4hU6HmLsuWgCmZl3viAdRR0
 uNbdSByW4Uv9x9RZN7OORriDW/2kuyOYf+OGKU3/bnatqwrUG0ZgFrD44iNqEPfoKpkT
 aSUppdtjGkh/77jWLgj6dQEEs+TGfCZJfu+nAG/1/R6KuNNrlQV/iEYW0Lg+1Vxp4ykE
 1OUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740314696; x=1740919496;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fIpG476gFgxkQUXJbLJeGZ8a/c9BZar43/VrfJLi6jI=;
 b=hM4mbtMD2WaaV0FAG8Kx3iz9KmqBzuh0k4dcEPRaoKcnqQPLYmbIsfTaaAQ+fp1GlO
 Gpij+DPE3TSG1g0Kwxdepl+UWECOoabTJAqdI48kx9Fcy24SqHRbm/xVjw0Dw4vU2beI
 OnxEY1lTD0HC0Z4gS9cvOW7sWyDZ4I8losxdEZBSlb20wVYyJ0+ctDKtyKGOlwseSF3a
 VShguo2F/Duanv923ukURu5Cxr/U04HrWhIMNiceynJmmF4aPX56ovC9QLnduYEejUcW
 nu5QdEBPmByyun4Sxhkyd6Uy2lErtVgZ981r5gFBkWIYqd9XaEjZ+aI9CGKKmGdQRpfk
 ThJQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW6/od+8Lvagkv0rwxUA+xj5dS+OmV1vf96OP5MGbLZDSMSyse/KFYx8lOLkkM8fajQHFX7X4Y=@lists.denx.de
X-Gm-Message-State: AOJu0YyhN9RzjlHihtAMtPfFy8idn3cOh3o9pdW4J9YfcXAFcNr/Gv3I
 6hizNE4hnexyBCBXmQf+Vfzytr41/JRa13oj4AFcJ7iI49VXKg7mf9cw4Tn7nfvW8jMs1f2XPp8
 mp4/QtcyER57rVcsGAJZL/gLQXGFzlKfz
X-Gm-Gg: ASbGnctt8p9BG3PSGkaStzBZ4Hx5NawwH5hLlBOHqlHkZztOEp7fzHuEe/vsKmxA1UT
 oUx/kxfBEo2reRYj1nwqRjg613jtSjVEb+2waJBAeDwAAkK7teVZ+aV9294YW7Tg1uvCX7nrYYz
 iCgRrJwYAX
X-Google-Smtp-Source: AGHT+IGClqYYb4OcHglDL2otDJ+nU32D3jRxZoYV7AaDI1qLHcEZD3zuaAGAWc8+qpbe1l2OjcOAqjBF1KEwnFw2vDQ=
X-Received: by 2002:a05:6000:144f:b0:38d:bec9:c8d with SMTP id
 ffacd0b85a97d-38f6f0c6be9mr9667159f8f.53.1740314696082; Sun, 23 Feb 2025
 04:44:56 -0800 (PST)
MIME-Version: 1.0
References: <20250223-vop2-pt2-v2-0-71350e482970@riseup.net>
 <20250223-vop2-pt2-v2-1-71350e482970@riseup.net>
In-Reply-To: <20250223-vop2-pt2-v2-1-71350e482970@riseup.net>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Sun, 23 Feb 2025 14:44:44 +0200
X-Gm-Features: AWEUYZkjnjcyjKY1pBswwdmJ75MT4EyQT5_fgKNsGKdAaeAK40dyM7CQ1Zjuusk
Message-ID: <CAPVz0n3MTP7-KrUw3Mz_KiTbDWdT-vi+uRAoK27N4NzW4yWJ8A@mail.gmail.com>
Subject: Re: [PATCH v2 01/11] video: rockchip: dw-mipi-dsi: Depend on
 CONFIG_VIDEO_BRIDGE
To: Dang Huynh <danct12@riseup.net>
Cc: Anatolij Gustschin <agust@denx.de>, Simon Glass <sjg@chromium.org>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>, Tom Rini <trini@konsulko.com>,
 Nicolas Frattaroli <frattaroli.nicolas@gmail.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Ondrej Jirman <megi@xff.cz>,
 Dragan Simic <dsimic@manjaro.org>, u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

=D0=BD=D0=B4, 23 =D0=BB=D1=8E=D1=82. 2025=E2=80=AF=D1=80. =D0=BE 14:13 Dang=
 Huynh <danct12@riseup.net> =D0=BF=D0=B8=D1=88=D0=B5:
>
> The driver is in video bridge class, so we must depend on it or
> the driver will fail to init.
>
> Signed-off-by: Dang Huynh <danct12@riseup.net>
> ---
>  drivers/video/rockchip/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/video/rockchip/Kconfig b/drivers/video/rockchip/Kcon=
fig
> index 01804dcb1cc8743e738d32540bea6c8539e51ab4..72fcd6715a69e522f2ba6e8de=
9c1a923106ca10f 100644
> --- a/drivers/video/rockchip/Kconfig
> +++ b/drivers/video/rockchip/Kconfig
> @@ -71,7 +71,7 @@ config DISPLAY_ROCKCHIP_MIPI
>
>  config DISPLAY_ROCKCHIP_DW_MIPI
>         bool "Rockchip Designware MIPI"
> -       depends on VIDEO_ROCKCHIP
> +       depends on VIDEO_ROCKCHIP && VIDEO_BRIDGE
>         select VIDEO_DW_MIPI_DSI
>         help
>           Select the Designware MIPI DSI controller in use on some Rockch=
ip
>
> --
> 2.48.1
>

LGTM, not sure if this matters though.
Reviewed-by: Svyatoslav Ryhel <clamor95@gmail.com>
