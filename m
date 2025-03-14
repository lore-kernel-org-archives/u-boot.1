Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9959C35FF1
	for <u-boot@archiver.kernel.org>; Fri, 14 Mar 2025 16:02:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3D5D381E72;
	Fri, 14 Mar 2025 17:02:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="a+xrnSIw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CFFC681D25; Fri, 14 Mar 2025 17:02:39 +0100 (CET)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com
 [IPv6:2a00:1450:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CEA3A81D25
 for <u-boot@lists.denx.de>; Fri, 14 Mar 2025 17:02:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-ac2a9a74d9cso466630066b.1
 for <u-boot@lists.denx.de>; Fri, 14 Mar 2025 09:02:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741968157; x=1742572957; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2owxbhBmmYTluNo7qBo4CyMwjP3z2aGNiw2oaBOELQw=;
 b=a+xrnSIwLBEh5IH2aT02SElLLkGem6NSPqs6J4tll1yvt2rJmVvJnfS900gKxWIMnu
 7Tcu0GhTWnSI30zOfjPO/kz34eJWjI3DQ9wjEk7is4Dn+hZcHStvUTCsbNUMGhMWZNBq
 Tu/hULeOKB94E7wK4mbyQtiBVG2YJMZd7mwOUd3jZPwden44RRsT4ASthPLPlQn8jJ2m
 vJQE/jAFBAYBZfARrx79d4Tj3gxZ2EQmdIpY7QSfcIsDffrc+paYcPdD1T3+tuS2oq0k
 YxAHB5r+kYZSUnVUAtBpc+Bg0IDsXdf6QvpczvtJjwYAp8fuKDIZxUVZJPu2Z2fYkISj
 xoYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741968157; x=1742572957;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2owxbhBmmYTluNo7qBo4CyMwjP3z2aGNiw2oaBOELQw=;
 b=YQ2CixcSLI51J1wMfacN/C25fLnJyZpaiS6Fjq69pF2l2QkWE+4lhuYwV3AR0ANQIV
 F+xJdG0Evho1Gp/eie9SHsvgFAnk+wXm0e1ePifXdFyaz21xSle7HP746XMLHKT69C25
 PVHOqJaHmmQq3RqN6aNJYb/ooKkziBERHEjQqJCJdH007C2M2FrQvwkR3lXZn5PLNQjw
 F0hpeQ0m+ezuAq0OAC2RBa5Aos8kA+akgJoK5L41rS1K4pAY/Xh/vpM1pJPtSGCKgWpV
 F2x4IjAnexjCP0h0PVtCX9lMkvf8KnE8gIf8Le9EZPWn/jqO/D0974QFLzpVINQFcyC7
 fuoA==
X-Gm-Message-State: AOJu0Ywa9AimmeG8E0yyWiSHej7CEBnvdiagVRnz9mFKCkifrHwHhRF8
 Na1AIfrFJbYuCfasCULm7biLsSrSKe82x0C6EQtHTcQhlJbjTdrW
X-Gm-Gg: ASbGncv6dSRf+LWNMiZYjNkwp34FVWsrXHi2Myi8HQnwYuNWl7jOfmjeDGUDd2oUujp
 hevGKL4dfagScQj00REZNP0plBZwzIanLPkDUtAw8bMvO5gF1P6FYPJGL8K/h2W9GH2TUD/dfgB
 3TDOahLNb5eG5k/gCYBJ4Q2n23fAT4LIxjCNI5aQOFrWAqfCjyw16qSvhVmA5NyL1ijr2np7+UP
 Uk3/ZJzUhaEh2r5Wm2+H1QCkvCMJRb0lYYuaWXDcKE/2koEEZ3ZK8iDiBQGeuhAh3X7kVtIbV68
 AreWexwuaKGkYjTIuJja/3Kmf/p21E+V/Ho1
X-Google-Smtp-Source: AGHT+IE44+rZENbUq9YpK7iWlH/ur4yLgv4g43zoLBMe8b3FSB6UgfZfjMlhHJkNa3xy9400Y9GoEg==
X-Received: by 2002:a17:907:97d3:b0:ac3:271e:6b1d with SMTP id
 a640c23a62f3a-ac3303dfca8mr413332166b.51.1741968156832; 
 Fri, 14 Mar 2025 09:02:36 -0700 (PDT)
Received: from xeon.. ([188.163.112.73]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ac314a47fdcsm242953066b.146.2025.03.14.09.02.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Mar 2025 09:02:36 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Thierry Reding <treding@nvidia.com>, Svyatoslav Ryhel <clamor95@gmail.com>,
 Tom Rini <trini@konsulko.com>,
 =?UTF-8?q?Jonas=20Schw=C3=B6bel?= <jonasschwoebel@yahoo.de>,
 Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de
Subject: [PATCH v1 2/4] ARM: tegra: endeavoru: upgrade bindings
Date: Fri, 14 Mar 2025 18:02:14 +0200
Message-ID: <20250314160216.36327-3-clamor95@gmail.com>
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

Upgrade HTC One X device tree to comply possible upstream Linux device
tree. Once Linux catches up, HTC One X can be switched to OF_UPSTREAM.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 arch/arm/dts/tegra30-htc-endeavoru.dts | 17 ++++-------------
 configs/endeavoru_defconfig            |  1 +
 2 files changed, 5 insertions(+), 13 deletions(-)

diff --git a/arch/arm/dts/tegra30-htc-endeavoru.dts b/arch/arm/dts/tegra30-htc-endeavoru.dts
index 8a0ba3c07cc..db8ac457880 100644
--- a/arch/arm/dts/tegra30-htc-endeavoru.dts
+++ b/arch/arm/dts/tegra30-htc-endeavoru.dts
@@ -33,13 +33,11 @@
 
 	host1x@50000000 {
 		dc@54200000 {
-			clocks = <&tegra_car TEGRA30_CLK_DISP1>,
-				 <&tegra_car TEGRA30_CLK_PLL_D_OUT0>;
+			backlight: backlight {
+				compatible = "nvidia,tegra-pwm-backlight";
 
-			rgb {
-				status = "okay";
-
-				nvidia,panel = <&dsia>;
+				nvidia,pwm-source = <1>;
+				nvidia,default-brightness = <0x8E>;
 			};
 		};
 
@@ -1265,13 +1263,6 @@
 		nvidia,xcvr-lsrslew = <2>;
 	};
 
-	backlight: backlight {
-		compatible = "nvidia,tegra-pwm-backlight";
-
-		nvidia,pwm-source = <1>;
-		nvidia,default-brightness = <0x8E>;
-	};
-
 	/* PMIC has a built-in 32KHz oscillator which is used by PMC */
 	clk32k_in: clock-32k {
 		compatible = "fixed-clock";
diff --git a/configs/endeavoru_defconfig b/configs/endeavoru_defconfig
index cc8777e4d83..a1c11c6435f 100644
--- a/configs/endeavoru_defconfig
+++ b/configs/endeavoru_defconfig
@@ -79,6 +79,7 @@ CONFIG_USB_GADGET_VENDOR_NUM=0x0bb4
 CONFIG_USB_GADGET_PRODUCT_NUM=0x0c02
 CONFIG_CI_UDC=y
 CONFIG_VIDEO=y
+CONFIG_VIDEO_BRIDGE=y
 # CONFIG_VIDEO_LOGO is not set
 CONFIG_VIDEO_LCD_ENDEAVORU=y
 CONFIG_VIDEO_DSI_TEGRA30=y
-- 
2.43.0

