Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44807105F7B1
	for <u-boot@archiver.kernel.org>; Fri, 13 Mar 2026 14:00:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2C3AF84329;
	Fri, 13 Mar 2026 14:59:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="wweYnwQn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D37A384337; Fri, 13 Mar 2026 14:59:38 +0100 (CET)
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azlp170100009.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c107::9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8776E8432A
 for <u-boot@lists.denx.de>; Fri, 13 Mar 2026 14:59:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=p-mantena@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FsxKlp/xNdQ3M3tbBGxANnD7hHMICS+YSmI8fXavItpC9rE90pxwWd4lRA5KDURxzerwJ7IneLGcFLwbKryFrHhqZppfnVpoAoX0kN6FlAhyHwQaCqDV/oHD+Fq8IBD9/KmwLkciU0Lnhi0P+D0lC48mX9AWA6+e3ADv9e+u3DTZFB02AinZ1xxQGGPLhfmHNmDbM3QXBgLIFBBW4FBu1d7PkMge/yVy7cq9H4mvqMP0gBTbB1+R4DoTFDgT7IrvTNaN4vwqeLJXCayLONOxHAHAevv8ZDXWoaY553DjLG1m1Ti2AGbfT9bNIO7NNAqQpd2wXESsTx+FrlTcxJTZ3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tDR+ipj7XA2p5SJMLkNrISfzdf4uPgvwuIJuvpWZVIM=;
 b=Dr5kqZXzuEuxv1n8zV9j1kX11aRmh1cso7F0iMqupGyqPQWl89xiVHmcsNpUI1wvlahhiYGT4qeqn3/WYByGTRnLM/VSrflFJLNsQSt7CutTO+fS/hNBif61N2OtmaHxxTdas0416Q9rAnxOUstF7fT52yT3Yr2GNkfdC1gumgC5Pupu6g5MV7VOYfU0Qq1Z727jTTRM2VDD4lUuIiINO7+v2na9eqQgcdE4Wo4l1hGdweEFH3q2PwWbi3+5E7tAf2YAM5vD8SZlw8p7xJnACju4lTUPOrK6vlT3FNSOo8vF78k0opin1MwamJveGtwmndZMseBVpvn/2Y9Pq1PgkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=konsulko.com smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tDR+ipj7XA2p5SJMLkNrISfzdf4uPgvwuIJuvpWZVIM=;
 b=wweYnwQnvJFcolriUWF0IAzP+OtbTSMff55LFoBe4HHz//r76CmLVW4GvI2sm/8v6YGwddFasplIKV0e4Att2rMRPdl9H5f5puLFbntyRBOM4IlnjWYrrBH2MW6EI8QTst1ooiwnRz+I040lrQp4Ki3COTEA2kWgtORtPgHVfeQ=
