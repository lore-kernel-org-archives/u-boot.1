Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18756EE57DB
	for <u-boot@archiver.kernel.org>; Wed, 11 Sep 2024 21:10:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1D1EC88B4B;
	Wed, 11 Sep 2024 23:10:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="UklvLxvV";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="PipHorJP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C2BC488C19; Wed, 11 Sep 2024 23:10:13 +0200 (CEST)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 175A788A74
 for <u-boot@lists.denx.de>; Wed, 11 Sep 2024 23:10:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4X3tWP5Xtbz9tg1
 for <u-boot@lists.denx.de>; Wed, 11 Sep 2024 23:10:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1726089009;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=/9mHD4r3X790b0HABu58lnX+hgR/cgrw9t7Ltu+B61s=;
 b=UklvLxvVITMYRRsQJ8J0PLmOM8nyrNz3hZ+1k2i7L3CrL7GFeUzej0ut/bZyqWivzsurRZ
 VVRH+j2fFoFSKiWsxDp/ESZz5OCd/2rVhqOmhM4O+nQ+FyIB3O3MATkCahxfx+qN4J+G5C
 5SA4XeKCIyqlTjE7nHGBomo/3BnudHLiDmbZe7WnpZBDWXgZIxxlmHrz2LA5B26vfYF51y
 cWTWSfVAd+eOMi1cTAIMOloTzmYdd9XtIowhVfL/rMydaftEL05rSXbwCyDMU+ZRYaB9/E
 q/OgMnMFuzlGED6DE5byuZmGtaAAQdruSNr34QlO06uP1lNcVGCVCQB3CF6xtw==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1726089007;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=/9mHD4r3X790b0HABu58lnX+hgR/cgrw9t7Ltu+B61s=;
 b=PipHorJPoXQKHZOSARRe/4unoynKZ90cE3f77Sp+pkdM8kMeqLORoJWkj6kGolJC0EMbUF
 wntXEqBKAepOsZ9c98GMu4mN5f9ZtIdXwn8eUg8TUVJJA2EjG2uE1iN5Py0sHUy/3rqwLA
 YRFLdN1EdjXpKXU7jCA0SRRfdKKyMoZZTUSZiSvcQtLyGege7pu64hsP1ED6d4W2ue8/cb
 KegyIsvffOs2JOadqVpd0aCSNE5YnmeYE00HSWK/cj9LcxYIjE8dPjP6rGL2eOmnHaAQ2K
 n8Y+rArdKdY82qW1RkSyelRKdKGuk+nT+LEyn/1yiSvxUbEDVvC+ASlDZaGlag==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: [PATCH 1/2] pinctrl: renesas: Synchronize R-Car R8A779G0 V4H PFC
 tables with Linux 6.10.9
Date: Wed, 11 Sep 2024 23:09:38 +0200
Message-ID: <20240911210951.175158-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: d59079fef0e3f070e70
X-MBO-RS-META: ynourz8epo9ixzt5cyj4joog399fkmqz
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

Synchronize R-Car R8A779G0 V4H PFC tables with Linux 6.10.9,
commit 1611860f184a2c9e74ed593948d43657734a7098 .

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
 drivers/pinctrl/renesas/pfc-r8a779g0.c | 830 ++++++++++++++-----------
 1 file changed, 462 insertions(+), 368 deletions(-)

diff --git a/drivers/pinctrl/renesas/pfc-r8a779g0.c b/drivers/pinctrl/renesas/pfc-r8a779g0.c
index aa58b79c24e..2a39d1c8884 100644
--- a/drivers/pinctrl/renesas/pfc-r8a779g0.c
+++ b/drivers/pinctrl/renesas/pfc-r8a779g0.c
@@ -70,20 +70,20 @@
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
 
 /* GPSR1 */
-#define GPSR1_28	F_(HTX3,		IP3SR1_19_16)
-#define GPSR1_27	F_(HCTS3_N,		IP3SR1_15_12)
-#define GPSR1_26	F_(HRTS3_N,		IP3SR1_11_8)
-#define GPSR1_25	F_(HSCK3,		IP3SR1_7_4)
-#define GPSR1_24	F_(HRX3,		IP3SR1_3_0)
+#define GPSR1_28	F_(HTX3_A,		IP3SR1_19_16)
+#define GPSR1_27	F_(HCTS3_N_A,		IP3SR1_15_12)
+#define GPSR1_26	F_(HRTS3_N_A,		IP3SR1_11_8)
+#define GPSR1_25	F_(HSCK3_A,		IP3SR1_7_4)
+#define GPSR1_24	F_(HRX3_A,		IP3SR1_3_0)
 #define GPSR1_23	F_(GP1_23,		IP2SR1_31_28)
 #define GPSR1_22	F_(AUDIO_CLKIN,		IP2SR1_27_24)
 #define GPSR1_21	F_(AUDIO_CLKOUT,	IP2SR1_23_20)
@@ -121,14 +121,14 @@
 #define GPSR2_11	F_(CANFD0_RX,		IP1SR2_15_12)
 #define GPSR2_10	F_(CANFD0_TX,		IP1SR2_11_8)
 #define GPSR2_9		F_(CAN_CLK,		IP1SR2_7_4)
-#define GPSR2_8		F_(TPU0TO0,		IP1SR2_3_0)
-#define GPSR2_7		F_(TPU0TO1,		IP0SR2_31_28)
+#define GPSR2_8		F_(TPU0TO0_A,		IP1SR2_3_0)
+#define GPSR2_7		F_(TPU0TO1_A,		IP0SR2_31_28)
 #define GPSR2_6		F_(FXR_TXDB,		IP0SR2_27_24)
-#define GPSR2_5		F_(FXR_TXENB_N,		IP0SR2_23_20)
+#define GPSR2_5		F_(FXR_TXENB_N_A,	IP0SR2_23_20)
 #define GPSR2_4		F_(RXDB_EXTFXR,		IP0SR2_19_16)
 #define GPSR2_3		F_(CLK_EXTFXR,		IP0SR2_15_12)
 #define GPSR2_2		F_(RXDA_EXTFXR,		IP0SR2_11_8)
-#define GPSR2_1		F_(FXR_TXENA_N,		IP0SR2_7_4)
+#define GPSR2_1		F_(FXR_TXENA_N_A,	IP0SR2_7_4)
 #define GPSR2_0		F_(FXR_TXDA,		IP0SR2_3_0)
 
 /* GPSR3 */
@@ -277,13 +277,13 @@
 
 /* SR0 */
 /* IP0SR0 */		/* 0 */			/* 1 */			/* 2 */			/* 3		4	 5	  6	   7	    8	     9	      A	       B	C	 D	  E	   F */
-#define IP0SR0_3_0	F_(0, 0)		FM(ERROROUTC_N_B)	FM(TCLK2_A)		F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
+#define IP0SR0_3_0	F_(0, 0)		FM(ERROROUTC_N_B)	FM(TCLK2_B)		F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
 #define IP0SR0_7_4	F_(0, 0)		FM(MSIOF3_SS1)		F_(0, 0)		F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
 #define IP0SR0_11_8	F_(0, 0)		FM(MSIOF3_SS2)		F_(0, 0)		F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
-#define IP0SR0_15_12	FM(IRQ3)		FM(MSIOF3_SCK)		F_(0, 0)		F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
-#define IP0SR0_19_16	FM(IRQ2)		FM(MSIOF3_TXD)		F_(0, 0)		F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
-#define IP0SR0_23_20	FM(IRQ1)		FM(MSIOF3_RXD)		F_(0, 0)		F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
-#define IP0SR0_27_24	FM(IRQ0)		FM(MSIOF3_SYNC)		F_(0, 0)		F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
+#define IP0SR0_15_12	FM(IRQ3_A)		FM(MSIOF3_SCK)		F_(0, 0)		F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
+#define IP0SR0_19_16	FM(IRQ2_A)		FM(MSIOF3_TXD)		F_(0, 0)		F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
+#define IP0SR0_23_20	FM(IRQ1_A)		FM(MSIOF3_RXD)		F_(0, 0)		F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
+#define IP0SR0_27_24	FM(IRQ0_A)		FM(MSIOF3_SYNC)		F_(0, 0)		F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
 #define IP0SR0_31_28	FM(MSIOF5_SS2)		F_(0, 0)		F_(0, 0)		F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
 
 /* IP1SR0 */		/* 0 */			/* 1 */			/* 2 */			/* 3		4	 5	  6	   7	    8	     9	      A	       B	C	 D	  E	   F */
@@ -292,72 +292,72 @@
 #define IP1SR0_11_8	FM(MSIOF5_TXD)		F_(0, 0)		F_(0, 0)		F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
 #define IP1SR0_15_12	FM(MSIOF5_SCK)		F_(0, 0)		F_(0, 0)		F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
 #define IP1SR0_19_16	FM(MSIOF5_RXD)		F_(0, 0)		F_(0, 0)		F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
-#define IP1SR0_23_20	FM(MSIOF2_SS2)		FM(TCLK1)		FM(IRQ2_A)		F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
-#define IP1SR0_27_24	FM(MSIOF2_SS1)		FM(HTX1)		FM(TX1)			F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
-#define IP1SR0_31_28	FM(MSIOF2_SYNC)		FM(HRX1)		FM(RX1)			F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
+#define IP1SR0_23_20	FM(MSIOF2_SS2)		FM(TCLK1_A)		FM(IRQ2_B)		F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
+#define IP1SR0_27_24	FM(MSIOF2_SS1)		FM(HTX1_A)		FM(TX1_A)		F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
+#define IP1SR0_31_28	FM(MSIOF2_SYNC)		FM(HRX1_A)		FM(RX1_A)		F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
 
 /* IP2SR0 */		/* 0 */			/* 1 */			/* 2 */			/* 3		4	 5	  6	   7	    8	     9	      A	       B	C	 D	  E	   F */
