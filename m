Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 663E6C369C2
	for <u-boot@archiver.kernel.org>; Sun, 20 Apr 2025 11:58:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6F4C0820EA;
	Sun, 20 Apr 2025 13:58:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=openbsd.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; secure) header.d=kpnmail.nl header.i=@kpnmail.nl header.b="RGqSfRWr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DF1CC82140; Sun, 20 Apr 2025 13:58:23 +0200 (CEST)
Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.184])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9D7318212F
 for <u-boot@lists.denx.de>; Sun, 20 Apr 2025 13:58:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=openbsd.org
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=kettenis@openbsd.org
X-KPN-MessageId: de81d381-1dde-11f0-8ec8-005056994fde
Received: from smtp.kpnmail.nl (unknown [10.31.155.8])
 by ewsoutbound.so.kpn.org (Halon) with ESMTPS
 id de81d381-1dde-11f0-8ec8-005056994fde;
 Sun, 20 Apr 2025 13:59:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kpnmail.nl; s=kpnmail01;
 h=mime-version:message-id:date:subject:to:from;
 bh=Y8v9qPSAYI5I2oLk8LtqEbfWJ8ewF1GpAlEZZpOpsFA=;
 b=RGqSfRWrSteWXi1q2lAgo7D7a7fy7fNdyWBItwFs/g+mW/XphJ6T9afPqIpT53ypoxN+Cx1DS8ovC
 fXOfQzxgzgzGaUeV4erdmHP9y1bGt0eA/7G4BjfED7G9uuNDM4TKVKyHlI9SCaCmgUYQnbmce+REYN
 QVdAVJ8jLXX6lncQ=
X-KPN-MID: 33|M4vfHiFytjlim26hECf9qdNRO8gp12JC2rSvAw8T+IfyVWUatsuSzb6MWyVFLPs
 PhchbqRl0KeSt7ynURpobSTuMU5pjBQNDmDU46Tu/aPU=
X-KPN-VerifiedSender: No
X-CMASSUN: 33|2qcTS1eB179W2zLoODRUUAZHam38ZYdXs/MtPi238bVpUCX76V1k79MHaxdp0wY
 asaTOsT/aKF9FnQKkw5gkvg==
X-Originating-IP: 80.61.163.207
Received: from bizet.sibelius.xs4all.nl (80-61-163-207.fixed.kpn.net
 [80.61.163.207]) by smtp.xs4all.nl (Halon) with ESMTPSA
 id c12ee633-1dde-11f0-97e2-00505699d6e5;
 Sun, 20 Apr 2025 13:58:21 +0200 (CEST)
From: Mark Kettenis <kettenis@openbsd.org>
To: u-boot@lists.denx.de
Cc: kettenis@openbsd.org,
	trini@konsulko.com,
	marcan@marcan.st
Subject: [PATCH 3/6] arm: apple: rtkit: Add a generic RTKit helper driver
Date: Sun, 20 Apr 2025 13:58:05 +0200
Message-ID: <20250420115808.94272-4-kettenis@openbsd.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250420115808.94272-1-kettenis@openbsd.org>
References: <20250420115808.94272-1-kettenis@openbsd.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

From: Hector Martin <marcan@marcan.st>

This driver handles the MTP ASC coprocessor, which does not need any
special handling on the RTKit side and communicates out-of-band.

Signed-off-by: Hector Martin <marcan@marcan.st>
Signed-off-by: Mark Kettenis <kettenis@openbsd.org>
---
 arch/arm/include/asm/arch-apple/rtkit.h |  2 +
 arch/arm/mach-apple/Makefile            |  1 +
 arch/arm/mach-apple/rtkit_helper.c      | 97 +++++++++++++++++++++++++
 3 files changed, 100 insertions(+)
 create mode 100644 arch/arm/mach-apple/rtkit_helper.c

diff --git a/arch/arm/include/asm/arch-apple/rtkit.h b/arch/arm/include/asm/arch-apple/rtkit.h
index b795215feb7..1b6c6ccd821 100644
--- a/arch/arm/include/asm/arch-apple/rtkit.h
+++ b/arch/arm/include/asm/arch-apple/rtkit.h
@@ -29,3 +29,5 @@ int apple_rtkit_boot(struct apple_rtkit *rtk);
 int apple_rtkit_set_ap_power(struct apple_rtkit *rtk, int pwrstate);
 int apple_rtkit_poll(struct apple_rtkit *rtk, ulong timeout);
 int apple_rtkit_shutdown(struct apple_rtkit *rtk, int pwrstate);
