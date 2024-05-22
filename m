Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86F60C25B79
	for <u-boot@archiver.kernel.org>; Wed, 22 May 2024 17:09:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B151D888B2;
	Wed, 22 May 2024 19:08:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=flygoat.com header.i=@flygoat.com header.b="AqENpY79";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="p4UGlzvs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2B75C888B0; Wed, 22 May 2024 19:08:19 +0200 (CEST)
Received: from wfout6-smtp.messagingengine.com
 (wfout6-smtp.messagingengine.com [64.147.123.149])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1222988889
 for <u-boot@lists.denx.de>; Wed, 22 May 2024 19:08:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jiaxun.yang@flygoat.com
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
 by mailfout.west.internal (Postfix) with ESMTP id 486311C00150;
 Wed, 22 May 2024 13:08:15 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute5.internal (MEProxy); Wed, 22 May 2024 13:08:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1716397694;
 x=1716484094; bh=51v4K0P8EVsp0p7SnaIspIVQxfHxeWtRhsc3QAQXJ6s=; b=
 AqENpY796rJkkeazBB43IjNt9ni8b3yKwr37tD2v7zinAc/9Jfth/0KyOzA7oYwy
 MkAKJWlzy7HxYZUraq59RJJCnr7nb3oFuOm6pW669s3mjEjdcvlRSj5OLEakIgEs
 WZQz3ONVpAvePZmz9CnTGMEUGoJ4JgM7/DFabcNNGcT59fpx73oCgblHOdFFLwC/
 husV0BB1vwIYlSFmj3XiPLCRBgSYgs+HN/wb8hfsBhJhN6CEF1JYrFG7zWzhOCoM
 Y3wCNT1mxjVIT66vlLy397eCV6KD0vDU2z+Zs+OyqN9vx65yZ8uwiEQ+yzbH32Cq
 nyczI57kTDX/GYr8bucdZw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1716397694; x=
 1716484094; bh=51v4K0P8EVsp0p7SnaIspIVQxfHxeWtRhsc3QAQXJ6s=; b=p
 4UGlzvs8vxPP+cpz2TC1WQYSKRMDVfBJ6Tm+Xr8LIhsYUtbb78BVdKVOcykv9YCQ
 NY1qyQWwWneKvHEV6cznncgCbmD3LGovS/+SD5TMH211/W2cBVXqcWNgmbz1OBBk
 jgOnueLBzD2rI6w43YgqNF6BUi0/DsTBDKITHA3n7edPkqJaYr05o85PoXKb+sv/
 0T65hQ6LZfbEYvQOTtzUGkNehtgHdkO+qARv2u3ouyJshPX0xtaLNMrrwH219TnW
 jo9ho6sh1Tn74UqstCy9m2CVBIrorGEoAUQn0wnxuZEcPOaMO+BP3dL6psHDFIcq
 yQb4X7zRIuGe/1grQOJ+A==
X-ME-Sender: <xms:fiZOZpY0Jf6bdaxC25XtZPAfcAUxmJFrNZk0UJ41Y4I9RrS-d3NtEA>
 <xme:fiZOZgZEVHm3TcPA833A3IXsCcY7EBBjN11TNuVZ2I-_rLM-dpzn3-WAjgf4RUko3
 _Fxnnr4J1RPXloX5H8>
X-ME-Received: <xmr:fiZOZr-y5j7Ne-zAl43mnrfwS2xBD2nJHbUTnGYNhAV_ysRNO6u7pvQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdeigedgfeegucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpeflihgr
 gihunhcujggrnhhguceojhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomheqne
 cuggftrfgrthhtvghrnhepvdekiefhfeevkeeuveetfeelffekgedugefhtdduudeghfeu
 veegffegudekjeelnecuvehluhhsthgvrhfuihiivgepvdenucfrrghrrghmpehmrghilh
 hfrhhomhepjhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomh
