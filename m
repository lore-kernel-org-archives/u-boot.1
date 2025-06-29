Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5917EC7EE39
	for <u-boot@archiver.kernel.org>; Sun, 29 Jun 2025 11:02:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0E97882B20;
	Sun, 29 Jun 2025 13:02:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="A5l3I7Bp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 983E982F2B; Sun, 29 Jun 2025 13:02:22 +0200 (CEST)
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com
 [IPv6:2a00:1450:4864:20::12a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2B7B882E35
 for <u-boot@lists.denx.de>; Sun, 29 Jun 2025 13:02:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-lf1-x12a.google.com with SMTP id
 2adb3069b0e04-553b9eb2299so4119113e87.0
 for <u-boot@lists.denx.de>; Sun, 29 Jun 2025 04:02:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1751194937; x=1751799737; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nVwbUXI2eluqii4mNobUaoE79SE4kIXwA/cUqVujK6M=;
 b=A5l3I7BpYst5A88SL8bV+XdzCjiJlE52sZIOMOW7O0aB0C1OxsU00ql6tEJmNLTwYV
 Lqw55qO898uFxCT143tVAxmuOT3GBrFjuJ6hHOlR0bru7E/TFEHGdtH1lo9MnUzul+T1
 MrAxZLthXb82gQZneN+asIOAL8G765K8thPP99fER2X+L9bAP1JR80A4MMt595PUklXr
 eu+cRuYnkrxRqtJ5LU/o/Qk3xFLVt0/Mol0qqyO7o0uHJfVd+Y0EGQEuMFM+8WEkGIsd
 DjEhXe0G/qq5gWlhWjQAsEGWu+npFQ57tkSGH/Dmopy/zce1jHL34H1nOnnc66j31YB0
 13Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751194937; x=1751799737;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nVwbUXI2eluqii4mNobUaoE79SE4kIXwA/cUqVujK6M=;
 b=TMw33ubXJPx0N9B7Akg3QB93S2LwXHBokgEmDk8gi7+quqKaO6Vfw8KymLeSBRioMF
 +yuqK3idrf9kc2Rvcq4jEF9Ddp4e11u81JlHND/gGT3i2p403tw+rgY5lseHehjEbx57
 Oz7s/7e/OfI6p0+5GVPCMhlr79r7CahSn/9uLPHcSmVFR3+zHg0UD91CizZlb5T3sIYc
 vsuskCg4gQoI3olTZdW0TFO8nf5DjzodL/FZxwcwK9iKkFiICzoNIjvyE2hypYwLMmHC
 4AoTbnMFPiUJyY+aibn2i6LOGrpwTNcQIvTBPrLQodHgrZTfTBOb195JI70ejjhcghcf
 ZSqw==
X-Gm-Message-State: AOJu0YxdXFm40pyItulIt9G2fmDHnAmfPyJY7SANPhMzwBHnzbyaDkfW
 A9Ehroy2CXR3wzRK3IP44Whoo277S4lyRDqJu7bVLrJ8fVyCgJ5V/eFG
X-Gm-Gg: ASbGnctMy35a+GTARpCh8f3yKe+/c4NNZQcSzZWC3pUr16OYV/BJbeyJ/GhqyLPi96t
 iem0BvQlUIWB06OFo411wqFqp2SZpoBkRj4Rx/mMebuOneWQDs3ZTqR7eqAWIlr/chy8dVttZJw
 mo3+P0Nhdm/rS/LY1a/jLNBwEB6Yoku1AvSoweDMWhHFdNYCBCr2r4f6LRcwEGchBjEqJFC5fPh
 Dxa4HlpIy5zEfIOFLe+cVAoCAt/lQRmzG2hddEnf06NZZFJxByA/azPBXJ/WhmJYLp+wIt2gYjS
 d8OLYBW45GnS2zN89uqHKE12FPitT3LlekVh++EM+td/arBjBQOFhQ==
X-Google-Smtp-Source: AGHT+IF1GUe30G63Qm6Ht4OASB8HVo6+1TZhArjw6G+vGk2quj3DhrO2Q1aeUbX9JDyGEO49DNvniw==
X-Received: by 2002:ac2:51c7:0:b0:553:2760:e82c with SMTP id
 2adb3069b0e04-55502cd7c37mr4249602e87.25.1751194937099; 
 Sun, 29 Jun 2025 04:02:17 -0700 (PDT)
Received: from xeon.. ([188.163.112.61]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5550b24028esm1090621e87.19.2025.06.29.04.02.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 29 Jun 2025 04:02:16 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Thierry Reding <treding@nvidia.com>, Svyatoslav Ryhel <clamor95@gmail.com>,
 Tom Rini <trini@konsulko.com>, Ion Agorria <ion@agorria.com>,
 =?UTF-8?q?Jonas=20Schw=C3=B6bel?= <jonasschwoebel@yahoo.de>
Cc: u-boot@lists.denx.de
Subject: [PATCH v1 2/6] crypto: tegra: Add Tegra AES engine driver
Date: Sun, 29 Jun 2025 14:01:59 +0300
Message-ID: <20250629110203.25086-3-clamor95@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250629110203.25086-1-clamor95@gmail.com>
References: <20250629110203.25086-1-clamor95@gmail.com>
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

From: Ion Agorria <ion@agorria.com>

This driver allows using Tegra AES engines within BSEV and BSEA blocks to
encrypt and decrypt data using different AES algorithms.

One use case is allowing u-boot to self update by using the already loaded
AES key in the engine's SBK slot by the bootrom.

Particular care must be taken as chainloaded u-boot's may not have the SBK
slot loaded as the vendor bootloader erases it before leaving it.

Signed-off-by: Ion Agorria <ion@agorria.com>
---
 arch/arm/include/asm/arch-tegra/crypto.h |   2 +
 drivers/crypto/Kconfig                   |   2 +
 drivers/crypto/Makefile                  |   1 +
 drivers/crypto/tegra/Kconfig             |   7 +
 drivers/crypto/tegra/Makefile            |   3 +
 drivers/crypto/tegra/tegra_aes.c         | 591 +++++++++++++++++++++++
 6 files changed, 606 insertions(+)
 create mode 100644 drivers/crypto/tegra/Kconfig
 create mode 100644 drivers/crypto/tegra/Makefile
 create mode 100644 drivers/crypto/tegra/tegra_aes.c

diff --git a/arch/arm/include/asm/arch-tegra/crypto.h b/arch/arm/include/asm/arch-tegra/crypto.h
index 7646163b97b..73e8365a57d 100644
--- a/arch/arm/include/asm/arch-tegra/crypto.h
+++ b/arch/arm/include/asm/arch-tegra/crypto.h
@@ -7,6 +7,8 @@
 #ifndef _CRYPTO_H_
 #define _CRYPTO_H_
 
+#define TEGRA_AES_SLOT_SBK		0
+
 /**
  * Sign a block of data
  *
diff --git a/drivers/crypto/Kconfig b/drivers/crypto/Kconfig
index d26f87364f9..0d58e3910fe 100644
--- a/drivers/crypto/Kconfig
+++ b/drivers/crypto/Kconfig
@@ -10,4 +10,6 @@ source "drivers/crypto/aspeed/Kconfig"
 
 source "drivers/crypto/nuvoton/Kconfig"
 
+source "drivers/crypto/tegra/Kconfig"
+
 endmenu
diff --git a/drivers/crypto/Makefile b/drivers/crypto/Makefile
index 2bd99fc2763..e4a4482b7f3 100644
--- a/drivers/crypto/Makefile
+++ b/drivers/crypto/Makefile
@@ -10,3 +10,4 @@ obj-y += fsl/
 obj-y += hash/
 obj-y += aspeed/
 obj-y += nuvoton/
+obj-y += tegra/
diff --git a/drivers/crypto/tegra/Kconfig b/drivers/crypto/tegra/Kconfig
new file mode 100644
index 00000000000..b027609307b
--- /dev/null
+++ b/drivers/crypto/tegra/Kconfig
@@ -0,0 +1,7 @@
+config TEGRA_AES
+	bool "Support the Tegra AES"
+	depends on DM_AES
+	help
+	  This provides a means to encrypt and decrypt data using the Tegra
+	  Bit Stream Engine for Video/Audio. Also may provide a mean to
+	  encrypt/decrypt/sign using already loaded device SBK.
diff --git a/drivers/crypto/tegra/Makefile b/drivers/crypto/tegra/Makefile
new file mode 100644
index 00000000000..a118350fd11
--- /dev/null
+++ b/drivers/crypto/tegra/Makefile
@@ -0,0 +1,3 @@
+# SPDX-License-Identifier: GPL-2.0+
+
+obj-$(CONFIG_$(PHASE_)TEGRA_AES) += tegra_aes.o
diff --git a/drivers/crypto/tegra/tegra_aes.c b/drivers/crypto/tegra/tegra_aes.c
new file mode 100644
index 00000000000..7b374c757ba
--- /dev/null
+++ b/drivers/crypto/tegra/tegra_aes.c
@@ -0,0 +1,591 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Driver for NVIDIA Tegra AES hardware engine residing inside the Bit Stream Engine
+ * for Video (BSEV) hardware block and Bit Stream Engine for Audio (BSEA).
+ *
+ * The programming sequence for this engine is with the help of commands which travel
+ * via a command queue residing between the CPU and the BSEV/BSEA block.
+ *
+ * The hardware key table length is 64 bytes and each key slot divided as follows:
+ * 1. Key - 32 bytes
+ * 2. Original IV - 16 bytes
+ * 3. Updated IV - 16 bytes
+ *
+ * The engine has 4 slots in T20/T30 in which 0th contains SBK loaded by bootrom,
+ * vendor bootloaders tend to clear this slot so that anything booted after can't
+ * use the SBK. This is relevant for U-Boot's chainloaded from these vendor bootloaders.
+ *
+ * Copyright (c) 2010-2011, NVIDIA Corporation
+ * Copyright (c) 2025, Ion Agorria.
+ */
+
+#include <dm.h>
+#include <asm/io.h>
+#include <malloc.h>
+#include <time.h>
+#include <linux/delay.h>
+#include <clk.h>
+#include <reset.h>
+#include <uboot_aes.h>
+
+#include <asm/arch-tegra/crypto.h>
+#include <asm/arch-tegra/fuse.h>
+
+/* Make sure pointers will fit register size for AES engine */
+static_assert(sizeof(void *) == sizeof(u32));
+
+#define IRAM_BASE				0x40000000
+
+#define TEGRA_AES_DMA_BUFFER_SIZE		(0x4000 / AES_BLOCK_LENGTH)
+#define TEGRA_AES_HW_MAX_KEY_LENGTH		AES256_KEY_LENGTH
+#define TEGRA_AES_HW_TABLE_LENGTH		(TEGRA_AES_HW_MAX_KEY_LENGTH + AES_BLOCK_LENGTH * 2)
+#define TEGRA_AES_IRAM_MAX_ADDR			(IRAM_BASE | TEGRA_AES_KEYTABLEADDR_FIELD)
+
+#define TEGRA_AES_BUSY_TIMEOUT_MS		1000
+
+/* Registers */
+#define TEGRA_AES_ICMDQUE_WR			0x000
+#define TEGRA_AES_CMDQUE_CONTROL		0x008
+#define TEGRA_AES_INTR_STATUS			0x018
+#define TEGRA_AES_INT_ENB			0x040
+#define TEGRA_AES_BSE_CFG			0x044
+#define TEGRA_AES_IRAM_ACCESS_CFG		0x0a0
+#define TEGRA_AES_SECURE_DEST_ADDR		0x100
+#define TEGRA_AES_SECURE_INPUT_SELECT		0x104
+#define TEGRA_AES_SECURE_CONFIG			0x108
+#define TEGRA_AES_SECURE_CONFIG_EXT		0x10c
+
+/* Register field macros */
+#define TEGRA_AES_ENGINE_BUSY_FIELD		BIT(0)
+#define TEGRA_AES_ICQ_EMPTY_FIELD		BIT(3)
+#define TEGRA_AES_DMA_BUSY_FIELD		BIT(23)
+#define TEGRA_AES_SECURE_KEY_SCH_DIS_FIELD	BIT(15)
+#define TEGRA_AES_KEYTABLEADDR_FIELD		(BIT(17) - 1)
+#define TEGRA_AES_SECURE_KEY_INDEX_SHIFT	20
+#define TEGRA_AES_SECURE_KEY_INDEX_FIELD	(0x1f << TEGRA_AES_SECURE_KEY_INDEX_SHIFT)
+#define TEGRA_AES_SECURE_CTR_CNT_SHIFT		16
+#define TEGRA_AES_SECURE_CTR_CNT_FIELD		(0xffff << TEGRA_AES_SECURE_CTR_CNT_SHIFT)
+#define TEGRA_AES_BSE_MODE_FIELD		0x1f
+#define TEGRA_AES_BSE_LITTLE_ENDIAN_FIELD	BIT(10)
+#define TEGRA_AES_CMDQ_OPCODE_SHIFT		26
+#define TEGRA_AES_CMDQ_CTRL_ICMDQEN_FIELD	BIT(1)
+#define TEGRA_AES_CMDQ_CTRL_SRC_STM_SEL_FIELD	BIT(4)
+#define TEGRA_AES_CMDQ_CTRL_DST_STM_SEL_FIELD	BIT(5)
+#define TEGRA_AES_SECURE_INPUT_ALG_SEL_SHIFT	28
+#define TEGRA_AES_SECURE_INPUT_KEY_LEN_SHIFT	16
+#define TEGRA_AES_SECURE_INPUT_IV_FIELD		BIT(10)
+#define TEGRA_AES_SECURE_INPUT_HASH_ENB_FIELD	BIT(2)
+#define TEGRA_AES_SECURE_CORE_SEL_SHIFT		9
+#define TEGRA_AES_SECURE_VCTRAM_SEL_SHIFT	7
+#define TEGRA_AES_SECURE_XOR_POS_SHIFT		3
+#define TEGRA_AES_INT_ERROR_MASK		0x6ff000
+
+/* Commands for BSEV/BSEA */
+#define TEGRA_AES_CMD_BLKSTARTENGINE		0x0e
+#define TEGRA_AES_CMD_DMASETUP			0x10
+#define TEGRA_AES_CMD_DMACOMPLETE		0x11
+#define TEGRA_AES_CMD_SETTABLE			0x15
+
+/* Flags for mode */
+#define TEGRA_AES_MODE_ENCRYPT			BIT(0)
+#define TEGRA_AES_MODE_CBC			BIT(1)
+#define TEGRA_AES_MODE_UPDATE_IV		BIT(2)
+#define TEGRA_AES_MODE_HASH			BIT(3)
+
+struct tegra_aes_priv {
+	void *regs;
+	void *iram_addr;
+
+	struct reset_ctl reset_ctl;
+	struct reset_ctl reset_ctl_vde;
+
+	struct clk *clk;
+	struct clk *clk_parent;
+
+	u8 current_key_size;
+	bool sbk_available;
+};
+
+static bool tegra_aes_is_busy(struct tegra_aes_priv *priv, bool dma_wait)
+{
+	u32 value = readl(priv->regs + TEGRA_AES_INTR_STATUS);
+	bool engine_busy = value & TEGRA_AES_ENGINE_BUSY_FIELD;
+	bool non_empty_queue = !(value & TEGRA_AES_ICQ_EMPTY_FIELD);
+	bool dma_busy = dma_wait && (value & TEGRA_AES_DMA_BUSY_FIELD);
+
+	log_debug("%s - e:%d q:%d dma:%d\n", __func__, engine_busy, non_empty_queue, dma_busy);
+
+	return engine_busy || non_empty_queue || dma_busy;
+}
+
+static u32 tegra_aes_check_error(struct tegra_aes_priv *priv)
+{
+	u32 value = readl(priv->regs + TEGRA_AES_INTR_STATUS) & TEGRA_AES_INT_ERROR_MASK;
+
+	if (value) {
+		writel(TEGRA_AES_INT_ERROR_MASK, priv->regs + TEGRA_AES_INTR_STATUS);
+		log_debug("%s 0x%x\n", __func__, value);
+	}
+
+	return value;
+}
+
+static int tegra_aes_wait_for_idle_dma(struct tegra_aes_priv *priv, bool dma_wait)
+{
+	ulong start = get_timer(0);
+
+	while (tegra_aes_is_busy(priv, dma_wait)) {
+		if (get_timer(start) > TEGRA_AES_BUSY_TIMEOUT_MS) {
+			log_err("%s: TIMEOUT!!!\n", __func__);
+			break;
+		}
+		mdelay(5);
+	}
+
+	if (tegra_aes_check_error(priv))
+		return -1;
+
+	return 0;
+}
+
+static int tegra_aes_wait_for_idle(struct tegra_aes_priv *priv)
+{
+	return tegra_aes_wait_for_idle_dma(priv, 1);
+}
+
+static int tegra_aes_configure(struct tegra_aes_priv *priv)
+{
+	u32 value;
+
+	if (tegra_aes_wait_for_idle(priv))
+		return -1;
+
+	/* IRAM config */
+	writel(0, priv->regs + TEGRA_AES_IRAM_ACCESS_CFG);
+
+	/* Reset interrupts bits, or engine will hang on next operation */
+	writel(0xFFFFFFFF, priv->regs + TEGRA_AES_INTR_STATUS);
+
+	/* Set interrupts */
+	writel(0, priv->regs + TEGRA_AES_INT_ENB);
+
+	/* Configure CMDQUE */
+	value = readl(priv->regs + TEGRA_AES_CMDQUE_CONTROL);
+	value |= TEGRA_AES_CMDQ_CTRL_SRC_STM_SEL_FIELD |
+		 TEGRA_AES_CMDQ_CTRL_DST_STM_SEL_FIELD |
+		 TEGRA_AES_CMDQ_CTRL_ICMDQEN_FIELD;
+	writel(value, priv->regs + TEGRA_AES_CMDQUE_CONTROL);
+
+	value = readl(priv->regs + TEGRA_AES_SECURE_CONFIG_EXT);
+	value &= ~TEGRA_AES_SECURE_CTR_CNT_FIELD;
+	writel(value, priv->regs + TEGRA_AES_SECURE_CONFIG_EXT);
+
+	/* Configure BSE */
+	value = readl(priv->regs + TEGRA_AES_BSE_CFG);
+	value &= ~TEGRA_AES_BSE_MODE_FIELD;
+	value |= TEGRA_AES_BSE_LITTLE_ENDIAN_FIELD;
+	writel(value, priv->regs + TEGRA_AES_BSE_CFG);
+
+	return 0;
+}
+
+static int tegra_aes_select_key_slot(struct tegra_aes_priv *priv, u32 key_size, u8 slot)
+{
+	if (tegra_aes_wait_for_idle(priv))
+		return -1;
+
+	if (key_size < (AES128_KEY_LENGTH * 8) ||
+	    key_size > (TEGRA_AES_HW_MAX_KEY_LENGTH * 8))
+		return -EINVAL;
+
+	priv->current_key_size = key_size;
+
+	/* Select the key slot */
+	u32 value = readl(priv->regs + TEGRA_AES_SECURE_CONFIG);
+
+	value &= ~TEGRA_AES_SECURE_KEY_INDEX_FIELD;
+	value |= (slot << TEGRA_AES_SECURE_KEY_INDEX_SHIFT);
+	writel(value, priv->regs + TEGRA_AES_SECURE_CONFIG);
+
+	return 0;
+}
+
+static int tegra_aes_call_engine(struct tegra_aes_priv *priv, u8 *src, u8 *dst,
+				 u32 nblocks, u32 mode)
+{
+	u32 value;
+	const u32 ICMDQ_LENGTH = 4;
+	u32 cmdq[ICMDQ_LENGTH];
+
+	log_debug("%s: 0x%p -> 0x%p blocks %d mode 0x%x\n", __func__,
+		  src, dst, nblocks, mode);
+
+	if (!nblocks) {
+		log_warning("%s: called with 0 blocks!\n", __func__);
+		return -1;
+	}
+
+	if (tegra_aes_configure(priv))
+		return -1;
+
+	/* Configure Secure Input */
+	value = 1 << TEGRA_AES_SECURE_INPUT_ALG_SEL_SHIFT |
+		priv->current_key_size << TEGRA_AES_SECURE_INPUT_KEY_LEN_SHIFT;
+
+	if (mode & TEGRA_AES_MODE_UPDATE_IV)
+		value |= TEGRA_AES_SECURE_INPUT_IV_FIELD;
+	if (mode & TEGRA_AES_MODE_HASH)
+		value |= TEGRA_AES_SECURE_INPUT_HASH_ENB_FIELD;
+	if (mode & TEGRA_AES_MODE_CBC) {
+		value |= ((mode & TEGRA_AES_MODE_ENCRYPT) ? 2 : 3) <<
+			 TEGRA_AES_SECURE_XOR_POS_SHIFT;
+		value |= ((mode & TEGRA_AES_MODE_ENCRYPT) ? 2 : 3) <<
+			 TEGRA_AES_SECURE_VCTRAM_SEL_SHIFT;
+		value |= ((mode & TEGRA_AES_MODE_ENCRYPT) ? 1 : 0) <<
+			 TEGRA_AES_SECURE_CORE_SEL_SHIFT;
+	} else {
+		/* ECB */
+		value |= ((mode & TEGRA_AES_MODE_ENCRYPT) ? 1 : 0) <<
+			 TEGRA_AES_SECURE_CORE_SEL_SHIFT;
+	}
+
+	writel(value, priv->regs + TEGRA_AES_SECURE_INPUT_SELECT);
+
+	/* Set destination address (doing in-place at IRAM) */
+	writel((u32)priv->iram_addr, priv->regs + TEGRA_AES_SECURE_DEST_ADDR);
+
+	/* Copy src data to IRAM */
+	if (src != priv->iram_addr)
+		memcpy(priv->iram_addr, src, nblocks * AES_BLOCK_LENGTH);
+
+	/* Run ICMD commands */
+	cmdq[0] = TEGRA_AES_CMD_DMASETUP << TEGRA_AES_CMDQ_OPCODE_SHIFT;
+	cmdq[1] = (u32)priv->iram_addr;
+	cmdq[2] = TEGRA_AES_CMD_BLKSTARTENGINE << TEGRA_AES_CMDQ_OPCODE_SHIFT | (nblocks - 1);
+	cmdq[3] = TEGRA_AES_CMD_DMACOMPLETE << TEGRA_AES_CMDQ_OPCODE_SHIFT;
+
+	for (int i = 0; i < ICMDQ_LENGTH; i++) {
+		tegra_aes_wait_for_idle_dma(priv, (ICMDQ_LENGTH - 1) == i);
+		writel(cmdq[i], priv->regs + TEGRA_AES_ICMDQUE_WR);
+	}
+
+	if (tegra_aes_wait_for_idle(priv))
+		return -1;
+
+	/* Put the result from IRAM to destination if not hashing */
+	if (dst != priv->iram_addr && !(mode & TEGRA_AES_MODE_HASH))
+		memcpy(dst, priv->iram_addr, nblocks * AES_BLOCK_LENGTH);
+
+	return 0;
+}
+
+static int tegra_aes_process_blocks(struct udevice *dev, u8 *iv, u8 *src,
+				    u8 *dst, u32 num_aes_blocks, u32 mode)
+{
+	struct tegra_aes_priv *priv = dev_get_priv(dev);
+
+	log_debug("%s: 0x%p -> 0x%p blocks %d mode 0x%x\n",
+		  __func__, src, dst, num_aes_blocks, mode);
+
+	if (!num_aes_blocks) {
+		log_warning("%s: called with 0 blocks!\n", __func__);
+		return -1;
+	}
+
+	/* Load initial IV if CBC mode */
+	if (mode & TEGRA_AES_MODE_CBC) {
+		if (tegra_aes_call_engine(priv, iv, priv->iram_addr, 1, TEGRA_AES_MODE_CBC))
+			return -1;
+
+		/* Add update IV flag */
+		mode |= TEGRA_AES_MODE_UPDATE_IV;
+	}
+
+	/* Process blocks by calling engine several times per dma buffer size */
+	while (num_aes_blocks > 0) {
+		u32 blocks = min(num_aes_blocks, (u32)TEGRA_AES_DMA_BUFFER_SIZE);
+
+		if (tegra_aes_call_engine(priv, src, dst, blocks, mode))
+			return -1;
+
+		num_aes_blocks -= blocks;
+		src += blocks * AES_BLOCK_LENGTH;
+		dst += blocks * AES_BLOCK_LENGTH;
+	}
+
+	return 0;
+}
+
+static int tegra_aes_ops_available_key_slots(struct udevice *dev)
+{
+	return 4; /* 4 slots in Tegra20 and Tegra30 */
+}
+
+static int tegra_aes_ops_select_key_slot(struct udevice *dev, u32 key_size, u8 slot)
+{
+	struct tegra_aes_priv *priv = dev_get_priv(dev);
+
+	if (slot == TEGRA_AES_SLOT_SBK && !priv->sbk_available) {
+		log_warning("%s: SBK not available!\n", __func__);
+		return -1;
+	}
+
+	return tegra_aes_select_key_slot(priv, key_size, slot);
+}
+
+static int tegra_aes_ops_set_key_for_key_slot(struct udevice *dev, u32 key_size,
+					      u8 *key, u8 slot)
+{
+	struct tegra_aes_priv *priv = dev_get_priv(dev);
+	const u8 SUBCMD_CRYPTO_TABLE_SEL = 0x3;
+	const u8 SUBCMD_KEY_TABLE_SEL = 0x8;
+	const u8 CMDQ_KEYTABLEADDR_SHIFT = 0;
+	const u8 CMDQ_KEYTABLEID_SHIFT = 17;
+	const u8 CMDQ_TABLESEL_SHIFT = 24;
+	u32 value, addr;
+
+	log_debug("%s: slot %d\n", __func__, slot);
+
+	if (tegra_aes_configure(priv))
+		return -1;
+
+	if (key_size < (AES128_KEY_LENGTH * 8) ||
+	    key_size > (TEGRA_AES_HW_MAX_KEY_LENGTH * 8))
+		return -EINVAL;
+
+	if (slot == TEGRA_AES_SLOT_SBK)
+		log_debug("%s: SBK slot being set!\n", __func__);
+
+	/* Clear and copy data to IRAM */
+	memset(priv->iram_addr, 0, TEGRA_AES_HW_TABLE_LENGTH);
+	memcpy(priv->iram_addr, key, key_size / 8);
+
+	/* Mask the addr */
+	addr = ((u32)priv->iram_addr) & TEGRA_AES_KEYTABLEADDR_FIELD;
+
+	/* Command for engine to load AES key from IRAM */
+	value = TEGRA_AES_CMD_SETTABLE << TEGRA_AES_CMDQ_OPCODE_SHIFT |
+		SUBCMD_CRYPTO_TABLE_SEL << CMDQ_TABLESEL_SHIFT |
+		(SUBCMD_KEY_TABLE_SEL | slot) << CMDQ_KEYTABLEID_SHIFT |
+		addr << CMDQ_KEYTABLEADDR_SHIFT;
+	writel(value, priv->regs + TEGRA_AES_ICMDQUE_WR);
+
+	return tegra_aes_wait_for_idle(priv);
+}
+
+static int tegra_aes_ops_aes_ecb_encrypt(struct udevice *dev, u8 *src, u8 *dst,
+					 u32 num_aes_blocks)
+{
+	return tegra_aes_process_blocks(dev, NULL, src, dst, num_aes_blocks,
+					TEGRA_AES_MODE_ENCRYPT);
+}
+
+static int tegra_aes_ops_aes_ecb_decrypt(struct udevice *dev, u8 *src, u8 *dst,
+					 u32 num_aes_blocks)
+{
+	return tegra_aes_process_blocks(dev, NULL, src, dst, num_aes_blocks, 0);
+}
+
+static int tegra_aes_ops_aes_cbc_encrypt(struct udevice *dev, u8 *iv, u8 *src,
+					 u8 *dst, u32 num_aes_blocks)
+{
+	return tegra_aes_process_blocks(dev, iv, src, dst, num_aes_blocks,
+					TEGRA_AES_MODE_CBC | TEGRA_AES_MODE_ENCRYPT);
+}
+
+static int tegra_aes_ops_aes_cbc_decrypt(struct udevice *dev, u8 *iv, u8 *src,
+					 u8 *dst, u32 num_aes_blocks)
+{
+	return tegra_aes_process_blocks(dev, iv, src, dst, num_aes_blocks,
+					TEGRA_AES_MODE_CBC);
+}
+
+static void tegra_aes_test_loaded_sbk(struct udevice *dev)
+{
+	struct tegra_aes_priv *priv = dev_get_priv(dev);
+	enum fuse_operating_mode opmode = tegra_fuse_get_operation_mode();
+	const u8 ZERO_KEY_CIPHERTEXT[AES_BLOCK_LENGTH] = {
+		0x66, 0xe9, 0x4b, 0xd4, 0xef, 0x8a, 0x2c, 0x3b,
+		0x88, 0x4c, 0xfa, 0x59, 0xca, 0x34, 0x2b, 0x2e
+	};
+
+	/* Encrypt a zero block, we use ECB so that we only care about SBK and not the IV */
+	memset(priv->iram_addr, 0, AES_BLOCK_LENGTH);
+	tegra_aes_select_key_slot(priv, 128, TEGRA_AES_SLOT_SBK);
+	tegra_aes_call_engine(priv, priv->iram_addr, priv->iram_addr, 1, TEGRA_AES_MODE_ENCRYPT);
+
+	/* Evaluate the result of engine operation */
+	if (!memcmp(priv->iram_addr, AES_ZERO_BLOCK, AES_BLOCK_LENGTH)) {
+		log_err("%s: engine is not operational! (opmode 0x%x)\n", __func__, opmode);
+	} else if (!memcmp(priv->iram_addr, ZERO_KEY_CIPHERTEXT, AES_BLOCK_LENGTH)) {
+		if (opmode == MODE_ODM_PRODUCTION_SECURE) {
+			log_warning("%s: SBK is zero or is cleared from engine! (opmode 0x%x)\n",
+				    __func__, opmode);
+		} else {
+			log_debug("%s - SBK is zero and available! (opmode 0x%x)\n",
+				  __func__, opmode);
+			priv->sbk_available = true;
+		}
+	} else {
+		if (opmode == MODE_ODM_PRODUCTION_SECURE) {
+			log_debug("%s: SBK is available! (opmode 0x%x)\n", __func__, opmode);
+			priv->sbk_available = true;
+		} else {
+			log_warning("%s: SBK is not zero and should be! (opmode 0x%x)\n",
+				    __func__, opmode);
+		}
+	}
+}
+
+static int tegra_aes_hw_init(struct udevice *dev)
+{
+	struct tegra_aes_priv *priv = dev_get_priv(dev);
+	u32 value;
+	int ret;
+
+	if (priv->clk_parent) {
+		ret = reset_assert(&priv->reset_ctl_vde);
+		if (ret) {
+			log_debug("%s: VDE reset assert failed: %d\n", __func__, ret);
+			return ret;
+		}
+	}
+
+	ret = reset_assert(&priv->reset_ctl);
+	if (ret) {
+		log_debug("%s: BSE reset assert failed: %d\n", __func__, ret);
+		return ret;
+	}
+
+	if (priv->clk_parent) {
+		ret = clk_enable(priv->clk_parent);
+		if (ret) {
+			log_err("%s: VDE clock enable failed: %d\n", __func__, ret);
+			return ret;
+		}
+
+		ret = clk_set_rate(priv->clk_parent, 50 * 1000000);
+		if (IS_ERR_VALUE(ret)) {
+			log_err("%s: VDE clock set rate failed: %d\n", __func__, ret);
+			return ret;
+		}
+	}
+
+	ret = clk_enable(priv->clk);
+	if (ret) {
+		log_err("%s: BSE clock enable failed: %d\n", __func__, ret);
+		return ret;
+	}
+
+	if (priv->clk_parent) {
+		ret = reset_deassert(&priv->reset_ctl_vde);
+		if (ret) {
+			log_err("%s: VDE reset deassert failed: %d\n", __func__, ret);
+			return ret;
+		}
+	}
+
+	ret = reset_deassert(&priv->reset_ctl);
+	if (ret) {
+		log_err("%s: BSE reset deassert failed: %d\n", __func__, ret);
+		return ret;
+	}
+
+	/* Enable key schedule generation in hardware */
+	value = readl(priv->regs + TEGRA_AES_SECURE_CONFIG_EXT);
+	value &= ~TEGRA_AES_SECURE_KEY_SCH_DIS_FIELD;
+	writel(value, priv->regs + TEGRA_AES_SECURE_CONFIG_EXT);
+
+	/* Check if SBK is loaded in SBK slot or was erased */
+	priv->sbk_available = false;
+	tegra_aes_test_loaded_sbk(dev);
+
+	return 0;
+}
+
+static int tegra_aes_probe(struct udevice *dev)
+{
+	struct tegra_aes_priv *priv = dev_get_priv(dev);
+	fdt_size_t iram_size = 0;
+	u32 value;
+	int ret;
+
+	priv->current_key_size = AES128_KEY_LENGTH;
+
+	priv->regs = dev_read_addr_ptr(dev);
+	if (!priv->regs) {
+		log_err("%s: Cannot find aes reg address, binding failed\n", __func__);
+		return -EINVAL;
+	}
+
+	priv->iram_addr = devfdt_get_addr_size_name_ptr(dev, "iram-buffer", &iram_size);
+	if (!priv->iram_addr) {
+		log_debug("%s: Cannot find iram buffer address, binding failed\n", __func__);
+		return -EINVAL;
+	}
+
+	if (iram_size < TEGRA_AES_DMA_BUFFER_SIZE * AES_BLOCK_LENGTH) {
+		log_debug("%s: Unsupported iram buffer size: 0x%x required: 0x%x\n",
+			  __func__, iram_size, TEGRA_AES_DMA_BUFFER_SIZE);
+		return -EINVAL;
+	}
+
+	/* Make sure the IRAM address is kept block aligned and accessible for slot loading */
+	value = (uint32_t)priv->iram_addr;
+	if ((value & 0xFFF0000F) != IRAM_BASE || value > TEGRA_AES_IRAM_MAX_ADDR) {
+		log_debug("%s: iram buffer must be located inside iram,", __func__);
+		log_debug("AES block aligned and not above 0x%08x, current addr %p\n",
+			  (u32)TEGRA_AES_IRAM_MAX_ADDR, priv->iram_addr);
+		return -EINVAL;
+	}
+
+	ret = reset_get_by_name(dev, NULL, &priv->reset_ctl);
+	if (ret) {
+		log_debug("%s: failed to get BSE reset: %d\n", __func__, ret);
+		return ret;
+	}
+
+	priv->clk = devm_clk_get(dev, NULL);
+	if (IS_ERR(priv->clk)) {
+		log_err("%s: failed to get BSE clock: %d\n", __func__, ret);
+		return ret;
+	}
+
+	/* VDE clock and reset required by BSEV */
+	ret = reset_get_by_name(dev, "vde", &priv->reset_ctl_vde);
+	if (ret)
+		log_debug("%s: failed to get VDE reset: %d\n", __func__, ret);
+
+	priv->clk_parent = devm_clk_get(dev, "vde");
+	if (IS_ERR(priv->clk_parent))
+		log_debug("%s: failed to get BSE clock: %d\n", __func__, ret);
+
+	return tegra_aes_hw_init(dev);
+}
+
+static const struct aes_ops tegra_aes_ops = {
+	.available_key_slots = tegra_aes_ops_available_key_slots,
+	.select_key_slot = tegra_aes_ops_select_key_slot,
+	.set_key_for_key_slot = tegra_aes_ops_set_key_for_key_slot,
+	.aes_ecb_encrypt = tegra_aes_ops_aes_ecb_encrypt,
+	.aes_ecb_decrypt = tegra_aes_ops_aes_ecb_decrypt,
+	.aes_cbc_encrypt = tegra_aes_ops_aes_cbc_encrypt,
+	.aes_cbc_decrypt = tegra_aes_ops_aes_cbc_decrypt,
+};
+
+static const struct udevice_id tegra_aes_ids[] = {
+	{ .compatible = "nvidia,tegra20-bsea" },
+	{ .compatible = "nvidia,tegra20-bsev" },
+	{ .compatible = "nvidia,tegra30-bsea" },
+	{ .compatible = "nvidia,tegra30-bsev" },
+	{ }
+};
+
+U_BOOT_DRIVER(tegra_aes) = {
+	.name = "tegra_aes",
+	.id = UCLASS_AES,
+	.of_match = tegra_aes_ids,
+	.probe = tegra_aes_probe,
+	.ops = &tegra_aes_ops,
+	.priv_auto = sizeof(struct tegra_aes_priv),
+};
-- 
2.48.1

