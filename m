Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18DA8D7237B
	for <u-boot@archiver.kernel.org>; Fri, 23 Jan 2026 11:49:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0EC1083B85;
	Fri, 23 Jan 2026 12:47:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="Mz3Aq8QT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 316048397D; Fri, 23 Jan 2026 12:47:04 +0100 (CET)
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 72D7F83D9C
 for <u-boot@lists.denx.de>; Fri, 23 Jan 2026 12:46:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=richard.genoud@bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id 223A94E42214;
 Fri, 23 Jan 2026 11:46:49 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id EB9256070A;
 Fri, 23 Jan 2026 11:46:48 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id D7F3B119A87C5; Fri, 23 Jan 2026 12:46:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1769168807; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding:in-reply-to:references;
 bh=qg5PlukUHD9MW57PvNpC8Os8Ktuc/3bdcEfjBe2vwS4=;
 b=Mz3Aq8QTbXquuOr5MsYQsbJMYNJfYln1wUiNrKUBwtZcwAaFSykLuOzbN88bxL2GLgx2kJ
 wUAAQiXqtfjb/zGjTYmI33cLxKIxTsN2rRJ9pybLuua9RpAAiyqFhJy6fx+od0TysXkBe3
 Hp2woUaubr9WZXAEDf5i5+X7h3HD39CvXZmvYrlDgttznkq1LTUhQihW/k6eeEr+UR1/YT
 wn7rTnVSy+CnbsMBWyp4RdC8WbCGzTe/vU007SzegFN/Oi0XXy7ndLB68g7dWozt+gzcMc
 XBGzeqR3+sy1eflwYPL9GtZa/SByopQbOSX/cKuEU297jKpDIhjaWJLvAMnRnQ==
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
Subject: [PATCH v3 26/26] tools: sunxi-spl-image-builder: support H6/H616 NAND
 boot
Date: Fri, 23 Jan 2026 12:45:01 +0100
Message-ID: <20260123114507.1400918-27-richard.genoud@bootlin.com>
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

The H6/H616 boot ROM doesn't expect a SPL scrambled the same way as
older SoCs.
It doesn't use a specific seeds table, it expects a maximized ECC
(BCH-80), a specific BBM (FF000301) and doesn't work if empty pages are
skipped (it needs its specific BBM, even in the padding).

So, add a --soc=h6 option to support H6/616 with:
- more ECC strengths
- specific BBM
- default_scrambler_seeds[] with all values
- no empty pages skip

In Kconfig, select BCH-80 by default for SUNXI_SPL_ECC_STRENGTH to make
BROM happy.

And in scripts/Makefile.xpl, use --soc=h6 option when building for a
SUN50I_GEN_H6 SoC.

Tested on Whatsminer H616 board, booting from NAND.

Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>
Co-developed-by: James Hilliard <james.hilliard1@gmail.com>
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
Signed-off-by: Richard Genoud <richard.genoud@bootlin.com>
---
 drivers/mtd/nand/raw/Kconfig    |  1 +
 scripts/Makefile.xpl            |  1 +
 tools/sunxi-spl-image-builder.c | 92 ++++++++++++++++++++++++++-------
 3 files changed, 75 insertions(+), 19 deletions(-)

diff --git a/drivers/mtd/nand/raw/Kconfig b/drivers/mtd/nand/raw/Kconfig
index 140fd5e7689b..cbce0913e09c 100644
--- a/drivers/mtd/nand/raw/Kconfig
+++ b/drivers/mtd/nand/raw/Kconfig
@@ -483,6 +483,7 @@ if NAND_SUNXI
 
 config NAND_SUNXI_SPL_ECC_STRENGTH
 	int "Allwinner NAND SPL ECC Strength"
+	default 80 if SUN50I_GEN_H6
 	default 64
 
 config NAND_SUNXI_SPL_ECC_SIZE
diff --git a/scripts/Makefile.xpl b/scripts/Makefile.xpl
index 52f014ad3324..ff611bd07b48 100644
--- a/scripts/Makefile.xpl
+++ b/scripts/Makefile.xpl
@@ -455,6 +455,7 @@ $(obj)/sunxi-spl.bin: $(obj)/$(SPL_BIN).bin FORCE
 
 quiet_cmd_sunxi_spl_image_builder = SUNXI_SPL_IMAGE_BUILDER $@
 cmd_sunxi_spl_image_builder = $(objtree)/tools/sunxi-spl-image-builder \
