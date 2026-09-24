Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C330C9831A
	for <u-boot@archiver.kernel.org>; Thu, 24 Sep 2026 12:36:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4229381DE0;
	Thu, 24 Sep 2026 12:36:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id h6DZVu4WUUKi; Thu, 24 Sep 2026 12:36:37 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 5D36A81DCA
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790253397;
	b=CgnSKk9nKcg19pGKxx5PVqDHp+NZCfjamUB5x28Y6LKNkYRE2pb93AS5UMXaY8AgaAIB
	 QQL1L9xXs+VnZw6hKppiuKsaDeD2dLfdgm+MFEvQYloUinfpYFltDc4BxRmZADAzljpSB
	 Rq1pb9di4jY3lwC2gE2/XL9gUrtJ+Q3buaxSBXdA39wu85gQ2TNpCDV1zyU8HlISBIhzJ
	 sw/a/Ciy63DMlCchVsq5ATBXTaz0+wSHmKzQLYYc7Y4I7vW1IRRfUR1YwoDcgWhMso8YS
	 X2GijgxQ+2XOaFWHOojOJ59S5XDOqgXPLgK0u0v51vWM60rVPUJKZdKmoG8fM1l1+pA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790253397;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Last-TLS-Session-Version:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=/YIoPtxxJcmyJ73yNbnHstOxSrI5gyjhS54L2mFd2Y4=;
	b=ioo0fW9G3tMVJ92FbtEkbgQHwllK8FyTNilIw1cU1ymtw8YVbSgk0IFlU1SKJUklVLDq
	 tWVmJ5qd/n7L3ItDfScyCP8NZRC0qF8bsMjMTODxkFVzIm6ppJrFXIVLNHecSyf5N/OH2
	 AhQiskWmGb9lWkIyWEv7nZvtJai1o9NWhibcnV7e3FpnUkG2Hjz9d+xl/sB0y91Vq9L7/
	 yvSgSeXfSWb9lacRUI0jHibZVm+HY7OYJtVcaBAynmAuE//+gICkWwdYdITfFmBhmTSL+
	 c7HLurnnIHXVZQaoseTuuIXxpwAFAmclOlDW34DI+3HPfsMx0pEZCeMw9mRXSYobKfg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790253397;
	bh=/YIoPtxxJcmyJ73yNbnHstOxSrI5gyjhS54L2mFd2Y4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=LFvcKz3msMx6D1+N7C0Q24hRUvddqIvFQwbvBxR7i8JSoTjf2+zchWYtGWIxF1zJ8
	 SSuG57QLv7y8lfWpPMgXiCuha6+/YhzVOK/afazBnEorfmF2RgnUmL7vdOF17RpvTu
	 nzVhZfa0sax9zlUJdIv6IHTUzU+6zFKrLmUsC1avEiky6luljnHoZjwtsE739xncMv
	 xV5l32FO9aVxluX0BjhrpnDuSpSh6go7YWU/4fGgjxVhtUVQSU5lAVbetGU2WplZIE
	 gk3ng9QzgbtTCYI5trm93pJGPG2F2VEhJAqKWRSsMFGCjh3ruZrZgL6y59ZjT9shoQ
	 raDWb0svjAt2w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5D36A81DCA;
	Thu, 24 Sep 2026 12:36:37 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 2D58835A
 for <u-boot@lists.u-boot-project.org>; Thu, 24 Sep 2026 12:36:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 1F34740470
 for <u-boot@lists.u-boot-project.org>; Thu, 24 Sep 2026 12:36:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9k3Hx2bmYIQh for <u-boot@lists.u-boot-project.org>;
 Thu, 24 Sep 2026 12:36:35 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 2AF2B400FB
