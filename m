Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6B12105F7AE
	for <u-boot@archiver.kernel.org>; Fri, 13 Mar 2026 14:01:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 61E518432A;
	Fri, 13 Mar 2026 14:59:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="Xaf3VLiu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 14A7B84366; Fri, 13 Mar 2026 14:59:44 +0100 (CET)
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azlp170120001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c107::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B7A6384307
 for <u-boot@lists.denx.de>; Fri, 13 Mar 2026 14:59:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=p-mantena@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jkqS0ymr4AlAlVIIMc3SZ9bT7rzAOrsdClpyLIjFo+Ivd0itK223MrtWC0pfC35hBKz0EkLMA6aMFkj51nGCFUfdLfIZM/y3i3g9dkj4XKqDiFELkoqAL/r2tZrjBfroJUKm7kyIyqhCseuDPtDtzkX8b8hj327WhmN+IukJi7wVz+HLVpxzpfyZSTAuDgoy3v/+97gUGyiULyiRBmbyVkQo/nzlPLXcwaI1KoqN0a+QNrFGdmrFHbdvH8ifVCGYJ5YO1fwPc7eHLn6rhC8FJXqvYJzA1FUiGexySYMvt68Brji0FmxHpBprCQoWhyIuYZerLCfjA5pXkvCNFsUASQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zgrGF94jlXHV8dtGmmf6CZmQxsYQQGG07r2Ntb1gBKk=;
 b=Yb2RdOv1vRhAhOGuW1IF7hV8pwWxsT2ZGgKAcydRphrCL4fhpF8qUP622eqK6unamQjwAHZ3f37AyM83BNyN0WqWIxpAM7j6icXOxP8Y9bgjSpKqkRRTu269YiRQdozyCURP0thSME0hE20ZjyMx8e/zXN/SHc2/RBHwnwS83XbxEPzwBbWZhfRot1fxZddJLpIXVaxVvxUyBzuhPCXNHvSA5E/zHsoaitR+g3gs6G6zimscWwe7gmDDOU521ZQ65uAFgaQRZUaT/VYI130w/PmKMbnrnTp3xXPK/VTiz3efx91G+rdWcXLx/dUJoiZrvnN81TbopAMxvNApAesm1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=konsulko.com smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zgrGF94jlXHV8dtGmmf6CZmQxsYQQGG07r2Ntb1gBKk=;
 b=Xaf3VLiudy0Oyz9lQSO/IFd2Fx7RDJdUiiQH8Myy3/BI1ctX5PVw0l6EaNUGHaxtm+dSKg04ueYkS1hCaUIOP9uNrPWt7AbNXX8w6eZOaRE8I3jY6oWPJXr88lgl8NYxqrSUc/CaLTO/r0ERRh0skyN+g0y4BJQg5YQrOJsACjA=
