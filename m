Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2C36EBFD37
	for <u-boot@archiver.kernel.org>; Mon, 13 Apr 2026 11:06:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8D0538419E;
	Mon, 13 Apr 2026 13:06:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="RbH6efPw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0ACF98407D; Mon, 13 Apr 2026 13:06:24 +0200 (CEST)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6D632840D8
 for <u-boot@lists.denx.de>; Mon, 13 Apr 2026 13:06:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-488af96f6b2so57676465e9.0
 for <u-boot@lists.denx.de>; Mon, 13 Apr 2026 04:06:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776078379; x=1776683179; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=fEn07sIk9cXzw9wGGlw/Rg6nOAz+bx2WAbHJgltzu0U=;
 b=RbH6efPw78Q4HekvC/HOeQKmVAQS7hCr20H/HWeaNVqGp3XAycVFtEuJLFnP6ktPOe
 987qP+bX7meSnsXt3/kil3zGoOy4yaCEQZWMFRcSqE21pysXmPKGnO9hoRQq3Fjur6ph
 jnI/XvwE1JgmNyuCiMJ7nULkT/Y3gnBC9qfPC6xtdGVO4uGyMn2tA9cnFKX1cZH7idB+
 qbp9RNmmTeTnll8+1jpEpTlLhodRNeBiRYChIlUXTxc1kyQGLeVZ6ITYn3iMv0NTZax1
 V1DvHP/aToMWVgy0aPZsDNzdyYq2wcbx/W0FyY8tpFnA/OQDy/hOPBvnA747xkZZhfRi
 L3Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776078379; x=1776683179;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=fEn07sIk9cXzw9wGGlw/Rg6nOAz+bx2WAbHJgltzu0U=;
 b=q4ElAxXvi0N+yrfVcCyd0LcTvhtRUTu6tB/5e0vcYWsrIyPvLG4H1xZpJYYAs51Rea
 czCGjSpVdFwdX/o375tHI1ByVkoRDIl1jPICLB0Xiig0PF/nVWHt6SNtCw8mE6bsf7d1
 /BfqB5m3l8xHhgvT/+fnSzuqtNHFSCCYtwmY6Kb8418WuGa2NejRl3KmVt9mQ0zMZnIx
 8Ox1mg05OHa0gdt0hErMifrUQCYYRtA5omLRjHBbhApa+RnPDgz1ODDzh1spJbcLY+dw
 zgxy/5CVMYj2vC21rEPN+M979yreckjd+db3g6ucZSrAbFoftgi7zjot8uTmiT240Y79
 9lCA==
X-Forwarded-Encrypted: i=1;
 AFNElJ/1kBQjnY/T2RwIYQMJLeEPRwKDdlwpLRRDwX3QGZXkwBKh2YcjDulxpfC8ZFEL0WATuc39Hh4=@lists.denx.de
X-Gm-Message-State: AOJu0YxTB6U/ef6OcH2qQ/+e+OLYAO7IdbOfugZX2JzViMtbE4BIZDze
 7gVJbDkF1O1eOePwp1gjSH3GhkL8Gnd1+WaaGk8Uu1We1W85whLYLe9hReu5uhPCb6PNRxwdIca
 dPlDv7Yo=
X-Gm-Gg: AeBDietIJXJTA9QXlY4d/rzmrFVi+OsuUZo31Kn5zEi5uq+MAfx+s4FT8YcCqcJkLyg
 FI+9NERVV90KOz820g5VgM9DzHWmFzM+5YRo68FVJNZFXGyJNRmQYhldMSVdvO8O4mdCOYeB5Yd
 MGd6JPOYf6FPto/TWNgNWNol1vdWkkx/18w2QN2MKHQ3uPNc/d77m6C0MK5LTw2bwxyjg/tkysR
 Girt83VjQ0jA6VB7c/yU4BcpMnI+Vrf/9SROG9WRcE9HfGbcaBC5bkk6S1zIL4kaheOxLqMC/LI
 7gEWkGCIq4MwQ/iaEOkFdMf6bCjbTva/Ho3gkWWvMGX95DQAoTWIko1sRIEWxcoO/DDabELoV00
 OZFljEFp85CPvgm95DWB7AoDXus2l2zrCiFqNTxMITRgMm+ps6zEJthSFC3OnJvn6CDj9e3wMwu
 nXEt5/a2aodqswZ4H72PWStvxw31FUONGXDK8CFEyJ/04Y13zRGxKg11446X5eKlD7Ow0H
X-Received: by 2002:a05:600c:871a:b0:488:a2ac:a34a with SMTP id
 5b1f17b1804b1-488d67f4299mr189181505e9.10.1776078379462; 
 Mon, 13 Apr 2026 04:06:19 -0700 (PDT)
