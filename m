Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B860C7EE30
	for <u-boot@archiver.kernel.org>; Mon, 30 Jun 2025 00:09:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AF12F82F54;
	Mon, 30 Jun 2025 02:09:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="OJydOk28";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="WCJ6c1mO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C7B2A82E86; Mon, 30 Jun 2025 02:08:58 +0200 (CEST)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org
 [IPv6:2001:67c:2050:0:465::103])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A741D82C2F
 for <u-boot@lists.denx.de>; Mon, 30 Jun 2025 02:08:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4bVmjF2YLvz9sWm;
 Mon, 30 Jun 2025 02:08:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1751242129;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=R0hwD5MLKp6qPbWYILRXjTwvBLdzHSKllzVfO2Lx6XU=;
 b=OJydOk28mfgwHGMlScZTxvzcb7DsoUu7X4r6EusRQH605XbjJ7kHKmTPoIVFzCldju+I90
 UuDTsgcsb7lheEfEyCatnat5ymYZeVsNiKJ45NWQYjEo81NCA/h5ALGE99y2014z3ZWnaX
 kXQk0QdIiawJw4X37L76uUrvsJjF2WuQAxJM+tygW/u1kYuisUMmj2m+SmKu4rfwr/xNqn
 W4tPE+ngab8YAx+FOdlHZtf97qPELoPCtczMCq7GVFZFgY+Wm9vh54dwrpwfS9X29tOIWN
 qmD3wt8XoJGnybVgEoB88kZLfqr1XS/U2ir6uDiXUJLeEuxZqkjA0qE+p7+I/Q==
From: Marek Vasut <marek.vasut@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1751242127;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=R0hwD5MLKp6qPbWYILRXjTwvBLdzHSKllzVfO2Lx6XU=;
 b=WCJ6c1mOJpD0EWiws8HRj22mZ5MumGNCkdyVE8U18QWySRfSwirS8d8TSZIKVrPLAb5CuZ
 BkF83dqOTUUr2hAFqeVrjFs3t8MJvI6V3+99Zx7YWFrUpyeioPV53Peh/Zx26cl6e0A/2F
 Cf5IJA+2ke/XHNVJZl2Rk4I8dDnzO9mQo6B+/6s4EHclrKSpZogvRjTm1PdT1WQd9TVQB1
 vLoaWCPhss8HMN45TeKa4/OBb8uYpxqiZTF9ydOxOWJ0jqlvWIA+GF3AnnxGHLIkvO11Ux
 hiZUM4UsoKNCm1exm6C2aDOTojDeAX0boL2mml4qsmLMVcXINNND0m0smSMUZw==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut@mailbox.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Janne Grunau <j@jannau.net>, Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Sam Edwards <cfsworks@gmail.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 2/2] spl: fit: Add ability to jump to Linux via OpTee-OS on
 ARMv7a
Date: Mon, 30 Jun 2025 02:08:06 +0200
Message-ID: <20250630000832.952206-2-marek.vasut@mailbox.org>
In-Reply-To: <20250630000832.952206-1-marek.vasut@mailbox.org>
References: <20250630000832.952206-1-marek.vasut@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 620cc5208f9435c0b5a
X-MBO-RS-META: tyuh1rctraexeuucdkdabnjug4f4accm
X-Rspamd-Queue-Id: 4bVmjF2YLvz9sWm
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

Add support for jumping to Linux kernel through OpTee-OS on ARMv7a to SPL.
This is already supported on ARMv8a, this patch adds the ARMv7a support.
Extend the SPL fitImage loader to record OpTee-OS load address and in case
the load address is non-zero, use the same bootm-optee.S code used by the
U-Boot fitImage jump code to start OpTee-OS first and jump to Linux next.

Signed-off-by: Marek Vasut <marek.vasut@mailbox.org>
---
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Janne Grunau <j@jannau.net>
Cc: Mattijs Korpershoek <mkorpershoek@kernel.org>
Cc: Patrick Rudolph <patrick.rudolph@9elements.com>
Cc: Sam Edwards <cfsworks@gmail.com>
Cc: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
V2: Include armv7.h only on non-ARM64
---
 arch/arm/lib/spl.c   | 10 ++++++++++
 common/spl/spl_fit.c | 20 ++++++++++++++++++++
 include/spl.h        |  3 +++
 3 files changed, 33 insertions(+)

