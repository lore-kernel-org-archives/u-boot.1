Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4C63C4332F
	for <u-boot@archiver.kernel.org>; Sat,  4 Nov 2023 13:58:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C102D86EE0;
	Sat,  4 Nov 2023 14:58:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="YH/3eBwJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7BBE58703A; Sat,  4 Nov 2023 14:57:28 +0100 (CET)
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com
 [IPv6:2607:f8b0:4864:20::730])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8BBEB87037
 for <u-boot@lists.denx.de>; Sat,  4 Nov 2023 14:57:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x730.google.com with SMTP id
 af79cd13be357-77897c4ac1fso175859485a.3
 for <u-boot@lists.denx.de>; Sat, 04 Nov 2023 06:57:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1699106237; x=1699711037; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=i/MTlWOQLymgAWdmmTjVE+zbQa5r6MVK/rRGEoy+hN0=;
 b=YH/3eBwJ9MUrd3GA50kPaArcpykFM/G4h4o0DAkAu5PC6C+9VMp652X3+kgvXy0v3M
 LzdW2qlpI5e/gGA2gOPFP/fCOMYG7oUEywSjp6pcQMCroLvml8P/sGvpDeAJ9EH6V1GB
 bnHfWEAFQWMgKBPRXUW749wTgrw7uGb9KOLnk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699106237; x=1699711037;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=i/MTlWOQLymgAWdmmTjVE+zbQa5r6MVK/rRGEoy+hN0=;
 b=moS2ZlTiPzRPrlZE0l1VFS2XKhSmv1ig74CHLrUGsZvGdGgsqh+OSqzXBGpayzIUtV
 OqdFVgweinNB9SdJfGQwOVw6xnLizVMDrldOC1+58X0sLrS1LqGrCpGY5Zdt42bQY8/8
 odQ6JXRmejC8I9GqnXdPWhrMIQsk/7iLpt/VcRWJa2s0gWu2zCtofErb5GlA/ZIMiEQc
 B9XCiHrRJxBr8uynUnj6HLiTMx79+ygSdczpe7h5GdnQBab4wOuyhRZmxgoWB6UaHe5S
 bBvJBSBJ4P6voAbQq5PufMyAEbKVJqujoVigoMCQ6/1S5YSnc2NlmX/x92CfFHbXNWIr
 zjOA==
X-Gm-Message-State: AOJu0YzNxU9mvCcyhUVEroQx4iFKMHqNBgdbwg4m0InJ/HnmW+RQn0fW
 SARw1hGzYZQtY4FID2D8neAYYPCZBIdoaE4DFtu/zQ==
X-Google-Smtp-Source: AGHT+IFkXvqiwOFd07AgxWGd8YH+SIdCQA1EcZn1TCCn35FZPenlqS+wNhGnjtOK/MZrgD5vKxMJxA==
X-Received: by 2002:a05:620a:290b:b0:778:b559:4744 with SMTP id
 m11-20020a05620a290b00b00778b5594744mr28311092qkp.58.1699106237314; 
 Sat, 04 Nov 2023 06:57:17 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-0000-0000-0000-013d.res6.spectrum.com.
 [2603:6081:7b00:6400::13d]) by smtp.gmail.com with ESMTPSA id
 bs36-20020a05620a472400b00773f008da40sm1593947qkb.125.2023.11.04.06.57.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 04 Nov 2023 06:57:16 -0700 (PDT)
Date: Sat, 4 Nov 2023 09:57:15 -0400
From: Tom Rini <trini@konsulko.com>
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Thierry Reding <treding@nvidia.com>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, u-boot@lists.denx.de
Subject: Re: [PATCH v3 2/2] mmc: tegra: get default-tap and default-trim from
 device tree
Message-ID: <20231104135715.GZ496310@bill-the-cat>
References: <20231003063352.42660-1-clamor95@gmail.com>
 <20231003063352.42660-3-clamor95@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="nczrmGOZObSA/CSN"
Content-Disposition: inline
In-Reply-To: <20231003063352.42660-3-clamor95@gmail.com>
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


--nczrmGOZObSA/CSN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 03, 2023 at 09:33:52AM +0300, Svyatoslav Ryhel wrote:

> Default-tap and default-trim values are used for eMMC setup
> mostly on T114+ devices. As for now, those values are hardcoded
> for T210 and ignored for all other Tegra generations. Fix this
> by passing tap and trim values from dts.
>=20
> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>

Applied to u-boot/master, thanks!

--=20
Tom

--nczrmGOZObSA/CSN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmVGTbsACgkQFHw5/5Y0
tyxtGwwAkE+71jZM5oBXjDrrH6wvz36yvuLaX7QSo0uz0eKkiAubV9aKQqCxDBFx
Hb6Kg5FV8k7CGvaWALbdv1Glhm93Cp++g32zeKYKvBgOqcLXZNUxJAAI7SsDXgoz
9gGyYvq7dUN6sPjHp+gqiZ+iVYNSGmEu8AeQzoS9IJmQbM+dPY6oG2cffjApM5L6
WjHAtWAy5odvR/+nGw4O4o+fn+EJutwXWX3YmVA7I/btON6cDZcYeJxRacS8rlE6
JPxjPmCQYwHS6OLqneBYnWv3x5JPE6wZ5Wgt0uhuMPox0lw1wdWbLuMR21SxgsSc
pOofIgAjBXnhwbRBg5xgxQXsZy0wNrPzK+XhwaCaGTmNEazJ/umtkST8heoZj5Sy
nztTEWtZrwpFPJ5JWLK4uDVWVCWCRxsaXCzO3Ctj0S/+h7zw3WHx8WtFChdHwvc4
kjeVp1Bk/NCKl0wNV9mi5HGM6iswNJcCyR95HWgy+GAjNfGi4s1uZFK63eHVh6Lh
QiN4YJf3
=sjMh
-----END PGP SIGNATURE-----

--nczrmGOZObSA/CSN--
