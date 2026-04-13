Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 199E1F531CA
	for <u-boot@archiver.kernel.org>; Mon, 13 Apr 2026 21:14:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C849A841A2;
	Mon, 13 Apr 2026 23:13:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Flr0fTy7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D7DFA839DF; Mon, 13 Apr 2026 19:14:05 +0200 (CEST)
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com
 [IPv6:2607:f8b0:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A56678352B
 for <u-boot@lists.denx.de>; Mon, 13 Apr 2026 19:14:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x336.google.com with SMTP id
 46e09a7af769-7dbd08144deso4305525a34.0
 for <u-boot@lists.denx.de>; Mon, 13 Apr 2026 10:14:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1776100442; x=1776705242; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=UGX+FuQSX62GTdeNVwbqbE6TJBBSvPNJEezbTI/41f8=;
 b=Flr0fTy7/7LtSXOWn0UVXc8oKYbgMVOvuUOnkLxq++OdDyrb5AAJb31SLFvhV48Ueo
 vIh8DtjjPDBtrqeE7ge01q6OH2DbH+1FJLC1SRihOWk6pUWLbg4tXN7WPws8yBWZ39f1
 1FNXbcQ65CsLZ1y+jr1P59yYj7mCw2y5Gvxbc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776100442; x=1776705242;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UGX+FuQSX62GTdeNVwbqbE6TJBBSvPNJEezbTI/41f8=;
 b=g8JAN9Re7iHVG7ZX0N4i9XTFTH5A2SRk2hL3x/KEMXPvSwEleXtEAR/DTwN/dp71mm
 gx68JAn9ylp287/a8JG+XkASmW385wBRrlqRaiySLolOcr8hz4SfGLms8/srDAfbr7uG
 zCFeFrrtB8UmuHXwXBqHd68aPhTptJA8VV47qAnbauOhJeNaTE64ySwk0sIjtrKrXBVi
 3ErDZTFeMEaBS5Oxe/K6T43ZYAizkrpGs8i0QZRbjd/TsBl9UcJqwZ78oXnTRJt6qooT
 EsMo6rP4nWlpkYXsTOPH3SpBRhfxpQEOV1HcdJTdrf+SHuh1dpDyyfJECSRnSAe6JQs4
 SijQ==
X-Gm-Message-State: AOJu0YybJIBUauSoCzfCbIO1yzFklKf1ceIN1910fqlejV3PBTzT4E/c
 JyrXmvNttbzI+1ZHujm1GxL6TadY91kyW8kLNLlLoV64UmIZSmJ51FrB2EMbCP7C9Ts=
X-Gm-Gg: AeBDieusQ2I0u3nLd5n1OPbXTgiVhs0kNS6HbTOnyQCzm0m9VgH11RooLKgqZHzxSPe
 FVJrmHMCu/BszuhTOjqcoZpslgjuz27Pso5atQecV3cuIiBOWHx7BZjuQx3yyiWfUyyjPSZ9feb
 /V5BC8mF283UsdUwcxi8eit4u0Qp+v9ul6StbJdacvPA7d4046gbySDrDwHO/hK+UAr82an9zom
 gIc08AmiorhtLEIf2FULqbN5QlDzw0IB55i0zR+dY9q9+PSBgM/HVOwx+PQoSwBHnQc/toma3S6
 iiwrvB3R91juH7EknyKoGNs2Ldc1zjj13iVo7EWSVJTjzlUWg6BXMSc3vwAiZ8GZdnk6eVLiZWH
 9nwZxr7aSeT/DRfYhrMqeakrIrCpWbWW942kpYv5y/7KDNnLNyoxaNDlnlbQ9Djp/k6dLBdoH8/
 HrAl+Z5YTukPqKmyEMLXrQk2TOLhXTSxdBTM8zPmCP3YA0EoNoQSwsSnlqtZJZKlcLoxYdMcHyK
 xWbLJ8vYlftKjxbHygVPf5CFG1c8qNd1U4XTiK/y7hT8GgMrEI=
X-Received: by 2002:a05:6820:f013:b0:68e:1120:d4c0 with SMTP id
 006d021491bc7-68e1120d6demr4214115eaf.15.1776100442272; 
 Mon, 13 Apr 2026 10:14:02 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-68bc82ea711sm5942693eaf.4.2026.04.13.10.13.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Apr 2026 10:14:01 -0700 (PDT)
Date: Mon, 13 Apr 2026 11:13:57 -0600
From: Tom Rini <trini@konsulko.com>
To: michael.srba@seznam.cz
Cc: u-boot@lists.denx.de, Sumit Garg <sumit.garg@kernel.org>,
 u-boot-qcom@groups.io, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, Sughosh Ganu <sughosh.ganu@arm.com>,
 Anshul Dalal <anshuld@ti.com>, Peng Fan <peng.fan@nxp.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Andrew Davis <afd@ti.com>,
 Hrushikesh Salunke <h-salunke@ti.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Ye Li <ye.li@nxp.com>, Andre Przywara <andre.przywara@arm.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>, Dhruva Gole <d-gole@ti.com>,
 Kaustabh Chakraborty <kauschluss@disroot.org>,
 Jerome Forissier <jerome.forissier@arm.com>,
 Heiko Schocher <hs@nabladev.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Lukasz Majewski <lukma@denx.de>,
 Mateusz Kulikowski <mateusz.kulikowski@gmail.com>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Michal Simek <michal.simek@amd.com>, Yao Zi <me@ziyao.cc>,
 Peter Korsgaard <peter@korsgaard.com>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Tingting Meng <tingting.meng@altera.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>,
 Alice Guo <alice.guo@nxp.com>, George Chan <gchan9527@gmail.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 Alexey Charkov <alchark@gmail.com>, Ronald Wahl <ronald.wahl@legrand.com>
Subject: Re: [PATCH v2 03/10] drivers: allow clk_stub and spmi in SPL
Message-ID: <20260413171357.GZ41863@bill-the-cat>
References: <20260411-qcom_spl-v2-0-9609557cf562@seznam.cz>
 <20260411-qcom_spl-v2-3-9609557cf562@seznam.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="eu57DJxPlBOBa/6p"
Content-Disposition: inline
In-Reply-To: <20260411-qcom_spl-v2-3-9609557cf562@seznam.cz>
X-Clacks-Overhead: GNU Terry Pratchett
X-Mailman-Approved-At: Mon, 13 Apr 2026 23:13:56 +0200
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


--eu57DJxPlBOBa/6p
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 11, 2026 at 02:00:08AM +0200, michael.srba@seznam.cz wrote:
> From: Michael Srba <Michael.Srba@seznam.cz>
>=20
> Only Makefile and Kconfig changes necessary.
>=20
> Signed-off-by: Michael Srba <Michael.Srba@seznam.cz>
> ---
>  drivers/Makefile      | 2 +-
>  drivers/clk/Kconfig   | 6 ++++++
>  drivers/spmi/Kconfig  | 6 ++++++
>  drivers/spmi/Makefile | 2 +-
>  4 files changed, 14 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/Makefile b/drivers/Makefile
> index 43d0ba33281..477718ce89a 100644
> --- a/drivers/Makefile
> +++ b/drivers/Makefile
> @@ -35,6 +35,7 @@ obj-$(CONFIG_$(PHASE_)RAM) +=3D ram/
>  obj-$(CONFIG_$(PHASE_)RTC) +=3D rtc/
>  obj-$(CONFIG_$(PHASE_)SERIAL) +=3D serial/
>  obj-$(CONFIG_$(PHASE_)SPI) +=3D spi/
> +obj-$(CONFIG_$(PHASE_)SPMI) +=3D spmi/
>  obj-$(CONFIG_$(PHASE_)TIMER) +=3D timer/
>  obj-$(CONFIG_$(PHASE_)VIRTIO) +=3D virtio/
>  obj-$(CONFIG_$(PHASE_)DM_MAILBOX) +=3D mailbox/
> @@ -106,7 +107,6 @@ obj-$(CONFIG_DM_REBOOT_MODE) +=3D reboot-mode/
>  obj-y +=3D rtc/
>  obj-y +=3D scsi/
>  obj-y +=3D sound/
> -obj-y +=3D spmi/
>  obj-y +=3D watchdog/
>  obj-$(CONFIG_QE) +=3D qe/
>  obj-$(CONFIG_U_QE) +=3D qe/
> diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
> index c2da7b3938b..888ea08cead 100644
> --- a/drivers/clk/Kconfig
> +++ b/drivers/clk/Kconfig
> @@ -114,6 +114,12 @@ config CLK_STUB
>  	  Enable this to provide a stub clock driver for non-essential clock
>  	  controllers.
> =20
> +config SPL_CLK_STUB
> +	bool "Stub clock driver"
> +	depends on SPL_CLK
> +	help
> +	  Enable stub clock driver in SPL
> +
>  config CLK_BCM6345
>  	bool "Clock controller driver for BCM6345"
>  	depends on CLK && ARCH_BMIPS
> diff --git a/drivers/spmi/Kconfig b/drivers/spmi/Kconfig
> index ab4878ebae4..f3d91e0b754 100644
> --- a/drivers/spmi/Kconfig
> +++ b/drivers/spmi/Kconfig
> @@ -8,6 +8,12 @@ config SPMI
>  	  SPMI (System Power Management Interface) bus is used
>  	  to connect PMIC devices on various SoCs.
> =20
> +config SPL_SPMI
> +	bool "Enable SPMI bus support in SPL"
> +	depends on SPL_DM
> +	help
> +	  Select this to enable SPMI bus support in SPL
> +
>  config SPMI_MSM
>  	bool "Support Qualcomm SPMI bus"
>  	depends on SPMI

You need to add SPL_SPMI_MSM here, and then update the Makefile to use
$(PHASE_) as well.

--=20
Tom

--eu57DJxPlBOBa/6p
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCad0kVQAKCRAr4qD1Cr/k
CvMRAQChpDZWXd9HGXKafsYGQUFEs3tBVy7I0K5VXqfJ/4iy+wEA8s7G+JViEZla
8WOiRO7RWTJJ1//dosIErGRM/ToLagc=
=AenQ
-----END PGP SIGNATURE-----

--eu57DJxPlBOBa/6p--
