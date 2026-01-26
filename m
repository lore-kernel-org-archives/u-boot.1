Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F281FD19503
	for <u-boot@archiver.kernel.org>; Mon, 26 Jan 2026 16:15:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D902C83EBA;
	Mon, 26 Jan 2026 17:15:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="WVYmzmF5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4AC9783C04; Mon, 26 Jan 2026 17:15:19 +0100 (CET)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5326583EA9
 for <u-boot@lists.denx.de>; Mon, 26 Jan 2026 17:15:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ozndrgt@gmail.com
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-47ee07570deso36203015e9.1
 for <u-boot@lists.denx.de>; Mon, 26 Jan 2026 08:15:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1769444116; x=1770048916; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CgGW4AtWN9phi1yamTy9kXNO3StYiaZsNoQZmZPV/6Y=;
 b=WVYmzmF5szY/VU5ize2YW+JYp5F9pW0RoTHPw0E3vscKToAf/XXDelV9YpEaPragxX
 8JzZjkVyCrjOb/BwgD2Zk7Pjp7m/HdaHUviOzC6kySKDnLoO2WTuagGMYEZksPEz+hYB
 mqeVqVJvewmEF/fvXadOVZXsOWjFkn+/4tZYx5Ef9igJ7rncrHQiBc2M1FXnMNt4PzE6
 JJjnfCw1K4o4NWMtBr0mQ8Kl5TCJpLRkqrIOtVcg2OgHU9GbIYoRDRX/sh5XsEWV2Qvl
 N7NxKYbkwWf+sFS6fk8TxHnSatxcF9nutjPwkBM217MHClZ4ji5fx7O3D5GZpS4/qZ3F
 oQog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769444116; x=1770048916;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=CgGW4AtWN9phi1yamTy9kXNO3StYiaZsNoQZmZPV/6Y=;
 b=HPiPGneOEKNA7HVpkx0Ukju6ZEf8rNy2Ar5y/Ho4fNGgRzCt1yiqXSCDjlgLOdIOWh
 LFxl1JJFyyQeNIPIgQPFFyskQtTkqzg1n8KtKPUE3DZ1jaYPnS6+AAly+5DUjmakPx2k
 B4M9ir3HvGZAqgVkZSlrEXiLo+u9IeKt+8/2E09IAymk6qOPGsCVNT8pOgZrcOCzQPzG
 UNmNtKKACN15polt+egqx9NWNge6s5ymLTIdGDMDnBiQLbjrUMG67dmO5rpzZWd3xc/T
 LC7QYT4nRC7qeSJvi5AuNQqOiruyTpf8o618ZCt/ZchzOm5Qa2Qj+nOikikguJ7iDxE8
 TX1g==
X-Gm-Message-State: AOJu0YzIPlPohgS1yvE2h1IdNisTQ6bb6O4cgIjFcuyCu/6MJWkyzoFF
 ZvX50q95swJQxHbwQsAB4EpgHnCSiK2yUXCkaE2meldXgxZ699KA5gz34TnbXA==
X-Gm-Gg: AZuq6aIzNJC8aJFVt4kw2obAifroprUMHi4LmfQgGaiZBzppr0JQjhsAUUkGLMyhfVf
 q2TEGcO4Yh96p8pYV0ti4Ye4lwrTqGvJiqJSkGrlVWraBTc0hPg4tJPoz8GTaQ+qTtxfnmeKz86
 +bS4+l2neWDPzbY/EclKFHaSijVvyjsrb4JYThqRLylLv1oqzOxymIPh587VlrgrxRo3yii2r1L
 5BdJ7CrG7MA9CB7zp7v0DWX1Vt0/B/bkg45M2K05j2tNAnB7/SStN5snIl/QXPJfenU/PAXVSPZ
 v8bWuE+EU0G8SZ1tUV+vAvkn3su+Zk9ZtUDdrap8TDsqse51YdMj919X8VhzbBSdEIEAwJ2IPNz
 VNLPvCjC6VIA5TKmpyDpgZ34v2AyDyXDndpebC8uYhlHoJUYplo9gF8RtrIsW3UpYTZykKmhY5u
 A5ELsHGftiUFhXnSDkxuoYXBA=
X-Received: by 2002:a05:600c:310a:b0:477:1bb6:17e5 with SMTP id
 5b1f17b1804b1-4805cf69b43mr69945335e9.30.1769444116395; 
 Mon, 26 Jan 2026 08:15:16 -0800 (PST)
Received: from odurgut-Precision-5570..
 ([2a00:20:c361:3985:cfa:b5c2:f360:f511])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4804d5ffe12sm107368615e9.3.2026.01.26.08.15.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Jan 2026 08:15:16 -0800 (PST)
From: ozndrgt@gmail.com
To: u-boot@lists.denx.de
Cc: linux@analog.com, malysagreg@gmail.com,
 Ozan Durgut <ozan.durgut@analog.com>
Subject: [PATCH 4/5] arm: dts: adi: rename GPIO expanders
Date: Mon, 26 Jan 2026 17:15:04 +0100
Message-ID: <4418706861c3b126376cee10ef2bc74f3bff8cb0.1769439596.git.ozan.durgut@analog.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1769439596.git.ozan.durgut@analog.com>
References: <cover.1769439596.git.ozan.durgut@analog.com>
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

From: Ozan Durgut <ozan.durgut@analog.com>

The current naming convention for GPIO expanders across ADI SC5xx
device trees is inconsistent. This patch updates the node names to
correct indexing and clarify hardware location.

For SC573, SC584, and SC589 evaluation SBCs, switch to zero-based
indexing to align with standard conventions.

For SC594 and SC598 SoM + carrier evaluation kits, rename the nodes to
crr_gpio_expander. This prefix indicates which board the expander is on.

