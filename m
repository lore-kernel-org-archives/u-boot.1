Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6513C3DA6E
	for <u-boot@archiver.kernel.org>; Thu, 28 Dec 2023 20:44:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2D39587A08;
	Thu, 28 Dec 2023 21:44:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="cHL04lZg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D5C4687A72; Thu, 28 Dec 2023 21:44:32 +0100 (CET)
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com
 [IPv6:2607:f8b0:4864:20::112f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4E4DE879FF
 for <u-boot@lists.denx.de>; Thu, 28 Dec 2023 21:44:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112f.google.com with SMTP id
 00721157ae682-5d7a47d06eeso56860607b3.1
 for <u-boot@lists.denx.de>; Thu, 28 Dec 2023 12:44:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1703796269; x=1704401069; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=P63PH8us0frKpXY4zFrkIQz9VYSgcgRgh6OxtI9wwWk=;
 b=cHL04lZgRNmnFTJMKz6Z4MuTjo7FAUh9s9NO1yXOqpmjm2nF1XOFN6aWOqmPpeUOrQ
 QVDgIBg7uzavkOqnujRyPiwHATSwf2Gcz+A0vjpfRyDiJDVzOcscxOoSk9zIlTZA+t9k
 g0XUTgcuOIH1iT4BoMdyRgMffT3tNDOCo3od0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703796269; x=1704401069;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=P63PH8us0frKpXY4zFrkIQz9VYSgcgRgh6OxtI9wwWk=;
 b=bzUjmYrMLZyGbMFFAaRKGpdsbdCpyKAX6SQz5y2ApkjyxKRC5J7H+R80VUla3egxsE
 TsJL75+Vg4C9eiVLFBZ2BbTDoGnKAmxjCnmgqkhSG3rsyS19j8HOcurBFxT5q0vAHRT3
 Y1BuKZe2Q0w6VE3wswz+0ugYmUeia6rmGQc80ZYbRNdJjbjjaA5yrO6vPe9YFrsJiOTO
 bQxkegGT5AthCjF7ZNuFUSCc88L2AI619yB6IJ+ajnH4EKr69peiKjed7WG9+tybwnJx
 wUr29QDFAU844hu+Gw4Vzx8L5PF6b61VrsUX+j2dOe5rC3RvkNsm94zTa1pE9psl3Qyh
 yEOg==
X-Gm-Message-State: AOJu0Yzs7szW7+3Aq5oIQX7Qoo54jYBHYB2vVXthZi6ruafesJh9hJu4
 uqTRsEuyaenc7czKHk4zNCU1qsOXvta43w==
X-Google-Smtp-Source: AGHT+IENUsF45h1P1J2iHyWnKph1L1ZgbVmn6m+G2hCIDO+uXCB1PF67MN68VQ+vfGfRSdOTrIPySg==
X-Received: by 2002:a05:690c:2b93:b0:5ee:cb7e:4865 with SMTP id
 en19-20020a05690c2b9300b005eecb7e4865mr1514251ywb.8.1703796268920; 
 Thu, 28 Dec 2023 12:44:28 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-3119-0000-0000-0000-1001.res6.spectrum.com.
 [2603:6081:7b00:3119::1001]) by smtp.gmail.com with ESMTPSA id
 m187-20020a8171c4000000b005d781a2e123sm7773449ywc.109.2023.12.28.12.44.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Dec 2023 12:44:28 -0800 (PST)
Date: Thu, 28 Dec 2023 15:44:25 -0500
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Sumit Garg <sumit.garg@linaro.org>,
 Albert Aribaud <albert.u.boot@aribaud.net>,
 Andreas =?iso-8859-1?Q?Bie=DFmann?= <andreas@biessmann.org>,
 Michal Simek <michal.simek@amd.com>,
 Michal Simek <monstr@monstr.eu>, Minkyu Kang <mk7.kang@samsung.com>,
 Scott McNutt <smcnutt@psyent.com>, Thomas Chou <thomas@wytron.com.tw>