Authentication-Results: smtp2.osuosl.org; arc=none smtp.remote-ip=185.246.84.56
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790253395;
 b=lFKcO0Na3s3DX4xfaD5CZEWRsstIOfCPdVV6mMgvAwJyBbzaxPz/ZMYeKv3atUzo0Ce2
 KrO+mMceLR27I6Lk4tzTWvuXietaSJKX6oipTMSHC0E5TvycvTqrEIYd11ryFCLMwICF9
 N2+iJx+9GjTHpeUe+AfXVCBDARPWxIkiWse4JD1UiNZA/MEzeymvuKTL6TbqxgO/dslpv
 IfoRD4u6L5pSDEKUssMqpeHfkCxePrqrs3g0uszNVVuqFLoIC/+Olm3FP46t2Iz3Ztgqz
 amEZDN5G8ZRiy0p5LuwPlZtlo/XC4WBStiJxwK1gWcOUm6XFZgydoh2c7Q0YtNviAow==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790253395;
 h=Received-SPF:Received:Received:Received:DKIM-Signature:From:To:Cc:
 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:X-Last-TLS-Session-Version;
 bh=/YIoPtxxJcmyJ73yNbnHstOxSrI5gyjhS54L2mFd2Y4=;
 b=Yo6ZqQGbjzH1buSLH4DfOy0jyf2akLAi85w3x3eKNrobFC2IlGisy1CfiLOMtP+4Neob
 kr5Xph2fvTXATEcROyGswYoDJGluFAF6T6Tot6jecmD+UjIcQD7apcldfRP59qKUj4oxZ
 Vfzf6EuCpisTskM7SKELKqNPsMQj9px53bK/0aQwgV4fM/+4ZjpCef7YoRbLQPnHPq6By
 loXg4CdLJuufzmRqjmC1UWmXei8XiDZxMslikTMuZQ1Cv+cEcKXULjJCLxnPg5uzZaS0g
 IZ690Av+QInACbqw65D4ndMhvj8t/7rp+qr6h+wNWtB7NFR1K+JmbNf8yhIzBtSP0vQ==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=bootlin.com; 
 dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256
 header.s=dkim header.b=Bgh9pAz2; 
 arc=none smtp.remote-ip=185.246.84.56
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.246.84.56;
 helo=smtpout-02.galae.net; envelope-from=richard.genoud@bootlin.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com
 header.a=rsa-sha256 header.s=dkim header.b=Bgh9pAz2
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 2AF2B400FB
 for <u-boot@lists.u-boot-project.org>; Thu, 24 Sep 2026 12:36:35 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-02.galae.net (Postfix) with ESMTPS id 6C5021A1000;
 Thu, 24 Sep 2026 12:36:33 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 3CF2960341;
 Thu, 24 Sep 2026 12:36:33 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 0D3F610329477; 
 Thu, 24 Sep 2026 14:36:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1790253391; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding:in-reply-to:references;
 bh=/YIoPtxxJcmyJ73yNbnHstOxSrI5gyjhS54L2mFd2Y4=;
 b=Bgh9pAz2O5f0E92EevPA/NgUQ+N6wLY4IwUbTbDkkLJQWLI9FviilbXXIlm8H8Fy3AxhYt
 pOzHZ/9aeeE+gfbK8z4C6dXwgPa0+mWQsRcXcIW9K1pM7K8LCZDEd9HyQS8Xab4JUk407N
 wR9yXNMz7hEAvERSE38kJ173ObjIJDn+4yR+3zL3+sTQKO4+xB4iF/1FWoSXkK3Pn1mzpP
 Qr+5d0lKYdYMYHaS/Y0p8mQuu0O6vw6HfnTm/K5nWOH+Dyb4A1drss6YX1DSQOqfKR/phO
 OeDdrBhfE+S0xFojSm70vUbT7YtWmf0EzgSmRWjlJ3zYH48U9HJyh1uAB1fhSw==
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
Subject: [PATCH v6 09/22] board: evm: Enable de-isolation of IOs at resume for
 j7200 and j784s4
Date: Thu, 24 Sep 2026 14:35:20 +0200
Message-ID: <20260924123533.2599438-10-richard.genoud@bootlin.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260924123533.2599438-1-richard.genoud@bootlin.com>
References: <20260924123533.2599438-1-richard.genoud@bootlin.com>
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
index 881392bd963a..489b705e57e3 100644
--- a/board/ti/j721e/evm.c
+++ b/board/ti/j721e/evm.c
@@ -17,6 +17,7 @@
 #include <spl.h>
 #include <dm.h>
 #include <asm/arch/k3-ddr.h>
+#include <wait_bit.h>
 
 #include "../common/board_detect.h"
 #include "../common/fdt_ops.h"
@@ -469,6 +470,30 @@ err_free_gpio:
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
-- 
2.55.0

