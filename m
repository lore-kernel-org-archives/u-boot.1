Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11C6AC52D7B
	for <u-boot@archiver.kernel.org>; Sun, 11 Aug 2024 14:54:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8CD318862E;
	Sun, 11 Aug 2024 16:51:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="CKOoDVEs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9A09188907; Sun, 11 Aug 2024 16:51:24 +0200 (CEST)
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com
 [IPv6:2607:f8b0:4864:20::d32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 70C7B8861A
 for <u-boot@lists.denx.de>; Sun, 11 Aug 2024 16:51:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd32.google.com with SMTP id
 ca18e2360f4ac-81f860c6015so143094039f.0
 for <u-boot@lists.denx.de>; Sun, 11 Aug 2024 07:51:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1723387880; x=1723992680; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=29ndO3HCOfspWRgEC2+8A+wseUHTCFmbmb0XXAtl0yU=;
 b=CKOoDVEsnX9LGjXJuQjLf2aPHlXDEspPm/K4/lznv2Kb6AXSSJeY8oocLSfSTSdIbk
 Xuw0egUL9h8D3S7SBa62oJlPIagT0pGXBXHVRdULGz5y8HmJwT53+TXHe708jWbtL0LV
 LOZbYmOnJj2BJfiHwz1QT4r4Ig7oJsWbPQVXo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723387880; x=1723992680;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=29ndO3HCOfspWRgEC2+8A+wseUHTCFmbmb0XXAtl0yU=;
 b=tV/uVPguFw9Ph4ZoQif8X6xWP2BZRovlBgI4pIZm8AdbW8SHLN7VT80q7+hBXINnxG
 5L5352o8wUSLs9udACxq1Tl8Kor4L94lvwsbQOC0txrKcWfrPYvnU/rud4ORAj66FJFs
 M0tXC03RL358WbiacLlzQDjKq+d+mX2iYpWm2Mof6tNfZf32sfebdGxMbsXB9NjQTXe7
 HHeCbhvd2Z6h5q0GDHK8BTTAr/8Tv94i10rVp0QmWg9GJ8DlBf50HxvfPdI8KrMHbBTV
 aCzFlFO3925JmrX/EJYRis9vAbej0UxF0wPNwqchj7MVZ9XBlHzJB1apvS3Za6TBHwp0
 q0Iw==
X-Gm-Message-State: AOJu0YzmNs0lsAgxKQpXJFUyp3Ez+kmjgFe8kAibAtcW9MqUsHhZEplQ
 fA/lHdo0IA+zzDdkUApTgi+TCJ0lbw0clK05phSurAO4M4lsFusM1DpGp3wLg/7lUwxoJi6Looc
 =
X-Google-Smtp-Source: AGHT+IHNYRu/yJEnkNDCCrwNv1A5IGmr/o7DbcuuYiZbi0M6G3rJLpOmc2x2FZ1Udbm47gN4i32fbA==
X-Received: by 2002:a05:6602:2b85:b0:80b:8cb:e9a2 with SMTP id
 ca18e2360f4ac-8225ee87fa2mr971483039f.9.1723387879980; 
 Sun, 11 Aug 2024 07:51:19 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4ca769fbe17sm1076047173.101.2024.08.11.07.51.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 11 Aug 2024 07:51:19 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Heiko Schocher <hs@denx.de>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v2 08/18] rtc: Drop CFG_SYS_RTC_BUS_NUM
Date: Sun, 11 Aug 2024 08:50:37 -0600
Message-Id: <20240811145047.4189460-9-sjg@chromium.org>
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

This option is very old and the migration deadline was years ago. Drop
it so that the I2C system can be simplified.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 README                        | 5 -----
 cmd/date.c                    | 6 ------
 include/configs/ls1028aqds.h  | 1 -
 include/configs/ls1028ardb.h  | 2 --
 include/configs/ls1046afrwy.h | 1 -
 include/configs/lx2160aqds.h  | 3 ---
 include/configs/lx2160ardb.h  | 3 ---
 include/configs/lx2162aqds.h  | 3 ---
 include/configs/m53menlo.h    | 2 --
 include/configs/tqma6_wru4.h  | 1 -
 include/i2c.h                 | 5 -----
 11 files changed, 32 deletions(-)

diff --git a/README b/README
index c3821c5ce4e..37c959cc9c2 100644
--- a/README
+++ b/README
@@ -893,11 +893,6 @@ The following options need to be configured:
 
 		will skip addresses 0x50 and 0x68 on a board with one I2C bus
 
-		CFG_SYS_RTC_BUS_NUM
-
-		If defined, then this indicates the I2C bus number for the RTC.
-		If not defined, then U-Boot assumes that RTC is on I2C bus 0.
-
 		CONFIG_SOFT_I2C_READ_REPEATED_START
 
 		defining this will force the i2c_read() function in
diff --git a/cmd/date.c b/cmd/date.c
index 755adec1e71..bdb3e199b43 100644
--- a/cmd/date.c
+++ b/cmd/date.c
@@ -42,12 +42,6 @@ static int do_date(struct cmd_tbl *cmdtp, int flag, int argc,
 			return CMD_RET_FAILURE;
 		}
 	}
