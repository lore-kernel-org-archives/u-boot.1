Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43F70D6DDE1
	for <u-boot@archiver.kernel.org>; Fri, 15 Nov 2024 13:32:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 70B5D89266;
	Fri, 15 Nov 2024 14:32:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="kfCc1Tkg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DD6568933B; Fri, 15 Nov 2024 14:32:14 +0100 (CET)
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com
 [IPv6:2607:f8b0:4864:20::f30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BB9EE8933E
 for <u-boot@lists.denx.de>; Fri, 15 Nov 2024 14:32:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf30.google.com with SMTP id
 6a1803df08f44-6cbd00dd21cso8926396d6.3
 for <u-boot@lists.denx.de>; Fri, 15 Nov 2024 05:32:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1731677531; x=1732282331; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=+2yjM2iyAfIL/tJSYK3Io8KhLio5CBWJRkrqBpQARoU=;
 b=kfCc1TkgbLFeqwh3g/HMUXZYiHSkBuQKwWpXM65rwRger44g6I3kYJQYSi0w6bHo1k
 1PLajg18YoKo9jyXwG4bd0CHdcAJZiN7FpwXnpQfsH6neYa416m7YNOERGAO7NZgcKBc
 H+ayHTP4gnl8VnY4V23arxXE72rE6ENAdEZKA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731677531; x=1732282331;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+2yjM2iyAfIL/tJSYK3Io8KhLio5CBWJRkrqBpQARoU=;
 b=wO8OaY1umAVl7k9nbL1AqDo47FESLH9aBAXfbqCgM3FEQxl5qUyAR8mbS02dWgwl50
 l5H3/Y2V4qRHX5n+YxgphLh67a0n2WpGigu/mCwrUNODT9qu5d7/VYldnShCNPXoWEld
 kj/I/5dw9ZEnKX9ajK+K2Qs30gBqXbn9lUd1V9C5qfnmSQXe+Dt7kKUL3GnSSnhZOf1r
 9ROslq4t27ekwEJk6pwhGW31jvb7PSzx/GBvzeJAE69dnezpHsemNHIrJjyEzzcuPB6W
 BGAiPbMMlLJeVtqWOCy63AfprZ37AtO+IqgkFMKbPDkRBWWeq3iAUJeD82rI8q4GPVqk
 zSJA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWzSu32DN99OWZqpMnC4jt//CxkZwCUs5Bua1IQUn3L9kCn4Z6iWN6IQRM5LN2EanFGpsbSJcY=@lists.denx.de
X-Gm-Message-State: AOJu0Yy8Yx9nqfeMQfhLmGrNGBBPLdR2sXTE0aUM8a6mPun7GPMonMVt
 XQSvZ52JEDP3t4wNvGECsX/n/qCXwrmSOAlZ6gcg/gJ9bWo2y4pwygBp4r5xSl4=
X-Google-Smtp-Source: AGHT+IFwXjJYVsEt892tRD/WjWPTIkprx/d7bLxo7XgclBguHaCz8lVpGj9VGJ8/AGZQ5dwp3D2gVw==
X-Received: by 2002:a05:6214:568f:b0:6d3:f73c:4437 with SMTP id
 6a1803df08f44-6d3fb749033mr34079056d6.8.1731677531606; 
 Fri, 15 Nov 2024 05:32:11 -0800 (PST)
Received: from bill-the-cat ([187.144.30.219])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b35ca67426sm157239185a.122.2024.11.15.05.32.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Nov 2024 05:32:10 -0800 (PST)
Date: Fri, 15 Nov 2024 07:32:07 -0600
From: Tom Rini <trini@konsulko.com>
To: Jerome Forissier <jerome.forissier@linaro.org>
Cc: Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de,
 Yasuharu Shibata <yasuharu.shibata@gmail.com>
Subject: Re: [PATCH] test/cmd/wget.c: move net_test_wget() to the cmd test
 suite
Message-ID: <20241115133207.GQ3600562@bill-the-cat>
References: <20241105120653.99438-1-jerome.forissier@linaro.org>
 <20241115001400.GO3600562@bill-the-cat>
 <45113171-b97b-4ef1-9758-86a6d5adfd18@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="pSIdumbsDfpCM8I3"
Content-Disposition: inline
In-Reply-To: <45113171-b97b-4ef1-9758-86a6d5adfd18@linaro.org>
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


--pSIdumbsDfpCM8I3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 15, 2024 at 11:53:59AM +0100, Jerome Forissier wrote:
>=20
>=20
> On 11/15/24 01:14, Tom Rini wrote:
> > On Tue, Nov 05, 2024 at 01:06:53PM +0100, Jerome Forissier wrote:
> >=20
> >> Since net_test_wget() is testing a command and is in test/cmd it
> >> should be in the 'cmd' test suite, not 'lib'.
> >>
> >> Reported-by: Simon Glass <sjg@chromium.org>
> >> Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
> >> Reviewed-by: Simon Glass <sjg@chromium.org>
> >> ---
> >>  test/cmd/wget.c | 3 ++-
> >>  1 file changed, 2 insertions(+), 1 deletion(-)
> >=20
> > This leads to a sequencing error in tests:
> > ------------------------------------ Captured stdout call -------------=
------------------------
> > =3D> ut dm dm_test_eth_act
> > Test: dm_test_eth_act: eth.c
> >=20
> > Error: eth@10002000 No valid MAC address found.
> >=20
> > Error: eth@10002000 No valid MAC address found.
> >=20
> > Error: eth@10002000 No valid MAC address found.
> >=20
> > Error: eth@10002000 No valid MAC address found.
> >=20
> > Error: eth@10002000 No valid MAC address found.
> >=20
> > Error: eth@10004000 No valid MAC address found.
> >=20
> > Error: eth@10002000 No valid MAC address found.
> >=20
> > Error: eth@10004000 No valid MAC address found.
> >=20
> > Error: eth@10002000 No valid MAC address found.
> >=20
> > Error: eth@10002000 No valid MAC address found.
> > test/dm/eth.c:284, dm_test_eth_act(): -ENODEV =3D=3D net_loop(PING): Ex=
pected 0xffffffed (-19), got 0xffffffea (-22)
> > Test: dm_test_eth_act: eth.c (flat tree)
> > test/dm/eth.c:273, dm_test_eth_act(): addr =3D NULL: Expected non-null,=
 got NULL
> > Test 'dm_test_eth_act' failed 2 times
> > Failures: 2
> > =3D>
> >=20
> > Where it's fine when run by itself, but fails in CI/etc when running all
> > unit tests.
>=20
> How annoying ;) Any idea how to reproduce locally?

