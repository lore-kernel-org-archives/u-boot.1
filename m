Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5930E75428
	for <u-boot@archiver.kernel.org>; Tue,  3 Oct 2023 06:22:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0D2C3871F2;
	Tue,  3 Oct 2023 08:21:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="YFGr7O6d";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5976286E15; Tue,  3 Oct 2023 08:21:49 +0200 (CEST)
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com
 [IPv6:2a00:1450:4864:20::22d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 619D287165
 for <u-boot@lists.denx.de>; Tue,  3 Oct 2023 08:21:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-lj1-x22d.google.com with SMTP id
 38308e7fff4ca-2c022ce8114so5709791fa.1
 for <u-boot@lists.denx.de>; Mon, 02 Oct 2023 23:21:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1696314106; x=1696918906; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=A8eoRsoVa32XOODjgTSNQ/eetbYwjwqVJhMmxh+PprY=;
 b=YFGr7O6d+4EwHdxnAuA9t56BV4TLv4fiiRzZkTVtPUZDJYiqBWZNzeMy0qwQ8Ljzhs
 2UmB2d9lSrRTtaUJr3YJmRVTY9C+mVYuictRzCRKBL4R8+7hvQnhyhrtMO9UcXkQAleD
 OmjhqysznGLORszubA+dC3JxM7duqxEjFJ7fqD3YmgL813i//aBshUxywXNUVo4N9qBg
 trPi7UQSh6U0qJDErhdzWjSz1qt/G1TWBHgxCNP8+FNY0183F8mdYUpYhLu12qTPlQqR
 3Lb1F/m/zmzDwnB51kpLaf25CWFJVNK8VOg/LIwgIE3w9/PnRAuorkc+paGJub/39sPR
 lm5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696314106; x=1696918906;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=A8eoRsoVa32XOODjgTSNQ/eetbYwjwqVJhMmxh+PprY=;
 b=u95jbhhQNa16F82IhhGg/THcud7RvKVrzJfcd3DbQFZoQ5Dt0B8F7/bU+hnzVdNxej
 21QwvC8GjNIPJwq7w9K9zqM1c4XvVHs0b6AEBQvjZcLTfkA6neWiCIC64+PrpahITWjf
 /kTk2tibH62HCBTYMZrk2jWNDdKFVIzne8Leoyq6M+Eo0rsoepFjT2b2Fb7AvWQJLkLe
 2hnxKIuXUMjvV134HiAseUDOfxgoOgT1lK3lrKK/dyl6HA03Se4XtISHAyRM8oP6uaaq
 dCW9XJwTMgDTNyFUdtpQG6ItxRJfJFL92xBRdM3YPvSi2+toDiD5z0sHyH+yokQa5Xkh
 OLlw==
X-Gm-Message-State: AOJu0Yz2fkEJmnz1netnDSSRodOdVgXuG0RwGxsZklREwiRib19oZcjC
 m5+GqbXhlHfK8J3qsyHwjPk=
X-Google-Smtp-Source: AGHT+IGo/iSZdcLoVNNJC0Dqyl/9HzskVoVFw1iHVCky2MMUCXa8fluAQfEXV1m1X7HFrVkwZ5NjAg==
X-Received: by 2002:a2e:86d3:0:b0:2c0:2e25:5730 with SMTP id
 n19-20020a2e86d3000000b002c02e255730mr10783351ljj.5.1696314105908; 
 Mon, 02 Oct 2023 23:21:45 -0700 (PDT)
Received: from xeon.. ([188.163.112.76]) by smtp.gmail.com with ESMTPSA id
 n4-20020a2e86c4000000b002bfba0d26bcsm103594ljj.8.2023.10.02.23.21.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Oct 2023 23:21:45 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Jaehoon Chung <jh80.chung@samsung.com>, Simon Glass <sjg@chromium.org>,
 Jonas Karlman <jonas@kwiboo.se>, Svyatoslav Ryhel <clamor95@gmail.com>,
 Eugen Hristev <eugen.hristev@collabora.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 John Keeping <john@metanate.com>
Cc: u-boot@lists.denx.de
Subject: [PATCH v4 3/4] power: regulator: Perform regulator setup inside uclass
Date: Tue,  3 Oct 2023 09:21:25 +0300
Message-Id: <20231003062126.42026-4-clamor95@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231003062126.42026-1-clamor95@gmail.com>
References: <20231003062126.42026-1-clamor95@gmail.com>
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

Regulators initial setup was previously dependent on board call.
To move from this behaviour next solution is proposed: on post_bind
boot-on/always-on properties are checked, all regulators with
such props will be probed just after binding which ensures that
essential regulators are set, then in the post probe regulator
autoset is called so that correct regulator state according to
device tree is reached.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
[jonas@kwiboo.se: use autoset func, only probe with always/boot-on prop]
Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 drivers/power/regulator/regulator-uclass.c | 30 ++++++++++++++++++----
 1 file changed, 25 insertions(+), 5 deletions(-)

diff --git a/drivers/power/regulator/regulator-uclass.c b/drivers/power/regulator/regulator-uclass.c
index 4b2c6c2964..69d6d6428d 100644
--- a/drivers/power/regulator/regulator-uclass.c
+++ b/drivers/power/regulator/regulator-uclass.c
@@ -473,6 +473,7 @@ static int regulator_post_bind(struct udevice *dev)
 {
 	struct dm_regulator_uclass_plat *uc_pdata;
 	const char *property = "regulator-name";
+	int ret;
 
 	uc_pdata = dev_get_uclass_plat(dev);
 
@@ -486,13 +487,20 @@ static int regulator_post_bind(struct udevice *dev)
 			return -EINVAL;
 	}
 
-	if (regulator_name_is_unique(dev, uc_pdata->name))
-		return 0;
+	ret = regulator_name_is_unique(dev, uc_pdata->name);
+	if (!ret) {
+		debug("'%s' of dev: '%s', has nonunique value: '%s'\n",
+		      property, dev->name, uc_pdata->name);
+		return -EINVAL;
+	}
 
-	debug("'%s' of dev: '%s', has nonunique value: '%s\n",
-	      property, dev->name, uc_pdata->name);
+	uc_pdata->always_on = dev_read_bool(dev, "regulator-always-on");
+	uc_pdata->boot_on = dev_read_bool(dev, "regulator-boot-on");
 
-	return -EINVAL;
+	if (uc_pdata->always_on || uc_pdata->boot_on)
+		dev_or_flags(dev, DM_FLAG_PROBE_AFTER_BIND);
+
+	return 0;
 }
 
 static int regulator_pre_probe(struct udevice *dev)
@@ -546,6 +554,17 @@ static int regulator_pre_probe(struct udevice *dev)
 	return 0;
 }
 
+static int regulator_post_probe(struct udevice *dev)
+{
+	int ret;
+
+	ret = regulator_autoset(dev);
+	if (ret == -EMEDIUMTYPE || ret == -ENOSYS)
+		return 0;
+
+	return ret;
+}
+
 int regulators_enable_boot_on(bool verbose)
 {
 	struct udevice *dev;
@@ -603,5 +622,6 @@ UCLASS_DRIVER(regulator) = {
 	.name		= "regulator",
 	.post_bind	= regulator_post_bind,
 	.pre_probe	= regulator_pre_probe,
+	.post_probe	= regulator_post_probe,
 	.per_device_plat_auto	= sizeof(struct dm_regulator_uclass_plat),
 };
-- 
2.39.2

