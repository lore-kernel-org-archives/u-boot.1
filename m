Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0E79C3DA41
	for <u-boot@archiver.kernel.org>; Tue,  9 Jul 2024 09:35:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B7F4888637;
	Tue,  9 Jul 2024 11:34:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ZTsN1XTv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ED9F28861D; Tue,  9 Jul 2024 11:34:53 +0200 (CEST)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com
 [IPv6:2a00:1450:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 160B187EBD
 for <u-boot@lists.denx.de>; Tue,  9 Jul 2024 11:34:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-a77d85f7fa3so555483766b.0
 for <u-boot@lists.denx.de>; Tue, 09 Jul 2024 02:34:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720517689; x=1721122489; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=HykTcs0S2BVC+htfsUdNvqfUoQEwEbUbaahj8ZlST3U=;
 b=ZTsN1XTv7XY89SX1niDMI33hZ8aDOrCteHvoBsa8HETrc25j3tNWEWByVfpzf3CT5I
 MYVOruA9l2y+7cJLtvcqSkoUU9OnYucjYRMVcUoVBBEKiALLsFMf44O8CZNvBMRZ3nFj
 GKresNXLTP28oYgUUtuvCYSJ1OlC8JGgtz/ZZLZnCdTtKj5GPEU/y8imo4H9DiYy3jWt
 4KuX4txE3sU3gjIjnIqW9FKb3ctVaT2LmQdhpZ5YPE2cswuaCycXuFB8WmeuP3+G4Usk
 QBFyGz+2KjMK/5UNIPKsyJHZBpKmOwrs9aVCNDQzM9HweDA3GIAOvB/XaxUawOhRuxHv
 Y5hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720517689; x=1721122489;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HykTcs0S2BVC+htfsUdNvqfUoQEwEbUbaahj8ZlST3U=;
 b=Z9oCabTxKHwgrc9IWT1agl4plJCziPLCF2yAbZTMImR9fOut5GbSfGClEl8oG6CvXg
 PPHTE2zJbDEXN1Ba53buKN8fyKKgg1Q78Y7GjS1dsG6QDzf2Gpcv9dSN9eqKcg4qf/k/
 oPExSojfWOGNDR8jRCqn8Fe3cnBW/m7D0ggN1BhLmPQoHi7m/uJIT/NH91lHacoyan5H
 OX0iVRl4PvTuKh6sT3PxHXmrKWnuKKfkcVdVFRGKA5XpOUov9lbdwHdRPj7lcOl9nMCC
 tJke6nKwl/vhw/HRaV86++STF8OMYBl4jFqhZTXhSrL+vftOGXv7pxkpaM/kC7fvBb4z
 Vy+A==
X-Gm-Message-State: AOJu0Yya4x/b8K8xod9xtFnSnlmccjEcuxgKtvDJ1m/KjSo4SUn+4Eqj
 bhuxqbz9OU6huL9oIqY28AK2wVzuHj5VQUmX7DuMQQGeb+LDFOMgsvnJtByc0w4=
X-Google-Smtp-Source: AGHT+IGN7xlK0ncngp6xbdCgOB/MvoC1cS7Qqdy1iN8jIVkJOulAesDVpb/B/Yvw682hFJls7NraLg==
X-Received: by 2002:a17:907:7753:b0:a77:cac5:ba7 with SMTP id
 a640c23a62f3a-a780d20ed7emr148809866b.8.1720517688533; 
 Tue, 09 Jul 2024 02:34:48 -0700 (PDT)
Received: from [192.168.0.113] ([2a02:8109:aa0d:be00::18f8])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a780a7fefaasm62884566b.140.2024.07.09.02.34.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jul 2024 02:34:47 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Tue, 09 Jul 2024 11:34:30 +0200
Subject: [PATCH v4 02/21] soc: qcom: import rpmh and cmd-db drivers from Linux
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240709-b4-qcom-rpmh-v4-2-c06d0a26644a@linaro.org>
References: <20240709-b4-qcom-rpmh-v4-0-c06d0a26644a@linaro.org>
In-Reply-To: <20240709-b4-qcom-rpmh-v4-0-c06d0a26644a@linaro.org>
To: Tom Rini <trini@konsulko.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>, Jaehoon Chung <jh80.chung@samsung.com>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=76366;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=j9WbJphYvx0zy0PCfHYGbyBI5lgZK76RiS3a/HIsr1w=;
 b=owEBbQKS/ZANAwAIAQWDMSsZX2S2AcsmYgBmjQQyxn+GdIO/VkBxlEPDLuPFDUNNzJmY5vZ4n
 ChdMcJ+pyGJAjMEAAEIAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCZo0EMgAKCRAFgzErGV9k
 tizUD/43+oCyDfs8HS8AZq8YF2dHKcp6pZ0uY3CDSxUkG5YRvHsrWo+jslH0WDGmROIHTZ4fxaN
 HCCu2/6O7F5MPvsLDBSQPcycRT90Dn1d54YaUKPe2zhEomoejEkUOOxNWgxHc/YaAgustxL+IJd
 XxtXAQkvPKToUpaABdgpwxl7VhkufjD0bBSjgR6zgjBznDufen+QyQlBxh8tyZbHr6OeztyLQL5
 an2G8eGGKOqlItrPyvKSL9ZSiaywyCvwVO6NHWtVKQaWEQsjOEzklWmaB4od+JmF+IbJJKjypX5
 x8gb/9Bqn/g6HIfJWLYTWDHCH2goFc/gR+WCLYTodnNdwx+bEu14+2E/suNetWmLWwjystN8KXl
 1hLeIzGBeh8CHbNtlE7XeC8+OEM3JIBv+o/39Qp4dkkhJClDdkS+xi41jyTp0+HEfsoowl4BQQT
 BXZOGTIyB3zwgqVPppRddPEpvFle+gqLnWPEfnLIgWcAxDQ+b8+evLekK94rUu9CZHxYNf2Ak1y
 bfqj1xrQ4G6T1aRMzxm42Bhj/kdgnA4d2VHc1qbKLoiRwzpI88vrnqyO52zzJ5WDadUaMtcZp3h
 XqVnLE5qW8zeKpkJK4xIqI7z0hFJS4wd4ZdWoajU11AaXn8wSezJeDKGcZFQgIkjeXUIFJCod2H
 bk2ESJD0nPT/b4w==
X-Developer-Key: i=caleb.connolly@linaro.org; a=openpgp;
 fpr=83B24DA7FE145076BC38BB250CD904EB673A7C47
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

Import RPMh and cmd-db framework from Linux 6.10-rc6.

Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 drivers/soc/Kconfig              |    1 +
 drivers/soc/Makefile             |    1 +
 drivers/soc/qcom/Kconfig         |   27 +
 drivers/soc/qcom/Makefile        |    4 +
 drivers/soc/qcom/cmd-db.c        |  393 +++++++++++++
 drivers/soc/qcom/rpmh-internal.h |  148 +++++
 drivers/soc/qcom/rpmh-rsc.c      | 1162 ++++++++++++++++++++++++++++++++++++++
 drivers/soc/qcom/rpmh.c          |  502 ++++++++++++++++
 include/soc/qcom/cmd-db.h        |   48 ++
 include/soc/qcom/rpmh.h          |   47 ++
 include/soc/qcom/tcs.h           |   81 +++
 11 files changed, 2414 insertions(+)

diff --git a/drivers/soc/Kconfig b/drivers/soc/Kconfig
index cee506fe4747..8ef408d9ba1b 100644
--- a/drivers/soc/Kconfig
+++ b/drivers/soc/Kconfig
@@ -47,8 +47,9 @@ config SOC_XILINX_VERSAL_NET
 	  Enable this option to select SoC device id driver for Xilinx Versal NET.
 	  This allows other drivers to verify the SoC familiy & revision using
 	  matching SoC attributes.
 
+source "drivers/soc/qcom/Kconfig"
 source "drivers/soc/samsung/Kconfig"
 source "drivers/soc/ti/Kconfig"
 
 endmenu
diff --git a/drivers/soc/Makefile b/drivers/soc/Makefile
index 5ec89a053165..00e6a5ac8e2b 100644
--- a/drivers/soc/Makefile
+++ b/drivers/soc/Makefile
@@ -2,8 +2,9 @@
 #
 # Makefile for the U-Boot SOC specific device drivers.
 
 obj-$(CONFIG_SOC_AMD_VERSAL2) += soc_amd_versal2.o
+obj-$(CONFIG_SOC_QCOM) += qcom/
 obj-$(CONFIG_SOC_SAMSUNG) += samsung/
 obj-$(CONFIG_SOC_TI) += ti/
 obj-$(CONFIG_SOC_DEVICE) += soc-uclass.o
 obj-$(CONFIG_SOC_DEVICE_TI_K3) += soc_ti_k3.o
diff --git a/drivers/soc/qcom/Kconfig b/drivers/soc/qcom/Kconfig
new file mode 100644
index 000000000000..4aa7833930c7
--- /dev/null
+++ b/drivers/soc/qcom/Kconfig
@@ -0,0 +1,27 @@
+# SPDX-License-Identifier: GPL-2.0-only
+#
+# QCOM Soc drivers
+#
+menuconfig SOC_QCOM
+	bool "Qualcomm SOC drivers support"
+	help
+	  Say Y here if you want to enable Qualcomm SOC drivers support.
+
+if SOC_QCOM
+
+config QCOM_COMMAND_DB
+	bool "Qualcomm Command DB"
+	help
+	  Command DB queries shared memory by key string for shared system
+	  resources. Platform drivers that require to set state of a shared
+	  resource on a RPM-hardened platform must use this database to get
+	  SoC specific identifier and information for the shared resources.
+
+config QCOM_RPMH
+	bool "Qualcomm RPMh support"
+	depends on QCOM_COMMAND_DB
+	help
+	  Say y here to support the Qualcomm RPMh (resource peripheral manager)
+	  if you need to control regulators on Qualcomm platforms, say y here.
+
+endif # SOC_QCOM
diff --git a/drivers/soc/qcom/Makefile b/drivers/soc/qcom/Makefile
new file mode 100644
index 000000000000..78fae8bbfa16
--- /dev/null
+++ b/drivers/soc/qcom/Makefile
@@ -0,0 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0+
+
+obj-$(CONFIG_QCOM_COMMAND_DB) += cmd-db.o
+obj-$(CONFIG_QCOM_RPMH) += rpmh-rsc.o rpmh.o
diff --git a/drivers/soc/qcom/cmd-db.c b/drivers/soc/qcom/cmd-db.c
new file mode 100644
index 000000000000..d84572662017
--- /dev/null
+++ b/drivers/soc/qcom/cmd-db.c
@@ -0,0 +1,393 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2016-2018, 2020, The Linux Foundation. All rights reserved.
+ * Copyright (c) 2024, Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+#include <linux/bitfield.h>
+#include <linux/debugfs.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/of_reserved_mem.h>
+#include <linux/platform_device.h>
+#include <linux/seq_file.h>
+#include <linux/types.h>
+
+#include <soc/qcom/cmd-db.h>
+
+#define NUM_PRIORITY		2
+#define MAX_SLV_ID		8
+#define SLAVE_ID_MASK		0x7
+#define SLAVE_ID_SHIFT		16
+#define SLAVE_ID(addr)		FIELD_GET(GENMASK(19, 16), addr)
+#define VRM_ADDR(addr)		FIELD_GET(GENMASK(19, 4), addr)
+
+/**
+ * struct entry_header: header for each entry in cmddb
+ *
+ * @id: resource's identifier
+ * @priority: unused
+ * @addr: the address of the resource
+ * @len: length of the data
+ * @offset: offset from :@data_offset, start of the data
+ */
+struct entry_header {
+	u8 id[8];
+	__le32 priority[NUM_PRIORITY];
+	__le32 addr;
+	__le16 len;
+	__le16 offset;
+};
+
+/**
+ * struct rsc_hdr: resource header information
+ *
+ * @slv_id: id for the resource
+ * @header_offset: entry's header at offset from the end of the cmd_db_header
+ * @data_offset: entry's data at offset from the end of the cmd_db_header
+ * @cnt: number of entries for HW type
+ * @version: MSB is major, LSB is minor
+ * @reserved: reserved for future use.
+ */
+struct rsc_hdr {
+	__le16 slv_id;
+	__le16 header_offset;
+	__le16 data_offset;
+	__le16 cnt;
+	__le16 version;
+	__le16 reserved[3];
+};
+
+/**
+ * struct cmd_db_header: The DB header information
+ *
+ * @version: The cmd db version
+ * @magic: constant expected in the database
+ * @header: array of resources
+ * @checksum: checksum for the header. Unused.
+ * @reserved: reserved memory
+ * @data: driver specific data
+ */
+struct cmd_db_header {
+	__le32 version;
+	u8 magic[4];
+	struct rsc_hdr header[MAX_SLV_ID];
+	__le32 checksum;
+	__le32 reserved;
+	u8 data[];
+};
+
+/**
+ * DOC: Description of the Command DB database.
+ *
+ * At the start of the command DB memory is the cmd_db_header structure.
+ * The cmd_db_header holds the version, checksum, magic key as well as an
+ * array for header for each slave (depicted by the rsc_header). Each h/w
+ * based accelerator is a 'slave' (shared resource) and has slave id indicating
+ * the type of accelerator. The rsc_header is the header for such individual
+ * slaves of a given type. The entries for each of these slaves begin at the
+ * rsc_hdr.header_offset. In addition each slave could have auxiliary data
+ * that may be needed by the driver. The data for the slave starts at the
+ * entry_header.offset to the location pointed to by the rsc_hdr.data_offset.
+ *
+ * Drivers have a stringified key to a slave/resource. They can query the slave
+ * information and get the slave id and the auxiliary data and the length of the
+ * data. Using this information, they can format the request to be sent to the
+ * h/w accelerator and request a resource state.
+ */
+
+static const u8 CMD_DB_MAGIC[] = { 0xdb, 0x30, 0x03, 0x0c };
+
+static bool cmd_db_magic_matches(const struct cmd_db_header *header)
+{
+	const u8 *magic = header->magic;
+
+	return memcmp(magic, CMD_DB_MAGIC, ARRAY_SIZE(CMD_DB_MAGIC)) == 0;
+}
+
+static struct cmd_db_header *cmd_db_header;
+
+static inline const void *rsc_to_entry_header(const struct rsc_hdr *hdr)
+{
+	u16 offset = le16_to_cpu(hdr->header_offset);
+
+	return cmd_db_header->data + offset;
+}
+
+static inline void *
+rsc_offset(const struct rsc_hdr *hdr, const struct entry_header *ent)
+{
+	u16 offset = le16_to_cpu(hdr->data_offset);
+	u16 loffset = le16_to_cpu(ent->offset);
+
+	return cmd_db_header->data + offset + loffset;
+}
+
+/**
+ * cmd_db_ready - Indicates if command DB is available
+ *
+ * Return: 0 on success, errno otherwise
+ */
+int cmd_db_ready(void)
+{
+	if (cmd_db_header == NULL)
+		return -EPROBE_DEFER;
+	else if (!cmd_db_magic_matches(cmd_db_header))
+		return -EINVAL;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(cmd_db_ready);
+
+static int cmd_db_get_header(const char *id, const struct entry_header **eh,
+			     const struct rsc_hdr **rh)
+{
+	const struct rsc_hdr *rsc_hdr;
+	const struct entry_header *ent;
+	int ret, i, j;
+	u8 query[sizeof(ent->id)] __nonstring;
+
+	ret = cmd_db_ready();
+	if (ret)
+		return ret;
+
+	strtomem_pad(query, id, 0);
+
+	for (i = 0; i < MAX_SLV_ID; i++) {
+		rsc_hdr = &cmd_db_header->header[i];
+		if (!rsc_hdr->slv_id)
+			break;
+
+		ent = rsc_to_entry_header(rsc_hdr);
+		for (j = 0; j < le16_to_cpu(rsc_hdr->cnt); j++, ent++) {
+			if (memcmp(ent->id, query, sizeof(ent->id)) == 0) {
+				if (eh)
+					*eh = ent;
+				if (rh)
+					*rh = rsc_hdr;
+				return 0;
+			}
+		}
+	}
+
+	return -ENODEV;
+}
+
+/**
+ * cmd_db_read_addr() - Query command db for resource id address.
+ *
+ * @id: resource id to query for address
+ *
+ * Return: resource address on success, 0 on error
+ *
+ * This is used to retrieve resource address based on resource
+ * id.
+ */
+u32 cmd_db_read_addr(const char *id)
+{
+	int ret;
+	const struct entry_header *ent;
+
+	ret = cmd_db_get_header(id, &ent, NULL);
+
+	return ret < 0 ? 0 : le32_to_cpu(ent->addr);
+}
+EXPORT_SYMBOL_GPL(cmd_db_read_addr);
+
+/**
+ * cmd_db_read_aux_data() - Query command db for aux data.
+ *
+ *  @id: Resource to retrieve AUX Data on
+ *  @len: size of data buffer returned
+ *
+ *  Return: pointer to data on success, error pointer otherwise
+ */
+const void *cmd_db_read_aux_data(const char *id, size_t *len)
+{
+	int ret;
+	const struct entry_header *ent;
+	const struct rsc_hdr *rsc_hdr;
+
+	ret = cmd_db_get_header(id, &ent, &rsc_hdr);
+	if (ret)
+		return ERR_PTR(ret);
+
+	if (len)
+		*len = le16_to_cpu(ent->len);
+
+	return rsc_offset(rsc_hdr, ent);
+}
+EXPORT_SYMBOL_GPL(cmd_db_read_aux_data);
+
+/**
+ * cmd_db_match_resource_addr() - Compare if both Resource addresses are same
+ *
+ * @addr1: Resource address to compare
+ * @addr2: Resource address to compare
+ *
+ * Return: true if two addresses refer to the same resource, false otherwise
+ */
+bool cmd_db_match_resource_addr(u32 addr1, u32 addr2)
+{
+	/*
+	 * Each RPMh VRM accelerator resource has 3 or 4 contiguous 4-byte
+	 * aligned addresses associated with it. Ignore the offset to check
+	 * for VRM requests.
+	 */
+	if (addr1 == addr2)
+		return true;
+	else if (SLAVE_ID(addr1) == CMD_DB_HW_VRM && VRM_ADDR(addr1) == VRM_ADDR(addr2))
+		return true;
+
+	return false;
+}
+EXPORT_SYMBOL_GPL(cmd_db_match_resource_addr);
+
+/**
+ * cmd_db_read_slave_id - Get the slave ID for a given resource address
+ *
+ * @id: Resource id to query the DB for version
+ *
+ * Return: cmd_db_hw_type enum on success, CMD_DB_HW_INVALID on error
+ */
+enum cmd_db_hw_type cmd_db_read_slave_id(const char *id)
+{
+	int ret;
+	const struct entry_header *ent;
+	u32 addr;
+
+	ret = cmd_db_get_header(id, &ent, NULL);
+	if (ret < 0)
+		return CMD_DB_HW_INVALID;
+
+	addr = le32_to_cpu(ent->addr);
+	return (addr >> SLAVE_ID_SHIFT) & SLAVE_ID_MASK;
+}
+EXPORT_SYMBOL_GPL(cmd_db_read_slave_id);
+
+#ifdef CONFIG_DEBUG_FS
+static int cmd_db_debugfs_dump(struct seq_file *seq, void *p)
+{
+	int i, j;
+	const struct rsc_hdr *rsc;
+	const struct entry_header *ent;
+	const char *name;
+	u16 len, version;
+	u8 major, minor;
+
+	seq_puts(seq, "Command DB DUMP\n");
+
+	for (i = 0; i < MAX_SLV_ID; i++) {
+		rsc = &cmd_db_header->header[i];
+		if (!rsc->slv_id)
+			break;
+
+		switch (le16_to_cpu(rsc->slv_id)) {
+		case CMD_DB_HW_ARC:
+			name = "ARC";
+			break;
+		case CMD_DB_HW_VRM:
+			name = "VRM";
+			break;
+		case CMD_DB_HW_BCM:
+			name = "BCM";
+			break;
+		default:
+			name = "Unknown";
+			break;
+		}
+
+		version = le16_to_cpu(rsc->version);
+		major = version >> 8;
+		minor = version;
+
+		seq_printf(seq, "Slave %s (v%u.%u)\n", name, major, minor);
+		seq_puts(seq, "-------------------------\n");
+
+		ent = rsc_to_entry_header(rsc);
+		for (j = 0; j < le16_to_cpu(rsc->cnt); j++, ent++) {
+			seq_printf(seq, "0x%05x: %*pEp", le32_to_cpu(ent->addr),
+				   (int)strnlen(ent->id, sizeof(ent->id)), ent->id);
+
+			len = le16_to_cpu(ent->len);
+			if (len) {
+				seq_printf(seq, " [%*ph]",
+					   len, rsc_offset(rsc, ent));
+			}
+			seq_putc(seq, '\n');
+		}
+	}
+
+	return 0;
+}
+
+static int open_cmd_db_debugfs(struct inode *inode, struct file *file)
+{
+	return single_open(file, cmd_db_debugfs_dump, inode->i_private);
+}
+#endif
+
+static const struct file_operations cmd_db_debugfs_ops = {
+#ifdef CONFIG_DEBUG_FS
+	.open = open_cmd_db_debugfs,
+#endif
+	.read = seq_read,
+	.llseek = seq_lseek,
+	.release = single_release,
+};
+
+static int cmd_db_dev_probe(struct platform_device *pdev)
+{
+	struct reserved_mem *rmem;
+	int ret = 0;
+
+	rmem = of_reserved_mem_lookup(pdev->dev.of_node);
+	if (!rmem) {
+		dev_err(&pdev->dev, "failed to acquire memory region\n");
+		return -EINVAL;
+	}
+
+	cmd_db_header = memremap(rmem->base, rmem->size, MEMREMAP_WB);
+	if (!cmd_db_header) {
+		ret = -ENOMEM;
+		cmd_db_header = NULL;
+		return ret;
+	}
+
+	if (!cmd_db_magic_matches(cmd_db_header)) {
+		dev_err(&pdev->dev, "Invalid Command DB Magic\n");
+		return -EINVAL;
+	}
+
+	debugfs_create_file("cmd-db", 0400, NULL, NULL, &cmd_db_debugfs_ops);
+
+	device_set_pm_not_required(&pdev->dev);
+
+	return 0;
+}
+
+static const struct of_device_id cmd_db_match_table[] = {
+	{ .compatible = "qcom,cmd-db" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, cmd_db_match_table);
+
+static struct platform_driver cmd_db_dev_driver = {
+	.probe  = cmd_db_dev_probe,
+	.driver = {
+		   .name = "cmd-db",
+		   .of_match_table = cmd_db_match_table,
+		   .suppress_bind_attrs = true,
+	},
+};
+
+static int __init cmd_db_device_init(void)
+{
+	return platform_driver_register(&cmd_db_dev_driver);
+}
+core_initcall(cmd_db_device_init);
+
+MODULE_DESCRIPTION("Qualcomm Technologies, Inc. Command DB Driver");
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/soc/qcom/rpmh-internal.h b/drivers/soc/qcom/rpmh-internal.h
new file mode 100644
index 000000000000..e3cf1beff803
--- /dev/null
+++ b/drivers/soc/qcom/rpmh-internal.h
@@ -0,0 +1,148 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2016-2018, The Linux Foundation. All rights reserved.
+ */
+
+
+#ifndef __RPM_INTERNAL_H__
+#define __RPM_INTERNAL_H__
+
+#include <linux/bitmap.h>
+#include <linux/wait.h>
+#include <soc/qcom/tcs.h>
+
+#define TCS_TYPE_NR			4
+#define MAX_CMDS_PER_TCS		16
+#define MAX_TCS_PER_TYPE		3
+#define MAX_TCS_NR			(MAX_TCS_PER_TYPE * TCS_TYPE_NR)
+#define MAX_TCS_SLOTS			(MAX_CMDS_PER_TCS * MAX_TCS_PER_TYPE)
+
+struct rsc_drv;
+
+/**
+ * struct tcs_group: group of Trigger Command Sets (TCS) to send state requests
+ * to the controller
+ *
+ * @drv:       The controller.
+ * @type:      Type of the TCS in this group - active, sleep, wake.
+ * @mask:      Mask of the TCSes relative to all the TCSes in the RSC.
+ * @offset:    Start of the TCS group relative to the TCSes in the RSC.
+ * @num_tcs:   Number of TCSes in this type.
+ * @ncpt:      Number of commands in each TCS.
+ * @req:       Requests that are sent from the TCS; only used for ACTIVE_ONLY
+ *             transfers (could be on a wake/sleep TCS if we are borrowing for
+ *             an ACTIVE_ONLY transfer).
+ *             Start: grab drv->lock, set req, set tcs_in_use, drop drv->lock,
+ *                    trigger
+ *             End: get irq, access req,
+ *                  grab drv->lock, clear tcs_in_use, drop drv->lock
+ * @slots:     Indicates which of @cmd_addr are occupied; only used for
+ *             SLEEP / WAKE TCSs.  Things are tightly packed in the
+ *             case that (ncpt < MAX_CMDS_PER_TCS).  That is if ncpt = 2 and
+ *             MAX_CMDS_PER_TCS = 16 then bit[2] = the first bit in 2nd TCS.
+ */
+struct tcs_group {
+	struct rsc_drv *drv;
+	int type;
+	u32 mask;
+	u32 offset;
+	int num_tcs;
+	int ncpt;
+	const struct tcs_request *req[MAX_TCS_PER_TYPE];
+	DECLARE_BITMAP(slots, MAX_TCS_SLOTS);
+};
+
+/**
+ * struct rpmh_request: the message to be sent to rpmh-rsc
+ *
+ * @msg: the request
+ * @cmd: the payload that will be part of the @msg
+ * @completion: triggered when request is done
+ * @dev: the device making the request
+ * @needs_free: check to free dynamically allocated request object
+ */
+struct rpmh_request {
+	struct tcs_request msg;
+	struct tcs_cmd cmd[MAX_RPMH_PAYLOAD];
+	struct completion *completion;
+	const struct device *dev;
+	bool needs_free;
+};
+
+/**
+ * struct rpmh_ctrlr: our representation of the controller
+ *
+ * @cache: the list of cached requests
+ * @cache_lock: synchronize access to the cache data
+ * @dirty: was the cache updated since flush
+ * @batch_cache: Cache sleep and wake requests sent as batch
+ */
+struct rpmh_ctrlr {
+	struct list_head cache;
+	spinlock_t cache_lock;
+	bool dirty;
+	struct list_head batch_cache;
+};
+
+struct rsc_ver {
+	u32 major;
+	u32 minor;
+};
+
+/**
+ * struct rsc_drv: the Direct Resource Voter (DRV) of the
+ * Resource State Coordinator controller (RSC)
+ *
+ * @name:               Controller identifier.
+ * @base:               Start address of the DRV registers in this controller.
+ * @tcs_base:           Start address of the TCS registers in this controller.
+ * @id:                 Instance id in the controller (Direct Resource Voter).
+ * @num_tcs:            Number of TCSes in this DRV.
+ * @rsc_pm:             CPU PM notifier for controller.
+ *                      Used when solver mode is not present.
+ * @cpus_in_pm:         Number of CPUs not in idle power collapse.
+ *                      Used when solver mode and "power-domains" is not present.
+ * @genpd_nb:           PM Domain notifier for cluster genpd notifications.
+ * @tcs:                TCS groups.
+ * @tcs_in_use:         S/W state of the TCS; only set for ACTIVE_ONLY
+ *                      transfers, but might show a sleep/wake TCS in use if
+ *                      it was borrowed for an active_only transfer.  You
+ *                      must hold the lock in this struct (AKA drv->lock) in
+ *                      order to update this.
+ * @lock:               Synchronize state of the controller.  If RPMH's cache
+ *                      lock will also be held, the order is: drv->lock then
+ *                      cache_lock.
+ * @tcs_wait:           Wait queue used to wait for @tcs_in_use to free up a
+ *                      slot
+ * @client:             Handle to the DRV's client.
+ * @dev:                RSC device.
+ */
+struct rsc_drv {
+	const char *name;
+	void __iomem *base;
+	void __iomem *tcs_base;
+	int id;
+	int num_tcs;
+	struct notifier_block rsc_pm;
+	struct notifier_block genpd_nb;
+	atomic_t cpus_in_pm;
+	struct tcs_group tcs[TCS_TYPE_NR];
+	DECLARE_BITMAP(tcs_in_use, MAX_TCS_NR);
+	spinlock_t lock;
+	wait_queue_head_t tcs_wait;
+	struct rpmh_ctrlr client;
+	struct device *dev;
+	struct rsc_ver ver;
+	u32 *regs;
+};
+
+int rpmh_rsc_send_data(struct rsc_drv *drv, const struct tcs_request *msg);
+int rpmh_rsc_write_ctrl_data(struct rsc_drv *drv,
+			     const struct tcs_request *msg);
+void rpmh_rsc_invalidate(struct rsc_drv *drv);
+void rpmh_rsc_write_next_wakeup(struct rsc_drv *drv);
+
+void rpmh_tx_done(const struct tcs_request *msg);
+int rpmh_flush(struct rpmh_ctrlr *ctrlr);
+
+#endif /* __RPM_INTERNAL_H__ */
diff --git a/drivers/soc/qcom/rpmh-rsc.c b/drivers/soc/qcom/rpmh-rsc.c
new file mode 100644
index 000000000000..de86009ecd91
--- /dev/null
+++ b/drivers/soc/qcom/rpmh-rsc.c
@@ -0,0 +1,1162 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2016-2018, The Linux Foundation. All rights reserved.
+ * Copyright (c) 2023-2024, Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+#define pr_fmt(fmt) "%s " fmt, KBUILD_MODNAME
+
+#include <linux/atomic.h>
+#include <linux/cpu_pm.h>
+#include <linux/delay.h>
+#include <linux/interrupt.h>
+#include <linux/io.h>
+#include <linux/iopoll.h>
+#include <linux/kernel.h>
+#include <linux/ktime.h>
+#include <linux/list.h>
+#include <linux/module.h>
+#include <linux/notifier.h>
+#include <linux/of.h>
+#include <linux/of_irq.h>
+#include <linux/of_platform.h>
+#include <linux/platform_device.h>
+#include <linux/pm_domain.h>
+#include <linux/pm_runtime.h>
+#include <linux/slab.h>
+#include <linux/spinlock.h>
+#include <linux/wait.h>
+
+#include <clocksource/arm_arch_timer.h>
+#include <soc/qcom/cmd-db.h>
+#include <soc/qcom/tcs.h>
+#include <dt-bindings/soc/qcom,rpmh-rsc.h>
+
+#include "rpmh-internal.h"
+
+#define CREATE_TRACE_POINTS
+#include "trace-rpmh.h"
+
+
+#define RSC_DRV_ID			0
+
+#define MAJOR_VER_MASK			0xFF
+#define MAJOR_VER_SHIFT			16
+#define MINOR_VER_MASK			0xFF
+#define MINOR_VER_SHIFT			8
+
+enum {
+	RSC_DRV_TCS_OFFSET,
+	RSC_DRV_CMD_OFFSET,
+	DRV_SOLVER_CONFIG,
+	DRV_PRNT_CHLD_CONFIG,
+	RSC_DRV_IRQ_ENABLE,
+	RSC_DRV_IRQ_STATUS,
+	RSC_DRV_IRQ_CLEAR,
+	RSC_DRV_CMD_WAIT_FOR_CMPL,
+	RSC_DRV_CONTROL,
+	RSC_DRV_STATUS,
+	RSC_DRV_CMD_ENABLE,
+	RSC_DRV_CMD_MSGID,
+	RSC_DRV_CMD_ADDR,
+	RSC_DRV_CMD_DATA,
+	RSC_DRV_CMD_STATUS,
+	RSC_DRV_CMD_RESP_DATA,
+};
+
+/* DRV HW Solver Configuration Information Register */
+#define DRV_HW_SOLVER_MASK		1
+#define DRV_HW_SOLVER_SHIFT		24
+
+/* DRV TCS Configuration Information Register */
+#define DRV_NUM_TCS_MASK		0x3F
+#define DRV_NUM_TCS_SHIFT		6
+#define DRV_NCPT_MASK			0x1F
+#define DRV_NCPT_SHIFT			27
+
+/* Offsets for CONTROL TCS Registers */
+#define RSC_DRV_CTL_TCS_DATA_HI		0x38
+#define RSC_DRV_CTL_TCS_DATA_HI_MASK	0xFFFFFF
+#define RSC_DRV_CTL_TCS_DATA_HI_VALID	BIT(31)
+#define RSC_DRV_CTL_TCS_DATA_LO		0x40
+#define RSC_DRV_CTL_TCS_DATA_LO_MASK	0xFFFFFFFF
+#define RSC_DRV_CTL_TCS_DATA_SIZE	32
+
+#define TCS_AMC_MODE_ENABLE		BIT(16)
+#define TCS_AMC_MODE_TRIGGER		BIT(24)
+
+/* TCS CMD register bit mask */
+#define CMD_MSGID_LEN			8
+#define CMD_MSGID_RESP_REQ		BIT(8)
+#define CMD_MSGID_WRITE			BIT(16)
+#define CMD_STATUS_ISSUED		BIT(8)
+#define CMD_STATUS_COMPL		BIT(16)
+
+/*
+ * Here's a high level overview of how all the registers in RPMH work
+ * together:
+ *
+ * - The main rpmh-rsc address is the base of a register space that can
+ *   be used to find overall configuration of the hardware
+ *   (DRV_PRNT_CHLD_CONFIG). Also found within the rpmh-rsc register
+ *   space are all the TCS blocks. The offset of the TCS blocks is
+ *   specified in the device tree by "qcom,tcs-offset" and used to
+ *   compute tcs_base.
+ * - TCS blocks come one after another. Type, count, and order are
+ *   specified by the device tree as "qcom,tcs-config".
+ * - Each TCS block has some registers, then space for up to 16 commands.
+ *   Note that though address space is reserved for 16 commands, fewer
+ *   might be present. See ncpt (num cmds per TCS).
+ *
+ * Here's a picture:
+ *
+ *  +---------------------------------------------------+
+ *  |RSC                                                |
+ *  | ctrl                                              |
+ *  |                                                   |
+ *  | Drvs:                                             |
+ *  | +-----------------------------------------------+ |
+ *  | |DRV0                                           | |
+ *  | | ctrl/config                                   | |
+ *  | | IRQ                                           | |
+ *  | |                                               | |
+ *  | | TCSes:                                        | |
+ *  | | +------------------------------------------+  | |
+ *  | | |TCS0  |  |  |  |  |  |  |  |  |  |  |  |  |  | |
+ *  | | | ctrl | 0| 1| 2| 3| 4| 5| .| .| .| .|14|15|  | |
+ *  | | |      |  |  |  |  |  |  |  |  |  |  |  |  |  | |
+ *  | | +------------------------------------------+  | |
+ *  | | +------------------------------------------+  | |
+ *  | | |TCS1  |  |  |  |  |  |  |  |  |  |  |  |  |  | |
+ *  | | | ctrl | 0| 1| 2| 3| 4| 5| .| .| .| .|14|15|  | |
+ *  | | |      |  |  |  |  |  |  |  |  |  |  |  |  |  | |
+ *  | | +------------------------------------------+  | |
+ *  | | +------------------------------------------+  | |
+ *  | | |TCS2  |  |  |  |  |  |  |  |  |  |  |  |  |  | |
+ *  | | | ctrl | 0| 1| 2| 3| 4| 5| .| .| .| .|14|15|  | |
+ *  | | |      |  |  |  |  |  |  |  |  |  |  |  |  |  | |
+ *  | | +------------------------------------------+  | |
+ *  | |                    ......                     | |
+ *  | +-----------------------------------------------+ |
+ *  | +-----------------------------------------------+ |
+ *  | |DRV1                                           | |
+ *  | | (same as DRV0)                                | |
+ *  | +-----------------------------------------------+ |
+ *  |                      ......                       |
+ *  +---------------------------------------------------+
+ */
+
+#define USECS_TO_CYCLES(time_usecs)			\
+	xloops_to_cycles((time_usecs) * 0x10C7UL)
+
+static inline unsigned long xloops_to_cycles(u64 xloops)
+{
+	return (xloops * loops_per_jiffy * HZ) >> 32;
+}
+
+static u32 rpmh_rsc_reg_offset_ver_2_7[] = {
+	[RSC_DRV_TCS_OFFSET]		= 672,
+	[RSC_DRV_CMD_OFFSET]		= 20,
+	[DRV_SOLVER_CONFIG]		= 0x04,
+	[DRV_PRNT_CHLD_CONFIG]		= 0x0C,
+	[RSC_DRV_IRQ_ENABLE]		= 0x00,
+	[RSC_DRV_IRQ_STATUS]		= 0x04,
+	[RSC_DRV_IRQ_CLEAR]		= 0x08,
+	[RSC_DRV_CMD_WAIT_FOR_CMPL]	= 0x10,
+	[RSC_DRV_CONTROL]		= 0x14,
+	[RSC_DRV_STATUS]		= 0x18,
+	[RSC_DRV_CMD_ENABLE]		= 0x1C,
+	[RSC_DRV_CMD_MSGID]		= 0x30,
+	[RSC_DRV_CMD_ADDR]		= 0x34,
+	[RSC_DRV_CMD_DATA]		= 0x38,
+	[RSC_DRV_CMD_STATUS]		= 0x3C,
+	[RSC_DRV_CMD_RESP_DATA]		= 0x40,
+};
+
+static u32 rpmh_rsc_reg_offset_ver_3_0[] = {
+	[RSC_DRV_TCS_OFFSET]		= 672,
+	[RSC_DRV_CMD_OFFSET]		= 24,
+	[DRV_SOLVER_CONFIG]		= 0x04,
+	[DRV_PRNT_CHLD_CONFIG]		= 0x0C,
+	[RSC_DRV_IRQ_ENABLE]		= 0x00,
+	[RSC_DRV_IRQ_STATUS]		= 0x04,
+	[RSC_DRV_IRQ_CLEAR]		= 0x08,
+	[RSC_DRV_CMD_WAIT_FOR_CMPL]	= 0x20,
+	[RSC_DRV_CONTROL]		= 0x24,
+	[RSC_DRV_STATUS]		= 0x28,
+	[RSC_DRV_CMD_ENABLE]		= 0x2C,
+	[RSC_DRV_CMD_MSGID]		= 0x34,
+	[RSC_DRV_CMD_ADDR]		= 0x38,
+	[RSC_DRV_CMD_DATA]		= 0x3C,
+	[RSC_DRV_CMD_STATUS]		= 0x40,
+	[RSC_DRV_CMD_RESP_DATA]		= 0x44,
+};
+
+static inline void __iomem *
+tcs_reg_addr(const struct rsc_drv *drv, int reg, int tcs_id)
+{
+	return drv->tcs_base + drv->regs[RSC_DRV_TCS_OFFSET] * tcs_id + reg;
+}
+
+static inline void __iomem *
+tcs_cmd_addr(const struct rsc_drv *drv, int reg, int tcs_id, int cmd_id)
+{
+	return tcs_reg_addr(drv, reg, tcs_id) + drv->regs[RSC_DRV_CMD_OFFSET] * cmd_id;
+}
+
+static u32 read_tcs_cmd(const struct rsc_drv *drv, int reg, int tcs_id,
+			int cmd_id)
+{
+	return readl_relaxed(tcs_cmd_addr(drv, reg, tcs_id, cmd_id));
+}
+
+static u32 read_tcs_reg(const struct rsc_drv *drv, int reg, int tcs_id)
+{
+	return readl_relaxed(tcs_reg_addr(drv, reg, tcs_id));
+}
+
+static void write_tcs_cmd(const struct rsc_drv *drv, int reg, int tcs_id,
+			  int cmd_id, u32 data)
+{
+	writel_relaxed(data, tcs_cmd_addr(drv, reg, tcs_id, cmd_id));
+}
+
+static void write_tcs_reg(const struct rsc_drv *drv, int reg, int tcs_id,
+			  u32 data)
+{
+	writel_relaxed(data, tcs_reg_addr(drv, reg, tcs_id));
+}
+
+static void write_tcs_reg_sync(const struct rsc_drv *drv, int reg, int tcs_id,
+			       u32 data)
+{
+	int i;
+
+	writel(data, tcs_reg_addr(drv, reg, tcs_id));
+
+	/*
+	 * Wait until we read back the same value.  Use a counter rather than
+	 * ktime for timeout since this may be called after timekeeping stops.
+	 */
+	for (i = 0; i < USEC_PER_SEC; i++) {
+		if (readl(tcs_reg_addr(drv, reg, tcs_id)) == data)
+			return;
+		udelay(1);
+	}
+	pr_err("%s: error writing %#x to %d:%#x\n", drv->name,
+	       data, tcs_id, reg);
+}
+
+/**
+ * tcs_invalidate() - Invalidate all TCSes of the given type (sleep or wake).
+ * @drv:  The RSC controller.
+ * @type: SLEEP_TCS or WAKE_TCS
+ *
+ * This will clear the "slots" variable of the given tcs_group and also
+ * tell the hardware to forget about all entries.
+ *
+ * The caller must ensure that no other RPMH actions are happening when this
+ * function is called, since otherwise the device may immediately become
+ * used again even before this function exits.
+ */
+static void tcs_invalidate(struct rsc_drv *drv, int type)
+{
+	int m;
+	struct tcs_group *tcs = &drv->tcs[type];
+
+	/* Caller ensures nobody else is running so no lock */
+	if (bitmap_empty(tcs->slots, MAX_TCS_SLOTS))
+		return;
+
+	for (m = tcs->offset; m < tcs->offset + tcs->num_tcs; m++)
+		write_tcs_reg_sync(drv, drv->regs[RSC_DRV_CMD_ENABLE], m, 0);
+
+	bitmap_zero(tcs->slots, MAX_TCS_SLOTS);
+}
+
+/**
+ * rpmh_rsc_invalidate() - Invalidate sleep and wake TCSes.
+ * @drv: The RSC controller.
+ *
+ * The caller must ensure that no other RPMH actions are happening when this
+ * function is called, since otherwise the device may immediately become
+ * used again even before this function exits.
+ */
+void rpmh_rsc_invalidate(struct rsc_drv *drv)
+{
+	tcs_invalidate(drv, SLEEP_TCS);
+	tcs_invalidate(drv, WAKE_TCS);
+}
+
+/**
+ * get_tcs_for_msg() - Get the tcs_group used to send the given message.
+ * @drv: The RSC controller.
+ * @msg: The message we want to send.
+ *
+ * This is normally pretty straightforward except if we are trying to send
+ * an ACTIVE_ONLY message but don't have any active_only TCSes.
+ *
+ * Return: A pointer to a tcs_group or an ERR_PTR.
+ */
+static struct tcs_group *get_tcs_for_msg(struct rsc_drv *drv,
+					 const struct tcs_request *msg)
+{
+	int type;
+	struct tcs_group *tcs;
+
+	switch (msg->state) {
+	case RPMH_ACTIVE_ONLY_STATE:
+		type = ACTIVE_TCS;
+		break;
+	case RPMH_WAKE_ONLY_STATE:
+		type = WAKE_TCS;
+		break;
+	case RPMH_SLEEP_STATE:
+		type = SLEEP_TCS;
+		break;
+	default:
+		return ERR_PTR(-EINVAL);
+	}
+
+	/*
+	 * If we are making an active request on a RSC that does not have a
+	 * dedicated TCS for active state use, then re-purpose a wake TCS to
+	 * send active votes. This is safe because we ensure any active-only
+	 * transfers have finished before we use it (maybe by running from
+	 * the last CPU in PM code).
+	 */
+	tcs = &drv->tcs[type];
+	if (msg->state == RPMH_ACTIVE_ONLY_STATE && !tcs->num_tcs)
+		tcs = &drv->tcs[WAKE_TCS];
+
+	return tcs;
+}
+
+/**
+ * get_req_from_tcs() - Get a stashed request that was xfering on the given TCS.
+ * @drv:    The RSC controller.
+ * @tcs_id: The global ID of this TCS.
+ *
+ * For ACTIVE_ONLY transfers we want to call back into the client when the
+ * transfer finishes. To do this we need the "request" that the client
+ * originally provided us. This function grabs the request that we stashed
+ * when we started the transfer.
+ *
+ * This only makes sense for ACTIVE_ONLY transfers since those are the only
+ * ones we track sending (the only ones we enable interrupts for and the only
+ * ones we call back to the client for).
+ *
+ * Return: The stashed request.
+ */
+static const struct tcs_request *get_req_from_tcs(struct rsc_drv *drv,
+						  int tcs_id)
+{
+	struct tcs_group *tcs;
+	int i;
+
+	for (i = 0; i < TCS_TYPE_NR; i++) {
+		tcs = &drv->tcs[i];
+		if (tcs->mask & BIT(tcs_id))
+			return tcs->req[tcs_id - tcs->offset];
+	}
+
+	return NULL;
+}
+
+/**
+ * __tcs_set_trigger() - Start xfer on a TCS or unset trigger on a borrowed TCS
+ * @drv:     The controller.
+ * @tcs_id:  The global ID of this TCS.
+ * @trigger: If true then untrigger/retrigger. If false then just untrigger.
+ *
+ * In the normal case we only ever call with "trigger=true" to start a
+ * transfer. That will un-trigger/disable the TCS from the last transfer
+ * then trigger/enable for this transfer.
+ *
+ * If we borrowed a wake TCS for an active-only transfer we'll also call
+ * this function with "trigger=false" to just do the un-trigger/disable
+ * before using the TCS for wake purposes again.
+ *
+ * Note that the AP is only in charge of triggering active-only transfers.
+ * The AP never triggers sleep/wake values using this function.
+ */
+static void __tcs_set_trigger(struct rsc_drv *drv, int tcs_id, bool trigger)
+{
+	u32 enable;
+	u32 reg = drv->regs[RSC_DRV_CONTROL];
+
+	/*
+	 * HW req: Clear the DRV_CONTROL and enable TCS again
+	 * While clearing ensure that the AMC mode trigger is cleared
+	 * and then the mode enable is cleared.
+	 */
+	enable = read_tcs_reg(drv, reg, tcs_id);
+	enable &= ~TCS_AMC_MODE_TRIGGER;
+	write_tcs_reg_sync(drv, reg, tcs_id, enable);
+	enable &= ~TCS_AMC_MODE_ENABLE;
+	write_tcs_reg_sync(drv, reg, tcs_id, enable);
+
+	if (trigger) {
+		/* Enable the AMC mode on the TCS and then trigger the TCS */
+		enable = TCS_AMC_MODE_ENABLE;
+		write_tcs_reg_sync(drv, reg, tcs_id, enable);
+		enable |= TCS_AMC_MODE_TRIGGER;
+		write_tcs_reg(drv, reg, tcs_id, enable);
+	}
+}
+
+/**
+ * enable_tcs_irq() - Enable or disable interrupts on the given TCS.
+ * @drv:     The controller.
+ * @tcs_id:  The global ID of this TCS.
+ * @enable:  If true then enable; if false then disable
+ *
+ * We only ever call this when we borrow a wake TCS for an active-only
+ * transfer. For active-only TCSes interrupts are always left enabled.
+ */
+static void enable_tcs_irq(struct rsc_drv *drv, int tcs_id, bool enable)
+{
+	u32 data;
+	u32 reg = drv->regs[RSC_DRV_IRQ_ENABLE];
+
+	data = readl_relaxed(drv->tcs_base + reg);
+	if (enable)
+		data |= BIT(tcs_id);
+	else
+		data &= ~BIT(tcs_id);
+	writel_relaxed(data, drv->tcs_base + reg);
+}
+
+/**
+ * tcs_tx_done() - TX Done interrupt handler.
+ * @irq: The IRQ number (ignored).
+ * @p:   Pointer to "struct rsc_drv".
+ *
+ * Called for ACTIVE_ONLY transfers (those are the only ones we enable the
+ * IRQ for) when a transfer is done.
+ *
+ * Return: IRQ_HANDLED
+ */
+static irqreturn_t tcs_tx_done(int irq, void *p)
+{
+	struct rsc_drv *drv = p;
+	int i;
+	unsigned long irq_status;
+	const struct tcs_request *req;
+
+	irq_status = readl_relaxed(drv->tcs_base + drv->regs[RSC_DRV_IRQ_STATUS]);
+
+	for_each_set_bit(i, &irq_status, BITS_PER_TYPE(u32)) {
+		req = get_req_from_tcs(drv, i);
+		if (WARN_ON(!req))
+			goto skip;
+
+		trace_rpmh_tx_done(drv, i, req);
+
+		/*
+		 * If wake tcs was re-purposed for sending active
+		 * votes, clear AMC trigger & enable modes and
+		 * disable interrupt for this TCS
+		 */
+		if (!drv->tcs[ACTIVE_TCS].num_tcs)
+			__tcs_set_trigger(drv, i, false);
+skip:
+		/* Reclaim the TCS */
+		write_tcs_reg(drv, drv->regs[RSC_DRV_CMD_ENABLE], i, 0);
+		writel_relaxed(BIT(i), drv->tcs_base + drv->regs[RSC_DRV_IRQ_CLEAR]);
+		spin_lock(&drv->lock);
+		clear_bit(i, drv->tcs_in_use);
+		/*
+		 * Disable interrupt for WAKE TCS to avoid being
+		 * spammed with interrupts coming when the solver
+		 * sends its wake votes.
+		 */
+		if (!drv->tcs[ACTIVE_TCS].num_tcs)
+			enable_tcs_irq(drv, i, false);
+		spin_unlock(&drv->lock);
+		wake_up(&drv->tcs_wait);
+		if (req)
+			rpmh_tx_done(req);
+	}
+
+	return IRQ_HANDLED;
+}
+
+/**
+ * __tcs_buffer_write() - Write to TCS hardware from a request; don't trigger.
+ * @drv:    The controller.
+ * @tcs_id: The global ID of this TCS.
+ * @cmd_id: The index within the TCS to start writing.
+ * @msg:    The message we want to send, which will contain several addr/data
+ *          pairs to program (but few enough that they all fit in one TCS).
+ *
+ * This is used for all types of transfers (active, sleep, and wake).
+ */
+static void __tcs_buffer_write(struct rsc_drv *drv, int tcs_id, int cmd_id,
+			       const struct tcs_request *msg)
+{
+	u32 msgid;
+	u32 cmd_msgid = CMD_MSGID_LEN | CMD_MSGID_WRITE;
+	u32 cmd_enable = 0;
+	struct tcs_cmd *cmd;
+	int i, j;
+
+	/* Convert all commands to RR when the request has wait_for_compl set */
+	cmd_msgid |= msg->wait_for_compl ? CMD_MSGID_RESP_REQ : 0;
+
+	for (i = 0, j = cmd_id; i < msg->num_cmds; i++, j++) {
+		cmd = &msg->cmds[i];
+		cmd_enable |= BIT(j);
+		msgid = cmd_msgid;
+		/*
+		 * Additionally, if the cmd->wait is set, make the command
+		 * response reqd even if the overall request was fire-n-forget.
+		 */
+		msgid |= cmd->wait ? CMD_MSGID_RESP_REQ : 0;
+
+		write_tcs_cmd(drv, drv->regs[RSC_DRV_CMD_MSGID], tcs_id, j, msgid);
+		write_tcs_cmd(drv, drv->regs[RSC_DRV_CMD_ADDR], tcs_id, j, cmd->addr);
+		write_tcs_cmd(drv, drv->regs[RSC_DRV_CMD_DATA], tcs_id, j, cmd->data);
+		trace_rpmh_send_msg(drv, tcs_id, msg->state, j, msgid, cmd);
+	}
+
+	cmd_enable |= read_tcs_reg(drv, drv->regs[RSC_DRV_CMD_ENABLE], tcs_id);
+	write_tcs_reg(drv, drv->regs[RSC_DRV_CMD_ENABLE], tcs_id, cmd_enable);
+}
+
+/**
+ * check_for_req_inflight() - Look to see if conflicting cmds are in flight.
+ * @drv: The controller.
+ * @tcs: A pointer to the tcs_group used for ACTIVE_ONLY transfers.
+ * @msg: The message we want to send, which will contain several addr/data
+ *       pairs to program (but few enough that they all fit in one TCS).
+ *
+ * This will walk through the TCSes in the group and check if any of them
+ * appear to be sending to addresses referenced in the message. If it finds
+ * one it'll return -EBUSY.
+ *
+ * Only for use for active-only transfers.
+ *
+ * Must be called with the drv->lock held since that protects tcs_in_use.
+ *
+ * Return: 0 if nothing in flight or -EBUSY if we should try again later.
+ *         The caller must re-enable interrupts between tries since that's
+ *         the only way tcs_in_use will ever be updated and the only way
+ *         RSC_DRV_CMD_ENABLE will ever be cleared.
+ */
+static int check_for_req_inflight(struct rsc_drv *drv, struct tcs_group *tcs,
+				  const struct tcs_request *msg)
+{
+	unsigned long curr_enabled;
+	u32 addr;
+	int j, k;
+	int i = tcs->offset;
+
+	for_each_set_bit_from(i, drv->tcs_in_use, tcs->offset + tcs->num_tcs) {
+		curr_enabled = read_tcs_reg(drv, drv->regs[RSC_DRV_CMD_ENABLE], i);
+
+		for_each_set_bit(j, &curr_enabled, MAX_CMDS_PER_TCS) {
+			addr = read_tcs_cmd(drv, drv->regs[RSC_DRV_CMD_ADDR], i, j);
+			for (k = 0; k < msg->num_cmds; k++) {
+				if (cmd_db_match_resource_addr(msg->cmds[k].addr, addr))
+					return -EBUSY;
+			}
+		}
+	}
+
+	return 0;
+}
+
+/**
+ * find_free_tcs() - Find free tcs in the given tcs_group; only for active.
+ * @tcs: A pointer to the active-only tcs_group (or the wake tcs_group if
+ *       we borrowed it because there are zero active-only ones).
+ *
+ * Must be called with the drv->lock held since that protects tcs_in_use.
+ *
+ * Return: The first tcs that's free or -EBUSY if all in use.
+ */
+static int find_free_tcs(struct tcs_group *tcs)
+{
+	const struct rsc_drv *drv = tcs->drv;
+	unsigned long i;
+	unsigned long max = tcs->offset + tcs->num_tcs;
+
+	i = find_next_zero_bit(drv->tcs_in_use, max, tcs->offset);
+	if (i >= max)
+		return -EBUSY;
+
+	return i;
+}
+
+/**
+ * claim_tcs_for_req() - Claim a tcs in the given tcs_group; only for active.
+ * @drv: The controller.
+ * @tcs: The tcs_group used for ACTIVE_ONLY transfers.
+ * @msg: The data to be sent.
+ *
+ * Claims a tcs in the given tcs_group while making sure that no existing cmd
+ * is in flight that would conflict with the one in @msg.
+ *
+ * Context: Must be called with the drv->lock held since that protects
+ * tcs_in_use.
+ *
+ * Return: The id of the claimed tcs or -EBUSY if a matching msg is in flight
+ * or the tcs_group is full.
+ */
+static int claim_tcs_for_req(struct rsc_drv *drv, struct tcs_group *tcs,
+			     const struct tcs_request *msg)
+{
+	int ret;
+
+	/*
+	 * The h/w does not like if we send a request to the same address,
+	 * when one is already in-flight or being processed.
+	 */
+	ret = check_for_req_inflight(drv, tcs, msg);
+	if (ret)
+		return ret;
+
+	return find_free_tcs(tcs);
+}
+
+/**
+ * rpmh_rsc_send_data() - Write / trigger active-only message.
+ * @drv: The controller.
+ * @msg: The data to be sent.
+ *
+ * NOTES:
+ * - This is only used for "ACTIVE_ONLY" since the limitations of this
+ *   function don't make sense for sleep/wake cases.
+ * - To do the transfer, we will grab a whole TCS for ourselves--we don't
+ *   try to share. If there are none available we'll wait indefinitely
+ *   for a free one.
+ * - This function will not wait for the commands to be finished, only for
+ *   data to be programmed into the RPMh. See rpmh_tx_done() which will
+ *   be called when the transfer is fully complete.
+ * - This function must be called with interrupts enabled. If the hardware
+ *   is busy doing someone else's transfer we need that transfer to fully
+ *   finish so that we can have the hardware, and to fully finish it needs
+ *   the interrupt handler to run. If the interrupts is set to run on the
+ *   active CPU this can never happen if interrupts are disabled.
+ *
+ * Return: 0 on success, -EINVAL on error.
+ */
+int rpmh_rsc_send_data(struct rsc_drv *drv, const struct tcs_request *msg)
+{
+	struct tcs_group *tcs;
+	int tcs_id;
+
+	might_sleep();
+
+	tcs = get_tcs_for_msg(drv, msg);
+	if (IS_ERR(tcs))
+		return PTR_ERR(tcs);
+
+	spin_lock_irq(&drv->lock);
+
+	/* Wait forever for a free tcs. It better be there eventually! */
+	wait_event_lock_irq(drv->tcs_wait,
+			    (tcs_id = claim_tcs_for_req(drv, tcs, msg)) >= 0,
+			    drv->lock);
+
+	tcs->req[tcs_id - tcs->offset] = msg;
+	set_bit(tcs_id, drv->tcs_in_use);
+	if (msg->state == RPMH_ACTIVE_ONLY_STATE && tcs->type != ACTIVE_TCS) {
+		/*
+		 * Clear previously programmed WAKE commands in selected
+		 * repurposed TCS to avoid triggering them. tcs->slots will be
+		 * cleaned from rpmh_flush() by invoking rpmh_rsc_invalidate()
+		 */
+		write_tcs_reg_sync(drv, drv->regs[RSC_DRV_CMD_ENABLE], tcs_id, 0);
+		enable_tcs_irq(drv, tcs_id, true);
+	}
+	spin_unlock_irq(&drv->lock);
+
+	/*
+	 * These two can be done after the lock is released because:
+	 * - We marked "tcs_in_use" under lock.
+	 * - Once "tcs_in_use" has been marked nobody else could be writing
+	 *   to these registers until the interrupt goes off.
+	 * - The interrupt can't go off until we trigger w/ the last line
+	 *   of __tcs_set_trigger() below.
+	 */
+	__tcs_buffer_write(drv, tcs_id, 0, msg);
+	__tcs_set_trigger(drv, tcs_id, true);
+
+	return 0;
+}
+
+/**
+ * find_slots() - Find a place to write the given message.
+ * @tcs:    The tcs group to search.
+ * @msg:    The message we want to find room for.
+ * @tcs_id: If we return 0 from the function, we return the global ID of the
+ *          TCS to write to here.
+ * @cmd_id: If we return 0 from the function, we return the index of
+ *          the command array of the returned TCS where the client should
+ *          start writing the message.
+ *
+ * Only for use on sleep/wake TCSes since those are the only ones we maintain
+ * tcs->slots for.
+ *
+ * Return: -ENOMEM if there was no room, else 0.
+ */
+static int find_slots(struct tcs_group *tcs, const struct tcs_request *msg,
+		      int *tcs_id, int *cmd_id)
+{
+	int slot, offset;
+	int i = 0;
+
+	/* Do over, until we can fit the full payload in a single TCS */
+	do {
+		slot = bitmap_find_next_zero_area(tcs->slots, MAX_TCS_SLOTS,
+						  i, msg->num_cmds, 0);
+		if (slot >= tcs->num_tcs * tcs->ncpt)
+			return -ENOMEM;
+		i += tcs->ncpt;
+	} while (slot + msg->num_cmds - 1 >= i);
+
+	bitmap_set(tcs->slots, slot, msg->num_cmds);
+
+	offset = slot / tcs->ncpt;
+	*tcs_id = offset + tcs->offset;
+	*cmd_id = slot % tcs->ncpt;
+
+	return 0;
+}
+
+/**
+ * rpmh_rsc_write_ctrl_data() - Write request to controller but don't trigger.
+ * @drv: The controller.
+ * @msg: The data to be written to the controller.
+ *
+ * This should only be called for sleep/wake state, never active-only
+ * state.
+ *
+ * The caller must ensure that no other RPMH actions are happening and the
+ * controller is idle when this function is called since it runs lockless.
+ *
+ * Return: 0 if no error; else -error.
+ */
+int rpmh_rsc_write_ctrl_data(struct rsc_drv *drv, const struct tcs_request *msg)
+{
+	struct tcs_group *tcs;
+	int tcs_id = 0, cmd_id = 0;
+	int ret;
+
+	tcs = get_tcs_for_msg(drv, msg);
+	if (IS_ERR(tcs))
+		return PTR_ERR(tcs);
+
+	/* find the TCS id and the command in the TCS to write to */
+	ret = find_slots(tcs, msg, &tcs_id, &cmd_id);
+	if (!ret)
+		__tcs_buffer_write(drv, tcs_id, cmd_id, msg);
+
+	return ret;
+}
+
+/**
+ * rpmh_rsc_ctrlr_is_busy() - Check if any of the AMCs are busy.
+ * @drv: The controller
+ *
+ * Checks if any of the AMCs are busy in handling ACTIVE sets.
+ * This is called from the last cpu powering down before flushing
+ * SLEEP and WAKE sets. If AMCs are busy, controller can not enter
+ * power collapse, so deny from the last cpu's pm notification.
+ *
+ * Context: Must be called with the drv->lock held.
+ *
+ * Return:
+ * * False		- AMCs are idle
+ * * True		- AMCs are busy
+ */
+static bool rpmh_rsc_ctrlr_is_busy(struct rsc_drv *drv)
+{
+	unsigned long set;
+	const struct tcs_group *tcs = &drv->tcs[ACTIVE_TCS];
+	unsigned long max;
+
+	/*
+	 * If we made an active request on a RSC that does not have a
+	 * dedicated TCS for active state use, then re-purposed wake TCSes
+	 * should be checked for not busy, because we used wake TCSes for
+	 * active requests in this case.
+	 */
+	if (!tcs->num_tcs)
+		tcs = &drv->tcs[WAKE_TCS];
+
+	max = tcs->offset + tcs->num_tcs;
+	set = find_next_bit(drv->tcs_in_use, max, tcs->offset);
+
+	return set < max;
+}
+
+/**
+ * rpmh_rsc_write_next_wakeup() - Write next wakeup in CONTROL_TCS.
+ * @drv: The controller
+ *
+ * Writes maximum wakeup cycles when called from suspend.
+ * Writes earliest hrtimer wakeup when called from idle.
+ */
+void rpmh_rsc_write_next_wakeup(struct rsc_drv *drv)
+{
+	ktime_t now, wakeup;
+	u64 wakeup_us, wakeup_cycles = ~0;
+	u32 lo, hi;
+
+	if (!drv->tcs[CONTROL_TCS].num_tcs || !drv->genpd_nb.notifier_call)
+		return;
+
+	/* Set highest time when system (timekeeping) is suspended */
+	if (system_state == SYSTEM_SUSPEND)
+		goto exit;
+
+	/* Find the earliest hrtimer wakeup from online cpus */
+	wakeup = dev_pm_genpd_get_next_hrtimer(drv->dev);
+
+	/* Find the relative wakeup in kernel time scale */
+	now = ktime_get();
+	wakeup = ktime_sub(wakeup, now);
+	wakeup_us = ktime_to_us(wakeup);
+
+	/* Convert the wakeup to arch timer scale */
+	wakeup_cycles = USECS_TO_CYCLES(wakeup_us);
+	wakeup_cycles += arch_timer_read_counter();
+
+exit:
+	lo = wakeup_cycles & RSC_DRV_CTL_TCS_DATA_LO_MASK;
+	hi = wakeup_cycles >> RSC_DRV_CTL_TCS_DATA_SIZE;
+	hi &= RSC_DRV_CTL_TCS_DATA_HI_MASK;
+	hi |= RSC_DRV_CTL_TCS_DATA_HI_VALID;
+
+	writel_relaxed(lo, drv->base + RSC_DRV_CTL_TCS_DATA_LO);
+	writel_relaxed(hi, drv->base + RSC_DRV_CTL_TCS_DATA_HI);
+}
+
+/**
+ * rpmh_rsc_cpu_pm_callback() - Check if any of the AMCs are busy.
+ * @nfb:    Pointer to the notifier block in struct rsc_drv.
+ * @action: CPU_PM_ENTER, CPU_PM_ENTER_FAILED, or CPU_PM_EXIT.
+ * @v:      Unused
+ *
+ * This function is given to cpu_pm_register_notifier so we can be informed
+ * about when CPUs go down. When all CPUs go down we know no more active
+ * transfers will be started so we write sleep/wake sets. This function gets
+ * called from cpuidle code paths and also at system suspend time.
+ *
+ * If its last CPU going down and AMCs are not busy then writes cached sleep
+ * and wake messages to TCSes. The firmware then takes care of triggering
+ * them when entering deepest low power modes.
+ *
+ * Return: See cpu_pm_register_notifier()
+ */
+static int rpmh_rsc_cpu_pm_callback(struct notifier_block *nfb,
+				    unsigned long action, void *v)
+{
+	struct rsc_drv *drv = container_of(nfb, struct rsc_drv, rsc_pm);
+	int ret = NOTIFY_OK;
+	int cpus_in_pm;
+
+	switch (action) {
+	case CPU_PM_ENTER:
+		cpus_in_pm = atomic_inc_return(&drv->cpus_in_pm);
+		/*
+		 * NOTE: comments for num_online_cpus() point out that it's
+		 * only a snapshot so we need to be careful. It should be OK
+		 * for us to use, though.  It's important for us not to miss
+		 * if we're the last CPU going down so it would only be a
+		 * problem if a CPU went offline right after we did the check
+		 * AND that CPU was not idle AND that CPU was the last non-idle
+		 * CPU. That can't happen. CPUs would have to come out of idle
+		 * before the CPU could go offline.
+		 */
+		if (cpus_in_pm < num_online_cpus())
+			return NOTIFY_OK;
+		break;
+	case CPU_PM_ENTER_FAILED:
+	case CPU_PM_EXIT:
+		atomic_dec(&drv->cpus_in_pm);
+		return NOTIFY_OK;
+	default:
+		return NOTIFY_DONE;
+	}
+
+	/*
+	 * It's likely we're on the last CPU. Grab the drv->lock and write
+	 * out the sleep/wake commands to RPMH hardware. Grabbing the lock
+	 * means that if we race with another CPU coming up we are still
+	 * guaranteed to be safe. If another CPU came up just after we checked
+	 * and has grabbed the lock or started an active transfer then we'll
+	 * notice we're busy and abort. If another CPU comes up after we start
+	 * flushing it will be blocked from starting an active transfer until
+	 * we're done flushing. If another CPU starts an active transfer after
+	 * we release the lock we're still OK because we're no longer the last
+	 * CPU.
+	 */
+	if (spin_trylock(&drv->lock)) {
+		if (rpmh_rsc_ctrlr_is_busy(drv) || rpmh_flush(&drv->client))
+			ret = NOTIFY_BAD;
+		spin_unlock(&drv->lock);
+	} else {
+		/* Another CPU must be up */
+		return NOTIFY_OK;
+	}
+
+	if (ret == NOTIFY_BAD) {
+		/* Double-check if we're here because someone else is up */
+		if (cpus_in_pm < num_online_cpus())
+			ret = NOTIFY_OK;
+		else
+			/* We won't be called w/ CPU_PM_ENTER_FAILED */
+			atomic_dec(&drv->cpus_in_pm);
+	}
+
+	return ret;
+}
+
+/**
+ * rpmh_rsc_pd_callback() - Check if any of the AMCs are busy.
+ * @nfb:    Pointer to the genpd notifier block in struct rsc_drv.
+ * @action: GENPD_NOTIFY_PRE_OFF, GENPD_NOTIFY_OFF, GENPD_NOTIFY_PRE_ON or GENPD_NOTIFY_ON.
+ * @v:      Unused
+ *
+ * This function is given to dev_pm_genpd_add_notifier() so we can be informed
+ * about when cluster-pd is going down. When cluster go down we know no more active
+ * transfers will be started so we write sleep/wake sets. This function gets
+ * called from cpuidle code paths and also at system suspend time.
+ *
+ * If AMCs are not busy then writes cached sleep and wake messages to TCSes.
+ * The firmware then takes care of triggering them when entering deepest low power modes.
+ *
+ * Return:
+ * * NOTIFY_OK          - success
+ * * NOTIFY_BAD         - failure
+ */
+static int rpmh_rsc_pd_callback(struct notifier_block *nfb,
+				unsigned long action, void *v)
+{
+	struct rsc_drv *drv = container_of(nfb, struct rsc_drv, genpd_nb);
+
+	/* We don't need to lock as genpd on/off are serialized */
+	if ((action == GENPD_NOTIFY_PRE_OFF) &&
+	    (rpmh_rsc_ctrlr_is_busy(drv) || rpmh_flush(&drv->client)))
+		return NOTIFY_BAD;
+
+	return NOTIFY_OK;
+}
+
+static int rpmh_rsc_pd_attach(struct rsc_drv *drv, struct device *dev)
+{
+	int ret;
+
+	pm_runtime_enable(dev);
+	drv->genpd_nb.notifier_call = rpmh_rsc_pd_callback;
+	ret = dev_pm_genpd_add_notifier(dev, &drv->genpd_nb);
+	if (ret)
+		pm_runtime_disable(dev);
+
+	return ret;
+}
+
+static int rpmh_probe_tcs_config(struct platform_device *pdev, struct rsc_drv *drv)
+{
+	struct tcs_type_config {
+		u32 type;
+		u32 n;
+	} tcs_cfg[TCS_TYPE_NR] = { { 0 } };
+	struct device_node *dn = pdev->dev.of_node;
+	u32 config, max_tcs, ncpt, offset;
+	int i, ret, n, st = 0;
+	struct tcs_group *tcs;
+
+	ret = of_property_read_u32(dn, "qcom,tcs-offset", &offset);
+	if (ret)
+		return ret;
+	drv->tcs_base = drv->base + offset;
+
+	config = readl_relaxed(drv->base + drv->regs[DRV_PRNT_CHLD_CONFIG]);
+
+	max_tcs = config;
+	max_tcs &= DRV_NUM_TCS_MASK << (DRV_NUM_TCS_SHIFT * drv->id);
+	max_tcs = max_tcs >> (DRV_NUM_TCS_SHIFT * drv->id);
+
+	ncpt = config & (DRV_NCPT_MASK << DRV_NCPT_SHIFT);
+	ncpt = ncpt >> DRV_NCPT_SHIFT;
+
+	n = of_property_count_u32_elems(dn, "qcom,tcs-config");
+	if (n != 2 * TCS_TYPE_NR)
+		return -EINVAL;
+
+	for (i = 0; i < TCS_TYPE_NR; i++) {
+		ret = of_property_read_u32_index(dn, "qcom,tcs-config",
+						 i * 2, &tcs_cfg[i].type);
+		if (ret)
+			return ret;
+		if (tcs_cfg[i].type >= TCS_TYPE_NR)
+			return -EINVAL;
+
+		ret = of_property_read_u32_index(dn, "qcom,tcs-config",
+						 i * 2 + 1, &tcs_cfg[i].n);
+		if (ret)
+			return ret;
+		if (tcs_cfg[i].n > MAX_TCS_PER_TYPE)
+			return -EINVAL;
+	}
+
+	for (i = 0; i < TCS_TYPE_NR; i++) {
+		tcs = &drv->tcs[tcs_cfg[i].type];
+		if (tcs->drv)
+			return -EINVAL;
+		tcs->drv = drv;
+		tcs->type = tcs_cfg[i].type;
+		tcs->num_tcs = tcs_cfg[i].n;
+		tcs->ncpt = ncpt;
+
+		if (!tcs->num_tcs || tcs->type == CONTROL_TCS)
+			continue;
+
+		if (st + tcs->num_tcs > max_tcs ||
+		    st + tcs->num_tcs >= BITS_PER_BYTE * sizeof(tcs->mask))
+			return -EINVAL;
+
+		tcs->mask = ((1 << tcs->num_tcs) - 1) << st;
+		tcs->offset = st;
+		st += tcs->num_tcs;
+	}
+
+	drv->num_tcs = st;
+
+	return 0;
+}
+
+static int rpmh_rsc_probe(struct platform_device *pdev)
+{
+	struct device_node *dn = pdev->dev.of_node;
+	struct rsc_drv *drv;
+	char drv_id[10] = {0};
+	int ret, irq;
+	u32 solver_config;
+	u32 rsc_id;
+
+	/*
+	 * Even though RPMh doesn't directly use cmd-db, all of its children
+	 * do. To avoid adding this check to our children we'll do it now.
+	 */
+	ret = cmd_db_ready();
+	if (ret) {
+		if (ret != -EPROBE_DEFER)
+			dev_err(&pdev->dev, "Command DB not available (%d)\n",
+									ret);
+		return ret;
+	}
+
+	drv = devm_kzalloc(&pdev->dev, sizeof(*drv), GFP_KERNEL);
+	if (!drv)
+		return -ENOMEM;
+
+	ret = of_property_read_u32(dn, "qcom,drv-id", &drv->id);
+	if (ret)
+		return ret;
+
+	drv->name = of_get_property(dn, "label", NULL);
+	if (!drv->name)
+		drv->name = dev_name(&pdev->dev);
+
+	snprintf(drv_id, ARRAY_SIZE(drv_id), "drv-%d", drv->id);
+	drv->base = devm_platform_ioremap_resource_byname(pdev, drv_id);
+	if (IS_ERR(drv->base))
+		return PTR_ERR(drv->base);
+
+	rsc_id = readl_relaxed(drv->base + RSC_DRV_ID);
+	drv->ver.major = rsc_id & (MAJOR_VER_MASK << MAJOR_VER_SHIFT);
+	drv->ver.major >>= MAJOR_VER_SHIFT;
+	drv->ver.minor = rsc_id & (MINOR_VER_MASK << MINOR_VER_SHIFT);
+	drv->ver.minor >>= MINOR_VER_SHIFT;
+
+	if (drv->ver.major == 3)
+		drv->regs = rpmh_rsc_reg_offset_ver_3_0;
+	else
+		drv->regs = rpmh_rsc_reg_offset_ver_2_7;
+
+	ret = rpmh_probe_tcs_config(pdev, drv);
+	if (ret)
+		return ret;
+
+	spin_lock_init(&drv->lock);
+	init_waitqueue_head(&drv->tcs_wait);
+	bitmap_zero(drv->tcs_in_use, MAX_TCS_NR);
+
+	irq = platform_get_irq(pdev, drv->id);
+	if (irq < 0)
+		return irq;
+
+	ret = devm_request_irq(&pdev->dev, irq, tcs_tx_done,
+			       IRQF_TRIGGER_HIGH | IRQF_NO_SUSPEND,
+			       drv->name, drv);
+	if (ret)
+		return ret;
+
+	/*
+	 * CPU PM/genpd notification are not required for controllers that support
+	 * 'HW solver' mode where they can be in autonomous mode executing low
+	 * power mode to power down.
+	 */
+	solver_config = readl_relaxed(drv->base + drv->regs[DRV_SOLVER_CONFIG]);
+	solver_config &= DRV_HW_SOLVER_MASK << DRV_HW_SOLVER_SHIFT;
+	solver_config = solver_config >> DRV_HW_SOLVER_SHIFT;
+	if (!solver_config) {
+		if (pdev->dev.pm_domain) {
+			ret = rpmh_rsc_pd_attach(drv, &pdev->dev);
+			if (ret)
+				return ret;
+		} else {
+			drv->rsc_pm.notifier_call = rpmh_rsc_cpu_pm_callback;
+			cpu_pm_register_notifier(&drv->rsc_pm);
+		}
+	}
+
+	/* Enable the active TCS to send requests immediately */
+	writel_relaxed(drv->tcs[ACTIVE_TCS].mask,
+		       drv->tcs_base + drv->regs[RSC_DRV_IRQ_ENABLE]);
+
+	spin_lock_init(&drv->client.cache_lock);
+	INIT_LIST_HEAD(&drv->client.cache);
+	INIT_LIST_HEAD(&drv->client.batch_cache);
+
+	dev_set_drvdata(&pdev->dev, drv);
+	drv->dev = &pdev->dev;
+
+	ret = devm_of_platform_populate(&pdev->dev);
+	if (ret && pdev->dev.pm_domain) {
+		dev_pm_genpd_remove_notifier(&pdev->dev);
+		pm_runtime_disable(&pdev->dev);
+	}
+
+	return ret;
+}
+
+static const struct of_device_id rpmh_drv_match[] = {
+	{ .compatible = "qcom,rpmh-rsc", },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, rpmh_drv_match);
+
+static struct platform_driver rpmh_driver = {
+	.probe = rpmh_rsc_probe,
+	.driver = {
+		  .name = "rpmh",
+		  .of_match_table = rpmh_drv_match,
+		  .suppress_bind_attrs = true,
+	},
+};
+
+static int __init rpmh_driver_init(void)
+{
+	return platform_driver_register(&rpmh_driver);
+}
+core_initcall(rpmh_driver_init);
+
+MODULE_DESCRIPTION("Qualcomm Technologies, Inc. RPMh Driver");
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/soc/qcom/rpmh.c b/drivers/soc/qcom/rpmh.c
new file mode 100644
index 000000000000..8903ed956312
--- /dev/null
+++ b/drivers/soc/qcom/rpmh.c
@@ -0,0 +1,502 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2016-2018, The Linux Foundation. All rights reserved.
+ */
+
+#include <linux/atomic.h>
+#include <linux/bug.h>
+#include <linux/interrupt.h>
+#include <linux/jiffies.h>
+#include <linux/kernel.h>
+#include <linux/list.h>
+#include <linux/lockdep.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+#include <linux/spinlock.h>
+#include <linux/types.h>
+#include <linux/wait.h>
+
+#include <soc/qcom/rpmh.h>
+
+#include "rpmh-internal.h"
+
+#define RPMH_TIMEOUT_MS			msecs_to_jiffies(10000)
+
+#define DEFINE_RPMH_MSG_ONSTACK(device, s, q, name)	\
+	struct rpmh_request name = {			\
+		.msg = {				\
+			.state = s,			\
+			.cmds = name.cmd,		\
+			.num_cmds = 0,			\
+			.wait_for_compl = true,		\
+		},					\
+		.cmd = { { 0 } },			\
+		.completion = q,			\
+		.dev = device,				\
+		.needs_free = false,				\
+	}
+
+#define ctrlr_to_drv(ctrlr) container_of(ctrlr, struct rsc_drv, client)
+
+/**
+ * struct cache_req: the request object for caching
+ *
+ * @addr: the address of the resource
+ * @sleep_val: the sleep vote
+ * @wake_val: the wake vote
+ * @list: linked list obj
+ */
+struct cache_req {
+	u32 addr;
+	u32 sleep_val;
+	u32 wake_val;
+	struct list_head list;
+};
+
+/**
+ * struct batch_cache_req - An entry in our batch catch
+ *
+ * @list: linked list obj
+ * @count: number of messages
+ * @rpm_msgs: the messages
+ */
+
+struct batch_cache_req {
+	struct list_head list;
+	int count;
+	struct rpmh_request rpm_msgs[];
+};
+
+static struct rpmh_ctrlr *get_rpmh_ctrlr(const struct device *dev)
+{
+	struct rsc_drv *drv = dev_get_drvdata(dev->parent);
+
+	return &drv->client;
+}
+
+void rpmh_tx_done(const struct tcs_request *msg)
+{
+	struct rpmh_request *rpm_msg = container_of(msg, struct rpmh_request,
+						    msg);
+	struct completion *compl = rpm_msg->completion;
+	bool free = rpm_msg->needs_free;
+
+	if (!compl)
+		goto exit;
+
+	/* Signal the blocking thread we are done */
+	complete(compl);
+
+exit:
+	if (free)
+		kfree(rpm_msg);
+}
+
+static struct cache_req *__find_req(struct rpmh_ctrlr *ctrlr, u32 addr)
+{
+	struct cache_req *p, *req = NULL;
+
+	list_for_each_entry(p, &ctrlr->cache, list) {
+		if (p->addr == addr) {
+			req = p;
+			break;
+		}
+	}
+
+	return req;
+}
+
+static struct cache_req *cache_rpm_request(struct rpmh_ctrlr *ctrlr,
+					   enum rpmh_state state,
+					   struct tcs_cmd *cmd)
+{
+	struct cache_req *req;
+	unsigned long flags;
+	u32 old_sleep_val, old_wake_val;
+
+	spin_lock_irqsave(&ctrlr->cache_lock, flags);
+	req = __find_req(ctrlr, cmd->addr);
+	if (req)
+		goto existing;
+
+	req = kzalloc(sizeof(*req), GFP_ATOMIC);
+	if (!req) {
+		req = ERR_PTR(-ENOMEM);
+		goto unlock;
+	}
+
+	req->addr = cmd->addr;
+	req->sleep_val = req->wake_val = UINT_MAX;
+	list_add_tail(&req->list, &ctrlr->cache);
+
+existing:
+	old_sleep_val = req->sleep_val;
+	old_wake_val = req->wake_val;
+
+	switch (state) {
+	case RPMH_ACTIVE_ONLY_STATE:
+	case RPMH_WAKE_ONLY_STATE:
+		req->wake_val = cmd->data;
+		break;
+	case RPMH_SLEEP_STATE:
+		req->sleep_val = cmd->data;
+		break;
+	}
+
+	ctrlr->dirty |= (req->sleep_val != old_sleep_val ||
+			 req->wake_val != old_wake_val) &&
+			 req->sleep_val != UINT_MAX &&
+			 req->wake_val != UINT_MAX;
+
+unlock:
+	spin_unlock_irqrestore(&ctrlr->cache_lock, flags);
+
+	return req;
+}
+
+/**
+ * __rpmh_write: Cache and send the RPMH request
+ *
+ * @dev: The device making the request
+ * @state: Active/Sleep request type
+ * @rpm_msg: The data that needs to be sent (cmds).
+ *
+ * Cache the RPMH request and send if the state is ACTIVE_ONLY.
+ * SLEEP/WAKE_ONLY requests are not sent to the controller at
+ * this time. Use rpmh_flush() to send them to the controller.
+ */
+static int __rpmh_write(const struct device *dev, enum rpmh_state state,
+			struct rpmh_request *rpm_msg)
+{
+	struct rpmh_ctrlr *ctrlr = get_rpmh_ctrlr(dev);
+	int ret = -EINVAL;
+	struct cache_req *req;
+	int i;
+
+	/* Cache the request in our store and link the payload */
+	for (i = 0; i < rpm_msg->msg.num_cmds; i++) {
+		req = cache_rpm_request(ctrlr, state, &rpm_msg->msg.cmds[i]);
+		if (IS_ERR(req))
+			return PTR_ERR(req);
+	}
+
+	if (state == RPMH_ACTIVE_ONLY_STATE) {
+		ret = rpmh_rsc_send_data(ctrlr_to_drv(ctrlr), &rpm_msg->msg);
+	} else {
+		/* Clean up our call by spoofing tx_done */
+		ret = 0;
+		rpmh_tx_done(&rpm_msg->msg);
+	}
+
+	return ret;
+}
+
+static int __fill_rpmh_msg(struct rpmh_request *req, enum rpmh_state state,
+		const struct tcs_cmd *cmd, u32 n)
+{
+	if (!cmd || !n || n > MAX_RPMH_PAYLOAD)
+		return -EINVAL;
+
+	memcpy(req->cmd, cmd, n * sizeof(*cmd));
+
+	req->msg.state = state;
+	req->msg.cmds = req->cmd;
+	req->msg.num_cmds = n;
+
+	return 0;
+}
+
+/**
+ * rpmh_write_async: Write a set of RPMH commands
+ *
+ * @dev: The device making the request
+ * @state: Active/sleep set
+ * @cmd: The payload data
+ * @n: The number of elements in payload
+ *
+ * Write a set of RPMH commands, the order of commands is maintained
+ * and will be sent as a single shot.
+ */
+int rpmh_write_async(const struct device *dev, enum rpmh_state state,
+		     const struct tcs_cmd *cmd, u32 n)
+{
+	struct rpmh_request *rpm_msg;
+	int ret;
+
+	rpm_msg = kzalloc(sizeof(*rpm_msg), GFP_ATOMIC);
+	if (!rpm_msg)
+		return -ENOMEM;
+	rpm_msg->needs_free = true;
+
+	ret = __fill_rpmh_msg(rpm_msg, state, cmd, n);
+	if (ret) {
+		kfree(rpm_msg);
+		return ret;
+	}
+
+	return __rpmh_write(dev, state, rpm_msg);
+}
+EXPORT_SYMBOL_GPL(rpmh_write_async);
+
+/**
+ * rpmh_write: Write a set of RPMH commands and block until response
+ *
+ * @dev: The device making the request
+ * @state: Active/sleep set
+ * @cmd: The payload data
+ * @n: The number of elements in @cmd
+ *
+ * May sleep. Do not call from atomic contexts.
+ */
+int rpmh_write(const struct device *dev, enum rpmh_state state,
+	       const struct tcs_cmd *cmd, u32 n)
+{
+	DECLARE_COMPLETION_ONSTACK(compl);
+	DEFINE_RPMH_MSG_ONSTACK(dev, state, &compl, rpm_msg);
+	int ret;
+
+	ret = __fill_rpmh_msg(&rpm_msg, state, cmd, n);
+	if (ret)
+		return ret;
+
+	ret = __rpmh_write(dev, state, &rpm_msg);
+	if (ret)
+		return ret;
+
+	ret = wait_for_completion_timeout(&compl, RPMH_TIMEOUT_MS);
+	WARN_ON(!ret);
+	return (ret > 0) ? 0 : -ETIMEDOUT;
+}
+EXPORT_SYMBOL_GPL(rpmh_write);
+
+static void cache_batch(struct rpmh_ctrlr *ctrlr, struct batch_cache_req *req)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&ctrlr->cache_lock, flags);
+	list_add_tail(&req->list, &ctrlr->batch_cache);
+	ctrlr->dirty = true;
+	spin_unlock_irqrestore(&ctrlr->cache_lock, flags);
+}
+
+static int flush_batch(struct rpmh_ctrlr *ctrlr)
+{
+	struct batch_cache_req *req;
+	const struct rpmh_request *rpm_msg;
+	int ret = 0;
+	int i;
+
+	/* Send Sleep/Wake requests to the controller, expect no response */
+	list_for_each_entry(req, &ctrlr->batch_cache, list) {
+		for (i = 0; i < req->count; i++) {
+			rpm_msg = req->rpm_msgs + i;
+			ret = rpmh_rsc_write_ctrl_data(ctrlr_to_drv(ctrlr),
+						       &rpm_msg->msg);
+			if (ret)
+				break;
+		}
+	}
+
+	return ret;
+}
+
+/**
+ * rpmh_write_batch: Write multiple sets of RPMH commands and wait for the
+ * batch to finish.
+ *
+ * @dev: the device making the request
+ * @state: Active/sleep set
+ * @cmd: The payload data
+ * @n: The array of count of elements in each batch, 0 terminated.
+ *
+ * Write a request to the RSC controller without caching. If the request
+ * state is ACTIVE, then the requests are treated as completion request
+ * and sent to the controller immediately. The function waits until all the
+ * commands are complete. If the request was to SLEEP or WAKE_ONLY, then the
+ * request is sent as fire-n-forget and no ack is expected.
+ *
+ * May sleep. Do not call from atomic contexts for ACTIVE_ONLY requests.
+ */
+int rpmh_write_batch(const struct device *dev, enum rpmh_state state,
+		     const struct tcs_cmd *cmd, u32 *n)
+{
+	struct batch_cache_req *req;
+	struct rpmh_request *rpm_msgs;
+	struct completion *compls;
+	struct rpmh_ctrlr *ctrlr = get_rpmh_ctrlr(dev);
+	unsigned long time_left;
+	int count = 0;
+	int ret, i;
+	void *ptr;
+
+	if (!cmd || !n)
+		return -EINVAL;
+
+	while (n[count] > 0)
+		count++;
+	if (!count)
+		return -EINVAL;
+
+	ptr = kzalloc(sizeof(*req) +
+		      count * (sizeof(req->rpm_msgs[0]) + sizeof(*compls)),
+		      GFP_ATOMIC);
+	if (!ptr)
+		return -ENOMEM;
+
+	req = ptr;
+	compls = ptr + sizeof(*req) + count * sizeof(*rpm_msgs);
+
+	req->count = count;
+	rpm_msgs = req->rpm_msgs;
+
+	for (i = 0; i < count; i++) {
+		__fill_rpmh_msg(rpm_msgs + i, state, cmd, n[i]);
+		cmd += n[i];
+	}
+
+	if (state != RPMH_ACTIVE_ONLY_STATE) {
+		cache_batch(ctrlr, req);
+		return 0;
+	}
+
+	for (i = 0; i < count; i++) {
+		struct completion *compl = &compls[i];
+
+		init_completion(compl);
+		rpm_msgs[i].completion = compl;
+		ret = rpmh_rsc_send_data(ctrlr_to_drv(ctrlr), &rpm_msgs[i].msg);
+		if (ret) {
+			pr_err("Error(%d) sending RPMH message addr=%#x\n",
+			       ret, rpm_msgs[i].msg.cmds[0].addr);
+			break;
+		}
+	}
+
+	time_left = RPMH_TIMEOUT_MS;
+	while (i--) {
+		time_left = wait_for_completion_timeout(&compls[i], time_left);
+		if (!time_left) {
+			/*
+			 * Better hope they never finish because they'll signal
+			 * the completion that we're going to free once
+			 * we've returned from this function.
+			 */
+			WARN_ON(1);
+			ret = -ETIMEDOUT;
+			goto exit;
+		}
+	}
+
+exit:
+	kfree(ptr);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(rpmh_write_batch);
+
+static int is_req_valid(struct cache_req *req)
+{
+	return (req->sleep_val != UINT_MAX &&
+		req->wake_val != UINT_MAX &&
+		req->sleep_val != req->wake_val);
+}
+
+static int send_single(struct rpmh_ctrlr *ctrlr, enum rpmh_state state,
+		       u32 addr, u32 data)
+{
+	DEFINE_RPMH_MSG_ONSTACK(NULL, state, NULL, rpm_msg);
+
+	/* Wake sets are always complete and sleep sets are not */
+	rpm_msg.msg.wait_for_compl = (state == RPMH_WAKE_ONLY_STATE);
+	rpm_msg.cmd[0].addr = addr;
+	rpm_msg.cmd[0].data = data;
+	rpm_msg.msg.num_cmds = 1;
+
+	return rpmh_rsc_write_ctrl_data(ctrlr_to_drv(ctrlr), &rpm_msg.msg);
+}
+
+/**
+ * rpmh_flush() - Flushes the buffered sleep and wake sets to TCSes
+ *
+ * @ctrlr: Controller making request to flush cached data
+ *
+ * Return:
+ * * 0          - Success
+ * * Error code - Otherwise
+ */
+int rpmh_flush(struct rpmh_ctrlr *ctrlr)
+{
+	struct cache_req *p;
+	int ret = 0;
+
+	lockdep_assert_irqs_disabled();
+
+	/*
+	 * Currently rpmh_flush() is only called when we think we're running
+	 * on the last processor.  If the lock is busy it means another
+	 * processor is up and it's better to abort than spin.
+	 */
+	if (!spin_trylock(&ctrlr->cache_lock))
+		return -EBUSY;
+
+	if (!ctrlr->dirty) {
+		pr_debug("Skipping flush, TCS has latest data.\n");
+		goto write_next_wakeup;
+	}
+
+	/* Invalidate the TCSes first to avoid stale data */
+	rpmh_rsc_invalidate(ctrlr_to_drv(ctrlr));
+
+	/* First flush the cached batch requests */
+	ret = flush_batch(ctrlr);
+	if (ret)
+		goto exit;
+
+	list_for_each_entry(p, &ctrlr->cache, list) {
+		if (!is_req_valid(p)) {
+			pr_debug("%s: skipping RPMH req: a:%#x s:%#x w:%#x",
+				 __func__, p->addr, p->sleep_val, p->wake_val);
+			continue;
+		}
+		ret = send_single(ctrlr, RPMH_SLEEP_STATE, p->addr,
+				  p->sleep_val);
+		if (ret)
+			goto exit;
+		ret = send_single(ctrlr, RPMH_WAKE_ONLY_STATE, p->addr,
+				  p->wake_val);
+		if (ret)
+			goto exit;
+	}
+
+	ctrlr->dirty = false;
+
+write_next_wakeup:
+	rpmh_rsc_write_next_wakeup(ctrlr_to_drv(ctrlr));
+exit:
+	spin_unlock(&ctrlr->cache_lock);
+	return ret;
+}
+
+/**
+ * rpmh_invalidate: Invalidate sleep and wake sets in batch_cache
+ *
+ * @dev: The device making the request
+ *
+ * Invalidate the sleep and wake values in batch_cache.
+ */
+void rpmh_invalidate(const struct device *dev)
+{
+	struct rpmh_ctrlr *ctrlr = get_rpmh_ctrlr(dev);
+	struct batch_cache_req *req, *tmp;
+	unsigned long flags;
+
+	spin_lock_irqsave(&ctrlr->cache_lock, flags);
+	list_for_each_entry_safe(req, tmp, &ctrlr->batch_cache, list)
+		kfree(req);
+	INIT_LIST_HEAD(&ctrlr->batch_cache);
+	ctrlr->dirty = true;
+	spin_unlock_irqrestore(&ctrlr->cache_lock, flags);
+}
+EXPORT_SYMBOL_GPL(rpmh_invalidate);
diff --git a/include/soc/qcom/cmd-db.h b/include/soc/qcom/cmd-db.h
new file mode 100644
index 000000000000..47a6cab75e63
--- /dev/null
+++ b/include/soc/qcom/cmd-db.h
@@ -0,0 +1,48 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2016-2018, The Linux Foundation. All rights reserved.
+ * Copyright (c) 2024, Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+#ifndef __QCOM_COMMAND_DB_H__
+#define __QCOM_COMMAND_DB_H__
+
+#include <linux/err.h>
+
+enum cmd_db_hw_type {
+	CMD_DB_HW_INVALID = 0,
+	CMD_DB_HW_MIN     = 3,
+	CMD_DB_HW_ARC     = CMD_DB_HW_MIN,
+	CMD_DB_HW_VRM     = 4,
+	CMD_DB_HW_BCM     = 5,
+	CMD_DB_HW_MAX     = CMD_DB_HW_BCM,
+	CMD_DB_HW_ALL     = 0xff,
+};
+
+#if IS_ENABLED(CONFIG_QCOM_COMMAND_DB)
+u32 cmd_db_read_addr(const char *resource_id);
+
+const void *cmd_db_read_aux_data(const char *resource_id, size_t *len);
+
+bool cmd_db_match_resource_addr(u32 addr1, u32 addr2);
+
+enum cmd_db_hw_type cmd_db_read_slave_id(const char *resource_id);
+
+int cmd_db_ready(void);
+#else
+static inline u32 cmd_db_read_addr(const char *resource_id)
+{ return 0; }
+
+static inline const void *cmd_db_read_aux_data(const char *resource_id, size_t *len)
+{ return ERR_PTR(-ENODEV); }
+
+static inline bool cmd_db_match_resource_addr(u32 addr1, u32 addr2)
+{ return false; }
+
+static inline enum cmd_db_hw_type cmd_db_read_slave_id(const char *resource_id)
+{ return -ENODEV; }
+
+static inline int cmd_db_ready(void)
+{ return -ENODEV; }
+#endif /* CONFIG_QCOM_COMMAND_DB */
+#endif /* __QCOM_COMMAND_DB_H__ */
diff --git a/include/soc/qcom/rpmh.h b/include/soc/qcom/rpmh.h
new file mode 100644
index 000000000000..bdbee1a97d36
--- /dev/null
+++ b/include/soc/qcom/rpmh.h
@@ -0,0 +1,47 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2016-2018, The Linux Foundation. All rights reserved.
+ */
+
+#ifndef __SOC_QCOM_RPMH_H__
+#define __SOC_QCOM_RPMH_H__
+
+#include <soc/qcom/tcs.h>
+#include <linux/platform_device.h>
+
+
+#if IS_ENABLED(CONFIG_QCOM_RPMH)
+int rpmh_write(const struct device *dev, enum rpmh_state state,
+	       const struct tcs_cmd *cmd, u32 n);
+
+int rpmh_write_async(const struct device *dev, enum rpmh_state state,
+		     const struct tcs_cmd *cmd, u32 n);
+
+int rpmh_write_batch(const struct device *dev, enum rpmh_state state,
+		     const struct tcs_cmd *cmd, u32 *n);
+
+void rpmh_invalidate(const struct device *dev);
+
+#else
+
+static inline int rpmh_write(const struct device *dev, enum rpmh_state state,
+			     const struct tcs_cmd *cmd, u32 n)
+{ return -ENODEV; }
+
+static inline int rpmh_write_async(const struct device *dev,
+				   enum rpmh_state state,
+				   const struct tcs_cmd *cmd, u32 n)
+{ return -ENODEV; }
+
+static inline int rpmh_write_batch(const struct device *dev,
+				   enum rpmh_state state,
+				   const struct tcs_cmd *cmd, u32 *n)
+{ return -ENODEV; }
+
+static inline void rpmh_invalidate(const struct device *dev)
+{
+}
+
+#endif /* CONFIG_QCOM_RPMH */
+
+#endif /* __SOC_QCOM_RPMH_H__ */
diff --git a/include/soc/qcom/tcs.h b/include/soc/qcom/tcs.h
new file mode 100644
index 000000000000..3acca067c72b
--- /dev/null
+++ b/include/soc/qcom/tcs.h
@@ -0,0 +1,81 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2016-2019, The Linux Foundation. All rights reserved.
+ */
+
+#ifndef __SOC_QCOM_TCS_H__
+#define __SOC_QCOM_TCS_H__
+
+#define MAX_RPMH_PAYLOAD	16
+
+/**
+ * rpmh_state: state for the request
+ *
+ * RPMH_SLEEP_STATE:       State of the resource when the processor subsystem
+ *                         is powered down. There is no client using the
+ *                         resource actively.
+ * RPMH_WAKE_ONLY_STATE:   Resume resource state to the value previously
+ *                         requested before the processor was powered down.
+ * RPMH_ACTIVE_ONLY_STATE: Active or AMC mode requests. Resource state
+ *                         is aggregated immediately.
+ */
+enum rpmh_state {
+	RPMH_SLEEP_STATE,
+	RPMH_WAKE_ONLY_STATE,
+	RPMH_ACTIVE_ONLY_STATE,
+};
+
+/**
+ * struct tcs_cmd: an individual request to RPMH.
+ *
+ * @addr: the address of the resource slv_id:18:16 | offset:0:15
+ * @data: the resource state request
+ * @wait: ensure that this command is complete before returning.
+ *        Setting "wait" here only makes sense during rpmh_write_batch() for
+ *        active-only transfers, this is because:
+ *        rpmh_write() - Always waits.
+ *                       (DEFINE_RPMH_MSG_ONSTACK will set .wait_for_compl)
+ *        rpmh_write_async() - Never waits.
+ *                       (There's no request completion callback)
+ */
+struct tcs_cmd {
+	u32 addr;
+	u32 data;
+	u32 wait;
+};
+
+/**
+ * struct tcs_request: A set of tcs_cmds sent together in a TCS
+ *
+ * @state:          state for the request.
+ * @wait_for_compl: wait until we get a response from the h/w accelerator
+ *                  (same as setting cmd->wait for all commands in the request)
+ * @num_cmds:       the number of @cmds in this request
+ * @cmds:           an array of tcs_cmds
+ */
+struct tcs_request {
+	enum rpmh_state state;
+	u32 wait_for_compl;
+	u32 num_cmds;
+	struct tcs_cmd *cmds;
+};
+
+#define BCM_TCS_CMD_COMMIT_SHFT		30
+#define BCM_TCS_CMD_COMMIT_MASK		0x40000000
+#define BCM_TCS_CMD_VALID_SHFT		29
+#define BCM_TCS_CMD_VALID_MASK		0x20000000
+#define BCM_TCS_CMD_VOTE_X_SHFT		14
+#define BCM_TCS_CMD_VOTE_MASK		0x3fff
+#define BCM_TCS_CMD_VOTE_Y_SHFT		0
+#define BCM_TCS_CMD_VOTE_Y_MASK		0xfffc000
+
+/* Construct a Bus Clock Manager (BCM) specific TCS command */
+#define BCM_TCS_CMD(commit, valid, vote_x, vote_y)		\
+	(((commit) << BCM_TCS_CMD_COMMIT_SHFT) |		\
+	((valid) << BCM_TCS_CMD_VALID_SHFT) |			\
+	((cpu_to_le32(vote_x) &					\
+	BCM_TCS_CMD_VOTE_MASK) << BCM_TCS_CMD_VOTE_X_SHFT) |	\
+	((cpu_to_le32(vote_y) &					\
+	BCM_TCS_CMD_VOTE_MASK) << BCM_TCS_CMD_VOTE_Y_SHFT))
+
+#endif /* __SOC_QCOM_TCS_H__ */

-- 
2.45.2

