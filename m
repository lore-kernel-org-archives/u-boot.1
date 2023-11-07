Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9472C4332F
	for <u-boot@archiver.kernel.org>; Tue,  7 Nov 2023 18:26:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2FBC48753A;
	Tue,  7 Nov 2023 19:26:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="WdRDpyUG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 99FD687588; Tue,  7 Nov 2023 19:26:31 +0100 (CET)
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com
 [IPv6:2607:f8b0:4864:20::735])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6888387514
 for <u-boot@lists.denx.de>; Tue,  7 Nov 2023 19:26:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x735.google.com with SMTP id
 af79cd13be357-777754138bdso383406585a.1
 for <u-boot@lists.denx.de>; Tue, 07 Nov 2023 10:26:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1699381588; x=1699986388; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=yOO5eoKvdi5QH9jdU/tyEYZE76eGzAt2IFtb3HNZk9M=;
 b=WdRDpyUGeSXs7LRZkgiZqEEUFULiZvyoMdgR1ev5B2d7mLToPyifF6jzDOxycRg9tZ
 FgoUylpqX/Vyp+mVueiiwgCIP6+J+TlBI7FyTwcvOw/5R2dSTjy4QtSHvEHp4xdDGG/e
 x7QZfGy2JNJzoZM0MrpVNsqVnHYcaszuFIxXM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699381588; x=1699986388;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yOO5eoKvdi5QH9jdU/tyEYZE76eGzAt2IFtb3HNZk9M=;
 b=lHu1itMxT2sOazyUNjHnIqSTe8KCBua9R8yyT56oYNsX/eeUrVtF2L1gXMra9a0B4G
 VY55WVItIXyE30yn29vjmvS5RawNxDoE083Zg4B3b852sLJ3amc9ykSTJVcfaKUa2uuO
 p/89LYP92yVVMroOxSdh5H7MCg7P8xAVhZixGQyPG4pPBTNr7MIsrM40+Uar/Fz3StpD
 PybK0/LzfIBfd7UmTdFBey/ezvO4N0ThRMxNVBNXPFiJ2jhz4mkwJEMaWTamU0AxoU28
 KJHiQBuaSYYBVSRpUlmdR0n3hAK5enwRW8Z/iE4PXC1TR3OXYqHl+ZtwCIoRsh7hN4LK
 M1nw==
X-Gm-Message-State: AOJu0YzEiZKudJaK5kBm92Al+gcyvkk1oHVPwS0dx6vB6LKstqSqen8k
 TH5LjrwaxcDpHo25ps2pWHcPdA==
X-Google-Smtp-Source: AGHT+IGeOsDeCest6oXFCFTVJy82Jzul70GcpmMU+mFAHh/DsgubuGvP4LXrWDUyH300MIFWklfLeQ==
X-Received: by 2002:a05:620a:4247:b0:77a:754b:feae with SMTP id
 w7-20020a05620a424700b0077a754bfeaemr13991842qko.48.1699381588146; 
 Tue, 07 Nov 2023 10:26:28 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-2fee-489d-8907-1a68.res6.spectrum.com.
 [2603:6081:7b00:6400:2fee:489d:8907:1a68])
 by smtp.gmail.com with ESMTPSA id
 k22-20020a05620a07f600b0076eee688a95sm161113qkk.0.2023.11.07.10.26.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Nov 2023 10:26:27 -0800 (PST)
Date: Tue, 7 Nov 2023 13:26:25 -0500
From: Tom Rini <trini@konsulko.com>
To: Thomas Richard <thomas.richard@bootlin.com>
Cc: u-boot@lists.denx.de, nm@ti.com, thomas.petazzoni@bootlin.com,
 gregory.clement@bootlin.com, u-kumar1@ti.com
Subject: Re: [PATCH v2 7/8] board: ti: j721e: During resume spl restores TF-A
 and DM-Firmware
Message-ID: <20231107182625.GL6601@bill-the-cat>
References: <20231107161802.855154-1-thomas.richard@bootlin.com>
 <20231107161802.855154-8-thomas.richard@bootlin.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="iLu02WZo7irPv/kP"
Content-Disposition: inline
In-Reply-To: <20231107161802.855154-8-thomas.richard@bootlin.com>
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


--iLu02WZo7irPv/kP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 07, 2023 at 05:18:01PM +0100, Thomas Richard wrote:

> During the boot a copy of DM-Firmware is done in a reserved memory
> area before it starts.
> When resuming, R5 SPL uses this copy of DM-Firmware instead of the fit
> image.
> TF-A which saved itself in this same memory area, is restored in
> SRAM by R5 SPL.
>=20
> Based on the work of Gregory CLEMENT <gregory.clement@bootlin.com>
>=20
> Signed-off-by: Thomas Richard <thomas.richard@bootlin.com>
> Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>
>=20
> ---
>=20
> Changes in v2:
> - Check if TF-A is running in DRAM, if yes no need to restore it
> - Remove BL31_START macro, and get TF-A start address from the fit image
>=20
>  arch/arm/mach-k3/common.c                 | 48 ++++++++++++++++++++++-
>  arch/arm/mach-k3/include/mach/j721e_spl.h | 28 +++++++++++++
>  arch/arm/mach-k3/sysfw-loader.c           |  9 +++--
>  3 files changed, 81 insertions(+), 4 deletions(-)

