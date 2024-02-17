Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B84BC48BC3
	for <u-boot@archiver.kernel.org>; Sat, 17 Feb 2024 12:26:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CAF7487C80;
	Sat, 17 Feb 2024 13:26:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="vWhb/YN7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 86ED1879F0; Sat, 17 Feb 2024 13:26:21 +0100 (CET)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3215C87C9E
 for <u-boot@lists.denx.de>; Sat, 17 Feb 2024 13:26:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=danishanwar@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 41HCQ6hF104873;
 Sat, 17 Feb 2024 06:26:06 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1708172766;
 bh=eiInjqxqSEP1xkfWuGoZDktdOIRgmNlePHHDwSnIg30=;
 h=From:To:CC:Subject:Date;
 b=vWhb/YN7hvieMqDJGzcksEqStU7PvAdmU034uJZRSBwJL7tl4+RPwexLJBWPr3b7O
 FwHFjGg7uwIkSqjZnxq3rEOzN9564qkdRDvfYWJqmXhFfnMDQwBhfaBbpZ6hAahdfY
 uQYa1YHasvj4FSOFZ6KL/idrg/+8wywBZE1eahR0=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 41HCQ6e7083764
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Sat, 17 Feb 2024 06:26:06 -0600
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Sat, 17
 Feb 2024 06:26:05 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Sat, 17 Feb 2024 06:26:05 -0600
Received: from lelv0854.itg.ti.com (lelv0854.itg.ti.com [10.181.64.140])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 41HCQ58o001726;
 Sat, 17 Feb 2024 06:26:05 -0600
Received: from localhost (danish-tpc.dhcp.ti.com [10.24.69.25])
 by lelv0854.itg.ti.com (8.14.7/8.14.7) with ESMTP id 41HCQ4Du005020;
 Sat, 17 Feb 2024 06:26:04 -0600
From: MD Danish Anwar <danishanwar@ti.com>
To: Max Krummenacher <max.krummenacher@toradex.com>, Francesco Dolcini
 <francesco.dolcini@toradex.com>, Dan Carpenter <dan.carpenter@linaro.org>,
 Simon Glass <sjg@chromium.org>, Nishanth Menon <nm@ti.com>, MD Danish Anwar
 <danishanwar@ti.com>, Tom Rini <trini@konsulko.com>
CC: <u-boot@lists.denx.de>, <srk@ti.com>, Vignesh Raghavendra
 <vigneshr@ti.com>, <r-gunasekaran@ti.com>,
 Roger Quadros <rogerq@kernel.org>
Subject: [PATCH v5] remoteproc: uclass: Add methods to load firmware to rproc
 and boot rproc
Date: Sat, 17 Feb 2024 17:56:02 +0530
Message-ID: <20240217122602.3402774-1-danishanwar@ti.com>
X-Mailer: git-send-email 2.34.1
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

Add APIs to set a firmware_name to a rproc and boot the rproc with the
same firmware.

Clients can call rproc_set_firmware() API to set firmware_name for a rproc
whereas rproc_boot() will load the firmware set by rproc_set_firmware() to
a buffer by calling request_firmware_into_buf(). rproc_boot() will then
load the firmware file to the remote processor and start the remote
processor.

Also include "fs-loader.h" and make remoteproc driver select FS_LOADER in
Kconfig so that we can call request_firmware_into_buf() from remoteproc
driver.

Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
---
Changes from v4 to v5:
*) Added Kconfig option REMOTEPROC_MAX_FW_SIZE to set max firmware size
   that can be loaded to a rproc.
*) Added freeing of address in rproc_boot() as pointed out by Ravi.
*) Allocating the address at a later point in rproc_boot()
*) Rebased on latest u-boot/master [commit 
   9e00b6993f724da9699ef12573307afea8c19284]

Changes from v3 to v4:
*) No functional change. Splitted the patch out of the series as suggested
   by Nishant.
*) Droppped the RFC tag.

