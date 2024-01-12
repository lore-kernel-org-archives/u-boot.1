Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F94FC4706C
	for <u-boot@archiver.kernel.org>; Fri, 12 Jan 2024 13:47:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DE8AA87A98;
	Fri, 12 Jan 2024 14:46:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="cNOQ06SY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F2C378794F; Fri, 12 Jan 2024 14:46:35 +0100 (CET)
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com
 [IPv6:2607:f8b0:4864:20::1133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9678F87AD3
 for <u-boot@lists.denx.de>; Fri, 12 Jan 2024 14:46:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1133.google.com with SMTP id
 00721157ae682-5e86fc3f1e2so58092437b3.0
 for <u-boot@lists.denx.de>; Fri, 12 Jan 2024 05:46:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1705067192; x=1705671992; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=zTrX+d93FlTTUjCb0iDVrMizYMFwLjwJ0WpEWpJeJPA=;
 b=cNOQ06SYOBaY0mXHU93P0CPCvkH/OPcUz5mSS9b5CiuY6ZrZ910Bes7tjiLS1J635+
 PIAv/kYYL5yyWfm6GHnx78DL1Y95DQ3dP73TVqOoKwP+kgvsek8WQUw9y2kbWWG1AAhP
 9H/t9ChlOjzW49vLl90qV41Q0Zr3MlnBSpFdY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705067192; x=1705671992;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zTrX+d93FlTTUjCb0iDVrMizYMFwLjwJ0WpEWpJeJPA=;
 b=VjBXVE/yhuitnVn316suPmdM/da5iGcPtKi8L3fuUA5GiQiCFryP968Cr9ou5behXF
 hVj8yiyw/DB2PKPy1ckCddLLdevhs1LPVl9QKT8SNPCpV82SX868OLj/1GLJZYLerV0b
 Q+RQGTKpv/6nb2HA5L2G4cJCfmgQl7cPHiQSDQ1JuW9y6U/vB9GKng8KqE5zFwR3QT1v
 H7lQuE9DztNkVztkTI1oEsN2k0odm5oWPPJ2ZZ3P/ULOUQOYtJ4dpmVqmC/+t1F4D+EY
 VccJ0LYyhSoKVdHcbgrQdLCZErESi+ShDTgavcE9KcLljrn5TCtReB5davjLdZiKzn6c
 y5CQ==
X-Gm-Message-State: AOJu0Yys0KFt38F2HRaU9+Ah8weGeYmX10tuiaxjz+sSzT+poI/9jHwW
 uO3Z83pq/e4RSKG67TnXBhraMZtVBzPaGQ==
X-Google-Smtp-Source: AGHT+IEPzsdM16w86D1dbehcFUe9Bz8azudeC25vwtRETKCvOdgmiO3X1/C5IdkNWtI/JnN4hkuPtA==
X-Received: by 2002:a81:b659:0:b0:5d7:1941:aad with SMTP id
 h25-20020a81b659000000b005d719410aadmr1207673ywk.72.1705067192329; 
 Fri, 12 Jan 2024 05:46:32 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-3119-0000-0000-0000-1002.res6.spectrum.com.
 [2603:6081:7b00:3119::1002]) by smtp.gmail.com with ESMTPSA id
 u14-20020a81a50e000000b005e7535a3303sm1313843ywg.91.2024.01.12.05.46.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Jan 2024 05:46:31 -0800 (PST)
Date: Fri, 12 Jan 2024 08:46:30 -0500
From: Tom Rini <trini@konsulko.com>
To: Alexander Dahl <ada@thorsis.com>
Cc: u-boot@lists.denx.de, Stefan Roese <sr@denx.de>,
 Simon Glass <sjg@chromium.org>, Marek Vasut <marex@denx.de>,
 Paul-Erwan Rio <paulerwan.rio@gmail.com>, Terry Lv <terry.lv@nxp.com>
Subject: Re: [PATCH v3 1/2] tools: kwbimage: Allow disabling build on
 non-mvebu platforms
Message-ID: <20240112134630.GW1610741@bill-the-cat>
References: <20231221072611.11479-1-ada@thorsis.com>
 <20231221072611.11479-2-ada@thorsis.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="YNa30eVDLBsuL+yf"
Content-Disposition: inline
In-Reply-To: <20231221072611.11479-2-ada@thorsis.com>
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


--YNa30eVDLBsuL+yf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 21, 2023 at 08:26:10AM +0100, Alexander Dahl wrote:

> Some users want to build with CONFIG_TOOLS_LIBCRYPTO disabled, which in
> general is possible for at least some boards.  32-bit mvebu however
> requires kwbimage for building SPL, and kwbimage has a hard dependency
> to host OpenSSL.
>=20
> The new symbol CONFIG_TOOLS_KWBIMAGE allows disabling kwbimage build on
> non-mvebu platforms, and thus building without host libcrypto from
> OpenSSL.
>=20
> Based on previous work and discussions, see links below.
>=20
> Link: https://lore.kernel.org/u-boot/20211021093304.25399-1-pali@kernel.o=
rg/
> Link: https://lore.kernel.org/u-boot/20220111153120.1276641-1-marex@denx.=
de/
> Link: https://lore.kernel.org/u-boot/20230121154743.667253-2-paulerwan.ri=
o@gmail.com/
> Cc: Marek Vasut <marex@denx.de>
> Cc: Paul-Erwan Rio <paulerwan.rio@gmail.com>
> Signed-off-by: Alexander Dahl <ada@thorsis.com>
> Reviewed-by: Simon Glass <sjg@chromium.org>

Applied to u-boot/master, thanks!

--=20
Tom

--YNa30eVDLBsuL+yf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGyBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmWhQrYACgkQFHw5/5Y0
tyzpdgv3UNbScHQICV9UJYxf4cOZPWOKEdHiIPuQN1iUAz2t5TEYnt7O0cMuVN3u
T3+chN8oPW0Ciy5rtSzuweIfXqk8BuodPLglVphs4xXweOD1RD8I16NypoRRGZpY
s+1iMuwIguaPx3SulHQVHB7l0kgBvkoC+Oq+t3vqhodOZEVrQJkx6GD6OIyoz2pJ
wuz3jeWUU5Q6hbUpcrkIs7c8TRuRwTlepP1rvRnadTrMAt9YAFXYcdcNhcbfPMOa
sJqMwPqLiGqhT0XHSW4riMmz/rU1pVOsBHE54hiI4U8qz2KQc1ypjt1/qyVWkHia
ZKmaPsILzZt6WBY+vJySNp+U0LsaHBJzWOeWFXKt3ylRQGqfq5mDQUyKu0kc8w6D
qkVWR2/Z9wwcE28X4oRMhWO1Ijy+VH99sYa1tT4syUB0lGPE+ZTUr4fpLqvxvDXk
MIWn2b4tpJ2yKATFmv+AxK07TzXP6VsMg4cchPeA8WgfSKuMefm85w5sAc8MTXS4
eVQ9zh0=
=VY5f
-----END PGP SIGNATURE-----

--YNa30eVDLBsuL+yf--
