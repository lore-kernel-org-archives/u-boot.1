Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBA07CD5BD5
	for <u-boot@archiver.kernel.org>; Wed, 27 May 2026 14:05:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5C201844CF;
	Wed, 27 May 2026 16:05:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=free.fr header.i=@free.fr header.b="OIpRC3ht";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 53D5E84659; Wed, 27 May 2026 16:05:49 +0200 (CEST)
Received: from smtp1-g21.free.fr (smtp1-g21.free.fr [IPv6:2a01:e0c:1:1599::10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E3349839A8
 for <u-boot@lists.denx.de>; Wed, 27 May 2026 16:05:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=vjardin@free.fr
Received: from localhost.localdomain (unknown [91.160.0.144])
 (Authenticated sender: vjardin@free.fr)
 by smtp1-g21.free.fr (Postfix) with ESMTPSA id D3A6EB0059A;
 Wed, 27 May 2026 16:05:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
 s=smtp-20201208; t=1779890746;
 bh=uFTgguyByXA8xfd1gohUMLukky5QZTtqxUD7h3X/GEs=;
 h=From:To:Cc:Subject:Date:From;
 b=OIpRC3htTLaT4IJq5kjTws89A4q9z5zfFjE9O6nzrC0mRNnE/8orj63iFlgSvGY6k
 jT9n8kfYHav3PlANUpK7qUHmkHuqgX1H0sS7x9fo+5OHBob0iKKMsHQW5/x3XNe7vj
 fN44wUypy9TCrlGRMfOy0qa+FL+5Hlebwz/ZJFOQeTkYka74nRKKevpqhxS0J6ZzUB
 rQvM/gTquOG2xQZTwylU81ugNSY1NEjqPFD/B8emlMd08v4jVHX7Nr7WmSBbkp1CUX
 6glrlEBCjwXAS5pUfnktAz+e13IVOyDORMhnquAfbmL4UWGEPhgvepVRiQPxqcHRKH
 /JgdAhmWZkOEg==
From: Vincent Jardin <vjardin@free.fr>
To: u-boot@lists.denx.de
Cc: Vincent Jardin <vjardin@free.fr>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Jerome Forissier <jerome.forissier@arm.com>,
 Kory Maincent <kory.maincent@bootlin.com>,
 Kuan-Wei Chiu <visitorckw@gmail.com>,
 Marek Vasut <marek.vasut@mailbox.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, Peng Fan <peng.fan@nxp.com>,
 Philip Molloy <philip.molloy@analog.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Raymond Mao <raymond.mao@riscstar.com>, Simon Glass <sjg@chromium.org>,
 Stefan Roese <stefan.roese@mailbox.org>, Tom Rini <trini@konsulko.com>,
 Yao Zi <me@ziyao.cc>
Subject: [PATCH v1] thermal: jc42: add JEDEC JC-42.4/TSE2004av SPD
Date: Wed, 27 May 2026 16:05:19 +0200
Message-ID: <20260527140523.544762-1-vjardin@free.fr>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

It is designed as a generic UCLASS_THERMAL driver for any JEDEC
JC-42.4 family of on-DIMM temperature sensors (TSE2004av and
compatible parts).

The driver reads the temperature register over DM I2C.

The "jedec,jc-42.4-temp" compatible is Linux-aligned (see
Documentation/devicetree/bindings/hwmon/jedec,jc-42.4-temp.yaml in
the Linux tree).

When CMD_TEMPERATURE is enabled, the sensor becomes available with
the standard commands "temperature list" / "temperature get".

Signed-off-by: Vincent Jardin <vjardin@free.fr>

---

 MAINTAINERS              |  5 +++
 drivers/thermal/Kconfig  |  7 +++
 drivers/thermal/Makefile |  1 +
 drivers/thermal/jc42.c   | 93 ++++++++++++++++++++++++++++++++++++++++
 4 files changed, 106 insertions(+)
 create mode 100644 drivers/thermal/jc42.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 056902f6ef2..a7c86e3e29d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1297,6 +1297,11 @@ T:	git https://source.denx.de/u-boot/u-boot.git
 F:	cmd/i3c.c
 F:	drivers/i3c/
 
+JEDEC JC-42.4 / TSE2004av TEMPERATURE SENSOR
+M:	Vincent Jardin <vjardin@free.fr>
+S:	Maintained
+F:	drivers/thermal/jc42.c
+
 KWBIMAGE / KWBOOT TOOLS
 M:	Pali Rohár <pali@kernel.org>
 M:	Marek Behún <kabel@kernel.org>
diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
index 91c39aa4dee..04cf3bfa420 100644
--- a/drivers/thermal/Kconfig
+++ b/drivers/thermal/Kconfig
@@ -55,4 +55,11 @@ config TI_LM74_THERMAL
 	 Enable thermal support for the Texas Instruments LM74 chip.
 	 The driver supports reading CPU temperature.
 
+config DM_THERMAL_JC42
+	bool "JEDEC JC-42.4/TSE2004av SPD temperature sensor"
+	depends on DM_I2C
+	help
+	  Enable support for the JEDEC JC-42.4 temperature sensor found
+	  on the SPD bus of DDR3 and DDR4 DIMMs (TSE2004av and compatible).
+
 endif # if DM_THERMAL
diff --git a/drivers/thermal/Makefile b/drivers/thermal/Makefile
index b6f06c00ed9..c9fa7561b45 100644
--- a/drivers/thermal/Makefile
+++ b/drivers/thermal/Makefile
@@ -11,3 +11,4 @@ obj-$(CONFIG_RCAR_GEN3_THERMAL) += rcar_gen3_thermal.o
 obj-$(CONFIG_SANDBOX) += thermal_sandbox.o
 obj-$(CONFIG_TI_DRA7_THERMAL) += ti-bandgap.o
 obj-$(CONFIG_TI_LM74_THERMAL) += ti-lm74.o
+obj-$(CONFIG_DM_THERMAL_JC42) += jc42.o
diff --git a/drivers/thermal/jc42.c b/drivers/thermal/jc42.c
new file mode 100644
index 00000000000..6945260e8b0
--- /dev/null
+++ b/drivers/thermal/jc42.c
@@ -0,0 +1,93 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright 2026 Free Mobile - Vincent Jardin
+ *
+ * JEDEC JC-42.4 / TSE2004av Temperature Sensor driver.
+ *
+ * Generic I2C temperature sensor of the Serial Presence Detect (SPD)
+ * bus of DDR3 and DDR4 SO-DIMMs / UDIMMs / RDIMMs per the JEDEC
+ * JC-42.4 standard. The TSE2004av variant adds an integrated SPD
+ * EEPROM, but the thermal register interface is the same and is
+ * what this driver exposes.
+ *
+ * Register layout (subset):
+ *   0x05  Ambient temperature, 16-bit big-endian:
+ *           bit 15    : T_CRIT alarm flag    (read-only)
+ *           bit 14    : T_HIGH alarm flag    (read-only)
+ *           bit 13    : T_LOW alarm flag     (read-only)
+ *           bit 12    : sign (two's-complement within bits[12:0])
+ *           bits[11:0]: magnitude * 16 (LSB = 0.0625 degC = 62.5 mC)
+ *   0x06  Manufacturer ID  (16-bit BE, JEP-106 vendor code)
+ *   0x07  Device ID + Revision (upper byte = ID, lower = revision)
+ *   ...
+ */
+
+#include <dm.h>
+#include <i2c.h>
+#include <thermal.h>
+#include <linux/bitops.h>
+
+#define JC42_REG_TEMP		0x05
+
+#define JC42_TEMP_SIGN		BIT(12)
+#define JC42_TEMP_MAGNITUDE	GENMASK(11, 0)
+
+static int jc42_get_temp(struct udevice *dev, int *temp)
+{
+	u8 buf[2];
+	int ret;
+	int mag;
+
+	ret = dm_i2c_read(dev, JC42_REG_TEMP, buf, sizeof(buf));
+	if (ret)
+		return ret;
+
+	mag = ((buf[0] << 8) | buf[1]) & (JC42_TEMP_SIGN | JC42_TEMP_MAGNITUDE);
+	if (mag & JC42_TEMP_SIGN)
+		mag -= (JC42_TEMP_SIGN << 1);
+
+	/*
+	 * mag is in units of 1/16 degC. Multiply first to keep one
+	 * extra bit of precision before the divide. Worst-case range
+	 * for a 13-bit signed value is +/-4096, so the product fits
+	 * comfortably in an int (~4.1M mC).
+	 */
+	*temp = mag * 1000 / 16;
+
+	return 0;
+}
+
+static const struct dm_thermal_ops jc42_ops = {
+	.get_temp	= jc42_get_temp,
+};
+
+/*
+ * Optional DT label property override: it replace the default DM
+ * device name (the ofnode name, eg "temp@18") so
+ * temperature list or temperature get commands
+ * show a human-meaningful identifier such as "ddr-top" or
+ * "ddr-bottom".
+ * It mirrors the Linux hwmon binding which uses label for the
+ * per-sensor display name.
+ */
+static int jc42_bind(struct udevice *dev)
+{
+	const char *label = dev_read_string(dev, "label");
+
+	if (label && *label)
+		return device_set_name(dev, label);
+	return 0;
+}
+
+static const struct udevice_id jc42_match[] = {
+	{ .compatible = "jedec,jc-42.4-temp" },
+	{ }
+};
+
+U_BOOT_DRIVER(jc42_thermal) = {
+	.name		= "jc42_thermal",
+	.id		= UCLASS_THERMAL,
+	.of_match	= jc42_match,
+	.bind		= jc42_bind,
+	.ops		= &jc42_ops,
+};
-- 
2.43.0

base-commit: bfe90a308a94caa9d855440683521ff04122ae2a
branch: for-upstream/thermal-jc42
