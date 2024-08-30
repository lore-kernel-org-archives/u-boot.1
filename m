Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BE4DCA0EE6
	for <u-boot@archiver.kernel.org>; Fri, 30 Aug 2024 07:23:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8307C88D5A;
	Fri, 30 Aug 2024 09:23:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1978B88D23; Fri, 30 Aug 2024 09:23:40 +0200 (CEST)
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0254888D5A
 for <u-boot@lists.denx.de>; Fri, 30 Aug 2024 09:23:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none)
 header.from=aspeedtech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=chiawei_wang@aspeedtech.com
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Fri, 30 Aug
 2024 15:23:34 +0800
Received: from mail.aspeedtech.com (192.168.10.152) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1258.12 via Frontend
 Transport; Fri, 30 Aug 2024 15:23:34 +0800
From: Chia-Wei Wang <chiawei_wang@aspeedtech.com>
To: <trini@konsulko.com>, <u-boot@lists.denx.de>
Subject: [PATCH] drivers/crypto: aspeed: Add Caliptra SHA ACC support
Date: Fri, 30 Aug 2024 15:23:34 +0800
Message-ID: <20240830072334.2916897-1-chiawei_wang@aspeedtech.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
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

Aspeed AST27xx SoCs integrate the CPTRA 1.0 secure IP, which
export a SHA accelerator interface for SoC to use.

Note that CPTRA 1.0 supports only SHA384 and SHA512 and this
patch is verified by the 'hash test sha384/sha512' commands.

Signed-off-by: Chia-Wei Wang <chiawei_wang@aspeedtech.com>
---
 drivers/crypto/aspeed/Kconfig     |  10 ++
 drivers/crypto/aspeed/Makefile    |   1 +
 drivers/crypto/aspeed/cptra_sha.c | 258 ++++++++++++++++++++++++++++++
 3 files changed, 269 insertions(+)
 create mode 100644 drivers/crypto/aspeed/cptra_sha.c

diff --git a/drivers/crypto/aspeed/Kconfig b/drivers/crypto/aspeed/Kconfig
index 9bf317177aa..473e3e5a863 100644
--- a/drivers/crypto/aspeed/Kconfig
+++ b/drivers/crypto/aspeed/Kconfig
@@ -18,3 +18,13 @@ config ASPEED_ACRY
 
 	 Enabling this allows the use of RSA/ECC operations in hardware without requiring the
 	 software implementations. It also improves performance and saves code size.
+
+config ASPEED_CPTRA_SHA
+	bool "Caliptra SHA ACC for Aspeed AST27xx SoCs"
+	depends on DM_HASH
+	help
+	  Select this option to enable a driver for using the SHA accelerator provided
+	  by Caliptra 1.0, which is integrated in AST27xx BMC SoCs.
+
+	  Enabling this allows the use of SHA operations in hardware. Note that only
+	  SHA384 and SHA512 are supported by Caliptra 1.0.
diff --git a/drivers/crypto/aspeed/Makefile b/drivers/crypto/aspeed/Makefile
index 58b55fc46e4..570587e744f 100644
--- a/drivers/crypto/aspeed/Makefile
+++ b/drivers/crypto/aspeed/Makefile
@@ -1,2 +1,3 @@
 obj-$(CONFIG_ASPEED_HACE) += aspeed_hace.o
 obj-$(CONFIG_ASPEED_ACRY) += aspeed_acry.o
