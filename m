Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CB82CDB474
	for <u-boot@archiver.kernel.org>; Mon, 23 Oct 2023 07:03:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7EA218789B;
	Mon, 23 Oct 2023 09:02:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="YNToYsgC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1B48087895; Mon, 23 Oct 2023 09:02:56 +0200 (CEST)
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com
 [IPv6:2607:f8b0:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EA3C187895
 for <u-boot@lists.denx.de>; Mon, 23 Oct 2023 09:02:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jim.t90615@gmail.com
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-1caa371dcd8so16927225ad.0
 for <u-boot@lists.denx.de>; Mon, 23 Oct 2023 00:02:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1698044572; x=1698649372; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Aq9lQTpR8hTgjs6VJTpxKcp8LSr3JariuZXdSOGcfiI=;
 b=YNToYsgCSSR+6Fs2RyXhiHhWxipM10vEABekPe7x6Wiw59XahwWunYuegJJOKJgDLI
 YbU8jn/8g0UuL6Snq3hVl5/YhebxHRbwpTR5R5fHOSLZw4TawMVG14bKV9wqvPyqCkmO
 0jJ2XKMfyEELv0KfI7mxGw8+6LPJlU+Sz9pZrcMWlcs1N3PXDXJSPssxaFu2sEVVBtDx
 fGOlQGVJNoe+9t9Pe2651wJuLcrE1sr7bKcsEvfSC5xK3Kryfb+qt4w0qmZ94xAWPh+u
 vCOD4unXT7BzVR3j+ykxIxj2PX7XYPrlJqXCrsHBCosZQdNIKIUJYSvnWRl23fTJXdwt
 kw2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698044572; x=1698649372;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Aq9lQTpR8hTgjs6VJTpxKcp8LSr3JariuZXdSOGcfiI=;
 b=d29AjBNkJJAhODhoUvi++AgGQ/9La95Q6crqC3NzUifjZYd4yzV3Em2sqSRlzkSMN1
 BHmBkMerC62f88qT3IsQXayF2fa/wNtDVUXj+8EtIVStwBFgh0/r+01TKsVkS0mlNP9P
 bEvSzH7X7pPLfaqmUWlE+ihQaxmipyRIgiCjyRxuM8vmpN6o3lEcAUaKq4GpYKuxUD/4
 TCUitdnZfKZys6lv3wfvpyz17lyF/XBMKkpIJ7AOE72JI8tq5Qa8wEQ0cCz+F3QrIIl4
 o/ajYnz0uJutwQ/VE8F7Bm/ZB4fv1uRqAtQD7CFd06D/6osaJrPdwlP06FLvu1wdtoqI
 2mGQ==
X-Gm-Message-State: AOJu0Yx9fTGXykHyvZ4ykMRqTbfmp+leeZjdj9OZn3XWs1X8sElPJDZ9
 RNIZUl4XPSAAgUgJr/O8kF0=
X-Google-Smtp-Source: AGHT+IFXvGuPK0cdQI/8NrsU3ODUid1HDl4CWZshs1qRX6vyJ7qx/kO3o61IyOeZSDknCpsRitumIA==
X-Received: by 2002:a17:902:f293:b0:1c9:e229:f5e2 with SMTP id
 k19-20020a170902f29300b001c9e229f5e2mr5498767plc.34.1698044572254; 
 Mon, 23 Oct 2023 00:02:52 -0700 (PDT)
Received: from cs20-buildserver.lan ([1.200.144.223])
 by smtp.gmail.com with ESMTPSA id
 13-20020a170902c24d00b001c74876f018sm5368432plg.18.2023.10.23.00.02.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Oct 2023 00:02:51 -0700 (PDT)
From: Jim Liu <jim.t90615@gmail.com>
X-Google-Original-From: Jim Liu <JJLIU0@nuvoton.com>
To: JJLIU0@nuvoton.com, YSCHU@nuvoton.com, KWLIU@nuvoton.com,
 trini@konsulko.com, jim.t90615@gmail.com
Cc: u-boot@lists.denx.de
Subject: [PATCH v4 2/4] configs: npcm: Support more uart baud rate
Date: Mon, 23 Oct 2023 15:02:23 +0800
Message-Id: <20231023070225.3142578-3-JJLIU0@nuvoton.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231023070225.3142578-1-JJLIU0@nuvoton.com>
References: <20231023070225.3142578-1-JJLIU0@nuvoton.com>
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

Add uart baud rate table to arbel(npcm8xx) and poleg(npcm7xx)

Signed-off-by: Jim Liu <JJLIU0@nuvoton.com>

Changes for v2:
   - Add commit message
Changes for v3:
   - Modify CONFIG_SYS_BAUDRATE_TABLE
Changes for v4:
   - No change

---
 include/configs/arbel.h | 5 ++++-
 include/configs/poleg.h | 2 ++
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/include/configs/arbel.h b/include/configs/arbel.h
index 891257bc93..29010503d3 100644
--- a/include/configs/arbel.h
+++ b/include/configs/arbel.h
@@ -7,11 +7,14 @@
 #define __CONFIG_ARBEL_H
 
 #define CFG_SYS_SDRAM_BASE		0x0
-#define CFG_SYS_BOOTMAPSZ		(30 << 20)
+#define CFG_SYS_BOOTMAPSZ		(128 << 20)
 #define CFG_SYS_BOOTM_LEN		(20 << 20)
 #define CFG_SYS_INIT_RAM_ADDR	CFG_SYS_SDRAM_BASE
 #define CFG_SYS_INIT_RAM_SIZE	0x8000
 
+#define CFG_SYS_BAUDRATE_TABLE	{ 9600, 14400, 19200, 38400, 57600, 115200, 230400, \						  380400, 460800, 921600 }
+
+
 /* Default environemnt variables */
 #define CFG_EXTRA_ENV_SETTINGS   "uimage_flash_addr=80400000\0"   \
 		"stdin=serial\0"   \
diff --git a/include/configs/poleg.h b/include/configs/poleg.h
index 1e96e838be..2a2d85c8ec 100644
--- a/include/configs/poleg.h
+++ b/include/configs/poleg.h
@@ -13,6 +13,8 @@
 #define CFG_SYS_BOOTMAPSZ            (0x30 << 20)
 #define CFG_SYS_SDRAM_BASE           0x0
 
+#define CFG_SYS_BAUDRATE_TABLE	{ 57600, 115200, 230400, 460800 }
+
 /* Default environemnt variables */
 #define CFG_EXTRA_ENV_SETTINGS   "uimage_flash_addr=80200000\0"   \
 		"stdin=serial\0"   \
-- 
2.25.1

