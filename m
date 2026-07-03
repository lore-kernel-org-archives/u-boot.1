Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4581FC43458
	for <u-boot@archiver.kernel.org>; Fri,  3 Jul 2026 08:00:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 966E7849F6;
	Fri,  3 Jul 2026 09:59:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="r26VAUxX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 15BE6849F0; Fri,  3 Jul 2026 03:50:13 +0200 (CEST)
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com
 [IPv6:2607:f8b0:4864:20::230])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4AA68848BF
 for <u-boot@lists.denx.de>; Fri,  3 Jul 2026 03:50:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=james.hilliard1@gmail.com
Received: by mail-oi1-x230.google.com with SMTP id
 5614622812f47-487167d083bso26226b6e.3
 for <u-boot@lists.denx.de>; Thu, 02 Jul 2026 18:50:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783043409; x=1783648209; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=lHfwE1ymbXA7JmElrWxxUeW8ZyRPLPROs5MNEGMYP5k=;
 b=r26VAUxXbZTH5eTQsn5b5DqYSLuZrBQPMeO8Jr4nvisEptpQEmmnnLwgiIG8y+MI69
 pqBwGkJPTMlro4/dKLcR09AB6cUiO4fDKpduxXZvm4dKg0tZjSFPIrh0VVsz2KG9m8KO
 V/myWlyI+/huy224zeUO/SfvqJgeP64NkKWpmj304TOpQdT+uEhlDDOzDgkXM918lZDH
 zk3T+pjNh7i/GtuhgHuiTvjyQoBX9Xk2VK/Sqs8vqjC1oBiXHD6oKUCfz43CFLR5v30W
 xc3/UUs//RyDrllXeEAjdOtRWjpQqeBy03oycC/+UNLZ0noE1ALXglU99ssiWbv+iI7P
 GC6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783043409; x=1783648209;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=lHfwE1ymbXA7JmElrWxxUeW8ZyRPLPROs5MNEGMYP5k=;
 b=exXoQl4O5XQIiiOZJgdgUnqxZPoQBzKWFddiFkNnMxFFLvWfprR6Vz3PkURZ7EqVsL
 yibx5m4q8f9RQoNVHUAhIuXIsbXqeUjvSEdEozYepRbRWZzgNTD2jIdvZqTsrhurwCcL
 U+FTiO43aHYG9CzfLfw6n1lA10jhdKqwi9ZYV2BMOeMpB5q+TeAjH0W57dIVFrQNMFH7
 W9i2tQvXSUlOPQ4ubsBPqS/oK8oAfPluLGEyHT7CvxwDrAnbP/upFGRBNSSO5GXccEE9
 /V97V3mAua0qHREKXhvWBdyiwPbCYgW0NB9G2ialvTeaS1PejknLRSGSv3mfuDc6D/DX
 fzrQ==
X-Gm-Message-State: AOJu0YzEyPJFJWlT97U/lu94xJGqpdKq70N8CFB1JGIRdJQYkIxM0Jpn
 0t4qapvYlEsK3Qxgx99LFx9PUQigaXo/rFrRrdmb4LOb/c4Qqtx3vv73
X-Gm-Gg: AfdE7cluLrf/b/9JuvOld4ppGi/TXbhWxB9rfzAuCuAlUjwlIF+KVc8BaPz1FZ+kSt+
 4f8ZO8uORSN1uPS8C3MKmb4/9MEofOexqi3NydK0kV5a9FmTeUfBToqSVcScI841lX/IzJbhjlR
 WqQ0gw2TOwyelqVY5MbrMMI6tc4TlHbFNQ44jgG5ayqL8Sd2tlFPhd0/mzxzgRWVlcvr8xVouJW
 0kgaxJJkVqw7i/WEa9dWumaKW2vKMLQXVy4H2qBfBi4Htvehd0dlFimen/5eeBSQ0Kayj7Fx4jR
 5rRqHV1Hl2c0QLZkCKSE8+gGirQFRIsI0uC+VlKgoDbL3TSoSIon/T8eB2Y4cyYSyeW1YgZEnq5
 pYbJWODETbDFpuITcIPjbA2g7/29H3kqNL3h9C5+mqY6tp3cLi6UWg/bnD9SIb40qTYcWgmuziN
 NSlRqFRJyND9eLOJwPhadbmu4oKq5ya8l+aRNWA1pXuueUfoA+i2QAKlTw5toey61A2g+tzZpgw
 xKBwzlb7wPMOXzTx1efIZHnRuh1zMMu6G65jGBNr1lNY4g6KqR3Ujy0EAtr92ffi+7dIw==
