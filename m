Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E19EBC36017
	for <u-boot@archiver.kernel.org>; Wed,  2 Apr 2025 15:20:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1F2DB81703;
	Wed,  2 Apr 2025 17:19:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="X8Cevexe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 21BEF81E6C; Wed,  2 Apr 2025 17:19:58 +0200 (CEST)
Received: from mail-oo1-xc34.google.com (mail-oo1-xc34.google.com
 [IPv6:2607:f8b0:4864:20::c34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D4F658035B
 for <u-boot@lists.denx.de>; Wed,  2 Apr 2025 17:19:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc34.google.com with SMTP id
 006d021491bc7-60219d9812bso1740534eaf.0
 for <u-boot@lists.denx.de>; Wed, 02 Apr 2025 08:19:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1743607194; x=1744211994; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=3juWxCv6WdQr+xI3/DXfpbaEwoo3/hf2mZzdyiBnpQc=;
 b=X8CevexeRO7Hhq9+/SC8s6KVr53w4E4GqvXGKHKCiZw5kPfygE9K3gNMXT61yJV68P
 biuyKZXDxOjgHek326+XxH+warQluBoT3UeKxIZDfGKUgpl3lroQtB876HYoJGWUiy3q
 NJXxXspAF6t+SvV+llbfcBzBANiWitv5F4Tpo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743607194; x=1744211994;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3juWxCv6WdQr+xI3/DXfpbaEwoo3/hf2mZzdyiBnpQc=;
 b=K7Srhmx7Es94wPgZCu8C2wp4v5RiDY7R1UniBtnS28vs5gJnYlQHLstnkV/WamxxND
 JSSAajwnpiLBQw4QDSWDlUliZmlM2hJdBNtTr1O8UQfntkBgKNU6gRMoMyRGpkdRT7ki
 epqr2EwvY4eMYQTewn8XDe7D5fjCQWeAwHFfXxbSjpkcJKLfwiiNqSzRzOMlF5x/MITa
 5SWBme18BE7ILywJA9yg5/ZXiBQPt68n9Rjuny5o71G4Yg3k7lVRgY262yoEPJU9Jthy
 j07neEZ/vvb2nbeEsDsNmh+hUrpm2OqymzcN7TNO+rXl9UF2hXDH7tlLsN8325fLTzLd
 A5RQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWevrb6kdOFrNdZszurL+OQrGRvainLYEAMmdcj24nA5/OMdjaUcbixc6x/YKzyzatIsHfK70Q=@lists.denx.de
X-Gm-Message-State: AOJu0Yy6P5Lg3DwL/RdgPNzUCdyB3FGansBC3CXhWDRFJ8NaylyzvX+v
 2DpFK0q4xh4hgTOgG6e/nGtdqN0Y0fyuiF711cJohSAUVqW8iCjzytKBABMhrzw=
X-Gm-Gg: ASbGncuy0880TE7fBdtwagb+cqEX+ajOJeohIKV9QX94BDZZOj+gfJQ2KtCk1SsyTwp
 dGb3NOFd6aiVYVvbKiFkaAz5GjKrn3Tbsj/avbLvfhw8v2VvxzWzn8dkf7E+CPK643/t4XhMdQT
 zneKqhBGCkLj7pw3UgTIfhj9Gjc/BDoF+pqgbGXn1kM15V94CNd4T36VKE4E4mU7yNDYQdTCni8
 SyfpCoOloC+xeFokWljTwHNfn4Ad66kzOZmwNjZ5ACOGGIJf3B857dxjl3bZ0VM4GAwSXOSrg9U
 qmyJRuozdYTprU//pV3+EWZMLZiKm4gxV+kbG3PHmhlv7oXKFSh3j7tlhJKC/M4ccQAflNzkURw
 JvxhDFw==
X-Google-Smtp-Source: AGHT+IG3C84QG9Vi8fBjWfKHZ1QTiJ3kOehG/8iRLBrSIFQfaoLMcMrQtTLp3qHFkdPoxSkfxSLQCQ==
X-Received: by 2002:a05:6820:61e:b0:601:af0a:20c0 with SMTP id
 006d021491bc7-60400245648mr1314418eaf.3.1743607194490; 
 Wed, 02 Apr 2025 08:19:54 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-602845027b6sm2231753eaf.16.2025.04.02.08.19.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Apr 2025 08:19:53 -0700 (PDT)
Date: Wed, 2 Apr 2025 09:19:51 -0600
From: Tom Rini <trini@konsulko.com>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Bruce Suen <bruce_suen@163.com>, u-boot@lists.denx.de
Subject: Re: [PATCH 02/14] net: airoha: Add Airoha Ethernet driver
Message-ID: <20250402151951.GY5495@bill-the-cat>
References: <20250401225156.25790-1-ansuelsmth@gmail.com>
 <20250401225156.25790-3-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="tLs7ixuVKqBbOThl"
Content-Disposition: inline
In-Reply-To: <20250401225156.25790-3-ansuelsmth@gmail.com>
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


--tLs7ixuVKqBbOThl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 02, 2025 at 12:51:34AM +0200, Christian Marangi wrote:

> Add airoha Ethernet driver for Airoha AN7581 SoC. This is a majorly
> rewritten and simplified version of the Linux airoha_eth.c driver.
>=20
> It's has been modified to support a single RX/TX ring to reflect U-Boot
> implementation with recv and send API.
>=20
> The struct and the define are kept as similar as possible to upstream
> one to not diverge too much.
>=20
> The AN7581 SoC include an Ethernet Switch based on the Mediatek MT753x
> but doesn't require any modification aside from setting the CPU port and
> applying the Flood configuration hence it can be handled entirely in the
> Ethernet driver.
>=20
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> ---
>  drivers/net/Kconfig      |    8 +
>  drivers/net/Makefile     |    1 +
>  drivers/net/airoha_eth.c | 1448 ++++++++++++++++++++++++++++++++++++++
>  3 files changed, 1457 insertions(+)
>  create mode 100644 drivers/net/airoha_eth.c

checkpatch.pl has some macro warnings and it looks like some
inconsistent spacing around '#define FOO' vs '#define<tab>FOO' ? And are
all of those defines needed?

--=20
Tom

--tLs7ixuVKqBbOThl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmftVZcACgkQFHw5/5Y0
tyxuagv/VFL4sxhPVGKefhtsonIK8nRfiUcn0VQIEGVX3n37QkMB23Fyg8QKVmN0
p3tWr/mVyHIqHixmvGMl+kt1jtHSdaOyS+OGSHW3t2eWliCPCFZxjJq4QBE4Aj8e
TTJtv8DdHApnx7FFMdSBrN26m+tdjHoui1R5MREjpiI4w0y3nPKc4Y8iLu46omBW
H0ms/2q/LeX9Vye+p1B7S3rMK24s2gvdx4OY2Qm2NXwaPp0t2VYAxdPuRdOfTDPU
ITiCbV7xQEiAsf5zlzctDYw4BZyOQu3a6lqS0EiepZ7DFAendUgR13FoM4xszO1V
p8r0nCVkAw7HFabxJRdz2PszjIE+WSqCsemi+EC3uhCs8yy1va3wAU1TKrFnKXcW
eoHA2NN+BnbwinwjAcuJ0AS4W4di6114fIFT2adXJElmNebOYHfT5LY9hdZG7hTL
EuzaHJtGUszzE6gTsscWLGYtdYSPcNxVCGxnLfF7yvaOALg2ZI2hUiPj2oU3+Skj
4wLagX3P
=PZpJ
-----END PGP SIGNATURE-----

--tLs7ixuVKqBbOThl--
