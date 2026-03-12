Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62ADBFED2FE
	for <u-boot@archiver.kernel.org>; Thu, 12 Mar 2026 09:58:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B8E41841D2;
	Thu, 12 Mar 2026 10:57:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=ew.tq-group.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="ipS0tyhW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3633383F53; Thu, 12 Mar 2026 10:57:43 +0100 (CET)
Received: from www537.your-server.de (www537.your-server.de [188.40.3.216])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7267C84181
 for <u-boot@lists.denx.de>; Thu, 12 Mar 2026 10:57:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=ew.tq-group.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Max.Merchel@ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ew.tq-group.com; s=default2602; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
 bh=X3ooqwkzU4gAt8+eW7eqj7Oj/Uim20K+d0oABPE5z+Y=; b=ipS0tyhW3v4xFKFvzyd1OtWm0C
 TWpjyXRQrG0ZxuutWhjoF7hEk5JfAg3SU1PqaVWIIFJ+S1NFqfd14k/d3Tu2DvwBOaASt0jKFrHDE
 iVCcDXr7HARQkVFbzuMp+PtRrebl7iA5JCSK/uVEEQROlKv9B138Zo7GnW4QRvwar0gr3XGtWlBEs
 wog9RvJQOD5DM7ddrxpNE4xbzRhNZgpFYj2hu7cW1B/aWMS7sq39CoLubmgY/W/84OLoM5BajWse9
 bIZjJWE5zQHG5Q0JmNsjZ4wmx6r47SoBebxW/bcKV1DNxVcpSGzOqCge2IYatKYm6Np/QmvEHxzpK
 lCgYGQPw==;
Received: from sslproxy07.your-server.de ([78.47.199.104])
 by www537.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96.2) (envelope-from <Max.Merchel@ew.tq-group.com>)
 id 1w0cnR-0007yd-2x; Thu, 12 Mar 2026 10:57:37 +0100
Received: from localhost ([127.0.0.1])
 by sslproxy07.your-server.de with esmtpsa (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96) (envelope-from <Max.Merchel@ew.tq-group.com>)
 id 1w0cnR-000Fyo-1w; Thu, 12 Mar 2026 10:57:37 +0100
From: Max Merchel <Max.Merchel@ew.tq-group.com>
To: Tom Rini <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>
Cc: Max Merchel <Max.Merchel@ew.tq-group.com>, u-boot@lists.denx.de,
 u-boot@ew.tq-group.com
Subject: [PATCH 07/13] configs: tqma6: change to include tqma6.h in baseboard
 headers
Date: Thu, 12 Mar 2026 10:57:03 +0100
Message-ID: <20260312095711.3219756-8-Max.Merchel@ew.tq-group.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260312095711.3219756-1-Max.Merchel@ew.tq-group.com>
References: <20260312095711.3219756-1-Max.Merchel@ew.tq-group.com>
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

The SoM (TQMa6) can be used on various baseboards. No modifications to
the SoM files should be required to use the SoM on different baseboards.
Therefore, the SoM headers are included by the baseboard.

Signed-off-by: Max Merchel <Max.Merchel@ew.tq-group.com>
---
 board/tq/tqma6/Kconfig       |  3 ++-
 include/configs/tqma6.h      | 13 -------------
 include/configs/tqma6_mba6.h |  2 ++
 include/configs/tqma6_wru4.h |  2 ++
 4 files changed, 6 insertions(+), 14 deletions(-)

diff --git a/board/tq/tqma6/Kconfig b/board/tq/tqma6/Kconfig
index e62228d73d0..9cb0c909aa9 100644
--- a/board/tq/tqma6/Kconfig
+++ b/board/tq/tqma6/Kconfig
@@ -7,7 +7,8 @@ config SYS_VENDOR
 	default "tq"
 
 config SYS_CONFIG_NAME
-	default "tqma6"
+	default "tqma6_mba6" if MBA6
+	default "tqma6_wru4" if WRU4
 
 choice
 	prompt "TQMa6 SoC variant"
diff --git a/include/configs/tqma6.h b/include/configs/tqma6.h
index 3c6678aa2b8..00610e76869 100644
--- a/include/configs/tqma6.h
+++ b/include/configs/tqma6.h
@@ -38,17 +38,4 @@
 #define TQMA6_SPI_UBOOT_START		0x400
 #define TQMA6_SPI_UBOOT_SIZE		0xc0000
 
-/*
- * All the defines above are for the TQMa6 SoM
- *
- * Now include the baseboard specific configuration
- */
-#ifdef CONFIG_MBA6
-#include "tqma6_mba6.h"
-#elif CONFIG_WRU4
-#include "tqma6_wru4.h"
-#else
-#error "No baseboard for the TQMa6 defined!"
-#endif
-
 #endif /* __TQMA6_CONFIG_H */
diff --git a/include/configs/tqma6_mba6.h b/include/configs/tqma6_mba6.h
index 81f96ac91e8..c30aeae4f29 100644
--- a/include/configs/tqma6_mba6.h
+++ b/include/configs/tqma6_mba6.h
@@ -11,6 +11,8 @@
 #ifndef __CONFIG_TQMA6_MBA6_H
 #define __CONFIG_TQMA6_MBA6_H
 
+#include "tqma6.h"
+
 #define CFG_MXC_UART_BASE		UART2_BASE
 
 #endif /* __CONFIG_TQMA6_MBA6_H */
diff --git a/include/configs/tqma6_wru4.h b/include/configs/tqma6_wru4.h
index 110bd895a8a..b35e471bd95 100644
--- a/include/configs/tqma6_wru4.h
+++ b/include/configs/tqma6_wru4.h
@@ -6,6 +6,8 @@
 #ifndef __CONFIG_TQMA6_WRU4_H
 #define __CONFIG_TQMA6_WRU4_H
 
+#include "tqma6.h"
+
 /* Ethernet */
 #define CFG_FEC_MXC_PHYADDR		0x01
 
-- 
2.43.0

