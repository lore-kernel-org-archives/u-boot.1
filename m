Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE5C9E66882
	for <u-boot@archiver.kernel.org>; Sat, 23 Nov 2024 21:49:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9962989187;
	Sat, 23 Nov 2024 22:49:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=srcf.ucam.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id CDD7F891B4; Sat, 23 Nov 2024 20:56:35 +0100 (CET)
Received: from cavan.codon.org.uk (cavan.codon.org.uk [176.126.240.207])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BFFAA89275
 for <u-boot@lists.denx.de>; Sat, 23 Nov 2024 20:56:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=srcf.ucam.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mjg59@codon.org.uk
Received: from fedora.. (23-93-16-71.fiber.dynamic.sonic.net [23.93.16.71])
 by cavan.codon.org.uk (Postfix) with ESMTPSA id 38895407DD;
 Sat, 23 Nov 2024 19:56:31 +0000 (GMT)
From: Matthew Garrett <mjg59@srcf.ucam.org>
To: u-boot@lists.denx.de
Cc: Matthew Garrett <mgarrett@aurora.tech>, Bin Meng <bmeng.cn@gmail.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Simon Glass <sjg@chromium.org>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 Tom Rini <trini@konsulko.com>,
 =?UTF-8?q?Vincent=20Stehl=C3=A9?= <vincent.stehle@arm.com>
Subject: [PATCH 01/10] Add EFI handover support to bootm
Date: Sat, 23 Nov 2024 11:55:00 -0800
Message-ID: <20241123195616.305687-2-mjg59@srcf.ucam.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241123195616.305687-1-mjg59@srcf.ucam.org>
References: <20241123195616.305687-1-mjg59@srcf.ucam.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 23 Nov 2024 22:49:00 +0100
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

From: Matthew Garrett <mgarrett@aurora.tech>

We want to jump into the EFI stub in the kernel so it can perform
appropriate init and call ExitBootServices. Add support for doing that,
including ensuring that we copy the kernel to somewhere that's not
currently being used by the firmware.

Signed-off-by: Matthew Garrett <mgarrett@aurora.tech>

---

 arch/x86/lib/bootm.c | 49 ++++++++++++++++++++++++++++++--------------
 boot/bootm.c         |  5 +++++
 include/bootm.h      |  6 ++++++
 include/efi.h        |  1 +
 lib/efi/efi.c        |  1 +
 lib/efi/efi_app.c    | 36 ++++++++++++++++++++++++++++++++
 6 files changed, 83 insertions(+), 15 deletions(-)

diff --git a/arch/x86/lib/bootm.c b/arch/x86/lib/bootm.c
index 55f581836df..c4446b1f9c6 100644
--- a/arch/x86/lib/bootm.c
+++ b/arch/x86/lib/bootm.c
@@ -150,6 +150,38 @@ error:
 	return 1;
 }
 
