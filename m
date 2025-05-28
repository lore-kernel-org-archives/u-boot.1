Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C91EC5AD49
	for <u-boot@archiver.kernel.org>; Wed, 28 May 2025 12:33:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 333B183986;
	Wed, 28 May 2025 14:33:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="NZl3AsU2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0A84B838E6; Wed, 28 May 2025 14:33:23 +0200 (CEST)
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com
 [IPv6:2607:f8b0:4864:20::d31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AE9A4839CB
 for <u-boot@lists.denx.de>; Wed, 28 May 2025 14:33:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd31.google.com with SMTP id
 ca18e2360f4ac-85b3f92c8f8so98108639f.1
 for <u-boot@lists.denx.de>; Wed, 28 May 2025 05:33:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1748435598; x=1749040398; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=c9Tg36wpyIEyDVR+dvJTZ69Gd+LwO5lR+RPbWuW8b2w=;
 b=NZl3AsU2AJPAmXwoWt2xuFAMA4C2BmWKiLBqO3DujenDkqj322SXMTwjYU+qAHP8av
 YIHyTfNir4KQx8sggUdz9u7ivuTj03iIrSbKpOHt9zOiGv9e/RYrCXhi+9c2QurkRA6K
 Vm1yOZNJHpSbaq0jl/6YE1FnKP7shU04DUfKs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748435598; x=1749040398;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=c9Tg36wpyIEyDVR+dvJTZ69Gd+LwO5lR+RPbWuW8b2w=;
 b=LjgzNJItk8B7NGpG/BnNb6chsviA0HiZM3gHVn5UbIwiQ5pYQnAWhN6Lek/lVO1Eqk
 +wIuC16M73zlUutLrThAR8B9J/apM8x27BLQpJfNrF2gWnebKeyeKiUGVvm2oBorq2BS
 +FmYEr1j4jadbFC2Lsge1lA/0ONQzkmQRIkpjlqK9q4YILMOB5c2fcUohkzQYiHoptFW
 I5tToewKnbWU8mewiTTQDNMOJrKVrVQJMJ6mDaRktpTIqWFe2xTsKQ/BAp1VNnXUctYe
 r1SANDcNCFlp6rfwCaV73KDoaQE1DVL9wG8m6SqDXrG7KmLU14VFoarhMTG1+AP3nDi6
 ZpSg==
X-Gm-Message-State: AOJu0Yz8xIZMlHX+TXXiDlfaXBnDT5AxpgBTrTjipq12ePjifpUb7u5p
 tFFNh+7ikOlZi9txSGqVzrKxkyTNI296SJorSIOq/Yqe3EMcudJr7Gn0Vpe1n6h7Z+JnxvYMiUi
 EPI35B9N+
X-Gm-Gg: ASbGncuKYlGEsB4dlbIKTXcQsBUJrLMzJ5iXhfJiewIPYgEmncSN2/GaKCNuexQbeC+
 anplfhmy+8uuQ2jwyEIFU+QICLt2jC+0PY3QAk8FhZz0ANAL47fiCxXJ7Z5GJNfLlxF5yuD6cJ0
 KyWy3JUHPv//53OVf25irhMBNGCToEMr8xMRQq/5bmbElBg1CHYsYUPm3mH4mHNFIqFUFqQILh1
 SYiywblKSwH6oQ7vulyLRKr/5iHnCjwsFcpj/HJFro5nwkuCYCE77X7gMH+3FTWMaTsPg7Vs1JL
 ZOdAbYC6R2F3CGJ1bptIJHd7jbPekdiLv4sbz9jxdeRl3vSNAhjS3Ho7+2HNobsWLJn5C4t0f0V
 KvAq/0FULqw4V
X-Google-Smtp-Source: AGHT+IFwFbzwEQNja2nqslMggtMktRubeXhZ8Q6Jm/MiOWskqMyEFYmJVGYBS+DBmAtbP2YN29XOfg==
X-Received: by 2002:a6b:6b01:0:b0:86c:bbd8:3fc with SMTP id
 ca18e2360f4ac-86cbbd8049dmr1313209939f.0.1748435598400; 
 Wed, 28 May 2025 05:33:18 -0700 (PDT)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4fdbd4bb408sm205972173.58.2025.05.28.05.33.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 May 2025 05:33:17 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: =?UTF-8?q?Fran=C3=A7ois=20Ozog?= <francois.ozog@linaro.org>,
 Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Bill Mills <bill.mills@linaro.org>, Raymond Mao <raymond.mao@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Andrew Phelps <andrew.phelps@canonical.com>,
 Simon Glass <sjg@chromium.org>, Quentin Schulz <quentin.schulz@cherry.de>,
 Sean Anderson <seanga2@gmail.com>, Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: [PATCH v5 04/25] spl: Tidy up the header includes
Date: Wed, 28 May 2025 06:32:06 -0600
Message-ID: <20250528063224.v5.4.Ie563607416a8f7504c69b46ce608c1c1df75caa6@changeid>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250528123236.1138632-1-sjg@chromium.org>
References: <20250528123236.1138632-1-sjg@chromium.org>
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

