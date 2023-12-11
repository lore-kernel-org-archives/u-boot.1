Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6487EC4167B
	for <u-boot@archiver.kernel.org>; Mon, 11 Dec 2023 18:42:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A200A877B2;
	Mon, 11 Dec 2023 19:41:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="qCA6O7le";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B57AC877AA; Mon, 11 Dec 2023 19:41:56 +0100 (CET)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4E3AE877A8
 for <u-boot@lists.denx.de>; Mon, 11 Dec 2023 19:41:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-40c4846847eso11650465e9.1
 for <u-boot@lists.denx.de>; Mon, 11 Dec 2023 10:41:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1702320114; x=1702924914; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=MThO5fVmLAmttVrSyzCq3yBtZ0JYFKtPiJtZnqgsebY=;
 b=qCA6O7leBgp4qQtUEO6qyoJaKcWrX4096dvBGF488RBYCFf/rEBnW8XYqAvf86FLdM
 q+Q+JwG6H5iF3bHfwKHb67lBsMNFghm2gtT/6II8Sr37OQ1rKBDM+oFQVLA/DnbhQh1T
 1Thny/Te6sIbWsfSDY/DjbFFquIxfROw+AnPHkf13XXpx+59elyI0i3CI8UfPn+ATKih
 exOu3Uuf8IQvvff7UA1YOUdVlPmRpc3SukzYl14FAfvCbSUxFTra3uSrnUjbJ1TuqiQI
 jUcCvry8mLbm+qw1dg+EP8SGoJ/2vOqrbdE8U/VKSyKOlJ390c0Hd3cKTOHErFnhgd2N
 NyJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702320114; x=1702924914;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MThO5fVmLAmttVrSyzCq3yBtZ0JYFKtPiJtZnqgsebY=;
 b=X/vjHMzR5JgEinh54JQrDAmDCizWOHD4dIGTOGd1Kd+IlOeF8yhwk54LlkZ3o830kD
 uMGofztHAwEu3xMGgmNNpV/haWKT2cxcurK02VdjaACPJkXXfjT9nvlliAreU/jFCa1/
 755boebr6NQRKUSMZFU9gVUybfXOZGlxYSt5PGTLcrlRe6WOeawlQ6/HqvWJ+MZsqyh9
 8+E4sGlQggBnVz8WVM5byWY9825TmsZWxPXyT45rHL7SIhhbriWH0/WNBEnUshmTbRP9
 NPwWdCVxshre2+6weJOLt+ITrGRitpZ53dVCdXi6ftSWSDXDlnwL5DNkAMlLWSS1MOba
 eG5Q==
X-Gm-Message-State: AOJu0YxQSX5++oqhD2XVBMOYC2n7MGzocjRHkciY35gT6zl7Jy1Uabhl
 0Lu/8ymLg9lXkNQmHTJwTtO86Q==
X-Google-Smtp-Source: AGHT+IGtcMPqo/VSmc5fS6699EpqplK6dZmTRkxSpCi4Ar4Dkl11BQFp8Jc6XRcB/cv22j46+YMMNA==
X-Received: by 2002:a05:600c:430c:b0:40c:2c5c:f945 with SMTP id
 p12-20020a05600c430c00b0040c2c5cf945mr2699873wme.36.1702320113777; 
 Mon, 11 Dec 2023 10:41:53 -0800 (PST)
Received: from lion.localdomain (host-92-17-96-230.as13285.net. [92.17.96.230])
 by smtp.gmail.com with ESMTPSA id
 b1-20020a05600c4e0100b00405959469afsm13910422wmq.3.2023.12.11.10.41.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Dec 2023 10:41:53 -0800 (PST)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Mon, 11 Dec 2023 18:41:42 +0000
