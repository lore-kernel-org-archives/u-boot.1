Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9037ED10F40
	for <u-boot@archiver.kernel.org>; Wed, 26 Nov 2025 13:02:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EE0A584201;
	Wed, 26 Nov 2025 14:02:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="GZjD+Ee1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 546A78309A; Wed, 26 Nov 2025 09:47:19 +0100 (CET)
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com
 [IPv6:2a00:1450:4864:20::229])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 581D082B20
 for <u-boot@lists.denx.de>; Wed, 26 Nov 2025 09:47:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=promsoft@gmail.com
Received: by mail-lj1-x229.google.com with SMTP id
 38308e7fff4ca-37d13ddaa6aso2859291fa.1
 for <u-boot@lists.denx.de>; Wed, 26 Nov 2025 00:47:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1764146836; x=1764751636; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=L5YA3UE18LgS+454W1TTeTziH1BetbqYuK4EzyjRXDE=;
 b=GZjD+Ee1DbUr1NRLwdi6kKU5v1PgQSjECkxyIBiAuSOXbTqqbCjtiqy1uRV5B80KY8
 Ifty69/fJC8ihX3PRLQvCa2Dgy4mVHDye/VY8TrLI5uwCO7rlN3hPMDn6ICjZCDDm8UI
 +GNLXm6Qru4hVblq6lPu+EIIxkRfdspeDixX8xULZK7XT4pMQq8usgERjVJIcCjZy70+
 hvcjNJnLk/As2ll0sI7lp/UHf8D79SrwegTTogyHSRxSG0rbRbu03MfpG646lZEnLASN
 fre3qfX5O2J8x1OfK/HYJk6Ye6+HBZDV3RTEIhDSHeWONHbAI+W58LUO02SsX754bxG+
 UhEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764146836; x=1764751636;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=L5YA3UE18LgS+454W1TTeTziH1BetbqYuK4EzyjRXDE=;
 b=Lr2yIefR0SvpRylDdsuxxfodzUsKK50g9x/ieAcJRA93EwQ7TB4wsAUJm3ceSzeOPC
 YtXrt5ZnRtx5q6UZeOJ/8PHICmIrAvxO8F/JwWDL/VsdKApmMHpCQbqN+JOFv4N0Et4+
 9N4NUDDk/0+Cj91H5eGZZFoGZ0yZoYCG2DTjXiHNuFq/oJJQGOMvqItkjGZIzXrcH9O/
 gGeixCFlUEiZCV86ebT+0ynAjWrntuEDJtiVI0XQWu/Qd4uAcd219J5rR35kJyDeh8xu
 qIO2GXHwwwgidhk1nofCnwUe4w5OyTCUty/Gi4H8zSf2DvTuA0G2bDhbU3HvrSnL20kr
 ZpGw==
X-Gm-Message-State: AOJu0YyGZWTk3wxMTZWjU5gciEbWDl2t/kac11lD205b+sbIEoqQfAba
 5ikTUnasojQ5G18GLzuyV3umhUVDzp6OxTapaRlPWBONCIa29rerHXh5ngX9A4m3NcI94DT0DRY
 2A8jMdrEQF/OUx2rJ//jMLx6n3zNm3pE=
X-Gm-Gg: ASbGncveBODUiAyR7rG0pROANzyK6GPUI1VeItwGizrkwdSJU0MdA8htrcvepajUNUj
 hYqxH2vRfPUpuwYqnNmaDDRKddeCxtdTp/Cv28Fk9w87rPipWA8W5V0Nvsw5Qx7dBS3vu8GyIg/
 vUaucCL+4XeofsHOvgcpz0ppSg+/RZo22+I1maqbLS8/UVW/CKEDCnqsJneX75eQkNfLfCEQHj1
 oF7gptnPHJRKtLZ76mdL9XMGnlO889PVVBiXHORRf2BMAHcxblkDAT+rqQc6tRSR81+l9Ueyn+5
 zKs7mrWEDjGZxfr9CS55aF4yf0Om
X-Google-Smtp-Source: AGHT+IFKJRZb60TojcOSCNfAj1sR16IODFdXUfR+RjTwU8I+hkqzJrSVHsezRlw6bEh52tto1MllKwkGJClstK1f9uY=
X-Received: by 2002:a2e:8a88:0:b0:37c:c370:60a3 with SMTP id
 38308e7fff4ca-37cd8ed21c0mr52131671fa.0.1764146836291; Wed, 26 Nov 2025
 00:47:16 -0800 (PST)
MIME-Version: 1.0
References: <20251017-pinctrl-exynos7870-v1-0-beaa92f95a0c@disroot.org>
In-Reply-To: <20251017-pinctrl-exynos7870-v1-0-beaa92f95a0c@disroot.org>
From: Minkyu Kang <promsoft@gmail.com>
Date: Wed, 26 Nov 2025 17:47:03 +0900
X-Gm-Features: AWmQ_bkR3fguCsn6eW2yGuKUnVf7cTfI0GKvrMTu678O4xBFBUidmHECNTsieyk
Message-ID: <CALrBrZ2_h6c2T9D2wh2uxRiyvREJAwc5roeFYgc7YPFaiEynfA@mail.gmail.com>
Subject: Re: [PATCH 0/2] Support for Samsung Exynos 7870 pin controllers in
 driver
To: Kaustabh Chakraborty <kauschluss@disroot.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>, 
 Sam Protsenko <semen.protsenko@linaro.org>,
 Henrik Grimler <henrik@grimler.se>, Minkyu Kang <mk7.kang@samsung.com>
X-Mailman-Approved-At: Wed, 26 Nov 2025 14:01:59 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

Hi,


2025=EB=85=84 10=EC=9B=94 18=EC=9D=BC (=ED=86=A0) 01:02, Kaustabh Chakrabor=
ty <kauschluss@disroot.org>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:

> This patch series aims to add support for the Exynos 7870 pin
> controllers. Along with that, it also introduces a way to bind the GPIO
> driver along with it, as in devicetree both reside in the same node.
>
> Signed-off-by: Kaustabh Chakraborty <kauschluss@disroot.org>
> ---
> Kaustabh Chakraborty (2):
>       pinctrl: exynos: bind GPIO driver along with pinctrl
>       pinctrl: exynos78x0: add proper support for exynos7870 pinctrl
>
>  drivers/pinctrl/exynos/pinctrl-exynos.c     | 11 ++++++
>  drivers/pinctrl/exynos/pinctrl-exynos.h     |  1 +
>  drivers/pinctrl/exynos/pinctrl-exynos7420.c |  1 +
>  drivers/pinctrl/exynos/pinctrl-exynos78x0.c | 60
> +++++++++++++++++++++++++++++
>  drivers/pinctrl/exynos/pinctrl-exynos850.c  |  1 +
>  5 files changed, 74 insertions(+)
> ---
> base-commit: 582a04763aa80738c1c8ac60c47d1a5159a42833
> change-id: 20251014-pinctrl-exynos7870-761e0a2847a2
>
> Best regards,
> --
> Kaustabh Chakraborty <kauschluss@disroot.org>
>

applied to u-boot-samsung.

Thanks,
Minkyu Kang.

>
