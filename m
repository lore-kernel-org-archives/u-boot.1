Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9BB2C5475B
	for <u-boot@archiver.kernel.org>; Tue, 20 Feb 2024 18:40:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5C9A588011;
	Tue, 20 Feb 2024 19:40:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="PYfS+zvm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D548987FEE; Tue, 20 Feb 2024 19:40:01 +0100 (CET)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F14E787FED
 for <u-boot@lists.denx.de>; Tue, 20 Feb 2024 19:39:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=nm@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 41KIdroh084035;
 Tue, 20 Feb 2024 12:39:53 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1708454393;
 bh=RE8JTuETAnM24vxVhBpvxoByd78vQ/ZKa9ijz2ZISl0=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=PYfS+zvmqvhvU1gXQ4Cbk8jdjUaIdzxxMAnqd+0ZKQJMTqBGUS8bBAP7hKIijvp/i
 kbvEmSd4WumGqHJ40hGVnfLtG8WE8/2P7t+XVc3Ws9VOts/c8v2iD3NoePZIe8fQ8N
 fFzsumPwHlC+8Pr5fcdCgJ0d0rsZoG06OzrQuoPI=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 41KIdriV040200
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 20 Feb 2024 12:39:53 -0600
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 20
 Feb 2024 12:39:53 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 20 Feb 2024 12:39:53 -0600
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 41KIdr8o128001;
 Tue, 20 Feb 2024 12:39:53 -0600
From: Nishanth Menon <nm@ti.com>
To: Robert Nelson <robertcnelson@gmail.com>, Tom Rini <trini@konsulko.com>
CC: <u-boot@lists.denx.de>, Nishanth Menon <nm@ti.com>
Subject: [PATCH V2 1/5] board: beagle: beagleplay: Enable 32k crystal
Date: Tue, 20 Feb 2024 12:39:48 -0600
Message-ID: <20240220183952.3614252-2-nm@ti.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240220183952.3614252-1-nm@ti.com>
References: <20240220183952.3614252-1-nm@ti.com>
MIME-Version: 1.0
Organization: Texas Instruments, Inc.
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
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

Enable the external 32k crystal similar to that found on other
production AM62X board. The trim settings for the crystal is board
dependent, so the sequences tend to be board specific. Since this is
a configuration that needs to be done prior to DM managing the system
and all other muxes get set, do the same from R5 context.

Tested-by: Robert Nelson <robertcnelson@gmail.com>
Signed-off-by: Nishanth Menon <nm@ti.com>
---
Changes from V1:
 * Added Robert's tested by.

V1: https://lore.kernel.org/r/20240212155332.541949-2-nm@ti.com

 board/beagle/beagleplay/beagleplay.c | 37 ++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/board/beagle/beagleplay/beagleplay.c b/board/beagle/beagleplay/beagleplay.c
index 1c376dea372f..2adb2517ef00 100644
--- a/board/beagle/beagleplay/beagleplay.c
+++ b/board/beagle/beagleplay/beagleplay.c
@@ -11,6 +11,8 @@
 #include <fdt_support.h>
 #include <spl.h>
 
+#include <asm/arch/hardware.h>
+
 DECLARE_GLOBAL_DATA_PTR;
 
 int board_init(void)
@@ -27,3 +29,38 @@ int dram_init_banksize(void)
 {
 	return fdtdec_setup_memory_banksize();
 }
+
+#ifdef CONFIG_SPL_BOARD_INIT
+
+/*
+ * Enable the 32k Crystal: needed for accurate 32k clock
+ * and external clock sources such as wlan 32k input clock
+ * supplied from the SoC to the wlan chip.
+ *
+ * The trim setup can be very highly board type specific choice of the crystal
+ * So this is done in the board file, though, in this case, no specific trim
+ * is necessary.
+ */
+static void crystal_32k_enable(void)
+{
+	/* Only mess with 32k at the start of boot from R5 */
+	if (IS_ENABLED(CONFIG_CPU_V7R)) {
+		/*
+		 * We have external 32k crystal, so lets enable it (0x0)
+		 * and disable bypass (0x0)
+		 */
+		writel(0x0, MCU_CTRL_LFXOSC_CTRL);
+
+		/* Add any crystal specific TRIM needed here.. */
+
+		/* Make sure to mux the SoC 32k from the crystal */
+		writel(MCU_CTRL_DEVICE_CLKOUT_LFOSC_SELECT_VAL,
+		       MCU_CTRL_DEVICE_CLKOUT_32K_CTRL);
+	}
+}
+
+void spl_board_init(void)
+{
+	crystal_32k_enable();
+}
+#endif
-- 
2.43.0

