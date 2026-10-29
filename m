Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A57A6606A321
	for <u-boot@archiver.kernel.org>; Thu, 29 Oct 2026 05:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=HVQEmdLw;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=ziyao.cc header.i=@ziyao.cc header.a=rsa-sha256 header.s=zmail header.b=AWYRqgMB
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6E1FA407C5;
	Thu, 29 Oct 2026 05:10:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zcpm3XnzdQ4y; Thu, 29 Oct 2026 05:10:15 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 7E04440731
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793250615;
	b=luzhar4tgkWJlMaC9OaIylafEgYQvikAJ/SLkqSGq3TOuc9D3K7BcrGvZdUNPXFSjMKJ
	 zS8AyWns5xtB8sh91QafHRe+6oCbMQiLOS2rWKibxdr/tmMSfnJaNazODDn3CdwzjsGvP
	 CCzihXkG9mvhWZrzY5hpAEXQ/IDC6rnzh6A7Q2X17aJBFejcctUgPcNy011Pjkr7Hy7rN
	 tfCZawWK80JiS8VqoYkMXYJgDOK/i4+gOBE6r37c3a1teIvBJKtVoRFlInkO5FUQNYInG
	 a4s9aSloqB9M5n0WYPUQCdQWQPhOadH40pvIY4gFV+jLI0v0OqhnlgpY9b4YkfhpilQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793250615;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-ZohoMailClient:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=rmu/xAAL4MrODGlzPpP6bPv8PFUKlCXBGE4FGfSU518=;
	b=JgocBynPiw0kgNK1haNtEzRDoghirVJ43QOrBAfKjW2ylURDXYxGLuzHTsZFHiE09Ffj
	 fpY1JMnU4aeebIZoUeuiSUr+gNuVz8SBekYf9yaEYScVXaGFjX+QC0z9t099KvoDio5nD
	 FU2Tmg8STChnC9PZzlKP1ClAmsPCJCceaIR6/6fR0Cj+Oc/F5niUt3FKJgNoT7WRTkmeP
	 2pugeDjvGPevWtrWAW8I53KAlqONq0AQT39NWSMtZbzI/16c5LOhZK/OJECXEahDePf3o
	 bQMh4J+9Y4OaFBYUQklkh0WV2dy5McFDsvUFMPtWbLjdxTWTedX3c45GHB+7CuqacCg==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; 
	dmarc=pass header.from=ziyao.cc;
	dkim=pass header.d=ziyao.cc header.i=@ziyao.cc header.a=rsa-sha256 header.s=zmail header.b=AWYRqgMB;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793250615;
	bh=rmu/xAAL4MrODGlzPpP6bPv8PFUKlCXBGE4FGfSU518=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=HVQEmdLw91tdmGYEJuz2btNNk+EK0SqNKtiRIsc/X8Sqt8sMt8aVF/Gc7j+LY1ylk
	 7HZ6io+wxO5RMIcoNwxA4/ETkns46adACfZvCj1ISZwoWZ+nHULM1FGcTKxYaF2AmV
	 MFbOioR9yCdxQqDZYDVfUUDeSlMeH/60/+ktS/iLkjNTbM2uXm+Bh1UIpxMDZ91XSz
	 DOnOhvjdIvbV2Bj9OV1IiijQQUDcoNNbXYDvXun2b238z9O7azGVMOxn+ijz+8xHIw
	 AjRDsKNGMZJzPMo2CFDUJKePPdQ89plyNPANEoyLr6SW+iqqmgHWWKQSvwYqYTNN0v
	 HDjzLJ6QtrMLg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7E04440731;
	Thu, 29 Oct 2026 05:10:15 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id C4303DD7
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 05:10:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id B694A40731
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 05:10:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id oO4IrH1jEU0n for <u-boot@lists.u-boot-project.org>;
 Thu, 29 Oct 2026 05:10:12 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org F1BAC40786
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=165.173.180.15
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793250612;
 b=sXk9R/lvEBlFhQjo1rcDOzAbFMkk2GFs+2HlaXqol2xUurOVg+kkbOS6qDYMIaOAwsIj
 ptYY2WpvSViP5nfhg8uVHE2cT3njNmdcx1P6mORUOMYVteDvppomYj/34gf6u1lK8BgKL
 8fQRassrv2AklJVeDFJ4s2H7Eu0GFOPBO8WcO6gFxm7FnY9Ue8RKxof32dmAtsLkvY4YW
 58aXgQgS3VpCAMM1KKyYIWWJg6hNf3u41z1kuyUaLtNS/QMC67e3TKeRhsQqDpXVexO1l
 H+8V5Xl1gqQ3TuNwHZ5C+nIwPOsADcsQwPIg6Wd4jaiDzVqzpSPbthjCIqRiWQMgUdg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793250612;
 h=Received-SPF:DKIM-Signature:Received:From:To:Cc:Subject:Date:
 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:X-ZohoMailClient;
 bh=rmu/xAAL4MrODGlzPpP6bPv8PFUKlCXBGE4FGfSU518=;
 b=ic9TlAdkdzq8FfeJf8e4R5bO440CVhVfZn/dWbzDvIwpzYarGn4OFJ16B9jZZ9XppuPs
 l7xbeKUpKgD5tuoRFnwDCNqo8mTa9G00TDeOlrHBKQUXGQqS0TJWlw9xxd4S1iFjFgLR8
 6oaxGMVNmarZguTJM0haPNysnIf4MpVQBw6eq2DMC+fuN92y+GuG9S16Nyq+eimAVt9fN
 WlrUBG9Ce/nVXRfAMhejqrtqip58qLOrcduSxhmHednP+46V+haf72aD/9Eb8HEjDYR7T
 02bpRG+EzicqoHf3rmFZ3Uj9Y9uDVTvsxDpdK3lnWuA4sGvnosfyvojsyXHoIVHFHuw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
 dmarc=pass header.from=ziyao.cc;
 dkim=pass header.d=ziyao.cc header.i=@ziyao.cc header.a=rsa-sha256
 header.s=zmail header.b=AWYRqgMB; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.180.15
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=165.173.180.15;
 helo=sender6-op-o15.zoho.com; envelope-from=me@ziyao.cc; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=ziyao.cc
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=ziyao.cc header.i=@ziyao.cc
 header.a=rsa-sha256 header.s=zmail header.b=AWYRqgMB
