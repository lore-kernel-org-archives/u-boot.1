Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8F3DCCA462
	for <u-boot@archiver.kernel.org>; Fri, 16 Oct 2026 06:57:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8B08D409CE;
	Fri, 16 Oct 2026 06:57:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5d--XRahdSjd; Fri, 16 Oct 2026 06:57:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 9C070409BB
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792133865;
	b=f8vPGXxEH7I2xd+b2zb7twlieoFOhjGo1PDzGWrLXXOGAUveBwCbKSwLKN3OLAAb4upt
	 y/HnfwvdBVaVZIklSSs0D6uFeDw8YEbVTO0ZqwtVKZHWpIZF1+M5Spxp6P9ia5n6OIVLo
	 vRKQCIZrOj1LHTdcB8rjTfSuKyuHvDAp5qkC4hqJTmLscmmArsjxvgYzFA1xZnSdMWHGJ
	 m0PxBUiDa4fXzhvpbZxn6xSbS0kDS2kRo7nxUU+nMf7tfrDcH7eHb9JB3orWo7RI11Zci
	 2FD6UVS7VQXK9/JVKZqIF6xaTnvAT5RvilUiIam3xc/V+yNVNY8yzDQv+1+0OXIKdiw==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792133865;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-ZohoMailClient:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=k2ocCWM5XSq1rokPYX9Dw3TkgK4q1TLtiilx9Y9XHao=;
	b=JItjse56GHRLtm0Ke99bh4gnxAenIDdxuFjfctnJM6OL6841gXicxc89R9qX3YAVWzF7
	 by8kHGbRTzogBeIJKXxx0Xwfhclwu2SFL2178lD+3PfC7GnSwFtM0t1pGjUTHfyxokgVU
	 u2vTpRNCi6Lk9lwNpWxhkG8NYK6ltGWKFstx2IxJHs1R7h45gAf4+8FHC2H+YRHOtgJPn
	 Fbkrv9yBACo7vD7vdaBWFlM7WEniYdYEOXzChrWO82Lf7Z0aIhkm1xM43yLYwyNjSUDRb
	 MkPLLp5EnXipamfJmL8GV8vQaX7NYwX770CnSOKvC9SfyiYU89mElCbe+J+CiilQnTQ==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; 
	dmarc=pass header.from=ziyao.cc;
	dkim=pass header.d=ziyao.cc header.i=me@ziyao.cc header.a=rsa-sha256 header.s=zmail header.b=YWHUt5ss;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792133865;
	bh=k2ocCWM5XSq1rokPYX9Dw3TkgK4q1TLtiilx9Y9XHao=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=iB8mzUoL5swJ02gS592SgcfMtov+vXyZHgakaXbhIe1xsRoz2jkMTjRCLRxjEku/z
	 C+IZD9wBOHL/0eJi4L0Rh/1ErUyRmKLGdaLX6xGgbbQmd/QJRKYQH31GB0+Z/+chZP
	 32kx7jXGzqRgqe8ik3rAlAA+wtSQp5aSx5ke6NjTFHFx8hCNkgX56VdBykSNw4S7K9
	 zW3GYHhkRP5w4n7+zD34iOjSj8DkYIyHifaiJYwX22Pfi6EcQ8XK8bQhzFUIcNOFp3
	 xiKvUjWN78UptoeRlHewyXX2qPZp8mfldOOC3Y0XeQQIJ46Fk+w+GBRSqMZa84CJP7
	 bsXD8deoNdUgA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9C070409BB;
	Fri, 16 Oct 2026 06:57:45 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 78615362
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 06:57:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 67C9A409BB
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 06:57:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7ZvT58TWmVVt for <u-boot@lists.u-boot-project.org>;
 Fri, 16 Oct 2026 06:57:43 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org A2FF540990
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=165.173.180.15
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792133862;
 b=CTnyMdLeMFOyF84UG1SwupltviLjg8CtUPGJ7nShekzcLoTvhXlwSABHTW2+A/CaCcj3
 brFGjNiQy/D4odz80OPe9FyK/y+BUc36U8qNNk0WNGzDxKXs5qxMFZQQ3rvPk2m5i+z3T
 buDgK06FH94KRD3rsrJZqyRJq4nzVER7xoee+ROcZu0zvXlrzbdQ3WY1GctAmkO6LynQC
 Ru5mwmcOgT2j43ZE7mmFQyC0kwOvU55BEcDwgc3A62coKIyBdFFFIqdERH4mm1pPk0UVA
 1+IuW3R723MqyImwbRDsphzGtRwGJIAP4A0NJHkxXvv2uc1v7/uvrFFdJMtkb1eMgKg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792133862;
 h=Received-SPF:DKIM-Signature:Received:From:To:Cc:Subject:Date:
 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:X-ZohoMailClient;
 bh=k2ocCWM5XSq1rokPYX9Dw3TkgK4q1TLtiilx9Y9XHao=;
 b=WHxGAsZ3Y4wHeJHpHznsfQ3LdNu2vvjv94haGYi6vW3Ko7pUd6owbbIoPJoVq+0DR419
 nHxyu0trDmqJ8La/Qakj4nn+dT8AVAmZyJaMGUPsV0Kj4y/4gWmXkQNXK+IvQDtGmClfE
 8wlXXTvVtDUPEvxYE8TcS4IOrcdfaHCLr41GQW5XgbipFny4V/H6oT3QmFwKNUrYbc7zI
 J55eZ98na91IXWJs1dI28IPETElzzqtRwZ72hwlbe+cElD7jiFkq7CaNGBcrqZCu0eVbn
 BMb9ingQCy9+JrV350AY9NUxYX1YtQp5QMKJYQYfbeFePOG7assJr4m/u4mCNnzTQXA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
 dmarc=pass header.from=ziyao.cc;
 dkim=pass header.d=ziyao.cc header.i=me@ziyao.cc header.a=rsa-sha256
 header.s=zmail header.b=YWHUt5ss; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.180.15
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=165.173.180.15;
 helo=sender6-op-o15.zoho.com; envelope-from=me@ziyao.cc; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=ziyao.cc
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=ziyao.cc header.i=me@ziyao.cc
 header.a=rsa-sha256 header.s=zmail header.b=YWHUt5ss
