Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8396DCCFA13
	for <u-boot@archiver.kernel.org>; Thu, 30 Apr 2026 08:45:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1690884690;
	Thu, 30 Apr 2026 10:44:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="TW1gSMIm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A478C8469D; Thu, 30 Apr 2026 10:44:46 +0200 (CEST)
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EE07E8460D
 for <u-boot@lists.denx.de>; Thu, 30 Apr 2026 10:44:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=richard.genoud@bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-02.galae.net (Postfix) with ESMTPS id 8E70D1A348E;
 Thu, 30 Apr 2026 08:44:43 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 63E7860495;
 Thu, 30 Apr 2026 08:44:43 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id D41A91072B6D1; 
 Thu, 30 Apr 2026 10:44:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1777538681; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding:in-reply-to:references;
 bh=mUgofqoocZd1PbkGZC1p0wzVAyKRg6TF4oXe8rebIBw=;
 b=TW1gSMIma3MGvRHyxb6L8Let5RO1TjphcbDV3QPOZqr2X4OOaoM/2FOmOPUzPgvfKgZS0Z
 BazK0R2EbvEVjXSGWCmDGv24qgrjYZ5G+E56KAYKG+wyKxT4cJihjR0GFzP621lzvH+Jg/
 rkoEpFtl9QHhu67zDdkfnhe2DmYotUOB80NBIYvKT6VkKkvJtHXifWDeL5bu4VQC8rAn3U
 d2y9UsXkFgRtGcAy3kFyKmioVpc33i7r5rnpg8Pyi/X87gXmdJUbYz9/+NgSi2de82ZdxP
 d9v+Z5I8kabYogqhUEHaoAVUe2aEYxtlueVPNcDqb6XM9igFQ/kvUQc/TdI6mg==
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
Subject: [PATCH 06/20] board: ti: j721s2: Add resume detection
Date: Thu, 30 Apr 2026 10:43:59 +0200
Message-ID: <20260430084414.1354490-7-richard.genoud@bootlin.com>
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

Add the capability to detect a resume. This overrides the weak function
j7xx_board_is_resuming(void).
To detect the resume, SPL searches a magic value (0xBA) in a register of
PMICA.
This value is set by DM-Firmware during the suspend sequence.

Signed-off-by: Thomas Richard (TI) <thomas.richard@bootlin.com>
---
 board/ti/j721s2/evm.c | 37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/board/ti/j721s2/evm.c b/board/ti/j721s2/evm.c
index 92d5c8498643..e18ba1a540c9 100644
--- a/board/ti/j721s2/evm.c
+++ b/board/ti/j721s2/evm.c
@@ -22,9 +22,11 @@
 #include <dm/uclass-internal.h>
 #include <dm/root.h>
 #include <asm/arch/k3-ddr.h>
+#include <power/pmic.h>
 
 #include "../common/board_detect.h"
 #include "../common/fdt_ops.h"
+#include "../common/k3-lpm.h"
 
 DECLARE_GLOBAL_DATA_PTR;
 
@@ -304,6 +306,41 @@ int board_late_init(void)
 	return 0;
 }
 
+#if (IS_ENABLED(CONFIG_SPL_BUILD) && IS_ENABLED(CONFIG_TARGET_J721S2_R5_EVM) && IS_ENABLED(CONFIG_PMIC_TPS65941))
+
+/* in board_init_f(), there's no BSS, so we can't use global/static variables */
+bool j7xx_board_is_resuming(void)
+{
+	struct udevice *pmic;
+	int err;
+
+	if (gd_k3_resuming() != K3_RESUME_STATE_UNKNOWN)
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
+	if (pmic_reg_read(pmic, K3_LPM_SCRATCH_PAD_REG) == K3_LPM_MAGIC_SUSPEND) {
+		debug("%s: board is resuming\n", __func__);
+		gd_set_k3_resuming(K3_RESUME_STATE_RESUMING);
+
+		/* clean magic suspend */
+		if (pmic_reg_write(pmic, K3_LPM_SCRATCH_PAD_REG, 0))
+			printf("Failed to clean magic value for suspend detection in PMIC\n");
+	} else {
+		debug("%s: board is booting (no resume detected)\n", __func__);
+		gd_set_k3_resuming(K3_RESUME_STATE_BOOTING);
+	}
+end:
+	return gd_k3_resuming() == K3_RESUME_STATE_RESUMING;
+}
+#endif /* CONFIG_SPL_BUILD && CONFIG_TARGET_J721S2_R5_EVM && CONFIG_PMIC_TPS65941 */
+
 void spl_board_init(void)
 {
 	struct udevice *dev;