Running all of the tests (or at least all of the "ut" unit tests) in
sandbox should do it.

--=20
Tom

--pSIdumbsDfpCM8I3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmc3TVcACgkQFHw5/5Y0
tyyDCAv+OvramU6sluqrc3BstOMTqQFg2qO6Z71pTJ3xqV6PUSj+c0NlH5O/x1rj
xr1PIbB22lYJes4MsTMPWjfDIys9ROM1F+DgsGfe+AY5k5iCy8v/3Rc7MzGGruhY
khC040RjLrLGgkgw/Ksx4XYelxkz3R3X0CvXXST3WuTxKKuQShhp4NjGA8iawIXp
re6FmhzDDsmxrD9wJspqWkbAvLEDuADiHl3xrJFXFtMZ3d2ZzjO8+7RIgdukOycn
iIpUX8s2CbiukYeDoDLgmKfCrBoV/popPvwzixLPIT9bXitwWprpGvEijN84v3Lb
dA2he04DwInDGvWyDNAKm7BjQo6Ei95lmf7icU/5RCDztOQThoZ6AEqgf4g5dr8r
KOYObmPA0c1ncl/pJsDGmEg/1e9poMJGF9J0nDFExUm05N6kjQRMKU+zXA3UkyCM
WVVNqLywxRHk/bqty1ylZORz9EvTHOwfS7BLwARp0GqDVYdciDVrkoDKu/+wOo6k
hCzdUMQ7
=+4uw
-----END PGP SIGNATURE-----

--pSIdumbsDfpCM8I3--
