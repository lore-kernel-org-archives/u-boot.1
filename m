Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DDCBCCFA03
	for <u-boot@archiver.kernel.org>; Thu,  6 Nov 2025 13:37:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 82B1B83B91;
	Thu,  6 Nov 2025 14:37:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="fyOvk06k";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 792D083B1A; Thu,  6 Nov 2025 14:37:52 +0100 (CET)
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com
 [IPv6:2607:f8b0:4864:20::22c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D924A83B91
 for <u-boot@lists.denx.de>; Thu,  6 Nov 2025 14:37:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22c.google.com with SMTP id
 5614622812f47-44fff8c46bbso264218b6e.1
 for <u-boot@lists.denx.de>; Thu, 06 Nov 2025 05:37:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1762436268; x=1763041068; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=v8Z98dhxfsOYCfCYCtkYXUxFuTU1i6K/5rPOurVx42I=;
 b=fyOvk06ktCCwh+3VYbDEvKsy01UXbRrIWW277p9Wa6jgwN0S8hMPX9wqdKwkdYp6sO
 B1eYTYscaqx1Rkqa0aF6FbQwNXbGGbdr3e2GDnmflsOpDiccLWXzfWlveyhvn33fwNAr
 av2cfQDrFpYpzIorw0YM3HvaiLQNrW7VtGvSI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762436268; x=1763041068;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=v8Z98dhxfsOYCfCYCtkYXUxFuTU1i6K/5rPOurVx42I=;
 b=keD9DFp5ITGsfHgGFJg3BeKBbh1MPmudyBlPJugtkgn7eWnHK06tpyoSB/tAjIohFJ
 AE4Bq8H4fWeGEC19jQsv/orEGGAmq0Q1mAhTRH0E6h+KAu27MKJxH2Yytp0X7ebEtX3A
 ybDNVzMRfTg+wHdhOZB99KWfwrdUfzfKk5i8XhNfxr5gCAOfMe05MRvI7ilxqEBxFFRo
 iuFsJ/fbiSe9Uf9yI/sWccIAjUNYnLwzZ7ZWOP6Oiel/+kdTFhfx1WOoSVqugG3MYhz/
 o1U1NsRc6fVq5bfCrZXgUTFnooyawFzTFnHsdojITxzmoM7REKlhg1QEgEsUZbJhmWQ7
 n0gw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUsBMia33/uG7tLEmhsM3cs6YIyrH+rvo2s4JYe/7XRbVpdNnKBZaNbCwwos/zJTHQJry3lE1g=@lists.denx.de
X-Gm-Message-State: AOJu0YzBWN4qFJG5WqMehNIdd6spbBdmMmM7Lbi3u7K50Av3XyZvHd9S
 l6L2ZTPlIbfrAYIBnwt8yyUbWAt2AfOOv+FXUqYTwew2b7lY0VN+6HOU05nd/hcyS88=
X-Gm-Gg: ASbGnct259A403GsjBUzQ2qR1gJRLXGqYLaHB46Z/vQJwX8zOijdr4tM5Cs5PyeScju
 9xd84kNhjatVqQzoJYYOCGFu9n5WbiSUcebv5uOr/8dPOw2VD6g1NFoQOBsUCrm+y3yloJTaqh0
 7LWTsm4njFaWWSpiqD1A8QffsJI0LQIUz6v72IjoWzAQMsZ8sQi9Rc6drhmz33iGkwrdJX+JjIY
 joN3HVlXGUROBwI4A5TxwUyVBXBjfu0JytGkiBZv/fKfvijyRpq9+LgmB3lu5uPgnOJkSlHb2Ea
 luXMd9PF4+gKu/3Ljjtg1JKRx2VwFbGdhQkOYv59Oxl0CNN1o7tV84s/C2XL54hBJrHqDj/1Km1
 eM2nWzwbuU9hx+ZQypBnewf//tJZzO3L+ZFuaVQrrmcaEvshYQ7ZqOUfZhkV3oAC+FIeQnf6r5U
 VQvqtURGXIBwJTxfIxE6EIIzIZM19LhIcOZL+Ev6mqE8/f6MUZow==
X-Google-Smtp-Source: AGHT+IFHjIKde7xqeSEAjx2tgn5j8qlHKPNiyuXwau3Ban+h4nqby6Jad9PvlbNVDqgqivVRJqqDrg==
X-Received: by 2002:a05:6808:1a1b:b0:44d:aaa7:62bd with SMTP id
 5614622812f47-44fed38960cmr3227031b6e.27.1762436268500; 
 Thu, 06 Nov 2025 05:37:48 -0800 (PST)
Received: from bill-the-cat (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4500253ce65sm805104b6e.5.2025.11.06.05.37.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Nov 2025 05:37:47 -0800 (PST)
Date: Thu, 6 Nov 2025 07:37:45 -0600
From: Tom Rini <trini@konsulko.com>
To: Anshul Dalal <anshuld@ti.com>
Cc: Swamil Jain <s-jain1@ti.com>, devarsht@ti.com, aradhya.bhatia@linux.dev,
 n-jain1@ti.com, tomi.valkeinen@ideasonboard.com, vigneshr@ti.com,
 praneeth@ti.com, h-shenoy@ti.com, u-kumar1@ti.com, n-francis@ti.com,
 u-boot@lists.denx.de
Subject: Re: [PATCH v4 0/2] Refactor tidss_drv and enable early splash on AM625
Message-ID: <20251106133745.GX6688@bill-the-cat>
References: <20251106085842.629521-1-s-jain1@ti.com>
 <DE1M02OMYGCG.UGUVC26WQW5I@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="neXcyaD/BRIpWMuw"
Content-Disposition: inline
In-Reply-To: <DE1M02OMYGCG.UGUVC26WQW5I@ti.com>
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


--neXcyaD/BRIpWMuw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 06, 2025 at 05:56:38PM +0530, Anshul Dalal wrote:
> On Thu Nov 6, 2025 at 2:28 PM IST, Swamil Jain wrote:
> > This series:
> > - Refactors tidss_drv                                                  =
 =20
> > - Adds am62x_a53_splashscreen.config to enable splashscreen at u-boot  =
 =20
> >   SPL
> >
> > Signed-off-by: Swamil Jain <s-jain1@ti.com>
> > ---
>=20
> Tested-by: Anshul Dalal <anshuld@ti.com>
>=20
> I also went ahead and did a sandbox build and the driver seems to build
> fine contrary to what Tom saw[1].
>=20
> Below are the steps I followed, am I missing something here?
>  1. make sandbox_defconfig
>  2. Select CONFIG_VIDEO_TIDSS via menuconfig
>  3. make -j`nproc`
>=20
> [1]: https://lore.kernel.org/u-boot/20251105164114.GQ6688@bill-the-cat/

v4 drops the header in question :)

--=20
Tom

--neXcyaD/BRIpWMuw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaQykoQAKCRAr4qD1Cr/k
CvipAP0TTx5GBZctDlXptkdhXP79NAEcrP47R2KZlYflzEKsGQD/cPXtla8yRouv
lRvDj54Z17Uf8LU9Q4yoo2x20lUC1gU=
=IeZF
-----END PGP SIGNATURE-----

--neXcyaD/BRIpWMuw--
