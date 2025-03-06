Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B234C282DE
	for <u-boot@archiver.kernel.org>; Thu,  6 Mar 2025 05:58:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9D00C80805;
	Thu,  6 Mar 2025 06:58:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=KARO-electronics.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 75F5980756; Thu,  6 Mar 2025 06:58:23 +0100 (CET)
Received: from dd54918.kasserver.com (dd54918.kasserver.com [85.13.167.58])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2DB0B80756
 for <u-boot@lists.denx.de>; Thu,  6 Mar 2025 06:58:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=KARO-electronics.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=LW@KARO-electronics.de
Received: from karo-electronics.de (unknown [89.1.81.74])
 by dd54918.kasserver.com (Postfix) with ESMTPSA id 8D04E772172F;
 Thu,  6 Mar 2025 06:58:20 +0100 (CET)
Date: Thu, 6 Mar 2025 06:58:20 +0100
From: Lothar =?UTF-8?B?V2HDn21hbm4=?= <LW@KARO-electronics.de>
To: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
Cc: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>, Sean
 Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>, Stefano Babic
 <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>, "NXP i.MX U-Boot
 Team" <uboot-imx@nxp.com>, Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Alice Guo <alice.guo@nxp.com>, marex@denx.de, u-boot@lists.denx.de, Ye Li
 <ye.li@nxp.com>, Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH v7 18/19] imx95_evk: add i.MX95 19x19 EVK board basic
 support
Message-ID: <20250306065820.015094f2@karo-electronics.de>
In-Reply-To: <20250305-imx95-v1-18-286d15acbb8a@oss.nxp.com>
References: <20250305-imx95-v1-0-286d15acbb8a@oss.nxp.com>
 <20250305-imx95-v1-18-286d15acbb8a@oss.nxp.com>
Organization: Ka-Ro electronics GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spamd-Bar: ---
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

Hi,

On Wed, 05 Mar 2025 21:28:30 +0800 Alice Guo (OSS) wrote:
> From: Ye Li <ye.li@nxp.com>
>=20
> This patch adds i.MX95 19x19 EVK board basic support.
>=20
> Messaging unit for EdgeLock Secure Enclave, messaging unit for System
> Manager, uSDHC for SD Card, gpio, lpuart are supported now.
>=20
> Signed-off-by: Ye Li <ye.li@nxp.com>
> Signed-off-by: Alice Guo <alice.guo@nxp.com>
> Reviewed-by: Peng Fan <peng.fan@nxp.com>
> ---
>  arch/arm/dts/imx95-19x19-evk-u-boot.dtsi      |  62 ++++++++++
>  arch/arm/dts/imx95-u-boot.dtsi                | 157 ++++++++++++++++++++=
++++++
>  arch/arm/mach-imx/imx9/Kconfig                |   8 ++
>  arch/arm/mach-imx/imx9/scmi/container.cfg     |  10 ++
>  arch/arm/mach-imx/imx9/scmi/imximage.cfg      |  15 +++
>  board/freescale/imx95_evk/Kconfig             |  12 ++
>  board/freescale/imx95_evk/MAINTAINERS         |   6 +
>  board/freescale/imx95_evk/Makefile            |  11 ++
>  board/freescale/imx95_evk/imx95_19x19_evk.env |  91 +++++++++++++++
>  board/freescale/imx95_evk/imx95_evk.c         |  36 ++++++
>  board/freescale/imx95_evk/spl.c               |  72 ++++++++++++
>  configs/imx95_19x19_evk_defconfig             | 152 ++++++++++++++++++++=
+++++
>  doc/board/nxp/imx95_evk.rst                   | 114 +++++++++++++++++++
>  doc/board/nxp/index.rst                       |   1 +
>  include/configs/imx95_evk.h                   |  24 ++++
>  15 files changed, 771 insertions(+)
>=20
[...]
> diff --git a/arch/arm/dts/imx95-u-boot.dtsi b/arch/arm/dts/imx95-u-boot.d=
tsi
> new file mode 100644
> index 0000000000..b0dcf765a7
> --- /dev/null
> +++ b/arch/arm/dts/imx95-u-boot.dtsi
> @@ -0,0 +1,157 @@
[...]
> +&elemu3 {
> +	compatible =3D "fsl,imx93-mu-s4";
> +	status =3D "okay";
> +	bootph-all;
> +};
> +
'status' should be the LAST property in a node.

> diff --git a/arch/arm/mach-imx/imx9/scmi/container.cfg b/arch/arm/mach-im=
x/imx9/scmi/container.cfg
> new file mode 100644
> index 0000000000..ac5a0a2818
> --- /dev/null
> +++ b/arch/arm/mach-imx/imx9/scmi/container.cfg
> @@ -0,0 +1,10 @@
> +/* SPDX-License-Identifier: GPL-2.0+ */
> +/*
> + * Copyright 2025 NXP
> + */
> +
> +BOOT_FROM SD
> +SOC_TYPE IMX9
> +CONTAINER
> +IMAGE A55 bl31.bin 0x8a200000
> +IMAGE A55 u-boot.bin CONFIG_TEXT_BASE
> \ No newline at end of file
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

> diff --git a/arch/arm/mach-imx/imx9/scmi/imximage.cfg b/arch/arm/mach-imx=
/imx9/scmi/imximage.cfg
> new file mode 100644
> index 0000000000..678d15c99b
> --- /dev/null
> +++ b/arch/arm/mach-imx/imx9/scmi/imximage.cfg
> @@ -0,0 +1,15 @@
> +/* SPDX-License-Identifier: GPL-2.0+ */
> +/*
> + * Copyright 2025 NXP
> + */
> +
> +BOOT_FROM SD
> +SOC_TYPE IMX9
> +APPEND mx95a0-ahab-container.img
> +CONTAINER
> +IMAGE OEI m33-oei-ddrfw.bin 0x1ffc0000
> +HOLD 0x10000
> +IMAGE OEI oei-m33-tcm.bin 0x1ffc0000
> +IMAGE M33 m33_image.bin 0x1ffc0000
> +IMAGE A55 spl/u-boot-spl.bin 0x20480000
> +DUMMY_V2X 0x8b000000
> \ No newline at end of file
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

[...]
> diff --git a/board/freescale/imx95_evk/imx95_19x19_evk.env b/board/freesc=
ale/imx95_evk/imx95_19x19_evk.env
> new file mode 100644
> index 0000000000..becf6c3162
> --- /dev/null
> +++ b/board/freescale/imx95_evk/imx95_19x19_evk.env
> @@ -0,0 +1,91 @@
[...]
> +bsp_bootcmd=3Decho Running BSP bootcmd ...;
> +			mmc dev ${mmcdev}; if mmc rescan; then
> +			if run loadbootscript; then
> +				run bootscript;
> +			else
> +				if test ${sec_boot} =3D yes; then
> +					if run loadcntr; then
> +						run mmcboot;
> +					else run netboot;
> +					fi;
> +				else
> +					if run loadimage; then
> +						run mmcboot;
> +					else run netboot;
> +					fi;
> +				fi;
> +			fi;
> +		fi;
> \ No newline at end of file
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^



Lothar Wa=C3=9Fmann
