Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA99DD15DA5
	for <u-boot@archiver.kernel.org>; Mon, 21 Oct 2024 15:14:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6084688EAF;
	Mon, 21 Oct 2024 17:13:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="mR6yig1l";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3439188F24; Mon, 21 Oct 2024 17:13:41 +0200 (CEST)
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net
 [217.70.183.199])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 45BCA88EAE
 for <u-boot@lists.denx.de>; Mon, 21 Oct 2024 17:13:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=bastien.curutchet@bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPA id 8C6F6FF803;
 Mon, 21 Oct 2024 15:13:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
 t=1729523618;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RZQJibq++KLTKSnOMI4p5rsjUwMYs/KpII3u62qY2wA=;
 b=mR6yig1lpkj+cXZHiJMMs0eDlLCqzCCq5PlZVu4CdT2dLs+bkR+JlGMADF6plZp49fHZc8
 T5/q1ZKozBZZI7kPFJEG4AC+eRmyCD/aC/fl22dzEG4eQLogQ2965JFOprKWAcIoe7k2sh
 Hg7NyZYoLzFbDI3SrCoovhVkJinDJhUc18d6/UKdXzgnyxHxYF70D6vaw5XyAUh9JttlC1
 QyzqCyawXFAkKZDpxTGbASmpChy0TXY7XxYmPgbNmY8A8OXfe1nygKG0SN974S3XpouvY4
 3I4DuqxO2BaCK/d809X01XEy2HxPRFLmFfaeFnv5Z3XSFePY529ahe0y1igJIQ==
From: Bastien Curutchet <bastien.curutchet@bootlin.com>
To: Tom Rini <trini@konsulko.com>,
	Andrew Davis <afd@ti.com>
Cc: u-boot@lists.denx.de, Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Herve Codina <herve.codina@bootlin.com>,
 Christopher Cordahi <christophercordahi@nanometrics.ca>,
 Bastien Curutchet <bastien.curutchet@bootlin.com>
Subject: [PATCH 3/6] memory: ti-aemif: Add ARCH_DAVINCI to architectures that
 uses TI_AEMIF
Date: Mon, 21 Oct 2024 17:13:27 +0200
Message-ID: <20241021151330.1860929-4-bastien.curutchet@bootlin.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241021151330.1860929-1-bastien.curutchet@bootlin.com>
References: <20241021151330.1860929-1-bastien.curutchet@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: bastien.curutchet@bootlin.com
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

TI_AEMIF configuration doesn't depend on ARCH_DAVINCI while the AEMIF
controller is present in the DaVinci SoCs.

Add ARCH_DAVINCI to the potential users of the TI_AEMIF driver
Add <asm/io.h> to driver's includes to fix build issue on ARCH_DAVINCI

Signed-off-by: Bastien Curutchet <bastien.curutchet@bootlin.com>
---
 drivers/memory/Kconfig    | 2 +-
 drivers/memory/ti-aemif.c | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/memory/Kconfig b/drivers/memory/Kconfig
index d10edd2774..7c40f17698 100644
--- a/drivers/memory/Kconfig
+++ b/drivers/memory/Kconfig
@@ -39,7 +39,7 @@ config STM32_FMC2_EBI
 
 config TI_AEMIF
 	tristate "Texas Instruments AEMIF driver"
-	depends on ARCH_KEYSTONE
+	depends on ARCH_KEYSTONE || ARCH_DAVINCI
 	help
 	  This driver is for the AEMIF module available in Texas Instruments
 	  SoCs. AEMIF stands for Asynchronous External Memory Interface and
diff --git a/drivers/memory/ti-aemif.c b/drivers/memory/ti-aemif.c
index 8e7ddde970..82a9c8cf7b 100644
--- a/drivers/memory/ti-aemif.c
+++ b/drivers/memory/ti-aemif.c
@@ -7,6 +7,7 @@
  */
 
 #include <asm/arch/hardware.h>
+#include <asm/io.h>
 #include <asm/ti-common/ti-aemif.h>
 
 #define AEMIF_WAITCYCLE_CONFIG		(0x4)
-- 
2.47.0

