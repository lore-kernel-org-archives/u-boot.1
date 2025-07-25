Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F58BC87FCE
	for <u-boot@archiver.kernel.org>; Fri, 25 Jul 2025 14:31:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 68D53839AF;
	Fri, 25 Jul 2025 16:31:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="qewvWsxR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 072C9839B5; Fri, 25 Jul 2025 16:31:14 +0200 (CEST)
Received: from mail-oa1-x33.google.com (mail-oa1-x33.google.com
 [IPv6:2001:4860:4864:20::33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7C15F839A1
 for <u-boot@lists.denx.de>; Fri, 25 Jul 2025 16:31:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x33.google.com with SMTP id
 586e51a60fabf-3005517e7d0so594894fac.0
 for <u-boot@lists.denx.de>; Fri, 25 Jul 2025 07:31:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1753453870; x=1754058670; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=PWPtAptNIEolGbZm1uezY9j81zXhj7JDBJ7PK610mxA=;
 b=qewvWsxRvde2ywaiAM7MB4JXAMHSOjxmaPV2SqPWwytgCy352BSLCvrjXq4rKLmpVR
 3wXo5tMHf7KGgqveOB2X2CQWWBRv5+A5QBTyPdxcHAPA9kiSyR3majil2H86M2IC6sOs
 dHxA04be4tPeIFC8VA9UW4Tqedji+oCGpJ7Rg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753453870; x=1754058670;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PWPtAptNIEolGbZm1uezY9j81zXhj7JDBJ7PK610mxA=;
 b=o9d0m9AQf9tQ1ByEmBBewywH5+/HaW2Tgjw0oskonZgEt1sSiYP5NxKge5Zxuev1Nv
 0CQPGTgKxZ24TXWgTNdy2KLbXQ+BRNXikrq8RJ/AoY7c5Nj3Q99d3445bHyVvlTJifJA
 K2JKkL0xF5DMkGddBFn3KXdh4nqcLqZVUNvdVkqkqSXBSHw1taICmufExOF6ToDCejqz
 n3g0D9KEjQ/pX78r9TQGoGOP+BOxt2OLUpGW1x5yayoGHg2bDScskN1mNvEq/dXJ3kNK
 WY8llLgNEyudbKTBT/Ehmk+AwW7dMzhtRxkCR6pAj43IdSERWGfO77KZ+WG+zifr29NA
 2Dag==
X-Forwarded-Encrypted: i=1;
 AJvYcCWYaj+efmfweXKI92542TYkh+0N1rtP9GJUPjLHMEyKTdLUPKIKLjLwV9d0HD+liPK2YgM0RyI=@lists.denx.de
X-Gm-Message-State: AOJu0YyUFLf7xwhIiNMaQTiCqoG38eeR1NfHhchmuIiC4GFqlq+6ec6O
 PS+q7nI/iMObuBMOKWGe3tuyaLmpRZ0Brt61t8aBFrAoK73VD1hZ8hom566B+OUoCCU=
X-Gm-Gg: ASbGncsnN/+0TuTRss2VY7jQCoxLM6OKH7wgmND010a7BR562pQ8Q/MIm0q3adV67p1
 eY/OgLo36DMzTXQptv+f1+PPb+8Q1I6TtljzBCp+v3+mwyrQvUc1G26wi08YX6KoBO8BccdqVm1
 ALoX65sQ+bgqMOTKTj/JRoEtcUMD2IDx8lWcaxMR/gN1ZbFzdW/We9ZB0fpEeTcsJyMHCJBtqGW
 3U683sKRbxZqebLxnJnAKPA7e8YT0DLWvkjKGc80mU7f+U02IehO/XFoTBxKqGoxG3qPd4E43Hv
 poQOwsn1MzwR0pQrPTn41dGxXim/C/xXPhtHTBlk6SoBl747Ii5r8BICIQhTEa4QcGSOSXtmdPM
 rVvCEt7usRp7TNRHlpwNtbCp+0m5GgM57FvpnJ+6YjPp6jP7AO08M9iA1
X-Google-Smtp-Source: AGHT+IEQU7fUCda2SnbPNZBK3xdBIUUJSj/E4L2g3jdKQcZA2cq8uJMs6gWZRWtMUpnpJ0+HKhLMQg==
X-Received: by 2002:a05:6870:b41b:b0:2ff:a87d:5c71 with SMTP id
 586e51a60fabf-3070209d4dfmr1309634fac.33.1753453870026; 
 Fri, 25 Jul 2025 07:31:10 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-306e1f7b0e7sm1092578fac.40.2025.07.25.07.31.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Jul 2025 07:31:09 -0700 (PDT)
Date: Fri, 25 Jul 2025 08:31:07 -0600
From: Tom Rini <trini@konsulko.com>
To: Michal Simek <michal.simek@amd.com>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, git@xilinx.com,
 u-boot@lists.denx.de
Subject: Re: [PATCH] exception: Add missing string.h
Message-ID: <20250725143107.GE1807455@bill-the-cat>
References: <e9b3fd74e233ea783e64fe1d1c3de5d4f3c6610c.1753447310.git.michal.simek@amd.com>
 <a745fa32-44cc-4671-811f-c9eae8a092e7@gmx.de>
 <7aaba571-eb98-4e54-a11e-2cd05a1cc035@amd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="t9m/Z739LTj52h48"
Content-Disposition: inline
In-Reply-To: <7aaba571-eb98-4e54-a11e-2cd05a1cc035@amd.com>
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


--t9m/Z739LTj52h48
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 25, 2025 at 03:29:27PM +0200, Michal Simek wrote:
>=20
>=20
> On 7/25/25 14:46, Heinrich Schuchardt wrote:
> > On 25.07.25 14:41, Michal Simek wrote:
> > > The commit 1e50f7457fca ("include/command.h: Drop <env.h>") removed e=
nv.h
> > > which also included string.h which generate compilation error.
> > > But because none is enabling CMD_EXCEPTION it by default it hasn't be=
en
> > > spot.
> > >=20
> > > Signed-off-by: Michal Simek <michal.simek@amd.com>
> > > ---
> > >=20
> > > =A0=A0 CC=A0=A0=A0=A0=A0 drivers/mtd/mtd-uclass.o
> > > In file included from cmd/riscv/exception.c:91:
> > > include/exception.h: In function 'exception_complete':
> > > include/exception.h:41:23: error: implicit declaration of function
> > > 'strlen' [- Wimplicit-function-declaration]
> > > =A0=A0=A0 41 |=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 len =
=3D strlen(argv[1]);
> > > =A0=A0=A0=A0=A0=A0 |=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 ^~~~~~
> > > include/exception.h:1:1: note: 'strlen' is defined in header
> > > '<string.h>'; this is probably fixable by adding '#include
> > > <string.h>'
> > > =A0=A0 +++ |+#include <string.h>
> > > =A0=A0=A0=A0 1 | /* SPDX-License-Identifier: GPL-2.0+ */
> > > include/exception.h:49:22: error: implicit declaration of function
> > > 'strncmp' [-Wimplicit-function-declaration]
> > > =A0=A0=A0 49 |=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (!s=
trncmp(argv[1], cmdtp->name, len))
> > > =A0=A0=A0=A0=A0=A0 |=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 ^~~~~~~
> > > include/exception.h:49:22: note: 'strncmp' is defined in header
> > > '<string.h>'; this is probably fixable by adding '#include
> > > <string.h>'
> > > make[2]: *** [scripts/Makefile.build:297: cmd/riscv/exception.o] Erro=
r 1
> > > make[2]: *** Waiting for unfinished jobs....
> > > =A0=A0 CC=A0=A0=A0=A0=A0 drivers/serial/serial-uclass.o
> > >=20
> > > ---
> > > =A0 include/exception.h | 1 +
> > > =A0 1 file changed, 1 insertion(+)
> > >=20
> > > diff --git a/include/exception.h b/include/exception.h
> > > index a7f21e73d753..0d4dff49954b 100644
> > > --- a/include/exception.h
> > > +++ b/include/exception.h
> > > @@ -6,6 +6,7 @@
> > > =A0=A0 */
> > > =A0 #include <command.h>
> > > +#include <string.h>
> > > =A0 static int do_exception(struct cmd_tbl *cmdtp, int flag, int argc,
> > > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 char *const argv[])
> >=20
> > This patch just looks like
> > https://patchwork.ozlabs.org/project/uboot/patch/20250702205818.44188-1-
> > heinrich.schuchardt@canonical.com/
> > and
> > https://patchwork.ozlabs.org/project/uboot/patch/20250703051951.43372-2-
> > heinrich.schuchardt@canonical.com/
> > which were positively reviewed.
> >=20
> > Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
>=20
> yes it is the same.
>=20
> Tom: Please drop this one and take origin one

OK. If it's not ugent, it will come with v2 of the arm64 stack
backtraces that Casey posted today, once that's ready to merge.

--=20
Tom

--t9m/Z739LTj52h48
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaIOVIwAKCRAr4qD1Cr/k
CsIaAQDArLgwlS7H88UedjnHuUkR9MBDiPO4x/uR3B5j3KCR2gEA8PqpwP30SU6J
BEMREQypRLIt904IsAK/ty2zcueFkQo=
=+zbJ
-----END PGP SIGNATURE-----

--t9m/Z739LTj52h48--
