Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 627FACA0FED
	for <u-boot@archiver.kernel.org>; Wed, 27 Aug 2025 14:26:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6103783287;
	Wed, 27 Aug 2025 16:25:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="DRsCoyWm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C7BB983145; Wed, 27 Aug 2025 13:08:57 +0200 (CEST)
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com
 [IPv6:2607:f8b0:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6CCC8828A2
 for <u-boot@lists.denx.de>; Wed, 27 Aug 2025 13:08:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=bhimeswararao.matsa@gmail.com
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-2487a60d649so17150445ad.2
 for <u-boot@lists.denx.de>; Wed, 27 Aug 2025 04:08:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1756292933; x=1756897733; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=wfGEKqmbn1Xnn/llwBaa7Dvqdeko8Li2AP+BXdBjCvg=;
 b=DRsCoyWmXaH7giXuCynSONrf7BaroULfb3Pk2asjwn1MUU6YJNvBgCEXs74kwtYAPG
 cGFoIfLS3EUFoYLSlcF8eUCgjsdmVjOzempm9441Rmydvak7KhDQBlN2HaWWS63J90rp
 RSDFUT2GIN2TIaJgIienEFKrcvd6PkSWp0UQvvSr0+8vEvGoioW21h9MPIoDNx3UOMqZ
 V00QTgeJTvzZRWDKYzkxiv5Q9veF+ntPCPz8OFxWOgkoafX2gZEDmqGUSpKfHCkH5MTI
 DvpYGoHHMNBGC75yinJqlHNDwe+/jegXPkhE/ZnbGuv5QaHV/FCB1buuYcs9suJZ8nr6
 rfwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756292933; x=1756897733;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=wfGEKqmbn1Xnn/llwBaa7Dvqdeko8Li2AP+BXdBjCvg=;
 b=V+pmLl7gP/vUDXuYvaPYr/R4NSg7c/IJ4h6IZNSHOMqxkuFRgzE3AfTQilyD62vkvk
 K2uPJDp2VR5uzHyzVhIY+iUkJhmYO+uLq2sj6ptNWqV9gLDMiUwveUl6sa9eKuhnUX68
 pG6h/PYJRFGz+W+LxbX7JTIhtLhkIJ0T8hQ86Gg8Vr9UgDPWfdvObPpcEX87I90SAxvl
 EKeSaAL0JwhRdO7ulm78XM9zs16XqEn9gtBdzgRcFomjWYLcVLtQuP5mNylrbKZQH57v
 mdyqpd/UxoFGf4nsfJHGxD/zrdVE9EGgeVUVrANerG5J62tvNfxDCb104uU6xETibjbA
 4e5Q==
X-Gm-Message-State: AOJu0Yz0NIP9CcYnx3QBK9SLZwul6L+9xNr8407fSngm0xGbVhV/spHn
 28skD2UBN4jJWSYQA5wJZvipqd+X4K69kXvfyg6pgF6JVlFPIJbMBNpvPWrf6YPW
X-Gm-Gg: ASbGncsJp4tg4rYf0UWO5MwqFZddCKUKaUiw0FKxFgeR5WYyDSqJPhPBh7aFy1MkK2D
 1O+9tYdxpjBuFVJpQhE/sIbuZQTlpWfToPkoNydOZAkE7eRfPKayqRYttuhmXCxbvj96tn9pGHy
 uFZnAXqshZc2ImynLtsoLtsjN8bhLJGxcFT3L1fK3kUeb1XUHGlK6LkYycXoVdIDLvYb2M4CBC1
 8jevHvWocab8dVaGDaRk1VdLeMSbcZxDOjAVwAtlR5nswKJX45bHT5yCxk6KlZd8exkj+vM0dOw
 pU720sVTBBAWD4Ni0LUIF1SXfUr1Bx8FGBaw88Y/OH/xQJh/bwZkCRIfiWSby++lQkxynKZoOqn
 KmWo/dRxRpH0/9fliCcc6tFzAJJt55pCl7NkWkfuSi+tKiFQSE04fQum0tmvy9lzSQTZVDioPCQ
 MrisoTAG3huQ==
X-Google-Smtp-Source: AGHT+IEifGH44k4ad1ZBj+llnBi03kjXlWpJAUtw+tEyaqhhzyUz7r9Pba/sPQ0y32d2lGuhLL/+JA==
X-Received: by 2002:a17:903:388c:b0:246:831c:b1e1 with SMTP id
 d9443c01a7336-246831cb5ccmr182559725ad.2.1756292933499; 
 Wed, 27 Aug 2025 04:08:53 -0700 (PDT)
Received: from kumara-Inspiron-15-3530.. ([49.207.207.110])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-24873ceb334sm37862905ad.51.2025.08.27.04.08.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 Aug 2025 04:08:52 -0700 (PDT)
From: Bhimeswararao Matsa <bhimeswararao.matsa@gmail.com>
To: u-boot@lists.denx.de
Cc: Bhimeswararao Matsa <bhimeswararao.matsa@gmail.com>,
 Heiko Schocher <hs@nabladev.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH] i2c: davinci: use mdelay() for multi-millisecond waits
