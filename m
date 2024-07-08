Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECDE6C3271E
	for <u-boot@archiver.kernel.org>; Mon,  8 Jul 2024 11:33:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A7D2188707;
	Mon,  8 Jul 2024 13:33:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="EycFQzJB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2C67388271; Mon,  8 Jul 2024 13:33:13 +0200 (CEST)
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com
 [IPv6:2a00:1450:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D6506884CC
 for <u-boot@lists.denx.de>; Mon,  8 Jul 2024 13:33:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-a77e5929033so209768466b.0
 for <u-boot@lists.denx.de>; Mon, 08 Jul 2024 04:33:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720438389; x=1721043189; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=1uFfKAf15FxhHpA2O1ii8PCNKbpxpSKEjmqNOdVSSFc=;
 b=EycFQzJBB8SVyIOjr9Or4Ju2zlSocrOUv7fH9M8OXgBxZLZfndKmrjZlHu31nZCVIq
 TJ2GemmKwjJwqdhSVa++IEZgc4ahI1zhtakZaM7KqC2MaPN4s4fmXWzSjQD1hZbi4zef
 +BRfvt+8dhb164t6d6vNscq7gkfE3MZVla8gRIPynbSk9UErFf1h7y/1K6DejeeJMniv
 CPwHaQpKtYXTHcf2xyks+c/nKxxqvRhZnzcBZET5NHaeOkkDfKiERzFFErV2OYOMjE+l
 OXuwvVcWSlDMNsxw6pEloGEduKAAM9s9gATwSkEC6jN8v1oJ+J3cw4IUFKDbFpMqMIE8
 yVWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720438389; x=1721043189;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1uFfKAf15FxhHpA2O1ii8PCNKbpxpSKEjmqNOdVSSFc=;
 b=C50cNh7shyGGxkiHr/rF/hcMzT3sEyemPJttiU4z6cQ6xWWKkAeR6hdkkHw+kLdoKR
 gIxXlrtT6n6q3uOSk4ROgzxXiU70Z5x83CjiirMFS/hiyC+zBpjwSdb7TDpY6HWx2DTf
 LjgOJprM2RXDjzsBhVdlnQOVw5cqug8xy8Zu0mwBPRew4tdlgVxLFw0memCMcegYIRG/
 quKv6hurgXz+FaynfqBx20iM9Q3VWlJ6bqe2eUuShClPwX3BAx9zD+SYYEKkccRZs6Wj
 hkVYVatJZJbtsG4R9uPYCEesJqiHJcv0qlUy3BQlToFyGNzVybw9Z2PXHZLR94awZjoi
 aMOQ==
X-Gm-Message-State: AOJu0YxG2vHBZbrlXbiiw71+/1rZPUbbM0FKQqM5+VZDQjtSNR6TGyWS
 mmJMIdS4GU4bKUqr/LeyiEb6bzw98ccFyioGLG7nf7NFZjYIZ4XhVbcf9cJ5eGYQz5wZu/1Imzu
 81Mw=
X-Google-Smtp-Source: AGHT+IHqFwcBAOl51OQAQbiivJUaXSfaZHADCHOn0c969MlPxu7F4TkawtcmLM6DNNlSkFM5UAW09g==
X-Received: by 2002:a17:906:5acd:b0:a6f:51d8:1963 with SMTP id
 a640c23a62f3a-a77ba70e622mr828786466b.43.1720438388431; 
 Mon, 08 Jul 2024 04:33:08 -0700 (PDT)
Received: from [192.168.0.113] ([2a02:8109:aa0d:be00::18f8])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a77c9925463sm303628466b.69.2024.07.08.04.33.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Jul 2024 04:33:07 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Mon, 08 Jul 2024 13:32:54 +0200
Subject: [PATCH v2 2/4] soc: qcom: rpmh and cmd-db drivers
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240708-b4-qcom-rpmh-v2-2-8bc765606e56@linaro.org>
References: <20240708-b4-qcom-rpmh-v2-0-8bc765606e56@linaro.org>
In-Reply-To: <20240708-b4-qcom-rpmh-v2-0-8bc765606e56@linaro.org>
To: Tom Rini <trini@konsulko.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>, Jaehoon Chung <jh80.chung@samsung.com>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=45038;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=ohkrqlRvwIN9S6KoECFHzQZ8KikyhsB+l7SqUSmolWc=;
 b=owEBbQKS/ZANAwAIAQWDMSsZX2S2AcsmYgBmi85w2CQTxIEzoUbIDfpMmUWyokRlS4nvmqdID
 mlwhZqyOAyJAjMEAAEIAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCZovOcAAKCRAFgzErGV9k
 tro9D/9I7yyitQ2/IU5z6BkWU5JwUYUJ6bwxtsGbFY+NPmiG9WLmxchlAOApV2PL6V3/hYJn6wA
 U5/qM5jQTd6G3ni7UzONes+njgV0Oiu5NEfxFOCnxSzk87SM31QAiHdjxG9f5uJ3bEH627YNMip
 wK6PmTM0nu1iVTx43RRpuYyzEtekPVDlSqsvWCNCceOHyWqhypjUujpZxxZSYvXdBrBRCqa5CmQ
 01EfePOjuo/bTINjb3JpfPEihaOfz1GsRl+GW/noC5n6IfKLiCFxWh7kcO9+bywJDWseSis8hfM
 KqbLxo6BCZPwUw1mTqbrsuMR+Gn6nEe2sln6LXdeF+nOyxVqncwP5z8f5LlGL2lMtQUG5DkU7us
 sbh4aXuU9DILcbaObm0QRA+vM1Ss+4FzcajBiyu8jTAyXSoSmtorr3PkEvh+5lcEqh/ZzP285i/
 992X8reD2BPtkT8DAwqHzvr5NU/7uFJGlxiLuv7yhFkQ2F1eHmdNGosnJ71RWezPyYKREgWf3U8
 Vxa2b61V5Ui0ucUtdsC/3bVbNhlfmvAd4aitxebQwhY5uG2va36+4iajHxsxg0SYdIfYkCV6fSY
 vIuLRpb+CV+V+nxqS+MN11LbmtSlZ5jKXyN4xQPi9gQxQw0b5e3ywJw618iUR1/HWNWafc5ndU4
 +LRMKaBpuTE7SAw==
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

Introduce two Qualcomm SoC drivers, the RPMh and cmd-db. RPMh is a the
name for the second generation Resource Power Management hub on Qualcomm
SoCs. Most core regulators have to be controlled via this hub.

The cmd-db is a region of memory which contains offsets and data about
how to communicate with the RPMh.

Tested-by: Neil Armstrong <neil.armstrong@linaro.org> # on SM8550 & SM8^%)
Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 drivers/soc/Kconfig              |   1 +
 drivers/soc/Makefile             |   1 +
 drivers/soc/qcom/Kconfig         |  25 ++
 drivers/soc/qcom/Makefile        |   4 +
 drivers/soc/qcom/cmd-db.c        | 261 ++++++++++++++++
 drivers/soc/qcom/rpmh-internal.h | 141 +++++++++
 drivers/soc/qcom/rpmh-rsc.c      | 628 +++++++++++++++++++++++++++++++++++++++
 drivers/soc/qcom/rpmh.c          | 112 +++++++
 include/soc/qcom/cmd-db.h        |  42 +++
 include/soc/qcom/rpmh.h          |  29 ++
 include/soc/qcom/tcs.h           |  78 +++++
 11 files changed, 1322 insertions(+)

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
index 5ec89a053165..abcc8a88950f 100644
--- a/drivers/soc/Makefile
+++ b/drivers/soc/Makefile
@@ -4,8 +4,9 @@
 
 obj-$(CONFIG_SOC_AMD_VERSAL2) += soc_amd_versal2.o
 obj-$(CONFIG_SOC_SAMSUNG) += samsung/
 obj-$(CONFIG_SOC_TI) += ti/
+obj-$(CONFIG_SOC_QCOM) += qcom/
 obj-$(CONFIG_SOC_DEVICE) += soc-uclass.o
 obj-$(CONFIG_SOC_DEVICE_TI_K3) += soc_ti_k3.o
 obj-$(CONFIG_SANDBOX) += soc_sandbox.o
 obj-$(CONFIG_SOC_XILINX_ZYNQMP) += soc_xilinx_zynqmp.o
diff --git a/drivers/soc/qcom/Kconfig b/drivers/soc/qcom/Kconfig
new file mode 100644
index 000000000000..a0872c5b3c83
--- /dev/null
+++ b/drivers/soc/qcom/Kconfig
@@ -0,0 +1,25 @@
+# SPDX-License-Identifier: GPL-2.0+
+
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
index 000000000000..4fca569cfb77
--- /dev/null
+++ b/drivers/soc/qcom/Makefile
@@ -0,0 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0+
+
+obj-$(CONFIG_QCOM_COMMAND_DB) += cmd-db.o
+obj-$(CONFIG_QCOM_RPMH)	+= rpmh-rsc.o rpmh.o
diff --git a/drivers/soc/qcom/cmd-db.c b/drivers/soc/qcom/cmd-db.c
new file mode 100644
index 000000000000..62f1479bda09
--- /dev/null
+++ b/drivers/soc/qcom/cmd-db.c
@@ -0,0 +1,261 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2016-2018, 2020, The Linux Foundation. All rights reserved.
+ * Copyright (c) 2023, Linaro Ltd.
+ */
+
+#define pr_fmt(fmt) "cmd-db: " fmt
+
+#include <dm/device.h>
+#include <dm.h>
+#include <dm/device_compat.h>
+#include <linux/kernel.h>
+#include <linux/types.h>
+#include <linux/ioport.h>
+#include <linux/byteorder/generic.h>
+
+#include <soc/qcom/cmd-db.h>
+
+#define NUM_PRIORITY		2
+#define MAX_SLV_ID		8
+#define SLAVE_ID_MASK		0x7
+#define SLAVE_ID_SHIFT		16
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
+static int cmd_db_get_header(const char *id, const struct entry_header **eh,
+			     const struct rsc_hdr **rh)
+{
+	const struct rsc_hdr *rsc_hdr;
+	const struct entry_header *ent;
+	int i, j;
+	u8 query[sizeof(ent->id)] __nonstring;
+
+	/*
+	 * Pad out query string to same length as in DB. NOTE: the output
+	 * query string is not necessarily '\0' terminated if it bumps up
+	 * against the max size. That's OK and expected.
+	 */
+	strncpy(query, id, sizeof(query));
+
+	for (i = 0; i < MAX_SLV_ID; i++) {
+		rsc_hdr = &cmd_db_header->header[i];
+		if (!rsc_hdr->slv_id)
+			break;
+
+		ent = rsc_to_entry_header(rsc_hdr);
+		for (j = 0; j < le16_to_cpu(rsc_hdr->cnt); j++, ent++) {
+			if (strncmp(ent->id, query, sizeof(ent->id)) == 0) {
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
+EXPORT_SYMBOL(cmd_db_read_addr);
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
+EXPORT_SYMBOL(cmd_db_read_aux_data);
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
+EXPORT_SYMBOL(cmd_db_read_slave_id);
+
+int cmd_db_init(void)
+{
+	void __iomem *base;
+	ofnode rmem, node;
+
+	if (cmd_db_header)
+		return 0;
+
+	rmem = ofnode_path("/reserved-memory");
+	ofnode_for_each_subnode(node, rmem) {
+		if (ofnode_device_is_compatible(node, "qcom,cmd-db"))
+			goto found;
+	}
+
+	log_err("%s: Failed to find cmd-db node\n", __func__);
+	return -ENOENT;
+found:
+	debug("%s(%s)\n", __func__, ofnode_get_name(node));
+
+	base = (void __iomem *)ofnode_get_addr(node);
+	if ((fdt_addr_t)base == FDT_ADDR_T_NONE) {
+		log_err("%s: Failed to read base address\n", __func__);
+		return -ENOENT;
+	}
+
+	cmd_db_header = base;
+	if (!cmd_db_magic_matches(cmd_db_header)) {
+		log_err("%s: Invalid Command DB Magic\n", __func__);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL(cmd_db_init);
diff --git a/drivers/soc/qcom/rpmh-internal.h b/drivers/soc/qcom/rpmh-internal.h
new file mode 100644
index 000000000000..9dbb1c51cc35
--- /dev/null
+++ b/drivers/soc/qcom/rpmh-internal.h
@@ -0,0 +1,141 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2016-2018, The Linux Foundation. All rights reserved.
+ */
+
+#ifndef __RPM_INTERNAL_H__
+#define __RPM_INTERNAL_H__
+
+#include <linux/bitmap.h>
+#include <soc/qcom/tcs.h>
+
+#define TCS_TYPE_NR			4
+#define MAX_CMDS_PER_TCS		16
+#define MAX_TCS_PER_TYPE		3
+#define MAX_TCS_NR			(MAX_TCS_PER_TYPE * TCS_TYPE_NR)
+#define MAX_TCS_SLOTS			(MAX_CMDS_PER_TCS * MAX_TCS_PER_TYPE)
+
+#define USEC_PER_SEC           1000000UL
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
+	const struct udevice *dev;
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
+	struct tcs_group tcs[TCS_TYPE_NR];
+	DECLARE_BITMAP(tcs_in_use, MAX_TCS_NR);
+	struct rpmh_ctrlr client;
+	struct udevice *dev;
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
+int rpmh_rsc_wait_for_resp(struct rsc_drv *drv, int tcs_id);
+int rpmh_flush(struct rpmh_ctrlr *ctrlr);
+
+#endif /* __RPM_INTERNAL_H__ */
diff --git a/drivers/soc/qcom/rpmh-rsc.c b/drivers/soc/qcom/rpmh-rsc.c
new file mode 100644
index 000000000000..1f8428c415a1
--- /dev/null
+++ b/drivers/soc/qcom/rpmh-rsc.c
@@ -0,0 +1,628 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2016-2018, 2020, The Linux Foundation. All rights reserved.
+ * Copyright (c) 2023, Linaro Ltd.
+ */
+
+#define pr_fmt(fmt) "rpmh-rsc: " fmt
+
+#include <linux/err.h>
+#include <linux/types.h>
+#include <dm.h>
+#include <dm/ofnode.h>
+#include <dm/devres.h>
+#include <dm/device_compat.h>
+#include <linux/delay.h>
+#include <dm/lists.h>
+#include <errno.h>
+#include <asm/io.h>
+#include <asm/bitops.h>
+#include <linux/bitmap.h>
+#include <log.h>
+
+#include <dt-bindings/soc/qcom,rpmh-rsc.h>
+#include "rpmh-internal.h"
+
+#include <soc/qcom/rpmh.h>
+#include <soc/qcom/cmd-db.h>
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
+static u32 read_tcs_reg(const struct rsc_drv *drv, int reg, int tcs_id)
+{
+	return readl_relaxed(tcs_reg_addr(drv, reg, tcs_id));
+}
+
+static void write_tcs_cmd(const struct rsc_drv *drv, int reg, int tcs_id,
+			  int cmd_id, u32 data)
+{
+	void __iomem *addr = tcs_cmd_addr(drv, reg, tcs_id, cmd_id);
+
+	debug("tcs(m): %d cmd(n): %d addr: %#x data: %#x\n",
+	      tcs_id, cmd_id, reg, data);
+	writel_relaxed(data, addr);
+}
+
+static void write_tcs_reg(const struct rsc_drv *drv, int reg, int tcs_id,
+			  u32 data)
+{
+	void __iomem *addr = tcs_reg_addr(drv, reg, tcs_id);
+
+	debug("tcs(m): %d addr: %#x data: %#x\n",
+	      tcs_id, reg, data);
+	writel_relaxed(data, addr);
+}
+
+static void write_tcs_reg_sync(const struct rsc_drv *drv, int reg, int tcs_id,
+			       u32 data)
+{
+	int i;
+	void __iomem *addr = tcs_reg_addr(drv, reg, tcs_id);
+
+	debug("tcs(m): %d addr: %#x data: %#x\n",
+	      tcs_id, reg, data);
+
+	writel(data, addr);
+
+	/*
+	 * Wait until we read back the same value.  Use a counter rather than
+	 * ktime for timeout since this may be called after timekeeping stops.
+	 */
+	for (i = 0; i < USEC_PER_SEC; i++) {
+		if (readl(addr) == data)
+			return;
+		udelay(1);
+	}
+	log_err("error writing %#x to %d:%#x\n",
+		data, tcs_id, reg);
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
+ * rpmh_rsc_wait_for_resp() - Spin until we get a response from the rpmh
+ * @drv:    The controller.
+ * @tcs_id: The global ID of this TCS.
+ *
+ * This is for ACTIVE_ONLY transfers (which are the only ones we support in
+ * u-boot). As we don't support interrupts, we just spin on the IRQ_STATUS
+ * register until the bit is set to confirm that the TCS TX is done.
+ */
+int rpmh_rsc_wait_for_resp(struct rsc_drv *drv, int tcs_id)
+{
+	u32 reg;
+	int i;
+
+	reg = drv->regs[RSC_DRV_IRQ_STATUS];
+
+	debug("waiting for response to tcs %d\n", tcs_id);
+
+	for (i = 0; i < 5 * USEC_PER_SEC; i++) {
+		if (readl(tcs_reg_addr(drv, reg, tcs_id)) & BIT(tcs_id))
+			break;
+		udelay(1);
+	}
+
+	if (i == 5 * USEC_PER_SEC) {
+		log_err("timeout waiting\n");
+		return -ETIMEDOUT;
+	}
+
+	writel_relaxed(BIT(tcs_id), drv->tcs_base + drv->regs[RSC_DRV_IRQ_CLEAR]);
+
+	return 0;
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
+	/* u-boot: get a response to ensure everything is golden before continuing */
+	cmd_msgid |= CMD_MSGID_RESP_REQ;
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
+		debug("tcs(m): %d [%s] cmd(n): %d msgid: %#x addr: %#x data: %#x complete: %d\n",
+		      tcs_id, msg->state == RPMH_ACTIVE_ONLY_STATE ? "active" : "?", j, msgid,
+		      cmd->addr, cmd->data, cmd->wait);
+	}
+
+	cmd_enable |= read_tcs_reg(drv, drv->regs[RSC_DRV_CMD_ENABLE], tcs_id);
+	write_tcs_reg(drv, drv->regs[RSC_DRV_CMD_ENABLE], tcs_id, cmd_enable);
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
+	if (msg->state != RPMH_ACTIVE_ONLY_STATE) {
+		log_err("WARN: only ACTIVE_ONLY state supported\n");
+		return ERR_PTR(-EINVAL);
+	}
+
+	return &drv->tcs[ACTIVE_TCS];
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
+	unsigned long flags;
+
+	tcs = get_tcs_for_msg(drv, msg);
+	if (IS_ERR(tcs))
+		return PTR_ERR(tcs);
+
+	spin_lock_irqsave(&drv->lock, flags);
+
+	/* u-boot is single-threaded, always use the first TCS as we'll never conflict */
+	tcs_id = tcs->offset;
+
+	tcs->req[tcs_id - tcs->offset] = msg;
+	generic_set_bit(tcs_id, drv->tcs_in_use);
+	if (msg->state == RPMH_ACTIVE_ONLY_STATE && tcs->type != ACTIVE_TCS) {
+		/*
+		 * Clear previously programmed WAKE commands in selected
+		 * repurposed TCS to avoid triggering them. tcs->slots will be
+		 * cleaned from rpmh_flush() by invoking rpmh_rsc_invalidate()
+		 */
+		write_tcs_reg_sync(drv, drv->regs[RSC_DRV_CMD_ENABLE], tcs_id, 0);
+	}
+	spin_unlock_irqrestore(&drv->lock, flags);
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
+	rpmh_rsc_wait_for_resp(drv, tcs_id);
+
+	return 0;
+}
+
+static int rpmh_probe_tcs_config(struct udevice *dev, struct rsc_drv *drv)
+{
+	struct tcs_type_config {
+		u32 type;
+		u32 n;
+	} tcs_cfg[TCS_TYPE_NR] = { { 0 } };
+	ofnode dn = dev_ofnode(dev);
+	u32 config, max_tcs, ncpt, offset;
+	int i, ret, n, st = 0;
+	struct tcs_group *tcs;
+
+	ret = ofnode_read_u32(dn, "qcom,tcs-offset", &offset);
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
+	n = ofnode_read_u32_array(dn, "qcom,tcs-config", (u32 *)tcs_cfg, 2 * TCS_TYPE_NR);
+	if (n < 0) {
+		log_err("RPMh: %s: error reading qcom,tcs-config %d\n", dev->name, n);
+		return n;
+	}
+
+	for (i = 0; i < TCS_TYPE_NR; i++) {
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
+static int rpmh_rsc_bind(struct udevice *dev)
+{
+	int ret;
+
+	ret = cmd_db_init();
+	if (ret)
+		return ret;
+
+	return dm_scan_fdt_dev(dev);
+}
+
+static int rpmh_rsc_probe(struct udevice *dev)
+{
+	ofnode dn = dev_ofnode(dev);
+	struct rsc_drv *drv;
+	char drv_id[10] = {0};
+	int ret;
+	u32 rsc_id;
+
+	drv = dev_get_priv(dev);
+
+	ret = ofnode_read_u32(dn, "qcom,drv-id", &drv->id);
+	if (ret)
+		return ret;
+
+	drv->name = ofnode_get_property(dn, "label", NULL);
+	if (!drv->name)
+		drv->name = dev->name;
+
+	snprintf(drv_id, ARRAY_SIZE(drv_id), "drv-%d", drv->id);
+	drv->base = (void __iomem *)dev_read_addr_name(dev, drv_id);
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
+	ret = rpmh_probe_tcs_config(dev, drv);
+	if (ret)
+		return ret;
+
+	spin_lock_init(&drv->lock);
+	init_waitqueue_head(&drv->tcs_wait);
+	bitmap_zero(drv->tcs_in_use, MAX_TCS_NR);
+
+	/* Enable the active TCS to send requests immediately */
+	writel_relaxed(drv->tcs[ACTIVE_TCS].mask,
+		       drv->tcs_base + drv->regs[RSC_DRV_IRQ_ENABLE]);
+
+	spin_lock_init(&drv->client.cache_lock);
+	INIT_LIST_HEAD(&drv->client.cache);
+	INIT_LIST_HEAD(&drv->client.batch_cache);
+
+	dev_set_drvdata(dev, drv);
+	drv->dev = dev;
+
+	log_debug("RPMh: %s: v%d.%d\n", dev->name, drv->ver.major, drv->ver.minor);
+
+	return ret;
+}
+
+static const struct udevice_id qcom_rpmh_ids[] = {
+	{ .compatible = "qcom,rpmh-rsc" },
+	{ }
+};
+
+U_BOOT_DRIVER(qcom_rpmh_rsc) = {
+	.name		= "qcom_rpmh_rsc",
+	.id		= UCLASS_MISC,
+	.priv_auto	= sizeof(struct rsc_drv),
+	.probe		= rpmh_rsc_probe,
+	.bind		= rpmh_rsc_bind,
+	.of_match	= qcom_rpmh_ids,
+	/* rpmh is under CLUSTER_PD which we don't support */
+	.flags		= DM_FLAG_DEFAULT_PD_CTRL_OFF,
+};
diff --git a/drivers/soc/qcom/rpmh.c b/drivers/soc/qcom/rpmh.c
new file mode 100644
index 000000000000..fc881c21e3e3
--- /dev/null
+++ b/drivers/soc/qcom/rpmh.c
@@ -0,0 +1,112 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2016-2018, The Linux Foundation. All rights reserved.
+ */
+
+#define pr_fmt(fmt) "rpmh: " fmt
+
+#include <linux/bug.h>
+#include <linux/kernel.h>
+#include <linux/list.h>
+#include <linux/types.h>
+#include <dm/device.h>
+
+#include <soc/qcom/rpmh.h>
+
+#include "rpmh-internal.h"
+
+#define RPMH_TIMEOUT_MS			msecs_to_jiffies(10000)
+
+#define DEFINE_RPMH_MSG_ONSTACK(device, s, name)	\
+	struct rpmh_request name = {			\
+		.msg = {				\
+			.state = s,			\
+			.cmds = name.cmd,		\
+			.num_cmds = 0,			\
+		},					\
+		.cmd = { { 0 } },			\
+		.dev = device,				\
+		.needs_free = false,			\
+	}
+
+#define ctrlr_to_drv(ctrlr) container_of(ctrlr, struct rsc_drv, client)
+
+static struct rpmh_ctrlr *get_rpmh_ctrlr(const struct udevice *dev)
+{
+	struct rsc_drv *drv = (struct rsc_drv *)dev_get_priv(dev->parent);
+
+	if (!drv) {
+		log_err("BUG: no RPMh driver for %s (parent %s)\n", dev->name, dev->parent->name);
+		BUG();
+	}
+
+	return &drv->client;
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
+static int __rpmh_write(const struct udevice *dev, enum rpmh_state state,
+			struct rpmh_request *rpm_msg)
+{
+	struct rpmh_ctrlr *ctrlr = get_rpmh_ctrlr(dev);
+
+	debug("rpmh_write: %s, %d\n", dev->name, state);
+
+	if (state != RPMH_ACTIVE_ONLY_STATE) {
+		log_err("WARN: only ACTIVE_ONLY state supported\n");
+		return -EINVAL;
+	}
+
+	return rpmh_rsc_send_data(ctrlr_to_drv(ctrlr), &rpm_msg->msg);
+}
+
+static int __fill_rpmh_msg(struct rpmh_request *req, enum rpmh_state state,
+			   const struct tcs_cmd *cmd, u32 n)
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
+	debug("rpmh_msg: %d, %d cmds [first %#x/%#x]\n", state, n, cmd->addr, cmd->data);
+
+	return 0;
+}
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
+int rpmh_write(const struct udevice *dev, enum rpmh_state state,
+	       const struct tcs_cmd *cmd, u32 n)
+{
+	DEFINE_RPMH_MSG_ONSTACK(dev, state, rpm_msg);
+	int ret;
+
+	ret = __fill_rpmh_msg(&rpm_msg, state, cmd, n);
+	if (ret)
+		return ret;
+
+	ret = __rpmh_write(dev, state, &rpm_msg);
+
+	return ret;
+}
diff --git a/include/soc/qcom/cmd-db.h b/include/soc/qcom/cmd-db.h
new file mode 100644
index 000000000000..d5dfe7917c10
--- /dev/null
+++ b/include/soc/qcom/cmd-db.h
@@ -0,0 +1,42 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (c) 2016-2018, The Linux Foundation. All rights reserved. */
+
+#ifndef __QCOM_COMMAND_DB_H__
+#define __QCOM_COMMAND_DB_H__
+
+#include <linux/err.h>
+#include <dm/device.h>
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
+enum cmd_db_hw_type cmd_db_read_slave_id(const char *resource_id);
+
+int cmd_db_init(void);
+
+#else
+static inline u32 cmd_db_read_addr(const char *resource_id)
+{ return 0; }
+
+static inline const void *cmd_db_read_aux_data(const char *resource_id, size_t *len)
+{ return ERR_PTR(-ENODEV); }
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
index 000000000000..eb7c067cc5fd
--- /dev/null
+++ b/include/soc/qcom/rpmh.h
@@ -0,0 +1,29 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2016-2018, The Linux Foundation. All rights reserved.
+ */
+
+#ifndef __SOC_QCOM_RPMH_H__
+#define __SOC_QCOM_RPMH_H__
+
+#include <linux/types.h>
+#include <linux/errno.h>
+#include <soc/qcom/tcs.h>
+#include <dm/device-internal.h>
+
+#if IS_ENABLED(CONFIG_QCOM_RPMH)
+int rpmh_write(const struct udevice *dev, enum rpmh_state state,
+	       const struct tcs_cmd *cmd, u32 n);
+
+#else
+
+static inline int rpmh_write(const struct udevice *dev, enum rpmh_state state,
+			     const struct tcs_cmd *cmd, u32 n)
+{ return -ENODEV; }
+
+#endif /* CONFIG_QCOM_RPMH */
+
+/* u-boot: no multithreading */
+#define rpmh_write_async(dev, state, cmd, n) rpmh_write(dev, state, cmd, n)
+
+#endif /* __SOC_QCOM_RPMH_H__ */
diff --git a/include/soc/qcom/tcs.h b/include/soc/qcom/tcs.h
new file mode 100644
index 000000000000..c8d28b052f1d
--- /dev/null
+++ b/include/soc/qcom/tcs.h
@@ -0,0 +1,78 @@
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
+ * @num_cmds:       the number of @cmds in this request
+ * @cmds:           an array of tcs_cmds
+ */
+struct tcs_request {
+	enum rpmh_state state;
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

