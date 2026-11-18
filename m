Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C638606A31C
	for <u-boot@archiver.kernel.org>; Wed, 18 Nov 2026 13:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=M1SKH9Sw;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=23YNaS+p
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 26A798127B;
	Wed, 18 Nov 2026 13:18:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id huVrCthJ6h2c; Wed, 18 Nov 2026 13:18:54 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 372A2811FC
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795007934;
	b=f16eHf7iuyEquld7ZohbyrcyvVLvIZOAyXHmcwPZFHHar2DWf8jEM49oczUdjcBdVjUB
	 NIDN9vxhFENzyGDfgeq1lR8quUGnyihPfikbIq7CZDtLxG8zMuxGY1P/5gt+VIedrFXgP
	 1O3rOXw9Ocaw9z0ArbF8+OFqQjcq4gcCSl5knu3qbQEO1kIabFaYNQF5JUUnspWQhSrZd
	 7XggeauPrjwhqtGjW/NzE2cd8Ajd19eaW7sM9fw2SrLK/X/DGexGt6now+fO42pjHSwmz
	 VdUT5/1WmJaO4NpZO5zER9yMAU7HmDvOYMz9NdYFoiNzgzD/kkTck2XtF9+HI13Nv2g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795007934;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Last-TLS-Session-Version:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=Q+/R/B/m+GbcTw09enjt+JinMewIw2AKR+v7nQI15Q0=;
	b=SYPc6qACyGiHDFVNBfVhdnsH6XB0SH+NCf0ckjELRZsGaLTdFr1op18owNFwF797ATYZ
	 2Ks3hq9fRhwi/8//UHhuVZJL0vLOdJk94joO1mavP+4AUuhTm+qpExu8aNI408agffHbg
	 KE6wbB4bFSab0+OVOfHmj++937bCYf81pYjwvC5jkd78XVjo8Zzov2V1OfHdTqC1vf2HB
	 a5ocRdaTiT/o/en6YTU0J8OTDXd84tORFhrg5SulcQtLTsV57BMn8uJB/VfAPLHM+hnrE
	 am0tE+/1o1rysPRzX1sUMZfqXkcwuk3rm48HPCEf8/NXahZcEtOSoNtRyTz2BwgeJWA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795007934;
	bh=Q+/R/B/m+GbcTw09enjt+JinMewIw2AKR+v7nQI15Q0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=M1SKH9SwigNmx9barImHFTZZZuFAMaBelUbvOTxO5VFpM+tcR/uqCJTaMzrG7RErN
	 UnO9MhnclIBPUt8+stjFmZdstQjPMshSRLvNKJWgHyZmgN032DtElXQlQQYPtsslw3
	 HLgY1gCv6k3e5aqSWCGDdRBVFvi466qF4BvTLIw9CSpuMmWP4RuVEM/0+GlmOSLA1B
	 QQ7ngEVPNji4ECpJfLt9V0JIoU3yD75yl8DnWVjGsNPuVSgDxl/UdgkKBt7r2gVZyW
	 NOjcAOntV1g7Ak/mpPiKLObSvnoHiZbVRNJ6t0ziHM5So5kiH9nEppyWIpOKZ0fH2v
	 bw5nGwXvx5hsQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 372A2811FC;
	Wed, 18 Nov 2026 13:18:54 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id C983261
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 13:18:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id C768740481
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 13:18:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dZIL3BrjxXmG for <u-boot@lists.u-boot-project.org>;
 Wed, 18 Nov 2026 13:18:51 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 9CF0040060
