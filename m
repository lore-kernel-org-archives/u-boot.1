Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 662DAC3271E
	for <u-boot@archiver.kernel.org>; Fri,  5 Jul 2024 15:37:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 94A4F88619;
	Fri,  5 Jul 2024 17:37:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="nk5YTpI/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2056D88864; Fri,  5 Jul 2024 17:37:30 +0200 (CEST)
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com
 [IPv6:2001:4860:4864:20::29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A1F2B884A9
 for <u-boot@lists.denx.de>; Fri,  5 Jul 2024 17:37:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x29.google.com with SMTP id
 586e51a60fabf-25e43dda1edso469363fac.0
 for <u-boot@lists.denx.de>; Fri, 05 Jul 2024 08:37:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1720193846; x=1720798646; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=j05qe71fSOf6zemsvqLSfa1IzunraeEVxxaUP7cHqII=;
 b=nk5YTpI/5o/NYjjbKkcTK3yrhIh8cgwBH1FfqfR+cYZsqk2qkSURRYjcr1Gu1O5NCE
 otpC9rAc7KAc1KiFoprUnXGPjaLaf926JDEhvmLmZM6Rnhmo227+9P7tYq7EbOEqqu5y
 1jIaI9hDzojYWzRS7M+61XGRvq+YBWhqpj7Cw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720193846; x=1720798646;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=j05qe71fSOf6zemsvqLSfa1IzunraeEVxxaUP7cHqII=;
 b=ZSjhTK1OJ3Dj2FdBUFgO7L2llcdLc/j2J0F+Mohf80wGU60Mj1y/BhXkmELIam4buk
 M+BSr6KTB+haDeFTHd8TXOjr0yBJhdwuP5c3VG2JTSHYcQskVy4eBVkuEfaUNPvIQdFe
 UHQ2k0MmqN9ZdjbrhGrbUHGLK0bO9LZmymvoOts+LOJhNaWDbi2fZ0/NbTCGfkenZi9M
 LBiK+HwyhPvTl1ZjVdouxlurgtYHi3ESBKm3JLTWJq+xOPSVey73vLzx+V/04qKO1PCQ
 XBRs0Vnc0wSQayxcziAgymu6SmI7Hb/ukHPus/UEeAxKVlo8aPAkSWnAkVy75p4jPktm
 7z0Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCWezwZVPz9grFv8O8Lg8Dd9cr26lbdRz4WroX34TdYaHNhP3P29E342JS0j5YQZaj7zJmht7Ick1VoVba/W69ZdjgxCkA==
X-Gm-Message-State: AOJu0YxmG5DlsW1WvmsIHUcZu3igZ+1VTCwJECaYfh6Ko9I2d9MzUX/r
 Rtq7mlkWeefQ6vdLDksKAygWUrl3QGPaSRQY7XAG7Z0KkwfYSAvU23RM6Lkjdgk=
X-Google-Smtp-Source: AGHT+IFmWt6HYjSeZDjsyTAc0YL7bTGOOoMyDZhK8lyJ+Ok7PTqUiachwKZjAE9UVZDxdbRfBogQ6Q==
X-Received: by 2002:a05:6870:212:b0:254:7f9f:3f21 with SMTP id
 586e51a60fabf-25e2bb801d3mr4528479fac.27.1720193846257; 
 Fri, 05 Jul 2024 08:37:26 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-45.totalplay.net.
 [189.203.97.45]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-25e4c2d1ef3sm234018fac.30.2024.07.05.08.37.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Jul 2024 08:37:24 -0700 (PDT)
Date: Fri, 5 Jul 2024 09:37:21 -0600
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
Subject: Re: [PATCH v3 07/10] configs: am62: Add configs for enabling ETHBOOT
 in R5SPL
Message-ID: <20240705153721.GF38804@bill-the-cat>
References: <20240705045030.1141934-1-c-vankar@ti.com>
 <20240705045030.1141934-8-c-vankar@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="tg36nu/ttDJs1AvL"
Content-Disposition: inline
In-Reply-To: <20240705045030.1141934-8-c-vankar@ti.com>
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


--tg36nu/ttDJs1AvL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 05, 2024 at 10:20:27AM +0530, Chintan Vankar wrote:

> From: Kishon Vijay Abraham I <kishon@ti.com>
>=20
> Add configs for enabling ETHBOOT in R5SPL.
>=20
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> Signed-off-by: Andreas Dannenberg <dannenberg@ti.com>
> Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
> Signed-off-by: Chintan Vankar <c-vankar@ti.com>
> ---
>=20
> Link to v2:
> https://lore.kernel.org/r/20240425120822.2048012-8-c-vankar@ti.com/
>=20
> Changes from v2 to v3:
> - No changes.
>=20
>  configs/am62x_evm_r5_ethboot_defconfig | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
>  create mode 100644 configs/am62x_evm_r5_ethboot_defconfig
>=20
> diff --git a/configs/am62x_evm_r5_ethboot_defconfig b/configs/am62x_evm_r=
5_ethboot_defconfig
> new file mode 100644
> index 0000000000..7b1932b215
> --- /dev/null
> +++ b/configs/am62x_evm_r5_ethboot_defconfig
> @@ -0,0 +1,20 @@
> +#include<configs/am62x_evm_r5_defconfig>
> +
> +CONFIG_SPL_GPIO=3Dy

You need a few other options set in order for buildman to work in this
case, please look at the other #include users.

--=20
Tom

--tg36nu/ttDJs1AvL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmaIEyoACgkQFHw5/5Y0
tywHjAv+LBpYYlR6h9bbUpsNjmMAy66Hst/9uN8ocHBD9OloY9MwaKUhu+fpFTdF
bFhkT3ZksS+JLlDonKEh3ZjSqZbsj/ZMhi0GkGgAU7JFhhyxvv+d6lFEaXz4aqXp
Drl8tkpnIwtYSm4b6RgZXOYMm6GtDqoWlGH8qRUuGExBpACBe65t02gjVZik46/8
atis3uvs/sClXCCINiQNOneWJByQGsgBnSPgIuivFyScGrHBI+QqGFJTPl2wzmco
29wiP7tyGZ59/ykH5C2POSWLQHTQMMSOfN+T0D+pPMBeP0M8sivknzguwyMPdlJI
D7k3DKuaLyMJBAi0zSFSeLBKf8A1+nehY4dvk78qOS5JgBUgHrBVa58FG/jQZxHe
GbX/EU9F8yGkX8JUD9WtTqCj7uqQrBzJ2AiPHMLWl+rkMFK+C9UvfupNcF6Vj6xW
mfGBDd7nwzIw55U3hzX9cb9rNu1JsL+irBDwDfUoLYRgiKrb7yE8JHkSHv2Pk246
OWbNPSNO
=VXfh
-----END PGP SIGNATURE-----

--tg36nu/ttDJs1AvL--
