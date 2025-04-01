Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72129C36010
	for <u-boot@archiver.kernel.org>; Tue,  1 Apr 2025 13:54:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CDC7B81F7E;
	Tue,  1 Apr 2025 15:54:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="g+oqfPph";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 72BBD81F7E; Tue,  1 Apr 2025 15:53:59 +0200 (CEST)
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com
 [IPv6:2607:f8b0:4864:20::22a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2BC0881703
 for <u-boot@lists.denx.de>; Tue,  1 Apr 2025 15:53:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22a.google.com with SMTP id
 5614622812f47-3f6ab1b8fc1so3281115b6e.0
 for <u-boot@lists.denx.de>; Tue, 01 Apr 2025 06:53:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1743515636; x=1744120436; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=JW25oJIagPh3ZnTqVjtorRdab2dTPrWFFFtOFuynRLA=;
 b=g+oqfPph70oNAlhC+JZu2+DDd88piF3UHszbGQj30bzTKCdoQADjVBX+xoZL6YKeJC
 cuKSeY7SePjDbjJzL9qflN7llghK0N2nvFBUhMECPo3CRGZipMLlfif4wICWuPk/gh35
 JKldOsR3gH3dZ//QR5Wp7ZJjwwpEYb+Vuf/xg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743515636; x=1744120436;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JW25oJIagPh3ZnTqVjtorRdab2dTPrWFFFtOFuynRLA=;
 b=O9DnlQn9Wq5RDPKMdXmcVDaD0Shi75/rhInD3daN+det3Nd+qZTk2K6oTeQySONkXw
 X+DMzw9QbxyMXr5nn1ug/LVx3oLCVCnlSFLHYXOjUBJV/two8CZt4pxRkyRYLCm/zleJ
 ckE1i+3UP55FOUFOHRRLlzT+ihYHa3e6wndWCZ5WtsIj0yPixFwTjbPGv0rptkKnQhJa
 foNvDG3U46+fT38J9UWeBea7Ea/DGXfCg25Rwm/487tDeQ3OIX2oDXrzfE5gxL3w2JDv
 FMOwxIvggVlB0TaVEbSKMZkIhfHD2uxYFmz9KLpTUWoFnoniMAzNKwfy6V1IxqF5HSm1
 9kBg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUMor/or78xH1sTOdM1O9PH3OLK2cUCCXBKAOMaKFbVkogS4SIafMMtCDgqdaWrcRx9R2RRTxI=@lists.denx.de
X-Gm-Message-State: AOJu0Yz4SLMIP/VVi2qcjRowjPyTMp+BuUG7kXxm+ye1peK154b54RM7
 yHIrW26h5mqoTaEoRuZ1FKYU55Jjxyg0Ewqwq3R6gntQt765+jN16m/qklGlyn8=
X-Gm-Gg: ASbGnctIBmhG7ZBQUezSU3gUIBMm37fqXL/NRC1Du/ae1tWC2EjUMkGfb/zrghkBT8l
 Jo1cP5o1HQ8dPZNRy53aNyVABtLTXsAmefwvsz4OD235EzHNl+4ikoRrSjcyNzb2BTiGHc78ITH
 a5/XOuKJi2uR5yYd/imS5wuSqz6mP7/yYOXwwT4+YiWHPUpMW+iovysCFnnqBHdNucMtpgbbejC
 dezMSxV7xHtpXOj2CALVuXpUmBtW7kvts1fOJ3UjzRCk3sV8P2YEiMikXfXn4TSr4SK2Sg99DPM
 W+x3jATPyMDvEqcYXo1UjNJo+BXYcgj98otUscw7MEdXWE2uhO776ia+jXmlActolirz5lV+pdC
 msV9mXNWQWWyUPjHC
X-Google-Smtp-Source: AGHT+IHDw5iAl4r/UBP/ZdLBvZnHYhk7AjET0zFzvdi5bPJSEFzu+4ROiL/EHpqOk2Eb39YSJV+WQg==
X-Received: by 2002:a05:6808:6807:b0:3f7:28ac:8068 with SMTP id
 5614622812f47-3ff0f5293d9mr8024551b6e.13.1743515635903; 
 Tue, 01 Apr 2025 06:53:55 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-3ff05278de3sm1941632b6e.36.2025.04.01.06.53.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Apr 2025 06:53:55 -0700 (PDT)
Date: Tue, 1 Apr 2025 07:53:53 -0600
From: Tom Rini <trini@konsulko.com>
To: Leonard Anderweit <L.Anderweit@phytec.de>
Cc: "quentin.schulz@cherry.de" <quentin.schulz@cherry.de>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 "sjg@chromium.org" <sjg@chromium.org>,
 "upstream@lists.phytec.de" <upstream@lists.phytec.de>
Subject: Re: [PATCH] doc: build: docker: Fix code-block formatting
Message-ID: <20250401135353.GC5495@bill-the-cat>
References: <20250401094952.8896-1-l.anderweit@phytec.de>
 <9b5a0cd4-9e6b-43c5-a770-5fc1e90e82bc@cherry.de>
 <abeb4ff7e64a76cf80ada25e4e6cf086c516c013.camel@phytec.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="nArC7IBNChKLV/Zl"
Content-Disposition: inline
In-Reply-To: <abeb4ff7e64a76cf80ada25e4e6cf086c516c013.camel@phytec.de>
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


--nArC7IBNChKLV/Zl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 01, 2025 at 11:18:45AM +0000, Leonard Anderweit wrote:
> Hi Quentin,
>=20
> Am Dienstag, dem 01.04.2025 um 12:07 +0200 schrieb Quentin Schulz:
> > Hi Leonard,
> >=20
> > On 4/1/25 11:49 AM, Leonard Anderweit wrote:
> > > Remove double : before code-block. While at it, use code-block for
> > > all
> >=20
> > Why?
>=20
> I just found it odd that the two styles are mixed here.

We're bad about consistency in things like this. I likely went with "::"
being the shortest way to get things looking OK but indeed a code-block
statement is correct. Thanks!

--=20
Tom

--nArC7IBNChKLV/Zl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmfr7/EACgkQFHw5/5Y0
tyxhrgv/eJfHrIz3HP5D+FkTy9leACcX+VFXKqincVoPIF2nb6ZyCQy1TXUEAJo6
2YiYJAOuED7NETmmRhQh4cFMia3a4bMrxInAkcyDdck5Sa9jm4yUd9s8u5tey9t9
yVKosFO4KXYFBN+YeHudiLwlb+oF7vF5wTwt1Nw/yKKXaz+sgdj5O5LvJb/mKCwj
d91hQdBkAooXmjEleXahIXxx/2oKGzcWAXQMwA9bf4rdt3liZKdxLzqvd6CwFicJ
sSmkwvWr9d0fSoq0AFsyMJgk0dwFPhleiNDKiWFbTtnoDLDgG7HiLYF1rL1Azezu
sIXaMxiL0vcV26y5ZpfdRpF3W8IPyf600LJRSsdIRalJnmcnBQUp5IWfmbtkZWcK
gYYbq7XCOEISgoEEE1TR/L8GDgk2YFTB6+RQlcgs8cT4kKekTcUkABHLqlzUahhF
HK/c/YenBV9xNF83OwxTWBu/RIF62RUBHUnXRlfQT4E7wzdtHwLltcEVfFtTUxLP
VAhSylm5
=X9s6
-----END PGP SIGNATURE-----

--nArC7IBNChKLV/Zl--
