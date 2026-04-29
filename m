Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 702BDFF8867
	for <u-boot@archiver.kernel.org>; Wed, 29 Apr 2026 11:43:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8B42884837;
	Wed, 29 Apr 2026 13:43:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=siemens.com header.i=ludwig.nussel@siemens.com header.b="lXbzWWul";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A214284849; Wed, 29 Apr 2026 13:43:15 +0200 (CEST)
Received: from mta-64-226.siemens.flowmailer.net
 (mta-64-226.siemens.flowmailer.net [185.136.64.226])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 47F658483A
 for <u-boot@lists.denx.de>; Wed, 29 Apr 2026 13:43:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ludwig.nussel@siemens.com
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id
 20260429114313079ee54053000207db for <u-boot@lists.denx.de>;
 Wed, 29 Apr 2026 13:43:13 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=ludwig.nussel@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=aBPoPLzIxCJlV/gVXzT4T8wgDJj+kcxBlRbOjAUB5rU=;
 b=lXbzWWullAiNd9ePRAWSrowUjoVYC+Yb26DGU6xF4tNeh1y7teQ1xAsrMNRF1efckgL23c
 XNsvmlD1cOwWgAsKccEf2xXiSG0SY9YNyfnK4niXpiplcTnd9oe802cEAVAKQ/06TN2HLtSN
 XVKnSG42WsGJOXC5ZRe909KRQIOAt30Jm3rM/OY6R2Lv53l0DDyEn9yTaAx+Hg+zwAe6+nTE
 842plpSHs/OnLQQ942CSMB76ulsb9HeDwqnr8ETXlD0CsO6Kwkf/2J1JvDfmpV0ROf8cq8M2
 VhgsCZnK0Tc8+wxNjyPZZztUSmIkc+i5YxOtbEZlb9PiK7KlpRJ3PveQ==;
From: Ludwig Nussel <ludwig.nussel@siemens.com>
To: u-boot@lists.denx.de
Cc: Ludwig Nussel <ludwig.nussel@siemens.com>, Anshul Dalal <anshuld@ti.com>,
 Aristo Chen <jj251510319013@gmail.com>, Benjamin ROBIN <dev@benjarobin.fr>,
 George Chan <gchan9527@gmail.com>, Heiko Schocher <hs@nabladev.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 =?UTF-8?q?Jo=C3=A3o=20Paulo=20Gon=C3=A7alves?= <joao.goncalves@toradex.com>,
 "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Martin Schwan <m.schwan@phytec.de>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>, Peng Fan <peng.fan@nxp.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, Simon Glass <sjg@chromium.org>,
 Sughosh Ganu <sughosh.ganu@arm.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 3/3] tpm: allocate tpm event log if missing
Date: Wed, 29 Apr 2026 13:41:43 +0200
Message-ID: <20260429134142.3.db7fbeb8b6e8499f4d031c04cb5cd8175873b643@changeid>
In-Reply-To: <20260429114250.791663-1-ludwig.nussel@siemens.com>
References: <20260429114250.791663-1-ludwig.nussel@siemens.com>
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

 boot/Kconfig         |   1 +
 boot/bootm.c         |  18 +++-----
 boot/image-fdt.c     |  67 ++++++++++++++++++++++++++++
 include/tpm-common.h |   1 +
 include/tpm_tcg2.h   |   9 ++--
 lib/tpm_tcg2.c       | 101 +++++++++++++++++++++++++++++++++----------
 6 files changed, 160 insertions(+), 37 deletions(-)

diff --git a/boot/Kconfig b/boot/Kconfig
index ae6f09a6ede..a4e23f9c78a 100644
--- a/boot/Kconfig
+++ b/boot/Kconfig
@@ -1041,6 +1041,7 @@ config MEASURED_BOOT
 	select SHA384
 	select SHA512
 	select SM3
+	select DEVRES
 	help
 	  This option enables measurement of the boot process when booting
 	  without UEFI . Measurement involves creating cryptographic hashes
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
index a3a4fb8b558..f9cab464452 100644
--- a/boot/image-fdt.c
+++ b/boot/image-fdt.c
@@ -24,6 +24,10 @@
 #include <asm/io.h>
 #include <dm/ofnode.h>
 #include <tee/optee.h>
+#if defined(CONFIG_MEASURED_BOOT)
+#include <tpm_tcg2.h>
+#include <dm/device.h>
+#endif
 
 DECLARE_GLOBAL_DATA_PTR;
 
@@ -589,6 +593,67 @@ __weak int arch_fixup_fdt(void *blob)
 	return 0;
 }
 
