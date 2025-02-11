Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AADDFC0219B
	for <u-boot@archiver.kernel.org>; Tue, 11 Feb 2025 17:52:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8ABA7806FE;
	Tue, 11 Feb 2025 18:52:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="X6rfTgn7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B68E7809D0; Tue, 11 Feb 2025 18:52:13 +0100 (CET)
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A83D480079
 for <u-boot@lists.denx.de>; Tue, 11 Feb 2025 18:52:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-kumar1@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 51BHq81Y3739866
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 11 Feb 2025 11:52:08 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1739296328;
 bh=J1iS9w9tflMBKpT9NymCTKyDFMWNkxGXQEMYJy0n7MM=;
 h=From:To:CC:Subject:Date;
 b=X6rfTgn7v8DMXnN+xjsbbv2kwds3CtqTJ+YWFArfJeFb9W7H8i+kPVe7AAlH5nojZ
 OROT9i9S26hlPaSssfgD2fmemb5hcPjsyxpl7spVMdLfmdIs1BUxVWeZdYxxjUclNH
 tl33Zt8iDbGv4sLEmnDhktMZz4CnlpsXH/NwxDF4=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 51BHq8j2066920
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 11 Feb 2025 11:52:08 -0600
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 11
 Feb 2025 11:52:07 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 11 Feb 2025 11:52:08 -0600
Received: from udit-HP-Z2-Tower-G9-Workstation-Desktop-PC.dhcp.ti.com
 (udit-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [10.24.69.6])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 51BHq4cw117020;
 Tue, 11 Feb 2025 11:52:05 -0600
From: Udit Kumar <u-kumar1@ti.com>
To: <trini@konsulko.com>, <jh80.chung@samsung.com>, <u-boot@lists.denx.de>
CC: <nm@ti.com>, <d-gole@ti.com>, <n-francis@ti.com>, <vigneshr@ti.com>,
 <m-chawdhry@ti.com>, <b-padhi@ti.com>, <j-keerthy@ti.com>, Udit Kumar
 <u-kumar1@ti.com>
Subject: [PATCH] power: regulator: tps65941: Fix voltage calculation for ldo
Date: Tue, 11 Feb 2025 23:21:58 +0530
Message-ID: <20250211175158.867154-1-u-kumar1@ti.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
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

As per TRM[0] Section 8.7.1 "TPS6594-Q1 Registers", LDOx_Vout
bit 6-1, define the NVM voltage settings.
Along side table 8-4 of above TRM, shows voltage to value mapping.

Driver wrongly using bits 5-1 to calculate voltage, and to convert
voltage to value driver was using buck's calculation.
So fix those calculation.

[0]: https://www.ti.com/lit/ds/symlink/tps6594-q1.pdf
Fixes: 5d7dbd22cf7d ("power: regulator: tps65941: use function callbacks for conversion ops")
Signed-off-by: Udit Kumar <u-kumar1@ti.com>
---
Bootlogs
https://gist.github.com/uditkumarti/298bd277da11eb82146d7aff24c402ba

 drivers/power/regulator/tps65941_regulator.c | 16 +++++++++++++---
 include/power/tps65941.h                     |  3 ++-
 2 files changed, 15 insertions(+), 4 deletions(-)

diff --git a/drivers/power/regulator/tps65941_regulator.c b/drivers/power/regulator/tps65941_regulator.c
index bc4d153fd8..13f94b730d 100644
--- a/drivers/power/regulator/tps65941_regulator.c
+++ b/drivers/power/regulator/tps65941_regulator.c
@@ -388,6 +388,14 @@ static int tps65941_ldo_enable(struct udevice *dev, int op, bool *enable)
 	return 0;
 }
 
+static int tps65941_ldo_volt2val(__maybe_unused int idx, int uV)
+{
+	if (uV > TPS65941_LDO_VOLT_MAX || uV < TPS65941_LDO_VOLT_MIN)
+		return -EINVAL;
+
+	return ((uV - 600000) / 50000 + 0x4) << TPS65941_LDO_MODE_MASK;
+}
+
 static int tps65941_ldo_val2volt(__maybe_unused int idx, int val)
 {
 	if (val > TPS65941_LDO_VOLT_MAX_HEX || val < TPS65941_LDO_VOLT_MIN_HEX)
@@ -459,7 +467,7 @@ static int tps65224_ldo_val2volt(int idx, int val)
 static const struct tps65941_reg_conv_ops ldo_conv_ops[] = {
 	[TPS65941_LDO_CONV_OPS_IDX] = {
 		.volt_mask = TPS65941_LDO_VOLT_MASK,
-		.volt2val = tps65941_buck_volt2val,
+		.volt2val = tps65941_ldo_volt2val,
 		.val2volt = tps65941_ldo_val2volt,
 	},
 	[TPS65224_LDO_CONV_OPS_IDX] = {
@@ -472,7 +480,7 @@ static const struct tps65941_reg_conv_ops ldo_conv_ops[] = {
 static int tps65941_ldo_val(struct udevice *dev, int op, int *uV)
 {
 	unsigned int hex, adr;
-	int ret, ret_volt, idx;
+	int ret, ret_volt, idx, ldo_bypass;
 	struct dm_regulator_uclass_plat *uc_pdata;
 	const struct tps65941_reg_conv_ops *conv_ops;
 	ulong chip_id;
@@ -502,7 +510,9 @@ static int tps65941_ldo_val(struct udevice *dev, int op, int *uV)
 	if (ret < 0)
 		return ret;
 
+	ldo_bypass = ret & TPS65941_LDO_BYPASS_EN;
 	ret &= conv_ops->volt_mask;
+	ret = ret >> TPS65941_LDO_MODE_MASK;
 	ret_volt = conv_ops->val2volt(idx, ret);
 	if (ret_volt < 0)
 		return ret_volt;
@@ -531,7 +541,7 @@ static int tps65941_ldo_val(struct udevice *dev, int op, int *uV)
 		ret &= ~TPS65224_LDO_VOLT_MASK;
 		ret |= hex;
 	} else {
-		ret = hex;
+		ret = hex | ldo_bypass;
 	}
 
 	ret = pmic_reg_write(dev->parent, adr, ret);
diff --git a/include/power/tps65941.h b/include/power/tps65941.h
index cec85333f0..a026ec5695 100644
--- a/include/power/tps65941.h
+++ b/include/power/tps65941.h
@@ -21,10 +21,11 @@
 #define TPS65941_BUCK_VOLT_MAX		3340000
 #define TPS65941_BUCK_MODE_MASK		0x1
 
-#define TPS65941_LDO_VOLT_MASK		0x3E
+#define TPS65941_LDO_VOLT_MASK		0x7E
 #define TPS65941_LDO_VOLT_MAX_HEX	0x3A
 #define TPS65941_LDO_VOLT_MIN_HEX	0x4
 #define TPS65941_LDO_VOLT_MAX		3300000
+#define TPS65941_LDO_VOLT_MIN		600000
 #define TPS65941_LDO_MODE_MASK		0x1
 #define TPS65941_LDO_BYPASS_EN		0x80
 #define TP65941_BUCK_CONF_SLEW_MASK	0x7
-- 
2.34.1

