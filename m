Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BBF1C02182
	for <u-boot@archiver.kernel.org>; Tue, 21 Jan 2025 15:39:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 72C1D801FB;
	Tue, 21 Jan 2025 16:39:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="a9huT5FP";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="p5ijgv8H";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 52592801F5; Tue, 21 Jan 2025 16:39:02 +0100 (CET)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org
 [IPv6:2001:67c:2050:0:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5BCF080283
 for <u-boot@lists.denx.de>; Tue, 21 Jan 2025 16:38:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4YcrwK5nwFz9sb9;
 Tue, 21 Jan 2025 16:38:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1737473937;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=QP6cyzNqWyI5XQ0XkWkrY9YOlWAQ9zlFyjFvXOssbyU=;
 b=a9huT5FP61wMOL4WKqgwHEJ0jEDcjvT8lCXIB9mdOhQF3b8iTGoX/Q/FCaAkZW3hl2NolP
 0bsaWv8pxOfehXqQR7vdjvIp5EeUAoL1CiMCInWJ33wtYHkRYE7hJe0V5UtiE3MSnq3wEI
 sWX87B/lRrxbguoKRe3WHemnflY0URttPQa6iwTB/xNAQSXazCQCgjhEb4TPm9CnAZCwfz
 jrPyXS+mI2DEzfu0OILtJds8EMJwuJtlCNecWAV/ZN61WvaN0U4udzO1yxQXNvXeF87mQY
 cTiMq39AI5n6mdpRTcG5E8msdtmUuO6E3ZlZTyGuhYBF2D9Jl2iMunhWhPNK+Q==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1737473935;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=QP6cyzNqWyI5XQ0XkWkrY9YOlWAQ9zlFyjFvXOssbyU=;
 b=p5ijgv8HDJcqJXcyal7THgEWAy8N4V58TICk0rHF1xuuiHIBmwZ/yC19FAQPPcHW67E6j9
 EX/O1IDnUKuqitza50HKrKnNWnHNmoKHg0LN9hICD5xonkqeXrt0E/N8jNdbiryTWWQHZL
 rT4qvLPe+hHyHslhJfYdqwdg4ic7nmtyS2YYdLfDbVhT2HaAJHTygtoaNmY+PU2/Eos7mY
 TRdycTW8UTyuj7k8dlcoeZrHVEeZ/vG17dJ5ld+uI8toeOOgFT1GKbYsCARldBEcIKgcjF
 Ocz3h41JcEVRxS3GmO6Hdk97wJDcu9NyVZlOJZD6SIjwOJ2PWAlCyYkf/ZTIJw==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Anurag Dutta <a-dutta@ti.com>,
 Christoph Niedermaier <cniedermaier@dh-electronics.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Hiago De Franco <hiago.franco@toradex.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Michal Simek <michal.simek@amd.com>, Peter Robinson <pbrobinson@gmail.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, Tom Rini <trini@konsulko.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
Subject: [PATCH] treewide: Replace Maximumm with Maximum in Kconfig symbol
 description
Date: Tue, 21 Jan 2025 16:36:11 +0100
Message-ID: <20250121153836.83878-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 57e2951c22fac7d7692
X-MBO-RS-META: 4zhdqa6anu1u4ai5gnmcq6ho99hazrxn
X-Rspamd-Queue-Id: 4YcrwK5nwFz9sb9
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

Replace Maximumm with Maximum in Kconfig symbol description, fix a typo.
No functional change.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Anurag Dutta <a-dutta@ti.com>
Cc: Christoph Niedermaier <cniedermaier@dh-electronics.com>
Cc: Francesco Dolcini <francesco.dolcini@toradex.com>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Hiago De Franco <hiago.franco@toradex.com>
Cc: Joe Hershberger <joe.hershberger@ni.com>
Cc: Michael Trimarchi <michael@amarulasolutions.com>
Cc: Michal Simek <michal.simek@amd.com>
Cc: Peter Robinson <pbrobinson@gmail.com>
Cc: Quentin Schulz <quentin.schulz@cherry.de>
Cc: Tom Rini <trini@konsulko.com>
Cc: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
Cc: u-boot@lists.denx.de
---
 drivers/block/Kconfig | 2 +-
 drivers/mtd/Kconfig   | 2 +-
 env/Kconfig           | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/block/Kconfig b/drivers/block/Kconfig
index cc75bad02b8..750b0bd2082 100644
--- a/drivers/block/Kconfig
+++ b/drivers/block/Kconfig
@@ -147,7 +147,7 @@ config IDE
 if IDE
 
 config SYS_IDE_MAXBUS
-	hex "Maximumm number of IDE buses"
+	hex "Maximum number of IDE buses"
 	default 2
 	help
 	  This is the number of IDE buses provided by the board. Each one
diff --git a/drivers/mtd/Kconfig b/drivers/mtd/Kconfig
index 185e8346213..2b7f5e5ed7b 100644
--- a/drivers/mtd/Kconfig
+++ b/drivers/mtd/Kconfig
@@ -216,7 +216,7 @@ config STM32_FLASH
 	 STM32 MCU.
 
 config SYS_MAX_FLASH_SECT
-	int "Maximumm number of sectors on a flash chip"
+	int "Maximum number of sectors on a flash chip"
 	depends on MTD_NOR_FLASH || FLASH_CFI_DRIVER
 	default 512
 
diff --git a/env/Kconfig b/env/Kconfig
index aaf0b1fe9ac..4438f0b392c 100644
--- a/env/Kconfig
+++ b/env/Kconfig
@@ -60,7 +60,7 @@ config ENV_MIN_ENTRIES
 	  to store the environment settings.
 
 config ENV_MAX_ENTRIES
-	int "Maximumm number of entries in the environment hashtable"
+	int "Maximum number of entries in the environment hashtable"
 	default 512
 	help
 	  Maximum number of entries in the hash table that is used internally
-- 
2.45.2

