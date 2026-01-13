Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D6B9D29DC2
	for <u-boot@archiver.kernel.org>; Tue, 13 Jan 2026 04:02:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A63E28388D;
	Tue, 13 Jan 2026 05:02:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gentoo.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id EAEB083885; Tue, 13 Jan 2026 05:02:47 +0100 (CET)
Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AE6B6836A3
 for <u-boot@lists.denx.de>; Tue, 13 Jan 2026 05:02:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=gentoo.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=dlan@gentoo.org
Received: from ofovo.local (unknown [116.232.18.222])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: dlan)
 by smtp.gentoo.org (Postfix) with ESMTPSA id 233243411FF;
 Tue, 13 Jan 2026 04:02:40 +0000 (UTC)
From: Yixun Lan <dlan@gentoo.org>
Date: Tue, 13 Jan 2026 12:01:55 +0800
Subject: [PATCH v3 1/9] power: regulator: add AXP318W support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260113-01-a733-soc-support-v3-1-f19dcd098f60@gentoo.org>
References: <20260113-01-a733-soc-support-v3-0-f19dcd098f60@gentoo.org>
In-Reply-To: <20260113-01-a733-soc-support-v3-0-f19dcd098f60@gentoo.org>
To: u-boot@lists.denx.de
Cc: linux-sunxi@lists.linux.dev, Andre Przywara <andre.przywara@arm.com>, 
 Jagan Teki <jagan@amarulasolutions.com>, Tom Rini <trini@konsulko.com>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Paul Kocialkowski <contact@paulk.fr>, Samuel Holland <samuel@sholland.org>, 
 Yixun Lan <dlan@gentoo.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=5529; i=dlan@gentoo.org;
 h=from:subject:message-id; bh=xp4StcskhTGvUSXGraji1RmyCScxqtHPV9B3WySr3dg=;
 b=owEB6QIW/ZANAwAKATGq6kdZTbvtAcsmYgBpZcPANOiZ4S3OEsB0WFOAe1E5VwTo+wmmuIEII
 IkgzaXWNhGJAq8EAAEKAJkWIQS1urjJwxtxFWcCI9wxqupHWU277QUCaWXDwBsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMSwyLDJfFIAAAAAALgAoaXNzdWVyLWZwckBub3RhdGlvbnMub3BlbnBncC5
 maWZ0aGhvcnNlbWFuLm5ldEI1QkFCOEM5QzMxQjcxMTU2NzAyMjNEQzMxQUFFQTQ3NTk0REJCRU
 QACgkQMarqR1lNu+1BBw//X/fuf5lPXpUGgQMTTGnnAtnSMWgnmF0Hk61femM2vok6rVs5FK5g0
 0jfl55SDO1CEhK8lAYP6N+hYUmUc5nwBUlO0LlSUIfIZZUAAGeYWr/ZTvkr0KbC1BuWS3+aDtV1
 tcCfeyzCKFJUgEojVQ9NHuFnHeVzZBTMcJILEPioznUNGvNHBxXM+Zb8QJVxyLIv/11Ic7dbNId
 0IWmLI9Kqps7410T/TRanZPyg1vpj9pN3vmpSx4lJ8CMjOE+6JXQnnBI1BmBa2C7AhJZs9EY7dG
 sxeOXuS2net9G+A3fmxur2SfVFoUxmu31Zb1wPY1FIM8okB1Vqi3Ar3SYGoBRRk9AyGre2k2Ubb
 Rs06n4Tavv/B1+jkVqX308tYp4tx6g62vnxJmTt5tjHH4Fq5u5ubZg83gK2hLfFAdpGtpQM1yhi
 JCzayz32KxvlSSe9E8tMtt7jUpoKEVDrUhCnf3iwMXbnHq7U4Cqdpbt7kMDI0yi47DYs8U88frQ
 A2qC34C3yefLoRhR6mtdiQDs4JnKubjrCF5PhXor83475F5FIZwhH01wI0glhjBWxcKGo08Wz6P
 sR5f2SQ4MhhxHPpSG+p5Hyx03fhQDEwPuUhQGAiYbzgiwGbn7RMCy3l784i2wNIg5s1f9fSLgQf
 esdxfu7btUhcNsePEwgmkHi4mHlZwY=
