Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F572C4167B
	for <u-boot@archiver.kernel.org>; Tue, 28 Nov 2023 06:43:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 990AA87569;
	Tue, 28 Nov 2023 07:43:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8A4BB87579; Tue, 28 Nov 2023 07:43:14 +0100 (CET)
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
 by phobos.denx.de (Postfix) with ESMTP id 224858755D
 for <u-boot@lists.denx.de>; Tue, 28 Nov 2023 07:43:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=starfivetech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kuanlim.lee@starfivetech.com
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
 by ex01.ufhost.com (Postfix) with ESMTP id 90DC124E16E
 for <u-boot@lists.denx.de>; Tue, 28 Nov 2023 14:43:09 +0800 (CST)
Received: from EXMBX066.cuchost.com (172.16.7.66) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Tue, 28 Nov
 2023 14:43:09 +0800
Received: from localhost.localdomain (202.188.176.82) by EXMBX066.cuchost.com
 (172.16.6.66) with Microsoft SMTP Server (TLS) id 15.0.1497.42;
 Tue, 28 Nov 2023 14:43:07 +0800
From: Kuan Lim Lee <kuanlim.lee@starfivetech.com>
To: <u-boot@lists.denx.de>
CC: <cheehong.ang@starfivetech.com>, Kuan Lim Lee
 <kuanlim.lee@starfivetech.com>, Wei Liang Lim <weiliang.lim@starfivetech.com>
Subject: [PATCH v2] timer: starfive: Add Starfive timer support
Date: Tue, 28 Nov 2023 14:42:33 +0800
Message-ID: <20231128064254.635-1-kuanlim.lee@starfivetech.com>
X-Mailer: git-send-email 2.42.0.windows.2
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [202.188.176.82]
X-ClientProxiedBy: EXCAS064.cuchost.com (172.16.6.24) To EXMBX066.cuchost.com
 (172.16.6.66)
X-YovoleRuleAgent: yovoleflag
Content-Transfer-Encoding: quoted-printable
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

Add timer driver in Starfive SoC. It is an timer that outside
of CPU core and inside Starfive SoC.

Signed-off-by: Kuan Lim Lee <kuanlim.lee@starfivetech.com>
Signed-off-by: Wei Liang Lim <weiliang.lim@starfivetech.com>

Changes for v2:
- correct driver name, comment, variable
---
 drivers/timer/Kconfig          |  7 +++
 drivers/timer/Makefile         |  1 +
 drivers/timer/starfive-timer.c | 96 ++++++++++++++++++++++++++++++++++
 3 files changed, 104 insertions(+)
 create mode 100644 drivers/timer/starfive-timer.c

diff --git a/drivers/timer/Kconfig b/drivers/timer/Kconfig
index 915b2af160..a98be9dfae 100644
--- a/drivers/timer/Kconfig
+++ b/drivers/timer/Kconfig
@@ -326,4 +326,11 @@ config XILINX_TIMER
 	  Select this to enable support for the timer found on
 	  any Xilinx boards (axi timer).
=20
+config STARFIVE_TIMER
+	bool "Starfive timer support"
+	depends on TIMER
+	help
+	  Select this to enable support for the timer found on
+	  Starfive SoC.
+
 endmenu
diff --git a/drivers/timer/Makefile b/drivers/timer/Makefile
index 1ca74805fd..1ef814970b 100644
--- a/drivers/timer/Makefile
+++ b/drivers/timer/Makefile
@@ -34,3 +34,4 @@ obj-$(CONFIG_MTK_TIMER)		+=3D mtk_timer.o
 obj-$(CONFIG_MCHP_PIT64B_TIMER)	+=3D mchp-pit64b-timer.o
 obj-$(CONFIG_IMX_GPT_TIMER)	+=3D imx-gpt-timer.o
 obj-$(CONFIG_XILINX_TIMER)	+=3D xilinx-timer.o
+obj-$(CONFIG_STARFIVE_TIMER)	+=3D starfive-timer.o
diff --git a/drivers/timer/starfive-timer.c b/drivers/timer/starfive-time=
r.c
new file mode 100644
index 0000000000..b9ba33277e
--- /dev/null
+++ b/drivers/timer/starfive-timer.c
@@ -0,0 +1,96 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright 2022 StarFive, Inc. All rights reserved.
+ *   Author: Kuan Lim Lee <kuanlim.lee@starfivetech.com>
+ */
+
+#include <common.h>
+#include <clk.h>
+#include <dm.h>
+#include <time.h>
+#include <timer.h>
+#include <asm/io.h>
+#include <dm/device-internal.h>
+#include <linux/err.h>
+
+#define	STF_TIMER_INT_STATUS	0x00
+#define STF_TIMER_CTL		0x04
+#define STF_TIMER_LOAD		0x08
+#define STF_TIMER_ENABLE	0x10
+#define STF_TIMER_RELOAD	0x14
+#define STF_TIMER_VALUE		0x18
+#define STF_TIMER_INT_CLR	0x20
+#define STF_TIMER_INT_MASK	0x24
+
+struct starfive_timer_priv {
+	void __iomem *base;
+	u32 timer_size;
+};
+
+static u64 notrace starfive_get_count(struct udevice *dev)
+{
+	struct starfive_timer_priv *priv =3D dev_get_priv(dev);
+
+	/* Read decrement timer value and convert to increment value */
+	return priv->timer_size - readl(priv->base + STF_TIMER_VALUE);
+}
+
+static const struct timer_ops starfive_ops =3D {
+	.get_count =3D starfive_get_count,
+};
+
+static int starfive_probe(struct udevice *dev)
+{
+	struct timer_dev_priv *uc_priv =3D dev_get_uclass_priv(dev);
+	struct starfive_timer_priv *priv =3D dev_get_priv(dev);
+	int timer_channel;
+	struct clk clk;
+	int ret;
+
+	priv->base =3D dev_read_addr_ptr(dev);
+	if (!priv->base)
+		return -EINVAL;
+
+	timer_channel =3D dev_read_u32_default(dev, "channel", 0);
+	priv->base =3D priv->base + (0x40 * timer_channel);
+
+	/* Get clock rate from channel selectecd*/
+	ret =3D clk_get_by_index(dev, timer_channel, &clk);
+	if (ret)
+		return ret;
+
+	ret =3D clk_enable(&clk);
+	if (ret)
+		return ret;
+	uc_priv->clock_rate =3D clk_get_rate(&clk);
+
+	/*
+	 * Initiate timer, channel 0
+	 * Unmask Interrupt Mask
+	 */
+	writel(0, priv->base + STF_TIMER_INT_MASK);
+	/* Single run mode Setting */
+	if (dev_read_bool(dev, "single-run"))
+		writel(1, priv->base + STF_TIMER_CTL);
+	/* Set Reload value */
+	priv->timer_size =3D dev_read_u32_default(dev, "timer-size", -1U);
+	writel(priv->timer_size, priv->base + STF_TIMER_LOAD);
+	/* Enable to start timer */
+	writel(1, priv->base + STF_TIMER_ENABLE);
+
+	return 0;
+}
+
+static const struct udevice_id starfive_ids[] =3D {
+	{ .compatible =3D "starfive,jh8100-timers" },
+	{ }
+};
+
+U_BOOT_DRIVER(jh8100_starfive_timer) =3D {
+	.name		=3D "starfive_timer",
+	.id		=3D UCLASS_TIMER,
+	.of_match	=3D starfive_ids,
+	.probe		=3D starfive_probe,
+	.ops		=3D &starfive_ops,
+	.priv_auto	=3D sizeof(struct starfive_timer_priv),
+};
--=20
2.34.1

