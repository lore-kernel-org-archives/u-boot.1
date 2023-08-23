Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71281EE49B0
	for <u-boot@archiver.kernel.org>; Wed, 23 Aug 2023 15:03:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9564D8645E;
	Wed, 23 Aug 2023 17:03:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="c4Nzq56j";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 035188645F; Wed, 23 Aug 2023 17:03:04 +0200 (CEST)
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com
 [IPv6:2607:f8b0:4864:20::b33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EDD10863F9
 for <u-boot@lists.denx.de>; Wed, 23 Aug 2023 17:03:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb33.google.com with SMTP id
 3f1490d57ef6-d748d8cf074so5261459276.0
 for <u-boot@lists.denx.de>; Wed, 23 Aug 2023 08:03:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1692802980; x=1693407780;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=R/0Riv2Bg2VbS+m5FY9brwIMDR/bGMMcoulO6aD8tbg=;
 b=c4Nzq56j4918oRbftJw2laVs7oMp8d4YwosR+0qNodalbXG1p/NjUDy7ItK0cx88Vx
 bDhNWwcjWlTuxmfsc/khsOTUvqDxj6MFG7mr4ForENWGXm4dg8ImXH0MM1UygSYXNT+2
 zrZbyzVlNt5IauudgcGfnVltQCczP5+5YBzCs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692802980; x=1693407780;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=R/0Riv2Bg2VbS+m5FY9brwIMDR/bGMMcoulO6aD8tbg=;
 b=lqC6/C0LSwvCGvd6l78CQ3HISgsb6Cc5kFfh9ClyLJXPNsWeJut9bEOSr2fHdQyXiX
 +gPG3QE4Jwgo3oX3Cc3mcSwmfn6YmirajgBA/HY+K6TFE4RU3bLj2xpBm799KnJjdSmG
 nPciyA9X/qM6uHK6PCOY6EwwAigtiTX5aw2pUS8/gS+rMjnreBwUbxq+O1GPGXmr0Gcd
 4QtbdD2FGQIuYL+O+cCy0mDmnWrLmx0/AJ6s6/V3yQL8zDr/L+Ul9kGS5QArreNWUPuu
 FnPhqD6o7/u0oR1qW1Ve91dVPNnrQpO3GrQC0soNOaTxwnkCfbq7q8FJg99gaIDMjUpi
 Ysog==
X-Gm-Message-State: AOJu0Yx8w5th7sQFlFIL1t82TWfKFOodjWtkSR3A7/2c+F6qZRcHtSw8
 2mzeWK3RvjeKu2LElWY6KA9akvqtr58ocWlPDkv8hw==
X-Google-Smtp-Source: AGHT+IFhrr4ySFL4wnKJdMiZX99zXLoVEnsHXC3kxslAl0Eh1GnRDxPeAqE7lCB3TNa/OFMw4Oco0g==
X-Received: by 2002:a25:d38e:0:b0:d4a:499d:a881 with SMTP id
 e136-20020a25d38e000000b00d4a499da881mr12007651ybf.9.1692802980609; 
 Wed, 23 Aug 2023 08:03:00 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-5ca1-6af2-305a-b62a.res6.spectrum.com.
 [2603:6081:7b00:6400:5ca1:6af2:305a:b62a])
 by smtp.gmail.com with ESMTPSA id
 v71-20020a252f4a000000b00d1732567560sm2858165ybv.5.2023.08.23.08.02.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Aug 2023 08:03:00 -0700 (PDT)
Date: Wed, 23 Aug 2023 11:02:58 -0400
From: Tom Rini <trini@konsulko.com>
To: Oleksandr Suvorov <oleksandr.suvorov@foundries.io>
Cc: u-boot@lists.denx.de, Alexandru Gagniuc <mr.nuke.me@gmail.com>,
 Bin Meng <bmeng.cn@gmail.com>, Kautuk Consul <kconsul@ventanamicro.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>, Simon Glass <sjg@chromium.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: Re: [PATCH] spl: crypto: fix including SHA* object files in SPL
Message-ID: <20230823150258.GJ3953269@bill-the-cat>
References: <20230823145633.10948-1-oleksandr.suvorov@foundries.io>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="KZViapVAysKb9LxF"
Content-Disposition: inline
In-Reply-To: <20230823145633.10948-1-oleksandr.suvorov@foundries.io>
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


--KZViapVAysKb9LxF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 23, 2023 at 05:56:27PM +0300, Oleksandr Suvorov wrote:

> If one of SHA* algorithms is disabled in u-boot, its code is not
> included in SPL even if a given SHA* option is enabled in SPL. Fix
> this.
>=20
> Fixes: 603d15a572d ("spl: cypto: Bring back SPL_ versions of SHA")
> Signed-off-by: Oleksandr Suvorov <oleksandr.suvorov@foundries.io>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--KZViapVAysKb9LxF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmTmH54ACgkQFHw5/5Y0
tyxptgv+Nq6ovpnA+P50P0adXRmOWDk1GAmdPcwOLd/1xfQTnJ/hbojLhU97FnsQ
iJUl94soATx6+Or3jyAKyNFfBrA34Cwj5/cylsgStsB5T9xygwASqbUCvmoq1Her
/CuRN4k1gPdqRGjwvbxTKR3HNaa2aki5D3oe86AriKcPwaIkpKk+5J5CxkEApLco
ITw36UMiHpNAlxRRmcdvCEeJxjVZjsamA+jVHLqZB8Z6lbRF9Az1EIRhxeljoXpX
4xpiA7M+TZh/pwL58BeSQGOWIUJre4ijQFXN/amRmgq5mrGqoqbaNLnEsw6lpL/0
JKeAl9MHwkh5XNXwr8bSxFl1smUi6l4ypy/qwMCgt6D3te9FRypt+2PQV1brvqqe
F5VFV2ED/dHXMWmrmFDQXRPpbrTJ36zgKi0JvPC1+sSWASS8vxWCiWQOeqN1OjvT
R4Yw3LdmWtpMQ2U0CpHxil+ldIU6z+AWQobWOPAaqBy7TfsiP0bAb7HJmnqu+OPo
fZBwtUt5
=bZZe
-----END PGP SIGNATURE-----

--KZViapVAysKb9LxF--
