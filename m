Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FEC8C71136
	for <u-boot@archiver.kernel.org>; Mon, 16 Jun 2025 06:39:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C4BE681E18;
	Mon, 16 Jun 2025 08:39:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="O2bgRFWK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3200782063; Mon, 16 Jun 2025 08:39:32 +0200 (CEST)
Received: from smtp-relay-canonical-1.canonical.com
 (smtp-relay-canonical-1.canonical.com [185.125.188.121])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1917381E06
 for <u-boot@lists.denx.de>; Mon, 16 Jun 2025 08:39:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.. (dynamic-046-114-107-162.46.114.pool.telefonica.de
 [46.114.107.162])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 9A79541AD6; 
 Mon, 16 Jun 2025 06:39:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1750055968;
 bh=HQFV77ZoFMgeU8k/IqIC1lLaK9+LW040qOdlcF2gdwM=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=O2bgRFWKx7WsIFeMozT7Shr8RlwfhBRcD1d+pT1GHTZQskuf0z/mbopjwq4yOLruV
 oO/VXAVlvvmB93GM8p1VdO/DbK8ou9Lgs96AJrtu+8hK/hFASj/QapR2414syEspEA
 1R53KydEetUlfjM6rqWEE+GREyclsc4raWrzRENFODd3jsGZccFMF+TUyuAiaxI6cM
 APiq6qykn9A7ZUXy7LXDJ6uHznIz96JAfredqhL3ne2NxqSS4Cp9oRblnZOOimWSMk
 1erUFzh7NLzHYPOrPjvzSfz4d7ZbxaSUYLJZRLklQcpAy5E3y5v6/JabvisnuXNsqF
 wVe6TIeFqj2RA==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Simon Glass <sjg@chromium.org>, Adriano Cordova <adrianox@gmail.com>,
 u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] efi_loader: Support loading a ramdisk with bootefi
Date: Mon, 16 Jun 2025 08:39:22 +0200
Message-ID: <20250616063922.9882-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.48.1
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

From: Simon Glass <sjg@chromium.org>

It is sometimes useful to be able to boot via EFI using a ramdisk. Add
support for this.

Fix a 'specifiy' typo while here.

Signed-off-by: Simon Glass <sjg@chromium.org>
Reviewed-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 cmd/bootefi.c             | 33 +++++++++++++++++++++++++--------
 doc/usage/cmd/bootefi.rst | 38 +++++++++++++++++++++++++++++++-------
 2 files changed, 56 insertions(+), 15 deletions(-)

