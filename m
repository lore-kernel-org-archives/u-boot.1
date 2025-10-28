Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B000CCF9E0
	for <u-boot@archiver.kernel.org>; Tue, 28 Oct 2025 09:16:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 30EBD83B5B;
	Tue, 28 Oct 2025 10:14:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="dWOCv7vP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7A06C83B4A; Tue, 28 Oct 2025 10:14:34 +0100 (CET)
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2B7D583AFD
 for <u-boot@lists.denx.de>; Tue, 28 Oct 2025 10:14:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=richard.genoud@bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id D11814E41395;
 Tue, 28 Oct 2025 09:14:29 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id A746F606AB;
 Tue, 28 Oct 2025 09:14:29 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 9D56C102F4AA4; Tue, 28 Oct 2025 10:14:25 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1761642868; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding:in-reply-to:references;
 bh=XUnThcKko5nJMgCwARUFtQkDLkJun3NhL0xa5q29MXA=;
 b=dWOCv7vPhi4PQNMeSajDvtA79V2UgnFuI2YfkqUfan3CMeCDltBhG+VHfupZyML070tTdo
 4fwKnQpzFduKyB5Z98KFaY8BGCyPa3PQUzRuVuask0ZCApm8cWfZRgAYKkHqHoyypwWHdV
 Zx/AiuPpk9A1tCCKMu0Tc057E+E1pM8x+UtpHghmYjEIvw+DQA6aCZV1zh1ECPPunoDvOr
 2nUXS/9GvlNEy3VU6gcRIfN90r5AmfnPH7U8q7GEgLlM/TaMnJnSRlox8XRyGa34bIsiyF
 sl+utxMVc3qxd7f3Q4r5sdkE7+Cz2beRKpw4h/0x67PN33hhDxteJVfd0qBO0w==
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
Subject: [PATCH v2 20/24] sunxi: clock: H6: add NAND controller clock registers
Date: Tue, 28 Oct 2025 10:12:41 +0100
Message-ID: <20251028091256.600992-21-richard.genoud@bootlin.com>
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

Add missing NAND controller-related clock registers

The NAND controller on H6/H616 uses one clock for its internal logic
(NAND0_CLK) and one clock for ECC engine (NAND1_CLK) in addition to AHB
and MBUS clocks.

As NAND{0,1}_CLKs and MBUS_GATE are missing, add them.

The bit locations are from H616/H6 User Manual.

Signed-off-by: Richard Genoud <richard.genoud@bootlin.com>
---
 .../include/asm/arch-sunxi/clock_sun50i_h6.h  | 24 +++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/arm/include/asm/arch-sunxi/clock_sun50i_h6.h b/arch/arm/include/asm/arch-sunxi/clock_sun50i_h6.h
index 45fa4ab6e57c..8d1c7c185486 100644
--- a/arch/arm/include/asm/arch-sunxi/clock_sun50i_h6.h
+++ b/arch/arm/include/asm/arch-sunxi/clock_sun50i_h6.h
@@ -24,7 +24,11 @@
 #define CCU_H6_APB2_CFG			0x524
 #define CCU_H6_MBUS_CFG			0x540
 #define CCU_H6_DRAM_CLK_CFG		0x800
+#define CCU_H6_MBUS_GATE		0x804
 #define CCU_H6_DRAM_GATE_RESET		0x80c
+#define CCU_NAND0_CLK_CFG		0x810
+#define CCU_NAND1_CLK_CFG		0x814
+#define CCU_H6_NAND_GATE_RESET		0x82c
 #define CCU_MMC0_CLK_CFG		0x830
 #define CCU_MMC1_CLK_CFG		0x834
 #define CCU_MMC2_CLK_CFG		0x838
@@ -146,6 +150,16 @@
 #define RESET_SHIFT			(16)
 #define GATE_SHIFT			(0)
 
+/* MBUS gate offsets */
+#define MBUS_GATE_OFFSET_DI		11
+#define MBUS_GATE_OFFSET_G2D		10
+#define MBUS_GATE_OFFSET_CSI		8
+#define MBUS_GATE_OFFSET_NAND		5
+#define MBUS_GATE_OFFSET_TS0		3
+#define MBUS_GATE_OFFSET_VE		2
+#define MBUS_GATE_OFFSET_CE		1
+#define MBUS_GATE_OFFSET_DMA		0
+
 /* DRAM clock bit field */
 #define DRAM_CLK_ENABLE			BIT(31)
 #define DRAM_MOD_RESET			BIT(30)
@@ -155,6 +169,16 @@
 #define DRAM_CLK_M_MASK			(0x1f)
 #define DRAM_CLK_M(m)			(((m)-1) << 0)
 
+/* NAND clock bit field */
+#define CCM_NAND_CTRL_M(x)		((x) - 1)
+#define CCM_NAND_CTRL_N(x)		((x) << 8)
+#define CCM_NAND_CTRL_OSCM24		(0x0 << 24)
+#define CCM_NAND_CTRL_PLL6		(0x1 << 24)
+#define CCM_NAND_CTRL_PLL_PERIPH2	(0x2 << 24)
+#define CCM_NAND_CTRL_PLL6X2		(0x3 << 24)
+#define CCM_NAND_CTRL_PLL_PERIPH2X2	(0x4 << 24)
+#define CCM_NAND_CTRL_ENABLE		(0x1 << 31)
+
 /* MMC clock bit field */
 #define CCM_MMC_CTRL_M(x)		((x) - 1)
 #define CCM_MMC_CTRL_N(x)		((x) << 8)
-- 
2.47.3

