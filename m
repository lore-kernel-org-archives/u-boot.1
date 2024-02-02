Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAF57C48286
	for <u-boot@archiver.kernel.org>; Fri,  2 Feb 2024 00:26:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3F93787D84;
	Fri,  2 Feb 2024 01:25:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="XXLTWYMG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 76FBA87CC4; Fri,  2 Feb 2024 01:25:04 +0100 (CET)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1D54587D57
 for <u-boot@lists.denx.de>; Fri,  2 Feb 2024 01:24:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=afd@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4120OoxL029785;
 Thu, 1 Feb 2024 18:24:50 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1706833490;
 bh=YEI/k7kvXfCldmxBx8bSyP48eclFV+MasAyt+zPV77k=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=XXLTWYMGrAkqpI0G5u6/PbYct5zYVI+jqVH4lrIU5aAprbEf3Gf4WyCXV0rgaYi8p
 auWN4a23tGyTJRVGM2ugBCpmLsI5xj3b/ZR5XrN7bfpyJ7B98ri/onbhLY0XW56KV7
 NihutfRmwsCDVpbyb0I/zGPMwoBFmsZpeCM+r0JU=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4120OoHL039474
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 1 Feb 2024 18:24:50 -0600
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 1
 Feb 2024 18:24:50 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 1 Feb 2024 18:24:50 -0600
Received: from lelvsmtp6.itg.ti.com ([10.249.42.149])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4120OnBi107441;
 Thu, 1 Feb 2024 18:24:49 -0600
From: Andrew Davis <afd@ti.com>
To: Neha Malcom Francis <n-francis@ti.com>, Vignesh Raghavendra
 <vigneshr@ti.com>, Nishanth Menon <nm@ti.com>, Simon Glass
 <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
CC: <u-boot@lists.denx.de>, Andrew Davis <afd@ti.com>
Subject: [PATCH 3/6] arm: mach-k3: Move tispl.bin loading into R5 directory
Date: Thu, 1 Feb 2024 18:24:45 -0600
Message-ID: <20240202002448.1116407-3-afd@ti.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240202002448.1116407-1-afd@ti.com>
References: <20240202002448.1116407-1-afd@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
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

ATF, OPTEE, DM (tispl.bin) loading is only ever done by the R5 core,
move the code into the R5 directory.

Signed-off-by: Andrew Davis <afd@ti.com>
---
 arch/arm/mach-k3/common.c    | 248 +---------------------------------
 arch/arm/mach-k3/r5/common.c | 249 +++++++++++++++++++++++++++++++++++
 2 files changed, 252 insertions(+), 245 deletions(-)

diff --git a/arch/arm/mach-k3/common.c b/arch/arm/mach-k3/common.c
index 5d53efed85b..8db7ca0725e 100644
--- a/arch/arm/mach-k3/common.c
+++ b/arch/arm/mach-k3/common.c
@@ -28,27 +28,6 @@
 #include <elf.h>
 #include <soc.h>
 
-#if IS_ENABLED(CONFIG_SYS_K3_SPL_ATF)
-enum {
-	IMAGE_ID_ATF,
-	IMAGE_ID_OPTEE,
-	IMAGE_ID_SPL,
-	IMAGE_ID_DM_FW,
-	IMAGE_AMT,
-};
-
-#if CONFIG_IS_ENABLED(FIT_IMAGE_POST_PROCESS)
-static const char *image_os_match[IMAGE_AMT] = {
-	"arm-trusted-firmware",
-	"tee",
-	"U-Boot",
-	"DM",
-};
-#endif
-
-static struct image_info fit_image_info[IMAGE_AMT];
-#endif
-
 struct ti_sci_handle *get_ti_sci_handle(void)
 {
 	struct udevice *dev;
@@ -128,233 +107,12 @@ int early_console_init(void)
 }
 #endif
 
