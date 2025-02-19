Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10FE9C021AA
	for <u-boot@archiver.kernel.org>; Wed, 19 Feb 2025 14:34:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4699C801BE;
	Wed, 19 Feb 2025 15:34:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="jazCn6sv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B2BA8807C4; Wed, 19 Feb 2025 15:34:10 +0100 (CET)
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E9881800D7
 for <u-boot@lists.denx.de>; Wed, 19 Feb 2025 15:34:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=afd@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 51JEXk041833399
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Wed, 19 Feb 2025 08:33:46 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1739975626;
 bh=7eR8OuiBMW1jooy/PiaLE0HY4/DNfuWNTXzZx+EAOaE=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=jazCn6svPn1gejMcYHqHPnQRZybw8fnD+CafN+8Iv4ye8ISI/N2cB1JhvimKz/ebU
 kvG+TcSKaInQAdN051MO13Va+vSJC3wTEYYRI56TCqmdtC/ocsRdwA7Oi8yoUpz0lG
 AJjmJKVpgMJTUaYDdOhd32gu2royEnUoAMewrDDk=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTP id 51JEXk0G018871;
 Wed, 19 Feb 2025 08:33:46 -0600
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 19
 Feb 2025 08:33:45 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 19 Feb 2025 08:33:45 -0600
Received: from [10.249.42.149] ([10.249.42.149])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 51JEXiJY022886;
 Wed, 19 Feb 2025 08:33:44 -0600
Message-ID: <328922a9-aaab-496b-9a82-1cfbe8452005@ti.com>
Date: Wed, 19 Feb 2025 08:33:44 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 06/13] configs: am68: Add configs for enabling Ethboot
 in R5SPL
To: Chintan Vankar <c-vankar@ti.com>, Christian Marangi <ansuelsmth@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>, Sughosh Ganu
 <sughosh.ganu@linaro.org>, Simon Glass <sjg@chromium.org>, Michael Walle
 <mwalle@kernel.org>, Roger Quadros <rogerq@kernel.org>, Matthias Schiffer
 <matthias.schiffer@ew.tq-group.com>, Santhosh Kumar K <s-k6@ti.com>, "Hari
 Nagalla" <hnagalla@ti.com>, Nishanth Menon <nm@ti.com>, Jonathan Humphreys
 <j-humphreys@ti.com>, Andreas Dannenberg <dannenberg@ti.com>, "Kishon Vijay
 Abraham I" <kishon@ti.com>, Joao Paulo Goncalves
 <joao.goncalves@toradex.com>, Siddharth Vadapalli <s-vadapalli@ti.com>,
 Alexander Sverdlin <alexander.sverdlin@siemens.com>, Wadim Egorov
 <w.egorov@phytec.de>, "Udit Kumar" <u-kumar1@ti.com>, Neha Malcom Francis
 <n-francis@ti.com>, Ramon Fried <rfried.dev@gmail.com>, Joe Hershberger
 <joe.hershberger@ni.com>, "Bryan Brattlof" <bb@ti.com>, Vignesh Raghavendra
 <vigneshr@ti.com>, Manorit Chawdhry <m-chawdhry@ti.com>, Tom Rini
 <trini@konsulko.com>
CC: <u-boot@lists.denx.de>
References: <20250219104831.2315464-1-c-vankar@ti.com>
 <20250219104831.2315464-7-c-vankar@ti.com>
Content-Language: en-US
From: Andrew Davis <afd@ti.com>
In-Reply-To: <20250219104831.2315464-7-c-vankar@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
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

