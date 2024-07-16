Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79CCEC3DA49
	for <u-boot@archiver.kernel.org>; Tue, 16 Jul 2024 19:13:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0871C884B2;
	Tue, 16 Jul 2024 21:13:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="pSw0F2HW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 43053885C5; Tue, 16 Jul 2024 21:13:07 +0200 (CEST)
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com
 [IPv6:2607:f8b0:4864:20::236])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EE8AE88440
 for <u-boot@lists.denx.de>; Tue, 16 Jul 2024 21:13:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x236.google.com with SMTP id
 5614622812f47-3d9c4887533so3095008b6e.2
 for <u-boot@lists.denx.de>; Tue, 16 Jul 2024 12:13:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1721157184; x=1721761984; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=zjFJDxjrDNU9ryCkhKAsZ9PweiP/07719rkHfdyxFg8=;
 b=pSw0F2HWJ1QLe6RXpzMwPCvqtqIOn/VyWjfzeNDdj79Of6lM3ROzP6R7vFdAymIUep
 UPxq3RiBCqCnx/wUHKjJW76CqY3o1RGLwC1XyZlDpgbP+sj7CZfrJXayOYAFB2+3rWo9
 Wcgov3cFTv2FTMAbBcIvja2eQDXCq9uEZBVEc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721157184; x=1721761984;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zjFJDxjrDNU9ryCkhKAsZ9PweiP/07719rkHfdyxFg8=;
 b=ArORYBG1K9rarkg8d7cjTL9lroYSNy6Op9VqM8FOWIXkKTaoT4nn+3kXY7hSedAHsN
 qckZQaIkqNi1znU6hZIv+wimBM9fBGw9BiYAQf/4696SnYI99rDvjeO6hoCmthxQZNPW
 /q0TADmD0XM7uEO/ND5jr+H+jfZrHZDBEWrH4ha1TqL+RSl0If8l/1lyjj53pqqPKknI
 qx/nZ39AmmX1F5w7eb8GpJ1zmD3vm4dxHIemjU2FVAelmnrQgBwNmGk1Un2T3k0ikhxM
 TmyNa43J8drnlQvK3MQEdoz8QUKXnZl3K8ITHDBUHNree4I0C3ZGr47Qg2NpMmHE13+D
 sO3Q==
X-Gm-Message-State: AOJu0Yx25n3QdS1xEjTmsPub4qoUxT7QxS6NK7QdGuUXsDBWu7/xBJ+Q
 CacbzP0xs0eVVu71CUKAXSIgak4gEH2+XJ2ATRXntrcPfdKf72G9ednxfRo9WK2Ec0eRch0AqEl
 J
X-Google-Smtp-Source: AGHT+IE4aE0zPNhoStMpL4raUyoaVn6FNbzfWGGC/bTg3kqSyhYy7ik0b+AMFnrT/bl7cWl4x1hHjw==
X-Received: by 2002:a05:6808:1523:b0:3d9:24b4:e131 with SMTP id
 5614622812f47-3dac7b9968emr3866750b6e.24.1721157183537; 
 Tue, 16 Jul 2024 12:13:03 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-103-45.totalplay.net.
 [189.203.103.45]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-3dab3dd22absm1188314b6e.16.2024.07.16.12.13.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jul 2024 12:13:02 -0700 (PDT)
Date: Tue, 16 Jul 2024 13:13:00 -0600
From: Tom Rini <trini@konsulko.com>
To: Nishanth Menon <nm@ti.com>, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
Cc: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>,
 Quentin Schulz <quentin.schulz@theobroma-systems.com>,
 Peter Robinson <pbrobinson@gmail.com>,
 Enric Balletbo i Serra <eballetb@redhat.com>,
 Josh Boyer <jwboyer@redhat.com>
Subject: Re: Request for hosting a boot-firmware repository in u-boot git
 (denx and GitHub)
Message-ID: <20240716191300.GM561963@bill-the-cat>
References: <20240620213539.ftmjhphypssxp5n4@desolate>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="jafNALASbnDZ6im9"
Content-Disposition: inline
In-Reply-To: <20240620213539.ftmjhphypssxp5n4@desolate>
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


