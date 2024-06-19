Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7520C27C79
	for <u-boot@archiver.kernel.org>; Wed, 19 Jun 2024 16:15:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2B7AC8845A;
	Wed, 19 Jun 2024 18:15:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="g1BgfxQ4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 618F0882DC; Wed, 19 Jun 2024 18:15:51 +0200 (CEST)
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com
 [IPv6:2607:f8b0:4864:20::22e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 34C138845A
 for <u-boot@lists.denx.de>; Wed, 19 Jun 2024 18:15:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22e.google.com with SMTP id
 5614622812f47-3d21c4eec2dso3525109b6e.1
 for <u-boot@lists.denx.de>; Wed, 19 Jun 2024 09:15:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1718813748; x=1719418548; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=CjleHSajRGpE6Ka5CbkQnqpVVvesEfLFQ15xWMJGGrY=;
 b=g1BgfxQ4EVAaXsLdqxHv5O+hRBsdbb9wUp/BwuuTf8UFDfM7lWNiwKdrR78Xl9Scar
 abgDM73FaPO6BixbiUhnYitKKNTCpR2U4lf42Ewr5oHRJkKKuWNd2CICj1UTTRC9l8DR
 cuyMzWn/7GKKJpUxvQkSHVLUdIikCE0mgG0ZE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718813748; x=1719418548;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CjleHSajRGpE6Ka5CbkQnqpVVvesEfLFQ15xWMJGGrY=;
 b=SCrjxTxbrLnROL1WzRPBQXwdVpxEEGkNEE1LrwnpYiPvJpRmYfS8QpwmvwDt1tRDqr
 l1s0sLc1Kgfi8xsJnLfXMjOvYnhk9qSl5MLTBkFg7KsYQUxl33afCLmr2xiKw53J+BlO
 TFSGcCjNEYsn7ZDPI44QJUb1X6uRoGMz+lf8ADEPCIJcew2kviyBwDK19xlkmTb6ysL0
 PGci8nRjXstq0hwG5f5o/cXIUQC1T33UqqD7EfJ4gMcTIcn/MKLHabH9KquETGKPvFn3
 NThMR0eScK7nR0b1GhTtdWcaQxILozY+JD/P1IIklCDkIThCjntQi1dD7o0VG/vO9d2d
 VSbg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWcLDeg29cVgnLUtKc0ga7/nrPRXoSp2Yh1+CXvF8cJRiciEayYWXaRDkgV/3XLhg890XAvH/QQkbLzWl+MDkFQpVBPLQ==
X-Gm-Message-State: AOJu0YxDI9CXJMtNQuxbu3hwAdd1aA49gx+UDSZJff9ykKPyVETL17PZ
 S3/YF3m2KgNsRMrq48QDE1/e5FPEb3wTFM6PIDz8I2a80BOARZv0fvTJSedrQXA=
X-Google-Smtp-Source: AGHT+IHcm3VX2Qx5Kt4aFHxwsW41G6+71L95G1mlX9aL8nYgXlthmj0Ocr1MZjiav64Y+W6unnI3/w==
X-Received: by 2002:a05:6808:2102:b0:3d2:14b5:adf8 with SMTP id
 5614622812f47-3d51b966425mr3687107b6e.5.1718813746301; 
 Wed, 19 Jun 2024 09:15:46 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-205-45.totalplay.net.
 [187.190.205.45]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-3d247630087sm2162611b6e.26.2024.06.19.09.15.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Jun 2024 09:15:45 -0700 (PDT)
Date: Wed, 19 Jun 2024 10:15:43 -0600
From: Tom Rini <trini@konsulko.com>
To: Michal Simek <monstr@monstr.eu>
Cc: Michal Simek <michal.simek@amd.com>, u-boot@lists.denx.de
Subject: Re: [PATCH] cmd: Make use of U_BOOT_LONGHELP when missing
Message-ID: <20240619161543.GG68077@bill-the-cat>
References: <20240618174516.3320193-1-trini@konsulko.com>
 <CAHTX3d+ovc79DW=gquPpN63Bs2Qzd8E7aj6TP0Fb75aUH=LQ8A@mail.gmail.com>
 <20240619145009.GY68077@bill-the-cat>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="8Z2HXnI2ZmZWnYS4"
Content-Disposition: inline
In-Reply-To: <20240619145009.GY68077@bill-the-cat>
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


--8Z2HXnI2ZmZWnYS4
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 19, 2024 at 08:50:09AM -0600, Tom Rini wrote:
> On Wed, Jun 19, 2024 at 08:15:04AM +0200, Michal Simek wrote:
> > =FAt 18. 6. 2024 v 19:45 odes=EDlatel Tom Rini <trini@konsulko.com> nap=
sal:
> > >
> > > After adding the U_BOOT_LONGHELP macro some new commands came in still
> > > that were not making use if it. Switch these cases over and in a few
> > > places add missing newlines as well.
> > >
> > > Signed-off-by: Tom Rini <trini@konsulko.com>
> > > ---
> > >  arch/arm/mach-imx/cmd_dek.c                |  4 ++--
> > >  arch/arm/mach-imx/cmd_mfgprot.c            |  4 ++--
> > >  arch/arm/mach-imx/imx8/snvs_security_sc.c  | 16 ++++++++--------
> > >  arch/arm/mach-stm32mp/cmd_stm32key.c       |  4 ++--
> > >  board/freescale/common/cmd_esbc_validate.c |  4 ++--
> > >  board/kontron/sl28/cmds.c                  |  4 ++--
> > >  cmd/adc.c                                  |  4 ++--
> > >  cmd/arm/exception.c                        |  5 ++---
> > >  cmd/arm/exception64.c                      |  5 ++---
> > >  cmd/blob.c                                 |  4 ++--
> > >  cmd/riscv/exception.c                      |  5 ++---
> > >  cmd/scmi.c                                 |  5 ++---
> > >  cmd/x86/exception.c                        |  5 ++---
> > >  13 files changed, 32 insertions(+), 37 deletions(-)
> [snip]
> > arch/arm/mach-imx/imx8/snvs_security_sc.c:781:static char
> > snvs_sec_status_help_text[] =3D
>=20
> I missed this one for some reason, yeah.
>=20
> > board/xilinx/versal-net/cmds.c:74:static char versalnet_help_text[] =3D
> >=20
> > These two should also be part of this patch.
>=20
> OK.
>=20
> > And this one is interesting.
> > cmd/cli.c:122:static char cli_help_text[] =3D
> >=20
> > it is guarded by SYS_LONGHELP but I think it should be just removed
> > and macro should be used instead.
> >=20
> > #if CONFIG_IS_ENABLED(SYS_LONGHELP)
> > static char cli_help_text[] =3D
> >         "get - print current cli\n"
> >         "set - set the current cli, possible value are: old, modern"
> >         ;
> > #endif
> >=20
> > U_BOOT_CMD(cli, 3, 1, do_cli,
> >            "cli",
> > #if CONFIG_IS_ENABLED(SYS_LONGHELP)
> >            cli_help_text
> > #endif
> > );
>=20
> This one is actually kind of "funny". I know I changed it to that,
> rather than using the macro like everything else, when I first did the
> conversion as there was some sort of odd build failure introduced. I'll
> go and see if it still fails somewhere.

Welp, world build passed, and sandbox with and without LONGHELP set
passed, so, either I made a mistake back originally or something else
changed and it's fine now.

--=20
Tom

--8Z2HXnI2ZmZWnYS4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmZzBCkACgkQFHw5/5Y0
tyx3oQv/ULpUqZ5uL5oZ65YbhWoDo94DBxzVjO/V1UUVRS6IagU8dglExTnfPexj
cJhXiR9G2DvGVcanBcPNb5VBm8I67sujb/Tr/C41rBLKmh/0esYJ2VgW+EJeRMS2
4ps9wSTzUhSA9YjMfMJTSpu3AW+8PKc5JtuwCWEDawL5KeZn0MtArL4tn9S0UMnX
mQCL7KnCeIe8cnFVPMVfVosPwQSQZtnBgGltddJmQZkgxxHrgih502IyUCsODT3O
Gt3AqCRZF0Wo68TWoc6LGskUvjDTsdgNTlLg/fQPhaNvK9LfeE2rhmaL9VMLZWzn
6ijrbxS4cx7A2VJSbUtXjRMTkdo8TPeYr/4xwA13V7bnv7f/UcC6XQtD97ulbMjh
mF7YEPlWQYmpUiOJwH56sE4NXMxQgj5sArqFgvbRsU5jzbfwjvKzjXJWeH55q51o
QuL748sTTrZA71hxrStG1/XzV1U/lYrI8ZvXjjegX/HtFujZVYDEH1YeIt7+rrVD
bV34NEDn
=czKa
-----END PGP SIGNATURE-----

--8Z2HXnI2ZmZWnYS4--
