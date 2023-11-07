Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 928C2C04A95
	for <u-boot@archiver.kernel.org>; Tue,  7 Nov 2023 23:22:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9CE718764C;
	Wed,  8 Nov 2023 00:22:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="f3h/jvVG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A62B187447; Wed,  8 Nov 2023 00:21:58 +0100 (CET)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9AA9C8764C
 for <u-boot@lists.denx.de>; Wed,  8 Nov 2023 00:21:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=bb@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3A7NLgB2093966;
 Tue, 7 Nov 2023 17:21:42 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1699399302;
 bh=oZaS1WgYfdIc5ba37Stn7+sTJklMHRfdFC+TXXkcspg=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=f3h/jvVGwnLP3mH8h1ZHR4kqniP8xMTMht9nwNoYpGm5WxQ1q/rNvgSjTptd+REjK
 SkyUUgYl45Jk7f22CpX2qyzQYIwOaUVa+emwQjYUtAJRAoAABbm9nL6mc0FgT9PrGM
 2Q+4APsLJDgtwW7xgnn3KMtXas2SxUE1tlS+dadE=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3A7NLgwi043602
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 7 Nov 2023 17:21:42 -0600
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 7
 Nov 2023 17:21:42 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 7 Nov 2023 17:21:41 -0600
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
 by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3A7NLfrN048231;
 Tue, 7 Nov 2023 17:21:41 -0600
From: Bryan Brattlof <bb@ti.com>
To: Tom Rini <trini@konsulko.com>, Vignesh Raghavendra <vigneshr@ti.com>,
 Christian Gmeiner <christian.gmeiner@gmail.com>, Andrew Davis <afd@ti.com>
CC: UBoot Mailing List <u-boot@lists.denx.de>, Bryan Brattlof <bb@ti.com>
Subject: [PATCH 1/3] board: ti: common: add rtc setup to common folder
Date: Tue, 7 Nov 2023 17:21:41 -0600
Message-ID: <20231107232139.2839534-6-bb@ti.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231107232139.2839534-5-bb@ti.com>
References: <20231107232139.2839534-5-bb@ti.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2763; i=bb@ti.com;
 h=from:subject; bh=sIghlc7zkDcjuIxk5AZITsje/Y4hWxUCfrQbZaL2xzg=;
 b=owNCWmg5MUFZJlNZsM0dJgAAZn///vff/+syrcv3dr/Nn1/GjTr6+PTv/9/r2f+d871W73cwA
 RlRjtQAAAGho0A0ZBoGg0Gg0aNAGhoAaAADTRpo00Gg09RoNGI9TagaMxCYmyggaGjQyNGQaaaa
 MjRpoBiZDEyBkDENDIDQAAAYhkxMgaaGIDENADTExGm0Q0bITRpoPU9QaAAaAGjQ9QAB6geoAAB
 oPU009TCaNHqNAaDRoAeoaA0MnqAHqAAARZ/ORCtjyY4P5u6ENgKH9ySM9hL88i4dTEQTdV9ZrQ
 D3l0IQSXEzd0kSgmiwX2GYnOdj8s/AVDSDaUGdKvIGgZyEYbn1RTWxTsGnUs9RKZRx8oQ46VkEk
 DJFmS3cvVV1F0p9ZD2ysZMxFaU++SOTTC0CVjIPw8ZTgriaYJqMgSTZtCjFVCdJsqcUI1+AHR6i
 bXG3BsR0OnwK1bf0+CnJIamCUUU0ZF31fj4bYwkHtrhUQ0iVCJsvWZ4NuW9M9IZrUQazwE4kLrm
 Cw4lerEOvoApTMDByepk4K9o/mOYP0BDln5Nu73cBpHvaSneG5UOFRcXLZmlJIxRv+OvNPC12iP
 kX4E2SELcvK0ScAZsZAZpRIDjaHxWjowUYqAIEGsPAtW86bqtQtrEHCNBdfjqXLovTMB0YBFyNA
 OgQZYCELuSKcKEhYZo6TA==
