Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B4D5C4829A
	for <u-boot@archiver.kernel.org>; Sun, 11 Feb 2024 13:37:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6F1EA87C45;
	Sun, 11 Feb 2024 14:37:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Gry8JmHn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E9F8287C45; Sun, 11 Feb 2024 14:04:43 +0100 (CET)
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com
 [IPv6:2a00:1450:4864:20::132])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0054A87C69
 for <u-boot@lists.denx.de>; Sun, 11 Feb 2024 14:04:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=resch.max@gmail.com
Received: by mail-lf1-x132.google.com with SMTP id
 2adb3069b0e04-51182f8590bso1050070e87.0
 for <u-boot@lists.denx.de>; Sun, 11 Feb 2024 05:04:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1707656680; x=1708261480; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Sbl+HbitvHN9cF/CUXTJoKq2jauf8ev1bETOfKaFJmg=;
 b=Gry8JmHnKu+4jDYyAMitOKpSpUxZkUlh9sGybYjog2LiIFuMIA0b1F7TO0VrmxYMRf
 1L75/2x7ZuIgZAS9ohaDltgEfdNLYnMhAz+bkbu5mIBTnDtlekiwKgN201m5td4ieHqR
 e8gUxrg8OBlU/MhwhaaSdp4C2XhOuNwRSjcSTBk7m60Hg2HjOLFbHC0zdsQpm8wIhz+c
 EcoFvegQDjNDyHX7tA4L8wRjSD00O/8uCPPUNoLQwZF08TItLq38j0OrXHYpSGfxlkac
 sXceHBjBiEcXhcoG0cMy2RgdyL1QXr/girN24Xu2Nop+qpSgav3K8owU0zw4WnnBoYB7
 zqGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707656680; x=1708261480;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Sbl+HbitvHN9cF/CUXTJoKq2jauf8ev1bETOfKaFJmg=;
 b=PM0huAcCXGFbUxLx6Tm9ZGNvwLyY7XIkrCY0kw7lEXrl1FL+zr8hqhhQRvCCXzmqae
 a3OXJHrF59/J3UvMo7/dGfIGvPEHMdRzA3T2J3/6IgE4ESu0ba8FaeXEJHz4NJXk+uWa
 i7SI2fNtB78p4gV/Coszr35pEClMgSGD+Bwnsarfx0pncnyZAk/tNS1TBmI64RUmsgY9
 AChux0BVsKkTjsJvRMsa5Bd7GAQUZVfqF9Zlmx5lXMVdWhum5L4jZKEuI38Dseh17vV4
 M+XHPmIzuHRF0JkcD9i8Bx3o1PEaFn1JTpZrqbBD2GR58gas7k0ppXFCP5RfMYbvlQEN
 t0og==
X-Gm-Message-State: AOJu0YwKMIRb37Fdkw6uMLNRynrXIm0776mVV8hMQ/bZl8dZSmG5m3AK
 rlvbClH5+2SU8x53w2+DR8RSekB2Ahldr/hadvO1BcBnBqObEbFKHRD9UNHY
X-Google-Smtp-Source: AGHT+IHzPAT/If5QxihCAbV+uRfNVBBOwIDacbwVyn9zbav7SwlI6u3Cxj1cGbBolG67jjLm44jZVQ==
X-Received: by 2002:a05:6512:3d11:b0:511:51ec:8684 with SMTP id
 d17-20020a0565123d1100b0051151ec8684mr3084970lfv.50.1707656680158; 
 Sun, 11 Feb 2024 05:04:40 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCWZ2XFEtBlvoA4P6BsHYg+aL+BGMxtPkpJSJ+zbpMSpw/kvqwNb9uBgV9N9EaKRB28rAC+mYEjH0buontFR5w2B01Bu
Received: from niflheim.lan ([2001:871:223:9d90:4a25:3e0d:c47c:bed7])
 by smtp.gmail.com with ESMTPSA id
 p7-20020a05600c468700b004105528c61fsm5825771wmo.35.2024.02.11.05.04.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 11 Feb 2024 05:04:39 -0800 (PST)
From: Max Resch <resch.max@gmail.com>
To: u-boot@lists.denx.de
Cc: sr@denx.de,
	Max Resch <resch.max@gmail.com>
Subject: [PATCH v4] rng: Add Turris Mox rTWM RNG driver
Date: Sun, 11 Feb 2024 14:04:13 +0100
Message-ID: <20240211130436.698777-1-resch.max@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sun, 11 Feb 2024 14:37:52 +0100
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

Changes in v4:
 - wrongful/missing git rebase

Changes in v3:
 - More meaningful variable names in accordance with review

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
index 0000000000..ec2cb0bca3
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
+	struct turris_rwtm_rng_priv *priv = dev_get_priv(dev);
+	phys_addr_t phys;
+	size_t size;
+	int ret;
+
+	phys = priv->buffer;
+
+	while (count) {
+		size = min_t(size_t, RNG_BUFFER_SIZE, count);
+
+		ret = turris_rwtm_rng_fill_entropy(phys, size);
+
+		memcpy(data, (void *)phys, size);
+		count -= size;
+		data = (u8 *)data + size;
+	}
+
+	return 0;
+}
+
+static int turris_rwtm_rng_probe(struct udevice *dev)
+{
+	struct turris_rwtm_rng_priv *priv = dev_get_priv(dev);
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
+	struct turris_rwtm_rng_priv *priv = dev_get_priv(dev);
+	phys_addr_t phys = priv->buffer;
+
+	dma_free_coherent((void *)phys);
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