diff --git a/arch/arm/lib/spl.c b/arch/arm/lib/spl.c
index c43a63f1819..71e882b1f2c 100644
--- a/arch/arm/lib/spl.c
+++ b/arch/arm/lib/spl.c
@@ -16,6 +16,9 @@
 #include <asm/global_data.h>
 #include <linux/compiler.h>
 #include <asm/mach-types.h>
+#if defined(CONFIG_ARM) && !defined(CONFIG_ARM64)
+#include <asm/armv7.h>
+#endif
 
 #ifndef CONFIG_SPL_DM
 /* Pointer to as well as the global data structure for SPL */
@@ -72,6 +75,13 @@ void __noreturn jump_to_image_linux(struct spl_image_info *spl_image)
 	image_entry_arg_t image_entry =
 		(image_entry_arg_t)(uintptr_t) spl_image->entry_point;
 	cleanup_before_linux();
+#if defined(CONFIG_BOOTM_OPTEE) && defined(CONFIG_ARM) && !defined(CONFIG_ARM64)
+	if (spl_image->optee_addr)
+		boot_jump_linux_via_optee((void *)(spl_image->entry_point),
+					  machid,
+					  (u32)(spl_image->arg),
+					  spl_image->optee_addr);
+#endif
 	image_entry(0, machid, spl_image->arg);
 }
 #endif	/* CONFIG_ARM64 */
diff --git a/common/spl/spl_fit.c b/common/spl/spl_fit.c
index b3824af475f..7f4b780b6dd 100644
--- a/common/spl/spl_fit.c
+++ b/common/spl/spl_fit.c
@@ -545,6 +545,23 @@ static int spl_fit_image_is_fpga(const void *fit, int node)
 	return !strcmp(type, "fpga");
 }
 
+static void spl_fit_image_record_arm32_optee(const void *fit, int node,
+					     struct spl_image_info *spl_image,
+					     struct spl_image_info *image_info)
+{
+#if defined(CONFIG_BOOTM_OPTEE) && defined(CONFIG_ARM) && !defined(CONFIG_ARM64)
+	const char *type = fdt_getprop(fit, node, FIT_TYPE_PROP, NULL);
+
+	if (!type)
+		return;
+
+	if (strcmp(type, "tee"))
+		return;
+
+	spl_image->optee_addr = image_info->load_addr;
+#endif
+}
+
 static int spl_fit_image_get_os(const void *fit, int noffset, uint8_t *os)
 {
 	if (!CONFIG_IS_ENABLED(FIT_IMAGE_TINY) || CONFIG_IS_ENABLED(OS_BOOT))
@@ -898,6 +915,9 @@ int spl_load_simple_fit(struct spl_image_info *spl_image,
 		    image_info.entry_point != FDT_ERROR)
 			spl_image->entry_point = image_info.entry_point;
 
+		spl_fit_image_record_arm32_optee(ctx.fit, node, spl_image,
+						 &image_info);
+
 		/* Record our loadables into the FDT */
 		if (!CONFIG_IS_ENABLED(FIT_IMAGE_TINY) &&
 		    xpl_get_fdt_update(info) && spl_image->fdt_addr)
diff --git a/include/spl.h b/include/spl.h
index 7c10c7f792e..148299a5494 100644
--- a/include/spl.h
+++ b/include/spl.h
@@ -288,6 +288,9 @@ struct spl_image_info {
 	ulong entry_point;
 #if CONFIG_IS_ENABLED(LOAD_FIT) || CONFIG_IS_ENABLED(LOAD_FIT_FULL)
 	void *fdt_addr;
+#endif
+#if defined(CONFIG_BOOTM_OPTEE) && defined(CONFIG_ARM) && !defined(CONFIG_ARM64)
+	ulong optee_addr;
 #endif
 	u32 boot_device;
 	u32 offset;
-- 
2.47.2

