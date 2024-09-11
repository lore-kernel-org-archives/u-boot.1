Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78AB1EE57D7
	for <u-boot@archiver.kernel.org>; Wed, 11 Sep 2024 21:10:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AF83E88BE4;
	Wed, 11 Sep 2024 23:10:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="QPlhCLpR";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="A1jTMtI8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BDA8788BA7; Wed, 11 Sep 2024 23:10:12 +0200 (CEST)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 85D5588B4B
 for <u-boot@lists.denx.de>; Wed, 11 Sep 2024 23:10:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4X3tWQ1zz5z9sGk
 for <u-boot@lists.denx.de>; Wed, 11 Sep 2024 23:10:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1726089010;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JeYx/F4znxzM79cKQqZ7qBpIDy06HUMbdEgKXaGMGGk=;
 b=QPlhCLpRoikXpOwO7tlMsnxLG2Xtfb9iNEXeFiz1wz3Q08HugsnG7YnXMvC7MFDdffpBX3
 tRAf88A+Bt3te4A90qXd1/zodcbJcm5JioQ6PXkiq33cGrHktAePXZpHyVRjo7u2S0X+Dl
 5Q0LxVqD5cSCl4itl5skj4NwUngNRwegoeDdzlabVXEaoovBgzN1j4QKk8BE649a5u4QuF
 t+YZW9GERptbaTzL0ElqdiFWFKp5dbRuVUfUeN9ur8lZRZ1OFVia3n9GYG7mFKBRSlzPlG
 SSS3KI9CA/0azF8ekgla2Xc07q0YXWBR77/0Vy2/WeZZLK+QR9e+ZQbl7kEm2A==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1726089008;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JeYx/F4znxzM79cKQqZ7qBpIDy06HUMbdEgKXaGMGGk=;
 b=A1jTMtI8dlDq7Ae0X+RzBpiIb1Zwrs+Lx806UEFWXI4lJkugRWFiC1Vec6Ss0Kh2FnDq2X
 1AGq7cEli8RbxFLUOsGjPty34Dj3KoGLZlGQzZCBmmohjp7pJ3R8a3BWEUgJb6pBZmVjBe
 MhO1BjG2uUSSv3gVOQw2m958w9EZF62P9HMB3iLG4WBliIGRrJ7BZhJ7m7kA/qTXuqEBYZ
 bL9vhJZEY5puIk4XAFzZeEtUEIpL7CvNAEqzOaFsoL7cNf+eoy9EtTFd05xwYg54uJ5dNG
 gIxKvI0FzoV6v/aeLCAmbaFIxrMSUXQ48AsA4iLnoAm+RLOOmOx8Q+MYODOOaQ==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: [PATCH 2/2] pinctrl: renesas: Synchronize R-Car R8A779H0 V4M PFC
 tables with Linux 6.10.9
Date: Wed, 11 Sep 2024 23:09:39 +0200
Message-ID: <20240911210951.175158-2-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20240911210951.175158-1-marek.vasut+renesas@mailbox.org>
References: <20240911210951.175158-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 5b5bbdcd7220dc75a4c
X-MBO-RS-META: 8ks37pkm4o5rjqgj1mfpgrd6ppduw88r
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

Synchronize R-Car R8A779H0 V4M PFC tables with Linux 6.10.9,
commit 1611860f184a2c9e74ed593948d43657734a7098 .

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
 drivers/pinctrl/renesas/pfc-r8a779h0.c | 219 +++++++++++++++++++++----
 1 file changed, 186 insertions(+), 33 deletions(-)

diff --git a/drivers/pinctrl/renesas/pfc-r8a779h0.c b/drivers/pinctrl/renesas/pfc-r8a779h0.c
index 2f09e767288..bfabf0c379a 100644
--- a/drivers/pinctrl/renesas/pfc-r8a779h0.c
+++ b/drivers/pinctrl/renesas/pfc-r8a779h0.c
@@ -77,10 +77,10 @@
 #define GPSR0_9		F_(MSIOF5_SYNC,		IP1SR0_7_4)
 #define GPSR0_8		F_(MSIOF5_SS1,		IP1SR0_3_0)
 #define GPSR0_7		F_(MSIOF5_SS2,		IP0SR0_31_28)
