Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E59ACFD376
	for <u-boot@archiver.kernel.org>; Fri, 28 Nov 2025 14:14:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6DDEB845C8;
	Fri, 28 Nov 2025 15:13:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="nn+jOUtG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D48E8844D8; Fri, 28 Nov 2025 11:17:29 +0100 (CET)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D84BC844DF
 for <u-boot@lists.denx.de>; Fri, 28 Nov 2025 11:17:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=msp@baylibre.com
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-47774d3536dso13688655e9.0
 for <u-boot@lists.denx.de>; Fri, 28 Nov 2025 02:17:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1764325042; x=1764929842;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=OsXB7AaS+QZ9M3tNGgcSVtHQVFc0ivNOMKrAxCYr42A=;
 b=nn+jOUtGuHs+vFGIm8BHZ7W0uQg5ri9gjpWbuX0etl+2pKJMxoPrC8OwCXMdHgaFZD
 +56pgI/5Nl9KdoLAPn6t3hajxWkQPi2wrb+Q0Cj3jM+LGgVcj0FMwZ6Ab1PVNy1qwiqh
 LcMsuj8cCa5Ls7ImMB2BrHkcvShcPirrkPeZRvvgDYYLnBM+tYQfu8JLV5UtjG1akamZ
 CEmhFrCbcXM3tbXvTheA9F3FOpud7tfUwjvlJzpWcLF9efV8TdqCtZPSYLiXhDTEHBPK
 yoCP2ozWCy+OjSEhodHe32CRgEe51i8PLxTU/pg7d1OjpPXUIfDKI/OhjosiFV+2oN3X
 z9Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764325042; x=1764929842;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=OsXB7AaS+QZ9M3tNGgcSVtHQVFc0ivNOMKrAxCYr42A=;
 b=EmnBqKqkbvie0RcS/NUM1z0qzcF5dvYulMIWSzJ6Aig6yXt6S7QjZnisDCtP+b3qlL
 JsxfbwWUjHhjoSqoYauGJb2hzOZole590tLD12xO6p0IZbV07posMpjvNTLvQ3QCFPb9
 HhKayGdPJEsSR0YCFJiNAqbYnjrGBSXImtyHJua7XzxJXFga1QdY93XOBADvtCDInTxe
 HEBfeymFau1RcaLAeYkNPhD39tYEyXusL9Bnjo9qP2s66K31q/XwyuK5AkL8oLsWZOmS
 LyKbQVHwdZcaz56aVgiSQiV22SSdQzJbi4EI2haJ+untU7b6AYwYpTbQtFu4GMWBhNrG
 /DPQ==
X-Gm-Message-State: AOJu0Yw+DJNFMgxp7aUQfAIL+Or/kP00jVIzfjDAjUppNaEpKIl09jhr
 zSnHUjOyBdp/59Oy9lVdEknp2dX1eClQoJbas5pNUcbtwo9fEXxWB4S3jWft1jwA//E=
X-Gm-Gg: ASbGncsTGTx9oG6rZTT+mlX7CZXkNeGyJOyDaORNBPNykk/+5l7KPrO9PB7C9fpWhuN
 VfE3YASTSM66LXIFWH5bBJP1Iwv1BXgk1Y9rdXh8hwhNrs8joLleA52nYh88zhh90Il30AnAyky
 lvvby8oTQFoDwO1pR3gTjZ//umTjl8rD2FKAEYpXOKjlPawXAnvnv3k2REIguT/XsSdyrnp5B3b
 0gIHGJQdcxjxhePYpHvRVqFeDOQ6DjH/twAipkne0A39PWRyxLILrFGXEePBJ1ahGc/go4fO8lR
 xb8WMqNbEg76a1Q0JaUtvolcAPifTf3Fewaw5NAF20H714nPx9Xvs2PHV2yzM8S2MLpTb8WTMfh
 x0xX2dzzgWS1hQmNpBSZasG6hl34xPUDZExEoyVycmg3Gxp997tu+jY/ES22FCvEPLLQCtsCcmq
 EiqC7FRyi8OaN15xn+Qw==