v4: https://lore.kernel.org/all/20240130063322.2345057-1-danishanwar@ti.com/
v3: https://lore.kernel.org/all/20240124064930.1787929-4-danishanwar@ti.com/

 drivers/remoteproc/Kconfig        |   8 +++
 drivers/remoteproc/rproc-uclass.c | 100 ++++++++++++++++++++++++++++++
 include/remoteproc.h              |  34 ++++++++++
 3 files changed, 142 insertions(+)

diff --git a/drivers/remoteproc/Kconfig b/drivers/remoteproc/Kconfig
index 781de530af..759d21437a 100644
--- a/drivers/remoteproc/Kconfig
+++ b/drivers/remoteproc/Kconfig
@@ -10,6 +10,7 @@ menu "Remote Processor drivers"
 # All users should depend on DM
 config REMOTEPROC
 	bool
+	select FS_LOADER
 	depends on DM
 
 # Please keep the configuration alphabetically sorted.
@@ -102,4 +103,11 @@ config REMOTEPROC_TI_IPU
 	help
 	  Say 'y' here to add support for TI' K3 remoteproc driver.
 
+config REMOTEPROC_MAX_FW_SIZE
+	hex "Maximum size of firmware that needs to be loaded to rproc"
+	default 0x10000
+	help
+	  Maximum size of the firmware file (elf, binary) that needs to be
+	  loaded to th rproc core.
+
 endmenu
diff --git a/drivers/remoteproc/rproc-uclass.c b/drivers/remoteproc/rproc-uclass.c
index 28b362c887..784361cef9 100644
--- a/drivers/remoteproc/rproc-uclass.c
+++ b/drivers/remoteproc/rproc-uclass.c
@@ -13,6 +13,7 @@
 #include <log.h>
 #include <malloc.h>
 #include <virtio_ring.h>
+#include <fs_loader.h>
 #include <remoteproc.h>
 #include <asm/io.h>
 #include <dm/device-internal.h>
@@ -961,3 +962,102 @@ unsigned long rproc_parse_resource_table(struct udevice *dev, struct rproc *cfg)
 
 	return 1;
 }
