Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CA06C43458
	for <u-boot@archiver.kernel.org>; Tue, 30 Jun 2026 01:21:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C2F3A84AFF;
	Tue, 30 Jun 2026 03:20:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=riscstar.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b="0n583weU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9D66884AFF; Tue, 30 Jun 2026 03:20:32 +0200 (CEST)
Received: from mail-dl1-x1233.google.com (mail-dl1-x1233.google.com
 [IPv6:2607:f8b0:4864:20::1233])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 07F6F84AFD
 for <u-boot@lists.denx.de>; Tue, 30 Jun 2026 03:20:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=riscstar.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=eric.chung@riscstar.com
Received: by mail-dl1-x1233.google.com with SMTP id
 a92af1059eb24-13809223fd4so4856482c88.1
 for <u-boot@lists.denx.de>; Mon, 29 Jun 2026 18:20:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1782782428; x=1783387228;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=9mdAml/pbfQBkEazFguL1JckRlJSX088RVqqwlBBjSc=;
 b=0n583weUFARC13+bDMhI0Xs8KZPr0y/IagOwehRI7pb5k1KxUCPx+J0A5l2YIj/zx2
 dKzexmOVH19udteMd/t6O4hZskxrYJjLl3BLQycXXHKaOu3+abdrFSansyaNHbqzSZB2
 PHrF1LsMtMFUA97Bc9P7C3+/0duHCrb9FsnyckMtY31g4PvekOSIZxIdcD21BDcmpqyM
 xP2XCOLhpMpuleQjVKcktn8PyIgo62PXODNB8fftnvzKoTgJU4cYaFNV7yQynYQ7bGna
 gNoLGC1k/S8einiumJSM/5YIxeMosJaPSVSkV52ZsnzloayoqE41tGV0ZFFm4u8r/rE3
 hQBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782782428; x=1783387228;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=9mdAml/pbfQBkEazFguL1JckRlJSX088RVqqwlBBjSc=;
 b=C54peOgwoo82t+6A+E7rP7gkHUGyhrWsvkntdP6A3unKUsmKqGaZDmXrZzUxHMCJIz
 8OKgWudprXr0puXNEg9hXJq9kng+qukxvMu91mJhmohm/UGWPdR+EYFfa5Vjie6gcuuU
 l/+OL3ZAoMBRR3JlUDd6QoUdK58EtWncsFKi/X2R7QNHaUn3WU5M0JFNQJsxouFIp7vF
 6ag2lcgBPiq4O3EwWvXkXSfhsPoEj+UcaLhvxERS7vcEjpEJFCgUNLFDlhO404dmBk7N
 33PeMhhIY56621/L129Cz/q0cxiKwYOuOpdt0u1DPOi3IwTlxIerJdT4D3cPV9qoCj92
 QidQ==
X-Gm-Message-State: AOJu0YxhYl/5hc1Idehw8j8aCLDugySafHV8orSjfRRqfhgHSEgVs3sJ
 iTr3oaUOoCmG5hIoB0A6q10JbLBs01OqerVeFLyDhdcV7TMmvV6KiyNqJw6Phd8Nv3M=
X-Gm-Gg: AfdE7ckwtijxzu2U9T81StsM6hmHpFw8279CfcWNfWzKh/juHufAXzjT5Ic2uAvQEbH
 /pRbpFOl6GL3AEmhUEqfGx8zylAg/DCh5Na+sli1sdE2IwJz2QkCHhHpEvvYZkZCFZbOLpfvWDk
 uiMuGFvLRu4/BxfoqvdMKQb8Jqdf5/gjkRzNzk5yYbJgpsyLWAp1OLNVchRrxpVenfgtyNN7UnD
 kN52HErPlA9wSSvM7gQcmFlT01VhDwALobW2ZYK/NXLJkvoiMDwfBfPMFnaveiJcUs0W3wfD/84
 c6SDACYw0nd+usejfkGM42QMwk+XbcFx59EkNj8RDy0FbCty2eywfyBRse84UbuPVK8t637maSX
 itEbuJ84Jed1u3qL6Kic6XOQVWO6Kax4GyISC79DTRIJniDJgd7KUhMn9TlSyNi+CyPpOYJnnTn
 izxr5w8FLC7DtKpzv4Tkrp6dl+WVROBzQxzjMsGmA7I4XQ1+YqMSLpoOvTgaLpHbduASD8fWdhS
 IgkHQLRykgVAbBaD/eJaqSSGG4m9S87+qerYq8r3WKXQyQM2+CHLg==
