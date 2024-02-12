Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46C6EC4829B
	for <u-boot@archiver.kernel.org>; Mon, 12 Feb 2024 15:54:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 16DE987EDE;
	Mon, 12 Feb 2024 16:53:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="OKpHHnUy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2213C875FA; Mon, 12 Feb 2024 16:53:41 +0100 (CET)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 689DE8718A
 for <u-boot@lists.denx.de>; Mon, 12 Feb 2024 16:53:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=nm@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 41CFrXSV056946;
 Mon, 12 Feb 2024 09:53:33 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1707753214;
 bh=r06DvzFd/9njWxi9H+OlpUagan8BvMnt1ZPtUXvXXGI=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=OKpHHnUyU5qeTSlcKPgdQ+RV516EftIfXGX17rFjlnWSpBD91SRqjsou91k9+Jzm6
 mN4jxuASIn3VBHl2//flZY6pkgA5NYn1yWYptwB7wROCa8nRxBnbcO5ymuD0cxYMyB
 suGMYoFHFsTe49X9MyS3jL9949CoT+UZoosZkrZM=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 41CFrXMf118489
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 12 Feb 2024 09:53:33 -0600
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 12
 Feb 2024 09:53:33 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 12 Feb 2024 09:53:33 -0600
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 41CFrX6a033145;
 Mon, 12 Feb 2024 09:53:33 -0600
From: Nishanth Menon <nm@ti.com>
To: Robert Nelson <robertcnelson@gmail.com>, Tom Rini <trini@konsulko.com>
CC: <u-boot@lists.denx.de>, Nishanth Menon <nm@ti.com>
Subject: [PATCH 1/4] board: beagle: beagleplay: Enable 32k crystal
Date: Mon, 12 Feb 2024 09:53:29 -0600
Message-ID: <20240212155332.541949-2-nm@ti.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240212155332.541949-1-nm@ti.com>
References: <20240212155332.541949-1-nm@ti.com>
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

Signed-off-by: Nishanth Menon <nm@ti.com>
---
 board/beagle/beagleplay/beagleplay.c | 37 ++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/board/beagle/beagleplay/beagleplay.c b/board/beagle/beagleplay/beagleplay.c
index 20819ecf45b4..a75b3145fa37 100644
--- a/board/beagle/beagleplay/beagleplay.c
+++ b/board/beagle/beagleplay/beagleplay.c
@@ -11,6 +11,8 @@
 #include <fdt_support.h>
 #include <spl.h>
 
+#include <asm/arch/hardware.h>
+
 DECLARE_GLOBAL_DATA_PTR;
 
 int board_init(void)
@@ -28,6 +30,41 @@ int dram_init_banksize(void)
 	return fdtdec_setup_memory_banksize();
 }
 
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
+
 #ifdef CONFIG_BOARD_LATE_INIT
 int board_late_init(void)
 {
-- 
2.43.0

