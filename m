Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88D4EC25B74
	for <u-boot@archiver.kernel.org>; Mon, 27 May 2024 06:39:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E6D0788168;
	Mon, 27 May 2024 08:39:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=edgeble.ai
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=edgeble-ai.20230601.gappssmtp.com header.i=@edgeble-ai.20230601.gappssmtp.com header.b="Ynb5ZX91";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D98728816A; Mon, 27 May 2024 08:39:29 +0200 (CEST)
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com
 [IPv6:2001:4860:4864:20::36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8241D88167
 for <u-boot@lists.denx.de>; Mon, 27 May 2024 08:39:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=edgeble.ai
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=jagan@edgeble.ai
Received: by mail-oa1-x36.google.com with SMTP id
 586e51a60fabf-24ca3acb835so1100992fac.3
 for <u-boot@lists.denx.de>; Sun, 26 May 2024 23:39:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=edgeble-ai.20230601.gappssmtp.com; s=20230601; t=1716791966; x=1717396766;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=nv93Av15zBEdqWdUWJ5T1yIkKIcGnzFoza9jBVRxPTM=;
 b=Ynb5ZX91fGM5uPZHTETnfeLIkmdZX9n10gj3qPKtPpk81eLdJgn/cFSPa9VIpGkkar
 5iKswd4cuMiIIhBn85vdswkcBZnyCkO8sDW/A8hhyL+E0f5Cwt2En3KtnYVxsUuLyTBt
 HJaDDpB/MoCCXPDr3Z6xcha4eaiW3IqhMjOTMMSkc1CvzwB33ILicgfr35UtIFkvsRkE
 Q/xAxmUYWjE3+sSIQI8RpJIn47qFHPYGLlgpdXNYJzKTEXjevlb1tHgBMPA2gnz+bhRm
 pmLbViSGamWN0wle3FjHRfcTakZPXiRn27gmKCHg2UIRsJrt/YO+zhewds5q3bzFBbuP
 Gw0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716791966; x=1717396766;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=nv93Av15zBEdqWdUWJ5T1yIkKIcGnzFoza9jBVRxPTM=;
 b=NmuH7GG6fMR0JO0gIjNnBBtWSybku7jGTEimVUX45CIAi6S2xRWzQ5gLMo5mTV+Uf1
 hGmYUL8Cir73QMjPsLKngIGH9CdGLq6Rv2L41JH78SlGFXqihlsTdefoPvsrv6lMVkYr
 eW9v7jyl9/jICeHXj4XYMLBQFgTwWTAjqTGcWaL2zSPUNdgc6//zFI6QT7Q+UUyRbpf9
 LsX7rx/pOvga6tTSADONX25c6LVaKOr+0zWTXGP5iEqMlDfo4mh9K25oe6ycquM2RMWc
 onVPHc8qNg2rhile5X0K7iVGjYimVyMt2/DCz3hJS3Py+G5QYIq/JfmxQNH5JZJz9CGs
 afdA==
X-Forwarded-Encrypted: i=1;
 AJvYcCV3UWAkX+8hLCuO5Il7E0QzLOZ+/9s5u3EnFROxsCnSmSnfO/MSlEW1Z2TA7RBDslbJoXBgPN0ba3c4p/cbhATmezW7Fg==
X-Gm-Message-State: AOJu0Ywn5Fw2in0ez4Q/mjs9cGNcSG4nuSzErNTWt/x2ckb8gWa9dRtv
 izvUkC8oM4ke4UtIj1n+/V1jIb7qEMUHmFJx6T61pGbEV+Op+0X3THSl6EwE5wA=
X-Google-Smtp-Source: AGHT+IH93YNs5LfpW6Tn3wFromARVhH98QdarTym2zsK6FDRVHcYwiL6g00SvEqU3yH48Zj5Ny3O9A==
X-Received: by 2002:a05:6870:828e:b0:24d:2d66:f07b with SMTP id
 586e51a60fabf-24d2d66f15bmr7119905fac.19.1716791965911; 
 Sun, 26 May 2024 23:39:25 -0700 (PDT)
Received: from tops-ThinkPad-E14-Gen-5.. ([103.217.239.66])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-6f8fc0599f3sm4283664b3a.53.2024.05.26.23.39.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 26 May 2024 23:39:25 -0700 (PDT)
From: Jagan Teki <jagan@edgeble.ai>
To: Kever Yang <kever.yang@rock-chips.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Simon Glass <sjg@chromium.org>,
 Jonas Karlman <jonas@kwiboo.se>
Cc: Anand Moon <anand@edgeble.ai>, u-boot@lists.denx.de,
 Jagan Teki <jagan@edgeble.ai>
Subject: [PATCH 1/2] arm64: dts: rockchip: Fix spl-boot-order for edgeble-ncm6b
Date: Mon, 27 May 2024 12:09:14 +0530
Message-Id: <20240527063915.6205-1-jagan@edgeble.ai>
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

Edgeble NCM6B SoM has built-in eMMC so make sdhci has first boot
priority.

Fix it for NCM6A, NCM6B SoM.

Signed-off-by: Jagan Teki <jagan@edgeble.ai>
---
 arch/arm/dts/rk3588-edgeble-neu6a-io-u-boot.dtsi |  6 +-----
 arch/arm/dts/rk3588-edgeble-neu6b-io-u-boot.dtsi | 11 ++++++-----
 2 files changed, 7 insertions(+), 10 deletions(-)

diff --git a/arch/arm/dts/rk3588-edgeble-neu6a-io-u-boot.dtsi b/arch/arm/dts/rk3588-edgeble-neu6a-io-u-boot.dtsi
index dd0058262b..88f3f7eee2 100644
--- a/arch/arm/dts/rk3588-edgeble-neu6a-io-u-boot.dtsi
+++ b/arch/arm/dts/rk3588-edgeble-neu6a-io-u-boot.dtsi
@@ -6,12 +6,8 @@
 #include "rk3588-u-boot.dtsi"
 
 / {
-	aliases {
-		mmc0 = &sdmmc;
-	};
-
 	chosen {
-		u-boot,spl-boot-order = &sdmmc;
+		u-boot,spl-boot-order = "same-as-spl", &sdhci, &sdmmc;
 	};
 };
 
diff --git a/arch/arm/dts/rk3588-edgeble-neu6b-io-u-boot.dtsi b/arch/arm/dts/rk3588-edgeble-neu6b-io-u-boot.dtsi
index a45b3f5e86..289578803e 100644
--- a/arch/arm/dts/rk3588-edgeble-neu6b-io-u-boot.dtsi
+++ b/arch/arm/dts/rk3588-edgeble-neu6b-io-u-boot.dtsi
@@ -6,11 +6,12 @@
 #include "rk3588j-u-boot.dtsi"
 
 / {
-	aliases {
-		mmc0 = &sdmmc;
-	};
-
 	chosen {
-		u-boot,spl-boot-order = &sdmmc;
+		u-boot,spl-boot-order = "same-as-spl", &sdhci, &sdmmc;
 	};
 };
+
+&sdmmc {
+	bus-width = <4>;
+	status = "okay";
+};
-- 
2.34.1

