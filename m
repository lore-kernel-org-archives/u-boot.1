Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E12FFCA1009
	for <u-boot@archiver.kernel.org>; Wed,  3 Sep 2025 08:00:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F2646833BF;
	Wed,  3 Sep 2025 10:00:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Al3V0UNw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7807A832EB; Wed,  3 Sep 2025 00:24:17 +0200 (CEST)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 78CD983253
 for <u-boot@lists.denx.de>; Wed,  3 Sep 2025 00:24:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=osama.abdelkader@gmail.com
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-afcb7ae31caso1135261666b.3
 for <u-boot@lists.denx.de>; Tue, 02 Sep 2025 15:24:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1756851855; x=1757456655; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=WGA7xbyWApKSf/qdUuk4HFGWRpJOmbdzVkChX5pI33s=;
 b=Al3V0UNwKn8CJODyU6EctTmA9UhDp5DTo+dn92gEZN/LhFztz2sqAPf/+ktc7k5dts
 edc7vVBBMmkXRhyv3FcG6hkIsUMtdQl2Q2e3B2paoJ+spSWHScojKfrz5pLwVMktf1oo
 8Zq0KbqZGromgQJI1/nBSSwwpKm78OocsBVWOWhAaZJECDongzFw2xhW1XmhsyWP45GQ
 Koh94j/9PDZ/2eXHv2OLlGqZS6zwOSSFJiKaa/xxWZKxmLk5c+XSDaFfLXmFGlLm+Xq3
 W7BM5kH/ALSSRPVDIFpmujEBDw4JxDjH/HNarwuLBrCYGEcij5HZ01k8wECyQddQwGJx
 BO8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756851855; x=1757456655;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=WGA7xbyWApKSf/qdUuk4HFGWRpJOmbdzVkChX5pI33s=;
 b=pFBpDtZsWrwIvH4QoOP1ay/m5qMtxve48MRVjPNrlcsNkz6Kes5RHl06aJ9OOZTmoi
 grHh9AiPBetMBDOpkJjyXTYcbVTZEnB3sOIDK8QzIdZ9/6zHpdSJdAbLo8Yg7uXhO6P4
 e14weJllF9/EXmz7yy/dbhDLye2/2vJ45kL3SsBxgMZLKn88IB9l6gI9irCGsjTdWbfI
 cVAmFplZjRLu352rYyx9S4GFXuMwq0gX7vk6dvUz/40sSqKlFpPwcux4UMjhyUTrGBp3
 VWV7CueuHGLn1MBqrNscd30Fnzr20ti6ovC2wmSEry9/T6pV+Bf/57G+dZQQiVGKb8Md
 ticQ==
X-Gm-Message-State: AOJu0Yy4wBupjsopD/L3MHy1/2CpVmhysgoZSsW+X8LJoPUoEfSKR4XS
 Mwf93yE4zCqxRlzM1PEiCzNmZ6H97snevxmFoD1bNsGCnlar5RiXyZ5haE8SNMUvCZA=
X-Gm-Gg: ASbGncsqyHzlVf5Pe2JKI36fYZjUlnK3KeU2VLKZei2gKeEPgsHvtsX6mr+uKsH+twv
 Z4kM80MCn2KxaZIL49pB9KZIWGx+joiMmdpkUPZ50sxYMfE5bnD2mDINAe5y0uE9wlSKZ+7fcwu
 IL7Dcjh7inhTfiZG1apOJytr9c+XJzmgIT34WPPlHotkxlCTLu/3Plvgt4CA8n2AmEvBcVunRCT
 +2cKLTqrELcDsaTX3OhI+w+Se6z1BqWPhVkSEcgKTK1PsdDhd96q/f8i9QF2dcxFTBVq9V7Yjrt
 bMRIAj5B5AQBhR2rY+7VKjWw4+LQm9sVW6KNCqyqKNu38cWQa0ghrqfsSzMObEnT6WDZd4CXBRD
 SK5pA5aq1wbmZPkdyd7A0sduc+Zy4Nv/AxE3lBbXb1PWcO5YgOED+aK4pD980DWqvF2CNpmxUUw
 BlD1O30gAOlekx2j8qJA==
X-Google-Smtp-Source: AGHT+IESiMS+B80XWKeF21iRWA6E+acc28lu6P2TAgCyFRdZZURBEPXYK2hmTzObTGLJ9wXAYSZMug==
X-Received: by 2002:a17:907:2d14:b0:af9:3589:68cb with SMTP id
 a640c23a62f3a-b01d975eb99mr1270925666b.48.1756851854778; 
 Tue, 02 Sep 2025 15:24:14 -0700 (PDT)
Received: from osama.. ([2a02:908:1b0:afe0:4282:1de9:794a:3397])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b0424cc1698sm651332066b.21.2025.09.02.15.24.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Sep 2025 15:24:14 -0700 (PDT)
From: Osama Abdelkader <osama.abdelkader@gmail.com>
To: sjg@chromium.org,
	trini@konsulko.com
Cc: u-boot@lists.denx.de,
	Osama Abdelkader <osama.abdelkader@gmail.com>
Subject: [PATCH] sandbox: replace deprecated getenv() with env_get()
Date: Wed,  3 Sep 2025 00:24:11 +0200
Message-ID: <20250902222411.152220-1-osama.abdelkader@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 03 Sep 2025 10:00:23 +0200
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

use env_get() instead of getenv() for consistency.

Signed-off-by: Osama Abdelkader <osama.abdelkader@gmail.com>
---
 arch/sandbox/cpu/os.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/sandbox/cpu/os.c b/arch/sandbox/cpu/os.c
index f5c9a8aecf2..adb6b586946 100644
--- a/arch/sandbox/cpu/os.c
+++ b/arch/sandbox/cpu/os.c
@@ -35,6 +35,7 @@
 #include <asm/state.h>
 #include <os.h>
 #include <rtc_def.h>
+#include <env.h>
 
 /* Environment variable for time offset */
 #define ENV_TIME_OFFSET "UBOOT_SB_TIME_OFFSET"
@@ -283,7 +284,7 @@ int os_unmap(void *buf, int size)
 
 int os_persistent_file(char *buf, int maxsize, const char *fname)
 {
-	const char *dirname = getenv("U_BOOT_PERSISTENT_DATA_DIR");
+	const char *dirname = env_get("U_BOOT_PERSISTENT_DATA_DIR");
 	char *ptr;
 	int len;
 
@@ -1014,7 +1015,7 @@ long os_get_time_offset(void)
 {
 	const char *offset;
 
-	offset = getenv(ENV_TIME_OFFSET);
+	offset = env_get(ENV_TIME_OFFSET);
 	if (offset)
 		return strtol(offset, NULL, 0);
 	return 0;
@@ -1132,7 +1133,7 @@ static void *fuzzer_thread(void * ptr)
 	const char *fuzz_test;
 
 	/* Find which test to run from an environment variable. */
-	fuzz_test = getenv("UBOOT_SB_FUZZ_TEST");
+	fuzz_test = env_get("UBOOT_SB_FUZZ_TEST");
 	if (!fuzz_test)
 		os_abort();
 
-- 
2.43.0

