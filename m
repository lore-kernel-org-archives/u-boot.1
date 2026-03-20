Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C26DF1098782
	for <u-boot@archiver.kernel.org>; Fri, 20 Mar 2026 13:07:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1121A84035;
	Fri, 20 Mar 2026 14:06:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="NGfA/ejQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 24C8783CF5; Fri, 20 Mar 2026 13:52:47 +0100 (CET)
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com
 [IPv6:2607:f8b0:4864:20::f43])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DDBEE83CEA
 for <u-boot@lists.denx.de>; Fri, 20 Mar 2026 13:52:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jcethrid@gmail.com
Received: by mail-qv1-xf43.google.com with SMTP id
 6a1803df08f44-899ee491af3so21848926d6.1
 for <u-boot@lists.denx.de>; Fri, 20 Mar 2026 05:52:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1774011164; x=1774615964; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=z36/pBdP+0WyCp4eyCgU4weNUeh3cpEIhILICmbnPa4=;
 b=NGfA/ejQi0nNDHk9L9oov3e9410V7Ltjqb9oRXMWulIhSaA1L6oI9xnfoyB6JxV94W
 +kz/roPYWisDOvYInmCLPaHdnXTIBJbl9bwurddNHK2xNpe9PYOGHJrDpG18XMa884Qr
 FVtHdRTaB9BfBCA85zixu/z3tEVi0OuKi5iF02n6UxQjeOQC0OP8KGwyV5MuDZRVqvRC
 PkVo9BFmgVPX4yv9U1jesp6WUpyVLLon2JO4g4QyGei3X+97bAg9ki7GNkJYRa3prFln
 expMu4JYgBXebh0GAY83D0BOhP1OkKH3IFACofIEf5Offhji/8z7jMVSj1D83INlcuXo
 +TrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774011164; x=1774615964;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=z36/pBdP+0WyCp4eyCgU4weNUeh3cpEIhILICmbnPa4=;
 b=QW206pQKXVGZ9Rv0OZqpI96SZa6NhA/EmXAQXU0OxX6RjB88gMkNRIUsxVZKzo3wWt
 UyY1ym7vbPuludsvXzbNl49lDFCKPUD/fnutgQtsoKw3sOItMzNipRBpPYA3U18Z4uQU
 Ph8wyt5LKcUqekP3ne/+w91tmQqFU12YuVdlKKpATE6jxZzaAd8O8zKe7Z+udnkAuT6Z
 Me+VH5oRsvHDNn84cirJMMUBRukb8WSC0aFLDiaRFF0CleN0WeDZ1+tbv4KDoa1SP1xq
 UhmpDjgJ22dOHw7iQQK/3xI3+ciXIdtVCwA1OCVOsO4bg4CBOZaiEo1joE9d5woIrP/Z
 FvpA==
X-Gm-Message-State: AOJu0Yx/pyOBMzJwQ49V9lYB9P+exAsLgAJhKRuMMTJqhoNneaWXp9wF
 jeWtrFfkzyOqvBL55TKmf2ns3CWXc//D8/4k/X1F8YREM6IvazmGC089txMcpOiljcK8Mw==
X-Gm-Gg: ATEYQzw36D/LF9eR7w8WCSgyOI40X43cTG2SVkk4CAKp1mSQNSMnjYcKm8ALEIJhFEn
 tzn1mPrrZQ5Tc7ljTSkm8RSUQ2TBTh9KjCcCcP0m5Ys+7dYIyQ+thVNT/paDsXYvEumFZvIwnDT
 f9Ix5/Pyvbv9ztylWDJi5soWHjVPTkS/LMGWqhJuu7h3YhuekoiQmghq456Hefk35fhE6r7SCGD
 2CtnV9guwFSP4kBRAZSC7XqcMzlePX4QzHa+a0lXqb6SvYOD8SuuhmWLiU+gwaS7q78tNMBsR3G
 JQRTVCY4AY7RnBMUn3kJG2kFIKtxZkLEJEU0BfUHOGwxosUh3ZGf8iCdMUE7cSHhV3AyF7bFMtC
 hAYuVzjsgAF0nBUmvnOy/UIkuArYkrZGSuhgKRoBk1WLcUpfquU514xDlkrUEN8g26C5rqscODk
 PBQTyzAIkNTOx/7ZXa/fUAIwac+j4k6Bnr2A==
