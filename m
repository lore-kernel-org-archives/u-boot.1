Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29E09CCD18D
	for <u-boot@archiver.kernel.org>; Mon, 13 Oct 2025 13:33:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B03F38391C;
	Mon, 13 Oct 2025 15:32:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="JicJULBt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9874A838F3; Mon, 13 Oct 2025 15:32:48 +0200 (CEST)
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AF549837E4
 for <u-boot@lists.denx.de>; Mon, 13 Oct 2025 15:32:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kory.maincent@bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-04.galae.net (Postfix) with ESMTPS id 76C05C093AF;
 Mon, 13 Oct 2025 13:32:27 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 68A5E606C6;
 Mon, 13 Oct 2025 13:32:46 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id CA9EA102F2269; 
 Mon, 13 Oct 2025 15:32:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1760362365; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=IgSOfQmYPj7B0+sV3jPLR63TQH6mGgB7YqtnRgoy9PE=;
 b=JicJULBtmsrnYoziAKuONzcQOxWBcZ6Adn2fN+xz+87y+nOEkqVlXrqh8zazV050B3brv+
 oHeRwq+e/pQHCNGUG+lVSuPH1LqOl3k/3PJxuPZOR7MCCnPTH+/eXoaNxHQSzEhRDuk1M9
 tJnkZz1jRc7MryPgOSde2o9NERauNKWIE346KLvFnNzV6dwTnEKLQxq2ir4IOiKC3hoe7f
 zBSKTbtnWmTH7Q4Szgw6pkJ9oUcXRhYbkZOfj0JHIw6svACQzsbEtgrjcJKRfkMnNh5zPO
 PTiECTa4/E11WDN8J4yQ8N7MbsY1PHNKK5B6XXc/HEdxPDz7a6xWbqDI/HSSLw==
From: "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>
Date: Mon, 13 Oct 2025 15:32:28 +0200
Subject: [PATCH v3 03/20] board: ti: Fix CAPE_EEPROM_BUS_NUM Kconfig dependency
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251013-feature_sysboot_extension_board-v3-3-04067b7422a5@bootlin.com>
References: <20251013-feature_sysboot_extension_board-v3-0-04067b7422a5@bootlin.com>
In-Reply-To: <20251013-feature_sysboot_extension_board-v3-0-04067b7422a5@bootlin.com>
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Jagan Teki <jagan@amarulasolutions.com>, 
 Andre Przywara <andre.przywara@arm.com>, 
 Hans de Goede <hdegoede@redhat.com>, Mario Six <mario.six@gdsys.cc>, 
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, 
 "Ying-Chun Liu (PaulLiu)" <paul.liu@linaro.org>
Cc: Roger Quadros <rogerq@kernel.org>, Bajjuri Praneeth <praneeth@ti.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, u-boot@lists.denx.de, 
 "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>
X-Mailer: b4 0.15-dev-8cb71
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

The CAPE_EEPROM_BUS_NUM configuration option was incorrectly depending
on CMD_EXTENSION, which represents the extension board command. However,
the cape scan functionality can be built and used independently of the
command interface through the SUPPORT_EXTENSION_SCAN option.

Change the dependency from CMD_EXTENSION to SUPPORT_EXTENSION_SCAN to
properly reflect that the I2C bus configuration is needed for the cape
scan function itself, not specifically for the command.

Signed-off-by: Kory Maincent (TI.com) <kory.maincent@bootlin.com>
---

Change in v3:
- New patch
---
 board/ti/common/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/board/ti/common/Kconfig b/board/ti/common/Kconfig
index f481812247c..9512c5c23f1 100644
--- a/board/ti/common/Kconfig
+++ b/board/ti/common/Kconfig
@@ -20,7 +20,7 @@ config CAPE_EEPROM_BUS_NUM
 	int "Cape EEPROM's I2C bus address"
 	range 0 8
 	default 2
-	depends on CMD_EXTENSION
+	depends on SUPPORT_EXTENSION_SCAN
 
 config TI_COMMON_CMD_OPTIONS
 	bool "Enable cmd options on TI platforms"

-- 
2.43.0

