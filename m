Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9ABB8E71090
	for <u-boot@archiver.kernel.org>; Thu, 21 Sep 2023 15:53:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0CFF4867B5;
	Thu, 21 Sep 2023 17:53:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="SU6ofO1r";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E0CB986484; Thu, 21 Sep 2023 17:53:46 +0200 (CEST)
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com
 [IPv6:2607:f8b0:4864:20::112e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CC47C86466
 for <u-boot@lists.denx.de>; Thu, 21 Sep 2023 17:53:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112e.google.com with SMTP id
 00721157ae682-59be6605e1dso13917597b3.3
 for <u-boot@lists.denx.de>; Thu, 21 Sep 2023 08:53:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1695311623; x=1695916423; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Sst3Kf4/n5KTIROS4NCnDVEXh9qcjg/AyD7TBEf9j7o=;
 b=SU6ofO1r0x3E3OXvG3UUa+ACSIY6AVCQFg+MgC2EIGHBa7cHeULsGSVUedVh5EbIxM
 u1C+/+5mZScPM5TLrRKo8/lCTfQDjKe5msWJbOPttITrPAasJxCMpSdA3poMz1D2+/FL
 ofpuVz+bGc9WpXJP8OSMYCj4Znk+6f/UugBxc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695311623; x=1695916423;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Sst3Kf4/n5KTIROS4NCnDVEXh9qcjg/AyD7TBEf9j7o=;
 b=C7n56e8bQT+tvbtmA2tvShSvBlPX0/apCRs8gznKoJ5uiKlQ1RQQjIFngSuA7biaSR
 ZyzaIjsgEHKfM4haKrP9a5Lj1rZL4l3Dtt6GkwiEjRlLf40gi38gZqwyzFEC4Z9IvJ0z
 h1zThZ888TP0CJM/QV2OBZbdvpZDwG5GJ4gns3HSTybA4Rdn5ZNhwwBzzZNjrXkE5GM9
 6W9ArLF5k0e1aLPD8UnN/3jdidZOyDpDRsi4gXgm3bNTX/iM4E1J8zji6p7MK4zna1by
 r0zTP87uU8eagvYQzQ62+KeZvA0w6W20kFkOWExpkzZq/nJcO6SoKDKZtH0Ar1aOskmz
 nEzw==
X-Gm-Message-State: AOJu0YwagZJ/p2jjsB8YWnMkeD5dPZPMHqiIQyjhDZRNE6y5FPc/0XNs
 1eZId6kcXbN0OG6Crt319N2Si3LQF9BHwJv47nW4kQ==
X-Google-Smtp-Source: AGHT+IGFMzT1dqGomXgEaKnzxxMuiQxICfolUqdbCn2FwiPihqnj0OypiPAdXbQC1ZxNKNdMvEixZQ==
X-Received: by 2002:a81:5256:0:b0:59b:dadf:298a with SMTP id
 g83-20020a815256000000b0059bdadf298amr6005691ywb.4.1695311623551; 
 Thu, 21 Sep 2023 08:53:43 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-46ac-83a0-07b5-e9a6.res6.spectrum.com.
 [2603:6081:7b00:6400:46ac:83a0:7b5:e9a6])
 by smtp.gmail.com with ESMTPSA id
 j128-20020a0dc786000000b005928ba6806dsm393385ywd.97.2023.09.21.08.53.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Sep 2023 08:53:43 -0700 (PDT)
Date: Thu, 21 Sep 2023 11:53:41 -0400
From: Tom Rini <trini@konsulko.com>
To: Daniel Schwierzeck <daniel.schwierzeck@gmail.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, u-boot@lists.denx.de
Subject: Re: [PATCH] bmips: Add Inteno XG6846 board
Message-ID: <20230921155341.GU305624@bill-the-cat>
References: <20230920074225.1130769-1-linus.walleij@linaro.org>
 <20230920142252.GO305624@bill-the-cat>
 <CACRpkdYqO1nH51VxjbpnPjaPy7eHaMDCSP5tWBDB1SB3R0cCcQ@mail.gmail.com>
 <20230920185547.GP305624@bill-the-cat>
 <ea1b9ef4-0cf5-ed92-2b70-6d8f70be17ac@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="fH0+IcmVRAThUovc"
Content-Disposition: inline
In-Reply-To: <ea1b9ef4-0cf5-ed92-2b70-6d8f70be17ac@gmail.com>
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


