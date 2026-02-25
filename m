Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13DB1FD45F1
	for <u-boot@archiver.kernel.org>; Wed, 25 Feb 2026 23:40:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 499AE83AA9;
	Thu, 26 Feb 2026 00:40:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="OkSzY8/k";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C071B83DEA; Thu, 26 Feb 2026 00:40:50 +0100 (CET)
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com
 [IPv6:2607:f8b0:4864:20::233])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8451E82A9E
 for <u-boot@lists.denx.de>; Thu, 26 Feb 2026 00:40:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x233.google.com with SMTP id
 5614622812f47-45f053b7b90so123495b6e.0
 for <u-boot@lists.denx.de>; Wed, 25 Feb 2026 15:40:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1772062847; x=1772667647; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=64/+G7JoApjqR2lPXYLeki14wxpH709rVZrR7en98EY=;
 b=OkSzY8/khdHV0ZfbfikoT6x6a8aGHhydJMPfwhuGjjLLoUaEXJ8w71Z6Zx3pVMwQIU
 gZkbe84hVbr9OTXcAg3ZtthzBkS/eB34rnhKU6jW1rnvShVgfoecPv0Cn6IDxaIaxgeW
 5No2lhMc/XGAqt3XDj7fSB+qCujyQ99dAtvJ4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772062847; x=1772667647;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=64/+G7JoApjqR2lPXYLeki14wxpH709rVZrR7en98EY=;
 b=D7KXJblmBvm8J1R987VCnlwbpmuTZOtKSZMfDPjKBZXNFjHyURV/4SvY47g7Gq9HoH
 GExSqMVCd3mCOMwumfiLlUs5TQtFcOySl5D3xktgW7Qajo9eiukZeHJwI0W3MOiQbSKU
 ss+NAC9xPQNfLWKExeTt3WzF405WXW3spJ7GuVQL9ifeL8Q3wg85V22tEF6jh3Xxp7s/
 6rq9zmxEuNprbHSPWUioqUWEVl1otw21ApUAdvEW6Nzk1bEKlS0Sa1RlPlDM4b06fJ2D
 4sIV4CYIpQJmw4NgUxTMnlhk7K4Ak5LjG3qWjtKyCh18p33KTnPEtJbqo2snH+hFIMAj
 PF2Q==
X-Gm-Message-State: AOJu0YxXKBFUBR5GHfpg8YseffOZh8ZJxcnYYJVwFeuHkjw1uUI4wVz3
 2SIYsaqAOgGikdR0Edlrt8jxjHmLyIlL7tYb8gyrXRRueuQUpj9yzH0+fM+fB2hZd34=
X-Gm-Gg: ATEYQzwh5kFUlUblDYj+iq7u6xQu4xMjXQI4ELhBd7PqGMgRfTiRqhz9CMEcof2QLu0
 vaxehtmPo3yEwqqFsDhHt9KZ2nGqqHYPeHYWfG2J8+zlbXe6Nnqj30Em6dxRuqbQqL0L0Yf1BjX
 dGNpUL8LPhSVQ97uQiA8muy9QWqLBc0G7wuf2PPRihD9MYq9ldeyOMS6d/Tdk44jGeQwwadsEx1
 wrrOGv9bVawMvzW9V8gatDBbZ5PXGbh4lfQHKpaMm4/QiB8lPu06zeQjHLU0S7hOqzO5B+So/wi
 7dEKmBSjE6k7tHY4OCMcbh1O87MJDdr7QJmCbF2uzQtQYDxi0t00SlhW37tlQnO18UrSU09+SXs
 qcaf1GW42AZ3InRjvt0dTBaSwo+kAWd15vZy3bAs8Xh1gQxLJP5+xdYlcsEnrXD6xOtBbKTkJPx
 nSoeH6XmsyZ6/JiJ143L9i60vFoGDZFuv0dDysAAqqFmdthLPSDx1/CgOEFDL5rhjN7CO2B42mw
 X38pgRecwEXmPiwDsQMoudDBhrWnDVD6vTq4e8Zm5+qAdmsxmSz3kvUa+GOIw==
X-Received: by 2002:a05:6870:d1c7:b0:40a:5a07:3598 with SMTP id
 586e51a60fabf-4160fc966f4mr55247fac.36.1772062847097; 
 Wed, 25 Feb 2026 15:40:47 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4160cf2572bsm329694fac.2.2026.02.25.15.40.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Feb 2026 15:40:46 -0800 (PST)
Date: Wed, 25 Feb 2026 17:40:43 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, Simon Glass <simon.glass@canonical.com>,
 Alice Guo <alice.guo@nxp.com>, Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Aristo Chen <jj251510319013@gmail.com>, Bryan Brattlof <bb@ti.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Neha Malcom Francis <n-francis@ti.com>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Peng Fan <peng.fan@nxp.com>,
 Philippe Reynes <philippe.reynes@softathome.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>,
 Yannic Moog <y.moog@phytec.de>
Subject: Re: [PATCH 1/6] binman: test: Renumber duplicate test-file prefixes
Message-ID: <20260225234043.GA1593142@bill-the-cat>
References: <20260225225040.2568118-1-sjg@chromium.org>
 <20260225225040.2568118-2-sjg@chromium.org>
 <20260225225453.GZ1593142@bill-the-cat>
 <CAFLszTjp33ygXW0NYXwan1VP_5RwXytiFXLfStKGF4gv6vA7OA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="sRKYtBTKa50+1hqF"
Content-Disposition: inline
In-Reply-To: <CAFLszTjp33ygXW0NYXwan1VP_5RwXytiFXLfStKGF4gv6vA7OA@mail.gmail.com>
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


--sRKYtBTKa50+1hqF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 25, 2026 at 04:34:37PM -0700, Simon Glass wrote:
> Hi Tom,
>=20
> On Wed, 25 Feb 2026 at 15:54, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Wed, Feb 25, 2026 at 03:50:30PM -0700, Simon Glass wrote:
> >
> > > From: Simon Glass <simon.glass@canonical.com>
> > >
> > > Quite a few test files reuse number prefixes that already exist in the
> > > test numbering. Test .dts files are supposed to start with unique
> > > numbers.
> > >
> > > Renumber conflicting files and update the references in ftest.py
> > >
> > > Signed-off-by: Simon Glass <simon.glass@canonical.com>
> >
> > Since the numbering does not seem to matter, can we move forward with
> > some other scheme perhaps?
>=20
> With so many files, the numbers are the only way I can easily tell them a=
part.

Sounds like we need another scheme then, as collisions over numbers has
happened too many times. Some subdirs might help instead.

--=20
Tom

--sRKYtBTKa50+1hqF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaZ+IeAAKCRAr4qD1Cr/k
CuiSAP4zwJthEMkN8SX5LguZpaaOUNF0ceEHO+NviC8s/xUfdQD/RVpSWjo9RgC6
VF7W5iHJY9IqxFvb+qldHEXuiJny1Q8=
=thGz
-----END PGP SIGNATURE-----

--sRKYtBTKa50+1hqF--
