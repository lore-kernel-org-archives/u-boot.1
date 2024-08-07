Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72443C52D6F
	for <u-boot@archiver.kernel.org>; Wed,  7 Aug 2024 06:44:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DA10C88B4B;
	Wed,  7 Aug 2024 08:44:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="L4Zo4dqF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 54CF588AD4; Wed,  7 Aug 2024 08:44:49 +0200 (CEST)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5B38388B59
 for <u-boot@lists.denx.de>; Wed,  7 Aug 2024 08:44:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4281d812d3eso13578445e9.3
 for <u-boot@lists.denx.de>; Tue, 06 Aug 2024 23:44:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1723013087; x=1723617887;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=YtoU3ixlGBR8oCIO5iHaBaGi4wAOP+OpuHXYbB9nin0=;
 b=L4Zo4dqFGAnCLyh0KagrP5m/ZlaYbaUarwt7XAbmKmrhFlPPjLpsX9fQ04N10ey7cq
 MD7hd+Z0UDSeEATMDqpeD6FGFh5GcylE+Ptlh1eLMuMB3ph0rODE9TrE7CBcGgmayWRU
 v/xY21VzbKTQyOJ/R4ZNyPk03UjliL8qPQmscbSxCcvJdUeNcFTjdqF4Oear5Wc//BjC
 6dlpYHB9ARnl6Qe6Yd05b3pzHQ4aimq1jbkXq8hY2ZTBYDelp0XX/Wv9I8zImIqnJtv7
 uTEmyTpRK3CptuX8ihKJ94j24zo14+/tiDpqoSAUhVCKRdwoUsyW2QhMr0iX9CgA1Uzg
 EJRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723013087; x=1723617887;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YtoU3ixlGBR8oCIO5iHaBaGi4wAOP+OpuHXYbB9nin0=;
 b=QejpLQC6gBd6Q2HSxYvu2AexVDjHgFka+lymMwW1tjTiDfs/M3/DWjcGvYnbkqdYrC
 +tRsL66BibXRK9OkK4GnmQSTkJfgdbNCA1blL1d5+yjdjanMzFB1/uhPnJf4/jA49e36
 74EJ/abucbtC0sTJJFpdxA5T6SCi4srZH/NlwE3pWHyR4w8SGAqbiUt9jQRfK+eeLCT/
 0sPLGK66bBSabQeRQZSnHFDcJvP7mCk6Oz76GeG45hhIv0RuayCxU0qtgaXfe7UCYDuB
 +uYNVbImhaSX6LH1hooJ92X18d3M8+tbvRBSIWVBA0WyfHWQehDEj2COvqMQLo/OeZ7K
 YOlQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXfemt0QtK2kZvsvQWXi6KjQZ8tej5Wp/IoxWzSEtILbYBzG8vylMUCqWKM+5h5EXBl+uj2g0E=@lists.denx.de
X-Gm-Message-State: AOJu0YyESy3guMjyNA8kibINRcgpDDGP2MXjT5VJny41EwfPZl6uOAGD
 +tmnBSs43Gmqt3hJQK+jE7e9wUTCwKgbmoIT4IB7AsYcENHEBsZUR25VpQ9NdJM=
X-Google-Smtp-Source: AGHT+IHrBtl1Ldzi/79uO3un52aNPdF3lWnHh4TSDVMpWSoseVRTLVsaVqEzMPjW+VC6brokC73OZQ==
X-Received: by 2002:a05:600c:1f96:b0:428:f0a:3f92 with SMTP id
 5b1f17b1804b1-428e6b2f142mr142592795e9.21.1723013086280; 
 Tue, 06 Aug 2024 23:44:46 -0700 (PDT)
Received: from localhost ([2a01:cb19:8f40:f900:f167:cb53:a707:1347])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-429059a8912sm12742805e9.38.2024.08.06.23.44.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Aug 2024 23:44:45 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>, Ilias
 Apalodimas <ilias.apalodimas@linaro.org>
Cc: Simon Glass <sjg@chromium.org>, Shantur Rathore <i@shantur.com>, AKASHI
 Takahiro <akashi.tkhro@gmail.com>, u-boot@lists.denx.de, Heinrich
 Schuchardt <heinrich.schuchardt@canonical.com>
Subject: Re: [PATCH 1/1] boot: set correct block device name in
 set_efi_bootdev()
In-Reply-To: <20240807001345.296937-1-heinrich.schuchardt@canonical.com>
References: <20240807001345.296937-1-heinrich.schuchardt@canonical.com>
Date: Wed, 07 Aug 2024 08:44:43 +0200
Message-ID: <87jzgsomqs.fsf@baylibre.com>
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

Hi Heinrich,

Thank you for the patch.

On mer., ao=C3=BBt 07, 2024 at 02:13, Heinrich Schuchardt <heinrich.schucha=
rdt@canonical.com> wrote:

> For SATA devices the class name is 'ahci' but the block device name is
> 'sata'.
>
> Use function blk_get_uclass_name() to retrieve the correct string.
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>

Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>

> ---
>  boot/bootmeth_efi.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
>
> diff --git a/boot/bootmeth_efi.c b/boot/bootmeth_efi.c
> index 39232eb2e25..6b41c0999f1 100644
> --- a/boot/bootmeth_efi.c
> +++ b/boot/bootmeth_efi.c
> @@ -100,11 +100,10 @@ static void set_efi_bootdev(struct blk_desc *desc, =
struct bootflow *bflow)
>  	if (last_slash)
>  		*last_slash =3D '\0';
>=20=20
> -	log_debug("setting bootdev %s, %s, %s, %p, %x\n",
> -		  dev_get_uclass_name(media_dev), devnum_str, bflow->fname,
> -		  bflow->buf, size);
>  	dev_name =3D device_get_uclass_id(media_dev) =3D=3D UCLASS_MASS_STORAGE=
 ?
> -		 "usb" : dev_get_uclass_name(media_dev);
> +		 "usb" : blk_get_uclass_name(device_get_uclass_id(media_dev));
> +	log_debug("setting bootdev %s, %s, %s, %p, %x\n",
> +		  dev_name, devnum_str, bflow->fname, bflow->buf, size);
>  	efi_set_bootdev(dev_name, devnum_str, bflow->fname, bflow->buf, size);
>  }
>=20=20
> --=20
> 2.45.2
