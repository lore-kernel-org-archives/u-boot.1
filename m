Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E66A5C3ABC3
	for <u-boot@archiver.kernel.org>; Sat, 10 May 2025 13:43:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1794082A4D;
	Sat, 10 May 2025 15:43:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="JbYwg3P5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 46F2582A4D; Sat, 10 May 2025 15:43:30 +0200 (CEST)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com
 [IPv6:2a00:1450:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2FC0A826AA
 for <u-boot@lists.denx.de>; Sat, 10 May 2025 15:43:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-ac2963dc379so473395666b.2
 for <u-boot@lists.denx.de>; Sat, 10 May 2025 06:43:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1746884606; x=1747489406; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=c9Tg36wpyIEyDVR+dvJTZ69Gd+LwO5lR+RPbWuW8b2w=;
 b=JbYwg3P58CCzCrGUcsj4Img6GtGOMw+kfu7PFhDRcP/5HW2TUB5p8IHztsB0/ilg/K
 oTIhZzm5++ygf+D5GhwPjciGy4bGorOxTBF6S6oUb+CSvkM7W1XJ5nJ3T/5E7XRm1RIP
 dMYl464LtaCBD8mufME8LlyOJWREQxM7iE9f4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746884606; x=1747489406;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=c9Tg36wpyIEyDVR+dvJTZ69Gd+LwO5lR+RPbWuW8b2w=;
 b=jOoh8QFGtqzcnbvOn3CV6apy7RRm/qwpPYQDUcCHeoDxXXHODooTudAfDdzOSoUCjC
 jgTy02pMdY/3cRS6XJIIgAWi4IVmfaPAgVZDqSYFVlO4Cnz/cK7t4YFdWfsp/vOcDXDl
 hWCBSfnlu8zbrJZ8hc+UE50wHaairry/3/TP/+QCO9PSMPVr1BaMn0t6SIpz54wZ1JbO
 7SBS7xBD3jrHwdjspGFawC0OB/i2y4WkJfcKgK+QXwTzQZwxrYqykXBk8nHNjjXHntZj
 8zYmKT/SbrBmsPlGl7lAb1e39BVMVrtxdxzLWxLlKM3mverlY3pNkkbp/runr1qdnPVM
 E4lw==
X-Gm-Message-State: AOJu0YyNZ7djWPco/mOzC42Sz5m/R1XlBsRWa/quNf76z5bkIou+5IET
 Ap3MycDWX5CHZ2UXCWYvnF613eK2PvIHzOg8ViG+5swAhDXWu6Vr+IhxwpWLbW+D7x97/VycmY0
 +INQiIKNVOQ==
X-Gm-Gg: ASbGncsbiHEnCKDSxzWts/iiMAQhKM6OmoAwAoSSh7jXGWeylIM1+CGTLc9zXUYv1He
 MQxjDGq82wPncO9o93bGwnKRhD6RCb8ZyvB5ePs/snb2yZB8k9GyMkjf9RhOEegeQ/PZgUM0OM7
 N/OdifndpeA9GrRMbNWe78vgQlN23baIvvelqGpqzRVAxV0wB7U73qjIjSntv0koT1QFLs3aKOC
 dAyzypzH/52rhJvyB0La/gBGC8rRsqLwdRQa8q/ZL6/UIf81P+cB+HghftF50diXv/cDYt9BzX4
 g1eftONcQK4ukStNZCwe4cKiYIuvD/SJ7+hTUsUC4dCumegtFEZhwPIlq/wevs5D2gdj
X-Google-Smtp-Source: AGHT+IFg/o4xbNlf9ohkaIK4+QqLpTXyW68LJNgSKCFCQ90qyMLWThnf/pb6mx3eoIx7QpE5+BwnJA==
X-Received: by 2002:a17:907:db02:b0:ac8:1142:a9e5 with SMTP id
 a640c23a62f3a-ad21915df0fmr694069366b.47.1746884606157; 
 Sat, 10 May 2025 06:43:26 -0700 (PDT)
Received: from chromium.org (82-132-222-17.dab.02.net. [82.132.222.17])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ad219747028sm319763866b.106.2025.05.10.06.43.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 10 May 2025 06:43:25 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Raymond Mao <raymond.mao@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Bill Mills <bill.mills@linaro.org>,
 Andrew Phelps <andrew.phelps@canonical.com>,
 =?UTF-8?q?Fran=C3=A7ois=20Ozog?= <francois.ozog@linaro.org>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Sean Anderson <seanga2@gmail.com>, Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: [PATCH v4 02/22] spl: Tidy up the header includes
Date: Sat, 10 May 2025 15:42:00 +0200
Message-ID: <20250510154214.v4.2.Ie563607416a8f7504c69b46ce608c1c1df75caa6@changeid>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250510134253.1581164-1-sjg@chromium.org>
References: <20250510134253.1581164-1-sjg@chromium.org>
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

