Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7692C27C79
	for <u-boot@archiver.kernel.org>; Thu, 20 Jun 2024 14:34:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4BBB988535;
	Thu, 20 Jun 2024 16:34:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="A+6eU+nX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2396F88541; Thu, 20 Jun 2024 16:34:38 +0200 (CEST)
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com
 [IPv6:2607:f8b0:4864:20::22f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0F9CB884DC
 for <u-boot@lists.denx.de>; Thu, 20 Jun 2024 16:34:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22f.google.com with SMTP id
 5614622812f47-3d218ea7750so485169b6e.3
 for <u-boot@lists.denx.de>; Thu, 20 Jun 2024 07:34:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1718894074; x=1719498874; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=aUWzXqGZfn4rO4cb7Jq2gClV0NMcFyDetFinbt0RjUw=;
 b=A+6eU+nXwNt7idpvTU4/JhO7r/DfO7kOccsiMNgMU5VQGj9ZO+nakt/VChtrMuM+L+
 qmJL7AQDgr6JUcUqxO31m18MeKbcoDcTnzxnY1xEgi+TsmotlX8hQCV6YcyMX3Zxdvqm
 EdGY5SxYki69v/ZuZmY58GAOlOnENfrzXe7Rw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718894074; x=1719498874;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aUWzXqGZfn4rO4cb7Jq2gClV0NMcFyDetFinbt0RjUw=;
 b=CzGTK89qQquPMVS2nA1NltVzAsVO0N/JDEuOcxUKNXuiocJHpVEC1XfYwcYUh77YsT
 toBL8ZuJgMkExnbg+ZGgv1wTCnVG1eZ95IYUi/NgnaOnSWCiiERAuwhiunChtig4fvFQ
 te/bzMQISbySB4Yjv99PszutlwzNs5MVMhFvH+izM+82Stmm7+8kvixEp7IiEMAjhJRK
 RjZ+4czyToL/W6e7OX8O9UkewU1JaC7nrSRdFhxwNIWmS889RAFCNLPYAXZfZj5E4aoN
 CG2TRusmucZmKmglOfe6u0XR0r2K6Iys6Sp19GP+mH201XOp8blfrwhhvDxkETFa9076
 A8iQ==
X-Gm-Message-State: AOJu0YyiENGDY+srm0GT4iaxc7FDRO1rzznydStF7drgV/k4HWujNc7c
 A1t1PYx/EDy+6Z5p6VCqWNntufX+O9uotaLFcZDIBEUxAPGGmZXDOJrbK04fxuo=
X-Google-Smtp-Source: AGHT+IFy5y9VNrwnqXeK6Ig7uiAjrJQybmOZbcNmhio1lebPsVtYhYMIVz12WcrEREHEI6b0HqIqaQ==
X-Received: by 2002:a05:6808:148c:b0:3d2:30c1:e5db with SMTP id
 5614622812f47-3d51bae51fcmr6087893b6e.44.1718894074597; 
 Thu, 20 Jun 2024 07:34:34 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-205-45.totalplay.net.
 [187.190.205.45]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-3d2476bb36fsm2518478b6e.40.2024.06.20.07.34.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Jun 2024 07:34:34 -0700 (PDT)
Date: Thu, 20 Jun 2024 08:34:30 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Andrejs Cainikovs <andrejs.cainikovs@toradex.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Sean Anderson <seanga2@gmail.com>
Subject: Re: [PATCH 5/5] CI: Run code-coverage test for Binman
Message-ID: <20240620143430.GN68077@bill-the-cat>
References: <20240620131937.1130446-1-sjg@chromium.org>
 <20240620131937.1130446-6-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="TfReLNI9RxHaC/GO"
Content-Disposition: inline
In-Reply-To: <20240620131937.1130446-6-sjg@chromium.org>
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


--TfReLNI9RxHaC/GO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 20, 2024 at 07:19:37AM -0600, Simon Glass wrote:
> Binman includes a good set of tests covering all of its functionality.
> This includes a code-coverage test.
>=20
> However to date the code-coverage test has not been checked
> automatically by CI, relying on people to run 'binman test -T'
> themselves.
>=20
> Plug the gap to avoid bugs creeping in future.
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>=20
>  .gitlab-ci.yml | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

This misses Azure, please update as well.

--=20
Tom

--TfReLNI9RxHaC/GO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmZ0PfYACgkQFHw5/5Y0
tyyweAwAlRp6lLuWKkbCr01fZNsLiaqKyyofskmXjUadMKk/5hXUD6pHwif0kCDO
eMrpa3q8xDS9ejZHTPhZlSQ7p4DWdfdvJ3mvDhcTjkSbS7IcG0FpRhEOltpmplbK
gh0W3+df8/svwaqM7xeThFEvSdp4DidpleeLCUmvxhXjkotvqTAaNeqjyDkZYLWq
buZc49H5Fdn/qLCTtKTwXf0Cc/7GEfksqm9H5fDiX7uEFpeUTlvUwtcrPs9nJACR
Pox2EW1XM5VJPSHzw6EBV7t5HY9Fz2D+BimmfLkb9zPHz/J0LgtBzFt8/D6gwhYO
PjezjRYm3SKyQs3jhEN5+pS4jdO7ITBBuNbzqIV0O8yyj5BdpRUTX+9nM+ZVmYon
B9/2aZrzoi4+Y8La5Muv6Ere3duUpoPs+7dSQVRcEiyf1W8BKvofs+W/lJoTUJqo
rVlQe0Na83KD4P1EQUVArwCEbx24O+07QqwX8b1YCypD3eeS2TEB7kMVk3khnAM6
/af8vdjK
=2jNW
-----END PGP SIGNATURE-----

--TfReLNI9RxHaC/GO--
