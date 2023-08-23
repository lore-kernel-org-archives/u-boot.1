Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28FB1EE49AE
	for <u-boot@archiver.kernel.org>; Wed, 23 Aug 2023 08:06:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 61313864BA;
	Wed, 23 Aug 2023 10:06:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20221208.gappssmtp.com header.i=@baylibre-com.20221208.gappssmtp.com header.b="Rsmww5d2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0FDEC8640E; Wed, 23 Aug 2023 10:06:31 +0200 (CEST)
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com
 [IPv6:2a00:1450:4864:20::42e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B7347864C4
 for <u-boot@lists.denx.de>; Wed, 23 Aug 2023 10:06:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-31aec0a1a8bso2427576f8f.0
 for <u-boot@lists.denx.de>; Wed, 23 Aug 2023 01:06:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1692777988; x=1693382788; 
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=IzuVC2xkFrFhrTu6k0mlgiYttCjJDkUkdfrlgWAlhiY=;
 b=Rsmww5d2lhCU17sLZL/Q5ziUU/zSu+SHP6pYFaCDA+P5viopNVvriUiV//WXXmCTLd
 NcWnkKASA4URu/X8vGVEX5QV28O9hkRhBLDF85GeeoZLuchUfFYgPt35ap6LE1vh6GNR
 ticbi64CmyiBT8aOCmem4yYk8uVH5/+EIXOmdWTL+rW2V2Te7jT+6W6l+F5FocfqRfE4
 3CByKl08P5Zcx4YWXlHyQsCtjsY9pW6oB6OyPxEFIGRhohlLJtLKaiOGMk5UkKgd+cUS
 kSx/NN1Np0PAUe4ufLDpNgrKo/i5KowxdeHBefiTKmAgs/AMeNHxfhlmQcch3Qbpq3rm
 MT2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692777988; x=1693382788;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IzuVC2xkFrFhrTu6k0mlgiYttCjJDkUkdfrlgWAlhiY=;
 b=TdBP/l2g5ct2D8PJnx8nhvHcJTYPd/VrmpAvyZMMZ3pW6rDNe++FYjNJWeHJ/qz47P
 skN8RmwJTgAey7KYsbAUa8aiK3nXT1fkfvcUkExGr6pZqpx2mca6041fEAw/AGOsL7NT
 puGnopmbSoz+pUzqoF64H2Q6/wgKrWfpBI2qLMClZs425TxNhptcM9lfpmxAN2VBjXrT
 7rMr4eqXYGqvdK013zmjUp1tAf5PmUw7MryAtpcZV0P5Pw0cHj9xqS/uJSNyui/KEDxn
 TJAUDjdbLlYl6HwrX94Mn/ZPvjn7mTxTNw6VroeqOV1fsWSCkR2/l3PkqEGCQ6KYT/Ij
 dv9Q==
X-Gm-Message-State: AOJu0YwT00Uw6H0w+jR0e0Z8iW2+biTLTIuGVSAtHU4LDKINYqktikJy
 SRi54c9i/lCVWNT5b6fKujw/YPXZkLl/D8SJdf0=
X-Google-Smtp-Source: AGHT+IEwIOcWgDPemW4Z1cTDPiAfvwooSjzpXQWbyMIcgHM2qPEBbX9a9pUxSG5mDlHlVoLQCVfKpw==
X-Received: by 2002:a5d:498e:0:b0:31a:e3df:f719 with SMTP id
 r14-20020a5d498e000000b0031ae3dff719mr8754866wrq.17.1692777988138; 
 Wed, 23 Aug 2023 01:06:28 -0700 (PDT)
Received: from localhost ([2a01:cb19:8704:be00:4f55:bd9d:611a:6c8e])
 by smtp.gmail.com with ESMTPSA id
 o17-20020a05600c379100b003fe26244858sm16661299wmr.46.2023.08.23.01.06.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Aug 2023 01:06:27 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Nishanth Menon <nm@ti.com>, Neha Francis <n-francis@ti.com>, Tom Rini
 <trini@konsulko.com>
Cc: Bryan <bb@ti.com>, Praneeth <praneeth@ti.com>, Andrew <afd@ti.com>, Robert
 Nelson <robertcnelson@gmail.com>, Vignesh <vigneshr@ti.com>,
 u-boot@lists.denx.de, Jan
 Kiszka <jan.kiszka@siemens.com>, Nitin Yadav <n-yadav@ti.com>, Nishanth
 Menon <nm@ti.com>
Subject: Re: [PATCH V4 4/8] drivers: mmc: am654_sdhci: Update OTAP/ITAP delay
In-Reply-To: <20230822184135.2328409-5-nm@ti.com>
References: <20230822184135.2328409-1-nm@ti.com>
 <20230822184135.2328409-5-nm@ti.com>
Date: Wed, 23 Aug 2023 10:06:27 +0200
Message-ID: <87r0nufaik.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
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

On mar., ao=C3=BBt 22, 2023 at 13:41, Nishanth Menon <nm@ti.com> wrote:

> From: Nitin Yadav <n-yadav@ti.com>
>
> U-Boot is fail to boot class U1 UHS SD cards (such as microcenter)
> due to incorrect OTAP and ITAP delay select values. Update OTAP and
> ITAP delay select values based on recommeded RIOT values to fix boot
> issue.

nitpick: recommeded -> recommended

>
> Signed-off-by: Nitin Yadav <n-yadav@ti.com>
> Signed-off-by: Nishanth Menon <nm@ti.com>
> ---
> Picked up from TI u-boot
> New patch in the series
>
>  drivers/mmc/am654_sdhci.c | 14 ++++++++++----
>  1 file changed, 10 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/mmc/am654_sdhci.c b/drivers/mmc/am654_sdhci.c
> index fd667aeafdaa..d0b51c0707d4 100644
> --- a/drivers/mmc/am654_sdhci.c
> +++ b/drivers/mmc/am654_sdhci.c
> @@ -442,12 +442,18 @@ static int j721e_4bit_sdhci_set_ios_post(struct sdh=
ci_host *host)
>  {
>  	struct udevice *dev =3D host->mmc->dev;
>  	struct am654_sdhci_plat *plat =3D dev_get_plat(dev);
> -	u32 otap_del_sel, mask, val;
> +	u32 otap_del_sel, itap_del_sel, mask, val;
>=20=20
>  	otap_del_sel =3D plat->otap_del_sel[host->mmc->selected_mode];
> -	mask =3D OTAPDLYENA_MASK | OTAPDLYSEL_MASK;
> -	val =3D (1 << OTAPDLYENA_SHIFT) | (otap_del_sel << OTAPDLYSEL_SHIFT);
> +	itap_del_sel =3D plat->itap_del_sel[host->mmc->selected_mode];
> +	mask =3D OTAPDLYENA_MASK | OTAPDLYSEL_MASK | ITAPDLYSEL_MASK |
> +		ITAPDLYENA_MASK;
> +	val =3D (1 << OTAPDLYENA_SHIFT) | (otap_del_sel << OTAPDLYSEL_SHIFT) |
> +		(1 << ITAPDLYENA_SHIFT) | (itap_del_sel << ITAPDLYSEL_SHIFT);
> +	regmap_update_bits(plat->base, PHY_CTRL4, ITAPCHGWIN_MASK,
> +			   1 << ITAPCHGWIN_SHIFT);
>  	regmap_update_bits(plat->base, PHY_CTRL4, mask, val);
> +	regmap_update_bits(plat->base, PHY_CTRL4, ITAPCHGWIN_MASK, 0);
>=20=20
>  	regmap_update_bits(plat->base, PHY_CTRL5, CLKBUFSEL_MASK,
>  			   plat->clkbuf_sel);
> @@ -501,7 +507,7 @@ static int sdhci_am654_get_otap_delay(struct udevice =
*dev,
>  	 * Remove the corresponding capability if an otap-del-sel
>  	 * value is not found
>  	 */
> -	for (i =3D MMC_HS; i <=3D MMC_HS_400; i++) {
> +	for (i =3D MMC_LEGACY; i <=3D MMC_HS_400; i++) {

I'm not super familiar with mmc drivers in general, but it feels like
this bit does not really belong in this patch.

Is this another bugfix for removing otap-del-sel for MMC_LEGACY devices
or does U1 UHS SD cards are considered to be of MMC_LEGACY type ?

>  		ret =3D dev_read_u32(dev, td[i].otap_binding,
>  				   &plat->otap_del_sel[i]);
>  		if (ret) {
> --=20
> 2.40.0
