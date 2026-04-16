Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94777F43697
	for <u-boot@archiver.kernel.org>; Fri, 17 Apr 2026 12:51:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4DC258448C;
	Fri, 17 Apr 2026 14:44:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="lW4gtCEj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5AEC784105; Thu, 16 Apr 2026 17:20:27 +0200 (CEST)
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com
 [IPv6:2607:f8b0:4864:20::f44])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D8F46841F2
 for <u-boot@lists.denx.de>; Thu, 16 Apr 2026 17:20:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jcethrid@gmail.com
Received: by mail-qv1-xf44.google.com with SMTP id
 6a1803df08f44-89fc4147f2eso97202946d6.3
 for <u-boot@lists.denx.de>; Thu, 16 Apr 2026 08:20:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776352823; x=1776957623; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0UyqzTfrtNmu8mlcwq3THfL26yhZKHq1m4GJo51JMRI=;
 b=lW4gtCEjPd6meSQsyQ4BDW5zb1DZIDYwUqFt3/iEmyf7IvWTupzJis2v6vftFdl/TJ
 /ToFKZBPszAZYS7EVwiBPiLNKwS2yHXoJFe+vhZQ2BcFt0EbEcMUixphmv+csOujEkQX
 PAuvPTUkTNDtGlUTLIevNNWaVOOKl4vdzmoVL0jl2iDghp1PjF2M3k82GuQ14sHSCeOy
 h1b1y8LtLcAkKLHCWOo/Fywgn7VkaTVIcgvk36H5wxeuLwGEhLKuJPKD7OXvVHmTYNDz
 MQwQ/XP9o9rxIsjtaeIUXZSIsJnJ+QFlKBBfLei7jrrkJUeG2SQZmo+tcbCGEARr/kNS
 TxzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776352823; x=1776957623;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=0UyqzTfrtNmu8mlcwq3THfL26yhZKHq1m4GJo51JMRI=;
 b=rtK5qnGq1ap8o19cQ0AiF8pdT6PGgrdrg7y6rzS1hwSAdcEfUh3zVBf+ljH37mnnW/
 pTuTF7k67uVoHeGuNZpPWN4CEgy1KMUbAGqqlBSeJF7h/xUxgEDWfgLgdfQ1WviYTWwu
 vXqom/tY3X9mJQLTX7H11xsaTgMB6jjCg0BxqpPCeqGZl+l5sdhin6cEpVhEIYp0edsn
 YPgBvuiJ1IoPEJdksP20ALV2ulMZ2+3/LsJUm2cdrvaPO9s2pOllJVx1eoNlRf8td6Ob
 rVRwCi/AOPFkxvBX6i0DA07MyXzW3xkHFNTcLkbJIBmm23fAG7mh9Da2LtHPoeMp7DJp
 J1SQ==
X-Gm-Message-State: AOJu0Yz81TuI5PFTJ+dSqYzok7DF+tviI6keTBQKKGt5DD2ojm44TGWH
 0WpmhcnXtacxcjsRXUbgCdnRYmVy0wXDPOpUwjfFh2VRuO1wGgLv4YtUSgrM+iSq
X-Gm-Gg: AeBDiesbs6aK4jVPbT0gYvtWqt6C/CJDCQKGimw0f/XgkncmlY1d5bEZIRd8YyQoh8w
 hTqk9di23TrPKQ6D0TmbTlDwDtp9Rv3G5z4bERKapQWtUqzhe/JD/UCU4WaAD58+EiMXNnKtLne
 Q+9GeX/LdA+FgP9TW86LjwjWEyG0L4fEtFXc09HyOxDwtX0mYVSo+dC86RWUr7m18ae5Et/VPrG
 zvPr5XMsdmSjsKtf5pIbVgnf5ajcT9kyGdPkw0mtr937QEriyeWurgDnZWO0eoEz9pxJgcvrwd3
 HUc0kHFYwMKA8HsJMDPSk+ApD88+SJde7hTAMuuhlJBsbM1cxz5kDTvR3mEHZF2Rrqzf5HL1Rig
 fNRavsL6PaWgjt/fvJUJfAQiw2K1WP89AMbVvmjrN78AS4Kez/JQIMdyXf+hOqHRqivV9dbKW+2
 BC/t4LosUYYYAHxw8ofLx9+6WoFX1G8ZD4jA==
X-Received: by 2002:a05:6214:f2b:b0:8ae:660a:be74 with SMTP id
 6a1803df08f44-8ae660ac6b8mr151023466d6.7.1776352823479; 
 Thu, 16 Apr 2026 08:20:23 -0700 (PDT)
Received: from cethr-l01.localdomain ([136.56.120.109])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8ae6c93b7e2sm38561586d6.8.2026.04.16.08.20.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Apr 2026 08:20:23 -0700 (PDT)
From: Caleb Ethridge <jcethrid@gmail.com>
To: u-boot@lists.denx.de
Cc: malysagreg@gmail.com, trini@konsulko.com, linux@analog.com,
 philip@philipmolloy.com, Caleb Ethridge <caleb.ethridge@analog.com>
Subject: [RESEND v4 10/14] mach-sc5xx: Update SPI bootargs for ubifs
Date: Thu, 16 Apr 2026 11:19:45 -0400
Message-Id: <c75ab7b2f97d54a5d6f5b236b5134e9edaf5ea34.1776344788.git.jcethrid@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1776344788.git.jcethrid@gmail.com>
References: <cover.1776344788.git.jcethrid@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 17 Apr 2026 14:44:25 +0200
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

