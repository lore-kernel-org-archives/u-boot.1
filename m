Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B19D9C54E49
	for <u-boot@archiver.kernel.org>; Thu,  7 Mar 2024 17:12:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D313D87E6D;
	Thu,  7 Mar 2024 18:12:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="bgU9kdMC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 12C4C87E80; Thu,  7 Mar 2024 18:12:48 +0100 (CET)
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com
 [IPv6:2607:f8b0:4864:20::731])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2374187EBD
 for <u-boot@lists.denx.de>; Thu,  7 Mar 2024 18:12:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x731.google.com with SMTP id
 af79cd13be357-7882dd2b1c9so91065885a.1
 for <u-boot@lists.denx.de>; Thu, 07 Mar 2024 09:12:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1709831564; x=1710436364; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=7AIsaPhE4I8HsI5/lbFDaqixSmWUHZpwh2WXOVV1ltc=;
 b=bgU9kdMCiThKaQPuFpjVc4yL3k/DQDgKVW2O/1MyBcLiVM+4Z894Trx2+dhd4sVaX6
 SylseGQGcIF2hbdoplurxB4HxKfi5KfPaqdLngQro4XK42irhgGB/dSAAe7BaDIO36gS
 V19aMNEZWbgVt+6WZCVwAQ7lpG7TyEGaPD/DY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709831564; x=1710436364;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7AIsaPhE4I8HsI5/lbFDaqixSmWUHZpwh2WXOVV1ltc=;
 b=CZWLRqlpcLeIpR608d5IljCtQK9Ga+BQ7MQiiL/nsccLl53cxkEd3E6lg0CqIc3kXh
 HT1SxVBCGbzWvf6wriSbe2lek2RHNTJg2H+kMvadutTTX5WW3NdXlQazA4wQiFtNQZFN
 Oo1C1Arakpska3qrAx8Ts98Ga9ka/uI/ryaZO1hWLy7lZensU9hutqeIInXcuRRO8wMc
 lrDdRXxD75at49vWLhUWkefcH0PsQJ1E5CG3l1h7qmu0mJotblbpHypIchI5B8roURpb
 OUkBJtlOmUm5egy6zPenU5gqXEXq2V0W2Hq9uv3ga1gmvM35i000Z3GD3euPWToNdRW7
 NpOQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXqA0Ki2sEN8ZYk6Cp8p+zWnpbNt8AljweRc2+0dnALYPxZ1W/8TA9MLNbov8wY/SE0JpSzqwbV3Y2XZc6ht87+ktAX9w==
X-Gm-Message-State: AOJu0Yz5pr3hS4yMOL2AVyQhWSEz99c+uJYTlY6CzHhrV/DVvJFVy+G4
 q7tKRnigy0SQiZu706Wo2YuVEJvWI206GF6o/mZXu/OUWWFJm5UkTPzVkjM8BvM=
X-Google-Smtp-Source: AGHT+IEbLE5+EMDOWTQV+zieUGYcpLQvlSigNgDeuyYXd9SuTrbFXWPd4OS7YyphDNYhFXdtR4oK+A==
X-Received: by 2002:a05:620a:2a05:b0:787:ea8a:d081 with SMTP id
 o5-20020a05620a2a0500b00787ea8ad081mr3132424qkp.25.1709831533997; 
 Thu, 07 Mar 2024 09:12:13 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-007f-0000-0000-0000-1001.res6.spectrum.com.
 [2603:6081:7b00:7f::1001]) by smtp.gmail.com with ESMTPSA id
 j12-20020ac84f8c000000b0042ec784680esm5256998qtw.16.2024.03.07.09.12.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Mar 2024 09:12:13 -0800 (PST)
Date: Thu, 7 Mar 2024 12:12:11 -0500
From: Tom Rini <trini@konsulko.com>
To: Roger Quadros <rogerq@kernel.org>
Cc: Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, nm@ti.com, srk@ti.com,
 s-vadapalli@ti.com, vigneshr@ti.com, mripard@kernel.org,
 dannenberg@ti.com, r-gunasekaran@ti.com, danishanwar@ti.com,
 u-boot@lists.denx.de
Subject: Re: [PATCH v2 1/2] net: mdio: Handle bus level GPIO Reset
Message-ID: <20240307171211.GK1523872@bill-the-cat>
References: <20240228-for-2024-07-am65-cpsw-mdio-v2-0-f74f972eafeb@kernel.org>
 <20240228-for-2024-07-am65-cpsw-mdio-v2-1-f74f972eafeb@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="TJgP3WTm4NG5YvmA"
Content-Disposition: inline
In-Reply-To: <20240228-for-2024-07-am65-cpsw-mdio-v2-1-f74f972eafeb@kernel.org>
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


--TJgP3WTm4NG5YvmA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 28, 2024 at 12:35:26PM +0200, Roger Quadros wrote:

> Some platforms have bus level Reset controlled
> by a GPIO line. If available then handle bus reset
> via GPIO.
>=20
> Signed-off-by: Roger Quadros <rogerq@kernel.org>

Applied to u-boot/next, thanks!

--=20
Tom

--TJgP3WTm4NG5YvmA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmXp9WsACgkQFHw5/5Y0
tyw8Ogv+LEpYJIB4ioQDLr7iF2RqM/Ka9uu2PeXBg+ySjIVh3RnCWTCe6wxyoELZ
pm2Wl8qINUuiK8Qd2Ful1ch/cyHRryGLjtuC8KnGT5Y7DG6zPpsy/MK7N671ioIw
3KjcooRbWasO1VHm07I89ynNSfFYZMUlwmcuVT4hfRSHJVUh/8JwtjKvMqsHJzZ1
WMaULNlnUG236UlK/zMkXyQ+XZMebvDkNwKMo+LPOtFZfcX/nkjENu/fLL26OqU9
Hg5IxRFnest/gMjLgWPPOxH8POaOyXAyv0fFGCf2rCBr0mW5RCFRzZDKId41GUgv
UGrnkav5gkZUjPjdh1VgCkqSPY9d+Zq6hh7uj6fHDm+sJKhMpI6rxKzkb0Bi9aX1
aWBRv5ZJwqUwvSEU3sEpsd7b7rsw/F5u/rx3GxilAELgHFJvaVdugJC2cv7v2c1D
z2azBKydALH8oyEHh2yAuqU4EYaCSTN3o7NS/ITKBAZm9Hcito2xakQI5QCCjUEo
XfgScyww
=9MZV
-----END PGP SIGNATURE-----

--TJgP3WTm4NG5YvmA--
