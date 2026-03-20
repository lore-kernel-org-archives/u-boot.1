Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C54281098782
	for <u-boot@archiver.kernel.org>; Fri, 20 Mar 2026 13:07:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4F0838409B;
	Fri, 20 Mar 2026 14:06:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="V//15dg2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 334AA83E36; Fri, 20 Mar 2026 13:53:00 +0100 (CET)
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com
 [IPv6:2607:f8b0:4864:20::741])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 098C183CEA
 for <u-boot@lists.denx.de>; Fri, 20 Mar 2026 13:52:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jcethrid@gmail.com
Received: by mail-qk1-x741.google.com with SMTP id
 af79cd13be357-8cfbfdabf3fso173923285a.3
 for <u-boot@lists.denx.de>; Fri, 20 Mar 2026 05:52:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1774011177; x=1774615977; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=K9u3Rqe5tRo1wU5A8TsSmjUBnB+cC/hVBRkjmAR9mNw=;
 b=V//15dg2BWDk+e22j7q+m5ht50mI6RIA8uuxfPF3vxoLRYmXcnyNqqVTZT4y1ncnMO
 rf7HWPw/qoatwdKSpqUOqORhouPGYN6AmFKID66ka/aknd34zINjD6AHWMZK2c03hIPd
 WEvsuk6wa8cMw5xcw0Q1SZRlGzaykfFBKJFFfBVrBlycbHtbHqnukBdeCfFfHfE1zYbd
 xlkfbjhE4Oreecv4wCYNeYJdNhEedWhWYe6K9qoFdvmiTUW8vzfToTpm68N0p/jQcJZs
 d3jY2sA7ri2EUhi+4E9qiPr6hL1d3WmcuoN1uQs4bJrSVC0NRKBBRVE4T5l2ZxLtR8Bq
 b47Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774011177; x=1774615977;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=K9u3Rqe5tRo1wU5A8TsSmjUBnB+cC/hVBRkjmAR9mNw=;
 b=b8XDQmjCwCxWsXZLTTTybKhKwtSlnJ0P4FD1hJGyx5rKL20ZIoGR+uCpD1JNBxEKxW
 KJ3dZ9tnAKhGVnWEjF5C1mqcK/5Biiu6dUahaCRzVAzCWFaKznsbZoIsxk/CAywsslFw
 AbMmLdq0j/MEC1uHik1/CLUgsR0kI+TRMAlJLGq6gfEoLSTNMT5BJD1bBzvSgSRaEL7D
 06uWkDpLs0/MkhgUVzRHNbqGLT9bJ0liA0SUnqdl1oDd0eHkpDiYyEXD7NRJ3r+o8ZFb
 pRD63r2tXCh/77nZbIBSeRJ/UfsVauWfMzXHaHwOozsqPa1DosRF8LTPOjfBi3AC1S+V
 jidA==
X-Gm-Message-State: AOJu0YwDtPZXqjprWTOaPNLSaQ5iTkVNXx/sTU9/XpFR9/uLbII0UQnW
 80bzLb5ZSennbojxnnJPtDuMO+p8e67C3QxqDwmB56Rt2vfvWnTW+koHH94q7Ul7SptucA==
X-Gm-Gg: ATEYQzwyXahHo6iR2EFgYIcziblVFawGVbgI860qJ6SNNGHWuqqFfAMPWN+VNzHizJa
 OuhDoPB5ABKT4uuHkLyX23OAdl/Cwu8l1Vs9fn5H+Cxvw0NIN3lLkDstOAEfmSiDaUjSj9Ed9jM
 3KnqsJ8ZuV0CYVkuJEoLGFFO56/kh3j+o/rL4zJMnuQ0B0NSHw4dQb3W2aCQVHKkyWODEiYLbOR
 V9Stfm7X9YOoLRnw+jk5QaqivxrrepMavdR/eWi25ZZWLc3On31sh+Xa/l+IhsHUxv0+4oJgNWP
 +P6KGJhJvmIilFAFf301bm9pYPhhQyJg79jQ9ADxkRd17mUKp6X34Zyyyf8Gf/AAQpUyCp8iqqR
 nrKoyzaDCPHlJVubTnnSmUrwOODNstWDVfk/ROQ6DzpKjKiqSg0rjYL3dRnWO4zZOYPhLKYhT4v
 EqEtm6fCAP4KzwfRScKWDls1rmwTzg+MNdfQ==
X-Received: by 2002:a0c:f101:0:b0:89c:64cf:60d9 with SMTP id
 6a1803df08f44-89c859d94d7mr32941066d6.24.1774011176748; 
 Fri, 20 Mar 2026 05:52:56 -0700 (PDT)
Received: from cethr-l01.localdomain ([136.56.120.109])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-89c8537c3b5sm19168166d6.47.2026.03.20.05.52.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Mar 2026 05:52:56 -0700 (PDT)
From: Caleb Ethridge <jcethrid@gmail.com>
To: u-boot@lists.denx.de
Cc: malysagreg@gmail.com, philip@philipmolloy.com, trini@konsulko.com,
 linux@analog.com, Caleb Ethridge <caleb.ethridge@analog.com>
