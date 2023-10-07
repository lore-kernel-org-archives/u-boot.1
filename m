Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D17DE95A62
	for <u-boot@archiver.kernel.org>; Sat,  7 Oct 2023 19:13:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3BF5F86D61;
	Sat,  7 Oct 2023 21:13:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="UGA4/M2S";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2E78886CDB; Sat,  7 Oct 2023 21:13:21 +0200 (CEST)
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com
 [IPv6:2607:f8b0:4864:20::1134])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AB07286B68
 for <u-boot@lists.denx.de>; Sat,  7 Oct 2023 21:13:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1134.google.com with SMTP id
 00721157ae682-59f6441215dso39428687b3.2
 for <u-boot@lists.denx.de>; Sat, 07 Oct 2023 12:13:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1696705992; x=1697310792; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=59Y7poJPpdgip2ryKXyFfpdV9FMhvPlaWQr1vgaTufI=;
 b=UGA4/M2SXKlh7cU13EK5IhzRkg4ic0Om6A12R75u1lg3IICiYSf83GxBcROcvPOzYC
 gjIxivmFaFyHtLjA1K5yuu2S0ruj3LnxpleuebYXmnL9FARqzKQiybSsLdgHpQ31JOTQ
 9ZgisWtd0Nxs1hU9XkB0Bjr+m1GscYc5bt5MA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696705992; x=1697310792;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=59Y7poJPpdgip2ryKXyFfpdV9FMhvPlaWQr1vgaTufI=;
 b=EdbdvxNQPi1Y9GtIkUrIfDMamWsvVmcmkbzNrYIZ+WWpCn/7VxmaiBJlIFwFbnAUZa
 VKSaJYDEdEHUvGv8byYui52bPuzML/33Vcg0ivKZ+DcU2PyEXmexRhZ96oRtfa+g6oxe
 KYDWfr1nJHew5A4AX+HARbhCgZmd/Lrl4BWnTuBeq7lg1yvW5gT0hOcz0prOSf9Fo1HH
 OErN0I5guPpxXncI7KKGtmLGM8p5Yzb3K5zfE4l+iwEL82ePzLz8BHUgXQt3u10dkNYO
 yTPVWAL2dA35KkdrxJBHwmATRJ+kGBZ0NS5hXYkyY6crrSDjq6WBAOydhGC110ozaaWK
 UCrQ==
X-Gm-Message-State: AOJu0YxkmvbEYEMA0SH36gN8LK61ggvava/J5hVgFutFmip48p5Cssud
 /mwrOQGyxMH1C/ci5Yz4rGiCITH79X3XPXB8phYHaA==
X-Google-Smtp-Source: AGHT+IF91C00VMLBnkqar4FyoOOfyIKwB/Omj773PSu2vKm13wD/zoJ6dBx8yegAdns05BoHPoop5w==
X-Received: by 2002:a0d:eb0b:0:b0:59f:4ef0:b4b6 with SMTP id
 u11-20020a0deb0b000000b0059f4ef0b4b6mr12086093ywe.26.1696705991558; 
 Sat, 07 Oct 2023 12:13:11 -0700 (PDT)
Received: from bill-the-cat.lan
 (2603-6081-7b00-6400-3c47-81c9-6281-4dc8.res6.spectrum.com.
 [2603:6081:7b00:6400:3c47:81c9:6281:4dc8])
 by smtp.gmail.com with ESMTPSA id
 p63-20020a0de642000000b005704c4d3579sm2244883ywe.40.2023.10.07.12.13.10
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 07 Oct 2023 12:13:11 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH 2/2] cmd: Convert existing long help messages to the new macro
Date: Sat,  7 Oct 2023 15:13:08 -0400
Message-Id: <20231007191308.2222470-2-trini@konsulko.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231007191308.2222470-1-trini@konsulko.com>
References: <20231007191308.2222470-1-trini@konsulko.com>
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

- Generally we just drop the #ifdef CONFIG_SYS_LONGHELP and endif lines
  and use U_BOOT_LONGHELP to declare the same variable name as before
- In a few places, either rename the variable to follow convention or
  introduce the variable as it was being done inline before.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 arch/arm/mach-imx/cmd_nandbcb.c                      |  6 ++----
 board/freescale/common/ngpixis.c                     |  6 ++----
 board/work-microwave/work_92105/work_92105_display.c | 12 ++++--------
 board/xilinx/common/fru.c                            |  7 ++-----
 board/xilinx/versal/cmds.c                           |  7 ++-----
 board/xilinx/zynq/cmds.c                             |  6 ++----
 board/xilinx/zynqmp/cmds.c                           |  6 ++----
 cmd/acpi.c                                           |  6 ++----
 cmd/aes.c                                            |  6 ++----
 cmd/armffa.c                                         |  4 ++--
 cmd/axi.c                                            |  4 ++--
 cmd/bloblist.c                                       |  6 ++----
 cmd/bootcount.c                                      |  9 ++-------
 cmd/bootdev.c                                        |  6 ++----
 cmd/bootefi.c                                        |  6 ++----
 cmd/bootflow.c                                       |  9 ++++-----
 cmd/booti.c                                          |  6 ++----
 cmd/bootm.c                                          |  6 ++----
 cmd/bootmeth.c                                       |  6 ++----
 cmd/bootz.c                                          |  6 ++----
 cmd/cat.c                                            |  6 ++----
 cmd/cedit.c                                          |  6 ++----
 cmd/clk.c                                            |  6 ++----
 cmd/conitrace.c                                      |  4 +---
 cmd/cpu.c                                            |  7 ++-----
 cmd/cyclic.c                                         |  4 ++--
 cmd/dm.c                                             |  7 ++-----
 cmd/efidebug.c                                       |  6 ++----
 cmd/event.c                                          |  6 ++----
 cmd/fdt.c                                            |  6 ++----
 cmd/font.c                                           |  6 ++----
 cmd/help.c                                           |  5 ++++-
 cmd/i2c.c                                            |  6 ++----
 cmd/kaslrseed.c                                      |  6 ++----
 cmd/log.c                                            |  7 ++-----
 cmd/mp.c                                             |  6 ++----
 cmd/mtd.c                                            |  6 ++----
 cmd/mtdparts.c                                       |  6 ++----
 cmd/mux.c                                            |  4 ++--
 cmd/nand.c                                           |  6 ++----
 cmd/nvedit.c                                         |  6 ++----
 cmd/osd.c                                            |  4 ++--
 cmd/pcap.c                                           |  4 ++--
 cmd/pci.c                                            |  6 ++----
 cmd/pci_mps.c                                        |  6 ++----
 cmd/riscv/sbi.c                                      |  7 ++-----
 cmd/rng.c                                            |  6 ++----
 cmd/sandbox/exception.c                              |  5 ++---
 cmd/scp03.c                                          |  7 ++++---
 cmd/sf.c                                             |  8 +++-----
 cmd/source.c                                         |  9 ++++-----
 cmd/ti/pd.c                                          | 10 +++++-----
 cmd/vbe.c                                            |  6 ++----
 cmd/wdt.c                                            |  4 ++--
 cmd/ximg.c                                           |  6 ++----
 cmd/xxd.c                                            |  6 ++----
 test/cmd_ut.c                                        |  6 ++----
 test/fuzz/cmd_fuzz.c                                 |  7 ++-----
 58 files changed, 129 insertions(+), 230 deletions(-)

diff --git a/arch/arm/mach-imx/cmd_nandbcb.c b/arch/arm/mach-imx/cmd_nandbcb.c
index c54f52b343c7..70a213a49dd0 100644
--- a/arch/arm/mach-imx/cmd_nandbcb.c
+++ b/arch/arm/mach-imx/cmd_nandbcb.c
@@ -1561,8 +1561,7 @@ usage:
 	return CMD_RET_USAGE;
 }
 
