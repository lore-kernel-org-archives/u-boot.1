Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1013CC3DA49
	for <u-boot@archiver.kernel.org>; Thu, 18 Jul 2024 17:39:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1661988AE1;
	Thu, 18 Jul 2024 19:37:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="lS7gQgNb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 58DC688B66; Thu, 18 Jul 2024 19:36:59 +0200 (CEST)
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com
 [IPv6:2a00:1450:4864:20::42c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BB42888B22
 for <u-boot@lists.denx.de>; Thu, 18 Jul 2024 19:36:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-3685b3dbcdcso61120f8f.3
 for <u-boot@lists.denx.de>; Thu, 18 Jul 2024 10:36:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1721324209; x=1721929009; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jKHc43u1TcGjUDlv7l9M3oFlNlL7j5I4LTRXAfv7vB8=;
 b=lS7gQgNbf3pOpUbSgfNGv646FiDme1sLZtBxJ10J9wqoI7ipprbzs3/+d0exAHB84Y
 aOImhGivV0ah2BzlwWjlsEI+KI7s72cb0hZUFfcV2ZVejoQVM2xlyIyeN+uRwEnv2dYX
 PEQn+/lS/X+wKN4ucc1yCgCNxitSh3xYLwRS0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721324209; x=1721929009;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jKHc43u1TcGjUDlv7l9M3oFlNlL7j5I4LTRXAfv7vB8=;
 b=Sva81EpTd12zLzmkCsl43g1RMTglRscXlWR3jOKNSRr65D8VdtGnJ5CNJTI33VSssE
 PoSt9P7pnB3Vwg6bdG0Tv0ameZ/ZDshK1++TvjBvlEv7r2de7NP5gFBTUuT0XmoniKTe
 PqXnv7ZJXE5t++28t9X9RkOwjqL7pC+S+EUnRw2clW/nBTsQ5eR1qau7tJUzMkI9x9cw
 Np6ScvncSIBJyrHccY3rK5Mbe46nZFZNSoWz/vI2zk37RBF+5BY8CD7xSfkUHgw3/rdj
 sWKvDNuEXijYS4XUPgm2bglrgx9IEXIcupH7oijCvmyBIHZiBgS+1m3aDI5+8DpM7SzV
 jgfg==
X-Gm-Message-State: AOJu0YzFq2Cu1kUyUCgxjSUKGomH+Ihe56O2DcnVAoPYh74vP0RWIU1r
 lVN7obGv/tyK9wpAO43ShefSi7e8zkVWEXPwU654/COejLeTUeIsPlG2BYC/JX77W7sM3c15xNg
 =
X-Google-Smtp-Source: AGHT+IEaFxHbXsBU3SAzbSes0T2vFYlXvGH+6yA+87H9bim7tI14ivWgLDPLWoJoBj45UZC8TdAZMA==
X-Received: by 2002:a5d:45d2:0:b0:367:973e:c20a with SMTP id
 ffacd0b85a97d-368315fa466mr3658163f8f.18.1721324209125; 
 Thu, 18 Jul 2024 10:36:49 -0700 (PDT)
Received: from tasman.. (host-92-15-194-143.as13285.net. [92.15.194.143])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427d2b29396sm20950715e9.32.2024.07.18.10.36.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Jul 2024 10:36:48 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Heiko Schocher <hs@denx.de>,
 Simon Glass <sjg@chromium.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Philip Richard Oberfichtner <pro@denx.de>, egnite GmbH <info@egnite.de>
Subject: [PATCH 17/20] i2c: Drop CFG_SYS_MAX_I2C_BUS
Date: Thu, 18 Jul 2024 18:36:08 +0100
Message-Id: <20240718173611.4014274-18-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240718173611.4014274-1-sjg@chromium.org>
References: <20240718173611.4014274-1-sjg@chromium.org>
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

Only one board uses this option and it is very old. Let's drop it.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 include/configs/ethernut5.h |  3 ---
 include/i2c.h               | 14 --------------
 2 files changed, 17 deletions(-)

diff --git a/include/configs/ethernut5.h b/include/configs/ethernut5.h
index 807c6963192..c327bbbe07d 100644
--- a/include/configs/ethernut5.h
+++ b/include/configs/ethernut5.h
@@ -59,9 +59,6 @@
 #define CFG_SYS_I2C_RTC_ADDR		0x51
 #endif
 
-/* I2C */
-#define CFG_SYS_MAX_I2C_BUS	1
-
 #define I2C_SOFT_DECLARATIONS
 
 #define GPIO_I2C_SCL		AT91_PIO_PORTA, 24
diff --git a/include/i2c.h b/include/i2c.h
index b6727bb2a73..282f3cd700f 100644
--- a/include/i2c.h
+++ b/include/i2c.h
@@ -933,20 +933,6 @@ int i2c_set_bus_speed(unsigned int);
 unsigned int i2c_get_bus_speed(void);
 #endif /* CONFIG_SYS_I2C_LEGACY */
 
-/*
- * only for backwardcompatibility, should go away if we switched
- * completely to new multibus support.
- */
-#if CONFIG_IS_ENABLED(SYS_I2C_LEGACY)
-# if !defined(CFG_SYS_MAX_I2C_BUS)
-#  define CFG_SYS_MAX_I2C_BUS		2
-# endif
-# define I2C_MULTI_BUS				1
-#else
-# define CFG_SYS_MAX_I2C_BUS		1
-# define I2C_MULTI_BUS				0
-#endif
-
 /**
  * Find the I2C bus number by given a FDT I2C node.
  *
-- 
2.34.1

