Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E7A0CA0FF9
	for <u-boot@archiver.kernel.org>; Fri, 29 Aug 2025 14:29:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2A49B83689;
	Fri, 29 Aug 2025 16:29:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="HObaX0Yw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ACE7883448; Fri, 29 Aug 2025 04:11:55 +0200 (CEST)
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com
 [IPv6:2607:f8b0:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6BAA483443
 for <u-boot@lists.denx.de>; Fri, 29 Aug 2025 04:11:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=bhimeswararao.matsa@gmail.com
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-248a61a27acso12455655ad.1
 for <u-boot@lists.denx.de>; Thu, 28 Aug 2025 19:11:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1756433511; x=1757038311; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wfGEKqmbn1Xnn/llwBaa7Dvqdeko8Li2AP+BXdBjCvg=;
 b=HObaX0YwwDZXVc44SYjUWMyQ+3UgdcuMxARgiBQAxdBZ842Oe7Uj3HWCAor5z3WEHK
 8xbcbCW+QSsaBeMYGPZ570rPC3EawRzm8IyDzDJKTiHMC/KYwJ3RYBr9ei0aY3H7FGbl
 INmcOCfHCwN75YmmyDtZt4jbST0o6jmOVh7T9m5lii23D6pUjF3wU2iP3A/tVxxigJmF
 c1WpXiqB+MBBR0we8sff3Cwe1v3cbJxX7JsZltip3eF9UUZreRD/mnSfROC8B7vcQM0X
 jtOnLCvbVf47UZGzmk8IZIkQiK4GmVFNOzNepflcKLa75lRDvOce4qHZ0VfYsBUU1gg/
 QsAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756433511; x=1757038311;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wfGEKqmbn1Xnn/llwBaa7Dvqdeko8Li2AP+BXdBjCvg=;
 b=GwpRQuiYvoW5nr8cJjiSGZMemEX9TwYjeuqf5Vg8dnD3obddW/poJKhS1owsNWzstx
 e5G/5UYYfwb7pMmtG5k4iCJt0PwrzoKXd5Od16S/CES+VSje9TWWBraUTxFMo6AxvmJc
 siKafAYifJLWqHVFSQeX9hq3AhrNMaFiZdYL71NUGSn8vWSkfOZ3LeE71ucBLVmaAGXL
 iF28ymdINSRkBh9opE/3VMcTUIFXDa+ahNts+eJhw43uEyytCLukXuG2tlu2tWqRlCQ2
 qIxZgVdUt2e7/hIwiAYeCNLk1StjwKPdFvTUju2VeJwQnrmpdivbXpxPe8okpiSNPeE+
 wowA==
X-Gm-Message-State: AOJu0YxUwJjY354ZR7DG1wlTq53XXBUz/IdcCa7z/oDz1QsLcr8HBhiA
 wEn52nOl+cO3AO69rndQQY3z0soAj9VpnMIw6migO4tsQkx1Q4c1HXHR/wtFjCZK
X-Gm-Gg: ASbGncueq61wdRzOUH1HWTp4w+Jpr1H8y5lfOxanMDFaLqIgbGsvGgD9/TUtf46li5O
 UO4RHHxTLqQit3qnLRDwRgSQ9J5/lXJWYUUYDrNajlFHin64zHvqVhM/AVck66eGNo5Da60xLYY
 IELJpRbA5XkLMK19iFoAoVqxwGafwmseAjGD+SMDD+DmaSELT3uAdhisFWbfndsAYe6isT0nXOm
 ubOGLrwRpuN7FJrvWOf+OH9Fe1xQbHgj0Rwgvg0emrbvzjL8ke0QTsq5zi+ZGCs/30VxSQvtBvL
 +x0q+OEsZuILX/3LIex++JFoMaBb432N37+ItTFpciLWWnDeXxYU+9nqC4aHlkKPFOWkM5+wwB0
 F3ZNSFN/sdIeIfDXIhH4opryTDbeqbKbOQwuygzJEyACR+QSuneiiheWwPu4P9eYltOu1oCuxA/
 mmGPtu9MpG9gFsCkir+OOL
X-Google-Smtp-Source: AGHT+IFjJ7DcJeqQAJ5ygoL3nqJJk0Xb+nQfjP8BCsSXYAQjNSIkV7phbDrZQIAFqYtmpoD+wehNMg==
X-Received: by 2002:a17:903:238a:b0:245:f860:80b1 with SMTP id
 d9443c01a7336-248753a264dmr150004145ad.11.1756433511193; 
 Thu, 28 Aug 2025 19:11:51 -0700 (PDT)
Received: from kumara-Inspiron-15-3530.. ([49.207.207.107])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2490cbc9cb9sm4694055ad.15.2025.08.28.19.11.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Aug 2025 19:11:50 -0700 (PDT)
From: Bhimeswararao Matsa <bhimeswararao.matsa@gmail.com>
To: u-boot@lists.denx.de
Cc: Bhimeswararao Matsa <bhimeswararao.matsa@gmail.com>
Subject: [PATCH] i2c: davinci: use mdelay() for multi-millisecond waits
Date: Fri, 29 Aug 2025 07:41:30 +0530
Message-ID: <20250829021131.28451-3-bhimeswararao.matsa@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250829021131.28451-1-bhimeswararao.matsa@gmail.com>
References: <20250829021131.28451-1-bhimeswararao.matsa@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 29 Aug 2025 16:29:12 +0200
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

