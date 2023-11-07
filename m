Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6607C4332F
	for <u-boot@archiver.kernel.org>; Tue,  7 Nov 2023 18:12:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2EBCA875BF;
	Tue,  7 Nov 2023 19:12:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="qETvgzp0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 87AB1875C0; Tue,  7 Nov 2023 19:12:28 +0100 (CET)
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com
 [IPv6:2607:f8b0:4864:20::831])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 79B14875B8
 for <u-boot@lists.denx.de>; Tue,  7 Nov 2023 19:12:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x831.google.com with SMTP id
 d75a77b69052e-41e3e77e675so39575421cf.1
 for <u-boot@lists.denx.de>; Tue, 07 Nov 2023 10:12:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1699380745; x=1699985545; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=d5iTt8fsPnLuOUAXmJKrMn4WW71Ca0guCYFITwqmGzg=;
 b=qETvgzp0pvtjnR8iarGjeIV0MvlqxrhH5nIMtzl+FGIw0COizvgNNcgB7Bb+dvtrza
 m+Gu5dpymFJk+7n4LEWhwiWcQyL+bTPMO7Q5omGLUaQMfufKcAY2HXnRlM8v7xAqFafn
 VbmMmG9a3E8VpgVKU/BQBFGwnR1sXpiTjWc5g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699380745; x=1699985545;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=d5iTt8fsPnLuOUAXmJKrMn4WW71Ca0guCYFITwqmGzg=;
 b=HKq2s4IWBXdiwoxr8vfCGwRUn342b7E8tgKp4RHDuzATQIv+lkp8elrTz6DTDZAvmq
 I77wN1++v//zx/kv9E7J3d4H1e8uTTujo++dRyYM8148vm/ikuK0nPwIcOZMTyfMwaho
 ZqXmAZ+VijuIg2vrgJ5IFWApsJZXvkI0DgJfE9KeGYrrx9xnvxK/wxwWr2JrcXz5a0px
 YB0cl6RWkkOgQT/PPG2IdsNjG0/Abq73Tk9ERKv5//RZG4ynG6aXvU36eHZNlGb493tJ
 YYwPUhm+WfK4RJl5Vy6927UsCA6Q5bU6VODie6Kmt8fp3pf/OzhPe5XXZyiE9PjrrZp6
 ZHPg==
X-Gm-Message-State: AOJu0YzqMEFMu2cdD9I1WP2lbN0pg+b7NLIo9JKZJbp56A5trJkYRcyR
 PwKkIEfhB7WdwDszaBY1F+8TsA==
X-Google-Smtp-Source: AGHT+IF1SkYlQHuXIjY4wBxIsGKb1jpgw21jk7RGjcuGbHwXOMXxdz+FfW1fMzuaeAUtPaNEsAxwXA==
X-Received: by 2002:a05:622a:1492:b0:419:4e1c:68f9 with SMTP id
 t18-20020a05622a149200b004194e1c68f9mr38840831qtx.47.1699380745257; 
 Tue, 07 Nov 2023 10:12:25 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-2fee-489d-8907-1a68.res6.spectrum.com.
 [2603:6081:7b00:6400:2fee:489d:8907:1a68])
 by smtp.gmail.com with ESMTPSA id
 l23-20020ac84a97000000b004181b41e793sm137310qtq.50.2023.11.07.10.12.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Nov 2023 10:12:24 -0800 (PST)
Date: Tue, 7 Nov 2023 13:12:23 -0500
From: Tom Rini <trini@konsulko.com>
To: Thomas Richard <thomas.richard@bootlin.com>
Cc: u-boot@lists.denx.de, nm@ti.com, thomas.petazzoni@bootlin.com,
 gregory.clement@bootlin.com, u-kumar1@ti.com
Subject: Re: [PATCH v2 2/8] configs: j7200_evm_r5: Used reserved memory in
 DDR for stack
Message-ID: <20231107181223.GI6601@bill-the-cat>
References: <20231107161802.855154-1-thomas.richard@bootlin.com>
 <20231107161802.855154-3-thomas.richard@bootlin.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="UHCCO3m6OlsGWGrZ"
Content-Disposition: inline
In-Reply-To: <20231107161802.855154-3-thomas.richard@bootlin.com>
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


--UHCCO3m6OlsGWGrZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 07, 2023 at 05:17:56PM +0100, Thomas Richard wrote:
> From: Gregory CLEMENT <gregory.clement@bootlin.com>
>=20
> When resuming from suspend to ram, we load again the DM firmware.
> However, we have to be sure to not modify the memory used by
> Linux.
>=20
> Currently the SPL stack in DDR was in place that could be used by
> Linux. Instead of it use a memory address that is located in a
> reserved location that won't be used by Linux.
>=20
> Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>
> Signed-off-by: Thomas Richard <thomas.richard@bootlin.com>
> ---
>=20
> (no changes since v1)
>=20
>  configs/j7200_evm_r5_defconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/configs/j7200_evm_r5_defconfig b/configs/j7200_evm_r5_defcon=
fig
> index c4dd33627b..7450529d66 100644
> --- a/configs/j7200_evm_r5_defconfig
> +++ b/configs/j7200_evm_r5_defconfig
> @@ -20,7 +20,7 @@ CONFIG_DM_RESET=3Dy
>  CONFIG_SPL_MMC=3Dy
>  CONFIG_SPL_SERIAL=3Dy
>  CONFIG_SPL_DRIVERS_MISC=3Dy
> -CONFIG_SPL_STACK_R_ADDR=3D0x82000000
> +CONFIG_SPL_STACK_R_ADDR=3D0xa5300000
>  CONFIG_SPL_FS_FAT=3Dy
>  CONFIG_SPL_LIBDISK_SUPPORT=3Dy
>  CONFIG_SPL_SPI_FLASH_SUPPORT=3Dy

This is fine but I want to see a previous change that sets
CONFIG_SPL_SIZE_LIMIT and related to the right / useful values
(j721e/j721s2 and some other K3 platforms set this as well) for j7200,
and then SPL_SIZE_LIMIT_PROVIDE_STACK being set in this patch, and other
options adjusted as needed.

--=20
Tom

--UHCCO3m6OlsGWGrZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmVKfgYACgkQFHw5/5Y0
tyxjvwv8DAMk9Twa3nczIC2OROvQGxCyCsgoq0t8aoogLiSD99TVeax7xoSdM8L4
k0hvqxfyFoRwmojyPhC9k4dmoU65BrTL+A50UFFP4dLKCoUmpu4nG3N3Dp1YeG41
FxMiJcNjEm7437oznM33JDLtn7+bxvhB+oX43aD1U3oJWFaHsJ12dWcJyw2t83v6
pcioW2GENSPfSqkzGzhRNIA1Nt7YlbpUDpFmQaSkmJxawXJzXFoFjaUzuIAE/APm
3jqEQ6iJxxGTzz1+tRoMATBWc3PAKNWd9W9HFnY5Gj/sb5aKtWdmIHDw/MYzhHjK
KDvzA76MkWIPthMeVwz9hRfOrmgD5YuUsBRJaJzOq/nSlId2CHk11Oeh9sPFDzIC
2gWOG4h6EMYMlp6TIu1CDxec9L2EgquKFw496ODRkCdu8b1eHXWqy8HjocX1q8+r
aRrjJOChaJoFfhHZw0mQGrJaZIa1wAlZwygq7F5gHEwEmeRWbWXh2uzLcz/cqkmO
MT63bOfh
=vJW9
-----END PGP SIGNATURE-----

--UHCCO3m6OlsGWGrZ--
