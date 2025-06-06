Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0EB8C5AD49
	for <u-boot@archiver.kernel.org>; Fri,  6 Jun 2025 14:36:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EC0B481F0D;
	Fri,  6 Jun 2025 16:36:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="FijJd5kF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9244382977; Fri,  6 Jun 2025 16:36:45 +0200 (CEST)
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com
 [IPv6:2607:f8b0:4864:20::22a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 61E8C800C1
 for <u-boot@lists.denx.de>; Fri,  6 Jun 2025 16:36:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22a.google.com with SMTP id
 5614622812f47-4074997ce2bso621153b6e.3
 for <u-boot@lists.denx.de>; Fri, 06 Jun 2025 07:36:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1749220601; x=1749825401; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=nSEgG8R1Xf709JHRIV0dZqNc64Lv1jvHPK4q+Hl0KUc=;
 b=FijJd5kF7Gku0jjJoW38DM51vXGYrBW7KqXLnEfbl9pE36EeZxj7iVXPeP4g8K+bNY
 6SyfJJnljPw8lz9ubl+wjGm9MDmzthvSkH2Tz/xWrmetmj8Z4DO990pbq6QFsw62uN2U
 YxPPD9+CfD+IWmk128pH9tXSiyYrWGs9CysM8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749220601; x=1749825401;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nSEgG8R1Xf709JHRIV0dZqNc64Lv1jvHPK4q+Hl0KUc=;
 b=N1+U6uNfNpTsQbURJpcUs65yeX863F0GdU5zu5DyjfzJ41UN92Qvd9B3vod7PBTVeF
 OmXvJPjL8FcO3mdPOUygprhrr0hh4MxbkrhgnqWN/sLkudo+xBWiS1h4tyt2C/SoBS7O
 tFynACAHvi9tQd/24zPp8s3UOx212UYFTr4Hwz0/S618wZ0m347YfTd2UfKtrJTRd7kG
 jyu4GE+UOtSAKpW1X6xYdO5X4yw/KNWPYJd1IhOV/EOG4m45DZmNX3Yaf9LfDcFQp6u3
 EmtuFRwvP9AnKARoYwxkxap/Oz+yg7aRE2Iib6pnyz7+S72bEhrfxDmiqfWOLkH8+FwS
 DDNg==
X-Forwarded-Encrypted: i=1;
 AJvYcCV8NG81R8AAXrMXH2dI7Upz5oTU7quhCfBv5T7ToFyI8JaX1/rGb6Vs67DJNqL1n7Q1b35lwmc=@lists.denx.de
X-Gm-Message-State: AOJu0YyCxVJuq8+cXUVOEFbD/UCpbtnRECdbVLFhtfai4MDKvdSiUPlv
 tGMjb3WAxX0l7MvY7BthXPvjkL+Fvo1/baVncxO9eX+TdtLIV5xwrsOL0RyhdLe2gV4=
X-Gm-Gg: ASbGncuZMnHeYz0PERatw/QDB5/wKrA6lvXJeb4UMQ7D7Av14QN3tL7of+b/1wF2uI6
 EvbtquRPmZUW094n4zy9eVTCQB+vWDT9v1ZoH8T4oW1mbE0N82byaWb9L/dhNoKImJ4UlQrLcu9
 wo4D3N13/BHaxuzNln8UfKHgTz0QejtyT3IsKoME4qPTzLopoAHf1ufnK34Fq7khsRt2NofiOVO
 C6WkI1zeh4mgPXuSElma9rHljBEzPgfJfoFP8WlVhh8W1cYYf7E1jUwbbaoInIOaxFnIRgByv1/
 sEYHIXQHM2vH+vHAbnWMUD7VlVquAiD0ayebGnQf3t29MO4uC4YLjZzZ/Cx+mAuWN4266gN+ZDF
 xb7LgWdtn6aAe
X-Google-Smtp-Source: AGHT+IHcEnst4V0h+W3HA0zlq/BK8dRcv0gamf+x+xU2b5FbuBiXepYVS4Z3OSBnRG6qVA3EjkK5zg==
X-Received: by 2002:a05:6808:3a0e:b0:3f9:aeb6:6eac with SMTP id
 5614622812f47-4090521fcdemr2324166b6e.30.1749220601270; 
 Fri, 06 Jun 2025 07:36:41 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-409069f59absm314327b6e.23.2025.06.06.07.36.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Jun 2025 07:36:40 -0700 (PDT)
Date: Fri, 6 Jun 2025 08:36:38 -0600
From: Tom Rini <trini@konsulko.com>
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Mattijs Korpershoek <mkorpershoek@kernel.org>, u-boot@lists.denx.de,
 Dmitrii Merkurev <dimorinny@google.com>
Subject: Re: [PATCH RFT v5 3/3] fastboot: integrate block flashing back-end
Message-ID: <20250606143638.GS1382132@bill-the-cat>
References: <20250606-topic-fastboot-blk-v5-0-203538ec5b32@linaro.org>
 <20250606-topic-fastboot-blk-v5-3-203538ec5b32@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="P5jxo07+BunoDheW"
Content-Disposition: inline
In-Reply-To: <20250606-topic-fastboot-blk-v5-3-203538ec5b32@linaro.org>
X-Clacks-Overhead: GNU Terry Pratchett
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


--P5jxo07+BunoDheW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 06, 2025 at 11:33:09AM +0200, Neil Armstrong wrote:

> From: Dmitrii Merkurev <dimorinny@google.com>
>=20
> 1. Get partition info/size
> 2. Erase partition
> 3. Flash partition
> 4. BCB
>=20
> Signed-off-by: Dmitrii Merkurev <dimorinny@google.com>
> Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
> Tested-by: Mattijs Korpershoek <mkorpershoek@kernel.org>
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
>  drivers/fastboot/Kconfig      | 29 ++++++++++++++++++++++++++++-
>  drivers/fastboot/Makefile     |  1 +
>  drivers/fastboot/fb_command.c |  8 ++++++++
>  drivers/fastboot/fb_common.c  | 22 ++++++++++++++++++----
>  drivers/fastboot/fb_getvar.c  |  8 +++++++-
>  5 files changed, 62 insertions(+), 6 deletions(-)
>=20
> diff --git a/drivers/fastboot/Kconfig b/drivers/fastboot/Kconfig
> index 70207573de2bd0d56b4b7fa6f7e17fdc5803ba15..75911468ba4980d9b96e2af9e=
708f08b9ef16ac8 100644
> --- a/drivers/fastboot/Kconfig
> +++ b/drivers/fastboot/Kconfig
> @@ -91,7 +91,7 @@ config FASTBOOT_USB_DEV
>  config FASTBOOT_FLASH
>  	bool "Enable FASTBOOT FLASH command"
>  	default y if ARCH_SUNXI || ARCH_ROCKCHIP
> -	depends on MMC || (MTD_RAW_NAND && CMD_MTDPARTS)
> +	depends on MMC || (MTD_RAW_NAND && CMD_MTDPARTS) || BLK

This is what's tricky. The symbol FASTBOOT_FLASH is default y for all
ARCH_SUNXI and ARCH_ROCKCHIP platforms where FASTBOOT is enabled. Since
looking in to effects here isn't super well documented, I'm going to be
a bit more verbose here than I might otherwise just to have a post to
refer back to later (possibly for adding to something under
doc/develop/).

So, tools/qconfig.py can be helpful here. If we use -b to first build
the database of boards and CONFIG sybmols enabled, we can then do:
$ tools/qconfig.py -f FASTBOOT ARCH_SUNXI BLK
to get everything that is FASTBOOT and ARCH_SUNXI and BLK.
We can also do:
$ tools/qconfig.py -f FASTBOOT ARCH_SUNXI BLK ~FASTBOOT_FLASH
To get the same as the above, but do not enable FASTBOOT_FLASH. This
gives us the CHIP platform. This is going to be the one that now enables
the new functionality. If we do the same but for ARCH_ROCKCHIP we get
zero matches. So this is our culprit.

This means the series, and this patch here needs to also disable the new
functionality on the CHIP defconfig.

--=20
Tom

--P5jxo07+BunoDheW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmhC/O4ACgkQFHw5/5Y0
tyzS7gv9HlfUZ3rY2XQj4vAqtmhX7Qx4vpYw4zJHORSyd0VV4wRx+CpT4PU8814N
+UO4mVjQt1SLQjXp17iMKjYCqeIISOZqK9rouY3lAk3do/bt2YHHCjSljFRm6WVO
OPhKKuKpmgfiYVhvpsKMqayRGSTs+wR5GK/oANPrK/vqtJvJh+jwETcEL3MvReCQ
kb8rKsKvzsEhDIcFTPfTY65SJWShMWo+Kzj3W2MmUnotfeG9UEtdJBzq0l6Nobn3
sNN+3TdP6J6CZBPRVFdECFxkN04CTsKfhtEGsZGJNhGpKz8ExXovbJyTYlE38L5x
cm7te76ROi9m+KFRZmeiBwGP2wRXMzYXuLV9jOhw8WjhfGa2f2iVagMut3kqJcz4
SAmtWC51DU6Vv1qfnywrBkNHFbVwoM7OaDaBHhi2tnGd/fr8zVAIECF5Uet3LiDN
LTN0NAShf8G2LJEKLyk5QJnCX69C98h7YXQx5Ol8uooxI3npT/9T5gpJdETxgbEb
eoJ/PCHI
=XFCQ
-----END PGP SIGNATURE-----

--P5jxo07+BunoDheW--
