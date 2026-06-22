Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86E1DCD98F2
	for <u-boot@archiver.kernel.org>; Mon, 22 Jun 2026 20:32:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 95F3D84931;
	Mon, 22 Jun 2026 22:32:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="D7Lo+8DV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1382B849BA; Mon, 22 Jun 2026 22:32:30 +0200 (CEST)
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com
 [IPv6:2001:4860:4864:20::31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A3ABC848EB
 for <u-boot@lists.denx.de>; Mon, 22 Jun 2026 22:32:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=james.hilliard1@gmail.com
Received: by mail-oa1-x31.google.com with SMTP id
 586e51a60fabf-4479ab2e41eso648634fac.2
 for <u-boot@lists.denx.de>; Mon, 22 Jun 2026 13:32:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782160346; x=1782765146; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=xGFORM7KHa/GowAoLjrYDfDZ4wNqXEI+0/eRRvr6DaI=;
 b=D7Lo+8DVhYEAH04PXxTAyXTcQom0VyBuWwMyYRocfbKtSCmi1rb0YlJeovqow4PQDr
 hk+s06q3Vvb1dYeqCtZeMjsM/lG6VCDgVlKcFJkGXBxsEVUChbUhtMXfdZbwxbL0llSz
 xLmyey46awh3vWGvVhw/f+JRYJ0IkWjBbfrZ+RkiR7YDScCS4Am6WQPeiY8HG1sU/v1Z
 of/NMKowF7QrKJIt/M16cT5DCYSSgeSAgZv4ecdlY7gqgTIoEyJNGYaxhbby3/3orxaZ
 Po8WM+IN30TqXjnHvOQx5nCEwHmFDQpsbzV1u0HIvU7IxNAjvLhKKpVSGjGs8MpYKO0F
 1uwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782160346; x=1782765146;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xGFORM7KHa/GowAoLjrYDfDZ4wNqXEI+0/eRRvr6DaI=;
 b=H+g1FCmqY/UTM6jiIAYNusKqzEvyAQp6D8OF5YR6gndaODLlS6+O/yVxSyLwP811oL
 clQUUMH6X0jW2vY4xLhjXSVarkqMLm087TOV6LlHounY26bbs2Kltyp11m400hFfHaYR
 asilNN9rniq3g4XPGaHWoYF1QMr/V5bLyJR5LqlVS/5YpBcH6CI5fYg2NuyDpdRNdPe7
 H7ark8ktD6TM5IEytdh3bZsmaA+b1Ne+ZMJUJYoJ5z1GINhGDT6I5ydJ2aL39QYmqnsT
 2sD4upyhr8ZRNrImFZRswi8EBKfd9D+mJ8ALhp3svXypSISGC0BYfxynOOXrEgER4Oub
 6+5g==
X-Gm-Message-State: AOJu0YzQCpQUQGF/9BSZDXspy+Fl2fbM9gL7Gx95yLsZtrNfgBJjuA2F
 kCYLCTVv5g0i1Y2t0sRTyKaNoKjRKgiyTzuNGVLfSFmozx/Vyj/UvkvVrSyLQa7pxXM=
X-Gm-Gg: AfdE7cmnADNZMOiepCRxs1lts7cINArncJgTpM4RNB/Y4n2maC1GSIsIvuyWpYALFds
 vRDObO0KeDsAtLP6JA+noAvYshyItIf/Q8ZufhpNq704YnqBwr0XwfDgRETcItRB2bdFup0TmGs
 V/7ULOdcKAhUyltYdv/5s1lJi724W4EtiX5l2DhOmaE7NX/plq2YD64kTwBRWucv80plBrECX4r
 SjTLbO/jg2da422TSCjHCr3bPBeVQuTP2MzXuVI4q0IP9FxdFlYA8s8rz96p/HeQcV/GFk2V8gw
 gSqvOLep0RfEN91efpY+cpG1I0G3HyyLrMpwb8JwGPoDEPTwL5Z7raePl5z/njCmhOLfAzT3ot9
 dzPXvPyZC6eCmby1SCbJRO53n7fi1rWNUwbMSS/B0gBL1mllSJRbfDmKsJKa28hjasozzRoNTT2
 WlR1oRZU6+44GHRbhAmayCvQlcTgT6PZFy2F9Gb3ovc4zd6LXppXxj1xYYa/2RPvNhN0aqioII3
 7Dp1y0YpFWY7KuKYrSxB2apiy3YMi83uZIiefAkAeyCDw99TwG7yG2GgcvMVnuhYQYgHeX9J5X/
 UaZdbSAAwr2+O9k=
X-Received: by 2002:a05:6808:1b06:b0:479:eb19:6e66 with SMTP id
 5614622812f47-48f29eb5fcamr42375b6e.38.1782160346246; 
 Mon, 22 Jun 2026 13:32:26 -0700 (PDT)
Received: from james-x399.tailafd1a.ts.net (97-118-25-163.hlrn.qwest.net.
 [97.118.25.163]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-48aec0dd2bbsm5313693b6e.6.2026.06.22.13.32.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jun 2026 13:32:25 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
To: u-boot@lists.denx.de
Cc: James Hilliard <james.hilliard1@gmail.com>, Tom Rini <trini@konsulko.com>,
 Jerome Forissier <jerome.forissier@arm.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, Simon Glass <sjg@chromium.org>,
 "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Heiko Schocher <hs@nabladev.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Benjamin Hahn <B.Hahn@phytec.de>, Tim Harvey <tharvey@gateworks.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Jonas Karlman <jonas@kwiboo.se>, Pranav Sanwal <pranav.sanwal@amd.com>
Subject: [PATCH] net: lwip: add tftpsrv command
Date: Mon, 22 Jun 2026 14:31:54 -0600
Message-ID: <20260622203157.73416-1-james.hilliard1@gmail.com>
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
The lwIP stack already builds the lwIP TFTP application, but only wires
it up for client-side tftpboot.

Add a lwIP tftpsrv command and implement the server path with
tftp_init_server(). Reuse the existing lwIP TFTP write callback and
memory copy path so LMB checks, progress output, filesize/fileaddr
updates and EFI bootdev handling stay consistent with tftpboot.

Track receive timeout and write-failure state around the lwIP callbacks
so a stalled or rejected receive is not reported as a successful close.

Move CMD_TFTPSRV out of the legacy-only Kconfig block so it can be
enabled with either network stack.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 cmd/Kconfig        |  14 ++--
 cmd/lwip/Makefile  |   1 +
 cmd/lwip/tftpsrv.c |  11 +++
 include/net-lwip.h |   1 +
 net/lwip/tftp.c    | 181 +++++++++++++++++++++++++++++++++++++++++++--
 5 files changed, 197 insertions(+), 11 deletions(-)
 create mode 100644 cmd/lwip/tftpsrv.c

diff --git a/cmd/Kconfig b/cmd/Kconfig
index 032e55e8127..8f3d66ddc77 100644
--- a/cmd/Kconfig
+++ b/cmd/Kconfig
@@ -2127,12 +2127,6 @@ config CMD_TFTPPUT
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
@@ -2279,6 +2273,14 @@ config CMD_TFTPBOOT
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
index 00000000000..522a7ccacdf
--- /dev/null
+++ b/cmd/lwip/tftpsrv.c
@@ -0,0 +1,11 @@
+// SPDX-License-Identifier: GPL-2.0+
+
+#include <command.h>
+#include <net.h>
+
+U_BOOT_CMD(tftpsrv, 2, 1, do_tftpsrv,
+	   "act as a TFTP server and boot the first received file",
+	   "[loadAddress]\n"
+	   "Listen for an incoming TFTP transfer, receive a file and boot it.\n"
+	   "The transfer is aborted if a transfer has not been started after\n"
+	   "about 50 seconds or if Ctrl-C is pressed.");
diff --git a/include/net-lwip.h b/include/net-lwip.h
index 20cb0992cce..571d8941ff0 100644
--- a/include/net-lwip.h
+++ b/include/net-lwip.h
@@ -52,6 +52,7 @@ bool wget_validate_uri(char *uri);
 
 int do_dns(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[]);
 int do_nfs(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[]);
+int do_tftpsrv(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[]);
 int do_wget(struct cmd_tbl *cmdtp, int flag, int argc, char * const argv[]);
 
 #endif /* __NET_LWIP_H__ */
diff --git a/net/lwip/tftp.c b/net/lwip/tftp.c
index 7f3b28b8507..af25aabc973 100644
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
+#define NO_WRQ_TIMEOUT_MS (TFTP_TIMEOUT_MSECS * TFTP_MAX_RETRIES)
 
 enum done_state {
 	NOT_DONE = 0,
@@ -34,8 +37,27 @@ struct tftp_ctx {
 	ulong hash_count;
 	ulong start_time;
 	enum done_state done;
+	bool is_server;
+	bool wrq_accepted;
+	char fname[TFTP_MAX_FILENAME_LEN + 1];
 };
 
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
@@ -71,7 +93,7 @@ static int store_block(struct tftp_ctx *ctx, void *src, u16_t len)
 	ctx->size += len;
 	ctx->block_count++;
 
-	tftp_tsize = tftp_client_get_tsize();
+	tftp_tsize = ctx->is_server ? 0 : tftp_client_get_tsize();
 	if (tftp_tsize) {
 		pos = clamp(ctx->size, 0UL, tftp_tsize);
 
@@ -92,7 +114,20 @@ static int store_block(struct tftp_ctx *ctx, void *src, u16_t len)
 
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
@@ -101,13 +136,15 @@ static void tftp_close(void *handle)
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
@@ -142,9 +179,14 @@ static int tftp_write(void *handle, struct pbuf *p)
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
@@ -204,6 +246,9 @@ static int tftp_loop(struct udevice *udev, ulong addr, char *fname,
 	ctx.block_count = 0;
 	ctx.hash_count = 0;
 	ctx.daddr = addr;
+	ctx.is_server = false;
+	ctx.wrq_accepted = false;
+	ctx.fname[0] = '\0';
 
 	printf("Using %s device\n", udev->name);
 	printf("TFTP from server %s; our IP address is %s\n",
@@ -258,6 +303,132 @@ static int tftp_loop(struct udevice *udev, ulong addr, char *fname,
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
+		tftpsrv_active_ctx = NULL;
+		net_lwip_remove_netif(netif);
+		return -1;
+	}
+
+	ctx.start_time = get_timer(0);
+	sys_timeout(NO_WRQ_TIMEOUT_MS, no_request, &ctx);
+	while (!ctx.done) {
+		net_lwip_rx(udev, netif);
+		if (ctrlc()) {
+			printf("\nAbort\n");
+			ctx.done = ABORTED;
+			break;
+		}
+	}
+	sys_untimeout(no_request, (void *)&ctx);
+
+	tftp_cleanup();
+	tftpsrv_active_ctx = NULL;
+	net_lwip_remove_netif(netif);
+
+	if (ctx.done == SUCCESS) {
+		if (env_set_hex("fileaddr", addr)) {
+			log_err("fileaddr not updated\n");
+			return -1;
+		}
+		efi_set_bootdev("Net", "", ctx.fname, map_sysmem(addr, 0),
+				ctx.size);
+		return 0;
+	}
+
+	return -1;
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
+
+out:
+	return ret;
+}
+
 int do_tftpb(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 {
 	int ret = CMD_RET_SUCCESS;
-- 
2.53.0

