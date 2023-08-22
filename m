Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F31D2EE49A3
	for <u-boot@archiver.kernel.org>; Tue, 22 Aug 2023 03:19:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CEB3D8728B;
	Tue, 22 Aug 2023 05:17:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="JS6U7i8k";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AED44871C2; Tue, 22 Aug 2023 05:17:24 +0200 (CEST)
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com
 [IPv6:2607:f8b0:4864:20::132])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CC4EE8726F
 for <u-boot@lists.denx.de>; Tue, 22 Aug 2023 05:17:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x132.google.com with SMTP id
 e9e14a558f8ab-34bbc5eb310so11528565ab.2
 for <u-boot@lists.denx.de>; Mon, 21 Aug 2023 20:17:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1692674239; x=1693279039;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1cSOD/v38JWsOXEBgfqXVSjVgz00+saIjMcw3I4cd6A=;
 b=JS6U7i8ko7nkRtSbFMd35EBThLfP262AY18EmZH2cXgGUW3m7LTbOWGBSZNoI6qyGF
 IZlyrGrnUiUaKAwMNFGVUDhge2u4HYv4let2h/BakbqCYMU6AIDw4/8az2agjs8jsMxt
 /uqrcvycOVTm6U6g/J+IvgO15eKildOzyZEtM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692674239; x=1693279039;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1cSOD/v38JWsOXEBgfqXVSjVgz00+saIjMcw3I4cd6A=;
 b=auywHttqHZCKauMF30HpxHBQRHz1w1VNhUZg1QK2FUjMoW8Ixadt2fX61HE3OL2zyk
 hNhkz3C2Ycjzsr1mEhdda4buAN3dp3zt0stklQBsKmk2GVjuwOwYBYIc5mDahP9/kpJ8
 MaVfX4EpLKN1w7bTgqkdH8mxZNYY4refoMN5G/s1lfVNstIzv/94GTmyOYkdi9p7nHYG
 nIyFCMTGHBF/ExpNZTy5C0eBkVtQBz27mahdM67YYGgfN1W28WLGNhnne8hMDEV0Ju62
 NlBdy6r4J1RCxJw/zAumBqT2aYL4z3+NhaMzMibxQk/bvbhZFM9lrFsqt+tlkG6tKXxC
 tdvg==
X-Gm-Message-State: AOJu0YxBfOHPGgRJhUig5FKR/TPD55MFJlP0Q+TdeTAsYyRhTR//F3cp
 Juc9FfxqWdu68KSlgrn5Id092CEHXc3RwmPvrrU=
X-Google-Smtp-Source: AGHT+IG9QDx2levpNlC/LZyf85vu8sFkaPh3LL5FvmKM6g1RFVbVVlh6WLh1AJFlvSq/ZcBYEg+9/g==
X-Received: by 2002:a05:6e02:194a:b0:349:614f:8d9c with SMTP id
 x10-20020a056e02194a00b00349614f8d9cmr11562934ilu.31.1692674239467; 
 Mon, 21 Aug 2023 20:17:19 -0700 (PDT)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 gv14-20020a0566382e4e00b0042b37dda71asm2722735jab.136.2023.08.21.20.17.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Aug 2023 20:17:19 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Alexander Graf <agraf@csgraf.de>, Tom Rini <trini@konsulko.com>,
 Bin Meng <bmeng.cn@gmail.com>, Simon Glass <sjg@chromium.org>
Subject: [PATCH 12/14] x86: Convert arch_fsp_init() to use events
Date: Mon, 21 Aug 2023 21:16:59 -0600
Message-ID: <20230822031705.1340941-13-sjg@chromium.org>
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

Convert this to use events instead of calling a function directly in the
init sequence.

Rename it to arch_fsp_init_f() to distinguish it from the one that happens
after relocation.

