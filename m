Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDCF2D7494E
	for <u-boot@archiver.kernel.org>; Tue, 29 Oct 2024 23:53:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AF5A1891BC;
	Wed, 30 Oct 2024 00:53:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="byOQhDId";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 276A9891B8; Wed, 30 Oct 2024 00:53:09 +0100 (CET)
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com
 [IPv6:2607:f8b0:4864:20::f29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 233EC891A3
 for <u-boot@lists.denx.de>; Wed, 30 Oct 2024 00:53:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf29.google.com with SMTP id
 6a1803df08f44-6cbce9e4598so37059386d6.2
 for <u-boot@lists.denx.de>; Tue, 29 Oct 2024 16:53:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1730245986; x=1730850786; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=cfVVOhEY5wuruiQu/e5cOoCranO4ChA39lHdmEUP/Bo=;
 b=byOQhDIdphb0feuyKeKI9DfqJ+Gv5hm6150LsMa5gpkSt01gl6fKA5zNMh3cFbiA4a
 OMVzRv3+7KQeYJk9uoxECyPfh9XYNL+xAwfrEkMlb+aMU5ie6nK2e86By2HOyvREAsc6
 ZUOxCGYLZjGre2I9+WBOdEcQYXY0d7F1TPx1Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730245986; x=1730850786;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cfVVOhEY5wuruiQu/e5cOoCranO4ChA39lHdmEUP/Bo=;
 b=BYN4e2dT7HtmSQ4B/Bgg00vyPeSpM4NCBEuSUFK7wfIUUEQufBCkjmPmBbXNmNJsGR
 IRCEXbZKgyx1uTCpz8tWNOJpgrtbM5Uiix54bTYDyyInJN8rCXXgQqqXZimCcPEQHoGg
 HZZHUgmw9qzNVJYUZm6H2N9go2okWgcIAG8EIxQgWegYEFbBHUFwWvT28fvgB39Xv1H1
 Az4t0w0R9dtSkEfqzUwMvvewAq4rB19ovqa292JdQ9E/OKMxlc+ZkjuFB7xvHnLho3/Q
 5Ylm7wwySw5NWWUxAQmjjV1MZMws6E7vxG0Lzu4fZk80uVic9pGyf41DJ64BwpOc9/UF
 JKkg==
X-Gm-Message-State: AOJu0YwMjehlL4GyjqZTDJvghYbib+tP58fOUFH+NxC9nUXv1cOKQL6R
 EHP3fhBeqIL9Yeq1w1U3rt8dCq1qk4EnPce96jWswUMqHtYl7WOsoaIObMxE4+L/GH1ks0C/yIs
 TLY8=
X-Google-Smtp-Source: AGHT+IGWOHPw8D1aypsEu1lvSARSFSBe4kbOXZ2XLXUs2wocpCIO3E+Sjsww0aVVmSJGgyPf3gdXiw==
X-Received: by 2002:a05:6214:5348:b0:6d3:469e:b767 with SMTP id
 6a1803df08f44-6d3469eba2dmr13342346d6.9.1730245986038; 
 Tue, 29 Oct 2024 16:53:06 -0700 (PDT)
Received: from bill-the-cat ([187.144.104.2]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6d17972f572sm46687706d6.20.2024.10.29.16.53.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Oct 2024 16:53:05 -0700 (PDT)
Date: Tue, 29 Oct 2024 17:53:03 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: [PATCH v7 02/11] test: Release board after tests complete
Message-ID: <20241029235303.GC2558755@bill-the-cat>
References: <20241010015145.1977999-1-sjg@chromium.org>
 <20241010015145.1977999-3-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="cKkYjyOZOH4DV09D"
Content-Disposition: inline
In-Reply-To: <20241010015145.1977999-3-sjg@chromium.org>
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


--cKkYjyOZOH4DV09D
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 09, 2024 at 07:51:36PM -0600, Simon Glass wrote:

> When a board is finished with, the lab may want to power it off, or
> perform some other function. Add a new script which is called when tests
> are complete.
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>

Reviewed-by: Tom Rini <trini@konsulko.com>

But please note I don't see an up to date version of the
u-boot-test-hooks side of this which would include the release wrapper,
and presumably files.

--=20
Tom

--cKkYjyOZOH4DV09D
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmchdV8ACgkQFHw5/5Y0
tyyqmgv8CA6fgwBIrAWeIWsc6jSjHceErc7CRf+G1848tKMwY7NdsxiXo//heVB4
jKNdavI6jI+VLoraJ3csxDKjRK6epXEYaE453nkVaAkD0+OJW+NR9Z2kSaFu5pbg
pex2+I7IAu5OOO5l8+vhtUnmFGTBatHIV8Y6PRJalH1hM9nWVWB/9G7KoOXRiuVm
7WWDnQcJYflBps4CXschlcddCfeBSwV93N+Dqz3Q2AbIGeBCQ1EHXhvh6E5NyKBz
Dx8iQ3er8+1NByCzvzIXmuAs0p+y0NusiqYoUo9YfKWizeNrdgzb96D9lK6YWth3
+ophRQ3aRLzhYQevHrMQ6CxbOtqFtUlSYdlTos7BZkcMGvZMAZ7BEX2wNh+aEkP3
GbdNJpEqSGh5J1+5xsfha1wxWXpVCc+Ni3EA92BPvD+fBoLVb7y2IFKAK2hwuX35
EJzM0FIzADay8C0ET9y8qXYeaBHTODNJKc1ClURwXC/VLuP9LsOTFwcHRQ3Lbbgq
riKcLH2H
=J4O7
-----END PGP SIGNATURE-----

--cKkYjyOZOH4DV09D--
