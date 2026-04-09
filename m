Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E2C4EA3C57
	for <u-boot@archiver.kernel.org>; Thu,  9 Apr 2026 11:27:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E7595839D5;
	Thu,  9 Apr 2026 13:27:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="W2HqBzUG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C446F83D8A; Thu,  9 Apr 2026 13:27:52 +0200 (CEST)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com
 [IPv6:2a00:1450:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D503C83693
 for <u-boot@lists.denx.de>; Thu,  9 Apr 2026 13:27:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jstephan@baylibre.com
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-b97f9587e6eso107276566b.3
 for <u-boot@lists.denx.de>; Thu, 09 Apr 2026 04:27:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775734070; cv=none;
 d=google.com; s=arc-20240605;
 b=Kikdypk6IutAPNoGb+IhgNEwE7nH1qNr5rpilFK8UvOofJYcYIyb4iQXKx3KCWtoWb
 KIai2PNJHSgt0vBag7e22h4pN0bYToB461BzKOGz3QjVaKcHqJuWYnd1ingvGaHvvEhh
 LAWxdw/MJshlslKmUyPlmf6S1hW/q9m5RRazUULo4Fc1CYRJtiRE/3aC1z2UXzT5+e0E
 8wloo4pCDJdO0KfuFe20inU2o2r7ie5B/TWrRD394aVMxXxm+dpkNLdfGLE2XT+iRocK
 FoGIlSqqRfqxiDpu7UiqGaFTOvxdSt7NsYuuRT9HLT7a3KJBXtkUMDXoiATSM/je/PtN
 ynsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=OkgRWahIO/iHes0O735vkpacEvIDYD+FT1tAb2jRY8s=;
 fh=3APL3yAaRWDnTkQCt/YGAL0fA7ANeAbLgwJO2kblEUQ=;
 b=Q4sspf3a1DVT78ppwP3U8/KRv8QUd6TPCG1fR3YMPt28r8rOe12HK4TMAyc5AzJWC8
 jWKPC/diyVUcfLTLoNvY0g0Jwh4d86xXzxw3nbwotQWyzAffIKhmkpTCA5JR5zNs10bm
 ih9uX7X9hSxhs746SwNEpXlG+AuzwEtmGVJO/IQbiJBx0R1LUhdinhjecuY1GnR/WMR4
 v8nwQkVSw3tDVs/TLV5k7XpnXjvsXkIsLjRgxWFftcdS0d3iPAQUKFegejes5ZdFQMb8
 AfUhH7hp5KM6eHNthn2DotgtN06w21GVxtK62vSqU7QNcxhyuEh2vxDx0/eEAzJVA/Wt
 Y/MQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1775734070; x=1776338870;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OkgRWahIO/iHes0O735vkpacEvIDYD+FT1tAb2jRY8s=;
 b=W2HqBzUG4Zzf5/O2w5+2BhV69mNY6u15qe1GKzE09s+LHx318rdi7d8Nh5jeFM3qU6
 xhG1XfBOcdqLkm5k5LBol0+cGjn1ZQnD1uFsx61xVxCYvYGC47HcX+mqel4cJNYt1dZI
 wX15UbcpcXcYYYo48PL5EHB2P0awPhWsXblLj/8wohRQuv8jrh1ybNml8glGmXb4p/TR
 FwXgMkwSjiQw92nDufBkra1u+RBv8HSwHkbkt3nEccrpLE8DmEbJCxZQhyMjgHiNs8SP
 lYIH+3ohulAu3EW7C75K2D1S0RoZorm0Crr8ffpvBUF4SeyqE0HZ+BBDcPDEPxF6cMNB
 lr0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775734070; x=1776338870;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=OkgRWahIO/iHes0O735vkpacEvIDYD+FT1tAb2jRY8s=;
 b=otan9TbqoQBpHFRql7s/PuaMohpGqFcy5cSHYLekEMbsxNXlmc2uU1xkA9yIgjf5+9
 Cfspz21MRPeFWu2K1U4Tag1j4yNmQxhfBTaKKHwiKioRkEMeSEIyjqQWi4ki2Ql9jTBg
 zDiOnC4pw1+SB5TiBOq9AWn0lv0s+5p53q3xBtYL5nNF1ab/pco5/AJCpz6NB2OXfEcf
 QdL5iVhy+usdeVJzMp9uDQ7umt1YZNPT5Cj/LYFYysH4iclYUAFIctMpL5kJmx5dOgcR
 BjXoqovtmPDtEoI0ExZ8pI6cLadSkkvXnOaNqMSEJeg0hb5NQIU+XnBbxxrMW6sUH1ml
 J2sw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUZMFnXpbnrIuuN+6/Jx6WnVit0xjIhpqgyVTufWX5H4i5/N5c77DVlE27Lj4T1wNE6eGxUgCI=@lists.denx.de
X-Gm-Message-State: AOJu0Yy64BgvTz4ULuE4Pm68O98NrTv5tlb2srd9hYoQlzJhV7zcwytV
 so0IN6YPckotPWsBMVgS+tHa0CaN4yhsy8DXfYXMa3Xtumt/JHUk4UmWxVtHsKfVNkOeKZ0/Vxd
 kCdeXodgtQvML7YkUgJKT/vLVZyoUJs8WRMelPc/Qpg==
X-Gm-Gg: AeBDietVAaBS03T2Q8E5WJ1CPQCS3oItQwuzgbSTSzn3ZKaIdh4TXTGTW0pv6A5YzMr
 LFZJr0btPcajnuhkH2QeiJyrrEUi1WrW6dwg2D8mBz7kq58ekJMJJjT1rLNDCXSxKy8p/iivTI4
 EOvON5TJMZxsFsgkw8sX0u1VvQwm0xmpb0EIA+ocED3YrjG95xumG5D36HWb0aM/lRWIIkkoqza
 8OA6fdc9z09EEel7CThgA4V2f+DySq8lf1ee9+XGYhxYbHLq8xIZvNLzDPz/ECrAnc59qH8Qnus
 mBRDo9kCG78l1gEjcJpJPCcRkngFVKbV/zvHe74+T+e9Ud2ZdrYyhlwt+csPE6js1XJFWNnZgUs
 fIRWAYhO1pSX32SOlc5YnoI0yfw==
X-Received: by 2002:a17:906:9f91:b0:b97:cc05:61b9 with SMTP id
 a640c23a62f3a-b9c6764d9e8mr1366771266b.15.1775734070238; Thu, 09 Apr 2026
 04:27:50 -0700 (PDT)
MIME-Version: 1.0
References: <20260327-mtk-pmic-fixes-v1-0-ef874ca82409@baylibre.com>
 <20260327-mtk-pmic-fixes-v1-2-ef874ca82409@baylibre.com>
In-Reply-To: <20260327-mtk-pmic-fixes-v1-2-ef874ca82409@baylibre.com>
From: Julien Stephan <jstephan@baylibre.com>
Date: Thu, 9 Apr 2026 13:27:47 +0200
X-Gm-Features: AQROBzB9tC_73gMHxUs76Qcd57cArgR4PHP7qrexG5tDZ3_4VPGP5iJRS5j0qCQ
Message-ID: <CAEHHSvbZ-BpuBm2KOjz18ihzQsz6cRSnusM7Rv_YPWXuLePVPw@mail.gmail.com>
Subject: Re: [PATCH 2/3] power: pmic: mtk-pwrap: add PWRAP_CAP_WDT_SRC flag
To: David Lechner <dlechner@baylibre.com>
Cc: Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>,
 Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
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

Le ven. 27 mars 2026 =C3=A0 20:03, David Lechner <dlechner@baylibre.com> a =
=C3=A9crit :
>
> Add a PWRAP_CAP_WDT_SRC flag to indicate if a PMIC wrapper has a WDT_SRC
> or not. Then use this to conditionally enable the watchdog timer.
>
> Prior to this change, since the register was not defined, it defaulted
> to 0, so the wrong register (DONE2) was being written to.
>
> Signed-off-by: David Lechner <dlechner@baylibre.com>
> ---
>  drivers/power/pmic/mtk-pwrap.c | 12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/power/pmic/mtk-pwrap.c b/drivers/power/pmic/mtk-pwra=
p.c
> index 9ff06fdb3bd..d8498646921 100644
> --- a/drivers/power/pmic/mtk-pwrap.c
> +++ b/drivers/power/pmic/mtk-pwrap.c
> @@ -60,10 +60,11 @@ static const struct pmic_child_info mt6359_pmic_child=
ren_info[] =3D {
>
>  /* Group of bits used for shown pwrap capability */
>  #define PWRAP_CAP_INT1_EN              BIT(3)
> -#define PWRAP_CAP_WDT_SRC1             BIT(4)
> -#define PWRAP_CAP_ARB                  BIT(5)
> +#define PWRAP_CAP_WDT_SRC              BIT(4)
> +#define PWRAP_CAP_WDT_SRC1             BIT(5)
> +#define PWRAP_CAP_ARB                  BIT(6)
>  /* To implement this capability, the registers used in pwrap_init() must=
 be defined. */
> -#define PWRAP_CAP_INIT                 BIT(6)
> +#define PWRAP_CAP_INIT                 BIT(7)

can you reorder patch 1 and 2 to avoid modifying PWRAP_CAP_INIT twice ?

>
>  /* defines for slave device wrapper registers */
>  enum dew_regs {
> @@ -780,7 +781,8 @@ static int mtk_pwrap_probe(struct udevice *dev)
>          * Since STAUPD was not used on mt8173 platform,
>          * so STAUPD of WDT_SRC which should be turned off
>          */
> -       pwrap_writel(wrp, wrp->master->wdt_src, PWRAP_WDT_SRC_EN);
> +       if (HAS_CAP(wrp->master->caps, PWRAP_CAP_WDT_SRC))
> +               pwrap_writel(wrp, wrp->master->wdt_src, PWRAP_WDT_SRC_EN)=
;
>
>         if (HAS_CAP(wrp->master->caps, PWRAP_CAP_WDT_SRC1))
>                 pwrap_writel(wrp, wrp->master->wdt_src, PWRAP_WDT_SRC_EN_=
1);
> @@ -912,7 +914,7 @@ static const struct pmic_wrapper_type pwrap_mt8365 =
=3D {
>         .int1_en_all =3D 0x0,
>         .spi_w =3D PWRAP_MAN_CMD_SPI_WRITE,
>         .wdt_src =3D PWRAP_WDT_SRC_MASK_ALL,
> -       .caps =3D PWRAP_CAP_INT1_EN | PWRAP_CAP_WDT_SRC1 | PWRAP_CAP_INIT=
,
> +       .caps =3D PWRAP_CAP_INT1_EN | PWRAP_CAP_WDT_SRC | PWRAP_CAP_WDT_S=
RC1 | PWRAP_CAP_INIT,
>  };
>
>  static const struct udevice_id mtk_pwrap_ids[] =3D {
>
> --
> 2.43.0
>
