Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B084EE49A3
	for <u-boot@archiver.kernel.org>; Tue, 22 Aug 2023 03:19:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1829587293;
	Tue, 22 Aug 2023 05:17:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Enljsvs0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D5547871C2; Tue, 22 Aug 2023 05:17:24 +0200 (CEST)
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com
 [IPv6:2607:f8b0:4864:20::12b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9562D8728E
 for <u-boot@lists.denx.de>; Tue, 22 Aug 2023 05:17:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12b.google.com with SMTP id
 e9e14a558f8ab-349a94f3d69so12304365ab.1
 for <u-boot@lists.denx.de>; Mon, 21 Aug 2023 20:17:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1692674240; x=1693279040;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pOuzJexSRntoZLsgrAAoPaTL8MyH7zE3QLdaV8kibh0=;
 b=Enljsvs08d7qcj1TPeIsYuBD8bXiVWGDfibQCA2KBhq0sBUJ7R7FwMnuLxn41H0A1U
 poy6sRIxowLTcVeZhcR61Qi+5GoE5F/7U87NP8FGDr8QKpgJlEjdvgyTPCNAhi18oF5g
 gy9A8KylT5Qtnht1dDf2DK0kROCHAL6lTMTcw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692674240; x=1693279040;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pOuzJexSRntoZLsgrAAoPaTL8MyH7zE3QLdaV8kibh0=;
 b=VFrZy4u1UMZxDP4H25djxmEjE73W6UI2x7/QiFkJQKtWtZRkNG2hZhXWieI7/z0yNr
 VpAUA6Auzq/U38GdUrPT3Dhur68i8NJzKXhENeKleEZjCRC6K0ttK+KKq+aFJmnqkfTA
 PmesbHss56tXZtrJ19hAyCMMdjDqklcgNputec3FTxDhpWAsCmGPUqaZlEWsDbURT1SL
 ciQAxmdzzfsV/8WppIs5XYJ0ipWtvjyJgOWG1zNIkw38bdC3yea1CIJAl9/nRmNpE9Lp
 16G9cmXqZJHcaBFWu0exdxIbtkP69Ywk0XX3yA/XEKuJXTdCzaKU6CMjp6vDpFgIBjBg
 47SA==
X-Gm-Message-State: AOJu0YwoygGeVg9TzBi3CLTk9IIosCjnFzxxXFxvyH/HQi6hX9OwL7Vh
 0jBOg8xgI5IOsY1nseqm0X4o/MsWQrtyv27DPBc=
X-Google-Smtp-Source: AGHT+IELZV4QN0ljW2GkqH8KB2gJCT065Sr/Pzsc0UK9wHs+lRTX4ICW6s72mQHS3ZWGtFR0/MdFzw==
X-Received: by 2002:a05:6e02:1066:b0:346:4f37:9ee7 with SMTP id
 q6-20020a056e02106600b003464f379ee7mr7522631ilj.13.1692674240186; 
 Mon, 21 Aug 2023 20:17:20 -0700 (PDT)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 gv14-20020a0566382e4e00b0042b37dda71asm2722735jab.136.2023.08.21.20.17.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Aug 2023 20:17:20 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Alexander Graf <agraf@csgraf.de>, Tom Rini <trini@konsulko.com>,
 Bin Meng <bmeng.cn@gmail.com>, Simon Glass <sjg@chromium.org>
Subject: [PATCH 13/14] freescale: Drop call to init_func_vid() in the init
 sequence
Date: Mon, 21 Aug 2023 21:17:00 -0600
Message-ID: <20230822031705.1340941-14-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.rc1.204.g551eb34607-goog
In-Reply-To: <20230822031705.1340941-1-sjg@chromium.org>
References: <20230822031705.1340941-1-sjg@chromium.org>
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

Use the misc_init_f event instead, which is designed for this purpose.

All boards with CONFIG_VID already enable CONFIG_EVENT.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 arch/arm/cpu/armv8/fsl-layerscape/spl.c |  5 +++++
 board/freescale/ls1088a/ls1088a.c       |  3 ++-
 board/freescale/lx2160a/lx2160a.c       |  2 ++
 common/board_f.c                        | 10 ----------
 include/init.h                          |  3 ---
 5 files changed, 9 insertions(+), 14 deletions(-)

diff --git a/arch/arm/cpu/armv8/fsl-layerscape/spl.c b/arch/arm/cpu/armv8/fsl-layerscape/spl.c
index 61fced451eb5..033f48d04b90 100644
--- a/arch/arm/cpu/armv8/fsl-layerscape/spl.c
+++ b/arch/arm/cpu/armv8/fsl-layerscape/spl.c
@@ -78,6 +78,11 @@ void tzpc_init(void)
 #endif
 }
 
