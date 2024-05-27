Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A9BAC25B79
	for <u-boot@archiver.kernel.org>; Mon, 27 May 2024 06:39:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6C3B888231;
	Mon, 27 May 2024 08:39:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=edgeble.ai
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=edgeble-ai.20230601.gappssmtp.com header.i=@edgeble-ai.20230601.gappssmtp.com header.b="lf4sxChb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0585788167; Mon, 27 May 2024 08:39:34 +0200 (CEST)
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com
 [IPv6:2607:f8b0:4864:20::431])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6B2968820B
 for <u-boot@lists.denx.de>; Mon, 27 May 2024 08:39:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=edgeble.ai
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=jagan@edgeble.ai
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-6fdfee2734aso1017431b3a.0
 for <u-boot@lists.denx.de>; Sun, 26 May 2024 23:39:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=edgeble-ai.20230601.gappssmtp.com; s=20230601; t=1716791970; x=1717396770;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DP2JK9ufxRkWpzKXl3le6ahk5SIXIkjeY2ia2d4GDTc=;
 b=lf4sxChb0BkulzxRGRDiWu2Mq6nR46rzhaPGWbrCuNTkkl9i3aFGm6/n55cfasrIil
 OkYeJ2y5siXSegasn0dnaZNT+3dTKwg5Dd9N/6wWg/ZUAwJoiMcWwCIWe2gbPTQMQhcQ
 aT3wS4d66XK10bOB3+dHMDod7awFcyRdPppnduSRS3ZE44yxfuEJm6RSk0aQ2f94DIoA
 kKbXI6dyz/l2Z8NkFWzJBSMvF+AjDvDr/Qk0AN3TF1MH9KfeTSsXDiCd38IAyo+uGKft
 WQnGfVV7BCaHTFUAGknjbJ97memE1lUZqgxU3qKpnL18fGUHTOFjT/x8eIQpzf19R+Xa
 4YuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716791970; x=1717396770;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DP2JK9ufxRkWpzKXl3le6ahk5SIXIkjeY2ia2d4GDTc=;
 b=oDVPcuANpDa2NWVjLHQyGd0/avSetoltn7xL5vO71wVJjnssfiyyeBqVU4SEqM+7LZ
 pIH7+roJRH02sfNDHspxiCe4O7Uo98R/1vI8/U9XO7vGlJAOsHmyfSMc6uiuVnN1n47l
 E4IfOR3Mo89Dm0gmKV4XysHrjbtLo2w9bQ3lKVMYrQvYJw59hP0NIYMPFAaJZIETCgzp
 /tupXwgwo8YRoRF75D06T8TSHohixHr/CFJVOv/wymYOAQcmKGyyCbd+0vlTPIwJqytN
 9sYGgXd2dW4qAuXwV4AkyNEWztXCLESL4cm1vmfI8mCWI/IpRlL0Hh+h19HrXhZuHQg/
 W8pg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXPUWE4sCIPDTuN07tUPmHRVmwLCJtFaIgHLKii2Wck/+bQXhznD1SfSOddHVDViPtlnz49gMuZnbYdWQybYLISLrCT7Q==
X-Gm-Message-State: AOJu0Yy7WAWBCjdaowepcr3Xrh8cpeGHkZU17MVofE42zW9w4Ll9EQNx
 R2xcMaDYflg1SReqicvuIGMyeSsRwJf2b0t20p1/eSSDjf+7fzC8v+Bo1EoPrPk=
X-Google-Smtp-Source: AGHT+IEsLWeHpWrUy/xxXvJasBXOzfN1VxUUiksC6cMuYpzLvj+qay21/FE+SNtTMAEnVKnZcnfCNQ==
X-Received: by 2002:a05:6a20:158d:b0:1af:baf9:feee with SMTP id
 adf61e73a8af0-1b212d37083mr8989982637.26.1716791969609; 
 Sun, 26 May 2024 23:39:29 -0700 (PDT)
