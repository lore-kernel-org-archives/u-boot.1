Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F31ACCD1A5
	for <u-boot@archiver.kernel.org>; Tue, 21 Oct 2025 08:00:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 298C5831D6;
	Tue, 21 Oct 2025 10:00:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="hlgbQQUQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 854B58334F; Tue, 21 Oct 2025 10:00:00 +0200 (CEST)
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 384D3802C1
 for <u-boot@lists.denx.de>; Tue, 21 Oct 2025 09:59:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=richard.genoud@bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-02.galae.net (Postfix) with ESMTPS id C85B81A1580;
 Tue, 21 Oct 2025 07:59:57 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 9CD73606DC;
 Tue, 21 Oct 2025 07:59:57 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 3EA72102F23F0; 
 Tue, 21 Oct 2025 09:59:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1761033596; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding; bh=cSY+c3XG7PfH2fmkA1TVDpwbPHkg3Y3wWAnhmgLPWfI=;
 b=hlgbQQUQfnbXTu7Hiv9MLo6bC50lwMKVSwWZw13xappLXYwP3b7+sO0+KCoKZJR5njSL2o
 sPAvPa9OuvO3HvCQWyEnt6jczeTWKgw8t2MGC6KSxqhC4GdbsfSe234Gy2MhXzX7drkvbi
 tODHvwq6I4axzCVry2yCLj2AGoIfdl1rk6UTLNBF/ZZrgBJAoqQxftsmphHwm/oIHC6GuY
 FUw3B3Horu90gOFS6Y7Fa5n3ovRohiI5A09s9BeHXuRisVuGxuqR5SdoiFgxQFDyNh5x9w
 sFwoIhi8aGf5btqFI4JkkqBlGgtrjJwwrSn2CIIzfv7QIeFZMGUM9tLb3Odpfw==
From: Richard Genoud <richard.genoud@bootlin.com>
To: Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Tom Rini <trini@konsulko.com>, Jagan Teki <jagan@amarulasolutions.com>,
 Andre Przywara <andre.przywara@arm.com>
Cc: Dinesh Maniyam <dinesh.maniyam@intel.com>,
 Linus Walleij <linus.walleij@linaro.org>,
 Anand Gore <anand.gore@broadcom.com>, david regan <dregan@broadcom.com>,
 Greg Malysa <malysagreg@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Philip Molloy <philip.molloy@analog.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, u-boot@lists.denx.de,
 James Hilliard <james.hilliard1@gmail.com>,
 Richard Genoud <richard.genoud@bootlin.com>
Subject: [PATCH v2] Makefile: pass KEYDIR when set to sunxi-spl.bin mkimage
Date: Tue, 21 Oct 2025 09:59:34 +0200
Message-ID: <20251021075934.549466-1-richard.genoud@bootlin.com>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

From: James Hilliard <james.hilliard1@gmail.com>

Provide private keys to build sunxi-spl.bin

Currently we pass this for u-boot-spl.kwb targets, however when
building sunxi-spl.bin in the TOC0 format, we may also need to
specify a KEYDIR.
As such we should also pass this when set to mkimage for the
sunxi-spl.bin target.

Tested on Whatsminer H616 board.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
Signed-off-by: Richard Genoud <richard.genoud@bootlin.com>
---
 scripts/Makefile.xpl | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

Changes from v1:
- remove superfluous From: (sorry for the noise)

diff --git a/scripts/Makefile.xpl b/scripts/Makefile.xpl
index 3e940bf562d5..52f014ad3324 100644
--- a/scripts/Makefile.xpl
+++ b/scripts/Makefile.xpl
@@ -442,7 +442,8 @@ MKIMAGEFLAGS_sunxi-spl.bin = \
 	-A $(ARCH) \
 	-T $(CONFIG_SPL_IMAGE_TYPE) \
 	-a $(CONFIG_SPL_TEXT_BASE) \
-	-n $(CONFIG_DEFAULT_DEVICE_TREE)
+	-n $(CONFIG_DEFAULT_DEVICE_TREE) \
+	$(if $(KEYDIR),-k $(KEYDIR))
 
 OBJCOPYFLAGS_u-boot-spl-dtb.hex := -I binary -O ihex --change-address=$(CONFIG_SPL_TEXT_BASE)
 

base-commit: 2ba64e303b2706e5c42a6bf982326d632342ca66
-- 
2.47.3