Subject: [PATCH 10/11] mach-sc5xx: Update SPI bootargs for ubifs
Date: Fri, 20 Mar 2026 08:50:25 -0400
Message-Id: <65b2cbb737f01fa299288ee5030558fad2237d5c.1774008927.git.jcethrid@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1774008927.git.jcethrid@gmail.com>
References: <cover.1774008927.git.jcethrid@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 20 Mar 2026 14:06:14 +0100
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

From: Caleb Ethridge <caleb.ethridge@analog.com>

Update the bootargs used in SPI/OSPI bootmode
to reflect change from jffs to ubifs for the
SPI's filesystem.

Signed-off-by: Caleb Ethridge <caleb.ethridge@analog.com>
---
 board/adi/sc573-ezlite/sc573-ezlite.env         | 1 -
 board/adi/sc584-ezkit/sc584-ezkit.env           | 1 -
 board/adi/sc589-ezkit/sc589-ezkit.env           | 1 -
 board/adi/sc589-mini/sc589-mini.env             | 1 -
 board/adi/sc594-som-ezkit/sc594-som-ezkit.env   | 1 -
 board/adi/sc594-som-ezlite/sc594-som-ezlite.env | 1 -
 board/adi/sc598-som-ezkit/sc598-som-ezkit.env   | 1 -
 board/adi/sc598-som-ezlite/sc598-som-ezlite.env | 1 -
 include/env/adi/adi_boot.env                    | 5 ++---
 9 files changed, 2 insertions(+), 11 deletions(-)

diff --git a/board/adi/sc573-ezlite/sc573-ezlite.env b/board/adi/sc573-ezlite/sc573-ezlite.env
index 4e7422b28c3..357649df7e0 100644
--- a/board/adi/sc573-ezlite/sc573-ezlite.env
+++ b/board/adi/sc573-ezlite/sc573-ezlite.env
@@ -4,7 +4,6 @@
  * (C) Copyright 2024 - Analog Devices, Inc.
  */
 
-jffs2file=adsp-sc5xx-__stringify(CONFIG_ADI_IMAGE)-adsp-sc573-ezkit.jffs2
 adi_image_offset=0xd0000
 httpdstp=8000
 loadaddr=CONFIG_SC5XX_LOADADDR
diff --git a/board/adi/sc584-ezkit/sc584-ezkit.env b/board/adi/sc584-ezkit/sc584-ezkit.env
index 1bb334fc6c8..2ee1dedcc88 100644
--- a/board/adi/sc584-ezkit/sc584-ezkit.env
+++ b/board/adi/sc584-ezkit/sc584-ezkit.env
@@ -4,7 +4,6 @@
  * (C) Copyright 2024 - Analog Devices, Inc.
  */
 
-jffs2file=adsp-sc5xx-__stringify(CONFIG_ADI_IMAGE)-adsp-sc584-ezkit.jffs2
 adi_image_offset=0xd0000
 httpdstp=8000
 loadaddr=CONFIG_SC5XX_LOADADDR
diff --git a/board/adi/sc589-ezkit/sc589-ezkit.env b/board/adi/sc589-ezkit/sc589-ezkit.env
index 2f7eed76d96..1a785b5c9f1 100644
--- a/board/adi/sc589-ezkit/sc589-ezkit.env
+++ b/board/adi/sc589-ezkit/sc589-ezkit.env
@@ -4,7 +4,6 @@
  * (C) Copyright 2024 - Analog Devices, Inc.
  */
 
-jffs2file=adsp-sc5xx-__stringify(CONFIG_ADI_IMAGE)-adsp-sc589-ezkit.jffs2
 adi_image_offset=0xd0000
 httpdstp=8000
 loadaddr=CONFIG_SC5XX_LOADADDR
diff --git a/board/adi/sc589-mini/sc589-mini.env b/board/adi/sc589-mini/sc589-mini.env
index fe536737220..70a7eb1299c 100644
--- a/board/adi/sc589-mini/sc589-mini.env
+++ b/board/adi/sc589-mini/sc589-mini.env
@@ -4,7 +4,6 @@
  * (C) Copyright 2024 - Analog Devices, Inc.
  */
 
-jffs2file=adsp-sc5xx-__stringify(CONFIG_ADI_IMAGE)-adsp-sc589-mini.jffs2
 adi_image_offset=0xd0000
 httpdstp=8000
 loadaddr=CONFIG_SC5XX_LOADADDR
diff --git a/board/adi/sc594-som-ezkit/sc594-som-ezkit.env b/board/adi/sc594-som-ezkit/sc594-som-ezkit.env
index 6183da8391b..63d1e2b9e99 100644
--- a/board/adi/sc594-som-ezkit/sc594-som-ezkit.env
+++ b/board/adi/sc594-som-ezkit/sc594-som-ezkit.env
@@ -4,7 +4,6 @@
  * (C) Copyright 2024 - Analog Devices, Inc.
  */
 
