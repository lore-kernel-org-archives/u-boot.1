Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B230C61D97
	for <u-boot@archiver.kernel.org>; Wed, 22 Nov 2023 13:12:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AC2F5875FA;
	Wed, 22 Nov 2023 14:12:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="GCvpk2tB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3C005875F7; Wed, 22 Nov 2023 14:12:05 +0100 (CET)
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com
 [IPv6:2607:f8b0:4864:20::b2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7F93C87463
 for <u-boot@lists.denx.de>; Wed, 22 Nov 2023 14:12:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb2f.google.com with SMTP id
 3f1490d57ef6-da7ea62e76cso6670251276.3
 for <u-boot@lists.denx.de>; Wed, 22 Nov 2023 05:12:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1700658719; x=1701263519; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tzVpN9PR44jGSVKImklEQOO2+WjWbexXA7YedtkDPng=;
 b=GCvpk2tBE9o8x2FPa3LjtquZQQH7IbUA6u4Y5wI35O6Wzb74A+WZY0cgfYn37ZCg1s
 km7Ra3jL7mbPL5cG1y1jQIQq/s2oYyPZAQnq75F1CSLngYVS4sLmsoQfifQeshYExmWz
 vScIV2Ia4ECtbey9i8m9B5U58GwBiviDnuXrc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700658719; x=1701263519;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tzVpN9PR44jGSVKImklEQOO2+WjWbexXA7YedtkDPng=;
 b=oh+bNdTgO4qkOmrFg+F6Aw3iIO+ZcEvwDVfJ+vPfjNbYYITjOTK2xdqIXOKbtlos0s
 6UYnAF3BOrQX8MhSWpxXVG2dJnE4C+CAOmCBG7IPRIvO9Cr3JHd2F3LS0FVrv95wmpxW
 ovZWBhlV6BbweTniYTpW4o+rNPC+DE5voif0sA/WsptlnqNjnXNu9/KoeOW7Qq23kxpI
 xaCR2hohwhnoDNJiXrhhKcH7N3qHwnUkfn3fHrucOhGa1fNNI1F7bmmSI3XWZIc5aaMO
 lTTnYsS9d3tbN8tm3fHHucO8CAp5TtZKl9bmyZQQdTRQ5yXKma0CovRozj9xypWp8R7y
 9eeg==
X-Gm-Message-State: AOJu0YxvNjXY7ySqwKP+9cdTdaq3QIoKKHRsyB9yAF2fpswRk/xu3XYx
 A1ACMffEkPLoDlqpWhta92pvbJ1Mcku9NbJCfInhbA==
X-Google-Smtp-Source: AGHT+IEOfF7xb6wFnCNraWJc0iq0MqZWaAy3w4KogAeJIA2/Adm/kuAC/Qa0NT8GXEVKhN1XrXrLhg==
X-Received: by 2002:a05:6902:3cd:b0:da0:3510:d46b with SMTP id
 g13-20020a05690203cd00b00da03510d46bmr1908687ybs.52.1700658718885; 
 Wed, 22 Nov 2023 05:11:58 -0800 (PST)
Received: from bill-the-cat.lan
 (2603-6081-7b00-6400-999e-39fe-b112-e0fa.res6.spectrum.com.
 [2603:6081:7b00:6400:999e:39fe:b112:e0fa])
 by smtp.gmail.com with ESMTPSA id
 x63-20020a254a42000000b00c64533e4e20sm1367511yba.33.2023.11.22.05.11.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Nov 2023 05:11:58 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Huan Wang <alison.wang@nxp.com>,
 Angelo Dureghello <angelo@kernel-space.org>
Subject: [PATCH 04/11] m68k: Rework asm/global_data.h slightly
Date: Wed, 22 Nov 2023 08:11:47 -0500
Message-Id: <20231122131154.2444690-4-trini@konsulko.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231122131154.2444690-1-trini@konsulko.com>
References: <20231122131154.2444690-1-trini@konsulko.com>
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
---
Cc: Huan Wang <alison.wang@nxp.com>
Cc: Angelo Dureghello <angelo@kernel-space.org>
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

