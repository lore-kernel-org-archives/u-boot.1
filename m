Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2295CD11DB
	for <u-boot@archiver.kernel.org>; Wed, 20 Mar 2024 09:03:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 76C9388121;
	Wed, 20 Mar 2024 10:02:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=thorsis.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=thorsis.com header.i=@thorsis.com header.b="aF4caYj4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2BADE88105; Wed, 20 Mar 2024 10:02:26 +0100 (CET)
Received: from mail.thorsis.com (mail.thorsis.com [92.198.35.195])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0F503880FF
 for <u-boot@lists.denx.de>; Wed, 20 Mar 2024 10:02:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=thorsis.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=ada@thorsis.com
From: Alexander Dahl <ada@thorsis.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=thorsis.com; s=default;
 t=1710925337;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8xZ6P7couu4VkuQBFH3dp8QEnxqo0IKhH5lT3hN4AfU=;
 b=aF4caYj4MMw1fAV7gq6pulLfnj43YKggL8LMZZ9O5GI+Kluuc1k+r4TMRHjwHJI4lmgB34
 BrZ1fn+7BfJZey850lzdVMO3tF2rEtT4lO6OSbmycEgEsVMZM6/JKhK8a8K5LSFTYPnpqj
 FWpG0M+EJ0WstsVIrVW33vC0GkqVb0I06ZPCMlAj5ZqCfC9D9vMazoy27YacKlhVAeakp0
 r7OzgtZIrphHjoRKXrd1NokwmMKP9Wy45NZJwwSnDIk9M34Hmgtaz2OzQzM3+3CgXmMxaQ
 ntPXL2min4yy+SsExEqBllBsNoIvCNKFMgvzrA3EDZn//ERDTnPhfr3sA4AFMw==
To: Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>
Cc: Balamanikandan Gunasundar <balamanikandan.gunasundar@microchip.com>,
 Eugen Hristev <eugen.hristev@collabora.com>,
 Mihai Sain <mihai.sain@microchip.com>, Li Bin <bin.li@microchip.com>,
 u-boot@lists.denx.de
Subject: [PATCH v2 4/6] mtd: nand: raw: atmel: Introduce optional debug
 commands
Date: Wed, 20 Mar 2024 10:02:12 +0100
Message-Id: <20240320090214.40465-5-ada@thorsis.com>
In-Reply-To: <20240320090214.40465-1-ada@thorsis.com>
References: <20240320090214.40465-1-ada@thorsis.com>
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

For now adds one new command 'hsmc' with a single subcommand 'decode' to
read and display the content of the registers of the Static Memory
Controllers (SMC/HSMC) found in different at91 SoCs.  Needed to get a
better picture on what raw nand core and atmel nand controller driver
try to set as timings based on ONFI parameters of the connected NAND
chip.

Tested on SAMA5D2 and SAM9X60 based boards.  Example output:

    U-Boot> hsmc decode

    MCK rate: 200 MHz

    SMC_SETUP3:     0x00000002
    SMC_PULSE3:     0x06030703
    SMC_CYCLE3:     0x00060007
    SMC_MODE3:      0x001f0003
    NCS_RD: setup: 0 (0 ns), pulse: 6 (30 ns), hold: 0 (0 ns), cycle: 6 (30 ns)
       NRD: setup: 0 (0 ns), pulse: 3 (15 ns), hold: 3 (15 ns), cycle: 6 (30 ns)
    NCS_WR: setup: 0 (0 ns), pulse: 7 (35 ns), hold: 0 (0 ns), cycle: 7 (35 ns)
       NWE: setup: 2 (10 ns), pulse: 3 (15 ns), hold: 2 (10 ns), cycle: 7 (35 ns)
    Standard read applied
    TDF optimization enabled
    TDF cycles: 15 (75 ns)
    Data Bus Width: 8-bit bus
    NWAIT Mode: 0
    Write operation controlled by NWE signal
    Read operation controlled by NRD signal

Signed-off-by: Alexander Dahl <ada@thorsis.com>
Tested-by: Mihai Sain <mihai.sain@microchip.com>
---

Notes:
    v1:
    - initial patch version
    
    v2:
    - Use SMC register definitions
    - Implement atmel_hsmc_print_timings()
    - Improve hsmc command output
    - Collected tags

 drivers/mtd/nand/raw/Kconfig                 |   9 +
 drivers/mtd/nand/raw/atmel/nand-controller.c | 295 +++++++++++++++++++
 2 files changed, 304 insertions(+)

