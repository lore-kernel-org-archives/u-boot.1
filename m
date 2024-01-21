Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0428C47422
	for <u-boot@archiver.kernel.org>; Sun, 21 Jan 2024 20:59:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2DDF887708;
	Sun, 21 Jan 2024 21:59:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="hjvhd1ic";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B7A9B877EC; Sun, 21 Jan 2024 21:18:02 +0100 (CET)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C427087796
 for <u-boot@lists.denx.de>; Sun, 21 Jan 2024 21:18:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=resch.max@gmail.com
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-40e76626170so29572325e9.2
 for <u-boot@lists.denx.de>; Sun, 21 Jan 2024 12:18:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1705868279; x=1706473079; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=avySH4vdJjuTYDcCEnORZM+d69G/g6r9bNaFUoTfxyw=;
 b=hjvhd1ic7EZVEdGhJAHOikjmK0s5u36V7I9PMqxEELFZx/Wm72oWLF1rOqp59NUz35
 YtttSFWzvi63z+Nxf8DEER2IkGLxrMXv02donGKRJhhtm2/D4Jp4CLZ4Tdk7XfmDqiyz
 PwsEtjr9S0UAamxxY1K7GBoPP+L50Btf59S2EoUXDVgoYUXDMiiOekyn6xDihMlZHv/A
 5MxS+cXpfRVl0dks9ymNhNCukHSlrwIPgjPW2Y0aH1tcrJrOOf9W8aVVTgSrCTfDtysG
 NAWgZ+HQLbE/3BXHHTbbr8FQHyPZu7uIpPOdZuU1uEa5kI4To4qiQI63YwpiWP1CSt6g
 ogpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705868279; x=1706473079;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=avySH4vdJjuTYDcCEnORZM+d69G/g6r9bNaFUoTfxyw=;
 b=gV5D0Kf16UcJaMnPSfHUC2dALpRgXbLsrhFYIBwdJ6/F9WYDxNJere2j2fN33BAz2k
 OG33W5b8Sal5EH/NmK96qpNmtUsyFvpzmkFnyUqw9Q9fwZFlp19ea8j9O8OmK4QKZpXu
 xnU632tXIFkzvJPGm5I/dq6dvDZ++OdQM6ow1RPlrEzZgYfpVjbYzVYmcTSLIc6vZ0T/
 A8iTuDYWYBE9Nk5XzD5lbQKbM4v4kHWodfbtlxSqiwyo83vZr+dxTO8FCsCDVYvGza7q
 dq7QofoSHsTJhAFCZzn3wm8yDztv6zhxvvqtEaivzcml38iyt1nuBhmgN4q0WCeGS/zw
 gkxA==
X-Gm-Message-State: AOJu0Yxc9I4GZDO5Krpa4LszMuV4IADX0ZeRl3pjhZ563dGt2rk1wt3L
 JqQL1vdM1mpP/saUDOUKr2qN4HVthayDzTvu0zJOvgyiUXJsYrvZ/xCVekSg
X-Google-Smtp-Source: AGHT+IFw1/Fe7J1t5uMQaovYzoprUzZNGMjI5raMIiO40Eyy8CqBAHzpCcIDzNiulQrPemEbZoWGYQ==
X-Received: by 2002:a05:600c:1ca9:b0:40e:62d8:3326 with SMTP id
 k41-20020a05600c1ca900b0040e62d83326mr1682110wms.16.1705868279127; 
 Sun, 21 Jan 2024 12:17:59 -0800 (PST)
Received: from niflheim.lan ([2001:871:223:517:1bcd:a630:f42f:3edc])
 by smtp.gmail.com with ESMTPSA id
 m10-20020adffa0a000000b003392172fd60sm6870676wrr.51.2024.01.21.12.17.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 21 Jan 2024 12:17:58 -0800 (PST)
From: Max Resch <resch.max@gmail.com>
To: u-boot@lists.denx.de
Cc: sr@denx.de,
	Max Resch <resch.max@gmail.com>
Subject: [PATCH v2] rng: Add Turris Mox rWTM RNG driver
Date: Sun, 21 Jan 2024 21:17:16 +0100
Message-ID: <20240121201737.671340-1-resch.max@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sun, 21 Jan 2024 21:59:12 +0100
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

A RNG driver for Armada 3720 boards running the Turris Mox rWTM firmware
from CZ.NIC in the secure processor.

Signed-off-by: Max Resch <resch.max@gmail.com>
---

Changes in v2:
 - Removed ring buffer implementation

 drivers/rng/Kconfig           |   8 +++
 drivers/rng/Makefile          |   1 +
 drivers/rng/turris_rwtm_rng.c | 122 ++++++++++++++++++++++++++++++++++
 3 files changed, 131 insertions(+)
 create mode 100644 drivers/rng/turris_rwtm_rng.c

diff --git a/drivers/rng/Kconfig b/drivers/rng/Kconfig
index a89c899568..cd72852a47 100644
--- a/drivers/rng/Kconfig
+++ b/drivers/rng/Kconfig
@@ -105,4 +105,12 @@ config RNG_JH7110
 	help
 	  Enable True Random Number Generator in StarFive JH7110 SoCs.
 