Signed-off-by: Ozan Durgut <ozan.durgut@analog.com>
---
 arch/arm/dts/sc573-ezkit.dts      | 4 ++--
 arch/arm/dts/sc584-ezkit.dts      | 4 ++--
 arch/arm/dts/sc589-ezkit.dts      | 4 ++--
 arch/arm/dts/sc594-som-ezkit.dts  | 2 +-
 arch/arm/dts/sc594-som-ezlite.dts | 2 +-
 arch/arm/dts/sc598-som-ezkit.dts  | 2 +-
 arch/arm/dts/sc598-som-ezlite.dts | 2 +-
 7 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/arch/arm/dts/sc573-ezkit.dts b/arch/arm/dts/sc573-ezkit.dts
index a848d55be62..4a3d1ed5c56 100644
--- a/arch/arm/dts/sc573-ezkit.dts
+++ b/arch/arm/dts/sc573-ezkit.dts
@@ -14,7 +14,7 @@
 };
 
 &i2c0 {
-	gpio_expander1: mcp23017@21 {
+	gpio_expander0: mcp23017@21 {
 		compatible = "microchip,mcp23017";
 		reg = <0x21>;
 		gpio-controller;
@@ -118,7 +118,7 @@
 		};
 	};
 
-	gpio_expander2: mcp23017@22 {
+	gpio_expander1: mcp23017@22 {
 		compatible = "microchip,mcp23017";
 		reg = <0x22>;
 		gpio-controller;
diff --git a/arch/arm/dts/sc584-ezkit.dts b/arch/arm/dts/sc584-ezkit.dts
index e9f4e1da383..176faa50672 100644
--- a/arch/arm/dts/sc584-ezkit.dts
+++ b/arch/arm/dts/sc584-ezkit.dts
@@ -13,7 +13,7 @@
 };
 
 &i2c2 {
-	gpio_expander1: mcp23017@21 {
+	gpio_expander0: mcp23017@21 {
 		compatible = "microchip,mcp23017";
 		reg = <0x21>;
 		gpio-controller;
@@ -125,7 +125,7 @@
 		};
 	};
 
-	gpio_expander2: mcp23017@22 {
+	gpio_expander1: mcp23017@22 {
 		compatible = "microchip,mcp23017";
 		reg = <0x22>;
 		gpio-controller;
diff --git a/arch/arm/dts/sc589-ezkit.dts b/arch/arm/dts/sc589-ezkit.dts
index 39ac7a4fd6e..d8eb5b6f8fe 100644
--- a/arch/arm/dts/sc589-ezkit.dts
+++ b/arch/arm/dts/sc589-ezkit.dts
@@ -17,7 +17,7 @@
 &i2c0 {
 	#address-cells = <1>;
 	#size-cells = <0>;
-	gpio_expander1: mcp23017@21 {
+	gpio_expander0: mcp23017@21 {
 		compatible = "microchip,mcp23017";
 		reg = <0x21>;
 		gpio-controller;
@@ -145,7 +145,7 @@
 		};
 	};
 
-	gpio_expander2: mcp23017@22 {
+	gpio_expander1: mcp23017@22 {
 		compatible = "microchip,mcp23017";
 		reg = <0x22>;
 		gpio-controller;
diff --git a/arch/arm/dts/sc594-som-ezkit.dts b/arch/arm/dts/sc594-som-ezkit.dts
index c8a01fba527..afc16df577a 100644
--- a/arch/arm/dts/sc594-som-ezkit.dts
+++ b/arch/arm/dts/sc594-som-ezkit.dts
@@ -13,7 +13,7 @@
 };
 
 &i2c2 {
-	gpio_expander2: mcp23017@22 {
+	crr_gpio_expander: mcp23017@22 {
 		compatible = "microchip,mcp23017";
 		reg = <0x22>;
 		gpio-controller;
diff --git a/arch/arm/dts/sc594-som-ezlite.dts b/arch/arm/dts/sc594-som-ezlite.dts
index 970d3b1a377..ab6f94352fc 100644
--- a/arch/arm/dts/sc594-som-ezlite.dts
+++ b/arch/arm/dts/sc594-som-ezlite.dts
@@ -13,7 +13,7 @@
 };
 
 &i2c2 {
-	gpio_expander: adp5588@30 {
+	crr_gpio_expander: adp5588@30 {
 		compatible = "adi,adp5588";
 		reg = <0x30>;
 		gpio-controller;
diff --git a/arch/arm/dts/sc598-som-ezkit.dts b/arch/arm/dts/sc598-som-ezkit.dts
index 36ea66714cb..493d2010e32 100644
--- a/arch/arm/dts/sc598-som-ezkit.dts
+++ b/arch/arm/dts/sc598-som-ezkit.dts
@@ -13,7 +13,7 @@
 };
 
 &i2c2 {
-	gpio_expander2: mcp23017@22 {
+	crr_gpio_expander: mcp23017@22 {
 		compatible = "microchip,mcp23017";
 		reg = <0x22>;
 		gpio-controller;
diff --git a/arch/arm/dts/sc598-som-ezlite.dts b/arch/arm/dts/sc598-som-ezlite.dts
index 72d336a6673..179c291f34b 100644
--- a/arch/arm/dts/sc598-som-ezlite.dts
+++ b/arch/arm/dts/sc598-som-ezlite.dts
@@ -13,7 +13,7 @@
 };
 
 &i2c2 {
-	gpio_expander: adp5588@30 {
+	crr_gpio_expander: adp5588@30 {
 		compatible = "adi,adp5588";
 		reg = <0x30>;
 		gpio-controller;
-- 
2.43.0

