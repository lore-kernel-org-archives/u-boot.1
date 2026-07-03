Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D10E1C43458
	for <u-boot@archiver.kernel.org>; Fri,  3 Jul 2026 08:00:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1F83E84A27;
	Fri,  3 Jul 2026 09:59:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="gDZCCCQX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EDEE9849F0; Fri,  3 Jul 2026 03:50:16 +0200 (CEST)
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com
 [IPv6:2607:f8b0:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 53D57848BF
 for <u-boot@lists.denx.de>; Fri,  3 Jul 2026 03:50:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=james.hilliard1@gmail.com
Received: by mail-ot1-x32a.google.com with SMTP id
 46e09a7af769-7e9fc3de7ceso17453a34.1
 for <u-boot@lists.denx.de>; Thu, 02 Jul 2026 18:50:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783043413; x=1783648213; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=zb+S3OTAqCPFoP3EPApJ7CYD0iNbvNilHw4E1mfz5nE=;
 b=gDZCCCQXYbR1+4VgdMNnVH4pOEWYgA9V847SicIRCaJWwkvFZsQYp4c2gn6iIgFXRB
 611BKE29F7hOLEv9Lgq/mlWvz1ONKbImffrepXSjr7Jc2cJ3XEJLES0GA83FSUkZflP4
 EFZ54KrVKvHdt9trBx++OQ4W4ILMDepUpQM1n+uXDSjol+X8Gux81Yk22etYCE4+VU8S
 WBnLLQEc0luPAZYJxfAJUQWeCSL+YI9dX1/4L+FNZds57A04aEbA+wrniPwYQkwqH2g6
 ZTdiEdzAh6Yn7gUpUmDD8wTwBVV0yd39AzfrgwhsFG15bzjoafq6nkiZ9mOWAnRPSonC
 15Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783043413; x=1783648213;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=zb+S3OTAqCPFoP3EPApJ7CYD0iNbvNilHw4E1mfz5nE=;
 b=YEZScO1msdyxdPKIcnEOVzlWzJ730g3aQmSapldSNSvEU8Dbgq+jiJA/VbnR+pfw2N
 sgmdcmXs5PdalLEqLvmQfvh4tO8Lt3DEBRx+RLaLZf8ThTonjm4hxjCtUHLuliEiMYsO
 HqHJ0Xr6jusaUtu/YUYWlMWITZeyN2Lds4DTMs0AcdhT8wXvCQOqTV9Y4KuaZwW42adn
 8Zb/24xSg385DvB4a5qte/99pEs9DCmXwV70dw9acKDboKqOK6fULOc3zTx0Al6aeksP
 +SpzFJSp+R8C94BAhcqjWfrt9kfBoU1ZxaxQKLbcbUlgXnd88y8w0iIniwDrSearjt8C
 DpSg==
X-Gm-Message-State: AOJu0YzVEudaOTIwfxAK2BCTE5zKMfzwezMxhwigqEvNoqNh0iwLQvJr
 gudY+9CNbZFr0ArVoqC47xNVxQQM45mA5SR5++Noeaq2guBoKk/wS5A7
X-Gm-Gg: AfdE7cmgbHkHZ98ymEbo1nEa33GBlB99tvrvzoPtcR/2oDKxnviGlfLyZr2nJKtaDnV
 mA7JLe/BVbPwnOIc4lwO6JyqqnXBNhqq0SQdbS+WeEp1/vkdRFKLDO9DGFPptwpnVmmUNWeik8r
 TLMxd4XRz+D8IdQ4rjjlCktF9sspiQr6Av83CmpylfxwWhLfoW5OUQ0f3h8wyElnWAS+2JZaZ1o
 fMpNkcNS1qKkova+yEbpw76KqY06zbrZ8TrCFrR8AwIiw58MWLqgJNkJKARmDTcCbSEQz/co4Hf
 VGZU/o2cQsSZbwQSk96O32yB53Q4691dL3IUrpBqdPznEtM5SQM6qK70dccEc0f5t+FMO4PaVmq
 Ey3tyXBqgqewkRMA42b89whvcLPt/K/ISmub8X6P15l4aRRe3O36qUNkG6jaN+wEbfbOPP8pory
 KqOKRI86K2HjRZS/0MnNaU1o4PwUrQZn4DnXiTxrCA86bI8Fp9ZhR3VfuLv6+5yDFwilspIg86/
 igl1jABa2/LM+AhydXo8FlUxwB1tS0ewOylGFf6Cs27aQCBoSZiR526wNf2D9YgP55xog==
X-Received: by 2002:a05:6808:8515:b0:497:daad:d03 with SMTP id
 5614622812f47-497daad0fb1mr2253221b6e.36.1783043412849; 
 Thu, 02 Jul 2026 18:50:12 -0700 (PDT)
Received: from [127.0.1.1] (97-118-25-163.hlrn.qwest.net. [97.118.25.163])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-497d1b43cfcsm2974888b6e.14.2026.07.02.18.50.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Jul 2026 18:50:12 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Thu, 02 Jul 2026 19:49:55 -0600
Subject: [PATCH v2 10/10] crypto: allwinner: add sun8i-ce hash driver
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260702-submit-ce-series-v2-v2-10-ffda5bed58af@gmail.com>
References: <20260702-submit-ce-series-v2-v2-0-ffda5bed58af@gmail.com>
In-Reply-To: <20260702-submit-ce-series-v2-v2-0-ffda5bed58af@gmail.com>
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
 Jerome Forissier <jerome.forissier@arm.com>
X-Mailer: b4 0.15.2
X-Mailman-Approved-At: Fri, 03 Jul 2026 09:59:22 +0200
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

The Allwinner sun8i Crypto Engine includes hardware hash methods. Add a
UCLASS_HASH child for the sun8i-ce parent so FIT hash verification can
use the accelerator from U-Boot proper and SPL.

Support MD5, SHA1, SHA256, SHA384 and SHA512 using the CE one-shot task
interface. Build the final hash padding in the driver and bounce
word-unaligned input so FIT data with short or unaligned tails can be
hashed directly.

H6 and H616 use bit-sized hash task lengths, so reject inputs whose
padded length would overflow the 32-bit task descriptor field. Feed the
watchdog from the shared CE polling path while waiting for hardware
completion.

In SPL, only advertise hash algorithms selected for that phase so
SRAM-constrained builds do not accept wider algorithms unless requested.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
Changes v1 -> v2:
  - Reject oversized bit-length hash tasks  (suggested by Simon Glass)
  - Feed the watchdog while polling CE completion  (suggested by Simon Glass)
  - Drop the post-operation schedule() call  (suggested by Simon Glass)
  - Bounce only word-unaligned input
---
 drivers/crypto/allwinner/sun8i-ce/Kconfig         |  26 ++
 drivers/crypto/allwinner/sun8i-ce/Makefile        |   1 +
 drivers/crypto/allwinner/sun8i-ce/sun8i-ce-core.c |  55 ++--
 drivers/crypto/allwinner/sun8i-ce/sun8i-ce-hash.c | 298 ++++++++++++++++++++++
 drivers/crypto/allwinner/sun8i-ce/sun8i-ce.h      |   7 +
 5 files changed, 372 insertions(+), 15 deletions(-)

diff --git a/drivers/crypto/allwinner/sun8i-ce/Kconfig b/drivers/crypto/allwinner/sun8i-ce/Kconfig
index e780638d86f..c9ca8141ba6 100644
--- a/drivers/crypto/allwinner/sun8i-ce/Kconfig
+++ b/drivers/crypto/allwinner/sun8i-ce/Kconfig
@@ -38,6 +38,32 @@ config SPL_SUNXI_CE_AES
 	  Engine found in Allwinner H6 and H616 compatible SoCs. This can be
 	  used to decrypt FIT images before loading U-Boot proper.
 
+config SUNXI_CE_HASH
+	bool "Allwinner sunxi CE hash"
+	depends on ARCH_SUNXI
+	depends on DM_HASH
+	depends on CLK && DM_RESET
+	select SUNXI_CE
+	help
+	  Select this option to enable hash calculation using the Crypto Engine
+	  found in Allwinner sunxi SoCs. The driver supports MD5, SHA1,
+	  SHA256, SHA384 and SHA512.
+
+config SPL_SUNXI_CE_HASH
+	bool "Allwinner sunxi CE hash in SPL"
+	depends on ARCH_SUNXI
+	depends on MACH_SUN50I_H6 || MACH_SUN50I_H616
+	depends on SPL_DM
+	depends on SPL_OF_CONTROL
+	select SPL_DM_HASH
+	select SPL_CRYPTO
+	select SPL_SUNXI_CE
+	help
+	  Select this option to enable hash calculation in SPL using the Crypto
+	  Engine found in Allwinner H6 and H616 compatible SoCs. FIT image
+	  hashes can then be calculated by the hardware accelerator before
+	  U-Boot proper is loaded.
+
 config SUNXI_CE_ECDSA
 	bool "Allwinner sunxi CE ECDSA verifier"
 	depends on ARCH_SUNXI
diff --git a/drivers/crypto/allwinner/sun8i-ce/Makefile b/drivers/crypto/allwinner/sun8i-ce/Makefile
index 753ea827a0d..5baf65e40ec 100644
--- a/drivers/crypto/allwinner/sun8i-ce/Makefile
+++ b/drivers/crypto/allwinner/sun8i-ce/Makefile
@@ -2,4 +2,5 @@
 
 obj-$(CONFIG_$(PHASE_)SUNXI_CE) += sun8i-ce-core.o
 obj-$(CONFIG_$(PHASE_)SUNXI_CE_AES) += sun8i-ce-aes.o
+obj-$(CONFIG_$(PHASE_)SUNXI_CE_HASH) += sun8i-ce-hash.o
 obj-$(CONFIG_$(PHASE_)SUNXI_CE_ECDSA) += sun8i-ce-ecdsa.o
diff --git a/drivers/crypto/allwinner/sun8i-ce/sun8i-ce-core.c b/drivers/crypto/allwinner/sun8i-ce/sun8i-ce-core.c
index 743a93ca3d3..ed0ac8b025f 100644
--- a/drivers/crypto/allwinner/sun8i-ce/sun8i-ce-core.c
+++ b/drivers/crypto/allwinner/sun8i-ce/sun8i-ce-core.c
@@ -7,11 +7,13 @@
 #include <dm.h>
 #include <dm/device_compat.h>
 #include <dm/lists.h>
+#include <errno.h>
+#include <time.h>
+#include <u-boot/schedule.h>
 #include <asm/arch/cpu.h>
 #include <asm/cache.h>
 #include <asm/io.h>
 #include <linux/delay.h>
-#include <linux/iopoll.h>
 #include "sun8i-ce.h"
 
 #define SUNXI_CE_TDQ			0x00
@@ -77,6 +79,25 @@ static void sunxi_ce_print_error(u32 err)
 		printf("CE ERROR: key ladder configuration error\n");
 }
 
