Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A26CEC25B48
	for <u-boot@archiver.kernel.org>; Thu, 26 Oct 2023 13:42:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7AC6E875A1;
	Thu, 26 Oct 2023 15:42:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="BV5edaZg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2E4BF875DA; Thu, 26 Oct 2023 15:42:05 +0200 (CEST)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A251B87598
 for <u-boot@lists.denx.de>; Thu, 26 Oct 2023 15:41:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4079ed65471so6972425e9.1
 for <u-boot@lists.denx.de>; Thu, 26 Oct 2023 06:41:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1698327719; x=1698932519;
 darn=lists.denx.de; 
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=GXYwkjf/k/iPjcFqnMiDY68NJWoXknz2s5MJIBWpwyM=;
 b=BV5edaZg466HrGIkq6SEJ1ZQFVkYW7FLxzAOKj4bJ1VFZ+cJev4aj1Gj9ikve6xdh7
 lHsfTMt8s54El1iVllXHJUXFe7jDEt+9nUEFEOnGtmHGHe+KrkerLNb+SSlkSnqag+R2
 3BNe68AvaebceSdjFvJENLwDVOus8E+wjmS30NYdejOih/iQxRbNCAeTwai5HfAx6xoL
 XGgYpGGWgQFIDzQrHmrxqB8R4tMJzbto4L/sB5WKbsk14UYCQfSeUJt+MB4OzLR93smF
 3m1nBtcr7PzMHnYyZbyqWA0FjhTm8egrRRT77EX07Y6ZN/bAoiZpFv278NXoJZ2sjd7X
 SXDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698327719; x=1698932519;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=GXYwkjf/k/iPjcFqnMiDY68NJWoXknz2s5MJIBWpwyM=;
 b=GTrVwXYYjtd4KpkQ22GE/O1eXEzyWeyVAO9fN/hT8m651ow1wJoWB2/2kC3t5PJnR8
 Y5zs49b8QzbL98s+XPLrMEaywH0XCw9aIoxscpHxixW29OuZknVd9fHgn1NCX1f9v/GS
 edHekyjeOx/DhagEO9KQ99gTVoVRNBJW3JqiJwnwVvrsaRQdZMc3XSj0n2DVW5V4fH9D
 6n6lC4znVsJpUElJsT4Pki9lTMtPqhJuLzSsusUXAYp4tPnO3m5cVXrjjDfkB0BheYQ+
 7Js2YXXC8z6/d0k098MCgdMEVoK7WcpTOWMuEaiYdD2jrA+E1Q+ijqKMK4rfxax3bDxL
 vnnA==
X-Gm-Message-State: AOJu0YzigvmQ5IyhSbW1mGnFewCeYmhsfjsLS6AAOmp1KuAbZNgS/qeN
 Gvx+flJLicvJVcsk/MDUNLIy9g==
X-Google-Smtp-Source: AGHT+IH42prjvBPsRBRsFFnXZBRP2fAOVCt5HkwH10gTh+1rr806sQTMmiQzNTESIiRo+RnvbqHG3g==
X-Received: by 2002:a05:600c:4445:b0:408:80bb:ae80 with SMTP id
 v5-20020a05600c444500b0040880bbae80mr11686024wmn.7.1698327719048; 
 Thu, 26 Oct 2023 06:41:59 -0700 (PDT)
Received: from [192.168.2.42] ([82.66.159.240])
 by smtp.gmail.com with ESMTPSA id
 n41-20020a05600c3ba900b004060f0a0fdbsm2646407wms.41.2023.10.26.06.41.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Oct 2023 06:41:58 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
Date: Thu, 26 Oct 2023 15:41:31 +0200
Subject: [PATCH] configs: khadas-vim3*_android: fix environment saving
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231026-fix-saveenv-v1-1-6aa59be65481@baylibre.com>
X-B4-Tracking: v=1; b=H4sIAIpsOmUC/x2MQQqAIBAAvyJ7TtDNRPpKdLDaai8WLkgg/T3pO
 AwzFYQyk8CoKmQqLHylBrZTsJ4xHaR5awxosLcGvd750RILUSqalsEF5xExILTiztT0f5vm9/0
 A1KtjYV0AAAA=
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Guillaume La Roque <glaroque@baylibre.com>, u-boot-amlogic@groups.io, 
 u-boot@lists.denx.de, Mattijs Korpershoek <mkorpershoek@baylibre.com>
X-Mailer: b4 0.12.4-dev-6aa5d
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

The environment is used to configure some additional boot features such as:
* extra boot arguments
* enable AVB (Android Verified Boot) verification

Right now, we cannot store it in eMMC:

  Loading Environment from nowhere... OK

Fix it by enabling the appropriate options in the defconfig

Fixes: b749d5ecdc06 ("configs: meson64_android: define raw parts for bootloader")
Signed-off-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
---
 configs/khadas-vim3_android_ab_defconfig  | 4 ++++
 configs/khadas-vim3_android_defconfig     | 4 ++++
 configs/khadas-vim3l_android_ab_defconfig | 4 ++++
 configs/khadas-vim3l_android_defconfig    | 4 ++++
 4 files changed, 16 insertions(+)

