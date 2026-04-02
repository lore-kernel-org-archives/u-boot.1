Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95638D6AAE7
	for <u-boot@archiver.kernel.org>; Thu,  2 Apr 2026 15:49:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6C1BC8418A;
	Thu,  2 Apr 2026 17:48:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="DAkV9nzN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3133484020; Thu,  2 Apr 2026 17:29:08 +0200 (CEST)
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com
 [IPv6:2607:f8b0:4864:20::742])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9120183F7D
 for <u-boot@lists.denx.de>; Thu,  2 Apr 2026 17:29:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jcethrid@gmail.com
Received: by mail-qk1-x742.google.com with SMTP id
 af79cd13be357-8cfc2d1fdbfso90879485a.3
 for <u-boot@lists.denx.de>; Thu, 02 Apr 2026 08:29:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775143744; x=1775748544; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0UyqzTfrtNmu8mlcwq3THfL26yhZKHq1m4GJo51JMRI=;
 b=DAkV9nzNFprcQYTwZa8M4Dymr6YkUgwvcohfj+ZH68R0W3Aarpa/I7ycJwY9HuzMT6
 Vvpo5rFxFUPuj95u3PwU4rbZd75+ADP0NHfZUJkv3my45sg32NtxmJM44HmghBhTEpDM
 6DgfX9Nx1B+dhKgdJDX1SptPjyTGYw6t9o06IOPxslEI0Eowjh2E7eXpYZvG9GksPstj
 drQ6sS8MjLRH5JzxkXdb27+RnUIZU1Vz74o495KJp6yTK0pN5WlM9SWddhx0ZmAAEx3q
 Zb10E0PJxsmjIfeD5GmegsS3c6NI7ZbrhwssttGAHstprnMj9wZz0zDEDfbZ1tarrHgU
 JrDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775143744; x=1775748544;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=0UyqzTfrtNmu8mlcwq3THfL26yhZKHq1m4GJo51JMRI=;
 b=iz9jIUFKqiLt/EentIvUjhRtONJbgsU2pLSew0ltdWfh+8J82inW5QCMswCsIcDIsi
 oncp6k5TJ6bu/5kwHQxEPYWoUEV/ksWDC96RBRCttHQEXrIXIZQwzCu0hr+q2MUd9YBH
 /JbQDI08IK1YV70Pa24kUC/cy2/F8FPAcMXHZ1drvdAtxfIy/8pmkS6ZNuCexr13G63w
 cu3SrZMnOZHDI7pbrgSUKbrOd7r6zNswdEyPnfCyKMjB3sqjJzaO0cDP2W/Va4zgJNvV
 MfAdKxl9tSeBcscDKm1W5URpUQMCUqWY9osTaGb9QX+hHgNOtx+Y+0nG7Hlj9QdRP6Dc
 zBpQ==
X-Gm-Message-State: AOJu0Yyf6NK2/S3bgBizNfSyq78XWFJmohwx9wPSbjCVf65bCJ+ixoum
 GndMHw4LnNgh7fLjX3Ys9utgBtr/bj5xgtYcig0IkpxVlwcrn/Wv9vOAwNLy1kne
X-Gm-Gg: ATEYQzxoZ4AGLvdJQLy3oGt9sD6aRip3BLjCPjQFRx5jnRjAnW8z6ZBXJYsTk68VBgH
 kt0YBUnYnyyrLDxyAvA4a8pOvothRdrY753IW2XUZhaLMcr9jPBw52CNdJGGk0XjFJxs75Xy8O3
 DW0ay467K4sLYlpTSq1OD+kiu+X8fQjF9NM14p3tRkrHLy6Ilj1XhCx9p6MO81qQvH5gSalnx2O
 86yEOZjiqKvfeaQElbtV6q4JsST0kTzyz8SMUsx/98NLuGeRZQ4w9iKVzixTFYS84CwX7n8y5/u
 3nqMGKaF09lcWW/yzGrZrc1CRR5lWFm9+46l+iZMgSEQqmuiQH7ZkoriJRULwhV01GEsqVITsVz
 qva0IhEj4ofkCAV1Atom/vfVvngHIP2emc0fQksFpMZVlde7YfntjaeV63YHjN3OgeisxYZoJ16
 zb8X8bN09lOQU29cDSKD93taQ4gnup38qv8/2jV/cA0rQJ
X-Received: by 2002:a05:620a:19a4:b0:8cf:db7b:6224 with SMTP id
 af79cd13be357-8d1b5be0242mr1089003885a.59.1775143743426; 
 Thu, 02 Apr 2026 08:29:03 -0700 (PDT)
Received: from cethr-l01.localdomain ([136.56.120.109])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8d2a5393a07sm239037485a.4.2026.04.02.08.29.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Apr 2026 08:29:03 -0700 (PDT)
From: Caleb Ethridge <jcethrid@gmail.com>
To: u-boot@lists.denx.de
Cc: malysagreg@gmail.com, trini@konsulko.com, linux@analog.com,
 philip@philipmolloy.com, Caleb Ethridge <caleb.ethridge@analog.com>
Subject: [RESEND v2 10/13] mach-sc5xx: Update SPI bootargs for ubifs
Date: Thu,  2 Apr 2026 11:28:33 -0400
Message-Id: <7b4a41a72a0fc1b0a6c9b17fe5bbc050bf6c0170.1775143241.git.jcethrid@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1775143241.git.jcethrid@gmail.com>
References: <cover.1775143241.git.jcethrid@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 02 Apr 2026 17:48:00 +0200
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

