Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8AF9C3DA49
	for <u-boot@archiver.kernel.org>; Thu, 18 Jul 2024 17:38:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1B56688B16;
	Thu, 18 Jul 2024 19:36:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="nZw9Tjk8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0B9BB88B25; Thu, 18 Jul 2024 19:36:55 +0200 (CEST)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E6BCC88B0D
 for <u-boot@lists.denx.de>; Thu, 18 Jul 2024 19:36:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4266f344091so5045775e9.0
 for <u-boot@lists.denx.de>; Thu, 18 Jul 2024 10:36:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1721324205; x=1721929005; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QBPkwFkF1dHjMzr/6xPgULo3aQXuISwUaqKYYxG9cb4=;
 b=nZw9Tjk8vXKz+WaWkSvPQq85+1xmemPhToZ0ZSe0oj2v4q4jt4fM+c5lapHH5vTbwo
 tvsfC66GmoT/6EeXvUI1S0JmpLuOeCU6lb/rjxRCQx0tz0PSFycktwW2j4O7kVwfJZR/
 pFINKv93v+LDTKHoiEwBRVuE68cgUg9QnepbA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721324205; x=1721929005;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QBPkwFkF1dHjMzr/6xPgULo3aQXuISwUaqKYYxG9cb4=;
 b=Ma65kMVF18Q1AQ3a8lCgTz8D3ivYl5PaD+fWjpSHEPxNMdm90NA/lCh7EEOoaSAiY4
 NI8vV3tlJVYKkxMJmF9zUdzx91DUCE67VOzVEs6Hi2TWFRlI5KoW8ckSdINZR9kXAdqm
 D8k6z5JctYQ0wsQsUDmvqoFkJoGEU+3u0sKFh7Ydtqal6qsgzpL/VgzOGBZzNpDOfvNn
 vx7QOK5Qm72rcSbFKHCfv2KtXpcl/TT19jzvygnx3RGEQNEs/8tkZ4tD2yOphAoCTGgy
 Mgvg5MdKjuJaK64eJFuXfjbwhso1zRlH+lQzhx7/knKSEu3D10h+yurFOh4J/giq3+tC
 bu9Q==
X-Gm-Message-State: AOJu0YzJqzIuD0igRRFH9v0vHLyPPfXHriAtEazlcv2BfuAYsvint75j
 DAtztaxLzk7GIQym9cCKn14qmqgmuvVllgTldt/zkP/rlOjzM9ExEX0Fj1diyzLH5HCepgaGUbI
 =
X-Google-Smtp-Source: AGHT+IGxGd4Gorzvc68C2iWfMPHGx3rm6pRS803eym4LBS/Cp0DABLtnFan7x6HiBho+i7e6sOOZiQ==
X-Received: by 2002:a05:600c:5801:b0:426:59ec:179d with SMTP id
 5b1f17b1804b1-427c2d00125mr37948455e9.38.1721324205296; 
 Thu, 18 Jul 2024 10:36:45 -0700 (PDT)
Received: from tasman.. (host-92-15-194-143.as13285.net. [92.15.194.143])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427d2b29396sm20950715e9.32.2024.07.18.10.36.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Jul 2024 10:36:44 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Heiko Schocher <hs@denx.de>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH 13/20] i2c: Drop reference to SYS_I2C_INIT_BOARD
Date: Thu, 18 Jul 2024 18:36:04 +0100
Message-Id: <20240718173611.4014274-14-sjg@chromium.org>
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

This is not now used by any boards, so drop it.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

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
index 1f2afc65e8b..6b2bff03f13 100644
--- a/drivers/i2c/soft_i2c.c
+++ b/drivers/i2c/soft_i2c.c
@@ -108,16 +108,13 @@ DECLARE_GLOBAL_DATA_PTR;
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
@@ -145,7 +142,6 @@ static void send_reset(void)
 	send_stop();
 	I2C_TRISTATE;
 }
-#endif
 
 /*-----------------------------------------------------------------------
  * START: High -> Low on SDA while SCL is High
@@ -278,12 +274,6 @@ static uchar read_byte(int ack)
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
@@ -291,7 +281,6 @@ static void soft_i2c_init(struct i2c_adapter *adap, int speed, int slaveaddr)
 	 * system will crash.
 	 */
 	send_reset ();
-#endif
 }
 
 /*-----------------------------------------------------------------------
-- 
2.34.1

