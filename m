Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33634F588C2
	for <u-boot@archiver.kernel.org>; Mon, 20 Apr 2026 12:55:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 43547843C4;
	Mon, 20 Apr 2026 14:54:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=ee.vjti.ac.in
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=vjti.ac.in header.i=@vjti.ac.in header.b="aEgPoId6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AEC0384258; Mon, 20 Apr 2026 13:11:58 +0200 (CEST)
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com
 [IPv6:2607:f8b0:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8813883E36
 for <u-boot@lists.denx.de>; Mon, 20 Apr 2026 13:11:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=ee.vjti.ac.in
Authentication-Results: phobos.denx.de;
 spf=none smtp.mailfrom=ssrane_b23@ee.vjti.ac.in
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-2adff872068so13183615ad.1
 for <u-boot@lists.denx.de>; Mon, 20 Apr 2026 04:11:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=vjti.ac.in; s=google; t=1776683514; x=1777288314; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YJ2raXpVI6yfdStFZxc77dqeKykJmnlSTmCyX3O+ado=;
 b=aEgPoId6Ot2bZJA2OzroEXLMoTbXz8EYYZJ26PrX1cnbI+zW8K/C7iKM2gWiSQ4muy
 l1C5wopKtZXBNRvlM0SHpHUqvF32Ozuv0uUFBU1iUi/pzbwamRnwn5fz6f0C4gO7EjAc
 fd8dJiFiu4mhrPrmitKeaXafcL6V7JcxvxWFk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776683514; x=1777288314;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=YJ2raXpVI6yfdStFZxc77dqeKykJmnlSTmCyX3O+ado=;
 b=GesuikwF/iGMSbi3q0I/L/o0C0BaLRZMwxY8Bg1ZWXkRo+pmlsTYxIi1hZFhT1Ct4A
 ycQoVRc/AF9IS4KYBDaoR+lkA9euyfNeQGEnjku5oW/2HoQChPQONhhOwyOrY/vsmYjH
 k0obANmGXU1zXw6x91p3RSVtUnROU5crk7RhiBg7zF7TErwUMlt5qFW3WhCA8GbTYHUB
 7yCfAzElURwPDLBInvzOfLcjJhIari9CbOgqeSZ3JL5dQdOwbOiYbMjW1DwuLoPnROB9
 0i3OihGhWHqeEIkubX2PvzAS76oJFUT7D7B0YnaRdKVxGr/zuqN8vn9qZFmJm8yY6mJS
 btmA==
X-Gm-Message-State: AOJu0YxGGK3NmBPfOsZ8wshGyzRUDK0GmbsVWnBelgYDF7k283gZZQax
 ffnw01KSp+Xzo1jD8WoeBfrECpcrgccTTweUvV3Vonl/Aun0Cnnu2oKFuoo9vIuV6dzN3UJv+L2
 J2kNIJfI=
X-Gm-Gg: AeBDiesETHMCjuiVcUUmj9CuVRSQ4mVW7BpqWbZ+G4uwQFGc7vNGT/41aml9NtQOX2W
 z1HgzpZJ1BxzoORiZKGGLWtALsjJZHOQZpyqlb7P6kawiwLc6jKGIL8qDrsIGzYUlzB7kPAUA5h
 FfXqOYIHn2Q4jnNKjN6UgtGW+ZBBSI8sBN3I7g/JBy/45NbUmaOIlqzzWHNDYIS20aiEcMr8X7u
 tLG4NUgc5ugYnAKEt+EoDwfbFIMhux2lNtlfHdQVoy7/7Rz4Ytz3+UfkcyGwx9/7DCQlDhgU/1T
 lTfPw8yzr2GwxWgjq06nMZ25p5mAd4ZSbtawe0SRWHT0wcNiGBUsoeU8ZA7VJmwV0t9XZ5S7W2z
 jM5VhlwrFhSW0y/bf/vvrYqDZBbRbhvwclC2195qacQ84yVkAozylq8GO4SyG15iQQFdGmDxgKM
 UXwxGM6nGBVqa3b3VhpYGl6naIIAoN0krydrQx9dhq0jiz2y2+MsvgehaNRATtTqZiqT/saIyxK
 OvvfnzrN7EdwDU/TD80lGcGLcYFQyDs
X-Received: by 2002:a17:903:17cf:b0:2b2:4d78:eec2 with SMTP id
 d9443c01a7336-2b5f9f1ab12mr132472165ad.18.1776683514573; 
 Mon, 20 Apr 2026 04:11:54 -0700 (PDT)
Received: from ranegod-HP-ENVY-x360-Convertible-13-bd0xxx.www.tendawifi.com
 ([14.139.108.62]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b5fab30f29sm98792685ad.68.2026.04.20.04.11.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Apr 2026 04:11:54 -0700 (PDT)
From: Shaurya Rane <ssrane_b23@ee.vjti.ac.in>
To: u-boot@lists.denx.de
Cc: jd@denx.de, tl@denx.de, trini@konsulko.com, sjg@chromium.org,
 Shaurya Rane <ssrane_b23@ee.vjti.ac.in>
Subject: [PATCH v2 2/2] BeaglePlay: enable IT66121 HDMI bridge and video stack
Date: Sun, 19 Apr 2026 23:05:40 +0530
Message-ID: <20260419173541.31592-3-ssrane_b23@ee.vjti.ac.in>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260419173541.31592-1-ssrane_b23@ee.vjti.ac.in>
References: <20260419173541.31592-1-ssrane_b23@ee.vjti.ac.in>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 20 Apr 2026 14:54:39 +0200
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

Bring in DTS bootph-all tags for the DSS, I2C2, HDMI bridge and
pinmux nodes, plus defconfig options for TIDSS, VIDEO_BRIDGE_ITE_IT66121,
BMP and splash screen support.

Signed-off-by: Shaurya Rane <ssrane_b23@ee.vjti.ac.in>
---
 arch/arm/dts/k3-am625-beagleplay-u-boot.dtsi | 42 ++++++++++++++++++++
 configs/am62x_beagleplay_a53_defconfig       | 13 ++++++
 2 files changed, 55 insertions(+)

diff --git a/arch/arm/dts/k3-am625-beagleplay-u-boot.dtsi b/arch/arm/dts/k3-am625-beagleplay-u-boot.dtsi
index 2a4f0e45365..b1ba62c20ad 100644
--- a/arch/arm/dts/k3-am625-beagleplay-u-boot.dtsi
+++ b/arch/arm/dts/k3-am625-beagleplay-u-boot.dtsi
@@ -322,3 +322,45 @@
 &cpsw_port2 {
 	status = "disabled";
 };
+
+/* ===== Display / HDMI support for U-Boot splash screen ===== */
+
+&main_pmx0 {
+	bootph-all;
+
+	dss0_pins_default {
+		bootph-all;
+	};
+
+	hdmi_gpio_pins_default {
+		bootph-all;
+	};
+
+	i2c2_1v8_pins_default {
+		bootph-all;
+	};
+};
+
+&dss {
+	bootph-all;
+};
+
+&dss_ports {
+	bootph-all;
+
+	port@1 {
+		bootph-all;
+	};
+};
+
+&main_i2c2 {
+	bootph-all;
+
+	bridge-hdmi@4c {
+		bootph-all;
+	};
+};
+
+&main_gpio0 {
+	bootph-all;
+};
diff --git a/configs/am62x_beagleplay_a53_defconfig b/configs/am62x_beagleplay_a53_defconfig
index c9bc7cd8d39..bb4be38537c 100644
--- a/configs/am62x_beagleplay_a53_defconfig
+++ b/configs/am62x_beagleplay_a53_defconfig
@@ -121,6 +121,19 @@ CONFIG_EXT4_WRITE=y
 CONFIG_FS_FAT_MAX_CLUSTSIZE=16384
 CONFIG_LZO=y
 CONFIG_EFI_SET_TIME=y
+CONFIG_DM_VIDEO=y
+CONFIG_VIDEO=y
+CONFIG_VIDEO_TIDSS=y
+CONFIG_VIDEO_BRIDGE=y
+CONFIG_VIDEO_BRIDGE_ITE_IT66121=y
+CONFIG_BACKLIGHT_GPIO=y
+CONFIG_SYS_WHITE_ON_BLACK=y
+CONFIG_BMP=y
+CONFIG_CMD_BMP=y
+CONFIG_SPLASH_SCREEN=y
+CONFIG_SPLASH_SCREEN_ALIGN=y
+CONFIG_VIDEO_LOGO=y
+CONFIG_I2C_EDID=y
 
 #include <configs/k3_efi_capsule.config>
 #include <configs/am62x_a53_usbdfu.config>
-- 
2.34.1

