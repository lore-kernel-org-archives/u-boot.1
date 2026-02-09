Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D07FE7E0D5
	for <u-boot@archiver.kernel.org>; Mon,  9 Feb 2026 18:40:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0E55783CEE;
	Mon,  9 Feb 2026 19:40:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="L7TL6fzN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EA9A683D0F; Mon,  9 Feb 2026 19:40:00 +0100 (CET)
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com
 [IPv6:2a00:1450:4864:20::22d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F072C83CB5
 for <u-boot@lists.denx.de>; Mon,  9 Feb 2026 19:39:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-lj1-x22d.google.com with SMTP id
 38308e7fff4ca-382fb275271so33515271fa.0
 for <u-boot@lists.denx.de>; Mon, 09 Feb 2026 10:39:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1770662398; x=1771267198; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=T8i5uXrqfkCaS4B/XAe85WcE4RxFj3dJM1FTxIiEM+E=;
 b=L7TL6fzNF/rW7xq42latiwtw2vG1JDay45veL2bn3rrdyX2FrfFwsNZnVECBIuxKfz
 43Ma5NTfuiTGHcYnqqvlqOl3kiS6SOfXG4YnwgrQmveCwyBcTQIM/gRfpZFLTTjtd2Mn
 f3zq0s7B3w7xsyTnvsSYVwHEVl3cTI1FHxFXQQOCsnMBdE3PI+V+g/nI1xfpr29Qv80E
 fmXnRZ1pe7hYJksTzxhTdgm3QzMwX+Cj8oA8hzucuW8QZp5IlSRTeBqraxNQmYURSCsJ
 Lu29xHn8SnG2ItMprX5+3vJVyXRtz052Snomb/JN1equyxXtlWkJjSn8gVimWvEaeAyk
 sGMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770662398; x=1771267198;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=T8i5uXrqfkCaS4B/XAe85WcE4RxFj3dJM1FTxIiEM+E=;
 b=D9PjUYPGuI6H9ZLeNRaMUhMBCb9/mIxL4I6WNowaggRKqjlrjJIGgvgfmzl/h/v7p1
 aZNKkCkUVXSHsUvN3MAc1q1o8yQ4sCVZH0eRYlW2t88MAj07GvkvqY7zv5442N480OTQ
 srXgXIfV1d1OxmHK645wb5hO2J6Hdkg5LPlS60g9C/yOH0M9t3smOfh1g6cBxTj+Crjv
 WcHFtOQ5nxQve7sCSV3YBBvXaTuzafQBLBMOdR7hlKUkwDH8bv8PZwyy7z+mctlENdxy
 AfWlGX+sb4tvxVefIY+fafo9mGgMZ41GKaqfX3xFltOfVZkeR8mk6dgBYC7DMYfUFmBa
 7fdw==
X-Gm-Message-State: AOJu0Yxa+1MLnMXrpA1N0bksH/aT2AGlUWw4VlUXYNKiGG3G34bNoMze
 fVTAaJFhX8SlcTAGqw6XNR8BktLJlrZy+odrtwD2ebCzE+ti4hGN2t08
X-Gm-Gg: AZuq6aLmCvzjSo8qd/Q58h66K1knEw9iyj+9m9+VN1AOWH92A/RdMMkh9/vejn17jeq
 GW3t9P8msZsub/ksa+WtSBxjaN+FlcPhzcyK4YYciPQ62TAXD3VdJFRfP+qo+UHPxvCavcDCn0r
 8chKaJQm2ysVROP2FD89WG3CQIJjj+HhBgeWRVYShSgO7PUQpK14+gIeuiAk4rlshh2e8TsbMH7
 fRe8jnLhWxRLHapqy4nANUeiQ98S/Dt62gsN1EwK9V39eQqrMgyosIN/HWdHRdIGyFR6vo9tbfQ
 nHnsSxBS4MpRrnBjVwGdqNmmg8RDyct3aKblnxDVefkIz2KScjDkgcxBgdDM/6C52bq+yhgjCVp
 6Gi/XtPA1iCjpPV3wk3m4Hz4TzwYUCRpovCWyA2EjJUT7IMsyzuuU/bNKsaFXuWpZ3vS6NUkbt0
 Hf
X-Received: by 2002:a05:651c:1991:b0:386:e86c:835e with SMTP id
 38308e7fff4ca-386e86c889dmr4524461fa.14.1770662397605; 
 Mon, 09 Feb 2026 10:39:57 -0800 (PST)
Received: from xeon ([188.163.112.51]) by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-386b62363a9sm26554891fa.9.2026.02.09.10.39.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Feb 2026 10:39:56 -0800 (PST)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Tom Rini <trini@konsulko.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Peng Fan <peng.fan@nxp.com>, Svyatoslav Ryhel <clamor95@gmail.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Kever Yang <kever.yang@rock-chips.com>
Cc: u-boot@lists.denx.de
Subject: [PATCH v1 1/1] power: pmic: enable sysreset function with device tree
 property
Date: Mon,  9 Feb 2026 20:39:48 +0200
Message-ID: <20260209183948.34807-2-clamor95@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260209183948.34807-1-clamor95@gmail.com>
References: <20260209183948.34807-1-clamor95@gmail.com>
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

Add a condition to enable the PMIC sysreset function via the
system-power-controller device tree property in addition to the existing
Kconfig dependency, provided the PMIC supports it.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 drivers/power/pmic/max77663.c         | 4 +++-
 drivers/power/pmic/max8907.c          | 3 ++-
 drivers/power/pmic/palmas.c           | 4 +++-
 drivers/power/pmic/pmic_tps65910_dm.c | 4 +++-
 drivers/power/pmic/rk8xx.c            | 4 +++-
 drivers/power/pmic/tps80031.c         | 4 +++-
 6 files changed, 17 insertions(+), 6 deletions(-)

diff --git a/drivers/power/pmic/max77663.c b/drivers/power/pmic/max77663.c
index c2a7cbf7e40..a06042e2918 100644
--- a/drivers/power/pmic/max77663.c
+++ b/drivers/power/pmic/max77663.c
@@ -46,7 +46,9 @@ static int max77663_bind(struct udevice *dev)
 	ofnode regulators_node;
 	int children, ret;
 
-	if (IS_ENABLED(CONFIG_SYSRESET_MAX77663)) {
+	if (IS_ENABLED(CONFIG_SYSRESET_MAX77663) &&
+	    (dev_read_bool(dev, "maxim,system-power-controller") ||
+	     dev_read_bool(dev, "system-power-controller"))) {
 		ret = device_bind_driver_to_node(dev, MAX77663_RST_DRIVER,
 						 "sysreset", dev_ofnode(dev),
 						 NULL);
diff --git a/drivers/power/pmic/max8907.c b/drivers/power/pmic/max8907.c
index a7ef70177de..34bef0c8cd6 100644
--- a/drivers/power/pmic/max8907.c
+++ b/drivers/power/pmic/max8907.c
@@ -48,7 +48,8 @@ static int max8907_bind(struct udevice *dev)
 	int children, ret;
 
 	if (IS_ENABLED(CONFIG_SYSRESET_MAX8907) &&
-	    dev_read_bool(dev, "maxim,system-power-controller")) {
+	    (dev_read_bool(dev, "maxim,system-power-controller") ||
+	     dev_read_bool(dev, "system-power-controller"))) {
 		ret = device_bind_driver_to_node(dev, MAX8907_RST_DRIVER,
 						 "sysreset", dev_ofnode(dev),
 						 NULL);
diff --git a/drivers/power/pmic/palmas.c b/drivers/power/pmic/palmas.c
index 37d4190fabe..e5b497dfc39 100644
--- a/drivers/power/pmic/palmas.c
+++ b/drivers/power/pmic/palmas.c
@@ -48,7 +48,9 @@ static int palmas_bind(struct udevice *dev)
 	ofnode subnode, gpio_node;
 	int children, ret;
 
-	if (IS_ENABLED(CONFIG_SYSRESET_PALMAS)) {
+	if (IS_ENABLED(CONFIG_SYSRESET_PALMAS) &&
+	    (dev_read_bool(dev, "ti,system-power-controller") ||
+	     dev_read_bool(dev, "system-power-controller"))) {
 		ret = device_bind_driver_to_node(dev, PALMAS_RST_DRIVER,
 						 "sysreset", dev_ofnode(dev),
 						 NULL);
diff --git a/drivers/power/pmic/pmic_tps65910_dm.c b/drivers/power/pmic/pmic_tps65910_dm.c
index de8d805566a..bce35603275 100644
--- a/drivers/power/pmic/pmic_tps65910_dm.c
+++ b/drivers/power/pmic/pmic_tps65910_dm.c
@@ -61,7 +61,9 @@ static int pmic_tps65910_bind(struct udevice *dev)
 	ofnode regulators_node;
 	int children, ret;
 
-	if (IS_ENABLED(CONFIG_SYSRESET_TPS65910)) {
+	if (IS_ENABLED(CONFIG_SYSRESET_TPS65910) &&
+	    (dev_read_bool(dev, "ti,system-power-controller") ||
+	     dev_read_bool(dev, "system-power-controller"))) {
 		ret = device_bind_driver(dev, TPS65910_RST_DRIVER,
 					 "sysreset", NULL);
 		if (ret) {
diff --git a/drivers/power/pmic/rk8xx.c b/drivers/power/pmic/rk8xx.c
index d11f7a7886e..95b71d2fe49 100644
--- a/drivers/power/pmic/rk8xx.c
+++ b/drivers/power/pmic/rk8xx.c
@@ -220,7 +220,9 @@ static int rk8xx_bind(struct udevice *dev)
 
 	debug("%s: '%s' - found regulators subnode\n", __func__, dev->name);
 
-	if (CONFIG_IS_ENABLED(SYSRESET)) {
+	if (CONFIG_IS_ENABLED(SYSRESET) &&
+	    (dev_read_bool(dev, "rockchip,system-power-controller") ||
+	     dev_read_bool(dev, "system-power-controller"))) {
 		ret = device_bind_driver_to_node(dev, "rk8xx_sysreset",
 						 "rk8xx_sysreset",
 						 dev_ofnode(dev), NULL);
diff --git a/drivers/power/pmic/tps80031.c b/drivers/power/pmic/tps80031.c
index a2f935b0c6d..6004a14cd6c 100644
--- a/drivers/power/pmic/tps80031.c
+++ b/drivers/power/pmic/tps80031.c
@@ -46,7 +46,9 @@ static int tps80031_bind(struct udevice *dev)
 	ofnode regulators_node;
 	int children, ret;
 
-	if (IS_ENABLED(CONFIG_SYSRESET_TPS80031)) {
+	if (IS_ENABLED(CONFIG_SYSRESET_TPS80031) &&
+	    (dev_read_bool(dev, "ti,system-power-controller") ||
+	     dev_read_bool(dev, "system-power-controller"))) {
 		ret = device_bind_driver(dev, TPS80031_RST_DRIVER,
 					 "sysreset", NULL);
 		if (ret) {
-- 
2.51.0

