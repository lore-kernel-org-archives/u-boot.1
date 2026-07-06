Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFF37C43458
	for <u-boot@archiver.kernel.org>; Mon,  6 Jul 2026 10:53:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 473A5846F8;
	Mon,  6 Jul 2026 12:53:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=free.fr header.i=@free.fr header.b="fWUp/XxI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 448B1848D2; Mon,  6 Jul 2026 12:53:41 +0200 (CEST)
Received: from smtp6-g21.free.fr (smtp6-g21.free.fr [212.27.42.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B347784105
 for <u-boot@lists.denx.de>; Mon,  6 Jul 2026 12:53:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=vjardin@free.fr
Received: from localhost.localdomain (unknown [213.36.7.12])
 (Authenticated sender: vjardin@free.fr)
 by smtp6-g21.free.fr (Postfix) with ESMTPSA id 5893E78050B;
 Mon,  6 Jul 2026 12:53:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
 s=smtp-20201208; t=1783335218;
 bh=UbFWii8mDa+HB652DdjegyjZAkHS3TDloh8+rcoX0MU=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=fWUp/XxI8+d9APLcTmvZRu6cYNx323YkhwyoEc7ApY/5pZnaWhq45gL6Pr/DlxOPA
 PlLZrphsaLPYvxDz5+0UnLzErwNeLjoNjIl1VuGkkBGr+D7aTg9rHf9CjoDcWYPtZt
 gsuLS5yCYmNeaubT7crzicuBhNW8G1MW1m9S0K58VrkV6EoIRTZzeQNGJMdUf8Xw+w
 aJkkkspY17EWkfmXAcQpF4F6lyOI54ot4pnZA2KHeNLOPpKAgwfj9R72/J7lWwXdSq
 4InWda/1zqaBSnqIgf9UswezhXjy9rVB9S1XQhGsAef2mlSs0ovgmn7KCfkromlVWV
 kBCQrZgEjxIOg==
From: Vincent Jardin <vjardin@free.fr>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Simon Glass <sjg@chromium.org>,
 Jerome Forissier <jerome.forissier@arm.com>, Peng Fan <peng.fan@nxp.com>,
 Vincent Jardin <vjardin@free.fr>
Subject: [PATCH v3 2/7] power: regulator: add generic PMBus UCLASS_REGULATOR
 adapter
Date: Mon,  6 Jul 2026 12:50:53 +0200
Message-ID: <20260706105111.2018334-3-vjardin@free.fr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260706105111.2018334-1-vjardin@free.fr>
References: <20260706105111.2018334-1-vjardin@free.fr>
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

PMBus regulators differ in numeric formats and quirks, not in how they
are driven. Share that common behaviour as a regulator-uclass adapter
so chip drivers and the pmbus CLI do not each reimplement the decode
and transport, and add a catch-all driver on compatible = "pmbus" for
compliant chips that have no dedicated driver yet.

Gated by CONFIG_DM_REGULATOR_PMBUS_HELPER and
CONFIG_DM_REGULATOR_PMBUS_GENERIC.

Signed-off-by: Vincent Jardin <vjardin@free.fr>
---

(no changes since v1)

 MAINTAINERS                             |   3 +
 drivers/power/regulator/Kconfig         |  24 ++
 drivers/power/regulator/Makefile        |   2 +
 drivers/power/regulator/pmbus_generic.c |  90 +++++++
 drivers/power/regulator/pmbus_helper.c  | 315 ++++++++++++++++++++++++
 drivers/power/regulator/pmbus_helper.h  |  90 +++++++
 include/pmbus.h                         |  37 +++
 lib/pmbus.c                             |  17 ++
 8 files changed, 578 insertions(+)
 create mode 100644 drivers/power/regulator/pmbus_generic.c
 create mode 100644 drivers/power/regulator/pmbus_helper.c
 create mode 100644 drivers/power/regulator/pmbus_helper.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 39e333f8f70..123ea9ed3ed 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1585,6 +1585,9 @@ M:	Vincent Jardin <vjardin@free.fr>
 S:	Maintained
 F:	cmd/pmbus.c
 F:	doc/develop/pmbus.rst
+F:	drivers/power/regulator/pmbus_generic.c
+F:	drivers/power/regulator/pmbus_helper.c
+F:	drivers/power/regulator/pmbus_helper.h
 F:	include/pmbus.h
 F:	lib/pmbus.c
 
diff --git a/drivers/power/regulator/Kconfig b/drivers/power/regulator/Kconfig
index ca5de5b8726..5b1a9c3f991 100644
--- a/drivers/power/regulator/Kconfig
+++ b/drivers/power/regulator/Kconfig
@@ -557,3 +557,27 @@ config DM_REGULATOR_MT6359
 	  MediaTek MT6359 PMIC.
 	  This driver supports the control of different power rails of device
 	  through regulator interface.
+
+config DM_REGULATOR_PMBUS_HELPER
+	bool "Shared regulator helpers for PMBus chip drivers"
+	depends on DM_REGULATOR && PMBUS && DM_I2C
+	help
+	  Provide shared get_value / set_value / get_enable / set_enable
+	  operations for UCLASS_REGULATOR drivers that bind PMBus 1.x
+	  compliant voltage regulators. Per chip drivers
+	  (mps,mpq8785, lltc,ltc3882, ...) consume this helper to avoid
+	  duplicating the LINEAR16 / DIRECT decoder dispatch and the
+	  VOUT_MODE / VOUT_COMMAND / OPERATION transport sequences.
+
+config DM_REGULATOR_PMBUS_GENERIC
+	bool "Generic PMBus 1.x regulator driver (compatible=\"pmbus\")"
+	depends on DM_REGULATOR_PMBUS_HELPER
+	help
+	  Catch all UCLASS_REGULATOR driver bound to compatible = "pmbus".
+	  Auto detects the VOUT numeric format from the chip's VOUT_MODE
+	  register and exposes telemetry plus voltage set / get against
+	  the standard PMBus 1.x command codes. Use this for PMBus
+	  compliant chips that have no per chip driver yet; promote to a
+	  per chip driver only when chip specific quirks (vendor
+	  registers, VID coercion, ADDR pin auto promotion, non standard
+	  m / b / R coefficients) need handling.
diff --git a/drivers/power/regulator/Makefile b/drivers/power/regulator/Makefile
index 36a84e7cd71..b084e9ac4bc 100644
--- a/drivers/power/regulator/Makefile
+++ b/drivers/power/regulator/Makefile
@@ -49,3 +49,5 @@ obj-$(CONFIG_REGULATOR_RZG2L_USBPHY) += rzg2l-usbphy-regulator.o
 obj-$(CONFIG_$(PHASE_)DM_REGULATOR_CPCAP) += cpcap_regulator.o
 obj-$(CONFIG_DM_REGULATOR_MT6357) += mt6357_regulator.o
 obj-$(CONFIG_DM_REGULATOR_MT6359) += mt6359_regulator.o
+obj-$(CONFIG_DM_REGULATOR_PMBUS_HELPER)  += pmbus_helper.o
+obj-$(CONFIG_DM_REGULATOR_PMBUS_GENERIC) += pmbus_generic.o
diff --git a/drivers/power/regulator/pmbus_generic.c b/drivers/power/regulator/pmbus_generic.c
new file mode 100644
index 00000000000..6ba50ce08f8
--- /dev/null
+++ b/drivers/power/regulator/pmbus_generic.c
@@ -0,0 +1,90 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright 2026 Free Mobile, Vincent Jardin
+ *
+ * Generic PMBus 1.x compatible voltage regulator driver.
+ *
+ * Catch all driver bound to compatible = "pmbus" for chips that have
+ * no per chip driver under drivers/power/regulator/. The probe path
+ * detects the VOUT numeric format from VOUT_MODE bits[7:5]:
+ *
+ *   - 0  LINEAR16 with the exponent supplied via VOUT_MODE bits[4:0]
+ *   - 1  VID; mapped to pmbus_fmt_vid (decoder returns 0 today; per
+ *        chip driver still required to plug a VID table)
+ *   - 2  DIRECT; default coefficients m=1, b=0, R=0 (per chip
+ *        coefficients arrive via PMBUS_QUERY / PMBUS_COEFFICIENTS,
+ *        not yet consumed by U-Boot; values may need a per chip
+ *        driver if telemetry numbers are wrong)
+ *   - 3  IEEE754; mapped to pmbus_fmt_ieee754 (decoder returns 0
+ *        today; per chip driver required)
+ *
+ * Other sensor classes (VIN, IIN, IOUT, TEMPERATURE) default to
+ * LINEAR which is the spec baseline for compliant chips. If an
+ * operator sees wrong telemetry numbers on this driver, the answer
+ * is to write a per chip driver with the correct format[] / m / b / R.
+ *
+ * Adapted in spirit from linux/drivers/hwmon/pmbus/pmbus.c (the
+ * kernel's generic probe driver). The U-Boot version drops the
+ * page count auto detection (most generic compliant parts are
+ * single rail; multi rail chips are quirky enough to need a per
+ * chip driver) and the kernel hwmon publication layers.
+ */
+
+#include <dm.h>
+#include <i2c.h>
+#include <log.h>
+#include <pmbus.h>
+#include <power/regulator.h>
+
+#include "pmbus_helper.h"
+
+struct pmbus_generic_priv {
+	struct pmbus_regulator_priv base;	/* must be first */
+	struct pmbus_driver_info info;
+};
+
+static int pmbus_generic_probe(struct udevice *dev)
+{
+	struct pmbus_generic_priv *gpriv = dev_get_priv(dev);
+	struct pmbus_driver_info *info = &gpriv->info;
+	enum pmbus_sensor_classes c;
+	int ret;
+
+	info->pages = 1;
+	for (c = 0; c < PSC_NUM_CLASSES; c++) {
+		info->format[c] = pmbus_fmt_linear;
+		info->m[c] = 0;
+		info->b[c] = 0;
+		info->R[c] = 0;
+	}
+
+	ret = pmbus_regulator_probe_common(dev, info, 0);
+	if (ret)
+		return ret;
+
+	/*
+	 * Avoid reading non supported pages to avoid device's sticky
+	 * status.
+	 */
+	info->pages = dev_read_u32_default(dev, "pmbus,num-pages", 1);
+	if (info->pages < 1)
+		info->pages = 1;
+
+	pmbus_regulator_identify_vout(gpriv->base.i2c_dev, info);
+
+	return 0;
+}
+
+static const struct udevice_id pmbus_generic_ids[] = {
+	{ .compatible = "pmbus" },
+	{ }
+};
+
+U_BOOT_DRIVER(pmbus_generic_regulator) = {
+	.name      = "pmbus_generic_regulator",
+	.id        = UCLASS_REGULATOR,
+	.of_match  = pmbus_generic_ids,
+	.probe     = pmbus_generic_probe,
+	.ops       = &pmbus_regulator_ops,
+	.priv_auto = sizeof(struct pmbus_generic_priv),
+};
diff --git a/drivers/power/regulator/pmbus_helper.c b/drivers/power/regulator/pmbus_helper.c
new file mode 100644
index 00000000000..4763470442d
--- /dev/null
+++ b/drivers/power/regulator/pmbus_helper.c
@@ -0,0 +1,315 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright 2026 Free Mobile, Vincent Jardin
+ *
+ * Shared UCLASS_REGULATOR operations over the PMBus 1.x framework.
+ * See pmbus_helper.h for the API surface and doc/develop/pmbus.rst
+ * for the porting guide.
+ *
+ * No code in this file may reference a specific chip family or
+ * board. Chip specific quirks (vendor registers, VID coercion,
+ * ADDR pin auto promotion, byte reversed MFR strings, etc.) belong
+ * in the per chip driver under drivers/power/regulator/<chip>.c.
+ */
+
+#include <dm.h>
+#include <dm/device-internal.h>
+#include <dm/lists.h>
+#include <i2c.h>
+#include <log.h>
+#include <pmbus.h>
+#include <vsprintf.h>
+#include <linux/types.h>
+#include <power/regulator.h>
+
+#include "pmbus_helper.h"
+
+static int pmbus_regulator_select_page(struct pmbus_regulator_priv *priv)
+{
+	u8 p;
+
+	if (priv->page <= 0)
+		return 0;
+	p = (u8)priv->page;
+	return dm_i2c_write(priv->i2c_dev, PMBUS_PAGE, &p, 1);
+}
+
+static int pmbus_regulator_get_value(struct udevice *dev)
+{
+	struct pmbus_regulator_priv *priv = dev_get_priv(dev);
+	u8 vout_mode = 0;
+	u16 raw = 0;
+	s64 uv;
+	int ret;
+
+	ret = pmbus_regulator_select_page(priv);
+	if (ret)
+		return ret;
+	pmbus_read_byte(priv->i2c_dev, PMBUS_VOUT_MODE, &vout_mode);
+	if (pmbus_read_word(priv->i2c_dev, PMBUS_READ_VOUT, &raw))
+		return -EIO;
+
+	if (priv->info)
+		uv = pmbus_reg2data(priv->info, PSC_VOLTAGE_OUT, raw, vout_mode);
+	else
+		uv = pmbus_reg2data_linear16(raw, vout_mode);
+
+	if (uv > INT_MAX)
+		uv = INT_MAX;
+	if (uv < INT_MIN)
+		uv = INT_MIN;
+	return (int)uv;
+}
+
+static int pmbus_regulator_set_value(struct udevice *dev, int uV)
+{
+	struct pmbus_regulator_priv *priv = dev_get_priv(dev);
+	u8 vout_mode = 0;
+	u8 buf[2];
+	u16 raw;
+	int ret;
+
+	ret = pmbus_regulator_select_page(priv);
+	if (ret)
+		return ret;
+	if (pmbus_read_byte(priv->i2c_dev, PMBUS_VOUT_MODE, &vout_mode))
+		return -EIO;
+
+	/*
+	 * Dispatch on the chip's VOUT_MODE selector. LINEAR16 and DIRECT
+	 * are wired today; VID and IEEE754 return -ENOSYS until their
+	 * encoders land. For DIRECT, the m / b / R triple comes from the
+	 * chip's pmbus_driver_info[PSC_VOLTAGE_OUT]; if the per chip
+	 * driver did not populate them, the encoder cannot run.
+	 */
+	switch (vout_mode & PB_VOUT_MODE_MODE_MASK) {
+	case PB_VOUT_MODE_LINEAR:
+		raw = pmbus_data2reg_linear16((s64)uV, vout_mode);
+		break;
+	case PB_VOUT_MODE_DIRECT:
+		if (!priv->info ||
+		    priv->info->format[PSC_VOLTAGE_OUT] != pmbus_fmt_direct)
+			return -ENODATA;
+		raw = pmbus_data2reg_direct((s64)uV,
+					    priv->info->m[PSC_VOLTAGE_OUT],
+					    priv->info->b[PSC_VOLTAGE_OUT],
+					    priv->info->R[PSC_VOLTAGE_OUT]);
+		break;
+	default:
+		return -ENOSYS;
+	}
+
+	buf[0] = (u8)(raw & 0xff);
+	buf[1] = (u8)((raw >> 8) & 0xff);
+	return dm_i2c_write(priv->i2c_dev, PMBUS_VOUT_COMMAND, buf, 2);
+}
+
+static int pmbus_regulator_get_enable(struct udevice *dev)
+{
+	struct pmbus_regulator_priv *priv = dev_get_priv(dev);
+	u8 op = 0;
+	int ret;
+
+	ret = pmbus_regulator_select_page(priv);
+	if (ret)
+		return ret;
+	if (pmbus_read_byte(priv->i2c_dev, PMBUS_OPERATION, &op))
+		return -EIO;
+	return (op & PB_OPERATION_ON) ? 1 : 0;
+}
+
+static int pmbus_regulator_set_enable(struct udevice *dev, bool enable)
+{
+	struct pmbus_regulator_priv *priv = dev_get_priv(dev);
+	u8 op = 0;
+	int ret;
+
+	ret = pmbus_regulator_select_page(priv);
+	if (ret)
+		return ret;
+	if (pmbus_read_byte(priv->i2c_dev, PMBUS_OPERATION, &op))
+		return -EIO;
+
+	if (enable)
+		op |= PB_OPERATION_ON;
+	else
+		op &= (u8)~PB_OPERATION_ON;
+	return dm_i2c_write(priv->i2c_dev, PMBUS_OPERATION, &op, 1);
+}
+
+const struct dm_regulator_ops pmbus_regulator_ops = {
+	.get_value  = pmbus_regulator_get_value,
+	.set_value  = pmbus_regulator_set_value,
+	.get_enable = pmbus_regulator_get_enable,
+	.set_enable = pmbus_regulator_set_enable,
+};
+
+int pmbus_regulator_read_temp(struct udevice *reg_dev, int *temp_mc)
+{
+	struct pmbus_regulator_priv *priv;
+	u16 raw = 0;
+	s64 udeg;
+	int ret;
+
+	if (!reg_dev || !temp_mc)
+		return -EINVAL;
+	priv = dev_get_priv(reg_dev);
+	if (!priv || !priv->i2c_dev)
+		return -ENODEV;
+
+	ret = pmbus_regulator_select_page(priv);
+	if (ret)
+		return ret;
+	if (pmbus_read_word(priv->i2c_dev, PMBUS_READ_TEMPERATURE_1, &raw))
+		return -EIO;
+
+	/*
+	 * vout_mode is meaningless for the temperature class. With a
+	 * chip info record the dispatcher honours its per-class format
+	 * (DIRECT m/b/R for MPS, LINEAR11 for spec-compliant parts);
+	 * without one, fall back to the PMBus 1.x standard LINEAR11.
+	 */
+	if (priv->info)
+		udeg = pmbus_reg2data(priv->info, PSC_TEMPERATURE, raw, 0);
+	else
+		udeg = pmbus_reg2data_linear11(raw);
+
+	*temp_mc = (int)(udeg / 1000);
+	return 0;
+}
+
+enum pmbus_data_format
+pmbus_regulator_identify_vout(struct udevice *i2c_dev,
+			      struct pmbus_driver_info *info)
+{
+	u8 vout_mode = 0;
+
+	if (pmbus_read_byte(i2c_dev, PMBUS_VOUT_MODE, &vout_mode))
+		return info->format[PSC_VOLTAGE_OUT];
+
+	switch (vout_mode & PB_VOUT_MODE_MODE_MASK) {
+	case PB_VOUT_MODE_LINEAR:
+		info->format[PSC_VOLTAGE_OUT] = pmbus_fmt_linear;
+		break;
+	case PB_VOUT_MODE_VID:
+		info->format[PSC_VOLTAGE_OUT] = pmbus_fmt_vid;
+		break;
+	case PB_VOUT_MODE_DIRECT:
+		info->format[PSC_VOLTAGE_OUT] = pmbus_fmt_direct;
+		info->m[PSC_VOLTAGE_OUT] = 1;
+		info->b[PSC_VOLTAGE_OUT] = 0;
+		info->R[PSC_VOLTAGE_OUT] = 0;
+		break;
+	case PB_VOUT_MODE_IEEE754:
+		info->format[PSC_VOLTAGE_OUT] = pmbus_fmt_ieee754;
+		break;
+	default:
+		break;
+	}
+	return info->format[PSC_VOLTAGE_OUT];
+}
+
+const struct pmbus_driver_info *pmbus_regulator_info_by_addr(int bus_seq,
+							     u8 addr)
+{
+	struct uclass *uc;
+	struct udevice *r;
+
+	if (uclass_get(UCLASS_REGULATOR, &uc))
+		return NULL;
+
+	uclass_foreach_dev(r, uc) {
+		struct udevice *parent = dev_get_parent(r);
+		struct pmbus_regulator_priv *priv;
+		int ra;
+
+		if (!parent || device_get_uclass_id(parent) != UCLASS_I2C)
+			continue;
+		if (dev_seq(parent) != bus_seq)
+			continue;
+		ra = dev_read_addr(r);
+		if (ra < 0 || (u8)ra != addr)
+			continue;
+
+		/*
+		 * Address matches. Only chips driven through this helper
+		 * carry a pmbus_regulator_priv at the head of their priv;
+		 * identify them by their shared ops vector so we never
+		 * misread a foreign regulator's private layout.
+		 */
+		if (!r->driver || r->driver->ops != &pmbus_regulator_ops)
+			return NULL;
+		if (device_probe(r))
+			return NULL;
+		priv = dev_get_priv(r);
+		return priv ? priv->info : NULL;
+	}
+	return NULL;
+}
+
+/*
+ * Spawn the generic UCLASS_THERMAL companion (drivers/thermal/
+ * pmbus_thermal.c) as a child of this regulator so READ_TEMPERATURE_1
+ * is reachable through the standard `temperature list` / `temperature
+ * get` interface. Named "<regulator-name>-temp" so several PMBus rails
+ * on one board produce distinct, descriptive device names. Failure is
+ * non-fatal: the chip still works as a UCLASS_REGULATOR.
+ */
+static void pmbus_regulator_bind_thermal(struct udevice *dev)
+{
+	struct udevice *therm;
+	const char *rname;
+	char name[48];
+
+	if (!IS_ENABLED(CONFIG_PMBUS_THERMAL))
+		return;
+	if (device_bind_driver(dev, "pmbus_thermal", "pmbus-temp", &therm))
+		return;
+	rname = dev_read_string(dev, "regulator-name");
+	snprintf(name, sizeof(name), "%s-temp", rname ? rname : dev->name);
+	device_set_name(therm, name);
+}
+
+int pmbus_regulator_probe_common(struct udevice *dev,
+				 const struct pmbus_driver_info *info,
+				 int page)
+{
+	struct pmbus_regulator_priv *priv = dev_get_priv(dev);
+	int chip_addr;
+	int ret;
+
+	chip_addr = dev_read_addr(dev);
+	if (chip_addr < 0)
+		return -EINVAL;
+
+	ret = i2c_get_chip(dev_get_parent(dev), (u32)chip_addr, 1, &priv->i2c_dev);
+	if (ret)
+		return ret;
+
+	priv->info = info;
+	priv->page = page;
+
+	if (page > 0) {
+		u8 p = (u8)page;
+
+		ret = dm_i2c_write(priv->i2c_dev, PMBUS_PAGE, &p, 1);
+		if (ret)
+			return ret;
+	}
+
+	pmbus_regulator_bind_thermal(dev);
+	return 0;
+}
+
+int pmbus_regulator_apply_voltage_scale(struct udevice *dev,
+					u32 fb_divider_permille)
+{
+	struct pmbus_regulator_priv *priv = dev_get_priv(dev);
+	u8 buf[2];
+
+	if (fb_divider_permille == 0)
+		return 0;
+	buf[0] = (u8)(fb_divider_permille & 0xff);
+	buf[1] = (u8)((fb_divider_permille >> 8) & 0xff);
+	return dm_i2c_write(priv->i2c_dev, PMBUS_VOUT_SCALE_LOOP, buf, 2);
+}
diff --git a/drivers/power/regulator/pmbus_helper.h b/drivers/power/regulator/pmbus_helper.h
new file mode 100644
index 00000000000..82f263cd513
--- /dev/null
+++ b/drivers/power/regulator/pmbus_helper.h
@@ -0,0 +1,90 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Copyright 2026 Free Mobile, Vincent Jardin
+ *
+ * Shared UCLASS_REGULATOR ops for PMBus 1.x voltage regulator chips.
+ *
+ * Per chip drivers under drivers/power/regulator/<chip>.c bind a
+ * vendor,chip compatible from DT and call pmbus_regulator_probe_common()
+ * in their .probe. They install pmbus_regulator_ops as the .ops vector;
+ * the helper handles VOUT_MODE / READ_VOUT / VOUT_COMMAND / OPERATION
+ * via the tree level <pmbus.h> framework.
+ *
+ * Per chip drivers retain control of identify hooks (VOUT_MODE based
+ * format selection), chip specific quirks (vendor registers, ADDR pin
+ * auto promotion), and DT property handling (e.g. MPS
+ * mps,vout-fb-divider-ratio-permille).
+ */
+
+#ifndef _DRIVERS_POWER_REGULATOR_PMBUS_HELPER_H_
+#define _DRIVERS_POWER_REGULATOR_PMBUS_HELPER_H_
+
+#include <linux/types.h>
+#include <pmbus.h>
+
+struct udevice;
+struct dm_regulator_ops;
+
+/*
+ * Per chip private state. The first field of every per chip driver's
+ * priv_auto must be (or contain at offset 0) a struct
+ * pmbus_regulator_priv so the shared ops vector can recover it via
+ * dev_get_priv(dev).
+ *
+ *   i2c_dev   chip handle obtained from dev->parent at probe time
+ *             (the parent must be a UCLASS_I2C bus).
+ *   page      PMBUS_PAGE selector for multi rail chips. Single rail
+ *             chips set page = 0; the helper writes PMBUS_PAGE only
+ *             when page > 0 to avoid wasted bus traffic on single
+ *             rail parts.
+ *   info      pointer to the chip's pmbus_driver_info; consumed by
+ *             pmbus_reg2data() / pmbus_data2reg_linear16() to pick
+ *             the right format[] / m / b / R coefficients.
+ */
+struct pmbus_regulator_priv {
+	struct udevice *i2c_dev;
+	int page;
+	const struct pmbus_driver_info *info;
+};
+
+extern const struct dm_regulator_ops pmbus_regulator_ops;
+
+/*
+ * Per chip probe glue. Reads `reg` from DT, gets the I2C chip handle
+ * from dev->parent, populates priv->i2c_dev / page / info, and writes
+ * PMBUS_PAGE if page > 0. Per chip drivers call this in their .probe
+ * before any chip specific identification.
+ */
+int pmbus_regulator_probe_common(struct udevice *dev,
+				 const struct pmbus_driver_info *info,
+				 int page);
+
+/*
+ * Optional helper for per chip drivers that honour an external
+ * feedback divider DT property (e.g. MPS mps,vout-fb-divider-ratio-
+ * permille). Writes the supplied ratio to PMBUS_VOUT_SCALE_LOOP at
+ * probe time. fb_divider_permille == 0 leaves the chip default.
+ */
+int pmbus_regulator_apply_voltage_scale(struct udevice *dev,
+					u32 fb_divider_permille);
+
+/*
+ * Read PMBUS_VOUT_MODE and set info->format[PSC_VOLTAGE_OUT] from its
+ * mode selector bits[7:5] per PMBus 1.3 Part II sec 8.3:
+ *   LINEAR  -> pmbus_fmt_linear
+ *   VID     -> pmbus_fmt_vid
+ *   DIRECT  -> pmbus_fmt_direct (default coefficients m=1, b=0, R=0)
+ *   IEEE754 -> pmbus_fmt_ieee754
+ *
+ * The single place that knows the VOUT_MODE bit layout; both the
+ * generic regulator and per chip drivers call it so they never
+ * re-implement the switch. Returns the selected format so a chip
+ * driver can post-adjust a quirk (e.g. MPS encodes VOUT in DIRECT
+ * with m=64 R=1 even when VOUT_MODE reports VID). On a VOUT_MODE read
+ * failure the format is left unchanged and the prior value is returned.
+ */
+enum pmbus_data_format
+pmbus_regulator_identify_vout(struct udevice *i2c_dev,
+			      struct pmbus_driver_info *info);
+
+#endif /* _DRIVERS_POWER_REGULATOR_PMBUS_HELPER_H_ */
diff --git a/include/pmbus.h b/include/pmbus.h
index f86e0673e41..0e121fa6637 100644
--- a/include/pmbus.h
+++ b/include/pmbus.h
@@ -464,6 +464,43 @@ bool pmbus_word_command_supported(struct udevice *dev, u8 reg);
 void pmbus_print_telemetry(struct udevice *chip);
 void pmbus_print_status_word(struct udevice *chip);
 
+/*
+ * Regulator -> thermal bridge.
+ *
+ * Read READ_TEMPERATURE_1 (8Dh) from a UCLASS_REGULATOR device that
+ * was bound by a pmbus_helper based chip driver, decode it through
+ * the chip's pmbus_driver_info (so the MPS DIRECT 1 degC/LSB quirk
+ * and the standard LINEAR11 encoding are both handled), select the
+ * regulator's PAGE first on multi rail parts, and return the result
+ * in millidegrees Celsius.
+ *
+ * This is what the generic drivers/thermal/pmbus_thermal.c companion
+ * calls on its parent; keeping the decode here avoids exposing the
+ * regulator-private pmbus_regulator_priv layout to other subsystems.
+ *
+ * Returns 0 on success, or a negative errno (-ENODEV if reg is not a
+ * probed pmbus regulator, -EIO on bus error).
+ */
+int pmbus_regulator_read_temp(struct udevice *reg_dev, int *temp_mc);
+
+/*
+ * Look up the pmbus_driver_info of a probed UCLASS_REGULATOR device at
+ * (bus_seq, addr) that is driven by a pmbus_helper based chip driver
+ * (mpq8785, pmbus_generic, ...). Probes the device so its identify
+ * hook has run and format[] is populated, then returns its
+ * driver_info. Returns NULL if no such regulator is bound at that
+ * address, if the device is not a pmbus regulator, or if
+ * CONFIG_DM_REGULATOR_PMBUS_HELPER is disabled.
+ *
+ * Lets pmbus_set_active() -- and thus the pmbus CLI and the board
+ * boot snapshots -- reuse the rich, VOUT_MODE detected driver_info of
+ * a DT bound generic / chip regulator when the device is selected by
+ * raw <bus>:<addr> (which has no chip-match registry entry and would
+ * otherwise fall back to blanket LINEAR16 / LINEAR11 decoding).
+ */
+const struct pmbus_driver_info *pmbus_regulator_info_by_addr(int bus_seq,
+							     u8 addr);
+
 /*
  * Status bit name decoding.
  *
diff --git a/lib/pmbus.c b/lib/pmbus.c
index 4192abde91c..62a66593638 100644
--- a/lib/pmbus.c
+++ b/lib/pmbus.c
@@ -761,6 +761,23 @@ int pmbus_set_active(int bus_seq, u8 addr)
 				sizeof(pmbus_active_state.vendor));
 	}
 
+	/*
+	 * No MFR_ID chip-match (a spec compliant part with no per chip
+	 * driver, e.g. a Flex / Delta PSU): if a generic / chip
+	 * UCLASS_REGULATOR is bound at this address, reuse its
+	 * VOUT_MODE detected driver_info so telemetry decodes through
+	 * the right per class formats instead of the blanket
+	 * LINEAR16 / LINEAR11 fallback.
+	 */
+	if (CONFIG_IS_ENABLED(DM_REGULATOR_PMBUS_HELPER) &&
+	    !pmbus_active_state.info) {
+		const struct pmbus_driver_info *di =
+			pmbus_regulator_info_by_addr(bus_seq, addr);
+
+		if (di)
+			pmbus_active_state.info = di;
+	}
+
 	/*
 	 * MFR_MODEL / MFR_REVISION are best effort. Use the same byte
 	 * order the matched chip declared; if nothing matched, use the
-- 
2.43.0

