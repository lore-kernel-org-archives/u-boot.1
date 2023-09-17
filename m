Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12CB2CD37B4
	for <u-boot@archiver.kernel.org>; Sun, 17 Sep 2023 14:12:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7E2198691E;
	Sun, 17 Sep 2023 16:09:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="i8Ltp6MK";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="OgA2FM93";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2B67C869CD; Sun, 17 Sep 2023 16:09:23 +0200 (CEST)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0C2BC86611
 for <u-boot@lists.denx.de>; Sun, 17 Sep 2023 16:09:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4RpVCy5KWkz9sWt
 for <u-boot@lists.denx.de>; Sun, 17 Sep 2023 16:09:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1694959758;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LVKEMAl6PMwaKfN0Uw6HgoU12/dccgogdE0dy/ZxYkg=;
 b=i8Ltp6MKrZ2xspVJRK+iDF/Yd7xmaAJ22gf/OZKGu0/wbskce8ygLtdD9kcDag3ok138lm
 a9nLlBVGHxHlr0nRIWRSNEN1aNa+UTAnlVP60pjdyzjSfmX7rxegQbNI0q+A60Rn+u/a6s
 yCDsS7vBwfl+pb0sVBcK0wuQ5ck113Fa6alUCl4uxe0pitJ/87KJ47o2sax2UsU0pEnet8
 QYoKsNcwIrhL58L5EMoOgKUWe4fCEox0uMHJOLLc6CoBVtZDES2KGGeYqWsyQGpLWjUtTb
 QAb5wKEd7uqtEKvYdiTgwpQ6glsPkVbvH038dd9EwOzvyPqVNEpRWiJ6fuaVDg==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1694959756;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LVKEMAl6PMwaKfN0Uw6HgoU12/dccgogdE0dy/ZxYkg=;
 b=OgA2FM93du73ekp0mVvQ1YAMaGXd1OY2jscbK6r+q1A9oX3fhH5X8Myl8P4+foliEro1e9
 yMwWLhZ6O58fvD29ZppzD90qxCrf9H7dykshbiHrypT15r3dfI7pXY/cFOcs7nd0WDFtzP
 eo8WOd5E3k/jQ/S0PUkJYeAS5niTPwVUkYnXpoyzOicJN0/tIVjfm+HYJ4Wn3esYJTp90I
 EM0XnAGG2N5ucKQ9WEDEi0CsTEL9SG4CeoMKiMyvziUhTf28vkduyPKbyWTIenTe+IAGSN
 KBdKA/PYJDPyhn443HZ1Lh4u4jHSdFcX0ExkQ+bIZ3CLRu5f5xl1BaSvGl8BZg==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: [PATCH 18/18] pinctrl: renesas: Synchronize R8A779G0 V4H PFC tables
 with Linux 6.5.3
Date: Sun, 17 Sep 2023 16:08:49 +0200
Message-Id: <20230917140849.379711-18-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20230917140849.379711-1-marek.vasut+renesas@mailbox.org>
References: <20230917140849.379711-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: prs5pqths448trg5os1osny5zws8rmtq
X-MBO-RS-ID: 0d99face765945b2f08
X-Rspamd-Queue-Id: 4RpVCy5KWkz9sWt
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

Synchronize R-Car R8A779G0 V4H PFC tables with Linux 6.5.3,
commit 238589d0f7b421aae18c5704dc931595019fa6c7 .

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
 drivers/pinctrl/renesas/pfc-r8a779g0.c | 1095 +++++++++++++-----------
 1 file changed, 596 insertions(+), 499 deletions(-)

diff --git a/drivers/pinctrl/renesas/pfc-r8a779g0.c b/drivers/pinctrl/renesas/pfc-r8a779g0.c
index 78a91f426d9..20498a1c2f7 100644
--- a/drivers/pinctrl/renesas/pfc-r8a779g0.c
+++ b/drivers/pinctrl/renesas/pfc-r8a779g0.c
@@ -52,6 +52,12 @@
 	PORT_GP_CFG_21(7,	fn, sfx, CFG_FLAGS),					\
 	PORT_GP_CFG_14(8,	fn, sfx, CFG_FLAGS | SH_PFC_PIN_CFG_IO_VOLTAGE_18_33)
 
+#define CPU_ALL_NOGP(fn)								\
+	PIN_NOGP_CFG(VDDQ_AVB0, "VDDQ_AVB0", fn, SH_PFC_PIN_CFG_IO_VOLTAGE_18_25),	\
+	PIN_NOGP_CFG(VDDQ_AVB1, "VDDQ_AVB1", fn, SH_PFC_PIN_CFG_IO_VOLTAGE_18_25),	\
+	PIN_NOGP_CFG(VDDQ_AVB2, "VDDQ_AVB2", fn, SH_PFC_PIN_CFG_IO_VOLTAGE_18_25),	\
+	PIN_NOGP_CFG(VDDQ_TSN0, "VDDQ_TSN0", fn, SH_PFC_PIN_CFG_IO_VOLTAGE_18_25)
+
 /* GPSR0 */
 #define GPSR0_18	F_(MSIOF2_RXD,		IP2SR0_11_8)
 #define GPSR0_17	F_(MSIOF2_SCK,		IP2SR0_7_4)
@@ -159,54 +165,54 @@
 #define GPSR3_0		F_(MMC_SD_D1,		IP0SR3_3_0)
 
 /* GPSR4 */
-#define GPSR4_24	FM(AVS1)
-#define GPSR4_23	FM(AVS0)
-#define GPSR4_22	FM(PCIE1_CLKREQ_N)
-#define GPSR4_21	FM(PCIE0_CLKREQ_N)
-#define GPSR4_20	FM(TSN0_TXCREFCLK)
-#define GPSR4_19	FM(TSN0_TD2)
-#define GPSR4_18	FM(TSN0_TD3)
-#define GPSR4_17	FM(TSN0_RD2)
-#define GPSR4_16	FM(TSN0_RD3)
-#define GPSR4_15	FM(TSN0_TD0)
-#define GPSR4_14	FM(TSN0_TD1)
-#define GPSR4_13	FM(TSN0_RD1)
-#define GPSR4_12	FM(TSN0_TXC)
-#define GPSR4_11	FM(TSN0_RXC)
-#define GPSR4_10	FM(TSN0_RD0)
-#define GPSR4_9		FM(TSN0_TX_CTL)
-#define GPSR4_8		FM(TSN0_AVTP_PPS0)
-#define GPSR4_7		FM(TSN0_RX_CTL)
-#define GPSR4_6		FM(TSN0_AVTP_CAPTURE)
-#define GPSR4_5		FM(TSN0_AVTP_MATCH)
-#define GPSR4_4		FM(TSN0_LINK)
-#define GPSR4_3		FM(TSN0_PHY_INT)
-#define GPSR4_2		FM(TSN0_AVTP_PPS1)
-#define GPSR4_1		FM(TSN0_MDC)
-#define GPSR4_0		FM(TSN0_MDIO)
+#define GPSR4_24	F_(AVS1,		IP3SR4_3_0)
+#define GPSR4_23	F_(AVS0,		IP2SR4_31_28)
+#define GPSR4_22	F_(PCIE1_CLKREQ_N,	IP2SR4_27_24)
+#define GPSR4_21	F_(PCIE0_CLKREQ_N,	IP2SR4_23_20)
+#define GPSR4_20	F_(TSN0_TXCREFCLK,	IP2SR4_19_16)
+#define GPSR4_19	F_(TSN0_TD2,		IP2SR4_15_12)
+#define GPSR4_18	F_(TSN0_TD3,		IP2SR4_11_8)
+#define GPSR4_17	F_(TSN0_RD2,		IP2SR4_7_4)
+#define GPSR4_16	F_(TSN0_RD3,		IP2SR4_3_0)
+#define GPSR4_15	F_(TSN0_TD0,		IP1SR4_31_28)
+#define GPSR4_14	F_(TSN0_TD1,		IP1SR4_27_24)
+#define GPSR4_13	F_(TSN0_RD1,		IP1SR4_23_20)
+#define GPSR4_12	F_(TSN0_TXC,		IP1SR4_19_16)
+#define GPSR4_11	F_(TSN0_RXC,		IP1SR4_15_12)
+#define GPSR4_10	F_(TSN0_RD0,		IP1SR4_11_8)
+#define GPSR4_9		F_(TSN0_TX_CTL,		IP1SR4_7_4)
+#define GPSR4_8		F_(TSN0_AVTP_PPS0,	IP1SR4_3_0)
+#define GPSR4_7		F_(TSN0_RX_CTL,		IP0SR4_31_28)
+#define GPSR4_6		F_(TSN0_AVTP_CAPTURE,	IP0SR4_27_24)
+#define GPSR4_5		F_(TSN0_AVTP_MATCH,	IP0SR4_23_20)
+#define GPSR4_4		F_(TSN0_LINK,		IP0SR4_19_16)
+#define GPSR4_3		F_(TSN0_PHY_INT,	IP0SR4_15_12)
+#define GPSR4_2		F_(TSN0_AVTP_PPS1,	IP0SR4_11_8)
+#define GPSR4_1		F_(TSN0_MDC,		IP0SR4_7_4)
+#define GPSR4_0		F_(TSN0_MDIO,		IP0SR4_3_0)
 
 /* GPSR 5 */
-#define GPSR5_20	FM(AVB2_RX_CTL)
-#define GPSR5_19	FM(AVB2_TX_CTL)
-#define GPSR5_18	FM(AVB2_RXC)
-#define GPSR5_17	FM(AVB2_RD0)
-#define GPSR5_16	FM(AVB2_TXC)
-#define GPSR5_15	FM(AVB2_TD0)
-#define GPSR5_14	FM(AVB2_RD1)
-#define GPSR5_13	FM(AVB2_RD2)
-#define GPSR5_12	FM(AVB2_TD1)
-#define GPSR5_11	FM(AVB2_TD2)
-#define GPSR5_10	FM(AVB2_MDIO)
-#define GPSR5_9		FM(AVB2_RD3)
-#define GPSR5_8		FM(AVB2_TD3)
-#define GPSR5_7		FM(AVB2_TXCREFCLK)
-#define GPSR5_6		FM(AVB2_MDC)
-#define GPSR5_5		FM(AVB2_MAGIC)
-#define GPSR5_4		FM(AVB2_PHY_INT)
-#define GPSR5_3		FM(AVB2_LINK)
-#define GPSR5_2		FM(AVB2_AVTP_MATCH)
-#define GPSR5_1		FM(AVB2_AVTP_CAPTURE)
-#define GPSR5_0		FM(AVB2_AVTP_PPS)
+#define GPSR5_20	F_(AVB2_RX_CTL,		IP2SR5_19_16)
+#define GPSR5_19	F_(AVB2_TX_CTL,		IP2SR5_15_12)
+#define GPSR5_18	F_(AVB2_RXC,		IP2SR5_11_8)
+#define GPSR5_17	F_(AVB2_RD0,		IP2SR5_7_4)
+#define GPSR5_16	F_(AVB2_TXC,		IP2SR5_3_0)
+#define GPSR5_15	F_(AVB2_TD0,		IP1SR5_31_28)
+#define GPSR5_14	F_(AVB2_RD1,		IP1SR5_27_24)
+#define GPSR5_13	F_(AVB2_RD2,		IP1SR5_23_20)
+#define GPSR5_12	F_(AVB2_TD1,		IP1SR5_19_16)
+#define GPSR5_11	F_(AVB2_TD2,		IP1SR5_15_12)
+#define GPSR5_10	F_(AVB2_MDIO,		IP1SR5_11_8)
+#define GPSR5_9		F_(AVB2_RD3,		IP1SR5_7_4)
+#define GPSR5_8		F_(AVB2_TD3,		IP1SR5_3_0)
+#define GPSR5_7		F_(AVB2_TXCREFCLK,	IP0SR5_31_28)
+#define GPSR5_6		F_(AVB2_MDC,		IP0SR5_27_24)
+#define GPSR5_5		F_(AVB2_MAGIC,		IP0SR5_23_20)
+#define GPSR5_4		F_(AVB2_PHY_INT,	IP0SR5_19_16)
+#define GPSR5_3		F_(AVB2_LINK,		IP0SR5_15_12)
+#define GPSR5_2		F_(AVB2_AVTP_MATCH,	IP0SR5_11_8)
+#define GPSR5_1		F_(AVB2_AVTP_CAPTURE,	IP0SR5_7_4)
+#define GPSR5_0		F_(AVB2_AVTP_PPS,	IP0SR5_3_0)
 
 /* GPSR 6 */
 #define GPSR6_20	F_(AVB1_TXCREFCLK,	IP2SR6_19_16)
@@ -271,209 +277,271 @@
 #define GPSR8_0		F_(SCL0,		IP0SR8_3_0)
 
 /* SR0 */
