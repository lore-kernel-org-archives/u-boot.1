Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 015CACCF9F8
	for <u-boot@archiver.kernel.org>; Fri,  7 Nov 2025 18:57:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3F9D983DF3;
	Fri,  7 Nov 2025 19:57:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="pOBd9kls";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7EE1183E1B; Fri,  7 Nov 2025 19:57:32 +0100 (CET)
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com
 [IPv6:2607:f8b0:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0D9A183DF2
 for <u-boot@lists.denx.de>; Fri,  7 Nov 2025 19:57:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x332.google.com with SMTP id
 46e09a7af769-7c28c21aba1so652901a34.0
 for <u-boot@lists.denx.de>; Fri, 07 Nov 2025 10:57:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1762541849; x=1763146649; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=46hdDnQbyLiTJ7sMe5lBUPsm28B9szhbKT6L4ich5Bk=;
 b=pOBd9klsNuZGJcZF4w3GOzAhHTOgh3NNJb2rv1/Eq+AnvefRj2PdjdDoA+GZyablID
 66aax2VW60j8sV8eadAL+hgNLqcyA0R9tIgMxfN6xVPDSph7FUXOIBmnUOc2caxoyL+h
 BIffSVYM4Ejud8jSOUXnB8qNlJWhBZ0DHbUDA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762541849; x=1763146649;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=46hdDnQbyLiTJ7sMe5lBUPsm28B9szhbKT6L4ich5Bk=;
 b=Z9nLVQ859rPVPgkLexitqpJ3kLQXb5pTejtEULhJQt/UW6xj7wguS4s611qKre0I07
 ivgBXTHiM3Q69cVwwZrOsqe5sDkKLvHXbxc/5HzE1BtOJNJgYVr79WPJD5qai2j/uTUa
 +/9LBfRoepDp/jBgfpOrorCJ18/uiyiZ6LUaPG3kNLL6YegKLdkRsLLzBuvIlnFvcA7G
 ozja0buaJX6KIj8cB7ZZqiawaG558FUVH+kTwxj5oote07Zs3kCZIw6a9iDH8Vy3Br3u
 oYFXG5et8uXqcycGDTd+3q+jASHIm8QCvVqpDIlWgb/bGOlRyJ34Cf/IiD5k1kNLNEUQ
 3ZhQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXEWqZlubSomHBBCs0ad14RqNuWi8ZJrWUYb6CySfY0srhO5ITbFfxpYYhOyE1dpYdrsEg7u/c=@lists.denx.de
X-Gm-Message-State: AOJu0YxZ78z07mJznNhbYEon/3EYrsbI3xt4IPUZZ7gRyPPexdBhrWj+
 BTuzUk1YrKe1T4kroVgZjXgCmpRnXZK7DZ4N0TIe0Q46+LPECN4HP79pkM1EHYugMss=
X-Gm-Gg: ASbGnctnPztH9Wjyifa+JcqipADgP9XxD/sQsDgz5pq1p2KnRzVnSXae4pwDoc1TXAG
 Mq2KEr9R09nMFW2o0nNyJMDQJ2xsbywmmt1/2KKTCTLZ5997UZN+3AbtK/SMWereZxWPuI+TFBR
 1JM/UXG/d3yq/ykjIeyeOJg7Wd/CAQRv3alOa8efxJUpZcvzAmAkfgZ1peCRZHgA6uPRHtY+Dnm
 6P/eiURfixJYY6zZM4cIEIxP+yH38kLx/6SOD57G2b2ySqlIzn+srx4K+tqThqXTcvEEmm6wYcT
 HCFcffHnqeW1wUaf+hVYv4I+J1qkB8Yp5iICavpW+ln658RzNM5bQzLPYrGngxiDlXsKx+ezFAp
 bW5cPCBtnWUfdqaJ7+/+hlrewHr60r8dvdsRQvRh/66+2vpy6G694TWnDsI7dQlMO3++ReSDbwy
 AgXALpMav2kGdhe5NVW1F2UMgteEZKyeXAHFsu95Xl3vP7pmjy5A==
X-Google-Smtp-Source: AGHT+IEbUh/KV+t2KSOyedscBD0lR5Dt5+zvszQDki8OXkPfDXZ6LXT7ZQBQMtib/L0EoBJgDXGjNw==
X-Received: by 2002:a05:6830:718e:b0:759:55bd:9594 with SMTP id
 46e09a7af769-7c6fd71b237mr281446a34.6.1762541848692; 
 Fri, 07 Nov 2025 10:57:28 -0800 (PST)
Received: from bill-the-cat (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7c6f0f0a6dasm1955606a34.5.2025.11.07.10.57.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Nov 2025 10:57:27 -0800 (PST)
Date: Fri, 7 Nov 2025 12:57:25 -0600
From: Tom Rini <trini@konsulko.com>
To: Hrushikesh Salunke <h-salunke@ti.com>
Cc: Bryan Brattlof <bb@ti.com>, vigneshr@ti.com, jm@ti.com, s-k6@ti.com,
 quentin.schulz@cherry.de, afd@ti.com, j-humphreys@ti.com,
 anshuld@ti.com, n-francis@ti.com, danishanwar@ti.com,
 rogerq@kernel.org, w.egorov@phytec.de, sjg@chromium.org,
 u-boot@lists.denx.de, s-vadapalli@ti.com, srk@ti.com
Subject: Re: [PATCH v2 0/3] Add PCIe boot support on TI AM64X SoC
Message-ID: <20251107185725.GA2074336@bill-the-cat>
References: <20250616165638.632089-1-h-salunke@ti.com>
 <20250910145656.5lesv67c5tq5tvar@bryanbrattlof.com>
 <be444e57-fdbb-4e4a-9592-2d48a5626d49@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="r21yYdXOyTd1lJah"
Content-Disposition: inline
In-Reply-To: <be444e57-fdbb-4e4a-9592-2d48a5626d49@ti.com>
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


--r21yYdXOyTd1lJah
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 11, 2025 at 11:08:03AM +0530, Hrushikesh Salunke wrote:
>=20
> On 10/09/25 20:26, Bryan Brattlof wrote:
> > On June 16, 2025 thus sayeth Hrushikesh Salunke:
> > > This patch series adds support for booting over PCIe on TI AM64X SoC.
> > >=20
> > > AM64X contains single instance of PCIe controller, which can operate =
in
> > > endpoint mode to support PCIe boot. This series:
> > >=20
> > > - Adds PCIe as a valid boot media for AM64X.
> > > - Enables necessary config options to support PCIe boot.
> > >=20
> > > This feature has been tested on AM64X EVM. Following are the logs
> > > corresponding to this feature.
> > > https://gist.github.com/hrushikesh221/bb11746d4325a27f209028573f3255a1
> > >=20
> > > Program used to copy bootloaders from PCIe Root-Complex to Endpoint:
> > > https://gist.github.com/hrushikesh221/6dc406b72f38762357b8e7f81a47db56
> > >=20
> >=20
> > We need to find a way to put this sequence or this example code in the
> > board docs. I don't want to have to rely on your Github account or my
> > memory when we need to revisit this in a year or two.
> >=20
> > ~Bryan
>=20
>=20
> Hello Bryan,
>=20
> Thanks for pointing it out. Some changes were requested for the patch
> series[1] on which this series is dependent for functionality, so
> I will be posting the next version for both the series. Along with
> it I will also post a patch for documenting the PCIe boot.
>=20
> [1] https://patchwork.ozlabs.org/project/uboot/patch/20250619071841.12653=
64-1-h-salunke@ti.com/

Please make sure that v3 also builds warning-free. The trivial update to
v2 to build on master (now that the generic DFU part is merged) has
warnings. Thanks.

--=20
Tom

--r21yYdXOyTd1lJah
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaQ5BEgAKCRAr4qD1Cr/k
Chj7AQChEvjXs36B2N71e2kADIl3SDQklRtlnPDLZCfFH90vPwD+PrijDzNTgCFC
An6zjpcBY6QGajEHfhPRN6pA7UE0qg0=
=fAtY
-----END PGP SIGNATURE-----

--r21yYdXOyTd1lJah--