diff --git a/drivers/mtd/nand/raw/Kconfig b/drivers/mtd/nand/raw/Kconfig
index f6644899b0a..43057aa6c5b 100644
--- a/drivers/mtd/nand/raw/Kconfig
+++ b/drivers/mtd/nand/raw/Kconfig
@@ -50,12 +50,21 @@ config SYS_NAND_NO_SUBPAGE_WRITE
 
 config DM_NAND_ATMEL
 	bool "Support Atmel NAND controller with DM support"
+	select MFD_ATMEL_SMC
 	select SYS_NAND_SELF_INIT
 	imply SYS_NAND_USE_FLASH_BBT
 	help
 	  Enable this driver for NAND flash platforms using an Atmel NAND
 	  controller.
 
+config CMD_NAND_ATMEL_DEBUG
+	bool "Optional debug commands for Atmel NAND controller"
+	depends on DM_NAND_ATMEL
+	help
+	  Add commands for debugging internals of the Atmel NAND flash
+	  controller, for example:
+	  - Decode Static Memory Controller (SMC) registers
+
 config NAND_ATMEL
 	bool "Support Atmel NAND controller"
 	select SYS_NAND_SELF_INIT
diff --git a/drivers/mtd/nand/raw/atmel/nand-controller.c b/drivers/mtd/nand/raw/atmel/nand-controller.c
index e06523f3298..75da15c157b 100644
--- a/drivers/mtd/nand/raw/atmel/nand-controller.c
+++ b/drivers/mtd/nand/raw/atmel/nand-controller.c
@@ -51,11 +51,13 @@
 
 #include <asm-generic/gpio.h>
 #include <clk.h>
+#include <command.h>
 #include <dm/device_compat.h>
 #include <dm/devres.h>
 #include <dm/of_addr.h>
 #include <dm/of_access.h>
 #include <dm/uclass.h>
+#include <linux/bitops.h>
 #include <linux/completion.h>
 #include <linux/io.h>
 #include <linux/iopoll.h>
@@ -69,6 +71,7 @@
 #include <nand.h>
 #include <regmap.h>
 #include <syscon.h>
+#include <vsprintf.h>
 
 #include "pmecc.h"
 
@@ -216,6 +219,7 @@ struct atmel_nand_controller_ops {
 	int (*ecc_init)(struct nand_chip *chip);
 	int (*setup_data_interface)(struct atmel_nand *nand, int csline,
 				    const struct nand_data_interface *conf);
+	void (*print_info)(struct atmel_nand *nand, int csline);
 };
 
 struct atmel_nand_controller_caps {
@@ -2041,12 +2045,260 @@ err:
 	return ret;
 }
 
