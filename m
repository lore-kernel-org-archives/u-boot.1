Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29AECC3DA6E
	for <u-boot@archiver.kernel.org>; Mon, 25 Dec 2023 15:43:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 849B18784B;
	Mon, 25 Dec 2023 16:42:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="HUV0narC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2603D8744F; Mon, 25 Dec 2023 16:42:20 +0100 (CET)
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com
 [IPv6:2a00:1450:4864:20::234])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B654087846
 for <u-boot@lists.denx.de>; Mon, 25 Dec 2023 16:42:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=maxim.uvarov@linaro.org
Received: by mail-lj1-x234.google.com with SMTP id
 38308e7fff4ca-2ccb923c4d2so11323231fa.1
 for <u-boot@lists.denx.de>; Mon, 25 Dec 2023 07:42:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703518936; x=1704123736; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/SLgFjrfnKhrRx66uwyN72RTeQ06CKv9CxJBWJ/pjGY=;
 b=HUV0narCP2SOpLHf0xSpSgfyuSZDtXUjCD+Qr2zMo928tm/4PJ67mB75LaziNlCOs2
 98Y3UXDyOSajG3xM9DZkda/5F1psnbKSAxf7iT0th89fD34rN+Yg9mg4ueZTmA03vMkV
 X6m5Ev1EABOvXKhnTbMny6t/3McuF0MqPITzRHAku9LbLuLIKD6uRhMncTyq8/b53Tsr
 UQKaIjI1qat5n6X0H8v+TCb0RANDuFDddTnEGpO7EqxVxfK1648n40q4UjqMpq3poTuA
 46SoKE+UF6xwRagghiD9mY9lq7GVUSdjtHxh7jm72dzPoD4PXmM7BI5oWLm2ElSpwxHG
 53mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703518936; x=1704123736;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/SLgFjrfnKhrRx66uwyN72RTeQ06CKv9CxJBWJ/pjGY=;
 b=qzf0AXA1afMzWbRV3WfcOSlPouovPsgk4eHdLWQT14fsFdAvwpqEIK024tM9SKPcQr
 T6hfK6J/TDmmZRKcpf9hFxis4VlP2DwCV2BsTS/uRN4knLulCJmRbBJpw+N1mNVGsXnI
 Q8r2NejW0z3+nw1wjTu26VQDdrkWgC1fq3JF/T/zodrDCIPN/NJb0D5nIsuNIzsbBz1N
 ocfEYfl8DHffYJ2kOMJ6pZDD3L0Ivt7Wv+xlcQjQoS5l+hGaVeJMxVyDxjX2eOsvUd6X
 xw29I77GfNp4MUMpGDw5RHuSQwG2HskIbmXW3cAg7lcQ2chq8EkDZJoxyPk7xxHpfam2
 XxKg==
X-Gm-Message-State: AOJu0YwoT67OaaBxzEe5CPDVsCTb06WaoeWNXEnFZRLs9NVt6fysD+zy
 WWcx3pOvrfN5ZH99w3zf6eLlZrJSN9mH/5O4tdGHr+lP4f0=
X-Google-Smtp-Source: AGHT+IEeh713Yh0XqURlYTdBk4vLMrUyq4QKR8r/rAInSrnHU+5aDFN5xx7ewEc40Pa+0X+zvqgpRg==
X-Received: by 2002:a05:651c:2044:b0:2cc:7868:c200 with SMTP id
 t4-20020a05651c204400b002cc7868c200mr1197822ljo.90.1703518936432; 
 Mon, 25 Dec 2023 07:42:16 -0800 (PST)
Received: from localhost.localdomain ([45.82.14.220])
 by smtp.gmail.com with ESMTPSA id
 a17-20020a2ebe91000000b002cca6eafc44sm1425644ljr.113.2023.12.25.07.42.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Dec 2023 07:42:16 -0800 (PST)