-#ifdef CONFIG_SYS_LONGHELP
-static char nandbcb_help_text[] =
+U_BOOT_LONGHELP(nandbcb,
 	"init addr off|partition len - update 'len' bytes starting at\n"
 	"       'off|part' to memory address 'addr', skipping  bad blocks\n"
 	"nandbcb bcbonly off|partition fw1-off fw1-size [fw2-off fw2-size]\n"
@@ -1572,8 +1571,7 @@ static char nandbcb_help_text[] =
 	"       FIY, BCB isn't erased automatically, so mtd erase should\n"
 	"       be called in advance before writing new BCB:\n"
 	"           > mtd erase mx7-bcb\n"
-	"nandbcb dump off|partition - dump/verify boot structures\n";
-#endif
+	"nandbcb dump off|partition - dump/verify boot structures\n");
 
 U_BOOT_CMD(nandbcb, 7, 1, do_nandbcb,
 	   "i.MX NAND Boot Control Blocks write",
diff --git a/board/freescale/common/ngpixis.c b/board/freescale/common/ngpixis.c
index 37a6f775a057..7be1ccee6383 100644
--- a/board/freescale/common/ngpixis.c
+++ b/board/freescale/common/ngpixis.c
@@ -234,15 +234,13 @@ int pixis_reset_cmd(struct cmd_tbl *cmdtp, int flag, int argc,
 	return 0;
 }
 
-#ifdef CONFIG_SYS_LONGHELP
-static char pixis_help_text[] =
+U_BOOT_LONGHELP(pixis,
 	"- hard reset to default bank\n"
 	"pixis_reset altbank - reset to alternate bank\n"
 #ifdef DEBUG
 	"pixis_reset dump - display the PIXIS registers\n"
 #endif
-	"pixis_reset sysclk <SYSCLK_freq> - reset with SYSCLK frequency(KHz)\n";
-#endif
+	"pixis_reset sysclk <SYSCLK_freq> - reset with SYSCLK frequency(KHz)\n");
 
 U_BOOT_CMD(
 	pixis_reset, CONFIG_SYS_MAXARGS, 1, pixis_reset_cmd,
diff --git a/board/work-microwave/work_92105/work_92105_display.c b/board/work-microwave/work_92105/work_92105_display.c
index 5f625e6f52ad..64dd5d4072a6 100644
--- a/board/work-microwave/work_92105/work_92105_display.c
+++ b/board/work-microwave/work_92105/work_92105_display.c
@@ -293,12 +293,10 @@ static int do_max6957aax(struct cmd_tbl *cmdtp, int flag, int argc,
 	return 1;
 }
 
-#ifdef CONFIG_SYS_LONGHELP
-static char max6957aax_help_text[] =
+U_BOOT_LONGHELP(max6957aax,
 	"max6957aax - write or read display register:\n"
 		"\tmax6957aax R|r reg - read display register;\n"
-		"\tmax6957aax reg val - write display register.";
-#endif
+		"\tmax6957aax reg val - write display register.");
 
 U_BOOT_CMD(
 	max6957aax, 6, 1, do_max6957aax,
@@ -337,13 +335,11 @@ static int do_hd44780(struct cmd_tbl *cmdtp, int flag, int argc,
 	return 0;
 }
 
-#ifdef CONFIG_SYS_LONGHELP
-static char hd44780_help_text[] =
+U_BOOT_LONGHELP(hd44780,
 	"hd44780 - control LCD driver:\n"
 		"\thd44780 cmd <val> - send command <val> to driver;\n"
 		"\thd44780 data <val> - send data <val> to driver;\n"
-		"\thd44780 str \"<text>\" - send \"<text>\" to driver.";
-#endif
+		"\thd44780 str \"<text>\" - send \"<text>\" to driver.");
 
 U_BOOT_CMD(
 	hd44780, 6, 1, do_hd44780,
diff --git a/board/xilinx/common/fru.c b/board/xilinx/common/fru.c
index f6ca46c3cecc..c916c3d6b4c8 100644
--- a/board/xilinx/common/fru.c
+++ b/board/xilinx/common/fru.c
@@ -72,17 +72,14 @@ static int do_fru(struct cmd_tbl *cmdtp, int flag, int argc,
 }
 
 /***************************************************/
-#ifdef CONFIG_SYS_LONGHELP
-static char fru_help_text[] =
+U_BOOT_LONGHELP(fru,
 	"capture <addr> - Parse and capture FRU table present at address.\n"
 	"fru display - Displays content of FRU table that was captured using\n"
 	"              fru capture command\n"
 	"fru board_gen <addr> <manufacturer> <board name> <serial number>\n"
 	"              <part number> <revision> - Generate FRU format with\n"
 	"              board info area filled based on parameters. <addr> is\n"
-	"              pointing to place where FRU is generated.\n"
-	;
-#endif
+	"              pointing to place where FRU is generated.\n");
 
 U_BOOT_CMD(
 	fru, 8, 1, do_fru,
diff --git a/board/xilinx/versal/cmds.c b/board/xilinx/versal/cmds.c
index 148fa51266d2..9cc2cdcebf1c 100644
--- a/board/xilinx/versal/cmds.c
+++ b/board/xilinx/versal/cmds.c
@@ -91,12 +91,9 @@ static int do_versal(struct cmd_tbl *cmdtp, int flag, int argc,
 	return cmd_process_error(c, ret);
 }
 
-#ifdef CONFIG_SYS_LONGHELP
-static char versal_help_text[] =
+U_BOOT_LONGHELP(versal,
 	"loadpdi addr len - Load pdi image\n"
-	"load pdi image at ddr address 'addr' with pdi image size 'len'\n"
-;
-#endif
+	"load pdi image at ddr address 'addr' with pdi image size 'len'\n");
 
 U_BOOT_CMD(versal, 4, 1, do_versal,
 	   "versal sub-system",
diff --git a/board/xilinx/zynq/cmds.c b/board/xilinx/zynq/cmds.c
index 024fac65f304..d7c7b2f22955 100644
--- a/board/xilinx/zynq/cmds.c
+++ b/board/xilinx/zynq/cmds.c
@@ -527,8 +527,7 @@ static int do_zynq(struct cmd_tbl *cmdtp, int flag, int argc,
 	return cmd_process_error(zynq_cmd, ret);
 }
 
-#ifdef CONFIG_SYS_LONGHELP
-static char zynq_help_text[] =
+U_BOOT_LONGHELP(zynq,
 	""
 #ifdef CONFIG_CMD_ZYNQ_RSA
 	"rsa <baseaddr>  - Verifies the authenticated and encrypted\n"
@@ -545,8 +544,7 @@ static char zynq_help_text[] =
 	"       if operation type is load or loadp, it loads the encrypted\n"
 	"       full or partial bitstream on to PL respectively.\n"
 #endif
-	;
-#endif
+	);
 
 U_BOOT_CMD(zynq,	6,	0,	do_zynq,
 	   "Zynq specific commands", zynq_help_text
diff --git a/board/xilinx/zynqmp/cmds.c b/board/xilinx/zynqmp/cmds.c
index fadb0edb24fb..f1f3eff501e1 100644
--- a/board/xilinx/zynqmp/cmds.c
+++ b/board/xilinx/zynqmp/cmds.c
@@ -381,8 +381,7 @@ static int do_zynqmp(struct cmd_tbl *cmdtp, int flag, int argc,
 }
 
 /***************************************************/
-#ifdef CONFIG_SYS_LONGHELP
-static char zynqmp_help_text[] =
+U_BOOT_LONGHELP(zynqmp,
 	"secure src len [key_addr] - verifies secure images of $len bytes\n"
 	"                            long at address $src. Optional key_addr\n"
 	"                            can be specified if user key needs to\n"
@@ -422,8 +421,7 @@ static char zynqmp_help_text[] =
 	"	48 bytes hash value into srcaddr\n"
 	"	Optional key_addr can be specified for saving sha3 hash value\n"
 	"	Note: srcaddr/srclen should not be 0\n"
-	;
-#endif
+	);
 
 U_BOOT_CMD(
 	zynqmp, 9, 1, do_zynqmp,
diff --git a/cmd/acpi.c b/cmd/acpi.c
index ede9c8c7dcb4..7e397d1a74e1 100644
--- a/cmd/acpi.c
+++ b/cmd/acpi.c
@@ -171,13 +171,11 @@ static int do_acpi_dump(struct cmd_tbl *cmdtp, int flag, int argc,
 	return 0;
 }
 
-#ifdef CONFIG_SYS_LONGHELP
-static char acpi_help_text[] =
+U_BOOT_LONGHELP(acpi,
 	"list  - list ACPI tables\n"
 	"acpi items [-d]   - List/dump each piece of ACPI data from devices\n"
 	"acpi set [<addr>] - Set or show address of ACPI tables\n"
-	"acpi dump <name>  - Dump ACPI table";
-#endif
+	"acpi dump <name>  - Dump ACPI table");
 
 U_BOOT_CMD_WITH_SUBCMDS(acpi, "ACPI tables", acpi_help_text,
 	U_BOOT_SUBCMD_MKENT(list, 1, 1, do_acpi_list),
diff --git a/cmd/aes.c b/cmd/aes.c
index 1936518824a1..1264675aa01f 100644
--- a/cmd/aes.c
+++ b/cmd/aes.c
@@ -88,8 +88,7 @@ static int do_aes(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 }
 
 /***************************************************/
-#ifdef CONFIG_SYS_LONGHELP
-static char aes_help_text[] =
+U_BOOT_LONGHELP(aes,
 	"[.128,.192,.256] enc key iv src dst len - Encrypt block of data $len bytes long\n"
 	"                             at address $src using a key at address\n"
 	"                             $key with initialization vector at address\n"
@@ -101,8 +100,7 @@ static char aes_help_text[] =
 	"                             $key with initialization vector at address\n"
 	"                             $iv. Store the result at address $dst.\n"
 	"                             The $len size must be multiple of 16 bytes.\n"
-	"                             The $key and $iv must be 16 bytes long.";
-#endif
+	"                             The $key and $iv must be 16 bytes long.");
 
 U_BOOT_CMD(
 	aes, 7, 1, do_aes,
diff --git a/cmd/armffa.c b/cmd/armffa.c
index 7e6eafc03ad7..9585150b9627 100644
--- a/cmd/armffa.c
+++ b/cmd/armffa.c
@@ -188,13 +188,13 @@ static int do_ffa_devlist(struct cmd_tbl *cmdtp, int flag, int argc, char *const
 	return CMD_RET_SUCCESS;
 }
 
-static char armffa_help_text[] =
+U_BOOT_LONGHELP(armffa,
 	"getpart <partition UUID>\n"
 	"       - lists the partition(s) info\n"
 	"ping <partition ID>\n"
 	"       - sends a data pattern to the specified partition\n"
 	"devlist\n"
-	"       - displays information about the FF-A device/driver\n";
+	"       - displays information about the FF-A device/driver\n");
 
 U_BOOT_CMD_WITH_SUBCMDS(armffa, "Arm FF-A test command", armffa_help_text,
 			U_BOOT_SUBCMD_MKENT(getpart, 2, 1, do_ffa_getpart),
diff --git a/cmd/axi.c b/cmd/axi.c
index b97b43eb7d01..5620891db28b 100644
--- a/cmd/axi.c
+++ b/cmd/axi.c
@@ -344,11 +344,11 @@ static int do_ihs_axi(struct cmd_tbl *cmdtp, int flag, int argc,
 		return CMD_RET_USAGE;
 }
 
-static char axi_help_text[] =
+U_BOOT_LONGHELP(axi,
 	"bus  - show AXI bus info\n"
 	"axi dev [bus] - show or set current AXI bus to bus number [bus]\n"
 	"axi md size addr [# of objects] - read from AXI device at address [addr] and data width [size] (one of 8, 16, 32)\n"
-	"axi mw size addr value [count] - write data [value] to AXI device at address [addr] and data width [size] (one of 8, 16, 32)\n";
+	"axi mw size addr value [count] - write data [value] to AXI device at address [addr] and data width [size] (one of 8, 16, 32)\n");
 
 U_BOOT_CMD(axi, 7, 1, do_ihs_axi,
 	   "AXI sub-system",
diff --git a/cmd/bloblist.c b/cmd/bloblist.c
index 21e7ff67af20..26548ecf847e 100644
--- a/cmd/bloblist.c
+++ b/cmd/bloblist.c
@@ -29,11 +29,9 @@ static int do_bloblist_list(struct cmd_tbl *cmdtp, int flag, int argc,
 	return 0;
 }
 
-#ifdef CONFIG_SYS_LONGHELP
-static char bloblist_help_text[] =
+U_BOOT_LONGHELP(bloblist,
 	"info   - show information about the bloblist\n"
-	"bloblist list   - list blobs in the bloblist";
-#endif
+	"bloblist list   - list blobs in the bloblist");
 
 U_BOOT_CMD_WITH_SUBCMDS(bloblist, "Bloblists", bloblist_help_text,
 	U_BOOT_SUBCMD_MKENT(info, 1, 1, do_bloblist_info),
diff --git a/cmd/bootcount.c b/cmd/bootcount.c
index 3898d2543d2c..30ce5dba30d9 100644
--- a/cmd/bootcount.c
+++ b/cmd/bootcount.c
@@ -46,16 +46,11 @@ static int do_bootcount(struct cmd_tbl *cmdtp, int flag, int argc,
 	return CMD_RET_USAGE;
 }
 
-#if IS_ENABLED(CONFIG_SYS_LONGHELP)
-static char bootcount_help_text[] =
+U_BOOT_LONGHELP(bootcount,
 	"print - print current bootcounter\n"
-	"reset - reset the bootcounter"
-	;
-#endif
+	"reset - reset the bootcounter");
 
 U_BOOT_CMD(bootcount, 2, 1, do_bootcount,
 	   "bootcount",
-#if IS_ENABLED(CONFIG_SYS_LONGHELP)
 	   bootcount_help_text
-#endif
 );
diff --git a/cmd/bootdev.c b/cmd/bootdev.c
index a657de6bd0f6..471189cda480 100644
--- a/cmd/bootdev.c
+++ b/cmd/bootdev.c
@@ -139,13 +139,11 @@ static int do_bootdev_hunt(struct cmd_tbl *cmdtp, int flag, int argc,
 	return 0;
 }
 
-#ifdef CONFIG_SYS_LONGHELP
-static char bootdev_help_text[] =
+U_BOOT_LONGHELP(bootdev,
 	"list [-p]         - list all available bootdevs (-p to probe)\n"
 	"bootdev hunt [-l|<spec>]  - use hunt drivers to find bootdevs\n"
 	"bootdev select <bd>       - select a bootdev by name | label | seq\n"
-	"bootdev info [-p]         - show information about a bootdev (-p to probe)";
-#endif
+	"bootdev info [-p]         - show information about a bootdev (-p to probe)");
 
 U_BOOT_CMD_WITH_SUBCMDS(bootdev, "Boot devices", bootdev_help_text,
 	U_BOOT_SUBCMD_MKENT(list, 2, 1, do_bootdev_list),
diff --git a/cmd/bootefi.c b/cmd/bootefi.c
index f73d6eb0e2d8..20e5c94a33a4 100644
--- a/cmd/bootefi.c
+++ b/cmd/bootefi.c
@@ -698,8 +698,7 @@ static int do_bootefi(struct cmd_tbl *cmdtp, int flag, int argc,
 	return ret;
 }
 
-#ifdef CONFIG_SYS_LONGHELP
-static char bootefi_help_text[] =
+U_BOOT_LONGHELP(bootefi,
 	"<image address>[:<image size>] [<fdt address>]\n"
 	"  - boot EFI payload\n"
 #ifdef CONFIG_CMD_BOOTEFI_HELLO
@@ -719,8 +718,7 @@ static char bootefi_help_text[] =
 	"    If specified, the device tree located at <fdt address> gets\n"
 	"    exposed as EFI configuration table.\n"
 #endif
-	;
-#endif
+	);
 
 U_BOOT_CMD(
 	bootefi, 4, 0, do_bootefi,
diff --git a/cmd/bootflow.c b/cmd/bootflow.c
index 300ad3aaa760..ad39ebe4379f 100644
--- a/cmd/bootflow.c
+++ b/cmd/bootflow.c
@@ -541,8 +541,7 @@ static int do_bootflow_cmdline(struct cmd_tbl *cmdtp, int flag, int argc,
 }
 #endif /* CONFIG_CMD_BOOTFLOW_FULL */
 
-#ifdef CONFIG_SYS_LONGHELP
-static char bootflow_help_text[] =
+U_BOOT_LONGHELP(bootflow,
 #ifdef CONFIG_CMD_BOOTFLOW_FULL
 	"scan [-abeGl] [bdev]  - scan for valid bootflows (-l list, -a all, -e errors, -b boot, -G no global)\n"
 	"bootflow list [-e]             - list scanned bootflows (-e errors)\n"
@@ -551,11 +550,11 @@ static char bootflow_help_text[] =
 	"bootflow read                  - read all current-bootflow files\n"
 	"bootflow boot                  - boot current bootflow\n"
 	"bootflow menu [-t]             - show a menu of available bootflows\n"
-	"bootflow cmdline [set|get|clear|delete|auto] <param> [<value>] - update cmdline";
+	"bootflow cmdline [set|get|clear|delete|auto] <param> [<value>] - update cmdline"
 #else
-	"scan - boot first available bootflow\n";
+	"scan - boot first available bootflow\n"
 #endif
-#endif /* CONFIG_SYS_LONGHELP */
+	);
 
 U_BOOT_CMD_WITH_SUBCMDS(bootflow, "Boot flows", bootflow_help_text,
 	U_BOOT_SUBCMD_MKENT(scan, 3, 1, do_bootflow_scan),
diff --git a/cmd/booti.c b/cmd/booti.c
index 6ac39193db80..1d531bdd0658 100644
--- a/cmd/booti.c
+++ b/cmd/booti.c
@@ -134,8 +134,7 @@ int do_booti(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 	return ret;
 }
 
-#ifdef CONFIG_SYS_LONGHELP
-static char booti_help_text[] =
+U_BOOT_LONGHELP(booti,
 	"[addr [initrd[:size]] [fdt]]\n"
 	"    - boot Linux flat or compressed 'Image' stored at 'addr'\n"
 	"\tThe argument 'initrd' is optional and specifies the address\n"
@@ -151,8 +150,7 @@ static char booti_help_text[] =
 	"\tis required. To boot a kernel with a device-tree blob but\n"
 	"\twithout an initrd image, use a '-' for the initrd argument.\n"
 #endif
-	"";
-#endif
+	);
 
 U_BOOT_CMD(
 	booti,	CONFIG_SYS_MAXARGS,	1,	do_booti,
diff --git a/cmd/bootm.c b/cmd/bootm.c
index 7968415b6d1e..3e504ccfe811 100644
--- a/cmd/bootm.c
+++ b/cmd/bootm.c
@@ -168,8 +168,7 @@ int bootm_maybe_autostart(struct cmd_tbl *cmdtp, const char *cmd)
 	return 0;
 }
 
-#ifdef CONFIG_SYS_LONGHELP
-static char bootm_help_text[] =
+U_BOOT_LONGHELP(bootm,
 	"[addr [arg ...]]\n    - boot application image stored in memory\n"
 	"\tpassing arguments 'arg ...'; when booting a Linux kernel,\n"
 	"\t'arg' can be the address of an initrd image\n"
@@ -208,8 +207,7 @@ static char bootm_help_text[] =
 #if defined(CONFIG_TRACE)
 	"\tfake    - OS specific fake start without go\n"
 #endif
-	"\tgo      - start OS";
-#endif
+	"\tgo      - start OS");
 
 U_BOOT_CMD(
 	bootm,	CONFIG_SYS_MAXARGS,	1,	do_bootm,
diff --git a/cmd/bootmeth.c b/cmd/bootmeth.c
index 9fbcccdba7ef..f5b01343c48c 100644
--- a/cmd/bootmeth.c
+++ b/cmd/bootmeth.c
@@ -104,11 +104,9 @@ static int do_bootmeth_order(struct cmd_tbl *cmdtp, int flag, int argc,
 	return 0;
 }
 
-#ifdef CONFIG_SYS_LONGHELP
-static char bootmeth_help_text[] =
+U_BOOT_LONGHELP(bootmeth,
 	"list [-a]     - list available bootmeths (-a all)\n"
-	"bootmeth order [<bd> ...]  - select bootmeth order / subset to use";
-#endif
+	"bootmeth order [<bd> ...]  - select bootmeth order / subset to use");
 
 U_BOOT_CMD_WITH_SUBCMDS(bootmeth, "Boot methods", bootmeth_help_text,
 	U_BOOT_SUBCMD_MKENT(list, 2, 1, do_bootmeth_list),
diff --git a/cmd/bootz.c b/cmd/bootz.c
index f1423573d23d..742889f21de7 100644
--- a/cmd/bootz.c
+++ b/cmd/bootz.c
@@ -88,8 +88,7 @@ int do_bootz(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 	return ret;
 }
 
-#ifdef CONFIG_SYS_LONGHELP
-static char bootz_help_text[] =
+U_BOOT_LONGHELP(bootz,
 	"[addr [initrd[:size]] [fdt]]\n"
 	"    - boot Linux zImage stored in memory\n"
 	"\tThe argument 'initrd' is optional and specifies the address\n"
@@ -102,8 +101,7 @@ static char bootz_help_text[] =
 	"\tuse a '-' for the second argument. If you do not pass a third\n"
 	"\ta bd_info struct will be passed instead\n"
 #endif
-	"";
-#endif
+	);
 
 U_BOOT_CMD(
 	bootz,	CONFIG_SYS_MAXARGS,	1,	do_bootz,
diff --git a/cmd/cat.c b/cmd/cat.c
index b059080193d4..18aa6ca7aa67 100644
--- a/cmd/cat.c
+++ b/cmd/cat.c
@@ -60,11 +60,9 @@ static int do_cat(struct cmd_tbl *cmdtp, int flag, int argc,
 	return 0;
 }
 
-#ifdef CONFIG_SYS_LONGHELP
-static char cat_help_text[] =
+U_BOOT_LONGHELP(cat,
 	"<interface> <dev[:part]> <file>\n"
-	"  - Print file from 'dev' on 'interface' to standard output\n";
-#endif
+	"  - Print file from 'dev' on 'interface' to standard output\n");
 
 U_BOOT_CMD(cat, 4, 1, do_cat,
 	   "Print file to standard output",
diff --git a/cmd/cedit.c b/cmd/cedit.c
index 2ff284f4cde6..6352e6369d1e 100644
--- a/cmd/cedit.c
+++ b/cmd/cedit.c
@@ -270,8 +270,7 @@ static int do_cedit_run(struct cmd_tbl *cmdtp, int flag, int argc,
 	return 0;
 }
 
-#ifdef CONFIG_SYS_LONGHELP
-static char cedit_help_text[] =
+U_BOOT_LONGHELP(cedit,
 	"load <interface> <dev[:part]> <filename>   - load config editor\n"
 	"cedit read_fdt <i/f> <dev[:part]> <filename>     - read settings\n"
 	"cedit write_fdt <i/f> <dev[:part]> <filename>    - write settings\n"
@@ -279,8 +278,7 @@ static char cedit_help_text[] =
 	"cedit write_env [-v]                             - write settings to env vars\n"
 	"cedit read_cmos [-v] [dev]                       - read settings from CMOS RAM\n"
 	"cedit write_cmos [-v] [dev]                      - write settings to CMOS RAM\n"
-	"cedit run                                        - run config editor";
-#endif /* CONFIG_SYS_LONGHELP */
+	"cedit run                                        - run config editor");
 
 U_BOOT_CMD_WITH_SUBCMDS(cedit, "Configuration editor", cedit_help_text,
 	U_BOOT_SUBCMD_MKENT(load, 5, 1, do_cedit_load),
diff --git a/cmd/clk.c b/cmd/clk.c
index ff7c7649a159..c7c379d7a617 100644
--- a/cmd/clk.c
+++ b/cmd/clk.c
@@ -152,10 +152,8 @@ static int do_clk(struct cmd_tbl *cmdtp, int flag, int argc,
 		return CMD_RET_USAGE;
 }
 
-#ifdef CONFIG_SYS_LONGHELP
-static char clk_help_text[] =
+U_BOOT_LONGHELP(clk,
 	"dump - Print clock frequencies\n"
-	"clk setfreq [clk] [freq] - Set clock frequency";
-#endif
+	"clk setfreq [clk] [freq] - Set clock frequency");
 
 U_BOOT_CMD(clk, 4, 1, do_clk, "CLK sub-system", clk_help_text);
diff --git a/cmd/conitrace.c b/cmd/conitrace.c
index d50f3bf3ccbf..9a1bc3518485 100644
--- a/cmd/conitrace.c
+++ b/cmd/conitrace.c
@@ -41,9 +41,7 @@ static int do_conitrace(struct cmd_tbl *cmdtp, int flag, int argc,
 	return CMD_RET_SUCCESS;
 }
 
-#ifdef CONFIG_SYS_LONGHELP
-static char conitrace_help_text[] = "";
-#endif
+U_BOOT_LONGHELP(conitrace, "");
 
 U_BOOT_CMD_COMPLETE(
 	conitrace, 2, 0, do_conitrace,
diff --git a/cmd/cpu.c b/cmd/cpu.c
index 314852440f1d..245a82fa3eb4 100644
--- a/cmd/cpu.c
+++ b/cmd/cpu.c
@@ -83,12 +83,9 @@ static int do_cpu_detail(struct cmd_tbl *cmdtp, int flag, int argc,
 	return 0;
 }
 
-#if IS_ENABLED(CONFIG_SYS_LONGHELP)
-static char cpu_help_text[] =
+U_BOOT_LONGHELP(cpu,
 	"list	- list available CPUs\n"
-	"cpu detail	- show CPU detail"
-	;
-#endif
+	"cpu detail	- show CPU detail");
 
 U_BOOT_CMD_WITH_SUBCMDS(cpu, "display information about CPUs", cpu_help_text,
 	U_BOOT_SUBCMD_MKENT(list, 1, 1, do_cpu_list),
diff --git a/cmd/cyclic.c b/cmd/cyclic.c
index 946f1d78184d..ad7fc3b975e1 100644
--- a/cmd/cyclic.c
+++ b/cmd/cyclic.c
@@ -76,9 +76,9 @@ static int do_cyclic_list(struct cmd_tbl *cmdtp, int flag, int argc,
 	return 0;
 }
 
-static char cyclic_help_text[] =
+U_BOOT_LONGHELP(cyclic,
 	"demo <cycletime_ms> <delay_us> - register cyclic demo function\n"
-	"cyclic list - list cyclic functions\n";
+	"cyclic list - list cyclic functions\n");
 
 U_BOOT_CMD_WITH_SUBCMDS(cyclic, "Cyclic", cyclic_help_text,
 	U_BOOT_SUBCMD_MKENT(demo, 3, 1, do_cyclic_demo),
diff --git a/cmd/dm.c b/cmd/dm.c
index 1aa86aab9c1c..fb605c2da1a8 100644
--- a/cmd/dm.c
+++ b/cmd/dm.c
@@ -112,17 +112,14 @@ static int do_dm_dump_uclass(struct cmd_tbl *cmdtp, int flag, int argc,
 #define DM_MEM
 #endif
 
-#if IS_ENABLED(CONFIG_SYS_LONGHELP)
-static char dm_help_text[] =
+U_BOOT_LONGHELP(dm,
 	"compat        Dump list of drivers with compatibility strings\n"
 	"dm devres        Dump list of device resources for each device\n"
 	"dm drivers       Dump list of drivers with uclass and instances\n"
 	DM_MEM_HELP
 	"dm static        Dump list of drivers with static platform data\n"
 	"dm tree [-s][-e][name]   Dump tree of driver model devices (-s=sort)\n"
-	"dm uclass [-e][name]     Dump list of instances for each uclass"
-	;
-#endif
+	"dm uclass [-e][name]     Dump list of instances for each uclass");
 
 U_BOOT_CMD_WITH_SUBCMDS(dm, "Driver model low level access", dm_help_text,
 	U_BOOT_SUBCMD_MKENT(compat, 1, 1, do_dm_dump_driver_compat),
diff --git a/cmd/efidebug.c b/cmd/efidebug.c
index 0be3af3e7630..201531ac19fc 100644
--- a/cmd/efidebug.c
+++ b/cmd/efidebug.c
@@ -1484,8 +1484,7 @@ static int do_efidebug(struct cmd_tbl *cmdtp, int flag,
 	return cp->cmd(cmdtp, flag, argc, argv);
 }
 
-#ifdef CONFIG_SYS_LONGHELP
-static char efidebug_help_text[] =
+U_BOOT_LONGHELP(efidebug,
 	"  - UEFI Shell-like interface to configure UEFI environment\n"
 	"\n"
 	"efidebug boot add - set UEFI BootXXXX variable\n"
@@ -1532,8 +1531,7 @@ static char efidebug_help_text[] =
 	"  - run simple bootmgr for test\n"
 #endif
 	"efidebug query [-nv][-bs][-rt][-at]\n"
-	"  - show size of UEFI variables store\n";
-#endif
+	"  - show size of UEFI variables store\n");
 
 U_BOOT_CMD(
 	efidebug, CONFIG_SYS_MAXARGS, 0, do_efidebug,
diff --git a/cmd/event.c b/cmd/event.c
index b4b779ffac00..f6cdb55fc913 100644
--- a/cmd/event.c
+++ b/cmd/event.c
@@ -18,10 +18,8 @@ static int do_event_list(struct cmd_tbl *cmdtp, int flag, int argc,
 	return 0;
 }
 
-#ifdef CONFIG_SYS_LONGHELP
-static char event_help_text[] =
-	"list - list event spies";
-#endif
+U_BOOT_LONGHELP(event,
+	"list - list event spies");
 
 U_BOOT_CMD_WITH_SUBCMDS(event, "Events", event_help_text,
 	U_BOOT_SUBCMD_MKENT(list, 1, 1, do_event_list));
diff --git a/cmd/fdt.c b/cmd/fdt.c
index 2401ea8b44cb..331564c13be9 100644
--- a/cmd/fdt.c
+++ b/cmd/fdt.c
@@ -1113,8 +1113,7 @@ static int fdt_print(const char *pathp, char *prop, int depth)
 }
 
 /********************************************************************/
-#ifdef CONFIG_SYS_LONGHELP
-static char fdt_help_text[] =
+U_BOOT_LONGHELP(fdt,
 	"addr [-c] [-q] <addr> [<size>]  - Set the [control] fdt location to <addr>\n"
 #ifdef CONFIG_OF_LIBFDT_OVERLAY
 	"fdt apply <addr>                    - Apply overlay to the DT\n"
@@ -1153,8 +1152,7 @@ static char fdt_help_text[] =
 	"                                               default gd->fdt_blob\n"
 #endif
 	"NOTE: Dereference aliases by omitting the leading '/', "
-		"e.g. fdt print ethernet0.";
-#endif
+		"e.g. fdt print ethernet0.");
 
 U_BOOT_CMD(
 	fdt,	255,	0,	do_fdt,
diff --git a/cmd/font.c b/cmd/font.c
index fe2d65caaf77..cb39c88063fb 100644
--- a/cmd/font.c
+++ b/cmd/font.c
@@ -79,12 +79,10 @@ static int do_font_size(struct cmd_tbl *cmdtp, int flag, int argc,
 }
 
 
-#ifdef CONFIG_SYS_LONGHELP
-static char font_help_text[] =
+U_BOOT_LONGHELP(font,
 	"list       - list available fonts\n"
 	"font select <name> [<size>] - select font to use\n"
-	"font size <size> - select font size to";
-#endif
+	"font size <size> - select font size to");
 
 U_BOOT_CMD_WITH_SUBCMDS(font, "Fonts", font_help_text,
 	U_BOOT_SUBCMD_MKENT(list, 1, 1, do_font_list),
diff --git a/cmd/help.c b/cmd/help.c
index 8d67d977bf1a..9f8393eefd81 100644
--- a/cmd/help.c
+++ b/cmd/help.c
@@ -29,7 +29,10 @@ U_BOOT_CMD(
 );
 
 #ifdef CONFIG_CMDLINE
-/* This does not use the U_BOOT_CMD macro as ? can't be used in symbol names */
+/*
+ * This does not use the U_BOOT_CMD macro as ? can't be used in symbol names
+ * nor can we rely on the CONFIG_SYS_LONGHELP helper macro
+ */
 ll_entry_declare(struct cmd_tbl, question_mark, cmd) = {
 	"?",	CONFIG_SYS_MAXARGS, cmd_always_repeatable,	do_help,
 	"alias for 'help'",
diff --git a/cmd/i2c.c b/cmd/i2c.c
index f0a5fa2e741f..80831561c671 100644
--- a/cmd/i2c.c
+++ b/cmd/i2c.c
@@ -1969,8 +1969,7 @@ static int do_i2c(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 }
 
 /***************************************************/
-#ifdef CONFIG_SYS_LONGHELP
-static char i2c_help_text[] =
+U_BOOT_LONGHELP(i2c,
 #if CONFIG_IS_ENABLED(SYS_I2C_LEGACY) || CONFIG_IS_ENABLED(DM_I2C)
 	"bus [muxtype:muxaddr:muxchannel] - show I2C bus info\n"
 	"i2c " /* That's the prefix for the crc32 command below. */
@@ -1999,8 +1998,7 @@ static char i2c_help_text[] =
 #if defined(CONFIG_CMD_SDRAM)
 	"i2c sdram chip - print SDRAM configuration information\n"
 #endif
-	"i2c speed [speed] - show or set I2C bus speed";
-#endif
+	"i2c speed [speed] - show or set I2C bus speed");
 
 U_BOOT_CMD(
 	i2c, 7, 1, do_i2c,
diff --git a/cmd/kaslrseed.c b/cmd/kaslrseed.c
index 8a1d8120cdcf..9acb8e163863 100644
--- a/cmd/kaslrseed.c
+++ b/cmd/kaslrseed.c
@@ -68,11 +68,9 @@ static int do_kaslr_seed(struct cmd_tbl *cmdtp, int flag, int argc, char *const
 	return ret;
 }
 
-#ifdef CONFIG_SYS_LONGHELP
-static char kaslrseed_help_text[] =
+U_BOOT_LONGHELP(kaslrseed,
 	"[n]\n"
-	"  - append random bytes to chosen kaslr-seed node\n";
-#endif
+	"  - append random bytes to chosen kaslr-seed node\n");
 
 U_BOOT_CMD(
 	kaslrseed, 1, 0, do_kaslr_seed,
diff --git a/cmd/log.c b/cmd/log.c
index c377aee85c5e..c9a23e4ae0d3 100644
--- a/cmd/log.c
+++ b/cmd/log.c
@@ -375,8 +375,7 @@ static int do_log_rec(struct cmd_tbl *cmdtp, int flag, int argc,
 	return 0;
 }
 
-#ifdef CONFIG_SYS_LONGHELP
-static char log_help_text[] =
+U_BOOT_LONGHELP(log,
 	"level [<level>] - get/set log level\n"
 	"categories - list log categories\n"
 	"drivers - list log drivers\n"
@@ -405,9 +404,7 @@ static char log_help_text[] =
 	"\tc=category, l=level, F=file, L=line number, f=function, m=msg\n"
 	"\tor 'default', or 'all' for all\n"
 	"log rec <category> <level> <file> <line> <func> <message> - "
-		"output a log record"
-	;
-#endif
+		"output a log record");
 
 U_BOOT_CMD_WITH_SUBCMDS(log, "log system", log_help_text,
 	U_BOOT_SUBCMD_MKENT(level, 2, 1, do_log_level),
diff --git a/cmd/mp.c b/cmd/mp.c
index 8d14401b4944..1b4373f25873 100644
--- a/cmd/mp.c
+++ b/cmd/mp.c
@@ -66,8 +66,7 @@ cpu_cmd(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 	return 0;
 }
 
-#ifdef CONFIG_SYS_LONGHELP
-static char cpu_help_text[] =
+U_BOOT_LONGHELP(cpu,
 	    "<num> reset                 - Reset cpu <num>\n"
 	"cpu status                      - Status of all cpus\n"
 	"cpu <num> status                - Status of cpu <num>\n"
@@ -86,8 +85,7 @@ static char cpu_help_text[] =
 	"     When cpu <num> is released r4 and r5 = 0.\n" \
 	"     r7 will contain the size of the initial mapped area"
 #endif
-	"";
-#endif
+	);
 
 U_BOOT_CMD(
 	cpu, CONFIG_SYS_MAXARGS, 1, cpu_cmd,
diff --git a/cmd/mtd.c b/cmd/mtd.c
index eb6e2d6892ff..e63c011e7910 100644
--- a/cmd/mtd.c
+++ b/cmd/mtd.c
@@ -541,8 +541,7 @@ static int mtd_name_complete(int argc, char *const argv[], char last_char,
 }
 #endif /* CONFIG_AUTO_COMPLETE */
 
-#ifdef CONFIG_SYS_LONGHELP
-static char mtd_help_text[] =
+U_BOOT_LONGHELP(mtd,
 	"- generic operations on memory technology devices\n\n"
 	"mtd list\n"
 	"mtd read[.raw][.oob]                  <name> <addr> [<off> [<size>]]\n"
@@ -563,8 +562,7 @@ static char mtd_help_text[] =
 	"\t\t* must be a multiple of a block for erase\n"
 	"\t\t* must be a multiple of a page otherwise (special case: default is a page with dump)\n"
 	"\n"
-	"The .dontskipff option forces writing empty pages, don't use it if unsure.\n";
-#endif
+	"The .dontskipff option forces writing empty pages, don't use it if unsure.\n");
 
 U_BOOT_CMD_WITH_SUBCMDS(mtd, "MTD utils", mtd_help_text,
 		U_BOOT_SUBCMD_MKENT(list, 1, 1, do_mtd_list),
diff --git a/cmd/mtdparts.c b/cmd/mtdparts.c
index 0984158f41ea..b31db73ebfc9 100644
--- a/cmd/mtdparts.c
+++ b/cmd/mtdparts.c
@@ -2079,8 +2079,7 @@ U_BOOT_CMD(
 	"    - change active partition (e.g. part-id = nand0,1) of a MTD device"
 );
 
-#ifdef CONFIG_SYS_LONGHELP
-static char mtdparts_help_text[] =
+U_BOOT_LONGHELP(mtdparts,
 	"\n"
 	"    - list partition table\n"
 	"mtdparts delall\n"
@@ -2122,8 +2121,7 @@ static char mtdparts_help_text[] =
 	"<size>     := standard linux memsize OR '-' to denote all remaining space\n"
 	"<offset>   := partition start offset within the device\n"
 	"<name>     := '(' NAME ')'\n"
-	"<ro-flag>  := when set to 'ro' makes partition read-only (not used, passed to kernel)";
-#endif
+	"<ro-flag>  := when set to 'ro' makes partition read-only (not used, passed to kernel)");
 
 U_BOOT_CMD(
 	mtdparts,	6,	0,	do_mtdparts,
diff --git a/cmd/mux.c b/cmd/mux.c
index c75907af7726..388fb0878a84 100644
--- a/cmd/mux.c
+++ b/cmd/mux.c
@@ -173,10 +173,10 @@ static int do_mux_deselect(struct cmd_tbl *cmdtp, int flag, int argc,
 	return CMD_RET_SUCCESS;
 }
 
-static char mux_help_text[] =
+U_BOOT_LONGHELP(mux,
 	"list - List all Muxes and their states\n"
 	"select <chip> <id> <state> - Select the given mux state\n"
-	"deselect <chip> <id> - Deselect the given mux and reset it to its idle state";
+	"deselect <chip> <id> - Deselect the given mux and reset it to its idle state");
 
 U_BOOT_CMD_WITH_SUBCMDS(mux, "List, select, and deselect muxes", mux_help_text,
 			U_BOOT_SUBCMD_MKENT(list, 1, 1, do_mux_list),
diff --git a/cmd/nand.c b/cmd/nand.c
index b41e54ec4229..71b8f9644296 100644
--- a/cmd/nand.c
+++ b/cmd/nand.c
@@ -919,8 +919,7 @@ usage:
 	return CMD_RET_USAGE;
 }
 
-#ifdef CONFIG_SYS_LONGHELP
-static char nand_help_text[] =
+U_BOOT_LONGHELP(nand,
 	"info - show available NAND devices\n"
 	"nand device [dev] - show or set current device\n"
 	"nand read - addr off|partition size\n"
@@ -965,8 +964,7 @@ static char nand_help_text[] =
 	"nand env.oob set off|partition - set enviromnent offset\n"
 	"nand env.oob get - get environment offset"
 #endif
-	"";
-#endif
+	);
 
 U_BOOT_CMD(
 	nand, CONFIG_SYS_MAXARGS, 1, do_nand,
diff --git a/cmd/nvedit.c b/cmd/nvedit.c
index eaa000bd3559..daf1ad37f9be 100644
--- a/cmd/nvedit.c
+++ b/cmd/nvedit.c
@@ -1238,8 +1238,7 @@ static int do_env(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 	return CMD_RET_USAGE;
 }
 
-#ifdef CONFIG_SYS_LONGHELP
-static char env_help_text[] =
+U_BOOT_LONGHELP(env,
 #if defined(CONFIG_CMD_ASKENV)
 	"ask name [message] [size] - ask for environment variable\nenv "
 #endif
@@ -1304,8 +1303,7 @@ static char env_help_text[] =
 	"env set -e [-nv][-bs][-rt][-at][-a][-i addr:size][-v] name [arg ...]\n"
 	"    - set UEFI variable; unset if '-i' or 'arg' not specified\n"
 #endif
-	"env set [-f] name [arg ...]\n";
-#endif
+	"env set [-f] name [arg ...]\n");
 
 U_BOOT_CMD(
 	env, CONFIG_SYS_MAXARGS, 1, do_env,
diff --git a/cmd/osd.c b/cmd/osd.c
index c8c62d4a2ab3..210bc5d4c231 100644
--- a/cmd/osd.c
+++ b/cmd/osd.c
@@ -278,12 +278,12 @@ static int do_osd(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 		return CMD_RET_USAGE;
 }
 
-static char osd_help_text[] =
+U_BOOT_LONGHELP(osd,
 	"show  - show OSD info\n"
 	"osd dev [dev] - show or set current OSD\n"
 	"write [pos_x] [pos_y] [buffer] [count] - write 8-bit hex encoded buffer to osd memory at a given position\n"
 	"print [pos_x] [pos_y] [color] [text] - write ASCII buffer (given by text data and driver-specific color information) to osd memory\n"
-	"size [size_x] [size_y] - set OSD XY size in characters\n";
+	"size [size_x] [size_y] - set OSD XY size in characters\n");
 
 U_BOOT_CMD(
 	osd, 6, 1, do_osd,
diff --git a/cmd/pcap.c b/cmd/pcap.c
index ab5c1a7e8737..a0149203fad5 100644
--- a/cmd/pcap.c
+++ b/cmd/pcap.c
@@ -48,7 +48,7 @@ static int do_pcap_clear(struct cmd_tbl *cmdtp, int flag, int argc,
 	return pcap_clear() ? CMD_RET_FAILURE : CMD_RET_SUCCESS;
 }
 
-static char pcap_help_text[] =
+U_BOOT_LONGHELP(pcap,
 	"- network packet capture\n\n"
 	"pcap\n"
 	"pcap init\t\t\t<addr> <max_size>\n"
@@ -60,7 +60,7 @@ static char pcap_help_text[] =
 	"With:\n"
 	"\t<addr>: user address to which pcap will be stored (hexedcimal)\n"
 	"\t<max_size>: Maximum size of pcap file (decimal)\n"
-	"\n";
+	"\n");
 
 U_BOOT_CMD_WITH_SUBCMDS(pcap, "pcap", pcap_help_text,
 			U_BOOT_SUBCMD_MKENT(init, 3, 0, do_pcap_init),
diff --git a/cmd/pci.c b/cmd/pci.c
index 78b661d15b1c..d89e71c16a04 100644
--- a/cmd/pci.c
+++ b/cmd/pci.c
@@ -620,8 +620,7 @@ static int do_pci(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 
 /***************************************************/
 
-#ifdef CONFIG_SYS_LONGHELP
-static char pci_help_text[] =
+U_BOOT_LONGHELP(pci,
 	"[bus|*] [long]\n"
 	"    - short or long list of PCI devices on bus 'bus'\n"
 	"pci enum\n"
@@ -639,8 +638,7 @@ static char pci_help_text[] =
 	"pci modify[.b, .w, .l] b.d.f address\n"
 	"    -  modify, auto increment CFG address\n"
 	"pci write[.b, .w, .l] b.d.f address value\n"
-	"    - write to CFG address";
-#endif
+	"    - write to CFG address");
 
 U_BOOT_CMD(
 	pci,	5,	1,	do_pci,
diff --git a/cmd/pci_mps.c b/cmd/pci_mps.c
index 555a5fdd8e6b..98161da93a05 100644
--- a/cmd/pci_mps.c
+++ b/cmd/pci_mps.c
@@ -152,13 +152,11 @@ usage:
 
 /***************************************************/
 
-#ifdef CONFIG_SYS_LONGHELP
-static char pci_mps_help_text[] =
+U_BOOT_LONGHELP(pci_mps,
 	"safe\n"
 	"    - Set PCI Express MPS of all devices to safe values\n"
 	"pci_mps peer2peer\n"
-	"    - Set PCI Express MPS of all devices to support hotplug and peer-to-peer DMA\n";
-#endif
+	"    - Set PCI Express MPS of all devices to support hotplug and peer-to-peer DMA\n");
 
 U_BOOT_CMD(pci_mps, 2, 0, do_pci_mps,
 	   "configure PCI Express MPS", pci_mps_help_text);
diff --git a/cmd/riscv/sbi.c b/cmd/riscv/sbi.c
index 32761c595eb3..940d9bc1681a 100644
--- a/cmd/riscv/sbi.c
+++ b/cmd/riscv/sbi.c
@@ -119,11 +119,8 @@ static int do_sbi(struct cmd_tbl *cmdtp, int flag, int argc,
 	return 0;
 }
 
-#ifdef CONFIG_SYS_LONGHELP
-static char sbi_help_text[] =
-	"- display SBI spec version, implementation, and available extensions";
-
-#endif
+U_BOOT_LONGHELP(sbi,
+	"- display SBI spec version, implementation, and available extensions");
 
 U_BOOT_CMD_COMPLETE(
 	sbi, 1, 0, do_sbi,
diff --git a/cmd/rng.c b/cmd/rng.c
index 81a23964b82e..52f722c7af89 100644
--- a/cmd/rng.c
+++ b/cmd/rng.c
@@ -56,11 +56,9 @@ static int do_rng(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 	return ret;
 }
 
-#ifdef CONFIG_SYS_LONGHELP
-static char rng_help_text[] =
+U_BOOT_LONGHELP(rng,
 	"[dev [n]]\n"
-	"  - print n random bytes(max 64) read from dev\n";
-#endif
+	"  - print n random bytes(max 64) read from dev\n");
 
 U_BOOT_CMD(
 	rng, 3, 0, do_rng,
diff --git a/cmd/sandbox/exception.c b/cmd/sandbox/exception.c
index 1aa1d673aed4..c082401ce6b3 100644
--- a/cmd/sandbox/exception.c
+++ b/cmd/sandbox/exception.c
@@ -31,11 +31,10 @@ static struct cmd_tbl cmd_sub[] = {
 			 "", ""),
 };
 
-static char exception_help_text[] =
+U_BOOT_LONGHELP(exception,
 	"<ex>\n"
 	"  The following exceptions are available:\n"
 	"  undefined  - undefined instruction\n"
-	"  sigsegv    - illegal memory access\n"
-	;
+	"  sigsegv    - illegal memory access\n");
 
 #include <exception.h>
diff --git a/cmd/scp03.c b/cmd/scp03.c
index 216c942dd48b..2b8d5aecf349 100644
--- a/cmd/scp03.c
+++ b/cmd/scp03.c
@@ -41,11 +41,12 @@ int do_scp03_provision(struct cmd_tbl *cmdtp, int flag, int argc,
 	return CMD_RET_SUCCESS;
 }
 
-static char text[] =
+U_BOOT_LONGHELP(scp03,
 	"provides a command to enable SCP03 and provision the SCP03 keys\n"
 	" enable    - enable SCP03 on the TEE\n"
-	" provision - provision SCP03 on the TEE\n";
+	" provision - provision SCP03 on the TEE\n");
 
-U_BOOT_CMD_WITH_SUBCMDS(scp03, "Secure Channel Protocol 03 control", text,
+U_BOOT_CMD_WITH_SUBCMDS(scp03, "Secure Channel Protocol 03 control",
+	scp03_help_text,
 	U_BOOT_SUBCMD_MKENT(enable, 1, 1, do_scp03_enable),
 	U_BOOT_SUBCMD_MKENT(provision, 1, 1, do_scp03_provision));
diff --git a/cmd/sf.c b/cmd/sf.c
index 977ffcb63c10..30b2bd5ef689 100644
--- a/cmd/sf.c
+++ b/cmd/sf.c
@@ -614,8 +614,7 @@ static int do_spi_flash(struct cmd_tbl *cmdtp, int flag, int argc,
 	return ret;
 }
 
-#ifdef CONFIG_SYS_LONGHELP
-static const char long_help[] =
+U_BOOT_LONGHELP(sf,
 	"probe [[bus:]cs] [hz] [mode]	- init flash device on given SPI bus\n"
 	"				  and chip select\n"
 	"sf read addr offset|partition len	- read `len' bytes starting at\n"
@@ -635,10 +634,9 @@ static const char long_help[] =
 #ifdef CONFIG_CMD_SF_TEST
 	"\nsf test offset len		- run a very basic destructive test"
 #endif
-#endif /* CONFIG_SYS_LONGHELP */
-	;
+	);
 
 U_BOOT_CMD(
 	sf,	5,	1,	do_spi_flash,
-	"SPI flash sub-system", long_help
+	"SPI flash sub-system", sf_help_text
 );
diff --git a/cmd/source.c b/cmd/source.c
index 92c7835bf50e..0ba9736b1ab3 100644
--- a/cmd/source.c
+++ b/cmd/source.c
@@ -54,19 +54,18 @@ static int do_source(struct cmd_tbl *cmdtp, int flag, int argc,
 	return rcode;
 }
 
-#ifdef CONFIG_SYS_LONGHELP
-static char source_help_text[] =
+U_BOOT_LONGHELP(source,
 #if defined(CONFIG_FIT)
 	"[<addr>][:[<image>]|#[<config>]]\n"
 	"\t- Run script starting at addr\n"
 	"\t- A FIT config name or subimage name may be specified with : or #\n"
 	"\t  (like bootm). If the image or config name is omitted, the\n"
-	"\t  default is used.";
+	"\t  default is used."
 #else
 	"[<addr>]\n"
-	"\t- Run script starting at addr";
-#endif
+	"\t- Run script starting at addr"
 #endif
+	);
 
 U_BOOT_CMD(
 	source, 2, 0,	do_source,
diff --git a/cmd/ti/pd.c b/cmd/ti/pd.c
index a9a182fc386e..a0492a5fdee3 100644
--- a/cmd/ti/pd.c
+++ b/cmd/ti/pd.c
@@ -175,11 +175,11 @@ static int ti_do_pd(struct cmd_tbl *cmdtp, int flag, int argc, char * const argv
 		return CMD_RET_USAGE;
 }
 
-U_BOOT_CMD(pd, 4, 1, ti_do_pd,
-	   "TI power domain control",
-#if IS_ENABLED(CONFIG_SYS_LONGHELP)
+U_BOOT_LONGHELP(pd,
 	   "dump                 - show power domain status\n"
 	   "enable [psc] [lpsc]  - enable power domain\n"
-	   "disable [psc] [lpsc] - disable power domain\n"
-#endif
+	   "disable [psc] [lpsc] - disable power domain\n");
+
+U_BOOT_CMD(pd, 4, 1, ti_do_pd,
+	   "TI power domain control", pd_help_text
 );
diff --git a/cmd/vbe.c b/cmd/vbe.c
index 600690394eb8..0e84b0e97aa4 100644
--- a/cmd/vbe.c
+++ b/cmd/vbe.c
@@ -104,13 +104,11 @@ static int do_vbe_state(struct cmd_tbl *cmdtp, int flag, int argc,
 	return 0;
 }
 
-#ifdef CONFIG_SYS_LONGHELP
-static char vbe_help_text[] =
+U_BOOT_LONGHELP(vbe,
 	"list   - list VBE bootmeths\n"
 	"vbe select - select a VBE bootmeth by sequence or name\n"
 	"vbe info   - show information about a VBE bootmeth\n"
-	"vbe state  - show VBE state";
-#endif
+	"vbe state  - show VBE state");
 
 U_BOOT_CMD_WITH_SUBCMDS(vbe, "Verified Boot for Embedded", vbe_help_text,
 	U_BOOT_SUBCMD_MKENT(list, 1, 1, do_vbe_list),
diff --git a/cmd/wdt.c b/cmd/wdt.c
index 27410981e7bf..b9fdf7ad155f 100644
--- a/cmd/wdt.c
+++ b/cmd/wdt.c
@@ -157,13 +157,13 @@ static int do_wdt_expire(struct cmd_tbl *cmdtp, int flag, int argc,
 	return CMD_RET_SUCCESS;
 }
 
-static char wdt_help_text[] =
+U_BOOT_LONGHELP(wdt,
 	"list - list watchdog devices\n"
 	"wdt dev [<name>] - get/set current watchdog device\n"
 	"wdt start <timeout ms> [flags] - start watchdog timer\n"
 	"wdt stop - stop watchdog timer\n"
 	"wdt reset - reset watchdog timer\n"
-	"wdt expire [flags] - expire watchdog timer immediately\n";
+	"wdt expire [flags] - expire watchdog timer immediately\n");
 
 U_BOOT_CMD_WITH_SUBCMDS(wdt, "Watchdog sub-system", wdt_help_text,
 	U_BOOT_SUBCMD_MKENT(list, 1, 1, do_wdt_list),
diff --git a/cmd/ximg.c b/cmd/ximg.c
index 60ed2c9f6f9e..a50dd20b19aa 100644
--- a/cmd/ximg.c
+++ b/cmd/ximg.c
@@ -258,8 +258,7 @@ do_imgextract(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 	return 0;
 }
 
-#ifdef CONFIG_SYS_LONGHELP
-static char imgextract_help_text[] =
+U_BOOT_LONGHELP(imgextract,
 	"addr part [dest]\n"
 	"    - extract <part> from legacy image at <addr> and copy to <dest>"
 #if defined(CONFIG_FIT)
@@ -267,8 +266,7 @@ static char imgextract_help_text[] =
 	"addr uname [dest]\n"
 	"    - extract <uname> subimage from FIT image at <addr> and copy to <dest>"
 #endif
-	"";
-#endif
+	);
 
 U_BOOT_CMD(
 	imxtract, 4, 1, do_imgextract,
diff --git a/cmd/xxd.c b/cmd/xxd.c
index 742a85c7a933..446ac1915ef5 100644
--- a/cmd/xxd.c
+++ b/cmd/xxd.c
@@ -73,11 +73,9 @@ static int do_xxd(struct cmd_tbl *cmdtp, int flag, int argc,
 	return 0;
 }
 
-#ifdef CONFIG_SYS_LONGHELP
-static char xxd_help_text[] =
+U_BOOT_LONGHELP(xxd,
 	"<interface> <dev[:part]> <file>\n"
-	"  - Print file from 'dev' on 'interface' as hexdump to standard output\n";
-#endif
+	"  - Print file from 'dev' on 'interface' as hexdump to standard output\n");
 
 U_BOOT_CMD(xxd, 4, 1, do_xxd,
 	   "Print file as hexdump to standard output",
diff --git a/test/cmd_ut.c b/test/cmd_ut.c
index 0f56409e8031..477d4759521c 100644
--- a/test/cmd_ut.c
+++ b/test/cmd_ut.c
@@ -166,8 +166,7 @@ static int do_ut(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 	return CMD_RET_USAGE;
 }
 
-#ifdef CONFIG_SYS_LONGHELP
-static char ut_help_text[] =
+U_BOOT_LONGHELP(ut,
 	"[-r] [-f] [<suite>] - run unit tests\n"
 	"   -r<runs>   Number of times to run each test\n"
 	"   -f         Force 'manual' tests to run as well\n"
@@ -237,8 +236,7 @@ static char ut_help_text[] =
 	!defined(CONFIG_SPL_BUILD) && !defined(API_BUILD)
 	"\nunicode - Unicode functions"
 #endif
-	;
-#endif /* CONFIG_SYS_LONGHELP */
+	);
 
 U_BOOT_CMD(
 	ut, CONFIG_SYS_MAXARGS, 1, do_ut,
diff --git a/test/fuzz/cmd_fuzz.c b/test/fuzz/cmd_fuzz.c
index e2f44f3ecb61..d0bc7b8d7b76 100644
--- a/test/fuzz/cmd_fuzz.c
+++ b/test/fuzz/cmd_fuzz.c
@@ -70,11 +70,8 @@ static int do_fuzz(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[]
 	return 1;
 }
 
-#ifdef CONFIG_SYS_LONGHELP
-static char fuzz_help_text[] =
-	"[fuzz-test-name] - execute the named fuzz test\n"
-	;
-#endif /* CONFIG_SYS_LONGHELP */
+U_BOOT_LONGHELP(fuzz,
+	"[fuzz-test-name] - execute the named fuzz test\n");
 
 U_BOOT_CMD(
 	fuzz, CONFIG_SYS_MAXARGS, 1, do_fuzz,
-- 
2.34.1

