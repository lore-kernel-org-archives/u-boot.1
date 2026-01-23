Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 345F1D7236C
	for <u-boot@archiver.kernel.org>; Fri, 23 Jan 2026 11:48:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6F54083D6C;
	Fri, 23 Jan 2026 12:46:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="dMUTFDsU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CD42E83D17; Fri, 23 Jan 2026 12:46:39 +0100 (CET)
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 11E2C83CD3
 for <u-boot@lists.denx.de>; Fri, 23 Jan 2026 12:46:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=richard.genoud@bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id A9CF44E42214;
 Fri, 23 Jan 2026 11:46:36 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 7A5856070A;
 Fri, 23 Jan 2026 11:46:36 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 1B42B119A87BE; Fri, 23 Jan 2026 12:46:32 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1769168794; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding:in-reply-to:references;
 bh=OS8Pf65Ff4vXOv6jCw46GRTyX2/rYoufOGlrXj4okY8=;
 b=dMUTFDsUBX4NIO1y6XOSuo/+Z16mzEOlN/QccU8YwnyoxdpVgGRI7SdxwqiuUa6xUoslII
 b3USqDYB9HQwfL08De+o2C46hbMx5vXLqpvjNsu/0DrWnxbNM4dqhf+nYENpp4cWNkWzrY
 VDUOsVQVtzJigvORo9Wx0xvSutIozOzaVwqKfuU0erYSSFBMcwzY/yMTp9I2UTxbs1TqMa
 o8sMIJb2JWvFNOxIGPM21RySD4tE+iq5AeQ94XhZVcoTruGxCev7BOzOMWfNvyEoEhdb1U
 oDmoV1j/cBJt6S6KSZd2VOv1fwKv+IvEh+KOpwE3RTcwI3ARbsdrt20AtDHApA==
From: Richard Genoud <richard.genoud@bootlin.com>
To: Jagan Teki <jagan@amarulasolutions.com>,
 Andre Przywara <andre.przywara@arm.com>, Tom Rini <trini@konsulko.com>,
 Hans de Goede <hdegoede@redhat.com>, Lukasz Majewski <lukma@denx.de>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>
Cc: Jernej Skrabec <jernej.skrabec@gmail.com>, Chen-Yu Tsai <wens@csie.org>,
 Andrey Skvortsov <andrej.skvortzov@gmail.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 James Hilliard <james.hilliard1@gmail.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Boris Brezillon <bbrezillon@kernel.org>,
 Philip Molloy <philip.molloy@analog.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tien Fong Chee <tien.fong.chee@altera.com>, u-boot@lists.denx.de,
 Richard Genoud <richard.genoud@bootlin.com>
Subject: [PATCH v3 21/26] clk: sunxi: Add MBUS Master Clock Gating Register
Date: Fri, 23 Jan 2026 12:44:56 +0100
Message-ID: <20260123114507.1400918-22-richard.genoud@bootlin.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260123114507.1400918-1-richard.genoud@bootlin.com>
References: <20260123114507.1400918-1-richard.genoud@bootlin.com>
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