Authentication-Results: smtp2.osuosl.org; arc=none smtp.remote-ip=185.246.84.56
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.246.84.56;
 helo=smtpout-02.galae.net; envelope-from=richard.genoud@bootlin.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com
 header.a=rsa-sha256 header.s=dkim header.b=23YNaS+p
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 9CF0040060
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 13:18:50 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-02.galae.net (Postfix) with ESMTPS id A45071A16D0;
 Wed, 18 Nov 2026 13:18:48 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 69DE55FE9B;
 Wed, 18 Nov 2026 13:18:48 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id CF8AE11BC1F9E; Wed, 18 Nov 2026 14:18:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1795007927; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding:in-reply-to:references;
 bh=Q+/R/B/m+GbcTw09enjt+JinMewIw2AKR+v7nQI15Q0=;
 b=23YNaS+pE+hr173qpNa8HJtOS0rkPQdJr/VNAyxShh8MIiRwYQzOVn/NgwG9WWLmpQXpFj
 GcTaqvb+QBlWZCzEV9N/LGOKxrCVDaD6E4kGyMJqycEpxHHZZ3Ci3A5hows8vJMqZHO1g+
 +QM/xaaDHk6Ok80BsYGj5/sTo9eF2FV67Bs/duzu6glCoTOIL5EucT+y0zfVkTfXYMwivC
 BpzaQMu7G22ZNkxLGcFiTxsJxEXu1aimlnRDS56zT4oJy2Yt7ogUdcKbGBFvXvls+uqK4C
 w9W9I8P5gYeY6fvJUZVqGk1xiRR4Skgp0KhA6A2Y9vQ6H0dFX/CzemQLAfWPTg==
From: "Richard Genoud (TI)" <richard.genoud@bootlin.com>
To: Tom Rini <trini@konsulko.com>, Manorit Chawdhry <m-chawdhry@ti.com>,
 "Andrew F . Davis" <afd@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
 Bryan Brattlof <bb@ti.com>, Simon Glass <sjg@chromium.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>
Cc: Markus Schneider-Pargmann <msp@baylibre.com>,
 Kendall Willis <k-willis@ti.com>, Udit Kumar <u-kumar1@ti.com>,
 Abhash Kumar <a-kumar2@ti.com>,
 Thomas Richard <thomas.richard@bootlin.com>,
 Gregory CLEMENT <gregory.clement@bootlin.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Richard Genoud <richard.genoud@bootlin.com>,
 u-boot@lists.u-boot-project.org
Subject: [PATCH v7 07/20] board: evm: Enable de-isolation of IOs at resume for
 j7200 and j784s4
Date: Wed, 18 Nov 2026 14:17:54 +0100
Message-ID: <20261118131807.135859-8-richard.genoud@bootlin.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261118131807.135859-1-richard.genoud@bootlin.com>
References: <20261118131807.135859-1-richard.genoud@bootlin.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Abhash Kumar Jha <a-kumar2@ti.com>

In IO_ONLY_PLUS_DDR low power mode, the DDR is in self refresh, and the
SoC is powered off except wake-up IOs.

When resuming from IO_ONLY_PLUS_DDR low power mode, the IOs are
isolated. Remove that isolation in resume sequence.

On j7200, The canuart IOs are isolated whereas on j784s4, the
mcu_general IOs are isolated.

Signed-off-by: Abhash Kumar Jha <a-kumar2@ti.com>
Co-developed-by: Richard Genoud (TI) <richard.genoud@bootlin.com>
Signed-off-by: Richard Genoud (TI) <richard.genoud@bootlin.com>
---
 .../arm/mach-k3/include/mach/j721e_hardware.h | 11 ++++++++
 .../mach-k3/include/mach/j784s4_hardware.h    | 10 ++++++++
 arch/arm/mach-k3/r5/lpm-common.c              | 16 ++++++++++++
 board/ti/j721e/evm.c                          | 25 +++++++++++++++++++
 board/ti/j784s4/evm.c                         | 24 ++++++++++++++++++
 5 files changed, 86 insertions(+)

diff --git a/arch/arm/mach-k3/include/mach/j721e_hardware.h b/arch/arm/mach-k3/include/mach/j721e_hardware.h
index 5bef309af0a4..e6e437af4ec0 100644
--- a/arch/arm/mach-k3/include/mach/j721e_hardware.h
+++ b/arch/arm/mach-k3/include/mach/j721e_hardware.h
@@ -14,6 +14,17 @@
 #define WKUP_CTRL_MMR0_BASE				0x43000000
 #define MCU_CTRL_MMR0_BASE				0x40f00000
 #define CTRL_MMR0_BASE					0x00100000
