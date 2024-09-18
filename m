Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B278CCDD541
	for <u-boot@archiver.kernel.org>; Wed, 18 Sep 2024 15:24:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0457088F52;
	Wed, 18 Sep 2024 17:22:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.b="ZBTfOlsV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8F1F688F31; Wed, 18 Sep 2024 17:22:22 +0200 (CEST)
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com
 [IPv6:2a00:1450:4864:20::12b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1E62588F2F
 for <u-boot@lists.denx.de>; Wed, 18 Sep 2024 17:22:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=9elements.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=patrick.rudolph@9elements.com
Received: by mail-lf1-x12b.google.com with SMTP id
 2adb3069b0e04-53654e2ed93so7777017e87.0
 for <u-boot@lists.denx.de>; Wed, 18 Sep 2024 08:22:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=9elements.com; s=google; t=1726672939; x=1727277739; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VHazB46Yk/mxj/H0avqhbt9VJjHzYLaEtoSR9sGB1ac=;
 b=ZBTfOlsVU3jF05vjphoXk5oG+rKurBXO5Cx3GZ0b6cht5wIxT6Rh51J8x+OAhPkn+j
 wqBSrEQWXTWNjxOF2H/DsA/WBJRENJ0//6syd8ClVQKpdLztXTwGS8kS0x4d5kSmJKA0
 dqcTRxxYbbTZByT8JtLrT6BBgUptG0QD/uIThZyBjgKY3/q6tG8yRw5+t+jxXckHpwqL
 PxxSCMDZDBdahShBZMWDfmdxBD7or688Ly6kkIOuWjwK0iZ/o2Mq+hNT6UstNSKuAp6w
 GkZU1ZtAFCZX8ffztT8gfoROArzGevAD4LSUS02QnXPpb8RZmqtp6iZAECfRj70NJKYE
 kOug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726672939; x=1727277739;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VHazB46Yk/mxj/H0avqhbt9VJjHzYLaEtoSR9sGB1ac=;
 b=N4F/1GS69qXiY0cmYEadKz7e1+BAv0+aJ4GYZJf7tN6jc8oGj+WLhkVyZ1QIob/vut
 io92XQB/tfHuDTpAS0jR+SI+qN3CV1gYS1C+HBoYsihytjI6Z7KcvifR2Ich7k6m4FYe
 /g7cZ+cKVSUhng5hg5rhe6UBs0tCkkJYoox7GWLLt0LmoNgX0Xm2KhMRj0lSTblnjkDZ
 i6APKieHvZiGlTlDHgNiHiZ9Rv+Zw21a2bXq+l1mON2KOXJh8sRWQQAeeDblc4gPCepQ
 E1JMElmsz3lOuyhslIyd6Ft8ajsdOcJC3Rg3sGCfFZdH0g9PlsW78vbHTB66/JLQyZov
 8YKA==
X-Gm-Message-State: AOJu0YwQjU1HACdUAMGCy/LC02kpzKSVZRf73ELHf9gKpF6RKmkskzAY
 HauRV9JNlDHK58ZiOcnoXib9NtptvbCJv1w2TrUWKuJSdmSO+pEMRzvmzDn15OHz0TtNEaJLwXW
 O
X-Google-Smtp-Source: AGHT+IHaNHfN7EvVcQjcBn7Cg/POa3WFAmRyeWso1/vpmIYa4ki2cYVvymLR+rQsUoap4r9ZJFi+ZA==
X-Received: by 2002:a05:6512:2348:b0:52f:d69e:bb38 with SMTP id
 2adb3069b0e04-53678fb1f1bmr12951851e87.2.1726672939284; 
 Wed, 18 Sep 2024 08:22:19 -0700 (PDT)
Received: from fedora.sec.9e.network
 (ip-037-049-067-221.um09.pools.vodafone-ip.de. [37.49.67.221])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a90610967b0sm599791266b.42.2024.09.18.08.22.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Sep 2024 08:22:18 -0700 (PDT)
From: Patrick Rudolph <patrick.rudolph@9elements.com>
To: u-boot@lists.denx.de,
	Simon Glass <sjg@chromium.org>
Cc: Patrick Rudolph <patrick.rudolph@9elements.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v4 11/35] acpi: acpi_table: Add IORT support
Date: Wed, 18 Sep 2024 17:20:15 +0200
Message-ID: <20240918152136.3395170-12-patrick.rudolph@9elements.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240918152136.3395170-1-patrick.rudolph@9elements.com>
References: <20240918152136.3395170-1-patrick.rudolph@9elements.com>
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

