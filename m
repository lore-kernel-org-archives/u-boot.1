Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68177C3DA42
	for <u-boot@archiver.kernel.org>; Fri,  5 Jul 2024 15:39:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EC7A0884A9;
	Fri,  5 Jul 2024 17:39:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="F0eFJcXy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0CE1888619; Fri,  5 Jul 2024 17:39:26 +0200 (CEST)
Received: from mail-oo1-xc35.google.com (mail-oo1-xc35.google.com
 [IPv6:2607:f8b0:4864:20::c35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9A97388395
 for <u-boot@lists.denx.de>; Fri,  5 Jul 2024 17:39:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc35.google.com with SMTP id
 006d021491bc7-5c661bcb9a0so117353eaf.2
 for <u-boot@lists.denx.de>; Fri, 05 Jul 2024 08:39:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1720193962; x=1720798762; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=ql5MEilqUhYmJ0uo4MgRS3ZeTJi2tXURR5Bcdxd0tjc=;
 b=F0eFJcXyBM6WtaVrba1l7nOwpdMGqCMizBfsBipfu9bC7nhasDH00cg2KrLVLav9mc
 tw/xSMYFoExmGLhx1iiYQt2/0kr6nYp7EZNZNpVwl+/fQA0VhgqlgA6IqPWXDxBcMFTC
 BRCRN82t3N3O0hPl7/OCnvxv8sl+xs+pv/aLA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720193962; x=1720798762;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ql5MEilqUhYmJ0uo4MgRS3ZeTJi2tXURR5Bcdxd0tjc=;
 b=xEAdHod1m6i3eTqQm9Z+OGP/4mwnwyd1uoE0Q/yYSPFrajJay/YKmKzUGHKj0zaUKo
 MFB2d/9HyW2TyCeIZj7XrV4LtqQz45VaNer4CcWQRBF+CHMAHXC0eq5JMkpJ5QT2zWlk
 +tL7ZODp5rUiyNzSEGWUpr5kaI/EbyiOH+l/mXVOScdjvcpyfBh5RffloFtpvAErQei9
 r63jYD3DAKP4TgBuVHEbFZax9zer1VZsVyaMdmaQE9ZHYFkNnaK9HEWjCishkWsfNW6B
 UvBf+ULBjnV6tu2cUdvfyTgMOa3gJsPN+G+OOygyfVWsVRHo4BUI1m0Gu9joSNRWdC0U
 GHig==
X-Forwarded-Encrypted: i=1;
 AJvYcCWoc5396AbxRDN5iCpq3Z0qGb1HH4WY1QMFh1Ayg18gf/nIuQde/e0m9sYh6jP0Bzdbgk8z9ziZ4xz09ejjlBycx+Fl3g==
X-Gm-Message-State: AOJu0YyipKnAqEVpXJf/dytzUPHjyfcDqERchWC77xMKiwW4E/VMWf5K
 9mx8Ti7WCM28N2oO5aaULGikriqsFYRMSev25nm4AK8TOI6CDiJe0I2JcA77Cr0=
X-Google-Smtp-Source: AGHT+IFwlSQyBYmlWWQ8Od/TNEokhARBHnVxaSEsNoo3NogsG0X4OqA7p1tGsaD6SeM4dNFDAC5ddA==
X-Received: by 2002:a4a:a9c3:0:b0:5bd:ae80:865b with SMTP id
 006d021491bc7-5c6470be63dmr5019256eaf.9.1720193961660; 
 Fri, 05 Jul 2024 08:39:21 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-45.totalplay.net.
 [189.203.97.45]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-5c4543b9aeesm1222694eaf.19.2024.07.05.08.39.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Jul 2024 08:39:21 -0700 (PDT)
Date: Fri, 5 Jul 2024 09:39:18 -0600
From: Tom Rini <trini@konsulko.com>
To: Chintan Vankar <c-vankar@ti.com>
Cc: Michal Simek <michal.simek@amd.com>, Bryan Brattlof <bb@ti.com>,
 Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
 Vignesh Raghavendra <vigneshr@ti.com>, Andrew Davis <afd@ti.com>,
 MD Danish Anwar <danishanwar@ti.com>, Udit Kumar <u-kumar1@ti.com>,
 Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
 Andreas Dannenberg <dannenberg@ti.com>,
 Jonas Karlman <jonas@kwiboo.se>, Devarsh Thakkar <devarsht@ti.com>,
 Sean Anderson <seanga2@gmail.com>, Kishon Vijay Abraham I <kishon@ti.com>,
 Nikhil M Jain <n-jain1@ti.com>,
 Joao Paulo Goncalves <joao.goncalves@toradex.com>,
 Wadim Egorov <w.egorov@phytec.de>, Sjoerd Simons <sjoerd@collabora.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Alexander Sverdlin <alexander.sverdlin@siemens.com>,
 Siddharth Vadapalli <s-vadapalli@ti.com>,
 Neha Malcom Francis <n-francis@ti.com>, Dhruva Gole <d-gole@ti.com>,
 Simon Glass <sjg@chromium.org>, Roger Quadros <rogerq@kernel.org>,
 Maxime Ripard <mripard@kernel.org>, Nishanth Menon <nm@ti.com>,
 srk@ti.com, u-boot@lists.denx.de
Subject: Re: [PATCH v3 10/10] arch: arm: dts: k3-am62-sk-u-boot: Add missing
 "bootph-all" property to phy_gmii_sel node
Message-ID: <20240705153918.GJ38804@bill-the-cat>
References: <20240705045030.1141934-1-c-vankar@ti.com>
 <20240705045030.1141934-11-c-vankar@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="v6eMhVd280bs6KuA"
Content-Disposition: inline
In-Reply-To: <20240705045030.1141934-11-c-vankar@ti.com>
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


--v6eMhVd280bs6KuA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 05, 2024 at 10:20:30AM +0530, Chintan Vankar wrote:

> Add "bootph-all" property to CPSW MAC's PHY node phy_gmii_sel.
>=20
> Signed-off-by: Chintan Vankar <c-vankar@ti.com>
> ---
>=20
> Link to v2:
> https://lore.kernel.org/r/20240425120822.2048012-11-c-vankar@ti.com/
>=20
> Changes from v2 to v3:
> - Since "phy_gmii_sel" with "bootph-all" property is merged at upstream
>   Linux for am62x-sk-common with commit "ba50141137fa", this patch can be
>   drop with next DT-Sync.
>=20
>  arch/arm/dts/k3-am625-sk-u-boot.dtsi | 4 ++++
>  1 file changed, 4 insertions(+)

Please use the cherry-pick option to bring this change forward so
there's nothing to do on the next re-sync, thanks.

--=20
Tom

--v6eMhVd280bs6KuA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmaIE6YACgkQFHw5/5Y0
tyx5Rgv+OgSW+Jb2ke8MCui+PMOjmQUgQ2yJxCB+NL7evJYvRcKhH2DQaVmSxFAB
L0630b8Qq6RgHOcaY5GAQG0l+RjwBRXDZZAuZ2kxJEIbrbIk88AC/tsZPortnbTA
noUQ7XxATH55ZCW0JXShDN/9xGW70vfPuta7uKcq8e/5wkSn6HFz/DMja85PC4yj
4ojoAdJaNji/ePgJfIbNPunEuVg0l8myUReZ1cXj/Ej7Vg3Fn2u68nsly1n01aay
uzum96cbDtI54QApZmtUjzKkUCJ3F9AalNV/25FwA4fQHCCGb+rHSp6hrhVcbJ7q
0gRJLgxu05L+A6gkxyjzLViJsY1O4Hzs+5xmlhKKQysgsWI2fwIygcE+IbCyrP/t
r1Ce5T4CydbtEFBPUFGEtGc42x8BOAIPv8zKLZOmTdnxK3vTgvUh/4B95nTa7pjx
gK/+S5IOjfT7V/4fqrbUZ+kV9WVUmREcDQY5GNuwM3Uv7iFl3duJ9244PebD6GQJ
JijbdFRN
=PBdY
-----END PGP SIGNATURE-----

--v6eMhVd280bs6KuA--
