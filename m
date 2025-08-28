Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31110CA0FF2
	for <u-boot@archiver.kernel.org>; Thu, 28 Aug 2025 05:03:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9A1D3831D5;
	Thu, 28 Aug 2025 07:03:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="gWVUrULD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CDBA4831BB; Thu, 28 Aug 2025 03:19:23 +0200 (CEST)
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com
 [IPv6:2607:f8b0:4864:20::42d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 52EFC83106
 for <u-boot@lists.denx.de>; Thu, 28 Aug 2025 03:19:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=bhimeswararao.matsa@gmail.com
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-771fa65b0e1so247963b3a.0
 for <u-boot@lists.denx.de>; Wed, 27 Aug 2025 18:19:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1756343959; x=1756948759; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=xVEO7eONrzNUYgbBeksaFItW7N5Q2v0lHFZtDcnUNBE=;
 b=gWVUrULDA1VIDnQ+ck2/Qg98FXpQ1BS5qCBkH6sqz4P3O5qVlx5bkX+dsf1EPgTWf+
 Mhl7i7SWKdMDsC5YOZgxWxK1YLw5o6gCFBxZeG8geKzZuFeGi/Zqoa71jSYcNktQUifK
 1NMbbeQIFGRGTbyYu7W+p+wB04eF6083TreDhcdJU0v6D/5LED+R1WkLHxT7Ln3PnzM2
 8dKrY8j3MNj/xrSn5VA9pgbYAPXgMyYfKbw3IgTS+4jyDKm+gc9CY1fCHdDPymZx07aF
 39k539c2h19+gzTM+/MrX/fXeGDV9dRn79nDzxDz0kkqhwIefT5K9H8l8o/T2mk3iESp
 WWVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756343959; x=1756948759;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=xVEO7eONrzNUYgbBeksaFItW7N5Q2v0lHFZtDcnUNBE=;
 b=wZe6g7HDd4DMU4nxHVT+dADQac6pyzn4J5NEyPR2o+qqRaO5j2yaIvuvZMN7yyhPu2
 uHA5KLuCDGjI6vZzYPFMzSBaa5RzfSWmeFJxCHRmJIvjfl/EkujjlBrn+t8q5N+23mzm
 8WaGEyjJfki5v0wK2o5FS98HTC5ly0Ytbzey+yNMJPnA/YbaEE6TvO7UPljbWUsBmlD5
 NmhN9l9ggaRP0exUqOTkkuySeG8aJ2BFKHduL4pLfvD7ga1ql9roUBIvqJwhNSkzqpqK
 dbsgsRxylDpyDahowmRSMDjz9K4KGF556Kq1KC0fQmOI5QONXmdtcvAIcaOSNhEO+jRl
 YlAA==
X-Gm-Message-State: AOJu0YxlttldpzSeYEgq9MBGc34kA57N0e2eV2OemZokb9A/AOldsyBh
 iO4sbt5BNhfmAOBSHQaoFZiJyex5nHxStWIsaVMPeeRfwSBPhqty5p/Rqlj7NthY
X-Gm-Gg: ASbGnctoPim4nADWCZPxoInLNq7tNODpItwW7VzbmYBlXmg1hVcz+hnI1QUJZrPNUhB
 59lg2MRZLqj/YBjXOlC2KvIAAuqOKAYXbopZGTpeKPhyXRHADM26tH3FqxbAgyhNndrG/bDnJ2m
 +oDYZgKlg2VLCOPMRfD85gsJACZfuGQbOyCM/6JDUCq2w5q1m8eGneoYVvKklP3UTmAFW4NX4lX
 j68F02oABTA+1Vx1Ratf2SNh4LjNcoP154dlLje/2WnAMhngRQ6dvlDtw+MIs13dygkw/i0amTw
 9cMy/aq3owr6vb0LUWccPmie8Beg2x/IV/bdQG8mBycAKNInJ+iCKgn8dr8w7MLdv3L1qdIYfi1
 HCpgA/HWpSeChXAyxyHiCoNfqW5wPJg5OzoWRZxYnDL/JL3SGeJH9oPwVscNgVdAHjLA2IlixrV
 C8KSbpNrvA
X-Google-Smtp-Source: AGHT+IF3xthtSPD/Lh0RYEvf5vjTSlMo8obEKv2cZLGR8vfz7nIlYlfiI9w3D3wJ5tnod7Fsk8mCKA==
X-Received: by 2002:a05:6a20:7d9e:b0:243:78a:82c2 with SMTP id
 adf61e73a8af0-24340dafb84mr30561603637.60.1756343959217; 
 Wed, 27 Aug 2025 18:19:19 -0700 (PDT)
Received: from kumara-Inspiron-15-3530.. ([49.207.217.28])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b49cbb7b5d5sm12456307a12.33.2025.08.27.18.19.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 Aug 2025 18:19:18 -0700 (PDT)
From: Bhimeswararao Matsa <bhimeswararao.matsa@gmail.com>
To: u-boot@lists.denx.de
Cc: Bhimeswararao Matsa <bhimeswararao.matsa@gmail.com>,
 Heiko Schocher <hs@nabladev.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v2] =?UTF-8?q?i2c:=20davinci:=20drop=20unnecessary=20paren?=
 =?UTF-8?q?theses=20in=20REG(&=E2=80=A6)?=