-/* IP0SR0 */		/* 0 */			/* 1 */			/* 2 */		/* 3		4	 5	  6	   7	    8	     9	      A	       B	C	 D	  E	   F */
-#define IP0SR0_3_0	F_(0, 0)		FM(ERROROUTC_B)		FM(TCLK2_A)	F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
-#define IP0SR0_7_4	F_(0, 0)		FM(MSIOF3_SS1)		F_(0, 0)	F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
-#define IP0SR0_11_8	F_(0, 0)		FM(MSIOF3_SS2)		F_(0, 0)	F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
-#define IP0SR0_15_12	FM(IRQ3)		FM(MSIOF3_SCK)		F_(0, 0)	F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
-#define IP0SR0_19_16	FM(IRQ2)		FM(MSIOF3_TXD)		F_(0, 0)	F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
-#define IP0SR0_23_20	FM(IRQ1)		FM(MSIOF3_RXD)		F_(0, 0)	F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
-#define IP0SR0_27_24	FM(IRQ0)		FM(MSIOF3_SYNC)		F_(0, 0)	F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
-#define IP0SR0_31_28	FM(MSIOF5_SS2)		F_(0, 0)		F_(0, 0)	F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
-
-/* IP1SR0 */		/* 0 */			/* 1 */			/* 2 */		/* 3		4	 5	  6	   7	    8	     9	      A	       B	C	 D	  E	   F */
-#define IP1SR0_3_0	FM(MSIOF5_SS1)		F_(0, 0)		F_(0, 0)	F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
-#define IP1SR0_7_4	FM(MSIOF5_SYNC)		F_(0, 0)		F_(0, 0)	F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
-#define IP1SR0_11_8	FM(MSIOF5_TXD)		F_(0, 0)		F_(0, 0)	F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
-#define IP1SR0_15_12	FM(MSIOF5_SCK)		F_(0, 0)		F_(0, 0)	F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
-#define IP1SR0_19_16	FM(MSIOF5_RXD)		F_(0, 0)		F_(0, 0)	F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
-#define IP1SR0_23_20	FM(MSIOF2_SS2)		FM(TCLK1)		FM(IRQ2_A)	F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
-#define IP1SR0_27_24	FM(MSIOF2_SS1)		FM(HTX1)		FM(TX1)		F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
-#define IP1SR0_31_28	FM(MSIOF2_SYNC)		FM(HRX1)		FM(RX1)		F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
-
-/* IP2SR0 */		/* 0 */			/* 1 */			/* 2 */		/* 3		4	 5	  6	   7	    8	     9	      A	       B	C	 D	  E	   F */
-#define IP2SR0_3_0	FM(MSIOF2_TXD)		FM(HCTS1_N)		FM(CTS1_N)	F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
-#define IP2SR0_7_4	FM(MSIOF2_SCK)		FM(HRTS1_N)		FM(RTS1_N)	F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
-#define IP2SR0_11_8	FM(MSIOF2_RXD)		FM(HSCK1)		FM(SCK1)	F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
+/* IP0SR0 */		/* 0 */			/* 1 */			/* 2 */			/* 3		4	 5	  6	   7	    8	     9	      A	       B	C	 D	  E	   F */
+#define IP0SR0_3_0	F_(0, 0)		FM(ERROROUTC_N_B)	FM(TCLK2_A)		F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
+#define IP0SR0_7_4	F_(0, 0)		FM(MSIOF3_SS1)		F_(0, 0)		F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
+#define IP0SR0_11_8	F_(0, 0)		FM(MSIOF3_SS2)		F_(0, 0)		F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
+#define IP0SR0_15_12	FM(IRQ3)		FM(MSIOF3_SCK)		F_(0, 0)		F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
+#define IP0SR0_19_16	FM(IRQ2)		FM(MSIOF3_TXD)		F_(0, 0)		F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
+#define IP0SR0_23_20	FM(IRQ1)		FM(MSIOF3_RXD)		F_(0, 0)		F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
+#define IP0SR0_27_24	FM(IRQ0)		FM(MSIOF3_SYNC)		F_(0, 0)		F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
+#define IP0SR0_31_28	FM(MSIOF5_SS2)		F_(0, 0)		F_(0, 0)		F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
+
+/* IP1SR0 */		/* 0 */			/* 1 */			/* 2 */			/* 3		4	 5	  6	   7	    8	     9	      A	       B	C	 D	  E	   F */
+#define IP1SR0_3_0	FM(MSIOF5_SS1)		F_(0, 0)		F_(0, 0)		F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
+#define IP1SR0_7_4	FM(MSIOF5_SYNC)		F_(0, 0)		F_(0, 0)		F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
+#define IP1SR0_11_8	FM(MSIOF5_TXD)		F_(0, 0)		F_(0, 0)		F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
+#define IP1SR0_15_12	FM(MSIOF5_SCK)		F_(0, 0)		F_(0, 0)		F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
+#define IP1SR0_19_16	FM(MSIOF5_RXD)		F_(0, 0)		F_(0, 0)		F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
+#define IP1SR0_23_20	FM(MSIOF2_SS2)		FM(TCLK1)		FM(IRQ2_A)		F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
+#define IP1SR0_27_24	FM(MSIOF2_SS1)		FM(HTX1)		FM(TX1)			F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
+#define IP1SR0_31_28	FM(MSIOF2_SYNC)		FM(HRX1)		FM(RX1)			F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
+
+/* IP2SR0 */		/* 0 */			/* 1 */			/* 2 */			/* 3		4	 5	  6	   7	    8	     9	      A	       B	C	 D	  E	   F */
+#define IP2SR0_3_0	FM(MSIOF2_TXD)		FM(HCTS1_N)		FM(CTS1_N)		F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
+#define IP2SR0_7_4	FM(MSIOF2_SCK)		FM(HRTS1_N)		FM(RTS1_N)		F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
+#define IP2SR0_11_8	FM(MSIOF2_RXD)		FM(HSCK1)		FM(SCK1)		F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
 
 /* SR1 */
-/* IP0SR1 */		/* 0 */			/* 1 */			/* 2 */		/* 3		4	 5	  6	   7	    8	     9	      A	       B	C	 D	  E	   F */
-#define IP0SR1_3_0	FM(MSIOF1_SS2)		FM(HTX3_A)		FM(TX3)		F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
-#define IP0SR1_7_4	FM(MSIOF1_SS1)		FM(HCTS3_N_A)		FM(RX3)		F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
-#define IP0SR1_11_8	FM(MSIOF1_SYNC)		FM(HRTS3_N_A)		FM(RTS3_N)	F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
-#define IP0SR1_15_12	FM(MSIOF1_SCK)		FM(HSCK3_A)		FM(CTS3_N)	F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
-#define IP0SR1_19_16	FM(MSIOF1_TXD)		FM(HRX3_A)		FM(SCK3)	F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
-#define IP0SR1_23_20	FM(MSIOF1_RXD)		F_(0, 0)		F_(0, 0)	F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
-#define IP0SR1_27_24	FM(MSIOF0_SS2)		FM(HTX1_X)		FM(TX1_X)	F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
-#define IP0SR1_31_28	FM(MSIOF0_SS1)		FM(HRX1_X)		FM(RX1_X)	F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
-
-/* IP1SR1 */		/* 0 */			/* 1 */			/* 2 */		/* 3		4	 5	  6	   7	    8	     9	      A	       B	C	 D	  E	   F */
-#define IP1SR1_3_0	FM(MSIOF0_SYNC)		FM(HCTS1_N_X)		FM(CTS1_N_X)	FM(CANFD5_TX_B)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
-#define IP1SR1_7_4	FM(MSIOF0_TXD)		FM(HRTS1_N_X)		FM(RTS1_N_X)	FM(CANFD5_RX_B)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
-#define IP1SR1_11_8	FM(MSIOF0_SCK)		FM(HSCK1_X)		FM(SCK1_X)	F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
-#define IP1SR1_15_12	FM(MSIOF0_RXD)		F_(0, 0)		F_(0, 0)	F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
-#define IP1SR1_19_16	FM(HTX0)		FM(TX0)			F_(0, 0)	F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
-#define IP1SR1_23_20	FM(HCTS0_N)		FM(CTS0_N)		FM(PWM8_A)	F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
-#define IP1SR1_27_24	FM(HRTS0_N)		FM(RTS0_N)		FM(PWM9_A)	F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
-#define IP1SR1_31_28	FM(HSCK0)		FM(SCK0)		FM(PWM0_A)	F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
-
-/* IP2SR1 */		/* 0 */			/* 1 */			/* 2 */		/* 3		4	 5	  6	   7	    8	     9	      A	       B	C	 D	  E	   F */
-#define IP2SR1_3_0	FM(HRX0)		FM(RX0)			F_(0, 0)	F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
-#define IP2SR1_7_4	FM(SCIF_CLK)		FM(IRQ4_A)		F_(0, 0)	F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
-#define IP2SR1_11_8	FM(SSI_SCK)		FM(TCLK3)		F_(0, 0)	F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
-#define IP2SR1_15_12	FM(SSI_WS)		FM(TCLK4)		F_(0, 0)	F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
-#define IP2SR1_19_16	FM(SSI_SD)		FM(IRQ0_A)		F_(0, 0)	F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
-#define IP2SR1_23_20	FM(AUDIO_CLKOUT)	FM(IRQ1_A)		F_(0, 0)	F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
-#define IP2SR1_27_24	FM(AUDIO_CLKIN)		FM(PWM3_A)		F_(0, 0)	F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
-#define IP2SR1_31_28	F_(0, 0)		FM(TCLK2)		FM(MSIOF4_SS1)	FM(IRQ3_B)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
-
-/* IP3SR1 */		/* 0 */			/* 1 */			/* 2 */		/* 3		4	 5	  6	   7	    8	     9	      A	       B	C	 D	  E	   F */
-#define IP3SR1_3_0	FM(HRX3)		FM(SCK3_A)		FM(MSIOF4_SS2)	F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
-#define IP3SR1_7_4	FM(HSCK3)		FM(CTS3_N_A)		FM(MSIOF4_SCK)	FM(TPU0TO0_A)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
-#define IP3SR1_11_8	FM(HRTS3_N)		FM(RTS3_N_A)		FM(MSIOF4_TXD)	FM(TPU0TO1_A)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
-#define IP3SR1_15_12	FM(HCTS3_N)		FM(RX3_A)		FM(MSIOF4_RXD)	F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
-#define IP3SR1_19_16	FM(HTX3)		FM(TX3_A)		FM(MSIOF4_SYNC)	F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
+/* IP0SR1 */		/* 0 */			/* 1 */			/* 2 */			/* 3		4	 5	  6	   7	    8	     9	      A	       B	C	 D	  E	   F */
+#define IP0SR1_3_0	FM(MSIOF1_SS2)		FM(HTX3_A)		FM(TX3)			F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
+#define IP0SR1_7_4	FM(MSIOF1_SS1)		FM(HCTS3_N_A)		FM(RX3)			F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
+#define IP0SR1_11_8	FM(MSIOF1_SYNC)		FM(HRTS3_N_A)		FM(RTS3_N)		F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
+#define IP0SR1_15_12	FM(MSIOF1_SCK)		FM(HSCK3_A)		FM(CTS3_N)		F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
+#define IP0SR1_19_16	FM(MSIOF1_TXD)		FM(HRX3_A)		FM(SCK3)		F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
+#define IP0SR1_23_20	FM(MSIOF1_RXD)		F_(0, 0)		F_(0, 0)		F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
+#define IP0SR1_27_24	FM(MSIOF0_SS2)		FM(HTX1_X)		FM(TX1_X)		F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
+#define IP0SR1_31_28	FM(MSIOF0_SS1)		FM(HRX1_X)		FM(RX1_X)		F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
+
+/* IP1SR1 */		/* 0 */			/* 1 */			/* 2 */			/* 3		4	 5	  6	   7	    8	     9	      A	       B	C	 D	  E	   F */
+#define IP1SR1_3_0	FM(MSIOF0_SYNC)		FM(HCTS1_N_X)		FM(CTS1_N_X)		FM(CANFD5_TX_B)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
+#define IP1SR1_7_4	FM(MSIOF0_TXD)		FM(HRTS1_N_X)		FM(RTS1_N_X)		FM(CANFD5_RX_B)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
+#define IP1SR1_11_8	FM(MSIOF0_SCK)		FM(HSCK1_X)		FM(SCK1_X)		F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
+#define IP1SR1_15_12	FM(MSIOF0_RXD)		F_(0, 0)		F_(0, 0)		F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
+#define IP1SR1_19_16	FM(HTX0)		FM(TX0)			F_(0, 0)		F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
+#define IP1SR1_23_20	FM(HCTS0_N)		FM(CTS0_N)		FM(PWM8_A)		F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
+#define IP1SR1_27_24	FM(HRTS0_N)		FM(RTS0_N)		FM(PWM9_A)		F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
+#define IP1SR1_31_28	FM(HSCK0)		FM(SCK0)		FM(PWM0_A)		F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
+
+/* IP2SR1 */		/* 0 */			/* 1 */			/* 2 */			/* 3		4	 5	  6	   7	    8	     9	      A	       B	C	 D	  E	   F */
+#define IP2SR1_3_0	FM(HRX0)		FM(RX0)			F_(0, 0)		F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
+#define IP2SR1_7_4	FM(SCIF_CLK)		FM(IRQ4_A)		F_(0, 0)		F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
+#define IP2SR1_11_8	FM(SSI_SCK)		FM(TCLK3)		F_(0, 0)		F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
+#define IP2SR1_15_12	FM(SSI_WS)		FM(TCLK4)		F_(0, 0)		F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
+#define IP2SR1_19_16	FM(SSI_SD)		FM(IRQ0_A)		F_(0, 0)		F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
+#define IP2SR1_23_20	FM(AUDIO_CLKOUT)	FM(IRQ1_A)		F_(0, 0)		F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
+#define IP2SR1_27_24	FM(AUDIO_CLKIN)		FM(PWM3_A)		F_(0, 0)		F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
+#define IP2SR1_31_28	F_(0, 0)		FM(TCLK2)		FM(MSIOF4_SS1)		FM(IRQ3_B)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
+
+/* IP3SR1 */		/* 0 */			/* 1 */			/* 2 */			/* 3		4	 5	  6	   7	    8	     9	      A	       B	C	 D	  E	   F */
+#define IP3SR1_3_0	FM(HRX3)		FM(SCK3_A)		FM(MSIOF4_SS2)		F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
+#define IP3SR1_7_4	FM(HSCK3)		FM(CTS3_N_A)		FM(MSIOF4_SCK)		FM(TPU0TO0_A)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
+#define IP3SR1_11_8	FM(HRTS3_N)		FM(RTS3_N_A)		FM(MSIOF4_TXD)		FM(TPU0TO1_A)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
+#define IP3SR1_15_12	FM(HCTS3_N)		FM(RX3_A)		FM(MSIOF4_RXD)		F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
+#define IP3SR1_19_16	FM(HTX3)		FM(TX3_A)		FM(MSIOF4_SYNC)		F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
 
 /* SR2 */
