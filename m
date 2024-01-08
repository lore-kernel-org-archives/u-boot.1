Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AFE4C3DA6E
	for <u-boot@archiver.kernel.org>; Mon,  8 Jan 2024 16:59:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 745F487AC9;
	Mon,  8 Jan 2024 17:58:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="JaPffeqc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ABA8587463; Mon,  8 Jan 2024 17:58:30 +0100 (CET)
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net
 [IPv6:2001:4b98:dc4:8::229])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 122D587AB8
 for <u-boot@lists.denx.de>; Mon,  8 Jan 2024 17:58:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=thomas.richard@bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 495D4FF803;
 Mon,  8 Jan 2024 16:58:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
 t=1704733107;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jtYoPd6fisbVXU8nV9h4UyT0r8OlF+bGYZ1JfBEEBgE=;
 b=JaPffeqcRqWzQVH+6viIHwb4+WtvcQskXKcVvEKIt6A59ToullNFlMAkx0ZsfPg+bAexhl
 gW3v4MVFlsaN6GWBfjaqcrix5q/Xcqm7V04HSwn2A/wTb7NA+LcRHoRugSy1XtXv2OZ7gg
 2D+79nB8voHKxx3Ljl6c3pQGj8CVThOXozwQHpHXc2h++fzCpUmuY398/KUSi+0cGMteTZ
 z3SbLIssv5Wbv75ocp5FDn8arZiWbMYgDae/hEfAPEoMYwPn86dz3KKjbq2kql2lCGx4Rf
 gAH+XGJHOpVle/vY4u4/+SuLTXhTrFjS9vAj5RpvcPzFg3VRWhk+7dfpTc04/A==
From: Thomas Richard <thomas.richard@bootlin.com>
To: u-boot@lists.denx.de
Cc: thomas.petazzoni@bootlin.com, thomas.richard@bootlin.com, nm@ti.com,
 u-kumar1@ti.com, gregory.clement@bootlin.com, Andrew Davis <afd@ti.com>,
 Christian Gmeiner <christian.gmeiner@gmail.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v3 7/8] board: ti: j721e: During resume spl notify tf-a that
 the board is resuming
Date: Mon,  8 Jan 2024 17:56:27 +0100
Message-Id: <20240108165628.3935756-8-thomas.richard@bootlin.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240108165628.3935756-1-thomas.richard@bootlin.com>
References: <20240108165628.3935756-1-thomas.richard@bootlin.com>
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

During the boot a copy of DM-Firmware and TF-A is done in a reserved memory
area.
When resuming, R5 SPL uses these copies instead of the fit image.
R5 SPL writes a magic value in the scratchpad ram to notify TF-A that
the board is resuming.

Based on the work of Gregory CLEMENT <gregory.clement@bootlin.com>

Signed-off-by: Thomas Richard <thomas.richard@bootlin.com>
Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>

---

Changes in v3:
- At resume, R5 SPL doesn't restore TF-A anymore.
  TF-A is started like during a cold boot. R5 SPL will notify that the board is
  resuming using a magic value written in the scratchpad ram.
  TF-A will restore itself.

Changes in v2:
- Check if TF-A is running in DRAM, if yes no need to restore it
- Remove BL31_START macro, and get TF-A start address from the fit image

 arch/arm/mach-k3/common.c                     | 65 ++++++++++++++++++-
 .../arm/mach-k3/include/mach/j721e_hardware.h |  1 +
 arch/arm/mach-k3/include/mach/j721e_spl.h     | 30 +++++++++
 arch/arm/mach-k3/sysfw-loader.c               |  9 ++-
 4 files changed, 101 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-k3/common.c b/arch/arm/mach-k3/common.c
index a35110429b..546ea3cf5e 100644
--- a/arch/arm/mach-k3/common.c
+++ b/arch/arm/mach-k3/common.c
@@ -26,6 +26,7 @@
 #include <env.h>
 #include <elf.h>
 #include <soc.h>
+#include <hang.h>
 
 #if IS_ENABLED(CONFIG_SYS_K3_SPL_ATF)
 enum {
@@ -221,6 +222,11 @@ void release_resources_for_core_shutdown(void)
 	}
 }
 
