Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69B24D75E34
	for <u-boot@archiver.kernel.org>; Sun, 24 Nov 2024 19:18:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 228A689924;
	Sun, 24 Nov 2024 20:18:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="O7cUUQMO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D62F989924; Sun, 24 Nov 2024 20:17:58 +0100 (CET)
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com
 [IPv6:2a00:1450:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F17EC8958F
 for <u-boot@lists.denx.de>; Sun, 24 Nov 2024 20:17:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-aa545dc7105so119192466b.3
 for <u-boot@lists.denx.de>; Sun, 24 Nov 2024 11:17:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732475874; x=1733080674; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=vMTNM8Wxw3yHIqudFos625gRJbJSmUlRgS4x2gT55mA=;
 b=O7cUUQMOyJWM09putsxq+50IlCYzIIIzhiiGvzvQr5VCXczY0ewaTA6qTo73vy+JIS
 gAw+i9l4F19+lnkTGmcw8GdEhZqPJzkniV76umxZJJufEUXBPFGFad6C2W4wy/UE9OVt
 qguUkCGK2agvF37DtHGFtsK1DEEPy8P3UJtbXBy8dY3MGnNluVbt8dgoZ5cAWaS0I9gm
 3YkQWFBSeE1wxevLppvxZf6uGOdWedQIVQjO3476m129fvQC6jcXjTvhdcoZ5ax0xujJ
 swG6pDwbtGohFQdmhZ6qk5YL4D3/30+pbeE/OmnJ/gOljUBlMvWwbQAj66JRDFN6ZVti
 7z/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732475874; x=1733080674;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vMTNM8Wxw3yHIqudFos625gRJbJSmUlRgS4x2gT55mA=;
 b=DUcdIP6ctWDaMMSY7uupvYd4Hs+pI6fbWC71qYEF70GxIKRZiWE9QtJawIDpLYqUso
 3Ws7uasCbl7PsjBEIc0hXbRM1O9XrpGFfOPjpnT4dBI1L/BH7sqKCUbSQYGBfiWA00S4
 NguEIRxbox1gwe1EK8bUkbkOadA4VECbyiFoBAvWoI3L5W9gcwJW42oei56btBGtWu93
 CxCSJmiQegI/B7uuil2V6Z2GmTYPMqVKILUGiezC/4A1yZFM9RxSFiQE3dWpgWT0chgH
 HOWvopd1kC1X5GCu8eXGCKbuELyQISaao3rjvl/+uEIykpLgeWN2wcUsboHjGql67j35
 QKdA==
X-Gm-Message-State: AOJu0YwxlDzPCysPXq/L/NQ7mxWJov5NTPEwB1PJwAroRsVIU70HXXm+
 jod0HKGv4JCB15qxsFRMWiGpIsPe3l9Tx8NlayJkUrXq4cdi9yqdrALDO0zoT/0=
X-Gm-Gg: ASbGncvKTULPsaLtkS9JrhdH42zccDxe52A1Vbw97U0oa+hr4YvQ+0pOo739o0HWg3v
 fergcGeuqJQ0ev4hlvq9bJc3vCfAY4VDx2wSWVUwkawPRFgHxootioXZ+nRYezX4b/8sz/YraQM
 Uvqhjy3jJDQpJYUpJtgG/c8Rj2IopQyY88qkXNuvtuceZT1taKjG6dSBUXy7f5ruswTB4sse1u2
 8M7GqikQdVnAFqY4S39yu5z5JP8qdGA2jacoVpVzrf+wXcMiYKg4Lvw1XsO+9Bqh5wX
X-Google-Smtp-Source: AGHT+IHE/ifkNyCmETEb43Pw6hBFDlnjGTRuXB89xCotMUwa9D/MKHbflqGBEWMLhVgyKxZdAaExGA==
X-Received: by 2002:a17:906:2929:b0:aa5:1661:1949 with SMTP id
 a640c23a62f3a-aa516611a79mr739920066b.40.1732475874357; 
 Sun, 24 Nov 2024 11:17:54 -0800 (PST)
Received: from lion.localdomain ([2a02:8109:888d:ff00:ca7f:54ff:fe52:4519])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aa50b28f848sm371874566b.36.2024.11.24.11.17.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 24 Nov 2024 11:17:53 -0800 (PST)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Sun, 24 Nov 2024 20:17:49 +0100
Subject: [PATCH 07/15] soc: qcom: smem: adjust for U-Boot
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241124-b4-modernise-smem-v1-7-b7852c11b67c@linaro.org>
References: <20241124-b4-modernise-smem-v1-0-b7852c11b67c@linaro.org>
In-Reply-To: <20241124-b4-modernise-smem-v1-0-b7852c11b67c@linaro.org>
To: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>, 
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>, Mario Six <mario.six@gdsys.cc>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=18900;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=6Io/+B5XjS8J5lBvCIePD30blJmgsuFGDVwPqeqtrTA=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhnTn6psXXPQLQu2+xv5si9MSveN5IzxeOLdXiDf68dJnH
 nufMLzoKGVhEORgkBVTZBE/scyyae1le43tCy7AzGFlAhnCwMUpABOJusHwv17iyzVp3vvfM/h/
 iBjKyPv3Lk1/L3xqQci0deGeD+xUJRn+O22/1Xu1wOPXDK5TXtE/zxnViziXKzAsfv+tW9wl+NA
 0PwA=
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

Port over the smem code to U-Boot and remove socinfo.

Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 drivers/soc/qcom/smem.c | 320 +++++++++---------------------------------------
 include/soc/qcom/smem.h |   9 +-
 2 files changed, 63 insertions(+), 266 deletions(-)

diff --git a/drivers/soc/qcom/smem.c b/drivers/soc/qcom/smem.c
index 7143856e85c3..5166f289dfb6 100644
--- a/drivers/soc/qcom/smem.c
+++ b/drivers/soc/qcom/smem.c
@@ -3,17 +3,18 @@
  * Copyright (c) 2015, Sony Mobile Communications AB.
  * Copyright (c) 2012-2013, The Linux Foundation. All rights reserved.
  */
 
+#define pr_fmt(fmt) "smem: " fmt
+
 #include <dm/device.h>
 #include <dm/device_compat.h>
 #include <dm/ofnode.h>
 #include <linux/bug.h>
 #include <linux/io.h>
 #include <linux/ioport.h>
 #include <linux/sizes.h>
 #include <soc/qcom/smem.h>
-#include <soc/qcom/socinfo.h>
 
 /*
  * The Qualcomm shared memory system is a allocate only heap structure that
  * consists of one of more memory areas that can be accessed by the processors
@@ -260,31 +261,23 @@ struct smem_region {
 };
 
 /**
  * struct qcom_smem - device data for the smem device
- * @dev:	device pointer
- * @hwlock:	reference to a hwspinlock
  * @ptable: virtual base of partition table
  * @global_partition: describes for global partition when in use
  * @partitions: list of partitions of current processor/host
  * @item_count: max accepted item number
- * @socinfo:	platform device pointer
  * @num_regions: number of @regions
  * @regions:	list of the memory regions defining the shared memory
  */
 struct qcom_smem {
-	struct device *dev;
-
-	struct hwspinlock *hwlock;
-
 	u32 item_count;
-	struct platform_device *socinfo;
 	struct smem_ptable *ptable;
 	struct smem_partition global_partition;
 	struct smem_partition partitions[SMEM_HOST_COUNT];
 
 	unsigned num_regions;
-	struct smem_region regions[] __counted_by(num_regions);
+	struct smem_region regions[];
 };
 
 static void *
 phdr_to_last_uncached_entry(struct smem_partition_header *phdr)
@@ -351,38 +344,9 @@ static void *cached_entry_to_item(struct smem_private_entry *e)
 	return p - le32_to_cpu(e->size);
 }
 
 /* Pointer to the one and only smem handle */
