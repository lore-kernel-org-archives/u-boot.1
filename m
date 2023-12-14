Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84AAEC4332F
	for <u-boot@archiver.kernel.org>; Thu, 14 Dec 2023 18:17:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 35F4E87B65;
	Thu, 14 Dec 2023 19:17:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="c5Ap2Cjs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E1C3A87B51; Thu, 14 Dec 2023 19:17:04 +0100 (CET)
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com
 [IPv6:2607:f8b0:4864:20::1135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A3BD387B51
 for <u-boot@lists.denx.de>; Thu, 14 Dec 2023 19:17:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1135.google.com with SMTP id
 00721157ae682-5e35e1dfb99so11079677b3.0
 for <u-boot@lists.denx.de>; Thu, 14 Dec 2023 10:17:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1702577820; x=1703182620; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lK4lLWbnXrEyVF8bp/1hWcm47Y/hj6qtwo1YCENOKNE=;
 b=c5Ap2CjsI6jel2IVfcQBz5WRvtOnfMX3AVDqqeVfBUe7GgI9vWHezDLn7nvYmiksNY
 CaSMlbt3pK6j4XVMXUhvqwVKeRf36be7lr5v8W2MciTk6Xjpuryh5IJiSf6oaVPlBNvI
 m0bz+IE6GBU7zXSQBEWiZZLrJPR2i4oQaLwGw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702577820; x=1703182620;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lK4lLWbnXrEyVF8bp/1hWcm47Y/hj6qtwo1YCENOKNE=;
 b=XBPDliqjEKEuCXh0LM7WsvaOcH/j4sg6mV9jJ2AoqwXmq9RhDgqEWiLJ2WZJcaM24b
 bsxQQknjYH0CZuk0LpfVEMJtZaUijWlOlv+IHYp/KUzDwlkEmDSYn1OHpfsKa3mfZO1t
 +8yqxMX5ElQByvASiqSd3XdxHU/eb5KoC8TNpNPOLhj1wdGBSKH7Ordl76aAFfDP5WZf
 ZFIuGQB/ZK5kA+YklFM/r2wI4rZpaaD00/8tFWPvszraP0p1tBEuzTtak1p/DbD7T1EV
 MCOStfbwSqLpbfMJOapj11XTWQ/v6i1Zr6SiWjQ53efDf6p7gDgYPR7ELjjJSz6htzB1
 LfnA==
X-Gm-Message-State: AOJu0YzsbkixtGeRJfeHq37UQgUItuMckRwxXB0wdDYBQmSyY5EwvbAv
 uVTEEk9+Rbbq3FY0GRq452P9ur51XAOKk4v20OA=
X-Google-Smtp-Source: AGHT+IGXeXBTrATHSZITvVoPgWQ0Tnqmrb/ipAvM/hFZj9eb1THRUbsu6blaek1i8J7AhJ4ml7zC0A==
X-Received: by 2002:a25:6942:0:b0:dbc:dce3:31db with SMTP id
 e63-20020a256942000000b00dbcdce331dbmr1917944ybc.7.1702577820249; 
 Thu, 14 Dec 2023 10:17:00 -0800 (PST)
Received: from bill-the-cat.lan
 (2603-6081-7b00-6400-ef43-b142-0a3d-20b7.res6.spectrum.com.
 [2603:6081:7b00:6400:ef43:b142:a3d:20b7])
 by smtp.gmail.com with ESMTPSA id
 s129-20020a0dd087000000b005d361dd6454sm5665698ywd.87.2023.12.14.10.16.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Dec 2023 10:16:59 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>
Subject: [v2 02/16] arc: Cleanup and audit usage of <config.h>
Date: Thu, 14 Dec 2023 13:16:44 -0500
Message-Id: <20231214181658.3359902-2-trini@konsulko.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231214181658.3359902-1-trini@konsulko.com>
References: <20231214181658.3359902-1-trini@konsulko.com>
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

We need to include <config.h> directly when a file needs to have
something such as CFG_SYS_SDRAM_SIZE referenced as this file is not
automatically globally included and is most commonly indirectly included
via common.h.  Remove most cases of arc including config.h directly, but
add it where needed. Further clean up the tb100 board config.h file so
that we don't rely on config.h being included there for a value used in
a single place.

Signed-off-by: Tom Rini <trini@konsulko.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
---
 arch/arc/include/asm/arc-bcr.h |  2 --
 arch/arc/include/asm/arcregs.h |  1 -
 arch/arc/include/asm/cache.h   |  2 --
 arch/arc/lib/cpu.c             |  1 +
 board/abilis/tb100/tb100.c     |  4 ++++
 include/configs/tb100.h        | 21 ---------------------
 6 files changed, 5 insertions(+), 26 deletions(-)

diff --git a/arch/arc/include/asm/arc-bcr.h b/arch/arc/include/asm/arc-bcr.h
index 823906d946e4..a6c972bf1e31 100644
--- a/arch/arc/include/asm/arc-bcr.h
+++ b/arch/arc/include/asm/arc-bcr.h
@@ -13,8 +13,6 @@
 #define __ARC_BCR_H
 #ifndef __ASSEMBLY__
 
-#include <config.h>
-
 union bcr_di_cache {
 	struct {
 #ifdef CONFIG_CPU_BIG_ENDIAN
diff --git a/arch/arc/include/asm/arcregs.h b/arch/arc/include/asm/arcregs.h
index a9f54f61e0cc..273fb8eed859 100644
--- a/arch/arc/include/asm/arcregs.h
+++ b/arch/arc/include/asm/arcregs.h
@@ -7,7 +7,6 @@
 #define _ASM_ARC_ARCREGS_H
 
 #include <asm/cache.h>
-#include <config.h>
 
 /*
  * ARC architecture has additional address space - auxiliary registers.
diff --git a/arch/arc/include/asm/cache.h b/arch/arc/include/asm/cache.h
index 74cff716ef60..65dff4214830 100644
--- a/arch/arc/include/asm/cache.h
+++ b/arch/arc/include/asm/cache.h
@@ -6,8 +6,6 @@
 #ifndef __ASM_ARC_CACHE_H
 #define __ASM_ARC_CACHE_H
 
-#include <config.h>
-
 /*
  * As of today we may handle any L1 cache line length right in software.
  * For that essentially cache line length is a variable not constant.
diff --git a/arch/arc/lib/cpu.c b/arch/arc/lib/cpu.c
index 803dfd425580..593950449f2e 100644
--- a/arch/arc/lib/cpu.c
+++ b/arch/arc/lib/cpu.c
@@ -3,6 +3,7 @@
  * Copyright (C) 2013-2014, 2018 Synopsys, Inc. All rights reserved.
  */
 
+#include <config.h>
 #include <clock_legacy.h>
 #include <init.h>
 #include <malloc.h>
diff --git a/board/abilis/tb100/tb100.c b/board/abilis/tb100/tb100.c
index 3dc9e14ef8c0..eb7d12908134 100644
--- a/board/abilis/tb100/tb100.c
+++ b/board/abilis/tb100/tb100.c
@@ -14,6 +14,10 @@ void reset_cpu(void)
 	writel(0x1, (void *)CRM_SWRESET);
 }
 
+/*
+ * Ethernet configuration
+ */
+#define ETH0_BASE_ADDRESS		0xFE100000
 int board_eth_init(struct bd_info *bis)
 {
 	if (designware_initialize(ETH0_BASE_ADDRESS, 0) >= 0)
diff --git a/include/configs/tb100.h b/include/configs/tb100.h
index 1318f5e5ee44..08b6f3219c33 100644
--- a/include/configs/tb100.h
+++ b/include/configs/tb100.h
@@ -21,25 +21,4 @@
  */
 #define CFG_SYS_NS16550_CLK		166666666
 
-/*
- * Even though the board houses Realtek RTL8211E PHY
- * corresponding PHY driver (drivers/net/phy/realtek.c) behaves unexpectedly.
- * In particular "parse_status" reports link is down.
- *
- * Until Realtek PHY driver is fixed fall back to generic PHY driver
- * which implements all required functionality and behaves much more stable.
- *
- *
- */
-
-/*
- * Ethernet configuration
- */
-#define ETH0_BASE_ADDRESS		0xFE100000
-#define ETH1_BASE_ADDRESS		0xFE110000
-
-/*
- * Console configuration
- */
-
 #endif /* _CONFIG_TB100_H_ */
-- 
2.34.1