X-ME-Proxy: <xmx:fiZOZnohybusdpkxUO4LFdKrC99k-ctc7NjVjU_zVld7wa29iWClOg>
 <xmx:fiZOZkqhco3Sotb7gZ9JGxJcki65lD0gZk7cz5C4hsiD-peh4mF9HQ>
 <xmx:fiZOZtTE1ZMfpz9H_7TwE19xCOKeV4-_m-aktPWrp5uXMCLPgWOAMg>
 <xmx:fiZOZsrX6L44LV1m6H31xCHudzfXtBlOgQQe1b4cERyfO4Bubr1hTg>
 <xmx:fiZOZlfrQJFHbu3RxenHUMZUc5Mxh2beP_P22XjF3nHzTgvv35DUH3uT>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 22 May 2024 13:08:13 -0400 (EDT)
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
Date: Wed, 22 May 2024 18:08:03 +0100
Subject: [PATCH v2 07/10] drivers: cpu: Add xtensa CPU driver
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240522-qemu-xtensa-v2-7-04bf7e42b10b@flygoat.com>
References: <20240522-qemu-xtensa-v2-0-04bf7e42b10b@flygoat.com>
In-Reply-To: <20240522-qemu-xtensa-v2-0-04bf7e42b10b@flygoat.com>
To: u-boot@lists.denx.de, Sean Anderson <sean.anderson@seco.com>
Cc: Max Filippov <jcmvbkbc@gmail.com>, Tom Rini <trini@konsulko.com>, 
 Sumit Garg <sumit.garg@linaro.org>, Jiaxun Yang <jiaxun.yang@flygoat.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4043;
 i=jiaxun.yang@flygoat.com; h=from:subject:message-id;
 bh=Vj7K34xzk80p+hSGvzRVdiGlPDsc8x+UvGR796zCzTI=;
 b=owGbwMvMwCXmXMhTe71c8zDjabUkhjQ/tfyl/tlCS0Usoy5+P397ntG36Ue2LDLLOaveHZ20x
 YlX8e73jhIWBjEuBlkxRZYQAaW+DY0XF1x/kPUHZg4rE8gQBi5OAZhI13tGhjOvBZSrNrN8TszY
 /vHsGQnOVS5/LqTFRoke4Zlxp0D4VSXD99Bfizawnq218VngEt9aMqchvKOWo6nuU+sc2R871gm
 wAQA=
X-Developer-Key: i=jiaxun.yang@flygoat.com; a=openpgp;
 fpr=980379BEFEBFBF477EA04EF9C111949073FC0F67
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

Implement various CPU related functions.
I'm actually just using it to get cpu clock frequency.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 drivers/cpu/Kconfig      |   6 +++
 drivers/cpu/Makefile     |   1 +
 drivers/cpu/xtensa_cpu.c | 117 +++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 124 insertions(+)

diff --git a/drivers/cpu/Kconfig b/drivers/cpu/Kconfig
index 1c3c810651ef..5c06cd9f60e8 100644
--- a/drivers/cpu/Kconfig
+++ b/drivers/cpu/Kconfig
@@ -33,3 +33,9 @@ config CPU_MICROBLAZE
 	select XILINX_MICROBLAZE0_PVR
 	help
 	  Support CPU cores for Microblaze architecture.
+
+config CPU_XTENSA
+	bool "Enable Xtensa CPU driver"
+	depends on CPU && XTENSA
+	help
+	  Support CPU cores for Xtensa architecture.
diff --git a/drivers/cpu/Makefile b/drivers/cpu/Makefile
index d4bbf6fa5e05..bc75d9b974e8 100644
--- a/drivers/cpu/Makefile
+++ b/drivers/cpu/Makefile
@@ -14,4 +14,5 @@ obj-$(CONFIG_CPU_IMX) += imx8_cpu.o
 obj-$(CONFIG_CPU_MPC83XX) += mpc83xx_cpu.o
 obj-$(CONFIG_CPU_RISCV) += riscv_cpu.o
 obj-$(CONFIG_CPU_MICROBLAZE) += microblaze_cpu.o
+obj-$(CONFIG_CPU_XTENSA) += xtensa_cpu.o
 obj-$(CONFIG_SANDBOX) += cpu_sandbox.o
