Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85D6BEE498E
	for <u-boot@archiver.kernel.org>; Tue, 30 Dec 2025 17:50:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9B19583F4C;
	Tue, 30 Dec 2025 18:50:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="IkCjzyhY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2C94083FA4; Tue, 30 Dec 2025 18:50:19 +0100 (CET)
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com
 [IPv6:2607:f8b0:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8A44683F4C
 for <u-boot@lists.denx.de>; Tue, 30 Dec 2025 18:50:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32b.google.com with SMTP id
 46e09a7af769-7c6e815310aso8295830a34.0
 for <u-boot@lists.denx.de>; Tue, 30 Dec 2025 09:50:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1767117015; x=1767721815; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Lz4L0m+1ikLswLogREfLDamAAJWwQWVodt0xlL6PHJE=;
 b=IkCjzyhYFcs11SeAzWNBhlT3X6NYS1chliprgq+kktnhjHp3su1CelnO/zmBwMhDF2
 2xPh2BlhRyMmF8Muxiy2ZgXgoT860yopJBvmtVyq+JymVtHDvajQ3FUZ1tP/FMNrsNBu
 Sl8qXj+CuWUwDRpssyt+AIBXNmTLvQmsOlbO4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767117015; x=1767721815;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Lz4L0m+1ikLswLogREfLDamAAJWwQWVodt0xlL6PHJE=;
 b=cb33g2qhd98LoHaz1d4AGYGx7A4FU4arP+YXTX7iTpLIX1OI2L/zieFICYES3Wy3RD
 q0AKm7p8rDAtO8JWXmcrcDx9v7qFvgOaafW+EwijQzgbuSoqTI1T++aVBuJVgFe2CLe7
 tFQ3dD3wqq+W1MoD7aY8TXmYR5WlEUIAWPxt0AIWdF/uyU9LGETCIi+7ViIr7t5wspVW
 FMaOQq9pL3Yp0gkByWbsjTqZZ2Y2OgtaASNjztYDUWuXAEi/c9ns9/o/y/XqVECA8C8g
 CjkWsU/JUiqcSmaGJPePioxG7MDnNVAlylFn8MaXF3GDvyazfFvle8BpbSQ2l6Wrm+wS
 4f8g==
X-Forwarded-Encrypted: i=1;
 AJvYcCWLRfHzOlltTvd4M7QUD8+xkUdH444/KaS9gmi1h6RB5zVM8BL79gFEWcNRR2mPuV2pO9XZDtw=@lists.denx.de
X-Gm-Message-State: AOJu0YyyR7PfqEe4qvsd7OTwYzrUCKaKVmvvQwE5ZG5SWL9AjRQDBFPK
 s2VOJ02oOYY3V9O30Zn4RsqQVl3Ngl2fXslZjW0NnsjI9b+ubt9ZV2NQm/W7Wvh1cRE=
X-Gm-Gg: AY/fxX7uhAI+VBx3tppuvdkFcSEw4sQBE0NcxUjNFdj4qnocKa+uc6UEcd/NJ8tOwTA
 i1G4/lnQSiFe+kpCUE3Ga6U2wIHc5+OrczdRCZ7066Oz/DE4kJaiAjojqP/aon9mb+ifio5Xcer
 C1caK7itJVsTUtYsujqJGfS9YfPwILHInkguQyTIRyZDGymh1EGuSlU70kYlfdroP9O+c/8bdZC
 ZK4yauGj2K5YFQoQY8DNSgaz+kkSxsqGHUebMjJ+EOq9I5Y5WBeKJe/D9FQb+X+tUDIYnugPpxp
 YnIt/wubOEDle1HJqaqczx2SXizLh73yxG77Wmete6kbBrp7AfqEwsByfyg3mfSrzZhTu0W7Pqi
 xt+IVR3RN48sNIDUVtSus9835D5e01D9Uc6DxTA5Nhs4r6khhRfHg2tWqT6y2X2T3dszcqM9kM1
 q6EbYJEFGmiE1P4gJ7WBQXZBhkwg5Nkbod2YzxGod9nMcR9bED9qP9d2uq3E5TwgDoqiseSKiBB
 /S9CxZlU6RcFkjQ6ANY9W0oeQDd+F0d9uM708fzR7ltGsEcZg==
X-Google-Smtp-Source: AGHT+IGXJGujUffEt97KUktDG4qcWnCS43vTP8dK9kHcIThLuGGdKz5k4gajuOou3/fT7c5yGY2OGg==
X-Received: by 2002:a05:6830:6688:b0:7c7:5974:3563 with SMTP id
 46e09a7af769-7cc66a15846mr15683263a34.29.1767117015248; 
 Tue, 30 Dec 2025 09:50:15 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7cc6673ccc2sm22921199a34.12.2025.12.30.09.50.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Dec 2025 09:50:14 -0800 (PST)
Date: Tue, 30 Dec 2025 11:50:12 -0600
From: Tom Rini <trini@konsulko.com>
To: Swamil Jain <s-jain1@ti.com>
Cc: devarsht@ti.com, aradhya.bhatia@linux.dev, n-jain1@ti.com,
 tomi.valkeinen@ideasonboard.com, vigneshr@ti.com, praneeth@ti.com,
 h-shenoy@ti.com, u-kumar1@ti.com, n-francis@ti.com, u-boot@lists.denx.de
Subject: Re: [PATCH v4 2/2] configs: am62x_evm_a53_defconfig: Enable A53
 splashscreen at u-boot SPL
Message-ID: <20251230175012.GA256115@bill-the-cat>
References: <20251106085842.629521-1-s-jain1@ti.com>
 <20251106085842.629521-3-s-jain1@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="+uh6ENeArvgtzCDK"
Content-Disposition: inline
In-Reply-To: <20251106085842.629521-3-s-jain1@ti.com>
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


--+uh6ENeArvgtzCDK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 06, 2025 at 02:28:42PM +0530, Swamil Jain wrote:

> From: Devarsh Thakkar <devarsht@ti.com>
>=20
> Enable A53 splashscreen at u-boot SPL stage. SPL_MAX_SIZE is bumped up
> to 0x80000 to accommodate splash related code. SPL Board initialization
> Kconfig is set to dynamically update simple-framebuffer and
> reserved-memory DT nodes before kernel bootup.
>=20
> Signed-off-by: Devarsh Thakkar <devarsht@ti.com>
> Signed-off-by: Swamil Jain <s-jain1@ti.com>
> ---
>  configs/am62x_a53_splashscreen.config | 17 +++++++++++++++++
>  configs/am62x_evm_a53_defconfig       |  3 ++-
>  2 files changed, 19 insertions(+), 1 deletion(-)
>  create mode 100644 configs/am62x_a53_splashscreen.config

This in turn makes am62x_evm_a53_ethboot too big to compile. Please
figure out how to re-factor these changes, or update the _ethboot
version to disable this again. Thanks.

--=20
Tom

--+uh6ENeArvgtzCDK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaVQQ0QAKCRAr4qD1Cr/k
CrqgAP9KJ4pKdqK8Wj0K1obRCBd4dRbt2mv74VnNC/5KbsCVHgEA/ZGfe0J8puPu
vZTZGL8V1v9HbAeNX/WnUMbGosUm8Qs=
=IfsD
-----END PGP SIGNATURE-----

--+uh6ENeArvgtzCDK--
