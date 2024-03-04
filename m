Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A2C8C5478C
	for <u-boot@archiver.kernel.org>; Mon,  4 Mar 2024 11:31:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6396487FB6;
	Mon,  4 Mar 2024 12:30:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 96CCF87F9E; Mon,  4 Mar 2024 12:30:42 +0100 (CET)
Received: from smtp-42ab.mail.infomaniak.ch (smtp-42ab.mail.infomaniak.ch
 [84.16.66.171])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8E59987F7E
 for <u-boot@lists.denx.de>; Mon,  4 Mar 2024 12:30:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=foss+uboot@0leil.net
Received: from smtp-4-0000.mail.infomaniak.ch (smtp-4-0000.mail.infomaniak.ch
 [10.7.10.107])
 by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4TpGhn1RDXz8Gf;
 Mon,  4 Mar 2024 12:30:33 +0100 (CET)
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4TpGhm3LKkzrCr; Mon,  4 Mar 2024 12:30:32 +0100 (CET)
From: Quentin Schulz <foss+uboot@0leil.net>
Date: Mon, 04 Mar 2024 12:29:56 +0100
Subject: [PATCH v3 02/16] regulator: rk8xx: remove unused functions
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240304-rk3588-saradc-v3-2-7424e2ed5d3b@theobroma-systems.com>
References: <20240304-rk3588-saradc-v3-0-7424e2ed5d3b@theobroma-systems.com>
In-Reply-To: <20240304-rk3588-saradc-v3-0-7424e2ed5d3b@theobroma-systems.com>
To: Jagan Teki <jagan@amarulasolutions.com>, Tom Rini <trini@konsulko.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, Simon Glass <sjg@chromium.org>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 Kever Yang <kever.yang@rock-chips.com>, 
 Klaus Goger <klaus.goger@theobroma-systems.com>, 
 Heiko Stuebner <heiko.stuebner@cherry.de>
Cc: u-boot@lists.denx.de, 
 Quentin Schulz <quentin.schulz@theobroma-systems.com>, 
 Quentin Schulz <foss+uboot@0leil.net>
X-Mailer: b4 0.13.0
X-Infomaniak-Routing: alpha
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

From: Quentin Schulz <quentin.schulz@theobroma-systems.com>

Those two functions had their last user removed in commit f9c68a566c4d
("rockchip: phycore_rk3288: remove phycore_init() function") part of
v2023.01 release, so let's do some cleanup here.

Cc: Quentin Schulz <foss+uboot@0leil.net>
Signed-off-by: Quentin Schulz <quentin.schulz@theobroma-systems.com>
---
 drivers/power/regulator/rk8xx.c | 31 -------------------------------
 include/power/rk8xx_pmic.h      |  2 --
 2 files changed, 33 deletions(-)

diff --git a/drivers/power/regulator/rk8xx.c b/drivers/power/regulator/rk8xx.c
index e80bd6c3723..97d73ac95e0 100644
--- a/drivers/power/regulator/rk8xx.c
+++ b/drivers/power/regulator/rk8xx.c
@@ -210,14 +210,6 @@ static const struct rk8xx_reg_info rk818_ldo[] = {
 };
 #endif
 
-static const u16 rk818_chrg_cur_input_array[] = {
-	450, 800, 850, 1000, 1250, 1500, 1750, 2000, 2250, 2500, 2750, 3000
-};
-
-static const uint rk818_chrg_shutdown_vsel_array[] = {
-	2780000, 2850000, 2920000, 2990000, 3060000, 3130000, 3190000, 3260000
-};
-
 static const struct rk8xx_reg_info *get_buck_reg(struct udevice *pmic,
 						 int num, int uvolt)
 {
@@ -1160,26 +1152,3 @@ int rk8xx_spl_configure_buck(struct udevice *pmic, int buck, int uvolt)
 
 	return _buck_set_enable(pmic, buck, true);
 }
-
-int rk818_spl_configure_usb_input_current(struct udevice *pmic, int current_ma)
-{
-	uint i;
-
-	for (i = 0; i < ARRAY_SIZE(rk818_chrg_cur_input_array); i++)
-		if (current_ma <= rk818_chrg_cur_input_array[i])
-			break;
-
-	return pmic_clrsetbits(pmic, REG_USB_CTRL, RK818_USB_ILIM_SEL_MASK, i);
-}
-
-int rk818_spl_configure_usb_chrg_shutdown(struct udevice *pmic, int uvolt)
-{
-	uint i;
-
-	for (i = 0; i < ARRAY_SIZE(rk818_chrg_shutdown_vsel_array); i++)
-		if (uvolt <= rk818_chrg_shutdown_vsel_array[i])
-			break;
-
-	return pmic_clrsetbits(pmic, REG_USB_CTRL, RK818_USB_CHG_SD_VSEL_MASK,
-			       i);
-}
diff --git a/include/power/rk8xx_pmic.h b/include/power/rk8xx_pmic.h
index 3cbfc021956..0db82419d4f 100644
--- a/include/power/rk8xx_pmic.h
+++ b/include/power/rk8xx_pmic.h
@@ -233,7 +233,5 @@ struct rk8xx_priv {
 };
 
 int rk8xx_spl_configure_buck(struct udevice *pmic, int buck, int uvolt);
-int rk818_spl_configure_usb_input_current(struct udevice *pmic, int current_ma);
-int rk818_spl_configure_usb_chrg_shutdown(struct udevice *pmic, int uvolt);
 
 #endif

-- 
2.44.0

