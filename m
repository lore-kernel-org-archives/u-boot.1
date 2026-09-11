Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2706C88E4A
	for <u-boot@archiver.kernel.org>; Fri, 11 Sep 2026 10:48:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id BCDAC80816;
	Fri, 11 Sep 2026 10:48:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id IF3Ma2sQgzPN; Fri, 11 Sep 2026 10:48:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org DFBC480CA3
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789123693;
	b=SGlrbKNq/OAii1Q7gf61SbhAEdZONbbn9LgBy7o3rkEyujtBVQCCgv5YBZUFL6iGHFCv
	 Jgi2DGry7NiwAy5eIaHrC/Iz9oIFtujNbs40o0mn7fcoH+clI5OXzjiuxGNQrbZrRe3qv
	 gftdhrUDsbrCbxXfux7t8bGoO4seBLOXZyXnInvtl+KfCwTeyoCHVmb22A6LXXxCGUmT6
	 3QrAuHAsQS+SWA7nDkrIxtrqi+OEnImNtd6a05/UJfNQYu508u7HD9FVuUo7Nmk5lV8Wp
	 X1xX7pcVuwAujrOL9KQwmo7J92Mz0bSYyycDS2yZdO1GSJnAj30twr9UjHiCkz+CwVQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789123693;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-ZohoMailClient:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=Cf4Qe7x0db0ymrVySdU+E7Hy0fuQMCUAMBoUVe/pg1I=;
	b=JYp1KO5cSUBAPBKXO7zNl0NNcdGIz1KCSHPARdtaS/R8F3ky5Vpd8uy11oedg90elT7Z
	 3sSeh8x5HXv55UhPDPOgUg0rdBi+6bDanlTxubZbbdt2JcU/+aWjtmD4TdxUMQ/G9RC1g
	 +JsfK2htNe0xh4Kv9pWGfHEqDtzHZ/ihgxWVDHTHtXeVcTG11KwU2LURnO7b9VQo5+hoM
	 Uo/FrP+uW/Zn9XfbTcbHLmrLtvUhCEkNupw2+xDYYQ/Qn6+ZBeqJqm8QMGK/i4c93uG5s
	 nOzrHLEBgm6EaLu6/5yGiNzWtTXwNVTEIgUe9VyJkwK4wdIlhd446QnG4sILRJLEPPA==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789123693;
	bh=Cf4Qe7x0db0ymrVySdU+E7Hy0fuQMCUAMBoUVe/pg1I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=h+0IE5MNA6PVYLRn6dgg9BtKAzgSDv99JXW4X+k+CcnQt8+LORbvpmdZCssMUhQkS
	 2NXm8bKi33COUbj2CQe/HrB2UtV/9L/QQR9vJYHrj/b7vgEEIGLW2tU7Q8z22g+VaC
	 SAWV+/quF8m6wtxYCL8c3RIkHlMoXb692VfQ9KmAxELKuLj8MnbDJ4RC+jZGsUarMJ
	 JoBF5PW47gBYtc/coDqbb2DxTGjvrwPNNjmXAWMSPkH9t/gpJkQtnRf+3DllsyrBIu
	 EMJ6k7B7FGADgnOvBsqOvBQNlAobk/ezfB9DSbZs8+9rsnZb0U1Re1HSbbEadORXAo
	 Y7MuCm7qIBQxQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id DFBC480CA3;
	Fri, 11 Sep 2026 10:48:12 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 91C2E49D
 for <u-boot@lists.u-boot-project.org>; Fri, 11 Sep 2026 10:48:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 77A7640B0B
 for <u-boot@lists.u-boot-project.org>; Fri, 11 Sep 2026 10:48:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id oHHZweT0c8t8 for <u-boot@lists.u-boot-project.org>;
 Fri, 11 Sep 2026 10:48:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org B164440AF6
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=136.143.188.15
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789123690;
 b=HMovG6Hcz90HU/XcV82yPRCD6Xrss6NsTq+QNjR549AK4Nq/IASeeRXIs/FT9RDUMojQ
 pOXw7wmPyD8QCE8pRVRpy16fbJtuNafpveoupsiNO7/fkLFdghxxFgNVQzrA2Poj4b9Tg
 JvQqUoqDnB+Y36k4F364NxFfZqjmixa/Y6oCN0pmi0RfNS+9xEVfvsjm7O/kfJ5MSg4k5
 cwVeq7h7TjniUFp/UxIvazdmThiSX1rndowkpkgLmkeQjPslEH7ImB96h/4yqLGYE8fLO
 Vym8DFjidreDHAIX9An8SkM7G9PKlVeWFSlaB3iT3KFU4ZL99qTD1sEeF8lolmTZHgQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789123690;
 h=Received-SPF:DKIM-Signature:Received:From:To:Cc:Subject:Date:
 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:X-ZohoMailClient;
 bh=Cf4Qe7x0db0ymrVySdU+E7Hy0fuQMCUAMBoUVe/pg1I=;
 b=nulFdxA1qluQD/glG8/nnUo4zvDKYG0OUukb3DgGmtxh4pbG/sfMbofLvfAW1mUUXTIk
 OCDAlnA02YKgwce5PO9wCHtUKk/4ANp2oH3B+KZ1fUkxtyLABQNo3ahCdlb2KUasPRFOl
 J5utWr1DCkPrcpdne+AvfYcfpIy+kRS1PN02Dlv5z+lMcsm3z48laY9Hi+cJbF8aUplrl
 kztUOMrNNQRGPAfeuCF4Db7kz6Cyg2Csy3Wja0/GpX1OTscL1ChTuJ0vxKxIKQc2qQyma
 Wnaebk/QgrwSrJ6bMz3ackUkIOOTzsCfx9ehznFUsckWe5/ns4DGwSQrC4Cj0pExMDA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org;
 dmarc=pass header.from=ziyao.cc; 
 dkim=pass header.d=ziyao.cc header.i=me@ziyao.cc header.a=rsa-sha256
 header.s=zmail header.b=hXHd6+iH; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=136.143.188.15
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=136.143.188.15;
 helo=sender4-op-o15.zoho.com; envelope-from=me@ziyao.cc; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=ziyao.cc
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=ziyao.cc header.i=me@ziyao.cc
 header.a=rsa-sha256 header.s=zmail header.b=hXHd6+iH
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com
 [136.143.188.15])
 by smtp4.osuosl.org (Postfix) with ESMTPS id B164440AF6
 for <u-boot@lists.u-boot-project.org>; Fri, 11 Sep 2026 10:48:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1789123686; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=GxB7f/yx/Us1eWuaMBqNvjL9YRO/O3XprC5OkXf936w5bIvs5OyOEydBCskW4S3CBsJNVOlnd/cZqD/+g/AqMx/PjRhPxLojYYspGgAMLqipsOd5mWIGqjCGd9N2iOINDAkLNEgkndd/ZZ+DKw26enFUm6wa8zkrez2nicgecms=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1789123686;
 h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=Cf4Qe7x0db0ymrVySdU+E7Hy0fuQMCUAMBoUVe/pg1I=; 
 b=MWHId1409Cg8SPZaN1TBz4nijzNMJ4PFE7j/u+N1S8DEgjwJPCaC1zccfuLuyxDtwqafuVf06Fn5UaSkFqlFIbm3hP+R/yl9sfDlAIayAhdHt8xZDMx1coqIVpHI6lcr/CgUKsbPW4KefwN7iwqHD9NhP+8Hb853IJLy49W9PWg=
