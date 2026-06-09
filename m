Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71BB7CD8C9D
	for <u-boot@archiver.kernel.org>; Tue,  9 Jun 2026 02:04:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E6CF3839D9;
	Tue,  9 Jun 2026 04:04:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="ZHvwlPz6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DBF3B839D9; Tue,  9 Jun 2026 04:04:19 +0200 (CEST)
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azlp170120001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c107::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 597B9839A8
 for <u-boot@lists.denx.de>; Tue,  9 Jun 2026 04:04:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alif.zakuan.yuslaimi@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZJmehHHf/i1Pps2xJ2lKmAMwpJOyrrnnl3BsrSAkPJU54eGfbIYgsgmIIWXh6j4Vw+KlrmJcMwzE+fC3ypozzb2A2M2TTlQ28u4zWeq3xy/9NJBYM6ya5e6qpuu0NjAybNUh1eaUzVkR7pE9WseWhHCzGhds/Q7BlpBjPC++zP0x1R14/zfMwfvu9rwJYS2tQuy+5ypcIVPB8LuNXnuxJDmg2pehykNcc/B3yOas7xbk6mL+c7JgXPOJKg6p06qZcC4fwFlxahW09tGL6lHxrgniTjrGliNDjp/HhxnO7niZ8Iv6J5FglFqwkQmpQlGcXlEIdg3CvRU3FJvSOOC+Mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Yw5A+VtKn2SOx5BWvhkCLe1xF7kBvFSMHb/ptAFTiY8=;
 b=H1DntUMox8V5AXU0x5LmoCW1FwOm67CT4e+9lY9+04eAL9EZ3UzVtPueNGn1a1XGPyij1Gmr7AkFKsjDEZZMPlU4JCKN73Vm0KWsSJv2qsCMwL2ayeDjxvsmAm9VFctM2XCSyWqChmTU16LyHobIKzqRnwwlSEmHUkRGLAYVaaqeyfFQh15I2Vyx8B5lTu8IaRtqwGM5qj2to7fE8qLC/PU9E94d2UuKcTZ8ec8/yifmOuDk2EcFCT1CyQovAphLjPiREIqQe+LlZjuR4WW9slLpN6h5wwxmDsjwJr0fhGVwvF9MQWCdt8ke5PJWerIilmU771TLWI25LhcAhwIH6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yw5A+VtKn2SOx5BWvhkCLe1xF7kBvFSMHb/ptAFTiY8=;
 b=ZHvwlPz6wbB//Sz7EUnxEdlhqVSV/P3/503qfAiknJbCmB5F/VUobfsT1RPemTt084JSG+EGi7UKSx3/W72Mqj/CUvwftyZximOwHavcAM+/qTTaRcYQa6yQVGXE3APgeQnNNx3liAoDY9nejN1JS30ZvOFuZhMK5bdaa6bIOZsDQW7prk9Cb65mkItDLCvSCxUlB9oy37mHtYRwS0eMJVDI7+PATgb6PzH9P33v1VoSpkE2MeNIednHurhwxLZ7KHfOmjqbMpnDGDW6ej0HkyMCXLMOym4BrAt4LHaInATEpPccOhFXMIcUWieJMdnpZtDsCW+m9GSTQriVmEUCNA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from PH7PR03MB7063.namprd03.prod.outlook.com (2603:10b6:510:2a4::6)
 by MWHPR03MB989484.namprd03.prod.outlook.com (2603:10b6:303:2a8::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.13; Tue, 9 Jun 2026
 02:04:14 +0000
Received: from PH7PR03MB7063.namprd03.prod.outlook.com
 ([fe80::f6cf:4203:1cbc:cd21]) by PH7PR03MB7063.namprd03.prod.outlook.com
 ([fe80::f6cf:4203:1cbc:cd21%4]) with mapi id 15.21.0092.007; Tue, 9 Jun 2026
 02:04:14 +0000
From: alif.zakuan.yuslaimi@altera.com
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>, Tom Rini <trini@konsulko.com>,
 Brian Sune <briansune@gmail.com>, patrice.chotard@foss.st.com,
 Peng Fan <peng.fan@nxp.com>, Yao Zi <me@ziyao.cc>,
 Simon Glass <sjg@chromium.org>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
Subject: [PATCH v4 2/3] ddr: altera: gen5: Add DRAM size checking
Date: Tue,  9 Jun 2026 10:03:57 +0800
Message-ID: <20260609020358.25985-3-alif.zakuan.yuslaimi@altera.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260609020358.25985-1-alif.zakuan.yuslaimi@altera.com>
References: <20260609020358.25985-1-alif.zakuan.yuslaimi@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY3PR10CA0013.namprd10.prod.outlook.com
 (2603:10b6:a03:255::18) To PH7PR03MB7063.namprd03.prod.outlook.com
 (2603:10b6:510:2a4::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR03MB7063:EE_|MWHPR03MB989484:EE_
X-MS-Office365-Filtering-Correlation-Id: afa7ac6f-df8c-4d85-4003-08dec5cb67e0
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|55112099003|11063799006|56012099006|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: lOBTyFlvXGwBwjNdD1x3ZCy6kAGZXZuEmPKKCZiWMUnVsQL830TDBLgs43IDCfFp2gvHa6GOBDndoe3+ryb7dKgOIkIO6+YjHDF7IVXsYUuCD6T+AaG6aDz/npP3BXc+YEhGXb9tqylVFs0eTKHYagYclbWn8NQb8VTmCYotrpHDQ6tkTuCpjBJks1+UU8smHrELFbU1wqaGSx2A8cNZ/RCRs8/vj0J0Bo509moqPDVf8taIbbMhNTVTb/xuWRMldilUJJmEy4hzHZearo09svfg5aOy7YuyCO4Xg500hhoQ2sHcxMgMvLEJ/Lgrhl756b8osuRvDIQPr7DUt45oQHzBejbICOMAoL0VTPkOKDeXgglbb83blEsQRModJ70iZIUhyDcso8R6HHU/0IO/sWn+2jQRmb7HuhsWdDf4g10uQz1EXe445QM8cM15+ofBOa+J48Wrlgh2wOgOoRB6TVPatWca+Nzplg4o/HkGUjFA6APBKpbbwak5KuE6tIjq06IH9FeUhsHe+4C49bGAs3IoIwrjMlmxdGXAjuJGT5BHtIcDdXsmFEGjJIJGmc0r5zSQ2vD6Zv+7jd8wiYW2vpbGhtqmFtmZ+3Q9onUF6gnSyCMVRw3ayUHN3tn0PK3Kai56K9XcrdsLsZKDUTrdVHilJVgYIW5flAjqSMCVs8AGMRO1+RXBBtOyzXsQ/zt1
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR03MB7063.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(55112099003)(11063799006)(56012099006)(6133799003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?gJxl7B9Z1tZfHXSbWA+Yl4Tt3Nxp0WRXMekKD1zyot/Pf0G1IeLAY/gKLide?=
 =?us-ascii?Q?29bkQmsvsQEiH49IwfqpJZWcgBw73qDaSkaFbEhkpGFt4/8TyvGz/43Vyebr?=
 =?us-ascii?Q?Fd+3gevAuMkp/zGJiX2G6QxEeGivc+P5YRwBkSq8vBovCom2XiYdfCP/ivyD?=
 =?us-ascii?Q?q+iIz/UzkEbUfHpn9g0JOFv+sVy/yvR1hi5aaRPL8Nna0TMB5JgIvkdZOCto?=
 =?us-ascii?Q?bQeyJyPM8gxundg10dmGniLNhK+roFBuM+jwxhUVNe6Kh9r/l6dmhPjAz2Cz?=
 =?us-ascii?Q?dDCoURlco+pHtx430N5CaUD/dfetRwzIzsFd2wDAbVZBOg1LnfoHlk21Ymnl?=
 =?us-ascii?Q?DFZEefDkaAUM1H8JKNJlrcyFoNMvT5s7oNr913jPX9v3z4V4I0yFm2ZJVMrt?=
 =?us-ascii?Q?xkmz9eUk5XCwSULJFTxYfy5zzhTwDNynPpL4Yd4IBJ+hvQ69GtBKPKeZmd4h?=
 =?us-ascii?Q?sQKGMou087Gc8QCLiULz7n0leErv7BFBgTWP62O0qlI9NMVzQgvN2s0z8No8?=
 =?us-ascii?Q?oZK2Yxbr9qwUgU+zmIpF+t2X77FO6dr78Y65r31lTegsF5GHAAnJ4i/anHYh?=
 =?us-ascii?Q?S4Ty7au9n3/3dxxfV0CGTUT5a6ponZCCnNUINRMl7AQ8iB64WAzQnsd+emYP?=
 =?us-ascii?Q?KGDPoo8Ic086SljLvmXrC7nsQQRGNNzgg1xN5gmyp5QaW0V/KNvNKg3H0F3v?=
 =?us-ascii?Q?gcBJelbVdl2DCZdj38NFkaBT7QRlHyxmfQq/EMHZBFNLsqR+1pxQ0pEPUmr2?=
 =?us-ascii?Q?qYvMpZtuAa07QXNgm6T2EuDODrDA2hxRlCh6gM0mua1CbFy7DaVe5G77fVSg?=
 =?us-ascii?Q?4sTccfijfxutn4Z6Rj77YFFgkJuid4SON6AF2zj0KBPjGiK1JJthVOxKSsIp?=
 =?us-ascii?Q?4EyN+2EgOFwn10tkiH2xLSQjmL5JR+0YQpqhJ2rQyDJOBrPIlP3G53qeOyna?=
 =?us-ascii?Q?tfvixryQVK3+0vYLHXdeDTiYvaMBzGS2M1jO30VeITVZuk8PG20zKJ2fzmgA?=
 =?us-ascii?Q?1eDuVEkYQHvENh2m2VfT0f4GAXxYN0kszmF/hPRqCFjdAI9Xd0hSqTA4MMTi?=
 =?us-ascii?Q?1T/nc0ol6u9dzoLXzCosDJoJQAaN5SBQ8+FnN2ap2QLkOIaWKpNughAo16fZ?=
 =?us-ascii?Q?uqYwq3qUMneuNt4Fk1attqIzoLIPlomElcbJB7ewu3w9ipT8PQRR/6Rngmog?=
 =?us-ascii?Q?91tTv/Z/XBrkE+w1tv3lj3CEK83jegaSz6WyW1LaLOUDSM0IthsOCzTGODTh?=
 =?us-ascii?Q?QaALtPvCKuWzDFLac4m4b4EhhcZqi6gHzobhCoAjaigdJ8jt6Qp0avSzfO7J?=
 =?us-ascii?Q?k6k19U9VgepdlJqLmkUiLhkZ/IfJDw90k7uKVSw3YGiyOr6Ln1EiknTSXYq+?=
 =?us-ascii?Q?eOIyYijXfmdcoxwlA0B/NVHuFNwOCGA71p7V960j4ie7PQGkT/Z8edYydWSZ?=
 =?us-ascii?Q?uY2KYGDb2CWzlNDiSovba/90d+GWftj/1F6smvhqBsw8uSa4PAS4kkplj3CK?=
 =?us-ascii?Q?AEHT6uY1msiWNuFuLhtwOuAyCUhUlS6coUAGBCApCxPQy8512b+udUFHvJ9v?=
 =?us-ascii?Q?xG5TeFMvMvZ6HvFLvbrA6z+w9yAFa2dnfi0fh6xQjyFOqcVfcrdRLTd6Elci?=
 =?us-ascii?Q?5OQz0IsIc0XOHYeRjOKazdSn77EyapPI+dU6ZvAgd++s0w35tpSOeG16kz8Y?=
 =?us-ascii?Q?b4q0avEM8DstbSQ1cFW8LTbC8hV6YNSdrMIusPFBqrssjhBYmQiJZ3cU7GEQ?=
 =?us-ascii?Q?wRaFajDzh+rS95SLXDLK4z141qitviE=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: afa7ac6f-df8c-4d85-4003-08dec5cb67e0
X-MS-Exchange-CrossTenant-AuthSource: PH7PR03MB7063.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2026 02:04:14.7704 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BugHQAwDmJL3q4zHtrPQ0wGr4l2NPGxKIkscpn+G9B82+Yszwa5uEwsMLP+KcGzuXTysvURk5Qzycyc+88YvDo0E3+EYP7ixG15gdRIYofE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR03MB989484
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

Add DRAM size checking compare between size from device tree and actual
hardware.

Trigger hang if DRAM size from device tree is greater than actual hardware.
Display warning message if DRAM size mismatch between device tree and
actual hardware.

get_ram_size() uses size from device tree. So, it has consistency with
other device families.

New Kconfig is introduced to enable this implementation only on the default
CycloneV board as this will increase the SPL size which will exceed some
Gen5 devices' SPL size limit.

Signed-off-by: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
---

(no changes since v3)

Changes in v3:
- Move the bdata declaration and gd->bd = &bdata assignment from spl_gen5.c
  in patch 3 into this patch, making this patch self-contained

Changes in v2:
- DRAM size checking is set as optional via Kconfig and defaulted on only
  for the reference Arria10/CycloneV boards to avoid SPL overflows on
  size-limited Gen5 defconfigs.

 arch/arm/mach-socfpga/Kconfig    |  9 +++++++++
 arch/arm/mach-socfpga/spl_gen5.c | 11 +++++++++++
 drivers/ddr/altera/sdram_gen5.c  | 27 +++++++++++++++++++++++++++
 3 files changed, 47 insertions(+)

diff --git a/arch/arm/mach-socfpga/Kconfig b/arch/arm/mach-socfpga/Kconfig
index fb98b647442..b814e034ecd 100644
--- a/arch/arm/mach-socfpga/Kconfig
+++ b/arch/arm/mach-socfpga/Kconfig
@@ -6,6 +6,12 @@ config ERR_PTR_OFFSET
 config NR_DRAM_BANKS
 	default 1
 
+config SOCFPGA_DRAM_SIZE_CHECK
+	bool "Enable DRAM size checking for safety"
+	help
+	 Compares device tree DRAM size with actual hardware. Hangs on
+	 oversized claim.
+
 config SOCFPGA_SECURE_VAB_AUTH
 	bool "Enable boot image authentication with Secure Device Manager"
 	depends on ARCH_SOCFPGA_AGILEX || ARCH_SOCFPGA_N5X || \
@@ -111,6 +117,9 @@ config SOCFPGA_ARRIA10_ALWAYS_REPROGRAM
 config ARCH_SOCFPGA_CYCLONE5
 	bool
 	select ARCH_SOCFPGA_GEN5
+	select SOCFPGA_DRAM_SIZE_CHECK if !TARGET_SOCFPGA_TERASIC_SOCKIT \
+	  && !TARGET_SOCFPGA_EBV_SOCRATES && \
+	  !TARGET_SOCFPGA_SOFTING_VINING_FPGA
 
 config ARCH_SOCFPGA_GEN5
 	bool
diff --git a/arch/arm/mach-socfpga/spl_gen5.c b/arch/arm/mach-socfpga/spl_gen5.c
index 08b756db2ca..a9825173189 100644
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
@@ -24,6 +25,12 @@
 #include <dm/uclass.h>
 #include <linux/bitops.h>
 
+DECLARE_GLOBAL_DATA_PTR;
+
+#if IS_ENABLED(CONFIG_SOCFPGA_DRAM_SIZE_CHECK)
+static struct bd_info bdata __attribute__ ((section(".data")));
+#endif
+
 u32 spl_boot_device(void)
 {
 	const u32 bsel = readl(socfpga_get_sysmgr_addr() +
@@ -143,6 +150,10 @@ void board_init_f(ulong dummy)
 	/* enable console uart printing */
 	preloader_console_init();
 
+#if IS_ENABLED(CONFIG_SOCFPGA_DRAM_SIZE_CHECK)
+	gd->bd = &bdata;
+#endif
+
 	ret = uclass_get_device(UCLASS_RAM, 0, &dev);
 	if (ret) {
 		debug("DRAM init failed: %d\n", ret);
diff --git a/drivers/ddr/altera/sdram_gen5.c b/drivers/ddr/altera/sdram_gen5.c
index 3c79bb11802..1c3c70ea8ae 100644
--- a/drivers/ddr/altera/sdram_gen5.c
+++ b/drivers/ddr/altera/sdram_gen5.c
@@ -5,6 +5,7 @@
 #include <dm.h>
 #include <errno.h>
 #include <div64.h>
+#include <hang.h>
 #include <init.h>
 #include <log.h>
 #include <ram.h>
@@ -15,6 +16,7 @@
 #include <asm/arch/sdram.h>
 #include <asm/arch/system_manager.h>
 #include <asm/bitops.h>
+#include <asm/global_data.h>
 #include <asm/io.h>
 #include <dm/device_compat.h>
 
@@ -22,6 +24,8 @@
 
 #ifdef CONFIG_XPL_BUILD
 
+DECLARE_GLOBAL_DATA_PTR;
+
 struct altera_gen5_sdram_priv {
 	struct ram_info info;
 };
@@ -604,8 +608,31 @@ static int altera_gen5_sdram_probe(struct udevice *dev)
 	sdram_size = sdram_calculate_size(sdr_ctrl);
 	debug("SDRAM: %ld MiB\n", sdram_size >> 20);
 
+#if IS_ENABLED(CONFIG_SOCFPGA_DRAM_SIZE_CHECK)
+	/* setup the dram info within bd */
+	dram_init_banksize();
+
+	if (sdram_size != gd->bd->bi_dram[0].size) {
+		printf("DDR: Warning: DRAM size from device tree (%lu MiB)\n",
+		       (ulong)(gd->bd->bi_dram[0].size >> 20));
+		printf(" mismatch with hardware (%lu MiB).\n",
+		       (ulong)(sdram_size >> 20));
+	}
+
+	if (gd->bd->bi_dram[0].size > sdram_size) {
+		printf("DDR: Error: DRAM size from device tree is greater\n");
+		printf(" than hardware size.\n");
+		hang();
+	}
+#endif
+
 	/* Sanity check ensure correct SDRAM size specified */
+#if IS_ENABLED(CONFIG_SOCFPGA_DRAM_SIZE_CHECK)
+	if (get_ram_size(0, gd->bd->bi_dram[0].size) !=
+	    gd->bd->bi_dram[0].size) {
+#else
 	if (get_ram_size(0, sdram_size) != sdram_size) {
+#endif
 		puts("SDRAM size check failed!\n");
 		goto failed;
 	}
-- 
2.43.7

