Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA598CDB46E
	for <u-boot@archiver.kernel.org>; Thu, 12 Oct 2023 07:44:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F260C86DD6;
	Thu, 12 Oct 2023 09:44:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="NyycMESA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 11E2A86D0C; Thu, 12 Oct 2023 09:44:36 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CF97686E50
 for <u-boot@lists.denx.de>; Thu, 12 Oct 2023 09:44:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1697096668; x=1697701468; i=xypron.glpk@gmx.de;
 bh=cZitO0waR2enEMYX5C1lfCIUUO55Vmw3VH+huHUOSqs=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=NyycMESAdR4nuFMz49YO+EZ6j4mx0lRPVWfXmNOyUBDDuTvfLVr8IxyoyfoNsrG29NNB0JQLWKz
 DHjQAfK41EXWfMPLKdg2VXxmVJEVUccw4B2J4pgLitN8yxWCMwKYGBq5V+gXqme4C34NMVVI+5b6T
 qg3srOdEBP3losdY3EP/qD0k89wb3cJWGAvP165XhagiGQeP7BWhicSjpET+IRurMyF57iHcB2lJv
 W//KVIqLzruDfQaT6K1CdO9KpwVfxF3V62srbFSqotK/Ypj26h0jkCUbbdMVS7OD9s53ODdIXSLVd
 I5PdHKeI4UHWo5b/8qSbyZ7c8e/b77MFs7ug==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.94] ([178.202.40.247]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MRTRN-1rBYXh0PWn-00NPB0; Thu, 12
 Oct 2023 09:44:28 +0200
Message-ID: <4a84d96b-b7e0-477d-833f-8ed3e568d05f@gmx.de>
Date: Thu, 12 Oct 2023 09:44:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/26] arm: imx: Check header before calling
 spl_load_imx_container
Content-Language: en-US, de-DE
To: Sean Anderson <seanga2@gmail.com>
Cc: Harald Seiler <hws@denx.de>, Simon Glass <sjg@chromium.org>,
 uboot-imx@nxp.com, Anatolij Gustschin <agust@denx.de>,
 Fabio Estevam <festevam@gmail.com>, Peng Fan <peng.fan@nxp.com>,
 Stefano Babic <sbabic@denx.de>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de
References: <20231012015626.3487451-1-seanga2@gmail.com>
 <20231012015626.3487451-8-seanga2@gmail.com>
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20231012015626.3487451-8-seanga2@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:bpUXCqiGZcvRgCZPrCuB0XvKQyrgMzQ5LkW4MVRskJesKT/LRs/
 WGTwLzmcLQyeU3A7ONrFvedvgDws/y3CmUAtO8ztjuysGd6DkhLc96K4Zfm+9LAqYBKjPMh
 Bpho21737w8kaT9348uRxaDGoX69TI8f1KYopI2pOo3uh4jYHr4w/cmK2zwHWjgYELFxXQA
 qaLbMrybLoTfRH0QgrVaQ==