+#define DMSC_PWRCTRL_BASE				0x44130000
+
+#define PMCTRL_IO_1					(DMSC_PWRCTRL_BASE + 0x88)
+#define PMCTRL_IO_LPM					PMCTRL_IO_1
+#define CANUART_WAKE_CTRL				0x18300
+#define CANUART_WAKE_STAT0				0x18308
+#define CANUART_WAKE_STAT1				0x1830C
+
+#define IO_ISO_MAGIC_VAL				0x55555554
+#define CANUART_WAKE_STAT1_CANUART_IO_MODE		BIT(0)
+#define DEISOLATION_TIMEOUT_MS				10
 
 #define CTRLMMR_MAIN_DEVSTAT				(CTRL_MMR0_BASE + 0x30)
 #define MAIN_DEVSTAT_BOOT_MODE_B_MASK		BIT(0)
diff --git a/arch/arm/mach-k3/include/mach/j784s4_hardware.h b/arch/arm/mach-k3/include/mach/j784s4_hardware.h
index 29a894baed34..033ae153d674 100644
--- a/arch/arm/mach-k3/include/mach/j784s4_hardware.h
+++ b/arch/arm/mach-k3/include/mach/j784s4_hardware.h
@@ -15,6 +15,16 @@
 #define MCU_CTRL_MMR0_BASE				0x40f00000
 #define CTRL_MMR0_BASE					0x00100000
 
+#define PMCTRL_IO_0					(WKUP_CTRL_MMR0_BASE + 0x14084)
+#define PMCTRL_IO_LPM					PMCTRL_IO_0
+#define MCU_GEN_WAKE_CTRL				0x18310
+#define MCU_GEN_WAKE_STAT0				0x18318
+#define MCU_GEN_WAKE_STAT1				0x1831C
+
+#define IO_ISO_MAGIC_VAL				0x55555554
+#define MCU_GEN_WAKE_STAT1_MCU_GEN_IO_MODE		BIT(0)
+#define DEISOLATION_TIMEOUT_MS				10
+
 #define CTRLMMR_MAIN_DEVSTAT				(CTRL_MMR0_BASE + 0x30)
 #define MAIN_DEVSTAT_BOOT_MODE_B_MASK			BIT(0)
 #define MAIN_DEVSTAT_BOOT_MODE_B_SHIFT			0
diff --git a/arch/arm/mach-k3/r5/lpm-common.c b/arch/arm/mach-k3/r5/lpm-common.c
index f949ff0904ed..96306f307973 100644
--- a/arch/arm/mach-k3/r5/lpm-common.c
+++ b/arch/arm/mach-k3/r5/lpm-common.c
@@ -6,6 +6,7 @@
  * Copyright (C) 2026 Bootlin
  */
 
+#include <asm/arch/hardware.h>
 #include <clk.h>
 #include <dm/device.h>
 #include <dm/read.h>
@@ -26,6 +27,8 @@
 /* PMIC register where the magic value resides */
 #define K3_LPM_SCRATCH_PAD_REG_3 0xcb
 
+#define IO_ISO_STATUS BIT(25)
+
 #define CONTEXT_SAVE_SZ	0x80000
 #define ATF_CERT_SZ	0x80000
 #define OPTEE_CERT_SZ	0x100000
@@ -46,6 +49,8 @@ enum k3_resume_state {
 	K3_RESUME_STATE_RESUMING
 };
 
+__weak void clear_isolation(void) { }
+
 #define GPIO_OUT_1 0x3D
 void k3_deassert_ddr_ret(const char *pmic_name, unsigned int ddr_ret_val,
 			 unsigned int ddr_ret_clk, bool toggle)
@@ -77,11 +82,22 @@ bool j7xx_board_is_resuming(void)
 {
 	static enum k3_resume_state k3_resuming;
 	struct udevice *pmic;
+	u32 pmctrl_val = 0;
 	int ret, magic;
 
 	if (k3_resuming != K3_RESUME_STATE_UNKNOWN)
 		goto end;
 
+#ifdef PMCTRL_IO_LPM
+	pmctrl_val = readl(PMCTRL_IO_LPM);
+#endif
+	if ((pmctrl_val & IO_ISO_STATUS) == IO_ISO_STATUS) {
+		clear_isolation();
+		k3_resuming = K3_RESUME_STATE_RESUMING;
+		debug("board is resuming from IO_DDR mode\n");
+		goto end;
+	}
+
 	ret = uclass_get_device_by_name(UCLASS_PMIC,
 					"pmic@48", &pmic);
 	if (ret) {
diff --git a/board/ti/j721e/evm.c b/board/ti/j721e/evm.c
index 8e2b8f3d47da..f9dc71183023 100644
--- a/board/ti/j721e/evm.c
+++ b/board/ti/j721e/evm.c
@@ -17,6 +17,7 @@
 #include <spl.h>
 #include <dm.h>
 #include <asm/arch/k3-ddr.h>
+#include <wait_bit.h>
 
 #include "../common/board_detect.h"
 #include "../common/fdt_ops.h"
@@ -472,6 +473,30 @@ err_free_gpio:
 	}
 }
 
