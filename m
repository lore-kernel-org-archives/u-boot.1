Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D4D9CDB47F
	for <u-boot@archiver.kernel.org>; Wed, 24 Jun 2026 07:47:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8727F84A4F;
	Wed, 24 Jun 2026 09:45:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="SYJ2OUJT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3A33E84A3E; Wed, 24 Jun 2026 09:45:54 +0200 (CEST)
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3379080287
 for <u-boot@lists.denx.de>; Wed, 24 Jun 2026 09:45:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=richard.genoud@bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-02.galae.net (Postfix) with ESMTPS id E86C91A090B;
 Wed, 24 Jun 2026 07:45:51 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id B6F9A601C5;
 Wed, 24 Jun 2026 07:45:51 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 19807106C85E5; 
 Wed, 24 Jun 2026 09:45:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1782287150; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding:in-reply-to:references;
 bh=iOQZ2sV/5qHdX5zQSzjegail5KwfWxv3dmCw6nJiBxg=;
 b=SYJ2OUJTikdfcJak2dG5LAZDRehTdAnOs3d2BeCMEyFFa77SIFS6nt8Z8KwsIHH+rc2OqX
 6Z3zj09ssabYkQWHZJq5LTh7yTPYi2c5W80mV0nbmGEtChHfQmZz0mvNZ4rz7kl8TCHoFY
 81YtNKS0sh0NW0qxoAPLkzUfjF4xgZGekShwXkSmVIUFrNNTo4VYB7A/sJgUh7fX0I0IEC
 Ho79I/hcJd/kSby0jrzY/0FuviUy8/XxvPtzMNCPNyKjmzTWTrnYRuZHqNmeKF/jz369+4
 V9SFT3xOi9n/Sym+kjsk3mbPNYNaLr8EzX1waT4oL7L79ZJ8IysN+EGFxer5Mg==
From: "Richard Genoud (TI)" <richard.genoud@bootlin.com>
To: Tom Rini <trini@konsulko.com>, Manorit Chawdhry <m-chawdhry@ti.com>,
 Apurva Nandan <a-nandan@ti.com>, "Andrew F . Davis" <afd@ti.com>,
 Vignesh Raghavendra <vigneshr@ti.com>, Bryan Brattlof <bb@ti.com>,
 Vaishnav Achath <vaishnav.a@ti.com>, Jayesh Choudhary <j-choudhary@ti.com>,
 Simon Glass <sjg@chromium.org>, Alper Nebi Yasak <alpernebiyasak@gmail.com>
Cc: Markus Schneider-Pargmann <msp@baylibre.com>,
 Kendall Willis <k-willis@ti.com>, Udit Kumar <u-kumar1@ti.com>,
 Abhash Kumar <a-kumar2@ti.com>,
 Thomas Richard <thomas.richard@bootlin.com>,
 Gregory CLEMENT <gregory.clement@bootlin.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Richard Genoud <richard.genoud@bootlin.com>, u-boot@lists.denx.de
Subject: [PATCH v3 16/19] arm: mach-k3: j721s2: Enable LPM resume flow
Date: Wed, 24 Jun 2026 09:44:56 +0200
Message-ID: <20260624074459.873906-17-richard.genoud@bootlin.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260624074459.873906-1-richard.genoud@bootlin.com>
References: <20260624074459.873906-1-richard.genoud@bootlin.com>
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

Add the board specific part of the exit retention sequence for k3-ddrss:
- exit DDR from retention
- de-assert the DDR_RET pin
- restore DDR max frequency
- exit DDR from low power
Then generic resume path is run.

Signed-off-by: Thomas Richard (TI) <thomas.richard@bootlin.com>
---
 arch/arm/mach-k3/j721s2/j721s2_init.c | 49 ++++++++++++++++++++++++---
 1 file changed, 45 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-k3/j721s2/j721s2_init.c b/arch/arm/mach-k3/j721s2/j721s2_init.c
index b5453d8895d4..051b85d8ac5b 100644
--- a/arch/arm/mach-k3/j721s2/j721s2_init.c
+++ b/arch/arm/mach-k3/j721s2/j721s2_init.c
@@ -16,12 +16,20 @@
 #include <dm/uclass-internal.h>
 #include <dm/pinctrl.h>
 #include <dm/root.h>
+#include <mach/k3-ddr.h>
 #include <mmc.h>
+#include <power/pmic.h>
 #include <remoteproc.h>
 
 #include "../sysfw-loader.h"
+#include "../lpm-common.h"
 #include "../common.h"
 
+#define MAX_DDR_CONTROLLERS	2
+
+/* DDR retention bits */
+#define DDR_RET_VAL BIT(3)
+
 /* NAVSS North Bridge (NB) */
 #define NAVSS0_NBSS_NB0_CFG_MMRS		0x03702000
 #define NAVSS0_NBSS_NB1_CFG_MMRS		0x03703000
@@ -253,9 +261,12 @@ bool check_rom_loaded_sysfw(void)
 void k3_mem_init(void)
 {
 	struct udevice *dev;
-	int ret;
+	int ret, ctrl = 0;
 
 	if (IS_ENABLED(CONFIG_K3_J721E_DDRSS)) {
+		struct udevice *devs[MAX_DDR_CONTROLLERS];
+		struct k3_ddrss_regs regs[MAX_DDR_CONTROLLERS];
+
 		ret = uclass_get_device_by_name(UCLASS_MISC, "msmc", &dev);
 		if (ret)
 			panic("Probe of msmc failed: %d\n", ret);
@@ -263,10 +274,40 @@ void k3_mem_init(void)
 		ret = uclass_get_device(UCLASS_RAM, 0, &dev);
 		if (ret)
 			panic("DRAM 0 init failed: %d\n", ret);
+		devs[0] = dev;
+		ctrl++;
 
-		ret = uclass_next_device_err(&dev);
-		if (ret && ret != -ENODEV)
-			panic("DRAM 1 init failed: %d\n", ret);
+		while (ctrl < MAX_DDR_CONTROLLERS) {
+			ret = uclass_next_device_err(&dev);
+			if (ret == -ENODEV)
+				break;
+
+			if (ret)
+				panic("DRAM %d init failed: %d\n", ctrl, ret);
+			devs[ctrl] = dev;
+			ctrl++;
+		}
+
+		if (j7xx_board_is_resuming()) {
+			/* exit DDRs from retention */
+			for (ctrl = 0; ctrl < MAX_DDR_CONTROLLERS; ctrl++)
+				k3_ddrss_lpddr4_exit_retention(devs[ctrl],
+							       &regs[ctrl]);
+
+			/* de-assert DDR_RET pin */
+			k3_deassert_ddr_ret("pmic@4c", DDR_RET_VAL, 0, false);
+
+			/* restore DDR max frequency */
+			for (ctrl = 0; ctrl < MAX_DDR_CONTROLLERS; ctrl++)
+				k3_ddrss_lpddr4_change_freq(devs[ctrl]);
+
+			/* exit DDR from low power */
+			for (ctrl = 0; ctrl < MAX_DDR_CONTROLLERS; ctrl++)
+				k3_ddrss_lpddr4_exit_low_power(devs[ctrl],
+							       &regs[ctrl]);
+
+			do_resume();
+		}
 	}
 	spl_enable_cache();
 }
