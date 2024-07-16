Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74FE9C3DA49
	for <u-boot@archiver.kernel.org>; Tue, 16 Jul 2024 20:01:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B71A787D14;
	Tue, 16 Jul 2024 22:01:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Daxeq9KH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A8EBF87D2F; Tue, 16 Jul 2024 22:01:53 +0200 (CEST)
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com
 [IPv6:2607:f8b0:4864:20::22c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 58D1483333
 for <u-boot@lists.denx.de>; Tue, 16 Jul 2024 22:01:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22c.google.com with SMTP id
 5614622812f47-3c9cc681ee4so3277905b6e.0
 for <u-boot@lists.denx.de>; Tue, 16 Jul 2024 13:01:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1721160110; x=1721764910; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=2pcfHw+PCX4e57Fr5RIAZyNaNvBoOwPNM01bVFqteVA=;
 b=Daxeq9KHhC6sf7IMkjvHuzP4VU8KSD2Fz6T9IuR9q1ghXP5dDICIX0+EkLk3twZXx1
 73QZ+E4oUNoe888/bPKEw4Sak68gE062yfHvfem4cIKNk0C4tZZVkMUEO1akIVW+60jF
 HDctmTokNeZUw+6kENFMreoTX7I/SCwSEDWvY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721160110; x=1721764910;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2pcfHw+PCX4e57Fr5RIAZyNaNvBoOwPNM01bVFqteVA=;
 b=Qo8gOMTrLRP61PUCrDz6Jzjud0/x+6+P9wBqO5yztlsaxS2KZZWmRWqflS6Hbh7fjz
 OAkPBMmNeW5WrUCHpYHVYtSRn28xXDIjaYOHVw1AXjIbiejWMBNI+CGURA/MzMLwnAvD
 ZM9PeBKbAcwJyyHVYI61vzh2KZDyyQr/D0yN+pwxQWOtS34gprDBulqD5fsjPnpgwf2J
 +L9AbYCAlkX4f1/ZnW5JocFRhR9UaxUHysBuzzkNBFHLxNEiXGlWYsF6XY7wa9pS5SIp
 LTqz9BviF59Bbyvk/rfYD2ZUmtdWs2/qBPZj++6v+AoL1/LdfbXYO7j0uVrUW4qhtwoW
 vhuQ==
X-Gm-Message-State: AOJu0Yw4tSSjLMe3lo+kOunfIPp75fRwhymNqt1kxoCxlzwhNlBY2iKd
 ZIH0SKPytHizgJNEOnYO5hLiC9IcrpleTefY1cYWV6RMBZbjbVqVRlS8/ZUIp90=
X-Google-Smtp-Source: AGHT+IF1qsK1+FRCOkJ4bgDs1ak6CXzPUuMXgOdPW/xZgFiPYDXbuF4tXHbpbl6Kbzs8zu/WQpSssQ==
X-Received: by 2002:a05:6808:23c5:b0:3da:a16e:1750 with SMTP id
 5614622812f47-3dac7bb5c8cmr4556678b6e.33.1721160109939; 
 Tue, 16 Jul 2024 13:01:49 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-103-45.totalplay.net.
 [189.203.103.45]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-3dab3ddb41csm1220039b6e.25.2024.07.16.13.01.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jul 2024 13:01:49 -0700 (PDT)
Date: Tue, 16 Jul 2024 14:01:47 -0600
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>,
 Quentin Schulz <quentin.schulz@theobroma-systems.com>,
 Peter Robinson <pbrobinson@gmail.com>,
 Enric Balletbo i Serra <eballetb@redhat.com>,
 Josh Boyer <jwboyer@redhat.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Nishanth Menon <nm@ti.com>
Subject: Re: Request for hosting a boot-firmware repository in u-boot git
 (denx and GitHub)
Message-ID: <20240716200147.GN561963@bill-the-cat>
References: <20240620213539.ftmjhphypssxp5n4@desolate>
 <20240716191300.GM561963@bill-the-cat>
 <4bb80912-62fa-4f33-a344-351141d8df10@canonical.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="cGHX2h/oOWrd5raK"
Content-Disposition: inline
In-Reply-To: <4bb80912-62fa-4f33-a344-351141d8df10@canonical.com>
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


--cGHX2h/oOWrd5raK
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 16, 2024 at 09:35:18PM +0200, Heinrich Schuchardt wrote:
> On 7/16/24 21:13, Tom Rini wrote:
> > On Thu, Jun 20, 2024 at 04:35:39PM -0500, Nishanth Menon wrote:
> > > Hi Team,
> > >=20
> > > We have briefly discussed this topic on IRC[1]. I would like to
> > > propose a new boot-firmware repository similar to the Linux-firmware
> > > repository under the aegis of u-boot hosting.
> > >=20
> > > In addition to TI, it looks like some NXP[2] and Rockchip[3]
> > > platforms seem to require additional closed-source/open-source
> > > binaries to have a complete bootable image. Distribution rights and
> > > locations of these binaries are challenging, and there needs to be a
> > > standard for how and where they are hosted for end users.
> > >=20
> > > Further, looking ahead to future architectures:
> > > * IP firmware: More and more IP vendors are embedding their own
> > >    "specialized controllers" and require firmware for the operation
> > >    (similar to Rockchip's DDR controller, I guess),
> > > * boot stage firmware: Additional stages of the boot process involve
> > >    vendor intermediate firmware, such as power configuration.
> > > * Security enclave binaries: While I see a few folks trying to have an
> > >    open-source s/w architecture, many PKA and PQC systems still requi=
re
> > >    prop binaries for IP reasons.
> > >=20
> > > NOTE: I am not judging any company(including TI) for reasons why some
> > > firmware is proprietary, but I hate to have the end users and other
> > > system (distro) maintainers have to deal with hell trying to make the
> > > life of end users easy to live with.
> > >=20
> > > In the case of TI's K3 architecture devices, we have two binary blobs
> > > that are critical for the boot process.
> > >=20
> > > 1. TIFS Firmware / DMSC firmware[4]=E2=80=94This is the security encl=
ave
> > >    firmware. It is often encrypted, and sources are not public (due to
> > >    various business/regulatory reasons).
> > > 2. DM Firmware[5] - There is a source in public in some cases and
> > >    binary only in others - essentially limited function binary to be
> > >    put up in the device management uC. In cases where the source is
> > >    available, the build procedure is, in my personal opinion, pretty
> > >    arcane, and even though in theory it is practical, in practice, not
> > >    friendly - efforts are going to simplify it, even probably integra=
te
> > >    it with a more opensource ecosystem, but that is talking "look at =
the
> > >    tea leaves" stuff.
> > > 3. Low Power Management (LPM) binaries: tifs stub: another encrypted
> > >    binary that gives the tifs system context restore logic before
> > >    retrieving tifs firmware and a corresponding DM restoration binary.
> > >=20
> > > All told, this is not unlike the situation that necessitated the
> > > creation of a Linux firmware repository.
> > >=20
> > > Options that I see:
> > >=20
> > > 1. Let the status quo be - SoC vendors maintain random locations and
> > >    random rules to maintain boot firmware.
> > > 2. Ask Linux-firmware to host the binaries in a single canonical
> > >    location
> > > 3. Host a boot-firmware repository - u-boot repo may be the more
> > >    logical location.
> > >=20
> > > * (1) isn't the correct answer.
> > >=20
> > > * (2) Though I haven't seen any policy from the Linux-firmware
> > >    community mandating anything of the form, the binaries we are talk=
ing
> > >    of may not belong to Linux-firmware as they aren't strictly speaki=
ng
> > >    something Linux kernel will load (since the bootloader has that
> > >    responsibility), and in some cases may not even directly talk to
> > >    (security enclave or DDR firmware stuff). I am adding Josh to this
> > >    mail to see if he has any opinions on the topic (but keeping
> > >    from cross posting on linux-firmware list, unless folks feel it is
> > >    OK).
> > >=20
> > > On (3):
> > > Proposal:
> > >=20
> > > * Create a boot firmware repository in Denx and/or GitHub (if
> > >    financials are a hurdle, I hope we can solve it as a community).
> > > * Limit binaries only to those consumed part of the u-boot scope.
> > >=20
> > > * Limit binaries only to those that do not have an opensource project
> > >    (Trusted Firmware-A/M, OP-TEE, etc..) or depend entirely on vendor
> > >    source or are binary only in nature (subject to licensing terms be=
low)
> > > * Limit binaries to some pre-established size to prevent repository
> > >    explosion - say, 512Kib?
> > > * Follow the same rules of integration and licensing guidelines as
> > >    Linux-firmware[6].
> > > * Similar rules as Linux-firmware guidelines of ABI backward and
> > >    forward compatibility.
> > > * Set a workflow update flow and a compatibility requirements document
> > >=20
> > > If we agree to have boot firmware under the stewardship of u-boot, we
> > > should also set other rules, which is excellent to discuss.
> > >=20
> > > Thoughts?
> >=20
> > I believe that fundamentally, this is a problem that exists beyond both
> > just "U-Boot needs some binaries" and "TI has some binaries that
> > bootloaders need". So a generic solution is appropriate, and some sort
> > of community-based hosting of these needs (with appropriate licensing
> > from the IP owners) makes sense. Looking around at the binaries I have
> > to keep locally to use NXP platforms, and TI platforms and Rockchip
> > platforms, it's far from ideal. Having one place to get them all from
> > would make life easier for a lot of developers and also frankly for a
> > lot of end customers of these chips.
> >=20
>=20
> Some thought needs to be given to the license implications of these binar=
ies
> for operating system distributions.
>=20
> A distro providing a combined binary consisting of U-Boot and closed sour=
ce
> firmware might be interpreted as conflicting with U-Boot's GPL license.
>=20
> Distributing the closed source binaries and U-Boot in separate packages
> according to their respective licenses and only assemble them on the targ=
et
> device via a post-installation script might be allowable.

For this project the question is making sure that the binaries are
licensed such that they could be externally redistributable.

I don't know why someone would suggest that ABI calls are suddenly
linkage as I thought that (as far as these matters go) that was already
settled, but I am not a lawyer.

--=20
Tom

--cGHX2h/oOWrd5raK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmaW0aQACgkQFHw5/5Y0
tyw4kAwAmQCQEqLxhwO0NY9KXWtMVt8Q8ngoJV01IZSHOqEfP/pD+EJNMN5ofIkO
H+2vasglODmc/r4SWD7jmcDfdRe0VhSAVD2lFymQngV68g5EI23HF+3tAbp0UgUx
0MOikf6a6XyG8YG1cpLSGCaW5kktN+Zhv66geEFEYUbW11sSwnO6MuhLZNuurnAY
X1H8KMvZXsIDSuvV0J+u2D3XqHgv/GrfNBqvDHUNErdiEAuvk7pZBzs3VlUmY2EJ
R9Mi3qPKGJJzgv79NLVIUbTG0qDr3+iz4m3QyTVAjb1gHy1zQiUhFVoESYuJushV
u+MJUvcToroOGMg4AsaxqulPeKaADWs5bLbKoVlmOWmDQ6KD0JiG0eFyb5eR2MF8
v6hLNuCEX1rJMoC8pyYT9OayxKEko9iE5X6jkHRDlLBzfE8LJ901R6UNl4Qvypyw
cFCnEd8ywwoWjl+LPCAwhgX0D0GiDqMLerp2HuZPElS3CbvPozT9hqkLVcljFjFG
fOAQM5Qa
=oxcp
-----END PGP SIGNATURE-----

--cGHX2h/oOWrd5raK--
