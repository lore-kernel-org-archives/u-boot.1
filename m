Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E759BC369CA
	for <u-boot@archiver.kernel.org>; Thu, 17 Apr 2025 18:16:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6CC03830AB;
	Thu, 17 Apr 2025 20:16:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="nKkqviXF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2134F82E08; Thu, 17 Apr 2025 20:16:48 +0200 (CEST)
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com
 [IPv6:2607:f8b0:4864:20::d32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E060082EC6
 for <u-boot@lists.denx.de>; Thu, 17 Apr 2025 20:16:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd32.google.com with SMTP id
 ca18e2360f4ac-85b3f92c8f8so94871539f.1
 for <u-boot@lists.denx.de>; Thu, 17 Apr 2025 11:16:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1744913804; x=1745518604; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=c9Tg36wpyIEyDVR+dvJTZ69Gd+LwO5lR+RPbWuW8b2w=;
 b=nKkqviXFNMf78L8GFeSodLWC9GKAH6/ss/k3a0av756H8+mF39rBUWH/6DylKZSC3x
 fiku1E5iJsiT3pLD4jWs9Hfc1no0V24MCJhEmQ4bc331lR7YB9u/Ro2ig5K1NTiWkvJQ
 pWkQNHhAQMBGblYiWVwvY1XyhQFJfqQaAlAco=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744913804; x=1745518604;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=c9Tg36wpyIEyDVR+dvJTZ69Gd+LwO5lR+RPbWuW8b2w=;
 b=jtioPLwtix3g37ytvatctLlikNT7Wm3aXWbctXPH5TwbtQPcx/CtJjN1gmzkGytOeV
 O1VK0eFqOmKJhrnpy7omuNpg2cifWeYpHlvoi7MJRJNGw5jTKX0QdvFFL5m2XtYnEybp
 buNkGXumyTokaYsOOmF3RQPTu9Q8SSXXyfSOxKgSnCmP3IOlfhIfwOSuW4HQOapYrpYM
 ny84kPxfOEqYUjdfoN82cpEOhAXF3gkdDSB1dyhetIzUExEZfTYGyPT5oBEfAPc1QJBH
 zzKD/mXHw78mYEwEj4ga8AVTGYAcs3aAj/sBNYv7tM0N1+IMFVwKqV4G8Q4NQlr3A8ec
 PpGA==
X-Gm-Message-State: AOJu0YwwUw6ZFpjQEr/ykMQlXA2W4lOGVUBC2k0V09M9c0IYMZDcGI1M
 ater5AROrOX6keHzId0Bm1EH03uspPyc9IL7VzCe7deVo+uBR/Yt3hhgvtaBJFdTy/Gi4+3uLSM
 =
X-Gm-Gg: ASbGnctDEtMCn1M/6FdiyxSVGhVG+nPmiArW5hzNjpYYN9AkVEQBSM+ZAel8Ca3BprT
 sytWpJCgwjnRJ/x/oYjHmYhSxY4RT5ANFnQTcndS8sbDGcfL06fsR8TPAxdKr0W+DDGJ1djf4zz
 Oi4T1V3ZKIufYkjMJaGbh6BR3EjkvOURENHw4QepA4JbesODqViG937ExeU/IP1KM+1cmVmYj7C
 io45Q6W1fgl9CBC34mhbN5wc9kS8MIZ0zPO6AXLnib1okLJalL3mKN7cIubxBW0NM+8/VnwUy93
 YZRP5Kf77VbkCGpSzK2mTOnZ3G2+FAlNu7YzdPrJRpL3iELWzvxejggdGI1Kai71FFLlGehfWIR
 d+g==
X-Google-Smtp-Source: AGHT+IHyQlEimQx7fDhF4xCJsCOCeIAo9Yj5/IzFEt2u0f1+cRI6pcl3U3cNrKXPPq66JPr578HV0A==
X-Received: by 2002:a05:6602:3a0b:b0:85b:48e7:14fd with SMTP id
 ca18e2360f4ac-861c5a2ec38mr855376339f.14.1744913803794; 
 Thu, 17 Apr 2025 11:16:43 -0700 (PDT)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4f6a37cb9aesm66673173.28.2025.04.17.11.16.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Apr 2025 11:16:42 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Peter Maydell <peter.maydell@linaro.org>,
 Raymond Mao <raymond.mao@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Andrew Phelps <andrew.phelps@canonical.com>,
 =?UTF-8?q?Fran=C3=A7ois=20Ozog?= <francois.ozog@linaro.org>,
 Bill Mills <bill.mills@linaro.org>, Simon Glass <sjg@chromium.org>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Sean Anderson <seanga2@gmail.com>, Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: [PATCH v3 03/22] spl: Tidy up the header includes
Date: Thu, 17 Apr 2025 12:15:45 -0600
Message-ID: <20250417121601.v3.3.Ie563607416a8f7504c69b46ce608c1c1df75caa6@changeid>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250417181613.1355024-1-sjg@chromium.org>
References: <20250417181613.1355024-1-sjg@chromium.org>
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

These are out of order. Fix them.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 common/spl/spl.c | 27 +++++++++++++--------------
 1 file changed, 13 insertions(+), 14 deletions(-)

diff --git a/common/spl/spl.c b/common/spl/spl.c
index 76fd56dfe4b..abbca9acde0 100644
--- a/common/spl/spl.c
+++ b/common/spl/spl.c
@@ -6,42 +6,41 @@
  * Aneesh V <aneesh@ti.com>
  */
 
-#include <config.h>
-#include <bloblist.h>
 #include <binman_sym.h>
+#include <bloblist.h>
+#include <bootcount.h>
 #include <bootstage.h>
 #include <dm.h>
+#include <fat.h>
+#include <fdt_support.h>
 #include <handoff.h>
 #include <hang.h>
+#include <image.h>
 #include <init.h>
 #include <irq_func.h>
 #include <log.h>
+#include <malloc.h>
 #include <mapmem.h>
+#include <nand.h>
 #include <serial.h>
 #include <spl.h>
 #include <spl_load.h>
 #include <system-constants.h>
-#include <asm/global_data.h>
-#include <asm-generic/gpio.h>
-#include <nand.h>
-#include <fat.h>
-#include <u-boot/crc.h>
 #if CONFIG_IS_ENABLED(BANNER_PRINT)
 #include <timestamp.h>
 #endif
 #include <version.h>
-#include <image.h>
-#include <malloc.h>
-#include <mapmem.h>
+#include <video.h>
+#include <wdt.h>
+#include <asm-generic/gpio.h>
+#include <asm/global_data.h>
+#include <asm/u-boot.h>
 #include <dm/root.h>
 #include <dm/util.h>
 #include <dm/device-internal.h>
 #include <dm/uclass-internal.h>
 #include <linux/compiler.h>
-#include <fdt_support.h>
-#include <bootcount.h>
-#include <wdt.h>
-#include <video.h>
+#include <u-boot/crc.h>
 
 DECLARE_GLOBAL_DATA_PTR;
 DECLARE_BINMAN_MAGIC_SYM;
-- 
2.43.0

