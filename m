Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C53D2CCFA02
	for <u-boot@archiver.kernel.org>; Sat,  1 Nov 2025 20:34:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0887783642;
	Sat,  1 Nov 2025 21:34:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="pZsUzATZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4F38083677; Sat,  1 Nov 2025 21:34:53 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 81CA58331F
 for <u-boot@lists.denx.de>; Sat,  1 Nov 2025 21:34:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=bfc8=5K=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: Message-ID: Date: Subject: Cc:
 To: From; q=dns/txt; s=fe-e1b5cab7be; t=1762029289;
 bh=WcjoTpFOuIyeG9QuUgPCzEeBOIwuc6m1ctSEL5Vbgfs=;
 b=pZsUzATZA80dsjQ5IfVVfZxy5NlskgUoLXsBkg4oOOoePvFlf1A42m/7XG838Jxvy4UQPvOc+
 rV6tcD74K3NOe3btDPjyOpYXt9GvL+HRmrMyCcSuUqTCzhdV2SOpzEwQxWOVtyYIOsaYtTcmTja
 CUPi9oXFYwdCfuekGsQh4kgWuVooxnpVplV5wxZk3PJuWbNro+JgyMNWSW/TlZ41w2y+twSogDA
 ugThJf+T2dQaVcQXnkrA5kQM6Vzf4EoKIcle/OJtUwDpFoNF5m/YUAz2zwWj1vCSdQvlpGDYLLW
 x4w4gtVE4JOz3MGK9Qf18IHW1/b/UQVbaJYraIsPdFtQ==
X-Forward-Email-ID: 69066ee0d987fc274f5252ac
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-Forward-Email-Version: 1.4.1
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Tom Rini <trini@konsulko.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Peng Fan <peng.fan@nxp.com>
Cc: Ye Li <ye.li@nxp.com>, Fabio Estevam <festevam@gmail.com>,
 Jonas Karlman <jonas@kwiboo.se>, Dang Huynh <danct12@riseup.net>,
 u-boot@lists.denx.de
Subject: [PATCH] Revert "power: regulator: Add vin-supply for GPIO and Fixed
 regulators"
Date: Sat,  1 Nov 2025 20:34:26 +0000
Message-ID: <20251101203429.1603832-1-jonas@kwiboo.se>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Rockchip boards may depend on a working MMC regulator in SPL to
successfully load FIT payload from MMC. Typically, these boards only
include the vmmc-supply regulator and not its vin-supply in SPL control
FDT.

The commit f98d812e5353 ("power: regulator: Add vin-supply for GPIO and
Fixed regulators") breaks loading FIT from MMC in SPL on some of these
boards due to now requiring the vin-supply to be included in the SPL
control FDT.

The commit also strangely enables any found vin-supply in
regulator_common_of_to_plat() and not when a regulator is enabled or as
part of regulator_autoset().

Revert the commit to fix FIT loading in SPL on broken boards.

If a board needs to have its vin-supply enabled, two options come to
mind:

- Add regulator-always-on prop to the regulator in the -u-boot.dtsi for
  any board.

- Implement full support for reference counting of regulators and then
  update the regulator-uclass to enable any found vin-supply when a
  regulator is enabled.

This reverts commit f98d812e5353408ef77a46bad1f1cdc793ff8a03.

Reported-by: Dang Huynh <danct12@riseup.net>
Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 drivers/power/regulator/regulator_common.c | 10 ----------
 drivers/power/regulator/regulator_common.h |  1 -
 2 files changed, 11 deletions(-)

diff --git a/drivers/power/regulator/regulator_common.c b/drivers/power/regulator/regulator_common.c
index 3ed713ce5019..685d8735fa5c 100644
--- a/drivers/power/regulator/regulator_common.c
+++ b/drivers/power/regulator/regulator_common.c
@@ -44,16 +44,6 @@ int regulator_common_of_to_plat(struct udevice *dev,
 			dev_read_u32_default(dev, "u-boot,off-on-delay-us", 0);
 	}
 
-	ret = device_get_supply_regulator(dev, "vin-supply", &plat->vin_supply);
-	if (ret) {
-		debug("Regulator vin regulator not defined: %d\n", ret);
-		if (ret != -ENOENT)
-			return ret;
-	}
-
-	if (plat->vin_supply)
-		regulator_set_enable_if_allowed(plat->vin_supply, true);
-
 	return 0;
 }
 
diff --git a/drivers/power/regulator/regulator_common.h b/drivers/power/regulator/regulator_common.h
index 799c968d0b66..d4962899d830 100644
--- a/drivers/power/regulator/regulator_common.h
+++ b/drivers/power/regulator/regulator_common.h
@@ -14,7 +14,6 @@ struct regulator_common_plat {
 	unsigned int startup_delay_us;
 	unsigned int off_on_delay_us;
 	unsigned int enable_count;
-	struct udevice *vin_supply;
 };
 
 int regulator_common_of_to_plat(struct udevice *dev,
-- 
2.51.0

