Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66F43C36011
	for <u-boot@archiver.kernel.org>; Sun, 30 Mar 2025 09:36:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F1E4B81F54;
	Sun, 30 Mar 2025 11:36:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="kc44j/LM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2150481F0B; Sun, 30 Mar 2025 11:36:19 +0200 (CEST)
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com
 [IPv6:2a00:1450:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0E701817C4
 for <u-boot@lists.denx.de>; Sun, 30 Mar 2025 11:36:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-ac2a81e41e3so713175666b.1
 for <u-boot@lists.denx.de>; Sun, 30 Mar 2025 02:36:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1743327376; x=1743932176; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IEY2jTYJG1ZgFUHRsIgLdFGSj3qT7Vm6I8lb9opawog=;
 b=kc44j/LMVuEfepWSFL/VkYWN1qfmJ6RYAujm1j4ZLxGCJ5t1GcZBH/ETxwwWlQinoq
 qIFyfbw8qU9QkfVEDgOVV7sz43CSeQeJzg0GVt7I2r/bdsOIIxf2pcE5wnjNLQvFTUXc
 H80EheM/a5y72HuA6Npe1+hjj0SHcutKwXFkFm62udHwv4LGUbrrSBmrIqoigKWTjO1f
 XCUuzc3pNcmvXhllWzQImOTMllIdk2/Qx+oRBA+CVCl61IcPkQ+0Zdai+xpFG4TBveym
 4gFBg1z6V+rU7bUvMxYfl8FYqPe6uX0bSZr8nmov9Od8tT+OUTxRmBT/uqsa7T19ubnQ
 i4rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743327376; x=1743932176;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IEY2jTYJG1ZgFUHRsIgLdFGSj3qT7Vm6I8lb9opawog=;
 b=tXtP6S4I9Kguxd03w95mtwjO0afmMwbfjF1omigKopCljAOz0krkLCWLMjDtZDxWIx
 K/3yVtZMbJpgx1TqtngHdN+9NrnbRmqDYqtb2Pmvh/lPwOUpGax0UXE3e19dELLQLoPx
 +toSzQOOWvZAPPiiyhskE4uPUp5dZm7uBLdv+MH+7zA9AdNG+0HTriIOx/zzw42Tu44R
 lXgYUGGGjRDNCIec2lmRyuHNCPf8ETy5YLp80qQwmnkjIfh/KVPuFBzqjjk/osxCtMeF
 EVZebFmPadgE7Dufzv55rb+el2Q19kvASP8WTg0K6TJeczneSjZncI5emK/fjBe+qVfE
 Sdmg==
X-Gm-Message-State: AOJu0YwgZAE3aM/EaDt674Q9tXucXZ8+3ZxdVsXaMaeVuXUt16cwW9w1
 KRKzUu4uRSzcCvfFzClyd2phXazPbahywrwTBkGFSkVNQXIqQONO
X-Gm-Gg: ASbGncvV/fOH/JCferUuICGksm3Mx+6sXIFVp826bJb6g7d9hO1EFhHk8Wh9YMt1TLc
 8OBENDECBIowbfwbiheT2PN0QZBpVky+/naWXGH63rv0Ny9Pi7yPVeOnzEFLIgyWL/IbS5WhMaN
 aaiizDoV+HvGAZS4FhB5msp8dqSL8rD60HrV7Olst5tMfMErQMmXb3QE84tCTnl/YrC8DQVAeP1
 2S5BapvJKtdRhwQgf9rf0MXflPIbADOZObkoTcXHBM2Wj+AluBgnxIUhTI9JDW+5FNx4AH9hLOS
 Mk9NaJ9yTYx5SsbgKQbirGRE/hsrGh5WfH2u
X-Google-Smtp-Source: AGHT+IGJkL0ayq12qeM23JIFPXazxk5a24levmf1ta4zHsuJR1ESBrLDO93uIjfLsO8D6wgSfgGyVw==
X-Received: by 2002:a17:907:9693:b0:ac3:3cfc:a59c with SMTP id
 a640c23a62f3a-ac73898d4c5mr481308866b.11.1743327376366; 
 Sun, 30 Mar 2025 02:36:16 -0700 (PDT)
Received: from xeon.. ([188.163.112.51]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ac71971b7cfsm455273866b.183.2025.03.30.02.36.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 30 Mar 2025 02:36:16 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Francesco Dolcini <francesco.dolcini@toradex.com>,
 Tom Rini <trini@konsulko.com>, Svyatoslav Ryhel <clamor95@gmail.com>,
 =?UTF-8?q?Jonas=20Schw=C3=B6bel?= <jonasschwoebel@yahoo.de>,
 Alban Bedel <alban.bedel@avionic-design.de>,
 Anatolij Gustschin <agust@denx.de>, Thierry Reding <treding@nvidia.com>,
 Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de
Subject: [PATCH v1 4/5] video: tegra: drop prefix from file names
Date: Sun, 30 Mar 2025 12:35:59 +0300
Message-ID: <20250330093600.10871-5-clamor95@gmail.com>
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

Dir name is enough.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 drivers/video/tegra/Makefile                           | 10 +++++-----
 .../{tegra-pwm-backlight.c => dc-pwm-backlight.c}      |  2 +-
 drivers/video/tegra/{tegra-dc.c => dc.c}               |  2 +-
 drivers/video/tegra/{tegra-dc.h => dc.h}               |  0
 drivers/video/tegra/{tegra-dsi.c => dsi.c}             |  4 ++--
 drivers/video/tegra/{tegra-dsi.h => dsi.h}             |  0
 drivers/video/tegra/{tegra-hdmi.c => hdmi.c}           |  4 ++--
 drivers/video/tegra/{tegra-hdmi.h => hdmi.h}           |  0
 drivers/video/tegra/{tegra-host1x.c => host1x.c}       |  0
 drivers/video/tegra/{tegra-mipi.c => mipi.c}           |  0
 10 files changed, 11 insertions(+), 11 deletions(-)
 rename drivers/video/tegra/{tegra-pwm-backlight.c => dc-pwm-backlight.c} (99%)
 rename drivers/video/tegra/{tegra-dc.c => dc.c} (99%)
 rename drivers/video/tegra/{tegra-dc.h => dc.h} (100%)
 rename drivers/video/tegra/{tegra-dsi.c => dsi.c} (99%)
 rename drivers/video/tegra/{tegra-dsi.h => dsi.h} (100%)
 rename drivers/video/tegra/{tegra-hdmi.c => hdmi.c} (99%)
 rename drivers/video/tegra/{tegra-hdmi.h => hdmi.h} (100%)
 rename drivers/video/tegra/{tegra-host1x.c => host1x.c} (100%)
 rename drivers/video/tegra/{tegra-mipi.c => mipi.c} (100%)

diff --git a/drivers/video/tegra/Makefile b/drivers/video/tegra/Makefile
index cd4cf72b3e5..4602b49ee73 100644
--- a/drivers/video/tegra/Makefile
+++ b/drivers/video/tegra/Makefile
@@ -1,9 +1,9 @@
 # SPDX-License-Identifier: GPL-2.0+
 
-obj-$(CONFIG_HOST1X_TEGRA) += tegra-host1x.o
-obj-$(CONFIG_VIDEO_TEGRA20) += tegra-dc.o
-obj-$(CONFIG_VIDEO_DSI_TEGRA30) += tegra-dsi.o tegra-mipi.o mipi-phy.o
-obj-$(CONFIG_VIDEO_HDMI_TEGRA) += tegra-hdmi.o
-obj-$(CONFIG_TEGRA_BACKLIGHT_PWM) += tegra-pwm-backlight.o
+obj-$(CONFIG_HOST1X_TEGRA) += host1x.o
+obj-$(CONFIG_VIDEO_TEGRA20) += dc.o
+obj-$(CONFIG_VIDEO_DSI_TEGRA30) += dsi.o mipi.o mipi-phy.o
+obj-$(CONFIG_VIDEO_HDMI_TEGRA) += hdmi.o
+obj-$(CONFIG_TEGRA_BACKLIGHT_PWM) += dc-pwm-backlight.o
 
 obj-${CONFIG_VIDEO_TEGRA124} += tegra124/
diff --git a/drivers/video/tegra/tegra-pwm-backlight.c b/drivers/video/tegra/dc-pwm-backlight.c
similarity index 99%
rename from drivers/video/tegra/tegra-pwm-backlight.c
rename to drivers/video/tegra/dc-pwm-backlight.c
index 998f0df1991..eff10b5563e 100644
--- a/drivers/video/tegra/tegra-pwm-backlight.c
+++ b/drivers/video/tegra/dc-pwm-backlight.c
@@ -15,7 +15,7 @@
 #include <asm/io.h>
 #include <asm/gpio.h>
 
-#include "tegra-dc.h"
+#include "dc.h"
 
 #define TEGRA_PWM_BL_MIN_BRIGHTNESS	0x10
 #define TEGRA_PWM_BL_MAX_BRIGHTNESS	0xFF
diff --git a/drivers/video/tegra/tegra-dc.c b/drivers/video/tegra/dc.c
similarity index 99%
rename from drivers/video/tegra/tegra-dc.c
rename to drivers/video/tegra/dc.c
index 1f43153ff27..f0e3d2c993f 100644
--- a/drivers/video/tegra/tegra-dc.c
+++ b/drivers/video/tegra/dc.c
@@ -19,7 +19,7 @@
 #include <asm/arch/clock.h>
 #include <asm/arch/powergate.h>
 
-#include "tegra-dc.h"
+#include "dc.h"
 
 /* Holder of Tegra per-SOC DC differences */
 struct tegra_dc_soc_info {
diff --git a/drivers/video/tegra/tegra-dc.h b/drivers/video/tegra/dc.h
similarity index 100%
rename from drivers/video/tegra/tegra-dc.h
rename to drivers/video/tegra/dc.h
diff --git a/drivers/video/tegra/tegra-dsi.c b/drivers/video/tegra/dsi.c
similarity index 99%
rename from drivers/video/tegra/tegra-dsi.c
rename to drivers/video/tegra/dsi.c
index a96fba01ee4..bc308869f4e 100644
--- a/drivers/video/tegra/tegra-dsi.c
+++ b/drivers/video/tegra/dsi.c
@@ -24,8 +24,8 @@
 #include <asm/arch/clock.h>
 #include <asm/arch-tegra/clk_rst.h>
 
-#include "tegra-dc.h"
-#include "tegra-dsi.h"
+#include "dc.h"
+#include "dsi.h"
 #include "mipi-phy.h"
 
 /* List of supported DSI bridges */
diff --git a/drivers/video/tegra/tegra-dsi.h b/drivers/video/tegra/dsi.h
similarity index 100%
rename from drivers/video/tegra/tegra-dsi.h
rename to drivers/video/tegra/dsi.h
diff --git a/drivers/video/tegra/tegra-hdmi.c b/drivers/video/tegra/hdmi.c
similarity index 99%
rename from drivers/video/tegra/tegra-hdmi.c
rename to drivers/video/tegra/hdmi.c
index bda69919d92..bfb48b25187 100644
--- a/drivers/video/tegra/tegra-hdmi.c
+++ b/drivers/video/tegra/hdmi.c
@@ -22,8 +22,8 @@
 #include <asm/io.h>
 #include <asm/arch/clock.h>
 
-#include "tegra-dc.h"
-#include "tegra-hdmi.h"
+#include "dc.h"
+#include "hdmi.h"
 
 #define DDCCI_ENTRY_ADDR	0x37
 #define DDCCI_SOURSE_ADDR	0x51
diff --git a/drivers/video/tegra/tegra-hdmi.h b/drivers/video/tegra/hdmi.h
similarity index 100%
rename from drivers/video/tegra/tegra-hdmi.h
rename to drivers/video/tegra/hdmi.h
diff --git a/drivers/video/tegra/tegra-host1x.c b/drivers/video/tegra/host1x.c
similarity index 100%
rename from drivers/video/tegra/tegra-host1x.c
rename to drivers/video/tegra/host1x.c
diff --git a/drivers/video/tegra/tegra-mipi.c b/drivers/video/tegra/mipi.c
similarity index 100%
rename from drivers/video/tegra/tegra-mipi.c
rename to drivers/video/tegra/mipi.c
-- 
2.43.0