Received: from sender6-op-o15.zoho.com (sender6-op-o15.zoho.com
 [165.173.180.15])
 by smtp4.osuosl.org (Postfix) with ESMTPS id F1BAC40786
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 05:10:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1793250605; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=YSe5YhMsOnUn3FHXBLH8F2ElkGzpPuzF0xDG1HxSC9UBwsLJ54C5AeM2xXVG5GmpiP+b7kYyBj2ztQd1ojHT/sBvmHIFEbmxXKGxGWM+M8sjOf+2QTYXL9Q1n4em7L7GJU6qhqoCnXr9aJT6/OjVbPHwJC/OWWbYfyrcfL8q7hQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1793250605;
 h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=rmu/xAAL4MrODGlzPpP6bPv8PFUKlCXBGE4FGfSU518=; 
 b=e9193RNR8Lq8G1kUlbEzWKmLPzF7yIn+g3wjidn/JPC4j2QV7peJfTZYRx5Ztvqjzrn+pKxpDe3z/DTrWmEucg/rKDsU+Y3WX0GSOis6QJ8dMSLyfuOpXSBcp2O9bL3TnmfGykYxEe7bRRaQniEk+JiXigAe4a6iP4nuIarUIKc=
ARC-Authentication-Results: i=1; mx.zohomail.com; dkim=pass  header.i=ziyao.cc;
 spf=pass  smtp.mailfrom=me@ziyao.cc;
 dmarc=pass header.from=<me@ziyao.cc>
DKIM-Signature: a=rsa-sha256;
 b=AWYRqgMBwCxXQwJGQyomlzkSlZhKENKkyjEZoLJM6XnkFRzrm5mgOmYKg2kMSCAlK/7VlsIlOaWM6j8KPDxdysKeQel1zCcPnojBSfQcvLpgYM/uLN1aIaxf80VvReAPLtGU07dDX1rqgN9uf1swaCIErCuR9+fmm9bNzoCcIek=;
 c=relaxed/relaxed; s=zmail; d=ziyao.cc; v=1;
 bh=rmu/xAAL4MrODGlzPpP6bPv8PFUKlCXBGE4FGfSU518=;
 h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 1793250603427685.3169015892639;
 Wed, 28 Oct 2026 22:10:03 -0700 (PDT)
From: Yao Zi <me@ziyao.cc>
To: Tom Rini <trini@konsulko.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 u-boot@lists.u-boot-project.org
Cc: Yao Zi <me@ziyao.cc>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH v6 13/20] cpu: Add loongarch_cpu driver
Date: Thu, 29 Oct 2026 05:07:30 +0000
Message-ID: <20261029050738.1107663-14-me@ziyao.cc>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261029050738.1107663-1-me@ziyao.cc>
References: <20261029050738.1107663-1-me@ziyao.cc>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-16.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Jiaxun Yang <jiaxun.yang@flygoat.com>

Implement a driver for LoongArch CPU solely for gathering
some information bits from FDT and CPU level config registers.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
Signed-off-by: Yao Zi <me@ziyao.cc>
Reviewed-by: Simon Glass <sjg@chromium.org>
---

No changes since v5

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
2.56.0