ARC-Authentication-Results: i=1; mx.zohomail.com; dkim=pass  header.i=ziyao.cc;
 spf=pass  smtp.mailfrom=me@ziyao.cc;
 dmarc=pass header.from=<me@ziyao.cc>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1789123686; 
 s=zmail; d=ziyao.cc; i=me@ziyao.cc;
 h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=Cf4Qe7x0db0ymrVySdU+E7Hy0fuQMCUAMBoUVe/pg1I=;
 b=hXHd6+iHlF+A8fD4sZJnrmV7NS/34UXnGJwSJWgt600NU73+5HN/zEVoO8004OSX
 A3aiJpM2VbysaFB62uS80UE2aZWIpNQ3e3eErCfbF54DkhHTNxIVLrWNxllzTzf5FJm
 5NHxgvwSIB9TZCm9oBDxuFeB/6GNfJQSEIkUz5G4=
Received: by mx.zohomail.com with SMTPS id 1789123684084284.6325124630429;
 Fri, 11 Sep 2026 03:48:04 -0700 (PDT)
From: Yao Zi <me@ziyao.cc>
To: Tom Rini <trini@konsulko.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.u-boot-project.org,
	Yao Zi <me@ziyao.cc>
Subject: [PATCH v4 12/19] cpu: Add loongarch_cpu driver
Date: Fri, 11 Sep 2026 10:45:57 +0000
Message-ID: <20260911104604.2910944-13-me@ziyao.cc>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260911104604.2910944-1-me@ziyao.cc>
References: <20260911104604.2910944-1-me@ziyao.cc>
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

