Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFFACFF8867
	for <u-boot@archiver.kernel.org>; Tue, 28 Apr 2026 03:33:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0688284394;
	Tue, 28 Apr 2026 05:32:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="htJn5S7n";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 50FBA84355; Tue, 28 Apr 2026 05:32:45 +0200 (CEST)
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azlp170120002.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c007::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DEA5884383
 for <u-boot@lists.denx.de>; Tue, 28 Apr 2026 05:32:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alif.zakuan.yuslaimi@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WvySJuDECq533RC5cTjd/MkdzraVwE0+dagmkn3PbBcNFc8s4jWaA4o3Yva1/KPe4PJDkpleZ3cRay3xUdCtNVTOx8p/DsLm3z/vaD5DOFKlLvXepBJAg+freG4yEO0rcvoGiNRD43EYA9mTMz6R54emoVt8I6jLxmpIgg6+uDAjmrQN76Isu2wJxI59P2Atwn5S+RtNwnikR0fE20MJpIFLpf+ZOxbLznPns80Z0P8xOadg2jEKD4HErwT+Vt6g4VQNiWAGcaXfnufFURe2KdxtOXqDRYdJMTOmwYGqgDE2BrW85I7pD7KVycOjrsbaEWJCT7nW6YCUiPXNe5aFzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z1ZQFGzlDDqlTG4AnQ8uYpkAoDVyZ3IzTYd93LOWaFM=;
 b=gG6bYGFeu2ayVbRH92Qx6sJHBBtlVXUltj/qGhUrj04uUHJGZNNhWTUHwgrJDFo8w33ZaN979psZ/ogwoF0GFmxXy+znC8nVVI0UpHv4Cuyhzt6vaDr/sLMbWYpKYII+k6amB/vDsk3IvfadbXCY+MU/wmXnW/FAEVQ75RnEDc5GWd/Zq+O8cuebAzuyokWq+SW2aPkCF+xeZL3OCjRyarc/+jVOSetlizJVUMK8Qpe+UdfO0vH6jyf0/X+c/U+ZhlDKMw3NvhhfeFabHLbGfL/3AduGWvl9Rj542S+FT94Go2F5hPDP/oaFKRFL/xZo+ap3YuPMXdW5onMtN6MiyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z1ZQFGzlDDqlTG4AnQ8uYpkAoDVyZ3IzTYd93LOWaFM=;
 b=htJn5S7n5HKbg7itZ83jh/qsTaJ1y7eVd19Z+feP0iMhiH5JOBUbPgf0V6JaXSouEWKmwUq8MyIPQMHy836ZCkXDeBm3l+n0VtvGD1a37pRAQRJn1agBNKcHITSXDgrCW8TwVfgBG+hdUD6SylSTLNRr9WSAONwv8dWe/MyekaxpSqE4KX1JThfItvLsgtQAcGpmh4WhKVZXiKTdK3O+8X/bdVCFrcCz09qKiDqBn1MDfCi42LBXC7/9vzLaYSjmDEDk1N+rEJGbwbhaWzw+ZjA0MhChApp0rnRSykCno9ZOIsrh2+W5e2e7qLyglubnPsVSem9kFAg+P9Wh+JSmzg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from PH7PR03MB7063.namprd03.prod.outlook.com (2603:10b6:510:2a4::6)
 by BN9PR03MB5996.namprd03.prod.outlook.com (2603:10b6:408:135::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.36; Tue, 28 Apr
 2026 03:32:38 +0000
Received: from PH7PR03MB7063.namprd03.prod.outlook.com
 ([fe80::f6cf:4203:1cbc:cd21]) by PH7PR03MB7063.namprd03.prod.outlook.com
 ([fe80::f6cf:4203:1cbc:cd21%4]) with mapi id 15.20.9846.021; Tue, 28 Apr 2026
 03:32:38 +0000
From: alif.zakuan.yuslaimi@altera.com
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>, Tom Rini <trini@konsulko.com>,
 Brian Sune <briansune@gmail.com>, Yao Zi <me@ziyao.cc>,
 Patrice Chotard <patrice.chotard@foss.st.com>, Peng Fan <peng.fan@nxp.com>,
 Simon Glass <sjg@chromium.org>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
Subject: [PATCH v2 3/3] ddr: socfpga: Add ECC DRAM scrubbing support for
 Gen5/Arria10
Date: Mon, 27 Apr 2026 20:32:30 -0700
Message-ID: <20260428033230.7777-4-alif.zakuan.yuslaimi@altera.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260428033230.7777-1-alif.zakuan.yuslaimi@altera.com>
References: <20260428033230.7777-1-alif.zakuan.yuslaimi@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0039.namprd03.prod.outlook.com
 (2603:10b6:a03:33e::14) To PH7PR03MB7063.namprd03.prod.outlook.com
 (2603:10b6:510:2a4::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR03MB7063:EE_|BN9PR03MB5996:EE_
X-MS-Office365-Filtering-Correlation-Id: efd666dc-a647-4e67-91ba-08dea4d6cbc3
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|55112099003|13003099007|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: 7kCNpV8ygiLkQg/1sF9NRzL3UbJKSR0dgRyuGDWvHC6qtYA6/E31UVw2tLwZwdOVWl2Jz2WXWgoZ+dbO359rsHxpmDw3FuK7CjRD2xigyDgwSO80g+M9Gdh5BaNYYxfrDK6mglwl+xWTeF5Y7lfYZVNHy0Ur1tiKDa0HOGa4/TMFmhIanrrJoUenzQ6LxZg8yyIoMWIibnWtK8hiOicLB84HPPE2kb2f0OXuTLG/quAy1r+loDKQB55//yGV44E3lSq22gW7H22g1yXDKz8cH2CxGlZ1YFWibTOrgQh9yaVoT1yaNDL3gbIWjZAGDUy8adZ9w1lpQysRaVBPOlctFlYqZUiiwQ/Bry0t6e6i/JBp+acIezeyXccrq+gRdkJsU4gd43//VXg81FA3R9+3zTATdteGfQZ1NEIf9eF6h4rPZnl6+P9e8K0vQKdl+3VxOcXO9LfLHj4E53eGKtO4DQLZ6RIIyOzbRFflCUS4Ax/M9hnRbEuF6ExjlyeKjpQRJMP99hChKnclh/Jahw75Fm8sTvFbpx/dDihHa+5N5XLHRoAlXDp6glW8rmoJkfm3xavnP6+RFYKF9N2NLgUFtWJ+YhvozNzFqWgT48Q9zYQ/D55kzbC5ZlSoBMIODJsJhgibe1Ah52V4P7TyE4YUOgUZ4Tf8mjuFMh2OFF+Ea9yatAPuLqmaqyRrK6cw9A9M
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR03MB7063.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(55112099003)(13003099007)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?doaQmogo2bXQZ9pVSpAP3vtcKruhAJnbbqErOrsRwLfw1/XLKDWQO+gW+7xR?=
 =?us-ascii?Q?M6A1BqPWPC+5+VDSwTIbHP3ajzSavMYiWX+MPJDo6ION7VRXR4Eq/dTIJlCA?=
 =?us-ascii?Q?PO6XVgoBHHApsgdPat+EpU6RXkxq6DVFszfs6xcQqaCcxgXBH9LKapSE2eXg?=
 =?us-ascii?Q?onK9A9/JEg9Hyd+PV/W3l1oVvv+iEpYrt621Q8r+mrUGdxNWhzA33AyIPAiL?=
 =?us-ascii?Q?cPv24SLZ4Hv9vcbFwSvBAPooOH51Fy4I7ITiE/49UOPKD/mJ1bDmR95YoPHW?=
 =?us-ascii?Q?sHu81Yj24TnAIdQRwaCegeszVrlJYofmNhxaq7T+1Phw7cFar5HHoFki+ysG?=
 =?us-ascii?Q?FH5OwmJU5VIr5IK8DrMC5fheARixnzToF8oqkIHHMZMQEyJkG1yiazx/y+hd?=
 =?us-ascii?Q?OpbE+fIGimjRNus27g08N20nUgVR9yC3gIPdHymsUlK5UYzmscb7aXQDc6E1?=
 =?us-ascii?Q?AqOakraBS9POLV8K7UI7IdfNMkEahkq69i90iAglRIChSpnad9r/JDWbqqR8?=
 =?us-ascii?Q?5LP6bj6EpFS0Ederg2m5e/0MgORMiVz7hkfvW4sBETcb7zCddh+jOiS0DyPG?=
 =?us-ascii?Q?6OBoGSjZDJKGwV+moIjTtiY0YRhR1f/3ET59uTiA/pO/JbQtHnKzldK0MkM0?=
 =?us-ascii?Q?2XDDuPhwvWq1lTTkI+6YbTst5UhTimSxWTkYaNNJBDgi8eIz4ZstyEZ0SWZw?=
 =?us-ascii?Q?n0vEtPDuyRu1ZzstIoVhAQjIjHpiAXO4I9StS/lWGf0b3MRfF5tRMYDOc15u?=
 =?us-ascii?Q?z9nlZGZ2bSY207q1zYoxWMzI/KN7172HC5JPeMFVbl4jHSC+t2iNIrvQLdjC?=
 =?us-ascii?Q?9ydAzJxtQp/YPJU6nUDNqaM/+NuHSzqrz6NB5Lz4sasODpiZmNsLzo/KvfbN?=
 =?us-ascii?Q?X+wDMtZwWcydREmidLQ7GP3LiXjtJ7gGtMHgv9x8jSKE/j8ZoUiijkCpQZZg?=
 =?us-ascii?Q?ibKlZgOuBgF9o+qO8X3DQvuayyor00J/gpKzjSS8uYTvO4DS33uV7xRXSs3i?=
 =?us-ascii?Q?cZbOcL2dZXCVFLHyE97g2Ld7jCnGCj882qRxU6W/3P7NKlRgn7AqAN2iciUF?=
 =?us-ascii?Q?kQU3Yp+d1vjhqOzPXRGFW1HgQstZMWmrY29cXJLniZ6FL6OYwLTEC9m5UHZT?=
 =?us-ascii?Q?dPwL3O1oXNTtopYOypSPHJPQWVz1WzIoMm7FxCjjMWLq+ZPOPNkJg/TUmCso?=
 =?us-ascii?Q?Yoh/CJn/zi3Ug4CBMvH8vqD2J/Kt3RJ9XfIYIdkB7ziSmtCIY9+QduOQp4S4?=
 =?us-ascii?Q?0dfCEFrVjwj6FbXxWVTXrCbZtyHUFL9I+I4MLuloQhqf3RQyCJT+JCdSX7si?=
 =?us-ascii?Q?ruFi2EpSTVSdV2P92UAcvxY4R2YUae2ZFpawR0PXUzu0n0eZG4hWWlZnhDMB?=
 =?us-ascii?Q?uVERudaTOsP5Ixi1UsSNnrbndsHnXHnmBJefjol1hBt0qqfW94Wo3bLcYZ/a?=
 =?us-ascii?Q?ieMiQm1A8+slyqKRRYdo2nQhGv19GS/hW25rB4M+uem7PaxZ/CuEPFR2cj6s?=
 =?us-ascii?Q?HNCar+aGC+aHOrBYLC2VJI3ppT37trSClwqSiV65HgG2k+Mb6bFgPsOCQ0pC?=
 =?us-ascii?Q?ZyTZ/jdUPRuONclm7uEflSAZPs1iCLdJ6SROBT2sY9QSEVaJ5kZrKI+33KHI?=
 =?us-ascii?Q?W7yJiHpRu2le4iV9MsITQFA5fyoLYQisWCznltyAiHZpQAo+RG4Xy2Jb4lfB?=
 =?us-ascii?Q?9Sg5WG8lQDwyv/O1iKiPGQMYaMAsmIpM0BApFXqUILEw2KlCMiH2F4Aseg0I?=
 =?us-ascii?Q?ex+f72xIpzqEK/i6R8WS+rqSlYzjEq4=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: efd666dc-a647-4e67-91ba-08dea4d6cbc3
X-MS-Exchange-CrossTenant-AuthSource: PH7PR03MB7063.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2026 03:32:38.3744 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3ruDIrAAX5UR9DKppPdpNVjZT6IOxwBDPEPNbI02ZyWHzbx1GBTLSEujpeusufnER01IEn1VwRsm7e7RkLEgUBt5G3Coj9NmIi8IxPP1hj4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR03MB5996
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

From: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>

The SDRAM must first be rewritten by zeroes if ECC is used to initialize
the ECC metadata. Make the CPU overwrite the DRAM with zeroes in such a
case.

This implementation turns the caches on temporarily, then overwrites the
whole RAM with zeroes, flushes the caches and turns them off again.
This provides satisfactory performance.

Move common code sdram_init_ecc_bits() to new common file sdram_soc32.c.
Preparation for Gen5 uses the same memory initialization function as
Arria10.

New Kconfig is introduced to enable this implementation only on the default
Arria10 and CycloneV boards as this will increase the SPL size which
will exceed some Gen5 devices' SPL size limit.

Signed-off-by: Tien Fong Chee <tien.fong.chee@altera.com>
Signed-off-by: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
---
 arch/arm/mach-socfpga/Kconfig      | 13 ++++-
 arch/arm/mach-socfpga/spl_a10.c    |  4 ++
 arch/arm/mach-socfpga/spl_gen5.c   | 17 ++++++
 drivers/ddr/altera/Makefile        |  4 +-
 drivers/ddr/altera/sdram_arria10.c | 34 +++++-------
 drivers/ddr/altera/sdram_gen5.c    | 41 ++++++++++++--
 drivers/ddr/altera/sdram_soc32.c   | 85 ++++++++++++++++++++++++++++++
 drivers/ddr/altera/sdram_soc32.h   | 15 ++++++
 8 files changed, 187 insertions(+), 26 deletions(-)
 create mode 100644 drivers/ddr/altera/sdram_soc32.c
 create mode 100644 drivers/ddr/altera/sdram_soc32.h

diff --git a/arch/arm/mach-socfpga/Kconfig b/arch/arm/mach-socfpga/Kconfig
index 830585a72cc..dd71691b724 100644
--- a/arch/arm/mach-socfpga/Kconfig
+++ b/arch/arm/mach-socfpga/Kconfig
@@ -6,6 +6,13 @@ config ERR_PTR_OFFSET
 config NR_DRAM_BANKS
 	default 1
 
+config SOCFPGA_ECC_SUPPORT
+	bool "Enable ECC support for DRAM"
+	help
+	 Adds CPU-based ECC support for DRAM at boot. This will initialize
+	 all DRAM ECC metadata to zero, preventing false ECC errors and
+	 improving reliability.
+
 config SOCFPGA_DRAM_SIZE_CHECK
 	bool "Enable DRAM size checking for safety"
 	help
@@ -105,6 +112,7 @@ config ARCH_SOCFPGA_ARRIA10
 	select ETH_DESIGNWARE_SOCFPGA
 	imply FPGA_SOCFPGA
 	imply SPL_USE_TINY_PRINTF
+	select SOCFPGA_ECC_SUPPORT
 
 config SOCFPGA_ARRIA10_ALWAYS_REPROGRAM
 	bool "Always reprogram Arria 10 FPGA"
@@ -117,6 +125,9 @@ config SOCFPGA_ARRIA10_ALWAYS_REPROGRAM
 config ARCH_SOCFPGA_CYCLONE5
 	bool
 	select ARCH_SOCFPGA_GEN5
+	select SOCFPGA_ECC_SUPPORT if \
+	  !TARGET_SOCFPGA_TERASIC_SOCKIT && !TARGET_SOCFPGA_EBV_SOCRATES \
+	  && !TARGET_SOCFPGA_SOFTING_VINING_FPGA
 	select SOCFPGA_DRAM_SIZE_CHECK if !TARGET_SOCFPGA_TERASIC_SOCKIT \
 	  && !TARGET_SOCFPGA_EBV_SOCRATES && \
 	  !TARGET_SOCFPGA_SOFTING_VINING_FPGA
@@ -124,7 +135,7 @@ config ARCH_SOCFPGA_CYCLONE5
 config ARCH_SOCFPGA_GEN5
 	bool
 	select SPL_ALTERA_SDRAM
-	select SPL_CACHE if SPL
+	select SPL_CACHE if SPL && SOCFPGA_ECC_SUPPORT
 	imply FPGA_SOCFPGA
 	imply SPL_SIZE_LIMIT_SUBTRACT_GD
 	imply SPL_SIZE_LIMIT_SUBTRACT_MALLOC
diff --git a/arch/arm/mach-socfpga/spl_a10.c b/arch/arm/mach-socfpga/spl_a10.c
index c20376f7f8e..4d0696bbaf6 100644
--- a/arch/arm/mach-socfpga/spl_a10.c
+++ b/arch/arm/mach-socfpga/spl_a10.c
@@ -25,6 +25,7 @@
 #include <asm/sections.h>
 #include <fdtdec.h>
 #include <watchdog.h>
+#include <wdt.h>
 #include <asm/arch/pinmux.h>
 #include <asm/arch/fpga_manager.h>
 #include <mmc.h>
@@ -265,6 +266,9 @@ void board_init_f(ulong dummy)
 	/* Configure the clock based on handoff */
 	cm_basic_init(gd->fdt_blob);
 
+	if (CONFIG_IS_ENABLED(WDT))
+		initr_watchdog();
+
 #ifdef CONFIG_HW_WATCHDOG
 	/* release osc1 watchdog timer 0 from reset */
 	socfpga_reset_deassert_osc1wd0();
diff --git a/arch/arm/mach-socfpga/spl_gen5.c b/arch/arm/mach-socfpga/spl_gen5.c
index 08b756db2ca..530863b1564 100644
--- a/arch/arm/mach-socfpga/spl_gen5.c
+++ b/arch/arm/mach-socfpga/spl_gen5.c
@@ -6,6 +6,7 @@
 #include <hang.h>
 #include <init.h>
 #include <log.h>
+#include <asm/global_data.h>
 #include <asm/io.h>
 #include <asm/utils.h>
 #include <image.h>
@@ -21,9 +22,17 @@
 #include <debug_uart.h>
 #include <fdtdec.h>
 #include <watchdog.h>
+#include <wdt.h>
 #include <dm/uclass.h>
 #include <linux/bitops.h>
 
+DECLARE_GLOBAL_DATA_PTR;
+
+#if IS_ENABLED(CONFIG_SOCFPGA_ECC_SUPPORT) || \
+	IS_ENABLED(CONFIG_SOCFPGA_DRAM_SIZE_CHECK)
+static struct bd_info bdata __attribute__ ((section(".data")));
+#endif
+
 u32 spl_boot_device(void)
 {
 	const u32 bsel = readl(socfpga_get_sysmgr_addr() +
@@ -106,6 +115,9 @@ void board_init_f(ulong dummy)
 	if (cm_basic_init(cm_default_cfg))
 		hang();
 
+	if (CONFIG_IS_ENABLED(WDT))
+		initr_watchdog();
+
 	/* Enable bootrom to configure IOs. */
 	sysmgr_config_warmrstcfgio(1);
 
@@ -143,6 +155,11 @@ void board_init_f(ulong dummy)
 	/* enable console uart printing */
 	preloader_console_init();
 
+#if IS_ENABLED(CONFIG_SOCFPGA_ECC_SUPPORT) || \
+	IS_ENABLED(CONFIG_SOCFPGA_DRAM_SIZE_CHECK)
+	gd->bd = &bdata;
+#endif
+
 	ret = uclass_get_device(UCLASS_RAM, 0, &dev);
 	if (ret) {
 		debug("DRAM init failed: %d\n", ret);
diff --git a/drivers/ddr/altera/Makefile b/drivers/ddr/altera/Makefile
index 8259ab04a7e..ece6a131897 100644
--- a/drivers/ddr/altera/Makefile
+++ b/drivers/ddr/altera/Makefile
@@ -7,8 +7,8 @@
 # Copyright (C) 2014-2025 Altera Corporation <www.altera.com>
 
 ifdef CONFIG_$(PHASE_)ALTERA_SDRAM
-obj-$(CONFIG_ARCH_SOCFPGA_GEN5) += sdram_gen5.o sequencer.o
-obj-$(CONFIG_ARCH_SOCFPGA_ARRIA10) += sdram_arria10.o
+obj-$(CONFIG_ARCH_SOCFPGA_GEN5) += sdram_soc32.o sdram_gen5.o sequencer.o
+obj-$(CONFIG_ARCH_SOCFPGA_ARRIA10) += sdram_soc32.o sdram_arria10.o
 obj-$(CONFIG_ARCH_SOCFPGA_STRATIX10) += sdram_soc64.o sdram_s10.o
 obj-$(CONFIG_ARCH_SOCFPGA_AGILEX) += sdram_soc64.o sdram_agilex.o
 obj-$(CONFIG_ARCH_SOCFPGA_N5X) += sdram_soc64.o sdram_n5x.o
diff --git a/drivers/ddr/altera/sdram_arria10.c b/drivers/ddr/altera/sdram_arria10.c
index c281f711fdf..09d3526603e 100644
--- a/drivers/ddr/altera/sdram_arria10.c
+++ b/drivers/ddr/altera/sdram_arria10.c
@@ -22,9 +22,13 @@
 #include <linux/bitops.h>
 #include <linux/delay.h>
 #include <linux/kernel.h>
+#include <linux/sizes.h>
+#include "sdram_soc32.h"
 
 DECLARE_GLOBAL_DATA_PTR;
 
+#define PGTABLE_OFF	0x4000
+
 static void sdram_mmr_init(void);
 static u64 sdram_size_calc(void);
 
@@ -193,24 +197,6 @@ static int sdram_is_ecc_enabled(void)
 		  ALT_ECC_HMC_OCP_ECCCTL_ECC_EN_SET_MSK);
 }
 
-/* Initialize SDRAM ECC bits to avoid false DBE */
-static void sdram_init_ecc_bits(u32 size)
-{
-	icache_enable();
-
-	memset(0, 0, 0x8000);
-	gd->arch.tlb_addr = 0x4000;
-	gd->arch.tlb_size = PGTABLE_SIZE;
-
-	dcache_enable();
-
-	printf("DDRCAL: Scrubbing ECC RAM (%i MiB).\n", size >> 20);
-	memset((void *)0x8000, 0, size - 0x8000);
-	flush_dcache_all();
-	printf("DDRCAL: Scrubbing ECC RAM done.\n");
-	dcache_disable();
-}
-
 /* Function to startup the SDRAM*/
 static int sdram_startup(void)
 {
@@ -735,8 +721,16 @@ int ddr_calibration_sequence(void)
 	if (of_sdram_firewall_setup(gd->fdt_blob))
 		puts("FW: Error Configuring Firewall\n");
 
-	if (sdram_is_ecc_enabled())
-		sdram_init_ecc_bits(gd->ram_size);
+	if (sdram_is_ecc_enabled()) {
+#if IS_ENABLED(CONFIG_SOCFPGA_ECC_SUPPORT)
+		sdram_init_ecc_bits();
+	}
+#else
+		puts("DDR: Enable CONFIG_SOCFPGA_ECC_SUPPORT when SDRAM ");
+		puts("ECC is enabled.\n");
+		hang();
+	}
+#endif
 
 	sdram_size_check();
 
diff --git a/drivers/ddr/altera/sdram_gen5.c b/drivers/ddr/altera/sdram_gen5.c
index 1c3c70ea8ae..76effb264e2 100644
--- a/drivers/ddr/altera/sdram_gen5.c
+++ b/drivers/ddr/altera/sdram_gen5.c
@@ -2,6 +2,7 @@
 /*
  * Copyright Altera Corporation (C) 2014-2015
  */
+#include <cpu_func.h>
 #include <dm.h>
 #include <errno.h>
 #include <div64.h>
@@ -19,8 +20,11 @@
 #include <asm/global_data.h>
 #include <asm/io.h>
 #include <dm/device_compat.h>
-
+#include <linux/sizes.h>
 #include "sequencer.h"
+#include "sdram_soc32.h"
+
+#define PGTABLE_OFF	0x4000
 
 #ifdef CONFIG_XPL_BUILD
 
@@ -566,6 +570,19 @@ static unsigned long sdram_calculate_size(struct socfpga_sdr_ctrl *sdr_ctrl)
 	return temp;
 }
 
+#if IS_ENABLED(CONFIG_SOCFPGA_ECC_SUPPORT)
+static int sdram_is_ecc_enabled(struct socfpga_sdr_ctrl *sdr_ctrl)
+{
+	return !!(readl(&sdr_ctrl->ctrl_cfg) &
+		  SDR_CTRLGRP_CTRLCFG_ECCEN_MASK);
+}
+#else
+static int sdram_is_ecc_enabled(struct socfpga_sdr_ctrl *sdr_ctrl)
+{
+    return 0;
+}
+#endif
+
 static int altera_gen5_sdram_of_to_plat(struct udevice *dev)
 {
 	struct altera_gen5_sdram_plat *plat = dev_get_plat(dev);
@@ -608,10 +625,13 @@ static int altera_gen5_sdram_probe(struct udevice *dev)
 	sdram_size = sdram_calculate_size(sdr_ctrl);
 	debug("SDRAM: %ld MiB\n", sdram_size >> 20);
 
-#if IS_ENABLED(CONFIG_SOCFPGA_DRAM_SIZE_CHECK)
+#if IS_ENABLED(CONFIG_SOCFPGA_DRAM_SIZE_CHECK) || \
+    IS_ENABLED(CONFIG_SOCFPGA_ECC_SUPPORT)
 	/* setup the dram info within bd */
 	dram_init_banksize();
+#endif
 
+#if IS_ENABLED(CONFIG_SOCFPGA_DRAM_SIZE_CHECK)
 	if (sdram_size != gd->bd->bi_dram[0].size) {
 		printf("DDR: Warning: DRAM size from device tree (%lu MiB)\n",
 		       (ulong)(gd->bd->bi_dram[0].size >> 20));
@@ -626,8 +646,23 @@ static int altera_gen5_sdram_probe(struct udevice *dev)
 	}
 #endif
 
+	if (sdram_is_ecc_enabled(sdr_ctrl)) {
+#if IS_ENABLED(CONFIG_SOCFPGA_ECC_SUPPORT)
+		/* Must set USEECCASDATA to 0 if ECC is enabled */
+		clrbits_le32(&sdr_ctrl->static_cfg,
+			     SDR_CTRLGRP_STATICCFG_USEECCASDATA_MASK);
+		sdram_init_ecc_bits();
+#else
+		puts("DDR: Enable CONFIG_SOCFPGA_ECC_SUPPORT when SDRAM ");
+		puts("ECC is enabled.\n");
+		puts("DDR: Without scrub, false ECC errors may occur.\n");
+		hang();
+#endif
+}
+
 	/* Sanity check ensure correct SDRAM size specified */
-#if IS_ENABLED(CONFIG_SOCFPGA_DRAM_SIZE_CHECK)
+#if IS_ENABLED(CONFIG_SOCFPGA_DRAM_SIZE_CHECK) || \
+    IS_ENABLED(CONFIG_SOCFPGA_ECC_SUPPORT)
 	if (get_ram_size(0, gd->bd->bi_dram[0].size) !=
 	    gd->bd->bi_dram[0].size) {
 #else
diff --git a/drivers/ddr/altera/sdram_soc32.c b/drivers/ddr/altera/sdram_soc32.c
new file mode 100644
index 00000000000..7556d4933f4
--- /dev/null
+++ b/drivers/ddr/altera/sdram_soc32.c
@@ -0,0 +1,85 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2026 Altera Corporation <www.altera.com>
+ */
+
+#include "sdram_soc32.h"
+#include <string.h>
+#include <hang.h>
+#include <linux/sizes.h>
+#include <cpu_func.h>
+#include <watchdog.h>
+#include <wait_bit.h>
+#include <asm/global_data.h>
+#include <asm/system.h>
+#if !defined(CONFIG_HW_WATCHDOG)
+#include <asm/arch/reset_manager.h>
+#endif
+
+DECLARE_GLOBAL_DATA_PTR;
+
+#define PGTABLE_OFF	0x4000
+#define PGTABLE_RESERVE (PGTABLE_OFF + PGTABLE_SIZE)
+
+#if IS_ENABLED(CONFIG_SOCFPGA_ECC_SUPPORT)
+static void socfpga_prepare_watchdog_for_long_op(void)
+{
+#if !IS_ENABLED(CONFIG_WATCHDOG)
+	/*
+	 * No DM watchdog support enabled. Previous boot stage may have left
+	 * L4WD0 running, so stop it once before long DDR scrub operation.
+	 */
+	socfpga_per_reset(SOCFPGA_RESET(L4WD0), 1);
+	socfpga_per_reset(SOCFPGA_RESET(L4WD0), 0);
+#endif
+}
+
+/* Initialize SDRAM ECC bits to avoid false DBE */
+void sdram_init_ecc_bits(void)
+{
+	u32 start;
+	phys_addr_t start_addr;
+	phys_size_t size, size_init;
+
+	start = get_timer(0);
+
+	start_addr = gd->bd->bi_dram[0].start;
+	size = gd->bd->bi_dram[0].size;
+
+	printf("DDRCAL: Scrubbing ECC RAM (%lu MiB).\n",
+	       (ulong)(size >> 20));
+
+	if (size <= PGTABLE_RESERVE) {
+		printf("DDRCAL: Error: DRAM size %#llx smaller than scrub reserve %#x\n",
+		       (unsigned long long)size, PGTABLE_RESERVE);
+		hang();
+	}
+
+	memset((void *)start_addr, 0, PGTABLE_RESERVE);
+	gd->arch.tlb_addr = start_addr + PGTABLE_OFF;
+	gd->arch.tlb_size = PGTABLE_SIZE;
+	start_addr += PGTABLE_RESERVE;
+	size -= PGTABLE_RESERVE;
+
+	dcache_enable();
+
+	socfpga_prepare_watchdog_for_long_op();
+
+	while (size > 0) {
+		size_init = min_t(phys_size_t, (phys_size_t)SZ_1G, size);
+		memset((void *)start_addr, 0, size_init);
+		size -= size_init;
+		start_addr += size_init;
+
+#if IS_ENABLED(CONFIG_WATCHDOG)
+		/* Service DM watchdog cyclic callbacks */
+		schedule();
+#endif
+	}
+
+	dcache_disable();
+
+	printf("DDRCAL: SDRAM-ECC initialized success with %u ms\n",
+	       (u32)get_timer(start));
+}
+#endif
diff --git a/drivers/ddr/altera/sdram_soc32.h b/drivers/ddr/altera/sdram_soc32.h
new file mode 100644
index 00000000000..2cfc583b5f5
--- /dev/null
+++ b/drivers/ddr/altera/sdram_soc32.h
@@ -0,0 +1,15 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2026 Altera Corporation <www.altera.com>
+ */
+
+#ifndef	_SDRAM_SOC32_H_
+#define	_SDRAM_SOC32_H_
+
+#if IS_ENABLED(CONFIG_SOCFPGA_ECC_SUPPORT)
+void sdram_init_ecc_bits(void);
+#else
+static inline void sdram_init_ecc_bits(void) { }
+#endif
+
+#endif /* _SDRAM_SOC32_H_ */
-- 
2.43.7

