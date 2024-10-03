Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EEE8CF34B0
	for <u-boot@archiver.kernel.org>; Thu,  3 Oct 2024 15:47:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C997E88E4A;
	Thu,  3 Oct 2024 17:47:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="d/esfZvT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F2F608843A; Thu,  3 Oct 2024 17:47:11 +0200 (CEST)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BB24288E5A
 for <u-boot@lists.denx.de>; Thu,  3 Oct 2024 17:47:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-42cb0f28bfbso9378375e9.1
 for <u-boot@lists.denx.de>; Thu, 03 Oct 2024 08:47:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1727970428; x=1728575228; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WfZkN40BGwrsplDkoL4zYsrJ+IyWbxoUOxHvT2T1WTI=;
 b=d/esfZvTcPD9ezFy7YdSAyO7Wsb8qpTTvbCZ5GcJ8G7VUNNFE185SVl39uzn2izvhJ
 k2Di1qA3eEv6bsuXUPyxCyG8qaouTrwy2Ac6BLH1I4Ki9LbL3ugxDtq38QzVNHRIjpFJ
 Wp/29sW7PdsZkmPXMbDMI4iggzKIG7xo+nQXXLTbQLK7rjOIg7WsO646ZEI4wjaizLgw
 Zqpu6gn/dDLttXzFBb7Os5p5boUhkK9ya0g/IAtXh839xn/T9MCMeSbXZmi1X002ySbA
 774AaDSLxjngN0vzR/Z6perRJMCMhx8qFklATGetK5TdNHP27qORv5615thONyMsdJMv
 SMOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727970428; x=1728575228;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WfZkN40BGwrsplDkoL4zYsrJ+IyWbxoUOxHvT2T1WTI=;
 b=axwB99e8ee6uhiArLxK9OteD+GmdJKzg8lfrYcJ2+wuimHfWpapXpo1NumaFmVw8fx
 I9iWsUfEk63qbOlw1ZyIIM8Djg3PGcansKHn1u6EzWvJDEZowxbVmmukwtuVTblH2uy0
 P8i17vaKklPmEJFbmiFIrKBYrKjaFBsCi6bppk2nvqQ8Mt7tRCZgiacsCiDzS5JtCg6m
 r5miQwJVqInqtC/NNhwqUMZCsCQ5Lfhmucs2Aq/+0pg2NcEIatoU/Ms6ZtI4oyXbt2Q6
 cnQkSJEyfor4nmVr/UAa/sINsG98cpC09VERocbjBRUwljgk5K2Eos3da0tZqs6pNApU
 9fsw==
X-Gm-Message-State: AOJu0YyaVfpzw5oB6nWI8R8gQ+6h2VkvEakz7qfITKA/8+YZfDDZ6I1u
 mKhO7F6weNK35HCuumPaRu2RgDUOBsn5Sn7+PBOeQXF0oHpg4r+xjviLQPoSdZZcFcNZiNx8JvI
 CO1ZJ80ww
X-Google-Smtp-Source: AGHT+IH7lWdKw6R8doEhOTq2R8wGbttZYQMBd7YUOSz8U8uCyVOPIGk3lyyuio6egYCGGZ8xuNltMA==
X-Received: by 2002:a05:600c:4710:b0:42c:b4f1:f2ad with SMTP id
 5b1f17b1804b1-42f778f3815mr50000615e9.33.1727970428165; 
 Thu, 03 Oct 2024 08:47:08 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:d888:7a58:deed:47d6])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37d08245059sm1541748f8f.55.2024.10.03.08.47.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Oct 2024 08:47:07 -0700 (PDT)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Javier Tia <javier.tia@linaro.org>, Raymond Mao <raymond.mao@linaro.org>,
 Maxim Uvarov <muvarov@gmail.com>, Tim Harvey <tharvey@gateworks.com>,
 Anton Antonov <Anton.Antonov@arm.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Tom Rini <trini@konsulko.com>, Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Simon Glass <sjg@chromium.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Sean Anderson <seanga2@gmail.com>
Subject: [PATCH v11 15/29] net-lwip: add TFTP support and tftpboot command
Date: Thu,  3 Oct 2024 17:46:19 +0200
Message-Id: <6ebffbe03de27d5177bec361fdc5e26816ceb849.1727968902.git.jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1727968902.git.jerome.forissier@linaro.org>
References: <cover.1727968902.git.jerome.forissier@linaro.org>
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

Implement do_tftpb(). This implementation of the tftp command
supports an optional port number. For example:

 tftp 192.168.0.30:9069:file.bin

