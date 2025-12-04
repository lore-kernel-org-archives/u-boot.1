Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 472CBD24477
	for <u-boot@archiver.kernel.org>; Thu,  4 Dec 2025 18:43:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B57CB84120;
	Thu,  4 Dec 2025 19:43:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="en3iXKa2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 92FAD8412C; Thu,  4 Dec 2025 19:43:30 +0100 (CET)
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazlp17011000f.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c100::f])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B0C678409C
 for <u-boot@lists.denx.de>; Thu,  4 Dec 2025 19:43:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=afd@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=npYu+BeSCUVRJ+rrGsIjTXKhxVo1Vk7xkkBJI34g9dyokDoW4/fgoyszmelR+r6RVBjMC/zrSVkdgH80loiGjz5NP/rl8wkYiLrXl+/BT2uJfDXXCxnR8Wpn+/v5usPaUgyp3TL/9neyE5UGglYphs3hlnBoIEjmAU21BbEs1kZtXdQ9Ka6odQB1xhqLsufYqDPpuLY2ngdlnhrVqgz7AvCZMKWD/p7za0l+yJA9tLNS9qItkAFrlWcHF5HXn46PpqwcpagnG8nzQgBfja/f/MeOnrgZwgOKRZMbRedLymrtN+tZrMHdztsJsP4QOAzk5jnNPqcASGuc3clit9QRNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0nkRtbm03Fgl2ZIp63HJhJzM0tK8wY8aBJwHvLca2l0=;
 b=jfB4PSkUB76jfKbkveyJWP2L2tgBfb+ZzJJNvatanQWYyJDn7yk6uEYBn/BvEJ6+ehge7HdKLKNv+gZZU5ti//o0lcLifjFpXmvShOB/yVBZlrybU7IJ4Dj0ZKASZyQY5G7vKxoVnXp/m/i1oHUtw2S2ovQzOcdmNUK/ZNZwmsKMnqyy7pnRZdnsCqabcnXgHgQSnXn7odZsOLaEn8VYh+EYxCl2Nlhwsb42YDr6bU0TQ8eIs5p7P/UqlUOQgynfXu/eRUABDfG/VpBiSbV3lqAwDJxO8x9j5DV8+ZcZvLwl/gqMetk5DZk5uQm8lEBvdOC3ObGLQAbN47LAAcVE9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=sancloud.com smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0nkRtbm03Fgl2ZIp63HJhJzM0tK8wY8aBJwHvLca2l0=;
 b=en3iXKa2hlE8gcYW9IpzDzLQh92RXta9HfTPWjeHj5V9UQcvDXIuYrOqn0yB/BLVCfcLPIUQkKSsEC51DpFjl+q29Yx4ctl32a5BY+/RDmFk8mnHMpaMEmOi7PjxzAQj5UWEyXNNrxI1NsqFl+P4POUSoxFnnN4rwKjZ8AdAXts=
