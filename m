Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F4CCC7115C
	for <u-boot@archiver.kernel.org>; Thu, 29 Aug 2024 01:22:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8C144886F9;
	Thu, 29 Aug 2024 03:22:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="uZ7cGDV3";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="K9PK+AqK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C513C8891E; Thu, 29 Aug 2024 03:22:29 +0200 (CEST)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org
 [IPv6:2001:67c:2050:0:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AF285879C1
 for <u-boot@lists.denx.de>; Thu, 29 Aug 2024 03:22:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4WvNmz2nfMz9slm;
 Thu, 29 Aug 2024 03:22:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1724894547;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=MH067EdUGU9ZbqBlt0v0JlCKF0xu1ucR+9XB7lgjIrQ=;
 b=uZ7cGDV3z/UYvgB1nbfNoKb6P0gU+RBmxV3erJFq6N0s1/sW0LlwiWir9ODVh0T7qtQZi9
 sXmdYBLh1+p5FkpuAIkuOsjI4Kflt/ZTrA6CBYRwQTwVtWaNhwBkFBcWL3N1BX/DDUHk3M
 qqqqJBuls9+PUYPIdOy6E+MA8YqCB/SbU1PKy/zfLNYoeKcmj7Igr10+coBD88jzKmcorN
 6ba5rWef+4v9xttOMM+a0KMtqqVlSGD3xOLNvD+c+6qg9OD3wtjr7nG7XerPv2dtZZroMQ
 fjZFuXyAQBVcM2ScrmpQvyTG0r4TlZ28eXx0w0c+OaIIQ15BLfv/yVWvnF63Pw==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1724894545;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=MH067EdUGU9ZbqBlt0v0JlCKF0xu1ucR+9XB7lgjIrQ=;
 b=K9PK+AqKsve6A6u6Rx4zLG7IIixsnbRWxztg61CMzCiAzTSaFT8sR03d/jBpMARcDGsXgg
 meucxZ74F7y3om6Xagie/JBsfZbPji505Xxxo0gy26WL27m2I51Ho479PrjwSAWAlklTOP
 h8llXDwW61GfY9+2fb8zzLxYtiGSuKP5szbugQQI12j1NQ1/KNLijycMXFcL2JsuIYV9b4
 c/9eqMC9TzV5F7qkB1xBpZvkkXJAh8yPilDPUXQkYNcZ0ce+SLp8mn318rVUmCoVifSs9r
 PQfvNNycbfD4UJn6VW107VKuX7J4GxAJskitieJhjN1Ll/EHrffdH31TdmYa5A==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Francis Laniel <francis.laniel@amarulasolutions.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Michal Simek <michal.simek@amd.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH] mmc: Hide mmc speed command under mmc command
Date: Thu, 29 Aug 2024 03:22:01 +0200
Message-ID: <20240829012210.179436-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 34a38e42fd3bb7cbcf0
X-MBO-RS-META: dbr7yba4kncxeywym85a79erikwweahs
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

The mmc speed command configuration option keeps showing up in
Kconfig even if CMD_MMC is not set. Move MMC_SPEED_MODE_SET under
CMD_MMC to show up the Kconfig option only if MMC command is enabled.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: AKASHI Takahiro <akashi.tkhro@gmail.com>
Cc: Francis Laniel <francis.laniel@amarulasolutions.com>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Mattijs Korpershoek <mkorpershoek@baylibre.com>
Cc: Michal Simek <michal.simek@amd.com>
Cc: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
 cmd/Kconfig | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/cmd/Kconfig b/cmd/Kconfig
index 978f44eda42..efe2357d044 100644
--- a/cmd/Kconfig
+++ b/cmd/Kconfig
@@ -1399,6 +1399,15 @@ config CMD_MMC_SWRITE
 	  Enable support for the "mmc swrite" command to write Android sparse
 	  images to eMMC.
 
+config MMC_SPEED_MODE_SET
+	bool "set speed mode using mmc command"
+	help
+	  Enable setting speed mode using mmc rescan and mmc dev commands.
+	  The speed mode is provided as the last argument in these commands
+	  and is indicated using the index from enum bus_mode in
+	  include/mmc.h. A speed mode can be set only if it has already
+	  been enabled in the device tree.
+
 endif
 
 config CMD_CLONE
@@ -2963,16 +2972,6 @@ config CMD_UBIFS
 	help
 	  UBIFS is a file system for flash devices which works on top of UBI.
 
-config MMC_SPEED_MODE_SET
-	bool "set speed mode using mmc command"
-	depends on CMD_MMC
-	help
-	  Enable setting speed mode using mmc rescan and mmc dev commands.
-	  The speed mode is provided as the last argument in these commands
-	  and is indicated using the index from enum bus_mode in
-	  include/mmc.h. A speed mode can be set only if it has already
-	  been enabled in the device tree.
-
 config CMD_MESON
 	bool "Amlogic Meson commands"
 	depends on ARCH_MESON
-- 
2.45.2

