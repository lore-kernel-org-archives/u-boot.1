Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B005CD6E56
	for <u-boot@archiver.kernel.org>; Mon,  1 Jun 2026 12:13:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B52D284A02;
	Mon,  1 Jun 2026 14:07:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=baylibre.com header.i=@baylibre.com header.b="pCTvhx0A";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 011D484862; Mon,  1 Jun 2026 11:32:35 +0200 (CEST)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 106558484C
 for <u-boot@lists.denx.de>; Mon,  1 Jun 2026 11:32:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=msp@baylibre.com
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-49068493267so54225195e9.1
 for <u-boot@lists.denx.de>; Mon, 01 Jun 2026 02:32:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1780306352; x=1780911152; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=EuONaSG+lMLRa2oA554ImlJ2y/z/OKdI28p9VCThWDY=;
 b=pCTvhx0AQ9FQV4v4OoiFRnAriUFwsHbmHA0yDW+1EWIuQkljUIkNlRF37o9/06rou4
 YiccbIaLrkSqy9CaAaVUuA0mBHHvRkx5AO7JwIcPCsMGSd3fwxG83tl/oIkT/aUefvjY
 P+COmjbfdV3QZ83S9VDdMj+oSvbBrUTge4tIPeC/QtC88a3IPjO3sZF8ZoDN3nRlTdWP
 +AKYt20p7kIivExhbleBZmrXXmKYwR/MWJOmk828+36RGgQC27t5xwZmHL5NGdX3iDJe
 05RSr9jP0cvVGx1q1xdgNF3+26++GPJmD8yVVztAAxTxxxaWj4Bv5IDGFd12HUxiUMpT
 zyOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780306352; x=1780911152;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=EuONaSG+lMLRa2oA554ImlJ2y/z/OKdI28p9VCThWDY=;
 b=XHQ5XoQIOhKE+U/uYmu/6qj7ht4p23m7fPNHdUiKO5aqPN9O7I46kXJI6xLMzgLtsW
 p6+Ni2LtLBRoLNj2vTxiozgWIsAsG+kOzrklGvlA7l/Si386Ae8WF6NF0lcpO+/YZGxx
 Xne7a2xt+XTPJTQa/kIRZ3mBlTSWDMXYIY60tZrppN0D+nnS4EQ4lI3oNtOeh7vtICLA
 EdtVMndHJkZSAFZTvrt5MEIAY+a5RW4XW3Xp26kwjpDPAq5Ccsq1ZqxgshVE+jLcGmUs
 xua+EccI3RrpYWO+r2x6p3mPe1GF50fkzUiprIy0+JjugVI/9PkKqvzQ/udS34ZZw2Z9
 0oHQ==
X-Gm-Message-State: AOJu0YzHwggH9B8IK6pT79QfS2sXLcN2KXO7CT6+namdYbhDlwEJ/laO
 PG8OXKC15e3h8SsFAe0m1xeBM1G4reerJGPX307vX7yESI/Z967PTwgmGxlpZWApTrE=
X-Gm-Gg: Acq92OGxHAUk8vfg1yMUsQVESwAOwjlUul+ih78LctgqHMTQEBCxl9igPHA3aMZKAOn
 jzvesHkeXpTlWqahwQrqWEhTgv6561zxnnSk6AY/69F0Iltcekj0DOT1TZAGYW4ar4MJD/c0w39
 IOmn06xd6M6YqXZSTfh4DG9RJsrHFlIYtq1oCNp8yoVo9fuLFQwCvdUs8mRi2oKb9OXP+UMA2p0
 iv93XP8+uuD/J4K5JpSNXgRkC7M4cNoD/ncjV6/XQHY91C6clWh9ALACYw3ZU8ob77g+DygmmeL
 oSGJcDuqL73NdCMqh7qnLpotnYSrVHeAuMvnG9LNkLm7knzL6ST1wX+Up2anscuHinZa/NJEZmd
 Tczv5AhcdSV/UJM9txfhVSB96IuohjQAv6PyPbGH00dRQkFKfaXeN8pG66Wi9gvOp3lZiBjCN6v
 O5mDyMqh8ZrF/Bk+vflSeiymxBWmFezqk=
X-Received: by 2002:a05:600c:1d86:b0:48e:60a3:220a with SMTP id
 5b1f17b1804b1-490a28aa789mr199700145e9.0.1780306352562; 
 Mon, 01 Jun 2026 02:32:32 -0700 (PDT)