Subject: [PATCH 3/3] iommu: add qcom-hyp-smmu
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231211-b4-dwc3-qcom-v1-3-46275113b4f2@linaro.org>
References: <20231211-b4-dwc3-qcom-v1-0-46275113b4f2@linaro.org>
In-Reply-To: <20231211-b4-dwc3-qcom-v1-0-46275113b4f2@linaro.org>
To: Caleb Connolly <caleb.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>, Mark Kettenis <kettenis@openbsd.org>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 u-boot@lists.denx.de
X-Mailer: b4 0.13-dev-4bd13
X-Developer-Signature: v=1; a=openpgp-sha256; l=13720;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=0vpyjdBDMEmxjCCP1G5G95FyQ6HXV5QUL6Q0GaFcCec=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhtTy8Lc5Z8s63bKvHf95XGcWc/IOybt7on9ocSqesL8yK
 6LDYOvUjlIWBkEOBlkxRRbxE8ssm9ZettfYvuACzBxWJpAhDFycAjCRBzsZ/gr1KVWIuup+2zxV
 da3j3ps3v4v4fmvSuLfyoC/fgvcWTvsYGZYcUq/7oDV398qamkIvEaNXjyKCV68Lfdv01N542qL
 EdzkA
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

Add a basic implementation of the ARM SMMU. This driver is intended for
use on Qualcomm platforms where the SMMU has been configured by a previous
bootloader, cannot be turned off, and doesn't support BYPASS streams.
It keeps all existing stream mappings and only creates new ones for stream
ids that aren't already configured.