+__weak int init_func_vid(void)
+{
+	return 0;
+}
+
 void board_init_f(ulong dummy)
 {
 	int ret;
diff --git a/board/freescale/ls1088a/ls1088a.c b/board/freescale/ls1088a/ls1088a.c
index 7a1047a77f73..f2b8bec03729 100644
--- a/board/freescale/ls1088a/ls1088a.c
+++ b/board/freescale/ls1088a/ls1088a.c
@@ -181,13 +181,14 @@ unsigned long long get_qixis_addr(void)
 #endif
 
 #if defined(CONFIG_VID)
-int init_func_vid(void)
+static int setup_core_voltage(void)
 {
 	if (adjust_vdd(0) < 0)
 		printf("core voltage not adjusted\n");
 
 	return 0;
 }
+EVENT_SPY_SIMPLE(EVT_MISC_INIT_F, setup_core_voltage);
 
 u16 soc_get_fuse_vid(int vid_index)
 {
diff --git a/board/freescale/lx2160a/lx2160a.c b/board/freescale/lx2160a/lx2160a.c
index d631a11ff667..2883848550af 100644
--- a/board/freescale/lx2160a/lx2160a.c
+++ b/board/freescale/lx2160a/lx2160a.c
@@ -13,6 +13,7 @@
 #include <i2c.h>
 #include <malloc.h>
 #include <errno.h>
+#include <event.h>
 #include <netdev.h>
 #include <fsl_ddr.h>
 #include <asm/io.h>
@@ -242,6 +243,7 @@ int init_func_vid(void)
 	return 0;
 }
 #endif
+EVENT_SPY_SIMPLE(EVT_MISC_INIT_F, init_func_vid);
 
 int checkboard(void)
 {
diff --git a/common/board_f.c b/common/board_f.c
index 46008bac6595..aef395b1354e 100644
--- a/common/board_f.c
+++ b/common/board_f.c
@@ -280,13 +280,6 @@ static int init_func_i2c(void)
 }
 #endif
 
-#if defined(CONFIG_VID)
-__weak int init_func_vid(void)
-{
-	return 0;
-}
-#endif
-
 static int setup_mon_len(void)
 {
 #if defined(__ARM__) || defined(__MICROBLAZE__)
@@ -896,9 +889,6 @@ static const init_fnc_t init_sequence_f[] = {
 	INIT_FUNC_WATCHDOG_RESET
 #if CONFIG_IS_ENABLED(SYS_I2C_LEGACY)
 	init_func_i2c,
-#endif
-#if defined(CONFIG_VID) && !defined(CONFIG_SPL)
-	init_func_vid,
 #endif
 	announce_dram_init,
 	dram_init,		/* configure available RAM banks */
diff --git a/include/init.h b/include/init.h
index 1bf76e4eff72..13579db75900 100644
--- a/include/init.h
+++ b/include/init.h
@@ -276,9 +276,6 @@ int set_cpu_clk_info(void);
 int update_flash_size(int flash_size);
 int arch_early_init_r(void);
 int misc_init_r(void);
-#if defined(CONFIG_VID)
-int init_func_vid(void);
-#endif
 
 /* common/board_info.c */
 int checkboard(void);
-- 
2.42.0.rc1.204.g551eb34607-goog

