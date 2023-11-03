Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 753D0C4167B
	for <u-boot@archiver.kernel.org>; Fri,  3 Nov 2023 14:39:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BB09B871DA;
	Fri,  3 Nov 2023 15:39:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="DTIMG8RD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4F8C38723E; Fri,  3 Nov 2023 15:39:34 +0100 (CET)
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com
 [IPv6:2607:f8b0:4864:20::f2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 07ED0871B2
 for <u-boot@lists.denx.de>; Fri,  3 Nov 2023 15:39:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf2a.google.com with SMTP id
 6a1803df08f44-66d17bdabe1so12342616d6.0
 for <u-boot@lists.denx.de>; Fri, 03 Nov 2023 07:39:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1699022369; x=1699627169; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=b2MgCwiPzJxz9pbEaCvtg+OrynrmNp5eSGZTtFS9byE=;
 b=DTIMG8RD1+8mAZ2+T8HciQi4/oIrhhsbbDjO6k2jwUQn4QnjzzdoPpNY1QK7BGznGG
 Ji3hDvWTs3PXRu5ex9KeWED9k1NMYdr8stdB54jo7NcUiPXyvfT5npCa38AmwfbvtB46
 gRq/WjcpTN6byfgQ0gy6I4UNBrTEtxsQZv4GM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699022369; x=1699627169;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=b2MgCwiPzJxz9pbEaCvtg+OrynrmNp5eSGZTtFS9byE=;
 b=tOw+6OeKZy9AEtCeg1qNTvR9fQdup2JdDSdcn9s/WebG26T+ql9YdVPoBEqXEMFxi2
 9yumbK2cVSNZMKAsp+3Wu4b3RoK2WN+Q+N3ndgb9DT4VxgLFz9Akvj+GEcuVxVAMBx9/
 zWYNDBeG4CeJsP8MFriIOR1LnZf4jE82gBtEX+wVT55P/PLPIkkZ4rODfJgfkWsKy9vP
 LPa3N/VGhSZFpvpImJEkjNO+Wry0AqBYVSRlhhFZJxEFGFzUflY3unLKAybOwAhFU+NW
 QKlTIiHsSvtQax371Os+o3qtSLAEpqPSY1BT9gWVuf0gKR2gC8VFV3fyyWqCejf1AOy4
 rZDA==
X-Gm-Message-State: AOJu0YyAdPpxmocwjxkvy5NfgLjl6kAZCWewskWbJ568w1UchP9io+Jy
 ksmcP1cfuk8E72wRhq55pk7UPA==
X-Google-Smtp-Source: AGHT+IHV7wW7BlFeQL9EknK7MCG9XBouPoBl4sv3N0TnrEoDF0xPHCcQ5hTLgzd+9XQOlYpsrtXYRA==
X-Received: by 2002:a05:6214:e4c:b0:66d:1624:2203 with SMTP id
 o12-20020a0562140e4c00b0066d16242203mr23749885qvc.20.1699022368836; 
 Fri, 03 Nov 2023 07:39:28 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-0000-0000-0000-013d.res6.spectrum.com.
 [2603:6081:7b00:6400::13d]) by smtp.gmail.com with ESMTPSA id
 s8-20020ad45248000000b00670867d7bdfsm785823qvq.122.2023.11.03.07.39.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Nov 2023 07:39:28 -0700 (PDT)
Date: Fri, 3 Nov 2023 10:39:25 -0400
From: Tom Rini <trini@konsulko.com>
To: Nishanth Menon <nm@ti.com>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Sinthu Raja <sinthu.raja@ti.com>,
 Manorit Chawdhry <m-chawdhry@ti.com>, Reid Tonking <reidt@ti.com>,
 Neha Malcom Francis <n-francis@ti.com>, Andrew Davis <afd@ti.com>,
 Simon Glass <sjg@chromium.org>, Robert Nelson <robertcnelson@gmail.com>,
 Jason Kridner <jkridner@beagleboard.org>, u-boot@lists.denx.de
Subject: Re: [PATCH 00/15] board: ti: Add support for BeagleBone AI-64
Message-ID: <20231103143925.GP496310@bill-the-cat>
References: <20231103003805.2420005-1-nm@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="H8xTa4VyveQjiAQd"
Content-Disposition: inline
In-Reply-To: <20231103003805.2420005-1-nm@ti.com>
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


--H8xTa4VyveQjiAQd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 02, 2023 at 07:37:50PM -0500, Nishanth Menon wrote:

> Cleanups for J721e/J7200 and add support for BeagleBone AI-64
>=20
> Based off:
> master 07fe79c93c5c Merge tag 'i2cfixes-for-v2024-01-rc2' of https://sour=
ce.denx.de/u-boot/custodians/u-boot-i2c
>=20
> Boot Logs:
> J721e-SK: https://gist.github.com/nmenon/c144e64f1da9fd49997ef5794b056bb0
> J721e-EVM: https://gist.github.com/nmenon/e79bed6807da05c723e71687fb3c0b90
> J7200-HSEVM: https://gist.github.com/nmenon/5658dd6fa2f67bce915c77b25c02f=
897
>=20
> BeagleBone AI-64:
> SD/MMC boot: https://gist.github.com/nmenon/1e07858fb8ca39ca87e40d3894e4d=
9b7
> eMMC boot: https://gist.github.com/nmenon/9b0602df1f1be2c6b512d135b0afae60
> eMMC boot with SDcard detected: https://gist.github.com/nmenon/82058014f4=
b2f6b9ed21431bc675e12a
>=20
> U-Boot CI: https://github.com/u-boot/u-boot/pull/444

Looking at the end result of the code, the split of evm.c looks good.
One small thing is dropping common.h from the board files.

--=20
Tom

--H8xTa4VyveQjiAQd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmVFBhkACgkQFHw5/5Y0
tyy6xgv/b1t6auXGDHZ/CiW2zihtzW/jv1/2yuHz5RiVFgzWB+fL1fxHyNEt945b
v1Pm/jJJ1yPRgQHw75BZXGJOlTXGjpro5jh4VTzYIE0Unbp9mUtUnIKUszm5FEhZ
A8/8XZpEaBDZS7jKNA7xhb4eDokT4r8L26OrjxFCdxROnKuAw4aQyzMQIvGA6KTZ
w2obuf1cPW8Mzz4Iznpcq4vIoi5ia3RFFkQAVlIrrtjkPdsM06+iIsS2T6QIn5vC
2mZcrAYdg5oLFw2EQVcmcl9QAqHigOWXH8tz4Nvp5/T099At+GaEKa4ue1ehvTSG
RGMcmcdRTCvmUuTV50vDrY2NoGsF8UINPRLO2wsJywIKiRGNpQQzn3DoMfuC0BEU
Ebvm7nGX2XVzI81siFUD/C+UujOYQSowvKLup7oRlY7icgBYlsNGXYXbSSBITOSp
BAuRDWlm/8Ye1bi4qwhYwiuw68moXcyBL9fl8TF62EblcBRmtVCAqyj8TAntWmjO
u6d5rrtw
=zYz2
-----END PGP SIGNATURE-----

--H8xTa4VyveQjiAQd--
