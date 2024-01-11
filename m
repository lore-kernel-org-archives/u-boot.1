Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5F3EC47258
	for <u-boot@archiver.kernel.org>; Thu, 11 Jan 2024 13:08:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1CF1B87AEF;
	Thu, 11 Jan 2024 14:08:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="edpCCfTu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E908A87A3B; Thu, 11 Jan 2024 08:06:53 +0100 (CET)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AC35287A61
 for <u-boot@lists.denx.de>; Thu, 11 Jan 2024 08:06:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=danishanwar@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 40B76W0O127228;
 Thu, 11 Jan 2024 01:06:32 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1704956792;
 bh=pS0x6qzppQ1eh6xyBXCC61Y+A7dLgo3zysq5GZoRKl8=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=edpCCfTujDGkt6cyYKhID1gJ0AQ4o6IYIwAISPWfI+yw7bqFawV28ktEamGisZ+Yz
 DQ1LE2msxza1kknBIKKd5+R9SoAQwY2mv8uNT1hc+gMyoN9qfRPFueLELPm7EvBwKT
 dhKxpaTHV20OnwqkbsOLJVAFmo4aTZRMjCPiB3ic=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 40B76WSE001889
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 11 Jan 2024 01:06:32 -0600
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 11
 Jan 2024 01:06:31 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 11 Jan 2024 01:06:31 -0600
Received: from lelv0854.itg.ti.com (lelv0854.itg.ti.com [10.181.64.140])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 40B76VvD090278;
 Thu, 11 Jan 2024 01:06:31 -0600
Received: from localhost (danish-tpc.dhcp.ti.com [10.24.69.25])
 by lelv0854.itg.ti.com (8.14.7/8.14.7) with ESMTP id 40B76Ufe017676;
 Thu, 11 Jan 2024 01:06:31 -0600
From: MD Danish Anwar <danishanwar@ti.com>
To: Dan Carpenter <dan.carpenter@linaro.org>, Siddharth Vadapalli
 <s-vadapalli@ti.com>, Maxime Ripard <mripard@kernel.org>, Roger Quadros
 <rogerq@kernel.org>, Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
 Stefan Roese <sr@denx.de>, Qu Wenruo <wqu@suse.com>, Sean Anderson
 <seanga2@gmail.com>, Bryan Brattlof <bb@ti.com>, Heinrich Schuchardt
 <xypron.glpk@gmx.de>, Christian Gmeiner <christian.gmeiner@gmail.com>,
 Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>, Andy
 Shevchenko <andriy.shevchenko@linux.intel.com>, Nikhil M Jain
 <n-jain1@ti.com>, Manorit Chawdhry <m-chawdhry@ti.com>, Andrew Davis
 <afd@ti.com>, Neha Malcom Francis <n-francis@ti.com>, Simon Glass
 <sjg@chromium.org>, MD Danish Anwar <danishanwar@ti.com>, FUKAUMI Naoki
 <naoki@radxa.com>, Christian Hewitt <christianshewitt@gmail.com>, Hai Pham
 <hai.pham.ud@renesas.com>, Svyatoslav Ryhel <clamor95@gmail.com>, Jonas
 Karlman <jonas@kwiboo.se>, Neil Armstrong <neil.armstrong@linaro.org>,
 Marek Vasut <marex@denx.de>, Michal Simek <michal.simek@amd.com>,
 Kever Yang <kever.yang@rock-chips.com>, Ramon Fried <rfried.dev@gmail.com>,
 Joe Hershberger <joe.hershberger@ni.com>
CC: <u-boot@lists.denx.de>, <srk@ti.com>, <r-gunasekaran@ti.com>
Subject: [RFC PATCH v2 03/15] remoteproc: uclass: Add methods to load firmware
 to rproc and boot rproc
Date: Thu, 11 Jan 2024 12:35:59 +0530
Message-ID: <20240111070611.342701-4-danishanwar@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240111070611.342701-1-danishanwar@ti.com>
References: <20240111070611.342701-1-danishanwar@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Mailman-Approved-At: Thu, 11 Jan 2024 14:08:34 +0100
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
 drivers/remoteproc/Kconfig        |  1 +
 drivers/remoteproc/rproc-uclass.c | 85 +++++++++++++++++++++++++++++++
 include/remoteproc.h              | 35 +++++++++++++
 3 files changed, 121 insertions(+)

diff --git a/drivers/remoteproc/Kconfig b/drivers/remoteproc/Kconfig
index 781de530af..0fdf1b38ea 100644
--- a/drivers/remoteproc/Kconfig
+++ b/drivers/remoteproc/Kconfig
@@ -10,6 +10,7 @@ menu "Remote Processor drivers"
 # All users should depend on DM
 config REMOTEPROC
 	bool
