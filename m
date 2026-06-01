Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2D92CD6E56
	for <u-boot@archiver.kernel.org>; Mon,  1 Jun 2026 12:14:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2BB4A84A0B;
	Mon,  1 Jun 2026 14:07:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=baylibre.com header.i=@baylibre.com header.b="EH9qw2qn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7BCDC84852; Mon,  1 Jun 2026 11:32:37 +0200 (CEST)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 74211846A3
 for <u-boot@lists.denx.de>; Mon,  1 Jun 2026 11:32:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=msp@baylibre.com
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4906238c62eso78583775e9.3
 for <u-boot@lists.denx.de>; Mon, 01 Jun 2026 02:32:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1780306355; x=1780911155; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=k+QTI6VzeHPJG1Ok/4ns1ORWX9G5cr22fsDTkC12q3U=;
 b=EH9qw2qncFWiRcnPj2AB/YKB9htdLh9UqOluyEu4tQ+VflJ8yhd/vyOKyevX5/d4LU
 b9MGrPUFXhfU8V2FWaJ6bTZkm1lnWPMVBg0r15JddZRr73BchQGj9b3meeFXgRhrFWi6
 JR/iKogymC/i9a80sKUrq9hRcQ0ONRYKCOiGRnrN+IDoUdjWvPGNrsHdaO1uRYkHR01T
 72um+bOKzTWewUWAHVasYnfvQFRDm9THDvmqEqJ6AdkkAcvsiInoNdOhleVpji2m4RI7
 EmEkh2z1q7Z/G6gqn1T6c400fbBoGQ812cAObXhQaNw8WjjhHxIh5xNPeV4tEEkCmGwc
 0NVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780306355; x=1780911155;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=k+QTI6VzeHPJG1Ok/4ns1ORWX9G5cr22fsDTkC12q3U=;
 b=ksC95swNEHdLlAP0jEUVLcsbfTiP7nAd0qrPnzYWYFCoOXJDwEpI/Wgmxs2Ixdl7ez
 YUtCt6E5xwbag66bL6Wm2lKK612N2HE7sAzO/cRKYjE60cFz3Yoz6tHU+BWjKqn66TRQ
 UqPclcTyjff7OowJaErhm4Em77u4c3fFPcK100c5CP/hLcCg2FymWqF6LosDPGfZFsTf
 d4gVFlU/ExsKjKkQG5Ph4EIGe5wl5enTS5lV21HHnSlyHclXK1HAgAR2S6/SUGgjbeBH
 TRGZoC5/+HbGMzFyw5aPyBQ0s+jenxCydn1FQRBZHRIKaoakgPmZH71syWOW9d7A9fwK
 JXrw==
X-Gm-Message-State: AOJu0Yw1k7wna7+zZ5m8py6udHbAAjeX7RqgKP8ArTBd4+wBN3cWKgAG
 hnvZHYmsM1vBaJLX3Zo39cBoSOWee1dWqglpDJal2XTr1fFCOZDF4TOhBALoDccYsUw=
X-Gm-Gg: Acq92OF2QCTsyAJdQlxKT0syZJoMknBCKQBvsGS6rIHulMVqt0qYrAbswhm3LYLjo2e
 mpK6PBS97cS6Btlo1Kd6fv3hoB3ylyRLOzf9pZcTS4znyD7Gmty/2FnWej2PQemDxYi0z4wjb19
 VSyqMaJI0tJYFQtw+4nA7qeN0OmBGPpk6aE0M2mowTlaIOxuOSxcYoVLP8lVsYoSTjKKkGqdeOQ
 VxQ5PZVPLsj0isGW7++CLw9a654Mw5enFh2WIKQaleVnqta+49Jloq6jKXXv9n1YDfBMKzblt8n
 6uyLFyYeNOdfLaEhTKo9Zd+wJ20RbxyB6F0J4ZjJf9JapCa5tZ80bv85PX6OCRbX75Lpdor37Aw
 H7gKGGq98VKLBvFCrmjGzd9vZ8MuBbllRDJ32qvaaJfgsP7ep7nN0Jeuh5hKTQyFEl1LniJrfLm
 SJc/2zEa8MIt0NbyGXv1L77Szwf703b2E=
X-Received: by 2002:a05:600c:8b2e:b0:490:6237:5213 with SMTP id
 5b1f17b1804b1-490a2941a84mr188617835e9.23.1780306354905; 
 Mon, 01 Jun 2026 02:32:34 -0700 (PDT)
Received: from localhost ([2001:4091:a246:8595:a745:3210:d732:4094])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4909d68a925sm362496645e9.2.2026.06.01.02.32.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jun 2026 02:32:34 -0700 (PDT)
From: "Markus Schneider-Pargmann (TI)" <msp@baylibre.com>
Date: Mon, 01 Jun 2026 11:30:46 +0200
Subject: [PATCH v8 11/17] dm: core: Split SIMPLE_PM_BUS into phases
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260601-topic-am33-evm-oftree-v2026-01-v8-11-2c33c98e7ce5@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2021; i=msp@baylibre.com;
 h=from:subject:message-id; bh=WjsP8F+92HRc+RM3kQY9Oem3n7nDx2oDP4NvQuCEy5M=;
 b=owGbwMvMwCXWejAsc4KoVzDjabUkhizZwMrHyT/slqWX2ljvMPhw4lES46TiFfnbE4xaGWe2i
 mrwvRPsKGVhEONikBVTZOlMDE37L7/zWPKiZZth5rAygQxh4OIUgImoTmP479VkbmW1f6XmmQKV
 Pa2ZlyfVdwj69s/+0uSWH99QZZk2g5Gh59DKJIPqiEnR+nNYT4u1Bj4SXs6x2XNm+d+cgndL3Re
 xAgA=
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

