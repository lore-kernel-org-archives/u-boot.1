Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10433D4A5F4
	for <u-boot@archiver.kernel.org>; Sun, 18 Jan 2026 13:49:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 08CAC83B4E;
	Sun, 18 Jan 2026 14:47:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="L3ahkg/u";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BAE89833C6; Sat, 17 Jan 2026 20:12:53 +0100 (CET)
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com
 [IPv6:2607:f8b0:4864:20::72c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3FE8F82BF2
 for <u-boot@lists.denx.de>; Sat, 17 Jan 2026 20:12:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymondmaoca@gmail.com
Received: by mail-qk1-x72c.google.com with SMTP id
 af79cd13be357-8c655e0ee70so331987085a.3
 for <u-boot@lists.denx.de>; Sat, 17 Jan 2026 11:12:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1768677170; x=1769281970; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iwKXhhebbm7tSgLx+7slGWzQilXykw9HViOQ7wrIxno=;
 b=L3ahkg/uh+hn8kHfJExF789IduNsstvhurQYZlWzv3W2XlMC8nNSS96a6Ppa/24dBy
 CAF/nrgPcGbKRLabA8yXajIJ9liyPV3BAN5aT0SUrksE5WhislIKzjrl3gxAqjMNkVZI
 DR9HxmFj/aX3SOpW9ezI0X8v/cYksnBCbIk5uGURR7LLlzJAcWAqKRnXDOlOEbXWmHxM
 Y5FXXEaEUhqSQGQxGTujXJ42tB9I0PDHAS+GDIXqk+RbW+hbfdXI7/B6J9YftySe4npi
 9d7KAlcU7h42yaumQXNO+YdbmAtKfDXnZSqoh4MleoBUAG+VrbktTQVlmerytnnTb442
 Y8Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768677170; x=1769281970;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=iwKXhhebbm7tSgLx+7slGWzQilXykw9HViOQ7wrIxno=;
 b=Ysm/Ka7SCVoJK0PnHu87t8mkAOAKMs5tRvVSDYoic9ajwrikbXpeOONCNxGzWSBZGl
 XtH5KGp05xSfkFH6hPnU9PxVzjvFmg03l9MvsLfHA7QleowmBO97sc9YVzfPkCuYZfZz
 /VP2jEOhkyEH6HpcOA2RpYxW5JO/88ofIQO/hQLdB1sfPwffg4tXSe5iOUj2yqmNLBw7
 nIpakCCORu01Ge7MjJ0l13U5NqN1sOs0kZBHCf6Yn6g9dEsFvnMMRPUBafWgqm8T/oRK
 7J/aKTbU+GCSweEnm8qvrwIFhzVvFc7S+t0yNlT1N5p9fZmYCDAd4tXVO/pAyO7nlxvR
 T2LQ==
X-Gm-Message-State: AOJu0YyaGhkVS1gqZ5dwEO/dUj7Jm0FMBlEPynp+B59/UbzM/QzdvRiJ
 YvrAXsMCxAtlM2Q6YXe5aNK6OcGgLucCqLinF9VuRSwb+Y/gHJbYHBpdHlwMEw==
X-Gm-Gg: AY/fxX7Q6rV0l5YXlcm3uKoFG0ukof0qFGaj5KBCiR9y4HV+8rbyrK1UiJTXDwvzvvI
 ezx9tG2/GXy9p12j6T2n8jNWQ4tpRhCOCKF/p/MDC/+1NlEWMPt4hS6fSaF2rKQ+af/hd6OD8TC
 DpguW9v1gq/vdZM3H97HkuFDLSYqwTAkBgyD9WdaFDIQJ6orWZSoTYLPC8S5mxjX09cD3rbS2Zj
 xLuFBzK4NaffO5TUPS4UDowgQb7HlAyNI01e0egPsGjJ1XHk713PBDAdzgBgf0aQlozvbxlUEHa
 Vwg1uIHZZW0dkBFuvr8ikvxiMd1rP03a48wyrkwZh7gH2oFYZDNUFT70OWU6quda1gPS5FX3DlP
 ZDdDKJT3nYOZD6PVRIbeWM7u1LWrQRD11ASCRtEIGTCC0dtMoQbDDZTTq/gcKTItldSFpAYk+Lm
 UN7R81Bck4kK3WJ6Lcb0NIXcprvRdf7uG1J5w9+dNKnMJFzC0wZ8qwF9R5JPOv4oL4NWN9dQs=
X-Received: by 2002:ac8:5e49:0:b0:4f3:59a7:67b3 with SMTP id
 d75a77b69052e-502a1655df0mr102409951cf.20.1768677169763; 
 Sat, 17 Jan 2026 11:12:49 -0800 (PST)
Received: from ubuntu.localdomain (174-138-202-16.cpe.distributel.net.
 [174.138.202.16]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-502a1ef9347sm44340261cf.25.2026.01.17.11.12.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 17 Jan 2026 11:12:49 -0800 (PST)
From: Raymond Mao <raymondmaoca@gmail.com>
To: u-boot@lists.denx.de
Cc: uboot@riscstar.com, Raymond Mao <raymond.mao@riscstar.com>,
 Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>,
 Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>,
 Heiko Schocher <hs@nabladev.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Peng Fan <peng.fan@nxp.com>, Yao Zi <me@ziyao.cc>,
 Yu-Chien Peter Lin <peter.lin@sifive.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Randolph Sheng-Kai Lin <randolph@andestech.com>,
 Jamie Gibbons <jamie.gibbons@microchip.com>,
 Michal Simek <michal.simek@amd.com>,
 Eric Schikschneit <eric.schikschneit@novatechautomation.com>,
 Yixun Lan <dlan@gentoo.org>, Junhui Liu <junhui.liu@pigmoral.tech>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Vasileios Bimpikas <vasileios.bimpikas@analog.com>,
 Greg Malysa <malysagreg@gmail.com>, Aniket Limaye <a-limaye@ti.com>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Justin Swartz <justin.swartz@risingedge.co.za>,
 Angelo Dureghello <angelo.dureghello@timesys.com>,
 Utsav Agarwal <utsav.agarwal@analog.com>,
 Ian Roberts <ian.roberts@timesys.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>, Henrik Grimler <henrik@grimler.se>,
 Quentin Schulz <quentin.schulz@cherry.de>, Anshul Dalal <anshuld@ti.com>,
 Kory Maincent <kory.maincent@bootlin.com>,
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Samuel Holland <samuel@sholland.org>,
 Justin Klaassen <justin@tidylabs.net>,
 Rui Miguel Silva <rui.silva@linaro.org>,
 Andre Przywara <andre.przywara@arm.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Gabriel Fernandez <gabriel.fernandez@foss.st.com>,
 Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>,
 Heiko Stuebner <heiko@sntech.de>, Joseph Chen <chenjh@rock-chips.com>,
 Elaine Zhang <zhangqing@rock-chips.com>
Subject: [PATCH 16/17] power: regulator: add support for Spacemit P1 SoC
Date: Sat, 17 Jan 2026 14:01:50 -0500
Message-Id: <20260117190231.977686-17-raymondmaoca@gmail.com>
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

Support voltage regulator for Spacemit P1 SoC. It contains 6 BUCKs
and 11 LDOs.

Signed-off-by: Raymond Mao <raymond.mao@riscstar.com>
---
 drivers/power/pmic/pmic_spacemit_p1.c         |   5 +-
 drivers/power/regulator/Kconfig               |  15 +
 drivers/power/regulator/Makefile              |   1 +
 .../power/regulator/spacemit_p1_regulator.c   | 460 ++++++++++++++++++
 include/power/spacemit_p1.h                   |   3 +-
 5 files changed, 480 insertions(+), 4 deletions(-)
 create mode 100644 drivers/power/regulator/spacemit_p1_regulator.c

diff --git a/drivers/power/pmic/pmic_spacemit_p1.c b/drivers/power/pmic/pmic_spacemit_p1.c
index 88c8a375de1..d09240ee469 100644
--- a/drivers/power/pmic/pmic_spacemit_p1.c
+++ b/drivers/power/pmic/pmic_spacemit_p1.c
@@ -38,8 +38,8 @@ static int pmic_p1_read(struct udevice *dev, uint reg, u8 *buffer,
 
 static const struct pmic_child_info p1_children_info[] = {
 	{ .prefix = "buck",		.driver = P1_BUCK_DRIVER },
-	{ .prefix = "aldo",		.driver = P1_LDO_DRIVER },
-	{ .prefix = "dldo",		.driver = P1_LDO_DRIVER },
+	{ .prefix = "aldo",		.driver = P1_ALDO_DRIVER },
+	{ .prefix = "dldo",		.driver = P1_DLDO_DRIVER },
 	{ },
 };
 
@@ -91,5 +91,4 @@ U_BOOT_DRIVER(pmic_p1) = {
 	.bind		= pmic_p1_bind,
 	.probe		= pmic_p1_probe,
 	.ops		= &pmic_p1_ops,
-	//.priv_auto	= sizeof(struct p1_pdata),
 };
diff --git a/drivers/power/regulator/Kconfig b/drivers/power/regulator/Kconfig
index c6da459a212..182510581c0 100644
--- a/drivers/power/regulator/Kconfig
+++ b/drivers/power/regulator/Kconfig
@@ -520,3 +520,18 @@ config DM_REGULATOR_CPCAP
 	REGULATOR CPCAP. The driver supports both DC-to-DC Step-Down Switching
 	(SW) Regulators and Low-Dropout Linear (LDO) Regulators	found in CPCAP
 	PMIC and implements get/set api for voltage and state.
+
+config DM_REGULATOR_SPACEMIT_P1
+	bool "Enable driver for Spacemit P1 PMIC regulators"
+	depends on DM_REGULATOR && PMIC_SPACEMIT_P1
+	help
+	  Enable implementation of driver-model regulator uclass features
+	  for regulator P1. The driver supports BUCKs, LDOs and SWITCHes.
+
+config SPL_DM_REGULATOR_SPACEMIT_P1
+	bool "Enable driver for Spacemit P1 PMIC regulators in SPL"
+	depends on SPL_DM_REGULATOR && SPL_PMIC_SPACEMIT_P1
+	help
+	  Enable implementation of driver-model regulator uclass features
+	  for regulator P1 in SPL. The driver supports BUCKs, LDOs and
+	  SWITCHes.
diff --git a/drivers/power/regulator/Makefile b/drivers/power/regulator/Makefile
index ee8f56ea3b9..2a586e42f5c 100644
--- a/drivers/power/regulator/Makefile
+++ b/drivers/power/regulator/Makefile
@@ -47,3 +47,4 @@ obj-$(CONFIG_$(PHASE_)DM_REGULATOR_ANATOP) += anatop_regulator.o
 obj-$(CONFIG_DM_REGULATOR_TPS65219) += tps65219_regulator.o
 obj-$(CONFIG_REGULATOR_RZG2L_USBPHY) += rzg2l-usbphy-regulator.o
 obj-$(CONFIG_$(PHASE_)DM_REGULATOR_CPCAP) += cpcap_regulator.o
+obj-$(CONFIG_$(PHASE_)DM_REGULATOR_SPACEMIT_P1) += spacemit_p1_regulator.o
diff --git a/drivers/power/regulator/spacemit_p1_regulator.c b/drivers/power/regulator/spacemit_p1_regulator.c
new file mode 100644
index 00000000000..9d7cfc43e1a
--- /dev/null
+++ b/drivers/power/regulator/spacemit_p1_regulator.c
@@ -0,0 +1,460 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2025-2026 RISCStar Ltd.
+ */
+
+#include <dm.h>
+#include <dm/lists.h>
+#include <errno.h>
+#include <log.h>
+#include <power/pmic.h>
+#include <power/regulator.h>
+#include <power/spacemit_p1.h>
+
+struct p1_reg_info {
+	uint min_uv;
+	uint step_uv;
+	u8 vsel_reg;
+	u8 vsel_sleep_reg;
+	u8 config_reg;
+	u8 vsel_mask;
+	u8 min_sel;
+	u8 max_sel;
+};
+
+static const struct p1_reg_info p1_bucks[] = {
+	/* BUCK 1 */
+	{ 500000,  5000, P1_BUCK_VSEL(1), P1_BUCK_SVSEL(1), P1_BUCK_CTRL(1),
+	  BUCK_VSEL_MASK, 0x00, 0xaa },
+	{ 1375000, 25000, P1_BUCK_VSEL(1), P1_BUCK_SVSEL(1), P1_BUCK_CTRL(1),
+	  BUCK_VSEL_MASK, 0xab, 0xfe },
+	/* BUCK 2 */
+	{ 500000,  5000, P1_BUCK_VSEL(2), P1_BUCK_SVSEL(2), P1_BUCK_CTRL(2),
+	  BUCK_VSEL_MASK, 0x00, 0xaa },
+	{ 1375000, 25000, P1_BUCK_VSEL(2), P1_BUCK_SVSEL(2), P1_BUCK_CTRL(2),
+	  BUCK_VSEL_MASK, 0xab, 0xfe },
+	/* BUCK 3 */
+	{ 500000,  5000, P1_BUCK_VSEL(3), P1_BUCK_SVSEL(3), P1_BUCK_CTRL(3),
+	  BUCK_VSEL_MASK, 0x00, 0xaa },
+	{ 1375000, 25000, P1_BUCK_VSEL(3), P1_BUCK_SVSEL(3), P1_BUCK_CTRL(3),
+	  BUCK_VSEL_MASK, 0xab, 0xfe },
+	/* BUCK 4 */
+	{ 500000,  5000, P1_BUCK_VSEL(4), P1_BUCK_SVSEL(4), P1_BUCK_CTRL(4),
+	  BUCK_VSEL_MASK, 0x00, 0xaa },
+	{ 1375000, 25000, P1_BUCK_VSEL(4), P1_BUCK_SVSEL(4), P1_BUCK_CTRL(4),
+	  BUCK_VSEL_MASK, 0xab, 0xfe },
+	/* BUCK 5 */
+	{ 500000,  5000, P1_BUCK_VSEL(5), P1_BUCK_SVSEL(5), P1_BUCK_CTRL(5),
+	  BUCK_VSEL_MASK, 0x00, 0xaa },
+	{ 1375000, 25000, P1_BUCK_VSEL(5), P1_BUCK_SVSEL(5), P1_BUCK_CTRL(5),
+	  BUCK_VSEL_MASK, 0xab, 0xfe },
+	/* BUCK 6 */
+	{ 500000,  5000, P1_BUCK_VSEL(6), P1_BUCK_SVSEL(6), P1_BUCK_CTRL(6),
+	  BUCK_VSEL_MASK, 0x00, 0xaa },
+	{ 1375000, 25000, P1_BUCK_VSEL(6), P1_BUCK_SVSEL(6), P1_BUCK_CTRL(6),
+	  BUCK_VSEL_MASK, 0xab, 0xfe },
+};
+
+static const struct p1_reg_info p1_aldos[] = {
+	/* ALDO 1 */
+	{ 500000, 25000, P1_ALDO_VOLT(1), P1_ALDO_SVOLT(1), P1_ALDO_CTRL(1),
+	  ALDO_VSEL_MASK, 0x0b, 0x7f },
+	/* ALDO 2 */
+	{ 500000, 25000, P1_ALDO_VOLT(2), P1_ALDO_SVOLT(2), P1_ALDO_CTRL(2),
+	  ALDO_VSEL_MASK, 0x0b, 0x7f },
+	/* ALDO 3 */
+	{ 500000, 25000, P1_ALDO_VOLT(3), P1_ALDO_SVOLT(3), P1_ALDO_CTRL(3),
+	  ALDO_VSEL_MASK, 0x0b, 0x7f },
+	/* ALDO 4 */
+	{ 500000, 25000, P1_ALDO_VOLT(4), P1_ALDO_SVOLT(4), P1_ALDO_CTRL(4),
+	  ALDO_VSEL_MASK, 0x0b, 0x7f },
+};
+
+static const struct p1_reg_info p1_dldos[] = {
+	/* DLDO 1 */
+	{ 500000, 25000, P1_DLDO_VOLT(1), P1_DLDO_SVOLT(1), P1_DLDO_CTRL(1),
+	  ALDO_VSEL_MASK, 0x0b, 0x7f },
+	/* DLDO 2 */
+	{ 500000, 25000, P1_DLDO_VOLT(2), P1_DLDO_SVOLT(2), P1_DLDO_CTRL(2),
+	  ALDO_VSEL_MASK, 0x0b, 0x7f },
+	/* DLDO 3 */
+	{ 500000, 25000, P1_DLDO_VOLT(3), P1_DLDO_SVOLT(3), P1_DLDO_CTRL(3),
+	  ALDO_VSEL_MASK, 0x0b, 0x7f },
+	/* DLDO 4 */
+	{ 500000, 25000, P1_DLDO_VOLT(4), P1_DLDO_SVOLT(4), P1_DLDO_CTRL(4),
+	  ALDO_VSEL_MASK, 0x0b, 0x7f },
+	/* DLDO 5 */
+	{ 500000, 25000, P1_DLDO_VOLT(5), P1_DLDO_SVOLT(5), P1_DLDO_CTRL(5),
+	  ALDO_VSEL_MASK, 0x0b, 0x7f },
+	/* DLDO 6 */
+	{ 500000, 25000, P1_DLDO_VOLT(6), P1_DLDO_SVOLT(6), P1_DLDO_CTRL(6),
+	  ALDO_VSEL_MASK, 0x0b, 0x7f },
+	/* DLDO 7 */
+	{ 500000, 25000, P1_DLDO_VOLT(7), P1_DLDO_SVOLT(7), P1_DLDO_CTRL(7),
+	  ALDO_VSEL_MASK, 0x0b, 0x7f },
+};
+
+static const struct p1_reg_info *get_buck_reg(struct udevice *pmic,
+					      int idx, int uvolt)
+{
+	if (idx < 0)
+		return NULL;
+	if (uvolt < 1375000)
+		return &p1_bucks[(idx - 1) * 2 + 0];
+	return &p1_bucks[(idx - 1) * 2 + 1];
+}
+
+static const struct p1_reg_info *get_aldo_reg(struct udevice *pmic,
+					      int idx, int uvolt)
+{
+	return &p1_aldos[idx];
+}
+
+static const struct p1_reg_info *get_dldo_reg(struct udevice *pmic,
+					      int idx, int uvolt)
+{
+	return &p1_dldos[idx];
+}
+
+static int buck_get_value(struct udevice *dev)
+{
+	const struct dm_pmic_ops *ops = device_get_ops(dev->parent);
+	const struct p1_reg_info *info;
+	uint val;
+	int ret;
+
+	if (!ops || !ops->read)
+		return -ENOSYS;
+
+	info = get_buck_reg(dev->parent, dev->driver_data, 0);
+	if (!info)
+		return -ENOENT;
+	ret = pmic_reg_read(dev->parent, info->vsel_reg);
+	if (ret < 0)
+		return ret;
+	val = ret & info->vsel_mask;
+	while (val > info->max_sel)
+		info++;
+
+	return info->min_uv + (val - info->min_sel) * info->step_uv;
+}
+
+static int buck_set_value(struct udevice *dev, int uvolt)
+{
+	const struct dm_pmic_ops *ops = device_get_ops(dev->parent);
+	const struct p1_reg_info *info;
+	uint val;
+	int ret;
+
+	if (!ops || !ops->write)
+		return -ENOSYS;
+
+	info = get_buck_reg(dev->parent, dev->driver_data, uvolt);
+	if (!info)
+		return -ENOENT;
+	val = (uvolt - info->min_uv);
+	val = val / info->step_uv;
+	val += info->min_sel;
+	ret = pmic_reg_write(dev->parent, info->vsel_reg, val);
+	if (ret < 0)
+		return ret;
+	return 0;
+}
+
+static int buck_get_enable(struct udevice *dev)
+{
+	const struct p1_reg_info *info;
+	int ret;
+
+	info = get_buck_reg(dev->parent, dev->driver_data, 0);
+	if (!info)
+		return -ENOENT;
+
+	ret = pmic_reg_read(dev->parent, info->config_reg);
+	if (ret < 0)
+		return ret;
+	return ret & BUCK_EN_MASK;
+}
+
+static int buck_set_enable(struct udevice *dev, bool enable)
+{
+	const struct p1_reg_info *info;
+	uint val;
+	int ret;
+
+	info = get_buck_reg(dev->parent, dev->driver_data, 0);
+	if (!info)
+		return -ENOENT;
+
+	ret = pmic_reg_read(dev->parent, info->config_reg);
+	if (ret < 0)
+		return ret;
+	val = (unsigned int)ret;
+	val &= BUCK_EN_MASK;
+
+	if (enable == val)
+		return 0;
+
+	val = enable;
+	ret = pmic_clrsetbits(dev->parent, info->config_reg, BUCK_EN_MASK, val);
+	if (ret < 0)
+		return ret;
+
+	return 0;
+}
+
+static const struct dm_regulator_ops p1_buck_ops = {
+	.get_value  = buck_get_value,
+	.set_value  = buck_set_value,
+	.get_enable = buck_get_enable,
+	.set_enable = buck_set_enable,
+};
+
+static int p1_buck_probe(struct udevice *dev)
+{
+	struct dm_regulator_uclass_plat *uc_pdata;
+
+	uc_pdata = dev_get_uclass_plat(dev);
+
+	uc_pdata->type = REGULATOR_TYPE_BUCK;
+	uc_pdata->mode_count = 0;
+
+	return 0;
+}
+
+U_BOOT_DRIVER(p1_buck) = {
+	.name		= P1_BUCK_DRIVER,
+	.id		= UCLASS_REGULATOR,
+	.ops		= &p1_buck_ops,
+	.probe		= p1_buck_probe,
+};
+
+static int aldo_get_value(struct udevice *dev)
+{
+	const struct dm_pmic_ops *ops = device_get_ops(dev->parent);
+	const struct p1_reg_info *info;
+	uint val;
+	int ret;
+
+	if (!ops || !ops->read)
+		return -ENOSYS;
+
+	info = get_aldo_reg(dev->parent, dev->driver_data, 0);
+	if (!info)
+		return -ENOENT;
+
+	ret = pmic_reg_read(dev->parent, info->vsel_reg);
+	if (ret < 0)
+		return ret;
+
+	val = ret & info->vsel_mask;
+	while (val > info->max_sel)
+		info++;
+
+	return info->min_uv + (val - info->min_sel) * info->step_uv;
+}
+
+static int aldo_set_value(struct udevice *dev, int uvolt)
+{
+	const struct dm_pmic_ops *ops = device_get_ops(dev->parent);
+	const struct p1_reg_info *info;
+	uint val;
+	int ret;
+
+	if (!ops || !ops->write)
+		return -ENOSYS;
+
+	info = get_aldo_reg(dev->parent, dev->driver_data, uvolt);
+	if (!info)
+		return -ENOENT;
+	val = (uvolt - info->min_uv);
+	val = val / info->step_uv;
+	val += info->min_sel;
+	ret = pmic_reg_write(dev->parent, info->vsel_reg, val);
+	if (ret < 0)
+		return ret;
+	return 0;
+}
+
+static int aldo_get_enable(struct udevice *dev)
+{
+	const struct p1_reg_info *info;
+	int ret;
+
+	info = get_aldo_reg(dev->parent, dev->driver_data, 0);
+	if (!info)
+		return -ENOENT;
+
+	ret = pmic_reg_read(dev->parent, info->config_reg);
+	if (ret < 0)
+		return ret;
+	return ret & ALDO_EN_MASK;
+}
+
+static int aldo_set_enable(struct udevice *dev, bool enable)
+{
+	const struct p1_reg_info *info;
+	uint val;
+	int ret;
+
+	info = get_aldo_reg(dev->parent, dev->driver_data, 0);
+	if (!info)
+		return -ENOENT;
+
+	ret = pmic_reg_read(dev->parent, info->config_reg);
+	if (ret < 0)
+		return ret;
+	val = (unsigned int)ret;
+	val &= ALDO_EN_MASK;
+
+	if (enable == val)
+		return 0;
+
+	val = enable;
+	ret = pmic_clrsetbits(dev->parent, info->config_reg, ALDO_EN_MASK, val);
+	if (ret < 0)
+		return ret;
+
+	return 0;
+}
+
+static const struct dm_regulator_ops p1_aldo_ops = {
+	.get_value	= aldo_get_value,
+	.set_value	= aldo_set_value,
+	.get_enable	= aldo_get_enable,
+	.set_enable	= aldo_set_enable,
+};
+
+static int p1_aldo_probe(struct udevice *dev)
+{
+	struct dm_regulator_uclass_plat *uc_pdata;
+
+	uc_pdata = dev_get_uclass_plat(dev);
+
+	uc_pdata->type = REGULATOR_TYPE_LDO;
+	uc_pdata->mode_count = 0;
+
+	return 0;
+}
+
+U_BOOT_DRIVER(p1_aldo) = {
+	.name		= P1_ALDO_DRIVER,
+	.id		= UCLASS_REGULATOR,
+	.ops		= &p1_aldo_ops,
+	.probe		= p1_aldo_probe,
+};
+
+static int dldo_get_value(struct udevice *dev)
+{
+	const struct dm_pmic_ops *ops = device_get_ops(dev->parent);
+	const struct p1_reg_info *info;
+	uint val;
+	int ret;
+
+	if (!ops || !ops->read)
+		return -ENOSYS;
+
+	info = get_dldo_reg(dev->parent, dev->driver_data, 0);
+	if (!info)
+		return -ENOENT;
+
+	ret = pmic_reg_read(dev->parent, info->vsel_reg);
+	if (ret < 0)
+		return ret;
+
+	val = ret & info->vsel_mask;
+	while (val > info->max_sel)
+		info++;
+
+	return info->min_uv + (val - info->min_sel) * info->step_uv;
+}
+
+static int dldo_set_value(struct udevice *dev, int uvolt)
+{
+	const struct dm_pmic_ops *ops = device_get_ops(dev->parent);
+	const struct p1_reg_info *info;
+	uint val;
+	int ret;
+
+	if (!ops || !ops->write)
+		return -ENOSYS;
+
+	info = get_dldo_reg(dev->parent, dev->driver_data, uvolt);
+	if (!info)
+		return -ENOENT;
+	val = (uvolt - info->min_uv);
+	val = val / info->step_uv;
+	val += info->min_sel;
+	ret = pmic_reg_write(dev->parent, info->vsel_reg, val);
+	if (ret < 0)
+		return ret;
+	return 0;
+}
+
+static int dldo_get_enable(struct udevice *dev)
+{
+	const struct p1_reg_info *info;
+	int ret;
+
+	info = get_dldo_reg(dev->parent, dev->driver_data, 0);
+	if (!info)
+		return -ENOENT;
+
+	ret = pmic_reg_read(dev->parent, info->config_reg);
+	if (ret < 0)
+		return ret;
+	return ret & DLDO_EN_MASK;
+}
+
+static int dldo_set_enable(struct udevice *dev, bool enable)
+{
+	const struct p1_reg_info *info;
+	uint val;
+	int ret;
+
+	info = get_dldo_reg(dev->parent, dev->driver_data, 0);
+	if (!info)
+		return -ENOENT;
+
+	ret = pmic_reg_read(dev->parent, info->config_reg);
+	if (ret < 0)
+		return ret;
+	val = (unsigned int)ret;
+	val &= DLDO_EN_MASK;
+
+	if (enable == val)
+		return 0;
+
+	val = enable;
+	ret = pmic_clrsetbits(dev->parent, info->config_reg, DLDO_EN_MASK, val);
+	if (ret < 0)
+		return ret;
+
+	return 0;
+}
+
+static const struct dm_regulator_ops p1_dldo_ops = {
+	.get_value	= dldo_get_value,
+	.set_value	= dldo_set_value,
+	.get_enable	= dldo_get_enable,
+	.set_enable	= dldo_set_enable,
+};
+
+static int p1_dldo_probe(struct udevice *dev)
+{
+	struct dm_regulator_uclass_plat *uc_pdata;
+
+	uc_pdata = dev_get_uclass_plat(dev);
+
+	uc_pdata->type = REGULATOR_TYPE_LDO;
+	uc_pdata->mode_count = 0;
+
+	return 0;
+}
+
+U_BOOT_DRIVER(p1_dldo) = {
+	.name		= P1_DLDO_DRIVER,
+	.id		= UCLASS_REGULATOR,
+	.ops		= &p1_dldo_ops,
+	.probe		= p1_dldo_probe,
+};
diff --git a/include/power/spacemit_p1.h b/include/power/spacemit_p1.h
index 848bb469305..2e3a006282c 100644
--- a/include/power/spacemit_p1.h
+++ b/include/power/spacemit_p1.h
@@ -155,7 +155,8 @@ enum {
 };
 
 #define P1_BUCK_DRIVER			"p1_buck"
-#define P1_LDO_DRIVER			"p1_ldo"
+#define P1_ALDO_DRIVER			"p1_aldo"
+#define P1_DLDO_DRIVER			"p1_dldo"
 #define P1_SWITCH_DRIVER		"p1_switch"
 #define P1_WDT_DRIVER			"p1_wdt"
 
-- 
2.25.1

