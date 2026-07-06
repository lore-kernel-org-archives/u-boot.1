Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F579C43458
	for <u-boot@archiver.kernel.org>; Mon,  6 Jul 2026 13:04:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 15E598490A;
	Mon,  6 Jul 2026 15:04:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=etu.esisar.grenoble-inp.fr
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=etu.esisar.grenoble-inp.fr header.i=@etu.esisar.grenoble-inp.fr header.b="nMZYWfB+";
	dkim=pass (1024-bit key) header.d=etu.esisar.grenoble-inp.fr header.i=@etu.esisar.grenoble-inp.fr header.b="ZgPmzurs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B7C3B807C4; Mon,  6 Jul 2026 10:35:36 +0200 (CEST)
Received: from mx1.esisar.grenoble-inp.fr (mx1.esisar.grenoble-inp.fr
 [195.220.36.33])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4925B80398
 for <u-boot@lists.denx.de>; Mon,  6 Jul 2026 10:35:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=etu.esisar.grenoble-inp.fr
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=theodore.oviguian@etu.esisar.grenoble-inp.fr
Received: from mx1.esisar.grenoble-inp.fr (localhost [127.0.0.1])
 by mx1.esisar.grenoble-inp.fr (Postfix) with ESMTPS id 53D982240F7;
 Mon,  6 Jul 2026 10:35:33 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by mx1.esisar.grenoble-inp.fr (Postfix) with ESMTP id 3B26B2240F8;
 Mon,  6 Jul 2026 10:35:33 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mx1.esisar.grenoble-inp.fr 3B26B2240F8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=etu.esisar.grenoble-inp.fr;
 s=29808A28-1FE8-11E5-B58B-F10B7632C813; t=1783326933;
 bh=Uo0+i1X+yFwHR8Qty62u7ivEl2b2U/glv5g44DExwbE=;
 h=From:To:Date:Message-ID:MIME-Version;
 b=nMZYWfB+usbSClxYo6eeX3UTzDul11Yktb9kLM5neqBwTAX3Hx2NASIzoEKZFb2oX
 GcqGB6ojCJSYr4DDjgnHG+k8qGcb2HHz5lG12T+jXKmidbEcAEp0JfajLXSvvFugm8
 0AYe+wWhxr/JHM9SJ6ExeTMQsSPW1iY8DuxGuNmc=
Received: from mx1.esisar.grenoble-inp.fr ([127.0.0.1])
 by localhost (mx1.esisar.grenoble-inp.fr [127.0.0.1]) (amavis, port 10026)
 with ESMTP id lD3bjXnSiHHm; Mon,  6 Jul 2026 10:35:33 +0200 (CEST)
Received: from srv-zimbra.esisar.grenoble-inp.fr (unknown [172.21.100.139])
 by mx1.esisar.grenoble-inp.fr (Postfix) with ESMTPS id 113462240F7;
 Mon,  6 Jul 2026 10:35:33 +0200 (CEST)
Received: from srv-zimbra.esisar.grenoble-inp.fr (localhost [127.0.0.1])
 by srv-zimbra.esisar.grenoble-inp.fr (Postfix) with ESMTPS id 053046E1029;
 Mon,  6 Jul 2026 10:35:33 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by srv-zimbra.esisar.grenoble-inp.fr (Postfix) with ESMTP id F344F6E0B25;
 Mon,  6 Jul 2026 10:35:32 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.10.3 srv-zimbra.esisar.grenoble-inp.fr
 F344F6E0B25
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=etu.esisar.grenoble-inp.fr;
 s=29808A28-1FE8-11E5-B58B-F10B7632C813; t=1783326932;
 bh=Uo0+i1X+yFwHR8Qty62u7ivEl2b2U/glv5g44DExwbE=;
 h=From:To:Date:Message-ID:MIME-Version;
 b=ZgPmzursRxJKxxZwgHW/efbUodD2pqcdOchpxyJmhqQBCLs5sOlXR2qmG0193U0S3
 TBn4Ova9uTZeGiL8Ju/IVmkeN6FpmRIqumNuILsv7juUeUeevKklO8Yx6LxkFEm5Al
 HUvfRMUwJlJzGwTpsgXiPJQiCIX9ROyMcZ2LJGGk=
Received: from srv-zimbra.esisar.grenoble-inp.fr ([127.0.0.1])
 by localhost (srv-zimbra.esisar.grenoble-inp.fr [127.0.0.1]) (amavis,
 port 10026)
 with ESMTP id fX6CtpB1iNiS; Mon,  6 Jul 2026 10:35:32 +0200 (CEST)
Received: from Ubuntu.eur.gad.schneider-electric.com
 (96.169.185.81.rev.sfr.net [81.185.169.96])
 by srv-zimbra.esisar.grenoble-inp.fr (Postfix) with ESMTPSA id 99F246E1598;
 Mon,  6 Jul 2026 10:35:32 +0200 (CEST)
From: theodore.oviguian@etu.esisar.grenoble-inp.fr
To: u-boot@lists.denx.de
Cc: Theodore Oviguian <theodore.oviguian@etu.esisar.grenoble-inp.fr>,
 Theodore Oviguian <theodore.oviguian@se.com>,
 Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>,
 Neha Malcom Francis <n-francis@ti.com>
