Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCDDAF46C79
	for <u-boot@archiver.kernel.org>; Mon,  6 Apr 2026 19:48:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4E9638419E;
	Mon,  6 Apr 2026 21:46:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="XtAT6nLO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B1E5F83E36; Mon,  6 Apr 2026 21:21:47 +0200 (CEST)
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com
 [IPv6:2607:f8b0:4864:20::f43])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 884E28352B
 for <u-boot@lists.denx.de>; Mon,  6 Apr 2026 21:21:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jcethrid@gmail.com
Received: by mail-qv1-xf43.google.com with SMTP id
 6a1803df08f44-89cda8de641so52975156d6.0
 for <u-boot@lists.denx.de>; Mon, 06 Apr 2026 12:21:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775503304; x=1776108104; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0UyqzTfrtNmu8mlcwq3THfL26yhZKHq1m4GJo51JMRI=;
 b=XtAT6nLOx1vSQwIQQofjNRCUQmIx/6IxntoGP2oT+x4RW9uXZir5drN8h1Casgf+5U
 5mc73BYxs6M/aMGZUls2O+EIIa3pkOfMAMzmuxpA93ZHgym4+ZfQ0EezMbGlGGDPSahM
 tzkjvTlB2WwVEpyBe0lgGOGgU/4Vihm1xCSRuk/ci5EOLcfsfjdfMwPOnYcsd1JkwsW9
 nvijdswNbSI9rxSmfW3LGEvlzji2qUW72lloShJRGAG7rr73M5K1DuLtXEWWkLcQY94e
 4VDeV3TK7/w6hPtXva2QWsW9nK/8Jx+l7++rvLyxfztuGoPZhVOYhTlrmF7aq2xd0uAg
 2x+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775503304; x=1776108104;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=0UyqzTfrtNmu8mlcwq3THfL26yhZKHq1m4GJo51JMRI=;
 b=mDbKbWQgQbqBPoWP029Ytwv9WNMPcU4akX3/uRm4m0fCpV32RIjBJ07pOG/pXHuk5U
 FjrVt2LzOp0ai5laDqITSCmGJqDwPbXt2aJ1kS4p6QnEyc74q9svfUUhsKZKi/wBIgNc
 x/iKpTkBSBfX9Ggo2xT/obi1/nplvnDPka9vxwLcHdLS2wwOPNgr0JM5OTgI2YicD1bU
 pez3fstyWmmdf7keUiybY5Hyv7BisDLwdeTE1C9e4p13dk7EuFHpWEZ/bfrPGM9oGT6x
 fiN0HPPOjEeOatvJcXQ4i9K3mLfH7v3tLUe6RrFa6rItefCtdyogWSULKKGLMj8QCbdE
 QJ9Q==
X-Gm-Message-State: AOJu0YwOKF0RO8H7SDkKDKnLMlpZFS9BkUPRMwR99KZJBcIgf6snAvUS
 fHbYEn1n4EC0SaVeov2+IS1NR3wryOjcov5zpKFLzUt5FkyTU1fPf4vYTE/38kcJ
X-Gm-Gg: AeBDievxq0aSN01eGcB+eu10LLJ19m1YsFpvj8YNSaic7ENrmfiyBpc5uFWx24q3Lk1
 rbz4I5ytVAXb5z+KqB1EnJzf9AjfNOn+GJMEazUf9No8N2pxSGRW/vmFNxsZJ7uW+x1tqgISxay
 IlYR63R14AANu1GkzevgGitmLcbebSYJQn/hqVIfxHUQGAE9fatEKjEW6T8r7AMf5X7nDalKXr+
 kPkzgx1u3VmudT+sJuSEwsqmF45aQp90icx8NiGKCZNZqB1Tt3RUAtTv6945wnJpBl+ZiFJA4He
 /baIRoyaC4C8OHXOqys1GmztGbfmBgjlfDfp458GhwIwumtS5s2UVeDM/sI8GNv4Lxcdp1kl3pE
 GeNZ5An3S3jmxdaNcvpcdRWOKm5v7w26YLoGQ9WPD1HK5mUq/5ADtpUkp3MES6eLJgUB7QfEnK5
 ESAs7ufKtNyf0xVAOMx2cU5nO1e8VUZPOhFg==
X-Received: by 2002:a05:6214:5c49:b0:899:fc48:4e68 with SMTP id
 6a1803df08f44-8a7021bb9a2mr245179616d6.4.1775503304254; 
 Mon, 06 Apr 2026 12:21:44 -0700 (PDT)