+config RNG_TURRIS_RWTM
+	bool "Turris Mox TRNG in Secure Processor"
+	depends on DM_RNG && ARMADA_3700
+	help
+	  Use TRNG in Turris Mox Secure Processor Firmware. Can be used
+	  on other Armada-3700 devices (like EspressoBin) if Secure
+	  Firmware from CZ.NIC is used.
+
 endif
diff --git a/drivers/rng/Makefile b/drivers/rng/Makefile
index 7e64c4cdfc..ecae1a3da3 100644
--- a/drivers/rng/Makefile
+++ b/drivers/rng/Makefile
@@ -17,3 +17,4 @@ obj-$(CONFIG_RNG_SMCCC_TRNG) += smccc_trng.o
 obj-$(CONFIG_RNG_ARM_RNDR) += arm_rndr.o
 obj-$(CONFIG_TPM_RNG) += tpm_rng.o
 obj-$(CONFIG_RNG_JH7110) += jh7110_rng.o
+obj-$(CONFIG_RNG_TURRIS_RWTM) += turris_rwtm_rng.o
diff --git a/drivers/rng/turris_rwtm_rng.c b/drivers/rng/turris_rwtm_rng.c
new file mode 100644
index 0000000000..143fe0b47f
--- /dev/null
+++ b/drivers/rng/turris_rwtm_rng.c
@@ -0,0 +1,122 @@
+// SPDX-License-Identifier: GPL-2.0-or-later OR BSD-3-Clause
+/*
+ * Copyright (c) 2024, Max Resch
+ */
+
+#include <dm.h>
+#include <malloc.h>
+#include <rng.h>
+#include <asm/dma-mapping.h>
+#include <asm/types.h>
+#include <mach/mbox.h>
+
+/* size of entropy buffer */
+#define RNG_BUFFER_SIZE	128U
+
+struct turris_rwtm_rng_priv {
+	phys_addr_t buffer;
+};
+
+static int turris_rwtm_rng_fill_entropy(phys_addr_t entropy, size_t size)
+{
+	u32 args[3] = { 1, (u32)entropy, size };
+	int ret;
+
+	/* flush data cache */
+	flush_dcache_range(entropy, entropy + size);
+
+	/*
+	 * get entropy
+	 * args[0] = 1 copies BYTES array in args[1] of length args[2]
+	 */
+	ret = mbox_do_cmd(MBOX_CMD_GET_RANDOM, args, 3, NULL, 0);
+	if (ret < 0)
+		return ret;
+
+	/* invalidate data cache */
+	invalidate_dcache_range(entropy, entropy + size);
+
+	return 0;
+}
+
+static int turris_rwtm_rng_random_read(struct udevice *dev, void *data, size_t count)
+{
+	phys_addr_t p;
+	size_t size;
+	int ret;
+
+	p = ((struct turris_rwtm_rng_priv *)dev_get_priv(dev))->buffer;
+
+	while (count) {
+		size = min_t(size_t, RNG_BUFFER_SIZE, count);
+
+		ret = turris_rwtm_rng_fill_entropy(p, size);
+
+		memcpy(data, (void *)p, size);
+		count -= size;
+		data = (u8 *)data + size;
+	}
+
+	return 0;
+}
+
+static int turris_rwtm_rng_probe(struct udevice *dev)
+{
+	struct turris_rwtm_rng_priv *priv;
+	u32 args[] = { 0 };
+	int ret;
+
+	/*
+	 * check if the random command is supported
+	 * args[0] = 0 would copy 16 DWORDS entropy to out but we ignore them
+	 */
+	ret = mbox_do_cmd(MBOX_CMD_GET_RANDOM, args, ARRAY_SIZE(args), NULL, 0);
+
+	if (ret < 0)
+		return ret;
+
+	/* entropy buffer */
+	priv = (struct turris_rwtm_rng_priv *)dev_get_priv(dev);
+	priv->buffer = 0;
+
+	/* buffer address need to be aligned */
+	dma_alloc_coherent(RNG_BUFFER_SIZE, (unsigned long *)&priv->buffer);
+	if (!priv->buffer)
+		return -ENOMEM;
+
+	return 0;
+}
+
+static int turris_rwtm_rng_remove(struct udevice *dev)
+{
+	phys_addr_t p;
+
+	p = ((struct turris_rwtm_rng_priv *)dev_get_priv(dev))->buffer;
+	dma_free_coherent((void *)p);
+
+	return 0;
+}
+
+static const struct dm_rng_ops turris_rwtm_rng_ops = {
+	.read = turris_rwtm_rng_random_read,
+};
+
+/*
+ * only Turris MOX firmware has the RNG but allow all probable devices to be
+ * probed the default firmware will just reject the probe
+ */
+static const struct udevice_id turris_rwtm_rng_match[] = {
+	{ .compatible = "cznic,turris-mox-rwtm" },
+	{ .compatible = "marvell,armada-3700-rwtm-firmware" },
+	{},
+};
+
+U_BOOT_DRIVER(turris_rwtm_rng) = {
+	.name	= "turris-rwtm-rng",
+	.id	= UCLASS_RNG,
+	.of_match = turris_rwtm_rng_match,
+	.ops	= &turris_rwtm_rng_ops,
+	.probe	= turris_rwtm_rng_probe,
+	.remove = turris_rwtm_rng_remove,
+	.priv_auto = sizeof(struct turris_rwtm_rng_priv),
+};
-- 
2.43.0