X-Google-Smtp-Source: AGHT+IEcMeHABSeBPh3y847d5XbHnyeJNJotx9lxm/sMBjNKxOgRXQyLD72pca+yYeTSr1txRHSerA==
X-Received: by 2002:a05:600c:3213:b0:477:7588:c8cc with SMTP id
 5b1f17b1804b1-477b9ea924fmr225256835e9.7.1764325042168; 
 Fri, 28 Nov 2025 02:17:22 -0800 (PST)
Received: from localhost ([2001:4090:a247:809c:875a:7c11:12fc:ed9])
 by smtp.gmail.com with UTF8SMTPSA id
 ffacd0b85a97d-42e1c5c3016sm9037982f8f.1.2025.11.28.02.17.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Nov 2025 02:17:21 -0800 (PST)
From: "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>
Date: Fri, 28 Nov 2025 11:16:59 +0100
Subject: [PATCH 1/2] clk: ti: Split common omap2plus functions into new symbol
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251128-topic-am33-clk-regmap-dep-v2026-01-v1-1-d722c79506b2@baylibre.com>
References: <20251128-topic-am33-clk-regmap-dep-v2026-01-v1-0-d722c79506b2@baylibre.com>
In-Reply-To: <20251128-topic-am33-clk-regmap-dep-v2026-01-v1-0-d722c79506b2@baylibre.com>
To: u-boot@lists.denx.de
Cc: Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, 
 Tom Rini <trini@konsulko.com>, Quentin Schulz <quentin.schulz@cherry.de>, 
 Yegor Yefremov <yegorslists@googlemail.com>, 
 Sjoerd Simons <sjoerd.simons@collabora.co.uk>, 
 Govindaraji Sivanantham <Govindaraji.Sivanantham@in.bosch.com>, 
 Hiremath Gireesh <Gireesh.Hiremath@in.bosch.com>, 
 "Andrew F. Davis" <afd@ti.com>, 
 =?utf-8?q?Javier_Mart=C3=ADnez_Canillas?= <javier@dowhile0.org>, 
 Felix Brack <fb@ltec.ch>, Heiko Schocher <hs@nabladev.com>, 
 Enric Balletbo i Serra <enric.balletbo@collabora.com>, 
 Adam Ford <aford173@gmail.com>, 
 Wolfgang Wallner <wolfgang.wallner@br-automation.com>, 
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>, 
 Marcin Niestroj <m.niestroj@grinn-global.com>, 
 Nikita Kiryanov <nikita@compulab.co.il>, Thomas Weber <weber@corscience.de>, 
 Enrico Leto <enrico.leto@siemens.com>, 
 "Derald D. Woods" <woods.technical@gmail.com>, 
 "Matwey V. Kornilov" <matwey.kornilov@gmail.com>, 
 Niel Fourie <lusus@denx.de>, Parthiban Nallathambi <parthiban@linumiz.com>, 
 Paul Kocialkowski <contact@paulk.fr>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Romain Gantois <romain.gantois@bootlin.com>, 
 Kory Maincent <kory.maincent@bootlin.com>, 
 Tomas Peterka <atheiste@seznam.cz>, Anurag Dutta <a-dutta@ti.com>, 
 Fabio Estevam <festevam@gmail.com>, Anshul Dalal <anshuld@ti.com>, 
 Peter Robinson <pbrobinson@gmail.com>, 
 "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2739; i=msp@baylibre.com;
 h=from:subject:message-id; bh=tgUw9sSIkGlRVrN8EVRb2F/Ry/EuBrG6+ouccXIxLeo=;
 b=owGbwMvMwCXWejAsc4KoVzDjabUkhkzNsqVZHDPaIjijPfd5nTIy5Nz9XE9jeWGVR0lUy/ZF3
 f7rVpl0lLIwiHExyIopsnQmhqb9l995LHnRss0wc1iZQIYwcHEKwESqmxkZDvesNs64s19RZsWB
 DDbGh1+/vsz/UrPecJLPxWPm9SfEeRn+5zpsrExYdVLKny+9ae6WMlZW1kvL3fLtXE4ltM3zd27
 nAAA=
