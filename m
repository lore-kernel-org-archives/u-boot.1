Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93848C0218D
	for <u-boot@archiver.kernel.org>; Wed, 29 Jan 2025 23:44:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9EAE280C6D;
	Thu, 30 Jan 2025 00:44:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="EH3T/aS6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4586B80D1C; Thu, 30 Jan 2025 00:44:10 +0100 (CET)
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6A0CB80BAB
 for <u-boot@lists.denx.de>; Thu, 30 Jan 2025 00:44:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=jm@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 50TNi3bI2211271
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 29 Jan 2025 17:44:03 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1738194243;
 bh=sd46wgliQsU3BQMxkk2AtzRcvWRrmDwLv6SrUlPydjU=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=EH3T/aS6o8eP8FsxTY+mx4OEIlZjszcsyFdKSGJ2ifYom5lKzFRmQ3d2FpPcfJ166
 1I8WFsOo+nCK0CPePbonwDbXNSRRv2FgrdPc06k9liIGJAPDG9duzobhAQBfRHxJ0O
 8nkMJ70xllzRi137pLhjaDX/zezcPtfY5DPHGbOw=
Received: from DFLE111.ent.ti.com (dfle111.ent.ti.com [10.64.6.32])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 50TNi3X6026992
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 29 Jan 2025 17:44:03 -0600
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 29
 Jan 2025 17:44:03 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 29 Jan 2025 17:44:03 -0600
Received: from judy-hp.dhcp.ti.com (judy-hp.dhcp.ti.com [128.247.81.105])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 50TNi3fd023664;
 Wed, 29 Jan 2025 17:44:03 -0600
From: Judith Mendez <jm@ti.com>
To: Tom Rini <trini@konsulko.com>
CC: Santhosh Kumar K <s-k6@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
 <u-boot@lists.denx.de>, Judith Mendez <jm@ti.com>
Subject: [PATCH 1/2] arm: mach-k3: am62*_init: Probe ESM nodes
Date: Wed, 29 Jan 2025 17:44:02 -0600
Message-ID: <20250129234403.574766-2-jm@ti.com>
X-Mailer: git-send-email 2.48.0
In-Reply-To: <20250129234403.574766-1-jm@ti.com>
References: <20250129234403.574766-1-jm@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
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

From: Santhosh Kumar K <s-k6@ti.com>

On AM62A and AM62P devices, it is possible to route Main ESM error
events to MCU ESM. MCU ESM high error output can trigger the reset
logic to reset the device. So, for these devices we have Main ESM and
MCU ESM nodes in the device tree. Add functions to probe these nodes
if CONFIG_ESM_K3 is enabled.

Signed-off-by: Santhosh Kumar K <s-k6@ti.com>
Signed-off-by: Judith Mendez <jm@ti.com>
---
 arch/arm/mach-k3/am62ax/am62a7_init.c | 26 ++++++++++++++++++++++++++
 arch/arm/mach-k3/am62px/am62p5_init.c | 26 ++++++++++++++++++++++++++
 2 files changed, 52 insertions(+)

diff --git a/arch/arm/mach-k3/am62ax/am62a7_init.c b/arch/arm/mach-k3/am62ax/am62a7_init.c
index 78153c97a58..698e6d5c587 100644
--- a/arch/arm/mach-k3/am62ax/am62a7_init.c
+++ b/arch/arm/mach-k3/am62ax/am62a7_init.c
@@ -15,6 +15,9 @@
 #include "../sysfw-loader.h"
 #include "../common.h"
 
+#define CTRLMMR_MCU_RST_CTRL             0x04518170
+#define RST_CTRL_ESM_ERROR_RST_EN_Z_MASK 0xFFFDFFFF
+
 struct fwl_data cbass_main_fwls[] = {
        { "FSS_DAT_REG3", 7, 8 },
 };
