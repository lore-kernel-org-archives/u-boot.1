Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45D15C25B79
	for <u-boot@archiver.kernel.org>; Wed, 22 May 2024 15:37:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2979A88892;
	Wed, 22 May 2024 17:35:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=flygoat.com header.i=@flygoat.com header.b="yeMBohqo";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="W6rDRzcf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E3EB28888F; Wed, 22 May 2024 17:35:33 +0200 (CEST)
Received: from wfout5-smtp.messagingengine.com
 (wfout5-smtp.messagingengine.com [64.147.123.148])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6488787D43
 for <u-boot@lists.denx.de>; Wed, 22 May 2024 17:35:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jiaxun.yang@flygoat.com
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
 by mailfout.west.internal (Postfix) with ESMTP id 97CF51C0007C;
 Wed, 22 May 2024 11:35:29 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute1.internal (MEProxy); Wed, 22 May 2024 11:35:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1716392129;
 x=1716478529; bh=fn1QyanIzbOtDTaN6iaMl7r+jZpcgqaEWNevdKz5mFE=; b=
 yeMBohqogdAfiO1J13mc/DmMdlGSOnNmci9oaC+r1zal488pvBnm/FrFx5soTAR/
 uKVgC24bC0nkVh+OUXP5OBVDGjGJ9cjZDDXT0LrDoTE94WjajOzfRzErUoAQBP4H
 o1J35eYQNwCDM3V4P7oc6IQ/49oK4rE348qPJYJdr6AV3KEFASr32m1SY/e6qQef
 svW1R88GqI2DCzjZXBnyIPcrgZtxgFFFTx/Wi+qzubG4ldEu3vUlRkidBc0Oe7Oe
 KEF1D59Xp/QdiY+DDuveK/XxQsr/MOh7zUTbHH9vFM3khmkYrhFkbIypg6EOFOty
 d26cI+1YUxlCj4Q9OkvVdQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1716392129; x=
 1716478529; bh=fn1QyanIzbOtDTaN6iaMl7r+jZpcgqaEWNevdKz5mFE=; b=W
 6rDRzcfVMFldVjwBPt4szkFTjoUVygqdblGNRV2PxDbRs04i/1UCzsx7emCMg40O
 SvdWb6f1l+1eZs7NfUnyoCnVd88b17LLzVNLewOXDFghtzI1oX4+ua0ltTY2XIqk
 XWL7o4ZpuawFK5CH0z9Gc/ZA+eUT3X3Q/zKciGaWcmBzet7DN4PWBsOED1dDn4Vf
 gzlpRK9e+SUk8kt7x8QfxTIIQrTAVmknpvSScNcovwCOsdtCGRzVjEBYXPknGgup
 dDniiqbSCMS4etAJ3tYOh04EQqsuf4FRH0QwypEDL6Crd1z2N2dnQEoNtRni4hy3
 K6+nhWSAA4AfmuGCyulGA==
X-ME-Sender: <xms:wRBOZlMKKXUIFnLz7_MV_i3b_jTzZsiYx4l1RxmHimcY04H1EwR5lA>
 <xme:wRBOZn8TOohYcpQiQIClSrLSSoSIt2jBc5q29tiNC8Qh9NsqBzIPY8WbZ-O1hY6X9
 kuehV6NOxXENMB3tXQ>
X-ME-Received: <xmr:wRBOZkS_skB1NIW2z-1UVEQxnpFSR0mnINEpoqCJtAhaE_f2f9BL3u8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdeigedgvdefucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpeflihgr
 gihunhcujggrnhhguceojhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomheqne
 cuggftrfgrthhtvghrnhepvdekiefhfeevkeeuveetfeelffekgedugefhtdduudeghfeu
 veegffegudekjeelnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilh
 hfrhhomhepjhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomh
X-ME-Proxy: <xmx:wRBOZhv0hbOy11No8blpCyxOqMEJ3t7UfU2FoH_Dd909X1pPow6dKQ>
 <xmx:wRBOZtf1gHhB8fiqff-Q1QhwHIZs3aFxTsWppKV_zweKQZzAsMfUvg>
 <xmx:wRBOZt1y4sA4pduKnz3fvmndzPknBcc9I_oCmD3b7-EeQFHtWPHJ-Q>
 <xmx:wRBOZp8H948Lrncl3C33zeKRC4POynt0v9QGrSF4OEKLhHYMJcsbBw>
 <xmx:wRBOZlSqiYoQaBEmUDU7E25gVAAKSZmgT9DCuTpXF_Cb37K3-9Tf7InP>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 22 May 2024 11:35:28 -0400 (EDT)
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
Date: Wed, 22 May 2024 16:34:55 +0100
Subject: [PATCH 12/16] cpu: Add loongarch_cpu driver
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240522-loongarch-v1-12-1407e0b69678@flygoat.com>
References: <20240522-loongarch-v1-0-1407e0b69678@flygoat.com>
In-Reply-To: <20240522-loongarch-v1-0-1407e0b69678@flygoat.com>
To: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.denx.de, Jiaxun Yang <jiaxun.yang@flygoat.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5130;
 i=jiaxun.yang@flygoat.com; h=from:subject:message-id;
 bh=mlfr1Xn0OUgVjqSpv9W5vPvX6oDnoMj9ChIAuqFEdjk=;
 b=owGbwMvMwCXmXMhTe71c8zDjabUkhjQ/geXhziJ27DIsIdd3acTdOdJ+mpX71v8bb6V60r2mn
 Z4sLb6wo5SFQYyLQVZMkSVEQKlvQ+PFBdcfZP2BmcPKBDKEgYtTACayNJzhn/VG1dkhUzV0rnn2
 PJx2lEn1YOTvRmbeI6tl2XhelWws5mb4p1O5XzYm0qPBYUvFH4H3u2zCul/sXR4/JeDgr+3ZrIf
 WsgAA
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

Implement a driver for LoongArch CPU solely for gathering
some information bits from FDT and CPU level config registers.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 drivers/cpu/Kconfig         |   6 ++
 drivers/cpu/Makefile        |   1 +
 drivers/cpu/loongarch_cpu.c | 148 ++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 155 insertions(+)

diff --git a/drivers/cpu/Kconfig b/drivers/cpu/Kconfig
index 1c3c810651ef..9cee9285194b 100644
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
index d4bbf6fa5e05..914819712f79 100644
--- a/drivers/cpu/Makefile
+++ b/drivers/cpu/Makefile
@@ -11,6 +11,7 @@ obj-$(CONFIG_ARCH_IMX8) += imx8_cpu.o
 obj-$(CONFIG_ARCH_AT91) += at91_cpu.o
 obj-$(CONFIG_ARCH_MEDIATEK) += mtk_cpu.o
 obj-$(CONFIG_CPU_IMX) += imx8_cpu.o
+obj-$(CONFIG_CPU_LOONGARCH) += loongarch_cpu.o
 obj-$(CONFIG_CPU_MPC83XX) += mpc83xx_cpu.o
 obj-$(CONFIG_CPU_RISCV) += riscv_cpu.o
 obj-$(CONFIG_CPU_MICROBLAZE) += microblaze_cpu.o
diff --git a/drivers/cpu/loongarch_cpu.c b/drivers/cpu/loongarch_cpu.c
new file mode 100644
index 000000000000..8ce6746054ff
--- /dev/null
+++ b/drivers/cpu/loongarch_cpu.c
@@ -0,0 +1,148 @@
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
+		int i;
+		char vendor_buf[9] = { 0 };
+		char name_buf[9] = { 0 };
+		u64 vendor = iocsr_read64(LOONGARCH_IOCSR_VENDOR);
+		u64 name = iocsr_read64(LOONGARCH_IOCSR_CPUNAME);
+
+		if (!vendor || !name)
+			goto get_desc_dt;
+
+		for (i = 0; i < sizeof(u64); i++) {
+			vendor_buf[i] = vendor & 0xff;
+			name_buf[i] = name & 0xff;
+			vendor >>= 8;
+			name >>= 8;
+		}
+
+		snprintf(buf, size, "%s-%s", vendor_buf, name_buf);
+
+		return 0;
+	}
+
+get_desc_dt:
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
+	if (ret == -ENOSYS || ret == -ENOTSUPP)
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
2.43.0