Date: Thu, 28 Aug 2025 06:49:06 +0530
Message-ID: <20250828011908.5406-1-bhimeswararao.matsa@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 28 Aug 2025 07:03:09 +0200
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

checkpatch.pl reports that several parentheses in davinci_i2c.c
are unnecessary. Remove them to clean up the code and silence
checkpatch warnings.

Signed-off-by: Bhimeswararao Matsa <bhimeswararao.matsa@gmail.com>
---
 drivers/i2c/davinci_i2c.c | 118 +++++++++++++++++++-------------------
 1 file changed, 59 insertions(+), 59 deletions(-)

diff --git a/drivers/i2c/davinci_i2c.c b/drivers/i2c/davinci_i2c.c
index ffd0dd0b282..caf5fbcc346 100644
--- a/drivers/i2c/davinci_i2c.c
+++ b/drivers/i2c/davinci_i2c.c
@@ -41,20 +41,20 @@ static int _wait_for_bus(struct i2c_regs *i2c_base)
 {
 	int	stat, timeout;
 
-	REG(&(i2c_base->i2c_stat)) = 0xffff;
+	REG(&i2c_base->i2c_stat) = 0xffff;
 
 	for (timeout = 0; timeout < 10; timeout++) {
-		stat = REG(&(i2c_base->i2c_stat));
+		stat = REG(&i2c_base->i2c_stat);
 		if (!((stat) & I2C_STAT_BB)) {
-			REG(&(i2c_base->i2c_stat)) = 0xffff;
+			REG(&i2c_base->i2c_stat) = 0xffff;
 			return 0;
 		}
 
-		REG(&(i2c_base->i2c_stat)) = stat;
+		REG(&i2c_base->i2c_stat) = stat;
 		mdelay(50);
 	}
 
-	REG(&(i2c_base->i2c_stat)) = 0xffff;
+	REG(&i2c_base->i2c_stat) = 0xffff;
 	return 1;
 }
 
@@ -64,23 +64,23 @@ static int _poll_i2c_irq(struct i2c_regs *i2c_base, int mask)
 
 	for (timeout = 0; timeout < 10; timeout++) {
 		mdelay(1);
-		stat = REG(&(i2c_base->i2c_stat));
+		stat = REG(&i2c_base->i2c_stat);
 		if (stat & mask)
 			return stat;
 	}
 
-	REG(&(i2c_base->i2c_stat)) = 0xffff;
+	REG(&i2c_base->i2c_stat) = 0xffff;
 	return stat | I2C_TIMEOUT;
 }
 
 static void _flush_rx(struct i2c_regs *i2c_base)
 {
 	while (1) {
-		if (!(REG(&(i2c_base->i2c_stat)) & I2C_STAT_RRDY))
+		if (!(REG(&i2c_base->i2c_stat) & I2C_STAT_RRDY))
 			break;
 
-		REG(&(i2c_base->i2c_drr));
-		REG(&(i2c_base->i2c_stat)) = I2C_STAT_RRDY;
+		REG(&i2c_base->i2c_drr);
+		REG(&i2c_base->i2c_stat) = I2C_STAT_RRDY;
 		mdelay(1);
 	}
 }
