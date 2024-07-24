Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 332A9C3DA64
	for <u-boot@archiver.kernel.org>; Wed, 24 Jul 2024 22:47:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0A921889D9;
	Thu, 25 Jul 2024 00:47:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="fwBOZ1vM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AFF6288929; Thu, 25 Jul 2024 00:47:27 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 31FBD889CB
 for <u-boot@lists.denx.de>; Thu, 25 Jul 2024 00:47:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=fa7d=OZ=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: Message-ID: Date: Subject: Cc:
 To: From; q=dns/txt; s=fe-e1b5cab7be; t=1721861240;
 bh=gtYfVHkmba4s2XI0nvMd9Z70fLs550YRUn+7ItDPi4g=;
 b=fwBOZ1vMHObQKCpiURmN1NT/81Df7YIIh/SzbKORq10EN+mt1c6maD6i6whEYibDuvky7AL9W
 41tJUw/Pkm1qFyJ7TtKEcaD5pw0Tq6SmHXS9bwYkn6f05di5IAKxx1ZuAe2zAoq1Ha++vH6chCn
 moortk/weTA4AQDOEb7lGFWwKHEUwvBx8NwoXMcAsFEiDeejFv48hzFeHn/nkJLnyyfB7Oa8Xwm
 Bxcw2BW1P2G6VkqjmVXuCEwBUV8rX91w8qjXXoOorVL2sYgsyCO/pCIrVgeo0fwWJIC9fnBOLKo
 BPHHqwEblY3TiI7eG0Lx3fre8Wh6aDCG/wyQ4d85kdIg==
From: Jonas Karlman <jonas@kwiboo.se>
To: Jaehoon Chung <jh80.chung@samsung.com>, Tom Rini <trini@konsulko.com>
Cc: Jonas Karlman <jonas@kwiboo.se>, u-boot@lists.denx.de
Subject: [PATCH 1/2] power: regulator: Do not call set_suspend_value with
 -ENODATA
Date: Wed, 24 Jul 2024 22:47:10 +0000
Message-ID: <20240724224713.2963301-1-jonas@kwiboo.se>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 66a18477c03061da306c8846
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

On some boards a PMIC regulator is flagged with regulator-on-in-suspend
and does not define any suspend or max microvolt, e.g. on Radxa ROCK 3A:

  vcc_ddr: DCDC_REG3 {
	regulator-name = "vcc_ddr";
	regulator-always-on;
	regulator-boot-on;
	regulator-initial-mode = <0x2>;

	regulator-state-mem {
		regulator-on-in-suspend;
	};
  };

This result in suspend_uV having the value -ENODATA after probe.

This negative voltage, -ENODATA, gets missinterpreted and result in an
unexpected voltage being set by autoset.

E.g. on Radxa ROCK 3A the vcc_ddr regulator by default have a normal and
suspend voltage value of 0.5v. However, due to this missinterpretation
the suspend voltage end up beind set to 0.5625v instead.

Fix this by skip calling regulator_set_suspend_value() in autoset and
also protect calling set value ops when input value is -ENODATA.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 drivers/power/regulator/regulator-uclass.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/power/regulator/regulator-uclass.c b/drivers/power/regulator/regulator-uclass.c
index 88a8525b3c47..03d39587b315 100644
--- a/drivers/power/regulator/regulator-uclass.c
+++ b/drivers/power/regulator/regulator-uclass.c
@@ -60,6 +60,8 @@ int regulator_set_value(struct udevice *dev, int uV)
 		return -EINVAL;
 	if (uc_pdata->max_uV != -ENODATA && uV > uc_pdata->max_uV)
 		return -EINVAL;
+	if (uV == -ENODATA)
+		return -EINVAL;
 
 	if (!ops || !ops->set_value)
 		return -ENOSYS;
@@ -90,6 +92,8 @@ int regulator_set_suspend_value(struct udevice *dev, int uV)
 		return -EINVAL;
 	if (uc_pdata->max_uV != -ENODATA && uV > uc_pdata->max_uV)
 		return -EINVAL;
+	if (uV == -ENODATA)
+		return -EINVAL;
 
 	if (!ops->set_suspend_value)
 		return -ENOSYS;
@@ -141,6 +145,8 @@ int regulator_set_current(struct udevice *dev, int uA)
 		return -EINVAL;
 	if (uc_pdata->max_uA != -ENODATA && uA > uc_pdata->max_uA)
 		return -EINVAL;
+	if (uA == -ENODATA)
+		return -EINVAL;
 
 	if (!ops || !ops->set_current)
 		return -ENOSYS;
@@ -299,7 +305,7 @@ int regulator_autoset(struct udevice *dev)
 	if (ret == -ENOSYS)
 		ret = 0;
 
-	if (!ret && uc_pdata->suspend_on) {
+	if (!ret && uc_pdata->suspend_on && uc_pdata->suspend_uV != -ENODATA) {
 		ret = regulator_set_suspend_value(dev, uc_pdata->suspend_uV);
 		if (ret == -ENOSYS)
 			ret = 0;
-- 
2.45.2

