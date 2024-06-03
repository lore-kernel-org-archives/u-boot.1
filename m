Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 286ADC25B75
	for <u-boot@archiver.kernel.org>; Mon,  3 Jun 2024 17:42:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 18307883A4;
	Mon,  3 Jun 2024 19:42:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="IWuo1jXy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9BCD087EB4; Mon,  3 Jun 2024 19:42:17 +0200 (CEST)
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com
 [IPv6:2001:4860:4864:20::36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3EBBF8839C
 for <u-boot@lists.denx.de>; Mon,  3 Jun 2024 19:42:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x36.google.com with SMTP id
 586e51a60fabf-24c9f6338a4so1790514fac.1
 for <u-boot@lists.denx.de>; Mon, 03 Jun 2024 10:42:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1717436534; x=1718041334; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=y8ynzjsbyfa11US1WXyqQcBxPE+hNbA+vpaSBMl6S1c=;
 b=IWuo1jXyd1PKzpLBywXKK7a53hsrEG4tiQsCOKRnxSlPMQ03xam7ShL9zZFiGVlTH2
 OR0sa8aNcmD9hL5nh5itHI3oMaUPtsy3L75f1mGfuDL3FBl3KWD2MQ3JNX3AKwel2oy6
 58rOqbvRf+V5cJb4j8vjOqPjaY/QUNHetHs1Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717436534; x=1718041334;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=y8ynzjsbyfa11US1WXyqQcBxPE+hNbA+vpaSBMl6S1c=;
 b=j46jjX9E3DNfIcV33l3l0jBC3lURuJaBL0gdxGKhIqYVzF5KYLLM5vSpIZQjtbFqd5
 YzKUq9vSKynIaESgvuEFzkBR10nTR+rc/5QCICACZb0KagWnF56Wybd3uz7rJ8OQcyKu
 Wfy1Mn9PkAYhDORAEwdFH2VQrixTMWJw1UGjI/b40o7nqZ/hgQgqLDx/MLPAJFadHdh1
 9CFA4umaGPaLD310gwewDRXXpxG6R3h+o6KRANvHBzv4wauH+VEb/jKtf88WRi3jVlVw
 T1x2+4BulpkGkCGF3RhQtbIcvkCnAP/isd7wHZ/5U4SSpBX4n2zwBTs9RW/nwXyxTgvM
 JRfg==
X-Gm-Message-State: AOJu0Yz4FfMCVC00p68e/H17oA7p6ZHjB2ZrsTAe2GT3smIy9vi9MXNM
 t0b2qQg+dZDjWs35mMQEAp4yKhbPgw1BYrRX2fi4cME7uarV6MeLNxsl/yB3Muw=
X-Google-Smtp-Source: AGHT+IGS+OlxYrwNO/2kxTAru3YL85tbJ2DDPylr35d65c5Pey744G/LHeXOr78hYJMCWERhrodt7g==
X-Received: by 2002:a05:6870:2308:b0:250:7aea:d125 with SMTP id
 586e51a60fabf-2508ba20098mr10911273fac.27.1717436533822; 
 Mon, 03 Jun 2024 10:42:13 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-45.totalplay.net.
 [189.203.100.45]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-25085226ae6sm2553749fac.36.2024.06.03.10.42.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Jun 2024 10:42:13 -0700 (PDT)
Date: Mon, 3 Jun 2024 11:42:11 -0600
From: Tom Rini <trini@konsulko.com>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: u-boot@lists.denx.de, Adam Ford <aford173@gmail.com>
Subject: Re: [PULL] u-boot-sh/master-cleanup
Message-ID: <20240603174211.GC68077@bill-the-cat>
References: <20240602125047.12374-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="BoCaFmnbY16tmSDj"
Content-Disposition: inline
In-Reply-To: <20240602125047.12374-1-marek.vasut+renesas@mailbox.org>
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


--BoCaFmnbY16tmSDj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 02, 2024 at 02:50:14PM +0200, Marek Vasut wrote:

> The following changes since commit ea722aa5eb33740ae77e8816aeb72b385e621c=
d0:
>=20
>   Merge branch '2024-05-29-assorted-small-fixes' (2024-05-29 11:21:14 -06=
00)
>=20
> are available in the Git repository at:
>=20
>   https://source.denx.de/u-boot/custodians/u-boot-sh.git master-cleanup
>=20
> for you to fetch changes up to ecfa301911405f9ebc27677f6d26fcd43309ed36:
>=20
>   configs: rzg2_beacon: Realign ENV location and offset (2024-06-02 02:30=
:01 +0200)
>=20

Applied to u-boot/master, thanks!

--=20
Tom

--BoCaFmnbY16tmSDj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmZeAHMACgkQFHw5/5Y0
tyz6sgv7BkRCBsjb4ZUEOvm/GWSDmfMpSJcIQlypwH51rVDECibnsB+Xtv8BYTFh
ASTCJf8icguAp6IOhA6IXiHWeqV76HjOzQfqp6XCe9dndjBmu1ycKM3gR2ytabJZ
2wJwa/Fkjml9OQNnOZJnJGS/TIJI0Z7++bHKtpb2WDggFhEx5q6Lag/iIL68tMe0
Pl490sQ+IK0EHw0z3h6PdXUB1sLH8z9TEC4k0Yv9kMPwlw7enDrP4vwHEzW1/Pot
/d6mxf3aztL9nxURp3brjFbIpSQcQMu7GmkvPCrT8Bh6Zu2n/MURoHsyf3Hfg6G1
TqCbfDMoYDVWOur22upA+IgfPc2pSKsukm/OjFcpu3lyZJKhXj/8UFkA8tR/Ov0t
S3Z4+CiIaLAdz2ESC/l5s5dT7Wrq8Zad5BEe2I/IUd326dQZSbq2o2a2nLcQNOf4
DEgmefSa5pcOGGcvczcyZ1xytM6omblLAzs/If1xwvgz5Ml29MNldpIoYYbFCHWo
Wj311VpY
=ynFi
-----END PGP SIGNATURE-----

--BoCaFmnbY16tmSDj--
