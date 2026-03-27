Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B745D10F284B
	for <u-boot@archiver.kernel.org>; Fri, 27 Mar 2026 16:25:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9AACF84073;
	Fri, 27 Mar 2026 17:24:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="oWjOsdw2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3349D83DBF; Fri, 27 Mar 2026 14:51:50 +0100 (CET)
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com
 [IPv6:2607:f8b0:4864:20::842])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1DE6C83C14
 for <u-boot@lists.denx.de>; Fri, 27 Mar 2026 14:51:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jcethrid@gmail.com
Received: by mail-qt1-x842.google.com with SMTP id
 d75a77b69052e-505a1789a27so11441741cf.3
 for <u-boot@lists.denx.de>; Fri, 27 Mar 2026 06:51:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774619507; x=1775224307; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=T5Y/CtJfZFddx/akZCAToS06GB4MrNGXJ4EklZvgvio=;
 b=oWjOsdw2gcrD32Hkb1e2BWqFpukbkPFzfOsn8LtXyxOKO8d+NirQa6NEfC2Oe5ozVd
 eRSptYGGv6Sea6ldapN+xO8+/89RijbdcczL8gNLKAOnZBo04gHcj5PcyISSdMR3XqPp
 i+HPZU73GkYP43gId5Y5ZKxyPUZq7rk7/vYwAGkockLIQJhq3U4KUQheifwp5eO++jKq
 Y/c2iRMV/NB2T+OoltaYrA9988nfGOusHiB93qiTykm0OTwGewq7mUmO0BbatsBemn0Q
 K+zVU71LroHY/OY2w4AmWItGZB865lj3mBc1Genm1nAIk02jZtOv2QC0aOjfIATFyYqM
 cjEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774619507; x=1775224307;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=T5Y/CtJfZFddx/akZCAToS06GB4MrNGXJ4EklZvgvio=;
 b=Pxyy39Pp4pRoWh6I1MS1hTsWqFvoIJzI0wq1uXRTKl9u2HDIjuu75wFkXoED/pkfpG
 H+gfzRvmTybHsM048U2p9TdYwVAi42Yw3Cud+6ihDGoJhIPCNGxl8D2QMSkS5UInoqT3
 nf1KMo4NwyGYrdueYkr0a5rGXAcoZKbDDQ1UTnGSVJ8SmxPMAN7WtcAhDM75lSOY54Xr
 tuUvojYCtSqGhSmuJYCBoikr4iUeoN6ibdIMHm8mEgk9DCq90/ZGo0qlUoNEN7yhwbXo
 avooGE1Oo6BhApLpfQcJaaxtCONeYVB7DUzOpAoXZKs88NjanX1vvDpuxBVbbwYx2Crc
 u8Ew==
X-Gm-Message-State: AOJu0Yz0/59tE0bVqmE+XT3zU7OmbHD/1A0gszQ1QC5sw8NFYDPM/uf6
 NU6TGcZQqyK2IjPdfZ++6sJIAWjDPnJNu5nlzQL16NY+ANfeNUItRuM9cpLNnRfe
X-Gm-Gg: ATEYQzzgQuS0jWDqS6Qsu75ZcazFkAR470VuXOFptzT59NfxlnQzoVWoHVzykf/jzWW
 2wwztGH+T9yqvhDY1AQc4MPozuZPIIue/AkG7tK56u1X2SNRoKep6lGaRy9Wo7aNb50SSpjb859
 cHmsnJqLoJtI9vpfgAe1qxf0bW8qb7mcnLeOI0uRvkORJJzzsqB3aeNrSHtseBt2Kz1hVSwEWWJ
 VhkfFUp28szF2t93yx3Nu2JonHeop2RZFketjDHlXufAI6JooEUxpF6r2Q8/fmg3RoDiUnuRWLC
 LiQ+l73zbAw401ZnVLaMRce9jw28QFrp9cFfcs5hz5Nbac6AaMistyicesQxGkouGYr1kf+ARZo
 T7yZ8/ZUxp3ZdKbVJDi7oxR0Dg052bFkpthIc6zWNgf27nao+lf4+v7pgvS2tVENiu9hzTGaO3L
 Dd9h3xfV0uN8tCDJO7yC5jmOfoRioH+V8rtg==
