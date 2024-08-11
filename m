Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91D72C52D7B
	for <u-boot@archiver.kernel.org>; Sun, 11 Aug 2024 14:55:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BE7B08896B;
	Sun, 11 Aug 2024 16:51:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="DaurIpEq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8F5EF886F0; Sun, 11 Aug 2024 16:51:26 +0200 (CEST)
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com
 [IPv6:2607:f8b0:4864:20::d36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C1F1988916
 for <u-boot@lists.denx.de>; Sun, 11 Aug 2024 16:51:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd36.google.com with SMTP id
 ca18e2360f4ac-81f94ce2272so139828239f.2
 for <u-boot@lists.denx.de>; Sun, 11 Aug 2024 07:51:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1723387882; x=1723992682; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yIkKBg9t8jTpP06N86JxD9EckB+xNKNG8PQsnI6APSg=;
 b=DaurIpEqeaknTX6h6LFqBnb0A61PzgSugVv9XdN6hFNBRB2YD6vOv0Qurx5RPU1m0y
 KYJj1xpU9M7Ur3INsOnc9CvD7fVUQ3Yf0oZNSs8fZAYHapJ+OxlOqYRMey6VPF/4sQsj
 D2ZEgpwObTy4SAZoHfbLpxebZJVZS+oeYCyJo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723387882; x=1723992682;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yIkKBg9t8jTpP06N86JxD9EckB+xNKNG8PQsnI6APSg=;
 b=BJKzkKBPpXDIus3ghJRqIvNeqvssaZy2wg2bi+zU9d8yvGG3lK/DMELgg2a4w7Hxds
 JxlT5sxEdHZwzFNfh78y1vdPtFb4drs5vP7GJs24DVMoLxyAG+cC/e66GCghPFNSFqU/
 gebX/xO8OIyMN+vFxZaxrPhpRur+YnY5b9+Kb8ovkgXS8fl74aAZvm7guNDC0vvTIBql
 ecg7g6uR7H2nbjTeO9eURbgtK8F5TDGhD/3rRruaatxz+XSlQoZchBjzUD0GKDGBgagH
 L9JiTUq910KcHq8k24jZUAmUmkHufeevZeimjprWIwBRBYI+SA20Y9blNug0i5ThtpJT
 k8qQ==
X-Gm-Message-State: AOJu0YzPNsKIFcC+Fe2LSVA8Ib/hesb4MAvx8QUUyBjeGnqZF4M0Rs0w
 ubt9g84SPa5BAY5EWViC9mhQsP35A120JokBN5elnOlCtCl7sDhLTY6FrRtfkif5rouIVaHU1ZM
 =
X-Google-Smtp-Source: AGHT+IF0iTRpYF97MOG9zGSp2Uk21nQ1Qgw20kT8eDTi7tA1RRRCAImZF31FyjZVC01O2oq/vfCz2w==
X-Received: by 2002:a05:6602:6110:b0:81f:d4db:c7de with SMTP id
 ca18e2360f4ac-8225eedb210mr786472739f.16.1723387882349; 
 Sun, 11 Aug 2024 07:51:22 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4ca769fbe17sm1076047173.101.2024.08.11.07.51.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 11 Aug 2024 07:51:21 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Heiko Schocher <hs@denx.de>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v2 11/18] i2c: Drop reference to SYS_I2C_INIT_BOARD
Date: Sun, 11 Aug 2024 08:50:40 -0600
Message-Id: <20240811145047.4189460-12-sjg@chromium.org>
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

This is not now used by any boards, so drop it.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 doc/I2C_Edge_Conditions | 10 ++++------
 drivers/i2c/soft_i2c.c  | 11 -----------
 2 files changed, 4 insertions(+), 17 deletions(-)

diff --git a/doc/I2C_Edge_Conditions b/doc/I2C_Edge_Conditions
index f4a99687011..9ccb21c5092 100644
--- a/doc/I2C_Edge_Conditions
+++ b/doc/I2C_Edge_Conditions
@@ -31,12 +31,10 @@ Notes
 !!!THIS IS AN UNDOCUMENTED I2C BUS BUG, NOT A AMCC 4xx BUG!!!
 
 This reset edge condition could possibly be present in every I2C
-controller and device available. For boards where a I2C bus reset
-function can be implemented a i2c_init_board() function should be
-provided and enabled by #define'ing CONFIG_SYS_I2C_INIT_BOARD in your
-board's config file. Note that this is NOT necessary when using the
-bit-banging I2C driver (common/soft_i2c.c) as this already includes
-the I2C bus reset sequence.
+controller and device available.
+
+Note that this problem does not happen when using the bit-banging I2C driver
+(common/soft_i2c.c) as this already includes the I2C bus reset sequence.
 
 
 Many thanks to Bill Hunter for finding this serious BUG.
diff --git a/drivers/i2c/soft_i2c.c b/drivers/i2c/soft_i2c.c
index 89ddf821063..79f7a320502 100644
--- a/drivers/i2c/soft_i2c.c
+++ b/drivers/i2c/soft_i2c.c
@@ -107,16 +107,13 @@ DECLARE_GLOBAL_DATA_PTR;
 /*-----------------------------------------------------------------------
  * Local functions
  */
-#if !defined(CONFIG_SYS_I2C_INIT_BOARD)
 static void  send_reset	(void);
-#endif
 static void  send_start	(void);
 static void  send_stop	(void);
 static void  send_ack	(int);
 static int   write_byte	(uchar byte);
 static uchar read_byte	(int);
 
-#if !defined(CONFIG_SYS_I2C_INIT_BOARD)
 /*-----------------------------------------------------------------------
  * Send a reset sequence consisting of 9 clocks with the data signal high
  * to clock any confused device back into an idle state.  Also send a
@@ -144,7 +141,6 @@ static void send_reset(void)
 	send_stop();
 	I2C_TRISTATE;
 }
-#endif
 
 /*-----------------------------------------------------------------------
  * START: High -> Low on SDA while SCL is High
@@ -277,12 +273,6 @@ static uchar read_byte(int ack)
  */
 static void soft_i2c_init(struct i2c_adapter *adap, int speed, int slaveaddr)
 {
-#if defined(CONFIG_SYS_I2C_INIT_BOARD)
-	/* call board specific i2c bus reset routine before accessing the   */
-	/* environment, which might be in a chip on that bus. For details   */
-	/* about this problem see doc/I2C_Edge_Conditions.                  */
-	i2c_init_board();
-#else
 	/*
 	 * WARNING: Do NOT save speed in a static variable: if the
 	 * I2C routines are called before RAM is initialized (to read
@@ -290,7 +280,6 @@ static void soft_i2c_init(struct i2c_adapter *adap, int speed, int slaveaddr)
 	 * system will crash.
 	 */
 	send_reset ();
-#endif
 }
 
 /*-----------------------------------------------------------------------
-- 
2.34.1

