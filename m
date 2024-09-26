Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE8CFCEBF76
	for <u-boot@archiver.kernel.org>; Fri, 27 Sep 2024 04:44:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6135289070;
	Fri, 27 Sep 2024 06:44:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1727412279;
	bh=5aY23Ge8j8IadboOveNUYnj3/odcSp76oaU3rtta2lM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=kC4OAFoIy352u5fu713x/4IfSt6DBxb7fAmmrq8S99hL8kxNexiZiPFz4RPBmJW1G
	 iEFtVOCIn0T4VYEsRGbWhgaEWky5JcduCoz/65j6SIb0hZbtkLBFhM0J/IpEZBcPig
	 09TSWef8MnK+dpIzj6DkDpX7YUcLxNFU/55kN7CTSuOyAF2CFrIlzg7kjVYqRBMdp5
	 iuRYsk7YhRXrz0V3CPmhHygk1G2Fgl3o57p9Ji7Il0frn9y7jTVFs91/bwgCiNiQJS
	 pn28kF8HJBL2CAlAgCnwSVb475z6KezAaT5n1zg0Kys2XHgDXoTMgcTTeYtWd5/6qZ
	 pAPKsrzHJqg8A==
Received: from tr.lan (ip-86-49-120-218.bb.vodafone.cz [86.49.120.218])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 9606888FA7;
 Fri, 27 Sep 2024 01:15:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1727392526;
 bh=5aY23Ge8j8IadboOveNUYnj3/odcSp76oaU3rtta2lM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=g2JdtgwmmAQn6IavUiqg3NVepPkdFvhgeQdfnPRt9EkL/lbtO3Lv+zZwv6GeM5JXp
 Us0VhD8H96srKA2xshAmLT11jJceVSJehPcKj/ecL0qAiBMa/se8qJp9lQUSGd4Wnc
 K8+XWEceUD3cdXdViLjFGI/6bQ7etnoc6WvwFMx6FS2AQfbA/9GarW16X61yTSaGp8
 njyDLNmxEO3Px8KvYz8YdAfhwyBhOEB/h4oTuWfrGOiXJuV8QDKuGsZuXK2kja3Urh
 nOAHq8gQUDOulJJiCG/LFpYoZdW+BsRF5gQ7vlOBPfGjW4CQxFwtZkkNnyhr+eLkvL
 gZAboT2aAR0TA==
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
Subject: [PATCH v3 2/4] power: regulator: Convert
 regulators_enable_boot_on/off() to regulator_post_probe
Date: Fri, 27 Sep 2024 01:14:13 +0200
Message-ID: <20240926231457.2933914-2-marex@denx.de>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240926231457.2933914-1-marex@denx.de>
References: <20240926231457.2933914-1-marex@denx.de>
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

Turn regulators_enable_boot_on() and regulators_enable_boot_off() into
empty functions. Implement matching functionality in regulator_post_probe()
instead. The regulator_post_probe() is called for all regulators after they
probe, and regulators that have regulator-always-on or regulator-boot-on DT
properties now always probe due to DM_FLAG_PROBE_AFTER_BIND being set on
such regulators in regulator_post_bind().

Finally, fold regulator_unset() functionality into regulator_autoset().

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
V2: Rebase on current u-boot/next
V3: No change
---
 drivers/power/regulator/regulator-uclass.c | 60 +++++++---------------
 1 file changed, 19 insertions(+), 41 deletions(-)

diff --git a/drivers/power/regulator/regulator-uclass.c b/drivers/power/regulator/regulator-uclass.c
index 1a970004540..9fcc4bd85b9 100644
--- a/drivers/power/regulator/regulator-uclass.c
+++ b/drivers/power/regulator/regulator-uclass.c
@@ -314,6 +314,11 @@ int regulator_autoset(struct udevice *dev)
 			return ret;
 	}
 
+	if (uc_pdata->force_off) {
+		ret = regulator_set_enable(dev, false);
+		goto out;
+	}
+
 	if (!uc_pdata->always_on && !uc_pdata->boot_on) {
 		ret = -EMEDIUMTYPE;
 		goto out;
@@ -518,56 +523,28 @@ static int regulator_pre_probe(struct udevice *dev)
 	return 0;
 }
 
-int regulators_enable_boot_on(bool verbose)
+static int regulator_post_probe(struct udevice *dev)
 {
-	struct udevice *dev;
-	struct uclass *uc;
 	int ret;
 
-	ret = uclass_get(UCLASS_REGULATOR, &uc);
-	if (ret)
+	ret = regulator_autoset(dev);
+	if (ret && ret != -EMEDIUMTYPE && ret != -EALREADY && ret != ENOSYS)
 		return ret;
-	for (uclass_first_device(UCLASS_REGULATOR, &dev);
-	     dev;
-	     uclass_next_device(&dev)) {
-		ret = regulator_autoset(dev);
-		if (ret == -EMEDIUMTYPE || ret == -EALREADY) {
-			ret = 0;
-			continue;
-		}
-		if (verbose)
-			regulator_show(dev, ret);
-		if (ret == -ENOSYS)
-			ret = 0;
-	}
 
-	return ret;
+	if (_DEBUG)
+		regulator_show(dev, ret);
+
+	return 0;
 }
 
-int regulators_enable_boot_off(bool verbose)
+int regulators_enable_boot_on(bool verbose)
 {
-	struct udevice *dev;
-	struct uclass *uc;
-	int ret;
-
-	ret = uclass_get(UCLASS_REGULATOR, &uc);
-	if (ret)
-		return ret;
-	for (uclass_first_device(UCLASS_REGULATOR, &dev);
-	     dev;
-	     uclass_next_device(&dev)) {
-		ret = regulator_unset(dev);
-		if (ret == -EMEDIUMTYPE) {
-			ret = 0;
-			continue;
-		}
-		if (verbose)
-			regulator_show(dev, ret);
-		if (ret == -ENOSYS)
-			ret = 0;
-	}
+	return 0;
+}
 
-	return ret;
+int regulators_enable_boot_off(bool verbose)
+{
+	return 0;
 }
 
 UCLASS_DRIVER(regulator) = {
@@ -575,5 +552,6 @@ UCLASS_DRIVER(regulator) = {
 	.name		= "regulator",
 	.post_bind	= regulator_post_bind,
 	.pre_probe	= regulator_pre_probe,
+	.post_probe	= regulator_post_probe,
 	.per_device_plat_auto	= sizeof(struct dm_regulator_uclass_plat),
 };
-- 
2.45.2