One problem here is we aren't updating something under doc/, possibly
doc/board/ti/k3.rst unless you want to start populating something
entirely new under doc/develop/. And then using kernel-doc comments here
and including the code in the rst.  And so this is a global comment to
the series as well, and I'll leave sorting out when/where to introduce
that part up to your discretion.

[snip]
> diff --git a/arch/arm/mach-k3/include/mach/j721e_spl.h b/arch/arm/mach-k3=
/include/mach/j721e_spl.h
> index e8947917a6..8e0f141ed6 100644
> --- a/arch/arm/mach-k3/include/mach/j721e_spl.h
> +++ b/arch/arm/mach-k3/include/mach/j721e_spl.h
> @@ -42,4 +42,32 @@
>  #define K3_PRIMARY_BOOTMODE		0x0
>  #define K3_BACKUP_BOOTMODE		0x1
> =20
> +/* Starting buffer address is 1MB before the stack address in DDR */
> +#define BUFFER_ADDR (CONFIG_SPL_STACK_R_ADDR - SZ_1M)

Assuming this is the full level of configurability we need to
BUFFER_ADDR please add some Kconfig logic to make sure we can't not set
CONFIG_SPL_STACK_R_ADDR. That might take a little trial-and-error and
if we just cannot enforce this via Kconfig, let me know and I'll think
about what we want to do instead next.

> +/* This is actually the whole size of the SRAM */
> +#define BL31_SIZE    0x20000

If this is all of SRAM then is there not already a define?

> +/* This address belongs to a reserved memory region for the point of vie=
w of
> + * Linux, U-boot SPL must use the same address to restore TF-A and resume
> + * entry point address
> + */
> +#define LPM_SAVE		0xA5000000
> +#define LPM_BL31_SAVE		LPM_SAVE
> +#define LPM_BL31_RESUME_SAVE	LPM_BL31_SAVE + BL31_SIZE
> +#define LPM_BL31_START_SAVE	LPM_BL31_RESUME_SAVE + __SIZEOF_POINTER__
> +#define LPM_DM_SAVE		LPM_BL31_START_SAVE  + __SIZEOF_POINTER__

Is any of this somewhere in the devicetree as well? I'm not saying "and
so pull it from that!" is a must, but I'd like to at least know "that
would be horrible to do", and fall back to having this needed
co-operation documented somewhere and ideally somewhere / somehow that
getting the values wrong is clear. Debugging resume failures at run-time
is much more painful than build time.

> +/* Check if the copy of TF-A and DM-Firmware in DRAM does not overlap an
> + * over memory section.
> + * The resume address of TF-A is also saved in DRAM.
> + * At build time we don't know the DM-Firmware size, so we keep 512k to
> + * save it.
> + */
> +#if defined(CONFIG_SPL_BUILD) && defined(CONFIG_TARGET_J7200_R5_EVM)
> +#if ((LPM_DM_SAVE + SZ_512K) > BUFFER_ADDR)
> +#error Not enough space to save DM-Firmware, TF-A and context for S2R
> +#endif
> +#endif

This is really the kind of thing I'd like to see enforced via Kconfig if
at all possible. Sometimes yes we just have to CPP and #error, I just
want to know we can't.

--=20
Tom

--iLu02WZo7irPv/kP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmVKgVEACgkQFHw5/5Y0
tyzFggv/XItp0OLN6aYzCOZLDzhML9Lz9dvsU9cwhaGKd9Fb3P57SQJefyuW6uWF
lEZWjBZz9eBO6vHkusG+ktDKpe19ZFhQOwbNU1FbywMebB/tYxf6RoM4Uj2IsTBT
JrzZfnCZRg6L5wpfi62UySKS/scIIeN2aURYTeD1lJuqzqC7B6eixcgZbMkSgRaD
W9mWU1q54SQGbXJz//RYIul6GIg9eiDekJPhZpjRvC8rMjTYgKW/FQM+ZwbVwkIe
mm+jUNfNnZrqfSRPDkEvB0YeuG5LmmKrRcvg3M+4tJY4NSPchyzjk1wN2dkW6Rx0
qEKhRGHaEeSYiRHt4n8AkheliH7EapTkc/ege54zRiHJ8v5NawlW1H/8ctJrVVLj
L5DCmjz7B7rQMdAXxhgba/7PCOVilakvRx7/P9uk3PFAHKz/CEWPKKKUieoS4oj2
r6ML1JJm8nIHGZeMf7hR1bJHaSL4/t3M+3GUcg6OV51ISgFysYH3CQ+JqLERl5V/
gMDm+5hk
=xV1N
-----END PGP SIGNATURE-----

--iLu02WZo7irPv/kP--
