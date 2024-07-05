Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C14A0C38150
	for <u-boot@archiver.kernel.org>; Fri,  5 Jul 2024 22:40:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4EF4C88254;
	Sat,  6 Jul 2024 00:40:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="qJAlX4Sj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3385A88254; Sat,  6 Jul 2024 00:40:28 +0200 (CEST)
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com
 [IPv6:2607:f8b0:4864:20::230])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E0FEE889FF
 for <u-boot@lists.denx.de>; Sat,  6 Jul 2024 00:40:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x230.google.com with SMTP id
 5614622812f47-3d9229486efso318405b6e.3
 for <u-boot@lists.denx.de>; Fri, 05 Jul 2024 15:40:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1720219225; x=1720824025; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=IsYX2Bnumb88dOeeB3PHJnodVVXWi2qJP4PnQFXdDc8=;
 b=qJAlX4Sj1NUo8vvrrMpzY4f1lCVag39mw405yENTfiVuLzh8YLPGeZ6iA3Oc8Wqf9I
 9m3zxiux4cnJgutvTQo0l0veanvyPi8WQbLBSFwD9cnSWYfz391ZXe5HE0QGKlP/bHpG
 +qnN7Xx3Ol0PnEaWKgAgXSgkc1dhi4xQ1UGrg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720219225; x=1720824025;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IsYX2Bnumb88dOeeB3PHJnodVVXWi2qJP4PnQFXdDc8=;
 b=FuLyIPuN+2p1A9QCjWAghKPJyi+6la8w+LBsOuCJ2Jr/vJasisqZ5xJLDxijQyrsj2
 wmGlgPAc3+m6R2uVJVfV7L4FBb3T4SL2oaAk7zTFBKg1WYEa80dP/s6WjALGA0um8aww
 T3qPTnKosngSi8ltMMI6ce+NP2q8RyetLC8me8FK8Odtjwe6UewnJpj4fNiuOpgLJbfV
 baS/2h1gEYDtqjLiKyXnlVeIgQ+ncEh2NpHPGKUSv3Vu0MPGwmhXCGPeIo2MffK3EuTm
 NvCcYcPUevz9Mz0ngCZqbBT7rPh0Axd8JBDnYcy7GGicTglQLngsR/A60BjW6ydaq+Xb
 vYhA==
X-Gm-Message-State: AOJu0YwQS/hC01OTsY1uXWz9xZCRZWDrtuu7hj9xxA7x0UE/D+Mz2lu3
 d35JDPPcTIduGNJ9ZkN7TzM2x6jvHuZY6hjbZEmT0FgQdVfnvnH+G8q7l9u8GWUtFmixqqScfVZ
 V71lkfg==
X-Google-Smtp-Source: AGHT+IHHox0SaOHo3JIstEqOEFjUWnPtLOnUtZOYtyaZhv1aHcKQjh2e5L6PcBt56Lg21SB1Yatwiw==
X-Received: by 2002:a05:6808:1b24:b0:3d8:a93a:33e3 with SMTP id
 5614622812f47-3d914c8e06bmr7777495b6e.25.1720219224688; 
 Fri, 05 Jul 2024 15:40:24 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-45.totalplay.net.
 [189.203.97.45]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-3d62fa3984esm2857766b6e.44.2024.07.05.15.40.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Jul 2024 15:40:24 -0700 (PDT)
Date: Fri, 5 Jul 2024 16:40:22 -0600
From: Tom Rini <trini@konsulko.com>
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH] watchdog: mpc8xxx: Fix timer value
Message-ID: <20240705224022.GY38804@bill-the-cat>
References: <31a49f86032687601e617da89f831a162303f283.1719476762.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="R+W2EQQaUvSZcLqT"
Content-Disposition: inline
In-Reply-To: <31a49f86032687601e617da89f831a162303f283.1719476762.git.christophe.leroy@csgroup.eu>
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


--R+W2EQQaUvSZcLqT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 27, 2024 at 10:26:08AM +0200, Christophe Leroy wrote:

> Timer value is a 16 bits calculated from the wanted timeout and the
> system clock. On powerpc/8xx, a timeout of 2s gives a value which
> is over U16_MAX so U16_MAX shall be used. But the calculation is
> casted to u16 so at the end the result is 63770 instead of 128906.
>=20
> So the timer gets loaded with 63770 instead of 65535. It is not
> a big difference in that case, but lets make the code correct and
> cast to u32 instead of u16.
>=20
> Fixes: 26e8ebcd7cb7 ("watchdog: mpc8xxx: Make it generic")
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>

Applied to u-boot/master, thanks!

--=20
Tom

--R+W2EQQaUvSZcLqT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmaIdlYACgkQFHw5/5Y0
tyyW/Qv/SUgscws5vMzQvZE5wo+Dg7tvJWnkNnfPHJYFs5zHplUymUHDBX70wjmJ
Uwj/fjJGzZ4Zm66AnCAzhkgzpNznKXnaif9QPQquvbpseyCJSoMgjwWNnSG7+EoU
3MgMwKxK6WIMonvEwPbMjpRxeFWlHIHD4DJbTHcI59NN4oxkF5MqMw1JmdhBCm/m
ncp+nCjfc9IsX7jVJ9dSaTJ4oRw1OuDGCjV8zxBC8kRf5Y55oS4XoS39TrHp4pSR
9KQNePXPvIjfSymvJ9NOkAbGehL44iegV7oXwkNQOgnAcukTRXAZpZRa8dun9WEn
7gSiN+BQrlz7rONSMgExcb5ik+Q8YLi4+VSXmodGGFgiJK6yCFO8XY/i6LPeqGta
mFNRP2OTUEHbncM4lFt4VyOmbc6VOU12+x98V3rySymQvwOdlI0EU7fR/bpmYo0V
6Zp3A+Ju1KEKcaZoAI0am2or4pD4ifTdrC52yZKj+mgzIvvRVAJmQ5MDHNqBAKEN
RNnG5/8Z
=hBkB
-----END PGP SIGNATURE-----

--R+W2EQQaUvSZcLqT--
