Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 749DBC4332F
	for <u-boot@archiver.kernel.org>; Sun, 12 Nov 2023 00:15:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8226886FA6;
	Sun, 12 Nov 2023 01:10:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ZeTPCVtj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CCBE186FE9; Sun, 12 Nov 2023 01:09:50 +0100 (CET)
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com
 [IPv6:2607:f8b0:4864:20::131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CEA8086FA7
 for <u-boot@lists.denx.de>; Sun, 12 Nov 2023 01:09:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x131.google.com with SMTP id
 e9e14a558f8ab-3576e74ae9dso13202265ab.3
 for <u-boot@lists.denx.de>; Sat, 11 Nov 2023 16:09:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1699747773; x=1700352573; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sx52Eoo1t3RSYl0VcVZHBcSkayTT1dQia9VUFNzWLq8=;
 b=ZeTPCVtj/+wy3GGqNjbGEFiFaUp97RlGovYES6mbwZRSBfI/+6I+Wwrh4V1J/YvC9N
 ZY1U3xfepDj+i+pD6mqBb8zRP0/nZr/BIMOyjAI5eraGC5PnkasaHPdo4hdel4lK8/9x
 V9lOjBoGhEB1X8VxBCr7UVJfdwcCAtsr2oPfg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699747773; x=1700352573;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sx52Eoo1t3RSYl0VcVZHBcSkayTT1dQia9VUFNzWLq8=;
 b=EiZy8Rlk3qIB9vDAKnA0u6uS5PNtBhSUTvvpKVjicLTYs3IxDMaGNG9D00+KgrrO13
 q0mwg7aJMQl83Pj1GtMiq6tkhbHnQr6aMIBiac3ieE/vo53V3JsORnE6VTIu1V4s0fkY
 iY5N1pZXE0d5XB2FuWGiF0BfLKziPPi5i582fiA8VDz/1nTRIGMFPGW0HrTcyD56Hlft
 ZxEQ7eA7jeuCBN9c7mf3zLM5np6N7ZcVhnDjn1i6Olsw8kz75IX4ueYtXKL4am3J02MG
 mu2Aj3uchD/SUoaS26FuHdkGn2jMg5OKvsk36RgxR+JCNXorEE/XTfVbcY4nsDef0k3I
 nzSQ==
X-Gm-Message-State: AOJu0Yy2FJZ8dYDnyViO0oyZMHvyP+3Xl53KNX1Ap8u/XgSZrDS1qACI
 psPVZ2BcG9hYADRqN17jm9mR9qSwVMNx8YatvIA2qQ==
X-Google-Smtp-Source: AGHT+IHeFDz8V+x0OmDmdGrXiFYA1+anw3kY/SO39Z1Pm+6KbUu18dQezHvD6BgEt3BcKtIz2SUtBw==
X-Received: by 2002:a05:6e02:2143:b0:34a:a4a5:3f93 with SMTP id
 d3-20020a056e02214300b0034aa4a53f93mr4836609ilv.5.1699747773593; 
 Sat, 11 Nov 2023 16:09:33 -0800 (PST)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 l14-20020a92280e000000b003576ff2d8b1sm706804ilf.26.2023.11.11.16.09.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 11 Nov 2023 16:09:33 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Baruch Siach <baruch@tkos.co.il>, Bin Meng <bmeng.cn@gmail.com>,
 Evgeny Bachinin <EABachinin@sberdevices.ru>,
 Fabio Estevam <festevam@gmail.com>,
 =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Michal Simek <michal.simek@amd.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Qu Wenruo <wqu@suse.com>,
 Stefano Babic <sbabic@denx.de>, linux-btrfs@vger.kernel.org
Subject: [PATCH 03/29] treewide: Tidy up semicolon after command macros
Date: Sat, 11 Nov 2023 17:08:48 -0700
Message-ID: <20231112000923.73568-4-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
In-Reply-To: <20231112000923.73568-1-sjg@chromium.org>
References: <20231112000923.73568-1-sjg@chromium.org>
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

The U_BOOT_CMD_COMPLETE() macro has a semicolon at the end, perhaps
inadvertently. Some code has taken advantage of this.

Tidy this up by dropping the semicolon from the macro and adding it to
macro invocations as required.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 board/freescale/common/vid.c | 2 +-
 board/xilinx/common/fru.c    | 2 +-
 board/xilinx/versal/cmds.c   | 2 +-
 board/xilinx/zynqmp/cmds.c   | 2 +-
 cmd/btrfs.c                  | 2 +-
 cmd/eeprom.c                 | 2 +-
 cmd/ext2.c                   | 4 ++--
 cmd/fs.c                     | 8 ++++----
 cmd/pinmux.c                 | 2 +-
 cmd/qfw.c                    | 2 +-
 include/command.h            | 2 +-
 11 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/board/freescale/common/vid.c b/board/freescale/common/vid.c
index 5ec3f2a76b19..fc5d400cfe18 100644
--- a/board/freescale/common/vid.c
+++ b/board/freescale/common/vid.c
@@ -793,4 +793,4 @@ U_BOOT_CMD(
 	vdd_read, 1, 0, do_vdd_read,
 	"read VDD",
 	" - Read the voltage specified in mV"
-)
+);
diff --git a/board/xilinx/common/fru.c b/board/xilinx/common/fru.c
index c916c3d6b4c8..12b21317496a 100644
--- a/board/xilinx/common/fru.c
+++ b/board/xilinx/common/fru.c
@@ -85,4 +85,4 @@ U_BOOT_CMD(
 	fru, 8, 1, do_fru,
 	"FRU table info",
 	fru_help_text
-)
+);
diff --git a/board/xilinx/versal/cmds.c b/board/xilinx/versal/cmds.c
index 9cc2cdcebf1c..2a74e49aedec 100644
--- a/board/xilinx/versal/cmds.c
+++ b/board/xilinx/versal/cmds.c
@@ -98,4 +98,4 @@ U_BOOT_LONGHELP(versal,
 U_BOOT_CMD(versal, 4, 1, do_versal,
 	   "versal sub-system",
 	   versal_help_text
-)
+);
diff --git a/board/xilinx/zynqmp/cmds.c b/board/xilinx/zynqmp/cmds.c
index f1f3eff501e1..9524688f27d9 100644
--- a/board/xilinx/zynqmp/cmds.c
+++ b/board/xilinx/zynqmp/cmds.c
@@ -427,4 +427,4 @@ U_BOOT_CMD(
 	zynqmp, 9, 1, do_zynqmp,
 	"ZynqMP sub-system",
 	zynqmp_help_text
-)
+);
diff --git a/cmd/btrfs.c b/cmd/btrfs.c
index 98daea99e9ed..2843835d08b8 100644
--- a/cmd/btrfs.c
+++ b/cmd/btrfs.c
@@ -24,4 +24,4 @@ U_BOOT_CMD(btrsubvol, 3, 1, do_btrsubvol,
 	"list subvolumes of a BTRFS filesystem",
 	"<interface> <dev[:part]>\n"
 	"     - List subvolumes of a BTRFS filesystem."
-)
+);
diff --git a/cmd/eeprom.c b/cmd/eeprom.c
index 0b6ca8c505fb..322765ad02a0 100644
--- a/cmd/eeprom.c
+++ b/cmd/eeprom.c
@@ -435,4 +435,4 @@ U_BOOT_CMD(
 	"The values which can be provided with the -l option are:\n"
 	CONFIG_EEPROM_LAYOUT_HELP_STRING"\n"
 #endif
-)
+);
diff --git a/cmd/ext2.c b/cmd/ext2.c
index 57a99516a6ac..a0ce0cf5796b 100644
--- a/cmd/ext2.c
+++ b/cmd/ext2.c
@@ -42,7 +42,7 @@ U_BOOT_CMD(
 	"list files in a directory (default /)",
 	"<interface> <dev[:part]> [directory]\n"
 	"    - list files from 'dev' on 'interface' in a 'directory'"
-)
+);
 
 U_BOOT_CMD(
 	ext2load,	6,	0,	do_ext2load,
@@ -50,4 +50,4 @@ U_BOOT_CMD(
 	"<interface> [<dev[:part]> [addr [filename [bytes [pos]]]]]\n"
 	"    - load binary file 'filename' from 'dev' on 'interface'\n"
 	"      to address 'addr' from ext2 filesystem."
-)
+);
diff --git a/cmd/fs.c b/cmd/fs.c
index 6044f73af5b4..46cb43dcdb5b 100644
--- a/cmd/fs.c
+++ b/cmd/fs.c
@@ -39,7 +39,7 @@ U_BOOT_CMD(
 	"      If 'bytes' is 0 or omitted, the file is read until the end.\n"
 	"      'pos' gives the file byte position to start reading from.\n"
 	"      If 'pos' is 0 or omitted, the file is read from the start."
-)
+);
 
 static int do_save_wrapper(struct cmd_tbl *cmdtp, int flag, int argc,
 			   char *const argv[])