diff --git a/drivers/cpu/xtensa_cpu.c b/drivers/cpu/xtensa_cpu.c
new file mode 100644
index 000000000000..fbb561dd6128
--- /dev/null
+++ b/drivers/cpu/xtensa_cpu.c
@@ -0,0 +1,117 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2024 Jiaxun Yang <jiaxun.yang@flygoat.com>
+ */
+
+#include <clk.h>
+#include <cpu.h>
+#include <dm.h>
+#include <errno.h>
+#include <linux/bitops.h>
+#include <linux/err.h>
+
+#include <asm/arch/core.h>
+
+static int xtensa_cpu_get_desc(const struct udevice *dev, char *buf, int size)
+{
+	const char *cpu = XCHAL_CORE_ID;
+
+	if (!cpu || size < (strlen(cpu) + 1))
+		return -ENOSPC;
+
+	strcpy(buf, cpu);
+
+	return 0;
+}
+
+static int xtensa_cpu_get_info(const struct udevice *dev, struct cpu_info *info)
+{
+	struct cpu_plat *plat = dev_get_parent_plat(dev);
+
+	info->cpu_freq = plat->timebase_freq;
+
+#if XCHAL_HAVE_PTP_MMU
+		info->features |= BIT(CPU_FEAT_MMU);
+#endif
+#if XCHAL_ICACHE_SIZE || XCHAL_DCACHE_SIZE
+		info->features |= BIT(CPU_FEAT_L1_CACHE);
+#endif
+
+	return 0;
+}
+
+static int xtensa_cpu_get_count(const struct udevice *dev)
+{
+	ofnode node;
+	int num = 0;
+
+	ofnode_for_each_subnode(node, dev_ofnode(dev->parent)) {
+		const char *device_type;
+
+		/* skip if hart is marked as not available in the device tree */
+		if (!ofnode_is_enabled(node))
+			continue;
+
+		device_type = ofnode_read_string(node, "device_type");
+		if (!device_type)
+			continue;
+		if (strcmp(device_type, "cpu") == 0)
+			num++;
+	}
+
+	return num;
+}
+
+static int xtensa_cpu_bind(struct udevice *dev)
+{
+	struct cpu_plat *plat = dev_get_parent_plat(dev);
+
+	plat->cpu_id = dev_read_addr(dev);
+
+	return 0;
+}
+
+static int xtensa_cpu_probe(struct udevice *dev)
+{
+	int ret = 0;
+	struct clk clk;
+	struct cpu_plat *plat = dev_get_parent_plat(dev);
+
+	asm volatile ("rsr %0, 176\n"
+		      "rsr %1, 208\n"
+		      : "=r"(plat->id[0]), "=r"(plat->id[1]));
+
+	/* Get a clock if it exists */
+	ret = clk_get_by_index(dev, 0, &clk);
+	if (!ret) {
+		ret = clk_enable(&clk);
+		if (ret && (ret != -ENOSYS || ret != -ENOTSUPP))
+			return ret;
+		ret = clk_get_rate(&clk);
+		if (!IS_ERR_VALUE(ret))
+			plat->timebase_freq = ret;
+	}
+
+	return 0;
+}
+
+static const struct cpu_ops xtensa_cpu_ops = {
+	.get_desc	= xtensa_cpu_get_desc,
+	.get_info	= xtensa_cpu_get_info,
+	.get_count	= xtensa_cpu_get_count,
+};
+
+static const struct udevice_id xtensa_cpu_ids[] = {
+	{ .compatible = "cdns,xtensa-cpu" },
+	{ }
+};
+
+U_BOOT_DRIVER(xtensa_cpu) = {
+	.name = "xtensa_cpu",
+	.id = UCLASS_CPU,
+	.of_match = xtensa_cpu_ids,
+	.bind = xtensa_cpu_bind,
+	.probe = xtensa_cpu_probe,
+	.ops = &xtensa_cpu_ops,
+	.flags = DM_FLAG_PRE_RELOC,
+};

-- 
2.43.0

