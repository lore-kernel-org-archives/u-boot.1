Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34684C021BF
	for <u-boot@archiver.kernel.org>; Wed, 26 Feb 2025 11:55:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8A94981101;
	Wed, 26 Feb 2025 12:54:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="fwvFo0LK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 471E4811A7; Wed, 26 Feb 2025 12:54:22 +0100 (CET)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com
 [IPv6:2a00:1450:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 486B880F3F
 for <u-boot@lists.denx.de>; Wed, 26 Feb 2025 12:54:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-aaecf50578eso1326908966b.2
 for <u-boot@lists.denx.de>; Wed, 26 Feb 2025 03:54:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1740570860; x=1741175660; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rbuEw22xQWhJ0T2OHWyGd32leSWFic6kujgCi8DscRo=;
 b=fwvFo0LKat5kquhz2+a0gOHxtPaSuvTjDIxyhnzjPSsHRszcpEb6dx9LSUbuWo8+Wc
 9ODk9P2lZybYqsDU9iMAJSzTQl51TZsGcmvr8BebyjbgZikVIwmz9KCJSwQxM9pJcqVN
 U27b83FAtKqyerxuuja9ur/2qLVeJSgi5HdwN0SuLuh7Ky3f/Lhzwod/xTKyu1vKWwhu
 uUEDG2rufxnHj9KRjJyD2OTbHFTZUURUXcAvgKBiS3CxCpskZ5MFRiBou70kiEt/4k/l
 +9J2Q0S0k1aOO68O/to6q487090vhDcJPdCYXXuBJ6yt/UbwNmzw+jTgdkJsAH1OsrJY
 UFPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740570860; x=1741175660;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rbuEw22xQWhJ0T2OHWyGd32leSWFic6kujgCi8DscRo=;
 b=D1tOw0hgrCSpsVfK0jpytLWyQJYXhY6hqi9FoWjjsVJZQEnvwQCNlTxFM4WapGujjJ
 rocBHQYSS2KalupgskCL7yhaGycHn54KMdqh8/IQ02WVzVzZr3AzroZyReWQa91sACxJ
 AjKcUoirLd4MF8BO8ytMhSDKg/BpqvCvz1SHQDzAJZ+lk8xn/8uat4Uaf2TAAggepmZc
 arV0IAtlVpb47BxMmaR7afNmiW1JgVYQDkkUpQxg2FgQJsm37l7XDCne1M4AwypFlfZM
 SeNQKyIjljY8sUO9trdRdUYYCl4rgACaIxGevn1iagQXHd4JKffh/Oa5yFHrW/T9ViAs
 PxSQ==
X-Gm-Message-State: AOJu0Yw/Tf0zaQRCQFLJRD0MYvWsPngxmp/xbIwuqV/ntKwplQ2S576x
 18zpBQqx0YBLMOM7sLjedWkbWH7SSN5z/EUxE9jOs5/7wCZn3gqsBJsnCA==
X-Gm-Gg: ASbGncvBefwBcyqB2ihSjkJUyrcJB1I7ZurUaVGySxn/53J/S661haaFrW74t0W1pnK
 TL9z/xBxhOLBEYIFJkQMcEfiDBFv7QkpOW+3SUt41No8og3sIARbIRSEXbf16dINzuhLYv7HcVF
 fbCTtzFD5ui+GSVZadNxnF2HysjQ4asTglQAl8xykLjNFNKmg2594RUxKPGi1AuV2ZWlJwK9fzv
 ICtmgSMq1SMOTry6axU2252zlsZ2/frT3plmJuWY20cl7500P1UbMLJvr7XJBzP70Ddtsm8/ISc
 qwA8QNczC5lOrocRAA==
X-Google-Smtp-Source: AGHT+IHB1BGoMTGFGXmPajAFynBmosVzrRRjrRa/hePAVl6f3+54PUhkNH1QHsPMX3S7gHeQGRBJgg==
X-Received: by 2002:a17:907:d26:b0:ab7:b7e:65c3 with SMTP id
 a640c23a62f3a-abc0d9e427emr1823387166b.17.1740570859574; 
 Wed, 26 Feb 2025 03:54:19 -0800 (PST)
Received: from xeon.. ([188.163.112.51]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-abed2055011sm308673366b.156.2025.02.26.03.54.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Feb 2025 03:54:19 -0800 (PST)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Thierry Reding <treding@nvidia.com>, Svyatoslav Ryhel <clamor95@gmail.com>,
 Tom Rini <trini@konsulko.com>, Anatolij Gustschin <agust@denx.de>,
 =?UTF-8?q?Jonas=20Schw=C3=B6bel?= <jonasschwoebel@yahoo.de>,
 Peter Robinson <pbrobinson@gmail.com>
Cc: u-boot@lists.denx.de
Subject: [PATCH v2 12/12] ARM: tegra: endeavoru: adjust panel node
Date: Wed, 26 Feb 2025 13:53:38 +0200
Message-ID: <20250226115338.42832-13-clamor95@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250226115338.42832-1-clamor95@gmail.com>
References: <20250226115338.42832-1-clamor95@gmail.com>
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

Bind panel in Linux-style, as DSI child.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 arch/arm/dts/tegra30-htc-endeavoru.dts | 23 +++++++++++------------
 1 file changed, 11 insertions(+), 12 deletions(-)

diff --git a/arch/arm/dts/tegra30-htc-endeavoru.dts b/arch/arm/dts/tegra30-htc-endeavoru.dts
index dbff795bd89..8a0ba3c07cc 100644
--- a/arch/arm/dts/tegra30-htc-endeavoru.dts
+++ b/arch/arm/dts/tegra30-htc-endeavoru.dts
@@ -48,7 +48,17 @@
 
 			avdd-dsi-csi-supply = <&avdd_dsi_csi>;
 
-			panel = <&panel>;
+			panel@0 {
+				compatible = "htc,edge-panel";
+				reg = <0>;
+
+				reset-gpios = <&gpio TEGRA_GPIO(N, 6) GPIO_ACTIVE_LOW>;
+
+				vdd-supply = <&vdd_3v3_panel>;
+				vddio-supply = <&vdd_1v8_panel>;
+
+				backlight = <&backlight>;
+			};
 		};
 	};
 
@@ -1292,17 +1302,6 @@
 		};
 	};
 
-	panel: panel {
-		compatible = "htc,edge-panel";
-
-		reset-gpios = <&gpio TEGRA_GPIO(N, 6) GPIO_ACTIVE_LOW>;
-
-		vdd-supply = <&vdd_3v3_panel>;
-		vddio-supply = <&vdd_1v8_panel>;
-
-		backlight = <&backlight>;
-	};
-
 	vcore_emmc: regulator-emmc {
 		compatible = "regulator-fixed";
 		regulator-name = "vdd_2v85_sdmmc";
-- 
2.43.0

