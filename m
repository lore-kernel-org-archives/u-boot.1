Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3555FE74AC3
	for <u-boot@archiver.kernel.org>; Tue,  3 Dec 2024 16:36:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C8BC889677;
	Tue,  3 Dec 2024 17:36:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id E4D1489651; Tue,  3 Dec 2024 17:36:30 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id A2AEA893A9
 for <u-boot@lists.denx.de>; Tue,  3 Dec 2024 17:36:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=sughosh.ganu@linaro.org
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0DC70143D;
 Tue,  3 Dec 2024 08:36:56 -0800 (PST)
Received: from a079122.blr.arm.com (a079122.arm.com [10.162.17.48])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B3EDC3F71E;
 Tue,  3 Dec 2024 08:36:25 -0800 (PST)
From: Sughosh Ganu <sughosh.ganu@linaro.org>
To: u-boot@lists.denx.de
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Anton Antonov <Anton.Antonov@arm.com>, Tom Rini <trini@konsulko.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: [PATCH v2 4/4] efi: add helper functions to insert pmem node for DT
 fixup
Date: Tue,  3 Dec 2024 22:06:05 +0530
Message-Id: <20241203163605.1482152-5-sughosh.ganu@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241203163605.1482152-1-sughosh.ganu@linaro.org>
References: <20241203163605.1482152-1-sughosh.ganu@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

The EFI HTTP boot puts the iso installer image at some location in
memory which needs to be reserved in the devicetree as persistent
memory (pmem). Add helper functions which add this pmem node when the
EFI_DT_FIXUP protocol's fixup callback is invoked.

Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
---
Changes since V1:
* Use log_err() to print the error message in image_setup_libfdt()
* Remove "ERROR:" from the error print in image_setup_libfdt()

 boot/image-fdt.c             |  9 +++++++++
 include/efi_loader.h         | 17 +++++++++++++++++
 lib/efi_loader/efi_bootmgr.c | 21 +++++++++++++++++++++
 lib/efi_loader/efi_helper.c  | 12 ++++++++++++
 4 files changed, 59 insertions(+)

diff --git a/boot/image-fdt.c b/boot/image-fdt.c
index 3d5b6f9e2dc..de479d3ffa0 100644
--- a/boot/image-fdt.c
+++ b/boot/image-fdt.c
@@ -11,6 +11,7 @@
 #include <command.h>
 #include <fdt_support.h>
 #include <fdtdec.h>
+#include <efi_loader.h>
 #include <env.h>
 #include <errno.h>
 #include <image.h>
@@ -648,6 +649,14 @@ int image_setup_libfdt(struct bootm_headers *images, void *blob, bool lmb)
 	if (!ft_verify_fdt(blob))
 		goto err;
 
+	if (CONFIG_IS_ENABLED(EFI_HTTP_BOOT)) {
+		fdt_ret = fdt_efi_pmem_setup(blob);
+		if (fdt_ret) {
+			log_err("HTTP boot pmem fixup failed\n");
+			goto err;
+		}
+	}
+
 	/* after here we are using a livetree */
 	if (!of_live_active() && CONFIG_IS_ENABLED(EVENT)) {
 		struct event_ft_fixup fixup;
diff --git a/include/efi_loader.h b/include/efi_loader.h
index 24e40799eee..87b9a6e4da0 100644
--- a/include/efi_loader.h
+++ b/include/efi_loader.h
@@ -748,6 +748,15 @@ bool efi_varname_is_load_option(u16 *var_name16, int *index);
 efi_status_t efi_next_variable_name(efi_uintn_t *size, u16 **buf,
 				    efi_guid_t *guid);
 
+/**
+ * fdt_efi_pmem_setup() - Setup the pmem node in the devicetree
+ *
+ * @fdt:	Pointer to the devicetree
+ *
+ * Return:	0 on success, negative on failure
+ */
+int fdt_efi_pmem_setup(void *fdt);
+
 /**
  * efi_size_in_pages() - convert size in bytes to size in pages
  *
@@ -964,6 +973,14 @@ efi_status_t efi_set_load_options(efi_handle_t handle,
 				  void *load_options);
 efi_status_t efi_bootmgr_load(efi_handle_t *handle, void **load_options);
 
+/**
+ * efi_bootmgr_pmem_setup() - Put a pmem node for UEFI HTTP installers
+ *
+ * @fdt:	Pointer to the DT blob
+ * Return:	status code
+ */
+efi_status_t efi_bootmgr_pmem_setup(void *fdt);
+
 /**
  * struct efi_image_regions - A list of memory regions
  *
diff --git a/lib/efi_loader/efi_bootmgr.c b/lib/efi_loader/efi_bootmgr.c
index b906e53e26e..db4eb6a7376 100644
--- a/lib/efi_loader/efi_bootmgr.c
+++ b/lib/efi_loader/efi_bootmgr.c
@@ -41,6 +41,8 @@ struct uridp_context {
 	efi_handle_t mem_handle;
 };
 
+static struct uridp_context *uctx;
+
 const efi_guid_t efi_guid_bootmenu_auto_generated =
 		EFICONFIG_AUTO_GENERATED_ENTRY_GUID;
 
@@ -427,6 +429,7 @@ static efi_status_t efi_bootmgr_release_uridp(struct uridp_context *ctx)
 
 	efi_free_pool(ctx->loaded_dp);
 	free(ctx);
+	uctx = NULL;
 
 	return ret == EFI_SUCCESS ? ret2 : ret;
 }
@@ -447,6 +450,23 @@ static void EFIAPI efi_bootmgr_http_return(struct efi_event *event,
 	EFI_EXIT(ret);
 }
 
+/**
+ * efi_bootmgr_pmem_setup() - Put a pmem node for UEFI HTTP installers
+ *
+ * @fdt:	Pointer to the DT blob
+ * Return:	status code
+ */
+efi_status_t efi_bootmgr_pmem_setup(void *fdt)
+{
+	if (!uctx) {
+		log_warning("No EFI HTTP boot context found\n");
+		return EFI_SUCCESS;
+	}
+
+	return !fdt_fixup_pmem_region(fdt, uctx->image_addr, uctx->image_size) ?
+		EFI_SUCCESS : EFI_INVALID_PARAMETER;
+}
+
 /**
  * try_load_from_uri_path() - Handle the URI device path
  *
@@ -476,6 +496,7 @@ static efi_status_t try_load_from_uri_path(struct efi_device_path_uri *uridp,
 	if (!ctx)
 		return EFI_OUT_OF_RESOURCES;
 
+	uctx = ctx;
 	s = env_get("loadaddr");
 	if (!s) {
 		log_err("Error: loadaddr is not set\n");
diff --git a/lib/efi_loader/efi_helper.c b/lib/efi_loader/efi_helper.c
index bf96f61d3d0..6fae37ad617 100644
--- a/lib/efi_loader/efi_helper.c
+++ b/lib/efi_loader/efi_helper.c
@@ -313,6 +313,18 @@ int efi_unlink_dev(efi_handle_t handle)
 	return 0;
 }
 
+/**
+ * fdt_efi_pmem_setup() - Setup the pmem node in the devicetree
+ *
+ * @fdt:	Pointer to the devicetree
+ *
+ * Return:	0 on success, negative on failure
+ */
+int fdt_efi_pmem_setup(void *fdt)
+{
+	return efi_bootmgr_pmem_setup(fdt) == EFI_SUCCESS ? 0 : -1;
+}
+
 static int u16_tohex(u16 c)
 {
 	if (c >= '0' && c <= '9')
-- 
2.34.1

