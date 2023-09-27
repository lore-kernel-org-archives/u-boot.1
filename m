Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41D60E80AB0
	for <u-boot@archiver.kernel.org>; Wed, 27 Sep 2023 14:24:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7461A801B6;
	Wed, 27 Sep 2023 16:24:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="H5Fv3b4w";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6617486E1B; Wed, 27 Sep 2023 16:24:43 +0200 (CEST)
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com
 [IPv6:2607:f8b0:4864:20::d31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5A0CB801B6
 for <u-boot@lists.denx.de>; Wed, 27 Sep 2023 16:24:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd31.google.com with SMTP id
 ca18e2360f4ac-79f989480e0so352093139f.3
 for <u-boot@lists.denx.de>; Wed, 27 Sep 2023 07:24:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1695824680; x=1696429480; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=7yrPC60cOl+7g9HqiTDEqb2gZe4FQJu7rxyBR/PHPeo=;
 b=H5Fv3b4wEFTzQZv1wtg9DMFIa7Q6WqVj5aAxR87OduKnQAfw7bOzTX7KS355U3ZImM
 8L8jta+FZ+qkQyqCMliWHEE3cem5t4lxfvVsv8wBrc+NKl1SWxfg6Ylthui0as1bVWSy
 gtYgKMTS9ud478T8mtfxfySOSzHlNMuZsRyMg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695824680; x=1696429480;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=7yrPC60cOl+7g9HqiTDEqb2gZe4FQJu7rxyBR/PHPeo=;
 b=OcWTEMNqc9fRy8Xc9a28aa7patptoFTAtKuWx9tme0Yv+oX7HN5v02ohKmpsXiwOfU
 +3jAht3PdMfKxVBkCsrVtyjXLncs3+L9NELzkAeJn/X883w0RgL77o+kB6JDMdvTLSoD
 /5Uv01uSXx5mj7KvSPQzTfbA3wbT8WLCWA7h0De4FuvAaaCO62WxQnKB4RnUQ/siD8xC
 gw6ET759Sk/ZEmbcK/a17mMLLl/zK6KiVQ3AaX1SbPwJKPng+dFEmbs3av6yC8lic5Yf
 wdWHvfOmCbmWESC0iChNXJwIilx37tyFcY9SOULqWXvGeC29jod8ZEqV1furcaZuCCa/
 YFwg==
X-Gm-Message-State: AOJu0Yz0+KzmubkW1ye10kSijr/81vcurf6cstC2IXJ0IqRSaKeH3J0E
 hJLBy8hr1wWA/1j9IpBu9oBVDioB7WmQYpThS9w=
X-Google-Smtp-Source: AGHT+IFGkC3Q+BABUUc3jt11NZSXh0R4gcboRujM7BpqdeiiTPuOR6S0niOTpp564V9IEKjPcFZNnQ==
X-Received: by 2002:a6b:d801:0:b0:787:1555:efca with SMTP id
 y1-20020a6bd801000000b007871555efcamr2107078iob.5.1695824679911; 
 Wed, 27 Sep 2023 07:24:39 -0700 (PDT)
Received: from kea.bld.corp.google.com ([2620:15c:183:200:1da0:a3ce:7aae:e9fa])
 by smtp.gmail.com with ESMTPSA id
 f20-20020a02b794000000b0043a0d66a80csm4097091jam.24.2023.09.27.07.24.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 Sep 2023 07:24:39 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Marek Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>,
 Evgeny Bachinin <EABachinin@sberdevices.ru>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Safae Ouajih <souajih@baylibre.com>
Subject: [PATCH v5 39/43] command: Include a required header in command.h
Date: Wed, 27 Sep 2023 08:22:37 -0600
Message-ID: <20230927142359.2965941-40-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.515.g380fc7ccd1-goog
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

This uses ARRAY_SIZE() but does not include the header file which declares
it. Fix this, so that command.h can be included without common.h

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v5:
- Adjust so this builds on azure

 boot/bootm.c      | 2 +-
 include/command.h | 4 ++++
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/boot/bootm.c b/boot/bootm.c
index b1c3afe0a3a..8f96a80d425 100644
--- a/boot/bootm.c
+++ b/boot/bootm.c
@@ -8,6 +8,7 @@
 #include <common.h>
 #include <bootstage.h>
 #include <cli.h>
+#include <command.h>
 #include <cpu_func.h>
 #include <env.h>
 #include <errno.h>
@@ -29,7 +30,6 @@
 #include "mkimage.h"
 #endif
 
-#include <command.h>
 #include <bootm.h>
 #include <image.h>
 
diff --git a/include/command.h b/include/command.h
index ae7bb4a30b0..34ea989b39b 100644
--- a/include/command.h
+++ b/include/command.h
@@ -25,6 +25,10 @@
 #endif
 
 #ifndef	__ASSEMBLY__
+
+/* For ARRAY_SIZE() */
+#include <linux/kernel.h>
+
 /*
  * Monitor Command Table
  */
-- 
2.42.0.515.g380fc7ccd1-goog