-#elif CONFIG_IS_ENABLED(SYS_I2C_LEGACY)
-	old_bus = i2c_get_bus_num();
-	i2c_set_bus_num(CFG_SYS_RTC_BUS_NUM);
-#else
-	old_bus = I2C_GET_BUS();
-	I2C_SET_BUS(CFG_SYS_RTC_BUS_NUM);
 #endif
 
 	switch (argc) {
diff --git a/include/configs/ls1028aqds.h b/include/configs/ls1028aqds.h
index 769ece901c1..ed93b51d808 100644
--- a/include/configs/ls1028aqds.h
+++ b/include/configs/ls1028aqds.h
@@ -47,7 +47,6 @@
 #endif
 
 /* RTC */
-#define CFG_SYS_RTC_BUS_NUM         1
 #define I2C_MUX_CH_RTC                 0xB
 
 /* Store environment at top of flash */
diff --git a/include/configs/ls1028ardb.h b/include/configs/ls1028ardb.h
index 0f591e3c4ab..d44ce45fd6b 100644
--- a/include/configs/ls1028ardb.h
+++ b/include/configs/ls1028ardb.h
@@ -10,8 +10,6 @@
 
 #define COUNTER_FREQUENCY_REAL		(get_board_sys_clk() / 4)
 
-#define CFG_SYS_RTC_BUS_NUM         0
-
 /* Store environment at top of flash */
 
 /*
diff --git a/include/configs/ls1046afrwy.h b/include/configs/ls1046afrwy.h
index 5e03a962d10..21804fc6654 100644
--- a/include/configs/ls1046afrwy.h
+++ b/include/configs/ls1046afrwy.h
@@ -66,7 +66,6 @@
 
 /* RTC */
 #define CFG_SYS_I2C_RTC_ADDR		0x51  /* Channel 0 I2C bus 0*/
-#define CFG_SYS_RTC_BUS_NUM			0
 
 /*
  * Environment
diff --git a/include/configs/lx2160aqds.h b/include/configs/lx2160aqds.h
index 3a316e73308..5b397e23d89 100644
--- a/include/configs/lx2160aqds.h
+++ b/include/configs/lx2160aqds.h
@@ -8,9 +8,6 @@
 
 #include "lx2160a_common.h"
 
-/* RTC */
-#define CFG_SYS_RTC_BUS_NUM		0
-
 /* MAC/PHY configuration */
 
 /* Initial environment variables */
diff --git a/include/configs/lx2160ardb.h b/include/configs/lx2160ardb.h
index 6404b359111..e700a7b1135 100644
--- a/include/configs/lx2160ardb.h
+++ b/include/configs/lx2160ardb.h
@@ -8,9 +8,6 @@
 
 #include "lx2160a_common.h"
 
-/* RTC */
-#define CFG_SYS_RTC_BUS_NUM		4
-
 #if defined(CONFIG_FSL_MC_ENET)
 #define AQR113C_PHY_ADDR1		0x0
 #define AQR113C_PHY_ADDR2		0x08
diff --git a/include/configs/lx2162aqds.h b/include/configs/lx2162aqds.h
index 54d7cea4c59..2d0db47b334 100644
--- a/include/configs/lx2162aqds.h
+++ b/include/configs/lx2162aqds.h
@@ -10,9 +10,6 @@
 
 /* USB */
 
-/* RTC */
-#define CFG_SYS_RTC_BUS_NUM		0
-
 /* Initial environment variables */
 #define CFG_EXTRA_ENV_SETTINGS		\
 	EXTRA_ENV_SETTINGS			\
diff --git a/include/configs/m53menlo.h b/include/configs/m53menlo.h
index 9cf46b2c362..c245cbe427b 100644
--- a/include/configs/m53menlo.h
+++ b/include/configs/m53menlo.h
@@ -57,8 +57,6 @@
 #define CFG_FEC_MXC_PHYADDR		0x0
 #endif
 
-#define CFG_SYS_RTC_BUS_NUM		1 /* I2C2 */
-
 /*
  * RTC
  */
diff --git a/include/configs/tqma6_wru4.h b/include/configs/tqma6_wru4.h
index e06fc7fe155..5e21463305a 100644
--- a/include/configs/tqma6_wru4.h
+++ b/include/configs/tqma6_wru4.h
@@ -16,7 +16,6 @@
 /* Watchdog */
 
 /* Config on-board RTC */
-#define CFG_SYS_RTC_BUS_NUM		2
 #define CFG_SYS_I2C_RTC_ADDR		0x68
 /* Turn off RTC square-wave output to save battery */
 
diff --git a/include/i2c.h b/include/i2c.h
index 622540c8265..45ca3d63e3f 100644
--- a/include/i2c.h
+++ b/include/i2c.h
@@ -655,11 +655,6 @@ void i2c_early_init_f(void);
 #undef CFG_SYS_I2C_DIRECT_BUS
 #endif
 
-/* define the I2C bus number for RTC and DTT if not already done */
-#if !defined(CFG_SYS_RTC_BUS_NUM)
-#define CFG_SYS_RTC_BUS_NUM		0
-#endif
-
 struct i2c_adapter {
 	void		(*init)(struct i2c_adapter *adap, int speed,
 				int slaveaddr);
-- 
2.34.1