Received: from localhost ([2001:4091:a246:8595:a745:3210:d732:4094])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4909d7002e8sm264084275e9.15.2026.06.01.02.32.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jun 2026 02:32:32 -0700 (PDT)
From: "Markus Schneider-Pargmann (TI)" <msp@baylibre.com>
Date: Mon, 01 Jun 2026 11:30:44 +0200
Subject: [PATCH v8 09/17] am33xx: Fix comment about config symbols
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260601-topic-am33-evm-oftree-v2026-01-v8-9-2c33c98e7ce5@baylibre.com>
References: <20260601-topic-am33-evm-oftree-v2026-01-v8-0-2c33c98e7ce5@baylibre.com>
In-Reply-To: <20260601-topic-am33-evm-oftree-v2026-01-v8-0-2c33c98e7ce5@baylibre.com>
To: u-boot@lists.denx.de, Marc Murphy <marc.murphy@sancloud.com>
Cc: Tom Rini <trini@konsulko.com>, Rasmus Villemoes <ravi@prevas.dk>, 
 Kory Maincent <kory.maincent@bootlin.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Romain Gantois <romain.gantois@bootlin.com>, 
 Parvathi Pudi <parvathi@couthit.com>, 
 Basharath Hussain Khaja <basharath@couthit.com>, 
 Paul Barker <paul.barker@sancloud.com>, "Andrew F. Davis" <afd@ti.com>, 
 Simon Glass <sjg@chromium.org>, Anshul Dalal <anshuld@ti.com>, 
 Michael Trimarchi <michael@amarulasolutions.com>, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Svyatoslav Ryhel <clamor95@gmail.com>, 
 Tien Fong Chee <tien.fong.chee@altera.com>, 
 Frieder Schrempf <frieder.schrempf@kontron.de>, 
 Johan Jonker <jbx6244@gmail.com>, Brian Sune <briansune@gmail.com>, 
 Hai Pham <hai.pham.ud@renesas.com>, 
 Bernhard Messerklinger <bernhard.messerklinger@at.abb.com>, 
 Emanuele Ghidoli <emanuele.ghidoli@toradex.com>, 
 =?utf-8?q?Jonas_Schw=C3=B6bel?= <jonasschwoebel@yahoo.de>, 
 Paul Kocialkowski <contact@paulk.fr>, 
 Andre Przywara <andre.przywara@arm.com>, Paresh Bhagat <p-bhagat@ti.com>, 
 Ion Agorria <ion@agorria.com>, Peng Fan <peng.fan@nxp.com>, 
 Ernest Van Hoecke <ernest.vanhoecke@toradex.com>, 
 David Lechner <dlechner@baylibre.com>, Janne Grunau <j@jannau.net>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Sughosh Ganu <sughosh.ganu@arm.com>, 
 "Markus Schneider-Pargmann (TI)" <msp@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1145; i=msp@baylibre.com;
 h=from:subject:message-id; bh=5Yykrkd1oSnyX7pm49x9FHg9Z9WPawInbezFIX1wlQU=;
 b=owGbwMvMwCXWejAsc4KoVzDjabUkhizZwAJfCzU9bYcFpmvCy27fmvT66az42w3tTz0PPb126
 AHjSscDHaUsDGJcDLJiiiydiaFp/+V3HktetGwzzBxWJpAhDFycAjCROA1GhnVSYlyaByJUCqJn
 tXcXH9hd7yly3vC+7o5V+VKbzs8/UMPw37P2qatDFu/1O1MnPim70e+b/uq5gaCZqDTbuiyNjtZ
 jvAA=
X-Developer-Key: i=msp@baylibre.com; a=openpgp;
 fpr=BADD88DB889FDC3E8A3D5FE612FA6A01E0A45B41
X-Mailman-Approved-At: Mon, 01 Jun 2026 14:07:04 +0200
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

Fix #else and #endif comments to match actual #if condition. Comments
incorrectly referenced CONFIG_USB_MUSB_* instead of CONFIG_AM335X_USB*
and CONFIG_XPL_BUILD.

Reviewed-by: Kory Maincent <kory.maincent@bootlin.com>
Signed-off-by: Markus Schneider-Pargmann (TI) <msp@baylibre.com>
---
 arch/arm/mach-omap2/am33xx/board.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/am33xx/board.c b/arch/arm/mach-omap2/am33xx/board.c
index 90b341303c7309dc21b34cc01020db997f53c8f3..c3931900622957a5499fe6483473c61e3a62fff0 100644
--- a/arch/arm/mach-omap2/am33xx/board.c
+++ b/arch/arm/mach-omap2/am33xx/board.c
@@ -259,7 +259,7 @@ int arch_misc_init(void)
 {
 	return 0;
 }
-#else	/* CONFIG_USB_MUSB_* && CONFIG_AM335X_USB* && !CONFIG_DM_USB */
+#else /* CONFIG_AM335X_USB* && CONFIG_XPL_BUILD */
 
 int arch_misc_init(void)
 {
@@ -282,7 +282,7 @@ int arch_misc_init(void)
 	return 0;
 }
 
-#endif /* CONFIG_USB_MUSB_* && CONFIG_AM335X_USB* && !CONFIG_DM_USB */
+#endif /* CONFIG_AM335X_USB* && CONFIG_XPL_BUILD */
 
 #if !CONFIG_IS_ENABLED(SKIP_LOWLEVEL_INIT)
 

-- 
2.53.0