-#define IP2SR0_3_0	FM(MSIOF2_TXD)		FM(HCTS1_N)		FM(CTS1_N)		F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
-#define IP2SR0_7_4	FM(MSIOF2_SCK)		FM(HRTS1_N)		FM(RTS1_N)		F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
-#define IP2SR0_11_8	FM(MSIOF2_RXD)		FM(HSCK1)		FM(SCK1)		F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
+#define IP2SR0_3_0	FM(MSIOF2_TXD)		FM(HCTS1_N_A)		FM(CTS1_N_A)		F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
+#define IP2SR0_7_4	FM(MSIOF2_SCK)		FM(HRTS1_N_A)		FM(RTS1_N_A)		F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
+#define IP2SR0_11_8	FM(MSIOF2_RXD)		FM(HSCK1_A)		FM(SCK1_A)		F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
 
 /* SR1 */
 /* IP0SR1 */		/* 0 */			/* 1 */			/* 2 */			/* 3		4	 5	  6	   7	    8	     9	      A	       B	C	 D	  E	   F */
-#define IP0SR1_3_0	FM(MSIOF1_SS2)		FM(HTX3_A)		FM(TX3)			F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
-#define IP0SR1_7_4	FM(MSIOF1_SS1)		FM(HCTS3_N_A)		FM(RX3)			F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
-#define IP0SR1_11_8	FM(MSIOF1_SYNC)		FM(HRTS3_N_A)		FM(RTS3_N)		F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
-#define IP0SR1_15_12	FM(MSIOF1_SCK)		FM(HSCK3_A)		FM(CTS3_N)		F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
-#define IP0SR1_19_16	FM(MSIOF1_TXD)		FM(HRX3_A)		FM(SCK3)		F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
+#define IP0SR1_3_0	FM(MSIOF1_SS2)		FM(HTX3_B)		FM(TX3_B)		F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
+#define IP0SR1_7_4	FM(MSIOF1_SS1)		FM(HCTS3_N_B)		FM(RX3_B)		F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
+#define IP0SR1_11_8	FM(MSIOF1_SYNC)		FM(HRTS3_N_B)		FM(RTS3_N_B)		F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
+#define IP0SR1_15_12	FM(MSIOF1_SCK)		FM(HSCK3_B)		FM(CTS3_N_B)		F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
+#define IP0SR1_19_16	FM(MSIOF1_TXD)		FM(HRX3_B)		FM(SCK3_B)		F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
 #define IP0SR1_23_20	FM(MSIOF1_RXD)		F_(0, 0)		F_(0, 0)		F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
-#define IP0SR1_27_24	FM(MSIOF0_SS2)		FM(HTX1_X)		FM(TX1_X)		F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
-#define IP0SR1_31_28	FM(MSIOF0_SS1)		FM(HRX1_X)		FM(RX1_X)		F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
+#define IP0SR1_27_24	FM(MSIOF0_SS2)		FM(HTX1_B)		FM(TX1_B)		F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
+#define IP0SR1_31_28	FM(MSIOF0_SS1)		FM(HRX1_B)		FM(RX1_B)		F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
 
 /* IP1SR1 */		/* 0 */			/* 1 */			/* 2 */			/* 3		4	 5	  6	   7	    8	     9	      A	       B	C	 D	  E	   F */
-#define IP1SR1_3_0	FM(MSIOF0_SYNC)		FM(HCTS1_N_X)		FM(CTS1_N_X)		FM(CANFD5_TX_B)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
-#define IP1SR1_7_4	FM(MSIOF0_TXD)		FM(HRTS1_N_X)		FM(RTS1_N_X)		FM(CANFD5_RX_B)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
-#define IP1SR1_11_8	FM(MSIOF0_SCK)		FM(HSCK1_X)		FM(SCK1_X)		F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
+#define IP1SR1_3_0	FM(MSIOF0_SYNC)		FM(HCTS1_N_B)		FM(CTS1_N_B)		FM(CANFD5_TX_B)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
+#define IP1SR1_7_4	FM(MSIOF0_TXD)		FM(HRTS1_N_B)		FM(RTS1_N_B)		FM(CANFD5_RX_B)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
+#define IP1SR1_11_8	FM(MSIOF0_SCK)		FM(HSCK1_B)		FM(SCK1_B)		F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
 #define IP1SR1_15_12	FM(MSIOF0_RXD)		F_(0, 0)		F_(0, 0)		F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
 #define IP1SR1_19_16	FM(HTX0)		FM(TX0)			F_(0, 0)		F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
-#define IP1SR1_23_20	FM(HCTS0_N)		FM(CTS0_N)		FM(PWM8_A)		F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
-#define IP1SR1_27_24	FM(HRTS0_N)		FM(RTS0_N)		FM(PWM9_A)		F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
-#define IP1SR1_31_28	FM(HSCK0)		FM(SCK0)		FM(PWM0_A)		F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
+#define IP1SR1_23_20	FM(HCTS0_N)		FM(CTS0_N)		FM(PWM8)		F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
+#define IP1SR1_27_24	FM(HRTS0_N)		FM(RTS0_N)		FM(PWM9)		F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
+#define IP1SR1_31_28	FM(HSCK0)		FM(SCK0)		FM(PWM0)		F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
 
 /* IP2SR1 */		/* 0 */			/* 1 */			/* 2 */			/* 3		4	 5	  6	   7	    8	     9	      A	       B	C	 D	  E	   F */
 #define IP2SR1_3_0	FM(HRX0)		FM(RX0)			F_(0, 0)		F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
 #define IP2SR1_7_4	FM(SCIF_CLK)		FM(IRQ4_A)		F_(0, 0)		F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
-#define IP2SR1_11_8	FM(SSI_SCK)		FM(TCLK3)		F_(0, 0)		F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
-#define IP2SR1_15_12	FM(SSI_WS)		FM(TCLK4)		F_(0, 0)		F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
-#define IP2SR1_19_16	FM(SSI_SD)		FM(IRQ0_A)		F_(0, 0)		F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
-#define IP2SR1_23_20	FM(AUDIO_CLKOUT)	FM(IRQ1_A)		F_(0, 0)		F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
+#define IP2SR1_11_8	FM(SSI_SCK)		FM(TCLK3_B)		F_(0, 0)		F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
+#define IP2SR1_15_12	FM(SSI_WS)		FM(TCLK4_B)		F_(0, 0)		F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
+#define IP2SR1_19_16	FM(SSI_SD)		FM(IRQ0_B)		F_(0, 0)		F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
+#define IP2SR1_23_20	FM(AUDIO_CLKOUT)	FM(IRQ1_B)		F_(0, 0)		F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
 #define IP2SR1_27_24	FM(AUDIO_CLKIN)		FM(PWM3_A)		F_(0, 0)		F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
-#define IP2SR1_31_28	F_(0, 0)		FM(TCLK2)		FM(MSIOF4_SS1)		FM(IRQ3_B)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
+#define IP2SR1_31_28	F_(0, 0)		FM(TCLK2_A)		FM(MSIOF4_SS1)		FM(IRQ3_B)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
 
 /* IP3SR1 */		/* 0 */			/* 1 */			/* 2 */			/* 3		4	 5	  6	   7	    8	     9	      A	       B	C	 D	  E	   F */
-#define IP3SR1_3_0	FM(HRX3)		FM(SCK3_A)		FM(MSIOF4_SS2)		F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
-#define IP3SR1_7_4	FM(HSCK3)		FM(CTS3_N_A)		FM(MSIOF4_SCK)		FM(TPU0TO0_A)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
-#define IP3SR1_11_8	FM(HRTS3_N)		FM(RTS3_N_A)		FM(MSIOF4_TXD)		FM(TPU0TO1_A)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
-#define IP3SR1_15_12	FM(HCTS3_N)		FM(RX3_A)		FM(MSIOF4_RXD)		F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
-#define IP3SR1_19_16	FM(HTX3)		FM(TX3_A)		FM(MSIOF4_SYNC)		F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
+#define IP3SR1_3_0	FM(HRX3_A)		FM(SCK3_A)		FM(MSIOF4_SS2)		F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
+#define IP3SR1_7_4	FM(HSCK3_A)		FM(CTS3_N_A)		FM(MSIOF4_SCK)		FM(TPU0TO0_B)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
+#define IP3SR1_11_8	FM(HRTS3_N_A)		FM(RTS3_N_A)		FM(MSIOF4_TXD)		FM(TPU0TO1_B)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
+#define IP3SR1_15_12	FM(HCTS3_N_A)		FM(RX3_A)		FM(MSIOF4_RXD)		F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
+#define IP3SR1_19_16	FM(HTX3_A)		FM(TX3_A)		FM(MSIOF4_SYNC)		F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
 
 /* SR2 */
 /* IP0SR2 */		/* 0 */			/* 1 */			/* 2 */			/* 3		4	 5	  6	   7	    8	     9	      A	       B	C	 D	  E	   F */
-#define IP0SR2_3_0	FM(FXR_TXDA)		FM(CANFD1_TX)		FM(TPU0TO2_A)		F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
-#define IP0SR2_7_4	FM(FXR_TXENA_N)		FM(CANFD1_RX)		FM(TPU0TO3_A)		F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
-#define IP0SR2_11_8	FM(RXDA_EXTFXR)		FM(CANFD5_TX)		FM(IRQ5)		F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
-#define IP0SR2_15_12	FM(CLK_EXTFXR)		FM(CANFD5_RX)		FM(IRQ4_B)		F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
+#define IP0SR2_3_0	FM(FXR_TXDA)		FM(CANFD1_TX)		FM(TPU0TO2_B)		F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
+#define IP0SR2_7_4	FM(FXR_TXENA_N_A)	FM(CANFD1_RX)		FM(TPU0TO3_B)		F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
+#define IP0SR2_11_8	FM(RXDA_EXTFXR)		FM(CANFD5_TX_A)		FM(IRQ5)		F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
+#define IP0SR2_15_12	FM(CLK_EXTFXR)		FM(CANFD5_RX_A)		FM(IRQ4_B)		F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
 #define IP0SR2_19_16	FM(RXDB_EXTFXR)		F_(0, 0)		F_(0, 0)		F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
-#define IP0SR2_23_20	FM(FXR_TXENB_N)		F_(0, 0)		F_(0, 0)		F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
+#define IP0SR2_23_20	FM(FXR_TXENB_N_A)	F_(0, 0)		F_(0, 0)		F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
 #define IP0SR2_27_24	FM(FXR_TXDB)		F_(0, 0)		F_(0, 0)		F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
