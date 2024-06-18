Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E35B5C2BA18
	for <u-boot@archiver.kernel.org>; Tue, 18 Jun 2024 13:57:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3CEBA882EF;
	Tue, 18 Jun 2024 15:56:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=flygoat.com header.i=@flygoat.com header.b="HMqghj3k";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="SVnqedVq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0A6508786C; Tue, 18 Jun 2024 15:56:38 +0200 (CEST)
Received: from wfhigh8-smtp.messagingengine.com
 (wfhigh8-smtp.messagingengine.com [64.147.123.159])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DE281883CF
 for <u-boot@lists.denx.de>; Tue, 18 Jun 2024 15:56:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jiaxun.yang@flygoat.com
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
 by mailfhigh.west.internal (Postfix) with ESMTP id 14BEA18000CC;
 Tue, 18 Jun 2024 09:56:34 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute2.internal (MEProxy); Tue, 18 Jun 2024 09:56:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1718718993;
 x=1718805393; bh=OfPKRMn+ahQ0j9YZ0pacxctgLf/LarNUvDltYQ3U/mI=; b=
 HMqghj3k2WegIRqDuFt2oZLDV0ISuTrSugXnNZpcZi26jc3OD8osl2UPDf/8wLMh
 9yQHGPclaop4GKLoQs8/rbeEdDr+1IQoPjng6y+Gb7I9WmvEcxNE7FBCsw6o37E5
 dJOVT0X+XDTlpCIa/1Dj+5GijZ4vqVaBxY/Kp3IiIBqZbaLK1bbMujAdg3YqCB4s
 95vGlDnKAyMnegklEPJb1GwPQ5h5zA0e6MdJ3B3H1vyTMpl6dmVPZtwDO9O449fq
 D7/uy8Oe3LzYwu9m9d8rF33/pnTxIMKT+TqhsVBFUhUjWmhSBUQ/YON7br0d76Tq
 rUBIGA7U8HGqprs5ZL1C4Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1718718993; x=
 1718805393; bh=OfPKRMn+ahQ0j9YZ0pacxctgLf/LarNUvDltYQ3U/mI=; b=S
 VnqedVqecpp/GITeHmewrhi0yQLF5UdZUHGhSV7gcf/HTKSswsHvdAVkW3oAguVr
 tc70zEV1j/OHvZvZnsWsDj9Jz6KRo3tlOPqLyPQPpwiz8XvWclFszt1GIXjs8cFz
 wtlVVEEnbGTYVIddbipm6anVX79Y9GEacDjybSbRauro9A3bfnJ74U3aFOryk+IO
 nnzmdqjqFDun/ZdZPzvK3YgyhxQKDtMkxRsiDD86qayLhSohB1df9kCc5E4tyvlW
 sNoQkTTxPie/XDIk5xFURpIpLyyEIMjhuroH1H7+kLcwVDC+d0ga+m2f921GGo8v
 h4+3e+fRWXY2zUlVcRw3A==
X-ME-Sender: <xms:EZJxZnxZSAFFeXLEAk-tflNuOMvBmIq40_8ewQxVT-cBRugezFrNLw>
 <xme:EZJxZvSdedq1WuHm7IKfqrtiQVfR4E3reZO9asAQQ7uhMim6wkj4BQwsWLdEeTDMm
 nxj4u3lq5jyCKMjPoo>
X-ME-Received: <xmr:EZJxZhXRAXahHYQGxqu2wM62wvEClz9WUBLmLi1zYuJFDW77vAtsk-w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfedvkedggeduucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpeflihgr
 gihunhcujggrnhhguceojhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomheqne
 cuggftrfgrthhtvghrnhepvdekiefhfeevkeeuveetfeelffekgedugefhtdduudeghfeu
 veegffegudekjeelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilh
 hfrhhomhepjhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomh
X-ME-Proxy: <xmx:EZJxZhhQ3hqVMFQ5I49dVULU4MFngkveGhieBKFae9_8HksqqcrvEw>
 <xmx:EZJxZpBuAQ_SHSjXbjBDtk72kMA3phiZjii3dUN0lfyPxn_dsPnBJQ>
 <xmx:EZJxZqIPmPq8Hy9X7SOdiA8vbS1qzPznKQoIk64AJjUc_0yfzjlQDw>
 <xmx:EZJxZoDFv6h0pZ7F04wPjl4IuYa3jMnJXYT-NtwEiMRJPxuSBhbr9Q>
 <xmx:EZJxZr0Vr5tm-YqlqyXHGsdEguzY0PilALGQoTvDuZ7L4vQvxwBo0heH>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 18 Jun 2024 09:56:32 -0400 (EDT)
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
Date: Tue, 18 Jun 2024 14:56:07 +0100
Subject: [PATCH v3 07/12] drivers: cpu: Add xtensa CPU driver
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240618-qemu-xtensa-v3-7-f5af5e6fdd23@flygoat.com>
References: <20240618-qemu-xtensa-v3-0-f5af5e6fdd23@flygoat.com>
In-Reply-To: <20240618-qemu-xtensa-v3-0-f5af5e6fdd23@flygoat.com>
To: u-boot@lists.denx.de, Sean Anderson <sean.anderson@seco.com>
Cc: Max Filippov <jcmvbkbc@gmail.com>, Tom Rini <trini@konsulko.com>, 
 Sumit Garg <sumit.garg@linaro.org>, Jiaxun Yang <jiaxun.yang@flygoat.com>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4089;
 i=jiaxun.yang@flygoat.com; h=from:subject:message-id;
 bh=+1HelshC7SNHRzFrQAT5P+DlOpo60ivAMc2qv0Gjq6A=;
 b=owGbwMvMwCXmXMhTe71c8zDjabUkhrTCSYxbjrs/dXzO9axHrfHY35X+m4KXvvLiNs/teuf6o
 G7BfBf9jlIWBjEuBlkxRZYQAaW+DY0XF1x/kPUHZg4rE8gQBi5OAZhISRYjQ6P5vtWHk/iv8nac
 brr68tbiP3cskl0vXE26G1bsMJe17g8jw9zvh7Z8Zj4x0WDKI0+lrVsfpEc+79FVM2rZsfCq0tE
 cORYA
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

Tested-by: Max Filippov <jcmvbkbc@gmail.com>
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