@@ -93,9 +93,9 @@ static uint _davinci_i2c_setspeed(struct i2c_regs *i2c_base,
 	psc = 2;
 	/* SCLL + SCLH */
 	div = (CFG_SYS_HZ_CLOCK / ((psc + 1) * speed)) - 10;
-	REG(&(i2c_base->i2c_psc)) = psc; /* 27MHz / (2 + 1) = 9MHz */
-	REG(&(i2c_base->i2c_scll)) = (div * 50) / 100; /* 50% Duty */
-	REG(&(i2c_base->i2c_sclh)) = div - REG(&(i2c_base->i2c_scll));
+	REG(&i2c_base->i2c_psc) = psc; /* 27MHz / (2 + 1) = 9MHz */
+	REG(&i2c_base->i2c_scll) = (div * 50) / 100; /* 50% Duty */
+	REG(&i2c_base->i2c_sclh) = div - REG(&i2c_base->i2c_scll);
 
 	return 0;
 }
@@ -103,22 +103,22 @@ static uint _davinci_i2c_setspeed(struct i2c_regs *i2c_base,
 static void _davinci_i2c_init(struct i2c_regs *i2c_base,
 			      uint speed, int slaveadd)
 {
-	if (REG(&(i2c_base->i2c_con)) & I2C_CON_EN) {
-		REG(&(i2c_base->i2c_con)) = 0;
+	if (REG(&i2c_base->i2c_con) & I2C_CON_EN) {
+		REG(&i2c_base->i2c_con) = 0;
 		mdelay(50);
 	}
 
 	_davinci_i2c_setspeed(i2c_base, speed);
 
-	REG(&(i2c_base->i2c_oa)) = slaveadd;
-	REG(&(i2c_base->i2c_cnt)) = 0;
+	REG(&i2c_base->i2c_oa) = slaveadd;
+	REG(&i2c_base->i2c_cnt) = 0;
 
 	/* Interrupts must be enabled or I2C module won't work */
-	REG(&(i2c_base->i2c_ie)) = I2C_IE_SCD_IE | I2C_IE_XRDY_IE |
+	REG(&i2c_base->i2c_ie) = I2C_IE_SCD_IE | I2C_IE_XRDY_IE |
 		I2C_IE_RRDY_IE | I2C_IE_ARDY_IE | I2C_IE_NACK_IE;
 
 	/* Now enable I2C controller (get it out of reset) */
-	REG(&(i2c_base->i2c_con)) = I2C_CON_EN;
+	REG(&i2c_base->i2c_con) = I2C_CON_EN;
 
 	mdelay(1);
 }
@@ -140,9 +140,9 @@ static int _davinci_i2c_read(struct i2c_regs *i2c_base, u8 chip,
 	if (alen != 0) {
 		/* Start address phase */
 		tmp = I2C_CON_EN | I2C_CON_MST | I2C_CON_STT | I2C_CON_TRX;
-		REG(&(i2c_base->i2c_cnt)) = alen;
-		REG(&(i2c_base->i2c_sa)) = chip;
-		REG(&(i2c_base->i2c_con)) = tmp;
+		REG(&i2c_base->i2c_cnt) = alen;
+		REG(&i2c_base->i2c_sa) = chip;
+		REG(&i2c_base->i2c_con) = tmp;
 
 		tmp = _poll_i2c_irq(i2c_base, I2C_STAT_XRDY | I2C_STAT_NACK);
 
@@ -152,9 +152,9 @@ static int _davinci_i2c_read(struct i2c_regs *i2c_base, u8 chip,
 		case 2:
 			/* Send address MSByte */
 			if (tmp & I2C_STAT_XRDY) {
-				REG(&(i2c_base->i2c_dxr)) = (addr >> 8) & 0xff;
+				REG(&i2c_base->i2c_dxr) = (addr >> 8) & 0xff;
 			} else {
-				REG(&(i2c_base->i2c_con)) = 0;
+				REG(&i2c_base->i2c_con) = 0;
 				return 1;
 			}
 
@@ -166,9 +166,9 @@ static int _davinci_i2c_read(struct i2c_regs *i2c_base, u8 chip,
 		case 1:
 			/* Send address LSByte */
 			if (tmp & I2C_STAT_XRDY) {
-				REG(&(i2c_base->i2c_dxr)) = addr & 0xff;
+				REG(&i2c_base->i2c_dxr) = addr & 0xff;
 			} else {
-				REG(&(i2c_base->i2c_con)) = 0;
+				REG(&i2c_base->i2c_con) = 0;
 				return 1;
 			}
 
@@ -178,7 +178,7 @@ static int _davinci_i2c_read(struct i2c_regs *i2c_base, u8 chip,
 			CHECK_NACK();
 
 			if (!(tmp & I2C_STAT_ARDY)) {
-				REG(&(i2c_base->i2c_con)) = 0;
+				REG(&i2c_base->i2c_con) = 0;
 				return 1;
 			}
 		}
@@ -186,9 +186,9 @@ static int _davinci_i2c_read(struct i2c_regs *i2c_base, u8 chip,
 
 	/* Address phase is over, now read 'len' bytes and stop */
 	tmp = I2C_CON_EN | I2C_CON_MST | I2C_CON_STT | I2C_CON_STP;
-	REG(&(i2c_base->i2c_cnt)) = len & 0xffff;
-	REG(&(i2c_base->i2c_sa)) = chip;
-	REG(&(i2c_base->i2c_con)) = tmp;
+	REG(&i2c_base->i2c_cnt) = len & 0xffff;
+	REG(&i2c_base->i2c_sa) = chip;
+	REG(&i2c_base->i2c_con) = tmp;
 
 	for (i = 0; i < len; i++) {
 		tmp = _poll_i2c_irq(i2c_base, I2C_STAT_RRDY | I2C_STAT_NACK |
@@ -197,9 +197,9 @@ static int _davinci_i2c_read(struct i2c_regs *i2c_base, u8 chip,
 		CHECK_NACK();
 
 		if (tmp & I2C_STAT_RRDY) {
-			buf[i] = REG(&(i2c_base->i2c_drr));
+			buf[i] = REG(&i2c_base->i2c_drr);
 		} else {
-			REG(&(i2c_base->i2c_con)) = 0;
+			REG(&i2c_base->i2c_con) = 0;
 			return 1;
 		}
 	}
@@ -209,14 +209,14 @@ static int _davinci_i2c_read(struct i2c_regs *i2c_base, u8 chip,
 	CHECK_NACK();
 
 	if (!(tmp & I2C_STAT_SCD)) {
-		REG(&(i2c_base->i2c_con)) = 0;
+		REG(&i2c_base->i2c_con) = 0;
 		return 1;
 	}
 
 	_flush_rx(i2c_base);
-	REG(&(i2c_base->i2c_stat)) = 0xffff;
-	REG(&(i2c_base->i2c_cnt)) = 0;
-	REG(&(i2c_base->i2c_con)) = 0;
+	REG(&i2c_base->i2c_stat) = 0xffff;
+	REG(&i2c_base->i2c_cnt) = 0;
+	REG(&i2c_base->i2c_con) = 0;
 
 	return 0;
 }
@@ -242,10 +242,10 @@ static int _davinci_i2c_write(struct i2c_regs *i2c_base, u8 chip,
 	/* Start address phase */
 	tmp = I2C_CON_EN | I2C_CON_MST | I2C_CON_STT |
 		I2C_CON_TRX | I2C_CON_STP;
-	REG(&(i2c_base->i2c_cnt)) = (alen == 0) ?
+	REG(&i2c_base->i2c_cnt) = (alen == 0) ?
 		len & 0xffff : (len & 0xffff) + alen;
-	REG(&(i2c_base->i2c_sa)) = chip;
-	REG(&(i2c_base->i2c_con)) = tmp;
+	REG(&i2c_base->i2c_sa) = chip;
+	REG(&i2c_base->i2c_con) = tmp;
 
 	switch (alen) {
 	case 2:
@@ -255,9 +255,9 @@ static int _davinci_i2c_write(struct i2c_regs *i2c_base, u8 chip,
 		CHECK_NACK();
 
 		if (tmp & I2C_STAT_XRDY) {
-			REG(&(i2c_base->i2c_dxr)) = (addr >> 8) & 0xff;
+			REG(&i2c_base->i2c_dxr) = (addr >> 8) & 0xff;
 		} else {
-			REG(&(i2c_base->i2c_con)) = 0;
+			REG(&i2c_base->i2c_con) = 0;
 			return 1;
 		}
 		/* No break, fall through */
@@ -268,9 +268,9 @@ static int _davinci_i2c_write(struct i2c_regs *i2c_base, u8 chip,
 		CHECK_NACK();
 
 		if (tmp & I2C_STAT_XRDY) {
-			REG(&(i2c_base->i2c_dxr)) = addr & 0xff;
+			REG(&i2c_base->i2c_dxr) = addr & 0xff;
 		} else {
-			REG(&(i2c_base->i2c_con)) = 0;
+			REG(&i2c_base->i2c_con) = 0;
 			return 1;
 		}
 	}
@@ -281,7 +281,7 @@ static int _davinci_i2c_write(struct i2c_regs *i2c_base, u8 chip,
 		CHECK_NACK();
 
 		if (tmp & I2C_STAT_XRDY)
-			REG(&(i2c_base->i2c_dxr)) = buf[i];
+			REG(&i2c_base->i2c_dxr) = buf[i];
 		else
 			return 1;
 	}
@@ -291,14 +291,14 @@ static int _davinci_i2c_write(struct i2c_regs *i2c_base, u8 chip,
 	CHECK_NACK();
 
 	if (!(tmp & I2C_STAT_SCD)) {
-		REG(&(i2c_base->i2c_con)) = 0;
+		REG(&i2c_base->i2c_con) = 0;
 		return 1;
 	}
 
 	_flush_rx(i2c_base);
-	REG(&(i2c_base->i2c_stat)) = 0xffff;
-	REG(&(i2c_base->i2c_cnt)) = 0;
-	REG(&(i2c_base->i2c_con)) = 0;
+	REG(&i2c_base->i2c_stat) = 0xffff;
+	REG(&i2c_base->i2c_cnt) = 0;
+	REG(&i2c_base->i2c_con) = 0;
 
 	return 0;
 }
@@ -307,35 +307,35 @@ static int _davinci_i2c_probe_chip(struct i2c_regs *i2c_base, u8 chip)
 {
 	int	rc = 1;
 
-	if (chip == REG(&(i2c_base->i2c_oa)))
+	if (chip == REG(&i2c_base->i2c_oa))
 		return rc;
 
-	REG(&(i2c_base->i2c_con)) = 0;
+	REG(&i2c_base->i2c_con) = 0;
 	if (_wait_for_bus(i2c_base))
 		return 1;
 
 	/* try to read one byte from current (or only) address */
-	REG(&(i2c_base->i2c_cnt)) = 1;
-	REG(&(i2c_base->i2c_sa))  = chip;
-	REG(&(i2c_base->i2c_con)) = (I2C_CON_EN | I2C_CON_MST | I2C_CON_STT |
+	REG(&i2c_base->i2c_cnt) = 1;
+	REG(&i2c_base->i2c_sa)  = chip;
+	REG(&i2c_base->i2c_con) = (I2C_CON_EN | I2C_CON_MST | I2C_CON_STT |
 				     I2C_CON_STP);
 	mdelay(50);
 
-	if (!(REG(&(i2c_base->i2c_stat)) & I2C_STAT_NACK)) {
+	if (!(REG(&i2c_base->i2c_stat) & I2C_STAT_NACK)) {
 		rc = 0;
 		_flush_rx(i2c_base);
-		REG(&(i2c_base->i2c_stat)) = 0xffff;
+		REG(&i2c_base->i2c_stat) = 0xffff;
 	} else {
-		REG(&(i2c_base->i2c_stat)) = 0xffff;
-		REG(&(i2c_base->i2c_con)) |= I2C_CON_STP;
+		REG(&i2c_base->i2c_stat) = 0xffff;
+		REG(&i2c_base->i2c_con) |= I2C_CON_STP;
 		mdelay(20);
 		if (_wait_for_bus(i2c_base))
 			return 1;
 	}
 
 	_flush_rx(i2c_base);
-	REG(&(i2c_base->i2c_stat)) = 0xffff;
-	REG(&(i2c_base->i2c_cnt)) = 0;
+	REG(&i2c_base->i2c_stat) = 0xffff;
+	REG(&i2c_base->i2c_cnt) = 0;
 	return rc;
 }
 
-- 
2.43.0