-#define GPSR0_6		F_(IRQ0,		IP0SR0_27_24)
-#define GPSR0_5		F_(IRQ1,		IP0SR0_23_20)
-#define GPSR0_4		F_(IRQ2,		IP0SR0_19_16)
-#define GPSR0_3		F_(IRQ3,		IP0SR0_15_12)
+#define GPSR0_6		F_(IRQ0_A,		IP0SR0_27_24)
+#define GPSR0_5		F_(IRQ1_A,		IP0SR0_23_20)
+#define GPSR0_4		F_(IRQ2_A,		IP0SR0_19_16)
+#define GPSR0_3		F_(IRQ3_A,		IP0SR0_15_12)
 #define GPSR0_2		F_(GP0_02,		IP0SR0_11_8)
 #define GPSR0_1		F_(GP0_01,		IP0SR0_7_4)
 #define GPSR0_0		F_(GP0_00,		IP0SR0_3_0)
@@ -261,15 +261,16 @@
 #define GPSR7_1		F_(AVB0_AVTP_CAPTURE,	IP0SR7_7_4)
 #define GPSR7_0		F_(AVB0_AVTP_PPS,	IP0SR7_3_0)
 
+
 /* SR0 */
 /* IP0SR0 */		/* 0 */			/* 1 */			/* 2 */		/* 3		4	 5	  6	   7	    8	     9	      A	       B	C	 D	  E	   F */
 #define IP0SR0_3_0	F_(0, 0)		FM(ERROROUTC_N_B)	FM(TCLK2_B)	F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
 #define IP0SR0_7_4	F_(0, 0)		FM(MSIOF3_SS1)		F_(0, 0)	F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
 #define IP0SR0_11_8	F_(0, 0)		FM(MSIOF3_SS2)		F_(0, 0)	F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
-#define IP0SR0_15_12	FM(IRQ3)		FM(MSIOF3_SCK)		F_(0, 0)	F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
-#define IP0SR0_19_16	FM(IRQ2)		FM(MSIOF3_TXD)		F_(0, 0)	F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
-#define IP0SR0_23_20	FM(IRQ1)		FM(MSIOF3_RXD)		F_(0, 0)	F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
-#define IP0SR0_27_24	FM(IRQ0)		FM(MSIOF3_SYNC)		F_(0, 0)	F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
+#define IP0SR0_15_12	FM(IRQ3_A)		FM(MSIOF3_SCK)		F_(0, 0)	F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
+#define IP0SR0_19_16	FM(IRQ2_A)		FM(MSIOF3_TXD)		F_(0, 0)	F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
+#define IP0SR0_23_20	FM(IRQ1_A)		FM(MSIOF3_RXD)		F_(0, 0)	F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
+#define IP0SR0_27_24	FM(IRQ0_A)		FM(MSIOF3_SYNC)		F_(0, 0)	F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
 #define IP0SR0_31_28	FM(MSIOF5_SS2)		F_(0, 0)		F_(0, 0)	F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
 
 /* IP1SR0 */		/* 0 */			/* 1 */			/* 2 */		/* 3		4	 5	  6	   7	    8	     9	      A	       B	C	 D	  E	   F */
