Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19A7CCD6E64
	for <u-boot@archiver.kernel.org>; Wed,  3 Jun 2026 09:56:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BF0538469D;
	Wed,  3 Jun 2026 11:55:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="uQ5BbHII";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8D45C848F0; Wed,  3 Jun 2026 11:55:27 +0200 (CEST)
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B14C38491C
 for <u-boot@lists.denx.de>; Wed,  3 Jun 2026 11:55:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=richard.genoud@bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-02.galae.net (Postfix) with ESMTPS id 713151A37B7;
 Wed,  3 Jun 2026 09:55:23 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 3FAFC5FFA8;
 Wed,  3 Jun 2026 09:55:23 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 7652010888CCD; 
 Wed,  3 Jun 2026 11:55:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1780480521; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding:in-reply-to:references;
 bh=r9s0M7oaLy8KWlsd+RihsaYeCQ0IO2Z+3A9a8a3xPgA=;
 b=uQ5BbHII+h0g5rGlB5uS8zicOEKWSdW+ko1Lf1mEaWuxP3tIG954s8vTpwXf00iZs4w4EL
 ZKpyTAwZyNCnqFJRC6MMK7FkxwP1ymgaKWuDNdBSEhKe+NHy2m2aGyIO3lygu7i6WtPXt8
 FQhl3yf3SmO2WQW9AtBWzRjwM35Z06VwLEWsBxvdsFnCAa5u4VlVjjcmbsokDxKKepO3AG
 pUEIYKQdB2CU8qR/30D9juRJnakmCzim+Ds4mia9Ux34OAHh5qry9MPbYMulcNG73NyFY3
 X+5DG9jL6Wg/QsgRdzlAQnh0NtH4rnC/CjxPK09N3KlMjdGrNtW4OXRZttJZkw==
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
Subject: [PATCH v2 10/16] arm: mach-k3: j721e: Enable LPM resume flow for
 J7200/J721e SOC
Date: Wed,  3 Jun 2026 11:54:43 +0200
Message-ID: <20260603095449.2089514-11-richard.genoud@bootlin.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260603095449.2089514-1-richard.genoud@bootlin.com>
References: <20260603095449.2089514-1-richard.genoud@bootlin.com>
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

Add support for resuming from suspend in board_init_f.
The resume state of the SOC is identified and lpm resume
sequence is followed accordingly.

First, add the board specific part of the exit retention sequence for
k3-ddrss following the DDR resume sequence:
   - exit DDR from retention
   - de-assert the DDR_RET pin
   - restore DDR max frequency
   - exit DDR from low power

Then:
   - Extract context address from devicetree and send to TIFS.
   - Power on the rproc cluster.
   - Replay the certificates attached to saved images of ATF and OPTEE.
   - Resume sequence for context restore and rproc resume.
   - Image entry to DM firmware.
(All those steps are done in do_resume())

The context address area is firewalled by TIFS to protect it from
other hosts.

Co-developed-by: Gregory CLEMENT (TI) <gregory.clement@bootlin.com>
Signed-off-by: Gregory CLEMENT (TI) <gregory.clement@bootlin.com>
Signed-off-by: Thomas Richard (TI) <thomas.richard@bootlin.com>
Co-developed-by: Prasanth Babu Mantena <p-mantena@ti.com>
Signed-off-by: Prasanth Babu Mantena <p-mantena@ti.com>
Co-developed-by: Richard Genoud (TI) <richard.genoud@bootlin.com>
Signed-off-by: Richard Genoud (TI) <richard.genoud@bootlin.com>
---
 arch/arm/mach-k3/j721e/j721e_init.c | 64 +++++++++++++++++++++++++++++
 1 file changed, 64 insertions(+)

diff --git a/arch/arm/mach-k3/j721e/j721e_init.c b/arch/arm/mach-k3/j721e/j721e_init.c
index f9af0288cf66..a1f87e653299 100644
--- a/arch/arm/mach-k3/j721e/j721e_init.c
+++ b/arch/arm/mach-k3/j721e/j721e_init.c
@@ -20,9 +20,12 @@
 #include <mmc.h>
 #include <remoteproc.h>
 #include <k3-avs.h>
+#include <power/pmic.h>
+#include <mach/k3-ddr.h>
 
 #include "../sysfw-loader.h"
 #include "../common.h"
+#include "../lpm-common.h"
 
 /* NAVSS North Bridge (NB) registers */
 #define NAVSS0_NBSS_NB0_CFG_MMRS		0x03802000
@@ -294,10 +297,55 @@ void do_dt_magic(void)
 }
 #endif
 
+#define GPIO_OUT_1 0x3D
+#define DDR_RET_VAL BIT(1)
+#define DDR_RET_CLK BIT(2)
+#define PMIC_NSLEEP_REG 0x86
+
+static void __maybe_unused k3_deassert_DDR_RET(void)
+{
+	struct udevice *pmica;
+	struct udevice *pmicb;
+	int regval;
+	int ret;
+
+	ret = uclass_get_device_by_name(UCLASS_PMIC,
+					"pmic@48", &pmica);
+	if (ret) {
+		printf("Getting PMICA init failed: %d\n", ret);
+		return;
+	}
+
+	ret = uclass_get_device_by_name(UCLASS_PMIC,
+					"pmic@4c", &pmicb);
+	if (ret) {
+		printf("Getting PMICB init failed: %d\n", ret);
+		return;
+	}
+	/* Set DDR_RET Signal Low on PMIC B */
+	regval = pmic_reg_read(pmicb, GPIO_OUT_1) & ~DDR_RET_VAL;
+
+	pmic_reg_write(pmicb, GPIO_OUT_1, regval);
+
+	/* Now toggle the CLK of the latch for DDR ret */
+	pmic_reg_write(pmicb, GPIO_OUT_1, regval | DDR_RET_CLK);
+	pmic_reg_write(pmicb, GPIO_OUT_1, regval & ~(DDR_RET_CLK));
+	pmic_reg_write(pmicb, GPIO_OUT_1, regval | DDR_RET_CLK);
+	pmic_reg_write(pmicb, GPIO_OUT_1, regval & ~(DDR_RET_CLK));
+
+	pmic_reg_write(pmica, PMIC_NSLEEP_REG, 0x3);
+}
+
+__weak bool j7xx_board_is_resuming(void)
+{
+	return false;
+}
+
 void board_init_f(ulong dummy)
 {
 	int ret;
 #if defined(CONFIG_K3_J721E_DDRSS) || defined(CONFIG_K3_LOAD_SYSFW)
+	struct k3_ddrss_regs regs;
 	struct udevice *dev;
 #endif
 	/*
@@ -410,6 +458,22 @@ void board_init_f(ulong dummy)
 	ret = uclass_get_device(UCLASS_RAM, 0, &dev);
 	if (ret)
 		panic("DRAM init failed: %d\n", ret);
+
+	if (j7xx_board_is_resuming()) {
+		/*
+		 * The DDR resume sequence is:
+		 * - exit DDR from retention
+		 * - de-assert the DDR_RET pin
+		 * - restore DDR max frequency
+		 * - exit DDR from low power
+		 */
+		k3_ddrss_lpddr4_exit_retention(dev, &regs);
+		k3_deassert_DDR_RET();
+		k3_ddrss_lpddr4_change_freq(dev);
+		k3_ddrss_lpddr4_exit_low_power(dev, &regs);
+
+		do_resume();
+	}
 #endif
 	spl_enable_cache();
 
-- 
2.47.3