--fH0+IcmVRAThUovc
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 21, 2023 at 04:00:24PM +0200, Daniel Schwierzeck wrote:
>=20
>=20
> On 9/20/23 20:55, Tom Rini wrote:
> > On Wed, Sep 20, 2023 at 08:51:07PM +0200, Linus Walleij wrote:
> > > On Wed, Sep 20, 2023 at 4:22=E2=80=AFPM Tom Rini <trini@konsulko.com>=
 wrote:
> > >=20
> > > > > + * This is a diet version of the device tree from Linux,
> > > > > + * suitable for U-Boot.
> > > > > + */
> > > >=20
> > > > We shouldn't need a diet version of the tree.  If it's reasonably d=
one
> > > > and stable in the kernel, we can even move towards just passing the
> > > > U-Boot tree along to Linux.
> > >=20
> > > The device tree is not stable in the kernel.
> > > It exists in OpenWrt and the creators of the bmips target are
> > > kind of absent for the moment. The reason it is not in Linux
> > > is that the "switch ethernet" driver and bindings need to be
> > > upstreamed before the device trees can be upstreamed.
> > >=20
> > > But I can try to bring in more of it for sure :)
> >=20
> > Just like ARM the goal is just to drop in the kernel dts here.
>=20
> I guess this approach works well for ARM but not for MIPS. Most MIPS cons=
umer boards
> are just maintained in OpenWRT but not in mainline Linux. And there are a=
 few boards
> which have been just mainlined in U-Boot but not Linux so them also don't=
 have a
> stable Linux DT.
>=20
> As MIPS is a dead architecture I suggest to just go with the minimal DT s=
uited for U-Boot ;)

OK, I'll let it go then.

> > > > > +++ b/board/inteno/xg6846/xg6846.c
> > > > > @@ -0,0 +1,6 @@
> > > > > +// SPDX-License-Identifier: GPL-2.0+
> > > > > +/*
> > > > > + * Copyright (C) 2023 Linus Walleij <linusw@kernel.org>
> > > > > + */
> > > > > +
> > > > > +#include <common.h>
> > > >=20
> > > > So basically just an empty object file.  Can we just _not_ have
> > > > something here, if we perhaps don't set SYS_BOARD?  I assume if the=
re's
> > > > just nothing here the link rules fail.
> > >=20
> > > Admittedly my knowledge of U-Boot internals are not the
> > > best and this is a bit of a copy and paste job from
> > > board/comtrend/ar5387un/ar-5387un.c which looks like
> > > this and sets a bad example I suppose.
> >=20
> > Yeah, I didn't know we had someone doing that already here, whoops.
> >=20
> > > I guess you are asking me to modify U-Boots build system to
> > > make the whole .c and Makefile inside a board subdir optional
> > > so we can delete all such empty boardfiles?
> >=20
> > Well, it'd sure be nice if we could avoid having a dummy C file.  If
> > it looks like a nightmare once you take a peek, we can just live with
> > it.
> >=20
>=20
> I just tested it, you can simply add an empty board/inteno/xg6846/Makefil=
e and
> remove board/inteno/xg6846/xg6846.c. But you can also remove the Makefile.
> Just the Kconfig and MAINTAINERS file are needed.

Oh nice, thanks!

--=20
Tom

--fH0+IcmVRAThUovc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmUMZwIACgkQFHw5/5Y0
tywmJAv+M4etkHcs1+IhndxLK85ZtbhCMdb0k5zDtah8zAXnYzUI0/qxt2jezORJ
lRZiZuX/DsahtNUOewj8hr1x7iA2bfZiJzoIYgpME9BGnKTgcobfo07VkrqTkBSc
rWIwz+Hl5M7bcwX1NTNbckjoR1qi042ez58mT0BV2+c9vEuzh4AF3mvccRfaQsd8
b36y1CIbUujAcwiYXwpc2X79Rja/8mxBLuABqZOcsQXCXD8zSg96cmKBgf7rt0xo
GSorT6NBFCc4LKbEGQzDx28Mu55uRpD63E6gfm5GsIgD6DMHWPkV9tSxFQmiPeS5
sgd3A91I4+nENJmMBsZsJy9JRA8k3dKwkIxIMkoWly5nfGeH+OsM/jp9vWxpayaM
p/KQvXX5NRM57zoxTN64eqdYIdMoCVZ8IRgPW+GpOLAbuXjfMNw+0xYnWppeRtfZ
ZO6GVFOOFJ4btynzpmjD5+eHzybC0T9oneRInVtX03Ro0HqI0J/oKjcTAMaYfZcu
YYNXIcgi
=HyWJ
-----END PGP SIGNATURE-----

--fH0+IcmVRAThUovc--
