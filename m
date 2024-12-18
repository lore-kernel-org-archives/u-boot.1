Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E36E8E77187
	for <u-boot@archiver.kernel.org>; Wed, 18 Dec 2024 17:40:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9A9AF8031E;
	Wed, 18 Dec 2024 18:40:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="TyQ4HkMB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9EB548030F; Wed, 18 Dec 2024 18:40:09 +0100 (CET)
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com
 [IPv6:2607:f8b0:4864:20::736])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 25250802F2
 for <u-boot@lists.denx.de>; Wed, 18 Dec 2024 18:40:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x736.google.com with SMTP id
 af79cd13be357-7b6f95d2eafso531394785a.3
 for <u-boot@lists.denx.de>; Wed, 18 Dec 2024 09:40:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1734543606; x=1735148406; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=tyzb3hm1b78ifFhKB+ZoObhOOHan7zoagOaCdhkSn6s=;
 b=TyQ4HkMBZKIAVwQ3SlzkQ1beQ+n95pkfUWuUfF0UkaOmA7+nVcKQUEfx4tj0UtR/ei
 9Hp4R6O67UysGCtHo+SaQ66VKhrD+tWdn5dqY6rfrGhgbcnVcQq+CDDVdJF2yW4LiuBG
 H59AD0wtLto+BWpU6DluoMI/FGlpwR1DDLb9U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734543606; x=1735148406;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tyzb3hm1b78ifFhKB+ZoObhOOHan7zoagOaCdhkSn6s=;
 b=sbHPua+HPxtgQOeYF1Ccb7z+20Vo3/PKyIW+U/X9gR5oqO3j+LZ1R6l7Jb/kgbEjuL
 pfJYBRHoLt1a6Dnqt2DvG2lltS4v4Wm/1Ki9V4JpfX9Hssc19o4y+DLiAfR2IKmFZWUm
 eHOz+eTPrQr34n8W0dkfAf88RE2ejxq0iC2CDM20pKS2VMTyXn4GXTUkNN7byn3B2DAZ
 9xsLDk/kvC2G/oMwuCPrnfoF8yp3gFcomdSYQMEUPiQ4gxCUwpaOZs+tYCXg9y7iKfQz
 7J9df8vlOoa0aElgzU7v5M7krfcsEtdx0/XOqvUJ/zfTyY0yxxkiaZ2F2T39QfgWNS1O
 lblg==
X-Gm-Message-State: AOJu0YxrVvXHQjq49diKEPXYFapmAAA0M6QbJ7XZZ9+bevQoBMILPzr1
 jsb8F8jEkzllIIkheVcOlSqBomnHHPpcVBkGwevHFz+YIfgDuCpr0s+bdCB+Xg4T4lo2wNodpE/
 u
X-Gm-Gg: ASbGncvFNm8pCDBFlfknjLQvg020+CroG3szBPBvyohpaNK71uD2BrPQ7QWFXUwwWa6
 0TjOCvsTJZiNOvZKTx2ln3yx60gbEZPDf0cACAhu0xJfz98ZKdDKWmDHuOBBdGytIQM416xnVh7
 +X2vrXS0galr9fdO9N0vmysYLBSJPc2w/qS6NpFHyMFYWPfcuZaP1ZkR+ACefdLh8g7Yl9bgLzH
 K/KKkQPmxzyFJkb7pmINUBvgUYQRTgfqUaC2xIwMdsVMleUAIwBDqwZ
X-Google-Smtp-Source: AGHT+IEwmgKrOm23UwsE6sLgEa7pvvY1op4awczbzigwYBnB2zw1TKbdN0XxVQqLKYsAU7ZppITFdA==
X-Received: by 2002:a05:620a:2950:b0:7b3:5858:1286 with SMTP id
 af79cd13be357-7b8637b7bacmr502654585a.47.1734543606022; 
 Wed, 18 Dec 2024 09:40:06 -0800 (PST)
Received: from bill-the-cat ([187.144.29.192])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b7047eea1asm450488285a.60.2024.12.18.09.40.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Dec 2024 09:40:05 -0800 (PST)
Date: Wed, 18 Dec 2024 11:40:02 -0600
From: Tom Rini <trini@konsulko.com>
To: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Cc: U-Boot-Denx <u-boot@lists.denx.de>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>
Subject: Re: Pull request for u-boot-nand-20241212
Message-ID: <20241218174002.GL1505244@bill-the-cat>
References: <CAOf5uwnqcLbVH6Chd_rKc_Q5aEe0jC+-Z5g_K_nQD8wF+qmDOw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="G7+WgUiWcsSBubh2"
Content-Disposition: inline
In-Reply-To: <CAOf5uwnqcLbVH6Chd_rKc_Q5aEe0jC+-Z5g_K_nQD8wF+qmDOw@mail.gmail.com>
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


--G7+WgUiWcsSBubh2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 15, 2024 at 03:46:22PM +0100, Michael Nazzareno Trimarchi wrote:

> Hi Tom
>=20
> The following changes since commit 9452fb7484118822b878ad445237d111b7b1a2=
8d:
>=20
>   Merge branch 'master' of
> https://source.denx.de/u-boot/custodians/u-boot-sh (2024-12-11
> 12:50:29 -0600)
>=20
> are available in the Git repository at:
>=20
>   git@source.denx.de:u-boot/custodians/u-boot-nand-flash.git
> mike/u-boot-nand-20241212
>=20
> for you to fetch changes up to 65ac40c1e99826b346c5e3b829143902494415e2:
>=20
>   nand: Add a watch command (2024-12-12 19:28:07 +0100)
>=20
> Small addition to uboot-nand. Nothing relevant for now. Anyway
> a nice new command coming from Miquel Raynal and small changes.
>=20
> The patches pass the pipeline CI:
> https://source.denx.de/u-boot/custodians/u-boot-nand-flash/-/pipelines/23=
837
>=20

Applied to u-boot/next, thanks!

--=20
Tom

--G7+WgUiWcsSBubh2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmdjCPIACgkQFHw5/5Y0
tyw9jgv+I5okV95vuh5eGNzFYz+HdAK6a5vtrCT7wLuDcMYeNNbWVDQmvDblPg5F
n5e/2alJF6e8wdBtmBCEONEX9jCuXTPGBQTul2BrU0C5Poe8hLHXcp4yRAzzRo2G
Gu2qgbwZkcZQdX+8Vk10iEpo1rlYxrpCyWtHaPTpoRxZJEM4XXlyuzIhXEOby2TK
pKGlx3EHX+8ztE0s3bS/Gg7PmgTo96wXebFH2UHi/u19O+vZLtv/lE6jRc6fSuoK
F36qU2iFMiXnMf+gcbAbXYz+5tBpEqZTInAFcuSYg/cYfb9SKcWFLX88qxt+uL1k
RSKCXxzCBmZjiHFgkORU+VdeZ9WygAkZeT+TGfa09y3S3Aw+mlUMzNOxyEXLh8Xm
7I5Ytja2glggY+5ihR+Z2Fo7CpxcZshZMeaW9KHj7SKeQbxK6oWX3yeM4+Ft0lH/
cxDI28hdqrM1aQZDyAWT3NliqrTBbIaviURE4D2ZyblbLgvUbL/1V32Io2yen+qG
8yhKDPDg
=jJWy
-----END PGP SIGNATURE-----

--G7+WgUiWcsSBubh2--