+
+int apple_rtkit_helper_poll(struct udevice *dev, ulong timeout);
diff --git a/arch/arm/mach-apple/Makefile b/arch/arm/mach-apple/Makefile
index 50b465b9473..d79a3a69592 100644
--- a/arch/arm/mach-apple/Makefile
+++ b/arch/arm/mach-apple/Makefile
@@ -3,4 +3,5 @@
 obj-y += board.o
 obj-y += lowlevel_init.o
 obj-y += rtkit.o
+obj-$(CONFIG_APPLE_MTP_KEYB) += rtkit_helper.o
 obj-$(CONFIG_NVME_APPLE) += sart.o
diff --git a/arch/arm/mach-apple/rtkit_helper.c b/arch/arm/mach-apple/rtkit_helper.c
new file mode 100644
index 00000000000..3b755008195
--- /dev/null
+++ b/arch/arm/mach-apple/rtkit_helper.c
@@ -0,0 +1,97 @@
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+/*
+ * Copyright The Asahi Linux Contributors
+ */
+
+#include <dm.h>
+#include <mailbox.h>
+#include <mapmem.h>
+#include <reset.h>
+
+#include <asm/io.h>
+#include <asm/arch/rtkit.h>
+#include <linux/iopoll.h>
+
+/* ASC registers */
+#define REG_CPU_CTRL		0x0044
+#define  REG_CPU_CTRL_RUN	BIT(4)
+
+struct rtkit_helper_priv {
+	void *asc;		/* ASC registers */
+	struct mbox_chan chan;
+	struct apple_rtkit *rtk;
+};
+
+static int rtkit_helper_probe(struct udevice *dev)
+{
+	struct rtkit_helper_priv *priv = dev_get_priv(dev);
+	u32 ctrl;
+	int ret;
+
+	priv->asc = dev_read_addr_ptr(dev);
+	if (!priv->asc)
+		return -EINVAL;
+
+	ret = mbox_get_by_index(dev, 0, &priv->chan);
+	if (ret < 0)
+		return ret;
+
+	ctrl = readl(priv->asc + REG_CPU_CTRL);
+	writel(ctrl | REG_CPU_CTRL_RUN, priv->asc + REG_CPU_CTRL);
+
+	priv->rtk = apple_rtkit_init(&priv->chan, priv, NULL, NULL);
+	if (!priv->rtk)
+		return -ENOMEM;
+
+	ret = apple_rtkit_boot(priv->rtk);
+	if (ret < 0) {
+		printf("%s: Helper apple_rtkit_boot returned: %d\n", __func__, ret);
+		return ret;
+	}
+
+	ret = apple_rtkit_set_ap_power(priv->rtk, APPLE_RTKIT_PWR_STATE_ON);
+	if (ret < 0) {
+		printf("%s: Helper apple_rtkit_set_ap_power returned: %d\n", __func__, ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+static int rtkit_helper_remove(struct udevice *dev)
+{
+	struct rtkit_helper_priv *priv = dev_get_priv(dev);
+	u32 ctrl;
+
+	apple_rtkit_shutdown(priv->rtk, APPLE_RTKIT_PWR_STATE_QUIESCED);
+
+	ctrl = readl(priv->asc + REG_CPU_CTRL);
+	writel(ctrl & ~REG_CPU_CTRL_RUN, priv->asc + REG_CPU_CTRL);
+
+	apple_rtkit_free(priv->rtk);
+	priv->rtk = NULL;
+
+	return 0;
+}
+
+int apple_rtkit_helper_poll(struct udevice *dev, ulong timeout)
+{
+	struct rtkit_helper_priv *priv = dev_get_priv(dev);
+
+	return apple_rtkit_poll(priv->rtk, timeout);
+}
+
+static const struct udevice_id rtkit_helper_ids[] = {
+	{ .compatible = "apple,rtk-helper-asc4" },
+	{ /* sentinel */ }
+};
+
+U_BOOT_DRIVER(rtkit_helper) = {
+	.name = "rtkit_helper",
+	.id = UCLASS_MISC,
+	.of_match = rtkit_helper_ids,
+	.priv_auto = sizeof(struct rtkit_helper_priv),
+	.probe = rtkit_helper_probe,
+	.remove = rtkit_helper_remove,
+	.flags = DM_FLAG_OS_PREPARE,
+};
-- 
2.49.0