Received: from cethr-l01.localdomain ([136.56.120.109])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8a596e03dc6sm150191166d6.34.2026.04.06.12.21.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Apr 2026 12:21:44 -0700 (PDT)
From: Caleb Ethridge <jcethrid@gmail.com>
To: u-boot@lists.denx.de
Cc: malysagreg@gmail.com, trini@konsulko.com, linux@analog.com,
 philip@philipmolloy.com, Caleb Ethridge <caleb.ethridge@analog.com>
Subject: [PATCH v3 10/13] mach-sc5xx: Update SPI bootargs for ubifs
Date: Mon,  6 Apr 2026 15:06:12 -0400
Message-Id: <9d1fb30e71ee96a3168b16fb4398050951407968.1775500819.git.jcethrid@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1775500819.git.jcethrid@gmail.com>
References: <cover.1775500819.git.jcethrid@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 06 Apr 2026 21:46:28 +0200
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
index 4ee08deb1b3..c909b3b476a 100644
--- a/board/adi/sc573-ezlite/sc573-ezlite.env
+++ b/board/adi/sc573-ezlite/sc573-ezlite.env
@@ -3,7 +3,6 @@
  * (C) Copyright 2024 - Analog Devices, Inc.
  */
 
-jffs2file=adsp-sc5xx-__stringify(CONFIG_ADI_IMAGE)-adsp-sc573-ezkit.jffs2
 adi_image_offset=0xd0000
 loadaddr=CONFIG_SC5XX_LOADADDR
 
diff --git a/board/adi/sc584-ezkit/sc584-ezkit.env b/board/adi/sc584-ezkit/sc584-ezkit.env
index 20e5ee0eb76..1090d2731a5 100644
--- a/board/adi/sc584-ezkit/sc584-ezkit.env
+++ b/board/adi/sc584-ezkit/sc584-ezkit.env
@@ -3,7 +3,6 @@
  * (C) Copyright 2024 - Analog Devices, Inc.
  */
 
-jffs2file=adsp-sc5xx-__stringify(CONFIG_ADI_IMAGE)-adsp-sc584-ezkit.jffs2
 adi_image_offset=0xd0000
 loadaddr=CONFIG_SC5XX_LOADADDR
 
diff --git a/board/adi/sc589-ezkit/sc589-ezkit.env b/board/adi/sc589-ezkit/sc589-ezkit.env
index 6f314542ecc..02567830c16 100644
--- a/board/adi/sc589-ezkit/sc589-ezkit.env
+++ b/board/adi/sc589-ezkit/sc589-ezkit.env
@@ -3,7 +3,6 @@
  * (C) Copyright 2024 - Analog Devices, Inc.
  */
 
-jffs2file=adsp-sc5xx-__stringify(CONFIG_ADI_IMAGE)-adsp-sc589-ezkit.jffs2
 adi_image_offset=0xd0000
 loadaddr=CONFIG_SC5XX_LOADADDR
 
diff --git a/board/adi/sc589-mini/sc589-mini.env b/board/adi/sc589-mini/sc589-mini.env
index c5ea555411e..661c130b835 100644
--- a/board/adi/sc589-mini/sc589-mini.env
+++ b/board/adi/sc589-mini/sc589-mini.env
@@ -3,7 +3,6 @@
  * (C) Copyright 2024 - Analog Devices, Inc.
  */
 
-jffs2file=adsp-sc5xx-__stringify(CONFIG_ADI_IMAGE)-adsp-sc589-mini.jffs2
 adi_image_offset=0xd0000
 loadaddr=CONFIG_SC5XX_LOADADDR
 
diff --git a/board/adi/sc594-som-ezkit/sc594-som-ezkit.env b/board/adi/sc594-som-ezkit/sc594-som-ezkit.env
index 4d86eafe145..f787d972339 100644
--- a/board/adi/sc594-som-ezkit/sc594-som-ezkit.env
+++ b/board/adi/sc594-som-ezkit/sc594-som-ezkit.env
@@ -3,7 +3,6 @@
  * (C) Copyright 2024 - Analog Devices, Inc.
  */
 
-jffs2file=adsp-sc5xx-__stringify(CONFIG_ADI_IMAGE)-adsp-sc594-som-ezkit.jffs2
 adi_image_offset=0x100000
 loadaddr=CONFIG_SC5XX_LOADADDR
 
