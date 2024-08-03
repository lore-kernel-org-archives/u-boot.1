Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E89AC49EA1
	for <u-boot@archiver.kernel.org>; Sat,  3 Aug 2024 16:16:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6242988CDA;
	Sat,  3 Aug 2024 18:15:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1722701719;
	bh=6DGJ2H5wB/yz5dlc/gCEfSlg991/vWHlr8180YXo8ww=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=aeYxHF5nQDi8tIYuH90uuBwaTkFCyKBtlKQtPKZ4jHUm4rmI0kW4w9NTk4C0HXXtp
	 z4cSet7F1xRJidao2moUgKFLR7/AZgVxf1vj++tuwgfdsr8wD8QfkikjXVlkFGPqIp
	 PjYPOYDVZ8qj3oC/Bx7pNqkpIKCdTeHrSS+X4TBPTgE1Lz/YrWNNwpLDt8sQ/VKXC0
	 ILSixn2NfPmLlkpkOBIllcNbBYdyIdQ3qI6CRs+QQjYTSallg7X0yBKrMrkqZw0eGg
	 tMW+7NjcANDqTfUvfsk3vbPR9HKOM1FnBeuOCcesSCJ4ma2m7TLNWLs6iR2eVMGSj5
	 RwLebVKNavZ8Q==
