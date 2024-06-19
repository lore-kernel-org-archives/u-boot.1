Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA9E6C27C53
	for <u-boot@archiver.kernel.org>; Wed, 19 Jun 2024 14:50:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 28E218844C;
	Wed, 19 Jun 2024 16:50:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="axLvKgZs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D321D8844F; Wed, 19 Jun 2024 16:50:15 +0200 (CEST)
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com
 [IPv6:2607:f8b0:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A0DB18836D
 for <u-boot@lists.denx.de>; Wed, 19 Jun 2024 16:50:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x333.google.com with SMTP id
 46e09a7af769-6f9ca219760so3738525a34.2
 for <u-boot@lists.denx.de>; Wed, 19 Jun 2024 07:50:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1718808612; x=1719413412; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=YIEL6MMLqGeMr7EazggIXvfdeW+sYBJUjexesPmQM8U=;
 b=axLvKgZsixKzMtN1I+2byXIg4JhKi27gTN28J6uGEd4Kv9wbhfbnROoVN9WjojXZ51
 OZfyFcP33OK1ylv53+iqZhGPYZWbYD4k5KvAN1dPZuLOUM2vz9W2H/NTL6phZ2wFzIWE
 Ye4hxsUCnjQ29xxtAk39k0euuDalyUlMtAdzs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718808612; x=1719413412;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YIEL6MMLqGeMr7EazggIXvfdeW+sYBJUjexesPmQM8U=;
 b=OHnCCHkpQFVkctVsNeiA9b6I3SBSqIa+gZ85SOvAdIB+azepR/t2ocHZM5d2PSP2YY
 SAkcJBQM++9yG+a1WnE2rACmfqgVS5AOq5zRJZrKaFkN3tN6o3ZhgjSE3ZgWWr/Cst3L
 d46udgvMPkzNo+PfwTsUH6H7XfLaKA4jRIshtKFtsjE2Su+Ocl6MHRNmnTQ8zVnLT+0t
 J3kCSadir8X2oSk+2N5SQ4utkcz1rifqwUI+YxU3pSMu/CK0wMeeFywnxGSpJ1t5QuYs
 5/lxfXARV9IHp22hJpFaIAsX43uz75LYoYk0uHOcOpYBugoIux/XRpSv/vR7hG8iFF9j
 n2pw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUB6YqwP4tcGY61IGenaDYM9muIhP8AuJPac++F6NCdJcrWgGYUidp+CsHZIErZ6aAO+fD+go47iIBpZkK6MFJfk34MWQ==
X-Gm-Message-State: AOJu0Yyh3avVnt672dCl2eRPHZj0Tv+Z5Xe9vUC4RzPS2v4U3Ari/6nr
 MT5Xtb61ZkasMjFsz/jC0eRtV1AQ1yC4KcP5U4+urcpEAJsi57M7Lg4VOG8DKto=
X-Google-Smtp-Source: AGHT+IF3cOa2YiujuGNAeeUVKbPIFCGMXA1uDj322Z69lHs/fhc8D77nLUp0flvaJTOoM3ggEyRQlw==
X-Received: by 2002:a9d:63d8:0:b0:6f9:6931:89ef with SMTP id
 46e09a7af769-7007365b72cmr2974795a34.2.1718808612273; 
 Wed, 19 Jun 2024 07:50:12 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-205-45.totalplay.net.
 [187.190.205.45]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-6ff2cfb7be8sm625122a34.54.2024.06.19.07.50.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Jun 2024 07:50:11 -0700 (PDT)
Date: Wed, 19 Jun 2024 08:50:09 -0600
From: Tom Rini <trini@konsulko.com>
To: Michal Simek <monstr@monstr.eu>
Cc: Michal Simek <michal.simek@amd.com>, u-boot@lists.denx.de
Subject: Re: [PATCH] cmd: Make use of U_BOOT_LONGHELP when missing
Message-ID: <20240619145009.GY68077@bill-the-cat>
References: <20240618174516.3320193-1-trini@konsulko.com>
 <CAHTX3d+ovc79DW=gquPpN63Bs2Qzd8E7aj6TP0Fb75aUH=LQ8A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="24iHJmCrsOq3ww5y"
Content-Disposition: inline
In-Reply-To: <CAHTX3d+ovc79DW=gquPpN63Bs2Qzd8E7aj6TP0Fb75aUH=LQ8A@mail.gmail.com>
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


--24iHJmCrsOq3ww5y
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 19, 2024 at 08:15:04AM +0200, Michal Simek wrote:
> =FAt 18. 6. 2024 v 19:45 odes=EDlatel Tom Rini <trini@konsulko.com> napsa=
l:
> >
> > After adding the U_BOOT_LONGHELP macro some new commands came in still
> > that were not making use if it. Switch these cases over and in a few
> > places add missing newlines as well.
> >
> > Signed-off-by: Tom Rini <trini@konsulko.com>
> > ---
> >  arch/arm/mach-imx/cmd_dek.c                |  4 ++--
> >  arch/arm/mach-imx/cmd_mfgprot.c            |  4 ++--
> >  arch/arm/mach-imx/imx8/snvs_security_sc.c  | 16 ++++++++--------
> >  arch/arm/mach-stm32mp/cmd_stm32key.c       |  4 ++--
> >  board/freescale/common/cmd_esbc_validate.c |  4 ++--
> >  board/kontron/sl28/cmds.c                  |  4 ++--
> >  cmd/adc.c                                  |  4 ++--
> >  cmd/arm/exception.c                        |  5 ++---
> >  cmd/arm/exception64.c                      |  5 ++---
> >  cmd/blob.c                                 |  4 ++--
> >  cmd/riscv/exception.c                      |  5 ++---
> >  cmd/scmi.c                                 |  5 ++---
> >  cmd/x86/exception.c                        |  5 ++---
> >  13 files changed, 32 insertions(+), 37 deletions(-)
[snip]
> arch/arm/mach-imx/imx8/snvs_security_sc.c:781:static char
> snvs_sec_status_help_text[] =3D

I missed this one for some reason, yeah.

> board/xilinx/versal-net/cmds.c:74:static char versalnet_help_text[] =3D
>=20
> These two should also be part of this patch.

OK.

> And this one is interesting.
> cmd/cli.c:122:static char cli_help_text[] =3D
>=20
> it is guarded by SYS_LONGHELP but I think it should be just removed
> and macro should be used instead.
>=20
> #if CONFIG_IS_ENABLED(SYS_LONGHELP)
> static char cli_help_text[] =3D
>         "get - print current cli\n"
>         "set - set the current cli, possible value are: old, modern"
>         ;
> #endif
>=20
> U_BOOT_CMD(cli, 3, 1, do_cli,
>            "cli",
> #if CONFIG_IS_ENABLED(SYS_LONGHELP)
>            cli_help_text
> #endif
> );

This one is actually kind of "funny". I know I changed it to that,
rather than using the macro like everything else, when I first did the
conversion as there was some sort of odd build failure introduced. I'll
go and see if it still fails somewhere.

--=20
Tom

--24iHJmCrsOq3ww5y
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmZy8CEACgkQFHw5/5Y0
tywC0gwAgUeI9H623tZpf33QDvB9R1lsgxK+S5zuKuEKGEml22phzycniVHK4f3T
Nvzm44WuFmSBl6vBWbp3R7bIul7aklUEidXOkJHITaXjZ4L0Kf5bUMWgPVn9aJJK
rO4iLrb3FZX64AEtibqXmBICIBSORaIH55vL7HKcW0lN8y8Z/eIBHAVCXZPOQuAh
p0SpL2HDt+LL8g6fSMNLRQCi8pVM2yMFWojBERWFhIICp9GZ7/JOkCvF4RrCXXht
O3KLT3qGGoBjwTvOIDLDXcfdRnrqh4/12/8NDqOz7gVqqahqCyuQ6i3QQj6rxzdI
x5+wKgFeIEbj7O3zHjQ+++WGa1HtX2uwfxk+SaUJ7YB2Lj+XsFwCB9Q5b+XUFgAl
V9gAuQwINF81D2AKutuqFhA1fQ4aPqH9F8EERyg2iagZLK2jNz+zbLdSXLdvJZro
EIkPR5tMWvH+r9TTQuUUR30tA89LPK9bfeBTIhLRWTO811zxMIrGuUQE6UAa/6e1
deCI/PTv
=N/G4
-----END PGP SIGNATURE-----

--24iHJmCrsOq3ww5y--
