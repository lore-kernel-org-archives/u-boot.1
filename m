Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7815CD98F2
	for <u-boot@archiver.kernel.org>; Thu, 18 Jun 2026 11:57:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 02A7B847C3;
	Thu, 18 Jun 2026 13:57:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="AcZygZH4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 05FDF84995; Thu, 18 Jun 2026 13:57:00 +0200 (CEST)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CE8D780287
 for <u-boot@lists.denx.de>; Thu, 18 Jun 2026 13:56:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-490c1915793so6582745e9.2
 for <u-boot@lists.denx.de>; Thu, 18 Jun 2026 04:56:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781783817; x=1782388617; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=5aQLbR86oCqyKVGd3/wgakBb8cfQvhvGfwVwGZ8LETg=;
 b=AcZygZH4ug43Gqr3mT7pFMs1ij4znBkzLVKCgiIyGR+9txiNCHI7o6tPuRrlbW5Mkj
 ctkrusPr3xCb2Mjd5mXgw5XPERBSqkqDBRMqjRsL+W4Pice7s6XnOMmadBZ5FuxY1V3+
 XVOuN58RlPR5E3AoNZ6pYpCrNttVgWSlDwVS5RPnVaEdzptTy2rf45RPHpS6d51VWhWD
 QT75pSmw4hOaffML28foKlhTzRvjsnjixw44OFtPIym1p0u3Kpy4nj24YmzFL0ROQ/Au
 odqyT6VFZVQyJrJO0sWcq+fE4C4RgCGZl7/uKXPSP/Q1s+Bg1SiaoyrR8rRunEp0pwYj
 n3JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781783817; x=1782388617;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=5aQLbR86oCqyKVGd3/wgakBb8cfQvhvGfwVwGZ8LETg=;
 b=fEZV2hK80vkDp/zS10NqClzmTuyboCKenX0zj8WX63yfbc5UJWYADSUBGnSGEI7LL7
 VDPvg15xwZf2nnv4xS9wLX3UxzJZ6IieQV6jdbmYTxlCcDljMDgr2yAjl+Uqs+ddEBch
 cgiAYrWFU2SzHGNj95RqdJ6majkKJxgajUWbwhXt2/4hkz5WmHMQuSNdYmn+iPijU+35
 vEPYM0qfJHpYkKy9TfARoPh02rWkz2nY0MD8yvLf4qbehXzDdhu9WHeWTU7Vl/nDcsuM
 7Gy31tlrIu8ISg7L9W8emmfPBw375FLP9+w8gaQtZhaZShQOyc1s/Nc4TsQKp8nndwqP
 n9fQ==
X-Gm-Message-State: AOJu0Yxc2uBGgJwmvnI67pkYTp7D8JA0vridIQcjPaaX0DoQT1fnvqym
 nzEPxG9IsYf7weydW8sWe6QY2A/WzUvYNb5w70Ytnr5SL/VSeZlaFHiSfsKCk0VsTj0=
X-Gm-Gg: AfdE7cmHCxNST2QB5bLWJScRElkT3cbULwZ6b+iR8DKY2NzhdoxTEze5eCfKApWJKDA
 jDaifCo4ibjs4OoYH8F6UflfqkrbLztQeT1fNGRqIFjFENq4ms+QI7fLO59Wp3A1nwCp/N0eZKS
 ph+l1YY+k4KwOXC7JYvgdmUTg4DLeD9ZZRswUm9qApXE1go92OSroMTQ9zTQGvKexRwq/9/dP5S
 4qbddIFn6Z31DJWUkwD6S+ZZHWcds/F+hqX4WOMtySphYEC2DuxvoeGN4RjrPnt9BqvsMfaFash
 uph3ahNCo0cDqhjuN6Na57vAjbt73zXAQ9DNwylnYU8dDKncjdYfTLE3HZP9RdNWStk8PSf/Ftn
 /9FdxjVnOS5zhiL9YG6cccCTr39S5C7opMoaT/Ktn11tFl0n3wFnTX2IlgN62qoV3ZhySi9uPMb
 dnZ7wvNmb3pHx4PFa45cuyPknBNUBCmBhfuFXHkuelknBHFQa4/Vx6PDk=
X-Received: by 2002:a05:600c:6089:b0:490:b8c0:d46a with SMTP id
 5b1f17b1804b1-4923412f185mr121188195e9.22.1781783817235; 
 Thu, 18 Jun 2026 04:56:57 -0700 (PDT)
Received: from lion.localdomain (p5b29e032.dip0.t-ipconnect.de. [91.41.224.50])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-46289c3b3a3sm14448355f8f.30.2026.06.18.04.56.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Jun 2026 04:56:56 -0700 (PDT)
From: Casey Connolly <casey.connolly@linaro.org>
Date: Thu, 18 Jun 2026 13:56:49 +0200
Subject: [PATCH v3 01/15] Revert "dm: SMEM (Shared memory) uclass"
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260618-b4-modernise-smem-v3-1-472391477988@linaro.org>
References: <20260618-b4-modernise-smem-v3-0-472391477988@linaro.org>
In-Reply-To: <20260618-b4-modernise-smem-v3-0-472391477988@linaro.org>
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
 bh=9FDuMPu13fZb3kHmJxYtXDf/mc6VQF3sWcLj1QBfniI=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhizjuyxf3dwX2PlNaGVUaa0OVPrBfOXdDmb5sOPM8vKnP
 7zvvb+jo5SFQZCDQVZMkUX8xDLLprWX7TW2L7gAM4eVCWQIAxenAEzkfTPDXxHOZrXLiVm8+jfd
 jYs/S3b5KbnFs7b0iT+M8FZfXXhtFsP/yPPeigel9P8/3BfRLnI2vUS/oE5Redb/6BmPLaP/KBm
 zAAA=
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
index 8047c5e1f879..d252514cca57 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1142,9 +1142,8 @@ config ARCH_SNAPDRAGON
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

