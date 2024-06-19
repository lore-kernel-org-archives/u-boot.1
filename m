Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEA68C27C53
	for <u-boot@archiver.kernel.org>; Wed, 19 Jun 2024 21:28:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7B1D6884D4;
	Wed, 19 Jun 2024 23:28:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="OhEjUhG1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8AEF6884C7; Wed, 19 Jun 2024 23:28:08 +0200 (CEST)
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com
 [IPv6:2607:f8b0:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6436C88363
 for <u-boot@lists.denx.de>; Wed, 19 Jun 2024 23:28:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32a.google.com with SMTP id
 46e09a7af769-6f9603730d5so101415a34.1
 for <u-boot@lists.denx.de>; Wed, 19 Jun 2024 14:28:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1718832485; x=1719437285; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uxeHz2raTD5KCK6hDmva5KcUg10JobBKvE2xiey8oCU=;
 b=OhEjUhG1h53xZO4HDem9t7yoQeyDahrUogVge6e0DwNKAKgg0jhPPusi1/PuyFpVbe
 8FUUAuMo7C9pB848gCoZcInO6LBMy80fu96F+WGxOcXkl9AE7xBpoAZGDnCYzKpy8/gI
 OzxbaYBmaNcuU4CtJT3ey+sifr9e+3STmr32U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718832485; x=1719437285;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uxeHz2raTD5KCK6hDmva5KcUg10JobBKvE2xiey8oCU=;
 b=M6NJLb4scjpHSNWlDMHRfkBDjEmN3w7jivlsMXzV+unWvVWtSTbrNFaQVvOlROO6G4
 BUeKBbxczq+A51qk50S+pj40Hr0dLqDIC8vjOkp+WA3S6bmkIPBlzuirsFMPAMhpacEH
 dqCQXCmnbv6jvwvga4VblEX5uryjZ6FXHMXiRdn4gymWAcO5mnMUX91qKIUhkv4e0WFx
 mj8CMV585D/rF8DavKRnqGy24RqpKKqc0uHbIlQ/NDGv+FDiufTXZURNzTtYtCnZwlW8
 V/irx3yL/s0MRcElR85KRFlfdpX3aTe4B9C35mHEyy5lGGU9QsNjM7D6m/ViqXovEWVm
 hNIA==
X-Gm-Message-State: AOJu0YyT4U3na8DBufJtBL9D7wA8RJoWN1A/KibVTLctdUfgGDOOyY+4
 A1Zzm5/ECntsLEW7sS6rg16YaJjnR+m9rio5uLfmTCmjykpSVR5ivPrlMGkSBjDFY+mPePbmoHk
 uWONGng==
X-Google-Smtp-Source: AGHT+IFCuvhdEDNhhJkbdHBtaKHg7OoPlYl5hhPOvxmNGv3oJT/b+0HvVbt/XNAIiHHxv3WRWLAQtQ==
X-Received: by 2002:a05:6830:1302:b0:6f9:a3c6:a864 with SMTP id
 46e09a7af769-70073c2bfc9mr3887150a34.10.1718832485160; 
 Wed, 19 Jun 2024 14:28:05 -0700 (PDT)
Received: from bill-the-cat.tail58a08.ts.net
 (fixed-187-190-205-45.totalplay.net. [187.190.205.45])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7008a5a34c9sm338654a34.73.2024.06.19.14.28.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Jun 2024 14:28:04 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: [PATCH 2/7] m68k: Rename icache_invalid to invalidate_icache_all
Date: Wed, 19 Jun 2024 15:27:54 -0600
Message-Id: <20240619212759.3456158-2-trini@konsulko.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240619212759.3456158-1-trini@konsulko.com>
References: <20240619212759.3456158-1-trini@konsulko.com>
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

The implementation of icache_invalid appears to be doing what other
architectures call invalidate_icache_all so rename to match.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
Huan Wang <alison.wang@nxp.com>
Angelo Dureghello <angelo@kernel-space.org>
---
 arch/m68k/include/asm/cache.h | 1 -
 arch/m68k/lib/cache.c         | 6 +++---
 drivers/net/mcffec.c          | 5 +++--
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/m68k/include/asm/cache.h b/arch/m68k/include/asm/cache.h
index 6ef7f7be1af8..aa8d2edb40ba 100644
--- a/arch/m68k/include/asm/cache.h
+++ b/arch/m68k/include/asm/cache.h
@@ -185,7 +185,6 @@
 
 #ifndef __ASSEMBLY__		/* put C only stuff in this section */
 
-void icache_invalid(void);
 void dcache_invalid(void);
 
 #endif
diff --git a/arch/m68k/lib/cache.c b/arch/m68k/lib/cache.c
index dab834c1cbd8..370ad40f1423 100644
--- a/arch/m68k/lib/cache.c
+++ b/arch/m68k/lib/cache.c
@@ -29,7 +29,7 @@ int dcache_status(void)
 
 void icache_enable(void)
 {
-	icache_invalid();
+	invalidate_icache_all();
 
 	*cf_icache_status = 1;
 
@@ -53,7 +53,7 @@ void icache_disable(void)
 	u32 temp = 0;
 
 	*cf_icache_status = 0;
-	icache_invalid();
+	invalidate_icache_all();
 
 #if defined(CONFIG_CF_V4) || defined(CFG_CF_V4E)
 	__asm__ __volatile__("movec %0, %%acr2"::"r"(temp));
@@ -68,7 +68,7 @@ void icache_disable(void)
 #endif
 }
 
-void icache_invalid(void)
+void invalidate_icache_all(void)
 {
 	u32 temp;
 
diff --git a/drivers/net/mcffec.c b/drivers/net/mcffec.c
index 04b711e4f650..7e53492733ed 100644
--- a/drivers/net/mcffec.c
+++ b/drivers/net/mcffec.c
@@ -11,6 +11,7 @@
  */
 
 #include <config.h>
+#include <cpu_func.h>
 #include <env.h>
 #include <hang.h>
 #include <malloc.h>
@@ -399,7 +400,7 @@ static int mcffec_send(struct udevice *dev, void *packet, int length)
 #endif
 
 #ifdef CONFIG_SYS_UNIFY_CACHE
-	icache_invalid();
+	invalidate_icache_all();
 #endif
 
 	j = 0;
@@ -433,7 +434,7 @@ static int mcffec_recv(struct udevice *dev, int flags, uchar **packetp)
 
 	for (;;) {
 #ifdef CONFIG_SYS_UNIFY_CACHE
-		icache_invalid();
+		invalidate_icache_all();
 #endif
 		/* If nothing received - leave for() loop */
 		if (info->rxbd[info->rx_idx].cbd_sc & BD_ENET_RX_EMPTY)
-- 
2.34.1

