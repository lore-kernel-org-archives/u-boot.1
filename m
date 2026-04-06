Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C80BF46C79
	for <u-boot@archiver.kernel.org>; Mon,  6 Apr 2026 19:47:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1EC0784132;
	Mon,  6 Apr 2026 21:46:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="HMzz6D1l";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5ED5083FA3; Mon,  6 Apr 2026 21:21:35 +0200 (CEST)
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com
 [IPv6:2607:f8b0:4864:20::841])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4610B8352B
 for <u-boot@lists.denx.de>; Mon,  6 Apr 2026 21:21:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jcethrid@gmail.com
Received: by mail-qt1-x841.google.com with SMTP id
 d75a77b69052e-50d880e6fbbso16199221cf.0
 for <u-boot@lists.denx.de>; Mon, 06 Apr 2026 12:21:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775503292; x=1776108092; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lHAkMTmekNWYDlx47qWSJ15HH9sRN6KSWiRhITbcCRA=;
 b=HMzz6D1l1Hsx+d4qLPSACNzvSC/RWXD1IPbwbj06oN+hAk0wcYzuAu2oLT23sLuazc
 VDyHPn13NjfZtVbLU6QSuiKI1xqGx6umRBJSCOk2lWSllomiPHb3VQv8SLaCAoFPMKQH
 /yObZh/hd9gVezbEeSsWj+PxY+EO67H/8JwU7gQb2qk/7GmzpT2pbjl0RWbenVfisEg/
 uk7MyuQUy1Kb+4q3K554naQ9yCtF1F4GLdI+sZ2cm+V6CF98+5PkotSauhvdo2mIxlWn
 2ReSinF7GbvERQbsYwUTvvqbOEYTezsNGVxtPXNDQ6BLDhivXUjX+iHz1aUXS2FB6BIG
 WaUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775503292; x=1776108092;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=lHAkMTmekNWYDlx47qWSJ15HH9sRN6KSWiRhITbcCRA=;
 b=cKwSPSEfU3ugQ21mKACb47NlkbtR5q07uP1hTbnmoS9EeMtQjpxciyrkRwChlmDKVj
 QyxxbUQTf9zbeci3go6ggDVYzclpgnsuaTMk0cqIPr5d9tZrUUOKRlNXp2VVbnd8kSKX
 zS+MaSv2SLqRx8MDdNcsPd7me1Y/XHV96GfVK/pRw8hPun3vsl+kmHHRyIQ9KXRfk+/R
 gaWHZgxFd9mnBUvocXexE3UGr0h34a5fMR/lYUL6lG7D7FyYDLKtuVRFyPv+8GlmWvCW
 +T6eXSRxvKsnGSFg3Z3EfMe3saLJlD+bm+W1p6q3sJqXccSa/FTWhrb0LpJ3baHXKMms
 mjzA==
X-Gm-Message-State: AOJu0Ywrzj1dseoFAXTGBKGVhRrl5e7HuIbyNlgOq1CQJkxoZ77A08bT
 WdW7ZcBTS6Dyc3q7Z7/Qh73v7LfL2slOzQX4+NF6XtBAjkkfc1WXWsdqT9lDSiiS
X-Gm-Gg: AeBDieuPbw0OfxQIEfpzTkjG/EDQaUU1rAbIsTLdK3VBoR2NMNkjGoZ4Ywd66uQgANp
 V/Ts58trbV0yUE6wvK4ii355dt+vepg5IaVR3a2BRYau0Du7f5zbbGkLEQoZE3Q1Vl5O5M/0Hp8
 vTvhHACxcpZxwwwBVf0F/DQZ1iGNqSq0CIgyCOm8ko9Yp+qKdf9Y2+XrwVDcf9QT7oNO49Cerdp
 TyCTO0X7jGU45bHcfxECzW7MLs+xW2JL9OIPfF/n0/xXgwpzUaaBZK61DWPJphcjzfqLKhLSpl5
 a7nK0a3gFpPDuh54qUtdz2SU4T2nJVdL80LKM1GPdXVMEOvKMvhzaPTSTaBBhe2tEQL3cQA/VKH
 8L4oDRPxcKzSWj7cR3wnocyj9obCoibR4H/1MQFdVNRJ8tXbhpmbNOWnL9kbdeXziBi0h1hv3rg
 mO1Pogr1KLY6F5UDEhtgTiyVFuLMt7nqtjLA==
X-Received: by 2002:ac8:5a07:0:b0:50b:2dd5:2be with SMTP id
 d75a77b69052e-50d4fa82089mr224889191cf.13.1775503291876; 
 Mon, 06 Apr 2026 12:21:31 -0700 (PDT)
Received: from cethr-l01.localdomain ([136.56.120.109])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8a596e03dc6sm150191166d6.34.2026.04.06.12.21.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Apr 2026 12:21:31 -0700 (PDT)
From: Caleb Ethridge <jcethrid@gmail.com>
To: u-boot@lists.denx.de
Cc: malysagreg@gmail.com, trini@konsulko.com, linux@analog.com,
 philip@philipmolloy.com, Caleb Ethridge <caleb.ethridge@analog.com>
Subject: [PATCH v3 05/13] mach-sc5xx: Add USB boot command
Date: Mon,  6 Apr 2026 15:06:07 -0400
Message-Id: <bce64919c7f442c9ff1fc1f3989fa1edcabe3c52.1775500819.git.jcethrid@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1775500819.git.jcethrid@gmail.com>
References: <cover.1775500819.git.jcethrid@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 06 Apr 2026 21:46:28 +0200
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

