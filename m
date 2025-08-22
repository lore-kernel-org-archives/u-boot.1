Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26ACDCA0EEB
	for <u-boot@archiver.kernel.org>; Fri, 22 Aug 2025 14:48:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 117C980548;
	Fri, 22 Aug 2025 16:48:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="RbGrEPpe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DBBE681D5D; Fri, 22 Aug 2025 16:48:07 +0200 (CEST)
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com
 [IPv6:2607:f8b0:4864:20::d36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 622E18006D
 for <u-boot@lists.denx.de>; Fri, 22 Aug 2025 16:48:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-io1-xd36.google.com with SMTP id
 ca18e2360f4ac-88470af142bso174251739f.0
 for <u-boot@lists.denx.de>; Fri, 22 Aug 2025 07:48:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1755874084; x=1756478884; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=SGfdq549pByN8Q0x5vS4Y1nZcsd168JPVyXtsFXaScU=;
 b=RbGrEPpe9HIQGxGDj5bu5NkU1vhLDJQjkxjRRhTVNBbQYkSIzm7wAv97y98GUFiA5c
 c7+h/PiDjUGRsAZFx6T0HN1RQKOVdVa+ASdE22eBMki/wn7bEWzFvPMkIpjBy/krY/sT
 rbTH7ugdLtnHibK3cHfVHrpEK7FK1GjwcwTwQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755874084; x=1756478884;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SGfdq549pByN8Q0x5vS4Y1nZcsd168JPVyXtsFXaScU=;
 b=ff9qJ7tbBzSurAMnnj2fMA0Ehigzp5UK/scLg75ZSQy9Nj2a03LAnsCIGG8FbpqfGE
 l5Y8otzim9zk0vZxg1rHT9DFc0BI3y9kDrLbpvJ/11QYwYPbXKwFJ/Dgm2kV4qmmEupo
 EPdt3j0mDzfLWDvxhuaIC+6a9hqpzxXFliELa8Aq5HgWg8fl+1FlKWjQbeH2j8Xttq4y
 9f+5pd7pmUF3XdquILsqRhaAqF6Xe4dS+N67yJwJ0r8i6CmtYOq9xTUZh8sYIOAyFg9N
 nMjFDfh5WTOUiJOElXJpzGu+5bryJte9KcOtM58OAe+Iu6nAyCKlI/R9uxZd1uGq4xw/
 iYLQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWVb8O0b/Y/U52066TyEXwrlycOfqf31wIMKW83oGeKa7IYXVTcXTnyFZ9GMAqAsWT5T9oQ3Gw=@lists.denx.de
X-Gm-Message-State: AOJu0YySmYxe6iMnKxThIFDAZNYnwU4GV69a/61JGYWLecyhPiLjLtS9
 jPn8lTaRRJL5UCdStFPzHGpS6B0PqKlyg5ndH7Z8nC5wygPzm+3xLGipnSLVlUkaX3+j57nT4FX
 gFn/GEN8=
X-Gm-Gg: ASbGncuUMsJSQy5KdAoB0SBVtv/1+ybMTBsu6GYbeGewY6duG1uiPkVz5wGS/Gb+/8G
 Ly+BTmU7T18Qx9YGM2ZAOBxrmSZyMy62Pxuex9m2xDHFUu4+RhRo4n+SzIVn58LSoie5BRQt0Ln
 uwgBVi2wIiNy218h4xMRef3h1suwNzq3KBEKMMJcUfRgYNvvLRz0yQkKqUkw/vNJ9VHweeS9qiy
 Aj5QVuWosdVod1v4i/4FZtC87g59ptmwgfc5lm2pn7Jyyy0BTi6MbkS24J8iDoANbwdK2ceG3O4
 c0hzrtGKnTSy38WCgPeJo5lZuSfM+tM0siESASQdJ3ZBFuLlk9Ouu76AR3wcCI1nGh0zPUDPaig
 BQcs0NqUcAMmeEt/Y1m1dE5kGYyIuU+LUMtJxlySn+ZBF0t4u2Ym+ePrh
X-Google-Smtp-Source: AGHT+IHEWCH42t8tfEnlfRkejmKtBn1EWrDtZTm6HIfOtgexU5wcQyGztUOBF+VODsgrN4kR6lEcNw==
X-Received: by 2002:a05:6602:158d:b0:861:d8ca:3587 with SMTP id
 ca18e2360f4ac-886bd14bc73mr549605639f.4.1755874084034; 
 Fri, 22 Aug 2025 07:48:04 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-886c8f0a83esm8882639f.10.2025.08.22.07.48.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Aug 2025 07:48:03 -0700 (PDT)
Date: Fri, 22 Aug 2025 08:47:59 -0600
From: Tom Rini <trini@konsulko.com>
To: vishnu singh <v-singh1@ti.com>
Cc: mkorpershoek@kernel.org, j@jannau.net, u-boot@lists.denx.de
Subject: Re: [RFC PATCH] bootstage: stash boot records to reserved mem before
 kernel handoff
Message-ID: <20250822144759.GO124814@bill-the-cat>
References: <20250822040523.1803792-1-v-singh1@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="i+HNzIACJvsSZKb5"
Content-Disposition: inline
In-Reply-To: <20250822040523.1803792-1-v-singh1@ti.com>
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


--i+HNzIACJvsSZKb5
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 22, 2025 at 09:35:23AM +0530, vishnu singh wrote:

> From: Vishnu Singh <v-singh1@ti.com>
>=20
> U-Boot now stashes its bootstage buffer into a reserved memory region
> whenever CONFIG_BOOTSTAGE_STASH is enabled, just before exiting to the
> kernel. This allows a post boot parser to read a unified timeline
> (SPL=E2=86=92U-Boot=E2=86=92Kernel=E2=86=92MCU/DSP) directly from DDR, en=
abling standardized
> and repeatable boot-time profiling across releases and SoCs.
>=20
> Change summary:
>  Call bootstage_stash_default() in announce_and_cleanup()
>   when CONFIG_BOOTSTAGE_STASH is set.
>=20
> Reference boot-time parser utility:
>  https://github.com/v-singh1/boot-time-parse
>=20
> Sample boot time report:
>     +--------------------------------------------------------------------+
>                      am62xx-evm Boot Time Report
>     +--------------------------------------------------------------------+
>     Device Power On         : 0 ms
>     SPL Time                : 843 ms
>     U-Boot Time             : 2173 ms
>     Kernel handoff time     : 462 ms
>     Kernel Time             : 2522 ms
>     Total Boot Time         : 6000 ms
>     +--------------------------------------------------------------------+
>=20
>     +--------------------------------------------------------------------+
>                      Bootloader and Kernel Boot Records
>     +--------------------------------------------------------------------+
>     BOOTSTAGE_AWAKE                =3D      0 ms (+  0 ms)
>     BOOTSTAGE_START_UBOOT_F        =3D    843 ms (+  0 ms)
>     BOOTSTAGE_ACCUM_DM_F           =3D    843 ms (+  0 ms)
>     BOOTSTAGE_START_UBOOT_R        =3D   1951 ms (+1108 ms)
>     BOOTSTAGE_ACCUM_DM_R           =3D   1951 ms (+  0 ms)
>     BOOTSTAGE_NET_ETH_START        =3D   2032 ms (+ 81 ms)
>     BOOTSTAGE_NET_ETH_INIT         =3D   2053 ms (+ 21 ms)
>     BOOTSTAGE_MAIN_LOOP            =3D   2055 ms (+  2 ms)
>     BOOTSTAGE_START_MCU            =3D   2661 ms (+606 ms)
>     BOOTSTAGE_BOOTM_START          =3D   2959 ms (+298 ms)
>     BOOTSTAGE_RUN_OS               =3D   3016 ms (+ 57 ms)
>     BOOTSTAGE_BOOTM_HANDOFF        =3D   3016 ms (+  0 ms)
>     BOOTSTAGE_KERNEL_START         =3D   3478 ms (+462 ms)
>     BOOTSTAGE_KERNEL_END           =3D   6000 ms (+2522 ms)
>     +--------------------------------------------------------------------+
>=20
>     +--------------------------------------------------------------------+
>                      MCU Boot Records
>     +--------------------------------------------------------------------+
>     MCU_AWAKE                      =3D   2661 ms (+  0 ms)
>     BOARD_PERIPHERALS_INIT         =3D   2661 ms (+  0 ms)
>     MAIN_TASK_CREATE               =3D   2661 ms (+  0 ms)
>     FIRST_TASK                     =3D   2662 ms (+  1 ms)
>     DRIVERS_OPEN                   =3D   2662 ms (+  0 ms)
>     BOARD_DRIVERS_OPEN             =3D   2662 ms (+  0 ms)
>     IPC_SYNC_FOR_LINUX             =3D   6636 ms (+3974 ms)
>     IPC_REGISTER_CLIENT            =3D   6636 ms (+  0 ms)
>     IPC_SUSPEND_TASK               =3D   6636 ms (+  0 ms)
>     IPC_RECEIVE_TASK               =3D   6636 ms (+  0 ms)
>     IPC_SYNC_ALL                   =3D   6787 ms (+151 ms)
>     +--------------------------------------------------------------------+
>=20
> Signed-off-by: Vishnu Singh <v-singh1@ti.com>

In that it looks like x86 already does a similar thing, this is a good
idea and I wonder if some tooling already exists to read it.

> ---
>  arch/arm/lib/bootm.c | 3 +++
>  1 file changed, 3 insertions(+)
>=20
> diff --git a/arch/arm/lib/bootm.c b/arch/arm/lib/bootm.c
> index 7eb764e1f4e..b01e763ff28 100644
> --- a/arch/arm/lib/bootm.c
> +++ b/arch/arm/lib/bootm.c
> @@ -57,6 +57,9 @@ static void announce_and_cleanup(int fake)
>  #ifdef CONFIG_BOOTSTAGE_FDT
>  	bootstage_fdt_add_report();
>  #endif
> +	if (IS_ENABLED(CONFIG_BOOTSTAGE_STASH))
> +		bootstage_stash_default();

You don't need to guard the call, the default bootstage_stash_default()
is a return 0 call when CONFIG_BOOTSTAGE_STASH isn't set.

--=20
Tom

--i+HNzIACJvsSZKb5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaKiDGwAKCRAr4qD1Cr/k
CgI8AP9hOVeD5c7ALQYvmVgWtgOHOQXTepqivCjLV2TgZQIaEgEApmS/L12LTZoS
5nehZ0qRED3w6UWEvj5r+h4ReY4UJQQ=
=mAZr
-----END PGP SIGNATURE-----

--i+HNzIACJvsSZKb5--