X-Developer-Key: i=dlan@gentoo.org; a=openpgp;
 fpr=50B03A1A5CBCD33576EF8CD7920C0DBCAABEFD55
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

The PMIC is also known as AXP819 in vendor pmu code

For DCDC6, 8, 9, the underlying hardware support more than two levels
voltage step tuning, but for now only first two levels are implemented
in this driver, hence highest voltage will be limited at seccond level.
It actual meets board requirement in current design, and we've verified
it in Radxa Cubie A7A board.

Following are detail explanation of voltage tuning stpes for those DCDCs:

DCDC | voltage range  | units | steps | implemented
 6   | 0.5   -  1.2   | 10 mV | 71    | Y
 .   | 1.22  -  1.54  | 20 mV | 17    | Y
 .   | 1.8   -  2.4   | 20 mV | 31    | N
 .   | 2.44  -  2.76  | 40 mV | 9     | N
 --------------------------------------------------
 8/9 | 0.5   -  1.2   | 10 mV | 71    | Y
 .   | 1.22  -  1.84  | 20 mV | 32    | Y
 .   | 1.9   -  3.4   | 100mV | 16    | N

Signed-off-by: Yixun Lan <dlan@gentoo.org>
---
 drivers/power/pmic/axp.c                |  1 +
 drivers/power/regulator/axp_regulator.c | 50 +++++++++++++++++++++++++++++++++
 include/axp_pmic.h                      |  1 +
 3 files changed, 52 insertions(+)

diff --git a/drivers/power/pmic/axp.c b/drivers/power/pmic/axp.c
index 1204ec00f8d..7d8348b0769 100644
--- a/drivers/power/pmic/axp.c
+++ b/drivers/power/pmic/axp.c
@@ -95,6 +95,7 @@ static const struct udevice_id axp_pmic_ids[] = {
 	{ .compatible = "x-powers,axp806", .data = AXP806_ID },
 	{ .compatible = "x-powers,axp809", .data = AXP809_ID },
 	{ .compatible = "x-powers,axp813", .data = AXP813_ID },
+	{ .compatible = "x-powers,axp318w", .data = AXP318_ID },
 	{ }
 };
 
diff --git a/drivers/power/regulator/axp_regulator.c b/drivers/power/regulator/axp_regulator.c
index 7794a4f5d92..16d3a8f7f90 100644
--- a/drivers/power/regulator/axp_regulator.c
+++ b/drivers/power/regulator/axp_regulator.c
@@ -189,6 +189,55 @@ static const struct axp_regulator_plat axp313_regulators[] = {
 	{ }
 };
 
