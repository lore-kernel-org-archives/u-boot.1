Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2A6EE77180
	for <u-boot@archiver.kernel.org>; Wed, 11 Dec 2024 07:33:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5C70D80315;
	Wed, 11 Dec 2024 08:32:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="Cdfu8kF6";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="W0dxq3Kg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 25D4E802D5; Wed, 11 Dec 2024 08:32:39 +0100 (CET)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org
 [IPv6:2001:67c:2050:0:465::103])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 326FE80214
 for <u-boot@lists.denx.de>; Wed, 11 Dec 2024 08:32:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4Y7S446ZjZz9ssn;
 Wed, 11 Dec 2024 08:32:36 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1733902356;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NWXU0Try4LBTEP/kSjB+Ss60Ef/QTXlYkF7dT8UZnWM=;
 b=Cdfu8kF6EUDOU/iSp544CMB0qaIwIbOlpn46urQxpuBRYZm4oNOTiUMWjASCDS+5bI18jc
 w9SYzsR+8YLkBalJHyKw/OjMZwvWLEGHCrlBYfSz8Z68nZJETYsy3Uc3OMBpzNRCWvIDYA
 JUL12z6qTPnkxhrKj8XWiKOtXc/LIkOQOkftJm0YYcKs4v3I7XmSuRjpE8XjC1/LiSq2Va
 qDIiHzlG3UgfPAUQ38mt6tjh+kp7R6gjd4+FLLRHaFxvxmx8ysz8YNsjVL52mQX2pMRbWZ
 NFzs32R/4S4SvYO2US8nvIkrGYECHEV6aV9j30ELJsg2zpkLA4UHzAZgXOvWMw==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1733902355;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NWXU0Try4LBTEP/kSjB+Ss60Ef/QTXlYkF7dT8UZnWM=;
 b=W0dxq3KgK3u2LwEuMmXXcw+NZ+4RFDCFPXthedB9jiSCTr99iQ7silOESWOn+Axy0CpRJ0
 X0w9qsuFuT/ze89U6MYXtK1yCUJJuVArBQ5ZCB8NwXKLXJzCzH7fAxkTcyMvv9Ppm+6hLf
 qqvdAxCrFl/47HFna6ZRmKY8FEze54SOkVW/96hqa6sR0btz1YO1dTam9QzFfoZe5jArbI
 XEaJ53j+fNoTIqBc9aJbalHsSTHixxAu+4+6z42XcmJvmiCtMTnMgtAP1SOcffVbiZ27JN
 OlG/7uFf0IfnZXE4xt+SE4b6xZbPcqfeh1gXBDZcsCIG10lt1xKNzkobD5D2gA==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 08/13] pci: renesas: Fix R-Car spelling
Date: Wed, 11 Dec 2024 08:30:32 +0100
Message-ID: <20241211073210.8087-8-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20241211073210.8087-1-marek.vasut+renesas@mailbox.org>
References: <20241211073210.8087-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: b433b69eb32ddf2c3ff
X-MBO-RS-META: bjo9xjjcmoo9kz9kz64so7wdo6919scp
X-Rspamd-Queue-Id: 4Y7S446ZjZz9ssn
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

The correct spelling is R-Car, including the dash, update the usage.
Kconfig strings and comment changes only, no functional change.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
V2: No change
---
 drivers/pci/Kconfig         | 8 ++++----
 drivers/pci/pci-rcar-gen2.c | 2 +-
 drivers/pci/pci-rcar-gen3.c | 2 +-
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
index 876a5fa57ee..41901433e8c 100644
--- a/drivers/pci/Kconfig
+++ b/drivers/pci/Kconfig
@@ -189,19 +189,19 @@ config PCI_MSC01
 	depends on TARGET_MALTA
 
 config PCI_RCAR_GEN2
-	bool "Renesas RCar Gen2 PCIe driver"
+	bool "Renesas R-Car Gen2 PCIe driver"
 	depends on RCAR_32
 	help
 	  Say Y here if you want to enable PCIe controller support on
-	  Renesas RCar Gen2 SoCs. The PCIe controller on RCar Gen2 is
+	  Renesas R-Car Gen2 SoCs. The PCIe controller on R-Car Gen2 is
 	  also used to access EHCI USB controller on the SoC.
 
 config PCI_RCAR_GEN3
-	bool "Renesas RCar Gen3 PCIe driver"
+	bool "Renesas R-Car Gen3 PCIe driver"
 	depends on RCAR_GEN3
 	help
 	  Say Y here if you want to enable PCIe controller support on
-	  Renesas RCar Gen3 SoCs.
+	  Renesas R-Car Gen3 SoCs.
 
 config PCI_SANDBOX
 	bool "Sandbox PCI support"
diff --git a/drivers/pci/pci-rcar-gen2.c b/drivers/pci/pci-rcar-gen2.c
index 12c31e74087..08d5c4fbb8b 100644
--- a/drivers/pci/pci-rcar-gen2.c
+++ b/drivers/pci/pci-rcar-gen2.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * Renesas RCar Gen2 PCIEC driver
+ * Renesas R-Car Gen2 PCIEC driver
  *
  * Copyright (C) 2018 Marek Vasut <marek.vasut@gmail.com>
  */
diff --git a/drivers/pci/pci-rcar-gen3.c b/drivers/pci/pci-rcar-gen3.c
index 76878246f1e..d4b4037ce19 100644
--- a/drivers/pci/pci-rcar-gen3.c
+++ b/drivers/pci/pci-rcar-gen3.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * Renesas RCar Gen3 PCIEC driver
+ * Renesas R-Car Gen3 PCIEC driver
  *
  * Copyright (C) 2018-2019 Marek Vasut <marek.vasut@gmail.com>
  *
-- 
2.45.2

