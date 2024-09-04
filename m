Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04FE0CD4842
	for <u-boot@archiver.kernel.org>; Wed,  4 Sep 2024 02:43:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9199288C7D;
	Wed,  4 Sep 2024 04:43:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="UQcI5K84";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 563C088C7E; Wed,  4 Sep 2024 04:43:41 +0200 (CEST)
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com
 [IPv6:2607:f8b0:4864:20::1035])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 42CC288AE8
 for <u-boot@lists.denx.de>; Wed,  4 Sep 2024 04:43:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jim.t90615@gmail.com
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-2d89dbb60bdso233006a91.1
 for <u-boot@lists.denx.de>; Tue, 03 Sep 2024 19:43:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1725417818; x=1726022618; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ixu6u2cpg7yS5qR9/ks4aqGORQxFaKDgU7+UWDltOuU=;
 b=UQcI5K84n74SgknF+FbJ6aq+2GdSVVBpI2oU/VzPhB0jZtz6CEAiqLNlqNO5VjBgAa
 vpDzxkOzokKT0aYF/3p1tQ81oX1DFrwsXKTjXw4Hukk82GAFRG/f3493aeEyLn1LuUTj
 CLft6B1jnugrugJ3wshcPZaJ0NREWIYEUElCiCS4UXGoUQFR7eZWww2hQPluDV0HuOdZ
 lYpq8EcvqJfzqRK9QL1GoBiXCcRiuZfBDEcUcguHtD7etm9UsHViYilYf/IegeHmU0e3
 imWHnLeK2pVDZwsJhXFS/A1JPDL0QgFgYEeENv2c/a6jHQYAnXYdwKbfRgVrjYLS/spZ
 VVqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725417818; x=1726022618;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ixu6u2cpg7yS5qR9/ks4aqGORQxFaKDgU7+UWDltOuU=;
 b=GDqtkvCwx6HB3oFV+4cB+FicBDadyzykqHscOLyW9nu4k+ksbhNd2mOilHamLChR1F
 XH4oCGtSEFRATLfxDvMvBg0TnTIWWcz8+CeZVH6LCn1Hf8cO7kf0hQAy3E9wdZW8NJyb
 hPM3ZQbzrJo9u1LrTQRKHQ9qkyOHQjwkGRsfJpMDKOOaET4GKZnyMiBDScfIIrAN4mVf
 iO+VYt75oB3grN3P6wOIoqv/AULLStsmrkLAHkY0c5bBtSz2zudJvxB8NLYakBuQcmru
 IKxtcSIu9otjcYlrUb1aZFjQjssGUXwYanuBoETr4dzVvWCPnI7ttWfFkqaXzK2bTLIz
 kT8Q==
X-Gm-Message-State: AOJu0Yz30YAxnrhgC3DtWbMbs3ftcMrazDqqWGVjSk9qcGorxR8b5Dgc
 QOzwCSfGVJFKBnBcBcwTENHlg88yC2vl9RP+aLMY2QAZYbfogig8B1sZvmY/
X-Google-Smtp-Source: AGHT+IGlwU5kWl3zxqoJgLIb3XP8Vkm5rpWmSb1ckVbciNfxntKuj6TlDBsRnA7CBowttzI7ht1ynw==
X-Received: by 2002:a17:90a:a88a:b0:2c9:5ecd:e3c5 with SMTP id
 98e67ed59e1d1-2d8563922b8mr20163069a91.33.1725417817810; 
 Tue, 03 Sep 2024 19:43:37 -0700 (PDT)
Received: from cs20-buildserver.. ([180.217.139.107])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2da7ba49b57sm1141829a91.18.2024.09.03.19.43.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Sep 2024 19:43:37 -0700 (PDT)
From: Jim Liu <jim.t90615@gmail.com>
X-Google-Original-From: Jim Liu <JJLIU0@nuvoton.com>
To: JJLIU0@nuvoton.com,
	trini@konsulko.com,
	jim.t90615@gmail.com
Cc: u-boot@lists.denx.de
Subject: [PATCH v1 2/3] configs: arbel_evb: change env offset and boot address
Date: Wed,  4 Sep 2024 10:41:05 +0800
Message-Id: <20240904024106.2030437-3-JJLIU0@nuvoton.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240904024106.2030437-1-JJLIU0@nuvoton.com>
References: <20240904024106.2030437-1-JJLIU0@nuvoton.com>
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

Change env offset and boot address for new design.

Signed-off-by: Jim Liu <JJLIU0@nuvoton.com>
---
 configs/arbel_evb_defconfig | 4 ++--
 include/configs/arbel.h     | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/configs/arbel_evb_defconfig b/configs/arbel_evb_defconfig
index 08753aebc0..9983d3a58b 100644
--- a/configs/arbel_evb_defconfig
+++ b/configs/arbel_evb_defconfig
@@ -7,7 +7,7 @@ CONFIG_NR_DRAM_BANKS=2
 CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
 CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x06208000
 CONFIG_ENV_SIZE=0x40000
-CONFIG_ENV_OFFSET=0x3C0000
+CONFIG_ENV_OFFSET=0x7C0000
 CONFIG_ENV_SECT_SIZE=0x1000
 CONFIG_DM_GPIO=y
 CONFIG_DEFAULT_DEVICE_TREE="nuvoton-npcm845-evb"
@@ -17,7 +17,7 @@ CONFIG_ARCH_NPCM8XX=y
 CONFIG_SYS_SKIP_UART_INIT=y
 CONFIG_TARGET_ARBEL_EVB=y
 CONFIG_SYS_LOAD_ADDR=0x06208000
-CONFIG_ENV_ADDR=0x803C0000
+CONFIG_ENV_ADDR=0x807C0000
 CONFIG_FIT=y
 CONFIG_FIT_VERBOSE=y
 CONFIG_SYS_BOOTM_LEN=0x1400000
diff --git a/include/configs/arbel.h b/include/configs/arbel.h
index 61f6a5e243..b5f684e88f 100644
--- a/include/configs/arbel.h
+++ b/include/configs/arbel.h
@@ -16,7 +16,7 @@
 	{ 9600, 14400, 19200, 38400, 57600, 115200, 230400, 380400, 460800, 921600 }
 
 /* Default environemnt variables */
-#define CFG_EXTRA_ENV_SETTINGS   "uimage_flash_addr=80400000\0"   \
+#define CFG_EXTRA_ENV_SETTINGS   "uimage_flash_addr=80800000\0"   \
 		"stdin=serial\0"   \
 		"stdout=serial\0"   \
 		"stderr=serial\0"    \
-- 
2.34.1

