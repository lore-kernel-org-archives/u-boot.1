Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E372FCDB474
	for <u-boot@archiver.kernel.org>; Thu, 12 Oct 2023 23:17:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 077DF86EB8;
	Fri, 13 Oct 2023 01:14:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="csp02xTx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 84B3A86AE6; Fri, 13 Oct 2023 01:04:39 +0200 (CEST)
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com
 [IPv6:2607:f8b0:4864:20::112b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BE3DB86E37
 for <u-boot@lists.denx.de>; Fri, 13 Oct 2023 01:04:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112b.google.com with SMTP id
 00721157ae682-5a7af52ee31so18571557b3.2
 for <u-boot@lists.denx.de>; Thu, 12 Oct 2023 16:04:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1697151844; x=1697756644; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JAwqw5kEw5iMkMzO/RkA1BXByBiCKV756AmtJ+Of06E=;
 b=csp02xTxoYNDV4jX09IQmWqGkVvaLY97eaufAjJqq4nmzNtfmSCHGhgOcC1LJEcp7+
 3HmyJQ5EaROYmuGR5R+ozqudsAjx8kqe5YClTxw2qvKxbg7CgyQZx6+LvfeDezquVhLZ
 K78GwrJiDjqBDbUbRo9fwFGaxKgycsak0Qb6Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697151844; x=1697756644;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JAwqw5kEw5iMkMzO/RkA1BXByBiCKV756AmtJ+Of06E=;
 b=qgEOtM99NhnN7gFwPwd/ZLc4YVQwDb2mc+4/+nmpa3RwBjSkOXGFQmVZs01tPvbv7o
 DMDIyIdyKkt/klkPHfAtTkGavzHz91+iuoNCCxaMsF4haBL0IKURSD+jI1Duq8tlMRS8
 SgcDjb5+jlW0AJp1HVEtBDHE9dYH4Xu7DFa89QoDUdjCgpjFpteept7+SnSww4uihgOa
 OnX7T+YsbNStZXf+WlPCc4aFH9TbO/BVrpC97GNW1LtZnpljC7tPYvlU8p/QJ+D5k8zX
 d6RkyHhLPUSBxO4A8bvdIVVyX/r1KmuOaU6VYvTD0cgOfbbacZdGECjrzcSHxgMlVYQF
 FBdw==
X-Gm-Message-State: AOJu0Yxuka0WuyVvtzDtarvrwKidz5nbbLAZXwSB3yK7zDYN+jBeZnY7
 B+aIdeB9t/WRg0s9RwEntHQlxCFvTeMGTT0AT8zC9Q==
X-Google-Smtp-Source: AGHT+IFxaJLG/wXeezCrauI3KgsZM8MAiWiDyXxym6HQj2CzxX0qit9E1IBZqZH8HzPHdQOljbio6g==
X-Received: by 2002:a81:4f88:0:b0:5a8:1aa2:1ac1 with SMTP id
 d130-20020a814f88000000b005a81aa21ac1mr464235ywb.12.1697151844466; 
 Thu, 12 Oct 2023 16:04:04 -0700 (PDT)
Received: from bill-the-cat.lan
 (2603-6081-7b00-6400-5647-4a14-f04e-8d8d.res6.spectrum.com.
 [2603:6081:7b00:6400:5647:4a14:f04e:8d8d])
 by smtp.gmail.com with ESMTPSA id
 k7-20020a816f07000000b005925765aa30sm278730ywc.135.2023.10.12.16.04.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Oct 2023 16:04:03 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Michal Simek <michal.simek@amd.com>
Subject: [PATCH 5/7] microblaze: Remove common.h usage
Date: Thu, 12 Oct 2023 19:03:57 -0400
Message-Id: <20231012230359.2005249-5-trini@konsulko.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231012230359.2005249-1-trini@konsulko.com>
References: <20231012230359.2005249-1-trini@konsulko.com>
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

We can remove common.h from most cases of the code here, and only a few
places need an additional header instead.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
Cc: Michal Simek <michal.simek@amd.com>
---
 arch/microblaze/cpu/cache.c                          | 1 -
 arch/microblaze/cpu/cpuinfo.c                        | 1 -
 arch/microblaze/cpu/exception.c                      | 2 +-
 arch/microblaze/cpu/interrupts.c                     | 3 ++-
 arch/microblaze/cpu/pvr.c                            | 1 -
 arch/microblaze/cpu/relocate.c                       | 3 ++-
 arch/microblaze/cpu/spl.c                            | 1 -
 arch/microblaze/include/asm/cpuinfo.h                | 2 ++
 arch/microblaze/lib/bootm.c                          | 1 -
 board/xilinx/microblaze-generic/microblaze-generic.c | 1 -
 10 files changed, 7 insertions(+), 9 deletions(-)

diff --git a/arch/microblaze/cpu/cache.c b/arch/microblaze/cpu/cache.c
index 829e6c7ae605..75ec0a8fd24f 100644
--- a/arch/microblaze/cpu/cache.c
+++ b/arch/microblaze/cpu/cache.c
@@ -5,7 +5,6 @@
  * Michal SIMEK <monstr@monstr.eu>
  */
 
-#include <common.h>
 #include <cpu_func.h>
 #include <asm/asm.h>
 #include <asm/cache.h>
diff --git a/arch/microblaze/cpu/cpuinfo.c b/arch/microblaze/cpu/cpuinfo.c
index 6b15d6ca41c0..2bfdf767f3a5 100644
--- a/arch/microblaze/cpu/cpuinfo.c
+++ b/arch/microblaze/cpu/cpuinfo.c
@@ -2,7 +2,6 @@
 /*
  * Copyright (C) 2022, Ovidiu Panait <ovpanait@gmail.com>
  */
-#include <common.h>
 #include <asm/cpuinfo.h>
 #include <asm/global_data.h>
 
diff --git a/arch/microblaze/cpu/exception.c b/arch/microblaze/cpu/exception.c
index 9414776afa7f..6b329fc7b3a2 100644
--- a/arch/microblaze/cpu/exception.c
+++ b/arch/microblaze/cpu/exception.c
@@ -5,8 +5,8 @@
  * Michal  SIMEK <monstr@monstr.eu>
  */
 
-#include <common.h>
 #include <hang.h>
+#include <stdio.h>
 #include <asm/asm.h>
 
 void _hw_exception_handler (void)
diff --git a/arch/microblaze/cpu/interrupts.c b/arch/microblaze/cpu/interrupts.c
index ac53208bda67..244f7fd15eba 100644
--- a/arch/microblaze/cpu/interrupts.c
+++ b/arch/microblaze/cpu/interrupts.c
@@ -7,7 +7,8 @@
  * Yasushi SHOJI <yashi@atmark-techno.com>
  */
 
-#include <common.h>
+#include <log.h>
+#include <vsprintf.h>
 #include <asm/asm.h>
 
 void enable_interrupts(void)
diff --git a/arch/microblaze/cpu/pvr.c b/arch/microblaze/cpu/pvr.c
index 23c0f912d435..71aea0b9380c 100644
--- a/arch/microblaze/cpu/pvr.c
+++ b/arch/microblaze/cpu/pvr.c
@@ -2,7 +2,6 @@
 /*
  * Copyright (C) 2022, Ovidiu Panait <ovpanait@gmail.com>
  */
-#include <common.h>
 #include <asm/asm.h>
 #include <asm/pvr.h>
 
diff --git a/arch/microblaze/cpu/relocate.c b/arch/microblaze/cpu/relocate.c
index 7a15fb2ec397..e46fe5bdd5d7 100644
--- a/arch/microblaze/cpu/relocate.c
+++ b/arch/microblaze/cpu/relocate.c
@@ -4,8 +4,9 @@
  * Michal Simek <michal.simek@amd.com>
  */
 
-#include <common.h>
 #include <elf.h>
+#include <log.h>
+#include <linux/types.h>
 
 #define R_MICROBLAZE_NONE	0
 #define R_MICROBLAZE_32		1
diff --git a/arch/microblaze/cpu/spl.c b/arch/microblaze/cpu/spl.c
index c21beafdb810..cb224bd25423 100644
--- a/arch/microblaze/cpu/spl.c
+++ b/arch/microblaze/cpu/spl.c
@@ -5,7 +5,6 @@
  * Michal Simek <michal.simek@amd.com>
  */
 
-#include <common.h>
 #include <command.h>
 #include <image.h>
 #include <log.h>
diff --git a/arch/microblaze/include/asm/cpuinfo.h b/arch/microblaze/include/asm/cpuinfo.h
index 3c58e52217c4..fbd9418a2f8b 100644
--- a/arch/microblaze/include/asm/cpuinfo.h
+++ b/arch/microblaze/include/asm/cpuinfo.h
@@ -6,6 +6,8 @@
 #ifndef __ASM_MICROBLAZE_CPUINFO_H
 #define __ASM_MICROBLAZE_CPUINFO_H
 
+#include <linux/types.h>
+
 /**
  * struct microblaze_cpuinfo - CPU info for microblaze processor core.
  *
diff --git a/arch/microblaze/lib/bootm.c b/arch/microblaze/lib/bootm.c
index 930384f4015f..f3ec4b741b88 100644
--- a/arch/microblaze/lib/bootm.c
+++ b/arch/microblaze/lib/bootm.c
@@ -7,7 +7,6 @@
  * Yasushi SHOJI <yashi@atmark-techno.com>
  */
 
-#include <common.h>
 #include <bootstage.h>
 #include <command.h>
 #include <cpu_func.h>
diff --git a/board/xilinx/microblaze-generic/microblaze-generic.c b/board/xilinx/microblaze-generic/microblaze-generic.c
index a427ac94a170..2b035d535892 100644
--- a/board/xilinx/microblaze-generic/microblaze-generic.c
+++ b/board/xilinx/microblaze-generic/microblaze-generic.c
@@ -10,7 +10,6 @@
  * header files
  */
 
-#include <common.h>
 #include <config.h>
 #include <env.h>
 #include <init.h>
-- 
2.34.1

