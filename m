Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BD77C46CD3
	for <u-boot@archiver.kernel.org>; Tue, 26 Dec 2023 15:49:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A1F4087987;
	Tue, 26 Dec 2023 16:49:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="xMfCxZG9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B0B1987986; Tue, 26 Dec 2023 16:49:02 +0100 (CET)
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com
 [IPv6:2a00:1450:4864:20::130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2C93E8797A
 for <u-boot@lists.denx.de>; Tue, 26 Dec 2023 16:49:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=maxim.uvarov@linaro.org
Received: by mail-lf1-x130.google.com with SMTP id
 2adb3069b0e04-50e7aed09adso1388179e87.0
 for <u-boot@lists.denx.de>; Tue, 26 Dec 2023 07:49:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703605739; x=1704210539; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mVSeNbQ8D1ZRK64eIrAXj0cWWWd2vM9c4djrpvxOh3I=;
 b=xMfCxZG9KSElTDIEilibx7y77VyD3Dv3p9CxbORAHg7nSk0PFyi6RG/tp/rUFPiHfh
 fRGNbWN3dBx+DLkcK8skKDj8qLOYKzplYtKUtOeSh7wBcXoeUsC+PRZF2h3JfunfRK/E
 53b1p4nCbX2fwrZx0TMBPhcG0c70+exqm6h+3MEU3t7UZBNf51ZYTM3u7dgOa6iQbZE/
 b3L/V2HfB0JhAzwtyGL2/5PRGH1l2FA02bsRAGow3X7Q20dD6VfMQ47B2nVbu8itNFGz
 eti+Rf8hgMPsX6OkKBiah7VWv7I1643etN+OQDv5+H9uE+xx8zkMwR9Yg9Jd850rDw8a
 x35g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703605739; x=1704210539;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mVSeNbQ8D1ZRK64eIrAXj0cWWWd2vM9c4djrpvxOh3I=;
 b=AOzWQzC7eRbzqJLu1E7ACxbW2/WUvehI7drTk2LEFwz3/OD9vrBSNfl/uxV9lF0CHr
 leKtd3cGVGEcMa5XfMZ08f6y/QaSMF36LG7PAYCT8oM+4hwAFez7MNgEBQpZSHZke/CC
 z6v10mCMHwGRyni12pRMQMqLfhwMEkT0ky+fba9SABnA/1uvcknKYgcCPxG8eKfuZI/B
 Wkqd6DRuQ0rZhOeErHqMWjVSms4k0QBKtPOMxRGHD2gnmqMW8fXHsxDUfeoL50SjE+Qw
 mTAoV/Bw4s0/X6Q8xd3D2SjobPNOd+VtZ4KhZnw0GATZWH13W2pDsJ/ycdFIQo8TlrUj
 9tmA==
X-Gm-Message-State: AOJu0YyoiMmidi954CNqZxA/9nx6hcDC4HQ+4hK+FVohcfd4QfmJCOzt
 o3gwB7xMFghry22euZ3ce7uX2J9qo08NOEAtzRFxgwsCwgU=
X-Google-Smtp-Source: AGHT+IGqfaWV7gWnl8N5Gy//1GCg+sUHw+6okZcGdEFpT2pcVBDFj2qI3lWR/j6//6Ek68f1HWRvfg==
X-Received: by 2002:a05:6512:23a2:b0:50e:464c:e9d with SMTP id
 c34-20020a05651223a200b0050e464c0e9dmr3648522lfv.101.1703605738795; 
 Tue, 26 Dec 2023 07:48:58 -0800 (PST)
Received: from localhost.localdomain ([45.82.14.220])
 by smtp.gmail.com with ESMTPSA id
 d25-20020a0565123d1900b0050e743b0b2csm1089336lfv.34.2023.12.26.07.48.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Dec 2023 07:48:58 -0800 (PST)
From: Maxim Uvarov <maxim.uvarov@linaro.org>
To: u-boot@lists.denx.de
Cc: simon.k.r.goldschmidt@gmail.com, tien.fong.chee@intel.com,
 sjg@chromium.org, joe.hershberger@ni.com, rfried.dev@gmail.com,
 bharat.gooty@broadcom.com, rayagonda.kokatanur@broadcom.com,
 trini@konsulko.com, Maxim Uvarov <maxim.uvarov@linaro.org>
Subject: [PATHv3 7/8] omap3: use device specific naming for mem_init
Date: Tue, 26 Dec 2023 21:46:18 +0600
Message-Id: <20231226154619.5071-8-maxim.uvarov@linaro.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20231226154619.5071-1-maxim.uvarov@linaro.org>
References: <20231226154619.5071-1-maxim.uvarov@linaro.org>
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
index 5d43e7c9cf..4d27d82c78 100644
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
+ * omap3_mem_init -
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

