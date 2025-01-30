Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC203C0218A
	for <u-boot@archiver.kernel.org>; Thu, 30 Jan 2025 14:51:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 31DB0820E3;
	Thu, 30 Jan 2025 15:51:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="m+tJdSlv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E1093820E3; Thu, 30 Jan 2025 15:51:11 +0100 (CET)
Received: from mail-oo1-xc33.google.com (mail-oo1-xc33.google.com
 [IPv6:2607:f8b0:4864:20::c33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A2DF580EBA
 for <u-boot@lists.denx.de>; Thu, 30 Jan 2025 15:51:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc33.google.com with SMTP id
 006d021491bc7-5f31b3db5ecso400774eaf.0
 for <u-boot@lists.denx.de>; Thu, 30 Jan 2025 06:51:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1738248668; x=1738853468; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=fiJB5XFL8olGUHr27Hb3lQFQ5EuBVrgV9i2NrHnXpPY=;
 b=m+tJdSlvuxYCDCF2uORStPuZY+CsNxQYewxRpPyv5IdZcd0Ip0rpNtk6WNXF+EtF4N
 KDWtwlEGDprDXvfeRR8zi89cVzomqgRFOaZiGxfppbw4cqTrp5JwET3Sh0KYRcZ+I0BC
 DL6C5zViZab42UeiUS1B1cQvkh9ca8bFH3tj0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738248668; x=1738853468;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fiJB5XFL8olGUHr27Hb3lQFQ5EuBVrgV9i2NrHnXpPY=;
 b=jqSBDmBHt++49sMbxDocxhiPczJ89faGmdeOnZcS2D1e3hR63/QfRPSmSV4q0TFmrP
 BDXTEEhwYW+4kgTebUei1WDAVujxGnfpCCPlRueUS5BKQWrKSaCN7vFmMtNm5bx3Z+Bf
 tZibDkK2IlBKZhgnZ4i+JSb0GFQfz5aL2JK+OmCYiK8gJ2royDzKrSFIDr1dLxLbkNJT
 Xv6URWEt/s8r4G2xnTULuOxm6+VNFS/sbU04Cy32YGDp3/uVc/3EQI2Gqk9Eew2HQAO/
 vO4O4d8faz0vUIqCR1AY41ECR/P1qCiQhgFw9SKQDPJBgFEG5P0ZVsMw1XLVBK9mrOoZ
 AiFg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWICUMPE1YTbU6tNrZ0b7t9tIg0mnbGvxfMWPl+AWWOo0l1P0B48U1wPSSWOJV9zmpnbzfV8zo=@lists.denx.de
X-Gm-Message-State: AOJu0Yx3bU8sAAiPW3eUmxtOZXLjOg2gQtt7Tar45kR33oH/N9G8EgsH
 xay0R4J66vU9a93QqLm2ose6XlgAp9904b1pjyIfK+9sNf6BvMsOwHywPF0qw4trMarJdHHCO+Q
 s
X-Gm-Gg: ASbGncudvcKcStr10/eyvClfmhOHtUp22Bat+uBPQ977/agOP65kBYndnqRwTSswGRx
 0FWrDQ2VznZXEQEolQ2EEDfURCkwcAv0UXD4K3DZPP7WTfFBCmIEPp8i0ZuP7pONdiTaszsto+b
 BwnKLSs2z7Kzp8iK1i9qwFJ0xN9XFfXYbZqwecUQ5sN/PkGpID4qHHtYEuBNHcQ1GCmxemtmAgA
 9HOw3oFsu+z4yVVfmKRL/36HuHQZlyY3TcINS+xvwVAWJQHteG+xO/a+/wSPg/wA+mTd2rh1ebr
 xiMyfJx/0ZA0+RQ=
X-Google-Smtp-Source: AGHT+IG2v0npE7CK+/rcvSaqrTG02MJeMCILyj4IqWuBWf1f6Qtd39jaf1EyXRORUBKF9+xN6nuIxA==
X-Received: by 2002:a05:6820:80d:b0:5f6:4ce2:fa4f with SMTP id
 006d021491bc7-5fc00454789mr4157130eaf.4.1738248668337; 
 Thu, 30 Jan 2025 06:51:08 -0800 (PST)
Received: from bill-the-cat ([189.177.145.20])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-726618b9ff2sm338113a34.45.2025.01.30.06.51.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Jan 2025 06:51:07 -0800 (PST)
Date: Thu, 30 Jan 2025 08:51:04 -0600
From: Tom Rini <trini@konsulko.com>
To: Martin Schwan <M.Schwan@phytec.de>
Cc: "sjg@chromium.org" <sjg@chromium.org>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 "upstream@lists.phytec.de" <upstream@lists.phytec.de>
Subject: Re: [PATCH 1/2] bootstd: Add implementation for bootmeth rauc
Message-ID: <20250130145104.GZ1233568@bill-the-cat>
References: <20250129-wip-bootmeth-rauc-v1-0-6308e732f314@phytec.de>
 <20250129-wip-bootmeth-rauc-v1-1-6308e732f314@phytec.de>
 <20250129160323.GV1233568@bill-the-cat>
 <da13999132b06d7891ffc85edfc3147e64cbaa93.camel@phytec.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="TeS6IFd/JnNKY54c"
Content-Disposition: inline
In-Reply-To: <da13999132b06d7891ffc85edfc3147e64cbaa93.camel@phytec.de>
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


--TeS6IFd/JnNKY54c
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 30, 2025 at 09:48:19AM +0000, Martin Schwan wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA256
>=20
> On Wed, 2025-01-29 at 10:03 -0600, Tom Rini wrote:
> > On Wed, Jan 29, 2025 at 03:25:25PM +0100, Martin Schwan wrote:
> > > Add a bootmeth driver which supports booting A/B system with RAUC
> > > as
> > > their update client.
> > >=20
> > > Signed-off-by: Martin Schwan <m.schwan@phytec.de>
> > > ---
> > > =A0boot/Kconfig=A0=A0=A0=A0=A0=A0=A0=A0 |=A0 11 ++
> > > =A0boot/Makefile=A0=A0=A0=A0=A0=A0=A0 |=A0=A0 1 +
> > > =A0boot/bootmeth_rauc.c | 408
> > > +++++++++++++++++++++++++++++++++++++++++++++++++++
> > > =A03 files changed, 420 insertions(+)
> >=20
> > I'm curious, what would be required to have this work for any block
> > device, rather than just "mmc" ? Just a lack of time / testing / this
> > is
> > v1 and that's a future idea? Or is there something more fundamental
> > required within bootstd/bootmeths ? Thanks!
> >=20
>=20
> Besides MMC, RAUC supports updating SSDs and raw NAND flash [1].
>=20
> I guess there should be very little to no adjustments necessary to
> support SSDs (probably only adjust checks).
>=20
> For raw NAND flash and using UBI volumes, this would require some
> additional code calling the correct read operations, but is definitely
> possible. I did not implement it yet because of lack of time and
> verification, as you correctly guessed.
>=20
> Network devices are not supported for obvious reasons.

Thanks for elaborating.

--=20
Tom

--TeS6IFd/JnNKY54c
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmebkdgACgkQFHw5/5Y0
tyw+dAwAm6Z8MHdPl3m7ekhQPzn/O8TjUUJhyYep/kUiy1e0osxS0Q/ZmQV7MqaP
+Bpcr+e6flUprlCMesDnTLYlC0r2gjeAxeTcQmuDPFhTaSd6QeIRI2B8IpRWSlYT
nM4YYo1WU8Ui14GITT/rIN57LVmSAmhWF/eN6z/ap1+A9K/pVJYAkB9uC2rH1llk
hgrL0p3DXB5MQUWhwQ/Zy69P+fybegnuXeAofOsSX5b0b7WNvXnrzvUBhqn9wA45
kXZ9iwndUPhv7JvAtwcM9/e5gujC6lfRffhzux2ET0Hn5TeXyu4abvhBHUf6New3
/5IyWMB857Y5t8FXSp193DFZLtSwgH4fImRHdVZf85sFlmvkC7wTR7BC2cB9dc/u
UFR1GroWg1zCw1jhJm+nX75rNw9/qDyBy2Ce16oWXorjWJ28Pg14ImwHrp4cVbkf
Gxt91IeYyRT9hsjJdl7FaeHNs5c9wKekmsQjXdY4W7L4kdYoayPd00pFnwTSMHGH
rQh5C4b+
=ZO0a
-----END PGP SIGNATURE-----

--TeS6IFd/JnNKY54c--
