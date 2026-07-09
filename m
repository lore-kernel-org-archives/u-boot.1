Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA910C44501
	for <u-boot@archiver.kernel.org>; Fri, 10 Jul 2026 13:00:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B8B0F84B39;
	Fri, 10 Jul 2026 14:56:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="psP+RHHU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6470784C15; Fri, 10 Jul 2026 00:47:06 +0200 (CEST)
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com
 [IPv6:2001:4860:4864:20::2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 06CC784B72
 for <u-boot@lists.denx.de>; Fri, 10 Jul 2026 00:47:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=james.hilliard1@gmail.com
Received: by mail-oa1-x2d.google.com with SMTP id
 586e51a60fabf-44ae14b4fd6so127318fac.2
 for <u-boot@lists.denx.de>; Thu, 09 Jul 2026 15:47:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783637222; x=1784242022; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=H0zJd6HaMGo0VTO1E0AC8QphiHFP3PrNAE5TmZfYcSs=;
 b=psP+RHHUux02WuUKHRDHjoydd4fnpTtbUFj4s/KmZZOoH1ueu5IjWzLkFFJ833zuRf
 smFLJKYej0u+57IHGk128lRoDvKgDKWc4HxSUFPiYsXJGoV9bKhwakKs2gdqEhowwvbE
 snvDvJFTi0HeY7EuzFeyl7J/iHlImCcqFRmlfMK2Lcy7kZc77ytvxI5qCKgRopCbn0eX
 6C7Fu7Lsw1Gvnn3p9UDaOKrQ60yRmYHKxLyM8wt35Vyf8DD2VBU5cpL0/fnFdQDheWLr
 QdSLW23b8MoAq76P4BRmyTWrxaerbJkxwq40jZbLR8uYpQFjfFbJEOL9ENClj0tC9QgW
 mpOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783637222; x=1784242022;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=H0zJd6HaMGo0VTO1E0AC8QphiHFP3PrNAE5TmZfYcSs=;
 b=HheOTNe4+DciV3y3xpLbLUN9wTw2b2ql3CTbTR9gsgrC6D7XVIv2XG5ixPpmNu0tNh
 UiN7jxqETdAJxfDd7gKAXOXAvyzPDkoe6R6dF7PKatdMMGHKXKfIJcXVVFAjovKyLB5D
 b93ON9qFCqea663O+r2MGVbHz3rqVgBVbK1qtFhJ1K3Eb8jez4UH6hv3bLMQTG8Uga5/
 81a8VknDZ7j2SrxHuUWtOaCBpAhHoYLCmftNFj8MadFCFUeXWwpjOzrHLYmAZxEaEKFF
 BU4HPvMkv8hr8XevDe6XjmY2N1poAalHcPBAx/5lGrh+6mJQxZGiMlMwP7igalC6792U
 snAg==
X-Gm-Message-State: AOJu0YxO5yP0IjWxaOs1LG48TcXItqZ8oGDNK1F9ncfWfJ62TIbgySct
 LDCGMIdluQ0z0nejPBn7JaHK5cz6SBYNfs03jGMiRwM+JTZPiRwqQNOT
X-Gm-Gg: AfdE7ckvJ1DqjOmI9jOhTrxk44DqbjO6SHB1Pv9AC+CSTJz6I2ZJtOGONo2nX/84aJA
 dN3EtfChRhz7svoauUXSz3Dk25TWFMGvEMUXxC9fN9pDvAkuq0d72MalSwggjolY2nzlRpLT2eI
 1c5GI2WSbu2+BrhJBVw8zbaJ35e06lOMDJr1qWELz9CuungSHu54ZW101fBm0ZubW3J9/D0vhXH
 zgQVAdL+zlgDye1uAco3Jlah54bQP2Q4orXN7mqwfudTZQCqqJN+QMwnCOfz+4C2dXFDt+kMSHx
 Q+FKpcLzMQvFCIOjsIPBiZlRc2mlSZLHq397HEnQrztGcoSJses2rpnmbIvmnuOurHs7V0XZ2zH
 qVESjXVoexBOG6Wz6qhh7TWo21lIIngCTTD01T+/xmpvMeOcPiq/jvywq8AEIKYCCokIiqksALu
 97cypGxgzqsS2hwA3I8EeqQjlgyAFovRnhSq81SWaS0+ul20tbDw8r8Z5/W31nYs90JZj3yv7st
 tf288lYjibe/hVjckC3mdq+XyR374nBhxRGQe728IEXpti+IeOiY0ioV6QA4zaF
X-Received: by 2002:a05:6870:1d3:b0:447:6223:42ff with SMTP id
 586e51a60fabf-45163c30a2amr5526330fac.32.1783637221475; 
 Thu, 09 Jul 2026 15:47:01 -0700 (PDT)
Received: from [127.0.1.1] (174-29-11-8.hlrn.qwest.net. [174.29.11.8])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-45191643abdsm3310749fac.11.2026.07.09.15.46.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jul 2026 15:47:00 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Thu, 09 Jul 2026 16:46:29 -0600
Subject: [PATCH v3 07/10] crypto: allwinner: add sun8i-ce AES driver
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260709-submit-ce-series-v2-v3-7-5017da8c9bef@gmail.com>
References: <20260709-submit-ce-series-v2-v3-0-5017da8c9bef@gmail.com>
In-Reply-To: <20260709-submit-ce-series-v2-v3-0-5017da8c9bef@gmail.com>
To: u-boot@lists.denx.de, Svyatoslav Ryhel <clamor95@gmail.com>, 
 Ion Agorria <ion@agorria.com>
Cc: James Hilliard <james.hilliard1@gmail.com>, 
 Chen-Yu Tsai <wens@kernel.org>, Samuel Holland <samuel@sholland.org>, 
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Aristo Chen <aristo.chen@canonical.com>, Anton Ivanov <anton@binarly.io>, 
 Daniel Golle <daniel@makrotopia.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Wolfgang Wallner <wolfgang.wallner@at.abb.com>, Randolph Sapp <rs@ti.com>, 
 Heiko Schocher <hs@nabladev.com>, Alexey Charkov <alchark@gmail.com>, 
 "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>, 
 Peng Fan <peng.fan@nxp.com>, Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Anshul Dalal <anshuld@ti.com>, Rasmus Villemoes <rv@rasmusvillemoes.dk>, 
 Johan Jonker <jbx6244@gmail.com>, Francesco Valla <francesco@valla.it>, 
 Michael Walle <mwalle@kernel.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Andre Przywara <andre.przywara@arm.com>, Lukasz Majewski <lukma@denx.de>, 
 Michael Trimarchi <michael@amarulasolutions.com>, 
 Richard Genoud <richard.genoud@bootlin.com>, 
 Marek Vasut <marek.vasut@mailbox.org>, E Shattow <e@freeshell.de>, 
 Enric Balletbo i Serra <eballetbo@kernel.org>, 
 Lucas Dietrich <ld.adecy@gmail.com>, David Lechner <dlechner@baylibre.com>, 
 Julien Stephan <jstephan@baylibre.com>, 
 Kuan-Wei Chiu <visitorckw@gmail.com>, 
 Raymond Mao <raymond.mao@riscstar.com>, 
 Stefan Roese <stefan.roese@mailbox.org>, 
 Thierry Reding <treding@nvidia.com>, Francois Berder <fberder@outlook.fr>, 
 Jonas Karlman <jonas@kwiboo.se>, 
 Jerome Forissier <jerome.forissier@arm.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Bastien Curutchet <bastien.curutchet@bootlin.com>
X-Mailer: b4 0.15.2
X-Mailman-Approved-At: Fri, 10 Jul 2026 14:56:43 +0200
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

Add an Allwinner sun8i Crypto Engine driver using the same directory and
driver naming style as the Linux sun8i-ce driver. The parent device owns
the shared CE registers, clocks, resets and task submission path, while
an AES child exposes the standard UCLASS_AES interface.

Support AES-128, AES-192 and AES-256 in ECB and CBC modes with
software-provided keys. Process direct DMA-capable buffers in 128 KiB
chunks and use cache-aligned bounce buffers for unaligned heads, tails
and overlapping cases. CBC keeps the IV chain in software between chunks
so each CE task can run on a larger contiguous range without losing
chaining state.

Model the H6 and H616 compatibles after the Linux sun8i-ce variant data.
Both variants use byte-sized cipher task lengths; H616 additionally
needs word-addressed descriptors. In SPL, enable the shared H6-family CE
clock, bus gate, reset and MBUS gate directly because the full
clock/reset uclasses are not always available there.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
Changes v1 -> v2:
  - Expose slot 0 as the software-provided AES key slot
---
 MAINTAINERS                                       |   1 +
 drivers/crypto/Kconfig                            |   2 +
 drivers/crypto/Makefile                           |   1 +
 drivers/crypto/allwinner/Kconfig                  |   3 +
 drivers/crypto/allwinner/Makefile                 |   3 +
 drivers/crypto/allwinner/sun8i-ce/Kconfig         |  39 ++
 drivers/crypto/allwinner/sun8i-ce/Makefile        |   4 +
 drivers/crypto/allwinner/sun8i-ce/sun8i-ce-aes.c  | 413 ++++++++++++++++++++++
 drivers/crypto/allwinner/sun8i-ce/sun8i-ce-core.c | 375 ++++++++++++++++++++
 drivers/crypto/allwinner/sun8i-ce/sun8i-ce.h      |  61 ++++
 10 files changed, 902 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 030f92a84f9..57e56680437 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -762,6 +762,7 @@ F:	arch/arm/include/asm/arch-sunxi/
 F:	arch/arm/mach-sunxi/
 F:	board/sunxi/
 F:	drivers/clk/sunxi/
+F:	drivers/crypto/allwinner/
 F:	drivers/phy/allwinner/
 F:	drivers/pinctrl/sunxi/
 F:	drivers/video/sunxi/
diff --git a/drivers/crypto/Kconfig b/drivers/crypto/Kconfig
index 0d58e3910fe..d15a59f87ee 100644
--- a/drivers/crypto/Kconfig
+++ b/drivers/crypto/Kconfig
@@ -6,6 +6,8 @@ source "drivers/crypto/aes/Kconfig"
 
 source "drivers/crypto/fsl/Kconfig"
 
+source "drivers/crypto/allwinner/Kconfig"
+
 source "drivers/crypto/aspeed/Kconfig"
 
 source "drivers/crypto/nuvoton/Kconfig"
diff --git a/drivers/crypto/Makefile b/drivers/crypto/Makefile
index e4a4482b7f3..cbbd5dc1dbe 100644
--- a/drivers/crypto/Makefile
+++ b/drivers/crypto/Makefile
@@ -8,6 +8,7 @@ obj-y += aes/
 obj-y += rsa_mod_exp/
 obj-y += fsl/
 obj-y += hash/
+obj-y += allwinner/
 obj-y += aspeed/
 obj-y += nuvoton/
 obj-y += tegra/
diff --git a/drivers/crypto/allwinner/Kconfig b/drivers/crypto/allwinner/Kconfig
new file mode 100644
index 00000000000..9765b089e25
--- /dev/null
+++ b/drivers/crypto/allwinner/Kconfig
@@ -0,0 +1,3 @@
+# SPDX-License-Identifier: GPL-2.0+
+
+source "drivers/crypto/allwinner/sun8i-ce/Kconfig"
diff --git a/drivers/crypto/allwinner/Makefile b/drivers/crypto/allwinner/Makefile
new file mode 100644
index 00000000000..2dcae98bac9
--- /dev/null
+++ b/drivers/crypto/allwinner/Makefile
@@ -0,0 +1,3 @@
+# SPDX-License-Identifier: GPL-2.0+
+
+obj-y += sun8i-ce/
diff --git a/drivers/crypto/allwinner/sun8i-ce/Kconfig b/drivers/crypto/allwinner/sun8i-ce/Kconfig
new file mode 100644
index 00000000000..f72cf3498fe
--- /dev/null
+++ b/drivers/crypto/allwinner/sun8i-ce/Kconfig
@@ -0,0 +1,39 @@
+# SPDX-License-Identifier: GPL-2.0+
+
+config SUNXI_CE
+	bool
+	depends on ARCH_SUNXI
+	depends on CLK && DM_RESET
+
+config SPL_SUNXI_CE
+	bool
+	depends on ARCH_SUNXI
+	depends on MACH_SUN50I_H6 || MACH_SUN50I_H616
+	depends on SPL_DM
+	depends on SPL_OF_CONTROL
+	select SPL_CRYPTO
+
+config SUNXI_CE_AES
+	bool "Allwinner sunxi CE AES"
+	depends on ARCH_SUNXI
+	depends on DM_AES
+	depends on CLK && DM_RESET
+	select AES
+	select SUNXI_CE
+	help
+	  Select this option to enable AES encryption and decryption using
+	  the Crypto Engine found in Allwinner sunxi SoCs. The driver
+	  supports software-provided AES-128, AES-192 and AES-256 keys.
+
+config SPL_SUNXI_CE_AES
+	bool "Allwinner sunxi CE AES in SPL"
+	depends on ARCH_SUNXI
+	depends on MACH_SUN50I_H6 || MACH_SUN50I_H616
+	depends on SPL_DM_AES
+	depends on SPL_OF_CONTROL
+	select SPL_CRYPTO
+	select SPL_SUNXI_CE
+	help
+	  Select this option to enable AES decryption in SPL using the Crypto
+	  Engine found in Allwinner H6 and H616 compatible SoCs. This can be
+	  used to decrypt FIT images before loading U-Boot proper.
diff --git a/drivers/crypto/allwinner/sun8i-ce/Makefile b/drivers/crypto/allwinner/sun8i-ce/Makefile
new file mode 100644
index 00000000000..2a8778065b1
--- /dev/null
+++ b/drivers/crypto/allwinner/sun8i-ce/Makefile
@@ -0,0 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0+
+
+obj-$(CONFIG_$(PHASE_)SUNXI_CE) += sun8i-ce-core.o
+obj-$(CONFIG_$(PHASE_)SUNXI_CE_AES) += sun8i-ce-aes.o
diff --git a/drivers/crypto/allwinner/sun8i-ce/sun8i-ce-aes.c b/drivers/crypto/allwinner/sun8i-ce/sun8i-ce-aes.c
new file mode 100644
index 00000000000..6870eb38a65
--- /dev/null
+++ b/drivers/crypto/allwinner/sun8i-ce/sun8i-ce-aes.c
@@ -0,0 +1,413 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2026 James Hilliard
+ */
+
+#define LOG_CATEGORY UCLASS_AES
+
+#include <dm.h>
+#include <malloc.h>
+#include <memalign.h>
+#include <uboot_aes.h>
+#include <linux/dma-mapping.h>
+#include <linux/kernel.h>
+#include <linux/string.h>
+#include "sun8i-ce.h"
+
+#define SUNXI_CE_ENCRYPTION		0
+#define SUNXI_CE_DECRYPTION		BIT(8)
+
+#define SUNXI_CE_OP_ECB			0
+#define SUNXI_CE_OP_CBC			BIT(8)
+
+#define SUNXI_CE_AES_KEY_128BIT		0
+#define SUNXI_CE_AES_KEY_192BIT		1
+#define SUNXI_CE_AES_KEY_256BIT		2
+
+#define SUNXI_CE_KEY_SELECT_INPUT	0
+#define SUNXI_CE_KEY_SELECT_SHIFT	20
+#define SUNXI_CE_AES_DIRECT_CHUNK_SIZE	(128 * 1024)
+#define SUNXI_CE_AES_BOUNCE_CHUNK_SIZE	(64 * 1024)
+#define SUNXI_CE_AES_BOUNCE_CHUNK_BLOCKS \
+	(SUNXI_CE_AES_BOUNCE_CHUNK_SIZE / AES_BLOCK_LENGTH)
+
+struct sunxi_aes_priv {
+	u8 key[AES256_KEY_LENGTH];
+	u32 key_bits;
+	u32 ce_key_size;
+};
+
+static int sunxi_ce_key_size(u32 key_bits, u32 *ce_key_size)
+{
+	switch (key_bits) {
+	case AES128_KEY_LENGTH * 8:
+		*ce_key_size = SUNXI_CE_AES_KEY_128BIT;
+		return 0;
+	case AES192_KEY_LENGTH * 8:
+		*ce_key_size = SUNXI_CE_AES_KEY_192BIT;
+		return 0;
+	case AES256_KEY_LENGTH * 8:
+		*ce_key_size = SUNXI_CE_AES_KEY_256BIT;
+		return 0;
+	default:
+		return -EINVAL;
+	}
+}
+
+static bool sunxi_aes_ranges_overlap(const u8 *src, const u8 *dst, size_t len)
+{
+	uintptr_t src_start = (uintptr_t)src;
+	uintptr_t dst_start = (uintptr_t)dst;
+	uintptr_t src_end = src_start + len;
+	uintptr_t dst_end = dst_start + len;
+
+	return src_start < dst_end && dst_start < src_end;
+}
+
+static u32 sunxi_aes_direct_blocks(const u8 *src, const u8 *dst,
+				   u32 num_blocks)
+{
+	u32 len = min_t(u32, num_blocks * AES_BLOCK_LENGTH,
+			SUNXI_CE_AES_DIRECT_CHUNK_SIZE);
+
+	if (!IS_ALIGNED((uintptr_t)src, ARCH_DMA_MINALIGN) ||
+	    !IS_ALIGNED((uintptr_t)dst, ARCH_DMA_MINALIGN))
+		return 0;
+
+	return ALIGN_DOWN(len, ARCH_DMA_MINALIGN) / AES_BLOCK_LENGTH;
+}
+
+static u32 sunxi_aes_bounce_blocks(const u8 *dst, u32 num_blocks)
+{
+	uintptr_t dst_addr = (uintptr_t)dst;
+	u32 blocks = min_t(u32, num_blocks, SUNXI_CE_AES_BOUNCE_CHUNK_BLOCKS);
+	u32 head;
+
+	if (!IS_ALIGNED(dst_addr, AES_BLOCK_LENGTH))
+		return blocks;
+
+	head = ALIGN(dst_addr, ARCH_DMA_MINALIGN) - dst_addr;
+	if (head)
+		blocks = min_t(u32, blocks, head / AES_BLOCK_LENGTH);
+
+	return blocks;
+}
+
+static void sunxi_aes_fill_task(struct sunxi_ce_priv *ce,
+				struct sunxi_ce_task *task,
+				dma_addr_t key, dma_addr_t iv,
+				dma_addr_t src, dma_addr_t dst,
+				u32 len, u32 comm_ctl, u32 sym_ctl)
+{
+	u32 task_len = len / sizeof(u32);
+
+	memset(task, 0, sizeof(*task));
+
+	task->t_id = SUNXI_CE_CHAN;
+	task->t_common_ctl = comm_ctl | SUNXI_CE_COMM_INT;
+	task->t_sym_ctl = sym_ctl;
+	task->t_key = sunxi_ce_desc_dma_addr(ce, key);
+	if (iv)
+		task->t_iv = sunxi_ce_desc_dma_addr(ce, iv);
+	task->t_dlen = ce->variant->cipher_t_dlen_in_bytes ? len : task_len;
+	task->t_src[0].addr = sunxi_ce_desc_dma_addr(ce, src);
+	task->t_src[0].len = task_len;
+	task->t_dst[0].addr = sunxi_ce_desc_dma_addr(ce, dst);
+	task->t_dst[0].len = task_len;
+}
+
+static void sunxi_aes_update_iv(u8 *iv_work, u8 *src, u8 *dst, u32 len,
+				bool decrypt)
+{
+	if (decrypt)
+		memcpy(iv_work, src + len - AES_BLOCK_LENGTH,
+		       AES_BLOCK_LENGTH);
+	else
+		memcpy(iv_work, dst + len - AES_BLOCK_LENGTH,
+		       AES_BLOCK_LENGTH);
+}
+
+static int sunxi_aes_run_hw(struct sunxi_ce_priv *ce,
+			    struct sunxi_ce_task *task, void *key,
+			    u8 *iv, u8 *src, u8 *dst, u32 num_blocks,
+			    u32 comm_ctl, u32 sym_ctl)
+{
+	u8 iv_work[AES_BLOCK_LENGTH];
+	u8 iv_next[AES_BLOCK_LENGTH];
+	u8 *iv_buf = NULL, *src_buf = NULL, *dst_buf = NULL;
+	dma_addr_t key_dma;
+	bool cbc = iv;
+	bool decrypt = comm_ctl & SUNXI_CE_DECRYPTION;
+	int ret;
+
+	if (cbc) {
+		iv_buf = memalign(ARCH_DMA_MINALIGN, ARCH_DMA_MINALIGN);
+		if (!iv_buf) {
+			ret = -ENOMEM;
+			goto out_free;
+		}
+	}
+
+	if (cbc)
+		memcpy(iv_work, iv, AES_BLOCK_LENGTH);
+
+	key_dma = dma_map_single(key, ARCH_DMA_MINALIGN, DMA_TO_DEVICE);
+	if (dma_mapping_error(NULL, key_dma)) {
+		ret = -EIO;
+		goto out_free;
+	}
+
+	while (num_blocks) {
+		u32 blocks = sunxi_aes_direct_blocks(src, dst, num_blocks);
+		bool direct = blocks > 0;
+		bool in_place = direct && src == dst;
+		enum dma_data_direction src_dir = in_place ? DMA_BIDIRECTIONAL :
+							  DMA_TO_DEVICE;
+		u32 len = blocks * AES_BLOCK_LENGTH;
+		u8 *src_dma_buf = direct ? src : src_buf;
+		u8 *dst_dma_buf = direct ? dst : dst_buf;
+		dma_addr_t iv_dma = 0, src_dma, dst_dma;
+
+		if (!direct) {
+			if (!src_buf) {
+				src_buf = memalign(ARCH_DMA_MINALIGN,
+						   SUNXI_CE_AES_BOUNCE_CHUNK_SIZE);
+				dst_buf = memalign(ARCH_DMA_MINALIGN,
+						   SUNXI_CE_AES_BOUNCE_CHUNK_SIZE);
+				if (!src_buf || !dst_buf) {
+					ret = -ENOMEM;
+					goto out_unmap_key;
+				}
+			}
+			blocks = sunxi_aes_bounce_blocks(dst, num_blocks);
+			len = blocks * AES_BLOCK_LENGTH;
+			src_dma_buf = src_buf;
+			dst_dma_buf = dst_buf;
+			memcpy(src_buf, src, len);
+		}
+		if (cbc && decrypt && in_place)
+			memcpy(iv_next, src_dma_buf + len - AES_BLOCK_LENGTH,
+			       AES_BLOCK_LENGTH);
+		if (cbc) {
+			memset(iv_buf, 0, ARCH_DMA_MINALIGN);
+			memcpy(iv_buf, iv_work, AES_BLOCK_LENGTH);
+			iv_dma = dma_map_single(iv_buf, ARCH_DMA_MINALIGN,
+						DMA_TO_DEVICE);
+			if (dma_mapping_error(NULL, iv_dma)) {
+				ret = -EIO;
+				goto out_unmap_key;
+			}
+		}
+
+		src_dma = dma_map_single(src_dma_buf, len, src_dir);
+		if (dma_mapping_error(NULL, src_dma)) {
+			ret = -EIO;
+			goto out_unmap_iv;
+		}
+
+		if (in_place) {
+			dst_dma = src_dma;
+		} else {
+			dst_dma = dma_map_single(dst_dma_buf, len,
+						 DMA_FROM_DEVICE);
+			if (dma_mapping_error(NULL, dst_dma)) {
+				ret = -EIO;
+				goto out_unmap_src;
+			}
+		}
+
+		sunxi_aes_fill_task(ce, task, key_dma, iv_dma, src_dma,
+				    dst_dma, len, comm_ctl, sym_ctl);
+		sunxi_ce_flush(task, sizeof(*task));
+
+		ret = sunxi_ce_run_task(ce, task);
+
+		if (!in_place)
+			dma_unmap_single(dst_dma, len, DMA_FROM_DEVICE);
+out_unmap_src:
+		dma_unmap_single(src_dma, len, src_dir);
+out_unmap_iv:
+		if (cbc)
+			dma_unmap_single(iv_dma, ARCH_DMA_MINALIGN,
+					 DMA_TO_DEVICE);
+		if (ret)
+			goto out_unmap_key;
+
+		if (cbc) {
+			if (decrypt && in_place)
+				memcpy(iv_work, iv_next, AES_BLOCK_LENGTH);
+			else
+				sunxi_aes_update_iv(iv_work, src_dma_buf,
+						    dst_dma_buf, len, decrypt);
+		}
+		if (!direct)
+			memcpy(dst, dst_buf, len);
+		num_blocks -= blocks;
+		src += len;
+		dst += len;
+	}
+
+	ret = 0;
+
+out_unmap_key:
+	dma_unmap_single(key_dma, ARCH_DMA_MINALIGN, DMA_TO_DEVICE);
+out_free:
+	free(iv_buf);
+	free(dst_buf);
+	free(src_buf);
+
+	return ret;
+}
+
+static int sunxi_aes_run(struct udevice *dev, u8 *iv, u8 *src, u8 *dst,
+			 u32 num_blocks, u32 aes_mode, bool decrypt)
+{
+	struct sunxi_aes_priv *priv = dev_get_priv(dev);
+	struct sunxi_ce_priv *ce = dev_get_priv(dev_get_parent(dev));
+	struct sunxi_ce_task *tasks;
+	u8 *key_buf;
+	u32 comm_ctl, sym_ctl;
+	bool cbc = aes_mode == SUNXI_CE_OP_CBC;
+	size_t total_len;
+	int ret;
+
+	if (!priv->key_bits)
+		return -EINVAL;
+	if (!num_blocks)
+		return 0;
+	if (!src || !dst)
+		return -EINVAL;
+	if (cbc && !iv)
+		return -EINVAL;
+	total_len = (size_t)num_blocks * AES_BLOCK_LENGTH;
+
+	/*
+	 * Exact in-place operation is supported, but chunked bounce processing
+	 * does not provide memmove-style semantics for partial overlaps.
+	 */
+	if (src != dst && sunxi_aes_ranges_overlap(src, dst, total_len))
+		return -EINVAL;
+
+	tasks = memalign(ARCH_DMA_MINALIGN,
+			 ALIGN(sizeof(*tasks), ARCH_DMA_MINALIGN));
+	key_buf = memalign(ARCH_DMA_MINALIGN, ARCH_DMA_MINALIGN);
+	if (!tasks || !key_buf) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	memset(key_buf, 0, ARCH_DMA_MINALIGN);
+	memcpy(key_buf, priv->key, priv->key_bits / 8);
+
+	comm_ctl = decrypt ? SUNXI_CE_DECRYPTION : SUNXI_CE_ENCRYPTION;
+	sym_ctl = priv->ce_key_size |
+		  aes_mode |
+		  (SUNXI_CE_KEY_SELECT_INPUT << SUNXI_CE_KEY_SELECT_SHIFT);
+
+	ret = sunxi_aes_run_hw(ce, tasks, key_buf, iv, src, dst, num_blocks,
+			       comm_ctl, sym_ctl);
+
+out:
+	free(key_buf);
+	free(tasks);
+
+	return ret;
+}
+
+static int sunxi_aes_available_key_slots(struct udevice *dev)
+{
+	return 1;
+}
+
+static int sunxi_aes_get_software_key_slot(struct udevice *dev)
+{
+	return 0;
+}
+
+static int sunxi_aes_select_key_slot(struct udevice *dev, u32 key_size,
+				     u8 slot)
+{
+	struct sunxi_aes_priv *priv = dev_get_priv(dev);
+	u32 ce_key_size;
+	int ret;
+
+	if (slot)
+		return -EINVAL;
+
+	ret = sunxi_ce_key_size(key_size, &ce_key_size);
+	if (ret)
+		return ret;
+
+	priv->key_bits = key_size;
+	priv->ce_key_size = ce_key_size;
+
+	return 0;
+}
+
+static int sunxi_aes_set_key_for_key_slot(struct udevice *dev, u32 key_size,
+					  u8 *key, u8 slot)
+{
+	struct sunxi_aes_priv *priv = dev_get_priv(dev);
+	u32 ce_key_size;
+	int ret;
+
+	if (slot || !key)
+		return -EINVAL;
+
+	ret = sunxi_ce_key_size(key_size, &ce_key_size);
+	if (ret)
+		return ret;
+
+	memcpy(priv->key, key, key_size / 8);
+	priv->key_bits = key_size;
+	priv->ce_key_size = ce_key_size;
+
+	return 0;
+}
+
+static int sunxi_aes_ecb_encrypt(struct udevice *dev, u8 *src, u8 *dst,
+				 u32 num_blocks)
+{
+	return sunxi_aes_run(dev, NULL, src, dst, num_blocks,
+			     SUNXI_CE_OP_ECB, false);
+}
+
+static int sunxi_aes_ecb_decrypt(struct udevice *dev, u8 *src, u8 *dst,
+				 u32 num_blocks)
+{
+	return sunxi_aes_run(dev, NULL, src, dst, num_blocks,
+			     SUNXI_CE_OP_ECB, true);
+}
+
+static int sunxi_aes_cbc_encrypt(struct udevice *dev, u8 *iv, u8 *src,
+				 u8 *dst, u32 num_blocks)
+{
+	return sunxi_aes_run(dev, iv, src, dst, num_blocks,
+			     SUNXI_CE_OP_CBC, false);
+}
+
+static int sunxi_aes_cbc_decrypt(struct udevice *dev, u8 *iv, u8 *src,
+				 u8 *dst, u32 num_blocks)
+{
+	return sunxi_aes_run(dev, iv, src, dst, num_blocks,
+			     SUNXI_CE_OP_CBC, true);
+}
+
+static const struct aes_ops sunxi_aes_ops = {
+	.available_key_slots = sunxi_aes_available_key_slots,
+	.get_software_key_slot = sunxi_aes_get_software_key_slot,
+	.select_key_slot = sunxi_aes_select_key_slot,
+	.set_key_for_key_slot = sunxi_aes_set_key_for_key_slot,
+	.aes_ecb_encrypt = sunxi_aes_ecb_encrypt,
+	.aes_ecb_decrypt = sunxi_aes_ecb_decrypt,
+	.aes_cbc_encrypt = sunxi_aes_cbc_encrypt,
+	.aes_cbc_decrypt = sunxi_aes_cbc_decrypt,
+};
+
+U_BOOT_DRIVER(sun8i_ce_aes) = {
+	.name = "sun8i-ce-aes",
+	.id = UCLASS_AES,
+	.ops = &sunxi_aes_ops,
+	.priv_auto = sizeof(struct sunxi_aes_priv),
+	.flags = DM_FLAG_PRE_RELOC,
+};
diff --git a/drivers/crypto/allwinner/sun8i-ce/sun8i-ce-core.c b/drivers/crypto/allwinner/sun8i-ce/sun8i-ce-core.c
new file mode 100644
index 00000000000..3674e54ec12
--- /dev/null
+++ b/drivers/crypto/allwinner/sun8i-ce/sun8i-ce-core.c
@@ -0,0 +1,375 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2026 James Hilliard
+ */
+
+#include <cpu_func.h>
+#include <dm.h>
+#include <dm/device_compat.h>
+#include <dm/lists.h>
+#include <asm/arch/cpu.h>
+#include <asm/cache.h>
+#include <asm/io.h>
+#include <linux/delay.h>
+#include <linux/iopoll.h>
+#include "sun8i-ce.h"
+
+#define SUNXI_CE_TDQ			0x00
+#define SUNXI_CE_ICR			0x08
+#define SUNXI_CE_ISR			0x0c
+#define SUNXI_CE_TLR			0x10
+#define SUNXI_CE_ESR			0x18
+#define SUNXI_CE_SCSA			0x24
+#define SUNXI_CE_SCDA			0x28
+
+#define SUNXI_CE_CHAN_ERR_MASK		(0xff << (SUNXI_CE_CHAN * 8))
+#define SUNXI_CE_ERR_ALGO_NOTSUP	BIT(0)
+#define SUNXI_CE_ERR_DATALEN		BIT(1)
+#define SUNXI_CE_ERR_KEYSRAM		BIT(2)
+#define SUNXI_CE_ERR_ADDR_INVALID	BIT(5)
+#define SUNXI_CE_ERR_KEYLADDER		BIT(6)
+#define SUNXI_CE_TASK_START		BIT(0)
+#define SUNXI_CE_METHOD_MASK		GENMASK(6, 0)
+#define SUNXI_CE_TLR_METHOD_SHIFT	8
+#define SUNXI_CE_WORD_SHIFT		2
+#define SUNXI_CE_TIMEOUT_US		3000000
+
+#define SUN50I_H6_CCU_CE_CLK		0x680
+#define SUN50I_H6_CCU_CE_BGR		0x68c
+#define SUN50I_H6_CCU_MBUS_GATE		0x804
+#define SUN50I_H6_CCU_CE_CLK_SRC_MASK	BIT(24)
+#define SUN50I_H6_CCU_CE_CLK_N_MASK	GENMASK(9, 8)
+#define SUN50I_H6_CCU_CE_CLK_M_MASK	GENMASK(3, 0)
+#define SUN50I_H6_CCU_CE_CLK_GATE	BIT(31)
+#define SUN50I_H6_CCU_CE_BUS_GATE	BIT(0)
+#define SUN50I_H6_CCU_CE_BUS_RST	BIT(16)
+#define SUN50I_H6_CCU_MBUS_GATE_CE	BIT(2)
+#define SUN50I_H616_CCU_CE_CLK_M	7
+
+u32 sunxi_ce_desc_dma_addr(struct sunxi_ce_priv *priv, dma_addr_t addr)
+{
+	if (priv->variant->needs_word_addresses)
+		addr >>= SUNXI_CE_WORD_SHIFT;
+
+	return (u32)addr;
+}
+
+void sunxi_ce_flush(void *buf, size_t len)
+{
+	ulong start = ALIGN_DOWN((ulong)buf, ARCH_DMA_MINALIGN);
+	ulong end = ALIGN((ulong)buf + len, ARCH_DMA_MINALIGN);
+
+	flush_dcache_range(start, end);
+}
+
+static void sunxi_ce_print_error(u32 err)
+{
+	printf("CE ERROR: %#x\n", err);
+	if (err & SUNXI_CE_ERR_ALGO_NOTSUP)
+		printf("CE ERROR: algorithm not supported\n");
+	if (err & SUNXI_CE_ERR_DATALEN)
+		printf("CE ERROR: data length error\n");
+	if (err & SUNXI_CE_ERR_KEYSRAM)
+		printf("CE ERROR: keysram access error for AES\n");
+	if (err & SUNXI_CE_ERR_ADDR_INVALID)
+		printf("CE ERROR: address invalid\n");
+	if (err & SUNXI_CE_ERR_KEYLADDER)
+		printf("CE ERROR: key ladder configuration error\n");
+}
+
+int sunxi_ce_run_task(struct sunxi_ce_priv *priv, struct sunxi_ce_task *task)
+{
+	u32 method = task->t_common_ctl & SUNXI_CE_METHOD_MASK;
+	u32 val, err;
+	int ret;
+
+	val = readl(priv->base + SUNXI_CE_ICR);
+	writel(val | SUNXI_CE_CHAN_INT, priv->base + SUNXI_CE_ICR);
+	writel(SUNXI_CE_CHAN_INT, priv->base + SUNXI_CE_ISR);
+	writel(SUNXI_CE_CHAN_ERR_MASK, priv->base + SUNXI_CE_ESR);
+	ret = readl_poll_timeout(priv->base + SUNXI_CE_ISR, val,
+				 !(val & SUNXI_CE_CHAN_INT),
+				 SUNXI_CE_TIMEOUT_US);
+	if (ret) {
+		printf("%s: timeout waiting for stale interrupt\n", __func__);
+		return ret;
+	}
+	ret = readl_poll_timeout(priv->base + SUNXI_CE_TLR, val, !val,
+				 SUNXI_CE_TIMEOUT_US);
+	if (ret) {
+		printf("%s: timeout waiting for task launcher\n", __func__);
+		return ret;
+	}
+
+	writel(sunxi_ce_desc_dma_addr(priv, virt_to_phys(task)),
+	       priv->base + SUNXI_CE_TDQ);
+	/* Be sure all data is written before enabling the task. */
+	wmb();
+	writel((method << SUNXI_CE_TLR_METHOD_SHIFT) | SUNXI_CE_TASK_START,
+	       priv->base + SUNXI_CE_TLR);
+
+	ret = readl_poll_timeout(priv->base + SUNXI_CE_ISR, val,
+				 val & SUNXI_CE_CHAN_INT,
+				 SUNXI_CE_TIMEOUT_US);
+	if (ret) {
+		printf("%s: DMA timeout\n", __func__);
+		writel(SUNXI_CE_CHAN_INT, priv->base + SUNXI_CE_ISR);
+		writel(SUNXI_CE_CHAN_ERR_MASK, priv->base + SUNXI_CE_ESR);
+		return ret;
+	}
+
+	ret = readl_poll_timeout(priv->base + SUNXI_CE_SCSA, val, !val,
+				 SUNXI_CE_TIMEOUT_US);
+	if (ret) {
+		printf("%s: timeout waiting for source DMA idle\n", __func__);
+		return ret;
+	}
+	ret = readl_poll_timeout(priv->base + SUNXI_CE_SCDA, val, !val,
+				 SUNXI_CE_TIMEOUT_US);
+	if (ret) {
+		printf("%s: timeout waiting for destination DMA idle\n",
+		       __func__);
+		return ret;
+	}
+
+	writel(0, priv->base + SUNXI_CE_TLR);
+	clrbits_le32(priv->base + SUNXI_CE_ICR, SUNXI_CE_CHAN_INT);
+	writel(0, priv->base + SUNXI_CE_TDQ);
+	ret = readl_poll_timeout(priv->base + SUNXI_CE_TLR, val, !val,
+				 SUNXI_CE_TIMEOUT_US);
+	if (ret) {
+		printf("%s: timeout clearing task launcher\n", __func__);
+		return ret;
+	}
+	readl(priv->base + SUNXI_CE_TDQ);
+
+	err = readl(priv->base + SUNXI_CE_ESR) & SUNXI_CE_CHAN_ERR_MASK;
+	writel(SUNXI_CE_CHAN_ERR_MASK, priv->base + SUNXI_CE_ESR);
+
+	if (err) {
+		sunxi_ce_print_error(err >> (SUNXI_CE_CHAN * 8));
+		return -EIO;
+	}
+
+	return 0;
+}
+
+int sunxi_ce_reset(struct sunxi_ce_priv *priv)
+{
+	int ret;
+
+	if (IS_ENABLED(CONFIG_XPL_BUILD)) {
+		if (!priv->variant->spl_reset)
+			return -EOPNOTSUPP;
+
+		priv->variant->spl_reset();
+		return 0;
+	}
+
+	ret = reset_assert_bulk(&priv->resets);
+	if (ret)
+		return ret;
+
+	udelay(1);
+
+	ret = reset_deassert_bulk(&priv->resets);
+	if (ret)
+		return ret;
+
+	udelay(10);
+
+	return 0;
+}
+
+static void sun50i_h6_ce_spl_reset(void)
+{
+	void __iomem *ccu = (void __iomem *)SUNXI_CCM_BASE;
+
+	clrbits_le32(ccu + SUN50I_H6_CCU_CE_BGR,
+		     SUN50I_H6_CCU_CE_BUS_RST);
+	udelay(1);
+	setbits_le32(ccu + SUN50I_H6_CCU_CE_BGR,
+		     SUN50I_H6_CCU_CE_BUS_RST);
+	udelay(10);
+}
+
+static void sun50i_h6_ce_spl_enable_clocks(void)
+{
+	void __iomem *ccu = (void __iomem *)SUNXI_CCM_BASE;
+
+	clrsetbits_le32(ccu + SUN50I_H6_CCU_CE_CLK,
+			SUN50I_H6_CCU_CE_CLK_SRC_MASK |
+			SUN50I_H6_CCU_CE_CLK_N_MASK |
+			SUN50I_H6_CCU_CE_CLK_M_MASK,
+			SUN50I_H6_CCU_CE_CLK_GATE);
+	setbits_le32(ccu + SUN50I_H6_CCU_CE_BGR,
+		     SUN50I_H6_CCU_CE_BUS_GATE |
+		     SUN50I_H6_CCU_CE_BUS_RST);
+	setbits_le32(ccu + SUN50I_H6_CCU_MBUS_GATE,
+		     SUN50I_H6_CCU_MBUS_GATE_CE);
+	sun50i_h6_ce_spl_reset();
+}
+
+static void sun50i_h616_ce_setup_mod_clock(void)
+{
+	void __iomem *ccu = (void __iomem *)SUNXI_CCM_BASE;
+
+	clrsetbits_le32(ccu + SUN50I_H6_CCU_CE_CLK,
+			SUN50I_H6_CCU_CE_CLK_GATE |
+			SUN50I_H6_CCU_CE_CLK_SRC_MASK |
+			SUN50I_H6_CCU_CE_CLK_N_MASK |
+			SUN50I_H6_CCU_CE_CLK_M_MASK,
+			SUN50I_H6_CCU_CE_CLK_SRC_MASK |
+			SUN50I_H616_CCU_CE_CLK_M);
+}
+
+static void sun50i_h616_ce_spl_enable_clocks(void)
+{
+	void __iomem *ccu = (void __iomem *)SUNXI_CCM_BASE;
+
+	sun50i_h616_ce_setup_mod_clock();
+	setbits_le32(ccu + SUN50I_H6_CCU_CE_BGR,
+		     SUN50I_H6_CCU_CE_BUS_RST);
+	setbits_le32(ccu + SUN50I_H6_CCU_CE_BGR,
+		     SUN50I_H6_CCU_CE_BUS_GATE);
+	setbits_le32(ccu + SUN50I_H6_CCU_CE_CLK,
+		     SUN50I_H6_CCU_CE_CLK_GATE);
+	setbits_le32(ccu + SUN50I_H6_CCU_MBUS_GATE,
+		     SUN50I_H6_CCU_MBUS_GATE_CE);
+	sun50i_h6_ce_spl_reset();
+}
+
+static int sunxi_ce_bind(struct udevice *dev)
+{
+	const struct sunxi_ce_variant *variant =
+		(const struct sunxi_ce_variant *)dev_get_driver_data(dev);
+	int ret;
+
+	if (CONFIG_IS_ENABLED(SUNXI_CE_AES) && variant->has_aes) {
+		ret = device_bind_driver(dev, "sun8i-ce-aes",
+					 "sun8i-ce-aes", NULL);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+static int sunxi_ce_probe(struct udevice *dev)
+{
+	struct sunxi_ce_priv *priv = dev_get_priv(dev);
+	int ret;
+
+	priv->variant = (const struct sunxi_ce_variant *)
+			dev_get_driver_data(dev);
+	priv->base = dev_read_addr_ptr(dev);
+	if (!priv->base)
+		return -EINVAL;
+
+	if (IS_ENABLED(CONFIG_XPL_BUILD)) {
+		if (!priv->variant->spl_enable_clocks)
+			return -ENOSYS;
+
+		priv->variant->spl_enable_clocks();
+		return 0;
+	}
+
+	ret = reset_get_bulk(dev, &priv->resets);
+	if (ret) {
+		dev_err(dev, "failed to get resets: %d\n", ret);
+		return ret;
+	}
+
+	ret = clk_get_bulk(dev, &priv->clks);
+	if (ret) {
+		dev_err(dev, "failed to get clocks: %d\n", ret);
+		goto err_release_resets;
+	}
+
+	if (priv->variant->setup_mod_clock)
+		priv->variant->setup_mod_clock();
+
+	ret = reset_deassert_bulk(&priv->resets);
+	if (ret) {
+		dev_err(dev, "failed to deassert resets: %d\n", ret);
+		goto err_release_clks;
+	}
+
+	ret = clk_enable_bulk(&priv->clks);
+	if (ret) {
+		dev_err(dev, "failed to enable clocks: %d\n", ret);
+		goto err_assert_resets;
+	}
+
+	ret = sunxi_ce_reset(priv);
+	if (ret) {
+		dev_err(dev, "failed to reset CE: %d\n", ret);
+		goto err_disable_clks;
+	}
+
+	return 0;
+
+err_disable_clks:
+	clk_disable_bulk(&priv->clks);
+err_assert_resets:
+	reset_assert_bulk(&priv->resets);
+err_release_clks:
+	clk_release_bulk(&priv->clks);
+err_release_resets:
+	reset_release_bulk(&priv->resets);
+
+	return ret;
+}
+
+static int sunxi_ce_remove(struct udevice *dev)
+{
+	struct sunxi_ce_priv *priv = dev_get_priv(dev);
+
+	if (IS_ENABLED(CONFIG_XPL_BUILD))
+		return 0;
+
+	clk_disable_bulk(&priv->clks);
+	clk_release_bulk(&priv->clks);
+	reset_assert_bulk(&priv->resets);
+	reset_release_bulk(&priv->resets);
+
+	return 0;
+}
+
+static const struct sunxi_ce_variant sun50i_h6_variant = {
+	.has_aes = true,
+	.cipher_t_dlen_in_bytes = true,
+	.spl_enable_clocks = sun50i_h6_ce_spl_enable_clocks,
+	.spl_reset = sun50i_h6_ce_spl_reset,
+};
+
+static const struct sunxi_ce_variant sun50i_h616_variant = {
+	.has_aes = true,
+	.cipher_t_dlen_in_bytes = true,
+	.needs_word_addresses = true,
+	.setup_mod_clock = sun50i_h616_ce_setup_mod_clock,
+	.spl_enable_clocks = sun50i_h616_ce_spl_enable_clocks,
+	.spl_reset = sun50i_h6_ce_spl_reset,
+};
+
+static const struct udevice_id sunxi_ce_ids[] = {
+	{
+		.compatible = "allwinner,sun50i-h6-crypto",
+		.data = (ulong)&sun50i_h6_variant,
+	}, {
+		.compatible = "allwinner,sun50i-h616-crypto",
+		.data = (ulong)&sun50i_h616_variant,
+	},
+	{ }
+};
+
+U_BOOT_DRIVER(sun8i_ce) = {
+	.name = "sun8i-ce",
+	.id = UCLASS_NOP,
+	.of_match = sunxi_ce_ids,
+	.bind = sunxi_ce_bind,
+	.probe = sunxi_ce_probe,
+	.remove = sunxi_ce_remove,
+	.priv_auto = sizeof(struct sunxi_ce_priv),
+	.flags = DM_FLAG_PRE_RELOC,
+};
diff --git a/drivers/crypto/allwinner/sun8i-ce/sun8i-ce.h b/drivers/crypto/allwinner/sun8i-ce/sun8i-ce.h
new file mode 100644
index 00000000000..1580fff35fe
--- /dev/null
+++ b/drivers/crypto/allwinner/sun8i-ce/sun8i-ce.h
@@ -0,0 +1,61 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Copyright (C) 2026 James Hilliard
+ */
+
+#ifndef __SUN8I_CE_H
+#define __SUN8I_CE_H
+
+#include <clk.h>
+#include <reset.h>
+#include <linux/bitops.h>
+#include <linux/types.h>
+
+#define SUNXI_CE_CHAN			0
+#define SUNXI_CE_CHAN_INT		BIT(SUNXI_CE_CHAN)
+#define SUNXI_CE_COMM_INT		BIT(31)
+#define SUNXI_CE_METHOD_AES		0
+#define SUNXI_CE_MAX_SG			8
+
+struct sunxi_ce_sginfo {
+	u32 addr;
+	u32 len;
+};
+
+struct sunxi_ce_task {
+	u32 t_id;
+	u32 t_common_ctl;
+	u32 t_sym_ctl;
+	u32 t_asym_ctl;
+	u32 t_key;
+	u32 t_iv;
+	u32 t_ctr;
+	u32 t_dlen;
+	struct sunxi_ce_sginfo t_src[SUNXI_CE_MAX_SG];
+	struct sunxi_ce_sginfo t_dst[SUNXI_CE_MAX_SG];
+	u32 next;
+	u32 reserved[3];
+};
+
+struct sunxi_ce_variant {
+	bool has_aes;
+	bool cipher_t_dlen_in_bytes;
+	bool needs_word_addresses;
+	void (*setup_mod_clock)(void);
+	void (*spl_enable_clocks)(void);
+	void (*spl_reset)(void);
+};
+
+struct sunxi_ce_priv {
+	void __iomem *base;
+	const struct sunxi_ce_variant *variant;
+	struct clk_bulk clks;
+	struct reset_ctl_bulk resets;
+};
+
+u32 sunxi_ce_desc_dma_addr(struct sunxi_ce_priv *priv, dma_addr_t addr);
+void sunxi_ce_flush(void *buf, size_t len);
+int sunxi_ce_run_task(struct sunxi_ce_priv *priv, struct sunxi_ce_task *task);
+int sunxi_ce_reset(struct sunxi_ce_priv *priv);
+
+#endif

-- 
2.53.0

