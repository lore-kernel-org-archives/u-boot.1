Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96078C5DF8E
	for <u-boot@archiver.kernel.org>; Fri, 21 Aug 2026 08:44:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 57B5881157;
	Fri, 21 Aug 2026 08:44:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id bz7dTYIYWP9e; Fri, 21 Aug 2026 08:44:28 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787301868;
	bh=BSzxMZ28lfPfZVKHuKHHPrleRx4kFmLltYdaySZPIs8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=p35vB+9LSeYdU1fsi7H5SOH+yPVvGLpKA88WAa6kIODkkvd2e5cSnYtwaRLf6W4bp
	 RhWTarHsneshe9CEg4ZVWkLvlaiSSR3VUJi85LUhQkMk1YRjJcqvRFkEuFSj3JJl6L
	 MwfGb0zUNPAquuchcJqsEfDsC8ZIzt/oMwuwvilovgKgjlTWr5PXjnejHI/4Rnoruo
	 00sVB/LR4rS794X0VOV6ii2p/I+dxATo4VeaA5TD1nAf/wMSYV3rNj7aWOliMRkx07
	 D8HESoGlfofg3Q1GPJNlvxTB0gb+yTprMhFXyXki/1iwHMb1y3xIUKywJxVYph0t3a
	 64WXG6KTzkqbA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8B1208114D;
	Fri, 21 Aug 2026 08:44:28 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 6E4201B8
 for <u-boot@lists.u-boot-project.org>; Fri, 21 Aug 2026 08:44:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 608F48104B
 for <u-boot@lists.u-boot-project.org>; Fri, 21 Aug 2026 08:44:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LT_B4fsXmTtQ for <u-boot@lists.u-boot-project.org>;
 Fri, 21 Aug 2026 08:44:25 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=136.143.188.15;
 helo=sender4-op-o15.zoho.com; envelope-from=me@ziyao.cc; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=ziyao.cc
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=ziyao.cc header.i=me@ziyao.cc
 header.a=rsa-sha256 header.s=zmail header.b=daxtae1Q
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com
 [136.143.188.15])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 9E87F810B7
 for <u-boot@lists.u-boot-project.org>; Fri, 21 Aug 2026 08:44:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1787301859; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=e5T3rshCq58iUPNdQP6gdWX8mzFplnpQYnpnK12LHwEBjunxNeo9hBXudlB0Xfh+ZN3qXHSNhKvnijp6clljycih5bjfpuKajk4WABt4e+2mI3A/YjDLaS1QyBupL8QD6i9FkDIqXOc844qwZqQqYR5tLEIx3BWeWIVP7+Fu29Y=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1787301859;
 h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=BSzxMZ28lfPfZVKHuKHHPrleRx4kFmLltYdaySZPIs8=; 
 b=kVTkX4DbW1mNhq1lz7yoFho/Vom1VNnHIyN+PeA5oTzqXaHXYEEMAmfkA6BMY+DabhyTUyF4X+08KMGDwKVm+A8kBWIftisXjJxhndbkagQc0OwWOJlike30NLX8Rqx0ULGyNjS7oxDrPch2GklKgVLQ3sji91kk39eIvrRItTQ=
ARC-Authentication-Results: i=1; mx.zohomail.com; dkim=pass  header.i=ziyao.cc;
 spf=pass  smtp.mailfrom=me@ziyao.cc;
 dmarc=pass header.from=<me@ziyao.cc>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1787301859; 
 s=zmail; d=ziyao.cc; i=me@ziyao.cc;
 h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=BSzxMZ28lfPfZVKHuKHHPrleRx4kFmLltYdaySZPIs8=;
 b=daxtae1Qo646tHT3kWocmFYeif0gokM2w7YDs5Txkoo9EH+qWPZtl4Yl1CaXKCif
 DSrVXTuPh4YVH2LtzUko14F6L4qqOwX8nNgga4N+9OajLvd7qxsleZ4IIkp+NKjK3r3
 e9K2qwpch1oQL2JwmWHNUTEEAELbtOYAnAeVckNE=
