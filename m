Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A16FD49773
	for <u-boot@archiver.kernel.org>; Sun,  1 Dec 2024 14:49:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 169DD8914D;
	Sun,  1 Dec 2024 15:43:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="al+3ifXi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7FF4189137; Sun,  1 Dec 2024 15:43:02 +0100 (CET)
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com
 [IPv6:2607:f8b0:4864:20::d35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F2A8189124
 for <u-boot@lists.denx.de>; Sun,  1 Dec 2024 15:42:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd35.google.com with SMTP id
 ca18e2360f4ac-843e9db3e65so109675539f.1
 for <u-boot@lists.denx.de>; Sun, 01 Dec 2024 06:42:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1733064175; x=1733668975; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aeDuaiVAnOayNdGxnyyqA4Br37CMDrOVGCFZ5dDy/V4=;
 b=al+3ifXi+gBmmaCr9ok0noDJU5GnprbuoaaXjodpgsf2DlHe69ibF4fyAF3EYnLjad
 wUpSDopA3QnIo8aXt1U9U2Vq9b9Uv8eAt7hrlmNnsLE+i6ScE+ama7ml9ClETE85Icmz
 zRk/TZlmIKV/PYJYV098pmwDuVzGeB3DQYCz4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733064175; x=1733668975;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aeDuaiVAnOayNdGxnyyqA4Br37CMDrOVGCFZ5dDy/V4=;
 b=lKkw3vpSSPADhKrODT9SXU/VLeiFIBmgvnC3a68ZoipgwX9UPMx4VVc3kcK5M3abmW
 MoBuncywske+QGSvhVR20nO+5ar9bc4m8VMG6Z9JM4/xSFafea14Ix32ziLu8yrma/2U
 Z0fUksxA5w0FvbRfS9dbCnz25naXi3x3pgDptfxZetJGSrpo2+tpLKmw8efZGZuHZJTR
 gy61dnwsJgUzGEI5C5V9iB1J1jN8y5M769515vAsFQmkFgvmcxpqM+otUsDQApSTn8JA
 9dK5CzPjxuS4JkFRGqEw/totdfoLomPzSAwAtKML8QqGegcUyelCpN5hWUaIIltvskt1
 +AKw==
X-Gm-Message-State: AOJu0YxfXIZhCfjzYUgiJcIDGsVTBlT2Yc04Biaf6bamtv0HxC4jM0Cf
 NJZu4/3UY5zD3xvDKnryFc7cogR8gZD0JVhgUv/VXmXlF/uT+6uBdym3m4WFNvNdV2PaZC2iFZA
 =
X-Gm-Gg: ASbGnctiJc8BvbpOsgcidgnYvYnsMKqlEJJmXRNvcdf84JIEPEAXsADMamTF/HqnHs9
 kYABOEJxpjldj8COSR3DTOJuHCY0vIqNW+D862Tu65WzEVS7B2LLi/WxY5x+c0Jt9LhG9E4qNIP
 vukoSvXAiCXLQ+A/BzkjaQv4pjImN9n5Mu5dNFgMgrxyzsI1jyydvv+mIC+z3Wa9KVGodbO7Fsi
 M6UxqgV5Nci20F2tU46+d/INqy/D7vcIB4Jxpgjz9Xe
X-Google-Smtp-Source: AGHT+IEfHN+BiC1A2axOkWXi1eJ3kIL3KTOJ6nOlz29dP+6yi3cVfs/BDxVASd5PDmnUblgLeUxyJA==
X-Received: by 2002:a05:6602:6d05:b0:83b:5306:d24d with SMTP id
 ca18e2360f4ac-844015352b5mr1459479039f.6.1733064174789; 
 Sun, 01 Dec 2024 06:42:54 -0800 (PST)
Received: from chromium.org ([139.60.174.4]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-84405ec8755sm160826839f.17.2024.12.01.06.42.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Dec 2024 06:42:54 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Jaehoon Chung <jh80.chung@samsung.com>, Jonas Karlman <jonas@kwiboo.se>,
 Marek Vasut <marex@denx.de>, Quentin Schulz <quentin.schulz@cherry.de>,
 Svyatoslav Ryhel <clamor95@gmail.com>
Subject: [PATCH 2/8] Revert "power: regulator: Trigger probe of regulators
 which are always-on or boot-on"
Date: Sun,  1 Dec 2024 07:42:30 -0700
Message-ID: <20241201144240.1664398-3-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241201144240.1664398-1-sjg@chromium.org>
References: <20241201144240.1664398-1-sjg@chromium.org>
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

Unfortunately this commit causes a problem on nyan-big:

   U-Boot SPL 2024.10-rc6-00632-g51c4679d2f84 (Nov 30 2024 - 13:28:40 -0700)
   Trying to boot from RAM

   U-Boot 2024.10-rc6-00632-g51c4679d2f84 (Nov 30 2024 - 13:28:40 -0700)

   SoC: tegra124
   Reset cause: POR
   Model: Acer Chromebook 13 CB5-311
   Board: Google/NVIDIA Nyan-big, ID: -2
   DRAM:  2 GiB
   failed to read ID1 register: -121
   failed to read ID: -121
   failed to read ID1 register: -121
   failed to read ID: -121
   failed to read ID1 register: -121
   failed to read ID: -121
   failed to read ID1 register: -121
   failed to read ID: -121
   failed to read ID1 register: -121
   failed to read ID: -121
   failed to read ID1 register: -121
   failed to read ID: -121
   failed to read ID1 register: -121
   failed to read ID: -121
   failed to read ID1 register: -121
   failed to read ID: -121
   failed to read ID1 register: -121
   failed to read ID: -121
   Unknown PLL id 14
   failed to read ID1 register: -121
   failed to read ID: -121
   initcall failed at call 810029c8 (err=-121: Remote I/O error)
   ### ERROR ### Please RESET the board ###

This reverts commit 51c4679d2f848e91b4a0cf867a426ffe5bb094b2.

Tweak a few tests also, so they continue to pass.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 drivers/power/regulator/regulator-uclass.c | 22 +++++++---------------
 test/dm/regulator.c                        |  6 ++++--
 2 files changed, 11 insertions(+), 17 deletions(-)

diff --git a/drivers/power/regulator/regulator-uclass.c b/drivers/power/regulator/regulator-uclass.c
index decd0802c84..3da7c09ef14 100644
--- a/drivers/power/regulator/regulator-uclass.c
+++ b/drivers/power/regulator/regulator-uclass.c
@@ -433,8 +433,6 @@ static int regulator_post_bind(struct udevice *dev)
 	const char *property = "regulator-name";
 
 	uc_pdata = dev_get_uclass_plat(dev);
-	uc_pdata->always_on = dev_read_bool(dev, "regulator-always-on");
-	uc_pdata->boot_on = dev_read_bool(dev, "regulator-boot-on");
 
 	/* Regulator's mandatory constraint */
 	uc_pdata->name = dev_read_string(dev, property);
@@ -446,21 +444,13 @@ static int regulator_post_bind(struct udevice *dev)
 			return -EINVAL;
 	}
 
-	if (!regulator_name_is_unique(dev, uc_pdata->name)) {
-		debug("'%s' of dev: '%s', has nonunique value: '%s\n",
-		      property, dev->name, uc_pdata->name);
-		return -EINVAL;
-	}
+	if (regulator_name_is_unique(dev, uc_pdata->name))
+		return 0;
 
-	/*
-	 * In case the regulator has regulator-always-on or
-	 * regulator-boot-on DT property, trigger probe() to
-	 * configure its default state during startup.
-	 */
-	if (uc_pdata->always_on || uc_pdata->boot_on)
-		dev_or_flags(dev, DM_FLAG_PROBE_AFTER_BIND);
+	debug("'%s' of dev: '%s', has nonunique value: '%s\n",
+	      property, dev->name, uc_pdata->name);
 
-	return 0;
+	return -EINVAL;
 }
 
 static int regulator_pre_probe(struct udevice *dev)
