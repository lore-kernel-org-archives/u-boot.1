Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC2EAC282EC
	for <u-boot@archiver.kernel.org>; Fri, 14 Mar 2025 16:03:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8B34581DED;
	Fri, 14 Mar 2025 17:02:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Ct+NQunE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4CF6D81E81; Fri, 14 Mar 2025 17:02:41 +0100 (CET)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com
 [IPv6:2a00:1450:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9423081E14
 for <u-boot@lists.denx.de>; Fri, 14 Mar 2025 17:02:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-ac2a9a74d9cso466632466b.1
 for <u-boot@lists.denx.de>; Fri, 14 Mar 2025 09:02:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741968158; x=1742572958; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1FFLPgg6zVUsd9enOm+7N6NcjtN+NvBv9jSH7YzFhoc=;
 b=Ct+NQunEEh+TS9I63YZGTqT+bMEVRhrYyXZ9WSzi2XrkImyhXrCC2vi57nQYb7PyOO
 jzTcff6tN7CyEQqV/SlZQecoG2ogtk65NBWV+bks9ldXxEa/vVwEuPzUnMjlAj5ktqRG
 /70eH0xEDwKxi5HZR3Scf3vK2HDk6Dg+1Fvek3hKlyxuWMNav7oZLLEEYFfwTh1obQyY
 H+RNFe7a1WjlMU9UkPV+gu/j8FTiERK2deOUWTbUo53UkIMiU3a4alOWBv87PiwRAAs+
 QFDOmVmrXrsL37nFCjrmjyROVc0uXpqXxIfda+EHC2yrv+hKxqbA9cC48bBevd5hmxue
 +A0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741968158; x=1742572958;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1FFLPgg6zVUsd9enOm+7N6NcjtN+NvBv9jSH7YzFhoc=;
 b=lb2wland/RctFoV5oCM9abQSZZn428HX3o2F7B4eb8m6sYi7y8FooaRSEU/zckY4gs
 Eh5VPE8QiHwTM3DXZsfduu5DO4l0zQE81+GT6jpmXOvV1hXXy5KgYhzKMwslf/t14bJy
 x+vdL8uaayvvTngL03+i2Qeu8UftrLIn27pJYmaFMe4MVk8Js61i+/s25c3AWHHXcFld
 EVZg0KIExeuaY67j7z6HrTOFy4TR9qz9+MQsWPLqAO9uYWPWqwYim9cuy3GCsyh5LzSM
 A6DY4S0v0lk+PMpIB6xOUj8FGod/BYCUTLKBk/WL+ubTGfWAaTxBBC16mhR86qUzTe3G
 O7Rg==
X-Gm-Message-State: AOJu0YzzUFbo2HTCrb1mR/hVJ/kfNiw9UhbsOYGL6Q6Jc1ZXsX4Iiq7M
 TTQ+rxGCtbnEI2VAoqui65QTeL5ViNsuv/ZoDVvrOZbRO8/kkhFh
X-Gm-Gg: ASbGncvvckZqUjm69RGRnoin/j1uLlKnxm9yhJE4pZT3F7bJ7cUsHkWUwtTXu3U8pUd
 iaoJiMMYYxGEspGIT6JhX32d86W8dgjcdTVKJNf7UjDVZY/s8UKeiXtPGKuZ2gX5tTvvhMn/M/C
 w23WO3m7FPgZvH/sriuadjM6cFwgtS4Cp3MsnMtFolUBzk24ArxT6iyjly8f8ITQ3vXP9J6FFMN
 qfnaKkIQ07bI4x71wG157hRlkcr/sT6vkG5DacNV7Elc81qvsCAZclXTHeJUT1ecIsR031oa62n
 +BYaAy9Zmt6ihYyKXUdvb86oCv7Qoru60dQT
X-Google-Smtp-Source: AGHT+IG9KcjEfKu/f5w5dAs5/yhJYZ86fYo6lcCSMf2pbkc45Kqca0XL3zhoGx1RQ/L5T6drouQ7cw==
X-Received: by 2002:a17:907:97d3:b0:ac3:271e:6b1d with SMTP id
 a640c23a62f3a-ac3303dfca8mr413343566b.51.1741968157808; 
 Fri, 14 Mar 2025 09:02:37 -0700 (PDT)
Received: from xeon.. ([188.163.112.73]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ac314a47fdcsm242953066b.146.2025.03.14.09.02.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Mar 2025 09:02:37 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Thierry Reding <treding@nvidia.com>, Svyatoslav Ryhel <clamor95@gmail.com>,
 Tom Rini <trini@konsulko.com>,
 =?UTF-8?q?Jonas=20Schw=C3=B6bel?= <jonasschwoebel@yahoo.de>,
 Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de
Subject: [PATCH v1 3/4] ARM: tegra: p1801-t: enable HDMI
Date: Fri, 14 Mar 2025 18:02:15 +0200
Message-ID: <20250314160216.36327-4-clamor95@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250314160216.36327-1-clamor95@gmail.com>
References: <20250314160216.36327-1-clamor95@gmail.com>
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

Bind HDMI for ASUS AiO P1801-t to provide full panel support and improve
usability.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 arch/arm/dts/tegra30-asus-p1801-t.dts | 12 +-----------
 configs/transformer_t30_defconfig     |  2 ++
 2 files changed, 3 insertions(+), 11 deletions(-)

diff --git a/arch/arm/dts/tegra30-asus-p1801-t.dts b/arch/arm/dts/tegra30-asus-p1801-t.dts
index 243ff2bda26..4b7b64b477b 100644
--- a/arch/arm/dts/tegra30-asus-p1801-t.dts
+++ b/arch/arm/dts/tegra30-asus-p1801-t.dts
@@ -34,20 +34,10 @@
 
 	host1x@50000000 {
 		dc@54200000 {
-			clocks = <&tegra_car TEGRA30_CLK_DISP1>,
-				 <&tegra_car TEGRA30_CLK_PLL_D_OUT0>;
-
-			rgb {
-				status = "okay";
-
-				nvidia,panel = <&hdmi>;
-			};
+			status = "disabled";
 		};
 
 		hdmi: hdmi@54280000 {
-			clocks = <&tegra_car TEGRA30_CLK_HDMI>,
-				 <&tegra_car TEGRA30_CLK_PLL_D_OUT0>;
-
 			status = "okay";
 
 			hdmi-supply = <&hdmi_5v0_sys>;
diff --git a/configs/transformer_t30_defconfig b/configs/transformer_t30_defconfig
index 9d63755533a..f5a666d8a17 100644
--- a/configs/transformer_t30_defconfig
+++ b/configs/transformer_t30_defconfig
@@ -89,6 +89,8 @@ CONFIG_USB_GADGET_VENDOR_NUM=0x0b05
 CONFIG_USB_GADGET_PRODUCT_NUM=0x4daf
 CONFIG_CI_UDC=y
 CONFIG_VIDEO=y
+CONFIG_VIDEO_BRIDGE=y
 # CONFIG_VIDEO_LOGO is not set
 CONFIG_VIDEO_BRIDGE_TOSHIBA_TC358768=y
 CONFIG_VIDEO_TEGRA20=y
+CONFIG_VIDEO_HDMI_TEGRA=y
-- 
2.43.0