Received: from crub.agik.hopto.org (p54833c06.dip0.t-ipconnect.de
 [84.131.60.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: agust@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id C818C88C57;
 Sat,  3 Aug 2024 18:15:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1722701715;
 bh=6DGJ2H5wB/yz5dlc/gCEfSlg991/vWHlr8180YXo8ww=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=UkTHIPTpV1X9ksKRlCp8Wr2WLBxDN8awb/RizC4A+7OKwixWNWYNTaTysZG1XdMve
 2bWq8C02WztVINqOYavwbW4W8fWROAaI4DcBvqfpwLW30LlKmheqK0fYrDTADo5h0z
 pvm9aKmbkB8h09uVrfOi+rP94AXjHdyRI/G/oeEX19IKfCu1DBMeQ+R5/qt3JlF0jv
 +4sk7G5b3ioojcq+d/bzYaxSWOSAb8xAwwrrPcGZRULDeYhIyUjPb7+wr2AFo1Pjwn
 BhHgyDulTVNPmQsa3yng0dhTYYO7OA33Z2HNUUEkngwx/BDc/H7qlQB3j5PwZ6atO2
 v+KWcnY9IHhQw==
From: Anatolij Gustschin <agust@denx.de>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>, Fabio Estevam <festevam@denx.de>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 07/11] board: novena: convert to DM_I2C
Date: Sat,  3 Aug 2024 18:15:09 +0200
Message-Id: <20240803161513.486062-7-agust@denx.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240803161513.486062-1-agust@denx.de>
References: <20240803161513.486062-1-agust@denx.de>
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

Conversion to DM_I2C is mandatory, enable DM_I2C
to disable board removal warning. Convert EEPROM
and IT6251 access to use DM_I2C API.

Signed-off-by: Anatolij Gustschin <agust@denx.de>
---
Cc: Marek Vasut <marex@denx.de>
Cc: Fabio Estevam <festevam@denx.de>
Cc: Tom Rini <trini@konsulko.com>
---
 board/kosagi/novena/novena.c |  10 +--
 board/kosagi/novena/video.c  | 140 +++++++++++++++++++----------------
 configs/novena_defconfig     |   2 +-
 3 files changed, 81 insertions(+), 71 deletions(-)

diff --git a/board/kosagi/novena/novena.c b/board/kosagi/novena/novena.c
index 3220727f23..f65551ece5 100644
--- a/board/kosagi/novena/novena.c
+++ b/board/kosagi/novena/novena.c
@@ -137,23 +137,23 @@ struct novena_eeprom_data {
 int misc_init_r(void)
 {
 	struct novena_eeprom_data data;
-	uchar *datap = (uchar *)&data;
+	uint8_t *datap = (uint8_t *)&data;
 	const char *signature = "Novena";
+	struct udevice *eeprom;
 	int ret;
 
 	/* If 'ethaddr' is already set, do nothing. */
 	if (env_get("ethaddr"))
 		return 0;
 
-	/* EEPROM is at bus 2. */
-	ret = i2c_set_bus_num(2);
+	/* EEPROM is at bus 2, address 0x56 */
+	ret = i2c_get_chip_for_busnum(2, 0x56, 1, &eeprom);
 	if (ret) {
 		puts("Cannot select EEPROM I2C bus.\n");
 		return 0;
 	}
 
-	/* EEPROM is at address 0x56. */
-	ret = eeprom_read(0x56, 0, datap, sizeof(data));
+	ret = dm_i2c_read(eeprom, 0, datap, sizeof(data));
 	if (ret) {
 		puts("Cannot read I2C EEPROM.\n");
 		return 0;
diff --git a/board/kosagi/novena/video.c b/board/kosagi/novena/video.c
index be5a737a31..67f98431b5 100644
--- a/board/kosagi/novena/video.c
+++ b/board/kosagi/novena/video.c
@@ -58,28 +58,29 @@
 
 #define IT6521_RETRY_MAX				20
 
+static struct udevice *it6251_chip;
+static struct udevice *it6251_lvds;
+
 static int it6251_is_stable(void)
 {
-	const unsigned int caddr = NOVENA_IT6251_CHIPADDR;
-	const unsigned int laddr = NOVENA_IT6251_LVDSADDR;
 	int status;
 	int clkcnt;
 	int rpclkcnt;
 	int refstate;
 
-	rpclkcnt = (i2c_reg_read(caddr, 0x13) & 0xff) |
-		   ((i2c_reg_read(caddr, 0x14) << 8) & 0x0f00);
+	rpclkcnt = (dm_i2c_reg_read(it6251_chip, 0x13) & 0xff) |
+		   ((dm_i2c_reg_read(it6251_chip, 0x14) << 8) & 0x0f00);
 	debug("RPCLKCnt: %d\n", rpclkcnt);
 
-	status = i2c_reg_read(caddr, IT6251_SYSTEM_STATUS);
+	status = dm_i2c_reg_read(it6251_chip, IT6251_SYSTEM_STATUS);
 	debug("System status: 0x%02x\n", status);
 
-	clkcnt = (i2c_reg_read(laddr, IT6251_REG_PCLK_CNT_LOW) & 0xff) |
-		 ((i2c_reg_read(laddr, IT6251_REG_PCLK_CNT_HIGH) << 8) &
+	clkcnt = (dm_i2c_reg_read(it6251_lvds, IT6251_REG_PCLK_CNT_LOW) & 0xff) |
+		 ((dm_i2c_reg_read(it6251_lvds, IT6251_REG_PCLK_CNT_HIGH) << 8) &
 		  0x0f00);
 	debug("Clock: 0x%02x\n", clkcnt);
 
-	refstate = i2c_reg_read(laddr, IT6251_REF_STATE);
+	refstate = dm_i2c_reg_read(it6251_lvds, IT6251_REF_STATE);
 	debug("Ref Link State: 0x%02x\n", refstate);
 
 	if ((refstate & 0x1f) != 0)
@@ -97,16 +98,14 @@ static int it6251_is_stable(void)
 
 static int it6251_ready(void)
 {
-	const unsigned int caddr = NOVENA_IT6251_CHIPADDR;
-
 	/* Test if the IT6251 came out of reset by reading ID regs. */
-	if (i2c_reg_read(caddr, IT6251_VENDOR_ID_LOW) != 0x15)
+	if (dm_i2c_reg_read(it6251_chip, IT6251_VENDOR_ID_LOW) != 0x15)
 		return 0;
-	if (i2c_reg_read(caddr, IT6251_VENDOR_ID_HIGH) != 0xca)
+	if (dm_i2c_reg_read(it6251_chip, IT6251_VENDOR_ID_HIGH) != 0xca)
 		return 0;
-	if (i2c_reg_read(caddr, IT6251_DEVICE_ID_LOW) != 0x51)
+	if (dm_i2c_reg_read(it6251_chip, IT6251_DEVICE_ID_LOW) != 0x51)
 		return 0;
-	if (i2c_reg_read(caddr, IT6251_DEVICE_ID_HIGH) != 0x62)
+	if (dm_i2c_reg_read(it6251_chip, IT6251_DEVICE_ID_HIGH) != 0x62)
 		return 0;
 
 	return 1;
@@ -114,116 +113,112 @@ static int it6251_ready(void)
 
 static void it6251_program_regs(void)
 {
-	const unsigned int caddr = NOVENA_IT6251_CHIPADDR;
-	const unsigned int laddr = NOVENA_IT6251_LVDSADDR;
-
-	i2c_reg_write(caddr, 0x05, 0x00);
+	dm_i2c_reg_write(it6251_chip, 0x05, 0x00);
 	mdelay(1);
 
 	/* set LVDSRX address, and enable */
-	i2c_reg_write(caddr, 0xfd, 0xbc);
-	i2c_reg_write(caddr, 0xfe, 0x01);
+	dm_i2c_reg_write(it6251_chip, 0xfd, 0xbc);
+	dm_i2c_reg_write(it6251_chip, 0xfe, 0x01);
 
 	/*
 	 * LVDSRX
 	 */
 	/* This write always fails, because the chip goes into reset */
 	/* reset LVDSRX */
-	i2c_reg_write(laddr, 0x05, 0xff);
-	i2c_reg_write(laddr, 0x05, 0x00);
+	dm_i2c_reg_write(it6251_lvds, 0x05, 0xff);
+	dm_i2c_reg_write(it6251_lvds, 0x05, 0x00);
 
 	/* reset LVDSRX PLL */
-	i2c_reg_write(laddr, 0x3b, 0x42);
-	i2c_reg_write(laddr, 0x3b, 0x43);
+	dm_i2c_reg_write(it6251_lvds, 0x3b, 0x42);
+	dm_i2c_reg_write(it6251_lvds, 0x3b, 0x43);
 
 	/* something with SSC PLL */
-	i2c_reg_write(laddr, 0x3c, 0x08);
+	dm_i2c_reg_write(it6251_lvds, 0x3c, 0x08);
 	/* don't swap links, but writing reserved registers */
-	i2c_reg_write(laddr, 0x0b, 0x88);
+	dm_i2c_reg_write(it6251_lvds, 0x0b, 0x88);
 
 	/* JEIDA, 8-bit depth  0x11, orig 0x42 */
-	i2c_reg_write(laddr, 0x2c, 0x01);
+	dm_i2c_reg_write(it6251_lvds, 0x2c, 0x01);
 	/* "reserved" */
-	i2c_reg_write(laddr, 0x32, 0x04);
+	dm_i2c_reg_write(it6251_lvds, 0x32, 0x04);
 	/* "reserved" */
-	i2c_reg_write(laddr, 0x35, 0xe0);
+	dm_i2c_reg_write(it6251_lvds, 0x35, 0xe0);
 	/* "reserved" + clock delay */
-	i2c_reg_write(laddr, 0x2b, 0x24);
+	dm_i2c_reg_write(it6251_lvds, 0x2b, 0x24);
 
 	/* reset LVDSRX pix clock */
-	i2c_reg_write(laddr, 0x05, 0x02);
-	i2c_reg_write(laddr, 0x05, 0x00);
+	dm_i2c_reg_write(it6251_lvds, 0x05, 0x02);
+	dm_i2c_reg_write(it6251_lvds, 0x05, 0x00);
 
 	/*
 	 * DPTX
 	 */
 	/* set for two lane mode, normal op, no swapping, no downspread */
-	i2c_reg_write(caddr, 0x16, 0x02);
+	dm_i2c_reg_write(it6251_chip, 0x16, 0x02);
 
 	/* some AUX channel EDID magic */
-	i2c_reg_write(caddr, 0x23, 0x40);
+	dm_i2c_reg_write(it6251_chip, 0x23, 0x40);
 
 	/* power down lanes 3-0 */
-	i2c_reg_write(caddr, 0x5c, 0xf3);
+	dm_i2c_reg_write(it6251_chip, 0x5c, 0xf3);
 
 	/* enable DP scrambling, change EQ CR phase */
-	i2c_reg_write(caddr, 0x5f, 0x06);
+	dm_i2c_reg_write(it6251_chip, 0x5f, 0x06);
 
 	/* color mode RGB, pclk/2 */
-	i2c_reg_write(caddr, 0x60, 0x02);
+	dm_i2c_reg_write(it6251_chip, 0x60, 0x02);
 	/* dual pixel input mode, no EO swap, no RGB swap */
-	i2c_reg_write(caddr, 0x61, 0x04);
+	dm_i2c_reg_write(it6251_chip, 0x61, 0x04);
 	/* M444B24 video format */
-	i2c_reg_write(caddr, 0x62, 0x01);
+	dm_i2c_reg_write(it6251_chip, 0x62, 0x01);
 
 	/* vesa range / not interlace / vsync high / hsync high */
-	i2c_reg_write(caddr, 0xa0, 0x0F);
+	dm_i2c_reg_write(it6251_chip, 0xa0, 0x0F);
 
 	/* hpd event timer set to 1.6-ish ms */
-	i2c_reg_write(caddr, 0xc9, 0xf5);
+	dm_i2c_reg_write(it6251_chip, 0xc9, 0xf5);
 
 	/* more reserved magic */
-	i2c_reg_write(caddr, 0xca, 0x4d);
-	i2c_reg_write(caddr, 0xcb, 0x37);
+	dm_i2c_reg_write(it6251_chip, 0xca, 0x4d);
+	dm_i2c_reg_write(it6251_chip, 0xcb, 0x37);
 
 	/* enhanced framing mode, auto video fifo reset, video mute disable */
-	i2c_reg_write(caddr, 0xd3, 0x03);
+	dm_i2c_reg_write(it6251_chip, 0xd3, 0x03);
 
 	/* "vidstmp" and some reserved stuff */
-	i2c_reg_write(caddr, 0xd4, 0x45);
+	dm_i2c_reg_write(it6251_chip, 0xd4, 0x45);
 
 	/* queue number -- reserved */
-	i2c_reg_write(caddr, 0xe7, 0xa0);
+	dm_i2c_reg_write(it6251_chip, 0xe7, 0xa0);
 	/* info frame packets  and reserved */
-	i2c_reg_write(caddr, 0xe8, 0x33);
+	dm_i2c_reg_write(it6251_chip, 0xe8, 0x33);
 	/* more AVI stuff */
-	i2c_reg_write(caddr, 0xec, 0x00);
+	dm_i2c_reg_write(it6251_chip, 0xec, 0x00);
 
 	/* select PC master reg for aux channel? */
-	i2c_reg_write(caddr, 0x23, 0x42);
+	dm_i2c_reg_write(it6251_chip, 0x23, 0x42);
 
 	/* send PC request commands */
-	i2c_reg_write(caddr, 0x24, 0x00);
-	i2c_reg_write(caddr, 0x25, 0x00);
-	i2c_reg_write(caddr, 0x26, 0x00);
+	dm_i2c_reg_write(it6251_chip, 0x24, 0x00);
+	dm_i2c_reg_write(it6251_chip, 0x25, 0x00);
+	dm_i2c_reg_write(it6251_chip, 0x26, 0x00);
 
 	/* native aux read */
-	i2c_reg_write(caddr, 0x2b, 0x00);
+	dm_i2c_reg_write(it6251_chip, 0x2b, 0x00);
 	/* back to internal */
-	i2c_reg_write(caddr, 0x23, 0x40);
+	dm_i2c_reg_write(it6251_chip, 0x23, 0x40);
 
 	/* voltage swing level 3 */
-	i2c_reg_write(caddr, 0x19, 0xff);
+	dm_i2c_reg_write(it6251_chip, 0x19, 0xff);
 	/* pre-emphasis level 3 */
-	i2c_reg_write(caddr, 0x1a, 0xff);
+	dm_i2c_reg_write(it6251_chip, 0x1a, 0xff);
 
 	/* start link training */
-	i2c_reg_write(caddr, 0x17, 0x01);
+	dm_i2c_reg_write(it6251_chip, 0x17, 0x01);
 }
 
 static int it6251_init(void)
 {
-	const unsigned int caddr = NOVENA_IT6251_CHIPADDR;
 	int reg;
 	int tries, retries = 0;
 
@@ -233,7 +228,7 @@ static int it6251_init(void)
 
 		/* Wait for video stable. */
 		for (tries = 0; tries < 100; tries++) {
-			reg = i2c_reg_read(caddr, 0x17);
+			reg = dm_i2c_reg_read(it6251_chip, 0x17);
 			/* Test Link CFG, STS, LCS read done. */
 			if ((reg & 0xe0) != 0xe0) {
 				/* Not yet, wait a bit more. */
@@ -285,10 +280,14 @@ static int detect_lvds(struct display_info_t const *dev)
 
 	enable_lvds(dev);
 
-	ret = i2c_set_bus_num(NOVENA_IT6251_I2C_BUS);
-	if (ret) {
-		puts("Cannot select IT6251 I2C bus.\n");
-		return 0;
+	if (!it6251_chip) {
+		ret = i2c_get_chip_for_busnum(NOVENA_IT6251_I2C_BUS,
+					      NOVENA_IT6251_CHIPADDR,
+					      1, &it6251_chip);
+		if (ret) {
+			puts("Cannot select IT6251 I2C bus.\n");
+			return 0;
+		}
 	}
 
 	/* Wait up-to ~250 mS for the LVDS to come up. */
@@ -435,9 +434,20 @@ void setup_display_lvds(void)
 {
 	int ret;
 
-	ret = i2c_set_bus_num(NOVENA_IT6251_I2C_BUS);
+	if (!it6251_chip) {
+		ret = i2c_get_chip_for_busnum(NOVENA_IT6251_I2C_BUS,
+					      NOVENA_IT6251_CHIPADDR,
+					      1, &it6251_chip);
+		if (ret) {
+			puts("Cannot select LVDS-to-eDP I2C bus.\n");
+			return;
+		}
+	}
+
+	ret = i2c_get_chip_for_busnum(NOVENA_IT6251_I2C_BUS,
+				      NOVENA_IT6251_LVDSADDR, 1, &it6251_lvds);
 	if (ret) {
-		puts("Cannot select LVDS-to-eDP I2C bus.\n");
+		puts("Cannot find IT6251 LVDS bus.\n");
 		return;
 	}
 
diff --git a/configs/novena_defconfig b/configs/novena_defconfig
index 322689ef3a..dd3541bc59 100644
--- a/configs/novena_defconfig
+++ b/configs/novena_defconfig
@@ -67,7 +67,7 @@ CONFIG_NETCONSOLE=y
 CONFIG_BOUNCE_BUFFER=y
 CONFIG_DWC_AHSATA=y
 CONFIG_LBA48=y
-CONFIG_SYS_I2C_LEGACY=y
+CONFIG_DM_I2C=y
 CONFIG_SPL_SYS_I2C_LEGACY=y
 CONFIG_SYS_I2C_MXC=y
 CONFIG_FSL_USDHC=y
-- 
2.25.1