Received: from sender6-op-o15.zoho.com (sender6-op-o15.zoho.com
 [165.173.180.15])
 by smtp4.osuosl.org (Postfix) with ESMTPS id A2FF540990
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 06:57:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1792133855; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=IvBrsQ6r/JLBH2LXPb40aI+Myr0vruwa42kF8tbxGijHuKA/xg6R7lLtyKkKFMBYTMrQcKVBtzOsmaRZAO9xoq7N5mJd0ZyFO/riTfIyjQg8lEejiGzfLKwtlGBzbri6XP6Rqebtr+M0tcaP0yB9SqUnaadGEX6QjSz2arfWJf8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1792133855;
 h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=k2ocCWM5XSq1rokPYX9Dw3TkgK4q1TLtiilx9Y9XHao=; 
 b=Dz3g16eTKkRRsjSlFhN3dVYuQUK7HPxyIVoojro/cC/wKqvkSgM61aa55jvXGCSqFGpeEDDHkLtKTkXw2FNStsJVT+8heDL/0X/j1I4IkEe8S1DFQhvE/n0GWNrWGy3MT6ubbLlSSVPdYT29T+2zYkv54kAQENywt/yg9dk578s=
ARC-Authentication-Results: i=1; mx.zohomail.com; dkim=pass  header.i=ziyao.cc;
 spf=pass  smtp.mailfrom=me@ziyao.cc;
 dmarc=pass header.from=<me@ziyao.cc>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1792133855; 
 s=zmail; d=ziyao.cc; i=me@ziyao.cc;
 h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=k2ocCWM5XSq1rokPYX9Dw3TkgK4q1TLtiilx9Y9XHao=;
 b=YWHUt5sszKbZ7hIQn2dcDvLkViAgLdoFFCmwQgXVRDaWFQQZ92zwAWk6nK6t8em+
 Nc/bYDVvR94x7JFZP06rMnKfGV5Nzy7SpUrEhsVWPfU9NWYXMFF2pacA91HlI3b4gPp
 o/44TxyyI5WKSyJbOMlL9fnuZGPpL4wxF6Akneio=
Received: by smtp.zohomail.com with SMTPS id 1792133852763635.1211602287912;
 Thu, 15 Oct 2026 23:57:32 -0700 (PDT)
From: Yao Zi <me@ziyao.cc>
To: Tom Rini <trini@konsulko.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.u-boot-project.org,
	Yao Zi <me@ziyao.cc>
Subject: [PATCH v5 13/20] cpu: Add loongarch_cpu driver
Date: Fri, 16 Oct 2026 06:54:53 +0000
Message-ID: <20261016065500.137544-14-me@ziyao.cc>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261016065500.137544-1-me@ziyao.cc>
References: <20261016065500.137544-1-me@ziyao.cc>
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

Changed from v4
- Explicitly clear info->cpu_freq before passing its address to
  dev_read_u32()
- Temporarily store return value of clk_get_rate() in an ulong() to
  avoid truncation

No changes since v3

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
---
 drivers/cpu/Kconfig         |   6 ++
 drivers/cpu/Makefile        |   1 +
 drivers/cpu/loongarch_cpu.c | 145 ++++++++++++++++++++++++++++++++++++
 3 files changed, 152 insertions(+)
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
index 000000000000..773aac9dfe14
--- /dev/null
+++ b/drivers/cpu/loongarch_cpu.c
@@ -0,0 +1,145 @@
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
+	struct clk clk;
+	ulong freq;
+	int ret;
+
+	info->cpu_freq = 0;
+
+	/* First try getting the frequency from the assigned clock */
+	ret = clk_get_by_index((struct udevice *)dev, 0, &clk);
+	if (!ret) {
+		freq = clk_get_rate(&clk);
+		if (!IS_ERR_VALUE(freq))
+			info->cpu_freq = freq;
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