diff --git a/board/adi/sc594-som-ezlite/sc594-som-ezlite.env b/board/adi/sc594-som-ezlite/sc594-som-ezlite.env
index bfce3a9c9b0..9db35ac8d59 100644
--- a/board/adi/sc594-som-ezlite/sc594-som-ezlite.env
+++ b/board/adi/sc594-som-ezlite/sc594-som-ezlite.env
@@ -3,7 +3,6 @@
  * (C) Copyright 2024 - Analog Devices, Inc.
  */
 
-jffs2file=adsp-sc5xx-__stringify(CONFIG_ADI_IMAGE)-adsp-sc594-som-ezlite.jffs2
 adi_image_offset=0x100000
 loadaddr=CONFIG_SC5XX_LOADADDR
 
diff --git a/board/adi/sc598-som-ezkit/sc598-som-ezkit.env b/board/adi/sc598-som-ezkit/sc598-som-ezkit.env
index cbc5a57c755..f787d972339 100644
--- a/board/adi/sc598-som-ezkit/sc598-som-ezkit.env
+++ b/board/adi/sc598-som-ezkit/sc598-som-ezkit.env
@@ -3,7 +3,6 @@
  * (C) Copyright 2024 - Analog Devices, Inc.
  */
 
-jffs2file=adsp-sc5xx-__stringify(CONFIG_ADI_IMAGE)-adsp-sc598-som-ezkit.jffs2
 adi_image_offset=0x100000
 loadaddr=CONFIG_SC5XX_LOADADDR
 
diff --git a/board/adi/sc598-som-ezlite/sc598-som-ezlite.env b/board/adi/sc598-som-ezlite/sc598-som-ezlite.env
index cbf5d5e60f1..d5364df1613 100644
--- a/board/adi/sc598-som-ezlite/sc598-som-ezlite.env
+++ b/board/adi/sc598-som-ezlite/sc598-som-ezlite.env
@@ -5,6 +5,5 @@
 
 adi_image_offset=0x100000
 loadaddr=CONFIG_SC5XX_LOADADDR
-jffs2file=adsp-sc5xx-__stringify(CONFIG_ADI_IMAGE)-adsp-sc598-som-ezlite.jffs2
 
 #include <env/adi/adi_boot.env>
diff --git a/include/env/adi/adi_boot.env b/include/env/adi/adi_boot.env
index d6caa95325e..046f4f8a410 100644
--- a/include/env/adi/adi_boot.env
+++ b/include/env/adi/adi_boot.env
@@ -3,7 +3,6 @@
  *
  * - adi_image_offset, location of the fitImage on the SPI flash
  * - loadaddr, where you want to load things
- * - jffs2file, name of the jffs2 file for update, ex adsp-sc5xx-tiny-adsp-sc573.jffs2
  */
 
 #ifdef CONFIG_SC59X_64
@@ -48,7 +47,7 @@ mmcboot=mmc rescan;
 #endif
 
 #if defined(USE_SPI)
-spiargs=setenv bootargs root=/dev/mtdblock4 rw rootfstype=jffs2 ${adi_bootargs}; setenv sfdev CONFIG_SC_BOOT_SPI_BUS:CONFIG_SC_BOOT_SPI_SSEL
+spiargs=setenv bootargs rootfstype=ubifs root=ubi0:rootfs ubi.mtd=3 rw ${adi_bootargs}; setenv sfdev CONFIG_SC_BOOT_SPI_BUS:CONFIG_SC_BOOT_SPI_SSEL
 spiboot=run spiargs;
 	sf probe ${sfdev};
 	sf read ${loadaddr} ${adi_image_offset} 0xF00000;
@@ -56,7 +55,7 @@ spiboot=run spiargs;
 #endif
 
 #if defined(USE_OSPI)
-ospiargs=setenv bootargs root=/dev/mtdblock4 rw rootfstype=jffs2 ${adi_bootargs}; setenv sfdev CONFIG_SC_BOOT_OSPI_BUS:CONFIG_SC_BOOT_OSPI_SSEL
+ospiargs=setenv bootargs rootfstype=ubifs root=ubi0:rootfs ubi.mtd=3 rw ${adi_bootargs}; setenv sfdev CONFIG_SC_BOOT_OSPI_BUS:CONFIG_SC_BOOT_OSPI_SSEL
 ospiboot=run ospiargs;
 	sf probe ${sfdev};
 	sf read ${loadaddr} ${adi_image_offset} 0xF00000;
-- 
2.34.1

