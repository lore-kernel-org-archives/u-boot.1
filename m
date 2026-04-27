Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA9A8FF885E
	for <u-boot@archiver.kernel.org>; Mon, 27 Apr 2026 12:56:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0DD34842FD;
	Mon, 27 Apr 2026 14:54:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="UG2InALu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A27538423D; Mon, 27 Apr 2026 11:03:35 +0200 (CEST)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 836CC83C14
 for <u-boot@lists.denx.de>; Mon, 27 Apr 2026 11:03:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=msp@baylibre.com
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4890d945eb4so49570835e9.0
 for <u-boot@lists.denx.de>; Mon, 27 Apr 2026 02:03:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1777280610; x=1777885410;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=k+QTI6VzeHPJG1Ok/4ns1ORWX9G5cr22fsDTkC12q3U=;
 b=UG2InALuwoHwa6INsZIYO5uFytadjvnyoYkU1wg9XCOGt3Q/B+0JNh9XW5RglnkzFo
 bxmgFfgd+1nQeFeMbFjIcFvp3nKcHJLLcUBT9Ql6Wi24vcKQEvacVyGOAgxiJKregi1P
 vHLo9eh0uEVVTWpk2FMNEAsRUQggXxYa/4T7DM86a3Ffun3fTRYpEZEB6SWwlSGJU0XF
 Zd/2BspIcF41pWKzLczqkjrIl+Ddt77QjGsWZo24BT0OzfccuOC8b99WxfXiV15zjDj/
 /BuPw7ulb//wYtRem1ZoxKY8r81RPqePcF3V9axXk5z8n4g2vKPSrSYUEn+TMCQ0NWwo
 XmRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777280610; x=1777885410;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=k+QTI6VzeHPJG1Ok/4ns1ORWX9G5cr22fsDTkC12q3U=;
 b=j1jxGwNpCiuLbxPtqlvX0AslraGS+9vPdaS3XKxrLtMYhCgtnmAdAZJ6KxqQaVCec6
 rlsRhYTRFrY/BDhP1P66geneobQcXWWO8yY/ISE7vuVXRAHe98Po5tE/zqT5V0oHvoMC
 NYN8sQbJnS/BcpFRv77fPku0CZ2MgXT0K15PnAW1orviXXfHcUhAX/s30UtYxNyllpFY
 nMPMatR4q+ezBcreFtsvSD8gvuqPTBrR6BJu/XFP4du/XJMFvnGLfjPKLEJRbL3mFBWj
 +r1RG09aLQMb3v2gO6sD9F3DxZFBrDejqnBskzSl0zRT3V3BcDqUurdl+7qFjXNVKMlF
 CCGg==
X-Gm-Message-State: AOJu0YxUZKpBpdA8rLI53v4oe1k7RRYYGynX8Re7Vj2MiPZOxFsyLPzL
 dHMDe1bxXBUX8rnreOXW9OFbNpIfs64o/v/8z+4TDZNvufs0o4K2jhZua7w1ODr7e+c=
X-Gm-Gg: AeBDieuJUBjNpQzWjlu4lGLcok/7+kF/2/VBCQ5Z0XGI2m7pfC30YT8JLP5C1p5KW34
 h202pRxVET7f4sUirVxJa3to8sXzBxl6VNazISC7DD5Nh2jQb6samsYJeae4hzuswZ7lMPmyJ/I
 K9ETNgB9L46rYMcYanvItqLXDkmtZ+boxE0KlYKpbKnWmcf69Lpv4+CwJsPm8vkcnZluhwXCLPL
 n3Pva1rm5qwopAn0Q09lNyr8yn/25mgowiI14PKJ5tQczStP6H+Mo/bDQK3O8SRoz6GA2l5a+Vd
 6w/S4+WbnsaLRGDmW7VcmMBmbTN1ouqiXm8JDgRJBucQQ1g6EkDD4rDHtdAwc12HXXAjSK6lHhH
 Ptc+K7qKBQWJrUzgYnMSkK/ygs1go4Zp5+mDuSkyoRlUSlugml3SY2oA0FTB+lzLA6iop/c5tr5
 prqXHHvVMuq+rIjW24weGi3bQUKkaKAKA=
X-Received: by 2002:a05:600c:a305:b0:48a:53cb:8604 with SMTP id
 5b1f17b1804b1-48a53cb8949mr293321435e9.14.1777280609841; 
 Mon, 27 Apr 2026 02:03:29 -0700 (PDT)
