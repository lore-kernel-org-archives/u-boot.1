Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 381D3C43458
	for <u-boot@archiver.kernel.org>; Mon, 13 Jul 2026 13:23:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3E86484BC8;
	Mon, 13 Jul 2026 15:21:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="AR8icnJN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D92AE84A4A; Mon, 13 Jul 2026 08:44:06 +0200 (CEST)
Received: from mail-oo1-xc35.google.com (mail-oo1-xc35.google.com
 [IPv6:2607:f8b0:4864:20::c35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 433D784A51
 for <u-boot@lists.denx.de>; Mon, 13 Jul 2026 08:44:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=james.hilliard1@gmail.com
Received: by mail-oo1-xc35.google.com with SMTP id
 006d021491bc7-6a382104a85so1600841eaf.2
 for <u-boot@lists.denx.de>; Sun, 12 Jul 2026 23:44:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783925043; x=1784529843; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=AnR3LuO4KY+ko6f6JTiFuNi4+hxyk1ocjOG8PUzcwWk=;
 b=AR8icnJNduT9Q3cCGckDvG4792ipaUlNzvTSvuHOXusRwFtefpezGd6TIabeIbfTKX
 r7TAFzhKNqzYfcGEWoeV08qImVqwTe4FAJkx9KS9kYN72Zl1EOAdbYTv4whgEXKfD7jX
 uOYNS4wdJYHEyn02jPMsha2amPJbXWTq/ror1Tg3y9WnBlCMko5UcDgClELaETtFBEkx
 uPaEk45UtcQM4VlzFPK4wK6+QhwoXBINu512x91xbxjqgL0VFwtXdLziwc9NXKiksigG
 shJp8jGUncM7DTvjy9bN2HrwW5HNnvVuX4MAGr4LSFuhUwrNnmcB+8uikyLm+ydedVNB
 /Nug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783925043; x=1784529843;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=AnR3LuO4KY+ko6f6JTiFuNi4+hxyk1ocjOG8PUzcwWk=;
 b=ePayuaoS/8/b2aIz4t1IVxh8yll55gZeAbTLyq5yUBzGU7LCuna/7KhswB1+JkV+t7
 NJdiT+Arg45hIJBn3IX/MFexuvvX8ndzkX+/TbT+0JM7Zy4xaRWLgq7MN/y6BUmZkrGL
 85YToVo5/tusQSC9TsemStkGiVJPldRL+CkUKNWtlBDHEt0f5GEnPYgUfDx1nYZj5J3B
 P7LP6BIWKgVYemwEQrDkZzexnyy1FqEDukcX0TJkS8UlZEbXZKJmEWX3B68lNZbkaRjs
 wPuSPLrxdkBg5YzYjxa8TsC23Kkq9VL/CEroY60gWZAxnHa/goL2Dt+V2MWsc7yDiReg
 r+Qg==
X-Forwarded-Encrypted: i=1;
 AFNElJ/GbUELoueltTN1A78JhFsKI7HfVEhxneASRP8RaSz0Ft7E1fRkdrfP0IprNoNGS4Vp28hcJL4=@lists.denx.de
X-Gm-Message-State: AOJu0YxTcfec2sU9fnOHIr5jfJn34WrYY2DZZlL0AdjIC1pPDSDBmxFV
 HcO7hUY66XafBbyloLHKlsiJN4WDJufE/CCK1tXOJYaqbRsjUKbADn+m
X-Gm-Gg: AfdE7cli9vNmUtc4lUpVuzy8N9YDQaHWLzFp40V1XXX1RBrEexRGeGD5em07OueUB9L
 6N4/HgGEmGTBHS50x1BflCeHGv9YAx/EyeIMIxqlSx/7bjpj+JWYApHs4kawI9d9kr0tqoN3TFh
 g5YKg0MOQuxWZ9ldPHUKiVLsiUwWBAPKhQbMmb4ndz6nDeYaebGazGahQ0MyGD1iFeBSf/nYCMN
 MQ3NKpX90BRgHROFKBwntpw5Qq69kJ9rLEQieMhmQE29oZlKfsj0Doy+gFm0s168U7ADQnyjLhr
 Gfh+zhC0D7yxUszQ9+oOdw6dmpgfpCHfELqsCMQGNNGPmqTNjUd2QuqDfM9F65kAbac26tBh3g+
 se1K5KKDGmBpLpFrpdUae7sTKxDwQZoKb5ZlddvYS9xzuT3Vve0CHFl/NquOHQHrVX/Tjk0yzPq
 lra2csUrcK7jDGc1wLAPkbLy7y1aL5G/emA0fJqIDxl+TxplDyjiUcx1/9hYNRPWR6k5eomGySu
 eXgwcjsFJGDRwlNMLz5jDiNMnhiqwQkpZ8Bq8JldXT3HQgFxellXRBiCUHjDJoA
X-Received: by 2002:a05:6820:81cb:b0:6a3:759d:c418 with SMTP id
 006d021491bc7-6a39a863ac2mr4706949eaf.71.1783925042942; 
 Sun, 12 Jul 2026 23:44:02 -0700 (PDT)
Received: from [127.0.1.1] (174-29-11-8.hlrn.qwest.net. [174.29.11.8])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-451916ce98dsm12538126fac.13.2026.07.12.23.44.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 12 Jul 2026 23:44:02 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Mon, 13 Jul 2026 00:43:11 -0600
Subject: [PATCH v4 14/14] crypto: allwinner: add sun8i-ce hash driver
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260713-submit-ce-series-v2-v4-14-ff7edc705b8a@gmail.com>
References: <20260713-submit-ce-series-v2-v4-0-ff7edc705b8a@gmail.com>
In-Reply-To: <20260713-submit-ce-series-v2-v4-0-ff7edc705b8a@gmail.com>
To: Svyatoslav Ryhel <clamor95@gmail.com>, Ion Agorria <ion@agorria.com>, 
 u-boot@lists.denx.de, Aspeed BMC SW team <BMC-SW@aspeedtech.com>, 
 Joel Stanley <joel@jms.id.au>
Cc: Chen-Yu Tsai <wens@kernel.org>, Samuel Holland <samuel@sholland.org>, 
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Thierry Reding <treding@nvidia.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Rasmus Villemoes <ravi@prevas.dk>, Aristo Chen <aristo.chen@canonical.com>, 
 Anton Ivanov <anton@binarly.io>, Daniel Golle <daniel@makrotopia.org>, 
 Francois Berder <fberder@outlook.fr>, Peng Fan <peng.fan@nxp.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Randolph Sapp <rs@ti.com>, 
 Jonas Karlman <jonas@kwiboo.se>, 
 Wolfgang Wallner <wolfgang.wallner@at.abb.com>, 
 Alexey Charkov <alchark@gmail.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Heiko Schocher <hs@nabladev.com>, 
 "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>, 
 Anshul Dalal <anshuld@ti.com>, Johan Jonker <jbx6244@gmail.com>, 
 Francesco Valla <francesco@valla.it>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Michael Walle <mwalle@kernel.org>, 
 Andre Przywara <andre.przywara@arm.com>, Lukasz Majewski <lukma@denx.de>, 
 Richard Genoud <richard.genoud@bootlin.com>, 
 Michael Trimarchi <michael@amarulasolutions.com>, 
 E Shattow <e@freeshell.de>, Enric Balletbo i Serra <eballetbo@kernel.org>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Lucas Dietrich <ld.adecy@gmail.com>, David Lechner <dlechner@baylibre.com>, 
 Julien Stephan <jstephan@baylibre.com>, 
 Kuan-Wei Chiu <visitorckw@gmail.com>, 
 Bastien Curutchet <bastien.curutchet@bootlin.com>, 
 Raymond Mao <raymond.mao@riscstar.com>, 
 Ryan Chen <ryan_chen@aspeedtech.com>, 
 Chia-Wei Wang <chiawei_wang@aspeedtech.com>, 
 "Lucien.Jheng" <lucienzx159@gmail.com>, 
 Mateusz Furdyna <mateusz.furdyna@nokia.com>, 
 Dinesh Maniyam <dinesh.maniyam@altera.com>, 
 Heiko Stuebner <heiko@sntech.de>, 
 James Hilliard <james.hilliard1@gmail.com>
X-Mailer: b4 0.15.2
X-Mailman-Approved-At: Mon, 13 Jul 2026 15:20:59 +0200
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
hashed directly. Submit hash work on its dedicated completion channel
through the parent's task-session API.

H6 and H616 use bit-sized hash task lengths, so reject inputs whose
padded length would overflow the 32-bit task descriptor field. Feed the
watchdog from the shared CE polling path while waiting for hardware
completion.

In SPL, only advertise hash algorithms selected for that phase so
SRAM-constrained builds do not accept wider algorithms unless requested.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
Changes v3 -> v4:
  - Consolidate algorithm selection and invariant task sizing
  - Use the dedicated hash channel and shared task-session path
  - Return -EOPNOTSUPP for unavailable algorithms

Changes v1 -> v2:
  - Reject oversized bit-length hash tasks  (suggested by Simon Glass)
  - Feed the watchdog while polling CE completion  (suggested by Simon Glass)
  - Drop the post-operation schedule() call  (suggested by Simon Glass)
  - Bounce only word-unaligned input
---
 drivers/crypto/allwinner/sun8i-ce/Kconfig         |  26 +++
 drivers/crypto/allwinner/sun8i-ce/Makefile        |   1 +
 drivers/crypto/allwinner/sun8i-ce/sun8i-ce-core.c |  23 ++-
 drivers/crypto/allwinner/sun8i-ce/sun8i-ce-hash.c | 238 ++++++++++++++++++++++
 drivers/crypto/allwinner/sun8i-ce/sun8i-ce.h      |  11 +-
 5 files changed, 292 insertions(+), 7 deletions(-)

diff --git a/drivers/crypto/allwinner/sun8i-ce/Kconfig b/drivers/crypto/allwinner/sun8i-ce/Kconfig
index dedfa835775..b906bc222cc 100644
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
index c8c4e1c24bc..4f80334a9a0 100644
--- a/drivers/crypto/allwinner/sun8i-ce/sun8i-ce-core.c
+++ b/drivers/crypto/allwinner/sun8i-ce/sun8i-ce-core.c
@@ -123,6 +123,12 @@ static u32 sunxi_ce_method_engine(u32 method)
 		return SUNXI_CE_ENGINE_AES;
 	case SUNXI_CE_METHOD_RAES:
 		return SUNXI_CE_ENGINE_RAES;
+	case SUNXI_CE_METHOD_MD5:
+	case SUNXI_CE_METHOD_SHA1:
+	case SUNXI_CE_METHOD_SHA256:
+	case SUNXI_CE_METHOD_SHA384:
+	case SUNXI_CE_METHOD_SHA512:
+		return SUNXI_CE_ENGINE_HASH;
 	case SUNXI_CE_METHOD_ECC:
 		return SUNXI_CE_ENGINE_ASYM;
 	default:
@@ -586,20 +592,29 @@ static void sun50i_h616_ce_spl_enable_clocks(void)
 	sun50i_h6_ce_spl_reset();
 }
 
+static int sunxi_ce_bind_child(struct udevice *dev, const char *name)
+{
+	return device_bind_driver(dev, name, name, NULL);
+}
+
 static int sunxi_ce_bind(struct udevice *dev)
 {
 	int ret;
 
 	if (CONFIG_IS_ENABLED(SUNXI_CE_AES)) {
-		ret = device_bind_driver(dev, "sun8i-ce-aes",
-					 "sun8i-ce-aes", NULL);
+		ret = sunxi_ce_bind_child(dev, "sun8i-ce-aes");
 		if (ret)
 			return ret;
 	}
 
 	if (CONFIG_IS_ENABLED(SUNXI_CE_ECDSA)) {
-		ret = device_bind_driver(dev, "sun8i-ce-ecdsa",
-					 "sun8i-ce-ecdsa", NULL);
+		ret = sunxi_ce_bind_child(dev, "sun8i-ce-ecdsa");
+		if (ret)
+			return ret;
+	}
+
+	if (CONFIG_IS_ENABLED(SUNXI_CE_HASH)) {
+		ret = sunxi_ce_bind_child(dev, "sun8i-ce-hash");
 		if (ret)
 			return ret;
 	}
diff --git a/drivers/crypto/allwinner/sun8i-ce/sun8i-ce-hash.c b/drivers/crypto/allwinner/sun8i-ce/sun8i-ce-hash.c
new file mode 100644
index 00000000000..da725ed0a08
--- /dev/null
+++ b/drivers/crypto/allwinner/sun8i-ce/sun8i-ce-hash.c
@@ -0,0 +1,238 @@
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
+#include <u-boot/sha512.h>
+#include <linux/dma-mapping.h>
+#include <linux/kernel.h>
+#include "sun8i-ce.h"
+
+#define SUNXI_CE_HASH_MAX_BLOCK_SIZE	SHA512_BLOCK_SIZE
+#define SUNXI_CE_HASH_MAX_DIGEST_SIZE	SHA512_SUM_LEN
+#define SUNXI_CE_HASH_MAX_PAD_SIZE	(2 * SUNXI_CE_HASH_MAX_BLOCK_SIZE)
+
+struct sunxi_hash_job {
+	struct sunxi_ce_task task __aligned(ARCH_DMA_MINALIGN);
+	u8 pad[SUNXI_CE_HASH_MAX_PAD_SIZE] __aligned(ARCH_DMA_MINALIGN);
+	u8 result[SUNXI_CE_HASH_MAX_DIGEST_SIZE] __aligned(ARCH_DMA_MINALIGN);
+};
+
+static int sunxi_hash_method(enum HASH_ALGO algo)
+{
+	switch (algo) {
+	case HASH_ALGO_MD5:
+		if (IS_ENABLED(CONFIG_XPL_BUILD) && !CONFIG_IS_ENABLED(MD5))
+			return -EOPNOTSUPP;
+		return SUNXI_CE_METHOD_MD5;
+	case HASH_ALGO_SHA1:
+		if (IS_ENABLED(CONFIG_XPL_BUILD) && !CONFIG_IS_ENABLED(SHA1))
+			return -EOPNOTSUPP;
+		return SUNXI_CE_METHOD_SHA1;
+	case HASH_ALGO_SHA256:
+		if (IS_ENABLED(CONFIG_XPL_BUILD) && !CONFIG_IS_ENABLED(SHA256))
+			return -EOPNOTSUPP;
+		return SUNXI_CE_METHOD_SHA256;
+	case HASH_ALGO_SHA384:
+		if (IS_ENABLED(CONFIG_XPL_BUILD) && !CONFIG_IS_ENABLED(SHA384))
+			return -EOPNOTSUPP;
+		return SUNXI_CE_METHOD_SHA384;
+	case HASH_ALGO_SHA512:
+		if (IS_ENABLED(CONFIG_XPL_BUILD) && !CONFIG_IS_ENABLED(SHA512))
+			return -EOPNOTSUPP;
+		return SUNXI_CE_METHOD_SHA512;
+	default:
+		return -EOPNOTSUPP;
+	}
+}
+
+static size_t sunxi_hash_pad(enum HASH_ALGO algo, u8 *pad,
+			     const u8 *tail, size_t tail_len, u32 len)
+{
+	u32 block_size = algo >= HASH_ALGO_SHA384 ?
+			 SHA512_BLOCK_SIZE : 64;
+	size_t aligned_len = ALIGN_DOWN(len, sizeof(u32));
+	size_t rem = len % block_size;
+	size_t len_size = block_size == SHA512_BLOCK_SIZE ? 16 : 8;
+	size_t total_len, pad_len, len_off;
+	u64 bits;
+
+	total_len = rem < block_size - len_size ?
+		    len + block_size - rem : len + 2 * block_size - rem;
+	pad_len = total_len - aligned_len;
+
+	memset(pad, 0, pad_len);
+	if (tail_len)
+		memcpy(pad, tail, tail_len);
+	pad[tail_len] = 0x80;
+
+	bits = (u64)len << 3;
+	len_off = pad_len - 8;
+	if (algo == HASH_ALGO_MD5) {
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
+				 u32 method,
+				 dma_addr_t src, size_t src_len,
+				 dma_addr_t pad, size_t pad_len,
+				 dma_addr_t result, size_t result_len)
+{
+	struct sunxi_ce_task *task = &job->task;
+	u32 total_len = src_len + pad_len;
+	u32 sg = 0;
+
+	memset(task, 0, sizeof(*task));
+
+	task->t_id = SUNXI_CE_CHANNEL_HASH;
+	task->t_common_ctl = SUNXI_CE_COMM_INT | method;
+	task->t_dlen = total_len * 8;
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
+	task->t_dst[0].len = result_len / sizeof(u32);
+}
+
+static int sunxi_hash_run(struct sunxi_ce_priv *ce, struct sunxi_hash_job *job,
+			  u32 method,
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
+	sunxi_hash_fill_task(ce, job, method, src_dma, src_len, pad_dma,
+			     pad_len, result_dma, result_len);
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
+	struct sunxi_ce_priv *ce = dev_get_priv(dev_get_parent(dev));
+	size_t src_len = ALIGN_DOWN(ilen, sizeof(u32));
+	size_t tail_len = ilen - src_len;
+	struct sunxi_hash_job *job;
+	const void *src = ibuf;
+	u8 *src_buf = NULL;
+	const u8 *tail = ibuf;
+	ssize_t digest_size;
+	size_t pad_len, result_size;
+	int method, ret;
+
+	method = sunxi_hash_method(hash_algo);
+	if (method < 0)
+		return method;
+	if ((!ibuf && ilen) || !obuf)
+		return -EINVAL;
+	digest_size = hash_algo_digest_size(hash_algo);
+	if (digest_size < 0)
+		return digest_size;
+	result_size = hash_algo == HASH_ALGO_SHA384 ?
+		      SHA512_SUM_LEN : digest_size;
+
+	job = malloc_cache_aligned(sizeof(*job));
+	if (!job)
+		return -ENOMEM;
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
+	pad_len = sunxi_hash_pad(hash_algo, job->pad, tail, tail_len, ilen);
+	if (src_len + pad_len > U32_MAX / 8) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	ret = sunxi_hash_run(ce, job, method, src, src_len, pad_len, result_size);
+	if (ret)
+		goto out;
+
+	memcpy(obuf, job->result, digest_size);
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
index 04bd962f02f..8926274a1ce 100644
--- a/drivers/crypto/allwinner/sun8i-ce/sun8i-ce.h
+++ b/drivers/crypto/allwinner/sun8i-ce/sun8i-ce.h
@@ -13,11 +13,17 @@
 
 #define SUNXI_CE_CHANNEL_AES		0
 #define SUNXI_CE_CHANNEL_RAES		1
+#define SUNXI_CE_CHANNEL_HASH		2
 #define SUNXI_CE_CHANNEL_ASYM		3
 #define SUNXI_CE_CHAN_MASK(x)		BIT(x)
 #define SUNXI_CE_COMM_INT		BIT(31)
 #define SUNXI_CE_METHOD_AES		0
 #define SUNXI_CE_METHOD_RAES		0x30
+#define SUNXI_CE_METHOD_MD5		16
+#define SUNXI_CE_METHOD_SHA1		17
+#define SUNXI_CE_METHOD_SHA256		19
+#define SUNXI_CE_METHOD_SHA384		20
+#define SUNXI_CE_METHOD_SHA512		21
 #define SUNXI_CE_METHOD_ECC		33
 #define SUNXI_CE_ECC_OP_VERIFY		7
 #define SUNXI_CE_ECC_OP_SHIFT		16
@@ -27,10 +33,9 @@
 
 #define SUNXI_CE_ENGINE_AES		BIT(0)
 #define SUNXI_CE_ENGINE_RAES		BIT(1)
+#define SUNXI_CE_ENGINE_HASH		BIT(2)
 #define SUNXI_CE_ENGINE_ASYM		BIT(3)
-#define SUNXI_CE_ENGINE_MASK		(SUNXI_CE_ENGINE_AES | \
-					 SUNXI_CE_ENGINE_RAES | \
-					 SUNXI_CE_ENGINE_ASYM)
+#define SUNXI_CE_ENGINE_MASK		GENMASK(3, 0)
 
 struct sunxi_ce_sginfo {
 	u32 addr;

-- 
2.53.0