X-Received: by 2002:a05:6808:1441:b0:495:fa73:2e2a with SMTP id
 5614622812f47-4960ea8ac97mr5382119b6e.0.1783043408848; 
 Thu, 02 Jul 2026 18:50:08 -0700 (PDT)
Received: from [127.0.1.1] (97-118-25-163.hlrn.qwest.net. [97.118.25.163])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-497d1b43cfcsm2974888b6e.14.2026.07.02.18.50.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Jul 2026 18:50:08 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Thu, 02 Jul 2026 19:49:53 -0600
Subject: [PATCH v2 08/10] crypto: allwinner: add sun8i-ce ECDSA verifier
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260702-submit-ce-series-v2-v2-8-ffda5bed58af@gmail.com>
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

The H616 Crypto Engine includes an ECC engine which can verify ECDSA
signatures. Add a UCLASS_ECDSA child for the sun8i-ce parent so FIT
signature verification can use the hardware block from U-Boot proper and
SPL.

The CE takes explicit curve parameters for each operation. Provide tables
for the curves accepted by U-Boot's FIT ECDSA parser: secp224r1,
prime256v1, secp384r1 and secp521r1. Make each curve independently
selectable for U-Boot proper and SPL so SRAM-constrained builds can keep
only the curves they need. The task input layout follows the ECC verify
buffer order used by Allwinner's CE implementation.

The CE input buffer uses fixed-width curve fields. Reuse the parameter
packing logic for the message digest as well, so wider digests are
truncated to the leftmost curve-width bytes according to ECDSA rules.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
Changes v1 -> v2:
  - Document the CE input-buffer layout  (suggested by Simon Glass)
  - Document ECC byte-sized task length  (suggested by Simon Glass)
  - Make CE ECDSA curves individually selectable  (suggested by Simon Glass)
  - Use neutral wording in comments and commit log
---
 drivers/crypto/allwinner/sun8i-ce/Kconfig          |  93 +++++
 drivers/crypto/allwinner/sun8i-ce/Makefile         |   1 +
 drivers/crypto/allwinner/sun8i-ce/sun8i-ce-core.c  |   8 +
 drivers/crypto/allwinner/sun8i-ce/sun8i-ce-ecdsa.c | 434 +++++++++++++++++++++
 drivers/crypto/allwinner/sun8i-ce/sun8i-ce.h       |   4 +
 5 files changed, 540 insertions(+)

diff --git a/drivers/crypto/allwinner/sun8i-ce/Kconfig b/drivers/crypto/allwinner/sun8i-ce/Kconfig
index f72cf3498fe..e780638d86f 100644
--- a/drivers/crypto/allwinner/sun8i-ce/Kconfig
+++ b/drivers/crypto/allwinner/sun8i-ce/Kconfig
@@ -37,3 +37,96 @@ config SPL_SUNXI_CE_AES
 	  Select this option to enable AES decryption in SPL using the Crypto
 	  Engine found in Allwinner H6 and H616 compatible SoCs. This can be
 	  used to decrypt FIT images before loading U-Boot proper.
