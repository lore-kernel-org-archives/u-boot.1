Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13701C43458
	for <u-boot@archiver.kernel.org>; Mon, 29 Jun 2026 19:24:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A29ED84AAE;
	Mon, 29 Jun 2026 21:23:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="RvNGrWVc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 248E284A29; Mon, 29 Jun 2026 21:23:52 +0200 (CEST)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3088084AAE
 for <u-boot@lists.denx.de>; Mon, 29 Jun 2026 21:23:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andreas.zdziarstek@gmail.com
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4903d730b1fso46786705e9.2
 for <u-boot@lists.denx.de>; Mon, 29 Jun 2026 12:23:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782761028; x=1783365828; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mhLM+86B1uQraQiRi63VApf26GMXo45//W6NvM0PC0s=;
 b=RvNGrWVcGTEGE1pC6hCyqD6AbN7BcRNRxClWYiNY1Fl4jAcvEXtx5ZWpK9aBLqw9LN
 GjGWSYjyF9t5UnqHrM8V3YBb44avDAN25QsXX8URZ+dXHXlUgMSUTpsdlyZFuURfW1ph
 nEvevijTvgqutq0k+iYV+fW/AdOoMbXF8F50D6vsO/FRXUbSjeKkZ4TccvJLPFJky3Ei
 00BWbXuJKaJvI20eJkQTFELj3qXp4SnzEYjhJTuKYnpeaxYpiaTZdsebQr5/M4I/Kip2
 2vX4rTXEai3FA/XnZ02pKc5Yy2dszFHy9LQ02HiWcXlpEnljIOga7fEk2yI6E/5O2o17
 ImBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782761028; x=1783365828;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=mhLM+86B1uQraQiRi63VApf26GMXo45//W6NvM0PC0s=;
 b=oBHUKbiPf6fO+xr37MOh4vtCRAkyuyxUiVJFS44ue0EAA0Hds7txep0/nibeLd0gYw
 oJhIw9oBhVk1JAJAVpt8jvP/P9O8KhxPGeYnnqHHVHkoHSIYu0MG60q2p16xIcXFPWkc
 Ijqe9MN538sdM1dhYUjFyw1AUI2p9BOAI528/+Ec9gRnHf1JOxYo5p3aW0PfgEA1L/Ex
 zArj4e5CjEMJGBNx5Uv+9xZwewRxwjOVxXIMfV5GM2QKqzfFMKCa4bNVQLc2UCR8UqR6
 wF5wvvauay/YaF7FgKc7RF94ebCfvqqkcIqmKJZRLvH8NrlyOBHI1kPs5YeThiNupOsF
 aAoQ==
X-Gm-Message-State: AOJu0YyWbfsKYGwTcdoNIk9+OZQ+PXVl9y1tY/WqmB1FlOlc2OQ4a3uK
 DD5qsWH5JVNwn7W2zo4e5I0+Xf0NPy/Hd8Dl6F6wlrp67BVPhCzKVQuhJ6jkBrlR
X-Gm-Gg: AfdE7cn+CmLqK1KxVSLYJaRgx/FwE+pAmVZFt6EVPfHMyfDkaAnmuFB5esio1zmvlYY
 qtq1MM82edp82FYVFCue1syYixfTcCF+s+fVDaX5+Qf+dDO3D1VQqXT7yxVHb8iZLcf1riLlT8m
 TeDtGQPLPrvN7/XHFhAbognTv5dybJuD+7pzOUgUOyEGt1YdoicrL3uXps328EdjQQZwiYgojPc
 K9gwGowVzWQKnf1D4Hh1AcmMbL5TBOg0PyWCPEOLDYa5gEiArnAkgTyTVxGxqgFFW1g0wSOsp4O
 hGCs6a1F2UPDJnFp4V2J5YWyDfpKWy4wsmlR+C4NHqFdABrmFr9lNOJCSa6EYUredG601ApRtuM
 Midt3XNiQMisNEAhWjcUWzSv+WqYeYwro3E3pvbBmcM+UgJ2+uvqEA58DXGdfe8r9GBd7o+8sA7
 VEeawdSNxWbK7TPHacPPTYN0j4oJuksScMbE/agkSFWFjoRuMPLAS0dKb/l705Hb4=
X-Received: by 2002:a05:600c:1394:b0:490:e60b:6860 with SMTP id
 5b1f17b1804b1-493b827fa78mr14942365e9.7.1782761028507; 
 Mon, 29 Jun 2026 12:23:48 -0700 (PDT)
