Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF911CCD1AB
	for <u-boot@archiver.kernel.org>; Wed, 22 Oct 2025 15:20:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 580A5835FE;
	Wed, 22 Oct 2025 17:20:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="OT/ErUaR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C961C835B0; Wed, 22 Oct 2025 17:20:32 +0200 (CEST)
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 847FB82B20
 for <u-boot@lists.denx.de>; Wed, 22 Oct 2025 17:20:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kory.maincent@bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-02.galae.net (Postfix) with ESMTPS id 3EFF61A15C3;
 Wed, 22 Oct 2025 15:20:30 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 15C21606DC;
 Wed, 22 Oct 2025 15:20:30 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 69C3B102F2435; 
 Wed, 22 Oct 2025 17:20:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1761146429; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=6YaBRH1HaDBXGrpsy7FAfCDgoLLu6N65RKzF3NGVWvg=;
 b=OT/ErUaRKYVPzSZAzu38M9/tlxOa2uCzoYyb9SdgR0M6mW+AP4Lfo81whH2x7XcyuuKrfr
 ME2JZ34BN2eZm1iA6SYZIIiu6NdiAGYBchhRNoDOGnxXRZ3A3EN3HUXTt9PzDx3peUZm49
 v/mbz0nWLQ0rMFjgqQHRnTVXamjoBFZ1sFsNYvxIYAVMRtMnUd1uPF3TP1wzwaFpNrk0AF
 k+L6ZqKXg0ytO/8lDJj74PntB8BvY1vSX3s2GkHESv408CHMWFhfN9SlXbGRObw9x+zD1s
 Yy6+kLCxbRH0VW0DaU52wiULfEMAPWHMFnYuCYEsJputMRXF/tR1bfMe/OMR9w==
From: "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>
Date: Wed, 22 Oct 2025 17:20:13 +0200
Subject: [PATCH v4 02/20] board: ti: Exclude cape detection from XPL builds
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251022-feature_sysboot_extension_board-v4-2-d24b5ef7b468@bootlin.com>
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

