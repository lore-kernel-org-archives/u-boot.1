Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9514BC25B75
	for <u-boot@archiver.kernel.org>; Sun, 19 May 2024 20:55:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 82179882E2;
	Sun, 19 May 2024 22:54:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=flygoat.com header.i=@flygoat.com header.b="NuziRrUz";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="aYlUFidA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ADA958818C; Sun, 19 May 2024 22:54:02 +0200 (CEST)
Received: from fhigh6-smtp.messagingengine.com
 (fhigh6-smtp.messagingengine.com [103.168.172.157])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8C03288223
 for <u-boot@lists.denx.de>; Sun, 19 May 2024 22:54:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jiaxun.yang@flygoat.com
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
 by mailfhigh.nyi.internal (Postfix) with ESMTP id C3BE9114010A;
 Sun, 19 May 2024 16:53:59 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute7.internal (MEProxy); Sun, 19 May 2024 16:53:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1716152039;
 x=1716238439; bh=51v4K0P8EVsp0p7SnaIspIVQxfHxeWtRhsc3QAQXJ6s=; b=
 NuziRrUzdbvnd84wZkBZG9UwI0GlijkXXvGpMvZX/RyfMZgGw9kzxmL14FR5+U1u
 RptOsuDavlRFEzx3Ja13uE7e5ObVzk5KXlDpHMPESAfNh3ixukDbVMtZdHpfEnTf
 pp9SXMOwrVl1sFC5ED9PpVizQhlz6AdI4FUS1HRicWg4FDLOUgP3nwKSDNVmbH1K
 8NeiwpTEOyRR6XFG5gxYtwgDXEMQCvQVNAWAX0L5Ygql4L83fm1TSV4oMdxW+CgW
 pAYujS/yPQ8F/HxJCpnaM7zWUsqIgCgAakiYZYtDnPbV0jcWUNOuwJmb25WNfRPM
 d1RJm52e+bGTUAlEweIKaA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1716152039; x=
 1716238439; bh=51v4K0P8EVsp0p7SnaIspIVQxfHxeWtRhsc3QAQXJ6s=; b=a
 YlUFidASOg7k4ASLhWOM8QLtaWpjUPFQxkPTtenARakn+6BKdBoPN4pEcOXkbH0k
 bSTZ7iCUUTvZsM9nNYpkOixEt6Fpr3rB+KtRM3CtsSAHzqjbj0l7SycZXIFIp37J
 gIP9LkyiNFDWCWxePStz4RfJNCNMiZa6TYmX5yKavDEox3qQf9g6+vLDH63qYrse
 GKE5gZcuDfcPDhRwyv9w3DvNx2EBiB1W6SZokhSF4RAoRMtWYTWGN6KvB5YqSKQJ
 tMoSJAmCDPVGze/5sgT3Sas1MygXYtMpPTCHQSStxZyXDwj9pGCeCHoDt+F9yJGn
 jtTdZmA+I7eFj2TX8bwdg==
X-ME-Sender: <xms:52ZKZhztmzs35Kupia-Pn2990lALHqJ8fSEgXvJcgd2pBCj9_Pevjg>
 <xme:52ZKZhQ5MZ7Lc0-5GPNnq2R1ASIOPpXFUknwmMUSWmqk1YXLnsTQDFPLJcz9LA24z
 Gjncsa2yYAXhitrkUE>
X-ME-Received: <xmr:52ZKZrWdDYKuxutz3JvTxxwK3bPVvMq37Xg24W2JXHYBAJJBD3ukZoc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdehkedgudehvdcutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
 necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
 enucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheplfhi
 rgiguhhnucgjrghnghcuoehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhmqe
 enucggtffrrghtthgvrhhnpedvkeeihfefveekueevteefleffkeegudeghfdtuddugefh
 ueevgeffgedukeejleenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrih
 hlfhhrohhmpehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhm
X-ME-Proxy: <xmx:52ZKZjgwPDnWPoNcM23-FrEeDOU1iPFW4kckcAeBOILl9UJss7RVyw>
 <xmx:52ZKZjCc1rE43NDVOwc9_f2U-Few3tXBdVRiKocPFFJfNNJ7-UpeJQ>
 <xmx:52ZKZsI82qWzmmuqd-VI2MZHFTQ-Ia6AYi8NT5q6rrVhTERxwiEGIA>
 <xmx:52ZKZiC892HdSZKBzWsFJfNlXq7XCl97pSzEdpKKxKFwIjmjVABDuQ>
 <xmx:52ZKZl3RjvZ8ruZIds7DJqv1-MbrSEcd5mAiOQZEuNfsS40-3rZfQleN>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 19 May 2024 16:53:58 -0400 (EDT)
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
Date: Sun, 19 May 2024 21:53:54 +0100
Subject: [PATCH 07/10] drivers: cpu: Add xtensa CPU driver
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240519-qemu-xtensa-v1-7-8fff0cb11c19@flygoat.com>
References: <20240519-qemu-xtensa-v1-0-8fff0cb11c19@flygoat.com>
In-Reply-To: <20240519-qemu-xtensa-v1-0-8fff0cb11c19@flygoat.com>
To: u-boot@lists.denx.de, Sean Anderson <sean.anderson@seco.com>
Cc: Max Filippov <jcmvbkbc@gmail.com>, Tom Rini <trini@konsulko.com>, 
 Sumit Garg <sumit.garg@linaro.org>, Jiaxun Yang <jiaxun.yang@flygoat.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4043;
 i=jiaxun.yang@flygoat.com; h=from:subject:message-id;
 bh=Vj7K34xzk80p+hSGvzRVdiGlPDsc8x+UvGR796zCzTI=;
 b=owGbwMvMwCXmXMhTe71c8zDjabUkhjSvtHuuF/ZuftT8qf1n4tP/11kvb2Ztn3D0bN2zO+L3Z
 ScuNC5d1FHKwiDGxSArpsgSIqDUt6Hx4oLrD7L+wMxhZQIZwsDFKQATkV7K8N9XQTdNpU3TaEHl
 6cWfOiQVIg792Cx6kMnjxfZtt4tPHZ/C8Fd08jP+8hdGHr5a5cu5D0Qu//Po0/ekdeFpHyIOu97
 rKGMBAA==
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

