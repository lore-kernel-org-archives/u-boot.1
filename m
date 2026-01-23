Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D28FD7236C
	for <u-boot@archiver.kernel.org>; Fri, 23 Jan 2026 11:48:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BED6483C5E;
	Fri, 23 Jan 2026 12:46:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="vl8+00JW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A0A9B83B0B; Fri, 23 Jan 2026 12:46:35 +0100 (CET)
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4B69283CB9
 for <u-boot@lists.denx.de>; Fri, 23 Jan 2026 12:46:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=richard.genoud@bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-04.galae.net (Postfix) with ESMTPS id 39703C214FC;
 Fri, 23 Jan 2026 11:46:33 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 013AD6070A;
 Fri, 23 Jan 2026 11:46:33 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 560F7119A83E7; Fri, 23 Jan 2026 12:46:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1769168791; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding:in-reply-to:references;
 bh=XUnThcKko5nJMgCwARUFtQkDLkJun3NhL0xa5q29MXA=;
 b=vl8+00JW0hV+W7Ur9bjo7H+lLCbNZLxFG+IqBzI4M8Q6sOp0R8w0Yz9bQ1Nq/VeN6T5HTw
 GNvMwoO38P4jPjixoBI6Jt4DJkiagdEA1K+8kKPrOpLb+YGD1cdr69i9YQVj0kT+FLTIl8
 dppNojAGSG0r9cSJd5ZZsed1A27OF1koLvGtO/VWeH9QLEq5Z1BMBBzHyCHyoT9Y5+3Dq+
 UyH+VP6SZhgDQXY1jZX9ACf3SEuDnTjeSI3Px4R6MlZ9m5JyaZ97YtgoJXKd1VfPQXv3/f
 DsfIFsRbFCujIvbWWXegNhmOn6OEEZ+F7dySZus1/+EfR3r6ExJY6PmSQ8JiJg==
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
Subject: [PATCH v3 20/26] sunxi: clock: H6: add NAND controller clock registers
Date: Fri, 23 Jan 2026 12:44:55 +0100
Message-ID: <20260123114507.1400918-21-richard.genoud@bootlin.com>
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

