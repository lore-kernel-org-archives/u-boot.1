Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1EB9FF885C
	for <u-boot@archiver.kernel.org>; Sat, 25 Apr 2026 16:56:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 191268425F;
	Sat, 25 Apr 2026 18:55:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="p9vgzRBB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 63F8B842BF; Sat, 25 Apr 2026 18:34:39 +0200 (CEST)
Received: from mail-ua1-x943.google.com (mail-ua1-x943.google.com
 [IPv6:2607:f8b0:4864:20::943])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 097C083FF5
 for <u-boot@lists.denx.de>; Sat, 25 Apr 2026 18:34:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jcethrid@gmail.com
Received: by mail-ua1-x943.google.com with SMTP id
 a1e0cc1a2514c-94aaa5d3bfcso5152868241.3
 for <u-boot@lists.denx.de>; Sat, 25 Apr 2026 09:34:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777134876; x=1777739676; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0rhjHCeHqsTChJ1NFRA8a2p8g2b1zBvajnobE5jxHoY=;
 b=p9vgzRBB5AbX9xMT0sK17k8DxCRrxFnzHlci6+rsxj/9KJ9vqwyxyLsYODqhdbYBQC
 pb2YmKa2h8qZoaIQeK14D03YvQv+30QgXHBr3J0AM5Lk10NowjssXRVXJ5ySqihSfoh7
 KLW7X4lj3RzKZBPG8sxXbLgf2JjKJiiaoyT/9LR44+MW3K3TuiIt8WlQf7jDHM5SzoH6
 jrEYb2XdqfG2k1Mv0w0Gi+nSkHA8L6tCiyzu2DvhQXV9wyS0qRUr/UzI+G52wntDSjCe
 FFzs+Lz+EoQw2/V9H+D3CJyDLdbX3oSFkY3gpjKCvCMFoEZhcr+InmUjJsBMsCyKY/WS
 f1tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777134876; x=1777739676;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=0rhjHCeHqsTChJ1NFRA8a2p8g2b1zBvajnobE5jxHoY=;
 b=cHLMpEZOr+Ne45uMikEARxiOHEQ9MWxyonmidECNBOSwykXfMevN5iuFj6mJIZam9T
 vV47UNL+I5WDi5AvD11ds8O6YZavzm1rGdPv7eTA4D+BT1myw9g1FJ6IOEeAYHr/GZao
 xVZqFHxCGQvMO+jP1JB0mWd/GUn4PGVXugMXAPSwcbvj0SdUcGh4+ncjCnaHHVmQuFxd
 c6zOICuk1ijdRk2W2Rs4IGFmJNYfvaO3yqN/U3QqoVN1GWzfZd43wV6d72aIaBB2eWjA
 78PJeoR0Z5uB2c2z8vfujKJY1eTseU3pOn97nNqGFSnhUL/GwXXv7U2ZMTaXv2521UoT
 cofw==
X-Gm-Message-State: AOJu0YxbtTXmd1VnZ7TL8varQpmhIPKSsrimfs5c5476nQRODnd02+fw
 RysmO8Cnuyh62kiOsgV4oAnri4J7gBhr/5PfsgHHnwPTm4L/DJC+uzxr8BUyM1wC
X-Gm-Gg: AeBDies1JXFlutkEnQAhLc11cA+nGWa67GGe0Xp1K1terhV4+QvOxY7evex4wLDyl5M
 GcvcoomD5y4xC4Ajx8tbAj6XXiZeN7VZJPcJ8MrGFuK+vX7Ky8OfGFKExj7RdkhvNdM4nZMPncy
 WL/IB8TrgC8LOduarHANJRZU8D8dTOgC3El+c2krXAcDq+/t96xi+MqMA9jqWOwEmxmYJ+oFPNO
 ENzCpXUggu+bYqAniY0JqZlm8f0aG5ATDYTksTpIUkS/SFMIgOVJza/xh1aPnNSZXFaHZcrtTZL
 wf2vnODSNXaqahGJFWjR4G4mjOT/DfxNrK+4g91i/NAq9TlVrSvPu1ZeKR0znPF0eCtWQMt6bn3
 VFiQL5jMPNXl6pC6F3VLtaYsCaPzVtqtKw4b7vlmc1TA+WGWpMvHKGX8nALT4WLJJFz4Px38zHm
 fxiS2hMbRjPzSi56Wq/efLhgw6wsgQX1P8HB2WFYs6ftwdNWO88QmZCz0=
