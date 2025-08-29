Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42206CA0FF9
	for <u-boot@archiver.kernel.org>; Fri, 29 Aug 2025 14:29:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BB8FB83677;
	Fri, 29 Aug 2025 16:29:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="X18fTg/D";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 85A7C83448; Fri, 29 Aug 2025 04:11:50 +0200 (CEST)
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com
 [IPv6:2607:f8b0:4864:20::531])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1442D83443
 for <u-boot@lists.denx.de>; Fri, 29 Aug 2025 04:11:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=bhimeswararao.matsa@gmail.com
Received: by mail-pg1-x531.google.com with SMTP id
 41be03b00d2f7-b4755f37c3eso1417951a12.3
 for <u-boot@lists.denx.de>; Thu, 28 Aug 2025 19:11:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1756433506; x=1757038306; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bkNIFhI4U6PGpvLpQLJNk9P0i1SQJRu/AHODYNBsNsM=;
 b=X18fTg/D8B/WVueYfjW/2q+S3ppcEN+xpPGmAygheBSpDu8Aw1pEWqX48+3oX+cD7B
 O1Fs5a9OPGjLZhtDROzBsII2qS0zw5W3RY6183CWZf23wkmws9enCPTvtKmm286k1jiR
 ofmNXw0aEhCjm67koeNGkxDzRktN6AgOwRTG5BOob/+NctzLTHDu5d0IeiF2mOyjd8zN
 9TC8x8s/7Rzte1pHdOp4vTA5/GqUAktHncJYxzFtYKG/zKOdyJ2FFjbD5kTMEgn1RkO3
 6yfrmp3BnAMpYriOaneBRphAcfy53NPYeYx4kmtwCfM0s3mV6ZwbCJjFuG89fKfvMjzK
 CfBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756433506; x=1757038306;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bkNIFhI4U6PGpvLpQLJNk9P0i1SQJRu/AHODYNBsNsM=;
 b=BrjXK0tOtoQgc5FRXWm8juRPJX5m04soEYYXwHamaVcf//D5RJBZ4oKzDcXLRmL352
 uuyfLZGStufFSdXruAZeG3oaQmJsoyUx04nLApyrQDtbgosWpjK/aU2aWFWHbgl/oBMN
 JNkm+xv38xW8bx1hLzhQJTdCv99y7eyBcbEx0U3eCXcLQ7qGislenwAm86ByQVMuD75n
 sMvNnj1wI93Vyt4qnYeuaT1GXpwPkG7zBchttiqInuqFrwYGsimB2jWWlpfCS2LQaLaI
 fuUfDntucuyPDcKjInhdDZzy6t2C/gVJ1gNq86xiZ/IFXkfraKygHAEL7z6msvZl/2vg
 5vIw==
X-Gm-Message-State: AOJu0YxPdoJOI026LWgFbwWTodUr97a+c1cmIMtEvIZibis/4AeUZuzL
 bNSShQpnJieM4qFz2Y+Jg0aPXuhBmYGWXiLgR8kVLGxG5k3AsJoCXN3XIsykky+r
X-Gm-Gg: ASbGncsT4Q0l1J8kwpLqWC5K79vP8NusjVLdjubdSXcFH+F6R95qt570JBe0blNyLbL
 Qvy1+tVITNNU1tskBMv2nru1CqyyIfa+GA8xjxzE1gARrZ4/AGT3DUqvlM74KNb4ueN9pFxObHT
 Hr+tsxFcrMRAfp10H4Gyo9y/lR56ynMTtkD9onyySArE1SW41PRlrdzQg5uceH9rNB9XV0JgBZm
 x1+ya/3VgQMLypHUv1pst83osidf8PhY2SzOYWIPut0WD/wgEwJTSUZzXjeGUWjZMdy+AbbOXnX
 /mXNEfDxiMJwm9MytGglsufgVENnyQ0i+5eYUEBTN9MO6gNVqtJf99GgvajOMeSrpmeT7TP4XPK
 2CNYMFyNEurRmR3jos/UTMHoczq29TiZX5Bwi2IZjlUT6R0N3Bjl1C8EZtmD/Xbf/5ZeQwl2VHT
 Nzm4GAlP+qGKPHv0wyYWNz