UI-OutboundReport: notjunk:1;M01:P0:jE/Jckvs70s=;f6SUmGUxxnCe2VGBtIHMd2nYNPy
 /2OIUA1neaZVtki9m2Vk5rbohclTQ3NDyorCuhkmZODD4/cqxajFtCezppJhXEivTxWIiPuyg
 m7TvhyfY/AwdPPA9HU29HW+4Mq4lHWmQQRTRFWsubA13nupwpUIe+vV4ai89YcZ9Tv3FG7rb1
 XrwTPmd04bO2/S/t6Dsc2cH7XYxBEybpCaMErl6A6ZgdRRDIMq/gSRt3mvaAKxcCkSUalVMTw
 E2MvpbzbDFW1FLEycAcfW7gIstv5eZsLD8fc3U5Hpukd3J5MGY82v78I1ZggLJrOI/Zf86MBL
 LXGyhwg454E1J2xUQUPiFQp8LPNiBCuD+zP3jSohebDVg7KzpnuVKqEttqguE7Fm1j1XSi7HZ
 OK94KVJyUWsvPP9wyCdCnGBS16mKtZrHK2wY/CxlTUbmhOL7avder8U/0USfOYSGNNAeie6I+
 ZqYXEvVG8+g9CphxJ4R0CV9UnFGkp+wn0pcgLw0g4PcTEL45sOqrHXh+NM8Bmvhx6jPVEMUry
 oRcDoSR8/2nd4k4biqHcnW+B8EEjmXZoeCpIYhYJDSKNmw2036iLlqUnaD3g7+7AP+73Dz53b
 uWeI4Bi+7cTvu4DxycNwMoog4U4c6WxfJZbSJJWUiwEtDsdEHfUkD+sxIp3AYlyfQHHQ/mtUN
 oRMbau60+NE7laLlXOqppQBT2cwi1j4b/xEE69h3WYoc49zUG256iA3jGWy52vGjtRE0aTX1Y
 xyhu63TsjZw1VYQwTgSOYyicN1vl/jfpTXDj2h9OxW5moO5A0ptsweCG1/dTnrO6EoR5Kka9v
 x7vKl+BlGJz6kxCbY3NRnddu6nElFGnb0RQw8C5P4P92RS5UlvXhpl0Wv4wm/8E9xng7N4eLP
 /v2djvejWf53X3AQnhNLhYG5KkHRXYWHLwRfwGsrjcGuPWGI/wlk+W/rJHKuPdbTkE2dWNFv5
 Pg/fMm/XUB/TFR4GB0kpoMHaYec=
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

On 10/12/23 03:56, Sean Anderson wrote:
> Make sure we have an IMX header before calling spl_load_imx_container,
> since if we don't it will fail with -ENOENT. This allows us to fall back=
 to
> legacy/raw images if they are also enabled.

Looking at CONFIG_AHAB_BOOT (related to secure boot) we must be sure
that we don't introduce any unsolicited fallback on existing configuration=
s.

Best regards

Heinrich

