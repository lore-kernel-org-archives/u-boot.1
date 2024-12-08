Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA8C0E7717F
	for <u-boot@archiver.kernel.org>; Sun,  8 Dec 2024 22:07:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 29E84895B1;
	Sun,  8 Dec 2024 23:06:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="GWNh5PCp";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="dn2VE7Ss";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5FBB989541; Sun,  8 Dec 2024 23:06:28 +0100 (CET)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 180158954F
 for <u-boot@lists.denx.de>; Sun,  8 Dec 2024 23:06:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4Y5zbj6Gnrz9skk;
 Sun,  8 Dec 2024 23:06:25 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1733695585;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ocOqLmMJ/2txrCDIjHPO58KB4ChNdCIaDzrkT16KrJY=;
 b=GWNh5PCpYEGUtN0I2EGd6q9aOGmTnxu0fDEpKuVa2sia5sE66OdhNuVhFOTyJO6ZEixJSe
 tBKriiiey25eZECU8Aq8PxSqnDeK0ES6ZbN00o7L3OyY5VEzkR8cXYCoennV84S7RSnvsa
 IepL6uDFGELiEdp9eydN6541vBS3uZ4ZuFi4EEZWKyXc9xu/s/rQacbEsNVjY+FLWrjCm6
 46W7GuiI2scwrxykwBEcMjtXK6tZhRFuZA4VHo+fnuZGD67xWEhnDzhiTXyg0PfUM60Pm8
 6q7dSRe/U81zg53+W13jpmwKSSnMDnK24CdMHjf1aFvDth5+1az18gKb1ImQSg==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1733695584;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ocOqLmMJ/2txrCDIjHPO58KB4ChNdCIaDzrkT16KrJY=;
 b=dn2VE7SsAXuvIXMopv3kAuRxad5iwt5ygZynReQw30A+FhNbEBaYGdJxYMBbP9goCaXS9C
 CqViPlzHpSWoIW65wqCT6l5Qb2sy8VX7nDETPFuPm07q7ORactVd2vabVT74AXcGJ6C/An
 o1wYp1Ea/eG1bTUft/P8gkxXdZfbOuWubd2ulbiFvIjELOWqPCuOZtDQjMsUtYd6VkR19W
 zS+hzVqZNwCvO6sZjX73bpvHv46w5ktnWGqIH0l0idhE2aDZ/Cl540aMVTkGU2SEnEuNNt
 00AX6Uvmq8d3RpHzvXG2aFBtfJu6lyRE+ubA7d7g53szbW9Gd0c08WZwYKGz6A==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 08/13] pci: renesas: Fix R-Car spelling
Date: Sun,  8 Dec 2024 23:04:01 +0100
Message-ID: <20241208220551.204743-8-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20241208220551.204743-1-marek.vasut+renesas@mailbox.org>
References: <20241208220551.204743-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: zxpfsaiwodu5gg7arpribtty73iizkzn
X-MBO-RS-ID: 291aaa9174fa3569289
X-Rspamd-Queue-Id: 4Y5zbj6Gnrz9skk
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

