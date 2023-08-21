Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2209CEE49A5
	for <u-boot@archiver.kernel.org>; Mon, 21 Aug 2023 22:31:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0776D87205;
	Tue, 22 Aug 2023 00:30:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kwiboo.se header.i=@kwiboo.se header.b="oFpxrZyB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A1AAD871FC; Tue, 22 Aug 2023 00:30:32 +0200 (CEST)
Received: from s.wrqvwxzv.outbound-mail.sendgrid.net
 (s.wrqvwxzv.outbound-mail.sendgrid.net [149.72.154.232])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B8856871BD
 for <u-boot@lists.denx.de>; Tue, 22 Aug 2023 00:30:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=bounces+31435339-7456-u-boot=lists.denx.de@em2124.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=from:subject:in-reply-to:references:mime-version:to:cc:
 content-transfer-encoding:content-type:cc:content-type:from:subject:to;
 s=s1; bh=r0bh0vraKybA0AwRqN1Vl3JcAJOVX+XylNmaVQbWmfg=;
 b=oFpxrZyBWVjCLITFJQM4jUhqS+o10B1tM6ci+1eJGY3MXm6YrkjnHcJHScTbT6QHxrLX
 /QHM18eqXjYS6Ad7OuKipwlPXRgWoEeCd/Tp3Tg4AY5T6E3fmOy2ddCaTPVju7xAMpU4Su
 fFyLsK2EiGfPNTgVYs+EhKZ8HctFu1kOcY6WIe/gzsitlKkeYVGa8VZP4YKuCiNHc2TVCd
 hoZqlQFKgXNAB1ubJLsC5GcdVT/Nf6EJg2p6fez2tf1jXrjfNdTURf45ASKDwIBIEf0nKM
 XTXRqIilhNo3zGkDCHTAijUszOTfjt1CftQllN17NXwGRKOwCmsldN/xQL4PtMkQ==
Received: by filterdrecv-65f68489c8-knmdt with SMTP id
 filterdrecv-65f68489c8-knmdt-1-64E3E584-3
 2023-08-21 22:30:28.125282143 +0000 UTC m=+8895270.061218379
Received: from bionic.localdomain (unknown) by geopod-ismtpd-7 (SG) with ESMTP
 id kmaZ-s2sTcWnipShSqZP2A Mon, 21 Aug 2023 22:30:27.917 +0000 (UTC)
From: Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH v2 4/5] rockchip: Port IO-domain driver for RK3568 from linux
Date: Mon, 21 Aug 2023 22:30:28 +0000 (UTC)
Message-ID: <20230821223020.3918620-5-jonas@kwiboo.se>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230821223020.3918620-1-jonas@kwiboo.se>
References: <20230821223020.3918620-1-jonas@kwiboo.se>
MIME-Version: 1.0
X-SG-EID: =?us-ascii?Q?TdbjyGynYnRZWhH+7lKUQJL+ZxmxpowvO2O9SQF5CwCVrYgcwUXgU5DKUU3QxA?=
 =?us-ascii?Q?fZekEeQsTe+RrMu3cja6a0hzUvsrL7oqO4GlZIS?=
 =?us-ascii?Q?DqoYIqr9Mrb5QtyG9xk6UqvWXj4ohQqQPjbaDp1?=
 =?us-ascii?Q?mnjhtbkNbh1mcn7U7e7Mta4BikpatDXaEiEM0xM?=
 =?us-ascii?Q?sTd9Yj=2Fm6Qogh02wXZvAVtKK=2F3k7EO=2F6CaCSQ9Z?=
 =?us-ascii?Q?Gj+wjl3UiPMafHxyCAcXcAmR0hKlZxUe=2FDR45l?=
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>
Cc: u-boot@lists.denx.de, Jonas Karlman <jonas@kwiboo.se>, Jianqun Xu
 <jay.xu@rock-chips.com>, Heiko Stuebner <heiko@sntech.de>, Doug Anderson
 <dianders@chromium.org>
X-Entity-ID: P7KYpSJvGCELWjBME/J5tg==
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=us-ascii
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

Port the Rockchip IO-domain driver for RK3568 from linux.

The driver auto probe after bind to configure IO-domain based on the
regulator voltage. Compared to the linux driver this driver is not
notified about regulator voltage changes and only configure IO-domain
based on the initial voltage autoset by the regulator.

