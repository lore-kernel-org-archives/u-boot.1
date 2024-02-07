Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85A1DC4828D
	for <u-boot@archiver.kernel.org>; Wed,  7 Feb 2024 15:45:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C58B587CF9;
	Wed,  7 Feb 2024 16:44:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="uu6F/2Xk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 419BE87B05; Wed,  7 Feb 2024 16:44:54 +0100 (CET)
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com
 [IPv6:2607:f8b0:4864:20::72f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4C95487CF6
 for <u-boot@lists.denx.de>; Wed,  7 Feb 2024 16:44:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72f.google.com with SMTP id
 af79cd13be357-785388b3281so32721585a.2
 for <u-boot@lists.denx.de>; Wed, 07 Feb 2024 07:44:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1707320691; x=1707925491; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=SVAZFV86HDNc2iYlpB8wN8UR+0B5gH3W7zXV/e7ixxc=;
 b=uu6F/2XkX3ciu62fUwGQJwaN4f7J/IqJNLj4p6lqNJMNsygFU+fZdqq/LsswBR41XP
 0SV/hzIiDIw7Fc06KSHjzeEfGDEaahTdLHYfItilrnE1nlqPuVhGVyorRw2In0rk6HtJ
 qd2sfcEKI5uKjvIffBbRPG2KMbXiAQDfZVM7U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707320691; x=1707925491;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SVAZFV86HDNc2iYlpB8wN8UR+0B5gH3W7zXV/e7ixxc=;
 b=u7ZTHKQD+B00RQrOEY7ylbsi+IdburjNNIWWKlaFcRhI0kQARtwCNZZQ5Do88gl+I9
 2jOKjW8M9oUiUh888ejNr9DveXviCfLUoKM7l5OKnSfmYQHdy2M9FkZPIpW+U+VS2sjH
 4YfTr5KtevJW25uAnaHq1B7SFcdcLOUhRBZJNZfl/e+SWOVtdJxWRI/Hvw2TIg6YgPnT
 GeBVQsngyhWvgQ4Ra20/HVgH338u/0Pp964KjvT96SXcjrbDysQIj31r21Dh7l+6zBJT
 xsjI/UIc53tCqzLqIfPEnCX2Zb4CjvIBDlOZr/lHHqkY/TCBV9NR19f74Hhjlyejq7/L
 A6uw==
X-Gm-Message-State: AOJu0YwQX/ahq90aPwMUENNTKWMSLIF8VBqnYSF6flE4vJ1SNubnETgf
 +Jo3Fw0aU+pDSD88T0cyj3MFDjTOezRuGxA32Y3TfbrSXfyY95DNwEQatIe57Vw=
X-Google-Smtp-Source: AGHT+IFqFUGXTuItZsxcfZE1nzdd4Q6wInlQfn119j3PTKVrGbBZxGfnTJ87E+spJsOO+DDQII1UEw==
X-Received: by 2002:a0c:dc04:0:b0:68c:a3d4:fcb4 with SMTP id
 s4-20020a0cdc04000000b0068ca3d4fcb4mr5404395qvk.40.1707320691041; 
 Wed, 07 Feb 2024 07:44:51 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCXNVm6uwTtpiHKJluV0KH3/dukuCR3Uj6+WeCsrN1ZpjkTGJ6U8j2zvLDwIWq3NRQBQo38fqtb65Whiem7rpDEV75IeGg==
Received: from bill-the-cat
 (2603-6081-7b00-3119-0000-0000-0000-1001.res6.spectrum.com.
 [2603:6081:7b00:3119::1001]) by smtp.gmail.com with ESMTPSA id
 g2-20020ad45142000000b006869ec9cd16sm680049qvq.129.2024.02.07.07.44.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Feb 2024 07:44:50 -0800 (PST)
Date: Wed, 7 Feb 2024 10:44:48 -0500
From: Tom Rini <trini@konsulko.com>
To: Brandon Maier <brandon.maier@collins.com>
Cc: u-boot@lists.denx.de, Joao Marcos Costa <jmcosta944@gmail.com>
Subject: Re: [PATCH] scripts/gen_compile_commands: update to Linux v6.7
Message-ID: <20240207154448.GZ1152441@bill-the-cat>
References: <20240122184553.69014-1-brandon.maier@collins.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="X8WvDI8uL04OoC6E"
Content-Disposition: inline
In-Reply-To: <20240122184553.69014-1-brandon.maier@collins.com>
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


--X8WvDI8uL04OoC6E
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 22, 2024 at 06:45:50PM +0000, Brandon Maier wrote:

> Adds support for assembly files and updates the LINE_PATTERN so it
> supports both "cmd" and "savedcmd", which allows reverting the U-Boot
> modification in commit 97fbb2eb016b ("scripts/gen_compile_commands.py:
> adapt _LINE_PATTERN").
>=20
> Upstream commits:
>=20
> - 880946158b011 gen_compile_commands.py: fix path resolve with symlinks i=
n it
> - 9e56d3be4bfd2 gen_compile_commands: Sort output compile commands by fil=
e name
> - 52c15e7e79285 gen_compile_commands: Allow the line prefix to still be c=
md_
> - 1c67921444bf6 gen_compile_commands: add assembly files to compilation d=
atabase
>=20
> Signed-off-by: Brandon Maier <brandon.maier@collins.com>
> Cc: Joao Marcos Costa <jmcosta944@gmail.com>

Applied to u-boot/master, thanks!

--=20
Tom

--X8WvDI8uL04OoC6E
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmXDpXAACgkQFHw5/5Y0
tyyyeAwAnnlgE8sZPoOmjX2/iEwrm4LCvJ1CAFM3M4OlQF9goxsE7LiKLr+tE6ou
rOyLA68hbzte+xrEREHRwEYDEGQ3CwtwGrmFfFK9aI/R36B5Yn6+JozVp9Ntq1hD
lXHBChMGOaJEzicaUiCricPkSN3r8oFeN4+zjASW2Q1kDd4Eubk7CyBbYmYw4lJr
sfqHw1oa3Wy1QVBgJJzMFHeQlR6xaAG2e7JUix3g2vX/MxAuKwaOi9q/S0S/lolT
/UlZ6txHHPJA4iGGiJj38TpqcCnBQD0I0c/P2t6Wh/MzS2dbkUCRpQb6Y0nlGqKr
BaYf5IwOlEZdetz1dOnyqRYZcjBJAoj1D9pYQuN76tCaY4oWTB6BMaRpAgdVfO7a
zKlm02jhvnNe7vWCtE69AR4AHZP+evrN0/OMIZbIAlVUaYdg+ChWhQ/GVOvI/pEm
df5lDvfCCGjUcw1DecuH2v/RHRGem5IuMLRHudEOeBIgWGElzZDxSBcks90bMGRC
mcwPijgj
=wNf2
-----END PGP SIGNATURE-----

--X8WvDI8uL04OoC6E--