Received: from CH2PR20CA0007.namprd20.prod.outlook.com (2603:10b6:610:58::17)
 by PH7PR10MB5745.namprd10.prod.outlook.com (2603:10b6:510:125::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.12; Fri, 13 Mar
 2026 13:59:32 +0000
Received: from CH2PEPF00000140.namprd02.prod.outlook.com
 (2603:10b6:610:58:cafe::17) by CH2PR20CA0007.outlook.office365.com
 (2603:10b6:610:58::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.17 via Frontend Transport; Fri,
 13 Mar 2026 13:59:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 CH2PEPF00000140.mail.protection.outlook.com (10.167.244.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9700.17 via Frontend Transport; Fri, 13 Mar 2026 13:59:30 +0000
Received: from DLEE214.ent.ti.com (157.170.170.117) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 13 Mar
 2026 08:59:28 -0500
Received: from DLEE212.ent.ti.com (157.170.170.114) by DLEE214.ent.ti.com
 (157.170.170.117) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 13 Mar
 2026 08:59:28 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE212.ent.ti.com
 (157.170.170.114) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Fri, 13 Mar 2026 08:59:28 -0500
Received: from prasanth-server.dhcp.ti.com (prasanth-server.dhcp.ti.com
 [10.24.53.104])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 62DDx6Je638000;
 Fri, 13 Mar 2026 08:59:26 -0500
From: Prasanth Babu Mantena <p-mantena@ti.com>
To: <u-boot@lists.denx.de>, <trini@konsulko.com>, <n-francis@ti.com>
CC: <u-kumar1@ti.com>, <vigneshr@ti.com>, <a-kumar2@ti.com>
Subject: [RFC PATCH 08/19] board: ti: j721e: Add exit retention for k3-ddrss
 (J7200)
Date: Fri, 13 Mar 2026 19:28:49 +0530
Message-ID: <20260313135900.3430264-9-p-mantena@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260313135900.3430264-1-p-mantena@ti.com>
References: <20260313135900.3430264-1-p-mantena@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000140:EE_|PH7PR10MB5745:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f996b3d-424e-4c00-3876-08de8108bf7b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700016|1800799024|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: ea80WKG4llLU+Xz5MQoE6Nclq6D8k+e8InnQGhWuwGnmVyur6X6phZMUDVQBU06t/Cw7IJ2FQgqE2T5Dhtja6qMafuXrJPl5VuIe26BmXAtaBRkzVnHO+9Qn9GY8Fehy9ogDP5RICCCNb41a1WztJD+HjWTYurmAB9ydRr9MXSg8xgQ+JsYK9BVVcSrfQCR2LxTYKQL5zBUO4JGS8PBlmlDTjHM6jdI3FuG2HinzRfh/kQtH0K5QuQgerjXdHnJLySR7h6RdprFTjkuWFASVhlpkI/xDtDmiQXKN3Mt83mfrKkU06xdcuo1nTtyfsyb9lyypYZlmbTXVJDRLtEbclwtp6vS2oh4/bZFF/+74dwPcfIqyh3EAL8D0yzjeKsQKY/tfaUrvhN6RdNIm41K43AQkdBmD0D73uQ3Po3RTNEUFJ+OlAx2Iu2LrQgMcAYz9KBKSJ9Ean5v9+ksA0AwaqeSkuCGfJAvHDmdYtIAVxoy/fkHK9h6id8zlNTnm9pe1XFsNSbme+m3Ti0Z8BKeojRCyGIAPaKDuXw/7yXzgncvCoPitrtsZmdKqCee6MKoB41I3aB8CSNicT8Ty3rrXoZ+QazUdcvfxam2a8lhR7CgnlIYJbSO2uNyVcGwPcscw/+z3rMol8N2yfiB0WBhOxjan5bdB1ChDGy69AsTCPFAG3HvtaySutQCatzMKR9Vgb4egpDgp0f7uRN+TU2kSrramVGI7FWEsXpPuqiBwRiuauMyp/sm7Q3kVkOb5BeIajeCYq+f8qL+3V6Ka4skGow==
X-Forefront-Antispam-Report: CIP:198.47.23.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet200.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700016)(1800799024)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 7lqOb7QcvXDu7vmiZ4xFstUBepylGlnxJAwKnMTIl6s2EAgKGRtdpy97IDrZksyQ8lL6J9ltvjBOrRdf9VG5nk1OexGI8BmZ4o3SgfW2zm9Y3v25emFggnsbKHVEMC/VMeIjj4hwpn22RLaOWDiWcUsjsv8YeM9mPfN4rL1hw7VDH6gVWwly611tOxOte8uRTJRBOyC//RcYMF247WMm/1FFgK9wbaKRUlGzDCYwPz5OL5320J2kraCrh24E4DGoBQlhb0DZ4FIfGAuj1A39pcAk5cK1v8dukYon/6hlsIM9iSmaAHrJg8bZ0XAuYfTaoA/rfYgMFu/EYryLrZ0AjHoz/gHnMXl288U/hkEcmtXQrECg3iDQJ67vYcW0jJUc/eKkKoQrbjRxCjThAyEBx9CWQJm+h0xWPuvIFhnSP/g+NPqntP+UdKNwD5rtFQoE
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2026 13:59:30.4513 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f996b3d-424e-4c00-3876-08de8108bf7b
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.194];
 Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF00000140.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB5745
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

From: Thomas Richard <thomas.richard@bootlin.com>

Add the board specific part of the exit retention sequence for k3-ddrss
Following the DDR resume sequence,
   - exit DDR from retention
   - de-assert the DDR_RET pin
   - restore DDR max frequency
   - exit DDR from low power

Signed-off-by: Thomas Richard <thomas.richard@bootlin.com>
Signed-off-by: Richard Genoud <richard.genoud@bootlin.com>
Signed-off-by: Prasanth Babu Mantena <p-mantena@ti.com>
---
 arch/arm/mach-k3/j721e/j721e_init.c | 56 +++++++++++++++++++++++++++++
 1 file changed, 56 insertions(+)

diff --git a/arch/arm/mach-k3/j721e/j721e_init.c b/arch/arm/mach-k3/j721e/j721e_init.c
index f325597a70b..220cb700ff7 100644
--- a/arch/arm/mach-k3/j721e/j721e_init.c
+++ b/arch/arm/mach-k3/j721e/j721e_init.c
@@ -23,6 +23,8 @@
 
 #include "../sysfw-loader.h"
 #include "../common.h"
+#include <power/pmic.h>
+#include <mach/k3-ddr.h>
 
 /* NAVSS North Bridge (NB) registers */
 #define NAVSS0_NBSS_NB0_CFG_MMRS		0x03802000
@@ -294,10 +296,50 @@ void do_dt_magic(void)
 }
 #endif
 
