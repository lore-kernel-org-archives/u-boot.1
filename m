Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA37FCD8CB9
	for <u-boot@archiver.kernel.org>; Wed, 10 Jun 2026 10:53:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CC2058486B;
	Wed, 10 Jun 2026 12:53:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=siemens.com header.i=ludwig.nussel@siemens.com header.b="t/M5EAPj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9EE0480086; Wed, 10 Jun 2026 12:52:57 +0200 (CEST)
Received: from mta-65-227.siemens.flowmailer.net
 (mta-65-227.siemens.flowmailer.net [185.136.65.227])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 01A958484F
 for <u-boot@lists.denx.de>; Wed, 10 Jun 2026 12:52:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ludwig.nussel@siemens.com
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id
 20260610105251ed58180447000207a3 for <u-boot@lists.denx.de>;
 Wed, 10 Jun 2026 12:52:51 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=ludwig.nussel@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=xByg0FqtvjcxpZis6O0byHIysfiArtqDPkP9K8pEku0=;
 b=t/M5EAPjyfZypIqsvZmlexVGk++ZgzPBL9+34vvr3f6aJOIfmO6Z/M834fX7m6TszdLmYV
 etBwdVwCk5lWxRDpkIb4GSZJhLCIkzmVGQHv0PUArhZ37+1uB55I0bJw9w2lIHCHhvuX1hhF
 6eScjos6/iET6L75HTfvswtcJkuxMPRaAHP1WP4dmnIHw+WOwBYRMruzvGSF91n67711JAo/
 eIpQyNSywCT3DxvBDYPhS5KMG8xkSWj2LUl17qPaS0Gywz65V3dv1vzK01oIwj6laXOCzfCv
 1nCkkjHbXQWSl/wtPbShNJ5KZZBqyTcqbKvu55eQBPEQwfdulGa0nX1A==;
From: Ludwig Nussel <ludwig.nussel@siemens.com>
To: u-boot@lists.denx.de
Cc: Ludwig Nussel <ludwig.nussel@siemens.com>,
 David Lechner <dlechner@baylibre.com>, Heiko Schocher <hs@nabladev.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 =?UTF-8?q?Jo=C3=A3o=20Paulo=20Gon=C3=A7alves?= <joao.goncalves@toradex.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Peter Robinson <pbrobinson@gmail.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, Simon Glass <sjg@chromium.org>,
 Sughosh Ganu <sughosh.ganu@arm.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 3/3] tpm: allocate tpm event log if missing
Date: Wed, 10 Jun 2026 12:52:05 +0200
Message-ID: <20260610125204.v2.3.db7fbeb8b6e8499f4d031c04cb5cd8175873b643@changeid>
In-Reply-To: <20260610105243.193355-1-ludwig.nussel@siemens.com>
References: <20260610105243.193355-1-ludwig.nussel@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1328817:519-21489:flowmailer
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

Allocate and attach the TPM event log to the TPM device if not
initialized yet. The address is copied into the device tree for the
kernel so the event log is accessible from Linux userspace too.

Signed-off-by: Ludwig Nussel <ludwig.nussel@siemens.com>

---

Changes in v2:
- imply DEVRES in config TPM
- use fdt_getprop for reading property
- don't wrap #include in #if
- fix memory leak in error case of tcg2_log_prepare_buffer
- handle NULL elog parameter in tcg2_measurement_term
- use CONFIG_TPM2_EVENT_LOG_SIZE
- pass log_size instead of position in dt

 boot/bootm.c         |  18 +++---
 boot/image-fdt.c     |  69 +++++++++++++++++++++++
 include/tpm-common.h |   2 +
 include/tpm_tcg2.h   |   9 +--
 lib/Kconfig          |   1 +
 lib/tpm_tcg2.c       | 130 ++++++++++++++++++++++++++++++++++---------
 6 files changed, 188 insertions(+), 41 deletions(-)

