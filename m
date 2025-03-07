Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 360F9C19F32
	for <u-boot@archiver.kernel.org>; Fri,  7 Mar 2025 15:51:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AF66281298;
	Fri,  7 Mar 2025 16:51:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="JTsDMLzC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C90CF812C8; Fri,  7 Mar 2025 16:51:02 +0100 (CET)
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com
 [IPv6:2607:f8b0:4864:20::b30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BE93D8122F
 for <u-boot@lists.denx.de>; Fri,  7 Mar 2025 16:50:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb30.google.com with SMTP id
 3f1490d57ef6-e589c258663so1772625276.1
 for <u-boot@lists.denx.de>; Fri, 07 Mar 2025 07:50:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1741362658; x=1741967458; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=rwEodUuwWy7DEctJy9LOnzkVVORFxAdFfek9V2J+zuQ=;
 b=JTsDMLzCO5/lajV8c6yZvLBNkMAE+08yiKEuOtjx0RLUvJSrbwzakJqiRL+LvPuxXi
 nF461GMcxDgUq//bwZ+chqhLIxxguiAWbJqukYpsFrU0hOqhYmZ+LWCsOF/QZ5HhOvLo
 /lKToyaFMOIjyHo/weZ3ImPMa/0FmpbzwXzS4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741362658; x=1741967458;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rwEodUuwWy7DEctJy9LOnzkVVORFxAdFfek9V2J+zuQ=;
 b=aSvO3D2+K9OTQecAk1iQpxjMG5wX0Yu8s8tdeoWtHE/r6OY2zN2YEzym9U4Nq/VMP7
 HhBXc9LwIG9C4A8vSr1DBypky/mugT+7ybiYbzNi3XErxnQ0KIt+9b+dVbf+4z05xArB
 hlknnCLc90RK2hbnPT2PgdH/7j1EJAm8r5F4x4XRo271wtxyNuTBZisHSCHVtLEk2QQo
 bpioIna8CMyccVzjc/1wB24/uTMfsO9+JUrZhZtxvlxCJmOWRkk/YZnJR4v4H/tB0EH9
 VDjr8x1odhwryyC/yuAOlAds0YkwA3XtS6A6/mt1d+wTLwhfeh/mSx/1UOw+uzHwQ2gm
 vJyg==
X-Gm-Message-State: AOJu0YzA0DyAsSXqYJIr7q6zxpU2MAuXTuyZaiziVVrA7aBhWPeRqBto
 ckVru3BUMP6RbV5HXGgB2Q5YTB08OVf/Zh6/UOavwls57m7AvsgcMLR+dPNOUlc=
X-Gm-Gg: ASbGncudMERTYKkbMX7NXyGqVKMZxYF419T1uPk1Uxa5weKd6ylXHUtBb8AhxmA5h2U
 lsms3966ZP8wWvc97f4vRCfa/vtwPWB0oqEIFQGvdRkNtKsWjl3Bg1kQMfesgm4PZBneaQG/HAU
 F4j/yiGEveZ762g+AdjCsYwvIABP+BbODEMIbi9bbvICmT3VPFczuIWwJv+V3rUpKl/FzlYC1/o
 F3zQ1Hh4p+bxFuio1GumSGV9KOzFFK6CeucFGrXMr9jUSJEzG8YIIXTAtihqLmkfu4wGtc+6oIG
 yoqkrB4Qza8QUzoHXDL1CCbut0tdl7F8eEbZIPERVa00hQ==
X-Google-Smtp-Source: AGHT+IGcY71j5MN2kQtAfC49lv5RXOdtF1KqfRdkb/kQ2tMNVvNon7lwy4HZOZABmE5ZV6hYIjGCig==
X-Received: by 2002:a05:690c:998e:b0:6f9:ac35:4483 with SMTP id
 00721157ae682-6febf3a9308mr52988767b3.25.1741362658591; 
 Fri, 07 Mar 2025 07:50:58 -0800 (PST)
Received: from bill-the-cat ([187.192.142.234])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-6feb2a1c4basm7876847b3.25.2025.03.07.07.50.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Mar 2025 07:50:57 -0800 (PST)
Date: Fri, 7 Mar 2025 09:50:55 -0600
From: Tom Rini <trini@konsulko.com>
To: Anshul Dalal <anshuld@ti.com>
Cc: u-boot@lists.denx.de, vigneshr@ti.com, afd@ti.com, m-chawdhry@ti.com,
 n-francis@ti.com, b-liu@ti.com
Subject: Re: [PATCH 02/10] cmd: Kconfig: enable CMD_BOOTI for ARCH_K3
Message-ID: <20250307155055.GP2640854@bill-the-cat>
References: <20250307075541.2571104-1-anshuld@ti.com>
 <20250307075541.2571104-3-anshuld@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="G5YApX3JzoDcilPg"
Content-Disposition: inline
In-Reply-To: <20250307075541.2571104-3-anshuld@ti.com>
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


--G5YApX3JzoDcilPg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 07, 2025 at 01:25:30PM +0530, Anshul Dalal wrote:

> This allows us to load the kernel image to memory on 32-bit R5 SPL.
>=20
> Signed-off-by: Anshul Dalal <anshuld@ti.com>
> ---
>  cmd/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/cmd/Kconfig b/cmd/Kconfig
> index a04fcaa0e08..66145a001b8 100644
> --- a/cmd/Kconfig
> +++ b/cmd/Kconfig
> @@ -357,7 +357,7 @@ config CMD_BOOTZ
> =20
>  config CMD_BOOTI
>  	bool "booti"
> -	depends on ARM64 || RISCV || SANDBOX
> +	depends on ARM64 || RISCV || SANDBOX || ARCH_K3

How are you using "booti" on the R5 part of K3? This shouldn't be
useful...

--=20
Tom

--G5YApX3JzoDcilPg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmfLFdcACgkQFHw5/5Y0
tyyl0wv/Te8Uwo+/jDRWEbc3uXBgyxWMd7E6XvV3io3Dnvh01ptYCyB1+/S0M/wl
bZb8b0/NsnFp73CukGCA90wZ/r+R/S/A5+D9fSTnSE/IpW3lmjvH6ut7xoew6tbE
bg/QVXqOlXDeE6XAYom+UUdiAceo6ruKXkHePnIivCb87WIFshWdS4Pz2+yXowWp
G4C9iSM8T4KN9DtEsQj9TPfLpDeiezx/xX/T4lQ7iXgwiMW6vrQ2h5h2eLXfqVg9
t3zwnpSQC4bx/RTMe9EwSxQe06u4hzl1QyeTaBaE5K7nDolWnrLsENToqJvZxDNF
8g68rw0tXdCV3u7n/gpnYtmdy9SMsG+Usq2+4S4aQKpHJe37maGC2iHdCNr2uRC7
kPNiXNDukdUaqDvlT9qkYgpNQcuBWhrm78DTQv4qkHZ8BRDIU02CjJe9jta5oVGK
h4y4fyBYnEHPwke7wu4u89jm6xbdP8ypEgYMNRirelCeIeE/ueRK1ZbSGRfv3eYt
HdUJHHja
=bEKC
-----END PGP SIGNATURE-----

--G5YApX3JzoDcilPg--
