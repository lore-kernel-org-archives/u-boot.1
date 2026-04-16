Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4704FF43699
	for <u-boot@archiver.kernel.org>; Fri, 17 Apr 2026 12:51:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3BCEA844BE;
	Fri, 17 Apr 2026 14:44:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="D8lLx8wr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 397538420C; Thu, 16 Apr 2026 17:20:32 +0200 (CEST)
Received: from mail-vs1-xe42.google.com (mail-vs1-xe42.google.com
 [IPv6:2607:f8b0:4864:20::e42])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0E04084201
 for <u-boot@lists.denx.de>; Thu, 16 Apr 2026 17:20:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jcethrid@gmail.com
Received: by mail-vs1-xe42.google.com with SMTP id
 ada2fe7eead31-612d8a59ca0so1215840137.1
 for <u-boot@lists.denx.de>; Thu, 16 Apr 2026 08:20:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776352829; x=1776957629; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QfX3Y4HRlVlSE9KPBL5PId+AHtD03Q7wPEhbAX1BH3A=;
 b=D8lLx8wryuUBxfA2C8EL7mbc+xC91DeZ/tfKB+0A5r2Bk517mlt/sLIqy7JTj5PSPu
 buLYh2Sx97D0ZKGJWFtpcPDmWeOu/wYFwbS1qWHWqNE1xAnvMH5SKtSKs8XUaTrbIxfa
 WTs7mCJ2WCST77ZVWfjGX6C9KRC82/i9PzicV7eySbN43F/mbUWcU4VoknnV5sfa94wu
 8DRSLYK558WmEh0z0RvvGwIQGvxJ/mNaybmdQ5Kj1UGAfhsHpAvDXLsQpov+ujl52hGu
 TLAqzVrviGwEKEe4b2+3uQ+rZqHCqol1kNfNPfunTZ65y4JwQrrtfsGz9ukzsunYANbC
 Ab+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776352829; x=1776957629;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=QfX3Y4HRlVlSE9KPBL5PId+AHtD03Q7wPEhbAX1BH3A=;
 b=JkcMPagfN5sqBvXY6kySm8YmZABOFvpQmvy43ownVcEAbtrPkZE/kO+Jc3zUCtbUnY
 DJP9ODLVdYTn1SgP8hp57obKMsjwAxah50r9YdBpbak0Q+4RwN1oSUies+ZhRJSI5pIl
 0EQzwei4s5iSK782MGs67Pf42RqyHaMoyuoPWLn+aIgZtfnWGpmCnjSlAQDEwaVAm4uq
 FoA12nPbTZcIK1r7yU96OlyaNgW2HNyQ8YokgSWixXIxaetL6kfRpZZcVBou7N7wkLWH
 m2j9I1ZjeNRMntOePx3wIDdWQgPpTKUF8Hm31d+FPQkLGVPobn3+0Z+ogfpbPcb3dCPX
 FcgQ==
X-Gm-Message-State: AOJu0YzeCQ3udukak7bV7aJzHWP138lbu3EszJ3ACcshupWdZoA2WFTP
 cOB3D34LBESx0/CVhF9GTKshyt9gE6kTU4EYKZSlHrYDTWVfrexjQU2EBkrBsCLn
X-Gm-Gg: AeBDiesmoLGDLRvDiRsbyprfoRhHnkkRBJpW8zhen7xskD7mnTrzS011cb4Bt+EdOic
 knLWpAdFTc67Jo3mJ+omrH8fWGgf586rIIAajKH3XWN/NMMLen5eYJsCJs8Tf33TQl6flH+jBHH
 zfnzyQX/vDJ1HLoqqKi+rsRAbltHNiwKckjJWAtNu9OUCAJHJC6+OgDdwVSOiedQMI68n0G9LfS
 3sZbl8E1Y3/bMARQERtZtCmAEsq33vhKs00ADQ4m0N09NQL9KDmIcjP7S0QOTPoDlNhYOm9lATS
 CXk9Y5uk7MQ0X9NR6LWo+4wbRFi6IRDYOosRMqvd1uJA4DBc2NLb8u5qNKAk2O0M/EX3XS/iMX4
 rhsiiknhEv2D2pHBDZ7U0Ij7bRMUM926Ibj/vH6uWJbYYf1926uMEUDSmrFuyo8mfUtDBGSMqBW
 fxISkFyagpUW94MpPgOrj+HoP+1HWb5CVLYw==
X-Received: by 2002:a05:6102:3e0e:b0:602:7589:6545 with SMTP id
 ada2fe7eead31-60a0198ad58mr14218748137.28.1776352828720; 
 Thu, 16 Apr 2026 08:20:28 -0700 (PDT)
Received: from cethr-l01.localdomain ([136.56.120.109])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8ae6c93b7e2sm38561586d6.8.2026.04.16.08.20.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Apr 2026 08:20:28 -0700 (PDT)
From: Caleb Ethridge <jcethrid@gmail.com>
To: u-boot@lists.denx.de
Cc: malysagreg@gmail.com, trini@konsulko.com, linux@analog.com,
 philip@philipmolloy.com, Caleb Ethridge <caleb.ethridge@analog.com>
Subject: [RESEND v4 14/14] arm: sc5xx: Add fdt_addr_r, kernel_addr_r,
 and initrd_addr
Date: Thu, 16 Apr 2026 11:19:49 -0400
Message-Id: <4b5af507bd698752af52fd318273fb5fe40e53d4.1776344788.git.jcethrid@gmail.com>
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

