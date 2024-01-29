Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DB16C47DDB
	for <u-boot@archiver.kernel.org>; Mon, 29 Jan 2024 17:56:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7C3EA87DBE;
	Mon, 29 Jan 2024 18:55:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="gCr97DVc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0C84487DBE; Mon, 29 Jan 2024 18:55:34 +0100 (CET)
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com
 [IPv6:2607:f8b0:4864:20::1132])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 033F787D78
 for <u-boot@lists.denx.de>; Mon, 29 Jan 2024 18:55:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1132.google.com with SMTP id
 00721157ae682-5ffa694d8e5so36213727b3.0
 for <u-boot@lists.denx.de>; Mon, 29 Jan 2024 09:55:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1706550930; x=1707155730; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=ivL6miOigIDrq1rQs9KEyV9/0eBL4qKNRgRUrpcCT7Y=;
 b=gCr97DVcM2b0wwjaP+cIfEfRQKhomeeDlSSx2Vhrg7iA/ewg0wXuyJNd5YY/NlQ1f3
 i5jzBbD5OvhKwCr1vFJWYTV6W5yFfw0KgRSloH4/k+I0tJuzFH6jQsXovtPjh5FQ/Lx5
 oacGCNRIi51U/ZWXgFV9M0LESUefbx6sma490=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706550930; x=1707155730;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ivL6miOigIDrq1rQs9KEyV9/0eBL4qKNRgRUrpcCT7Y=;
 b=m05ISwQC0HqRVRp8ZiiMGQ0KA3MPQfXsvtg+SJJLpiRzSsaJ5VZEKhP7cgd2OKAfec
 d3bEuQLOtzE+9XPmZpeNl88vuAkKTMuXkCuZOx/+xuBmkGYSB8m3WTx5gzCWNJgHma38
 fJXJp2g8UZ+Ryxgq5UakEUe+4xH2Hvk9bovGfRzSQayf2UWxbx2FOedgmVrgPGJPb+CI
 sFdLfC3ohJGLaepYU90vsW8LAiD2Do1BCbco65lKDywyS3F/9bCGFjv83EMqBnssFyS6
 koLVzD0SoDBjh9ATo6GM8qiH2p+0RV5EXtGOn6x+0alIBuygD6pGADQVF4DQGDLuue/e
 5ZXw==
X-Gm-Message-State: AOJu0YyaA5Lwc3fE2Htu7cSI6xaFPanuQOXmU75y/XnG/uQIKJN84r8h
 nkbHaY67nohqJrP/5wa1/9WlsRXxyf2muwDPjiKB0FCbeogergs4xGboXMsRpgHiMlxBcHnXPx3
 H
X-Google-Smtp-Source: AGHT+IEBS1qTLBVlYvjm0A2+IU+Iba5g3GlJ70LJX5UzP3LxZRbIJANIZ6d5rjv5JWnU5VEI9QW7tw==
X-Received: by 2002:a81:4910:0:b0:5ff:7ecc:751c with SMTP id
 w16-20020a814910000000b005ff7ecc751cmr3306221ywa.4.1706550930739; 
 Mon, 29 Jan 2024 09:55:30 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-3119-0000-0000-0000-1001.res6.spectrum.com.
 [2603:6081:7b00:3119::1001]) by smtp.gmail.com with ESMTPSA id
 v205-20020a8148d6000000b005ff99f7e10esm2618305ywa.138.2024.01.29.09.55.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jan 2024 09:55:30 -0800 (PST)
Date: Mon, 29 Jan 2024 12:55:28 -0500
From: Tom Rini <trini@konsulko.com>
To: Love Kumar <love.kumar@amd.com>
Cc: u-boot@lists.denx.de, michal.simek@amd.com, git@xilinx.com
Subject: Re: [PATCH] test/py: secure: Add secure tests for Zynq & ZynqMP
Message-ID: <20240129175528.GI1152441@bill-the-cat>
References: <6e28de8a3ea437ff04cacb2cb389cec44bb033e3.1705655604.git.love.kumar@amd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Uy1/pRP9Yrir572R"
Content-Disposition: inline
In-Reply-To: <6e28de8a3ea437ff04cacb2cb389cec44bb033e3.1705655604.git.love.kumar@amd.com>
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


--Uy1/pRP9Yrir572R
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 19, 2024 at 03:31:29PM +0530, Love Kumar wrote:

> Add test cases to verify the different type of secure boot images loaded
> at DDR location for AMD's ZynqMP SoC. It also adds tests authentication
> and decryption functionality using AES and RSA features for Zynq.
>=20
> Signed-off-by: Love Kumar <love.kumar@amd.com>

Applied to u-boot/master, thanks!

--=20
Tom

--Uy1/pRP9Yrir572R
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmW35pAACgkQFHw5/5Y0
tyxxUAwAusj/4E6BiOis3pg8/o0GZ/V2NT/j2ut5cifpW7zG+UrXL0pmFMPRj8yV
DYd7W9XYCI4behgwKfhVc+QFo8DpyAVxcd4NbecsN45cEr6qS2IZvyuerjpNGq5p
u3PaNufhhWDd5pz42FHaGDXtnzbbyZFA1V+XjRAfMJTsAWdQaCjkb8TlroKxw2/6
kfE3aumUdmgV6zEYR9nGFpCiXVg3zCcVZOdL/LQg9uMEdAcjXfPqGvGO9VKLHggj
8uCI508x1mkFw/qUFOHG211gKo+P7ArYnftI92EuYc6QFuWQ0RQnBRdC3pR915th
PMPiQ5V3z7TVnGbO+citEWHTBKWGVLoa3qU+RDNq9/Z8Twq1ELI7Yq14spDRhPn4
vTMzyq0PxQVgeEJZ2EmdjEQpof++7sgWmuLzkya1Njls0K1146jnNo0LIZlZ577J
/Bw4F1vcZMPKKEvmgLPXwoX5UFmnjU+ebQX3LMRMyVaJ1Y38gMZ2ukLhiiRB1x2I
CT8uEc9c
=c0kr
-----END PGP SIGNATURE-----

--Uy1/pRP9Yrir572R--
