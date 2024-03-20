Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A056C54E58
	for <u-boot@archiver.kernel.org>; Wed, 20 Mar 2024 12:42:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7701C8803E;
	Wed, 20 Mar 2024 13:42:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="VsqAi7ua";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 247618802B; Wed, 20 Mar 2024 13:42:12 +0100 (CET)
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com
 [IPv6:2607:f8b0:4864:20::112e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 05BEA8809E
 for <u-boot@lists.denx.de>; Wed, 20 Mar 2024 13:42:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112e.google.com with SMTP id
 00721157ae682-60a104601dcso70166327b3.2
 for <u-boot@lists.denx.de>; Wed, 20 Mar 2024 05:42:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1710938529; x=1711543329; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=tMaPD1zz3MDy2pI+4/j9blrITJF5WpFqVKJXkNQOusE=;
 b=VsqAi7uai6K/2dUE8VVrDvAYc2yURpt7T6ce/fxdjwsi4aMbMb/VZqzSlq3QxzqvEa
 kAZ08+4pGyoTHGGvoO0Z9UY26VJHJjY0Sl6Evls54Oyuw3rENE55nvqHNocN+cpbycGO
 TOROSCoiRsMgeMIh8PvoYTMGV7uQst+rfhPQc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710938529; x=1711543329;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tMaPD1zz3MDy2pI+4/j9blrITJF5WpFqVKJXkNQOusE=;
 b=ndE4QFBmGUzSOaiDT1Uy0uFdNBLtd8dcM7IBR/VnwmHY/8M67Nsn5Y3VqVvyGS8UqL
 aq+1iqlOxlNDNZhgesupTTrvgWi1NpFynBPN7cfokfCTI3Frppjv/0scFbkpygY9hqxQ
 VCJlIAA/quB7d+spCMIvASdjyO8A0VroWsQBq5dHEQFhxoh98bdw+NMYYp129RRqbkF7
 aJpUI8A/7OlmWd7uvGHP0ZbFzmerjA6ChDHy5h1xv+zbG/pehVh7+WoEyoGrie7q/LyC
 Dk+5iiR0SIfLFULwBQGuDfz/VhVsD/5dGxa2242LhFEHgw1f5YiFVX9bBCxWdekThi8e
 +jNQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXwCwn3qWHIeuhmqU9iXPWsXE/PBvaryzCUbRHhpArXLIvy55RrquCkg4KQvXtZifNEqV/5kHi/YbDLaTAftR+9WLS0/Q==
X-Gm-Message-State: AOJu0Yx5yfNHnX8QQZc1NvWb1g2DvGG5H/3in+SXIwOSRbXJw2LNIPMG
 o/Ke3UbYFc7XFi/0YfA8P5wYmtidZRyt5pKye5Y2zf8Xp1nJaDddZVvZhox74y8=
X-Google-Smtp-Source: AGHT+IE0ov3Jya9wgIOqgooK6Fj/w/nH7gWo7NfFzio285NkitHskbPR2jIXMngozvFSQU0wPNb82A==
X-Received: by 2002:a0d:d3c6:0:b0:60a:50ec:afbc with SMTP id
 v189-20020a0dd3c6000000b0060a50ecafbcmr18154071ywd.41.1710938528850; 
 Wed, 20 Mar 2024 05:42:08 -0700 (PDT)
Received: from bill-the-cat (065-184-193-066.res.spectrum.com. [65.184.193.66])
 by smtp.gmail.com with ESMTPSA id
 z132-20020a814c8a000000b00610eaf46c6dsm562318ywa.117.2024.03.20.05.42.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Mar 2024 05:42:07 -0700 (PDT)
Date: Wed, 20 Mar 2024 08:42:05 -0400
From: Tom Rini <trini@konsulko.com>
To: MD Danish Anwar <danishanwar@ti.com>
Cc: Nishanth Menon <nm@ti.com>, Igor Opaniuk <igor.opaniuk@foundries.io>,
 Andrew Davis <afd@ti.com>, u-boot@lists.denx.de, srk@ti.com,
 Vignesh Raghavendra <vigneshr@ti.com>, r-gunasekaran@ti.com,
 Roger Quadros <rogerq@kernel.org>
Subject: Re: [PATCH] arm: mach-k3: Fix config check for FS_LOADER
Message-ID: <20240320124205.GS3442575@bill-the-cat>
References: <20240314143311.259568-1-danishanwar@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="pbm8dVAiVqanj2FW"
Content-Disposition: inline
In-Reply-To: <20240314143311.259568-1-danishanwar@ti.com>
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


--pbm8dVAiVqanj2FW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 14, 2024 at 08:03:10PM +0530, MD Danish Anwar wrote:

> load_firmware() API calls fs-loader APIs and checks for CONFIG_FS_LOADER
> before calling those APIs. The if check only checks for CONFIG_FS_LOADER
> but not for CONFIG_SPL_FS_LOADER.
>=20
> When CONFIG_FS_LOADER is enabled, load_firmware() API calls fs-loader APIs
> but this is done at SPL stage and at this time FS_LOADER is not built yet
> as a result we see below build error.
>=20
>   AR      spl/boot/built-in.o
>   LD      spl/u-boot-spl
> arm-none-linux-gnueabihf-ld.bfd: arch/arm/mach-k3/common.o: in function
> `load_firmware':
> /home/danish/workspace/u-boot/arch/arm/mach-k3/common.c:184: undefined
> reference to `get_fs_loader'
> arm-none-linux-gnueabihf-ld.bfd:
> /home/danish/workspace/u-boot/arch/arm/mach-k3/common.c:185: undefined
> reference to `request_firmware_into_buf'
> make[2]: *** [/home/danish/workspace/u-boot/scripts/Makefile.spl:527:
> spl/u-boot-spl] Error 1
> make[1]: *** [/home/danish/workspace/u-boot/Makefile:2055:
> spl/u-boot-spl] Error 2
> make[1]: Leaving directory '/home/danish/uboot_images/am64x/r5'
> make: *** [Makefile:177: sub-make] Error 2
>=20
> Fix this by modifying the if check to CONFIG_IS_ENABLED(FS_LOADER) instead
> of IS_ENABLED(CONFIG_FS_LOADER) as the former will check for the
> appropriate config option (CONFIG_SPL_FS_LOADER / CONFIG_FS_LOADER) based
> on the build stage.
>=20
> Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
> Acked-by: Ravi Gunasekaran <r-gunasekaran@ti.com>

Applied to u-boot/next, thanks!

--=20
Tom

--pbm8dVAiVqanj2FW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmX62Z0ACgkQFHw5/5Y0
tywkUwv/bt0WMoRiWmIVUDN7WqIOglrhfvr5XnYk7YYv1WEpGR1s3AtWS+k5rQmA
IyvafQGBhNswPRVNSM0+nUTmYRJNnX+M7uSIknATbXoFzK8rzOY+Xf0787fszGQu
y6HjYhUC1A32fupnENaCFEgRip7pRnuqEz8C12J24W8LAml40RlukT6yGop3cipK
adhcFW6Pfa8Hm/wJ4WGNVGKMw3VfjuTxixciHw24LYCwkUme0iNWkiqtMfZdonhc
XtzxmxkCmyHZLHlxaKBQBpLvCExy+9xE9tD82O6ifnoQb8BvN+1M79YtIhQ9XnG3
h33ozuCOuIh1Q/TiB6DAz4VexYR/MhzOYOaq9/hY2dAyCuC9nTAedeqO8M9PIiV7
92Q223+uCPySH6LtMT6YAD7sr0zYLgYgxO/HhlmiA2vVL5imv2U5MgWxCtl296qE
pkBQ94F1dWM1H06f61IlP+xy7TEvqzVzPxq6aqzlCEqdnb1tgygQQ0kz5xwxFmVE
A36ypDwE
=XttK
-----END PGP SIGNATURE-----

--pbm8dVAiVqanj2FW--
