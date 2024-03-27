Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DD39C47DD9
	for <u-boot@archiver.kernel.org>; Wed, 27 Mar 2024 14:19:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EE6CB880F3;
	Wed, 27 Mar 2024 15:19:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="J0LbxX0k";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 792E5880FB; Wed, 27 Mar 2024 15:19:14 +0100 (CET)
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com
 [IPv6:2607:f8b0:4864:20::433])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 62088880EB
 for <u-boot@lists.denx.de>; Wed, 27 Mar 2024 15:19:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-6e6ca65edc9so2070803b3a.0
 for <u-boot@lists.denx.de>; Wed, 27 Mar 2024 07:19:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1711549151; x=1712153951; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=UHJ8iOzSJiUhozbBsSDKVgBn2GeDMVJlqmKXHubpxdg=;
 b=J0LbxX0kxN27z3Holjktvc6Sq5XE5Q4If8dAObepwdIDsppH5wQcg8Ah5Efa84BUwn
 mw3/yXEOP/F9a/sbgZQD+zHHjNs7kaK3DeGHaY+Q1sPFVIAxRaJmTIz7D+Y4fEhVVI1q
 Rul1qjQMRGLseYS9eFlGDxmdkbBOLWwEiaN4uSb3Z+LuJqU8MCzJejNeMzQFkwxuIHaD
 0HPgI/74+gRAjCL3ag+OVPx8domylvBsmpzIEBqgnjioiPMxX7Bpa+84IhoejxziA9m3
 tTlNwL1plyhdj3ORnOROUWPu2RbbtcmGgN/M1/48fvxdM8XZbPFMttgrovzwccbwzPz6
 EoSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711549151; x=1712153951;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=UHJ8iOzSJiUhozbBsSDKVgBn2GeDMVJlqmKXHubpxdg=;
 b=qplxV+uydSYfb38OxNbGOfus8gpr2vmTEX5BQSryTreV/P8zrdn91zY07lVr9SM31M
 BWVPPiFH2IoeU7ZXle7e7B1sY4twL6hnFPvqpCvAugADA8o7lsEortI+E9XSl381CavM
 C0wAe4h/YI3L8uCdR2iXYW8VXZ0L49/Bu99z5zY6limLB1G/RTggRdU2PY7DoUccHKtj
 ixB3ScroHHCt3WFXi282S8WeVYRs/3fT1QoSjraHRP+dpcMX+msc4J9j6K5cavb1SYly
 vyS6nYVKOPtilw8jYGyPl8RFDfdpwIwXhhMh7I8Q/C6pmGYqhy1jx+zTUCxshCdlacGa
 Tp1A==
X-Forwarded-Encrypted: i=1;
 AJvYcCXl0AUF4Vj7ASnOUqLrBYjcDojJhYgzug/uLRG6bVMu9Y3KJwMR3r8ieOKELqS7likg16cjGJd7n6kRU8Et/J9u05cejw==
X-Gm-Message-State: AOJu0YxRqu+hZplLOMKpAbwJkYsXp8vuXiNuWoEa7siM26qv5VP6mo1k
 JjZCuSyW024zBlLHw482haAjdyOQkyJiJyN3L09oZeWHLgVQA8Ai
X-Google-Smtp-Source: AGHT+IHty25PcsJVtOQ27NfL0VAk+11rovjQxzgqg2Ii1bwFREeUPBRvHF8FcLXSdipQ85idnoOh8A==
X-Received: by 2002:a05:6a20:841c:b0:1a3:c3a1:b780 with SMTP id
 c28-20020a056a20841c00b001a3c3a1b780mr128315pzd.1.1711549150772; 
 Wed, 27 Mar 2024 07:19:10 -0700 (PDT)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:bfc9:1394:a603:c344])
 by smtp.gmail.com with ESMTPSA id
 p56-20020a056a0026f800b006e091a254adsm7923879pfw.30.2024.03.27.07.19.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 Mar 2024 07:19:10 -0700 (PDT)
From: Fabio Estevam <festevam@gmail.com>
To: festevam@gmail.com
Cc: baruch@tkos.co.il, trini@konsulko.com, josua@solid-run.com,
 u-boot@lists.denx.de, cgmeiner@igalia.com
Subject: [PATCH] mx6cuboxi: Convert to watchdog driver model
Date: Wed, 27 Mar 2024 11:18:49 -0300
Message-Id: <20240327141849.2126157-1-festevam@gmail.com>
X-Mailer: git-send-email 2.34.1
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

Commit 68dcbdd594d4 ("ARM: imx: Add weak default reset_cpu()") caused
the 'reset' command in U-Boot to not cause a board reset.

Fix it by switching to the watchdog driver model via sysreset, which
is the preferred method for implementing the watchdog reset.

Signed-off-by: Fabio Estevam <festevam@gmail.com>
---
Christian,

Can you test this, please?

 .../dts/imx6qdl-hummingboard2-emmc-som-v15-u-boot.dtsi | 10 ++++++++++
 configs/mx6cuboxi_defconfig                            |  3 +++
 2 files changed, 13 insertions(+)

diff --git a/arch/arm/dts/imx6qdl-hummingboard2-emmc-som-v15-u-boot.dtsi b/arch/arm/dts/imx6qdl-hummingboard2-emmc-som-v15-u-boot.dtsi
index 23a05773b579..e9b188ed6587 100644
--- a/arch/arm/dts/imx6qdl-hummingboard2-emmc-som-v15-u-boot.dtsi
+++ b/arch/arm/dts/imx6qdl-hummingboard2-emmc-som-v15-u-boot.dtsi
@@ -13,6 +13,12 @@
 			&gpio6 4 0
 		>;
 	};
+
+	wdt-reboot {
+		compatible = "wdt-reboot";
+		wdt = <&wdog1>;
+		bootph-pre-ram;
+	};
 };
 
 &soc {
@@ -58,3 +64,7 @@
 &usdhc3 {
 	bootph-all;
 };
+
+&wdog1 {
+	bootph-pre-ram;
+};
diff --git a/configs/mx6cuboxi_defconfig b/configs/mx6cuboxi_defconfig
index 66d4aaeda2d9..27ceb22599a6 100644
--- a/configs/mx6cuboxi_defconfig
+++ b/configs/mx6cuboxi_defconfig
@@ -71,6 +71,8 @@ CONFIG_DM_REGULATOR=y
 CONFIG_DM_REGULATOR_FIXED=y
 CONFIG_DM_SERIAL=y
 CONFIG_MXC_UART=y
+CONFIG_SYSRESET=y
+CONFIG_SYSRESET_WATCHDOG=y
 CONFIG_DM_THERMAL=y
 CONFIG_IMX_THERMAL=y
 CONFIG_USB=y
@@ -89,3 +91,4 @@ CONFIG_IMX_HDMI=y
 CONFIG_SPLASH_SCREEN=y
 CONFIG_SPLASH_SCREEN_ALIGN=y
 CONFIG_BMP_16BPP=y
+CONFIG_IMX_WATCHDOG=y
-- 
2.34.1

