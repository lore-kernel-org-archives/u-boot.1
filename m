Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49E00C3DA49
	for <u-boot@archiver.kernel.org>; Sat, 20 Jul 2024 12:47:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5F15188C9F;
	Sat, 20 Jul 2024 14:44:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="KDVxpc6w";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="cNyoO6PM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1FD5388C91; Sat, 20 Jul 2024 14:43:56 +0200 (CEST)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org
 [IPv6:2001:67c:2050:0:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D036888C7A
 for <u-boot@lists.denx.de>; Sat, 20 Jul 2024 14:43:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4WR5nj4nT3z9sT1;
 Sat, 20 Jul 2024 14:43:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1721479433;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eaoF3BxE2R6vuj65JZt5UX4O0hgyeB7ysyjG0t3/FLs=;
 b=KDVxpc6wTvMepo/bpT8fYDqCkX/IX0fzsoBmMMBhSRkHwb0qoSZ/AhQX8DSd92I7EVrRDl
 qBmFIgH7JRJyp6fVMmqZK2izjWJKHO96NPbreX/X0rgBwUJUT+vderDZ+9zrKVg3qRQxKM
 FYDnfvySrVcQNRhPRbTQPrA8xmckfnakoZF7pBS8dAKpQ7+nacSDvOhJaAeKp1t/lx4bAg
 dIS1ZzpVmJHmsD5uO8W5eBgxp3kDxJOUkN5TrhNu2ilnoXYNE8VNbcxAkw+ZRxzKwN4G6u
 pu/zciJpARQlFFBciCCcnLx8kRL0beXT/WORc/bEWRWNCjUKcH4w5Y7bgCzXbg==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1721479431;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eaoF3BxE2R6vuj65JZt5UX4O0hgyeB7ysyjG0t3/FLs=;
 b=cNyoO6PMOFYTdKbBjAwPbImzXqOQWjUX6FzLgCqFljHIc7qWyPl6RlwTJPtZU1iV97eFIf
 2KBvhuHFTEsll+NLBwfmejMH4ggvejXlp0bkaxlnW6+0LFYmtqWUHzne6I96n2AuckvI6W
 YtOsAv9SbdmroODR6h5rsZ80SUdNk99GV+BjLweRCkvP4t/LgBI07HJU7KtSg9BXWNiRX/
 N1SlOKX8N+b7xatp0MGseDT34bKwv8/DR2K/kSmG80k/8f+FOH92oiq2Z0kwk12+kWQlB0
 uOX8V4qnPmUD0xeewAgjlp41rikA9i1qzimDKSdrUJ/hZJst4rYLwdFDAB3mGA==
To: u-boot@lists.denx.de
Cc: francesco.dolcini@toradex.com, seanga2@gmail.com, sjg@chromium.org,
 trini@konsulko.com, Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: [PATCH 23/40] drivers: pinctrl: Remove duplicate newlines
Date: Sat, 20 Jul 2024 14:40:48 +0200
Message-ID: <20240720124239.7553-23-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20240720124239.7553-1-marek.vasut+renesas@mailbox.org>
References: <20240720124239.7553-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: c6aad8a79b5b8141b79
X-MBO-RS-META: fbkhbspxk79tb3ezopqsufoqgp4j19jk
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

Drop all duplicate newlines. No functional change.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
 drivers/pinctrl/exynos/pinctrl-exynos.h     | 1 -
 drivers/pinctrl/mvebu/pinctrl-armada-37xx.c | 1 -
 drivers/pinctrl/pinctrl-sti.c               | 1 -
 drivers/pinctrl/pinctrl_pic32.c             | 1 -
 drivers/pinctrl/renesas/pfc-r8a77951.c      | 1 -
 drivers/pinctrl/renesas/pfc-r8a7796.c       | 1 -
 drivers/pinctrl/renesas/pfc-r8a77965.c      | 1 -
 drivers/pinctrl/renesas/pfc-r8a77970.c      | 1 -
 drivers/pinctrl/renesas/pfc-r8a77980.c      | 1 -
 drivers/pinctrl/renesas/pfc-r8a77995.c      | 2 --
 drivers/pinctrl/renesas/pfc-r8a779f0.c      | 1 -
 drivers/pinctrl/renesas/pfc-r8a779h0.c      | 1 -
 drivers/pinctrl/renesas/pfc.c               | 1 -
 drivers/pinctrl/tegra/funcmux-tegra20.c     | 1 -
 14 files changed, 15 deletions(-)

diff --git a/drivers/pinctrl/exynos/pinctrl-exynos.h b/drivers/pinctrl/exynos/pinctrl-exynos.h
index 743bb557309..da666777581 100644
--- a/drivers/pinctrl/exynos/pinctrl-exynos.h
+++ b/drivers/pinctrl/exynos/pinctrl-exynos.h
@@ -92,7 +92,6 @@ struct exynos_pinctrl_config_data {
 	const unsigned int	value;
 };
 
-
 void exynos_pinctrl_setup_peri(struct exynos_pinctrl_config_data *conf,
 		unsigned int num_conf, unsigned long base);
 int exynos_pinctrl_set_state(struct udevice *dev,
diff --git a/drivers/pinctrl/mvebu/pinctrl-armada-37xx.c b/drivers/pinctrl/mvebu/pinctrl-armada-37xx.c
index 64036296e24..884ed258d17 100644
--- a/drivers/pinctrl/mvebu/pinctrl-armada-37xx.c
+++ b/drivers/pinctrl/mvebu/pinctrl-armada-37xx.c
@@ -729,7 +729,6 @@ static int armada_37xx_pinctrl_probe(struct udevice *dev)
 	if (!info->funcs)
 		return -ENOMEM;
 
-
 	ret = armada_37xx_fill_group(info);
 	if (ret)
 		return ret;
diff --git a/drivers/pinctrl/pinctrl-sti.c b/drivers/pinctrl/pinctrl-sti.c
index 4996b69d9af..d87249ad1be 100644
--- a/drivers/pinctrl/pinctrl-sti.c
+++ b/drivers/pinctrl/pinctrl-sti.c
@@ -208,7 +208,6 @@ void sti_pin_configure(struct udevice *dev, struct sti_pin_desc *pin_desc)
 		generic_clear_bit(bit, sysconfreg);
 }
 
-
 static int sti_pinctrl_set_state(struct udevice *dev, struct udevice *config)
 {
 	struct fdtdec_phandle_args args;
diff --git a/drivers/pinctrl/pinctrl_pic32.c b/drivers/pinctrl/pinctrl_pic32.c
index 9f38b56e9c0..090351072d8 100644
--- a/drivers/pinctrl/pinctrl_pic32.c
+++ b/drivers/pinctrl/pinctrl_pic32.c
@@ -114,7 +114,6 @@ struct pic32_reg_in_mux {
 #define PPS_OUT(__port, __pin) \
 	(((__port) * PIC32_PINS_PER_PORT + (__pin)) << 2)
 
-
 struct pic32_pinctrl_priv {
 	struct pic32_reg_in_mux *mux_in; /* mux input function */
 	struct pic32_reg_port *pinconf; /* pin configuration*/
diff --git a/drivers/pinctrl/renesas/pfc-r8a77951.c b/drivers/pinctrl/renesas/pfc-r8a77951.c
index 81568ae4a5e..1cfdc335041 100644
--- a/drivers/pinctrl/renesas/pfc-r8a77951.c
+++ b/drivers/pinctrl/renesas/pfc-r8a77951.c
@@ -250,7 +250,6 @@
 #define GPSR7_1		FM(AVS2)
 #define GPSR7_0		FM(AVS1)
 
-
 /* IPSRx */		/* 0 */			/* 1 */		/* 2 */			/* 3 */				/* 4 */		/* 5 */		/* 6 */			/* 7 */		/* 8 */			/* 9 */		/* A */		/* B */		/* C - F */
 #define IP0_3_0		FM(AVB_MDC)		F_(0, 0)	FM(MSIOF2_SS2_C)	F_(0, 0)			F_(0, 0)	F_(0, 0)	F_(0, 0)		F_(0, 0)	F_(0, 0)		F_(0, 0)	F_(0, 0)	F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
 #define IP0_7_4		FM(AVB_MAGIC)		F_(0, 0)	FM(MSIOF2_SS1_C)	FM(SCK4_A)			F_(0, 0)	F_(0, 0)	F_(0, 0)		F_(0, 0)	F_(0, 0)		F_(0, 0)	F_(0, 0)	F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
diff --git a/drivers/pinctrl/renesas/pfc-r8a7796.c b/drivers/pinctrl/renesas/pfc-r8a7796.c
index 3de43febbd3..a289397fb8f 100644
--- a/drivers/pinctrl/renesas/pfc-r8a7796.c
+++ b/drivers/pinctrl/renesas/pfc-r8a7796.c
@@ -256,7 +256,6 @@
 #define GPSR7_1		FM(AVS2)
 #define GPSR7_0		FM(AVS1)
 
-
 /* IPSRx */		/* 0 */			/* 1 */		/* 2 */			/* 3 */				/* 4 */		/* 5 */		/* 6 */			/* 7 */		/* 8 */			/* 9 */		/* A */		/* B */		/* C - F */
 #define IP0_3_0		FM(AVB_MDC)		F_(0, 0)	FM(MSIOF2_SS2_C)	F_(0, 0)			F_(0, 0)	F_(0, 0)	F_(0, 0)		F_(0, 0)	F_(0, 0)		F_(0, 0)	F_(0, 0)	F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
 #define IP0_7_4		FM(AVB_MAGIC)		F_(0, 0)	FM(MSIOF2_SS1_C)	FM(SCK4_A)			F_(0, 0)	F_(0, 0)	F_(0, 0)		F_(0, 0)	F_(0, 0)		F_(0, 0)	F_(0, 0)	F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
diff --git a/drivers/pinctrl/renesas/pfc-r8a77965.c b/drivers/pinctrl/renesas/pfc-r8a77965.c
index 3a6813cee61..2852ae64ec0 100644
--- a/drivers/pinctrl/renesas/pfc-r8a77965.c
+++ b/drivers/pinctrl/renesas/pfc-r8a77965.c
@@ -256,7 +256,6 @@
 #define GPSR7_1		FM(AVS2)
 #define GPSR7_0		FM(AVS1)
 
-
 /* IPSRx */		/* 0 */			/* 1 */		/* 2 */			/* 3 */				/* 4 */		/* 5 */		/* 6 */			/* 7 */		/* 8 */			/* 9 */		/* A */		/* B */		/* C - F */
 #define IP0_3_0		FM(AVB_MDC)		F_(0, 0)	FM(MSIOF2_SS2_C)	F_(0, 0)			F_(0, 0)	F_(0, 0)	F_(0, 0)		F_(0, 0)	F_(0, 0)		F_(0, 0)	F_(0, 0)	F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
 #define IP0_7_4		FM(AVB_MAGIC)		F_(0, 0)	FM(MSIOF2_SS1_C)	FM(SCK4_A)			F_(0, 0)	F_(0, 0)	F_(0, 0)		F_(0, 0)	F_(0, 0)		F_(0, 0)	F_(0, 0)	F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
diff --git a/drivers/pinctrl/renesas/pfc-r8a77970.c b/drivers/pinctrl/renesas/pfc-r8a77970.c
index 3c9c060d245..00ebbbc7120 100644
--- a/drivers/pinctrl/renesas/pfc-r8a77970.c
+++ b/drivers/pinctrl/renesas/pfc-r8a77970.c
@@ -160,7 +160,6 @@
 #define GPSR5_1		FM(QSPI0_MOSI_IO0)
 #define GPSR5_0		FM(QSPI0_SPCLK)
 
-
 /* IPSRx */		/* 0 */				/* 1 */			/* 2 */		/* 3 */		/* 4 */			/* 5 */		/* 6 - F */
 #define IP0_3_0		FM(DU_DR2)			FM(HSCK0)		F_(0, 0)	FM(A0)		F_(0, 0)		F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
 #define IP0_7_4		FM(DU_DR3)			FM(HRTS0_N)		F_(0, 0)	FM(A1)		F_(0, 0)		F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
diff --git a/drivers/pinctrl/renesas/pfc-r8a77980.c b/drivers/pinctrl/renesas/pfc-r8a77980.c
index 14a4b4dc731..e3fc4045741 100644
--- a/drivers/pinctrl/renesas/pfc-r8a77980.c
+++ b/drivers/pinctrl/renesas/pfc-r8a77980.c
@@ -194,7 +194,6 @@
 #define GPSR5_1		FM(QSPI0_MOSI_IO0)
 #define GPSR5_0		FM(QSPI0_SPCLK)
 
-
 /* IPSRx */		/* 0 */				/* 1 */			/* 2 */			/* 3 */		/* 4 */		/* 5 */		/* 6 - F */
 #define IP0_3_0		FM(DU_DR2)			FM(SCK4)		FM(GETHER_RMII_CRS_DV)	FM(A0)		F_(0, 0)	F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
 #define IP0_7_4		FM(DU_DR3)			FM(RX4)			FM(GETHER_RMII_RX_ER)	FM(A1)		F_(0, 0)	F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
diff --git a/drivers/pinctrl/renesas/pfc-r8a77995.c b/drivers/pinctrl/renesas/pfc-r8a77995.c
index eccf5c15907..d3e2d842fa5 100644
--- a/drivers/pinctrl/renesas/pfc-r8a77995.c
+++ b/drivers/pinctrl/renesas/pfc-r8a77995.c
@@ -428,7 +428,6 @@ FM(IP12_31_28)	IP12_31_28 \
 #define MOD_SEL1_27		FM(SEL_SCIF0_0)		FM(SEL_SCIF0_1)
 #define MOD_SEL1_26		FM(SEL_SSIF4_0)		FM(SEL_SSIF4_1)
 
-
 #define PINMUX_MOD_SELS	\
 \
 		MOD_SEL1_31 \
@@ -2870,7 +2869,6 @@ static const struct pinmux_ioctrl_reg pinmux_ioctrl_regs[] = {
 	{ /* sentinel */ }
 };
 
-
 static int r8a77995_pin_to_pocctrl(unsigned int pin, u32 *pocctrl)
 {
 	switch (pin) {
diff --git a/drivers/pinctrl/renesas/pfc-r8a779f0.c b/drivers/pinctrl/renesas/pfc-r8a779f0.c
index de5ec6c812a..eec50210d92 100644
--- a/drivers/pinctrl/renesas/pfc-r8a779f0.c
+++ b/drivers/pinctrl/renesas/pfc-r8a779f0.c
@@ -654,7 +654,6 @@ static const unsigned int i2c5_mux[] = {
 	SDA5_MARK, SCL5_MARK,
 };
 
-
 /* - INTC-EX ---------------------------------------------------------------- */
 static const unsigned int intc_ex_irq0_pins[] = {
 	/* IRQ0 */
diff --git a/drivers/pinctrl/renesas/pfc-r8a779h0.c b/drivers/pinctrl/renesas/pfc-r8a779h0.c
index 17422395ad1..2f09e767288 100644
--- a/drivers/pinctrl/renesas/pfc-r8a779h0.c
+++ b/drivers/pinctrl/renesas/pfc-r8a779h0.c
@@ -261,7 +261,6 @@
 #define GPSR7_1		F_(AVB0_AVTP_CAPTURE,	IP0SR7_7_4)
 #define GPSR7_0		F_(AVB0_AVTP_PPS,	IP0SR7_3_0)
 
-
 /* SR0 */
 /* IP0SR0 */		/* 0 */			/* 1 */			/* 2 */		/* 3		4	 5	  6	   7	    8	     9	      A	       B	C	 D	  E	   F */
 #define IP0SR0_3_0	F_(0, 0)		FM(ERROROUTC_N_B)	FM(TCLK2_B)	F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
diff --git a/drivers/pinctrl/renesas/pfc.c b/drivers/pinctrl/renesas/pfc.c
index 96a47daac35..2f6c3b3d1c7 100644
--- a/drivers/pinctrl/renesas/pfc.c
+++ b/drivers/pinctrl/renesas/pfc.c
@@ -947,7 +947,6 @@ static int sh_pfc_map_pins(struct sh_pfc *pfc, struct sh_pfc_pinctrl *pmx)
 	return 0;
 }
 
-
 static int sh_pfc_pinctrl_probe(struct udevice *dev)
 {
 	struct sh_pfc_pinctrl_priv *priv = dev_get_priv(dev);
diff --git a/drivers/pinctrl/tegra/funcmux-tegra20.c b/drivers/pinctrl/tegra/funcmux-tegra20.c
index b8c91323785..951ae196161 100644
--- a/drivers/pinctrl/tegra/funcmux-tegra20.c
+++ b/drivers/pinctrl/tegra/funcmux-tegra20.c
@@ -32,7 +32,6 @@ static const struct pmux_pingrp_config disp1_default[] = {
 	PINMUX(SLXD,  SPDIF,      NORMAL,    NORMAL),
 };
 
-
 int funcmux_select(enum periph_id id, int config)
 {
 	int bad_config = config != FUNCMUX_DEFAULT;
-- 
2.43.0