+
+int rproc_set_firmware(struct udevice *rproc_dev, const char *fw_name)
+{
+	struct dm_rproc_uclass_pdata *uc_pdata;
+	int len;
+	char *p;
+
+	if (!rproc_dev || !fw_name)
+		return -EINVAL;
+
+	uc_pdata = dev_get_uclass_plat(rproc_dev);
+	if (!uc_pdata)
+		return -EINVAL;
+
+	len = strcspn(fw_name, "\n");
+	if (!len) {
+		debug("invalid firmware name\n");
+		return -EINVAL;
+	}
+
+	p = strndup(fw_name, len);
+	if (!p)
+		return -ENOMEM;
+
+	uc_pdata->fw_name = p;
+
+	return 0;
+}
+
+int rproc_boot(struct udevice *rproc_dev)
+{
+	struct dm_rproc_uclass_pdata *uc_pdata;
+	struct udevice *fs_loader;
+	int core_id, ret = 0;
+	char *firmware;
+	void *addr;
+
+	if (!rproc_dev)
+		return -EINVAL;
+
+	uc_pdata = dev_get_uclass_plat(rproc_dev);
+	if (!uc_pdata)
+		return -EINVAL;
+
+	core_id = dev_seq(rproc_dev);
+	firmware = uc_pdata->fw_name;
+
+	if (!firmware) {
+		debug("No firmware set for rproc core %d\n", core_id);
+		return -EINVAL;
+	}
+
+	/* Initialize all rproc cores */
+	if (!rproc_is_initialized()) {
+		ret = rproc_init();
+		if (ret) {
+			debug("rproc_init() failed: %d\n", ret);
+			return ret;
+		}
+	}
+
+	/* Loading firmware to a given address */
+	ret = get_fs_loader(&fs_loader);
+	if (ret) {
+		debug("could not get fs loader: %d\n", ret);
+		return ret;
+	}
+
+	if (CONFIG_REMOTEPROC_MAX_FW_SIZE) {
+		addr = malloc(CONFIG_REMOTEPROC_MAX_FW_SIZE);
+		if (!addr)
+			return -ENOMEM;
+	} else {
+		debug("CONFIG_REMOTEPROC_MAX_FW_SIZE not defined\n");
+		return -EINVAL;
+	}
+
+	ret = request_firmware_into_buf(fs_loader, firmware, addr, CONFIG_REMOTEPROC_MAX_FW_SIZE,
+					0);
+	if (ret < 0) {
+		debug("could not request %s: %d\n", firmware, ret);
+		goto free_buffer;
+	}
+
+	ret = rproc_load(core_id, (ulong)addr, ret);
+	if (ret) {
+		debug("failed to load %s to rproc core %d from addr 0x%08lX err %d\n",
+		      uc_pdata->fw_name, core_id, (ulong)addr, ret);
+		goto free_buffer;
+	}
+
+	ret = rproc_start(core_id);
+	if (ret)
+		debug("failed to start rproc core %d\n", core_id);
+
+free_buffer:
+	free(addr);
+	return ret;
+}
diff --git a/include/remoteproc.h b/include/remoteproc.h
index 91a88791a4..6f8068e149 100644
--- a/include/remoteproc.h
+++ b/include/remoteproc.h
@@ -403,6 +403,7 @@ enum rproc_mem_type {
  * @name: Platform-specific way of naming the Remote proc
  * @mem_type: one of 'enum rproc_mem_type'
  * @driver_plat_data: driver specific platform data that may be needed.
+ * @fw_name: firmware name
  *
  * This can be accessed with dev_get_uclass_plat() for any UCLASS_REMOTEPROC
  * device.
@@ -412,6 +413,7 @@ struct dm_rproc_uclass_pdata {
 	const char *name;
 	enum rproc_mem_type mem_type;
 	void *driver_plat_data;
+	char *fw_name;
 };
 
 /**
@@ -705,6 +707,34 @@ unsigned long rproc_parse_resource_table(struct udevice *dev,
 struct resource_table *rproc_find_resource_table(struct udevice *dev,
 						 unsigned int addr,
 						 int *tablesz);
+/**
+ * rproc_set_firmware() - assign a new firmware name
+ * @rproc_dev: device for which new firmware name is being assigned
+ * @fw_name: new firmware name to be assigned
+ *
+ * This function allows remoteproc drivers or clients to configure a custom
+ * firmware name. The function does not trigger a remote processor boot,
+ * only sets the firmware name used for a subsequent boot.
+ *
+ * This function sets the fw_name field in uclass pdata of the Remote proc
+ *
+ * Return: 0 on success or a negative value upon failure
+ */
+int rproc_set_firmware(struct udevice *rproc_dev, const char *fw_name);
+
+/**
+ * rproc_boot() - boot a remote processor
+ * @rproc_dev: rproc device to boot
+ *
+ * Boot a remote processor (i.e. load its firmware, power it on, ...).
+ *
+ * This function first loads the firmware set in the uclass pdata of Remote
+ * processor to a buffer and then loads firmware to the remote processor
+ * using rproc_load().
+ *
+ * Return: 0 on success, and an appropriate error value otherwise
+ */
+int rproc_boot(struct udevice *rproc_dev);
 #else
 static inline int rproc_init(void) { return -ENOSYS; }
 static inline int rproc_dev_init(int id) { return -ENOSYS; }
@@ -744,6 +774,10 @@ static inline int rproc_elf_load_rsc_table(struct udevice *dev, ulong fw_addr,
 					   ulong fw_size, ulong *rsc_addr,
 					   ulong *rsc_size)
 { return -ENOSYS; }
+static inline int rproc_set_firmware(struct udevice *rproc_dev, const char *fw_name)
+{ return -ENOSYS; }
+static inline int rproc_boot(struct udevice *rproc_dev)
+{ return -ENOSYS; }
 #endif
 
 #endif	/* _RPROC_H_ */
-- 
2.34.1

