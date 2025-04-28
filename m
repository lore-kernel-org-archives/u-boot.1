Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A832C369D5
	for <u-boot@archiver.kernel.org>; Mon, 28 Apr 2025 13:27:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EAE4982AA7;
	Mon, 28 Apr 2025 15:24:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="o8TZnkem";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 63D0A82AAA; Mon, 28 Apr 2025 15:24:58 +0200 (CEST)
Received: from mx08-00178001.pphosted.com (mx08-00178001.pphosted.com
 [91.207.212.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 414F782A0D
 for <u-boot@lists.denx.de>; Mon, 28 Apr 2025 15:24:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=7213f5eaf8=patrice.chotard@foss.st.com
Received: from pps.filterd (m0369457.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53S9ULkg010140;
 Mon, 28 Apr 2025 15:24:50 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=selector1; bh=
 QBJSEyWH8gG1YGmbNcgh7MA6xtJLRFVTgT5NMTBgsco=; b=o8TZnkem0AAJqMNf
 RIPEUpp6R+XR/VSKtni4NJgmEvJMCTO+bitG/rFsJNMHe31mHBQNh5CZZuSSjQgR
 S0Xz9sNN2v2Rwmlm3t+8RtFrfg4yNGuL0vRpceJ/WHUTxNzszWCETWoobofHzy2w
 OARlfJfqEPszTnrkxC+lT3fiG4X1bp4f/7zNxbB4SQLUL/uvUbqfwZx3X80agk32
 Ewvx73TCUlMRazMbCnicADzkfk48b5RFFq0j6KRGaP9hob8d17tKAEQWH9ozzFHX
 R5VCL44VTacpdqL4XoYykusp68ZuEQse2gDkQSF0sOjEWlgcBUEvFqDJiUnF6hlI
 ebA6gQ==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 469aencfv8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 28 Apr 2025 15:24:50 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 4506B40068;
 Mon, 28 Apr 2025 15:23:47 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 0A330A60F2C;
 Mon, 28 Apr 2025 15:23:01 +0200 (CEST)
Received: from [10.48.87.62] (10.48.87.62) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 28 Apr
 2025 15:22:59 +0200
Message-ID: <16d2ac8d-c6c4-45e5-b2cb-0c5bfa425b1a@foss.st.com>
Date: Mon, 28 Apr 2025 15:22:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 05/22] board: st: stm32mp2: add mmc_get_env_dev()
To: <u-boot@lists.denx.de>
CC: Patrick DELAUNAY <patrick.delaunay@foss.st.com>, U-Boot STM32
 <uboot-stm32@st-md-mailman.stormreply.com>, Heinrich Schuchardt
 <xypron.glpk@gmx.de>, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Simon Glass <sjg@chromium.org>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 Tom Rini <trini@konsulko.com>
References: <20250425131533.392747-1-patrice.chotard@foss.st.com>
 <20250425131533.392747-6-patrice.chotard@foss.st.com>
Content-Language: en-US
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <20250425131533.392747-6-patrice.chotard@foss.st.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.48.87.62]
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-28_05,2025-04-24_02,2025-02-21_01
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



On 4/25/25 15:15, Patrice Chotard wrote:
> Use the boot instance to select the correct mmc device identifier,
> this patch only to save the environment on eMMC = MMC(1) on
> STMicroelectronics boards.
> 
> Set the CONFIG_SYS_MMC_ENV_DEV to -1 to select the mmc boot instance
> by default.
> 
> Signed-off-by: Patrick Delaunay <patrick.delaunay@foss.st.com>
> Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
> ---
> 
> (no changes since v1)
> 
>  board/st/stm32mp2/stm32mp2.c | 37 ++++++++++++++++++++++++++++++++++++
>  configs/stm32mp25_defconfig  |  2 +-
>  2 files changed, 38 insertions(+), 1 deletion(-)
> 
> diff --git a/board/st/stm32mp2/stm32mp2.c b/board/st/stm32mp2/stm32mp2.c
> index c70ffaf5dbd..8446b8fd3d6 100644
> --- a/board/st/stm32mp2/stm32mp2.c
> +++ b/board/st/stm32mp2/stm32mp2.c
> @@ -10,6 +10,7 @@
>  #include <fdt_support.h>
>  #include <log.h>
>  #include <misc.h>
> +#include <mmc.h>
>  #include <asm/global_data.h>
>  #include <asm/arch/sys_proto.h>
>  #include <dm/device.h>
> @@ -78,6 +79,42 @@ enum env_location env_get_location(enum env_operation op, int prio)
>  	}
>  }
>  
> +int mmc_get_boot(void)
> +{
> +	struct udevice *dev;
> +	u32 boot_mode = get_bootmode();
> +	unsigned int instance = (boot_mode & TAMP_BOOT_INSTANCE_MASK) - 1;
> +	char cmd[20];
> +	const u32 sdmmc_addr[] = {
> +		STM32_SDMMC1_BASE,
> +		STM32_SDMMC2_BASE,
> +		STM32_SDMMC3_BASE
> +	};
> +
> +	if (instance > ARRAY_SIZE(sdmmc_addr))
> +		return 0;
> +
> +	/* search associated sdmmc node in devicetree */
> +	snprintf(cmd, sizeof(cmd), "mmc@%x", sdmmc_addr[instance]);
> +	if (uclass_get_device_by_name(UCLASS_MMC, cmd, &dev)) {
> +		log_err("mmc%d = %s not found in device tree!\n", instance, cmd);
> +		return 0;
> +	}
> +
> +	return dev_seq(dev);
> +};
> +
> +int mmc_get_env_dev(void)
> +{
> +	const int mmc_env_dev = CONFIG_IS_ENABLED(ENV_IS_IN_MMC, (CONFIG_SYS_MMC_ENV_DEV), (-1));
> +
> +	if (mmc_env_dev >= 0)
> +		return mmc_env_dev;
> +
> +	/* use boot instance to select the correct mmc device identifier */
> +	return mmc_get_boot();
> +}
> +
>  int board_late_init(void)
>  {
>  	const void *fdt_compat;
> diff --git a/configs/stm32mp25_defconfig b/configs/stm32mp25_defconfig
> index d11910f139f..fd5c36ec3e2 100644
> --- a/configs/stm32mp25_defconfig
> +++ b/configs/stm32mp25_defconfig
> @@ -36,7 +36,7 @@ CONFIG_CMD_LOG=y
>  CONFIG_OF_LIVE=y
>  CONFIG_ENV_IS_NOWHERE=y
>  CONFIG_ENV_IS_IN_MMC=y
> -CONFIG_SYS_MMC_ENV_DEV=1
> +CONFIG_SYS_MMC_ENV_DEV=-1
>  CONFIG_NO_NET=y
>  CONFIG_SYS_64BIT_LBA=y
>  CONFIG_GPIO_HOG=y
Applied to u-boot-stm32/master

Thanks
Patrice
