Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51AD9C4332F
	for <u-boot@archiver.kernel.org>; Thu, 14 Dec 2023 18:18:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 910B387B8F;
	Thu, 14 Dec 2023 19:17:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="HPGoUKAl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9CA2D87B73; Thu, 14 Dec 2023 19:17:11 +0100 (CET)
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com
 [IPv6:2607:f8b0:4864:20::112a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4356E87B67
 for <u-boot@lists.denx.de>; Thu, 14 Dec 2023 19:17:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112a.google.com with SMTP id
 00721157ae682-5e41dc5a4cbso2221537b3.3
 for <u-boot@lists.denx.de>; Thu, 14 Dec 2023 10:17:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1702577826; x=1703182626; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TPGuOak30KRxXq2FKK+8zdFFvtovtRpykjy/VRsoNYE=;
 b=HPGoUKAl0nvEjmDhWAeSVkELlMKXpYLPNaiihyg4sOiy+SEKIQ48iqB8AvsKzF1OLf
 ylcxGaEw/2DwhfkPt6gSlo3pcFIIroBg787z5AVViqqP0RE6AVRS/yKoF3hkKfvZLJP4
 6J8O5K6izOp0uqa0OKMLkQsiyls93bHurD2mg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702577826; x=1703182626;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TPGuOak30KRxXq2FKK+8zdFFvtovtRpykjy/VRsoNYE=;
 b=bblvxZlqfW3N7DB+Q/WY2krNEpHZBEXIJCSuCODYo2E4wWbSfmijrt8viq7emSkOVc
 TnzRTk+KhtrzhlBDT0GemLm13ldEJxOS6bEPoEonyPn8N1ajw+9gvDBt6lN3PBUyZJ0r
 EJqUZ9v8E5yuzwtb3Xeb6ysdyo8v6L3paxaKtkvs+FCpVhVnGBPvKuBTyRHHrOQIvwVp
 M/QIWvSx+oOzxJ5F7R0ZVybIrQaB1EGgvYfa7NopTJTnX8mJfJ8HilurDbDSGgWv6JJd
 oACuSQFN+3q+PLMR6OcXuUftQAPt13TdmrKH+e3dd5w4K212KsftitER9/OaGM3o4wUb
 ssFw==
X-Gm-Message-State: AOJu0YyfaMOAWjF9tt6rbT6ZTkstt3SU+g/IHrdUpGUX32xm2RgEr1rK
 V7LJF+rUXSs42uIMOe2kf0WbdFSUbVoPfh4DgEo=
X-Google-Smtp-Source: AGHT+IEoeYVWPHM4amOfiLp/qbO+dmgiCk30dByeM9mh0zbPBU74S0yHacYdP6kKtd0UwV2fETpJ+Q==
X-Received: by 2002:a81:5c82:0:b0:5d7:1941:aab with SMTP id
 q124-20020a815c82000000b005d719410aabmr9121533ywb.70.1702577826616; 
 Thu, 14 Dec 2023 10:17:06 -0800 (PST)
Received: from bill-the-cat.lan
 (2603-6081-7b00-6400-ef43-b142-0a3d-20b7.res6.spectrum.com.
 [2603:6081:7b00:6400:ef43:b142:a3d:20b7])
 by smtp.gmail.com with ESMTPSA id
 s129-20020a0dd087000000b005d361dd6454sm5665698ywd.87.2023.12.14.10.17.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Dec 2023 10:17:06 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Angelo Dureghello <angelo@kernel-space.org>
Subject: [v2 09/16] m68k: Rework asm/global_data.h slightly
Date: Thu, 14 Dec 2023 13:16:51 -0500
Message-Id: <20231214181658.3359902-9-trini@konsulko.com>
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

In the architecture global data, replace the one case of u32 with
unsigned long. Now, we can drop config.h here but then do need to add it
in two m68k-centric spaces.

Signed-off-by: Tom Rini <trini@konsulko.com>
Acked-by: Angelo Dureghello <angelo@kernel-space.org>
---
 arch/m68k/include/asm/cache.h       | 2 ++
 arch/m68k/include/asm/global_data.h | 4 +---
 arch/m68k/lib/traps.c               | 1 +
 3 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/m68k/include/asm/cache.h b/arch/m68k/include/asm/cache.h
index 8ed2b4dbab47..6ef7f7be1af8 100644
--- a/arch/m68k/include/asm/cache.h
+++ b/arch/m68k/include/asm/cache.h
@@ -9,6 +9,8 @@
 #ifndef __CACHE_H
 #define __CACHE_H
 
+#include <config.h>
+
 #if defined(CONFIG_MCF520x) || defined(CONFIG_MCF523x) || \
     defined(CONFIG_MCF52x2)
 #define CFG_CF_V2
diff --git a/arch/m68k/include/asm/global_data.h b/arch/m68k/include/asm/global_data.h
index 5f576ba16f9a..c2ef5770a3df 100644
--- a/arch/m68k/include/asm/global_data.h
+++ b/arch/m68k/include/asm/global_data.h
@@ -7,8 +7,6 @@
 #ifndef	__ASM_GBL_DATA_H
 #define __ASM_GBL_DATA_H
 
-#include <config.h>
-
 /* Architecture-specific global data */
 struct arch_global_data {
 #ifdef CONFIG_SYS_I2C_FSL
@@ -24,7 +22,7 @@ struct arch_global_data {
 	unsigned long sdhc_clk;
 #endif
 #if defined(CONFIG_FSL_ESDHC)
-	u32 sdhc_per_clk;
+	unsigned long sdhc_per_clk;
 #endif
 };
 
diff --git a/arch/m68k/lib/traps.c b/arch/m68k/lib/traps.c
index c283351181d8..2a025c5a6e86 100644
--- a/arch/m68k/lib/traps.c
+++ b/arch/m68k/lib/traps.c
@@ -7,6 +7,7 @@
  * Wolfgang Denk, DENX Software Engineering, wd@denx.de.
  */
 
+#include <config.h>
 #include <init.h>
 #include <watchdog.h>
 #include <command.h>
-- 
2.34.1