-#if IS_ENABLED(CONFIG_SYS_K3_SPL_ATF)
-
-void init_env(void)
-{
-#ifdef CONFIG_SPL_ENV_SUPPORT
-	char *part;
-
-	env_init();
-	env_relocate();
-	switch (spl_boot_device()) {
-	case BOOT_DEVICE_MMC2:
-		part = env_get("bootpart");
-		env_set("storage_interface", "mmc");
-		env_set("fw_dev_part", part);
-		break;
-	case BOOT_DEVICE_SPI:
-		env_set("storage_interface", "ubi");
-		env_set("fw_ubi_mtdpart", "UBI");
-		env_set("fw_ubi_volume", "UBI0");
-		break;
-	default:
-		printf("%s from device %u not supported!\n",
-		       __func__, spl_boot_device());
-		return;
-	}
-#endif
-}
-
-int load_firmware(char *name_fw, char *name_loadaddr, u32 *loadaddr)
-{
-	struct udevice *fsdev;
-	char *name = NULL;
-	int size = 0;
-
-	if (!IS_ENABLED(CONFIG_FS_LOADER))
-		return 0;
-
-	*loadaddr = 0;
-#ifdef CONFIG_SPL_ENV_SUPPORT
-	switch (spl_boot_device()) {
-	case BOOT_DEVICE_MMC2:
-		name = env_get(name_fw);
-		*loadaddr = env_get_hex(name_loadaddr, *loadaddr);
-		break;
-	default:
-		printf("Loading rproc fw image from device %u not supported!\n",
-		       spl_boot_device());
-		return 0;
-	}
-#endif
-	if (!*loadaddr)
-		return 0;
-
-	if (!get_fs_loader(&fsdev)) {
-		size = request_firmware_into_buf(fsdev, name, (void *)*loadaddr,
-						 0, 0);
-	}
-
-	return size;
-}
-
-void release_resources_for_core_shutdown(void)
-{
-	struct ti_sci_handle *ti_sci = get_ti_sci_handle();
-	struct ti_sci_dev_ops *dev_ops = &ti_sci->ops.dev_ops;
-	struct ti_sci_proc_ops *proc_ops = &ti_sci->ops.proc_ops;
-	int ret;
-	u32 i;
-
-	/* Iterate through list of devices to put (shutdown) */
-	for (i = 0; i < ARRAY_SIZE(put_device_ids); i++) {
-		u32 id = put_device_ids[i];
-
-		ret = dev_ops->put_device(ti_sci, id);
-		if (ret)
-			panic("Failed to put device %u (%d)\n", id, ret);
-	}
-
-	/* Iterate through list of cores to put (shutdown) */
-	for (i = 0; i < ARRAY_SIZE(put_core_ids); i++) {
-		u32 id = put_core_ids[i];
-
-		/*
-		 * Queue up the core shutdown request. Note that this call
-		 * needs to be followed up by an actual invocation of an WFE
-		 * or WFI CPU instruction.
-		 */
-		ret = proc_ops->proc_shutdown_no_wait(ti_sci, id);
-		if (ret)
-			panic("Failed sending core %u shutdown message (%d)\n",
-			      id, ret);
-	}
-}
-
-void __noreturn jump_to_image_no_args(struct spl_image_info *spl_image)
-{
-	typedef void __noreturn (*image_entry_noargs_t)(void);
-	struct ti_sci_handle *ti_sci = get_ti_sci_handle();
-	u32 loadaddr = 0;
-	int ret, size = 0, shut_cpu = 0;
-
-	/* Release all the exclusive devices held by SPL before starting ATF */
-	ti_sci->ops.dev_ops.release_exclusive_devices(ti_sci);
-
-	ret = rproc_init();
-	if (ret)
-		panic("rproc failed to be initialized (%d)\n", ret);
-
-	init_env();
-
-	if (!fit_image_info[IMAGE_ID_DM_FW].image_start) {
-		size = load_firmware("name_mcur5f0_0fw", "addr_mcur5f0_0load",
-				     &loadaddr);
-	}
-
-	/*
-	 * It is assumed that remoteproc device 1 is the corresponding
-	 * Cortex-A core which runs ATF. Make sure DT reflects the same.
-	 */
-	if (!fit_image_info[IMAGE_ID_ATF].image_start)
-		fit_image_info[IMAGE_ID_ATF].image_start =
-			spl_image->entry_point;
-
-	ret = rproc_load(1, fit_image_info[IMAGE_ID_ATF].image_start, 0x200);
-	if (ret)
-		panic("%s: ATF failed to load on rproc (%d)\n", __func__, ret);
-
-#if (CONFIG_IS_ENABLED(FIT_IMAGE_POST_PROCESS) && IS_ENABLED(CONFIG_SYS_K3_SPL_ATF))
-	/* Authenticate ATF */
-	void *image_addr = (void *)fit_image_info[IMAGE_ID_ATF].image_start;
-
-	debug("%s: Authenticating image: addr=%lx, size=%ld, os=%s\n", __func__,
-	      fit_image_info[IMAGE_ID_ATF].image_start,
-	      fit_image_info[IMAGE_ID_ATF].image_len,
-	      image_os_match[IMAGE_ID_ATF]);
-
-	ti_secure_image_post_process(&image_addr,
-				     (size_t *)&fit_image_info[IMAGE_ID_ATF].image_len);
-
-	/* Authenticate OPTEE */
-	image_addr = (void *)fit_image_info[IMAGE_ID_OPTEE].image_start;
-
-	debug("%s: Authenticating image: addr=%lx, size=%ld, os=%s\n", __func__,
-	      fit_image_info[IMAGE_ID_OPTEE].image_start,
-	      fit_image_info[IMAGE_ID_OPTEE].image_len,
-	      image_os_match[IMAGE_ID_OPTEE]);
-
-	ti_secure_image_post_process(&image_addr,
-				     (size_t *)&fit_image_info[IMAGE_ID_OPTEE].image_len);
-
-#endif
-
-	if (!fit_image_info[IMAGE_ID_DM_FW].image_len &&
-	    !(size > 0 && valid_elf_image(loadaddr))) {
-		shut_cpu = 1;
-		goto start_arm64;
-	}
-
-	if (!fit_image_info[IMAGE_ID_DM_FW].image_start) {
-		loadaddr = load_elf_image_phdr(loadaddr);
-	} else {
-		loadaddr = fit_image_info[IMAGE_ID_DM_FW].image_start;
-		if (valid_elf_image(loadaddr))
-			loadaddr = load_elf_image_phdr(loadaddr);
-	}
-
-	debug("%s: jumping to address %x\n", __func__, loadaddr);
-
-start_arm64:
-	/* Add an extra newline to differentiate the ATF logs from SPL */
-	printf("Starting ATF on ARM64 core...\n\n");
-
-	ret = rproc_start(1);
-	if (ret)
-		panic("%s: ATF failed to start on rproc (%d)\n", __func__, ret);
-
-	if (shut_cpu) {
-		debug("Shutting down...\n");
-		release_resources_for_core_shutdown();
-
-		while (1)
-			asm volatile("wfe");
-	}
-	image_entry_noargs_t image_entry = (image_entry_noargs_t)loadaddr;
-
-	image_entry();
-}
-#endif
-
-#if CONFIG_IS_ENABLED(FIT_IMAGE_POST_PROCESS)
+#if CONFIG_IS_ENABLED(FIT_IMAGE_POST_PROCESS) && !IS_ENABLED(CONFIG_SYS_K3_SPL_ATF)
 void board_fit_image_post_process(const void *fit, int node, void **p_image,
 				  size_t *p_size)
 {
-#if IS_ENABLED(CONFIG_SYS_K3_SPL_ATF)
-	int len;
-	int i;
-	const char *os;
-	u32 addr;
-
-	os = fdt_getprop(fit, node, "os", &len);
-	addr = fdt_getprop_u32_default_node(fit, node, 0, "entry", -1);
-
-	debug("%s: processing image: addr=%x, size=%d, os=%s\n", __func__,
-	      addr, *p_size, os);
-
-	for (i = 0; i < IMAGE_AMT; i++) {
-		if (!strcmp(os, image_os_match[i])) {
-			fit_image_info[i].image_start = addr;
-			fit_image_info[i].image_len = *p_size;
-			debug("%s: matched image for ID %d\n", __func__, i);
-			break;
-		}
-	}
-	/*
-	 * Only DM and the DTBs are being authenticated here,
-	 * rest will be authenticated when A72 cluster is up
-	 */
-	if ((i != IMAGE_ID_ATF) && (i != IMAGE_ID_OPTEE))
-#endif
-	{
-		ti_secure_image_check_binary(p_image, p_size);
-		ti_secure_image_post_process(p_image, p_size);
-	}
-#if IS_ENABLED(CONFIG_SYS_K3_SPL_ATF)
-	else
-		ti_secure_image_check_binary(p_image, p_size);
-#endif
+	ti_secure_image_check_binary(p_image, p_size);
+	ti_secure_image_post_process(p_image, p_size);
 }
 #endif
 
