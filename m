Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCEA0FD875F
	for <u-boot@archiver.kernel.org>; Tue, 17 Mar 2026 12:42:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 65C2E842DB;
	Tue, 17 Mar 2026 13:42:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="ittctm1G";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 022B9842EB; Tue, 17 Mar 2026 13:42:27 +0100 (CET)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 38715842C4
 for <u-boot@lists.denx.de>; Tue, 17 Mar 2026 13:42:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=patrice.chotard@foss.st.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PsKuN8eX1JVbAhFj+T/HvSUdDwI9UTQLHHaEAyJwABejOJGJezPXkAVpGanY354Kwp12uJVmB+xJvwdUGtpkLFJnhzp3tAxK4kvkSFEJiptsizsIxI++DsPThqdvO09fUgM+cFpZ1a+20xlOVmp41ectlrUOMM7jFY3Qn0JOuXIBf8Xcd2Xuxm0BXZIG0GUPF5ZkZsau8YaXKNcsTAv5zHOiWygTqIm8Tjpp8HjV4Rmqs4fTbDkj3WeL0WyxpWF0Lr+iRXnRNvVZtXTFGzeRGo6WYVeC24Mj/sXXIGprN6mVA6/VtA8nK7RtgTIEyK80/Cn1eIU4Eoz98HYx3MphRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nVngTnGoDlyWEGzLeo6p04KBUiT29qssiyjWsiod5pQ=;
 b=otdV05r3gq/jwhK0eMKZXPX/A48WPUtDw4z4lvyQoVLn8kGYK++fZzreya1Qir5n/VrWKrypCsphfl2+Ri6e11ZU54U6cB2RYPW9hIW2TDmc9dBVfXzIWad/OuUferYMBZYcBVcjXsgEHT91sTUI2m5aoDl5kgRK9ettg7sBZTSl0hLn+6cO5MPdwChM6/gBG0KOkLjScbdP7PlZl5ouIgZOg5lJHEEpE3IXYUHovqqgQyl86Tgaqm5iwpbPKHFjlcbkvHAtByMrBK6jnEvdrrmpfjf1GkO8DQ6NylsqNK4otdwwYmB4fTm8LrRy3x4bYUEJng9575vUYNPuP8e+Kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.59) smtp.rcpttodomain=konsulko.com smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nVngTnGoDlyWEGzLeo6p04KBUiT29qssiyjWsiod5pQ=;
 b=ittctm1GX/IGMFDODKQuRAcwAMJ+w/3jNB18eGgaM0jrZc16L64h4njesjEY5EPLKslrGa/xT5vbTn0Y/cA6/5iK6NOkylItR0DlZiUuvLIlRh0wlWPPd+zBVyqcPXO/tHLH8+iY75nobw4dBcBXuG7lfbpHlx38jj/wVhTs7aEMY2i0ROmk4HFrna4hAo/XeH1gk9JpOPDiZwpEPJ/KThFZgL9nFq0ZYTJWaBgPahz1nApuQRttXjId+9sk4n9L3OKJmwj4BYI8wmID8bnpOToOXMYnXBQXvEApYv9UpIKmG7cdOd11I4O+ivmG4daCdSXEppoazkWsg5uMmEcaug==
Received: from DU6P191CA0038.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:53f::22)
 by AS2PR10MB7345.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:607::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.21; Tue, 17 Mar
 2026 12:42:22 +0000