+#ifdef CONFIG_CMD_NAND_ATMEL_DEBUG
+u32 atmel_smc_decode_ncycles(u32 reg, u32 shift, u32 msbpos, u32 msbwidth, u32 msbfactor)
+{
+	/*
+	 *	Examples:
+	 *
+	 *	NRD setup length = (128 * NRD_SETUP[5] + NRD_SETUP[4:0]) clock cycles.
+	 *	NRD pulse length = (256 * NRD_PULSE[6] + NRD_PULSE[5:0]) clock cycles.
+	 *	Read cycle length = (NRD_CYCLE[8:7] * 256) + NRD_CYCLE[6:0] clock cycles.
+	 */
+
+	reg >>= shift;
+
+	u32 lsbmask = GENMASK(msbpos - 1, 0);
+	u32 msbmask = GENMASK(msbwidth - 1, 0) << msbpos;
+	u32 msb = (reg & msbmask) >> msbpos;
+	u32 lsb = (reg & lsbmask);
+
+	return msb * msbfactor + lsb;
+}
+
+static void atmel_smc_cs_conf_print_raw(struct atmel_smc_cs_conf *conf, int cs)
+{
+	printf("SMC_SETUP%d:     0x%08x\n", cs, conf->setup);
+	printf("SMC_PULSE%d:     0x%08x\n", cs, conf->pulse);
+	printf("SMC_CYCLE%d:     0x%08x\n", cs, conf->cycle);
+	printf("SMC_MODE%d:      0x%08x\n", cs, conf->mode);
+}
+
+static void atmel_hsmc_cs_conf_print_raw(struct atmel_smc_cs_conf *conf, int cs)
+{
+	printf("HSMC_SETUP%d:    0x%08x\n", cs, conf->setup);
+	printf("HSMC_PULSE%d:    0x%08x\n", cs, conf->pulse);
+	printf("HSMC_CYCLE%d:    0x%08x\n", cs, conf->cycle);
+	printf("HSMC_TIMINGS%d:  0x%08x\n", cs, conf->timings);
+	printf("HSMC_MODE%d:     0x%08x\n", cs, conf->mode);
+}
+
+static void atmel_smc_print_reg(const char *name, u32 setup, u32 pulse,
+				u32 cycle, u32 clk_period_ns)
+{
+	u32 hold = cycle - pulse - setup;
+
+	printf("%6s: setup: %u (%u ns), pulse: %u (%u ns), hold: %u (%u ns), cycle: %u (%u ns)\n",
+	       name, setup, setup * clk_period_ns, pulse, pulse * clk_period_ns,
+	       hold, hold * clk_period_ns, cycle, cycle * clk_period_ns);
+}
+
+static void atmel_smc_print_ncs_rd(struct atmel_smc_cs_conf *conf, u32 clk_period_ns)
+{
+	u32 ncs_rd_setup = atmel_smc_decode_ncycles(conf->setup,
+						    ATMEL_SMC_NCS_RD_SHIFT,
+						    5, 1, 128);
+	u32 ncs_rd_pulse = atmel_smc_decode_ncycles(conf->pulse,
+						    ATMEL_SMC_NCS_RD_SHIFT,
+						    6, 1, 256);
+	u32 nrd_cycle = atmel_smc_decode_ncycles(conf->cycle, 16, 7, 2, 256);
+
+	atmel_smc_print_reg("NCS_RD", ncs_rd_setup, ncs_rd_pulse,
+			    nrd_cycle, clk_period_ns);
+}
+
+static void atmel_smc_print_nrd(struct atmel_smc_cs_conf *conf, u32 clk_period_ns)
+{
+	u32 nrd_setup = atmel_smc_decode_ncycles(conf->setup,
+						 ATMEL_SMC_NRD_SHIFT,
+						 5, 1, 128);
+	u32 nrd_pulse = atmel_smc_decode_ncycles(conf->pulse,
+						 ATMEL_SMC_NRD_SHIFT,
+						 6, 1, 256);
+	u32 nrd_cycle = atmel_smc_decode_ncycles(conf->cycle, 16, 7, 2, 256);
+
+	atmel_smc_print_reg("NRD", nrd_setup, nrd_pulse, nrd_cycle, clk_period_ns);
+}
+
+static void atmel_smc_print_ncs_wr(struct atmel_smc_cs_conf *conf, u32 clk_period_ns)
+{
+	u32 ncs_wr_setup = atmel_smc_decode_ncycles(conf->setup,
+						    ATMEL_SMC_NCS_WR_SHIFT,
+						    5, 1, 128);
+	u32 ncs_wr_pulse = atmel_smc_decode_ncycles(conf->pulse,
+						    ATMEL_SMC_NCS_WR_SHIFT,
+						    6, 1, 256);
+	u32 nwe_cycle = atmel_smc_decode_ncycles(conf->cycle, 0, 7, 2, 256);
+
+	atmel_smc_print_reg("NCS_WR", ncs_wr_setup, ncs_wr_pulse,
+			    nwe_cycle, clk_period_ns);
+}
+
+static void atmel_smc_print_nwe(struct atmel_smc_cs_conf *conf, u32 clk_period_ns)
+{
+	u32 nwe_setup = atmel_smc_decode_ncycles(conf->setup,
+						 ATMEL_SMC_NWE_SHIFT,
+						 5, 1, 128);
+	u32 nwe_pulse = atmel_smc_decode_ncycles(conf->pulse,
+						 ATMEL_SMC_NWE_SHIFT,
+						 6, 1, 256);
+	u32 nwe_cycle = atmel_smc_decode_ncycles(conf->cycle, 0, 7, 2, 256);
+
+	atmel_smc_print_reg("NWE", nwe_setup, nwe_pulse, nwe_cycle, clk_period_ns);
+}
+
+static void atmel_smc_print_mode(struct atmel_smc_cs_conf *conf, u32 clk_period_ns)
+{
+	u32 tdf;
+	u8 dbw;
+
+	if (conf->mode & BIT(24)) {
+		printf("Asynchronous burst read in Page mode applied on the corresponding chip select\n");
+		printf("Page Size: %u-byte page\n",
+		       4 << ((conf->mode & GENMASK(29, 28)) >> 28));
+	} else {
+		printf("Standard read applied\n");
+	}
+
+	tdf = (conf->mode & GENMASK(19, 16)) >> 16;
+	printf("TDF optimization %s\n",
+	       (conf->mode & BIT(20)) ? "enabled" : "disabled");
+	printf("TDF cycles: %u (%u ns)\n", tdf, tdf * clk_period_ns);
+
+	dbw = 8 << ((conf->mode & GENMASK(13, 12)) >> 12);
+	printf("Data Bus Width: %u-bit bus\n", dbw);
+	if (dbw > 8)
+		printf("Byte %s access type\n",
+		       (conf->mode & BIT(8)) ? "write" : "select");
+
+	printf("NWAIT Mode: %lu\n", (conf->mode & GENMASK(5, 4)) >> 4);
+	printf("Write operation controlled by %s signal\n",
+	       (conf->mode & BIT(1)) ? "NWE" : "NCS");
+	printf("Read operation controlled by %s signal\n",
+	       (conf->mode & BIT(0)) ? "NRD" : "NCS");
+}
+
+static void atmel_hsmc_print_mode(struct atmel_smc_cs_conf *conf, u32 clk_period_ns)
+{
+	u32 tdf;
+	u8 dbw;
+
+	tdf = (conf->mode & GENMASK(19, 16)) >> 16;
+	printf("TDF optimization %s\n",
+	       (conf->mode & BIT(20)) ? "enabled" : "disabled");
+	printf("TDF cycles: %u (%u ns)\n", tdf, tdf * clk_period_ns);
+
+	dbw = 8 << ((conf->mode & BIT(12)) >> 12);
+	printf("Data Bus Width: %u-bit bus\n", dbw);
+	if (dbw > 8)
+		printf("Byte %s access type\n",
+		       (conf->mode & BIT(8)) ? "write" : "select");
+
+	printf("NWAIT Mode: %lu\n", (conf->mode & GENMASK(5, 4)) >> 4);
+	printf("Write operation controlled by %s signal\n",
+	       (conf->mode & BIT(1)) ? "NWE" : "NCS");
+	printf("Read operation controlled by %s signal\n",
+	       (conf->mode & BIT(0)) ? "NRD" : "NCS");
+}
+
+static void atmel_hsmc_print_timings(struct atmel_smc_cs_conf *conf, u32 clk_period_ns)
+{
+	u32 twb = atmel_smc_decode_ncycles(conf->timings,
+					   ATMEL_HSMC_TIMINGS_TWB_SHIFT,
+					   3, 1, 64);
+	u32 trr = atmel_smc_decode_ncycles(conf->timings,
+					   ATMEL_HSMC_TIMINGS_TRR_SHIFT,
+					   3, 1, 64);
+	u32 tar = atmel_smc_decode_ncycles(conf->timings,
+					   ATMEL_HSMC_TIMINGS_TAR_SHIFT,
+					   3, 1, 64);
+	u32 tadl = atmel_smc_decode_ncycles(conf->timings,
+					    ATMEL_HSMC_TIMINGS_TADL_SHIFT,
+					    3, 1, 64);
+	u32 tclr = atmel_smc_decode_ncycles(conf->timings,
+					    ATMEL_HSMC_TIMINGS_TCLR_SHIFT,
+					    3, 1, 64);
+
+	printf("NFSEL (NAND Flash Selection) is %s\n",
+	       conf->timings & ATMEL_HSMC_TIMINGS_NFSEL ? "set" : "cleared");
+	printf("OCMS (Off Chip Memory Scrambling) is %s\n",
+	       conf->timings & ATMEL_HSMC_TIMINGS_OCMS ? "enabled" : "disabled");
+
+	printf("TWB (WEN High to REN to Busy): %u (%u ns)\n",
+	       twb, twb * clk_period_ns);
+	printf("TRR (Ready to REN Low Delay):  %u (%u ns)\n",
+	       trr, trr * clk_period_ns);
+	printf("TAR (ALE to REN Low Delay):    %u (%u ns)\n",
+	       tar, tar * clk_period_ns);
+	printf("TADL (ALE to Data Start):      %u (%u ns)\n",
+	       tadl, tadl * clk_period_ns);
+	printf("TCLR (CLE to REN Low Delay):   %u (%u ns)\n",
+	       tclr, tclr * clk_period_ns);
+}
+
+static void atmel_smc_print_info(struct atmel_nand *nand, int csline)
+{
+	struct atmel_nand_controller *nc;
+	struct atmel_smc_cs_conf smcconf;
+	struct atmel_nand_cs *cs;
+	u32 mck_period_ns;
+
+	nc = to_nand_controller(nand->controller);
+	cs = &nand->cs[csline];
+
+	atmel_smc_cs_conf_init(&smcconf);
+	atmel_smc_cs_conf_get(nc->smc, cs->id, &smcconf);
+
+	atmel_smc_cs_conf_print_raw(&smcconf, cs->id);
+
+	mck_period_ns = NSEC_PER_SEC / clk_get_rate(nc->mck);
+
+	atmel_smc_print_ncs_rd(&smcconf, mck_period_ns);
+	atmel_smc_print_nrd(&smcconf, mck_period_ns);
+	atmel_smc_print_ncs_wr(&smcconf, mck_period_ns);
+	atmel_smc_print_nwe(&smcconf, mck_period_ns);
+
+	atmel_smc_print_mode(&smcconf, mck_period_ns);
+}
+
+static void atmel_hsmc_print_info(struct atmel_nand *nand, int csline)
+{
+	struct atmel_hsmc_nand_controller *hsmc_nc;
+	struct atmel_nand_controller *nc;
+	struct atmel_smc_cs_conf smcconf;
+	struct atmel_nand_cs *cs;
+	u32 mck_period_ns;
+
+	nc = to_nand_controller(nand->controller);
+	hsmc_nc = to_hsmc_nand_controller(nand->controller);
+	cs = &nand->cs[csline];
+
+	atmel_smc_cs_conf_init(&smcconf);
+	atmel_hsmc_cs_conf_get(nc->smc, hsmc_nc->hsmc_layout, cs->id, &smcconf);
+
+	atmel_hsmc_cs_conf_print_raw(&smcconf, cs->id);
+
+	mck_period_ns = NSEC_PER_SEC / clk_get_rate(nc->mck);
+
+	atmel_smc_print_ncs_rd(&smcconf, mck_period_ns);
+	atmel_smc_print_nrd(&smcconf, mck_period_ns);
+	atmel_smc_print_ncs_wr(&smcconf, mck_period_ns);
+	atmel_smc_print_nwe(&smcconf, mck_period_ns);
+
+	atmel_hsmc_print_mode(&smcconf, mck_period_ns);
+	atmel_hsmc_print_timings(&smcconf, mck_period_ns);
+}
+#endif
+
 static const struct atmel_nand_controller_ops atmel_hsmc_nc_ops = {
 	.probe = atmel_hsmc_nand_controller_probe,
 	.remove = atmel_hsmc_nand_controller_remove,
 	.ecc_init = atmel_hsmc_nand_ecc_init,
 	.nand_init = atmel_hsmc_nand_init,
 	.setup_data_interface = atmel_hsmc_nand_setup_data_interface,
+#ifdef CONFIG_CMD_NAND_ATMEL_DEBUG
+	.print_info = atmel_hsmc_print_info,
+#endif
 };
 
 static const struct atmel_nand_controller_caps atmel_sama5_nc_caps = {
@@ -2117,6 +2369,9 @@ static const struct atmel_nand_controller_ops atmel_smc_nc_ops = {
 	.ecc_init = atmel_nand_ecc_init,
 	.nand_init = atmel_smc_nand_init,
 	.setup_data_interface = atmel_smc_nand_setup_data_interface,
+#ifdef CONFIG_CMD_NAND_ATMEL_DEBUG
+	.print_info = atmel_smc_print_info,
+#endif
 };
 
 static const struct atmel_nand_controller_caps atmel_sam9260_nc_caps = {
@@ -2247,3 +2502,43 @@ void board_nand_init(void)
 		printf("Failed to initialize NAND controller. (error %d)\n",
 		       ret);
 }
+
+#ifdef CONFIG_CMD_NAND_ATMEL_DEBUG
+static int do_hsmc_decode(struct cmd_tbl *cmdtp, int flag,
+			  int argc, char * const argv[])
+{
+	struct atmel_nand_controller *nc;
+	struct atmel_nand *nand;
+	struct nand_chip *chip;
+	struct mtd_info *mtd;
+	int i, j;
+
+	for (i = 0; i < CONFIG_SYS_MAX_NAND_DEVICE; i++) {
+		putc('\n');
+		mtd = get_nand_dev_by_index(i);
+		if (!mtd)
+			continue;
+
+		chip = mtd_to_nand(mtd);
+		nand = to_atmel_nand(chip);
+		nc = to_nand_controller(nand->controller);
+		printf("MCK rate: %lu MHz\n", clk_get_rate(nc->mck) / 1000000);
+		if (!nc->caps->ops->print_info)
+			continue;
+
+		for (j = 0; j < nand->numcs; j++) {
+			putc('\n');
+			nc->caps->ops->print_info(nand, j);
+		}
+	}
+
+	return CMD_RET_SUCCESS;
+}
+
+static char hsmc_help_text[] =
+	"decode - Decode SMC registers\n"
+	;
+
+U_BOOT_CMD_WITH_SUBCMDS(hsmc, "Atmel Static Memory Controller (SMC) debugging", hsmc_help_text,
+			U_BOOT_SUBCMD_MKENT(decode, 1, 1, do_hsmc_decode));
+#endif
-- 
2.39.2

