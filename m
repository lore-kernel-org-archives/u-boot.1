Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22D0AD6AAE7
	for <u-boot@archiver.kernel.org>; Thu,  2 Apr 2026 15:49:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B4ADC8416F;
	Thu,  2 Apr 2026 17:48:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="U7WvRdnr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A52B9839DF; Thu,  2 Apr 2026 17:29:06 +0200 (CEST)
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com
 [IPv6:2607:f8b0:4864:20::741])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BDBC783CF5
 for <u-boot@lists.denx.de>; Thu,  2 Apr 2026 17:28:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jcethrid@gmail.com
Received: by mail-qk1-x741.google.com with SMTP id
 af79cd13be357-8cb4136d865so131664885a.1
 for <u-boot@lists.denx.de>; Thu, 02 Apr 2026 08:28:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775143737; x=1775748537; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lHAkMTmekNWYDlx47qWSJ15HH9sRN6KSWiRhITbcCRA=;
 b=U7WvRdnr2Xbywux52qfpBwmudWeYNeZsOqaT3CMWO8WwXQopAVCX+q2HI9OKmz54FW
 Rsx/bchtSSbYlH0JcKTv5g1X6tBAKlPvSfuXdlIkxEA5oHwKSh7HhXSHtNtcMLZEONsk
 rWPsg9g8yyOZS0ZLzt1ih9OoNA/zhGkynX8OFtBu+jfCY99UO0zCxinjFKpWbOFgYvmZ
 BznHaKJc9RGSgmk8n08I+/9jKLsU8AChKMlwpWHZWN09Oj/DwEfm1gY0gE3d8hnHAvGG
 rr7RhWVnGwsFxcMmWYklJdVzNGOlrsefTSJqvqeo9aWJH+JxNkYK77ybXi2DV4GLwaCw
 4Knw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775143737; x=1775748537;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=lHAkMTmekNWYDlx47qWSJ15HH9sRN6KSWiRhITbcCRA=;
 b=YRUi+9E3jWKBLhvyp7f/GnDYs23X9OqjfWHnSMcic+x7yQ249eSd1RTr89vcUsgbW/
 +nv/9C5O5paMPJu1bWI1gLiXhg/rCokL/NqrXgkZdbG66CqzKL/L+KtOacs9rYxahBTt
 vmfLrT3iqnOpZ+I9cHShvN78QW+wu4zv8758mbjs4Xpc9c6mBG3tW6pZCUi7ewxQ/LM2
 2PGugi04w5txUjKM1UiHaHTjWvSBRuCAJ+PtTPTNZJy2k/3Io7zBMnDwu/NMF32wq6hs
 LlAxYd+/N6BYSwbkqsF1xS+6QbC59GJmi6zEP0sfIxmFCpeu8FJktE5/9bomN+r6toOe
 97uQ==
X-Gm-Message-State: AOJu0Yx4ypMn6rdqFHFMZYxTiplcK/8wx+RMOEp8fCLb0omqIswBJBpz
 h6sMFUbDKju2IVZbqfFcTaE1ntuIH5AlRtTA2kPKKDQZn3Q53F+lnhTzmXe2Bt/Q
X-Gm-Gg: ATEYQzyUmbGLoY3OtkEXW8/7MbHoXX42uob6DNFiToarXMrRV8QeeIP6CQqXEl+b/g8
 ynwZhYvoTdO+Wz3sE5v0XnGbIClsq06szDGiK2ueIcmXeCcRCj4/OSXjCCnGC6mOasVu+lF0pQm
 ksgAT+AfAZf2y0cJ6X8L/Hx2jPKdJbyOhXafywK1b1ddestNv+rkd4vUBThRI+4PbFdjsySCmht
 P6wWJ6OSwxHJxHma5pRECbwhgbI/msDhK1khfrAFbfTEt1aDPanYN+OltYW98Q1JMJPrA6Y2zJL
 H8Ri+qwTzZAPKJaxqkDvHfK6Opx/V6MXWtqFrmMpCUOQr3097otkGrTnKq9Y/pcr0lobOuuCh/A
 gmFKe8RFCeXRzbrPGcTbZ/8Cgqbu+DTMmRsFgoQHENrwIw3wGlXBHvYh6bC8UyOUteyuUrkGyS2
 W8MHX08Lxql/WLg8d+FLoXFd85QpR/1iM3mw==
X-Received: by 2002:a05:620a:1a22:b0:8cf:df8b:1e51 with SMTP id
 af79cd13be357-8d1b5b08864mr1176209585a.28.1775143737461; 
 Thu, 02 Apr 2026 08:28:57 -0700 (PDT)
Received: from cethr-l01.localdomain ([136.56.120.109])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8d2a5393a07sm239037485a.4.2026.04.02.08.28.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Apr 2026 08:28:57 -0700 (PDT)
From: Caleb Ethridge <jcethrid@gmail.com>
To: u-boot@lists.denx.de
Cc: malysagreg@gmail.com, trini@konsulko.com, linux@analog.com,
 philip@philipmolloy.com, Caleb Ethridge <caleb.ethridge@analog.com>
Subject: [RESEND v2 05/13] mach-sc5xx: Add USB boot command
Date: Thu,  2 Apr 2026 11:28:28 -0400
Message-Id: <004cd6c2c2d38df036ebbef8897a22ea3c8bbfcc.1775143241.git.jcethrid@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1775143241.git.jcethrid@gmail.com>
References: <cover.1775143241.git.jcethrid@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 02 Apr 2026 17:48:00 +0200
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

