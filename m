Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 704F1E7717F
	for <u-boot@archiver.kernel.org>; Tue, 17 Dec 2024 19:57:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DEDEE8021A;
	Tue, 17 Dec 2024 20:57:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ACB1IfLa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D18EF8022F; Tue, 17 Dec 2024 20:57:42 +0100 (CET)
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com
 [IPv6:2607:f8b0:4864:20::731])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5D28580107
 for <u-boot@lists.denx.de>; Tue, 17 Dec 2024 20:57:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x731.google.com with SMTP id
 af79cd13be357-7b6ef047e9bso5133585a.1
 for <u-boot@lists.denx.de>; Tue, 17 Dec 2024 11:57:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1734465459; x=1735070259; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Eo1GC76gx+CaubOCBObaAfsmYaN2jeSRSkQgaH5Kou0=;
 b=ACB1IfLa9QFzluFM1K3nlA4Z5zmElF6ShV3TBZI7FXAhGC79yy0IJiXW04029jkOuC
 bFP6Mxk0vRu3rNaH3BNsoOBIKFZlejBC8espV/CiTkUPaLamULsHXMHao3pF+gSA/NVn
 2CIP8bme8DycVBjasQDOdAW4I2j82MtEEuXUY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734465459; x=1735070259;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Eo1GC76gx+CaubOCBObaAfsmYaN2jeSRSkQgaH5Kou0=;
 b=m26W2LQj35GQKvoFSG61FsHoNu0aB2Chbq6LnfbSxTgRrj27ZfUdqkBs6Sn7HzkuhA
 uk2V6rQJ2uDtFRDq1orZoMwwk/4zoljuD3u0Zo9EVVv2ToK+NCIs70DG5q4z7tGg7yxk
 GvhzWJcBzkCGBdvn/WLiV5a9BM9lDex8dX7en7MWzwo6Af4wQ3ZbVzJC+G7kQBp+qKag
 k9zwy+esrAmcUNOgn70r54qwdicbqXprdb2yPzHUozkx2TA/6Lsk9q1KpEI+n1ipjsby
 YFoyrloLms/oam4JgOWplxQXOKG/6Wuusz8SVCqvXIfrHkPG2Tcm+pQokn+YtX2o5J/U
 aGWg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVEodimcxW6CaEhK0t+S8MOOfevStw9jhoQRg6qiBxHXiSOXMPU2D8019oIBPf94/rggyy4xt4=@lists.denx.de
X-Gm-Message-State: AOJu0YxBzU03/7zJla7/xMP7gBS3oZbgiSMhaigKZB6qc6xM3241XslA
 9++6JZ4ZzXy9/5qBMZ8Csq7sN833/Bm7aqDvVqRL08Zn7tvYR7R30yf3VgywYfk=
X-Gm-Gg: ASbGnctrzU47rJwgWAwF38MW4wZn+DOiqe9kaIHk0Zk3l85cY+CeHrcAoJLND9eUc+g
 csbwzpHW/sNzlzgmSipnL4dtA2Ae0I7mfEaaXwZHgZ5wTXv7/no6dZtX1k3KwMCVpiuvXkOPNVA
 waLBOWuokNtczYasWKWPTXWrKq7/81dRYR7IJ2G8eC0ZHcqN597wwR79KDGzYscoEaETpAHWj2v
 RsahHEhYb10bDJiW6wzYfN/HwZpHhIOdIZGF01DBgLgLFsCrQ9esDM+
X-Google-Smtp-Source: AGHT+IFj5zBLCsd4n3IF/VKGU6l4U6AJ7MBUHdMQjpMOGEQayTmtBy7I1wuUJScSRCJTmdlKFBNrgA==
X-Received: by 2002:a05:620a:4084:b0:7a9:a356:a5dd with SMTP id
 af79cd13be357-7b86368fe34mr12782685a.20.1734465459208; 
 Tue, 17 Dec 2024 11:57:39 -0800 (PST)
Received: from bill-the-cat ([187.144.29.192])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b7047d5de0sm349424785a.35.2024.12.17.11.57.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Dec 2024 11:57:38 -0800 (PST)
Date: Tue, 17 Dec 2024 13:57:34 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: Bryan Brattlof <bb@ti.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 "Leon M. Busch-George" <leon@georgemail.eu>,
 Marek Vasut <marex@denx.de>, Matthew Garrett <mgarrett@aurora.tech>,
 Raymond Mao <raymond.mao@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Sam Edwards <CFSworks@gmail.com>, Sumit Garg <sumit.garg@linaro.org>,
 U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: [PATCH 1/3] efi: Correct logic for OF_EMBED and OF_SEPARATE
 co-existing
