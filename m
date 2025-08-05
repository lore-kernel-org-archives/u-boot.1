Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B476EC87FCB
	for <u-boot@archiver.kernel.org>; Tue,  5 Aug 2025 05:46:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BEF1B8349B;
	Tue,  5 Aug 2025 07:46:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="XYURNS15";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E66F983807; Tue,  5 Aug 2025 07:46:20 +0200 (CEST)
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 53D49832F9
 for <u-boot@lists.denx.de>; Tue,  5 Aug 2025 07:46:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT03.fritz.box (ip-005-147-080-091.um06.pools.vodafone-ip.de
 [5.147.80.91])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 71AF040194; 
 Tue,  5 Aug 2025 05:46:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1754372777;
 bh=qX3Upoyi2E//eVoOl8FG+Q2dmkQEHf5dUuAzJcV4Sm0=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=XYURNS15lqiaF7MLUWpDK4IY51Uke6GyDtfSK2V+3ADMuII4xNRdlBC9IRCVVmDOZ
 1v5Pdjg7hvqxaH615ovgyGMauuLwk4OJISKJgnZ2WQ4NzJKslYy7OfHebP2E4ekYNx
 fGnqpivb3RS9FpjlD+0zJXmjNDbak/OTHAFqWY6KkYrpGHC6rqId9+EDYb+OjPF8HU
 GRqq7/538QlOEnZ2jirNUI4FKFt0abxRFmsN0Dvi6V1LAbK7RjslZ+0CU6NdicH9TT
 IIiAcZvtoFiPNPm8Q6W26UfYBv7R1yy01BntlKg1WG4IsYiQiqGRfPbUdS0gvjTwEA
 +I1jfe2GifMlA==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Adriano Cordova <adrianox@gmail.com>, Mark Kettenis <kettenis@openbsd.org>,
 u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH v2 1/1] efi_loader: Support loading a ramdisk with bootefi
Date: Tue,  5 Aug 2025 07:46:14 +0200
Message-ID: <20250805054614.5555-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.50.0
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

It is sometimes useful to be able to boot via EFI using a Linux initrd.
Add support for this.

Fix a 'specifiy' typo while here.

Signed-off-by: Simon Glass <sjg@chromium.org>
Reviewed-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
v2:
	consistently refer to Linux initrd instead of RAM disk
---
 cmd/bootefi.c             | 33 +++++++++++++++++++++++++--------
 doc/usage/cmd/bootefi.rst | 37 ++++++++++++++++++++++++++++++-------
 2 files changed, 55 insertions(+), 15 deletions(-)

diff --git a/cmd/bootefi.c b/cmd/bootefi.c
index 8e8752127ed..b8f5bb35950 100644
--- a/cmd/bootefi.c
+++ b/cmd/bootefi.c
@@ -136,22 +136,39 @@ static int do_bootefi(struct cmd_tbl *cmdtp, int flag, int argc,
 {
 	efi_status_t ret;
 	char *p;
-	void *fdt, *image_buf;
-	unsigned long addr, size;
+	void *fdt, *initrd = NULL, *image_buf;
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
+			initrd = map_sysmem(rd_addr, rd_len);
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
+	ret = efi_binary_run(image_buf, size, fdt, initrd, rd_len);
 
 	if (ret != EFI_SUCCESS)
 		return CMD_RET_FAILURE;
@@ -224,7 +241,7 @@ static int do_bootefi(struct cmd_tbl *cmdtp, int flag, int argc,
 }
 
 U_BOOT_LONGHELP(bootefi,
-	"<image address>[:<image size>] [<fdt address>]\n"
+	"<image address>[:<size>] [<initrd address>:<size>] [<fdt address>]\n"
 	"  - boot EFI payload\n"
 #ifdef CONFIG_CMD_BOOTEFI_HELLO
 	"bootefi hello\n"
diff --git a/doc/usage/cmd/bootefi.rst b/doc/usage/cmd/bootefi.rst
index d6e4e62e383..7c5448586b7 100644
--- a/doc/usage/cmd/bootefi.rst
+++ b/doc/usage/cmd/bootefi.rst
@@ -12,7 +12,7 @@ Synopsis
 
 ::
 
-    bootefi <image_addr>[:<image_size>] [<fdt_addr>]
+    bootefi <image_addr>[:<image_size>] [<initrd_addr>:<initrd_size>] [<fdt_address>]
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
+    load mmc 0:1 $initrd_addr_r intird
+    bootefi $kernel_addr_r $initrd_addr_r:$filesize $fdt_addr_r
+
 The last UEFI binary loaded defines the image file path in the loaded image
 protocol.
 
@@ -51,21 +61,34 @@ The value of the environment variable *bootargs* is converted from UTF-8 to
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
 
+initrd_addr
+    Address of the Linux initial RAM disk or '-'. If no address is specified,
+    no RAM disk is used when booting.
+
+initrd_size
+    Size of the Linux initial RAM disk.
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
2.50.0

