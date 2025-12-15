Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4B0FD41D74
	for <u-boot@archiver.kernel.org>; Mon, 15 Dec 2025 11:03:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7AC8482FC7;
	Mon, 15 Dec 2025 12:03:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="LCFG8enZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 73B9180050; Mon, 15 Dec 2025 12:03:07 +0100 (CET)
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazlp170120007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c101::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 759068334F
 for <u-boot@lists.denx.de>; Mon, 15 Dec 2025 12:03:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tanmay.kathpalia@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EhoeK+9b6kVHoFLWobSsBE2Tc9nzSXouwYLFp5z1PkrPWwQmOukBAhpj9B4UBWtzjiyqPcakeTFkVHj8UHa+BvtyGDCdCg/600NhlR1MU0F+F7dYcdtBTmQtQbnMtMJKtvpZ9LDyQ84ASU6IzZa2Nnq6gfAEac8R5K2JAAENa9AYNuur/nyUarZGzwajXuMRQXsJIFQMfUWEBj3nhlxnepmwVZrAuDdTIPtLrj6G3JyTAIPXHW+beoUQeNqmLNf/kIxwe+JX6kY6hsnG5htrlVfv6CnSXeKe84GxWov0hvG3gmzCN50l+NYRLgMjlWZekOFZjpAC6MaZ3LQzmU45WA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2yhiLEARS0rXW7yFkbINfbY0epzdF/l1BEakZf17Oto=;
 b=gwLa5DJS9qagU7tjDoAxVR4F3PMBzkKVPTdmZUabNfOaaIgZk4yGFp2UyJfTMLLbwc9WaXTXAjuBQ/6sKi68DMBOx/ExgC4xs4wma5jByc24YK+XRHGz42gTmJ7Vs0zi2GOpQMs2/XIsJ5QNO76FyWRqTNJsxqZ+3mjLQ58wAonl5nZ7NPx7909OPX/iRRfTKfw5fKUl54in/jHYC0BcECLF/YXQgE8PyOylq9LyjxDLm6yY/Y7dxE+0Ra+09gGMaw2rg8Zj5hpvP5iBjaqtMwx6FFDh3wkwjbvdsxInInkEolGGsXzCdBSCSFWwmCprf97FtLdohoMNCoVYXUEFvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2yhiLEARS0rXW7yFkbINfbY0epzdF/l1BEakZf17Oto=;
 b=LCFG8enZUyfuth0nrun+AFvXMf8Wo/3Y0AsxnuG0ohFaMNnQ+K+lA+Zh2zoxqx89WEG1OeetuMBXxBTyDGZ/oqQuE8qAm4vy7gkY0cxdRvf2KnHmHnlMlY+W4NJdH5cz4QQhVckvVN3iLADgGWHPC2tPkfoGXFUkhxCCeFwR4K1xjKEj6Ewd5rkwnb7hbwtYnFQvr+IrhDHywEShf57Fq0JvdwET3U2EkdlKwDHqueAmOfERk0TsqH6UWlx8eB/xU2agAgSHlMzF3jwatV4ucLmMFIMrPDGhDZ2w+Zf68UfPmfMuKoSElFqbj+XLTqAPpifLO+gN+DYJ+ArWD4np/Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from DM4PR03MB6208.namprd03.prod.outlook.com (2603:10b6:5:39c::19)
 by LV3PR03MB7658.namprd03.prod.outlook.com (2603:10b6:408:28d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.11; Mon, 15 Dec
 2025 11:03:03 +0000
Received: from DM4PR03MB6208.namprd03.prod.outlook.com
 ([fe80::6735:e440:e9a1:e844]) by DM4PR03MB6208.namprd03.prod.outlook.com
 ([fe80::6735:e440:e9a1:e844%3]) with mapi id 15.20.9412.011; Mon, 15 Dec 2025
 11:03:03 +0000
From: Tanmay Kathpalia <tanmay.kathpalia@altera.com>
To: u-boot@lists.denx.de
Cc: peng.fan@nxp.com, jh80.chung@samsung.com, trini@konsulko.com,
 marex@denx.de, tien.fong.chee@altera.com, tanmay.kathpalia@altera.com
Subject: [PATCH v1 3/4] configs: socfpga_agilex5: Enable MMC and Cadence SDHCI
 support
Date: Mon, 15 Dec 2025 03:01:16 -0800
Message-Id: <20251215110117.19371-4-tanmay.kathpalia@altera.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20251215110117.19371-1-tanmay.kathpalia@altera.com>
References: <20251215110117.19371-1-tanmay.kathpalia@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR11CA0059.namprd11.prod.outlook.com
 (2603:10b6:a03:80::36) To DM4PR03MB6208.namprd03.prod.outlook.com
 (2603:10b6:5:39c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR03MB6208:EE_|LV3PR03MB7658:EE_
X-MS-Office365-Filtering-Correlation-Id: 408e8eab-8ab7-4b26-bbab-08de3bc9840a
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?L3E6GTwrrKRbVnUbK/TIm7xRsGg78lkN1Wuxe5g9bImZSdc5ojvXBhIV4XAO?=
 =?us-ascii?Q?Nw0vSdOS2gKN6iSyXzweibSFD1iBxZoBviVo2mJm+oziCY1cuR4Xqnkt1WeW?=
 =?us-ascii?Q?GePBtQJXI+LgoOV4hi0LCUZD7E9HUwrQcBo59fNB+QEtxID9n46+H54k670D?=
 =?us-ascii?Q?DPrJnkzzqy9NQcwQhB5C8Dc6Zt5goPVEw+cmY3/RXtah5jDk8/5A6hqYQNzc?=
 =?us-ascii?Q?qgfgKHKLYHmRz/g4biyZpiUQxa8ktVnHPILZKRPr/s2NfjHyncmdbHTkQD8l?=
 =?us-ascii?Q?RFVfnVN+YOoHnQaerYf7h2dY+Z2IIPS8YS1YvchMxDJpI6yA3gpXRvXmVwsX?=
 =?us-ascii?Q?LGKccNgn27+wdZ+xbw7Odph9OcLzfV2cjcFB7iXPsvlK15Fk2EJFuog6Eukb?=
 =?us-ascii?Q?aXV6WNlqPu1SjfL1Stt57X0ejtoiQRoEO7tty6tor3Q+pOmsZDkIf22J9/+o?=
 =?us-ascii?Q?1QmnkYnyI6jghr8eOBGwbHYWF28rIQEE4PqAwiwSj6G4LDErzzSi/oC1pOPA?=
 =?us-ascii?Q?pefY9CI5oL86idekf5AlUdHw/tDu8yw6cOABxexlrTTGRRytcP4qtDtkwFuV?=
 =?us-ascii?Q?fUM9p/jCjavVGgd56rLgUr32dPNhOtNg8R0FEM5xuKA1VQ3ASwVuZFAh5h/f?=
 =?us-ascii?Q?G79VMRXX3W/WaWT0j/KpT0XDLVY9pb7LLzEM8WoSoHJzaLIMNR+scMwHy2+R?=
 =?us-ascii?Q?5RdPxKZndXP9cTRFr7ENpyyswYslPXS4ewVNiXdKMk4m/k+XAwJSJK6q89ja?=
 =?us-ascii?Q?2v7YR1o8RRGRChP91ZVxGgWBBiHW/PSCO1cDnawIbzgOIPIcrBHFwQJV9F+7?=
 =?us-ascii?Q?o1V+Y38hZnWtcfCHuDY7cl5hka813o0pUc9KFgDRZR7R3DrFmN0P4ieNOgZS?=
 =?us-ascii?Q?p/9uSe2wJAAUs+Avwh9ZJdBffiLYYFN2eP+SH3eck6CEuXPljNtqQ0bWLg/U?=
 =?us-ascii?Q?MD8XGfURG5UW0dYKsITPTq/e86o/ODeo109I83X57r3fh2ha8t7GVm9yCjFj?=
 =?us-ascii?Q?rNRk/49uph1NQvQBkXibwrzPHwfRLceVkL4U/WO9fB3vgM5jU95YQL23RH8f?=
 =?us-ascii?Q?x5AeiGFmmK0fMzJOwBKStkP817ztxHi6idrLvOo1kNpXYO5TUkQgfPrJmdSe?=
 =?us-ascii?Q?BhcGA6f+agDYXqxYueU4zWnMqjm9k9pea2+gsGnvHYurFUXSJ6QFLqZn97qD?=
 =?us-ascii?Q?lL8gS1e/4sB+ROQL9QXy36imFBVxuKp5XHqWRYWybccGFHFxqFPbH3MFmQHR?=
 =?us-ascii?Q?iURJKgW6yfx/ubISQSWWeXBDXiHZD8PstkxOOuTSd+iMA6DbbZ0zkcwBWjJd?=
 =?us-ascii?Q?K7a0kbmWloURhqIbFi7IkoINkxDEIOtO3Ywh3AtolaJQpXPQ9HsUu8fIFJOw?=
 =?us-ascii?Q?O07VGYfyTjT1tPtxJz5x1w/qktpmgBalxvHb9MMJnJihf0j6aZseh3vAxKIp?=
 =?us-ascii?Q?d2W2xoByNXupi7cr6TiYsp4QZT6zHltm?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR03MB6208.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/yypHLh4lgQzd4Q/fXU5BRr31xuklg2KmCJWmbpgW6l2xQLGO0pcCFRiBmlZ?=
 =?us-ascii?Q?o2RYRBoQ0fKWPxB0dEDPFxF5TphPLiJmVVAt6l6KuMh0PQKkmZdrhgZRgSXc?=
 =?us-ascii?Q?4YKaSoVoYdx7XLMJpCnru4hnZK6F32rK2tjFE5PIBCjO//+siBV3Qy29i5Zx?=
 =?us-ascii?Q?9hzZbvbutSwoCLBzQcOYVaD4oxKvojr4vQ7VwYABTGUgp0ayyhICLaYssw16?=
 =?us-ascii?Q?8sWMGIHjNF/+A5u7cKTaWw4S3rXH1VOrOLqIcvxdTioUh7ift36k7OOLyB+u?=
 =?us-ascii?Q?koZJqt/5BP+CWaBPMn48iegZm4BzlUQlKQEQYQX4bXAkLMmYXjUMGIZUU0p0?=
 =?us-ascii?Q?fykHP3C+hS9ffz2m11VPkFIuuD0RUYWXjG2cM0HfUfPIWdXBtWwag0hIfhjt?=
 =?us-ascii?Q?/Bb/ZHtK32PMTOncketxg9LQ6CfByJ5IVGSPtm+nX6JfstFCncj1M3uea1Nw?=
 =?us-ascii?Q?LZc19i4Jn7BdGVDuYspOzgM/qUY0rj+2ga8bXUGdbILCqHGOeFmFtuc2NfIH?=
 =?us-ascii?Q?c5a2nFru9VLiK697LFFgwfsjMXAUviDi/AsAdRGHwUw7ALKAKXbBPnWABM3v?=
 =?us-ascii?Q?g5PU/wnhKN0N00ObRi7Xlyhk+nv/CaRT4C23oDOJo6MZQ+UxLuRh+yi0SEBA?=
 =?us-ascii?Q?kGbX5CyVexORKt7ToEV/Hm7mufHcOOF2cQaQWk+jyQBgSiGDV3DwZ8tiLriP?=
 =?us-ascii?Q?Aji58vUWiwSV3EledRKXaTCyjW6KXIFa3XpnhFy5wMPjCxEBjY8UWPcZTBVF?=
 =?us-ascii?Q?8yPH7qQk5wHSRuwbgMK8iTvDFfES4rpG8Rz+bnrqSKXjTw88j+rg6INhQrOO?=
 =?us-ascii?Q?139D48jhKI58XUbMljCaZTQYRosrllFgkLJcLQBdIbwW3OEJIvDi4DxkPALk?=
 =?us-ascii?Q?B0ILupD/RO0uqOmFT6UTo8O45O/cc7c35XLullJQ7/OEQj+HH3Jp10vLs3ur?=
 =?us-ascii?Q?tPIAAzGBU6VKH/u0765mR622EueNWwhGZWiwHSx2qY7Kgv8dsXinnzPq75T6?=
 =?us-ascii?Q?4YgXTOBaJDQausdAP/pELkD63YSZcFJPKIMPeBB/zaeFDDdm5/cZ3TWcGoXI?=
 =?us-ascii?Q?6oD+Hzz9lLmCcaCHfY++zViOocpJEfAwEMYydMVcf+/AC8PNfGPxtz/moqyv?=
 =?us-ascii?Q?hjpZFW59BZ/ORqz+A6yBFhexmI8lEOtlBtIEfgoe57UsbcVegEzFuYdFnrau?=
 =?us-ascii?Q?LFANacoRrUcCip/j2m1wisKVDePCzKB1dv2weCLdwjcIxnSMfZlqSjnNpLvM?=
 =?us-ascii?Q?ap8fBDASHWpMt+9seAbii7797XxkHYpJe/0lY2duWhz7VFzzLpunulOxObna?=
 =?us-ascii?Q?ImUqA0fk0ZiQul/L6rwiZhcPJ0iVw9nXD9piLdcMPm6n/mnFFYk9NoRPOZ1f?=
 =?us-ascii?Q?vJ/St5bi4+impZoMSpcZqQym5UTWGnWbcJFgi8uLjrx6ydlP4zH/VW9rV1Hc?=
 =?us-ascii?Q?QyqGBIyA6YGayBE8xrVWvoI6yhxbTr/1GNY87ltYQWedMwdvM4XaaR4iDf3x?=
 =?us-ascii?Q?e9oOG0ksH2eyUbN6VAA+vTtfFcidxs7Nxp357eSIweoTGFQ2TE0huY237NBT?=
 =?us-ascii?Q?aS0HUZIHZrAR1Br9kDwURUDS21DCCkHrfZCiJ7lxYXrmWWEcujqVYfdHGtaQ?=
 =?us-ascii?Q?8g=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 408e8eab-8ab7-4b26-bbab-08de3bc9840a
X-MS-Exchange-CrossTenant-AuthSource: DM4PR03MB6208.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2025 11:03:03.2242 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1YPizBshNBuc8P7uadk27qwsjjfEZbS93yDFFFm1gp6N3cJIwsDxApO8WBIBfq1OmLIuR1ZIRgvlJn9LzAarbe9w62rr9j+EbaenRfIQ5tc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR03MB7658
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

Enable MMC support with Cadence SDHCI controller for both SPL and
U-Boot proper on Agilex5 platform to support SD card operations in
legacy and high speed timing modes.

MMC controller configuration:
- Enable MMC subsystem (CONFIG_MMC=y, CONFIG_DM_MMC=y)
- Add Cadence SDHCI controller support (CONFIG_MMC_SDHCI_CADENCE=y)
- Enable SDHCI with ADMA support for better performance
- Add MMC command support for user interaction

SPL configuration:
- Enable MMC support in SPL (CONFIG_SPL_DM_MMC=y)
- Add SDHCI ADMA support in SPL (CONFIG_SPL_MMC_SDHCI_ADMA=y)
- Enable GPIO support in SPL (CONFIG_SPL_DWAPB_GPIO=y)

Voltage regulator support:
- Add device model regulator framework (CONFIG_DM_REGULATOR=y)
- Enable fixed voltage regulator support for card power
- Add GPIO-controlled regulator for I/O voltage switching
- Include regulator support in SPL for early initialization

These changes enable SD card functionality with legacy and high speed
timing modes, providing proper voltage regulation and GPIO control
for the Agilex5 SoCDK platform.

Signed-off-by: Tanmay Kathpalia <tanmay.kathpalia@altera.com>
---
 configs/socfpga_agilex5_defconfig | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/configs/socfpga_agilex5_defconfig b/configs/socfpga_agilex5_defconfig
index 799ea910f03..3eabc372269 100644
--- a/configs/socfpga_agilex5_defconfig
+++ b/configs/socfpga_agilex5_defconfig
@@ -2,6 +2,7 @@ CONFIG_ARM=y
 CONFIG_SPL_SYS_DCACHE_OFF=y
 CONFIG_ARCH_SOCFPGA=y
 CONFIG_TEXT_BASE=0x80200000
+CONFIG_SPL_GPIO=y
 CONFIG_NR_DRAM_BANKS=3
 CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
 CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x80300000
@@ -66,6 +67,7 @@ CONFIG_CMD_WDT=y
 CONFIG_CMD_CACHE=y
 CONFIG_CMD_TIMER=y
 CONFIG_CMD_UBI=y
+CONFIG_CMD_MMC=y
 # CONFIG_ISO_PARTITION is not set
 # CONFIG_EFI_PARTITION is not set
 CONFIG_OF_LIST=""
@@ -106,5 +108,22 @@ CONFIG_USB_DWC3=y
 CONFIG_USB_HUB_DEBOUNCE_TIMEOUT=3000
 CONFIG_DESIGNWARE_WATCHDOG=y
 CONFIG_WDT=y
+CONFIG_DM_REGULATOR=y
+CONFIG_DM_REGULATOR_FIXED=y
+CONFIG_DM_REGULATOR_GPIO=y
+CONFIG_SPL_DWAPB_GPIO=y
+CONFIG_SPL_DM_REGULATOR=y
+CONFIG_SPL_DM_REGULATOR_FIXED=y
+CONFIG_SPL_DM_REGULATOR_GPIO=y
+CONFIG_SPL_MMC=y
+CONFIG_SPL_DM_MMC=y
+CONFIG_SPL_MMC_IO_VOLTAGE=y
+CONFIG_SPL_MMC_SDHCI_ADMA=y
+CONFIG_MMC=y
+CONFIG_MMC_SDHCI=y
+CONFIG_DM_MMC=y
+CONFIG_MMC_IO_VOLTAGE=y
+CONFIG_MMC_SDHCI_ADMA=y
+CONFIG_MMC_SDHCI_CADENCE=y
 # CONFIG_SPL_USE_TINY_PRINTF is not set
 CONFIG_PANIC_HANG=y
-- 
2.43.7

