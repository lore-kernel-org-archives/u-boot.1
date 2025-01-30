Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90B81C0218D
	for <u-boot@archiver.kernel.org>; Thu, 30 Jan 2025 01:37:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F0FBF80AE4;
	Thu, 30 Jan 2025 02:37:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1738201071;
	bh=WtqqqXu5Oy0sdiga7qxum7h85FXIvXZk5jTE8bEMdDM=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=cnIT6PmE8QKqhNCyngmVArAn6U9mGfOSwN9PG+bbPkWIf5UO2RPN0ID+BLpOG194f
	 9daVM3LjnstuJvxajMEeHAPiLPUxcPzx/tq/DV+4Q3Z573yozWMkVhnuEyBNZwATVL
	 pjSgbV9iJsZdH49rMMZTOW63qLfW0ek2fIQYnqXYez090zL3NatG6PLbE8hqYvUY4s
	 yVpOzCg9EYAj3chh1JBQSC3fg+IR+MlQsenirYbHD+vvNsZJjBjKIg5okfUsXBRIKE
	 4QOn6W86miF4zXJJT9DJ+XrRxaH/CJMapsBr49BLzR7/ry7RTrgf5SroW6k3xIErnq
	 WF/xLYyY026Fg==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 318D1809D0; Thu, 30 Jan 2025 02:37:50 +0100 (CET)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 16DEE80B9B
 for <u-boot@lists.denx.de>; Thu, 30 Jan 2025 02:37:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=marex@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="JDMJTxbO"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 060E610382D08; Thu, 30 Jan 2025 02:37:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1738201066;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=WtqqqXu5Oy0sdiga7qxum7h85FXIvXZk5jTE8bEMdDM=;
 b=JDMJTxbOAcvvCxwoSo2UXT9lSSHppWTmQXjxTZ3xOABgHbcMoJOodKmjT0hZBYhZPNyScu
 Ptv/WZY8AoeGY7W752pFae8aRpTKgTVrGBb8FBvIy5SluowJAFzWtO2lrvnnOzm6DrxSWk
 PzDeBMoUBUjG+ihQj9AiD9IKaVS/+VwV0nIVl8/VWn5KOewWlZH2P+RNberruv0RWLPQQn
 iaHQYRgcrprZ4IZDesMnKfm+qXmkuu2n0RuVc/6eC8/VEcnxlKB4uE0kYP7WlJTh3cHoAn
 GdJXqQ9v4VBBQbSNXlAJxnZxYQfxcprRmoGl0jP4RsLWRrOZ0d5jVIQxbNLEzg==
From: Marek Vasut <marex@denx.de>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>, Heiko Schocher <hs@denx.de>,
 Michal Simek <michal.simek@amd.com>, Tom Rini <trini@konsulko.com>,
 Vasileios Amoiridis <vasileios.amoiridis@cern.ch>
Subject: [PATCH] bootcount: zynqmp: Extend ZynqMP specific bootcount support
Date: Thu, 30 Jan 2025 02:37:19 +0100
Message-ID: <20250130013726.337914-1-marex@denx.de>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
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

The PGGS area contains four registers, each of which can hold up to
32bit of data. Extend the boot counter to support storing boot count
in either of the four registers with arbitrary mask to avoid limiting
the boot counter only to the PGGS register 2 LSByte.

Drop U_BOOT_DRVINFO() as that would instantiate the boot counter even
if there is no DT node associated with it, that is undesired behavior.

The boot counter configuration is implemented using three new DT properties:
reg - PGGS register address, fallback to PGGS 2 at 0xffd80058
u-boot,bootcount-reg-mask - Register mask, applied on PGGS register
u-boot,bootcount-mask - Boot counter mask, applied on boot counter
u-boot,bootcount-magic - Boot counter magic, applied on boot counter

Example configuration of 16bit boot counter with 0xb0010000 magic in PGGS0:

&amba {
	bootcount@0xffd80050 {
		compatible = "u-boot,bootcount-zynqmp";
		reg = <0 0xffd80050 0 0x4>;
		u-boot,bootcount-magic = <0xb0010000>;
		u-boot,bootcount-mask = <0xffff>;
		u-boot,bootcount-reg-mask = <0xffffffff>;
	};
};

Signed-off-by: Marek Vasut <marex@denx.de>
---
Cc: Heiko Schocher <hs@denx.de>
Cc: Michal Simek <michal.simek@amd.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: Vasileios Amoiridis <vasileios.amoiridis@cern.ch>
Cc: u-boot@lists.denx.de
---
 drivers/bootcount/bootcount_zynqmp.c | 79 +++++++++++++++++++++++++---
 1 file changed, 71 insertions(+), 8 deletions(-)

