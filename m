Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97AA7F46C59
	for <u-boot@archiver.kernel.org>; Mon,  6 Apr 2026 16:51:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 27F9E8416F;
	Mon,  6 Apr 2026 18:50:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="WHdEkib5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5DAF083F98; Mon,  6 Apr 2026 16:27:45 +0200 (CEST)
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com
 [IPv6:2607:f8b0:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 26EDD83936
 for <u-boot@lists.denx.de>; Mon,  6 Apr 2026 16:27:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32c.google.com with SMTP id
 46e09a7af769-7dbe437b072so515355a34.2
 for <u-boot@lists.denx.de>; Mon, 06 Apr 2026 07:27:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1775485662; x=1776090462; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=9W9hFBVypTGBDECS3g5ONLr0VI9EAl1V7TGS4Z9P6Ng=;
 b=WHdEkib5I0l4mJeVFxarz0x5q5aEChjtyfGVd4gvThBwULNTUxaIBC3v+ZD7pxevA2
 p8atDDM5BE/fkZk+lIXbfiAsoJzed9qOkoY+WlXh+yFXIQHDbU9DH9AltZxeBh4Q/gju
 hkLmPJwJGnsC+Rfexf2E5VnL8vcNTy32A9uj4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775485662; x=1776090462;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9W9hFBVypTGBDECS3g5ONLr0VI9EAl1V7TGS4Z9P6Ng=;
 b=m9CEXhbDRSS7/J50wq9wOkJ/mmw9NWpAh69cUUMEFh7fyOUQ/v1Gm0W4SqDVpWJhUi
 Ntn4ClfaWoOAeqfRXEBzcr+KEBlkVrV7I0BUz11mdyM21VUsVPKCvJUTAUpG6WzkB7n+
 JeJnfHlBLu+AQrUo7rFM3mkwsjS9ojy3fz1kEUCo1a6QL5TTrT7NRng7Pnt2DL93qD3O
 0WC54TJZBY26P6SDquLlk8R90LeiYR/MKGySgsVEHwabCcL/GGwGyj9ZkV0D6/mOxk7T
 4tvYRxr2+MHZrsLucJOQhI+6CzcRk/58sbQaZsct2SgMFcE1FKu8JmhLtzwpqUdGsdQi
 MQRg==
X-Gm-Message-State: AOJu0YyWr7+tKEKeYkEroA0S7aaLbHzvUqE/5thnFHVIkcnMM76C213s
 aQnZD1fH2VIJPS3z5lh0U1ReQsvfGdzIL7+IIBnOegrqyH/AvvM31dOvzGJKiIlfT8Q=
X-Gm-Gg: AeBDietbNK/Jkj2N9uhU7CeDx534ES8vN57c1R7tMMEzh1eMGCZIN+jSN3vOmlRZbYU
 GE6GqVUUNJOoZr2f1XzaEqZ/6kifAQ3vqlfddUF64UrDDPcIoG/GLodPaP33SfGtvOfjzEyOpm3
 BRMMpZ/O8N8M4tT1LgrFs27DWRrBIkpz5+GGp/6zJTatv5DO8if+AcvXbzNCq38PvEZv8UPrPDY
 t4pnXR3V3tG9hRw+C74fCTfbyRK8ptTKml+hbKBw7XMBEiT55ERjNshQpuxGBZNHCwo6+JesEK6
 hXt7E+IWwdMzTJw/T9b0BgHqou+RzKrp+r/EPD9tkfBnL+IKBCtqopFIYjq0CtFf+KdciNzSpv+
 SmmGjL15ryRrs5oEVzDmhk277Q/lgiK/+gI8P4FconCbxsEfkr+cHjTPwnvU2kF4Exsm69gGvu0
 Ujw27hbpMC1fcybCDB3EzRJSxZwItihPxtGV8H0M/ZnRbBZFBLP8QZH4NGXPfSWR+9G488hSoLD
 wTFwgHP9/pnNHlWIq2MeM4NfPDhTZQl9ZCbm4tR0et0sDfD
X-Received: by 2002:a05:6820:60f:b0:683:4783:3e64 with SMTP id
 006d021491bc7-68347833f0fmr5519167eaf.62.1775485661686; 
 Mon, 06 Apr 2026 07:27:41 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-235.totalplay.net.
 [189.203.97.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-422eb25a55asm11960972fac.10.2026.04.06.07.27.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Apr 2026 07:27:40 -0700 (PDT)
Date: Mon, 6 Apr 2026 08:27:37 -0600
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
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Subject: Re: [PATCH 4/5] mach-snapdragon: support building SPL
Message-ID: <20260406142737.GN41863@bill-the-cat>
References: <20260404-qcom_spl-v1-0-9e6c2ac66587@seznam.cz>
 <20260404-qcom_spl-v1-4-9e6c2ac66587@seznam.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="WHd3HB2uwyBAv0yt"
Content-Disposition: inline
In-Reply-To: <20260404-qcom_spl-v1-4-9e6c2ac66587@seznam.cz>
X-Clacks-Overhead: GNU Terry Pratchett
X-Mailman-Approved-At: Mon, 06 Apr 2026 18:50:36 +0200
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


--WHd3HB2uwyBAv0yt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 04, 2026 at 01:18:19AM +0200, michael.srba@seznam.cz wrote:

> From: Michael Srba <Michael.Srba@seznam.cz>
>=20
> Initially sdm845 support is added, and only usb boot
> is supported for the next stage.
>=20
> Signed-off-by: Michael Srba <Michael.Srba@seznam.cz>
[snip]
> diff --git a/arch/arm/mach-snapdragon/Kconfig b/arch/arm/mach-snapdragon/=
Kconfig
> index 976c0e35fce..938e6ebd8bf 100644
> --- a/arch/arm/mach-snapdragon/Kconfig
> +++ b/arch/arm/mach-snapdragon/Kconfig
> @@ -1,6 +1,24 @@
>  if ARCH_SNAPDRAGON
> =20
> +# SoC specific SRAM addresses
> +
> +# sdm845
> +SDM845_BOOT_IMEM_BASE :=3D 0x14800000
> +SDM845_BOOT_IMEM_SIZE :=3D 0x180000
> +# we may not be able to use the whole BOOT_IMEM depending on the whiteli=
sted regions hardcoded in PBL
> +# (we could technically relocate ourselves after the fact)
> +SDM845_BOOT_IMEM_OFFSET :=3D 0x3f000
> +SDM845_BOOT_IMEM_USABLE_SIZE :=3D 0xc1000
> +# technically the below would work, except the memory from 0x14833000 to=
 0x1483F000 gets trashed
> +# between the ELF getting loaded and XBL_SEC jumping to our code
> +#SDM845_BOOT_IMEM_OFFSET :=3D 0x16000
> +#SDM845_BOOT_IMEM_USABLE_SIZE :=3D 0xea000
> +SDM845_OCIMEM_BASE :=3D 0x14680000
> +SDM845_OCIMEM_SIZE :=3D 0x00040000
> +SDM845_OCIMEM_END  :=3D $(shell, printf "0x%x\n" "$(dollar)(($(SDM845_OC=
IMEM_BASE) + $(SDM845_OCIMEM_SIZE) - 1))")

