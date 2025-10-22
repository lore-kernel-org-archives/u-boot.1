Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22BC7CCD1AB
	for <u-boot@archiver.kernel.org>; Wed, 22 Oct 2025 15:20:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 193C48323A;
	Wed, 22 Oct 2025 17:20:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="dFWBMeyk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 659A2835B0; Wed, 22 Oct 2025 17:20:30 +0200 (CEST)
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 897758323A
 for <u-boot@lists.denx.de>; Wed, 22 Oct 2025 17:20:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kory.maincent@bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-02.galae.net (Postfix) with ESMTPS id 311C51A15D7;
 Wed, 22 Oct 2025 15:20:28 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id F35B8606DC;
 Wed, 22 Oct 2025 15:20:27 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id E615B102F2444; 
 Wed, 22 Oct 2025 17:20:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1761146426; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=FHr/DjBd4F29pmKYX3P4sWO6KGWp0qZyXLMbZ05J8UU=;
 b=dFWBMeyktoRAzvtfyA7G7QheNIYFgXKjCdGbLYh1x/ssudhTsTGg/Ylk0XSTShD5HiCIID
 YaFMc0PioJ1xfXGpDdSFKiHpT6A/XLJAnDKwWznty8WhqlIUt11hmIFyccuiZlNKEjlVJJ
 zXQL2VCo3t2B/dPI5rORJRt8PG7x0NaZcs0PiCo9ZLhDFzzoIUcoQp3s3L4/glUo8E/x7C
 JuYHeCGWTzqoxRAnLcVTWaKycEKwB/ktysI+sTxPP8JNhgdwlkft+tsqZfBWQkyt1xoWWh
 ws/KcDPAvVSrPo+aD/Cp4UChL01QvKwAH/HPWvqJrmCRerbaukGiVcjC9NkMWA==
From: "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>
Date: Wed, 22 Oct 2025 17:20:12 +0200
Subject: [PATCH v4 01/20] MAINTAINERS: Add maintainer for extension board
 support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251022-feature_sysboot_extension_board-v4-1-d24b5ef7b468@bootlin.com>
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
 "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>
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

Add myself as maintainer for the extension board support that was
originally added to track ongoing development and maintenance.

Signed-off-by: Kory Maincent (TI.com) <kory.maincent@bootlin.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>
---
 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 12043a1f82e..e411e266c94 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1182,6 +1182,14 @@ F:	scripts/event_dump.py
 F:	test/common/event.c
 F:	test/py/tests/test_event_dump.py
 
+EXTENSION
+M:	Kory Maincent <kory.maincent@bootlin.com>
+S:	Maintained
+F:	board/sunxi/chip.c
+F:	board/ti/common/cape_detect.c
+F:	cmd/extension_board.c
+F:	include/extension_board.h
+
 FASTBOOT
 M:	Mattijs Korpershoek <mkorpershoek@kernel.org>
 S:	Maintained

-- 
2.43.0

