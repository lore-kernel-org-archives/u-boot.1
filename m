Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 506F4C3ABCB
	for <u-boot@archiver.kernel.org>; Mon, 12 May 2025 16:53:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0B08D80C83;
	Mon, 12 May 2025 18:53:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="j5XPfZFs";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="eF9Y3etC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8FB3582A25; Mon, 12 May 2025 18:53:29 +0200 (CEST)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org
 [IPv6:2001:67c:2050:0:465::201])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8E52E80584
 for <u-boot@lists.denx.de>; Mon, 12 May 2025 18:53:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4Zx5K32dqvz9sZg;
 Mon, 12 May 2025 18:53:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1747068807;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ELEN7ua9WpYZIPdeK8InCpCp0Q9fefEsTT24YYk0+ao=;
 b=j5XPfZFstgqGgAM5ZDBLZ3Tze4UpkCj/aAoHMvazH2XryfeoMM5jlskllW4a3uLZWyMoVn
 5OwUsiDbAqJ637UjGuuNarfFgkp2K4tXYgOhisMH8E5VtkHY0ppCzwpQzhH6v4w6kU/di5
 i5m4mmITBeRU5H8ZPFK31GIUB4E7pt6YT+EZJjV47gbrdvFMhgcN6d0egBbF89rXIV3NnZ
 9DKSus95MiWkBpJRtc6hlI/3WHUtS2pYRAYYHQ1SvTKXKgdZbgWY2fBNfQ1tRuLKDbGnlG
 CNlK9wW53Gp2461yjr8t6Z75nmbSSYNFJzqtEZuai7/vgU5wmgadTlMWw6yOlg==
From: Marek Vasut <marek.vasut@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1747068805;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ELEN7ua9WpYZIPdeK8InCpCp0Q9fefEsTT24YYk0+ao=;
 b=eF9Y3etCnti4eYOXIU1FLRE644oeuv3f7R8PCS0roaKW4WH/DNQtM//tn+Kq/H4z2YIsl+
 LGvkzq0SeKLVDj7O9lt3rKkDr6IvuLSKUp3qIotwY2u2k+Lf/R0KmOg/1h87Kjy4ZrnYYy
 KQZ66NkWr3Qwomx2nQIa+u6P9ROvOiFYby2KFhJhQ1j2BkjfIHVfYhyZL1zjBOgUtFyhIc
 HCd9B86DU9iUJLBr+7koIBicxxAxCYvU/jk5bgiWmmUNFnChbkPfTfauQt4utbO6Io6uE/
 8bntdlBPF9QVz5gwpp31sebYyUyTjSXcPKQ2Pqrt6KyqMrHsNSITpHkg3cuO1Q==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut@mailbox.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Janne Grunau <j@jannau.net>, Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Sam Edwards <cfsworks@gmail.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 2/2] spl: fit: Add ability to jump to Linux via OpTee-OS on
 ARMv7a
Date: Mon, 12 May 2025 18:52:13 +0200
Message-ID: <20250512165307.148434-2-marek.vasut@mailbox.org>
In-Reply-To: <20250512165307.148434-1-marek.vasut@mailbox.org>
References: <20250512165307.148434-1-marek.vasut@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: a078259a6e31ad2ad19
X-MBO-RS-META: ucuaiyc9bdqnw86bsnn1uyr1tm5f8uwq
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
 arch/arm/lib/spl.c   |  8 ++++++++
 common/spl/spl_fit.c | 20 ++++++++++++++++++++
 include/spl.h        |  3 +++
 3 files changed, 31 insertions(+)

diff --git a/arch/arm/lib/spl.c b/arch/arm/lib/spl.c
index c43a63f1819..f41a53f0ed2 100644
--- a/arch/arm/lib/spl.c
+++ b/arch/arm/lib/spl.c
@@ -16,6 +16,7 @@
 #include <asm/global_data.h>
 #include <linux/compiler.h>
 #include <asm/mach-types.h>
+#include <asm/armv7.h>
 
 #ifndef CONFIG_SPL_DM
 /* Pointer to as well as the global data structure for SPL */
@@ -72,6 +73,13 @@ void __noreturn jump_to_image_linux(struct spl_image_info *spl_image)
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
index 86506d6905c..294fb49b9e6 100644
--- a/common/spl/spl_fit.c
+++ b/common/spl/spl_fit.c
@@ -544,6 +544,23 @@ static int spl_fit_image_is_fpga(const void *fit, int node)
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
@@ -859,6 +876,9 @@ int spl_load_simple_fit(struct spl_image_info *spl_image,
 		    image_info.entry_point != FDT_ERROR)
 			spl_image->entry_point = image_info.entry_point;
 
+		spl_fit_image_record_arm32_optee(ctx.fit, node, spl_image,
+						 &image_info);
+
 		/* Record our loadables into the FDT */
 		if (!CONFIG_IS_ENABLED(FIT_IMAGE_TINY) &&
 		    xpl_get_fdt_update(info) && spl_image->fdt_addr)
diff --git a/include/spl.h b/include/spl.h
index 850c64d4b19..a51dfa4f494 100644
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

