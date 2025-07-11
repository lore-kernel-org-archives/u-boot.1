Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFCD5C83F1B
	for <u-boot@archiver.kernel.org>; Fri, 11 Jul 2025 14:32:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1118C803DF;
	Fri, 11 Jul 2025 16:32:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="SGUIXUUm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5F861805D7; Fri, 11 Jul 2025 16:32:19 +0200 (CEST)
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com
 [IPv6:2607:f8b0:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C10A4800D7
 for <u-boot@lists.denx.de>; Fri, 11 Jul 2025 16:32:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x336.google.com with SMTP id
 46e09a7af769-73afbe1497bso898435a34.1
 for <u-boot@lists.denx.de>; Fri, 11 Jul 2025 07:32:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1752244335; x=1752849135; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=NvSEnyMNSduxObUeuYGqN+6s2KnLxlWDVFRJtCRV398=;
 b=SGUIXUUmDYmaZ5it/J1VsqMmUQhrDNGZJoZzf02nhAbFcPtP3c1/ol4PLh+dZxU/J/
 OT/2EgmyoyhT2nAlN8s2fXbMaKrsd8A57vf3zbeCw3NOICrsj64Qyh3jEv6CB1b1e/iK
 /KpQLc6VQhRWO6q4mJphNrZQC7/dUeEIKPKmQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752244335; x=1752849135;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NvSEnyMNSduxObUeuYGqN+6s2KnLxlWDVFRJtCRV398=;
 b=TU+GR8mLbziGIJtA0K9Cv80nB5PiBuRPvVECyXNVqWk1+rXOTzweXxu1Ui2U7LcXHn
 nNPX1y+zLLleOZ3RVdLrc+sMWVxXQ0t+HPStM7qngwVby/mQYEMRC+qDXz4VrS2ZKSVO
 I06UBwDOH1wZq6tGRjubgUtdWxYsRPka1x+KSTgVx0uQeK1Ro2x4G0Nw3sgj+vIj7tvM
 /wSC3FhKaGVd4JM3GJW9BT8YyrL1wgurxYGqSf74nZuPaP07cMNXlaQGlHzfjLWeslzM
 gCZef+5YHAd00EitStrs3of8+RBlro6BI1IAqwXoPpQxl/sX4sXXD91J09UawGv4sJjX
 b5UA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWn7tEuRIML47l7j4+JoQpDcJBiy82GcvpxH72d8gcCRfVVd+37E1/IiNN3o8kuyDYxS/0C3jw=@lists.denx.de
X-Gm-Message-State: AOJu0YwgTeofBoAqCsPST4BcjkXm2JXB6BPPJqrxl0t1qPky337iBGeB
 wd+bcsYdxA80lrsB/SDLFmFUsBon/3gJa2Srxdf4uQ27csYUwJkqCeEuQrzi+DHKFQs=
X-Gm-Gg: ASbGncuYBXruBmv/rPOAxN3GjmtJPdh4MNfjhJY66xveSOABHAwXggy0J+8kAlYHOFH
 zZqOCzCMY0QxVJFJV+53emUUabvC/tyXMS/6q12z9QLx9ejyH8qTiAB4Ymk13RPHDVBnQn6vq4e
 jhJpugSe/9H3a6FqsTQzNGKjIF3gKKiDw1osVhYTVpaoqgqhRV7RxuRvaYlgQTKlwAoXP0USS4z
 N6MmmUZpn/5KsWprWNszkl3KhHqQO+LsTSSu/49wRwVkcCeCUmU9V7M0vmD4Azdmo4afMrkxG7s
 527tESVT5orLN+rpGWEgCS1GVqhDwDSR8YJzUplfcnWLKbwKiFoFIzFyOeg5A5B6Jk4kIv7lwpl
 BJVX6G65HYgk7Nfxftg8vmL/w074XV/hh05uSRKxaKDkfrzVLlruGiW65/JDxty3QQYg=
X-Google-Smtp-Source: AGHT+IFXfUh0M4h2EsI41gQyMc8Ir+rsjvguE0Q/adsitRzHWwXJ4shleQm1DQ8umEogkMxttYILcw==
X-Received: by 2002:a05:6808:120b:b0:40c:fcb9:9158 with SMTP id
 5614622812f47-41511813017mr2717063b6e.27.1752244335342; 
 Fri, 11 Jul 2025 07:32:15 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4141bbde341sm556546b6e.27.2025.07.11.07.32.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Jul 2025 07:32:14 -0700 (PDT)
Date: Fri, 11 Jul 2025 08:32:11 -0600
From: Tom Rini <trini@konsulko.com>
To: Yao Zi <ziyao@disroot.org>, Michal Simek <michal.simek@amd.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de
Subject: Re: [PATCH v2] kbuild: Avoid including architecture-specific
 Makefile twice
Message-ID: <20250711143211.GE6424@bill-the-cat>
References: <20250711085234.23659-1-ziyao@disroot.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="fYsw9CpT5ffnMZ2V"
Content-Disposition: inline
In-Reply-To: <20250711085234.23659-1-ziyao@disroot.org>
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


--fYsw9CpT5ffnMZ2V
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 11, 2025 at 08:52:34AM +0000, Yao Zi wrote:

> Stranges errors are observed when building U-Boot master for almost any
> RISC-V board, the messages are in two types, one is about duplicated
> symbols,
>=20
> 	u-boot/arch/riscv/cpu//mtrap.S:32: multiple definition of `trap_entry';
> 	arch/riscv/cpu/mtrap.o: u-boot/arch/riscv/cpu//mtrap.S:32: first defined=
 here
>=20
> and the other is fixdep's complaint about missing dependency files,
>=20
> 	fixdep: error opening file: arch/riscv/cpu/.mtrap.o.d: No such file or d=
irectory
> 	fixdep: error opening file: arch/riscv/cpu//.start.o.d: No such file or =
directory
>=20
> where the latter could only be reproduced when building parallelly.
>=20
> Both the two types of errors are about files in arch/riscv/cpu, and
> there's a suspicious slash character in the reported path. Looking
> through RISC-V-specific Makefiles, there's only one place that may
> expand to such a path,
>=20
> 	libs-y +=3D arch/riscv/cpu/$(CPU)/
>=20
> The right hand expands to "arch/riscv/cpu//" if $(CPU) isn't defined at
> the time of including. With some debug statement added to
> arch/riscv/Makefile, the output proves that arch/riscv/Makefile is
> included twice, once with $(CPU) undefined and once defined correctly
> according to CONFIG_SYS_CPU.
>=20
> Futher bisecting shows an extra include statement against
> arch/$(SRCARCH)/Makefile is added in earlier bump of Kbuild system. But
> the statement is evaluated before config.mk is included and definition
> of $(CPU), causing objects in arch/riscv/cpu/ are built and linked twice
> (once as "arch/riscv/cpu/*", and once as "arch/riscv/cpu//*"), resulting
> in the error.
>=20
> Let's simply remove the extra include to fix these nasty errors. For
> config targets, bumping Kbuild also introduced a new include to
> arch/$(SRCARCH)/Makefile, which is removed as well for consistency.
>=20
> Fixes: 5f520875bdf ("kbuild: Bump the build system to 5.1")
> Signed-off-by: Yao Zi <ziyao@disroot.org>
> Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> ---
>=20
> Changes from v1
> - Don't describe the problem as RISC-V-specific since it may affect ARM
>   builds as well.
> - Prevent config targets from including for architecture-specific
>   Makefile as well for consistency.
> - Add comments to explain the removal.
> - Link to v1: https://lore.kernel.org/u-boot/20250709161418.21287-2-ziyao=
@disroot.org/
>=20
>  Makefile | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
>=20
> diff --git a/Makefile b/Makefile
> index da53efa09f1..e745cc618ba 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -635,8 +635,9 @@ ifeq ($(config-targets),1)
>  # Read arch specific Makefile to set KBUILD_DEFCONFIG as needed.
>  # KBUILD_DEFCONFIG may point out an alternative default configuration
>  # used for 'make defconfig'
> -# Modified for U-Boot
> --include arch/$(SRCARCH)/Makefile
> +# Modified for U-Boot: we don't include arch/$(SRCARCH)/Makefile for con=
fig
> +# targets, which is useless since U-Boot has no architecture defining it=
s own
> +# KBUILD_{DEF,K}CONFIG, or CROSS_COMPILE.
>  export KBUILD_DEFCONFIG KBUILD_KCONFIG CC_VERSION_TEXT
> =20
>  config: scripts_basic outputmakefile FORCE
> @@ -724,8 +725,10 @@ endif
>  ARCH_CPPFLAGS :=3D
>  ARCH_AFLAGS :=3D
>  ARCH_CFLAGS :=3D
> -# Modified for U-Boot
> --include arch/$(SRCARCH)/Makefile
> +# Modified for U-Boot: we put off the include of arch/$(SRCARCH)/Makefil=
e until
> +# making sure include/config/auto.conf is up-to-date and include of conf=
ig.mk,
> +# because the architecture-specific Makefile may make use of variables d=
efined
> +# in config.mk. See also the comment about autoconf_is_old.
> =20
>  ifeq ($(dot-config),1)
>  ifeq ($(may-sync-config),1)

Since Fabio confirmed this fixes his issue, I'd like one or two more
tested-by's if I can before the end of the day when I'll apply this.
Thanks!

--=20
Tom

--fYsw9CpT5ffnMZ2V
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmhxIGgACgkQFHw5/5Y0
tyyIwQwAqQjhrbxJjJi1Q2H7/o9X0KD6iLFGksOCzgjEP6KnYkqtDI9O4k8JwsZM
9cxkK9x8Oaj/YQEtR4Rc7NqT0GAhuBGT+RCtgyWx9acY0UJz7JhWy7V1GZnxhPrg
+xHwXi9EOMdWR2q2WflkIhBC/cYzIfbdJt6mjQrBY/DtMaucaNb71OQI0SCzRpMM
UBWmdYGvFMb7MIKVs4LIsQJnhsdYgoiR4Z1PeLorOHxw8MUabTECnegwwtpvu4/2
s1W0oWW/nus3QVo7s+ZE96OaI8BlkOeiXehy/2V9jqd1yZP1mXkZK0GYRNzyuAYX
dis2nqwYWrkLU4s+0btuca9Ma4kYuCJCQ/srMhFKwj0MLBXdrxiJz6cM7jy0ub/E
yZ/DuwefAreR9RuMHZPUYoXd+4DpGGlHApVkhXlFhJTopFb/hAuLYgVTb74lkt9W
810AfpsLaylzZtKOPT17YInHfu6cyOJ9PHuqD2HWk9FMOqMpqOzmTYHDd4cFTOF4
Bsg9+ssI
=4Ghy
-----END PGP SIGNATURE-----

--fYsw9CpT5ffnMZ2V--