-/* IP0SR2 */		/* 0 */			/* 1 */			/* 2 */		/* 3		4	 5	  6	   7	    8	     9	      A	       B	C	 D	  E	   F */
-#define IP0SR2_3_0	FM(FXR_TXDA)		FM(CANFD1_TX)		FM(TPU0TO2_A)	F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
-#define IP0SR2_7_4	FM(FXR_TXENA_N)		FM(CANFD1_RX)		FM(TPU0TO3_A)	F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
-#define IP0SR2_11_8	FM(RXDA_EXTFXR)		FM(CANFD5_TX)		FM(IRQ5)	F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
-#define IP0SR2_15_12	FM(CLK_EXTFXR)		FM(CANFD5_RX)		FM(IRQ4_B)	F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
-#define IP0SR2_19_16	FM(RXDB_EXTFXR)		F_(0, 0)		F_(0, 0)	F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
-#define IP0SR2_23_20	FM(FXR_TXENB_N)		F_(0, 0)		F_(0, 0)	F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
-#define IP0SR2_27_24	FM(FXR_TXDB)		F_(0, 0)		F_(0, 0)	F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
-#define IP0SR2_31_28	FM(TPU0TO1)		FM(CANFD6_TX)		F_(0, 0)	FM(TCLK2_B)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
-
-/* IP1SR2 */		/* 0 */			/* 1 */			/* 2 */		/* 3		4	 5	  6	   7	    8	     9	      A	       B	C	 D	  E	   F */
-#define IP1SR2_3_0	FM(TPU0TO0)		FM(CANFD6_RX)		F_(0, 0)	FM(TCLK1_A)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
-#define IP1SR2_7_4	FM(CAN_CLK)		FM(FXR_TXENA_N_X)	F_(0, 0)	F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
-#define IP1SR2_11_8	FM(CANFD0_TX)		FM(FXR_TXENB_N_X)	F_(0, 0)	F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
-#define IP1SR2_15_12	FM(CANFD0_RX)		FM(STPWT_EXTFXR)	F_(0, 0)	F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
-#define IP1SR2_19_16	FM(CANFD2_TX)		FM(TPU0TO2)		F_(0, 0)	FM(TCLK3_A)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
-#define IP1SR2_23_20	FM(CANFD2_RX)		FM(TPU0TO3)		FM(PWM1_B)	FM(TCLK4_A)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
-#define IP1SR2_27_24	FM(CANFD3_TX)		F_(0, 0)		FM(PWM2_B)	F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
-#define IP1SR2_31_28	FM(CANFD3_RX)		F_(0, 0)		FM(PWM3_B)	F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
-
-/* IP2SR2 */		/* 0 */			/* 1 */			/* 2 */		/* 3		4	 5	  6	   7	    8	     9	      A	       B	C	 D	  E	   F */
-#define IP2SR2_3_0	FM(CANFD4_TX)		F_(0, 0)		FM(PWM4)	F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
-#define IP2SR2_7_4	FM(CANFD4_RX)		F_(0, 0)		FM(PWM5)	F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
-#define IP2SR2_11_8	FM(CANFD7_TX)		F_(0, 0)		FM(PWM6)	F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
-#define IP2SR2_15_12	FM(CANFD7_RX)		F_(0, 0)		FM(PWM7)	F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
+/* IP0SR2 */		/* 0 */			/* 1 */			/* 2 */			/* 3		4	 5	  6	   7	    8	     9	      A	       B	C	 D	  E	   F */
+#define IP0SR2_3_0	FM(FXR_TXDA)		FM(CANFD1_TX)		FM(TPU0TO2_A)		F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
+#define IP0SR2_7_4	FM(FXR_TXENA_N)		FM(CANFD1_RX)		FM(TPU0TO3_A)		F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
+#define IP0SR2_11_8	FM(RXDA_EXTFXR)		FM(CANFD5_TX)		FM(IRQ5)		F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
+#define IP0SR2_15_12	FM(CLK_EXTFXR)		FM(CANFD5_RX)		FM(IRQ4_B)		F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
+#define IP0SR2_19_16	FM(RXDB_EXTFXR)		F_(0, 0)		F_(0, 0)		F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
+#define IP0SR2_23_20	FM(FXR_TXENB_N)		F_(0, 0)		F_(0, 0)		F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
+#define IP0SR2_27_24	FM(FXR_TXDB)		F_(0, 0)		F_(0, 0)		F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
+#define IP0SR2_31_28	FM(TPU0TO1)		FM(CANFD6_TX)		F_(0, 0)		FM(TCLK2_B)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
+
+/* IP1SR2 */		/* 0 */			/* 1 */			/* 2 */			/* 3		4	 5	  6	   7	    8	     9	      A	       B	C	 D	  E	   F */
+#define IP1SR2_3_0	FM(TPU0TO0)		FM(CANFD6_RX)		F_(0, 0)		FM(TCLK1_A)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
+#define IP1SR2_7_4	FM(CAN_CLK)		FM(FXR_TXENA_N_X)	F_(0, 0)		F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
+#define IP1SR2_11_8	FM(CANFD0_TX)		FM(FXR_TXENB_N_X)	F_(0, 0)		F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
+#define IP1SR2_15_12	FM(CANFD0_RX)		FM(STPWT_EXTFXR)	F_(0, 0)		F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
+#define IP1SR2_19_16	FM(CANFD2_TX)		FM(TPU0TO2)		F_(0, 0)		FM(TCLK3_A)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
+#define IP1SR2_23_20	FM(CANFD2_RX)		FM(TPU0TO3)		FM(PWM1_B)		FM(TCLK4_A)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
+#define IP1SR2_27_24	FM(CANFD3_TX)		F_(0, 0)		FM(PWM2_B)		F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
+#define IP1SR2_31_28	FM(CANFD3_RX)		F_(0, 0)		FM(PWM3_B)		F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
+
+/* IP2SR2 */		/* 0 */			/* 1 */			/* 2 */			/* 3		4	 5	  6	   7	    8	     9	      A	       B	C	 D	  E	   F */
+#define IP2SR2_3_0	FM(CANFD4_TX)		F_(0, 0)		FM(PWM4)		F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
+#define IP2SR2_7_4	FM(CANFD4_RX)		F_(0, 0)		FM(PWM5)		F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
+#define IP2SR2_11_8	FM(CANFD7_TX)		F_(0, 0)		FM(PWM6)		F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
+#define IP2SR2_15_12	FM(CANFD7_RX)		F_(0, 0)		FM(PWM7)		F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
 
 /* SR3 */
-/* IP0SR3 */		/* 0 */			/* 1 */			/* 2 */		/* 3		4	 5	  6	   7	    8	     9	      A	       B	C	 D	  E	   F */
-#define IP0SR3_3_0	FM(MMC_SD_D1)		F_(0, 0)		F_(0, 0)	F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
-#define IP0SR3_7_4	FM(MMC_SD_D0)		F_(0, 0)		F_(0, 0)	F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
-#define IP0SR3_11_8	FM(MMC_SD_D2)		F_(0, 0)		F_(0, 0)	F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
-#define IP0SR3_15_12	FM(MMC_SD_CLK)		F_(0, 0)		F_(0, 0)	F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
-#define IP0SR3_19_16	FM(MMC_DS)		F_(0, 0)		F_(0, 0)	F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
-#define IP0SR3_23_20	FM(MMC_SD_D3)		F_(0, 0)		F_(0, 0)	F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
-#define IP0SR3_27_24	FM(MMC_D5)		F_(0, 0)		F_(0, 0)	F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
-#define IP0SR3_31_28	FM(MMC_D4)		F_(0, 0)		F_(0, 0)	F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
-
-/* IP1SR3 */		/* 0 */			/* 1 */			/* 2 */		/* 3		4	 5	  6	   7	    8	     9	      A	       B	C	 D	  E	   F */
-#define IP1SR3_3_0	FM(MMC_D7)		F_(0, 0)		F_(0, 0)	F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
-#define IP1SR3_7_4	FM(MMC_D6)		F_(0, 0)		F_(0, 0)	F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
-#define IP1SR3_11_8	FM(MMC_SD_CMD)		F_(0, 0)		F_(0, 0)	F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
-#define IP1SR3_15_12	FM(SD_CD)		F_(0, 0)		F_(0, 0)	F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
-#define IP1SR3_19_16	FM(SD_WP)		F_(0, 0)		F_(0, 0)	F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
-#define IP1SR3_23_20	FM(IPC_CLKIN)		FM(IPC_CLKEN_IN)	FM(PWM1_A)	FM(TCLK3_X)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
-#define IP1SR3_27_24	FM(IPC_CLKOUT)		FM(IPC_CLKEN_OUT)	FM(ERROROUTC_A)	FM(TCLK4_X)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
-#define IP1SR3_31_28	FM(QSPI0_SSL)		F_(0, 0)		F_(0, 0)	F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
-
-/* IP2SR3 */		/* 0 */			/* 1 */			/* 2 */		/* 3		4	 5	  6	   7	    8	     9	      A	       B	C	 D	  E	   F */
-#define IP2SR3_3_0	FM(QSPI0_IO3)		F_(0, 0)		F_(0, 0)	F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
-#define IP2SR3_7_4	FM(QSPI0_IO2)		F_(0, 0)		F_(0, 0)	F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
-#define IP2SR3_11_8	FM(QSPI0_MISO_IO1)	F_(0, 0)		F_(0, 0)	F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
-#define IP2SR3_15_12	FM(QSPI0_MOSI_IO0)	F_(0, 0)		F_(0, 0)	F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
-#define IP2SR3_19_16	FM(QSPI0_SPCLK)		F_(0, 0)		F_(0, 0)	F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
-#define IP2SR3_23_20	FM(QSPI1_MOSI_IO0)	F_(0, 0)		F_(0, 0)	F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
-#define IP2SR3_27_24	FM(QSPI1_SPCLK)		F_(0, 0)		F_(0, 0)	F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
-#define IP2SR3_31_28	FM(QSPI1_MISO_IO1)	F_(0, 0)		F_(0, 0)	F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
-
-/* IP3SR3 */		/* 0 */			/* 1 */			/* 2 */		/* 3		4	 5	  6	   7	    8	     9	      A	       B	C	 D	  E	   F */
-#define IP3SR3_3_0	FM(QSPI1_IO2)		F_(0, 0)		F_(0, 0)	F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
-#define IP3SR3_7_4	FM(QSPI1_SSL)		F_(0, 0)		F_(0, 0)	F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
-#define IP3SR3_11_8	FM(QSPI1_IO3)		F_(0, 0)		F_(0, 0)	F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
-#define IP3SR3_15_12	FM(RPC_RESET_N)		F_(0, 0)		F_(0, 0)	F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
-#define IP3SR3_19_16	FM(RPC_WP_N)		F_(0, 0)		F_(0, 0)	F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
-#define IP3SR3_23_20	FM(RPC_INT_N)		F_(0, 0)		F_(0, 0)	F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
+/* IP0SR3 */		/* 0 */			/* 1 */			/* 2 */			/* 3		4	 5	  6	   7	    8	     9	      A	       B	C	 D	  E	   F */
+#define IP0SR3_3_0	FM(MMC_SD_D1)		F_(0, 0)		F_(0, 0)		F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
+#define IP0SR3_7_4	FM(MMC_SD_D0)		F_(0, 0)		F_(0, 0)		F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
+#define IP0SR3_11_8	FM(MMC_SD_D2)		F_(0, 0)		F_(0, 0)		F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
+#define IP0SR3_15_12	FM(MMC_SD_CLK)		F_(0, 0)		F_(0, 0)		F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
+#define IP0SR3_19_16	FM(MMC_DS)		F_(0, 0)		F_(0, 0)		F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
+#define IP0SR3_23_20	FM(MMC_SD_D3)		F_(0, 0)		F_(0, 0)		F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
+#define IP0SR3_27_24	FM(MMC_D5)		F_(0, 0)		F_(0, 0)		F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
+#define IP0SR3_31_28	FM(MMC_D4)		F_(0, 0)		F_(0, 0)		F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
+
+/* IP1SR3 */		/* 0 */			/* 1 */			/* 2 */			/* 3		4	 5	  6	   7	    8	     9	      A	       B	C	 D	  E	   F */
+#define IP1SR3_3_0	FM(MMC_D7)		F_(0, 0)		F_(0, 0)		F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
+#define IP1SR3_7_4	FM(MMC_D6)		F_(0, 0)		F_(0, 0)		F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
+#define IP1SR3_11_8	FM(MMC_SD_CMD)		F_(0, 0)		F_(0, 0)		F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
+#define IP1SR3_15_12	FM(SD_CD)		F_(0, 0)		F_(0, 0)		F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
+#define IP1SR3_19_16	FM(SD_WP)		F_(0, 0)		F_(0, 0)		F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
+#define IP1SR3_23_20	FM(IPC_CLKIN)		FM(IPC_CLKEN_IN)	FM(PWM1_A)		FM(TCLK3_X)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
+#define IP1SR3_27_24	FM(IPC_CLKOUT)		FM(IPC_CLKEN_OUT)	FM(ERROROUTC_N_A)	FM(TCLK4_X)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
+#define IP1SR3_31_28	FM(QSPI0_SSL)		F_(0, 0)		F_(0, 0)		F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
+
+/* IP2SR3 */		/* 0 */			/* 1 */			/* 2 */			/* 3		4	 5	  6	   7	    8	     9	      A	       B	C	 D	  E	   F */
+#define IP2SR3_3_0	FM(QSPI0_IO3)		F_(0, 0)		F_(0, 0)		F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
+#define IP2SR3_7_4	FM(QSPI0_IO2)		F_(0, 0)		F_(0, 0)		F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
+#define IP2SR3_11_8	FM(QSPI0_MISO_IO1)	F_(0, 0)		F_(0, 0)		F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
+#define IP2SR3_15_12	FM(QSPI0_MOSI_IO0)	F_(0, 0)		F_(0, 0)		F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
+#define IP2SR3_19_16	FM(QSPI0_SPCLK)		F_(0, 0)		F_(0, 0)		F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
+#define IP2SR3_23_20	FM(QSPI1_MOSI_IO0)	F_(0, 0)		F_(0, 0)		F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
+#define IP2SR3_27_24	FM(QSPI1_SPCLK)		F_(0, 0)		F_(0, 0)		F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
+#define IP2SR3_31_28	FM(QSPI1_MISO_IO1)	F_(0, 0)		F_(0, 0)		F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
+
+/* IP3SR3 */		/* 0 */			/* 1 */			/* 2 */			/* 3		4	 5	  6	   7	    8	     9	      A	       B	C	 D	  E	   F */
+#define IP3SR3_3_0	FM(QSPI1_IO2)		F_(0, 0)		F_(0, 0)		F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
+#define IP3SR3_7_4	FM(QSPI1_SSL)		F_(0, 0)		F_(0, 0)		F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
+#define IP3SR3_11_8	FM(QSPI1_IO3)		F_(0, 0)		F_(0, 0)		F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
+#define IP3SR3_15_12	FM(RPC_RESET_N)		F_(0, 0)		F_(0, 0)		F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
+#define IP3SR3_19_16	FM(RPC_WP_N)		F_(0, 0)		F_(0, 0)		F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
+#define IP3SR3_23_20	FM(RPC_INT_N)		F_(0, 0)		F_(0, 0)		F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
+
+/* SR4 */
+/* IP0SR4 */		/* 0 */			/* 1 */			/* 2 */			/* 3		4	 5	  6	   7	    8	     9	      A	       B	C	 D	  E	   F */
+#define IP0SR4_3_0	FM(TSN0_MDIO)		F_(0, 0)		F_(0, 0)		F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
+#define IP0SR4_7_4	FM(TSN0_MDC)		F_(0, 0)		F_(0, 0)		F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
+#define IP0SR4_11_8	FM(TSN0_AVTP_PPS1)	F_(0, 0)		F_(0, 0)		F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
+#define IP0SR4_15_12	FM(TSN0_PHY_INT)	F_(0, 0)		F_(0, 0)		F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
+#define IP0SR4_19_16	FM(TSN0_LINK)		F_(0, 0)		F_(0, 0)		F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
+#define IP0SR4_23_20	FM(TSN0_AVTP_MATCH)	F_(0, 0)		F_(0, 0)		F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
+#define IP0SR4_27_24	FM(TSN0_AVTP_CAPTURE)	F_(0, 0)		F_(0, 0)		F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
+#define IP0SR4_31_28	FM(TSN0_RX_CTL)		F_(0, 0)		F_(0, 0)		F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
+
+/* IP1SR4 */		/* 0 */			/* 1 */			/* 2 */			/* 3		4	 5	  6	   7	    8	     9	      A	       B	C	 D	  E	   F */
+#define IP1SR4_3_0	FM(TSN0_AVTP_PPS0)	F_(0, 0)		F_(0, 0)		F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
+#define IP1SR4_7_4	FM(TSN0_TX_CTL)		F_(0, 0)		F_(0, 0)		F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
+#define IP1SR4_11_8	FM(TSN0_RD0)		F_(0, 0)		F_(0, 0)		F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
+#define IP1SR4_15_12	FM(TSN0_RXC)		F_(0, 0)		F_(0, 0)		F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
+#define IP1SR4_19_16	FM(TSN0_TXC)		F_(0, 0)		F_(0, 0)		F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
+#define IP1SR4_23_20	FM(TSN0_RD1)		F_(0, 0)		F_(0, 0)		F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
+#define IP1SR4_27_24	FM(TSN0_TD1)		F_(0, 0)		F_(0, 0)		F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
+#define IP1SR4_31_28	FM(TSN0_TD0)		F_(0, 0)		F_(0, 0)		F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
+
+/* IP2SR4 */		/* 0 */			/* 1 */			/* 2 */			/* 3		4	 5	  6	   7	    8	     9	      A	       B	C	 D	  E	   F */
+#define IP2SR4_3_0	FM(TSN0_RD3)		F_(0, 0)		F_(0, 0)		F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
+#define IP2SR4_7_4	FM(TSN0_RD2)		F_(0, 0)		F_(0, 0)		F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
+#define IP2SR4_11_8	FM(TSN0_TD3)		F_(0, 0)		F_(0, 0)		F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
+#define IP2SR4_15_12	FM(TSN0_TD2)		F_(0, 0)		F_(0, 0)		F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
+#define IP2SR4_19_16	FM(TSN0_TXCREFCLK)	F_(0, 0)		F_(0, 0)		F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
+#define IP2SR4_23_20	FM(PCIE0_CLKREQ_N)	F_(0, 0)		F_(0, 0)		F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
+#define IP2SR4_27_24	FM(PCIE1_CLKREQ_N)	F_(0, 0)		F_(0, 0)		F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
+#define IP2SR4_31_28	FM(AVS0)		F_(0, 0)		F_(0, 0)		F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
+
+/* IP3SR4 */		/* 0 */			/* 1 */			/* 2 */			/* 3		4	 5	  6	   7	    8	     9	      A	       B	C	 D	  E	   F */
+#define IP3SR4_3_0	FM(AVS1)		F_(0, 0)		F_(0, 0)		F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
+
+/* SR5 */
+/* IP0SR5 */		/* 0 */			/* 1 */			/* 2 */			/* 3		4	 5	  6	   7	    8	     9	      A	       B	C	 D	  E	   F */
+#define IP0SR5_3_0	FM(AVB2_AVTP_PPS)	F_(0, 0)		F_(0, 0)		F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
+#define IP0SR5_7_4	FM(AVB2_AVTP_CAPTURE)	F_(0, 0)		F_(0, 0)		F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
+#define IP0SR5_11_8	FM(AVB2_AVTP_MATCH)	F_(0, 0)		F_(0, 0)		F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
+#define IP0SR5_15_12	FM(AVB2_LINK)		F_(0, 0)		F_(0, 0)		F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
+#define IP0SR5_19_16	FM(AVB2_PHY_INT)	F_(0, 0)		F_(0, 0)		F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
+#define IP0SR5_23_20	FM(AVB2_MAGIC)		F_(0, 0)		F_(0, 0)		F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
+#define IP0SR5_27_24	FM(AVB2_MDC)		F_(0, 0)		F_(0, 0)		F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
+#define IP0SR5_31_28	FM(AVB2_TXCREFCLK)	F_(0, 0)		F_(0, 0)		F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
+
+/* IP1SR5 */		/* 0 */			/* 1 */			/* 2 */			/* 3		4	 5	  6	   7	    8	     9	      A	       B	C	 D	  E	   F */
+#define IP1SR5_3_0	FM(AVB2_TD3)		F_(0, 0)		F_(0, 0)		F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
+#define IP1SR5_7_4	FM(AVB2_RD3)		F_(0, 0)		F_(0, 0)		F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
+#define IP1SR5_11_8	FM(AVB2_MDIO)		F_(0, 0)		F_(0, 0)		F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
+#define IP1SR5_15_12	FM(AVB2_TD2)		F_(0, 0)		F_(0, 0)		F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
+#define IP1SR5_19_16	FM(AVB2_TD1)		F_(0, 0)		F_(0, 0)		F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
+#define IP1SR5_23_20	FM(AVB2_RD2)		F_(0, 0)		F_(0, 0)		F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
+#define IP1SR5_27_24	FM(AVB2_RD1)		F_(0, 0)		F_(0, 0)		F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
+#define IP1SR5_31_28	FM(AVB2_TD0)		F_(0, 0)		F_(0, 0)		F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
+
+/* IP2SR5 */		/* 0 */			/* 1 */			/* 2 */			/* 3		4	 5	  6	   7	    8	     9	      A	       B	C	 D	  E	   F */
+#define IP2SR5_3_0	FM(AVB2_TXC)		F_(0, 0)		F_(0, 0)		F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
+#define IP2SR5_7_4	FM(AVB2_RD0)		F_(0, 0)		F_(0, 0)		F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
+#define IP2SR5_11_8	FM(AVB2_RXC)		F_(0, 0)		F_(0, 0)		F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
+#define IP2SR5_15_12	FM(AVB2_TX_CTL)		F_(0, 0)		F_(0, 0)		F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
+#define IP2SR5_19_16	FM(AVB2_RX_CTL)		F_(0, 0)		F_(0, 0)		F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
 
 /* SR6 */
