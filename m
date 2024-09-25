Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1ED80CF9C69
	for <u-boot@archiver.kernel.org>; Wed, 25 Sep 2024 02:53:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D2D5588B6D;
	Wed, 25 Sep 2024 04:53:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1727232787;
	bh=TnJQl5Hvlypu7lQSJPLJaTt2+GQO6x5Q4WcO04yDkxI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=RZqtI3zINgLvbXOV8OkzjgU2navOKzbEiTgWtAzZb+LXLkejyXDeI1FAGN9bRq2t2
	 ousgrgb5vN7wYql6uoU8jtbfyGDfTGtFcAziBoEsRcvzd8T+OA50AADzjjDzQdFNha
	 /wS+KBYiPm52DPn2sxp6CbhZDbuRu/TP2twmdy5q214sLLXmD7IUIsD6FrRSfBIYlI
	 Ax6oHyh3V4jCDPj3w6it5PrfpAikC/uWb5itmyZn3oZ9X3KVPFiK9PHY7eVTXV3w1Y
	 Q2nZhaqzP+iYpylHr6oFrHD4Aci1HqmOIXgqvn9E/kgmd/UxhQQjCQtVK0WQ2VSyXq
	 0YryyQ72Oz1iA==
Received: from tr.lan (ip-86-49-120-218.bb.vodafone.cz [86.49.120.218])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 3A35A87C69;
 Wed, 25 Sep 2024 04:24:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1727231059;
 bh=TnJQl5Hvlypu7lQSJPLJaTt2+GQO6x5Q4WcO04yDkxI=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=L798oHOQaOTUgG9Q6uV0+nd2qgJFh2Whyw5y/9NxaTX/w+37UfAXSlorH9n0SB6Fz
 daqwDVZDlSuz+gpG24w+UW9yHHsETSAnIHBYVtOYqQwDAJN43PzdmDaoDxfua5s96M
 qINBhKraNJyVjvvF82/KfqigtOaA2YGuM1oWktVSQV6bzfyGWHM1eIOtzbPgPbq3Sa
 6v0+ZgtHjMDzlh/YnUZ8ROdg75rUEorvbGTt5MbkweHMYkX+pBwF+JbEQEjVLcvhiX
 3DYlUZoNIe7733HzO7G7Z0oWhpfWabEyy7CK80poypB6terbIkMOFx244iuMu5yd9s
 aU7HLu8tdU8yg==
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
Subject: [PATCH v2 4/5] power: regulator: Drop regulator_unset()
Date: Wed, 25 Sep 2024 04:21:55 +0200
Message-ID: <20240925022314.714285-4-marex@denx.de>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240925022314.714285-1-marex@denx.de>
References: <20240925022314.714285-1-marex@denx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 25 Sep 2024 04:53:05 +0200
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

This function is never called, drop it.

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
---
 drivers/power/regulator/regulator-uclass.c | 11 -----------
 include/power/regulator.h                  | 14 +-------------
 2 files changed, 1 insertion(+), 24 deletions(-)

diff --git a/drivers/power/regulator/regulator-uclass.c b/drivers/power/regulator/regulator-uclass.c
index 3c05fdf1966..34c2a36ec44 100644
--- a/drivers/power/regulator/regulator-uclass.c
+++ b/drivers/power/regulator/regulator-uclass.c
@@ -343,17 +343,6 @@ out:
 	return ret;
 }
 
-int regulator_unset(struct udevice *dev)
-{
-	struct dm_regulator_uclass_plat *uc_pdata;
-
-	uc_pdata = dev_get_uclass_plat(dev);
-	if (uc_pdata && uc_pdata->force_off)
-		return regulator_set_enable(dev, false);
-
-	return -EMEDIUMTYPE;
-}
-
 static void regulator_show(struct udevice *dev, int ret)
 {
 	struct dm_regulator_uclass_plat *uc_pdata;
diff --git a/include/power/regulator.h b/include/power/regulator.h
index bb07a814c79..5363483d02a 100644
--- a/include/power/regulator.h
+++ b/include/power/regulator.h
@@ -430,7 +430,7 @@ int regulators_enable_boot_on(bool verbose);
  *
  * This disables all regulators which are marked to be off at boot time.
  *
- * This effectively calls regulator_unset() for every regulator.
+ * This effectively does nothing.
  */
 int regulators_enable_boot_off(bool verbose);
 
@@ -453,18 +453,6 @@ int regulators_enable_boot_off(bool verbose);
  */
 int regulator_autoset(struct udevice *dev);
 
-/**
- * regulator_unset: turn off a regulator
- *
- * The setup depends on constraints found in device's uclass's platform data
- * (struct dm_regulator_uclass_platdata):
- *
- * - Disable - will set - if  'force_off' is set to true,
- *
- * The function returns on the first-encountered error.
- */
-int regulator_unset(struct udevice *dev);
-
 /**
  * regulator_autoset_by_name: setup the regulator given by its uclass's
  * platform data name field. The setup depends on constraints found in device's
-- 
2.45.2

