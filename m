Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8577CEBF69
	for <u-boot@archiver.kernel.org>; Fri, 27 Sep 2024 04:44:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 05F4088EBA;
	Fri, 27 Sep 2024 06:44:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1727412279;
	bh=3wtm7njRmLwWCm4X6Zs05QlG06fMPKalB8KzZsc2kME=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=kPtTvCaNg7JaHXitLFJg7hHvb7ivVMyba07F3f2zEmkKHYdpcpICWX9oHfqFe434z
	 k5hRUUCeVejZYHC3BxHTPJ3P8wfFA9FTYgUYlEYN2XCQIOUyITRnW6quWtjD5Q3KwB
	 A7gnX+ZcztCyAPIOX+98KsKMqke44OXf+K7YTn/VUA+2adt/ARfNBP+RVdF2vv6pS0
	 Xcv4th0Bklcg5SOuQcPG8OttD4ARJmfFyyVHxPFo96e4WpghG/U7lWTbKjbx0eNzz3
	 vklnmYYXMbspLbL5RHGCRORE79hyIevfkAs5iQjmZl4HVkDgaG+8MzPyJlZyD3qizo
	 Fidw0JLI5v1XQ==
Received: from tr.lan (ip-86-49-120-218.bb.vodafone.cz [86.49.120.218])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id BF6EC88F68;
 Fri, 27 Sep 2024 01:15:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1727392525;
 bh=3wtm7njRmLwWCm4X6Zs05QlG06fMPKalB8KzZsc2kME=;
 h=From:To:Cc:Subject:Date:From;
 b=Eu3wXEDt7sc0LgoJftFOea78zAOBva3nlmsdOQP4bXL/gNDCqNInaoZ1QpM2jnI9/
 f3nXtoUoSmqZ4nrLGsBwJP8B3SzSESDsEjL/jUnnP9prSsGiu+VyhiQhVFuhA3oPMh
 H5PmT+fPqtaMSku9fN0JmLyMGpZreRFZtbsyZyXA3fzKJTthdHPZGyX8jJ+5MpY01M
 stWG8CRITZP/Tc7vnFdMArPzL0USpyLHiwldN+c1YOy1YlUoxZIjn4lxnJBCQrpHrl
 WQU5gbVbdzKlqYt4gWylmctw4+E7KBV+g3EMoOK+lqnZWvAAW1ZqwiKIDkvApq5HTb
 ssK7t1DerP31g==
From: Marek Vasut <marex@denx.de>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>, Ben Wolsieffer <benwolsieffer@gmail.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Chris Morgan <macromorgan@hotmail.com>, Dragan Simic <dsimic@manjaro.org>,
 Eugen Hristev <eugen.hristev@collabora.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Jagan Teki <jagan@amarulasolutions.com>, Jonas Karlman <jonas@kwiboo.se>,
 Kever Yang <kever.yang@rock-chips.com>,
 Kostya Porotchkin <kostap@marvell.com>,
 Matteo Lisi <matteo.lisi@engicam.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Max Krummenacher <max.krummenacher@toradex.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Quentin Schulz <quentin.schulz@cherry.de>, Sam Day <me@samcday.com>,
 Simon Glass <sjg@chromium.org>, Sumit Garg <sumit.garg@linaro.org>,
 Svyatoslav Ryhel <clamor95@gmail.com>, Thierry Reding <treding@nvidia.com>,
 Tom Rini <trini@konsulko.com>,
 Volodymyr Babchuk <Volodymyr_Babchuk@epam.com>, u-boot-amlogic@groups.io,
 u-boot-qcom@groups.io, u-boot@dh-electronics.com,
 uboot-stm32@st-md-mailman.stormreply.com
Subject: [PATCH v3 1/4] power: regulator: Trigger probe of regulators which
 are always-on or boot-on
Date: Fri, 27 Sep 2024 01:14:12 +0200
Message-ID: <20240926231457.2933914-1-marex@denx.de>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 27 Sep 2024 06:44:37 +0200
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

In case a regulator DT node contains regulator-always-on or regulator-boot-on
property, make sure the regulator gets correctly configured by U-Boot on start
up. Unconditionally probe such regulator drivers. This is a preparatory patch
for introduction of .regulator_post_probe() which would trigger the regulator
configuration.

Parsing of regulator-always-on and regulator-boot-on DT property has been
moved to regulator_post_bind() as the information is required early, the
rest of the DT parsing has been kept in regulator_pre_probe() to avoid
slowing down the boot process.

Signed-off-by: Marek Vasut <marex@denx.de>
---
Cc: Ben Wolsieffer <benwolsieffer@gmail.com>
Cc: Caleb Connolly <caleb.connolly@linaro.org>
Cc: Chris Morgan <macromorgan@hotmail.com>
Cc: Dragan Simic <dsimic@manjaro.org>
Cc: Eugen Hristev <eugen.hristev@collabora.com>
Cc: Francesco Dolcini <francesco.dolcini@toradex.com>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Jaehoon Chung <jh80.chung@samsung.com>
Cc: Jagan Teki <jagan@amarulasolutions.com>
Cc: Jonas Karlman <jonas@kwiboo.se>
Cc: Kever Yang <kever.yang@rock-chips.com>
Cc: Kostya Porotchkin <kostap@marvell.com>
Cc: Matteo Lisi <matteo.lisi@engicam.com>
Cc: Mattijs Korpershoek <mkorpershoek@baylibre.com>
Cc: Max Krummenacher <max.krummenacher@toradex.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Patrice Chotard <patrice.chotard@foss.st.com>
Cc: Patrick Delaunay <patrick.delaunay@foss.st.com>
Cc: Philipp Tomsich <philipp.tomsich@vrull.eu>
Cc: Quentin Schulz <quentin.schulz@cherry.de>
Cc: Sam Day <me@samcday.com>
Cc: Simon Glass <sjg@chromium.org>
Cc: Sumit Garg <sumit.garg@linaro.org>
Cc: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Thierry Reding <treding@nvidia.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: Volodymyr Babchuk <Volodymyr_Babchuk@epam.com>
Cc: u-boot-amlogic@groups.io
Cc: u-boot-qcom@groups.io
Cc: u-boot@dh-electronics.com
Cc: u-boot@lists.denx.de
Cc: uboot-stm32@st-md-mailman.stormreply.com
---
V2: - Rebase on current u-boot/next
    - Update test cases to handle already started regulators correctly