Received: from turbine.fritz.box (p5784ea85.dip0.t-ipconnect.de.
 [87.132.234.133]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493b8ca8b1csm8734785e9.9.2026.06.29.12.23.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jun 2026 12:23:47 -0700 (PDT)
From: Andreas Zdziarstek <andreas.zdziarstek@gmail.com>
To: u-boot@lists.denx.de
Cc: trini@konsulko.com, sjg@chromium.org, philipp.tomsich@vrull.eu,
 kever.yang@rock-chips.com, jonas@kwiboo.se, quentin.schulz@cherry.de,
 Andreas Zdziarstek <andreas.zdziarstek@gmail.com>
Subject: [PATCH v4 4/4] rockchip: odroid-m1/m1s: enable watchdog support
Date: Mon, 29 Jun 2026 21:23:36 +0200
Message-ID: <20260629192336.1555651-5-andreas.zdziarstek@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260629192336.1555651-1-andreas.zdziarstek@gmail.com>
References: <20260629192336.1555651-1-andreas.zdziarstek@gmail.com>
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

The rk3566 ODROID-M1S and rk3568 ODROID-M1 have a DesignWare watchdog.
Enable CONFIG_WDT and CONFIG_CMD_WDT so it can be driven via the wdt
command. The driver itself is pulled in by the SoC's imply
DESIGNWARE_WATCHDOG.

CONFIG_WATCHDOG and CONFIG_WATCHDOG_AUTOSTART are left explicitly unset
to not cause any breaking changes on existing systems.

Signed-off-by: Andreas Zdziarstek <andreas.zdziarstek@gmail.com>
---
 configs/odroid-m1-rk3568_defconfig  | 4 ++++
 configs/odroid-m1s-rk3566_defconfig | 4 ++++
 2 files changed, 8 insertions(+)

diff --git a/configs/odroid-m1-rk3568_defconfig b/configs/odroid-m1-rk3568_defconfig
index b00985b0405..bcc0556de2e 100644
--- a/configs/odroid-m1-rk3568_defconfig
+++ b/configs/odroid-m1-rk3568_defconfig
@@ -37,6 +37,7 @@ CONFIG_CMD_MMC=y
 CONFIG_CMD_MTD=y
 CONFIG_CMD_PCI=y
 CONFIG_CMD_USB=y
+CONFIG_CMD_WDT=y
 # CONFIG_CMD_SETEXPR is not set
 CONFIG_CMD_INI=y
 CONFIG_CMD_PMIC=y
@@ -92,5 +93,8 @@ CONFIG_USB_OHCI_HCD=y
 CONFIG_USB_OHCI_GENERIC=y
 CONFIG_USB_DWC3=y
 CONFIG_USB_DWC3_GENERIC=y
+# CONFIG_WATCHDOG is not set
+# CONFIG_WATCHDOG_AUTOSTART is not set
+CONFIG_WDT=y
 CONFIG_FS_CRAMFS=y
 CONFIG_ERRNO_STR=y
diff --git a/configs/odroid-m1s-rk3566_defconfig b/configs/odroid-m1s-rk3566_defconfig
index d59882a2a59..cda2f9fb539 100644
--- a/configs/odroid-m1s-rk3566_defconfig
+++ b/configs/odroid-m1s-rk3566_defconfig
@@ -30,6 +30,7 @@ CONFIG_CMD_PCI=y
 CONFIG_CMD_USB=y
 CONFIG_CMD_ROCKUSB=y
 CONFIG_CMD_USB_MASS_STORAGE=y
+CONFIG_CMD_WDT=y
 # CONFIG_CMD_SETEXPR is not set
 CONFIG_CMD_INI=y
 CONFIG_CMD_PMIC=y
@@ -87,5 +88,8 @@ CONFIG_USB_DWC3_GENERIC=y
 CONFIG_USB_GADGET=y
 CONFIG_USB_GADGET_DOWNLOAD=y
 CONFIG_USB_FUNCTION_ROCKUSB=y
+# CONFIG_WATCHDOG is not set
+# CONFIG_WATCHDOG_AUTOSTART is not set
+CONFIG_WDT=y
 CONFIG_FS_CRAMFS=y
 CONFIG_ERRNO_STR=y
-- 
2.53.0