X-Received: by 2002:a05:7022:ec0c:b0:138:637:6227 with SMTP id
 a92af1059eb24-13b2a1603famr1024811c88.11.1782782428328; 
 Mon, 29 Jun 2026 18:20:28 -0700 (PDT)
Received: from [127.0.1.1] ([209.170.101.129])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13b2a9b425asm2806974c88.0.2026.06.29.18.20.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jun 2026 18:20:27 -0700 (PDT)
From: Eric Chung <eric.chung@riscstar.com>
Date: Tue, 30 Jun 2026 09:19:13 +0800
Subject: [PATCH v5 12/14] power: regulator: add support for Spacemit P1 SoC
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260630-m1-v1-12-83f13347b3ba@riscstar.com>
References: <20260630-m1-v1-0-83f13347b3ba@riscstar.com>
In-Reply-To: <20260630-m1-v1-0-83f13347b3ba@riscstar.com>
To: u-boot@lists.denx.de, u-boot-spacemit@groups.io, 
 Yixun Lan <dlan@gentoo.org>
Cc: Tim Ouyang <tim609@andestech.com>, Leo Liang <leo.liang@sifive.com>, 
 Tom Rini <trini@konsulko.com>, Huan Zhou <pericycle.cc@gmail.com>, 
 Jamie Gibbons <jamie.gibbons@microchip.com>, 
 Randolph Sheng-Kai Lin <randolph@andestech.com>, 
 Conor Dooley <conor.dooley@microchip.com>, Yao Zi <me@ziyao.cc>, 
 Peng Fan <peng.fan@nxp.com>, Sam Protsenko <semen.protsenko@linaro.org>, 
 Lukasz Majewski <lukma@denx.de>, Heiko Schocher <hs@nabladev.com>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Bastien Curutchet <bastien.curutchet@bootlin.com>, 
 Johan Jonker <jbx6244@gmail.com>, 
 Justin Swartz <justin.swartz@risingedge.co.za>, 
 Jaehoon Chung <jh80.chung@samsung.com>, Henrik Grimler <henrik@grimler.se>, 
 Macpaul Lin <macpaul.lin@mediatek.com>, 
 Eric Chung <eric.chung@riscstar.com>, 
 Raymond Mao <raymond.mao@riscstar.com>, Guodong Xu <guodong@riscstar.com>, 
 Songsong Zhang <sszhang@vsit.ai>
X-Mailer: b4 0.15.2
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
Signed-off-by: Guodong Xu <guodong@riscstar.com>
Tested-by: Songsong Zhang <sszhang@vsit.ai>
---
 drivers/power/regulator/Kconfig                 |   7 +
 drivers/power/regulator/Makefile                |   1 +
 drivers/power/regulator/spacemit_p1_regulator.c | 464 ++++++++++++++++++++++++
 3 files changed, 472 insertions(+)

diff --git a/drivers/power/regulator/Kconfig b/drivers/power/regulator/Kconfig
index 3b3ed97eb9f..2e564536ec9 100644
--- a/drivers/power/regulator/Kconfig
+++ b/drivers/power/regulator/Kconfig
@@ -557,3 +557,10 @@ config DM_REGULATOR_MT6359
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
diff --git a/drivers/power/regulator/Makefile b/drivers/power/regulator/Makefile
index 36a84e7cd71..308a79f6816 100644
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
index 00000000000..7b5eb710edf
--- /dev/null
+++ b/drivers/power/regulator/spacemit_p1_regulator.c
@@ -0,0 +1,464 @@
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
+	if (idx < 1 || idx > ARRAY_SIZE(p1_aldos))
+		return NULL;
+	return &p1_aldos[idx - 1];
+}
+
+static const struct p1_reg_info *get_dldo_reg(struct udevice *pmic,
+					      int idx, int uvolt)
+{
+	if (idx < 1 || idx > ARRAY_SIZE(p1_dldos))
+		return NULL;
+	return &p1_dldos[idx - 1];
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
2.51.0

