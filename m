Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9733CCF45A0
	for <u-boot@archiver.kernel.org>; Mon, 12 Jan 2026 16:45:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DC3D383693;
	Mon, 12 Jan 2026 17:45:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="L5DqTRO6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4EDCA83869; Mon, 12 Jan 2026 17:45:18 +0100 (CET)
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com
 [IPv6:2607:f8b0:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BD612835FD
 for <u-boot@lists.denx.de>; Mon, 12 Jan 2026 17:45:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x331.google.com with SMTP id
 46e09a7af769-7c6e815310aso5474702a34.0
 for <u-boot@lists.denx.de>; Mon, 12 Jan 2026 08:45:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1768236314; x=1768841114; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=UnCH7WlIH0Dvvo95troMQ1olkwT11F0BDvAL/XAlFAU=;
 b=L5DqTRO6agi4qySkEAOiNiZj8HGI6/vol1ACnc/mW/oTUbeQ2pVbUGo/Jw2khnf6nt
 WPY/VVHNhgiiuvdpHaAUHG7V7aRmCXZOAGbuDGb0Cs81++PjfIfqWLq85haNB6mVWZb5
 altDzgQnDXhvphRzJeL9RizQ6r0cLtEgnmgQk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768236314; x=1768841114;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UnCH7WlIH0Dvvo95troMQ1olkwT11F0BDvAL/XAlFAU=;
 b=YHWn13eK4gqoX+7CNGfrrldxDKZlG4UZIZwTo5RFMRKLIVyjmM2s7VOgki3snu+gJV
 cFy721aos8Cl4/4j9TnTh4FmiFlYtKHfrpTsKl322ajtD1YPUq7RAthLA6FSsYIl4L5T
 O33+7ZxsmvqIl1/yb7FZwH3DyDynmr4VQcMyfzk2KsnMfs1O2PwqS7S93Yt79/7/71m5
 7Fjn6IwMqXNM4R6jbZvAMzF+BmkR/sshHDo2RAUV/JjLvuVn0DAc+7+ZuXEeEhwNUh/F
 3+1Ijb0qORajKhzyJIUYKQH9HJfH2aW0eKUxQB642EcBISgWYiWSbAlv154+fY/mdn2o
 VaPg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXI1WZPjqfhzEtREO2rpcKDi+gQQWqh4eYE5pN3KeLSXO+WyfM2vjosIHrv2m/e4w1ZsAd7ou8=@lists.denx.de
X-Gm-Message-State: AOJu0YyDCcZD+H+n9jUiAgZ6/Oz/OnC9BNcDYXxd0fvbOVM0BYB5U4C4
 p0w5lE5v4fsZOEz74XFR4jd4BhReRwmZv6u6SM5LCwv0s+F2ZXIyGjUabJLDInDRZCo=
X-Gm-Gg: AY/fxX7mu6Axi0PgnQdE/NVL1KVp7EEmBzi/FD2v/lyGWh6FDZW27VTmeJQYmENWqhq
 SCbYn2AiHdEQubMxx6j8TTFs9otX2xkhzxL6vNMGPpl9rAncTHDMSTrbGCxXOu3fc4KLa4oaqiU
 ziURsuaIrMig/euvFrX1eBRE/9aqGvbmxRnTqmN1nnHhOdkqsQS2gz8dmrxRLz7XIdfHE97bc1t
 HGcSFxTCEG6PkjD9QLZn6Zti3MYQH5S+nefMnM6tn7sQ/H+POgOq/Q7SzI3vVF2FuuXwyVbWl+8
 /VSX8lyuW8agtZbrG3siUjH+wXJPtQYm/TIoYwdZqi0SiKEUh5cHqFtBDwL30uYzaw3xlHpww90
 N/cv3gsS36jPnBnYHvlJN9aXqY9558mW/MjlUy+pn1fLDu8Q+YlO6R7CIkJT0E5Z35hRwoV6FEu
 mfHPNJ5bcxnhU1zj6TabTWhwv7ZS01aoZBrcvScn+o8Um4ddvGCv27k2GVt5heyQv7lh+LCsQ8A
 x7TbTjghDUOGHWSKtNgQj1ZLWQXq+QGISl2rnI=
X-Google-Smtp-Source: AGHT+IFTMtEGqt5qMHIPAsW/WOCES61RUyhHKL1xTOm/Pc1REbH3bSonVKfZ+c0scn00TQY0MLlaiw==
X-Received: by 2002:a05:6830:2e05:b0:7c7:da3:ed27 with SMTP id
 46e09a7af769-7ce50c3d832mr8925689a34.35.1768236312965; 
 Mon, 12 Jan 2026 08:45:12 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7ce478af6efsm13267061a34.18.2026.01.12.08.45.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Jan 2026 08:45:12 -0800 (PST)
Date: Mon, 12 Jan 2026 10:45:09 -0600
From: Tom Rini <trini@konsulko.com>
To: Marek Vasut <marek.vasut@mailbox.org>
Cc: Beleswar Padhi <b-padhi@ti.com>, ilias.apalodimas@linaro.org,
 malysagreg@gmail.com, sughosh.ganu@linaro.org,
 philip.molloy@analog.com, james.hilliard1@gmail.com, anshuld@ti.com,
 afd@ti.com, nm@ti.com, vigneshr@ti.com, n-francis@ti.com,
 u-kumar1@ti.com, u-boot@lists.denx.de
Subject: Re: [PATCH v2 2/2] ARM: OMAP2+: Pad SPL binary to 8-byte alignment
 before DTB
Message-ID: <20260112164509.GP3416603@bill-the-cat>
References: <20260112101102.1417970-1-b-padhi@ti.com>
 <20260112101102.1417970-3-b-padhi@ti.com>
 <f7562e91-03cb-4bb9-aabe-e7c0b6ea1b6b@mailbox.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="IyPXhiO4UMGn8WJd"
Content-Disposition: inline
In-Reply-To: <f7562e91-03cb-4bb9-aabe-e7c0b6ea1b6b@mailbox.org>
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


--IyPXhiO4UMGn8WJd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 12, 2026 at 03:40:57PM +0100, Marek Vasut wrote:
> On 1/12/26 11:11 AM, Beleswar Padhi wrote:
> > The OMAP2 SPL linker script (also used for K3 platforms) currently uses
> > a 4-byte alignment directive after the __u_boot_list section. This
> > alignment directive only advances the location counter without padding
> > the actual binary output.
> >=20
> > When objcopy extracts u-boot-spl-nodtb.bin, it includes only actual
> > data, stopping at the last byte of __u_boot_list (e.g., 0x41c359fc),
> > not an aligned address (e.g., 0x41c35a00). So, when the FIT image
> > containing device trees is concatenated to the SPL binary, it gets
> > appended at this unaligned file size, causing libfdt validation failure.
> >=20
> > To fix this, move the alignment directive into the __u_boot_list section
> > itself and make it 8-byte aligned as per DT spec. This forces the linker
> > to include padding as part of the section data, ensuring objcopy
> > includes the padding bytes in the binary and the appended FIT image
> > starts at an 8-byte aligned boundary.
> >=20
> > Reported-by: Anshul Dalal <anshuld@ti.com>
> > Closes: https://lore.kernel.org/u-boot/DFJ950O0QM0D.380U0N16ZO19E@ti.com
> > Fixes: 0535e46d55d7 ("scripts/dtc: Update to upstream version v1.7.2-35=
-g52f07dcca47c")
> > Signed-off-by: Beleswar Padhi <b-padhi@ti.com>
> > ---
> > v2: Changelog:
> > 1. Get rid of extra ALIGN() directive, replace it with a comment
> > 2. Carry Reported-by, Closes and Fixes tag.
> >=20
> > Link to v1:
> > https://lore.kernel.org/all/20260109190026.58464-3-b-padhi@ti.com/
> >=20
> >   arch/arm/mach-omap2/u-boot-spl.lds | 6 +++++-
> >   1 file changed, 5 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/arch/arm/mach-omap2/u-boot-spl.lds b/arch/arm/mach-omap2/u=
-boot-spl.lds
> > index 3bb759d8a1c..5ad169a37b7 100644
> > --- a/arch/arm/mach-omap2/u-boot-spl.lds
> > +++ b/arch/arm/mach-omap2/u-boot-spl.lds
> > @@ -35,9 +35,13 @@ SECTIONS
> >   	. =3D ALIGN(4);
> >   	__u_boot_list : {
> >   		KEEP(*(SORT(__u_boot_list*)));
> > +		/*
> > +		 * Ensure 8-byte alignment at the end of the last section before
> > +		 * DTB is appended, to satisfy DT spec alignment requirements
> > +		 */
> > +		. =3D ALIGN(8);
> >   	} >.sram
> Does this work even if the __u_boot_list section is empty ?

I'm not sure it can be empty, but it should still work.

> I think what you need is unconditional alignment of the end of the binary,
> that has to be 8 bytes aligned.

We might need to look harder at what Anshul was suggesting in his reply,
yeah. I'll chime in over there next.

--=20
Tom

--IyPXhiO4UMGn8WJd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaWUlEgAKCRAr4qD1Cr/k
CkQFAP4xLq9/XFXMiz9ipdpNOh3BhYDpAeP0jjUm84IWw5U1FgEAs1vn0ZS/2DVc
2WbtTmj20hHrIZlqSmc+5Vy1bWEMRwc=
=FNrA
-----END PGP SIGNATURE-----

--IyPXhiO4UMGn8WJd--
