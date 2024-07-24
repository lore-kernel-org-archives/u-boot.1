Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8210EC3DA63
	for <u-boot@archiver.kernel.org>; Wed, 24 Jul 2024 22:47:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7EA2F889A6;
	Thu, 25 Jul 2024 00:47:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="id01VNBW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3A72C889DC; Thu, 25 Jul 2024 00:47:30 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D694588929
 for <u-boot@lists.denx.de>; Thu, 25 Jul 2024 00:47:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=fa7d=OZ=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1721861245; bh=gxRDUd3ZI7zXF7HmrziDHAnabzH/rYg/a87Dwz/12Sc=;
 b=id01VNBWZTTeUmbpDnq2PSIHejnkHzRoAAYiYUlq2CySPos4qO+csNNPW3fDBNA+5DvWALLdJ
 2GMfXpOvG2JTFjQUOL+b+miyZsdKXD277QWlLiEwGuvfCJ5Uojypc8/lE3ks3G+9Q1Ng2M2aIGv
 yt5pYUmll5pJ0m+rDGCZuvamlasO4TQ0kb9R2cFF99YCK57b4qlAhuH4EnMeYUofVTY6B5XnGOJ
 Fyt6ymbPnEQ6CQnWBZ2vhDwZlmlSU+m7YrPYcQd5hzUyFwjkPqzNPw+BbBoAbDaSJ6m1VeZpO4T
 9XXCu0HegFvycr0A5nuTChXXCLM9gOnFEV2nNJ6kipEg==
From: Jonas Karlman <jonas@kwiboo.se>
To: Jaehoon Chung <jh80.chung@samsung.com>, Tom Rini <trini@konsulko.com>
Cc: Jonas Karlman <jonas@kwiboo.se>, u-boot@lists.denx.de
Subject: [PATCH 2/2] power: regulator: Consistently return -ENOSYS when ops is
 unimplemented
Date: Wed, 24 Jul 2024 22:47:11 +0000
Message-ID: <20240724224713.2963301-2-jonas@kwiboo.se>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240724224713.2963301-1-jonas@kwiboo.se>
References: <20240724224713.2963301-1-jonas@kwiboo.se>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 66a1847ac03061da306c885c
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

dev_get_driver_ops() may return NULL when the udevice is invalid.

Move the ops check to top of functions to consistently return -ENOSYS
when ops is unimplemented and prevent trying to access uclass plat data,
also add missing NULL checks to suspend ops.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 drivers/power/regulator/regulator-uclass.c | 24 +++++++++++-----------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/power/regulator/regulator-uclass.c b/drivers/power/regulator/regulator-uclass.c
index 03d39587b315..009229002920 100644
--- a/drivers/power/regulator/regulator-uclass.c
+++ b/drivers/power/regulator/regulator-uclass.c
@@ -55,6 +55,9 @@ int regulator_set_value(struct udevice *dev, int uV)
 	struct dm_regulator_uclass_plat *uc_pdata;
 	int ret, old_uV = uV, is_enabled = 0;
 
+	if (!ops || !ops->set_value)
+		return -ENOSYS;
+
 	uc_pdata = dev_get_uclass_plat(dev);
 	if (uc_pdata->min_uV != -ENODATA && uV < uc_pdata->min_uV)
 		return -EINVAL;
@@ -63,9 +66,6 @@ int regulator_set_value(struct udevice *dev, int uV)
 	if (uV == -ENODATA)
 		return -EINVAL;
 
-	if (!ops || !ops->set_value)
-		return -ENOSYS;
-
 	if (uc_pdata->ramp_delay) {
 		is_enabled = regulator_get_enable(dev);
 		old_uV = regulator_get_value(dev);
@@ -87,6 +87,9 @@ int regulator_set_suspend_value(struct udevice *dev, int uV)
 	const struct dm_regulator_ops *ops = dev_get_driver_ops(dev);
 	struct dm_regulator_uclass_plat *uc_pdata;
 
+	if (!ops || !ops->set_suspend_value)
+		return -ENOSYS;
+
 	uc_pdata = dev_get_uclass_plat(dev);
 	if (uc_pdata->min_uV != -ENODATA && uV < uc_pdata->min_uV)
 		return -EINVAL;
@@ -95,9 +98,6 @@ int regulator_set_suspend_value(struct udevice *dev, int uV)
 	if (uV == -ENODATA)
 		return -EINVAL;
 
-	if (!ops->set_suspend_value)
-		return -ENOSYS;
-
 	return ops->set_suspend_value(dev, uV);
 }
 
@@ -105,7 +105,7 @@ int regulator_get_suspend_value(struct udevice *dev)
 {
 	const struct dm_regulator_ops *ops = dev_get_driver_ops(dev);
 
-	if (!ops->get_suspend_value)
+	if (!ops || !ops->get_suspend_value)
 		return -ENOSYS;
 
 	return ops->get_suspend_value(dev);
@@ -140,6 +140,9 @@ int regulator_set_current(struct udevice *dev, int uA)
 	const struct dm_regulator_ops *ops = dev_get_driver_ops(dev);
 	struct dm_regulator_uclass_plat *uc_pdata;
 
+	if (!ops || !ops->set_current)
+		return -ENOSYS;
+
 	uc_pdata = dev_get_uclass_plat(dev);
 	if (uc_pdata->min_uA != -ENODATA && uA < uc_pdata->min_uA)
 		return -EINVAL;
@@ -148,9 +151,6 @@ int regulator_set_current(struct udevice *dev, int uA)
 	if (uA == -ENODATA)
 		return -EINVAL;
 
-	if (!ops || !ops->set_current)
-		return -ENOSYS;
-
 	return ops->set_current(dev, uA);
 }
 
@@ -216,7 +216,7 @@ int regulator_set_suspend_enable(struct udevice *dev, bool enable)
 {
 	const struct dm_regulator_ops *ops = dev_get_driver_ops(dev);
 
-	if (!ops->set_suspend_enable)
+	if (!ops || !ops->set_suspend_enable)
 		return -ENOSYS;
 
 	return ops->set_suspend_enable(dev, enable);
@@ -226,7 +226,7 @@ int regulator_get_suspend_enable(struct udevice *dev)
 {
 	const struct dm_regulator_ops *ops = dev_get_driver_ops(dev);
 
-	if (!ops->get_suspend_enable)
+	if (!ops || !ops->get_suspend_enable)
 		return -ENOSYS;
 
 	return ops->get_suspend_enable(dev);
-- 
2.45.2

