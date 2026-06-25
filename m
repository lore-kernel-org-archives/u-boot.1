Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBE1DCDB47F
	for <u-boot@archiver.kernel.org>; Thu, 25 Jun 2026 07:16:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0E16184987;
	Thu, 25 Jun 2026 09:15:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="Paj7X3TL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9D9CA847C8; Thu, 25 Jun 2026 09:15:31 +0200 (CEST)
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 93B1E80398
 for <u-boot@lists.denx.de>; Thu, 25 Jun 2026 09:15:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=richard.genoud@bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id 4D2EE4E408C9;
 Thu, 25 Jun 2026 07:15:29 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 217635FF03;
 Thu, 25 Jun 2026 07:15:29 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 32B71106C8449; 
 Thu, 25 Jun 2026 09:15:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1782371727; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding:in-reply-to:references;
 bh=d3RmSDdGDsY//nd7Ib9sx50532vyKSc5p5/8+r6sDKI=;
 b=Paj7X3TL5cg89l3yle5Tnffyg5r6T2lUSfNH3NTCEh0yJK58KClOh1c7A2E5mV6gzEoaWb
 H+guKDbh+8nvW5fQUEBvxU8lSv6tc+WlATlRqg1YmC8HbBbuvdwIWF5CtVI5Wkqu5pPvSR
 DooSBRyn64Rsnbvge73ATY16LyT/qZeTyuX0EVXKDrWeS9hE4JvUEHqR4CZVWPaoUPmxmO
 sRZCSEgRdEhtY6yvhzUhWfvGLTKWvtNpEmNmetP9xEWHQaCYE7MkBg17oyi72Vs+7YDaRf
 h0ARo1sWy137PDmgsvUCKiy8IUIog2VndNfZ7zMh/5f3tGPHnur+btkCtDuaNQ==
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
Subject: [PATCH v4 05/19] mach-k3: r5: common: introduce k3_deassert_ddr_ret()
Date: Thu, 25 Jun 2026 09:15:01 +0200
Message-ID: <20260625071515.91243-6-richard.genoud@bootlin.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260625071515.91243-1-richard.genoud@bootlin.com>
References: <20260625071515.91243-1-richard.genoud@bootlin.com>
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

Deasserting DDR retention pin is quite similar from J7200, J784s4,
J721e, and j721s2 SoCs.

Instead of duplicating almost the same code, add it in lpm-common.c.

NB: On J7200, there's a latch, so the clock needs to be toggled.

Signed-off-by: Richard Genoud (TI) <richard.genoud@bootlin.com>
---
 arch/arm/mach-k3/lpm-common.h    |  2 ++
 arch/arm/mach-k3/r5/lpm-common.c | 27 +++++++++++++++++++++++++++
 2 files changed, 29 insertions(+)

diff --git a/arch/arm/mach-k3/lpm-common.h b/arch/arm/mach-k3/lpm-common.h
index 2b360e6f03f3..2e3ea4428124 100644
--- a/arch/arm/mach-k3/lpm-common.h
+++ b/arch/arm/mach-k3/lpm-common.h
@@ -11,5 +11,7 @@
 
 void __noreturn do_resume(void);
 void lpm_process(void);
+void k3_deassert_ddr_ret(const char *pmic_name, unsigned int ddr_ret_val,
+			 unsigned int ddr_ret_clk, bool toggle);
 
 #endif
diff --git a/arch/arm/mach-k3/r5/lpm-common.c b/arch/arm/mach-k3/r5/lpm-common.c
index 95f777c5029f..afc6b5cf5376 100644
--- a/arch/arm/mach-k3/r5/lpm-common.c
+++ b/arch/arm/mach-k3/r5/lpm-common.c
@@ -41,6 +41,33 @@ struct lpm_addr_info {
 /* This is used by J722s */
 __weak void ctrl_mmr_unlock(void) { }
 
+#define GPIO_OUT_1 0x3D
+void k3_deassert_ddr_ret(const char *pmic_name, unsigned int ddr_ret_val,
+			 unsigned int ddr_ret_clk, bool toggle)
+{
+	struct udevice *pmic;
+	int regval;
+	int err;
+
+	err = uclass_get_device_by_name(UCLASS_PMIC, pmic_name, &pmic);
+	if (err) {
+		printf("Getting %s init failed: %d\n", pmic_name, err);
+		return;
+	}
+
+	/* Set DDR_RET Signal Low on PMIC */
+	regval = pmic_reg_read(pmic, GPIO_OUT_1) & ~ddr_ret_val;
+	pmic_reg_write(pmic, GPIO_OUT_1, regval);
+
+	if (toggle) {
+		/* Now toggle the CLK of the latch for DDR retention */
+		pmic_reg_write(pmic, GPIO_OUT_1, regval | ddr_ret_clk);
+		pmic_reg_write(pmic, GPIO_OUT_1, regval & ~ddr_ret_clk);
+		pmic_reg_write(pmic, GPIO_OUT_1, regval | ddr_ret_clk);
+		pmic_reg_write(pmic, GPIO_OUT_1, regval & ~ddr_ret_clk);
+	}
+}
+
 /* in board_init_f(), there's no BSS, so we can't use global/static variables */
 bool j7xx_board_is_resuming(void)
 {
