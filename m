Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8492C47071
	for <u-boot@archiver.kernel.org>; Thu, 16 Nov 2023 04:12:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AEF9B87488;
	Thu, 16 Nov 2023 05:11:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="meOUrT2L";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A2A43870D2; Thu, 16 Nov 2023 05:11:25 +0100 (CET)
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com
 [IPv6:2607:f8b0:4864:20::d2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 881168725C
 for <u-boot@lists.denx.de>; Thu, 16 Nov 2023 05:11:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2a.google.com with SMTP id
 ca18e2360f4ac-7a92727934eso12980439f.3
 for <u-boot@lists.denx.de>; Wed, 15 Nov 2023 20:11:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1700107882; x=1700712682; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ws8Tm5uicxdZKwKLVxHx7X5iHURGQOqIcEnBacXPka0=;
 b=meOUrT2LJKc0bfLz7hafSBdpZ3Ic2NckllGdC3UDhB88dgoIcMjGbKjT3wQhA9WGVn
 JoKU+xATBxFkzZGs3JCs5OLDVP2QHZYBxxCr1uR5j7Fv+aX19x8Iauou2Oyr9fliH6sj
 cquThIajAQ+yUxSVI+G0G5/2Edp+9Cd/ZxKeA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700107882; x=1700712682;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ws8Tm5uicxdZKwKLVxHx7X5iHURGQOqIcEnBacXPka0=;
 b=sJG7yhN7tCUOq/4ys1l8s9DD5R+wB6b+c11pY+VaUXyM5lGnMMf7lmJEtayHifvauI
 8wAo+EeTBRW0uXmt++B7BGa1UiufckayZA9W35wpykooFBd6Dqsnc4IVJLb1aXPjusAQ
 J9XlehpmwGH1U7c352A9eMzW6zm0oWkkVAP/Fa14u6I4qiF7yvfBg5YqUrsKV64myCq9
 /3Lvd3HdJFJ24JCXobsrl0divlTv+vLeJ6MjOjp/zxsRqenBkOwHsd6bu2ahjz/yv9Xi
 mEaLC7Ep4pAFjx6w3pdXa9g8fxUP544SDY9YBXiwhPs1msrsuIqVBRI2ys3W1yj7DM5G
 vzqw==
X-Gm-Message-State: AOJu0YzAguTb74V9x9m/bHIUv0ndwzJR0wadOHGU3Dlr+HPiHw6X/2bk
 dKk5VeAgwkelXBv2PtpV5WgMbCL5Fk/XLqKp6JRTRw==
X-Google-Smtp-Source: AGHT+IHddw6XYFtUxtkVUoPCB138MBNzh8uAFlMlRuJODj1bu9r85i3mF5SjuSye7sx2DDE0fPxJrw==
X-Received: by 2002:a05:6602:2e93:b0:792:8c52:b3b8 with SMTP id
 m19-20020a0566022e9300b007928c52b3b8mr24654676iow.14.1700107882040; 
 Wed, 15 Nov 2023 20:11:22 -0800 (PST)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 f3-20020a02a803000000b0045a1063713asm1307527jaj.130.2023.11.15.20.11.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Nov 2023 20:11:21 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>, Baruch Siach <baruch@tkos.co.il>,
 Bin Meng <bmeng.cn@gmail.com>, Evgeny Bachinin <EABachinin@sberdevices.ru>,
 Fabio Estevam <festevam@gmail.com>,
 =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Michal Simek <michal.simek@amd.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Qu Wenruo <wqu@suse.com>,
 Stefano Babic <sbabic@denx.de>, linux-btrfs@vger.kernel.org
Subject: [PATCH v2 04/32] treewide: Tidy up semicolon after command macros
Date: Wed, 15 Nov 2023 21:10:04 -0700
Message-ID: <20231116041043.362055-5-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0.rc0.421.g78406f8d94-goog
In-Reply-To: <20231116041043.362055-1-sjg@chromium.org>
References: <20231116041043.362055-1-sjg@chromium.org>
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
Reviewed-by: Tom Rini <trini@konsulko.com>
---

(no changes since v1)

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
2.43.0.rc0.421.g78406f8d94-goog

