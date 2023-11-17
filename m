Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12E73C072A2
	for <u-boot@archiver.kernel.org>; Fri, 17 Nov 2023 22:53:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AE56C874A1;
	Fri, 17 Nov 2023 23:53:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="dq7PjHyF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C04AF874A3; Fri, 17 Nov 2023 23:53:20 +0100 (CET)
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com
 [IPv6:2607:f8b0:4864:20::f36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DE4208749D
 for <u-boot@lists.denx.de>; Fri, 17 Nov 2023 23:53:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf36.google.com with SMTP id
 6a1803df08f44-670e7ae4a2eso31906826d6.1
 for <u-boot@lists.denx.de>; Fri, 17 Nov 2023 14:53:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1700261595; x=1700866395; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1J6238r8Qls48FaJfBExVydqZkV6pS/RzqtawlGy31w=;
 b=dq7PjHyFnxg+fJG0htd+cU6Ol05fcEI8XhIfVw6qYCpgt19S5lgXWeyZ+3PEF8tlMP
 pALqe1zYUX57fqKy5lqsrJM5f/EY5z+wO2/UFMLfY1DKgqDT6myWHpgipnsDKB6k3wZI
 h45cTOVFNVk3RJNS8hlR4OGJhH2jxpqZGcTQU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700261595; x=1700866395;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1J6238r8Qls48FaJfBExVydqZkV6pS/RzqtawlGy31w=;
 b=veYlh9kRBd4J5aZgsKLNYrJuu5pOQa2Xcru0op3XJl87oU7EAJjzdLm9vJVQlON+rL
 aQmVfHsJ/NkyAB74fwMJv+MOSKJfAaFiVW/J4l2zoH43HjtNk8Cpz41mRp0owtczgAMN
 Y1dBnEdG0asUbLY4XvcuIWKTmLQHNdVNtSKu00b+UHZ6RJR3joXXregWJ5CL4ZSJZXew
 6ZS3XnqjayNs0Mimq0wqYLqhjRSVnxU1asqC22j9h85RZNc90FWESEOYHQuh3PpZG0cW
 BP3ZRV12qWeb/7STFMOm2Oj9ylE7KUQos0SFNlEBUh3xfkiTTQV7as5Dp5HIus9g9Ayf
 ACkA==
X-Gm-Message-State: AOJu0YxmjfQHYJFCliVhdDJpJcPzTvIHDK9OfwUqiPrL+bH4mXcsnIxG
 Nd48g5ZZcILjrKW9ygRVZBE09C8/h4tyo4EtVXrsMg==
X-Google-Smtp-Source: AGHT+IEpMvMMpRMqjpMESWyU96nKu4OJfYzWXNB70scco3QLX0Vx9uevDUclueRhm7KOjz/zUAHsRw==
X-Received: by 2002:a0c:f002:0:b0:66f:a356:b5dc with SMTP id
 z2-20020a0cf002000000b0066fa356b5dcmr781557qvk.12.1700261595524; 
 Fri, 17 Nov 2023 14:53:15 -0800 (PST)
Received: from bill-the-cat.lan
 (2603-6081-7b00-6400-dbd8-aafa-ccfe-bf84.res6.spectrum.com.
 [2603:6081:7b00:6400:dbd8:aafa:ccfe:bf84])
 by smtp.gmail.com with ESMTPSA id
 r12-20020a05621410cc00b0065b08bb01afsm961084qvs.124.2023.11.17.14.53.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Nov 2023 14:53:15 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Alexey Brodkin <abrodkin@synopsys.com>,
 Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>, uboot-snps-arc@synopsys.com
Subject: [PATCH 2/5] arc: Cleanup and audit usage of <config.h>
Date: Fri, 17 Nov 2023 17:53:10 -0500
Message-Id: <20231117225313.2144665-2-trini@konsulko.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231117225313.2144665-1-trini@konsulko.com>
References: <20231117225313.2144665-1-trini@konsulko.com>
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
---
Cc: Alexey Brodkin <abrodkin@synopsys.com>
Cc: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
Cc: uboot-snps-arc@synopsys.com
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

