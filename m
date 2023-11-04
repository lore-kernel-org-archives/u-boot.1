Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2774C4332F
	for <u-boot@archiver.kernel.org>; Sat,  4 Nov 2023 21:53:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EEDE387097;
	Sat,  4 Nov 2023 22:52:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="lM+ZX/rj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 94947870C7; Sat,  4 Nov 2023 22:52:53 +0100 (CET)
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com
 [IPv6:2607:f8b0:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8C5DA8708A
 for <u-boot@lists.denx.de>; Sat,  4 Nov 2023 22:52:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-ot1-x336.google.com with SMTP id
 46e09a7af769-6d3099818c0so524490a34.1
 for <u-boot@lists.denx.de>; Sat, 04 Nov 2023 14:52:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1699134769; x=1699739569; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lDW4hqeUzvulvY2Y3lkBy15M8X2CLX9z+R98Aelzcpk=;
 b=lM+ZX/rja37d9i13lGmyqocvr4MIzpS5SM+x/0Qc/JavignYj1rCQOhMe71dueAbar
 RrrupcxZbLqvpBePFcE0uHmI0DGoqUlXk6we9VQjBe3eVGL7CPCFLsgw85CRPJ6VavWP
 Lp26jwV+UtN4N7gOjHE7UaO1Uij5EwZBq4Bj3cR//AtZNZQFHJd7mrXd3jfQeyWjwfxW
 Up6t6s/VQUEuhTyRMkW2QwST5vzBJE2hGg/c8GIJsWdibYxaGDNow6+kgEpPkWHMKMbP
 chSr15UI9UTRqNFKEugVZElhlrKqN7t5AuQct9ZI25LJnyELbPGGIBg0YQ6XR962iZC4
 b/Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699134769; x=1699739569;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lDW4hqeUzvulvY2Y3lkBy15M8X2CLX9z+R98Aelzcpk=;
 b=YwhCn+wq/tCKmc4enhExk79R65fODttJui6zksJAl6B9H97fbiIplgC9lL18TVw4P5
 FSYDSFk4Qv8SgGmtjFFKiZpM2x3fWUxW4sD3blvZLYhYhgfe7jCUkw63+g+pB5P0CNWD
 Y2vWT7dDeUjSvA94OKq+s9JkAmagiNIt+fi8wPNWTwDuic4NMiTued4RnzNTkoCqs8GE
 97A7gYoj+W/8RIC726qNsKoz5Uub2hhJhdTvi6q491lgJThZW+Hh9IaGZ2kHoJZk+ZgQ
 wZV/Oo54p3Yj8uEuYt/etDE7pIhRpdQTniNX7P1hOOEIrehkWZ5UXRPUkOYJfnt7tznj
 oy8w==
X-Gm-Message-State: AOJu0Yxa/+iwke9kZHVhoSntFsKwXG4ZCikg+IvD6k4MC+UkfN50EUlq
 R8ub3PhXfovNvNruvx/RKAFplH3tiBU=
X-Google-Smtp-Source: AGHT+IHZKx89qv/8zTDOSRSkQZNALpAsxccX1/SPD/TDMniKyiXCp1QEMrVVAYjSZ9sdBzRrDMIRTg==
X-Received: by 2002:a05:6808:1a24:b0:3b2:ec6d:edcd with SMTP id
 bk36-20020a0568081a2400b003b2ec6dedcdmr28159024oib.3.1699134769212; 
 Sat, 04 Nov 2023 14:52:49 -0700 (PDT)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:b4e9:3424:1f72:d6d3])
 by smtp.gmail.com with ESMTPSA id
 o68-20020a257347000000b00da0abddeb02sm2239669ybc.34.2023.11.04.14.52.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 04 Nov 2023 14:52:48 -0700 (PDT)
From: Fabio Estevam <festevam@gmail.com>
To: sbabic@denx.de
Cc: u-boot@lists.denx.de,
	Fabio Estevam <festevam@denx.de>
Subject: [PATCH v2 2/2] pico-pi-imx6ul: Convert to watchdog driver model
Date: Sat,  4 Nov 2023 18:52:42 -0300
Message-Id: <20231104215242.310349-2-festevam@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231104215242.310349-1-festevam@gmail.com>
References: <20231104215242.310349-1-festevam@gmail.com>
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

From: Fabio Estevam <festevam@denx.de>

Commit 68dcbdd594d4 ("ARM: imx: Add weak default reset_cpu()") caused
the 'reset' command in U-Boot to not cause a board reset.
    
Fix it by switching to the watchdog driver model via sysreset, which
is the preferred method for implementing the watchdog reset.

Signed-off-by: Fabio Estevam <festevam@denx.de>
---
Changes since v1:
- Also added imx6ul-pico-pi-u-boot.dtsi which I forgot to add in v1.

 arch/arm/dts/imx6ul-pico-pi-u-boot.dtsi | 15 +++++++++++++++
 configs/pico-pi-imx6ul_defconfig        |  3 +++
 2 files changed, 18 insertions(+)
 create mode 100644 arch/arm/dts/imx6ul-pico-pi-u-boot.dtsi

diff --git a/arch/arm/dts/imx6ul-pico-pi-u-boot.dtsi b/arch/arm/dts/imx6ul-pico-pi-u-boot.dtsi
new file mode 100644
index 000000000000..95bd9c905954
--- /dev/null
+++ b/arch/arm/dts/imx6ul-pico-pi-u-boot.dtsi
@@ -0,0 +1,15 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+
+#include "imx7s-u-boot.dtsi"
+
+/ {
+	wdt-reboot {
+		compatible = "wdt-reboot";
+		wdt = <&wdog1>;
+		bootph-pre-ram;
+	};
+};
+
+&wdog1 {
+	bootph-pre-ram;
+};
diff --git a/configs/pico-pi-imx6ul_defconfig b/configs/pico-pi-imx6ul_defconfig
index 3af968d55128..604a213e1ea4 100644
--- a/configs/pico-pi-imx6ul_defconfig
+++ b/configs/pico-pi-imx6ul_defconfig
@@ -72,6 +72,8 @@ CONFIG_DM_REGULATOR_FIXED=y
 CONFIG_DM_REGULATOR_GPIO=y
 CONFIG_DM_SERIAL=y
 CONFIG_MXC_UART=y
+CONFIG_SYSRESET=y
+CONFIG_SYSRESET_WATCHDOG=y
 CONFIG_USB=y
 CONFIG_SPL_USB_HOST=y
 CONFIG_USB_MAX_CONTROLLER_COUNT=2
@@ -82,3 +84,4 @@ CONFIG_USB_GADGET_VENDOR_NUM=0x0525
 CONFIG_USB_GADGET_PRODUCT_NUM=0xa4a5
 CONFIG_CI_UDC=y
 CONFIG_SPL_USB_SDP_SUPPORT=y
+CONFIG_IMX_WATCHDOG=y
-- 
2.34.1


