Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 434A2CD5BA4
	for <u-boot@archiver.kernel.org>; Tue, 19 May 2026 13:01:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3DE41847F6;
	Tue, 19 May 2026 15:01:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=pigmoral.tech
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=pigmoral.tech header.i=junhui.liu@pigmoral.tech header.b="LgOMRVYR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A2AF5847F6; Tue, 19 May 2026 15:01:38 +0200 (CEST)
Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com
 [136.143.188.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5BA7A843B6
 for <u-boot@lists.denx.de>; Tue, 19 May 2026 15:01:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=pigmoral.tech
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=junhui.liu@pigmoral.tech
ARC-Seal: i=1; a=rsa-sha256; t=1779195691; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=gMnfNVtOoDYIXzNW34lZWUqxM2RJoR765MRgdrUpgrK4oQI6MisKf9U2+lpnrDzbruJXFYLjNF0/vL86AHl318labj+JSO8xmspfohitk8jhy0mk36QfmmZnxMkQey7rVcDk2wYqoxNyrfZoTI8V5Wnk3glWEUKPuOjJmrfNnBs=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1779195691;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=eydqakSw66RYx89Y4xHq/Fk+IdL8JivYOPY6QV4ys2w=; 
 b=BV1MNy6f2QlRB+c5MEWNJS3C4x+Qmp3oyWxqeTihFw3AFfHLBxlxe/mGyiPwZ3/qj5iXbpgLcPcgoqnzMfgHtcW7D0PUbForuzsqbKYdUZp7d9msSbunug6z3LcCRxdk0DulJqoJvIUpRK/DQ/ZwZT1KXQ/jgYd+K4mkiVHwK/Y=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=pigmoral.tech;
 spf=pass  smtp.mailfrom=junhui.liu@pigmoral.tech;
 dmarc=pass header.from=<junhui.liu@pigmoral.tech>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1779195691; 
 s=zmail; d=pigmoral.tech; i=junhui.liu@pigmoral.tech;
 h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:References:In-Reply-To:To:To:Cc:Cc:Reply-To;
 bh=eydqakSw66RYx89Y4xHq/Fk+IdL8JivYOPY6QV4ys2w=;
 b=LgOMRVYRzx9+kP4oVXHDVaj8Pgv2XYgVqLr9sW+Lwk/jRLgQZwoWv6yQOejukFO1
 mJRgpTmOj8SQDigC12QrpOJNLh1GxR9db7zQUjdXHbN4Oxs4SuNNXifaNtj+LcntE8x
 jCFh1KYzaTj/8uZCG907dKSxIf7OerePP+McHZCc=
Received: by mx.zohomail.com with SMTPS id 1779195689249679.8142751247705;
 Tue, 19 May 2026 06:01:29 -0700 (PDT)
From: Junhui Liu <junhui.liu@pigmoral.tech>
Date: Tue, 19 May 2026 20:58:29 +0800
Subject: [PATCH 2/5] arm: mach-sunxi: add syscon driver for system-control
 nodes
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260519-a5e-gmac1-v1-2-c3117603b9fb@pigmoral.tech>
References: <20260519-a5e-gmac1-v1-0-c3117603b9fb@pigmoral.tech>
In-Reply-To: <20260519-a5e-gmac1-v1-0-c3117603b9fb@pigmoral.tech>
To: u-boot@lists.denx.de
Cc: Andre Przywara <andre.przywara@arm.com>, Tom Rini <trini@konsulko.com>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Paul Kocialkowski <contact@paulk.fr>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>, 
 Mikhail Kalashnikov <iuncuim@gmail.com>, 
 Cody Eksal <masterr3c0rd@epochal.quest>, 
 Jerome Forissier <jerome.forissier@arm.com>, 
 Christian Marangi <ansuelsmth@gmail.com>, 
 Peter Robinson <pbrobinson@gmail.com>, 
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>, 
 Robert Marko <robert.marko@sartura.hr>, Yao Zi <me@ziyao.cc>, 
 Leo Yu-Chi Liang <ycliang@andestech.com>, Jonas Karlman <jonas@kwiboo.se>, 
 Kever Yang <kever.yang@rock-chips.com>, 
 Lukas Schmid <lukas.schmid@netcube.li>, Lukasz Majewski <lukma@denx.de>, 
 Paul Kocialkowski <paulk@sys-base.io>, 
 Junhui Liu <junhui.liu@pigmoral.tech>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779195642; l=3018;
 i=junhui.liu@pigmoral.tech; s=20251228; h=from:subject:message-id;
 bh=+u/hRJPU8V/DTwZIfQ8v2h+u7zJV2gN5uJdM+HITu6o=;
 b=pBZrC+o9JfEhzbtKKPhwVxxJ31XRttp0w6Gau0+lFSwni7QnIUNwNAlReon56j4NinCW6p+Lk
 mgQH3Cmf5PjCPm3M/S6Bb8zQy+MvaISxThsbTpVi1xLPIIbn2fGUQF/
X-Developer-Key: i=junhui.liu@pigmoral.tech; a=ed25519;
 pk=3vU0qIPJAH8blXmLyqBhKx+nLOjcLwwYhZXelEpw7h4=
X-ZohoMailClient: External
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

The upstream Linux kernel relies on the sunxi_sram driver to bind the
system-control nodes as syscon devices. Since U-Boot lacks this SRAM
driver, peripheral drivers may fail to resolve the syscon node unless an
explicit "syscon" compatible is added into the device tree.

To address this, add a bare UCLASS_SYSCON driver that matches all
Allwinner system-control and SRAM controller compatibles listed in the
Linux kernel to provide the necessary regmap access to the system
controller.

Signed-off-by: Junhui Liu <junhui.liu@pigmoral.tech>
---
 arch/arm/mach-sunxi/Kconfig  |  7 +++++++
 arch/arm/mach-sunxi/Makefile |  1 +
 arch/arm/mach-sunxi/syscon.c | 28 ++++++++++++++++++++++++++++
 3 files changed, 36 insertions(+)

diff --git a/arch/arm/mach-sunxi/Kconfig b/arch/arm/mach-sunxi/Kconfig
index ceba96b61a5..e5145bf3885 100644
--- a/arch/arm/mach-sunxi/Kconfig
+++ b/arch/arm/mach-sunxi/Kconfig
@@ -209,6 +209,13 @@ config SUN6I_PRCM
 	  Support for the PRCM (Power/Reset/Clock Management) unit available
 	  in A31 SoC.
 
+config SUNXI_SYSCON
+	bool
+	select SYSCON
+	help
+	  Enable syscon driver for Allwinner system controllers, which provides
+	  access to the SRAM/system-control node for drivers.
+
 config AXP_PMIC_BUS
 	bool
 	select DM_PMIC if DM_I2C
diff --git a/arch/arm/mach-sunxi/Makefile b/arch/arm/mach-sunxi/Makefile
index 9c79b55abf3..ff475d8fff5 100644
--- a/arch/arm/mach-sunxi/Makefile
+++ b/arch/arm/mach-sunxi/Makefile
@@ -10,6 +10,7 @@ obj-y	+= board.o
 obj-y	+= cpu_info.o
 obj-y	+= dram_helpers.o
 obj-$(CONFIG_SUN6I_PRCM)	+= prcm.o
+obj-$(CONFIG_SUNXI_SYSCON)	+= syscon.o
 obj-$(CONFIG_AXP_PMIC_BUS)	+= pmic_bus.o
 obj-$(CONFIG_MACH_SUNIV)	+= clock_sun6i.o
 obj-$(CONFIG_MACH_SUN4I)	+= clock_sun4i.o
diff --git a/arch/arm/mach-sunxi/syscon.c b/arch/arm/mach-sunxi/syscon.c
new file mode 100644
index 00000000000..e27110dfb0d
--- /dev/null
+++ b/arch/arm/mach-sunxi/syscon.c
@@ -0,0 +1,28 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2026 Junhui Liu <junhui.liu@pigmoral.tech>
+ */
+
+#include <dm.h>
+#include <syscon.h>
+
+static const struct udevice_id sunxi_syscon_ids[] = {
+	{ .compatible = "allwinner,sun4i-a10-sram-controller" },
+	{ .compatible = "allwinner,sun4i-a10-system-control" },
+	{ .compatible = "allwinner,sun5i-a13-system-control" },
+	{ .compatible = "allwinner,sun8i-a23-system-control" },
+	{ .compatible = "allwinner,sun8i-h3-system-control" },
+	{ .compatible = "allwinner,sun20i-d1-system-control" },
+	{ .compatible = "allwinner,sun50i-a64-sram-controller" },
+	{ .compatible = "allwinner,sun50i-a64-system-control" },
+	{ .compatible = "allwinner,sun50i-h5-system-control" },
+	{ .compatible = "allwinner,sun50i-h616-system-control" },
+	{ .compatible = "allwinner,sun55i-a523-system-control" },
+	{ /* sentinel */ },
+};
+
+U_BOOT_DRIVER(sunxi_syscon) = {
+	.name = "sunxi_syscon",
+	.id = UCLASS_SYSCON,
+	.of_match = sunxi_syscon_ids,
+};

-- 
2.54.0

