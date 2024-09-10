Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1798ECE564
	for <u-boot@archiver.kernel.org>; Tue, 10 Sep 2024 04:08:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F0D6788F04;
	Tue, 10 Sep 2024 06:08:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="XDDlITIQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CBD3E88EC1; Tue, 10 Sep 2024 06:08:15 +0200 (CEST)
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com
 [IPv6:2607:f8b0:4864:20::f30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C7ECE88F03
 for <u-boot@lists.denx.de>; Tue, 10 Sep 2024 06:08:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf30.google.com with SMTP id
 6a1803df08f44-6c548eb3380so8745506d6.1
 for <u-boot@lists.denx.de>; Mon, 09 Sep 2024 21:08:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1725941291; x=1726546091; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=T3ktm6h1RVUKv9NhJwky4HCUkEQAeIVkC5rPKchc9PE=;
 b=XDDlITIQ65F1TbTnvJsPC42BO833+BLUOCCHyL8jx+WtMJASky5GbG+39umVsiz1i8
 mS4R7KQSebx0Y10+c08Xa8AbS+BHxkzJ0BDMyQC1TJ4RBr5sW4GNSFzPG/9exnZSeWgS
 K5srPXhg5Nb0DeGeha2y6zD09K15BEHiB19sE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725941291; x=1726546091;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=T3ktm6h1RVUKv9NhJwky4HCUkEQAeIVkC5rPKchc9PE=;
 b=cyF3wk7OINjfN1ygp08RKX7LC+1UkCbfwt4l5MbgIHeWeBUlFWm1ZOqaUrOHJO1m4A
 BQ6vb0nHikjoxh/ompIGrzzeqQEdOLf5GbnKUGb81Hdd8RvIcUJnGjd/oxYMBG5T39po
 1Nzr5VlETLZghUQrLROe7PTXPFIORX2+QlE8JJr8hi6mYgfRPPVdU5pcWwv6wuKfaWD8
 o18GXtwvzXps1AIirdFNkYvB+lXP9fMQgTY3ffXV5396pVVUs9x83QDifybxCku9xlC5
 TQuczfbdsGg4bYzz6Unv9dgGc8xS8xIltASGsClejlOieHGD+VQ3CjtRSGaGDN8yEpR5
 GA9Q==
X-Gm-Message-State: AOJu0YyQpLoiJaNGs/fQOuYZOYr2mkwHGwbYt+K1iaOH2VEVzkxPChO4
 gfbP9jFBkurilXg/WDSYZgWHIvQLPP/J39g/l4gzVPPUNqpPE4Knfls0WvxN0R60KQU3/TwqahX
 RSnI=
X-Google-Smtp-Source: AGHT+IEZYs1V3dYXblAJ1PQyFpWyWwTE4cMuL2uyAyCTPbDP9fdOT9Vwa0weT0z9G+3afwGIwSoJWw==
X-Received: by 2002:a05:6214:578a:b0:6c3:5efc:d2fb with SMTP id
 6a1803df08f44-6c5283fdb53mr221683236d6.22.1725941290585; 
 Mon, 09 Sep 2024 21:08:10 -0700 (PDT)
Received: from bill-the-cat ([187.144.65.244])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6c534339839sm26729026d6.43.2024.09.09.21.08.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Sep 2024 21:08:09 -0700 (PDT)
Date: Mon, 9 Sep 2024 22:08:07 -0600
From: Tom Rini <trini@konsulko.com>
To: Marek Vasut <marex@denx.de>
Cc: u-boot@lists.denx.de
Subject: Re: [PULL] u-boot-usb/next
Message-ID: <20240910040807.GF4252@bill-the-cat>
References: <20240909202054.73857-1-marex@denx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="BE/pbvDu60jVZ/3F"
Content-Disposition: inline
In-Reply-To: <20240909202054.73857-1-marex@denx.de>
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


--BE/pbvDu60jVZ/3F
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 09, 2024 at 10:20:28PM +0200, Marek Vasut wrote:

> The following changes since commit d0f74bd417daf6492975ce346843ba0767caf5=
1c:
>=20
>   buildman: Support building within a Python venv (2024-09-06 12:45:54 -0=
600)
>=20
> are available in the Git repository at:
>=20
>   git://source.denx.de/u-boot-usb.git next
>=20
> for you to fetch changes up to e72e683e36a83214dbb2547d88d553b5fd816dc8:
>=20
>   phy: test: Implement sandbox PHY .set_mode and DM test (2024-09-09 17:1=
8:04 +0200)
>=20

Applied to u-boot/next, thanks!

--=20
Tom

--BE/pbvDu60jVZ/3F
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmbfxiAACgkQFHw5/5Y0
tyyKMgv9GzySAYRteOb3dnNkzMUSzxFx/w858RLVyVPkU5GFkTMPYxEsAxR6YxJe
CWm69p3HZhPIyLFuBOeMMQc3fXanMzY+kdktCGvjsq8h+EKNLAqJCjMBPqSpLn8b
rvb53K5RwY2IdXpx1fVt3Gbzb35jGF5J7Zytz9c+iJTog7I5H0aFoIPr9xHoBpM6
mFCYLoqB8G0/03LIU1XzzJY7IsdWdn1tOrQ3fHED5obO3w9vQUb84Ph1uGsF4vtZ
I201K5V9vm5sBbfDSK0+tCbIkp/ft/GsIni7Ch0rDe2GP8gpELKVwTa+oaKmeR6N
jjy/HVUcy0LkyVyRvQVrvdc70eA8KQuqMWAHlyZ13pr0/qvh0ivcj++H/r8409f/
VxQ2timn0muhbiAehx00Li/DLg+r0GHO1fvf/Z/YKxnwfxBAUsFURPxgrz9UZhbx
vUESrxHQV3KG/jE7qNqv1SHkAQFUUY3xvoA7epmIcjoWKoasuwxMAgc5zokMDl9E
gkQDr3+S
=0iNe
-----END PGP SIGNATURE-----

--BE/pbvDu60jVZ/3F--