-/* IP0SR6 */		/* 0 */			/* 1 */			/* 2 */		/* 3		4	 5	  6	   7	    8	     9	      A	       B	C	 D	  E	   F */
-#define IP0SR6_3_0	FM(AVB1_MDIO)		F_(0, 0)		F_(0, 0)	F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
-#define IP0SR6_7_4	FM(AVB1_MAGIC)		F_(0, 0)		F_(0, 0)	F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
-#define IP0SR6_11_8	FM(AVB1_MDC)		F_(0, 0)		F_(0, 0)	F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
-#define IP0SR6_15_12	FM(AVB1_PHY_INT)	F_(0, 0)		F_(0, 0)	F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
-#define IP0SR6_19_16	FM(AVB1_LINK)		FM(AVB1_MII_TX_ER)	F_(0, 0)	F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
-#define IP0SR6_23_20	FM(AVB1_AVTP_MATCH)	FM(AVB1_MII_RX_ER)	F_(0, 0)	F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
-#define IP0SR6_27_24	FM(AVB1_TXC)		FM(AVB1_MII_TXC)	F_(0, 0)	F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
-#define IP0SR6_31_28	FM(AVB1_TX_CTL)		FM(AVB1_MII_TX_EN)	F_(0, 0)	F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
-
-/* IP1SR6 */		/* 0 */			/* 1 */			/* 2 */		/* 3		4	 5	  6	   7	    8	     9	      A	       B	C	 D	  E	   F */
-#define IP1SR6_3_0	FM(AVB1_RXC)		FM(AVB1_MII_RXC)	F_(0, 0)	F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
-#define IP1SR6_7_4	FM(AVB1_RX_CTL)		FM(AVB1_MII_RX_DV)	F_(0, 0)	F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
-#define IP1SR6_11_8	FM(AVB1_AVTP_PPS)	FM(AVB1_MII_COL)	F_(0, 0)	F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
-#define IP1SR6_15_12	FM(AVB1_AVTP_CAPTURE)	FM(AVB1_MII_CRS)	F_(0, 0)	F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
-#define IP1SR6_19_16	FM(AVB1_TD1)		FM(AVB1_MII_TD1)	F_(0, 0)	F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
-#define IP1SR6_23_20	FM(AVB1_TD0)		FM(AVB1_MII_TD0)	F_(0, 0)	F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
-#define IP1SR6_27_24	FM(AVB1_RD1)		FM(AVB1_MII_RD1)	F_(0, 0)	F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
-#define IP1SR6_31_28	FM(AVB1_RD0)		FM(AVB1_MII_RD0)	F_(0, 0)	F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
-
-/* IP2SR6 */		/* 0 */			/* 1 */			/* 2 */		/* 3		4	 5	  6	   7	    8	     9	      A	       B	C	 D	  E	   F */
-#define IP2SR6_3_0	FM(AVB1_TD2)		FM(AVB1_MII_TD2)	F_(0, 0)	F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
-#define IP2SR6_7_4	FM(AVB1_RD2)		FM(AVB1_MII_RD2)	F_(0, 0)	F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
-#define IP2SR6_11_8	FM(AVB1_TD3)		FM(AVB1_MII_TD3)	F_(0, 0)	F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
-#define IP2SR6_15_12	FM(AVB1_RD3)		FM(AVB1_MII_RD3)	F_(0, 0)	F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
-#define IP2SR6_19_16	FM(AVB1_TXCREFCLK)	F_(0, 0)		F_(0, 0)	F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
+/* IP0SR6 */		/* 0 */			/* 1 */			/* 2 */			/* 3		4	 5	  6	   7	    8	     9	      A	       B	C	 D	  E	   F */
+#define IP0SR6_3_0	FM(AVB1_MDIO)		F_(0, 0)		F_(0, 0)		F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
+#define IP0SR6_7_4	FM(AVB1_MAGIC)		F_(0, 0)		F_(0, 0)		F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
+#define IP0SR6_11_8	FM(AVB1_MDC)		F_(0, 0)		F_(0, 0)		F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
+#define IP0SR6_15_12	FM(AVB1_PHY_INT)	F_(0, 0)		F_(0, 0)		F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
+#define IP0SR6_19_16	FM(AVB1_LINK)		FM(AVB1_MII_TX_ER)	F_(0, 0)		F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
+#define IP0SR6_23_20	FM(AVB1_AVTP_MATCH)	FM(AVB1_MII_RX_ER)	F_(0, 0)		F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
+#define IP0SR6_27_24	FM(AVB1_TXC)		FM(AVB1_MII_TXC)	F_(0, 0)		F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
+#define IP0SR6_31_28	FM(AVB1_TX_CTL)		FM(AVB1_MII_TX_EN)	F_(0, 0)		F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
+
+/* IP1SR6 */		/* 0 */			/* 1 */			/* 2 */			/* 3		4	 5	  6	   7	    8	     9	      A	       B	C	 D	  E	   F */
+#define IP1SR6_3_0	FM(AVB1_RXC)		FM(AVB1_MII_RXC)	F_(0, 0)		F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
+#define IP1SR6_7_4	FM(AVB1_RX_CTL)		FM(AVB1_MII_RX_DV)	F_(0, 0)		F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
+#define IP1SR6_11_8	FM(AVB1_AVTP_PPS)	FM(AVB1_MII_COL)	F_(0, 0)		F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
+#define IP1SR6_15_12	FM(AVB1_AVTP_CAPTURE)	FM(AVB1_MII_CRS)	F_(0, 0)		F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
+#define IP1SR6_19_16	FM(AVB1_TD1)		FM(AVB1_MII_TD1)	F_(0, 0)		F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
+#define IP1SR6_23_20	FM(AVB1_TD0)		FM(AVB1_MII_TD0)	F_(0, 0)		F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
+#define IP1SR6_27_24	FM(AVB1_RD1)		FM(AVB1_MII_RD1)	F_(0, 0)		F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
+#define IP1SR6_31_28	FM(AVB1_RD0)		FM(AVB1_MII_RD0)	F_(0, 0)		F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
+
+/* IP2SR6 */		/* 0 */			/* 1 */			/* 2 */			/* 3		4	 5	  6	   7	    8	     9	      A	       B	C	 D	  E	   F */
+#define IP2SR6_3_0	FM(AVB1_TD2)		FM(AVB1_MII_TD2)	F_(0, 0)		F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
+#define IP2SR6_7_4	FM(AVB1_RD2)		FM(AVB1_MII_RD2)	F_(0, 0)		F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
+#define IP2SR6_11_8	FM(AVB1_TD3)		FM(AVB1_MII_TD3)	F_(0, 0)		F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
+#define IP2SR6_15_12	FM(AVB1_RD3)		FM(AVB1_MII_RD3)	F_(0, 0)		F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
+#define IP2SR6_19_16	FM(AVB1_TXCREFCLK)	F_(0, 0)		F_(0, 0)		F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
 
 /* SR7 */