For FSPv2 nothing needs to be done here, so drop the empty function.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 arch/x86/lib/fsp1/fsp_common.c |  1 +
 arch/x86/lib/fsp2/fsp_common.c |  5 -----
 common/board_f.c               |  4 +---
 common/event.c                 |  1 +
 include/event.h                |  9 +++++++++
 include/init.h                 | 11 -----------
 6 files changed, 12 insertions(+), 19 deletions(-)

diff --git a/arch/x86/lib/fsp1/fsp_common.c b/arch/x86/lib/fsp1/fsp_common.c
index 20926171822d..df18f4767562 100644
--- a/arch/x86/lib/fsp1/fsp_common.c
+++ b/arch/x86/lib/fsp1/fsp_common.c
@@ -101,3 +101,4 @@ int arch_fsp_init(void)
 
 	return 0;
 }
+EVENT_SPY_SIMPLE(EVT_FSP_INIT_F, arch_fsp_init);
diff --git a/arch/x86/lib/fsp2/fsp_common.c b/arch/x86/lib/fsp2/fsp_common.c
index 20c3f6406adf..d802a86967d5 100644
--- a/arch/x86/lib/fsp2/fsp_common.c
+++ b/arch/x86/lib/fsp2/fsp_common.c
@@ -8,11 +8,6 @@
 #include <init.h>
 #include <asm/fsp/fsp_support.h>
 
-int arch_fsp_init(void)
-{
-	return 0;
-}
-
 void board_final_cleanup(void)
 {
 	u32 status;
diff --git a/common/board_f.c b/common/board_f.c
index a485ba62fa17..46008bac6595 100644
--- a/common/board_f.c
+++ b/common/board_f.c
@@ -855,9 +855,7 @@ static const init_fnc_t init_sequence_f[] = {
 #if defined(CONFIG_CONSOLE_RECORD_INIT_F)
 	console_record_init,
 #endif
-#if defined(CONFIG_HAVE_FSP)
-	arch_fsp_init,
-#endif
+	INITCALL_EVENT(EVT_FSP_INIT_F),
 	arch_cpu_init,		/* basic arch cpu dependent setup */
 	mach_cpu_init,		/* SoC/machine dependent CPU setup */
 	initf_dm,
diff --git a/common/event.c b/common/event.c
index 55f6932ef62c..8a6190888845 100644
--- a/common/event.c
+++ b/common/event.c
@@ -35,6 +35,7 @@ const char *const type_name[] = {
 
 	/* init hooks */
 	"misc_init_f",
+	"fsp_init_r",
 
 	/* Fpga load hook */
 	"fpga_load",
diff --git a/include/event.h b/include/event.h
index b2cfd65c9f8b..85269aa317aa 100644
--- a/include/event.h
+++ b/include/event.h
@@ -32,6 +32,15 @@ enum event_t {
 	/* Init hooks */
 	EVT_MISC_INIT_F,
 
+	/*
+	 * Emitted before relocation to set up Firmware Support Package
+	 *
+	 * Where U-Boot relies on binary blobs to handle part of the system
+	 * init, this event can be used to set up the blobs. This is used on
+	 * some Intel platforms
+	 */
+	EVT_FSP_INIT_F,
+
 	/* Fpga load hook */
 	EVT_FPGA_LOAD,
 
diff --git a/include/init.h b/include/init.h
index 3bf30476a2e0..1bf76e4eff72 100644
--- a/include/init.h
+++ b/include/init.h
@@ -57,17 +57,6 @@ int arch_cpu_init(void);
  */
 int mach_cpu_init(void);
 
-/**
- * arch_fsp_init() - perform firmware support package init
- *
- * Where U-Boot relies on binary blobs to handle part of the system init, this
- * function can be used to set up the blobs. This is used on some Intel
- * platforms.
- *
- * Return: 0
- */
-int arch_fsp_init(void);
-
 /**
  * arch_fsp_init() - perform post-relocation firmware support package init
  *
-- 
2.42.0.rc1.204.g551eb34607-goog