-jffs2file=adsp-sc5xx-__stringify(CONFIG_ADI_IMAGE)-adsp-sc594-som-ezkit.jffs2
 adi_image_offset=0x100000
 httpdstp=8000
 loadaddr=CONFIG_SC5XX_LOADADDR
diff --git a/board/adi/sc594-som-ezlite/sc594-som-ezlite.env b/board/adi/sc594-som-ezlite/sc594-som-ezlite.env
index c1d2ea747be..9ae2a8552e0 100644
--- a/board/adi/sc594-som-ezlite/sc594-som-ezlite.env
+++ b/board/adi/sc594-som-ezlite/sc594-som-ezlite.env
@@ -4,7 +4,6 @@
  * (C) Copyright 2024 - Analog Devices, Inc.
  */
 
-jffs2file=adsp-sc5xx-__stringify(CONFIG_ADI_IMAGE)-adsp-sc594-som-ezlite.jffs2
 adi_image_offset=0x100000
 httpdstp=8000
 loadaddr=CONFIG_SC5XX_LOADADDR
diff --git a/board/adi/sc598-som-ezkit/sc598-som-ezkit.env b/board/adi/sc598-som-ezkit/sc598-som-ezkit.env
index a4c87491369..63d1e2b9e99 100644
--- a/board/adi/sc598-som-ezkit/sc598-som-ezkit.env
+++ b/board/adi/sc598-som-ezkit/sc598-som-ezkit.env
@@ -4,7 +4,6 @@
  * (C) Copyright 2024 - Analog Devices, Inc.
  */
 
-jffs2file=adsp-sc5xx-__stringify(CONFIG_ADI_IMAGE)-adsp-sc598-som-ezkit.jffs2
 adi_image_offset=0x100000
 httpdstp=8000
 loadaddr=CONFIG_SC5XX_LOADADDR
diff --git a/board/adi/sc598-som-ezlite/sc598-som-ezlite.env b/board/adi/sc598-som-ezlite/sc598-som-ezlite.env
index 8b23dc6e7d8..ba6433d921c 100644
--- a/board/adi/sc598-som-ezlite/sc598-som-ezlite.env
+++ b/board/adi/sc598-som-ezlite/sc598-som-ezlite.env
@@ -7,6 +7,5 @@
 adi_image_offset=0x100000
 httpdstp=8000
 loadaddr=CONFIG_SC5XX_LOADADDR
-jffs2file=adsp-sc5xx-__stringify(CONFIG_ADI_IMAGE)-adsp-sc598-som-ezlite.jffs2
 
 #include <env/adi/adi_boot.env>
diff --git a/include/env/adi/adi_boot.env b/include/env/adi/adi_boot.env
index b04bd1ba20e..2adf9146282 100644
--- a/include/env/adi/adi_boot.env
+++ b/include/env/adi/adi_boot.env
@@ -3,7 +3,6 @@
  *
  * - adi_image_offset, location of the fitImage on the SPI flash
  * - loadaddr, where you want to load things
- * - jffs2file, name of the jffs2 file for update, ex adsp-sc5xx-tiny-adsp-sc573.jffs2
  */
 
 #ifdef CONFIG_SC59X_64
@@ -47,7 +46,7 @@ mmcboot=mmc rescan;
 #endif
 
 #if defined(USE_SPI)
-spiargs=setenv bootargs root=/dev/mtdblock4 rw rootfstype=jffs2 ${adi_bootargs}; setenv sfdev CONFIG_SC_BOOT_SPI_BUS:CONFIG_SC_BOOT_SPI_SSEL
+spiargs=setenv bootargs rootfstype=ubifs root=ubi0:rootfs ubi.mtd=3 rw ${adi_bootargs}; setenv sfdev CONFIG_SC_BOOT_SPI_BUS:CONFIG_SC_BOOT_SPI_SSEL
 spiboot=run spiargs;
 	sf probe ${sfdev};
 	sf read ${loadaddr} ${adi_image_offset} 0xF00000;
@@ -55,7 +54,7 @@ spiboot=run spiargs;
 #endif
 
 #if defined(USE_OSPI)
-ospiargs=setenv bootargs root=/dev/mtdblock4 rw rootfstype=jffs2 ${adi_bootargs}; setenv sfdev CONFIG_SC_BOOT_OSPI_BUS:CONFIG_SC_BOOT_OSPI_SSEL
+ospiargs=setenv bootargs rootfstype=ubifs root=ubi0:rootfs ubi.mtd=3 rw ${adi_bootargs}; setenv sfdev CONFIG_SC_BOOT_OSPI_BUS:CONFIG_SC_BOOT_OSPI_SSEL
 ospiboot=run ospiargs;
 	sf probe ${sfdev};
 	sf read ${loadaddr} ${adi_image_offset} 0xF00000;
-- 
2.34.1