-static struct qcom_smem *__smem;
-
-/* Timeout (ms) for the trylock of remote spinlocks */
-#define HWSPINLOCK_TIMEOUT	1000
-
-/* The qcom hwspinlock id is always plus one from the smem host id */
-#define SMEM_HOST_ID_TO_HWSPINLOCK_ID(__x) ((__x) + 1)
-
-/**
- * qcom_smem_bust_hwspin_lock_by_host() - bust the smem hwspinlock for a host
- * @host:	remote processor id
- *
- * Busts the hwspin_lock for the given smem host id. This helper is intended
- * for remoteproc drivers that manage remoteprocs with an equivalent smem
- * driver instance in the remote firmware. Drivers can force a release of the
- * smem hwspin_lock if the rproc unexpectedly goes into a bad state.
- *
- * Context: Process context.
- *
- * Returns: 0 on success, otherwise negative errno.
- */
-int qcom_smem_bust_hwspin_lock_by_host(unsigned int host)
-{
-	/* This function is for remote procs, so ignore SMEM_HOST_APPS */
-	if (host == SMEM_HOST_APPS || host >= SMEM_HOST_COUNT)
-		return -EINVAL;
-
-	return hwspin_lock_bust(__smem->hwlock, SMEM_HOST_ID_TO_HWSPINLOCK_ID(host));
-}
-EXPORT_SYMBOL_GPL(qcom_smem_bust_hwspin_lock_by_host);
+static struct qcom_smem *__smem __section(".data") = NULL;
 
 /**
  * qcom_smem_is_available() - Check if SMEM is available
  *
@@ -429,9 +393,9 @@ static int qcom_smem_alloc_private(struct qcom_smem *smem,
 
 	/* Check that we don't grow into the cached region */
 	alloc_size = sizeof(*hdr) + ALIGN(size, 8);
 	if ((void *)hdr + alloc_size > cached) {
-		dev_err(smem->dev, "Out of memory\n");
+		log_err("Out of memory\n");
 		return -ENOSPC;
 	}
 
 	hdr->canary = SMEM_PRIVATE_CANARY;
