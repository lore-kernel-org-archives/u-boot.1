Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 642B1E99058
	for <u-boot@archiver.kernel.org>; Sat, 11 Apr 2026 07:09:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 47001841E6;
	Sat, 11 Apr 2026 09:09:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="iKpnYYFI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BBAFC84198; Fri, 10 Apr 2026 15:58:40 +0200 (CEST)
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com
 [IPv6:2607:f8b0:4864:20::843])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A61AE8416F
 for <u-boot@lists.denx.de>; Fri, 10 Apr 2026 15:58:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jcethrid@gmail.com
Received: by mail-qt1-x843.google.com with SMTP id
 d75a77b69052e-50b69bf5638so22742331cf.1
 for <u-boot@lists.denx.de>; Fri, 10 Apr 2026 06:58:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775829517; x=1776434317; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lHAkMTmekNWYDlx47qWSJ15HH9sRN6KSWiRhITbcCRA=;
 b=iKpnYYFIl8C+D5hg16zMLoJx51qX5GyDB6iTGNtmIwbddYoGHfco3ohO0ZJhqsjYvU
 XqafJRSL6eI9qu7vMw8WJkQXplLw7dAj66MCArWMzcVfPc604tFOqIE/qt11VLKXEge/
 KavH+3DQ03QglNxQQ3kkkbNvfsMkY8avNnhZZhYoiYJpIgdNUUJ2niSoUr8763wh5PDL
 rM5eLq8aG7qjySvL9UdQ13CA3tYYYZbTQa6ksQ0AoGs6YAhE08AfAP5JCFIiDJqgjRRT
 ckwFR5hCqDr5chtptByhgoHj2XtB4TG6AkGez5bExnS28BIp5uST+4BTn589ro1xyjHy
 2qng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775829517; x=1776434317;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=lHAkMTmekNWYDlx47qWSJ15HH9sRN6KSWiRhITbcCRA=;
 b=lt5fn9tOVv6cCXT769SCEhgbFa4fg4FmL5hIvkwWm55qnTcjfnqEZOaU+k5omJN4E6
 z0KLxq6TKv8/dHAzXE/evShkzIM9uB8SJ8s5W23+caJyt+osRx0Nz+Akf0dFsKBO4Kf+
 71JnFXnlqA6LLJkRQkAvp1R8LPGahSaQx47K/S8GLl7zqMq7PVr2U3VjJHFXByFcivCX
 KBu6siTINJNjuSenaULS+NdKxH+RS+Np0HHNcEiHIZQ+LP82fdC+0pNLKP4OPAFUy/Sb
 h6MewkJBS5p9KaAPsfeTO3F+SkvHZJuivOjs06xI1WhMsxlYjMfLYzGULPJY5S0VBVvA
 IgZA==
X-Gm-Message-State: AOJu0YxF17ksOeptDBDU3r8iVwDJZGAKo5xOkycr9DuOPiOO9rMSng6x
 FQlXwCTVYP7gM+vMrfck2icrnuvzVBMKkwqAiDCnaARQ4tZByKkA4Xejq+Q/zmph
X-Gm-Gg: AeBDiesJcNUCuZGeyWmwxvU5YNpc0QL6fX/Z81BOnTjRXd9NxuC4+BAuSG/+ecMNhQT
 Vya7U790Rrd3wQfaAzxG3qoJ9/XEwwTkcmBZp9k5+hGuIVJanqrsz6fWimE36/GX7aVSzxNEAGv
 o86giKbdydZZrn1aRPS1bXAOmb4TjfAW0+omSPfUmza38nZe8GSJItG5qnlTX0G8Tb0O1tua7CP
 0sbFYhIFiOQLdTG6HqcJZPQE2GTgKOQ3lF7/lAb4ri4G+SU60qfC4jhSFayzJMQl3KrBrfu1DdO
 i/Ly+d4+4CKKygQyrmba1RwtFatmI6D8K2hePEi7u+8R5znkWptx2y7NOSNvBUrvCtpFt3uHg2i
 ZfKcUTlyb+ww+fNJFA3mZIYNl53Ppic6LVG+2aBT2SaQ95TlF6wcskCactFrjGY70ZZLt9Q/LY0
 Lsx21eizYDGZt2kNQe7W1QtDJa/pdvQkaZ0B9fkWBP+WqW
X-Received: by 2002:a05:622a:3d0:b0:50b:1932:c9e with SMTP id
 d75a77b69052e-50dd5cc6a95mr45011171cf.39.1775829517249; 
 Fri, 10 Apr 2026 06:58:37 -0700 (PDT)
Received: from cethr-l01.localdomain ([136.56.120.109])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-50dd53f9c16sm21723141cf.11.2026.04.10.06.58.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Apr 2026 06:58:36 -0700 (PDT)
From: Caleb Ethridge <jcethrid@gmail.com>
To: u-boot@lists.denx.de
Cc: malysagreg@gmail.com, trini@konsulko.com, linux@analog.com,
 philip@philipmolloy.com, Caleb Ethridge <caleb.ethridge@analog.com>
Subject: [PATCH v4 05/14] mach-sc5xx: Add USB boot command
Date: Fri, 10 Apr 2026 09:58:00 -0400
Message-Id: <507ee64141154a4fe588a5e01f1b2d1b4e1fda09.1775829166.git.jcethrid@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1775829166.git.jcethrid@gmail.com>
References: <cover.1775829166.git.jcethrid@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 11 Apr 2026 09:08:55 +0200
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
 board/adi/sc573-ezkit/sc573-ezkit.env         | 1 +
 board/adi/sc589-ezkit/sc589-ezkit.env         | 1 +
 board/adi/sc589-mini/sc589-mini.env           | 1 +
 board/adi/sc594-som-ezkit/sc594-som-ezkit.env | 1 +
 board/adi/sc598-som-ezkit/sc598-som-ezkit.env | 1 +
 include/env/adi/adi_boot.env                  | 7 +++++++
 6 files changed, 12 insertions(+)

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

