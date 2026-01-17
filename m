Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89F07D4A5F4
	for <u-boot@archiver.kernel.org>; Sun, 18 Jan 2026 13:49:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BE9AD83B32;
	Sun, 18 Jan 2026 14:47:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="no6Ryo2D";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EACBF833C6; Sat, 17 Jan 2026 20:12:17 +0100 (CET)
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com
 [IPv6:2607:f8b0:4864:20::834])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9159382BF2
 for <u-boot@lists.denx.de>; Sat, 17 Jan 2026 20:12:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymondmaoca@gmail.com
Received: by mail-qt1-x834.google.com with SMTP id
 d75a77b69052e-5014e1312c6so14683221cf.2
 for <u-boot@lists.denx.de>; Sat, 17 Jan 2026 11:12:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1768677134; x=1769281934; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=H6GiGUirXne99vD+9t6NEsABG0S4oCaP33OwMy4v+ls=;
 b=no6Ryo2DlJse+nOGgXoJinrI6pnEBF6FuJlgT8Zqjxk924nz9v7yA5AJexPCvuUkQh
 AkRNiLM6ey9Qq7nIIN6T393f3dyRFxE99Ihc705lWg4duwAcas/rj8J9EMsdtTk7sOpm
 ldep/WRBI8Rqqk2NkQjjJtUq6cgaUSK2JQucYGcMQWlGniEXYSOGgnED8U8BaG/rpaRO
 +cT6DRgT92iBhcRlMxY8I+QOc/XaWEmbZpegLs7rnT6TEn9bW80icc9AgGXwd/T7EKL6
 ztwRnrzUM+PUr6FD0Jr/v7Ji7eWXzcDSX3v4thnWVNr31LEJOGnHYI4u9LPMUmTre8/L
 +KqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768677134; x=1769281934;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=H6GiGUirXne99vD+9t6NEsABG0S4oCaP33OwMy4v+ls=;
 b=ZVfVvo+QOCAiGL7+YTm4N5udGhZv5z2496ocMNqdWYVe1CX+APJYMmtEwR8TiUo4sp
 M8d6+ezGZKld4raAXXfaXczsuUMAiAnFgw400ST/V3djmLjUBw1+1EQOwnSPmcDqrccz
 Cu4Fp4htcD8L7m6+sofLyTkanYwzf6Iqq1dw/2PXm/CRYYuhDL0LoQEgQASbhRRrFx0X
 3ldVQERAB7BDcSe/3GdmcNBcAtJosud9CXiZRtusPWE6u94Pb4SCdQE/yA1VG6HGHBcx
 ZVsftfo4ARQ7oDUIDa5rfr0rGdRNA7tADMSTft/udOkGOv9Zm+xKFZKkBcABciaeumnR
 63zA==
X-Gm-Message-State: AOJu0YyjYTUT3lfVMyDGTmZIixggG9qiofaKaOtYbqyvegnM8VkpJXBx
 oTP87xo6vY4eESFRLItDwRkDCeRf7Emf0qKR7V4UnZ2XrrLOqM0Mha2jhRNe5w==
X-Gm-Gg: AY/fxX418pdqMrK4wLvtQyifNZ9IMoZe9ZuWobWbLqXtwafcPebczXYtYlQ24SpRr4Y
 UMIAY7H9PVVGt44jSaZ8LbTcnkP6qevBbhm4r+2sY9kC9dPCvQJEQvVFe3qkrYUbf/nWYXVTZIG
 vn3W+sXihanrp21wj/P5BVxfMwlNoVXYtP9IFG7UgjKHW30Zbw+4/IuN+E6Hr/j4uBGb6v8NmRa
 fZUZzNqAXaU1lCJ+dUKUkY5vYaanb6IpDvX+rqZxEQsTNvE7yQKFOAMdhnWSJAkKXBZvLSf+IuJ
 OkjEn5Nt3Xjbb1EsMlcb050iqNOZRTcVJzER5rYWbtnYycjTk3SONdHO8aUbj0mIvmyjcFA1utE
 c6eBb9L3DQkUOGji4U0iUeXYt8SVKjGVD/esPn/k+0j5sr/R9Li4EL0juPaYHAo5ZF1+7NzBAWj
 9BcePrJRqWeckou+Jkr72hYAN+rj8bIa5Y0TrWOaWdbS6MZmaQJ8BvA/cC8kS991Lb7pVMs/w=
