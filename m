Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F831C43458
	for <u-boot@archiver.kernel.org>; Fri,  3 Jul 2026 08:00:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BE0FE84979;
	Fri,  3 Jul 2026 09:59:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Crc4ss1I";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B0E71849F0; Fri,  3 Jul 2026 03:50:06 +0200 (CEST)
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com
 [IPv6:2001:4860:4864:20::31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 94B6A84A90
 for <u-boot@lists.denx.de>; Fri,  3 Jul 2026 03:50:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=james.hilliard1@gmail.com
Received: by mail-oa1-x31.google.com with SMTP id
 586e51a60fabf-44ae14b4fd6so5248fac.2
 for <u-boot@lists.denx.de>; Thu, 02 Jul 2026 18:50:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783043402; x=1783648202; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=vtPXZ1AGk7IYRJmDHvSWzcnnbR6bNamkgZ2UhNAFekY=;
 b=Crc4ss1IabqtL8qKTxSIzaVHZrqoOZ7gscmC0L1e8m2fnzzEKXfKjz15Ps+yzpoMhk
 eWZoN7m3DJQ/luwr5kwAiiPBKTx560qal6P/JHjLLJOl9clmTcxcUIvsQddGbue8D+r4
 7pEcI9dudwSpkgPb5of/BPiBHBolOm87ZZ+76yRmCWP2w/GWh3NfDoonIlQalLrYtFiG
 13VXliEjDFfQYfs5Et+kDy9glZKxORdbjvPr8nWsMd7wymt+gJHMnB5l1n1UpNPTxG4V
 nUORW6xUcUqhWQfbm7Dpo3FBPhiRvQXHeEJLTFu/noc0Gh4rShCT1laa3QeDH64SLW3U
 xyYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783043402; x=1783648202;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=vtPXZ1AGk7IYRJmDHvSWzcnnbR6bNamkgZ2UhNAFekY=;
 b=Qc7JfuJeM7sebwWQvLc2FsBr8nBrhoNpuAHfTIbCKrE/4dGjL3qzpx3ocpVJUHe068
 PtFRQ2ZrdiAPZ1LOruTrg/rgpQ8nesW+P1tDT0xv9161B3xj3wHOpLFS7tkVJ83Y4WBY
 DXa68B9ouRgvVBIRIgX6aTXOE7pYv5i3konxiOmiGXimFVxFY8Mghx+rKaKKFug4T7FN
 ad+R6OHyxocSCUkzbRhUCHy7mVladEbahpFpZ/6/NA6jpVbXhxff7HuM4lpYqtezEBR3
 /Gu07KhXWA9JagYnk/iXb0qeZvAOGUPx8Bt0ujfy/vZt0EnSl5uVkyB8uI9N+eYPVV+d
 Ql0w==
X-Gm-Message-State: AOJu0Yx6bwjic4uAJtY7FphZph97AKhI1TUzMY8OF1sdh8kIse6dyMUN
 XNOGjlyyx9go/rj74ZVJU8eiSdJVHC2Zg7eikmd4t184fmT+bRaWDXvq
X-Gm-Gg: AfdE7clr1ZIC72L5DaCsydm0tspwe0ZDdCOl/RDUwmoofxzxlpWCx0g7RODuiKQ4lK8
 I43ESWE0EfMYTleeu5XeUeYlvwIc1PQZi8HFQNnUo19t2h3gwNWSmKqmGVoyYpFBIBUVSyCr3RT
 49HFq9gPP4wnQZ9yWFEUfdyqrZCeW4KoVipgJ5yNVvlO3i5roZzHFwkvTQ9Qexk3Uw/XmKXsRYp
 WBLmFcFpZFcvhFjwqlDdFPdZy9i/Vy2sxI3mgwQOPU6738a3TQg71eC74I0N4Zezk/pXxv+dCw3
 CfFiVLXUIX3Aw3fHyWTydyS4LHnJqJOnzHagscHqY5rOdqMPt9TDgulbOQFn2LtvXADh794HvR/
 tKSsQ4gufCLpjE+nzzsEXjCrqUjJDtNt21S+UdkRMVFIdpJz0rbPyQpnT2unbOUi1ohINoHuhK2
 cACcZ6PJkKSvRQrFaNK+gzloTV3PaUEmKvej00EW4zf89JrK74v2ZRI5hvFUurmw46uL3WdDZhZ
 X+HEuA6+AmNQh7Jy7soNWKb3v0lMNgtVC4XY9QXtJWx1t5Sjwe+9mikjH8K8PguQ/qZyg==
X-Received: by 2002:a05:6808:640b:b0:479:ac7d:6d8a with SMTP id
 5614622812f47-4960ef4c140mr6459337b6e.24.1783043402254; 
 Thu, 02 Jul 2026 18:50:02 -0700 (PDT)
Received: from [127.0.1.1] (97-118-25-163.hlrn.qwest.net. [97.118.25.163])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-497d1b43cfcsm2974888b6e.14.2026.07.02.18.50.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Jul 2026 18:50:01 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Thu, 02 Jul 2026 19:49:50 -0600
Subject: [PATCH v2 05/10] clk: sunxi: add H6/H616 CE gates and reset
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260702-submit-ce-series-v2-v2-5-ffda5bed58af@gmail.com>
References: <20260702-submit-ce-series-v2-v2-0-ffda5bed58af@gmail.com>
In-Reply-To: <20260702-submit-ce-series-v2-v2-0-ffda5bed58af@gmail.com>
To: u-boot@lists.denx.de, Svyatoslav Ryhel <clamor95@gmail.com>, 
 Ion Agorria <ion@agorria.com>
Cc: James Hilliard <james.hilliard1@gmail.com>, 
 Chen-Yu Tsai <wens@kernel.org>, Samuel Holland <samuel@sholland.org>, 
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Aristo Chen <aristo.chen@canonical.com>, Anton Ivanov <anton@binarly.io>, 
 Daniel Golle <daniel@makrotopia.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Wolfgang Wallner <wolfgang.wallner@at.abb.com>, Randolph Sapp <rs@ti.com>, 
 Heiko Schocher <hs@nabladev.com>, Alexey Charkov <alchark@gmail.com>, 
 "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>, 
 Peng Fan <peng.fan@nxp.com>, Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Anshul Dalal <anshuld@ti.com>, Rasmus Villemoes <rv@rasmusvillemoes.dk>, 
 Johan Jonker <jbx6244@gmail.com>, Francesco Valla <francesco@valla.it>, 
 Michael Walle <mwalle@kernel.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Andre Przywara <andre.przywara@arm.com>, Lukasz Majewski <lukma@denx.de>, 
 Michael Trimarchi <michael@amarulasolutions.com>, 
 Richard Genoud <richard.genoud@bootlin.com>, 
 Marek Vasut <marek.vasut@mailbox.org>, E Shattow <e@freeshell.de>, 
 Enric Balletbo i Serra <eballetbo@kernel.org>, 
 Lucas Dietrich <ld.adecy@gmail.com>, David Lechner <dlechner@baylibre.com>, 
 Julien Stephan <jstephan@baylibre.com>, 
 Kuan-Wei Chiu <visitorckw@gmail.com>, 
 Raymond Mao <raymond.mao@riscstar.com>, 
 Stefan Roese <stefan.roese@mailbox.org>, 
 Thierry Reding <treding@nvidia.com>, Francois Berder <fberder@outlook.fr>, 
 Jonas Karlman <jonas@kwiboo.se>, 
 Jerome Forissier <jerome.forissier@arm.com>
X-Mailer: b4 0.15.2
X-Mailman-Approved-At: Fri, 03 Jul 2026 09:59:22 +0200
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

The H6 and H616 devicetrees describe the Crypto Engine with module, bus
and MBUS clocks plus a bus reset. Add the corresponding gate and reset
entries so drivers can enable the CE through the normal clock and reset
uclasses in U-Boot proper.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
---
Changes v1 -> v2:
  - Add Simon's Reviewed-by tag
---
 drivers/clk/sunxi/clk_h6.c   | 5 +++++
 drivers/clk/sunxi/clk_h616.c | 5 +++++
 2 files changed, 10 insertions(+)

diff --git a/drivers/clk/sunxi/clk_h6.c b/drivers/clk/sunxi/clk_h6.c
index 81deb5728e5..27ed5705a14 100644
--- a/drivers/clk/sunxi/clk_h6.c
+++ b/drivers/clk/sunxi/clk_h6.c
@@ -20,6 +20,10 @@ static struct ccu_clk_gate h6_gates[] = {
 	[CLK_DE]		= GATE(0x600, BIT(31)),
 	[CLK_BUS_DE]		= GATE(0x60c, BIT(0)),
 
+	[CLK_CE]		= GATE(0x680, BIT(31)),
+	[CLK_BUS_CE]		= GATE(0x68c, BIT(0)),
+
+	[CLK_MBUS_CE]		= GATE(0x804, BIT(2)),
 	[CLK_MBUS_NAND]		= GATE(0x804, BIT(5)),
 
 	[CLK_NAND0]		= GATE(0x810, BIT(31)),
@@ -77,6 +81,7 @@ static struct ccu_clk_gate h6_gates[] = {
 
 static struct ccu_reset h6_resets[] = {
 	[RST_BUS_DE]		= RESET(0x60c, BIT(16)),
+	[RST_BUS_CE]		= RESET(0x68c, BIT(16)),
 	[RST_BUS_NAND]		= RESET(0x82c, BIT(16)),
 
 	[RST_BUS_MMC0]		= RESET(0x84c, BIT(16)),
diff --git a/drivers/clk/sunxi/clk_h616.c b/drivers/clk/sunxi/clk_h616.c
index 3e7eea25bfe..d5b659d0bb2 100644
--- a/drivers/clk/sunxi/clk_h616.c
+++ b/drivers/clk/sunxi/clk_h616.c
@@ -19,6 +19,10 @@ static struct ccu_clk_gate h616_gates[] = {
 	[CLK_DE]		= GATE(0x600, BIT(31)),
 	[CLK_BUS_DE]		= GATE(0x60c, BIT(0)),
 
+	[CLK_CE]		= GATE(0x680, BIT(31)),
+	[CLK_BUS_CE]		= GATE(0x68c, BIT(0)),
+
+	[CLK_MBUS_CE]		= GATE(0x804, BIT(2)),
 	[CLK_MBUS_NAND]		= GATE(0x804, BIT(5)),
 
 	[CLK_NAND0]		= GATE(0x810, BIT(31)),
@@ -86,6 +90,7 @@ static struct ccu_clk_gate h616_gates[] = {
 
 static struct ccu_reset h616_resets[] = {
 	[RST_BUS_DE]		= RESET(0x60c, BIT(16)),
+	[RST_BUS_CE]		= RESET(0x68c, BIT(16)),
 	[RST_BUS_NAND]		= RESET(0x82c, BIT(16)),
 
 	[RST_BUS_MMC0]		= RESET(0x84c, BIT(16)),

-- 
2.53.0