X-Received: by 2002:ad4:5de5:0:b0:8ac:7ad3:4a66 with SMTP id
 6a1803df08f44-8b0280bbdd2mr437759456d6.21.1776954345724; 
 Thu, 23 Apr 2026 07:25:45 -0700 (PDT)
Received: from cethr-l01.localdomain ([136.56.120.109])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8b02aa4f1f9sm157183266d6.0.2026.04.23.07.25.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Apr 2026 07:25:45 -0700 (PDT)
From: Caleb Ethridge <jcethrid@gmail.com>
To: u-boot@lists.denx.de
Cc: malysagreg@gmail.com, trini@konsulko.com, linux@analog.com,
 philip@philipmolloy.com, sjg@chromium.org,
 Caleb Ethridge <caleb.ethridge@analog.com>
Subject: [PATCH v5 05/15] mach-sc5xx: Add USB boot command
Date: Thu, 23 Apr 2026 10:24:40 -0400
Message-Id: <bcf7a2612fb0be0814444ca70ed060052042e034.1776954004.git.jcethrid@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1776954004.git.jcethrid@gmail.com>
References: <cover.1776954004.git.jcethrid@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 25 Apr 2026 18:55:32 +0200
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

From: Caleb Ethridge <caleb.ethridge@analog.com>

Add the USB boot command to the environments
of the boards that support it.

Signed-off-by: Caleb Ethridge <caleb.ethridge@analog.com>
---
 board/adi/sc573-ezkit/sc573-ezkit.env           | 1 +
 board/adi/sc584-ezkit/sc584-ezkit.env           | 1 +
 board/adi/sc589-ezkit/sc589-ezkit.env           | 1 +
 board/adi/sc589-mini/sc589-mini.env             | 1 +
 board/adi/sc594-som-ezkit/sc594-som-ezkit.env   | 1 +
 board/adi/sc594-som-ezlite/sc594-som-ezlite.env | 1 +
 board/adi/sc598-som-ezkit/sc598-som-ezkit.env   | 1 +
 include/env/adi/adi_boot.env                    | 7 +++++++
 8 files changed, 14 insertions(+)

diff --git a/board/adi/sc573-ezkit/sc573-ezkit.env b/board/adi/sc573-ezkit/sc573-ezkit.env
index 51157ff36aa..36bd207f410 100644
--- a/board/adi/sc573-ezkit/sc573-ezkit.env
+++ b/board/adi/sc573-ezkit/sc573-ezkit.env
@@ -11,5 +11,6 @@ loadaddr=CONFIG_SC5XX_LOADADDR
 #define USE_SPI
 #define USE_RAM
 #define USE_MMC
+#define USE_USB
 
 #include <env/adi/adi_boot.env>
diff --git a/board/adi/sc584-ezkit/sc584-ezkit.env b/board/adi/sc584-ezkit/sc584-ezkit.env
index 6d4b20d70f6..9336fc4e59d 100644
--- a/board/adi/sc584-ezkit/sc584-ezkit.env
+++ b/board/adi/sc584-ezkit/sc584-ezkit.env
@@ -10,5 +10,6 @@ loadaddr=CONFIG_SC5XX_LOADADDR
 #define USE_NFS
 #define USE_SPI
 #define USE_RAM
+#define USE_USB
 
 #include <env/adi/adi_boot.env>