-/* IP0SR7 */		/* 0 */			/* 1 */			/* 2 */		/* 3		4	 5	  6	   7	    8	     9	      A	       B	C	 D	  E	   F */
-#define IP0SR7_3_0	FM(AVB0_AVTP_PPS)	FM(AVB0_MII_COL)	F_(0, 0)	F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
-#define IP0SR7_7_4	FM(AVB0_AVTP_CAPTURE)	FM(AVB0_MII_CRS)	F_(0, 0)	F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
-#define IP0SR7_11_8	FM(AVB0_AVTP_MATCH)	FM(AVB0_MII_RX_ER)	FM(CC5_OSCOUT)	F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
-#define IP0SR7_15_12	FM(AVB0_TD3)		FM(AVB0_MII_TD3)	F_(0, 0)	F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
-#define IP0SR7_19_16	FM(AVB0_LINK)		FM(AVB0_MII_TX_ER)	F_(0, 0)	F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
-#define IP0SR7_23_20	FM(AVB0_PHY_INT)	F_(0, 0)		F_(0, 0)	F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
-#define IP0SR7_27_24	FM(AVB0_TD2)		FM(AVB0_MII_TD2)	F_(0, 0)	F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
-#define IP0SR7_31_28	FM(AVB0_TD1)		FM(AVB0_MII_TD1)	F_(0, 0)	F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
-
-/* IP1SR7 */		/* 0 */			/* 1 */			/* 2 */		/* 3		4	 5	  6	   7	    8	     9	      A	       B	C	 D	  E	   F */
-#define IP1SR7_3_0	FM(AVB0_RD3)		FM(AVB0_MII_RD3)	F_(0, 0)	F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
-#define IP1SR7_7_4	FM(AVB0_TXCREFCLK)	F_(0, 0)		F_(0, 0)	F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
-#define IP1SR7_11_8	FM(AVB0_MAGIC)		F_(0, 0)		F_(0, 0)	F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
-#define IP1SR7_15_12	FM(AVB0_TD0)		FM(AVB0_MII_TD0)	F_(0, 0)	F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
-#define IP1SR7_19_16	FM(AVB0_RD2)		FM(AVB0_MII_RD2)	F_(0, 0)	F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
-#define IP1SR7_23_20	FM(AVB0_MDC)		F_(0, 0)		F_(0, 0)	F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
-#define IP1SR7_27_24	FM(AVB0_MDIO)		F_(0, 0)		F_(0, 0)	F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
-#define IP1SR7_31_28	FM(AVB0_TXC)		FM(AVB0_MII_TXC)	F_(0, 0)	F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
-
-/* IP2SR7 */		/* 0 */			/* 1 */			/* 2 */		/* 3		4	 5	  6	   7	    8	     9	      A	       B	C	 D	  E	   F */
-#define IP2SR7_3_0	FM(AVB0_TX_CTL)		FM(AVB0_MII_TX_EN)	F_(0, 0)	F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
-#define IP2SR7_7_4	FM(AVB0_RD1)		FM(AVB0_MII_RD1)	F_(0, 0)	F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
-#define IP2SR7_11_8	FM(AVB0_RD0)		FM(AVB0_MII_RD0)	F_(0, 0)	F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
-#define IP2SR7_15_12	FM(AVB0_RXC)		FM(AVB0_MII_RXC)	F_(0, 0)	F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
-#define IP2SR7_19_16	FM(AVB0_RX_CTL)		FM(AVB0_MII_RX_DV)	F_(0, 0)	F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
+/* IP0SR7 */		/* 0 */			/* 1 */			/* 2 */			/* 3		4	 5	  6	   7	    8	     9	      A	       B	C	 D	  E	   F */
+#define IP0SR7_3_0	FM(AVB0_AVTP_PPS)	FM(AVB0_MII_COL)	F_(0, 0)		F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
+#define IP0SR7_7_4	FM(AVB0_AVTP_CAPTURE)	FM(AVB0_MII_CRS)	F_(0, 0)		F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
+#define IP0SR7_11_8	FM(AVB0_AVTP_MATCH)	FM(AVB0_MII_RX_ER)	FM(CC5_OSCOUT)		F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
+#define IP0SR7_15_12	FM(AVB0_TD3)		FM(AVB0_MII_TD3)	F_(0, 0)		F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
+#define IP0SR7_19_16	FM(AVB0_LINK)		FM(AVB0_MII_TX_ER)	F_(0, 0)		F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
+#define IP0SR7_23_20	FM(AVB0_PHY_INT)	F_(0, 0)		F_(0, 0)		F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
+#define IP0SR7_27_24	FM(AVB0_TD2)		FM(AVB0_MII_TD2)	F_(0, 0)		F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
+#define IP0SR7_31_28	FM(AVB0_TD1)		FM(AVB0_MII_TD1)	F_(0, 0)		F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
+
+/* IP1SR7 */		/* 0 */			/* 1 */			/* 2 */			/* 3		4	 5	  6	   7	    8	     9	      A	       B	C	 D	  E	   F */
+#define IP1SR7_3_0	FM(AVB0_RD3)		FM(AVB0_MII_RD3)	F_(0, 0)		F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
+#define IP1SR7_7_4	FM(AVB0_TXCREFCLK)	F_(0, 0)		F_(0, 0)		F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
+#define IP1SR7_11_8	FM(AVB0_MAGIC)		F_(0, 0)		F_(0, 0)		F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
+#define IP1SR7_15_12	FM(AVB0_TD0)		FM(AVB0_MII_TD0)	F_(0, 0)		F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
+#define IP1SR7_19_16	FM(AVB0_RD2)		FM(AVB0_MII_RD2)	F_(0, 0)		F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
+#define IP1SR7_23_20	FM(AVB0_MDC)		F_(0, 0)		F_(0, 0)		F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
+#define IP1SR7_27_24	FM(AVB0_MDIO)		F_(0, 0)		F_(0, 0)		F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
+#define IP1SR7_31_28	FM(AVB0_TXC)		FM(AVB0_MII_TXC)	F_(0, 0)		F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
+
+/* IP2SR7 */		/* 0 */			/* 1 */			/* 2 */			/* 3		4	 5	  6	   7	    8	     9	      A	       B	C	 D	  E	   F */
+#define IP2SR7_3_0	FM(AVB0_TX_CTL)		FM(AVB0_MII_TX_EN)	F_(0, 0)		F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
+#define IP2SR7_7_4	FM(AVB0_RD1)		FM(AVB0_MII_RD1)	F_(0, 0)		F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
+#define IP2SR7_11_8	FM(AVB0_RD0)		FM(AVB0_MII_RD0)	F_(0, 0)		F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
+#define IP2SR7_15_12	FM(AVB0_RXC)		FM(AVB0_MII_RXC)	F_(0, 0)		F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
+#define IP2SR7_19_16	FM(AVB0_RX_CTL)		FM(AVB0_MII_RX_DV)	F_(0, 0)		F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
 
 /* SR8 */
-/* IP0SR8 */		/* 0 */			/* 1 */			/* 2 */		/* 3		4	 5	  6	   7	    8	     9	      A	       B	C	 D	  E	   F */
-#define IP0SR8_3_0	FM(SCL0)		F_(0, 0)		F_(0, 0)	F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
-#define IP0SR8_7_4	FM(SDA0)		F_(0, 0)		F_(0, 0)	F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
-#define IP0SR8_11_8	FM(SCL1)		F_(0, 0)		F_(0, 0)	F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
-#define IP0SR8_15_12	FM(SDA1)		F_(0, 0)		F_(0, 0)	F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
-#define IP0SR8_19_16	FM(SCL2)		F_(0, 0)		F_(0, 0)	F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
-#define IP0SR8_23_20	FM(SDA2)		F_(0, 0)		F_(0, 0)	F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
-#define IP0SR8_27_24	FM(SCL3)		F_(0, 0)		F_(0, 0)	F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
-#define IP0SR8_31_28	FM(SDA3)		F_(0, 0)		F_(0, 0)	F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
-
-/* IP1SR8 */		/* 0 */			/* 1 */			/* 2 */		/* 3		4	 5	  6	   7	    8	     9	      A	       B	C	 D	  E	   F */
-#define IP1SR8_3_0	FM(SCL4)		FM(HRX2)		FM(SCK4)	F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
-#define IP1SR8_7_4	FM(SDA4)		FM(HTX2)		FM(CTS4_N)	F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
-#define IP1SR8_11_8	FM(SCL5)		FM(HRTS2_N)		FM(RTS4_N)	F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
-#define IP1SR8_15_12	FM(SDA5)		FM(SCIF_CLK2)		F_(0, 0)	F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
-#define IP1SR8_19_16	F_(0, 0)		FM(HCTS2_N)		FM(TX4)		F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
-#define IP1SR8_23_20	F_(0, 0)		FM(HSCK2)		FM(RX4)		F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
+/* IP0SR8 */		/* 0 */			/* 1 */			/* 2 */			/* 3		4	 5	  6	   7	    8	     9	      A	       B	C	 D	  E	   F */
+#define IP0SR8_3_0	FM(SCL0)		F_(0, 0)		F_(0, 0)		F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
+#define IP0SR8_7_4	FM(SDA0)		F_(0, 0)		F_(0, 0)		F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
+#define IP0SR8_11_8	FM(SCL1)		F_(0, 0)		F_(0, 0)		F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
+#define IP0SR8_15_12	FM(SDA1)		F_(0, 0)		F_(0, 0)		F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
+#define IP0SR8_19_16	FM(SCL2)		F_(0, 0)		F_(0, 0)		F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
+#define IP0SR8_23_20	FM(SDA2)		F_(0, 0)		F_(0, 0)		F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
+#define IP0SR8_27_24	FM(SCL3)		F_(0, 0)		F_(0, 0)		F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
+#define IP0SR8_31_28	FM(SDA3)		F_(0, 0)		F_(0, 0)		F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
+
+/* IP1SR8 */		/* 0 */			/* 1 */			/* 2 */			/* 3		4	 5	  6	   7	    8	     9	      A	       B	C	 D	  E	   F */
+#define IP1SR8_3_0	FM(SCL4)		FM(HRX2)		FM(SCK4)		F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
+#define IP1SR8_7_4	FM(SDA4)		FM(HTX2)		FM(CTS4_N)		F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
+#define IP1SR8_11_8	FM(SCL5)		FM(HRTS2_N)		FM(RTS4_N)		F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
+#define IP1SR8_15_12	FM(SDA5)		FM(SCIF_CLK2)		F_(0, 0)		F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
+#define IP1SR8_19_16	F_(0, 0)		FM(HCTS2_N)		FM(TX4)			F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
+#define IP1SR8_23_20	F_(0, 0)		FM(HSCK2)		FM(RX4)			F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
 
 #define PINMUX_GPSR	\
 						GPSR3_29											\
@@ -545,6 +613,24 @@ FM(IP0SR3_23_20)	IP0SR3_23_20	FM(IP1SR3_23_20)	IP1SR3_23_20	FM(IP2SR3_23_20)	IP2
 FM(IP0SR3_27_24)	IP0SR3_27_24	FM(IP1SR3_27_24)	IP1SR3_27_24	FM(IP2SR3_27_24)	IP2SR3_27_24						\
 FM(IP0SR3_31_28)	IP0SR3_31_28	FM(IP1SR3_31_28)	IP1SR3_31_28	FM(IP2SR3_31_28)	IP2SR3_31_28						\
 \
+FM(IP0SR4_3_0)		IP0SR4_3_0	FM(IP1SR4_3_0)		IP1SR4_3_0	FM(IP2SR4_3_0)		IP2SR4_3_0	FM(IP3SR4_3_0)		IP3SR4_3_0	\
+FM(IP0SR4_7_4)		IP0SR4_7_4	FM(IP1SR4_7_4)		IP1SR4_7_4	FM(IP2SR4_7_4)		IP2SR4_7_4	\
+FM(IP0SR4_11_8)		IP0SR4_11_8	FM(IP1SR4_11_8)		IP1SR4_11_8	FM(IP2SR4_11_8)		IP2SR4_11_8	\
+FM(IP0SR4_15_12)	IP0SR4_15_12	FM(IP1SR4_15_12)	IP1SR4_15_12	FM(IP2SR4_15_12)	IP2SR4_15_12	\
+FM(IP0SR4_19_16)	IP0SR4_19_16	FM(IP1SR4_19_16)	IP1SR4_19_16	FM(IP2SR4_19_16)	IP2SR4_19_16	\
+FM(IP0SR4_23_20)	IP0SR4_23_20	FM(IP1SR4_23_20)	IP1SR4_23_20	FM(IP2SR4_23_20)	IP2SR4_23_20	\
+FM(IP0SR4_27_24)	IP0SR4_27_24	FM(IP1SR4_27_24)	IP1SR4_27_24	FM(IP2SR4_27_24)	IP2SR4_27_24	\
+FM(IP0SR4_31_28)	IP0SR4_31_28	FM(IP1SR4_31_28)	IP1SR4_31_28	FM(IP2SR4_31_28)	IP2SR4_31_28	\
+\
+FM(IP0SR5_3_0)		IP0SR5_3_0	FM(IP1SR5_3_0)		IP1SR5_3_0	FM(IP2SR5_3_0)		IP2SR5_3_0	\
+FM(IP0SR5_7_4)		IP0SR5_7_4	FM(IP1SR5_7_4)		IP1SR5_7_4	FM(IP2SR5_7_4)		IP2SR5_7_4	\
+FM(IP0SR5_11_8)		IP0SR5_11_8	FM(IP1SR5_11_8)		IP1SR5_11_8	FM(IP2SR5_11_8)		IP2SR5_11_8	\
+FM(IP0SR5_15_12)	IP0SR5_15_12	FM(IP1SR5_15_12)	IP1SR5_15_12	FM(IP2SR5_15_12)	IP2SR5_15_12	\
+FM(IP0SR5_19_16)	IP0SR5_19_16	FM(IP1SR5_19_16)	IP1SR5_19_16	FM(IP2SR5_19_16)	IP2SR5_19_16	\
+FM(IP0SR5_23_20)	IP0SR5_23_20	FM(IP1SR5_23_20)	IP1SR5_23_20	\
+FM(IP0SR5_27_24)	IP0SR5_27_24	FM(IP1SR5_27_24)	IP1SR5_27_24	\
+FM(IP0SR5_31_28)	IP0SR5_31_28	FM(IP1SR5_31_28)	IP1SR5_31_28	\
+\
 FM(IP0SR6_3_0)		IP0SR6_3_0	FM(IP1SR6_3_0)		IP1SR6_3_0	FM(IP2SR6_3_0)		IP2SR6_3_0	\
 FM(IP0SR6_7_4)		IP0SR6_7_4	FM(IP1SR6_7_4)		IP1SR6_7_4	FM(IP2SR6_7_4)		IP2SR6_7_4	\
 FM(IP0SR6_11_8)		IP0SR6_11_8	FM(IP1SR6_11_8)		IP1SR6_11_8	FM(IP2SR6_11_8)		IP2SR6_11_8	\
@@ -572,54 +658,6 @@ FM(IP0SR8_23_20)	IP0SR8_23_20	FM(IP1SR8_23_20)	IP1SR8_23_20	\
 FM(IP0SR8_27_24)	IP0SR8_27_24	\
 FM(IP0SR8_31_28)	IP0SR8_31_28
 