@@ -449,9 +413,9 @@ static int qcom_smem_alloc_private(struct qcom_smem *smem,
 	le32_add_cpu(&phdr->offset_free_uncached, alloc_size);
 
 	return 0;
 bad_canary:
-	dev_err(smem->dev, "Found invalid canary in hosts %hu:%hu partition\n",
+	log_err("Found invalid canary in hosts %hu:%hu partition\n",
 		le16_to_cpu(phdr->host0), le16_to_cpu(phdr->host1));
 
 	return -EINVAL;
 }
@@ -500,29 +464,21 @@ static int qcom_smem_alloc_global(struct qcom_smem *smem,
  */
 int qcom_smem_alloc(unsigned host, unsigned item, size_t size)
 {
 	struct smem_partition *part;
-	unsigned long flags;
 	int ret;
 
 	if (!__smem)
 		return -EPROBE_DEFER;
 
 	if (item < SMEM_ITEM_LAST_FIXED) {
-		dev_err(__smem->dev,
-			"Rejecting allocation of static entry %d\n", item);
+		log_err("Rejecting allocation of static entry %d\n", item);
 		return -EINVAL;
 	}
 
 	if (WARN_ON(item >= __smem->item_count))
 		return -EINVAL;
 
-	ret = hwspin_lock_timeout_irqsave(__smem->hwlock,
-					  HWSPINLOCK_TIMEOUT,
-					  &flags);
-	if (ret)
-		return ret;
-
 	if (host < SMEM_HOST_COUNT && __smem->partitions[host].virt_base) {
 		part = &__smem->partitions[host];
 		ret = qcom_smem_alloc_private(__smem, part, item, size);
 	} else if (__smem->global_partition.virt_base) {
@@ -531,10 +487,8 @@ int qcom_smem_alloc(unsigned host, unsigned item, size_t size)
 	} else {
 		ret = qcom_smem_alloc_global(__smem, item, size);
 	}
 
-	hwspin_unlock_irqrestore(__smem->hwlock, &flags);
-
 	return ret;
 }
 EXPORT_SYMBOL_GPL(qcom_smem_alloc);
 
@@ -660,9 +614,9 @@ static void *qcom_smem_get_private(struct qcom_smem *smem,
 
 	return ERR_PTR(-ENOENT);
 
 invalid_canary:
-	dev_err(smem->dev, "Found invalid canary in hosts %hu:%hu partition\n",
+	log_err("Found invalid canary in hosts %hu:%hu partition\n",
 			le16_to_cpu(phdr->host0), le16_to_cpu(phdr->host1));
 
 	return ERR_PTR(-EINVAL);
 }
@@ -796,63 +750,8 @@ phys_addr_t qcom_smem_virt_to_phys(void *p)
 	return 0;
 }
 EXPORT_SYMBOL_GPL(qcom_smem_virt_to_phys);
 
-/**
- * qcom_smem_get_soc_id() - return the SoC ID
- * @id:	On success, we return the SoC ID here.
- *
- * Look up SoC ID from HW/SW build ID and return it.
- *
- * Return: 0 on success, negative errno on failure.
- */
-int qcom_smem_get_soc_id(u32 *id)
-{
-	struct socinfo *info;
-
-	info = qcom_smem_get(QCOM_SMEM_HOST_ANY, SMEM_HW_SW_BUILD_ID, NULL);
-	if (IS_ERR(info))
-		return PTR_ERR(info);
-
-	*id = __le32_to_cpu(info->id);
-
-	return 0;
-}
-EXPORT_SYMBOL_GPL(qcom_smem_get_soc_id);
-
-/**
- * qcom_smem_get_feature_code() - return the feature code
- * @code: On success, return the feature code here.
- *
- * Look up the feature code identifier from SMEM and return it.
- *
- * Return: 0 on success, negative errno on failure.
- */
-int qcom_smem_get_feature_code(u32 *code)
-{
-	struct socinfo *info;
-	u32 raw_code;
-
-	info = qcom_smem_get(QCOM_SMEM_HOST_ANY, SMEM_HW_SW_BUILD_ID, NULL);
-	if (IS_ERR(info))
-		return PTR_ERR(info);
-
-	/* This only makes sense for socinfo >= 16 */
-	if (__le32_to_cpu(info->fmt) < SOCINFO_VERSION(0, 16))
-		return -EOPNOTSUPP;
-
-	raw_code = __le32_to_cpu(info->feature_code);
-
-	/* Ensure the value makes sense */
-	if (raw_code > SOCINFO_FC_INT_MAX)
-		raw_code = SOCINFO_FC_UNKNOWN;
-
-	*code = raw_code;
-
-	return 0;
-}
-EXPORT_SYMBOL_GPL(qcom_smem_get_feature_code);
-
 static int qcom_smem_get_sbl_version(struct qcom_smem *smem)
 {
 	struct smem_header *header;
 	__le32 *versions;
@@ -873,10 +772,9 @@ static struct smem_ptable *qcom_smem_get_ptable(struct qcom_smem *smem)
 		return ERR_PTR(-ENOENT);
 
 	version = le32_to_cpu(ptable->version);
 	if (version != 1) {
-		dev_err(smem->dev,
-			"Unsupported partition header version %d\n", version);
+		log_err("Unsupported partition header version %d\n", version);
 		return ERR_PTR(-EINVAL);
 	}
 	return ptable;
 }
@@ -906,42 +804,42 @@ static struct smem_partition_header *
 qcom_smem_partition_header(struct qcom_smem *smem,
 		struct smem_ptable_entry *entry, u16 host0, u16 host1)
 {
 	struct smem_partition_header *header;
-	u32 phys_addr;
+	u64 phys_addr;
 	u32 size;
 
 	phys_addr = smem->regions[0].aux_base + le32_to_cpu(entry->offset);
-	header = devm_ioremap_wc(smem->dev, phys_addr, le32_to_cpu(entry->size));
+	header = (void *)phys_addr; // devm_ioremap_wc()
 
 	if (!header)
 		return NULL;
 
 	if (memcmp(header->magic, SMEM_PART_MAGIC, sizeof(header->magic))) {
-		dev_err(smem->dev, "bad partition magic %4ph\n", header->magic);
+		log_err("bad partition magic %4ph\n", header->magic);
 		return NULL;
 	}
 
 	if (host0 != le16_to_cpu(header->host0)) {
-		dev_err(smem->dev, "bad host0 (%hu != %hu)\n",
-				host0, le16_to_cpu(header->host0));
+		log_err("bad host0 (%hu != %hu)\n",
+			host0, le16_to_cpu(header->host0));
 		return NULL;
 	}
 	if (host1 != le16_to_cpu(header->host1)) {
-		dev_err(smem->dev, "bad host1 (%hu != %hu)\n",
-				host1, le16_to_cpu(header->host1));
+		log_err("bad host1 (%hu != %hu)\n",
+			host1, le16_to_cpu(header->host1));
 		return NULL;
 	}
 
 	size = le32_to_cpu(header->size);
 	if (size != le32_to_cpu(entry->size)) {
-		dev_err(smem->dev, "bad partition size (%u != %u)\n",
+		log_err("bad partition size (%u != %u)\n",
 			size, le32_to_cpu(entry->size));
 		return NULL;
 	}
 
 	if (le32_to_cpu(header->offset_free_uncached) > size) {
-		dev_err(smem->dev, "bad partition free uncached (%u > %u)\n",
+		log_err("bad partition free uncached (%u > %u)\n",
 			le32_to_cpu(header->offset_free_uncached), size);
 		return NULL;
 	}
 
@@ -956,9 +854,9 @@ static int qcom_smem_set_global_partition(struct qcom_smem *smem)
 	bool found = false;
 	int i;
 
 	if (smem->global_partition.virt_base) {
-		dev_err(smem->dev, "Already found the global partition\n");
+		log_err("Already found the global partition\n");
 		return -EINVAL;
 	}
 
 	ptable = qcom_smem_get_ptable(smem);
@@ -981,9 +879,9 @@ static int qcom_smem_set_global_partition(struct qcom_smem *smem)
 		}
 	}
 
 	if (!found) {
-		dev_err(smem->dev, "Missing entry for global partition\n");
+		log_err("Missing entry for global partition\n");
 		return -EINVAL;
 	}
 
 	header = qcom_smem_partition_header(smem, entry,
@@ -1030,14 +928,14 @@ qcom_smem_enumerate_partitions(struct qcom_smem *smem, u16 local_host)
 		else
 			continue;
 
 		if (remote_host >= SMEM_HOST_COUNT) {
-			dev_err(smem->dev, "bad host %u\n", remote_host);
+			log_err("bad host %u\n", remote_host);
 			return -EINVAL;
 		}
 
 		if (smem->partitions[remote_host].virt_base) {
-			dev_err(smem->dev, "duplicate host %u\n", remote_host);
+			log_err("duplicate host %u\n", remote_host);
 			return -EINVAL;
 		}
 
 		header = qcom_smem_partition_header(smem, entry, host0, host1);
@@ -1058,12 +956,12 @@ static int qcom_smem_map_toc(struct qcom_smem *smem, struct smem_region *region)
 {
 	u32 ptable_start;
 
 	/* map starting 4K for smem header */
-	region->virt_base = devm_ioremap_wc(smem->dev, region->aux_base, SZ_4K);
+	region->virt_base = (void *)region->aux_base;
 	ptable_start = region->aux_base + region->size - SZ_4K;
 	/* map last 4k for toc */
-	smem->ptable = devm_ioremap_wc(smem->dev, ptable_start, SZ_4K);
+	smem->ptable = (struct smem_ptable *)(u64)ptable_start;
 
 	if (!region->virt_base || !smem->ptable)
 		return -ENOMEM;
 
@@ -1071,54 +969,29 @@ static int qcom_smem_map_toc(struct qcom_smem *smem, struct smem_region *region)
 }
 
 static int qcom_smem_map_global(struct qcom_smem *smem, u32 size)
 {
-	u32 phys_addr;
+	u64 phys_addr;
 
 	phys_addr = smem->regions[0].aux_base;
 
 	smem->regions[0].size = size;
-	smem->regions[0].virt_base = devm_ioremap_wc(smem->dev, phys_addr, size);
+	smem->regions[0].virt_base = (void *)phys_addr;
 
 	if (!smem->regions[0].virt_base)
 		return -ENOMEM;
 
 	return 0;
 }
 
-static int qcom_smem_resolve_mem(struct qcom_smem *smem, const char *name,
-				 struct smem_region *region)
-{
-	struct device *dev = smem->dev;
-	struct device_node *np;
-	struct resource r;
-	int ret;
-
-	np = of_parse_phandle(dev->of_node, name, 0);
-	if (!np) {
-		dev_err(dev, "No %s specified\n", name);
-		return -EINVAL;
-	}
-
-	ret = of_address_to_resource(np, 0, &r);
-	of_node_put(np);
-	if (ret)
-		return ret;
-
-	region->aux_base = r.start;
-	region->size = resource_size(&r);
-
-	return 0;
-}
-
-static int qcom_smem_probe(struct platform_device *pdev)
+int qcom_smem_init(void)
 {
 	struct smem_header *header;
-	struct reserved_mem *rmem;
 	struct qcom_smem *smem;
-	unsigned long flags;
 	int num_regions;
-	int hwlock_id;
+	fdt_size_t reg_size = 0;
+	u32 phandle;
+	ofnode node, mem_node;
 	u32 version;
 	u32 size;
 	int ret;
 	int i;
@@ -1126,85 +999,58 @@ static int qcom_smem_probe(struct platform_device *pdev)
 	if (__smem)
 		return 0;
 
 	num_regions = 1;
-	if (of_property_present(pdev->dev.of_node, "qcom,rpm-msg-ram"))
-		num_regions++;
 
-	smem = devm_kzalloc(&pdev->dev, struct_size(smem, regions, num_regions),
+	node = ofnode_by_compatible(ofnode_root(), "qcom,smem");
+	if (!ofnode_valid(node))
+		return -ENODEV;
+
+	if (ofnode_has_property(node, "memory-region")) {
+		ofnode_read_u32(node, "memory-region", &phandle);
+		mem_node = ofnode_get_by_phandle(phandle);
+	} else {
+		mem_node = node;
+	}
+
+	smem = kzalloc(sizeof(struct smem_region) * num_regions +
+		       sizeof(struct qcom_smem),
 			    GFP_KERNEL);
-	if (!smem)
+	if (!smem) {
+		log_err("Failed to allocate memory for smem\n");
 		return -ENOMEM;
+	}
 
-	smem->dev = &pdev->dev;
 	smem->num_regions = num_regions;
 
-	rmem = of_reserved_mem_lookup(pdev->dev.of_node);
-	if (rmem) {
-		smem->regions[0].aux_base = rmem->base;
-		smem->regions[0].size = rmem->size;
-	} else {
-		/*
-		 * Fall back to the memory-region reference, if we're not a
-		 * reserved-memory node.
-		 */
-		ret = qcom_smem_resolve_mem(smem, "memory-region", &smem->regions[0]);
-		if (ret)
-			return ret;
+	smem->regions[0].aux_base = ofnode_get_addr(mem_node);
+	reg_size = ofnode_get_size(mem_node);
+	if (smem->regions[0].aux_base == FDT_ADDR_T_NONE) {
+		log_err("Failed to get base address\n");
+		return -EINVAL;
 	}
-
-	if (num_regions > 1) {
-		ret = qcom_smem_resolve_mem(smem, "qcom,rpm-msg-ram", &smem->regions[1]);
-		if (ret)
-			return ret;
-	}
-
+	smem->regions[0].size = reg_size;
 
 	ret = qcom_smem_map_toc(smem, &smem->regions[0]);
-	if (ret)
+	if (ret) {
+		log_err("Failed to map toc\n");
 		return ret;
+	}
 
 	for (i = 1; i < num_regions; i++) {
-		smem->regions[i].virt_base = devm_ioremap_wc(&pdev->dev,
-							     smem->regions[i].aux_base,
-							     smem->regions[i].size);
-		if (!smem->regions[i].virt_base) {
-			dev_err(&pdev->dev, "failed to remap %pa\n", &smem->regions[i].aux_base);
-			return -ENOMEM;
-		}
+		smem->regions[i].virt_base = (void *)smem->regions[i].aux_base;
 	}
 
 	header = smem->regions[0].virt_base;
 	if (le32_to_cpu(header->initialized) != 1 ||
 	    le32_to_cpu(header->reserved)) {
-		dev_err(&pdev->dev, "SMEM is not initialized by SBL\n");
+		log_err("SMEM is not initialized by SBL\n");
 		return -EINVAL;
 	}
 
-	hwlock_id = of_hwspin_lock_get_id(pdev->dev.of_node, 0);
-	if (hwlock_id < 0) {
-		if (hwlock_id != -EPROBE_DEFER)
-			dev_err(&pdev->dev, "failed to retrieve hwlock\n");
-		return hwlock_id;
-	}
-
-	smem->hwlock = hwspin_lock_request_specific(hwlock_id);
-	if (!smem->hwlock)
-		return -ENXIO;
-
-	ret = hwspin_lock_timeout_irqsave(smem->hwlock, HWSPINLOCK_TIMEOUT, &flags);
-	if (ret)
-		return ret;
 	size = readl_relaxed(&header->available) + readl_relaxed(&header->free_offset);
-	hwspin_unlock_irqrestore(smem->hwlock, &flags);
 
 	version = qcom_smem_get_sbl_version(smem);
-	/*
-	 * smem header mapping is required only in heap version scheme, so unmap
-	 * it here. It will be remapped in qcom_smem_map_global() when whole
-	 * partition is mapped again.
-	 */
-	devm_iounmap(smem->dev, smem->regions[0].virt_base);
 	switch (version >> 16) {
 	case SMEM_GLOBAL_PART_VERSION:
 		ret = qcom_smem_set_global_partition(smem);
 		if (ret < 0)
@@ -1215,63 +1061,19 @@ static int qcom_smem_probe(struct platform_device *pdev)
 		qcom_smem_map_global(smem, size);
 		smem->item_count = SMEM_ITEM_COUNT;
 		break;
 	default:
-		dev_err(&pdev->dev, "Unsupported SMEM version 0x%x\n", version);
+		log_err("Unsupported SMEM version 0x%x\n", version);
 		return -EINVAL;
 	}
 
 	BUILD_BUG_ON(SMEM_HOST_APPS >= SMEM_HOST_COUNT);
 	ret = qcom_smem_enumerate_partitions(smem, SMEM_HOST_APPS);
-	if (ret < 0 && ret != -ENOENT)
+	if (ret < 0 && ret != -ENOENT) {
+		log_err("Failed to enumerate partitions\n");
 		return ret;
+	}
 
 	__smem = smem;
 
-	smem->socinfo = platform_device_register_data(&pdev->dev, "qcom-socinfo",
-						      PLATFORM_DEVID_NONE, NULL,
-						      0);
-	if (IS_ERR(smem->socinfo))
-		dev_dbg(&pdev->dev, "failed to register socinfo device\n");
-
 	return 0;
 }
-
-static void qcom_smem_remove(struct platform_device *pdev)
-{
-	platform_device_unregister(__smem->socinfo);
-
-	hwspin_lock_free(__smem->hwlock);
-	__smem = NULL;
-}
-
-static const struct of_device_id qcom_smem_of_match[] = {
-	{ .compatible = "qcom,smem" },
-	{}
-};
-MODULE_DEVICE_TABLE(of, qcom_smem_of_match);
-
-static struct platform_driver qcom_smem_driver = {
-	.probe = qcom_smem_probe,
-	.remove_new = qcom_smem_remove,
-	.driver  = {
-		.name = "qcom-smem",
-		.of_match_table = qcom_smem_of_match,
-		.suppress_bind_attrs = true,
-	},
-};
-
-static int __init qcom_smem_init(void)
-{
-	return platform_driver_register(&qcom_smem_driver);
-}
-arch_initcall(qcom_smem_init);
-
-static void __exit qcom_smem_exit(void)
-{
-	platform_driver_unregister(&qcom_smem_driver);
-}
-module_exit(qcom_smem_exit)
-
-MODULE_AUTHOR("Bjorn Andersson <bjorn.andersson@sonymobile.com>");
-MODULE_DESCRIPTION("Qualcomm Shared Memory Manager");
-MODULE_LICENSE("GPL v2");
diff --git a/include/soc/qcom/smem.h b/include/soc/qcom/smem.h
index f946e3beca21..a955db08c0f0 100644
--- a/include/soc/qcom/smem.h
+++ b/include/soc/qcom/smem.h
@@ -3,18 +3,13 @@
 #define __QCOM_SMEM_H__
 
 #define QCOM_SMEM_HOST_ANY -1
 
+int qcom_smem_init(void);
+
 bool qcom_smem_is_available(void);
 int qcom_smem_alloc(unsigned host, unsigned item, size_t size);
 void *qcom_smem_get(unsigned host, unsigned item, size_t *size);
 
 int qcom_smem_get_free_space(unsigned host);
 
-phys_addr_t qcom_smem_virt_to_phys(void *p);
-
-int qcom_smem_get_soc_id(u32 *id);
-int qcom_smem_get_feature_code(u32 *code);
-
-int qcom_smem_bust_hwspin_lock_by_host(unsigned int host);
-
 #endif

-- 
2.47.0