>
> To avoid too much bloat, Legacy/Raw images are disabled for the four
> configs which only boot from raw MMC.
>
> Future work could include merging imx_container.h with imx8image.h, sinc=
e
> they appear to define mostly the same structures.
>
> Signed-off-by: Sean Anderson <seanga2@gmail.com>
> ---
>
>   MAINTAINERS                                                  | 1 +
>   arch/arm/include/asm/mach-imx/ahab.h                         | 2 +-
>   arch/arm/mach-imx/cmd_dek.c                                  | 4 ++--
>   arch/arm/mach-imx/ele_ahab.c                                 | 2 +-
>   arch/arm/mach-imx/image-container.c                          | 2 +-
>   arch/arm/mach-imx/imx8/ahab.c                                | 2 +-
>   arch/arm/mach-imx/parse-container.c                          | 2 +-
>   arch/arm/mach-imx/spl_imx_romapi.c                           | 5 +++--
>   common/spl/spl_mmc.c                                         | 4 +++-
>   common/spl/spl_nand.c                                        | 4 +++-
>   common/spl/spl_nor.c                                         | 4 +++-
>   common/spl/spl_spi.c                                         | 4 +++-
>   configs/deneb_defconfig                                      | 2 ++
>   configs/giedi_defconfig                                      | 2 ++
>   configs/imx8qm_mek_defconfig                                 | 2 ++
>   configs/imx8qxp_mek_defconfig                                | 2 ++
>   drivers/usb/gadget/f_sdp.c                                   | 4 +++-
>   .../include/asm/mach-imx/image.h =3D> include/imx_container.h  | 0
>   18 files changed, 34 insertions(+), 14 deletions(-)
>   rename arch/arm/include/asm/mach-imx/image.h =3D> include/imx_containe=
r.h (100%)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 7d5d05320c0..35209e73af5 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -300,6 +300,7 @@ F:	arch/arm/include/asm/mach-imx/
>   F:	board/freescale/*mx*/
>   F:	board/freescale/common/
>   F:	drivers/serial/serial_mxc.c
> +F:	include/imx_container.h
>
>   ARM HISILICON
>   M:	Peter Griffin <peter.griffin@linaro.org>
> diff --git a/arch/arm/include/asm/mach-imx/ahab.h b/arch/arm/include/asm=
/mach-imx/ahab.h
> index 4222e3db278..4884f056251 100644
> --- a/arch/arm/include/asm/mach-imx/ahab.h
> +++ b/arch/arm/include/asm/mach-imx/ahab.h
> @@ -6,7 +6,7 @@
>   #ifndef __IMX_AHAB_H__
>   #define __IMX_AHAB_H__
>
> -#include <asm/mach-imx/image.h>
> +#include <imx_container.h>
>
>   int ahab_auth_cntr_hdr(struct container_hdr *container, u16 length);
>   int ahab_auth_release(void);
> diff --git a/arch/arm/mach-imx/cmd_dek.c b/arch/arm/mach-imx/cmd_dek.c
> index 6fa5b41fcd3..2f389dbe8df 100644
> --- a/arch/arm/mach-imx/cmd_dek.c
> +++ b/arch/arm/mach-imx/cmd_dek.c
> @@ -18,12 +18,12 @@
>   #include <mapmem.h>
>   #include <tee.h>
>   #ifdef CONFIG_IMX_SECO_DEK_ENCAP
> +#include <imx_container.h>
>   #include <firmware/imx/sci/sci.h>
> -#include <asm/mach-imx/image.h>
>   #endif
>   #ifdef CONFIG_IMX_ELE_DEK_ENCAP
> +#include <imx_container.h>
>   #include <asm/mach-imx/ele_api.h>
> -#include <asm/mach-imx/image.h>
>   #endif
>
>   #include <cpu_func.h>
> diff --git a/arch/arm/mach-imx/ele_ahab.c b/arch/arm/mach-imx/ele_ahab.c
> index 6a1ad198f89..295c055ad0a 100644
> --- a/arch/arm/mach-imx/ele_ahab.c
> +++ b/arch/arm/mach-imx/ele_ahab.c
> @@ -6,12 +6,12 @@
>   #include <common.h>
>   #include <command.h>
>   #include <errno.h>
> +#include <imx_container.h>
>   #include <asm/io.h>
>   #include <asm/mach-imx/ele_api.h>
>   #include <asm/mach-imx/sys_proto.h>
>   #include <asm/arch-imx/cpu.h>
>   #include <asm/arch/sys_proto.h>
> -#include <asm/mach-imx/image.h>
>   #include <console.h>
>   #include <cpu_func.h>
>   #include <asm/global_data.h>
> diff --git a/arch/arm/mach-imx/image-container.c b/arch/arm/mach-imx/ima=
ge-container.c
> index eff9e0c4597..ebc8021d7cc 100644
> --- a/arch/arm/mach-imx/image-container.c
> +++ b/arch/arm/mach-imx/image-container.c
> @@ -5,6 +5,7 @@
>
>   #include <common.h>
>   #include <errno.h>
> +#include <imx_container.h>
>   #include <log.h>
>   #include <malloc.h>
>   #include <asm/io.h>
> @@ -12,7 +13,6 @@
>   #include <spi_flash.h>
>   #include <spl.h>
>   #include <nand.h>
> -#include <asm/mach-imx/image.h>
>   #include <asm/arch/sys_proto.h>
>   #include <asm/mach-imx/boot_mode.h>
>
> diff --git a/arch/arm/mach-imx/imx8/ahab.c b/arch/arm/mach-imx/imx8/ahab=
.c
> index 44ea63584aa..994becccefd 100644
> --- a/arch/arm/mach-imx/imx8/ahab.c
> +++ b/arch/arm/mach-imx/imx8/ahab.c
> @@ -6,6 +6,7 @@
>   #include <common.h>
>   #include <command.h>
>   #include <errno.h>
> +#include <imx_container.h>
>   #include <log.h>
>   #include <asm/global_data.h>
>   #include <asm/io.h>
> @@ -13,7 +14,6 @@
>   #include <asm/mach-imx/sys_proto.h>
>   #include <asm/arch-imx/cpu.h>
>   #include <asm/arch/sys_proto.h>
> -#include <asm/mach-imx/image.h>
>   #include <console.h>
>   #include <cpu_func.h>
>   #include "u-boot/sha256.h"
> diff --git a/arch/arm/mach-imx/parse-container.c b/arch/arm/mach-imx/par=
se-container.c
> index 0a3d41f411e..126ab7c57a1 100644
> --- a/arch/arm/mach-imx/parse-container.c
> +++ b/arch/arm/mach-imx/parse-container.c
> @@ -6,9 +6,9 @@
>   #include <common.h>
>   #include <stdlib.h>
>   #include <errno.h>
> +#include <imx_container.h>
>   #include <log.h>
>   #include <spl.h>
> -#include <asm/mach-imx/image.h>
>   #ifdef CONFIG_AHAB_BOOT
>   #include <asm/mach-imx/ahab.h>
>   #endif
> diff --git a/arch/arm/mach-imx/spl_imx_romapi.c b/arch/arm/mach-imx/spl_=
imx_romapi.c
> index b51061b987b..8816566b364 100644
> --- a/arch/arm/mach-imx/spl_imx_romapi.c
> +++ b/arch/arm/mach-imx/spl_imx_romapi.c
> @@ -6,11 +6,11 @@
>   #include <common.h>
>   #include <errno.h>
>   #include <image.h>
> +#include <imx_container.h>
>   #include <log.h>
>   #include <asm/global_data.h>
>   #include <linux/libfdt.h>
>   #include <spl.h>
> -#include <asm/mach-imx/image.h>
>   #include <asm/arch/sys_proto.h>
>
>   DECLARE_GLOBAL_DATA_PTR;
> @@ -111,7 +111,8 @@ static int spl_romapi_load_image_seekable(struct spl=
_image_info *spl_image,
>   		load.read =3D spl_romapi_read_seekable;
>   		load.priv =3D &pagesize;
>   		return spl_load_simple_fit(spl_image, &load, offset / pagesize, head=
er);
> -	} else if (IS_ENABLED(CONFIG_SPL_LOAD_IMX_CONTAINER)) {
> +	} else if (IS_ENABLED(CONFIG_SPL_LOAD_IMX_CONTAINER) &&
> +		   valid_container_hdr((void *)header)) {
>   		struct spl_load_info load;
>
>   		memset(&load, 0, sizeof(load));
> diff --git a/common/spl/spl_mmc.c b/common/spl/spl_mmc.c
> index 02ad32a23e0..67c7ae34a58 100644
> --- a/common/spl/spl_mmc.c
> +++ b/common/spl/spl_mmc.c
> @@ -16,6 +16,7 @@
>   #include <errno.h>
>   #include <mmc.h>
>   #include <image.h>
> +#include <imx_container.h>
>
>   static int mmc_load_legacy(struct spl_image_info *spl_image,
>   			   struct spl_boot_device *bootdev,
> @@ -108,7 +109,8 @@ int mmc_load_image_raw_sector(struct spl_image_info =
*spl_image,
>   		load.bl_len =3D mmc->read_bl_len;
>   		load.read =3D h_spl_load_read;
>   		ret =3D spl_load_simple_fit(spl_image, &load, sector, header);
> -	} else if (IS_ENABLED(CONFIG_SPL_LOAD_IMX_CONTAINER)) {
> +	} else if (IS_ENABLED(CONFIG_SPL_LOAD_IMX_CONTAINER) &&
> +		   valid_container_hdr((void *)header)) {
>   		struct spl_load_info load;
>
>   		load.dev =3D mmc;
> diff --git a/common/spl/spl_nand.c b/common/spl/spl_nand.c
> index 6cc34004f49..07916bedbb9 100644
> --- a/common/spl/spl_nand.c
> +++ b/common/spl/spl_nand.c
> @@ -7,6 +7,7 @@
>   #include <config.h>
>   #include <fdt_support.h>
>   #include <image.h>
> +#include <imx_container.h>
>   #include <log.h>
>   #include <spl.h>
>   #include <asm/io.h>
> @@ -99,7 +100,8 @@ static int spl_nand_load_element(struct spl_image_inf=
o *spl_image,
>   		load.bl_len =3D bl_len;
>   		load.read =3D spl_nand_fit_read;
>   		return spl_load_simple_fit(spl_image, &load, offset / bl_len, header=
);
> -	} else if (IS_ENABLED(CONFIG_SPL_LOAD_IMX_CONTAINER)) {
> +	} else if (IS_ENABLED(CONFIG_SPL_LOAD_IMX_CONTAINER) &&
> +		   valid_container_hdr((void *)header)) {
>   		struct spl_load_info load;
>
>   		load.dev =3D NULL;
> diff --git a/common/spl/spl_nor.c b/common/spl/spl_nor.c
> index c141a9ae629..dd447982071 100644
> --- a/common/spl/spl_nor.c
> +++ b/common/spl/spl_nor.c
> @@ -5,6 +5,7 @@
>
>   #include <common.h>
>   #include <image.h>
> +#include <imx_container.h>
>   #include <log.h>
>   #include <spl.h>
>
> @@ -102,7 +103,8 @@ static int spl_nor_load_image(struct spl_image_info =
*spl_image,
>   					   (void *)header);
>   	}
>   #endif
> -	if (IS_ENABLED(CONFIG_SPL_LOAD_IMX_CONTAINER)) {
> +	if (IS_ENABLED(CONFIG_SPL_LOAD_IMX_CONTAINER) &&
> +	    valid_container_hdr((void *)header)) {
>   		load.bl_len =3D 1;
>   		load.read =3D spl_nor_load_read;
>   		return spl_load_imx_container(spl_image, &load,
> diff --git a/common/spl/spl_spi.c b/common/spl/spl_spi.c
> index d69069a75bf..1427c9478c0 100644
> --- a/common/spl/spl_spi.c
> +++ b/common/spl/spl_spi.c
> @@ -10,6 +10,7 @@
>
>   #include <common.h>
>   #include <image.h>
> +#include <imx_container.h>
>   #include <log.h>
>   #include <spi.h>
>   #include <spi_flash.h>
> @@ -153,7 +154,8 @@ static int spl_spi_load_image(struct spl_image_info =
*spl_image,
>   			err =3D spl_load_simple_fit(spl_image, &load,
>   						  payload_offs,
>   						  header);
> -		} else if (IS_ENABLED(CONFIG_SPL_LOAD_IMX_CONTAINER)) {
> +		} else if (IS_ENABLED(CONFIG_SPL_LOAD_IMX_CONTAINER) &&
> +			   valid_container_hdr((void *)header)) {
>   			struct spl_load_info load;
>
>   			load.dev =3D flash;
> diff --git a/configs/deneb_defconfig b/configs/deneb_defconfig
> index 82869e4e0f9..ee2478aa0bb 100644
> --- a/configs/deneb_defconfig
> +++ b/configs/deneb_defconfig
> @@ -44,6 +44,8 @@ CONFIG_SPL_HAS_BSS_LINKER_SECTION=3Dy
>   CONFIG_SPL_BSS_START_ADDR=3D0x128000
>   CONFIG_SPL_BSS_MAX_SIZE=3D0x1000
>   CONFIG_SPL_BOARD_INIT=3Dy
> +# CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
> +# CONFIG_SPL_LEGACY_IMAGE_FORMAT is not set
>   CONFIG_SPL_SYS_MALLOC_SIMPLE=3Dy
>   # CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
>   CONFIG_SPL_SYS_MALLOC=3Dy
> diff --git a/configs/giedi_defconfig b/configs/giedi_defconfig
> index b56b736c436..5e403c90c8c 100644
> --- a/configs/giedi_defconfig
> +++ b/configs/giedi_defconfig
> @@ -44,6 +44,8 @@ CONFIG_SPL_HAS_BSS_LINKER_SECTION=3Dy
>   CONFIG_SPL_BSS_START_ADDR=3D0x128000
>   CONFIG_SPL_BSS_MAX_SIZE=3D0x1000
>   CONFIG_SPL_BOARD_INIT=3Dy
> +# CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
> +# CONFIG_SPL_LEGACY_IMAGE_FORMAT is not set
>   CONFIG_SPL_SYS_MALLOC_SIMPLE=3Dy
>   # CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
>   CONFIG_SPL_SYS_MALLOC=3Dy
> diff --git a/configs/imx8qm_mek_defconfig b/configs/imx8qm_mek_defconfig
> index b9083b0453f..4c5206306ee 100644
> --- a/configs/imx8qm_mek_defconfig
> +++ b/configs/imx8qm_mek_defconfig
> @@ -38,6 +38,8 @@ CONFIG_SPL_HAS_BSS_LINKER_SECTION=3Dy
>   CONFIG_SPL_BSS_START_ADDR=3D0x128000
>   CONFIG_SPL_BSS_MAX_SIZE=3D0x1000
>   CONFIG_SPL_BOARD_INIT=3Dy
> +# CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
> +# CONFIG_SPL_LEGACY_IMAGE_FORMAT is not set
>   CONFIG_SPL_SYS_MALLOC_SIMPLE=3Dy
>   # CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
>   CONFIG_SPL_SYS_MALLOC=3Dy
> diff --git a/configs/imx8qxp_mek_defconfig b/configs/imx8qxp_mek_defconf=
ig
> index f516b0b5557..f312d3945fb 100644
> --- a/configs/imx8qxp_mek_defconfig
> +++ b/configs/imx8qxp_mek_defconfig
> @@ -38,6 +38,8 @@ CONFIG_SPL_HAS_BSS_LINKER_SECTION=3Dy
>   CONFIG_SPL_BSS_START_ADDR=3D0x128000
>   CONFIG_SPL_BSS_MAX_SIZE=3D0x1000
>   CONFIG_SPL_BOARD_INIT=3Dy
> +# CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
> +# CONFIG_SPL_LEGACY_IMAGE_FORMAT is not set
>   CONFIG_SPL_SYS_MALLOC_SIMPLE=3Dy
>   # CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
>   CONFIG_SPL_SYS_MALLOC=3Dy
> diff --git a/drivers/usb/gadget/f_sdp.c b/drivers/usb/gadget/f_sdp.c
> index 2b3a9c5fd4c..ee9384fb37e 100644
> --- a/drivers/usb/gadget/f_sdp.c
> +++ b/drivers/usb/gadget/f_sdp.c
> @@ -34,6 +34,7 @@
>   #include <spl.h>
>   #include <image.h>
>   #include <imximage.h>
> +#include <imx_container.h>
>   #include <watchdog.h>
>
>   #define HID_REPORT_ID_MASK	0x000000ff
> @@ -852,7 +853,8 @@ static int sdp_handle_in_ep(struct spl_image_info *s=
pl_image,
>   				return SDP_EXIT;
>   			}
>   #endif
> -			if (IS_ENABLED(CONFIG_SPL_LOAD_IMX_CONTAINER)) {
> +			if (IS_ENABLED(CONFIG_SPL_LOAD_IMX_CONTAINER) &&
> +			    valid_container_hdr((void *)header)) {
>   				struct spl_load_info load;
>
>   				load.dev =3D header;
> diff --git a/arch/arm/include/asm/mach-imx/image.h b/include/imx_contain=
er.h
> similarity index 100%
> rename from arch/arm/include/asm/mach-imx/image.h
> rename to include/imx_container.h