V3: - Fix conditional around DM_FLAG_PROBE_AFTER_BIND to ORR
---
 drivers/power/regulator/regulator-uclass.c | 22 +++++++++++++++-------
 test/dm/panel.c                            |  2 +-
 test/dm/regulator.c                        |  4 ++--
 3 files changed, 18 insertions(+), 10 deletions(-)

diff --git a/drivers/power/regulator/regulator-uclass.c b/drivers/power/regulator/regulator-uclass.c
index 00922900292..1a970004540 100644
--- a/drivers/power/regulator/regulator-uclass.c
+++ b/drivers/power/regulator/regulator-uclass.c
@@ -439,6 +439,8 @@ static int regulator_post_bind(struct udevice *dev)
 	const char *property = "regulator-name";
 
 	uc_pdata = dev_get_uclass_plat(dev);
+	uc_pdata->always_on = dev_read_bool(dev, "regulator-always-on");
+	uc_pdata->boot_on = dev_read_bool(dev, "regulator-boot-on");
 
 	/* Regulator's mandatory constraint */
 	uc_pdata->name = dev_read_string(dev, property);
@@ -450,13 +452,21 @@ static int regulator_post_bind(struct udevice *dev)
 			return -EINVAL;
 	}
 
-	if (regulator_name_is_unique(dev, uc_pdata->name))
-		return 0;
+	if (!regulator_name_is_unique(dev, uc_pdata->name)) {
+		debug("'%s' of dev: '%s', has nonunique value: '%s\n",
+		      property, dev->name, uc_pdata->name);
+		return -EINVAL;
+	}
 
-	debug("'%s' of dev: '%s', has nonunique value: '%s\n",
-	      property, dev->name, uc_pdata->name);
+	/*
+	 * In case the regulator has regulator-always-on or
+	 * regulator-boot-on DT property, trigger probe() to
+	 * configure its default state during startup.
+	 */
+	if (uc_pdata->always_on || uc_pdata->boot_on)
+		dev_or_flags(dev, DM_FLAG_PROBE_AFTER_BIND);
 
-	return -EINVAL;
+	return 0;
 }
 
 static int regulator_pre_probe(struct udevice *dev)
@@ -479,8 +489,6 @@ static int regulator_pre_probe(struct udevice *dev)
 						-ENODATA);
 	uc_pdata->max_uA = dev_read_u32_default(dev, "regulator-max-microamp",
 						-ENODATA);
-	uc_pdata->always_on = dev_read_bool(dev, "regulator-always-on");
-	uc_pdata->boot_on = dev_read_bool(dev, "regulator-boot-on");
 	uc_pdata->ramp_delay = dev_read_u32_default(dev, "regulator-ramp-delay",
 						    0);
 	uc_pdata->force_off = dev_read_bool(dev, "regulator-force-boot-off");
diff --git a/test/dm/panel.c b/test/dm/panel.c
index ce835c96ed0..ec85a9b1e6e 100644
--- a/test/dm/panel.c
+++ b/test/dm/panel.c
@@ -33,7 +33,7 @@ static int dm_test_panel(struct unit_test_state *uts)
 	ut_assertok(sandbox_pwm_get_config(pwm, 0, &period_ns, &duty_ns,
 					   &enable, &polarity));
 	ut_asserteq(false, enable);
-	ut_asserteq(false, regulator_get_enable(reg));
+	ut_asserteq(true, regulator_get_enable(reg));
 
 	ut_assertok(panel_enable_backlight(dev));
 	ut_assertok(sandbox_pwm_get_config(pwm, 0, &period_ns, &duty_ns,
diff --git a/test/dm/regulator.c b/test/dm/regulator.c
index 532bbd82376..449748ad52f 100644
--- a/test/dm/regulator.c
+++ b/test/dm/regulator.c
@@ -186,7 +186,7 @@ int dm_test_power_regulator_set_enable_if_allowed(struct unit_test_state *uts)
 
 	/* Get BUCK1 - always on regulator */
 	platname = regulator_names[BUCK1][PLATNAME];
-	ut_assertok(regulator_autoset_by_name(platname, &dev_autoset));
+	ut_asserteq(-EALREADY, regulator_autoset_by_name(platname, &dev_autoset));
 	ut_assertok(regulator_get_by_platname(platname, &dev));
 
 	/* Try disabling always-on regulator */
@@ -288,7 +288,7 @@ static int dm_test_power_regulator_autoset(struct unit_test_state *uts)
 	 * Expected output state: uV=1200000; uA=200000; output enabled
 	 */
 	platname = regulator_names[BUCK1][PLATNAME];
-	ut_assertok(regulator_autoset_by_name(platname, &dev_autoset));
+	ut_asserteq(-EALREADY, regulator_autoset_by_name(platname, &dev_autoset));
 
 	/* Check, that the returned device is proper */
 	ut_assertok(regulator_get_by_platname(platname, &dev));
-- 
2.45.2

