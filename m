Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DA1EC43458
	for <u-boot@archiver.kernel.org>; Wed,  1 Jul 2026 17:58:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A358084B53;
	Wed,  1 Jul 2026 19:58:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="JeXGejpu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9726784C63; Wed,  1 Jul 2026 19:58:29 +0200 (CEST)
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com
 [IPv6:2607:f8b0:4864:20::1035])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6C96F84AE9
 for <u-boot@lists.denx.de>; Wed,  1 Jul 2026 19:58:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-37fa53bc22dso628013a91.3
 for <u-boot@lists.denx.de>; Wed, 01 Jul 2026 10:58:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782928706; x=1783533506; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jFo7+RIPY2zE/P4AfbpVI25IKo0ipfRaBmOQTZw5LAU=;
 b=JeXGejpukQaSP0d3cFcmZPR2gqpAOHnxm0xHjbCAXNXEKZ2NUh6cByc6OLVxTGD1uj
 LRopsEIZMh9UnccHvHSBozaIQ/vNEdj+iyn0G9P0hA1s+4MfCqtjZhfeRlFN7wG9SELr
 3/ee5T/yyDZ/w3rt/usJHKV3EA1TKziNgBcG/TaJEiGeYnuhqlgJ+KG/GTP/90lnhOza
 NUieYCr6kh3/4PyOUouE4cj/cTMnx8wH3vxG3hPs7uAFuCQV2AQ+7gwHhLNM8p9MSgOD
 BCi21pmDXVHtgmLtvpLV4XhCB03OJWCGp/GDAKVSbVehbSoB8GVgI1yWYazCd6ZyaJEv
 6iig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782928706; x=1783533506;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=jFo7+RIPY2zE/P4AfbpVI25IKo0ipfRaBmOQTZw5LAU=;
 b=O8oNCRjdqfMkOih9DpEX568wu7IT4zBZcANMMZItmfvbREFgzB2Z/klq9mUgQWQ2Kg
 ISVWQf7+9pUi03JcL1ExewfappH3XxdM9rFO2eWPNOVGieNN9NkhAumMY81PhZIg9dKJ
 dTyMsLccQ2CcOhk//ipuNlovitYbBA5DiDVv2VoYPfoco/p3AjKJESQXlH0dVWEKHxbM
 9eXKyfAe7fNaH4m7cGGuMtTzKt6RxW/OYofHdEY+eR9QHDf2MuNfXR9jSLPflQ4CdjFM
 9+U5U2U6omEsoKV0/lGH2Af+h3rrToJemnYvRHsq2jCVg8V3k152U6i2kYQVX14885MZ
 KaJA==
X-Forwarded-Encrypted: i=1;
 AFNElJ+XXEBi33sq98IcqAJDXKAmGYkLHKbdYSmRVAE8kYExquZh5m0Oekd6y/V+qAQSOAZfbn6/8G4=@lists.denx.de
X-Gm-Message-State: AOJu0Yw2sQhYp6HzzqYSkmM+5Z3q33OqCOFxpNS33P4WMPQDB25YCnLI
 8S5W2kRT+XCVu2rjqui22gWHTX2AAIdUAKApNYr7/LZnx68J1kAt8olqkExaDw==
X-Gm-Gg: AfdE7cmE/u3dNbbdJ0vEhBoR0J0z9yYEVlY6Q975jMK4OnMHh9ClVt4Bg0/LoHGNgc0
 XxQy/EC3ixuGmaQoBD3aqa/iMMkiAf/JaGVjnvqipucvlBjabEnfYGrccVO0GH36pxiGbppop4Z
 vhTuzpw0wffmIsVuG4z/TZMDnLMVtNCEe1rnSjtdh5NHphpQSNDEqJv7Ge0Ej25jAPVIxtky0mC
 4fN4/EyLEEefKlnl4ECObUPdCXn5ZlXhDJyUXxfKCK6opp5i3uEJrY2uXYdaLeHmuzDeQd3GpOs
 aVPPcQQNpZjRCClBSCzNf/T9Mlh0Et9tVgl/FUmqRODQnfbqBQyiAo+dYag/IAbq+pIzu3xneX0
 QzacNiT+4GvV2jqp3nqI6Z5ND7R204Lh4gjuTFbJjbzq+si6K2fm4JRi1nTAbumDEK0xcAYuQ+F
 Zi8QN++iBFLWJtcIaSYzgwvYoMQCHIs78mCVYd9QYx2SIHzyDSTQGbjC+cdeF+in79Ozh/Bw==
