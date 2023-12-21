Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 701C7C35274
	for <u-boot@archiver.kernel.org>; Thu, 21 Dec 2023 10:50:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A4E5A87834;
	Thu, 21 Dec 2023 11:50:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="WHaJmeb9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 00A9B8783E; Thu, 21 Dec 2023 11:50:36 +0100 (CET)
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 216C38783E
 for <u-boot@lists.denx.de>; Thu, 21 Dec 2023 11:50:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.fritz.box (ip-178-202-040-247.um47.pools.vodafone-ip.de
 [178.202.40.247])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id C02A94166B; 
 Thu, 21 Dec 2023 10:50:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1703155833;
 bh=PuJGQNs+3vUNMvTuSDCsH4AkkeQ4rkBMDtyEzzHoKEU=;
 h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
 MIME-Version;
 b=WHaJmeb9h1VVqndvGxto4M6KHruORlUjV0jIgEav5qTvLx2ZifGrjVQNDDdpIM4NR
 lSnpSNEMSOZpfTsanwPvSrlOsmL3vSfKOzeERek18gVL08zR1QL7e+U3qHKVIFNviB
 KZQNI53Mh1FObGlBtcp0Mm1MGovE8AV+NhDtnqmFCwT/NtotYr5WvDDPa4j4xYz0eK
 +Ru7XYTf9fb12I7bSy4xiee8KIR3vFUw9rjTJ+SbOAJPZmxDGhSjdDJRIAVYI37ymi
 P5RggBKbdnw1LrdZ1xmTePu4H3MJRsWnYkXUSmkxrojnghGW4q4TE2iUObp6OJOuXe
 Ls0Ad/8BMzwQg==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>, Bin Meng <bmeng.cn@gmail.com>,
 Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 2/2] smbios: copy QEMU tables
Date: Thu, 21 Dec 2023 11:50:17 +0100
Message-Id: <20231221105017.6895-3-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231221105017.6895-1-heinrich.schuchardt@canonical.com>
References: <20231221105017.6895-1-heinrich.schuchardt@canonical.com>
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

QEMU provides SMBIOS tables with detailed information. We should not try to
replicate them in U-Boot.

If we want to inform about U-Boot, we can add a Firmware Inventory
Information (type 45) table in future.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 drivers/misc/Kconfig        |   8 ++
 drivers/misc/Makefile       |   1 +
 drivers/misc/qfw_smbios.c   | 195 ++++++++++++++++++++++++++++++++++++
 lib/efi_loader/efi_smbios.c |   4 +-
 4 files changed, 207 insertions(+), 1 deletion(-)
 create mode 100644 drivers/misc/qfw_smbios.c

diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
index e8e4400516..3d885f12c8 100644
--- a/drivers/misc/Kconfig
+++ b/drivers/misc/Kconfig
@@ -561,6 +561,14 @@ config QFW_MMIO
 	  Hidden option to enable MMIO QEMU fw_cfg interface. This will be
 	  selected by the appropriate QEMU board.
 
+config QFW_SMBIOS
+	bool
+	default y if ARM64
+	default y if RISCV && 64BIT
+	depends on QFW && SMBIOS
+	help
+	  Hidden option to read SMBIOS tables from QEMU.
+
 config I2C_EEPROM
 	bool "Enable driver for generic I2C-attached EEPROMs"
 	depends on MISC
diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
index cda701d38e..64bea92f51 100644
--- a/drivers/misc/Makefile
+++ b/drivers/misc/Makefile
@@ -66,6 +66,7 @@ obj-y += qfw.o
 obj-$(CONFIG_QFW_ACPI) += qfw_acpi.o
 obj-$(CONFIG_QFW_PIO) += qfw_pio.o
 obj-$(CONFIG_QFW_MMIO) += qfw_mmio.o
+obj-$(CONFIG_QFW_SMBIOS) += qfw_smbios.o
 obj-$(CONFIG_SANDBOX) += qfw_sandbox.o
 endif
 obj-$(CONFIG_ROCKCHIP_EFUSE) += rockchip-efuse.o
