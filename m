Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E7C3E99058
	for <u-boot@archiver.kernel.org>; Sat, 11 Apr 2026 07:11:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D1D9384258;
	Sat, 11 Apr 2026 09:09:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="nkvHFLvW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 015AE84154; Fri, 10 Apr 2026 15:58:54 +0200 (CEST)
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com
 [IPv6:2607:f8b0:4864:20::841])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2AD0C8416F
 for <u-boot@lists.denx.de>; Fri, 10 Apr 2026 15:58:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jcethrid@gmail.com
Received: by mail-qt1-x841.google.com with SMTP id
 d75a77b69052e-50b69bf5638so22745331cf.1
 for <u-boot@lists.denx.de>; Fri, 10 Apr 2026 06:58:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775829530; x=1776434330; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QfX3Y4HRlVlSE9KPBL5PId+AHtD03Q7wPEhbAX1BH3A=;
 b=nkvHFLvWPnTl2X4IyydYH0UMHrNKZk6QimU0CWCm9yipNi/2QvXJMGLQDb2FGWVcR6
 0L1EzhYqX6NyqbwI3D1Q2650997hPSxb8w3w5ZoAax8jnGMXMYeONPDDzIedN0xiWcC3
 ZYGEhAv7TY4zVN9vPH+zXKooIvYLxOCL1QbQqIX+tmrY3WEL537encPnI/y0aZNqrTUR
 LCvtjEOe7c8O/swF5iK3WTOW84P/2B6vZJ75m5bA2IgtsJ7+FAOK9MF38eeFeZkXQzwb
 SvvhIxyT6rnDIU3jg+2WSOE3RJrJv88uSqoFmqX5rzgEOI7FuymSXRzN7gR9UA0NJYZY
 FanA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775829530; x=1776434330;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=QfX3Y4HRlVlSE9KPBL5PId+AHtD03Q7wPEhbAX1BH3A=;
 b=U7KnBw9vvdorGH0WgbUyp5ULTYqcQVk2YAINDy3io3tronBegCGW7yMCTfTRqLotOv
 I7XMjf+5JYQZlFpvRhK0mTN6lD9iGGz6v7J23PkWRA1rkso2oCbTfQmrYZ3OwN20wjOf
 1zsy5QJvRTW6pExHXCsKrGqAKJ7YiKjjiVCZLGb6RFi0q1/VjrG4OTv/7EA99BlmOMzo
 w/KCnqdTVBO2EOLQMg1aVgp2s/g3/JR9TbDvS2KEN+uKGl9jDQquBxX4AEL+l3H3deQh
 jTwA/gN+c54HRSr5ao+crhMvd3PkZUMcJHLGRT4hObeQVoyZavRBypHGcp+vCoeU/pUK
 KwFQ==
X-Gm-Message-State: AOJu0YxNkb+/JChtJ35tMYfnRoyZvEdVlhvUMLju8iynHp/gHdipKb8K
 GghU1GrAIJSwSHDVPlgUNs5NZUZnmGLINzTXKu7vRCmUNolX26Mr/r0b9GDMimYY
X-Gm-Gg: AeBDievGYcr64MkOxlECAK6t2yeNKeLbJCR4lbqwq07p2uGkY+mdHcPI8c6W4HIolbb
 GJxU4FSNTXrF9bqRYOHx9XuzLVaE25K4J60ILk9DsnwICgZ5mRS0H+024OztL75FLNfCNFK8fRY
 RD5iKxLlPG9rXzXezOoVeIRPEoKoiLwxaaGWxsM1/kBt9BPiLy9yXI66JdDMXZihajmO0aIzFTv
 x+9AzIMmHJ8LnZxw3WVwg2fRY0/wa6lf3C3m/e2JLnNFUjCdxGtLVU72s+1HS47w5o8FAt2EJ5H
 xxE44A1jYYna23udYt29FxkLuk3ceSpmlfciB7eUIizK9Av/nGUcx0qgoyE7OfN6Rva9Q9wIzqJ
 s4COdKKLyZ0kPgupsDrsH0Ixf44rOhOP1MoJhZjthCRkMh8fL7q6MRji6OybbAGy0YbBwswAmSz
 RXiNEep51hbXmZjXrWPtdQ9WaUSyXB9Ts7MiZSjf8KXiTX
X-Received: by 2002:a05:622a:3d0:b0:50b:1932:c9e with SMTP id
 d75a77b69052e-50dd5cc6a95mr45020991cf.39.1775829529731; 
 Fri, 10 Apr 2026 06:58:49 -0700 (PDT)
Received: from cethr-l01.localdomain ([136.56.120.109])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-50dd53f9c16sm21723141cf.11.2026.04.10.06.58.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Apr 2026 06:58:49 -0700 (PDT)
From: Caleb Ethridge <jcethrid@gmail.com>
To: u-boot@lists.denx.de
Cc: malysagreg@gmail.com, trini@konsulko.com, linux@analog.com,
 philip@philipmolloy.com, Caleb Ethridge <caleb.ethridge@analog.com>
Subject: [PATCH v4 14/14] arm: sc5xx: Add fdt_addr_r, kernel_addr_r,
 and initrd_addr
Date: Fri, 10 Apr 2026 09:58:09 -0400
Message-Id: <bf1821a5b0f561df15ab1fd1d7783bb3184d3db9.1775829166.git.jcethrid@gmail.com>
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

