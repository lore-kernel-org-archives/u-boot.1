Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 710F3C43458
	for <u-boot@archiver.kernel.org>; Wed,  8 Jul 2026 19:31:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CD6A38496E;
	Wed,  8 Jul 2026 21:31:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="hABUYLUX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EE0838497A; Wed,  8 Jul 2026 21:31:34 +0200 (CEST)
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com
 [IPv6:2607:f8b0:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2E9F08407E
 for <u-boot@lists.denx.de>; Wed,  8 Jul 2026 21:31:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=james.hilliard1@gmail.com
Received: by mail-ot1-x32d.google.com with SMTP id
 46e09a7af769-7eb64085c45so678912a34.2
 for <u-boot@lists.denx.de>; Wed, 08 Jul 2026 12:31:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783539091; x=1784143891; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Uxzsh7WC411Hhi3+KIjWN7BMsZryYhwilTJ7EusQ5oY=;
 b=hABUYLUXs4No42ppg6Q4NXsgYbKsAhMLw4TwTv2NLSHcuccqRBCemqTXWSkPqy27+D
 3AgOMVY1q0dhXFqYQyOMzaGPBH7PPZL6vLUGZxsuzVKzC0B2V6doE0DzGrn3flKeBRCE
 u4AgEvcmGT6oCFqmaW2d8K/5/PV5o+mhdiE8F1Va4ItrPTiiAE6f65W7QqOt258dBEl/
 soLcMXjX7+r6073HmJQ2CHIQyeq4j1wutAg02AjuvNRF87edhraV9OLo76/wAvyZLF4s
 HGO7q2DDz0/ToAPMFgp9gi0FwmpKqlBFte8h0XF+Otmb7A2wkv1PmckD+UWlUb3InOqv
 K1nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783539091; x=1784143891;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Uxzsh7WC411Hhi3+KIjWN7BMsZryYhwilTJ7EusQ5oY=;
 b=MT/fwylS1DgHwvjDYGd53QK/RbmxBAMWoLp023tS5TQ+N6PvaHziSjhe1wtm89tCTn
 pKhyvcXH3i6s52DNqRWu7wFCdkKXQ3rf00eVOctNdX0fM9Dk4D2HB5qP4A11BFvds1+8
 YjN+qJe4g8vQoBI97y9wFCKWHV/RZyXESMXR37ldzplRfYuGLJvKlSaWnI0oKO1wlRpl
 3EobuBl7LSJnGgPtcPF/ZtcWNqeTDrwO5DW1I/ZRKCBrXUtUdiZlVg34EJQd2iN7f1u9
 8SMU4jPKsjyE/TM/Md1QMbcNHVd8/eA9L6Djun9ZJwu/DYsMZrFCTmPndeew8tTlzjiy
 rRBw==
X-Gm-Message-State: AOJu0YwPsU+7sIGnWx/GzkSCGE/ey+2Qv4sTnF7t7VY7LHrZCFL7lG9I
 Q0/cEM+D5Px48DW0qQGHD9++v2i3NjKGTcQxIeajMG5IJ3+7qL2GLCMa6unbQpuw/yCOWQ==
X-Gm-Gg: AfdE7cmcwFbMCY3ewr3EU9I9Z3LHn3zCic+cTPPggwoCK0iVV/Pjx/W6whDGt/E0WC1
 fLFkQmqf+46BOTPO8Gtu5WFE/hacCJjptspX93n6LEo0fnhWUkIEvCXBvrtgIaeDSwVzWnv38Aw
 LS32aLMh2haW26HFNqjQp972pqQHNHKTM/Z03o6sb3knRccMtLGT4oAdVHobd7vK5QuVNJzcBA1
 bBokC6rZeQDdESpRuWXz5pwvGciNsubJNbUYF3zaIGS3khzAr1PyjVGhSTR81BLmyDGdOJerV6V
 YKXuE/gvEIytAU6cfwAZ+aMc5KvIInlqk5lrkAK+LWEehSA3InmRkkScXqFkb9D448J3iykVBHT
 OYUPxCowFz87sdwsSTIL/pWKF5nvgKc72BSkbd1rXI+G5igVLyUTcoe5HNbaYEq9AvFE61wzJeE
 11Cex/LRrmWSgXxYUgJIrUERgrs7JTTDv33bbp393h72g4nUSE1y04nRm8jdeuJy+9XpSOrsuds
 QICUpYN8ODE2VDuM+6i/uCJ2fIqgR4kGE0NrVRW2NTRoPurjB+vgFmcTKId1veZO3q+D4OuDfFJ
 qCwxFDMgpA==
X-Received: by 2002:a05:6830:258a:b0:7e9:dbbe:5af4 with SMTP id
 46e09a7af769-7ebd0030c18mr2890001a34.32.1783539090144; 
 Wed, 08 Jul 2026 12:31:30 -0700 (PDT)
Received: from james-x399.tailafd1a.ts.net (174-29-11-8.hlrn.qwest.net.
 [174.29.11.8]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7ebcb262ddfsm2513648a34.14.2026.07.08.12.31.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Jul 2026 12:31:29 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
To: u-boot@lists.denx.de
Cc: James Hilliard <james.hilliard1@gmail.com>, Tom Rini <trini@konsulko.com>,
 Jerome Forissier <jerome.forissier@arm.com>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, Simon Glass <sjg@chromium.org>,
 "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Johan Jonker <jbx6244@gmail.com>, Heiko Schocher <hs@nabladev.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Yuya Hamamachi <yuya.hamamachi.sx@renesas.com>,
 Benjamin Hahn <B.Hahn@phytec.de>, Pranav Tilak <pranav.vinaytilak@amd.com>,
 Jonas Karlman <jonas@kwiboo.se>, Pranav Sanwal <pranav.sanwal@amd.com>,
 Peter Robinson <pbrobinson@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: [PATCH v4] net: lwip: add tftpsrv command
Date: Wed,  8 Jul 2026 13:31:17 -0600
Message-ID: <20260708193123.2557776-1-james.hilliard1@gmail.com>
X-Mailer: git-send-email 2.53.0
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

The legacy network stack supports tftpsrv, which listens for an
incoming TFTP write request and receives the first file into memory.
Despite the old command help wording, the command returns after
receiving the file and does not boot it automatically.

The lwIP stack already builds the lwIP TFTP application, but only wires
it up for client-side tftpboot. Add a lwIP tftpsrv command and
implement the server path with tftp_init_server(). Reuse the existing
lwIP TFTP write callback and memory copy path so LMB checks, progress
output, filesize/fileaddr updates and EFI bootdev handling stay
consistent with tftpboot.

Track receive timeout and write-failure state around the lwIP callbacks
so a stalled or rejected receive is not reported as a successful close.

Move CMD_TFTPSRV out of the legacy-only Kconfig block so it can be
enabled with either network stack. Update the command help text and add
usage documentation for the receive-only behavior.

Add pytest coverage for tftpsrv using a generated host file and curl's
TFTP upload support. Enable the command in qemu_arm64_lwip_defconfig so
the test can be run with the existing lwIP QEMU build when the boardenv
provides env__net_tftpsrv_file.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
Changes v3 -> v4:
  - Match lwIP TFTP filename length with legacy TFTP
  - Keep the server transfer context on the stack
  - Use the existing net_lwip_eth_stop() helper after tftpsrv exits

Changes v2 -> v3:
  - Use an explicit TFTPSRV_LISTEN_TIMEOUT_MS value
  - Allocate the server transfer context dynamically
  - Halt the lwIP Ethernet device after tftpsrv exits

Changes v1 -> v2:
  - Add tftpsrv usage documentation  (suggested by Quentin Schulz)
  - Add tftpsrv pytest coverage  (suggested by Quentin Schulz)
  - Enable CMD_TFTPSRV in qemu_arm64_lwip_defconfig
  - Allow tftpsrv pytest coverage to use an explicit upload URL
  - Keep tftpsrv pytest coverage gated by env__net_tftpsrv_file
  - Clarify that tftpsrv returns after receiving instead of booting
  - Update legacy and lwIP command help text for receive-only behavior
---
 cmd/Kconfig                       |  14 ++-
 cmd/lwip/Makefile                 |   1 +
 cmd/lwip/tftpsrv.c                |  11 ++
 cmd/net.c                         |   4 +-
 configs/qemu_arm64_lwip_defconfig |   1 +
 doc/usage/cmd/tftpsrv.rst         |  73 ++++++++++++
 include/net-lwip.h                |   1 +
 lib/lwip/u-boot/lwipopts.h        |  11 ++
 net/lwip/tftp.c                   | 188 +++++++++++++++++++++++++++++-
 test/py/tests/test_net.py         |  94 +++++++++++++++
 10 files changed, 385 insertions(+), 13 deletions(-)
 create mode 100644 cmd/lwip/tftpsrv.c
 create mode 100644 doc/usage/cmd/tftpsrv.rst

diff --git a/cmd/Kconfig b/cmd/Kconfig
index ca1039f6a03..c9a6c7c33a2 100644
--- a/cmd/Kconfig
+++ b/cmd/Kconfig
@@ -2134,12 +2134,6 @@ config CMD_TFTPPUT
 	help
 	  TFTP put command, for uploading files to a server
 
-config CMD_TFTPSRV
-	bool "tftpsrv"
-	depends on CMD_TFTPBOOT
-	help
-	  Act as a TFTP server and boot the first received file
-
 config NET_TFTP_VARS
 	bool "Control TFTP timeout and count through environment"
 	depends on CMD_TFTPBOOT
@@ -2286,6 +2280,14 @@ config CMD_TFTPBOOT
 	help
 	  tftpboot - load file via network using TFTP protocol
 
+config CMD_TFTPSRV
+	bool "tftpsrv"
+	depends on CMD_TFTPBOOT
+	help
+	  Act as a TFTP server and receive the first incoming file into
+	  memory. The command returns successfully after the transfer so
+	  boot scripts can boot the received image from the load address.
+
 config CMD_WGET
 	bool "wget"
 	default y if SANDBOX || ARCH_QEMU
diff --git a/cmd/lwip/Makefile b/cmd/lwip/Makefile
index 90df1f5511c..245683a9672 100644
--- a/cmd/lwip/Makefile
+++ b/cmd/lwip/Makefile
@@ -4,4 +4,5 @@ obj-$(CONFIG_CMD_NFS) += nfs.o
 obj-$(CONFIG_CMD_PING) += ping.o
 obj-$(CONFIG_CMD_SNTP) += sntp.o
 obj-$(CONFIG_CMD_TFTPBOOT) += tftp.o
+obj-$(CONFIG_CMD_TFTPSRV) += tftpsrv.o
 obj-$(CONFIG_CMD_WGET) += wget.o
diff --git a/cmd/lwip/tftpsrv.c b/cmd/lwip/tftpsrv.c
new file mode 100644
index 00000000000..6370c900489
--- /dev/null
+++ b/cmd/lwip/tftpsrv.c
@@ -0,0 +1,11 @@
+// SPDX-License-Identifier: GPL-2.0+
+
+#include <command.h>
+#include <net.h>
+
+U_BOOT_CMD(tftpsrv, 2, 1, do_tftpsrv,
+	   "act as a TFTP server and receive the first file",
+	   "[loadAddress]\n"
+	   "Listen for an incoming TFTP transfer and receive a file into memory.\n"
+	   "The transfer is aborted if a transfer has not been started after\n"
+	   "about 50 seconds or if Ctrl-C is pressed.");
diff --git a/cmd/net.c b/cmd/net.c
index f6f556f36ae..0f0b2386d87 100644
--- a/cmd/net.c
+++ b/cmd/net.c
@@ -89,9 +89,9 @@ static int do_tftpsrv(struct cmd_tbl *cmdtp, int flag, int argc,
 
 U_BOOT_CMD(
 	tftpsrv,	2,	1,	do_tftpsrv,
-	"act as a TFTP server and boot the first received file",
+	"act as a TFTP server and receive the first file",
 	"[loadAddress]\n"
-	"Listen for an incoming TFTP transfer, receive a file and boot it.\n"
+	"Listen for an incoming TFTP transfer and receive a file into memory.\n"
 	"The transfer is aborted if a transfer has not been started after\n"
 	"about 50 seconds or if Ctrl-C is pressed."
 );
diff --git a/configs/qemu_arm64_lwip_defconfig b/configs/qemu_arm64_lwip_defconfig
index a974970c3d3..06ed5a131db 100644
--- a/configs/qemu_arm64_lwip_defconfig
+++ b/configs/qemu_arm64_lwip_defconfig
@@ -7,6 +7,7 @@ CONFIG_NET_LWIP=y
 CONFIG_CMD_DNS=y
 CONFIG_CMD_NFS=y
 CONFIG_CMD_SNTP=y
+CONFIG_CMD_TFTPSRV=y
 CONFIG_CMD_WGET=y
 CONFIG_EFI_HTTP_BOOT=y
 CONFIG_WGET_HTTPS=y
diff --git a/doc/usage/cmd/tftpsrv.rst b/doc/usage/cmd/tftpsrv.rst
new file mode 100644
index 00000000000..597a2f3a8bd
--- /dev/null
+++ b/doc/usage/cmd/tftpsrv.rst
@@ -0,0 +1,73 @@
+.. SPDX-License-Identifier: GPL-2.0+:
+
+.. index::
+   single: tftpsrv (command)
+
+tftpsrv command
+===============
+
+Synopsis
+--------
+
+::
+
+    tftpsrv [loadAddress]
+
+Description
+-----------
+
+The tftpsrv command listens for an incoming TFTP write request and receives
+the first transferred file into memory.
+
+loadAddress
+    memory address where the received file is stored. If not provided, the
+    address is taken from the *loadaddr* environment variable or the default
+    image load address.
+
+After a successful transfer, the *fileaddr* and *filesize* environment
+variables describe the received file. The command returns successfully after
+the transfer has completed. It does not boot the file automatically; boot
+scripts can use commands such as bootm, booti or bootefi to boot from the
+load address.
+
+The transfer is aborted if no transfer has started after about 50 seconds or
+if Ctrl-C is pressed.
+
+Example
+-------
+
+In the example the following steps are executed:
+
+* setup the board network address
+* receive a FIT image from a host
+* boot the received FIT image
+
+::
+
+    => setenv autoload no
+    => dhcp
+    BOOTP broadcast 1
+    DHCP client bound to address 192.168.1.40 (7 ms)
+    => tftpsrv $loadaddr
+    Using ethernet@1c30000 device
+    Listening for TFTP transfer on 192.168.1.40
+    Load address: 0x42000000
+    Loading: #################################################################
+             6.5 MiB/s
+    done
+    Bytes transferred = 1048576 (100000 hex)
+    => bootm $fileaddr
+
+On the host, send the file to the board while U-Boot is listening:
+
+::
+
+    $ curl --upload-file image.fit tftp://192.168.1.40/image.fit
+
+Configuration
+-------------
+
+The command is only available if CONFIG_CMD_TFTPSRV=y.
+
+The command is supported by both the legacy network stack and the lwIP network
+stack.
diff --git a/include/net-lwip.h b/include/net-lwip.h
index 5d0627eb271..8e59a2299e0 100644
--- a/include/net-lwip.h
+++ b/include/net-lwip.h
@@ -53,6 +53,7 @@ bool wget_validate_uri(char *uri);
 
 int do_dns(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[]);
 int do_nfs(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[]);
+int do_tftpsrv(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[]);
 int do_wget(struct cmd_tbl *cmdtp, int flag, int argc, char * const argv[]);
 
 #endif /* __NET_LWIP_H__ */
diff --git a/lib/lwip/u-boot/lwipopts.h b/lib/lwip/u-boot/lwipopts.h
index 8dae004f1a2..1c1adc57c6b 100644
--- a/lib/lwip/u-boot/lwipopts.h
+++ b/lib/lwip/u-boot/lwipopts.h
@@ -72,6 +72,17 @@
 #define PBUF_POOL_RESERVE               4
 #define TFTP_BLOCKSIZE_THRESHOLD        4096
 
+/*
+ * Match the legacy U-Boot TFTP filename buffer. The legacy
+ * CONFIG_TFTP_FILE_NAME_MAX_LEN value is a buffer size including the trailing
+ * NUL, while lwIP's TFTP_MAX_FILENAME_LEN is the usable string length.
+ */
+#ifdef CONFIG_TFTP_FILE_NAME_MAX_LEN
+#define TFTP_MAX_FILENAME_LEN		(CONFIG_TFTP_FILE_NAME_MAX_LEN - 1)
+#else
+#define TFTP_MAX_FILENAME_LEN		127
+#endif
+
 #if defined(CONFIG_TFTP_BLOCKSIZE) && (CONFIG_TFTP_BLOCKSIZE > TFTP_BLOCKSIZE_THRESHOLD)
 #define PBUF_POOL_SIZE			(((CONFIG_TFTP_BLOCKSIZE + (IP_FRAG_MTU_USABLE - 1)) / \
 					  IP_FRAG_MTU_USABLE) + PBUF_POOL_HEADROOM)
diff --git a/net/lwip/tftp.c b/net/lwip/tftp.c
index 571c38172f9..d6a9f29a260 100644
--- a/net/lwip/tftp.c
+++ b/net/lwip/tftp.c
@@ -11,6 +11,7 @@
 #include <linux/delay.h>
 #include <linux/kconfig.h>
 #include <lwip/apps/tftp_client.h>
+#include <lwip/apps/tftp_server.h>
 #include <lwip/timeouts.h>
 #include <mapmem.h>
 #include <net.h>
@@ -19,6 +20,8 @@
 #define PROGRESS_PRINT_STEP_BYTES (10 * 1024)
 /* Max time to wait for first data packet from server */
 #define NO_RSP_TIMEOUT_MS 10000
+/* Max time to wait for an incoming TFTP write request */
+#define TFTPSRV_LISTEN_TIMEOUT_MS 50000
 
 enum done_state {
 	NOT_DONE = 0,
@@ -34,8 +37,31 @@ struct tftp_ctx {
 	ulong hash_count;
 	ulong start_time;
 	enum done_state done;
+	bool is_server;
+	bool wrq_accepted;
+	char fname[TFTP_MAX_FILENAME_LEN + 1];
 };
 
+/*
+ * The lwIP TFTP server open callback has no user-data argument. Keep the
+ * current server context here so tftp_open() can return it.
+ */
+static struct tftp_ctx *tftpsrv_active_ctx;
+
+static void transfer_timeout(void *arg)
+{
+	struct tftp_ctx *ctx = (struct tftp_ctx *)arg;
+
+	printf("Timeout!\n");
+	ctx->done = FAILURE;
+}
+
+static void restart_transfer_timeout(struct tftp_ctx *ctx)
+{
+	sys_untimeout(transfer_timeout, ctx);
+	sys_timeout(TFTP_TIMEOUT_MSECS, transfer_timeout, ctx);
+}
+
 /**
  * store_block() - copy received data
  *
@@ -71,7 +97,7 @@ static int store_block(struct tftp_ctx *ctx, void *src, u16_t len)
 	ctx->size += len;
 	ctx->block_count++;
 
-	tftp_tsize = tftp_client_get_tsize();
+	tftp_tsize = ctx->is_server ? 0 : tftp_client_get_tsize();
 	if (tftp_tsize) {
 		pos = clamp(ctx->size, 0UL, tftp_tsize);
 
@@ -92,7 +118,20 @@ static int store_block(struct tftp_ctx *ctx, void *src, u16_t len)
 
 static void *tftp_open(const char *fname, const char *mode, u8_t is_write)
 {
-	return NULL;
+	struct tftp_ctx *ctx = tftpsrv_active_ctx;
+
+	if (!IS_ENABLED(CONFIG_CMD_TFTPSRV) || !ctx || !is_write)
+		return NULL;
+
+	ctx->wrq_accepted = true;
+	ctx->start_time = get_timer(0);
+	snprintf(ctx->fname, sizeof(ctx->fname), "%s", fname);
+	restart_transfer_timeout(ctx);
+
+	printf("\nReceiving '%s' mode '%s'\n", fname, mode);
+	puts("Loading: ");
+
+	return ctx;
 }
 
 static void tftp_close(void *handle)
@@ -101,13 +140,15 @@ static void tftp_close(void *handle)
 	ulong tftp_tsize;
 	ulong elapsed;
 
+	sys_untimeout(transfer_timeout, ctx);
+
 	if (ctx->done == FAILURE || ctx->done == ABORTED) {
 		/* Closing after an error or Ctrl-C */
 		return;
 	}
 	ctx->done = SUCCESS;
 
-	tftp_tsize = tftp_client_get_tsize();
+	tftp_tsize = ctx->is_server ? 0 : tftp_client_get_tsize();
 	if (tftp_tsize) {
 		/* Print hash marks for the last packet received */
 		while (ctx->hash_count < 49) {
@@ -142,9 +183,14 @@ static int tftp_write(void *handle, struct pbuf *p)
 	struct tftp_ctx *ctx = handle;
 	struct pbuf *q;
 
-	for (q = p; q; q = q->next)
-		if (store_block(ctx, q->payload, q->len) < 0)
+	for (q = p; q; q = q->next) {
+		if (store_block(ctx, q->payload, q->len) < 0) {
+			ctx->done = FAILURE;
 			return -1;
+		}
+	}
+
+	restart_transfer_timeout(ctx);
 
 	return 0;
 }
@@ -204,6 +250,9 @@ static int tftp_loop(struct udevice *udev, ulong addr, char *fname,
 	ctx.block_count = 0;
 	ctx.hash_count = 0;
 	ctx.daddr = addr;
+	ctx.is_server = false;
+	ctx.wrq_accepted = false;
+	ctx.fname[0] = '\0';
 
 	printf("Using %s device\n", udev->name);
 	printf("TFTP from server %s; our IP address is %s\n",
@@ -258,6 +307,135 @@ static int tftp_loop(struct udevice *udev, ulong addr, char *fname,
 	return -1;
 }
 
+static void no_request(void *arg)
+{
+	struct tftp_ctx *ctx = (struct tftp_ctx *)arg;
+
+	if (ctx->wrq_accepted)
+		return;
+
+	printf("Timeout!\n");
+	ctx->done = FAILURE;
+}
+
+static int tftpsrv_loop(struct udevice *udev, ulong addr)
+{
+	struct netif *netif;
+	struct tftp_ctx ctx;
+	const char *ipaddr;
+	int ret = -1;
+	err_t err;
+
+	if (addr == 0)
+		return -1;
+
+	ipaddr = env_get("ipaddr");
+	if (!ipaddr || !*ipaddr) {
+		log_err("error: ipaddr has to be set\n");
+		return -1;
+	}
+
+	netif = net_lwip_new_netif(udev);
+	if (!netif)
+		return -1;
+
+	memset(&ctx, 0, sizeof(ctx));
+	ctx.done = NOT_DONE;
+	ctx.daddr = addr;
+	ctx.is_server = true;
+
+	printf("Using %s device\n", udev->name);
+	printf("Listening for TFTP transfer on %s\n", ipaddr);
+	printf("Load address: 0x%lx\n", ctx.daddr);
+
+	tftpsrv_active_ctx = &ctx;
+	err = tftp_init_server(&tftp_context);
+	if (err != ERR_OK) {
+		log_err("tftp_init_server err: %d\n", err);
+		goto out_remove_netif;
+	}
+
+	ctx.start_time = get_timer(0);
+	sys_timeout(TFTPSRV_LISTEN_TIMEOUT_MS, no_request, &ctx);
+	while (!ctx.done) {
+		net_lwip_rx(udev, netif);
+		if (ctrlc()) {
+			printf("\nAbort\n");
+			ctx.done = ABORTED;
+			break;
+		}
+	}
+	sys_untimeout(no_request, &ctx);
+	sys_untimeout(transfer_timeout, &ctx);
+
+	tftp_cleanup();
+
+	if (ctx.done == SUCCESS) {
+		if (env_set_hex("fileaddr", addr)) {
+			log_err("fileaddr not updated\n");
+			goto out_remove_netif;
+		}
+		efi_set_bootdev("Net", "", ctx.fname, map_sysmem(addr, 0),
+				ctx.size);
+		ret = 0;
+	}
+
+out_remove_netif:
+	tftpsrv_active_ctx = NULL;
+	net_lwip_remove_netif(netif);
+
+	return ret;
+}
+
+int do_tftpsrv(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
+{
+	int ret = CMD_RET_SUCCESS;
+	char *end;
+	ulong laddr;
+	ulong addr;
+
+	if (!IS_ENABLED(CONFIG_CMD_TFTPSRV))
+		return CMD_RET_FAILURE;
+
+	laddr = env_get_ulong("loadaddr", 16, image_load_addr);
+
+	switch (argc) {
+	case 1:
+		break;
+	case 2:
+		addr = hextoul(argv[1], &end);
+		if (end == argv[1] || *end) {
+			ret = CMD_RET_USAGE;
+			goto out;
+		}
+		laddr = addr;
+		break;
+	default:
+		ret = CMD_RET_USAGE;
+		goto out;
+	}
+
+	if (!laddr) {
+		log_err("error: no load address\n");
+		ret = CMD_RET_FAILURE;
+		goto out;
+	}
+
+	if (net_lwip_eth_start() < 0) {
+		ret = CMD_RET_FAILURE;
+		goto out;
+	}
+
+	if (tftpsrv_loop(eth_get_dev(), laddr) < 0)
+		ret = CMD_RET_FAILURE;
+	else
+		image_load_addr = laddr;
+	net_lwip_eth_stop();
+
+out:
+	return ret;
+}
+
 int do_tftpb(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 {
 	int ret = CMD_RET_SUCCESS;
diff --git a/test/py/tests/test_net.py b/test/py/tests/test_net.py
index 27cdd73fd49..a2007c2fd3a 100644
--- a/test/py/tests/test_net.py
+++ b/test/py/tests/test_net.py
@@ -59,6 +59,19 @@ For example:
         'fnu': 'ubtest-upload.bin',
     }
 
+    # Details regarding a file that may be written to U-Boot using the tftpsrv
+    # command. This variable may be omitted or set to None if tftpsrv testing
+    # is not possible or desired. The test uses host-side curl TFTP support to
+    # upload a generated file to U-Boot. The optional tftpsrv_url entry may be
+    # used when the host must use a forwarded address instead of U-Boot's
+    # ipaddr value.
+    env__net_tftpsrv_file = {
+        'fn': 'ubtest-tftpsrv.bin',
+        'addr': 0x10000000,
+        'size': 4096,
+        'timeout': 50000,
+    }
+
     # Details regarding a file that may be read from a NFS server. This variable
     # may be omitted or set to None if NFS testing is not possible or desired.
     env__net_nfs_readable_file = {
@@ -89,6 +102,8 @@ import utils
 import uuid
 import datetime
 import re
+import tempfile
+import zlib
 
 net_set_up = False
 net6_set_up = False
@@ -460,3 +475,82 @@ def test_net_tftpput(ubman):
 
     output = ubman.run_command("crc32 $fileaddr $filesize")
     assert expected_tftpb_crc in output
+
+
+@pytest.mark.buildconfigspec("cmd_crc32")
+@pytest.mark.buildconfigspec("cmd_tftpsrv")
+@pytest.mark.requiredtool("curl")
+def test_net_tftpsrv(ubman):
+    """Test the tftpsrv command.
+
+    A file is generated on the host, uploaded to U-Boot using TFTP and then
+    validated in U-Boot using its size and CRC32.
+
+    The details of the file to upload are provided by the boardenv_* file;
+    see the comment at the beginning of this file.
+    """
+
+    if not net_set_up:
+        pytest.skip("Network not initialized")
+
+    f = ubman.config.env.get("env__net_tftpsrv_file", None)
+    if not f:
+        pytest.skip("No tftpsrv file to write")
+
+    curl_version = utils.run_and_log(ubman, ["curl", "--version"])
+    if "tftp" not in curl_version.split():
+        pytest.skip("curl does not support TFTP")
+
+    addr = f.get("addr", None)
+    if not addr:
+        addr = utils.find_ram_base(ubman)
+
+    timeout = f.get("timeout", ubman.p.timeout)
+    timeout_secs = max(1, (timeout + 999) // 1000)
+    size = f.get("size", 4096)
+    fn = f.get("fn", "ubtest-tftpsrv.bin")
+    url = f.get("tftpsrv_url", None)
+    data = bytes([i % 251 for i in range(size)])
+    crc = "%08x" % (zlib.crc32(data) & 0xffffffff)
+
+    ip = ubman.run_command("echo $ipaddr").strip()
+    if not ip:
+        pytest.skip("No U-Boot IP address")
+    if not url:
+        url = "tftp://%s/%s" % (ip, fn)
+
+    with tempfile.NamedTemporaryFile() as tmp:
+        tmp.write(data)
+        tmp.flush()
+
+        done = False
+        with ubman.temporary_timeout(timeout):
+            try:
+                ubman.run_command("tftpsrv %x" % addr,
+                                  wait_for_prompt=False)
+                ubman.wait_for("Listening for TFTP transfer")
+                utils.run_and_log(
+                    ubman,
+                    [
+                        "curl",
+                        "--fail",
+                        "--max-time",
+                        str(timeout_secs),
+                        "--upload-file",
+                        tmp.name,
+                        url,
+                    ],
+                )
+                ubman.wait_for("Bytes transferred = %d" % size)
+                ubman.wait_for(ubman.prompt)
+                done = True
+            finally:
+                if not done:
+                    ubman.ctrlc()
+                    ubman.drain_console()
+
+    output = ubman.run_command("echo $filesize")
+    assert "%x" % size in output
+
+    output = ubman.run_command("crc32 $fileaddr $filesize")
+    assert crc in output
-- 
2.53.0

