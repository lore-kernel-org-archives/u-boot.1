Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA5E6CA1013
	for <u-boot@archiver.kernel.org>; Sat,  6 Sep 2025 00:06:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2BC9B839F0;
	Sat,  6 Sep 2025 02:06:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="ZIcjSHQp";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="pzZdYRGK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 178F583B03; Sat,  6 Sep 2025 02:06:27 +0200 (CEST)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BAB0183919
 for <u-boot@lists.denx.de>; Sat,  6 Sep 2025 02:06:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4cJYR42tcpz9tcV;
 Sat,  6 Sep 2025 02:06:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1757117184;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=831BJkzGOI2sSCw8IocHd4GCa8MxGOd7aX7YrBStM0g=;
 b=ZIcjSHQpdIRlUAi8n0VCrbDJAm4O1AiBmE6Oul/ZsELd3Wy3uMkAls/8q+2kgVZEgSMRQR
 J1svx46rus/7lqBN7UcGnmd09mpyxX0RUzhbwYgz4pyl+qmKFuQuIkLecZVouaZRx0SPxa
 aWEpZsj5HI3Oj789NyuSBGasWQGLeFBeaCKUeajwB9GG8C6GakAmRFK5Pm/+iWrH0WvFuT
 /Xg5e5Jx0wC3tCVtyPL9gIIkU3dsSAa2yFBT6ltIE7Ry7rUl3dd1ST5Az5OGqUbn3EuJ01
 kHUeyFhWS8E12CZAe//5IXUA87QdUWI0oymt62jtFmyNEEh/fvNpoB7Pn9MsxA==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1757117182;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=831BJkzGOI2sSCw8IocHd4GCa8MxGOd7aX7YrBStM0g=;
 b=pzZdYRGKpVRLnOYBCj5YR0fzqxrGM8SmuXdJ/FYi4JrbZLkm2FI2QSg9yTFtFxrnfotycV
 K78FIDUQ62B7ENB/En2gtSBOAsef4nAwr4VpDvSjERXDPW/jso3cxP2crY0U/gSBZYSeZK
 bZGM14Qx7j8ET1YdbmAk2F5uJIqVXzBBOwaFqNNli5reyyT0jfKGiFxsuXt0tADyQxklhm
 CIwC2ctbWekvgD+KeUinMlXUlj7rY1jbDts9cFhLonXA1huvlaExA/7ZBa+GqAbEoaknUT
 JQXh0cBHADsxAI4J23f1OYOhDy9SJVfuZE58lVi3MmcvTrtqNoEnVjOWlBoM9Q==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Adam Ford <aford173@gmail.com>,
 Alice Guo <alice.guo@nxp.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 David Zang <davidzangcs@gmail.com>, Fabio Estevam <festevam@gmail.com>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Mathieu Othacehe <othacehe@gnu.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Peng Fan <peng.fan@nxp.com>,
 Simon Glass <sjg@chromium.org>, Stefano Babic <sbabic@nabladev.com>,
 Tom Rini <trini@konsulko.com>, Ye Li <ye.li@nxp.com>
Subject: [PATCH] thermal: Convert .get_temp() return value to millicelsius
Date: Sat,  6 Sep 2025 02:05:33 +0200
Message-ID: <20250906000609.284902-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: mugryi3hu7sxhoprchc37ncj6q5i5iya
X-MBO-RS-ID: 312a9c5b11007e14142
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

Linux kernel .get_temp() callback reports values in millicelsius,
U-Boot currently reports them in celsius. Align the two and report
in millicelsius. Update drivers accordingly. Update callsites that
use thermal_get_temp() as well.

The 'temperature' command now reports temperature in millicelsius
as well, with additional accuracy. This changes command line ABI
slightly.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
Cc: Adam Ford <aford173@gmail.com>
Cc: Alice Guo <alice.guo@nxp.com>
Cc: Andrew Goodbody <andrew.goodbody@linaro.org>
Cc: David Zang <davidzangcs@gmail.com>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: Jaehoon Chung <jh80.chung@samsung.com>
Cc: Mathieu Othacehe <othacehe@gnu.org>
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc: Peng Fan <peng.fan@nxp.com>
Cc: Simon Glass <sjg@chromium.org>
Cc: Stefano Babic <sbabic@nabladev.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: Ye Li <ye.li@nxp.com>
Cc: u-boot@lists.denx.de
---
 arch/arm/mach-imx/cpu.c             | 1 +
 arch/arm/mach-imx/imx8ulp/soc.c     | 2 +-
 cmd/temperature.c                   | 2 +-
 drivers/cpu/imx8_cpu.c              | 2 +-
 drivers/mmc/omap_hsmmc.c            | 1 +
 drivers/thermal/imx_scu_thermal.c   | 2 +-
 drivers/thermal/imx_thermal.c       | 2 +-
 drivers/thermal/imx_tmu.c           | 2 +-
 drivers/thermal/rcar_gen3_thermal.c | 6 +++---
 drivers/thermal/thermal_sandbox.c   | 2 +-
 drivers/thermal/ti-bandgap.c        | 2 +-
 drivers/thermal/ti-lm74.c           | 2 +-
 include/thermal.h                   | 2 +-
 13 files changed, 15 insertions(+), 13 deletions(-)

