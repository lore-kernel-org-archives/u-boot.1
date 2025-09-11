Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF963CAC587
	for <u-boot@archiver.kernel.org>; Thu, 11 Sep 2025 17:27:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5E2CB833BF;
	Thu, 11 Sep 2025 19:27:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Ik50gyCR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E7EF7833EB; Thu, 11 Sep 2025 19:27:13 +0200 (CEST)
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com
 [IPv6:2001:4860:4864:20::29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B9A0B83390
 for <u-boot@lists.denx.de>; Thu, 11 Sep 2025 19:27:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x29.google.com with SMTP id
 586e51a60fabf-30ccea8a199so778385fac.2
 for <u-boot@lists.denx.de>; Thu, 11 Sep 2025 10:27:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1757611630; x=1758216430; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=pWZ860BIS0dNSjR5lj3MuPjUyzrhAN1AeIhUR5vS3/I=;
 b=Ik50gyCR/Tnla3MfLeblC/KNKmuAOJjWVuQ6H5R7/VD+iA0agkOKVrSnB0zrgmkSep
 PVbC/QIZsaiRIF5QJlE/wC4n6WN8CcaxMnoxfXK3ysPewkHNBaI6RbzC9cHMHVHDeEtb
 AzUGToVHXicLnyv5Flm9KBebVNlKvn//ZwiNs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757611630; x=1758216430;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pWZ860BIS0dNSjR5lj3MuPjUyzrhAN1AeIhUR5vS3/I=;
 b=qkc4qGMp7JQHvHwzBFFOtiRKLPghASxy0VXoTUR/e2zhCDPiL/cdyMOwT7KQ+JBoiM
 13IM4cafR8a97FIv3IKnL1pMBeMJlhz1iPpw6sfNLzvvJd1qyc/fKPpGGfziDDYEa3gl
 i4idb3b04+39JO51lxR9YseRvcIi6CVN/Hhc2NVPTJiFN90VOtZklZJnv0dqwDs2SO+e
 arbW7csoVU+zmnu3hjzvMHzq+P0KkRkf7oD04Vv0BtgpaykyhltKtqY6jqEIByyfgTyp
 NyGVH3GUhfM6/z4U+qK4NKO4h4PedI6tQhvf+SM06jkzGQEfBcQBF6e0KC1u2E5BZj1m
 tPvQ==
X-Gm-Message-State: AOJu0YwIcUiOqi/4kKtSWQQsknAC7pXRDrXTu8D1nlV78RvJHMCmHfNU
 BCHPQsGJozozRIZUBxa2X9JOn9evymlagIyACq4Cut9Wa/p1eQXRLZMoGWIHj7F52Rc=
X-Gm-Gg: ASbGncuLBtdi/z2EezJ5v4mLwZs+IEggc70phRwVmoy5qsE7MD9gBjc/CRiNYSOOtv7
 evjHypiJarqfoMYazGZJTMqS1auucdo/BLaRSg0RF5kNS/iykmiBFyIpv9z+T1e/dOqh85BNDaH
 YpiCB8fsEXNQ+eePzcVjYPEMbzZ95HYH0OjRU+L0hfCtFAB9KrpVcF8uZlj0CYtGD2RM1HvM5OZ
 7VImzZJtdZA4w/FzrEkpQ9rlU0OYuFcsqUaxfIs1FsVDULq6Pqji3qxsu/GDmqrpDsB6F+Iav+A
 eavzv6HKroW3rkpD5Y4gEaJfIi9Lg9ar/db6LbN4kwnD4Tr/VbfI8i2iAMPDw7wvAO6XKmssdrO
 W5ZiF4YZUynVrHHOholKfpgS3Mv2kYN+VtrfKqG+gyBsSUVTUX+E11ap9
X-Google-Smtp-Source: AGHT+IFs2bflL8cBQLgVN92GLCKtFKqE80OPE4P7PlFrPW/cYg4IvBVpA2tPCUtrc+G/k0/ZiLAP6g==
X-Received: by 2002:a05:6870:b907:b0:315:3ef4:eecd with SMTP id
 586e51a60fabf-32e553a280fmr18316fac.17.1757611630496; 
 Thu, 11 Sep 2025 10:27:10 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-32d35edf450sm544722fac.32.2025.09.11.10.27.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Sep 2025 10:27:09 -0700 (PDT)
Date: Thu, 11 Sep 2025 11:27:07 -0600
From: Tom Rini <trini@konsulko.com>
To: Anshul Dalal <anshuld@ti.com>
Cc: u-boot@lists.denx.de, vigneshr@ti.com, afd@ti.com, m-chawdhry@ti.com,
 n-francis@ti.com, b-liu@ti.com, nm@ti.com, bb@ti.com
Subject: Re: [PATCH RFT v1 07/17] spl: ext,fat: cleanup use of
 CONFIG_SPL_LIBCOMMON_SUPPORT
Message-ID: <20250911172707.GX124814@bill-the-cat>
References: <20250911131414.3296697-1-anshuld@ti.com>
 <20250911131414.3296697-8-anshuld@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="c6e1QDiZ1rBNuwT9"
Content-Disposition: inline
In-Reply-To: <20250911131414.3296697-8-anshuld@ti.com>
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


--c6e1QDiZ1rBNuwT9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 11, 2025 at 06:44:03PM +0530, Anshul Dalal wrote:

> Minor cleanup of spl_ext and spl_fat files, removing the outdated
> CONFIG_SPL_LIBCOMMON_SUPPORT symbols similar to the commit 1847129025e0
> ("spl: mmc: Drop checks for CONFIG_SPL_LIBCOMMON_SUPPORT") and adding a
> few extra failure reports.
>=20
> Signed-off-by: Anshul Dalal <anshuld@ti.com>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--c6e1QDiZ1rBNuwT9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaMMGawAKCRAr4qD1Cr/k
CvRfAQCd8dO06lLcNxlPnY9Xbf3eADlBOb5sCG5MuNtXrM9xfwD+I4W8yjlhGAT5
6Qih91Fm+pGNFubcvxA2/Nnnrt5dzQ4=
=cS2K
-----END PGP SIGNATURE-----

--c6e1QDiZ1rBNuwT9--
