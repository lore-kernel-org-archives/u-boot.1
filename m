Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F2D7CD8C9F
	for <u-boot@archiver.kernel.org>; Mon,  8 Jun 2026 13:06:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 088E984701;
	Mon,  8 Jun 2026 15:06:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=thingy.jp
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=thingy.jp header.i=@thingy.jp header.b="BRdjG0lJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2008A848BC; Mon,  8 Jun 2026 15:06:19 +0200 (CEST)
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com
 [IPv6:2607:f8b0:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 253DD8466E
 for <u-boot@lists.denx.de>; Mon,  8 Jun 2026 15:06:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=thingy.jp
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=daniel@0x0f.com
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-2c0a5354da1so34450575ad.0
 for <u-boot@lists.denx.de>; Mon, 08 Jun 2026 06:06:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=thingy.jp; s=google; t=1780923973; x=1781528773; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=uoPRvs41FI9DrzUZ0z/7vyiyC4Riugg75d15DY4L17c=;
 b=BRdjG0lJ098tyJIF5YhNTlvveKPM2BEz+V/yPW/KO70k9AOaZnR2Vk8I7VMUcHSVec
 fcsJ9YNXdM9CNE/h3dpNk0gulEe2hcyrXGkHWlMTmi/lbUyxuJUxmMUVvOynQBLDsMaI
 3TjpQtMpi1QdJCmelp2jF9S9GI7cQ+A3gpjJA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780923973; x=1781528773;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uoPRvs41FI9DrzUZ0z/7vyiyC4Riugg75d15DY4L17c=;
 b=ojixq3R61tMxL4JgQzS3hlAMeYIZ9mu0rEJ+Y2Fld0+YlV4LMW1kK1Q5KcJRax8H00
 kI24KkQ/qyIQbyTiIZHIcxLSz/hbibxbkZuxglCx0QkzWE0n6gntAgqCSax7wPeED3EH
 a8TrGGgc4nWrTUcE6ZP0cSK/tBtJBncp2e44WVfDpovXTQF2tvBF3IrX1pL0MYL3ypRd
 qfNngZOfXxIo3P70AAPw0QQZkREdBtVOY04pxjP12OPOjp1b372bCJytMwdB7mMwbxoi
 9briDMKC33JN3c3Wc2HMGfYR4AN8LyGgh2PsJy71ECVMxAPfhq6FfnRbSVnh1goa9lIB
 OOMw==
X-Gm-Message-State: AOJu0YyyPT3KZeS/iqG07+JKebbHVcdGYwk7dJdzRMEsdnnL64JR2PrH
 OzCZV63MYz03VjOWaCSFmVVHplN/d78KRu3OXsVV4AbOQ0rEWmj7Az10PruHMSbhYqSVJqFazIV
 VmPKF
X-Gm-Gg: Acq92OHsRBEBYcHNe1kNzg2YqENUjcSuyH3wfSfqJyRtKZNzAV28z5iU1X1/rUvTyfl
 PKDvRtemLpA1qoJhXejOSQecOgcBYZSFi/QR9w2s3fimuq+MUyedI2LBlxtFxdEx/nt8dGaLvJB
 uNbxYsu+rZVeG4rz979dOQHXgueySQL3r2O3IhLpKzwAQJMJ6a2/o4Q13HEtvDyIa0aW1pGtRDX
 rC+3mHaWpiubzNhbecIk/6KOyLu/J8o9qzHHzmZxaUc+KBjq3Af0cRHcSq5YDYlQ3xOTk3VGbkv
 YVcObd1Ycm8KVU10I4X19S5yqJbNeCaU6w2lovIY2orKl4aXPrE5X30kSXf9FlLGEDYROgGzQtU
 y0eeiyQhcUC4uPP3KjKILYuRj1Yq/4ZV3+sYDJSSyorJSmKWs/rA56CrP0tqfwkA8h0xz5ePDo5
 bg56fHTMKRemn8BcnMNeoNDOnRfKXrOVxqVKsnDIHqxAYlgGPRfQnmy2EgIemgNpEVYAY6IWTO4
 KQNCMrrrlIDW1+4g7sCHXkLprvQ8Nvm4w==
X-Received: by 2002:a17:903:3b8c:b0:2bf:361e:3edc with SMTP id
 d9443c01a7336-2c1ec3f61a1mr129413275ad.2.1780923973479; 
 Mon, 08 Jun 2026 06:06:13 -0700 (PDT)
Received: from kinako.work.home.arpa
 (p1909097-ipxg00g01sizuokaden.shizuoka.ocn.ne.jp. [153.129.9.97])
 by smtp.googlemail.com with ESMTPSA id
 d9443c01a7336-2c164f890b2sm183698655ad.26.2026.06.08.06.06.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Jun 2026 06:06:13 -0700 (PDT)
From: Daniel Palmer <daniel@thingy.jp>
To: trini@konsulko.com,
	sjg@chromium.org
Cc: u-boot@lists.denx.de,
	Daniel Palmer <daniel@thingy.jp>
Subject: [PATCH v2] xyz-modem: Select CRC16
Date: Mon,  8 Jun 2026 22:06:06 +0900
Message-ID: <20260608130606.121031-1-daniel@thingy.jp>
X-Mailer: git-send-email 2.53.0
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

- CONFIG_LOADB causes the xyzModem code to get built and that code depends
  on CONFIG_CRC16. If you don't have something else that selects CONFIG_CRC16
  you can unselect it and then the final link will fail:

  LD      u-boot
/usr/bin/m68k-linux-gnu-ld.bfd: common/xyzModem.o: in function `xyzModem_get_hdr':
u-boot/common/xyzModem.c:388:(.text.xyzModem_get_hdr+0x17a): undefined reference to `crc16_ccitt'

- Add CONFIG_YMODEM_SUPPORT, make that select CONFIG_CRC16 and make
  CONFIG_LOADB select CONFIG_YMODEM_SUPPORT.

- SPL/TPL already have Kconfig symbols for ymodem support but the spl
  ymodem code has issues building in the TPL phase and doesn't seem to
  be used:

/usr/bin/aarch64-linux-gnu-ld.bfd: common/spl/spl_ymodem.o: in function `spl_ymodem_load_image':
u-boot/common/spl/spl_ymodem.c:138:(.text.spl_ymodem_load_image+0xdc): undefined reference to `spl_load_simple_fit'
u-boot/common/spl/spl_ymodem.c:138:(.text.spl_ymodem_load_image+0xdc): relocation truncated to fit: R_AARCH64_CALL26 against undefined symbol `spl_load_simple_fit'
make[1]: *** [scripts/Makefile.xpl:546: tpl/u-boot-tpl] Error 1

- Remove the ymodem symbol entirely for TPL.

- Select CONFIG_SPL_CRC16 for SPL.

- Finally, since everyone is now using the ymodem support symbols remove
  the special rule for loadb in the makefile.

Signed-off-by: Daniel Palmer <daniel@thingy.jp>
---

v2: Fix the SPL/TPL stuff as brought up by Tom. This opened a can of
    worms when I tested if the TPL builds or not so I decided to just
    remove the TPL ymodem stuff. It didn't seem to be used in any
    defconfig and there isn't a CONFIG_TPL_CRC16 to enable the needed
    crc16 code anyhow so maybe it hasn't been used for a while?

 cmd/Kconfig            |  1 +
 common/Kconfig         |  4 ++++
 common/Makefile        |  1 -
 common/spl/Kconfig     |  1 +
 common/spl/Kconfig.tpl | 11 +----------
 5 files changed, 7 insertions(+), 11 deletions(-)

diff --git a/cmd/Kconfig b/cmd/Kconfig
index c71c6824a196..503fc51f6bb4 100644
--- a/cmd/Kconfig
+++ b/cmd/Kconfig
@@ -1412,6 +1412,7 @@ config CMD_W1
 config CMD_LOADB
 	bool "loadb"
 	default y
+	select YMODEM_SUPPORT
 	help
 	  Load a binary file over serial line.
 
diff --git a/common/Kconfig b/common/Kconfig
index 8e8c733aa295..0db74aa580e4 100644
--- a/common/Kconfig
+++ b/common/Kconfig
@@ -1274,3 +1274,7 @@ config IO_TRACE
 	  confirm that the driver behaves the same way before and after a code
 	  change. To add support for your architecture, add '#include
 	  <iotrace.h>' to the bottom of arch/<arch>/include/asm/io.h and test.
+
+config YMODEM_SUPPORT
+	bool
+	select CRC16
diff --git a/common/Makefile b/common/Makefile
index d62ea34599ed..6c39c422f980 100644
--- a/common/Makefile
+++ b/common/Makefile
@@ -99,7 +99,6 @@ obj-$(CONFIG_$(PHASE_)LOG) += log.o
 obj-$(CONFIG_$(PHASE_)LOG_CONSOLE) += log_console.o
 obj-$(CONFIG_$(PHASE_)LOG_SYSLOG) += log_syslog.o
 obj-y += s_record.o
-obj-$(CONFIG_CMD_LOADB) += xyzModem.o
 obj-$(CONFIG_$(PHASE_)YMODEM_SUPPORT) += xyzModem.o
 
 obj-$(CONFIG_$(PHASE_)AVB_VERIFY) += avb_verify.o
diff --git a/common/spl/Kconfig b/common/spl/Kconfig
index 5fa94098e498..25f3867f991c 100644
--- a/common/spl/Kconfig
+++ b/common/spl/Kconfig
@@ -1655,6 +1655,7 @@ config SPL_WATCHDOG
 config SPL_YMODEM_SUPPORT
 	bool "Support loading using Ymodem"
 	depends on SPL_SERIAL
+	select SPL_CRC16
 	help
 	  While loading from serial is slow it can be a useful backup when
 	  there is no other option. The Ymodem protocol provides a reliable
diff --git a/common/spl/Kconfig.tpl b/common/spl/Kconfig.tpl
index a535b61ecd35..ea238afbf188 100644
--- a/common/spl/Kconfig.tpl
+++ b/common/spl/Kconfig.tpl
@@ -38,7 +38,7 @@ config TPL_FRAMEWORK
 	default y if SPL_FRAMEWORK
 	help
 	  Enable the SPL framework under common/spl/ for TPL builds.
-	  This framework supports MMC, NAND and YMODEM and other methods
+	  This framework supports MMC, NAND and other methods
 	  loading of U-Boot's SPL stage. If unsure, say Y.
 
 config TPL_BANNER_PRINT
@@ -333,13 +333,4 @@ config TPL_DM_SPI_FLASH
 	help
 	  Enable support for SPI DM flash drivers in TPL.
 
-config TPL_YMODEM_SUPPORT
-	bool "Support loading using Ymodem"
-	depends on TPL_SERIAL
-	help
-	  While loading from serial is slow it can be a useful backup when
-	  there is no other option. The Ymodem protocol provides a reliable
-	  means of transmitting U-Boot over a serial line for using in TPL,
-	  with a checksum to ensure correctness.
-
 endmenu
-- 
2.53.0

