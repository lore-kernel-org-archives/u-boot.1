Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CBBCC27C4F
	for <u-boot@archiver.kernel.org>; Tue, 18 Jun 2024 14:18:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E1B3188137;
	Tue, 18 Jun 2024 16:18:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="FI5jacGF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6371F88204; Tue, 18 Jun 2024 16:18:46 +0200 (CEST)
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com
 [IPv6:2607:f8b0:4864:20::22b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1EC168812C
 for <u-boot@lists.denx.de>; Tue, 18 Jun 2024 16:18:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22b.google.com with SMTP id
 5614622812f47-3c9b94951cfso3327699b6e.3
 for <u-boot@lists.denx.de>; Tue, 18 Jun 2024 07:18:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1718720323; x=1719325123; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=sYDdpZjKgRkzuBXxNTCxQ69ftsG8FB9czvXkbDu4TkY=;
 b=FI5jacGFsD82AcX8bNEEY49Tdz4yOnhLu1lTvOc5w7R05yLqP8jlh6hrR7XF8dk+MM
 GsiD6x4fo5LEJqxERIPJ8TRmVFvIt2QGhNmgswFiwyn912GDGGG4jvd6uAEwPviimkqK
 kNxJDAvocTdVxYL+bCJS4dFB4aELrjgSZ5YpM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718720323; x=1719325123;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sYDdpZjKgRkzuBXxNTCxQ69ftsG8FB9czvXkbDu4TkY=;
 b=NtCz5VpV/2/jlgLtXFWI+FmhuIVV42DRFliumEyCD9Faf6+0M2su9ZCTYWFscMi0RZ
 oLJMr4TD8JbHLF4Aa72/UqI2xi6eCXXrwLIrEdu4UP553Y1w3/3TyPOpZjMsoq8iJ8pI
 OFQwYdIotqF3/8qlaOv9G9Z5ktXzM4GlLU6VS0nbYccZaVZoSa5cNB3YI3fThNF1zkDc
 MN6pdn4D9RF7L4H4lFFYd/Sjox9R7aDawM9imMe0JHi8fzI/I67zYBAHSjyUmqJvSWaT
 gXW7AVHvNESVbudBH0t6q/oyttDU55fmcYJB26+qvC78HQxP2uxZy2VEowd2SdJHbsBD
 peSQ==
X-Gm-Message-State: AOJu0YwC9SIDnEMHgCtduwXWpVxXbkyxGWNxFUg2nX1KIbOikxjAf7/1
 RAlAByX5hbRmUueZtFbMzA0UzBdM8jq9gCJxVBkiCFBzBazxjOs/NrloqTnKewE=
X-Google-Smtp-Source: AGHT+IHndA5CcCbdDI1kmJNzQb/ukHc+zsPEeHWfpD2dO6wx3pIus5ILf27Y8F8TegpVN4UwJVAiqQ==
X-Received: by 2002:a05:6808:114b:b0:3d2:2833:73e6 with SMTP id
 5614622812f47-3d24e980c66mr13218409b6e.46.1718720322698; 
 Tue, 18 Jun 2024 07:18:42 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-205-45.totalplay.net.
 [187.190.205.45]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-3d2476e31d8sm1797918b6e.53.2024.06.18.07.18.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Jun 2024 07:18:41 -0700 (PDT)
Date: Tue, 18 Jun 2024 08:18:39 -0600
From: Tom Rini <trini@konsulko.com>
To: Michal Simek <michal.simek@amd.com>
Cc: u-boot@lists.denx.de, git@xilinx.com
Subject: Re: [PATCH] amd: versal2: Use U_BOOT_LONGHELP macro
Message-ID: <20240618141839.GP68077@bill-the-cat>
References: <9fc5f9c3d92a45f0603e6e912394655f42e96173.1718716595.git.michal.simek@amd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="LGcFcUWUN6O0A1qi"
Content-Disposition: inline
In-Reply-To: <9fc5f9c3d92a45f0603e6e912394655f42e96173.1718716595.git.michal.simek@amd.com>
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


--LGcFcUWUN6O0A1qi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 18, 2024 at 03:16:38PM +0200, Michal Simek wrote:

> It is defined as __maybe_unused variable which fix issue when long help is
> disabled.
>=20
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
>=20
>  board/amd/versal2/cmds.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>=20
> diff --git a/board/amd/versal2/cmds.c b/board/amd/versal2/cmds.c
> index fbd99918a7f4..56ae39bc6a1e 100644
> --- a/board/amd/versal2/cmds.c
> +++ b/board/amd/versal2/cmds.c
> @@ -71,10 +71,9 @@ static int do_versal2_load_pdi(struct cmd_tbl *cmdtp, =
int flag, int argc,
>  	return cmd_process_error(cmdtp, ret);
>  }
> =20
> -static char versal2_help_text[] =3D
> +U_BOOT_LONGHELP(versal2,
>  	"loadpdi addr len - Load pdi image\n"
> -	"load pdi image at ddr address 'addr' with pdi image size 'len'\n"
> -;
> +	"load pdi image at ddr address 'addr' with pdi image size 'len'\n");
> =20
>  U_BOOT_CMD_WITH_SUBCMDS(versal2, "Versal Gen 2 sub-system", versal2_help=
_text,
>  			U_BOOT_SUBCMD_MKENT(loadpdi, 3, 1,

Reviewed-by: Tom Rini <trini@konsulko.com>

Ah, any chance you can work up something to checkpatch to catch that? I
had gone through a while ago and fixed up the cases which should have
been using that macro but I see a few more have slipped in, again.


--=20
Tom

--LGcFcUWUN6O0A1qi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmZxlz8ACgkQFHw5/5Y0
tyzFcAv/d4X8w7E0bn+8DBeao6Bh3fG8alTOr+pjHWwz8NUfkCZjsrVChery53uk
iFpdhjD6b0sxMe9+pkU1N9JpM3MDRmwIhyGuCcxNUh15rGHybg3/Xpqis9YfVJUy
ABMZWVLdVx+N11soIyWFomECzxLgyuCImATxC/Q/kKSDJ9GFZ5bvq/abksYR+nFO
XON5pyYQtN6aHIyLLhM72Yn7pxs0m0L40Q7QMMB+5i0bd+i7OrN3M3Zhmtlk2mmA
AKlpyyoA2y846KzCV2tX0/zAVA6JCnSJtyxU6uyyRIB3hxIP5J0DlKoZykRAWvPC
e2aDdUwhueatHKxz5xdKowJrGftBefs06DGImUh70y4ZUmspTQG6zh7zffnGeEqH
B5VS4bcZESVy0quq+98St3sSXyi97nDf7BgwcTCq790kNEXK5tr/YEWVUOxM5HXh
3M6WZwqbcPfGTu6a/MYBhxg2rx9wHpEPB4MnZsWAdaQ0H16A1PNXo/NhNq7ggbtx
AI+nD71n
=pljm
-----END PGP SIGNATURE-----

--LGcFcUWUN6O0A1qi--
