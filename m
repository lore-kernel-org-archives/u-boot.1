Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E186CD11DF
	for <u-boot@archiver.kernel.org>; Thu, 28 Mar 2024 20:02:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1376D88216;
	Thu, 28 Mar 2024 21:02:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Xpe7aGMZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D70F7881DD; Thu, 28 Mar 2024 21:02:14 +0100 (CET)
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com
 [IPv6:2607:f8b0:4864:20::72c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C1F2B881DB
 for <u-boot@lists.denx.de>; Thu, 28 Mar 2024 21:02:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72c.google.com with SMTP id
 af79cd13be357-78a5580333bso88600785a.2
 for <u-boot@lists.denx.de>; Thu, 28 Mar 2024 13:02:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1711656131; x=1712260931; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=qGYflGPa5wpR7WWncWrd9hPbwMGdxBZN7zbXGyO5YwA=;
 b=Xpe7aGMZjgseRd3V8pFmGIAE/FFaJKYfuENS6+A23xHEY422BgobnRnPrMQ0MUJlIK
 z2zw6gII+Qi9OfRcG1Vvkmjl7oulkrTYYJq7WcuqWM1Nzghu7eFliEY5y8niAUSaAUjn
 rEjSyUxFDDFzVzZ/ZM8I0NaOgvAXGSdLpSPxs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711656131; x=1712260931;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qGYflGPa5wpR7WWncWrd9hPbwMGdxBZN7zbXGyO5YwA=;
 b=RjuE8WT+j4+yg36mqligzmU3sRY0UiH/TAgl4+g6YLX5decWUndMJZB9oSlE4taZ9I
 EhT1xQ3TPc2gpLSCEE7+Vmi4rAr5pNuzqXDcV3aiT0FWhgfLtUGEa+Ck8pbE4k2PIjbr
 C/eFObwHV7rjmB76/+9blSK5HnQnh6/+WrPzr9ua04lJEN53NHTTT008IFfzQcmVoE+Y
 3iXEATCeA86QCzKRlU9ghr1WWdMk+dm68Ob3oKVUpRNIHeTUxehLLttnzKgAeEpnrqi1
 JZgN+0cqyiCRVKr3D5pLGeoX+p+LupPHeiW6Mnvgk0glB0MpV0P44EL8q9Lic8Gpqs8Q
 sbmQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWQgSQJwPY4kJVIkQYJc8mAEXzf81mdrxqyJxBFeRvR8U4jzLpFnzaxI7pXpxSuYdzHZQTFVL12EbZEQ/jDITeSzqY9iQ==
X-Gm-Message-State: AOJu0YyVEq2YQ8WK5tE+A9hGXj1LbdJg5bYZs8WxLRoQp1oZ4dbO/db/
 fpyR9T9xbEHw3HNwU/9WO1r0LsPEPkUbitOj4Obl+QDXeMlprJ0eO7Nam8ccL4U=
X-Google-Smtp-Source: AGHT+IEmye2KMUmomMi1CLqFLZSRSkhVB+JHOcYv1BsY9FGb/HcS/1RB+wsN8bYx8NEs9WSrV1P1SA==
X-Received: by 2002:a05:620a:29d4:b0:78b:c6bc:84d0 with SMTP id
 s20-20020a05620a29d400b0078bc6bc84d0mr474821qkp.47.1711656131651; 
 Thu, 28 Mar 2024 13:02:11 -0700 (PDT)
Received: from bill-the-cat (065-184-193-066.res.spectrum.com. [65.184.193.66])
 by smtp.gmail.com with ESMTPSA id
 j1-20020a05620a000100b0078bc5612d15sm209408qki.127.2024.03.28.13.02.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Mar 2024 13:02:11 -0700 (PDT)
Date: Thu, 28 Mar 2024 16:02:09 -0400
From: Tom Rini <trini@konsulko.com>
To: Chris Morgan <macromorgan@hotmail.com>
Cc: Eugen Hristev <eugen.hristev@collabora.com>,
 Kever Yang <kever.yang@rock-chips.com>,
 Chris Morgan <macroalpha82@gmail.com>, u-boot@lists.denx.de,
 xypron.glpk@gmx.de, cym@rock-chips.com, philipp.tomsich@vrull.eu,
 sjg@chromium.org, jonas@kwiboo.se
Subject: Re: [PATCH 1/2] rockchip: rk3588: Add support for ATAG parsing
Message-ID: <20240328200209.GE3442575@bill-the-cat>
References: <20240326204944.1572667-1-macroalpha82@gmail.com>
 <20240326204944.1572667-2-macroalpha82@gmail.com>
 <fe9eef97-5814-4d25-8357-60873d565aff@rock-chips.com>
 <DM4PR05MB9229EA8B503F50C94DDA5212A5342@DM4PR05MB9229.namprd05.prod.outlook.com>
 <9541747b-b05c-4bb2-bf73-d720659905d2@collabora.com>
 <DM4PR05MB92298DB9B7803B3E0ABC0137A5342@DM4PR05MB9229.namprd05.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="MjA6wiX3vGFfPdSp"
Content-Disposition: inline
In-Reply-To: <DM4PR05MB92298DB9B7803B3E0ABC0137A5342@DM4PR05MB9229.namprd05.prod.outlook.com>
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


--MjA6wiX3vGFfPdSp
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 27, 2024 at 10:03:11AM -0500, Chris Morgan wrote:
> On Wed, Mar 27, 2024 at 04:21:49PM +0200, Eugen Hristev wrote:
> > On 3/27/24 15:32, Chris Morgan wrote:
> > > On Wed, Mar 27, 2024 at 06:32:06PM +0800, Kever Yang wrote:
> > >> Hi Chris,
> > >>
> > >> =A0=A0=A0 The ATAGS is used for passing parameter from bootloader to=
 kernel at
> > >> first, which has been replaced by DTB now for ARM platform.
> > >>
> > >> =A0=A0=A0 And Rockchip using ATAGs for passing parameter like dram m=
emory
> > >> size/board uart in different boot process like DRAM init binary/ TPL=
/SPL to
> > >> U-Boot since 2018.
> > >>
> > >> =A0=A0=A0 And almost at the same time, Simon add bloblist for mainli=
ne U-Boot
> > >> which for similar purpose.
> > >>
> > >> =A0=A0=A0 So I'm not sure if this ATAGS should be accept in mainline=
 U-Boot or
> > >> not, even for rockchip platform only seems some kind of regression f=
or this
> > >> feature support.
> > >>
> > >>
> > >> Hi Simon and Tom,
> > >>
> > >> =A0=A0=A0=A0 Could you help to give some suggestion for this?
> > >>
> > >=20
> > > I really meant to do this as an "RFC", so I apologize in advance for
> > > possibly causing more work in treating this as a full-fledged patch.
> > >=20
> > > The problem I'm trying to solve is that I've got 2 boards, a Rock 5B
> > > as well as an Indiedroid Nova both with 16GB of RAM. I noticed that
> > > without the memory holes the Rock 5B defined in my Indiedroid it would
> > > also fail to boot. I've got 2 other boards as well with less than 16GB
> > > of RAM which seem to work fine without any holes (a 4GB Indiedroid No=
va
> > > prototype and a GameForce Ace with 12GB of RAM).
> >=20
> > Hi,
> >=20
> > When I initially added these holes in the memory, I tried to ask Rockch=
ip what are
> > the holes for. I didn't get any answer, however the patches to reserve =
the holes
> > were accepted.
> > If we could get more information about why the holes are there, if that=
 area is
> > specific to something, or that it's fixed in a per-SoC basis, we could =
reserve it
> > by hardcoding in the Linux DT, without the need for ATAGs.
> > Without real information, we cannot be sure that for other variants of =
the SoC or
> > some other bootrom configuration, the holes will not change/move.
> >=20
> > Eugen
>=20
> It's not *just* about the holes, but also making sure we use the full
> extent of the RAM. For example on my 4GB Indiedroid Nova the existing
> logic ignores about 256MB of RAM that's otherwise present. When we
> use the existing code the RAM map reported by Linux is as follows:
>=20
> [    0.000000] Early memory node ranges
> [    0.000000]   node   0: [mem 0x0000000000200000-0x00000000efffffff]
>=20
> Whereas when we do ATAGS parsing to set the banks we get the following:
>=20
> [    0.000000] Early memory node ranges
> [    0.000000]   node   0: [mem 0x0000000000200000-0x00000000efffffff]
> [    0.000000]   node   0: [mem 0x00000001f0000000-0x00000001ffffffff]
>=20
> So basically the issue is two-fold... one we need to create the memory
> holes when necessary, and two the current method of defining memory
> banks leaves some RAM unallocated. Parsing the ATAGS does both of these,
> I'm just curious if it's the RIGHT way or there's something else I'm
> missing...

It's unfortunate that all of this is in the wild, from the Rockchip
side. The best answer is that the platform should be passing all of this
along via bloblist. I would hope that future platforms will do that. For
now yes, I guess we need to constrain this ATAG parsing to rockchip as
much as we can and use it.

--=20
Tom

--MjA6wiX3vGFfPdSp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmYFzMEACgkQFHw5/5Y0
tyyf1gv/VP2XGhHUt1fU6NYqexSsLQ1oGSq3zHbxOuM1uLV+HJKLPRUHYKSzXCqA
IjKYLGH7rGO+qC4R55rN/7WSJfkldydMTUnnu9/LcE25S8jGruXtS+DR0eRCtvE4
tNoJJ6X9QizwN7Xa3+hLSkTO7kh9a4+t9MWBvKoESh0uNNKPm3ZCKn+wFmoE4F+Z
8HrawBsbQDyWJuQJYh1dykN18AIU3XPy22H0vKjlugs1ITDNE+FixjKBIwakND+B
8+puDsBHcM42mwIXbQOMCJxYh3FZQUidGMWOexi17lqDahSk1NkyA5QJeAca4ts5
t+MFBA4AR8NihbL1VKliVoF1mYhckxVOj+hNJjmbeQlBfsseZ4yqQOD8QJuAMmMi
EUIDzujLEfwN2ixHIxY19Z+v0fjgv0jmSrushv/YxZYCnzfuwOB+FZ6i6BqunBgQ
f9FRpm7N2gOFcxaFnQ+nGadO73d2tkZuYvUtUcQzOPlg8vnIYdG8l5HhxbNG1FUC
J3fcTBx6
=2dYh
-----END PGP SIGNATURE-----

--MjA6wiX3vGFfPdSp--
