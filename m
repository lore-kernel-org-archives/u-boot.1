Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63FDFC83011
	for <u-boot@archiver.kernel.org>; Thu, 29 Aug 2024 08:56:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9682A88B86;
	Thu, 29 Aug 2024 10:56:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="S99kqrAt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D278788AD7; Thu, 29 Aug 2024 10:56:26 +0200 (CEST)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DD2FA88B86
 for <u-boot@lists.denx.de>; Thu, 29 Aug 2024 10:56:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-427fc97a88cso3620835e9.0
 for <u-boot@lists.denx.de>; Thu, 29 Aug 2024 01:56:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1724921784; x=1725526584;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=tv3sL1g1cIq1/sO+JEXHNqbgdWA/9Tkrdg/voKB/wec=;
 b=S99kqrAtGWDGM1TvztrIzaFu1FBGatDuFmOpLH8P8i6KDmU/ldUynE1HOXfB2EK/Zh
 RTgfm+wXQp2vB5Fz1QOc4wj0OTr3A9DQ5fm9/gBnOAm+jIDqcy4PRhTdgt1r8I+vWBbQ
 4EHu1IpjlH43qvug3LUxGyIRcySovzjrT7NWV5ijTxWxcjNeNRaX7t29pP03LghF8BVG
 669q0HEYagDsSpSzk5MBYFLdTVEU6acdwxWnk/P6CGylCPEv8stBDRVwZzl7sN/ralJj
 L1NWJzO4HpGgyL7fFdz6FwjCv8Jubg8kJW4WliCEm858mVxKWcl1TGMHNuL5/0+uHsKU
 6JsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724921784; x=1725526584;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tv3sL1g1cIq1/sO+JEXHNqbgdWA/9Tkrdg/voKB/wec=;
 b=B4iV3v87E/4Cbd//ejXIOdjU/e4vGpoWsVkgz+RBuBBN/0kFXJyWZY/C/71gBRTfGh
 aJVDMTWuC6XZjzrgMmadVZmmkMMWgB+mkndbdaGESa9C4Ffo49RukKPlme/oPSDFWXE5
 o1CVicUE/8i3WeBFEGvkR2Z2c4Z9D7YS/9aIp7M9UqDoA221qXWw54Swvwz8wE7f8TBL
 O8xZYOlMNYBTQuMdBAYUZQZUz5M1rCizM4R2ufWbQ1ZoQkP5NV4N4/Dk8UHyl6TSnWpe
 lX7tDoKHhuIAx69hfbVbanVwYlH/9zt/mtD+BLmXoWqktpHwCU3m/PAaKO70BJ2FvafM
 BwRQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUy8RjEFmXnacwLXwYJgxdW1C8HnaSh2rAeyV2x77dLZyuwP6gZER4MG0VzOGS6kUkKAvj7RAA=@lists.denx.de
X-Gm-Message-State: AOJu0Yyl0PySg8qIJqZ/kMSem/xpZ3y+lbsbYdzUw/VrzozDaBJqj0j9
 cefjVX2z5Ybm+4zrfz3GNcJcbP2454+4jtQPgjlKSxlcgY/Bp4vq8GwLjCFtgjg=
X-Google-Smtp-Source: AGHT+IFWgcUmZED3IKltc/QecVkf1U6/eytahwGwcJ7zVujPaVP9SInd2KPs7eUfaZ036TnUW6yrfg==
X-Received: by 2002:a5d:618c:0:b0:371:8763:763c with SMTP id
 ffacd0b85a97d-3749b552584mr1467721f8f.33.1724921783717; 
 Thu, 29 Aug 2024 01:56:23 -0700 (PDT)
Received: from localhost ([82.66.159.240]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3749ee4a590sm864826f8f.9.2024.08.29.01.56.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Aug 2024 01:56:23 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Joshua Watt <jpewhacker@gmail.com>, u-boot@lists.denx.de
Cc: Joshua Watt <JPEWhacker@gmail.com>, Igor Opaniuk
 <igor.opaniuk@gmail.com>, Sam Protsenko <semen.protsenko@linaro.org>, Tom
 Rini <trini@konsulko.com>
Subject: Re: [PATCH v2] android_ab: Fixes: Fix backup offset calculation
In-Reply-To: <20240828143924.3987331-1-JPEWhacker@gmail.com>
References: <20240807141434.733085-1-JPEWhacker@gmail.com>
 <20240828143924.3987331-1-JPEWhacker@gmail.com>
Date: Thu, 29 Aug 2024 10:56:20 +0200
Message-ID: <87r0a7r9l7.fsf@baylibre.com>
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

Hi Joshua,

Thank you for the patch.

On mer., ao=C3=BBt 28, 2024 at 08:37, Joshua Watt <jpewhacker@gmail.com> wr=
ote:

> The backup offset is in bytes, but was incorrectly be interpreted as
> blocks, leading to it being written to the wrong location. Fix the
> calculation, clarify that ANDROID_AB_BACKUP_OFFSET is in bytes and must
> be a multiple of the block size, and add a runtime check to validate the
> offset.
>
> Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>

Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>

As Igor suggested, I will add:

Fixes: 3430f24bc69d ("android_ab: Try backup booloader_message")

When applying.

> ---
>  boot/android_ab.c | 9 +++++++--
>  common/Kconfig    | 3 ++-
>  2 files changed, 9 insertions(+), 3 deletions(-)
>
> diff --git a/boot/android_ab.c b/boot/android_ab.c
> index 143f373aae..1196a189ed 100644
> --- a/boot/android_ab.c
> +++ b/boot/android_ab.c
> @@ -139,8 +139,13 @@ static int ab_control_store(struct blk_desc *dev_des=
c,
>  {
>  	ulong abc_offset, abc_blocks, ret;
>=20=20
> -	abc_offset =3D offset +
> -		     offsetof(struct bootloader_message_ab, slot_suffix) /
> +	if (offset % part_info->blksz) {
> +		log_err("ANDROID: offset not block aligned\n");
> +		return -EINVAL;
> +	}
> +
> +	abc_offset =3D (offset +
> +		      offsetof(struct bootloader_message_ab, slot_suffix)) /
>  		     part_info->blksz;
>  	abc_blocks =3D DIV_ROUND_UP(sizeof(struct bootloader_control),
>  				  part_info->blksz);
> diff --git a/common/Kconfig b/common/Kconfig
> index 83c81edac2..e1b8557e0c 100644
> --- a/common/Kconfig
> +++ b/common/Kconfig
> @@ -986,7 +986,8 @@ config ANDROID_AB_BACKUP_OFFSET
>  	help
>  	  If non-zero, a backup bootloader message starting at this offset in
>  	  the partition will tried in the event that the primary one (starting
> -	  at offset 0) fails its checksum.
> +	  at offset 0) fails its checksum. The offset is in bytes and must be
> +	  multiple of the block size.
>=20=20
>  endmenu
>=20=20
> --=20
> 2.45.2