diff --git a/arch/arm/mach-k3/r5/common.c b/arch/arm/mach-k3/r5/common.c
index ef81f50c6c7..87d4712efd4 100644
--- a/arch/arm/mach-k3/r5/common.c
+++ b/arch/arm/mach-k3/r5/common.c
@@ -5,12 +5,225 @@
  * Copyright (C) 2023 Texas Instruments Incorporated - https://www.ti.com/
  */
 
+#include <linux/printk.h>
 #include <linux/types.h>
 #include <asm/hardware.h>
 #include <asm/io.h>
+#include <image.h>
+#include <fs_loader.h>
+#include <linux/soc/ti/ti_sci_protocol.h>
+#include <spl.h>
+#include <remoteproc.h>
+#include <elf.h>
 
 #include "../common.h"
 
+#if IS_ENABLED(CONFIG_SYS_K3_SPL_ATF)
+enum {
+	IMAGE_ID_ATF,
+	IMAGE_ID_OPTEE,
+	IMAGE_ID_SPL,
+	IMAGE_ID_DM_FW,
+	IMAGE_AMT,
+};
+
+#if CONFIG_IS_ENABLED(FIT_IMAGE_POST_PROCESS)
+static const char *image_os_match[IMAGE_AMT] = {
+	"arm-trusted-firmware",
+	"tee",
+	"U-Boot",
+	"DM",
+};
+#endif
+
+static struct image_info fit_image_info[IMAGE_AMT];
+
+void init_env(void)
+{
+#ifdef CONFIG_SPL_ENV_SUPPORT
+	char *part;
+
+	env_init();
+	env_relocate();
+	switch (spl_boot_device()) {
+	case BOOT_DEVICE_MMC2:
+		part = env_get("bootpart");
+		env_set("storage_interface", "mmc");
+		env_set("fw_dev_part", part);
+		break;
+	case BOOT_DEVICE_SPI:
+		env_set("storage_interface", "ubi");
+		env_set("fw_ubi_mtdpart", "UBI");
+		env_set("fw_ubi_volume", "UBI0");
+		break;
+	default:
+		printf("%s from device %u not supported!\n",
+		       __func__, spl_boot_device());
+		return;
+	}
+#endif
+}
+
+int load_firmware(char *name_fw, char *name_loadaddr, u32 *loadaddr)
+{
+	struct udevice *fsdev;
+	char *name = NULL;
+	int size = 0;
+
+	if (!IS_ENABLED(CONFIG_FS_LOADER))
+		return 0;
+
+	*loadaddr = 0;
+#ifdef CONFIG_SPL_ENV_SUPPORT
+	switch (spl_boot_device()) {
+	case BOOT_DEVICE_MMC2:
+		name = env_get(name_fw);
+		*loadaddr = env_get_hex(name_loadaddr, *loadaddr);
+		break;
+	default:
+		printf("Loading rproc fw image from device %u not supported!\n",
+		       spl_boot_device());
+		return 0;
+	}
+#endif
+	if (!*loadaddr)
+		return 0;
+
+	if (!get_fs_loader(&fsdev)) {
+		size = request_firmware_into_buf(fsdev, name, (void *)*loadaddr,
+						 0, 0);
+	}
+
+	return size;
+}
+
+void release_resources_for_core_shutdown(void)
+{
+	struct ti_sci_handle *ti_sci = get_ti_sci_handle();
+	struct ti_sci_dev_ops *dev_ops = &ti_sci->ops.dev_ops;
+	struct ti_sci_proc_ops *proc_ops = &ti_sci->ops.proc_ops;
+	int ret;
+	u32 i;
+
+	/* Iterate through list of devices to put (shutdown) */
+	for (i = 0; i < ARRAY_SIZE(put_device_ids); i++) {
+		u32 id = put_device_ids[i];
+
+		ret = dev_ops->put_device(ti_sci, id);
+		if (ret)
+			panic("Failed to put device %u (%d)\n", id, ret);
+	}
+
+	/* Iterate through list of cores to put (shutdown) */
+	for (i = 0; i < ARRAY_SIZE(put_core_ids); i++) {
+		u32 id = put_core_ids[i];
+
+		/*
+		 * Queue up the core shutdown request. Note that this call
+		 * needs to be followed up by an actual invocation of an WFE
+		 * or WFI CPU instruction.
+		 */
+		ret = proc_ops->proc_shutdown_no_wait(ti_sci, id);
+		if (ret)
+			panic("Failed sending core %u shutdown message (%d)\n",
+			      id, ret);
+	}
+}
+
+void __noreturn jump_to_image_no_args(struct spl_image_info *spl_image)
+{
+	typedef void __noreturn (*image_entry_noargs_t)(void);
+	struct ti_sci_handle *ti_sci = get_ti_sci_handle();
+	u32 loadaddr = 0;
+	int ret, size = 0, shut_cpu = 0;
+
+	/* Release all the exclusive devices held by SPL before starting ATF */
+	ti_sci->ops.dev_ops.release_exclusive_devices(ti_sci);
+
+	ret = rproc_init();
+	if (ret)
+		panic("rproc failed to be initialized (%d)\n", ret);
+
+	init_env();
+
+	if (!fit_image_info[IMAGE_ID_DM_FW].image_start) {
+		size = load_firmware("name_mcur5f0_0fw", "addr_mcur5f0_0load",
+				     &loadaddr);
+	}
+
+	/*
+	 * It is assumed that remoteproc device 1 is the corresponding
+	 * Cortex-A core which runs ATF. Make sure DT reflects the same.
+	 */
+	if (!fit_image_info[IMAGE_ID_ATF].image_start)
+		fit_image_info[IMAGE_ID_ATF].image_start =
+			spl_image->entry_point;
+
+	ret = rproc_load(1, fit_image_info[IMAGE_ID_ATF].image_start, 0x200);
+	if (ret)
+		panic("%s: ATF failed to load on rproc (%d)\n", __func__, ret);
+
+#if CONFIG_IS_ENABLED(FIT_IMAGE_POST_PROCESS)
+	/* Authenticate ATF */
+	void *image_addr = (void *)fit_image_info[IMAGE_ID_ATF].image_start;
+
+	debug("%s: Authenticating image: addr=%lx, size=%ld, os=%s\n", __func__,
+	      fit_image_info[IMAGE_ID_ATF].image_start,
+	      fit_image_info[IMAGE_ID_ATF].image_len,
+	      image_os_match[IMAGE_ID_ATF]);
+
+	ti_secure_image_post_process(&image_addr,
+				     (size_t *)&fit_image_info[IMAGE_ID_ATF].image_len);
+
+	/* Authenticate OPTEE */
+	image_addr = (void *)fit_image_info[IMAGE_ID_OPTEE].image_start;
+
+	debug("%s: Authenticating image: addr=%lx, size=%ld, os=%s\n", __func__,
+	      fit_image_info[IMAGE_ID_OPTEE].image_start,
+	      fit_image_info[IMAGE_ID_OPTEE].image_len,
+	      image_os_match[IMAGE_ID_OPTEE]);
+
+	ti_secure_image_post_process(&image_addr,
+				     (size_t *)&fit_image_info[IMAGE_ID_OPTEE].image_len);
+#endif
+
+	if (!fit_image_info[IMAGE_ID_DM_FW].image_len &&
+	    !(size > 0 && valid_elf_image(loadaddr))) {
+		shut_cpu = 1;
+		goto start_arm64;
+	}
+
+	if (!fit_image_info[IMAGE_ID_DM_FW].image_start) {
+		loadaddr = load_elf_image_phdr(loadaddr);
+	} else {
+		loadaddr = fit_image_info[IMAGE_ID_DM_FW].image_start;
+		if (valid_elf_image(loadaddr))
+			loadaddr = load_elf_image_phdr(loadaddr);
+	}
+
+	debug("%s: jumping to address %x\n", __func__, loadaddr);
+
+start_arm64:
+	/* Add an extra newline to differentiate the ATF logs from SPL */
+	printf("Starting ATF on ARM64 core...\n\n");
+
+	ret = rproc_start(1);
+	if (ret)
+		panic("%s: ATF failed to start on rproc (%d)\n", __func__, ret);
+
+	if (shut_cpu) {
+		debug("Shutting down...\n");
+		release_resources_for_core_shutdown();
+
+		while (1)
+			asm volatile("wfe");
+	}
+	image_entry_noargs_t image_entry = (image_entry_noargs_t)loadaddr;
+
+	image_entry();
+}
+#endif
+
 void disable_linefill_optimization(void)
 {
 	u32 actlr;
@@ -33,3 +246,39 @@ void disable_linefill_optimization(void)
 	actlr |= (1 << 13); /* Set DLFO bit  */
 	asm("mcr p15, 0, %0, c1, c0, 1" : : "r" (actlr));
 }
