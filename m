Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBA4BCA0FF9
	for <u-boot@archiver.kernel.org>; Fri, 29 Aug 2025 14:29:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 13AD78365E;
	Fri, 29 Aug 2025 16:29:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="fqBTW2+a";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DE33583448; Fri, 29 Aug 2025 04:11:43 +0200 (CEST)
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com
 [IPv6:2607:f8b0:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7257E83443
 for <u-boot@lists.denx.de>; Fri, 29 Aug 2025 04:11:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=bhimeswararao.matsa@gmail.com
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-2445806df50so13652725ad.1
 for <u-boot@lists.denx.de>; Thu, 28 Aug 2025 19:11:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1756433499; x=1757038299; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=XcTJdzU9cNet8xn1V51DMB78IZjzspc2/eRcFdGv2q8=;
 b=fqBTW2+aRdNuEqSFK2SRHrPTDFN0cpQv4dRD31ryMhqTHb0L2/FQYI8XAWzD3rtpH/
 4lijPeZOAVuN8y0VmswycRbYJqb1UwZ8AA7vOd9G5WLafLPlVTbp2nXg5WLaTb+sy8bI
 TdGLfjl74t1qudGp/3jZN8ScYDE89fnJ8MxbH8EjK3ADkwtg7bI97c9IaiXr/DVUCL72
 XVFPuBFQkSg9Wu9xurngJxMqAaljaOca1tkn8Mr4yn5orTy6bD/ZOeT6i9uiTZIL7qg6
 aZrbDeFJJ1y+i3QRY/OrKk14E7T2sIeqTmdzMqPSBjOWZYLcEiEPnbBXoZkwVGstNpmz
 NIAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756433499; x=1757038299;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=XcTJdzU9cNet8xn1V51DMB78IZjzspc2/eRcFdGv2q8=;
 b=jdFsYyrPUZcLUIlBCmGicwvLiyBeblGLVVcOVQeZPcolrJGywszcx34GRZMVXDNb60
 YUDhOAjmOYqlyW4pxch765fahDtUPazocFRpK9PO/7nGtc0Xi3+6YUjrppt2ZLLDvAe0
 MHvqY8Eflu/zCzM+IFVqxyCxZZ4HpOOH6uSDbgzios8AazxdRuCp1DNVBMwJSTk9GFza
 kQLwoaNpmyxk50Jq8A/ByfPRNUbs3EqftKtc4Q4qM3mnIdsRtSInvgyyDBVbbfwrGym3
 QoBtAjY2vouUbvK67e5ov2cm8wWo0uOOdONAl0iSE+louztEHtXe74mWj7C7JZhPAONc
 QrKg==
X-Gm-Message-State: AOJu0YxC/XcFnuvw+lz6v1/jXDvrV9owQnzNY09Ka4RN25YnKbFlz6kA
 OAM3ivCu0wHt5+HkwB9Hy513CQCRw4rR16mGn8HHcIPtRzXdCCkFFCY4joMLcPc6
X-Gm-Gg: ASbGncvmAvogy6Z0EovC/Nn6iCzJI4IvgGVSSEWCBZqDtH7Pw/vkbUEnzi8qudfy2eQ
 IE/oWPGdurB7oUNdPekR3IrYGs/dixhHZNPe26SMkebfxEucwAGgJdG85BIK0X/HNhqko7iVHyu
 WgHytQxDjIaj6uu8YtzQm8T/bcA5lWPMLXrsXouSJA86lraOCrEqHY54P94h4EufjGQP1+wf/BP
 rWLtE1/NsknXTqRWlR/71121BFd2tj7bDVpjV0C1LbKPe5QFehOohNX3JWQyCAkLlN1oODxqZoS
 GKbUzRr7QxOK9zzX+GwEg5Ttxr3s50SIUZoeFbQ1ewc+1xOdLrup9idt7lHvQMfJVrVC9cCLxDt
 ht1jqRqQzpqR/mLPfiouoy9PBdNRmYtInRPnNZDjfdIF/mfbuA4C8c0wnzEvNOB2RGVZAbhubwf
 g4Kx10uMS104PbWeEJD3g2
X-Google-Smtp-Source: AGHT+IEKCgEdOKjdVkswztVljxzoNhxWOrwrPTTYBJdFoxhTOhguzJlLXSiJ9bp7lp1tY8THtQXoLg==
X-Received: by 2002:a17:903:1ace:b0:246:51b9:ce4d with SMTP id
 d9443c01a7336-24651b9cf8fmr334579845ad.2.1756433499321; 
 Thu, 28 Aug 2025 19:11:39 -0700 (PDT)
Received: from kumara-Inspiron-15-3530.. ([49.207.207.107])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2490cbc9cb9sm4694055ad.15.2025.08.28.19.11.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Aug 2025 19:11:38 -0700 (PDT)
From: Bhimeswararao Matsa <bhimeswararao.matsa@gmail.com>
To: u-boot@lists.denx.de
Cc: Bhimeswararao Matsa <bhimeswararao.matsa@gmail.com>
Subject: [PATCH] =?UTF-8?q?i2c:=20davinci:=20drop=20unnecessary=20parenthe?=
 =?UTF-8?q?ses=20in=20REG(&=E2=80=A6)?=
Date: Fri, 29 Aug 2025 07:41:28 +0530
Message-ID: <20250829021131.28451-1-bhimeswararao.matsa@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

