Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4D09105F7A8
	for <u-boot@archiver.kernel.org>; Fri, 13 Mar 2026 14:00:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8F8758420D;
	Fri, 13 Mar 2026 14:59:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="IwMeT3W6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 975748431C; Fri, 13 Mar 2026 14:59:31 +0100 (CET)
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazlp170100005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c111::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0D7A984314
 for <u-boot@lists.denx.de>; Fri, 13 Mar 2026 14:59:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=p-mantena@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bXuVYehvCp+pvK2rPEeQT4f0t0wr5tc7/rn/nq87FK37oIDetx4d7vIiEwjNVHH935mzckl9rHpr3/Plq0OcZyLiMN3w2jEFRUXrx1yJP5ZFewwlXtL79K5iykob1tYiLFo5Cs/fD6AxE5lBZhgr4T9LatRlP5FHpZu9hmKy+wCkpPc+CWoX1i99/eDxkN+AYL3Ks37uP2lrZ1UKr7AED2PAh40EnrWR3gAYp0Wt1tvMX/UMHMdKwOfHXPw/Cf73ioLuiEoVnOYKyf6aK1kCvZCDAk7nTfQnz5HnTrq4qF5kXodXZlJDVXL7WopegVU+Cwvd5vrJE3J7ov50mpmg5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fdCn70Hsye03TjXi8CwCuhxiFMoiOJH+NCLO2qbn5q0=;
 b=PVzhUZKw50nO/2mgpDHmvRNI0nJVmbwtGzNr/MXrHRMvvt8X2JLHirXNpehfi8x2E+bss9q1aPpdJxhaAzyt0UPUxSH+d5O8hEC4DF64sD2gYkRSBeP5Pi6n7M9n6uBzvUdWKjT/69S+sfXnGVQtcOwTTF8WLTOnYdOMfmJbzLxBPdQ5LFbJaWufuUXr/luPocS4pPHN+s+UZh1sHl3CiGSV2nux/OhcOncH50RlD98NqrUq/S/2Aay0wfupRRj3Q7b8oZIELAtcHb5JBkZAFMm+Jq4zyQOtRjIRnku6Rr836CfVL9BCtyU+xmnvUQUOERHyhPonHdYX29cDpX/DUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=konsulko.com smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fdCn70Hsye03TjXi8CwCuhxiFMoiOJH+NCLO2qbn5q0=;
 b=IwMeT3W6Gt6Yc6Tntdr600hDnjC4IY9EwytgoWgWZUXevLEvMBfGdKkancJXnAxiMkysxUhRZrCqcgiv2L+0XgoqHE3SF+i8Lyde7n3hPleMHnnUegPUUnnmnDnTDl+Ybe7fpMNMDuExoKZmNvFH4j+Rm1mozWjiW5vQaqx6xQQ=
