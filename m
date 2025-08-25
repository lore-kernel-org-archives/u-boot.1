Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4601CA0FE7
	for <u-boot@archiver.kernel.org>; Mon, 25 Aug 2025 13:56:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 625A7831BE;
	Mon, 25 Aug 2025 15:55:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=fris.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=fris.de header.i=@fris.de header.b="C2RZYsry";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2871B831BB; Mon, 25 Aug 2025 15:55:48 +0200 (CEST)
Received: from mail.fris.de (mail.fris.de [IPv6:2a01:4f8:c2c:390b::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4EF1083043
 for <u-boot@lists.denx.de>; Mon, 25 Aug 2025 15:55:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=fris.de
Authentication-Results: phobos.denx.de; spf=fail smtp.mailfrom=frieder@fris.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id E7542C994A; Mon, 25 Aug 2025 15:55:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fris.de; s=dkim;
 t=1756130146; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding:in-reply-to:references;
 bh=kOlALI8yBXvzlXXSyNpbK5LMiEnMb2HuOMLysukWt58=;
 b=C2RZYsry6fZJW90TvGL9XVe/21OCQFwkq/DbQ8ICQF0nvsfik2gxIvaTRHT2ykREcG0xy3
 W8XDkWurxRKShuWaYaECJso40/MbSDOgOE7QPf+fA7mJZfElID0Eyqsqy4DAiWi8vla4zv
 QtIwLV47aW9MjgCwqSCDUKxWpkdxngrr1raF+swrGCVic2zWC79u4D4DaPiRD/miRVrvi3
 5u1qPY0LZrUMCFjZj3ya2nIQBT8kf8CNzjiwpIrSWH9L4H/R+pC2bLVMkKBzECigEUssa+
 DZuoHCXX0VyaeW2dOU6pBDWUBuscjdBfBrQL5f5sr98O3JctM/WnCeohXJjxlQ==
From: Frieder Schrempf <frieder@fris.de>
To: Frieder Schrempf <frieder.schrempf@kontron.de>,
 Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
Cc: Annette Kobou <annette.kobou@kontron.de>,
 Eberhard Stoll <eberhard.stoll@kontron.de>
Subject: [PATCH 07/11] imx: kontron-sl-mx6ul: Autostart fastboot if booted
 from USB
Date: Mon, 25 Aug 2025 15:54:31 +0200
Message-ID: <20250825135504.193004-8-frieder@fris.de>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250825135504.193004-1-frieder@fris.de>
References: <20250825135504.193004-1-frieder@fris.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
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

From: Annette Kobou <annette.kobou@kontron.de>

For booting via USB we want to automatically start the fastboot
command in order to access the board via uuu or other tools.

This allows for easier bringup of new boards during development
and manufacturing.

Signed-off-by: Annette Kobou <annette.kobou@kontron.de>
Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
---
 board/kontron/sl-mx6ul/sl-mx6ul.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/board/kontron/sl-mx6ul/sl-mx6ul.c b/board/kontron/sl-mx6ul/sl-mx6ul.c
index 16d89c64d61..e33907ee124 100644
--- a/board/kontron/sl-mx6ul/sl-mx6ul.c
+++ b/board/kontron/sl-mx6ul/sl-mx6ul.c
@@ -5,7 +5,9 @@
 
 #include <asm/arch/clock.h>
 #include <asm/arch/sys_proto.h>
+#include <asm/arch-mx6/imx-regs.h>
 #include <asm/global_data.h>
+#include <env.h>
 #include <env_internal.h>
 #include <fdt_support.h>
 #include <phy.h>
@@ -87,6 +89,16 @@ int board_init(void)
 	return 0;
 }
 
+int board_late_init(void)
+{
+	if (is_boot_from_usb()) {
+		env_set("bootdelay", "0");
+		env_set("bootcmd", "fastboot 0");
+	}
+
+	return 0;
+}
+
 enum env_location env_get_location(enum env_operation op, int prio)
 {
 	if (prio)
-- 
2.50.1

