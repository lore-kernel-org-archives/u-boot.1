Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60383CD11DD
	for <u-boot@archiver.kernel.org>; Thu, 28 Mar 2024 22:13:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9B6888820B;
	Thu, 28 Mar 2024 23:13:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="CcBaGRsJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 80A1487D0A; Thu, 28 Mar 2024 23:13:21 +0100 (CET)
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com
 [IPv6:2607:f8b0:4864:20::f30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 56A0B8573F
 for <u-boot@lists.denx.de>; Thu, 28 Mar 2024 23:13:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf30.google.com with SMTP id
 6a1803df08f44-69675e3be15so9158886d6.1
 for <u-boot@lists.denx.de>; Thu, 28 Mar 2024 15:13:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1711663998; x=1712268798; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=5IlAWvGj7Lqoe5SXOdCV7FYeSjP64VW6gZKtww70dEg=;
 b=CcBaGRsJ0nb/8UK4kl78NTnsBwfGH8FjXMX7b4vZcnUUhy087qWIilNOKc66FK5Y1p
 g0d2EVeZu505j/j+0Kr74CWbmJzTl5cPMRSPDy/JENU+Cd2YJpnF1Yx07WQZZ/ZO95qJ
 4sFNAkNseXxcT3A5YUbfAbjRkoXUgYQOMyuPE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711663998; x=1712268798;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5IlAWvGj7Lqoe5SXOdCV7FYeSjP64VW6gZKtww70dEg=;
 b=WoF/SJOIqJR5WMLrj6zh8j0vedhJ4AdAm25rhwFYPRfaSlx364/RVixQZw1vsYRZD9
 ELNWVX3nNCmK1yJ8GZWoV6ZV5ccHw8B1l+7RnZqgEESmmNYZF0nDCMjMRhKnx2h7GcGD
 +tvgR3L6PEMvfD684dHP1r3mGlrVZjO1EfhBomoMWfsBleSgdskd75RPjSk1jL9QXxF7
 ptUha3JxZLDf1whfUls2GfTLqRzZBOf9mcrXhWpvQTLNGD9fuRLtnjXRf9Ys+btreNE0
 8IIXdfkv+Y62RRkEbSaSYoPjQ1EnrtYAKdPbg3vPbX9XWtiGOeI3R5nbq7T4yzlSIvJ+
 eZmQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCURigBzcCVD02jmRpLYdeMKFqXvivG2HWk367iHJ6U5hL68uduc1Bb21LinTS5S8LbvL5ijwosmaygBDFPKDwxZvEzL9Q==
X-Gm-Message-State: AOJu0YxIQc+gOYn4JbDUSvCPXdqQ+DgeHarinrfpGylbaVHkkPNjVoJD
 zSISwgTASWDOZ14Wnk1tjnH0r2pcnCwbVs7rBWlvn/e6Ma+hzCp81DzsDyeioKI=
X-Google-Smtp-Source: AGHT+IEJCQV9NrjmfdScNCJhbEGt0rw/MdmnbH/0fJUDTz4N2fdzUY7mYOMg9ZCCJmxntCXv08xICA==
X-Received: by 2002:a05:6214:293:b0:691:815d:d78e with SMTP id
 l19-20020a056214029300b00691815dd78emr603139qvv.39.1711663998104; 
 Thu, 28 Mar 2024 15:13:18 -0700 (PDT)
Received: from bill-the-cat (065-184-193-066.res.spectrum.com. [65.184.193.66])
 by smtp.gmail.com with ESMTPSA id
 ny12-20020a056214398c00b0069699bda3d9sm1034142qvb.33.2024.03.28.15.13.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Mar 2024 15:13:17 -0700 (PDT)
Date: Thu, 28 Mar 2024 18:13:15 -0400
From: Tom Rini <trini@konsulko.com>
To: Chris Morgan <macromorgan@hotmail.com>
Cc: Eugen Hristev <eugen.hristev@collabora.com>,
 Kever Yang <kever.yang@rock-chips.com>,
 Chris Morgan <macroalpha82@gmail.com>, u-boot@lists.denx.de,
 xypron.glpk@gmx.de, cym@rock-chips.com, philipp.tomsich@vrull.eu,
 sjg@chromium.org, jonas@kwiboo.se
Subject: Re: [PATCH 1/2] rockchip: rk3588: Add support for ATAG parsing
Message-ID: <20240328221315.GA3179022@bill-the-cat>
References: <20240326204944.1572667-1-macroalpha82@gmail.com>
 <20240326204944.1572667-2-macroalpha82@gmail.com>
 <fe9eef97-5814-4d25-8357-60873d565aff@rock-chips.com>
 <DM4PR05MB9229EA8B503F50C94DDA5212A5342@DM4PR05MB9229.namprd05.prod.outlook.com>
 <9541747b-b05c-4bb2-bf73-d720659905d2@collabora.com>
 <DM4PR05MB92298DB9B7803B3E0ABC0137A5342@DM4PR05MB9229.namprd05.prod.outlook.com>
 <20240328200209.GE3442575@bill-the-cat>
 <DM4PR05MB92294A5E8F160BF82B4E46EFA53B2@DM4PR05MB9229.namprd05.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="j/y9nBl4V4QgR65T"
Content-Disposition: inline
In-Reply-To: <DM4PR05MB92294A5E8F160BF82B4E46EFA53B2@DM4PR05MB9229.namprd05.prod.outlook.com>
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


--j/y9nBl4V4QgR65T
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 28, 2024 at 04:58:53PM -0500, Chris Morgan wrote:
> On Thu, Mar 28, 2024 at 04:02:09PM -0400, Tom Rini wrote:
> > On Wed, Mar 27, 2024 at 10:03:11AM -0500, Chris Morgan wrote:
> > > On Wed, Mar 27, 2024 at 04:21:49PM +0200, Eugen Hristev wrote:
> > > > On 3/27/24 15:32, Chris Morgan wrote:
> > > > > On Wed, Mar 27, 2024 at 06:32:06PM +0800, Kever Yang wrote:
> > > > >> Hi Chris,
> > > > >>
> > > > >> =A0=A0=A0 The ATAGS is used for passing parameter from bootloade=
r to kernel at
> > > > >> first, which has been replaced by DTB now for ARM platform.
> > > > >>
> > > > >> =A0=A0=A0 And Rockchip using ATAGs for passing parameter like dr=
am memory
> > > > >> size/board uart in different boot process like DRAM init binary/=
 TPL/SPL to
> > > > >> U-Boot since 2018.
> > > > >>
> > > > >> =A0=A0=A0 And almost at the same time, Simon add bloblist for ma=
inline U-Boot
> > > > >> which for similar purpose.
> > > > >>
> > > > >> =A0=A0=A0 So I'm not sure if this ATAGS should be accept in main=
line U-Boot or
> > > > >> not, even for rockchip platform only seems some kind of regressi=
on for this
> > > > >> feature support.
> > > > >>
> > > > >>
> > > > >> Hi Simon and Tom,
> > > > >>
> > > > >> =A0=A0=A0=A0 Could you help to give some suggestion for this?
> > > > >>
> > > > >=20
> > > > > I really meant to do this as an "RFC", so I apologize in advance =
for
> > > > > possibly causing more work in treating this as a full-fledged pat=
ch.
> > > > >=20
> > > > > The problem I'm trying to solve is that I've got 2 boards, a Rock=
 5B
> > > > > as well as an Indiedroid Nova both with 16GB of RAM. I noticed th=
at
> > > > > without the memory holes the Rock 5B defined in my Indiedroid it =
would
> > > > > also fail to boot. I've got 2 other boards as well with less than=
 16GB
> > > > > of RAM which seem to work fine without any holes (a 4GB Indiedroi=
d Nova
> > > > > prototype and a GameForce Ace with 12GB of RAM).
> > > >=20
> > > > Hi,
> > > >=20
> > > > When I initially added these holes in the memory, I tried to ask Ro=
ckchip what are
> > > > the holes for. I didn't get any answer, however the patches to rese=
rve the holes
> > > > were accepted.
> > > > If we could get more information about why the holes are there, if =
that area is
> > > > specific to something, or that it's fixed in a per-SoC basis, we co=
uld reserve it
> > > > by hardcoding in the Linux DT, without the need for ATAGs.
> > > > Without real information, we cannot be sure that for other variants=
 of the SoC or
> > > > some other bootrom configuration, the holes will not change/move.
> > > >=20
> > > > Eugen
> > >=20
> > > It's not *just* about the holes, but also making sure we use the full
> > > extent of the RAM. For example on my 4GB Indiedroid Nova the existing
> > > logic ignores about 256MB of RAM that's otherwise present. When we
> > > use the existing code the RAM map reported by Linux is as follows:
> > >=20
> > > [    0.000000] Early memory node ranges
> > > [    0.000000]   node   0: [mem 0x0000000000200000-0x00000000efffffff]
> > >=20
> > > Whereas when we do ATAGS parsing to set the banks we get the followin=
g:
> > >=20
> > > [    0.000000] Early memory node ranges
> > > [    0.000000]   node   0: [mem 0x0000000000200000-0x00000000efffffff]
> > > [    0.000000]   node   0: [mem 0x00000001f0000000-0x00000001ffffffff]
> > >=20
> > > So basically the issue is two-fold... one we need to create the memory
> > > holes when necessary, and two the current method of defining memory
> > > banks leaves some RAM unallocated. Parsing the ATAGS does both of the=
se,
> > > I'm just curious if it's the RIGHT way or there's something else I'm
> > > missing...
> >=20
> > It's unfortunate that all of this is in the wild, from the Rockchip
> > side. The best answer is that the platform should be passing all of this
> > along via bloblist. I would hope that future platforms will do that. For
> > now yes, I guess we need to constrain this ATAG parsing to rockchip as
> > much as we can and use it.
>=20
> Any thought/benefit of trying to force the ATAGS into a bloblist after the
> fact (instead of expecting it to be passed that way)?  Otherwise yes I'll
> work on simplified ATAGS parsing for the memory info and constrain it to
> the rk3588 specific board code/wrap it around ROCKCHIP_TPL present.

I don't think it's worth the code size to convert the ATAGS to bloblist
at this time. In the future when we have rockchip platforms that pass
bloblist natively at that point it might make sense to convert the ATAGS
instead.

--=20
Tom

--j/y9nBl4V4QgR65T
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmYF63gACgkQFHw5/5Y0
tywNvQv+JK1Pk7iRdM+wUycJQYVBbS/RRhs8Ofnvee223h27//asd+usdha7A0oc
uJ5r0iykShz9DRt2aiSBgAtWOHek++74asyTljjk8rAlH3VsGktZaPfZWy9nfrjG
HRLratIEexPsNa9tuyYWsTBWfkT06+PswxD3HG8qdPTqbmsnOm9NOgFSrBGlfYGT
cAR6MfFUU/5y8OQbzopr6U5o76QutUd6k5pmfKob+WT0IN8nazMHx+bhmsbOk7/j
/w1LyoKOnIUrX+JnbjWnN9Mvb1z0bTysgwnTj5uvjKGurLKfzbX/Xb8S3B897Wg/
5XTXDd1e2NzvDTFG67Ps7o7bm0AZUpWXtMUDIEzUrxNhLqMjN6m1YpJT4Adoirxg
gHYmR+1ch+gmaRVdM856WZiOtekYr7L06VQroczb45mN/nfWwipMZjuFwA8nj7pC
WSSmQjAGCo9plN8KtLoQdyOSSiqQ2aJ2kfTuKU3cMATHOF8WfazLhwXjhby16bQ5
V+qZ1JyV
=laNn
-----END PGP SIGNATURE-----

--j/y9nBl4V4QgR65T--