+typedef void(*handover_func)(void *, struct efi_system_table *sys_table, struct
+boot_params *params);
+
+int efi_boot(ulong setup_base, ulong entry, bool image_64bit)
+{
+	struct boot_params *params = (struct boot_params *)setup_base;
+	struct setup_header *hdr = &params->hdr;
+	struct efi_priv *priv = efi_get_priv();
+	handover_func hf;
+	int offset = 0;
+
+	if (IS_ENABLED(CONFIG_EFI_APP_64BIT)) {
+		if (!image_64bit) {
+			printf("## Can only boot 64-bit kernels\n");
+			return 1;
+		}
+		offset = 512;
+	} else if (image_64bit) {
+		printf("# Can only boot 32-bit kernels\n");
+		return 1;
+	}
+
+	hdr->code32_start = (int)entry;
+	hdr->type_of_loader = 0x80; /* U-Boot, from Linux Documentation/x86/boot.rst */
+
+	hf = (handover_func)(entry + hdr->handover_offset + offset);
+	asm volatile ("cli");
+	priv->loaded_image->image_base = (char *)entry;
+	hf(priv->parent_image, priv->sys_table, params);
+	return -EFAULT;
+}
+
 int boot_linux_kernel(ulong setup_base, ulong entry, bool image_64bit)
 {
 	bootm_announce_and_cleanup();
@@ -158,21 +190,8 @@ int boot_linux_kernel(ulong setup_base, ulong entry, bool image_64bit)
 	timestamp_add_now(TS_U_BOOT_START_KERNEL);
 #endif
 
-	/*
-	 * Exit EFI boot services just before jumping, after all console
-	 * output, since the console won't be available afterwards.
-	 */
-	if (IS_ENABLED(CONFIG_EFI_APP)) {
-		int ret;
-
-		ret = efi_store_memory_map(efi_get_priv());
-		if (ret)
-			return ret;
-		printf("Exiting EFI boot services\n");
-		ret = efi_call_exit_boot_services();
-		if (ret)
-			return ret;
-	}
+	if (IS_ENABLED(CONFIG_EFI_APP))
+		return efi_boot(setup_base, entry, image_64bit)
 
 	if (image_64bit) {
 		if (!cpu_has_64bit()) {
diff --git a/boot/bootm.c b/boot/bootm.c
index 16a43d519a8..d5caa4cdb31 100644
--- a/boot/bootm.c
+++ b/boot/bootm.c
@@ -49,6 +49,10 @@ __weak void board_quiesce_devices(void)
 {
 }
 
+__weak void board_fixup_os(image_info_t *os)
+{
+}
+
 #if CONFIG_IS_ENABLED(LEGACY_IMAGE_FORMAT)
 /**
  * image_get_kernel - verify legacy format kernel image
@@ -999,6 +1003,7 @@ int bootm_run_states(struct bootm_info *bmi, int states)
 	/* Load the OS */
 	if (!ret && (states & BOOTM_STATE_LOADOS)) {
 		iflag = bootm_disable_interrupts();
+		board_fixup_os(&images->os);
 		ret = bootm_load_os(images, 0);
 		if (ret && ret != BOOTM_ERR_OVERLAP)
 			goto err;
diff --git a/include/bootm.h b/include/bootm.h
index 61160705215..b0d10123b53 100644
--- a/include/bootm.h
+++ b/include/bootm.h
@@ -217,6 +217,12 @@ void arch_preboot_os(void);
  */
 void board_quiesce_devices(void);
 
+/*
+ * boards should define this if they need to fix up the kernel before boot
+ * (eg, by modifying the desired load address).
+ */
+void board_fixup_os(image_info_t *os);
+
 /**
  * switch_to_non_secure_mode() - switch to non-secure mode
  */
diff --git a/include/efi.h b/include/efi.h
index c559fda3004..1d06230439f 100644
--- a/include/efi.h
+++ b/include/efi.h
@@ -459,6 +459,7 @@ static inline struct efi_mem_desc *efi_get_next_mem_desc(
  */
 struct efi_priv {
 	efi_handle_t parent_image;
+	struct efi_loaded_image *loaded_image;
 	struct efi_system_table *sys_table;
 	struct efi_boot_services *boot;
 	struct efi_runtime_services *run;
diff --git a/lib/efi/efi.c b/lib/efi/efi.c
index bcb34d67465..bb1d9e24f84 100644
--- a/lib/efi/efi.c
+++ b/lib/efi/efi.c
@@ -113,6 +113,7 @@ int efi_init(struct efi_priv *priv, const char *banner, efi_handle_t image,
 		efi_puts(priv, "Failed to get loaded image protocol\n");
 		return ret;
 	}
+	priv->loaded_image = loaded_image;
 	priv->image_data_type = loaded_image->image_data_type;
 
 	return 0;
diff --git a/lib/efi/efi_app.c b/lib/efi/efi_app.c
index 9b94a93ee4f..7c3ef9a7926 100644
--- a/lib/efi/efi_app.c
+++ b/lib/efi/efi_app.c
@@ -14,6 +14,7 @@
 #include <efi.h>
 #include <efi_api.h>
 #include <errno.h>
+#include <image.h>
 #include <init.h>
 #include <malloc.h>
 #include <sysreset.h>
@@ -218,6 +219,41 @@ static int efi_sysreset_request(struct udevice *dev, enum sysreset_t type)
 	return -EINPROGRESS;
 }
 
+/*
+ * Attempt to relocate the kernel to somewhere the firmware isn't using
+ */
+#define PAGE_SIZE_BITS 12
+void board_fixup_os(image_info_t *os)
+{
+	int pages;
+	ulong load_addr;
+	u64 addr;
+	efi_status_t status;
+	struct efi_priv *priv = efi_get_priv();
+	struct efi_boot_services *boot = priv->boot;
+
+	pages = (os->image_len + ((1 << PAGE_SIZE_BITS) - 1)) >> PAGE_SIZE_BITS;
+
+	addr = os->load;
+
+	/* Try to allocate at the preferred address */
+	status = boot->allocate_pages(EFI_ALLOCATE_ADDRESS, EFI_LOADER_DATA,
+				      pages, &addr);
+	if (status == EFI_SUCCESS)
+		return;
+
+	/* That failed, so try allocating anywhere there's enough room */
+	status = boot->allocate_pages(EFI_ALLOCATE_ANY_PAGES, EFI_LOADER_DATA, pages, &addr);
+	if (status == EFI_SUCCESS) {
+		/* Make sure bootm knows where we loaded the image */
+		os->load = addr;
+		return;
+	}
+
+	printf("Failed to alloc %lx bytes at %lx: %lx\n", os->image_len, load_addr,
+	       status);
+}
+
 static const struct udevice_id efi_sysreset_ids[] = {
 	{ .compatible = "efi,reset" },
 	{ }
-- 
2.47.0

