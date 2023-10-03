Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DE8FE7542B
	for <u-boot@archiver.kernel.org>; Tue,  3 Oct 2023 06:22:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7377787208;
	Tue,  3 Oct 2023 08:21:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="nHmq1Muo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1B37886E15; Tue,  3 Oct 2023 08:21:50 +0200 (CEST)
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com
 [IPv6:2a00:1450:4864:20::22c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 328A8871BF
 for <u-boot@lists.denx.de>; Tue,  3 Oct 2023 08:21:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-lj1-x22c.google.com with SMTP id
 38308e7fff4ca-2c28e35752cso6392821fa.0
 for <u-boot@lists.denx.de>; Mon, 02 Oct 2023 23:21:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1696314107; x=1696918907; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bxLun/IMTTyxIze7X+jNwFBAftcmEXYSPcEWDswEHgg=;
 b=nHmq1MuoK0x1QMGIf1oURF7IhBbhjbhible3SZo+y7WoUkL3L1SVWmg9tgium5K2Zq
 jFpFl4PpMMX27RyFm0UZNz59pI5RkgjlQcdSpvnIyFA9QQytytNVn3Uu+cucl6Ti7TmA
 XTp1nXl6n5YVsAMf8v7P3MdTUVHlCg37ZOizWRPWTmytptdVxYkIBNS9MRVLCs5XSgAZ
 UWUQhRfYW4f8k4w3nA+Gbjztv/LgKvMfzkbq0DgtxeGK1ZkmMmd5wLdiHfACBa7B0HKG
 Fex+HcBQmdjHIENRhuPK7DKoiGHsDfaQbzthxR0nR4dtGClKkudExpZdBgzLFHumgVqS
 Rskg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696314107; x=1696918907;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bxLun/IMTTyxIze7X+jNwFBAftcmEXYSPcEWDswEHgg=;
 b=oxQ9IunM63x3qCDfoMC0N9/UAj5acHDG7waWvnkvvlDYQj9OdJN4SFpYQ9N0gumf/t
 P2LHkj2veQDgtrS1HPD30TexVbCAe9LAz96ibj34kY1oJdtqRooAJOjnCHZNTFnEQOnr
 kFlI7GZ6kvost039JGu+AMEZe1NHGDJeqdo34RHmLPZfOejeSMLiZqA8TCqLEvoBtk8o
 L00qR0PnOwemaFrHyngJQQrAuFtCDQAo/3ALDbT8RrT5rLAImy3TmWJkINBmLw0KSE1C
 v1aj529tterabEj0d8KkZETWU79YVVw8BrwwwafALGiuk4lHFRIbJ8dAC2WaBRna8uRl
 ONMg==
X-Gm-Message-State: AOJu0Yx3TLvO5rUWuxXTIgK+pPvPB0GgVpUpw9tgTb5Seko2F19uutqy
 CY4PAr1UP25CA5Eiyni3RlA=
X-Google-Smtp-Source: AGHT+IGAPZMJTXaNfz3Ag+rcRhMXNKSEHoXFrAMlegTBVj8efwUU6T2nE2mfCLW80Eaad5O6xSgTXQ==
X-Received: by 2002:a05:651c:210b:b0:2c2:9514:d68f with SMTP id
 a11-20020a05651c210b00b002c29514d68fmr7913088ljq.32.1696314107442; 
 Mon, 02 Oct 2023 23:21:47 -0700 (PDT)
Received: from xeon.. ([188.163.112.76]) by smtp.gmail.com with ESMTPSA id
 n4-20020a2e86c4000000b002bfba0d26bcsm103594ljj.8.2023.10.02.23.21.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Oct 2023 23:21:47 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Jaehoon Chung <jh80.chung@samsung.com>, Simon Glass <sjg@chromium.org>,
 Jonas Karlman <jonas@kwiboo.se>, Svyatoslav Ryhel <clamor95@gmail.com>,
 Eugen Hristev <eugen.hristev@collabora.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 John Keeping <john@metanate.com>
Cc: u-boot@lists.denx.de
Subject: [PATCH v4 4/4] test: dm: regulator: provide test of auto setup
Date: Tue,  3 Oct 2023 09:21:26 +0300
Message-Id: <20231003062126.42026-5-clamor95@gmail.com>
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

Adjust existing tests to pass with autosetup and so test
if changes behave as expected.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 test/dm/regulator.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/test/dm/regulator.c b/test/dm/regulator.c
index 33115daaf5..fbbbddbf72 100644
--- a/test/dm/regulator.c
+++ b/test/dm/regulator.c
@@ -168,7 +168,8 @@ static int dm_test_power_regulator_set_get_enable(struct unit_test_state *uts)
 	/* Set the Enable of LDO1 - default is disabled */
 	platname = regulator_names[LDO1][PLATNAME];
 	ut_assertok(regulator_get_by_platname(platname, &dev));
-	ut_assertok(regulator_set_enable(dev, val_set));
+	/* LDO1 has boot-on property so enable should return -EALREADY */
+	ut_asserteq(regulator_set_enable(dev, val_set), -EALREADY);
 
 	/* Get the Enable state of LDO1 and compare it with the requested one */
 	ut_asserteq(regulator_get_enable(dev), val_set);
@@ -187,7 +188,8 @@ int dm_test_power_regulator_set_enable_if_allowed(struct unit_test_state *uts)
 
 	/* Get BUCK1 - always on regulator */
 	platname = regulator_names[BUCK1][PLATNAME];
-	ut_assertok(regulator_autoset_by_name(platname, &dev_autoset));
+	/* BUCK1 has always-on property so autoset should return -EALREADY */
+	ut_asserteq(regulator_autoset_by_name(platname, &dev_autoset), -EALREADY);
 	ut_assertok(regulator_get_by_platname(platname, &dev));
 
 	/* Try disabling always-on regulator */
@@ -307,7 +309,8 @@ static int dm_test_power_regulator_autoset(struct unit_test_state *uts)
 	 * Expected output state: uV=1200000; uA=200000; output enabled
 	 */
 	platname = regulator_names[BUCK1][PLATNAME];
-	ut_assertok(regulator_autoset_by_name(platname, &dev_autoset));
+	/* BUCK1 has always-on property so autoset should return -EALREADY */
+	ut_asserteq(regulator_autoset_by_name(platname, &dev_autoset), -EALREADY);
 
 	/* Check, that the returned device is proper */
 	ut_assertok(regulator_get_by_platname(platname, &dev));
-- 
2.39.2