+obj-$(CONFIG_ASPEED_CPTRA_SHA) += cptra_sha.o
diff --git a/drivers/crypto/aspeed/cptra_sha.c b/drivers/crypto/aspeed/cptra_sha.c
new file mode 100644
index 00000000000..26b97bdd92b
--- /dev/null
+++ b/drivers/crypto/aspeed/cptra_sha.c
@@ -0,0 +1,258 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright 2024 ASPEED Technology Inc.
+ */
+#include <asm/io.h>
+#include <config.h>
+#include <dm.h>
+#include <linux/bitfield.h>
+#include <linux/bitops.h>
+#include <linux/iopoll.h>
+#include <malloc.h>
+#include <u-boot/hash.h>
+#include <watchdog.h>
+
+/* SHA register offsets */
+#define CPTRA_SHA_LOCK			0x00
+#define CPTRA_SHA_USER			0x04
+#define CPTRA_SHA_MODE			0x08
+#define   CPTRA_SHA_MODE_ENDIAN		BIT(2)
+#define   CPTRA_SHA_MODE_SEL		GENMASK(1, 0)
+#define CPTRA_SHA_DLEN			0x10
+#define CPTRA_SHA_DATAIN		0x14
+#define CPTRA_SHA_EXEC			0x18
+#define CPTRA_SHA_STS			0x1c
+#define   CPTRA_SHA_STS_SOC_LOCK	BIT(1)
+#define   CPTRA_SHA_STS_VLD		BIT(0)
+#define CPTRA_SHA_DIGEST(n)		(0x20 + ((n) << 2))
+#define CPTRA_SHA_CTRL			0x60
+#define   CPTRA_SHA_CTRL_ZEROIZE	BIT(0)
+
+enum cptra_sha_modes {
+	CPTRA_SHA384_STREAM,
+	CPTRA_SHA512_STREAM,
+};
+
+struct cptra_sha_ctx {
+	enum HASH_ALGO algo;
+	uint32_t dgst_len;
+};
+
+struct cptra_sha {
+	void *regs;
+};
+
+static int cptra_sha_init(struct udevice *dev, enum HASH_ALGO algo, void **ctxp)
+{
+	struct cptra_sha_ctx *cs_ctx;
+	struct cptra_sha *cs;
+	uint32_t mode;
+	uint32_t reg;
+	int rc;
+
+	cs_ctx = malloc(sizeof(struct cptra_sha_ctx));
+	if (!cs_ctx)
+		return -ENOMEM;
+
+	memset(cs_ctx, 0, sizeof(struct cptra_sha_ctx));
+
+	cs_ctx->algo = algo;
+
+	switch (algo) {
+	case HASH_ALGO_SHA384:
+		mode = CPTRA_SHA384_STREAM;
+		cs_ctx->dgst_len = 48;
+		break;
+	case HASH_ALGO_SHA512:
+		mode = CPTRA_SHA512_STREAM;
+		cs_ctx->dgst_len = 64;
+		break;
+	default:
+		rc = -EINVAL;
+		goto free_n_out;
+	};
+
+	cs = dev_get_priv(dev);
+
+	/* get CPTRA SHA lock */
+	if (readl_poll_timeout(cs->regs + CPTRA_SHA_LOCK, reg, reg == 0, 1000000))
+		return -EBUSY;
+
+	/* zero clear SHA */
+	writel(CPTRA_SHA_CTRL_ZEROIZE, cs->regs + CPTRA_SHA_CTRL);
+
+	/* zero clear length */
+	writel(0x0, cs->regs + CPTRA_SHA_DLEN);
+
+	/* set SHA mode */
+	reg = readl(cs->regs + CPTRA_SHA_MODE);
+	reg &= ~(CPTRA_SHA_MODE_SEL);
+	reg |= FIELD_PREP(CPTRA_SHA_MODE_SEL, mode);
+	writel(reg, cs->regs + CPTRA_SHA_MODE);
+
+	*ctxp = cs_ctx;
+
+	return 0;
+
+free_n_out:
+	free(cs_ctx);
+
+	return rc;
+}
+
+static int cptra_sha_update(struct udevice *dev, void *ctx, const void *ibuf, uint32_t ilen)
+{
+	struct cptra_sha *cs;
+	uint32_t din_be;
+	uint32_t dlen_sum;
+	uint8_t *p8;
+	uint32_t i;
+
+	cs = dev_get_priv(dev);
+
+	/* update length */
+	dlen_sum = readl(cs->regs + CPTRA_SHA_DLEN) + ilen;
+	writel(dlen_sum, cs->regs + CPTRA_SHA_DLEN);
+
+	din_be = 0;
+	for (i = 0, p8 = (uint8_t *)ibuf; i < ilen; ++i) {
+		if (i && (i % sizeof(din_be) == 0)) {
+			writel(din_be, cs->regs + CPTRA_SHA_DATAIN);
+			din_be = 0;
+		}
+
+		din_be <<= 8;
+		din_be |= p8[i];
+	}
+
+	if (i % sizeof(din_be))
+		din_be <<= (8 * (sizeof(din_be) - (i % sizeof(din_be))));
+
+	writel(din_be, cs->regs + CPTRA_SHA_DATAIN);
+
+	return 0;
+}
+
+static int cptra_sha_finish(struct udevice *dev, void *ctx, void *obuf)
+{
+	struct cptra_sha_ctx *cs_ctx;
+	struct cptra_sha *cs;
+	uint32_t i, *p32;
+	uint32_t sts;
+
+	cs = dev_get_priv(dev);
+	cs_ctx = (struct cptra_sha_ctx *)ctx;
+
+	/* trigger SHA calculation */
+	writel(0x1, cs->regs + CPTRA_SHA_EXEC);
+
+	/* wait for completion */
+	while (1) {
+		sts = readl(cs->regs + CPTRA_SHA_STS);
+		if (sts & CPTRA_SHA_STS_VLD)
+			break;
+	}
+
+	/* get the SHA digest in big-endian */
+	p32 = (uint32_t *)obuf;
+	for (i = 0; i < (cs_ctx->dgst_len / sizeof(*p32)); ++i, p32++)
+		*p32 = be32_to_cpu(readl(cs->regs + CPTRA_SHA_DIGEST(i)));
+
+	/* release CPTRA SHA lock */
+	writel(0x1, cs->regs + CPTRA_SHA_LOCK);
+
+	free(cs_ctx);
+
+	return 0;
+}
+
+static int cptra_sha_digest_wd(struct udevice *dev, enum HASH_ALGO algo,
+			       const void *ibuf, const uint32_t ilen,
+			       void *obuf, uint32_t chunk_sz)
+{
+	const void *cur, *end;
+	uint32_t chunk;
+	void *ctx;
+	int rc;
+
+	rc = cptra_sha_init(dev, algo, &ctx);
+	if (rc)
+		return rc;
+
+	if (IS_ENABLED(CONFIG_HW_WATCHDOG) || CONFIG_IS_ENABLED(WATCHDOG)) {
+		cur = ibuf;
+		end = ibuf + ilen;
+
+		while (cur < end) {
+			chunk = end - cur;
+			if (chunk > chunk_sz)
+				chunk = chunk_sz;
+
+			rc = cptra_sha_update(dev, ctx, cur, chunk);
+			if (rc)
+				return rc;
+
+			cur += chunk;
+			schedule();
+		}
+	} else {
+		rc = cptra_sha_update(dev, ctx, ibuf, ilen);
+		if (rc)
+			return rc;
+	}
+
+	rc = cptra_sha_finish(dev, ctx, obuf);
+	if (rc)
+		return rc;
+
+	return 0;
+}
+
+static int cptra_sha_digest(struct udevice *dev, enum HASH_ALGO algo,
+			    const void *ibuf, const uint32_t ilen, void *obuf)
+{
+	/* re-use the watchdog version with input length as the chunk_sz */
+	return cptra_sha_digest_wd(dev, algo, ibuf, ilen, obuf, ilen);
+}
+
+static int cptra_sha_probe(struct udevice *dev)
+{
+	struct cptra_sha *cs = dev_get_priv(dev);
+
+	cs->regs = (void *)devfdt_get_addr(dev);
+	if (cs->regs == (void *)FDT_ADDR_T_NONE) {
+		debug("cannot map Caliptra SHA ACC registers\n");
+		return -ENODEV;
+	}
+
+	return 0;
+}
+
+static int cptra_sha_remove(struct udevice *dev)
+{
+	return 0;
+}
+
+static const struct hash_ops cptra_sha_ops = {
+	.hash_init = cptra_sha_init,
+	.hash_update = cptra_sha_update,
+	.hash_finish = cptra_sha_finish,
+	.hash_digest_wd = cptra_sha_digest_wd,
+	.hash_digest = cptra_sha_digest,
+};
+
+static const struct udevice_id cptra_sha_ids[] = {
+	{ .compatible = "aspeed,ast2700-cptra-sha" },
+	{ }
+};
+
+U_BOOT_DRIVER(aspeed_cptra_sha) = {
+	.name = "aspeed_cptra_sha",
+	.id = UCLASS_HASH,
+	.of_match = cptra_sha_ids,
+	.ops = &cptra_sha_ops,
+	.probe = cptra_sha_probe,
+	.remove	= cptra_sha_remove,
+	.priv_auto = sizeof(struct cptra_sha),
+	.flags = DM_FLAG_PRE_RELOC,
+};
-- 
2.25.1

