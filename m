Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DB01CAC58E
	for <u-boot@archiver.kernel.org>; Thu, 11 Sep 2025 14:49:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F04FC833AD;
	Thu, 11 Sep 2025 16:49:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Q9Z3tYLm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C0885833D1; Thu, 11 Sep 2025 16:49:07 +0200 (CEST)
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com
 [IPv6:2001:4860:4864:20::2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EAED68334F
 for <u-boot@lists.denx.de>; Thu, 11 Sep 2025 16:49:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2a.google.com with SMTP id
 586e51a60fabf-314f332e064so130219fac.2
 for <u-boot@lists.denx.de>; Thu, 11 Sep 2025 07:49:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1757602143; x=1758206943; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=FWqt6CFmjzCSrKhlPnE0kBHekERdlohmpyt5yonwXU8=;
 b=Q9Z3tYLmS5IhWnmQsY5OTYfNcf2/xCqu0b6SpQeNP3bozmuYGToQyUkWmubKGcyQBW
 Ac+9/JmR10mRWXhxYsQ8BsTOBBM6DLpCQXkKVGwzghd9mP5GN9fIZETDSpnloL5GqLA4
 Xuo6N28yYglnKk7G1g47VWp1Ax+brH1mzlTxQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757602143; x=1758206943;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FWqt6CFmjzCSrKhlPnE0kBHekERdlohmpyt5yonwXU8=;
 b=tvjyhZGp3s2ssC6PUIPsFhKYSDcsHX9LuQbTSS+xUP9xLOeQtNYS0u0Xp+ooCs5eYR
 QlSEnyUVI+6jDe53ZD7DSfE4Aw8xyrfUJjUHGD+AtnCImgFOSAliZ/Rnlya8N+Yl2BAI
 fw51IveowD5DjunGPmvSjYTLGcU3DPfHuNrFs7rkdGA7N5wRoAxJTW6NOd6SdZEsPN56
 8Q0GnhmpTW8lHnm6whHtyF8JFo9Jjfqvhth72cEWLGbgf4jNLNlJBrrinWzKfBWdZSC5
 Qb0oWCEbkbxMrMl0wsoCvhYp3IZxwkJW9TgZ9ptNCMgZdPbbLBa94zQfbA3DEwdDfYyc
 QVKA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVYcg4q64LxJnAxQk7eOLKZY2tqhJZLbu6L/TXRH564NISysO/VU4gSCWnqLrQ7FvaRJH7XEUI=@lists.denx.de
X-Gm-Message-State: AOJu0Yys6rM3t1WuYDYGvXOf/yqi2LKgcD0o+++Jl95BxI2TUTWZddxy
 vB8ccQWL2pdDDIo7LTuAehYtdXqgC/ddyXhLupZny12Esrj6clwdG1s8HA1+BRffJ+c=
X-Gm-Gg: ASbGncvT+jbjylbJ2m6XoSzqlNqg/xQHWK4u72VYs50uKFD7aijKVvkGxOUTqrbMKZr
 46hNQo1FCxFPdr3xo3kSIoQdO0IlPPdpGlyHpWJoa47QC1b01h7UQT64Ikn9jlVDio7kVVgzvXm
 qeBgWKnIDMKk0BJnwL1KlUUAcDGqIE+kzNbhHECfzBj8w4M6qBFdynQ7W1LSMZtC53JT9GWa0jc
 eAS4diZyPG9Ho9xBjfxB7p0c+mXkaPWOIyQTem11UKzlJDT4GqEXwUCsYNwA0C2g2iL5SJZGUoQ
 GOpiha94WB71azvg8JO4R3aRN8APlrael7tD1zad4BIkRvsoPNcTqVrq3nqOfQEJE0tIWaFtXKu
 q4PGEPWl1O1jYey0xkpkNhCGO76PRPVCFPezZUvk3XmQ5Ddheyap/HC3V3hj615QY6AE=
X-Google-Smtp-Source: AGHT+IE4QHOWZSW8n6NUBlz2afUH8tcbUIsw3MPgN8BsQHPzshsSadbHsvJet8YEjIWbeMv4Tz+kZw==
X-Received: by 2002:a05:6870:a11e:b0:30b:cd02:297c with SMTP id
 586e51a60fabf-3226542f9a3mr9647883fac.35.1757602143529; 
 Thu, 11 Sep 2025 07:49:03 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-32d357d2f9fsm452876fac.24.2025.09.11.07.49.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Sep 2025 07:49:02 -0700 (PDT)
Date: Thu, 11 Sep 2025 08:49:00 -0600
From: Tom Rini <trini@konsulko.com>
To: "Yuslaimi, Alif Zakuan" <alif.zakuan.yuslaimi@altera.com>
Cc: Peng Fan <peng.fan@nxp.com>, "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 "Chee, Tien Fong" <tien.fong.chee@altera.com>,
 Simon Glass <sjg@chromium.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>
Subject: Re: [PATCH v2 1/3] include: dt-bindings: clk: agilex: Add Agilex
 clock definitions header file
Message-ID: <20250911144900.GL124814@bill-the-cat>
References: <20250909021116.12599-1-alif.zakuan.yuslaimi@altera.com>
 <20250909021116.12599-2-alif.zakuan.yuslaimi@altera.com>
 <PAXPR04MB84591699BEC41960D222BB6D8809A@PAXPR04MB8459.eurprd04.prod.outlook.com>
 <PH7PR03MB7063972B766EC67BA14BA639AD09A@PH7PR03MB7063.namprd03.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="JXQtLjA7WI9kdDsw"
Content-Disposition: inline
In-Reply-To: <PH7PR03MB7063972B766EC67BA14BA639AD09A@PH7PR03MB7063.namprd03.prod.outlook.com>
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


--JXQtLjA7WI9kdDsw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 11, 2025 at 07:17:32AM +0000, Yuslaimi, Alif Zakuan wrote:
> Hi,
>=20
> > -----Original Message-----
> > From: Peng Fan <peng.fan@nxp.com>
> > Sent: Thursday, September 11, 2025 2:23 PM
> > To: Yuslaimi, Alif Zakuan <alif.zakuan.yuslaimi@altera.com>; u-
> > boot@lists.denx.de
> > Cc: Tom Rini <trini@konsulko.com>; Lukasz Majewski <lukma@denx.de>; Sean
> > Anderson <seanga2@gmail.com>; Jaehoon Chung
> > <jh80.chung@samsung.com>; Chee, Tien Fong <tien.fong.chee@altera.com>;
> > Simon Glass <sjg@chromium.org>; Marek Vasut
> > <marek.vasut+renesas@mailbox.org>; Simon Goldschmidt
> > <simon.k.r.goldschmidt@gmail.com>
> > Subject: RE: [PATCH v2 1/3] include: dt-bindings: clk: agilex: Add Agil=
ex clock
> > definitions header file
> >=20
> > [CAUTION: This email is from outside your organization. Unless you trus=
t the
> > sender, do not click on links or open attachments as it may be a fraudu=
lent email
> > attempting to steal your information and/or compromise your computer.]
> >=20
> > > Subject: [PATCH v2 1/3] include: dt-bindings: clk: agilex: Add Agilex
> > > clock definitions header file
> > > From: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
> > >
> > > Introduce header file to define the clock indexes for the Agilex plat=
form.
> > >
> > > Signed-off-by: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
> > > ---
> > >  include/dt-bindings/clock/agilex-clock.h | 71
> >=20
> > This not landed into linux kernel?
> >=20
>=20
> The existing Agilex clock header file in Linux mainline is outdated and
> missing several clock ID definitions required by the current U-Boot clock=
 driver.
> =20
> To avoid dependency on Linux upstream progress, this patch introduces
> a self-contained copy of the updated Agilex clock header file within U-Bo=
ot.
>=20
> This ensures U-Boot on Agilex can be built and function correctly with th=
e latest
> values for the clock driver.
>=20
> We can clean this up later once the latest version of the clock header fi=
le has been
> upstreamed into Linux mainline and synced over to U-Boot.

What's the progress on syncing this to Linux? I am OK with this path IF
and only IF once this is in upstream Linux any conflicts will be quickly
resolved here in U-Boot to use the upstream header.

--=20
Tom

--JXQtLjA7WI9kdDsw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaMLhWQAKCRAr4qD1Cr/k
CmwdAPwJYaeVC3kpyDh+hFE56ldhfBe3/z8EirwnYxIIzt5rsQEAoEUrLrKdctaF
i29ipFkfIm1WUC8X3z1od+EGCWqzCQw=
=5zyC
-----END PGP SIGNATURE-----

--JXQtLjA7WI9kdDsw--
