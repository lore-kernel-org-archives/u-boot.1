Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18B2FC44509
	for <u-boot@archiver.kernel.org>; Mon, 13 Jul 2026 13:21:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CDACE84B5D;
	Mon, 13 Jul 2026 15:21:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ii7r+uH7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9009C84A4F; Mon, 13 Jul 2026 08:43:41 +0200 (CEST)
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com
 [IPv6:2001:4860:4864:20::2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2BEB984A48
 for <u-boot@lists.denx.de>; Mon, 13 Jul 2026 08:43:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=james.hilliard1@gmail.com
Received: by mail-oa1-x2b.google.com with SMTP id
 586e51a60fabf-45171f2f608so1540386fac.1
 for <u-boot@lists.denx.de>; Sun, 12 Jul 2026 23:43:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783925018; x=1784529818; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=muuQNDCqFRnEsnEwUKW/CYrOU7kC/DiLQ1ayHS6ZCBc=;
 b=ii7r+uH7OM4GRqBOZKnbq9cmpQK6h/bgwkD53tYuAWycnsMHtqG0zUct1paxzSPUDa
 Ynbzo7whUsRBWHpnhZfLvo+IWHtB1m5EPYMcKpB3L49OgYl5ywYuRZmsSbFLf/SxZMHB
 ixB3fUYDf9xKdy86051DO/bW3aiIQxGQXzkg77TozKPdzJ8+G6pcLgUV7+9YyJbJc2/g
 ihSNuFNEeeSQQF1+OpvtRWIZzw6xYBZHcUWRpe3/TU+vQv5pIJh++kCi5rjvf3DPcvK+
 R6l7dGzAVrrJUDACMTHHz3CdQOeh8YK49UEPlg2zUEk+H2HkJYnwoG+svH2Sf5NbcanB
 XjPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783925018; x=1784529818;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=muuQNDCqFRnEsnEwUKW/CYrOU7kC/DiLQ1ayHS6ZCBc=;
 b=XalUSwTnZT65SJMjzyn17u88N0MUX6d0RpvXj8ysF9iedHy8XXrdBvhKzFX68KP1eg
 tHP8G/JxlAPXhyjYicROWBqGoLPAPAp+cvbSojw7VC9pO5HvNE8J7i8nEKl3NwTjkNze
 0ql7uvNKX2jWp8whHjOMsWqUzLKxbzSI6Wz35U9/2LohfEDJKxfE8GJmu6ANeclvvOTc
 aHgyeM+68/EoL8o1GjKaPJP7t8/QyJ1weno4b+DqHoUhVx1qn7HIRhmUi8DWYKqb98Da
 9GIhLwnJQwt/EGnlR+nd19L5JpjXrkgay4Owiu2EB0Ruq9ieRGa3CSqHIkDf7f0WN6HG
 f6QA==
X-Forwarded-Encrypted: i=1;
 AHgh+Rpnn3/4QOz5RbITF3bWd/rpq7oMCZ1Q6jV/0CLXs/II0OheM33/1n81locLp06onYZC2sSnoeY=@lists.denx.de
X-Gm-Message-State: AOJu0Yy0bJ8NND9ffFYh4PQTnDnp+YYX5mrJcnEXsg9F+PMkqpyAZdYq
 d2sh5JxWj/DJNEObSlnIWc3i9RsX5ymkembRA9QrP7z1PwCbh1KHPkBm
X-Gm-Gg: AfdE7cmsybqZMkZ+43Eqzofza7fuln301dMt1rhP7j+DHsS3KYF9rTJOKArjYJqfls4
 7dzukDbthx4XuUE0dsHoACeJ/V2WrdS/bIkctxGsoGp63unfJFEMU+EWC6UFUE1j5v45VMaHsLV
 b+nz1EgD2UVsUXBQ7gNhuDfmbnnCRWF/ZEqL9M0F2pHC+l4SO1kH38YA+oz3CFAuBJD7zy7mENG
 B0w67naKz8v5D8Saj4I+R4lbggOdZWuHF5aZc1EMP6T7wfheyHfCguZqAmndiMzkz8ul6OnBRzR
 5Qg9a35sXGx7rkQgx8lSpGpaLF4MfnRzxpXiE1Kh/OJsFee1MCI8k3na/LME3EBW4ePlisiIhut
 qiw8DAu2RSP8cznKjD4zBmQPYuPgwTOQxQM7XGvgGeS6JH0DncUv6ERpvgL4jDGKJboiIs4Vzzg
 PtJvAEGS/volOEm3UazHDPxXQCz0QrB0c2Y3z6qNm5rmSGYJdJkuH4Q5waalkYzVMP70kweTeYf
 Lu7gP/wJyEOpaAl2wPgF14SVZPkkkHyZ3bRpCy43BpJHaSAdUjPmsZ5c78yVvJI
X-Received: by 2002:a05:6871:2e88:b0:43d:2a41:4f with SMTP id
 586e51a60fabf-451f13fd36cmr4664789fac.29.1783925017780; 
 Sun, 12 Jul 2026 23:43:37 -0700 (PDT)
Received: from [127.0.1.1] (174-29-11-8.hlrn.qwest.net. [174.29.11.8])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-451916ce98dsm12538126fac.13.2026.07.12.23.43.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 12 Jul 2026 23:43:37 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Mon, 13 Jul 2026 00:42:59 -0600
Subject: [PATCH v4 02/14] crypto: hash: use DM providers from hash command
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260713-submit-ce-series-v2-v4-2-ff7edc705b8a@gmail.com>
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

The hash command currently always uses the software implementation for
the selected algorithm, even when driver-model hash providers are
available.

Add a hash_digest_wd_lookup() helper which probes UCLASS_HASH devices in
order and uses the first provider supporting the requested algorithm.
Continue past unavailable providers and unsupported operations, but
propagate a hard digest failure once a provider accepts the operation.
Remember probe failures so they are not silently hidden by software
fallback when no later provider succeeds.

Use the helper from the hash command and retain its software fallback
when no usable provider is present. Add sandbox tests covering provider
fallback and hard-error propagation.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
Changes v3 -> v4:
  - New patch
  - Try all registered hash providers instead of only device zero
  - Add provider-selection and error-propagation tests
  - Reserve -EINVAL for hard errors
  - Use -EOPNOTSUPP for unsupported algorithms
---
 common/hash.c                       |  21 ++++++
 drivers/crypto/aspeed/aspeed_hace.c |   2 +-
 drivers/crypto/aspeed/cptra_sha.c   |   2 +-
 drivers/crypto/hash/hash-uclass.c   |  39 +++++++++-
 include/u-boot/hash.h               |  24 +++++-
 test/dm/Makefile                    |   1 +
 test/dm/hash.c                      | 143 ++++++++++++++++++++++++++++++++++++
 7 files changed, 226 insertions(+), 6 deletions(-)

diff --git a/common/hash.c b/common/hash.c
index 71c4bef5826..5cbb4926c1d 100644
--- a/common/hash.c
+++ b/common/hash.c
@@ -11,6 +11,7 @@
 
 #ifndef USE_HOSTCC
 #include <command.h>
+#include <dm.h>
 #include <env.h>
 #include <log.h>
 #include <malloc.h>
@@ -20,6 +21,7 @@
 #include <asm/global_data.h>
 #include <asm/io.h>
 #include <linux/errno.h>
+#include <u-boot/hash.h>
 #else
 #include "mkimage.h"
 #include <linux/compiler_attributes.h>
@@ -614,7 +616,26 @@ int hash_command(const char *algo_name, int flags, struct cmd_tbl *cmdtp,
 			return CMD_RET_FAILURE;
 
 		buf = map_sysmem(addr, len);
+		if (CONFIG_IS_ENABLED(DM_HASH)) {
+			enum HASH_ALGO hash_algo;
+			int ret;
+
+			hash_algo = hash_algo_lookup_by_name(algo_name);
+			if (hash_algo != HASH_ALGO_INVALID) {
+				ret = hash_digest_wd_lookup(hash_algo, buf, len,
+							    output,
+							    algo->chunk_size);
+				if (ret && ret != -ENODEV && ret != -EOPNOTSUPP) {
+					unmap_sysmem(buf);
+					free(output);
+					return CMD_RET_FAILURE;
+				}
+				if (!ret)
+					goto done;
+			}
+		}
 		algo->hash_func_ws(buf, len, output, algo->chunk_size);
+done:
 		unmap_sysmem(buf);
 
 		/* Try to avoid code bloat when verify is not needed */
diff --git a/drivers/crypto/aspeed/aspeed_hace.c b/drivers/crypto/aspeed/aspeed_hace.c
index 22b5008a296..2469f53472f 100644
--- a/drivers/crypto/aspeed/aspeed_hace.c
+++ b/drivers/crypto/aspeed/aspeed_hace.c
@@ -160,7 +160,7 @@ static int aspeed_hace_init(struct udevice *dev, enum HASH_ALGO algo, void **ctx
 free_n_out:
 	free(hace_ctx);
 
-	return -EINVAL;
+	return -EOPNOTSUPP;
 }
 
 static int aspeed_hace_update(struct udevice *dev, void *ctx, const void *ibuf, uint32_t ilen)
diff --git a/drivers/crypto/aspeed/cptra_sha.c b/drivers/crypto/aspeed/cptra_sha.c
index f57778e160d..0dc00f306f1 100644
--- a/drivers/crypto/aspeed/cptra_sha.c
+++ b/drivers/crypto/aspeed/cptra_sha.c
@@ -68,7 +68,7 @@ static int cptra_sha_init(struct udevice *dev, enum HASH_ALGO algo, void **ctxp)
 		cs_ctx->dgst_len = 64;
 		break;
 	default:
-		rc = -EINVAL;
+		rc = -EOPNOTSUPP;
 		goto free_n_out;
 	};
 
diff --git a/drivers/crypto/hash/hash-uclass.c b/drivers/crypto/hash/hash-uclass.c
index 5d9f1e0d59b..30929412856 100644
--- a/drivers/crypto/hash/hash-uclass.c
+++ b/drivers/crypto/hash/hash-uclass.c
@@ -73,8 +73,8 @@ int hash_digest(struct udevice *dev, enum HASH_ALGO algo,
 }
 
 int hash_digest_wd(struct udevice *dev, enum HASH_ALGO algo,
-		   const void *ibuf, const uint32_t ilen,
-		   void *obuf, uint32_t chunk_sz)
+			   const void *ibuf, const uint32_t ilen,
+			   void *obuf, uint32_t chunk_sz)
 {
 	struct hash_ops *ops = (struct hash_ops *)device_get_ops(dev);
 
@@ -84,6 +84,41 @@ int hash_digest_wd(struct udevice *dev, enum HASH_ALGO algo,
 	return ops->hash_digest_wd(dev, algo, ibuf, ilen, obuf, chunk_sz);
 }
 
+static bool hash_op_unsupported(int ret)
+{
+	return ret == -ENOSYS || ret == -EOPNOTSUPP;
+}
+
+int hash_digest_wd_lookup(enum HASH_ALGO algo, const void *ibuf,
+			  const u32 ilen, void *obuf, u32 chunk_sz)
+{
+	struct udevice *dev;
+	int first_probe_err = 0;
+	bool found = false;
+	int ret;
+
+	for (ret = uclass_first_device_check(UCLASS_HASH, &dev); dev;
+	     ret = uclass_next_device_check(&dev)) {
+		found = true;
+		if (ret) {
+			if (!first_probe_err)
+				first_probe_err = ret;
+			continue;
+		}
+
+		ret = hash_digest_wd(dev, algo, ibuf, ilen, obuf, chunk_sz);
+		if (!ret)
+			return 0;
+		if (!hash_op_unsupported(ret))
+			return ret;
+	}
+
+	if (first_probe_err)
+		return first_probe_err;
+
+	return found ? -EOPNOTSUPP : -ENODEV;
+}
+
 int hash_init(struct udevice *dev, enum HASH_ALGO algo, void **ctxp)
 {
 	struct hash_ops *ops = (struct hash_ops *)device_get_ops(dev);
diff --git a/include/u-boot/hash.h b/include/u-boot/hash.h
index f9d47a99a77..a6ba08a8591 100644
--- a/include/u-boot/hash.h
+++ b/include/u-boot/hash.h
@@ -19,6 +19,8 @@ enum HASH_ALGO {
 	HASH_ALGO_INVALID = 0xffffffff,
 };
 
+struct udevice;
+
 /* general APIs for hash algo information */
 enum HASH_ALGO hash_algo_lookup_by_name(const char *name);
 ssize_t hash_algo_digest_size(enum HASH_ALGO algo);
@@ -29,8 +31,26 @@ int hash_digest(struct udevice *dev, enum HASH_ALGO algo,
 		const void *ibuf, const uint32_t ilen,
 		void *obuf);
 int hash_digest_wd(struct udevice *dev, enum HASH_ALGO algo,
-		   const void *ibuf, const uint32_t ilen,
-		   void *obuf, uint32_t chunk_sz);
+			   const void *ibuf, const uint32_t ilen,
+			   void *obuf, uint32_t chunk_sz);
+/**
+ * hash_digest_wd_lookup() - Hash with the first provider supporting an algorithm
+ *
+ * Probe each hash device in order and use the first one which supports the
+ * requested algorithm. Probe failures are remembered while later providers are
+ * tried. Once a provider accepts an operation, hard failures are returned
+ * without trying another provider.
+ *
+ * @algo: Hash algorithm
+ * @ibuf: Input buffer
+ * @ilen: Input buffer length
+ * @obuf: Output buffer
+ * @chunk_sz: Watchdog scheduling interval
+ * Return: 0 on success, -ENODEV if there are no providers, -EOPNOTSUPP if no
+ * provider supports @algo, or another negative error from a provider
+ */
+int hash_digest_wd_lookup(enum HASH_ALGO algo, const void *ibuf,
+			  const u32 ilen, void *obuf, u32 chunk_sz);
 int hash_init(struct udevice *dev, enum HASH_ALGO algo, void **ctxp);
 int hash_update(struct udevice *dev, void *ctx, const void *ibuf, const uint32_t ilen);
 int hash_finish(struct udevice *dev, void *ctx, void *obuf);
diff --git a/test/dm/Makefile b/test/dm/Makefile
index 0e3c63568dd..b6e8f0bd248 100644
--- a/test/dm/Makefile
+++ b/test/dm/Makefile
@@ -46,6 +46,7 @@ obj-$(CONFIG_DMA) += dma.o
 obj-$(CONFIG_VIDEO_MIPI_DSI) += dsi_host.o
 obj-$(CONFIG_DM_DSA) += dsa.o
 obj-$(CONFIG_ECDSA_VERIFY) += ecdsa.o
+obj-$(CONFIG_DM_HASH) += hash.o
 obj-$(CONFIG_EFI_MEDIA_SANDBOX) += efi_media.o
 obj-$(CONFIG_DM_ETH) += eth.o
 obj-$(CONFIG_EXTCON) += extcon.o
diff --git a/test/dm/hash.c b/test/dm/hash.c
new file mode 100644
index 00000000000..fe949e33de5
--- /dev/null
+++ b/test/dm/hash.c
@@ -0,0 +1,143 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Tests for driver-model hash-provider selection
+ *
+ * Copyright (C) 2026 James Hilliard
+ */
+
+#include <dm.h>
+#include <dm/device-internal.h>
+#include <dm/root.h>
+#include <dm/test.h>
+#include <dm/uclass-internal.h>
+#include <u-boot/hash.h>
+#include <test/test.h>
+#include <test/ut.h>
+
+static int unsupported_calls;
+static int success_calls;
+static int hard_error_calls;
+
+static int hash_test_unsupported(struct udevice *dev, enum HASH_ALGO algo,
+				 const void *ibuf, const uint32_t ilen,
+				 void *obuf, uint32_t chunk_sz)
+{
+	unsupported_calls++;
+
+	return -EOPNOTSUPP;
+}
+
+static int hash_test_success(struct udevice *dev, enum HASH_ALGO algo,
+			     const void *ibuf, const uint32_t ilen,
+			     void *obuf, uint32_t chunk_sz)
+{
+	success_calls++;
+	memset(obuf, 0x5a, hash_algo_digest_size(algo));
+
+	return 0;
+}
+
+static int hash_test_hard_error(struct udevice *dev, enum HASH_ALGO algo,
+				const void *ibuf, const uint32_t ilen,
+				void *obuf, uint32_t chunk_sz)
+{
+	hard_error_calls++;
+
+	return -EINVAL;
+}
+
+static const struct hash_ops hash_test_unsupported_ops = {
+	.hash_digest_wd = hash_test_unsupported,
+};
+
+static const struct hash_ops hash_test_success_ops = {
+	.hash_digest_wd = hash_test_success,
+};
+
+static const struct hash_ops hash_test_hard_error_ops = {
+	.hash_digest_wd = hash_test_hard_error,
+};
+
+U_BOOT_DRIVER(hash_test_unsupported_drv) = {
+	.name = "hash_test_unsupported",
+	.id = UCLASS_HASH,
+	.ops = &hash_test_unsupported_ops,
+};
+
+U_BOOT_DRIVER(hash_test_success_drv) = {
+	.name = "hash_test_success",
+	.id = UCLASS_HASH,
+	.ops = &hash_test_success_ops,
+};
+
+U_BOOT_DRIVER(hash_test_hard_error_drv) = {
+	.name = "hash_test_hard_error",
+	.id = UCLASS_HASH,
+	.ops = &hash_test_hard_error_ops,
+};
+
+static int hash_test_unbind_all(void)
+{
+	struct udevice *dev;
+	int ret;
+
+	for (;;) {
+		ret = uclass_find_first_device(UCLASS_HASH, &dev);
+		if (ret || !dev)
+			return ret;
+		if (device_active(dev)) {
+			ret = device_remove(dev, DM_REMOVE_NORMAL);
+			if (ret)
+				return ret;
+		}
+		ret = device_unbind(dev);
+		if (ret)
+			return ret;
+	}
+}
+
+static int hash_test_bind(const struct driver *drv, const char *name)
+{
+	struct udevice *dev;
+
+	return device_bind(dm_root(), drv, name, 0, ofnode_null(), &dev);
+}
+
+static int dm_test_hash_provider_selection(struct unit_test_state *uts)
+{
+	u8 digest[32];
+	int ret;
+
+	ut_assertok(hash_test_unbind_all());
+	ut_assertok(hash_test_bind(DM_DRIVER_GET(hash_test_unsupported_drv),
+				   "hash-unsupported"));
+	ut_assertok(hash_test_bind(DM_DRIVER_GET(hash_test_success_drv),
+				   "hash-success"));
+
+	unsupported_calls = 0;
+	success_calls = 0;
+	memset(digest, 0, sizeof(digest));
+	ret = hash_digest_wd_lookup(HASH_ALGO_SHA256, "test", 4, digest, 4);
+	ut_assertok(ret);
+	ut_asserteq(1, unsupported_calls);
+	ut_asserteq(1, success_calls);
+	for (int i = 0; i < sizeof(digest); i++)
+		ut_asserteq(0x5a, digest[i]);
+
+	ut_assertok(hash_test_unbind_all());
+	ut_assertok(hash_test_bind(DM_DRIVER_GET(hash_test_hard_error_drv),
+				   "hash-hard-error"));
+	ut_assertok(hash_test_bind(DM_DRIVER_GET(hash_test_success_drv),
+				   "hash-success"));
+
+	hard_error_calls = 0;
+	success_calls = 0;
+	ret = hash_digest_wd_lookup(HASH_ALGO_SHA256, "test", 4, digest, 4);
+	ut_asserteq(-EINVAL, ret);
+	ut_asserteq(1, hard_error_calls);
+	ut_asserteq(0, success_calls);
+
+	return 0;
+}
+
+DM_TEST(dm_test_hash_provider_selection, UTF_SCAN_FDT);

-- 
2.53.0

