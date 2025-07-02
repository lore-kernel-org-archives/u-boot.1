Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4613CC83F04
	for <u-boot@archiver.kernel.org>; Wed,  2 Jul 2025 15:27:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6A92D82F30;
	Wed,  2 Jul 2025 17:26:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5FFFB82FD6; Wed,  2 Jul 2025 17:26:03 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 98A9182103
 for <u-boot@lists.denx.de>; Wed,  2 Jul 2025 17:26:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=abdellatif.elkhlifi@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2FEAD22D9;
 Wed,  2 Jul 2025 08:25:45 -0700 (PDT)
Received: from e130802.cambridge.arm.com (e130802.arm.com [10.1.38.90])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1A0E63F6A8;
 Wed,  2 Jul 2025 08:25:57 -0700 (PDT)
From: abdellatif.elkhlifi@arm.com
To: u-boot@lists.denx.de
Cc: trini@konsulko.com, abdellatif.elkhlifi@arm.com,
 Davidson kumaresan <davidson.kumaresan@arm.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, Michal Simek <michal.simek@amd.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Casey Connolly <casey.connolly@linaro.org>
Subject: [PATCH 10/25] fwu_arm_psa: Initialize the update agent
Date: Wed,  2 Jul 2025 16:25:13 +0100
Message-Id: <20250702152528.1180414-11-abdellatif.elkhlifi@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250702152528.1180414-1-abdellatif.elkhlifi@arm.com>
References: <20250702152528.1180414-1-abdellatif.elkhlifi@arm.com>
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

From: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>

Add the initializations required for the update agent

The aim is adding support for the Trusted Services (aka TS)
Firmware Update API. This API allows the interaction with
the FWU services provided by Secure world.
At U-Boot level, we provide the PSA FWU ABI built on top of the
FF-A bus to invoke the FWU services in Secure world.

The design is based on the Platform Security Firmware Update
for the A-profile Arm Architecture specification [1].

In our design, the Secure world is the update agent. U-Boot
is the update client.

The update agent is initialized as follows:

- Trusted Services FWU SP discovery
- Setting up the shared buffer between the Normal world (U-Boot) and
  Secure world (Trusted Services)
- Notifying FWU SP about the shared buffer

[1]: DEN0118, 1.0 A:
    https://developer.arm.com/documentation/den0118/latest/

Signed-off-by: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
Signed-off-by: Davidson kumaresan <davidson.kumaresan@arm.com>
Cc: Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Simon Glass <sjg@chromium.org>
Cc: Michal Simek <michal.simek@amd.com>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: Casey Connolly <casey.connolly@linaro.org>
---
 MAINTAINERS                   |   7 +
 include/fwu_arm_psa.h         |  58 ++++++++
 lib/fwu_updates/Kconfig       |  18 +++
 lib/fwu_updates/Makefile      |   2 +
 lib/fwu_updates/fwu_arm_psa.c | 271 ++++++++++++++++++++++++++++++++++
 5 files changed, 356 insertions(+)
 create mode 100644 include/fwu_arm_psa.h
 create mode 100644 lib/fwu_updates/fwu_arm_psa.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 92119667618..fdf34c74049 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1227,6 +1227,13 @@ T:	git https://source.denx.de/u-boot/custodians/u-boot-fsl-qoriq.git
 F:	drivers/watchdog/sp805_wdt.c
 F:	drivers/watchdog/sbsa_gwdt.c
 
+FWU ARM PSA
+M:	Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
+M:	Davidson kumaresan <davidson.kumaresan@arm.com>
+S:	Maintained
+F:	include/fwu_arm_psa.h
+F:	lib/fwu_updates/fwu_arm_psa.c
+
 FWU Multi Bank Update
 M:	Sughosh Ganu <sughosh.ganu@linaro.org>
 S:	Maintained
