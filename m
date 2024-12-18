Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA6F6E77187
	for <u-boot@archiver.kernel.org>; Wed, 18 Dec 2024 12:47:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7E7368021D;
	Wed, 18 Dec 2024 13:47:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="l/8foEtY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 12B098031D; Wed, 18 Dec 2024 10:30:40 +0100 (CET)
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 14E2E8027E
 for <u-boot@lists.denx.de>; Wed, 18 Dec 2024 10:30:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=a-patra@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 4BI9UZDx4102799
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 18 Dec 2024 03:30:35 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1734514235;
 bh=+NmmsVPwEhR3gXxZol1XiHme+1UxtlJYmnYIWnt1EFs=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=l/8foEtYzsgDtZfZgxju+1v43/4IgksSiTpz4ZEGwvnHomJpLzYlIr4eqwGeF0PYi
 e5WIFt8b0SXnFIa+m/DH+XnVfqKOnFRRnMFJvuTjz/vdKFppJDDwgiy87NnmnVLCXG
 b0k1ootv4HRptq1NXlrkiffMocfe9VjyrdudXmuU=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4BI9UZQH025753
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 18 Dec 2024 03:30:35 -0600
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 18
 Dec 2024 03:30:34 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 18 Dec 2024 03:30:34 -0600
Received: from aparna-HP-Z2-Tower-G9-Workstation-Desktop-PC.dhcp.ti.com
 (aparna-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [172.24.227.31])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4BI9USGF060685;
 Wed, 18 Dec 2024 03:30:32 -0600
From: Aparna Patra <a-patra@ti.com>
To: <u-boot@lists.denx.de>, <trini@konsulko.com>, <bb@ti.com>
CC: <d-gole@ti.com>, <vigneshr@ti.com>, <n-francis@ti.com>, <nm@ti.com>,
 Aparna Patra <a-patra@ti.com>
Subject: [PATCH 1/3] arm: mach-k3: am62p: Fixup CPU core,
 CAN-FD and Video-codec nodes in fdt
Date: Wed, 18 Dec 2024 15:00:23 +0530
Message-ID: <20241218093025.45701-2-a-patra@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241218093025.45701-1-a-patra@ti.com>
References: <20241218093025.45701-1-a-patra@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-Mailman-Approved-At: Wed, 18 Dec 2024 13:47:15 +0100
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

AM62P SOC is available in multiple variants:
-CPU cores (Cortex-A) AM62Px1 (1 core),
 AM62Px2 (2 cores), AM62Px4 (4 cores)
-With and without CAN-FD & Video-codec support

Remove the relevant FDT nodes by reading the actual configuration
from the SoC registers, with that change it is possible to have a single
dts/dtb file handling the different variant at runtime.

Signed-off-by: Aparna Patra <a-patra@ti.com>
---
 arch/arm/mach-k3/am62px/am62p5_fdt.c          | 34 +++++++++++++++++++
 .../arm/mach-k3/include/mach/am62p_hardware.h | 29 ++++++++++++++++
 2 files changed, 63 insertions(+)

diff --git a/arch/arm/mach-k3/am62px/am62p5_fdt.c b/arch/arm/mach-k3/am62px/am62p5_fdt.c
index 29c832d28a..e88760ea51 100644
--- a/arch/arm/mach-k3/am62px/am62p5_fdt.c
+++ b/arch/arm/mach-k3/am62px/am62p5_fdt.c
@@ -7,8 +7,42 @@
 #include "../common_fdt.h"
 #include <fdt_support.h>
 
