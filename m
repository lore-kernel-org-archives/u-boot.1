Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46B39CCFA02
	for <u-boot@archiver.kernel.org>; Fri, 31 Oct 2025 19:00:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7D71A83AAC;
	Fri, 31 Oct 2025 20:00:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="a/fSFoPN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AFACB83AAD; Fri, 31 Oct 2025 20:00:10 +0100 (CET)
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com
 [IPv6:2001:4860:4864:20::30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7B91683A32
 for <u-boot@lists.denx.de>; Fri, 31 Oct 2025 20:00:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x30.google.com with SMTP id
 586e51a60fabf-3c9a42d6349so2960700fac.1
 for <u-boot@lists.denx.de>; Fri, 31 Oct 2025 12:00:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1761937207; x=1762542007; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=n44dZkyPhKw9lzY1QPQCSDnJ2zNqoZVhui5gm8i55GA=;
 b=a/fSFoPNwwytImRjxqd99G2+DOOOnVzH5SLdGvlnOtH+g11NDc3rgP2mx5zlhLcJMP
 OebJ1dfKrnyk5tG4J7EPcxJa8Rn4KR7fBhIrAy1au2d4zuj2ZABTp328CrfFOweLMKj8
 7mO7FkCJEhAD4gC2m77FRcj7Q8gZ7RVV5sVbM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761937207; x=1762542007;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=n44dZkyPhKw9lzY1QPQCSDnJ2zNqoZVhui5gm8i55GA=;
 b=n4oA8JVHG79A+SJODfWaVxC8UCz7KVflWPPBGF4BHyn5LFM3ZPvgP0VvYVxxdhasd/
 f9tILQlW1oLhNJE3lwFdnHus2oaCJ7/1HoV+ifUJ1wHQeZuv+r/pwaGf62M1eXfyvIcl
 D3gzduzr2QIrYJ0rxIj4F8qidxk3WhgrUeODbshrHg+EcmXTLjNrQvx1y8nrSJsFieYA
 Vcl/ePq5/0MGjsi0tF51sdhowxCkY6dC0FK3qJS9xuv3hn6fQ2p1FFV1FZPvt2fuBwKH
 gylJgZcgPt/oB6DaOkvzThNRzFmygJH+D+RKOtrKz2Te3MlPaRXREpNuH4iiSrl9/sgk
 X4lg==
X-Forwarded-Encrypted: i=1;
 AJvYcCX9z4xaiBtwvJD8WTTLv3gmGYnLAG434wBsCZBodvN6+zk7vr/4exkR17QPM5ZZN5rBZngNhs8=@lists.denx.de
X-Gm-Message-State: AOJu0Yw3646WKq5/+E+N3XFxUW4rtYF14wfud7aYWsoNHv7v/65xUlOA
 bBPheRE5MdqJoOdrLvdrDgljzCHUPW9NyXsl2PeUka9P4w/Xvtbkoc1u47bGro3eqOhzJHYZy0Q
 cRXtQa0nBEQ==
X-Gm-Gg: ASbGncvYrPTzSZpCwV5sCqn4Ryqsed67K0KA508UW/e2/HlFVCS4qyvIoCtvaJUdyXP
 3FrCgPN82abedPnOI4LnpKYyZHL11yydp679NSppHMb4xnNH1rGIdCtzUwCwncOesa41qQtIkhN
 ++AuGLTp2o8v6/GSmThGwT8iZ69Ro7bjv+j7MaCFV4gSEzB0wZ0xFxcaw1XcDX229oABNCWwcVR
 RC8zoRRhzWT/3qWcy7/YHusMyuuswZ5/GDTania2pXg5JtY5g4itbDHlagSh+w4Ai2y+k7+7Cyf
 41oKC82hS0DpQZVjAxlh6bsSprtqLYARVdhcUSKtdgyH3tBXzVQP9PDl7qUYnx1jdPf9Pk1AhK1
 pOYq8QXvFDKPpRgQcV5HMhYmoDqCKa6MwyUmfA5RaxnNnEsNlIgSSj92ahE3FX2sx3GA8EePop+
 Vio9EJotEf0bKHo1TcHh94sDpdPyBP9Dj1TnHVmLaaL3nBL1Zf6A==
X-Google-Smtp-Source: AGHT+IEHiN9J4OLXy/jvIhoexKw3ddFr0rjS959kn5epUgJzEkhOcoLxln+nKFwlgt51jHf0Ot8rLQ==
X-Received: by 2002:a05:6870:9610:b0:3d4:97:cc1f with SMTP id
 586e51a60fabf-3dacbfbc58cmr2378218fac.26.1761937207092; 
 Fri, 31 Oct 2025 12:00:07 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-3db40d8ef47sm829999fac.10.2025.10.31.12.00.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 Oct 2025 12:00:05 -0700 (PDT)
Date: Fri, 31 Oct 2025 13:00:03 -0600
From: Tom Rini <trini@konsulko.com>
To: Marek Vasut <marek.vasut@mailbox.org>
Cc: Beiyan Yun <root@infi.wang>, u-boot@lists.denx.de,
 Yao Zi <ziyao@disroot.org>, Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Siddharth Vadapalli <s-vadapalli@ti.com>
Subject: Re: [PATCH v4 1/5] net: phy: aquantia: refresh format
Message-ID: <20251031190003.GF6688@bill-the-cat>
References: <20251031152348.60571-1-root@infi.wang>
 <20251031152348.60571-2-root@infi.wang>
 <ac552ba3-832c-4cfb-aa39-c80949df7900@mailbox.org>
 <C2649793-C878-4906-BDF4-0410DA9F12A2@infi.wang>
 <304efeca-2529-4241-a9fe-7f305f8b430c@mailbox.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="6LvUsuRkrreNEwR4"
Content-Disposition: inline
In-Reply-To: <304efeca-2529-4241-a9fe-7f305f8b430c@mailbox.org>
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


--6LvUsuRkrreNEwR4
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 31, 2025 at 07:33:13PM +0100, Marek Vasut wrote:
> On 10/31/25 6:21 PM, Beiyan Yun wrote:
> >=20
> >=20
> > > On 31 Oct 2025, at 11:51=E2=80=AFPM, Marek Vasut <marek.vasut@mailbox=
=2Eorg> wrote:
> > >=20
> > > On 10/31/25 4:21 PM, Beiyan Yun wrote:
> > > > Refresh format using clang-format.
> > > > Signed-off-by: Beiyan Yun <root@infi.wang>
> > > > ---
> > > > Changes in v4:
> > > > - New
> > > >   drivers/net/phy/aquantia.c | 159 +++++++++++++++++---------------=
-----
> > > >   1 file changed, 75 insertions(+), 84 deletions(-)
> > > > diff --git a/drivers/net/phy/aquantia.c b/drivers/net/phy/aquantia.c
> > > > index 903fcd667f6..439c4c48bdc 100644
> > > > --- a/drivers/net/phy/aquantia.c
> > > > +++ b/drivers/net/phy/aquantia.c
> > > > @@ -18,28 +18,28 @@
> > > >   #include <asm/byteorder.h>
> > > >   #include <fs.h>
> > > >   -#define AQUNTIA_10G_CTL		0x20
> > > > -#define AQUNTIA_VENDOR_P1	0xc400
> > > > +#define AQUNTIA_10G_CTL 0x20
> > > > +#define AQUNTIA_VENDOR_P1 0xc400
> > > >   -#define AQUNTIA_SPEED_LSB_MASK	0x2000
> > > > -#define AQUNTIA_SPEED_MSB_MASK	0x40
> > > > +#define AQUNTIA_SPEED_LSB_MASK 0x2000
> > > > +#define AQUNTIA_SPEED_MSB_MASK 0x40
> > > #define<space>MACRO<tab>0xvalue
> > >=20
> > > is perfectly fine format.
> >=20
> > Agree, until clang-format has become the default.
> This change makes readability worse, no matter what formatting tool is the
> current recommendation.

Generally speaking, one should not just reformat the code, for
reformatting sake. If someone wants to tweak .clang-format and push the
changes to the kernel (whom I would assume are as picky as anyone else
here), that's fine with me.

--=20
Tom

--6LvUsuRkrreNEwR4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaQUHMAAKCRAr4qD1Cr/k
CnYiAQD2To5n9Cg8aW/fcp4rlacGWPGbxLMN9UkRylYItuKb+wD+KJFjLfueCONm
5c8wIDDkA3Og8NNY+NZ0KHLbMAuvdQc=
=7vAL
-----END PGP SIGNATURE-----

--6LvUsuRkrreNEwR4--