diff --git a/arch/arm/mach-imx/cpu.c b/arch/arm/mach-imx/cpu.c
index 17de9ff98ec..cc215b771ef 100644
--- a/arch/arm/mach-imx/cpu.c
+++ b/arch/arm/mach-imx/cpu.c
@@ -230,6 +230,7 @@ int print_cpuinfo(void)
 	ret = uclass_get_device(UCLASS_THERMAL, 0, &thermal_dev);
 	if (!ret) {
 		ret = thermal_get_temp(thermal_dev, &cpu_tmp);
+		cpu_tmp /= 1000;
 
 		if (!ret)
 			printf(" at %dC", cpu_tmp);
diff --git a/arch/arm/mach-imx/imx8ulp/soc.c b/arch/arm/mach-imx/imx8ulp/soc.c
index e85cb0dd252..b10762a9e07 100644
--- a/arch/arm/mach-imx/imx8ulp/soc.c
+++ b/arch/arm/mach-imx/imx8ulp/soc.c
@@ -279,7 +279,7 @@ int print_cpuinfo(void)
 	if (!ret) {
 		ret = thermal_get_temp(udev, &temp);
 		if (!ret)
-			printf("CPU current temperature: %dC\n", temp);
+			printf("CPU current temperature: %dC\n", temp / 1000);
 		else
 			debug(" - failed to get CPU current temperature\n");
 	} else {
diff --git a/cmd/temperature.c b/cmd/temperature.c
index 41e422fc937..c145d019364 100644
--- a/cmd/temperature.c
+++ b/cmd/temperature.c
@@ -32,7 +32,7 @@ static int do_get(struct cmd_tbl *cmdtp, int flag, int argc,
 	if (ret)
 		return CMD_RET_FAILURE;
 
-	printf("%s: %d C\n", dev->name, temp);
+	printf("%s: %d mC\n", dev->name, temp);
 
 	return CMD_RET_SUCCESS;
 }
diff --git a/drivers/cpu/imx8_cpu.c b/drivers/cpu/imx8_cpu.c
index 950630453f9..4a7e951ce19 100644
--- a/drivers/cpu/imx8_cpu.c
+++ b/drivers/cpu/imx8_cpu.c
@@ -190,7 +190,7 @@ static int cpu_imx_get_temp(struct cpu_imx_plat *plat)
 		return 0xdeadbeef;
 	}
 
-	return cpu_tmp;
+	return cpu_tmp / 1000;
 }
 #else
 static int cpu_imx_get_temp(struct cpu_imx_plat *plat)
diff --git a/drivers/mmc/omap_hsmmc.c b/drivers/mmc/omap_hsmmc.c
index 92bc72b267c..ae742080643 100644
--- a/drivers/mmc/omap_hsmmc.c
+++ b/drivers/mmc/omap_hsmmc.c
@@ -651,6 +651,7 @@ static int omap_hsmmc_execute_tuning(struct udevice *dev, uint opcode)
 		printf("Couldn't get temperature for tuning\n");
 		return ret;
 	}
+	temperature /= 1000;
 	val = readl(&mmc_base->dll);
 	val |= DLL_SWT;
 	writel(val, &mmc_base->dll);
diff --git a/drivers/thermal/imx_scu_thermal.c b/drivers/thermal/imx_scu_thermal.c
index fc2b0e227b2..6b0b1d10d9d 100644
--- a/drivers/thermal/imx_scu_thermal.c
+++ b/drivers/thermal/imx_scu_thermal.c
@@ -72,7 +72,7 @@ int imx_sc_thermal_get_temp(struct udevice *dev, int *temp)
 			break;
 	}
 
-	*temp = cpu_temp / 1000;
+	*temp = cpu_temp;
 
 	return 0;
 }
diff --git a/drivers/thermal/imx_thermal.c b/drivers/thermal/imx_thermal.c
index ea1fcc3dcb2..d04035950ee 100644
--- a/drivers/thermal/imx_thermal.c
+++ b/drivers/thermal/imx_thermal.c
@@ -223,7 +223,7 @@ int imx_thermal_get_temp(struct udevice *dev, int *temp)
 		cpu_tmp = read_cpu_temperature(dev);
 	}
 
