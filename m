Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 606F9CA0EC4
	for <u-boot@archiver.kernel.org>; Mon, 11 Aug 2025 19:16:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 752C58304F;
	Mon, 11 Aug 2025 21:16:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="dyzT1LnO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A1EE68304F; Mon, 11 Aug 2025 21:16:11 +0200 (CEST)
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com
 [IPv6:2607:f8b0:4864:20::233])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6916183013
 for <u-boot@lists.denx.de>; Mon, 11 Aug 2025 21:16:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x233.google.com with SMTP id
 5614622812f47-433fd4aeeb8so3071234b6e.0
 for <u-boot@lists.denx.de>; Mon, 11 Aug 2025 12:16:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1754939768; x=1755544568; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=OYDBtavLlM8g6t97QQcw55d+1SEPjoFQ+caUkIfMKIc=;
 b=dyzT1LnOIkcO516ob36eDL9SHfXq7Waqe8RWV00XzxGCWgBsQM+7ppUY5fUBS5xuHL
 /ESKnmNWL9wTXMEXmp9y+z/1zJab2W5/4PenY9jispgM2mBpXY9dVQAdaqZrzPbs9ckA
 3498W3CG+EoFiSBbKcfX9OazLk4oMKw0dYUaA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754939768; x=1755544568;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=OYDBtavLlM8g6t97QQcw55d+1SEPjoFQ+caUkIfMKIc=;
 b=XwqOO3zH8zV8ppr1kOrx/NdKom6e0o0f0uO9IZlk5EnpVdEH889er05HFfOWEFQnST
 sexfkXiQlmsJwJrN1mi88LGOkSZQrAF5x1z5PfIY+c6H3xUjNwG8dueD2uQmDabv2+95
 KDN9WxRZUzcJxQKInuSjbI7g5GRdNU0KqXeL0Wk3W+EMttPNqkZyO+UdVElQnyql6wuv
 ijjj3GN6Gj5oR7sfFw/N9iVqoBtypm4VaE5eds0Ygalomg9kbOCS0NKVfRjkKFThfEsp
 Yo1p6PXSGn8drEoIjlqcQf4q7dxzO5pteX9AmQ/1M/c/UX1s3CcgR4pYDcLGpR5JkpfP
 u6Jw==
X-Gm-Message-State: AOJu0Yxq22UDv3gcNWsvcYx6EK72ZCX6zJPSgmuCeiq0Is7AjMDQ/UrV
 02COGujo1samTr4Zrv087tHWrulnt3hvPtRTkxeV09uIsr7k2g1he9GhBZYfcLBeegnhjbFwWbw
 z/I79ehU=
X-Gm-Gg: ASbGncvLqtXb9ATNQM1d5NXls/B66xYiy1daPm3DFWsGZZQ+f5gSqImi0PGMY0RKNlV
 4Vqalpyf8LLP9mBIjSXBIQPzkSX0JXIYzQxUVdJIXx1NLtKQ6dohojwJN8e1nw5iQobHU9KeBFs
 GkCim7RFnMlNQWUXR8lMOPVbQSTXBfnxyhOEUzBCXgkca+xyPqjyqzN1GIAVaT9tYfIfcgCIKq9
 DoyKR70IN3iMVZIeyY+TgRENurPzPQP9hU0oGUB/VlrwqqivA8zMRaQgYSU0WLXWXCjG6Dy4V/K
 +lB/9fg7curqwYs8QGSwfSue+wSI3J9sRCnZM/VllMnbdnZyqzeZsUsqxsGfgLVSZfjo9cWvGmG
 iiSYHiUyZFBHzmg2sRMarl6RgZAppXBAS6dJ920gTZ+rv3zgGQjhDjBblfIo=
X-Google-Smtp-Source: AGHT+IGWNhrgA3xbYzm+yv9sVQ479kAUR8VoTn/jtXU4QB8XmFUlJHHMV5zUVWHhL8Zq8Tw3HQeGRw==
X-Received: by 2002:a05:6808:1997:b0:435:744c:92ab with SMTP id
 5614622812f47-435c91e48c6mr427877b6e.30.1754939768088; 
 Mon, 11 Aug 2025 12:16:08 -0700 (PDT)
Received: from bill-the-cat.. (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-50ae99cf4ffsm2441834173.26.2025.08.11.12.16.07
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Aug 2025 12:16:07 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH] arm: socfpga: Correct how we set BOOTFILE
Date: Mon, 11 Aug 2025 13:16:06 -0600
Message-ID: <20250811191606.1577182-1-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
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

In order to set the BOOTFILE symbol we first need to have USE_BOOTFILE
be set, or some of the logic might not work as expected later on when
building. Second, defaults like this belong with the symbol itself.

Fixes: da595d236b97 ("include: configs: soc64: Use CONFIG_SPL_ATF to differentiate bootfile")
Signed-off-by: Tom Rini <trini@konsulko.com>
---
 arch/arm/Kconfig | 4 +---
 env/Kconfig      | 1 +
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index e7257ff3e03a..40368abc297e 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -22,9 +22,6 @@ config ARM64_CRC32
 	  not be present on all ARMv8.0, but is always present on ARMv8.1 and
 	  newer.
 
-config BOOTFILE
-	default kernel.itb if SPL_ATF && TARGET_SOCFPGA_SOC64
-
 config COUNTER_FREQUENCY
 	int "Timer clock frequency"
 	depends on ARM64 || CPU_V7A
@@ -1178,6 +1175,7 @@ config ARCH_SOCFPGA
 	select SYSRESET_SOCFPGA_SOC64 if !TARGET_SOCFPGA_AGILEX5 && \
            TARGET_SOCFPGA_SOC64
 	select SYSRESET_PSCI if TARGET_SOCFPGA_AGILEX5
+	select USE_BOOTFILE if SPL_ATF && TARGET_SOCFPGA_SOC64
 	imply CMD_DM
 	imply CMD_MTDPARTS
 	imply CRC32_VERIFY
diff --git a/env/Kconfig b/env/Kconfig
index c667e8f2da19..1df7ebd547e6 100644
--- a/env/Kconfig
+++ b/env/Kconfig
@@ -957,6 +957,7 @@ config USE_BOOTFILE
 
 config BOOTFILE
 	string "'bootfile' environment variable value"
+	default kernel.itb if SPL_ATF && TARGET_SOCFPGA_SOC64
 	depends on USE_BOOTFILE
 	help
 	  The value to set the "bootfile" variable to.
-- 
2.43.0

