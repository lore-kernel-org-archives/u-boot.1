Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46B2EC83F25
	for <u-boot@archiver.kernel.org>; Mon, 21 Jul 2025 20:39:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A9BC183214;
	Mon, 21 Jul 2025 22:39:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="h7TVSR/v";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3CC0783214; Mon, 21 Jul 2025 22:39:08 +0200 (CEST)
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com
 [IPv6:2607:f8b0:4864:20::b32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D1AE6830EA
 for <u-boot@lists.denx.de>; Mon, 21 Jul 2025 22:39:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-yb1-xb32.google.com with SMTP id
 3f1490d57ef6-e8db917573dso116657276.1
 for <u-boot@lists.denx.de>; Mon, 21 Jul 2025 13:39:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753130344; x=1753735144; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pm0nNxXHMBFIKbpriw3+J+gEsBdn9IvvSa51s+jlD6o=;
 b=h7TVSR/vV6zqEjg15dGWJ3FR6hEvOsAJSDYqK8rxay0OgIDoy2Uf0qOkweHM7QbCvM
 q2J8OBnQLA1nZ0Lfy/xE5wi50GN52pnPeH2ysdZhyRtJtBeaIaxn7UPLXDZkzjvCSwrH
 67WfFgDPI310YUnwNZ11p9RmsGZ6hVMzLixB7Fhwu9yGrIkd0osMppiDCft1LuQULuob
 XMToLxHx0F5HRUvjIIQClZq0iUZgINZKlgzlg/UnGfEIwAZJIm9/NO8lS3vvmyhhd1Yk
 qBwb0cV/mBAoBp4iiAdyI+Kj3hpKfATI5A9MSrjBBun0+caj9YfPA58Fc4jmkAYPVSpc
 KL7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753130344; x=1753735144;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pm0nNxXHMBFIKbpriw3+J+gEsBdn9IvvSa51s+jlD6o=;
 b=Low6paATlB/geWJigPHX9z6iQsYUgFxdXJxvPsXFFfqyyRkToh5GUM6/m8U21Dw9xH
 m5tFsVSEoaTBUyO26nLVJvT34ZtJf5TXZU4KlNgc3J9xuA4n7bW0HykjLLSmgUVDu1zD
 az0l89t9zqhLxJhavlyqOH+5o60vNkSOXSmCd4bEHuSq5XDoZ0eZog69Jn1MhYijGI+s
 k2g9PU6KV9hJMFG57uZkEwL3NQ6SZRtmpr90iQU14tmltgIctWDIcQH5pIFRMVuqMG7k
 pfCV/abGlHw5MJUokEFurDY0pgc7vbg2Q5lqj+w07z5cBT622PR3mvW8DWomenelCEpd
 pQow==
X-Forwarded-Encrypted: i=1;
 AJvYcCUjfn4BBPmsjnuOypt0K7PEWGnSDRkJxwzrYUYDbjv3wVMZO9nVIUcbX+jhLjBdkERp+5lVRdY=@lists.denx.de
X-Gm-Message-State: AOJu0Yw1PjzYHotxsY33vTrmllgVqP+leDMxt6800Vp2IyaXD4B5aKMk
 hPzHuZNUQZQBlQBdE9AkflDrVaocWKklNdIPO6CFJgqgZmMcKQSFP0U6PkQ94j56lZTr3Q9T4EU
 kJoKDm0ckAhVis7N3DYN9Pxth2APZeAt7hlDggXnPVw==
X-Gm-Gg: ASbGnctjoPN+EsLCcqTp7x4A4+ERDghXTzrheCM3RlDLjZ2CBCOH0h7qXTzd/uJejpE
 E+RGnCYkrU8eBHMdf1cR8F1U0aA5Zohi/bfzUIWibwVaNt96M6Knwff1VycLo+jS3nRR0QvpjLK
 8X2puMmchz0XULXANJvKsqbD/rOf+ZgHSKEp4vxLOjlosdzHiig4BimRpcO9INhQSgtcbu6klZj
 Z9LRF6I3zefruuuwQ==
X-Google-Smtp-Source: AGHT+IEwVMM147RusOzCcH0LxNqd6PaX3v1++iMpIS0lZwbVU4ryn2z28ojSBakRhElEY+q0x8eodx18C5dUQGGyVTE=
X-Received: by 2002:a05:690c:6007:b0:719:586d:dd11 with SMTP id
 00721157ae682-719586deae1mr152385937b3.21.1753130344525; Mon, 21 Jul 2025
 13:39:04 -0700 (PDT)
MIME-Version: 1.0
References: <20250720-samsung-mmc-fixes-v1-0-cb705abfa594@grimler.se>
 <20250720-samsung-mmc-fixes-v1-3-cb705abfa594@grimler.se>
In-Reply-To: <20250720-samsung-mmc-fixes-v1-3-cb705abfa594@grimler.se>
From: Sam Protsenko <semen.protsenko@linaro.org>
Date: Mon, 21 Jul 2025 15:38:53 -0500
X-Gm-Features: Ac12FXyw9vurWVQQ5wZiCtd1AD-4wVKJlrELGOWznRn1i0uQZ3FUy8Y9zS8aWqw
Message-ID: <CAPLW+4mreJS4UDebSUH_TXy-9PLHLFZuCFyQQ=auetOQOwVfpA@mail.gmail.com>
Subject: Re: [PATCH 3/3] mmc: exynos_dw_mmc: add exynos5420 compatibles
To: Henrik Grimler <henrik@grimler.se>
Cc: Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>, 
 David Virag <virag.david003@gmail.com>, Minkyu Kang <mk7.kang@samsung.com>, 
 Tom Rini <trini@konsulko.com>, ~postmarketos/upstreaming@lists.sr.ht, 
 replicant@osuosl.org, u-boot@lists.denx.de
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

On Sun, Jul 20, 2025 at 12:00=E2=80=AFPM Henrik Grimler <henrik@grimler.se>=
 wrote:
>
> From: Jaehoon Chung <jh80.chung@samsung.com>
>
> The exynos5420 DTSes in linux kernel uses the compatibles
> samsung,exynos5420-dw-mshc{,-smu} instead of just
> samsung,exynos-dwmmc. Match the additional compatibles in the driver
> to make it possible to use it with DTSes from Linux kernel.
>
> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
> [ grimler: rebase after clksel reg abstraction and re-write commit messag=
e ]
> Signed-off-by: Henrik Grimler <henrik@grimler.se>
> ---

Reviewed-by: Sam Protsenko <semen.protsenko@linaro.org>

>  drivers/mmc/exynos_dw_mmc.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/drivers/mmc/exynos_dw_mmc.c b/drivers/mmc/exynos_dw_mmc.c
> index c8bf89d6d3552c1e0ebcaccc48a08087cbf3f596..12e37cb4b7884c5cdac030324=
5c93988d034459a 100644
> --- a/drivers/mmc/exynos_dw_mmc.c
> +++ b/drivers/mmc/exynos_dw_mmc.c
> @@ -372,6 +372,12 @@ static const struct udevice_id exynos_dwmmc_ids[] =
=3D {
>         {
>                 .compatible     =3D "samsung,exynos4412-dw-mshc",
>                 .data           =3D (ulong)&exynos4_drv_data,
> +       }, {
> +               .compatible     =3D "samsung,exynos5420-dw-mshc-smu",
> +               .data           =3D (ulong)&exynos5_drv_data,
> +       }, {
> +               .compatible     =3D "samsung,exynos5420-dw-mshc",
> +               .data           =3D (ulong)&exynos5_drv_data,
>         }, {
>                 .compatible     =3D "samsung,exynos-dwmmc",
>                 .data           =3D (ulong)&exynos5_drv_data,
>
> --
> 2.50.1
>
