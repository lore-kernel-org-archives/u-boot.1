Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8934E77184
	for <u-boot@archiver.kernel.org>; Tue, 17 Dec 2024 14:20:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E32AF801FB;
	Tue, 17 Dec 2024 15:20:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="j5XHXkEH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5B2FF80214; Tue, 17 Dec 2024 15:20:24 +0100 (CET)
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com
 [IPv6:2607:f8b0:4864:20::734])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 21C03801CE
 for <u-boot@lists.denx.de>; Tue, 17 Dec 2024 15:20:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x734.google.com with SMTP id
 af79cd13be357-7b1601e853eso416041785a.2
 for <u-boot@lists.denx.de>; Tue, 17 Dec 2024 06:20:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1734445221; x=1735050021; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=/EDtADyULg+4aCWiqXiEHnHrPPVWaZGglquRS88lYXM=;
 b=j5XHXkEHmc6V0t/ac07E0RQPH0ux9LgJbjnFxtv7t1kEoJX/19FIUY3nMUAX0Xac9/
 yPqAmGDYnhd/ST8xWxgChri1VoZ8uHCl0dxxFtk8cgoq+nwmv5dL0jmm8QkaOGayKYRZ
 9wdYKiVnlT32WqI9bjtJnWau38l5P6s2l3ybU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734445221; x=1735050021;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/EDtADyULg+4aCWiqXiEHnHrPPVWaZGglquRS88lYXM=;
 b=EP+Fg0ao1DK0B8d27dnFFIEsy6qrKkLfvCKbLJ64tiAEKwmw99L13ebxiXyw6lBmCb
 bymoXWojBIQ9HpW/28gQu8YqPR7CHi+s8jujQouCzBu4cmsaroQKDNwvFgipDBm4iyrC
 xfmAzyuQGMoAZCd0W+SMWw0JIVL4XewmoSNW5z4Eh7m+E9E+0a0Cq4+tKq7zhC3C4+d8
 uVDbDtAE7YeFNW6m5vfPytSHpVnRIeBCvI/RriKqDePo8vxoDmRpUb0psnLcDMBAPSFl
 UbcUvLtBmW1JBSRptXlkqUHMsQ5t4uBcrJKFRFretInSooZdVxDfanh3mSH4G32DeAQS
 G+5w==
X-Gm-Message-State: AOJu0Yz0d2auIS/IxBweTWl80x2JvQVIRUms6OkrVdB2vyH/6n7l7OkY
 MDIhddOaePVBSuVVAHzsxLo0j6XoO4/mWnpcLeUsVh+sJj9O4zt0BNmqIxQFu7M=
X-Gm-Gg: ASbGncvDujwOYeOmJON8ML7/1i4H00+xxF0JBzIksb9VYEUrUGWniqxR9yE6aqta34K
 E4GuzIQDGd7P4yRPCVwMfNmxeOYxiAtFZwIp1FPj0+oZjhguI3saBJ4UJstpzVdomwMs7YY47vg
 Dq+KCkiy04UX0tBkr6yZfHJfIvWqK72gAxAedtKmKO3vqDFxNwLGcvJMpB0ECfSUs4YHjBr1RU5
 yZgo09aHdeQUMyFRlUC+2/CvJup3heB9aADz7fOmWNFfsG3baM/O0rD
X-Google-Smtp-Source: AGHT+IEYbEX07ddiDuDQutQHq7SvhNtPYjNhICCeAdxo16S3rLhMiQfmBHZMoMzTZl+yfEM00l4u1A==
X-Received: by 2002:a05:620a:40c6:b0:7b6:d998:4fc5 with SMTP id
 af79cd13be357-7b6fbf14aeamr2443177485a.35.1734445220951; 
 Tue, 17 Dec 2024 06:20:20 -0800 (PST)
Received: from bill-the-cat ([187.144.29.192])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b7048bd619sm321775485a.78.2024.12.17.06.20.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Dec 2024 06:20:19 -0800 (PST)
Date: Tue, 17 Dec 2024 08:20:16 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Andrejs Cainikovs <andrejs.cainikovs@toradex.com>,
 Brandon Maier <brandon.maier@collins.com>
Subject: Re: [PATCH] buildman: Add a way to build a particular target
Message-ID: <20241217142016.GK1505244@bill-the-cat>
References: <20241217132616.3708573-1-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="NnfG9cCteVCrgF6Y"
Content-Disposition: inline
In-Reply-To: <20241217132616.3708573-1-sjg@chromium.org>
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


--NnfG9cCteVCrgF6Y
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 17, 2024 at 06:26:16AM -0700, Simon Glass wrote:

> At present buildman only supports building the default target. Generally
> this is what is wanted, but in some cases boards erroneously have a
> different target for product extra files.
>=20
> Add a --target option to help. Also add a comment indicating which
> letters are free for new options.
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>

How do you use this? It would be nice to be able to do "--target
u-boot-initial-env" for example for converting and verifying the
conversion of boards to plain text environment. Except the list of
artifacts that are kept isn't updated with that string as well. And
FWIW, is this for a case not solved by CONFIG_BUILD_TARGET?

--=20
Tom

--NnfG9cCteVCrgF6Y
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmdhiJ0ACgkQFHw5/5Y0
tyzzcAv+PbzhX/g7o99hOyKl2msjQSgjG7MXWzbil44r5BSYL/5PCBgSoXTqpE2Q
SjOtMaj0SenZPvuiAI/2yG1oL9BhQKeu6Ed6GSpRtS9P5BO5VmWUPPEsH+qPpU4l
Aq4qP5p5d5jRRS7zLHI4lQv2pVYfhuZSxk7s/ZZx60TeUzaUtAD497YTab/80aYd
mcw69Rfygvza2NHQQuVqB6O4bHh/ITG1q0KALxBxEyL4PV/64IIwvJsimEIwnaXa
lHk7J3683yrFOIhomd40/Oyx//PD84W/uS2WsxibUFLoy2SIyLSMCo41SqauV4cp
Tv8UBNfcJl4khfQy8VzUAC+jpk7a4SHJwpygaWI/gw3qaIGXlAe3um0JaNMdmvnb
QbxV5gMHmQ48H5EZsv3QpqvBwMl7FbeJQ799cluOnqTn1U/0axdg/9DoPOtoOv3h
wSEp46NoLpmVZyX0iUjnX070+9Mv9zHwKLl1LqCeGSsdHsb9e8vP2YPLN7kPkzqS
Lsik2MdN
=ht5W
-----END PGP SIGNATURE-----

--NnfG9cCteVCrgF6Y--
