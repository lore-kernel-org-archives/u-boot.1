Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 589B8CCD184
	for <u-boot@archiver.kernel.org>; Thu,  9 Oct 2025 14:51:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1B31A84529;
	Thu,  9 Oct 2025 16:51:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="2PXMVYhe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1913884552; Thu,  9 Oct 2025 16:51:06 +0200 (CEST)
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DBF5384528
 for <u-boot@lists.denx.de>; Thu,  9 Oct 2025 16:51:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kory.maincent@bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id 894CE4E40FB1;
 Thu,  9 Oct 2025 14:51:03 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 5FF0A6062C;
 Thu,  9 Oct 2025 14:51:03 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id BC6D4102F21EA; 
 Thu,  9 Oct 2025 16:51:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1760021462; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=6YaBRH1HaDBXGrpsy7FAfCDgoLLu6N65RKzF3NGVWvg=;
 b=2PXMVYhelbBrgly1QxFQm3lJoBKwv1MhRalf1frqTO2i63Rm5r5r3EMYq4b5DkzwNK0CVF
 Z4wQJbuf6Xg0khu7gKdzyo3Q2G4qDPsl64UrYWLmje76LnZcMtSbTCHKYrsjXPecPA7uvG
 vr3Ec03w7lB3mvm3O6y4WJcP6pUn1lWAvgtqNpYOF7W6vRk8DlqTiddmNJyDhv56IcXneG
 dLJ4rY6o2zY/NgIYN2GLSzuAd7hyBkDsq8+Khcm56SZCuTACS6apaZRuHsXzkE4Vvar6QZ
 U6aEVJEBjK+SX9Q16pLYCKSKOh/aBOoMOdPZp/at+MC3rME8GeKrktPbbpB6jw==
From: "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>
Date: Thu, 09 Oct 2025 16:50:40 +0200
Subject: [PATCH v2 04/18] board: ti: Exclude cape detection from XPL builds
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251009-feature_sysboot_extension_board-v2-4-e09b39e54de5@bootlin.com>
References: <20251009-feature_sysboot_extension_board-v2-0-e09b39e54de5@bootlin.com>
In-Reply-To: <20251009-feature_sysboot_extension_board-v2-0-e09b39e54de5@bootlin.com>
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

Disable cape detection functionality in XPL (eXtended Program Loader)
images to reduce size and complexity in the early boot stage.

Signed-off-by: Kory Maincent (TI.com) <kory.maincent@bootlin.com>
---

Changes in v2:
- Use PHASE macro instead of XPL check.
- Check SUPPORT_EXTENSION_SCAN instead of CONFIG_CMD_EXTENSION
---
 board/ti/common/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/board/ti/common/Makefile b/board/ti/common/Makefile
index caf6b9fa8c1..f58935b4103 100644
--- a/board/ti/common/Makefile
+++ b/board/ti/common/Makefile
@@ -2,6 +2,6 @@
 # Copyright (C) 2015-2016 Texas Instruments Incorporated - https://www.ti.com/
 
 obj-${CONFIG_TI_I2C_BOARD_DETECT} += board_detect.o
-obj-${CONFIG_CMD_EXTENSION} += cape_detect.o
+obj-${CONFIG_$(PHASE_)SUPPORT_EXTENSION_SCAN} += cape_detect.o
 obj-${CONFIG_OF_LIBFDT} += fdt_ops.o
 obj-${CONFIG_ARCH_K3} += k3-ddr.o

-- 
2.43.0