-/* MOD_SEL4 */			/* 0 */				/* 1 */
-#define MOD_SEL4_19		FM(SEL_TSN0_TD2_0)		FM(SEL_TSN0_TD2_1)
-#define MOD_SEL4_18		FM(SEL_TSN0_TD3_0)		FM(SEL_TSN0_TD3_1)
-#define MOD_SEL4_15		FM(SEL_TSN0_TD0_0)		FM(SEL_TSN0_TD0_1)
-#define MOD_SEL4_14		FM(SEL_TSN0_TD1_0)		FM(SEL_TSN0_TD1_1)
-#define MOD_SEL4_12		FM(SEL_TSN0_TXC_0)		FM(SEL_TSN0_TXC_1)
-#define MOD_SEL4_9		FM(SEL_TSN0_TX_CTL_0)		FM(SEL_TSN0_TX_CTL_1)
-#define MOD_SEL4_8		FM(SEL_TSN0_AVTP_PPS0_0)	FM(SEL_TSN0_AVTP_PPS0_1)
-#define MOD_SEL4_5		FM(SEL_TSN0_AVTP_MATCH_0)	FM(SEL_TSN0_AVTP_MATCH_1)
-#define MOD_SEL4_2		FM(SEL_TSN0_AVTP_PPS1_0)	FM(SEL_TSN0_AVTP_PPS1_1)
-#define MOD_SEL4_1		FM(SEL_TSN0_MDC_0)		FM(SEL_TSN0_MDC_1)
-
-/* MOD_SEL5 */			/* 0 */				/* 1 */
-#define MOD_SEL5_19		FM(SEL_AVB2_TX_CTL_0)		FM(SEL_AVB2_TX_CTL_1)
-#define MOD_SEL5_16		FM(SEL_AVB2_TXC_0)		FM(SEL_AVB2_TXC_1)
-#define MOD_SEL5_15		FM(SEL_AVB2_TD0_0)		FM(SEL_AVB2_TD0_1)
-#define MOD_SEL5_12		FM(SEL_AVB2_TD1_0)		FM(SEL_AVB2_TD1_1)
-#define MOD_SEL5_11		FM(SEL_AVB2_TD2_0)		FM(SEL_AVB2_TD2_1)
-#define MOD_SEL5_8		FM(SEL_AVB2_TD3_0)		FM(SEL_AVB2_TD3_1)
-#define MOD_SEL5_6		FM(SEL_AVB2_MDC_0)		FM(SEL_AVB2_MDC_1)
-#define MOD_SEL5_5		FM(SEL_AVB2_MAGIC_0)		FM(SEL_AVB2_MAGIC_1)
-#define MOD_SEL5_2		FM(SEL_AVB2_AVTP_MATCH_0)	FM(SEL_AVB2_AVTP_MATCH_1)
-#define MOD_SEL5_0		FM(SEL_AVB2_AVTP_PPS_0)		FM(SEL_AVB2_AVTP_PPS_1)
-
-/* MOD_SEL6 */			/* 0 */				/* 1 */
-#define MOD_SEL6_18		FM(SEL_AVB1_TD3_0)		FM(SEL_AVB1_TD3_1)
-#define MOD_SEL6_16		FM(SEL_AVB1_TD2_0)		FM(SEL_AVB1_TD2_1)
-#define MOD_SEL6_13		FM(SEL_AVB1_TD0_0)		FM(SEL_AVB1_TD0_1)
-#define MOD_SEL6_12		FM(SEL_AVB1_TD1_0)		FM(SEL_AVB1_TD1_1)
-#define MOD_SEL6_10		FM(SEL_AVB1_AVTP_PPS_0)		FM(SEL_AVB1_AVTP_PPS_1)
-#define MOD_SEL6_7		FM(SEL_AVB1_TX_CTL_0)		FM(SEL_AVB1_TX_CTL_1)
-#define MOD_SEL6_6		FM(SEL_AVB1_TXC_0)		FM(SEL_AVB1_TXC_1)
-#define MOD_SEL6_5		FM(SEL_AVB1_AVTP_MATCH_0)	FM(SEL_AVB1_AVTP_MATCH_1)
-#define MOD_SEL6_2		FM(SEL_AVB1_MDC_0)		FM(SEL_AVB1_MDC_1)
-#define MOD_SEL6_1		FM(SEL_AVB1_MAGIC_0)		FM(SEL_AVB1_MAGIC_1)
-
-/* MOD_SEL7 */			/* 0 */				/* 1 */
-#define MOD_SEL7_16		FM(SEL_AVB0_TX_CTL_0)		FM(SEL_AVB0_TX_CTL_1)
-#define MOD_SEL7_15		FM(SEL_AVB0_TXC_0)		FM(SEL_AVB0_TXC_1)
-#define MOD_SEL7_13		FM(SEL_AVB0_MDC_0)		FM(SEL_AVB0_MDC_1)
-#define MOD_SEL7_11		FM(SEL_AVB0_TD0_0)		FM(SEL_AVB0_TD0_1)
-#define MOD_SEL7_10		FM(SEL_AVB0_MAGIC_0)		FM(SEL_AVB0_MAGIC_1)
-#define MOD_SEL7_7		FM(SEL_AVB0_TD1_0)		FM(SEL_AVB0_TD1_1)
-#define MOD_SEL7_6		FM(SEL_AVB0_TD2_0)		FM(SEL_AVB0_TD2_1)
-#define MOD_SEL7_3		FM(SEL_AVB0_TD3_0)		FM(SEL_AVB0_TD3_1)
-#define MOD_SEL7_2		FM(SEL_AVB0_AVTP_MATCH_0)	FM(SEL_AVB0_AVTP_MATCH_1)
-#define MOD_SEL7_0		FM(SEL_AVB0_AVTP_PPS_0)		FM(SEL_AVB0_AVTP_PPS_1)
-
 /* MOD_SEL8 */			/* 0 */				/* 1 */
 #define MOD_SEL8_11		FM(SEL_SDA5_0)			FM(SEL_SDA5_1)
 #define MOD_SEL8_10		FM(SEL_SCL5_0)			FM(SEL_SCL5_1)
@@ -636,26 +674,18 @@ FM(IP0SR8_31_28)	IP0SR8_31_28
 
 #define PINMUX_MOD_SELS \
 \