It also supports taking the server IP from ${tftpserverip} if
defined, before falling back to ${serverip}.

Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
---
 cmd/Kconfig          |   3 +-
 cmd/net-lwip.c       |   8 ++
 include/net-common.h |   4 +
 include/net-lwip.h   |   4 +
 lib/binman.c         |   1 +
 net/lwip/dhcp.c      |  11 +-
 net/lwip/net-lwip.c  |  16 +++
 net/lwip/tftp.c      | 283 ++++++++++++++++++++++++++++++++++++++++++-
 8 files changed, 324 insertions(+), 6 deletions(-)

diff --git a/cmd/Kconfig b/cmd/Kconfig
index d09c237a52f..f1372a025b7 100644
--- a/cmd/Kconfig
+++ b/cmd/Kconfig
@@ -2119,10 +2119,9 @@ config CMD_MDIO
 config CMD_TFTPBOOT
 	bool "tftp"
 	select PROT_UDP_LWIP if NET_LWIP
-	default n
+	default y
 	help
 	  tftpboot - load file via network using TFTP protocol
-	  Currently a placeholder (not implemented) when NET_LWIP=y.
 
 endif  # if CMD_NET
 
diff --git a/cmd/net-lwip.c b/cmd/net-lwip.c
index 82edb5fd2e6..80f0872bb8f 100644
--- a/cmd/net-lwip.c
+++ b/cmd/net-lwip.c
@@ -11,3 +11,11 @@ U_BOOT_CMD(
         "[loadAddress] [[hostIPaddr:]bootfilename]"
 );
 #endif
+
+#if defined(CONFIG_CMD_TFTPBOOT)
+U_BOOT_CMD(
+	tftpboot,	3,	0,	do_tftpb,
+	"boot image via network using TFTP protocol\n",
+	"[loadAddress] [[hostIPaddr:]bootfilename]"
+);
+#endif
diff --git a/include/net-common.h b/include/net-common.h
index cbcac178c82..fd7c5e7b488 100644
--- a/include/net-common.h
+++ b/include/net-common.h
@@ -459,6 +459,10 @@ static inline struct in_addr env_get_ip(char *var)
 
 int net_init(void);
 
+/* NET compatibility */
+enum proto_t;
+int net_loop(enum proto_t protocol);
+
 /**
  * dhcp_run() - Run DHCP on the current ethernet device
  *
diff --git a/include/net-lwip.h b/include/net-lwip.h
index cfd06726577..37744b0e2cd 100644
--- a/include/net-lwip.h
+++ b/include/net-lwip.h
@@ -6,6 +6,10 @@
 #include <lwip/ip4.h>
 #include <lwip/netif.h>
 
+enum proto_t {
+	TFTPGET
+};
+
 struct netif *net_lwip_new_netif(struct udevice *udev);
 struct netif *net_lwip_new_netif_noip(struct udevice *udev);
 void net_lwip_remove_netif(struct netif *netif);
diff --git a/lib/binman.c b/lib/binman.c
index 9047f5275f3..93d85548116 100644
--- a/lib/binman.c
+++ b/lib/binman.c
@@ -137,6 +137,7 @@ int binman_init(void)
 {
 	int ret;
 
+	return 0;
 	binman = malloc(sizeof(struct binman_info));
 	if (!binman)
 		return log_msg_ret("space for binman", -ENOMEM);
diff --git a/net/lwip/dhcp.c b/net/lwip/dhcp.c
index be458d554cb..14685cf7825 100644
--- a/net/lwip/dhcp.c
+++ b/net/lwip/dhcp.c
@@ -116,11 +116,20 @@ int do_dhcp(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 int dhcp_run(ulong addr, const char *fname, bool autoload)
 {
 	char *dhcp_argv[] = {"dhcp", NULL, };
+#ifdef CONFIG_CMD_TFTPBOOT
+	char *tftp_argv[] = {"tftpboot", boot_file_name, NULL, };
+#endif
 	struct cmd_tbl cmdtp = {};	/* dummy */
 
 	if (autoload) {
-		/* Will be supported when TFTP is added */
+#ifdef CONFIG_CMD_TFTPBOOT
+		/* Assume DHCP was already performed */
+		if (boot_file_name[0])
+			return do_tftpb(&cmdtp, 0, 2, tftp_argv);
+		return 0;
+#else
 		return -EOPNOTSUPP;
+#endif
 	}
 
 	return do_dhcp(&cmdtp, 0, 1, dhcp_argv);
diff --git a/net/lwip/net-lwip.c b/net/lwip/net-lwip.c
index ca5426d058b..6a27d71de73 100644
--- a/net/lwip/net-lwip.c
+++ b/net/lwip/net-lwip.c
@@ -28,6 +28,7 @@ const u8 net_bcast_ethaddr[6] = { 0xff, 0xff, 0xff, 0xff, 0xff, 0xff };
 char *pxelinux_configfile;
 /* Our IP addr (0 = unknown) */
 struct in_addr	net_ip;