X-Google-Smtp-Source: AGHT+IEwyCnYWtH/kgCCEKi4CNI6HVuY91wLTb6Mkqmvos9F2o5eC+r2ts6OBQwzsY5ZhFkwBztK6g==
X-Received: by 2002:a17:903:2f44:b0:240:a222:2312 with SMTP id
 d9443c01a7336-2462eeeca94mr327470895ad.44.1756433506109; 
 Thu, 28 Aug 2025 19:11:46 -0700 (PDT)
Received: from kumara-Inspiron-15-3530.. ([49.207.207.107])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2490cbc9cb9sm4694055ad.15.2025.08.28.19.11.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Aug 2025 19:11:45 -0700 (PDT)
From: Bhimeswararao Matsa <bhimeswararao.matsa@gmail.com>
To: u-boot@lists.denx.de
Cc: Bhimeswararao Matsa <bhimeswararao.matsa@gmail.com>
Subject: [PATCH] i2c: davinci: prefer kernel types (u8/u32)
Date: Fri, 29 Aug 2025 07:41:29 +0530
Message-ID: <20250829021131.28451-2-bhimeswararao.matsa@gmail.com>
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

Replace uint8_t/uint32_t with u8/u32 to match U-Boot style
(checkpatch PREFER_KERNEL_TYPES). No functional change.

Signed-off-by: Bhimeswararao Matsa <bhimeswararao.matsa@gmail.com>
---
 drivers/i2c/davinci_i2c.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/i2c/davinci_i2c.c b/drivers/i2c/davinci_i2c.c
index 39132747208..9bba0600e3e 100644
--- a/drivers/i2c/davinci_i2c.c
+++ b/drivers/i2c/davinci_i2c.c
@@ -19,6 +19,7 @@
 #include <asm/arch/i2c_defs.h>
 #include <asm/io.h>
 #include <linux/delay.h>
+#include <linux/types.h>
 #include "davinci_i2c.h"
 
 /* Information about i2c controller */
@@ -87,7 +88,7 @@ static void _flush_rx(struct i2c_regs *i2c_base)
 static uint _davinci_i2c_setspeed(struct i2c_regs *i2c_base,
 				  uint speed)
 {
-	uint32_t	div, psc;
+	u32	div, psc;
 
 	psc = 2;
 	/* SCLL + SCLH */
@@ -122,10 +123,10 @@ static void _davinci_i2c_init(struct i2c_regs *i2c_base,
 	udelay(1000);
 }
 
-static int _davinci_i2c_read(struct i2c_regs *i2c_base, uint8_t chip,
-			     uint32_t addr, int alen, uint8_t *buf, int len)
+static int _davinci_i2c_read(struct i2c_regs *i2c_base, u8 chip,
+			     u32 addr, int alen, u8 *buf, int len)
 {
-	uint32_t	tmp;
+	u32	tmp;
 	int		i;
 
 	if ((alen < 0) || (alen > 2)) {
@@ -220,10 +221,10 @@ static int _davinci_i2c_read(struct i2c_regs *i2c_base, uint8_t chip,
 	return 0;
 }
 
-static int _davinci_i2c_write(struct i2c_regs *i2c_base, uint8_t chip,
-			      uint32_t addr, int alen, uint8_t *buf, int len)
+static int _davinci_i2c_write(struct i2c_regs *i2c_base, u8 chip,
+			      u32 addr, int alen, u8 *buf, int len)
 {
-	uint32_t	tmp;
+	u32	tmp;
 	int		i;
 
 	if ((alen < 0) || (alen > 2)) {
@@ -302,7 +303,7 @@ static int _davinci_i2c_write(struct i2c_regs *i2c_base, uint8_t chip,
 	return 0;
 }
 
-static int _davinci_i2c_probe_chip(struct i2c_regs *i2c_base, uint8_t chip)
+static int _davinci_i2c_probe_chip(struct i2c_regs *i2c_base, u8 chip)
 {
 	int	rc = 1;
 
-- 
2.43.0

