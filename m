Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B1BEC43458
	for <u-boot@archiver.kernel.org>; Wed,  8 Jul 2026 12:41:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C76A784A29;
	Wed,  8 Jul 2026 14:40:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="b/sAzaZJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BBB38849D2; Wed,  8 Jul 2026 03:13:15 +0200 (CEST)
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azlp170120002.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c007::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 414108497A
 for <u-boot@lists.denx.de>; Wed,  8 Jul 2026 03:13:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=chen.huei.lok@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q7WDNkZhSohBEMFyvIoCdUsCvPci0KzDkziFDfCaSdT2R+WlTAxYLnDRzQhzAtH39OS1G0scIg/UNaR1/EDIX+HjPh0Cnm6MpdSR/TphhRygUJ7Iwh72fjuxpbps3MDpiSRB8b9PrJdbJUVLjfqJdS3238l/VZjdFEPs9Ti8Sh5Fkfoi7tKAcSeYR9zczVcxQzE6oYdjwLKKAmJLK+iF4p0lgvWeESTFDRzJCU4XPn9FtUdoE0nVdw+kA2966TjaaT52Eer0s8GBg1I+8nDjXmqrp0yPULmFOf8T5vETrCeGFNjUbvD/XACXM7KLG3znRe4Ujx97Dr87PnPeLQ2k2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tjU8D+kkBIAETmdIcCvzFlSx6jmtgFFAyiwJxyzuEzs=;
 b=u64MZ5fjfHC0EL9Zcb2d+QbnNxiXxDxjjG/oCHdjsVulIn6DEbqBhvDl9xWQggrG40jnh34iZ/xwz7R4zjxGj1eRK2i4viNPdboWNg+aHxCr9TOD4SvXYIg7oITW4WLe0omTFOU8HG+i64CzAEGsusQE8019727WN5LzbijE5Zf+T9WxGMG08LzuhMVWyStZKZgdD3DNPum/Zr6EwPdyCpMGcd0sbjtiMVdXiUV/5YrC5Jv4EvyF/2JlMGsZ/d0H/lOkJ/+F4qLi5E6MdzFsFP/si9P37dyzlj6A71EPbnNPULPA1AeKbcTAW0V7bTu73IqL/wL8pvs47cd1MO8yzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tjU8D+kkBIAETmdIcCvzFlSx6jmtgFFAyiwJxyzuEzs=;
 b=b/sAzaZJmqWSagwOhhbyaHZjBOR7Jm2snu3DgQ+i/tm9VT8CW/U1DtVENWO1/fK4E9GAzZLiQGVww3D5VNeT2JaCcEoZ3/ga/kRJqBPUn3ntbZnFvKU7buEe3m+h5IGWIv26npHuyhs00r1HMYf6uONggiMFb+0uKPtTd9byv9psD2nuRzB3dz7UZ69ZTMO5q9siWdiiRQqdUMiB6ky/zx3gSkPVHeAKlG8ej1z1goJnXVglKAxBQNzls6+NRPSm6YnINeO7R75LOerP5exzcm8HDBfDlSk7sbRIU96ChSnndE96rFPN5sR5go0iL1Dj7MvROGdG9uwWUMrhREubwA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from IA3PR03MB8021.namprd03.prod.outlook.com (2603:10b6:208:502::17)
 by MW4PR03MB6473.namprd03.prod.outlook.com (2603:10b6:303:120::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Wed, 8 Jul 2026
 01:13:07 +0000
Received: from IA3PR03MB8021.namprd03.prod.outlook.com
 ([fe80::3016:b672:c683:f7ad]) by IA3PR03MB8021.namprd03.prod.outlook.com
 ([fe80::3016:b672:c683:f7ad%6]) with mapi id 15.21.0181.008; Wed, 8 Jul 2026
 01:13:07 +0000
From: Chen Huei Lok <chen.huei.lok@altera.com>
To: u-boot@lists.denx.de
Cc: Tien Fong Chee <tien.fong.chee@altera.com>, Tom Rini <trini@konsulko.com>,
 Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Chen Huei Lok <chen.huei.lok@altera.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Boon Khai Ng <boon.khai.ng@altera.com>,
 Kok Kiang Hea <kok.kiang.hea@altera.com>
Subject: [PATCH 04/15] ddr: altera: n5x: Add self-refresh support in DDR4
Date: Wed,  8 Jul 2026 09:12:17 +0800
Message-ID: <20260708011228.15613-5-chen.huei.lok@altera.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260708011228.15613-1-chen.huei.lok@altera.com>
References: <20260708011228.15613-1-chen.huei.lok@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0062.namprd03.prod.outlook.com
 (2603:10b6:a03:331::7) To IA3PR03MB8021.namprd03.prod.outlook.com
 (2603:10b6:208:502::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA3PR03MB8021:EE_|MW4PR03MB6473:EE_
X-MS-Office365-Filtering-Correlation-Id: 2dbfc673-f6bd-4336-76ae-08dedc8e1119
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|1800799024|376014|18002099003|11063799006|55112099003|56012099006|3023799007|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info: KSicx0J+1prynI8V6X6J+BHrSakejQfvNE0PT1X2RaIS81rR84VPtXUz6IRnSM4vndV8r9+Z+C9iOBeatGfQEL4elC3ykuTJKNRzEF6O0bkSf54vIvlOhZoZXUJtmrYU0h1RJwdwKBZuq+DZi49xZ3Xbb3A+0s6ypaiA5nzPstWMT/IV8WBC0RL1rNwRhDMLJmrxAKSllIFWDvSlTBUpc1pLGlKZl2wCZSmCCuF+0b/wwSbSkeFCyP0hrNVf4/jGe8a4bX4HaXz37enMnKypRf1mD3famsDgwxSCSpjQk0a0WFNh2v3JdDm454aCwntKypSP0Bvsi7PiaxW709ergDQnEqSwUxdqXK5R1zCPZuojvSIbohrpyha9Z1vcD5aKiWwrWMqQNlHF3TI9LLV9QomWTTCp4swG1tPIi0HKJQRsi7ODJKqN3mHkbDcatbtXlY9jQfh8tTewbfvtBpED5PBdjhZpu+IeNShrKSCGwbxuLCq9Zznqu8P4lRm+v0Z46m5wjC+eqB3QKi6IlsPr6qSo9rrJBbiy640aZab/DF9O/y+yKKPgrmlsx9TufNbqN2XsXuSte168nCfPbeSC7NhpBX+ZL9rDxl8c6JkBfnJdb8Z4W436D7v3seYjyOIpT3S8G6KIJCxtHtmBULWUoOljGme/0Ce/+X8OkMEGcY0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR03MB8021.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(18002099003)(11063799006)(55112099003)(56012099006)(3023799007)(22082099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?LkSpRENgDosLdg0x3ATFCDb0/Ai8JMArKaJmewnHeJvvojA8wZ0Kr26GiBVj?=
 =?us-ascii?Q?ER9YOqmBOB/iFBRnvIe3F2/PIMBp67Yu9KgY59YA2G0ahVtuljlM7W6HXX9T?=
 =?us-ascii?Q?olbUaBnROZXGeOXIQb528qfymEI0+HtbEjF0rJkn7VdzWwZ6Z3PLr91OEkkM?=
 =?us-ascii?Q?VyTfZDBS21OMjMYdRaOZxb2RN6XXdkPenHBhzxaeYoQ41BThsvn30RLgSa3r?=
 =?us-ascii?Q?NZxBw56HcXjUx1T0kNRNHDy9iTLyzuUTbpV1bZdk0tL5et+FgBl3v4AkRAIm?=
 =?us-ascii?Q?mbopbhFiZvHedqJUiGr/xjDhUdqzO2NJZmw19O7hlxTEqxyk80+FIOEjVrl6?=
 =?us-ascii?Q?BNAqIRscey637o0ympiqYhqDxpNFdy/wVRCLiCn+UYploVTQR0nAZiUWiPr1?=
 =?us-ascii?Q?Hh6IItybuYd3FYZQWicZRy8y9UqkmFEf54GbUD8i+XyewAS992+dyMFaonGq?=
 =?us-ascii?Q?fPa/90h/0adYGCQg5nLCmi53hYAgqDvYVhgMiKCgMwPfmEcnwUmbGBAMbd7a?=
 =?us-ascii?Q?nTp4OZrI7+TlzTnwhdtCPQdeoEMUykIZ7/Ria+2yBUn8le1RvYj3izxNAHXF?=
 =?us-ascii?Q?pB47fjbRuOofxYPM42v3dcz2WKbCdQFs+GtMbuLIP18l8pOOG6IKbPvivFaJ?=
 =?us-ascii?Q?hwRYnYgq5w4raZr198jAZrya6pNOJ2iP1vV5IMVl1lv2RLq4IWEId2Cqe6DM?=
 =?us-ascii?Q?ulKBJfbYJFXYD3K8neqLBV1nYV25egD17YhpD2dJDBzi5p3t5r+XMwq9EubO?=
 =?us-ascii?Q?/unp5FJ5GZuylgAy5kP8/Pf9xOhmxxMYGbdIeGpeXC5MTbB4UYTwxR0Onty2?=
 =?us-ascii?Q?6Al6pg2bes1INkTVRy6ZexVcbR9Jfrab78Usl1XG3mXiuMoJKvmulTLh/gfZ?=
 =?us-ascii?Q?xWYLcFC2teopFQ8OSNOPZQ54dEMb+gQdISI650YKgqUG+CPLgPIlrnc9Oe/+?=
 =?us-ascii?Q?7nr8KYNN0C2wV1TQZqYICOdh0QrxVs1IX/1yh+TEQUGixpNg1xsO+8dROyW0?=
 =?us-ascii?Q?tsehu1DvcMFyrVZOAM4oF6lK+pLvDIf+z2BRqDT+gh5GPOjiGZSDTcLbrNH+?=
 =?us-ascii?Q?E79/ftcd7SDgckb2cPEKhugDbTs6eAiutHBC3QxDWmIrHLoHFxoU/oGBxLOd?=
 =?us-ascii?Q?jYEiIXhedUyP9BdYAzrl/ja1sOmR9LL6SlCt2A20x+7LDl2rqHkM+8o5hVGD?=
 =?us-ascii?Q?ijTiSk/xAhvGjH3ExwxoefVMNXhJNTgO1FO/cicfZGfBYV54MGrHg4p/djS2?=
 =?us-ascii?Q?yf0cxg0sDcMQfnUdhMC0fQLT6+a2qG0cbWDBDzx2W8Pt9QttUiJro8qcN07z?=
 =?us-ascii?Q?i0qJqtw4Z82KGvscbK+4W+yvH7tb5YiTy4pJYKG6vLTjiPUJv4Y9psVSBxDT?=
 =?us-ascii?Q?PSaKEkyHnakLY9Zpr+rHyw5GQvWB4/SZsEQlb54t6q0/oYMawu2ccEF+hM98?=
 =?us-ascii?Q?mwbkO9tpMQGS4/+73ozjQbeSxKmhBSPNjKGUdx++3MpbGTZpOGFubl3rphtk?=
 =?us-ascii?Q?nzQLHuEIoPVflLonWJtvrlkUrsnAmcVXm5MMHCVGFmjZn0sy/BcCbPUehCiy?=
 =?us-ascii?Q?aKfYu1eNA6246P8huh4bpSNBs5F9Qxq1EBB96mnO4YX/iLbVibhNe3R25NgC?=
 =?us-ascii?Q?g3nsggWKNsgmLubRnLX+1Cjgj8xvJD2kq0PjkkTrYjQ/1E3b3HxoPVJ9n4XM?=
 =?us-ascii?Q?dP7fJb9GeaL1wxsl47VZrOpipr3hzYJmp9jBO6/HV+yxzBktMBlrhYIpHb7B?=
 =?us-ascii?Q?tnltvmSViywDXVTNpYFQFl/ZCvLs1Mo=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2dbfc673-f6bd-4336-76ae-08dedc8e1119
X-MS-Exchange-CrossTenant-AuthSource: IA3PR03MB8021.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2026 01:13:07.2173 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k3O2n3ybj00zapjls4YOE29vHIJm3vjv4tAmPHVN6GGWkVdY5i+FznVf3apuNXzcJo9+ZtSqQrb/77veEhon8zqzKyJGQm148XFHPDBAMr4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR03MB6473
X-Mailman-Approved-At: Wed, 08 Jul 2026 14:40:34 +0200
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

From: Tien Fong Chee <tien.fong.chee@altera.com>

Enable self-refresh support in DDR4 for retaining DDR4 content with
minimal power when reset is triggered. On a warm reset the trained PHY
calibration data is restored from a backup instead of running a full
calibration, so the DDR contents are preserved across the reset.

The same INIT0.skip_dram_init / PWRCTL self-refresh entry settings that
LPDDR4 requires are also applied to DDR4, as some DDR4 chips need them to
enter and exit retention correctly.

The backup calibration data is copied to DDR only when DDR retention is
enabled, and the backup header length ('cal->header.data_len') is
validated against the HPS handoff region so a corrupted or oversized
value cannot overflow into the handoff data before it is consumed.

Look up the DDR controller node using the "intel,sdr-ctl-n5x" compatible
string so it matches the node defined in the device tree.

Signed-off-by: Tien Fong Chee <tien.fong.chee@altera.com>
Signed-off-by: Chen Huei Lok <chen.huei.lok@altera.com>
---
 .../include/mach/system_manager_soc64.h       |   3 +-
 drivers/ddr/altera/sdram_n5x.c                | 841 ++++++++++++++++--
 2 files changed, 762 insertions(+), 82 deletions(-)

diff --git a/arch/arm/mach-socfpga/include/mach/system_manager_soc64.h b/arch/arm/mach-socfpga/include/mach/system_manager_soc64.h
index 8be98d0ee46..6e355f02158 100644
--- a/arch/arm/mach-socfpga/include/mach/system_manager_soc64.h
+++ b/arch/arm/mach-socfpga/include/mach/system_manager_soc64.h
@@ -149,8 +149,7 @@ void populate_sysmgr_pinmux(void);
  * storing qspi ref clock (kHz)
  */
 #define ALT_SYSMGR_SCRATCH_REG_0_DDR_RETENTION_MASK	BIT(31)
-#define ALT_SYSMGR_SCRATCH_REG_0_DDR_SHA_MASK		BIT(30)
-#define ALT_SYSMGR_SCRATCH_REG_0_DDR_RESET_TYPE_MASK	(BIT(29) | BIT(28))
+#define ALT_SYSMGR_SCRATCH_REG_0_DDR_RESET_TYPE_MASK GENMASK(30, 28)
 #define ALT_SYSMGR_SCRATCH_REG_0_DDR_RESET_TYPE_SHIFT	28
 
 /*
diff --git a/drivers/ddr/altera/sdram_n5x.c b/drivers/ddr/altera/sdram_n5x.c
index 17ec6afa82b..609f0f9cbd7 100644
--- a/drivers/ddr/altera/sdram_n5x.c
+++ b/drivers/ddr/altera/sdram_n5x.c
@@ -7,6 +7,7 @@
 #include <clk.h>
 #include <div64.h>
 #include <dm.h>
+#include <fs_loader.h>
 #include <errno.h>
 #include <fdtdec.h>
 #include <hang.h>
@@ -20,12 +21,26 @@
 #include <asm/arch/reset_manager.h>
 #include <asm/arch/system_manager.h>
 #include <asm/io.h>
+#include <dm/ofnode.h>
 #include <linux/err.h>
 #include <linux/sizes.h>
+#include <u-boot/crc.h>
+#include <u-boot/sha512.h>
 #include <u-boot/schedule.h>
 
 DECLARE_GLOBAL_DATA_PTR;
 
+/* PHY calibration data backup attribute */
+#define SOC64_OCRAM_PHY_BACKUP_BASE		0xFFE5E400
+/* "SKIP" */
+#define SOC64_CRAM_PHY_BACKUP_SKIP_MAGIC	0x50494B53
+#define BAC_CAL_MMC_RAW_OFFSET (CONFIG_ENV_SIZE + CONFIG_ENV_OFFSET)
+
+/* DDR handoff SHA384 attribute */
+#define DDR_HANDOFF_IMG_ADDR	0xFFE44000
+#define DDR_HANDOFF_IMG_LEN	0x1A000
+#define CHUNKSZ_PER_WD_RESET	(256 * 1024)
+
 /* MPFE NOC registers */
 #define FPGA2SDRAM_MGR_MAIN_SIDEBANDMGR_FLAGOUTSET0	0xF8024050
 
@@ -333,7 +348,10 @@ enum ddr_type {
 enum reset_type {
 	POR_RESET,
 	WARM_RESET,
-	COLD_RESET
+	COLD_RESET,
+	NCONFIG,
+	JTAG_CONFIG,
+	RSU_RECONFIG
 };
 
 /* DDR handoff structure */
@@ -379,6 +397,107 @@ enum message_mode {
 	STREAMING_MESSAGE
 };
 
+enum data_type {
+	HEADER_ONLY,
+	HEADER_DATA
+};
+
+/* Header for backup calibration data */
+struct cal_header_t {
+	u32 header_magic;
+	u32 data_len;
+	u32 caldata_crc32;
+	u8 ddrconfig_hash[SHA384_SUM_LEN];
+} __packed;
+
+/* Header + backup calibration data */
+struct bac_cal_data_t {
+	struct cal_header_t header;
+	u16 data;
+} __packed;
+
+enum data_process {
+	STORE,
+	LOADING
+};
+
+bool is_ddr_retention_enabled(u32 reg)
+{
+	if (reg & ALT_SYSMGR_SCRATCH_REG_0_DDR_RETENTION_MASK)
+		return true;
+
+	return false;
+}
+
+static enum reset_type get_reset_type(u32 reg)
+{
+	return (reg & ALT_SYSMGR_SCRATCH_REG_0_DDR_RESET_TYPE_MASK) >>
+		ALT_SYSMGR_SCRATCH_REG_0_DDR_RESET_TYPE_SHIFT;
+}
+
+void reset_type_print(enum reset_type reset_t)
+{
+	switch (reset_t) {
+	case POR_RESET:
+		printf("%s: POR is triggered\n", __func__);
+		break;
+	case WARM_RESET:
+		printf("%s: Warm reset is triggered\n", __func__);
+		break;
+	case COLD_RESET:
+		printf("%s: Cold reset is triggered\n", __func__);
+		break;
+	case NCONFIG:
+		printf("%s: NCONFIG is triggered\n", __func__);
+		break;
+	case JTAG_CONFIG:
+		printf("%s: JTAG_CONFIG is triggered\n", __func__);
+		break;
+	case RSU_RECONFIG:
+		printf("%s: RSU_RECONFIG is triggered\n", __func__);
+		break;
+	default:
+		printf("%s: Invalid reset type\n", __func__);
+	}
+}
+
+bool is_ddr_init_skipped(u32 reg)
+{
+	enum reset_type reset_t = get_reset_type(reg);
+
+	reset_type_print(reset_t);
+
+	if (reset_t == WARM_RESET) {
+		debug("%s: DDR init is skipped\n", __func__);
+		return true;
+	}
+
+	if (reset_t == COLD_RESET) {
+		if (is_ddr_retention_enabled(reg)) {
+			debug("%s: DDR retention bit is set\n", __func__);
+			debug("%s: DDR init is skipped\n", __func__);
+			return true;
+		}
+	}
+
+	debug("%s: DDR init is required\n", __func__);
+	return false;
+}
+
+bool is_ddr_calibration_skipped(u32 reg)
+{
+	enum reset_type reset_t = get_reset_type(reg);
+
+	if ((reset_t == NCONFIG || reset_t == JTAG_CONFIG ||
+	     reset_t == RSU_RECONFIG) && is_ddr_retention_enabled(reg)) {
+		debug("%s: DDR retention bit is set\n", __func__);
+		return true;
+	}
+
+	debug("%s: DDR calibration is required\n", __func__);
+	return false;
+}
+
 static int clr_ca_parity_error_status(phys_addr_t umctl2_base)
 {
 	int ret;
@@ -711,6 +830,7 @@ static int scrubber_ddr_config(phys_addr_t umctl2_base,
 	writel(0, umctl2_base + DDR4_SBRRANGE0_OFFSET);
 	writel(0, umctl2_base + DDR4_SBRRANGE1_OFFSET);
 
+	printf("Enabling scrubber ...\n");
 	/* Enables scrubber */
 	setbits_le32(umctl2_base + DDR4_SBRCTL_OFFSET, DDR4_SBRCTL_SCRUB_EN);
 	/* Polling all scrub writes commands have been sent */
@@ -848,14 +968,13 @@ static int init_umctl2(phys_addr_t umctl2_handoff_base,
 		/* Setting selfref_sw to 1, based on lpddr4 requirement */
 		setbits_le32(umctl2_base + DDR4_PWRCTL_OFFSET,
 			     DDR4_PWRCTL_SELFREF_SW);
-
 		/* Backup user settings, restore after DDR up running */
 		user_backup++;
 		*user_backup = readl(umctl2_base + DDR4_INIT0_OFFSET) &
 				     DDR4_INIT0_SKIP_RAM_INIT;
 
 		/*
-		 * Setting INIT0.skip_dram_init to 0x3, based on lpddr4
+		 * Setting INIT0.skip_dram_init to 0x3, based on ddr4 / lpddr4
 		 * requirement
 		 */
 		setbits_le32(umctl2_base + DDR4_INIT0_OFFSET,
@@ -924,9 +1043,534 @@ static int phy_pre_handoff_config(phys_addr_t umctl2_base,
 	return ret;
 }
 
-static int init_phy(struct ddr_handoff *ddr_handoff_info)
+static void phy_ocram(phys_addr_t phy_base, phys_addr_t phy_offset,
+		      u16 *data, enum data_process proc)
+{
+	u32 abs_addr;
+
+	abs_addr = phy_base + (phy_offset << 1);
+
+	if (proc == STORE) {
+		/* Storing PHY value */
+		writew(readw((uintptr_t)abs_addr), data);
+		debug("%s: PHY offset 0x%08x, data %x\n", __func__,
+		      (u32)phy_offset, readw((uintptr_t)data));
+	} else if (proc == LOADING) {
+		/* Loading bak cal data to PHY */
+		writew(readw(data), (uintptr_t)abs_addr);
+		debug("%s: PHY offset 0x%08x, data %x\n", __func__,
+		      (u32)phy_offset, readw((uintptr_t)abs_addr));
+	}
+}
+
+static int cal_data_ocram(phys_addr_t phy_base, u32 addr,
+			  enum data_process proc)
+{
+	/*
+	 * This array variable contains a list of PHY registers required for
+	 * backup before DDR entering self-refresh mode
+	 */
+	static const u32 phybak[] = {0x1005f, 0x1015f, 0x1105f, 0x1115f, 0x1205f,
+			0x1215f, 0x1305f, 0x1315f, 0x1405f, 0x1415f,
+			0x1505f, 0x1515f, 0x1605f, 0x1615f, 0x1705f,
+			0x1715f, 0x1805f, 0x1815f, 0x00055, 0x01055,
+			0x02055, 0x03055, 0x04055, 0x05055, 0x06055,
+			0x07055, 0x08055, 0x09055, 0x200c5, 0x2002e,
+			0x20024, 0x2003a, 0x2007d, 0x2007c, 0x20056,
+			0x1004d, 0x1014d, 0x1104d, 0x1114d, 0x1204d,
+			0x1214d, 0x1304d, 0x1314d, 0x1404d, 0x1414d,
+			0x1504d, 0x1514d, 0x1604d, 0x1614d, 0x1704d,
+			0x1714d, 0x1804d, 0x1814d, 0x10049, 0x10149,
+			0x11049, 0x11149, 0x12049, 0x12149, 0x13049,
+			0x13149, 0x14049, 0x14149, 0x15049, 0x15149,
+			0x16049, 0x16149, 0x17049, 0x17149, 0x18049,
+			0x18149, 0x00043, 0x01043, 0x02043, 0x03043,
+			0x04043, 0x05043, 0x06043, 0x07043, 0x08043,
+			0x09043, 0x20018, 0x20075, 0x20050, 0x2009b,
+			0x20008, 0x20088, 0x200b2, 0x10043, 0x10143,
+			0x11043, 0x11143, 0x12043, 0x12143, 0x13043,
+			0x13143, 0x14043, 0x14143, 0x15043, 0x15143,
+			0x16043, 0x16143, 0x17043, 0x17143, 0x18043,
+			0x18143, 0x2005b, 0x2005c, 0x200fa, 0x20019,
+			0x200f0, 0x200f1, 0x200f2, 0x200f3, 0x200f4,
+			0x200f5, 0x200f6, 0x200f7, 0x1004a, 0x1104a,
+			0x1204a, 0x1304a, 0x1404a, 0x1504a, 0x1604a,
+			0x1704a, 0x1804a, 0x20025, 0x2002d, 0x2002c,
+			0xd0000, 0x90000, 0x90001, 0x90002, 0x90003,
+			0x90004, 0x90005, 0x90029, 0x9002a, 0x9002b,
+			0x9002c, 0x9002d, 0x9002e, 0x9002f, 0x90030,
+			0x90031, 0x90032, 0x90033, 0x90034, 0x90035,
+			0x90036, 0x90037, 0x90038, 0x90039, 0x9003a,
+			0x9003b, 0x9003c, 0x9003d, 0x9003e, 0x9003f,
+			0x90040, 0x90041, 0x90042, 0x90043, 0x90044,
+			0x90045, 0x90046, 0x90047, 0x90048, 0x90049,
+			0x9004a, 0x9004b, 0x9004c, 0x9004d, 0x9004e,
+			0x9004f, 0x90050, 0x90051, 0x90052, 0x90053,
+			0x90054, 0x90055, 0x90056, 0x90057, 0x90058,
+			0x90059, 0x9005a, 0x9005b, 0x9005c, 0x9005d,
+			0x9005e, 0x9005f, 0x90060, 0x90061, 0x90062,
+			0x90063, 0x90064, 0x90065, 0x90066, 0x90067,
+			0x90068, 0x90069, 0x9006a, 0x9006b, 0x9006c,
+			0x9006d, 0x9006e, 0x9006f, 0x90070, 0x90071,
+			0x90072, 0x90073, 0x90074, 0x90075, 0x90076,
+			0x90077, 0x90078, 0x90079, 0x9007a, 0x9007b,
+			0x9007c, 0x9007d, 0x9007e, 0x9007f, 0x90080,
+			0x90081, 0x90082, 0x90083, 0x90084, 0x90085,
+			0x90086, 0x90087, 0x90088, 0x90089, 0x9008a,
+			0x9008b, 0x9008c, 0x9008d, 0x9008e, 0x9008f,
+			0x90090, 0x90091, 0x90092, 0x90093, 0x90094,
+			0x90095, 0x90096, 0x90097, 0x90098, 0x90099,
+			0x9009a, 0x9009b, 0x9009c, 0x9009d, 0x9009e,
+			0x9009f, 0x900a0, 0x900a1, 0x900a2, 0x900a3,
+			0x900a4, 0x900a5, 0x900a6, 0x900a7, 0x900a8,
+			0x900a9, 0x900aa, 0x900ab, 0x900ac, 0x900ad,
+			0x900ae, 0x900af, 0x900b0, 0x900b1, 0x900b2,
+			0x900b3, 0x900b4, 0x900b5, 0x900b6, 0x900b7,
+			0x900b8, 0x900b9, 0x900ba, 0x900bb, 0x900bc,
+			0x900bd, 0x900be, 0x900bf, 0x900c0, 0x900c1,
+			0x900c2, 0x900c3, 0x900c4, 0x900c5, 0x900c6,
+			0x900c7, 0x90006, 0x90007, 0x90008, 0x90009,
+			0x9000a, 0x9000b, 0xd00e7, 0x90017, 0x90026,
+			0x2000b, 0x2000c, 0x2000d, 0x2000e, 0x9000c,
+			0x9000d, 0x9000e, 0x9000f, 0x90010, 0x90011,
+			0x90012, 0x90013, 0x20089, 0xc0080, 0x200cb,
+			0x10068, 0x10069, 0x1006a, 0x1006b, 0x10168,
+			0x10169, 0x1016a, 0x1016b, 0x10268, 0x10269,
+			0x1026a, 0x1026b, 0x10368, 0x10369, 0x1036a,
+			0x1036b, 0x10468, 0x10469, 0x1046a, 0x1046b,
+			0x10568, 0x10569, 0x1056a, 0x1056b, 0x10668,
+			0x10669, 0x1066a, 0x1066b, 0x10768, 0x10769,
+			0x1076a, 0x1076b, 0x10868, 0x10869, 0x1086a,
+			0x1086b, 0x11068, 0x11069, 0x1106a, 0x1106b,
+			0x11168, 0x11169, 0x1116a, 0x1116b, 0x11268,
+			0x11269, 0x1126a, 0x1126b, 0x11368, 0x11369,
+			0x1136a, 0x1136b, 0x11468, 0x11469, 0x1146a,
+			0x1146b, 0x11568, 0x11569, 0x1156a, 0x1156b,
+			0x11668, 0x11669, 0x1166a, 0x1166b, 0x11768,
+			0x11769, 0x1176a, 0x1176b, 0x11868, 0x11869,
+			0x1186a, 0x1186b, 0x12068, 0x12069, 0x1206a,
+			0x1206b, 0x12168, 0x12169, 0x1216a, 0x1216b,
+			0x12268, 0x12269, 0x1226a, 0x1226b, 0x12368,
+			0x12369, 0x1236a, 0x1236b, 0x12468, 0x12469,
+			0x1246a, 0x1246b, 0x12568, 0x12569, 0x1256a,
+			0x1256b, 0x12668, 0x12669, 0x1266a, 0x1266b,
+			0x12768, 0x12769, 0x1276a, 0x1276b, 0x12868,
+			0x12869, 0x1286a, 0x1286b, 0x13068, 0x13069,
+			0x1306a, 0x1306b, 0x13168, 0x13169, 0x1316a,
+			0x1316b, 0x13268, 0x13269, 0x1326a, 0x1326b,
+			0x13368, 0x13369, 0x1336a, 0x1336b, 0x13468,
+			0x13469, 0x1346a, 0x1346b, 0x13568, 0x13569,
+			0x1356a, 0x1356b, 0x13668, 0x13669, 0x1366a,
+			0x1366b, 0x13768, 0x13769, 0x1376a, 0x1376b,
+			0x13868, 0x13869, 0x1386a, 0x1386b, 0x14068,
+			0x14069, 0x1406a, 0x1406b, 0x14168, 0x14169,
+			0x1416a, 0x1416b, 0x14268, 0x14269, 0x1426a,
+			0x1426b, 0x14368, 0x14369, 0x1436a, 0x1436b,
+			0x14468, 0x14469, 0x1446a, 0x1446b, 0x14568,
+			0x14569, 0x1456a, 0x1456b, 0x14668, 0x14669,
+			0x1466a, 0x1466b, 0x14768, 0x14769, 0x1476a,
+			0x1476b, 0x14868, 0x14869, 0x1486a, 0x1486b,
+			0x15068, 0x15069, 0x1506a, 0x1506b, 0x15168,
+			0x15169, 0x1516a, 0x1516b, 0x15268, 0x15269,
+			0x1526a, 0x1526b, 0x15368, 0x15369, 0x1536a,
+			0x1536b, 0x15468, 0x15469, 0x1546a, 0x1546b,
+			0x15568, 0x15569, 0x1556a, 0x1556b, 0x15668,
+			0x15669, 0x1566a, 0x1566b, 0x15768, 0x15769,
+			0x1576a, 0x1576b, 0x15868, 0x15869, 0x1586a,
+			0x1586b, 0x16068, 0x16069, 0x1606a, 0x1606b,
+			0x16168, 0x16169, 0x1616a, 0x1616b, 0x16268,
+			0x16269, 0x1626a, 0x1626b, 0x16368, 0x16369,
+			0x1636a, 0x1636b, 0x16468, 0x16469, 0x1646a,
+			0x1646b, 0x16568, 0x16569, 0x1656a, 0x1656b,
+			0x16668, 0x16669, 0x1666a, 0x1666b, 0x16768,
+			0x16769, 0x1676a, 0x1676b, 0x16868, 0x16869,
+			0x1686a, 0x1686b, 0x17068, 0x17069, 0x1706a,
+			0x1706b, 0x17168, 0x17169, 0x1716a, 0x1716b,
+			0x17268, 0x17269, 0x1726a, 0x1726b, 0x17368,
+			0x17369, 0x1736a, 0x1736b, 0x17468, 0x17469,
+			0x1746a, 0x1746b, 0x17568, 0x17569, 0x1756a,
+			0x1756b, 0x17668, 0x17669, 0x1766a, 0x1766b,
+			0x17768, 0x17769, 0x1776a, 0x1776b, 0x17868,
+			0x17869, 0x1786a, 0x1786b, 0x18068, 0x18069,
+			0x1806a, 0x1806b, 0x18168, 0x18169, 0x1816a,
+			0x1816b, 0x18268, 0x18269, 0x1826a, 0x1826b,
+			0x18368, 0x18369, 0x1836a, 0x1836b, 0x18468,
+			0x18469, 0x1846a, 0x1846b, 0x18568, 0x18569,
+			0x1856a, 0x1856b, 0x18668, 0x18669, 0x1866a,
+			0x1866b, 0x18768, 0x18769, 0x1876a, 0x1876b,
+			0x18868, 0x18869, 0x1886a, 0x1886b, 0x00080,
+			0x01080, 0x02080, 0x03080, 0x04080, 0x05080,
+			0x06080, 0x07080, 0x08080, 0x09080, 0x10020,
+			0x10080, 0x10081, 0x10082, 0x10083, 0x100d0,
+			0x100d1, 0x100d2, 0x100d3, 0x1008c, 0x1008d,
+			0x1008e, 0x1008f, 0x10180, 0x10181, 0x10182,
+			0x10183, 0x101d0, 0x101d1, 0x101d2, 0x101d3,
+			0x1018c, 0x1018d, 0x1018e, 0x1018f, 0x100c0,
+			0x100c1, 0x100c2, 0x100c3, 0x101c0, 0x101c1,
+			0x101c2, 0x101c3, 0x102c0, 0x102c1, 0x102c2,
+			0x102c3, 0x103c0, 0x103c1, 0x103c2, 0x103c3,
+			0x104c0, 0x104c1, 0x104c2, 0x104c3, 0x105c0,
+			0x105c1, 0x105c2, 0x105c3, 0x106c0, 0x106c1,
+			0x106c2, 0x106c3, 0x107c0, 0x107c1, 0x107c2,
+			0x107c3, 0x108c0, 0x108c1, 0x108c2, 0x108c3,
+			0x11020, 0x11080, 0x11081, 0x11082, 0x11083,
+			0x110d0, 0x110d1, 0x110d2, 0x110d3, 0x1108c,
+			0x1108d, 0x1108e, 0x1108f, 0x11180, 0x11181,
+			0x11182, 0x11183, 0x111d0, 0x111d1, 0x111d2,
+			0x111d3, 0x1118c, 0x1118d, 0x1118e, 0x1118f,
+			0x110c0, 0x110c1, 0x110c2, 0x110c3, 0x111c0,
+			0x111c1, 0x111c2, 0x111c3, 0x112c0, 0x112c1,
+			0x112c2, 0x112c3, 0x113c0, 0x113c1, 0x113c2,
+			0x113c3, 0x114c0, 0x114c1, 0x114c2, 0x114c3,
+			0x115c0, 0x115c1, 0x115c2, 0x115c3, 0x116c0,
+			0x116c1, 0x116c2, 0x116c3, 0x117c0, 0x117c1,
+			0x117c2, 0x117c3, 0x118c0, 0x118c1, 0x118c2,
+			0x118c3, 0x12020, 0x12080, 0x12081, 0x12082,
+			0x12083, 0x120d0, 0x120d1, 0x120d2, 0x120d3,
+			0x1208c, 0x1208d, 0x1208e, 0x1208f, 0x12180,
+			0x12181, 0x12182, 0x12183, 0x121d0, 0x121d1,
+			0x121d2, 0x121d3, 0x1218c, 0x1218d, 0x1218e,
+			0x1218f, 0x120c0, 0x120c1, 0x120c2, 0x120c3,
+			0x121c0, 0x121c1, 0x121c2, 0x121c3, 0x122c0,
+			0x122c1, 0x122c2, 0x122c3, 0x123c0, 0x123c1,
+			0x123c2, 0x123c3, 0x124c0, 0x124c1, 0x124c2,
+			0x124c3, 0x125c0, 0x125c1, 0x125c2, 0x125c3,
+			0x126c0, 0x126c1, 0x126c2, 0x126c3, 0x127c0,
+			0x127c1, 0x127c2, 0x127c3, 0x128c0, 0x128c1,
+			0x128c2, 0x128c3, 0x13020, 0x13080, 0x13081,
+			0x13082, 0x13083, 0x130d0, 0x130d1, 0x130d2,
+			0x130d3, 0x1308c, 0x1308d, 0x1308e, 0x1308f,
+			0x13180, 0x13181, 0x13182, 0x13183, 0x131d0,
+			0x131d1, 0x131d2, 0x131d3, 0x1318c, 0x1318d,
+			0x1318e, 0x1318f, 0x130c0, 0x130c1, 0x130c2,
+			0x130c3, 0x131c0, 0x131c1, 0x131c2, 0x131c3,
+			0x132c0, 0x132c1, 0x132c2, 0x132c3, 0x133c0,
+			0x133c1, 0x133c2, 0x133c3, 0x134c0, 0x134c1,
+			0x134c2, 0x134c3, 0x135c0, 0x135c1, 0x135c2,
+			0x135c3, 0x136c0, 0x136c1, 0x136c2, 0x136c3,
+			0x137c0, 0x137c1, 0x137c2, 0x137c3, 0x138c0,
+			0x138c1, 0x138c2, 0x138c3, 0x14020, 0x14080,
+			0x14081, 0x14082, 0x14083, 0x140d0, 0x140d1,
+			0x140d2, 0x140d3, 0x1408c, 0x1408d, 0x1408e,
+			0x1408f, 0x14180, 0x14181, 0x14182, 0x14183,
+			0x141d0, 0x141d1, 0x141d2, 0x141d3, 0x1418c,
+			0x1418d, 0x1418e, 0x1418f, 0x140c0, 0x140c1,
+			0x140c2, 0x140c3, 0x141c0, 0x141c1, 0x141c2,
+			0x141c3, 0x142c0, 0x142c1, 0x142c2, 0x142c3,
+			0x143c0, 0x143c1, 0x143c2, 0x143c3, 0x144c0,
+			0x144c1, 0x144c2, 0x144c3, 0x145c0, 0x145c1,
+			0x145c2, 0x145c3, 0x146c0, 0x146c1, 0x146c2,
+			0x146c3, 0x147c0, 0x147c1, 0x147c2, 0x147c3,
+			0x148c0, 0x148c1, 0x148c2, 0x148c3, 0x15020,
+			0x15080, 0x15081, 0x15082, 0x15083, 0x150d0,
+			0x150d1, 0x150d2, 0x150d3, 0x1508c, 0x1508d,
+			0x1508e, 0x1508f, 0x15180, 0x15181, 0x15182,
+			0x15183, 0x151d0, 0x151d1, 0x151d2, 0x151d3,
+			0x1518c, 0x1518d, 0x1518e, 0x1518f, 0x150c0,
+			0x150c1, 0x150c2, 0x150c3, 0x151c0, 0x151c1,
+			0x151c2, 0x151c3, 0x152c0, 0x152c1, 0x152c2,
+			0x152c3, 0x153c0, 0x153c1, 0x153c2, 0x153c3,
+			0x154c0, 0x154c1, 0x154c2, 0x154c3, 0x155c0,
+			0x155c1, 0x155c2, 0x155c3, 0x156c0, 0x156c1,
+			0x156c2, 0x156c3, 0x157c0, 0x157c1, 0x157c2,
+			0x157c3, 0x158c0, 0x158c1, 0x158c2, 0x158c3,
+			0x16020, 0x16080, 0x16081, 0x16082, 0x16083,
+			0x160d0, 0x160d1, 0x160d2, 0x160d3, 0x1608c,
+			0x1608d, 0x1608e, 0x1608f, 0x16180, 0x16181,
+			0x16182, 0x16183, 0x161d0, 0x161d1, 0x161d2,
+			0x161d3, 0x1618c, 0x1618d, 0x1618e, 0x1618f,
+			0x160c0, 0x160c1, 0x160c2, 0x160c3, 0x161c0,
+			0x161c1, 0x161c2, 0x161c3, 0x162c0, 0x162c1,
+			0x162c2, 0x162c3, 0x163c0, 0x163c1, 0x163c2,
+			0x163c3, 0x164c0, 0x164c1, 0x164c2, 0x164c3,
+			0x165c0, 0x165c1, 0x165c2, 0x165c3, 0x166c0,
+			0x166c1, 0x166c2, 0x166c3, 0x167c0, 0x167c1,
+			0x167c2, 0x167c3, 0x168c0, 0x168c1, 0x168c2,
+			0x168c3, 0x17020, 0x17080, 0x17081, 0x17082,
+			0x17083, 0x170d0, 0x170d1, 0x170d2, 0x170d3,
+			0x1708c, 0x1708d, 0x1708e, 0x1708f, 0x17180,
+			0x17181, 0x17182, 0x17183, 0x171d0, 0x171d1,
+			0x171d2, 0x171d3, 0x1718c, 0x1718d, 0x1718e,
+			0x1718f, 0x170c0, 0x170c1, 0x170c2, 0x170c3,
+			0x171c0, 0x171c1, 0x171c2, 0x171c3, 0x172c0,
+			0x172c1, 0x172c2, 0x172c3, 0x173c0, 0x173c1,
+			0x173c2, 0x173c3, 0x174c0, 0x174c1, 0x174c2,
+			0x174c3, 0x175c0, 0x175c1, 0x175c2, 0x175c3,
+			0x176c0, 0x176c1, 0x176c2, 0x176c3, 0x177c0,
+			0x177c1, 0x177c2, 0x177c3, 0x178c0, 0x178c1,
+			0x178c2, 0x178c3, 0x18020, 0x18080, 0x18081,
+			0x18082, 0x18083, 0x180d0, 0x180d1, 0x180d2,
+			0x180d3, 0x1808c, 0x1808d, 0x1808e, 0x1808f,
+			0x18180, 0x18181, 0x18182, 0x18183, 0x181d0,
+			0x181d1, 0x181d2, 0x181d3, 0x1818c, 0x1818d,
+			0x1818e, 0x1818f, 0x180c0, 0x180c1, 0x180c2,
+			0x180c3, 0x181c0, 0x181c1, 0x181c2, 0x181c3,
+			0x182c0, 0x182c1, 0x182c2, 0x182c3, 0x183c0,
+			0x183c1, 0x183c2, 0x183c3, 0x184c0, 0x184c1,
+			0x184c2, 0x184c3, 0x185c0, 0x185c1, 0x185c2,
+			0x185c3, 0x186c0, 0x186c1, 0x186c2, 0x186c3,
+			0x187c0, 0x187c1, 0x187c2, 0x187c3, 0x188c0,
+			0x188c1, 0x188c2, 0x188c3, 0x90201, 0x90202,
+			0x90203, 0x90204, 0x90205, 0x90206, 0x90207,
+			0x90208, 0x20077, 0x10040, 0x10030, 0x10140,
+			0x10130, 0x10240, 0x10230, 0x10340, 0x10330,
+			0x10440, 0x10430, 0x10540, 0x10530, 0x10640,
+			0x10630, 0x10740, 0x10730, 0x10840, 0x10830,
+			0x11040, 0x11030, 0x11140, 0x11130, 0x11240,
+			0x11230, 0x11340, 0x11330, 0x11440, 0x11430,
+			0x11540, 0x11530, 0x11640, 0x11630, 0x11740,
+			0x11730, 0x11840, 0x11830, 0x12040, 0x12030,
+			0x12140, 0x12130, 0x12240, 0x12230, 0x12340,
+			0x12330, 0x12440, 0x12430, 0x12540, 0x12530,
+			0x12640, 0x12630, 0x12740, 0x12730, 0x12840,
+			0x12830, 0x13040, 0x13030, 0x13140, 0x13130,
+			0x13240, 0x13230, 0x13340, 0x13330, 0x13440,
+			0x13430, 0x13540, 0x13530, 0x13640, 0x13630,
+			0x13740, 0x13730, 0x13840, 0x13830, 0x14040,
+			0x14030, 0x14140, 0x14130, 0x14240, 0x14230,
+			0x14340, 0x14330, 0x14440, 0x14430, 0x14540,
+			0x14530, 0x14640, 0x14630, 0x14740, 0x14730,
+			0x14840, 0x14830, 0x15040, 0x15030, 0x15140,
+			0x15130, 0x15240, 0x15230, 0x15340, 0x15330,
+			0x15440, 0x15430, 0x15540, 0x15530, 0x15640,
+			0x15630, 0x15740, 0x15730, 0x15840, 0x15830,
+			0x16040, 0x16030, 0x16140, 0x16130, 0x16240,
+			0x16230, 0x16340, 0x16330, 0x16440, 0x16430,
+			0x16540, 0x16530, 0x16640, 0x16630, 0x16740,
+			0x16730, 0x16840, 0x16830, 0x17040, 0x17030,
+			0x17140, 0x17130, 0x17240, 0x17230, 0x17340,
+			0x17330, 0x17440, 0x17430, 0x17540, 0x17530,
+			0x17640, 0x17630, 0x17740, 0x17730, 0x17840,
+			0x17830, 0x18040, 0x18030, 0x18140, 0x18130,
+			0x18240, 0x18230, 0x18340, 0x18330, 0x18440,
+			0x18430, 0x18540, 0x18530, 0x18640, 0x18630,
+			0x18740, 0x18730, 0x18840, 0x18830};
+	size_t phybak_num;
+	const u32 *phybak_p = phybak;
+	u16 *data;
+	struct bac_cal_data_t *cal = (struct bac_cal_data_t *)
+					((uintptr_t)addr);
+
+	/* Enable access to the PHY configuration registers */
+	clrbits_le16(phy_base + DDR_PHY_APBONLY0_OFFSET,
+		     DDR_PHY_MICROCONTMUXSEL);
+
+	phybak_num = ARRAY_SIZE(phybak);
+
+	debug("%s: Total PHY backup %d registers\n", __func__,
+	      (int)phybak_num);
+
+	if (proc == STORE) {
+		debug("%s: Storing PHY bak calibration to OCRAM ...\n",
+		      __func__);
+		/* Creating header */
+		/* Write PHY magic number */
+		cal->header.header_magic = SOC64_HANDOFF_DDR_PHY_MAGIC;
+		cal->header.data_len = phybak_num * sizeof(*data);
+	} else if (proc == LOADING) {
+		debug("%s: Loading bak calibration to PHY from OCRAM ...\n",
+		      __func__);
+	}
+
+	data = &cal->data;
+	while (phybak_num) {
+		phy_ocram(phy_base, *phybak_p, data, proc);
+		phybak_p++;
+		phybak_num--;
+		data++;
+		schedule();
+	};
+
+	if (proc == STORE) {
+		/* Creating header */
+		/* Generate HASH384 from the DDR config */
+		sha384_csum_wd((u8 *)DDR_HANDOFF_IMG_ADDR,
+			       DDR_HANDOFF_IMG_LEN,
+			       cal->header.ddrconfig_hash,
+			       CHUNKSZ_PER_WD_RESET);
+
+		if (SOC64_HANDOFF_BASE < ((uintptr_t)(&cal->data) +
+		    cal->header.data_len)) {
+			debug("%s: Backup cal data overflow HPS handoff\n",
+			      __func__);
+			return -ENOEXEC;
+		}
+
+		crc32_wd_buf((u8 *)&cal->data, cal->header.data_len,
+			     (u8 *)&cal->header.caldata_crc32,
+			     CHUNKSZ_PER_WD_RESET);
+	}
+
+	/* Isolate the APB access from internal CSRs */
+	setbits_le16(phy_base + DDR_PHY_APBONLY0_OFFSET,
+		     DDR_PHY_MICROCONTMUXSEL);
+
+	return 0;
+}
+
+static bool is_ddrconfig_hash_match(const void *buffer)
 {
 	int ret;
+	u8 hash[SHA384_SUM_LEN];
+
+	/* Magic symbol in first 4 bytes of header */
+	struct cal_header_t *header = (struct cal_header_t *)buffer;
+
+	/* Generate HASH384 from the image */
+	sha384_csum_wd((u8 *)DDR_HANDOFF_IMG_ADDR, DDR_HANDOFF_IMG_LEN,
+		       hash, CHUNKSZ_PER_WD_RESET);
+
+	ret = memcmp((void *)hash, (const void *)header->ddrconfig_hash,
+		     SHA384_SUM_LEN);
+	if (ret) {
+		debug("%s: DDR config hash mismatch\n", __func__);
+		return false;
+	}
+
+	return true;
+}
+
+static ofnode get_ddr_ofnode(ofnode from)
+{
+	return ofnode_by_compatible(from, "intel,sdr-ctl-n5x");
+}
+
+static const char *get_ddrcal_ddr_offset(void)
+{
+	const char *ddr_offset = NULL;
+
+	ofnode ddr_node = get_ddr_ofnode(ofnode_null());
+
+	if (ofnode_valid(ddr_node))
+		ddr_offset = ofnode_read_string(ddr_node,
+						"intel,ddrcal-ddr-offset");
+
+	return ddr_offset;
+}
+
+static const char *get_ddrcal_qspi_offset(void)
+{
+	const char *qspi_offset = NULL;
+
+	ofnode ddr_node = get_ddr_ofnode(ofnode_null());
+
+	if (ofnode_valid(ddr_node))
+		qspi_offset = ofnode_read_string(ddr_node,
+						 "intel,ddrcal-qspi-offset");
+
+	return qspi_offset;
+}
+
+static bool is_cal_bak_data_valid(void)
+{
+	int ret, size;
+	struct udevice *dev;
+	ofnode node;
+	const fdt32_t *phandle_p;
+	u32 phandle, crc32;
+	const char *qspi_offset = get_ddrcal_qspi_offset();
+	struct bac_cal_data_t *cal = (struct bac_cal_data_t *)((uintptr_t)
+					SOC64_OCRAM_PHY_BACKUP_BASE);
+
+	node = get_ddr_ofnode(ofnode_null());
+
+	if (ofnode_valid(node)) {
+		phandle_p = ofnode_get_property(node, "firmware-loader",
+						&size);
+		if (!phandle_p) {
+			node = ofnode_path("/chosen");
+			if (!ofnode_valid(node)) {
+				debug("%s: /chosen node was not found.\n",
+				      __func__);
+				return false;
+			}
+
+			phandle_p = ofnode_get_property(node,
+							"firmware-loader",
+							&size);
+			if (!phandle_p) {
+				debug("%s: firmware-loader property ",
+				      __func__);
+				debug("was not found.\n");
+				return false;
+			}
+		}
+	} else {
+		debug("%s: DDR node was not found.\n", __func__);
+		return false;
+	}
+
+	phandle = fdt32_to_cpu(*phandle_p);
+	ret = uclass_get_device_by_phandle_id(UCLASS_FS_FIRMWARE_LOADER,
+					      phandle, &dev);
+	if (ret)
+		return false;
+
+	/* Load DDR bak cal header into OCRAM buffer */
+	ret = request_firmware_into_buf(dev,
+					qspi_offset,
+					(void *)SOC64_OCRAM_PHY_BACKUP_BASE,
+					sizeof(struct cal_header_t), 0);
+	if (ret < 0) {
+		debug("%s: Failed to read bak cal header from flash.\n",
+		      __func__);
+		return false;
+	}
+
+	if (cal->header.header_magic != SOC64_HANDOFF_DDR_PHY_MAGIC) {
+		debug("%s: No magic found in cal backup header\n", __func__);
+		return false;
+	}
+
+	if (SOC64_HANDOFF_BASE < (SOC64_OCRAM_PHY_BACKUP_BASE +
+	    cal->header.data_len + sizeof(struct cal_header_t))) {
+		debug("%s: Backup cal data overflow HPS handoff\n", __func__);
+		return false;
+	}
+
+	/* Load header + DDR bak cal into OCRAM buffer */
+	ret = request_firmware_into_buf(dev,
+					qspi_offset,
+					(void *)SOC64_OCRAM_PHY_BACKUP_BASE,
+					cal->header.data_len +
+					sizeof(struct cal_header_t),
+					0);
+	if (ret < 0) {
+		debug("FPGA: Failed to read DDR bak cal data from flash.\n");
+		return false;
+	}
+
+	if (SOC64_HANDOFF_BASE < ((uintptr_t)(&cal->data) +
+	    cal->header.data_len)) {
+		debug("%s: Backup cal data overflow HPS handoff\n", __func__);
+		return false;
+	}
+
+	crc32_wd_buf((u8 *)&cal->data, cal->header.data_len,
+		     (u8 *)&crc32, CHUNKSZ_PER_WD_RESET);
+	debug("%s: crc32 %x for bak calibration data from QSPI\n", __func__,
+	      crc32);
+	if (crc32 != cal->header.caldata_crc32) {
+		debug("%s: CRC32 mismatch for calibration backup data\n",
+		      __func__);
+		return false;
+	}
+
+	if (!is_ddrconfig_hash_match((const void *)
+		SOC64_OCRAM_PHY_BACKUP_BASE)) {
+		debug("%s: HASH mismatch for DDR config data\n", __func__);
+		return false;
+	}
+
+	return true;
+}
+
+static int init_phy(struct ddr_handoff *ddr_handoff_info,
+		    bool *need_calibrate)
+{
+	u32 reg = readl(socfpga_get_sysmgr_addr() +
+			SYSMGR_SOC64_BOOT_SCRATCH_COLD0);
+	int ret;
 
 	printf("Initializing DDR PHY ...\n");
 
@@ -951,6 +1595,35 @@ static int init_phy(struct ddr_handoff *ddr_handoff_info)
 			ddr_handoff_info->phy_handoff_length,
 			ddr_handoff_info->phy_base);
 
+	if (is_ddr_calibration_skipped(reg)) {
+		if (is_cal_bak_data_valid())
+			*need_calibrate = false;
+		else
+			*need_calibrate = true;
+	}
+
+	debug("%s: Need calibrate %d\n", __func__, *need_calibrate);
+
+	if (*need_calibrate) {
+		/* Execute PHY configuration handoff */
+		handoff_process(ddr_handoff_info, ddr_handoff_info->phy_handoff_base,
+				ddr_handoff_info->phy_handoff_length,
+				ddr_handoff_info->phy_base);
+	} else {
+		ret = cal_data_ocram(ddr_handoff_info->phy_base,
+				     SOC64_OCRAM_PHY_BACKUP_BASE, LOADING);
+
+		if (ret)
+			return ret;
+
+	       /*
+		* Invalidate the section used for processing the PHY
+		* backup calibration data
+		*/
+		writel(SOC64_CRAM_PHY_BACKUP_SKIP_MAGIC,
+		       SOC64_OCRAM_PHY_BACKUP_BASE);
+	}
+
 	printf("DDR PHY configuration is completed\n");
 
 	return 0;
@@ -1161,6 +1834,14 @@ int populate_ddr_handoff(struct ddr_handoff *handoff)
 			debug("user setting data\n");
 			return -ENOEXEC;
 		}
+
+		/* Checking DDR handoff is overflow? */
+		if (SOC64_OCRAM_PHY_BACKUP_BASE <=
+		    (handoff->phy_engine_handoff_base +
+		    handoff->phy_engine_total_length)) {
+			printf("%s: DDR handoff is overflow\n ", __func__);
+			return -ENOEXEC;
+		}
 	} else {
 		debug("%s: Wrong format for DDR handoff, expect PHY",
 		      __func__);
@@ -1334,7 +2015,8 @@ static int ddr_trigger_sdram_init(phys_addr_t umctl2_base,
 }
 
 static int ddr_post_handoff_config(phys_addr_t umctl2_base,
-				   enum ddr_type umctl2_type)
+				   enum ddr_type umctl2_type,
+				   bool *need_calibrate)
 {
 	int ret = 0;
 	u32 value;
@@ -1364,11 +2046,13 @@ static int ddr_post_handoff_config(phys_addr_t umctl2_base,
 
 	/* Checking ECC is enabled? */
 	value = readl(umctl2_base + DDR4_ECCCFG0_OFFSET) & DDR4_ECC_MODE;
-	if (value) {
+	if (value)
 		printf("ECC is enabled\n");
+
+	if (value && *need_calibrate) {
 		ret = scrubber_ddr_config(umctl2_base, umctl2_type);
 		if (ret)
-			printf("Failed to enable ECC\n");
+			printf("Failed to enable scrubber\n");
 	}
 
 	return ret;
@@ -2064,40 +2748,23 @@ static int trigger_sdram_init(struct ddr_handoff *handoff)
 	return ret;
 }
 
-static int ddr_post_config(struct ddr_handoff *handoff)
+static int ddr_post_config(struct ddr_handoff *handoff, bool *need_calibrate)
 {
 	int ret;
 
-	ret = ddr_post_handoff_config(handoff->cntlr_base,
-				      handoff->cntlr_t);
+	ret = ddr_post_handoff_config(handoff->cntlr_base, handoff->cntlr_t,
+				      need_calibrate);
 	if (ret)
 		return ret;
 
 	if (handoff->cntlr2_t == DDRTYPE_LPDDR4_1)
 		ret = ddr_post_handoff_config(handoff->cntlr2_base,
-					      handoff->cntlr2_t);
+					      handoff->cntlr2_t,
+					      need_calibrate);
 
 	return ret;
 }
 
-static bool is_ddr_retention_enabled(u32 boot_scratch_cold0_reg)
-{
-	return boot_scratch_cold0_reg &
-	       ALT_SYSMGR_SCRATCH_REG_0_DDR_RETENTION_MASK;
-}
-
-static bool is_ddr_bitstream_sha_matching(u32 boot_scratch_cold0_reg)
-{
-	return boot_scratch_cold0_reg & ALT_SYSMGR_SCRATCH_REG_0_DDR_SHA_MASK;
-}
-
-static enum reset_type get_reset_type(u32 boot_scratch_cold0_reg)
-{
-	return (boot_scratch_cold0_reg &
-		ALT_SYSMGR_SCRATCH_REG_0_DDR_RESET_TYPE_MASK) >>
-		ALT_SYSMGR_SCRATCH_REG_0_DDR_RESET_TYPE_SHIFT;
-}
-
 void reset_type_debug_print(u32 boot_scratch_cold0_reg)
 {
 	switch (get_reset_type(boot_scratch_cold0_reg)) {
@@ -2115,63 +2782,44 @@ void reset_type_debug_print(u32 boot_scratch_cold0_reg)
 	}
 }
 
-bool is_ddr_init(void)
-{
-	u32 reg = readl(socfpga_get_sysmgr_addr() +
-			SYSMGR_SOC64_BOOT_SCRATCH_COLD0);
-
-	reset_type_debug_print(reg);
-
-	if (get_reset_type(reg) == POR_RESET) {
-		debug("%s: DDR init is required\n", __func__);
-		return true;
-	}
-
-	if (get_reset_type(reg) == WARM_RESET) {
-		debug("%s: DDR init is skipped\n", __func__);
-		return false;
-	}
-
-	if (get_reset_type(reg) == COLD_RESET) {
-		if (is_ddr_retention_enabled(reg) &&
-		    is_ddr_bitstream_sha_matching(reg)) {
-			debug("%s: DDR retention bit is set\n", __func__);
-			debug("%s: Matching in DDR bistream\n", __func__);
-			debug("%s: DDR init is skipped\n", __func__);
-			return false;
-		}
-	}
-
-	debug("%s: DDR init is required\n", __func__);
-	return true;
-}
-
 int sdram_mmr_init_full(struct udevice *dev)
 {
 	u32 user_backup[2], user_backup_2nd[2];
+	u32 reg = readl(socfpga_get_sysmgr_addr() +
+			SYSMGR_SOC64_BOOT_SCRATCH_COLD0);
 	int ret;
+	bool need_calibrate = true;
+	ulong ddr_offset;
+	char *endptr;
+	const char *offset = get_ddrcal_ddr_offset();
 	struct bd_info bd;
 	struct ddr_handoff ddr_handoff_info;
 	struct altera_sdram_priv *priv = dev_get_priv(dev);
 
 	printf("Checking SDRAM configuration in progress ...\n");
 	ret = populate_ddr_handoff(&ddr_handoff_info);
-		if (ret) {
-			debug("%s: Failed to populate DDR handoff\n",
-			      __func__);
-			return ret;
-		}
+	if (ret) {
+		debug("%s: Failed to populate DDR handoff\n",
+		      __func__);
+		return ret;
+	}
 
 	/* Set the MPFE NoC mux to correct DDR controller type */
 	use_ddr4(ddr_handoff_info.cntlr_t);
 
-	if (is_ddr_init()) {
+	/*
+	 * Invalidate the section used for processing the PHY backup
+	 * calibration data
+	 */
+	writel(SOC64_CRAM_PHY_BACKUP_SKIP_MAGIC, SOC64_OCRAM_PHY_BACKUP_BASE);
+
+	if (!is_ddr_init_skipped(reg)) {
 		printf("SDRAM init in progress ...\n");
 
 		/*
-		 * Polling reset complete, must be high to ensure DDR subsystem
-		 * in complete reset state before init DDR clock and DDR
-		 * controller
+		 * Polling reset complete, must be high to ensure DDR
+		 * subsystem in complete reset state before init DDR clock
+		 * and DDR controller
 		 */
 		ret = wait_for_bit_le32((const void *)((uintptr_t)(readl
 					(ddr_handoff_info.mem_reset_base) +
@@ -2206,7 +2854,7 @@ int sdram_mmr_init_full(struct udevice *dev)
 		printf("DDR controller configuration is completed\n");
 
 		/* Initialize DDR PHY */
-		ret = init_phy(&ddr_handoff_info);
+		ret = init_phy(&ddr_handoff_info, &need_calibrate);
 		if (ret) {
 			debug("%s: Failed to inilialize DDR PHY\n", __func__);
 			return ret;
@@ -2214,21 +2862,46 @@ int sdram_mmr_init_full(struct udevice *dev)
 
 		enable_phy_clk_for_csr_access(&ddr_handoff_info, true);
 
-		ret = start_ddr_calibration(&ddr_handoff_info);
-		if (ret) {
-			debug("%s: Failed to calibrate DDR\n", __func__);
-			return ret;
-		}
+		if (need_calibrate) {
+			ret = start_ddr_calibration(&ddr_handoff_info);
+			if (ret) {
+				debug("%s: Failed to calibrate DDR\n",
+				      __func__);
+				return ret;
+			}
 
-		enable_phy_clk_for_csr_access(&ddr_handoff_info, false);
+			/* DDR freq set to support DDR4-3200 */
+			phy_init_engine(&ddr_handoff_info);
+
+			/*
+			 * Backup calibration data to OCRAM first, these data
+			 * might be permanant stored to flash in later
+			 */
+			if (is_ddr_retention_enabled(reg)) {
+				ret = cal_data_ocram(ddr_handoff_info.phy_base,
+						     SOC64_OCRAM_PHY_BACKUP_BASE,
+						     STORE);
 
-		/* Reset ARC processor when no using for security purpose */
+				if (ret)
+					return ret;
+			}
+
+		} else {
+			/* Updating training result to DDR controller */
+			ret = update_training_result(&ddr_handoff_info);
+			if (ret)
+				return ret;
+		}
+
+		/*
+		 * Reset ARC processor when no using for security
+		 * purpose
+		 */
 		setbits_le16(ddr_handoff_info.phy_base +
 			     DDR_PHY_MICRORESET_OFFSET,
 			     DDR_PHY_MICRORESET_RESET);
 
-		/* DDR freq set to support DDR4-3200 */
-		phy_init_engine(&ddr_handoff_info);
+		enable_phy_clk_for_csr_access(&ddr_handoff_info, false);
 
 		ret = dfi_init(&ddr_handoff_info);
 		if (ret)
@@ -2242,7 +2915,7 @@ int sdram_mmr_init_full(struct udevice *dev)
 		if (ret)
 			return ret;
 
-		ret = ddr_post_config(&ddr_handoff_info);
+		ret = ddr_post_config(&ddr_handoff_info, &need_calibrate);
 		if (ret)
 			return ret;
 
@@ -2294,5 +2967,13 @@ int sdram_mmr_init_full(struct udevice *dev)
 
 	sdram_set_firewall(&bd);
 
+	if (is_ddr_retention_enabled(reg)) {
+		ddr_offset = simple_strtoul(offset, &endptr, 16);
+		if (!(offset == endptr || *endptr != '\0'))
+			memcpy((void *)ddr_offset,
+			       (const void *)SOC64_OCRAM_PHY_BACKUP_BASE,
+			       SZ_4K);
+	}
+
 	return 0;
 }
-- 
2.43.7

