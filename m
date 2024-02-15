Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3D35C4829E
	for <u-boot@archiver.kernel.org>; Thu, 15 Feb 2024 17:18:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3429987E1D;
	Thu, 15 Feb 2024 18:17:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="KL27zIt/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7AEBC87DE1; Thu, 15 Feb 2024 17:58:27 +0100 (CET)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 70B0587DA7
 for <u-boot@lists.denx.de>; Thu, 15 Feb 2024 17:58:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=resch.max@gmail.com
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-411d715c401so8809025e9.1
 for <u-boot@lists.denx.de>; Thu, 15 Feb 2024 08:58:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1708016304; x=1708621104; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=aQKnPc3O/zIYUqZMlYbIT0kj9l39nBWEh+hiDiWwHFo=;
 b=KL27zIt/oKe2xPu8fbjKqCmgqThhliSduq5SWffk4C+WiJJvIcF4V562ei4hSqUm3u
 r3caEZcLm9wvzOPOj2gkSZqcxbeR23D/4izqz4LZ3dSWwgtrdZWWVzkP6cZfLowHppHG
 d3cdVOPTeA8RmzxV/VZCi+PeSPfScbk1Ofi42wuZTURj2Rio1ULXt1s4ODr6WVpbbkh5
 ZmoSfrQdiMSKCxZTxx2XBzHV5Mvj/hQoJbsMIe4Fys96pc/YsIkwCErDnoheVDwIoXum
 +ugno1M34/OICr12m8tnP+aH19Fe8YYR3MvRSK6v5Ic/0GHIqud+5ruUeU7/adQ5Fr+H
 SA5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708016304; x=1708621104;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=aQKnPc3O/zIYUqZMlYbIT0kj9l39nBWEh+hiDiWwHFo=;
 b=HE5jW/4dltyQIjWUffWm3iCHUl4BCHtWxpJezaCFLc857PlIeRNXSQZ/Wu5LfYc3Ed
 Kdhsv2t94QV5p6WZFMbvb1auMnpzZHP0+SdvHMb/FZ2QdMipGb57L91TkmisyLgbkE7D
 s9Ub/G/qbYs30NRb5qlMH8O0m6F/TWxOFn8e3PLy34Z82DinUMrhFB78bxZ7lPjiC+Xd
 NZ2d4QNHARW2g4tJkQwpAwT5A8zuTc564boO+eYNZKeUgejx2rALsyRqEpa6wa8xeuNs
 8j8U+LZL15i6j1993udEoWfa3pLn8VKUWtJVAgTKSep1XhBAHKH0SgMYgnNj1hCSn8zS
 SIdw==
X-Gm-Message-State: AOJu0YxHOv56ir+gx1yi6jProK2tNyCkYk76eiHrz0ws5ag0IGqqkS9l
 f8BIQmhNgKybDOYobm1zi3cQ9B1ez1k+YezBa5H31n3F1vYvYa2Nv29t8cYJ
X-Google-Smtp-Source: AGHT+IEnV6jbbzcj8CthOTwzI50Q676rOEmtUuzgD70FVZDrt2srrxAjkEycLt7hrpUpkY0wgxNCNQ==
X-Received: by 2002:a05:600c:1553:b0:412:c9d:6549 with SMTP id
 f19-20020a05600c155300b004120c9d6549mr1598142wmg.7.1708016303931; 
 Thu, 15 Feb 2024 08:58:23 -0800 (PST)
Received: from localhost.localdomain ([2001:871:223:9d90:4a25:3e0d:c47c:bed7])
 by smtp.gmail.com with ESMTPSA id
 p38-20020a05600c1da600b004105528c61fsm2656680wms.35.2024.02.15.08.58.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Feb 2024 08:58:23 -0800 (PST)
From: Max Resch <resch.max@gmail.com>
To: u-boot@lists.denx.de
Cc: sr@denx.de,
	Max Resch <resch.max@gmail.com>
Subject: [PATCH v5] rng: Add Turris Mox rTWM RNG driver
Date: Thu, 15 Feb 2024 17:57:57 +0100
Message-ID: <20240215165812.635479-1-resch.max@gmail.com>
X-Mailer: git-send-email 2.43.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 15 Feb 2024 18:17:55 +0100
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

Changes in v5:
 - check return code turris_rwtm_rng_fill_entropy
 - remove empty line

Changes in v4:
 - wrongful/missing git rebase

Changes in v3:
 - More meaningful variable names in accordance with review

Changes in v2:
 - Removed ring buffer implementation

 drivers/rng/Kconfig           |   8 +++
 drivers/rng/Makefile          |   1 +
 drivers/rng/turris_rwtm_rng.c | 123 ++++++++++++++++++++++++++++++++++
 3 files changed, 132 insertions(+)
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
index 0000000000..ca808c4579
--- /dev/null
+++ b/drivers/rng/turris_rwtm_rng.c
@@ -0,0 +1,123 @@
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
+		if (ret < 0)
+			return ret;
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
2.43.1

