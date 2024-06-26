Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7E58C2BD09
	for <u-boot@archiver.kernel.org>; Thu, 27 Jun 2024 04:29:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CD9B188418;
	Thu, 27 Jun 2024 06:29:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1719462589;
	bh=j9+gNS0RvBKJupbfHAroI1F5otxQD2cptbmul1pdCUM=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=B3pVlfKS3CLm3OewLO7pdwVzJ9dLNvb+i/w1Fkl5Ch8+cSHC+5meMZ9cXJylDz6D3
	 lgId1FG/PBWzXc4jwsWnRiWE2wSOZnfWRfQr44QKkkWp26xmXmq+8U1Gvk44VWp5ny
	 n3GTywAilO/AIoz66D32uwiSA2jBnrsJ/gkOUEgJHZ5IVOma4+wd4eguJo+k/B3+XM
	 MsVj/tRcwKaCQZ2QsQfDhp6v7KQ2JdIqdnuprx76QZAzfLA7UwKUu5AyWFMfBurIrR
	 XqRTZED08CbwLt/rgN8t+II+IHzfvtHGIVvpn3QOynQfyCeLO/eheuLNNPna/0SO5K
	 ESiOAQlvPlZWg==
Received: from tr.lan (ip-86-49-120-218.bb.vodafone.cz [86.49.120.218])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 98CCA88495;
 Thu, 27 Jun 2024 01:57:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1719446272;
 bh=j9+gNS0RvBKJupbfHAroI1F5otxQD2cptbmul1pdCUM=;
 h=From:To:Cc:Subject:Date:From;
 b=COSdsZQAdkVFtgDBSrlF5Gijkt24B+EwJUTAil4EgCGlSPK7tKKQNMBhS1LeEPzgB
 FVedUPKHF/6hNGCHFTGVcDYW9CMWiWaxUTVPyNmXPoKI6XzBO9SfZcGLVDDQKGE5YL
 cvveotTcSSuvFePkTqGuWWBwwsqKcopsyFCLUNz6eL8CIFsR31okrjZCoUKk/im+Zj
 RZhSEdj/vWwbWFPkgdJ8Wow9SALESRiFy/AhGjqfA3VB3/vnE/4m1Sc+GIlCODkGGw
 eY8mzKd06viDAMPdaT+WEr/Hk5zGCewjRHlgcbgcVrIaMq8oGUc3FUV0avjIhpgt/y
 S7RNug7vFx9mA==
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
Subject: [PATCH 1/4] power: regulator: Trigger probe of regulators which are
 always-on or boot-on
Date: Thu, 27 Jun 2024 01:55:41 +0200
Message-ID: <20240626235717.272219-1-marex@denx.de>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 27 Jun 2024 06:29:48 +0200
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
 drivers/power/regulator/regulator-uclass.c | 22 +++++++++++++++-------
 1 file changed, 15 insertions(+), 7 deletions(-)

diff --git a/drivers/power/regulator/regulator-uclass.c b/drivers/power/regulator/regulator-uclass.c
index 66fd531da04..ccc4ef33d83 100644
--- a/drivers/power/regulator/regulator-uclass.c
+++ b/drivers/power/regulator/regulator-uclass.c
@@ -433,6 +433,8 @@ static int regulator_post_bind(struct udevice *dev)
 	const char *property = "regulator-name";
 
 	uc_pdata = dev_get_uclass_plat(dev);
+	uc_pdata->always_on = dev_read_bool(dev, "regulator-always-on");
+	uc_pdata->boot_on = dev_read_bool(dev, "regulator-boot-on");
 
 	/* Regulator's mandatory constraint */
 	uc_pdata->name = dev_read_string(dev, property);
@@ -444,13 +446,21 @@ static int regulator_post_bind(struct udevice *dev)
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
+	if (uc_pdata->always_on && uc_pdata->boot_on)
+		dev_or_flags(dev, DM_FLAG_PROBE_AFTER_BIND);
 
-	return -EINVAL;
+	return 0;
 }
 
 static int regulator_pre_probe(struct udevice *dev)
@@ -473,8 +483,6 @@ static int regulator_pre_probe(struct udevice *dev)
 						-ENODATA);
 	uc_pdata->max_uA = dev_read_u32_default(dev, "regulator-max-microamp",
 						-ENODATA);
-	uc_pdata->always_on = dev_read_bool(dev, "regulator-always-on");
-	uc_pdata->boot_on = dev_read_bool(dev, "regulator-boot-on");
 	uc_pdata->ramp_delay = dev_read_u32_default(dev, "regulator-ramp-delay",
 						    0);
 	uc_pdata->force_off = dev_read_bool(dev, "regulator-force-boot-off");
-- 
2.43.0

