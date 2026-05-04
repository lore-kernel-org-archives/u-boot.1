Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCD5EFF885A
	for <u-boot@archiver.kernel.org>; Mon,  4 May 2026 18:57:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0E6E8846A1;
	Mon,  4 May 2026 20:57:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="tvZjaQAN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E51F28469A; Mon,  4 May 2026 20:57:42 +0200 (CEST)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D572F8467F
 for <u-boot@lists.denx.de>; Mon,  4 May 2026 20:57:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-488b3f8fa2bso50009985e9.1
 for <u-boot@lists.denx.de>; Mon, 04 May 2026 11:57:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777921059; x=1778525859; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=tqaJQumYz8wnuv5jUZJCrb8zomnG6PJVA0VE+J2E4oQ=;
 b=tvZjaQANTroCg5nap18pz6D+JfmS8GlkfiyEMKAzgswqLkzF39049LI74gsnaDtbsL
 0dILKdVFpfKIpj6zOAQni7PHkkrjAEbQ+x4fcaFUxSmrWlu2bXMgx3mxj+vQRIEmRnRW
 p11oU6/a1RRIxiaDzIyFz7JLfH4FiLi7+TPQcDbM/MlX3PGCpvoBUwSeu0YULRsyIUsU
 JhIvwHlNCqybJwFpgD5PNwV+H375xi6Artkih0PfKeV3nQ1Xuf08LNLAkkhCmdva9zVw
 BY9o+WZK+MELGCds5E6CzuZUQL/y3fmfigkIwUG6HcdcIhL3LsrTtxR92zyMiD4cY547
 U4XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777921059; x=1778525859;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=tqaJQumYz8wnuv5jUZJCrb8zomnG6PJVA0VE+J2E4oQ=;
 b=VScoGDTTLcT4arPaa+aJTXXDOLuJpZYG5Ki9Ft5bjzDpNisYAVn2W8WWcn8uGCxig1
 R0yXAV8arm0uizEdFXX6I5T+5Cr4tWCFvgVkBvk/FVkb2ZKf2vvbQeTCOigOVqH9Ojo3
 BLSrb6cvFB+ojIBAbHonjgwXSvGrlXj0klIDz6GvsqbTKQhWFxdkZb7DP9W3zjGbY7ZA
 CRfBzLaHFMI9vpGwtSMZG410VbhZf7v+WHOhU1n1GSFLv3cmKF1+z6eclwRZ5adgPs+3
 DbL/rjwJ/VOiecllKKzC6XwWmyRP1r5IcmxI1lIDeiOnId48vqlV+B/smNQx3XRY/MIQ
 tO0g==
X-Gm-Message-State: AOJu0Yyyv6lObl2uKVtN70sRAsmy6FbRcGcPlRru0FpXeguqXBdPSmFg
 qkWuIFMP9P2sndcgE0Ze8skP+Lm3gF1FmIS6A9XNyfqksJgk6aRS2Ad5fGPAVoSuLtU=
X-Gm-Gg: AeBDietQqDCNSvq8CcS2kh5aXCnQ8zm3xnwg/SxpkjETSi2ldoNhvcDWbxJ/kirgExC
 7QCQDLhnwDGQ3lAgEyrv4ZDVqr34h2U7wr6e07g2UfFsWl1aTUb8ZzO0W44j/xZhcZlW6QCJb/W
 OytjJQMu6lqcELYGQuunRm6KUjF2Ph5XQTn6eITunhBJYMNMLwl1GammCv1SGwNR4JWSpOrKhN0
 4Qu1QNSCRj0O+CkYT/GvhFA5C+/+Vkc6nI/9KymXw1u52kCSOCm2+KQE1jSF7tcRnVBiAS7sT0z
 WG1ClYi2oZt1LnghE06pQh61onvt0p6TLdganCqsWhuQ6uELSGlabHcXrbG8jkms5Ubf7sBzFAs
 E1ihBzJZVRaX8UCPApuYOI/FjyfT/PLrwqsJHIhPwJkTUQ5U3QA/imzkF4ot6rZQhzZcrAYKDlF
 Fn8x0seDWNbLGSc+Q2Q0NnIPowpEoV2+y3PCf5nSLsr9h5lZdRTo64elThYHdXWLEGV6/GCwDQS
 ji0xuo=
