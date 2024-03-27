Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A090C47DD9
	for <u-boot@archiver.kernel.org>; Wed, 27 Mar 2024 13:47:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 519A988064;
	Wed, 27 Mar 2024 14:47:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="IpgvvoRO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B592A8806A; Wed, 27 Mar 2024 14:46:59 +0100 (CET)
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com
 [IPv6:2607:f8b0:4864:20::12f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AF3418800C
 for <u-boot@lists.denx.de>; Wed, 27 Mar 2024 14:46:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-il1-x12f.google.com with SMTP id
 e9e14a558f8ab-3688dcc5055so1114285ab.1
 for <u-boot@lists.denx.de>; Wed, 27 Mar 2024 06:46:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1711547216; x=1712152016; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=caYABsYjJWILG2gZ1ybiMkjI26jY2j75rWqfVHueDaM=;
 b=IpgvvoRO+BKRTAQ5qUTq999nJbOKC21sZMzA7doxF8qmV7vrswW1TvnKCFoFch6yyf
 uwgZyEKOtARYHYZ1UK/hBL94UYX4ctfyx1iyqNzCo17Vm/S84JgSwBQjFowfEGkDPSJB
 1kBZzZ43KzWkNXCcjeKhGlS8PVW9LjAyXR/xZwlsDfTHIpaYnCZQvPuLgdGG61UsMZUl
 YDX59qRRycC5lzVlTriTs2cLAF8ZWPfZVxNN5fFSoJOY5tz1L0Mna3DEevj+iFkBJkP/
 07Q/h/+3V4QgeNqw9aouhvWj454k3TLgudWaZOrMdrDSfU3fS8/4wG2CzaZ0qBuoJsCw
 haGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711547216; x=1712152016;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=caYABsYjJWILG2gZ1ybiMkjI26jY2j75rWqfVHueDaM=;
 b=wrsRBAhqIJIUX13OKxR06rgih2BkC9IuSHI/Tr5FTce/RNz/GjdJnN6tZPVEAL45e6
 rIZSl+e3loolbRHr1rhzmupfV0LEhIKsHqoImr7n1/ogLV3Wu2szHoYXW5BzffYBmF5X
 Fzo97l8snChSejvyY8Z3P6c3mKRXB6K1/+xiEngvWPWGaUtXCKGRxGDOmzoApS1/0v/C
 VgoR1mUpdocRwoEmenOg/c68+gZ3pz83kwNCgvugBgfZF5G93cuCUN2pIeXi8LDBZYUT
 GN+QezPNDOYB4NK5JSe4KDTtxY3sI8zvoGs7FpIwg8N9YGgT5kFu7U/WpQogY00pEsAz
 o9mA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU3rHTcG0ewqzGBHtUY8s1auCUTWHQbCFzO9mTR2xG2SEJmhj2UIXog4ON4Ec10z9h7IvgMOzg9n8zBuospJWoMeNicqA==
X-Gm-Message-State: AOJu0YzHuNqByq2vCDm5mTweD3C7/+Y72EG6hMc0LUDL1XqlR84rDvzW
 ICbhJXRbgUmYCs88/3e+wubvKztA2U94kziD7mfTeVxXSkXHipQ7
X-Google-Smtp-Source: AGHT+IGyOwe+hTGXyk7f2eBT5KLehDCrcSOms7BfvSWK8jLRn8oHKw8gzRSM/hyneR7E0AdJwv3USA==
X-Received: by 2002:a05:6602:2578:b0:7d0:3f6b:6af9 with SMTP id
 dj24-20020a056602257800b007d03f6b6af9mr126830iob.0.1711547216402; 
 Wed, 27 Mar 2024 06:46:56 -0700 (PDT)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:bfc9:1394:a603:c344])
 by smtp.gmail.com with ESMTPSA id
 u18-20020a634712000000b005f077dce0f6sm1107855pga.31.2024.03.27.06.46.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 Mar 2024 06:46:56 -0700 (PDT)
From: Fabio Estevam <festevam@gmail.com>
To: festevam@gmail.com
Cc: trini@konsulko.com,
	u-boot@lists.denx.de,
	uboot-imx@nxp.com
Subject: [PATCH] warp7: Convert to watchdog driver model
Date: Wed, 27 Mar 2024 10:46:51 -0300
Message-Id: <20240327134651.2113527-1-festevam@gmail.com>
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
 arch/arm/dts/imx7s-warp-u-boot.dtsi | 10 ++++++++++
 configs/warp7_defconfig             |  3 +++
 2 files changed, 13 insertions(+)

diff --git a/arch/arm/dts/imx7s-warp-u-boot.dtsi b/arch/arm/dts/imx7s-warp-u-boot.dtsi
index 4f44598c9a27..98784fd7a2ef 100644
--- a/arch/arm/dts/imx7s-warp-u-boot.dtsi
+++ b/arch/arm/dts/imx7s-warp-u-boot.dtsi
@@ -7,6 +7,12 @@
 	chosen {
 		stdout-path = &uart1;
 	};
+
+	wdt-reboot {
+		compatible = "wdt-reboot";
+		wdt = <&wdog1>;
+		bootph-pre-ram;
+	};
 };
 
 &aips3 {
@@ -24,3 +30,7 @@
 &uart1 {
 	bootph-all;
 };
+
+&wdog1 {
+	bootph-pre-ram;
+};
diff --git a/configs/warp7_defconfig b/configs/warp7_defconfig
index 9b518a121be6..48042b702c22 100644
--- a/configs/warp7_defconfig
+++ b/configs/warp7_defconfig
@@ -67,6 +67,8 @@ CONFIG_DM_REGULATOR_GPIO=y
 CONFIG_SPECIFY_CONSOLE_INDEX=y
 CONFIG_DM_SERIAL=y
 CONFIG_MXC_UART=y
+CONFIG_SYSRESET=y
+CONFIG_SYSRESET_WATCHDOG=y
 CONFIG_IMX_THERMAL=y
 CONFIG_USB=y
 CONFIG_USB_EHCI_HCD=y
@@ -80,5 +82,6 @@ CONFIG_USB_GADGET_DOWNLOAD=y
 CONFIG_USB_ETHER=y
 CONFIG_USB_ETH_CDC=y
 CONFIG_USBNET_HOST_ADDR="de:ad:be:af:00:00"
+CONFIG_IMX_WATCHDOG=y
 CONFIG_OPTEE_TZDRAM_SIZE=0x3000000
 CONFIG_BOOTM_OPTEE=y
-- 
2.34.1