diff --git a/cmd/bootefi.c b/cmd/bootefi.c
index 8e8752127ed..db1eb4f1dbf 100644
--- a/cmd/bootefi.c
+++ b/cmd/bootefi.c
@@ -136,22 +136,39 @@ static int do_bootefi(struct cmd_tbl *cmdtp, int flag, int argc,
 {
 	efi_status_t ret;
 	char *p;
-	void *fdt, *image_buf;
-	unsigned long addr, size;
+	void *fdt, *ramdisk = NULL, *image_buf;
+	unsigned long addr, size, rd_len = 0, fdt_addr = 0;
 	void *image_addr;
 	size_t image_size;
+	int fdt_arg = 2;
 
 	if (argc < 2)
 		return CMD_RET_USAGE;
 
 	if (argc > 2) {
-		uintptr_t fdt_addr;
+		ulong rd_addr = 0;
+		char *end = strchr(argv[2], ':');
 
-		fdt_addr = hextoul(argv[2], NULL);
+		if (end) {
+			rd_addr = hextoul(argv[2], NULL);
+			if (!rd_addr)
+				return CMD_RET_USAGE;
+
+			rd_len = hextoul(++end, NULL);
+			ramdisk = map_sysmem(rd_addr, rd_len);
+			++fdt_arg;
+		}
+	}
+
+	if (argc > fdt_arg + 1)
+		return CMD_RET_USAGE;
+	if (argc == fdt_arg + 1)
+		fdt_addr = hextoul(argv[fdt_arg], NULL);
+
+	if (fdt_addr)
 		fdt = map_sysmem(fdt_addr, 0);
-	} else {
+	else
 		fdt = EFI_FDT_USE_INTERNAL;
-	}
 
 	if (IS_ENABLED(CONFIG_CMD_BOOTEFI_BOOTMGR) &&
 	    !strcmp(argv[1], "bootmgr")) {
@@ -215,7 +232,7 @@ static int do_bootefi(struct cmd_tbl *cmdtp, int flag, int argc,
 		}
 	}
 
-	ret = efi_binary_run(image_buf, size, fdt, NULL, 0);
+	ret = efi_binary_run(image_buf, size, fdt, ramdisk, rd_len);
 
 	if (ret != EFI_SUCCESS)
 		return CMD_RET_FAILURE;
@@ -224,7 +241,7 @@ static int do_bootefi(struct cmd_tbl *cmdtp, int flag, int argc,
 }
 
 U_BOOT_LONGHELP(bootefi,
-	"<image address>[:<image size>] [<fdt address>]\n"
+	"<image address>[:<image size>] [<ramdisk_address>:<size>] [<fdt address>]\n"
 	"  - boot EFI payload\n"
 #ifdef CONFIG_CMD_BOOTEFI_HELLO
 	"bootefi hello\n"
diff --git a/doc/usage/cmd/bootefi.rst b/doc/usage/cmd/bootefi.rst
index d6e4e62e383..b78a9c61331 100644
--- a/doc/usage/cmd/bootefi.rst
+++ b/doc/usage/cmd/bootefi.rst
@@ -12,7 +12,7 @@ Synopsis
 
 ::
 
-    bootefi <image_addr>[:<image_size>] [<fdt_addr>]
+    bootefi <image_addr>[:<image_size>] [<ramdisk_addr>:<ramdisk_size>] [<fdt_address>]
     bootefi bootmgr [<fdt_addr>]
     bootefi hello [<fdt_addr>]
     bootefi selftest [<fdt_addr>]
@@ -44,6 +44,16 @@ command sequence to run a UEFI application might look like
     load mmc 0:1 $kernel_addr_r /EFI/grub/grubaa64.efi
     bootefi $kernel_addr_r $fdt_addr_r
 
+or
+
+::
+
+    setenv bootargs root=/dev/vda1
+    load mmc 0:1 $fdt_addr_r dtb
+    load mmc 0:1 $kernel_addr_r vmlinux
+    load mmc 0:1 $ramdisk_addr_r intird
+    bootefi $kernel_addr_r $ramdisk_addr_r:$filesize $fdt_addr_r
+
 The last UEFI binary loaded defines the image file path in the loaded image
 protocol.
 
@@ -51,21 +61,35 @@ The value of the environment variable *bootargs* is converted from UTF-8 to
 UTF-16 and passed as load options in the loaded image protocol to the UEFI
 binary.
 
+.. note::
+
+    The bootefi command accepts one to three arguments.
+    If the second argument contains a colon ':', it is assumed to specify the
+    initial RAM disk.
+
 image_addr
     Address of the UEFI binary.
 
-fdt_addr
-    Address of the device-tree or '-'. If no address is specifiy, the
-    environment variable $fdt_addr is used as first fallback, the address of
-    U-Boot's internal device-tree $fdtcontroladdr as second fallback.
-    When using ACPI no device-tree shall be specified.
-
 image_size
     Size of the UEFI binary file. This argument is only needed if *image_addr*
     does not match the address of the last loaded UEFI binary. In this case
     a memory device path will be used as image file path in the loaded image
     protocol.
 
+ramdisk_addr
+    Address of the ramdisk or '-'. If no address is specified, a ramdisk is not
+    used when booting.
+
+ramdisk_size
+    Address of the ramdisk or '-'. If no address is specified, a ramdisk is not
+    used when booting.
+
+fdt_addr
+    Address of the device-tree or '-'. If no address is specified, the
+    environment variable $fdt_addr is used as first fallback, the address of
+    U-Boot's internal device-tree $fdtcontroladdr as second fallback.
+    When using ACPI no device-tree shall be specified.
+
 Note
     UEFI binaries that are contained in FIT images are launched via the
     *bootm* command.
-- 
2.48.1