Received: from localhost ([2001:4090:a246:83ca:1917:a47e:1872:2063])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4891cc7b2efsm329717515e9.0.2026.04.27.02.03.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Apr 2026 02:03:28 -0700 (PDT)
From: "Markus Schneider-Pargmann (TI)" <msp@baylibre.com>
Date: Mon, 27 Apr 2026 11:01:27 +0200
Subject: [PATCH v7 11/14] dm: core: Split SIMPLE_PM_BUS into phases
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260427-topic-am33-evm-oftree-v2026-01-v7-11-7e6cd1a805a1@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2021; i=msp@baylibre.com;
 h=from:subject:message-id; bh=WjsP8F+92HRc+RM3kQY9Oem3n7nDx2oDP4NvQuCEy5M=;
 b=owGbwMvMwCXWejAsc4KoVzDjabUkhsz3ag5LTRur9hVG3S2oPHIwK5235qr+mpmbvDnVZL48/
 S1qP/FNRykLgxgXg6yYIktnYmjaf/mdx5IXLdsMM4eVCWQIAxenAExEm5XhD8eifSmv/90NaAiL
 k70tF6Fy9fxRq3Wfd65xy0r5ufzAssMMv5j8V6WvYXttox/3Rds19HGmjO0e1dUOeVstj12oebb
 2Oh8A
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

Similar to SIMPLE_BUS, create a SPL_SIMPLE_PM_BUS additional to the
SIMPLE_PM_BUS. Most boards will not need SIMPLE_PM_BUS in SPL.

This is currently needed to reduce the SPL size for beagle bone black
with OF_UPSTREAM enabled.

Reviewed-by: Simon Glass <sjg@chromium.org>
Reviewed-by: Kory Maincent <kory.maincent@bootlin.com>
Signed-off-by: Markus Schneider-Pargmann (TI) <msp@baylibre.com>
---
 drivers/core/Kconfig  | 8 ++++++++
 drivers/core/Makefile | 2 +-
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/core/Kconfig b/drivers/core/Kconfig
index 5419bf65b5d653464f8bf958382ede30954d6402..cbefb522e5804fe8f1b674f5db03396b22c45f3a 100644
--- a/drivers/core/Kconfig
+++ b/drivers/core/Kconfig
@@ -342,6 +342,14 @@ config SIMPLE_PM_BUS
 	  Supports the 'simple-pm-bus' driver, which is used for busses that
 	  have power domains and/or clocks which need to be enabled before use.
 
+config SPL_SIMPLE_PM_BUS
+	bool "Support simple-pm-bus driver in SPL"
+	depends on SPL_DM && SPL_OF_CONTROL && SPL_POWER_DOMAIN
+	help
+	  Supports the 'simple-pm-bus' driver, which is used for busses that
+	  have power domains and/or clocks which need to be enabled before use,
+	  in SPL.
+
 config OF_TRANSLATE
 	bool "Translate addresses using fdt_translate_address"
 	depends on DM && OF_CONTROL
diff --git a/drivers/core/Makefile b/drivers/core/Makefile
index a549890c22b997a8c3e7cd6ab08b2ed2ac7994b2..1073c26b2ed0009e15ccca0bac93a64d882f0df9 100644
--- a/drivers/core/Makefile
+++ b/drivers/core/Makefile
@@ -7,7 +7,7 @@ obj-$(CONFIG_$(PHASE_)ACPIGEN) += acpi.o
 obj-$(CONFIG_$(PHASE_)DEVRES) += devres.o
 obj-$(CONFIG_$(PHASE_)DM_DEVICE_REMOVE)	+= device-remove.o
 obj-$(CONFIG_$(PHASE_)SIMPLE_BUS)	+= simple-bus.o
-obj-$(CONFIG_SIMPLE_PM_BUS)	+= simple-pm-bus.o
+obj-$(CONFIG_$(PHASE_)SIMPLE_PM_BUS)	+= simple-pm-bus.o
 obj-$(CONFIG_DM)	+= dump.o
 obj-$(CONFIG_$(PHASE_)REGMAP)	+= regmap.o
 obj-$(CONFIG_$(PHASE_)SYSCON)	+= syscon-uclass.o

-- 
2.53.0