Date: Wed, 27 Aug 2025 16:38:46 +0530
Message-ID: <20250827110846.39686-1-bhimeswararao.matsa@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 27 Aug 2025 16:25:23 +0200
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

Signed-off-by: Bhimeswararao Matsa <bhimeswararao.matsa@gmail.com>
---
 drivers/i2c/davinci_i2c.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/i2c/davinci_i2c.c b/drivers/i2c/davinci_i2c.c
index 9bba0600e3e..ffd0dd0b282 100644
--- a/drivers/i2c/davinci_i2c.c
+++ b/drivers/i2c/davinci_i2c.c
@@ -51,7 +51,7 @@ static int _wait_for_bus(struct i2c_regs *i2c_base)
 		}
 
 		REG(&(i2c_base->i2c_stat)) = stat;
-		udelay(50000);
+		mdelay(50);
 	}
 
 	REG(&(i2c_base->i2c_stat)) = 0xffff;
@@ -63,7 +63,7 @@ static int _poll_i2c_irq(struct i2c_regs *i2c_base, int mask)
 	int	stat, timeout;
 
 	for (timeout = 0; timeout < 10; timeout++) {
-		udelay(1000);
+		mdelay(1);
 		stat = REG(&(i2c_base->i2c_stat));
 		if (stat & mask)
 			return stat;
@@ -81,7 +81,7 @@ static void _flush_rx(struct i2c_regs *i2c_base)
 
 		REG(&(i2c_base->i2c_drr));
 		REG(&(i2c_base->i2c_stat)) = I2C_STAT_RRDY;
-		udelay(1000);
+		mdelay(1);
 	}
 }
 
@@ -105,7 +105,7 @@ static void _davinci_i2c_init(struct i2c_regs *i2c_base,
 {
 	if (REG(&(i2c_base->i2c_con)) & I2C_CON_EN) {
 		REG(&(i2c_base->i2c_con)) = 0;
-		udelay(50000);
+		mdelay(50);
 	}
 
 	_davinci_i2c_setspeed(i2c_base, speed);
@@ -120,7 +120,7 @@ static void _davinci_i2c_init(struct i2c_regs *i2c_base,
 	/* Now enable I2C controller (get it out of reset) */
 	REG(&(i2c_base->i2c_con)) = I2C_CON_EN;
 
-	udelay(1000);
+	mdelay(1);
 }
 
 static int _davinci_i2c_read(struct i2c_regs *i2c_base, u8 chip,
@@ -319,7 +319,7 @@ static int _davinci_i2c_probe_chip(struct i2c_regs *i2c_base, u8 chip)
 	REG(&(i2c_base->i2c_sa))  = chip;
 	REG(&(i2c_base->i2c_con)) = (I2C_CON_EN | I2C_CON_MST | I2C_CON_STT |
 				     I2C_CON_STP);
-	udelay(50000);
+	mdelay(50);
 
 	if (!(REG(&(i2c_base->i2c_stat)) & I2C_STAT_NACK)) {
 		rc = 0;
@@ -328,7 +328,7 @@ static int _davinci_i2c_probe_chip(struct i2c_regs *i2c_base, u8 chip)
 	} else {
 		REG(&(i2c_base->i2c_stat)) = 0xffff;
 		REG(&(i2c_base->i2c_con)) |= I2C_CON_STP;
-		udelay(20000);
+		mdelay(20);
 		if (_wait_for_bus(i2c_base))
 			return 1;
 	}
-- 
2.43.0