--jafNALASbnDZ6im9
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 20, 2024 at 04:35:39PM -0500, Nishanth Menon wrote:
> Hi Team,
>=20
> We have briefly discussed this topic on IRC[1]. I would like to
> propose a new boot-firmware repository similar to the Linux-firmware
> repository under the aegis of u-boot hosting.
>=20
> In addition to TI, it looks like some NXP[2] and Rockchip[3]
> platforms seem to require additional closed-source/open-source
> binaries to have a complete bootable image. Distribution rights and
> locations of these binaries are challenging, and there needs to be a
> standard for how and where they are hosted for end users.
>=20
> Further, looking ahead to future architectures:
> * IP firmware: More and more IP vendors are embedding their own
>   "specialized controllers" and require firmware for the operation
>   (similar to Rockchip's DDR controller, I guess),
> * boot stage firmware: Additional stages of the boot process involve
>   vendor intermediate firmware, such as power configuration.
> * Security enclave binaries: While I see a few folks trying to have an
>   open-source s/w architecture, many PKA and PQC systems still require
>   prop binaries for IP reasons.
>=20
> NOTE: I am not judging any company(including TI) for reasons why some
> firmware is proprietary, but I hate to have the end users and other
> system (distro) maintainers have to deal with hell trying to make the
> life of end users easy to live with.
>=20
> In the case of TI's K3 architecture devices, we have two binary blobs
> that are critical for the boot process.
>=20
> 1. TIFS Firmware / DMSC firmware[4]=E2=80=94This is the security enclave
>   firmware. It is often encrypted, and sources are not public (due to
>   various business/regulatory reasons).
> 2. DM Firmware[5] - There is a source in public in some cases and
>   binary only in others - essentially limited function binary to be
>   put up in the device management uC. In cases where the source is
>   available, the build procedure is, in my personal opinion, pretty
>   arcane, and even though in theory it is practical, in practice, not
>   friendly - efforts are going to simplify it, even probably integrate
>   it with a more opensource ecosystem, but that is talking "look at the
>   tea leaves" stuff.
> 3. Low Power Management (LPM) binaries: tifs stub: another encrypted
>   binary that gives the tifs system context restore logic before
>   retrieving tifs firmware and a corresponding DM restoration binary.
>=20
> All told, this is not unlike the situation that necessitated the
> creation of a Linux firmware repository.
>=20
> Options that I see:
>=20
> 1. Let the status quo be - SoC vendors maintain random locations and
>   random rules to maintain boot firmware.
> 2. Ask Linux-firmware to host the binaries in a single canonical
>   location
> 3. Host a boot-firmware repository - u-boot repo may be the more
>   logical location.
>=20
> * (1) isn't the correct answer.
>=20
> * (2) Though I haven't seen any policy from the Linux-firmware
>   community mandating anything of the form, the binaries we are talking
>   of may not belong to Linux-firmware as they aren't strictly speaking
>   something Linux kernel will load (since the bootloader has that
>   responsibility), and in some cases may not even directly talk to
>   (security enclave or DDR firmware stuff). I am adding Josh to this
>   mail to see if he has any opinions on the topic (but keeping
>   from cross posting on linux-firmware list, unless folks feel it is
>   OK).
>=20
> On (3):
> Proposal:
>=20
> * Create a boot firmware repository in Denx and/or GitHub (if
>   financials are a hurdle, I hope we can solve it as a community).
> * Limit binaries only to those consumed part of the u-boot scope.
>=20
> * Limit binaries only to those that do not have an opensource project
>   (Trusted Firmware-A/M, OP-TEE, etc..) or depend entirely on vendor
>   source or are binary only in nature (subject to licensing terms below)
> * Limit binaries to some pre-established size to prevent repository
>   explosion - say, 512Kib?
> * Follow the same rules of integration and licensing guidelines as
>   Linux-firmware[6].
> * Similar rules as Linux-firmware guidelines of ABI backward and
>   forward compatibility.
> * Set a workflow update flow and a compatibility requirements document
>=20
> If we agree to have boot firmware under the stewardship of u-boot, we
> should also set other rules, which is excellent to discuss.
>=20
> Thoughts?

I believe that fundamentally, this is a problem that exists beyond both
just "U-Boot needs some binaries" and "TI has some binaries that
bootloaders need". So a generic solution is appropriate, and some sort
of community-based hosting of these needs (with appropriate licensing
=66rom the IP owners) makes sense. Looking around at the binaries I have
to keep locally to use NXP platforms, and TI platforms and Rockchip
platforms, it's far from ideal. Having one place to get them all from
would make life easier for a lot of developers and also frankly for a
lot of end customers of these chips.

--=20
Tom

--jafNALASbnDZ6im9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmaWxjwACgkQFHw5/5Y0
tywqlAv8CSuMVTAHvDzxTTgzkP8Tk894QjH8y0kqnShzYh+IuyDTqnMeFpHPk/xg
CyBRZKoiol9IAd3hLn3NFoV89Bw+n+c1eNat2fZrWUPh9WCvDn6m8nS2N+ILGeVq
QonalLjq/kzs9KUSijRu//8GuisTD1RTt1ilF+QIfat0oLWie2lTWbRc9isXSY/2
/h/r+gOtNrngOzUXyUtk74J+XgzOSgzKv4QehTJLmu58NY+S/3M3RyPXrRvTwS5s
TtHSDMWFATI4JbOFtYeH5ClfZwH5MfPJbi0NH0kbGxOYVPJHaMKUBenxWFCA/Wo7
v+GJGkI2aK+mq9oo5+NMr3EXWNGcaDvyNyCNmH90RqLcDtbP4fwXo2TBunSvKpgL
1cxXtdZyptVdwXPHx32wmArpmkTiGsUwEY7uxWi53nsYwXTre5Dd6/iNNrznfZld
2OkkPVr8JqR24LHclTlXHE63C53zGdzh/Rszg/H0JdPyOR653yKXuqM7cLbLiIFA
7HLIt5jt
=NbGI
-----END PGP SIGNATURE-----

--jafNALASbnDZ6im9--
