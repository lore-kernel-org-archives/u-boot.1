Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E69DCCD183
	for <u-boot@archiver.kernel.org>; Mon, 13 Oct 2025 13:33:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4F84883936;
	Mon, 13 Oct 2025 15:32:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="rPz/k+5I";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B6C0B837E4; Mon, 13 Oct 2025 15:32:50 +0200 (CEST)
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DB55F837E4
 for <u-boot@lists.denx.de>; Mon, 13 Oct 2025 15:32:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kory.maincent@bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id 6C94E4E40F94;
 Mon, 13 Oct 2025 13:32:48 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 42AA2606C6;
 Mon, 13 Oct 2025 13:32:48 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id EA4FB102F2263; 
 Mon, 13 Oct 2025 15:32:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1760362367; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=u8lvoISWRYZi75RNgeNf+uwFBm4XXO7i6GLmcjMM8YY=;
 b=rPz/k+5IDltg0rVQlbM/YpJGsOBfxOtEGGm1QcwTFXyc5xYLE/xqbGT9rRMv8trDKydlxm
 skspm8CtiDbJACfYcBep0Fajur3ArwPvKdjoNUnjdB7UeZm4feXRI077rPKdeB66E6DL31
 WJnAYvyh2F1oLjm5qiM96xuS5Z7X4uDQPZnS0XBzcmQux/ZgwJVwHMjtw7rNsNTT4macnC
 SB7q+1TaDFDyFsmaGYsrVPr0wbPWCnulU9rQoAB8+MCtTSR18NxDVhXaQG2/5qtdgw2XAQ
 rPWvzgtbaxEM5hlH60yHkITY18ic/1LgBaqlOTLA8osjPT6TvdZRb5L17KiVCg==
From: "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>
Date: Mon, 13 Oct 2025 15:32:29 +0200
Subject: [PATCH v3 04/20] board: sunxi: Exclude DIP detection from XPL builds
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251013-feature_sysboot_extension_board-v3-4-04067b7422a5@bootlin.com>
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

Disable DIP detection functionality in XPL (eXtended Program Loader)
images to reduce size and complexity in the early boot stage.

Signed-off-by: Kory Maincent (TI.com) <kory.maincent@bootlin.com>
---

Change in v2:
- New patch.
---
 board/sunxi/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/board/sunxi/Makefile b/board/sunxi/Makefile
index d96b7897b6c..ee82493117a 100644
--- a/board/sunxi/Makefile
+++ b/board/sunxi/Makefile
@@ -11,4 +11,4 @@ obj-$(CONFIG_SUN7I_GMAC)	+= gmac.o
 obj-$(CONFIG_MACH_SUN4I)	+= dram_sun4i_auto.o
 obj-$(CONFIG_MACH_SUN5I)	+= dram_sun5i_auto.o
 obj-$(CONFIG_MACH_SUN7I)	+= dram_sun5i_auto.o
-obj-$(CONFIG_CHIP_DIP_SCAN)	+= chip.o
+obj-$(CONFIG_$(PHASE_)CHIP_DIP_SCAN)	+= chip.o

-- 
2.43.0