@@ -70,6 +73,15 @@ static void ctrl_mmr_unlock(void)
 	mmr_unlock(PADCFG_MMR1_BASE, 1);
 }
 
+static __maybe_unused void enable_mcu_esm_reset(void)
+{
+	/* Set CTRLMMR_MCU_RST_CTRL:MCU_ESM_ERROR_RST_EN_Z  to '0' (low active) */
+	u32 stat = readl(CTRLMMR_MCU_RST_CTRL);
+
+	stat &= RST_CTRL_ESM_ERROR_RST_EN_Z_MASK;
+	writel(stat, CTRLMMR_MCU_RST_CTRL);
+}
+
 void board_init_f(ulong dummy)
 {
 	struct udevice *dev;
@@ -160,6 +172,20 @@ void board_init_f(ulong dummy)
 	/* Output System Firmware version info */
 	k3_sysfw_print_ver();
 
+	if (IS_ENABLED(CONFIG_ESM_K3)) {
+		/* Probe/configure ESM0 */
+		ret = uclass_get_device_by_name(UCLASS_MISC, "esm@420000", &dev);
+		if (ret)
+			printf("esm main init failed: %d\n", ret);
+
+		/* Probe/configure MCUESM */
+		ret = uclass_get_device_by_name(UCLASS_MISC, "esm@4100000", &dev);
+		if (ret)
+			printf("esm mcu init failed: %d\n", ret);
+
+		enable_mcu_esm_reset();
+	}
+
 #if defined(CONFIG_K3_AM62A_DDRSS)
 	ret = uclass_get_device(UCLASS_RAM, 0, &dev);
 	if (ret)
diff --git a/arch/arm/mach-k3/am62px/am62p5_init.c b/arch/arm/mach-k3/am62px/am62p5_init.c
index 2d35a7ce77e..36216aac90c 100644
--- a/arch/arm/mach-k3/am62px/am62p5_init.c
+++ b/arch/arm/mach-k3/am62px/am62p5_init.c
@@ -15,6 +15,9 @@
 #include "../sysfw-loader.h"
 #include "../common.h"
 
+#define CTRLMMR_MCU_RST_CTRL             0x04518170
+#define RST_CTRL_ESM_ERROR_RST_EN_Z_MASK 0xFFFDFFFF
+
 struct fwl_data cbass_main_fwls[] = {
 	{ "FSS_DAT_REG3", 7, 8 },
 };
@@ -67,6 +70,15 @@ static void ctrl_mmr_unlock(void)
 	mmr_unlock(PADCFG_MMR1_BASE, 1);
 }
 
+static __maybe_unused void enable_mcu_esm_reset(void)
+{
+	/* Set CTRLMMR_MCU_RST_CTRL:MCU_ESM_ERROR_RST_EN_Z  to '0' (low active) */
+	u32 stat = readl(CTRLMMR_MCU_RST_CTRL);
+
+	stat &= RST_CTRL_ESM_ERROR_RST_EN_Z_MASK;
+	writel(stat, CTRLMMR_MCU_RST_CTRL);
+}
+
 void board_init_f(ulong dummy)
 {
 	struct udevice *dev;
@@ -158,6 +170,20 @@ void board_init_f(ulong dummy)
 			panic("DRAM init failed: %d\n", ret);
 	}
 
+	if (IS_ENABLED(CONFIG_ESM_K3)) {
+		/* Probe/configure ESM0 */
+		ret = uclass_get_device_by_name(UCLASS_MISC, "esm@420000", &dev);
+		if (ret)
+			printf("esm main init failed: %d\n", ret);
+
+		/* Probe/configure MCUESM */
+		ret = uclass_get_device_by_name(UCLASS_MISC, "esm@4100000", &dev);
+		if (ret)
+			printf("esm mcu init failed: %d\n", ret);
+
+		enable_mcu_esm_reset();
+	}
+
 	spl_enable_cache();
 
 	setup_qos();
-- 
2.48.0