+
+#if CONFIG_IS_ENABLED(FIT_IMAGE_POST_PROCESS)
+void board_fit_image_post_process(const void *fit, int node, void **p_image,
+				  size_t *p_size)
+{
+	int len;
+	int i;
+	const char *os;
+	u32 addr;
+
+	os = fdt_getprop(fit, node, "os", &len);
+	addr = fdt_getprop_u32_default_node(fit, node, 0, "entry", -1);
+
+	debug("%s: processing image: addr=%x, size=%d, os=%s\n", __func__,
+	      addr, *p_size, os);
+
+	for (i = 0; i < IMAGE_AMT; i++) {
+		if (!strcmp(os, image_os_match[i])) {
+			fit_image_info[i].image_start = addr;
+			fit_image_info[i].image_len = *p_size;
+			debug("%s: matched image for ID %d\n", __func__, i);
+			break;
+		}
+	}
+	/*
+	 * Only DM and the DTBs are being authenticated here,
+	 * rest will be authenticated when A72 cluster is up
+	 */
+	if ((i != IMAGE_ID_ATF) && (i != IMAGE_ID_OPTEE)) {
+		ti_secure_image_check_binary(p_image, p_size);
+		ti_secure_image_post_process(p_image, p_size);
+	} else {
+		ti_secure_image_check_binary(p_image, p_size);
+	}
+}
+#endif
-- 
2.39.2

