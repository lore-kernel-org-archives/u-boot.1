Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52AD4D10F40
	for <u-boot@archiver.kernel.org>; Wed, 26 Nov 2025 13:03:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 336B484223;
	Wed, 26 Nov 2025 14:02:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="aGhrGkKG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8C39F832AD; Wed, 26 Nov 2025 09:52:26 +0100 (CET)
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com
 [IPv6:2a00:1450:4864:20::22a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 308DA830CA
 for <u-boot@lists.denx.de>; Wed, 26 Nov 2025 09:52:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=promsoft@gmail.com
Received: by mail-lj1-x22a.google.com with SMTP id
 38308e7fff4ca-37b99da107cso57771541fa.1
 for <u-boot@lists.denx.de>; Wed, 26 Nov 2025 00:52:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1764147143; x=1764751943; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=j/jmDuPb2ZoXfMl0oanEubZVlnzqvNTCJCiPocpUfz0=;
 b=aGhrGkKGCzkb9uAXP5bimSJR546dCUri/jf05pBh1h4rm2KvnG80YTscqAUQXVWORt
 kBe9oKpkBMEHXdEXBhNtrzCRBzkabXdn/0AYQ/cICKOvWE7xXJ2NiAzXNa0Mnadv6hzV
 JXrQdjcBVAqvS/74Z4LL5Ih+nv/w8cGf7yWCyPqAZIvvjYqre9rkKAce4yi6a7fe7ta4
 ObWHmAHktQIGkWt3bgqoofUuiTFxDLQZHZdd1N0ztJPLdeckLnXH791ET0VBnnRkY95J
 7zuxlm7ghslvYA8BV2xFh1b56bl21gxYmJJ97yW0PRmYrno1zpfZwd8Fj2WiOtnQ0Cz7
 IrUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764147143; x=1764751943;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=j/jmDuPb2ZoXfMl0oanEubZVlnzqvNTCJCiPocpUfz0=;
 b=qFF9Y3b/qldjsyx5C3NSO5vyzMzQdni0DhEwUN1Da20ZYXlShxUy7mwHM3wM32X8oQ
 IcplqIN9E3rduzY7azRus3ZzoDVUhVD/TVhfGF1ntCmvdVq7BzfPoVIhTYkPyAzpSwXK
 oCmCkIEotuo04ihDhEXMoQ77RZ6GbMkHPE1ESJIOEi5Ptv7us9XV6VZaYYlwtkwsbpBr
 /Hq3569GzuzuttMbnvLFp1Ja6dlriznAeQsmpp/4vWlgDQVidShDjB3x10s3K4MHkKBW
 8FQnQqhVl+7xvOqbxz4qgJaKYnMVpifF2Cwr2y5b5yJvdbCei1f3N3e+wnDTO/FQiV4g
 esGw==
X-Gm-Message-State: AOJu0YwsR22HJIyuFcAL98hbz1icIq9KXdh4lRLpdqkhfWqcSjlYnS2M
 oDtyLz4tf0BJoOQzwYl5PyZUn9DjWwGFfRkxBrjnw2tcqHEa1waREn958Lq5QS3T/PmZ4M8TIOv
 eF/lvqzML+uUqUGJrgqsxSrYJLCMy6/w=
X-Gm-Gg: ASbGnct2TFwaHuoamlvzceTg0UZkELh09QNeGRGRTnpZqCrtbD4USijaigDgfnmqafm
 JMYQLOSDpk+ayLzWcRfdrQAdrAMpAFdw6zJlp2GSCutBS0L47DLy7SsgYrtVYU01fpr1ybEcxNC
 Nh3fRQI47cAe/5zFl+P0bRw1/cyDuyeni8ibXhUPw/0WSEpN/SIFzo0UfaRmArW2E7GMgLZ779N
 isfGrTV8PRZFKoH+E6n7aetPSqdKl8b2rohuudUiT1Iv+70cZ9j6RRNmRDGTXzS5PjXafo2abjQ
 A8R1B9MwQ76F2XvCgzMR7bEVCMZc
X-Google-Smtp-Source: AGHT+IFH6mUQcZOA27m7SAtE8IT/HvYO3FQabuk5zkIT3UUGSOOp2kegkdptrHvqKUQRVgffqek+PSTUMrUFhxtNmBQ=
X-Received: by 2002:a2e:98d5:0:b0:378:e8d1:117 with SMTP id
 38308e7fff4ca-37cd919c3d6mr40959401fa.11.1764147143135; Wed, 26 Nov 2025
 00:52:23 -0800 (PST)
MIME-Version: 1.0
References: <20251021-gpio-s5p-bank-fix-v2-1-eae4b37e7e73@disroot.org>
In-Reply-To: <20251021-gpio-s5p-bank-fix-v2-1-eae4b37e7e73@disroot.org>
From: Minkyu Kang <promsoft@gmail.com>
Date: Wed, 26 Nov 2025 17:52:10 +0900
X-Gm-Features: AWmQ_bl6eDhyfsax5r15iL-fPQt1loH1_G0U37h0-lTL18lvF-ECZM84TI0mU3g
Message-ID: <CALrBrZ0CBUOrURtwUcncgzgPiyafxUYFWhmb9-CYMn5v2N+NnA@mail.gmail.com>
Subject: Re: [PATCH v2] gpio: s5p: increment bank base address only if bank is
 initialized
To: Kaustabh Chakraborty <kauschluss@disroot.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>, 
 Henrik Grimler <henrik@grimler.se>
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


2025=EB=85=84 10=EC=9B=94 21=EC=9D=BC (=ED=99=94) 23:24, Kaustabh Chakrabor=
ty <kauschluss@disroot.org>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:

> There is a condition guard which ensures that the GPIO node, indeed
> describes a GPIO controller.
>
>         if (!fdtdec_get_bool(blob, node, "gpio-controller"))
>                 continue;
>
> Since the bank base is being incremented in the loop, it is done so
> irrespective of whether the node is a GPIO controller or not. This leads
> to the incorrect resolution of bank base addresses.
>
> Move it out of the loop, and instead increment the bank base address
> only if the driver successfully binds a GPIO controller.
>
> Reviewed-by: Henrik Grimler <henrik@grimler.se>
> Fixes: b8809e60cdb5 ("dm: exynos: gpio: Convert to driver model")
> Signed-off-by: Kaustabh Chakraborty <kauschluss@disroot.org>
> ---
> Changes in v2:
> - collect Reviewed-by: tags
> - add Fixes: tag (Henrik Grimler)
> - Link to v1:
> https://lore.kernel.org/r/20251017-gpio-s5p-bank-fix-v1-1-41050462cea5@di=
sroot.org
> ---
>  drivers/gpio/s5p_gpio.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpio/s5p_gpio.c b/drivers/gpio/s5p_gpio.c
> index
> 53dbbe97b5a02d09fbf0124268faaffa31b1315f..c072f146514c63cdc98e907983a904f=
05cd118e7
> 100644
> --- a/drivers/gpio/s5p_gpio.c
> +++ b/drivers/gpio/s5p_gpio.c
> @@ -319,7 +319,7 @@ static int gpio_exynos_bind(struct udevice *parent)
>         base =3D dev_read_addr_ptr(parent);
>         for (node =3D fdt_first_subnode(blob, dev_of_offset(parent)), ban=
k =3D
> base;
>              node > 0;
> -            node =3D fdt_next_subnode(blob, node), bank++) {
> +            node =3D fdt_next_subnode(blob, node)) {
>                 struct exynos_gpio_plat *plat;
>                 struct udevice *dev;
>                 fdt_addr_t reg;
> @@ -341,9 +341,8 @@ static int gpio_exynos_bind(struct udevice *parent)
>                 if (reg !=3D FDT_ADDR_T_NONE)
>                         bank =3D (struct s5p_gpio_bank *)((ulong)base + r=
eg);
>
> -               plat->bank =3D bank;
> -
>                 debug("dev at %p: %s\n", bank, plat->bank_name);
> +               plat->bank =3D bank++;
>         }
>
>         return 0;
>
> ---
> base-commit: 582a04763aa80738c1c8ac60c47d1a5159a42833
> change-id: 20251014-gpio-s5p-bank-fix-1d008cb2a1a9
>
> Best regards,
> --
> Kaustabh Chakraborty <kauschluss@disroot.org>
>

applied to u-boot-samsung.

Thanks,
Minkyu Kang.

>
>