+ /*
+  * Only two level step tuning is implemented for DCDC6, 8, 9
+  * so the voltage below is not support in this driver
+  * DCDC6:   20  (v1.8 - 2.4v), 40 (2.44v - 2.76v)
+  * DCDC8,9: 100 (1.9v - 3.4v)
+  */
+static const struct axp_regulator_plat axp318_regulators[] = {
+	{  "dcdc1", 0x10, BIT(0), 0x12, 0x1f, 1000, 3400, 100, NA },
+	{  "dcdc2", 0x10, BIT(1), 0x13, 0x7f,  500, 1540,  10, 70 },
+	{  "dcdc3", 0x10, BIT(2), 0x14, 0x7f,  500, 1540,  10, 70 },
+	{  "dcdc4", 0x10, BIT(3), 0x15, 0x7f,  500, 1540,  10, 70 },
+	{  "dcdc5", 0x10, BIT(4), 0x16, 0x7f,  500, 1540,  10, 70 },
+	{  "dcdc6", 0x10, BIT(5), 0x17, 0x7f,  500, 1540,  10, 70 },
+	{  "dcdc7", 0x10, BIT(6), 0x18, 0x7f,  500, 1840,  10, 70 },
+	{  "dcdc8", 0x10, BIT(7), 0x19, 0x7f,  500, 1840,  10, 70 },
+	{  "dcdc9", 0x11, BIT(0), 0x1a, 0x7f,  500, 1840,  10, 70 },
+	{  "aldo1", 0x20, BIT(0), 0x24, 0x1f,  500, 3400, 100, NA },
+	{  "aldo2", 0x20, BIT(1), 0x25, 0x1f,  500, 3400, 100, NA },
+	{  "aldo3", 0x20, BIT(2), 0x26, 0x1f,  500, 3400, 100, NA },
+	{  "aldo4", 0x20, BIT(3), 0x27, 0x1f,  500, 3400, 100, NA },
+	{  "aldo5", 0x20, BIT(4), 0x28, 0x1f,  500, 3400, 100, NA },
+	{  "aldo6", 0x20, BIT(5), 0x29, 0x1f,  500, 3400, 100, NA },
+	{  "bldo1", 0x20, BIT(6), 0x2a, 0x1f,  500, 3400, 100, NA },
+	{  "bldo2", 0x20, BIT(7), 0x2b, 0x1f,  500, 3400, 100, NA },
+	{  "bldo3", 0x21, BIT(0), 0x2c, 0x1f,  500, 3400, 100, NA },
+	{  "bldo4", 0x21, BIT(1), 0x2d, 0x1f,  500, 3400, 100, NA },
+	{  "bldo5", 0x21, BIT(2), 0x2e, 0x1f,  500, 3400, 100, NA },
+	{  "cldo1", 0x21, BIT(3), 0x2f, 0x1f,  500, 3400, 100, NA },
+	{  "cldo2", 0x21, BIT(4), 0x30, 0x1f,  500, 3400, 100, NA },
+	{  "cldo3", 0x21, BIT(5), 0x31, 0x1f,  500, 3400, 100, NA },
+	{  "cldo4", 0x21, BIT(6), 0x32, 0x1f,  500, 3400, 100, NA },
+	{  "cldo5", 0x21, BIT(7), 0x33, 0x1f,  500, 3400, 100, NA },
+	{  "dldo1", 0x22, BIT(0), 0x34, 0x1f,  500, 3400, 100, NA },
+	{  "dldo2", 0x22, BIT(1), 0x35, 0x1f,  500, 3400, 100, NA },
+	{  "dldo3", 0x22, BIT(2), 0x36, 0x1f,  500, 3400, 100, NA },
+	{  "dldo4", 0x22, BIT(3), 0x37, 0x1f,  500, 3400, 100, NA },
+	{  "dldo5", 0x22, BIT(4), 0x38, 0x1f,  500, 3400, 100, NA },
+	{  "dldo6", 0x22, BIT(5), 0x39, 0x1f,  500, 3400, 100, NA },
+	{  "eldo1", 0x22, BIT(6), 0x3a, 0x1f,  500, 1500,  25, NA },
+	{  "eldo2", 0x22, BIT(7), 0x3b, 0x1f,  500, 1500,  25, NA },
+	{  "eldo3", 0x23, BIT(0), 0x3c, 0x1f,  500, 1500,  25, NA },
+	{  "eldo4", 0x23, BIT(1), 0x3d, 0x1f,  500, 1500,  25, NA },
+	{  "eldo5", 0x23, BIT(2), 0x3e, 0x1f,  500, 1500,  25, NA },
+	{  "eldo6", 0x23, BIT(3), 0x3f, 0x1f,  500, 1500,  25, NA },
+	{ "swout1", 0x11, BIT(3),   NA,   NA,   NA,   NA,  NA, NA },
+	{ "swout2", 0x11, BIT(4),   NA,   NA,   NA,   NA,  NA, NA },
+	{ }
+};
+
 /*
  * The "dcdc2" regulator has another range, beyond 1.54V up to 3.4V, in
  * steps of 100mV. We cannot model this easily, but also don't need that,
@@ -318,6 +367,7 @@ static const struct axp_regulator_plat *const axp_regulators[] = {
 	[AXP221_ID]	= axp22x_regulators,
 	[AXP223_ID]	= axp22x_regulators,
 	[AXP313_ID]	= axp313_regulators,
+	[AXP318_ID]	= axp318_regulators,
 	[AXP323_ID]	= axp313_regulators,
 	[AXP717_ID]	= axp717_regulators,
 	[AXP803_ID]	= axp803_regulators,
diff --git a/include/axp_pmic.h b/include/axp_pmic.h
index 1806a7270a0..2f547da74c2 100644
--- a/include/axp_pmic.h
+++ b/include/axp_pmic.h
@@ -39,6 +39,7 @@ enum {
 	AXP806_ID,
 	AXP809_ID,
 	AXP813_ID,
+	AXP318_ID,
 };
 
 int axp_set_dcdc1(unsigned int mvolt);

-- 
2.52.0

