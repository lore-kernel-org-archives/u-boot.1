Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38620C4332F
	for <u-boot@archiver.kernel.org>; Sat,  4 Nov 2023 18:40:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AA2B98703A;
	Sat,  4 Nov 2023 19:40:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="m+D5kts6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9C4618706C; Sat,  4 Nov 2023 19:40:53 +0100 (CET)
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AF5CE87060
 for <u-boot@lists.denx.de>; Sat,  4 Nov 2023 19:40:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.. (unknown [159.148.28.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id DF1B6416C7; 
 Sat,  4 Nov 2023 18:40:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1699123251;
 bh=177v1tddqavdoFil/deUeMPAK2wR4VJvtzQe+ajGidQ=;
 h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
 b=m+D5kts6MaPZawkk33+xZcbISDp4uJ4Am4QNYyl1b8m2u1fRZk7PqWxlFIFu4/zH8
 uSlBBuy6f0UdqY1IDFWB3R5UdcgHCjzSHxusBZeYNATPvEvZNA/Gm6PR18AQdZFHeq
 AKA0oA8VaUbA8GU0bZG0oSrZtfsrkFLVL0CTMXJ+67EC/Nw13bmYS5o5SYYKFCiQtG
 GPSWSdwTAZv1n5hDolSPECXjCkYO1DZ0l32jnQqy0tcVWrM3yYhrgpIpNUKjqlsBGK
 3vga8dq4/NDyc1fejkl5Eg96slDd1lECjV1ZPvI6k8g1QgawpS86EnZd+zMB1tnxWs
 mrnqIUDPT7PWA==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, Andre Przywara <andre.przywara@arm.com>,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] dm: Do not enable debug messages by default
Date: Sat,  4 Nov 2023 20:40:43 +0200
Message-Id: <20231104184043.12419-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.40.1
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

CONFIG_DM_WARN has a text indicating that these messages should only
provided when debugging. This implies that the setting must be default no.

We should still create debug messages.

Reported-by: Andre Przywara <andre.przywara@arm.com>
Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 drivers/core/Kconfig | 1 -
 include/dm/util.h    | 4 +---
 2 files changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/core/Kconfig b/drivers/core/Kconfig
index fe5c41d57e..737d4590d5 100644
--- a/drivers/core/Kconfig
+++ b/drivers/core/Kconfig
@@ -48,7 +48,6 @@ config VPL_DM
 config DM_WARN
 	bool "Enable warnings in driver model"
 	depends on DM
-	default y
 	help
 	  Enable this to see warnings related to driver model.
 
diff --git a/include/dm/util.h b/include/dm/util.h
index 89206cc496..95c3527a37 100644
--- a/include/dm/util.h
+++ b/include/dm/util.h
@@ -11,9 +11,7 @@ struct dm_stats;
 #if CONFIG_IS_ENABLED(DM_WARN)
 #define dm_warn(fmt...) log(LOGC_DM, LOGL_WARNING, ##fmt)
 #else
-static inline void dm_warn(const char *fmt, ...)
-{
-}
+#define dm_warn(fmt...) log(LOGC_DM, LOGL_DEBUG, ##fmt)
 #endif
 
 struct list_head;
-- 
2.40.1

