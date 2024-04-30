Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEDEFC4345F
	for <u-boot@archiver.kernel.org>; Tue, 30 Apr 2024 13:39:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4B70F88A67;
	Tue, 30 Apr 2024 15:36:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="FEHCvCTQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BAC0888A53; Tue, 30 Apr 2024 15:36:24 +0200 (CEST)
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com
 [IPv6:2607:f8b0:4864:20::730])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 31D1B88A1D
 for <u-boot@lists.denx.de>; Tue, 30 Apr 2024 15:36:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x730.google.com with SMTP id
 af79cd13be357-78f05341128so400417485a.0
 for <u-boot@lists.denx.de>; Tue, 30 Apr 2024 06:36:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1714484181; x=1715088981; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nEBdN/Aup7knESw95fsoqV3zgGPHtBHGriVVvoAWDh0=;
 b=FEHCvCTQH4Mj31L1pLA4qntK7qKQy2EfI5wiOjmGcaGYeTeS4jS0E+ay4DnHQGt6+/
 2LkkrukEatBMEjbVEsLY8bSU28zWCMz2L4XQsOQjwF3/9kyr/7xoJIGog4qwORVt0Xca
 vkefxuobLeHsC6X3zDJcItubncoaoGZMz4HBc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714484181; x=1715088981;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nEBdN/Aup7knESw95fsoqV3zgGPHtBHGriVVvoAWDh0=;
 b=JxBSVjTMdFPQD3EfOqGoQBPRByAlx4HRE8/LtTLx0ck7IK/DTPjoQQEuNYuaKEUT0M
 O0iNnqtEmzhwuXe4o0lwuRwlAMDNn30b/7eKxWfaeq/QDXj4c6EdmUYzpzW+779lwXE+
 MHSMM3DDhxDNchybHz5uAbkNuF8m6pB4O4evTuhu3e/PgkHqh6VL9XKLhU/QpxwCADJX
 3D7/hEuo27ZbMXfZlGl+sBgZpNdf7rLhI+AnqXftsg7bsMchJKi2nL4MfHkjRnTV3cxd
 cJ0LMd7vPC3tGpda3sOygBXlGUIIx2Yw2SWDMB0BT4jouCL8mTWtZpJgLuPc7Zq2YF5X
 bvvQ==
X-Gm-Message-State: AOJu0YxDhMHtr0boqmhV765Ev3vlLFUp1DvBant4Lfr6LgOuCHveIhJQ
 dIWHK1x6KQKv+Fa5XlworV75lR38+teekw4VAWvgxBssodET/AwhYvLQsWt54IV0U8wUqQGYK78
 41KF/vA==
X-Google-Smtp-Source: AGHT+IFXR1qSVG81duYpanbxuEM8W0szxYhMxT/CbB/tnZkPDNrhHmBE1XeZbOIsr27B4fpVph2CXA==
X-Received: by 2002:ad4:5768:0:b0:6a0:c953:cb02 with SMTP id
 r8-20020ad45768000000b006a0c953cb02mr7794118qvx.3.1714484180845; 
 Tue, 30 Apr 2024 06:36:20 -0700 (PDT)
Received: from bill-the-cat.tail58a08.ts.net ([187.144.98.216])
 by smtp.gmail.com with ESMTPSA id
 f12-20020a05621400cc00b006a0d0d792cesm1743877qvs.83.2024.04.30.06.36.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Apr 2024 06:36:20 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Stefan Bosch <stefan_b@posteo.net>
Subject: [PATCH 17/33] arm: nexell: Remove <common.h> and add needed includes
Date: Tue, 30 Apr 2024 07:35:43 -0600
Message-Id: <20240430133559.1836389-17-trini@konsulko.com>
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

Remove <common.h> from all mach-nexell files and when needed add missing
include files directly.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
Cc: Stefan Bosch <stefan_b@posteo.net>
---
 arch/arm/mach-nexell/clock.c              | 2 +-
 arch/arm/mach-nexell/include/mach/reset.h | 2 ++
 arch/arm/mach-nexell/reset.c              | 1 -
 arch/arm/mach-nexell/tieoff.c             | 1 -
 arch/arm/mach-nexell/timer.c              | 1 -
 5 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-nexell/clock.c b/arch/arm/mach-nexell/clock.c
index 59ffa26255f5..3082f6077b73 100644
--- a/arch/arm/mach-nexell/clock.c
+++ b/arch/arm/mach-nexell/clock.c
@@ -4,8 +4,8 @@
  * Hyunseok, Jung <hsjung@nexell.co.kr>
  */
 
-#include <common.h>
 #include <command.h>
+#include <vsprintf.h>
 #include <linux/err.h>
 #include <asm/io.h>
 #include <asm/arch/nexell.h>
diff --git a/arch/arm/mach-nexell/include/mach/reset.h b/arch/arm/mach-nexell/include/mach/reset.h
index e1301d4e53d3..0c6a13043f91 100644
--- a/arch/arm/mach-nexell/include/mach/reset.h
+++ b/arch/arm/mach-nexell/include/mach/reset.h
@@ -7,6 +7,8 @@
 #ifndef __NEXELL_RESET__
 #define __NEXELL_RESET__
 
+#include <linux/types.h>
+
 #define NUMBER_OF_RESET_MODULE_PIN      69
 
 enum rstcon {
diff --git a/arch/arm/mach-nexell/reset.c b/arch/arm/mach-nexell/reset.c
index 1f732a3d3732..627f568270b6 100644
--- a/arch/arm/mach-nexell/reset.c
+++ b/arch/arm/mach-nexell/reset.c
@@ -8,7 +8,6 @@
  *FIXME : Not support device tree & reset control driver.
  *        will remove after support device tree & reset control driver.
  */
-#include <common.h>
 #include <asm/io.h>
 #include <asm/arch/nexell.h>
 #include <asm/arch/reset.h>
diff --git a/arch/arm/mach-nexell/tieoff.c b/arch/arm/mach-nexell/tieoff.c
index 5a4744c296a2..51cca6744d6f 100644
--- a/arch/arm/mach-nexell/tieoff.c
+++ b/arch/arm/mach-nexell/tieoff.c
@@ -4,7 +4,6 @@
  * Youngbok, Park <park@nexell.co.kr>
  */
 
-#include <common.h>
 #include <asm/arch/nexell.h>
 #include <asm/arch/clk.h>
 #include <asm/arch/reset.h>
diff --git a/arch/arm/mach-nexell/timer.c b/arch/arm/mach-nexell/timer.c
index 3b311fd22a56..b35c7b1bb33a 100644
--- a/arch/arm/mach-nexell/timer.c
+++ b/arch/arm/mach-nexell/timer.c
@@ -4,7 +4,6 @@
  * Hyunseok, Jung <hsjung@nexell.co.kr>
  */
 
-#include <common.h>
 #include <log.h>
 
 #include <asm/io.h>
-- 
2.34.1

