Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26D2EC3DA4B
	for <u-boot@archiver.kernel.org>; Mon, 15 Jul 2024 13:20:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 761098881F;
	Mon, 15 Jul 2024 15:20:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="fjJJltkW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5EE4D8881F; Mon, 15 Jul 2024 15:20:03 +0200 (CEST)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 49C3B87C68
 for <u-boot@lists.denx.de>; Mon, 15 Jul 2024 15:20:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 856273FE1B
 for <u-boot@lists.denx.de>; Mon, 15 Jul 2024 13:20:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1721049600;
 bh=TPGFl6yorYtrG01Enn3WjcNxH4ZOLWRja94tSazOc9Q=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=fjJJltkWf2aMumyxSLHOsRSwXQ26CWwYYKps1tKtytCCbnh8lVulO+oWiM1vu15d+
 Ke4Rp+057RTLJPmjrx03YeqmPEl7DXQdNtVbw96h/57D1JFaGlxx1r8WLudq/QoRvQ
 73PMSgFem494eGot5DQ8dXIJylIqcRjGfM8JMyI7VS1EXCK7dhoAI6N4AiDYLfrxte
 StIJBFbOiey0AwRNxXUk7wAv2gWbRFxmWW4d/JWV9FabyjlZQZp280i0HN1xvxfwbD
 +N/7rWxwZDNw0O70xDCT63rAasMFi8pR7NzUQ8ZSPZUVKh+lkVYjlKpKEGKtqGrMEN
 S4NzhIU4x0+Pw==
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-a77c8d7b120so363854866b.3
 for <u-boot@lists.denx.de>; Mon, 15 Jul 2024 06:20:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721049600; x=1721654400;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=TPGFl6yorYtrG01Enn3WjcNxH4ZOLWRja94tSazOc9Q=;
 b=hrYtglwJBKXsQAr2V0Suq1u1BD06Eu84DzeeYf1pOm12pLZYwiVcoKKiYMqE/qOSun
 Ut4fchugxVnWwM7n6S/0p+qJEtehWcJLfJu6oUB7q42BuUSb+SJA2YfgY/pvrQ8X8qmE
 yls36AjzZV1RlqcGs8VPn8sjg42XrpGkyFGA1wc7diXavpjGxvnltSQEOdzUVP08llxn
 x0J5LcQ/AGy9Brp+6vy7wqI9KIYUeZ2G5jgtUliCOVr2m2LoS6us15wgmfmMTORUE/2L
 n98RkidbtjoFotJ4ZGKlBOC+nn9ivIBM/GEq6oayoVZf4GjygMuDCJ91z3Sf5d51D/w0
 f6fg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWIx2HxT4If5xwF6UxPmQCSmWA1qLYxSFotfjG+GeKljmkB+Z48mEpuejDLPsp7gRjwBN1ywlra17CzkifJm/dBY3j7pQ==
X-Gm-Message-State: AOJu0YzH59Kz2eWRHDDDImsBQ6utd0GMFNxNJBqi+5RxwdsRYogpTen6
 EBCTvWkKQeafr48q2EMwLgz14KuWiWBiNVFXIblTP97tq7O++rqq0dXcXOYiz6NvP4zXTNP5DAi
 YeeEbKzn7QSZjMSOgcBVCK4iK1DTC17Hb6dJl9vE9j+cQDMG3ysLRMHHThk9f50TQBFo=
X-Received: by 2002:a17:906:4f06:b0:a77:d52d:5c5d with SMTP id
 a640c23a62f3a-a780b68a41cmr1158060566b.10.1721049600010; 
 Mon, 15 Jul 2024 06:20:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF37WxG57KBjXscsqgYQWXWC8QCP7BILQk5FD56sv/l1TqIZ6q6qE4cnQYspq/4OjwBX1cv6w==
X-Received: by 2002:a17:906:4f06:b0:a77:d52d:5c5d with SMTP id
 a640c23a62f3a-a780b68a41cmr1158059066b.10.1721049599568; 
 Mon, 15 Jul 2024 06:19:59 -0700 (PDT)
Received: from workstation5.fritz.box
 (ip-062-143-093-080.um16.pools.vodafone-ip.de. [62.143.93.80])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a79bc5a38d9sm210288566b.25.2024.07.15.06.19.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Jul 2024 06:19:59 -0700 (PDT)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 William Zhang <william.zhang@broadcom.com>,
 Rui Miguel Silva <rui.silva@linaro.org>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] drivers/mtd/nvmxip: nvmxip.h is a global include
Date: Mon, 15 Jul 2024 15:19:50 +0200
Message-ID: <20240715131950.180562-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.45.2
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

include/nvmxip.h is a global and not a local include.
So we should use angle brackets.

Fixes: dc3abd8006c5 ("nvmxip: move header to include")
Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 drivers/mtd/nvmxip/nvmxip-uclass.c | 2 +-
 drivers/mtd/nvmxip/nvmxip.c        | 2 +-
 drivers/mtd/nvmxip/nvmxip_qspi.c   | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/mtd/nvmxip/nvmxip-uclass.c b/drivers/mtd/nvmxip/nvmxip-uclass.c
index 95dfa58def1..254f04e0b99 100644
--- a/drivers/mtd/nvmxip/nvmxip-uclass.c
+++ b/drivers/mtd/nvmxip/nvmxip-uclass.c
@@ -8,11 +8,11 @@
 
 #include <dm.h>
 #include <log.h>
+#include <nvmxip.h>
 #if CONFIG_IS_ENABLED(SANDBOX64)
 #include <asm/test.h>
 #endif
 #include <linux/bitops.h>
-#include "nvmxip.h"
 
 /* LBA Macros */
 
diff --git a/drivers/mtd/nvmxip/nvmxip.c b/drivers/mtd/nvmxip/nvmxip.c
index 229938db380..594500f0c65 100644
--- a/drivers/mtd/nvmxip/nvmxip.c
+++ b/drivers/mtd/nvmxip/nvmxip.c
@@ -9,10 +9,10 @@
 #include <dm.h>
 #include <log.h>
 #include <mapmem.h>
+#include <nvmxip.h>
 #include <asm/io.h>
 #include <linux/bitops.h>
 #include <linux/errno.h>
-#include "nvmxip.h"
 
 /**
  * nvmxip_blk_read() - block device read operation
diff --git a/drivers/mtd/nvmxip/nvmxip_qspi.c b/drivers/mtd/nvmxip/nvmxip_qspi.c
index 460887c7da3..f14a822b5d5 100644
--- a/drivers/mtd/nvmxip/nvmxip_qspi.c
+++ b/drivers/mtd/nvmxip/nvmxip_qspi.c
@@ -8,8 +8,8 @@
 
 #include <dm.h>
 #include <fdt_support.h>
+#include <nvmxip.h>
 #include <linux/errno.h>
-#include "nvmxip.h"
 
 #include <asm/global_data.h>
 DECLARE_GLOBAL_DATA_PTR;
-- 
2.45.2

