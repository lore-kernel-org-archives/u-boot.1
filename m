Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BB36C4332F
	for <u-boot@archiver.kernel.org>; Mon,  6 Nov 2023 16:32:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 43A2A8706C;
	Mon,  6 Nov 2023 17:32:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Fu0BR3cg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 86E9586FF9; Mon,  6 Nov 2023 17:32:42 +0100 (CET)
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com
 [IPv6:2607:f8b0:4864:20::f2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 329FC86F88
 for <u-boot@lists.denx.de>; Mon,  6 Nov 2023 17:32:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf2c.google.com with SMTP id
 6a1803df08f44-66cfd35f595so25986366d6.2
 for <u-boot@lists.denx.de>; Mon, 06 Nov 2023 08:32:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1699288359; x=1699893159; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=jn6sU6fHsLK0+gwuf3GOa4TaPFWDh0fpF3nvKAtSYjU=;
 b=Fu0BR3cgjqFMrTexGu1sKc529xIuo0llOAhsi9olNDw22wFa8XphW+/8cf1FXeSad4
 /6A1aZDUbbZOyKjfIshkyL2i2myvTZ6kdT10rkmUK+Ngczt63uMo9RBE1sGBx6GFMqad
 p/DdcAX6ExZPsAAz5FcrzOdFv88HT++ojnMyw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699288359; x=1699893159;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jn6sU6fHsLK0+gwuf3GOa4TaPFWDh0fpF3nvKAtSYjU=;
 b=wCXydNcyz3PC6s4S+918U0lx2X7aj4mPMzqSGYPPs2QLlDsyctP4fB6JXdK89qggms
 nrzUKZzBcS/RGPVQev7aPWd4s8TeeIIAxMFHlHNv5mY5M/KTelCydpruwJMt+lRQzgGC
 XW1mOnV0cZjdR/zeXqR+rhA/cwL31odSL4urqAt2RMyo6anbnxT3SDDNDTb++52gA/1S
 NPM7XkhPQkYCwyATPUgGlXpkYd9hSYtY4wAwRCd4UiU0PyXEuCo2aOL/NfV+4vZ2sCU/
 PLrc9VhG2Urq0BW/kkhlAKLKqgd+VbXITkLYJvOosu2nIJXJjWEK9Z9FnZg9YT71bXLl
 DR4Q==
X-Gm-Message-State: AOJu0YzwdZzoYKPKoLDUGPu19LnX9lYDVb+QlubRY0S/zErHA9Ou8Auv
 J79bhMMf5/OuwHXCO46fEgu/+w==
X-Google-Smtp-Source: AGHT+IEjKxYzYgmZ+uhPwXWF/gP8bv61pBAdyvzCscojAj89VA0pA33TtNVMjXUBUnuWWMKT7YK4kQ==
X-Received: by 2002:a05:6214:21ce:b0:65d:56c:5177 with SMTP id
 d14-20020a05621421ce00b0065d056c5177mr31447069qvh.57.1699288358973; 
 Mon, 06 Nov 2023 08:32:38 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-0000-0000-0000-013d.res6.spectrum.com.
 [2603:6081:7b00:6400::13d]) by smtp.gmail.com with ESMTPSA id
 d8-20020a0ce708000000b0065b12c7a48dsm3574807qvn.133.2023.11.06.08.32.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Nov 2023 08:32:38 -0800 (PST)
Date: Mon, 6 Nov 2023 11:32:36 -0500
From: Tom Rini <trini@konsulko.com>
To: seanedmond@linux.microsoft.com
Cc: u-boot@lists.denx.de, joe.hershberger@ni.com, rfried.dev@gmail.com
Subject: Re: [PATCH] net: dhcp6: Fix OPT_BOOTFILE_PARAM parsing
Message-ID: <20231106163236.GL496310@bill-the-cat>
References: <20230725231329.5653-1-seanedmond@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="cn0EPWS/dEdW6Pb1"
Content-Disposition: inline
In-Reply-To: <20230725231329.5653-1-seanedmond@linux.microsoft.com>
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


--cn0EPWS/dEdW6Pb1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 25, 2023 at 04:13:29PM -0700, seanedmond@linux.microsoft.com wr=
ote:

> From: Sean Edmond <seanedmond@microsoft.com>
>=20
> RFC 5970 states that OPT_BOOTFILE_PARAM (option 60) can be
> multiple parameters that start with a 16-bit length field followed
> by the parameter. For example:
> [ param-len 1 (16-bits) ] [ parameter 1 (variable length) ]
>=20
> This fix ensure we're considering "param-len 1" in the parsing.
>=20
> Signed-off-by: Sean Edmond <seanedmond@microsoft.com>

Applied to u-boot/master, thanks!

--=20
Tom

--cn0EPWS/dEdW6Pb1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmVJFSQACgkQFHw5/5Y0
tyyu2wv6Alss4sobJ/XDUio5nMJ5K7dM8rbQdlOUZT1x0kLspBHd/8qdip+dUSu2
vkrNB0SZjmMdaOzE/SPM3OC6JbFyvkLdOCQUu6B1DgW8yLgXE9sM2SqLQAzxpMwl
U5HEe4AMCxFOxNzQJRXcK9hDyY52D7RYaYktGusSujTbE2PTHDYXBPBRnNtPaS1k
GxQcONfyM1tFXYfDie0vnV89snxKTwqRWltJH5d1DmnmAAF6tpNBe4qgg60kr5Kc
BYwquiR0qJKRPkZ3pqVL9JCiZIFzZqENbC8PhdsWN0fwd5GjfdefflZ+s2ldq/pz
l4lkXRXMyjlg0FGG4PSSgRwd7N7dJfp91hgJGtpRAxf3AWjq92x3lnHfFeetxdA+
CIyk1WVBmNLtVffNk3ruSSmkRnf/gD2ZPFYeA1eiC3Ox+3mZGnGroi2YL71XOMOT
BAsxWhMD0nXfEz233hdV99rBlBs3DsyEj+KOSg9lk+fZrhhI4EtRqL4z+WlssXuq
F6L2mbsI
=DTA1
-----END PGP SIGNATURE-----

--cn0EPWS/dEdW6Pb1--
