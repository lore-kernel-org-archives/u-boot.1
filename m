Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FE6DFF8862
	for <u-boot@archiver.kernel.org>; Mon, 27 Apr 2026 12:55:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C6FBF842D7;
	Mon, 27 Apr 2026 14:54:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="giBX0iDb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0BE2D8420C; Mon, 27 Apr 2026 11:03:29 +0200 (CEST)
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com
 [IPv6:2a00:1450:4864:20::434])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0798E84119
 for <u-boot@lists.denx.de>; Mon, 27 Apr 2026 11:03:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=msp@baylibre.com
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-43d03db7f87so6798656f8f.3
 for <u-boot@lists.denx.de>; Mon, 27 Apr 2026 02:03:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1777280603; x=1777885403;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=mqD8wg/o3aOjH74OKLk9h8N1R36H89YNGYkFQoWJ5kI=;
 b=giBX0iDb31vwZkiZUzOVzcZVx2CN944cVXxS5ajcXuzrbwWvrOjyMfuR5iAVfVLEPY
 3W+o8V/snpHuDaug26A/9fi/Z2RreXgwkl2znf6kkGgph5gZqzbUjITl6T55uwsa9MKE
 x4V0vHt3H0Z9S1PHP9NBWYQuqN6KaGfN37UW+IhbV7avE4zlvXdQFmQSa0i/geWs5iT6
 iecy60ZP7hROl1Dr9nWe+HR0WDFVyWfHh75UqTVYVHMveLHDloCWnm5+sz10OlCpNHXT
 Emx/ADOHzBYJO6J5KDh7aSIWgr9u81rE6E5Kfw6+bojvffPF2SEh8Yy6+qP3bOfdjsL0
 kS4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777280603; x=1777885403;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=mqD8wg/o3aOjH74OKLk9h8N1R36H89YNGYkFQoWJ5kI=;
 b=T5NPHMAmDrmRMdrNBnKUsss8IA1fpN1flA2qlZlOI27e4XcdRCt0PP5t6IyQkQYMmx
 lOx1Qlo+5NVb9JREElinBFggx2kI6dj6eHdlF9Hi9lHKzXxAfQewPRbKWO0Uc/QRRF8R
 r1UpMBfIEX1YtBmE9mHxsJVlZuVDAheIVlRulQ23x2d81JaQNMdjEvVAn0qZaen227mv
 o+PTSv4DNxpgjrV5zu9pJVm/jTolXDr+9IJnqkqksWXBarfKch0WTZFNj3+vuBsdzF+9
 LoyuTqJkmdveoxRgdJktvFoq0BWMzPC16BqOs/0eED/kMsHj3l6aNnZWRUieHbe1cBda
 wzOw==
X-Gm-Message-State: AOJu0YyTpZBPqRKqjWQly8vfWs3d6hHKUZ8pdNcOQ2V6NnIBdTTLpq6G
 B8obNz4fckGBF1MQnaFlK64ARUO+G+uCOsJP9aywHGt2gSAJ0J4j5/FgwvrXCObMM2M=
X-Gm-Gg: AeBDiesMzWMw2ch+4DoD4joH5jBmsC7hH7sXP8t71IjQEsYNH1QgIWrfS7+ZbqNEAGN
 JnMtRkFT5ib2So7ehcWnumz+fAdoCScyia4mXlmgnZ/LQOyWHLhw8ccI/04yuYShffpRyUpLAve
 NkhHukujAe06iLNi01Rsqst+N+8AJkDb56X9aJz9IZWavcc+021N2ZT/VtwI31jC0KSYT+g6uCO
 9jkut6b322XWwo3d7juGn373GAwg+XoMTeIClUmngxu8pBbZCLADdR3cO4C1r6pXkqaljMMgZBs
 zJtwPO4xKcE/NoCv15nskB8haVTuPJMW0iD/bx1YuISIwmZ7i+RvAYCyd2fWtzDb35zPF5M8UUZ
 TA9O7zTZwR+dw+YA9WHKVpDY87Tvo4819oj9gg8ypptuCmFTHRL4BNNtqw6oqWFm4sPp2zQdGJf
 g9YmN0rUoE3lXpuVT5DZJFZpa/Q/jtf2Pnq1w/f5c5dg==
