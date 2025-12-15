Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20A9DD41D74
	for <u-boot@archiver.kernel.org>; Mon, 15 Dec 2025 11:02:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8B9CC800D0;
	Mon, 15 Dec 2025 12:02:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="NjvShU3o";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1022B8042F; Mon, 15 Dec 2025 12:02:45 +0100 (CET)
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012069.outbound.protection.outlook.com [52.101.53.69])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 835F780050
 for <u-boot@lists.denx.de>; Mon, 15 Dec 2025 12:02:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tanmay.kathpalia@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BDdTO6EHZ6UaOqL48xFoCu+mr1nW7LUdjJYUncVoyyx9Dn2laNCbCoPJ8VNN0jR0NIBYqyLpW9y3SGf0dV9AKsspTJbudJTlN9qyU3WfYgLi69INFvbEPCvnJMDD+9BeKYjoLYFlW3NFpCXrao55UlNxwho5SL5YTb2drrZAVaLqZjWV6O7YuUbCe9+gSV61SuBwCgT+vQ9dDeauF6aK0cSf41ub4AY5kaH7DrtFEPMYK1hUYKNNt55Mv/1TaDQMphnNo/nMEwQQ25xZOdIp55AjzTnW2ap4L5UbJic/p2Orqnyu8Tzr7Kbsx3ZUBNoGBSb04MlF1BHqzFGCrxvdVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wpMN23jzDyNGb1z8v27y+t8ejP3w6qngiAJUXukXYks=;
 b=NGeYlBghzVX+rO2lV7qs34xkujc1GOLK0tAemNNf/wWJJ02/HXIsM+oNr1Gikl2W9R9Z8ta97RXxYmJSvyUWJ4w2lkQHUXIPhODi/F7NxzI4Upwlos900srcVAYSFMpru4kYe3pbpQCyIQ+f+shyCflf20kaohvd+eSIr+hkvEjNqEpL2KeH1A9qgfR4eMj/JC6Rcf42ZZ1ffyHvw1r5+HsPH9Wd0pmWYUxY4lPZgMq9I8RyTiV+ql6GQxUsp85JwhT4gmwy4YgX/QDk7smighN8Gv48MOG9ake7XKp538SyWCNWtgbxQdMYMXGIyApOOovEsUNuu/UGhT63m8zdhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wpMN23jzDyNGb1z8v27y+t8ejP3w6qngiAJUXukXYks=;
 b=NjvShU3ozEqNK6vHroJCiTH8PKC13i6bjw88UEbOZHbUY1ZBdn6BSm9KN/d6UyHqiUWcT2P8pGgIm4MBoh6PpB5IQYWpkdLIdJtGd1UJth1zKh1F8om/1+iyu6sW2M4g9dhqhnKTzHcO2p/nXA6vS2pVvdwAKmaPvQqJM6HlGYj1cLzSltmYS5YGkLOJhAa19BC4QPnDwhgrPnu1ikwu/9m4coCSyos1sMZv2VK0oXqA3wfnw2pKdJJL61dxuJPUXeVTtYr2kKwEaj25odV7JQxSJjWZFGX6rMC2MbI/b/4D5EhS+fElBp3/5ySWwICggSjiXGGgAHsFAlh+Yg+WzQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from DM4PR03MB6208.namprd03.prod.outlook.com (2603:10b6:5:39c::19)
 by LV3PR03MB7658.namprd03.prod.outlook.com (2603:10b6:408:28d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.11; Mon, 15 Dec
 2025 11:02:27 +0000
Received: from DM4PR03MB6208.namprd03.prod.outlook.com
 ([fe80::6735:e440:e9a1:e844]) by DM4PR03MB6208.namprd03.prod.outlook.com
 ([fe80::6735:e440:e9a1:e844%3]) with mapi id 15.20.9412.011; Mon, 15 Dec 2025
 11:02:26 +0000
From: Tanmay Kathpalia <tanmay.kathpalia@altera.com>
To: u-boot@lists.denx.de
Cc: peng.fan@nxp.com, jh80.chung@samsung.com, trini@konsulko.com,
 marex@denx.de, tien.fong.chee@altera.com, tanmay.kathpalia@altera.com
Subject: [PATCH v1 0/4] socfpga: agilex5: SDHCI controller correction and
 feature enablement
Date: Mon, 15 Dec 2025 03:01:13 -0800
Message-Id: <20251215110117.19371-1-tanmay.kathpalia@altera.com>
X-Mailer: git-send-email 2.19.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR11CA0059.namprd11.prod.outlook.com
 (2603:10b6:a03:80::36) To DM4PR03MB6208.namprd03.prod.outlook.com
 (2603:10b6:5:39c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR03MB6208:EE_|LV3PR03MB7658:EE_
X-MS-Office365-Filtering-Correlation-Id: 054530a0-1a94-4236-ef7a-08de3bc96ec9
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?xfTBrcvKx4BIbfj6J4OKcsjLF9YO3s+Zq6SKjyhgmkGqQMgzDKqCbUP/Vqso?=
 =?us-ascii?Q?oRx5q/pFDisOT99fCTCkMqLOv9KJTlOOaJka9fv6XicAJYVJ2JpDNyqBSbIF?=
 =?us-ascii?Q?Uel/GybBmsN+GCp/RjT4sluPYOJhsuqt5gG9khtWNsFIgioyFk25gTk53+yp?=
 =?us-ascii?Q?NK3tsW8nH/LlOAzD1TUaIiVqjr/Oki1OPDBaXfZNbF/X7WzmXxTRU0a7KTvu?=
 =?us-ascii?Q?ptJmh7OqDBCuHujZUbACJOc+W4kkw23YbD8NSbfhXQUkQVLr6iwOsziP6Ako?=
 =?us-ascii?Q?d4pU0wxSqAS1lAXe8nE0Fj5gxWuMMZr8tBpXW8WBrfh/Xvjp9MFZerObBh3c?=
 =?us-ascii?Q?xgnOifUGtOiUyAMe4HreQcdviVDjRZxn1bMdteM3jFH4PBJD8OVhwSwejSE2?=
 =?us-ascii?Q?ce5Z8Couud9t1EG0kwm0cO44/DsROmVIn8BEd3awq8FAshgsUpNnbmDncFX2?=
 =?us-ascii?Q?21Bvj2jG25w7Zhv1pt9L7N1/izHrIhf8dhQannrP8IBi0aOqiNFmp2n5QEOA?=
 =?us-ascii?Q?/A83OvqDE4pdNTaV/LrhUqev6EVHHle7o1Ug1DuDIdtcqd9DfZzIGFJkFsVW?=
 =?us-ascii?Q?eKeL+wOov0/UIRyqxhlNQfkbsegoFuBx9AuF5yEIBlDg97/cpsTq1QoLLJAa?=
 =?us-ascii?Q?CQcK16Xoi+pWcjRh/4mT5aNQSdnHk1w9+xZ3k7wIgiDg0b2NSHa8S7QAOqoJ?=
 =?us-ascii?Q?Nzrl+VeCM8nZLJZqLNWCgJgDmr1aE5yXyt6I2Vi7Iw6noBkJRz1CaBpEya2F?=
 =?us-ascii?Q?YL+w+oKsJgnIf7YCZ0JaSn4Y+LOEtssKmCvUzsKS1+Ty7PABIqyhHDdMKagl?=
 =?us-ascii?Q?8C7CW/P1VjwYHk6Tm+dKFBVjfSR6xROgVXL070mT7CrtyA+SXsXB0pRvLFS8?=
 =?us-ascii?Q?Ek40fEZelqoz3uiCjtsH2mJ21s5lUL8ZVOz+i7FjhTLi1ZE6EE7wFqAfpPlA?=
 =?us-ascii?Q?6Th2B4odUNjVqT1Mt5cjCEjRZfdjUHGL1Na80Ku14rPAhFdCLpO7wbGg798H?=
 =?us-ascii?Q?CqwgRJ7IlqAZFjZcIQ1b+JTFfr10yGR/NC6A0mrNGPbCXPZB+46spsQhrKKW?=
 =?us-ascii?Q?8aYA0hM5yPjiee/k7FG5NxbsVMlVanoEpd87yBvVy/y+QvTBr1fFfbrWCqoD?=
 =?us-ascii?Q?AbiXNgC4edPbAMPU3tghCzoZsxRXtXYV7eBBMFelzIMiHyrPz6c2gKH9eTLy?=
 =?us-ascii?Q?xxlUMAq2Pt7L/bCu+ImtYJrq+Lv44eVw7gS+i6R631/BlFzRpZhJX58e6m/n?=
 =?us-ascii?Q?kxIOZVAItZVcPEgS16vkdNxIzp5lCk9QSFMqfjCsUd3hakcd/4SquzK69I/+?=
 =?us-ascii?Q?/jpxOhxdc3I4ObmRyxUWpn/eUs2TTPewlf+ib/bWw+8FIJOBa4DyqMsiLvQS?=
 =?us-ascii?Q?gZTPMFqAUMgaWPVn6WJbfFU2FqxtOT8fNkh17MjMWlK3705lK0FBgewVQqBL?=
 =?us-ascii?Q?sPkYtg5LnYwuEP9ytaOV+21CoxyrLQGD?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR03MB6208.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ezo59curzzdrTsr50J24vmpRL27U3SPVCa0zu2+Ro0m+pFAFUf/CE+DVo5zg?=
 =?us-ascii?Q?wHwpdsPsqishB8CcVcyoVOA3R75vzCMaCBDAOB7FIChVrfTCQpMgSD350niL?=
 =?us-ascii?Q?WyV1Gb5r17hWJdsW7nJ8aILLR5b9dkhkXPIABCVne+AnTGRqxl5jx/9spocd?=
 =?us-ascii?Q?dIyhPxrUyWHTJll/r649N8n+cc0/ZvqKifIz5x0VKuAZ5ikO061bvNe7WUYj?=
 =?us-ascii?Q?oWNemB0SpYmH3DYgAKjZ9LmSBPJU3V19xMVAAnphXNGJZwpqARPCMH4sS8Tt?=
 =?us-ascii?Q?vfQxhyD6U1QWosaZADkOB6RhMByc6hRiV1t968+932CESMpRC5YOrGa6UmKo?=
 =?us-ascii?Q?WTChY4CQtFaoOkzV1DyPOJgCEFmvCfLZ8NKPTSshujLem7Mve9ECf9uVIz3F?=
 =?us-ascii?Q?THVlHTiRmz7N4Wf9MFOF3Y/1471wTd5P2jURtlYbhJ7fPVkAbZC6+HCc5Kgs?=
 =?us-ascii?Q?kff+xyKH7tVKNolodHfRnZ6mGxu4tLn7+qjfKVxXpegP6GkOTUnCtOhTpqU+?=
 =?us-ascii?Q?u2NY6vFSS/RRc1QBxwJElotT6ftx4Dg5GU3KZa+oLWyDc0XVlAe7c/A2U6rT?=
 =?us-ascii?Q?mhkaCDhvfWhEYQ+8mZY+EFi7w8uOH0IgFWR3Rtf0InYjyP6b1/FJmt9EqsK0?=
 =?us-ascii?Q?Uo6J/SW9geNuJ2RdKfee/isk9OInZOUYJwWcxmMxcv6jM+ufFIZ9kpQ+M9g4?=
 =?us-ascii?Q?YTHFY1S/hXnX27OPdOSkUELgMGFYshNYjo/M8YRi2VnIhJ+O15GhSoGiXh6K?=
 =?us-ascii?Q?FVZTMrmwFjNV/pekZM+qswKANP5mbawXwCRMkGRRk1lqFBerGnlyW3Jg/oE3?=
 =?us-ascii?Q?x+0LGot6y4qmYxyfFDXebZC96Ed4xo81a/vIvAfntrXyM19t+y3Ok/G4owEw?=
 =?us-ascii?Q?W3K7ps99qecmhmiVZOu4wDgE72y7WEb8gAhce+XpgWq0Su/vPHWAV4S90XIM?=
 =?us-ascii?Q?zRg+U5uqzR9Ug25n+MXZ0l+DjK9XRevmlAJVk8/ATovvQdhBABHWm9n300Ao?=
 =?us-ascii?Q?54+xvgm5nHv8FUtRdXagTcxfw68RTmPtMDmkHalglg/bKd4O21laQtPnc9RV?=
 =?us-ascii?Q?BDOOTD+rKCO8ttYaiu4hTgq0Vwhlpgq265aASzHACUfGokAZ3LA9PE/uHgI0?=
 =?us-ascii?Q?vT35gOc2YMVEKcpoJI9SIIKYe4hzZy0zOOW4ZwdiBUUqTgr/ZFB7sICPLyjJ?=
 =?us-ascii?Q?IXAX60qqDBa6G2iwwgQ1nwIVj/RJYJTAjt/6luVQLSut+JFtzrX5hWQtvaeZ?=
 =?us-ascii?Q?wduKILNaMw4YAQ+akc+BeRO4zZXlNV6GCVYyuRyiWZeSmfRgqNZEc00zTZhx?=
 =?us-ascii?Q?MaVnZvcs7IwhgANA1NKnc5pRLGnASjMqVhm/KoX6BoQFU5BTj5Dy2nn+cnSd?=
 =?us-ascii?Q?k+L6/uU8EA+bFaOla8II2pE31E3r1H3cFob5SEC3HD58sXiO4KNdyZxZG+fJ?=
 =?us-ascii?Q?oqFiLvvgRTkZh9RD2wLTadr/6AoLwhS0tvtwvnAK0DboyvOV9BsLrpir1BMS?=
 =?us-ascii?Q?jYAcNEw8wz7vaqGV4nlSZDizmVKyZ0J1HzjCzw0BJAjpv+15DwVmUIjbKoAD?=
 =?us-ascii?Q?anAeUdyLRP+fSn0FrfiuFOOe6RFXxNmPdRByolu7eqEzfImRLmcOUfmk5l9J?=
 =?us-ascii?Q?JA=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 054530a0-1a94-4236-ef7a-08de3bc96ec9
X-MS-Exchange-CrossTenant-AuthSource: DM4PR03MB6208.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2025 11:02:26.7975 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WXRMxeCXAOJ3oWVpa9VnQzo2UTK+ObZpykioW/9lgWfzIG3zhftJFUcHVQpehl537xvpB28njDHOIKRkYhUHwKVkS3CrH+ewtdzhNfIrRu0=
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

This patch series addresses configuration corrections and enables
required features for SD/eMMC support on the SoCFPGA Agilex5 platform.

Summary of changes:

1. Remove SDIO_SEL GPIO hog configuration
   The SDIO_SEL GPIO hog setup is removed as voltage switching is now
   managed by the regulator framework, allowing proper UHS-I voltage
   control through the MMC subsystem.

2. Correct SDHCI controller node from SD4HC to SD6HC
   Updates the device tree to use the Cadence SD6HC controller
   (replacing SD4HC), adds appropriate compatible strings, and
   configures voltage regulators and GPIOs for SD card I/O switching.

3. Enable MMC and Cadence SDHCI support in defconfig
   Enables the MMC subsystem and Cadence SDHCI driver in both SPL and
   U-Boot proper, including ADMA and regulator support, to provide SD
   card functionality and voltage regulation.

4. Add dedicated eMMC device tree and defconfig
   Adds device tree and configuration for eMMC operation on Agilex5,
   including fixed I/O voltage regulator and timing parameters for
   supported modes.

These changes are specific to the SoCFPGA Agilex5 platform and ensure
correct SD/eMMC controller configuration and feature enablement.

Please review and provide feedback.

Regards,
Tanmay Kathpalia
tanmay.kathpalia@altera.com

Tanmay Kathpalia (4):
  Revert "arch: arm: dts: agilex5: Set SDIO_SEL GPIO pin as output"
  arm: dts: socfpga: agilex5: Upgrade SDHCI controller from SD4HC to
    SD6HC
  configs: socfpga_agilex5: Enable MMC and Cadence SDHCI support
  arm: dts: socfpga: agilex5: Add dedicated eMMC device tree support

 arch/arm/dts/Makefile                         |   1 +
 arch/arm/dts/socfpga_agilex5-u-boot.dtsi      |  14 +-
 arch/arm/dts/socfpga_agilex5.dtsi             |  29 +--
 .../arm/dts/socfpga_agilex5_socdk-u-boot.dtsi |  77 ++++----
 .../socfpga_agilex5_socdk_emmc-u-boot.dtsi    | 178 ++++++++++++++++++
 arch/arm/dts/socfpga_agilex5_socdk_emmc.dts   |  49 +++++
 configs/socfpga_agilex5_defconfig             |  20 +-
 configs/socfpga_agilex5_emmc_defconfig        |   6 +
 drivers/mmc/sdhci-cadence.c                   |   1 +
 9 files changed, 306 insertions(+), 69 deletions(-)
 create mode 100644 arch/arm/dts/socfpga_agilex5_socdk_emmc-u-boot.dtsi
 create mode 100644 arch/arm/dts/socfpga_agilex5_socdk_emmc.dts
 create mode 100644 configs/socfpga_agilex5_emmc_defconfig

-- 
2.43.7

