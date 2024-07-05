Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1ED60C3271E
	for <u-boot@archiver.kernel.org>; Fri,  5 Jul 2024 22:40:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6B13E889DB;
	Sat,  6 Jul 2024 00:40:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="XzayPCMO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 952F788636; Sat,  6 Jul 2024 00:40:06 +0200 (CEST)
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com
 [IPv6:2607:f8b0:4864:20::236])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9A0A7889DC
 for <u-boot@lists.denx.de>; Sat,  6 Jul 2024 00:40:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x236.google.com with SMTP id
 5614622812f47-3d561d685e7so1342393b6e.1
 for <u-boot@lists.denx.de>; Fri, 05 Jul 2024 15:40:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1720219202; x=1720824002; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Xvxf/KMKzqdGi+Fccj8uYadGUcGgzYkelg7tX70FTMM=;
 b=XzayPCMOdsWXAzPW1qN7w6botKTwp1ijOd2PAbYl5tzl/gnQ95zV6+XATJPuuGMSV4
 PlDN3g3SEw2PAB+CwNinvW8504sn9xLnFAAoVAex2B88rKzcGqMdP9BdC9Soybh2PSGC
 1O6TanplZPJ8+XrtdtuF34JTPz4BvxDvb71DQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720219202; x=1720824002;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Xvxf/KMKzqdGi+Fccj8uYadGUcGgzYkelg7tX70FTMM=;
 b=lAZ54YjJctzeheyHmI6cH0wJPDN8yNTWqhBvFLQhipP3RTAB9sQev+R7Qwbcibq0gw
 CGlWcy2yRz1lP4FO9TNb5B6xuHAiIJWdwFCJfvzCvCMQ3AUXempykLg4XM7pNWlRrOhv
 aBXBOAMPZ22Hk36C962UU520IlamyjkaJxVhwzBgqjHWaUZesAVWi5xvmzSPpPErhTnL
 yyMeBJt5vnx5rmN3V9xsq4HZwNEANB4gZGQYk1P//R0lH1T39cqZOU904YBXOTaYb/PG
 ruLOYuFv68BZl3EKtYKEWbFFeb2PYJz/2wyw7KCco0G4jHF/SSvlHEyyT5B/F/W6KMoT
 DegQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX9ybz3I3BzlRq+W52RM22R6XF2+yUlchLPtf555gZDo+XxG6H59VLFKHwQpcfj9Ep0OgbLxbS7GLluHfxhLaN2cVH/BA==
X-Gm-Message-State: AOJu0YyOvJZKIcdTZXhxPpLs82FzkO9ZlJtn8Hp2CIoXDoppjI4B6xPC
 1U/QyoL2R8NGp+LN3Msrv7SpJNH8jxXplrIVMznXBU3v4+dT5rLmv23RE/mpYJy2DsOGifADiRQ
 BG94z6A==
X-Google-Smtp-Source: AGHT+IHFUFvvCj1bey+lAsASHBZYwsZj/7XEzv0TtQ0Vm2sGzXFpA6c77+UKMmW4Da2EOFd0VLo9mg==
X-Received: by 2002:a05:6808:2386:b0:3d2:cba0:f902 with SMTP id
 5614622812f47-3d914c813d2mr8333880b6e.25.1720219201862; 
 Fri, 05 Jul 2024 15:40:01 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-45.totalplay.net.
 [189.203.97.45]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-3d62f9c7c51sm2850097b6e.18.2024.07.05.15.40.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Jul 2024 15:40:01 -0700 (PDT)
Date: Fri, 5 Jul 2024 16:39:59 -0600
From: Tom Rini <trini@konsulko.com>
To: Roger Quadros <rogerq@kernel.org>
Cc: Vignesh Raghavendra <vigneshr@ti.com>, srk@ti.com, praneeth@ti.com,
 u-boot@lists.denx.de
Subject: Re: [PATCH] configs: am64x_evm_a53_defconfig: Enable I2C GPIO drivers
Message-ID: <20240705223959.GV38804@bill-the-cat>
References: <20240623-for-2023-10-am64-nand-v1-1-018c591daedd@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="2JRssj4BHKPWZtIe"
Content-Disposition: inline
In-Reply-To: <20240623-for-2023-10-am64-nand-v1-1-018c591daedd@kernel.org>
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


--2JRssj4BHKPWZtIe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 23, 2024 at 10:41:19AM +0300, Roger Quadros wrote:

> The board has the TCA9554 I2C GPIO expander chip for expansion
> board presence detection logic.
>=20
> Enable the relevant I2C GPIO drivers.
>=20
> Signed-off-by: Roger Quadros <rogerq@kernel.org>

Applied to u-boot/master, thanks!

--=20
Tom

--2JRssj4BHKPWZtIe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmaIdj8ACgkQFHw5/5Y0
tyyR+gv7BYT0S+YUODhF6HNsgNKYu2wAiDdm22BghWVFW8W6Zos7X4CjhD/c+JYr
FBhulSDuipRxoz1AcEx1vBKZrb1MpGxvGVt9/bi+gv02TBXTOCLdotviIWzKzVb+
gnWWGaqcwMvz0phgSNar6LYd0pXZ9/JR6PHQmIYWjtq5Hm9WZNquBbgz5k/KAFMt
MS0SdHnL8K/G68WO5cny5X0ISYyojJd5u3WBMu2Hua/LNCtlKdvGav0UB8uyWrqr
VaLL/hWuKXrxivYR8Em/n1W5yfIuhuXIbpB0iwB480h9GOI6ctq66wzn9Y/488e6
bjzCq9es392r9HRbZjDrc1WPhkbGlPpw7nJIHWvKlxw70SSHj+ZeOBCi0e4ZOhnx
zXGtVJad8y+W/22VlThkn/1Ks5lD4MdwOyavM2Q0P+mEKtODBuzokRsdzX/8dYB9
LLh5TBSB3ry66lntZgr4JaGa8W5gjS1yGFTY1k2jmPiEr5Wxk8wtdKA6o2OXoNne
d10HZpC5
=c6Qj
-----END PGP SIGNATURE-----

--2JRssj4BHKPWZtIe--