X-Received: by 2002:a05:600c:2d07:b0:489:1927:5c0 with SMTP id
 5b1f17b1804b1-48d155750ffmr1240475e9.0.1777921058986; 
 Mon, 04 May 2026 11:57:38 -0700 (PDT)
Received: from lion.localdomain (p4fc3dd86.dip0.t-ipconnect.de.
 [79.195.221.134]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4500f9c2cd5sm2861f8f.23.2026.05.04.11.57.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 May 2026 11:57:38 -0700 (PDT)
From: Casey Connolly <casey.connolly@linaro.org>
Date: Mon, 04 May 2026 20:57:29 +0200
Subject: [PATCH v2 01/15] Revert "dm: SMEM (Shared memory) uclass"
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260504-b4-modernise-smem-v2-1-c01ec2ff3886@linaro.org>
References: <20260504-b4-modernise-smem-v2-0-c01ec2ff3886@linaro.org>
In-Reply-To: <20260504-b4-modernise-smem-v2-0-c01ec2ff3886@linaro.org>
To: u-boot@lists.denx.de, Sumit Garg <sumit.garg@kernel.org>, 
 u-boot-qcom@groups.io
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Casey Connolly <casey.connolly@linaro.org>, Peng Fan <peng.fan@nxp.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Alice Guo <alice.guo@nxp.com>, Quentin Schulz <quentin.schulz@cherry.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Kuan-Wei Chiu <visitorckw@gmail.com>, 
 Raymond Mao <raymond.mao@riscstar.com>, 
 Stefan Roese <stefan.roese@mailbox.org>, 
 Philip Molloy <philip.molloy@analog.com>, 
 Jerome Forissier <jerome.forissier@arm.com>, 
 Marek Vasut <marek.vasut@mailbox.org>, 
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>, 
 Rasmus Villemoes <ravi@prevas.dk>, Heiko Schocher <hs@nabladev.com>, 
 Michal Simek <michal.simek@amd.com>, Sughosh Ganu <sughosh.ganu@arm.com>, 
 Antony Kurniawan Soemardi <linux@smankusors.com>, 
 Luca Weiss <luca.weiss@fairphone.com>, 
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=8369;
 i=casey.connolly@linaro.org; h=from:subject:message-id;
 bh=olv9NbJFOeIp2YC79K4GzBmH+NEncQMQAFB9kWGAsNI=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhswfb+Ss58w5FCricXE7/zJT85ddu5bGVdSlZL7ZqpG8/
 m2X2Q62jlIWBkEOBlkxRRbxE8ssm9ZettfYvuACzBxWJpAhDFycAjCR/h0M/5QyapckFq8ydwwv
 T+x00Ep5cvqLzomsGXMKWpwY5f9MkGH4p8Lq//fxrq0PTrI+1ORYZay/xNwzhqX73ESvOXnn7tz
 bsB4A
X-Developer-Key: i=casey.connolly@linaro.org; a=openpgp;
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

SMEM is a highly Qualcomm specific interface, while having a dedicated
UCLASS for it offers a nice abstraction, for things like memory layout
parsing we need to use it before the driver model is available.

Therefore, it doesn't make sense to fit SMEM into the driver model.
Instead let's adopt a model closer to Linux, and parse SMEM really early
during boot (as soon as we have the FDT).

This reverts commit 7b384eccc785b596f68448b155cbda26df57fb23.

Signed-off-by: Casey Connolly <casey.connolly@linaro.org>
---
 arch/arm/Kconfig           |  1 -
 drivers/Kconfig            |  2 --
 drivers/Makefile           |  1 -
 drivers/smem/Kconfig       | 25 -------------
 drivers/smem/Makefile      |  7 ----
 drivers/smem/smem-uclass.c | 46 ------------------------
 include/dm/uclass-id.h     |  1 -
 include/smem.h             | 90 ----------------------------------------------
 8 files changed, 173 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index f624675eadf8..dadb18e0b8cd 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1141,9 +1141,8 @@ config ARCH_SNAPDRAGON
 	select POWER_DOMAIN
 	select GPIO_EXTRA_HEADER
 	select MSM_SMEM
 	select OF_CONTROL
-	select SMEM
 	select SPMI
 	select BOARD_LATE_INIT
 	select OF_BOARD
 	select SAVE_PREV_BL_FDT_ADDR if !ENABLE_ARM_SOC_BOOT0_HOOK
diff --git a/drivers/Kconfig b/drivers/Kconfig
index 47606ddc6c8b..aa293df37c57 100644
--- a/drivers/Kconfig
+++ b/drivers/Kconfig
@@ -123,10 +123,8 @@ source "drivers/scsi/Kconfig"
 source "drivers/serial/Kconfig"
 
 source "drivers/sm/Kconfig"
 
-source "drivers/smem/Kconfig"
-
 source "drivers/sound/Kconfig"
 
 source "drivers/soc/Kconfig"
 
diff --git a/drivers/Makefile b/drivers/Makefile
index 43d0ba332818..ca3e87ffb102 100644
--- a/drivers/Makefile
+++ b/drivers/Makefile
@@ -118,9 +118,8 @@ obj-y += pwm/
 obj-y += reset/
 obj-y += input/
 obj-y += iommu/
 # SOC specific infrastructure drivers.
-obj-y += smem/
 obj-y += thermal/
 obj-$(CONFIG_TEE) += tee/
 obj-$(CONFIG_ARM_FFA_TRANSPORT) += firmware/arm-ffa/
 obj-y += axi/
diff --git a/drivers/smem/Kconfig b/drivers/smem/Kconfig
deleted file mode 100644
index e5d7dcc81b17..000000000000
--- a/drivers/smem/Kconfig
+++ /dev/null
@@ -1,25 +0,0 @@
-menuconfig SMEM
-	bool  "SMEM (Shared Memory mamanger) support"
-
-if SMEM
-
-config SANDBOX_SMEM
-    bool "Sandbox Shared Memory Manager (SMEM)"
-    depends on SANDBOX && DM
-    help
-      enable SMEM support for sandbox. This is an emulation of a real SMEM
-      manager.
-      The sandbox driver allocates a shared memory from the heap and
-      initialzies it on start.
-
-config MSM_SMEM
-    bool "Qualcomm Shared Memory Manager (SMEM)"
-    depends on DM
-    depends on ARCH_SNAPDRAGON || ARCH_IPQ40XX
-    select DEVRES
-    help
-      Enable support for the Qualcomm Shared Memory Manager.
-      The driver provides an interface to items in a heap shared among all
-      processors in a Qualcomm platform.
-
-endif # menu "SMEM Support"
diff --git a/drivers/smem/Makefile b/drivers/smem/Makefile
deleted file mode 100644
index af3e9b50883c..000000000000
--- a/drivers/smem/Makefile
+++ /dev/null
@@ -1,7 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0+
-#
-# Makefile for the U-Boot SMEM interface drivers
-
-obj-$(CONFIG_SANDBOX_SMEM) += sandbox_smem.o
-obj-$(CONFIG_SMEM) += smem-uclass.o
-obj-$(CONFIG_MSM_SMEM) += msm_smem.o
diff --git a/drivers/smem/smem-uclass.c b/drivers/smem/smem-uclass.c
deleted file mode 100644
index 4dea5cc4bf1c..000000000000
--- a/drivers/smem/smem-uclass.c
+++ /dev/null
@@ -1,46 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0+
-/*
- * Copyright (c) 2018 Ramon Fried <ramon.fried@gmail.com>
- */
-
-#define LOG_CATEGORY UCLASS_SMEM
-
-#include <dm.h>
-#include <smem.h>
-
-int smem_alloc(struct udevice *dev, unsigned int host,
-		unsigned int item, size_t size)
-{
-	struct smem_ops *ops = smem_get_ops(dev);
-
-	if (!ops->alloc)
-		return -ENOSYS;
-
-	return ops->alloc(host, item, size);
-}
-
-void *smem_get(struct udevice *dev, unsigned int host,
-		unsigned int item, size_t *size)
-{
-	struct smem_ops *ops = smem_get_ops(dev);
-
-	if (!ops->get)
-		return NULL;
-
-	return ops->get(host, item, size);
-}
-
-int smem_get_free_space(struct udevice *dev, unsigned int host)
-{
-	struct smem_ops *ops = smem_get_ops(dev);
-
-	if (!ops->get_free_space)
-		return -ENOSYS;
-
-	return ops->get_free_space(host);
-}
-
-UCLASS_DRIVER(smem) = {
-	.id     = UCLASS_SMEM,
-	.name       = "smem",
-};
diff --git a/include/dm/uclass-id.h b/include/dm/uclass-id.h
index 36b5d87c304f..fe0aae2720ca 100644
--- a/include/dm/uclass-id.h
+++ b/include/dm/uclass-id.h
@@ -133,9 +133,8 @@ enum uclass_id {
 	UCLASS_SCMI_BASE,	/* Interface for SCMI Base protocol */
 	UCLASS_SCSI,		/* SCSI device */
 	UCLASS_SERIAL,		/* Serial UART */
 	UCLASS_SIMPLE_BUS,	/* Bus with child devices */
-	UCLASS_SMEM,		/* Shared memory interface */
 	UCLASS_SOC,		/* SOC Device */
 	UCLASS_SOUND,		/* Playing simple sounds */
 	UCLASS_SPI,		/* SPI bus */
 	UCLASS_SPI_FLASH,	/* SPI flash */
diff --git a/include/smem.h b/include/smem.h
deleted file mode 100644
index b19c534ebc43..000000000000
--- a/include/smem.h
+++ /dev/null
@@ -1,90 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0+ */
-/*
- * The shared memory system is an allocate-only heap structure that
- * consists of one of more memory areas that can be accessed by the processors
- * in the SoC.
- *
- * Allocation can be done globally for all processors or to an individual processor.
- * This is controlled by the @host parameter.
- *
- * Allocation and management of heap can be implemented in various ways,
- * The @item parameter should be used as an index/hash to the memory region.
- *
- * Copyright (c) 2018 Ramon Fried <ramon.fried@gmail.com>
- */
-
-#ifndef _smemh_
-#define _smemh_
-
-/* struct smem_ops: Operations for the SMEM uclass */
-struct smem_ops {
-	/**
-	 * alloc() - allocate space for a smem item
-	 *
-	 * @host:	remote processor id, or -1 for all processors.
-	 * @item:	smem item handle
-	 * @size:	number of bytes to be allocated
-	 * @return 0 if OK, -ve on error
-	 */
-	int (*alloc)(unsigned int host,
-		unsigned int item, size_t size);
-
-	/**
-	 * get() - Resolve ptr of size of a smem item
-	 *
-	 * @host:	the remote processor, of -1 for all processors.
-	 * @item:	smem item handle
-	 * @size:	pointer to be filled out with the size of the item
-	 * @return	pointer on success, NULL on error
-	 */
-	void *(*get)(unsigned int host,
-		unsigned int item, size_t *size);
-
-	/**
-	 * get_free_space() - Get free space in smem in bytes
-	 *
-	 * @host:   the remote processor identifying a partition, or -1
-	 *			for all processors.
-	 * @return	free space, -ve on error
-	 */
-	int (*get_free_space)(unsigned int host);
-};
-
-#define smem_get_ops(dev)	((struct smem_ops *)(dev)->driver->ops)
-
-/**
- * smem_alloc() - allocate space for a smem item
- * @host:	remote processor id, or -1
- * @item:	smem item handle
- * @size:	number of bytes to be allocated
- * Return: 0 if OK, -ve on error
- *
- * Allocate space for a given smem item of size @size, given that the item is
- * not yet allocated.
- */
-int smem_alloc(struct udevice *dev, unsigned int host, unsigned int item, size_t size);
-
-/**
- * smem_get() - resolve ptr of size of a smem item
- * @host:	the remote processor, or -1 for all processors.
- * @item:	smem item handle
- * @size:	pointer to be filled out with size of the item
- * Return:	pointer on success, NULL on error
- *
- * Looks up smem item and returns pointer to it. Size of smem
- * item is returned in @size.
- */
-void *smem_get(struct udevice *dev, unsigned int host, unsigned int item, size_t *size);
-
-/**
- * smem_get_free_space() - retrieve amount of free space in a partition
- * @host:	the remote processor identifying a partition, or -1
- *			for all processors.
- * Return:	size in bytes, -ve on error
- *
- * To be used by smem clients as a quick way to determine if any new
- * allocations has been made.
- */
-int smem_get_free_space(struct udevice *dev, unsigned int host);
-
-#endif /* _smem_h_ */

-- 
2.53.0

