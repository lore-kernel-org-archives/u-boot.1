Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FE8BC43602
	for <u-boot@archiver.kernel.org>; Thu,  2 Jul 2026 01:48:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F2E0184C87;
	Thu,  2 Jul 2026 03:48:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="j1DGVEiE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B325184C87; Thu,  2 Jul 2026 03:48:18 +0200 (CEST)
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com
 [IPv6:2607:f8b0:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3DCD484C15
 for <u-boot@lists.denx.de>; Thu,  2 Jul 2026 03:48:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=james.hilliard1@gmail.com
Received: by mail-ot1-x329.google.com with SMTP id
 46e09a7af769-7e9bb2d0417so734624a34.0
 for <u-boot@lists.denx.de>; Wed, 01 Jul 2026 18:48:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782956895; x=1783561695; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+BIz2evSD0ZSw8Rm2h2VjRmSvC5dUNuNT1JDwhG3TZA=;
 b=j1DGVEiE3cE9jRfQ01Q8QuFGTN1o7tFB3gtba16TZ35MBfTUjx879WI+voew+NBWtz
 db+9Qgnd33LK7r0EaT87kM2O65LQjrVHwFxxEP7RmoTg0+ERkwnqb4MT4TwKru7lU4tS
 QlsptPvlczEzpk91J/+IY6a09etCxBiX/K8YEvpWzk15z/DoAl4i/7nXQxgCMGY3ycJ/
 sCfC1PbPBqPhxtBadannJF8cEQORkIQAhnKzht4EeEdpMmdU2jD5D8wRaIGwWWCqV3Cz
 xC8l72zBIYiOmwYCtCzWqvDP/XoiB8klZcWjCLIlY5FTmRR2zzAegQndLSAl4hO9HLKs
 spzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782956895; x=1783561695;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=+BIz2evSD0ZSw8Rm2h2VjRmSvC5dUNuNT1JDwhG3TZA=;
 b=ERYFqn70xdtZhfNCgRFfrTqB1qPqQ0aLTOgmXYZEkxzvEtECfjrdyajlrI5MUEcx1H
 Qwd2bICE2BYmMfWvmsBv0s6jeCylSc7ctQvk+V8iH3BeWIMeORtutHkBzws0M2CZqBzp
 85H2vLu4pNRBy9+rB7bwPBu3mi3JjnRwOFcGeUja2mgg9F8WlaDPauH0gu43quc1cfPD
 4RlV8nEaAzE7syI70MFpkn20A/Ia+rw+/ZZUG5b0XqI+ZtgCTOl9cVHueMM4c+NzF9A5
 lUPUxnwnxUmPBavlremGIbxC8slCntc7gqoKLyjkkeNyBvuONSkKtd9Ylm/+AwUWHfNi
 U2WQ==
X-Gm-Message-State: AOJu0YzqeqkHlXtt6tLkdHUlyrVOC5ZrEaUZcJXSSAfdRyyj9I7Zp0S8
 kdtyBoW8bOQbJZJoPQJ2I77aLfDrl6KmdzFUleAXADGTvwj+NpiBJa44PnU61A/R/xrp9Q==
X-Gm-Gg: AfdE7cloA4qxe5VW3MF8fU+0yZWEWLDDoqAV7H1g0ZG+zx/z64Isa9mK+dUb5vBxW7y
 aqPtBiVH685RCYNn9/o6Sn/rTzxKZZ30EF5b5vL99N8j5koVU/5NGU76RhR8enm/E3qGjN7she6
 iMmoXSXYA6rtBZzhzp9hEPSi0DrieM35uEHOsHs73fJkeMVeqvJFo9G5dyB2bWds0wb+uxdnXdb
 rucG5zzizVgDu1A0scYPtRgMmMbE1/eliVdFWY5vaHNOqijHzESr1yBdS6YrgLI3hodm9luDFWt
 BhtIj9jnMC53Rggpp22LjteKKYHFosoj3z9gWg/vqnShnVpsAvciIBVa7JeKUf7fnlx5EN76Tgv
 4aKlG+62tcPxE6MxS9tvfrrbmUFkKTU4pYsGkX/rK3fU3l2E3BszTwRmTV9VmRNecpZEd3HR3Xh
 RjMCznsmQyD8Qw5QxawoPhdxPaVn73WNDlmqd9wUPRxjCTY099UWjsMZiAMGOg3GmbomD/kYYEw
 pPh/6iPblWtp6yGNEOFMl2KUKDVzhcY+JH33XmckZTHQDKj84zcjEQZnPFJjwImIf8VPt3nLtoZ
 432xj5Psn/KciUw=
X-Received: by 2002:a05:6820:4cc7:b0:6a1:7e36:e887 with SMTP id
 006d021491bc7-6a30d7caa23mr2051221eaf.29.1782956894780; 
 Wed, 01 Jul 2026 18:48:14 -0700 (PDT)
Received: from james-x399.tailafd1a.ts.net (97-118-25-163.hlrn.qwest.net.
 [97.118.25.163]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6a310051cfcsm1284511eaf.8.2026.07.01.18.48.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Jul 2026 18:48:14 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
To: u-boot@lists.denx.de
Cc: Andre Przywara <andre.przywara@arm.com>, Chen-Yu Tsai <wens@kernel.org>,
 Samuel Holland <samuel@sholland.org>,
 James Hilliard <james.hilliard1@gmail.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 9/9] crypto: allwinner: add sun8i-ce hash driver
Date: Wed,  1 Jul 2026 19:46:59 -0600
Message-ID: <20260702014724.1534351-9-james.hilliard1@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260702014724.1534351-1-james.hilliard1@gmail.com>
References: <20260702014724.1534351-1-james.hilliard1@gmail.com>
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

The Allwinner sun8i Crypto Engine includes hardware hash methods. Add a
UCLASS_HASH child for the sun8i-ce parent so FIT hash verification can use
the accelerator from U-Boot proper and SPL.

Support MD5, SHA1, SHA256, SHA384 and SHA512 using the CE one-shot task
interface. Build the final hash padding in the driver and bounce
cache-unaligned input so FIT data with short or unaligned tails can be
hashed directly.

H6 and H616 use bit-sized hash task lengths. In SPL, only advertise hash
algorithms selected for that phase so SRAM-constrained builds do not accept
wider algorithms unless requested.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 drivers/crypto/allwinner/sun8i-ce/Kconfig     |  26 ++
 drivers/crypto/allwinner/sun8i-ce/Makefile    |   1 +
 .../crypto/allwinner/sun8i-ce/sun8i-ce-core.c |  11 +
 .../crypto/allwinner/sun8i-ce/sun8i-ce-hash.c | 300 ++++++++++++++++++
 drivers/crypto/allwinner/sun8i-ce/sun8i-ce.h  |   7 +
 5 files changed, 345 insertions(+)
 create mode 100644 drivers/crypto/allwinner/sun8i-ce/sun8i-ce-hash.c

diff --git a/drivers/crypto/allwinner/sun8i-ce/Kconfig b/drivers/crypto/allwinner/sun8i-ce/Kconfig
index 3a259181143..dd7e5c85091 100644
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
+	depends on DM_HASH
+	depends on SPL_DM
+	depends on SPL_OF_CONTROL
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
index 743a93ca3d3..68f04d34ca2 100644
--- a/drivers/crypto/allwinner/sun8i-ce/sun8i-ce-core.c
+++ b/drivers/crypto/allwinner/sun8i-ce/sun8i-ce-core.c
@@ -259,6 +259,13 @@ static int sunxi_ce_bind(struct udevice *dev)
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
 
@@ -345,7 +352,9 @@ static int sunxi_ce_remove(struct udevice *dev)
 
 static const struct sunxi_ce_variant sun50i_h6_variant = {
 	.has_aes = true,
+	.has_hash = true,
 	.cipher_t_dlen_in_bytes = true,
+	.hash_t_dlen_in_bits = true,
 	.spl_enable_clocks = sun50i_h6_ce_spl_enable_clocks,
 	.spl_reset = sun50i_h6_ce_spl_reset,
 };
@@ -353,7 +362,9 @@ static const struct sunxi_ce_variant sun50i_h6_variant = {
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
index 00000000000..876e69d3c60
--- /dev/null
+++ b/drivers/crypto/allwinner/sun8i-ce/sun8i-ce-hash.c
@@ -0,0 +1,300 @@
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
+#include <watchdog.h>
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
+	if (src_len && !IS_ALIGNED((ulong)ibuf, ARCH_DMA_MINALIGN)) {
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
+	int ret;
+
+	ret = sunxi_hash_digest(dev, algo, ibuf, ilen, obuf);
+	if (!ret && chunk_sz)
+		schedule();
+
+	return ret;
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

