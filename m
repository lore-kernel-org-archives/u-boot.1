Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EF3AC4345F
	for <u-boot@archiver.kernel.org>; Tue, 30 Apr 2024 13:39:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A97E888A39;
	Tue, 30 Apr 2024 15:36:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="MgYOi3tk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BF23288A42; Tue, 30 Apr 2024 15:36:27 +0200 (CEST)
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com
 [IPv6:2607:f8b0:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 822DD88A20
 for <u-boot@lists.denx.de>; Tue, 30 Apr 2024 15:36:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32b.google.com with SMTP id
 46e09a7af769-6eb8ea5ac95so3433436a34.2
 for <u-boot@lists.denx.de>; Tue, 30 Apr 2024 06:36:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1714484184; x=1715088984; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ogpyRe0mkB6jLCGEP/BwnYwIMcbiVsCB+M4Efs+p3WY=;
 b=MgYOi3tkNVP9AqsAby0w2rm0faFpWxoev0rUN4DNgLuM6IbiDJQnVvsRPZIl2dTZcD
 4Cu9ijpkpcigwhv+u+c3bIc0ObiwcC9pJO2rkXSrSyhElQYFgW+wh+J5FQCDFV4smzkL
 SFE1eY9A5d08OyNLWHiWSFCjc0N0al1X4O6bs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714484184; x=1715088984;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ogpyRe0mkB6jLCGEP/BwnYwIMcbiVsCB+M4Efs+p3WY=;
 b=n8tHfh3tN/ASJrx5c8sGIM73IMGCBShkptigWhHlcNtaT5uOTsvMIzYnJqyl1MpDPr
 q+UpMnzhUdMLLP5l/T/UgjZhj9bQOKDDXsBSM6aaiCHX9YHfz5dxbDsha8HrXOQ8+2HJ
 E1D9elVn60Bj1AhE+otdFqDRDWyVls5KQYH7Dql1IcDYo2KCH8Q5ZGEB9SPXH7fAfCch
 XjNswKbOUp6v7pe4YbJDN1+0fc5GDxMptSHsceFyQn3aG/2hlcQphZL9cilT4qk2yvDs
 jDrKtbWtr/Vlwj5gZV7LyLE/OBo+CKgVJpKLgUMIPNzLnnsNOO0O7HX1fZ/6QxRtQHqa
 vzfA==
X-Gm-Message-State: AOJu0YxDtxOkW4EptaocnrMK6jOYDPA/+ba4GyMP6GeKOt8LgtsOFJED
 YIAcBWr723VpnRdVpDIowzfSW+alkKexH8BejPNzsljST550O7jbm/TtetbYRp3GF54emnzezcE
 VJTfkmg==
X-Google-Smtp-Source: AGHT+IE1qWI3K+LhxRqwCpxwz3etG6PoXxJxWauhWXqdPwIzU6ateAww+Tj+/WgUlMXQd/yoq+EmUA==
X-Received: by 2002:a9d:6318:0:b0:6ee:359a:527c with SMTP id
 q24-20020a9d6318000000b006ee359a527cmr3162716otk.31.1714484184147; 
 Tue, 30 Apr 2024 06:36:24 -0700 (PDT)
Received: from bill-the-cat.tail58a08.ts.net ([187.144.98.216])
 by smtp.gmail.com with ESMTPSA id
 f12-20020a05621400cc00b006a0d0d792cesm1743877qvs.83.2024.04.30.06.36.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Apr 2024 06:36:23 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>,
 Chunfeng Yun <chunfeng.yun@mediatek.com>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>
Subject: [PATCH 20/33] arm: mediatek: Remove <common.h> and add needed includes
Date: Tue, 30 Apr 2024 07:35:46 -0600
Message-Id: <20240430133559.1836389-20-trini@konsulko.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240430133559.1836389-1-trini@konsulko.com>
References: <20240430133559.1836389-1-trini@konsulko.com>
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

Remove <common.h> from all mach-mediatek files and when needed add
missing include files directly.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
Cc: Ryder Lee <ryder.lee@mediatek.com>
Cc: Weijie Gao <weijie.gao@mediatek.com>
Cc: Chunfeng Yun <chunfeng.yun@mediatek.com>
Cc: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>
---
 arch/arm/mach-mediatek/cpu.c         | 1 -
 arch/arm/mach-mediatek/mt7623/init.c | 2 +-
 arch/arm/mach-mediatek/mt7629/init.c | 2 +-
 arch/arm/mach-mediatek/mt8183/init.c | 1 -
 arch/arm/mach-mediatek/mt8512/init.c | 1 -
 arch/arm/mach-mediatek/mt8516/init.c | 1 -
 arch/arm/mach-mediatek/mt8518/init.c | 1 -
 arch/arm/mach-mediatek/spl.c         | 1 -
 8 files changed, 2 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mach-mediatek/cpu.c b/arch/arm/mach-mediatek/cpu.c
index c329e7cc98a8..8e8bc4f9ceaa 100644
--- a/arch/arm/mach-mediatek/cpu.c
+++ b/arch/arm/mach-mediatek/cpu.c
@@ -3,7 +3,6 @@
  * Copyright (C) 2018 MediaTek Inc.
  */
 
-#include <common.h>
 #include <cpu_func.h>
 #include <dm.h>
 #include <init.h>
diff --git a/arch/arm/mach-mediatek/mt7623/init.c b/arch/arm/mach-mediatek/mt7623/init.c
index 988b057e5984..3d6ba3f383c5 100644
--- a/arch/arm/mach-mediatek/mt7623/init.c
+++ b/arch/arm/mach-mediatek/mt7623/init.c
@@ -3,7 +3,7 @@
  * Copyright (C) 2018 MediaTek Inc.
  */
 
-#include <common.h>
+#include <config.h>
 #include <init.h>
 #include <asm/global_data.h>
 #include <linux/io.h>
diff --git a/arch/arm/mach-mediatek/mt7629/init.c b/arch/arm/mach-mediatek/mt7629/init.c
index 0130554ff35c..7cb8b72c364c 100644
--- a/arch/arm/mach-mediatek/mt7629/init.c
+++ b/arch/arm/mach-mediatek/mt7629/init.c
@@ -5,7 +5,7 @@
  */
 
 #include <clk.h>
-#include <common.h>
+#include <config.h>
 #include <dm.h>
 #include <fdtdec.h>
 #include <init.h>
diff --git a/arch/arm/mach-mediatek/mt8183/init.c b/arch/arm/mach-mediatek/mt8183/init.c
index 7496029705f6..37243547da81 100644
--- a/arch/arm/mach-mediatek/mt8183/init.c
+++ b/arch/arm/mach-mediatek/mt8183/init.c
@@ -6,7 +6,6 @@
  */
 
 #include <clk.h>
-#include <common.h>
 #include <dm.h>
 #include <fdtdec.h>
 #include <ram.h>
diff --git a/arch/arm/mach-mediatek/mt8512/init.c b/arch/arm/mach-mediatek/mt8512/init.c
index 5a21e9a4485c..3b48caf5196c 100644
--- a/arch/arm/mach-mediatek/mt8512/init.c
+++ b/arch/arm/mach-mediatek/mt8512/init.c
@@ -7,7 +7,6 @@
  */
 
 #include <clk.h>
-#include <common.h>
 #include <dm.h>
 #include <fdtdec.h>
 #include <init.h>
diff --git a/arch/arm/mach-mediatek/mt8516/init.c b/arch/arm/mach-mediatek/mt8516/init.c
index 3460dcc24943..892bd441a33b 100644
--- a/arch/arm/mach-mediatek/mt8516/init.c
+++ b/arch/arm/mach-mediatek/mt8516/init.c
@@ -6,7 +6,6 @@
  */
 
 #include <clk.h>
-#include <common.h>
 #include <cpu_func.h>
 #include <dm.h>
 #include <fdtdec.h>
diff --git a/arch/arm/mach-mediatek/mt8518/init.c b/arch/arm/mach-mediatek/mt8518/init.c
index f7e03de36507..c04bcb635178 100644
--- a/arch/arm/mach-mediatek/mt8518/init.c
+++ b/arch/arm/mach-mediatek/mt8518/init.c
@@ -7,7 +7,6 @@
  */
 
 #include <clk.h>
-#include <common.h>
 #include <cpu_func.h>
 #include <dm.h>
 #include <fdtdec.h>
diff --git a/arch/arm/mach-mediatek/spl.c b/arch/arm/mach-mediatek/spl.c
index d3cda94617e1..247d7ee6f1db 100644
--- a/arch/arm/mach-mediatek/spl.c
+++ b/arch/arm/mach-mediatek/spl.c
@@ -5,7 +5,6 @@
  */
 
 #include <clk.h>
-#include <common.h>
 #include <hang.h>
 #include <init.h>
 #include <spl.h>
-- 
2.34.1

