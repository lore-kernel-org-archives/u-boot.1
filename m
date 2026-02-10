Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DECE2EA8128
	for <u-boot@archiver.kernel.org>; Tue, 10 Feb 2026 15:17:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D45E383E83;
	Tue, 10 Feb 2026 16:15:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="dccDsxPe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E186F83E83; Tue, 10 Feb 2026 16:15:56 +0100 (CET)
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com
 [IPv6:2607:f8b0:4864:20::f2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 75C7683CF3
 for <u-boot@lists.denx.de>; Tue, 10 Feb 2026 16:15:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymondmaoca@gmail.com
Received: by mail-qv1-xf2d.google.com with SMTP id
 6a1803df08f44-896f632d206so27473086d6.0
 for <u-boot@lists.denx.de>; Tue, 10 Feb 2026 07:15:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1770736553; x=1771341353; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fAetLzgLBQ1yxUG2kf9nroCVFI+O5nNhtfX8H4GbgYA=;
 b=dccDsxPeoaYEebF3fVA7hBY9syPB111uQBaM9iXWJylS6zycKSv5G4kzgxWlKpcsph
 S03DGpMk4vrCqbhb8JARwyxOFZ/gkb8oTA/1VRFRca8dfwl2XY9PW6sopRrft2gM81mf
 TaJM94NaeOL0QZmat0c839hn5N9IAzWdFuRl+MTXFNUiK6G2g9RF+kc5MfZ6lLmoX6U5
 Q4cS5RITyzAF7v2WBd2/wyH4GRtyYqAWZC5fD1agZjwlBiygsWzyNkmqLRnzLM4F3w7z
 tG+Phh66j0wseospZPqTeHAHS1MpwYNwOmmKbnCKmwPrNsH+sboXtW6qHSOp4zIOdKKZ
 6sfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770736553; x=1771341353;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=fAetLzgLBQ1yxUG2kf9nroCVFI+O5nNhtfX8H4GbgYA=;
 b=a+oglbNFDa3V++Il/O3sHuYZbXNgzB4hhZSVEoWHVQ+yniR1mcxDRCsLyHnPG89LXa
 ZlxYYoRyrv0+2oXKhOyEoNcQQjhRnfW+iRwSMUE6P7h6xhBp7ZgBcOmb3gt2P66KaoGj
 nvU9baryNsMJo8VPcRIUNUoqlGR/we5lK6wd1piozGi3AG1Dl+ZdE2Y7f+2d6QQ4WucK
 iDCdVrakMGfxUDxr30mukgENLGCbPd+lZE8IWtS7HmYT6p1RGWYL8YCi6fZtbvce0HUu
 yrS1DBhA89swCxGRE9Y6TfhnfRw1gk0wTb3/y6Uk9Sed3hEKqpUHh+G1IJCQPlS13mKd
 KG7A==
X-Gm-Message-State: AOJu0YzsudbzINW8Nh9el4wJcW9svwhCr2c2u0w8i0QiPoyULB8Qutjh
 NssQXbKgmzRU5G5hUK90F9wzkx8p6TsTzWOZDIh0zDO7e2kaWI684EgXd/GPiw==
X-Gm-Gg: AZuq6aLRwS0GrV6Nr3eN9Ee6IwTjQtCpx7RTSZnfnNiKumJtX8kUN8yy4XefAkpw2rK
 PP4dothMhdipY/zU1XlZUfRgya7vFzuIzyYkXZdS9x7n2vZzW2KaRl59mGRo4A0wzZvB+Gp3dGz
 T1s5EV3L9WbIXNC7olKTrfC+iQ84pVyATJzV3CatQpAFbHDdpzMooVwzSB4Osl01Ty9hDxxho00
 CX62O5EOPeSF/zTJMiGD9skO/RBsgAeDqV9mDtX/fxgHmbkJFeCNkGWRAk9i1PAwue4lEqRxurg
 drVARZk21dqnoIjFVYSdajLb3uh+dWq7kx6Ax8RYnP4f295HldZecBV2ZD9BZnYK/vrXXXSiqxg
 fNFV+k2yKTl3PotyQ0vGoIbInVU3/pMQjm9P+Osh1s/2Vx66+BGZl0pVHAFUBtcbVoZtE2V6eo1
 JgoOeJJFvfKCrVGYGpgI4CjS7gMsae3OuT+MPHR2d5gEdEXjiMJPUojVYGqriWvxdeAwYcY/Zd3
 aF59nn01n8=
X-Received: by 2002:a05:6214:1d29:b0:895:d679:ecde with SMTP id
 6a1803df08f44-8970d8bbc5cmr35102096d6.27.1770736552990; 
 Tue, 10 Feb 2026 07:15:52 -0800 (PST)
Received: from ubuntu.localdomain (174-138-202-16.cpe.distributel.net.
 [174.138.202.16]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8953c057751sm101019286d6.43.2026.02.10.07.15.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Feb 2026 07:15:52 -0800 (PST)
From: Raymond Mao <raymondmaoca@gmail.com>
To: u-boot@lists.denx.de
Cc: uboot@riscstar.com, u-boot-spacemit@groups.io, raymond.mao@riscstar.com,
 rick@andestech.com, ycliang@andestech.com, trini@konsulko.com,
 lukma@denx.de, hs@nabladev.com, jh80.chung@samsung.com, peng.fan@nxp.com,
 xypron.glpk@gmx.de, randolph@andestech.com, dlan@gentoo.org,
 junhui.liu@pigmoral.tech, neil.armstrong@linaro.org,
 quentin.schulz@cherry.de, samuel@sholland.org, raymondmaoca@gmail.com
Subject: [PATCH v2 15/16] power: regulator: add support for Spacemit P1 SoC
Date: Tue, 10 Feb 2026 10:14:58 -0500
Message-Id: <20260210151459.2348758-16-raymondmaoca@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260210151459.2348758-1-raymondmaoca@gmail.com>
References: <20260210151459.2348758-1-raymondmaoca@gmail.com>
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
---
 drivers/power/regulator/Kconfig               |  15 +
 drivers/power/regulator/Makefile              |   1 +
 .../power/regulator/spacemit_p1_regulator.c   | 460 ++++++++++++++++++
 3 files changed, 476 insertions(+)
 create mode 100644 drivers/power/regulator/spacemit_p1_regulator.c

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

