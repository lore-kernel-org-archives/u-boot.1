Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25AD8FF885C
	for <u-boot@archiver.kernel.org>; Sat, 25 Apr 2026 18:06:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 01B2184543;
	Sat, 25 Apr 2026 20:02:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="b4+5Rgh+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 45DE884099; Sat, 25 Apr 2026 19:40:31 +0200 (CEST)
Received: from mail-vs1-xe43.google.com (mail-vs1-xe43.google.com
 [IPv6:2607:f8b0:4864:20::e43])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1122F839D9
 for <u-boot@lists.denx.de>; Sat, 25 Apr 2026 19:40:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jcethrid@gmail.com
Received: by mail-vs1-xe43.google.com with SMTP id
 ada2fe7eead31-612d8a59ca0so5800311137.1
 for <u-boot@lists.denx.de>; Sat, 25 Apr 2026 10:40:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777138828; x=1777743628; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=e2Xwx2NihrmI3wiyjtJsXhyoXs1r+RQxdzldD10AS8c=;
 b=b4+5Rgh+KX27uFIonLXpbSjmjld8C6B7jKj5T1rUXavgBxJDgiQRJifwFbE/BQEeIk
 Dj2vXZXg9Dbwtk1by3kAsfIqJdKC2oURQIrajeN6hKRMn+nINTNsdAcqaTce+FUrwb6p
 dltCC3IIuY3g/ZbNuVCdQReEhOQT4vAPYWnprFts35Yk6UjDOMJyXg9b74wQ5my738yp
 sa4HSk1Gs8BJDQq/qwJGtkx+pZyVOdJhn2p6OmLDr099KshBg7u9VMKa5OLyCLRG07Ui
 mbY6aUmsdBABPNvZtJ8C74mk+ChxewtZFqTXe0FTVxDzIkgpq3tFVG5vaZ6qXHQAspGF
 1TOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777138828; x=1777743628;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=e2Xwx2NihrmI3wiyjtJsXhyoXs1r+RQxdzldD10AS8c=;
 b=Yw2cQ8SeycJaTxvFOS18uUV5MHioXdGIuUg4hbiM4R5QIbZxfwhLQiVvOsBz7y1cv0
 C44m9g6XY3wwLzfK+dwBeqlrIcs6FkyKEqfFo05k7Eqynb2mhOghuhZGkmvPNAYW4y8G
 Vp4SvFtJXdSdlnbr/NlliAxkrjVBxb5tXFKhr9qButBZRoIZQRaBAe0hDa1Le8ZzMt1Z
 Iz+b5oVCOY8WhqRZJ+zGLyyBCvP3HIelu3MdxxJ2jR3wumXZp6krGdpKUwBSwLxb2skc
 1wUZ4hqfPRYB99SRhdjPo3Z26C+2UYnoKkibUXvUxsOcu/s9FpbdtzneN2zZwXBGH+xS
 IiIA==
X-Gm-Message-State: AOJu0YxXrebMXIXfzSVIgzrwDocWbYO4fMmKqv+Mjtio2wyGmuxYT3K7
 Q5LYwTj3a16NnQ4WL9PP0opa3fyTJy68eUHJ7aciHHmYH9hg/xzy0nCVezG0X7gR
X-Gm-Gg: AeBDiesouvVr0NLO1rAZswcLYfqI+xXKsrAC8/kvw/h2WpGhAIWypVTI5TBqU/cuHyp
 gMruioEDlJK07h3RfwDc6H07SiUvn5XclZdS/OpeaQXsjdCOwP9A8df7O72SgmcIijVLB11wivf
 MrUJ+S06fB75dY9lAtasUdXtHMiMHVRS6Fwp2BpKGfkKB0rZWb+j5CSf3b9zLRqZGK6fORep/mn
 Ubr0AbmGOl8MNZVWDiXfKE+BZl3EGWiuWtVreVYp1gyyNVZOKYiBf5EgeeEBgOm8bTyzdGt7Z/B
 M7KCFt0eHTojdcYTiMfaSITsA3gVHQFcnqhHoms9t/uN/spO9amWH4JYlEqk5LG73AgQPkC/pGJ
 5moMOm/rCHKS/6TQU2DEushrSV4qIWb8hqt2o4usHx9iNRo24v5LM18m/ztqwXpP1VAD9uQGRMU
 r6Re9FM8xpW5+v46/73IzZ5goARZA7kHaKbBMtVc2wjqCc
