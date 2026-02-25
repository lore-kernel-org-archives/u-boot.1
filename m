Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0330FD3769
	for <u-boot@archiver.kernel.org>; Wed, 25 Feb 2026 15:51:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 114EB83F7D;
	Wed, 25 Feb 2026 16:49:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="Z/YJfB4O";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CB50384064; Wed, 25 Feb 2026 16:49:42 +0100 (CET)
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazlp170130006.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 536DD83642
 for <u-boot@lists.denx.de>; Wed, 25 Feb 2026 16:46:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=tempfail smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VujVnaeJ822yZcnzWD/w0SMFi+5zF45upYVT0NHu5Ml1mp77eudw1SfmGrvUCZfIUZUvUuJnsLuolI+2pa+siOeRhKhepkiR6tcWCnKj7rSUGPUVlgT2cDAomlu8yTMFPU0/5E+zvvbQ1Jt45ZVu7XOpdnOvlQaLxzeCs3rRT7RtwSfoI7ZB8VZ0X4gVzVO7m2cgQVK8zyZtXlhYlJ0/eyTmu2uLbqQr5L4FeNg1tf61xhG3EEXE+bodFSyKrTmyY4Q8qeiOA0WMLN2OFg07J5gUNdLW7NY6PuXA+zJL08jM3Io+WG7IEsxkZ6tWVG4unB0CIoqC6M96+RjnTI/H/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pHDtWeib26AZOncNcqwd1ziS8lmgoD6kdP5teEE6ZYw=;
 b=N7olbu4V/Ax/cDjMxfX/jegtDqlMRMXL49S5QyVR7aJaqf/FNzgO1/SK/f8uqF1QbZjt0k42aE+fdiJCmnYZaMkVGqfVIyhGnwg4bklCfT+vEEYRpofqoMOsj9WS4y3WhoG8eejYrv50I7QQoxjuGwEhijqbZkdfa4bPf43k5gn5UHmYl0ffGdSuS/XwT0vbPtWY0Au286scxqoHj3/QDaPYFeuEV40M7tP5Td7QhG/qSWp51wBy4jVMa9KqzH/I0szUJPlLB2Q/Mokb37ZhIDWHf/2ZMGbNK2S/btOnxIMVZorE9dbgKbJf945yT6hAAV3MXDg6zJR3Zr2S2MKhUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pHDtWeib26AZOncNcqwd1ziS8lmgoD6kdP5teEE6ZYw=;
 b=Z/YJfB4OLdYDmxv9J2GPGG+eySb8bFSIhuyTy0hu5HS7Hn+R0dDruwUi0idDKUeojHyS9HH7D9u3XPKZSQspUItTC5Mabqi3fXtdYXyPhkxo7nBW+ZCMSb2fi3T+Ss+xFAdTpvGwQ3/YZBC2nI/ZRtrbulAlo0FleBjOYu5D/LI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com (2603:10a6:150:2be::5)
 by AS8PR04MB7575.eurprd04.prod.outlook.com (2603:10a6:20b:29c::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.23; Wed, 25 Feb
 2026 15:46:27 +0000
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::6c04:8947:f2f0:5e78]) by GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::6c04:8947:f2f0:5e78%6]) with mapi id 15.20.9632.017; Wed, 25 Feb 2026
 15:46:27 +0000
Message-ID: <61d889e2-2d21-4c30-b5f7-de1c41737d16@cherry.de>
Date: Wed, 25 Feb 2026 16:46:21 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] spl: Add generic SPL MTD loader support
To: Fabio Estevam <festevam@gmail.com>, michael@amarulasolutions.com
Cc: u-boot@lists.denx.de, trini@konsulko.com, seanga2@gmail.com,
 dinesh.maniyam@altera.com, a-dutta@ti.com, a-nandan@ti.com, jonas@kwiboo.se,
 Fabio Estevam <festevam@nabladev.com>