-#define IP0SR2_31_28	FM(TPU0TO1)		FM(CANFD6_TX)		F_(0, 0)		FM(TCLK2_B)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
+#define IP0SR2_31_28	FM(TPU0TO1_A)		FM(CANFD6_TX)		F_(0, 0)		FM(TCLK2_C)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
 
 /* IP1SR2 */		/* 0 */			/* 1 */			/* 2 */			/* 3		4	 5	  6	   7	    8	     9	      A	       B	C	 D	  E	   F */
-#define IP1SR2_3_0	FM(TPU0TO0)		FM(CANFD6_RX)		F_(0, 0)		FM(TCLK1_A)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
-#define IP1SR2_7_4	FM(CAN_CLK)		FM(FXR_TXENA_N_X)	F_(0, 0)		F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
-#define IP1SR2_11_8	FM(CANFD0_TX)		FM(FXR_TXENB_N_X)	F_(0, 0)		F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
+#define IP1SR2_3_0	FM(TPU0TO0_A)		FM(CANFD6_RX)		F_(0, 0)		FM(TCLK1_B)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
+#define IP1SR2_7_4	FM(CAN_CLK)		FM(FXR_TXENA_N_B)	F_(0, 0)		F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
+#define IP1SR2_11_8	FM(CANFD0_TX)		FM(FXR_TXENB_N_B)	F_(0, 0)		F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
 #define IP1SR2_15_12	FM(CANFD0_RX)		FM(STPWT_EXTFXR)	F_(0, 0)		F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
-#define IP1SR2_19_16	FM(CANFD2_TX)		FM(TPU0TO2)		F_(0, 0)		FM(TCLK3_A)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
-#define IP1SR2_23_20	FM(CANFD2_RX)		FM(TPU0TO3)		FM(PWM1_B)		FM(TCLK4_A)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
-#define IP1SR2_27_24	FM(CANFD3_TX)		F_(0, 0)		FM(PWM2_B)		F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
+#define IP1SR2_19_16	FM(CANFD2_TX)		FM(TPU0TO2_A)		F_(0, 0)		FM(TCLK3_C)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
+#define IP1SR2_23_20	FM(CANFD2_RX)		FM(TPU0TO3_A)		FM(PWM1_B)		FM(TCLK4_C)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
+#define IP1SR2_27_24	FM(CANFD3_TX)		F_(0, 0)		FM(PWM2)		F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
 #define IP1SR2_31_28	FM(CANFD3_RX)		F_(0, 0)		FM(PWM3_B)		F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
 
 /* IP2SR2 */		/* 0 */			/* 1 */			/* 2 */			/* 3		4	 5	  6	   7	    8	     9	      A	       B	C	 D	  E	   F */
@@ -383,8 +383,8 @@
 #define IP1SR3_11_8	FM(MMC_SD_CMD)		F_(0, 0)		F_(0, 0)		F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
 #define IP1SR3_15_12	FM(SD_CD)		F_(0, 0)		F_(0, 0)		F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
 #define IP1SR3_19_16	FM(SD_WP)		F_(0, 0)		F_(0, 0)		F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
-#define IP1SR3_23_20	FM(IPC_CLKIN)		FM(IPC_CLKEN_IN)	FM(PWM1_A)		FM(TCLK3_X)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
-#define IP1SR3_27_24	FM(IPC_CLKOUT)		FM(IPC_CLKEN_OUT)	FM(ERROROUTC_N_A)	FM(TCLK4_X)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
+#define IP1SR3_23_20	FM(IPC_CLKIN)		FM(IPC_CLKEN_IN)	FM(PWM1_A)		FM(TCLK3_A)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
+#define IP1SR3_27_24	FM(IPC_CLKOUT)		FM(IPC_CLKEN_OUT)	FM(ERROROUTC_N_A)	FM(TCLK4_A)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
 #define IP1SR3_31_28	FM(QSPI0_SSL)		F_(0, 0)		F_(0, 0)		F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
 
 /* IP2SR3 */		/* 0 */			/* 1 */			/* 2 */			/* 3		4	 5	  6	   7	    8	     9	      A	       B	C	 D	  E	   F */
