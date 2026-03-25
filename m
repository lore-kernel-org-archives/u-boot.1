Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC834109E527
	for <u-boot@archiver.kernel.org>; Wed, 25 Mar 2026 22:35:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ABDFA83E7A;
	Wed, 25 Mar 2026 23:33:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="KkLnfIzr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E775D840ED; Wed, 25 Mar 2026 23:33:28 +0100 (CET)
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com
 [IPv6:2607:f8b0:4864:20::72d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 68E15840F1
 for <u-boot@lists.denx.de>; Wed, 25 Mar 2026 23:33:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymondmaoca@gmail.com
Received: by mail-qk1-x72d.google.com with SMTP id
 af79cd13be357-8cd8c6e365eso47620185a.0
 for <u-boot@lists.denx.de>; Wed, 25 Mar 2026 15:33:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774478005; x=1775082805; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gjawqQ1KfcSr5CO973ACirRx4W9wDBkvAwDUZ6icL0Q=;
 b=KkLnfIzrMYf91YVnY3QFoLZJNVsIlb55LpLCNpWYuP94gx3ILeG+aRFKhPrMy7fPpI
 pc2FXgU5majfMlJl85I3r+OeraJ2wV8xQAU+voRBeauAPviKMYtJk6yUcZR73DbETD14
 H/4Y4qCmUIWhW0L8lG2qyOipea0wTvfRgLqg6Pd/d9Pvd4Tit8gGM3Z6qSwQ2rMfOXO1
 tMDFLgvcVaUk77F7IycJH4kVZ+4+upBGukSIJjfOTRfiysoBB07CaBCgDQ4xFNgnpbEt
 nFroIjk//K/18Hky8vesR8uWT6YqKx/+uirGuSlndCOGw9kdN+31DNOi/lLooWixOFk5
 CTgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774478005; x=1775082805;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=gjawqQ1KfcSr5CO973ACirRx4W9wDBkvAwDUZ6icL0Q=;
 b=BFTDwBp/PeB/GSXxDrP6G9hGBNabZL79UDeZ5VgSvxCm2Id4cckB35O/Gl/ixv3ISw
 j3MckSw6R0GYK952MoPRB3YWLJmDlC0STMSJaMLH1qk1aBK/ijwPwr/nOvwVrjeV79Oz
 upcPzhD2/iFjCEo8RCCFa6IRtLJiOetlO9Sf3SOnD7/CcEwSQQ9QhrJOtmcz0rzycNwN
 tmqljpYmMWdCK4EyTOcxRpogflnhU6aeiTWmAYrYMX4uqQXmS7G8GOfYskDszt0cvUHz
 SrgqnRuMdfpVjWNcwyYpIYcKOxchEPpSZTlKUUpRbGKzaxKlzsTPU7L7nsILNUuvxfcu
 3Apg==
X-Gm-Message-State: AOJu0Yzpp+uWdzt/ZrQYuGvmWLSm2IL16K0IvpjQsP2vWxpu4In8GE6I
 GlJQ6CkVWZTnyKn1J/mP7pZKR1QkL3jIaeeMYOxRSN/fxUjpwZTKPWdhgn37fIVX
X-Gm-Gg: ATEYQzyDlPQqXlyNBFZ9l5Jp1W5t1oD1UCUY5ooeDxH1438xqrcELl+v/YCzsDLbLX+
 9V6VACTJvT+SbubvAFE/ruHM7OFntymDato7Hud7iw7BBd6j9ZukOPQWNW1LGUSngYv2MN+zMyW
 9RkU/TPUTeS19AeA9aK2IipVdMw5Y4XYZMrFcsBCmYJIh98r8KOt8RFMyVrp3F9A5X1TBIZ3luI
 o20yagFfKW2vbsAhvIFTsS89pbeSgvW8fFBeqeDc0QIRdH3OVXZ43aiO6JvOTeyGjoIv+KIT5RN
 0NdQNOJp680r9ZkmHawUyhFLVNtONb+G8UxLphd8k/3dqA2p7kxuNaDKbabDvQi9p5C+DcEgk4t
 /M2G+M70UY7ynriIoOH38VBbgorKuh6SXa9FTGaEoA7rOv4RawSZFo40THDFRHPEN1boPZjgJcy
 VoQVmpF9qZXTw1AhwnifVQ68KgTnfAm4y/MljtTlNT2qXSa3wMglU6qIYu7xVTWNZ0Duyyky0z5
 lCHutxVs7c=
X-Received: by 2002:a05:620a:c4d:b0:8cf:bcf7:fcf4 with SMTP id
 af79cd13be357-8d000f20d32mr789551685a.22.1774478004754; 
 Wed, 25 Mar 2026 15:33:24 -0700 (PDT)
Received: from ubuntu.localdomain (173-206-124-85.cpe.distributel.net.
 [173.206.124.85]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8d00e39fc17sm101540185a.5.2026.03.25.15.33.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Mar 2026 15:33:24 -0700 (PDT)
From: Raymond Mao <raymondmaoca@gmail.com>
To: u-boot@lists.denx.de
Cc: uboot@riscstar.com, u-boot-spacemit@groups.io, raymond.mao@riscstar.com,
 rick@andestech.com, ycliang@andestech.com, trini@konsulko.com,
 lukma@denx.de, hs@nabladev.com, jh80.chung@samsung.com, peng.fan@nxp.com,
 xypron.glpk@gmx.de, randolph@andestech.com, dlan@gentoo.org,
 junhui.liu@pigmoral.tech, neil.armstrong@linaro.org,
 quentin.schulz@cherry.de, samuel@sholland.org, raymondmaoca@gmail.com
Subject: [PATCH v3 15/16] power: regulator: add support for Spacemit P1 SoC
Date: Wed, 25 Mar 2026 18:32:31 -0400
Message-Id: <20260325223232.1553212-16-raymondmaoca@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260325223232.1553212-1-raymondmaoca@gmail.com>
References: <20260325223232.1553212-1-raymondmaoca@gmail.com>
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

From: Raymond Mao <raymond.mao@riscstar.com>

Support voltage regulator for Spacemit P1 SoC. It contains 6 BUCKs
and 11 LDOs.

Signed-off-by: Raymond Mao <raymond.mao@riscstar.com>
Acked-by: Peng Fan <peng.fan@nxp.com>
---
Changes in v3:
- Drop SPL_DM_REGULATOR_SPACEMIT_P1 Kconfig

 drivers/power/regulator/Kconfig               |   8 +
 drivers/power/regulator/Makefile              |   1 +
 .../power/regulator/spacemit_p1_regulator.c   | 460 ++++++++++++++++++
 3 files changed, 469 insertions(+)
 create mode 100644 drivers/power/regulator/spacemit_p1_regulator.c

diff --git a/drivers/power/regulator/Kconfig b/drivers/power/regulator/Kconfig
index 4f39e46cebd..ddfbfd1483d 100644
--- a/drivers/power/regulator/Kconfig
+++ b/drivers/power/regulator/Kconfig
@@ -547,3 +547,11 @@ config DM_REGULATOR_MT6359
 	  MediaTek MT6359 PMIC.
 	  This driver supports the control of different power rails of device
 	  through regulator interface.
+
+config DM_REGULATOR_SPACEMIT_P1
+	bool "Enable driver for Spacemit P1 PMIC regulators"
+	depends on DM_REGULATOR && PMIC_SPACEMIT_P1
+	help
+	  Enable implementation of driver-model regulator uclass features
+	  for regulator P1. The driver supports BUCKs, LDOs and SWITCHes.
+
diff --git a/drivers/power/regulator/Makefile b/drivers/power/regulator/Makefile
index 9e303d4f7f8..8103382951b 100644
--- a/drivers/power/regulator/Makefile
+++ b/drivers/power/regulator/Makefile
@@ -29,6 +29,7 @@ obj-$(CONFIG_$(PHASE_)REGULATOR_RK8XX) += rk8xx.o
 obj-$(CONFIG_DM_REGULATOR_S2MPS11) += s2mps11_regulator.o
 obj-$(CONFIG_REGULATOR_S5M8767) += s5m8767.o
 obj-$(CONFIG_DM_REGULATOR_SANDBOX) += sandbox.o
+obj-$(CONFIG_DM_REGULATOR_SPACEMIT_P1) += spacemit_p1_regulator.o
 obj-$(CONFIG_REGULATOR_TPS65090) += tps65090_regulator.o
 obj-$(CONFIG_$(PHASE_)DM_REGULATOR_PALMAS) += palmas_regulator.o
 obj-$(CONFIG_$(PHASE_)DM_REGULATOR_PBIAS) += pbias_regulator.o
diff --git a/drivers/power/regulator/spacemit_p1_regulator.c b/drivers/power/regulator/spacemit_p1_regulator.c
new file mode 100644
index 00000000000..ab3ca489f0b
--- /dev/null
+++ b/drivers/power/regulator/spacemit_p1_regulator.c
@@ -0,0 +1,460 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2025-2026 RISCstar Ltd.
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
-- 
2.25.1

