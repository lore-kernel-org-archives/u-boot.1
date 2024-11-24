Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82E3DE668BC
	for <u-boot@archiver.kernel.org>; Sun, 24 Nov 2024 19:18:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A617689915;
	Sun, 24 Nov 2024 20:17:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="MdXqxTDb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6AA5F89578; Sun, 24 Nov 2024 20:17:56 +0100 (CET)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 401A48953A
 for <u-boot@lists.denx.de>; Sun, 24 Nov 2024 20:17:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-a9f1d76dab1so622914766b.0
 for <u-boot@lists.denx.de>; Sun, 24 Nov 2024 11:17:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732475873; x=1733080673; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=cqb6KcLWKmcgMwozq7ibPo753UC3S+1X9c7zVrt5ZOg=;
 b=MdXqxTDbiiBftICEEg+nEirkWyFVkVn3w8ottO2TLvnZEwksk5lO68alHw0q1UQzd0
 9yTG6L//YkA8pRSKUNq00sQ0UFRyE9OQYzMP87r79wuVYOX1lrm5iFtlDXXRUXOXSfqH
 xMuhwY9n/FJ8BA9Zy0sFtTRar1okQBRifdfgY9634x081PMR6j61XrTD3IvK/D9YSA/C
 zi3SuHReHTZZbc2HHl3S/S8FFE8+1f4VIMDkmBdt3FtWP50wxEcg3eTAlKbEj6VB1c2b
 HMl0VRo1Kzx75Xr7So3L44fsL4Gh4q1eSmbQqzHw7GeA8KwBmpr+yOceK2vRQ7VUdVmb
 WcSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732475873; x=1733080673;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cqb6KcLWKmcgMwozq7ibPo753UC3S+1X9c7zVrt5ZOg=;
 b=CRFcqVMxw/UvuyTGRt9jhffsbx4b7THozbZ6i8CP5twvaql9gv0l7pE2whWJYJQcXi
 4cvQ/eBDk4Sva2y8CC1QRwF/+0mWty51l1OokSUDuhGkIy6vZuDVF8ovov73lOwBLWtO
 Url0orZo8Zn/HpzCautgUi8uP6x58eKqh9KFRBGIP3zWC9stKakmHhyKe4CjDS2NA/MX
 dVsZc+nTTwCRGEYLzTkeR3R5sz5vBI15Qf8E1XJCSp9UFnskF73VnKyExXylIiA0q1Vg
 YZ4+gew0pzf6YOLygcjwcFGgo1oF4AyLW7t0aidOa6Qg47/gesa1D9XIEynTx0fh4sZF
 k0YA==
X-Gm-Message-State: AOJu0YyUIsXpCkVNz18RudD5UZyxawuSUw3AL11lclRgylzfh5h5DhDj
 WUWOcHyhmoCW0ht4mQwmRxoZtwIEsBQ5Sz6ILQFUrLStW8MnvP9ou/4OBgvZoic=
X-Gm-Gg: ASbGnctRRmeDlnxOCVC5uBSVeQZVTdZE3gKb576EJ3wUe3v3Pn4xJ0VsVTc/3n1+G1x
 DQsobKxYG2fDiwZEI/Ai3sbRxGUt43NBvhsXrGNysZT9gOWlFiFWKWEvwpLEPH7R6leCr1762Ut
 KekNClOg6TraSL2Vhfr9T2/b7/O74IWtwYxeuL6GU3eAXOE2Y/CSExP6kNbbRWuN9HLyWqYzUO2
 W4Lajxjvv6A1rUA1gptrPcLv9CjycK7baITMCOgj0ahI76nmLbLK3vMQnFC7NR17hcT
X-Google-Smtp-Source: AGHT+IEkRdI4yfqUO2tVDIY2ASl49fhs+OB9GKmT/H2yHkUKNCPoGqaNglpglrKgf7kyCuMOVSntvQ==
X-Received: by 2002:a17:906:1bb1:b0:aa5:1ec3:b96f with SMTP id
 a640c23a62f3a-aa51ec3be89mr765094566b.17.1732475872555; 
 Sun, 24 Nov 2024 11:17:52 -0800 (PST)
Received: from lion.localdomain ([2a02:8109:888d:ff00:ca7f:54ff:fe52:4519])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aa50b28f848sm371874566b.36.2024.11.24.11.17.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 24 Nov 2024 11:17:52 -0800 (PST)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Sun, 24 Nov 2024 20:17:47 +0100
Subject: [PATCH 05/15] soc: qcom: import smem from Linux 6.11-rc2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241124-b4-modernise-smem-v1-5-b7852c11b67c@linaro.org>
References: <20241124-b4-modernise-smem-v1-0-b7852c11b67c@linaro.org>
In-Reply-To: <20241124-b4-modernise-smem-v1-0-b7852c11b67c@linaro.org>
To: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>, 
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>, Mario Six <mario.six@gdsys.cc>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=40564;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=7Q9qDL1Nl3tB3jOmavMu5xzRgm86V1t3I12eMDq/y8U=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhnTn6hsF6S8eMq3h2OPtvLC5r8jrVHrZg/fLj2or3drUf
 qLp0uH/HaUsDIIcDLJiiiziJ5ZZNq29bK+xfcEFmDmsTCBDGLg4BWAizvKMDI0PjYL3pNubLtFJ
 mbvwTZ1cGN+ii2f11C/5p7zkWnEv9RQjQ98ib6Z8zt0dz9deZHhvz/rj1+/D/VdWbktdpf6jpC3
 83zsA
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

Import the SMEM driver from Linux.

Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 drivers/soc/qcom/smem.c    | 1279 ++++++++++++++++++++++++++++++++++++++++++++
 include/soc/qcom/smem.h    |   20 +
 include/soc/qcom/socinfo.h |  111 ++++
 3 files changed, 1410 insertions(+)

