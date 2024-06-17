Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D78B7C27C79
	for <u-boot@archiver.kernel.org>; Mon, 17 Jun 2024 15:34:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 801DF88378;
	Mon, 17 Jun 2024 17:33:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="csic0GLB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 399A887CDA; Mon, 17 Jun 2024 17:33:44 +0200 (CEST)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DAE2D880F5
 for <u-boot@lists.denx.de>; Mon, 17 Jun 2024 17:33:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-42138eadf64so36131285e9.3
 for <u-boot@lists.denx.de>; Mon, 17 Jun 2024 08:33:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718638421; x=1719243221; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=87Jpm45kzVS5H2Yenyow8XXD5OE3qOF3CkCP62vN/2s=;
 b=csic0GLBf7zHiAWfVmA1T/OpXVuJqtjrOPUWsv0NVdu+DT1tEbk0IiJ/79pNUJ92gT
 aUdwyD4cb2LxWkqHsVpV7K7GApiLGNmcHn33b8Z1Urk1HSovEurNQqbYpzkGG8FtDP4R
 hFQdj0Y/rG6z1g7YOev4JiPBhbO0ZPX5SXGNO6FXOO7BRSetO2ki+X5v4y/FnwAzzUQ1
 UWbInQ4o6qiO5aftifTvFg78+r4Z4OCkJTVtJdf5btdTaTiJ06D9wsTcxAIOCSRsaO5R
 VJnBtKiHAp7qzwBvMWTohdeK5P8MmN4JII2IP7yLAf+anyTpmTYkjSdV6o8hxczguu6a
 +34w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718638421; x=1719243221;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=87Jpm45kzVS5H2Yenyow8XXD5OE3qOF3CkCP62vN/2s=;
 b=mu/1M8Rbps+Psa21bawtqekMhH3fjPAQKrZtZoBFvBM9xXQQDBkjzt8EA1a8w40aaO
 +iJnMe8QZzECWk3QVgxhJ/BWu8VPRqZF7TQI7aWVECIV+i9/y3Po1M/iKUWSQLPnbN2N
 iQdUDpeGJdGMZS4LSOlhpIHTn5IBTM84z0HetAHG8AvKIE6LRfi62jZ2aPcS1pjB8Jrj
 R4+Ux8i665/Zy+lqg2DZoKS2eqkmwXCdVkK1povBV38bfGCLXSiaLc7fSwmnfkhueaC2
 gDS7DoMejfrOokoZ5kQtSFAPCSRu3MC7KJhDViWNwg5WqTVOnLKjBaYlJegwenaOBA8f
 oRyg==
X-Gm-Message-State: AOJu0YyStAp+xhfDC+d7d1ahExy/BNl76Bv/BU18xHGBwWsjDpvo+vtA
 oQjUTaJ657H5sW1FoRfVpHy7sulZNRMlsy4j0GuBpR/+lyP7ABBtQ1SczKujwoyzBgEhvKd0a7T
 8GsE=
X-Google-Smtp-Source: AGHT+IEapv6w14tIuHXwPJyEVIEtbjaZDAfewVf63DhL946ibf+5zGV9ob/FouUZjtb6UolsjfwC2g==
X-Received: by 2002:a05:600c:a03:b0:422:9c91:a26f with SMTP id
 5b1f17b1804b1-4230482c20fmr79025625e9.19.1718638421156; 
 Mon, 17 Jun 2024 08:33:41 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:6e75:be8f:56ae:2b5e])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-422f602f620sm161350895e9.19.2024.06.17.08.33.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Jun 2024 08:33:40 -0700 (PDT)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Javier Tia <javier.tia@linaro.org>, Maxim Uvarov <muvarov@gmail.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Francis Laniel <francis.laniel@amarulasolutions.com>,
 Peter Robinson <pbrobinson@gmail.com>
Subject: [PATCH v4 06/14] net-lwip: add TFTP support and tftpboot command
Date: Mon, 17 Jun 2024 17:32:58 +0200
Message-Id: <951df32b91d392899208d7fc841b161fa78ed33b.1718638104.git.jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1718638104.git.jerome.forissier@linaro.org>
References: <cover.1718638104.git.jerome.forissier@linaro.org>
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

Implement do_tftpb().

Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
---
 cmd/Kconfig     |   3 +-
 cmd/net-lwip.c  |   8 ++
 net-lwip/dhcp.c |  11 ++-
 net-lwip/tftp.c | 221 +++++++++++++++++++++++++++++++++++++++++++++++-
 4 files changed, 237 insertions(+), 6 deletions(-)

