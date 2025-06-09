Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 338C8C61CE8
	for <u-boot@archiver.kernel.org>; Mon,  9 Jun 2025 14:56:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9596A8144A;
	Mon,  9 Jun 2025 16:56:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="pcb/mBv/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E0D0B826AA; Mon,  9 Jun 2025 16:56:19 +0200 (CEST)
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com
 [IPv6:2607:f8b0:4864:20::22b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B32FA811AC
 for <u-boot@lists.denx.de>; Mon,  9 Jun 2025 16:56:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22b.google.com with SMTP id
 5614622812f47-406e31162c6so1234055b6e.2
 for <u-boot@lists.denx.de>; Mon, 09 Jun 2025 07:56:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1749480976; x=1750085776; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=DvwCgG9u7fFuaxpALkduY4iZXkPhKXYqi74BariHHCc=;
 b=pcb/mBv/g03nr71poO0UnucwsAKoxcFPXw+R4QQk17TXPCMovcj/TqqaZWSUvRzzE9
 726UcNWw8BpNR47kvkBTlhIdHdyY4VXhNPKcdxvBlxI1yn051ySQ02Z+7cN0tdLNSJtB
 L9uJvqzCwsKUVwRIH05OEhyabYB438NvGLFj0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749480976; x=1750085776;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DvwCgG9u7fFuaxpALkduY4iZXkPhKXYqi74BariHHCc=;
 b=AiGrFL+sGBEK1qnwEzggo/c0PXpqMzw2Qo69BY5UsB5y/oBxJ6I+nNna6IZbeJOC91
 zeyDByohdRbaRWsePZ+qWYem+tEZ/muBVGG32+0jSBuWn93F98U2ngWYqh4YiQc46Nwe
 6noR2hsotNY3mfWC0V4NVLwgaFRz0tU/MWLgmdJy2J4aer+6IpEM1oNqpuwiA15QQjhe
 l7AIXwvkk2/+/NL/D6y9kkTxYaa5xoiAcXKa4X3LQiVZC5sJ5ePncUM447COE7299T1L
 sKQJlynwCzuqKKSPy47nawdjY/Zmc5NuxAOv1jbTV32A0pr+QVrVz5HaXkBB77ZsFRH7
 BKqg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUF9Zj9mIJt+9mNwuw/VJU0v6gWsCrwYoL8mqmf9dgb3FEcnL6ns7KawDbmrBmFOSHZ/Kr3WMA=@lists.denx.de
X-Gm-Message-State: AOJu0Yw40BxUGRBSG+eEBv/I/9oo1FvSzddfvgyGi6lotg3AIPQRZyq5
 vG5o7EjMvmMQUxxQo0PnWq22L+t5RTYSQq0na0lpldsNwDgUTJPGawr1jWHRY0nBrjs=
X-Gm-Gg: ASbGncu69scasrB5eNZt9F1G1YBMgY4NWws+Zjl0OtkSZFveXba+njOF/PsoAXB5pjI
 0Bb3YyZ0Xztfqd9fhhpJ4bPUuVq6fwGf38YkEelM4xr1rDl0TreVKG9GvPxAH9W5sm8Y+ongoux
 pk6GhgMrsSrpqHvmAc08cceKcxNCmHMNT+wYMu/tk6w/JWABsdH88mouzZgB8lgs+MTEKfg1+x5
 wCLstfXf/5UaDZEgwoSQN2TTEbzv7VpGXHLexkUnaTl6Rpz28EUK5zVCAHE6a1g9YUdqPx23Cl5
 Ey5YRm5HNUxKAxkAfvPW6CUu3Mj850FGDaR15OD0EoGXYNQxdzO5nYyRzqRailHophCpTXPKq/x
 ECmxLItkygK+e
X-Google-Smtp-Source: AGHT+IE6QMP5gpeaPZJG9K3NqLCYuDtrM12SpNPk8mlrnn3NPjZU/JnGHv1/KVsp1pWKFLynU/dmKg==
X-Received: by 2002:a05:6808:1b1f:b0:40a:52e5:37bc with SMTP id
 5614622812f47-40a52e53d1dmr733322b6e.31.1749480976360; 
 Mon, 09 Jun 2025 07:56:16 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-40a53b5d277sm12171b6e.42.2025.06.09.07.56.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Jun 2025 07:56:15 -0700 (PDT)
Date: Mon, 9 Jun 2025 08:56:10 -0600
From: Tom Rini <trini@konsulko.com>
To: Anshul Dalal <anshuld@ti.com>
Cc: Eric Schikschneit <eric.schikschneit@novatechautomation.com>,
 u-boot@lists.denx.de
Subject: Re: [PATCH] dtc: Add Kconfig option to pad device tree blob
Message-ID: <20250609145610.GK1382132@bill-the-cat>
References: <20250603170624.93376-1-eric.schikschneit@novatechautomation.com>
 <DAHUYGE5YBJM.2DQMLH5VCAPKX@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="aqAiR3EvV7rX36Pr"
Content-Disposition: inline
In-Reply-To: <DAHUYGE5YBJM.2DQMLH5VCAPKX@ti.com>
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


--aqAiR3EvV7rX36Pr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 09, 2025 at 01:56:26PM +0530, Anshul Dalal wrote:
> On Tue Jun 3, 2025 at 10:36 PM IST, Eric Schikschneit wrote:
> > This will allow arch(s) that use device tree blobs to pad the end of the
> > device tree so they can be modified by board files at run time. This wi=
ll
> > help prevent errors such as FDT_ERR_NOSPACE from occuring.
> >
> > Signed-off-by: Eric Schikschneit <eric.schikschneit@novatechautomation.=
com>
> > ---
> >  arch/Kconfig                    | 7 +++++++
> >  arch/arc/dts/Makefile           | 2 +-
> >  arch/m68k/dts/Makefile          | 2 +-
> >  arch/microblaze/dts/Makefile    | 2 +-
> >  arch/nios2/dts/Makefile         | 2 +-
> >  arch/riscv/dts/Makefile         | 2 +-
> >  arch/sandbox/dts/Makefile       | 2 +-
> >  arch/x86/dts/Makefile           | 2 +-
> >  doc/board/broadcom/bcm7xxx.rst  | 6 ++----
> >  doc/develop/makefiles.rst       | 5 ++++-
> >  dts/upstream/src/arm64/Makefile | 2 +-
> >  dts/upstream/src/riscv/Makefile | 2 +-
> >  scripts/Makefile.dts            | 4 ++++
> >  13 files changed, 26 insertions(+), 14 deletions(-)
> >
> > diff --git a/arch/Kconfig b/arch/Kconfig
> > index ea33d07c086..bf4c2c80891 100644
> > --- a/arch/Kconfig
> > +++ b/arch/Kconfig
> > @@ -63,6 +63,13 @@ config SYS_CACHELINE_SIZE
> >  	default 64 if RISCV
> >  	default 32 if MIPS
> > =20
> > +config SYS_DTC_PAD_BYTES
> > +	int "Size in bytes to pad device tree blob"
> > +	default 4096 if ARC || ARM64 || M68K || MICROBLAZE || NIOS2 \
> > +		|| RISCV || SANDBOX || X86
> > +	default 32768 if X86 && EFI_APP
> > +	default 0
> > +
> >  config LINKER_LIST_ALIGN
> >  	int
> >  	default 32 if SANDBOX
> > diff --git a/arch/arc/dts/Makefile b/arch/arc/dts/Makefile
> > index fe6ad7b849a..87c627c01c8 100644
> > --- a/arch/arc/dts/Makefile
> > +++ b/arch/arc/dts/Makefile
> > @@ -11,4 +11,4 @@ dtb-$(CONFIG_TARGET_IOT_DEVKIT) +=3D  iot_devkit.dtb
> >  include $(srctree)/scripts/Makefile.dts
> > =20
> >  # Add any required device tree compiler flags here
> > -DTC_FLAGS +=3D -R 4 -p 0x1000
> > +DTC_FLAGS +=3D -R 4
>=20
> Thanks for the patch Eric, the changes to padding size look good to me
> although I wonder if we should expose the -R flag for configuring the
> number of /reserved-memory to user under Kconfig as well.
>=20
> We have it hardcoded to 4 everywhere now, might be useful to expose it
> as CONFIG_SYS_DTC_RSVD or similar for users looking to create compact
> DTBs (-R 0) or where more reserved regions need to be added at runtime.

That could be an interesting follow-up patch, yes.

--=20
Tom

--aqAiR3EvV7rX36Pr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmhG9gYACgkQFHw5/5Y0
tywHQQv+Ln/Bm9RuPdGHknvJ5ifVGCYyZQnse1EjSe1Uuxm9z+ZIGtVZc3a+AaHC
Q35F9iX8ZMaFRLlG51zQ+13kUHskg4Yqial2yg32owmZv6TA4uHxtD5YGzLICRDR
UhT5b+YeoYh3FF4X0VOyGe7qkKmeB27KkOM6+sdAAmpaKVe2VtHHZ+2cuDDZ6D3V
kWCN/C/XLCk/qGZIH19QtmuNMGZR2mwDxLy3UlIVYP5ErO0VB8hW//FMDC9x4/Yk
GNWcGUr5qwCGxY+Uf4B6RcmX/BA9cowXc7+1VMu+GjoyEbPz9k2PNNH6BZ2AvctG
GYgUgMc8EsB95oocj9ZrO2JsMlG/F+pjJ96foUN4CxXlYzpsghUaIWeQoPnxquNt
cBLrxRu34qJfqgy37fQFHUmEztWdIOkzAPVe6VGmurSsAZjDSSz9S65qc/cajpJY
ZFDAPD6tvDeCvS4lJfa2aNOi/ZG67yHmIuNbtoxns7N71vbXTfqep0CP9bwGGWCW
bA19T9oo
=iE7F
-----END PGP SIGNATURE-----

--aqAiR3EvV7rX36Pr--