X-Received: by 2002:a05:6214:3019:b0:89a:249:d2c1 with SMTP id
 6a1803df08f44-89c85a620e3mr38138696d6.51.1774011163647; 
 Fri, 20 Mar 2026 05:52:43 -0700 (PDT)
Received: from cethr-l01.localdomain ([136.56.120.109])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-89c8537c3b5sm19168166d6.47.2026.03.20.05.52.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Mar 2026 05:52:43 -0700 (PDT)
From: Caleb Ethridge <jcethrid@gmail.com>
To: u-boot@lists.denx.de
Cc: malysagreg@gmail.com, philip@philipmolloy.com, trini@konsulko.com,
 linux@analog.com, Caleb Ethridge <caleb.ethridge@analog.com>
Subject: [PATCH 05/11] mach-sc5xx: Add USB boot command
Date: Fri, 20 Mar 2026 08:50:20 -0400
Message-Id: <9a01a335c3eb2d8e3a471da81496cf619aec65ff.1774008927.git.jcethrid@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1774008927.git.jcethrid@gmail.com>
References: <cover.1774008927.git.jcethrid@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 20 Mar 2026 14:06:14 +0100
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
index 88766870c1a..74eaa23a1c3 100644
--- a/board/adi/sc573-ezkit/sc573-ezkit.env
+++ b/board/adi/sc573-ezkit/sc573-ezkit.env
@@ -13,5 +13,6 @@ loadaddr=CONFIG_SC5XX_LOADADDR
 #define USE_SPI
 #define USE_RAM
 #define USE_MMC
+#define USE_USB
 
 #include <env/adi/adi_boot.env>
diff --git a/board/adi/sc589-ezkit/sc589-ezkit.env b/board/adi/sc589-ezkit/sc589-ezkit.env
index f49d30e88e2..a15a446eb71 100644
--- a/board/adi/sc589-ezkit/sc589-ezkit.env
+++ b/board/adi/sc589-ezkit/sc589-ezkit.env
@@ -13,5 +13,6 @@ loadaddr=CONFIG_SC5XX_LOADADDR
 #define USE_RAM
 #define USE_MMC
 #define USE_SPI
+#define USE_USB
 
 #include <env/adi/adi_boot.env>
diff --git a/board/adi/sc589-mini/sc589-mini.env b/board/adi/sc589-mini/sc589-mini.env
index c741896601a..c6f7e491f32 100644
--- a/board/adi/sc589-mini/sc589-mini.env
+++ b/board/adi/sc589-mini/sc589-mini.env
@@ -13,5 +13,6 @@ loadaddr=CONFIG_SC5XX_LOADADDR
 #define USE_RAM
 #define USE_SPI
 #define USE_MMC
+#define USE_USB
 
 #include <env/adi/adi_boot.env>
diff --git a/board/adi/sc594-som-ezkit/sc594-som-ezkit.env b/board/adi/sc594-som-ezkit/sc594-som-ezkit.env
index d314e1117b5..a15793a279f 100644
--- a/board/adi/sc594-som-ezkit/sc594-som-ezkit.env
+++ b/board/adi/sc594-som-ezkit/sc594-som-ezkit.env
@@ -14,5 +14,6 @@ loadaddr=CONFIG_SC5XX_LOADADDR
 #define USE_OSPI
 #define USE_RAM
 #define USE_MMC
+#define USE_USB
 
 #include <env/adi/adi_boot.env>
diff --git a/board/adi/sc598-som-ezkit/sc598-som-ezkit.env b/board/adi/sc598-som-ezkit/sc598-som-ezkit.env
index 525e0f3547b..17a6d19c306 100644
--- a/board/adi/sc598-som-ezkit/sc598-som-ezkit.env
+++ b/board/adi/sc598-som-ezkit/sc598-som-ezkit.env
@@ -14,5 +14,6 @@ loadaddr=CONFIG_SC5XX_LOADADDR
 #define USE_OSPI
 #define USE_RAM
 #define USE_MMC
+#define USE_USB
 
 #include <env/adi/adi_boot.env>
diff --git a/include/env/adi/adi_boot.env b/include/env/adi/adi_boot.env
index 4d4a76729dc..b04bd1ba20e 100644
--- a/include/env/adi/adi_boot.env
+++ b/include/env/adi/adi_boot.env
@@ -67,3 +67,10 @@ ramboot= wget ${loadaddr} ${serverip}:/fitImage;
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

