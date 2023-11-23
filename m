Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 845D2C27C40
	for <u-boot@archiver.kernel.org>; Thu, 23 Nov 2023 00:53:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 86DC286F99;
	Thu, 23 Nov 2023 01:53:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="uQSNj/6q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 89642875F5; Thu, 23 Nov 2023 01:53:36 +0100 (CET)
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com
 [IPv6:2607:f8b0:4864:20::112a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4EDCF86DAF
 for <u-boot@lists.denx.de>; Thu, 23 Nov 2023 01:53:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112a.google.com with SMTP id
 00721157ae682-5cc589c0b90so3548237b3.2
 for <u-boot@lists.denx.de>; Wed, 22 Nov 2023 16:53:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1700700813; x=1701305613; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=liniMg2LiPOsza13tTlBFonQcXe8/Lu5ZyDtd3Pdb5Y=;
 b=uQSNj/6qxC9fj8ejyAcKA62hQvz7pHrHRso3Xnoa3Z37OAQE6ZDjZDG72E2J+YmZ1u
 Iacc93yhodNtTe9aJiaqWYlKlP6BBhDPFDZ2fuGn5rEYMWaW6OVp1ZFFfDM8vGTGo1CO
 9KQFXH5pbFwIe6/a4+IgqXesgES4JeizjpdqY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700700813; x=1701305613;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=liniMg2LiPOsza13tTlBFonQcXe8/Lu5ZyDtd3Pdb5Y=;
 b=wEOcc7y5oBmirGSbvvYv3jBbOiZXox8Kpx+1RBOx2J7Slzm/C0aAS+uzU3imkeEbmR
 F83nEiwuzJbLo5Sw+UW4ysOIlwKfcYqNHzenWa4jxmOAoYomrw9j1Epc4afAEuSaFK1y
 rts3ZL2aUbyDipxVpXYYfQ4CpxX0jA+7YjxcrG1oo4Ri9F86JuD4lFDfawYZ74vI0sB0
 QcTXW7chO7uILjSH6FX3x1frdc+30aXAN7Gtt3gNv76M18oXURx5W/d9aZMBItg3ed2H
 3W2suJAHwsz/Cm98cKTqu8HT+//MHiYgBxuMr2K10XzQGSghDUkud6981vnRMYcJfqYz
 QWoA==
X-Gm-Message-State: AOJu0YwmDPe5K2PduDCifnZ0Fpbav3Q0hj1rwh0LNqkulvD1nrnKAmbt
 FCsHaFs0iixPgQr6kV4jL+i+PJTxP3g1gVCYGxkblg==
X-Google-Smtp-Source: AGHT+IHcUeyUYhNHY5t0yyA+7JvybIgJUAeqxtA+I3ao6Kl+85y9S/7Aatbd/hshf10grQicG2irrw==
X-Received: by 2002:a81:6c07:0:b0:5a9:30c3:c664 with SMTP id
 h7-20020a816c07000000b005a930c3c664mr4371764ywc.19.1700700813031; 
 Wed, 22 Nov 2023 16:53:33 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-c98c-6625-156a-8c47.res6.spectrum.com.
 [2603:6081:7b00:6400:c98c:6625:156a:8c47])
 by smtp.gmail.com with ESMTPSA id
 w124-20020a0dd482000000b005cb56eb0d8dsm78585ywd.39.2023.11.22.16.53.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Nov 2023 16:53:32 -0800 (PST)
Date: Wed, 22 Nov 2023 19:53:30 -0500
From: Tom Rini <trini@konsulko.com>
To: Naresh Solanki <naresh.solanki@9elements.com>
Cc: u-boot@lists.denx.de, Patrick Rudolph <patrick.rudolph@9elements.com>,
 Chia-Wei Wang <chiawei_wang@aspeedtech.com>,
 Ryan Chen <ryan_chen@aspeedtech.com>, Simon Glass <sjg@chromium.org>
Subject: Re: [PATCH] sbp1: Add support for IBM SBP1 board
Message-ID: <20231123005330.GA3085390@bill-the-cat>
References: <20231117105053.1109399-1-naresh.solanki@9elements.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="+2A2t4zKz1Et3jnx"
Content-Disposition: inline
In-Reply-To: <20231117105053.1109399-1-naresh.solanki@9elements.com>
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


--+2A2t4zKz1Et3jnx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 17, 2023 at 04:20:38PM +0530, Naresh Solanki wrote:

> From: Patrick Rudolph <patrick.rudolph@9elements.com>
>=20
> Add defconfig & devicetree for IBM SBP1 board BMC based on AST2600 SoC.
>=20
> Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
> Signed-off-by: Naresh Solanki <naresh.solanki@9elements.com>
> ---
>=20
>  arch/arm/dts/Makefile         |   4 +-
>  arch/arm/dts/ast2600-sbp1.dts |  96 ++++++++++++++++++++++++++
>  configs/ibm-sbp1_defconfig    | 126 ++++++++++++++++++++++++++++++++++
>  3 files changed, 225 insertions(+), 1 deletion(-)
>  create mode 100644 arch/arm/dts/ast2600-sbp1.dts
>  create mode 100644 configs/ibm-sbp1_defconfig

This new defconfig needs to be listed in one of the MAINTAINERS files,
[snip]
> @@ -0,0 +1,126 @@
> +CONFIG_ARM=3Dy
> +CONFIG_SYS_DCACHE_OFF=3Dy
> +CONFIG_POSITION_INDEPENDENT=3Dy
> +CONFIG_SPL_SYS_THUMB_BUILD=3Dy
> +CONFIG_ARCH_ASPEED=3Dy
> +CONFIG_TEXT_BASE=3D0x80000000
> +CONFIG_SYS_MALLOC_LEN=3D0x2000000
> +CONFIG_SYS_MALLOC_F_LEN=3D0x800
> +CONFIG_ASPEED_AST2600=3Dy
> +CONFIG_TARGET_EVB_AST2600=3Dy

Probably the same one that has CONFIG_TARGET_EVB_AST2600 board code.

--=20
Tom

--+2A2t4zKz1Et3jnx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmVeooQACgkQFHw5/5Y0
tyzUzQv9GWBZwVfdzM665rJO6EB/oHMOT9CKNh9eBllRgjdnZ7yuVjZiK3QtCGvy
G2/w3ULTXiHzO38UV0gDRbUCXH6c65ZXiSjOFI/Py5EcxtVA2mMQq8vlyIQQ5/q3
CLUzqWESeKuboYq7o5qmoQofc+oPzaO8l+zhBUDrePDffKJsPoqkd6j3oI7HptLZ
+IeSABXdCz/oy+M6F8IM9kT01Oj7OB5LcecsbI7QOLALAn79r7XEe3z4cywYaMg4
VCAQY3RihUrcqgVYfWqvMWZf7l0jVXgttzeoqjTstjxkRq/8FdbIUnAVynwILBqj
YU9zoin7ii2N7vBSZE7hqiS+WNRT9tigU0QlyF4L2GFua1njGPlDqH/jD9C0M/LI
5tEyShq6mRarsQ6Z+9h+jxBVzJ9EFZwr7wZdC/N1RCHE7gKRIw9klBh2PStQcL1M
5W/VkLjYA9xHCw3pUzgdkFjmLrGBG5kzASqeZNCzJSoLtKte0uab4ZiGNuI6wFmc
TBSLcgWu
=rSLp
-----END PGP SIGNATURE-----

--+2A2t4zKz1Et3jnx--