diff --git a/boot/bootm.c b/boot/bootm.c
index 4836d6b2d41..701ec010e01 100644
--- a/boot/bootm.c
+++ b/boot/bootm.c
@@ -921,23 +921,19 @@ int bootm_measure(struct bootm_headers *images)
 		return ret;
 
 	if (IS_ENABLED(CONFIG_MEASURED_BOOT)) {
-		struct tcg2_event_log elog;
 		struct udevice *dev;
 		void *initrd_buf;
 		void *image_buf;
 		const char *s;
 		u32 rd_len;
-		bool ign;
 
-		elog.log_size = 0;
-		ign = IS_ENABLED(CONFIG_MEASURE_IGNORE_LOG);
-		ret = tcg2_measurement_init(&dev, &elog, ign);
-		if (ret)
+		ret = tcg2_measurement_init(&dev, NULL);
+		if (ret && ret != -EEXIST)
 			return ret;
 
 		image_buf = map_sysmem(images->os.image_start,
 				       images->os.image_len);
-		ret = tcg2_measure_data(dev, &elog, 8, images->os.image_len,
+		ret = tcg2_measure_data(dev, NULL, 8, images->os.image_len,
 					image_buf, EV_COMPACT_HASH,
 					strlen("linux") + 1, (u8 *)"linux");
 		if (ret)
@@ -945,14 +941,14 @@ int bootm_measure(struct bootm_headers *images)
 
 		rd_len = images->rd_end - images->rd_start;
 		initrd_buf = map_sysmem(images->rd_start, rd_len);
-		ret = tcg2_measure_data(dev, &elog, 9, rd_len, initrd_buf,
+		ret = tcg2_measure_data(dev, NULL, 9, rd_len, initrd_buf,
 					EV_COMPACT_HASH, strlen("initrd") + 1,
 					(u8 *)"initrd");
 		if (ret)
 			goto unmap_initrd;
 
 		if (IS_ENABLED(CONFIG_MEASURE_DEVICETREE)) {
-			ret = tcg2_measure_data(dev, &elog, 1, images->ft_len,
+			ret = tcg2_measure_data(dev, NULL, 1, images->ft_len,
 						(u8 *)images->ft_addr,
 						EV_TABLE_OF_DEVICES,
 						strlen("dts") + 1,
@@ -964,7 +960,7 @@ int bootm_measure(struct bootm_headers *images)
 		s = env_get("bootargs");
 		if (!s)
 			s = "";
-		ret = tcg2_measure_data(dev, &elog, 1, strlen(s) + 1, (u8 *)s,
+		ret = tcg2_measure_data(dev, NULL, 1, strlen(s) + 1, (u8 *)s,
 					EV_PLATFORM_CONFIG_FLAGS,
 					strlen(s) + 1, (u8 *)s);
 
@@ -973,7 +969,7 @@ unmap_initrd:
 
 unmap_image:
 		unmap_sysmem(image_buf);
-		tcg2_measurement_term(dev, &elog, ret != 0);
+		tcg2_measurement_term(dev, NULL, ret != 0);
 	}
 
 	return ret;
diff --git a/boot/image-fdt.c b/boot/image-fdt.c
index a3a4fb8b558..478158294ed 100644
--- a/boot/image-fdt.c
+++ b/boot/image-fdt.c
@@ -24,6 +24,8 @@
 #include <asm/io.h>
 #include <dm/ofnode.h>
 #include <tee/optee.h>
+#include <tpm_tcg2.h>
+#include <dm/device.h>
 
 DECLARE_GLOBAL_DATA_PTR;
 
@@ -589,6 +591,68 @@ __weak int arch_fixup_fdt(void *blob)
 	return 0;
 }
 
+static int copy_tpm_event_log(void *blob)
+{
+	int rc;
+	struct udevice *dev;
+	ofnode node;
+	char path[256];
+	int off;
+	struct tcg2_event_log *log;
+
+	if (!IS_ENABLED(CONFIG_MEASURED_BOOT))
+		return 0;
+
+	rc = tcg2_platform_get_tpm2(&dev);
+	if (rc)
+		return rc;
+
+	log = tcg2_platform_get_dev_log(dev);
+
+	if (!log || !log->allocated) {
+		log_debug("tpm event log not allocated\n");
+		return -ENOENT;
+	}
+
+	node = dev_ofnode(dev);
+	if (!ofnode_valid(node)) {
+		log_err("tpm %p has no device tree representation\n", dev);
+		return -ENOENT;
+	}
+
+	rc = ofnode_get_path(node, path, sizeof(path));
+	if (rc)
+		return rc;
+
+	off = fdt_path_offset(blob, path);
+	if (off < 0) {
+		log_warning("kernel device tree lacks %s\n", path);
+		return 0;
+	}
+
+	if (fdt_getprop(blob, off, "linux,sml-base", NULL)) {
+		log_warning("kernel dt already defines an event log address at %s\n", path);
+		return 0;
+	}
+
+	fdt64_t base = cpu_to_fdt64((u64)virt_to_phys(log->log));
+
+	rc = fdt_find_and_setprop(blob, path, "linux,sml-base", &base, sizeof(base), 1);
+	if (rc) {
+		log_err("failed to set sml-base: %d\n", rc);
+		return rc;
+	}
+
+	fdt32_t size = cpu_to_fdt32((u32)log->log_size);
+
+	rc = fdt_find_and_setprop(blob, path, "linux,sml-size", &size, sizeof(size), 1);
+	if (rc) {
+		log_err("failed to set sml-size: %d\n", rc);
+		return rc;
+	}
+	return 0;
+}
+
 int image_setup_libfdt(struct bootm_headers *images, void *blob, bool lmb)
 {
 	ulong *initrd_start = &images->initrd_start;
@@ -631,6 +695,11 @@ int image_setup_libfdt(struct bootm_headers *images, void *blob, bool lmb)
 		goto err;
 	}
 
+	fdt_ret = copy_tpm_event_log(blob);
+	if (fdt_ret && fdt_ret != -ENOENT && fdt_ret != -ENODEV) {
+		log_warning("Failed to copy TPM event log: %d\n", fdt_ret);
+	}
+
 	/* Store name of configuration node as u-boot,bootconf in /chosen node */
 	if (images->fit_uname_cfg)
 		fdt_find_and_setprop(blob, "/chosen", "u-boot,bootconf",
diff --git a/include/tpm-common.h b/include/tpm-common.h
index bfb84a931d1..3be69e7f392 100644
--- a/include/tpm-common.h
+++ b/include/tpm-common.h
@@ -10,6 +10,7 @@
 #include <command.h>
 
 struct udevice;
+struct tcg2_event_log;
 
 enum tpm_duration {
 	TPM_SHORT = 0,
@@ -83,6 +84,7 @@ struct tpm_chip_priv {
 	u32 active_banks[TPM2_NUM_PCR_BANKS];
 #endif
 	bool plat_hier_disabled;
+	struct tcg2_event_log *log;
 };
 
 /**
diff --git a/include/tpm_tcg2.h b/include/tpm_tcg2.h
index eb6afe49e77..db3f6f486e9 100644
--- a/include/tpm_tcg2.h
+++ b/include/tpm_tcg2.h
@@ -162,12 +162,14 @@ struct tcg_efi_spec_id_event {
  * @log_position:	Current entry position
  * @log_size:		Log space available
  * @found:		Boolean indicating if an existing log was discovered
+ * @allocated:		Boolean indicating that the log was allocated by u-boot
  */
 struct tcg2_event_log {
 	u8 *log;
 	u32 log_position;
 	u32 log_size;
 	bool found;
+	bool allocated;
 };
 
 /**
@@ -291,13 +293,10 @@ int tcg2_log_prepare_buffer(struct udevice *dev, struct tcg2_event_log *elog,
  *			memory region, in which case any existing log
  *			discovered will be copied to the specified memory
  *			region.
- * @ignore_existing_log Boolean to indicate whether or not to ignore an
- *			existing platform log in memory
  *
  * Return: zero on success, negative errno otherwise
  */
-int tcg2_measurement_init(struct udevice **dev, struct tcg2_event_log *elog,
-			  bool ignore_existing_log);
+int tcg2_measurement_init(struct udevice **dev, struct tcg2_event_log *elog);
 
 /**
  * Stop measurements and record separator events.
@@ -345,4 +344,6 @@ void tcg2_platform_startup_error(struct udevice *dev, int rc);
  */
 u32 tcg2_algorithm_to_mask(enum tpm2_algorithms);
 
+struct tcg2_event_log *tcg2_platform_get_dev_log(struct udevice *dev);
+
 #endif /* __TPM_TCG_V2_H */
diff --git a/lib/Kconfig b/lib/Kconfig
index cf13ac1bdad..170621ae266 100644
--- a/lib/Kconfig
+++ b/lib/Kconfig
@@ -493,6 +493,7 @@ config TPM
 	bool "Trusted Platform Module (TPM) Support"
 	depends on DM
 	imply DM_RNG
+	imply DEVRES
 	select SHA1
 	help
 	  This enables support for TPMs which can be used to provide security
diff --git a/lib/tpm_tcg2.c b/lib/tpm_tcg2.c
index d41228f75a9..2270b038cf5 100644
--- a/lib/tpm_tcg2.c
+++ b/lib/tpm_tcg2.c
@@ -21,6 +21,7 @@
 #include <linux/unaligned/le_byteshift.h>
 #include "tpm-utils.h"
 #include <bloblist.h>
+#include <dm/devres.h>
 
 int tcg2_get_pcr_info(struct udevice *dev, u32 *supported_bank, u32 *active_bank,
 		      u32 *bank_num)
@@ -212,6 +213,9 @@ static int tcg2_log_append_check(struct tcg2_event_log *elog, u32 pcr_index,
 	u32 event_size;
 	u8 *log;
 
+	if (!elog || !elog->log_size)
+		return 0;
+
 	event_size = size + tcg2_event_get_size(digest_list);
 	if (elog->log_position + event_size > elog->log_size) {
 		printf("%s: log too large: %u + %u > %u\n", __func__,
@@ -553,6 +557,9 @@ int tcg2_measure_data(struct udevice *dev, struct tcg2_event_log *elog,
 	if (rc)
 		return rc;
 
+	if (!elog)
+		elog = tcg2_platform_get_dev_log(dev);
+
 	return tcg2_log_append_check(elog, pcr_index, event_type, &digest_list,
 				     event_size, event);
 }
@@ -560,15 +567,32 @@ int tcg2_measure_data(struct udevice *dev, struct tcg2_event_log *elog,
 int tcg2_log_prepare_buffer(struct udevice *dev, struct tcg2_event_log *elog,
 			    bool ignore_existing_log)
 {
-	struct tcg2_event_log log;
+	struct tcg2_event_log log = {};
 	int rc;
 	u32 log_active = 0;
 
-	elog->log_position = 0;
-	elog->found = false;
+	if (elog) {
+		elog->log_position = 0;
+		elog->found = false;
+		elog->allocated = false;
+	} else if (tcg2_platform_get_dev_log(dev)) {
+		return -EEXIST;
+	}
 
 	rc = tcg2_platform_get_log(dev, (void **)&log.log, &log.log_size);
-	if (!rc) {
+	/* no existing event log found and none allocated yet */
+	if (rc && !elog) {
+		log.log_size = CONFIG_TPM2_EVENT_LOG_SIZE;
+		log.log = devm_kzalloc(dev, log.log_size, 0);
+		if (log.log) {
+			log.allocated = true;
+			ignore_existing_log = true;
+		} else {
+			log_err("Failed to allocate %u bytes event log\n", log.log_size);
+		}
+	}
+
+	if (log.log) {
 		log.log_position = 0;
 		log.found = false;
 
@@ -577,49 +601,78 @@ int tcg2_log_prepare_buffer(struct udevice *dev, struct tcg2_event_log *elog,
 			if (rc == -ERESTARTSYS && log_active)
 				goto pcr_allocate;
 			if (rc)
-				return rc;
+				goto out;
 		}
 
-		if (elog->log_size) {
-			if (log.found) {
-				if (elog->log_size < log.log_position)
-					return -ENOBUFS;
-
-				/*
-				 * Copy the discovered log into the user buffer
-				 * if there's enough space.
-				 */
-				memcpy(elog->log, log.log, log.log_position);
+		if (elog) {
+			if (elog->log_size) {
+				if (log.found) {
+					if (elog->log_size < log.log_position) {
+						rc = -ENOBUFS;
+						goto out;
+					}
+
+					/*
+					 * Copy the discovered log into the user buffer
+					 * if there's enough space.
+					 */
+					memcpy(elog->log, log.log, log.log_position);
+				}
+
+				unmap_physmem(log.log, MAP_NOCACHE);
+			} else {
+				elog->log = log.log;
+				elog->log_size = log.log_size;
 			}
+			log.log = NULL;
 
-			unmap_physmem(log.log, MAP_NOCACHE);
+			elog->log_position = log.log_position;
+			elog->found = log.found;
 		} else {
+			struct tpm_chip_priv *priv = dev_get_uclass_priv(dev);
+
+			elog = devm_kzalloc(dev, sizeof(struct tcg2_event_log), 0);
+			if (!elog)
+				goto out;
+
 			elog->log = log.log;
 			elog->log_size = log.log_size;
-		}
+			elog->log_position = log.log_position;
+			elog->found = log.found;
+			elog->allocated = log.allocated;
+
+			priv->log = elog;
 
-		elog->log_position = log.log_position;
-		elog->found = log.found;
+			log.log = NULL;
+		}
 	}
 
 pcr_allocate:
 	rc = tpm2_activate_banks(dev, log_active);
 	if (rc)
-		return rc;
+		goto out;
 
 	/*
 	 * Initialize the log buffer if no log was discovered and the buffer is
 	 * valid. User's can pass in their own buffer as a fallback if no
 	 * memory region is found.
 	 */
-	if (!elog->found && elog->log_size)
-		rc = tcg2_log_init(dev, elog);
+	if (elog) {
+		if (!elog->found && elog->log_size)
+			rc = tcg2_log_init(dev, elog);
+	}
+
+out:
+	if (rc && log.log && log.allocated) {
+		devm_kfree(dev, log.log);
+		log.log = NULL;
+		log.log_size = 0;
+	}
 
 	return rc;
 }
 
-int tcg2_measurement_init(struct udevice **dev, struct tcg2_event_log *elog,
-			  bool ignore_existing_log)
+int tcg2_measurement_init(struct udevice **dev, struct tcg2_event_log *elog)
 {
 	int rc;
 
@@ -627,11 +680,14 @@ int tcg2_measurement_init(struct udevice **dev, struct tcg2_event_log *elog,
 	if (rc)
 		return rc;
 
+	if (!elog && tcg2_platform_get_dev_log(*dev))
+		return -EEXIST;
+
 	rc = tpm_auto_start(*dev);
 	if (rc)
 		return rc;
 
-	rc = tcg2_log_prepare_buffer(*dev, elog, ignore_existing_log);
+	rc = tcg2_log_prepare_buffer(*dev, elog, IS_ENABLED(CONFIG_MEASURE_IGNORE_LOG));
 	if (rc) {
 		tcg2_measurement_term(*dev, elog, true);
 		return rc;
@@ -654,14 +710,36 @@ void tcg2_measurement_term(struct udevice *dev, struct tcg2_event_log *elog,
 	u32 event = error ? 0x1 : 0xffffffff;
 	int i;
 
+	/*
+	 * we don't check elog before. Even if there is none, try to
+	 * write the terminating PCR measurements
+	 */
 	for (i = 0; i < 8; ++i)
 		tcg2_measure_event(dev, elog, i, EV_SEPARATOR, sizeof(event),
 				   (const u8 *)&event);
+	if (!elog)
+		elog = tcg2_platform_get_dev_log(dev);
 
-	if (elog->log)
+	if (elog && elog->log)
 		unmap_physmem(elog->log, MAP_NOCACHE);
 }
 
+/**
+ * tcg2_platform_get_dev_log() - Get the TPM event log for a device
+ *
+ * @dev: TPM device
+ *
+ * Return: Pointer to the TPM event log structure for this device, or NULL if not allocated
+ */
+struct tcg2_event_log *tcg2_platform_get_dev_log(struct udevice *dev)
+{
+	struct tpm_chip_priv *priv;
+
+	priv = dev_get_uclass_priv(dev);
+
+	return priv->log;
+}
+
 __weak int tcg2_platform_get_log(struct udevice *dev, void **addr, u32 *size)
 {
 	const __be32 *addr_prop = NULL;
-- 
2.43.0