Received: from DB1PEPF000509F0.eurprd03.prod.outlook.com
 (2603:10a6:10:53f:cafe::8b) by DU6P191CA0038.outlook.office365.com
 (2603:10a6:10:53f::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.27 via Frontend Transport; Tue,
 17 Mar 2026 12:42:18 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.59)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.59 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.59; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.59) by
 DB1PEPF000509F0.mail.protection.outlook.com (10.167.242.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9700.17 via Frontend Transport; Tue, 17 Mar 2026 12:42:22 +0000
Received: from STKDAG1NODE1.st.com (10.75.128.132) by smtpo365.st.com
 (10.250.44.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.29; Tue, 17 Mar
 2026 13:44:55 +0100
Received: from [10.48.87.93] (10.48.87.93) by STKDAG1NODE1.st.com
 (10.75.128.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.29; Tue, 17 Mar
 2026 13:42:21 +0100
Message-ID: <8add8b77-dc8b-45ce-8d72-1fb21cd391c8@foss.st.com>
Date: Tue, 17 Mar 2026 13:42:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] scmi: Rework SCMI_FIRMWARE implementation
To: Tom Rini <trini@konsulko.com>, <u-boot@lists.denx.de>
CC: Marek Vasut <marek.vasut+renesas@mailbox.org>, Michal Simek
 <michal.simek@amd.com>, Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, "Patrick
 Delaunay" <patrick.delaunay@foss.st.com>, Peng Fan <peng.fan@nxp.com>, "Simon
 Glass" <sjg@chromium.org>, <uboot-stm32@st-md-mailman.stormreply.com>
References: <20260317012414.4162304-1-trini@konsulko.com>
Content-Language: en-US
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <20260317012414.4162304-1-trini@konsulko.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.48.87.93]
X-ClientProxiedBy: ENXCAS1NODE2.st.com (10.75.128.138) To STKDAG1NODE1.st.com
 (10.75.128.132)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB1PEPF000509F0:EE_|AS2PR10MB7345:EE_
X-MS-Office365-Filtering-Correlation-Id: 276252d8-f50a-4bf8-8b5a-08de8422a2a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|376014|82310400026|56012099003|18002099003|22082099003|7053199007;
X-Microsoft-Antispam-Message-Info: 4VYboZZmjhHpcY8z9zYGf2OEXrqddA2873hTcVod/jlORkppq7JbFnPIGX6HIuw6XYeZhTnpeIaqaQEdiwivpItxDgeXFsH9RGcwNiRTifYYYRyc/FllWm3zrpMnKp1/QkiPJni/dNr8mczh4PmHip4E73UnsYveLER+mOQ5OQLhQt2spfFesii42hM/qXCFRsLIgT+1HQq5qEX69GeuAwGGzTgFy9+Rh2ZbidXqv4kOzjXBvqovLPYK0v6+L8Yk9Qz822+6Wq2M8wT9DXyss22K56FZTVOe/gewPeMrGgEE4vkzL17JNebVrp3bJJNOtEPWzewOJ6/zDXwccvMGxE6Nz7zbngvws1aQf2mhQpuWmpN03nXM2D9H8rkechs9oCXcNyY6KfuNanWPwLSQ6L6aFDpIcfAMmdYwglse0ARK8N/SD4akwgl0FnwR/Yj7/NG7KBYLemes49ZqzZUhue/EEpFKVSoCwkNGioG1uy2XSJrbqf1sibFWGQicHBdHpbm35hJGkgFqkj16MgOtssajdw976hCyqSdrd1b94eicK1zjkKfJQNIPfFHZf3V34L+1JmhN4okjo2PsqO/5C8WNUCkZq9D5GUMod96JF5I23Lb1g73HFsbQT9DwbDHfnkFN0fJblh5UnuVtYB9M8gnHkYd+j4SZJLQd6CEE8pPHjZbXUYUUlToi2VlkhP6BHsc1ZvnQl4+e1VFZBwX53QNekEpi+7/MD6GEEh9KIPubv+2lmHJmVQsCnDcoRXCi/H8AMNlV3N16SXa2EFfh5A==
X-Forefront-Antispam-Report: CIP:164.130.1.59; CTRY:IT; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:smtpO365.st.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(376014)(82310400026)(56012099003)(18002099003)(22082099003)(7053199007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: v7L1N1sgf9KraYq0lO3RoMVRrL03DbSSQFYhsYbhNNqmCZl6Q0SdEiks4clMw/qOtEpk+icK8n7eXaz4N+vdXW9bbuwCXvMZE4F5jxjj2eT2/gtC+hMFD2JRJqNEYo2t8HiHWFIYsFsEJpl1+BYiMvSfc3s9P0uXht+uBdm/PyGEfNZxlMkVjaxFzmIXC6MJVmyOYXY0iVbHqOEw8Y+Hhdpniudv2AZli47FrUA3FqXA8iTwfr8Ryo456OF4ZyZlWPGz58OxZn8x/PqzkCqWiV8K1uPpHL9mQkpeEPk6T8p4fWRyxTOx9fsHGmSc2CBiF6ZSYdm5kHb5hnDbqIRb6RFKtohkATo9+mxN4YmY3cDi/GRo9MypG72fgoVuCq/RFGtRPuhOHaEGYNGrJvv3pMUYfI1rNZBvdyfX/bB+t+4o8dm0xHSDS4SofgI4y7hw
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2026 12:42:22.4605 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 276252d8-f50a-4bf8-8b5a-08de8422a2a6
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f; Ip=[164.130.1.59];
 Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource: DB1PEPF000509F0.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB7345
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



On 3/17/26 02:24, Tom Rini wrote:
> As exposed by "make randconfig", how we have SCMI_FIRMWARE today is
> incomplete, and in one case, used incorrectly. First, SCMI_FIRMWARE has
> a build-time dependency on OF_CONTROL being enabled, so add that.
> Second, RESET_SCMI depends on SCMI_FIRMWARE being enabled, it should not
> select that symbol. In turn, a number of platforms need to now enable
> SCMI_FIRMWARE explicitly and not rely on RESET_SCMI to enable it for
> them.
> 
> Signed-off-by: Tom Rini <trini@konsulko.com>
> ---
> Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>
> Cc: Michal Simek <michal.simek@amd.com>
> Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
> Cc: Patrice Chotard <patrice.chotard@foss.st.com>
> Cc: Patrick Delaunay <patrick.delaunay@foss.st.com>
> Cc: Peng Fan <peng.fan@nxp.com>
> Cc: Simon Glass <sjg@chromium.org>
> Cc: uboot-stm32@st-md-mailman.stormreply.com
> ---
>  configs/amd_versal2_virt_defconfig  | 1 +
>  configs/r8a78000_ironhide_defconfig | 1 +
>  configs/sandbox_defconfig           | 1 +
>  configs/stm32mp13_defconfig         | 1 +
>  configs/stm32mp15-odyssey_defconfig | 1 +
>  configs/stm32mp15_defconfig         | 1 +
>  configs/stm32mp15_trusted_defconfig | 1 +
>  configs/stm32mp21_defconfig         | 1 +
>  configs/stm32mp23_defconfig         | 1 +
>  configs/stm32mp25_defconfig         | 1 +
>  drivers/firmware/scmi/Kconfig       | 1 +
>  drivers/reset/Kconfig               | 2 +-
>  12 files changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/configs/amd_versal2_virt_defconfig b/configs/amd_versal2_virt_defconfig
> index 94dce5c191c4..8cc210946539 100644
> --- a/configs/amd_versal2_virt_defconfig
> +++ b/configs/amd_versal2_virt_defconfig
> @@ -80,6 +80,7 @@ CONFIG_CLK_SCMI=y
>  CONFIG_CLK_VERSAL=y
>  CONFIG_DFU_RAM=y
>  CONFIG_ARM_FFA_TRANSPORT=y
> +CONFIG_SCMI_FIRMWARE=y
>  CONFIG_FPGA_XILINX=y
>  CONFIG_FPGA_VERSALPL=y
>  CONFIG_DM_I2C=y
> diff --git a/configs/r8a78000_ironhide_defconfig b/configs/r8a78000_ironhide_defconfig
> index 180704e75af8..64e2c278a7e0 100644
> --- a/configs/r8a78000_ironhide_defconfig
> +++ b/configs/r8a78000_ironhide_defconfig
> @@ -29,6 +29,7 @@ CONFIG_FIRMWARE=y
>  CONFIG_NR_DRAM_BANKS=16
>  CONFIG_POWER_DOMAIN=y
>  CONFIG_RCAR_MFIS_MBOX=y
> +CONFIG_SCMI_FIRMWARE=y
>  CONFIG_RESET_SCMI=y
>  CONFIG_SCMI_AGENT_MAILBOX=y
>  CONFIG_SCMI_FIRMWARE=y
> diff --git a/configs/sandbox_defconfig b/configs/sandbox_defconfig
> index 36bf37827e91..b681b91c3f99 100644
> --- a/configs/sandbox_defconfig
> +++ b/configs/sandbox_defconfig
> @@ -209,6 +209,7 @@ CONFIG_SANDBOX_DMA=y
>  CONFIG_FASTBOOT_FLASH=y
>  CONFIG_FASTBOOT_FLASH_MMC_DEV=0
>  CONFIG_ARM_FFA_TRANSPORT=y
> +CONFIG_SCMI_FIRMWARE=y
>  CONFIG_FPGA_ALTERA=y
>  CONFIG_FPGA_STRATIX_II=y
>  CONFIG_FPGA_STRATIX_V=y
> diff --git a/configs/stm32mp13_defconfig b/configs/stm32mp13_defconfig
> index 6bd139441122..620a6da2efe3 100644
> --- a/configs/stm32mp13_defconfig
> +++ b/configs/stm32mp13_defconfig
> @@ -70,6 +70,7 @@ CONFIG_FASTBOOT_FLASH=y
>  CONFIG_FASTBOOT_FLASH_MMC_DEV=0
>  CONFIG_FASTBOOT_CMD_OEM_FORMAT=y
>  CONFIG_FASTBOOT_CMD_OEM_PARTCONF=y
> +CONFIG_SCMI_FIRMWARE=y
>  CONFIG_GPIO_HOG=y
>  CONFIG_DM_I2C=y
>  CONFIG_SYS_I2C_STM32F7=y
> diff --git a/configs/stm32mp15-odyssey_defconfig b/configs/stm32mp15-odyssey_defconfig
> index 868ba1915f71..5d1c01c99fb3 100644
> --- a/configs/stm32mp15-odyssey_defconfig
> +++ b/configs/stm32mp15-odyssey_defconfig
> @@ -86,6 +86,7 @@ CONFIG_FASTBOOT_MMC_USER_SUPPORT=y
>  CONFIG_FASTBOOT_MMC_USER_NAME="mmc1"
>  CONFIG_FASTBOOT_CMD_OEM_PARTCONF=y
>  CONFIG_FASTBOOT_CMD_OEM_BOOTBUS=y
> +CONFIG_SCMI_FIRMWARE=y
>  CONFIG_GPIO_HOG=y
>  CONFIG_DM_HWSPINLOCK=y
>  CONFIG_HWSPINLOCK_STM32=y
> diff --git a/configs/stm32mp15_defconfig b/configs/stm32mp15_defconfig
> index af2efc7bceb0..c26602b63b6f 100644
> --- a/configs/stm32mp15_defconfig
> +++ b/configs/stm32mp15_defconfig
> @@ -88,6 +88,7 @@ CONFIG_FASTBOOT_MMC_USER_SUPPORT=y
>  CONFIG_FASTBOOT_MMC_USER_NAME="mmc1"
>  CONFIG_FASTBOOT_CMD_OEM_PARTCONF=y
>  CONFIG_FASTBOOT_CMD_OEM_BOOTBUS=y
> +CONFIG_SCMI_FIRMWARE=y
>  CONFIG_GPIO_HOG=y
>  CONFIG_DM_HWSPINLOCK=y
>  CONFIG_HWSPINLOCK_STM32=y
> diff --git a/configs/stm32mp15_trusted_defconfig b/configs/stm32mp15_trusted_defconfig
> index 226d83357843..d7501612a797 100644
> --- a/configs/stm32mp15_trusted_defconfig
> +++ b/configs/stm32mp15_trusted_defconfig
> @@ -89,6 +89,7 @@ CONFIG_FASTBOOT_MMC_USER_SUPPORT=y
>  CONFIG_FASTBOOT_MMC_USER_NAME="mmc1"
>  CONFIG_FASTBOOT_CMD_OEM_PARTCONF=y
>  CONFIG_FASTBOOT_CMD_OEM_BOOTBUS=y
> +CONFIG_SCMI_FIRMWARE=y
>  CONFIG_GPIO_HOG=y
>  CONFIG_DM_HWSPINLOCK=y
>  CONFIG_HWSPINLOCK_STM32=y
> diff --git a/configs/stm32mp21_defconfig b/configs/stm32mp21_defconfig
> index 8ad31292579c..6a74a435f8d5 100644
> --- a/configs/stm32mp21_defconfig
> +++ b/configs/stm32mp21_defconfig
> @@ -51,6 +51,7 @@ CONFIG_NO_NET=y
>  CONFIG_SYS_64BIT_LBA=y
>  CONFIG_BUTTON=y
>  CONFIG_BUTTON_GPIO=y
> +CONFIG_SCMI_FIRMWARE=y
>  CONFIG_GPIO_HOG=y
>  CONFIG_DM_I2C=y
>  CONFIG_SYS_I2C_STM32F7=y
> diff --git a/configs/stm32mp23_defconfig b/configs/stm32mp23_defconfig
> index 49f47becba64..ed6fdd9662ef 100644
> --- a/configs/stm32mp23_defconfig
> +++ b/configs/stm32mp23_defconfig
> @@ -51,6 +51,7 @@ CONFIG_NO_NET=y
>  CONFIG_SYS_64BIT_LBA=y
>  CONFIG_BUTTON=y
>  CONFIG_BUTTON_GPIO=y
> +CONFIG_SCMI_FIRMWARE=y
>  CONFIG_GPIO_HOG=y
>  CONFIG_DM_I2C=y
>  CONFIG_SYS_I2C_STM32F7=y
> diff --git a/configs/stm32mp25_defconfig b/configs/stm32mp25_defconfig
> index 99b22a68fda6..42335aafeaf3 100644
> --- a/configs/stm32mp25_defconfig
> +++ b/configs/stm32mp25_defconfig
> @@ -58,6 +58,7 @@ CONFIG_NO_NET=y
>  CONFIG_SYS_64BIT_LBA=y
>  CONFIG_BUTTON=y
>  CONFIG_BUTTON_GPIO=y
> +CONFIG_SCMI_FIRMWARE=y
>  CONFIG_GPIO_HOG=y
>  CONFIG_DM_I2C=y
>  CONFIG_SYS_I2C_STM32F7=y
> diff --git a/drivers/firmware/scmi/Kconfig b/drivers/firmware/scmi/Kconfig
> index 33e089c460ba..cd912ebe4096 100644
> --- a/drivers/firmware/scmi/Kconfig
> +++ b/drivers/firmware/scmi/Kconfig
> @@ -3,6 +3,7 @@ config SCMI_FIRMWARE
>  	select FIRMWARE
>  	select OF_TRANSLATE
>  	depends on SANDBOX || DM_MAILBOX || ARM_SMCCC || OPTEE
> +	depends on OF_CONTROL
>  	help
>  	  System Control and Management Interface (SCMI) is a communication
>  	  protocol that defines standard interfaces for power, performance
> diff --git a/drivers/reset/Kconfig b/drivers/reset/Kconfig
> index 2fd91d6299cc..66911199c8ba 100644
> --- a/drivers/reset/Kconfig
> +++ b/drivers/reset/Kconfig
> @@ -208,7 +208,7 @@ config RESET_RASPBERRYPI
>  
>  config RESET_SCMI
>  	bool "Enable SCMI reset domain driver"
> -	select SCMI_FIRMWARE
> +	depends on SCMI_FIRMWARE
>  	help
>  	  Enable this option if you want to support reset controller
>  	  devices exposed by a SCMI agent based on SCMI reset domain

Reviewed-by: Patrice Chotard <patrice.chotard@foss.st.com>

Thanks
Patrice