References: <20260220031232.1254728-1-festevam@gmail.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20260220031232.1254728-1-festevam@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR06CA0211.eurprd06.prod.outlook.com
 (2603:10a6:802:2c::32) To GVXPR04MB12038.eurprd04.prod.outlook.com
 (2603:10a6:150:2be::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GVXPR04MB12038:EE_|AS8PR04MB7575:EE_
X-MS-Office365-Filtering-Correlation-Id: 131a210e-4d73-4f61-ed9e-08de7485095e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info: Ir8dWH9Hxs77I70x351VSK5iDMA80tU+uWNAvU0LAa+M4bujDVeRpZmA7RoN5Uod12lFnQExxOlwKsrnTm9BV7SLBBRVSwTghc82LbJKY4JA1xviUkGr1WEKvpFWL5w3fiCn5qLDJc3zOJOM6/QbPgO8uFa6bQ1XNzHBlFIUc54OmP0QDhkSoa4aKaMy/zMk1pXGAg/1ZFaEI8QiZy2lvpDpArTrwVYCmCrx/+k3h34ZU4k+r7CzE51ZdOMxke4f2b7YFVE7liW3GeeuKKEUJlgNRc91croXlq2t7k6l+Oj9X8Du4kkMF3A4Bi3HHy9c/7Z0aUGWhS6Z/LsgEHeDhL0EhVJknkwvTqftdXd15DHpjIHGYOlFiau9OmaazthulpOP7lv0U3njGCZO9C4HiIUyBfs6I7Sn0BFuwMWRTHG5/IG7SJAAW0M/PdDbOGB1KRcg4MAK8YwYTg0kdorpmsbWpHGcu4e59ak4GovG2Gi4vNxCJhzlb52dfpoTlfeY+3zkZ58poSYkk6KQDrhSp5SVAXKBPpJ1jtLhXL8x1YoMeEkjRUE3mNeiCObHhNlebX7JEjhIpCt6LgcTH2nE6x6Eun+bCbO1mBitimy9neZKaT/4T9JB1aGzrIUc7ztEdu7vgqTWgFsq7VUvdPYPPNrhDezxjhi6m19oZbwZjfEiIn8rVLjpqC9irk1JzpZDgSGNPD02MDlUlLKIvEtDoCCHnNum74fHSpHC+jYdet0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GVXPR04MB12038.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M3BlYVl0ajgyMUxiRUppQm96WWdTUzVJdXZ0eGtheG9tTmUzNjZMTjIvYTk5?=
 =?utf-8?B?U2NacEptaFErRkRsLzBCTFNtbWh3aDkwTEpIR3FoRE1xQ3BmUmw2UzFLMEFl?=
 =?utf-8?B?VGFRQk9YYVkvekpDbUJibEhzdWhwbVpDVUNaWVRhejc2MTVGVmNnbTdEQkgy?=
 =?utf-8?B?Vlk5SzFKOTdtME94Z0FaWmpvNi93TG5mRS9HWEFTNG04eEtPK1phbnBrUG1q?=
 =?utf-8?B?NGtBZFh6SDBXOW13bkx3YjBwdklBSzhMTE1ka0tFbzFkYkVHUW10a1FXTkE1?=
 =?utf-8?B?Rkh0WmNEQUVWczErdGloejgya0FUbjRmSHlVUy9EV0tCWnljaFRscEJMV2hD?=
 =?utf-8?B?d3pJaEorZnNqWlY1akRaMTdJZU96ajJ4RTRIeXBFc0gwems3QmFkVEFzMzZ2?=
 =?utf-8?B?QTVodG9oTUFkbUhOYytRWnVIYnllMmNNRTUweFlScTNpK2RqRG1ZQnh6NDVE?=
 =?utf-8?B?elY0UEdpOWZRbmpKVG4vdGxvMS9oU3g3azFBclNTMDBPbDZ5YzlOb3dIOVZx?=
 =?utf-8?B?cTlERXZoVnNTUVJUUFUwSTVob3U3OWxrZlZOZFRQSlhxRHcvdnlPNG82aDk0?=
 =?utf-8?B?RjY4eFYrL1o2VXVzRVNLNHdMekdOMGhMUVNWOXAvbVFVUXQwQmovZ3NoUE4v?=
 =?utf-8?B?MkFZNjc4Tk04ajVXaDV5M1ZqcTNGRFhOdFZlcndpTS9DQjMyZDhNYzlOWVU5?=
 =?utf-8?B?MHU2U0Y3UUxnRTcvRWNDTVh1NEw1V1FMcHkxRzVEUWJGU1E0VitZWkluRU9U?=
 =?utf-8?B?c0xtb3NjQ2d1Y29YNEdLd1VMMjFPZEl2UkJ1QkJrWmRsZGprLzVBcFllaSs5?=
 =?utf-8?B?N0MzOGVrb0hPUlhpWS9jQlBuM3d0R0xKaHJONEY0N210VGhCWGh2TkVwMGh0?=
 =?utf-8?B?RVVIRExxRG94NURTeFIvRzZxWG5mSmlkQkZqUHNCM2RibFBuajVQVUlQdFhJ?=
 =?utf-8?B?SHJ5SXg3aTBJNTV5anhxSDNWSzBrSE0yMU55UEVLQ0hZRjR6NHNnN0I1bVVh?=
 =?utf-8?B?enR0cFhqODUvK1g1c3RsS3dEWVpvSVM4SmVtWmw4Q2ZqdCtTS2tQVU9CRGN4?=
 =?utf-8?B?K2pqS0dZRG15ZWdibzBpZjJnRCs2S0xkdVAwTW9RdDAwRmlSNWRRM0lnQ09G?=
 =?utf-8?B?REVtZW9hN1JBeTJyUmwwRmcrTGpCa3QwL2lNUzlwSGFQMVo2di9xK2sraXdP?=
 =?utf-8?B?dk9pUkVnSjUvSXVDYW5yakpkak1MNFNLUCtZYjdhNFFOSlFMZy84T3BaNkFi?=
 =?utf-8?B?RDlUcEtVZnlCZXVGRTgrckMyYUdFeDQ1NE1seFVPZnJGUzZsZ0FKVEdOTit2?=
 =?utf-8?B?MTl6WlJWNVdvOEhWcU5LVWozUWs4S0M5ZDJ1K1JHaVdoZ3FtZlMvVmJmZWdR?=
 =?utf-8?B?bTRCclhFZ0Q5TnBDa0E0OUVoL2RuQ3E0WUtLczJJdWd6NVRwMU85M0x3b1Fl?=
 =?utf-8?B?VGp0R3YrVkVPU2NaYVR1YjZZelpSRG1HdTlpTVlNeFlDeDBZRkdISy9RMmYx?=
 =?utf-8?B?YkFRcXRlQUZ4UEY0SW1yNStyY3dCTVFQTmU3SnY3OFV5ay9taVcrSkN6cnl1?=
 =?utf-8?B?eXpUd2lLS0lEWEt5elNwdWE4aWFGNXhHUURGSWhzcWVvRXluaVZ5R1ZteU9o?=
 =?utf-8?B?N09yQ1Rac3NJYmNhTUorTHJ6c0FmbHdTakRLZjF2cVlrdVNWSGp6TERtcldY?=
 =?utf-8?B?SC9NeHg4cGc5RS81K0tpYVRhVnFlWVB1Z3p0a0hRaGQwdVc2QUF0RjN0cCtj?=
 =?utf-8?B?SHF5UUlyY1V5MUpRWW01cnV1Kyt0Unlzem1GK0dveC90Y0R5RmJoVUVzTkgr?=
 =?utf-8?B?QmwyY0liS3lsS3ZJQy9UdjlZQTlyVVhnNDd1emdWUGY2R2s5Q0dNZFBOdURu?=
 =?utf-8?B?UkJjbGtKRTNMVDlaaWhUVGpBMVhMdFM4Mi8wYjR5eEd2cnQ3RzU2TWwyVUpt?=
 =?utf-8?B?VkVpRzdoVEFiNUlxQ0plRnJsdXV3VUEvSTl0VUtrT3Ryb3diR2lJYi8vaEZq?=
 =?utf-8?B?ODJXWjdoMEkrYkNoRHlkU3psbkd4MVZBSjF1MTQ4RFFjNURzeDIrWVZPZTdh?=
 =?utf-8?B?b2V1VkZ4Vkh5Q1Z5US9BV0hycVRQZTNiMjZKS2kxalJKWDBCcWxNTjdsRVlX?=
 =?utf-8?B?ZVd0aFV4K0JZU2cyVmoxYlR4YlArd2N4Mm1yODlTUW9oN0t3aTV5MEgrYlhK?=
 =?utf-8?B?RU5UOWtTdWlYdENQUUlKanM5Y21saEEwTTY4QW1pd0p3MWJCSVIwbTVFMndE?=
 =?utf-8?B?Z09CcXN6Ti9KY1k2SXF5N0k3cTdnL2Q0UzVHTEw5RGhNNGI2SkY4Wit0Zjd5?=
 =?utf-8?B?K1dIRGlWK0NjeVNKV0gyRXJiVGxkSEwyRHArUDJKanltcGZQQUhxUT09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 131a210e-4d73-4f61-ed9e-08de7485095e
X-MS-Exchange-CrossTenant-AuthSource: GVXPR04MB12038.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2026 15:46:27.1172 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Re96gR7z/FBzvjs6K6nUat/G2rM15EWlKvC3pQYZ0OaRZEB4M6CytSK843BdL+Zam6VVH0nu3L9gdBpZHQjCxmoFBfuGB+DPp6wzW3dI0TQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7575
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

Hi Fabio,

On 2/20/26 4:12 AM, Fabio Estevam wrote:
> From: Fabio Estevam <festevam@nabladev.com>
> 
> Add support for loading the next stage from an MTD device in SPL.
> 
> Introduce CONFIG_SPL_MTD_LOAD and a generic SPL MTD loader
> implementation that uses the MTD subsystem to read the U-Boot payload.
> 
> The loader works with any MTD-backed storage, including raw NAND and
> SPI NAND, without being tied to a specific NAND type.
> 
> The payload offset defaults to CONFIG_SYS_MTD_U_BOOT_OFFS and can be
> overridden via the device tree property:
> 
>      u-boot,spl-payload-offset
> 

Missing update to docs (at the very least in 
doc/device-tree-bindings/config.txt). I'm also not entirely sure we 
should have two loaders use the same property for different media.

What happens if you have a system with SPI NOR and MTD support but the 
payload is at a different offset? Some Rockchip platforms have support 
for SPI flashes and NANDs, e.g. RK3568 to only name one. It seems it's 
possible to have both a SPI flash and NAND flash according to the 
datasheet and VCCIO2 IO block in Radxa Rock 3A schematics (the PX30 
datasheet mentions support for both as well but I only saw the same pins 
for both controllers).

> To support both raw NAND and SPI NAND boot flows, the loader is
> registered for BOOT_DEVICE_NAND and BOOT_DEVICE_SPI. This allows it
> to operate correctly on platforms where the ROM reports either NAND
> or SPI as the boot source while using the same MTD-based loading
> infrastructure.
> 
> The required NAND core and SPI NAND drivers are built for SPL when
> CONFIG_SPL_MTD_LOAD is enabled.
> 
> This provides reusable infrastructure for boards that boot from MTD
> devices without relying on SPI-specific or NAND-specific SPL loaders.
> 
> Signed-off-by: Fabio Estevam <festevam@nabladev.com>
> ---
> Changes since v1:
> - Use uclass_get_device_by_seq().
> - Use puts() instead of debug() for error.
> - Include the new loader to include/spl_load.h.
> - Introduce SPL_MTD_SPI_NAND.
> 
>   common/spl/Kconfig        | 30 ++++++++++++++
>   common/spl/Makefile       |  1 +
>   common/spl/spl_mtd.c      | 83 +++++++++++++++++++++++++++++++++++++++
>   drivers/mtd/Makefile      |  1 +
>   drivers/mtd/nand/Makefile |  4 +-
>   include/spl_load.h        |  1 +
>   6 files changed, 119 insertions(+), 1 deletion(-)
>   create mode 100644 common/spl/spl_mtd.c
> 
> diff --git a/common/spl/Kconfig b/common/spl/Kconfig
> index 2998b7acb75f..16dbc5b54324 100644
> --- a/common/spl/Kconfig
> +++ b/common/spl/Kconfig
> @@ -933,6 +933,12 @@ config SYS_MMCSD_FS_BOOT_PARTITION
>   	  used in fs mode.
>   	  Use -1 as a special value to use the first bootable partition.
>   
> +config SYS_SPL_MTD_SEQ
> +	int "MTD device number for the SPL load"
> +	default 0
> +	help
> +	  MTD device number used for the SPL load.
> +
>   config SPL_MMC_TINY
>   	bool "Tiny MMC framework in SPL"
>   	depends on SPL_MMC
> @@ -1578,6 +1584,30 @@ config SPL_SPI_LOAD
>   
>   endif # SPL_SPI_FLASH_SUPPORT
>   
> +config SPL_MTD_LOAD
> +	bool "Support loading from a generic MTD device"
> +	depends on SPL
> +	depends on MTD && DM_MTD
> +	help
> +	  Enable support for loading the next stage from an MTD device
> +	  using the MTD subsystem in SPL.
> +
> +	  This supports raw NAND and SPI NAND devices.
> +
> +config SPL_MTD_SPI_NAND
> +	bool "Enable SPI NAND support in SPL"
> +	depends on SPL_MTD_LOAD
> +	select MTD_SPI_NAND
> +	help
> +	 Build SPI NAND support for SPL.
> +
> +config SYS_MTD_U_BOOT_OFFS
> +	hex "address of U-boot payload in the MTD device"
> +	default 0x0
> +	help
> +	 Address within the MTD device where the U-boot payload is fetched
> +	 from.
> +

Specify this can be overridden in DT with the DT property you read in 
the driver.

Cheers,
Quentin
