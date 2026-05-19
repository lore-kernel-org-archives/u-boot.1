Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F319BCD343F
	for <u-boot@archiver.kernel.org>; Mon, 18 May 2026 22:40:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2AD52847C8;
	Tue, 19 May 2026 00:38:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=riscstar.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b="xpKoBv7u";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9CA6B846A4; Tue, 19 May 2026 00:32:36 +0200 (CEST)
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com
 [IPv6:2607:f8b0:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7C8948465A
 for <u-boot@lists.denx.de>; Tue, 19 May 2026 00:32:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=riscstar.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=guodong@riscstar.com
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-2ba4efedbeaso20578995ad.1
 for <u-boot@lists.denx.de>; Mon, 18 May 2026 15:32:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1779143552; x=1779748352;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=L9D78xd7NsGqSxhOoim1gTERZAOU3Pslje3bmkdgFos=;
 b=xpKoBv7u0ixRmogEZYg9r60ZtEIraPUly3wD3LXWz3ROId6WJXDYuHzU95xtpWPDkW
 x1ygJotLtZSggQVQHQIrnBT8B72p9Of8x37/DdrcXmiz3rpnb3SeJGU3nRZSR118WIzt
 YgqZg6q79FBhz4oKdJBdf0DwW/LtaRaUz/slofCRot88ACK9VCISBEnkBRPS16z2km5u
 4JTYdYdYdcooy0WBuDPvjzISoJvdzzE18iEZjiddaIsU7xfid8KMbOZNS0EQUP6v5NtU
 ln087UYXk+cEqiU+QJZw4ZdqKlX5A4KpwMmR4reoxvz0HOrG6nc3IGzQQsl38N3J4LoR
 tzcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779143552; x=1779748352;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=L9D78xd7NsGqSxhOoim1gTERZAOU3Pslje3bmkdgFos=;
 b=RYQsrNDMBycjFExignMZWOIPGR8TXPNYjMsW1paf4107gbdC2h3yKuuEKQ6IxJW8FA
 6nJu5hp+o9fkS+7hJWJPYca1qQbzJmuI/YuaXadq4zjoAC3iQlcrCYr3g5282OKmFMLo
 PqfrxxnldYLbNGYtUMpC1x9/b/FNltrLZSqxU8Toyw/LXrxStNy17N5V6OAsb31eZOI/
 FHQf2V/MDJvoZcHfQs9oSdhcVny7BXYy07b2BrUc16E77T1mbNeQx80y/9RtytP43m2j
 fzH/G8o5vJ+MYQEhmhx9dSaV+WHlRqkkhBXKQ5VaQGYnJ/Acv1yblX5zRUN/t3FVlx89
 xEwQ==
X-Gm-Message-State: AOJu0YwXGYfwLLlEdJgg+P3y+HlPiiruTKUPSg7R3HXpqukEowqmtZ9B
 WPQdzFkLgfR1jQM0N5b90+9aj+37OotJr5kuwPypR5zjlevlRwxiDSVrlatJ3S3UCt4=
X-Gm-Gg: Acq92OGDddAr4xfMWi7cQW71uF4SDq2bvCf+AZgXmHk7Imrlkm1Jmzo+Q51UibCjUgf
 vaJcFLfhIGcp2wVFAXe2lzjDbhUFkLnuq/FvfNKHQ1IF0MTQ5JQJaNhyskUFf6D2bDcp/jEB4tJ
 U3ls7TKVUY5P2dsvyTRRUqFsrfUlcoxf3bSPX+H5taBdiKI5IbZMtQKZMASAWzKLRGVaWIX5j6k
 JGCfKaoyXBCUOEJ6RlLeXCyZEH9/Q+99PivPdYX9w4kK0AkgfNnB8u5b+4Z2t7HDYFCRpzCGIeS
 +y8tpoSUlUwmrHrSIvck7FdlIAFKPvKH7Qbx68+y5H2M/o6/CktA6HaK0a9B72lGE4Uksuxvu9r
 lutCzREcY0oPgtFvmnhMntAfIyPW24C5Np8Xadb4NEZyKYehadJ3sdyhojxiSYBvMY+ayeTfHU8
 lON1k44MJOaNnjCeG1U2J8Gu+elxf6lvg8sQAtF0PeVhfLD4FamMO1HA==
X-Received: by 2002:a17:902:d506:b0:2b4:5f19:1d34 with SMTP id
 d9443c01a7336-2bd7e844a97mr194113355ad.17.1779143551884; 
 Mon, 18 May 2026 15:32:31 -0700 (PDT)
Received: from [127.0.1.1] ([2a12:a305:4::4072])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2bd5bd5ef27sm206379265ad.8.2026.05.18.15.32.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 May 2026 15:32:31 -0700 (PDT)
From: Guodong Xu <guodong@riscstar.com>
Date: Tue, 19 May 2026 06:26:30 -0400
Subject: [PATCH v4 12/14] power: regulator: add support for Spacemit P1 SoC
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260519-b4-k1-spl-bring-up-v4-12-3915a2a904c1@riscstar.com>
References: <20260519-b4-k1-spl-bring-up-v4-0-3915a2a904c1@riscstar.com>
In-Reply-To: <20260519-b4-k1-spl-bring-up-v4-0-3915a2a904c1@riscstar.com>
To: u-boot@lists.denx.de, Kongyang Liu <seashell11234455@gmail.com>, 
 Yixun Lan <dlan@gentoo.org>
Cc: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>, 
 Michal Simek <michal.simek@amd.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Yao Zi <me@ziyao.cc>, 
 Junhui Liu <junhui.liu@pigmoral.tech>, 
 Peter Korsgaard <peter@korsgaard.com>, 
 Leo Yu-Chi Liang <ycliang@andestech.com>, 
 Raymond Mao <raymond.mao@riscstar.com>, 
 Gabriel Fernandez <gabriel.fernandez@foss.st.com>, 
 Kever Yang <kever.yang@rock-chips.com>, 
 Finley Xiao <finley.xiao@rock-chips.com>, Rick Chen <rick@andestech.com>, 
 Conor Dooley <conor.dooley@microchip.com>, u-boot-spacemit@groups.io, 
 Vincent Legoll <legoll@online.fr>, Huan Zhou <pericycle.cc@gmail.com>, 
 Jamie Gibbons <jamie.gibbons@microchip.com>, 
 Randolph Sheng-Kai Lin <randolph@andestech.com>, 
 Sam Protsenko <semen.protsenko@linaro.org>, Peng Fan <peng.fan@nxp.com>, 
 Heiko Schocher <hs@nabladev.com>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Justin Swartz <justin.swartz@risingedge.co.za>, 
 Jaehoon Chung <jh80.chung@samsung.com>, 
 David Lechner <dlechner@baylibre.com>, Julien Masson <jmasson@baylibre.com>, 
 Macpaul Lin <macpaul.lin@mediatek.com>, Henrik Grimler <henrik@grimler.se>, 
 Kory Maincent <kory.maincent@bootlin.com>, Anshul Dalal <anshuld@ti.com>, 
 Bo-Chen Chen <rex-bc.chen@mediatek.com>, 
 Justin Klaassen <justin@tidylabs.net>, Guodong Xu <guodong.xu@riscstar.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Guodong Xu <guodong@riscstar.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>
X-Mailer: b4 0.15.1
X-Mailman-Approved-At: Tue, 19 May 2026 00:38:07 +0200
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

---
v4:
- Bounds-check + 1-based indexing in p1_aldo()/p1_dldo().
---
 drivers/power/regulator/Kconfig                 |   7 +
 drivers/power/regulator/Makefile                |   1 +
 drivers/power/regulator/spacemit_p1_regulator.c | 464 ++++++++++++++++++++++++
 3 files changed, 472 insertions(+)

diff --git a/drivers/power/regulator/Kconfig b/drivers/power/regulator/Kconfig
index ca5de5b8726..e6083b5d161 100644
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
2.43.0