X-Developer-Key: i=msp@baylibre.com; a=openpgp;
 fpr=BADD88DB889FDC3E8A3D5FE612FA6A01E0A45B41
X-Mailman-Approved-At: Fri, 28 Nov 2025 15:13:26 +0100
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

Create a new symbol for the common clock functions used by some of the
omap2plus clock drivers. These drivers now select this new symbol when
they need the functions. Note these common functions are not
ARCH_OMAP2PLUS specific.

Note that the common functions are using regmap, so select it here.

Signed-off-by: Markus Schneider-Pargmann (TI.com) <msp@baylibre.com>
---
 drivers/clk/ti/Kconfig  | 11 +++++++++++
 drivers/clk/ti/Makefile |  3 ++-
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/ti/Kconfig b/drivers/clk/ti/Kconfig
index fdda283d6d374b28230c68a8b29720184680c67b..7b8da69712e4fa61c15f3fb0cbdc9f3fd8de31bb 100644
--- a/drivers/clk/ti/Kconfig
+++ b/drivers/clk/ti/Kconfig
@@ -3,9 +3,17 @@
 # Copyright (C) 2020 Dario Binacchi <dariobin@libero.it>
 #
 
+config CLK_TI_OMAP2PLUS
+	bool
+	depends on CLK
+	select REGMAP
+	help
+	  Common clock functions used in some TI clock drivers.
+
 config CLK_TI_AM3_DPLL
 	bool "TI AM33XX Digital Phase-Locked Loop (DPLL) clock drivers"
 	depends on CLK && OF_CONTROL && ARCH_OMAP2PLUS
+	select CLK_TI_OMAP2PLUS
 	help
 	  This enables the DPLL clock drivers support on AM33XX SoCs. The DPLL
 	  provides all interface clocks and functional clocks to the processor.
@@ -19,18 +27,21 @@ config CLK_TI_CTRL
 config CLK_TI_DIVIDER
 	bool "TI divider clock driver"
 	depends on CLK && OF_CONTROL && CLK_CCF
+	select CLK_TI_OMAP2PLUS
 	help
 	  This enables the divider clock driver support on TI's SoCs.
 
 config CLK_TI_GATE
 	bool "TI gate clock driver"
 	depends on CLK && OF_CONTROL
+	select CLK_TI_OMAP2PLUS
 	help
 	  This enables the gate clock driver support on TI's SoCs.
 
 config CLK_TI_MUX
 	bool "TI mux clock driver"
 	depends on CLK && OF_CONTROL && CLK_CCF
+	select CLK_TI_OMAP2PLUS
 	help
 	  This enables the mux clock driver support on TI's SoCs.
 
diff --git a/drivers/clk/ti/Makefile b/drivers/clk/ti/Makefile
index a58f19f46d9f189e9394e756a5cf7bd32480287d..329fae67889b11a9ef3c646b166243abcb956144 100644
--- a/drivers/clk/ti/Makefile
+++ b/drivers/clk/ti/Makefile
@@ -3,13 +3,14 @@
 # Copyright (C) 2020 Dario Binacchi <dariobin@libero.it>
 #
 
-obj-$(CONFIG_ARCH_OMAP2PLUS) += clk.o omap4-cm.o
+obj-$(CONFIG_ARCH_OMAP2PLUS) += omap4-cm.o
 
 obj-$(CONFIG_CLK_TI_AM3_DPLL) += clk-am3-dpll.o clk-am3-dpll-x2.o
 obj-$(CONFIG_CLK_TI_CTRL) += clk-ctrl.o
 obj-$(CONFIG_CLK_TI_DIVIDER) += clk-divider.o
 obj-$(CONFIG_CLK_TI_GATE) += clk-gate.o
 obj-$(CONFIG_CLK_TI_MUX) += clk-mux.o
+obj-$(CONFIG_CLK_TI_OMAP2PLUS) += clk.o
 obj-$(CONFIG_CLK_TI_SCI) += clk-sci.o
 obj-$(CONFIG_$(PHASE_)CLK_K3_PLL) += clk-k3-pll.o
 obj-$(CONFIG_$(PHASE_)CLK_K3) += clk-k3.o

-- 
2.51.0