diff --git a/drivers/soc/qcom/smem.c b/drivers/soc/qcom/smem.c
new file mode 100644
index 000000000000..8515b8ae7777
--- /dev/null
+++ b/drivers/soc/qcom/smem.c
@@ -0,0 +1,1279 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2015, Sony Mobile Communications AB.
+ * Copyright (c) 2012-2013, The Linux Foundation. All rights reserved.
+ */
+
+#include <linux/hwspinlock.h>
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/of_reserved_mem.h>
+#include <linux/platform_device.h>
+#include <linux/sizes.h>
+#include <linux/slab.h>
+#include <linux/soc/qcom/smem.h>
+#include <linux/soc/qcom/socinfo.h>
+
+/*
+ * The Qualcomm shared memory system is a allocate only heap structure that
+ * consists of one of more memory areas that can be accessed by the processors
+ * in the SoC.
+ *
+ * All systems contains a global heap, accessible by all processors in the SoC,
+ * with a table of contents data structure (@smem_header) at the beginning of
+ * the main shared memory block.
+ *
+ * The global header contains meta data for allocations as well as a fixed list
+ * of 512 entries (@smem_global_entry) that can be initialized to reference
+ * parts of the shared memory space.
+ *
+ *
+ * In addition to this global heap a set of "private" heaps can be set up at
+ * boot time with access restrictions so that only certain processor pairs can
+ * access the data.
+ *
+ * These partitions are referenced from an optional partition table
+ * (@smem_ptable), that is found 4kB from the end of the main smem region. The
+ * partition table entries (@smem_ptable_entry) lists the involved processors
+ * (or hosts) and their location in the main shared memory region.
+ *
+ * Each partition starts with a header (@smem_partition_header) that identifies
+ * the partition and holds properties for the two internal memory regions. The
+ * two regions are cached and non-cached memory respectively. Each region
+ * contain a link list of allocation headers (@smem_private_entry) followed by
+ * their data.
+ *
+ * Items in the non-cached region are allocated from the start of the partition
+ * while items in the cached region are allocated from the end. The free area
+ * is hence the region between the cached and non-cached offsets. The header of
+ * cached items comes after the data.
+ *
+ * Version 12 (SMEM_GLOBAL_PART_VERSION) changes the item alloc/get procedure
+ * for the global heap. A new global partition is created from the global heap
+ * region with partition type (SMEM_GLOBAL_HOST) and the max smem item count is
+ * set by the bootloader.
+ *
+ * To synchronize allocations in the shared memory heaps a remote spinlock must
+ * be held - currently lock number 3 of the sfpb or tcsr is used for this on all
+ * platforms.
+ *
+ */
+
+/*
+ * The version member of the smem header contains an array of versions for the
+ * various software components in the SoC. We verify that the boot loader
+ * version is a valid version as a sanity check.
+ */
+#define SMEM_MASTER_SBL_VERSION_INDEX	7
+#define SMEM_GLOBAL_HEAP_VERSION	11
+#define SMEM_GLOBAL_PART_VERSION	12
+
+/*
+ * The first 8 items are only to be allocated by the boot loader while
+ * initializing the heap.
+ */
+#define SMEM_ITEM_LAST_FIXED	8
+
+/* Highest accepted item number, for both global and private heaps */
+#define SMEM_ITEM_COUNT		512
+
+/* Processor/host identifier for the application processor */
+#define SMEM_HOST_APPS		0
+
+/* Processor/host identifier for the global partition */
+#define SMEM_GLOBAL_HOST	0xfffe
+
+/* Max number of processors/hosts in a system */
+#define SMEM_HOST_COUNT		20
+
+/**
+  * struct smem_proc_comm - proc_comm communication struct (legacy)
+  * @command:	current command to be executed
+  * @status:	status of the currently requested command
+  * @params:	parameters to the command
+  */
+struct smem_proc_comm {
+	__le32 command;
+	__le32 status;
+	__le32 params[2];
+};
+
+/**
+ * struct smem_global_entry - entry to reference smem items on the heap
+ * @allocated:	boolean to indicate if this entry is used
+ * @offset:	offset to the allocated space
+ * @size:	size of the allocated space, 8 byte aligned
+ * @aux_base:	base address for the memory region used by this unit, or 0 for
+ *		the default region. bits 0,1 are reserved
+ */
+struct smem_global_entry {
+	__le32 allocated;
+	__le32 offset;
+	__le32 size;
+	__le32 aux_base; /* bits 1:0 reserved */
+};
+#define AUX_BASE_MASK		0xfffffffc
+
+/**
+ * struct smem_header - header found in beginning of primary smem region
+ * @proc_comm:		proc_comm communication interface (legacy)
+ * @version:		array of versions for the various subsystems
+ * @initialized:	boolean to indicate that smem is initialized
+ * @free_offset:	index of the first unallocated byte in smem
+ * @available:		number of bytes available for allocation
+ * @reserved:		reserved field, must be 0
+ * @toc:		array of references to items
+ */
+struct smem_header {
+	struct smem_proc_comm proc_comm[4];
+	__le32 version[32];
+	__le32 initialized;
+	__le32 free_offset;
+	__le32 available;
+	__le32 reserved;
+	struct smem_global_entry toc[SMEM_ITEM_COUNT];
+};
+
+/**
+ * struct smem_ptable_entry - one entry in the @smem_ptable list
+ * @offset:	offset, within the main shared memory region, of the partition
+ * @size:	size of the partition
+ * @flags:	flags for the partition (currently unused)
+ * @host0:	first processor/host with access to this partition
+ * @host1:	second processor/host with access to this partition
+ * @cacheline:	alignment for "cached" entries
+ * @reserved:	reserved entries for later use
+ */
+struct smem_ptable_entry {
+	__le32 offset;
+	__le32 size;
+	__le32 flags;
+	__le16 host0;
+	__le16 host1;
+	__le32 cacheline;
+	__le32 reserved[7];
+};
+
+/**
+ * struct smem_ptable - partition table for the private partitions
+ * @magic:	magic number, must be SMEM_PTABLE_MAGIC
+ * @version:	version of the partition table
+ * @num_entries: number of partitions in the table
+ * @reserved:	for now reserved entries
+ * @entry:	list of @smem_ptable_entry for the @num_entries partitions
+ */
+struct smem_ptable {
+	u8 magic[4];
+	__le32 version;
+	__le32 num_entries;
+	__le32 reserved[5];
+	struct smem_ptable_entry entry[];
+};
+
+static const u8 SMEM_PTABLE_MAGIC[] = { 0x24, 0x54, 0x4f, 0x43 }; /* "$TOC" */
+
+/**
+ * struct smem_partition_header - header of the partitions
+ * @magic:	magic number, must be SMEM_PART_MAGIC
+ * @host0:	first processor/host with access to this partition
+ * @host1:	second processor/host with access to this partition
+ * @size:	size of the partition
+ * @offset_free_uncached: offset to the first free byte of uncached memory in
+ *		this partition
+ * @offset_free_cached: offset to the first free byte of cached memory in this
+ *		partition
+ * @reserved:	for now reserved entries
+ */
+struct smem_partition_header {
+	u8 magic[4];
+	__le16 host0;
+	__le16 host1;
+	__le32 size;
+	__le32 offset_free_uncached;
+	__le32 offset_free_cached;
+	__le32 reserved[3];
+};
+
+/**
+ * struct smem_partition - describes smem partition
+ * @virt_base:	starting virtual address of partition
+ * @phys_base:	starting physical address of partition
+ * @cacheline:	alignment for "cached" entries
+ * @size:	size of partition
+ */
+struct smem_partition {
+	void __iomem *virt_base;
+	phys_addr_t phys_base;
+	size_t cacheline;
+	size_t size;
+};
+
+static const u8 SMEM_PART_MAGIC[] = { 0x24, 0x50, 0x52, 0x54 };
+
+/**
+ * struct smem_private_entry - header of each item in the private partition
+ * @canary:	magic number, must be SMEM_PRIVATE_CANARY
+ * @item:	identifying number of the smem item
+ * @size:	size of the data, including padding bytes
+ * @padding_data: number of bytes of padding of data
+ * @padding_hdr: number of bytes of padding between the header and the data
+ * @reserved:	for now reserved entry
+ */
+struct smem_private_entry {
+	u16 canary; /* bytes are the same so no swapping needed */
+	__le16 item;
+	__le32 size; /* includes padding bytes */
+	__le16 padding_data;
+	__le16 padding_hdr;
+	__le32 reserved;
+};
+#define SMEM_PRIVATE_CANARY	0xa5a5
+
+/**
+ * struct smem_info - smem region info located after the table of contents
+ * @magic:	magic number, must be SMEM_INFO_MAGIC
+ * @size:	size of the smem region
+ * @base_addr:	base address of the smem region
+ * @reserved:	for now reserved entry
+ * @num_items:	highest accepted item number
+ */
+struct smem_info {
+	u8 magic[4];
+	__le32 size;
+	__le32 base_addr;
+	__le32 reserved;
+	__le16 num_items;
+};
+
+static const u8 SMEM_INFO_MAGIC[] = { 0x53, 0x49, 0x49, 0x49 }; /* SIII */
+
+/**
+ * struct smem_region - representation of a chunk of memory used for smem
+ * @aux_base:	identifier of aux_mem base
+ * @virt_base:	virtual base address of memory with this aux_mem identifier
+ * @size:	size of the memory region
+ */
+struct smem_region {
+	phys_addr_t aux_base;
+	void __iomem *virt_base;
+	size_t size;
+};
+
+/**
+ * struct qcom_smem - device data for the smem device
+ * @dev:	device pointer
+ * @hwlock:	reference to a hwspinlock
+ * @ptable: virtual base of partition table
+ * @global_partition: describes for global partition when in use
+ * @partitions: list of partitions of current processor/host
+ * @item_count: max accepted item number
+ * @socinfo:	platform device pointer
+ * @num_regions: number of @regions
+ * @regions:	list of the memory regions defining the shared memory
+ */
+struct qcom_smem {
+	struct device *dev;
+
+	struct hwspinlock *hwlock;
+
+	u32 item_count;
+	struct platform_device *socinfo;
+	struct smem_ptable *ptable;
+	struct smem_partition global_partition;
+	struct smem_partition partitions[SMEM_HOST_COUNT];
+
+	unsigned num_regions;
+	struct smem_region regions[] __counted_by(num_regions);
+};
+
+static void *
+phdr_to_last_uncached_entry(struct smem_partition_header *phdr)
+{
+	void *p = phdr;
+
+	return p + le32_to_cpu(phdr->offset_free_uncached);
+}
+
+static struct smem_private_entry *
+phdr_to_first_cached_entry(struct smem_partition_header *phdr,
+					size_t cacheline)
+{
+	void *p = phdr;
+	struct smem_private_entry *e;
+
+	return p + le32_to_cpu(phdr->size) - ALIGN(sizeof(*e), cacheline);
+}
+
+static void *
+phdr_to_last_cached_entry(struct smem_partition_header *phdr)
+{
+	void *p = phdr;
+
+	return p + le32_to_cpu(phdr->offset_free_cached);
+}
+
+static struct smem_private_entry *
+phdr_to_first_uncached_entry(struct smem_partition_header *phdr)
+{
+	void *p = phdr;
+
+	return p + sizeof(*phdr);
+}
+
+static struct smem_private_entry *
+uncached_entry_next(struct smem_private_entry *e)
+{
+	void *p = e;
+
+	return p + sizeof(*e) + le16_to_cpu(e->padding_hdr) +
+	       le32_to_cpu(e->size);
+}
+
+static struct smem_private_entry *
+cached_entry_next(struct smem_private_entry *e, size_t cacheline)
+{
+	void *p = e;
+
+	return p - le32_to_cpu(e->size) - ALIGN(sizeof(*e), cacheline);
+}
+
+static void *uncached_entry_to_item(struct smem_private_entry *e)
+{
+	void *p = e;
+
+	return p + sizeof(*e) + le16_to_cpu(e->padding_hdr);
+}
+
+static void *cached_entry_to_item(struct smem_private_entry *e)
+{
+	void *p = e;
+
+	return p - le32_to_cpu(e->size);
+}
+
+/* Pointer to the one and only smem handle */
+static struct qcom_smem *__smem;
+
+/* Timeout (ms) for the trylock of remote spinlocks */
+#define HWSPINLOCK_TIMEOUT	1000
+
+/* The qcom hwspinlock id is always plus one from the smem host id */
+#define SMEM_HOST_ID_TO_HWSPINLOCK_ID(__x) ((__x) + 1)
+
+/**
+ * qcom_smem_bust_hwspin_lock_by_host() - bust the smem hwspinlock for a host
+ * @host:	remote processor id
+ *
+ * Busts the hwspin_lock for the given smem host id. This helper is intended
+ * for remoteproc drivers that manage remoteprocs with an equivalent smem
+ * driver instance in the remote firmware. Drivers can force a release of the
+ * smem hwspin_lock if the rproc unexpectedly goes into a bad state.
+ *
+ * Context: Process context.
+ *
+ * Returns: 0 on success, otherwise negative errno.
+ */
+int qcom_smem_bust_hwspin_lock_by_host(unsigned int host)
+{
+	/* This function is for remote procs, so ignore SMEM_HOST_APPS */
+	if (host == SMEM_HOST_APPS || host >= SMEM_HOST_COUNT)
+		return -EINVAL;
+
+	return hwspin_lock_bust(__smem->hwlock, SMEM_HOST_ID_TO_HWSPINLOCK_ID(host));
+}
+EXPORT_SYMBOL_GPL(qcom_smem_bust_hwspin_lock_by_host);
+
+/**
+ * qcom_smem_is_available() - Check if SMEM is available
+ *
+ * Return: true if SMEM is available, false otherwise.
+ */
+bool qcom_smem_is_available(void)
+{
+	return !!__smem;
+}
+EXPORT_SYMBOL_GPL(qcom_smem_is_available);
+
+static int qcom_smem_alloc_private(struct qcom_smem *smem,
+				   struct smem_partition *part,
+				   unsigned item,
+				   size_t size)
+{
+	struct smem_private_entry *hdr, *end;
+	struct smem_partition_header *phdr;
+	size_t alloc_size;
+	void *cached;
+	void *p_end;
+
+	phdr = (struct smem_partition_header __force *)part->virt_base;
+	p_end = (void *)phdr + part->size;
+
+	hdr = phdr_to_first_uncached_entry(phdr);
+	end = phdr_to_last_uncached_entry(phdr);
+	cached = phdr_to_last_cached_entry(phdr);
+
+	if (WARN_ON((void *)end > p_end || cached > p_end))
+		return -EINVAL;
+
+	while (hdr < end) {
+		if (hdr->canary != SMEM_PRIVATE_CANARY)
+			goto bad_canary;
+		if (le16_to_cpu(hdr->item) == item)
+			return -EEXIST;
+
+		hdr = uncached_entry_next(hdr);
+	}
+
+	if (WARN_ON((void *)hdr > p_end))
+		return -EINVAL;
+
+	/* Check that we don't grow into the cached region */
+	alloc_size = sizeof(*hdr) + ALIGN(size, 8);
+	if ((void *)hdr + alloc_size > cached) {
+		dev_err(smem->dev, "Out of memory\n");
+		return -ENOSPC;
+	}
+
+	hdr->canary = SMEM_PRIVATE_CANARY;
+	hdr->item = cpu_to_le16(item);
+	hdr->size = cpu_to_le32(ALIGN(size, 8));
+	hdr->padding_data = cpu_to_le16(le32_to_cpu(hdr->size) - size);
+	hdr->padding_hdr = 0;
+
+	/*
+	 * Ensure the header is written before we advance the free offset, so
+	 * that remote processors that does not take the remote spinlock still
+	 * gets a consistent view of the linked list.
+	 */
+	wmb();
+	le32_add_cpu(&phdr->offset_free_uncached, alloc_size);
+
+	return 0;
+bad_canary:
+	dev_err(smem->dev, "Found invalid canary in hosts %hu:%hu partition\n",
+		le16_to_cpu(phdr->host0), le16_to_cpu(phdr->host1));
+
+	return -EINVAL;
+}
+
+static int qcom_smem_alloc_global(struct qcom_smem *smem,
+				  unsigned item,
+				  size_t size)
+{
+	struct smem_global_entry *entry;
+	struct smem_header *header;
+
+	header = smem->regions[0].virt_base;
+	entry = &header->toc[item];
+	if (entry->allocated)
+		return -EEXIST;
+
+	size = ALIGN(size, 8);
+	if (WARN_ON(size > le32_to_cpu(header->available)))
+		return -ENOMEM;
+
+	entry->offset = header->free_offset;
+	entry->size = cpu_to_le32(size);
+
+	/*
+	 * Ensure the header is consistent before we mark the item allocated,
+	 * so that remote processors will get a consistent view of the item
+	 * even though they do not take the spinlock on read.
+	 */
+	wmb();
+	entry->allocated = cpu_to_le32(1);
+
+	le32_add_cpu(&header->free_offset, size);
+	le32_add_cpu(&header->available, -size);
+
+	return 0;
+}
+
+/**
+ * qcom_smem_alloc() - allocate space for a smem item
+ * @host:	remote processor id, or -1
+ * @item:	smem item handle
+ * @size:	number of bytes to be allocated
+ *
+ * Allocate space for a given smem item of size @size, given that the item is
+ * not yet allocated.
+ */
+int qcom_smem_alloc(unsigned host, unsigned item, size_t size)
+{
+	struct smem_partition *part;
+	unsigned long flags;
+	int ret;
+
+	if (!__smem)
+		return -EPROBE_DEFER;
+
+	if (item < SMEM_ITEM_LAST_FIXED) {
+		dev_err(__smem->dev,
+			"Rejecting allocation of static entry %d\n", item);
+		return -EINVAL;
+	}
+
+	if (WARN_ON(item >= __smem->item_count))
+		return -EINVAL;
+
+	ret = hwspin_lock_timeout_irqsave(__smem->hwlock,
+					  HWSPINLOCK_TIMEOUT,
+					  &flags);
+	if (ret)
+		return ret;
+
+	if (host < SMEM_HOST_COUNT && __smem->partitions[host].virt_base) {
+		part = &__smem->partitions[host];
+		ret = qcom_smem_alloc_private(__smem, part, item, size);
+	} else if (__smem->global_partition.virt_base) {
+		part = &__smem->global_partition;
+		ret = qcom_smem_alloc_private(__smem, part, item, size);
+	} else {
+		ret = qcom_smem_alloc_global(__smem, item, size);
+	}
+
+	hwspin_unlock_irqrestore(__smem->hwlock, &flags);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(qcom_smem_alloc);
+
+static void *qcom_smem_get_global(struct qcom_smem *smem,
+				  unsigned item,
+				  size_t *size)
+{
+	struct smem_header *header;
+	struct smem_region *region;
+	struct smem_global_entry *entry;
+	u64 entry_offset;
+	u32 e_size;
+	u32 aux_base;
+	unsigned i;
+
+	header = smem->regions[0].virt_base;
+	entry = &header->toc[item];
+	if (!entry->allocated)
+		return ERR_PTR(-ENXIO);
+
+	aux_base = le32_to_cpu(entry->aux_base) & AUX_BASE_MASK;
+
+	for (i = 0; i < smem->num_regions; i++) {
+		region = &smem->regions[i];
+
+		if ((u32)region->aux_base == aux_base || !aux_base) {
+			e_size = le32_to_cpu(entry->size);
+			entry_offset = le32_to_cpu(entry->offset);
+
+			if (WARN_ON(e_size + entry_offset > region->size))
+				return ERR_PTR(-EINVAL);
+
+			if (size != NULL)
+				*size = e_size;
+
+			return region->virt_base + entry_offset;
+		}
+	}
+
+	return ERR_PTR(-ENOENT);
+}
+
+static void *qcom_smem_get_private(struct qcom_smem *smem,
+				   struct smem_partition *part,
+				   unsigned item,
+				   size_t *size)
+{
+	struct smem_private_entry *e, *end;
+	struct smem_partition_header *phdr;
+	void *item_ptr, *p_end;
+	u32 padding_data;
+	u32 e_size;
+
+	phdr = (struct smem_partition_header __force *)part->virt_base;
+	p_end = (void *)phdr + part->size;
+
+	e = phdr_to_first_uncached_entry(phdr);
+	end = phdr_to_last_uncached_entry(phdr);
+
+	while (e < end) {
+		if (e->canary != SMEM_PRIVATE_CANARY)
+			goto invalid_canary;
+
+		if (le16_to_cpu(e->item) == item) {
+			if (size != NULL) {
+				e_size = le32_to_cpu(e->size);
+				padding_data = le16_to_cpu(e->padding_data);
+
+				if (WARN_ON(e_size > part->size || padding_data > e_size))
+					return ERR_PTR(-EINVAL);
+
+				*size = e_size - padding_data;
+			}
+
+			item_ptr = uncached_entry_to_item(e);
+			if (WARN_ON(item_ptr > p_end))
+				return ERR_PTR(-EINVAL);
+
+			return item_ptr;
+		}
+
+		e = uncached_entry_next(e);
+	}
+
+	if (WARN_ON((void *)e > p_end))
+		return ERR_PTR(-EINVAL);
+
+	/* Item was not found in the uncached list, search the cached list */
+
+	e = phdr_to_first_cached_entry(phdr, part->cacheline);
+	end = phdr_to_last_cached_entry(phdr);
+
+	if (WARN_ON((void *)e < (void *)phdr || (void *)end > p_end))
+		return ERR_PTR(-EINVAL);
+
+	while (e > end) {
+		if (e->canary != SMEM_PRIVATE_CANARY)
+			goto invalid_canary;
+
+		if (le16_to_cpu(e->item) == item) {
+			if (size != NULL) {
+				e_size = le32_to_cpu(e->size);
+				padding_data = le16_to_cpu(e->padding_data);
+
+				if (WARN_ON(e_size > part->size || padding_data > e_size))
+					return ERR_PTR(-EINVAL);
+
+				*size = e_size - padding_data;
+			}
+
+			item_ptr = cached_entry_to_item(e);
+			if (WARN_ON(item_ptr < (void *)phdr))
+				return ERR_PTR(-EINVAL);
+
+			return item_ptr;
+		}
+
+		e = cached_entry_next(e, part->cacheline);
+	}
+
+	if (WARN_ON((void *)e < (void *)phdr))
+		return ERR_PTR(-EINVAL);
+
+	return ERR_PTR(-ENOENT);
+
+invalid_canary:
+	dev_err(smem->dev, "Found invalid canary in hosts %hu:%hu partition\n",
+			le16_to_cpu(phdr->host0), le16_to_cpu(phdr->host1));
+
+	return ERR_PTR(-EINVAL);
+}
+
+/**
+ * qcom_smem_get() - resolve ptr of size of a smem item
+ * @host:	the remote processor, or -1
+ * @item:	smem item handle
+ * @size:	pointer to be filled out with size of the item
+ *
+ * Looks up smem item and returns pointer to it. Size of smem
+ * item is returned in @size.
+ */
+void *qcom_smem_get(unsigned host, unsigned item, size_t *size)
+{
+	struct smem_partition *part;
+	void *ptr = ERR_PTR(-EPROBE_DEFER);
+
+	if (!__smem)
+		return ptr;
+
+	if (WARN_ON(item >= __smem->item_count))
+		return ERR_PTR(-EINVAL);
+
+	if (host < SMEM_HOST_COUNT && __smem->partitions[host].virt_base) {
+		part = &__smem->partitions[host];
+		ptr = qcom_smem_get_private(__smem, part, item, size);
+	} else if (__smem->global_partition.virt_base) {
+		part = &__smem->global_partition;
+		ptr = qcom_smem_get_private(__smem, part, item, size);
+	} else {
+		ptr = qcom_smem_get_global(__smem, item, size);
+	}
+
+	return ptr;
+}
+EXPORT_SYMBOL_GPL(qcom_smem_get);
+
+/**
+ * qcom_smem_get_free_space() - retrieve amount of free space in a partition
+ * @host:	the remote processor identifying a partition, or -1
+ *
+ * To be used by smem clients as a quick way to determine if any new
+ * allocations has been made.
+ */
+int qcom_smem_get_free_space(unsigned host)
+{
+	struct smem_partition *part;
+	struct smem_partition_header *phdr;
+	struct smem_header *header;
+	unsigned ret;
+
+	if (!__smem)
+		return -EPROBE_DEFER;
+
+	if (host < SMEM_HOST_COUNT && __smem->partitions[host].virt_base) {
+		part = &__smem->partitions[host];
+		phdr = part->virt_base;
+		ret = le32_to_cpu(phdr->offset_free_cached) -
+		      le32_to_cpu(phdr->offset_free_uncached);
+
+		if (ret > le32_to_cpu(part->size))
+			return -EINVAL;
+	} else if (__smem->global_partition.virt_base) {
+		part = &__smem->global_partition;
+		phdr = part->virt_base;
+		ret = le32_to_cpu(phdr->offset_free_cached) -
+		      le32_to_cpu(phdr->offset_free_uncached);
+
+		if (ret > le32_to_cpu(part->size))
+			return -EINVAL;
+	} else {
+		header = __smem->regions[0].virt_base;
+		ret = le32_to_cpu(header->available);
+
+		if (ret > __smem->regions[0].size)
+			return -EINVAL;
+	}
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(qcom_smem_get_free_space);
+
+static bool addr_in_range(void __iomem *base, size_t size, void *addr)
+{
+	return base && ((void __iomem *)addr >= base && (void __iomem *)addr < base + size);
+}
+
+/**
+ * qcom_smem_virt_to_phys() - return the physical address associated
+ * with an smem item pointer (previously returned by qcom_smem_get()
+ * @p:	the virtual address to convert
+ *
+ * Returns 0 if the pointer provided is not within any smem region.
+ */
+phys_addr_t qcom_smem_virt_to_phys(void *p)
+{
+	struct smem_partition *part;
+	struct smem_region *area;
+	u64 offset;
+	u32 i;
+
+	for (i = 0; i < SMEM_HOST_COUNT; i++) {
+		part = &__smem->partitions[i];
+
+		if (addr_in_range(part->virt_base, part->size, p)) {
+			offset = p - part->virt_base;
+
+			return (phys_addr_t)part->phys_base + offset;
+		}
+	}
+
+	part = &__smem->global_partition;
+
+	if (addr_in_range(part->virt_base, part->size, p)) {
+		offset = p - part->virt_base;
+
+		return (phys_addr_t)part->phys_base + offset;
+	}
+
+	for (i = 0; i < __smem->num_regions; i++) {
+		area = &__smem->regions[i];
+
+		if (addr_in_range(area->virt_base, area->size, p)) {
+			offset = p - area->virt_base;
+
+			return (phys_addr_t)area->aux_base + offset;
+		}
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(qcom_smem_virt_to_phys);
+
+/**
+ * qcom_smem_get_soc_id() - return the SoC ID
+ * @id:	On success, we return the SoC ID here.
+ *
+ * Look up SoC ID from HW/SW build ID and return it.
+ *
+ * Return: 0 on success, negative errno on failure.
+ */
+int qcom_smem_get_soc_id(u32 *id)
+{
+	struct socinfo *info;
+
+	info = qcom_smem_get(QCOM_SMEM_HOST_ANY, SMEM_HW_SW_BUILD_ID, NULL);
+	if (IS_ERR(info))
+		return PTR_ERR(info);
+
+	*id = __le32_to_cpu(info->id);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(qcom_smem_get_soc_id);
+
+/**
+ * qcom_smem_get_feature_code() - return the feature code
+ * @code: On success, return the feature code here.
+ *
+ * Look up the feature code identifier from SMEM and return it.
+ *
+ * Return: 0 on success, negative errno on failure.
+ */
+int qcom_smem_get_feature_code(u32 *code)
+{
+	struct socinfo *info;
+	u32 raw_code;
+
+	info = qcom_smem_get(QCOM_SMEM_HOST_ANY, SMEM_HW_SW_BUILD_ID, NULL);
+	if (IS_ERR(info))
+		return PTR_ERR(info);
+
+	/* This only makes sense for socinfo >= 16 */
+	if (__le32_to_cpu(info->fmt) < SOCINFO_VERSION(0, 16))
+		return -EOPNOTSUPP;
+
+	raw_code = __le32_to_cpu(info->feature_code);
+
+	/* Ensure the value makes sense */
+	if (raw_code > SOCINFO_FC_INT_MAX)
+		raw_code = SOCINFO_FC_UNKNOWN;
+
+	*code = raw_code;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(qcom_smem_get_feature_code);
+
+static int qcom_smem_get_sbl_version(struct qcom_smem *smem)
+{
+	struct smem_header *header;
+	__le32 *versions;
+
+	header = smem->regions[0].virt_base;
+	versions = header->version;
+
+	return le32_to_cpu(versions[SMEM_MASTER_SBL_VERSION_INDEX]);
+}
+
+static struct smem_ptable *qcom_smem_get_ptable(struct qcom_smem *smem)
+{
+	struct smem_ptable *ptable;
+	u32 version;
+
+	ptable = smem->ptable;
+	if (memcmp(ptable->magic, SMEM_PTABLE_MAGIC, sizeof(ptable->magic)))
+		return ERR_PTR(-ENOENT);
+
+	version = le32_to_cpu(ptable->version);
+	if (version != 1) {
+		dev_err(smem->dev,
+			"Unsupported partition header version %d\n", version);
+		return ERR_PTR(-EINVAL);
+	}
+	return ptable;
+}
+
+static u32 qcom_smem_get_item_count(struct qcom_smem *smem)
+{
+	struct smem_ptable *ptable;
+	struct smem_info *info;
+
+	ptable = qcom_smem_get_ptable(smem);
+	if (IS_ERR_OR_NULL(ptable))
+		return SMEM_ITEM_COUNT;
+
+	info = (struct smem_info *)&ptable->entry[ptable->num_entries];
+	if (memcmp(info->magic, SMEM_INFO_MAGIC, sizeof(info->magic)))
+		return SMEM_ITEM_COUNT;
+
+	return le16_to_cpu(info->num_items);
+}
+
+/*
+ * Validate the partition header for a partition whose partition
+ * table entry is supplied.  Returns a pointer to its header if
+ * valid, or a null pointer otherwise.
+ */
+static struct smem_partition_header *
+qcom_smem_partition_header(struct qcom_smem *smem,
+		struct smem_ptable_entry *entry, u16 host0, u16 host1)
+{
+	struct smem_partition_header *header;
+	u32 phys_addr;
+	u32 size;
+
+	phys_addr = smem->regions[0].aux_base + le32_to_cpu(entry->offset);
+	header = devm_ioremap_wc(smem->dev, phys_addr, le32_to_cpu(entry->size));
+
+	if (!header)
+		return NULL;
+
+	if (memcmp(header->magic, SMEM_PART_MAGIC, sizeof(header->magic))) {
+		dev_err(smem->dev, "bad partition magic %4ph\n", header->magic);
+		return NULL;
+	}
+
+	if (host0 != le16_to_cpu(header->host0)) {
+		dev_err(smem->dev, "bad host0 (%hu != %hu)\n",
+				host0, le16_to_cpu(header->host0));
+		return NULL;
+	}
+	if (host1 != le16_to_cpu(header->host1)) {
+		dev_err(smem->dev, "bad host1 (%hu != %hu)\n",
+				host1, le16_to_cpu(header->host1));
+		return NULL;
+	}
+
+	size = le32_to_cpu(header->size);
+	if (size != le32_to_cpu(entry->size)) {
+		dev_err(smem->dev, "bad partition size (%u != %u)\n",
+			size, le32_to_cpu(entry->size));
+		return NULL;
+	}
+
+	if (le32_to_cpu(header->offset_free_uncached) > size) {
+		dev_err(smem->dev, "bad partition free uncached (%u > %u)\n",
+			le32_to_cpu(header->offset_free_uncached), size);
+		return NULL;
+	}
+
+	return header;
+}
+
+static int qcom_smem_set_global_partition(struct qcom_smem *smem)
+{
+	struct smem_partition_header *header;
+	struct smem_ptable_entry *entry;
+	struct smem_ptable *ptable;
+	bool found = false;
+	int i;
+
+	if (smem->global_partition.virt_base) {
+		dev_err(smem->dev, "Already found the global partition\n");
+		return -EINVAL;
+	}
+
+	ptable = qcom_smem_get_ptable(smem);
+	if (IS_ERR(ptable))
+		return PTR_ERR(ptable);
+
+	for (i = 0; i < le32_to_cpu(ptable->num_entries); i++) {
+		entry = &ptable->entry[i];
+		if (!le32_to_cpu(entry->offset))
+			continue;
+		if (!le32_to_cpu(entry->size))
+			continue;
+
+		if (le16_to_cpu(entry->host0) != SMEM_GLOBAL_HOST)
+			continue;
+
+		if (le16_to_cpu(entry->host1) == SMEM_GLOBAL_HOST) {
+			found = true;
+			break;
+		}
+	}
+
+	if (!found) {
+		dev_err(smem->dev, "Missing entry for global partition\n");
+		return -EINVAL;
+	}
+
+	header = qcom_smem_partition_header(smem, entry,
+				SMEM_GLOBAL_HOST, SMEM_GLOBAL_HOST);
+	if (!header)
+		return -EINVAL;
+
+	smem->global_partition.virt_base = (void __iomem *)header;
+	smem->global_partition.phys_base = smem->regions[0].aux_base +
+					   le32_to_cpu(entry->offset);
+	smem->global_partition.size = le32_to_cpu(entry->size);
+	smem->global_partition.cacheline = le32_to_cpu(entry->cacheline);
+
+	return 0;
+}
+
+static int
+qcom_smem_enumerate_partitions(struct qcom_smem *smem, u16 local_host)
+{
+	struct smem_partition_header *header;
+	struct smem_ptable_entry *entry;
+	struct smem_ptable *ptable;
+	u16 remote_host;
+	u16 host0, host1;
+	int i;
+
+	ptable = qcom_smem_get_ptable(smem);
+	if (IS_ERR(ptable))
+		return PTR_ERR(ptable);
+
+	for (i = 0; i < le32_to_cpu(ptable->num_entries); i++) {
+		entry = &ptable->entry[i];
+		if (!le32_to_cpu(entry->offset))
+			continue;
+		if (!le32_to_cpu(entry->size))
+			continue;
+
+		host0 = le16_to_cpu(entry->host0);
+		host1 = le16_to_cpu(entry->host1);
+		if (host0 == local_host)
+			remote_host = host1;
+		else if (host1 == local_host)
+			remote_host = host0;
+		else
+			continue;
+
+		if (remote_host >= SMEM_HOST_COUNT) {
+			dev_err(smem->dev, "bad host %u\n", remote_host);
+			return -EINVAL;
+		}
+
+		if (smem->partitions[remote_host].virt_base) {
+			dev_err(smem->dev, "duplicate host %u\n", remote_host);
+			return -EINVAL;
+		}
+
+		header = qcom_smem_partition_header(smem, entry, host0, host1);
+		if (!header)
+			return -EINVAL;
+
+		smem->partitions[remote_host].virt_base = (void __iomem *)header;
+		smem->partitions[remote_host].phys_base = smem->regions[0].aux_base +
+										le32_to_cpu(entry->offset);
+		smem->partitions[remote_host].size = le32_to_cpu(entry->size);
+		smem->partitions[remote_host].cacheline = le32_to_cpu(entry->cacheline);
+	}
+
+	return 0;
+}
+
+static int qcom_smem_map_toc(struct qcom_smem *smem, struct smem_region *region)
+{
+	u32 ptable_start;
+
+	/* map starting 4K for smem header */
+	region->virt_base = devm_ioremap_wc(smem->dev, region->aux_base, SZ_4K);
+	ptable_start = region->aux_base + region->size - SZ_4K;
+	/* map last 4k for toc */
+	smem->ptable = devm_ioremap_wc(smem->dev, ptable_start, SZ_4K);
+
+	if (!region->virt_base || !smem->ptable)
+		return -ENOMEM;
+
+	return 0;
+}
+
+static int qcom_smem_map_global(struct qcom_smem *smem, u32 size)
+{
+	u32 phys_addr;
+
+	phys_addr = smem->regions[0].aux_base;
+
+	smem->regions[0].size = size;
+	smem->regions[0].virt_base = devm_ioremap_wc(smem->dev, phys_addr, size);
+
+	if (!smem->regions[0].virt_base)
+		return -ENOMEM;
+
+	return 0;
+}
+
+static int qcom_smem_resolve_mem(struct qcom_smem *smem, const char *name,
+				 struct smem_region *region)
+{
+	struct device *dev = smem->dev;
+	struct device_node *np;
+	struct resource r;
+	int ret;
+
+	np = of_parse_phandle(dev->of_node, name, 0);
+	if (!np) {
+		dev_err(dev, "No %s specified\n", name);
+		return -EINVAL;
+	}
+
+	ret = of_address_to_resource(np, 0, &r);
+	of_node_put(np);
+	if (ret)
+		return ret;
+
+	region->aux_base = r.start;
+	region->size = resource_size(&r);
+
+	return 0;
+}
+
+static int qcom_smem_probe(struct platform_device *pdev)
+{
+	struct smem_header *header;
+	struct reserved_mem *rmem;
+	struct qcom_smem *smem;
+	unsigned long flags;
+	int num_regions;
+	int hwlock_id;
+	u32 version;
+	u32 size;
+	int ret;
+	int i;
+
+	if (__smem)
+		return 0;
+
+	num_regions = 1;
+	if (of_property_present(pdev->dev.of_node, "qcom,rpm-msg-ram"))
+		num_regions++;
+
+	smem = devm_kzalloc(&pdev->dev, struct_size(smem, regions, num_regions),
+			    GFP_KERNEL);
+	if (!smem)
+		return -ENOMEM;
+
+	smem->dev = &pdev->dev;
+	smem->num_regions = num_regions;
+
+	rmem = of_reserved_mem_lookup(pdev->dev.of_node);
+	if (rmem) {
+		smem->regions[0].aux_base = rmem->base;
+		smem->regions[0].size = rmem->size;
+	} else {
+		/*
+		 * Fall back to the memory-region reference, if we're not a
+		 * reserved-memory node.
+		 */
+		ret = qcom_smem_resolve_mem(smem, "memory-region", &smem->regions[0]);
+		if (ret)
+			return ret;
+	}
+
+	if (num_regions > 1) {
+		ret = qcom_smem_resolve_mem(smem, "qcom,rpm-msg-ram", &smem->regions[1]);
+		if (ret)
+			return ret;
+	}
+
+
+	ret = qcom_smem_map_toc(smem, &smem->regions[0]);
+	if (ret)
+		return ret;
+
+	for (i = 1; i < num_regions; i++) {
+		smem->regions[i].virt_base = devm_ioremap_wc(&pdev->dev,
+							     smem->regions[i].aux_base,
+							     smem->regions[i].size);
+		if (!smem->regions[i].virt_base) {
+			dev_err(&pdev->dev, "failed to remap %pa\n", &smem->regions[i].aux_base);
+			return -ENOMEM;
+		}
+	}
+
+	header = smem->regions[0].virt_base;
+	if (le32_to_cpu(header->initialized) != 1 ||
+	    le32_to_cpu(header->reserved)) {
+		dev_err(&pdev->dev, "SMEM is not initialized by SBL\n");
+		return -EINVAL;
+	}
+
+	hwlock_id = of_hwspin_lock_get_id(pdev->dev.of_node, 0);
+	if (hwlock_id < 0) {
+		if (hwlock_id != -EPROBE_DEFER)
+			dev_err(&pdev->dev, "failed to retrieve hwlock\n");
+		return hwlock_id;
+	}
+
+	smem->hwlock = hwspin_lock_request_specific(hwlock_id);
+	if (!smem->hwlock)
+		return -ENXIO;
+
+	ret = hwspin_lock_timeout_irqsave(smem->hwlock, HWSPINLOCK_TIMEOUT, &flags);
+	if (ret)
+		return ret;
+	size = readl_relaxed(&header->available) + readl_relaxed(&header->free_offset);
+	hwspin_unlock_irqrestore(smem->hwlock, &flags);
+
+	version = qcom_smem_get_sbl_version(smem);
+	/*
+	 * smem header mapping is required only in heap version scheme, so unmap
+	 * it here. It will be remapped in qcom_smem_map_global() when whole
+	 * partition is mapped again.
+	 */
+	devm_iounmap(smem->dev, smem->regions[0].virt_base);
+	switch (version >> 16) {
+	case SMEM_GLOBAL_PART_VERSION:
+		ret = qcom_smem_set_global_partition(smem);
+		if (ret < 0)
+			return ret;
+		smem->item_count = qcom_smem_get_item_count(smem);
+		break;
+	case SMEM_GLOBAL_HEAP_VERSION:
+		qcom_smem_map_global(smem, size);
+		smem->item_count = SMEM_ITEM_COUNT;
+		break;
+	default:
+		dev_err(&pdev->dev, "Unsupported SMEM version 0x%x\n", version);
+		return -EINVAL;
+	}
+
+	BUILD_BUG_ON(SMEM_HOST_APPS >= SMEM_HOST_COUNT);
+	ret = qcom_smem_enumerate_partitions(smem, SMEM_HOST_APPS);
+	if (ret < 0 && ret != -ENOENT)
+		return ret;
+
+	__smem = smem;
+
+	smem->socinfo = platform_device_register_data(&pdev->dev, "qcom-socinfo",
+						      PLATFORM_DEVID_NONE, NULL,
+						      0);
+	if (IS_ERR(smem->socinfo))
+		dev_dbg(&pdev->dev, "failed to register socinfo device\n");
+
+	return 0;
+}
+
+static void qcom_smem_remove(struct platform_device *pdev)
+{
+	platform_device_unregister(__smem->socinfo);
+
+	hwspin_lock_free(__smem->hwlock);
+	__smem = NULL;
+}
+
+static const struct of_device_id qcom_smem_of_match[] = {
+	{ .compatible = "qcom,smem" },
+	{}
+};
+MODULE_DEVICE_TABLE(of, qcom_smem_of_match);
+
+static struct platform_driver qcom_smem_driver = {
+	.probe = qcom_smem_probe,
+	.remove_new = qcom_smem_remove,
+	.driver  = {
+		.name = "qcom-smem",
+		.of_match_table = qcom_smem_of_match,
+		.suppress_bind_attrs = true,
+	},
+};
+
+static int __init qcom_smem_init(void)
+{
+	return platform_driver_register(&qcom_smem_driver);
+}
+arch_initcall(qcom_smem_init);
+
+static void __exit qcom_smem_exit(void)
+{
+	platform_driver_unregister(&qcom_smem_driver);
+}
+module_exit(qcom_smem_exit)
+
+MODULE_AUTHOR("Bjorn Andersson <bjorn.andersson@sonymobile.com>");
+MODULE_DESCRIPTION("Qualcomm Shared Memory Manager");
+MODULE_LICENSE("GPL v2");
diff --git a/include/soc/qcom/smem.h b/include/soc/qcom/smem.h
new file mode 100644
index 000000000000..f946e3beca21
--- /dev/null
+++ b/include/soc/qcom/smem.h
@@ -0,0 +1,20 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __QCOM_SMEM_H__
+#define __QCOM_SMEM_H__
+
+#define QCOM_SMEM_HOST_ANY -1
+
+bool qcom_smem_is_available(void);
+int qcom_smem_alloc(unsigned host, unsigned item, size_t size);
+void *qcom_smem_get(unsigned host, unsigned item, size_t *size);
+
+int qcom_smem_get_free_space(unsigned host);
+
+phys_addr_t qcom_smem_virt_to_phys(void *p);
+
+int qcom_smem_get_soc_id(u32 *id);
+int qcom_smem_get_feature_code(u32 *code);
+
+int qcom_smem_bust_hwspin_lock_by_host(unsigned int host);
+
+#endif
diff --git a/include/soc/qcom/socinfo.h b/include/soc/qcom/socinfo.h
new file mode 100644
index 000000000000..608950443eee
--- /dev/null
+++ b/include/soc/qcom/socinfo.h
@@ -0,0 +1,111 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef __QCOM_SOCINFO_H__
+#define __QCOM_SOCINFO_H__
+
+#include <linux/types.h>
+
+/*
+ * SMEM item id, used to acquire handles to respective
+ * SMEM region.
+ */
+#define SMEM_HW_SW_BUILD_ID		137
+
+#define SMEM_SOCINFO_BUILD_ID_LENGTH	32
+#define SMEM_SOCINFO_CHIP_ID_LENGTH	32
+
+/*
+ * SoC version type with major number in the upper 16 bits and minor
+ * number in the lower 16 bits.
+ */
+#define SOCINFO_MAJOR(ver) (((ver) >> 16) & 0xffff)
+#define SOCINFO_MINOR(ver) ((ver) & 0xffff)
+#define SOCINFO_VERSION(maj, min)  ((((maj) & 0xffff) << 16)|((min) & 0xffff))
+
+/* Socinfo SMEM item structure */
+struct socinfo {
+	__le32 fmt;
+	__le32 id;
+	__le32 ver;
+	char build_id[SMEM_SOCINFO_BUILD_ID_LENGTH];
+	/* Version 2 */
+	__le32 raw_id;
+	__le32 raw_ver;
+	/* Version 3 */
+	__le32 hw_plat;
+	/* Version 4 */
+	__le32 plat_ver;
+	/* Version 5 */
+	__le32 accessory_chip;
+	/* Version 6 */
+	__le32 hw_plat_subtype;
+	/* Version 7 */
+	__le32 pmic_model;
+	__le32 pmic_die_rev;
+	/* Version 8 */
+	__le32 pmic_model_1;
+	__le32 pmic_die_rev_1;
+	__le32 pmic_model_2;
+	__le32 pmic_die_rev_2;
+	/* Version 9 */
+	__le32 foundry_id;
+	/* Version 10 */
+	__le32 serial_num;
+	/* Version 11 */
+	__le32 num_pmics;
+	__le32 pmic_array_offset;
+	/* Version 12 */
+	__le32 chip_family;
+	__le32 raw_device_family;
+	__le32 raw_device_num;
+	/* Version 13 */
+	__le32 nproduct_id;
+	char chip_id[SMEM_SOCINFO_CHIP_ID_LENGTH];
+	/* Version 14 */
+	__le32 num_clusters;
+	__le32 ncluster_array_offset;
+	__le32 num_subset_parts;
+	__le32 nsubset_parts_array_offset;
+	/* Version 15 */
+	__le32 nmodem_supported;
+	/* Version 16 */
+	__le32  feature_code;
+	__le32  pcode;
+	__le32  npartnamemap_offset;
+	__le32  nnum_partname_mapping;
+	/* Version 17 */
+	__le32 oem_variant;
+	/* Version 18 */
+	__le32 num_kvps;
+	__le32 kvps_offset;
+	/* Version 19 */
+	__le32 num_func_clusters;
+	__le32 boot_cluster;
+	__le32 boot_core;
+};
+
+/* Internal feature codes */
+enum qcom_socinfo_feature_code {
+	/* External feature codes */
+	SOCINFO_FC_UNKNOWN = 0x0,
+	SOCINFO_FC_AA,
+	SOCINFO_FC_AB,
+	SOCINFO_FC_AC,
+	SOCINFO_FC_AD,
+	SOCINFO_FC_AE,
+	SOCINFO_FC_AF,
+	SOCINFO_FC_AG,
+	SOCINFO_FC_AH,
+};
+
+/* Internal feature codes */
+/* Valid values: 0 <= n <= 0xf */
+#define SOCINFO_FC_Yn(n)		(0xf1 + (n))
+#define SOCINFO_FC_INT_MAX		SOCINFO_FC_Yn(0xf)
+
+/* Product codes */
+#define SOCINFO_PC_UNKNOWN		0
+#define SOCINFO_PCn(n)			((n) + 1)
+#define SOCINFO_PC_RESERVE		(BIT(31) - 1)
+
+#endif

-- 
2.47.0