X-Received: by 2002:ac8:59c2:0:b0:4f4:c174:ae98 with SMTP id
 d75a77b69052e-502a179de1cmr112452421cf.62.1768677134050; 
 Sat, 17 Jan 2026 11:12:14 -0800 (PST)
Received: from ubuntu.localdomain (174-138-202-16.cpe.distributel.net.
 [174.138.202.16]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-502a1ef9347sm44340261cf.25.2026.01.17.11.12.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 17 Jan 2026 11:12:13 -0800 (PST)
From: Raymond Mao <raymondmaoca@gmail.com>
To: u-boot@lists.denx.de
Cc: uboot@riscstar.com, Raymond Mao <raymond.mao@riscstar.com>,
 Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>,
 Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>,
 Heiko Schocher <hs@nabladev.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Peng Fan <peng.fan@nxp.com>, Yao Zi <me@ziyao.cc>,
 Randolph Sheng-Kai Lin <randolph@andestech.com>,
 Conor Dooley <conor.dooley@microchip.com>,
 Yu-Chien Peter Lin <peter.lin@sifive.com>,
 Jamie Gibbons <jamie.gibbons@microchip.com>,
 Eric Schikschneit <eric.schikschneit@novatechautomation.com>,
 Michal Simek <michal.simek@amd.com>, Yixun Lan <dlan@gentoo.org>,
 Junhui Liu <junhui.liu@pigmoral.tech>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Angelo Dureghello <angelo.dureghello@timesys.com>,
 Utsav Agarwal <utsav.agarwal@analog.com>,
 Greg Malysa <malysagreg@gmail.com>,
 Justin Swartz <justin.swartz@risingedge.co.za>,
 Aniket Limaye <a-limaye@ti.com>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Ian Roberts <ian.roberts@timesys.com>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>, Henrik Grimler <henrik@grimler.se>,
 Quentin Schulz <quentin.schulz@cherry.de>, Anshul Dalal <anshuld@ti.com>,
 Kory Maincent <kory.maincent@bootlin.com>,
 Rui Miguel Silva <rui.silva@linaro.org>,
 Justin Klaassen <justin@tidylabs.net>,
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Samuel Holland <samuel@sholland.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Gabriel Fernandez <gabriel.fernandez@foss.st.com>,
 Kever Yang <kever.yang@rock-chips.com>, Jonas Karlman <jonas@kwiboo.se>,
 Elaine Zhang <zhangqing@rock-chips.com>,
 Joseph Chen <chenjh@rock-chips.com>
Subject: [PATCH 15/17] power: pmic: add support for Spacemit P1 PMIC
Date: Sat, 17 Jan 2026 14:01:49 -0500
Message-Id: <20260117190231.977686-16-raymondmaoca@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260117190231.977686-1-raymondmaoca@gmail.com>
References: <20260117190231.977686-1-raymondmaoca@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sun, 18 Jan 2026 14:47:30 +0100
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

From: Raymond Mao <raymond.mao@riscstar.com>

Spacemit's PMIC is used by Spacemit K1 SoC. It contains voltage
regulators, GPIOs and Watchdog.

Signed-off-by: Raymond Mao <raymond.mao@riscstar.com>
---
 drivers/power/pmic/Kconfig            |  17 +++
 drivers/power/pmic/Makefile           |   1 +
 drivers/power/pmic/pmic_spacemit_p1.c |  95 +++++++++++++++
 include/power/spacemit_p1.h           | 162 ++++++++++++++++++++++++++
 4 files changed, 275 insertions(+)
 create mode 100644 drivers/power/pmic/pmic_spacemit_p1.c
 create mode 100644 include/power/spacemit_p1.h

diff --git a/drivers/power/pmic/Kconfig b/drivers/power/pmic/Kconfig
index b1a5b1c2a1f..19a0c4a77dd 100644
--- a/drivers/power/pmic/Kconfig
+++ b/drivers/power/pmic/Kconfig
@@ -433,6 +433,23 @@ config PMIC_RAA215300
 	  support and several voltage regulators. For now, this driver simply
 	  allows register access and will bind the sysreset driver
 	  (CONFIG_SYSRESET_RAA215300) if it is enabled.
+
+config PMIC_SPACEMIT_P1
+	bool "Enable driver for Spacemit P1 power management chip"
+	depends on DM_PMIC
+	help
+	  The P1 PMIC integrates multiple functions including
+	  voltage regulators, a watchdog timer, GPIO interfaces, and a
+	  real-time clock.
+
+config SPL_PMIC_SPACEMIT_P1
+	bool "Enable driver for Spacemit P1 power management chip in SPL"
+	depends on SPL_DM_PMIC
+	help
+	  The P1 PMIC integrates multiple functions including
+	  voltage regulators, a watchdog timer, GPIO interfaces, and a
+	  real-time clock.
+
 endif
 
 config PMIC_TPS65217
diff --git a/drivers/power/pmic/Makefile b/drivers/power/pmic/Makefile
index 6bebffb05a6..dfe60223f00 100644
--- a/drivers/power/pmic/Makefile
+++ b/drivers/power/pmic/Makefile
@@ -39,6 +39,7 @@ obj-$(CONFIG_PMIC_TPS65941) += tps65941.o
 obj-$(CONFIG_PMIC_RAA215300) += raa215300.o
 obj-$(CONFIG_POWER_TPS65218) += pmic_tps65218.o
 obj-$(CONFIG_$(PHASE_)DM_PMIC_CPCAP) += cpcap.o
+obj-$(CONFIG_$(PHASE_)PMIC_SPACEMIT_P1) += pmic_spacemit_p1.o
 
 ifeq ($(CONFIG_$(PHASE_)POWER_LEGACY),y)
 obj-$(CONFIG_POWER_LTC3676) += pmic_ltc3676.o
diff --git a/drivers/power/pmic/pmic_spacemit_p1.c b/drivers/power/pmic/pmic_spacemit_p1.c
new file mode 100644
index 00000000000..88c8a375de1
--- /dev/null
+++ b/drivers/power/pmic/pmic_spacemit_p1.c
@@ -0,0 +1,95 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2025-2026 RISCStar Ltd.
+ */
+
+#include <dm.h>
+#include <power/pmic.h>
+#include <power/spacemit_p1.h>
+
+static int pmic_p1_reg_count(struct udevice *dev)
+{
+	return P1_MAX_REGS;
+}
+
+static int pmic_p1_write(struct udevice *dev, uint reg, const u8 *buffer,
+			 int len)
+{
+	int ret;
+
+	ret = dm_i2c_write(dev, reg, buffer, len);
+	if (ret)
+		pr_err("%s write error on register %02x\n", dev->name, reg);
+
+	return ret;
+}
+
+static int pmic_p1_read(struct udevice *dev, uint reg, u8 *buffer,
+			int len)
+{
+	int ret;
+
+	ret = dm_i2c_read(dev, reg, buffer, len);
+	if (ret)
+		pr_err("%s read error on register %02x\n", dev->name, reg);
+
+	return ret;
+}
+
+static const struct pmic_child_info p1_children_info[] = {
+	{ .prefix = "buck",		.driver = P1_BUCK_DRIVER },
+	{ .prefix = "aldo",		.driver = P1_LDO_DRIVER },
+	{ .prefix = "dldo",		.driver = P1_LDO_DRIVER },
+	{ },
+};
+
+static int pmic_p1_bind(struct udevice *dev)
+{
+	const struct pmic_child_info *p1_children_info =
+			(struct pmic_child_info *)dev_get_driver_data(dev);
+	ofnode regulators_node;
+	int children;
+
+	regulators_node = dev_read_subnode(dev, "regulators");
+	if (!ofnode_valid(regulators_node)) {
+		debug("%s regulators subnode not found\n", dev->name);
+		return -EINVAL;
+	}
+
+	children = pmic_bind_children(dev, regulators_node,
+				      p1_children_info);
+	if (!children)
+		debug("%s has no children (regulators)\n", dev->name);
+
+	return 0;
+}
+
+static int pmic_p1_probe(struct udevice *dev)
+{
+	return 0;
+}
+
+static struct dm_pmic_ops pmic_p1_ops = {
+	.reg_count	= pmic_p1_reg_count,
+	.read		= pmic_p1_read,
+	.write		= pmic_p1_write,
+};
+
+static const struct udevice_id pmic_p1_match[] = {
+	{
+		.compatible = "spacemit,p1",
+		.data = (ulong)&p1_children_info,
+	}, {
+		/* sentinel */
+	}
+};
+
+U_BOOT_DRIVER(pmic_p1) = {
+	.name		= "pmic_p1",
+	.id		= UCLASS_PMIC,
+	.of_match	= pmic_p1_match,
+	.bind		= pmic_p1_bind,
+	.probe		= pmic_p1_probe,
+	.ops		= &pmic_p1_ops,
+	//.priv_auto	= sizeof(struct p1_pdata),
+};
diff --git a/include/power/spacemit_p1.h b/include/power/spacemit_p1.h
new file mode 100644
index 00000000000..848bb469305
--- /dev/null
+++ b/include/power/spacemit_p1.h
@@ -0,0 +1,162 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Copyright (C) 2025-2026 RISCStar Ltd.
+ */
+
+#ifndef __SPACEMIT_P1_H_
+#define __SPACEMIT_P1_H_
+
+#define P1_MAX_REGS			0xA8
+
+#define P1_REG_ID			0x0
+
+#define P1_ID				0x2
+
+#define P1_REG_BUCK1_CTRL		0x47
+#define P1_REG_BUCK2_CTRL		0x4a
+#define P1_REG_BUCK3_CTRL		0x4d
+#define P1_REG_BUCK4_CTRL		0x50
+#define P1_REG_BUCK5_CTRL		0x53
+#define P1_REG_BUCK6_CTRL		0x56
+
+#define P1_REG_BUCK1_VSEL		0x48
+#define P1_REG_BUCK2_VSEL		0x4b
+#define P1_REG_BUCK3_VSEL		0x4e
+#define P1_REG_BUCK4_VSEL		0x51
+#define P1_REG_BUCK5_VSEL		0x54
+#define P1_REG_BUCK6_VSEL		0x57
+
+#define P1_REG_BUCK1_SVSEL		0x49
+#define P1_REG_BUCK2_SVSEL		0x4c
+#define P1_REG_BUCK3_SVSEL		0x4f
+#define P1_REG_BUCK4_SVSEL		0x52
+#define P1_REG_BUCK5_SVSEL		0x55
+#define P1_REG_BUCK6_SVSEL		0x58
+
+#define P1_BUCK_CTRL(x)			(0x47 + ((x) - 1) * 3)
+#define P1_BUCK_VSEL(x)			(0x48 + ((x) - 1) * 3)
+#define P1_BUCK_SVSEL(x)		(0x49 + ((x) - 1) * 3)
+
+#define BUCK_VSEL_MASK			0xff
+#define BUCK_EN_MASK			0x1
+#define BUCK_SVSEL_MASK			0xff
+
+#define P1_REG_ALDO1_CTRL		0x5b
+#define P1_REG_ALDO2_CTRL		0x5e
+#define P1_REG_ALDO3_CTRL		0x61
+#define P1_REG_ALDO4_CTRL		0x64
+
+#define P1_REG_ALDO1_VOLT		0x5c
+#define P1_REG_ALDO2_VOLT		0x5f
+#define P1_REG_ALDO3_VOLT		0x62
+#define P1_REG_ALDO4_VOLT		0x65
+
+#define P1_REG_ALDO1_SVOLT		0x5d
+#define P1_REG_ALDO2_SVOLT		0x60
+#define P1_REG_ALDO3_SVOLT		0x63
+#define P1_REG_ALDO4_SVOLT		0x66
+
+#define P1_ALDO_CTRL(x)			(0x5b + ((x) - 1) * 3)
+#define P1_ALDO_VOLT(x)			(0x5c + ((x) - 1) * 3)
+#define P1_ALDO_SVOLT(x)		(0x5d + ((x) - 1) * 3)
+
+#define ALDO_SVSEL_MASK			0x7f
+#define ALDO_EN_MASK			0x1
+#define ALDO_VSEL_MASK			0x7f
+
+#define P1_REG_DLDO1_CTRL		0x67
+#define P1_REG_DLDO2_CTRL		0x6a
+#define P1_REG_DLDO3_CTRL		0x6d
+#define P1_REG_DLDO4_CTRL		0x70
+#define P1_REG_DLDO5_CTRL		0x73
+#define P1_REG_DLDO6_CTRL		0x76
+#define P1_REG_DLDO7_CTRL		0x79
+
+#define P1_REG_DLDO1_VOLT		0x68
+#define P1_REG_DLDO2_VOLT		0x6b
+#define P1_REG_DLDO3_VOLT		0x6e
+#define P1_REG_DLDO4_VOLT		0x71
+#define P1_REG_DLDO5_VOLT		0x74
+#define P1_REG_DLDO6_VOLT		0x77
+#define P1_REG_DLDO7_VOLT		0x7a
+
+#define P1_REG_DLDO1_SVOLT		0x69
+#define P1_REG_DLDO2_SVOLT		0x6c
+#define P1_REG_DLDO3_SVOLT		0x6f
+#define P1_REG_DLDO4_SVOLT		0x72
+#define P1_REG_DLDO5_SVOLT		0x75
+#define P1_REG_DLDO6_SVOLT		0x78
+#define P1_REG_DLDO7_SVOLT		0x7b
+
+#define P1_DLDO_CTRL(x)			(0x67 + ((x) - 1) * 3)
+#define P1_DLDO_VOLT(x)			(0x68 + ((x) - 1) * 3)
+#define P1_DLDO_SVOLT(x)		(0x69 + ((x) - 1) * 3)
+
+#define DLDO_SVSEL_MASK			0x7f
+#define DLDO_EN_MASK			0x1
+#define DLDO_VSEL_MASK			0x7f
+
+#define P1_REG_SWITCH_CTRL		0x59
+#define P1_SWTICH_EN_MASK		0x1
+
+#define P1_REG_SWITCH_PWRKEY_EVENT_CTRL	0x97
+#define P1_SWITCH_PWRKEY_EVENT_EN_MSK	0xf
+
+#define P1_REG_SWITCH_PWRKEY_INIT_CTRL	0x9e
+#define P1_SWITCH_PWRKEY_INT_EN_MSK	0xf
+
+/* Watchdog Timer Registers */
+#define P1_WDT_CTRL			0x44
+#define P1_PWR_CTRL0			0x7C
+#define P1_PWR_CTRL2			0x7E
+#define P1_PWR_CTRL2_MSK		0xff
+
+/* Watchdog Timer Control Bits */
+#define P1_WDT_CLEAR_STATUS		0x1
+#define P1_SW_RST			0x2
+#define P1_WDT_RESET_ENABLE		0x80
+#define P1_WDT_ENABLE			0x8
+#define P1_WDT_TIMEOUT_1S		0x0
+#define P1_WDT_TIMEOUT_4S		0x1
+#define P1_WDT_TIMEOUT_8S		0x2
+#define P1_WDT_TIMEOUT_16S		0x3
+
+#define P1_RTC_TICK_CTRL		0x1d
+#define P1_RTC_TICK_CTRL_MSK		0x7f
+
+#define P1_RTC_TICK_EVENT		0x92
+#define P1_RTC_TICK_EVENT_MSK		0x3f
+
+#define P1_RTC_TICK_IRQ			0x99
+#define P1_RTC_TICK_IRQ_MSK		0x3f
+
+#define P1_REG_ALIVE			0xab
+#define P1_ALIVE_MSK			0x7
+#define SYS_REBOOT_FLAG_BIT		0x2
+
+/* SWITCH ID */
+enum {
+	P1_ID_SWITCH1,
+	P1_ID_SWITCH1_PWRKEY_EVENT,
+	P1_ID_SWITCH1_PWRKEY_INT,
+	P1_ID_SWITCH_RTC_TICK_CTRL,
+	P1_ID_SWITCH_RTC_TICK_EVENT,
+	P1_ID_SWITCH_RTC_TCK_IRQ,
+	P1_ID_SWITCH_POWER_DOWN,
+	P1_ID_SWITCH_CHARGING_FLAG,
+};
+
+/* POWERKEY events */
+enum {
+	PWRKEY_RISING_EVENT = 1,
+	PWRKEY_FAILING_EVENT = 2,
+	PWRKEY_SHORT_PRESS_EVENT = 4,
+	PWRKEY_LONG_PRESS_EVENT = 8,
+};
+
+#define P1_BUCK_DRIVER			"p1_buck"
+#define P1_LDO_DRIVER			"p1_ldo"
+#define P1_SWITCH_DRIVER		"p1_switch"
+#define P1_WDT_DRIVER			"p1_wdt"
+
+#endif /* __SPACEMIT_P1_H_ */
-- 
2.25.1

