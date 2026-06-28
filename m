Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B17DEC43458
	for <u-boot@archiver.kernel.org>; Sun, 28 Jun 2026 10:25:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AB4F584931;
	Sun, 28 Jun 2026 12:25:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="ynrK8uqU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 12C4984975; Sun, 28 Jun 2026 12:25:42 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ABE678484C
 for <u-boot@lists.denx.de>; Sun, 28 Jun 2026 12:25:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=9abc=EY=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1782642338; bh=AwSGeJrKF2yePhZOruAvbuNd4T3E3gsl2GOvCtRiiXc=;
 b=ynrK8uqURkysaRUWLKEWEE2rzFvPcpg80eeLfeINj/xpGsp+TEf28nf79887Tmx/W4xnOoiho
 CiEWr7xlxoV0Iftk4pibr3vyoX6RkZRS/wZDumFQUTgWYHqR1jy6yB1mKW+kUCpilk/Ir2FYWt0
 5KwcbQYqwcNmyl2Oy7Bdl4Li4fukplY/3DDZM7UdPwx7k6F9XPhRep8q8hR36uM3CWIW3WY4CrM
 NalWOi7ue1+VQflU+fEUM0cV6LEPd9+QcmJso8Q+UsDmB2lmLQWgg8fD7q1QJLnq7hRoUrfa3zD
 yZRor8RyRs0KDHePpVNPNU4keVootj2GCfixL/XiWkCw==
X-Forward-Email-ID: 6a40f69e7915ab77658c86d5
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-Forward-Email-Version: 2.9.1
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Tom Rini <trini@konsulko.com>
Cc: Kaustabh Chakraborty <kauschluss@disroot.org>,
 Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de,
 Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH 1/4] power: regulator: Add helper to set voltage within an
 acceptable range
Date: Sun, 28 Jun 2026 10:25:23 +0000
Message-ID: <20260628102527.1247889-2-jonas@kwiboo.se>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260628102527.1247889-1-jonas@kwiboo.se>
References: <20260628102527.1247889-1-jonas@kwiboo.se>
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

Add regulator_set_value_clamp() that clamps a requested target voltage
to both caller-provided limits and the regulator constraints before
setting the regulator voltage value.

Return -EINVAL when the caller limits cannot be satisfied by the
regulator constraints or when the requested range is invalid.

This helper will initially be used to set vqmmc-supply voltage within an
acceptable range according to SD Standards, i.e. 1.70V-1.95V and
2.7V-3.6V.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 drivers/power/regulator/regulator-uclass.c | 27 ++++++++++++++++++++++
 include/power/regulator.h                  | 12 ++++++++++
 2 files changed, 39 insertions(+)

diff --git a/drivers/power/regulator/regulator-uclass.c b/drivers/power/regulator/regulator-uclass.c
index 1c7f75a9338c..0f5ba51ad6c2 100644
--- a/drivers/power/regulator/regulator-uclass.c
+++ b/drivers/power/regulator/regulator-uclass.c
@@ -111,6 +111,33 @@ int regulator_get_suspend_value(struct udevice *dev)
 	return ops->get_suspend_value(dev);
 }
 
+int regulator_set_value_clamp(struct udevice *dev,
+			      int min_uV, int target_uV, int max_uV)
+{
+	const struct dm_regulator_ops *ops = dev_get_driver_ops(dev);
+	struct dm_regulator_uclass_plat *uc_pdata;
+	int uV;
+
+	if (!ops || !ops->set_value)
+		return -ENOSYS;
+
+	uc_pdata = dev_get_uclass_plat(dev);
+	if (uc_pdata->min_uV != -ENODATA && max_uV < uc_pdata->min_uV)
+		return -EINVAL;
+	if (uc_pdata->max_uV != -ENODATA && min_uV > uc_pdata->max_uV)
+		return -EINVAL;
+	if (min_uV > max_uV)
+		return -EINVAL;
+
+	if (uc_pdata->min_uV != -ENODATA)
+		min_uV = max(min_uV, uc_pdata->min_uV);
+	if (uc_pdata->max_uV != -ENODATA)
+		max_uV = min(max_uV, uc_pdata->max_uV);
+	uV = clamp(target_uV, min_uV, max_uV);
+
+	return regulator_set_value(dev, uV);
+}
+
 /*
  * To be called with at most caution as there is no check
  * before setting the actual voltage value.
diff --git a/include/power/regulator.h b/include/power/regulator.h
index 4011fb1d254b..a48bb3a5a1db 100644
--- a/include/power/regulator.h
+++ b/include/power/regulator.h
@@ -315,6 +315,18 @@ int regulator_set_suspend_value(struct udevice *dev, int uV);
  */
 int regulator_get_suspend_value(struct udevice *dev);
 
+/**
+ * regulator_set_value_clamp: set clamped microvoltage value of a given regulator
+ *
+ * @dev       - pointer to the regulator device
+ * @min_uV    - the minimum output value to set [micro Volts]
+ * @target_uV - the target output value to set [micro Volts]
+ * @max_uV    - the maximum output value to set [micro Volts]
+ * Return:    - 0 on success or -errno val if fails
+ */
+int regulator_set_value_clamp(struct udevice *dev,
+			      int min_uV, int target_uV, int max_uV);
+
 /**
  * regulator_set_value_force: set the microvoltage value of a given regulator
  *			      without any min-,max condition check
-- 
2.54.0

