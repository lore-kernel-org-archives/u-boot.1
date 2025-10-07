Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CEFFCCA470
	for <u-boot@archiver.kernel.org>; Tue,  7 Oct 2025 13:50:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A460E83D92;
	Tue,  7 Oct 2025 15:50:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="G6ksIU3T";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7631F83D9F; Tue,  7 Oct 2025 15:50:16 +0200 (CEST)
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com
 [IPv6:2607:f8b0:4864:20::230])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5522483D86
 for <u-boot@lists.denx.de>; Tue,  7 Oct 2025 15:50:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x230.google.com with SMTP id
 5614622812f47-43f988447b4so1457135b6e.0
 for <u-boot@lists.denx.de>; Tue, 07 Oct 2025 06:50:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1759845013; x=1760449813; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=2Gd+fbzwiVS3EGFvUVox5WxoeG3nJ388i0rs8gJLf8M=;
 b=G6ksIU3TUdBSZ6IuGWRBK9518+HKMDr+ermQttsM/+CX174OdOEwkrLVB6oGj4b/JI
 n4UvjTmp5FMg61UAlu3Hor36psORSYoVxWHXGV+vfNMOpJWrv9y9llzkPVnrS7f4Az4q
 eAFnpEOAl1JkjdcTHhgtdZJKSAv6cF8vTUGIA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759845013; x=1760449813;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2Gd+fbzwiVS3EGFvUVox5WxoeG3nJ388i0rs8gJLf8M=;
 b=QJgK7HXFl/rwUw363JO0MqQq9wcQfirCfIerdraUu0i9LMprg4mVQCZ+hGNBYCHYF0
 8dD139SUtGpQiqHEJimkGqypCNR2ZHT6oHIqx00HdwXoeOWrWrAS4gXauXHVz2cli5k+
 cOsG7kN++toSjOsLJUi1S8n5qLYdU52pGx4LqAtjbF0MtJlwfpPhL9kYGoeUJLc7az64
 g21ioHXl3wI14d7MN4oPlUw8F+LS2/TFhp875GlYzCFNaiA9lYw+18+rk/EGpEBEL4hx
 SaA/3EkjbsdCjwTaP0CM9NRynUl7U08RxBF7yjGhwOUCaeg5pQGcKyX//6t6TQXV4Ly5
 ZxWw==
X-Gm-Message-State: AOJu0YwWPpjZqTcWYuRlmOAbtTJS9nlM4N+gks6QpJ+aGK1ROKB9aUGO
 7y/CHkjcbYMGp9Qg86gyLlZw0aMyNJS96k4nyXiip0yixxD/dWTX8AsD8OGTu0h8gac=
X-Gm-Gg: ASbGncuLCddYee+wK0PKyiUSB0u0noPq2r2EYZq8Eyi9y7g97qewX+mxqrIXWkWG0h/
 Se7A8PoX0xJ1k0Pcx1gn04+KcBrSTihI9ABY4pV4hIKre7RCHLo99f1bz4F74rG5Qu2XmkG15AG
 hLoPE9DNuZrRu5fOctYM5qpGRQ49CveKumYln8QUj16zD8yTJnA8tzBmhYm3wXLr+Kx1/vFWt44
 pUnRfgsLopDGf31Y3sniaP+rdyyPr7bOsCMJO+dRJSJdxOmDAh3SNp0zzouvHocerk12uWLFMnj
 /U7A0KxFqEv9FwT7C2hIFLaTpMBR3dOopEJxgJC2pzLXHx7HFgnUhCYtNgfpq4/6p0RWEpFTCxZ
 huHrejAKj81sCxoPTRhv80AyomfsvATW1HMbFIckI+HtApo3M6YlO1P7C6y6BiDdLfV1ur+t77s
 02VbAFBGSJ2A==