diff --git a/include/fwu_arm_psa.h b/include/fwu_arm_psa.h
new file mode 100644
index 00000000000..f1d42f9ef24
--- /dev/null
+++ b/include/fwu_arm_psa.h
@@ -0,0 +1,58 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Copyright 2025 Arm Limited and/or its affiliates <open-source-office@arm.com>
+ *
+ * Authors:
+ *   Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
+ *   Davidson kumaresan <davidson.kumaresan@arm.com>
+ */
+
+#ifndef __FWU_ARM_PSA_H
+#define __FWU_ARM_PSA_H
+
+#include <linux/bitfield.h>
+#include <u-boot/uuid.h>
+
+#define FWU_BUFFER_PAGES		(1024)
+
+/* 4 MB buffer shared with secure world */
+#define FWU_BUFFER_SIZE			(FWU_BUFFER_PAGES * EFI_PAGE_SIZE)
+
+/* TS UUID string for detecting all SPs  (in big-endian format) */
+#define ALL_TS_SP_UUID			"d776cdbd-5e82-5147-3b96-ac4349f8d486"
+/* In little-endian equivalent to: bdcd76d7-825e-4751-963b-86d4f84943ac */
+
+/* TS FWU service UUID string (in big-endian format) */
+#define TS_FWU_SERVICE_UUID		"38a82368-061b-0e47-7497-fd53fb8bce0c"
+/* In little-endian equivalent to:  6823a838-1b06-470e-9774-0cce8bfb53fd */
+
+#define TS_RPC_MEM_RETRIEVE		(0xff0001)
+#define TS_RPC_SERVICE_INFO_GET		(0xff0003)
+#define RPC_SUCCESS			(0)
+
+#define SVC_IFACE_ID_GET_MASK		GENMASK(7, 0)
+#define GET_SVC_IFACE_ID(x)		\
+			 ((u8)(FIELD_GET(SVC_IFACE_ID_GET_MASK, (x))))
+
+#define HANDLE_MSW_MASK			GENMASK(63, 32)
+#define HANDLE_LSW_MASK			GENMASK(31, 0)
+#define GET_FWU_BUF_MSW(x)		\
+				((u32)(FIELD_GET(HANDLE_MSW_MASK, (x))))
+#define GET_FWU_BUF_LSW(x)		\
+				((u32)(FIELD_GET(HANDLE_LSW_MASK, (x))))
+
+/**
+ * fwu_agent_init() - Setup the FWU agent
+ *
+ * Perform the initializations required to communicate
+ * and use the FWU agent in secure world.
+ * The frontend of the FWU agent is the Trusted Services (aka TS)
+ * FWU SP (aka Secure Partition).
+ *
+ * Return:
+ *
+ * 0 is returned on success. Otherwise, failure
+ */
+int fwu_agent_init(void);
+
+#endif
diff --git a/lib/fwu_updates/Kconfig b/lib/fwu_updates/Kconfig
index a722107c129..cdc96109f0a 100644
--- a/lib/fwu_updates/Kconfig
+++ b/lib/fwu_updates/Kconfig
@@ -46,4 +46,22 @@ config FWU_MDATA_V2
 	  metadata structure. This option enables support for FWU
 	  Metadata version 2 access.
 
+config FWU_ARM_PSA
+	bool "FMP driver for Arm PSA FWU specification"
+	depends on EFI_CAPSULE_FIRMWARE_MANAGEMENT && \
+		EFI_CAPSULE_FIRMWARE_RAW && \
+		ARM_FFA_TRANSPORT && (ARM64 || SANDBOX)
+	select EFI_CAPSULE_FIRMWARE
+	help
+	  Select this option if you want to enable firmware management protocol
+	  driver that supports the Arm PSA firmware update specification as
+	  mentioned in https://developer.arm.com/documentation/den0118/a/
+
+config FWU_BUFFER_PAGES
+	int "Number of 4KB pages in the FWU shared buffer"
+	depends on FWU_ARM_PSA
+	default 1024
+	help
+	  This defines the size of the FWU shared buffer used for communication.
+
 endif
diff --git a/lib/fwu_updates/Makefile b/lib/fwu_updates/Makefile
index 3681bef46cd..ae8e4b27793 100644
--- a/lib/fwu_updates/Makefile
+++ b/lib/fwu_updates/Makefile
@@ -1,6 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0-or-later
 #
 # Copyright (c) 2022, Linaro Limited
+# Copyright 2025 Arm Limited and/or its affiliates <open-source-office@arm.com>
 #
 
 obj-$(CONFIG_FWU_MULTI_BANK_UPDATE) += fwu.o
@@ -8,3 +9,4 @@ obj-$(CONFIG_FWU_MDATA_GPT_BLK) += fwu_gpt.o
 obj-$(CONFIG_FWU_MDATA_MTD) += fwu_mtd.o
 obj-$(CONFIG_FWU_MDATA_V1) += fwu_v1.o
 obj-$(CONFIG_FWU_MDATA_V2) += fwu_v2.o
