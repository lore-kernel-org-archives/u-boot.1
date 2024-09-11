Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B1BAEE0211
	for <u-boot@archiver.kernel.org>; Wed, 11 Sep 2024 06:27:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 98A118919A;
	Wed, 11 Sep 2024 08:25:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.b="ZykpQpjS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 46C7B8919A; Wed, 11 Sep 2024 08:25:40 +0200 (CEST)
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com
 [IPv6:2a00:1450:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0950889195
 for <u-boot@lists.denx.de>; Wed, 11 Sep 2024 08:25:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=9elements.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=patrick.rudolph@9elements.com
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-a8a7cdfdd80so554108466b.0
 for <u-boot@lists.denx.de>; Tue, 10 Sep 2024 23:25:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=9elements.com; s=google; t=1726035937; x=1726640737; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PolrBhN3SuZNagATW6/s+6aR5BDECBWXymXuQLxwO8c=;
 b=ZykpQpjSyLA7uln6vntOENs3caDV9R9FiZTictVKpm7tYZLPh2ikgYpXpHPn3GBtTs
 DkoxYO61i6k7fwJ6B1/uM33cHIzWYprfNUTMjCdpYrBvmo6FpDoudqvKAHklHQpqYVqX
 KnwuKv8jjA1gCAq6P+Nz3lvNLJJlpa8dJ75SzLDyfBw2tqCCV68Na7DlC2PcfkD8xpgo
 iXibdcTe9xGrVi2cEvkxkdfOBS8aCv0IdwJGzhrzCfSg+hwFDaidzoLIvoNGPl+cAENz
 seB/wyWDpZMnOMckyiQqvvBzSEJjIQmUr4YnKg+fWMrjegMW47s8RblU9mKU1nByU1hk
 0fjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726035937; x=1726640737;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PolrBhN3SuZNagATW6/s+6aR5BDECBWXymXuQLxwO8c=;
 b=FMww2NFk5bzXP/+DR05cQirI5+NswzWVhIhzZVSj8RpbyXzN/oQbJoegSDK78HuwUK
 Al9USxNrz1ch4WTHqTLmWG9/VpnXxrLOw5/DFpqPU7+XPa2ip/E0GWofVyWlXcYz/t+3
 OwRv3MndCzWKECselN+jxN7ynQ18lRYBRB0ODXu3WT7/iYECREjuUYtZ/2Q61Rq4qL07
 M0CgWGUTG0oz39cCia7iiCKv27bO6AX/YU/mqlfmQNqoa7p7I1VZuZYF/ThUS5EtyRB1
 1DXA7kAqazGlNmTSjsGUyVFyo4XDgfWy6028e04mJbhvaU1wOszWrI7gWlHzIMFq3c4+
 D26w==
X-Gm-Message-State: AOJu0Yy12RTCyuxDep9MmX9u7ZBq6pqU8Ye3CIaYxWhEY+UpUsbOxEKr
 bbEPcUP4SPSGwq9LkmaiupBKIya456gOTyy0tkXaOp7H+DCxAghNZcPgBbiPFWbC4Rrjtn7NYYz
 V
X-Google-Smtp-Source: AGHT+IGLRPFXX3yeLQtk0KF3yUQV6dpVDFvw7AsONjWq6mRmz8434YjaNLwes1IG7y77KDdHa4p6yA==
X-Received: by 2002:a17:907:3e9e:b0:a8a:5ff9:bcd1 with SMTP id
 a640c23a62f3a-a8ffab47b64mr311634866b.21.1726035937347; 
 Tue, 10 Sep 2024 23:25:37 -0700 (PDT)
Received: from fedora.sec.9e.network
 (ip-037-049-067-221.um09.pools.vodafone-ip.de. [37.49.67.221])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a8d25a43365sm575545366b.94.2024.09.10.23.25.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Sep 2024 23:25:36 -0700 (PDT)
From: Patrick Rudolph <patrick.rudolph@9elements.com>
To: u-boot@lists.denx.de,
	Simon Glass <sjg@chromium.org>
Cc: Patrick Rudolph <patrick.rudolph@9elements.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v3 11/30] acpi: acpi_table: Add IORT support
Date: Wed, 11 Sep 2024 08:24:01 +0200
Message-ID: <20240911062511.494855-12-patrick.rudolph@9elements.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240911062511.494855-1-patrick.rudolph@9elements.com>
References: <20240911062511.494855-1-patrick.rudolph@9elements.com>
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
Cc: Simon Glass <sjg@chromium.org>
---
 include/acpi/acpi_table.h | 213 ++++++++++++++++++++++++++++++++++++++
 lib/acpi/acpi_table.c     | 213 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 426 insertions(+)

diff --git a/include/acpi/acpi_table.h b/include/acpi/acpi_table.h
index 19ca6276d0..82128c14d2 100644
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
index bc236e4ca2..4f5cfe522c 100644
--- a/lib/acpi/acpi_table.c
+++ b/lib/acpi/acpi_table.c
@@ -524,3 +524,216 @@ static int acpi_write_spcr(struct acpi_ctx *ctx, const struct acpi_writer *entry
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