diff --git a/cmd/Kconfig b/cmd/Kconfig
index 1bfa528e945..94a8de266f6 100644
--- a/cmd/Kconfig
+++ b/cmd/Kconfig
@@ -2101,10 +2101,9 @@ config CMD_DHCP
 config CMD_TFTPBOOT
 	bool "tftp"
 	select PROT_UDP_LWIP
-	default n
+	default y
 	help
 	  tftpboot - load file via network using TFTP protocol
-	  Currently a placeholder (not implemented)
 
 endif
 
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
diff --git a/net-lwip/dhcp.c b/net-lwip/dhcp.c
index 38ea565508f..af8ac214e81 100644
--- a/net-lwip/dhcp.c
+++ b/net-lwip/dhcp.c
@@ -88,11 +88,20 @@ int do_dhcp(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
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
diff --git a/net-lwip/tftp.c b/net-lwip/tftp.c
index 1fa246f55d9..295c8a7ebf2 100644
--- a/net-lwip/tftp.c
+++ b/net-lwip/tftp.c
@@ -2,10 +2,225 @@
 /* Copyright (C) 2024 Linaro Ltd. */
 
 #include <command.h>
-#include <net-lwip.h>
+#include <console.h>
+#include <image.h>
+#include <linux/delay.h>
+#include <lwip/apps/tftp_client.h>
+#include <lwip/timeouts.h>
+#include <net.h>
+#include <time.h>
+
+#define PROGRESS_PRINT_STEP_BYTES (100 * 1024)
+
+enum done_state {
+	NOT_DONE = 0,
+	SUCCESS = 1,
+	FAILURE = 2
+};
+
+struct tftp_ctx {
+	ulong daddr;
+	ulong size;
+	ulong prevsize;
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
+	if (ctx->done == FAILURE) {
+		/* Closing after an error */
+		return;
+	}
+
+	elapsed = get_timer(ctx->start_time);
+	ctx->done = SUCCESS;
+	printf("\nBytes transferred = %lu (%lx hex)\n", ctx->size, ctx->size);
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
+		if (ctx->size - ctx->prevsize > PROGRESS_PRINT_STEP_BYTES) {
+			printf("#");
+			ctx->prevsize = ctx->size;
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
+static int tftp_run(ulong addr, char *fname, ip_addr_t srvip)
+{
+	struct netif *netif;
+	struct tftp_ctx ctx;
+	err_t err;
+
+	if (!fname || addr == 0)
+		return -1;
+
+	netif = net_lwip_new_netif();
+	if (!netif)
+		return -1;
+
+	ctx.done = NOT_DONE;
+	ctx.size = 0;
+	ctx.prevsize = 0;
+	ctx.daddr = addr;
+
+	printf("Using %s device\n", eth_get_name());
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
+	err = tftp_get(&ctx, &srvip, TFTP_PORT, fname, TFTP_MODE_OCTET);
+	/* might return different errors, like routing problems */
+	if (err != ERR_OK) {
+		printf("tftp_get() error %d\n", err);
+		net_lwip_remove_netif(netif);
+		return -1;
+	}
+
+	while (!ctx.done) {
+		eth_rx();
+		sys_check_timeouts();
+		if (ctrlc())
+			break;
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
+		return 0;
+	}
+
+	return -1;
+}
 
 int do_tftpb(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 {
-	/* Not implemented */
-	return CMD_RET_FAILURE;
+	char *fname;
+	char *server_ip;
+	ip_addr_t srvip;
+	ulong addr;
+	char *end;
+	char *col;
+
+	image_load_addr = env_get_ulong("loadaddr", 16, image_load_addr);
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
+			image_load_addr = addr;
+			fname = env_get("bootfile");
+		} else {
+			fname = argv[1];
+		}
+		break;
+	case 3:
+		image_load_addr = hextoul(argv[1], NULL);
+		fname = argv[2];
+		break;
+	default:
+		return CMD_RET_USAGE;
+	}
+
+	col = strchr(fname, ':');
+	if (col) {
+		server_ip = fname;
+		*col = '\0';
+		fname = col + 1;
+	} else {
+		server_ip = env_get("serverip");
+		if (!server_ip) {
+			log_err("error: serverip variable has to be set\n");
+			return CMD_RET_FAILURE;
+		}
+	}
+	if (!ipaddr_aton(server_ip, &srvip)) {
+		log_err("error: ipaddr_aton\n");
+		return CMD_RET_FAILURE;
+	}
+
+	if (!fname) {
+		log_err("error: no file name\n");
+		return CMD_RET_FAILURE;
+	}
+
+	if (!image_load_addr) {
+		log_err("error: no load address\n");
+		return CMD_RET_FAILURE;
+	}
+
+	if (tftp_run(image_load_addr, fname, srvip) < 0)
+		return CMD_RET_FAILURE;
+
+	return CMD_RET_SUCCESS;
 }
-- 
2.40.1