Received: by mx.zohomail.com with SMTPS id 1787301857114921.0376665395847;
 Fri, 21 Aug 2026 01:44:17 -0700 (PDT)
From: Yao Zi <me@ziyao.cc>
To: Tom Rini <trini@konsulko.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.u-boot-project.org,
	Yao Zi <me@ziyao.cc>
Subject: [PATCH v3 12/19] cpu: Add loongarch_cpu driver
Date: Fri, 21 Aug 2026 08:42:12 +0000
Message-ID: <20260821084219.1703743-13-me@ziyao.cc>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260821084219.1703743-1-me@ziyao.cc>
References: <20260821084219.1703743-1-me@ziyao.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

From: Jiaxun Yang <jiaxun.yang@flygoat.com>

Implement a driver for LoongArch CPU solely for gathering
some information bits from FDT and CPU level config registers.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
Signed-off-by: Yao Zi <me@ziyao.cc>
---

Changed from v2
- Fall through to devicetree path in loongarch_cpu_get_desc() when
  probing with CPUCFG gets no meaningful results, instead of handling
  such cases with goto
- Replace open-coded copying loop with memcpy() in
  loongarch_cpu_get_desc()
- Correctly return -ENOSPC when snprintf() truncates the string in
  loongarch_cpu_get_desc()

Changed from v1
- Drop unnecessary check against -ENOTSUPP clk_enable()'s return value
  in loongarch_cpu_probe()

 drivers/cpu/Kconfig         |   6 ++
 drivers/cpu/Makefile        |   1 +
 drivers/cpu/loongarch_cpu.c | 142 ++++++++++++++++++++++++++++++++++++
 3 files changed, 149 insertions(+)
 create mode 100644 drivers/cpu/loongarch_cpu.c

diff --git a/drivers/cpu/Kconfig b/drivers/cpu/Kconfig
index c805c0bbfa19..9fd43ff88fde 100644
--- a/drivers/cpu/Kconfig
+++ b/drivers/cpu/Kconfig
@@ -13,6 +13,12 @@ config CPU_IMX
 	help
 	  Support CPU cores for SoCs of the i.MX series.
 
+config CPU_LOONGARCH
+	bool "Enable LoongArch CPU driver"
+	depends on CPU && LOONGARCH
+	help
+	  Support CPU cores for LoongArch processors.
+
 config CPU_MPC83XX
 	bool "Enable MPC83xx CPU driver"
 	depends on CPU && MPC83xx
diff --git a/drivers/cpu/Makefile b/drivers/cpu/Makefile
index eaf494706e2c..d9c0db74dd5a 100644
--- a/drivers/cpu/Makefile
+++ b/drivers/cpu/Makefile
@@ -13,6 +13,7 @@ obj-$(CONFIG_ARCH_AT91) += at91_cpu.o
 obj-$(CONFIG_ARCH_MEDIATEK) += mtk_cpu.o
 obj-$(CONFIG_CPU_ARMV8) += armv8_cpu.o
 obj-$(CONFIG_CPU_IMX) += imx8_cpu.o
+obj-$(CONFIG_CPU_LOONGARCH) += loongarch_cpu.o
 obj-$(CONFIG_CPU_MPC83XX) += mpc83xx_cpu.o
 obj-$(CONFIG_CPU_RISCV) += riscv_cpu.o
 obj-$(CONFIG_CPU_MICROBLAZE) += microblaze_cpu.o
