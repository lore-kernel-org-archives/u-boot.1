Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B47FC3ABC9
	for <u-boot@archiver.kernel.org>; Fri, 16 May 2025 18:32:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6F1B982AE2;
	Fri, 16 May 2025 20:32:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="MJbv9Jaa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 75B9182AE2; Fri, 16 May 2025 20:31:59 +0200 (CEST)
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com
 [IPv6:2607:f8b0:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5770D80107
 for <u-boot@lists.denx.de>; Fri, 16 May 2025 20:31:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32c.google.com with SMTP id
 46e09a7af769-7303d9d5edeso1077980a34.1
 for <u-boot@lists.denx.de>; Fri, 16 May 2025 11:31:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1747420316; x=1748025116; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=pe3E8Nhm0oiEQiM+eIHarIOlzmK6mYn4JNJuGElN9Ao=;
 b=MJbv9JaandHPwEcODGxsAI0uuJ6vB4tnOoQuU51Pf7gatTJ1PixQxhWK6rt2qpB+Hg
 TbaCApChyIvbK53afPTevsRia03TXOS4xkk6mfQCehCAdOEf5s50WT53pYAYvXwWLrAp
 3wAYxx2ubKW49RANemGYBh15oTdwMxuNM/gRM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747420316; x=1748025116;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pe3E8Nhm0oiEQiM+eIHarIOlzmK6mYn4JNJuGElN9Ao=;
 b=Hj/zpq5L6Ver7PRKoJY0/t42HldPIvSvyaWpWFJZJZhjBAszAAccRbD/ccbfou5Jdl
 yxAe6hlLD1JEaDTGbE7LqhxSrsQS4U+XnwFQQZKVo1gIC+/g2e4sBB8EmecT//YkHPxI
 3xONVVy28OFmTp7gDHr6gfRZ7iYFacSIcbQRvF/kqJGVQYLdmIODBV45bYEDGydd+A6Y
 RNeaKVrTM9/LK4Maa4JrAhGmcOqXTwDTNxH7dqPg5/zh3gxsV1iCPK3H5eHMusC4cITW
 5tqGlBxV5PzTKmNGrV1nFWlVbvPof9eeK0dhJRlJd9LZP9anWkyMvKwxwX4t0aGjFZ9O
 nrQw==
X-Gm-Message-State: AOJu0YyuI20qyjwwkkWTVaHTTJQkfityDQKWwvFjeInoV5FeEMcZZk3W
 i8Vt74LOH999473v+hcmiF93+YIVk7igmT5HAovaR4qFCqPlz/wtuCW/SbmgPGk69Z0=
X-Gm-Gg: ASbGncuJ7L1q7mfvdxY1cwM3LMBJUoXwy61Shpb2GjoZ/OWSV/Jun7ayNxKY029uFVi
 rEYt084cbKzZyQcj4IaHJ7K4CTynxYbM5QDK1Zir2J7kqVWaeWujf3k9uEEH2KcJyxK5j0GWocZ
 Vl4+CsblcgnrnFWDhjq8j0Xm1VNlqnHgnnKLiSFFlF0YZYMJYZoZBE3GkADTlVU1dkdanYp+c9u
 PIdAReMGQFlGbFAYxEKJ6MiGJbEXeb/hqx2kuPyIfRCH1JUl8/FKLe2taZe9T3PFVcvrIHdmwxz
 Bcb6B/yD4BftHVrtvRjfmfqEga69Djdu0oxZaVNcCw1oRua3v78koAee0UPFDtC2vUH3MGYk2po
 yhpdWicJC/6d9
X-Google-Smtp-Source: AGHT+IEvBNaW9SvFTNnmYhYC2VD6vzPYC6wvI8WuyP3nUNURl9A/raiJ/n9OjNYNXgo58vlR9YDOgg==
X-Received: by 2002:a05:6830:90d:b0:727:2a38:d0d2 with SMTP id
 46e09a7af769-734f6af80c7mr3433073a34.10.1747420315994; 
 Fri, 16 May 2025 11:31:55 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-734f6a4afb9sm446536a34.13.2025.05.16.11.31.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 May 2025 11:31:54 -0700 (PDT)
Date: Fri, 16 May 2025 12:31:53 -0600
From: Tom Rini <trini@konsulko.com>
To: ant.v.moryakov@gmail.com
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH] drivers: usb: host: fix prevent memory leak in interrupt
 message submission
Message-ID: <20250516183153.GL100073@bill-the-cat>
References: <20250516175434.124221-1-ant.v.moryakov@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="3J2Y1IvNuU22JOnh"
Content-Disposition: inline
In-Reply-To: <20250516175434.124221-1-ant.v.moryakov@gmail.com>
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


--3J2Y1IvNuU22JOnh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 16, 2025 at 08:54:34PM +0300, ant.v.moryakov@gmail.com wrote:

> From: Anton Moryakov <ant.v.moryakov@gmail.com>
>=20
> Ensure int_queue is properly destroyed when receiving wrong buffer
> by adding error handling path. Fixes memory leak that occurred
> when backbuffer validation failed.
>=20
> Signed-off-by: Anton Moryakov <ant.v.moryakov@gmail.com>
> ---
>  drivers/usb/host/ehci-hcd.c | 5 +++++
>  1 file changed, 5 insertions(+)
>=20
> diff --git a/drivers/usb/host/ehci-hcd.c b/drivers/usb/host/ehci-hcd.c
> index 7d5519c65a9..765d8b327ee 100644
> --- a/drivers/usb/host/ehci-hcd.c
> +++ b/drivers/usb/host/ehci-hcd.c
> @@ -1557,6 +1557,7 @@ static int _ehci_submit_int_msg(struct usb_device *=
dev, unsigned long pipe,
>  		debug("got wrong buffer back (%p instead of %p)\n",
>  		      backbuffer, buffer);
>  		return -EINVAL;
> +		goto err;

A goto after return cannot be right, and should have had some compiler
warnings too.

--=20
Tom

--3J2Y1IvNuU22JOnh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmgnhJQACgkQFHw5/5Y0
tyxBsgv/QZN9ej9gvx8zpjFyKxYGCES2mGX9O4sTn79sFP9CoNAvcp8mY4YF8F7k
PKTIrUtmqUDzRZJ8EROTSLyPC4HKWeKID7RE1zR2tPbOLjIkqxQy5Q4/BbmQkfai
D+E7uuzYGvnmrYUsJakNDY7S6hS00UKs4yoV28j0mTAnzM02O/ixJ7VLYukmb5WM
KvsH4zlltBoAo2ITGfLEbnYGe1qShvLzXRKf6Hgt+5PKOmKxnthnFXEe4ib1m7W/
CKYM1jErap0ObdWng0Yof8/LOFdh1B2APUXhCGd7uhNvLOh3pB2b8yqlXQ/o30Rd
spZrWt9LrHMiAiawlkoQu/Mtl6S0GQC+3Qkgvnr93bENO+M0tLSbtrCVAgRMcJoW
ss2iivG1Sa6MwbUeDj+thbzB3HUS9y2jixJ7+tR5Htzu0ailsIgEwA1O+v9D05HZ
z4zT4UFaa8J/e4jr/hpdFEQL6zi8PQ3TIVVRWgeLA3ybZSQSNWdhQWf0nz80Cuml
lXhl9KW0
=iOq7
-----END PGP SIGNATURE-----

--3J2Y1IvNuU22JOnh--
