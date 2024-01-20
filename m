Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A51F1C47DB7
	for <u-boot@archiver.kernel.org>; Sat, 20 Jan 2024 13:38:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D6BEC87D52;
	Sat, 20 Jan 2024 14:38:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="imqoLbKt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 29B9B87D2F; Sat, 20 Jan 2024 14:27:46 +0100 (CET)
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com
 [IPv6:2a00:1450:4864:20::42d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A64B687D4B
 for <u-boot@lists.denx.de>; Sat, 20 Jan 2024 14:27:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=resch.max@gmail.com
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-337b38d6568so1620184f8f.1
 for <u-boot@lists.denx.de>; Sat, 20 Jan 2024 05:27:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1705757262; x=1706362062; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0vInWxwDUZWtJ4BICRXUhpJUmtyuxKtqh5P8se8ejZM=;
 b=imqoLbKtaFj46lTQ/7xQVOtNbu1/xatWcieauWqyxmIK40mmp8VDi9NWwG2hXzlMnm
 1uP6+cUl5EzaxOctFf7uHXY2ic6eBnbUPWHUuEtPi60WPBDPwbgFctoH6rHgFqU/hyG0
 wmic14W8fBjw9Iy2Laaq+2XY0z4keghNT/Db7PGsND3qbVTjAfQuFUoeuo9xfTsWj+2O
 a8y1kN1VJYm9XgtZls+M67WPeJDwa9/Wq5fXzGRAdoSuhUSaiisJuaydkbh1suelIIdP
 O2cphfeK+IQ90+M1hXTxjhPbrD70zUtd3JkdBDeyiXe1z4byY5CbWoyy74MN0mYipBi1
 nkUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705757262; x=1706362062;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0vInWxwDUZWtJ4BICRXUhpJUmtyuxKtqh5P8se8ejZM=;
 b=bqrPMcbk9pQVOTxRrbYf0S94cmwzMSvogazDRPOh0gfvVLBqVjZchcN/z9Grabi0Be
 AQHY+2iMVQg+kNaBBuPseXeKU0jeITfaSNGCMr3R9Dd7HMRJjs6A5FnRLPOGamwwZ6FX
 g73D1r9wFlveW9+BkY9Cm9yBhhCs0dchud65+ZHdWnvrmYZ3+8SPm6V8syrVsbmsP1fE
 P/NPzPuW/C2J3/vXfzl+Pfs4eKAWo6kkWWPLIx/PXfQyW2O3PV/fqoo5jFYhJtnCNgwH
 9jhYpMIQgouOFDdoMV0eFQdDpiy5EZejaP8DkRRzx2J9PK1PsvJtaTC7G7vAeheFReXU
 VDww==
X-Gm-Message-State: AOJu0YxnL+px4GU6uHEUkaJENfWQ4MjMK4HqJoA99/u29m/xAbB4pfKU
 2UJ2r3EX0/nrWjGrR2xryI3q7dDKERpGa53ycN+oUzgoPepOfN9mu8g/Hmhm
X-Google-Smtp-Source: AGHT+IG6tLX558pQU32v4xbHhfAekTtbR4+Ua2Vg+1idHo/wIu/FSR+oEXQLB3sb1VdKfzqELFfh1g==
X-Received: by 2002:a05:600c:501e:b0:40e:3941:8314 with SMTP id
 n30-20020a05600c501e00b0040e39418314mr744651wmr.112.1705757262036; 
 Sat, 20 Jan 2024 05:27:42 -0800 (PST)
Received: from niflheim.lan ([2001:871:223:517:1bcd:a630:f42f:3edc])
 by smtp.gmail.com with ESMTPSA id
 fl19-20020a05600c0b9300b0040ea8d346e4sm300331wmb.37.2024.01.20.05.27.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 20 Jan 2024 05:27:41 -0800 (PST)
From: Max Resch <resch.max@gmail.com>
To: u-boot@lists.denx.de
Cc: sr@denx.de,
	Max Resch <resch.max@gmail.com>
Subject: [PATCH 1/1] add turris-rwtm-rng from CZ.NIC rWTM Firmware
Date: Sat, 20 Jan 2024 14:27:23 +0100
Message-ID: <20240120132731.35321-2-resch.max@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240120132731.35321-1-resch.max@gmail.com>
References: <20240120132731.35321-1-resch.max@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 20 Jan 2024 14:38:26 +0100
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

usable on all armada3700 devices with CZ.NIC firmware
compatible with devices with default firmware (does nothing)
based on Linux turris-mox-rwtm module

Signed-off-by: Max Resch <resch.max@gmail.com>
---

 drivers/rng/Kconfig           |   8 ++
 drivers/rng/Makefile          |   1 +
 drivers/rng/turris_rwtm_rng.c | 143 ++++++++++++++++++++++++++++++++++
 3 files changed, 152 insertions(+)
 create mode 100644 drivers/rng/turris_rwtm_rng.c

diff --git a/drivers/rng/Kconfig b/drivers/rng/Kconfig
index a89c899568..f5984a9ca0 100644
--- a/drivers/rng/Kconfig
+++ b/drivers/rng/Kconfig
@@ -105,4 +105,12 @@ config RNG_JH7110
 	help
 	  Enable True Random Number Generator in StarFive JH7110 SoCs.
 
+config RNG_TURRIS_RWTM
+	bool "Turris Mox TRNG in Secure Processor"
+	depends on DM_RNG && ARCH_MVEBU
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
index 0000000000..03e4fdfcaf
--- /dev/null
+++ b/drivers/rng/turris_rwtm_rng.c
@@ -0,0 +1,143 @@
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
+#define DRIVER_NAME	"turris-rwtm-rng"
+
+/* size of enthropy ring buffer */
+#define RNG_BUFFER_SIZE	4096U
+
+struct turris_rwtm_rng_priv {
+	phys_addr_t buffer;
+	u16 pos;
+};
+
+static int turris_rwtm_rng_fill_enthropy(phys_addr_t enthropy, size_t size)
+{
+	int ret;
+	u32 args[] = { 1, (u32)enthropy, size };
+
+	/* flush data cache */
+	flush_dcache_range(enthropy, enthropy + size);
+
+	/*
+	 * get enthropy
+	 * args[0] = 1 copies BYTES array in args[1] of length args[2]
+	 */
+	ret = mbox_do_cmd(MBOX_CMD_GET_RANDOM, args, 3, NULL, 0);
+	if (ret < 0)
+		return ret;
+
+	/* invalidate data cache */
+	invalidate_dcache_range(enthropy, enthropy + size);
+
+	return 0;
+}
+
+static int turris_rwtm_rng_random_read(struct udevice *dev, void *data, size_t count)
+{
+	int ret;
+	struct turris_rwtm_rng_priv *priv;
+	phys_addr_t p;
+	size_t size, copied;
+
+	priv = (struct turris_rwtm_rng_priv *)dev_get_priv(dev);
+	p = priv->buffer;
+
+	/* copy to ring buffer, optimize RWTM access */
+	size = min_t(size_t, RNG_BUFFER_SIZE - priv->pos, count);
+	copied = 0;
+
+	while (count) {
+		memcpy(((u8 *)data) + copied, (void *)(p + priv->pos), size);
+		count -= size;
+		copied += size;
+		priv->pos += size;
+
+		if (priv->pos == RNG_BUFFER_SIZE) {
+			ret = turris_rwtm_rng_fill_enthropy(p, RNG_BUFFER_SIZE);
+			if (ret < 0)
+				return ret;
+			priv->pos = 0;
+		}
+	}
+
+	return 0;
+}
+
+static int turris_rwtm_rng_probe(struct udevice *dev)
+{
+	int ret;
+	struct turris_rwtm_rng_priv *priv;
+	u32 args[] = { 0 };
+
+	/*
+	 * check if the random command is supported
+	 * args[0] = 0 would copy 16 DWORDS to out but we ignore them
+	 */
+	ret = mbox_do_cmd(MBOX_CMD_GET_RANDOM, args, 1, NULL, 0);
+
+	if (ret < 0)
+		return ret;
+
+	/* allocate ring buffer */
+	priv = dev_get_priv(dev);
+	priv->buffer = 0;
+
+	/* address need to be aligned */
+	dma_alloc_coherent(RNG_BUFFER_SIZE, (unsigned long *)&priv->buffer);
+	if (!priv->buffer)
+		return -ENOMEM;
+
+	priv->pos = 0;
+	memset((void *)priv->buffer, 0, RNG_BUFFER_SIZE);
+
+	/* fill ring buffer with enthroy */
+	return turris_rwtm_rng_fill_enthropy(priv->buffer, RNG_BUFFER_SIZE);
+}
+
+static int turris_rwtm_rng_remove(struct udevice *dev)
+{
+	struct turris_rwtm_rng_priv *priv;
+
+	priv = dev_get_priv(dev);
+	if (!priv->buffer)
+		return 0;
+
+	dma_free_coherent((void *)priv->buffer);
+	priv->buffer = 0;
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
+	.name	= DRIVER_NAME,
+	.id	= UCLASS_RNG,
+	.of_match = turris_rwtm_rng_match,
+	.ops	= &turris_rwtm_rng_ops,
+	.probe	= turris_rwtm_rng_probe,
+	.remove = turris_rwtm_rng_remove,
+	.priv_auto = sizeof(struct turris_rwtm_rng_priv),
+};
-- 
2.43.0

