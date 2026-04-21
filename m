Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5C12F8FA97
	for <u-boot@archiver.kernel.org>; Tue, 21 Apr 2026 15:12:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1482683C51;
	Tue, 21 Apr 2026 17:12:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=ee.vjti.ac.in
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=vjti.ac.in header.i=@vjti.ac.in header.b="BwLwIKYn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8B0A2840D8; Tue, 21 Apr 2026 15:21:35 +0200 (CEST)
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com
 [IPv6:2607:f8b0:4864:20::1030])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4CD3C83BC8
 for <u-boot@lists.denx.de>; Tue, 21 Apr 2026 15:21:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=ee.vjti.ac.in
Authentication-Results: phobos.denx.de;
 spf=none smtp.mailfrom=ssrane_b23@ee.vjti.ac.in
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-35e576110adso2842235a91.0
 for <u-boot@lists.denx.de>; Tue, 21 Apr 2026 06:21:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=vjti.ac.in; s=google; t=1776777691; x=1777382491; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NX3FW6IRrpKF9DWh6OKl3b6BdlavEBRnsaf+iXB+OxE=;
 b=BwLwIKYnKYdVcETUZ5Vj4XzavhI24rYNxoYR99GnNdvjfMiWgEjV/ChHzwKhTR9zSU
 L8A8DzwbkOfOBJphkhrLerFTY3ingr/5LedN6VMQQjUccCR1r53P68GbW6cVZNFMrnxW
 PJTmVyMMKKAklKVy7gJ+rr0xzarni7hb7ZU1o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776777691; x=1777382491;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=NX3FW6IRrpKF9DWh6OKl3b6BdlavEBRnsaf+iXB+OxE=;
 b=FdgKZAmYAxv6aquvA+2949DguITpUOJw86w+pxqzdljK9JUi8KYBbC2wIpkdfa0K6T
 vLj2NWz4SHcmnlDfNHDZGG0haivzJIdhTycr9x7mVKH4VeNw1bMVXJfP8ZUo9f9/sEhQ
 Qp5EFeAhE2/wCSX4cEG1VDbGLJ2pPkLxETAb8RqAaR7euQaslxMoEdW0rxqftNB7jK6n
 AxtbfZ42UJiNBhaa4Q3Sp/Uf054cZWPYhGXL9yz4d5GFhn9bIpDFZ8e6/RHjUqeCJSna
 CHX621hFgkrNogzPfnb1DPMNpH0wiW3pL2IqiaVCAUYRHZVffKz9HT7kBJylE29tvRo9
 SU5w==
X-Gm-Message-State: AOJu0YyBdUCNUZSU0uk8c3qMBhf/xCzMuIT9QhFx18AFMBDhWWJy8hPN
 ib5tIcYAfQJq1oz/kVWh1nuZK9xze4AwTtq2c/arW2nthWkXHE7pBFD1808CJUgnnM/+44Gv7Z9
 66f1/TaE=
X-Gm-Gg: AeBDietAmn+ytYyxMICxlNSrFJ+YZE03eduyyQLTBgMqhKzkqstW/dYFrsOe10p9PdQ
 qMsmAFhB/xyTj8oxX5kwOJ8tumoF+pKaPVfV8IhbUbv45M9r4Kb8OUI6m0bIxbmDkdxR8RwS92Q
 Lutdp/4XTMvnDNcntPAdYz65gh9obnbAtawbVglbMpUygQo9AeIk/PmxJf8HphWbTnzBQTiPjLS
 QZueD/7v+6Gpb9oIY54qLBvqcizK8hoTz6niCFFlc150pqaoi51MvbdAdwFRQCt8Cdk9k1zjnk6
 4jjrd8kz0fFSfROCs/ZimTluKow8o5t8Kg/6MPF3o9O4DkmHP9ztHNttUD3EV/XIpBT5tRKtqj8
 HLIwLK2ndjAy0Bdn2UqIRFWEF+VtDz3Y+w+31Snz50sjvHuXBQ7qNA7/uUlfEEE0ZbjqoJKP1Hk
 Ai+QIYiaW90i2kCusSmx9CGRIPici99mXOMwz0zrP2bieu1nMgtXZj4YBjx3N3jlt8WK0652iMr
 4Mc8MLUiswf3S8bTjlEofg9u9UyOJWb
X-Received: by 2002:a17:90b:4b83:b0:356:21e9:73ff with SMTP id
 98e67ed59e1d1-361402ebfebmr14252409a91.11.1776777690662; 
 Tue, 21 Apr 2026 06:21:30 -0700 (PDT)
Received: from ranegod-HP-ENVY-x360-Convertible-13-bd0xxx.www.tendawifi.com
 ([14.139.108.62]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3613fb42e25sm6688376a91.3.2026.04.21.06.21.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Apr 2026 06:21:30 -0700 (PDT)
From: Shaurya Rane <ssrane_b23@ee.vjti.ac.in>
To: u-boot@lists.denx.de
Cc: jd@ti.com, tl@ti.com, trini@konsulko.com, sjg@chromium.org,
 Shaurya Rane <ssrane_b23@ee.vjti.ac.in>
Subject: [PATCH v3 2/2] BeaglePlay: enable IT66121 HDMI bridge and video stack
Date: Tue, 21 Apr 2026 18:51:02 +0530
Message-ID: <20260421132103.30033-3-ssrane_b23@ee.vjti.ac.in>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260421132103.30033-1-ssrane_b23@ee.vjti.ac.in>
References: <20260421132103.30033-1-ssrane_b23@ee.vjti.ac.in>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 21 Apr 2026 17:12:16 +0200
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
Reviewed-by: Simon Glass <sjg@chromium.org>
---
Changes in v3:
 - No functional changes; carry Reviewed-by tag from Simon Glass.

Changes in v2:
 - Split out of the original patch; add bootph-all DT fragments
   alongside the defconfig options enabling TIDSS, the IT66121
   bridge driver, and splash-screen/BMP support.

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
2.43.0