+				$(if $(CONFIG_SUN50I_GEN_H6),--soc=h6) \
 				-c $(CONFIG_NAND_SUNXI_SPL_ECC_STRENGTH)/$(CONFIG_NAND_SUNXI_SPL_ECC_SIZE) \
 				-p $(CONFIG_SYS_NAND_PAGE_SIZE) \
 				-o $(CONFIG_SYS_NAND_OOBSIZE) \
diff --git a/tools/sunxi-spl-image-builder.c b/tools/sunxi-spl-image-builder.c
index a367f1177403..8a8ab124a7e4 100644
--- a/tools/sunxi-spl-image-builder.c
+++ b/tools/sunxi-spl-image-builder.c
@@ -11,6 +11,7 @@
 #include <linux/bch.h>
 
 #include <getopt.h>
+#include <string.h>
 #include <version.h>
 
 #define BCH_PRIMITIVE_POLY	0x5803
@@ -27,6 +28,7 @@ struct image_info {
 	int eraseblock_size;
 	int scramble;
 	int boot0;
+	int h6;
 	off_t offset;
 	const char *source;
 	const char *dest;
@@ -84,18 +86,29 @@ static void scramble(const struct image_info *info,
 	uint16_t state;
 	int i;
 
-	/* Boot0 is always scrambled no matter the command line option. */
-	if (info->boot0) {
+	/*
+	 * Bail out earlier if the user didn't ask for scrambling.
+	 * But Boot0 is always scrambled no matter the command line option.
+	 */
+	if (!info->boot0 && !info->scramble)
+		return;
+
+	/*
+	 * On H6, the BROM scrambler seed is no different than the default one
+	 */
+	if (info->boot0 && !info->h6) {
 		state = brom_scrambler_seeds[0];
 	} else {
-		unsigned seedmod = info->eraseblock_size / info->page_size;
+		unsigned int seedmod;
 
-		/* Bail out earlier if the user didn't ask for scrambling. */
-		if (!info->scramble)
-			return;
-
-		if (seedmod > ARRAY_SIZE(default_scrambler_seeds))
+		if (info->h6) {
+			/* H6 boot0 uses all 128 seeds */
 			seedmod = ARRAY_SIZE(default_scrambler_seeds);
+		} else {
+			seedmod = info->eraseblock_size / info->page_size;
+			if (seedmod > ARRAY_SIZE(default_scrambler_seeds))
+				seedmod = ARRAY_SIZE(default_scrambler_seeds);
+		}
 
 		state = default_scrambler_seeds[page % seedmod];
 	}
@@ -137,14 +150,19 @@ static int write_page(const struct image_info *info, uint8_t *buffer,
 
 	fwrite(buffer, info->page_size + info->oob_size, 1, dst);
 
-	for (i = 0; i < info->usable_page_size; i++) {
-		if (buffer[i] !=  0xff)
-			break;
-	}
+	/*
+	 * H6 BROM doesn't support empty pages
+	 */
+	if (!info->h6) {
+		for (i = 0; i < info->usable_page_size; i++) {
+			if (buffer[i] !=  0xff)
+				break;
+		}
 
-	/* We leave empty pages at 0xff. */
-	if (i == info->usable_page_size)
-		return 0;
+		/* We leave empty pages at 0xff. */
+		if (i == info->usable_page_size)
+			return 0;
+	}
 
 	/* Restore the source pointer to read it again. */
 	fseek(src, -cnt, SEEK_CUR);
@@ -212,6 +230,14 @@ static int write_page(const struct image_info *info, uint8_t *buffer,
 		}
 
 		memset(ecc, 0, eccbytes);
+
+		if (info->h6) {
+			/* BBM taken from vendor code: FF 00 03 01 */
+			buffer[info->ecc_step_size + 1] = 0;
+			buffer[info->ecc_step_size + 2] = 3; // NAND_VERSION_0
+			buffer[info->ecc_step_size + 3] = 1; // NAND_VERSION_1
+		}
+
 		swap_bits(buffer, info->ecc_step_size + 4);
 		encode_bch(bch, buffer, info->ecc_step_size + 4, ecc);
 		swap_bits(buffer, info->ecc_step_size + 4);
@@ -303,6 +329,8 @@ static void display_help(int status)
 		"-e <size>        --eraseblock=<size>  Erase block size\n"
 		"-b               --boot0              Build a boot0 image.\n"
 		"-s               --scramble           Scramble data\n"
+		"-t               --soc=<soc>          Build an image compatible with SoC type <soc>\n"
+		"                                      (possible values: a10, h6. Default: a10)\n"
 		"-a <offset>      --address=<offset>   Where the image will be programmed.\n"
 		"\n"
 		"Notes:\n"
@@ -313,6 +341,9 @@ static void display_help(int status)
 		"  Valid ECC strengths: 16, 24, 28, 32, 40, 48, 56, 60 and 64\n"
 		"  Valid ECC step size: 512 and 1024\n"
 		"\n"
+		"On H6/H616, the only ECC step size supported is 1024, but more ECC\n"
+		"strengths are supported: 44, 52, 68, 72, 76, 80\n"
+		"\n"
 		"If you are building a boot0 image, you'll have specify extra options.\n"
 		"These options should be chosen based on the layouts described here:\n"
 		"  http://linux-sunxi.org/NAND#More_information_on_BROM_NAND\n"
@@ -342,7 +373,12 @@ static void display_help(int status)
 
 static int check_image_info(struct image_info *info)
 {
-	static int valid_ecc_strengths[] = { 16, 24, 28, 32, 40, 48, 56, 60, 64 };
+	static int ecc_strengths_a10[] = { 16, 24, 28, 32, 40, 48, 56, 60, 64 };
+	static int ecc_strengths_h6[] = {
+		16, 24, 28, 32, 40, 44, 48, 52, 56, 60, 64, 68, 72, 76, 80
+	};
+	int *valid_ecc_strengths;
+	size_t nstrengths;
 	int eccbytes, eccsteps;
 	unsigned i;
 
@@ -367,12 +403,25 @@ static int check_image_info(struct image_info *info)
 		return -EINVAL;
 	}
 
-	for (i = 0; i < ARRAY_SIZE(valid_ecc_strengths); i++) {
+	if (info->h6) {
+		if (info->ecc_step_size != 1024) {
+			fprintf(stderr,
+				"H6 SoCs supports only 1024 bytes ECC step\n");
+			return -EINVAL;
+		}
+		valid_ecc_strengths = ecc_strengths_h6;
+		nstrengths = ARRAY_SIZE(ecc_strengths_h6);
+	} else {
+		valid_ecc_strengths = ecc_strengths_a10;
+		nstrengths = ARRAY_SIZE(ecc_strengths_a10);
+	}
+
+	for (i = 0; i < nstrengths; i++) {
 		if (valid_ecc_strengths[i] == info->ecc_strength)
 			break;
 	}
 
-	if (i == ARRAY_SIZE(valid_ecc_strengths)) {
+	if (i == nstrengths) {
 		fprintf(stderr, "Invalid ECC strength argument: %d\n",
 			info->ecc_strength);
 		return -EINVAL;
@@ -416,10 +465,11 @@ int main(int argc, char **argv)
 			{"boot0", no_argument, 0, 'b'},
 			{"scramble", no_argument, 0, 's'},
 			{"address", required_argument, 0, 'a'},
+			{"soc", required_argument, 0, 't'},
 			{0, 0, 0, 0},
 		};
 
-		int c = getopt_long(argc, argv, "c:p:o:u:e:ba:sh",
+		int c = getopt_long(argc, argv, "c:p:o:u:e:ba:sht:",
 				long_options, &option_index);
 		if (c == EOF)
 			break;
@@ -454,6 +504,10 @@ int main(int argc, char **argv)
 		case 'a':
 			info.offset = strtoull(optarg, NULL, 0);
 			break;
+		case 't':
+			if (strcmp("h6", optarg) == 0)
+				info.h6 = 1;
+			break;
 		case '?':
 			display_help(-1);
 			break;
-- 
2.47.3