Received: from CH0PR03CA0072.namprd03.prod.outlook.com (2603:10b6:610:cc::17)
 by CH2PR10MB4149.namprd10.prod.outlook.com (2603:10b6:610:a7::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Thu, 4 Dec
 2025 18:43:23 +0000
Received: from DS2PEPF00003439.namprd02.prod.outlook.com
 (2603:10b6:610:cc:cafe::4f) by CH0PR03CA0072.outlook.office365.com
 (2603:10b6:610:cc::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9388.11 via Frontend Transport; Thu,
 4 Dec 2025 18:43:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 DS2PEPF00003439.mail.protection.outlook.com (10.167.18.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9388.8 via Frontend Transport; Thu, 4 Dec 2025 18:43:22 +0000
Received: from DFLE112.ent.ti.com (10.64.6.33) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.2.2562.20; Thu, 4 Dec
 2025 12:43:20 -0600
Received: from DFLE202.ent.ti.com (10.64.6.60) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Thu, 4
 Dec 2025 12:43:19 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE202.ent.ti.com
 (10.64.6.60) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 4 Dec 2025 12:43:19 -0600
Received: from [10.249.42.149] ([10.249.42.149])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5B4IhJV72019406;
 Thu, 4 Dec 2025 12:43:19 -0600
Message-ID: <42e52490-e940-4382-853c-e8f7029b7c91@ti.com>
Date: Thu, 4 Dec 2025 12:43:18 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/9] configs: am335x_evm: Unify evm board defconfigs
To: "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>,
 <u-boot@lists.denx.de>, Marc Murphy <marc.murphy@sancloud.com>
CC: Tom Rini <trini@konsulko.com>, Rasmus Villemoes <ravi@prevas.dk>, "Kory
 Maincent" <kory.maincent@bootlin.com>, Marek Vasut
 <marek.vasut+renesas@mailbox.org>, Romain Gantois
 <romain.gantois@bootlin.com>, Parvathi Pudi <parvathi@couthit.com>,
 "Basharath Hussain Khaja" <basharath@couthit.com>, Paul Barker
 <paul.barker@sancloud.com>
References: <20251204-topic-am33-evm-oftree-v2026-01-v3-0-3d1566ce4dc7@baylibre.com>
 <20251204-topic-am33-evm-oftree-v2026-01-v3-4-3d1566ce4dc7@baylibre.com>
Content-Language: en-US
From: Andrew Davis <afd@ti.com>
In-Reply-To: <20251204-topic-am33-evm-oftree-v2026-01-v3-4-3d1566ce4dc7@baylibre.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003439:EE_|CH2PR10MB4149:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c80a86e-d6b8-486d-175f-08de3365009d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|7416014|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?R0p1ajRFbmt0bFlySkFsVlRZOS9EOTMxWVNlS1F1WjE4VnBwakRKT2Y3U1hi?=
 =?utf-8?B?WG9hb1ErQ0hyK3Q0WnFUZjUwQW9ROEE4QzQ4K1BmdnM2WXh2NmVWTkUyWE01?=
 =?utf-8?B?NzJSSU9yRExBQnFyT1NWWVpOSHMwVGxGb21kajMwMHRJR1J1R0k2ZmVNa09z?=
 =?utf-8?B?a1pGVEp2ak1MVE9GL240Z3RFVlpNRzlqeFR1TTVFTUJ0MUpnM3htN2xneHJn?=
 =?utf-8?B?QUZhcEZIWXoxcHJ2eHdaTUdMZFNFSVVxeC8zRkR2SWdVTExGR1FEQkNBTzV5?=
 =?utf-8?B?VXlHNjNBZzZUK21aQjlhUm1wc2RhNTFOUXF1Mlc3aC9ZUzZOektRejcvbTRo?=
 =?utf-8?B?c3BURmFzZkwyZmpUaXl2YjJ3VHVzcC9BY29sSE1vcE5rb3VWQXZrVUlqM2sy?=
 =?utf-8?B?QTdSc0tiN1RUUXpNYkdzVDZVU2w3UWpkaTRUdkFyMUxyN1Z0NXZRUTFDZENm?=
 =?utf-8?B?TWNwNFN1NDBFckJWSFBZRit0UytOcEtkdzNwRWs4QTdlMzcycVZkWElrcTlJ?=
 =?utf-8?B?UnZsellmOWNNWHIxb3hrdVVWNDM2UHFmZ2Nwa0J2QS9ndTFzeFFqdDVtVzlt?=
 =?utf-8?B?Q3Zwak1KbFFMeW9VR29yQzVrNUpsa3NmaGtnSG1QeDZQT0Ercm5EVW03S3po?=
 =?utf-8?B?V1FIWW91d3p5RmdWNE9jL3RPY3BuMEthckloN2Z2U2d1UkptV2ZEVmNTdmdH?=
 =?utf-8?B?bHVNTVh2SlNKbDBjTXdBMzdZSmd4UVRmSDVsRVJpK1N6VzhlVDhMbktyRWlq?=
 =?utf-8?B?dVdtUng3ZndJcy83bHVFMmpHYU9MMERCdDlURHJBSGd5RWk3S1pRL2xtT21z?=
 =?utf-8?B?blNGZHI1UkhrbXNQM015UTNyRW5MckxYWEFGUmc2d1RJU2FTbENTdW5nRFNh?=
 =?utf-8?B?cWcyVDJyR05lVlZ2eERyYWpnQ1VscXp6TXZUKzlYTU5rQzN5a1dGaFZZNU5V?=
 =?utf-8?B?SjVCQ3cvbDN2TDlza3RBOTFWSFhXN2dDRGp1ejRzS0lqd1IwVkZ1L0h4K2w4?=
 =?utf-8?B?L2RwcDA5bmJVbFdWczlYajVJYnJINnh2RUZWVm14U2kvd0kwMHEzeUREZHBy?=
 =?utf-8?B?WW5Ub3JZdTdiTkUrc2kwS1JxRDlUWUtPT3IzM0xVNkJONlJYQlVrR3BXUnI2?=
 =?utf-8?B?MUp1ZnRPVTAwL1QxNXZVMVA4RlJwVHFoVzZoNlFJRXBOTkU1YjVZL1FnVzN6?=
 =?utf-8?B?dW9KNEJXd0hhSmhuNkJydjV0ZGdNOW56VVZwK25iVmVKWnNxWHdIUElmOXBK?=
 =?utf-8?B?ZlZOcHJ2cUtMSnAvNzFQNnNUcTNDeStKQ0l0c0ZRRk5CazVCQ1F0SE4yUkFp?=
 =?utf-8?B?dVVidmdYN0dzbVNZM3UwUzgzRjV5MkNVbi9pUGo5eVl2Y3V1UzY1WjZpcE1z?=
 =?utf-8?B?RmFHbEZ0UmxWamxWSjNmZGpMYzgyc2F6UVM0NGttSkJrdjFqVnFqV2FSTHFI?=
 =?utf-8?B?c3U5TE5EbEFEekpvTVJQOWdwWGtSM3U3OE5pOGpjbk5vb3d4WGtORjAwYkdZ?=
 =?utf-8?B?MjVvN2k1ckQ5ZHlwR0NNbVMvaHJpOHdSZ01weVU0aUZNcGRkSEdldFJBK2NX?=
 =?utf-8?B?WDFLeVFZN1lOK1VDRG9PNDR2eXhzODBsZXk4d2czWjY1VkUwOXBvdFRSTytQ?=
 =?utf-8?B?RW8rVVpTdWxCZ1BRdkFwbWQ1T0dNc1JBRXYzVGdpR29RWk5TbnAydTBoRlFi?=
 =?utf-8?B?K2haUzI4YkdLNHA4cW5XWmRKaW1URWQyM2Y5WWlyMG44ZGFYVExNTG5iRVhY?=
 =?utf-8?B?M2h2b08xQkJCdXhGa1lkUEl6NWwzUFhyUFRjWm81bFZWTW1PN25LemUvczds?=
 =?utf-8?B?S3RoTkVQamwzSDFVZHdvbUlHZzhqNHczd0RNS3Bab2x3VEZ0bEhLdlExZ1Zx?=
 =?utf-8?B?VW45eWZZVTFuanRxVTA2cUhxMmRaQTNDU0pwWERBSEZjSlBOOWdzQ2pTTjNp?=
 =?utf-8?B?WlNvTUszaFRYTjR0UTJBTWU4R0d3RFBoL0IyYk9UZDBiZVc2WjVmc3ZjY2tD?=
 =?utf-8?B?eDJHckZhT3YzbUQ2ZTNpT2RiekVCWld4TzRLS2x6NHh0c25XcjdnNnk4aW05?=
 =?utf-8?B?V0ZkSVpmOGZEVXVpQ3JiOXB4UndCZFJzMzc3VldmaFFCelhaVzlML2VSSnUw?=
 =?utf-8?Q?lMns=3D?=
X-Forefront-Antispam-Report: CIP:198.47.21.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet201.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(7416014)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2025 18:43:22.7037 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c80a86e-d6b8-486d-175f-08de3365009d
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.195];
 Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003439.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4149
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

On 12/4/25 4:25 AM, Markus Schneider-Pargmann (TI.com) wrote:
> Much of the config symbols between the evm boards are the same
> independent of the actual board. This patch creates a hierarchy for the
> am335x_evm configs:
> 
>    am335x_evm.config
>    `-> am335x_evm_defconfig
>    `-> am335x_evm_spiboot_defconfig
>    `-> am335x_hs_evm.config
>        `-> am335x_hs_evm_defconfig
>        `-> am335x_hs_evm_uart_defconfig
> 

Idea looks good to me, but why not have am335x_evm_defconfig be the top
of the hierarchy instead of a new file? Same for HS, so something like this:

     am335x_evm_defconfig
     `-> am335x_evm_spiboot_defconfig
     `-> am335x_hs_evm_defconfig
         `-> am335x_hs_evm_uart_defconfig

Andrew

> Signed-off-by: Markus Schneider-Pargmann (TI.com) <msp@baylibre.com>
> ---
>   configs/am335x_evm.config            | 81 ++++++++++++++++++++++++++++++
>   configs/am335x_evm_defconfig         | 83 +------------------------------
>   configs/am335x_evm_spiboot_defconfig | 83 +------------------------------
>   configs/am335x_hs_evm.config         | 14 ++++++
>   configs/am335x_hs_evm_defconfig      | 95 +-----------------------------------
>   configs/am335x_hs_evm_uart_defconfig | 94 +----------------------------------
>   6 files changed, 103 insertions(+), 347 deletions(-)
> 
> diff --git a/configs/am335x_evm.config b/configs/am335x_evm.config
> new file mode 100644
> index 0000000000000000000000000000000000000000..ba39ae274c4095a61f2d102f0bc3de6d0637f53a
> --- /dev/null
> +++ b/configs/am335x_evm.config
> @@ -0,0 +1,81 @@
> +CONFIG_ARM=y
> +CONFIG_ARCH_CPU_INIT=y
> +CONFIG_ARCH_OMAP2PLUS=y
> +CONFIG_TI_COMMON_CMD_OPTIONS=y
> +CONFIG_SF_DEFAULT_SPEED=24000000
> +CONFIG_DEFAULT_DEVICE_TREE="am335x-evm"
> +CONFIG_AM33XX=y
> +CONFIG_CLOCK_SYNTHESIZER=y
> +CONFIG_SYS_BOOTM_LEN=0x1000000
> +CONFIG_SPL=y
> +CONFIG_TIMESTAMP=y
> +CONFIG_SPL_LOAD_FIT=y
> +CONFIG_DISTRO_DEFAULTS=y
> +CONFIG_OF_BOARD_SETUP=y
> +CONFIG_BOOTCOMMAND="run findfdt; run init_console; run finduuid; run distro_bootcmd"
> +CONFIG_LOGLEVEL=3
> +CONFIG_SYS_CONSOLE_INFO_QUIET=y
> +CONFIG_SPL_SYS_MALLOC=y
> +CONFIG_SPL_SYS_MALLOC_SIZE=0x800000
> +CONFIG_SPL_FIT_IMAGE_TINY=y
> +# CONFIG_SPL_FS_EXT4 is not set
> +CONFIG_SPL_MTD=y
> +CONFIG_SYS_I2C_EEPROM_ADDR_LEN=2
> +CONFIG_CMD_NAND=y
> +CONFIG_BOOTP_DNS2=y
> +CONFIG_CMD_MTDPARTS=y
> +# CONFIG_SPL_EFI_PARTITION is not set
> +CONFIG_OF_CONTROL=y
> +CONFIG_ENV_OVERWRITE=y
> +CONFIG_ENV_RELOC_GD_ENV_ADDR=y
> +CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
> +CONFIG_VERSION_VARIABLE=y
> +CONFIG_NET_RETRY_COUNT=10
> +CONFIG_BOOTP_SEND_HOSTNAME=y
> +CONFIG_BOOTCOUNT_LIMIT=y
> +CONFIG_SYS_BOOTCOUNT_BE=y
> +CONFIG_CLK_CDCE9XX=y
> +CONFIG_DFU_MMC=y
> +CONFIG_DFU_NAND=y
> +CONFIG_DFU_RAM=y
> +CONFIG_USB_FUNCTION_FASTBOOT=y
> +CONFIG_DM_I2C=y
> +CONFIG_SYS_I2C_EEPROM_ADDR=0x50
> +# CONFIG_MMC_HW_PARTITIONING is not set
> +CONFIG_MMC_OMAP_HS=y
> +CONFIG_MTD=y
> +CONFIG_MTD_RAW_NAND=y
> +CONFIG_SYS_NAND_ONFI_DETECTION=y
> +CONFIG_SYS_NAND_PAGE_SIZE=0x800
> +CONFIG_SYS_NAND_OOBSIZE=0x40
> +CONFIG_SYS_NAND_U_BOOT_LOCATIONS=y
> +CONFIG_SYS_NAND_U_BOOT_OFFS=0xc0000
> +CONFIG_DM_SPI_FLASH=y
> +CONFIG_SPI_FLASH_WINBOND=y
> +CONFIG_PHY_ATHEROS=y
> +CONFIG_PHY_SMSC=y
> +CONFIG_MII=y
> +CONFIG_DRIVER_TI_CPSW=y
> +CONFIG_DM_PMIC=y
> +# CONFIG_SPL_DM_PMIC is not set
> +CONFIG_PMIC_TPS65217=y
> +CONFIG_SPL_POWER_TPS65910=y
> +CONFIG_SPI=y
> +CONFIG_DM_SPI=y
> +CONFIG_OMAP3_SPI=y
> +CONFIG_TIMER=y
> +CONFIG_OMAP_TIMER=y
> +CONFIG_USB=y
> +CONFIG_DM_USB_GADGET=y
> +CONFIG_USB_MUSB_HOST=y
> +CONFIG_USB_MUSB_GADGET=y
> +CONFIG_USB_MUSB_TI=y
> +CONFIG_USB_GADGET=y
> +CONFIG_USB_GADGET_MANUFACTURER="Texas Instruments"
> +CONFIG_USB_GADGET_VENDOR_NUM=0x0451
> +CONFIG_USB_GADGET_PRODUCT_NUM=0xd022
> +CONFIG_USB_ETHER=y
> +CONFIG_WDT=y
> +# CONFIG_SPL_WDT is not set
> +CONFIG_DYNAMIC_CRC_TABLE=y
> +CONFIG_LZO=y
> diff --git a/configs/am335x_evm_defconfig b/configs/am335x_evm_defconfig
> index bd188c252780fb541afbbe61a243bddaab79be93..448b0a8308fcca04732b81313c72f7fd2247d1ca 100644
> --- a/configs/am335x_evm_defconfig
> +++ b/configs/am335x_evm_defconfig
> @@ -1,32 +1,12 @@
> -CONFIG_ARM=y
> -CONFIG_ARCH_CPU_INIT=y
> -CONFIG_ARCH_OMAP2PLUS=y
> -CONFIG_TI_COMMON_CMD_OPTIONS=y
> -CONFIG_SF_DEFAULT_SPEED=24000000
> -CONFIG_DEFAULT_DEVICE_TREE="am335x-evm"
> -CONFIG_AM33XX=y
> -CONFIG_CLOCK_SYNTHESIZER=y
> +#include <configs/am335x_evm.config>
> +
>   CONFIG_AM335X_USB0=y
>   CONFIG_AM335X_USB0_PERIPHERAL=y
>   CONFIG_AM335X_USB1=y
> -CONFIG_SYS_BOOTM_LEN=0x1000000
> -CONFIG_SPL=y
> -CONFIG_TIMESTAMP=y
>   CONFIG_FIT_SIGNATURE=y
>   CONFIG_FIT_VERBOSE=y
> -CONFIG_SPL_LOAD_FIT=y
> -CONFIG_DISTRO_DEFAULTS=y
> -CONFIG_OF_BOARD_SETUP=y
> -CONFIG_BOOTCOMMAND="run findfdt; run init_console; run finduuid; run distro_bootcmd"
> -CONFIG_LOGLEVEL=3
> -CONFIG_SYS_CONSOLE_INFO_QUIET=y
> -CONFIG_SPL_SYS_MALLOC=y
> -CONFIG_SPL_SYS_MALLOC_SIZE=0x800000
> -CONFIG_SPL_FIT_IMAGE_TINY=y
>   CONFIG_SPL_ETH=y
> -# CONFIG_SPL_FS_EXT4 is not set
>   CONFIG_SPL_FS_LOAD_PAYLOAD_NAME="u-boot.img"
> -CONFIG_SPL_MTD=y
>   CONFIG_SPL_MUSB_NEW=y
>   CONFIG_SPL_NAND_DRIVERS=y
>   CONFIG_SPL_NAND_ECC=y
> @@ -41,90 +21,31 @@ CONFIG_SYS_MMCSD_RAW_MODE_ARGS_SECTOR=0x1500
>   CONFIG_SYS_MMCSD_RAW_MODE_ARGS_SECTORS=0x200
>   CONFIG_CMD_EXTENSION=y
>   CONFIG_CMD_SPL_NAND_OFS=0x00080000
> -CONFIG_SYS_I2C_EEPROM_ADDR_LEN=2
> -CONFIG_CMD_NAND=y
>   # CONFIG_CMD_SETEXPR is not set
> -CONFIG_BOOTP_DNS2=y
> -CONFIG_CMD_MTDPARTS=y
>   CONFIG_MTDIDS_DEFAULT="nand0=nand.0"
>   CONFIG_MTDPARTS_DEFAULT="mtdparts=nand.0:128k(NAND.SPL),128k(NAND.SPL.backup1),128k(NAND.SPL.backup2),128k(NAND.SPL.backup3),256k(NAND.u-boot-spl-os),1m(NAND.u-boot),128k(NAND.u-boot-env),128k(NAND.u-boot-env.backup1),8m(NAND.kernel),-(NAND.file-system)"
> -# CONFIG_SPL_EFI_PARTITION is not set
> -CONFIG_OF_CONTROL=y
>   CONFIG_OF_LIST="am335x-evm am335x-bone am335x-sancloud-bbe am335x-sancloud-bbe-lite am335x-sancloud-bbe-extended-wifi am335x-boneblack am335x-evmsk am335x-bonegreen am335x-icev2 am335x-pocketbeagle am335x-bonegreen-eco"
> -CONFIG_ENV_OVERWRITE=y
> -CONFIG_ENV_RELOC_GD_ENV_ADDR=y
> -CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
>   CONFIG_SPL_ENV_IS_NOWHERE=y
> -CONFIG_VERSION_VARIABLE=y
> -CONFIG_NET_RETRY_COUNT=10
> -CONFIG_BOOTP_SEND_HOSTNAME=y
> -CONFIG_BOOTCOUNT_LIMIT=y
> -CONFIG_SYS_BOOTCOUNT_BE=y
>   CONFIG_CLK=y
>   CONFIG_CLK_CCF=y
> -CONFIG_CLK_CDCE9XX=y
>   CONFIG_CLK_TI_AM3_DPLL=y
>   CONFIG_CLK_TI_CTRL=y
>   CONFIG_CLK_TI_DIVIDER=y
>   CONFIG_CLK_TI_GATE=y
>   CONFIG_CLK_TI_MUX=y
>   CONFIG_DFU_TFTP=y
> -CONFIG_DFU_MMC=y
> -CONFIG_DFU_NAND=y
> -CONFIG_DFU_RAM=y
> -CONFIG_USB_FUNCTION_FASTBOOT=y
>   CONFIG_FASTBOOT_FLASH=y
>   CONFIG_FASTBOOT_FLASH_MMC_DEV=1
>   CONFIG_FASTBOOT_CMD_OEM_FORMAT=y
> -CONFIG_DM_I2C=y
>   CONFIG_MISC=y
> -CONFIG_SYS_I2C_EEPROM_ADDR=0x50
> -# CONFIG_MMC_HW_PARTITIONING is not set
> -CONFIG_MMC_OMAP_HS=y
> -CONFIG_MTD=y
> -CONFIG_MTD_RAW_NAND=y
>   CONFIG_SYS_NAND_BLOCK_SIZE=0x20000
> -CONFIG_SYS_NAND_ONFI_DETECTION=y
> -CONFIG_SYS_NAND_PAGE_SIZE=0x800
> -CONFIG_SYS_NAND_OOBSIZE=0x40
> -CONFIG_SYS_NAND_U_BOOT_LOCATIONS=y
> -CONFIG_SYS_NAND_U_BOOT_OFFS=0xc0000
> -CONFIG_DM_SPI_FLASH=y
>   CONFIG_SPI_FLASH_STMICRO=y
> -CONFIG_SPI_FLASH_WINBOND=y
> -CONFIG_PHY_ATHEROS=y
> -CONFIG_PHY_SMSC=y
>   CONFIG_PHY_TI_DP83867=y
>   CONFIG_PHY_GIGE=y
> -CONFIG_MII=y
> -CONFIG_DRIVER_TI_CPSW=y
> -CONFIG_DM_PMIC=y
> -# CONFIG_SPL_DM_PMIC is not set
> -CONFIG_PMIC_TPS65217=y
> -CONFIG_SPL_POWER_TPS65910=y
>   CONFIG_DM_PWM=y
>   CONFIG_PWM_TI_ECAP=y
> -CONFIG_SPI=y
> -CONFIG_DM_SPI=y
> -CONFIG_OMAP3_SPI=y
> -CONFIG_TIMER=y
> -CONFIG_OMAP_TIMER=y
> -CONFIG_USB=y
> -CONFIG_DM_USB_GADGET=y
>   CONFIG_SPL_DM_USB_GADGET=y
> -CONFIG_USB_MUSB_HOST=y
> -CONFIG_USB_MUSB_GADGET=y
> -CONFIG_USB_MUSB_TI=y
> -CONFIG_USB_GADGET=y
>   CONFIG_SPL_USB_GADGET=y
> -CONFIG_USB_GADGET_MANUFACTURER="Texas Instruments"
> -CONFIG_USB_GADGET_VENDOR_NUM=0x0451
> -CONFIG_USB_GADGET_PRODUCT_NUM=0xd022
> -CONFIG_USB_ETHER=y
>   CONFIG_SPL_USB_ETHER=y
>   CONFIG_VIDEO=y
>   CONFIG_AM335X_LCD=y
> -CONFIG_WDT=y
> -# CONFIG_SPL_WDT is not set
> -CONFIG_DYNAMIC_CRC_TABLE=y
> -CONFIG_LZO=y
> diff --git a/configs/am335x_evm_spiboot_defconfig b/configs/am335x_evm_spiboot_defconfig
> index 97f56f36aa6c5912bbd5fec7580cd1cd204bec2f..eebd916c02a2cad0d01ab738aab37b11dd3a9645 100644
> --- a/configs/am335x_evm_spiboot_defconfig
> +++ b/configs/am335x_evm_spiboot_defconfig
> @@ -1,108 +1,29 @@
> -CONFIG_ARM=y
> -CONFIG_ARCH_CPU_INIT=y
> -CONFIG_ARCH_OMAP2PLUS=y
> -CONFIG_TI_COMMON_CMD_OPTIONS=y
> -CONFIG_SF_DEFAULT_SPEED=24000000
> +#include <configs/am335x_evm.config>
> +
>   CONFIG_ENV_OFFSET=0x100000
>   CONFIG_SPL_DM_SPI=y
> -CONFIG_DEFAULT_DEVICE_TREE="am335x-evm"
> -CONFIG_AM33XX=y
> -CONFIG_CLOCK_SYNTHESIZER=y
>   # CONFIG_SPL_MMC is not set
> -CONFIG_SYS_BOOTM_LEN=0x1000000
> -CONFIG_SPL=y
>   # CONFIG_SPL_FS_FAT is not set
>   CONFIG_SPL_SPI_FLASH_SUPPORT=y
>   CONFIG_SPL_SPI=y
> -CONFIG_TIMESTAMP=y
> -CONFIG_SPL_LOAD_FIT=y
> -CONFIG_DISTRO_DEFAULTS=y
> -CONFIG_OF_BOARD_SETUP=y
> -CONFIG_BOOTCOMMAND="run findfdt; run init_console; run finduuid; run distro_bootcmd"
> -CONFIG_LOGLEVEL=3
> -CONFIG_SYS_CONSOLE_INFO_QUIET=y
> -CONFIG_SPL_SYS_MALLOC=y
> -CONFIG_SPL_SYS_MALLOC_SIZE=0x800000
> -CONFIG_SPL_FIT_IMAGE_TINY=y
> -# CONFIG_SPL_FS_EXT4 is not set
> -CONFIG_SPL_MTD=y
>   # CONFIG_SPL_NAND_SUPPORT is not set
>   CONFIG_SPL_DM_SPI_FLASH=y
>   CONFIG_SPL_SPI_LOAD=y
>   CONFIG_SYS_SPI_U_BOOT_OFFS=0x20000
> -CONFIG_SYS_I2C_EEPROM_ADDR_LEN=2
> -CONFIG_CMD_NAND=y
>   # CONFIG_CMD_SETEXPR is not set
> -CONFIG_BOOTP_DNS2=y
> -CONFIG_CMD_MTDPARTS=y
> -# CONFIG_SPL_EFI_PARTITION is not set
> -CONFIG_OF_CONTROL=y
>   CONFIG_SPL_OF_CONTROL=y
>   CONFIG_OF_LIST="am335x-evm am335x-bone am335x-boneblack am335x-evmsk am335x-bonegreen am335x-icev2 am335x-pocketbeagle am335x-bonegreen-eco"
> -CONFIG_ENV_OVERWRITE=y
>   # CONFIG_ENV_IS_IN_FAT is not set
>   CONFIG_ENV_IS_IN_SPI_FLASH=y
> -CONFIG_ENV_RELOC_GD_ENV_ADDR=y
> -CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
>   CONFIG_SPL_ENV_IS_NOWHERE=y
> -CONFIG_VERSION_VARIABLE=y
> -CONFIG_NET_RETRY_COUNT=10
> -CONFIG_BOOTP_SEND_HOSTNAME=y
>   CONFIG_SPL_OF_TRANSLATE=y
>   CONFIG_SPL_TI_SYSC=y
> -CONFIG_BOOTCOUNT_LIMIT=y
> -CONFIG_SYS_BOOTCOUNT_BE=y
>   CONFIG_SPL_CLK=y
> -CONFIG_CLK_CDCE9XX=y
>   CONFIG_CLK_TI_CTRL=y
>   CONFIG_DFU_TFTP=y
> -CONFIG_DFU_MMC=y
> -CONFIG_DFU_NAND=y
> -CONFIG_DFU_RAM=y
> -CONFIG_USB_FUNCTION_FASTBOOT=y
>   CONFIG_FASTBOOT_FLASH=y
>   CONFIG_FASTBOOT_FLASH_MMC_DEV=1
>   CONFIG_FASTBOOT_CMD_OEM_FORMAT=y
> -CONFIG_DM_I2C=y
> -CONFIG_SYS_I2C_EEPROM_ADDR=0x50
>   # CONFIG_SPL_DM_MMC is not set
> -# CONFIG_MMC_HW_PARTITIONING is not set
> -CONFIG_MMC_OMAP_HS=y
> -CONFIG_MTD=y
> -CONFIG_MTD_RAW_NAND=y
> -CONFIG_SYS_NAND_ONFI_DETECTION=y
> -CONFIG_SYS_NAND_PAGE_SIZE=0x800
> -CONFIG_SYS_NAND_OOBSIZE=0x40
> -CONFIG_SYS_NAND_U_BOOT_LOCATIONS=y
> -CONFIG_SYS_NAND_U_BOOT_OFFS=0xc0000
> -CONFIG_DM_SPI_FLASH=y
>   CONFIG_SPI_FLASH_STMICRO=y
> -CONFIG_SPI_FLASH_WINBOND=y
> -CONFIG_PHY_ATHEROS=y
> -CONFIG_PHY_SMSC=y
> -CONFIG_MII=y
> -CONFIG_DRIVER_TI_CPSW=y
> -CONFIG_DM_PMIC=y
> -# CONFIG_SPL_DM_PMIC is not set
> -CONFIG_PMIC_TPS65217=y
> -CONFIG_SPL_POWER_TPS65910=y
> -CONFIG_SPI=y
> -CONFIG_DM_SPI=y
> -CONFIG_OMAP3_SPI=y
> -CONFIG_TIMER=y
> -CONFIG_OMAP_TIMER=y
> -CONFIG_USB=y
> -CONFIG_DM_USB_GADGET=y
> -CONFIG_USB_MUSB_HOST=y
> -CONFIG_USB_MUSB_GADGET=y
> -CONFIG_USB_MUSB_TI=y
> -CONFIG_USB_GADGET=y
> -CONFIG_USB_GADGET_MANUFACTURER="Texas Instruments"
> -CONFIG_USB_GADGET_VENDOR_NUM=0x0451
> -CONFIG_USB_GADGET_PRODUCT_NUM=0xd022
> -CONFIG_USB_ETHER=y
> -CONFIG_WDT=y
> -# CONFIG_SPL_WDT is not set
> -CONFIG_DYNAMIC_CRC_TABLE=y
>   CONFIG_RSA=y
> -CONFIG_LZO=y
> diff --git a/configs/am335x_hs_evm.config b/configs/am335x_hs_evm.config
> new file mode 100644
> index 0000000000000000000000000000000000000000..7ade2fb163b204ad8bcc9554455fdd3e81657890
> --- /dev/null
> +++ b/configs/am335x_hs_evm.config
> @@ -0,0 +1,14 @@
> +#include <configs/am335x_evm.config>
> +
> +CONFIG_TI_SECURE_DEVICE=y
> +# CONFIG_SPL_ENV_SUPPORT is not set
> +CONFIG_SPL_FS_LOAD_PAYLOAD_NAME="u-boot.img"
> +# CONFIG_SPL_NAND_SUPPORT is not set
> +CONFIG_SPL_NAND_DRIVERS=y
> +CONFIG_SPL_NAND_ECC=y
> +CONFIG_MTDIDS_DEFAULT="nand0=nand.0"
> +CONFIG_MTDPARTS_DEFAULT="mtdparts=nand.0:128k(NAND.SPL),128k(NAND.SPL.backup1),128k(NAND.SPL.backup2),128k(NAND.SPL.backup3),256k(NAND.u-boot-spl-os),1m(NAND.u-boot),128k(NAND.u-boot-env),128k(NAND.u-boot-env.backup1),8m(NAND.kernel),-(NAND.file-system)"
> +CONFIG_OF_LIST="am335x-evm am335x-bone am335x-boneblack am335x-evmsk am335x-bonegreen am335x-icev2 am335x-pocketbeagle am335x-bonegreen-eco"
> +CONFIG_SPL_DM_USB_GADGET=y
> +CONFIG_SPL_TINY_MEMSET=y
> +CONFIG_RSA=y
> diff --git a/configs/am335x_hs_evm_defconfig b/configs/am335x_hs_evm_defconfig
> index e4eedd439c8a26052f57764059d660fbfabcb15b..8f140fa5b1e9d0edc80374fdd740e0ba9c65935d 100644
> --- a/configs/am335x_hs_evm_defconfig
> +++ b/configs/am335x_hs_evm_defconfig
> @@ -1,96 +1,5 @@
> -CONFIG_ARM=y
> -CONFIG_ARCH_CPU_INIT=y
> -CONFIG_ARCH_OMAP2PLUS=y
> -CONFIG_TI_SECURE_DEVICE=y
> -CONFIG_TI_COMMON_CMD_OPTIONS=y
> -CONFIG_SF_DEFAULT_SPEED=24000000
> -CONFIG_DEFAULT_DEVICE_TREE="am335x-evm"
> -CONFIG_AM33XX=y
> -CONFIG_CLOCK_SYNTHESIZER=y
> +#include <configs/am335x_hs_evm.config>
> +
>   CONFIG_SPL_TEXT_BASE=0x40300350
> -CONFIG_SYS_BOOTM_LEN=0x1000000
> -CONFIG_SPL=y
> -CONFIG_TIMESTAMP=y
> -CONFIG_SPL_LOAD_FIT=y
> -CONFIG_DISTRO_DEFAULTS=y
> -CONFIG_OF_BOARD_SETUP=y
> -CONFIG_BOOTCOMMAND="run findfdt; run init_console; run finduuid; run distro_bootcmd"
> -CONFIG_LOGLEVEL=3
> -CONFIG_SYS_CONSOLE_INFO_QUIET=y
>   CONFIG_SPL_MAX_SIZE=0xb0b0
> -CONFIG_SPL_SYS_MALLOC=y
> -CONFIG_SPL_SYS_MALLOC_SIZE=0x800000
> -CONFIG_SPL_FIT_IMAGE_TINY=y
> -# CONFIG_SPL_ENV_SUPPORT is not set
> -# CONFIG_SPL_FS_EXT4 is not set
> -CONFIG_SPL_FS_LOAD_PAYLOAD_NAME="u-boot.img"
> -CONFIG_SPL_MTD=y
> -# CONFIG_SPL_NAND_SUPPORT is not set
> -CONFIG_SPL_NAND_DRIVERS=y
> -CONFIG_SPL_NAND_ECC=y
>   # CONFIG_SPL_YMODEM_SUPPORT is not set
> -CONFIG_SYS_I2C_EEPROM_ADDR_LEN=2
> -CONFIG_CMD_NAND=y
> -CONFIG_BOOTP_DNS2=y
> -CONFIG_CMD_MTDPARTS=y
> -CONFIG_MTDIDS_DEFAULT="nand0=nand.0"
> -CONFIG_MTDPARTS_DEFAULT="mtdparts=nand.0:128k(NAND.SPL),128k(NAND.SPL.backup1),128k(NAND.SPL.backup2),128k(NAND.SPL.backup3),256k(NAND.u-boot-spl-os),1m(NAND.u-boot),128k(NAND.u-boot-env),128k(NAND.u-boot-env.backup1),8m(NAND.kernel),-(NAND.file-system)"
> -# CONFIG_SPL_EFI_PARTITION is not set
> -CONFIG_OF_CONTROL=y
> -CONFIG_OF_LIST="am335x-evm am335x-bone am335x-boneblack am335x-evmsk am335x-bonegreen am335x-icev2 am335x-pocketbeagle am335x-bonegreen-eco"
> -CONFIG_ENV_OVERWRITE=y
> -CONFIG_ENV_RELOC_GD_ENV_ADDR=y
> -CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
> -CONFIG_VERSION_VARIABLE=y
> -CONFIG_NET_RETRY_COUNT=10
> -CONFIG_BOOTP_SEND_HOSTNAME=y
> -CONFIG_BOOTCOUNT_LIMIT=y
> -CONFIG_SYS_BOOTCOUNT_BE=y
> -CONFIG_CLK_CDCE9XX=y
> -CONFIG_DFU_MMC=y
> -CONFIG_DFU_NAND=y
> -CONFIG_DFU_RAM=y
> -CONFIG_USB_FUNCTION_FASTBOOT=y
> -CONFIG_DM_I2C=y
> -CONFIG_SYS_I2C_EEPROM_ADDR=0x50
> -# CONFIG_MMC_HW_PARTITIONING is not set
> -CONFIG_MMC_OMAP_HS=y
> -CONFIG_MTD=y
> -CONFIG_MTD_RAW_NAND=y
> -CONFIG_SYS_NAND_ONFI_DETECTION=y
> -CONFIG_SYS_NAND_PAGE_SIZE=0x800
> -CONFIG_SYS_NAND_OOBSIZE=0x40
> -CONFIG_SYS_NAND_U_BOOT_LOCATIONS=y
> -CONFIG_SYS_NAND_U_BOOT_OFFS=0xc0000
> -CONFIG_DM_SPI_FLASH=y
> -CONFIG_SPI_FLASH_WINBOND=y
> -CONFIG_PHY_ATHEROS=y
> -CONFIG_PHY_SMSC=y
> -CONFIG_MII=y
> -CONFIG_DRIVER_TI_CPSW=y
> -CONFIG_DM_PMIC=y
> -# CONFIG_SPL_DM_PMIC is not set
> -CONFIG_PMIC_TPS65217=y
> -CONFIG_SPL_POWER_TPS65910=y
> -CONFIG_SPI=y
> -CONFIG_DM_SPI=y
> -CONFIG_OMAP3_SPI=y
> -CONFIG_TIMER=y
> -CONFIG_OMAP_TIMER=y
> -CONFIG_USB=y
> -CONFIG_DM_USB_GADGET=y
> -CONFIG_SPL_DM_USB_GADGET=y
> -CONFIG_USB_MUSB_HOST=y
> -CONFIG_USB_MUSB_GADGET=y
> -CONFIG_USB_MUSB_TI=y
> -CONFIG_USB_GADGET=y
> -CONFIG_USB_GADGET_MANUFACTURER="Texas Instruments"
> -CONFIG_USB_GADGET_VENDOR_NUM=0x0451
> -CONFIG_USB_GADGET_PRODUCT_NUM=0xd022
> -CONFIG_USB_ETHER=y
> -CONFIG_WDT=y
> -# CONFIG_SPL_WDT is not set
> -CONFIG_DYNAMIC_CRC_TABLE=y
> -CONFIG_SPL_TINY_MEMSET=y
> -CONFIG_RSA=y
> -CONFIG_LZO=y
> diff --git a/configs/am335x_hs_evm_uart_defconfig b/configs/am335x_hs_evm_uart_defconfig
> index f60f63f87d7018e10840b27ee9c5afc179c1e167..ff60802fdf1b01c53b650993d14b7ca0a081af9b 100644
> --- a/configs/am335x_hs_evm_uart_defconfig
> +++ b/configs/am335x_hs_evm_uart_defconfig
> @@ -1,98 +1,8 @@
> -CONFIG_ARM=y
> -CONFIG_ARCH_CPU_INIT=y
> -CONFIG_ARCH_OMAP2PLUS=y
> -CONFIG_TI_SECURE_DEVICE=y
> -CONFIG_TI_COMMON_CMD_OPTIONS=y
> -CONFIG_SF_DEFAULT_SPEED=24000000
> -CONFIG_DEFAULT_DEVICE_TREE="am335x-evm"
> -CONFIG_AM33XX=y
> -CONFIG_CLOCK_SYNTHESIZER=y
> +#include <configs/am335x_hs_evm.config>
> +
>   # CONFIG_SPL_MMC is not set
>   CONFIG_SPL_TEXT_BASE=0x40301950
> -CONFIG_SYS_BOOTM_LEN=0x1000000
> -CONFIG_SPL=y
>   # CONFIG_SPL_FS_FAT is not set
>   # CONFIG_SPL_LIBDISK_SUPPORT is not set
> -CONFIG_TIMESTAMP=y
> -CONFIG_SPL_LOAD_FIT=y
> -CONFIG_DISTRO_DEFAULTS=y
> -CONFIG_OF_BOARD_SETUP=y
> -CONFIG_BOOTCOMMAND="run findfdt; run init_console; run finduuid; run distro_bootcmd"
> -CONFIG_LOGLEVEL=3
> -CONFIG_SYS_CONSOLE_INFO_QUIET=y
>   CONFIG_SPL_MAX_SIZE=0x9ab0
> -CONFIG_SPL_SYS_MALLOC=y
> -CONFIG_SPL_SYS_MALLOC_SIZE=0x800000
> -CONFIG_SPL_FIT_IMAGE_TINY=y
> -# CONFIG_SPL_ENV_SUPPORT is not set
> -# CONFIG_SPL_FS_EXT4 is not set
> -CONFIG_SPL_MTD=y
> -# CONFIG_SPL_NAND_SUPPORT is not set
> -CONFIG_SPL_NAND_DRIVERS=y
> -CONFIG_SPL_NAND_ECC=y
> -CONFIG_SYS_I2C_EEPROM_ADDR_LEN=2
> -CONFIG_CMD_NAND=y
>   # CONFIG_CMD_SETEXPR is not set
> -CONFIG_BOOTP_DNS2=y
> -CONFIG_CMD_MTDPARTS=y
> -CONFIG_MTDIDS_DEFAULT="nand0=nand.0"
> -CONFIG_MTDPARTS_DEFAULT="mtdparts=nand.0:128k(NAND.SPL),128k(NAND.SPL.backup1),128k(NAND.SPL.backup2),128k(NAND.SPL.backup3),256k(NAND.u-boot-spl-os),1m(NAND.u-boot),128k(NAND.u-boot-env),128k(NAND.u-boot-env.backup1),8m(NAND.kernel),-(NAND.file-system)"
> -# CONFIG_SPL_EFI_PARTITION is not set
> -CONFIG_OF_CONTROL=y
> -CONFIG_OF_LIST="am335x-evm am335x-bone am335x-boneblack am335x-evmsk am335x-bonegreen am335x-icev2 am335x-pocketbeagle am335x-bonegreen-eco"
> -CONFIG_ENV_OVERWRITE=y
> -CONFIG_ENV_RELOC_GD_ENV_ADDR=y
> -CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
> -CONFIG_VERSION_VARIABLE=y
> -CONFIG_NET_RETRY_COUNT=10
> -CONFIG_BOOTP_SEND_HOSTNAME=y
> -CONFIG_BOOTCOUNT_LIMIT=y
> -CONFIG_SYS_BOOTCOUNT_BE=y
> -CONFIG_CLK_CDCE9XX=y
> -CONFIG_DFU_MMC=y
> -CONFIG_DFU_NAND=y
> -CONFIG_DFU_RAM=y
> -CONFIG_USB_FUNCTION_FASTBOOT=y
> -CONFIG_DM_I2C=y
> -CONFIG_SYS_I2C_EEPROM_ADDR=0x50
> -# CONFIG_MMC_HW_PARTITIONING is not set
> -CONFIG_MMC_OMAP_HS=y
> -CONFIG_MTD=y
> -CONFIG_MTD_RAW_NAND=y
> -CONFIG_SYS_NAND_ONFI_DETECTION=y
> -CONFIG_SYS_NAND_PAGE_SIZE=0x800
> -CONFIG_SYS_NAND_OOBSIZE=0x40
> -CONFIG_SYS_NAND_U_BOOT_LOCATIONS=y
> -CONFIG_SYS_NAND_U_BOOT_OFFS=0xc0000
> -CONFIG_DM_SPI_FLASH=y
> -CONFIG_SPI_FLASH_WINBOND=y
> -CONFIG_PHY_ATHEROS=y
> -CONFIG_PHY_SMSC=y
> -CONFIG_MII=y
> -CONFIG_DRIVER_TI_CPSW=y
> -CONFIG_DM_PMIC=y
> -# CONFIG_SPL_DM_PMIC is not set
> -CONFIG_PMIC_TPS65217=y
> -CONFIG_SPL_POWER_TPS65910=y
> -CONFIG_SPI=y
> -CONFIG_DM_SPI=y
> -CONFIG_OMAP3_SPI=y
> -CONFIG_TIMER=y
> -CONFIG_OMAP_TIMER=y
> -CONFIG_USB=y
> -CONFIG_DM_USB_GADGET=y
> -CONFIG_SPL_DM_USB_GADGET=y
> -CONFIG_USB_MUSB_HOST=y
> -CONFIG_USB_MUSB_GADGET=y
> -CONFIG_USB_MUSB_TI=y
> -CONFIG_USB_GADGET=y
> -CONFIG_USB_GADGET_MANUFACTURER="Texas Instruments"
> -CONFIG_USB_GADGET_VENDOR_NUM=0x0451
> -CONFIG_USB_GADGET_PRODUCT_NUM=0xd022
> -CONFIG_USB_ETHER=y
> -CONFIG_WDT=y
> -# CONFIG_SPL_WDT is not set
> -CONFIG_DYNAMIC_CRC_TABLE=y
> -CONFIG_SPL_TINY_MEMSET=y
> -CONFIG_RSA=y
> -CONFIG_LZO=y
> 

