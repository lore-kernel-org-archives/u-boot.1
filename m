Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0142CAC5A3
	for <u-boot@archiver.kernel.org>; Tue, 17 Sep 2024 20:59:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A162488DFE;
	Tue, 17 Sep 2024 22:59:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="AlO7Y96f";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7EA0D88DC7; Tue, 17 Sep 2024 22:59:48 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [207.246.76.47])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3228088DC7
 for <u-boot@lists.denx.de>; Tue, 17 Sep 2024 22:59:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=2cee=QQ=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1726606778; bh=s18EhKjwDYC8a+SrCYQbXNT9Gv2NRAxfMN1cwCx44sY=;
 b=AlO7Y96fgfbnI3zIe7HxUeCmKcJ0/ZZQk4Ub+uSZ+aanNxLuBY9hgPuBYcPFiSiJvyjtcC5ip
 Qg7exODgFIc2ey8anAHr6m9JIZf1g9wtrVut8oHM1K/c2xh2t9JZaM3L0NPX8pzwcG1P8/TZrcE
 pQv9ceFXwozIc9uQGpKwH7fenHlO4ExSsj86rWXCCLxqVIl1bpLa5qtTxgcVAD+q4dwEKYd7Lvp
 /3gaPT5iLp63kSpj2VFzzSq8lVA4sLEtszYT4gpjj5OPOvbZ+qeE6MTd+dHWu8/GiPTivLdR8uy
 c9+wqe13WW5SYIUIgVAGFE+X2UieDnPn2Ll36ReUItdQ==
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, Tom Rini <trini@konsulko.com>,
 Quentin Schulz <quentin.schulz@cherry.de>
Cc: u-boot@lists.denx.de,
	Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH v2 2/2] regulator: rk8xx: Use buck variable consistently
Date: Tue, 17 Sep 2024 20:59:18 +0000
Message-ID: <20240917205922.648088-2-jonas@kwiboo.se>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20240917205922.648088-1-jonas@kwiboo.se>
References: <20240917205922.648088-1-jonas@kwiboo.se>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 207.246.76.47
X-ForwardEmail-ID: 66e9edb5d8ca6c13c64ed543
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

The buck variable is zero based, i.e. buck=0 match BUCK1 in datasheet.

Remove any buck + 1 calculation to be more consistent in usage of the
buck variable across the different RK8xx variants in the driver.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
v2:
- Move buck + 1 related changes into a separate patch
- Remove all buck + 1 use to be fully consistent
---
 drivers/power/regulator/rk8xx.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/power/regulator/rk8xx.c b/drivers/power/regulator/rk8xx.c
index b910943c2c46..375d06e3207f 100644
--- a/drivers/power/regulator/rk8xx.c
+++ b/drivers/power/regulator/rk8xx.c
@@ -381,7 +381,7 @@ static int _buck_set_value(struct udevice *pmic, int buck, int uvolt)
 		val = ((uvolt - info->min_uv) / info->step_uv) + info->min_sel;
 
 	debug("%s: volt=%d, buck=%d, reg=0x%x, mask=0x%x, val=0x%x\n",
-	      __func__, uvolt, buck + 1, info->vsel_reg, mask, val);
+	      __func__, uvolt, buck, info->vsel_reg, mask, val);
 
 	if (priv->variant == RK816_ID) {
 		pmic_clrsetbits(pmic, info->vsel_reg, mask, val);
@@ -470,7 +470,7 @@ static int _buck_set_suspend_value(struct udevice *pmic, int buck, int uvolt)
 		val = ((uvolt - info->min_uv) / info->step_uv) + info->min_sel;
 
 	debug("%s: volt=%d, buck=%d, reg=0x%x, mask=0x%x, val=0x%x\n",
-	      __func__, uvolt, buck + 1, info->vsel_sleep_reg, mask, val);
+	      __func__, uvolt, buck, info->vsel_sleep_reg, mask, val);
 
 	return pmic_clrsetbits(pmic, info->vsel_sleep_reg, mask, val);
 }
@@ -539,9 +539,10 @@ static int _buck_set_suspend_enable(struct udevice *pmic, int buck, bool enable)
 		{
 			u8 reg;
 
-			if (buck + 1 >= 9) {
+			if (buck >= 8) {
+				/* BUCK9 and BUCK10 */
 				reg = RK806_POWER_SLP_EN1;
-				mask = BIT(buck + 1 - 3);
+				mask = BIT(buck - 2);
 			} else {
 				reg = RK806_POWER_SLP_EN0;
 				mask = BIT(buck);
@@ -590,9 +591,10 @@ static int _buck_get_suspend_enable(struct udevice *pmic, int buck)
 		{
 			u8 reg;
 
-			if (buck + 1 >= 9) {
+			if (buck >= 8) {
+				/* BUCK9 and BUCK10 */
 				reg = RK806_POWER_SLP_EN1;
-				mask = BIT(buck + 1 - 3);
+				mask = BIT(buck - 2);
 			} else {
 				reg = RK806_POWER_SLP_EN0;
 				mask = BIT(buck);
-- 
2.46.1