+__weak int board_is_resuming(void)
+{
+	return 0;
+}
+
 void __noreturn jump_to_image_no_args(struct spl_image_info *spl_image)
 {
 	typedef void __noreturn (*image_entry_noargs_t)(void);
@@ -235,6 +241,35 @@ void __noreturn jump_to_image_no_args(struct spl_image_info *spl_image)
 	if (ret)
 		panic("rproc failed to be initialized (%d)\n", ret);
 
+	if (board_is_resuming()) {
+#if IS_ENABLED(CONFIG_SOC_K3_J721E)
+		if (!valid_elf_image(LPM_DM))
+			panic("%s: DM-Firmware image is not valid, it cannot be loaded\n",
+			      __func__);
+
+		loadaddr = load_elf_image_phdr(LPM_DM);
+
+		memcpy((void *)*(ulong *)(LPM_BL31_START),
+		       (void *)LPM_BL31, *(ulong *)(LPM_BL31_SIZE));
+
+		ret = rproc_load(1, *(ulong *)(LPM_BL31_START), 0x200);
+		if (ret)
+			panic("%s: ATF failed to load on rproc (%d)\n", __func__, ret);
+
+#if (CONFIG_IS_ENABLED(FIT_IMAGE_POST_PROCESS) && IS_ENABLED(CONFIG_SYS_K3_SPL_ATF))
+		debug("%s: Authenticating image: addr=%lx, size=%ld, os=%s\n", __func__,
+		      *(ulong *)(LPM_BL31_START), *(ulong *)(LPM_BL31_SIZE),
+		      image_os_match[IMAGE_ID_ATF]);
+
+		ti_secure_image_post_process((void *)LPM_BL31_START,
+					     (size_t *)LPM_BL31_SIZE);
+#endif
+
+		debug("%s: jumping to address %x\n", __func__, loadaddr);
+		goto start_arm64;
+#endif /* IS_ENABLED(CONFIG_SOC_K3_J721E) */
+	}
+
 	init_env();
 
 	if (!fit_image_info[IMAGE_ID_DM_FW].image_start) {
@@ -250,6 +285,14 @@ void __noreturn jump_to_image_no_args(struct spl_image_info *spl_image)
 		fit_image_info[IMAGE_ID_ATF].image_start =
 			spl_image->entry_point;
 
+#if IS_ENABLED(CONFIG_SOC_K3_J721E)
+	/* Save TF-A image, as at resume fit image is not processed */
+	memcpy((void *)LPM_BL31, (void *)fit_image_info[IMAGE_ID_ATF].image_start,
+	       fit_image_info[IMAGE_ID_ATF].image_len);
+	*(ulong *)(LPM_BL31_START) = fit_image_info[IMAGE_ID_ATF].image_start;
+	*(ulong *)(LPM_BL31_SIZE) = fit_image_info[IMAGE_ID_ATF].image_len;
+#endif
+
 	ret = rproc_load(1, fit_image_info[IMAGE_ID_ATF].image_start, 0x200);
 	if (ret)
 		panic("%s: ATF failed to load on rproc (%d)\n", __func__, ret);
@@ -289,8 +332,18 @@ void __noreturn jump_to_image_no_args(struct spl_image_info *spl_image)
 		loadaddr = load_elf_image_phdr(loadaddr);
 	} else {
 		loadaddr = fit_image_info[IMAGE_ID_DM_FW].image_start;
-		if (valid_elf_image(loadaddr))
+		if (valid_elf_image(loadaddr)) {
 			loadaddr = load_elf_image_phdr(loadaddr);
+#if IS_ENABLED(CONFIG_SOC_K3_J721E)
+			if (fit_image_info[IMAGE_ID_DM_FW].image_len > (BUFFER_ADDR - LPM_DM))
+				log_warning("%s\n: Not enough space to save DM-Firmware",
+					    __func__);
+			else
+				memcpy((void *)LPM_DM,
+				       (void *)fit_image_info[IMAGE_ID_DM_FW].image_start,
+				       fit_image_info[IMAGE_ID_DM_FW].image_len);
+#endif
+		}
 	}
 
 	debug("%s: jumping to address %x\n", __func__, loadaddr);
@@ -299,6 +352,16 @@ start_arm64:
 	/* Add an extra newline to differentiate the ATF logs from SPL */
 	printf("Starting ATF on ARM64 core...\n\n");
 
+#if IS_ENABLED(CONFIG_SOC_K3_J721E)
+	/*
+	 * Write a magic value in scratchpad ram to notify TF-A that the board
+	 * is resuming
+	 */
+	if (board_is_resuming())
+		*(u32 *)(SCRACTHPAD_RAM_BASE) = BL31_MAGIC_SUSPEND;
+	else
+		*(u32 *)(SCRACTHPAD_RAM_BASE) = 0x00;
+#endif
 	ret = rproc_start(1);
 	if (ret)
 		panic("%s: ATF failed to start on rproc (%d)\n", __func__, ret);
diff --git a/arch/arm/mach-k3/include/mach/j721e_hardware.h b/arch/arm/mach-k3/include/mach/j721e_hardware.h
index 376db389ba..29f4030f5e 100644
--- a/arch/arm/mach-k3/include/mach/j721e_hardware.h
+++ b/arch/arm/mach-k3/include/mach/j721e_hardware.h
@@ -15,6 +15,7 @@
 #define WKUP_CTRL_MMR0_BASE				0x43000000
 #define MCU_CTRL_MMR0_BASE				0x40f00000
 #define CTRL_MMR0_BASE					0x00100000
+#define SCRACTHPAD_RAM_BASE				0x40280000
 
 #define CTRLMMR_MAIN_DEVSTAT				(CTRL_MMR0_BASE + 0x30)
 #define MAIN_DEVSTAT_BOOT_MODE_B_MASK		BIT(0)
diff --git a/arch/arm/mach-k3/include/mach/j721e_spl.h b/arch/arm/mach-k3/include/mach/j721e_spl.h
index e8947917a6..253e36b239 100644
--- a/arch/arm/mach-k3/include/mach/j721e_spl.h
+++ b/arch/arm/mach-k3/include/mach/j721e_spl.h
@@ -42,4 +42,34 @@
 #define K3_PRIMARY_BOOTMODE		0x0
 #define K3_BACKUP_BOOTMODE		0x1
 
+/* Starting buffer address is 1MB before the stack address in DDR */
+#define BUFFER_ADDR (CONFIG_SPL_STACK_R_ADDR - SZ_1M)
+
+/* This is actually the whole size of the SRAM */
+#define BL31_SIZE    0x20000
+
+/* This address belongs to a reserved memory region for the point of view of
+ * Linux, U-boot SPL must use the same address to restore TF-A and resume
+ * entry point address
+ */
+#define LPM_SAVE		0xA5000000
+#define LPM_BL31		LPM_SAVE
+#define LPM_BL31_START		LPM_BL31 + BL31_SIZE
+#define LPM_BL31_SIZE		LPM_BL31_START + 4
+#define LPM_DM			LPM_BL31_SIZE  + 4
+
+/* Check if the copy of TF-A and DM-Firmware in DRAM does not overlap an
+ * over memory section.
+ * The resume address of TF-A is also saved in DRAM.
+ * At build time we don't know the DM-Firmware size, so we keep 512k to
+ * save it.
+ */
+#if defined(CONFIG_SPL_BUILD) && defined(CONFIG_TARGET_J7200_R5_EVM)
+#if ((LPM_DM + SZ_512K) > BUFFER_ADDR)
+#error Not enough space to save DM-Firmware and TF-A for S2R
+#endif
+#endif
+
+#define BL31_MAGIC_SUSPEND 0xA5A5A5A5
+
 #endif
diff --git a/arch/arm/mach-k3/sysfw-loader.c b/arch/arm/mach-k3/sysfw-loader.c
index 9be2d9eaea..e6d452e590 100644
--- a/arch/arm/mach-k3/sysfw-loader.c
+++ b/arch/arm/mach-k3/sysfw-loader.c
@@ -84,13 +84,16 @@ static bool sysfw_loaded;
 static void *sysfw_load_address;
 
 /*
- * Populate SPL hook to override the default load address used by the SPL
- * loader function with a custom address for SYSFW loading.
+ * Populate SPL hook to override the default load address used by the
+ * SPL loader function with a custom address for SYSFW loading. In
+ * other case use also a custom address located in a reserved memory
+ * region. It ensures that Linux memory won't be corrupted by SPL during
+ * suspend to ram.
  */
 struct legacy_img_hdr *spl_get_load_buffer(ssize_t offset, size_t size)
 {
 	if (sysfw_loaded)
-		return (struct legacy_img_hdr *)(CONFIG_TEXT_BASE + offset);
+		return (struct legacy_img_hdr *)(BUFFER_ADDR + offset);
 	else if (sysfw_load_address)
 		return sysfw_load_address;
 	else
-- 
2.39.2

