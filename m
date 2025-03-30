Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B57FC28B20
	for <u-boot@archiver.kernel.org>; Sun, 30 Mar 2025 09:36:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A1FC381F0B;
	Sun, 30 Mar 2025 11:36:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="iCjDn337";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0B00381E8C; Sun, 30 Mar 2025 11:36:18 +0200 (CEST)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com
 [IPv6:2a00:1450:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EE7B081951
 for <u-boot@lists.denx.de>; Sun, 30 Mar 2025 11:36:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-aaf0f1adef8so482661766b.3
 for <u-boot@lists.denx.de>; Sun, 30 Mar 2025 02:36:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1743327375; x=1743932175; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RXytl43U3iiyIZVRJykNmEjX0MvjcXuArlPsB9e66BM=;
 b=iCjDn3372I1mqBysg+WHJZNYa1yGJit4/ZPHnIbqWxb+XGJQi7t/Nz3+6dT6hQ0q8O
 FTshEFs45dS3FMr72AD62TDIM6fgEBvBwhN30WuFu1ldOlmTQR5D6n/6OC9gMHHG8dlm
 WKNOPqrWHCGWaLkAnwWfaj2NV4X2lokNKkbAXBxSMUjzl2faQA+QzIOTgumYl8AlVulE
 wit+51N4xyvcARvd0nG4NruLr554GMWB1NnCBOuwMN292ydJBBafan9vjZf6dEXRyBXv
 EMPaBwwu5HGtBuPWb7fEw9gsQGn9cAcSyY7wnE6NVWerDChZP3Z8vODMzULxTfOBfqEb
 6HVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743327375; x=1743932175;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RXytl43U3iiyIZVRJykNmEjX0MvjcXuArlPsB9e66BM=;
 b=aOHL+yaxKwyRIEQ9XyrfvcKer4p8AvFoWN4zzaD8Qk7SQcOi2jcuI3eEWgtpEw/VsD
 dayo8KYv7Zehu4DpbFljv5nNV+X3r4GHeTHucD1OMF/b+BxU/rXZswEBYksTqFBEFQ8v
 ZMyfBUiX0h53noddR/iY7j8IldfTF7b6zuRzr7Yd8dEjrdCI1APfWIOtSPu3gSMWsB2O
 npGk/lwejLt7JH8qAxAslBFmXmcEb2wFN6ZdNeMxrkg9Myt+ejEFfEDzylcAiTTXV5aS
 e6xFvFG2YFAKmSCTMOWfr/A5osRZRb7IMItNTSaE53Zl6STPFjwRt2pt6smrsgemiUh1
 7iFw==
X-Gm-Message-State: AOJu0Yx/feNsMu+Yp/QmQaW/bkFV9ARff13qdt1vfaWLWd21eg4yy2IO
 fW9Mf76QiaPsS+zW8q7Lo3xWK8lSxGB+UmJI9X4Ud+11MjLlejAG
X-Gm-Gg: ASbGncvNLvNOHqoJL4WK2Ovf8k7v9CqVBG+ofPhsOShIZEJkX116IH/XP7tMTq+Ze9Z
 GykOd38kLUFEvOiCAnv4+sQUv4TmvgaRbUTmKbgyMeVSDzQvINL3EgLkOQcvrWsT8ArLTkhR/0g
 y1x9jjTFclc7G0YlgTcdW9gb5DeacGMPo9PDpNkNG3euKP6XQVRh6Bayu1Eu3Xf5+jccUupbb5p
 Eh4YnhDgTWfjKOU23LuF2sI56VdXzgRTTsxfaa4idEY7TTUYfjwoaPbm525B3q/tA8o6yNm26+K
 1DEqG6HTTUy79FvBEGwlOvNJ1kzqu6F4yiEu
X-Google-Smtp-Source: AGHT+IEvi6XUjONzLC7Eq9zx3xfKo0KF0lMVwNZeXfzrY8oVFGSrYYCmG9tkbG8v0rvlHdJeuL8Nkg==
X-Received: by 2002:a17:907:7e82:b0:ac3:cc9b:5b6d with SMTP id
 a640c23a62f3a-ac7389edcf6mr531052866b.16.1743327375259; 
 Sun, 30 Mar 2025 02:36:15 -0700 (PDT)
Received: from xeon.. ([188.163.112.51]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ac71971b7cfsm455273866b.183.2025.03.30.02.36.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 30 Mar 2025 02:36:14 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Francesco Dolcini <francesco.dolcini@toradex.com>,
 Tom Rini <trini@konsulko.com>, Svyatoslav Ryhel <clamor95@gmail.com>,
 =?UTF-8?q?Jonas=20Schw=C3=B6bel?= <jonasschwoebel@yahoo.de>,
 Alban Bedel <alban.bedel@avionic-design.de>,
 Anatolij Gustschin <agust@denx.de>, Thierry Reding <treding@nvidia.com>,
 Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de
Subject: [PATCH v1 3/5] video: move tegra124 into common tegra dir
Date: Sun, 30 Mar 2025 12:35:58 +0300
Message-ID: <20250330093600.10871-4-clamor95@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250330093600.10871-1-clamor95@gmail.com>
References: <20250330093600.10871-1-clamor95@gmail.com>
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

Place Tegra124 SOR and eDP implenetation into common Tegra driver folder
until it is integrated into existing setup.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 drivers/video/Kconfig                            | 8 --------
 drivers/video/Makefile                           | 1 -
 drivers/video/tegra/Kconfig                      | 8 ++++++++
 drivers/video/tegra/Makefile                     | 2 ++
 drivers/video/tegra/TODO                         | 5 +++++
 drivers/video/{ => tegra}/tegra124/Makefile      | 0
 drivers/video/{ => tegra}/tegra124/display.c     | 0
 drivers/video/{ => tegra}/tegra124/displayport.h | 0
 drivers/video/{ => tegra}/tegra124/dp.c          | 0
 drivers/video/{ => tegra}/tegra124/sor.c         | 0
 drivers/video/{ => tegra}/tegra124/sor.h         | 0
 11 files changed, 15 insertions(+), 9 deletions(-)
 create mode 100644 drivers/video/tegra/TODO
 rename drivers/video/{ => tegra}/tegra124/Makefile (100%)
 rename drivers/video/{ => tegra}/tegra124/display.c (100%)
 rename drivers/video/{ => tegra}/tegra124/displayport.h (100%)
 rename drivers/video/{ => tegra}/tegra124/dp.c (100%)
 rename drivers/video/{ => tegra}/tegra124/sor.c (100%)
 rename drivers/video/{ => tegra}/tegra124/sor.h (100%)

diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
index afcdb16c599..d343dfb061b 100644
--- a/drivers/video/Kconfig
+++ b/drivers/video/Kconfig
@@ -809,14 +809,6 @@ source "drivers/video/stm32/Kconfig"
 
 source "drivers/video/tidss/Kconfig"
 
-config VIDEO_TEGRA124
-	bool "Enable video support on Tegra124"
-	help
-	   Tegra124 supports many video output options including eDP and
-	   HDMI. At present only eDP is supported by U-Boot. This option
-	   enables this support which can be used on devices which
-	   have an eDP display connected.
-
 source "drivers/video/bridge/Kconfig"
 
 source "drivers/video/tegra/Kconfig"
diff --git a/drivers/video/Makefile b/drivers/video/Makefile
index f506f4ba050..fec58bd8283 100644
--- a/drivers/video/Makefile
+++ b/drivers/video/Makefile
@@ -34,7 +34,6 @@ obj-$(CONFIG_BACKLIGHT_LP855x) += lp855x_backlight.o
 obj-${CONFIG_EXYNOS_FB} += exynos/
 obj-${CONFIG_VIDEO_ROCKCHIP} += rockchip/
 obj-${CONFIG_VIDEO_STM32} += stm32/
-obj-${CONFIG_VIDEO_TEGRA124} += tegra124/
 obj-${CONFIG_$(XPL_)VIDEO_TIDSS} += tidss/
 obj-y += ti/
 
diff --git a/drivers/video/tegra/Kconfig b/drivers/video/tegra/Kconfig
index 598f9ea1f21..3d610036a1f 100644
--- a/drivers/video/tegra/Kconfig
+++ b/drivers/video/tegra/Kconfig
@@ -36,3 +36,11 @@ config TEGRA_BACKLIGHT_PWM
 	select VIDEO_TEGRA20
 	help
 	   Tegra DC dependent backlight.
+
+config VIDEO_TEGRA124
+	bool "Enable video support on Tegra124"
+	help
+	   Tegra124 supports many video output options including eDP and
+	   HDMI. At present only eDP is supported by U-Boot. This option
+	   enables this support which can be used on devices which
+	   have an eDP display connected.
diff --git a/drivers/video/tegra/Makefile b/drivers/video/tegra/Makefile
index 78521405749..cd4cf72b3e5 100644
--- a/drivers/video/tegra/Makefile
+++ b/drivers/video/tegra/Makefile
@@ -5,3 +5,5 @@ obj-$(CONFIG_VIDEO_TEGRA20) += tegra-dc.o
 obj-$(CONFIG_VIDEO_DSI_TEGRA30) += tegra-dsi.o tegra-mipi.o mipi-phy.o
 obj-$(CONFIG_VIDEO_HDMI_TEGRA) += tegra-hdmi.o
 obj-$(CONFIG_TEGRA_BACKLIGHT_PWM) += tegra-pwm-backlight.o
+
+obj-${CONFIG_VIDEO_TEGRA124} += tegra124/
diff --git a/drivers/video/tegra/TODO b/drivers/video/tegra/TODO
new file mode 100644
index 00000000000..1c8c2389a18
--- /dev/null
+++ b/drivers/video/tegra/TODO
@@ -0,0 +1,5 @@
+Existence of separate Tegra124 video implementations is not an ideal solution
+since generic video setup for Tegra already has Tegra124 support of some degree.
+It is not possible at the time of this note is written to integrate T124 SOR
+and DP without possible regressions. Tegra124 setup for SOR and DP should be
+incorporated into existing setup once such opportunity occurs.
diff --git a/drivers/video/tegra124/Makefile b/drivers/video/tegra/tegra124/Makefile
similarity index 100%
rename from drivers/video/tegra124/Makefile
rename to drivers/video/tegra/tegra124/Makefile
diff --git a/drivers/video/tegra124/display.c b/drivers/video/tegra/tegra124/display.c
similarity index 100%
rename from drivers/video/tegra124/display.c
rename to drivers/video/tegra/tegra124/display.c
diff --git a/drivers/video/tegra124/displayport.h b/drivers/video/tegra/tegra124/displayport.h
similarity index 100%
rename from drivers/video/tegra124/displayport.h
rename to drivers/video/tegra/tegra124/displayport.h
diff --git a/drivers/video/tegra124/dp.c b/drivers/video/tegra/tegra124/dp.c
similarity index 100%
rename from drivers/video/tegra124/dp.c
rename to drivers/video/tegra/tegra124/dp.c
diff --git a/drivers/video/tegra124/sor.c b/drivers/video/tegra/tegra124/sor.c
similarity index 100%
rename from drivers/video/tegra124/sor.c
rename to drivers/video/tegra/tegra124/sor.c
diff --git a/drivers/video/tegra124/sor.h b/drivers/video/tegra/tegra124/sor.h
similarity index 100%
rename from drivers/video/tegra124/sor.h
rename to drivers/video/tegra/tegra124/sor.h
-- 
2.43.0

