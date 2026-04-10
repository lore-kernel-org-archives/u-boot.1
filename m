Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66735E99058
	for <u-boot@archiver.kernel.org>; Sat, 11 Apr 2026 07:10:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B0BAC84228;
	Sat, 11 Apr 2026 09:09:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="SZqnrt1X";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 90D548414B; Fri, 10 Apr 2026 15:58:47 +0200 (CEST)
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com
 [IPv6:2607:f8b0:4864:20::844])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 688C284120
 for <u-boot@lists.denx.de>; Fri, 10 Apr 2026 15:58:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jcethrid@gmail.com
Received: by mail-qt1-x844.google.com with SMTP id
 d75a77b69052e-50335b926c2so15444951cf.2
 for <u-boot@lists.denx.de>; Fri, 10 Apr 2026 06:58:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775829524; x=1776434324; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0UyqzTfrtNmu8mlcwq3THfL26yhZKHq1m4GJo51JMRI=;
 b=SZqnrt1XgVnLNHmuQiwvWmoGzxdfe+CjaTJuyXohaCyz49jKiDse0TYB/KNHa16XDB
 c9Kq7TEvbF2T6ImO/nN2MDwCroz4FCMTm31WHAp2mvGTjaBinkr5lUpdAgb0Qvo5eM3r
 YvfH2Vy+aBar/XMqOBsDTHl7GaawybSI2tlIPpPlTYPkUzISWCq+ArOeDdCyI7RuAS03
 qcrAdSoRVSyr2M80ENkw/aIQy8xnwpV7utvE2O6QJ4w/KJcuMa3dRTIXfYbmcGE2U9Qj
 hDJYx7ptcH/lF2mKXvjp7b/Bb/SUDg5QR4S7dpSKuyVmR4abaj/ZtLd00WfqbAPTH6XD
 5j9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775829524; x=1776434324;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=0UyqzTfrtNmu8mlcwq3THfL26yhZKHq1m4GJo51JMRI=;
 b=IEKjLkIB1qQKoRC8Y7u/B98qe3auBQQ6pRNKUp5/OrqVV10oRsDgmhIiL44rXNAolT
 skch7TuSrTtdhEFXJ0j4CXS5jSotmTe780hSHvABHtZgADEMLb5lnnDi0RLLDW91dKy5
 eTPE/RT4QgpUycASS1+8epJozQWjJ+YYfR6kjNY/H28HrPfy/je3ByoWfwId0pJZ1HN6
 rD+XUX+lTdgRpad74b0Pd3g6ILbJ4QE7ZBF8HhAAR2PjvnheSxDN52SmWB/L/cxrP9UW
 q357582etc8y8pSgTPx+c4BeI3AsfWuBQKpyp7dx/GwtUUVIL22NPOM8SWiW+3wKtuPU
 Wcdg==
X-Gm-Message-State: AOJu0YyDt2uMqC+x6ZS3tgeO6zHhuC6FCwKPNiU1tni6uI+viXQpO3hV
 2JN46sjUufmX/I+4sRl6KWI66o8vQvNa5gi1oUad1ttlpx0tfmj84WHpYTJZbWB3
X-Gm-Gg: AeBDiesvUgiLhx8iVKFEaL3qZ9QS+Wt90H7BNuqpIw/GxY4tDfIjMJnnZmDkPKHjbgC
 4SQ1VfLw/EBljYNWy6kwgnMcM1aYx46WoFfhwJPm+P9CIlWIO8rjH/EUekqX95Pa4zpNhHqHKDG
 Q2SpV2HF2B2MMNPLzJt+H5wQUh0RVTDegR0v5Ydb2ZtEKC/7oxxfVVUF03tbGxaPHxKnremr+i3
 cELbbNcorpSPdMwYlTi5lokTgPtwXyHh/CkD5gpFNWvbot754XPRrjUn66iIq5fDSbnbkVz04cT
 dpMXVCUKUOREOOUM9J1Abff87h8Y9WqHSK0GgFUgaSAezZTpqQJ8zaiLwNvgJjU/uQjQbYNu+nc
 z2rCoejo0l8395LzmNJS6aPA6Xfafz+20utgPZcrtMw4Npj3WuqBsmqXKTsLYfztfczWf5VMdHn
 swUq7yh3DoHqmu+V3U7juFZzhqdxDWdjSq7w==
X-Received: by 2002:ac8:588a:0:b0:50d:9c1f:bbe3 with SMTP id
 d75a77b69052e-50dd5b673f6mr46848821cf.16.1775829524092; 
 Fri, 10 Apr 2026 06:58:44 -0700 (PDT)
Received: from cethr-l01.localdomain ([136.56.120.109])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-50dd53f9c16sm21723141cf.11.2026.04.10.06.58.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Apr 2026 06:58:43 -0700 (PDT)
From: Caleb Ethridge <jcethrid@gmail.com>
To: u-boot@lists.denx.de
Cc: malysagreg@gmail.com, trini@konsulko.com, linux@analog.com,
 philip@philipmolloy.com, Caleb Ethridge <caleb.ethridge@analog.com>
Subject: [PATCH v4 10/14] mach-sc5xx: Update SPI bootargs for ubifs
Date: Fri, 10 Apr 2026 09:58:05 -0400
Message-Id: <0089c6acb7f1411d2736cbba43a3a2016303c6b9.1775829166.git.jcethrid@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1775829166.git.jcethrid@gmail.com>
References: <cover.1775829166.git.jcethrid@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 11 Apr 2026 09:08:55 +0200
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