diff --git a/drivers/misc/qfw_smbios.c b/drivers/misc/qfw_smbios.c
new file mode 100644
index 0000000000..38f0225b36
--- /dev/null
+++ b/drivers/misc/qfw_smbios.c
@@ -0,0 +1,195 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * (C) Copyright 2023 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
+ */
+
+#define LOG_CATEGORY UCLASS_QFW
+
+#include <efi_loader.h>
+#include <errno.h>
+#include <log.h>
+#include <malloc.h>
+#include <mapmem.h>
+#include <qfw.h>
+#include <smbios.h>
+#include <tables_csum.h>
+#include <linux/sizes.h>
+#include <asm/global_data.h>
+
+DECLARE_GLOBAL_DATA_PTR;
+
+/**
+ * qfw_load_smbios_table() - load a QEMU firmware file
+ *
+ * @dev:	QEMU firmware device
+ * @size:	parameter to return the size of the loaded table
+ * @name:	name of the table to load
+ * Return:	address of the loaded table, NULL on error
+ */
+static void *qfw_load_smbios_table(struct udevice *dev, uint32_t *size,
+				   char *name)
+{
+	struct fw_file *file;
+	struct bios_linker_entry *table;
+
+	file = qfw_find_file(dev, name);
+	if (!file) {
+		log_debug("Can't find %s\n", name);
+		return NULL;
+	}
+
+	*size = be32_to_cpu(file->cfg.size);
+
+	table = malloc(*size);
+	if (!table) {
+		log_err("Out of memory\n");
+		return NULL;
+	}
+
+	qfw_read_entry(dev, be16_to_cpu(file->cfg.select), *size, table);
+
+	return table;
+}
+
+/**
+ * qfw_parse_smbios_anchor() - parse QEMU's SMBIOS anchor
+ *
+ * @dev:	QEMU firmware device
+ * @entry:	SMBIOS 3 structure to be filled from QEMU's anchor
+ * Return:	0 for success, -ve on error
+ */
+static int qfw_parse_smbios_anchor(struct udevice *dev,
+				   struct smbios3_entry *entry)
+{
+	void *table;
+	uint32_t size;
+	struct smbios_entry *entry2;
+	struct smbios3_entry *entry3;
+	const char *smbios_sig = "_SM_";
+	const char *smbios3_sig = "_SM3_";
+	int ret = 0;
+
+	table = qfw_load_smbios_table(dev, &size, "etc/smbios/smbios-anchor");
+	if (!table)
+		return -ENOMEM;
+	if (memcmp(table, smbios3_sig, sizeof(smbios3_sig))) {
+		entry3 = table;
+		if (entry3->length != sizeof(struct smbios3_entry)) {
+			ret = -ENOENT;
+			goto out;
+		}
+		memcpy(entry, entry3, sizeof(struct smbios3_entry));
+	} else if (memcmp(table, smbios3_sig, sizeof(smbios_sig))) {
+		entry2 = table;
+		if (entry->length != sizeof(struct smbios_entry)) {
+			ret = -ENOENT;
+			goto out;
+		}
+		memset(entry, 0, sizeof(struct smbios3_entry));
+		memcpy(entry, smbios3_sig, sizeof(smbios3_sig));
+		entry->length = sizeof(smbios3_sig);
+		entry->major_ver = entry2->major_ver;
+		entry->minor_ver = entry2->minor_ver;
+		entry->max_struct_size = entry2->max_struct_size;
+	} else {
+		ret = -ENOENT;
+		goto out;
+	}
+	ret = 0;
+out:
+	free(table);
+
+	return ret;
+}
+
+/**
+ * qfw_write_smbios_tables() - copy SMBIOS tables from QEMU
+ *
+ * @addr:	target buffer
+ * @size:	size of target buffer
+ * Return:	0 for success, -ve on error
+ */
+static int qfw_write_smbios_tables(u8 *addr, uint32_t size)
+{
+	int ret;
+	struct udevice *dev;
+	struct smbios3_entry *entry = (void *)addr;
+	void *table;
+	uint32_t table_size;
+
+	ret = qfw_get_dev(&dev);
+	if (ret) {
+		log_err("No QEMU firmware device\n");
+		return ret;
+	}
+
+	ret = qfw_read_firmware_list(dev);
+	if (ret) {
+		log_err("Can't read firmware file list\n");
+		return ret;
+	}
+
+	ret = qfw_parse_smbios_anchor(dev, entry);
+	if (ret) {
+		log_debug("Can't parse anchor\n");
+		return ret;
+	}
+
+	addr += entry->length;
+	entry->struct_table_address = (uintptr_t)addr;
+	entry->checksum = 0;
+	entry->checksum = table_compute_checksum(entry,
+						 sizeof(struct smbios3_entry));
+
+	table = qfw_load_smbios_table(dev, &table_size,
+				      "etc/smbios/smbios-tables");
+	if (table_size + sizeof(struct smbios3_entry) > size) {
+		free(table);
+		return -ENOMEM;
+	}
+	memcpy(addr, table, table_size);
+	free(table);
+
+	return 0;
+}
+
+/**
+ * qfw_evt_write_smbios_tables() - event handler for copying QEMU SMBIOS tables
+ *
+ * Return:	0 on success, -ve on error (only out of memory)
+ */
+static int qfw_evt_write_smbios_tables(void)
+{
+	phys_addr_t addr;
+	void *ptr;
+	int ret;
+	/*
+	 * TODO:
+	 * This size is currently hard coded in lib/efi_loader/efi_smbios.c.
+	 * We need a field in global data for the size.
+	 */
+	uint32_t size = SZ_4K;
+
+	/* Reserve 64K for SMBIOS tables, aligned to a 4K boundary */
+	ptr = memalign(SZ_4K, size);
+	if (!ptr) {
+		log_err("Out of memory\n");
+		return -ENOMEM;
+	}
+	addr = map_to_sysmem(ptr);
+
+	/* Generate SMBIOS tables */
+	ret = qfw_write_smbios_tables(ptr, size);
+	if (ret) {
+		log_info("Falling back to U-Boot generated SMBIOS tables\n");
+		write_smbios_table(addr);
+	} else {
+		log_debug("SMBIOS tables copied from QEMU\n");
+	}
+
+	gd_set_smbios_start(addr);
+
+	return 0;
+}
+
+EVENT_SPY_SIMPLE(EVT_LAST_STAGE_INIT, qfw_evt_write_smbios_tables);
diff --git a/lib/efi_loader/efi_smbios.c b/lib/efi_loader/efi_smbios.c
index 0fbf51b98d..ba39382d04 100644
--- a/lib/efi_loader/efi_smbios.c
+++ b/lib/efi_loader/efi_smbios.c
@@ -52,7 +52,9 @@ static int install_smbios_table(void)
 	u64 addr;
 	efi_status_t ret;
 
-	if (!IS_ENABLED(CONFIG_GENERATE_SMBIOS_TABLE) || IS_ENABLED(CONFIG_X86))
+	if (!IS_ENABLED(CONFIG_GENERATE_SMBIOS_TABLE) ||
+	    IS_ENABLED(CONFIG_X86) ||
+	    IS_ENABLED(CONFIG_QFW_SMBIOS))
 		return 0;
 
 	addr = SZ_4G;
-- 
2.40.1