X-Received: by 2002:a05:6214:5c82:b0:8ae:6347:8c91 with SMTP id
 6a1803df08f44-8b027fd8fb0mr378409296d6.3.1776954357266; 
 Thu, 23 Apr 2026 07:25:57 -0700 (PDT)
Received: from cethr-l01.localdomain ([136.56.120.109])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8b02aa4f1f9sm157183266d6.0.2026.04.23.07.25.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Apr 2026 07:25:57 -0700 (PDT)
From: Caleb Ethridge <jcethrid@gmail.com>
To: u-boot@lists.denx.de
Cc: malysagreg@gmail.com, trini@konsulko.com, linux@analog.com,
 philip@philipmolloy.com, sjg@chromium.org,
 Caleb Ethridge <caleb.ethridge@analog.com>
Subject: [PATCH v5 14/15] arm: sc5xx: Add fdt_addr_r, kernel_addr_r,
 and ramdisk_addr_r
Date: Thu, 23 Apr 2026 10:24:49 -0400
Message-Id: <53cf194ead51b7d52dffe9013a8e192cb3effb15.1776954004.git.jcethrid@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1776954004.git.jcethrid@gmail.com>
References: <cover.1776954004.git.jcethrid@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 25 Apr 2026 20:02:44 +0200
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

Add fdt_addr_r, kernel_addr_r, and ramdisk_addr_r to the SC5xx boards.
These variables are currently unused in the environment but will be
used in the future once support for booti commands is added to the
SC5xx boards.

Signed-off-by: Caleb Ethridge <caleb.ethridge@analog.com>
---
 board/adi/sc573-ezlite/sc573-ezlite.env         | 4 ++++
 board/adi/sc584-ezkit/sc584-ezkit.env           | 4 ++++
 board/adi/sc589-ezkit/sc589-ezkit.env           | 4 ++++
 board/adi/sc589-mini/sc589-mini.env             | 4 ++++
 board/adi/sc594-som-ezkit/sc594-som-ezkit.env   | 4 ++++
 board/adi/sc594-som-ezlite/sc594-som-ezlite.env | 4 ++++
 board/adi/sc598-som-ezkit/sc598-som-ezkit.env   | 4 ++++
 board/adi/sc598-som-ezlite/sc598-som-ezlite.env | 4 ++++
 8 files changed, 32 insertions(+)

diff --git a/board/adi/sc573-ezlite/sc573-ezlite.env b/board/adi/sc573-ezlite/sc573-ezlite.env
index ab1acabef53..bc1fdf293c2 100644
--- a/board/adi/sc573-ezlite/sc573-ezlite.env
+++ b/board/adi/sc573-ezlite/sc573-ezlite.env
@@ -3,6 +3,10 @@
  * (C) Copyright 2024 - Analog Devices, Inc.
  */
 
+fdt_addr_r=CONFIG_SYS_LOAD_ADDR
+kernel_addr_r=0x84008000
+ramdisk_addr_r=0x85000000
+
 #define USE_NFS
 #define USE_SPI
 #define USE_RAM
diff --git a/board/adi/sc584-ezkit/sc584-ezkit.env b/board/adi/sc584-ezkit/sc584-ezkit.env
index 0b8035ca6b1..e98abb37476 100644
--- a/board/adi/sc584-ezkit/sc584-ezkit.env
+++ b/board/adi/sc584-ezkit/sc584-ezkit.env
@@ -3,6 +3,10 @@
  * (C) Copyright 2024 - Analog Devices, Inc.
  */
 
+fdt_addr_r=CONFIG_SYS_LOAD_ADDR
+kernel_addr_r=0x8A308000
+ramdisk_addr_r=0x8A800000
+
 #define USE_NFS
 #define USE_SPI
 #define USE_RAM