X-Developer-Key: i=bb@ti.com; a=openpgp;
 fpr=D3D177E40A38DF4D1853FEEF41B90D5D71D56CE0
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

All of the starter kit boards for the am62xxx extended family utilize
the same 32k crystal oscillator for a more accurate clock for the RTC
instance. Add the setup the clock mux and debounce configuration to the
common board directory so the entire am62xxx extended family can utilize
it.

Signed-off-by: Bryan Brattlof <bb@ti.com>
---
 board/ti/common/Kconfig |  8 +++++++
 board/ti/common/rtc.c   | 47 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 55 insertions(+)
 create mode 100644 board/ti/common/rtc.c

diff --git a/board/ti/common/Kconfig b/board/ti/common/Kconfig
index 49edd98014ab7..56a65c0a402bb 100644
--- a/board/ti/common/Kconfig
+++ b/board/ti/common/Kconfig
@@ -1,3 +1,11 @@
+config BOARD_HAS_32K_RTC_CRYSTAL
+	bool "Enable the 32k crystial for RTC"
+	help
+	   Some of Texas Instrument's Starter-Kit boards have
+	   an onboard 32k crystal. Select this option if you wish Uboot
+	   to enable this crystal for Linux
+	default n
+
 config TI_I2C_BOARD_DETECT
 	bool "Support for Board detection for TI platforms"
 	help
diff --git a/board/ti/common/rtc.c b/board/ti/common/rtc.c
new file mode 100644
index 0000000000000..e117a927765c5
--- /dev/null
+++ b/board/ti/common/rtc.c
@@ -0,0 +1,47 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * RTC setup for TI Platforms
+ *
+ * Copyright (C) 2023 Texas Instruments Incorporated - https://www.ti.com/
+ */
+#include <asm/arch/hardware.h>
+#include <asm/io.h>
+#include <log.h>
+
+#define WKUP_CTRLMMR_DBOUNCE_CFG1 0x04504084
+#define WKUP_CTRLMMR_DBOUNCE_CFG2 0x04504088
+#define WKUP_CTRLMMR_DBOUNCE_CFG3 0x0450408c
+#define WKUP_CTRLMMR_DBOUNCE_CFG4 0x04504090
+#define WKUP_CTRLMMR_DBOUNCE_CFG5 0x04504094
+#define WKUP_CTRLMMR_DBOUNCE_CFG6 0x04504098
+
+void board_rtc_init(void)
+{
+	u32 val;
+
+	/* We have 32k crystal, so lets enable it */
+	val = readl(MCU_CTRL_LFXOSC_CTRL);
+	val &= ~(MCU_CTRL_LFXOSC_32K_DISABLE_VAL);
+	writel(val, MCU_CTRL_LFXOSC_CTRL);
+
+	/* Add any TRIM needed for the crystal here.. */
+	/* Make sure to mux up to take the SoC 32k from the crystal */
+	writel(MCU_CTRL_DEVICE_CLKOUT_LFOSC_SELECT_VAL,
+	       MCU_CTRL_DEVICE_CLKOUT_32K_CTRL);
+
+	/* Setup debounce conf registers - arbitrary values.
+	 * Times are approx
+	 */
+	/* 1.9ms debounce @ 32k */
+	writel(WKUP_CTRLMMR_DBOUNCE_CFG1, 0x1);
+	/* 5ms debounce @ 32k */
+	writel(WKUP_CTRLMMR_DBOUNCE_CFG2, 0x5);
+	/* 20ms debounce @ 32k */
+	writel(WKUP_CTRLMMR_DBOUNCE_CFG3, 0x14);
+	/* 46ms debounce @ 32k */
+	writel(WKUP_CTRLMMR_DBOUNCE_CFG4, 0x18);
+	/* 100ms debounce @ 32k */
+	writel(WKUP_CTRLMMR_DBOUNCE_CFG5, 0x1c);
+	/* 156ms debounce @ 32k */
+	writel(WKUP_CTRLMMR_DBOUNCE_CFG6, 0x1f);
+}
-- 
2.42.0