On 2/19/25 4:48 AM, Chintan Vankar wrote:
> Add configs for enabling Ethernet boot in R5SPL, also disable not required
> configs to avoid memory limitation.
> 
> Signed-off-by: Chintan Vankar <c-vankar@ti.com>
> ---
> 
> Link to v1:
> https://lore.kernel.org/r/20250107093840.2211381-6-c-vankar@ti.com/
> 
> Changes from v1 to v2:
> - Updated commit message.
> 
>   configs/am68_sk_r5_ethboot_defconfig | 60 ++++++++++++++++++++++++++++
>   1 file changed, 60 insertions(+)
>   create mode 100644 configs/am68_sk_r5_ethboot_defconfig
> 
> diff --git a/configs/am68_sk_r5_ethboot_defconfig b/configs/am68_sk_r5_ethboot_defconfig
> new file mode 100644
> index 00000000000..d4d279cad3b
> --- /dev/null
> +++ b/configs/am68_sk_r5_ethboot_defconfig
> @@ -0,0 +1,60 @@
> +#include <configs/am68_sk_r5_defconfig>
> +
> +CONFIG_ARM=y
> +CONFIG_ARCH_K3=y
> +CONFIG_SOC_K3_J721S2=y
> +CONFIG_TARGET_J721S2_R5_EVM=y
> +CONFIG_DEFAULT_DEVICE_TREE="k3-am68-sk-r5-base-board"
> +CONFIG_SPL_BOARD_INIT=y
> +CONFIG_SPL_DMA=y
> +CONFIG_SPL_ETH=y
> +CONFIG_SPL_NET=y
> +CONFIG_SPL_NET_VCI_STRING="AM68 U-Boot R5 SPL"
> +CONFIG_SPL_SYSCON=y

Assuming the above CONFIG is needed by one of the below
two drivers? Could the above be selected by one of them
in their Kconfig instead of in each defconfig?

> +CONFIG_TI_K3_NAVSS_UDMA=y
> +CONFIG_TI_AM65_CPSW_NUSS=y
> +CONFIG_SPI=n
> +CONFIG_SPL_SPI=n
> +CONFIG_DM_SPI=n
> +CONFIG_SPL_DM_SPI=n
> +CONFIG_SPI_MEM=n
> +CONFIG_CMD_FAT=n

The *_r5_defconfigs build both SPL and U-Boot proper, but we only use SPL.
Changing options that only affect U-Boot and not SPL shouldn't be needed.

Andrew

> +CONFIG_FS_FAT=n
> +CONFIG_SPL_FS_FAT=n
> +CONFIG_MMC_SDHCI=n
> +CONFIG_MTD=n
> +CONFIG_CMD_FAT=n
> +CONFIG_SPL_DM_SPI_FLASH=n
> +CONFIG_SPL_HAS_CUSTOM_MALLOC_START=n
> +CONFIG_HUSH_PARSER=n
> +CONFIG_CMD_DFU=n
> +CONFIG_CMD_GPT=n
> +CONFIG_SPL_YMODEM_SUPPORT=n
> +CONFIG_ARCH_FIXUP_FDT_MEMORY=n
> +CONFIG_INPUT=n
> +CONFIG_DFU=n
> +CONFIG_SPL_DFU=n
> +CONFIG_K3_EARLY_CONS=n
> +CONFIG_K3_QOS=n
> +CONFIG_USE_BOOTCOMMAND=n
> +CONFIG_SPL_MTD=n
> +CONFIG_SPL_NAND_SPI_SUPPORT=n
> +CONFIG_USB=n
> +CONFIG_FS_LOADER=n
> +CONFIG_SPL_FS_LOADER=n
> +CONFIG_PINCTRL_GENERIC=n
> +CONFIG_PINMUX=n
> +CONFIG_SPL_PINCTRL_GENERIC=n
> +CONFIG_SPL_PINMUX=n
> +CONFIG_DM_REGULATOR=n
> +CONFIG_TI_SCI_POWER_DOMAIN=n
> +CONFIG_SYSRESET=n
> +CONFIG_OF_UPSTREAM=n
> +CONFIG_SPL_SPI_LOAD=n
> +CONFIG_SPL_DM_SPI=n
> +CONFIG_NOR_SUPPORT=n
> +CONFIG_SPL_NOR_SUPPORT=n
> +CONFIG_SPL_DM_SPI=n
> +CONFIG_SYS_MALLOC_CLEAR_ON_INIT=n
> +CONFIG_SPL_SYS_MALLOC_CLEAR_ON_INIT=n
> +CONFIG_BOOTDEV_ETH=n
