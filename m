Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 919FFCCD1BF
	for <u-boot@archiver.kernel.org>; Tue, 28 Oct 2025 09:16:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 79C1183B80;
	Tue, 28 Oct 2025 10:14:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="W5PVaz5K";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 321BA83B7F; Tue, 28 Oct 2025 10:14:40 +0100 (CET)
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2716B83B27
 for <u-boot@lists.denx.de>; Tue, 28 Oct 2025 10:14:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=richard.genoud@bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-02.galae.net (Postfix) with ESMTPS id D584B1A16ED;
 Tue, 28 Oct 2025 09:14:32 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id AB3E1606AB;
 Tue, 28 Oct 2025 09:14:32 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 3179A102F4AB5; Tue, 28 Oct 2025 10:14:28 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1761642871; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding:in-reply-to:references;
 bh=OS8Pf65Ff4vXOv6jCw46GRTyX2/rYoufOGlrXj4okY8=;
 b=W5PVaz5KLtlRPEKLJwzM91dqx+4uCZkkbKqkHsEvTb6tR5zZNm7tE31nPFKtyjBZiPBJcu
 Za0rg7BjeQvKq573CSp3ZGL/w58eBO1qmwDrUoqFYrmGYRwTCqTC3anc92gbl1/fZVudWK
 5QhBnytUh8xQhWTOBMERpWI5aSeHER7xj8s3DdEhjEDvEvxSnM66G3EJn5Xni1lsXbQEnu
 YHT+9GqW2GfrfcjvTEiByG7Elate9/tSi2CsEgp8LflHkXXmMYcnY2LBrTJ795REgT1W7I
 qPzsJ78ZB4sWCuiK0nnwvMD00O29KejStxJxhABa80dBoe0fByXBCzrGwLw3+w==
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
Subject: [PATCH v2 21/24] clk: sunxi: Add MBUS Master Clock Gating Register
Date: Tue, 28 Oct 2025 10:12:42 +0100
Message-ID: <20251028091256.600992-22-richard.genoud@bootlin.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251028091256.600992-1-richard.genoud@bootlin.com>
References: <20251028091256.600992-1-richard.genoud@bootlin.com>
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
-- 
2.47.3