Message-ID: <20241217195734.GR1505244@bill-the-cat>
References: <20241211004503.3775922-2-sjg@chromium.org>
 <20241211004503.3775922-1-sjg@chromium.org>
 <CAFLszTjHyhwf0dV8THPDswXz58jRCW+ZX90Hr4_i7PjXsVHPBA@mail.gmail.com>
 <20241217142527.GL1505244@bill-the-cat>
 <CAFLszTg93ddp3r2Bmv+p-wKRBDxVYqz2mQ56etGqSWCGUjo6Jw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="QiFyRDLagytM5HUa"
Content-Disposition: inline
In-Reply-To: <CAFLszTg93ddp3r2Bmv+p-wKRBDxVYqz2mQ56etGqSWCGUjo6Jw@mail.gmail.com>
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


--QiFyRDLagytM5HUa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 17, 2024 at 12:46:17PM -0700, Simon Glass wrote:
> Hi Tom,
>=20
> On Tue, 17 Dec 2024 at 07:25, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Tue, Dec 17, 2024 at 08:00:56AM -0600, Simon Glass wrote:
> >
> > > While we do plan to switch to OF_SEPARATE now it is supported, it see=
ms
> > > worth at least showing how OF_EMBED could be used instead, just for t=
he
> > > record.
> > >
> > > So make the Makefile rule conditional on OF_SEPARATE and adjust fdtdec
> > > to avoid a build error when OF_EMBED is used.
> > >
> > > Finally. the dtb symbol has a double underscore, so update it to avoi=
d a
> > > build warning.
> > >
> > > With future patches, OF_EMBED will no-longer be used with the EFI app,
> > > so it is expected that it will eventually stop working.
> > >
> > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > Fixes: 2e7bf25f6bf ("Support separate DTB files with the UEFI app")
> > > ---
> > >
> > >  Makefile                       | 2 +-
> > >  include/asm-generic/sections.h | 2 +-
> > >  lib/fdtdec.c                   | 2 +-
> > >  3 files changed, 3 insertions(+), 3 deletions(-)
> > >
> > > Applied to sjg/master, thanks!
> >
> > Since you've picked up several series that no one was objecting to and
> > providing reasonable feedback on and applied them to your own tree, do
> > you plan to squash/rebase them and repost so they can be applied to
> > master / next at some point?
>=20
> The original EFI-app series actually had objections in toto. Did you
> not see the comments from Heinrich?

I assume you mean:
https://patchwork.ozlabs.org/project/uboot/patch/20241123195616.305687-2-mj=
g59@srcf.ucam.org/#3419029
which is a question.

> I've offered to send pull requests every now and then, to keep things
> in sync, if that is your goal? But I don't believe I can do that for
> particular patches/series. It is going to be hard enough for me to
> just maintain my own tree, let along dealing with your/Linaro tree.

I find you calling the mainline project tree "your/Linaro tree"
offensive. And I'm again asking you to explain in public what you are
doing exactly.

--=20
Tom

--QiFyRDLagytM5HUa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmdh164ACgkQFHw5/5Y0
tyyNQwv+IEn9RGhnZlyOzBg3G5LVRavDM9OjUE6d6zE3KPl8THNCoGuvoo6YUnrH
aVzfu3FRJTTte1rfiUqNQdYE9uP5uvVlSlYJuPYCL7HCKqRqu7q8f9yjBegqlOCN
mMd2/Dt5EPF/m0tLjU2isqF+G6ZYDZZgqszksJgEIJAP4hiPo6buqxY9wT3h1DLB
ttHNBJGPONFm6RAxEau3Q/H9L4oxdndBuhhqSfryRWCuXMZgmHLGFjvDcQYuMMJ3
hJ30dasoc/nhh2ZxVPt2Va0o1ZJJECFPF8bj+L2YcvyXNSsxQ5K0F8f+U8M2xnjZ
7ddi8CoCLGgKzsi5c7wpFUpKoJVgYfcCVfzZpq96gMqhlRYnPyi+qaoVs/igbX7y
/Ss9R7KxHjPwMJV5XW2h+BwGaqRTdyqfKpj2Vam2H5w1xn1vS04ojMosI7pfbRKg
kPcMt/ZCkGQaYO9Bf3h89KSDuqyp/Qit2A0E4mmj+VtGAbyUeSzRExpIJWiKd3Y0
pZf77wzs
=Wpcq
-----END PGP SIGNATURE-----

--QiFyRDLagytM5HUa--
