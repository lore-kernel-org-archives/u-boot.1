Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60D98C982CA
	for <u-boot@archiver.kernel.org>; Fri, 16 Jan 2026 15:05:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DA4758309A;
	Fri, 16 Jan 2026 16:05:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="oeeEanyB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 341F08367F; Fri, 16 Jan 2026 16:05:20 +0100 (CET)
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com
 [IPv6:2607:f8b0:4864:20::22d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C996A83015
 for <u-boot@lists.denx.de>; Fri, 16 Jan 2026 16:05:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22d.google.com with SMTP id
 5614622812f47-45ca17ef16eso220375b6e.0
 for <u-boot@lists.denx.de>; Fri, 16 Jan 2026 07:05:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1768575916; x=1769180716; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=q5cn0n9UCwgzWdqSp/XlCRcuTgGb6VLgq4EU06996Eg=;
 b=oeeEanyBty2IzP0KrHw5WoT2oGLzubzuNZKzCcA4w5TtVMo8tfGnlW1K4Iy3RuVeb8
 BBV7x9uLb/eLmATgMnZ2gR49Rswth7eYpA0S6AXGHHZ0WVluaQGVmdhOK7nsEqI0A4TK
 dbe58NJ8NVYafvEO2kvT2vTcqVDgdA9Rz40PI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768575916; x=1769180716;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=q5cn0n9UCwgzWdqSp/XlCRcuTgGb6VLgq4EU06996Eg=;
 b=VGi0DeHCqZYlD9ixtFMEIy2llSXtgA4thuQIGajLTdiz4TCGPPXQtASGeupIiCm+ng
 aX8niVPBORDRyvNiOc/0xQXp0QwVi/hSYE+BSV0lH57o+bs6pIUNdlPL1WEY2ogXbqQA
 fgoVlD8U4YIvQn6sqMNZtCxbDQitnJWosHj2HYeKBY0nzO0DDPiTOZGFDgrzaIreGc74
 IT5rP6R/Xt/MipdNS01emAx3l3j+KAV/YMrE+t34WG5rFWlnNmV2TS86CXCs/1N+LYNR
 Jr7h18Zcgo9YMBjyg2gkNVDD9Ph0HD6FsB2v+b/Epsi4LhEJQxhhofcdqZ25VarimmyS
 fOQw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVwtLHDmbXU6j1J8d+xAJUy7qz9sopozkg4j33Pev1kc/cvlsmLseR8tJ9dd8rbMRTDpDtETo4=@lists.denx.de
X-Gm-Message-State: AOJu0Yym7+vie6pqIHy1/qyfKZ0xiFjrgOpV5oy6UUVcjbIlUIV8T0xV
 VIKuOHwfBV1UcToYg9jdC3RsoC2K2/MMiKOGnAm3NyFPz5Iu4u7vOnrbq+mqZJ/Spfs=
X-Gm-Gg: AY/fxX65sTCN/neFpzIJFgenrQdrRVb1KP/NRzRSoQZIxS3sda4ASCzLfX6wz1HEPYY
 EblkB933Y9RoIdbqEk0GvPnETB3pMrO7aFylg04MctM0GL2v3OP5XTHN+8+1W2e5Y5akEyyHAVD
 NWYSCThhzaP6u2nCoj9JHF0yIE+Avszrc8mNktE5cINHYqD35MTe6WsWbI1oOXjOy5rqApFFqQN
 +XLAJnEkJRy5nPiIiB3yB39cuT5Bl7SfX/TLRFY8HiL+CRNWRHb0Uw3Cl+RUSYOaST7p9kxvC/E
 joXKUUP3OfGosgo8ZCWI2xP1wiD+CPfM09pJYSxiOCXZ3MJL0TPHG+ZrbrV3bXddaRwvW7HhiWI
 vxwuZYfQ/EHndmREuMmvnX+cxTbEYUzwwhj+JB5YVXg3cCxXBs4fiv2FGZGak0LpejaWAaC3tgs
 mmm7EyGWhvdEQtKgoXGDqQPHGXB/SX3YY13IHy0sO7oV47fB1ZI1dGn/i0MZPoNsoWZA798EMcV
 /qV8VEDDoqM/pLK2HQgq0cG3NhGZfna7YoFFOs=
X-Received: by 2002:a05:6808:3c4f:b0:44d:bdeb:f577 with SMTP id
 5614622812f47-45c9d82a6bemr1080265b6e.31.1768575916295; 
 Fri, 16 Jan 2026 07:05:16 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-45c9dff95a2sm1401738b6e.11.2026.01.16.07.05.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Jan 2026 07:05:15 -0800 (PST)
Date: Fri, 16 Jan 2026 09:05:13 -0600
From: Tom Rini <trini@konsulko.com>
To: Jamie.Gibbons@microchip.com
Cc: andrew.goodbody@linaro.org, u-boot@lists.denx.de,
 michael@amarulasolutions.com, Conor.Dooley@microchip.com,
 Valentina.FernandezAlanis@microchip.com, fberder@outlook.fr
Subject: Re: [PATCH v2 2/2] dm: core: Default to using DEVRES outside of xPL
Message-ID: <20260116150513.GL3416603@bill-the-cat>
References: <20251219202121.4180810-1-trini@konsulko.com>
 <20251227223833.3019311-1-trini@konsulko.com>
 <20251227223833.3019311-3-trini@konsulko.com>
 <ef5c3866fa673dd814264f1a26f73c5a9fb75b6b.camel@microchip.com>
 <20260114145842.GD3416603@bill-the-cat>
 <9fd13735b55dac213d23dc13309f0c3199be481e.camel@microchip.com>
 <8b4d8980c4c16a2d0f6e1b566f85034047c24fd5.camel@microchip.com>
 <20260115193130.GI3416603@bill-the-cat>
 <694fd0856209d75319393badf68188516c17d8f7.camel@microchip.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="InAHHBLy0+hSv5qy"
Content-Disposition: inline
In-Reply-To: <694fd0856209d75319393badf68188516c17d8f7.camel@microchip.com>
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


--InAHHBLy0+hSv5qy
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 16, 2026 at 01:59:21PM +0000, Jamie.Gibbons@microchip.com wrote:
> Hi Tom,
>=20
> On Thu, 2026-01-15 at 13:31 -0600, Tom Rini wrote:
> > On Thu, Jan 15, 2026 at 04:59:19PM +0000,
> > Jamie.Gibbons@microchip.com=C2=A0wrote:
> > > Hi Tom,
> > >=20
> > > On Thu, 2026-01-15 at 16:16 +0000, Jamie Gibbons wrote:
> > > > Hi Tom,
> > > >=20
> > > > On Wed, 2026-01-14 at 08:58 -0600, Tom Rini wrote:
> > > > > On Wed, Jan 14, 2026 at 02:33:04PM +0000,
> > > > > Jamie.Gibbons@microchip.com=C2=A0wrote:
> > > > > > Hi all,
> > > > > >=20
> > > > > > On Sat, 2025-12-27 at 16:37 -0600, Tom Rini wrote:
> > > > > > > The devm alloc functions that we have may follow the Linux
> > > > > > > kernel
> > > > > > > model
> > > > > > > where allocations are (almost always) automatically
> > > > > > > free()'d.
> > > > > > > However,
> > > > > > > quite often we don't enable, in full U-Boot, the tracking
> > > > > > > and
> > > > > > > free()'ing
> > > > > > > functionality. This in turn leads to memory leaks because
> > > > > > > the
> > > > > > > driver
> > > > > > > author expects that since the functions have the same name
> > > > > > > as in
> > > > > > > the
> > > > > > > Linux Kernel they have the same behavior. In turn we then
> > > > > > > get
> > > > > > > functionally correct commits such as commit 00e1fed93c8c
> > > > > > > ("firmware:
> > > > > > > ti_sci: Fix memory leaks in devm_ti_sci_get_of_resource")
> > > > > > > that
> > > > > > > manually
> > > > > > > add these calls. Rather than manually tracking allocations
> > > > > > > and
> > > > > > > implementing free()s, rework things so that we follow
> > > > > > > expectations
> > > > > > > by
> > > > > > > enabling the DEVRES functionality (outside of xPL phases).
> > > > > > >=20
> > > > > > > This turns DEVRES from a prompted symbol to a symbol that
> > > > > > > must
> > > > > > > be
> > > > > > > select'd, and we now remove our non-managed alloc/free
> > > > > > > functions
> > > > > > > from
> > > > > > > outside of xPL builds.
> > > > > > >=20
> > > > > > I=E2=80=99ve encountered a regression on the Microchip PolarFir=
e SoC
> > > > > > Icicle
> > > > > > Kit
> > > > > > with mainline U-Boot.
> > > > > >=20
> > > > > > After commit 217cf656e249 - the application of this patch
> > > > > > (=E2=80=9Cdm:
> > > > > > core:
> > > > > > Default to using DEVRES outside of xPL=E2=80=9D), U-Boot fails =
to boot
> > > > > > on
> > > > > > this
> > > > > > board. After this patch was applied the Icicle kit no longer
> > > > > > boots
> > > > > > and
> > > > > > crashes immediately after OpenSBI. Between this patch and
> > > > > > master
> > > > > > HEAD
> > > > > > the following errors are found - please see attached logs for
> > > > > > more
> > > > > > detail:
> > > > > >=20
> > > > > > =C2=A0=C2=A0=C2=A0 Failed to reserve memory for fdt at 0xbf3862=
10
> > > > > > =C2=A0=C2=A0=C2=A0 Required FDT relocation for applying DTOs fa=
iled: 1
> > > > > > =C2=A0=C2=A0=C2=A0 Could not find a valid device tree
> > > > > > =C2=A0=C2=A0=C2=A0 Device tree not found or missing FDT support
> > > > > > =C2=A0=C2=A0=C2=A0 ### ERROR ### Please RESET the board ###
> > > > > >=20
> > > > > > Sometimes, I also see an =E2=80=9CUnhandled exception: Illegal
> > > > > > instruction=E2=80=9D
> > > > > > and
> > > > > > a reset.
> > > > > >=20
> > > > > > The last known good commit is before this commmit. I used `git
> > > > > > bisect`
> > > > > > to confirm that 217cf656e249 (this patch) is the first bad
> > > > > > commit.
> > > > > >=20
> > > > > > Steps to reproduce:
> > > > > > - Build U-Boot for MPFS Icicle Kit
> > > > > > - Boot using HSS payload as usual - I use our build system
> > > > > > Buildroot
> > > > > > for
> > > > > > this
> > > > > > - Observe the boot failure after the above commit
> > > > > >=20
> > > > > > Any advise on the problem?
> > > > >=20
> > > > > It's really strange that it bisects down to this commit, rather
> > > > > than
> > > > > something device tree related. Do you still have
> > > > > fdt_high=3D0xffffffff
> > > > > or
> > > > > so set in the environment? It was in at least one of the logs,
> > > > > but I
> > > > > can't see for sure if it's just that the other log is from
> > > > > before
> > > > > the
> > > > > commit that added the print warning about not doing that, or if
> > > > > it
> > > > > wasn't set.
> > > > >=20
> > > > Apologies for the daly in my response, I wanted to do some more
> > > > debugging before getting back to you.
> > > >=20
> > > > Thanks for the suggestion about fdt_high. We have it set in our
> > > > boot
> > > > scripts. I chased this down with a bisect to 9235da9446e (boot:
> > > > Warn
> > > > users about fdt_high=3D~0 usage). I have now set fdt_high to our
> > > > maximum
> > > > addressable value instead of ~0. This does get rid of the warning
> > > > about
> > > > fdt_high in U-Boot, so that part is resolved.
> > > >=20
> > > > However, it doesn=E2=80=99t fix the underlying boot issue =E2=80=94=
 U-Boot still
> > > > fails
> > > > to boot altogether. During some bisections it often fails to apply
> > > > device tree overlays and doesn=E2=80=99t boot the kernel - I have a=
ttached
> > > > the
> > > > latest crash log.
> > > >=20
> > > > From my bisecting, the overlay breakage seems to start with the
> > > > DTC/libfdt update commit (0535e46d55d...). After that, overlay
> > > > application consistently fails, regardless of the fdt_high
> > > > settings.
> > > > As
> > > > an additional piece of information disabling MULT_DTB_FIT allows
> > > > the
> > > > board to boot as far as fdt error.
> > > >=20
> > > > Let me know if you have any other ideas.
> > > >=20
> > > > Thanks!
> > >=20
> > > Just for some further clarity, before the DEVRES Commit:
> > > =C2=A0- U-Boot boots fine with overlays disabled and fdt_high reset.
> > > =C2=A0- Overlay application causes FDT errors, but base boot works.
> > > After this DEVRES Commit (dm: core: Default to using DEVRES outside
> > > of
> > > xPL):
> > > =C2=A0- U-Boot does not boot at all =E2=80=94 no output, total crash.
> >=20
> > So to be clear, there's just nothing on the serial port from power on?
> > The initial logs I think confused the situation slightly. If no
> > output,
> > I would suggest bumping up SYS_MALLOC_F_LEN a little bit (maybe 0x2800
> > instead of 0x2000) and see.
> >=20
> Sorry for the confusion and thank you for your suggestion. I will
> attempt to clarify below.
>=20
> In summary, I found three issues in mainline U-Boot between the v2026.01
> tag and the master branch.
>=20
> 1. No boot (no output at all from U-Boot on the serial port) -
> introduced by 217cf656e24 dm: core: Default to using DEVRES outside of
> xPL - fixed by your suggestion above: s/CONFIG_SYS_MALLOC_F_LEN=3D0x2000/
> CONFIG_SYS_MALLOC_F_LEN=3D0x2800 in u-boot defconfigs
>=20
> 2. fdt_high warning - introduced by 9235da9446e boot: Warn users about
> fdt_high=3D~0 usage - fixed by: s/setenv fdt_high
> 0xffffffffffffffff/setenv fdt_high 0xbfffffffin in our build systems
> boot scripts
>=20
> 3. failed on fdt_open_into for DTO, i.e. overlay application fdt error -
> introduced by 0535e46d55d scripts/dtc: Update to upstream version
> v1.7.2-35-g52f07dcca47c - no fix implemented as of yet. Any suggestions
> on this are appreciated also.

Ah good. For #3, can you please start a new thread, and Cc Marek, and
include the full console long from power-on along with 'printenv' in
there before failure? That'll help figure things out.

--=20
Tom

--InAHHBLy0+hSv5qy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaWpTpQAKCRAr4qD1Cr/k
CmEgAQD1WpIlx5KNjJgvWwlW78rxgb1LlzPI7qTWqPgMfMzL7AEA+/hKWRzZ+TmP
cjkMTzns391E6nw21zGtFvQUUm7MLQc=
=YaJw
-----END PGP SIGNATURE-----

--InAHHBLy0+hSv5qy--