Received: from lion.localdomain (p4fc3dd86.dip0.t-ipconnect.de.
 [79.195.221.134]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488d5347ea5sm327284945e9.8.2026.04.13.04.06.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Apr 2026 04:06:18 -0700 (PDT)
From: Casey Connolly <casey.connolly@linaro.org>
Date: Mon, 13 Apr 2026 13:06:16 +0200
Subject: [PATCH 3/3] power: regulator: qcom-rpmh: propagate votes to parent
 supplies
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260413-casey-qcom-geni-rpmh-fixes-v1-3-2a83a67ac0f1@linaro.org>
References: <20260413-casey-qcom-geni-rpmh-fixes-v1-0-2a83a67ac0f1@linaro.org>
In-Reply-To: <20260413-casey-qcom-geni-rpmh-fixes-v1-0-2a83a67ac0f1@linaro.org>
To: Sumit Garg <sumit.garg@kernel.org>, u-boot-qcom@groups.io, 
 u-boot@lists.denx.de
Cc: Casey Connolly <casey.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini <trini@konsulko.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>, 
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>
X-Mailer: b4 0.15-dev-47773
X-Developer-Signature: v=1; a=openpgp-sha256; l=3070;
 i=casey.connolly@linaro.org; h=from:subject:message-id;
 bh=F6PqnQqZAhoZ+vDH0qEnA4aUGHOQTrFHiCA6wD+SN4o=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhsw759RzY+e//PLzlGaWWvAd1Yl/Gg/3snkwtFsZVvSWu
 T7Z+Wd5RykLgyAHg6yYIov4iWWWTWsv22tsX3ABZg4rE8gQBi5OAZjIcSaGP3xHfk37e/yV06Ei
 8QNM/VnfdmvlbH/5WEcpbt/ta2v0X/owMqy+9OPz9odR1ZuWGelVVR5dxme8bG1h0bqo7w635q5
 lzX4AAA==
X-Developer-Key: i=casey.connolly@linaro.org; a=openpgp;
 fpr=83B24DA7FE145076BC38BB250CD904EB673A7C47
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

Parse the parent supply data, fetch parent supplies and propagate
set_enable() calls to the parent regulator.

Not sure if necessary but it doesn't hurt

Signed-off-by: Casey Connolly <casey.connolly@linaro.org>
---
 drivers/power/regulator/qcom-rpmh-regulator.c | 35 +++++++++++++++++++++++++--
 1 file changed, 33 insertions(+), 2 deletions(-)

diff --git a/drivers/power/regulator/qcom-rpmh-regulator.c b/drivers/power/regulator/qcom-rpmh-regulator.c
index 3f0f18454698..de71af9b0f0d 100644
--- a/drivers/power/regulator/qcom-rpmh-regulator.c
+++ b/drivers/power/regulator/qcom-rpmh-regulator.c
@@ -159,8 +159,9 @@ struct rpmh_vreg {
 	struct udevice			*dev;
 	u32				addr;
 	const struct rpmh_vreg_hw_data	*hw_data;
 	bool				always_wait_for_ack;
+	struct udevice			*supply;
 
 	int				enabled;
 	bool				bypassed;
 	int				uv;
@@ -330,8 +331,26 @@ static int rpmh_regulator_set_enable_state(struct udevice *rdev,
 
 	debug("%s: set_enable %d (current %d)\n", rdev->name, enable,
 	      vreg->enabled);
 
+	if (vreg->enabled <= 0 && !enable)
+		return 0;
+	if (vreg->enabled >= 1 && enable) {
+		vreg->enabled++;
+		return 0;
+	}
+
+	if (vreg->supply) {
+		debug("%s: set supply %s enable state %d\n",
+		      rdev->name, vreg->supply->name, enable);
+		ret = regulator_set_enable(vreg->supply, enable);
+		if (ret < 0) {
+			debug("%s: failed to set supply %s enable state %d: %d\n",
+			      rdev->name, vreg->supply->name, enable, ret);
+			return ret;
+		}
+	}
+
 	if (vreg->enabled == -EINVAL &&
 	    vreg->uv != -ENOTRECOVERABLE) {
 		ret = _rpmh_regulator_vrm_set_value(rdev,
 						    vreg->uv, true);
@@ -339,10 +358,13 @@ static int rpmh_regulator_set_enable_state(struct udevice *rdev,
 			return ret;
 	}
 
 	ret = rpmh_regulator_send_request(vreg, &cmd, enable);
-	if (!ret)
-		vreg->enabled = enable;
+	if (!ret) {
+		if (vreg->enabled < 0)
+			vreg->enabled = 0;
+		vreg->enabled += enable ? 1 : -1;
+	}
 
 	return ret;
 }
 
@@ -837,8 +859,10 @@ static int rpmh_regulator_probe(struct udevice *dev)
 {
 	const struct rpmh_vreg_init_data *init_data;
 	struct rpmh_vreg *priv;
 	struct dm_regulator_uclass_plat *plat_data;
+	int ret;
+	char name[32] = { 0 };
 
 	init_data = (const struct rpmh_vreg_init_data *)dev_get_driver_data(dev);
 	priv = dev_get_priv(dev);
 	plat_data = dev_get_uclass_plat(dev);
@@ -849,8 +873,15 @@ static int rpmh_regulator_probe(struct udevice *dev)
 		dev_err(dev, "Failed to read RPMh address for %s\n", dev->name);
 		return -ENODEV;
 	}
 
+	strlcpy(name, init_data->supply_name, sizeof(name));
+	strlcat(name, "-supply", sizeof(name));
+	ret = device_get_supply_regulator(dev->parent, name, &priv->supply);
+	if (ret)
+		printf("Failed to get supply regulator %s for %s: %d\n",
+		       init_data->supply_name, dev->name, ret);
+
 	priv->hw_data = init_data->hw_data;
 	priv->enabled = -EINVAL;
 	priv->uv = -ENOTRECOVERABLE;
 	if (ofnode_read_u32(dev_ofnode(dev), "regulator-initial-mode", &priv->mode))

-- 
2.51.0

