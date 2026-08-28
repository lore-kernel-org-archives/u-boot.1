Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85C68C61DD3
	for <u-boot@archiver.kernel.org>; Fri, 28 Aug 2026 13:58:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4F58880F95;
	Fri, 28 Aug 2026 13:58:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id rG_fxWGj9R0f; Fri, 28 Aug 2026 13:58:42 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787925522;
	bh=DF8pZQBfy393JEbkLXnzgCQUuHX6bkQ3boDr0nsLF48=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=X2CnY9ywfTz9SwzB0ycKJ12FWVfu3PX71HKX5GmX0ciVzEcimH2o5WIZjTxTMFmET
	 dC8cuU+bs7XRgOhQbBQAbZli1GBUnU2P/khKdFJ7f0e+sqf0g8mgf/YYbI5HzafI/9
	 BMEamsmD2RSzHm5cRLIHkBlDdc/pW9/j3Y/lDxDbzpu0ytz5ndZIULtQ0niJGmJ0+t
	 NSFHPawuvspxQ4rTks9tpgA4sH2AXw+RURYQBAwvu0uKB1KhiVd/uoaG5ksUHA9YXg
	 oEGZz3K/xncJAUn681GHsbRcS6fH+O25brWdbT71IKMHvuorTY9cumRk1UZForWxUI
	 fvwc+h8kcWq8g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id BF3DF80F34;
	Fri, 28 Aug 2026 13:58:42 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 94F85334
 for <u-boot@lists.u-boot-project.org>; Fri, 28 Aug 2026 13:58:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 77F6240875
 for <u-boot@lists.u-boot-project.org>; Fri, 28 Aug 2026 13:58:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zp4RiBB9XAmO for <u-boot@lists.u-boot-project.org>;
 Fri, 28 Aug 2026 13:58:38 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.246.84.56;
 helo=smtpout-02.galae.net; envelope-from=richard.genoud@bootlin.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com
 header.a=rsa-sha256 header.s=dkim header.b=fiOOEx0s
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 05C2C4088B
 for <u-boot@lists.u-boot-project.org>; Fri, 28 Aug 2026 13:58:37 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-02.galae.net (Postfix) with ESMTPS id 27E891A18A3;
 Fri, 28 Aug 2026 13:58:36 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id E8CE860537;
 Fri, 28 Aug 2026 13:58:35 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 2DD7111C78068; 
 Fri, 28 Aug 2026 15:58:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1787925514; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding:in-reply-to:references;
 bh=DF8pZQBfy393JEbkLXnzgCQUuHX6bkQ3boDr0nsLF48=;
 b=fiOOEx0sZPC1M7Q1M+8rfAjqWFxBUZY/HUxIvSpTTL1MI0T634ubKiQ0U6CsYlAAjgWjFd
 kcEf5zhrBsfrTN1Pk4o0ypZuCevzjR3C77mPrdUY4Bm45KkqOqKbL3MiQfxormrJwgkqWm
 QvXr15LZDuPhFM1a3XUMmDt765vUPikJf+gyTihw++mIPqFSH9vywme8NxJ/Ll0XhOTB0l
 YbO6Zry9JrpE0NrCD0QQgMu5PRaBp00V+qI5sbQPwShW1pwnRaXdMpQXSwDUzCJiSZAkBT
 FvrOquMSVbElOA1e8FerSz0pEePBIfkcQNCoyNClUWgEDJb3HimcaT15KQKUvA==
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
 Richard Genoud <richard.genoud@bootlin.com>,
 u-boot@lists.u-boot-project.org
Subject: [PATCH v5 15/21] arm: mach-k3: j721e: Enable LPM resume flow for
 J7200/J721e SOC
Date: Fri, 28 Aug 2026 15:57:24 +0200
Message-ID: <20260828135730.1565643-16-richard.genoud@bootlin.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260828135730.1565643-1-richard.genoud@bootlin.com>
References: <20260828135730.1565643-1-richard.genoud@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

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
 arch/arm/mach-k3/j721e/j721e_init.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/arm/mach-k3/j721e/j721e_init.c b/arch/arm/mach-k3/j721e/j721e_init.c
index f9af0288cf66..fce6702be687 100644
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
@@ -46,6 +49,10 @@
 #define DEV_A72SS0_CORE0_ID 4
 #define DEV_A72SS0_CORE0_MSMC_CLK_ID 1
 
+/* DDR retention bits */
+#define DDR_RET_VAL BIT(1)
+#define DDR_RET_CLK BIT(2)
+
 #ifdef CONFIG_K3_LOAD_SYSFW
 struct fwl_data cbass_hc_cfg0_fwls[] = {
 #if defined(CONFIG_SOC_K3_J721E)
@@ -298,6 +305,7 @@ void board_init_f(ulong dummy)
 {
 	int ret;
 #if defined(CONFIG_K3_J721E_DDRSS) || defined(CONFIG_K3_LOAD_SYSFW)
+	struct k3_ddrss_regs regs;
 	struct udevice *dev;
 #endif
 	/*
@@ -410,6 +418,22 @@ void board_init_f(ulong dummy)
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
+		k3_deassert_ddr_ret("pmic@4c", DDR_RET_VAL, DDR_RET_CLK, true);
+		k3_ddrss_lpddr4_change_freq(dev);
+		k3_ddrss_lpddr4_exit_low_power(dev, &regs);
+
+		do_resume();
+	}
 #endif
 	spl_enable_cache();
 