diff --git a/drivers/bootcount/bootcount_zynqmp.c b/drivers/bootcount/bootcount_zynqmp.c
index bc0984e2d26..6613b80caec 100644
--- a/drivers/bootcount/bootcount_zynqmp.c
+++ b/drivers/bootcount/bootcount_zynqmp.c
@@ -3,16 +3,32 @@
 
 #include <bootcount.h>
 #include <dm.h>
+#include <dm/device_compat.h>
 #include <stdio.h>
 #include <zynqmp_firmware.h>
 #include <asm/arch/hardware.h>
 #include <dm/platdata.h>
 
+struct bootcount_zynqmp_priv {
+	void __iomem	*reg;		/* PGGS register to use for boot counter */
+	u32		regmask;	/* Mask over the valid register bits */
+	u32		mask;		/* Mask over the valid boot counter bits */
+	u32		magic;		/* Magic to place in the rest of the register */
+};
+
 static int bootcount_zynqmp_set(struct udevice *dev, const u32 val)
 {
+	struct bootcount_zynqmp_priv *priv = dev_get_priv(dev);
+	u32 rwval = val;
 	int ret;
 
-	ret = zynqmp_mmio_write((ulong)&pmu_base->pers_gen_storage2, 0xFF, val);
+	/* Apply magic to detect whether the boot counter is valid. */
+	rwval &= priv->mask;	/* Clear all non-bootcounter bits */
+	rwval |= priv->magic;	/* Apply magic value */
+
+	rwval &= priv->regmask;	/* Apply register mask */
+
+	ret = zynqmp_mmio_write((ulong)priv->reg, priv->regmask, rwval);
 	if (ret)
 		pr_info("%s write fail\n", __func__);
 
@@ -21,27 +37,74 @@ static int bootcount_zynqmp_set(struct udevice *dev, const u32 val)
 
 static int bootcount_zynqmp_get(struct udevice *dev, u32 *val)
 {
+	struct bootcount_zynqmp_priv *priv = dev_get_priv(dev);
 	int ret;
 
 	*val = 0;
-	ret = zynqmp_mmio_read((ulong)&pmu_base->pers_gen_storage2, val);
-	if (ret)
+	ret = zynqmp_mmio_read((ulong)priv->reg, val);
+	if (ret) {
 		pr_info("%s read fail\n", __func__);
+		return ret;
+	}
 
-	return ret;
-}
+	/* Clear out unrelated register content. */
+	*val &= priv->regmask;
 
-U_BOOT_DRVINFO(bootcount_zynqmp) = {
-	.name = "bootcount_zynqmp",
-};
+	/* Check whether magic is valid, if not, boot counter value is 0. */
+	if ((*val & ~priv->mask) != priv->magic)
+		*val = 0;
+
+	/* Remove magic from boot counter value. */
+	*val &= priv->mask;
+
+	return 0;
+}
 
 static const struct bootcount_ops bootcount_zynqmp_ops = {
 	.get = bootcount_zynqmp_get,
 	.set = bootcount_zynqmp_set,
 };
 
+static int bootcount_zynqmp_probe(struct udevice *dev)
+{
+	struct bootcount_zynqmp_priv *priv = dev_get_priv(dev);
+
+	/*
+	 * ZynqMP PGGS register to use for boot counter,
+	 * default to PGGS2 to maintain backward compatibility.
+	 */
+	priv->reg = dev_read_addr_ptr(dev);
+	if (!priv->reg)
+		priv->reg = &pmu_base->pers_gen_storage2;
+
+	/*
+	 * Boot counter mask and register mask, default to 0x000000ff
+	 * to maintain backward compatibility.
+	 */
+	priv->mask = dev_read_u32_default(dev, "u-boot,bootcount-mask", 0xff);
+	priv->regmask = dev_read_u32_default(dev, "u-boot,bootcount-reg-mask",
+					     priv->mask);
+
+	/*
+	 * Boot counter magic, default to 0x00000000
+	 * to maintain backward compatibility.
+	 */
+	priv->magic = dev_read_u32_default(dev, "u-boot,bootcount-magic", 0);
+	priv->magic &= ~priv->mask;
+
+	return 0;
+}
+
+static const struct udevice_id bootcount_zynqmp_ids[] = {
+	{ .compatible = "u-boot,bootcount-zynqmp" },
+	{ }
+};
+
 U_BOOT_DRIVER(bootcount_zynqmp) = {
 	.name = "bootcount_zynqmp",
 	.id = UCLASS_BOOTCOUNT,
 	.ops = &bootcount_zynqmp_ops,
+	.probe = bootcount_zynqmp_probe,
+	.of_match = bootcount_zynqmp_ids,
+	.priv_auto = sizeof(struct bootcount_zynqmp_priv),
 };
-- 
2.45.2