Received: from CH0PR03CA0306.namprd03.prod.outlook.com (2603:10b6:610:118::35)
 by SA1PR10MB997653.namprd10.prod.outlook.com (2603:10b6:806:4b3::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.17; Fri, 13 Mar
 2026 13:59:26 +0000
Received: from CH2PEPF0000013D.namprd02.prod.outlook.com
 (2603:10b6:610:118:cafe::d9) by CH0PR03CA0306.outlook.office365.com
 (2603:10b6:610:118::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.16 via Frontend Transport; Fri,
 13 Mar 2026 13:59:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 CH2PEPF0000013D.mail.protection.outlook.com (10.167.244.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9700.17 via Frontend Transport; Fri, 13 Mar 2026 13:59:26 +0000
Received: from DLEE205.ent.ti.com (157.170.170.85) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 13 Mar
 2026 08:59:25 -0500
Received: from DLEE208.ent.ti.com (157.170.170.97) by DLEE205.ent.ti.com
 (157.170.170.85) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 13 Mar
 2026 08:59:25 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE208.ent.ti.com
 (157.170.170.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Fri, 13 Mar 2026 08:59:25 -0500
Received: from prasanth-server.dhcp.ti.com (prasanth-server.dhcp.ti.com
 [10.24.53.104])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 62DDx6Jd638000;
 Fri, 13 Mar 2026 08:59:23 -0500
From: Prasanth Babu Mantena <p-mantena@ti.com>
To: <u-boot@lists.denx.de>, <trini@konsulko.com>, <n-francis@ti.com>
CC: <u-kumar1@ti.com>, <vigneshr@ti.com>, <a-kumar2@ti.com>
Subject: [RFC PATCH 07/19] board: ti: j784s4: Add resume detection for J784s4
Date: Fri, 13 Mar 2026 19:28:48 +0530
Message-ID: <20260313135900.3430264-8-p-mantena@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260313135900.3430264-1-p-mantena@ti.com>
References: <20260313135900.3430264-1-p-mantena@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000013D:EE_|SA1PR10MB997653:EE_
X-MS-Office365-Filtering-Correlation-Id: 114be4af-230a-4ea7-b7eb-08de8108bd04
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700016|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: lbPwwTkZymvnjXwlOERb8RmaScR/s+9oOrYwyUTsTKmvGn1i11ZEX9k0Qe/l9wNg1KOxH1DUam9NmJR55E/w0GQGG8Rx8AfDHR+YYErK6aliQBbb737QByOpZ5R/rmQ9YsobCcUB2cfe3WZ5v1fwYNIBuvsNC3Gv4G5DrKHIrNxzfUC0p/OELhbd2z+5vlaptHj+PGtJxuiDpv62DelRnDarpD9GLueSf2iYsuEtMAWTl+lGo3El6YO0zrKRq0E1zZafGO9YbitItcoVfzscrVoZshyO94u1V8BcXZYgLXOgDttD4uuXyCaLZD6ZgSj/RcJcdBdP/vTG5YAw0dHb4wV89M2lNQI/t4JxzLC+YxJoIEyApdgKFpYn4LLFjbH85dhGUNimN0kcycFVDMdGXuQPYb6tXQCxFfxeUMigSGUcpLJOP1frFLD4X47hVbbAajYBSB0DHalPdJTPsJtuohNS26CJh8zecTy54CZE1CRAoEgViGkTR/jP3o3ZaGLKhL/YPjJSI+C+vFXa1xtOWqQ8xq2L46ZT6zviLNueHoCxd6ipmAUiZnibZnMAOXxsw2hPAqgvTfla27MmSsmQIsxAUFrjKTNHaBBCmYwaDpE7FCmItBjCSMGTW0RgrBEN+oPhp55+ep+tVcuHo8pOJlcTMSkDkur9JeIphMMmuqi1GsYm2jXGjAKcrIdK69Wm8XHCY9fIKFRBdTVTRTmpp8yggbE5OY9yZnBS/moLx9hiryw748yTBMgd1OqPsHcNw1RbTtXf9BgRChGgeqsrZg==
X-Forefront-Antispam-Report: CIP:198.47.23.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet200.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700016)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: EyYysu6oJbp3TKKxJJvmaNziHgPf/Mq/qWhXiSDcDIFdEiKOzM+jHcV0QilnO2A0NsHuvCmDlELruFmKCqT8JqZacli71OMohRRpSBzBC/o9+y+52Zr7Ctp1SPKCjxX82QmnW5Ycgd94nv0TY8/k+l7ptvD+abmiCKZclUcWk3rfsW/idRy9MQ8gYm45iBYb43XWEgzw74zHoSjz755l66We/3W6kuHl8f3z4JaM+cBK5DMOrS445DyYIV3gXQsoMV/4MBbXhX42hI/sMexXTWW/KuV3bXacLzx0pJmnbxef53Cn2bg6qZoRybI8GzPZ9QAAygI/CsROWu71A7QdkknbQd8KYukXVEM0N1gyh1DDY0PWXw72jwTYC3eY7N++PwQgzk/n4YurBeQFyHD6/xecSmY/kKNzBTSHp0UNAaadB0i5ShrukmNFrgb5Z7Dz
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2026 13:59:26.3239 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 114be4af-230a-4ea7-b7eb-08de8108bd04
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.194];
 Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000013D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB997653
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

Add the capability to detect resume by implementing board_is_resuming(void).
To detect the resume, SPL searches a magic value (0xBA) in a register
of PMIC.
This value is set by DM-Firmware during the suspend sequence.

NB: As this is called in board_init_f(), there's no BSS, so we can't
use global/static variables.

Signed-off-by: Thomas Richard <thomas.richard@bootlin.com>
Co-developed-by: Gregory CLEMENT <gregory.clement@bootlin.com>
Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>
Signed-off-by: Prasanth Babu Mantena <p-mantena@ti.com>
---
 arch/arm/mach-k3/j784s4/j784s4_init.c |  2 ++
 board/ti/j784s4/evm.c                 | 41 +++++++++++++++++++++++++++
 2 files changed, 43 insertions(+)

diff --git a/arch/arm/mach-k3/j784s4/j784s4_init.c b/arch/arm/mach-k3/j784s4/j784s4_init.c
index 53f152ccd9c..161c68e474f 100644
--- a/arch/arm/mach-k3/j784s4/j784s4_init.c
+++ b/arch/arm/mach-k3/j784s4/j784s4_init.c
@@ -294,6 +294,8 @@ void board_init_f(ulong dummy)
 {
 	struct udevice *dev;
 	int ret;
+	/* init resume flag */
+	gd_set_k3_resuming(-1);
 
 	k3_spl_init();
 
diff --git a/board/ti/j784s4/evm.c b/board/ti/j784s4/evm.c
index cabb3017ee1..42fb819c553 100644
--- a/board/ti/j784s4/evm.c
+++ b/board/ti/j784s4/evm.c
@@ -12,6 +12,7 @@
 #include <init.h>
 #include <spl.h>
 #include <asm/arch/k3-ddr.h>
+#include <power/pmic.h>
 #include "../common/fdt_ops.h"
 
 DECLARE_GLOBAL_DATA_PTR;
@@ -61,6 +62,46 @@ int board_late_init(void)
 }
 #endif
 
+#if (IS_ENABLED(CONFIG_SPL_BUILD) && IS_ENABLED(CONFIG_TARGET_J784S4_R5_EVM))
+
+#define SCRATCH_PAD_REG_3 0xCB
+
+#define MAGIC_SUSPEND 0xBA
+
+/* in board_init_f(), there's no BSS, so we can't use global/static variables */
+int board_is_resuming(void)
+{
+	struct udevice *pmic;
+	int err;
+
+	if (gd_k3_resuming() >= 0)
+		goto end;
+
+	err = uclass_get_device_by_name(UCLASS_PMIC,
+					"pmic@48", &pmic);
+	if (err) {
+		printf("Getting PMIC init failed: %d\n", err);
+		goto end;
+	}
+	debug("%s: PMIC is detected (%s)\n", __func__, pmic->name);
+
+	if (pmic_reg_read(pmic, SCRATCH_PAD_REG_3) == MAGIC_SUSPEND) {
+		debug("%s: board is resuming\n", __func__);
+		gd_set_k3_resuming(1);
+
+		/* clean magic suspend */
+		if (pmic_reg_write(pmic, SCRATCH_PAD_REG_3, 0))
+			printf("Failed to clean magic value for suspend detection in PMIC\n");
+	} else {
+		debug("%s: board is booting (no resume detected)\n", __func__);
+		gd_set_k3_resuming(0);
+	}
+end:
+	return gd_k3_resuming();
+}
+
+#endif /* CONFIG_SPL_BUILD && CONFIG_TARGET_J784s4_R5_EVM */
+
 void spl_board_init(void)
 {
 	struct udevice *dev;
-- 
2.34.1

