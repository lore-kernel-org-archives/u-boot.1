Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 529C8C19F32
	for <u-boot@archiver.kernel.org>; Fri,  7 Mar 2025 19:05:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 849C480E94;
	Fri,  7 Mar 2025 20:05:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="tikrCx9z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D0EB480F0B; Fri,  7 Mar 2025 20:05:52 +0100 (CET)
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com
 [IPv6:2607:f8b0:4864:20::b35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 17CCD808A2
 for <u-boot@lists.denx.de>; Fri,  7 Mar 2025 20:05:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb35.google.com with SMTP id
 3f1490d57ef6-e60b75f87aaso1722945276.2
 for <u-boot@lists.denx.de>; Fri, 07 Mar 2025 11:05:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1741374347; x=1741979147; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=eUASVH5vpVNgH94wOSQP5l8DGm0Hz2nfDfubNkBy/v8=;
 b=tikrCx9z9gRfoXuX4o6MRVm907hToDz02fxMdyZAgUBoky8q34ZUGw37bZFZQNwMvZ
 xHptX/EGYWrHiLmE3ODPABXfyPqDznlYMsoIqh2aiZIC3MX11TP3r16BbPlRgaN8Cdw0
 FYjbBV6mmROrtt+ahEOJ4s0qby0kZCMyAth1E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741374347; x=1741979147;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eUASVH5vpVNgH94wOSQP5l8DGm0Hz2nfDfubNkBy/v8=;
 b=Fpg4pe7C9vDStiPXLOrb87BM3QIaC3BsddVZoAFsOnZntbTGkkG2AlGT2J8GS2KvwN
 5EI+RZiuJtYox/kTosxacENJYM7t/Rq+aFuvuU5Bd1glIAbm26rpeOekfLoEdqq6kQyV
 eaVCkHwXx8G/TsSwXoLZAKROO2lEHgmqC47iUrO7d5WelyosrhDoy0qkeLN+mP99tYWY
 m8dZ7hOrZPyc12vg49Ev27Q5BBxqyZsYLD4DQs8X8VrqeAlFWPXQbMwr0VwhjiS0nQFc
 L0NTqSz5cxheUu4O5v8XAIbPU1hOgWf63CQZKmdCWRfsYc1hzhzbqqGCjA+XxN87bCzg
 yq8A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVRk6RMS2drE7B43JhXdg9euo2HqZkhbRO7l9vtPB3r5/6Fcv5yXhKT6huPwHYkCbG45CNeB8Q=@lists.denx.de
X-Gm-Message-State: AOJu0YzqEvQicNGOm/ms1GD/C6Vw5HH/TFd+WeXkEULPB6tUxyjgPLI7
 rWMaMObJNYKYbLaFLpbAQpG9tjgByaZ3ZNoJl7rQjqIMvedkeJM6ts6497oN1Po=
X-Gm-Gg: ASbGnculKGfuTYCp7Wa3tjRSiPyajhVSb1vEg7G6AM3NWKmBOgLMBso4xewe+3nkPSW
 k7jrOX3cwGQ9W+HAgwr305VV7DuEecOcUQJbqViJStcKlV7H0asj8FM+lQ1eT4uwFzjTXMjr0z7
 /LcHpjjNNOp50W7BgymUMsvQ7OlG+EC/Jwk7XLv1otuVRqC2lBmGdnCB5fXUMaO/s2YfHQROJGi
 OtJt/Vb0wpBGZ4MVKWrX5NtL5N64YovS/dPaDtunZgwVu89ziJ88lMl0R6o9OKFPjNQln9mIBjF
 nnYx/yag4ulXp2DJyrZE0H5qSlbEtiGZgXVtypDVDYNKaQ==
X-Google-Smtp-Source: AGHT+IFspcyn4nR7wnqmNDvrtcBGjddRip9FwlL9wUYdc01tMXiH2XH/vTV+1NZ2Z5pFdD7/57UScQ==
X-Received: by 2002:a05:6902:2c05:b0:e63:703a:89e9 with SMTP id
 3f1490d57ef6-e63703a8a7amr507564276.49.1741374346819; 
 Fri, 07 Mar 2025 11:05:46 -0800 (PST)
Received: from bill-the-cat ([187.192.142.234])
 by smtp.gmail.com with ESMTPSA id
 3f1490d57ef6-e634b8fde5asm909239276.48.2025.03.07.11.05.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Mar 2025 11:05:46 -0800 (PST)
Date: Fri, 7 Mar 2025 13:05:43 -0600
From: Tom Rini <trini@konsulko.com>
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de
Subject: Re: [PATCH v1 1/1] sandbox: swap bloblist and fdt loading address
 sequence
Message-ID: <20250307190543.GT2640854@bill-the-cat>
References: <20250307101629.51561-1-clamor95@gmail.com>
 <20250307101629.51561-2-clamor95@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="hlFdxCGyv/9AI9PJ"
Content-Disposition: inline
In-Reply-To: <20250307101629.51561-2-clamor95@gmail.com>
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


--hlFdxCGyv/9AI9PJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 07, 2025 at 12:16:29PM +0200, Svyatoslav Ryhel wrote:

> The existing memory layout places the bloblist at 0xb000 and the fdt at 0=
x100,
> resulting in a 0xaf00 size constraint for the fdt. This constraint has be=
en
> reached. Lets modify the layout by moving the bloblist to 0x100. With a
> bloblist size limit of 0x400, this allows the fdt to be positioned at 0x5=
00,
> thus expanding its permissible size.
>=20
> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
[snip]
> diff --git a/doc/arch/sandbox/sandbox.rst b/doc/arch/sandbox/sandbox.rst
> index a8b0d7f0395..99459815c25 100644
> --- a/doc/arch/sandbox/sandbox.rst
> +++ b/doc/arch/sandbox/sandbox.rst
> @@ -658,8 +658,8 @@ that are mapped into that memory:
>  =3D=3D=3D=3D=3D=3D=3D=3D   =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D   =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>  Addr       Config                     Usage
>  =3D=3D=3D=3D=3D=3D=3D=3D   =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D   =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> -     100   CONFIG_SYS_FDT_LOAD_ADDR   Device tree
> -    b000   CONFIG_BLOBLIST_ADDR       Blob list
> +     100   CONFIG_BLOBLIST_ADDR       Blob list
> +     500   CONFIG_SYS_FDT_LOAD_ADDR   Device tree
>     10000   CFG_MALLOC_F_ADDR          Early memory allocation
>     f0000   CONFIG_PRE_CON_BUF_ADDR    Pre-console buffer
>    100000   TCG Event log              TCG Event Log

My question is do we have room or not to set aside 512KiB (as the
"should never be this large" value) instead of not quite 64KiB which we
can possibly hit again in the not too distant future? I think I checked
earlier and CFG_MALLOC_F_ADDR + CONFIG_SYS_MALLOC_F_LEN should still fit
below CONFIG_PRE_CON_BUF_ADDR if we do that (and also give the bloblist
some room to expand).

--=20
Tom

--hlFdxCGyv/9AI9PJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmfLQ4MACgkQFHw5/5Y0
tyz6tgv9EYOmvPzzHW1IbzENM5Byro7x6B3b+HtVy+RW0+x3Tw3kmdLPBCZ0+wLA
Ya1hOQ65bnd0NTrBIJiSZBjR8mFy7NozrFi+WFf1+Fs+SkQFlK+cmJ1KCilVyPXh
YN/ezKRpAwk7U9gMmjcs5j8KNecshEXKsg8q+UwQk5ByKsL+iS5CtOIDEd4r/w1h
jODSbHDE7v5/PrBEEOTatVY0IwyzU2DGB+nVynX+bBjVvcek6F30lEOcFr5H5Ky4
zmq8mFFoqgLqXF8oJSla+UpCpQsO1asMUw+EHF0HZI1ePqjmfbS2no4S9UcAe9PE
6huZx4Adk3WlDcsddBW5NnicHzyvutw+/aIqZyOazwERZuFZmbWMfR2JE0X8bCAx
eGfe5T7Wyv9X4v+8hng5fK0JMk4dMGmQeWKcU7/wB3ecQF7bArS5x5Jp1jCajtn6
wh3q6/ds1fj+RCjkErqSC7M+bi+H+BS84oNm69MUtAM2CQqWfWiin/r5aJdH9V9S
fHRxsQEI
=HcvG
-----END PGP SIGNATURE-----

--hlFdxCGyv/9AI9PJ--
