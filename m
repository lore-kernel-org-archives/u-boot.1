Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C152DD75E34
	for <u-boot@archiver.kernel.org>; Sun, 24 Nov 2024 19:18:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E5B59896A0;
	Sun, 24 Nov 2024 20:17:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="C25RpgA6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 63EB989580; Sun, 24 Nov 2024 20:17:50 +0100 (CET)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com
 [IPv6:2a00:1450:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3355A8953A
 for <u-boot@lists.denx.de>; Sun, 24 Nov 2024 20:17:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-aa52bb7beceso208163066b.3
 for <u-boot@lists.denx.de>; Sun, 24 Nov 2024 11:17:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732475868; x=1733080668; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=brqqZKykrMuZoa1LdNYB8vuSNcJr6464qwcR4yIsGyw=;
 b=C25RpgA6whGMq1I3MEA8TboI3s85oNqg4XSTlqEqD52p94zo48fSoaYNdW7wjlq+xU
 paEckPH4h6iZDhPWOrfzXwb9hnTInqeCEQ1ZXutcCfBTqfU3TpBlikE0Ils0MgJUKA3R
 PuXbx+/zVt8GxpjGmmXsHmbbrb5USyOiehYf1BJYyqx5ffcATUEItHsGKl96EB+k71mK
 hCDZzzH5wTzHHJ6X3vgNH7HF9xDbChBBOGgEmOST1/fppRZOvZeEInAsOkmFQLQCkeOl
 Nz47VLUmjJe0Ih1YJlyW2fMNeGpClpPbE4Rh7ot/aQZGatBkrhd4KR6VKKXZwsveCJ1D
 bsPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732475868; x=1733080668;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=brqqZKykrMuZoa1LdNYB8vuSNcJr6464qwcR4yIsGyw=;
 b=t1GHqfF6h9lSitOgh4CIId/Z7gp3te3LPA4MPR6rkUtpPYyOTuPdfqah6WljXjVC8d
 w8HSGeiXTkrVk2Rv4FP7gpuPFvI7Cz6ziH8o/DTkqse6VsCyv8RFyCROQ4sgynXLr4YF
 LCBQSGF7YztUo133R5lw3PYkPozmHBTM87AVSJgCZxiRKUqwmNHurJ5yndWEFl+6aYGZ
 vSTWPTx0PrqM90wHR/5Vt11srpCncyXqIVe5cY8pjLV1cxNzT2OySCkoI21hJgxxXW7N
 1J5AOE/BNLlGB+dmFpD/6WyVtEALDdawHe/1yqUTGmBWHcBtMzEKJxuZVrA14XdLVa5L
 cnYw==
X-Gm-Message-State: AOJu0YwJR2SUmvD09SoOODLyMTLhkjL5gQfy0ynDTnHU7tZuPSdi7a58
 1PdMFcPLh4RJxsWIy4/AGuUStPCh2hn83UzP29AcM/IfwivWcjWUxjW+w8rMPDTmUrC+WM+RxW1
 fnjU=
X-Gm-Gg: ASbGncvv7ced7n+N85g6sjQdA5bBnD55jYkmddoHnoIlqyrtzO/9eR8h4CWkYQnI8u6
 dG+tj0S2XRCnCtld776J3NIQLkxe9TQBldvCKAKjNF5PkLc13Nkx7ieKlKblPpuTghttfjk5/xD
 pohHqOvOeDuG4jA7NVUDKSNLKzD4ECWQRHts4g5wAu3YZiBgorNN4n7bzDZp9VnboPu9yXuTm3A
 8gyMtTZYPXaL3jCEvqSa2tOrCn89pf3ojTQsx8oa2xJ+Dq0rROsTmSJVsCP4Ab9Pdwj
X-Google-Smtp-Source: AGHT+IGV46rZjpG8+r6rZSZDOZSr0BxN+Fx2x7zDtPE2Jl+MAObsLYNen6G3Og013OIIz5aZHVDy8w==
X-Received: by 2002:a17:906:3caa:b0:aa5:451c:ce1e with SMTP id
 a640c23a62f3a-aa5451cd0cemr303962066b.32.1732475867648; 
 Sun, 24 Nov 2024 11:17:47 -0800 (PST)
Received: from lion.localdomain ([2a02:8109:888d:ff00:ca7f:54ff:fe52:4519])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aa50b28f848sm371874566b.36.2024.11.24.11.17.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 24 Nov 2024 11:17:47 -0800 (PST)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Sun, 24 Nov 2024 20:17:43 +0100
Subject: [PATCH 01/15] Revert "dm: SMEM (Shared memory) uclass"
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241124-b4-modernise-smem-v1-1-b7852c11b67c@linaro.org>
References: <20241124-b4-modernise-smem-v1-0-b7852c11b67c@linaro.org>
In-Reply-To: <20241124-b4-modernise-smem-v1-0-b7852c11b67c@linaro.org>
To: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>, 
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>, Mario Six <mario.six@gdsys.cc>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=8318;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=gP75Ots5RFaUWiObk7tC3qWRGvUFUcSl3q31p9RYwy8=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhnTn6huTD/96kTRFu/j7tECndc6NrOWPJUR+HlBVM0wqL
 XsXtUqko5SFQZCDQVZMkUX8xDLLprWX7TW2L7gAM4eVCWQIAxenAExE+wHD/9htZirfpS/lTlty
 +fYbtsOrngQ/3aJst/J94onWZte4VE6Gf0Zzv8+JvjWDzbJsYmZYX8v/j12hkpOXup5/oRvuZal
 i2wEA
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

SMEM is a highly Qualcomm specific interface, while having a dedicated
UCLASS for it offers a nice abstraction, for things like memory layout
parsing we need to use it before the driver model is available.

Therefore, it doesn't make sense to fit SMEM into the driver model.
Instead let's adopt a model closer to Linux, and parse SMEM really early
during boot (as soon as we have the FDT).

This reverts commit 7b384eccc785b596f68448b155cbda26df57fb23.

Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 arch/arm/Kconfig           |  1 -
 drivers/Kconfig            |  2 --
 drivers/Makefile           |  1 -
 drivers/smem/Kconfig       | 24 -------------
 drivers/smem/Makefile      |  7 ----
 drivers/smem/smem-uclass.c | 46 ------------------------
 include/dm/uclass-id.h     |  1 -
 include/smem.h             | 90 ----------------------------------------------
 8 files changed, 172 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 7282c4123b08..dc44ea1e6c9f 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1091,9 +1091,8 @@ config ARCH_SNAPDRAGON
 	select GPIO_EXTRA_HEADER
 	select MSM_SMEM
 	select OF_CONTROL
 	select OF_SEPARATE
-	select SMEM
 	select SPMI
 	select BOARD_LATE_INIT
 	select OF_BOARD
 	select SAVE_PREV_BL_FDT_ADDR
diff --git a/drivers/Kconfig b/drivers/Kconfig
index a073230c26dd..6dbbc3172076 100644
--- a/drivers/Kconfig
+++ b/drivers/Kconfig
@@ -119,10 +119,8 @@ source "drivers/scsi/Kconfig"
 source "drivers/serial/Kconfig"
 
 source "drivers/sm/Kconfig"
 
-source "drivers/smem/Kconfig"
-
 source "drivers/sound/Kconfig"
 
 source "drivers/soc/Kconfig"
 
diff --git a/drivers/Makefile b/drivers/Makefile
index 9440af1b09bc..385ea3b7918b 100644
--- a/drivers/Makefile
+++ b/drivers/Makefile
@@ -113,9 +113,8 @@ obj-y += pwm/
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
index 73d51b3a7a48..000000000000
--- a/drivers/smem/Kconfig
+++ /dev/null
@@ -1,24 +0,0 @@
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
index 270088ad94f7..281abe99acf1 100644
--- a/include/dm/uclass-id.h
+++ b/include/dm/uclass-id.h
@@ -128,9 +128,8 @@ enum uclass_id {
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
2.47.0

