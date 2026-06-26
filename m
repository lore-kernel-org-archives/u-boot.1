Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C3BECDE008
	for <u-boot@archiver.kernel.org>; Fri, 26 Jun 2026 00:34:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9469B84987;
	Fri, 26 Jun 2026 02:34:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="FHQhg9PY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ECC1184987; Fri, 26 Jun 2026 02:34:18 +0200 (CEST)
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com
 [IPv6:2607:f8b0:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8D62B8498C
 for <u-boot@lists.denx.de>; Fri, 26 Jun 2026 02:34:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=james.hilliard1@gmail.com
Received: by mail-ot1-x32c.google.com with SMTP id
 46e09a7af769-7e93d1dd156so165997a34.0
 for <u-boot@lists.denx.de>; Thu, 25 Jun 2026 17:34:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782434053; x=1783038853; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=LPZ3YqrWWPsvmDFr4L8FDDEXJS1AWdxDUAzEeKTV6Ko=;
 b=FHQhg9PYMPoTbDenN2r1nVJQLtlpnahBR/YTv7pXdMnJtSMyk0MOcOA6ya4T7d4vku
 YNJ7c9SKrWmoJQz4myO7Y+IcdH+Recpnl/yL6Z+EKQ6TY3fTkQaoIUCyS9/tZU8SvzXw
 mtQ55XboTvE1DXvpDiKb0d9d11GabQbvev3RH49Y4FUVaXzU+PxHq2pTVh6YyBjriZvG
 +MEIak+gkbGYADc+Z/VoC3YCShf2HYWRDX6Qy8zueGrpudRuPct5lM645wwDXpKoYQqA
 fVTwqQP3vclo1ih1Xvrh5QGW7lOZAdmkeWGnQ7BFHQUo0ttdZyysoyN/2JSke32olsFR
 zF5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782434053; x=1783038853;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LPZ3YqrWWPsvmDFr4L8FDDEXJS1AWdxDUAzEeKTV6Ko=;
 b=gyJei1VZEj63Q4/x0AoZ0vApi/PRkSmvy1CovP/uzkPoXPmS8Esqvs3ki9T1/Vh+Ku
 tyvNkkqOU0Ph+jGyN28TNz+gpmiv9MhqnU1bkDoZ5Lejdi6AyXvx2DcPIrZTheGyz2OP
 e4SwIbfZrtRlM76LtUjRI0QmKWPKS2XlkI6bLwPQMC6SCLcfOzrVaY1TZk63cj4XTLwK
 dLNAYsLaNgA62npzHXuHqGjSiHnMu2I5+XnFMJig1QVctW8Re0E+Ai8XSkX7Snayr6ZT
 7V2J18X5W50Qi5PR75GH5XTnyhjQTQjEKV5CUN2FUZEMHd2SUfJ2eCo19sFZQEjHknba
 U+0A==
X-Gm-Message-State: AOJu0YxTJoYKs4Fnd1pCIhykDXD3seWlbVbEW5ts8GJpVACKE54zbrSt
 ZSe1Sj6w3AU0hU6PxudjmOXb3O4nXB3AO4COidAatpwIInbMr3ug7iBOPI76x4nd/j4=
X-Gm-Gg: AfdE7ckpHciqbbPbdl+b95I5amftXmnA5D6ua4zOY5+e9Tb8UynosF0wntA5ubd2PYh
 DBf3r+DwL7j8R9KGvAT73SAJA8oshXVUhnQS0pmSHX67oP3Z0SzGQ0G8T1LYJQSqrbnVvc3v3tM
 FOr8dLq0PrkWPn7RA+7iR2rVc8f134D+3ATNXYZMgEWObdkMEqZuFEktj1rfe+IaDq0hxsVo2mf
 vWAE9KVmq/5Wn5pi4foKhE3k8oNr+tX/u/VEjuRzrgJZpnzmjxocMSOf6WAJdw297FjKIhJXrge
 hTYFffocy1jqfXZqX33GDt57LsJUkOUI8YQYEuHN8SNdiPn/Bo4Gl2XI72XTwCUEi8IQtBCYJYx
 KBXA9dJ/2Vovg6zCNHJ9Occ9Rsg4Qh5XkcwFY7yR8UQmiqI+89WnpoN/tRW87hMGVBOhu3L+P13
 n2xgrPPM0BCfvrgOtLdyozTYFi/CYvJJUPSchjkYM2qMyhzkMJ+TyqkMewAnHykTZ1tLurrli4q
 vduv+Z0SRovh+c8fByQKmpEXYk386N5Ng4YFScWah7ijPNFS77UZgVJONbt1Ke6QgRiDAqIhmKN
 a2hJzFnYiyVUc6I=
X-Received: by 2002:a05:6830:6084:b0:7e9:8867:cb23 with SMTP id
 46e09a7af769-7e99c257361mr4757527a34.16.1782434052935; 
 Thu, 25 Jun 2026 17:34:12 -0700 (PDT)
Received: from james-x399.tailafd1a.ts.net (97-118-25-163.hlrn.qwest.net.
 [97.118.25.163]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e9aa7d4fabsm435932a34.22.2026.06.25.17.34.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jun 2026 17:34:12 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
To: u-boot@lists.denx.de
Cc: James Hilliard <james.hilliard1@gmail.com>, Tom Rini <trini@konsulko.com>,
 Andre Przywara <andre.przywara@arm.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Simon Glass <sjg@chromium.org>,
 David Lechner <dlechner@baylibre.com>,
 Julien Stephan <jstephan@baylibre.com>, Peng Fan <peng.fan@nxp.com>,
 Kory Maincent <kory.maincent@bootlin.com>,
 Kuan-Wei Chiu <visitorckw@gmail.com>,
 Raymond Mao <raymond.mao@riscstar.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Stefan Roese <stefan.roese@mailbox.org>,
 Jerome Forissier <jerome.forissier@arm.com>, E Shattow <e@freeshell.de>,
 Wolfgang Wallner <wolfgang.wallner@at.abb.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Enric Balletbo i Serra <eballetbo@kernel.org>,
 Ion Agorria <ion@agorria.com>, Svyatoslav Ryhel <clamor95@gmail.com>,
 Daniel Golle <daniel@makrotopia.org>, Lucas Dietrich <ld.adecy@gmail.com>
Subject: [PATCH] crypto: sunxi: add CE ECDSA verifier
Date: Thu, 25 Jun 2026 18:34:00 -0600
Message-ID: <20260626003408.1754656-1-james.hilliard1@gmail.com>
X-Mailer: git-send-email 2.53.0
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

The Allwinner sunxi Crypto Engine found on the H616 includes an ECC
engine which can verify ECDSA signatures. Add a UCLASS_ECDSA provider
so FIT signature verification can use the hardware block from U-Boot
proper and SPL.

The CE takes explicit curve parameters, so provide parameter tables for
secp224r1, prime256v1, secp384r1 and secp521r1 using the curves
accepted by U-Boot's FIT ECDSA parser. Extend the generic ECDSA signing
and verification plumbing for the additional algorithm names and for
non-32-bit coordinate sizes.

The CE input buffer uses fixed-width curve fields. Reuse the parameter
packing logic for the message digest as well, so wider digests are
truncated to the leftmost curve-width bytes according to ECDSA rules.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 MAINTAINERS                    |   1 +
 doc/mkimage.1                  |   3 +
 doc/usage/fit/signature.rst    |   3 +-
 drivers/crypto/Kconfig         |  26 ++
 drivers/crypto/Makefile        |   1 +
 drivers/crypto/sunxi_ecdsa.c   | 612 +++++++++++++++++++++++++++++++++
 include/u-boot/ecdsa.h         |  16 +
 include/u-boot/fdt-libcrypto.h |   4 +-
 lib/ecdsa/Kconfig              |   2 +-
 lib/ecdsa/ecdsa-libcrypto.c    | 109 +++---
 lib/ecdsa/ecdsa-verify.c       |  33 +-
 lib/fdt-libcrypto.c            |  57 +--
 tools/image-sig-host.c         |   7 +
 13 files changed, 764 insertions(+), 110 deletions(-)
 create mode 100644 drivers/crypto/sunxi_ecdsa.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 370bcff56c1..d62252e1d1b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -770,6 +770,7 @@ F:	arch/arm/include/asm/arch-sunxi/
 F:	arch/arm/mach-sunxi/
 F:	board/sunxi/
 F:	drivers/clk/sunxi/
+F:	drivers/crypto/sunxi_ecdsa.c
 F:	drivers/phy/allwinner/
 F:	drivers/pinctrl/sunxi/
 F:	drivers/video/sunxi/
diff --git a/doc/mkimage.1 b/doc/mkimage.1
index 9a2d07cee75..b6ba88dd314 100644
--- a/doc/mkimage.1
+++ b/doc/mkimage.1
@@ -459,7 +459,10 @@ lb.
 rsa2048
 rsa3072
 rsa4096
+ecdsa224
 ecdsa256
+ecdsa384
+secp521r1
 .TE
 .RE
 .
diff --git a/doc/usage/fit/signature.rst b/doc/usage/fit/signature.rst
index da08cc75c3a..4f35f44bc8a 100644
--- a/doc/usage/fit/signature.rst
+++ b/doc/usage/fit/signature.rst
@@ -132,7 +132,8 @@ rsa,n0-inverse
 For ECDSA the following are mandatory:
 
 ecdsa,curve
-    Name of ECDSA curve (e.g. "prime256v1")
+    Name of ECDSA curve, such as "secp224r1", "prime256v1",
+    "secp384r1", or "secp521r1"
 
 ecdsa,x-point
     Public key X coordinate as a big-endian multi-word integer
diff --git a/drivers/crypto/Kconfig b/drivers/crypto/Kconfig
index 0d58e3910fe..9b0a4f18e24 100644
--- a/drivers/crypto/Kconfig
+++ b/drivers/crypto/Kconfig
@@ -6,6 +6,32 @@ source "drivers/crypto/aes/Kconfig"
 
 source "drivers/crypto/fsl/Kconfig"
 
+config SUNXI_ECDSA
+	bool "Allwinner sunxi CE ECDSA verifier"
+	depends on ARCH_SUNXI
+	depends on ECDSA_VERIFY
+	depends on CLK && DM_RESET
+	help
+	  Select this option to enable ECDSA signature verification using
+	  the Crypto Engine found in Allwinner sunxi SoCs. FIT image
+	  signatures can then be checked by the hardware accelerator in
+	  U-Boot proper. Digests wider than the selected curve are
+	  truncated according to ECDSA rules.
+
+config SPL_SUNXI_ECDSA
+	bool "Allwinner sunxi CE ECDSA verifier in SPL"
+	depends on ARCH_SUNXI
+	depends on SPL_DM
+	depends on SPL_OF_CONTROL
+	depends on SPL_ECDSA_VERIFY
+	select SPL_CRYPTO
+	help
+	  Select this option to enable ECDSA signature verification in SPL
+	  using the Crypto Engine found in Allwinner sunxi SoCs. This allows
+	  SPL FIT image signatures to be checked by the hardware accelerator
+	  before U-Boot proper is loaded. Digests wider than the selected
+	  curve are truncated according to ECDSA rules.
+
 source "drivers/crypto/aspeed/Kconfig"
 
 source "drivers/crypto/nuvoton/Kconfig"
diff --git a/drivers/crypto/Makefile b/drivers/crypto/Makefile
index e4a4482b7f3..88291ae235f 100644
--- a/drivers/crypto/Makefile
+++ b/drivers/crypto/Makefile
@@ -4,6 +4,7 @@
 #	http://www.samsung.com
 
 obj-$(CONFIG_EXYNOS_ACE_SHA)	+= ace_sha.o
+obj-$(CONFIG_$(PHASE_)SUNXI_ECDSA) += sunxi_ecdsa.o
 obj-y += aes/
 obj-y += rsa_mod_exp/
 obj-y += fsl/
diff --git a/drivers/crypto/sunxi_ecdsa.c b/drivers/crypto/sunxi_ecdsa.c
new file mode 100644
index 00000000000..e74239d640c
--- /dev/null
+++ b/drivers/crypto/sunxi_ecdsa.c
@@ -0,0 +1,612 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2026 James Hilliard
+ */
+
+#include <cpu_func.h>
+#include <crypto/ecdsa-uclass.h>
+#include <clk.h>
+#include <dm.h>
+#include <dm/device_compat.h>
+#include <reset.h>
+#include <log.h>
+#include <malloc.h>
+#include <memalign.h>
+#include <string.h>
+#include <asm/cache.h>
+#include <asm/arch/cpu.h>
+#include <asm/io.h>
+#include <linux/bitops.h>
+#include <linux/iopoll.h>
+#include <linux/kernel.h>
+
+#define SUNXI_CE_TDA			0x00
+#define SUNXI_CE_ICR			0x08
+#define SUNXI_CE_ISR			0x0c
+#define SUNXI_CE_TLR			0x10
+#define SUNXI_CE_ERR			0x18
+
+#define SUNXI_CE_CHAN			0
+#define SUNXI_CE_CHAN_INT		BIT(SUNXI_CE_CHAN)
+#define SUNXI_CE_CHAN_ERR_MASK		(0xff << (SUNXI_CE_CHAN * 8))
+#define SUNXI_CE_TASK_INT		BIT(31)
+#define SUNXI_CE_METHOD_ECC		33
+#define SUNXI_CE_TLR_METHOD_SHIFT	8
+#define SUNXI_CE_ECC_OP_VERIFY		7
+#define SUNXI_CE_ECC_OP_SHIFT		16
+#define SUNXI_CE_WORD_SHIFT		2
+#define SUNXI_CE_TIMEOUT_US		1000000
+
+#define SUN50I_H616_CCU_CE_CLK		0x680
+#define SUN50I_H616_CCU_CE_BGR		0x68c
+#define SUN50I_H616_CCU_MBUS_GATE	0x804
+#define SUN50I_H616_CCU_CE_CLK_SRC_PLL_PERIPH0_2X BIT(24)
+#define SUN50I_H616_CCU_CE_CLK_N_MASK	GENMASK(9, 8)
+#define SUN50I_H616_CCU_CE_CLK_M_MASK	GENMASK(3, 0)
+#define SUN50I_H616_CCU_CE_CLK_M_4	3
+#define SUN50I_H616_CCU_CE_CLK_GATE	BIT(31)
+#define SUN50I_H616_CCU_CE_BUS_GATE	BIT(0)
+#define SUN50I_H616_CCU_CE_BUS_RST	BIT(16)
+#define SUN50I_H616_CCU_MBUS_GATE_CE	BIT(2)
+
+#define SUNXI_ECDSA_PARAMS		12
+#define SUNXI_ECDSA_MAX_WORDS		17
+#define SUNXI_ECDSA_MAX_BYTES		(SUNXI_ECDSA_MAX_WORDS * sizeof(u32))
+#define SUNXI_ECDSA_MAX_SRC_BYTES	(SUNXI_ECDSA_PARAMS * SUNXI_ECDSA_MAX_BYTES)
+
+struct sunxi_ce_sg {
+	u32 addr;
+	u32 len;
+};
+
+struct sunxi_ce_task {
+	u32 chan_id;
+	u32 comm_ctl;
+	u32 sym_ctl;
+	u32 asym_ctl;
+	u32 key_addr;
+	u32 iv_addr;
+	u32 ctr_addr;
+	u32 data_len;
+	struct sunxi_ce_sg src[8];
+	struct sunxi_ce_sg dst[8];
+	u32 next;
+	u32 reserved[3];
+};
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
+struct sunxi_ecdsa_variant {
+	void (*spl_enable_clocks)(void);
+};
+
+struct sunxi_ecdsa_priv {
+	void __iomem *base;
+	const struct sunxi_ecdsa_variant *variant;
+	struct clk_bulk clks;
+	struct reset_ctl_bulk resets;
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
+static void sunxi_ecdsa_flush(void *buf, size_t len)
+{
+	ulong start = ALIGN_DOWN((ulong)buf, ARCH_DMA_MINALIGN);
+	ulong end = ALIGN((ulong)buf + len, ARCH_DMA_MINALIGN);
+
+	flush_dcache_range(start, end);
+}
+
+static void sunxi_ecdsa_invalidate(void *buf, size_t len)
+{
+	ulong start = ALIGN_DOWN((ulong)buf, ARCH_DMA_MINALIGN);
+	ulong end = ALIGN((ulong)buf + len, ARCH_DMA_MINALIGN);
+
+	invalidate_dcache_range(start, end);
+}
+
+static u32 sunxi_ecdsa_word_addr(void *buf)
+{
+	return (u32)(virt_to_phys(buf) >> SUNXI_CE_WORD_SHIFT);
+}
+
+static void sun50i_h616_ecdsa_spl_enable_clocks(void)
+{
+	void __iomem *ccu = (void __iomem *)SUNXI_CCM_BASE;
+
+	clrsetbits_le32(ccu + SUN50I_H616_CCU_CE_CLK,
+			SUN50I_H616_CCU_CE_CLK_SRC_PLL_PERIPH0_2X |
+			SUN50I_H616_CCU_CE_CLK_N_MASK |
+			SUN50I_H616_CCU_CE_CLK_M_MASK,
+			SUN50I_H616_CCU_CE_CLK_GATE |
+			SUN50I_H616_CCU_CE_CLK_SRC_PLL_PERIPH0_2X |
+			SUN50I_H616_CCU_CE_CLK_M_4);
+	setbits_le32(ccu + SUN50I_H616_CCU_CE_BGR,
+		     SUN50I_H616_CCU_CE_BUS_GATE |
+		     SUN50I_H616_CCU_CE_BUS_RST);
+	setbits_le32(ccu + SUN50I_H616_CCU_MBUS_GATE,
+		     SUN50I_H616_CCU_MBUS_GATE_CE);
+}
+
+static void sunxi_ecdsa_spl_enable_clocks(struct sunxi_ecdsa_priv *priv)
+{
+	if (priv->variant && priv->variant->spl_enable_clocks)
+		priv->variant->spl_enable_clocks();
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
+static void sunxi_ecdsa_fill_task(struct sunxi_ecdsa_job *job,
+				  const struct sunxi_ecdsa_curve *curve)
+{
+	struct sunxi_ce_task *task = &job->task;
+	u32 bytes = curve->words * sizeof(u32);
+
+	task->chan_id = SUNXI_CE_CHAN;
+	task->comm_ctl = SUNXI_CE_TASK_INT | SUNXI_CE_METHOD_ECC;
+	task->asym_ctl = curve->words |
+			 (SUNXI_CE_ECC_OP_VERIFY << SUNXI_CE_ECC_OP_SHIFT);
+	task->data_len = SUNXI_ECDSA_PARAMS * bytes;
+	task->src[0].addr = sunxi_ecdsa_word_addr(job->src);
+	task->src[0].len = task->data_len / sizeof(u32);
+	task->dst[0].addr = sunxi_ecdsa_word_addr(job->dst);
+	task->dst[0].len = curve->words;
+}
+
+static int sunxi_ecdsa_run(struct sunxi_ecdsa_priv *priv,
+			   struct sunxi_ecdsa_job *job)
+{
+	u32 val, err, result;
+	int ret;
+
+	sunxi_ecdsa_flush(&job->task, sizeof(job->task));
+	sunxi_ecdsa_flush(job->src, job->task.data_len);
+	sunxi_ecdsa_flush(job->dst, job->task.dst[0].len * sizeof(u32));
+
+	writel(SUNXI_CE_CHAN_INT, priv->base + SUNXI_CE_ISR);
+	writel(SUNXI_CE_CHAN_ERR_MASK, priv->base + SUNXI_CE_ERR);
+	writel(SUNXI_CE_CHAN_INT, priv->base + SUNXI_CE_ICR);
+
+	writel(sunxi_ecdsa_word_addr(&job->task), priv->base + SUNXI_CE_TDA);
+	writel(BIT(0) | (SUNXI_CE_METHOD_ECC << SUNXI_CE_TLR_METHOD_SHIFT),
+	       priv->base + SUNXI_CE_TLR);
+
+	ret = readl_poll_timeout(priv->base + SUNXI_CE_ISR, val,
+				 val & SUNXI_CE_CHAN_INT,
+				 SUNXI_CE_TIMEOUT_US);
+	if (ret)
+		return ret;
+
+	err = readl(priv->base + SUNXI_CE_ERR) & SUNXI_CE_CHAN_ERR_MASK;
+	writel(SUNXI_CE_CHAN_INT, priv->base + SUNXI_CE_ISR);
+	writel(SUNXI_CE_CHAN_ERR_MASK, priv->base + SUNXI_CE_ERR);
+
+	if (err) {
+		debug("%s: CE error %#x\n", __func__, err);
+		return -EIO;
+	}
+
+	sunxi_ecdsa_invalidate(job->dst, job->task.dst[0].len * sizeof(u32));
+	result = *(u32 *)job->dst;
+
+	return result == 1 ? 0 : -EPERM;
+}
+
+static int sunxi_ecdsa_verify_common(struct sunxi_ecdsa_priv *priv,
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
+	sunxi_ecdsa_fill_task(job, curve);
+
+	if (IS_ENABLED(CONFIG_XPL_BUILD))
+		sunxi_ecdsa_spl_enable_clocks(priv);
+
+	ret = sunxi_ecdsa_run(priv, job);
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
+	struct sunxi_ecdsa_priv *priv = dev_get_priv(dev);
+
+	return sunxi_ecdsa_verify_common(priv, pubkey, hash, hash_len,
+					 signature, sig_len);
+}
+
+static int sunxi_ecdsa_probe(struct udevice *dev)
+{
+	struct sunxi_ecdsa_priv *priv = dev_get_priv(dev);
+	int ret;
+
+	priv->variant = (const struct sunxi_ecdsa_variant *)
+			dev_get_driver_data(dev);
+	priv->base = dev_read_addr_ptr(dev);
+	if (!priv->base)
+		return -EINVAL;
+
+	if (IS_ENABLED(CONFIG_XPL_BUILD)) {
+		sunxi_ecdsa_spl_enable_clocks(priv);
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
+	return 0;
+
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
+static int sunxi_ecdsa_remove(struct udevice *dev)
+{
+	struct sunxi_ecdsa_priv *priv = dev_get_priv(dev);
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
+static const struct ecdsa_ops sunxi_ecdsa_ops = {
+	.verify = sunxi_ecdsa_verify_dm,
+};
+
+static const struct sunxi_ecdsa_variant sun50i_h616_variant = {
+	.spl_enable_clocks = sun50i_h616_ecdsa_spl_enable_clocks,
+};
+
+static const struct udevice_id sunxi_ecdsa_ids[] = {
+	{
+		.compatible = "allwinner,sun50i-h616-crypto",
+		.data = (ulong)&sun50i_h616_variant,
+	},
+	{ }
+};
+
+U_BOOT_DRIVER(sunxi_ecdsa) = {
+	.name = "sunxi_ecdsa",
+	.id = UCLASS_ECDSA,
+	.of_match = sunxi_ecdsa_ids,
+	.ops = &sunxi_ecdsa_ops,
+	.probe = sunxi_ecdsa_probe,
+	.remove = sunxi_ecdsa_remove,
+	.priv_auto = sizeof(struct sunxi_ecdsa_priv),
+	.flags = DM_FLAG_PRE_RELOC,
+};
diff --git a/include/u-boot/ecdsa.h b/include/u-boot/ecdsa.h
index f0ac0f327e9..e8b01cd0258 100644
--- a/include/u-boot/ecdsa.h
+++ b/include/u-boot/ecdsa.h
@@ -8,6 +8,7 @@
 
 #include <errno.h>
 #include <image.h>
+#include <string.h>
 
 /**
  * crypto_algo API impementation for ECDSA;
@@ -64,8 +65,23 @@ int ecdsa_verify(struct image_sign_info *info,
 		 uint8_t *sig, uint sig_len);
 /** @} */
 
+#define ECDSA224_BYTES	(224 / 8)
 #define ECDSA256_BYTES	(256 / 8)
 #define ECDSA384_BYTES	(384 / 8)
 #define ECDSA521_BYTES	((521 + 7) / 8)
 
+static inline unsigned int ecdsa_curve_size(const char *curve_name)
+{
+	if (!strcmp(curve_name, "secp224r1"))
+		return 224;
+	else if (!strcmp(curve_name, "prime256v1"))
+		return 256;
+	else if (!strcmp(curve_name, "secp384r1"))
+		return 384;
+	else if (!strcmp(curve_name, "secp521r1"))
+		return 521;
+
+	return 0;
+}
+
 #endif
diff --git a/include/u-boot/fdt-libcrypto.h b/include/u-boot/fdt-libcrypto.h
index b15d8a1eaf4..a7631cd0e04 100644
--- a/include/u-boot/fdt-libcrypto.h
+++ b/include/u-boot/fdt-libcrypto.h
@@ -12,7 +12,7 @@
 /**
  * fdt_add_bignum() - Write a libcrypto BIGNUM as an FDT property
  *
- * Convert a libcrypto BIGNUM * into a big endian array of integers.
+ * Convert a libcrypto BIGNUM * into a fixed-width big endian byte array.
  *
  * @blob:	FDT blob to modify
  * @noffset:	Offset of the FDT node
@@ -22,6 +22,6 @@
  * Return: 0 if all good all working, -ve on horror
  */
 int fdt_add_bignum(void *blob, int noffset, const char *prop_name,
-		   BIGNUM *num, int num_bits);
+		   const BIGNUM *num, int num_bits);
 
 #endif /* _FDT_LIBCRYPTO_H */
diff --git a/lib/ecdsa/Kconfig b/lib/ecdsa/Kconfig
index ca13b6bfa1f..f0c56278fb6 100644
--- a/lib/ecdsa/Kconfig
+++ b/lib/ecdsa/Kconfig
@@ -17,7 +17,7 @@ config ECDSA_VERIFY
 
 config SPL_ECDSA_VERIFY
 	bool "Enable ECDSA verification support in SPL"
-	depends on SPL
+	depends on SPL && SPL_DM
 	help
 	  Allow ECDSA signatures to be recognized and verified in SPL.
 
diff --git a/lib/ecdsa/ecdsa-libcrypto.c b/lib/ecdsa/ecdsa-libcrypto.c
index c4bfb2cec61..4877940c631 100644
--- a/lib/ecdsa/ecdsa-libcrypto.c
+++ b/lib/ecdsa/ecdsa-libcrypto.c
@@ -31,7 +31,7 @@ struct signer {
 	EVP_PKEY *evp_key;	/* Pointer to EVP_PKEY object */
 	EC_KEY *ecdsa_key;	/* Pointer to EC_KEY object */
 	void *hash;		/* Pointer to hash used for verification */
-	void *signature;	/* Pointer to output signature. Do not free()!*/
+	void *signature;	/* Pointer to raw signature buffer */
 };
 
 struct ecdsa_public_key {
@@ -50,11 +50,8 @@ static int fdt_get_key(struct ecdsa_public_key *key, const void *fdt, int node)
 	if (!key->curve_name)
 		return -ENOMSG;
 
-	if (!strcmp(key->curve_name, "prime256v1"))
-		key->size_bits = 256;
-	else if (!strcmp(key->curve_name, "secp384r1"))
-		key->size_bits = 384;
-	else
+	key->size_bits = ecdsa_curve_size(key->curve_name);
+	if (!key->size_bits)
 		return -EINVAL;
 
 	key->x = fdt_getprop(fdt, node, "ecdsa,x-point", &x_len);
@@ -63,7 +60,8 @@ static int fdt_get_key(struct ecdsa_public_key *key, const void *fdt, int node)
 	if (!key->x || !key->y)
 		return -EINVAL;
 
-	if (x_len != key->size_bits / 8 || y_len != key->size_bits / 8)
+	if (x_len != (key->size_bits + 7) / 8 ||
+	    y_len != (key->size_bits + 7) / 8)
 		return -EINVAL;
 
 	return 0;
@@ -85,11 +83,8 @@ static int read_key_from_fdt(struct signer *ctx, const void *fdt, int node)
 		return ret;
 	}
 
-	if (!strcmp(pubkey.curve_name, "prime256v1")) {
-		nid = NID_X9_62_prime256v1;
-	} else if (!strcmp(pubkey.curve_name, "secp384r1")) {
-		nid = NID_secp384r1;
-	} else {
+	nid = OBJ_sn2nid(pubkey.curve_name);
+	if (nid == NID_undef) {
 		fprintf(stderr, "Unsupported curve name: '%s'\n", pubkey.curve_name);
 		return -EINVAL;
 	}
@@ -111,7 +106,7 @@ static int read_key_from_fdt(struct signer *ctx, const void *fdt, int node)
 		return -ENOMEM;
 	}
 
-	len = pubkey.size_bits / 8;
+	len = (pubkey.size_bits + 7) / 8;
 
 	uint8_t buf[1 + len * 2];
 
@@ -140,7 +135,7 @@ static int read_key_from_fdt(struct signer *ctx, const void *fdt, int node)
 	return 0;
 }
 
-static int alloc_ctx(struct signer *ctx, const struct image_sign_info *info)
+static int init_ctx(struct signer *ctx)
 {
 	memset(ctx, 0, sizeof(*ctx));
 
@@ -149,11 +144,21 @@ static int alloc_ctx(struct signer *ctx, const struct image_sign_info *info)
 		return -1;
 	}
 
+	return 0;
+}
+
+static int alloc_sig_ctx(struct signer *ctx, const struct image_sign_info *info)
+{
 	ctx->hash = malloc(info->checksum->checksum_len);
 	ctx->signature = malloc(info->crypto->key_len * 2);
 
-	if (!ctx->hash || !ctx->signature)
+	if (!ctx->hash || !ctx->signature) {
+		free(ctx->hash);
+		free(ctx->signature);
+		ctx->hash = NULL;
+		ctx->signature = NULL;
 		return -ENOMEM;
+	}
 
 	return 0;
 }
@@ -166,8 +171,8 @@ static void free_ctx(struct signer *ctx)
 	if (ctx->evp_key)
 		EVP_PKEY_free(ctx->evp_key);
 
-	if (ctx->hash)
-		free(ctx->hash);
+	free(ctx->hash);
+	free(ctx->signature);
 }
 
 /*
@@ -271,10 +276,6 @@ static int load_key_from_fdt(struct signer *ctx, const struct image_sign_info *i
 	if (!fdt)
 		return -EINVAL;
 
-	ret = alloc_ctx(ctx, info);
-	if (ret)
-		return ret;
-
 	sig_node = fdt_subnode_offset(fdt, 0, FIT_SIG_NODENAME);
 	if (sig_node < 0) {
 		fprintf(stderr, "No /signature node found\n");
@@ -331,7 +332,9 @@ static int prepare_ctx(struct signer *ctx, const struct image_sign_info *info)
 	int key_len_bytes, ret;
 	char kname[1024];
 
-	memset(ctx, 0, sizeof(*ctx));
+	ret = init_ctx(ctx);
+	if (ret)
+		return ret;
 
 	if (info->fdt_blob) {
 		return load_key_from_fdt(ctx, info);
@@ -345,10 +348,6 @@ static int prepare_ctx(struct signer *ctx, const struct image_sign_info *info)
 		return -EINVAL;
 	}
 
-	ret = alloc_ctx(ctx, info);
-	if (ret)
-		return ret;
-
 	ret = read_key(ctx, kname);
 	if (ret)
 		return ret;
@@ -371,8 +370,11 @@ static int do_sign(struct signer *ctx, struct image_sign_info *info,
 
 	algo->calculate(algo->name, region, region_count, ctx->hash);
 	sig = ECDSA_do_sign(ctx->hash, algo->checksum_len, ctx->ecdsa_key);
+	if (!sig)
+		return -EIO;
 
 	ecdsa_sig_encode_raw(ctx->signature, sig, info->crypto->key_len);
+	ECDSA_SIG_free(sig);
 
 	return 0;
 }
@@ -420,11 +422,16 @@ int ecdsa_sign(struct image_sign_info *info, const struct image_region region[],
 
 	ret = prepare_ctx(&ctx, info);
 	if (ret >= 0) {
-		do_sign(&ctx, info, region, region_count);
-		*sigp = ctx.signature;
-		*sig_len = info->crypto->key_len * 2;
-
-		ret = ecdsa_check_signature(&ctx, info);
+		ret = alloc_sig_ctx(&ctx, info);
+		if (!ret)
+			ret = do_sign(&ctx, info, region, region_count);
+		if (!ret)
+			ret = ecdsa_check_signature(&ctx, info);
+		if (!ret) {
+			*sigp = ctx.signature;
+			*sig_len = info->crypto->key_len * 2;
+			ctx.signature = NULL;
+		}
 	}
 
 	free_ctx(&ctx);
@@ -439,8 +446,12 @@ int ecdsa_verify(struct image_sign_info *info,
 	int ret;
 
 	ret = prepare_ctx(&ctx, info);
-	if (ret >= 0)
-		ret = do_verify(&ctx, info, region, region_count, sig, sig_len);
+	if (ret >= 0) {
+		ret = alloc_sig_ctx(&ctx, info);
+		if (!ret)
+			ret = do_verify(&ctx, info, region, region_count,
+					sig, sig_len);
+	}
 
 	free_ctx(&ctx);
 	return ret;
@@ -453,7 +464,7 @@ static int do_add(struct signer *ctx, void *fdt, const char *key_node_name,
 	const char *curve_name;
 	const EC_GROUP *group;
 	const EC_POINT *point;
-	BIGNUM *x, *y;
+	BIGNUM *x = NULL, *y = NULL;
 
 	signature_node = fdt_subnode_offset(fdt, 0, FIT_SIG_NODENAME);
 	if (signature_node == -FDT_ERR_NOTFOUND) {
@@ -491,42 +502,54 @@ static int do_add(struct signer *ctx, void *fdt, const char *key_node_name,
 	group = EC_KEY_get0_group(ctx->ecdsa_key);
 	key_bits = EC_GROUP_order_bits(group);
 	curve_name = OBJ_nid2sn(EC_GROUP_get_curve_name(group));
-	/* Let 'x' and 'y' memory leak by not BN_free()'ing them. */
 	x = BN_new();
 	y = BN_new();
+	if (!x || !y) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
 	point = EC_KEY_get0_public_key(ctx->ecdsa_key);
-	EC_POINT_get_affine_coordinates(group, point, x, y, NULL);
+	if (!EC_POINT_get_affine_coordinates(group, point, x, y, NULL)) {
+		ret = -EINVAL;
+		goto out;
+	}
 
 	ret = fdt_setprop_string(fdt, key_node, FIT_KEY_HINT,
 				 info->keyname);
 	if (ret < 0)
-		return ret;
+		goto out;
 
 	ret = fdt_setprop_string(fdt, key_node, "ecdsa,curve", curve_name);
 	if (ret < 0)
-		return ret;
+		goto out;
 
 	ret = fdt_add_bignum(fdt, key_node, "ecdsa,x-point", x, key_bits);
 	if (ret < 0)
-		return ret;
+		goto out;
 
 	ret = fdt_add_bignum(fdt, key_node, "ecdsa,y-point", y, key_bits);
 	if (ret < 0)
-		return ret;
+		goto out;
 
 	ret = fdt_setprop_string(fdt, key_node, FIT_ALGO_PROP,
 				 info->name);
 	if (ret < 0)
-		return ret;
+		goto out;
 
 	if (info->require_keys) {
 		ret = fdt_setprop_string(fdt, key_node, FIT_KEY_REQUIRED,
 					 info->require_keys);
 		if (ret < 0)
-			return ret;
+			goto out;
 	}
 
-	return key_node;
+	ret = key_node;
+
+out:
+	BN_free(x);
+	BN_free(y);
+	return ret;
 }
 
 int ecdsa_add_verify_data(struct image_sign_info *info, void *fdt)
diff --git a/lib/ecdsa/ecdsa-verify.c b/lib/ecdsa/ecdsa-verify.c
index 629b662cf6c..201111bc128 100644
--- a/lib/ecdsa/ecdsa-verify.c
+++ b/lib/ecdsa/ecdsa-verify.c
@@ -12,22 +12,6 @@
 #include <dm/uclass.h>
 #include <u-boot/ecdsa.h>
 
-/*
- * Derive size of an ECDSA key from the curve name
- *
- * While it's possible to extract the key size by using string manipulation,
- * use a list of known curves for the time being.
- */
-static int ecdsa_key_size(const char *curve_name)
-{
-	if (!strcmp(curve_name, "prime256v1"))
-		return 256;
-	else if (!strcmp(curve_name, "secp384r1"))
-		return 384;
-
-	return 0;
-}
-
 static int fdt_get_key(struct ecdsa_public_key *key, const void *fdt, int node)
 {
 	int x_len, y_len;
@@ -38,7 +22,7 @@ static int fdt_get_key(struct ecdsa_public_key *key, const void *fdt, int node)
 		return -ENOMSG;
 	}
 
-	key->size_bits = ecdsa_key_size(key->curve_name);
+	key->size_bits = ecdsa_curve_size(key->curve_name);
 	if (key->size_bits == 0) {
 		debug("Unknown ECDSA curve '%s'", key->curve_name);
 		return -EINVAL;
@@ -50,7 +34,8 @@ static int fdt_get_key(struct ecdsa_public_key *key, const void *fdt, int node)
 	if (!key->x || !key->y)
 		return -EINVAL;
 
-	if (x_len != (key->size_bits / 8) || y_len != (key->size_bits / 8)) {
+	if (x_len != (key->size_bits + 7) / 8 ||
+	    y_len != (key->size_bits + 7) / 8) {
 		printf("%s: node=%d, curve@%p x@%p+%i y@%p+%i\n", __func__,
 		       node, key->curve_name, key->x, x_len, key->y, y_len);
 		return -EINVAL;
@@ -123,6 +108,12 @@ int ecdsa_verify(struct image_sign_info *info,
 	return ecdsa_verify_hash(dev, info, hash, sig, sig_len);
 }
 
+U_BOOT_CRYPTO_ALGO(ecdsa224) = {
+	.name = "ecdsa224",
+	.key_len = ECDSA224_BYTES,
+	.verify = ecdsa_verify,
+};
+
 U_BOOT_CRYPTO_ALGO(ecdsa256) = {
 	.name = "ecdsa256",
 	.key_len = ECDSA256_BYTES,
@@ -135,6 +126,12 @@ U_BOOT_CRYPTO_ALGO(ecdsa384) = {
 	.verify = ecdsa_verify,
 };
 
+U_BOOT_CRYPTO_ALGO(secp521r1) = {
+	.name = "secp521r1",
+	.key_len = ECDSA521_BYTES,
+	.verify = ecdsa_verify,
+};
+
 /*
  * uclass definition for ECDSA API
  *
diff --git a/lib/fdt-libcrypto.c b/lib/fdt-libcrypto.c
index ecb0344c8f6..8afe31cbe9d 100644
--- a/lib/fdt-libcrypto.c
+++ b/lib/fdt-libcrypto.c
@@ -5,68 +5,35 @@
  */
 
 #include <libfdt.h>
+#include <errno.h>
+#include <stdio.h>
+#include <stdlib.h>
 #include <u-boot/fdt-libcrypto.h>
 
 int fdt_add_bignum(void *blob, int noffset, const char *prop_name,
-		   BIGNUM *num, int num_bits)
+		   const BIGNUM *num, int num_bits)
 {
-	int nwords = num_bits / 32;
-	int size;
-	uint32_t *buf, *ptr;
-	BIGNUM *tmp, *big2, *big32, *big2_32;
-	BN_CTX *ctx;
+	int size = (num_bits + 7) / 8;
+	unsigned char *buf;
 	int ret;
 
-	tmp = BN_new();
-	big2 = BN_new();
-	big32 = BN_new();
-	big2_32 = BN_new();
+	if (size <= 0)
+		return -EINVAL;
 
-	/*
-	 * Note: This code assumes that all of the above succeed, or all fail.
-	 * In practice memory allocations generally do not fail (unless the
-	 * process is killed), so it does not seem worth handling each of these
-	 * as a separate case. Technicaly this could leak memory on failure,
-	 * but a) it won't happen in practice, and b) it doesn't matter as we
-	 * will immediately exit with a failure code.
-	 */
-	if (!tmp || !big2 || !big32 || !big2_32) {
-		fprintf(stderr, "Out of memory (bignum)\n");
-		return -ENOMEM;
-	}
-	ctx = BN_CTX_new();
-	if (!ctx) {
-		fprintf(stderr, "Out of memory (bignum context)\n");
-		return -ENOMEM;
-	}
-	BN_set_word(big2, 2L);
-	BN_set_word(big32, 32L);
-	BN_exp(big2_32, big2, big32, ctx); /* B = 2^32 */
-
-	size = nwords * sizeof(uint32_t);
 	buf = malloc(size);
 	if (!buf) {
 		fprintf(stderr, "Out of memory (%d bytes)\n", size);
 		return -ENOMEM;
 	}
 
-	/* Write out modulus as big endian array of integers */
-	for (ptr = buf + nwords - 1; ptr >= buf; ptr--) {
-		BN_mod(tmp, num, big2_32, ctx); /* n = N mod B */
-		*ptr = cpu_to_fdt32(BN_get_word(tmp));
-		BN_rshift(num, num, 32); /*  N = N/B */
+	if (BN_bn2binpad(num, buf, size) != size) {
+		free(buf);
+		return -EINVAL;
 	}
 
-	/*
-	 * We try signing with successively increasing size values, so this
-	 * might fail several times
-	 */
+	/* Callers may retry with a larger FDT if the property does not fit. */
 	ret = fdt_setprop(blob, noffset, prop_name, buf, size);
 	free(buf);
-	BN_free(tmp);
-	BN_free(big2);
-	BN_free(big32);
-	BN_free(big2_32);
 
 	return ret ? -FDT_ERR_NOSPACE : 0;
 }
diff --git a/tools/image-sig-host.c b/tools/image-sig-host.c
index 5285263c616..aeca83bd440 100644
--- a/tools/image-sig-host.c
+++ b/tools/image-sig-host.c
@@ -69,6 +69,13 @@ struct crypto_algo crypto_algos[] = {
 		.add_verify_data = rsa_add_verify_data,
 		.verify = rsa_verify,
 	},
+	{
+		.name = "ecdsa224",
+		.key_len = ECDSA224_BYTES,
+		.sign = ecdsa_sign,
+		.add_verify_data = ecdsa_add_verify_data,
+		.verify = ecdsa_verify,
+	},
 	{
 		.name = "ecdsa256",
 		.key_len = ECDSA256_BYTES,
-- 
2.53.0