diff --git a/drivers/cpu/loongarch_cpu.c b/drivers/cpu/loongarch_cpu.c
new file mode 100644
index 000000000000..74a80f9e79a4
--- /dev/null
+++ b/drivers/cpu/loongarch_cpu.c
@@ -0,0 +1,142 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2024 Jiaxun Yang <jiaxun.yang@flygoat.com>
+ */
+
+#include <clk.h>
+#include <cpu.h>
+#include <dm.h>
+#include <errno.h>
+#include <log.h>
+#include <asm/loongarch.h>
+#include <dm/device-internal.h>
+#include <dm/lists.h>
+#include <linux/bitops.h>
+#include <linux/err.h>
+
+static int loongarch_cpu_get_desc(const struct udevice *dev, char *buf, int size)
+{
+	const char *cpu;
+
+	/* We try to get CPU name from IOCSR first */
+	if ((read_cpucfg(LOONGARCH_CPUCFG1) & CPUCFG1_IOCSR)) {
+		char vendor_buf[9] = { 0 };
+		char name_buf[9] = { 0 };
+		u64 vendor = iocsr_read64(LOONGARCH_IOCSR_VENDOR);
+		u64 name = iocsr_read64(LOONGARCH_IOCSR_CPUNAME);
+
+		if (vendor && name) {
+			int ret;
+
+			memcpy(vendor_buf, &vendor, sizeof(vendor));
+			memcpy(name_buf, &name, sizeof(name));
+
+			ret = snprintf(buf, size, "%s-%s", vendor_buf, name_buf);
+			return ret >= size ? -ENOSPC : 0;
+		}
+	}
+
+	cpu = dev_read_string(dev, "compatible");
+	if (!cpu || size < (strlen(cpu) + 1))
+		return -ENOSPC;
+
+	strcpy(buf, cpu);
+
+	return 0;
+}
+
+static int loongarch_cpu_get_info(const struct udevice *dev, struct cpu_info *info)
+{
+	int ret;
+	struct clk clk;
+
+	/* First try getting the frequency from the assigned clock */
+	ret = clk_get_by_index((struct udevice *)dev, 0, &clk);
+	if (!ret) {
+		ret = clk_get_rate(&clk);
+		if (!IS_ERR_VALUE(ret))
+			info->cpu_freq = ret;
+	}
+
+	if (!info->cpu_freq)
+		dev_read_u32(dev, "clock-frequency", (u32 *)&info->cpu_freq);
+
+	if (read_cpucfg(LOONGARCH_CPUCFG1) & CPUCFG1_PAGING)
+		info->features |= BIT(CPU_FEAT_MMU);
+
+	if (read_cpucfg(LOONGARCH_CPUCFG16) & CPUCFG16_L1_IUPRE)
+		info->features |= BIT(CPU_FEAT_L1_CACHE);
+
+	return 0;
+}
+
+static int loongarch_cpu_get_count(const struct udevice *dev)
+{
+	ofnode node;
+	int num = 0;
+
+	ofnode_for_each_subnode(node, dev_ofnode(dev->parent)) {
+		const char *device_type;
+
+		/* skip if core is marked as not available in the device tree */
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
+static int loongarch_cpu_bind(struct udevice *dev)
+{
+	struct cpu_plat *plat = dev_get_parent_plat(dev);
+
+	plat->cpu_id = dev_read_addr(dev);
+
+	return 0;
+}
+
+static int loongarch_cpu_probe(struct udevice *dev)
+{
+	int ret = 0;
+	struct clk clk;
+
+	/* Get a clock if it exists */
+	ret = clk_get_by_index(dev, 0, &clk);
+	if (ret)
+		return 0;
+
+	ret = clk_enable(&clk);
+	if (ret == -ENOSYS)
+		return 0;
+	else
+		return ret;
+}
+
+static const struct cpu_ops loongarch_cpu_ops = {
+	.get_desc	= loongarch_cpu_get_desc,
+	.get_info	= loongarch_cpu_get_info,
+	.get_count	= loongarch_cpu_get_count,
+};
+
+static const struct udevice_id loongarch_cpu_ids[] = {
+	{ .compatible = "loongarch,Loongson-3A5000" }, /* From QEMU, undocumented */
+	{ .compatible = "loongson,la264" },
+	{ .compatible = "loongson,la364" },
+	{ }
+};
+
+U_BOOT_DRIVER(loongarch_cpu) = {
+	.name = "loongarch_cpu",
+	.id = UCLASS_CPU,
+	.of_match = loongarch_cpu_ids,
+	.bind = loongarch_cpu_bind,
+	.probe = loongarch_cpu_probe,
+	.ops = &loongarch_cpu_ops,
+	.flags = DM_FLAG_PRE_RELOC,
+};
-- 
2.55.0