Subject: Re: [PATCH 0/9] dts: Move to SoC-specific build rules
Message-ID: <20231228204425.GQ2652760@bill-the-cat>
References: <20231227082405.2202246-1-sjg@chromium.org>
 <20231227132156.GQ2652760@bill-the-cat>
 <CAFLszThBrAVSH2jYxhxFSETqr4za+BqjZBBjLaDokc1ZdrXXRw@mail.gmail.com>
 <20231228142311.GD2652760@bill-the-cat>
 <CAFLszTghB1ZObpxUe+afAp2zzQOfn2M9198ofsgnyW9cseG2Ew@mail.gmail.com>
 <20231228154019.GH2652760@bill-the-cat>
 <CAFLszTgZfAHATieERE1x8hhoFHpYDK4Vq4=VVmQapKEn63diyA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="rkLoE9Rd4+ezsZmc"
Content-Disposition: inline
In-Reply-To: <CAFLszTgZfAHATieERE1x8hhoFHpYDK4Vq4=VVmQapKEn63diyA@mail.gmail.com>
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


--rkLoE9Rd4+ezsZmc
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 28, 2023 at 07:48:08PM +0000, Simon Glass wrote:
> Hi Tom,
>=20
> On Thu, Dec 28, 2023 at 3:40=E2=80=AFPM Tom Rini <trini@konsulko.com> wro=
te:
> >
> > On Thu, Dec 28, 2023 at 03:09:40PM +0000, Simon Glass wrote:
> > > Hi Tom,
> > >
> > > On Thu, Dec 28, 2023 at 2:23=E2=80=AFPM Tom Rini <trini@konsulko.com>=
 wrote:
> > > >
> > > > On Thu, Dec 28, 2023 at 01:37:07PM +0000, Simon Glass wrote:
> > > > > Hi Tom,
> > > > >
> > > > > On Wed, Dec 27, 2023 at 1:21=E2=80=AFPM Tom Rini <trini@konsulko.=
com> wrote:
> > > > > >
> > > > > > On Wed, Dec 27, 2023 at 08:23:56AM +0000, Simon Glass wrote:
> > > > > >
> > > > > > > U-Boot builds devicetree binaries from its source tree. As pa=
rt of the
> > > > > > > Kconfig conversion, the Makefiles were updated to align with =
how this
> > > > > > > is done in Linux: a single target for each SoC is used to bui=
ld all the
> > > > > > > .dtb files for that SoC.
> > > > > > >
> > > > > > > Since then, the Makefiles have devolved in some cases, result=
ing in
> > > > > > > lots of target-specific build rules. Also Linux has moved to =
using
> > > > > > > subdirectories for each vendor.
> > > > > > >
> > > > > > > Recent work aims to allow U-Boot to directly use devicetree f=
iles from
> > > > > > > Linux. This would be easier if the directory structure were t=
he same.
> > > > > > > Another recent discussion involved dropping the build rules a=
ltogether.
> > > > > > >
> > > > > > > This series makes a start at cleaning up some of the build ru=
les, to
> > > > > > > reduce the amount of code and make it easier to add new board=
s for the
> > > > > > > same SoC.
> > > > > > >
> > > > > > > One issue is that the ARCH_xxx Kconfig options between U-Boot=
 and Linux
> > > > > > > are not always the same. Given the large number of SoCs and b=
oards
> > > > > > > supported by U-Boot, it would be useful to align these where =
possible.
> > > > > >
> > > > > > I don't know why we should start with this now, and further not=
 being on
