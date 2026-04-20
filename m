Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6A89F5A8A5
	for <u-boot@archiver.kernel.org>; Mon, 20 Apr 2026 18:12:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 09BE084315;
	Mon, 20 Apr 2026 20:12:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="JN2wZLNd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A5E0384319; Mon, 20 Apr 2026 20:12:07 +0200 (CEST)
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com
 [IPv6:2607:f8b0:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3F079842BF
 for <u-boot@lists.denx.de>; Mon, 20 Apr 2026 20:12:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x331.google.com with SMTP id
 46e09a7af769-7dca4debedaso2187142a34.2
 for <u-boot@lists.denx.de>; Mon, 20 Apr 2026 11:12:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1776708724; x=1777313524; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=cmLYjDicXAHk75iPqR1s5J+gcSpbyI+vEZ7SbltgZTM=;
 b=JN2wZLNdXq+aqwzzlG18FLC/3IWC0GFnrG2GRIrNTOod6N7SDqjIiORzopDiAcKfFS
 1CkWT7/yZC1QnK6rf/1Yv/0Nde+ZOwyG2EMNyeLZNdcyCeqQ/OlAxvbJ9WzU7HgqEe/y
 Fq62V01Aly0DQBIaJ0yAgofG+/wzsdUy8iIoE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776708724; x=1777313524;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cmLYjDicXAHk75iPqR1s5J+gcSpbyI+vEZ7SbltgZTM=;
 b=ir7kxtLu9hWJhQbWkj0zEtgaQVgUqje7KrhYITKcINQpjxSkySAbSwhH0lHWt9jZY4
 8JVQMbiscEYasWQpjJIodEDqZgVxZGfXKrHi2r8m0pG2r4Lrd0xgdD144gu5XZDpsg/C
 kJxQ/IBt5DtELp3kJOGpQhVm3b7ojWjYdsnhsD/cs4mTVcfR0+rDhpYrB8nnB0ZdwxIq
 vnbv08l1fn6l8r1xDmx5OtLWqlYeW+w1pImcO5FyrfwYqS5J41xSeioqtmqbC7Fxcd+U
 CMOduSeiLAZyoEsxfOrdt0tEF+Fhdxz+7puOevEmz6rwl64TJTwLSikpU1DxkQjh/COt
 Hcew==
X-Forwarded-Encrypted: i=1;
 AFNElJ+bvaMoW5J4zzCnh65epsuLOdi2n+ZnRvHkHiqRc8J7VQQ5ROFQsbOLKMzRte4fHNK/DBLV12I=@lists.denx.de
X-Gm-Message-State: AOJu0YznxeZKak0kHfADbXyUmcyfW2vtWuhDPy+8wJHKScEhnxgML7KH
 FrapI8ndZZUfnK+DdgIdQzacIWt/8tLGkFYhf0m18tRtOEq1NguNcv3BJhlOykIEbI8=
X-Gm-Gg: AeBDies36p1PqCUfOHDDRzztAazEOzh4qaFh2wpB0cbNbEh7TsBKXlirEKW3DbmE2Xx
 ymx4pswf3a/+sxkeijuKsHehks6Gf8prgswdxego+OsmPfGYUysjTI8pxNW0vbb3tXXUFGWD62m
 vBpAw80V7LATJ5pyHwsZ+g8pkPwdZE16TILl4n+dkubotARdxJyGmHh2/xyDUntZJeH91hRnohW
 SHd20aJgjSNJKq/Rl8VMK+XYRLcQou0izkJSZgtEDSpWO9UyCowna8+M9tQpzmp8twNpGIF4JNV
 /4NYmfmDz0hAGz3wFeAdsw6/l/QP+9k1WUqMJW+/jR5gkVDmZquX58RExZAG7M4tXhdhOV9kaon
 5ZXJ1NI8GT+OXh7iwZwvwbaL0Xzhz7zeXCfzaMkKjXqo53RowElhhzMwzg8IaQnVB4fIsLD4zUP
 Gp9r7Dlf1l9XiL6ZangZixvJhWbw5SFg8T7/ZuvVKbl5FoDm86WwlIBKr2BQcqxbFx9swQifzl8
 bi3nXu2z0ASEsXeYL4C+tTadeOLuKsKnuTYl0EDGinGVNaXCaPW0J8lJNBDeVGWa0JC5fSq
X-Received: by 2002:a05:6830:82ad:b0:7d7:45eb:4e22 with SMTP id
 46e09a7af769-7dc952a06c1mr9731703a34.26.1776708723818; 
 Mon, 20 Apr 2026 11:12:03 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7dcd56bd0e4sm371962a34.2.2026.04.20.11.12.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Apr 2026 11:12:03 -0700 (PDT)
Date: Mon, 20 Apr 2026 12:11:59 -0600
From: Tom Rini <trini@konsulko.com>
To: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
Cc: casey.connolly@linaro.org, neil.armstrong@linaro.org,
 sumit.garg@kernel.org, sughosh.ganu@arm.com,
 ilias.apalodimas@linaro.org, gchan9527@gmail.com,
 mchitale@ventanamicro.com, maximmosk4@gmail.com, jonas@kwiboo.se,
 marek.vasut@mailbox.org, quentin.schulz@cherry.de, peng.fan@nxp.com,
 sajattack@postmarketos.org, balaji.selvanathan@oss.qualcomm.com,
 wolfgang.wallner@at.abb.com, e@freeshell.de,
 yangshiji66@outlook.com, jan.kiszka@siemens.com,
 funderscore@postmarketos.org, hs@nabladev.com,
 kory.maincent@bootlin.com, jj251510319013@gmail.com,
 carlos.lopezr4096@gmail.com, u-boot-qcom@groups.io, u-boot@lists.denx.de
Subject: Re: [PATCH v3 0/7] Add FIT multi-DTB selection for Qualcomm platforms
Message-ID: <20260420181159.GA2373171@bill-the-cat>
References: <20260417120951.3454249-1-aswin.murugan@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="YSHt2C01AUqGcPn4"
Content-Disposition: inline
In-Reply-To: <20260417120951.3454249-1-aswin.murugan@oss.qualcomm.com>
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


--YSHt2C01AUqGcPn4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 17, 2026 at 05:39:44PM +0530, Aswin Murugan wrote:
> This series adds dynamic device tree selection from FIT images for
> Qualcomm Snapdragon platforms, enabling U-Boot to select the
> appropriate DTB based on hardware parameters detected from SMEM.
>=20
> Qualcomm fit based DTB format is documented in [1]
> The fit image contains only DTB, while the kernel will be part of UKI ima=
ge.
>=20
> The implementation consists of three parts:
>=20
> 1. SMEM cache infrastructure: Provides cached access to commonly
>    used SMEM data (socinfo, RAM partitions) to avoid redundant
>    lookups during boot. Includes socinfo header from Linux kernel
>    for SoC identification.
>=20
> 2. FIT multi-DTB selection: Implements the core selection logic
>    that reads hardware parameters from SMEM, parses metadata DTB,
>    matches FIT configurations, and loads the selected DTB with
>    overlays. Integrates with EFI boot flow by setting fdt_addr.
>=20
> 3. mkimage: add fatfs image type for FAT partition images
>    Added fatimage.c handler that uses mkfs.vfat and mcopy to create
>    FAT images from a directory.

I'm unsure why part 3 here is appropriate for U-Boot. It's wrapping
existing tooling to create a fat image?

--=20
Tom

--YSHt2C01AUqGcPn4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaeZsbwAKCRAr4qD1Cr/k
CvABAP9Xi7VeMSY80PkS1+0XKkPmrAv2mhCS221aDdoKVh+hwQD+JrGkraX9pIkH
KrN3B7VlAophBBW5ePLRA+Y9YztIyAU=
=lwPU
-----END PGP SIGNATURE-----

--YSHt2C01AUqGcPn4--
