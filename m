Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D73DCCD1BB
	for <u-boot@archiver.kernel.org>; Wed, 22 Oct 2025 15:20:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8E18C835FD;
	Wed, 22 Oct 2025 17:20:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="wbUoPPIN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C152E82B20; Wed, 22 Oct 2025 17:20:35 +0200 (CEST)
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E341280422
 for <u-boot@lists.denx.de>; Wed, 22 Oct 2025 17:20:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kory.maincent@bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id 8381C4E4127B;
 Wed, 22 Oct 2025 15:20:33 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 59F9C606DC;
 Wed, 22 Oct 2025 15:20:33 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 68E52102F2447; 
 Wed, 22 Oct 2025 17:20:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1761146431; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=IgSOfQmYPj7B0+sV3jPLR63TQH6mGgB7YqtnRgoy9PE=;
 b=wbUoPPINjOJScuqtt8rw3QTCmOMlLci4vAdVXJn53wjunPb2YebYwK2LPvush4Xb5sSA72
 nWtEaKMP9+KNIwK7T9i0avUb9ly2jcow387++anUDIpMDhVPCEHsz3QtwbyQeBOd4xgpIu
 o6bCDwklLYcBFH+RchSVknNxjwCNVvKedh7xNUyTIhA46Bz3HTS0QH9WaN33q8OVmaFl0g
 FyxAXpFKa9WlDbrHaOPWXKk4+nfdNB37IBr9HXJbH4EFWuOnGm5/Y0ARM3zdeV0BU7loBO
 1kwbwv2yHocpkzRXTXZUEYUTXBLgB8u2qmbX70KmEr1O2Qg7VxyyXdv+YniL3A==
From: "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>
Date: Wed, 22 Oct 2025 17:20:14 +0200
Subject: [PATCH v4 03/20] board: ti: Fix CAPE_EEPROM_BUS_NUM Kconfig dependency
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251022-feature_sysboot_extension_board-v4-3-d24b5ef7b468@bootlin.com>
References: <20251022-feature_sysboot_extension_board-v4-0-d24b5ef7b468@bootlin.com>
In-Reply-To: <20251022-feature_sysboot_extension_board-v4-0-d24b5ef7b468@bootlin.com>
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
X-Mailer: b4 0.15-dev-52d38
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