@@ -673,16 +674,16 @@ static const u16 pinmux_data[] = {
 
 	PINMUX_IPSR_GPSR(IP0SR0_11_8,	MSIOF3_SS2),
 
-	PINMUX_IPSR_GPSR(IP0SR0_15_12,	IRQ3),
+	PINMUX_IPSR_GPSR(IP0SR0_15_12,	IRQ3_A),
 	PINMUX_IPSR_GPSR(IP0SR0_15_12,	MSIOF3_SCK),
 
-	PINMUX_IPSR_GPSR(IP0SR0_19_16,	IRQ2),
+	PINMUX_IPSR_GPSR(IP0SR0_19_16,	IRQ2_A),
 	PINMUX_IPSR_GPSR(IP0SR0_19_16,	MSIOF3_TXD),
 
-	PINMUX_IPSR_GPSR(IP0SR0_23_20,	IRQ1),
+	PINMUX_IPSR_GPSR(IP0SR0_23_20,	IRQ1_A),
 	PINMUX_IPSR_GPSR(IP0SR0_23_20,	MSIOF3_RXD),
 
-	PINMUX_IPSR_GPSR(IP0SR0_27_24,	IRQ0),
+	PINMUX_IPSR_GPSR(IP0SR0_27_24,	IRQ0_A),
 	PINMUX_IPSR_GPSR(IP0SR0_27_24,	MSIOF3_SYNC),
 
 	PINMUX_IPSR_GPSR(IP0SR0_31_28,	MSIOF5_SS2),
@@ -1237,6 +1238,30 @@ static const unsigned int avb0_mdio_pins[] = {
 static const unsigned int avb0_mdio_mux[] = {
 	AVB0_MDC_MARK, AVB0_MDIO_MARK,
 };
+static const unsigned int avb0_mii_pins[] = {
+	/*
+	 * AVB0_MII_TD0, AVB0_MII_TD1, AVB0_MII_TD2,
+	 * AVB0_MII_TD3, AVB0_MII_RD0, AVB0_MII_RD1,
+	 * AVB0_MII_RD2, AVB0_MII_RD3, AVB0_MII_TXC,
+	 * AVB0_MII_TX_EN, AVB0_MII_TX_ER, AVB0_MII_RXC,
+	 * AVB0_MII_RX_DV, AVB0_MII_RX_ER, AVB0_MII_CRS,
+	 * AVB0_MII_COL
+	 */
+	RCAR_GP_PIN(7, 11), RCAR_GP_PIN(7,  7), RCAR_GP_PIN(7,  6),
+	RCAR_GP_PIN(7,  3), RCAR_GP_PIN(7, 18), RCAR_GP_PIN(7, 17),
+	RCAR_GP_PIN(7, 12), RCAR_GP_PIN(7,  8), RCAR_GP_PIN(7, 15),
+	RCAR_GP_PIN(7, 16), RCAR_GP_PIN(7,  4), RCAR_GP_PIN(7, 19),
+	RCAR_GP_PIN(7, 20), RCAR_GP_PIN(7,  2), RCAR_GP_PIN(7,  1),
+	RCAR_GP_PIN(7,  0),
+};
+static const unsigned int avb0_mii_mux[] = {
+	AVB0_MII_TD0_MARK, AVB0_MII_TD1_MARK, AVB0_MII_TD2_MARK,
+	AVB0_MII_TD3_MARK, AVB0_MII_RD0_MARK, AVB0_MII_RD1_MARK,
+	AVB0_MII_RD2_MARK, AVB0_MII_RD3_MARK, AVB0_MII_TXC_MARK,
+	AVB0_MII_TX_EN_MARK, AVB0_MII_TX_ER_MARK, AVB0_MII_RXC_MARK,
+	AVB0_MII_RX_DV_MARK, AVB0_MII_RX_ER_MARK, AVB0_MII_CRS_MARK,
+	AVB0_MII_COL_MARK,
+};
 static const unsigned int avb0_rgmii_pins[] = {
 	/*
 	 * AVB0_TX_CTL, AVB0_TXC, AVB0_TD0, AVB0_TD1, AVB0_TD2, AVB0_TD3,
@@ -1315,6 +1340,30 @@ static const unsigned int avb1_mdio_pins[] = {
 static const unsigned int avb1_mdio_mux[] = {
 	AVB1_MDC_MARK, AVB1_MDIO_MARK,
 };
+static const unsigned int avb1_mii_pins[] = {
+	/*
+	 * AVB1_MII_TD0, AVB1_MII_TD1, AVB1_MII_TD2,
+	 * AVB1_MII_TD3, AVB1_MII_RD0, AVB1_MII_RD1,
+	 * AVB1_MII_RD2, AVB1_MII_RD3, AVB1_MII_TXC,
+	 * AVB1_MII_TX_EN, AVB1_MII_TX_ER, AVB1_MII_RXC,
+	 * AVB1_MII_RX_DV, AVB1_MII_RX_ER, AVB1_MII_CRS,
+	 * AVB1_MII_COL
+	 */
+	RCAR_GP_PIN(6, 13), RCAR_GP_PIN(6, 12), RCAR_GP_PIN(6, 16),
+	RCAR_GP_PIN(6, 18), RCAR_GP_PIN(6, 15), RCAR_GP_PIN(6, 14),
+	RCAR_GP_PIN(6, 17), RCAR_GP_PIN(6, 19), RCAR_GP_PIN(6,  6),
+	RCAR_GP_PIN(6,  7), RCAR_GP_PIN(6,  4), RCAR_GP_PIN(6,  8),
+	RCAR_GP_PIN(6,  9), RCAR_GP_PIN(6,  5), RCAR_GP_PIN(6, 11),
+	RCAR_GP_PIN(6, 10),
+};
+static const unsigned int avb1_mii_mux[] = {
+	AVB1_MII_TD0_MARK, AVB1_MII_TD1_MARK, AVB1_MII_TD2_MARK,
+	AVB1_MII_TD3_MARK, AVB1_MII_RD0_MARK, AVB1_MII_RD1_MARK,
+	AVB1_MII_RD2_MARK, AVB1_MII_RD3_MARK, AVB1_MII_TXC_MARK,
+	AVB1_MII_TX_EN_MARK, AVB1_MII_TX_ER_MARK, AVB1_MII_RXC_MARK,
+	AVB1_MII_RX_DV_MARK, AVB1_MII_RX_ER_MARK, AVB1_MII_CRS_MARK,
+	AVB1_MII_COL_MARK,
+};
 static const unsigned int avb1_rgmii_pins[] = {
 	/*
 	 * AVB1_TX_CTL, AVB1_TXC, AVB1_TD0, AVB1_TD1, AVB1_TD2, AVB1_TD3,
@@ -1510,7 +1559,7 @@ static const unsigned int hscif0_ctrl_mux[] = {
 	HRTS0_N_MARK, HCTS0_N_MARK,
 };
 
-/* - HSCIF1_A ----------------------------------------------------------------- */
+/* - HSCIF1 ------------------------------------------------------------------- */
 static const unsigned int hscif1_data_a_pins[] = {
 	/* HRX1_A, HTX1_A */
 	RCAR_GP_PIN(0, 15), RCAR_GP_PIN(0, 14),
@@ -1533,7 +1582,6 @@ static const unsigned int hscif1_ctrl_a_mux[] = {
 	HRTS1_N_A_MARK, HCTS1_N_A_MARK,
 };
 
-/* - HSCIF1_B ---------------------------------------------------------------- */
 static const unsigned int hscif1_data_b_pins[] = {
 	/* HRX1_B, HTX1_B */
 	RCAR_GP_PIN(1, 7), RCAR_GP_PIN(1, 6),
@@ -1579,7 +1627,7 @@ static const unsigned int hscif2_ctrl_mux[] = {
 	HRTS2_N_MARK, HCTS2_N_MARK,
 };
 
-/* - HSCIF3_A ----------------------------------------------------------------- */
+/* - HSCIF3 ------------------------------------------------------------------- */
 static const unsigned int hscif3_data_a_pins[] = {
 	/* HRX3_A, HTX3_A */
 	RCAR_GP_PIN(1, 24), RCAR_GP_PIN(1, 28),
@@ -1602,7 +1650,6 @@ static const unsigned int hscif3_ctrl_a_mux[] = {
 	HRTS3_N_A_MARK, HCTS3_N_A_MARK,
 };
 
-/* - HSCIF3_B ----------------------------------------------------------------- */
 static const unsigned int hscif3_data_b_pins[] = {
 	/* HRX3_B, HTX3_B */
 	RCAR_GP_PIN(1, 4), RCAR_GP_PIN(1, 0),
@@ -1661,6 +1708,90 @@ static const unsigned int i2c3_mux[] = {
 	SDA3_MARK, SCL3_MARK,
 };
 
+/* - INTC-EX ---------------------------------------------------------------- */
+static const unsigned int intc_ex_irq0_a_pins[] = {
+	/* IRQ0_A */
+	RCAR_GP_PIN(0, 6),
+};
+static const unsigned int intc_ex_irq0_a_mux[] = {
+	IRQ0_A_MARK,
+};
+static const unsigned int intc_ex_irq0_b_pins[] = {
+	/* IRQ0_B */
+	RCAR_GP_PIN(1, 20),
+};
+static const unsigned int intc_ex_irq0_b_mux[] = {
+	IRQ0_B_MARK,
+};
+
+static const unsigned int intc_ex_irq1_a_pins[] = {
+	/* IRQ1_A */
+	RCAR_GP_PIN(0, 5),
+};
+static const unsigned int intc_ex_irq1_a_mux[] = {
+	IRQ1_A_MARK,
+};
+static const unsigned int intc_ex_irq1_b_pins[] = {
+	/* IRQ1_B */
+	RCAR_GP_PIN(1, 21),
+};
+static const unsigned int intc_ex_irq1_b_mux[] = {
+	IRQ1_B_MARK,
+};
+
+static const unsigned int intc_ex_irq2_a_pins[] = {
+	/* IRQ2_A */
+	RCAR_GP_PIN(0, 4),
+};
+static const unsigned int intc_ex_irq2_a_mux[] = {
+	IRQ2_A_MARK,
+};
+static const unsigned int intc_ex_irq2_b_pins[] = {
+	/* IRQ2_B */
+	RCAR_GP_PIN(0, 13),
+};
+static const unsigned int intc_ex_irq2_b_mux[] = {
+	IRQ2_B_MARK,
+};
+
+static const unsigned int intc_ex_irq3_a_pins[] = {
+	/* IRQ3_A */
+	RCAR_GP_PIN(0, 3),
+};
+static const unsigned int intc_ex_irq3_a_mux[] = {
+	IRQ3_A_MARK,
+};
+static const unsigned int intc_ex_irq3_b_pins[] = {
+	/* IRQ3_B */
+	RCAR_GP_PIN(1, 23),
+};
+static const unsigned int intc_ex_irq3_b_mux[] = {
+	IRQ3_B_MARK,
+};
+
+static const unsigned int intc_ex_irq4_a_pins[] = {
+	/* IRQ4_A */
+	RCAR_GP_PIN(1, 17),
+};
+static const unsigned int intc_ex_irq4_a_mux[] = {
+	IRQ4_A_MARK,
+};
+static const unsigned int intc_ex_irq4_b_pins[] = {
+	/* IRQ4_B */
+	RCAR_GP_PIN(2, 3),
+};
+static const unsigned int intc_ex_irq4_b_mux[] = {
+	IRQ4_B_MARK,
+};
+
+static const unsigned int intc_ex_irq5_pins[] = {
+	/* IRQ5 */
+	RCAR_GP_PIN(2, 2),
+};
+static const unsigned int intc_ex_irq5_mux[] = {
+	IRQ5_MARK,
+};
+
 /* - MMC -------------------------------------------------------------------- */
 static const unsigned int mmc_data_pins[] = {
 	/* MMC_SD_D[0:3], MMC_D[4:7] */
@@ -1978,7 +2109,7 @@ static const unsigned int pcie0_clkreq_n_mux[] = {
 	PCIE0_CLKREQ_N_MARK,
 };
 
-/* - PWM0_A ------------------------------------------------------------------- */
+/* - PWM0 --------------------------------------------------------------------- */
 static const unsigned int pwm0_a_pins[] = {
 	/* PWM0_A */
 	RCAR_GP_PIN(1, 15),
@@ -1987,7 +2118,6 @@ static const unsigned int pwm0_a_mux[] = {
 	PWM0_A_MARK,
 };
 
-/* - PWM0_B ------------------------------------------------------------------- */
 static const unsigned int pwm0_b_pins[] = {
 	/* PWM0_B */
 	RCAR_GP_PIN(1, 14),
@@ -1996,7 +2126,7 @@ static const unsigned int pwm0_b_mux[] = {
 	PWM0_B_MARK,
 };
 
-/* - PWM1_A ------------------------------------------------------------------- */
+/* - PWM1 --------------------------------------------------------------------- */
 static const unsigned int pwm1_a_pins[] = {
 	/* PWM1_A */
 	RCAR_GP_PIN(3, 13),
@@ -2005,7 +2135,6 @@ static const unsigned int pwm1_a_mux[] = {
 	PWM1_A_MARK,
 };
 
-/* - PWM1_B ------------------------------------------------------------------- */
 static const unsigned int pwm1_b_pins[] = {
 	/* PWM1_B */
 	RCAR_GP_PIN(2, 13),
@@ -2014,7 +2143,6 @@ static const unsigned int pwm1_b_mux[] = {
 	PWM1_B_MARK,
 };
 
-/* - PWM1_C ------------------------------------------------------------------- */
 static const unsigned int pwm1_c_pins[] = {
 	/* PWM1_C */
 	RCAR_GP_PIN(2, 17),
@@ -2023,7 +2151,7 @@ static const unsigned int pwm1_c_mux[] = {
 	PWM1_C_MARK,
 };
 
-/* - PWM2_A ------------------------------------------------------------------- */
+/* - PWM2 --------------------------------------------------------------------- */
 static const unsigned int pwm2_a_pins[] = {
 	/* PWM2_A */
 	RCAR_GP_PIN(3, 14),
@@ -2032,7 +2160,6 @@ static const unsigned int pwm2_a_mux[] = {
 	PWM2_A_MARK,
 };
 
-/* - PWM2_B ------------------------------------------------------------------- */
 static const unsigned int pwm2_b_pins[] = {
 	/* PWM2_B */
 	RCAR_GP_PIN(2, 14),
@@ -2041,7 +2168,6 @@ static const unsigned int pwm2_b_mux[] = {
 	PWM2_B_MARK,
 };
 
-/* - PWM2_C ------------------------------------------------------------------- */
 static const unsigned int pwm2_c_pins[] = {
 	/* PWM2_C */
 	RCAR_GP_PIN(2, 19),
@@ -2050,7 +2176,7 @@ static const unsigned int pwm2_c_mux[] = {
 	PWM2_C_MARK,
 };
 
-/* - PWM3_A ------------------------------------------------------------------- */
+/* - PWM3 --------------------------------------------------------------------- */
 static const unsigned int pwm3_a_pins[] = {
 	/* PWM3_A */
 	RCAR_GP_PIN(4, 14),
@@ -2059,7 +2185,6 @@ static const unsigned int pwm3_a_mux[] = {
 	PWM3_A_MARK,
 };
 
-/* - PWM3_B ------------------------------------------------------------------- */
 static const unsigned int pwm3_b_pins[] = {
 	/* PWM3_B */
 	RCAR_GP_PIN(2, 15),
@@ -2068,7 +2193,6 @@ static const unsigned int pwm3_b_mux[] = {
 	PWM3_B_MARK,
 };
 
-/* - PWM3_C ------------------------------------------------------------------- */
 static const unsigned int pwm3_c_pins[] = {
 	/* PWM3_C */
 	RCAR_GP_PIN(1, 22),
@@ -2145,7 +2269,7 @@ static const unsigned int scif0_ctrl_mux[] = {
 	RTS0_N_MARK, CTS0_N_MARK,
 };
 
-/* - SCIF1_A ------------------------------------------------------------------ */
+/* - SCIF1 -------------------------------------------------------------------- */
 static const unsigned int scif1_data_a_pins[] = {
 	/* RX1_A, TX1_A */
 	RCAR_GP_PIN(0, 15), RCAR_GP_PIN(0, 14),
@@ -2168,7 +2292,6 @@ static const unsigned int scif1_ctrl_a_mux[] = {
 	RTS1_N_A_MARK, CTS1_N_A_MARK,
 };
 
-/* - SCIF1_B ------------------------------------------------------------------ */
 static const unsigned int scif1_data_b_pins[] = {
 	/* RX1_B, TX1_B */
 	RCAR_GP_PIN(1, 7), RCAR_GP_PIN(1, 6),
@@ -2191,7 +2314,7 @@ static const unsigned int scif1_ctrl_b_mux[] = {
 	RTS1_N_B_MARK, CTS1_N_B_MARK,
 };
 
-/* - SCIF3_A ------------------------------------------------------------------ */
+/* - SCIF3 -------------------------------------------------------------------- */
 static const unsigned int scif3_data_a_pins[] = {
 	/* RX3_A, TX3_A */
 	RCAR_GP_PIN(1, 27), RCAR_GP_PIN(1, 28),
@@ -2214,7 +2337,6 @@ static const unsigned int scif3_ctrl_a_mux[] = {
 	RTS3_N_A_MARK, CTS3_N_A_MARK,
 };
 
-/* - SCIF3_B ------------------------------------------------------------------ */
 static const unsigned int scif3_data_b_pins[] = {
 	/* RX3_B, TX3_B */
 	RCAR_GP_PIN(1, 1), RCAR_GP_PIN(1, 0),
@@ -2293,7 +2415,7 @@ static const unsigned int ssi_ctrl_mux[] = {
 	SSI_SCK_MARK, SSI_WS_MARK,
 };
 
-/* - TPU_A ------------------------------------------------------------------- */
+/* - TPU --------------------------------------------------------------------- */
 static const unsigned int tpu_to0_a_pins[] = {
 	/* TPU0TO0_A */
 	RCAR_GP_PIN(2, 8),
@@ -2323,7 +2445,6 @@ static const unsigned int tpu_to3_a_mux[] = {
 	TPU0TO3_A_MARK,
 };
 
-/* - TPU_B ------------------------------------------------------------------- */
 static const unsigned int tpu_to0_b_pins[] = {
 	/* TPU0TO0_B */
 	RCAR_GP_PIN(1, 25),
@@ -2361,6 +2482,7 @@ static const struct sh_pfc_pin_group pinmux_groups[] = {
 	SH_PFC_PIN_GROUP(avb0_magic),
 	SH_PFC_PIN_GROUP(avb0_phy_int),
 	SH_PFC_PIN_GROUP(avb0_mdio),
+	SH_PFC_PIN_GROUP(avb0_mii),
 	SH_PFC_PIN_GROUP(avb0_rgmii),
 	SH_PFC_PIN_GROUP(avb0_txcrefclk),
 	SH_PFC_PIN_GROUP(avb0_avtp_pps),
@@ -2371,6 +2493,7 @@ static const struct sh_pfc_pin_group pinmux_groups[] = {
 	SH_PFC_PIN_GROUP(avb1_magic),
 	SH_PFC_PIN_GROUP(avb1_phy_int),
 	SH_PFC_PIN_GROUP(avb1_mdio),
+	SH_PFC_PIN_GROUP(avb1_mii),
 	SH_PFC_PIN_GROUP(avb1_rgmii),
 	SH_PFC_PIN_GROUP(avb1_txcrefclk),
 	SH_PFC_PIN_GROUP(avb1_avtp_pps),
@@ -2417,6 +2540,18 @@ static const struct sh_pfc_pin_group pinmux_groups[] = {
 	SH_PFC_PIN_GROUP(i2c2),
 	SH_PFC_PIN_GROUP(i2c3),
 
+	SH_PFC_PIN_GROUP(intc_ex_irq0_a),
+	SH_PFC_PIN_GROUP(intc_ex_irq0_b),
+	SH_PFC_PIN_GROUP(intc_ex_irq1_a),
+	SH_PFC_PIN_GROUP(intc_ex_irq1_b),
+	SH_PFC_PIN_GROUP(intc_ex_irq2_a),
+	SH_PFC_PIN_GROUP(intc_ex_irq2_b),
+	SH_PFC_PIN_GROUP(intc_ex_irq3_a),
+	SH_PFC_PIN_GROUP(intc_ex_irq3_b),
+	SH_PFC_PIN_GROUP(intc_ex_irq4_a),
+	SH_PFC_PIN_GROUP(intc_ex_irq4_b),
+	SH_PFC_PIN_GROUP(intc_ex_irq5),
+
 	BUS_DATA_PIN_GROUP(mmc_data, 1),
 	BUS_DATA_PIN_GROUP(mmc_data, 4),
 	BUS_DATA_PIN_GROUP(mmc_data, 8),
@@ -2533,6 +2668,7 @@ static const char * const avb0_groups[] = {
 	"avb0_magic",
 	"avb0_phy_int",
 	"avb0_mdio",
+	"avb0_mii",
 	"avb0_rgmii",
 	"avb0_txcrefclk",
 	"avb0_avtp_pps",
@@ -2545,6 +2681,7 @@ static const char * const avb1_groups[] = {
 	"avb1_magic",
 	"avb1_phy_int",
 	"avb1_mdio",
+	"avb1_mii",
 	"avb1_rgmii",
 	"avb1_txcrefclk",
 	"avb1_avtp_pps",
@@ -2630,6 +2767,20 @@ static const char * const i2c3_groups[] = {
 	"i2c3",
 };
 
+static const char * const intc_ex_groups[] = {
+	"intc_ex_irq0_a",
+	"intc_ex_irq0_b",
+	"intc_ex_irq1_a",
+	"intc_ex_irq1_b",
+	"intc_ex_irq2_a",
+	"intc_ex_irq2_b",
+	"intc_ex_irq3_a",
+	"intc_ex_irq3_b",
+	"intc_ex_irq4_a",
+	"intc_ex_irq4_b",
+	"intc_ex_irq5",
+};
+
 static const char * const mmc_groups[] = {
 	"mmc_data1",
 	"mmc_data4",
@@ -2814,6 +2965,8 @@ static const struct sh_pfc_function pinmux_functions[] = {
 	SH_PFC_FUNCTION(i2c2),
 	SH_PFC_FUNCTION(i2c3),
 
+	SH_PFC_FUNCTION(intc_ex),
+
 	SH_PFC_FUNCTION(mmc),
 
 	SH_PFC_FUNCTION(msiof0),
-- 
2.45.2