+#define GPIO_OUT_1 0x3D
+#define DDR_RET_VAL BIT(1)
+#define DDR_RET_CLK BIT(2)
+#define PMIC_NSLEEP_REG 0x86
+
+static void k3_deassert_DDR_RET(void)
+{
+	struct udevice *pmica;
+	struct udevice *pmicb;
+	int regval;
+	int ret;
+
+	ret = uclass_get_device_by_name(UCLASS_PMIC,
+					"pmic@48", &pmica);
+	if (ret) {
+		printf("Getting PMICA init failed: %d\n", ret);
+		return;
+	}
+
+	ret = uclass_get_device_by_name(UCLASS_PMIC,
+					"pmic@4c", &pmicb);
+	if (ret) {
+		printf("Getting PMICB init failed: %d\n", ret);
+		return;
+	}
+	/* Set DDR_RET Signal Low on PMIC B */
+	regval = pmic_reg_read(pmicb, GPIO_OUT_1) & ~DDR_RET_VAL;
+
+	pmic_reg_write(pmicb, GPIO_OUT_1, regval);
+
+	/* Now toggle the CLK of the latch for DDR ret */
+	pmic_reg_write(pmicb, GPIO_OUT_1, regval | DDR_RET_CLK);
+	pmic_reg_write(pmicb, GPIO_OUT_1, regval & ~(DDR_RET_CLK));
+	pmic_reg_write(pmicb, GPIO_OUT_1, regval | DDR_RET_CLK);
+	pmic_reg_write(pmicb, GPIO_OUT_1, regval & ~(DDR_RET_CLK));
+
+	pmic_reg_write(pmica, PMIC_NSLEEP_REG, 0x3);
+}
+
 void board_init_f(ulong dummy)
 {
 	int ret;
 #if defined(CONFIG_K3_J721E_DDRSS) || defined(CONFIG_K3_LOAD_SYSFW)
+	struct k3_ddrss_regs regs;
 	struct udevice *dev;
 #endif
 
@@ -414,6 +456,20 @@ void board_init_f(ulong dummy)
 	ret = uclass_get_device(UCLASS_RAM, 0, &dev);
 	if (ret)
 		panic("DRAM init failed: %d\n", ret);
+
+	if (board_is_resuming()) {
+		/*
+		 * The DDR resume sequence is:
+		 * - exit DDR from retention
+		 * - de-assert the DDR_RET pin
+		 * - restore DDR max frequency
+		 * - exit DDR from low power
+		 */
+		k3_ddrss_lpddr4_exit_retention(dev, &regs);
+		k3_deassert_DDR_RET();
+		k3_ddrss_lpddr4_change_freq(dev);
+		k3_ddrss_lpddr4_exit_low_power(dev, &regs);
+	}
 #endif
 	spl_enable_cache();
 
-- 
2.34.1

