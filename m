Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D3E5C27C79
	for <u-boot@archiver.kernel.org>; Wed, 19 Jun 2024 16:09:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 63499881C6;
	Wed, 19 Jun 2024 18:09:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="NomsqvIX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 70826883DB; Wed, 19 Jun 2024 18:09:51 +0200 (CEST)
Received: from mail-oo1-xc33.google.com (mail-oo1-xc33.google.com
 [IPv6:2607:f8b0:4864:20::c33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E67A487E49
 for <u-boot@lists.denx.de>; Wed, 19 Jun 2024 18:09:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc33.google.com with SMTP id
 006d021491bc7-5b97539a4a5so3700134eaf.2
 for <u-boot@lists.denx.de>; Wed, 19 Jun 2024 09:09:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1718813387; x=1719418187; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=w86mYuWvf+6BQFsBb3qKJBDb0Xptgaolp77TbU0dALY=;
 b=NomsqvIXs9bEhG2eGUmG44NaQEhU7SPg0BV5EzNLwnpE+M6iNmEJoRZfenEsbj4b10
 o92F+OY9/R3WPkvxrNKK75/5anCB1qe1ZoBo4Wx51KmvoslhkzeZLw2A+EXnoq7W/Np2
 i+N3DncDJsOYDTe1YR3+EvqM06SfAfR6WuVhQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718813387; x=1719418187;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=w86mYuWvf+6BQFsBb3qKJBDb0Xptgaolp77TbU0dALY=;
 b=i0b4E0GEzfO0OH6Nozpnevf/nAwWMKmTBE+CA/QiqehlRzI3dxLhkMOceDk2Pan0II
 LjJeyuwQdoShCJ0+3Y5jmGJ2lBpfGT4sF811wpT8L7m+Wm5uWedQHFqlm2JCSzv/YF9G
 HsLn3eMiG0s4/sjnvB9Cu/fPPZ0XOZc1hkrm5Zj8MA4gAdtn6RqFN9rJIf05v9tCUkWW
 9tJHsXi2hODx35gABgTJKlgK1FECYTsX7yroNlu8SIKbHVzU3jiyAm6dj1+XlF0XKShX
 dGegMN9BoCfZkJPY7REI8bnZbHVFbTsFaQJzmCWyhuwP0bFN93xO+Ycqw0+fn8119o7R
 IgPQ==
X-Gm-Message-State: AOJu0YwJaZjQ7R2lCF1beeC/QbEOg2EfWpW4IQmO7kS6y5iycEAJcEqN
 X5MjzUxX0exmIf5D6QgbDJM0cslycMiVwtsjb4Yl7xahoM9ha7zxX8eXYmS0nPuiyhUpH0BnPsh
 DQjh5tg==
X-Google-Smtp-Source: AGHT+IEZ5S7jC5Zf5VHtMnbq+VAyM+vYrhgURk6ZN9d/Wg1tlFMB2DjFnlXdGBzERj577r6COEYb7w==
X-Received: by 2002:a05:6870:d0c9:b0:254:a57e:1aed with SMTP id
 586e51a60fabf-25c94a005fdmr3528452fac.26.1718813387454; 
 Wed, 19 Jun 2024 09:09:47 -0700 (PDT)
Received: from bill-the-cat.tail58a08.ts.net
 (fixed-187-190-205-45.totalplay.net. [187.190.205.45])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2569934cd8csm3756960fac.50.2024.06.19.09.09.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Jun 2024 09:09:46 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Michal Simek <monstr@monstr.eu>
Subject: [v2] cmd: Make use of U_BOOT_LONGHELP when missing
Date: Wed, 19 Jun 2024 10:09:44 -0600
Message-Id: <20240619160944.3429449-1-trini@konsulko.com>
X-Mailer: git-send-email 2.34.1
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

After adding the U_BOOT_LONGHELP macro some new commands came in still
that were not making use if it. Switch these cases over and in a few
places add missing newlines as well.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
Cc: Michal Simek <monstr@monstr.eu>

Changes in v2:
- Add the instances Michal noted I missed before
---
 arch/arm/mach-imx/cmd_dek.c                |  4 ++--
 arch/arm/mach-imx/cmd_mfgprot.c            |  4 ++--
 arch/arm/mach-imx/imx8/snvs_security_sc.c  | 20 ++++++++++----------
 arch/arm/mach-stm32mp/cmd_stm32key.c       |  4 ++--
 board/amd/versal2/cmds.c                   |  5 ++---
 board/freescale/common/cmd_esbc_validate.c |  4 ++--
 board/kontron/sl28/cmds.c                  |  4 ++--
 board/xilinx/versal-net/cmds.c             |  5 ++---
 cmd/adc.c                                  |  4 ++--
 cmd/arm/exception.c                        |  5 ++---
 cmd/arm/exception64.c                      |  5 ++---
 cmd/blob.c                                 |  4 ++--
 cmd/cli.c                                  |  9 ++-------
 cmd/riscv/exception.c                      |  5 ++---
 cmd/scmi.c                                 |  5 ++---
 cmd/x86/exception.c                        |  5 ++---
 16 files changed, 40 insertions(+), 52 deletions(-)

diff --git a/arch/arm/mach-imx/cmd_dek.c b/arch/arm/mach-imx/cmd_dek.c
index c7962ead2d54..56e1a8f8be76 100644
--- a/arch/arm/mach-imx/cmd_dek.c
+++ b/arch/arm/mach-imx/cmd_dek.c
@@ -395,10 +395,10 @@ static int do_dek_blob(struct cmd_tbl *cmdtp, int flag, int argc,
 }
 
 /***************************************************/
-static char dek_blob_help_text[] =
+U_BOOT_LONGHELP(dek_blob,
 	"src dst len            - Encapsulate and create blob of data\n"
 	"                         $len bits long at address $src and\n"
-	"                         store the result at address $dst.\n";
+	"                         store the result at address $dst.\n");
 
 U_BOOT_CMD(
 	dek_blob, 4, 1, do_dek_blob,
diff --git a/arch/arm/mach-imx/cmd_mfgprot.c b/arch/arm/mach-imx/cmd_mfgprot.c
index 9925c9922687..9f37e611a1e7 100644
--- a/arch/arm/mach-imx/cmd_mfgprot.c
+++ b/arch/arm/mach-imx/cmd_mfgprot.c
@@ -134,12 +134,12 @@ free_m:
 }
 
 /***************************************************/
-static char mfgprot_help_text[] =
+U_BOOT_LONGHELP(mfgprot,
 	"Usage:\n"
 	 "Print the public key for Manufacturing Protection\n"
 	 "\tmfgprot pubk\n"
 	 "Generates a Manufacturing Protection signature\n"
-	 "\tmfgprot sign <data_addr> <size>";
+	 "\tmfgprot sign <data_addr> <size>\n");
 
 U_BOOT_CMD(
 	mfgprot, 4, 1, do_mfgprot,
diff --git a/arch/arm/mach-imx/imx8/snvs_security_sc.c b/arch/arm/mach-imx/imx8/snvs_security_sc.c
index f13dfc155165..df8c22b57063 100644
--- a/arch/arm/mach-imx/imx8/snvs_security_sc.c
+++ b/arch/arm/mach-imx/imx8/snvs_security_sc.c
@@ -597,7 +597,7 @@ exit:
 }
 #endif /* CONFIG_IMX_SNVS_SEC_SC_AUTO */
 
-static char snvs_cfg_help_text[] =
+U_BOOT_LONGHELP(snvs_cfg,
 	"snvs_cfg\n"
 	"\thp.lock\n"
 	"\thp.secvio_ctl\n"
@@ -618,7 +618,7 @@ static char snvs_cfg_help_text[] =
 	"\tlp.act_tamper_routing_ctl1\n"
 	"\tlp.act_tamper_routing_ctl2\n"
 	"\n"
-	"ALL values should be in hexadecimal format";
+	"ALL values should be in hexadecimal format\n");
 
 #define NB_REGISTERS 18
 static int do_snvs_cfg(struct cmd_tbl *cmdtp, int flag, int argc,
@@ -662,7 +662,7 @@ U_BOOT_CMD(snvs_cfg,
 	   snvs_cfg_help_text
 );
 
-static char snvs_dgo_cfg_help_text[] =
+U_BOOT_LONGHELP(snvs_dgo_cfg,
 	"snvs_dgo_cfg\n"
 	"\ttamper_offset_ctl\n"
 	"\ttamper_pull_ctl\n"
@@ -671,7 +671,7 @@ static char snvs_dgo_cfg_help_text[] =
 	"\ttamper_misc_ctl\n"
 	"\ttamper_core_volt_mon_ctl\n"
 	"\n"
-	"ALL values should be in hexadecimal format";
+	"ALL values should be in hexadecimal format\n");
 
 static int do_snvs_dgo_cfg(struct cmd_tbl *cmdtp, int flag, int argc,
 			   char *const argv[])
@@ -702,12 +702,12 @@ U_BOOT_CMD(snvs_dgo_cfg,
 	   snvs_dgo_cfg_help_text
 );
 
-static char tamper_pin_cfg_help_text[] =
+U_BOOT_LONGHELP(tamper_pin_cfg,
 	"snvs_dgo_cfg\n"
 	"\tpad\n"
 	"\tvalue\n"
 	"\n"
-	"ALL values should be in hexadecimal format";
+	"ALL values should be in hexadecimal format\n");
 
 static int do_tamper_pin_cfg(struct cmd_tbl *cmdtp, int flag, int argc,
 			     char *const argv[])
@@ -734,7 +734,7 @@ U_BOOT_CMD(tamper_pin_cfg,
 	   tamper_pin_cfg_help_text
 );
 
-static char snvs_clear_status_help_text[] =
+U_BOOT_LONGHELP(snvs_clear_status,
 	"snvs_clear_status\n"
 	"\tHPSR\n"
 	"\tHPSVSR\n"
@@ -742,7 +742,7 @@ static char snvs_clear_status_help_text[] =
 	"\tLPTDSR\n"
 	"\n"
 	"Write the status registers with the value provided,"
-	" clearing the status";
+	" clearing the status\n");
 
 static int do_snvs_clear_status(struct cmd_tbl *cmdtp, int flag, int argc,
 				char *const argv[])
@@ -778,9 +778,9 @@ U_BOOT_CMD(snvs_clear_status,
 	   snvs_clear_status_help_text
 );
 
-static char snvs_sec_status_help_text[] =
+U_BOOT_LONGHELP(snvs_sec_status,
 	"snvs_sec_status\n"
-	"Display information about the security related to tamper and secvio";
+	"Display information about the security related to tamper and secvio\n");
 
 static int do_snvs_sec_status(struct cmd_tbl *cmdtp, int flag, int argc,
 			      char *const argv[])
diff --git a/arch/arm/mach-stm32mp/cmd_stm32key.c b/arch/arm/mach-stm32mp/cmd_stm32key.c
index 0cb3c7a9fa44..040a70f581cb 100644
--- a/arch/arm/mach-stm32mp/cmd_stm32key.c
+++ b/arch/arm/mach-stm32mp/cmd_stm32key.c
@@ -419,12 +419,12 @@ static int do_stm32key_close(struct cmd_tbl *cmdtp, int flag, int argc, char *co
 	return CMD_RET_SUCCESS;
 }
 
-static char stm32key_help_text[] =
+U_BOOT_LONGHELP(stm32key,
 	"list : list the supported key with description\n"
 	"stm32key select [<key>] : Select the key identified by <key> or display the key used for read/fuse command\n"
 	"stm32key read [<addr> | -a ] : Read the curent key at <addr> or current / all (-a) key in OTP\n"
 	"stm32key fuse [-y] <addr> : Fuse the current key at addr in OTP\n"
-	"stm32key close [-y] : Close the device\n";
+	"stm32key close [-y] : Close the device\n");
 
 U_BOOT_CMD_WITH_SUBCMDS(stm32key, "Manage key on STM32", stm32key_help_text,
 	U_BOOT_SUBCMD_MKENT(list, 1, 0, do_stm32key_list),
diff --git a/board/amd/versal2/cmds.c b/board/amd/versal2/cmds.c
index fbd99918a7f4..56ae39bc6a1e 100644
--- a/board/amd/versal2/cmds.c
+++ b/board/amd/versal2/cmds.c
@@ -71,10 +71,9 @@ static int do_versal2_load_pdi(struct cmd_tbl *cmdtp, int flag, int argc,
 	return cmd_process_error(cmdtp, ret);
 }
 
-static char versal2_help_text[] =
+U_BOOT_LONGHELP(versal2,
 	"loadpdi addr len - Load pdi image\n"
-	"load pdi image at ddr address 'addr' with pdi image size 'len'\n"
-;
+	"load pdi image at ddr address 'addr' with pdi image size 'len'\n");
 
 U_BOOT_CMD_WITH_SUBCMDS(versal2, "Versal Gen 2 sub-system", versal2_help_text,
 			U_BOOT_SUBCMD_MKENT(loadpdi, 3, 1,
diff --git a/board/freescale/common/cmd_esbc_validate.c b/board/freescale/common/cmd_esbc_validate.c
index d4192e5ab521..3344653ba2da 100644
--- a/board/freescale/common/cmd_esbc_validate.c
+++ b/board/freescale/common/cmd_esbc_validate.c
@@ -63,14 +63,14 @@ static int do_esbc_validate(struct cmd_tbl *cmdtp, int flag, int argc,
 }
 
 /***************************************************/
-static char esbc_validate_help_text[] =
+U_BOOT_LONGHELP(esbc_validate,
 	"esbc_validate hdr_addr <hash_val> - Validates signature using\n"
 	"                          RSA verification\n"
 	"                          $hdr_addr Address of header of the image\n"
 	"                          to be validated.\n"
 	"                          $hash_val -Optional\n"
 	"                          It provides Hash of public/srk key to be\n"
-	"                          used to verify signature.\n";
+	"                          used to verify signature.\n");
 
 U_BOOT_CMD(
 	esbc_validate,	3,	0,	do_esbc_validate,
diff --git a/board/kontron/sl28/cmds.c b/board/kontron/sl28/cmds.c
index 7851361c48cc..07514778753f 100644
--- a/board/kontron/sl28/cmds.c
+++ b/board/kontron/sl28/cmds.c
@@ -172,8 +172,8 @@ out:
 	return CMD_RET_FAILURE;
 }
 
-static char sl28_help_text[] =
-	"nvm [<hex>] - display/set the 16 non-volatile bits\n";
+U_BOOT_LONGHELP(sl28,
+	"nvm [<hex>] - display/set the 16 non-volatile bits\n");
 
 U_BOOT_CMD_WITH_SUBCMDS(sl28, "SMARC-sAL28 specific", sl28_help_text,
 			U_BOOT_SUBCMD_MKENT(nvm, 2, 1, do_sl28_nvm));
diff --git a/board/xilinx/versal-net/cmds.c b/board/xilinx/versal-net/cmds.c
index 4d52084846b7..e8b669f0fd48 100644
--- a/board/xilinx/versal-net/cmds.c
+++ b/board/xilinx/versal-net/cmds.c
@@ -71,10 +71,9 @@ static int do_versalnet_load_pdi(struct cmd_tbl *cmdtp, int flag, int argc,
 	return cmd_process_error(cmdtp, ret);
 }
 
-static char versalnet_help_text[] =
+U_BOOT_LONGHELP(versalnet,
 	"loadpdi addr len - Load pdi image\n"
-	"load pdi image at ddr address 'addr' with pdi image size 'len'\n"
-;
+	"load pdi image at ddr address 'addr' with pdi image size 'len'\n");
 
 U_BOOT_CMD_WITH_SUBCMDS(versalnet, "Versal NET sub-system", versalnet_help_text,
 			U_BOOT_SUBCMD_MKENT(loadpdi, 3, 1,
diff --git a/cmd/adc.c b/cmd/adc.c
index f87f9785a114..4d3b5b61f6f0 100644
--- a/cmd/adc.c
+++ b/cmd/adc.c
@@ -152,11 +152,11 @@ static int do_adc_scan(struct cmd_tbl *cmdtp, int flag, int argc,
 	return CMD_RET_SUCCESS;
 }
 
-static char adc_help_text[] =
+U_BOOT_LONGHELP(adc,
 	"list - list ADC devices\n"
 	"adc info <name> - Get ADC device info\n"
 	"adc single <name> <channel> [varname] - Get Single data of ADC device channel\n"
-	"adc scan <name> [channel mask] - Scan all [or masked] ADC channels";
+	"adc scan <name> [channel mask] - Scan all [or masked] ADC channels\n");
 
 U_BOOT_CMD_WITH_SUBCMDS(adc, "ADC sub-system", adc_help_text,
 	U_BOOT_SUBCMD_MKENT(list, 1, 1, do_adc_list),
diff --git a/cmd/arm/exception.c b/cmd/arm/exception.c
index 98a9795b68c8..8857f1216049 100644
--- a/cmd/arm/exception.c
+++ b/cmd/arm/exception.c
@@ -49,12 +49,11 @@ static struct cmd_tbl cmd_sub[] = {
 			 "", ""),
 };
 
-static char exception_help_text[] =
+U_BOOT_LONGHELP(exception,
 	"<ex>\n"
 	"  The following exceptions are available:\n"
 	"  breakpoint - prefetch abort\n"
 	"  unaligned  - data abort\n"
-	"  undefined  - undefined instruction\n"
-	;
+	"  undefined  - undefined instruction\n");
 
 #include <exception.h>
diff --git a/cmd/arm/exception64.c b/cmd/arm/exception64.c
index 73d6c20ccace..4c5b953168cb 100644
--- a/cmd/arm/exception64.c
+++ b/cmd/arm/exception64.c
@@ -77,12 +77,11 @@ static struct cmd_tbl cmd_sub[] = {
 			 "", ""),
 };
 
-static char exception_help_text[] =
+U_BOOT_LONGHELP(exception,
 	"<ex>\n"
 	"  The following exceptions are available:\n"
 	"  breakpoint - breakpoint instruction exception\n"
 	"  unaligned  - unaligned LDAR data abort\n"
-	"  undefined  - undefined instruction exception\n"
-	;
+	"  undefined  - undefined instruction exception\n");
 
 #include <exception.h>
diff --git a/cmd/blob.c b/cmd/blob.c
index a3c1dc49224d..b1c72e3f4406 100644
--- a/cmd/blob.c
+++ b/cmd/blob.c
@@ -99,7 +99,7 @@ static int do_blob(struct cmd_tbl *cmdtp, int flag, int argc,
 }
 
 /***************************************************/
-static char blob_help_text[] =
+U_BOOT_LONGHELP(blob,
 	"enc src dst len km - Encapsulate and create blob of data\n"
 	"                          $len bytes long at address $src and\n"
 	"                          store the result at address $dst.\n"
@@ -115,7 +115,7 @@ static char blob_help_text[] =
 	"                          modifier is stored.\n"
 	"                          The modifier is required for generation\n"
 	"                          /use as key for cryptographic operation.\n"
-	"                          Key modifier should be 16 byte long.\n";
+	"                          Key modifier should be 16 byte long.\n");
 
 U_BOOT_CMD(
 	blob, 6, 1, do_blob,
diff --git a/cmd/cli.c b/cmd/cli.c
index be3bf7dfe202..e0ddd0a43d0b 100644
--- a/cmd/cli.c
+++ b/cmd/cli.c
@@ -118,16 +118,11 @@ static int do_cli(struct cmd_tbl *cmdtp, int flag, int argc,
 	return CMD_RET_USAGE;
 }
 
-#if CONFIG_IS_ENABLED(SYS_LONGHELP)
-static char cli_help_text[] =
+U_BOOT_LONGHELP(cli,
 	"get - print current cli\n"
-	"set - set the current cli, possible value are: old, modern"
-	;
-#endif
+	"set - set the current cli, possible value are: old, modern\n");
 
 U_BOOT_CMD(cli, 3, 1, do_cli,
 	   "cli",
-#if CONFIG_IS_ENABLED(SYS_LONGHELP)
 	   cli_help_text
-#endif
 );
diff --git a/cmd/riscv/exception.c b/cmd/riscv/exception.c
index 14ad6c440a56..2b58b1c449c0 100644
--- a/cmd/riscv/exception.c
+++ b/cmd/riscv/exception.c
@@ -68,14 +68,13 @@ static struct cmd_tbl cmd_sub[] = {
 			 "", ""),
 };
 
-static char exception_help_text[] =
+U_BOOT_LONGHELP(exception,
 	"<ex>\n"
 	"  The following exceptions are available:\n"
 	"  compressed - compressed instruction\n"
 	"  ebreak     - breakpoint\n"
 	"  ialign16   - 16 bit aligned instruction\n"
 	"  undefined  - illegal instruction\n"
-	"  unaligned  - load address misaligned\n"
-	;
+	"  unaligned  - load address misaligned\n");
 
 #include <exception.h>
diff --git a/cmd/scmi.c b/cmd/scmi.c
index 664062c4eff5..cfbca63e1644 100644
--- a/cmd/scmi.c
+++ b/cmd/scmi.c
@@ -369,7 +369,7 @@ static int do_scmi(struct cmd_tbl *cmdtp, int flag,
 	return cp->cmd(cmdtp, flag, argc, argv);
 }
 
-static char scmi_help_text[] =
+U_BOOT_LONGHELP(scmi,
 	" - SCMI utility\n"
 	" info - get the info of SCMI services\n"
 	" perm_dev <agent-id in hex> <device-id in hex> <flags in hex>\n"
@@ -377,8 +377,7 @@ static char scmi_help_text[] =
 	" perm_proto <agent-id in hex> <device-id in hex> <protocol-id in hex> <flags in hex>\n"
 	"   - set protocol permission to device\n"
 	" reset <agent-id in hex> <flags in hex>\n"
-	"   - reset platform resource settings\n"
-	"";
+	"   - reset platform resource settings\n");
 
 U_BOOT_CMD(scmi, CONFIG_SYS_MAXARGS, 0, do_scmi, "SCMI utility",
 	   scmi_help_text);
diff --git a/cmd/x86/exception.c b/cmd/x86/exception.c
index 14b6bd6f4932..02735494a3c6 100644
--- a/cmd/x86/exception.c
+++ b/cmd/x86/exception.c
@@ -19,10 +19,9 @@ static struct cmd_tbl cmd_sub[] = {
 			 "", ""),
 };
 
-static char exception_help_text[] =
+U_BOOT_LONGHELP(exception,
 	"<ex>\n"
 	"  The following exceptions are available:\n"
-	"  undefined  - undefined instruction\n"
-	;
+	"  undefined  - undefined instruction\n");
 
 #include <exception.h>
-- 
2.34.1

