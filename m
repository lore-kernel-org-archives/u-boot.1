Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C35A6E77197
	for <u-boot@archiver.kernel.org>; Tue,  7 Jan 2025 14:38:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2CAA7801E8;
	Tue,  7 Jan 2025 15:38:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="hCj4Q4zD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D8B5D801FD; Tue,  7 Jan 2025 15:38:34 +0100 (CET)
Received: from nyc.source.kernel.org (nyc.source.kernel.org
 [IPv6:2604:1380:45d1:ec00::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 08B3A8007D
 for <u-boot@lists.denx.de>; Tue,  7 Jan 2025 15:38:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rogerq@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id 3E498A41621;
 Tue,  7 Jan 2025 14:36:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04DBDC4CED6;
 Tue,  7 Jan 2025 14:38:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1736260709;
 bh=Cc2xTdV6TNslsr5qBaebFnPqUQMiNd0ojmjToEa3P1I=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=hCj4Q4zDm1s9TwAhX7K6dM2a8y2xXmKo4vBuhj7Bx3sjkbPDvCRgyLWL7w0dmoOIQ
 RGgvnl2cr1RB79z05/QI7XsR5FgsiJglTqe5b6wyTccyCUBY4tMfIfiwWEBfkWjqLq
 tlyD5hyuA5BCD9ERcf2sm0lK0M6T+gE4Ez7EpE/mkpFOJBmKIaR9qmNTV46eAU8CxE
 V7dJLZ7gN5EHQoA8zuNoWIbyn3y4pwVwX8drld9mCfIzMVA9/JXxAwyoWB3Q7DVcrl
 vULrt1ZkCgIZ8lWRdGRJzA7fnU04FbOvAgvV1hFH4Jg0fHS/jST/oCqedsGQ2+Hl2Y
 1r1KekbOLxpFw==
Message-ID: <82c602bb-f823-484d-97a9-1bf6de2b4a9b@kernel.org>
Date: Tue, 7 Jan 2025 16:38:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/13] configs: am68: Add configs for enabling Ethboot in
 R5SPL
To: Chintan Vankar <c-vankar@ti.com>, AKASHI Takahiro
 <akashi.tkhro@gmail.com>, Mikhail Kshevetskiy
 <mikhail.kshevetskiy@iopsys.eu>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Nishanth Menon <nm@ti.com>,
 Hari Nagalla <hnagalla@ti.com>, Jonathan Humphreys <j-humphreys@ti.com>,
 Andreas Dannenberg <dannenberg@ti.com>, Simon Glass <sjg@chromium.org>,
 Jayesh Choudhary <j-choudhary@ti.com>, Aniket Limaye <a-limaye@ti.com>,
 Aradhya Bhatia <a-bhatia1@ti.com>, Neha Malcom Francis <n-francis@ti.com>,
 Andrew Davis <afd@ti.com>, Ramon Fried <rfried.dev@gmail.com>,
 Joe Hershberger <joe.hershberger@ni.com>, Bryan Brattlof <bb@ti.com>,
 Vignesh Raghavendra <vigneshr@ti.com>, Manorit Chawdhry <m-chawdhry@ti.com>,
 Tom Rini <trini@konsulko.com>
Cc: srk@ti.com, s-vadapalli@ti.com, danishanwar@ti.com, u-boot@lists.denx.de
References: <20250107093840.2211381-1-c-vankar@ti.com>
 <20250107093840.2211381-6-c-vankar@ti.com>
Content-Language: en-US
From: Roger Quadros <rogerq@kernel.org>
In-Reply-To: <20250107093840.2211381-6-c-vankar@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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



On 07/01/2025 11:38, Chintan Vankar wrote:
> Add configs for enabling Ethernet boot in R5SPL.
> 
> Signed-off-by: Chintan Vankar <c-vankar@ti.com>
> ---
>  configs/am68_sk_r5_ethboot_defconfig | 80 ++++++++++++++++++++++++++++
>  1 file changed, 80 insertions(+)
>  create mode 100644 configs/am68_sk_r5_ethboot_defconfig
> 
> diff --git a/configs/am68_sk_r5_ethboot_defconfig b/configs/am68_sk_r5_ethboot_defconfig
> new file mode 100644
> index 00000000000..9bfbb5a3bfe
> --- /dev/null
> +++ b/configs/am68_sk_r5_ethboot_defconfig
> @@ -0,0 +1,80 @@
> +#include <configs/am68_sk_r5_defconfig>
> +
> +CONFIG_ARM=y
> +CONFIG_ARCH_K3=y
> +CONFIG_SOC_K3_J721S2=y
> +CONFIG_TARGET_J721S2_R5_EVM=y
> +CONFIG_DEFAULT_DEVICE_TREE="k3-am68-sk-r5-base-board"

Please don't add duplicates that are already included in configs/am68_sk_r5_defconfig
or configs/j721s2_evm_r5_defconfig

> +CONFIG_SPL_GPIO=y
> +CONFIG_SPL_BOARD_INIT=y
> +CONFIG_SPL_STACK_R_MALLOC_SIMPLE_LEN=0x200000
> +CONFIG_SPL_DMA=y
> +CONFIG_SPL_ENV_SUPPORT=y
> +CONFIG_SPL_ETH=y
> +CONFIG_SPL_I2C=y
> +CONFIG_SPL_NET=y
> +CONFIG_SPL_NET_VCI_STRING="AM68 U-Boot R5 SPL"
> +CONFIG_CMD_DHCP=y
> +CONFIG_SPL_SYSCON=y
> +CONFIG_DMA_CHANNELS=y
> +CONFIG_TI_K3_NAVSS_UDMA=y
> +CONFIG_DM_I2C=y
> +CONFIG_PHY_TI_DP83867=y
> +CONFIG_TI_AM65_CPSW_NUSS=y
> +CONFIG_SPI=n
> +CONFIG_SPL_SPI=n
> +CONFIG_DM_SPI=n
> +CONFIG_SPL_DM_SPI=n
> +CONFIG_SPL_SYS_MALLOC=y
> +CONFIG_SPI_MEM=n
> +CONFIG_CMD_FAT=n
> +CONFIG_FS_FAT=n
> +CONFIG_SPL_FS_FAT=n
> +CONFIG_MMC_SDHCI=n
> +CONFIG_MTD=n
> +CONFIG_CMD_FAT=n

Please explain in commit log why you are setting many of the
options to "n". Is it due to memory limitation?

> +CONFIG_SYS_RELOC_GD_ENV_ADD=y
> +CONFIG_SPL_DM_SPI_FLASH=n
> +CONFIG_SPL_HAS_CUSTOM_MALLOC_START=n
> +CONFIG_HUSH_PARSER=n
> +CONFIG_CMD_DFU=n
> +CONFIG_CMD_GPT=n
> +CONFIG_SPL_YMODEM_SUPPORT=n
> +CONFIG_ARCH_FIXUP_FDT_MEMORY=n
> +CONFIG_SPL_ENV_IS_NOWHERE=y
> +CONFIG_DM_EVENT=y
> +CONFIG_INPUT=n
> +CONFIG_ESM_K3=y
> +CONFIG_SPL_LOAD_BLOCK=y
> +CONFIG_DFU=n
> +CONFIG_SPL_DFU=n
> +CONFIG_TI_I2C_BOARD_DETECT=y
> +CONFIG_K3_EARLY_CONS=n
> +CONFIG_K3_QOS=n
> +CONFIG_USE_BOOTCOMMAND=n
> +CONFIG_SPL_MTD=n
> +CONFIG_SPL_NAND_SPI_SUPPORT=n
> +CONFIG_BOOTDEV_ETH=y
> +CONFIG_USB=n
> +CONFIG_FS_LOADER=n
> +CONFIG_SPL_FS_LOADER=n
> +CONFIG_SPL_DM_SPI=y
> +CONFIG_PINCTRL_GENERIC=n
> +CONFIG_PINMUX=n
> +CONFIG_SPL_PINCTRL_GENERIC=n
> +CONFIG_SPL_PINMUX=n
> +CONFIG_DM_REGULATOR=n
> +CONFIG_TI_SCI_POWER_DOMAIN=n
> +CONFIG_CMD_REMOTEPROC=y
> +CONFIG_SYSRESET=n
> +CONFIG_LAST_STAGE_INIT=y
> +CONFIG_OF_UPSTREAM=n

Why no OF_UPSTREAM?

> +CONFIG_K3_DM_FW=y
> +CONFIG_SPL_SPI_LOAD=n
> +CONFIG_SPL_DM_SPI=n
> +CONFIG_NOR_SUPPORT=n
> +CONFIG_SPL_NOR_SUPPORT=n
> +CONFIG_SPL_DM_SPI=n
> +CONFIG_SYS_MALLOC_CLEAR_ON_INIT=n
> +CONFIG_SPL_SYS_MALLOC_CLEAR_ON_INIT=n
> +CONFIG_BOOTDEV_ETH=n

-- 
cheers,
-roger