+	select FS_LOADER
 	depends on DM
 
 # Please keep the configuration alphabetically sorted.
diff --git a/drivers/remoteproc/rproc-uclass.c b/drivers/remoteproc/rproc-uclass.c
index 28b362c887..76db4157f7 100644
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
@@ -961,3 +962,87 @@ unsigned long rproc_parse_resource_table(struct udevice *dev, struct rproc *cfg)
 
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
+
+	len = strcspn(fw_name, "\n");
+	if (!len) {
+		debug("can't provide empty string for firmware name\n");
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
+int rproc_boot(struct udevice *rproc_dev, size_t fw_size)
+{
+	struct dm_rproc_uclass_pdata *uc_pdata;
+	struct udevice *fs_loader;
+	void *addr = malloc(fw_size);
+	int core_id, ret = 0;
+	char *firmware;
+	ulong rproc_addr;
+
+	if (!rproc_dev)
+		return -EINVAL;
+
+	if (!addr)
+		return -ENOMEM;
+
+	uc_pdata = dev_get_uclass_plat(rproc_dev);
+	core_id = dev_seq(rproc_dev);
+	firmware = uc_pdata->fw_name;
+
+	if (!firmware) {
+		debug("No firmware set for rproc core %d\n", core_id);
+		return -EINVAL;
+	}
+
+	/* Initialize all rproc cores */
+	rproc_init();
+
+	/* Loading firmware to a given address */
+	ret = get_fs_loader(&fs_loader);
+	if (ret) {
+		debug("could not get fs loader: %d\n", ret);
+		return ret;
+	}
+
+	ret = request_firmware_into_buf(fs_loader, firmware, addr, fw_size, 0);
+	if (ret < 0) {
+		debug("could not request %s: %d\n", firmware, ret);
+		return ret;
+	}
+
+	rproc_addr = (ulong)addr;
+
+	ret = rproc_load(core_id, rproc_addr, ret);
+	if (ret) {
+		debug("failed to load %s to rproc core %d from addr 0x%08lX err %d\n",
+		      uc_pdata->fw_name, core_id, rproc_addr, ret);
+		return ret;
+	}
+
+	ret = rproc_start(core_id);
+	if (ret) {
+		debug("failed to start rproc core %d\n", core_id);
+		return ret;
+	}
+
+	return ret;
+}
diff --git a/include/remoteproc.h b/include/remoteproc.h
index a11dc8a9b6..65b0ff7477 100644
--- a/include/remoteproc.h
+++ b/include/remoteproc.h
@@ -402,6 +402,7 @@ enum rproc_mem_type {
  * @name: Platform-specific way of naming the Remote proc
  * @mem_type: one of 'enum rproc_mem_type'
  * @driver_plat_data: driver specific platform data that may be needed.
+ * @fw_name: firmware name
  *
  * This can be accessed with dev_get_uclass_plat() for any UCLASS_REMOTEPROC
  * device.
@@ -411,6 +412,7 @@ struct dm_rproc_uclass_pdata {
 	const char *name;
 	enum rproc_mem_type mem_type;
 	void *driver_plat_data;
+	char *fw_name;
 };
 
 /**
@@ -704,6 +706,35 @@ unsigned long rproc_parse_resource_table(struct udevice *dev,
 struct resource_table *rproc_find_resource_table(struct udevice *dev,
 						 unsigned int addr,
 						 int *tablesz);
+/**
+ * rproc_set_firmware() - assign a new firmware
+ * @rproc_dev: device for wich new firmware is being assigned
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
+ * @fw_size: Size of the memory to allocate for firmeware
+ *
+ * Boot a remote processor (i.e. load its firmware, power it on, ...).
+ *
+ * This function first loads the firmware set in the uclass pdata of Remote
+ * processor to a buffer and then loads firmware to the remote processor
+ * using rproc_load().
+ *
+ * Return: 0 on success, and an appropriate error value otherwise
+ */
+int rproc_boot(struct udevice *rproc_dev, size_t fw_size);
 #else
 static inline int rproc_init(void) { return -ENOSYS; }
 static inline int rproc_dev_init(int id) { return -ENOSYS; }
@@ -743,6 +774,10 @@ static inline int rproc_elf_load_rsc_table(struct udevice *dev, ulong fw_addr,
 					   ulong fw_size, ulong *rsc_addr,
 					   ulong *rsc_size)
 { return -ENOSYS; }
+static inline int rproc_set_firmware(struct udevice *rproc_dev, const char *fw_name)
+{ return -ENOSYS; }
+static inline int rproc_boot(struct udevice *rproc_dev, size_t fw_size)
+{ return -ENOSYS; }
 #endif
 
 #endif	/* _RPROC_H_ */
-- 
2.34.1

