Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA74FC2BA18
	for <u-boot@archiver.kernel.org>; Tue, 18 Jun 2024 14:32:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 038E38824C;
	Tue, 18 Jun 2024 16:32:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="B5bmenoj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 53D70882EF; Tue, 18 Jun 2024 16:32:06 +0200 (CEST)
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com
 [IPv6:2001:4860:4864:20::2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B001388137
 for <u-boot@lists.denx.de>; Tue, 18 Jun 2024 16:32:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2f.google.com with SMTP id
 586e51a60fabf-2598abc6848so138843fac.0
 for <u-boot@lists.denx.de>; Tue, 18 Jun 2024 07:32:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1718721122; x=1719325922; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Cms3ybtpS1tCQ+sMuyq81GwQjMwG8pkN7ID5w9CIe5s=;
 b=B5bmenojlWCCfpwu56sK7lAXZZHGg3YRUJjLLOrsUF8fr/zbLjjaAq7PGIftqqW5AQ
 NrGKdlXapnAbccvE3fd+PN+tmTvBp/ULv5RtlvvmgjlMLhL5MwZrGO2oecH7QqE2yqa8
 IpLI2H+Shcvjbdj/Ym8moZqzyQ9n/Pjn7vZB0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718721122; x=1719325922;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Cms3ybtpS1tCQ+sMuyq81GwQjMwG8pkN7ID5w9CIe5s=;
 b=HnGc91l73r4o/uIzDeTFLxfLFuNmyANrUhzbyna09vP8OR234UprzoiOfDHZx0J8IE
 se72T9ZqZSQMrvlZVmxb3yX9EC9IuZkm0xGVUEmz2ur2/X+5Pxxamt4C7RUlHNRBXRxE
 Q2Hu0SABQJ+w21VTeAH8hbNEaLyYj3gYanH8FfdINWB3snXSvAyOtOF7A0tfRjcamtp9
 N1PDnc+M8eakSRTxjFCQvd5K0qBczYiMA27zu3Zn5e89EqmL60J1wpr/8D7RkiqpaIK6
 koDhIsppaYhQu3x2hyqZtEuuyyl17/1JWI8uepRMpm9c1n5IUUSlJTVVRRKbdQzZDzwY
 yZuw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVrOMX2B9hfiltePl54Iio+paHzl+WnrQf8/j3xE5JNnYY+rspdnC8QZPlapsoMCXBLiXThGXFCK6dPAkWp9ywwcMgJLA==
X-Gm-Message-State: AOJu0Yy8+bY4GRtsn7VPMxNtnfc/d2FhhkA1dP22MmKEzstBUJfv7oE0
 8/UplgY63cZyOIGkqtmZNtT6dpmKIjjhODFC5JDaBP0iK50vi+brbJMdWzKBjLA=
X-Google-Smtp-Source: AGHT+IGWC3qvxK/7rqC8SeCxn8owYwFO+Kv0ycCKLTMxQP6MGKyxne+BMQho+lhyC9diFCWsYqFM9A==
X-Received: by 2002:a05:6870:248a:b0:254:b781:2f5e with SMTP id
 586e51a60fabf-25972de7257mr1202028fac.17.1718721122459; 
 Tue, 18 Jun 2024 07:32:02 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-205-45.totalplay.net.
 [187.190.205.45]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2567aa79827sm3225571fac.32.2024.06.18.07.32.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Jun 2024 07:32:02 -0700 (PDT)
Date: Tue, 18 Jun 2024 08:31:59 -0600
From: Tom Rini <trini@konsulko.com>
To: Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc: Stefan Roese <sr@denx.de>, u-boot@lists.denx.de,
 Simon Glass <sjg@chromium.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Aaron Williams <awilliams@marvell.com>
Subject: Re: [PATCH 12/20] cyclic: Rise default CYCLIC_MAX_CPU_TIME_US to 5000
Message-ID: <20240618143159.GR68077@bill-the-cat>
References: <20240611-docker-image-v1-0-51472eb70357@flygoat.com>
 <20240611-docker-image-v1-12-51472eb70357@flygoat.com>
 <20240612160053.GS68077@bill-the-cat>
 <49522625-8663-4102-82aa-cabc0f239afa@app.fastmail.com>
 <20240612165048.GD68077@bill-the-cat>
 <e94995af-f9dd-4262-8dfb-2c47ab817e61@denx.de>
 <20240617232904.GL68077@bill-the-cat>
 <c50b3dc0-0385-4548-80ed-ffdc8623bfcc@app.fastmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="f4ban3DPoJD81NQU"
Content-Disposition: inline
In-Reply-To: <c50b3dc0-0385-4548-80ed-ffdc8623bfcc@app.fastmail.com>
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


--f4ban3DPoJD81NQU
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 18, 2024 at 03:00:50PM +0100, Jiaxun Yang wrote:
>=20
>=20
> =E5=9C=A82024=E5=B9=B46=E6=9C=8818=E6=97=A5=E5=85=AD=E6=9C=88 =E4=B8=8A=
=E5=8D=8812:29=EF=BC=8CTom Rini=E5=86=99=E9=81=93=EF=BC=9A
> [...]
> >> Acked-by: Stefan Roese <sr@denx.de>
> >
> > Can we please get either this, or
> > https://patchwork.ozlabs.org/project/uboot/patch/20240524210817.1953298=
-1-rasmus.villemoes@prevas.dk/
> > merged for master? The number of false negatives in CI due to this is
> > big issue for getting more contributors to use CI. Thanks.
>=20
> It seems like CYCLIC doesn't have it's own custodian tree.
> How are we going to handle it in this case?

Note that in U-Boot it's less important to have a tree per sub-section
and more important that custodians have a tree (and then use appropriate
tags when sending pull requests).

--=20
Tom

--f4ban3DPoJD81NQU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmZxml8ACgkQFHw5/5Y0
tyzzqQv/W8HqBS04JwPTKLU/UQZr86oA6McwcJCuJn/gg5fklDenWIHG2BSt3GLK
13atmGfou/ShFOz1blPuJLypgo5GcaH8Ii5jeMnFTGWMjaqiZfxU6QLxuKXrllAa
BkA7lFSmX7D7DI/BIWYsJy7prqi34FhzXyFFhQYvRWPeVCx957MzJK8R8K8I7BX3
l8raYD8IZgK0U+6gkWlkk8F/aFQn3O6FD+6Rk8fHu/fShi0HQ5oV/vHRTm1Xp/EA
mGD3wAP4NclF/xyhIZC5iKCGNtP1UAaDlEmC6sQD/nEbW9GuGGEogDx5eZ4J8nUl
0s1plvryw1VP87YKtj7ABsUjyadL0bxBEY7K4YV9//YrOH4G9Gl0nbnwFBw1VBA2
pF8upZY0mzCFcGMQnXi7BvgveuwmXSNe1Act+MPgoC6v1nSSNS6C7bPjXXxPobjG
7Zad8DbsdIdrDJZGw51r7/EzKoZlhLEkezKaXbuX62n3ZxTihIlOYwq+09SB+7Sy
sWo3jJYv
=ySwP
-----END PGP SIGNATURE-----

--f4ban3DPoJD81NQU--