Subject: [PATCH v2 1/3] ti_pwm: Add EHRPWM TBCLK clock driver
Date: Mon,  6 Jul 2026 08:35:00 +0000
Message-ID: <20260706083507.18386-2-theodore.oviguian@etu.esisar.grenoble-inp.fr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260706083507.18386-1-theodore.oviguian@etu.esisar.grenoble-inp.fr>
References: <20260706083507.18386-1-theodore.oviguian@etu.esisar.grenoble-inp.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Mon, 06 Jul 2026 15:04:38 +0200
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

From: Theodore Oviguian <theodore.oviguian@etu.esisar.grenoble-inp.fr>

Add a TI eHRPWM TBCLK clock driver
TBCLK provides the input clock required by all eHRPWM instances, so this
clock must be enabled before eHRPWM can operate

Signed-off-by: Theodore Oviguian <theodore.oviguian@se.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: Lukasz Majewski <lukma@denx.de>
Cc: Neha Malcom Francis <n-francis@ti.com>
---

(Change : remove unused macro, comply with the U-Boot coding style : use
u32 instead og uint32_t & remove trailing whitespace)
I decide to let EHRPWM_TBCLK help comment on one line to comply with the
Kconfig file style and because I think there was nothing more the=20
say in it

 drivers/clk/ti/Kconfig        |  7 ++++
 drivers/clk/ti/Makefile       |  1 +
 drivers/clk/ti/ehrpwm-tbclk.c | 66 +++++++++++++++++++++++++++++++++++
 3 files changed, 74 insertions(+)
 create mode 100644 drivers/clk/ti/ehrpwm-tbclk.c

diff --git a/drivers/clk/ti/Kconfig b/drivers/clk/ti/Kconfig
index 3b995ab8f47..937f586706d 100644
--- a/drivers/clk/ti/Kconfig
+++ b/drivers/clk/ti/Kconfig
@@ -83,3 +83,10 @@ config SPL_CLK_K3
 	depends on CLK && SPL
 	help
 	  Enables the clock translation layer from DT to device clocks.
+
+config EHRPWM_TBCLK
+	bool "Clock support for TI AM6X EHRPWM"
+	depends on ARCH_K3 && CLK
+	default y if PWM_TI_EHRPWM
+	help
+	  Enables clock support for TI AM6X pwms.
diff --git a/drivers/clk/ti/Makefile b/drivers/clk/ti/Makefile
index 74e4329a343..2c685224e7d 100644
--- a/drivers/clk/ti/Makefile
+++ b/drivers/clk/ti/Makefile
@@ -13,3 +13,4 @@ obj-$(CONFIG_CLK_TI_OMAP4_CM) +=3D omap4-cm.o
 obj-$(CONFIG_CLK_TI_SCI) +=3D clk-sci.o
 obj-$(CONFIG_$(PHASE_)CLK_K3_PLL) +=3D clk-k3-pll.o
 obj-$(CONFIG_$(PHASE_)CLK_K3) +=3D clk-k3.o
+obj-$(CONFIG_EHRPWM_TBCLK) +=3D ehrpwm-tbclk.o
diff --git a/drivers/clk/ti/ehrpwm-tbclk.c b/drivers/clk/ti/ehrpwm-tbclk.=
c
new file mode 100644
index 00000000000..d03c009027a
--- /dev/null
+++ b/drivers/clk/ti/ehrpwm-tbclk.c
@@ -0,0 +1,66 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ *
+ * Copyright (C) 2026 Schneider Electric - https://se.com
+ *	Th=C3=A9odore Oviguian <theodore.oviguian@se.com>
+ */
+#include <clk-uclass.h>
+#include <dm.h>
+#include <asm/io.h>
+#include <stdint.h>
+
+static int ehrpwm_tbclk_enable(struct clk *clk)
+{
+	fdt_addr_t reg =3D dev_read_addr(clk->dev);
+	u32 reg_val =3D readl(reg);
+
+	reg_val |=3D BIT(clk->id);
+
+	writel(reg_val, reg);
+
+	return 0;
+}
+
+static int ehrpwm_tbclk_disable(struct clk *clk)
+{
+	fdt_addr_t reg =3D dev_read_addr(clk->dev);
+	u32 reg_val =3D readl(reg);
+
+	reg_val &=3D ~BIT(clk->id);
+
+	writel(reg_val, reg);
+
+	return 0;
+}
+
+static ulong ehrpwm_tbclk_get_rate(struct clk *clk)
+{
+	return 0;
+}
+
+static struct clk_ops ehrpwm_tbclk_ops =3D {
+	.enable =3D ehrpwm_tbclk_enable,
+	.disable =3D ehrpwm_tbclk_disable,
+	.get_rate =3D ehrpwm_tbclk_get_rate,
+};
+
+static const struct udevice_id ehrpwm_tbclk_ids[] =3D {
+	{ .compatible =3D "ti,am654-ehrpwm-tbclk" },
+	{ .compatible =3D "ti,am64-epwm-tbclk" },
+	{ .compatible =3D "ti,am62-epwm-tbclk" },
+	{ /* sentinel */ }
+};
+
+static int ehrpwm_tbclk_probe(struct udevice *dev)
+{
+	return 0;
+}
+
+U_BOOT_DRIVER(ehrpwm_tbclk) =3D {
+	.name =3D "ehrpwm_tbclk",
+	.id =3D UCLASS_CLK,
+	.of_match =3D ehrpwm_tbclk_ids,
+	.ops =3D &ehrpwm_tbclk_ops,
+	.probe =3D ehrpwm_tbclk_probe,
+	.priv_auto	=3D 0,
+};
--=20
2.43.0

