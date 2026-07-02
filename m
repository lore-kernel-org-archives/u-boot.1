Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F8CCC43458
	for <u-boot@archiver.kernel.org>; Thu,  2 Jul 2026 01:48:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AEC0684C5F;
	Thu,  2 Jul 2026 03:48:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="dVbnX1S6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 57F0084C15; Thu,  2 Jul 2026 03:48:13 +0200 (CEST)
Received: from mail-oo1-xc29.google.com (mail-oo1-xc29.google.com
 [IPv6:2607:f8b0:4864:20::c29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A63D484C86
 for <u-boot@lists.denx.de>; Thu,  2 Jul 2026 03:48:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=james.hilliard1@gmail.com
Received: by mail-oo1-xc29.google.com with SMTP id
 006d021491bc7-6a1160a2c42so800401eaf.0
 for <u-boot@lists.denx.de>; Wed, 01 Jul 2026 18:48:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782956889; x=1783561689; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1s7alzWFjowY3ydSCttwnAWh/Kk2b9TsJPR0R3bmNHU=;
 b=dVbnX1S6N+ig3pfr0ha4QV+yBLKSdhg/54vUqLZT/TJ9Gwi35IW4XVauAs3UBXf5ij
 bSGU8/30LF6xnHIt70xkVB9Kv2+a1aAEMk34dVAo0RWYoC0HolLxtfMlm5OIIXsz8Zan
 zOQFxTvLOZ9q/zcr+T8XWks6W7ZH0nvBSldN18Qnw9FAfSvX9ok5kiIukwpffGOWBGcQ
 Gf17quc/IBYxzIsLONAvHvxQAuLuAFp2+QTwhlwTUXWo6LhXX5afdqLHZAHlOEEwYq0Q
 N7N6tgFYn54SFA8QDOYxEsDg4U/mcvhHWcMlbS9aNOPI5+GDur/LNRwjIN6NMwbetA8D
 6ajg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782956889; x=1783561689;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=1s7alzWFjowY3ydSCttwnAWh/Kk2b9TsJPR0R3bmNHU=;
 b=KZn0kBV7MLj9yxUobjLDkPS3dGuTtxPZI5kFo0bdIZEBPrbg6lk3Bu7Ut8IH5N4lC4
 fnWenxNJeY4EttCF9yQ5jNrBzNi21LXEWON1Ca7350yzYaQcYocuF3mBBLsrYjbRZw2s
 GGvnwjrrSYXHrmMUtvJ/2xGPuI7NnfM16EsL9F5Cn5n8BPY6+ecr7klvIKBUPzamV1kq
 N8PAY2U4w7echNthzr/T6fje0Eh3bVaXyajb6qy6+/XkwhI27FqU5NcVe1pZqh3mugKl
 xZ0SvhLPr0kG2SclaolcnN3TbZUrk3eDYCgIs7sFoC6f92xhuCAWEdLJphGfoz8TCTW+
 +yMA==
X-Gm-Message-State: AOJu0Yw9YhGC8gAiytOYnkYMn6mL2qj9FhR/nWHXK9mB3OJVoLvXto60
 P6+PV3HGkiaHA6fCQQ/n5AMtPXecSxYFKSrWIiD/AR0ayXfRh5nxRCIAqPb1hMD5Xbbs9g==
X-Gm-Gg: AfdE7ckww72RD2AIKlsTmQfBy++duojtak5O9DcNXJce+Bm+aqF++xWo75vp0AwWQDi
 AJg5zPvznefcjMfjmv21ncJsCxrCdayN63/2TcJYEU2QIYgKUE1SXJ2O1IlHEyL6B5RsyPfluuH
 Bl733a0J/Uz3NBPdNfosb7C0sV9MvPQoGSkg6a+pl9sqrJK3k5jCr9FHVPPtNO12uQsPqjxQV69
 bo6M9G/TTUYVEbw/oHJHGcJx7wpX6AJUiFLT350No580g8+lx+NKwTb567LfRDEi/uQHDAkLHfO
 JxXnsRL4uBsryuPv8SB19Ipte/5Qj/04VmxKpvSKjR/Isf9ZetO7Ri5ELRhgoRvBR4EE3MYzOsh
 Fd6J2FK3Ef5ZKbLrfKexvaLKjdr9F29XlwGky/AY9oaozaFCoJXLqrTVf7TDNO+bm/f4mnR0uEz
 GLiAIdWtTC384splYlylnzqg3KasiAb+XTdweeJBNzTRHj61/G0Ks8iEbioAu3F50FMaIHlTGXy
 EpmLGU64xUbd8eVu3yyVjoVZpAfEDA0OPH22gXciJgzGPtQlK1KCWl8xmfWFbnppdA4D4H7OqWK
 NJNI+Ase9p4Xq4g=
X-Received: by 2002:a05:6820:16a2:b0:6a1:5103:5ee5 with SMTP id
 006d021491bc7-6a309a76ed0mr2644217eaf.28.1782956889191; 
 Wed, 01 Jul 2026 18:48:09 -0700 (PDT)
Received: from james-x399.tailafd1a.ts.net (97-118-25-163.hlrn.qwest.net.
 [97.118.25.163]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6a310051cfcsm1284511eaf.8.2026.07.01.18.48.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Jul 2026 18:48:08 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
To: u-boot@lists.denx.de
Cc: Andre Przywara <andre.przywara@arm.com>, Chen-Yu Tsai <wens@kernel.org>,
 Samuel Holland <samuel@sholland.org>,
 James Hilliard <james.hilliard1@gmail.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 8/9] crypto: allwinner: add sun8i-ce ECDSA verifier
Date: Wed,  1 Jul 2026 19:46:58 -0600
Message-ID: <20260702014724.1534351-8-james.hilliard1@gmail.com>
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

The H616 Crypto Engine includes an ECC engine which can verify ECDSA
signatures. Add a UCLASS_ECDSA child for the sun8i-ce parent so FIT
signature verification can use the hardware block from U-Boot proper and
SPL.

The CE takes explicit curve parameters for each operation. Provide tables
for the curves accepted by U-Boot's FIT ECDSA parser: secp224r1,
prime256v1, secp384r1 and secp521r1.

The CE input buffer uses fixed-width curve fields. Reuse the parameter
packing logic for the message digest as well, so wider digests are
truncated to the leftmost curve-width bytes according to ECDSA rules.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 drivers/crypto/allwinner/sun8i-ce/Kconfig     |  29 ++
 drivers/crypto/allwinner/sun8i-ce/Makefile    |   1 +
 .../crypto/allwinner/sun8i-ce/sun8i-ce-core.c |   8 +
 .../allwinner/sun8i-ce/sun8i-ce-ecdsa.c       | 413 ++++++++++++++++++
 drivers/crypto/allwinner/sun8i-ce/sun8i-ce.h  |   4 +
 5 files changed, 455 insertions(+)
 create mode 100644 drivers/crypto/allwinner/sun8i-ce/sun8i-ce-ecdsa.c

diff --git a/drivers/crypto/allwinner/sun8i-ce/Kconfig b/drivers/crypto/allwinner/sun8i-ce/Kconfig
index f72cf3498fe..3a259181143 100644
--- a/drivers/crypto/allwinner/sun8i-ce/Kconfig
+++ b/drivers/crypto/allwinner/sun8i-ce/Kconfig
@@ -37,3 +37,32 @@ config SPL_SUNXI_CE_AES
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
index 00000000000..28f1b09f929
--- /dev/null
+++ b/drivers/crypto/allwinner/sun8i-ce/sun8i-ce-ecdsa.c
@@ -0,0 +1,413 @@
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
+#define SUNXI_ECDSA_MAX_WORDS		17
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
+static const struct sunxi_ecdsa_curve sunxi_ecdsa_curves[] = {
+	{
+		.name = "secp224r1",
+		.bits = 224,
+		.bytes = 28,
+		.words = 7,
+		.p = ecdsa_p224_p,
+		.a = ecdsa_p224_a,
+		.gx = ecdsa_p224_gx,
+		.gy = ecdsa_p224_gy,
+		.n = ecdsa_p224_n,
+	}, {
+		.name = "prime256v1",
+		.bits = 256,
+		.bytes = 32,
+		.words = 8,
+		.p = ecdsa_p256_p,
+		.a = ecdsa_p256_a,
+		.gx = ecdsa_p256_gx,
+		.gy = ecdsa_p256_gy,
+		.n = ecdsa_p256_n,
+	}, {
+		.name = "secp384r1",
+		.bits = 384,
+		.bytes = 48,
+		.words = 12,
+		.p = ecdsa_p384_p,
+		.a = ecdsa_p384_a,
+		.gx = ecdsa_p384_gx,
+		.gy = ecdsa_p384_gy,
+		.n = ecdsa_p384_n,
+	}, {
+		.name = "secp521r1",
+		.bits = 521,
+		.bytes = 66,
+		.words = 17,
+		.p = ecdsa_p521_p,
+		.a = ecdsa_p521_a,
+		.gx = ecdsa_p521_gx,
+		.gy = ecdsa_p521_gy,
+		.n = ecdsa_p521_n,
+	},
+};
+
+static const struct sunxi_ecdsa_curve *
+sunxi_ecdsa_find_curve(const struct ecdsa_public_key *pubkey)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(sunxi_ecdsa_curves); i++) {
+		if (!strcmp(pubkey->curve_name, sunxi_ecdsa_curves[i].name))
+			return &sunxi_ecdsa_curves[i];
+	}
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

