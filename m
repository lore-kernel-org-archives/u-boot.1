Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E083ECCF9F0
	for <u-boot@archiver.kernel.org>; Thu, 30 Oct 2025 21:24:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E4AC783893;
	Thu, 30 Oct 2025 22:24:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="DWtdFnzS";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="EsVLvoi5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CB201836F0; Thu, 30 Oct 2025 22:24:12 +0100 (CET)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BD928836F0
 for <u-boot@lists.denx.de>; Thu, 30 Oct 2025 22:24:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4cyHDV3Wc6z9tkP;
 Thu, 30 Oct 2025 22:24:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1761859450;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Wo7BAcY1ngvNkBwrFWoeeu6RyxCMaeeLs+IbLGIocz8=;
 b=DWtdFnzSrndkjPjpvt7Mlp/zLpUT8/+dy4LswVafTp2fgbt6dds/smKL/WTwSTNNV0M7//
 BHZ6PfbOrPH44peexAOKAgafK49dN1Jc5NPG3v+RRxJpuMLofeuDeau/bUjOzf5iYsXtp9
 zGlGz6+KMKnSc880ILju04oN23WcTmUVRuML0LXRymX8mSIha1Ro/kYtlieIhzBgHtfmya
 qoyZyv/tjGx/einh1tj+fnnsLDKBAnKZJM5lEjHbWuYberEIvnEkP6LWEIKhXgw2VEk1n7
 lIWp1QJmvds4ljnNTHCrZhNmoatTvvHS1D72aiAcZinJXMFnV7fxYSUrDQiHjw==
Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=EsVLvoi5;
 spf=pass (outgoing_mbo_mout: domain of marek.vasut@mailbox.org designates
 2001:67c:2050:b231:465::1 as permitted sender)
 smtp.mailfrom=marek.vasut@mailbox.org
From: Marek Vasut <marek.vasut@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1761859448;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Wo7BAcY1ngvNkBwrFWoeeu6RyxCMaeeLs+IbLGIocz8=;
 b=EsVLvoi5FgFGnIJGI3+4xPOBgDKdRazmj5dD4My5STv2bgalkC5YeY7REAmPDrhSotwfuJ
 7lgKnQAbyU4AZOQ2haL49RJ/Wash2MYXdeO8FnRsv+ntp1k+xRK3rdXNPOma+uP02R64yM
 7IwKxTzW5npR1awkXYdILlVlVQdi+8ea56SKojE6IBzAAk4KC7lqY2QR0DRDTROrgHZYw3
 PehUF65KKp5YkiBwbZmbcBbxgF+bMel1eIMDilLmCwiWUSppl2oTHpPaM/Mc//EkKfDiLF
 fFwEAa4ye/1AVyJ2c/VZIqPguZYtu1oBjoqksS+SYcDF9oyw3J7Y4HzEEkToyQ==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut@mailbox.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Janne Grunau <j@jannau.net>, Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Sam Edwards <cfsworks@gmail.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v4 2/2] spl: fit: Add ability to jump to Linux via OPTEE-OS on
 ARMv7a
Date: Thu, 30 Oct 2025 22:23:50 +0100
Message-ID: <20251030212359.12824-2-marek.vasut@mailbox.org>
In-Reply-To: <20251030212359.12824-1-marek.vasut@mailbox.org>
References: <20251030212359.12824-1-marek.vasut@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: ea82957315ff6fc51ca
X-MBO-RS-META: be73u8fphgy1qtj3j4bdmt16oqx8sprj
X-Rspamd-Queue-Id: 4cyHDV3Wc6z9tkP
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

Add support for jumping to Linux kernel through OPTEE-OS on ARMv7a to SPL.
This is already supported on ARMv8a, this patch adds the ARMv7a support.
Extend the SPL fitImage loader to record OPTEE-OS load address and in case
the load address is non-zero, use the same bootm-optee.S code used by the
U-Boot fitImage jump code to start OPTEE-OS first and jump to Linux next.

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
V3: No change
V4: s@OpTee-OS@OPTEE-OS@
---
 arch/arm/lib/spl.c   | 10 ++++++++++
 common/spl/spl_fit.c | 20 ++++++++++++++++++++
 include/spl.h        |  3 +++
 3 files changed, 33 insertions(+)

diff --git a/arch/arm/lib/spl.c b/arch/arm/lib/spl.c
index 6c7d1fb5629..bce51b9cc7d 100644
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
@@ -71,6 +74,13 @@ void __noreturn jump_to_image_linux(struct spl_image_info *spl_image)
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
index 746c3d2fa28..616df46e1c8 100644
--- a/common/spl/spl_fit.c
+++ b/common/spl/spl_fit.c
@@ -550,6 +550,23 @@ static int spl_fit_image_is_fpga(const void *fit, int node)
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
@@ -903,6 +920,9 @@ int spl_load_simple_fit(struct spl_image_info *spl_image,
 		    image_info.entry_point != FDT_ERROR)
 			spl_image->entry_point = image_info.entry_point;
 
+		spl_fit_image_record_arm32_optee(ctx.fit, node, spl_image,
+						 &image_info);
+
 		/* Record our loadables into the FDT */
 		if (!CONFIG_IS_ENABLED(FIT_IMAGE_TINY) &&
 		    xpl_get_fdt_update(info) && spl_image->fdt_addr)
diff --git a/include/spl.h b/include/spl.h
index cf45d411ecb..06dc28362d3 100644
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
2.51.0