I didn't know Kconfig even allowed this. And I *really* don't like it,
and I think it's going in the wrong direction with respect to being able
to configure a system. If these are configurable, then they need to be
"hex" type "config" options, and then used later on. Otherwise they
should just be the evaluated value as "default ... if ..." later on,
instead.

[snip]
> +config QCOM_SPL
> +	bool "Enable SPL for Snapdragon SOCs"
> +	select SUPPORT_SPL
> +	select ARMV8_SPL_EXCEPTION_VECTORS
> +	select ENABLE_ARM_SOC_BOOT0_HOOK
> +	select SPL
> +	select SPL_DM
> +	select SPL_DM_GPIO
> +	select SPL_DM_PMIC
> +	select SPL_DM_USB_GADGET
> +	select SPL_ENV_SUPPORT
> +	select SPL_GPIO
> +	select SPL_HAS_BSS_LINKER_SECTION
> +	select SPL_LIBCOMMON_SUPPORT
> +	select SPL_LIBDISK_SUPPORT
> +	select SPL_LIBGENERIC_SUPPORT
> +	select SPL_MMC
> +	select SPL_OF_REAL
> +	select SPL_OF_CONTROL
> +	select SPL_PINCONF
> +	select SPL_PINCTRL
> +	select SPL_PINCTRL_FULL
> +	select SPL_PINCTRL_GENERIC
> +	select SPL_PINCONF_RECURSIVE
> +	select SPL_PINMUX
> +	select SPL_SPRINTF
> +	select SPL_STRTO
> +	select SPL_USB_GADGET

This should be in the appropriate defconfig, or a config fragment if
re-used a lot. Or mirroring other platforms, as part of the stanza for
TARGET_... (or ARCH_...) as needed.

[snip]
> diff --git a/doc/board/qualcomm/spl.rst b/doc/board/qualcomm/spl.rst
> new file mode 100644
> index 00000000000..817c76b659e
> --- /dev/null
> +++ b/doc/board/qualcomm/spl.rst
> @@ -0,0 +1,70 @@
> +.. SPDX-License-Identifier: GPL-2.0+
> +.. sectionauthor:: Michael Srba <Michael.Srba@seznam.cz>
> +
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +Booting U-Boot SPL on Qualcomm SoCs
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +Overview
> +----------

These are style errors that will trip up CI when it builds the docs.
Please run "make htmldocs KDOC_WERROR=3D1" for v2, thanks.

--=20
Tom

--WHd3HB2uwyBAv0yt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCadPC2QAKCRAr4qD1Cr/k
ChhZAP9RUvoZHvhRqQVYHs8PA7awUrOv2OnUszShDGoCB/B/rwEAh51kcEPf6ML8
/AAGZpHeFBc9Daz2E/RPjljsz76WLQY=
=v9l/
-----END PGP SIGNATURE-----

--WHd3HB2uwyBAv0yt--