diff --git a/configs/khadas-vim3_android_ab_defconfig b/configs/khadas-vim3_android_ab_defconfig
index ccd6f6f8a075..0abccb64ee15 100644
--- a/configs/khadas-vim3_android_ab_defconfig
+++ b/configs/khadas-vim3_android_ab_defconfig
@@ -7,6 +7,7 @@ CONFIG_NR_DRAM_BANKS=1
 CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
 CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x20000000
 CONFIG_ENV_SIZE=0x10000
+CONFIG_ENV_OFFSET=0x0
 CONFIG_DM_GPIO=y
 CONFIG_DEFAULT_DEVICE_TREE="meson-g12b-a311d-khadas-vim3"
 CONFIG_OF_LIBFDT_OVERLAY=y
@@ -45,7 +46,10 @@ CONFIG_CMD_AB_SELECT=y
 CONFIG_CMD_REGULATOR=y
 CONFIG_CMD_AVB=y
 CONFIG_OF_CONTROL=y
+CONFIG_ENV_IS_IN_MMC=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_SYS_MMC_ENV_DEV=2
+CONFIG_SYS_MMC_ENV_PART=2
 CONFIG_ADC=y
 CONFIG_SARADC_MESON=y
 CONFIG_BUTTON=y
diff --git a/configs/khadas-vim3_android_defconfig b/configs/khadas-vim3_android_defconfig
index 5c3d565971d6..33ede5262295 100644
--- a/configs/khadas-vim3_android_defconfig
+++ b/configs/khadas-vim3_android_defconfig
@@ -7,6 +7,7 @@ CONFIG_NR_DRAM_BANKS=1
 CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
 CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x20000000
 CONFIG_ENV_SIZE=0x10000
+CONFIG_ENV_OFFSET=0x0
 CONFIG_DM_GPIO=y
 CONFIG_DEFAULT_DEVICE_TREE="meson-g12b-a311d-khadas-vim3"
 CONFIG_OF_LIBFDT_OVERLAY=y
@@ -43,7 +44,10 @@ CONFIG_CMD_USB_MASS_STORAGE=y
 CONFIG_CMD_REGULATOR=y
 CONFIG_CMD_AVB=y
 CONFIG_OF_CONTROL=y
+CONFIG_ENV_IS_IN_MMC=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_SYS_MMC_ENV_DEV=2
+CONFIG_SYS_MMC_ENV_PART=2
 CONFIG_ADC=y
 CONFIG_SARADC_MESON=y
 CONFIG_BUTTON=y
diff --git a/configs/khadas-vim3l_android_ab_defconfig b/configs/khadas-vim3l_android_ab_defconfig
index 0d6de8001382..8f32f8e8ad5b 100644
--- a/configs/khadas-vim3l_android_ab_defconfig
+++ b/configs/khadas-vim3l_android_ab_defconfig
@@ -7,6 +7,7 @@ CONFIG_NR_DRAM_BANKS=1
 CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
 CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x20000000
 CONFIG_ENV_SIZE=0x10000
+CONFIG_ENV_OFFSET=0x0
 CONFIG_DM_GPIO=y
 CONFIG_DEFAULT_DEVICE_TREE="meson-sm1-khadas-vim3l"
 CONFIG_OF_LIBFDT_OVERLAY=y
@@ -45,7 +46,10 @@ CONFIG_CMD_AB_SELECT=y
 CONFIG_CMD_REGULATOR=y
 CONFIG_CMD_AVB=y
 CONFIG_OF_CONTROL=y
+CONFIG_ENV_IS_IN_MMC=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_SYS_MMC_ENV_DEV=2
+CONFIG_SYS_MMC_ENV_PART=2
 CONFIG_ADC=y
 CONFIG_SARADC_MESON=y
 CONFIG_BUTTON=y
diff --git a/configs/khadas-vim3l_android_defconfig b/configs/khadas-vim3l_android_defconfig
index 827752f24373..443c10aee3d0 100644
--- a/configs/khadas-vim3l_android_defconfig
+++ b/configs/khadas-vim3l_android_defconfig
@@ -7,6 +7,7 @@ CONFIG_NR_DRAM_BANKS=1
 CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
 CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x20000000
 CONFIG_ENV_SIZE=0x10000
+CONFIG_ENV_OFFSET=0x0
 CONFIG_DM_GPIO=y
 CONFIG_DEFAULT_DEVICE_TREE="meson-sm1-khadas-vim3l"
 CONFIG_OF_LIBFDT_OVERLAY=y
@@ -43,7 +44,10 @@ CONFIG_CMD_USB_MASS_STORAGE=y
 CONFIG_CMD_REGULATOR=y
 CONFIG_CMD_AVB=y
 CONFIG_OF_CONTROL=y
+CONFIG_ENV_IS_IN_MMC=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_SYS_MMC_ENV_DEV=2
+CONFIG_SYS_MMC_ENV_PART=2
 CONFIG_ADC=y
 CONFIG_SARADC_MESON=y
 CONFIG_BUTTON=y

---
base-commit: 14a21f1a80afc58d52dc72e35f27d3a47d36c082
change-id: 20231026-fix-saveenv-eb5484622282

Best regards,
-- 
Mattijs Korpershoek <mkorpershoek@baylibre.com>

