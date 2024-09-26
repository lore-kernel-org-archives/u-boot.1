Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF57CCDE03A
	for <u-boot@archiver.kernel.org>; Thu, 26 Sep 2024 20:48:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 84ECE88DF1;
	Thu, 26 Sep 2024 22:48:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Ajb+dUjN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 25C3788DEF; Thu, 26 Sep 2024 22:48:46 +0200 (CEST)
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com
 [IPv6:2607:f8b0:4864:20::f29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E5F3988E03
 for <u-boot@lists.denx.de>; Thu, 26 Sep 2024 22:48:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf29.google.com with SMTP id
 6a1803df08f44-6cb25aad5dfso11000666d6.3
 for <u-boot@lists.denx.de>; Thu, 26 Sep 2024 13:48:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1727383723; x=1727988523; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8eYkEzhZo+pzkQyf5hnwbVnT55A3XvI7W6xRwuvqn6w=;
 b=Ajb+dUjNRCCeQaHdoEaOGSZre1+HUMqGiPvZMudL9q3IjA24hKSkWlh9o1rrsHccpf
 FL9YSqgtz4KNmSxFEZ4muw8llLjuoBkwnUnBQf+vrMCRgm1eOGH3JXEz+UND8R2HBjdO
 d9O+vCZBDNFlh6SdjhZPUxoptTVE07MgIYWKo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727383723; x=1727988523;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8eYkEzhZo+pzkQyf5hnwbVnT55A3XvI7W6xRwuvqn6w=;
 b=dGw4OF4j0hrYJRVaOj44NOaROBeralui4CfOPJbp5BpNhUzFOwmYOGGPO8stm8oBbg
 SUImYQ2KPFiPtXuTHySTdsHoR4iNoZc7eA9+HdJVI/uE11j8YkLHMuBpyWKsLvxGqZQU
 IPxuWAn+a1beh9tCBWIZEEeUCFlATQtTczBhnkcwCrq3R2nM4GeEM5JtTAtog9m9lHgY
 jeWfJn3RPZJwyrctHwQOwA+PzUS2zvZogunW/9TWL6n9hCKBrO0mKjwdVWWRgQm8Cok3
 kMpVsv+h2XqkNlrarUGLncIcrhXdLSbaTw03ahYKerKV0G6/CTMVPtK3TuHOqfOC0eru
 qC3Q==
X-Gm-Message-State: AOJu0YwaiV19wDd1fr24aIyT2+ZIwTQktRoX2vK13u0PBopd+tdCIxDw
 YuYAC8hALPygtGsWvVebihgOM/wveriwUfGQbtkjOeRES/puPTWhD9al+dCdQZpwfkkVoxAunaB
 B62YiSuU=
X-Google-Smtp-Source: AGHT+IGM/hq+9xO8h1gIWLfovoYtU1nJJ7tlK+kbgGyvwXI159wX3mN7vkWVhiLZn5aw6hFxcG67Fg==
X-Received: by 2002:a0c:f811:0:b0:6cb:3ba8:7a12 with SMTP id
 6a1803df08f44-6cb3cf205c9mr3803356d6.5.1727383722635; 
 Thu, 26 Sep 2024 13:48:42 -0700 (PDT)
Received: from chromium.org ([205.220.129.31])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6cb3b66cff5sm2538696d6.77.2024.09.26.13.48.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Sep 2024 13:48:42 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Jens Scharsig <esw@bus-elektronik.de>
Subject: [PATCH 06/27] eb_cpu5282: Drop STATUS_LED
Date: Thu, 26 Sep 2024 22:44:26 +0200
Message-ID: <20240926204455.963584-7-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240926204455.963584-1-sjg@chromium.org>
References: <20240926204455.963584-1-sjg@chromium.org>
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

This feature is very old and does not use the LED framework. Drop it
from this board.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 configs/eb_cpu5282_defconfig          | 6 ------
 configs/eb_cpu5282_internal_defconfig | 6 ------
 2 files changed, 12 deletions(-)

diff --git a/configs/eb_cpu5282_defconfig b/configs/eb_cpu5282_defconfig
index 271dbdf4dbb..82d28e5cf34 100644
--- a/configs/eb_cpu5282_defconfig
+++ b/configs/eb_cpu5282_defconfig
@@ -35,12 +35,6 @@ CONFIG_SYS_FAULT_ECHO_LINK_DOWN=y
 CONFIG_SYS_RX_ETH_BUFFER=8
 CONFIG_DM_I2C=y
 CONFIG_SYS_I2C_FSL=y
-CONFIG_LED_STATUS=y
-CONFIG_LED_STATUS0=y
-CONFIG_LED_STATUS_BIT=8
-CONFIG_LED_STATUS_BOOT_ENABLE=y
-CONFIG_LED_STATUS_BOOT=0
-CONFIG_LED_STATUS_CMD=y
 CONFIG_MTD=y
 CONFIG_MTD_NOR_FLASH=y
 CONFIG_FLASH_CFI_DRIVER=y
diff --git a/configs/eb_cpu5282_internal_defconfig b/configs/eb_cpu5282_internal_defconfig
index 89a7925dffa..d37127757a5 100644
--- a/configs/eb_cpu5282_internal_defconfig
+++ b/configs/eb_cpu5282_internal_defconfig
@@ -33,12 +33,6 @@ CONFIG_SYS_FAULT_ECHO_LINK_DOWN=y
 CONFIG_SYS_RX_ETH_BUFFER=8
 CONFIG_DM_I2C=y
 CONFIG_SYS_I2C_FSL=y
-CONFIG_LED_STATUS=y
-CONFIG_LED_STATUS0=y
-CONFIG_LED_STATUS_BIT=8
-CONFIG_LED_STATUS_BOOT_ENABLE=y
-CONFIG_LED_STATUS_BOOT=0
-CONFIG_LED_STATUS_CMD=y
 CONFIG_MTD=y
 CONFIG_MTD_NOR_FLASH=y
 CONFIG_FLASH_CFI_DRIVER=y
-- 
2.43.0