This driver is necessary to support peripherals that perform DMA which
weren't configured by the previous stage bootloader (for example USB).
It works by allocating a context bank using identity mapping (as U-Boot
doesn't use virtual addresses).

Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 drivers/iommu/Kconfig         |  16 ++
 drivers/iommu/Makefile        |   1 +
 drivers/iommu/qcom-hyp-smmu.c | 396 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 413 insertions(+)

diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
index dabc1f900d58..2ba6d9c13622 100644
--- a/drivers/iommu/Kconfig
+++ b/drivers/iommu/Kconfig
@@ -24,4 +24,20 @@ config APPLE_DART
 	  configuration to put the DART into bypass mode such that it can
 	  be used transparently by U-Boot.
 
+config QCOM_HYP_SMMU
+	bool "Qualcomm quirky SMMU support"
+	depends on IOMMU && ARCH_SNAPDRAGON
+	help
+	  Enable support for the Qualcomm variant of the Arm System MMU-500.
+	  Qualcomm boards have a non-standard SMMU where some registers are
+	  emulated by the hypervisor. It is initialised early in the boot
+	  process and can't be turned off.
+
+	  The main caveat with this hardware is that it doesn't support BYPASS
+	  streams, attempting to configure once will instead wind up with a
+	  FAULT stream, and the device will crash when DMA is attempted.
+
+	  Say Y here to enable support for non-boot peripherals like USB by
+	  configuring identity mapped streams for them.
+
 endmenu
diff --git a/drivers/iommu/Makefile b/drivers/iommu/Makefile
index e3e0900e1703..438cab8a7c49 100644
--- a/drivers/iommu/Makefile
+++ b/drivers/iommu/Makefile
@@ -4,3 +4,4 @@ obj-$(CONFIG_IOMMU) += iommu-uclass.o
 
 obj-$(CONFIG_APPLE_DART) += apple_dart.o
 obj-$(CONFIG_SANDBOX) += sandbox_iommu.o
+obj-$(CONFIG_QCOM_HYP_SMMU) += qcom-hyp-smmu.o
diff --git a/drivers/iommu/qcom-hyp-smmu.c b/drivers/iommu/qcom-hyp-smmu.c
new file mode 100644
index 000000000000..8e5cdb581550
--- /dev/null
+++ b/drivers/iommu/qcom-hyp-smmu.c
@@ -0,0 +1,396 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2023 Linaro Ltd.
+ * Basic ARM SMMU-500 driver, assuming a pre-initialised SMMU and only IDENTITY domains
+ * this driver only implements the bare minimum to configure stream mappings for periphals
+ * used by u-boot on platforms where the SMMU can't be disabled.
+ */
+
+#include <log.h>
+#include <cpu_func.h>
+#include <dm.h>
+#include <iommu.h>
+#include <linux/bitfield.h>
+#include <linux/list.h>
+#include <linux/err.h>
+#include <lmb.h>
+#include <memalign.h>
+#include <asm/io.h>
+
+#define ARM_SMMU_GR0 0
+#define ARM_SMMU_GR1 1
+
+#define ARM_SMMU_GR0_ID0 0x20
+#define ARM_SMMU_ID0_NUMSMRG GENMASK(7, 0) /* Number of stream mapping groups */
+#define ARM_SMMU_GR0_ID1 0x24
+#define ARM_SMMU_ID1_PAGESIZE \
+	BIT(31) /* Page shift is 16 bits when set, otherwise 23 */
+#define ARM_SMMU_ID1_NUMPAGENDXB \
+	GENMASK(30, 28) /* Number of pages before context banks */
+#define ARM_SMMU_ID1_NUMCB GENMASK(7, 0) /* Number of context banks supported */
+
+#define ARM_SMMU_GR1_CBAR(n) (0x0 + ((n) << 2))
+#define ARM_SMMU_CBAR_TYPE GENMASK(17, 16)
+#define ARM_SMMU_CBAR_VMID GENMASK(7, 0)
+enum arm_smmu_cbar_type {
+	CBAR_TYPE_S2_TRANS,
+	CBAR_TYPE_S1_TRANS_S2_BYPASS,
+	CBAR_TYPE_S1_TRANS_S2_FAULT,
+	CBAR_TYPE_S1_TRANS_S2_TRANS,
+};
+
+#define ARM_SMMU_GR1_CBA2R(n) (0x800 + ((n) << 2))
+#define ARM_SMMU_CBA2R_VA64 BIT(0)
+
+/* Per-CB system control register */
+#define ARM_SMMU_CB_SCTLR 0x0
+#define ARM_SMMU_SCTLR_CFCFG BIT(7) /* Stall on context fault */
+#define ARM_SMMU_SCTLR_CFIE BIT(6) /* Context fault interrupt enable */
+#define ARM_SMMU_SCTLR_CFRE BIT(5) /* Abort on context fault */
+
+/* Translation Table Base, holds address of translation table in memory to be used
+ * for this context bank. Or 0 for bypass
+ */
+#define ARM_SMMU_CB_TTBR0 0x20
+#define ARM_SMMU_CB_TTBR1 0x28
+/* Translation Control Register, configured TTBR/TLB behaviour (0 for bypass) */
+#define ARM_SMMU_CB_TCR 0x30
+/* Memory Attribute Indirection, also 0 for bypass */
+#define ARM_SMMU_CB_S1_MAIR0 0x38
+#define ARM_SMMU_CB_S1_MAIR1 0x3c
+
+#define ARM_SMMU_GR0_SMR(n) (0x800 + ((n) << 2))
+#define ARM_SMMU_SMR_VALID BIT(31)
+#define ARM_SMMU_SMR_MASK GENMASK(31, 16) // Always 0 for now??
+#define ARM_SMMU_SMR_ID GENMASK(15, 0)
+
+#define ARM_SMMU_GR0_S2CR(n) (0xc00 + ((n) << 2))
+#define ARM_SMMU_S2CR_PRIVCFG GENMASK(25, 24)
+
+enum arm_smmu_s2cr_privcfg {
+	S2CR_PRIVCFG_DEFAULT,
+	S2CR_PRIVCFG_DIPAN,
+	S2CR_PRIVCFG_UNPRIV,
+	S2CR_PRIVCFG_PRIV,
+};
+
+#define ARM_SMMU_S2CR_TYPE GENMASK(17, 16)
+
+enum arm_smmu_s2cr_type {
+	S2CR_TYPE_TRANS,
+	S2CR_TYPE_BYPASS,
+	S2CR_TYPE_FAULT,
+};
+
+#define ARM_SMMU_S2CR_EXIDVALID BIT(10)
+#define ARM_SMMU_S2CR_CBNDX GENMASK(7, 0)
+
+#define VMID_UNUSED 0xff
+
+struct qcom_smmu_priv {
+	phys_addr_t base;
+	struct list_head devices;
+	struct udevice *dev;
+
+	/* Read-once config */
+	int num_cb;
+	int num_smr;
+	u32 pgshift;
+	u32 cb_pg_offset;
+};
+
+struct mmu_dev {
+	struct list_head li;
+	struct udevice *dev;
+	u16 sid;
+	u16 cbx;
+	u16 smr;
+};
+
+#define page_addr(priv, page) ((priv)->base + ((page) << (priv)->pgshift))
+
+#define smmu_readl(priv, page, offset) readl(page_addr(priv, page) + offset)
+#define gr0_readl(priv, offset) smmu_readl(priv, ARM_SMMU_GR0, offset)
+#define gr1_readl(priv, offset) smmu_readl(priv, ARM_SMMU_GR1, offset)
+#define cbx_readl(priv, cbx, offset) \
+	smmu_readl(priv, (priv->cb_pg_offset) + cbx, offset)
+
+#define smmu_writel(priv, page, offset, value) \
+	writel((value), page_addr(priv, page) + offset)
+#define gr0_writel(priv, offset, value) \
+	smmu_writel(priv, ARM_SMMU_GR0, offset, (value))
+#define gr1_writel(priv, offset, value) \
+	smmu_writel(priv, ARM_SMMU_GR1, offset, (value))
+#define cbx_writel(priv, cbx, offset, value) \
+	smmu_writel(priv, (priv->cb_pg_offset) + cbx, offset, value)
+
+#define gr1_setbits(priv, offset, value) \
+	gr1_writel(priv, offset, gr1_readl(priv, offset) | (value))
+
+static int get_stream_id(struct udevice *dev)
+{
+	ofnode node = dev_ofnode(dev);
+	struct ofnode_phandle_args args;
+	int count = ofnode_parse_phandle_with_args(node, "iommus",
+						   "#iommu-cells", 0, 0, &args);
+
+	if (count < 0 || args.args[0] == 0) {
+		printf("Error: %s: iommus property not found or wrong number of cells\n",
+		       __func__);
+		return -EINVAL;
+	}
+
+	return args.args[0]; // Some mask from bit 16 onward?
+}
+
+static struct mmu_dev *alloc_dev(struct udevice *dev)
+{
+	struct qcom_smmu_priv *priv = dev_get_priv(dev->iommu);
+	struct mmu_dev *mmu_dev;
+	int sid;
+
+	sid = get_stream_id(dev);
+	debug("%s %s has SID %#x\n", dev->iommu->name, dev->name, sid);
+	if (sid < 0 || sid > 0xffff) {
+		printf("\tSMMU: Invalid stream ID for %s\n", dev->name);
+		return ERR_PTR(-EINVAL);
+	}
+
+	/* We only support a single SID per device for now */
+	list_for_each_entry(mmu_dev, &priv->devices, li) {
+		if (mmu_dev->sid == sid)
+			return ERR_PTR(-EEXIST);
+	}
+
+	mmu_dev = calloc(sizeof(*mmu_dev), 1);
+	if (!mmu_dev)
+		return ERR_PTR(-ENOMEM);
+
+	mmu_dev->dev = dev;
+	mmu_dev->sid = sid;
+
+	list_add_tail(&mmu_dev->li, &priv->devices);
+
+	return mmu_dev;
+}
+
+/* Find and init the first free context bank */
+static int alloc_cb(struct qcom_smmu_priv *priv)
+{
+	u32 cbar, type, vmid, val;
+
+	for (int i = 0; i < priv->num_cb; i++) {
+		cbar = gr1_readl(priv, ARM_SMMU_GR1_CBAR(i));
+		type = FIELD_GET(ARM_SMMU_CBAR_TYPE, cbar);
+		vmid = FIELD_GET(ARM_SMMU_CBAR_VMID, cbar);
+
+		/* Check that the context bank is available. We haven't reset the SMMU so
+		 * we just make a best guess.
+		 */
+		if (type != CBAR_TYPE_S2_TRANS &&
+		    (type != CBAR_TYPE_S1_TRANS_S2_BYPASS ||
+		     vmid != VMID_UNUSED))
+			continue;
+
+		debug("%s: Found free context bank %d (cbar %#x)\n",
+		      priv->dev->name, i, cbar);
+		type = CBAR_TYPE_S1_TRANS_S2_BYPASS;
+		vmid = 0;
+		cbar &= ~ARM_SMMU_CBAR_TYPE & ~ARM_SMMU_CBAR_VMID;
+		cbar |= FIELD_PREP(ARM_SMMU_CBAR_TYPE, type) |
+			FIELD_PREP(ARM_SMMU_CBAR_VMID, vmid);
+		gr1_writel(priv, ARM_SMMU_GR1_CBAR(i), cbar);
+
+		val = IS_ENABLED(CONFIG_ARM64) == 1 ? ARM_SMMU_CBA2R_VA64 : 0;
+		gr1_setbits(priv, ARM_SMMU_GR1_CBA2R(i), val);
+		return i;
+	}
+
+	return -1;
+}
+
+/* Search for a context bank that is already configured for this stream
+ * returns the context bank index or -ENOENT
+ */
+static int find_smr(struct qcom_smmu_priv *priv, u16 stream_id)
+{
+	u32 val;
+	int i;
+
+	for (i = 0; i < priv->num_smr; i++) {
+		val = gr0_readl(priv, ARM_SMMU_GR0_SMR(i));
+		if (!(val & ARM_SMMU_SMR_VALID) ||
+		    FIELD_GET(ARM_SMMU_SMR_ID, val) != stream_id)
+			continue;
+
+		return i;
+	}
+
+	return -ENOENT;
+}
+
+static int configure_smr_s2cr(struct qcom_smmu_priv *priv, struct mmu_dev *mdev)
+{
+	u32 val;
+	int i;
+
+	for (i = 0; i < priv->num_smr; i++) {
+		/* Configure SMR */
+		val = gr0_readl(priv, ARM_SMMU_GR0_SMR(i));
+		if (val & ARM_SMMU_SMR_VALID)
+			continue;
+
+		val = mdev->sid | ARM_SMMU_SMR_VALID;
+		gr0_writel(priv, ARM_SMMU_GR0_SMR(i), val);
+
+		/*
+		 * WARNING: Don't change this to use S2CR_TYPE_BYPASS!
+		 * Some Qualcomm boards have angry hypervisor firmware
+		 * that converts S2CR type BYPASS to type FAULT on write.
+		 * We don't use virtual addressing for these boards in
+		 * u-boot so we can get away with using S2CR_TYPE_TRANS
+		 * instead
+		 */
+		val = FIELD_PREP(ARM_SMMU_S2CR_TYPE, S2CR_TYPE_TRANS) |
+		      FIELD_PREP(ARM_SMMU_S2CR_CBNDX, mdev->cbx);
+		gr0_writel(priv, ARM_SMMU_GR0_S2CR(i), val);
+
+		mdev->smr = i;
+		break;
+	}
+
+	/* Make sure our writes went through */
+	mb();
+
+	return 0;
+}
+
+static int qcom_smmu_connect(struct udevice *dev)
+{
+	struct mmu_dev *mdev;
+	struct qcom_smmu_priv *priv;
+	int ret;
+
+	debug("%s: %s -> %s\n", __func__, dev->name, dev->iommu->name);
+
+	priv = dev_get_priv(dev->iommu);
+	if (WARN_ON(!priv))
+		return -EINVAL;
+
+	mdev = alloc_dev(dev);
+	if (IS_ERR(mdev) && PTR_ERR(mdev) != -EEXIST) {
+		printf("%s: %s Couldn't create mmu context\n", __func__,
+		       dev->name);
+		return PTR_ERR(mdev);
+	} else if (IS_ERR(mdev)) { // -EEXIST
+		return 0;
+	}
+
+	if (find_smr(priv, mdev->sid) >= 0) {
+		debug("Found existing context bank for %s, skipping init\n",
+		      dev->name);
+		return 0;
+	}
+
+	ret = alloc_cb(priv);
+	if (ret < 0 || ret > 0xff) {
+		printf("Error: %s: failed to allocate context bank for %s\n",
+		       __func__, dev->name);
+		return 0;
+	}
+	mdev->cbx = ret;
+
+	/* Configure context bank registers */
+	cbx_writel(priv, mdev->cbx, ARM_SMMU_CB_TTBR0, 0x0);
+	cbx_writel(priv, mdev->cbx, ARM_SMMU_CB_TTBR1, 0x0);
+	cbx_writel(priv, mdev->cbx, ARM_SMMU_CB_S1_MAIR0, 0x0);
+	cbx_writel(priv, mdev->cbx, ARM_SMMU_CB_S1_MAIR1, 0x0);
+	cbx_writel(priv, mdev->cbx, ARM_SMMU_CB_SCTLR,
+		   ARM_SMMU_SCTLR_CFIE | ARM_SMMU_SCTLR_CFRE |
+			   ARM_SMMU_SCTLR_CFCFG);
+	cbx_writel(priv, mdev->cbx, ARM_SMMU_CB_TCR, 0x0);
+
+	/* Ensure that our writes went through */
+	mb();
+
+	configure_smr_s2cr(priv, mdev);
+
+	return 0;
+}
+
+#ifdef DEBUG
+static inline void dump_boot_mappings(struct arm_smmu_priv *priv)
+{
+	u32 val;
+	int i;
+
+	debug("  SMMU dump boot mappings:\n");
+	for (i = 0; i < priv->num_smr; i++) {
+		val = gr0_readl(priv, ARM_SMMU_GR0_SMR(i));
+		if (val & ARM_SMMU_SMR_VALID)
+			debug("\tSMR %3d: SID: %#lx\n", i,
+			      FIELD_GET(ARM_SMMU_SMR_ID, val));
+	}
+}
+#else
+#define dump_boot_mappings(priv) \
+	do {                     \
+	} while (0)
+#endif
+
+static int qcom_smmu_probe(struct udevice *dev)
+{
+	struct qcom_smmu_priv *priv;
+	u32 val;
+
+	priv = dev_get_priv(dev);
+	priv->dev = dev;
+	priv->base = dev_read_addr(dev);
+	INIT_LIST_HEAD(&priv->devices);
+
+	/* Read SMMU config */
+	val = gr0_readl(priv, ARM_SMMU_GR0_ID0);
+	priv->num_smr = FIELD_GET(ARM_SMMU_ID0_NUMSMRG, val);
+
+	val = gr0_readl(priv, ARM_SMMU_GR0_ID1);
+	priv->num_cb = FIELD_GET(ARM_SMMU_ID1_NUMCB, val);
+	priv->pgshift = FIELD_GET(ARM_SMMU_ID1_PAGESIZE, val) ? 16 : 12;
+	priv->cb_pg_offset = 1
+			     << (FIELD_GET(ARM_SMMU_ID1_NUMPAGENDXB, val) + 1);
+
+	dump_boot_mappings(priv);
+
+	return 0;
+}
+
+static int qcom_smmu_remove(struct udevice *dev)
+{
+	(void)dev;
+	/*
+	 * We should probably try and de-configure things here,
+	 * however I'm yet to find a way to do it without crashing
+	 * and it seems like Linux doesn't care at all anyway.
+	 */
+
+	return 0;
+}
+
+static struct iommu_ops qcom_smmu_ops = {
+	.connect = qcom_smmu_connect,
+};
+
+static const struct udevice_id qcom_smmu500_ids[] = {
+	{ .compatible = "qcom,sdm845-smmu-500" },
+	{ /* sentinel */ }
+};
+
+U_BOOT_DRIVER(qcom_smmu500) = {
+	.name = "qcom_smmu500",
+	.id = UCLASS_IOMMU,
+	.of_match = qcom_smmu500_ids,
+	.priv_auto = sizeof(struct qcom_smmu_priv),
+	.ops = &qcom_smmu_ops,
+	.probe = qcom_smmu_probe,
+	.remove = qcom_smmu_remove,
+	.flags = DM_FLAG_OS_PREPARE,
+};

-- 
2.42.1