X-Received: by 2002:a05:6a21:e0a6:b0:3bf:7110:9949 with SMTP id
 adf61e73a8af0-3bfed1c58e3mr2970823637.6.1782928705877; 
 Wed, 01 Jul 2026 10:58:25 -0700 (PDT)
Received: from fabio-Precision-3551..
 ([2804:1b3:a800:5116:3bae:12e8:a7c9:dab9])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30f0bc27e0dsm63078eec.27.2026.07.01.10.58.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Jul 2026 10:58:24 -0700 (PDT)
From: Fabio Estevam <festevam@gmail.com>
To: kever.yang@rock-chips.com
Cc: djw@t-chip.com.cn, u-boot@lists.denx.de,
 Fabio Estevam <festevam@nabladev.com>
Subject: [PATCH v2 5/5] roc-pc-plus-rk3399: Enable USB Mass Storage support
Date: Wed,  1 Jul 2026 14:58:00 -0300
Message-ID: <20260701175800.40141-5-festevam@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260701175800.40141-1-festevam@gmail.com>
References: <20260701175800.40141-1-festevam@gmail.com>
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

From: Fabio Estevam <festevam@nabladev.com>

Configure the USB0 DWC3 controller for peripheral mode and enable the
required USB gadget options to support the U-Boot 'ums' command on the
ROC-RK3399-PC Plus.

The 'ums' command provides a convenient way to expose the on-board eMMC
as a USB Mass Storage device to a host computer, simplifying development,
image installation and recovery without requiring removable media or
network access.

Limit the controller to High-Speed operation by using the USB2 OTG PHY.

Signed-off-by: Fabio Estevam <festevam@nabladev.com>
---
Changes since v1:
- None.

 arch/arm/dts/rk3399-roc-pc-plus-u-boot.dtsi | 7 +++++++
 configs/roc-pc-plus-rk3399_defconfig        | 3 +++
 2 files changed, 10 insertions(+)

diff --git a/arch/arm/dts/rk3399-roc-pc-plus-u-boot.dtsi b/arch/arm/dts/rk3399-roc-pc-plus-u-boot.dtsi
index 7d5af3e234da..f613d75646c3 100644
--- a/arch/arm/dts/rk3399-roc-pc-plus-u-boot.dtsi
+++ b/arch/arm/dts/rk3399-roc-pc-plus-u-boot.dtsi
@@ -7,3 +7,10 @@
 &dc_12v {
 	/delete-property/ vin-supply;
 };
+
+&usbdrd_dwc3_0 {
+	dr_mode = "peripheral";
+	maximum-speed = "high-speed";
+	phys = <&u2phy0_otg>;
+	phy-names = "usb2-phy";
+};
diff --git a/configs/roc-pc-plus-rk3399_defconfig b/configs/roc-pc-plus-rk3399_defconfig
index 4ec2f7d44b5f..f3d78c53e672 100644
--- a/configs/roc-pc-plus-rk3399_defconfig
+++ b/configs/roc-pc-plus-rk3399_defconfig
@@ -2,3 +2,6 @@
 CONFIG_DEFAULT_DEVICE_TREE="rockchip/rk3399-roc-pc-plus"
 CONFIG_DEFAULT_FDT_FILE="rockchip/rk3399-roc-pc-plus.dtb"
 CONFIG_SPI_FLASH_XMC=y
+CONFIG_CMD_USB_MASS_STORAGE=y
+# CONFIG_USB_FUNCTION_FASTBOOT is not set
+CONFIG_USB_GADGET_DOWNLOAD=y
-- 
2.43.0

