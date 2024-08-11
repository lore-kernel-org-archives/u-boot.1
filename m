Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C454C3DA4A
	for <u-boot@archiver.kernel.org>; Sun, 11 Aug 2024 14:53:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 814468892C;
	Sun, 11 Aug 2024 16:51:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Y/ZNJ5HS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D333688934; Sun, 11 Aug 2024 16:51:20 +0200 (CEST)
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com
 [IPv6:2607:f8b0:4864:20::d35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 58D148861A
 for <u-boot@lists.denx.de>; Sun, 11 Aug 2024 16:51:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd35.google.com with SMTP id
 ca18e2360f4ac-8152f0c63c1so130417739f.1
 for <u-boot@lists.denx.de>; Sun, 11 Aug 2024 07:51:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1723387876; x=1723992676; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iS1sxj/PPb6ZIHhE7j+iswjgfVMChPa+gjplv9tH9DY=;
 b=Y/ZNJ5HSCOpDNx+R//1QVISURvZqpIO9TSFPwjovnplqO41vvR4u0g/sgsS7u/IPnX
 zvGe7eaTpWnSmrc4/Y3Lw6bmkdWqlWRy5oEGbJ2b+OY9HwbhINWkbvQEb//K4Aw8vsrW
 U4V+zeA5OcBazjb/rqJMmrqh2x42EAuaQnljo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723387876; x=1723992676;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iS1sxj/PPb6ZIHhE7j+iswjgfVMChPa+gjplv9tH9DY=;
 b=DCnqqG+Bv7Lpr431bHs0+691RETI0If6uQ7TqADPrLcXVGXmVBphZWQ2ZBGZ4QS62v
 nrm/W2bPAOLpoP7v9ttz5pS5hbq8lpA1cXX1e/MLCYcn5hTKSyJwnKe0/6RktJYgAEWx
 SjK6M6NkrBDEvduYRU8vJVLABEMJUYVB+0BGec8VnHmTvP2KIsumCEZtJU7AaPfFtOpS
 WjHA8BGYfnvDBn9Lr6n6CuJ9/4o/YHeHpvZ7L0IBLrN+FBYTaDSE0A5FKNct/u8qA6c+
 GgNBusnD80Jp7ZUf5oF7tWs5iMitNBCovXFrfEKzeBkEC425aHKi7wWkJEWzsiktsA+L
 iGDg==
X-Gm-Message-State: AOJu0YxzDFAFN3CJ0abv4CJ9Y8/atq/F3XtZHLa4NdnSxzAKqMijdVWU
 pxjpfdXtnhNqBGjjzhm8Yt2LSa2TLJufOlf/Ir0i4M/sjOkVFME45c15ttuEf6gECOfhFXuEC+A
 =
X-Google-Smtp-Source: AGHT+IHkOgi/QeBJ5gEcYwNd1459ePwPvUGtq8Ql9ocUYJlOQkNa+8X0Q5AvnJ7fQyItcvfeKneUoQ==
X-Received: by 2002:a05:6602:2c82:b0:807:f0fb:11a2 with SMTP id
 ca18e2360f4ac-8225ee39362mr1028229939f.13.1723387875958; 
 Sun, 11 Aug 2024 07:51:15 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4ca769fbe17sm1076047173.101.2024.08.11.07.51.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 11 Aug 2024 07:51:15 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Heiko Schocher <hs@denx.de>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v2 03/18] i2c: Remove CFG_I2C_MULTI_BUS
Date: Sun, 11 Aug 2024 08:50:32 -0600
Message-Id: <20240811145047.4189460-4-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240811145047.4189460-1-sjg@chromium.org>
References: <20240811145047.4189460-1-sjg@chromium.org>
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

This is used by a few boards but we are years past the migration date,
so let's drop it now.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v2:
- Drop omap3_beagle.h change as that board was removed

 README                   |  7 -------
 include/configs/sniper.h | 14 --------------
 include/configs/tqma6.h  |  3 ---
 include/i2c.h            |  2 +-
 4 files changed, 1 insertion(+), 25 deletions(-)

diff --git a/README b/README
index b76449b70a8..c3821c5ce4e 100644
--- a/README
+++ b/README
@@ -883,13 +883,6 @@ The following options need to be configured:
 		You should define these to the GPIO value as given directly to
 		the generic GPIO functions.
 
-		CFG_I2C_MULTI_BUS
-
-		This option allows the use of multiple I2C buses, each of which
-		must have a controller.	 At any point in time, only one bus is
-		active.	 To switch to a different bus, use the 'i2c dev' command.
-		Note that bus numbering is zero-based.
-
 		CFG_SYS_I2C_NOPROBES
 
 		This option specifies a list of I2C devices that will be skipped
diff --git a/include/configs/sniper.h b/include/configs/sniper.h
index 45a3102aeee..d0ae5e18605 100644
--- a/include/configs/sniper.h
+++ b/include/configs/sniper.h
@@ -34,20 +34,6 @@
 
 #define CFG_SYS_SDRAM_BASE		0x80000000
 
-/*
- * I2C
- */
-
-#define CFG_I2C_MULTI_BUS
-
-/*
- * Input
- */
-
-/*
- * SPL
- */
-
 /*
  * Serial
  */
diff --git a/include/configs/tqma6.h b/include/configs/tqma6.h
index 2da76f15431..ceeed174ec5 100644
--- a/include/configs/tqma6.h
+++ b/include/configs/tqma6.h
@@ -26,9 +26,6 @@
 
 #define TQMA6_SPI_FLASH_SECTOR_SIZE	SZ_64K
 
-/* I2C Configs */
-#define CFG_I2C_MULTI_BUS
-
 #if !defined(CONFIG_DM_PMIC)
 #define CFG_POWER_PFUZE100_I2C_ADDR	0x08
 #define TQMA6_PFUZE100_I2C_BUS		2
diff --git a/include/i2c.h b/include/i2c.h
index 1d3be3f6759..622540c8265 100644
--- a/include/i2c.h
+++ b/include/i2c.h
@@ -942,7 +942,7 @@ unsigned int i2c_get_bus_speed(void);
  * only for backwardcompatibility, should go away if we switched
  * completely to new multibus support.
  */
-#if CONFIG_IS_ENABLED(SYS_I2C_LEGACY) || defined(CFG_I2C_MULTI_BUS)
+#if CONFIG_IS_ENABLED(SYS_I2C_LEGACY)
 # if !defined(CFG_SYS_MAX_I2C_BUS)
 #  define CFG_SYS_MAX_I2C_BUS		2
 # endif
-- 
2.34.1