From: Maxim Uvarov <maxim.uvarov@linaro.org>
To: u-boot@lists.denx.de
Cc: simon.k.r.goldschmidt@gmail.com, tien.fong.chee@intel.com,
 sjg@chromium.org, joe.hershberger@ni.com, rfried.dev@gmail.com,
 bharat.gooty@broadcom.com, rayagonda.kokatanur@broadcom.com,
 trini@konsulko.com, Maxim Uvarov <maxim.uvarov@linaro.org>
Subject: [PATHv2 8/9] omap3: use device specific naming for mem_init
Date: Mon, 25 Dec 2023 21:39:28 +0600
Message-Id: <20231225153929.8284-9-maxim.uvarov@linaro.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20231225153929.8284-1-maxim.uvarov@linaro.org>
References: <20231225153929.8284-1-maxim.uvarov@linaro.org>
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

Use device specific naming for functions so as to not overlap
with common function names.

Signed-off-by: Maxim Uvarov <maxim.uvarov@linaro.org>
Reviewed-by: Tom Rini <trini@konsulko.com>
---
 arch/arm/include/asm/arch-omap3/mem.h | 2 +-
 arch/arm/mach-omap2/omap3/board.c     | 2 +-
 arch/arm/mach-omap2/omap3/emif4.c     | 4 ++--
 arch/arm/mach-omap2/omap3/sdrc.c      | 6 +++---
 4 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/arm/include/asm/arch-omap3/mem.h b/arch/arm/include/asm/arch-omap3/mem.h
index 569779c55e..fce3568eca 100644
--- a/arch/arm/include/asm/arch-omap3/mem.h
+++ b/arch/arm/include/asm/arch-omap3/mem.h
@@ -475,7 +475,7 @@ enum {
 #ifndef __ASSEMBLY__
 
 /* Function prototypes */
-void mem_init(void);
+void omap3_mem_init(void);
 
 u32 is_mem_sdr(void);
 u32 mem_ok(u32 cs);
diff --git a/arch/arm/mach-omap2/omap3/board.c b/arch/arm/mach-omap2/omap3/board.c
index 8b70251457..c76a95dd5d 100644
--- a/arch/arm/mach-omap2/omap3/board.c
+++ b/arch/arm/mach-omap2/omap3/board.c
@@ -216,7 +216,7 @@ void s_init(void)
 void board_init_f(ulong dummy)
 {
 	early_system_init();
-	mem_init();
+	omap3_mem_init();
 	/*
 	* Save the boot parameters passed from romcode.
 	* We cannot delay the saving further than this,
diff --git a/arch/arm/mach-omap2/omap3/emif4.c b/arch/arm/mach-omap2/omap3/emif4.c
index 7e5a281922..4fbfb387ab 100644
--- a/arch/arm/mach-omap2/omap3/emif4.c
+++ b/arch/arm/mach-omap2/omap3/emif4.c
@@ -159,10 +159,10 @@ int dram_init_banksize(void)
 }
 
 /*
- * mem_init() -
+ * omap3_mem_init() -
  *  - Initialize memory subsystem
  */
-void mem_init(void)
+void omap3_mem_init(void)
 {
 	do_emif4_init();
 }
diff --git a/arch/arm/mach-omap2/omap3/sdrc.c b/arch/arm/mach-omap2/omap3/sdrc.c
index 5d43e7c9cf..f2a0769b9d 100644
--- a/arch/arm/mach-omap2/omap3/sdrc.c
+++ b/arch/arm/mach-omap2/omap3/sdrc.c
@@ -4,7 +4,7 @@
  *
  * This file has been created after exctracting and consolidating
  * the SDRC related content from mem.c and board.c, also created
- * generic init function (mem_init).
+ * generic init function (omap3_mem_init).
  *
  * Copyright (C) 2004-2010
  * Texas Instruments Incorporated - https://www.ti.com/
@@ -232,11 +232,11 @@ int dram_init_banksize(void)
 }
 
 /*
- * mem_init -
+ * map3_mem_init -
  *  - Init the sdrc chip,
  *  - Selects CS0 and CS1,
  */
-void mem_init(void)
+void omap3_mem_init(void)
 {
 	/* only init up first bank here */
 	do_sdrc_init(CS0, EARLY_INIT);
-- 
2.30.2