X-Received: by 2002:a05:622a:120a:b0:50b:2d93:97b2 with SMTP id
 d75a77b69052e-50ba384c851mr35605531cf.23.1774619506754; 
 Fri, 27 Mar 2026 06:51:46 -0700 (PDT)
Received: from cethr-l01.localdomain ([136.56.120.109])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-89cd588969dsm48691356d6.12.2026.03.27.06.51.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Mar 2026 06:51:46 -0700 (PDT)
From: Caleb Ethridge <jcethrid@gmail.com>
To: u-boot@lists.denx.de
Cc: malysagreg@gmail.com, trini@konsulko.com, linux@analog.com,
 philip@philipmolloy.com, Caleb Ethridge <caleb.ethridge@analog.com>
Subject: [PATCH v2 05/13] mach-sc5xx: Add USB boot command
Date: Fri, 27 Mar 2026 09:49:20 -0400
Message-Id: <a43bbaf5c01d698a5bc1fafd5c6c0b0bad78cc56.1774618658.git.jcethrid@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1774618658.git.jcethrid@gmail.com>
References: <cover.1774618658.git.jcethrid@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 27 Mar 2026 17:24:39 +0100
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
index 9562b9a68a8..14e875f2927 100644
--- a/board/adi/sc573-ezkit/sc573-ezkit.env
+++ b/board/adi/sc573-ezkit/sc573-ezkit.env
@@ -12,5 +12,6 @@ loadaddr=CONFIG_SC5XX_LOADADDR
 #define USE_SPI
 #define USE_RAM
 #define USE_MMC
+#define USE_USB
 
 #include <env/adi/adi_boot.env>
diff --git a/board/adi/sc589-ezkit/sc589-ezkit.env b/board/adi/sc589-ezkit/sc589-ezkit.env
index 43f5d7a5565..2603d92c45a 100644
--- a/board/adi/sc589-ezkit/sc589-ezkit.env
+++ b/board/adi/sc589-ezkit/sc589-ezkit.env
@@ -12,5 +12,6 @@ loadaddr=CONFIG_SC5XX_LOADADDR
 #define USE_RAM
 #define USE_MMC
 #define USE_SPI
+#define USE_USB
 
 #include <env/adi/adi_boot.env>
diff --git a/board/adi/sc589-mini/sc589-mini.env b/board/adi/sc589-mini/sc589-mini.env
index 7726939946d..7390fb5fd6f 100644
--- a/board/adi/sc589-mini/sc589-mini.env
+++ b/board/adi/sc589-mini/sc589-mini.env
@@ -12,5 +12,6 @@ loadaddr=CONFIG_SC5XX_LOADADDR
 #define USE_RAM
 #define USE_SPI
 #define USE_MMC
+#define USE_USB
 
 #include <env/adi/adi_boot.env>
diff --git a/board/adi/sc594-som-ezkit/sc594-som-ezkit.env b/board/adi/sc594-som-ezkit/sc594-som-ezkit.env
index e3f25043856..62d23e8637f 100644
--- a/board/adi/sc594-som-ezkit/sc594-som-ezkit.env
+++ b/board/adi/sc594-som-ezkit/sc594-som-ezkit.env
@@ -13,5 +13,6 @@ loadaddr=CONFIG_SC5XX_LOADADDR
 #define USE_OSPI
 #define USE_RAM
 #define USE_MMC
+#define USE_USB
 
 #include <env/adi/adi_boot.env>
diff --git a/board/adi/sc598-som-ezkit/sc598-som-ezkit.env b/board/adi/sc598-som-ezkit/sc598-som-ezkit.env
index 1da4a585b1c..e26601c3330 100644
--- a/board/adi/sc598-som-ezkit/sc598-som-ezkit.env
+++ b/board/adi/sc598-som-ezkit/sc598-som-ezkit.env
@@ -13,5 +13,6 @@ loadaddr=CONFIG_SC5XX_LOADADDR
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