Received: from tops-ThinkPad-E14-Gen-5.. ([103.217.239.66])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-6f8fc0599f3sm4283664b3a.53.2024.05.26.23.39.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 26 May 2024 23:39:29 -0700 (PDT)
From: Jagan Teki <jagan@edgeble.ai>
To: Kever Yang <kever.yang@rock-chips.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Simon Glass <sjg@chromium.org>,
 Jonas Karlman <jonas@kwiboo.se>
Cc: Anand Moon <anand@edgeble.ai>, u-boot@lists.denx.de,
 Jagan Teki <jagan@edgeble.ai>
Subject: [PATCH 2/2] rockchip: rk3588-edgeble: Add USB OTG support
Date: Mon, 27 May 2024 12:09:15 +0530
Message-Id: <20240527063915.6205-2-jagan@edgeble.ai>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240527063915.6205-1-jagan@edgeble.ai>
References: <20240527063915.6205-1-jagan@edgeble.ai>
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

Add support for USB OTG with UMS to program eMMC.

Add it for Edgeble NCM6A, NCM6B.

Signed-off-by: Jagan Teki <jagan@edgeble.ai>
---
 .../dts/rk3588-edgeble-neu6a-io-u-boot.dtsi    | 18 ++++++++++++++++++
 .../dts/rk3588-edgeble-neu6b-io-u-boot.dtsi    | 18 ++++++++++++++++++
 configs/neu6a-io-rk3588_defconfig              |  9 +++++++++
 configs/neu6b-io-rk3588_defconfig              |  9 +++++++++
 4 files changed, 54 insertions(+)

diff --git a/arch/arm/dts/rk3588-edgeble-neu6a-io-u-boot.dtsi b/arch/arm/dts/rk3588-edgeble-neu6a-io-u-boot.dtsi
index 88f3f7eee2..534d9f8a2c 100644
--- a/arch/arm/dts/rk3588-edgeble-neu6a-io-u-boot.dtsi
+++ b/arch/arm/dts/rk3588-edgeble-neu6a-io-u-boot.dtsi
@@ -15,3 +15,21 @@
 	bus-width = <4>;
 	status = "okay";
 };
+
+&u2phy0 {
+	status = "okay";
+};
+
+&u2phy0_otg {
+	status = "okay";
+};
+
+&usbdp_phy0 {
+	status = "okay";
+};
+
+&usb_host0_xhci {
+	dr_mode = "peripheral";
+	maximum-speed = "high-speed";
+	status = "okay";
+};
diff --git a/arch/arm/dts/rk3588-edgeble-neu6b-io-u-boot.dtsi b/arch/arm/dts/rk3588-edgeble-neu6b-io-u-boot.dtsi
index 289578803e..b3d17a60ce 100644
--- a/arch/arm/dts/rk3588-edgeble-neu6b-io-u-boot.dtsi
+++ b/arch/arm/dts/rk3588-edgeble-neu6b-io-u-boot.dtsi
@@ -15,3 +15,21 @@
 	bus-width = <4>;
 	status = "okay";
 };
+
+&u2phy0 {
+	status = "okay";
+};
+
+&u2phy0_otg {
+	status = "okay";
+};
+
+&usbdp_phy0 {
+	status = "okay";
+};
+
+&usb_host0_xhci {
+	dr_mode = "peripheral";
+	maximum-speed = "high-speed";
+	status = "okay";
+};
diff --git a/configs/neu6a-io-rk3588_defconfig b/configs/neu6a-io-rk3588_defconfig
index ac281e6539..6e50d06458 100644
--- a/configs/neu6a-io-rk3588_defconfig
+++ b/configs/neu6a-io-rk3588_defconfig
@@ -24,6 +24,7 @@ CONFIG_SPL_PAD_TO=0x7f8000
 CONFIG_SPL_ATF=y
 CONFIG_CMD_GPT=y
 CONFIG_CMD_MMC=y
+CONFIG_CMD_USB_MASS_STORAGE=y
 # CONFIG_CMD_SETEXPR is not set
 # CONFIG_SPL_DOS_PARTITION is not set
 CONFIG_SPL_OF_CONTROL=y