+
+config SUNXI_CE_ECDSA
+	bool "Allwinner sunxi CE ECDSA verifier"
+	depends on ARCH_SUNXI
+	depends on ECDSA_VERIFY
+	depends on CLK && DM_RESET
+	select SUNXI_CE
+	help
+	  Select this option to enable ECDSA signature verification using
+	  the Crypto Engine found in Allwinner sunxi SoCs. FIT image
+	  signatures can then be checked by the hardware accelerator in
+	  U-Boot proper. Digests wider than the selected curve are
+	  truncated according to ECDSA rules.
+
+config SPL_SUNXI_CE_ECDSA
+	bool "Allwinner sunxi CE ECDSA verifier in SPL"
+	depends on ARCH_SUNXI
+	depends on MACH_SUN50I_H616
+	depends on SPL_DM
+	depends on SPL_OF_CONTROL
+	depends on SPL_ECDSA_VERIFY
+	select SPL_CRYPTO
+	select SPL_SUNXI_CE
+	help
+	  Select this option to enable ECDSA signature verification in SPL
+	  using the Crypto Engine found in Allwinner H616-compatible SoCs.
+	  This allows SPL FIT image signatures to be checked by the hardware
+	  accelerator before U-Boot proper is loaded. Digests wider than the
+	  selected curve are truncated according to ECDSA rules.
+
+if SUNXI_CE_ECDSA
+
+config SUNXI_CE_ECDSA_SECP224R1
+	bool "Support secp224r1"
+	default y
+	help
+	  Enable the secp224r1 curve parameters for the sunxi CE ECDSA
+	  verifier.
+
+config SUNXI_CE_ECDSA_PRIME256V1
+	bool "Support prime256v1"
+	default y
+	help
+	  Enable the prime256v1 curve parameters for the sunxi CE ECDSA
+	  verifier.
+
+config SUNXI_CE_ECDSA_SECP384R1
+	bool "Support secp384r1"
+	default y
+	help
+	  Enable the secp384r1 curve parameters for the sunxi CE ECDSA
+	  verifier.
+
+config SUNXI_CE_ECDSA_SECP521R1
+	bool "Support secp521r1"
+	default y
+	help
+	  Enable the secp521r1 curve parameters for the sunxi CE ECDSA
+	  verifier.
+
+endif
+
+if SPL_SUNXI_CE_ECDSA
+
+config SPL_SUNXI_CE_ECDSA_SECP224R1
+	bool "Support secp224r1 in SPL"
+	default y
+	help
+	  Enable the secp224r1 curve parameters for the sunxi CE ECDSA
+	  verifier in SPL.
+
+config SPL_SUNXI_CE_ECDSA_PRIME256V1
+	bool "Support prime256v1 in SPL"
+	default y
+	help
+	  Enable the prime256v1 curve parameters for the sunxi CE ECDSA
+	  verifier in SPL.
+
+config SPL_SUNXI_CE_ECDSA_SECP384R1
+	bool "Support secp384r1 in SPL"
+	default y
+	help
+	  Enable the secp384r1 curve parameters for the sunxi CE ECDSA
+	  verifier in SPL.
+
+config SPL_SUNXI_CE_ECDSA_SECP521R1
+	bool "Support secp521r1 in SPL"
+	default y
+	help
+	  Enable the secp521r1 curve parameters for the sunxi CE ECDSA
+	  verifier in SPL.
+
+endif
diff --git a/drivers/crypto/allwinner/sun8i-ce/Makefile b/drivers/crypto/allwinner/sun8i-ce/Makefile
index 2a8778065b1..753ea827a0d 100644
--- a/drivers/crypto/allwinner/sun8i-ce/Makefile
+++ b/drivers/crypto/allwinner/sun8i-ce/Makefile
@@ -2,3 +2,4 @@
 
 obj-$(CONFIG_$(PHASE_)SUNXI_CE) += sun8i-ce-core.o
 obj-$(CONFIG_$(PHASE_)SUNXI_CE_AES) += sun8i-ce-aes.o
+obj-$(CONFIG_$(PHASE_)SUNXI_CE_ECDSA) += sun8i-ce-ecdsa.o
diff --git a/drivers/crypto/allwinner/sun8i-ce/sun8i-ce-core.c b/drivers/crypto/allwinner/sun8i-ce/sun8i-ce-core.c
index 3674e54ec12..743a93ca3d3 100644
--- a/drivers/crypto/allwinner/sun8i-ce/sun8i-ce-core.c
+++ b/drivers/crypto/allwinner/sun8i-ce/sun8i-ce-core.c
@@ -252,6 +252,13 @@ static int sunxi_ce_bind(struct udevice *dev)
 			return ret;
 	}
 
+	if (CONFIG_IS_ENABLED(SUNXI_CE_ECDSA) && variant->has_ecdsa) {
+		ret = device_bind_driver(dev, "sun8i-ce-ecdsa",
+					 "sun8i-ce-ecdsa", NULL);
+		if (ret)
+			return ret;
+	}
+
 	return 0;
 }
 
