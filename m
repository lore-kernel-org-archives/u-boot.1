Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 436CAE67810
	for <u-boot@archiver.kernel.org>; Mon, 22 Dec 2025 18:32:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BAC7C83B99;
	Mon, 22 Dec 2025 19:31:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="kl2VIgme";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E934883D1A; Mon, 22 Dec 2025 19:31:57 +0100 (CET)
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com
 [IPv6:2607:f8b0:4864:20::22b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CFE5A83B95
 for <u-boot@lists.denx.de>; Mon, 22 Dec 2025 19:31:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22b.google.com with SMTP id
 5614622812f47-455af5758fdso2868058b6e.1
 for <u-boot@lists.denx.de>; Mon, 22 Dec 2025 10:31:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1766428314; x=1767033114; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=nGaY76/xAUqjGmC5JhDqJYUKYUNKJkcGikaXihNykfs=;
 b=kl2VIgmeM2nUGnkGOWgzn87khBip4esrASOhWES4DkVPeLPPFLbdtFvTcFksmnqTGn
 9eD4Qp7RwdS6KOJTm+3FIB5iUwmsrbtbIHVLcdPnBi8dAaqDrYeklpRKTy4uzkRX1syj
 3Siaaidm+OP6OG/geU3h1l4bo0NKq3jShB+Ek=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766428314; x=1767033114;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nGaY76/xAUqjGmC5JhDqJYUKYUNKJkcGikaXihNykfs=;
 b=rtJagwGEs3R6bQOQg8JGAHcKrK/jXMG41RXAOIjJtkyAft0dRSHBOP65bG+FtIsnKk
 fNPa5SXSOX/BUBMQKvMmTu6g786vGipQvHcu/8kPc2daOcX9TN+x8li43eOU4VdF6dFh
 lSxAGwzLq5GwwH+emqSDBV+9alXYi0+WdooF7Pj0LnLlzj9hXVJ0Wy7zQetwszq8T9o6
 Px7NBtYZL9ZgszSNGu/VeJbefAgTR5gtsCowSaujyU/UFVMjmT/gFoWTFfV/AUv7/o17
 2PcF/VHiCxfnqlg+0bKkdngbVoWTOWoFdWzMJswaNckzZP/1phfExwfESd2o5Oge/pDz
 x9kw==
X-Gm-Message-State: AOJu0YwADWNQoPb0RAYvmE1h6fhO3L9RmFI8HLMTsGFQtinPq6TpF3yQ
 OOlUAqYFfzgXoI9g6nmOuEMOvKzs05Fnahe0XbeVHfVeE5m12f6L8zxpynX7OM82w7tw5LBGWbd
 4XZhObro=
X-Gm-Gg: AY/fxX72PXclofEft/a8nxG5TuU2DS7zVqjs8n5fXSUdE52zK+swLegeubzpU/D3NMa
 Z9o8v2stKoGuUcVZTqMk3B9hhMcsRLUkn0j2eJfDvzryjFwb1lS1rVejqXk10dT3FjhrXd7U3rL
 3jDfReyvRIyW3kJxQoSzbJd17TIRBIRpYBLcwuwVBQWv2Yj0kdOmjqfMITSgOhezur8Urm8mAq4
 Y4rxXuA2cUbBKtvWkrbcu4+tn471D55/2GfZxm2uFZt01XFRRXhrbIvLReZnRddZamC21gpK9Jw
 SrFNEds9n/1hVMBAV7dg6V3Q/dbweYOdMPRt9JVT1xJ/vIpm5TYrzpDtwWI4KI2UzveN10fLAsk
 I8rHlbkhlTpdQDxjhQwkaggwaDfZKWZExZJfzM0RfQyZp9vT+IsDJ93JMYTJAtP0Mxzj7RCur0q
 KqIMAYl14oUN/waGVzw0oVMxU1b7p5UAKnOa3yZOQk52VVmQWhLg==
X-Google-Smtp-Source: AGHT+IEtly0tZGcDLUp1c91iRoQnQXgtJmamI2opRBSxYuAHc9S+V/1UNOGVRjIxx5yK4uK9fu9k+Q==
X-Received: by 2002:a05:6820:168b:b0:65d:a79:5691 with SMTP id
 006d021491bc7-65d0ea9da51mr5174152eaf.36.1766428314561; 
 Mon, 22 Dec 2025 10:31:54 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-65d0f3fb710sm7133804eaf.2.2025.12.22.10.31.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Dec 2025 10:31:53 -0800 (PST)
Date: Mon, 22 Dec 2025 12:31:51 -0600
From: Tom Rini <trini@konsulko.com>
To: Brian Sune <briansune@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH v1] Replace TARGET namespace and cleanup properly
Message-ID: <20251222183151.GC847766@bill-the-cat>
References: <20251222170521.147815-1-briansune@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="9rn2k56WBTaCQFbg"
Content-Disposition: inline
In-Reply-To: <20251222170521.147815-1-briansune@gmail.com>
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


--9rn2k56WBTaCQFbg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 23, 2025 at 01:05:21AM +0800, Brian Sune wrote:

> TARGET namespace is for machines / boards / what-have-you that
>  building U-Boot for. Simply replace from TARGET to ARCH
> make things more clear and proper for GEN5 SoCFPGA
> where GEN5 is referring to both Cyclone5 and Arria5.
>=20
> Signed-off-by: Brian Sune <briansune@gmail.com>

This might be something to work out with the rest of the Altera people.
Looking at the start of arch/arm/mach-socfpga/Kconfig, there's a lot of
examples of things following the anti-pattern of using the TARGET
namespace for what seem to be architectural symbols. These should be
converted (and in some cases possibly collapsed) one at a time.

--=20
Tom

--9rn2k56WBTaCQFbg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaUmOlAAKCRAr4qD1Cr/k
Cg2hAQDhzIgBay2ThlovsJR4RVvzRrFIlGNm7eUY9vqShsOqxwD/RqY5W3yzGLSi
hiOcvXaK9u6Bvw7t0QKtFdQ0v6Mv1g8=
=uhw4
-----END PGP SIGNATURE-----

--9rn2k56WBTaCQFbg--
