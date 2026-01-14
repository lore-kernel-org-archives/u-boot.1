Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0483CD37E39
	for <u-boot@archiver.kernel.org>; Wed, 14 Jan 2026 14:58:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 57C908063E;
	Wed, 14 Jan 2026 15:58:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="KKHnmul1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 32FA8830A0; Wed, 14 Jan 2026 15:58:48 +0100 (CET)
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com
 [IPv6:2607:f8b0:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 055A980325
 for <u-boot@lists.denx.de>; Wed, 14 Jan 2026 15:58:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x332.google.com with SMTP id
 46e09a7af769-7c76d855ddbso2915388a34.3
 for <u-boot@lists.denx.de>; Wed, 14 Jan 2026 06:58:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1768402725; x=1769007525; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=LM81MhAGJ18GTK5S84vxVLVgt6H1GEfq9cnmk6rXJNs=;
 b=KKHnmul1dghjeen1qjX5OOx/R1MPXK3qzNuC7AMbBDKgcvmZ1Stlxe1eGs6M9Xfr+O
 mDO8wI7KMIn82mXKDtpqOEvxNdtKCk5LBQwim2h7guMnYFZK2Ocy9OJhpCme53q5LZTY
 ryyIjS95RrqpnkLOXeim/l6OJoyRFaJJ+TR0c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768402725; x=1769007525;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LM81MhAGJ18GTK5S84vxVLVgt6H1GEfq9cnmk6rXJNs=;
 b=bEhm10jLAUcMa5CVdl/ddxx2ROlSJKYEOHOwBY+a68OmsW/nKAebs3g0DDxinW+QuS
 EGHzZpnlf5nFogB7VywNactdjfzhVoiBfrQJI1OOdWzaEZXYV2aIUQtxujYbma4Kkg6q
 Ag/txknM47CPDoIy0F8DpI+giM9ygfFgN4vK1tO5Hsy7g0Xao7h5PUWhlEk+ApfI+v9k
 +5Od27M+756Y8B7YBqVt5MmFEkjUpBLsUTG8iDgO+MywpVsyYG0Yibh8E1v3WAzlU1oV
 +d/WQsvoH7G/e+F7wGMnz0lcMOf+++L0rJn09CbiKgCGWcNjMD2lR8PZcEx75+W8RdTK
 utTw==
X-Gm-Message-State: AOJu0YwfI1x0qqJQT2UEeMdHnKpQbpgwzQxPLjvLCdVsQOqxquPP+yqW
 4iaxJ27v0BvNGOTNBQg1WM1FSeRDddk3V5DIZo1jA5ND2MxMtFux21DyqRKJ/nSo2Ofc3WWbD9+
 iGVlN580=
X-Gm-Gg: AY/fxX4RcB3A1keDnrsx31aCPU0X/xbjx+3p2dutpwO7ai6iM3qQx1z1huopqMyO1Pq
 FlgzOgGmHeVghyl3NaftRhp2h05lSHRTXF4gamAqNfkUAu1c8VniZtHCZ4eIFzGuFNlyc/2iu4L
 ljGpq8y8t5WsaLU5iWyvUXK109f0rb61pbZPAikO4d32BQMtEGEoCSBqrNwvqulBbs3rx52OEGv
 Rv5sZPapo35kRfmRa1k9JFzktU6wAsu/00aGoDBtAPt8aS0+AGdefqXlUPPHRBJY22cco7ZJFMw
 LWn62rjeBYbiWHtbCjVxOPVKX3hHRJQViwnC8JcHcxytmt1ZX1YJCJU75KxS5PeOtN3OYGDFi1x
 aUgCer72ELl30HOhBM7HhL0Kvv5U0kpogcL2QC+1iHERtOrj/3K6P1P75j8tlr6JOjoobNGRBBl
 fdqMPHn+bWUfGV8tj3GPVWnPiZOxBrxj4a4sr1dmytty0/EnWgnCwgBUJx1Q6NJwrHvEFeI+TcL
 z+2NuLEmjF4LkwAlc8UkBCgRjVL9b/EWBKJYZA=
X-Received: by 2002:a05:6830:449f:b0:7c7:6217:5c66 with SMTP id
 46e09a7af769-7cfc8b2c870mr2670596a34.19.1768402724624; 
 Wed, 14 Jan 2026 06:58:44 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7ce478d9c17sm18453792a34.22.2026.01.14.06.58.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Jan 2026 06:58:44 -0800 (PST)
Date: Wed, 14 Jan 2026 08:58:42 -0600
From: Tom Rini <trini@konsulko.com>
To: Jamie.Gibbons@microchip.com
Cc: u-boot@lists.denx.de, andrew.goodbody@linaro.org,
 michael@amarulasolutions.com, Conor.Dooley@microchip.com,
 Valentina.FernandezAlanis@microchip.com, fberder@outlook.fr
Subject: Re: [PATCH v2 2/2] dm: core: Default to using DEVRES outside of xPL
Message-ID: <20260114145842.GD3416603@bill-the-cat>
References: <20251219202121.4180810-1-trini@konsulko.com>
 <20251227223833.3019311-1-trini@konsulko.com>
 <20251227223833.3019311-3-trini@konsulko.com>
 <ef5c3866fa673dd814264f1a26f73c5a9fb75b6b.camel@microchip.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="1ABa+OCgwzWHqnK/"
Content-Disposition: inline
In-Reply-To: <ef5c3866fa673dd814264f1a26f73c5a9fb75b6b.camel@microchip.com>
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


--1ABa+OCgwzWHqnK/
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 14, 2026 at 02:33:04PM +0000, Jamie.Gibbons@microchip.com wrote:
> Hi all,
>=20
> On Sat, 2025-12-27 at 16:37 -0600, Tom Rini wrote:
> > The devm alloc functions that we have may follow the Linux kernel
> > model
> > where allocations are (almost always) automatically free()'d. However,
> > quite often we don't enable, in full U-Boot, the tracking and
> > free()'ing
> > functionality. This in turn leads to memory leaks because the driver
> > author expects that since the functions have the same name as in the
> > Linux Kernel they have the same behavior. In turn we then get
> > functionally correct commits such as commit 00e1fed93c8c ("firmware:
> > ti_sci: Fix memory leaks in devm_ti_sci_get_of_resource") that
> > manually
> > add these calls. Rather than manually tracking allocations and
> > implementing free()s, rework things so that we follow expectations by
> > enabling the DEVRES functionality (outside of xPL phases).
> >=20
> > This turns DEVRES from a prompted symbol to a symbol that must be
> > select'd, and we now remove our non-managed alloc/free functions from
> > outside of xPL builds.
> >=20
> I=E2=80=99ve encountered a regression on the Microchip PolarFire SoC Icic=
le Kit
> with mainline U-Boot.
>=20
> After commit 217cf656e249 - the application of this patch (=E2=80=9Cdm: c=
ore:
> Default to using DEVRES outside of xPL=E2=80=9D), U-Boot fails to boot on=
 this
> board. After this patch was applied the Icicle kit no longer boots and
> crashes immediately after OpenSBI. Between this patch and master HEAD
> the following errors are found - please see attached logs for more
> detail:
>=20
>     Failed to reserve memory for fdt at 0xbf386210
>     Required FDT relocation for applying DTOs failed: 1
>     Could not find a valid device tree
>     Device tree not found or missing FDT support
>     ### ERROR ### Please RESET the board ###
>=20
> Sometimes, I also see an =E2=80=9CUnhandled exception: Illegal instructio=
n=E2=80=9D and
> a reset.
>=20
> The last known good commit is before this commmit. I used `git bisect`
> to confirm that 217cf656e249 (this patch) is the first bad commit.
>=20
> Steps to reproduce:
> - Build U-Boot for MPFS Icicle Kit
> - Boot using HSS payload as usual - I use our build system Buildroot for
> this
> - Observe the boot failure after the above commit
>=20
> Any advise on the problem?

It's really strange that it bisects down to this commit, rather than
something device tree related. Do you still have fdt_high=3D0xffffffff or
so set in the environment? It was in at least one of the logs, but I
can't see for sure if it's just that the other log is from before the
commit that added the print warning about not doing that, or if it
wasn't set.

--=20
Tom

--1ABa+OCgwzWHqnK/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaWevIQAKCRAr4qD1Cr/k
ChlSAQD81/up1c9X6x+JE1kfkV0TyhUYkZPgDv0kAV+66zWXvAD/ZiFpCuOBKn7z
pUIU1Lv23wg0A6+cW7m/5R3OCnCvAgw=
=wvDz
-----END PGP SIGNATURE-----

--1ABa+OCgwzWHqnK/--