The SoC can implement acpi_fill_iort to update the IORT table.
Add a helper function to fill out the NAMED_COMPONENT node.

TEST=Run FWTS V24.03.00 on RPi4 and round no problems.

Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
Cc: Simon Glass <sjg@chromium.org>
---
 include/acpi/acpi_table.h | 213 ++++++++++++++++++++++++++++++++++++++
 lib/acpi/acpi_table.c     | 213 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 426 insertions(+)

diff --git a/include/acpi/acpi_table.h b/include/acpi/acpi_table.h
index 7ee3248ff6..5a30465ad2 100644
--- a/include/acpi/acpi_table.h
+++ b/include/acpi/acpi_table.h
@@ -832,6 +832,117 @@ struct acpi_pptt_cache {
 	u16 line_size;
 } __packed;
 
+/** IORT - IO Remapping Table revision 6
+ * Document number: ARM DEN 0049E.e, Sep 2022
+ */
+struct acpi_table_iort {
+	struct acpi_table_header header;
+	u32 node_count;
+	u32 node_offset;
+	u32 reserved;
+} __packed;
+
+/*
+ * IORT subtables
+ */
+struct acpi_iort_node {
+	u8 type;
+	u16 length;
+	u8 revision;
+	u32 identifier;
+	u32 mapping_count;
+	u32 mapping_offset;
+	char node_data[];
+} __packed;
+
+/* Values for subtable Type above */
+enum acpi_iort_node_type {
+	ACPI_IORT_NODE_ITS_GROUP = 0x00,
+	ACPI_IORT_NODE_NAMED_COMPONENT = 0x01,
+	ACPI_IORT_NODE_PCI_ROOT_COMPLEX = 0x02,
+	ACPI_IORT_NODE_SMMU = 0x03,
+	ACPI_IORT_NODE_SMMU_V3 = 0x04,
+	ACPI_IORT_NODE_PMCG = 0x05,
+	ACPI_IORT_NODE_RMR = 0x06,
+};
+
+/* ITS Group revision 1 */
+struct acpi_iort_its_group {
+	u32 its_count;
+	u32 identifiers[];	/* GIC ITS identifier array */
+} __packed;
+
+/* PCI root complex node revision 2 */
+struct acpi_iort_rc {
+	u64 mem_access_properties;
+	u32 ats_attributes;
+	u32 pci_segment_number;
+	u8 memory_address_size_limit;
+	u8 reserved[3];
+} __packed;
+
+/* SMMUv3 revision 5 */
+struct acpi_iort_smmu_v3 {
+	u64 base_address;	/* SMMUv3 base address */
+	u32 flags;
+	u32 reserved;
+	u64 vatos_address;
+	u32 model;
+	u32 event_gsiv;
+	u32 pri_gsiv;
+	u32 gerr_gsiv;
+	u32 sync_gsiv;
+	u32 pxm;
+	u32 id_mapping_index;
+} __packed;
+
+/* Masks for Flags field above */
+#define ACPI_IORT_SMMU_V3_COHACC_OVERRIDE   (1)
+#define ACPI_IORT_SMMU_V3_HTTU_OVERRIDE     (3 << 1)
+#define ACPI_IORT_SMMU_V3_PXM_VALID         (1 << 3)
+#define ACPI_IORT_SMMU_V3_DEVICEID_VALID    (1 << 4)
+
+struct acpi_iort_id_mapping {
+	u32 input_base;		/* Lowest value in input range */
+	u32 id_count;		/* Number of IDs */
+	u32 output_base;	/* Lowest value in output range */
+	u32 output_reference;	/* A reference to the output node */
+	u32 flags;
+} __packed;
+
+/* Masks for Flags field above for IORT subtable */
+#define ACPI_IORT_ID_SINGLE_MAPPING (1)
+
+/* Named Component revision 4 */
+struct acpi_iort_named_component {
+	u32 node_flags;
+	u64 memory_properties;	/* Memory access properties */
+	u8 memory_address_limit;	/* Memory address size limit */
+	char device_name[];	/* Path of namespace object */
+} __packed;
+
+/* Masks for Flags field above */
+#define ACPI_IORT_NC_STALL_SUPPORTED    (1)
+#define ACPI_IORT_NC_PASID_BITS         (31 << 1)
+
+struct acpi_iort_root_complex {
+	u64 memory_properties;	/* Memory access properties */
+	u32 ats_attribute;
+	u32 pci_segment_number;
+	u8 memory_address_limit;/* Memory address size limit */
+	u16 pasid_capabilities;	/* PASID Capabilities */
+	u8 reserved;		/* Reserved, must be zero */
+	u32 flags;		/* Flags */
+} __packed;
+
+/* Masks for ats_attribute field above */
+#define ACPI_IORT_ATS_SUPPORTED         (1)		/* The root complex ATS support */
+#define ACPI_IORT_PRI_SUPPORTED         (1 << 1)	/* The root complex PRI support */
+#define ACPI_IORT_PASID_FWD_SUPPORTED   (1 << 2)	/* The root complex PASID forward support */
+
+/* Masks for pasid_capabilities field above */
+#define ACPI_IORT_PASID_MAX_WIDTH       (0x1F)	/* Bits 0-4 */
+
 /* Tables defined/reserved by ACPI and generated by U-Boot */
 enum acpi_tables {
 	ACPITAB_BERT,
@@ -1000,6 +1111,108 @@ int acpi_fill_csrt(struct acpi_ctx *ctx);
  */
 void acpi_fill_fadt(struct acpi_fadt *fadt);
 
+/**
+ * acpi_fill_iort() - Fill out the body of the IORT table
+ *
+ * Should be implemented in SoC specific code.
+ *
+ * @ctx: ACPI context to write to
+ * @offset: Offset from the start of the IORT
+ */
+int acpi_fill_iort(struct acpi_ctx *ctx);
+
+/**
+ * acpi_iort_add_its_group() - Add ITS group node to IORT table
+ *
+ * Called by SoC specific code within acpi_fill_iort().
+ *
+ * @ctx: ACPI context to write to
+ * @its_count: Elements in identifiers
+ * @identifiers: The array of ITS identifiers. These IDs must match the value
+ *               used in the Multiple APIC Description Table (MADT) GIC ITS
+ *               structure for each relevant ITS unit.
+ * @return Offset of table within parent
+ */
+int acpi_iort_add_its_group(struct acpi_ctx *ctx,
+			    const u32 its_count,
+			    const u32 *identifiers);
+
+/**
+ * acpi_iort_add_named_component() - Add named component to IORT table
+ *
+ * Called by SoC specific code within acpi_fill_iort().
+ *
+ * @ctx: ACPI context to write to
+ * @node_flags: Node flags
+ * @memory_properties: Memory properties
+ * @memory_address_limit: Memory address limit
+ * @device_name: ACPI device path
+ * @return Offset of table within parent
+ */
+int acpi_iort_add_named_component(struct acpi_ctx *ctx,
+				  const u32 node_flags,
+				  const u64 memory_properties,
+				  const u8 memory_address_limit,
+				  const char *device_name);
+
+/**
+ * acpi_iort_add_rc() - Add PCI root complex node to IORT table
+ *
+ * Called by SoC specific code within acpi_fill_iort().
+ *
+ * @ctx: ACPI context to write to
+ * @mem_access_properties: Memory access properties
+ * @ats_attributes: Support for ATS and its ancillary feature
+ * @pci_segment_number: The PCI segment number, as in MCFG
+ * @memory_address_size_limit: The number of address bits, starting from LSB
+ * @num_mappings: Number of elements in map
+ * @map: ID mappings for this node
+ * @return Offset of table within parent
+ */
+int acpi_iort_add_rc(struct acpi_ctx *ctx,
+		     const u64 mem_access_properties,
+		     const u32 ats_attributes,
+		     const u32 pci_segment_number,
+		     const u8 memory_address_size_limit,
+		     const int num_mappings,
+		     const struct acpi_iort_id_mapping *map);
+
+/**
+ * acpi_iort_add_smmu_v3() - Add PCI root complex node to IORT table
+ *
+ * Called by SoC specific code within acpi_fill_iort().
+ *
+ * @ctx: ACPI context to write to
+ * @base_address: Base address of SMMU
+ * @flags: SMMUv3 flags
+ * @vatos_address: Optional, set to zero if not supported
+ * @model: Model ID
+ * @event_gsiv: GSIV of the Event interrupt if SPI based
+ * @pri_gsiv: GSIV of the PRI interrupt if SPI based
+ * @gerr_gsiv: GSIV of the GERR interrupt if GSIV based
+ * @sync_gsiv: TGSIV of the Sync interrupt if GSIV based
+ * @pxm: Proximity Domain
+ * @id_mapping_index: If all the SMMU control interrupts are GSIV based,
+ *                    this field is ignored. Index into the array of ID
+ *                    mapping otherwise.
+ * @num_mappings: Number of elements in map
+ * @map: ID mappings for this node
+ * @return Offset of table within parent
+ */
+int acpi_iort_add_smmu_v3(struct acpi_ctx *ctx,
+			  const u64 base_address,
+			  const u32 flags,
+			  const u64 vatos_address,
+			  const u32 model,
+			  const u32 event_gsiv,
+			  const u32 pri_gsiv,
+			  const u32 gerr_gsiv,
+			  const u32 sync_gsiv,
+			  const u32 pxm,
+			  const u32 id_mapping_index,
+			  const int num_mappings,
+			  const struct acpi_iort_id_mapping *map);
+
 /**
  * acpi_fill_madt() - Fill out the body of the MADT
  *
diff --git a/lib/acpi/acpi_table.c b/lib/acpi/acpi_table.c
index 2dc7b998e2..9d9c8befe8 100644
--- a/lib/acpi/acpi_table.c
+++ b/lib/acpi/acpi_table.c
@@ -520,3 +520,216 @@ static int acpi_write_spcr(struct acpi_ctx *ctx, const struct acpi_writer *entry
 }
 
 ACPI_WRITER(5spcr, "SPCR", acpi_write_spcr, 0);
+
+__weak int acpi_fill_iort(struct acpi_ctx *ctx)
+{
+	return 0;
+}
+
+int acpi_iort_add_its_group(struct acpi_ctx *ctx,
+			    const u32 its_count,
+			    const u32 *identifiers)
+{
+	struct acpi_iort_node *node;
+	struct acpi_iort_its_group *group;
+	int offset;
+
+	offset = ctx->current - ctx->tab_start;
+
+	node = ctx->current;
+	memset(node, '\0', sizeof(struct acpi_iort_node));
+
+	node->type = ACPI_IORT_NODE_ITS_GROUP;
+	node->revision = 1;
+
+	node->length = sizeof(struct acpi_iort_node);
+	node->length += sizeof(struct acpi_iort_its_group);
+	node->length += sizeof(u32) * its_count;
+
+	group = (struct acpi_iort_its_group *)node->node_data;
+	group->its_count = its_count;
+	memcpy(&group->identifiers, identifiers, sizeof(u32) * its_count);
+
+	ctx->current += node->length;
+
+	return offset;
+}
+
+int acpi_iort_add_named_component(struct acpi_ctx *ctx,
+				  const u32 node_flags,
+				  const u64 memory_properties,
+				  const u8 memory_address_limit,
+				  const char *device_name)
+{
+	struct acpi_iort_node *node;
+	struct acpi_iort_named_component *comp;
+	int offset;
+
+	offset = ctx->current - ctx->tab_start;
+
+	node = ctx->current;
+	memset(node, '\0', sizeof(struct acpi_iort_node));
+
+	node->type = ACPI_IORT_NODE_NAMED_COMPONENT;
+	node->revision = 4;
+	node->length = sizeof(struct acpi_iort_node);
+	node->length += sizeof(struct acpi_iort_named_component);
+	node->length += strlen(device_name) + 1;
+
+	comp = (struct acpi_iort_named_component *)node->node_data;
+
+	comp->node_flags = node_flags;
+	comp->memory_properties = memory_properties;
+	comp->memory_address_limit = memory_address_limit;
+	memcpy(comp->device_name, device_name, strlen(device_name) + 1);
+
+	ctx->current += node->length;
+
+	return offset;
+}
+
+int acpi_iort_add_rc(struct acpi_ctx *ctx,
+		     const u64 mem_access_properties,
+		     const u32 ats_attributes,
+		     const u32 pci_segment_number,
+		     const u8 memory_address_size_limit,
+		     const int num_mappings,
+		     const struct acpi_iort_id_mapping *map)
+{
+	struct acpi_iort_id_mapping *mapping;
+	struct acpi_iort_node *node;
+	struct acpi_iort_rc *rc;
+	int offset;
+
+	offset = ctx->current - ctx->tab_start;
+
+	node = ctx->current;
+	memset(node, '\0', sizeof(struct acpi_iort_node));
+
+	node->type = ACPI_IORT_NODE_PCI_ROOT_COMPLEX;
+	node->revision = 2;
+
+	node->length = sizeof(struct acpi_iort_node);
+	node->length += sizeof(struct acpi_iort_rc);
+	node->length += sizeof(struct acpi_iort_id_mapping) * num_mappings;
+
+	rc = (struct acpi_iort_rc *)node->node_data;
+	rc->mem_access_properties = mem_access_properties;
+	rc->ats_attributes = ats_attributes;
+	rc->pci_segment_number = pci_segment_number;
+	rc->memory_address_size_limit = memory_address_size_limit;
+
+	mapping = (struct acpi_iort_id_mapping *)(rc + 1);
+	for (int i = 0; i < num_mappings; i++) {
+		memcpy(mapping, &map[i], sizeof(struct acpi_iort_id_mapping));
+		mapping++;
+	}
+
+	ctx->current += node->length;
+
+	return offset;
+}
+
+int acpi_iort_add_smmu_v3(struct acpi_ctx *ctx,
+			  const u64 base_address,
+			  const u32 flags,
+			  const u64 vatos_address,
+			  const u32 model,
+			  const u32 event_gsiv,
+			  const u32 pri_gsiv,
+			  const u32 gerr_gsiv,
+			  const u32 sync_gsiv,
+			  const u32 pxm,
+			  const u32 id_mapping_index,
+			  const int num_mappings,
+			  const struct acpi_iort_id_mapping *map)
+{
+	struct acpi_iort_node *node;
+	struct acpi_iort_smmu_v3 *smmu;
+	struct acpi_iort_id_mapping *mapping;
+	int offset;
+
+	offset = ctx->current - ctx->tab_start;
+
+	node = ctx->current;
+	memset(node, '\0', sizeof(struct acpi_iort_node));
+
+	node->type = ACPI_IORT_NODE_SMMU_V3;
+	node->revision = 5;
+	node->mapping_count = num_mappings;
+	node->mapping_offset = sizeof(struct acpi_iort_node) + sizeof(struct acpi_iort_smmu_v3);
+
+	node->length = sizeof(struct acpi_iort_node);
+	node->length += sizeof(struct acpi_iort_smmu_v3);
+	node->length += sizeof(struct acpi_iort_id_mapping) * num_mappings;
+
+	smmu = (struct acpi_iort_smmu_v3 *)node->node_data;
+
+	smmu->base_address = base_address;
+	smmu->flags = flags;
+	smmu->vatos_address = vatos_address;
+	smmu->model = model;
+	smmu->event_gsiv = event_gsiv;
+	smmu->pri_gsiv = pri_gsiv;
+	smmu->gerr_gsiv = gerr_gsiv;
+	smmu->sync_gsiv = sync_gsiv;
+	smmu->pxm = pxm;
+	smmu->id_mapping_index = id_mapping_index;
+
+	mapping = (struct acpi_iort_id_mapping *)(smmu + 1);
+	for (int i = 0; i < num_mappings; i++) {
+		memcpy(mapping, &map[i], sizeof(struct acpi_iort_id_mapping));
+		mapping++;
+	}
+
+	ctx->current += node->length;
+
+	return offset;
+}
+
+static int acpi_write_iort(struct acpi_ctx *ctx, const struct acpi_writer *entry)
+{
+	struct acpi_table_iort *iort;
+	struct acpi_iort_node *node;
+	u32 offset;
+	int ret;
+
+	iort = ctx->current;
+	ctx->tab_start = ctx->current;
+	memset(iort, '\0', sizeof(struct acpi_table_iort));
+
+	acpi_fill_header(&iort->header, "IORT");
+	iort->header.revision = 1;
+	iort->header.creator_revision = 1;
+	iort->header.length = sizeof(struct acpi_table_iort);
+	iort->node_offset = sizeof(struct acpi_table_iort);
+
+	acpi_inc(ctx, sizeof(struct acpi_table_iort));
+
+	offset = sizeof(struct acpi_table_iort);
+	ret = acpi_fill_iort(ctx);
+	if (ret) {
+		ctx->current = iort;
+		return log_msg_ret("fill", ret);
+	}
+
+	/* Count nodes filled in */
+	for (node = (void *)iort + iort->node_offset;
+	     node->length > 0 && (void *)node < ctx->current;
+	     node = (void *)node + node->length)
+		iort->node_count++;
+
+	/* (Re)calculate length and checksum */
+	iort->header.length = ctx->current - (void *)iort;
+	iort->header.checksum = table_compute_checksum((void *)iort, iort->header.length);
+	log_debug("IORT at %p, length %x\n", iort, iort->header.length);
+
+	/* Drop the table if it is empty */
+	if (iort->header.length == sizeof(struct acpi_table_iort))
+		return log_msg_ret("fill", -ENOENT);
+	acpi_add_table(ctx, iort);
+
+	return 0;
+}
+
+ACPI_WRITER(5iort, "IORT", acpi_write_iort, 0);
-- 
2.46.0