+static int sunxi_ce_wait(void __iomem *addr, u32 mask, u32 expect)
+{
+	unsigned long timeout = timer_get_us() + SUNXI_CE_TIMEOUT_US;
+	u32 val;
+
+	do {
+		val = readl(addr);
+		if ((val & mask) == expect)
+			return 0;
+		schedule();
+	} while (!time_after(timer_get_us(), timeout));
+
+	val = readl(addr);
+	if ((val & mask) == expect)
+		return 0;
+
+	return -ETIMEDOUT;
+}
+
 int sunxi_ce_run_task(struct sunxi_ce_priv *priv, struct sunxi_ce_task *task)
 {
 	u32 method = task->t_common_ctl & SUNXI_CE_METHOD_MASK;
@@ -87,15 +108,12 @@ int sunxi_ce_run_task(struct sunxi_ce_priv *priv, struct sunxi_ce_task *task)
 	writel(val | SUNXI_CE_CHAN_INT, priv->base + SUNXI_CE_ICR);
 	writel(SUNXI_CE_CHAN_INT, priv->base + SUNXI_CE_ISR);
 	writel(SUNXI_CE_CHAN_ERR_MASK, priv->base + SUNXI_CE_ESR);
-	ret = readl_poll_timeout(priv->base + SUNXI_CE_ISR, val,
-				 !(val & SUNXI_CE_CHAN_INT),
-				 SUNXI_CE_TIMEOUT_US);
+	ret = sunxi_ce_wait(priv->base + SUNXI_CE_ISR, SUNXI_CE_CHAN_INT, 0);
 	if (ret) {
 		printf("%s: timeout waiting for stale interrupt\n", __func__);
 		return ret;
 	}
-	ret = readl_poll_timeout(priv->base + SUNXI_CE_TLR, val, !val,
-				 SUNXI_CE_TIMEOUT_US);
+	ret = sunxi_ce_wait(priv->base + SUNXI_CE_TLR, ~0U, 0);
 	if (ret) {
 		printf("%s: timeout waiting for task launcher\n", __func__);
 		return ret;
@@ -108,9 +126,8 @@ int sunxi_ce_run_task(struct sunxi_ce_priv *priv, struct sunxi_ce_task *task)
 	writel((method << SUNXI_CE_TLR_METHOD_SHIFT) | SUNXI_CE_TASK_START,
 	       priv->base + SUNXI_CE_TLR);
 
-	ret = readl_poll_timeout(priv->base + SUNXI_CE_ISR, val,
-				 val & SUNXI_CE_CHAN_INT,
-				 SUNXI_CE_TIMEOUT_US);
+	ret = sunxi_ce_wait(priv->base + SUNXI_CE_ISR, SUNXI_CE_CHAN_INT,
+			    SUNXI_CE_CHAN_INT);
 	if (ret) {
 		printf("%s: DMA timeout\n", __func__);
 		writel(SUNXI_CE_CHAN_INT, priv->base + SUNXI_CE_ISR);
@@ -118,14 +135,12 @@ int sunxi_ce_run_task(struct sunxi_ce_priv *priv, struct sunxi_ce_task *task)
 		return ret;
 	}
 
-	ret = readl_poll_timeout(priv->base + SUNXI_CE_SCSA, val, !val,
-				 SUNXI_CE_TIMEOUT_US);
+	ret = sunxi_ce_wait(priv->base + SUNXI_CE_SCSA, ~0U, 0);
 	if (ret) {
 		printf("%s: timeout waiting for source DMA idle\n", __func__);
 		return ret;
 	}
-	ret = readl_poll_timeout(priv->base + SUNXI_CE_SCDA, val, !val,
-				 SUNXI_CE_TIMEOUT_US);
+	ret = sunxi_ce_wait(priv->base + SUNXI_CE_SCDA, ~0U, 0);
 	if (ret) {
 		printf("%s: timeout waiting for destination DMA idle\n",
 		       __func__);
@@ -135,8 +150,7 @@ int sunxi_ce_run_task(struct sunxi_ce_priv *priv, struct sunxi_ce_task *task)
 	writel(0, priv->base + SUNXI_CE_TLR);
 	clrbits_le32(priv->base + SUNXI_CE_ICR, SUNXI_CE_CHAN_INT);
 	writel(0, priv->base + SUNXI_CE_TDQ);
-	ret = readl_poll_timeout(priv->base + SUNXI_CE_TLR, val, !val,
-				 SUNXI_CE_TIMEOUT_US);
+	ret = sunxi_ce_wait(priv->base + SUNXI_CE_TLR, ~0U, 0);
 	if (ret) {
 		printf("%s: timeout clearing task launcher\n", __func__);
 		return ret;
@@ -259,6 +273,13 @@ static int sunxi_ce_bind(struct udevice *dev)
 			return ret;
 	}
 
+	if (CONFIG_IS_ENABLED(SUNXI_CE_HASH) && variant->has_hash) {
+		ret = device_bind_driver(dev, "sun8i-ce-hash",
+					 "sun8i-ce-hash", NULL);
+		if (ret)
+			return ret;
+	}
+
 	return 0;
 }
 
@@ -345,7 +366,9 @@ static int sunxi_ce_remove(struct udevice *dev)
 
 static const struct sunxi_ce_variant sun50i_h6_variant = {
 	.has_aes = true,
+	.has_hash = true,
 	.cipher_t_dlen_in_bytes = true,
+	.hash_t_dlen_in_bits = true,
 	.spl_enable_clocks = sun50i_h6_ce_spl_enable_clocks,
 	.spl_reset = sun50i_h6_ce_spl_reset,
 };
@@ -353,7 +376,9 @@ static const struct sunxi_ce_variant sun50i_h6_variant = {
 static const struct sunxi_ce_variant sun50i_h616_variant = {
 	.has_aes = true,
 	.has_ecdsa = true,
+	.has_hash = true,
 	.cipher_t_dlen_in_bytes = true,
+	.hash_t_dlen_in_bits = true,
 	.needs_word_addresses = true,
 	.setup_mod_clock = sun50i_h616_ce_setup_mod_clock,
 	.spl_enable_clocks = sun50i_h616_ce_spl_enable_clocks,
diff --git a/drivers/crypto/allwinner/sun8i-ce/sun8i-ce-hash.c b/drivers/crypto/allwinner/sun8i-ce/sun8i-ce-hash.c
new file mode 100644
index 00000000000..64c4c2646e0
--- /dev/null
+++ b/drivers/crypto/allwinner/sun8i-ce/sun8i-ce-hash.c
@@ -0,0 +1,298 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2026 James Hilliard
+ */
+
+#define LOG_CATEGORY UCLASS_HASH
+
+#include <dm.h>
+#include <malloc.h>
+#include <memalign.h>
+#include <u-boot/hash.h>
+#include <u-boot/md5.h>
+#include <u-boot/sha1.h>
+#include <u-boot/sha256.h>
+#include <u-boot/sha512.h>
+#include <linux/dma-mapping.h>
+#include <linux/kernel.h>
+#include "sun8i-ce.h"
+
+#define SUNXI_CE_HASH_MAX_BLOCK_SIZE	SHA512_BLOCK_SIZE
+#define SUNXI_CE_HASH_MAX_DIGEST_SIZE	SHA512_SUM_LEN
+#define SUNXI_CE_HASH_MAX_PAD_SIZE	(2 * SUNXI_CE_HASH_MAX_BLOCK_SIZE)
+
+struct sunxi_hash_algo {
+	enum HASH_ALGO algo;
+	u32 method;
+	u32 digest_size;
+	u32 result_size;
+	u32 block_size;
+	bool le_len;
+};
+
+struct sunxi_hash_job {
+	struct sunxi_ce_task task __aligned(ARCH_DMA_MINALIGN);
+	u8 pad[SUNXI_CE_HASH_MAX_PAD_SIZE] __aligned(ARCH_DMA_MINALIGN);
+	u8 result[SUNXI_CE_HASH_MAX_DIGEST_SIZE] __aligned(ARCH_DMA_MINALIGN);
+};
+
+static const struct sunxi_hash_algo sunxi_hash_algos[] = {
+	{
+		.algo = HASH_ALGO_MD5,
+		.method = SUNXI_CE_METHOD_MD5,
+		.digest_size = MD5_SUM_LEN,
+		.result_size = MD5_SUM_LEN,
+		.block_size = 64,
+		.le_len = true,
+	},
+	{
+		.algo = HASH_ALGO_SHA1,
+		.method = SUNXI_CE_METHOD_SHA1,
+		.digest_size = SHA1_SUM_LEN,
+		.result_size = SHA1_SUM_LEN,
+		.block_size = 64,
+	},
+	{
+		.algo = HASH_ALGO_SHA256,
+		.method = SUNXI_CE_METHOD_SHA256,
+		.digest_size = SHA256_SUM_LEN,
+		.result_size = SHA256_SUM_LEN,
+		.block_size = 64,
+	},
+	{
+		.algo = HASH_ALGO_SHA384,
+		.method = SUNXI_CE_METHOD_SHA384,
+		.digest_size = SHA384_SUM_LEN,
+		.result_size = SHA512_SUM_LEN,
+		.block_size = SHA512_BLOCK_SIZE,
+	},
+	{
+		.algo = HASH_ALGO_SHA512,
+		.method = SUNXI_CE_METHOD_SHA512,
+		.digest_size = SHA512_SUM_LEN,
+		.result_size = SHA512_SUM_LEN,
+		.block_size = SHA512_BLOCK_SIZE,
+	},
+};
+
+static bool sunxi_hash_algo_enabled(enum HASH_ALGO algo)
+{
+	if (!IS_ENABLED(CONFIG_XPL_BUILD))
+		return true;
+
+	switch (algo) {
+	case HASH_ALGO_MD5:
+		return CONFIG_IS_ENABLED(MD5);
+	case HASH_ALGO_SHA1:
+		return CONFIG_IS_ENABLED(SHA1);
+	case HASH_ALGO_SHA256:
+		return CONFIG_IS_ENABLED(SHA256);
+	case HASH_ALGO_SHA384:
+		return CONFIG_IS_ENABLED(SHA384);
+	case HASH_ALGO_SHA512:
+		return CONFIG_IS_ENABLED(SHA512);
+	default:
+		return false;
+	}
+}
+
+static const struct sunxi_hash_algo *sunxi_hash_find_algo(enum HASH_ALGO algo)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(sunxi_hash_algos); i++) {
+		if (sunxi_hash_algos[i].algo == algo &&
+		    sunxi_hash_algo_enabled(algo))
+			return &sunxi_hash_algos[i];
+	}
+
+	return NULL;
+}
+
+static size_t sunxi_hash_pad(const struct sunxi_hash_algo *algo, u8 *pad,
+			     const u8 *tail, size_t tail_len, u32 len)
+{
+	size_t aligned_len = ALIGN_DOWN(len, sizeof(u32));
+	size_t rem = len % algo->block_size;
+	size_t len_size = algo->block_size == SHA512_BLOCK_SIZE ? 16 : 8;
+	size_t total_len, pad_len, len_off;
+	u64 bits;
+
+	total_len = rem < algo->block_size - len_size ?
+		    len + algo->block_size - rem :
+		    len + 2 * algo->block_size - rem;
+	pad_len = total_len - aligned_len;
+	if (pad_len > SUNXI_CE_HASH_MAX_PAD_SIZE)
+		return 0;
+
+	memset(pad, 0, pad_len);
+	if (tail_len)
+		memcpy(pad, tail, tail_len);
+	pad[tail_len] = 0x80;
+
+	bits = (u64)len << 3;
+	len_off = pad_len - 8;
+	if (algo->le_len) {
+		bits = cpu_to_le64(bits);
+		memcpy(pad + len_off, &bits, sizeof(bits));
+	} else {
+		bits = cpu_to_be64(bits);
+		memcpy(pad + len_off, &bits, sizeof(bits));
+	}
+
+	return pad_len;
+}
+
+static void sunxi_hash_fill_task(struct sunxi_ce_priv *ce,
+				 struct sunxi_hash_job *job,
+				 const struct sunxi_hash_algo *algo,
+				 dma_addr_t src, size_t src_len,
+				 dma_addr_t pad, size_t pad_len,
+				 dma_addr_t result)
+{
+	struct sunxi_ce_task *task = &job->task;
+	u32 total_len = src_len + pad_len;
+	u32 sg = 0;
+
+	memset(task, 0, sizeof(*task));
+
+	task->t_id = SUNXI_CE_CHAN;
+	task->t_common_ctl = SUNXI_CE_COMM_INT | algo->method;
+	task->t_dlen = ce->variant->hash_t_dlen_in_bits ?
+		       total_len * 8 : total_len / sizeof(u32);
+
+	if (src_len) {
+		task->t_src[sg].addr = sunxi_ce_desc_dma_addr(ce, src);
+		task->t_src[sg].len = src_len / sizeof(u32);
+		sg++;
+	}
+	task->t_src[sg].addr = sunxi_ce_desc_dma_addr(ce, pad);
+	task->t_src[sg].len = pad_len / sizeof(u32);
+
+	task->t_dst[0].addr = sunxi_ce_desc_dma_addr(ce, result);
+	task->t_dst[0].len = algo->result_size / sizeof(u32);
+}
+
+static int sunxi_hash_run(struct sunxi_ce_priv *ce, struct sunxi_hash_job *job,
+			  const struct sunxi_hash_algo *algo,
+			  const void *src, size_t src_len, size_t pad_len,
+			  size_t result_len)
+{
+	dma_addr_t src_dma = 0, pad_dma, result_dma;
+	int ret;
+
+	if (src_len) {
+		src_dma = dma_map_single((void *)src, src_len,
+					 DMA_TO_DEVICE);
+		if (dma_mapping_error(NULL, src_dma))
+			return -EIO;
+	}
+
+	pad_dma = dma_map_single(job->pad, pad_len, DMA_TO_DEVICE);
+	if (dma_mapping_error(NULL, pad_dma)) {
+		ret = -EIO;
+		goto out_unmap_src;
+	}
+
+	result_dma = dma_map_single(job->result, result_len, DMA_FROM_DEVICE);
+	if (dma_mapping_error(NULL, result_dma)) {
+		ret = -EIO;
+		goto out_unmap_pad;
+	}
+
+	sunxi_hash_fill_task(ce, job, algo, src_dma, src_len, pad_dma,
+			     pad_len, result_dma);
+	sunxi_ce_flush(&job->task, sizeof(job->task));
+
+	ret = sunxi_ce_run_task(ce, &job->task);
+
+	dma_unmap_single(result_dma, result_len, DMA_FROM_DEVICE);
+out_unmap_pad:
+	dma_unmap_single(pad_dma, pad_len, DMA_TO_DEVICE);
+out_unmap_src:
+	if (src_len)
+		dma_unmap_single(src_dma, src_len, DMA_TO_DEVICE);
+
+	return ret;
+}
+
+static int sunxi_hash_digest(struct udevice *dev, enum HASH_ALGO hash_algo,
+			     const void *ibuf, const uint32_t ilen, void *obuf)
+{
+	const struct sunxi_hash_algo *algo = sunxi_hash_find_algo(hash_algo);
+	struct sunxi_ce_priv *ce = dev_get_priv(dev_get_parent(dev));
+	size_t src_len = ALIGN_DOWN(ilen, sizeof(u32));
+	size_t tail_len = ilen - src_len;
+	struct sunxi_hash_job *job;
+	const void *src = ibuf;
+	u8 *src_buf = NULL;
+	const u8 *tail = ibuf;
+	size_t pad_len;
+	int ret;
+
+	if (!algo || (!ibuf && ilen) || !obuf)
+		return -EINVAL;
+
+	job = malloc_cache_aligned(sizeof(*job));
+	if (!job)
+		return -ENOMEM;
+
+	memset(job, 0, sizeof(*job));
+
+	if (src_len && !IS_ALIGNED((ulong)ibuf, sizeof(u32))) {
+		src_buf = memalign(ARCH_DMA_MINALIGN,
+				   ALIGN(src_len, ARCH_DMA_MINALIGN));
+		if (!src_buf) {
+			ret = -ENOMEM;
+			goto out;
+		}
+		memcpy(src_buf, ibuf, src_len);
+		src = src_buf;
+	}
+
+	if (tail_len)
+		tail += src_len;
+
+	pad_len = sunxi_hash_pad(algo, job->pad, tail, tail_len, ilen);
+	if (!pad_len) {
+		ret = -EINVAL;
+		goto out;
+	}
+	if (ce->variant->hash_t_dlen_in_bits &&
+	    src_len + pad_len > U32_MAX / 8) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	ret = sunxi_hash_run(ce, job, algo, src, src_len, pad_len,
+			     algo->result_size);
+	if (ret)
+		goto out;
+
+	memcpy(obuf, job->result, algo->digest_size);
+
+out:
+	free(src_buf);
+	free(job);
+
+	return ret;
+}
+
+static int sunxi_hash_digest_wd(struct udevice *dev, enum HASH_ALGO algo,
+				const void *ibuf, const uint32_t ilen,
+				void *obuf, uint32_t chunk_sz)
+{
+	return sunxi_hash_digest(dev, algo, ibuf, ilen, obuf);
+}
+
+static const struct hash_ops sunxi_hash_ops = {
+	.hash_digest = sunxi_hash_digest,
+	.hash_digest_wd = sunxi_hash_digest_wd,
+};
+
+U_BOOT_DRIVER(sun8i_ce_hash) = {
+	.name = "sun8i-ce-hash",
+	.id = UCLASS_HASH,
+	.ops = &sunxi_hash_ops,
+	.flags = DM_FLAG_PRE_RELOC,
+};
diff --git a/drivers/crypto/allwinner/sun8i-ce/sun8i-ce.h b/drivers/crypto/allwinner/sun8i-ce/sun8i-ce.h
index 7facd6d89ad..c3d235a43cc 100644
--- a/drivers/crypto/allwinner/sun8i-ce/sun8i-ce.h
+++ b/drivers/crypto/allwinner/sun8i-ce/sun8i-ce.h
@@ -15,6 +15,11 @@
 #define SUNXI_CE_CHAN_INT		BIT(SUNXI_CE_CHAN)
 #define SUNXI_CE_COMM_INT		BIT(31)
 #define SUNXI_CE_METHOD_AES		0
+#define SUNXI_CE_METHOD_MD5		16
+#define SUNXI_CE_METHOD_SHA1		17
+#define SUNXI_CE_METHOD_SHA256		19
+#define SUNXI_CE_METHOD_SHA384		20
+#define SUNXI_CE_METHOD_SHA512		21
 #define SUNXI_CE_METHOD_ECC		33
 #define SUNXI_CE_ECC_OP_VERIFY		7
 #define SUNXI_CE_ECC_OP_SHIFT		16
@@ -43,7 +48,9 @@ struct sunxi_ce_task {
 struct sunxi_ce_variant {
 	bool has_aes;
 	bool has_ecdsa;
+	bool has_hash;
 	bool cipher_t_dlen_in_bytes;
+	bool hash_t_dlen_in_bits;
 	bool needs_word_addresses;
 	void (*setup_mod_clock)(void);
 	void (*spl_enable_clocks)(void);

-- 
2.53.0

