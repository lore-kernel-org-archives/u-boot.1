Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D201C61D97
	for <u-boot@archiver.kernel.org>; Wed, 22 Nov 2023 20:49:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 39F2C87627;
	Wed, 22 Nov 2023 21:49:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="IalJIqB6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8B00087650; Wed, 22 Nov 2023 21:49:21 +0100 (CET)
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com
 [IPv6:2607:f8b0:4864:20::1131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 765B187641
 for <u-boot@lists.denx.de>; Wed, 22 Nov 2023 21:49:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1131.google.com with SMTP id
 00721157ae682-5cca68f6e01so1850567b3.2
 for <u-boot@lists.denx.de>; Wed, 22 Nov 2023 12:49:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1700686158; x=1701290958; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=WTDwa9nSlqhzNgY65ZsDeD1vOrN1N5Ki/AqpvYoSSb0=;
 b=IalJIqB6oiMj3sEnjerxpZ0Xc7pWta0ZErRqS3qpHkqK/v/9cM2ArilTuh05IVdE/f
 uS1vhvhag+FvuBJH/G28/7J30htMKVdcLlmjLCCSqbpW9YeNNVDATAz7skW1czZQ2WC4
 oZS5sBPYwCyf4+A5lWw+kn5b7nZpji1KScITc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700686158; x=1701290958;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WTDwa9nSlqhzNgY65ZsDeD1vOrN1N5Ki/AqpvYoSSb0=;
 b=vh68bd1FvYbFlawWPjZm7Mdk/QvUQCO3dolugGjdwhzc+OatGSK+jZ1ZimARkj3NOU
 t7exT5Q637pgCmZumpr512V82A6HP7LvKVIHSwRaNjnXcq5we/lq2IzryeDTCxtj4yxa
 eqFmJbD/+/KTz1IB8RpNA+cUfjqRiMBzt2DjDa8UF1hWtJIKCrIZbY9moKPkAt0Vugye
 k1x0BHJo5FBqhzCcBOAHzz2OMdve/gy/lksZhLIKEqlATbFUXgQGKYomHMQaWiEDAXfZ
 6UlYCrLNBtNJrdSUWvWHoaFETt6kBPZd9XV4Z+iS4BLZ0tBWNH66vZGN8Y0dbSAgpeck
 LdXQ==
X-Gm-Message-State: AOJu0Yy+1m8w41jmF6m2IplCuB9O3SUgornCXmSmbbXBbT0bu2HfZGEt
 qkw7JHl4pNs9cBeh9E0uXj2C2g==
X-Google-Smtp-Source: AGHT+IGMn40VS98+pa27nuTlVHro3WVLYKM+EE1yiDjmcwLe9Yohi2BQSZl43qLqcfNxEo+zpVNL6w==
X-Received: by 2002:a0d:f945:0:b0:5ca:d579:52f with SMTP id
 j66-20020a0df945000000b005cad579052fmr3465036ywf.35.1700686158239; 
 Wed, 22 Nov 2023 12:49:18 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-999e-39fe-b112-e0fa.res6.spectrum.com.
 [2603:6081:7b00:6400:999e:39fe:b112:e0fa])
 by smtp.gmail.com with ESMTPSA id
 o11-20020a81de4b000000b005a7bbd713ddsm83668ywl.108.2023.11.22.12.49.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Nov 2023 12:49:17 -0800 (PST)
Date: Wed, 22 Nov 2023 15:49:15 -0500
From: Tom Rini <trini@konsulko.com>
To: Nishanth Menon <nm@ti.com>
Cc: Neha Malcom Francis <n-francis@ti.com>, Simon Glass <sjg@chromium.org>,
 Marcel Ziswiler <marcel.ziswiler@toradex.com>,
 Vignesh Raghavendra <vigneshr@ti.com>,
 Francesco Dolcini <francesco@dolcini.it>, Andrew Davis <afd@ti.com>,
 u-boot@lists.denx.de
Subject: Re: [PATCH V2 1/2] arm: mach-k3: Move K3 degenerate keys out of
 board folder
Message-ID: <20231122204915.GA2513409@bill-the-cat>
References: <20231104024511.3597476-1-nm@ti.com>
 <20231104024511.3597476-2-nm@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="pE0B7i4REWV0g3Bi"
Content-Disposition: inline
In-Reply-To: <20231104024511.3597476-2-nm@ti.com>
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


--pE0B7i4REWV0g3Bi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 03, 2023 at 09:45:10PM -0500, Nishanth Menon wrote:

> This file is common for all of K3, move it out of board/ directory and
> into mach-k3. And change the relative paths to absolute paths in the
> binman paths.
>=20
> While at it, drop the reference in verdin-binman file which is
> redundant.
>=20
> Signed-off-by: Nishanth Menon <nm@ti.com>
> Reviewed-by: Francesco Dolcini <francesco.dolcini@toradex.com>
> Reviewed-by: Andrew Davis <afd@ti.com>

Applied to u-boot/next, thanks!

--=20
Tom

--pE0B7i4REWV0g3Bi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmVeaUsACgkQFHw5/5Y0
tyyoJgv/eM3NNj2VG5kw1oCOVLwCHjNQY7rpHa/qk5uF6jUjmq5lLGvYt4pgXtG2
RMteEDKl/z23c74na65/J9RUZ6Lbz5iNBdOa7G8qtxKojn5cYO5w8tGI9eEsFhIZ
Z10QqZRznsHgnJSdj//jD6Q2HhiojyIM30SNq/t1CTqwFZbuVhrFs/pm6/V7riMO
hkSFaum1RfzF107CfwVna8u3JWJC60wP4DH9MfW+Jlps0bS3ceKPnxNgEy2OnvEs
VD3xsHpCfv2oJfvmcTwlfY3pksCcuyFywu13QTM2fWFXSI9cPUk+KAOJ21M8ydbP
4aYMJGSY+yHhJ8q9o/H5ouYnObTz9o0P+CqStwmJuxlsRpydVPMWyTfQVaHMU72J
UhjyjhbW0hZ6pD+Bsg46JMr3CeZB8BPKOReiOcyICZXBThdXBiAlzoswWWlUWK3H
xOr5QyTsGxCB6I/pBvg55gG9R5pmnFI08mr1wNxuX8jtFfCcWmVYKM1fYyjQiB+r
xRITJ04q
=qzzE
-----END PGP SIGNATURE-----

--pE0B7i4REWV0g3Bi--