@@ -56,7 +56,7 @@ U_BOOT_CMD(
 	"      'bytes' gives the size to save in bytes and is mandatory.\n"
 	"      'pos' gives the file byte position to start writing to.\n"
 	"      If 'pos' is 0 or omitted, the file is written from the start."
-)
+);
 
 static int do_ls_wrapper(struct cmd_tbl *cmdtp, int flag, int argc,
 			 char *const argv[])
@@ -70,7 +70,7 @@ U_BOOT_CMD(
 	"<interface> [<dev[:part]> [directory]]\n"
 	"    - List files in directory 'directory' of partition 'part' on\n"
 	"      device type 'interface' instance 'dev'."
-)
+);
 
 static int do_ln_wrapper(struct cmd_tbl *cmdtp, int flag, int argc,
 			 char *const argv[])
@@ -84,7 +84,7 @@ U_BOOT_CMD(
 	"<interface> <dev[:part]> target linkname\n"
 	"    - create a symbolic link to 'target' with the name 'linkname' on\n"
 	"      device type 'interface' instance 'dev'."
-)
+);
 
 static int do_fstype_wrapper(struct cmd_tbl *cmdtp, int flag, int argc,
 			     char *const argv[])
diff --git a/cmd/pinmux.c b/cmd/pinmux.c
index f17cf4110d9f..105f01eaafff 100644
--- a/cmd/pinmux.c
+++ b/cmd/pinmux.c
@@ -178,4 +178,4 @@ U_BOOT_CMD(pinmux, CONFIG_SYS_MAXARGS, 1, do_pinmux,
 	   "list                     - list UCLASS_PINCTRL devices\n"
 	   "pinmux dev [pincontroller-name] - select pin-controller device\n"
 	   "pinmux status [-a | pin-name]   - print pin-controller muxing [for all | for pin-name]\n"
-)
+);
diff --git a/cmd/qfw.c b/cmd/qfw.c
index d6ecfa60d5a7..1b8c775ebf5a 100644
--- a/cmd/qfw.c
+++ b/cmd/qfw.c
@@ -121,4 +121,4 @@ U_BOOT_CMD(
 	"    - list                             : print firmware(s) currently loaded\n"
 	"    - cpus                             : print online cpu number\n"
 	"    - load <kernel addr> <initrd addr> : load kernel and initrd (if any), and setup for zboot\n"
-)
+);
diff --git a/include/command.h b/include/command.h
index 6262365e128f..5bd3ecbe8f91 100644
--- a/include/command.h
+++ b/include/command.h
@@ -390,7 +390,7 @@ int cmd_source_script(ulong addr, const char *fit_uname, const char *confname);
 #define U_BOOT_CMD_COMPLETE(_name, _maxargs, _rep, _cmd, _usage, _help, _comp) \
 	ll_entry_declare(struct cmd_tbl, _name, cmd) =			\
 		U_BOOT_CMD_MKENT_COMPLETE(_name, _maxargs, _rep, _cmd,	\
-						_usage, _help, _comp);
+						_usage, _help, _comp)
 
 #define U_BOOT_CMDREP_COMPLETE(_name, _maxargs, _cmd_rep, _usage,	\
 			       _help, _comp)				\
-- 
2.42.0.869.gea05f2083d-goog

