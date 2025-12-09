Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE478D3B999
	for <u-boot@archiver.kernel.org>; Tue,  9 Dec 2025 21:38:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0D90183C6C;
	Tue,  9 Dec 2025 22:38:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=valla.it
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=antispam.mailspamprotection.com header.i=@antispam.mailspamprotection.com header.b="MW5zFSXb";
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=valla.it header.i=@valla.it header.b="nj7QJMeE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5800D83C8C; Tue,  9 Dec 2025 22:38:05 +0100 (CET)
Received: from delivery.antispam.mailspamprotection.com
 (delivery.antispam.mailspamprotection.com [185.56.87.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 676F483C08
 for <u-boot@lists.denx.de>; Tue,  9 Dec 2025 22:38:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=valla.it
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=francesco@valla.it
ARC-Seal: i=1; cv=none; a=rsa-sha256;
 d=outgoing.instance-europe-west4-5z1r.prod.antispam.mailspamprotection.com;
 s=arckey; t=1765316282; 
 b=KQBTJXkFqsE2dqEYrDUPEidwG1xFKHEbk4TMlln7pU3PYc3xrziYg/0NnSJqKmkB+YweJCZ+6D
 QnSvSQYDUn/MstEkaAl7HkG5v1nbiVd8YIp+sgr8Vrh63PmjsnHf4IV0pS2uQ0dP50rUzCkKmP
 25gdDZ2bKAV10QdMmRK0h0sDKhmtNmOcsI31TJWuu3MFrfml9uLoJ1jl1uT8D875+/ryRFHluN
 FjiJ48W3PryLLg1pucajHAHzg+Lr55q2b9xx/H7py/muhbj3ql6mdc16OicZSe/cKmUyir81m+
 +bv1m3HU40XWmq1y9aZ7hcNsVHmHFAGfmYqRPH1xDqFGRQ==;
ARC-Authentication-Results: i=1;
 outgoing.instance-europe-west4-5z1r.prod.antispam.mailspamprotection.com;
 smtp.remote-ip=35.214.173.214; 
 iprev=pass (214.173.214.35.bc.googleusercontent.com)
 smtp.remote-ip=35.214.173.214; 
 auth=pass (LOGIN) smtp.auth=esm19.siteground.biz;
 dkim=pass header.d=valla.it header.s=default header.a=rsa-sha256;
 arc=none
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed;
 d=outgoing.instance-europe-west4-5z1r.prod.antispam.mailspamprotection.com;
 s=arckey; t=1765316282; 
 bh=xcF/iY9wUgnRgCQMditHxY2ijFyaOF/rvtgimEyX8e0=;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:
 From:Date:DKIM-Signature:DKIM-Signature;
 b=v9SGoyjAwNQxFMPB/FIV/puoxR7hU4A1KRhajH2nwmU1Qu60cFYr05W+mfT5QQycZYYHdNuB7o
 wjFGYOPlbskC68phTVjn/OilcGnc3WN4a0fOt8soGTA4HzkjtIciYPUdT3vYaK45EjLKE8jxj7
 cWDQZ7VNyBzYL/g6C4v3VeCbsD7iiiKRB91UvYH0isgxeS3QTzN6t8S/pNoSO3L7THhHEAsWJs
 q2CyD4npCJnAWzxk3AGvbTsV+WdSHxclsArgIVsEEHvpW8SjeteWRY0RhQi9byBFZQbah3cmSY
 sPvJce38n4E0ucP840bKXyK1SM+z9f0DTdGI20aTANTz/w==;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=antispam.mailspamprotection.com; s=default; h=CFBL-Feedback-ID:CFBL-Address
 :Content-Type:MIME-Version:Message-ID:Subject:Cc:To:From:Date:Reply-To:
 List-Unsubscribe:Content-Transfer-Encoding;
 bh=+cxUlF/Y7o1AIaazPwue9iGZcmqQuFYI3giMKjjU3j4=; b=MW5zFSXbVAFjKUV0h4W+lRnAFV
 98qsyxmDtldyGXsEruMKqlEfR9qZv7QJjFSN/fiXqYETFz4jLprU43bs7KsvxTXD/tAI6JVf3bCzn
 L6UcJ9yjzq2pgqJKIaOt0fGWnmBCcGge6mp42MbFP5BDqKbZWBCxaDOUkD1U0iWsH07g=;
Received: from 214.173.214.35.bc.googleusercontent.com ([35.214.173.214]
 helo=esm19.siteground.biz)
 by instance-europe-west4-5z1r.prod.antispam.mailspamprotection.com with
 esmtpsa (TLS1.3) tls TLS_AES_256_GCM_SHA384 (Exim 4.98.1)
 (envelope-from <francesco@valla.it>) id 1vT5PC-000000024ii-2jXB
 for u-boot@lists.denx.de; Tue, 09 Dec 2025 21:38:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=valla.it;
 s=default; h=Subject:Cc:To:From:Date:list-help:list-unsubscribe:
 list-subscribe:list-post:list-owner:list-archive;
 bh=+cxUlF/Y7o1AIaazPwue9iGZcmqQuFYI3giMKjjU3j4=; b=nj7QJMeEHLBnF1lvmef/vDB9W6
 yeKW9U8vAR6EWeJCT+TT+pBZrKNs9um+ZUxwb4qr3oxJr+hpMkFXzjwfnCb7CpXJpBv8voP39uMj1
 4oSTaKkKn5reMLGUUz10N2uw1fGXPRSz3XQjRxKkeGKEjcKBh9EzOvM6CBg2bZvVOYPA=;
Received: from [79.56.45.247] (port=64384 helo=bywater)
 by esm19.siteground.biz with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.98.1) (envelope-from <francesco@valla.it>)
 id 1vT5P7-0000000062i-0CBq; Tue, 09 Dec 2025 21:37:53 +0000
Date: Tue, 9 Dec 2025 22:37:51 +0100
From: Francesco Valla <francesco@valla.it>
To: Joseph Guo <qijian.guo@nxp.com>
Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.denx.de,
 Stefano Babic <sbabic@nabladev.com>,
 Fabio Estevam <festevam@gmail.com>, Tom Rini <trini@konsulko.com>,
 Peng Fan <peng.fan@nxp.com>,
 Sumit Garg <sumit.garg@oss.qualcomm.com>, Ye Li <ye.li@nxp.com>,
 Alice Guo <alice.guo@nxp.com>, Adam Ford <aford173@gmail.com>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Simon Glass <sjg@chromium.org>,
 Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>,
 Jacky Bai <ping.bai@nxp.com>, Joseph Guo <qijian.guo@oss.nxp.com>,
 Justin Jiang <justin.jiang@nxp.com>
Subject: Re: [PATCH v3 2/2] imx: Support i.MX91 11x11 FRDM board
Message-ID: <aTiWrz0RMo7umwbQ@bywater>
References: <20251209-imx91_frdm-v3-0-02303eb0c1c3@nxp.com>
 <20251209-imx91_frdm-v3-2-02303eb0c1c3@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251209-imx91_frdm-v3-2-02303eb0c1c3@nxp.com>
X-AntiAbuse: This header was added to track abuse,
 please include it with any abuse report
X-AntiAbuse: Primary Hostname - esm19.siteground.biz
X-AntiAbuse: Original Domain - lists.denx.de
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - valla.it
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-SGantispam-id: 5f987ec0e98e9c0c75fdc87f2921829f
AntiSpam-DLS: false
AntiSpam-DLSP: 
AntiSpam-DLSRS: 
AntiSpam-TS: 1.0
CFBL-Address: feedback@antispam.mailspamprotection.com; report=arf
CFBL-Feedback-ID: 1vT5PC-000000024ii-2jXB-feedback@antispam.mailspamprotection.com
Authentication-Results: outgoing.instance-europe-west4-5z1r.prod.antispam.mailspamprotection.com; 
 iprev=pass (214.173.214.35.bc.googleusercontent.com)
 smtp.remote-ip=35.214.173.214; 
 auth=pass (LOGIN) smtp.auth=esm19.siteground.biz;
 dkim=pass header.d=valla.it header.s=default header.a=rsa-sha256;
 arc=none
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

Hello Joseph,

On Tue, Dec 09, 2025 at 12:17:49PM +0900, Joseph Guo wrote:
> Add i.MX91 11x11 FRDM Board support.
>  - Four ddr scripts included w/o inline ecc feature. Support
>    both 1gb and 2gb DDR
>  - SDHC/EQOS/I2C/UART supported
>  - PCA9451 supported, default nominal drive mode
>  - Documentation added.
> 
> Signed-off-by: Joseph Guo <qijian.guo@nxp.com>
> ---
> Changes in v2:
> - correct commit message 'EVK' to 'FRDM'
> - use #include in ecc config file
> - add ecc description in README
> - drop extraneous includes
> - rename 'imx91_frdm.rst' to 'imx91_11x11_frdm.rst'
> - drop IMX91_FRDM_LPDDR4 symbol
> - drop bootph- property
> 
> Changes in v3:
> - drop usdhc2 in uboot dts
> - add workaround to clear ptn5110 alert in board init
> - /s/EFI_HAVE_CAPSULE_SUPPORT/ENV_IS_IN_MMC
> - drop fec and ethphy1 in u-boot in uboot dts
> - drop spi flash related config
> - drop m-core enviroment variable
> - change PHYS_SDRAM_SIZE macro to SZ_2G
> ---
>  arch/arm/dts/imx91-11x11-frdm-u-boot.dtsi          |   34 +
>  arch/arm/mach-imx/imx9/Kconfig                     |    9 +
>  board/freescale/imx91_frdm/Kconfig                 |   12 +
>  board/freescale/imx91_frdm/MAINTAINERS             |    7 +
>  board/freescale/imx91_frdm/Makefile                |   16 +
>  board/freescale/imx91_frdm/imx91_frdm.c            |   74 +
>  board/freescale/imx91_frdm/imx91_frdm.env          |   87 +
>  .../imx91_frdm/lpddr4_2400mts_1gb_timing.c         | 1996 ++++++++++++++++++++
>  .../imx91_frdm/lpddr4_2400mts_2gb_timing.c         | 1996 ++++++++++++++++++++
>  .../imx91_frdm/lpddr4_2400mts_ecc_1gb_timing.c     | 1996 ++++++++++++++++++++
>  .../imx91_frdm/lpddr4_2400mts_ecc_2gb_timing.c     | 1996 ++++++++++++++++++++
>  board/freescale/imx91_frdm/lpddr4_timing.h         |   12 +
>  board/freescale/imx91_frdm/spl.c                   |  193 ++
>  configs/imx91_11x11_frdm_defconfig                 |  138 ++
>  configs/imx91_11x11_frdm_inline_ecc_defconfig      |    3 +
>  doc/board/nxp/imx91_11x11_frdm.rst                 |  100 +
>  doc/board/nxp/index.rst                            |    1 +
>  include/configs/imx91_frdm.h                       |   25 +
>  18 files changed, 8695 insertions(+)
> 

[snip]

> diff --git a/board/freescale/imx91_frdm/imx91_frdm.c b/board/freescale/imx91_frdm/imx91_frdm.c
> new file mode 100644
> index 0000000000000000000000000000000000000000..453f19e7f5f1d06e9ac453933ea80c66e6368c81
> --- /dev/null
> +++ b/board/freescale/imx91_frdm/imx91_frdm.c
> @@ -0,0 +1,74 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright 2025 NXP
> + */
> +
> +#include <env.h>
> +#include <asm/arch/sys_proto.h>
> +#include <i2c.h>
> +#include <dm.h>
> +
> +#define TCPC_ALERT 0x10
> +#define TCPC_ALERT_MASK 0x12
> +#define TCPC_FAULT_STATUS_MASK 0x15
> +#define USB_I2C_BUS 2
> +#define USB_I2C_ADDR 0x50
> +
> +static int clear_pd_alert(void)
> +{

Given this is a workaround, maybe a comment explaining why this is
needed would be useful.

> +	struct udevice *bus;
> +	struct udevice *i2c_dev = NULL;
> +	int ret;
> +	u8 buffer_0[2] = {0, 0};
> +	u8 buffer_1[2] = {0xff, 0xff};
> +
> +	ret = uclass_get_device_by_seq(UCLASS_I2C, USB_I2C_BUS, &bus);
> +	if (ret) {
> +		printf("Failed to get I2C bus %d\n", USB_I2C_BUS);
> +		return ret;
> +	}
> +
> +		ret = dm_i2c_probe(bus, USB_I2C_ADDR, 0, &i2c_dev);
> +		if (ret)
> +			printf("Can't find USB PD device at 0x%02x\n", USB_I2C_ADDR);
> +
> +		/* Mask all alert status*/
> +		ret = dm_i2c_write(i2c_dev, TCPC_ALERT_MASK, buffer_0, 2);
> +		if (ret) {
> +			printf("%s dm_i2c_write failed: %d\n", __func__, ret);
> +			return 0;
> +		}
> +
> +		ret = dm_i2c_write(i2c_dev, TCPC_FAULT_STATUS_MASK, buffer_0, 2);
> +		if (ret) {
> +			printf("%s dm_i2c_write failed: %d\n", __func__, ret);
> +			return 0;
> +		}
> +
> +		ret = dm_i2c_write(i2c_dev, TCPC_ALERT, buffer_1, 2);
> +		if (ret) {
> +			printf("%s dm_i2c_write failed: %d\n", __func__, ret);
> +			return 0;
> +		}
> +

Indentation is off here.

> +	return 0;
> +}
> +
> +int board_late_init(void)
> +{
> +	if (IS_ENABLED(CONFIG_ENV_IS_IN_MMC))
> +		board_late_mmc_env_init();
> +
> +	env_set("sec_boot", "no");
> +
> +	if (IS_ENABLED(CONFIG_AHAB_BOOT))
> +		env_set("sec_boot", "yes");
> +
> +	if (IS_ENABLED(CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG)) {
> +		env_set("board_name", "11X11_FRDM");
> +		env_set("board_rev", "iMX91");
> +	}
> +
> +	clear_pd_alert();
> +	return 0;
> +}
> diff --git a/board/freescale/imx91_frdm/imx91_frdm.env b/board/freescale/imx91_frdm/imx91_frdm.env
> new file mode 100644
> index 0000000000000000000000000000000000000000..fa5e22f0508f3deb676ed1919146c3c4997a3c97
> --- /dev/null
> +++ b/board/freescale/imx91_frdm/imx91_frdm.env
> @@ -0,0 +1,87 @@
> +/* SPDX-License-Identifier: (GPL-2.0+ OR MIT) */
> +
> +boot_targets=mmc0 mmc1
> +boot_fit=no
> +bootm_size=0x10000000
> +cntr_addr=0x98000000
> +cntr_file=os_cntr_signed.bin
> +console=ttyLP0,115200 earlycon
> +fdt_addr_r=0x83000000
> +fdt_addr=0x83000000
> +fdtfile=CONFIG_DEFAULT_FDT_FILE
> +image=Image
> +mmcdev=CONFIG_ENV_MMC_DEVICE_INDEX
> +mmcpart=1
> +mmcroot=/dev/mmcblk1p2 rootwait rw
> +mmcautodetect=yes
> +mmcargs=setenv bootargs ${jh_clk} ${mcore_clk} console=${console} root=${mmcroot}
> +loadimage=fatload mmc ${mmcdev}:${mmcpart} ${loadaddr} ${image}
> +loadfdt=fatload mmc ${mmcdev}:${mmcpart} ${fdt_addr_r} ${fdtfile}
> +loadcntr=fatload mmc ${mmcdev}:${mmcpart} ${cntr_addr} ${cntr_file}
> +auth_os=auth_cntr ${cntr_addr}
> +sec_boot=no
> +boot_os=booti ${loadaddr} - ${fdt_addr_r}
> +mmcboot=
> +	echo Booting from mmc ...;
> +	run mmcargs;
> +	if test ${sec_boot} = yes; then
> +		if run true; then
> +			run boot_os;
> +		else
> +			echo ERR: failed to authenticate;
> +		fi;
> +	else
> +		if run loadfdt; then
> +			run boot_os;
> +		else
> +			echo WARN: Cannot load the DT;
> +		fi;
> +	fi;
> +netargs=setenv bootargs ${jh_clk} ${mcore_clk} console=${console} root=/dev/nfs
> +	ip=dhcp nfsroot=${serverip}:${nfsroot},v3,tcp
> +netboot=
> +	echo Booting from net ...;
> +	run netargs;
> +	if test ${ip_dyn} = yes; then
> +		setenv get_cmd dhcp;
> +	else
> +		setenv get_cmd tftp;
> +	fi;
> +	if test ${sec_boot} = yes; then
> +		${get_cmd} ${cntr_addr} ${cntr_file};
> +		if true; then
> +			run boot_os;
> +		else
> +			echo ERR: failed to authenticate;
> +		fi;
> +	else
> +		${get_cmd} ${loadaddr} ${image};
> +		if ${get_cmd} ${fdt_addr_r} ${fdtfile}; then
> +			run boot_os;
> +		else
> +			echo WARN: Cannot load the DT;
> +		fi;
> +	fi;
> +bsp_bootcmd=
> +	echo Running BSP bootcmd ...;
> +	mmc dev ${mmcdev};
> +	if mmc rescan; then
> +		if run loadbootscript; then
> +			run bootscript;
> +		else

Neither loadbootscript nor bootscript are defined; this leads to the
following error on startup:

    ## Error: "loadbootscript" not defined

I saw that this is shared by several other i.MX boards, but maybe it's
worth fixing.

> +			if test ${sec_boot} = yes; then
> +				if run loadcntr; then
> +					run mmcboot;
> +				else
> +					run netboot;
> +				fi;
> +			else
> +				if run loadimage; then
> +					run mmcboot;
> +				else
> +					run netboot;
> +				fi;
> +			fi;
> +		fi;
> +	fi;
> +scriptaddr=0x83500000


I also get on startup:

    Failed to update cpu-thermal trip(s)

But this is probably due to lack of thermal support at Linux kernel side
and needs a fix there?


Thank you

Regards,
Francesco

