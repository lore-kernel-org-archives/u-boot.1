Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94109CD8CA4
	for <u-boot@archiver.kernel.org>; Mon,  8 Jun 2026 19:06:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B5DC18405A;
	Mon,  8 Jun 2026 21:06:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="T6o62Zcl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7005384704; Mon,  8 Jun 2026 21:06:22 +0200 (CEST)
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com
 [IPv6:2607:f8b0:4864:20::22f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 177D5807C4
 for <u-boot@lists.denx.de>; Mon,  8 Jun 2026 21:06:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22f.google.com with SMTP id
 5614622812f47-4864aea1316so2497774b6e.2
 for <u-boot@lists.denx.de>; Mon, 08 Jun 2026 12:06:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1780945579; x=1781550379; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=LEHdfq9ZLt5UVJL13OhMAKhSP+TEJsGjwSITKqiyH7o=;
 b=T6o62Zcl64a4doX1IV2nGY+VSGDj/qgNOXqnMozriPpQGTu1dXs4X3qaZ778xHFb6g
 1TypUXO045CaCZ0+0ICR2b6Q1mmv0D1CByNK6ca1wlAprF3WcnZh32TniEisk3pDoVPd
 /k68YaYK+YV1zSlwbYWZby+tet0MMvZ+x6G9E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780945579; x=1781550379;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LEHdfq9ZLt5UVJL13OhMAKhSP+TEJsGjwSITKqiyH7o=;
 b=ZYKzLhx8XDYJIQOr9R2z76tcj67Hq85CgH//U1lCtcOSMyJNCOZSEsHxhY4s5Ar7Hs
 IyWPTUzvlxr1UZhTxU1jzis+TQ5isC6DOcOfG1c0MHofIzausDXZAyU64C19vWGAkxiP
 jwsBWtv6UDPJvSxMCFlLJvSDxPxseeSpT5yr3WrHDc0xyanGoJ8fae4jmrxe8L2cBk59
 70pmVkByXzRXJsQHoibAJtBTvamHBmfeaafKmu7vQ6Pu7fcYlnuobxF7tyedw1U/pzW6
 t4/rnD9LFBaKArXXlXR1PI6B0DWpiO/MK8nGj/BO+C5xnsDhYSJqRApoAxWGZNtEQQBR
 /4+g==
X-Gm-Message-State: AOJu0YwKbFep3YAyBmchs2TTlDjx0+6lY/lbjW9mH4+m+fyFwST0ESFY
 hFEssVeUiI/FnhJPB8JvArlZe7fF/QpTi8DEqThTZnii6NwijqIsKNzva7HdtJyO2BA=
X-Gm-Gg: Acq92OGF41dFHbmOCezlijepsZnGILSDb9VipS8P3lSNUUN8M69OFoW70VQUBpt/Pu1
 vE/O1qgoksS+7UqEHpfEEv5j6n4Lyjg3rRUuOZmMh6I/aE+rWjYjFSDUnoRk76rTvcnV+H/mNZh
 tWukWXLnFtXq/IWUrh8/ZvB1LK0jeHubmKsXRO2RexZCTSfgwQkUKXHtj9D7yy+tUrMOK8hZmKm
 /swFgY1Z8Z9Ler4jTS+bNuVMFp7IjRUzh2ef7RagmMasFO8GZ1Vnb61cZFJWVKi8Bkq28pb4Ip3
 oUKG/vXE/1boRyUj3Eq/OY5O/GVBirJQ6L4I12Joi4sD2jJA4RRAFaiwyQmIsKoOYgSK8IzBmGY
 ATJMKuTJMk5uZKy0U19ZZ7axoo00YGEnBGTWtZfPXYCAwkD4rqFEQnywcqhQZt28CrGISEvpo9S
 4Gufz9D7N2KLqyGStbkoxnpXGeUEdCvAk18UOobR3PLuUBVjtVZ3Ob4Px+h/Dbf8oDOzQGltLKt
 PgG0BCRYmJ+Eh3ddPiC5kXSZZh+LOan75Tmy+6JV7LLwJi4/4fAhRnadhZhJw==
X-Received: by 2002:a05:6808:150d:b0:486:4c2c:63d9 with SMTP id
 5614622812f47-4868de172b2mr10578876b6e.20.1780945578840; 
 Mon, 08 Jun 2026 12:06:18 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4865b9c584csm14870759b6e.17.2026.06.08.12.06.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Jun 2026 12:06:17 -0700 (PDT)
Date: Mon, 8 Jun 2026 13:06:15 -0600
From: Tom Rini <trini@konsulko.com>
To: Raz Ben Yehuda <raz.benyehuda@mobileye.com>
Cc: u-boot@lists.denx.de, Neil Armstrong <neil.armstrong@linaro.org>,
 Bhupesh Sharma <bhupesh.linux@gmail.com>,
 Neha Malcom Francis <n-francis@ti.com>,
 Tawfik Bayouk <tawfik.bayouk@mobileye.com>,
 Vladimir Kondratiev <vladimir.Kondratiev@mobileye.com>
Subject: Re: [PATCH v3 0/5] (no cover subject)
Message-ID: <20260608190615.GP382693@bill-the-cat>
References: <20260608-ufs_tool2-v3-0-a9f181e86229@mobileye.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="JyxYsLdaFk7FLaeR"
Content-Disposition: inline
In-Reply-To: <20260608-ufs_tool2-v3-0-a9f181e86229@mobileye.com>
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


--JyxYsLdaFk7FLaeR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 08, 2026 at 01:33:24PM +0300, Raz Ben Yehuda wrote:

> Changes in v3:
> - remove set_dev_desc command. DeviceDescriptor is not writable=20
> - Beautify the rst document
> - Link to v2: https://patch.msgid.link/20260607-ufs_tool2-v2-0-f79ff26ab1=
8c@mobileye.com
>=20
> ufs: Exted cmd line
>=20
> The UFS command provides utilities for querying, displaying, and modifying
> UFS device configuration and descriptor information. It is commonly used =
to
> configure UFS logical units (LUNs) in U-Boot, allowing storage devices to=
 be
> provisioned and reconfigured as needed.

In addition to the feedback I gave you just now, please see
https://docs.u-boot-project.org/en/latest/develop/ci_testing.html and
put this through CI before v4. I can see the rST will fail, and you
should also make sure it has meaningful examples and renders similar to
https://docs.u-boot-project.org/en/latest/usage/cmd/mmc.html for
example, thanks.

--=20
Tom

--JyxYsLdaFk7FLaeR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaicSpwAKCRAr4qD1Cr/k
CkJSAP46tgSm9aM3LfIMez18zx4VILg6JU/va/Pf3zsJIX2/0QEA3Lgr8f5trNJN
Bvzn2XQKTVwhYun1n5HuRLpue2YKRgc=
=QCr8
-----END PGP SIGNATURE-----

--JyxYsLdaFk7FLaeR--
