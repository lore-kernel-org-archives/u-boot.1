Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BC30C3DA42
	for <u-boot@archiver.kernel.org>; Sat, 13 Jul 2024 13:25:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 61931888C2;
	Sat, 13 Jul 2024 15:21:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="yRxHT9yw";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="bMpPaX3B";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1FE68888C2; Sat, 13 Jul 2024 15:21:36 +0200 (CEST)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D206388872
 for <u-boot@lists.denx.de>; Sat, 13 Jul 2024 15:21:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4WLpyP4BRNz9sTd;
 Sat, 13 Jul 2024 15:21:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1720876893;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dfKfcecKVw+vGCZzl+0CxWvSNIsofD7GKgAqAZip2Ac=;
 b=yRxHT9ywxx7VcToKk6fzl1PyJSSugHUoZ/Dx/x62q6hRcOZgN6P3FuyfOdww7jYN7Cm7Ft
 eXMST4xkX0MU+a8CHGOcwwzjX0j8V4lh482mMWzApeibcb+XB/lZkDFU2OMwIBp8tS3v64
 ekRE+h4/MWk34XB/0L4RTOOO6k2vNtnIb0CvG09IZ+06tvT0v2PmQi8XW1az7L4xxVWSXT
 HFKGGNFb0OiMZ37uQ7YkeUMYCgsmGcdwhDCNQdj3YS86xCcir9Fs47HHx90SueUzX2jMT2
 NyK1nABftYmAz2xT3JCcUa33RgsEievsv4TJm3r/eL+/EwruJjQ79zVA3tX/ug==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1720876891;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dfKfcecKVw+vGCZzl+0CxWvSNIsofD7GKgAqAZip2Ac=;
 b=bMpPaX3BgLK2pYugqSzGk31SbZ5gZeuPiEjX/UypcWlYXjusVRNDp0DxBLbULSjz///OYr
 UciOObs1vmAFBa5Yi+7zeOu6dNCTHWq2xxn9rqDUrqE/VCS3TBAOnMurFsPK8dJ20vlgex
 V8WnKJRmGEQnArU/B+S5TlNllfUvwEL6geOfx5h2DEPImwGN5MXN/OqyV3BHgW9feSYMAP
 NQc92pz9nlPsKHI8Nt+ahtG7ZQFE6/zeAu9xLqMKrEK6neAIiCbCvm2U/1WLIQ2wsy/sZD
 1aQUMLL0mNzQ8bf3+0WWsvuXyLuuukXipYdSPzwPd6Dja3k1qVrllo3tuGV4cw==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 25/45] cmd: Remove duplicate newlines
Date: Sat, 13 Jul 2024 15:19:16 +0200
Message-ID: <20240713132021.57650-25-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20240713132021.57650-1-marek.vasut+renesas@mailbox.org>
References: <20240713132021.57650-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: cf48b408525e6f70bfb
X-MBO-RS-META: ne8xedh1k7jrbm3x1u7nx4qc1wogkx5q
X-Rspamd-Queue-Id: 4WLpyP4BRNz9sTd
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
Cc: Francesco Dolcini <francesco.dolcini@toradex.com>
Cc: Sean Anderson <seanga2@gmail.com>
Cc: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
 cmd/ab_select.c       | 1 -
 cmd/bootm.c           | 2 --
 cmd/bootstage.c       | 1 -
 cmd/cache.c           | 1 -
 cmd/console.c         | 1 -
 cmd/cramfs.c          | 2 --
 cmd/extension_board.c | 1 -
 cmd/fat.c             | 1 -
 cmd/font.c            | 1 -
 cmd/load.c            | 8 --------
 cmd/mem.c             | 2 --
 cmd/mp.c              | 1 -
 cmd/mtdparts.c        | 4 ----
 cmd/net.c             | 1 -
 cmd/spl.c             | 1 -
 cmd/terminal.c        | 1 -
 cmd/tpm_test.c        | 1 -
 cmd/ubifs.c           | 1 -
 cmd/universe.c        | 6 ------
 cmd/usb.c             | 2 --
 cmd/ximg.c            | 1 -
 cmd/yaffs2.c          | 1 -
 cmd/zfs.c             | 3 ---
 23 files changed, 44 deletions(-)

