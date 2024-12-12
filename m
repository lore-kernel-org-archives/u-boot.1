Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CF35E7717F
	for <u-boot@archiver.kernel.org>; Thu, 12 Dec 2024 10:23:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 304E38030F;
	Thu, 12 Dec 2024 11:21:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="DW4tdMWz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B176880285; Thu, 12 Dec 2024 11:21:41 +0100 (CET)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BBCE780141
 for <u-boot@lists.denx.de>; Thu, 12 Dec 2024 11:21:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-aa6a3c42400so73601666b.0
 for <u-boot@lists.denx.de>; Thu, 12 Dec 2024 02:21:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1733998899; x=1734603699; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rbuEw22xQWhJ0T2OHWyGd32leSWFic6kujgCi8DscRo=;
 b=DW4tdMWzQGWVuxDY8Ny9XlEp+dQkomlbdqxbH++qfU5I/ix0AHQT6E7EhyMxyn46r8
 cLJrs4KA1nDMpmA/5s3IOBEJDUr66UGpwpvdK+lL+Lvs6qKWVIsnazqMmuecqeleQtnY
 dsEOesaDVciz3BCjnrUoIFPxBP636BXNTOUB9mt0Tu0f9VBhwS3lb+CjY0Z6j1K5tHL5
 acBKOnwnZdBJc3N7OfWDRsfgp+OqtJPM1rQmHmPCoaF1BiLxC1S7IHPChLGSRkf0CuUc
 NYGJjoBY35a8M88iMiOe1GLnsZlycwqIUzXPsENBpb0C+uiekIIdPcV9jgRyIAW8d82c
 vpVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733998899; x=1734603699;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rbuEw22xQWhJ0T2OHWyGd32leSWFic6kujgCi8DscRo=;
 b=dokYN5rHDH5PXr9WND4axNU/L9H/5KjnqM/++BdvIuWOzYWxqkTu3iWNrdK45LeL95
 3WUrfvBkNBbvSuh6PPdq4OfmQq4JM4paAhbzIfLXmH4Rlr0D27GBiouqnp5SZu2qa2RZ
 c1DrhF34a+Csoi+vT4EUYO0+4xKiF8YOMizxAlKGcApGxu40IScrCMjDyBs9KNejPR3u
 trRQps162HvXm6j7b28J/3nRr9Yi66ylBRRWnGbUBXOWcrY20uPsHtcin6UWbkpcZZ0i
 feGJMI9X0hLjFhry92wvu/A9vREhpouYaH6YvTZsvR4EVYoNOkROZD0+BrfAkDsDa+p6
 Bxiw==
X-Gm-Message-State: AOJu0Yz0XUQtZwykL0TPxb7+wT1X63f4jPr7pvQplZy8qfJwtav9AAwc
 Ilb5gltRW2Q0Dl989AhlnHxpxlV3uETFvmcSCGICiCmN4C47jamz
X-Gm-Gg: ASbGncvS2oJfkq7y/EXqfX1QkjiXzWHFX3wTcQlKBcCrSj6DApufmOmXOrfyMO4rt4N
 yPcRefTLeJRHlOYFW7DA2xZjBUI8zYCo75REyVFYSaliTX6EjG4afvRY59e0fbCRTNrwrpI0XOR
 yihP1IEFvM+Ml16jjDIAIH79geuL2Ayj4BdVa5J92teUQrGKeF7CMM7zbvLwUNiT0anTcL3EGqQ
 NJrikiz/OMG1jCh2aqjHqoColPmZIEAUJgp6Ku2qIHi5zdf
X-Google-Smtp-Source: AGHT+IHMP5WKl0FA49xna8PdV3jzMuKVCbFk+w2o6VXMt/F+L23efFXwTakokjga4RZ3NY3r4y/45A==
X-Received: by 2002:a17:906:7947:b0:aa5:b8dd:fec4 with SMTP id
 a640c23a62f3a-aa6c40bc8f9mr249185166b.4.1733998899104; 
 Thu, 12 Dec 2024 02:21:39 -0800 (PST)
Received: from xeon.. ([188.163.112.48]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aa67d6fcd3dsm646818066b.80.2024.12.12.02.21.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Dec 2024 02:21:38 -0800 (PST)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Thierry Reding <treding@nvidia.com>, Svyatoslav Ryhel <clamor95@gmail.com>,
 Tom Rini <trini@konsulko.com>, Anatolij Gustschin <agust@denx.de>,
 =?UTF-8?q?Jonas=20Schw=C3=B6bel?= <jonasschwoebel@yahoo.de>,
 Peter Robinson <pbrobinson@gmail.com>
Cc: u-boot@lists.denx.de
Subject: [PATCH v1 12/12] ARM: tegra: endeavoru: adjust panel node
Date: Thu, 12 Dec 2024 12:21:19 +0200
Message-ID: <20241212102119.6466-13-clamor95@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241212102119.6466-1-clamor95@gmail.com>
References: <20241212102119.6466-1-clamor95@gmail.com>
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