It is not recommended to enable MMC_IO_VOLTAGE or the mmc signal voltage
and IO-domain may end up out of sync.

Based on the linux commit 28b05a64e47c ("soc: rockchip: io-domain: add
rk3568 support").

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Simon Glass <sjg@chromium.org>
---
Cc: Jianqun Xu <jay.xu@rock-chips.com>
Cc: Heiko Stuebner <heiko@sntech.de>
Cc: Doug Anderson <dianders@chromium.org>
---
v2:
- Add probe after bind comment
- Drop parenthesis
- Collect r-b tag

 drivers/misc/Kconfig              |   9 ++
 drivers/misc/Makefile             |   1 +
 drivers/misc/rockchip-io-domain.c | 167 ++++++++++++++++++++++++++++++
 3 files changed, 177 insertions(+)
 create mode 100644 drivers/misc/rockchip-io-domain.c

diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
index b9f5c7a37aed..d160ce693939 100644
--- a/drivers/misc/Kconfig
+++ b/drivers/misc/Kconfig
@@ -101,6 +101,15 @@ config ROCKCHIP_OTP
 	  addressing and a length or through child-nodes that are generated
 	  based on the e-fuse map retrieved from the DTS.
 
+config ROCKCHIP_IODOMAIN
+	bool "Rockchip IO-domain driver support"
+	depends on DM_REGULATOR && ARCH_ROCKCHIP
+	default y if ROCKCHIP_RK3568
+	help
+	  Enable support for IO-domains in Rockchip SoCs. It is necessary
+	  for the IO-domain setting of the SoC to match the voltage supplied
+	  by the regulators.
+
 config SIFIVE_OTP
 	bool "SiFive eMemory OTP driver"
 	depends on MISC
diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
index fd8805f34bd9..b67b82358a6c 100644
--- a/drivers/misc/Makefile
+++ b/drivers/misc/Makefile
@@ -69,6 +69,7 @@ obj-$(CONFIG_SANDBOX) += qfw_sandbox.o
 endif
 obj-$(CONFIG_ROCKCHIP_EFUSE) += rockchip-efuse.o
 obj-$(CONFIG_ROCKCHIP_OTP) += rockchip-otp.o
+obj-$(CONFIG_$(SPL_TPL_)ROCKCHIP_IODOMAIN) += rockchip-io-domain.o
 obj-$(CONFIG_SANDBOX) += syscon_sandbox.o misc_sandbox.o
 obj-$(CONFIG_SIFIVE_OTP) += sifive-otp.o
 obj-$(CONFIG_SMSC_LPC47M) += smsc_lpc47m.o
diff --git a/drivers/misc/rockchip-io-domain.c b/drivers/misc/rockchip-io-domain.c
new file mode 100644
index 000000000000..3f6227f993f9
--- /dev/null
+++ b/drivers/misc/rockchip-io-domain.c
@@ -0,0 +1,167 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Rockchip IO Voltage Domain driver
+ *
+ * Ported from linux drivers/soc/rockchip/io-domain.c
+ */
+
+#include <common.h>
+#include <dm.h>
+#include <dm/device_compat.h>
+#include <regmap.h>
+#include <syscon.h>
+#include <power/regulator.h>
+
+#define MAX_SUPPLIES		16
+
+/*
+ * The max voltage for 1.8V and 3.3V come from the Rockchip datasheet under
+ * "Recommended Operating Conditions" for "Digital GPIO".   When the typical
+ * is 3.3V the max is 3.6V.  When the typical is 1.8V the max is 1.98V.
+ *
+ * They are used like this:
+ * - If the voltage on a rail is above the "1.8" voltage (1.98V) we'll tell the
+ *   SoC we're at 3.3.
+ * - If the voltage on a rail is above the "3.3" voltage (3.6V) we'll consider
+ *   that to be an error.
+ */
+#define MAX_VOLTAGE_1_8		1980000
+#define MAX_VOLTAGE_3_3		3600000
+
+#define RK3568_PMU_GRF_IO_VSEL0		0x0140
+#define RK3568_PMU_GRF_IO_VSEL1		0x0144
+#define RK3568_PMU_GRF_IO_VSEL2		0x0148
+
+struct rockchip_iodomain_soc_data {
+	int grf_offset;
+	const char *supply_names[MAX_SUPPLIES];
+	int (*write)(struct regmap *grf, int idx, int uV);
+};
+
+static int rk3568_iodomain_write(struct regmap *grf, int idx, int uV)
+{
+	u32 is_3v3 = uV > MAX_VOLTAGE_1_8;
+	u32 val0, val1;
+	int b;
+
+	switch (idx) {
+	case 0: /* pmuio1 */
+		break;
+	case 1: /* pmuio2 */
+		b = idx;
+		val0 = BIT(16 + b) | (is_3v3 ? 0 : BIT(b));
+		b = idx + 4;
+		val1 = BIT(16 + b) | (is_3v3 ? BIT(b) : 0);
+
+		regmap_write(grf, RK3568_PMU_GRF_IO_VSEL2, val0);
+		regmap_write(grf, RK3568_PMU_GRF_IO_VSEL2, val1);
+		break;
+	case 3: /* vccio2 */
+		break;
+	case 2: /* vccio1 */
+	case 4: /* vccio3 */
+	case 5: /* vccio4 */
+	case 6: /* vccio5 */
+	case 7: /* vccio6 */
+	case 8: /* vccio7 */
+		b = idx - 1;
+		val0 = BIT(16 + b) | (is_3v3 ? 0 : BIT(b));
+		val1 = BIT(16 + b) | (is_3v3 ? BIT(b) : 0);
+
+		regmap_write(grf, RK3568_PMU_GRF_IO_VSEL0, val0);
+		regmap_write(grf, RK3568_PMU_GRF_IO_VSEL1, val1);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static const struct rockchip_iodomain_soc_data soc_data_rk3568_pmu = {
+	.grf_offset = 0x140,
+	.supply_names = {
+		NULL,
+		"pmuio2-supply",
+		"vccio1-supply",
+		NULL,
+		"vccio3-supply",
+		"vccio4-supply",
+		"vccio5-supply",
+		"vccio6-supply",
+		"vccio7-supply",
+	},
+	.write = rk3568_iodomain_write,
+};
+
+static const struct udevice_id rockchip_iodomain_ids[] = {
+	{
+		.compatible = "rockchip,rk3568-pmu-io-voltage-domain",
+		.data = (ulong)&soc_data_rk3568_pmu,
+	},
+	{ }
+};
+
+static int rockchip_iodomain_bind(struct udevice *dev)
+{
+	/*
+	 * According to the Hardware Design Guide, IO-domain configuration must
+	 * be consistent with the power supply voltage (1.8V or 3.3V).
+	 * Probe after bind to configure IO-domain voltage early during boot.
+	 */
+	dev_or_flags(dev, DM_FLAG_PROBE_AFTER_BIND);
+
+	return 0;
+}
+
+static int rockchip_iodomain_probe(struct udevice *dev)
+{
+	struct rockchip_iodomain_soc_data *soc_data =
+		(struct rockchip_iodomain_soc_data *)dev_get_driver_data(dev);
+	struct regmap *grf;
+	int ret;
+
+	grf = syscon_get_regmap(dev_get_parent(dev));
+	if (IS_ERR(grf))
+		return PTR_ERR(grf);
+
+	for (int i = 0; i < MAX_SUPPLIES; i++) {
+		const char *supply_name = soc_data->supply_names[i];
+		struct udevice *reg;
+		int uV;
+
+		if (!supply_name)
+			continue;
+
+		ret = device_get_supply_regulator(dev, supply_name, &reg);
+		if (ret)
+			continue;
+
+		ret = regulator_autoset(reg);
+		if (ret && ret != -EALREADY && ret != -EMEDIUMTYPE &&
+		    ret != -ENOSYS)
+			continue;
+
+		uV = regulator_get_value(reg);
+		if (uV <= 0)
+			continue;
+
+		if (uV > MAX_VOLTAGE_3_3) {
+			dev_crit(dev, "%s: %d uV is too high. May damage SoC!\n",
+				 supply_name, uV);
+			continue;
+		}
+
+		soc_data->write(grf, i, uV);
+	}
+
+	return 0;
+}
+
+U_BOOT_DRIVER(rockchip_iodomain) = {
+	.name = "rockchip_iodomain",
+	.id = UCLASS_NOP,
+	.of_match = rockchip_iodomain_ids,
+	.bind = rockchip_iodomain_bind,
+	.probe = rockchip_iodomain_probe,
+};
-- 
2.41.0

