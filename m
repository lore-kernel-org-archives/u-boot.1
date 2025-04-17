Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 079D5C369C9
	for <u-boot@archiver.kernel.org>; Thu, 17 Apr 2025 21:41:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8C2F48309E;
	Thu, 17 Apr 2025 23:41:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Nw9W7kDC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F36B4830E9; Thu, 17 Apr 2025 23:41:11 +0200 (CEST)
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com
 [IPv6:2001:4860:4864:20::34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C67C182F5E
 for <u-boot@lists.denx.de>; Thu, 17 Apr 2025 23:41:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x34.google.com with SMTP id
 586e51a60fabf-2c6f27599abso329106fac.2
 for <u-boot@lists.denx.de>; Thu, 17 Apr 2025 14:41:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1744926068; x=1745530868; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Lk75norEyUgujcKgt8gI18RcFwfJtuyYM35CgS2Wuz8=;
 b=Nw9W7kDCSyTEUVhxRI5Qvf8pzoWrnBi7DJ1sFdZSP0I1cJPi0pZMIcUgg5czBGGduH
 8GomYoWKsIk17xb8xdRovOkXkFHFrZm7VPozkHjM2civQYVsdea2xyCSjc2ayU35k+rU
 2JNMlxNQ0Pkq5HwY9fN+5i2+6gM8+S/bcxAww=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744926068; x=1745530868;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Lk75norEyUgujcKgt8gI18RcFwfJtuyYM35CgS2Wuz8=;
 b=bfB4Fb9yMI81OGp3Z0jJ3dA+DXVtd8sQVGSJxPsS+Z+epOvF0/FPpq0LetBt9UeYEB
 8KNY2FlMMFoeyCHHkBuBRlOGcD9gDJ09Qy2eafalDce/X4qJbbB3iym+45rNqYh6KJ9O
 EnK6eQn/i8AcvYfIviH7WD9R19yvEjvq9TjrX9kLvU75PI67a/RKchsZP6GkeBJcyGNf
 TDg9oFRhfj8gTZ5rVtGBOzy0AAFP7CV9kBHwDYnnUCydHG50L3FCJbZ6V1WHtbVnkgCi
 S5OKIbKmoQhsAI22IPdIOi60VgIm1UWsmVDb9PcgH3sQO0uvisqcjkRNBqgEwXkFG25K
 kAaA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUfQy4rNkSRe6cK8dUYxJ87HfNOn+ffbCqShBl8hmdXpsU6lrOFGVm7NwOu61MBjbC3ZS9aH1U=@lists.denx.de
X-Gm-Message-State: AOJu0YyTz4yq+oddASwDpwBLLkKKitlvvSdw9272jFxAEwQ9QY5vNmhS
 dAe7IWen2pZ8FTk04sa5mYRJgjfA7ZelR3aSYz08yNS7GYP8kGQQ4lQm2bhWsaAizDU5vjV7Fju
 H
X-Gm-Gg: ASbGncuqswBqb0w0R/uBb/HzVP2/TL8wgo9KA78hXHDlLK+0b7CTLC9iZ9WXyz4UAxW
 oBivnr13HYtgG08H53mkrBptR4dlaHWbpXgPlUbMK31oPwJupkOgd1wkXG3Ad+lBkxFUskuNEvf
 HIlezlZGAnvkjdfE8j4mgS6E0Q0HZ1h4copRALCaiRB5wIU6JDecipbGhMaO6hFOCgMCUEDOdNr
 ar1OQFbBcDUc5qLg0IGiKdTor/bneqJ1HaOgpuSy4+Ck2EYeCgMTXKiLGXqnYFku/dnBivCaaGT
 6foIeg05x0NkoJDT9LHhXP5ya30TdL6qxJIRccGLAludEsKyteYGENoscx7RPa8YKjn9GbwCQnR
 USu+lefdDKMUf
X-Google-Smtp-Source: AGHT+IEg709fG5wwR3PT6MATFAbcUyUxqQWsZY58r+DFVV9cbhgYkRbOSCe/Q9SG6MgbPD+7LFGfwg==
X-Received: by 2002:a05:6871:d80a:b0:29d:ca24:c044 with SMTP id
 586e51a60fabf-2d52681dc4fmr297936fac.8.1744926068321; 
 Thu, 17 Apr 2025 14:41:08 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2d521849793sm133033fac.50.2025.04.17.14.41.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Apr 2025 14:41:07 -0700 (PDT)
Date: Thu, 17 Apr 2025 15:41:05 -0600
From: Tom Rini <trini@konsulko.com>
To: Judith Mendez <jm@ti.com>
Cc: Vignesh Raghavendra <vigneshr@ti.com>, Bryan Brattlof <bb@ti.com>,
 open list <u-boot@lists.denx.de>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH v2 0/5] More MMC fixes
Message-ID: <20250417214105.GB5495@bill-the-cat>
References: <20250414224357.1555064-1-jm@ti.com>
 <3c374be8-0f1b-425e-abfb-e9485ec08840@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="eP/vvFXXZSQMKsUP"
Content-Disposition: inline
In-Reply-To: <3c374be8-0f1b-425e-abfb-e9485ec08840@ti.com>
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


--eP/vvFXXZSQMKsUP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 17, 2025 at 03:11:18PM -0500, Judith Mendez wrote:
> Hi Tom,
>=20
>=20
> On 4/14/25 5:43 PM, Judith Mendez wrote:
> > This patch series fixes MMC_HS_52 mode in am654_sdhci
> > driver, as well as HIGH_SPEED_ENA and UHS_MODE_SELECT
> > for HS modes.
> >=20
> > Also Disable eMMC HS400 mode for am62px device according
> > to silicon errata i2458 [0] and add TI_COMMON_CMD_OPTIONS
> > to K3 Sitara board a53 defconfigs.
> >=20
>=20
>=20
> Please do not merge this patch series just yet,
> I will be respinning one more time, apologies.

OK, thanks.

--=20
Tom

--eP/vvFXXZSQMKsUP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmgBdWkACgkQFHw5/5Y0
tyydkQv9HjWOxel6groWDp2B8kmTGT0SN3iIVGYcnKe81QRtwGxTzrZ4p+xqYNy+
4F4plQinHD0JimwBk7ludap5tyofoLIciVmXeJZPNghSOARgglkS/ZEWaTWdNrjl
FOmA6eM3pWa5a14fsIgKhgoGAGpHrcNGOHy/dG8a8kxuqu2jcxD3ywqOVGnlvAjk
/R6mbpJEgDEr2Clvh8C8dIRn4sohyjywVAKKxzLvTuVhLlNaxTRhxaLoUCPBtseV
33womd5goflC7MK7M1nGGrGFNglbxjpA9fX+gMcH/Y+3Plc72auUju4esXHUG4Vg
C6GeVSGIYlOZNqyHGb9l7tIHY375f1najdMoDFaMtoCU90cSVHx0A8gXYYdF+8O8
UwllVCCFSipaOGPsGM9Xdb0VrXCy406r2Cj32idhQUhuesdyuHa1CHS3Acm7qYiw
d9A489AxknxrwECAtKOOQzqFlFN5q/9/LciGjavBPwjT6o03XVOXIuq9OUoS2E+w
FgMLSStD
=UXLe
-----END PGP SIGNATURE-----

--eP/vvFXXZSQMKsUP--