> > > > > > top of Sumit's series to remove our duplicate dts files. And th=
at's
> > > > > > where we can have the conversation about for which cases it eve=
n makes
> > > > > > sense to build all of the dts files for a given SoC.
> > > > >
> > > > > This is a completely different series - there are no conflicts wi=
th
> > > > > Sumit's series so it can be applied before or after it.
> > > > >
> > > > > My goal here is to clean up our build rules, rather than just thr=
owing
> > > > > them all away, for reasons we have discussed previously. I filed =
[1]
> > > > > to track that.
> > > >
> > > > Yes, I'm saying we shouldn't be doing anything this series does unt=
il
> > > > after Sumit's series has landed. Along with the fact that I don't l=
ike
> > > > what's going on in this series.
> > >
> > > This seems to again be the disagreement over whether a single DT
> > > should be build for each board, or all the DTs for an SoC?
> >
> > It's about the disagreement on what we should be building, and what that
> > infrastructure looks like. I do not like adding extra rules for
> > "clarity" because they don't make things clearer, they lead to the
> > unclear mess we have today getting worse. Most instructions are _not_
> > "now take this dtb and this binary and .." but just "take this binary",
> > because we already have the rules and logic to ensure we build the
> > required dtbs. I also don't like the parts of this series that amount
> > to deck shuffling when we should just be taking the chairs away. There's
> > just not nor will there be a case for omap3/4/5 platforms of "change the
> > dtb", so building more is pointless. For other SoCs, there may be some
> > cases of "this could have been just a DT change", like
> > rock5b-rk3588_defconfig / rock5a-rk3588s_defconfig could share a board
> > dir, but the configs are different and the dts are different, so I don't
> > know that you could really just swap the dtbs.
>=20
> It is true that we have a different defconfig for each board, but IMO
> that is not good. It is an artifact of the way the build system works.
> IMO Kconfig should be used to define sensible defaults so that the
> defconfigs are nearly empty. Perhaps config fragments can be part of
> the mix, if we can agree on [1].
>=20
> But if we let this genie out of the bottle, it will be impossible to
> put back in. The devicetree should control the hardware in U-Boot and
> it should be possible to use the same U-Boot proper on all boards
> which use the same SoC.

We've never been past the point where a few examples of closely related
boards can re-use the same U-Boot build and just change the device tree.

It's going to be very SoC specific if we can ever do things like that,
and it will also likely in turn become a question of where did the
tricky bits that U-Boot used to do get shoved instead. You're not going
to combine board/beagle/beagle/beagle.c and board/ti/omap3evm/evm.c (and
ignoring all of the other omap3 boards) and get one binary that works on
both, and just uses DT. Let alone that no one wants to do that work.

You've mentioned Rockchip before as maybe a better example, but
https://patchwork.ozlabs.org/project/uboot/list/?series=3D383579&state=3D* =
was
leading me to think that no, there's too much "this is what THIS
hardware does" that means that no, there's going to be hardware
variation that one must just handle in C. Or get more and new bindings
accepted upstream to try and make that be data driven, and also possibly
have to deal with "that's policy, not hardware" type arguments and so
forth.

> [1] https://patchwork.ozlabs.org/user/todo/uboot/?series=3D380278

Note that patchwork is annoying here and that for a series you've
assigned, you need to click on a patch in it, then the series link again
to get:
https://patchwork.ozlabs.org/project/uboot/list/?series=3D380278
which works for everyone. And append '&state=3D*' so that archive links
will still show it later once it's been accepted or superseded or what
have you.

--=20
Tom

--rkLoE9Rd4+ezsZmc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmWN3iYACgkQFHw5/5Y0
tyzclwwAhNAEN0K4cYF2/khkKihA76I4QEelpMIIZVnBu+Viloa8e1a8BTEeO4or
96/Im195FRk+g8mjSzb5cgm2sa71h9WS8UFWKMPLHMowY3BJZd35UeWOjUUkx+y1
cF9yHm/wzlus/W6DDI+db9IeiN0z+CdzoJTaBgocNsPUUA+pNFNpjsr4eP1ONwCR
AQztX7/ruDQSwHz0LMLYjyK3xWAM6cJ5TYFTjecQWVK8eCLYHpVr5MwUt6CaIr1g
giEtyTN5s9pLW2oc7vHxEbypSdHVEpyek3+BQ04+xibDioaboLH0Z2LmrWhNKiBD
LSS3e5NXWbtvBsDs5o0vgdDrPbRVD96/u13zhZMR+g0lyAhySvKvWz0vmsWj2v2p
XB8mk/XTjJKNAvfJGm/A5pAGgqkQj3CgpJ1y+Dxx1oiaSHGA/U9iSfoV5F3RofbT
KUy7D3yV3Mkb/oVYpF2j9a9KioskzqRs7judkeIriNYoGuc7yi2V3mHOSFpQdnl7
WGaJH76j
=5Z7w
-----END PGP SIGNATURE-----

--rkLoE9Rd4+ezsZmc--