@@ -345,6 +352,7 @@ static const struct sunxi_ce_variant sun50i_h6_variant = {
 
 static const struct sunxi_ce_variant sun50i_h616_variant = {
 	.has_aes = true,
+	.has_ecdsa = true,
 	.cipher_t_dlen_in_bytes = true,
 	.needs_word_addresses = true,
 	.setup_mod_clock = sun50i_h616_ce_setup_mod_clock,
diff --git a/drivers/crypto/allwinner/sun8i-ce/sun8i-ce-ecdsa.c b/drivers/crypto/allwinner/sun8i-ce/sun8i-ce-ecdsa.c
new file mode 100644
index 00000000000..15b35d91cf9
--- /dev/null
+++ b/drivers/crypto/allwinner/sun8i-ce/sun8i-ce-ecdsa.c
@@ -0,0 +1,434 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2026 James Hilliard
+ */
+
+#include <crypto/ecdsa-uclass.h>
+#include <dm.h>
+#include <malloc.h>
+#include <memalign.h>
+#include <string.h>
+#include <linux/dma-mapping.h>
+#include <linux/kernel.h>
+#include "sun8i-ce.h"
+
+#define SUNXI_ECDSA_PARAMS		12
+#define SUNXI_ECDSA_MAX_WORDS						\
+	(CONFIG_IS_ENABLED(SUNXI_CE_ECDSA_SECP521R1) ? 17 :		\
+	 CONFIG_IS_ENABLED(SUNXI_CE_ECDSA_SECP384R1) ? 12 :		\
+	 CONFIG_IS_ENABLED(SUNXI_CE_ECDSA_PRIME256V1) ? 8 :		\
+	 CONFIG_IS_ENABLED(SUNXI_CE_ECDSA_SECP224R1) ? 7 : 1)
+#define SUNXI_ECDSA_MAX_BYTES		(SUNXI_ECDSA_MAX_WORDS * sizeof(u32))
+#define SUNXI_ECDSA_MAX_SRC_BYTES	(SUNXI_ECDSA_PARAMS * SUNXI_ECDSA_MAX_BYTES)
+
+struct sunxi_ecdsa_job {
+	struct sunxi_ce_task task __aligned(ARCH_DMA_MINALIGN);
+	u8 src[SUNXI_ECDSA_MAX_SRC_BYTES] __aligned(ARCH_DMA_MINALIGN);
+	u8 dst[SUNXI_ECDSA_MAX_BYTES] __aligned(ARCH_DMA_MINALIGN);
+};
+
+struct sunxi_ecdsa_curve {
+	const char *name;
+	const u8 *p;
+	const u8 *a;
+	const u8 *gx;
+	const u8 *gy;
+	const u8 *n;
+	u16 bits;
+	u8 bytes;
+	u8 words;
+};
+
+static const u8 ecdsa_p224_p[] = {
+	0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
+	0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+	0x00, 0x00, 0x00, 0x01,
+};
+
+static const u8 ecdsa_p224_a[] = {
+	0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
+	0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xfe,
+	0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
+	0xff, 0xff, 0xff, 0xfe,
+};
+
+static const u8 ecdsa_p224_gx[] = {
+	0xb7, 0x0e, 0x0c, 0xbd, 0x6b, 0xb4, 0xbf, 0x7f,
+	0x32, 0x13, 0x90, 0xb9, 0x4a, 0x03, 0xc1, 0xd3,
+	0x56, 0xc2, 0x11, 0x22, 0x34, 0x32, 0x80, 0xd6,
+	0x11, 0x5c, 0x1d, 0x21,
+};
+
+static const u8 ecdsa_p224_gy[] = {
+	0xbd, 0x37, 0x63, 0x88, 0xb5, 0xf7, 0x23, 0xfb,
+	0x4c, 0x22, 0xdf, 0xe6, 0xcd, 0x43, 0x75, 0xa0,
+	0x5a, 0x07, 0x47, 0x64, 0x44, 0xd5, 0x81, 0x99,
+	0x85, 0x00, 0x7e, 0x34,
+};
+
+static const u8 ecdsa_p224_n[] = {
+	0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
+	0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0x16, 0xa2,
+	0xe0, 0xb8, 0xf0, 0x3e, 0x13, 0xdd, 0x29, 0x45,
+	0x5c, 0x5c, 0x2a, 0x3d,
+};
+
+static const u8 ecdsa_p256_p[] = {
+	0xff, 0xff, 0xff, 0xff, 0x00, 0x00, 0x00, 0x01,
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+	0x00, 0x00, 0x00, 0x00, 0xff, 0xff, 0xff, 0xff,
+	0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
+};
+
+static const u8 ecdsa_p256_a[] = {
+	0xff, 0xff, 0xff, 0xff, 0x00, 0x00, 0x00, 0x01,
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+	0x00, 0x00, 0x00, 0x00, 0xff, 0xff, 0xff, 0xff,
+	0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xfc,
+};
+
+static const u8 ecdsa_p256_gx[] = {
+	0x6b, 0x17, 0xd1, 0xf2, 0xe1, 0x2c, 0x42, 0x47,
+	0xf8, 0xbc, 0xe6, 0xe5, 0x63, 0xa4, 0x40, 0xf2,
+	0x77, 0x03, 0x7d, 0x81, 0x2d, 0xeb, 0x33, 0xa0,
+	0xf4, 0xa1, 0x39, 0x45, 0xd8, 0x98, 0xc2, 0x96,
+};
+
+static const u8 ecdsa_p256_gy[] = {
+	0x4f, 0xe3, 0x42, 0xe2, 0xfe, 0x1a, 0x7f, 0x9b,
+	0x8e, 0xe7, 0xeb, 0x4a, 0x7c, 0x0f, 0x9e, 0x16,
+	0x2b, 0xce, 0x33, 0x57, 0x6b, 0x31, 0x5e, 0xce,
+	0xcb, 0xb6, 0x40, 0x68, 0x37, 0xbf, 0x51, 0xf5,
+};
+
+static const u8 ecdsa_p256_n[] = {
+	0xff, 0xff, 0xff, 0xff, 0x00, 0x00, 0x00, 0x00,
+	0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
+	0xbc, 0xe6, 0xfa, 0xad, 0xa7, 0x17, 0x9e, 0x84,
+	0xf3, 0xb9, 0xca, 0xc2, 0xfc, 0x63, 0x25, 0x51,
+};
+
+static const u8 ecdsa_p384_p[] = {
+	0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
+	0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
+	0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
+	0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xfe,
+	0xff, 0xff, 0xff, 0xff, 0x00, 0x00, 0x00, 0x00,
+	0x00, 0x00, 0x00, 0x00, 0xff, 0xff, 0xff, 0xff,
+};
+
+static const u8 ecdsa_p384_a[] = {
+	0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
+	0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
+	0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
+	0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xfe,
+	0xff, 0xff, 0xff, 0xff, 0x00, 0x00, 0x00, 0x00,
+	0x00, 0x00, 0x00, 0x00, 0xff, 0xff, 0xff, 0xfc,
+};
+
+static const u8 ecdsa_p384_gx[] = {
+	0xaa, 0x87, 0xca, 0x22, 0xbe, 0x8b, 0x05, 0x37,
+	0x8e, 0xb1, 0xc7, 0x1e, 0xf3, 0x20, 0xad, 0x74,
+	0x6e, 0x1d, 0x3b, 0x62, 0x8b, 0xa7, 0x9b, 0x98,
+	0x59, 0xf7, 0x41, 0xe0, 0x82, 0x54, 0x2a, 0x38,
+	0x55, 0x02, 0xf2, 0x5d, 0xbf, 0x55, 0x29, 0x6c,
+	0x3a, 0x54, 0x5e, 0x38, 0x72, 0x76, 0x0a, 0xb7,
+};
+
+static const u8 ecdsa_p384_gy[] = {
+	0x36, 0x17, 0xde, 0x4a, 0x96, 0x26, 0x2c, 0x6f,
+	0x5d, 0x9e, 0x98, 0xbf, 0x92, 0x92, 0xdc, 0x29,
+	0xf8, 0xf4, 0x1d, 0xbd, 0x28, 0x9a, 0x14, 0x7c,
+	0xe9, 0xda, 0x31, 0x13, 0xb5, 0xf0, 0xb8, 0xc0,
+	0x0a, 0x60, 0xb1, 0xce, 0x1d, 0x7e, 0x81, 0x9d,
+	0x7a, 0x43, 0x1d, 0x7c, 0x90, 0xea, 0x0e, 0x5f,
+};
+
+static const u8 ecdsa_p384_n[] = {
+	0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
+	0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
+	0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
+	0xc7, 0x63, 0x4d, 0x81, 0xf4, 0x37, 0x2d, 0xdf,
+	0x58, 0x1a, 0x0d, 0xb2, 0x48, 0xb0, 0xa7, 0x7a,
+	0xec, 0xec, 0x19, 0x6a, 0xcc, 0xc5, 0x29, 0x73,
+};
+
+static const u8 ecdsa_p521_p[] = {
+	0x01, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
+	0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
+	0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
+	0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
+	0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
+	0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
+	0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
+	0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
+	0xff, 0xff,
+};
+
+static const u8 ecdsa_p521_a[] = {
+	0x01, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
+	0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
+	0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
+	0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
+	0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
+	0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
+	0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
+	0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
+	0xff, 0xfc,
+};
+
+static const u8 ecdsa_p521_gx[] = {
+	0x00, 0xc6, 0x85, 0x8e, 0x06, 0xb7, 0x04, 0x04,
+	0xe9, 0xcd, 0x9e, 0x3e, 0xcb, 0x66, 0x23, 0x95,
+	0xb4, 0x42, 0x9c, 0x64, 0x81, 0x39, 0x05, 0x3f,
+	0xb5, 0x21, 0xf8, 0x28, 0xaf, 0x60, 0x6b, 0x4d,
+	0x3d, 0xba, 0xa1, 0x4b, 0x5e, 0x77, 0xef, 0xe7,
+	0x59, 0x28, 0xfe, 0x1d, 0xc1, 0x27, 0xa2, 0xff,
+	0xa8, 0xde, 0x33, 0x48, 0xb3, 0xc1, 0x85, 0x6a,
+	0x42, 0x9b, 0xf9, 0x7e, 0x7e, 0x31, 0xc2, 0xe5,
+	0xbd, 0x66,
+};
+
+static const u8 ecdsa_p521_gy[] = {
+	0x01, 0x18, 0x39, 0x29, 0x6a, 0x78, 0x9a, 0x3b,
+	0xc0, 0x04, 0x5c, 0x8a, 0x5f, 0xb4, 0x2c, 0x7d,
+	0x1b, 0xd9, 0x98, 0xf5, 0x44, 0x49, 0x57, 0x9b,
+	0x44, 0x68, 0x17, 0xaf, 0xbd, 0x17, 0x27, 0x3e,
+	0x66, 0x2c, 0x97, 0xee, 0x72, 0x99, 0x5e, 0xf4,
+	0x26, 0x40, 0xc5, 0x50, 0xb9, 0x01, 0x3f, 0xad,
+	0x07, 0x61, 0x35, 0x3c, 0x70, 0x86, 0xa2, 0x72,
+	0xc2, 0x40, 0x88, 0xbe, 0x94, 0x76, 0x9f, 0xd1,
+	0x66, 0x50,
+};
+
+static const u8 ecdsa_p521_n[] = {
+	0x01, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
+	0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
+	0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
+	0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
+	0xff, 0xfa, 0x51, 0x86, 0x87, 0x83, 0xbf, 0x2f,
+	0x96, 0x6b, 0x7f, 0xcc, 0x01, 0x48, 0xf7, 0x09,
+	0xa5, 0xd0, 0x3b, 0xb5, 0xc9, 0xb8, 0x89, 0x9c,
+	0x47, 0xae, 0xbb, 0x6f, 0xb7, 0x1e, 0x91, 0x38,
+	0x64, 0x09,
+};
+
+static const struct sunxi_ecdsa_curve sunxi_ecdsa_secp224r1 = {
+	.name = "secp224r1",
+	.bits = 224,
+	.bytes = 28,
+	.words = 7,
+	.p = ecdsa_p224_p,
+	.a = ecdsa_p224_a,
+	.gx = ecdsa_p224_gx,
+	.gy = ecdsa_p224_gy,
+	.n = ecdsa_p224_n,
+};
+
+static const struct sunxi_ecdsa_curve sunxi_ecdsa_prime256v1 = {
+	.name = "prime256v1",
+	.bits = 256,
+	.bytes = 32,
+	.words = 8,
+	.p = ecdsa_p256_p,
+	.a = ecdsa_p256_a,
+	.gx = ecdsa_p256_gx,
+	.gy = ecdsa_p256_gy,
+	.n = ecdsa_p256_n,
+};
+
+static const struct sunxi_ecdsa_curve sunxi_ecdsa_secp384r1 = {
+	.name = "secp384r1",
+	.bits = 384,
+	.bytes = 48,
+	.words = 12,
+	.p = ecdsa_p384_p,
+	.a = ecdsa_p384_a,
+	.gx = ecdsa_p384_gx,
+	.gy = ecdsa_p384_gy,
+	.n = ecdsa_p384_n,
+};
+
+static const struct sunxi_ecdsa_curve sunxi_ecdsa_secp521r1 = {
+	.name = "secp521r1",
+	.bits = 521,
+	.bytes = 66,
+	.words = 17,
+	.p = ecdsa_p521_p,
+	.a = ecdsa_p521_a,
+	.gx = ecdsa_p521_gx,
+	.gy = ecdsa_p521_gy,
+	.n = ecdsa_p521_n,
+};
+
+static const struct sunxi_ecdsa_curve *
+sunxi_ecdsa_find_curve(const struct ecdsa_public_key *pubkey)
+{
+	if (CONFIG_IS_ENABLED(SUNXI_CE_ECDSA_SECP224R1) &&
+	    !strcmp(pubkey->curve_name, sunxi_ecdsa_secp224r1.name))
+		return &sunxi_ecdsa_secp224r1;
+	if (CONFIG_IS_ENABLED(SUNXI_CE_ECDSA_PRIME256V1) &&
+	    !strcmp(pubkey->curve_name, sunxi_ecdsa_prime256v1.name))
+		return &sunxi_ecdsa_prime256v1;
+	if (CONFIG_IS_ENABLED(SUNXI_CE_ECDSA_SECP384R1) &&
+	    !strcmp(pubkey->curve_name, sunxi_ecdsa_secp384r1.name))
+		return &sunxi_ecdsa_secp384r1;
+	if (CONFIG_IS_ENABLED(SUNXI_CE_ECDSA_SECP521R1) &&
+	    !strcmp(pubkey->curve_name, sunxi_ecdsa_secp521r1.name))
+		return &sunxi_ecdsa_secp521r1;
+
+	return NULL;
+}
+
+static void sunxi_ecdsa_copy_le_param(u8 **dst,
+				      const struct sunxi_ecdsa_curve *curve,
+				      const void *src, size_t len)
+{
+	const u8 *p = src;
+	size_t copy_len;
+	int i;
+
+	copy_len = min_t(size_t, len, curve->bytes);
+	for (i = 0; i < copy_len; i++)
+		(*dst)[i] = p[copy_len - 1 - i];
+	*dst += curve->words * sizeof(u32);
+}
+
+static void sunxi_ecdsa_fill_src(struct sunxi_ecdsa_job *job,
+				 const struct sunxi_ecdsa_curve *curve,
+				 const struct ecdsa_public_key *pubkey,
+				 const void *hash, size_t hash_len,
+				 const void *signature)
+{
+	const u8 *r = signature;
+	const u8 *s = r + curve->bytes;
+	u8 *dst = job->src;
+
+	/*
+	 * The H616 CE manual specifies this fixed sequence of little-endian
+	 * curve-width fields for ECC signature verification:
+	 *
+	 *   n, s, e, r, p, a, Gx, Gy, Qx, Qy, n, r
+	 */
+	sunxi_ecdsa_copy_le_param(&dst, curve, curve->n, curve->bytes);
+	sunxi_ecdsa_copy_le_param(&dst, curve, s, curve->bytes);
+	/* ECDSA uses the leftmost bits when the digest is wider than the key. */
+	sunxi_ecdsa_copy_le_param(&dst, curve, hash, hash_len);
+	sunxi_ecdsa_copy_le_param(&dst, curve, r, curve->bytes);
+	sunxi_ecdsa_copy_le_param(&dst, curve, curve->p, curve->bytes);
+	sunxi_ecdsa_copy_le_param(&dst, curve, curve->a, curve->bytes);
+	sunxi_ecdsa_copy_le_param(&dst, curve, curve->gx, curve->bytes);
+	sunxi_ecdsa_copy_le_param(&dst, curve, curve->gy, curve->bytes);
+	sunxi_ecdsa_copy_le_param(&dst, curve, pubkey->x, curve->bytes);
+	sunxi_ecdsa_copy_le_param(&dst, curve, pubkey->y, curve->bytes);
+	sunxi_ecdsa_copy_le_param(&dst, curve, curve->n, curve->bytes);
+	sunxi_ecdsa_copy_le_param(&dst, curve, r, curve->bytes);
+}
+
+static void sunxi_ecdsa_fill_task(struct sunxi_ce_priv *priv,
+				  struct sunxi_ecdsa_job *job,
+				  const struct sunxi_ecdsa_curve *curve,
+				  dma_addr_t src, dma_addr_t dst)
+{
+	struct sunxi_ce_task *task = &job->task;
+	u32 bytes = curve->words * sizeof(u32);
+
+	task->t_id = SUNXI_CE_CHAN;
+	task->t_common_ctl = SUNXI_CE_COMM_INT | SUNXI_CE_METHOD_ECC;
+	task->t_asym_ctl = curve->words |
+			   (SUNXI_CE_ECC_OP_VERIFY << SUNXI_CE_ECC_OP_SHIFT);
+	/* The ECC engine uses a byte-sized task length on H616. */
+	task->t_dlen = SUNXI_ECDSA_PARAMS * bytes;
+	task->t_src[0].addr = sunxi_ce_desc_dma_addr(priv, src);
+	task->t_src[0].len = task->t_dlen / sizeof(u32);
+	task->t_dst[0].addr = sunxi_ce_desc_dma_addr(priv, dst);
+	task->t_dst[0].len = curve->words;
+}
+
+static int sunxi_ecdsa_run(struct sunxi_ce_priv *priv,
+			   struct sunxi_ecdsa_job *job,
+			   const struct sunxi_ecdsa_curve *curve)
+{
+	size_t dst_len = curve->words * sizeof(u32);
+	size_t src_len = SUNXI_ECDSA_PARAMS * dst_len;
+	dma_addr_t src_dma, dst_dma;
+	u32 result;
+	int ret;
+
+	src_dma = dma_map_single(job->src, src_len, DMA_TO_DEVICE);
+	if (dma_mapping_error(NULL, src_dma))
+		return -EIO;
+
+	dst_dma = dma_map_single(job->dst, dst_len, DMA_FROM_DEVICE);
+	if (dma_mapping_error(NULL, dst_dma)) {
+		ret = -EIO;
+		goto out_unmap_src;
+	}
+
+	sunxi_ecdsa_fill_task(priv, job, curve, src_dma, dst_dma);
+	sunxi_ce_flush(&job->task, sizeof(job->task));
+
+	ret = sunxi_ce_run_task(priv, &job->task);
+
+	dma_unmap_single(dst_dma, dst_len, DMA_FROM_DEVICE);
+	if (ret)
+		goto out_unmap_src;
+
+	result = *(u32 *)job->dst;
+	ret = result == 1 ? 0 : -EPERM;
+
+out_unmap_src:
+	dma_unmap_single(src_dma, src_len, DMA_TO_DEVICE);
+
+	return ret;
+}
+
+static int sunxi_ecdsa_verify_common(struct sunxi_ce_priv *priv,
+				     const struct ecdsa_public_key *pubkey,
+				     const void *hash, size_t hash_len,
+				     const void *signature, size_t sig_len)
+{
+	const struct sunxi_ecdsa_curve *curve;
+	struct sunxi_ecdsa_job *job;
+	int ret;
+
+	curve = sunxi_ecdsa_find_curve(pubkey);
+	if (!curve || pubkey->size_bits != curve->bits || !hash_len ||
+	    sig_len != curve->bytes * 2)
+		return -EINVAL;
+
+	job = malloc_cache_aligned(sizeof(*job));
+	if (!job)
+		return -ENOMEM;
+
+	memset(job, 0, sizeof(*job));
+	sunxi_ecdsa_fill_src(job, curve, pubkey, hash, hash_len, signature);
+
+	ret = sunxi_ecdsa_run(priv, job, curve);
+	free(job);
+
+	return ret;
+}
+
+static int sunxi_ecdsa_verify_dm(struct udevice *dev,
+				 const struct ecdsa_public_key *pubkey,
+				 const void *hash, size_t hash_len,
+				 const void *signature, size_t sig_len)
+{
+	struct sunxi_ce_priv *priv = dev_get_priv(dev_get_parent(dev));
+
+	return sunxi_ecdsa_verify_common(priv, pubkey, hash, hash_len,
+					 signature, sig_len);
+}
+
+static const struct ecdsa_ops sunxi_ecdsa_ops = {
+	.verify = sunxi_ecdsa_verify_dm,
+};
+
+U_BOOT_DRIVER(sun8i_ce_ecdsa) = {
+	.name = "sun8i-ce-ecdsa",
+	.id = UCLASS_ECDSA,
+	.ops = &sunxi_ecdsa_ops,
+	.flags = DM_FLAG_PRE_RELOC,
+};
diff --git a/drivers/crypto/allwinner/sun8i-ce/sun8i-ce.h b/drivers/crypto/allwinner/sun8i-ce/sun8i-ce.h
index 1580fff35fe..7facd6d89ad 100644
--- a/drivers/crypto/allwinner/sun8i-ce/sun8i-ce.h
+++ b/drivers/crypto/allwinner/sun8i-ce/sun8i-ce.h
@@ -15,6 +15,9 @@
 #define SUNXI_CE_CHAN_INT		BIT(SUNXI_CE_CHAN)
 #define SUNXI_CE_COMM_INT		BIT(31)
 #define SUNXI_CE_METHOD_AES		0
+#define SUNXI_CE_METHOD_ECC		33
+#define SUNXI_CE_ECC_OP_VERIFY		7
+#define SUNXI_CE_ECC_OP_SHIFT		16
 #define SUNXI_CE_MAX_SG			8
 
 struct sunxi_ce_sginfo {
@@ -39,6 +42,7 @@ struct sunxi_ce_task {
 
 struct sunxi_ce_variant {
 	bool has_aes;
+	bool has_ecdsa;
 	bool cipher_t_dlen_in_bytes;
 	bool needs_word_addresses;
 	void (*setup_mod_clock)(void);

-- 
2.53.0

