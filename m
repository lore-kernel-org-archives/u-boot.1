Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABD97C43458
	for <u-boot@archiver.kernel.org>; Mon, 13 Jul 2026 13:22:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8B1F184BB2;
	Mon, 13 Jul 2026 15:21:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="n+0J+Z3J";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A447884A4B; Mon, 13 Jul 2026 08:43:57 +0200 (CEST)
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com
 [IPv6:2001:4860:4864:20::2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 84BA784A49
 for <u-boot@lists.denx.de>; Mon, 13 Jul 2026 08:43:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=james.hilliard1@gmail.com
Received: by mail-oa1-x2a.google.com with SMTP id
 586e51a60fabf-44856d185bcso1534623fac.3
 for <u-boot@lists.denx.de>; Sun, 12 Jul 2026 23:43:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783925034; x=1784529834; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=O7Q3E5koZI/qBjSbZlBOEVkl/RbDviEV4YXV6llWwXM=;
 b=n+0J+Z3JVNr89sFKVG99sPc3fCXKjj5u3rde+vzVK3gUJ4x5QryG7SrvE5b5ebAef/
 G5/oQxql9BeQKbrW51YjWjNddmEKsnXlhqW3FtWWqKeylHXnFReLCCHofWNpCmRt7LzP
 3pIDqxfpvIdwxyIeUenzlcLlJpGjNWWJ2bqcCJ9ttVA7TSBidjRIwvNG8ZP2pgdGakkI
 vzEHEkNdrUKbHLm6CtcldhRZ82ib08O2Uus3Q9cI/2c5/Bss9DT9joQuCeioC9d/mtJC
 6uXKXgZxEhppboZWnKA/FbJIovVNGUn0W15lxkEkqenqngReMox2MQImnGCSKRteZ6mu
 xQdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783925034; x=1784529834;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=O7Q3E5koZI/qBjSbZlBOEVkl/RbDviEV4YXV6llWwXM=;
 b=BhFGf6hI1Z/rQ7QiLQjVTr5fXZ+JFE2B5onBX6eXEFO9SbqRGt7KFbKOmWy8JoVLuf
 P4Vn8UN6QJMlqPlrpGnt/tIOYamxW2TWuspjkqGniRJeqwUtvEjWvfbHK9CFApeYUyVY
 51Kf1j6L4Yy37ocSdBDETeK21EuMI5EaTWNejpcRxOOJFjfjcSYPIRANstwfQsd6DhMp
 yv52YBOYukXAEmlgZydfHNtAiqLpQiDbIlWD2pG23y1ZqFU24at9PN5s33GY49q4FKoa
 fsPbkGeL0Hy/H8IOUKZpEObon5dzCzuCdT4dTqvSTcUZd8rAAr+ucrR37x1dU3zxa2++
 7YyQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RrYN5igULeBjewJFM0Wt3Usy9xxWBaVQ8fUpayvCfRiCUFN4MfS4bFQIAoHuyXQRw2odkg0zC4=@lists.denx.de
X-Gm-Message-State: AOJu0YysVw+rgE2bHLoxxSeST7kn6UtgoRY/tehsS86H37UoRYTBDVxR
 TqVdvZOoUIw5dv+heils3kIzahSNyXZX8Swzyc6uKBBYEWsNFswtILkv
X-Gm-Gg: AfdE7ckBh+Fl1aKv0Ux6C/HDBnlsKxDhhmTtKrhW0q8KydFzrnqcsjrkvu4cIE6U8Vz
 PgepNvBr5pxLQxL4mJ5jLuAxoW5/uIGNWteN6O7lbMp+cAYGHP4aAxN9l4qnHvCLJLzjSjbUneG
 +mWHkNoH6XY8aqtrPGntIGGxQLDJRQekt0pn8W13ExxkPE33wFLN31+oyRNTVDnGkltQhfc/KZE
 84ZNT3JuMlI57vwLa8aN/cRoE+qJewgegX10mp1mRu9S4NeqnfSuFKL1QrwwNbvO7DWdaUN1i57
 TGHWiROB0efxh7CkRQBeBwOWaI4eZRUB+248/gZDC9ztO+M52Aa6/IfcaT7dASmj/i8EuTRREYZ
 DOCNlgVOUewby5si5ZfbzpWLUBF53Xvq2xx+b1G6WDcU96g0P5h4P0NWNloIiCfK7+RkjxpPWCJ
 Wh8DjvUXZkdJkbbA55R7WgDSmmHcKdycIikqe+8agSXE6fG/ebE64iU94j8J+EvTrqNqOVmxP2Q
 42q2J0gaAQJ+YbqygjYFVTkKF9SpSCGqWb4757IljjrOLBkXxYxJzwqq4MauL2kDgu5xQo7sm0=
X-Received: by 2002:a05:6870:2ce:b0:43e:942:dfab with SMTP id
 586e51a60fabf-451f1483d85mr4227576fac.33.1783925034153; 
 Sun, 12 Jul 2026 23:43:54 -0700 (PDT)
Received: from [127.0.1.1] (174-29-11-8.hlrn.qwest.net. [174.29.11.8])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-451916ce98dsm12538126fac.13.2026.07.12.23.43.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 12 Jul 2026 23:43:53 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Mon, 13 Jul 2026 00:43:07 -0600
Subject: [PATCH v4 10/14] clk: sunxi: add H6/H616 CE gates and reset
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260713-submit-ce-series-v2-v4-10-ff7edc705b8a@gmail.com>
References: <20260713-submit-ce-series-v2-v4-0-ff7edc705b8a@gmail.com>
In-Reply-To: <20260713-submit-ce-series-v2-v4-0-ff7edc705b8a@gmail.com>
To: Svyatoslav Ryhel <clamor95@gmail.com>, Ion Agorria <ion@agorria.com>, 
 u-boot@lists.denx.de, Aspeed BMC SW team <BMC-SW@aspeedtech.com>, 
 Joel Stanley <joel@jms.id.au>
Cc: Chen-Yu Tsai <wens@kernel.org>, Samuel Holland <samuel@sholland.org>, 
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Thierry Reding <treding@nvidia.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Rasmus Villemoes <ravi@prevas.dk>, Aristo Chen <aristo.chen@canonical.com>, 
 Anton Ivanov <anton@binarly.io>, Daniel Golle <daniel@makrotopia.org>, 
 Francois Berder <fberder@outlook.fr>, Peng Fan <peng.fan@nxp.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Randolph Sapp <rs@ti.com>, 
 Jonas Karlman <jonas@kwiboo.se>, 
 Wolfgang Wallner <wolfgang.wallner@at.abb.com>, 
 Alexey Charkov <alchark@gmail.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Heiko Schocher <hs@nabladev.com>, 
 "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>, 
 Anshul Dalal <anshuld@ti.com>, Johan Jonker <jbx6244@gmail.com>, 
 Francesco Valla <francesco@valla.it>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Michael Walle <mwalle@kernel.org>, 
 Andre Przywara <andre.przywara@arm.com>, Lukasz Majewski <lukma@denx.de>, 
 Richard Genoud <richard.genoud@bootlin.com>, 
 Michael Trimarchi <michael@amarulasolutions.com>, 
 E Shattow <e@freeshell.de>, Enric Balletbo i Serra <eballetbo@kernel.org>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Lucas Dietrich <ld.adecy@gmail.com>, David Lechner <dlechner@baylibre.com>, 
 Julien Stephan <jstephan@baylibre.com>, 
 Kuan-Wei Chiu <visitorckw@gmail.com>, 
 Bastien Curutchet <bastien.curutchet@bootlin.com>, 
 Raymond Mao <raymond.mao@riscstar.com>, 
 Ryan Chen <ryan_chen@aspeedtech.com>, 
 Chia-Wei Wang <chiawei_wang@aspeedtech.com>, 
 "Lucien.Jheng" <lucienzx159@gmail.com>, 
 Mateusz Furdyna <mateusz.furdyna@nokia.com>, 
 Dinesh Maniyam <dinesh.maniyam@altera.com>, 
 Heiko Stuebner <heiko@sntech.de>, 
 James Hilliard <james.hilliard1@gmail.com>
X-Mailer: b4 0.15.2
X-Mailman-Approved-At: Mon, 13 Jul 2026 15:20:59 +0200
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

Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
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