+obj-$(CONFIG_FWU_ARM_PSA) += fwu_arm_psa.o
diff --git a/lib/fwu_updates/fwu_arm_psa.c b/lib/fwu_updates/fwu_arm_psa.c
new file mode 100644
index 00000000000..4a01c5ac672
--- /dev/null
+++ b/lib/fwu_updates/fwu_arm_psa.c
@@ -0,0 +1,271 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright 2025 Arm Limited and/or its affiliates <open-source-office@arm.com>
+ *
+ * Authors:
+ *   Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
+ *   Davidson kumaresan <davidson.kumaresan@arm.com>
+ */
+#include <arm_ffa.h>
+#include <dm.h>
+#include <fwu_arm_psa.h>
+#include <efi_loader.h>
+#include <fwu.h>
+#include <log.h>
+#include <malloc.h>
+#include <mapmem.h>
+#include <linux/errno.h>
+
+static void *g_fwu_buf;
+static u64 g_fwu_buf_handle;
+static u16 g_fwu_sp_id;
+static struct udevice *g_dev;
+static u16 g_svc_interface_id;
+static bool g_fwu_initialized;
+
+/**
+ * fwu_discover_ts_sp_id() - Query the FWU partition ID
+ *
+ * Use the FF-A driver to get the FWU partition ID.
+ * If multiple partitions are found, use the first one.
+ *
+ * Return:
+ *
+ * 0 on success
+ */
+static int fwu_discover_ts_sp_id(void)
+{
+	u32 count = 0;
+	int ret;
+	u32 i;
+	struct ffa_partition_desc *descs = NULL;
+	struct ffa_send_direct_data msg;
+	struct ffa_partition_uuid fwu_service_uuid = {0};
+
+	/* Ask the driver to fill the buffer with the SPs info */
+
+	ret = ffa_partition_info_get(g_dev, ALL_TS_SP_UUID, &count, &descs);
+	if (ret) {
+		log_err("FWU: Failure in querying partitions (err: %d)\n", ret);
+		return ret;
+	}
+
+	if (!count) {
+		log_err("FWU: No Trusted Service partition found\n");
+		return -ENODATA;
+	}
+
+	if (!descs) {
+		log_err("FWU: No partitions descriptors filled\n");
+		return -EINVAL;
+	}
+
+	if (uuid_str_to_le_bin(TS_FWU_SERVICE_UUID,
+			       (unsigned char *)&fwu_service_uuid)) {
+		log_err("FWU: invalid FWU SP  UUID\n");
+		return -EINVAL;
+	}
+
+	for (i = 0; i < count ; i++) {
+		log_debug("FWU: Enquiring service from SP 0x%x\n",
+			  descs[i].info.id);
+
+		msg.data0 = TS_RPC_SERVICE_INFO_GET;
+		msg.data1 = fwu_service_uuid.a1;
+		msg.data2 = fwu_service_uuid.a2;
+		msg.data3 = fwu_service_uuid.a3;
+		msg.data4 = fwu_service_uuid.a4;
+
+		ret = ffa_sync_send_receive(g_dev, descs[i].info.id, &msg, 0);
+		if (ret) {
+			log_err("FWU: FF-A error for SERVICE_INFO_GET (err: %d)\n",
+				ret);
+			return ret;
+		}
+
+		if (msg.data0 != TS_RPC_SERVICE_INFO_GET) {
+			log_err("FWU: Wrong SERVICE_INFO_GET return: (%lx)\n",
+				msg.data0);
+			continue;
+		}
+
+		if (msg.data1 == RPC_SUCCESS) {
+			g_svc_interface_id = GET_SVC_IFACE_ID(msg.data2);
+			g_fwu_sp_id = descs[i].info.id;
+			log_debug("FWU: Service interface ID 0x%x found\n",
+				  g_svc_interface_id);
+			return 0;
+		}
+
+		log_debug("FWU: service not found\n");
+	}
+
+	log_err("FWU: No SP provides the service\n");
+
+	return -ENOENT;
+}
+
+/**
+ * fwu_shared_buf_reclaim() - Reclaim the shared communication buffer
+ *
+ * In case of errors, this function can be called to retrieve
+ *  the FWU shared buffer.
+ *
+ * Return:
+ *
+ * 0 is returned on success. Otherwise, failure
+ */
+static int fwu_shared_buf_reclaim(void)
+{
+	int reclaim_ret;
+
+	reclaim_ret = ffa_memory_reclaim(g_dev, g_fwu_buf_handle, 0);
+	if (reclaim_ret)
+		log_err("FWU: FF-A memory reclaim failure (err: %d)\n",
+			reclaim_ret);
+	else
+		log_debug("FWU: Shared buffer reclaimed\n");
+
+	free(g_fwu_buf);
+	g_fwu_buf = NULL;
+
+	return reclaim_ret;
+}
+
+/**
+ * fwu_shared_buf_init() - Setup the FWU shared communication buffer
+ *
+ * The communication with the TS FWU SP is based on a buffer shared
+ * between U-Boot and TS FWU SP allocated in normal world and accessed
+ * by both sides. The buffer contains the data exchanged between both sides
+ * such as the payloads data.
+ *
+ * Return:
+ *
+ * 0 is returned on success. Otherwise, failure
+ */
+static int fwu_shared_buf_init(void)
+{
+	struct ffa_mem_ops_args args = {0};
+	struct ffa_mem_region_attributes attrs = {0};
+	struct ffa_send_direct_data msg;
+	int ret;
+
+	g_fwu_buf = memalign(EFI_PAGE_SIZE, FWU_BUFFER_SIZE);
+	if (!g_fwu_buf) {
+		log_err("FWU: Failure to allocate the shared buffer\n");
+		return -ENOMEM;
+	}
+
+	/* Setting up user arguments */
+	args.use_txbuf = true;
+	args.address = g_fwu_buf;
+	args.pg_cnt = FWU_BUFFER_PAGES;
+	args.nattrs = 1;
+	attrs.receiver = g_fwu_sp_id;
+	attrs.attrs = FFA_MEM_RW;
+	args.attrs = &attrs;
+
+	/* Registering the shared buffer with secure world (Trusted Services) */
+	ret = ffa_memory_share(g_dev, &args);
+	if (ret) {
+		free(g_fwu_buf);
+		g_fwu_buf = NULL;
+		log_err("FWU: Failure setting up the shared buffer (err: %d)\n",
+			ret);
+		return ret;
+	}
+
+	g_fwu_buf_handle = args.g_handle;
+
+	log_debug("FWU: shared buffer handle 0x%llx\n", g_fwu_buf_handle);
+
+	/* Inform the FWU SP know about the shared buffer */
+
+	msg.data0 = TS_RPC_MEM_RETRIEVE;
+	msg.data1 = GET_FWU_BUF_LSW(g_fwu_buf_handle);
+	msg.data2 = GET_FWU_BUF_MSW(g_fwu_buf_handle);
+
+	ret = ffa_sync_send_receive(g_dev, g_fwu_sp_id, &msg, 0);
+	if (ret) {
+		log_err("FWU: FF-A message error for MEM_RETRIEVE (err: %d)\n",
+			ret);
+		goto failure;
+	}
+
+	if (msg.data0 != TS_RPC_MEM_RETRIEVE) {
+		log_err("FWU: Unexpected MEM_RETRIEVE return: (%lx)\n",
+			msg.data0);
+		ret = -EINVAL;
+		goto failure;
+	}
+
+	if (msg.data1 != RPC_SUCCESS) {
+		log_err("FWU: MEM_RETRIEVE failed\n");
+		ret = -EOPNOTSUPP;
+		goto failure;
+	}
+
+	log_debug("FWU: MEM_RETRIEVE success for SP 0x%x\n", g_fwu_sp_id);
+
+	return 0;
+
+failure:
+	fwu_shared_buf_reclaim();
+	return ret;
+}
+
+/**
+ * fwu_agent_init() - Setup the FWU agent
+ *
+ * Perform the initializations required to communicate
+ * and use the FWU agent in secure world.
+ * The frontend of the FWU agent is the Trusted Services (aka TS)
+ * FWU SP (aka Secure Partition).
+ *
+ * Return:
+ *
+ * 0 is returned on success. Otherwise, failure
+ */
+int fwu_agent_init(void)
+{
+	int ret;
+	struct fwu_data *fwu_data;
+	u32 active_idx;
+
+	fwu_data = fwu_get_data();
+	if (!fwu_data) {
+		log_err("FWU: Cannot get FWU data\n");
+		return -EINVAL;
+	}
+
+	ret = fwu_get_active_index(&active_idx);
+	if (ret) {
+		log_err("FWU: Failed to read boot index, err (%d)\n",
+			ret);
+		return ret;
+	}
+
+	if (fwu_data->trial_state)
+		log_info("FWU: System booting in Trial State\n");
+	else
+		log_info("FWU: System booting in Regular State\n");
+
+	ret = uclass_first_device_err(UCLASS_FFA, &g_dev);
+	if (ret) {
+		log_err("FWU: Cannot find FF-A bus device, err (%d)\n", ret);
+		return ret;
+	}
+
+	ret = fwu_discover_ts_sp_id();
+	if (ret)
+		return ret;
+
+	ret = fwu_shared_buf_init();
+	if (ret)
+		return ret;
+
+	g_fwu_initialized = true;
+
+	return 0;
+}
-- 
2.25.1