-MOD_SEL4_19		MOD_SEL5_19										\
-MOD_SEL4_18					MOD_SEL6_18							\
-														\
-			MOD_SEL5_16		MOD_SEL6_16		MOD_SEL7_16				\
-MOD_SEL4_15		MOD_SEL5_15					MOD_SEL7_15				\
-MOD_SEL4_14													\
-						MOD_SEL6_13		MOD_SEL7_13				\
-MOD_SEL4_12		MOD_SEL5_12		MOD_SEL6_12							\
-			MOD_SEL5_11					MOD_SEL7_11		MOD_SEL8_11	\
-						MOD_SEL6_10		MOD_SEL7_10		MOD_SEL8_10	\
-MOD_SEL4_9											MOD_SEL8_9	\
-MOD_SEL4_8		MOD_SEL5_8								MOD_SEL8_8	\
-						MOD_SEL6_7		MOD_SEL7_7		MOD_SEL8_7	\
-			MOD_SEL5_6		MOD_SEL6_6		MOD_SEL7_6		MOD_SEL8_6	\
-MOD_SEL4_5		MOD_SEL5_5		MOD_SEL6_5					MOD_SEL8_5	\
-												MOD_SEL8_4	\
-									MOD_SEL7_3		MOD_SEL8_3	\
-MOD_SEL4_2		MOD_SEL5_2		MOD_SEL6_2		MOD_SEL7_2		MOD_SEL8_2	\
-MOD_SEL4_1					MOD_SEL6_1					MOD_SEL8_1	\
-			MOD_SEL5_0					MOD_SEL7_0		MOD_SEL8_0
+MOD_SEL8_11	\
+MOD_SEL8_10	\
+MOD_SEL8_9	\
+MOD_SEL8_8	\
+MOD_SEL8_7	\
+MOD_SEL8_6	\
+MOD_SEL8_5	\
+MOD_SEL8_4	\
+MOD_SEL8_3	\
+MOD_SEL8_2	\
+MOD_SEL8_1	\
+MOD_SEL8_0
 
 enum {
 	PINMUX_RESERVED = 0,
@@ -689,61 +719,8 @@ enum {
 static const u16 pinmux_data[] = {
 	PINMUX_DATA_GP_ALL(),
 
-	PINMUX_SINGLE(AVS1),
-	PINMUX_SINGLE(AVS0),
-	PINMUX_SINGLE(PCIE1_CLKREQ_N),
-	PINMUX_SINGLE(PCIE0_CLKREQ_N),
-
-	/* TSN0 without MODSEL4 */
-	PINMUX_SINGLE(TSN0_TXCREFCLK),
-	PINMUX_SINGLE(TSN0_RD2),
-	PINMUX_SINGLE(TSN0_RD3),
-	PINMUX_SINGLE(TSN0_RD1),
-	PINMUX_SINGLE(TSN0_RXC),
-	PINMUX_SINGLE(TSN0_RD0),
-	PINMUX_SINGLE(TSN0_RX_CTL),
-	PINMUX_SINGLE(TSN0_AVTP_CAPTURE),
-	PINMUX_SINGLE(TSN0_LINK),
-	PINMUX_SINGLE(TSN0_PHY_INT),
-	PINMUX_SINGLE(TSN0_MDIO),
-	/* TSN0 with MODSEL4 */
-	PINMUX_IPSR_NOGM(0, TSN0_TD2,		SEL_TSN0_TD2_1),
-	PINMUX_IPSR_NOGM(0, TSN0_TD3,		SEL_TSN0_TD3_1),
-	PINMUX_IPSR_NOGM(0, TSN0_TD0,		SEL_TSN0_TD0_1),
-	PINMUX_IPSR_NOGM(0, TSN0_TD1,		SEL_TSN0_TD1_1),
-	PINMUX_IPSR_NOGM(0, TSN0_TXC,		SEL_TSN0_TXC_1),
-	PINMUX_IPSR_NOGM(0, TSN0_TX_CTL,	SEL_TSN0_TX_CTL_1),
-	PINMUX_IPSR_NOGM(0, TSN0_AVTP_PPS0,	SEL_TSN0_AVTP_PPS0_1),
-	PINMUX_IPSR_NOGM(0, TSN0_AVTP_MATCH,	SEL_TSN0_AVTP_MATCH_1),
-	PINMUX_IPSR_NOGM(0, TSN0_AVTP_PPS1,	SEL_TSN0_AVTP_PPS1_1),
-	PINMUX_IPSR_NOGM(0, TSN0_MDC,		SEL_TSN0_MDC_1),
-
-	/* TSN0 without MODSEL5 */
-	PINMUX_SINGLE(AVB2_RX_CTL),
-	PINMUX_SINGLE(AVB2_RXC),
-	PINMUX_SINGLE(AVB2_RD0),
-	PINMUX_SINGLE(AVB2_RD1),
-	PINMUX_SINGLE(AVB2_RD2),
-	PINMUX_SINGLE(AVB2_MDIO),
-	PINMUX_SINGLE(AVB2_RD3),
-	PINMUX_SINGLE(AVB2_TXCREFCLK),
-	PINMUX_SINGLE(AVB2_PHY_INT),
-	PINMUX_SINGLE(AVB2_LINK),
-	PINMUX_SINGLE(AVB2_AVTP_CAPTURE),
-	/* TSN0 with MODSEL5 */
-	PINMUX_IPSR_NOGM(0, AVB2_TX_CTL,	SEL_AVB2_TX_CTL_1),
-	PINMUX_IPSR_NOGM(0, AVB2_TXC,		SEL_AVB2_TXC_1),
-	PINMUX_IPSR_NOGM(0, AVB2_TD0,		SEL_AVB2_TD0_1),
-	PINMUX_IPSR_NOGM(0, AVB2_TD1,		SEL_AVB2_TD1_1),
-	PINMUX_IPSR_NOGM(0, AVB2_TD2,		SEL_AVB2_TD2_1),
-	PINMUX_IPSR_NOGM(0, AVB2_TD3,		SEL_AVB2_TD3_1),
-	PINMUX_IPSR_NOGM(0, AVB2_MDC,		SEL_AVB2_MDC_1),
-	PINMUX_IPSR_NOGM(0, AVB2_MAGIC,		SEL_AVB2_MAGIC_1),
-	PINMUX_IPSR_NOGM(0, AVB2_AVTP_MATCH,	SEL_AVB2_AVTP_MATCH_1),
-	PINMUX_IPSR_NOGM(0, AVB2_AVTP_PPS,	SEL_AVB2_AVTP_PPS_1),
-
 	/* IP0SR0 */
-	PINMUX_IPSR_GPSR(IP0SR0_3_0,	ERROROUTC_B),
+	PINMUX_IPSR_GPSR(IP0SR0_3_0,	ERROROUTC_N_B),
 	PINMUX_IPSR_GPSR(IP0SR0_3_0,	TCLK2_A),
 
 	PINMUX_IPSR_GPSR(IP0SR0_7_4,	MSIOF3_SS1),
@@ -1009,7 +986,7 @@ static const u16 pinmux_data[] = {
 
 	PINMUX_IPSR_GPSR(IP1SR3_27_24,	IPC_CLKOUT),
 	PINMUX_IPSR_GPSR(IP1SR3_27_24,	IPC_CLKEN_OUT),
-	PINMUX_IPSR_GPSR(IP1SR3_27_24,	ERROROUTC_A),
+	PINMUX_IPSR_GPSR(IP1SR3_27_24,	ERROROUTC_N_A),
 	PINMUX_IPSR_GPSR(IP1SR3_27_24,	TCLK4_X),
 
 	PINMUX_IPSR_GPSR(IP1SR3_31_28,	QSPI0_SSL),
@@ -1032,26 +1009,86 @@ static const u16 pinmux_data[] = {
 	PINMUX_IPSR_GPSR(IP3SR3_19_16,	RPC_WP_N),
 	PINMUX_IPSR_GPSR(IP3SR3_23_20,	RPC_INT_N),
 
+	/* IP0SR4 */
+	PINMUX_IPSR_GPSR(IP0SR4_3_0,	TSN0_MDIO),
+	PINMUX_IPSR_GPSR(IP0SR4_7_4,	TSN0_MDC),
+	PINMUX_IPSR_GPSR(IP0SR4_11_8,	TSN0_AVTP_PPS1),
+	PINMUX_IPSR_GPSR(IP0SR4_15_12,	TSN0_PHY_INT),
+	PINMUX_IPSR_GPSR(IP0SR4_19_16,	TSN0_LINK),
+	PINMUX_IPSR_GPSR(IP0SR4_23_20,	TSN0_AVTP_MATCH),
+	PINMUX_IPSR_GPSR(IP0SR4_27_24,	TSN0_AVTP_CAPTURE),
+	PINMUX_IPSR_GPSR(IP0SR4_31_28,	TSN0_RX_CTL),
+
+	/* IP1SR4 */
+	PINMUX_IPSR_GPSR(IP1SR4_3_0,	TSN0_AVTP_PPS0),
+	PINMUX_IPSR_GPSR(IP1SR4_7_4,	TSN0_TX_CTL),
+	PINMUX_IPSR_GPSR(IP1SR4_11_8,	TSN0_RD0),
+	PINMUX_IPSR_GPSR(IP1SR4_15_12,	TSN0_RXC),
+	PINMUX_IPSR_GPSR(IP1SR4_19_16,	TSN0_TXC),
+	PINMUX_IPSR_GPSR(IP1SR4_23_20,	TSN0_RD1),
+	PINMUX_IPSR_GPSR(IP1SR4_27_24,	TSN0_TD1),
+	PINMUX_IPSR_GPSR(IP1SR4_31_28,	TSN0_TD0),
+
+	/* IP2SR4 */
+	PINMUX_IPSR_GPSR(IP2SR4_3_0,	TSN0_RD3),
+	PINMUX_IPSR_GPSR(IP2SR4_7_4,	TSN0_RD2),
+	PINMUX_IPSR_GPSR(IP2SR4_11_8,	TSN0_TD3),
+	PINMUX_IPSR_GPSR(IP2SR4_15_12,	TSN0_TD2),
+	PINMUX_IPSR_GPSR(IP2SR4_19_16,	TSN0_TXCREFCLK),
+	PINMUX_IPSR_GPSR(IP2SR4_23_20,	PCIE0_CLKREQ_N),
+	PINMUX_IPSR_GPSR(IP2SR4_27_24,	PCIE1_CLKREQ_N),
+	PINMUX_IPSR_GPSR(IP2SR4_31_28,	AVS0),
+
+	/* IP3SR4 */
+	PINMUX_IPSR_GPSR(IP3SR4_3_0,	AVS1),
+
+	/* IP0SR5 */
+	PINMUX_IPSR_GPSR(IP0SR5_3_0,	AVB2_AVTP_PPS),
+	PINMUX_IPSR_GPSR(IP0SR5_7_4,	AVB2_AVTP_CAPTURE),
+	PINMUX_IPSR_GPSR(IP0SR5_11_8,	AVB2_AVTP_MATCH),
+	PINMUX_IPSR_GPSR(IP0SR5_15_12,	AVB2_LINK),
+	PINMUX_IPSR_GPSR(IP0SR5_19_16,	AVB2_PHY_INT),
+	PINMUX_IPSR_GPSR(IP0SR5_23_20,	AVB2_MAGIC),
+	PINMUX_IPSR_GPSR(IP0SR5_27_24,	AVB2_MDC),
+	PINMUX_IPSR_GPSR(IP0SR5_31_28,	AVB2_TXCREFCLK),
+
+	/* IP1SR5 */
+	PINMUX_IPSR_GPSR(IP1SR5_3_0,	AVB2_TD3),
+	PINMUX_IPSR_GPSR(IP1SR5_7_4,	AVB2_RD3),
+	PINMUX_IPSR_GPSR(IP1SR5_11_8,	AVB2_MDIO),
+	PINMUX_IPSR_GPSR(IP1SR5_15_12,	AVB2_TD2),
+	PINMUX_IPSR_GPSR(IP1SR5_19_16,	AVB2_TD1),
+	PINMUX_IPSR_GPSR(IP1SR5_23_20,	AVB2_RD2),
+	PINMUX_IPSR_GPSR(IP1SR5_27_24,	AVB2_RD1),
+	PINMUX_IPSR_GPSR(IP1SR5_31_28,	AVB2_TD0),
+
+	/* IP2SR5 */
+	PINMUX_IPSR_GPSR(IP2SR5_3_0,	AVB2_TXC),
+	PINMUX_IPSR_GPSR(IP2SR5_7_4,	AVB2_RD0),
+	PINMUX_IPSR_GPSR(IP2SR5_11_8,	AVB2_RXC),
+	PINMUX_IPSR_GPSR(IP2SR5_15_12,	AVB2_TX_CTL),
+	PINMUX_IPSR_GPSR(IP2SR5_19_16,	AVB2_RX_CTL),
+
 	/* IP0SR6 */
 	PINMUX_IPSR_GPSR(IP0SR6_3_0,	AVB1_MDIO),
 
-	PINMUX_IPSR_MSEL(IP0SR6_7_4,	AVB1_MAGIC,		SEL_AVB1_MAGIC_1),
+	PINMUX_IPSR_GPSR(IP0SR6_7_4,	AVB1_MAGIC),
 
-	PINMUX_IPSR_MSEL(IP0SR6_11_8,	AVB1_MDC,		SEL_AVB1_MDC_1),
+	PINMUX_IPSR_GPSR(IP0SR6_11_8,	AVB1_MDC),
 
 	PINMUX_IPSR_GPSR(IP0SR6_15_12,	AVB1_PHY_INT),
 
 	PINMUX_IPSR_GPSR(IP0SR6_19_16,	AVB1_LINK),
 	PINMUX_IPSR_GPSR(IP0SR6_19_16,	AVB1_MII_TX_ER),
 
-	PINMUX_IPSR_MSEL(IP0SR6_23_20,	AVB1_AVTP_MATCH,	SEL_AVB1_AVTP_MATCH_1),
-	PINMUX_IPSR_MSEL(IP0SR6_23_20,	AVB1_MII_RX_ER,		SEL_AVB1_AVTP_MATCH_0),
+	PINMUX_IPSR_GPSR(IP0SR6_23_20,	AVB1_AVTP_MATCH),
+	PINMUX_IPSR_GPSR(IP0SR6_23_20,	AVB1_MII_RX_ER),
 
-	PINMUX_IPSR_MSEL(IP0SR6_27_24,	AVB1_TXC,		SEL_AVB1_TXC_1),
-	PINMUX_IPSR_MSEL(IP0SR6_27_24,	AVB1_MII_TXC,		SEL_AVB1_TXC_0),
+	PINMUX_IPSR_GPSR(IP0SR6_27_24,	AVB1_TXC),
+	PINMUX_IPSR_GPSR(IP0SR6_27_24,	AVB1_MII_TXC),
 
-	PINMUX_IPSR_MSEL(IP0SR6_31_28,	AVB1_TX_CTL,		SEL_AVB1_TX_CTL_1),
-	PINMUX_IPSR_MSEL(IP0SR6_31_28,	AVB1_MII_TX_EN,		SEL_AVB1_TX_CTL_0),
+	PINMUX_IPSR_GPSR(IP0SR6_31_28,	AVB1_TX_CTL),
+	PINMUX_IPSR_GPSR(IP0SR6_31_28,	AVB1_MII_TX_EN),
 
 	/* IP1SR6 */
 	PINMUX_IPSR_GPSR(IP1SR6_3_0,	AVB1_RXC),
@@ -1060,17 +1097,17 @@ static const u16 pinmux_data[] = {
 	PINMUX_IPSR_GPSR(IP1SR6_7_4,	AVB1_RX_CTL),
 	PINMUX_IPSR_GPSR(IP1SR6_7_4,	AVB1_MII_RX_DV),
 
-	PINMUX_IPSR_MSEL(IP1SR6_11_8,	AVB1_AVTP_PPS,		SEL_AVB1_AVTP_PPS_1),
-	PINMUX_IPSR_MSEL(IP1SR6_11_8,	AVB1_MII_COL,		SEL_AVB1_AVTP_PPS_0),
+	PINMUX_IPSR_GPSR(IP1SR6_11_8,	AVB1_AVTP_PPS),
+	PINMUX_IPSR_GPSR(IP1SR6_11_8,	AVB1_MII_COL),
 
 	PINMUX_IPSR_GPSR(IP1SR6_15_12,	AVB1_AVTP_CAPTURE),
 	PINMUX_IPSR_GPSR(IP1SR6_15_12,	AVB1_MII_CRS),
 
-	PINMUX_IPSR_MSEL(IP1SR6_19_16,	AVB1_TD1,		SEL_AVB1_TD1_1),
-	PINMUX_IPSR_MSEL(IP1SR6_19_16,	AVB1_MII_TD1,		SEL_AVB1_TD1_0),
+	PINMUX_IPSR_GPSR(IP1SR6_19_16,	AVB1_TD1),
+	PINMUX_IPSR_GPSR(IP1SR6_19_16,	AVB1_MII_TD1),
 
-	PINMUX_IPSR_MSEL(IP1SR6_23_20,	AVB1_TD0,		SEL_AVB1_TD0_1),
-	PINMUX_IPSR_MSEL(IP1SR6_23_20,	AVB1_MII_TD0,		SEL_AVB1_TD0_0),
+	PINMUX_IPSR_GPSR(IP1SR6_23_20,	AVB1_TD0),
+	PINMUX_IPSR_GPSR(IP1SR6_23_20,	AVB1_MII_TD0),
 
 	PINMUX_IPSR_GPSR(IP1SR6_27_24,	AVB1_RD1),
 	PINMUX_IPSR_GPSR(IP1SR6_27_24,	AVB1_MII_RD1),
@@ -1079,14 +1116,14 @@ static const u16 pinmux_data[] = {
 	PINMUX_IPSR_GPSR(IP1SR6_31_28,	AVB1_MII_RD0),
 
 	/* IP2SR6 */
-	PINMUX_IPSR_MSEL(IP2SR6_3_0,	AVB1_TD2,		SEL_AVB1_TD2_1),
-	PINMUX_IPSR_MSEL(IP2SR6_3_0,	AVB1_MII_TD2,		SEL_AVB1_TD2_0),
+	PINMUX_IPSR_GPSR(IP2SR6_3_0,	AVB1_TD2),
+	PINMUX_IPSR_GPSR(IP2SR6_3_0,	AVB1_MII_TD2),
 
 	PINMUX_IPSR_GPSR(IP2SR6_7_4,	AVB1_RD2),
 	PINMUX_IPSR_GPSR(IP2SR6_7_4,	AVB1_MII_RD2),
 
-	PINMUX_IPSR_MSEL(IP2SR6_11_8,	AVB1_TD3,		SEL_AVB1_TD3_1),
-	PINMUX_IPSR_MSEL(IP2SR6_11_8,	AVB1_MII_TD3,		SEL_AVB1_TD3_0),
+	PINMUX_IPSR_GPSR(IP2SR6_11_8,	AVB1_TD3),
+	PINMUX_IPSR_GPSR(IP2SR6_11_8,	AVB1_MII_TD3),
 
 	PINMUX_IPSR_GPSR(IP2SR6_15_12,	AVB1_RD3),
 	PINMUX_IPSR_GPSR(IP2SR6_15_12,	AVB1_MII_RD3),
@@ -1094,29 +1131,29 @@ static const u16 pinmux_data[] = {
 	PINMUX_IPSR_GPSR(IP2SR6_19_16,	AVB1_TXCREFCLK),
 
 	/* IP0SR7 */
-	PINMUX_IPSR_MSEL(IP0SR7_3_0,	AVB0_AVTP_PPS,		SEL_AVB0_AVTP_PPS_1),
-	PINMUX_IPSR_MSEL(IP0SR7_3_0,	AVB0_MII_COL,		SEL_AVB0_AVTP_PPS_0),
+	PINMUX_IPSR_GPSR(IP0SR7_3_0,	AVB0_AVTP_PPS),
+	PINMUX_IPSR_GPSR(IP0SR7_3_0,	AVB0_MII_COL),
 
 	PINMUX_IPSR_GPSR(IP0SR7_7_4,	AVB0_AVTP_CAPTURE),
 	PINMUX_IPSR_GPSR(IP0SR7_7_4,	AVB0_MII_CRS),
 
-	PINMUX_IPSR_MSEL(IP0SR7_11_8,	AVB0_AVTP_MATCH,	SEL_AVB0_AVTP_MATCH_1),
-	PINMUX_IPSR_MSEL(IP0SR7_11_8,	AVB0_MII_RX_ER,		SEL_AVB0_AVTP_MATCH_0),
-	PINMUX_IPSR_MSEL(IP0SR7_11_8,	CC5_OSCOUT,		SEL_AVB0_AVTP_MATCH_0),
+	PINMUX_IPSR_GPSR(IP0SR7_11_8,	AVB0_AVTP_MATCH),
+	PINMUX_IPSR_GPSR(IP0SR7_11_8,	AVB0_MII_RX_ER),
+	PINMUX_IPSR_GPSR(IP0SR7_11_8,	CC5_OSCOUT),
 
-	PINMUX_IPSR_MSEL(IP0SR7_15_12,	AVB0_TD3,		SEL_AVB0_TD3_1),
-	PINMUX_IPSR_MSEL(IP0SR7_15_12,	AVB0_MII_TD3,		SEL_AVB0_TD3_0),
+	PINMUX_IPSR_GPSR(IP0SR7_15_12,	AVB0_TD3),
+	PINMUX_IPSR_GPSR(IP0SR7_15_12,	AVB0_MII_TD3),
 
 	PINMUX_IPSR_GPSR(IP0SR7_19_16,	AVB0_LINK),
 	PINMUX_IPSR_GPSR(IP0SR7_19_16,	AVB0_MII_TX_ER),
 
 	PINMUX_IPSR_GPSR(IP0SR7_23_20,	AVB0_PHY_INT),
 
-	PINMUX_IPSR_MSEL(IP0SR7_27_24,	AVB0_TD2,		SEL_AVB0_TD2_1),
-	PINMUX_IPSR_MSEL(IP0SR7_27_24,	AVB0_MII_TD2,		SEL_AVB0_TD2_0),
+	PINMUX_IPSR_GPSR(IP0SR7_27_24,	AVB0_TD2),
+	PINMUX_IPSR_GPSR(IP0SR7_27_24,	AVB0_MII_TD2),
 
-	PINMUX_IPSR_MSEL(IP0SR7_31_28,	AVB0_TD1,		SEL_AVB0_TD1_1),
-	PINMUX_IPSR_MSEL(IP0SR7_31_28,	AVB0_MII_TD1,		SEL_AVB0_TD1_0),
+	PINMUX_IPSR_GPSR(IP0SR7_31_28,	AVB0_TD1),
+	PINMUX_IPSR_GPSR(IP0SR7_31_28,	AVB0_MII_TD1),
 
 	/* IP1SR7 */
 	PINMUX_IPSR_GPSR(IP1SR7_3_0,	AVB0_RD3),
@@ -1124,24 +1161,24 @@ static const u16 pinmux_data[] = {
 
 	PINMUX_IPSR_GPSR(IP1SR7_7_4,	AVB0_TXCREFCLK),
 
-	PINMUX_IPSR_MSEL(IP1SR7_11_8,	AVB0_MAGIC,		SEL_AVB0_MAGIC_1),
+	PINMUX_IPSR_GPSR(IP1SR7_11_8,	AVB0_MAGIC),
 
-	PINMUX_IPSR_MSEL(IP1SR7_15_12,	AVB0_TD0,		SEL_AVB0_TD0_1),
-	PINMUX_IPSR_MSEL(IP1SR7_15_12,	AVB0_MII_TD0,		SEL_AVB0_TD0_0),
+	PINMUX_IPSR_GPSR(IP1SR7_15_12,	AVB0_TD0),
+	PINMUX_IPSR_GPSR(IP1SR7_15_12,	AVB0_MII_TD0),
 
 	PINMUX_IPSR_GPSR(IP1SR7_19_16,	AVB0_RD2),
 	PINMUX_IPSR_GPSR(IP1SR7_19_16,	AVB0_MII_RD2),
 
-	PINMUX_IPSR_MSEL(IP1SR7_23_20,	AVB0_MDC,		SEL_AVB0_MDC_1),
+	PINMUX_IPSR_GPSR(IP1SR7_23_20,	AVB0_MDC),
 
 	PINMUX_IPSR_GPSR(IP1SR7_27_24,	AVB0_MDIO),
 
-	PINMUX_IPSR_MSEL(IP1SR7_31_28,	AVB0_TXC,		SEL_AVB0_TXC_1),
-	PINMUX_IPSR_MSEL(IP1SR7_31_28,	AVB0_MII_TXC,		SEL_AVB0_TXC_0),
+	PINMUX_IPSR_GPSR(IP1SR7_31_28,	AVB0_TXC),
+	PINMUX_IPSR_GPSR(IP1SR7_31_28,	AVB0_MII_TXC),
 
 	/* IP2SR7 */
-	PINMUX_IPSR_MSEL(IP2SR7_3_0,	AVB0_TX_CTL,		SEL_AVB0_TX_CTL_1),
-	PINMUX_IPSR_MSEL(IP2SR7_3_0,	AVB0_MII_TX_EN,		SEL_AVB0_TX_CTL_0),
+	PINMUX_IPSR_GPSR(IP2SR7_3_0,	AVB0_TX_CTL),
+	PINMUX_IPSR_GPSR(IP2SR7_3_0,	AVB0_MII_TX_EN),
 
 	PINMUX_IPSR_GPSR(IP2SR7_7_4,	AVB0_RD1),
 	PINMUX_IPSR_GPSR(IP2SR7_7_4,	AVB0_MII_RD1),
@@ -1193,10 +1230,28 @@ static const u16 pinmux_data[] = {
  */
 enum {
 	GP_ASSIGN_LAST(),
+	NOGP_ALL(),
 };
 
 static const struct sh_pfc_pin pinmux_pins[] = {
 	PINMUX_GPIO_GP_ALL(),
+	PINMUX_NOGP_ALL(),
+};
+
+/* - AUDIO CLOCK ----------------------------------------- */
+static const unsigned int audio_clkin_pins[] = {
+	/* CLK IN */
+	RCAR_GP_PIN(1, 22),
+};
+static const unsigned int audio_clkin_mux[] = {
+	AUDIO_CLKIN_MARK,
+};
+static const unsigned int audio_clkout_pins[] = {
+	/* CLK OUT */
+	RCAR_GP_PIN(1, 21),
+};
+static const unsigned int audio_clkout_mux[] = {
+	AUDIO_CLKOUT_MARK,
 };
 
 /* - AVB0 ------------------------------------------------ */
@@ -2332,6 +2387,22 @@ static const unsigned int scif_clk_mux[] = {
 	SCIF_CLK_MARK,
 };
 
+/* - SSI ------------------------------------------------- */
+static const unsigned int ssi_data_pins[] = {
+	/* SSI_SD */
+	RCAR_GP_PIN(1, 20),
+};
+static const unsigned int ssi_data_mux[] = {
+	SSI_SD_MARK,
+};
+static const unsigned int ssi_ctrl_pins[] = {
+	/* SSI_SCK,  SSI_WS */
+	RCAR_GP_PIN(1, 18), RCAR_GP_PIN(1, 19),
+};
+static const unsigned int ssi_ctrl_mux[] = {
+	SSI_SCK_MARK, SSI_WS_MARK,
+};
+
 /* - TPU ------------------------------------------------------------------- */
 static const unsigned int tpu_to0_pins[] = {
 	/* TPU0TO0 */
@@ -2464,6 +2535,9 @@ static const unsigned int tsn0_avtp_match_mux[] = {
 };
 
 static const struct sh_pfc_pin_group pinmux_groups[] = {
+	SH_PFC_PIN_GROUP(audio_clkin),
+	SH_PFC_PIN_GROUP(audio_clkout),
+
 	SH_PFC_PIN_GROUP(avb0_link),
 	SH_PFC_PIN_GROUP(avb0_magic),
 	SH_PFC_PIN_GROUP(avb0_phy_int),
@@ -2624,6 +2698,9 @@ static const struct sh_pfc_pin_group pinmux_groups[] = {
 	SH_PFC_PIN_GROUP(scif4_ctrl),
 	SH_PFC_PIN_GROUP(scif_clk),
 
+	SH_PFC_PIN_GROUP(ssi_data),
+	SH_PFC_PIN_GROUP(ssi_ctrl),
+
 	SH_PFC_PIN_GROUP(tpu_to0),		/* suffix might be updated */
 	SH_PFC_PIN_GROUP(tpu_to0_a),		/* suffix might be updated */
 	SH_PFC_PIN_GROUP(tpu_to1),		/* suffix might be updated */
@@ -2643,6 +2720,11 @@ static const struct sh_pfc_pin_group pinmux_groups[] = {
 	SH_PFC_PIN_GROUP(tsn0_avtp_match),
 };
 
+static const char * const audio_clk_groups[] = {
+	"audio_clkin",
+	"audio_clkout",
+};
+
 static const char * const avb0_groups[] = {
 	"avb0_link",
 	"avb0_magic",
@@ -2936,6 +3018,11 @@ static const char * const scif_clk_groups[] = {
 	"scif_clk",
 };
 
+static const char * const ssi_groups[] = {
+	"ssi_data",
+	"ssi_ctrl",
+};
+
 static const char * const tpu_groups[] = {
 	/* suffix might be updated */
 	"tpu_to0",
@@ -2960,6 +3047,8 @@ static const char * const tsn0_groups[] = {
 };
 
 static const struct sh_pfc_function pinmux_functions[] = {
+	SH_PFC_FUNCTION(audio_clk),
+
 	SH_PFC_FUNCTION(avb0),
 	SH_PFC_FUNCTION(avb1),
 	SH_PFC_FUNCTION(avb2),
@@ -3017,6 +3106,8 @@ static const struct sh_pfc_function pinmux_functions[] = {
 	SH_PFC_FUNCTION(scif4),
 	SH_PFC_FUNCTION(scif_clk),
 
+	SH_PFC_FUNCTION(ssi),
+
 	SH_PFC_FUNCTION(tpu),
 
 	SH_PFC_FUNCTION(tsn0),
@@ -3422,6 +3513,82 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		IP3SR3_7_4
 		IP3SR3_3_0))
 	},
+	{ PINMUX_CFG_REG_VAR("IP0SR4", 0xE6060060, 32,
+			     GROUP(4, 4, 4, 4, 4, 4, 4, 4),
+			     GROUP(
+		IP0SR4_31_28
+		IP0SR4_27_24
+		IP0SR4_23_20
+		IP0SR4_19_16
+		IP0SR4_15_12
+		IP0SR4_11_8
+		IP0SR4_7_4
+		IP0SR4_3_0))
+	},
+	{ PINMUX_CFG_REG_VAR("IP1SR4", 0xE6060064, 32,
+			     GROUP(4, 4, 4, 4, 4, 4, 4, 4),
+			     GROUP(
+		IP1SR4_31_28
+		IP1SR4_27_24
+		IP1SR4_23_20
+		IP1SR4_19_16
+		IP1SR4_15_12
+		IP1SR4_11_8
+		IP1SR4_7_4
+		IP1SR4_3_0))
+	},
+	{ PINMUX_CFG_REG_VAR("IP2SR4", 0xE6060068, 32,
+			     GROUP(4, 4, 4, 4, 4, 4, 4, 4),
+			     GROUP(
+		IP2SR4_31_28
+		IP2SR4_27_24
+		IP2SR4_23_20
+		IP2SR4_19_16
+		IP2SR4_15_12
+		IP2SR4_11_8
+		IP2SR4_7_4
+		IP2SR4_3_0))
+	},
+	{ PINMUX_CFG_REG_VAR("IP3SR4", 0xE606006C, 32,
+			     GROUP(-28, 4),
+			     GROUP(
+		/* IP3SR4_31_4 RESERVED */
+		IP3SR4_3_0))
+	},
+	{ PINMUX_CFG_REG_VAR("IP0SR5", 0xE6060860, 32,
+			     GROUP(4, 4, 4, 4, 4, 4, 4, 4),
+			     GROUP(
+		IP0SR5_31_28
+		IP0SR5_27_24
+		IP0SR5_23_20
+		IP0SR5_19_16
+		IP0SR5_15_12
+		IP0SR5_11_8
+		IP0SR5_7_4
+		IP0SR5_3_0))
+	},
+	{ PINMUX_CFG_REG_VAR("IP1SR5", 0xE6060864, 32,
+			     GROUP(4, 4, 4, 4, 4, 4, 4, 4),
+			     GROUP(
+		IP1SR5_31_28
+		IP1SR5_27_24
+		IP1SR5_23_20
+		IP1SR5_19_16
+		IP1SR5_15_12
+		IP1SR5_11_8
+		IP1SR5_7_4
+		IP1SR5_3_0))
+	},
+	{ PINMUX_CFG_REG_VAR("IP2SR5", 0xE6060868, 32,
+			     GROUP(-12, 4, 4, 4, 4, 4),
+			     GROUP(
+		/* IP2SR5_31_20 RESERVED */
+		IP2SR5_19_16
+		IP2SR5_15_12
+		IP2SR5_11_8
+		IP2SR5_7_4
+		IP2SR5_3_0))
+	},
 	{ PINMUX_CFG_REG("IP0SR6", 0xE6061060, 32, 4, GROUP(
 		IP0SR6_31_28
 		IP0SR6_27_24
@@ -3508,95 +3675,6 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 
 #define F_(x, y)	x,
 #define FM(x)		FN_##x,
-	{ PINMUX_CFG_REG_VAR("MOD_SEL4", 0xE6060100, 32,
-			     GROUP(-12, 1, 1, -2, 1, 1, -1, 1, -2, 1, 1, -2, 1,
-				   -2, 1, 1, -1),
-			     GROUP(
-		/* RESERVED 31-20 */
-		MOD_SEL4_19
-		MOD_SEL4_18
-		/* RESERVED 17-16 */
-		MOD_SEL4_15
-		MOD_SEL4_14
-		/* RESERVED 13 */
-		MOD_SEL4_12
-		/* RESERVED 11-10 */
-		MOD_SEL4_9
-		MOD_SEL4_8
-		/* RESERVED 7-6 */
-		MOD_SEL4_5
-		/* RESERVED 4-3 */
-		MOD_SEL4_2
-		MOD_SEL4_1
-		/* RESERVED 0 */
-		))
-	},
-	{ PINMUX_CFG_REG_VAR("MOD_SEL5", 0xE6060900, 32,
-			     GROUP(-12, 1, -2, 1, 1, -2, 1, 1, -2, 1, -1,
-				   1, 1, -2, 1, -1, 1),
-			     GROUP(
-		/* RESERVED 31-20 */
-		MOD_SEL5_19
-		/* RESERVED 18-17 */
-		MOD_SEL5_16
-		MOD_SEL5_15
-		/* RESERVED 14-13 */
-		MOD_SEL5_12
-		MOD_SEL5_11
-		/* RESERVED 10-9 */
-		MOD_SEL5_8
-		/* RESERVED 7 */
-		MOD_SEL5_6
-		MOD_SEL5_5
-		/* RESERVED 4-3 */
-		MOD_SEL5_2
-		/* RESERVED 1 */
-		MOD_SEL5_0))
-	},
-	{ PINMUX_CFG_REG_VAR("MOD_SEL6", 0xE6061100, 32,
-			     GROUP(-13, 1, -1, 1, -2, 1, 1,
-				   -1, 1, -2, 1, 1, 1, -2, 1, 1, -1),
-			     GROUP(
-		/* RESERVED 31-19 */
-		MOD_SEL6_18
-		/* RESERVED 17 */
-		MOD_SEL6_16
-		/* RESERVED 15-14 */
-		MOD_SEL6_13
-		MOD_SEL6_12
-		/* RESERVED 11 */
-		MOD_SEL6_10
-		/* RESERVED 9-8 */
-		MOD_SEL6_7
-		MOD_SEL6_6
-		MOD_SEL6_5
-		/* RESERVED 4-3 */
-		MOD_SEL6_2
-		MOD_SEL6_1
-		/* RESERVED 0 */
-		))
-	},
-	{ PINMUX_CFG_REG_VAR("MOD_SEL7", 0xE6061900, 32,
-			     GROUP(-15, 1, 1, -1, 1, -1, 1, 1, -2, 1, 1,
-				   -2, 1, 1, -1, 1),
-			     GROUP(
-		/* RESERVED 31-17 */
-		MOD_SEL7_16
-		MOD_SEL7_15
-		/* RESERVED 14 */
-		MOD_SEL7_13
-		/* RESERVED 12 */
-		MOD_SEL7_11
-		MOD_SEL7_10
-		/* RESERVED 9-8 */
-		MOD_SEL7_7
-		MOD_SEL7_6
-		/* RESERVED 5-4 */
-		MOD_SEL7_3
-		MOD_SEL7_2
-		/* RESERVED 1 */
-		MOD_SEL7_0))
-	},
 	{ PINMUX_CFG_REG_VAR("MOD_SEL8", 0xE6068100, 32,
 			     GROUP(-20, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1),
 			     GROUP(
@@ -3614,7 +3692,7 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		MOD_SEL8_1
 		MOD_SEL8_0))
 	},
-	{ },
+	{ /* sentinel */ }
 };
 
 static const struct pinmux_drive_reg pinmux_drive_regs[] = {
@@ -3876,7 +3954,7 @@ static const struct pinmux_drive_reg pinmux_drive_regs[] = {
 		{ RCAR_GP_PIN(8,  9),  4, 3 },	/* SDA4 */
 		{ RCAR_GP_PIN(8,  8),  0, 3 },	/* SCL4 */
 	} },
-	{ },
+	{ /* sentinel */ }
 };
 
 enum ioctrl_regs {
@@ -3899,30 +3977,49 @@ static const struct pinmux_ioctrl_reg pinmux_ioctrl_regs[] = {
 	[POC6]		= { 0xE60610A0, },
 	[POC7]		= { 0xE60618A0, },
 	[POC8]		= { 0xE60680A0, },
-	{ /* sentinel */ },
+	{ /* sentinel */ }
 };
 
 static int r8a779g0_pin_to_pocctrl(unsigned int pin, u32 *pocctrl)
 {
 	int bit = pin & 0x1f;
 
-	*pocctrl = pinmux_ioctrl_regs[POC0].reg;
-	if (pin >= RCAR_GP_PIN(0, 0) && pin <= RCAR_GP_PIN(0, 18))
+	switch (pin) {
+	case RCAR_GP_PIN(0, 0) ... RCAR_GP_PIN(0, 18):
+		*pocctrl = pinmux_ioctrl_regs[POC0].reg;
 		return bit;
 
-	*pocctrl = pinmux_ioctrl_regs[POC1].reg;
-	if (pin >= RCAR_GP_PIN(1, 0) && pin <= RCAR_GP_PIN(1, 22))
+	case RCAR_GP_PIN(1, 0) ... RCAR_GP_PIN(1, 22):
+		*pocctrl = pinmux_ioctrl_regs[POC1].reg;
 		return bit;
 
-	*pocctrl = pinmux_ioctrl_regs[POC3].reg;
-	if (pin >= RCAR_GP_PIN(3, 0) && pin <= RCAR_GP_PIN(3, 12))
+	case RCAR_GP_PIN(3, 0) ... RCAR_GP_PIN(3, 12):
+		*pocctrl = pinmux_ioctrl_regs[POC3].reg;
 		return bit;
 
-	*pocctrl = pinmux_ioctrl_regs[POC8].reg;
-	if (pin >= RCAR_GP_PIN(8, 0) && pin <= RCAR_GP_PIN(8, 13))
+	case PIN_VDDQ_TSN0:
+		*pocctrl = pinmux_ioctrl_regs[POC4].reg;
+		return 0;
+
+	case PIN_VDDQ_AVB2:
+		*pocctrl = pinmux_ioctrl_regs[POC5].reg;
+		return 0;
+
+	case PIN_VDDQ_AVB1:
+		*pocctrl = pinmux_ioctrl_regs[POC6].reg;
+		return 0;
+
+	case PIN_VDDQ_AVB0:
+		*pocctrl = pinmux_ioctrl_regs[POC7].reg;
+		return 0;
+
+	case RCAR_GP_PIN(8, 0) ... RCAR_GP_PIN(8, 13):
+		*pocctrl = pinmux_ioctrl_regs[POC8].reg;
 		return bit;
 
-	return -EINVAL;
+	default:
+		return -EINVAL;
+	}
 }
 
 static const struct pinmux_bias_reg pinmux_bias_regs[] = {
@@ -4232,7 +4329,7 @@ static const struct pinmux_bias_reg pinmux_bias_regs[] = {
 		[30] = SH_PFC_PIN_NONE,
 		[31] = SH_PFC_PIN_NONE,
 	} },
-	{ /* sentinel */ },
+	{ /* sentinel */ }
 };
 
 static const struct sh_pfc_soc_operations r8a779g0_pin_ops = {
-- 
2.40.1

