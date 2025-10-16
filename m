Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BD8DCCD199
	for <u-boot@archiver.kernel.org>; Thu, 16 Oct 2025 14:31:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DD6E6838CE;
	Thu, 16 Oct 2025 16:30:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="ulrgMNZt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8060783923; Thu, 16 Oct 2025 16:30:00 +0200 (CEST)
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B7CA183935
 for <u-boot@lists.denx.de>; Thu, 16 Oct 2025 16:29:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=richard.genoud@bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-02.galae.net (Postfix) with ESMTPS id 712CB1A1441;
 Thu, 16 Oct 2025 14:29:49 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 488296062C;
 Thu, 16 Oct 2025 14:29:49 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id A6243102F231B; 
 Thu, 16 Oct 2025 16:29:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1760624988; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding:in-reply-to:references;
 bh=DVfCQjAKbAOQNgUwIFvIS3XdDPfv8OLXX8WE8P5qHK4=;
 b=ulrgMNZtE9xOLvrmg/rj5+P4wUY6Qb2nLyZtIg6/BPqnB0UUbzwZaJ3CFUpbqLFTyH4bxr
 JuX+fmesBv4FVYrBY7CTu7Pbj/6Z62LoAE6KGLU3Zzrcf0BuZ8WCPRjeZAKtvn3fhRtKSd
 fC5fgCqeZue0CXA1FUoSfvvh9gBrEDHwQTM9suAt6TTt9qHwCYBE52LDfxex4TarCYJTlA
 n969+3MANrNuPrqk1oQ7A3D+9+JyCX0mkLEA5aT3HkUOo2nLphkPm/C21+k1fOQL3n4Ld3
 PLTmvKGUZJLuD6KZ7e5QzfMjBGQcd0VeQQJKgvcNbwYgM27RVAF9tfWwKkQnqw==
From: Richard Genoud <richard.genoud@bootlin.com>
To: Jagan Teki <jagan@amarulasolutions.com>,
 Andre Przywara <andre.przywara@arm.com>, Tom Rini <trini@konsulko.com>,
 Hans de Goede <hdegoede@redhat.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>
Cc: Jernej Skrabec <jernej.skrabec@gmail.com>, Chen-Yu Tsai <wens@csie.org>,
 Andrey Skvortsov <andrej.skvortzov@gmail.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Dinesh Maniyam <dinesh.maniyam@intel.com>,
 Anand Gore <anand.gore@broadcom.com>,
 Linus Walleij <linus.walleij@linaro.org>,
 david regan <dregan@broadcom.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, u-boot@lists.denx.de,
 Richard Genoud <richard.genoud@bootlin.com>
Subject: [PATCH 21/24] clk: sunxi: Add MBUS Master Clock Gating Register
Date: Thu, 16 Oct 2025 16:27:44 +0200
Message-ID: <20251016142752.2627710-22-richard.genoud@bootlin.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251016142752.2627710-1-richard.genoud@bootlin.com>
References: <20251016142752.2627710-1-richard.genoud@bootlin.com>
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

Add MBUS Master Clock Gating Register for H6 and H616

For H6/H616, the NAND controller needs the MBUS NAND clock along with
CLK_NAND0/1 and CLK_BUS_NAND.

The bit locations are from H6/H616 User Manuals.

Signed-off-by: Richard Genoud <richard.genoud@bootlin.com>
---
 drivers/clk/sunxi/clk_h6.c   | 2 ++
 drivers/clk/sunxi/clk_h616.c | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/drivers/clk/sunxi/clk_h6.c b/drivers/clk/sunxi/clk_h6.c
index 1b7bd9dea2f8..81deb5728e5b 100644
--- a/drivers/clk/sunxi/clk_h6.c
+++ b/drivers/clk/sunxi/clk_h6.c
@@ -20,6 +20,8 @@ static struct ccu_clk_gate h6_gates[] = {
 	[CLK_DE]		= GATE(0x600, BIT(31)),
 	[CLK_BUS_DE]		= GATE(0x60c, BIT(0)),
 
+	[CLK_MBUS_NAND]		= GATE(0x804, BIT(5)),
+
 	[CLK_NAND0]		= GATE(0x810, BIT(31)),
 	[CLK_NAND1]		= GATE(0x814, BIT(31)),
 	[CLK_BUS_NAND]		= GATE(0x82c, BIT(0)),
diff --git a/drivers/clk/sunxi/clk_h616.c b/drivers/clk/sunxi/clk_h616.c
index b1e999e18c14..3e7eea25bfe5 100644
--- a/drivers/clk/sunxi/clk_h616.c
+++ b/drivers/clk/sunxi/clk_h616.c
@@ -19,6 +19,8 @@ static struct ccu_clk_gate h616_gates[] = {
 	[CLK_DE]		= GATE(0x600, BIT(31)),
 	[CLK_BUS_DE]		= GATE(0x60c, BIT(0)),
 
+	[CLK_MBUS_NAND]		= GATE(0x804, BIT(5)),
+
 	[CLK_NAND0]		= GATE(0x810, BIT(31)),
 	[CLK_NAND1]		= GATE(0x814, BIT(31)),
 	[CLK_BUS_NAND]		= GATE(0x82c, BIT(0)),