-	*temp = cpu_tmp;
+	*temp = cpu_tmp * 1000;
 
 	return 0;
 }
diff --git a/drivers/thermal/imx_tmu.c b/drivers/thermal/imx_tmu.c
index 70d002aee25..51a072e23c6 100644
--- a/drivers/thermal/imx_tmu.c
+++ b/drivers/thermal/imx_tmu.c
@@ -245,7 +245,7 @@ int imx_tmu_get_temp(struct udevice *dev, int *temp)
 			return ret;
 	}
 
-	*temp = cpu_tmp / 1000;
+	*temp = cpu_tmp;
 
 	return 0;
 }
diff --git a/drivers/thermal/rcar_gen3_thermal.c b/drivers/thermal/rcar_gen3_thermal.c
index 83433e8d8f0..ffbe4a625e4 100644
--- a/drivers/thermal/rcar_gen3_thermal.c
+++ b/drivers/thermal/rcar_gen3_thermal.c
@@ -161,7 +161,7 @@ static int rcar_gen3_thermal_get_temp(struct udevice *dev, int *temp)
 	const struct equation_set_coef *coef;
 	int adj, decicelsius, reg, thcode;
 
-	/* Read register and convert to degree Celsius */
+	/* Read register and convert to millidegree Celsius */
 	reg = rcar_gen3_thermal_read(tsc, REG_GEN3_TEMP) & CTEMP_MASK;
 
 	if (reg < tsc->thcode[1]) {
@@ -184,8 +184,8 @@ static int rcar_gen3_thermal_get_temp(struct udevice *dev, int *temp)
 
 	/* Guaranteed operating range is -40C to 125C. */
 
-	/* Reporting is done in degree Celsius */
-	*temp = (decicelsius * 100 + adj * 1000) / 1000;
+	/* Reporting is done in millidegree Celsius */
+	*temp = decicelsius * 100 + adj * 1000;
 
 	return 0;
 }
diff --git a/drivers/thermal/thermal_sandbox.c b/drivers/thermal/thermal_sandbox.c
index b7c567d76cd..2e1f1559e53 100644
--- a/drivers/thermal/thermal_sandbox.c
+++ b/drivers/thermal/thermal_sandbox.c
@@ -12,7 +12,7 @@
 static int sandbox_thermal_get_temp(struct udevice *dev, int *temp)
 {
 	/* Simply return 100 deg C */
-	*temp = 100;
+	*temp = 100 * 1000;
 
 	return 0;
 }
diff --git a/drivers/thermal/ti-bandgap.c b/drivers/thermal/ti-bandgap.c
index 0ea17a909dd..dc869f108e4 100644
--- a/drivers/thermal/ti-bandgap.c
+++ b/drivers/thermal/ti-bandgap.c
@@ -163,7 +163,7 @@ static int ti_bandgap_get_temp(struct udevice *dev,  int *temp)
 	struct ti_bandgap *bgp = dev_get_priv(dev);
 
 	bgp->adc_val = 0x3ff & readl(bgp->base + CTRL_CORE_TEMP_SENSOR_MPU);
-	*temp = dra752_adc_to_temp[bgp->adc_val - DRA752_ADC_START_VALUE];
+	*temp = dra752_adc_to_temp[bgp->adc_val - DRA752_ADC_START_VALUE] * 1000;
 
 	return 0;
 }
diff --git a/drivers/thermal/ti-lm74.c b/drivers/thermal/ti-lm74.c
index 7d56f75df06..20d0e39ece1 100644
--- a/drivers/thermal/ti-lm74.c
+++ b/drivers/thermal/ti-lm74.c
@@ -28,7 +28,7 @@ static int ti_lm74_get_temp(struct udevice *dev, int *temp)
 
 	raw = ((buf[0] << 8) + buf[1]) >> 3;
 
-	*temp = (((int)raw * 125) + 1000) / 2000;
+	*temp = (((int)raw * 125) + 1000) / 2;
 
 	return 0;
 }
diff --git a/include/thermal.h b/include/thermal.h
index 52a3317fd54..74b1c62466b 100644
--- a/include/thermal.h
+++ b/include/thermal.h
@@ -25,7 +25,7 @@ struct dm_thermal_ops {
 	 * It will enable and initialize any Thermal hardware as necessary.
 	 *
 	 * @dev:	The Thermal device
-	 * @temp:	pointer that returns the measured temperature
+	 * @temp:	pointer that returns the measured temperature in millidegree Celsius
 	 */
 	int (*get_temp)(struct udevice *dev, int *temp);
 };
-- 
2.50.1