diff --git a/cmd/ab_select.c b/cmd/ab_select.c
index faeb83816e5..7c178c728ca 100644
--- a/cmd/ab_select.c
+++ b/cmd/ab_select.c
@@ -35,7 +35,6 @@ static int do_ab_select(struct cmd_tbl *cmdtp, int flag, int argc,
 		return CMD_RET_FAILURE;
 	}
 
-
 	ret = ab_select_slot(dev_desc, &part_info, dec_tries);
 	if (ret < 0) {
 		printf("Android boot failed, error %d.\n", ret);
diff --git a/cmd/bootm.c b/cmd/bootm.c
index 545b0c3d823..bee683d0580 100644
--- a/cmd/bootm.c
+++ b/cmd/bootm.c
@@ -256,7 +256,6 @@ U_BOOT_CMD(
 
 #endif
 
-
 /*******************************************************************/
 /* iminfo - print header info for a requested image */
 /*******************************************************************/
@@ -361,7 +360,6 @@ U_BOOT_CMD(
 );
 #endif
 
-
 /*******************************************************************/
 /* imls - list all images found in flash */
 /*******************************************************************/
diff --git a/cmd/bootstage.c b/cmd/bootstage.c
index 5246924f39a..c47679d69d6 100644
--- a/cmd/bootstage.c
+++ b/cmd/bootstage.c
@@ -86,7 +86,6 @@ static int do_boostage(struct cmd_tbl *cmdtp, int flag, int argc,
 		return CMD_RET_USAGE;
 }
 
-
 U_BOOT_CMD(bootstage, 4, 1, do_boostage,
 	"Boot stage command",
 	" - check boot progress and timing\n"
diff --git a/cmd/cache.c b/cmd/cache.c
index 7a2068296ef..3049f5c305f 100644
--- a/cmd/cache.c
+++ b/cmd/cache.c
@@ -86,7 +86,6 @@ static int parse_argv(const char *s)
 	return -1;
 }
 
-
 U_BOOT_CMD(
 	icache,   2,   1,     do_icache,
 	"enable or disable instruction cache",
diff --git a/cmd/console.c b/cmd/console.c
index 12fc92061a1..a8133ee3fa3 100644
--- a/cmd/console.c
+++ b/cmd/console.c
@@ -47,7 +47,6 @@ static int do_coninfo(struct cmd_tbl *cmd, int flag, int argc,
 	return 0;
 }
 
-
 /***************************************************/
 
 U_BOOT_CMD(
diff --git a/cmd/cramfs.c b/cmd/cramfs.c
index b57e2815926..baff50d1bd6 100644
--- a/cmd/cramfs.c
+++ b/cmd/cramfs.c
@@ -6,7 +6,6 @@
  *	Add support for a CRAMFS located in RAM
  */
 
-
 /*
  * CRAMFS support
  */
@@ -32,7 +31,6 @@
 # define DEBUGF(fmt, args...)
 #endif
 
-
 #ifndef CONFIG_MTD_NOR_FLASH
 # define OFFSET_ADJUSTMENT	0
 #else
diff --git a/cmd/extension_board.c b/cmd/extension_board.c
index f43bf680858..6c14d0ddebd 100644
--- a/cmd/extension_board.c
+++ b/cmd/extension_board.c
@@ -98,7 +98,6 @@ static int extension_scan(bool show)
 	return extension_num;
 }
 
-
 static int do_extension_scan(struct cmd_tbl *cmdtp, int flag,
 			     int argc, char *const argv[])
 {
diff --git a/cmd/fat.c b/cmd/fat.c
index ad0e5ed7d60..1655e80e945 100644
--- a/cmd/fat.c
+++ b/cmd/fat.c
@@ -32,7 +32,6 @@ int do_fat_fsload(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 	return do_load(cmdtp, flag, argc, argv, FS_TYPE_FAT);
 }
 
-
 U_BOOT_CMD(
 	fatload,	7,	0,	do_fat_fsload,
 	"load binary file from a dos filesystem",
diff --git a/cmd/font.c b/cmd/font.c
index ebde094b0a5..eb13fb12f79 100644
--- a/cmd/font.c
+++ b/cmd/font.c
@@ -77,7 +77,6 @@ static int do_font_size(struct cmd_tbl *cmdtp, int flag, int argc,
 	return 0;
 }
 
-
 U_BOOT_LONGHELP(font,
 	"list       - list available fonts\n"
 	"font select <name> [<size>] - select font to use\n"
diff --git a/cmd/load.c b/cmd/load.c
index ace1c52f90a..d773a25d70c 100644
--- a/cmd/load.c
+++ b/cmd/load.c
@@ -417,7 +417,6 @@ static int write_record(char *buf)
 
 #endif
 
-
 #if defined(CONFIG_CMD_LOADB)
 /*
  * loadb command (load binary) included
@@ -441,7 +440,6 @@ static void set_kerm_bin_mode(unsigned long *);
 static int k_recv(void);
 static ulong load_serial_bin(ulong offset);
 
-
 static char his_eol;        /* character he needs at end of packet */
 static int  his_pad_count;  /* number of pad chars he needs */
 static char his_pad_char;   /* pad chars he needs */
@@ -557,7 +555,6 @@ static int do_load_serial_bin(struct cmd_tbl *cmdtp, int flag, int argc,
 	return rcode;
 }
 
-
 static ulong load_serial_bin(ulong offset)
 {
 	int size, i;
@@ -652,7 +649,6 @@ static void send_nack(int n)
 	s1_sendpacket(a_b);
 }
 
-
 static void (*os_data_init)(void);
 static void (*os_data_char)(char new_char);
 static int os_data_state, os_data_state_saved;
@@ -693,7 +689,6 @@ static void set_kerm_bin_mode(unsigned long *addr)
 	os_data_char = bin_data_char;
 }
 
-
 /* k_data_* simply handles the kermit escape translations */
 static int k_data_escape, k_data_escape_saved;
 static void k_data_init(void)
@@ -1066,7 +1061,6 @@ static ulong load_serial_ymodem(ulong offset, int mode)
 	xyzModem_stream_terminate(false, &getcxmodem);
 	xyzModem_stream_close(&err);
 
-
 	flush_cache(offset, ALIGN(size, ARCH_DMA_MINALIGN));
 
 	printf("## Total Size      = 0x%08x = %d Bytes\n", size, size);
@@ -1141,7 +1135,6 @@ U_BOOT_CMD(
  * SAVES always requires LOADS support, but not vice versa
  */
 
-
 #if defined(CONFIG_CMD_SAVES)
 #ifdef	CONFIG_SYS_LOADS_BAUD_CHANGE
 U_BOOT_CMD(
@@ -1162,7 +1155,6 @@ U_BOOT_CMD(
 #endif	/* CONFIG_CMD_SAVES */
 #endif	/* CONFIG_CMD_LOADS */
 
-
 #if defined(CONFIG_CMD_LOADB)
 U_BOOT_CMD(
 	loadb, 3, 0,	do_load_serial_bin,
diff --git a/cmd/mem.c b/cmd/mem.c
index 4989d27f2ab..274348068c2 100644
--- a/cmd/mem.c
+++ b/cmd/mem.c
@@ -1316,14 +1316,12 @@ U_BOOT_CMD(
 	"[.b, .w, .l" HELP_Q "] address [# of objects]"
 );
 
-
 U_BOOT_CMD(
 	mm,	2,	1,	do_mem_mm,
 	"memory modify (auto-incrementing address)",
 	"[.b, .w, .l" HELP_Q "] address"
 );
 
-
 U_BOOT_CMD(
 	nm,	2,	1,	do_mem_nm,
 	"memory modify (constant address)",
diff --git a/cmd/mp.c b/cmd/mp.c
index b9b5e016246..261bb8a07d4 100644
--- a/cmd/mp.c
+++ b/cmd/mp.c
@@ -42,7 +42,6 @@ cpu_cmd(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 		return 1;
 	}
 
-
 	if (argc == 3) {
 		if (strncmp(argv[2], "reset", 5) == 0)
 			cpu_reset(cpuid);
diff --git a/cmd/mtdparts.c b/cmd/mtdparts.c
index f57d84dbb3a..a021b2d198d 100644
--- a/cmd/mtdparts.c
+++ b/cmd/mtdparts.c
@@ -291,7 +291,6 @@ static void current_save(void)
 	index_partitions();
 }
 
-
 /**
  * Produce a mtd_info given a type and num.
  *
@@ -401,7 +400,6 @@ static int part_validate_eraseblock(struct mtdids *id, struct part_info *part)
 	return 0;
 }
 
-
 /**
  * Performs sanity check for supplied partition. Offset and size are
  * verified to be within valid range. Partition type is checked and
@@ -1128,7 +1126,6 @@ static int generate_mtdparts(char *buf, u32 buflen)
 			p += len;
 			maxlen -= len;
 
-
 			/* add offset only when there is a gap between
 			 * partitions */
 			if ((!prev_part && (offset != 0)) ||
@@ -1709,7 +1706,6 @@ static int parse_mtdids(const char *const ids)
 	return 0;
 }
 
-
 /**
  * Parse and initialize global mtdids mapping and create global
  * device/partition list.
diff --git a/cmd/net.c b/cmd/net.c
index b206ff58e68..53ce2bc5d0c 100644
--- a/cmd/net.c
+++ b/cmd/net.c
@@ -97,7 +97,6 @@ U_BOOT_CMD(
 );
 #endif
 
-
 #ifdef CONFIG_CMD_RARP
 int do_rarpb(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 {
diff --git a/cmd/spl.c b/cmd/spl.c
index d1f47c7316b..76fe33762df 100644
--- a/cmd/spl.c
+++ b/cmd/spl.c
@@ -66,7 +66,6 @@ static int call_bootm(int argc, char *const argv[], const char *subcommand[])
 		bootm_argv[2] = argv[0]; /* kernel addr */
 	}
 
-
 	/*
 	 * - do the work -
 	 * exec subcommands of do_bootm to init the images
diff --git a/cmd/terminal.c b/cmd/terminal.c
index 369a755e0f5..d803bc6c896 100644
--- a/cmd/terminal.c
+++ b/cmd/terminal.c
@@ -66,7 +66,6 @@ int do_terminal(struct cmd_tbl *cmd, int flag, int argc, char *const argv[])
 	return 0;
 }
 
-
 /***************************************************/
 
 U_BOOT_CMD(
diff --git a/cmd/tpm_test.c b/cmd/tpm_test.c
index 9c8b1c74384..af83d78c3fe 100644
--- a/cmd/tpm_test.c
+++ b/cmd/tpm_test.c
@@ -424,7 +424,6 @@ static int test_startup(struct udevice *dev)
 	} \
 } while (0)
 
-
 static int test_timing(struct udevice *dev)
 {
 	uint8_t in[20], out[20];
diff --git a/cmd/ubifs.c b/cmd/ubifs.c
index 8fd39032ecc..22e95db8ca5 100644
--- a/cmd/ubifs.c
+++ b/cmd/ubifs.c
@@ -4,7 +4,6 @@
  * Stefan Roese, DENX Software Engineering, sr@denx.de.
  */
 
-
 /*
  * UBIFS command support
  */
diff --git a/cmd/universe.c b/cmd/universe.c
index d1a712829d0..1445d5301f2 100644
--- a/cmd/universe.c
+++ b/cmd/universe.c
@@ -14,7 +14,6 @@
 #define PCI_VENDOR PCI_VENDOR_ID_TUNDRA
 #define PCI_DEVICE PCI_DEVICE_ID_TUNDRA_CA91C042
 
-
 typedef struct _UNI_DEV UNI_DEV;
 
 struct _UNI_DEV {
@@ -26,7 +25,6 @@ struct _UNI_DEV {
 
 static UNI_DEV   *dev;
 
-
 int universe_init(void)
 {
 	int j, result;
@@ -112,7 +110,6 @@ int universe_init(void)
 	return result;
 }
 
-
 /*
  * Create pci slave window (access: pci -> vme)
  */
@@ -209,7 +206,6 @@ int universe_pci_slave_window(unsigned int pciAddr, unsigned int vmeAddr, int si
 	return -result;
 }
 
-
 /*
  * Create vme slave window (access: vme -> pci)
  */
@@ -294,7 +290,6 @@ int universe_vme_slave_window(unsigned int vmeAddr, unsigned int pciAddr, int si
 	return -result;
 }
 
-
 /*
  * Tundra Universe configuration
  */
@@ -342,7 +337,6 @@ int do_universe(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 	return 0;
 }
 
-
 U_BOOT_CMD(
 	universe,	8,	1,	do_universe,
 	"initialize and configure Turndra Universe",
diff --git a/cmd/usb.c b/cmd/usb.c
index 225d9291765..16c081bf128 100644
--- a/cmd/usb.c
+++ b/cmd/usb.c
@@ -549,7 +549,6 @@ static int usb_test(struct usb_device *dev, int port, char* arg)
 	}
 }
 
-
 /******************************************************************************
  * usb boot command intepreter. Derived from diskboot
  */
@@ -737,7 +736,6 @@ U_BOOT_CMD(
 #endif /* CONFIG_USB_STORAGE */
 );
 
-
 #ifdef CONFIG_USB_STORAGE
 U_BOOT_CMD(
 	usbboot,	3,	1,	do_usbboot,
diff --git a/cmd/ximg.c b/cmd/ximg.c
index c79e8a07860..1c96f5a0a1f 100644
--- a/cmd/ximg.c
+++ b/cmd/ximg.c
@@ -7,7 +7,6 @@
  * Kai-Uwe Bloem, Auerswald GmbH & Co KG, <linux-development@auerswald.de>
  */
 
-
 /*
  * Multi Image extract
  */
diff --git a/cmd/yaffs2.c b/cmd/yaffs2.c
index d0724d9bea8..daa44abeb72 100644
--- a/cmd/yaffs2.c
+++ b/cmd/yaffs2.c
@@ -13,7 +13,6 @@
  *  ...
  */
 
-
 #include <config.h>
 #include <command.h>
 
diff --git a/cmd/zfs.c b/cmd/zfs.c
index 2f831532c2e..471c63f2150 100644
--- a/cmd/zfs.c
+++ b/cmd/zfs.c
@@ -119,7 +119,6 @@ static int do_zfs_load(struct cmd_tbl *cmdtp, int flag, int argc,
 	return 0;
 }
 
-
 int zfs_print(const char *entry, const struct zfs_dirhook_info *data)
 {
 	printf("%s %s\n",
@@ -128,7 +127,6 @@ int zfs_print(const char *entry, const struct zfs_dirhook_info *data)
 	return 0; /* 0 continue, 1 stop */
 }
 
-
 static int do_zfs_ls(struct cmd_tbl *cmdtp, int flag, int argc,
 		     char *const argv[])
 {
@@ -157,7 +155,6 @@ static int do_zfs_ls(struct cmd_tbl *cmdtp, int flag, int argc,
 	return 0;
 }
 
-
 U_BOOT_CMD(zfsls, 4, 1, do_zfs_ls,
 		   "list files in a directory (default /)",
 		   "<interface> <dev[:part]> [directory]\n"
-- 
2.43.0

