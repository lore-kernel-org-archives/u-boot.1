Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECA2AE7716E
	for <u-boot@archiver.kernel.org>; Fri,  6 Dec 2024 02:36:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4FB0E895E2;
	Fri,  6 Dec 2024 03:36:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="MLWf+aLA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A4B5B8918C; Fri,  6 Dec 2024 03:36:45 +0100 (CET)
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com
 [IPv6:2607:f8b0:4864:20::d30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 728678962F
 for <u-boot@lists.denx.de>; Fri,  6 Dec 2024 03:36:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd30.google.com with SMTP id
 ca18e2360f4ac-843df3c4390so50362139f.3
 for <u-boot@lists.denx.de>; Thu, 05 Dec 2024 18:36:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1733452601; x=1734057401; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=El44hvYoArK6lqJKjv96dHFcIMtvoAoIYAra/BqgSOo=;
 b=MLWf+aLAfxi2JklkS9XgO/hvbT9YGrsriMA2MJ11gQ513m98+GWm5Erfj4myI/5PMr
 gkO84K9VN7sgvW27lJVLeHAsk0buIVnW9fttVNxwGHrDZ0n0HLEWMGMJBQGlbqetorIi
 O4wJcYt9Wny5dBq+j4IQIi/JRHnqaGIpqlxiU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733452601; x=1734057401;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=El44hvYoArK6lqJKjv96dHFcIMtvoAoIYAra/BqgSOo=;
 b=R4PrxGxr8u4IMmtFGrRYtStHdAoyWcmuIayWulU7TgEYGRHHYwmYA07h3vECKapv5+
 eIbaGvkdf2cXYf1NyhgmATeNt7NYW6P0OUrXJiQvg9WR0n3ZoTWZ5i5z+HTQ4sKhP8yY
 1V8dbaJdcRu/O9MKlLDCM2e/5Nbf8Ivi++sl9MBM4M0CFgK8BrlbaxHCHduNtioyRFJa
 U28RKjAc7pmUJ+H7I7oCWPZ52jS2H260m7r+LSEnqShUh7VL5Zo7s7qdU/pPbpsEYw1G
 Uvh3zcur4KZZoCuFKyWc7bfBoBy2yB3UqOPWITSKyVr+BUYUjjVUDgvDZOWoz7qTlavb
 GHmw==
X-Gm-Message-State: AOJu0YzBbFoVPAog1RmD5/Jo4p/WD5Y12m6MRHBdbBUR8DwkL0zU7sBV
 wO8BZIygg5h4ZrJdfiVELWruSY7L7atmOgDm4z1e+a5bYUfgM5+gdJZlIHgOQWzzwJnuo5moqbA
 =
X-Gm-Gg: ASbGncsQ+miQ5Z+8ZdQgqrpMAmqryIuQU5Ms1/9nhZq/tBrrV4510D/owM+ZwpWOftR
 pvysezz4YVOp2tYyb2X9XZ6+Rpw75nhF+cEsBJHFOkP8E37Vdir+K6r9aE2q1gIJP+CTrElAjo3
 vBJW7s9WtSoT9WWk1CRJIymP32/1p1YLlCF868hj/Ac1fc7sTfefeT5lw7c2L1NMe0IVy9bZvCL
 sP2zvUYxHDRGSdoDUTHgh/3D9YyMk7wSrVrHXREr+IHKEi7Q72jcDdBTs5rfJTWBY8eijCZzoRT
 I2JKKQ83aVs=
X-Google-Smtp-Source: AGHT+IFMC1uwF/5DclDB9YB+g8Lzx7hbfqSDYusJH8/5WTp4Fv8dMWyUtCpndSe8kyrzXTGYprwXLg==
X-Received: by 2002:a05:6e02:b4a:b0:3a7:820c:180a with SMTP id
 e9e14a558f8ab-3a811e29ca0mr20137055ab.19.1733452601309; 
 Thu, 05 Dec 2024 18:36:41 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4e2861f51bfsm575506173.112.2024.12.05.18.36.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Dec 2024 18:36:39 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Bin Meng <bmeng.cn@gmail.com>
Subject: [PATCH v3 03/46] x86: Drop duplicate definition of zimage_dump()
Date: Thu,  5 Dec 2024 19:35:42 -0700
Message-Id: <20241206023626.2456858-4-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241206023626.2456858-1-sjg@chromium.org>
References: <20241206023626.2456858-1-sjg@chromium.org>
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

This is now defined in bootm.h so drop the duplicate in the x86 code.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 arch/x86/include/asm/zimage.h | 8 --------
 cmd/x86/zboot.c               | 1 +
 2 files changed, 1 insertion(+), 8 deletions(-)

diff --git a/arch/x86/include/asm/zimage.h b/arch/x86/include/asm/zimage.h
index 8b542605170..76b2a797ccf 100644
--- a/arch/x86/include/asm/zimage.h
+++ b/arch/x86/include/asm/zimage.h
@@ -71,14 +71,6 @@ struct zboot_state {
 
 extern struct zboot_state state;
 
-/**
- * zimage_dump() - Dump information about a zimage
- *
- * @base_ptr: Pointer to the boot parameters
- * @show_cmdline: true to show the kernel command line
- */
-void zimage_dump(struct boot_params *base_ptr, bool show_cmdline);
-
 /**
  * zboot_load() - Load a zimage
  *
diff --git a/cmd/x86/zboot.c b/cmd/x86/zboot.c
index 3035172352a..40f67a75593 100644
--- a/cmd/x86/zboot.c
+++ b/cmd/x86/zboot.c
@@ -7,6 +7,7 @@
 
 #define LOG_CATEGORY	LOGC_BOOT
 
+#include <bootm.h>
 #include <command.h>
 #include <mapmem.h>
 #include <vsprintf.h>
-- 
2.34.1

