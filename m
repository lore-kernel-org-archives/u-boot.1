Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D685C4332F
	for <u-boot@archiver.kernel.org>; Mon, 30 Oct 2023 21:36:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4E0FB87AB1;
	Mon, 30 Oct 2023 22:36:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="bGdMvhtO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5E52F87AB1; Mon, 30 Oct 2023 22:36:11 +0100 (CET)
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com
 [IPv6:2607:f8b0:4864:20::236])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 47EAB879FD
 for <u-boot@lists.denx.de>; Mon, 30 Oct 2023 22:36:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x236.google.com with SMTP id
 5614622812f47-3b2ec5ee2e4so3076196b6e.3
 for <u-boot@lists.denx.de>; Mon, 30 Oct 2023 14:36:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1698701768; x=1699306568; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=VRuDzrFAOp6MUTEPukCQWgOEHHbtsWL1Eyrt4PL96mM=;
 b=bGdMvhtOlo1k6czTq0QDUZg7dyoTTjicpQc6zVvGNTO9UrwBe9QpqdPaBQjSEtqf/q
 IlkqP/vQ1kiY/FSxBsB6JwAxQaVguxP1lBIDVW9ZP+l/rR/06JOo3SXdVIAKNqFejt3M
 cawGBMzOMrYkwS5Ux2PKy0RavcY0W0ulUk6sc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698701768; x=1699306568;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VRuDzrFAOp6MUTEPukCQWgOEHHbtsWL1Eyrt4PL96mM=;
 b=wHMB45SQbriykDmBHNvd1yTIJFO0Eq/pfsQE/JklF4T1K0iTNH/bhscfdZ2x6eWrPw
 P9esycaldqwCncHarmYqfBGw/zR8atoK51SLq9RXkAgFYGGZAaVDQdwXyWPxKSiS2VzU
 +lPX6SpRlqzTSfsMVKMxPeHYzY75jp8ZAcPmpc2Z6ptkp9fQF2N9T/M+1uws8i9CZaNJ
 lPiUzx2OoZLDG4fTYeY98s05gUlkzKwX2hRCUPOvfVL5U1DOyoRsX/BR2zWHifjyjpUD
 tUHB533M3I5ZhKaorxlRUrilESqYzhaABfnq8KnM3mg4eAlMeUb7PercEnBc6DZYSR5l
 rP2A==
X-Gm-Message-State: AOJu0Yx/3Vi5jyA5R/50LX3RBREbqC+OfsmgPanBMSrJOzRJfFh+ctqt
 cMay0FJIDsVYNbsJRBfgg4mOp8l8tnAI9bQq1VTFzQ==
X-Google-Smtp-Source: AGHT+IHpPUa+ySi0KDG6Py8QYcuzNFaImPd2FtzmEVuAMgTuPjU1gH4BBlxsvFKr2r2s3Jsr4xV1bA==
X-Received: by 2002:a05:6358:2809:b0:169:845b:341e with SMTP id
 k9-20020a056358280900b00169845b341emr810634rwb.24.1698701767883; 
 Mon, 30 Oct 2023 14:36:07 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-0000-0000-0000-013d.res6.spectrum.com.
 [2603:6081:7b00:6400::13d]) by smtp.gmail.com with ESMTPSA id
 p13-20020ae9f30d000000b0077893a5a80esm3684719qkg.123.2023.10.30.14.36.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Oct 2023 14:36:07 -0700 (PDT)
Date: Mon, 30 Oct 2023 17:36:05 -0400
From: Tom Rini <trini@konsulko.com>
To: Michel Alex <Alex.Michel@wiedemann-group.com>
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: Re: [PATCH v4] misc: i2c_eeprom: consider pagesize when writing to
 eeprom
Message-ID: <20231030213605.GE496310@bill-the-cat>
References: <AS1P250MB0608EFCD6443148D5D9837C6A9F8A@AS1P250MB0608.EURP250.PROD.OUTLOOK.COM>
 <20231024231543.GN496310@bill-the-cat>
 <AS1P250MB06088A3DFC19C7673DB0F551A9DEA@AS1P250MB0608.EURP250.PROD.OUTLOOK.COM>
 <20231025135544.GN496310@bill-the-cat>
 <AS1P250MB06084AA86F3BB452127D951FA9DDA@AS1P250MB0608.EURP250.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="4bIyopHAW85KLJC0"
Content-Disposition: inline
In-Reply-To: <AS1P250MB06084AA86F3BB452127D951FA9DDA@AS1P250MB0608.EURP250.PROD.OUTLOOK.COM>
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


--4bIyopHAW85KLJC0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 26, 2023 at 05:47:41AM +0000, Michel Alex wrote:

> Calculate the maximum length of the buffer when writing
> across the page boundary. If the buffer length (len)
> exceeds the page boundary (pagesize), split it. Use this
> length instead of comparing the length with the pagesize,
> because if the write start address (offset) is not at the
> beginning of a page and the page_offset + len is greater
> than the page boundary (pagesize), the write operation
> would overflow the current page and the behaviour can be
> undefined (e.g. at24).
>=20
> Signed-off-by: Alex Michel <alex.michel@wiedemann-group.com>

Applied to u-boot/master, thanks!

--=20
Tom

--4bIyopHAW85KLJC0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmVAIcUACgkQFHw5/5Y0
tyx6TQwAs7L67dhlw8v1v9RgK0M6R0Zock7TBLvX1RHpqf+8Mb/RObhC/2tE4lCP
MJ2XTE0PI87dfwgCFMZxkWfGO5sa/+N5B9o4D0z8SDFtpHD6FiGjhPjcCWugegyS
ZIn2loFzh08dItD4GkaK2jFNglhSVUuDcLWwl6BQtnhztLPJgmXIyvvTfoiazdK0
afK87O7BF/CbLkfXiLKTVxVSE0kLRaFbYDXZQT8eyAWvnpbw2flUCupB8VtkUI6E
w8p2MRnDdOCHzFV2u4TbDrRKp8NQdS4VKoF7wCeAD0Zznaz4eBnqf/34K9Bvdg2T
cNjCyk9cpZiaJVVzrXGn7Fqud+bwkC/IHdN0mxXp7mXysyOBw5kkifbE9D8CbOCd
QZMI2ha18WxWPV1rXsFVGzsFZVvzC5PZDoPBK2I+LhGyRrTpvtyIi7CZ7cFIkGPV
g/y3amX2BbFCkuWKCLJ7/t2xEjwkn8AcmaZKfUDsHJO/2BLUPK51vEOQeB1t1yti
vZ+2In8M
=ykcd
-----END PGP SIGNATURE-----

--4bIyopHAW85KLJC0--
