Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1AB9C02187
	for <u-boot@archiver.kernel.org>; Sun, 19 Jan 2025 18:50:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1B24C801CF;
	Sun, 19 Jan 2025 19:50:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=manjaro.org header.i=@manjaro.org header.b="JJxH+5uI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 73F7F801F5; Sun, 19 Jan 2025 19:50:19 +0100 (CET)
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 10B3A800CF
 for <u-boot@lists.denx.de>; Sun, 19 Jan 2025 19:50:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=manjaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dsimic@manjaro.org
From: Dragan Simic <dsimic@manjaro.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
 t=1737312616;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=Ks0uVjhbTMEDYQA+9qMkC2FxxscIhiDdpqNL246mPaY=;
 b=JJxH+5uIIpSqt1jUBtvQ16uUu6dNSTAdMX36kk6+ca0MY0tTh0lzOjV3qK4/ANx9GEOgXV
 odRn/+OktP/+Y/9A1zHZEOyo/p6H6dG8+caiZQquU1JYx0bohHytdswQ7gfuITvEBazzbc
 Dw8n6yx0zGzHtLjAvJVaeVbNdY/6KLDClEaQV4MC18I2hcHF5l0csxSxFJksNN7eUzTj0X
 0HZGNMVbIlrsBYYTq3DrLAe3U9bAnKvU+d5anLn19PKKk4VlEQsTCKJLiwbtlDjMlNO147
 2GAHxDu2cE6pDqnNRnnIlxVnURrVvfPYzfwWpj43dIQKSY9o2ZP003bk5VeZ1g==
To: u-boot@lists.denx.de
Cc: marex@denx.de, Dang Huynh <danct12@riseup.net>,
 Piotr Zalewski <pZ010001011111@proton.me>
Subject: [PATCH] usb: Make what it takes for "usbkbd" to work in "stdin" clear
Date: Sun, 19 Jan 2025 19:50:02 +0100
Message-Id: <4079f51c0141711cb4cb27f7aeb050b1b1e17828.1737312317.git.dsimic@manjaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
 auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org
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

Selecting the CONFIG_SYS_CONSOLE_ENV_OVERWRITE option actually prevents the
CONFIG_USB_KEYBOARD option from working as expected, i.e. USB keyboards end
up not working as console inputs when "usbkbd" is properly specified as part
of the value of the "stdin" environment variable.  Describe this clearly in
the two relevant Kconfig files, to prevent any possible confusion.

In more detail, the console_init_r() function ends up overwriting the "stdin"
environment variable so it contains only the devices available at that point
(which doesn't include "usbkbd"), while the "usb start" operation is performed
much later, at which point the probe_usb_keyboard() function cannot assign any
discovered USB keyboards to the console because "usbkbd" is no longer present
in the "stdin" environment variable.

Reported-by: Dang Huynh <danct12@riseup.net>
Co-developed-by: Piotr Zalewski <pZ010001011111@proton.me>
Signed-off-by: Piotr Zalewski <pZ010001011111@proton.me>
Signed-off-by: Dragan Simic <dsimic@manjaro.org>
---
 common/Kconfig      | 7 +++++++
 drivers/usb/Kconfig | 3 ++-
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/common/Kconfig b/common/Kconfig
index 0e8c44f3f745..267a646e9d4e 100644
--- a/common/Kconfig
+++ b/common/Kconfig
@@ -297,6 +297,13 @@ config SYS_CONSOLE_ENV_OVERWRITE
 	  start-up (after relocation). This causes the environment to be
 	  updated to match the console devices actually chosen.
 
+	  When selected, USB keyboards will not be registered as console
+	  input devices regardless of the proper environment settings, i.e.
+	  despite properly having "usbkbd" as part of the value of the
+	  "stdin" environment variable.
+
+	  If unsure, say N.
+
 config SYS_CONSOLE_INFO_QUIET
 	bool "Don't display the console devices on boot"
 	help
diff --git a/drivers/usb/Kconfig b/drivers/usb/Kconfig
index 960b6a906ac4..4d52e382f570 100644
--- a/drivers/usb/Kconfig
+++ b/drivers/usb/Kconfig
@@ -106,7 +106,8 @@ config USB_KEYBOARD
 	select SYS_STDIO_DEREGISTER
 	---help---
 	  Say Y here if you want to use a USB keyboard for U-Boot command line
-	  input.
+	  input.  Also say N for SYS_CONSOLE_ENV_OVERWRITE and see the help for
+	  that option for more details.
 
 config USB_ONBOARD_HUB
 	bool "Onboard USB hub support"
