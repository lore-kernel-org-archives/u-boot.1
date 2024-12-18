Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7A9AE77187
	for <u-boot@archiver.kernel.org>; Wed, 18 Dec 2024 16:31:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 556A580274;
	Wed, 18 Dec 2024 17:31:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="KV9O0+QT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CF2EC80283; Wed, 18 Dec 2024 17:31:33 +0100 (CET)
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com
 [IPv6:2607:f8b0:4864:20::f30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9DCAD80269
 for <u-boot@lists.denx.de>; Wed, 18 Dec 2024 17:31:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf30.google.com with SMTP id
 6a1803df08f44-6d8adbda583so77786946d6.0
 for <u-boot@lists.denx.de>; Wed, 18 Dec 2024 08:31:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1734539490; x=1735144290; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=wWxZRANzXvrqlM9DWC/VrMI6AM7RNwAzPoPZq7V/xZM=;
 b=KV9O0+QTBynK8nKaoHE1BCyy6s4vtJIOgdPHn0T/nkemujiOW46QgB11sd8jBC5FQp
 VThYvvbzE5Gip1d9J1FTw9WFJayWk6fPE2EsADz+rKjDaTzx/sAd5C4wU60Inh1F4xGL
 yrkuFftrmh15RL1hCpgKCyES1hRq7aSfkIzLA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734539490; x=1735144290;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wWxZRANzXvrqlM9DWC/VrMI6AM7RNwAzPoPZq7V/xZM=;
 b=DFpJKfjMe4+/uTkJ4ItiJPPKdJYNam0ntWyqFUgtSYydCQ21C2Fk/cW5h8x9N6J+vF
 6yUH3RhzypigVx2MdlqTi/w5LhcrIq7AWkbINV3z6WftvGjGQpNKjfG2P2zZMHT2vFcK
 xGcOG958wnxs9zjE5xdKCoBcixPPyaGzt6R8OjkrCIO+NcYONKpjwiTi3oDbrDXQ0C75
 MGqOBphfgWPC12dBm93ikN7pJh2jDMtKBtwmtsZf9ba5hkzyrC/YMmK2T1Lmo3YKVKGS
 vaSzhV62TFEchGZa8Ymm+G7VnxoF5zOa/+2M4gjTB7jLDi98eEkTqg8OQVprUDtybRqJ
 lZEA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUFJtejvqDkxgFiS4i3Xf2FJq9j2oH5JWaHOBkMn9RxT89TNRvo02AyWlFavT/GMyu1SRtjLy0=@lists.denx.de
X-Gm-Message-State: AOJu0Yz+cgf1uYa6NeBzbG9bmQqMd8jrygW0SAkhDsF1ybEWtdceWMNt
 xB0Qga0becUyq5bwjivpiiH111MCW1G/iRwW1TseCmAtbsKgQFQE3ROoCD3jjSI=
X-Gm-Gg: ASbGncuKDiUiUECSBoyCxMJ7jfvONu6Ibc15O57NFfY+tTq1UhNrecthxTqCulAf6aO
 1qkyjgF6k7/HA4pCzNnzNz1wbnMxfS4dKp5uoUEeb691R8rYBPQlmLh5rWxtrNRRe8S0ev26e5I
 lYd9I/7TAZXGQuGSSZzsV7eLC/x+eiMgreGQ2ME79+75Ahoht9MePa+pblJ91TjKMeo27WLBRWR
 p1X1KIjU00v24CCzls9LKnN8uKzbSswmBakUfvajZL/r4gMrpyMfc7z
X-Google-Smtp-Source: AGHT+IFlslt5+/zt3D/6AcDlAuSnAWoFI6thdnGnySyjrjv2pKktV8QJWR2tNSk9Tp4ZF1eo8uhIiA==
X-Received: by 2002:a05:6214:1c0c:b0:6d3:b636:eccc with SMTP id
 6a1803df08f44-6dd14bc45a9mr4102296d6.21.1734539490310; 
 Wed, 18 Dec 2024 08:31:30 -0800 (PST)
Received: from bill-the-cat ([187.144.29.192])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6dccd22f79esm51736456d6.1.2024.12.18.08.31.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Dec 2024 08:31:29 -0800 (PST)
Date: Wed, 18 Dec 2024 10:31:26 -0600
From: Tom Rini <trini@konsulko.com>
To: Harrison Mutai <harrison.mutai@arm.com>
Cc: David Feng <fenghua@phytium.com.cn>,
 Linus Walleij <linus.walleij@linaro.org>,
 Peter Hoyes <Peter.Hoyes@arm.com>,
 Liviu Dudau <liviu.dudau@foss.arm.com>, nd@arm.com,
 andre.przywara@arm.com, manish.pandey2@arm.com, u-boot@lists.denx.de
Subject: Re: [PATCH 4/4] board: vexpress64: enable bloblist for SPL handoff
Message-ID: <20241218163126.GG1505244@bill-the-cat>
References: <20241218153933.37649-1-harrison.mutai@arm.com>
 <20241218153933.37649-5-harrison.mutai@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="QBnBR74/6/xn0RRO"
Content-Disposition: inline
In-Reply-To: <20241218153933.37649-5-harrison.mutai@arm.com>
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


--QBnBR74/6/xn0RRO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 18, 2024 at 03:39:31PM +0000, Harrison Mutai wrote:

> Enable bloblist on vexpress64 platforms to facilitate information
> passing from TF-A using the firmware handoff framework.
>=20
> Signed-off-by: Harrison Mutai <harrison.mutai@arm.com>
[snip]
> diff --git a/configs/vexpress_fvp_bloblist_defconfig b/configs/vexpress_f=
vp_bloblist_defconfig
> new file mode 100644
> index 0000000000..dcc87db872
> --- /dev/null
> +++ b/configs/vexpress_fvp_bloblist_defconfig
> @@ -0,0 +1,5 @@
> +#include <configs/vexpress_fvp_defconfig>
> +
> +CONFIG_BLOBLIST=3Dy
> +CONFIG_BLOBLIST_PASSAGE=3Dy
> +CONFIG_BLOBLIST_SIZE_RELOC=3D0x10000

I wonder if this means we should also do:

diff --git a/common/Kconfig b/common/Kconfig
index 11066ec64315..cca33ed28f32 100644
--- a/common/Kconfig
+++ b/common/Kconfig
@@ -1087,7 +1087,6 @@ config BLOBLIST_SIZE
 config BLOBLIST_SIZE_RELOC
 	hex "Size of bloblist after relocation"
 	default BLOBLIST_SIZE if BLOBLIST_FIXED || BLOBLIST_ALLOC
-	default 0x0 if BLOBLIST_PASSAGE
 	default 0x20000 if (ARM && EFI_LOADER && GENERATE_ACPI_TABLE)
 	help
 	  Sets the size of the bloblist in bytes after relocation. Since U-Boot

Because in this case we do need to set the size of the bloblist we use
internally to non-zero?

--=20
Tom

--QBnBR74/6/xn0RRO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmdi+N4ACgkQFHw5/5Y0
tyywXQv/VT+vqGNVMJlFLe5G17ljL1Q5B1jhWBBl03QgQN52mgDViDE7Q+7EDNxz
qXGCpcSd9JZNSKWNrjY5rL2nW51As7QA1RMmxEr0Ft17MYLlW9pp+ZGzA2Ppj610
1OnJ2UWs1KLSMsBYhuy7rWA/gs06YaDCP3GASFVtQZfO93NgASsY1KtNGXTCLX8O
fBuE8tEOfby6NB01/fu7OsXfdgNCMSFjrFEClR07VqNCIL7AM9LKqnTxTbFT5Loz
afLWOlTnsVG0KfEz0ePURMZHC1en3arAXOg3zdZlEFE5X+T7acJYQ3Z0fsopEt9U
XgHK4dTsMfjWWiFUTw+ThyXzJ93zs3bgC93Yr/95uuvb7SXMCeYmETGQQCTUe/DX
fRkIj8n9eZe0m9bc08k1vZJSiiW9XWghN3eV7t6J6oDGcUUhaKmpk34XFk9uTjzL
9Dou7RYTfpzZP/k1Gi3JE6qC6z8pXH9Ll7r1yMKCHwMA9yugigfL3NYlH+i9HL34
rdonCcDH
=0T0X
-----END PGP SIGNATURE-----

--QBnBR74/6/xn0RRO--