Add fdt_addr_r, kernel_addr_r, and initrd_addr to the SC5xx boards,
to be used by the booti command.

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
index ab1acabef53..2a62526717d 100644
--- a/board/adi/sc573-ezlite/sc573-ezlite.env
+++ b/board/adi/sc573-ezlite/sc573-ezlite.env
@@ -3,6 +3,10 @@
  * (C) Copyright 2024 - Analog Devices, Inc.
  */
 
+fdt_addr_r=CONFIG_SYS_LOAD_ADDR
+kernel_addr_r=0x84008000
+initrd_addr=0x85000000
+
 #define USE_NFS
 #define USE_SPI
 #define USE_RAM
diff --git a/board/adi/sc584-ezkit/sc584-ezkit.env b/board/adi/sc584-ezkit/sc584-ezkit.env
index 740b7b554cb..48bdb6fb2cd 100644
--- a/board/adi/sc584-ezkit/sc584-ezkit.env
+++ b/board/adi/sc584-ezkit/sc584-ezkit.env
@@ -3,6 +3,10 @@
  * (C) Copyright 2024 - Analog Devices, Inc.
  */
 
+fdt_addr_r=CONFIG_SYS_LOAD_ADDR
+kernel_addr_r=0x8A308000
+initrd_addr=0x8A800000
+
 #define USE_NFS
 #define USE_SPI
 #define USE_RAM
diff --git a/board/adi/sc589-ezkit/sc589-ezkit.env b/board/adi/sc589-ezkit/sc589-ezkit.env
index 00f90c7942e..1cc0e735672 100644
--- a/board/adi/sc589-ezkit/sc589-ezkit.env
+++ b/board/adi/sc589-ezkit/sc589-ezkit.env
@@ -3,6 +3,10 @@
  * (C) Copyright 2024 - Analog Devices, Inc.
  */
 
+fdt_addr_r=CONFIG_SYS_LOAD_ADDR
+kernel_addr_r=0xC4008000
+initrd_addr=0xC5000000
+
 #define USE_NFS
 #define USE_RAM
 #define USE_MMC
diff --git a/board/adi/sc589-mini/sc589-mini.env b/board/adi/sc589-mini/sc589-mini.env
index 13079ed7527..f3d21f3afc3 100644
--- a/board/adi/sc589-mini/sc589-mini.env
+++ b/board/adi/sc589-mini/sc589-mini.env
@@ -3,6 +3,10 @@
  * (C) Copyright 2024 - Analog Devices, Inc.
  */
 
+fdt_addr_r=CONFIG_SYS_LOAD_ADDR
+kernel_addr_r=0xC4008000
+initrd_addr=0xC5000000
+
 #define USE_NFS
 #define USE_RAM
 #define USE_SPI
diff --git a/board/adi/sc594-som-ezkit/sc594-som-ezkit.env b/board/adi/sc594-som-ezkit/sc594-som-ezkit.env
index 324bfae4571..2e88b8099bd 100644
--- a/board/adi/sc594-som-ezkit/sc594-som-ezkit.env
+++ b/board/adi/sc594-som-ezkit/sc594-som-ezkit.env
@@ -3,6 +3,10 @@
  * (C) Copyright 2024 - Analog Devices, Inc.
  */
 
+fdt_addr_r=CONFIG_SYS_LOAD_ADDR
+kernel_addr_r=0xA3008000
+initrd_addr=0xA8000000
+
 #define USE_NFS
 #define USE_SPI
 #define USE_OSPI
diff --git a/board/adi/sc594-som-ezlite/sc594-som-ezlite.env b/board/adi/sc594-som-ezlite/sc594-som-ezlite.env
index bdbfaf0dabe..8cdc7006d1d 100644
--- a/board/adi/sc594-som-ezlite/sc594-som-ezlite.env
+++ b/board/adi/sc594-som-ezlite/sc594-som-ezlite.env
@@ -3,6 +3,10 @@
  * (C) Copyright 2024 - Analog Devices, Inc.
  */
 
+fdt_addr_r=CONFIG_SYS_LOAD_ADDR
+kernel_addr_r=0x80008000
+initrd_addr=0x85000000
+
 #define USE_NFS
 #define USE_SPI
 #define USE_OSPI
diff --git a/board/adi/sc598-som-ezkit/sc598-som-ezkit.env b/board/adi/sc598-som-ezkit/sc598-som-ezkit.env
index 324bfae4571..b9934b0ac5d 100644
--- a/board/adi/sc598-som-ezkit/sc598-som-ezkit.env
+++ b/board/adi/sc598-som-ezkit/sc598-som-ezkit.env
@@ -3,6 +3,10 @@
  * (C) Copyright 2024 - Analog Devices, Inc.
  */
 
+fdt_addr_r=CONFIG_SYS_LOAD_ADDR
+kernel_addr_r=0x9a200000
+initrd_addr=0x9c000000
+
 #define USE_NFS
 #define USE_SPI
 #define USE_OSPI
diff --git a/board/adi/sc598-som-ezlite/sc598-som-ezlite.env b/board/adi/sc598-som-ezlite/sc598-som-ezlite.env
index ab1acabef53..ceb8e4e7776 100644
--- a/board/adi/sc598-som-ezlite/sc598-som-ezlite.env
+++ b/board/adi/sc598-som-ezlite/sc598-som-ezlite.env
@@ -3,6 +3,10 @@
  * (C) Copyright 2024 - Analog Devices, Inc.
  */
 
+fdt_addr_r=CONFIG_SYS_LOAD_ADDR
+kernel_addr_r=0x9a200000
+initrd_addr=0x9c000000
+
 #define USE_NFS
 #define USE_SPI
 #define USE_RAM
-- 
2.34.1

