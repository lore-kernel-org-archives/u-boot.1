Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 909FDC27C40
	for <u-boot@archiver.kernel.org>; Thu, 24 Aug 2023 19:28:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CC44C869C8;
	Thu, 24 Aug 2023 21:27:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="PHN781zf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 527EC869A5; Thu, 24 Aug 2023 21:26:59 +0200 (CEST)
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com
 [IPv6:2a00:1450:4864:20::12c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BB219869B7
 for <u-boot@lists.denx.de>; Thu, 24 Aug 2023 21:26:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-lf1-x12c.google.com with SMTP id
 2adb3069b0e04-5007abb15e9so247890e87.0
 for <u-boot@lists.denx.de>; Thu, 24 Aug 2023 12:26:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1692905216; x=1693510016;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mAZXWCtOXErgwteXkvnggMCEi7wnIc4O1akb4gC0G80=;
 b=PHN781zfKcE/eRUxzu8Ry/8MD9VEkHXywvzdANWh6baqqLp9IVKjg8YLlLSjM2usPH
 HZa8mms+wHXVbw1Lcfs/DsDqN2M2lqxjo9s1/aBSj+5nWJqjTGFc7asNvmTdKLxf7bJY
 /DDkIbza3VZKQXEppy4YO1Ant9eUJHCdUu6TBwnTU87bFrlSB4jpU9pW5SnVfdQGxUq3
 gGtnsGEI36WqcUhZkh8bJRe+Dwakn67jQHhm9Y3JWyQg+g7W2b7D2Wskz4NGsrW3RVNl
 wc2Ed1nFd3QDXarh+VOpq+SOLheXhnJXler/V8Gnawr9lOPQw/A0x6sGKqCqy40act9q
 mWoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692905216; x=1693510016;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mAZXWCtOXErgwteXkvnggMCEi7wnIc4O1akb4gC0G80=;
 b=EeUXjzO2aK2yut1KNn0TKLSeDyqwwpYcvWO3cUieeiEWo82cHg1XLVsYs9+cZB2xJX
 3GZCAfpEOlQGYWOWz5pdBzSm1IKTQhg0qi5d5+HV2UxSARUv0U7NpYiJauBV2sw5O6nv
 SxbF241qGcVz20Wd9FLJlO0kMX5B67VppmSUnQ+xDDrHVIMNMX9BIeN9QdmPSOYhKNK2
 t5+6XYtqy1jaLoP/Ke9xVgz4niEoRhEighiZCVIWP0CuAoo0DiUsJwFkw/EQwIUTqFxz
 Tuk9++QZ3bYFD6NuRSJR1n4Mz/cYaLJ9VtxLT8xSe4ZxiaJDmvqr6RJSlXsjkjdpc75w
 /FzA==
X-Gm-Message-State: AOJu0YyF8qHyVmB3D/gPfCVfUIJDP6EVZe6xH6XxqJMta//BaTPsdDyo
 tgJATy0syB+puZbwk1x4Sc1phiSVf8Qz2A==
X-Google-Smtp-Source: AGHT+IF/uQ775JVFAP/sTlANhEnhXSe9FrU99x1LyRXb+alidK+pot+AhLxStooR92bIONDSH96/Lw==
X-Received: by 2002:a05:6512:ea4:b0:4f8:75cf:fdd7 with SMTP id
 bi36-20020a0565120ea400b004f875cffdd7mr15053853lfb.22.1692905215788; 
 Thu, 24 Aug 2023 12:26:55 -0700 (PDT)
Received: from xeon.. ([188.163.112.52]) by smtp.gmail.com with ESMTPSA id
 be20-20020a0564021a3400b0052a1d98618bsm96033edb.54.2023.08.24.12.26.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Aug 2023 12:26:55 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Thierry Reding <treding@nvidia.com>, Svyatoslav Ryhel <clamor95@gmail.com>
Cc: u-boot@lists.denx.de
Subject: [PATCH v2 08/16] ARM: dts: endeavoru: complete missing bindings
Date: Thu, 24 Aug 2023 22:25:55 +0300
Message-Id: <20230824192603.240104-9-clamor95@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230824192603.240104-1-clamor95@gmail.com>
References: <20230824192603.240104-1-clamor95@gmail.com>
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

Clean up the tree and prepare for DM PMIC migration.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 arch/arm/dts/tegra30-htc-endeavoru.dts | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/arch/arm/dts/tegra30-htc-endeavoru.dts b/arch/arm/dts/tegra30-htc-endeavoru.dts
index c55e193d1d..5c7b2deae5 100644
--- a/arch/arm/dts/tegra30-htc-endeavoru.dts
+++ b/arch/arm/dts/tegra30-htc-endeavoru.dts
@@ -5,7 +5,6 @@
 /* CPU Speedo ID 4, Soc Speedo ID 1, CPU Process: 1, Core Process: 0 */
 
 #include <dt-bindings/input/input.h>
-
 #include "tegra30.dtsi"
 
 / {
@@ -66,13 +65,22 @@
 			compatible = "ti,tps80032";
 			reg = <0x48>;
 
+			ti,system-power-controller;
+
 			regulators {
+				vdd_1v8_vio: smps5 {
+					regulator-name = "vdd_1v8_gen";
+					regulator-min-microvolt = <1800000>;
+					regulator-max-microvolt = <1800000>;
+					regulator-always-on;
+					regulator-boot-on;
+				};
+
 				/* DSI VDD */
 				avdd_dsi_csi: ldo1 {
 					regulator-name = "avdd_dsi_csi";
 					regulator-min-microvolt = <1200000>;
 					regulator-max-microvolt = <1200000>;
-					regulator-always-on;
 				};
 			};
 		};
@@ -82,6 +90,9 @@
 		status = "okay";
 		bus-width = <8>;
 		non-removable;
+
+		vmmc-supply = <&vcore_emmc>;
+		vqmmc-supply = <&vdd_1v8_vio>;
 	};
 
 	micro_usb: usb@7d000000 {
-- 
2.39.2