+static int copy_tpm_event_log(void *blob)
+{
+#if defined(CONFIG_MEASURED_BOOT)
+	int rc;
+	struct udevice *dev;
+	ofnode node;
+	char path[256];
+	char *end;
+	struct tcg2_event_log *log;
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
+	if (fdt_path_offset(blob, path) < 0) {
+		log_warning("kernel device tree lacks %s\n", path);
+		return 0;
+	}
+
+	strlcat(path, "/linux,sml-base", sizeof(path));
+	if (fdt_path_offset(blob, path) >= 0) {
+		log_warning("kernel dt already defines an event log address at %s\n", path);
+		return 0;
+	}
+	end = strrchr(path, '/');
+	*end = 0;
+
+	fdt64_t a = cpu_to_fdt64((u64)virt_to_phys(log->log));
+	fdt32_t s = cpu_to_fdt32((u32)log->log_position);
+
+	rc = fdt_find_and_setprop(blob, path, "linux,sml-base", &a, sizeof(a), 1);
+	if (rc) {
+		log_err("failed to set sml-base: %d\n", rc);
+		return rc;
+	}
+	rc = fdt_find_and_setprop(blob, path, "linux,sml-size", &s, sizeof(s), 1);
+	if (rc) {
+		log_err("failed to set sml-size: %d\n", rc);
+		return rc;
+	}
+#endif
+	return 0;
+}
+
 int image_setup_libfdt(struct bootm_headers *images, void *blob, bool lmb)
 {
 	ulong *initrd_start = &images->initrd_start;
@@ -631,6 +696,8 @@ int image_setup_libfdt(struct bootm_headers *images, void *blob, bool lmb)
 		goto err;
 	}
 
+	copy_tpm_event_log(blob);
+
 	/* Store name of configuration node as u-boot,bootconf in /chosen node */
 	if (images->fit_uname_cfg)
 		fdt_find_and_setprop(blob, "/chosen", "u-boot,bootconf",
diff --git a/include/tpm-common.h b/include/tpm-common.h
index bfb84a931d1..f02dae679bd 100644
--- a/include/tpm-common.h
+++ b/include/tpm-common.h
@@ -83,6 +83,7 @@ struct tpm_chip_priv {
 	u32 active_banks[TPM2_NUM_PCR_BANKS];
 #endif
 	bool plat_hier_disabled;
+	void *log; /* struct tcg2_event_log */
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
diff --git a/lib/tpm_tcg2.c b/lib/tpm_tcg2.c
index d41228f75a9..4ea4b6d992f 100644
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
 
+	if (!elog->log_size)
+		return 0;
+
 	event_size = size + tcg2_event_get_size(digest_list);
 	if (elog->log_position + event_size > elog->log_size) {
 		printf("%s: log too large: %u + %u > %u\n", __func__,
@@ -542,6 +546,14 @@ int tcg2_measure_data(struct udevice *dev, struct tcg2_event_log *elog,
 	struct tpml_digest_values digest_list;
 	int rc;
 
+	if (!elog)
+		elog = tcg2_platform_get_dev_log(dev);
+
+	if (!elog) {
+		log_err("no event log allocated");
+		return -ENOENT;
+	}
+
 	if (data)
 		rc = tcg2_create_digest(dev, data, size, &digest_list);
 	else
@@ -564,11 +576,29 @@ int tcg2_log_prepare_buffer(struct udevice *dev, struct tcg2_event_log *elog,
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
+		/* magic size value. Same as in acpi_table.c */
+		log.log_size = 0x10000;
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
 
@@ -580,26 +610,40 @@ int tcg2_log_prepare_buffer(struct udevice *dev, struct tcg2_event_log *elog,
 				return rc;
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
+					if (elog->log_size < log.log_position)
+						return -ENOBUFS;
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
 
-			unmap_physmem(log.log, MAP_NOCACHE);
+			elog->log_position = log.log_position;
+			elog->found = log.found;
 		} else {
+			struct tpm_chip_priv *priv = dev_get_uclass_priv(dev);
+
+			elog = devm_kzalloc(dev, sizeof(struct tcg2_event_log), 0);
+
 			elog->log = log.log;
 			elog->log_size = log.log_size;
-		}
+			elog->log_position = log.log_position;
+			elog->found = log.found;
+			elog->allocated = log.allocated;
 
-		elog->log_position = log.log_position;
-		elog->found = log.found;
+			priv->log = elog;
+		}
 	}
 
 pcr_allocate:
@@ -612,14 +656,15 @@ pcr_allocate:
 	 * valid. User's can pass in their own buffer as a fallback if no
 	 * memory region is found.
 	 */
-	if (!elog->found && elog->log_size)
-		rc = tcg2_log_init(dev, elog);
+	if (elog) {
+		if (!elog->found && elog->log_size)
+			rc = tcg2_log_init(dev, elog);
+	}
 
 	return rc;
 }
 
-int tcg2_measurement_init(struct udevice **dev, struct tcg2_event_log *elog,
-			  bool ignore_existing_log)
+int tcg2_measurement_init(struct udevice **dev, struct tcg2_event_log *elog)
 {
 	int rc;
 
@@ -627,11 +672,14 @@ int tcg2_measurement_init(struct udevice **dev, struct tcg2_event_log *elog,
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
@@ -662,6 +710,15 @@ void tcg2_measurement_term(struct udevice *dev, struct tcg2_event_log *elog,
 		unmap_physmem(elog->log, MAP_NOCACHE);
 }
 
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