+static void fdt_fixup_cores_wdt_nodes_am62p(void *blob, int core_nr)
+{
+	char node_path[32];
+
+	if (core_nr < 1)
+		return;
+
+	for (; core_nr < 4; core_nr++) {
+		snprintf(node_path, sizeof(node_path), "/cpus/cpu@%d", core_nr);
+		fdt_del_node_path(blob, node_path);
+		snprintf(node_path, sizeof(node_path), "/cpus/cpu-map/cluster0/core%d", core_nr);
+		fdt_del_node_path(blob, node_path);
+		snprintf(node_path, sizeof(node_path), "/bus@f0000/watchdog@e0%d0000", core_nr);
+		fdt_del_node_path(blob, node_path);
+	}
+}
+
+static void fdt_fixup_video_codec_nodes_am62p(void *blob, bool has_video_codec)
+{
+	if (!has_video_codec)
+		fdt_del_node_path(blob, "/bus@f0000/video-codec@30210000");
+}
+
+static void fdt_fixup_canfd_nodes_am62p(void *blob, bool has_canfd)
+{
+	if (!has_canfd) {
+		fdt_del_node_path(blob, "/bus@f0000/can@20701000");
+		fdt_del_node_path(blob, "/bus@f0000/can@20711000");
+	}
+}
+
 int ft_system_setup(void *blob, struct bd_info *bd)
 {
+	fdt_fixup_cores_wdt_nodes_am62p(blob, k3_get_core_nr());
+	fdt_fixup_video_codec_nodes_am62p(blob, k3_has_video_codec());
+	fdt_fixup_canfd_nodes_am62p(blob, k3_has_canfd());
 	fdt_fixup_reserved(blob, "tfa", CONFIG_K3_ATF_LOAD_ADDR, 0x80000);
 	fdt_fixup_reserved(blob, "optee", CONFIG_K3_OPTEE_LOAD_ADDR, 0x1800000);
 
diff --git a/arch/arm/mach-k3/include/mach/am62p_hardware.h b/arch/arm/mach-k3/include/mach/am62p_hardware.h
index 923466c41f..339562722d 100644
--- a/arch/arm/mach-k3/include/mach/am62p_hardware.h
+++ b/arch/arm/mach-k3/include/mach/am62p_hardware.h
@@ -19,6 +19,14 @@
 #define MCU_CTRL_MMR0_BASE			0x04500000
 #define WKUP_CTRL_MMR0_BASE			0x43000000
 
+#define CTRLMMR_WKUP_JTAG_DEVICE_ID		(WKUP_CTRL_MMR0_BASE + 0x18)
+#define JTAG_DEV_CORE_NR_MASK			GENMASK(19, 18)
+#define JTAG_DEV_CORE_NR_SHIFT			18
+#define JTAG_DEV_CANFD_MASK			BIT(15)
+#define JTAG_DEV_CANFD_SHIFT			15
+#define JTAG_DEV_VIDEO_CODEC_MASK			BIT(14)
+#define JTAG_DEV_VIDEO_CODEC_SHIFT			14
+
 #define CTRLMMR_MAIN_DEVSTAT			(WKUP_CTRL_MMR0_BASE + 0x30)
 #define MAIN_DEVSTAT_PRIMARY_BOOTMODE_MASK	GENMASK(6, 3)
 #define MAIN_DEVSTAT_PRIMARY_BOOTMODE_SHIFT	3
@@ -72,6 +80,27 @@
 
 #define TI_SRAM_SCRATCH_BOARD_EEPROM_START	0x43c30000
 
+static inline int k3_get_core_nr(void)
+{
+	u32 dev_id = readl(CTRLMMR_WKUP_JTAG_DEVICE_ID);
+
+	return ((dev_id & JTAG_DEV_CORE_NR_MASK) >> JTAG_DEV_CORE_NR_SHIFT) + 1;
+}
+
+static inline int k3_has_video_codec(void)
+{
+	u32 dev_id = readl(CTRLMMR_WKUP_JTAG_DEVICE_ID);
+
+	return !((dev_id & JTAG_DEV_VIDEO_CODEC_MASK) >> JTAG_DEV_VIDEO_CODEC_SHIFT);
+}
+
+static inline int k3_has_canfd(void)
+{
+	u32 dev_id = readl(CTRLMMR_WKUP_JTAG_DEVICE_ID);
+
+	return (dev_id & JTAG_DEV_CANFD_MASK) >> JTAG_DEV_CANFD_SHIFT;
+}
+
 #if defined(CONFIG_SYS_K3_SPL_ATF) && !defined(__ASSEMBLY__)
 
 static const u32 put_device_ids[] = {};
-- 
2.34.1