X-Received: by 2002:a05:6000:26cf:b0:43f:dfbc:8c71 with SMTP id
 ffacd0b85a97d-43fe3dfbd89mr63367732f8f.25.1777280603335; 
 Mon, 27 Apr 2026 02:03:23 -0700 (PDT)
Received: from localhost ([2001:4090:a246:83ca:1917:a47e:1872:2063])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43fe4cc07bbsm83939048f8f.11.2026.04.27.02.03.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Apr 2026 02:03:22 -0700 (PDT)
From: "Markus Schneider-Pargmann (TI)" <msp@baylibre.com>
Date: Mon, 27 Apr 2026 11:01:22 +0200
Subject: [PATCH v7 06/14] am33xx: Avoid hard failure on USB probe issue
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260427-topic-am33-evm-oftree-v2026-01-v7-6-7e6cd1a805a1@baylibre.com>
References: <20260427-topic-am33-evm-oftree-v2026-01-v7-0-7e6cd1a805a1@baylibre.com>
In-Reply-To: <20260427-topic-am33-evm-oftree-v2026-01-v7-0-7e6cd1a805a1@baylibre.com>
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
 Parth Pancholi <parth.pancholi@toradex.com>, 
 =?utf-8?q?Jonas_Schw=C3=B6bel?= <jonasschwoebel@yahoo.de>, 
 Paul Kocialkowski <contact@paulk.fr>, 
 Andre Przywara <andre.przywara@arm.com>, Paresh Bhagat <p-bhagat@ti.com>, 
 Ion Agorria <ion@agorria.com>, Peng Fan <peng.fan@nxp.com>, 
 "Markus Schneider-Pargmann (TI)" <msp@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1212; i=msp@baylibre.com;
 h=from:subject:message-id; bh=a9mNtkme71PbyJwqoxXU2jtKAgHiQS6mJbF3mtWckVE=;
 b=owGbwMvMwCXWejAsc4KoVzDjabUkhsz3ahp5pYu3he8rveKidF/5UsdpaQMGo1t67DbvP8k9r
 Jji7v69o5SFQYyLQVZMkaUzMTTtv/zOY8mLlm2GmcPKBDKEgYtTACaSLMHI0P+qyPqGtswOjSl3
 hPbrf7FT7Sj+xFR6+E2eqtqWSIZ1Ggz/a59d/PhUZP73pL6wvct7OLexFWWXG0v/6g74cPL4x6s
 2nAA=
X-Developer-Key: i=msp@baylibre.com; a=openpgp;
 fpr=BADD88DB889FDC3E8A3D5FE612FA6A01E0A45B41
X-Mailman-Approved-At: Mon, 27 Apr 2026 14:54:41 +0200
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

Currently if USB fails to probe, U-Boot does not reach the console.

This patch does not fail if USB fails to probe making it easier to debug
in case of issues.

Reviewed-by: Kory Maincent <kory.maincent@bootlin.com>
Signed-off-by: Markus Schneider-Pargmann (TI) <msp@baylibre.com>
---
 arch/arm/mach-omap2/am33xx/board.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/am33xx/board.c b/arch/arm/mach-omap2/am33xx/board.c
index 4e9ad8935e3b5020c4ed1d022ae4846a2dc9486f..90b341303c7309dc21b34cc01020db997f53c8f3 100644
--- a/arch/arm/mach-omap2/am33xx/board.c
+++ b/arch/arm/mach-omap2/am33xx/board.c
@@ -266,12 +266,17 @@ int arch_misc_init(void)
 	struct udevice *dev;
 	int ret;
 
+	/*
+	 * Trigger probe of the UCLASS_MISC device which is a USB wrapper driver
+	 * ti-musb-wrapper that handles all usb host and gadget devices.
+	 */
 	ret = uclass_first_device_err(UCLASS_MISC, &dev);
 	if (ret)
-		return ret;
+		printf("Failed probing USB %d, continue without USB\n", ret);
 
 #if defined(CONFIG_DM_ETH) && defined(CONFIG_USB_ETHER)
-	usb_ether_init();
+	if (!ret)
+		usb_ether_init();
 #endif
 
 	return 0;

-- 
2.53.0