diff --git a/board/adi/sc589-ezkit/sc589-ezkit.env b/board/adi/sc589-ezkit/sc589-ezkit.env
index d068b44573f..a4a686158ca 100644
--- a/board/adi/sc589-ezkit/sc589-ezkit.env
+++ b/board/adi/sc589-ezkit/sc589-ezkit.env
@@ -11,5 +11,6 @@ loadaddr=CONFIG_SC5XX_LOADADDR
 #define USE_RAM
 #define USE_MMC
 #define USE_SPI
+#define USE_USB
 
 #include <env/adi/adi_boot.env>
diff --git a/board/adi/sc589-mini/sc589-mini.env b/board/adi/sc589-mini/sc589-mini.env
index 3827cf4e9a5..2a322bc6761 100644
--- a/board/adi/sc589-mini/sc589-mini.env
+++ b/board/adi/sc589-mini/sc589-mini.env
@@ -11,5 +11,6 @@ loadaddr=CONFIG_SC5XX_LOADADDR
 #define USE_RAM
 #define USE_SPI
 #define USE_MMC
+#define USE_USB
 
 #include <env/adi/adi_boot.env>
diff --git a/board/adi/sc594-som-ezkit/sc594-som-ezkit.env b/board/adi/sc594-som-ezkit/sc594-som-ezkit.env
index 69d2ec3ba03..a4c72f2e9c7 100644
--- a/board/adi/sc594-som-ezkit/sc594-som-ezkit.env
+++ b/board/adi/sc594-som-ezkit/sc594-som-ezkit.env
@@ -12,5 +12,6 @@ loadaddr=CONFIG_SC5XX_LOADADDR
 #define USE_OSPI
 #define USE_RAM
 #define USE_MMC
+#define USE_USB
 
 #include <env/adi/adi_boot.env>
diff --git a/board/adi/sc594-som-ezlite/sc594-som-ezlite.env b/board/adi/sc594-som-ezlite/sc594-som-ezlite.env
index f915175e041..e312fc95ae4 100644
--- a/board/adi/sc594-som-ezlite/sc594-som-ezlite.env
+++ b/board/adi/sc594-som-ezlite/sc594-som-ezlite.env
@@ -12,5 +12,6 @@ loadaddr=CONFIG_SC5XX_LOADADDR
 #define USE_OSPI
 #define USE_RAM
 #define USE_MMC
+#define USE_USB
 
 #include <env/adi/adi_boot.env>
diff --git a/board/adi/sc598-som-ezkit/sc598-som-ezkit.env b/board/adi/sc598-som-ezkit/sc598-som-ezkit.env
index b6f477c8402..754dcece976 100644
--- a/board/adi/sc598-som-ezkit/sc598-som-ezkit.env
+++ b/board/adi/sc598-som-ezkit/sc598-som-ezkit.env
@@ -12,5 +12,6 @@ loadaddr=CONFIG_SC5XX_LOADADDR
 #define USE_OSPI
 #define USE_RAM
 #define USE_MMC
+#define USE_USB
 
 #include <env/adi/adi_boot.env>
diff --git a/include/env/adi/adi_boot.env b/include/env/adi/adi_boot.env
index eb098dd2256..d6caa95325e 100644
--- a/include/env/adi/adi_boot.env
+++ b/include/env/adi/adi_boot.env
@@ -68,3 +68,10 @@ ramboot= wget ${loadaddr} ${serverip}:/fitImage;
 	run ramargs;
 	bootm ${loadaddr}
 #endif
+
+#if defined(USE_USB)
+usbargs=setenv bootargs root=/dev/sda2 rw rootfstype=ext4 rootwait ${adi_bootargs}
+usbboot=usb start;
+	ext4load usb 0:1 ${loadaddr} /fitImage; run usbargs;
+	bootm ${loadaddr}
+#endif
-- 
2.34.1