@@ -483,6 +473,8 @@ static int regulator_pre_probe(struct udevice *dev)
 						-ENODATA);
 	uc_pdata->max_uA = dev_read_u32_default(dev, "regulator-max-microamp",
 						-ENODATA);
+	uc_pdata->always_on = dev_read_bool(dev, "regulator-always-on");
+	uc_pdata->boot_on = dev_read_bool(dev, "regulator-boot-on");
 	uc_pdata->ramp_delay = dev_read_u32_default(dev, "regulator-ramp-delay",
 						    0);
 	uc_pdata->force_off = dev_read_bool(dev, "regulator-force-boot-off");
diff --git a/test/dm/regulator.c b/test/dm/regulator.c
index 449748ad52f..59cdd6a3e98 100644
--- a/test/dm/regulator.c
+++ b/test/dm/regulator.c
@@ -186,7 +186,8 @@ int dm_test_power_regulator_set_enable_if_allowed(struct unit_test_state *uts)
 
 	/* Get BUCK1 - always on regulator */
 	platname = regulator_names[BUCK1][PLATNAME];
-	ut_asserteq(-EALREADY, regulator_autoset_by_name(platname, &dev_autoset));
+	ut_asserteq(-EALREADY,
+		    regulator_autoset_by_name(platname, &dev_autoset));
 	ut_assertok(regulator_get_by_platname(platname, &dev));
 
 	/* Try disabling always-on regulator */
@@ -288,7 +289,8 @@ static int dm_test_power_regulator_autoset(struct unit_test_state *uts)
 	 * Expected output state: uV=1200000; uA=200000; output enabled
 	 */
 	platname = regulator_names[BUCK1][PLATNAME];
-	ut_asserteq(-EALREADY, regulator_autoset_by_name(platname, &dev_autoset));
+	ut_asserteq(-EALREADY,
+		    regulator_autoset_by_name(platname, &dev_autoset));
 
 	/* Check, that the returned device is proper */
 	ut_assertok(regulator_get_by_platname(platname, &dev));
-- 
2.43.0

