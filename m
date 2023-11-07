Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F7DCC4332F
	for <u-boot@archiver.kernel.org>; Tue,  7 Nov 2023 16:19:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A02C987533;
	Tue,  7 Nov 2023 17:18:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="cjE/tNLs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B8EAF87545; Tue,  7 Nov 2023 17:18:52 +0100 (CET)
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net
 [217.70.183.197])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 447708751B
 for <u-boot@lists.denx.de>; Tue,  7 Nov 2023 17:18:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=thomas.richard@bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 9EA7E1C0010;
 Tue,  7 Nov 2023 16:18:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
 t=1699373930;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4d0EYyZ4ovUbajF1zq9MqdjSZKJpFZyyVNYeRe4RyDk=;
 b=cjE/tNLslLIfi0rx+XZ/2JyQ2B/FR4Jtla7WQe0gW3GaX41e1pfZcUP1YpxApyzLFghVJH
 GDLrWkV9MFEgLbay67QsieCMIUCPaECWUtbrl/RT/uZ2YzJJql93v4EAkgsoqs2s/TpPCp
 o39+aycSO6/NeMatkJahkkaBj94PzqNrjbwUdg+Edb9f3gdP2DdSiDrCg7lCJXPHR+iNtA
 vdp5VanH/J0OvQmE+aCV1bZWIr3UVWcSxx7WS4wC+7FW7ecA6F1M+YKgx34TKvdTq+PrJm
 kv33UfiUWktgQZDvpZEUEm6xw0aMtw+VCOIOt4Kuet4VE1iUM/Ibh0Anld5rfg==
From: Thomas Richard <thomas.richard@bootlin.com>
To: u-boot@lists.denx.de
Cc: nm@ti.com, thomas.richard@bootlin.com, thomas.petazzoni@bootlin.com,
 gregory.clement@bootlin.com, u-kumar1@ti.com, Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 4/8] board: ti: j721e: Add resume detection for J7200
Date: Tue,  7 Nov 2023 17:17:58 +0100
Message-Id: <20231107161802.855154-5-thomas.richard@bootlin.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231107161802.855154-1-thomas.richard@bootlin.com>
References: <20231107161802.855154-1-thomas.richard@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: thomas.richard@bootlin.com
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

Add the capability to detect a resume.
To detect the resume, SPL searches a magic value (0xBA) in a register
of PMICA.
This value is set by DM-Firmware during the suspend sequence.

Based on the work of Gregory CLEMENT <gregory.clement@bootlin.com>

Signed-off-by: Thomas Richard <thomas.richard@bootlin.com>
Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>
---

(no changes since v1)

 board/ti/j721e/evm.c | 54 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 54 insertions(+)

diff --git a/board/ti/j721e/evm.c b/board/ti/j721e/evm.c
index 38fe447d8f..b4b94c8c69 100644
--- a/board/ti/j721e/evm.c
+++ b/board/ti/j721e/evm.c
@@ -22,6 +22,9 @@
 #include <spl.h>
 #include <dm.h>
 #include <dm/uclass-internal.h>
+#if (IS_ENABLED(CONFIG_SPL_BUILD) && IS_ENABLED(CONFIG_TARGET_J7200_R5_EVM))
+#include <power/pmic.h>
+#endif
 
 #include "../common/board_detect.h"
 
@@ -528,6 +531,57 @@ err_free_gpio:
 	}
 }
 
+#if (IS_ENABLED(CONFIG_SPL_BUILD) && IS_ENABLED(CONFIG_TARGET_J7200_R5_EVM))
+
+#define SCRATCH_PAD_REG_3 0xCB
+
+#define MAGIC_SUSPEND 0xBA
+
+static int resuming = -1;
+
+int board_is_resuming(void)
+{
+	struct udevice *pmica, *pmicb;
+	int ret;
+
+	if (resuming >= 0)
+		goto end;
+
+	ret = uclass_get_device_by_name(UCLASS_PMIC,
+					"tps659413@48", &pmica);
+	if (ret) {
+		printf("Getting PMICA init failed: %d\n", ret);
+		resuming = 0;
+		goto end;
+	}
+	debug("%s: PMICA is detected (%s)\n", __func__, pmica->name);
+
+	ret = uclass_get_device_by_name(UCLASS_PMIC,
+					"lp876441@4c", &pmicb);
+	if (ret) {
+		printf("Getting PMICB init failed: %d\n", ret);
+		resuming = 0;
+		goto end;
+	}
+	debug("%s: PMICB is detected (%s)\n", __func__, pmicb->name);
+
+	if ((pmic_reg_read(pmica, SCRATCH_PAD_REG_3) == MAGIC_SUSPEND)) {
+		resuming = 1;
+		debug("%s: board is resuming\n", __func__);
+
+		/* clean magic suspend */
+		if (pmic_reg_write(pmica, SCRATCH_PAD_REG_3, 0))
+			printf("Failed to clean magic value for suspend detection in PMICA\n");
+	} else {
+		resuming = 0;
+		debug("%s: board is booting (no resume detected)\n", __func__);
+	}
+end:
+	return resuming;
+}
+
+#endif /* CONFIG_SPL_BUILD && CONFIG_TARGET_J7200_R5_EVM */
+
 void spl_board_init(void)
 {
 #if defined(CONFIG_ESM_K3) || defined(CONFIG_ESM_PMIC)
-- 
2.39.2