Received: from BY3PR10CA0026.namprd10.prod.outlook.com (2603:10b6:a03:255::31)
 by CO1PR10MB4658.namprd10.prod.outlook.com (2603:10b6:303:91::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.16; Fri, 13 Mar
 2026 13:59:38 +0000
Received: from SJ5PEPF000001EE.namprd05.prod.outlook.com
 (2603:10b6:a03:255:cafe::b9) by BY3PR10CA0026.outlook.office365.com
 (2603:10b6:a03:255::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.16 via Frontend Transport; Fri,
 13 Mar 2026 13:59:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 SJ5PEPF000001EE.mail.protection.outlook.com (10.167.242.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9700.17 via Frontend Transport; Fri, 13 Mar 2026 13:59:38 +0000
Received: from DLEE207.ent.ti.com (157.170.170.95) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 13 Mar
 2026 08:59:37 -0500
Received: from DLEE202.ent.ti.com (157.170.170.77) by DLEE207.ent.ti.com
 (157.170.170.95) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 13 Mar
 2026 08:59:37 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE202.ent.ti.com
 (157.170.170.77) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Fri, 13 Mar 2026 08:59:37 -0500
Received: from prasanth-server.dhcp.ti.com (prasanth-server.dhcp.ti.com
 [10.24.53.104])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 62DDx6Ji638000;
 Fri, 13 Mar 2026 08:59:35 -0500
From: Prasanth Babu Mantena <p-mantena@ti.com>
To: <u-boot@lists.denx.de>, <trini@konsulko.com>, <n-francis@ti.com>
CC: <u-kumar1@ti.com>, <vigneshr@ti.com>, <a-kumar2@ti.com>
Subject: [RFC PATCH 12/19] board: evm: Enable de-isolation of IOs at resume
 for j7200 and j784s4
Date: Fri, 13 Mar 2026 19:28:53 +0530
Message-ID: <20260313135900.3430264-13-p-mantena@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260313135900.3430264-1-p-mantena@ti.com>
References: <20260313135900.3430264-1-p-mantena@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001EE:EE_|CO1PR10MB4658:EE_
X-MS-Office365-Filtering-Correlation-Id: 31e7b09e-8f5d-49b7-8719-08de8108c40b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|1800799024|376014|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: sAxrw91mIBitj/fKhw0k3RmQ+V4F4ueFPzukzKP3cNMW7iTCa3gWqdp2PB0UZpYYFEOksE76FjrCEuRQVOX7ESucPreoPwd46a594+nEuqa5eyP14pukLzanZapsPkcL9cYLoQMcxB2rXsccnhwAsNr9G95NUkgOnNofBpcBkHmhZnII1Q7B9ZIxBE0cQHJjgA1QjdfqE7iKbeIrMFmhKO8wfgKi8s+Yp9yQXfWjlDVq5KxPbNepaQE/kkk5KPwTjp/v6TcCD6OIPbLFhiwKZAea00qdDjqZ5orsJsl58s702mSrcLuA/plDLUcJg4cxpbEynhnYIc0jQH2WzBS2JnrudXB/VRi9+w6hGxDXcO7DhW+HYJ3irgB8w+LzL1eFsJP+a2tcgSqwCeuLClhisli4n0ADZk1O+bGZwtsUFC6jj0jtdgqOKJMhRsoaEOdfTZHv25cLDyYc39YaZPCLZXLiGKApoQq8FaS6kuKuOszfUwyrzxFd7uykHQNI4umSluBgR82MFp/9uPFYpefA4zOpi0lKootAmoHb9ADy0HNulpu42hKhRZzZDwOnRkEqt3cVWsC79NZWlkxaIinPCRoqLDbTvrb6M0P4iwaDCWv4Hm0DNqCzXOnQ8HqxFIBsNslrGIgavo4Z+va4ZSV8LFqGMsOiwMYlaaK2Zn9ihg8ErO/01jYJ8lwMhrzXLtH21mzzPAKwjHlvHvZdk7DsXIeejngqWuDPJULZY8B2JSJGQe8hB/fqNniIcJOfAgAzjtvBbJaKVF4XgVOUxZGeMQ==
X-Forefront-Antispam-Report: CIP:198.47.23.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet201.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(1800799024)(376014)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Djg7Wqf1v2/OwSexsX85EGjV4xch0AWIUm7gtLYUYASsj3hEwvq56IBvcquTKLGc31GYzp5Q6/Wu/Y0sMjnT+fhIRs61Ffa6ylmlXd9skHtmJRGKajSTRzUqY3F4klU7dJ9C4UBOYh62HY9bbjAvndXjfP+IOiP+SdQ+5WTv50LylmH7QPbEMC2qZ8Ivv/CYwOv6n/k2XFlwQktApOFJTm72IhbIYN+KdWTLlSFUP/2SoZFa6Po5JGYuCsf+qmG9wsqSAnKe7FklhQVWSvXeRk9gNpo6z8zkNpJzD+fOIBMheTShjj9N/o5pnfe0+GYuQ8k3J9ENqugj5p4mkPLhW4OgudqCA8SEvwgdkyEX5+6689wgWbVSDss+xLCRw3zcbBczQPS8v+JmLzpSaLp67TzeaaVbMUpnT7jbWRKQR5PcDV5MrK2mlbwEzzao8U7t
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2026 13:59:38.0683 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 31e7b09e-8f5d-49b7-8719-08de8108c40b
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.195];
 Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001EE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4658
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

From: Abhash Kumar Jha <a-kumar2@ti.com>

When resuming from IO_ONLY_PLUS_DDR low power mode, the IOs are
isolated. Remove that isolation in resume sequence.

On j7200, The canuart IOs are isolated whereas on j784s4, the
mcu_general IOs are isolated.

Signed-off-by: Abhash Kumar Jha <a-kumar2@ti.com>
Signed-off-by: Prasanth Babu Mantena <p-mantena@ti.com>
---
 .../arm/mach-k3/include/mach/j721e_hardware.h | 11 +++++++
 .../mach-k3/include/mach/j784s4_hardware.h    | 10 +++++++
 board/ti/j721e/evm.c                          | 28 +++++++++++++++++
 board/ti/j784s4/evm.c                         | 30 +++++++++++++++++++
 4 files changed, 79 insertions(+)

diff --git a/arch/arm/mach-k3/include/mach/j721e_hardware.h b/arch/arm/mach-k3/include/mach/j721e_hardware.h
index 5bef309af0a..587dd10eb1e 100644
--- a/arch/arm/mach-k3/include/mach/j721e_hardware.h
+++ b/arch/arm/mach-k3/include/mach/j721e_hardware.h
@@ -15,6 +15,17 @@
 #define MCU_CTRL_MMR0_BASE				0x40f00000
 #define CTRL_MMR0_BASE					0x00100000
 
+#define PMCTRL_IO_1						(DMSC_PWRCTRL_BASE + 0x88)
+#define DMSC_PWRCTRL_BASE				0x44130000
+#define CANUART_WAKE_CTRL				0x18300
+#define CANUART_WAKE_STAT0				0x18308
+#define CANUART_WAKE_STAT1				0x1830C
+
+#define IO_ISO_MAGIC_VAL			0x55555554
+#define IO_ISO_STATUS				BIT(25)
+#define CANUART_WAKE_STAT1_CANUART_IO_MODE	BIT(0)
+#define DEISOLATION_TIMEOUT_MS			10
+
 #define CTRLMMR_MAIN_DEVSTAT				(CTRL_MMR0_BASE + 0x30)
 #define MAIN_DEVSTAT_BOOT_MODE_B_MASK		BIT(0)
 #define MAIN_DEVSTAT_BOOT_MODE_B_SHIFT		0
diff --git a/arch/arm/mach-k3/include/mach/j784s4_hardware.h b/arch/arm/mach-k3/include/mach/j784s4_hardware.h
index 29a894baed3..dd51473419d 100644
--- a/arch/arm/mach-k3/include/mach/j784s4_hardware.h
+++ b/arch/arm/mach-k3/include/mach/j784s4_hardware.h
@@ -15,6 +15,16 @@
 #define MCU_CTRL_MMR0_BASE				0x40f00000
 #define CTRL_MMR0_BASE					0x00100000
 
+#define PMCTRL_IO_0					0x14084
+#define MCU_GEN_WAKE_CTRL				0x18310
+#define MCU_GEN_WAKE_STAT0				0x18318
+#define MCU_GEN_WAKE_STAT1				0x1831C
+
+#define IO_ISO_MAGIC_VAL				0x55555554
+#define IO_ISO_STATUS					BIT(25)
+#define MCU_GEN_WAKE_STAT1_MCU_GEN_IO_MODE		BIT(0)
+#define DEISOLATION_TIMEOUT_MS				10
+
 #define CTRLMMR_MAIN_DEVSTAT				(CTRL_MMR0_BASE + 0x30)
 #define MAIN_DEVSTAT_BOOT_MODE_B_MASK			BIT(0)
 #define MAIN_DEVSTAT_BOOT_MODE_B_SHIFT			0
diff --git a/board/ti/j721e/evm.c b/board/ti/j721e/evm.c
index 20c77ff804f..368381c422a 100644
--- a/board/ti/j721e/evm.c
+++ b/board/ti/j721e/evm.c
@@ -18,6 +18,7 @@
 #include <dm.h>
 #include <asm/arch/k3-ddr.h>
 #include <power/pmic.h>
+#include <wait_bit.h>
 
 #include "../common/board_detect.h"
 #include "../common/fdt_ops.h"
@@ -475,16 +476,43 @@ err_free_gpio:
 #define SCRATCH_PAD_REG_3 0xCB
 
 #define MAGIC_SUSPEND 0xBA
+static void clear_isolation(void)
+{
+	int ret;
+	const void *wait_reg = (const void *)(WKUP_CTRL_MMR0_BASE + CANUART_WAKE_STAT1);
+
+	/* un-set the magic word for canuart IOs */
+	writel(IO_ISO_MAGIC_VAL, WKUP_CTRL_MMR0_BASE + CANUART_WAKE_CTRL);
+	writel((IO_ISO_MAGIC_VAL + 0x1), WKUP_CTRL_MMR0_BASE + CANUART_WAKE_CTRL);
+	writel(IO_ISO_MAGIC_VAL, WKUP_CTRL_MMR0_BASE + CANUART_WAKE_CTRL);
+
+	/* wait for CANUART_IO_MODE bit to be cleared */
+	ret = wait_for_bit_32(wait_reg,
+			      CANUART_WAKE_STAT1_CANUART_IO_MODE,
+			      false,
+			      DEISOLATION_TIMEOUT_MS,
+			      false);
+	if (ret < 0)
+		pr_err("Deisolation timeout");
+}
 
 int board_is_resuming(void)
 {
 	struct udevice *pmica;
 	struct udevice *pmicb;
+	u32 pmctrl_val = readl(PMCTRL_IO_1);
 	int ret;
 
 	if (gd_k3_resuming() >= 0)
 		goto end;
 
+	if ((pmctrl_val & IO_ISO_STATUS) == IO_ISO_STATUS) {
+		clear_isolation();
+		gd_set_k3_resuming(1);
+		debug("Resuming from IO_DDR mode\n");
+		return gd_k3_resuming();
+	}
+
 	ret = uclass_get_device_by_name(UCLASS_PMIC,
 					"pmic@48", &pmica);
 	if (ret) {
diff --git a/board/ti/j784s4/evm.c b/board/ti/j784s4/evm.c
index 42fb819c553..56d5abea6a9 100644
--- a/board/ti/j784s4/evm.c
+++ b/board/ti/j784s4/evm.c
@@ -13,7 +13,9 @@
 #include <spl.h>
 #include <asm/arch/k3-ddr.h>
 #include <power/pmic.h>
+#include <wait_bit.h>
 #include "../common/fdt_ops.h"
+#include "../common.h"
 
 DECLARE_GLOBAL_DATA_PTR;
 
@@ -68,15 +70,43 @@ int board_late_init(void)
 
 #define MAGIC_SUSPEND 0xBA
 
+static void clear_isolation(void)
+{
+	int ret;
+	const void *wait_reg = (const void *)(WKUP_CTRL_MMR0_BASE + MCU_GEN_WAKE_STAT1);
+
+	/* un-set the magic word for MCU_GENERAL IOs */
+	writel(IO_ISO_MAGIC_VAL, WKUP_CTRL_MMR0_BASE + MCU_GEN_WAKE_CTRL);
+	writel((IO_ISO_MAGIC_VAL + 0x1), WKUP_CTRL_MMR0_BASE + MCU_GEN_WAKE_CTRL);
+	writel(IO_ISO_MAGIC_VAL, WKUP_CTRL_MMR0_BASE + MCU_GEN_WAKE_CTRL);
+
+	/* wait for MCU_GEN_IO_MODE bit to be cleared */
+	ret = wait_for_bit_32(wait_reg,
+			      MCU_GEN_WAKE_STAT1_MCU_GEN_IO_MODE,
+			      false,
+			      DEISOLATION_TIMEOUT_MS,
+			      false);
+	if (ret < 0)
+		pr_err("Deisolation timeout");
+}
+
 /* in board_init_f(), there's no BSS, so we can't use global/static variables */
 int board_is_resuming(void)
 {
 	struct udevice *pmic;
+	u32 pmctrl_val = readl(WKUP_CTRL_MMR0_BASE + PMCTRL_IO_0);
 	int err;
 
 	if (gd_k3_resuming() >= 0)
 		goto end;
 
+	if ((pmctrl_val & IO_ISO_STATUS) == IO_ISO_STATUS) {
+		clear_isolation();
+		gd_set_k3_resuming(1);
+		debug("board is resuming from IO_DDR mode\n");
+		return gd_k3_resuming();
+	}
+
 	err = uclass_get_device_by_name(UCLASS_PMIC,
 					"pmic@48", &pmic);
 	if (err) {
-- 
2.34.1