@@ -33,6 +34,7 @@ CONFIG_SPL_DM_SEQ_ALIAS=y
 CONFIG_SPL_REGMAP=y
 CONFIG_SPL_SYSCON=y
 CONFIG_SPL_CLK=y
+# CONFIG_USB_FUNCTION_FASTBOOT is not set
 CONFIG_ROCKCHIP_GPIO=y
 CONFIG_SYS_I2C_ROCKCHIP=y
 CONFIG_MISC=y
@@ -42,6 +44,8 @@ CONFIG_MMC_DW_ROCKCHIP=y
 CONFIG_MMC_SDHCI=y
 CONFIG_MMC_SDHCI_SDMA=y
 CONFIG_MMC_SDHCI_ROCKCHIP=y
+CONFIG_PHY_ROCKCHIP_INNO_USB2=y
+CONFIG_PHY_ROCKCHIP_USBDP=y
 CONFIG_SPL_PINCTRL=y
 CONFIG_PWM_ROCKCHIP=y
 CONFIG_SPL_RAM=y
@@ -49,4 +53,9 @@ CONFIG_BAUDRATE=1500000
 CONFIG_DEBUG_UART_SHIFT=2
 CONFIG_SYS_NS16550_MEM32=y
 CONFIG_SYSRESET=y
+CONFIG_USB=y
+CONFIG_USB_DWC3=y
+CONFIG_USB_DWC3_GENERIC=y
+CONFIG_USB_GADGET=y
+CONFIG_USB_GADGET_DOWNLOAD=y
 CONFIG_ERRNO_STR=y
diff --git a/configs/neu6b-io-rk3588_defconfig b/configs/neu6b-io-rk3588_defconfig
index c01e5fb0d0..f2eb650f19 100644
--- a/configs/neu6b-io-rk3588_defconfig
+++ b/configs/neu6b-io-rk3588_defconfig
@@ -24,6 +24,7 @@ CONFIG_SPL_PAD_TO=0x7f8000
 CONFIG_SPL_ATF=y
 CONFIG_CMD_GPT=y
 CONFIG_CMD_MMC=y
+CONFIG_CMD_USB_MASS_STORAGE=y
 # CONFIG_CMD_SETEXPR is not set
 # CONFIG_SPL_DOS_PARTITION is not set
 CONFIG_SPL_OF_CONTROL=y
@@ -33,6 +34,7 @@ CONFIG_SPL_DM_SEQ_ALIAS=y
 CONFIG_SPL_REGMAP=y
 CONFIG_SPL_SYSCON=y
 CONFIG_SPL_CLK=y
+# CONFIG_USB_FUNCTION_FASTBOOT is not set
 CONFIG_ROCKCHIP_GPIO=y
 CONFIG_SYS_I2C_ROCKCHIP=y
 CONFIG_MISC=y
@@ -42,6 +44,8 @@ CONFIG_MMC_DW_ROCKCHIP=y
 CONFIG_MMC_SDHCI=y
 CONFIG_MMC_SDHCI_SDMA=y
 CONFIG_MMC_SDHCI_ROCKCHIP=y
+CONFIG_PHY_ROCKCHIP_INNO_USB2=y
+CONFIG_PHY_ROCKCHIP_USBDP=y
 CONFIG_SPL_PINCTRL=y
 CONFIG_PWM_ROCKCHIP=y
 CONFIG_SPL_RAM=y
@@ -49,4 +53,9 @@ CONFIG_BAUDRATE=1500000
 CONFIG_DEBUG_UART_SHIFT=2
 CONFIG_SYS_NS16550_MEM32=y
 CONFIG_SYSRESET=y
+CONFIG_USB=y
+CONFIG_USB_DWC3=y
+CONFIG_USB_DWC3_GENERIC=y
+CONFIG_USB_GADGET=y
+CONFIG_USB_GADGET_DOWNLOAD=y
 CONFIG_ERRNO_STR=y
-- 
2.34.1