diff --git a/board/adi/sc589-ezkit/sc589-ezkit.env b/board/adi/sc589-ezkit/sc589-ezkit.env
index 00f90c7942e..d44806b149b 100644
--- a/board/adi/sc589-ezkit/sc589-ezkit.env
+++ b/board/adi/sc589-ezkit/sc589-ezkit.env
@@ -3,6 +3,10 @@
  * (C) Copyright 2024 - Analog Devices, Inc.
  */
 
+fdt_addr_r=CONFIG_SYS_LOAD_ADDR
+kernel_addr_r=0xC4008000
+ramdisk_addr_r=0xC5000000
+
 #define USE_NFS
 #define USE_RAM
 #define USE_MMC
diff --git a/board/adi/sc589-mini/sc589-mini.env b/board/adi/sc589-mini/sc589-mini.env
index 13079ed7527..52b82016e3c 100644
--- a/board/adi/sc589-mini/sc589-mini.env
+++ b/board/adi/sc589-mini/sc589-mini.env
@@ -3,6 +3,10 @@
  * (C) Copyright 2024 - Analog Devices, Inc.
  */
 
+fdt_addr_r=CONFIG_SYS_LOAD_ADDR
+kernel_addr_r=0xC4008000
+ramdisk_addr_r=0xC5000000
+
 #define USE_NFS
 #define USE_RAM
 #define USE_SPI
diff --git a/board/adi/sc594-som-ezkit/sc594-som-ezkit.env b/board/adi/sc594-som-ezkit/sc594-som-ezkit.env
index 324bfae4571..7ed3cf9b454 100644
--- a/board/adi/sc594-som-ezkit/sc594-som-ezkit.env
+++ b/board/adi/sc594-som-ezkit/sc594-som-ezkit.env
@@ -3,6 +3,10 @@
  * (C) Copyright 2024 - Analog Devices, Inc.
  */
 
+fdt_addr_r=CONFIG_SYS_LOAD_ADDR
+kernel_addr_r=0xA3008000
+ramdisk_addr_r=0xA8000000
+
 #define USE_NFS
 #define USE_SPI
 #define USE_OSPI
diff --git a/board/adi/sc594-som-ezlite/sc594-som-ezlite.env b/board/adi/sc594-som-ezlite/sc594-som-ezlite.env
index 324bfae4571..7ed3cf9b454 100644
--- a/board/adi/sc594-som-ezlite/sc594-som-ezlite.env
+++ b/board/adi/sc594-som-ezlite/sc594-som-ezlite.env
@@ -3,6 +3,10 @@
  * (C) Copyright 2024 - Analog Devices, Inc.
  */
 
+fdt_addr_r=CONFIG_SYS_LOAD_ADDR
+kernel_addr_r=0xA3008000
+ramdisk_addr_r=0xA8000000
+
 #define USE_NFS
 #define USE_SPI
 #define USE_OSPI
diff --git a/board/adi/sc598-som-ezkit/sc598-som-ezkit.env b/board/adi/sc598-som-ezkit/sc598-som-ezkit.env
index 324bfae4571..da1ff295b0e 100644
--- a/board/adi/sc598-som-ezkit/sc598-som-ezkit.env
+++ b/board/adi/sc598-som-ezkit/sc598-som-ezkit.env
@@ -3,6 +3,10 @@
  * (C) Copyright 2024 - Analog Devices, Inc.
  */
 
+fdt_addr_r=CONFIG_SYS_LOAD_ADDR
+kernel_addr_r=0x9a200000
+ramdisk_addr_r=0x9c000000
+
 #define USE_NFS
 #define USE_SPI
 #define USE_OSPI
diff --git a/board/adi/sc598-som-ezlite/sc598-som-ezlite.env b/board/adi/sc598-som-ezlite/sc598-som-ezlite.env
index ab1acabef53..3f65fdabe18 100644
--- a/board/adi/sc598-som-ezlite/sc598-som-ezlite.env
+++ b/board/adi/sc598-som-ezlite/sc598-som-ezlite.env
@@ -3,6 +3,10 @@
  * (C) Copyright 2024 - Analog Devices, Inc.
  */
 
+fdt_addr_r=CONFIG_SYS_LOAD_ADDR
+kernel_addr_r=0x9a200000
+ramdisk_addr_r=0x9c000000
+
 #define USE_NFS
 #define USE_SPI
 #define USE_RAM
-- 
2.34.1

