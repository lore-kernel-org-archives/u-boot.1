Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08364FF8875
	for <u-boot@archiver.kernel.org>; Thu, 30 Apr 2026 08:44:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 532B88467A;
	Thu, 30 Apr 2026 10:44:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="Ck8TQvM+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D0FF78466E; Thu, 30 Apr 2026 10:44:37 +0200 (CEST)
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 69E2D8466C
 for <u-boot@lists.denx.de>; Thu, 30 Apr 2026 10:44:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=richard.genoud@bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id 126754E42B79;
 Thu, 30 Apr 2026 08:44:35 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id D514060495;
 Thu, 30 Apr 2026 08:44:34 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 64BAC1072B7AE; 
 Thu, 30 Apr 2026 10:44:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1777538673; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding:in-reply-to:references;
 bh=sk7iOm9SBxYXoB7YlV4H5UFOinc75XKNo0qOlhBVsNo=;
 b=Ck8TQvM+7MlMErtz0nPBGfjrDBl5tCH8v9ixaznWBrCv7kbEITTuQk/uGXNuFtuuUTlB+c
 m766cl3IAy9duMobJ4yiqkW+jSmgSZOAGpHSigE8xpQ38Zdwxn9FOx0D7aLgqVgwjeBnBa
 8igcIlSfvSoQ9nvySYIDwmoBL7nB7Ux0N0z0sxgnSDKalvMp3C98JBSfIyl5EKyO31i9sj
 GAEF2kSa46BSAic9hYLB87ZyfxzCzHD08x6g4j1k08QAhFs0ClR/L3AvJp9SzxQGRAo8Fd
 qAQXrWME8Yn/Zv/nQZ4ymjWbcKA/Xw1colUgXTsrCXofRtkzBvzcu6AKS1qhzw==
From: "Richard Genoud (TI)" <richard.genoud@bootlin.com>
To: Tom Rini <trini@konsulko.com>, Manorit Chawdhry <m-chawdhry@ti.com>,
 Apurva Nandan <a-nandan@ti.com>, "Andrew F . Davis" <afd@ti.com>,
 Vignesh Raghavendra <vigneshr@ti.com>, Bryan Brattlof <bb@ti.com>,
 Vaishnav Achath <vaishnav.a@ti.com>, Jayesh Choudhary <j-choudhary@ti.com>,
 Simon Glass <sjg@chromium.org>, Alper Nebi Yasak <alpernebiyasak@gmail.com>
Cc: Markus Schneider-Pargmann <msp@baylibre.com>, Udit Kumar <u-kumar1@ti.com>,
 Abhash Kumar <a-kumar2@ti.com>,
 Thomas Richard <thomas.richard@bootlin.com>,
 Gregory CLEMENT <gregory.clement@bootlin.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Richard Genoud <richard.genoud@bootlin.com>, u-boot@lists.denx.de
Subject: [PATCH 03/20] board: ti: j721e: Add resume detection for J721e/J7200
Date: Thu, 30 Apr 2026 10:43:56 +0200
Message-ID: <20260430084414.1354490-4-richard.genoud@bootlin.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260430084414.1354490-1-richard.genoud@bootlin.com>
References: <20260430084414.1354490-1-richard.genoud@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
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

From: "Thomas Richard (TI)" <thomas.richard@bootlin.com>

Add the capability to detect a resume. This overrides the weak
function j7xx_board_is_resuming(void).
To detect the resume, SPL searches a magic value (0xBA) in a register
of PMICA.
This value is set by DM-Firmware during the suspend sequence.

Signed-off-by: Thomas Richard (TI) <thomas.richard@bootlin.com>
Co-developed-by: Gregory CLEMENT (TI) <gregory.clement@bootlin.com>
Signed-off-by: Gregory CLEMENT (TI) <gregory.clement@bootlin.com>
Co-developed-by: Richard Genoud (TI) <richard.genoud@bootlin.com>
Signed-off-by: Richard Genoud (TI) <richard.genoud@bootlin.com>
---
 board/ti/common/k3-lpm.h | 17 +++++++++++++++++
 board/ti/j721e/evm.c     | 37 +++++++++++++++++++++++++++++++++++++
 2 files changed, 54 insertions(+)
 create mode 100644 board/ti/common/k3-lpm.h

diff --git a/board/ti/common/k3-lpm.h b/board/ti/common/k3-lpm.h
new file mode 100644
index 000000000000..a2141a0c25a8
--- /dev/null
+++ b/board/ti/common/k3-lpm.h
@@ -0,0 +1,17 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Copyright (C) 2026, Texas Instruments Incorporated - https://www.ti.com/
+ * Copyright (C) 2026, Bootlin
+ */
+
+#ifndef __K3_LPM_H
+#define __K3_LPM_H
+
+/* Magic value in PMIC register to indicate the suspend state (SOC_OFF) */
+#define K3_LPM_MAGIC_SUSPEND 0xba
+
+/* PMIC register where the magic value resides */
+#define K3_LPM_SCRATCH_PAD_REG 0xcb
+
+#endif /* __K3_LPM_H */
+
diff --git a/board/ti/j721e/evm.c b/board/ti/j721e/evm.c
index 881392bd963a..67ff13828514 100644
--- a/board/ti/j721e/evm.c
+++ b/board/ti/j721e/evm.c
@@ -17,9 +17,11 @@
 #include <spl.h>
 #include <dm.h>
 #include <asm/arch/k3-ddr.h>
+#include <power/pmic.h>
 
 #include "../common/board_detect.h"
 #include "../common/fdt_ops.h"
+#include "../common/k3-lpm.h"
 
 #define board_is_j721e_som()	(board_ti_k3_is("J721EX-PM1-SOM") || \
 				 board_ti_k3_is("J721EX-PM2-SOM"))
@@ -469,6 +471,41 @@ err_free_gpio:
 	}
 }
 
+#if (IS_ENABLED(CONFIG_SPL_BUILD) && IS_ENABLED(CONFIG_TARGET_J7200_R5_EVM))
+
+bool j7xx_board_is_resuming(void)
+{
+	struct udevice *pmica;
+	int ret;
+
+	if (gd_k3_resuming() != K3_RESUME_STATE_UNKNOWN)
+		goto end;
+
+	ret = uclass_get_device_by_name(UCLASS_PMIC,
+					"pmic@48", &pmica);
+	if (ret) {
+		printf("Getting PMICA init failed: %d\n", ret);
+		goto end;
+	}
+	debug("%s: PMICA is detected (%s)\n", __func__, pmica->name);
+
+	if (pmic_reg_read(pmica, K3_LPM_SCRATCH_PAD_REG) == K3_LPM_MAGIC_SUSPEND) {
+		debug("%s: board is resuming\n", __func__);
+		gd_set_k3_resuming(K3_RESUME_STATE_RESUMING);
+
+		/* clean magic suspend */
+		if (pmic_reg_write(pmica, K3_LPM_SCRATCH_PAD_REG, 0))
+			printf("Failed to clean magic value for suspend detection in PMICA\n");
+	} else {
+		debug("%s: board is booting (no resume detected)\n", __func__);
+		gd_set_k3_resuming(K3_RESUME_STATE_BOOTING);
+	}
+end:
+	return gd_k3_resuming() == K3_RESUME_STATE_RESUMING;
+}
+
+#endif /* CONFIG_SPL_BUILD && CONFIG_TARGET_J7200_R5_EVM */
+
 void spl_board_init(void)
 {
 	struct udevice *dev;