+char net_boot_file_name[1024];
 
 static err_t linkoutput(struct netif *netif, struct pbuf *p)
 {
@@ -285,6 +286,21 @@ void net_process_received_packet(uchar *in_packet, int len)
 #endif
 }
 
+int net_loop(enum proto_t protocol)
+{
+	char *argv[1];
+
+	switch (protocol) {
+	case TFTPGET:
+		argv[0] = "tftpboot";
+		return do_tftpb(NULL, 0, 1, argv);
+	default:
+		return -EINVAL;
+	}
+
+	return -EINVAL;
+}
+
 u32_t sys_now(void)
 {
 	return get_timer(0);
diff --git a/net/lwip/tftp.c b/net/lwip/tftp.c
index 1fa246f55d9..26978643313 100644
--- a/net/lwip/tftp.c
+++ b/net/lwip/tftp.c
@@ -2,10 +2,287 @@
 /* Copyright (C) 2024 Linaro Ltd. */
 
 #include <command.h>
-#include <net-lwip.h>
+#include <console.h>
+#include <display_options.h>
+#include <dm/device.h>
+#include <efi_loader.h>
+#include <image.h>
+#include <linux/delay.h>
+#include <lwip/apps/tftp_client.h>
+#include <lwip/timeouts.h>
+#include <mapmem.h>
+#include <net.h>
+#include <time.h>
+
+#define PROGRESS_PRINT_STEP_BYTES (10 * 1024)
+
+enum done_state {
+	NOT_DONE = 0,
+	SUCCESS,
+	FAILURE,
+	ABORTED
+};
+
+struct tftp_ctx {
+	ulong daddr;
+	ulong size;
+	ulong block_count;
+	ulong start_time;
+	enum done_state done;
+};
+
+static void *tftp_open(const char *fname, const char *mode, u8_t is_write)
+{
+	return NULL;
+}
+
+static void tftp_close(void *handle)
+{
+	struct tftp_ctx *ctx = handle;
+	ulong elapsed;
+
+	if (ctx->done == FAILURE || ctx->done == ABORTED) {
+		/* Closing after an error or Ctrl-C */
+		return;
+	}
+	ctx->done = SUCCESS;
+
+	elapsed = get_timer(ctx->start_time);
+	if (elapsed > 0) {
+		puts("\n\t ");	/* Line up with "Loading: " */
+		print_size(ctx->size / elapsed * 1000, "/s");
+	}
+	puts("\ndone\n");
+	printf("Bytes transferred = %lu (%lx hex)\n", ctx->size, ctx->size);
+
+	if (env_set_hex("filesize", ctx->size)) {
+		log_err("filesize not updated\n");
+		return;
+	}
+}
+
+static int tftp_read(void *handle, void *buf, int bytes)
+{
+	return 0;
+}
+
+static int tftp_write(void *handle, struct pbuf *p)
+{
+	struct tftp_ctx *ctx = handle;
+	struct pbuf *q;
+
+	for (q = p; q != NULL; q = q->next) {
+		memcpy((void *)ctx->daddr, q->payload, q->len);
+		ctx->daddr += q->len;
+		ctx->size += q->len;
+		ctx->block_count++;
+		if (ctx->block_count % 10 == 0) {
+			putc('#');
+			if (ctx->block_count % (65 * 10) == 0)
+				puts("\n\t ");
+		}
+	}
+
+	return 0;
+}
+
+static void tftp_error(void *handle, int err, const char *msg, int size)
+{
+	struct tftp_ctx *ctx = handle;
+	char message[100];
+
+	ctx->done = FAILURE;
+	memset(message, 0, sizeof(message));
+	memcpy(message, msg, LWIP_MIN(sizeof(message) - 1, (size_t)size));
+
+	printf("\nTFTP error: %d (%s)\n", err, message);
+}
+
+static const struct tftp_context tftp_context = {
+	tftp_open,
+	tftp_close,
+	tftp_read,
+	tftp_write,
+	tftp_error
+};
+
+static int tftp_loop(struct udevice *udev, ulong addr, char *fname,
+		     ip_addr_t srvip, uint16_t srvport)
+{
+	struct netif *netif;
+	struct tftp_ctx ctx;
+	err_t err;
+
+	if (!fname || addr == 0)
+		return -1;
+
+	if (!srvport)
+		srvport = TFTP_PORT;
+
+	netif = net_lwip_new_netif(udev);
+	if (!netif)
+		return -1;
+
+	ctx.done = NOT_DONE;
+	ctx.size = 0;
+	ctx.block_count = 0;
+	ctx.daddr = addr;
+
+	printf("Using %s device\n", udev->name);
+	printf("TFTP from server %s; our IP address is %s\n",
+		 ip4addr_ntoa(&srvip), env_get("ipaddr"));
+	printf("Filename '%s'.\n", fname);
+	printf("Load address: 0x%lx\n", ctx.daddr);
+	printf("Loading: ");
+
+	err = tftp_init_client(&tftp_context);
+	if (!(err == ERR_OK || err == ERR_USE))
+		log_err("tftp_init_client err: %d\n", err);
+
+	ctx.start_time = get_timer(0);
+	err = tftp_get(&ctx, &srvip, srvport, fname, TFTP_MODE_OCTET);
+	/* might return different errors, like routing problems */
+	if (err != ERR_OK) {
+		printf("tftp_get() error %d\n", err);
+		net_lwip_remove_netif(netif);
+		return -1;
+	}
+
+	while (!ctx.done) {
+		net_lwip_rx(udev, netif);
+		sys_check_timeouts();
+		if (ctrlc()) {
+			printf("\nAbort\n");
+			ctx.done = ABORTED;
+			break;
+		}
+	}
+
+	tftp_cleanup();
+
+	net_lwip_remove_netif(netif);
+
+	if (ctx.done == SUCCESS) {
+		if (env_set_hex("fileaddr", addr)) {
+			log_err("fileaddr not updated\n");
+			return -1;
+		}
+		efi_set_bootdev("Net", "", fname, map_sysmem(addr, 0),
+				ctx.size);
+		return 0;
+	}
+
+	return -1;
+}
 
 int do_tftpb(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 {
-	/* Not implemented */
-	return CMD_RET_FAILURE;
+	int ret = CMD_RET_SUCCESS;
+	char *arg = NULL;
+	char *words[3] = { };
+	char *fname = NULL;
+	char *server_ip = NULL;
+	char *server_port = NULL;
+	char *end;
+	ip_addr_t srvip;
+	uint16_t port = TFTP_PORT;
+	ulong laddr;
+	ulong addr;
+	int i;
+
+	laddr = env_get_ulong("loadaddr", 16, image_load_addr);
+
+	switch (argc) {
+	case 1:
+		fname = env_get("bootfile");
+		break;
+	case 2:
+		/*
+		 * Only one arg - accept two forms:
+		 * Just load address, or just boot file name. The latter
+		 * form must be written in a format which can not be
+		 * mis-interpreted as a valid number.
+		 */
+		addr = hextoul(argv[1], &end);
+		if (end == (argv[1] + strlen(argv[1]))) {
+			laddr = addr;
+			fname = env_get("bootfile");
+		} else {
+			arg = strdup(argv[1]);
+		}
+		break;
+	case 3:
+		laddr = hextoul(argv[1], NULL);
+		arg = strdup(argv[2]);
+		break;
+	default:
+		ret = CMD_RET_USAGE;
+		goto out;
+	}
+
+	if (!arg)
+		arg = net_boot_file_name;
+
+	if (arg) {
+		/* Parse [ip:[port:]]fname */
+		i = 0;
+		while ((*(words + i) = strsep(&arg,":")))
+			i++;
+
+		switch (i) {
+		case 3:
+			server_ip = words[0];
+			server_port = words[1];
+			fname = words[2];
+			break;
+		case 2:
+			server_ip = words[0];
+			fname = words[1];
+			break;
+		case 1:
+			fname = words[0];
+			break;
+		default:
+			break;
+		}
+	}
+
+	if (!server_ip)
+		server_ip = env_get("tftpserverip");
+	if (!server_ip)
+		server_ip = env_get("serverip");
+	if (!server_ip) {
+		log_err("error: tftpserverip/serverip has to be set\n");
+		ret = CMD_RET_FAILURE;
+		goto out;
+	}
+
+	if (server_port)
+		port = dectoul(server_port, NULL);
+
+	if (!ipaddr_aton(server_ip, &srvip)) {
+		log_err("error: ipaddr_aton\n");
+		ret = CMD_RET_FAILURE;
+		goto out;
+	}
+
+	if (!fname) {
+		log_err("error: no file name\n");
+		ret = CMD_RET_FAILURE;
+		goto out;
+	}
+
+	if (!laddr) {
+		log_err("error: no load address\n");
+		ret = CMD_RET_FAILURE;
+		goto out;
+	}
+
+	eth_set_current();
+
+	if (tftp_loop(eth_get_dev(), laddr, fname, srvip, port) < 0)
+		ret = CMD_RET_FAILURE;
+out:
+	free(arg);
+	return ret;
 }
-- 
2.40.1