X-Google-Smtp-Source: AGHT+IHiOjE/4xi0OVWQIy+JaSBq+6fezkK1LpT4vG7ABnFJzDitvzFU/pIlNxOtYxW8cailJna+ag==
X-Received: by 2002:a05:6808:13c4:b0:43b:252e:f7aa with SMTP id
 5614622812f47-43fc179e4b2mr7787675b6e.21.1759845012843; 
 Tue, 07 Oct 2025 06:50:12 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-43fb25a271asm3517195b6e.24.2025.10.07.06.50.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Oct 2025 06:50:11 -0700 (PDT)
Date: Tue, 7 Oct 2025 07:50:09 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>
Subject: Re: [PATCH v2 05/17] boot: Move showing of bootflows out of the
 command
Message-ID: <20251007135009.GI298503@bill-the-cat>
References: <20251001212649.3263574-1-sjg@chromium.org>
 <20251001212649.3263574-6-sjg@chromium.org>
 <20251002201537.GO6093@bill-the-cat>
 <CAFLszTigwz2mVfS=C6yXDnTMvdGxw=FsD36QCrpS2VOVSr+7nA@mail.gmail.com>
 <20251006234500.GG298503@bill-the-cat>
 <CAFLszTgEoEN=+QocxEXewkwe-wjOKeNRMn5YWSvHcOcaLR2qsA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="cn2012fmV704YuW+"
Content-Disposition: inline
In-Reply-To: <CAFLszTgEoEN=+QocxEXewkwe-wjOKeNRMn5YWSvHcOcaLR2qsA@mail.gmail.com>
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


--cn2012fmV704YuW+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 07, 2025 at 05:13:55AM -0600, Simon Glass wrote:
> Hi Tom,
>=20
> On Mon, 6 Oct 2025 at 17:45, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Mon, Oct 06, 2025 at 05:30:23PM -0600, Simon Glass wrote:
> > > Hi Tom,
> > >
> > > On Thu, 2 Oct 2025 at 14:15, Tom Rini <trini@konsulko.com> wrote:
> > > >
> > > > On Wed, Oct 01, 2025 at 03:26:30PM -0600, Simon Glass wrote:
> > > >
> > > > > It is helpful in tests to be able to show the bootflow that is be=
ing
> > > > > examined. Move show_bootflow() into boot/ and rename it.
> > > > >
> > > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > > ---
> > > > >
> > > > > Changes in v2:
> > > > > - Add a log_err() for an invalid state
> > > > >
> > > > >  boot/bootflow.c    | 57 ++++++++++++++++++++++++++++++++++++++
> > > > >  cmd/bootflow.c     | 68 ++--------------------------------------=
------
> > > > >  include/bootflow.h |  9 ++++++
> > > > >  3 files changed, 69 insertions(+), 65 deletions(-)
> > > > [snip]
> > > > > +     case BOOTFLOWST_COUNT:
> > > > > +             log_err("Unexpected boot value of bootflow error %d=
",
> > > > > +                      bflow->state);
> > > >
> > > > A small thing, checkpatch.pl catches that this isn't aligned with t=
he '('
> > > > here as it should be.
> > >
> > > OK. I'm unsure whether I really want this line anyway, since it
> > > increases code size.
> > >
> > > >
> > > > A larger thing, and please correct me if I'm wrong, but on reading =
the
> > > > whole set of changes, this move + rename just means we're putting m=
ore
> > > > info in the test output, and nothing else?
> > >
> > > It will also appear if you have CONFIG BOOTSTD_FULL and use 'bootflow
> > > list' or 'bootflow scan -l'.
> >
> > But that should be the case before this patch as well, yes?
>=20
> Yes, that's right. This is just moving the code into a place where it
> can be used from tests.

But it's not being used from tests, with this series.

--=20
Tom

--cn2012fmV704YuW+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaOUajQAKCRAr4qD1Cr/k
CjPbAQCkT5AUpi/+FQpDIMR2sYBXBeMB7litui9GeDyNqkok5wEA4dRlgsuJA2li
CN/sAr+NRsS5IqEZ67AmUKtYGxkKSwU=
=AIeH
-----END PGP SIGNATURE-----

--cn2012fmV704YuW+--
