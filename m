Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D065C54E49
	for <u-boot@archiver.kernel.org>; Thu,  7 Mar 2024 17:12:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 045BD87DE5;
	Thu,  7 Mar 2024 18:12:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="W9Y20B+q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0C0AE87DE5; Thu,  7 Mar 2024 18:12:24 +0100 (CET)
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com
 [IPv6:2607:f8b0:4864:20::72d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A5FA287D80
 for <u-boot@lists.denx.de>; Thu,  7 Mar 2024 18:12:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72d.google.com with SMTP id
 af79cd13be357-78810ba2ff1so59422885a.3
 for <u-boot@lists.denx.de>; Thu, 07 Mar 2024 09:12:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1709831540; x=1710436340; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=+JLn3oJBZ+AzFvVlWV/i9IkpnMHZGaE0tk5t3z+cRRI=;
 b=W9Y20B+qFZD/guGmHCdkO1MeXnsoxpomSdLPKmcqFYSOFWxo39GMcMNW4vnBfl3Y34
 Cho61MCQBvI707fkKx9QCUiocjiu6SUltpjEiSeOqfTbKM0dljtPc7VakUNTHhDdze0S
 zxy2zkdtTwytE4tP9szE502oyxeWDklIz67hU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709831540; x=1710436340;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+JLn3oJBZ+AzFvVlWV/i9IkpnMHZGaE0tk5t3z+cRRI=;
 b=w2yD/eccIR+jFVvUkc5t8qC2ox5f9GChu29WLFDp2ynQvzpGTQ2SSc7oFg9Pf7WTES
 l8RSc91P7y9ogf/U/GwY0zRBUCju1uMlDvF5n5wPDTuNL25JVylfdk48kwW3801SMo7e
 hfM8vgbNE/hI7wH8h32ALl3DmUtawcPzLy5k8Pyn+KfKqNHocDwcfe0wZUxPOPhdTQw+
 MoinVbf0Ypd1B37TnSNB8VGswO6JqN95I3cU9l4CNqTo88way5oBAbYk2LMJgWXh6K0A
 Ft1H/8v9qVYz6UxbJfK9JeEdJrk9Em7Gb6gImq5NcAa1YAvpCxRK9pDZMRss8i+Pi0oN
 /PvQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUlrx1T4JWK/6JRApODEiqdv1ZCXJ48zFtCsCeijBR4mO5ScJz5eNnGQsBPGG6Y8BLtbCnN5heWm0So3YDji06a94UjVw==
X-Gm-Message-State: AOJu0Yy3uSnZztpAs9I2TJ5qEbY9KdKJlIFHCWHjHgx2rhhbXSqp78yR
 sVL2yljKl/3FbTvBAtH6hh21ANiGvkG4jZtDS9ofb1uy57gapfhZ/XCVUp3LkqY=
X-Google-Smtp-Source: AGHT+IFs4vxOrtrzH0kJU4x5O1GE/PO6QtQvuGage4Tf6b+WYd2KPoVxqANeImtuOGJDDiM0BkKQVA==
X-Received: by 2002:a05:620a:204e:b0:788:2367:509b with SMTP id
 d14-20020a05620a204e00b007882367509bmr7133465qka.51.1709831540454; 
 Thu, 07 Mar 2024 09:12:20 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-007f-0000-0000-0000-1001.res6.spectrum.com.
 [2603:6081:7b00:7f::1001]) by smtp.gmail.com with ESMTPSA id
 pa39-20020a05620a832700b0078825a5ac3asm4791575qkn.45.2024.03.07.09.12.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Mar 2024 09:12:20 -0800 (PST)
Date: Thu, 7 Mar 2024 12:12:17 -0500
From: Tom Rini <trini@konsulko.com>
To: Roger Quadros <rogerq@kernel.org>
Cc: Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, nm@ti.com, srk@ti.com,
 s-vadapalli@ti.com, vigneshr@ti.com, mripard@kernel.org,
 dannenberg@ti.com, r-gunasekaran@ti.com, danishanwar@ti.com,
 u-boot@lists.denx.de
Subject: Re: [PATCH v2 2/2] net: am65-cpsw: cpsw_mdio: Switch to proper
 DM_MDIO framework
Message-ID: <20240307171217.GL1523872@bill-the-cat>
References: <20240228-for-2024-07-am65-cpsw-mdio-v2-0-f74f972eafeb@kernel.org>
 <20240228-for-2024-07-am65-cpsw-mdio-v2-2-f74f972eafeb@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="u4WKaef6TpXsD+ZL"
Content-Disposition: inline
In-Reply-To: <20240228-for-2024-07-am65-cpsw-mdio-v2-2-f74f972eafeb@kernel.org>
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


--u4WKaef6TpXsD+ZL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 28, 2024 at 12:35:27PM +0200, Roger Quadros wrote:

> Add a new Kconfig symbol MDIO_TI_CPSW for the CPSW MDIO
> driver and build it with proper DM support if enabled.
>=20
> If MDIO_TI_CPSW is not enabled then we continue to
> behave like before.
>=20
> Clean up MDIO custom handling in am65-cpsw and use
> dm_eth_phy_connect() to get the PHY.
>=20
> Signed-off-by: Roger Quadros <rogerq@kernel.org>
> Tested-by: Ravi Gunasekaran <r-gunasekaran@ti.com>

Applied to u-boot/next, thanks!

--=20
Tom

--u4WKaef6TpXsD+ZL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmXp9XEACgkQFHw5/5Y0
tyy6nwv+LrNDYshPrBEs3T9l5JFSs2+L53RUY5HCUHGZ2XKxmMkLVeHtKVhHuMTS
Y1dloOuHXALY8CMBBcsNC+DqU7q4msGbW1iYjEOzFk1IQoxD35NOIrcU7aMTXynO
UW8kQeyeRp1hUBKwRQI8yIBOCQO2QO66AES0cy7bY0c8O/xcnfT08yo0vhwRZdd8
KQoPc5xtCJLfic8qaqIQ5RdNuUpb85bI8EpgZqW1J3ztpIhlGGABWsdj4l7svzFM
WPnp+nSR6GuGFFNMu9HYbdDQO39di5E1OUkt9XPVkiy++Xrl7H/vvWRr6sxWEubP
BWcCebAhh36fwdktDnep+S9J8KbFlwK/PC2RWLn1Ll3F4kCM5Vn9KvpdKbk6P+eg
vEyTFaTt/GPtuLD/KgbxGtapwj5DFW2LvtP6Z36qocibtQQDiNU7QEeUZgneQTWg
h3B4bz8krl84B8M6bRjr+8G2EdcyDOPYlgZUzxPnqglUzFb0fgkBk/ONOuB/HFDi
u3GSY0SE
=k45W
-----END PGP SIGNATURE-----

--u4WKaef6TpXsD+ZL--
