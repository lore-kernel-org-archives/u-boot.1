Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D075C5478A
	for <u-boot@archiver.kernel.org>; Wed, 21 Feb 2024 17:40:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 798E288035;
	Wed, 21 Feb 2024 18:40:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="faIP75zx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D841888053; Wed, 21 Feb 2024 18:39:58 +0100 (CET)
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com
 [IPv6:2607:f8b0:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8840787E3E
 for <u-boot@lists.denx.de>; Wed, 21 Feb 2024 18:39:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-1d7517fe9d4so3968145ad.0
 for <u-boot@lists.denx.de>; Wed, 21 Feb 2024 09:39:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1708537195; x=1709141995; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=6CJI3tJYplN2wPxHm7sqeH86/k17eVuBMZILLUId3DQ=;
 b=faIP75zxGkOEImbHWIkKm+b/vaL+ymEc7dVFRNLNlZl7EFGpyRpSEG1/qCNjcZVQjX
 9d/ic8yVwSl+Dyzgzh2lNF9OHwPfBEqp513mNBmrDeG6EtqKiSxSAeKLE6NiwuiYApH3
 OgQYrRDomv+Aava7BUCjhB/AxxD6Kn78e4UblyoiflKqK1hYnrmThuCQdNnAUB/bVOk3
 zFnj5co9l9wNleZNj8iaBdfjHzBDK9bJuZkx9BhtrJsia1nLXwTPUGqDjplK7fZqDkEQ
 kN0p5BeFYuFn0dsu422EIHHyGubYz9uCbX+9ccuO8t+OoHEZOHE9XknW9pyoWrfMvr5q
 t21A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708537195; x=1709141995;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6CJI3tJYplN2wPxHm7sqeH86/k17eVuBMZILLUId3DQ=;
 b=evGXilSuTCl3D+mc0A2whWigHKU2bY/xOhC+/nipKyU+eZnY4b4hU/dZEXK0pG+LlJ
 8+UftH8Q5yjLJIH30pyLYQ4pRjQiSewsFDsvbE+eQ82A5pV09v2aCS/hptKbeCQw8qG+
 fiohYKlsBE9z+u+ZZaN89zPYrWJpi/sXKW0eCR9W1q5j4UsUBGOtKrjXSUXSKcY2f8VB
 gHXUHHPrbNUdr/YZnhHXFC+c1BHsMhHvMTaVJxWjSSVBFlqSnX1BsD6hFnQHLxbW+cuF
 GADCS7t+DnE4MLdABJsLyHNK+u9sOsiVC+2E1Thjm6ovEHbWuFY76DYhviqJTDZ0c/k7
 vmAg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXBQAzVLr1DS/WSHqsWn3DLt/1o8zxwJ/J0I96SlUhq6B+ZW92a9F/NiW/CZNFdiODmITxXvN0K1BJaZ7rykrhJzsOHGg==
X-Gm-Message-State: AOJu0YwQgv5jDVePNmeb/Eejo9lf0k9GnwvxWvgpVHCgzerP6+R4qqbZ
 7sscWG+fH5Y90xgsfAHA88HVRRVzu8yRt3mUSgq8la43yNGAQU+/
X-Google-Smtp-Source: AGHT+IG72EjIgzzOnQfDj9EJ2sbAmh2MajkgAlHnVnFstEU8V8cePVSwdXQQrztw4tP2wB/UKSaYwA==
X-Received: by 2002:a17:902:bb81:b0:1d8:ca3a:9d2a with SMTP id
 m1-20020a170902bb8100b001d8ca3a9d2amr19220638pls.4.1708537194713; 
 Wed, 21 Feb 2024 09:39:54 -0800 (PST)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:51f5:9fec:478b:c998])
 by smtp.gmail.com with ESMTPSA id
 t17-20020a170902d29100b001db5ecb2899sm8395463plc.162.2024.02.21.09.39.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Feb 2024 09:39:54 -0800 (PST)
From: Fabio Estevam <festevam@gmail.com>
To: sbabic@denx.de
Cc: jason.hui.liu@nxp.com, u-boot@lists.denx.de,
 Fabio Estevam <festevam@gmail.com>
Subject: [PATCH] imx53-qsb: Convert to watchdog driver model
Date: Wed, 21 Feb 2024 14:39:30 -0300
Message-Id: <20240221173930.868473-1-festevam@gmail.com>
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
 arch/arm/dts/imx53-qsb-u-boot.dtsi | 14 ++++++++++++++
 configs/mx53loco_defconfig         |  3 +++
 2 files changed, 17 insertions(+)
 create mode 100644 arch/arm/dts/imx53-qsb-u-boot.dtsi

diff --git a/arch/arm/dts/imx53-qsb-u-boot.dtsi b/arch/arm/dts/imx53-qsb-u-boot.dtsi
new file mode 100644
index 000000000000..593ab7caa635
--- /dev/null
+++ b/arch/arm/dts/imx53-qsb-u-boot.dtsi
@@ -0,0 +1,14 @@
+// SPDX-License-Identifier: GPL-2.0+
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
+
diff --git a/configs/mx53loco_defconfig b/configs/mx53loco_defconfig
index d4de8df7b49d..e2d3bc0b094e 100644
--- a/configs/mx53loco_defconfig
+++ b/configs/mx53loco_defconfig
@@ -60,6 +60,8 @@ CONFIG_POWER_FSL=y
 CONFIG_POWER_I2C=y
 CONFIG_DM_SERIAL=y
 CONFIG_MXC_UART=y
+CONFIG_SYSRESET=y
+CONFIG_SYSRESET_WATCHDOG=y
 CONFIG_USB=y
 CONFIG_USB_EHCI_MX5=y
 CONFIG_USB_STORAGE=y
@@ -67,3 +69,4 @@ CONFIG_USB_HOST_ETHER=y
 CONFIG_USB_ETHER_ASIX=y
 CONFIG_USB_ETHER_MCS7830=y
 CONFIG_USB_ETHER_SMSC95XX=y
+CONFIG_IMX_WATCHDOG=y
-- 
2.34.1