+#if (IS_ENABLED(CONFIG_SPL_BUILD) && IS_ENABLED(CONFIG_TARGET_J7200_R5_EVM))
+
+void clear_isolation(void)
+{
+	int ret;
+	const void *wait_reg = (const void *)(WKUP_CTRL_MMR0_BASE + CANUART_WAKE_STAT1);
+
+	/* un-set the magic word for canuart IOs */
+	writel(IO_ISO_MAGIC_VAL, WKUP_CTRL_MMR0_BASE + CANUART_WAKE_CTRL);
+	writel((IO_ISO_MAGIC_VAL + 0x1), WKUP_CTRL_MMR0_BASE + CANUART_WAKE_CTRL);
+	writel(IO_ISO_MAGIC_VAL, WKUP_CTRL_MMR0_BASE + CANUART_WAKE_CTRL);
+
+	/* wait for CANUART_IO_MODE bit to be cleared */
+	ret = wait_for_bit_32(wait_reg,
+			      CANUART_WAKE_STAT1_CANUART_IO_MODE,
+			      false,
+			      DEISOLATION_TIMEOUT_MS,
+			      false);
+	if (ret < 0)
+		panic("Deisolation timeout");
+}
+
+#endif /* CONFIG_SPL_BUILD && CONFIG_TARGET_J7200_R5_EVM */
+
 void spl_board_init(void)
 {
 	struct udevice *dev;
diff --git a/board/ti/j784s4/evm.c b/board/ti/j784s4/evm.c
index 8a4d40a5a959..5e9b9944a15f 100644
--- a/board/ti/j784s4/evm.c
+++ b/board/ti/j784s4/evm.c
@@ -11,7 +11,9 @@
 #include <efi_loader.h>
 #include <init.h>
 #include <spl.h>
+#include <asm/arch/hardware.h>
 #include <asm/arch/k3-ddr.h>
+#include <wait_bit.h>
 #include "../common/fdt_ops.h"
 
 struct efi_fw_image fw_images[] = {
@@ -59,6 +61,28 @@ int board_late_init(void)
 }
 #endif
 
+#if (IS_ENABLED(CONFIG_SPL_BUILD) && IS_ENABLED(CONFIG_TARGET_J784S4_R5_EVM))
+void clear_isolation(void)
+{
+	int ret;
+	const void *wait_reg = (const void *)(WKUP_CTRL_MMR0_BASE + MCU_GEN_WAKE_STAT1);
+
+	/* un-set the magic word for MCU_GENERAL IOs */
+	writel(IO_ISO_MAGIC_VAL, WKUP_CTRL_MMR0_BASE + MCU_GEN_WAKE_CTRL);
+	writel((IO_ISO_MAGIC_VAL + 0x1), WKUP_CTRL_MMR0_BASE + MCU_GEN_WAKE_CTRL);
+	writel(IO_ISO_MAGIC_VAL, WKUP_CTRL_MMR0_BASE + MCU_GEN_WAKE_CTRL);
+
+	/* wait for MCU_GEN_IO_MODE bit to be cleared */
+	ret = wait_for_bit_32(wait_reg,
+			      MCU_GEN_WAKE_STAT1_MCU_GEN_IO_MODE,
+			      false,
+			      DEISOLATION_TIMEOUT_MS,
+			      false);
+	if (ret < 0)
+		panic("Deisolation timeout");
+}
+#endif /* CONFIG_SPL_BUILD && CONFIG_TARGET_J784s4_R5_EVM */
+
 void spl_board_init(void)
 {
 	struct udevice *dev;