@@ -720,22 +720,22 @@ static const u16 pinmux_data[] = {
 
 	/* IP0SR0 */
 	PINMUX_IPSR_GPSR(IP0SR0_3_0,	ERROROUTC_N_B),
-	PINMUX_IPSR_GPSR(IP0SR0_3_0,	TCLK2_A),
+	PINMUX_IPSR_GPSR(IP0SR0_3_0,	TCLK2_B),
 
 	PINMUX_IPSR_GPSR(IP0SR0_7_4,	MSIOF3_SS1),
 
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
@@ -752,75 +752,75 @@ static const u16 pinmux_data[] = {
 	PINMUX_IPSR_GPSR(IP1SR0_19_16,	MSIOF5_RXD),
 
 	PINMUX_IPSR_GPSR(IP1SR0_23_20,	MSIOF2_SS2),
-	PINMUX_IPSR_GPSR(IP1SR0_23_20,	TCLK1),
-	PINMUX_IPSR_GPSR(IP1SR0_23_20,	IRQ2_A),
+	PINMUX_IPSR_GPSR(IP1SR0_23_20,	TCLK1_A),
+	PINMUX_IPSR_GPSR(IP1SR0_23_20,	IRQ2_B),
 
 	PINMUX_IPSR_GPSR(IP1SR0_27_24,	MSIOF2_SS1),
-	PINMUX_IPSR_GPSR(IP1SR0_27_24,	HTX1),
-	PINMUX_IPSR_GPSR(IP1SR0_27_24,	TX1),
+	PINMUX_IPSR_GPSR(IP1SR0_27_24,	HTX1_A),
+	PINMUX_IPSR_GPSR(IP1SR0_27_24,	TX1_A),
 
 	PINMUX_IPSR_GPSR(IP1SR0_31_28,	MSIOF2_SYNC),
-	PINMUX_IPSR_GPSR(IP1SR0_31_28,	HRX1),
-	PINMUX_IPSR_GPSR(IP1SR0_31_28,	RX1),
+	PINMUX_IPSR_GPSR(IP1SR0_31_28,	HRX1_A),
+	PINMUX_IPSR_GPSR(IP1SR0_31_28,	RX1_A),
 
 	/* IP2SR0 */
 	PINMUX_IPSR_GPSR(IP2SR0_3_0,	MSIOF2_TXD),
-	PINMUX_IPSR_GPSR(IP2SR0_3_0,	HCTS1_N),
-	PINMUX_IPSR_GPSR(IP2SR0_3_0,	CTS1_N),
+	PINMUX_IPSR_GPSR(IP2SR0_3_0,	HCTS1_N_A),
+	PINMUX_IPSR_GPSR(IP2SR0_3_0,	CTS1_N_A),
 
 	PINMUX_IPSR_GPSR(IP2SR0_7_4,	MSIOF2_SCK),
-	PINMUX_IPSR_GPSR(IP2SR0_7_4,	HRTS1_N),
-	PINMUX_IPSR_GPSR(IP2SR0_7_4,	RTS1_N),
+	PINMUX_IPSR_GPSR(IP2SR0_7_4,	HRTS1_N_A),
+	PINMUX_IPSR_GPSR(IP2SR0_7_4,	RTS1_N_A),
 
 	PINMUX_IPSR_GPSR(IP2SR0_11_8,	MSIOF2_RXD),
-	PINMUX_IPSR_GPSR(IP2SR0_11_8,	HSCK1),
-	PINMUX_IPSR_GPSR(IP2SR0_11_8,	SCK1),
+	PINMUX_IPSR_GPSR(IP2SR0_11_8,	HSCK1_A),
+	PINMUX_IPSR_GPSR(IP2SR0_11_8,	SCK1_A),
 
 	/* IP0SR1 */
 	PINMUX_IPSR_GPSR(IP0SR1_3_0,	MSIOF1_SS2),
-	PINMUX_IPSR_GPSR(IP0SR1_3_0,	HTX3_A),
-	PINMUX_IPSR_GPSR(IP0SR1_3_0,	TX3),
+	PINMUX_IPSR_GPSR(IP0SR1_3_0,	HTX3_B),
+	PINMUX_IPSR_GPSR(IP0SR1_3_0,	TX3_B),
 
 	PINMUX_IPSR_GPSR(IP0SR1_7_4,	MSIOF1_SS1),
-	PINMUX_IPSR_GPSR(IP0SR1_7_4,	HCTS3_N_A),
-	PINMUX_IPSR_GPSR(IP0SR1_7_4,	RX3),
+	PINMUX_IPSR_GPSR(IP0SR1_7_4,	HCTS3_N_B),
+	PINMUX_IPSR_GPSR(IP0SR1_7_4,	RX3_B),
 
 	PINMUX_IPSR_GPSR(IP0SR1_11_8,	MSIOF1_SYNC),
-	PINMUX_IPSR_GPSR(IP0SR1_11_8,	HRTS3_N_A),
-	PINMUX_IPSR_GPSR(IP0SR1_11_8,	RTS3_N),
+	PINMUX_IPSR_GPSR(IP0SR1_11_8,	HRTS3_N_B),
+	PINMUX_IPSR_GPSR(IP0SR1_11_8,	RTS3_N_B),
 
 	PINMUX_IPSR_GPSR(IP0SR1_15_12,	MSIOF1_SCK),
-	PINMUX_IPSR_GPSR(IP0SR1_15_12,	HSCK3_A),
-	PINMUX_IPSR_GPSR(IP0SR1_15_12,	CTS3_N),
+	PINMUX_IPSR_GPSR(IP0SR1_15_12,	HSCK3_B),
+	PINMUX_IPSR_GPSR(IP0SR1_15_12,	CTS3_N_B),
 
 	PINMUX_IPSR_GPSR(IP0SR1_19_16,	MSIOF1_TXD),
-	PINMUX_IPSR_GPSR(IP0SR1_19_16,	HRX3_A),
-	PINMUX_IPSR_GPSR(IP0SR1_19_16,	SCK3),
+	PINMUX_IPSR_GPSR(IP0SR1_19_16,	HRX3_B),
+	PINMUX_IPSR_GPSR(IP0SR1_19_16,	SCK3_B),
 
 	PINMUX_IPSR_GPSR(IP0SR1_23_20,	MSIOF1_RXD),
 
 	PINMUX_IPSR_GPSR(IP0SR1_27_24,	MSIOF0_SS2),
-	PINMUX_IPSR_GPSR(IP0SR1_27_24,	HTX1_X),
-	PINMUX_IPSR_GPSR(IP0SR1_27_24,	TX1_X),
+	PINMUX_IPSR_GPSR(IP0SR1_27_24,	HTX1_B),
+	PINMUX_IPSR_GPSR(IP0SR1_27_24,	TX1_B),
 
 	PINMUX_IPSR_GPSR(IP0SR1_31_28,	MSIOF0_SS1),
-	PINMUX_IPSR_GPSR(IP0SR1_31_28,	HRX1_X),
-	PINMUX_IPSR_GPSR(IP0SR1_31_28,	RX1_X),
+	PINMUX_IPSR_GPSR(IP0SR1_31_28,	HRX1_B),
+	PINMUX_IPSR_GPSR(IP0SR1_31_28,	RX1_B),
 
 	/* IP1SR1 */
 	PINMUX_IPSR_GPSR(IP1SR1_3_0,	MSIOF0_SYNC),
-	PINMUX_IPSR_GPSR(IP1SR1_3_0,	HCTS1_N_X),
-	PINMUX_IPSR_GPSR(IP1SR1_3_0,	CTS1_N_X),
+	PINMUX_IPSR_GPSR(IP1SR1_3_0,	HCTS1_N_B),
+	PINMUX_IPSR_GPSR(IP1SR1_3_0,	CTS1_N_B),
 	PINMUX_IPSR_GPSR(IP1SR1_3_0,	CANFD5_TX_B),
 
 	PINMUX_IPSR_GPSR(IP1SR1_7_4,	MSIOF0_TXD),
-	PINMUX_IPSR_GPSR(IP1SR1_7_4,	HRTS1_N_X),
-	PINMUX_IPSR_GPSR(IP1SR1_7_4,	RTS1_N_X),
+	PINMUX_IPSR_GPSR(IP1SR1_7_4,	HRTS1_N_B),
+	PINMUX_IPSR_GPSR(IP1SR1_7_4,	RTS1_N_B),
 	PINMUX_IPSR_GPSR(IP1SR1_7_4,	CANFD5_RX_B),
 
 	PINMUX_IPSR_GPSR(IP1SR1_11_8,	MSIOF0_SCK),
-	PINMUX_IPSR_GPSR(IP1SR1_11_8,	HSCK1_X),
-	PINMUX_IPSR_GPSR(IP1SR1_11_8,	SCK1_X),
+	PINMUX_IPSR_GPSR(IP1SR1_11_8,	HSCK1_B),
+	PINMUX_IPSR_GPSR(IP1SR1_11_8,	SCK1_B),
 
 	PINMUX_IPSR_GPSR(IP1SR1_15_12,	MSIOF0_RXD),
 
@@ -829,15 +829,15 @@ static const u16 pinmux_data[] = {
 
 	PINMUX_IPSR_GPSR(IP1SR1_23_20,	HCTS0_N),
 	PINMUX_IPSR_GPSR(IP1SR1_23_20,	CTS0_N),
-	PINMUX_IPSR_GPSR(IP1SR1_23_20,	PWM8_A),
+	PINMUX_IPSR_GPSR(IP1SR1_23_20,	PWM8),
 
 	PINMUX_IPSR_GPSR(IP1SR1_27_24,	HRTS0_N),
 	PINMUX_IPSR_GPSR(IP1SR1_27_24,	RTS0_N),
-	PINMUX_IPSR_GPSR(IP1SR1_27_24,	PWM9_A),
+	PINMUX_IPSR_GPSR(IP1SR1_27_24,	PWM9),
 
 	PINMUX_IPSR_GPSR(IP1SR1_31_28,	HSCK0),
 	PINMUX_IPSR_GPSR(IP1SR1_31_28,	SCK0),
-	PINMUX_IPSR_GPSR(IP1SR1_31_28,	PWM0_A),
+	PINMUX_IPSR_GPSR(IP1SR1_31_28,	PWM0),
 
 	/* IP2SR1 */
 	PINMUX_IPSR_GPSR(IP2SR1_3_0,	HRX0),
@@ -847,99 +847,99 @@ static const u16 pinmux_data[] = {
 	PINMUX_IPSR_GPSR(IP2SR1_7_4,	IRQ4_A),
 
 	PINMUX_IPSR_GPSR(IP2SR1_11_8,	SSI_SCK),
-	PINMUX_IPSR_GPSR(IP2SR1_11_8,	TCLK3),
+	PINMUX_IPSR_GPSR(IP2SR1_11_8,	TCLK3_B),
 
 	PINMUX_IPSR_GPSR(IP2SR1_15_12,	SSI_WS),
-	PINMUX_IPSR_GPSR(IP2SR1_15_12,	TCLK4),
+	PINMUX_IPSR_GPSR(IP2SR1_15_12,	TCLK4_B),
 
 	PINMUX_IPSR_GPSR(IP2SR1_19_16,	SSI_SD),
-	PINMUX_IPSR_GPSR(IP2SR1_19_16,	IRQ0_A),
+	PINMUX_IPSR_GPSR(IP2SR1_19_16,	IRQ0_B),
 
 	PINMUX_IPSR_GPSR(IP2SR1_23_20,	AUDIO_CLKOUT),
-	PINMUX_IPSR_GPSR(IP2SR1_23_20,	IRQ1_A),
+	PINMUX_IPSR_GPSR(IP2SR1_23_20,	IRQ1_B),
 
 	PINMUX_IPSR_GPSR(IP2SR1_27_24,	AUDIO_CLKIN),
 	PINMUX_IPSR_GPSR(IP2SR1_27_24,	PWM3_A),
 
-	PINMUX_IPSR_GPSR(IP2SR1_31_28,	TCLK2),
+	PINMUX_IPSR_GPSR(IP2SR1_31_28,	TCLK2_A),
 	PINMUX_IPSR_GPSR(IP2SR1_31_28,	MSIOF4_SS1),
 	PINMUX_IPSR_GPSR(IP2SR1_31_28,	IRQ3_B),
 
 	/* IP3SR1 */
-	PINMUX_IPSR_GPSR(IP3SR1_3_0,	HRX3),
+	PINMUX_IPSR_GPSR(IP3SR1_3_0,	HRX3_A),
 	PINMUX_IPSR_GPSR(IP3SR1_3_0,	SCK3_A),
 	PINMUX_IPSR_GPSR(IP3SR1_3_0,	MSIOF4_SS2),
 
-	PINMUX_IPSR_GPSR(IP3SR1_7_4,	HSCK3),
+	PINMUX_IPSR_GPSR(IP3SR1_7_4,	HSCK3_A),
 	PINMUX_IPSR_GPSR(IP3SR1_7_4,	CTS3_N_A),
 	PINMUX_IPSR_GPSR(IP3SR1_7_4,	MSIOF4_SCK),
-	PINMUX_IPSR_GPSR(IP3SR1_7_4,	TPU0TO0_A),
+	PINMUX_IPSR_GPSR(IP3SR1_7_4,	TPU0TO0_B),
 
-	PINMUX_IPSR_GPSR(IP3SR1_11_8,	HRTS3_N),
+	PINMUX_IPSR_GPSR(IP3SR1_11_8,	HRTS3_N_A),
 	PINMUX_IPSR_GPSR(IP3SR1_11_8,	RTS3_N_A),
 	PINMUX_IPSR_GPSR(IP3SR1_11_8,	MSIOF4_TXD),
-	PINMUX_IPSR_GPSR(IP3SR1_11_8,	TPU0TO1_A),
+	PINMUX_IPSR_GPSR(IP3SR1_11_8,	TPU0TO1_B),
 
-	PINMUX_IPSR_GPSR(IP3SR1_15_12,	HCTS3_N),
+	PINMUX_IPSR_GPSR(IP3SR1_15_12,	HCTS3_N_A),
 	PINMUX_IPSR_GPSR(IP3SR1_15_12,	RX3_A),
 	PINMUX_IPSR_GPSR(IP3SR1_15_12,	MSIOF4_RXD),
 
-	PINMUX_IPSR_GPSR(IP3SR1_19_16,	HTX3),
+	PINMUX_IPSR_GPSR(IP3SR1_19_16,	HTX3_A),
 	PINMUX_IPSR_GPSR(IP3SR1_19_16,	TX3_A),
 	PINMUX_IPSR_GPSR(IP3SR1_19_16,	MSIOF4_SYNC),
 
 	/* IP0SR2 */
 	PINMUX_IPSR_GPSR(IP0SR2_3_0,	FXR_TXDA),
 	PINMUX_IPSR_GPSR(IP0SR2_3_0,	CANFD1_TX),
-	PINMUX_IPSR_GPSR(IP0SR2_3_0,	TPU0TO2_A),
+	PINMUX_IPSR_GPSR(IP0SR2_3_0,	TPU0TO2_B),
 
-	PINMUX_IPSR_GPSR(IP0SR2_7_4,	FXR_TXENA_N),
+	PINMUX_IPSR_GPSR(IP0SR2_7_4,	FXR_TXENA_N_A),
 	PINMUX_IPSR_GPSR(IP0SR2_7_4,	CANFD1_RX),
-	PINMUX_IPSR_GPSR(IP0SR2_7_4,	TPU0TO3_A),
+	PINMUX_IPSR_GPSR(IP0SR2_7_4,	TPU0TO3_B),
 
 	PINMUX_IPSR_GPSR(IP0SR2_11_8,	RXDA_EXTFXR),
-	PINMUX_IPSR_GPSR(IP0SR2_11_8,	CANFD5_TX),
+	PINMUX_IPSR_GPSR(IP0SR2_11_8,	CANFD5_TX_A),
 	PINMUX_IPSR_GPSR(IP0SR2_11_8,	IRQ5),
 
 	PINMUX_IPSR_GPSR(IP0SR2_15_12,	CLK_EXTFXR),
-	PINMUX_IPSR_GPSR(IP0SR2_15_12,	CANFD5_RX),
+	PINMUX_IPSR_GPSR(IP0SR2_15_12,	CANFD5_RX_A),
 	PINMUX_IPSR_GPSR(IP0SR2_15_12,	IRQ4_B),
 
 	PINMUX_IPSR_GPSR(IP0SR2_19_16,	RXDB_EXTFXR),
 
-	PINMUX_IPSR_GPSR(IP0SR2_23_20,	FXR_TXENB_N),
+	PINMUX_IPSR_GPSR(IP0SR2_23_20,	FXR_TXENB_N_A),
 
 	PINMUX_IPSR_GPSR(IP0SR2_27_24,	FXR_TXDB),
 
-	PINMUX_IPSR_GPSR(IP0SR2_31_28,	TPU0TO1),
+	PINMUX_IPSR_GPSR(IP0SR2_31_28,	TPU0TO1_A),
 	PINMUX_IPSR_GPSR(IP0SR2_31_28,	CANFD6_TX),
-	PINMUX_IPSR_GPSR(IP0SR2_31_28,	TCLK2_B),
+	PINMUX_IPSR_GPSR(IP0SR2_31_28,	TCLK2_C),
 
 	/* IP1SR2 */
-	PINMUX_IPSR_GPSR(IP1SR2_3_0,	TPU0TO0),
+	PINMUX_IPSR_GPSR(IP1SR2_3_0,	TPU0TO0_A),
 	PINMUX_IPSR_GPSR(IP1SR2_3_0,	CANFD6_RX),
-	PINMUX_IPSR_GPSR(IP1SR2_3_0,	TCLK1_A),
+	PINMUX_IPSR_GPSR(IP1SR2_3_0,	TCLK1_B),
 
 	PINMUX_IPSR_GPSR(IP1SR2_7_4,	CAN_CLK),
-	PINMUX_IPSR_GPSR(IP1SR2_7_4,	FXR_TXENA_N_X),
+	PINMUX_IPSR_GPSR(IP1SR2_7_4,	FXR_TXENA_N_B),
 
 	PINMUX_IPSR_GPSR(IP1SR2_11_8,	CANFD0_TX),
-	PINMUX_IPSR_GPSR(IP1SR2_11_8,	FXR_TXENB_N_X),
+	PINMUX_IPSR_GPSR(IP1SR2_11_8,	FXR_TXENB_N_B),
 
 	PINMUX_IPSR_GPSR(IP1SR2_15_12,	CANFD0_RX),
 	PINMUX_IPSR_GPSR(IP1SR2_15_12,	STPWT_EXTFXR),
 
 	PINMUX_IPSR_GPSR(IP1SR2_19_16,	CANFD2_TX),
-	PINMUX_IPSR_GPSR(IP1SR2_19_16,	TPU0TO2),
-	PINMUX_IPSR_GPSR(IP1SR2_19_16,	TCLK3_A),
+	PINMUX_IPSR_GPSR(IP1SR2_19_16,	TPU0TO2_A),
+	PINMUX_IPSR_GPSR(IP1SR2_19_16,	TCLK3_C),
 
 	PINMUX_IPSR_GPSR(IP1SR2_23_20,	CANFD2_RX),
-	PINMUX_IPSR_GPSR(IP1SR2_23_20,	TPU0TO3),
+	PINMUX_IPSR_GPSR(IP1SR2_23_20,	TPU0TO3_A),
 	PINMUX_IPSR_GPSR(IP1SR2_23_20,	PWM1_B),
-	PINMUX_IPSR_GPSR(IP1SR2_23_20,	TCLK4_A),
+	PINMUX_IPSR_GPSR(IP1SR2_23_20,	TCLK4_C),
 
 	PINMUX_IPSR_GPSR(IP1SR2_27_24,	CANFD3_TX),
-	PINMUX_IPSR_GPSR(IP1SR2_27_24,	PWM2_B),
+	PINMUX_IPSR_GPSR(IP1SR2_27_24,	PWM2),
 
 	PINMUX_IPSR_GPSR(IP1SR2_31_28,	CANFD3_RX),
 	PINMUX_IPSR_GPSR(IP1SR2_31_28,	PWM3_B),
@@ -981,12 +981,12 @@ static const u16 pinmux_data[] = {
 	PINMUX_IPSR_GPSR(IP1SR3_23_20,	IPC_CLKIN),
 	PINMUX_IPSR_GPSR(IP1SR3_23_20,	IPC_CLKEN_IN),
 	PINMUX_IPSR_GPSR(IP1SR3_23_20,	PWM1_A),
-	PINMUX_IPSR_GPSR(IP1SR3_23_20,	TCLK3_X),
+	PINMUX_IPSR_GPSR(IP1SR3_23_20,	TCLK3_A),
 
 	PINMUX_IPSR_GPSR(IP1SR3_27_24,	IPC_CLKOUT),
 	PINMUX_IPSR_GPSR(IP1SR3_27_24,	IPC_CLKEN_OUT),
 	PINMUX_IPSR_GPSR(IP1SR3_27_24,	ERROROUTC_N_A),
-	PINMUX_IPSR_GPSR(IP1SR3_27_24,	TCLK4_X),
+	PINMUX_IPSR_GPSR(IP1SR3_27_24,	TCLK4_A),
 
 	PINMUX_IPSR_GPSR(IP1SR3_31_28,	QSPI0_SSL),
 
@@ -1533,15 +1533,14 @@ static const unsigned int canfd4_data_mux[] = {
 };
 
 /* - CANFD5 ----------------------------------------------------------------- */
-static const unsigned int canfd5_data_pins[] = {
-	/* CANFD5_TX, CANFD5_RX */
+static const unsigned int canfd5_data_a_pins[] = {
+	/* CANFD5_TX_A, CANFD5_RX_A */
 	RCAR_GP_PIN(2, 2), RCAR_GP_PIN(2, 3),
 };
-static const unsigned int canfd5_data_mux[] = {
-	CANFD5_TX_MARK, CANFD5_RX_MARK,
+static const unsigned int canfd5_data_a_mux[] = {
+	CANFD5_TX_A_MARK, CANFD5_RX_A_MARK,
 };
 
-/* - CANFD5_B ----------------------------------------------------------------- */
 static const unsigned int canfd5_data_b_pins[] = {
 	/* CANFD5_TX_B, CANFD5_RX_B */
 	RCAR_GP_PIN(1, 8), RCAR_GP_PIN(1, 9),
@@ -1601,49 +1600,48 @@ static const unsigned int hscif0_ctrl_mux[] = {
 };
 
 /* - HSCIF1 ----------------------------------------------------------------- */
-static const unsigned int hscif1_data_pins[] = {
-	/* HRX1, HTX1 */
+static const unsigned int hscif1_data_a_pins[] = {
+	/* HRX1_A, HTX1_A */
 	RCAR_GP_PIN(0, 15), RCAR_GP_PIN(0, 14),
 };
-static const unsigned int hscif1_data_mux[] = {
-	HRX1_MARK, HTX1_MARK,
+static const unsigned int hscif1_data_a_mux[] = {
+	HRX1_A_MARK, HTX1_A_MARK,
 };
-static const unsigned int hscif1_clk_pins[] = {
-	/* HSCK1 */
+static const unsigned int hscif1_clk_a_pins[] = {
+	/* HSCK1_A */
 	RCAR_GP_PIN(0, 18),
 };
-static const unsigned int hscif1_clk_mux[] = {
-	HSCK1_MARK,
+static const unsigned int hscif1_clk_a_mux[] = {
+	HSCK1_A_MARK,
 };
-static const unsigned int hscif1_ctrl_pins[] = {
-	/* HRTS1_N, HCTS1_N */
+static const unsigned int hscif1_ctrl_a_pins[] = {
+	/* HRTS1_N_A, HCTS1_N_A */
 	RCAR_GP_PIN(0, 17), RCAR_GP_PIN(0, 16),
 };
-static const unsigned int hscif1_ctrl_mux[] = {
-	HRTS1_N_MARK, HCTS1_N_MARK,
+static const unsigned int hscif1_ctrl_a_mux[] = {
+	HRTS1_N_A_MARK, HCTS1_N_A_MARK,
 };
 
-/* - HSCIF1_X---------------------------------------------------------------- */
-static const unsigned int hscif1_data_x_pins[] = {
-	/* HRX1_X, HTX1_X */
+static const unsigned int hscif1_data_b_pins[] = {
+	/* HRX1_B, HTX1_B */
 	RCAR_GP_PIN(1, 7), RCAR_GP_PIN(1, 6),
 };
-static const unsigned int hscif1_data_x_mux[] = {
-	HRX1_X_MARK, HTX1_X_MARK,
+static const unsigned int hscif1_data_b_mux[] = {
+	HRX1_B_MARK, HTX1_B_MARK,
 };
-static const unsigned int hscif1_clk_x_pins[] = {
-	/* HSCK1_X */
+static const unsigned int hscif1_clk_b_pins[] = {
+	/* HSCK1_B */
 	RCAR_GP_PIN(1, 10),
 };
-static const unsigned int hscif1_clk_x_mux[] = {
-	HSCK1_X_MARK,
+static const unsigned int hscif1_clk_b_mux[] = {
+	HSCK1_B_MARK,
 };
-static const unsigned int hscif1_ctrl_x_pins[] = {
-	/* HRTS1_N_X, HCTS1_N_X */
+static const unsigned int hscif1_ctrl_b_pins[] = {
+	/* HRTS1_N_B, HCTS1_N_B */
 	RCAR_GP_PIN(1, 9), RCAR_GP_PIN(1, 8),
 };
-static const unsigned int hscif1_ctrl_x_mux[] = {
-	HRTS1_N_X_MARK, HCTS1_N_X_MARK,
+static const unsigned int hscif1_ctrl_b_mux[] = {
+	HRTS1_N_B_MARK, HCTS1_N_B_MARK,
 };
 
 /* - HSCIF2 ----------------------------------------------------------------- */
@@ -1670,49 +1668,48 @@ static const unsigned int hscif2_ctrl_mux[] = {
 };
 
 /* - HSCIF3 ----------------------------------------------------------------- */
-static const unsigned int hscif3_data_pins[] = {
-	/* HRX3, HTX3 */
+static const unsigned int hscif3_data_a_pins[] = {
+	/* HRX3_A, HTX3_A */
 	RCAR_GP_PIN(1, 24), RCAR_GP_PIN(1, 28),
 };
-static const unsigned int hscif3_data_mux[] = {
-	HRX3_MARK, HTX3_MARK,
+static const unsigned int hscif3_data_a_mux[] = {
+	HRX3_A_MARK, HTX3_A_MARK,
 };
-static const unsigned int hscif3_clk_pins[] = {
-	/* HSCK3 */
+static const unsigned int hscif3_clk_a_pins[] = {
+	/* HSCK3_A */
 	RCAR_GP_PIN(1, 25),
 };
-static const unsigned int hscif3_clk_mux[] = {
-	HSCK3_MARK,
+static const unsigned int hscif3_clk_a_mux[] = {
+	HSCK3_A_MARK,
 };
-static const unsigned int hscif3_ctrl_pins[] = {
-	/* HRTS3_N, HCTS3_N */
+static const unsigned int hscif3_ctrl_a_pins[] = {
+	/* HRTS3_N_A, HCTS3_N_A */
 	RCAR_GP_PIN(1, 26), RCAR_GP_PIN(1, 27),
 };
-static const unsigned int hscif3_ctrl_mux[] = {
-	HRTS3_N_MARK, HCTS3_N_MARK,
+static const unsigned int hscif3_ctrl_a_mux[] = {
+	HRTS3_N_A_MARK, HCTS3_N_A_MARK,
 };
 
-/* - HSCIF3_A ----------------------------------------------------------------- */
-static const unsigned int hscif3_data_a_pins[] = {
-	/* HRX3_A, HTX3_A */
+static const unsigned int hscif3_data_b_pins[] = {
+	/* HRX3_B, HTX3_B */
 	RCAR_GP_PIN(1, 4), RCAR_GP_PIN(1, 0),
 };
-static const unsigned int hscif3_data_a_mux[] = {
-	HRX3_A_MARK, HTX3_A_MARK,
+static const unsigned int hscif3_data_b_mux[] = {
+	HRX3_B_MARK, HTX3_B_MARK,
 };
-static const unsigned int hscif3_clk_a_pins[] = {
-	/* HSCK3_A */
+static const unsigned int hscif3_clk_b_pins[] = {
+	/* HSCK3_B */
 	RCAR_GP_PIN(1, 3),
 };
-static const unsigned int hscif3_clk_a_mux[] = {
-	HSCK3_A_MARK,
+static const unsigned int hscif3_clk_b_mux[] = {
+	HSCK3_B_MARK,
 };
-static const unsigned int hscif3_ctrl_a_pins[] = {
-	/* HRTS3_N_A, HCTS3_N_A */
+static const unsigned int hscif3_ctrl_b_pins[] = {
+	/* HRTS3_N_B, HCTS3_N_B */
 	RCAR_GP_PIN(1, 2), RCAR_GP_PIN(1, 1),
 };
-static const unsigned int hscif3_ctrl_a_mux[] = {
-	HRTS3_N_A_MARK, HCTS3_N_A_MARK,
+static const unsigned int hscif3_ctrl_b_mux[] = {
+	HRTS3_N_B_MARK, HCTS3_N_B_MARK,
 };
 
 /* - I2C0 ------------------------------------------------------------------- */
@@ -1769,6 +1766,90 @@ static const unsigned int i2c5_mux[] = {
 	SDA5_MARK, SCL5_MARK,
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
@@ -2095,16 +2176,16 @@ static const unsigned int pcie1_clkreq_n_mux[] = {
 	PCIE1_CLKREQ_N_MARK,
 };
 
-/* - PWM0_A ------------------------------------------------------------------- */
-static const unsigned int pwm0_a_pins[] = {
-	/* PWM0_A */
+/* - PWM0 ------------------------------------------------------------------- */
+static const unsigned int pwm0_pins[] = {
+	/* PWM0 */
 	RCAR_GP_PIN(1, 15),
 };
-static const unsigned int pwm0_a_mux[] = {
-	PWM0_A_MARK,
+static const unsigned int pwm0_mux[] = {
+	PWM0_MARK,
 };
 
-/* - PWM1_A ------------------------------------------------------------------- */
+/* - PWM1 ------------------------------------------------------------------- */
 static const unsigned int pwm1_a_pins[] = {
 	/* PWM1_A */
 	RCAR_GP_PIN(3, 13),
@@ -2113,7 +2194,6 @@ static const unsigned int pwm1_a_mux[] = {
 	PWM1_A_MARK,
 };
 
-/* - PWM1_B ------------------------------------------------------------------- */
 static const unsigned int pwm1_b_pins[] = {
 	/* PWM1_B */
 	RCAR_GP_PIN(2, 13),
@@ -2122,16 +2202,16 @@ static const unsigned int pwm1_b_mux[] = {
 	PWM1_B_MARK,
 };
 
-/* - PWM2_B ------------------------------------------------------------------- */
-static const unsigned int pwm2_b_pins[] = {
-	/* PWM2_B */
+/* - PWM2 ------------------------------------------------------------------- */
+static const unsigned int pwm2_pins[] = {
+	/* PWM2 */
 	RCAR_GP_PIN(2, 14),
 };
-static const unsigned int pwm2_b_mux[] = {
-	PWM2_B_MARK,
+static const unsigned int pwm2_mux[] = {
+	PWM2_MARK,
 };
 
-/* - PWM3_A ------------------------------------------------------------------- */
+/* - PWM3 ------------------------------------------------------------------- */
 static const unsigned int pwm3_a_pins[] = {
 	/* PWM3_A */
 	RCAR_GP_PIN(1, 22),
@@ -2140,7 +2220,6 @@ static const unsigned int pwm3_a_mux[] = {
 	PWM3_A_MARK,
 };
 
-/* - PWM3_B ------------------------------------------------------------------- */
 static const unsigned int pwm3_b_pins[] = {
 	/* PWM3_B */
 	RCAR_GP_PIN(2, 15),
@@ -2185,22 +2264,22 @@ static const unsigned int pwm7_mux[] = {
 	PWM7_MARK,
 };
 
-/* - PWM8_A ------------------------------------------------------------------- */
-static const unsigned int pwm8_a_pins[] = {
-	/* PWM8_A */
+/* - PWM8 ------------------------------------------------------------------- */
+static const unsigned int pwm8_pins[] = {
+	/* PWM8 */
 	RCAR_GP_PIN(1, 13),
 };
-static const unsigned int pwm8_a_mux[] = {
-	PWM8_A_MARK,
+static const unsigned int pwm8_mux[] = {
+	PWM8_MARK,
 };
 
-/* - PWM9_A ------------------------------------------------------------------- */
-static const unsigned int pwm9_a_pins[] = {
-	/* PWM9_A */
+/* - PWM9 ------------------------------------------------------------------- */
+static const unsigned int pwm9_pins[] = {
+	/* PWM9 */
 	RCAR_GP_PIN(1, 14),
 };
-static const unsigned int pwm9_a_mux[] = {
-	PWM9_A_MARK,
+static const unsigned int pwm9_mux[] = {
+	PWM9_MARK,
 };
 
 /* - QSPI0 ------------------------------------------------------------------ */
@@ -2263,75 +2342,51 @@ static const unsigned int scif0_ctrl_mux[] = {
 };
 
 /* - SCIF1 ------------------------------------------------------------------ */
-static const unsigned int scif1_data_pins[] = {
-	/* RX1, TX1 */
+static const unsigned int scif1_data_a_pins[] = {
+	/* RX1_A, TX1_A */
 	RCAR_GP_PIN(0, 15), RCAR_GP_PIN(0, 14),
 };
-static const unsigned int scif1_data_mux[] = {
-	RX1_MARK, TX1_MARK,
+static const unsigned int scif1_data_a_mux[] = {
+	RX1_A_MARK, TX1_A_MARK,
 };
-static const unsigned int scif1_clk_pins[] = {
-	/* SCK1 */
+static const unsigned int scif1_clk_a_pins[] = {
+	/* SCK1_A */
 	RCAR_GP_PIN(0, 18),
 };
-static const unsigned int scif1_clk_mux[] = {
-	SCK1_MARK,
+static const unsigned int scif1_clk_a_mux[] = {
+	SCK1_A_MARK,
 };
-static const unsigned int scif1_ctrl_pins[] = {
-	/* RTS1_N, CTS1_N */
+static const unsigned int scif1_ctrl_a_pins[] = {
+	/* RTS1_N_A, CTS1_N_A */
 	RCAR_GP_PIN(0, 17), RCAR_GP_PIN(0, 16),
 };
-static const unsigned int scif1_ctrl_mux[] = {
-	RTS1_N_MARK, CTS1_N_MARK,
+static const unsigned int scif1_ctrl_a_mux[] = {
+	RTS1_N_A_MARK, CTS1_N_A_MARK,
 };
 
-/* - SCIF1_X ------------------------------------------------------------------ */
-static const unsigned int scif1_data_x_pins[] = {
-	/* RX1_X, TX1_X */
+static const unsigned int scif1_data_b_pins[] = {
+	/* RX1_B, TX1_B */
 	RCAR_GP_PIN(1, 7), RCAR_GP_PIN(1, 6),
 };
-static const unsigned int scif1_data_x_mux[] = {
-	RX1_X_MARK, TX1_X_MARK,
+static const unsigned int scif1_data_b_mux[] = {
+	RX1_B_MARK, TX1_B_MARK,
 };
-static const unsigned int scif1_clk_x_pins[] = {
-	/* SCK1_X */
+static const unsigned int scif1_clk_b_pins[] = {
+	/* SCK1_B */
 	RCAR_GP_PIN(1, 10),
 };
-static const unsigned int scif1_clk_x_mux[] = {
-	SCK1_X_MARK,
+static const unsigned int scif1_clk_b_mux[] = {
+	SCK1_B_MARK,
 };
-static const unsigned int scif1_ctrl_x_pins[] = {
-	/* RTS1_N_X, CTS1_N_X */
+static const unsigned int scif1_ctrl_b_pins[] = {
+	/* RTS1_N_B, CTS1_N_B */
 	RCAR_GP_PIN(1, 9), RCAR_GP_PIN(1, 8),
 };
-static const unsigned int scif1_ctrl_x_mux[] = {
-	RTS1_N_X_MARK, CTS1_N_X_MARK,
+static const unsigned int scif1_ctrl_b_mux[] = {
+	RTS1_N_B_MARK, CTS1_N_B_MARK,
 };
 
 /* - SCIF3 ------------------------------------------------------------------ */
-static const unsigned int scif3_data_pins[] = {
-	/* RX3, TX3 */
-	RCAR_GP_PIN(1, 1), RCAR_GP_PIN(1, 0),
-};
-static const unsigned int scif3_data_mux[] = {
-	RX3_MARK, TX3_MARK,
-};
-static const unsigned int scif3_clk_pins[] = {
-	/* SCK3 */
-	RCAR_GP_PIN(1, 4),
-};
-static const unsigned int scif3_clk_mux[] = {
-	SCK3_MARK,
-};
-static const unsigned int scif3_ctrl_pins[] = {
-	/* RTS3_N, CTS3_N */
-	RCAR_GP_PIN(1, 2), RCAR_GP_PIN(1, 3),
-};
-static const unsigned int scif3_ctrl_mux[] = {
-	RTS3_N_MARK, CTS3_N_MARK,
-};
-
-/* - SCIF3_A ------------------------------------------------------------------ */
 static const unsigned int scif3_data_a_pins[] = {
 	/* RX3_A, TX3_A */
 	RCAR_GP_PIN(1, 27), RCAR_GP_PIN(1, 28),
@@ -2354,6 +2409,28 @@ static const unsigned int scif3_ctrl_a_mux[] = {
 	RTS3_N_A_MARK, CTS3_N_A_MARK,
 };
 
+static const unsigned int scif3_data_b_pins[] = {
+	/* RX3_B, TX3_B */
+	RCAR_GP_PIN(1, 1), RCAR_GP_PIN(1, 0),
+};
+static const unsigned int scif3_data_b_mux[] = {
+	RX3_B_MARK, TX3_B_MARK,
+};
+static const unsigned int scif3_clk_b_pins[] = {
+	/* SCK3_B */
+	RCAR_GP_PIN(1, 4),
+};
+static const unsigned int scif3_clk_b_mux[] = {
+	SCK3_B_MARK,
+};
+static const unsigned int scif3_ctrl_b_pins[] = {
+	/* RTS3_N_B, CTS3_N_B */
+	RCAR_GP_PIN(1, 2), RCAR_GP_PIN(1, 3),
+};
+static const unsigned int scif3_ctrl_b_mux[] = {
+	RTS3_N_B_MARK, CTS3_N_B_MARK,
+};
+
 /* - SCIF4 ------------------------------------------------------------------ */
 static const unsigned int scif4_data_pins[] = {
 	/* RX4, TX4 */
@@ -2410,64 +2487,63 @@ static const unsigned int ssi_ctrl_mux[] = {
 	SSI_SCK_MARK, SSI_WS_MARK,
 };
 
-/* - TPU ------------------------------------------------------------------- */
-static const unsigned int tpu_to0_pins[] = {
-	/* TPU0TO0 */
+/* - TPU -------------------------------------------------------------------- */
+static const unsigned int tpu_to0_a_pins[] = {
+	/* TPU0TO0_A */
 	RCAR_GP_PIN(2, 8),
 };
-static const unsigned int tpu_to0_mux[] = {
-	TPU0TO0_MARK,
+static const unsigned int tpu_to0_a_mux[] = {
+	TPU0TO0_A_MARK,
 };
-static const unsigned int tpu_to1_pins[] = {
-	/* TPU0TO1 */
+static const unsigned int tpu_to1_a_pins[] = {
+	/* TPU0TO1_A */
 	RCAR_GP_PIN(2, 7),
 };
-static const unsigned int tpu_to1_mux[] = {
-	TPU0TO1_MARK,
+static const unsigned int tpu_to1_a_mux[] = {
+	TPU0TO1_A_MARK,
 };
-static const unsigned int tpu_to2_pins[] = {
-	/* TPU0TO2 */
+static const unsigned int tpu_to2_a_pins[] = {
+	/* TPU0TO2_A */
 	RCAR_GP_PIN(2, 12),
 };
-static const unsigned int tpu_to2_mux[] = {
-	TPU0TO2_MARK,
+static const unsigned int tpu_to2_a_mux[] = {
+	TPU0TO2_A_MARK,
 };
-static const unsigned int tpu_to3_pins[] = {
-	/* TPU0TO3 */
+static const unsigned int tpu_to3_a_pins[] = {
+	/* TPU0TO3_A */
 	RCAR_GP_PIN(2, 13),
 };
-static const unsigned int tpu_to3_mux[] = {
-	TPU0TO3_MARK,
+static const unsigned int tpu_to3_a_mux[] = {
+	TPU0TO3_A_MARK,
 };
 
-/* - TPU_A ------------------------------------------------------------------- */
-static const unsigned int tpu_to0_a_pins[] = {
-	/* TPU0TO0_A */
+static const unsigned int tpu_to0_b_pins[] = {
+	/* TPU0TO0_B */
 	RCAR_GP_PIN(1, 25),
 };
-static const unsigned int tpu_to0_a_mux[] = {
-	TPU0TO0_A_MARK,
+static const unsigned int tpu_to0_b_mux[] = {
+	TPU0TO0_B_MARK,
 };
-static const unsigned int tpu_to1_a_pins[] = {
-	/* TPU0TO1_A */
+static const unsigned int tpu_to1_b_pins[] = {
+	/* TPU0TO1_B */
 	RCAR_GP_PIN(1, 26),
 };
-static const unsigned int tpu_to1_a_mux[] = {
-	TPU0TO1_A_MARK,
+static const unsigned int tpu_to1_b_mux[] = {
+	TPU0TO1_B_MARK,
 };
-static const unsigned int tpu_to2_a_pins[] = {
-	/* TPU0TO2_A */
+static const unsigned int tpu_to2_b_pins[] = {
+	/* TPU0TO2_B */
 	RCAR_GP_PIN(2, 0),
 };
-static const unsigned int tpu_to2_a_mux[] = {
-	TPU0TO2_A_MARK,
+static const unsigned int tpu_to2_b_mux[] = {
+	TPU0TO2_B_MARK,
 };
-static const unsigned int tpu_to3_a_pins[] = {
-	/* TPU0TO3_A */
+static const unsigned int tpu_to3_b_pins[] = {
+	/* TPU0TO3_B */
 	RCAR_GP_PIN(2, 1),
 };
-static const unsigned int tpu_to3_a_mux[] = {
-	TPU0TO3_A_MARK,
+static const unsigned int tpu_to3_b_mux[] = {
+	TPU0TO3_B_MARK,
 };
 
 /* - TSN0 ------------------------------------------------ */
@@ -2580,8 +2656,8 @@ static const struct sh_pfc_pin_group pinmux_groups[] = {
 	SH_PFC_PIN_GROUP(canfd2_data),
 	SH_PFC_PIN_GROUP(canfd3_data),
 	SH_PFC_PIN_GROUP(canfd4_data),
-	SH_PFC_PIN_GROUP(canfd5_data),		/* suffix might be updated */
-	SH_PFC_PIN_GROUP(canfd5_data_b),	/* suffix might be updated */
+	SH_PFC_PIN_GROUP(canfd5_data_a),
+	SH_PFC_PIN_GROUP(canfd5_data_b),
 	SH_PFC_PIN_GROUP(canfd6_data),
 	SH_PFC_PIN_GROUP(canfd7_data),
 	SH_PFC_PIN_GROUP(can_clk),
@@ -2589,21 +2665,21 @@ static const struct sh_pfc_pin_group pinmux_groups[] = {
 	SH_PFC_PIN_GROUP(hscif0_data),
 	SH_PFC_PIN_GROUP(hscif0_clk),
 	SH_PFC_PIN_GROUP(hscif0_ctrl),
-	SH_PFC_PIN_GROUP(hscif1_data),		/* suffix might be updated */
-	SH_PFC_PIN_GROUP(hscif1_clk),		/* suffix might be updated */
-	SH_PFC_PIN_GROUP(hscif1_ctrl),		/* suffix might be updated */
-	SH_PFC_PIN_GROUP(hscif1_data_x),	/* suffix might be updated */
-	SH_PFC_PIN_GROUP(hscif1_clk_x),		/* suffix might be updated */
-	SH_PFC_PIN_GROUP(hscif1_ctrl_x),	/* suffix might be updated */
+	SH_PFC_PIN_GROUP(hscif1_data_a),
+	SH_PFC_PIN_GROUP(hscif1_clk_a),
+	SH_PFC_PIN_GROUP(hscif1_ctrl_a),
+	SH_PFC_PIN_GROUP(hscif1_data_b),
+	SH_PFC_PIN_GROUP(hscif1_clk_b),
+	SH_PFC_PIN_GROUP(hscif1_ctrl_b),
 	SH_PFC_PIN_GROUP(hscif2_data),
 	SH_PFC_PIN_GROUP(hscif2_clk),
 	SH_PFC_PIN_GROUP(hscif2_ctrl),
-	SH_PFC_PIN_GROUP(hscif3_data),		/* suffix might be updated */
-	SH_PFC_PIN_GROUP(hscif3_clk),		/* suffix might be updated */
-	SH_PFC_PIN_GROUP(hscif3_ctrl),		/* suffix might be updated */
-	SH_PFC_PIN_GROUP(hscif3_data_a),	/* suffix might be updated */
-	SH_PFC_PIN_GROUP(hscif3_clk_a),		/* suffix might be updated */
-	SH_PFC_PIN_GROUP(hscif3_ctrl_a),	/* suffix might be updated */
+	SH_PFC_PIN_GROUP(hscif3_data_a),
+	SH_PFC_PIN_GROUP(hscif3_clk_a),
+	SH_PFC_PIN_GROUP(hscif3_ctrl_a),
+	SH_PFC_PIN_GROUP(hscif3_data_b),
+	SH_PFC_PIN_GROUP(hscif3_clk_b),
+	SH_PFC_PIN_GROUP(hscif3_ctrl_b),
 
 	SH_PFC_PIN_GROUP(i2c0),
 	SH_PFC_PIN_GROUP(i2c1),
@@ -2612,6 +2688,18 @@ static const struct sh_pfc_pin_group pinmux_groups[] = {
 	SH_PFC_PIN_GROUP(i2c4),
 	SH_PFC_PIN_GROUP(i2c5),
 
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
@@ -2665,18 +2753,18 @@ static const struct sh_pfc_pin_group pinmux_groups[] = {
 	SH_PFC_PIN_GROUP(pcie0_clkreq_n),
 	SH_PFC_PIN_GROUP(pcie1_clkreq_n),
 
-	SH_PFC_PIN_GROUP(pwm0_a),		/* suffix might be updated */
+	SH_PFC_PIN_GROUP(pwm0),
 	SH_PFC_PIN_GROUP(pwm1_a),
 	SH_PFC_PIN_GROUP(pwm1_b),
-	SH_PFC_PIN_GROUP(pwm2_b),		/* suffix might be updated */
+	SH_PFC_PIN_GROUP(pwm2),
 	SH_PFC_PIN_GROUP(pwm3_a),
 	SH_PFC_PIN_GROUP(pwm3_b),
 	SH_PFC_PIN_GROUP(pwm4),
 	SH_PFC_PIN_GROUP(pwm5),
 	SH_PFC_PIN_GROUP(pwm6),
 	SH_PFC_PIN_GROUP(pwm7),
-	SH_PFC_PIN_GROUP(pwm8_a),		/* suffix might be updated */
-	SH_PFC_PIN_GROUP(pwm9_a),		/* suffix might be updated */
+	SH_PFC_PIN_GROUP(pwm8),
+	SH_PFC_PIN_GROUP(pwm9),
 
 	SH_PFC_PIN_GROUP(qspi0_ctrl),
 	BUS_DATA_PIN_GROUP(qspi0_data, 2),
@@ -2688,18 +2776,18 @@ static const struct sh_pfc_pin_group pinmux_groups[] = {
 	SH_PFC_PIN_GROUP(scif0_data),
 	SH_PFC_PIN_GROUP(scif0_clk),
 	SH_PFC_PIN_GROUP(scif0_ctrl),
-	SH_PFC_PIN_GROUP(scif1_data),		/* suffix might be updated */
-	SH_PFC_PIN_GROUP(scif1_clk),		/* suffix might be updated */
-	SH_PFC_PIN_GROUP(scif1_ctrl),		/* suffix might be updated */
-	SH_PFC_PIN_GROUP(scif1_data_x),		/* suffix might be updated */
-	SH_PFC_PIN_GROUP(scif1_clk_x),		/* suffix might be updated */
-	SH_PFC_PIN_GROUP(scif1_ctrl_x),		/* suffix might be updated */
-	SH_PFC_PIN_GROUP(scif3_data),		/* suffix might be updated */
-	SH_PFC_PIN_GROUP(scif3_clk),		/* suffix might be updated */
-	SH_PFC_PIN_GROUP(scif3_ctrl),		/* suffix might be updated */
-	SH_PFC_PIN_GROUP(scif3_data_a),		/* suffix might be updated */
-	SH_PFC_PIN_GROUP(scif3_clk_a),		/* suffix might be updated */
-	SH_PFC_PIN_GROUP(scif3_ctrl_a),		/* suffix might be updated */
+	SH_PFC_PIN_GROUP(scif1_data_a),
+	SH_PFC_PIN_GROUP(scif1_clk_a),
+	SH_PFC_PIN_GROUP(scif1_ctrl_a),
+	SH_PFC_PIN_GROUP(scif1_data_b),
+	SH_PFC_PIN_GROUP(scif1_clk_b),
+	SH_PFC_PIN_GROUP(scif1_ctrl_b),
+	SH_PFC_PIN_GROUP(scif3_data_a),
+	SH_PFC_PIN_GROUP(scif3_clk_a),
+	SH_PFC_PIN_GROUP(scif3_ctrl_a),
+	SH_PFC_PIN_GROUP(scif3_data_b),
+	SH_PFC_PIN_GROUP(scif3_clk_b),
+	SH_PFC_PIN_GROUP(scif3_ctrl_b),
 	SH_PFC_PIN_GROUP(scif4_data),
 	SH_PFC_PIN_GROUP(scif4_clk),
 	SH_PFC_PIN_GROUP(scif4_ctrl),
@@ -2709,14 +2797,14 @@ static const struct sh_pfc_pin_group pinmux_groups[] = {
 	SH_PFC_PIN_GROUP(ssi_data),
 	SH_PFC_PIN_GROUP(ssi_ctrl),
 
-	SH_PFC_PIN_GROUP(tpu_to0),		/* suffix might be updated */
-	SH_PFC_PIN_GROUP(tpu_to0_a),		/* suffix might be updated */
-	SH_PFC_PIN_GROUP(tpu_to1),		/* suffix might be updated */
-	SH_PFC_PIN_GROUP(tpu_to1_a),		/* suffix might be updated */
-	SH_PFC_PIN_GROUP(tpu_to2),		/* suffix might be updated */
-	SH_PFC_PIN_GROUP(tpu_to2_a),		/* suffix might be updated */
-	SH_PFC_PIN_GROUP(tpu_to3),		/* suffix might be updated */
-	SH_PFC_PIN_GROUP(tpu_to3_a),		/* suffix might be updated */
+	SH_PFC_PIN_GROUP(tpu_to0_a),
+	SH_PFC_PIN_GROUP(tpu_to0_b),
+	SH_PFC_PIN_GROUP(tpu_to1_a),
+	SH_PFC_PIN_GROUP(tpu_to1_b),
+	SH_PFC_PIN_GROUP(tpu_to2_a),
+	SH_PFC_PIN_GROUP(tpu_to2_b),
+	SH_PFC_PIN_GROUP(tpu_to3_a),
+	SH_PFC_PIN_GROUP(tpu_to3_b),
 
 	SH_PFC_PIN_GROUP(tsn0_link),
 	SH_PFC_PIN_GROUP(tsn0_phy_int),
@@ -2790,8 +2878,7 @@ static const char * const canfd4_groups[] = {
 };
 
 static const char * const canfd5_groups[] = {
-	/* suffix might be updated */
-	"canfd5_data",
+	"canfd5_data_a",
 	"canfd5_data_b",
 };
 
@@ -2814,13 +2901,12 @@ static const char * const hscif0_groups[] = {
 };
 
 static const char * const hscif1_groups[] = {
-	/* suffix might be updated */
-	"hscif1_data",
-	"hscif1_clk",
-	"hscif1_ctrl",
-	"hscif1_data_x",
-	"hscif1_clk_x",
-	"hscif1_ctrl_x",
+	"hscif1_data_a",
+	"hscif1_clk_a",
+	"hscif1_ctrl_a",
+	"hscif1_data_b",
+	"hscif1_clk_b",
+	"hscif1_ctrl_b",
 };
 
 static const char * const hscif2_groups[] = {
@@ -2830,13 +2916,12 @@ static const char * const hscif2_groups[] = {
 };
 
 static const char * const hscif3_groups[] = {
-	/* suffix might be updated */
-	"hscif3_data",
-	"hscif3_clk",
-	"hscif3_ctrl",
 	"hscif3_data_a",
 	"hscif3_clk_a",
 	"hscif3_ctrl_a",
+	"hscif3_data_b",
+	"hscif3_clk_b",
+	"hscif3_ctrl_b",
 };
 
 static const char * const i2c0_groups[] = {
@@ -2863,6 +2948,20 @@ static const char * const i2c5_groups[] = {
 	"i2c5",
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
@@ -2933,8 +3032,7 @@ static const char * const pcie_groups[] = {
 };
 
 static const char * const pwm0_groups[] = {
-	/* suffix might be updated */
-	"pwm0_a",
+	"pwm0",
 };
 
 static const char * const pwm1_groups[] = {
@@ -2943,8 +3041,7 @@ static const char * const pwm1_groups[] = {
 };
 
 static const char * const pwm2_groups[] = {
-	/* suffix might be updated */
-	"pwm2_b",
+	"pwm2",
 };
 
 static const char * const pwm3_groups[] = {
@@ -2969,13 +3066,11 @@ static const char * const pwm7_groups[] = {
 };
 
 static const char * const pwm8_groups[] = {
-	/* suffix might be updated */
-	"pwm8_a",
+	"pwm8",
 };
 
 static const char * const pwm9_groups[] = {
-	/* suffix might be updated */
-	"pwm9_a",
+	"pwm9",
 };
 
 static const char * const qspi0_groups[] = {
@@ -2997,23 +3092,21 @@ static const char * const scif0_groups[] = {
 };
 
 static const char * const scif1_groups[] = {
-	/* suffix might be updated */
-	"scif1_data",
-	"scif1_clk",
-	"scif1_ctrl",
-	"scif1_data_x",
-	"scif1_clk_x",
-	"scif1_ctrl_x",
+	"scif1_data_a",
+	"scif1_clk_a",
+	"scif1_ctrl_a",
+	"scif1_data_b",
+	"scif1_clk_b",
+	"scif1_ctrl_b",
 };
 
 static const char * const scif3_groups[] = {
-	/* suffix might be updated */
-	"scif3_data",
-	"scif3_clk",
-	"scif3_ctrl",
 	"scif3_data_a",
 	"scif3_clk_a",
 	"scif3_ctrl_a",
+	"scif3_data_b",
+	"scif3_clk_b",
+	"scif3_ctrl_b",
 };
 
 static const char * const scif4_groups[] = {
@@ -3036,15 +3129,14 @@ static const char * const ssi_groups[] = {
 };
 
 static const char * const tpu_groups[] = {
-	/* suffix might be updated */
-	"tpu_to0",
 	"tpu_to0_a",
-	"tpu_to1",
+	"tpu_to0_b",
 	"tpu_to1_a",
-	"tpu_to2",
+	"tpu_to1_b",
 	"tpu_to2_a",
-	"tpu_to3",
+	"tpu_to2_b",
 	"tpu_to3_a",
+	"tpu_to3_b",
 };
 
 static const char * const tsn0_groups[] = {
@@ -3087,6 +3179,8 @@ static const struct sh_pfc_function pinmux_functions[] = {
 	SH_PFC_FUNCTION(i2c4),
 	SH_PFC_FUNCTION(i2c5),
 
+	SH_PFC_FUNCTION(intc_ex),
+
 	SH_PFC_FUNCTION(mmc),
 
 	SH_PFC_FUNCTION(msiof0),
-- 
2.45.2

