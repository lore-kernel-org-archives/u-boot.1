Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61F1CC43458
	for <u-boot@archiver.kernel.org>; Thu,  2 Jul 2026 01:48:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 67B8784C6D;
	Thu,  2 Jul 2026 03:47:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Ws025QZY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0F2D684C7A; Thu,  2 Jul 2026 03:47:56 +0200 (CEST)
Received: from mail-oo1-xc33.google.com (mail-oo1-xc33.google.com
 [IPv6:2607:f8b0:4864:20::c33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EC91C84C75
 for <u-boot@lists.denx.de>; Thu,  2 Jul 2026 03:47:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=james.hilliard1@gmail.com
Received: by mail-oo1-xc33.google.com with SMTP id
 006d021491bc7-69d7aa0ac14so954984eaf.3
 for <u-boot@lists.denx.de>; Wed, 01 Jul 2026 18:47:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782956873; x=1783561673; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=G290XVTTsLfc4hehqyB9D6SDN9lMyJPUfVKk3b7BG5w=;
 b=Ws025QZYcAHqyyuQ4AAQUOgppBQydUY83Mn0F6rmpiciO8rk8RihDdl0bKiqXWFkDX
 Hw41VzH8YgMoij0pZ6m9YqSyeN0nV0zoYXusl8xvCYc7jbldQMYIsVGIdkWKV4qS4mfz
 hSUv0f1zcwW2+L7eh2UGoRUWzL1WOCWuXzC84wzXzPUNY6DRneWewASKz+rwrJ5j8RHz
 QRjYanjsD7zSJhwpijOn1S5pMrSFo87NS3XtO6fbbCb2VsEM+25kbRpBpormi2Qk5mI1
 VPreSDT5SmBV23TIq/AfWKp5zOGvZX0nE+fguP30yUhxvVDX4hMpLL8fm44by+jv0Fi4
 elWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782956873; x=1783561673;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=G290XVTTsLfc4hehqyB9D6SDN9lMyJPUfVKk3b7BG5w=;
 b=apIb03XDepPPQOOjspRVsRMgGsXtHCaMipoVjczO6YNdmPmurT1F0ZDbBwbjBGDhQ8
 zqdGJmAZm2tQ5QiIuklEP4MDyk2z54Hc80JuqKRBoWvjOjQtYA5UAle+UIa7ExKxVF/q
 yDDkSDrklgYRZ+OqkthU3vn6VZfgs0rYVKTBAWl2ZxR3JGWxT30FO2XM78BxCQ3o1bD7
 s8p39BKpx96ITQhrJeuN85Qd9AP9PbClsfo+wfrYJ9bB6bFkiveojmkqbNElDZA7xu7+
 vHOM7ViVYIxVrMOlw2pFwaFvk/kD8ScEwYQ+JWnLl6hh3Ojx144uvFoZLMPb5cnXp2e1
 HxKg==
X-Gm-Message-State: AOJu0YweXSu+gFTudDBfNOQGT5uGNej9hEWPN2eUmLGUXhigF4HdSvnZ
 AOoB0QfJPVDGaOjqTVWodCZndZshwRsFIJYwVtRyp+EJCRSY++LVyvmZumY3YGHeEWn+wg==
X-Gm-Gg: AfdE7cmsw52YxzdCn1irW5GSdKNX2UZRqXzmOHhyzWiHDLjFBAuuBzjb+sg0/fvoLcS
 rS3bJM/Qsl+TaIUnu5o/1nm6w4SyrIYokCKnPvtx8cyAZ8AuDuIMHhmyFS9iG+62LVKYi48w+T4
 d/uO4c4MF2w1Xyq2QiRpW5J1/viFYigZuv3BzFl6p0UITNS1LpQibYPNpCXnHqdfyP7Ds5jMGXP
 jc6HXT6x/D/A4m15x2HoBQIRXyWrMg1JNoR678V/qzTMwPX0zcOL97/VKPQOVO2V60fcYt4tqnx
 Aas/H7LRZJBO/w3rLBqNpyOZwYlT7LU6p7FiJnkz1JlVRZygKE/4LFyYgqZVvYLxLTHvXty6Ghq
 g1LbhgyVkThuUFlFq5Kf6EHm2GifrdLUqmzQvtC3juXmGX+3EN59/Wv1g415hZyVOBtxk14BPyC
 Gj4jjErZT+9632yMO08CeI/THhTBo/tx23Ho74MxHN8Q9tkJx8kWbrRiYRaU270OzUhu5B/3hjC
 Oxmrykzo2sQpb/1u56MDdwQFJPlE2X8TAhDeTQMek3PEclbJ43V3/t0bGT2tMxItyNcVIGYEbjI
 c9SJXrbYokppieQ=
X-Received: by 2002:a05:6820:1c85:b0:6a3:12ab:ddec with SMTP id
 006d021491bc7-6a312abea12mr837608eaf.28.1782956872571; 
 Wed, 01 Jul 2026 18:47:52 -0700 (PDT)
Received: from james-x399.tailafd1a.ts.net (97-118-25-163.hlrn.qwest.net.
 [97.118.25.163]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6a310051cfcsm1284511eaf.8.2026.07.01.18.47.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Jul 2026 18:47:51 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
To: u-boot@lists.denx.de
Cc: Andre Przywara <andre.przywara@arm.com>, Chen-Yu Tsai <wens@kernel.org>,
 Samuel Holland <samuel@sholland.org>,
 James Hilliard <james.hilliard1@gmail.com>,
 Lukasz Majewski <lukma@denx.de>, Tom Rini <trini@konsulko.com>,
 Richard Genoud <richard.genoud@bootlin.com>,
 Michael Trimarchi <michael@amarulasolutions.com>
Subject: [PATCH 5/9] clk: sunxi: add H6/H616 CE gates and reset
Date: Wed,  1 Jul 2026 19:46:55 -0600
Message-ID: <20260702014724.1534351-5-james.hilliard1@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260702014724.1534351-1-james.hilliard1@gmail.com>
References: <20260702014724.1534351-1-james.hilliard1@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

