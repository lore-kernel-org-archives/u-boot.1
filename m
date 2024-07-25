Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB61DC3DA49
	for <u-boot@archiver.kernel.org>; Thu, 25 Jul 2024 13:00:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A83F988385;
	Thu, 25 Jul 2024 14:59:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="cr97Jk2N";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 14ECB86D4C; Thu, 25 Jul 2024 14:59:06 +0200 (CEST)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A19ED880DE
 for <u-boot@lists.denx.de>; Thu, 25 Jul 2024 14:59:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-42797289c8bso7084495e9.0
 for <u-boot@lists.denx.de>; Thu, 25 Jul 2024 05:59:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721912343; x=1722517143; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OBzvGTI/CCakp36J8A2xLkcn7y3/6tKE/LMvMIOvaHo=;
 b=cr97Jk2N1CGE8fDVuI4yMgLKblRYegtq9h3YvlEXWxNPf9tu+PwYV1Ac5b2NYJN0Ie
 szmGj6dcnn1gPacScXDTrN99cy6Eijz0WFpyUPKzLncl8VI7gGVpz9Kbm1I41LH7XIDu
 /dtgHXiJCZ//e1mpTNnPPApo8wNz//IQxaiyP3Re1mOpDJk6FMIuHiokvb+59T9d9UO6
 M6OTOfjmGeltGfQTj2U72yxBvhdTXmoLyEtP1p/rG0gdg/3d3bEhdxCdas+YVdzkq52o
 3TT+RqVrrnzEwXtl2Icha8oGZtcymEnXqiE4RTUKxNJQRhqPhmvnGGhOVij0in5HaqmY
 WdsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721912343; x=1722517143;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OBzvGTI/CCakp36J8A2xLkcn7y3/6tKE/LMvMIOvaHo=;
 b=qPQLUDBMSA31tmTjgMqJKl3cDt+pvK4oxFU7y9FHR+2vKjg0GJCPi2d8BYJ9h6c07A
 2GhmLQLif6bfjiZDP849ltP8TmzPdluAWhI3frGxUIGAJAv6y97u+FpwgQ9lmfKY5uip
 JaId+nIc6YnrLfGGnHiXKkXWVfqxEsjH/aVZtHSGcXDpZ/LED/iuwCJ49Gz10uT9rDN0
 z7RY+ypdiSxMvj6qG5YlF0K9Wb2Az/dzqWnvAbek44r9jUqfOvlbPowkPPTt9NRn+tN0
 HJlnEzonKDFsm8AaEiMiuNIqCaXeGYRrxADE4+w4lyTFMrusWpytjMU7ZYT0QCLTgxEM
 JGFw==
X-Gm-Message-State: AOJu0YzNIcNGVfiGkH/Os/ZNHZT8KzvlzE9j6pR9dO1mLPTvcJ9MoHgS
 3BuBmSU4ccL1wEiK2IVfH8OwP58iD86uBoHfAiE2sU5x8It6jX0i29ZmUCYkQXJKb+sWKbG2Iap
 0vPmmTg==
X-Google-Smtp-Source: AGHT+IGYwpyHlFxyRbZQwXMX3YRCiX0zOYguAsEHXAFfNUSNbhUsvPKKlr9NpNzRfaTULm8eCU3srg==
X-Received: by 2002:a05:600c:1392:b0:426:5416:67e0 with SMTP id
 5b1f17b1804b1-4280574895bmr16151325e9.31.1721912342864; 
 Thu, 25 Jul 2024 05:59:02 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:a701:ef5f:d613:3e14])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4280573fd83sm34765205e9.19.2024.07.25.05.59.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jul 2024 05:59:02 -0700 (PDT)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Javier Tia <javier.tia@linaro.org>, Raymond Mao <raymond.mao@linaro.org>,
 Maxim Uvarov <muvarov@gmail.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Tom Rini <trini@konsulko.com>, Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Simon Glass <sjg@chromium.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Francis Laniel <francis.laniel@amarulasolutions.com>,
 Jonathan Humphreys <j-humphreys@ti.com>
Subject: [PATCH v5 13/20] net-lwip: add wget command
Date: Thu, 25 Jul 2024 14:57:34 +0200
Message-Id: <50837ffb4da3cc02f3b7a1b0832656d03747ca57.1721910373.git.jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1721910373.git.jerome.forissier@linaro.org>
References: <cover.1721910373.git.jerome.forissier@linaro.org>
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

Add support for the wget command with NET_LWIP.

Based on code initially developed by Maxim U.

Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
Co-developed-by: Maxim Uvarov <muvarov@gmail.com>
Cc: Maxim Uvarov <muvarov@gmail.com>
Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
---
 cmd/Kconfig        |  16 +--
 cmd/net-lwip.c     |   8 ++
 include/net-lwip.h |  18 +++
 net/lwip/Makefile  |   1 +
 net/lwip/wget.c    | 278 +++++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 314 insertions(+), 7 deletions(-)
 create mode 100644 net/lwip/wget.c

diff --git a/cmd/Kconfig b/cmd/Kconfig
index a862b6415dd..1251a996809 100644
--- a/cmd/Kconfig
+++ b/cmd/Kconfig
@@ -1986,13 +1986,6 @@ config SYS_DISABLE_AUTOLOAD
 	  is complete.  Enable this option to disable this behavior and instead
 	  require files to be loaded over the network by subsequent commands.
 
-config CMD_WGET
-	bool "wget"
-	select PROT_TCP
-	help
-	  wget is a simple command to download kernel, or other files,
-	  from a http server over TCP.
-
 config CMD_MII
 	bool "mii"
 	imply CMD_MDIO
@@ -2109,6 +2102,15 @@ config CMD_TFTPBOOT
 	  tftpboot - load file via network using TFTP protocol
 	  Currently a placeholder (not implemented) when NET_LWIP=y.
 
+config CMD_WGET
+	bool "wget"
+	select PROT_TCP if NET
+	select PROT_TCP_LWIP if NET_LWIP
+	select PROT_DNS_LWIP if NET_LWIP
+	help
+	  wget is a simple command to download kernel, or other files,
+	  from a http server over TCP.
+
 endif  # if CMD_NET
 
 endif  # if NET || NET_LWIP
diff --git a/cmd/net-lwip.c b/cmd/net-lwip.c
index c021da6a674..42f8bd6b259 100644
--- a/cmd/net-lwip.c
+++ b/cmd/net-lwip.c
@@ -35,3 +35,11 @@ U_BOOT_CMD(
 	"hostname [envvar]"
 );
 #endif
+
+#if defined(CONFIG_CMD_WGET)
+U_BOOT_CMD(
+	wget,   3,      1,      do_wget,
+	"boot image via network using HTTP protocol",
+	"[loadAddress] URL"
+);
+#endif
diff --git a/include/net-lwip.h b/include/net-lwip.h
index cb60537f9f3..f5d9255ccaf 100644
--- a/include/net-lwip.h
+++ b/include/net-lwip.h
@@ -12,8 +12,26 @@ void net_lwip_remove_netif(struct netif *netif);
 struct netif *net_lwip_get_netif(void);
 int net_lwip_rx(struct udevice *udev, struct netif *netif);
 
+/**
+ * wget_with_dns() - runs dns host IP address resulution before wget
+ *
+ * @dst_addr:	destination address to download the file
+ * @uri:	uri string of target file of wget
+ * Return:	downloaded file size, negative if failed
+ */
+
+int wget_with_dns(ulong dst_addr, char *uri);
+/**
+ * wget_validate_uri() - varidate the uri
+ *
+ * @uri:	uri string of target file of wget
+ * Return:	true if uri is valid, false if uri is invalid
+ */
+bool wget_validate_uri(char *uri);
+
 int do_dhcp(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[]);
 int do_dns(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[]);
 int do_ping(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[]);
+int do_wget(struct cmd_tbl *cmdtp, int flag, int argc, char * const argv[]);
 
 #endif /* __NET_LWIP_H__ */
diff --git a/net/lwip/Makefile b/net/lwip/Makefile
index 645d8a8c457..f2558f8763a 100644
--- a/net/lwip/Makefile
+++ b/net/lwip/Makefile
@@ -5,3 +5,4 @@ obj-$(CONFIG_CMD_DHCP) += dhcp.o
 obj-$(CONFIG_CMD_DNS) += dns.o
 obj-$(CONFIG_CMD_PING) += ping.o
 obj-$(CONFIG_CMD_TFTPBOOT) += tftp.o
+obj-$(CONFIG_CMD_WGET) += wget.o
diff --git a/net/lwip/wget.c b/net/lwip/wget.c
new file mode 100644
index 00000000000..65a69fab6e8
--- /dev/null
+++ b/net/lwip/wget.c
@@ -0,0 +1,278 @@
+// SPDX-License-Identifier: GPL-2.0+
+/* Copyright (C) 2024 Linaro Ltd. */
+
+#include <command.h>
+#include <console.h>
+#include <display_options.h>
+#include <image.h>
+#include <lwip/apps/http_client.h>
+#include <lwip/timeouts.h>
+#include <net.h>
+#include <time.h>
+
+#define SERVER_NAME_SIZE 200
+#define HTTP_PORT_DEFAULT 80
+#define PROGRESS_PRINT_STEP_BYTES (100 * 1024)
+
+enum done_state {
+        NOT_DONE = 0,
+        SUCCESS = 1,
+        FAILURE = 2
+};
+
+struct wget_ctx {
+	ulong daddr;
+	ulong saved_daddr;
+	ulong size;
+	ulong prevsize;
+	ulong start_time;
+	enum done_state done;
+};
+
+static int parse_url(char *url, char *host, u16 *port, char **path)
+{
+	char *p, *pp;
+	long lport;
+
+	p = strstr(url, "http://");
+	if (!p) {
+		log_err("only http:// is supported\n");
+		return -EINVAL;
+	}
+
+	p += strlen("http://");
+
+	/* Parse hostname */
+	pp = strchr(p, ':');
+	if (!pp)
+		pp = strchr(p, '/');
+	if (!pp)
+		return -EINVAL;
+
+	if (p + SERVER_NAME_SIZE <= pp)
+		return -EINVAL;
+
+	memcpy(host, p, pp - p);
+	host[pp - p] = '\0';
+
+	if (*pp == ':') {
+		/* Parse port number */
+		p = pp + 1;
+		lport = simple_strtol(p, &pp, 10);
+		if (pp && *pp != '/')
+			return -EINVAL;
+		if (lport > 65535)
+			return -EINVAL;
+		*port = (u16)lport;
+	} else {
+		*port = HTTP_PORT_DEFAULT;
+	}
+	if (*pp != '/')
+		return -EINVAL;
+	*path = pp;
+
+	return 0;
+}
+
+static err_t httpc_recv_cb(void *arg, struct altcp_pcb *pcb, struct pbuf *pbuf,
+			   err_t err)
+{
+	struct wget_ctx *ctx = arg;
+	struct pbuf *buf;
+
+	if (!pbuf)
+		return ERR_BUF;
+
+	for (buf = pbuf; buf; buf = buf->next) {
+		memcpy((void *)ctx->daddr, buf->payload, buf->len);
+		ctx->daddr += buf->len;
+		ctx->size += buf->len;
+		if (ctx->size - ctx->prevsize > PROGRESS_PRINT_STEP_BYTES) {
+			printf("#");
+			ctx->prevsize = ctx->size;
+		}
+	}
+
+	altcp_recved(pcb, pbuf->tot_len);
+	pbuf_free(pbuf);
+	return ERR_OK;
+}
+
+static void httpc_result_cb(void *arg, httpc_result_t httpc_result,
+			    u32_t rx_content_len, u32_t srv_res, err_t err)
+{
+	struct wget_ctx *ctx = arg;
+	ulong elapsed;
+
+	if (httpc_result != HTTPC_RESULT_OK) {
+		log_err("\nHTTP client error %d\n", httpc_result);
+		ctx->done = FAILURE;
+		return;
+	}
+
+	elapsed = get_timer(ctx->start_time);
+	if (rx_content_len > PROGRESS_PRINT_STEP_BYTES)
+		printf("\n");
+        printf("%u bytes transferred in %lu ms (", rx_content_len,
+	       get_timer(ctx->start_time));
+        print_size(rx_content_len / elapsed * 1000, "/s)\n");
+
+	if (env_set_hex("filesize", rx_content_len) ||
+	    env_set_hex("fileaddr", ctx->saved_daddr)) {
+		log_err("Could not set filesize or fileaddr\n");
+		ctx->done = FAILURE;
+		return;
+	}
+
+	ctx->done = SUCCESS;
+}
+
+static int wget_loop(struct udevice *udev, ulong dst_addr, char *uri)
+{
+	char server_name[SERVER_NAME_SIZE];
+	httpc_connection_t conn;
+	httpc_state_t *state;
+	struct netif *netif;
+	struct wget_ctx ctx;
+	char *path;
+	u16 port;
+
+	ctx.daddr = dst_addr;
+	ctx.saved_daddr = dst_addr;
+	ctx.done = NOT_DONE;
+	ctx.size = 0;
+	ctx.prevsize = 0;
+
+	if (parse_url(uri, server_name, &port, &path))
+		return CMD_RET_USAGE;
+
+	netif = net_lwip_new_netif(udev);
+	if (!netif)
+		return -1;
+
+	memset(&conn, 0, sizeof(conn));
+	conn.result_fn = httpc_result_cb;
+	ctx.start_time = get_timer(0);
+	if (httpc_get_file_dns(server_name, port, path, &conn, httpc_recv_cb,
+			       &ctx, &state)) {
+		net_lwip_remove_netif(netif);
+		return CMD_RET_FAILURE;
+	}
+
+	while (!ctx.done) {
+		net_lwip_rx(udev, netif);
+		sys_check_timeouts();
+		if (ctrlc())
+			break;
+	}
+
+	net_lwip_remove_netif(netif);
+
+	if (ctx.done == SUCCESS)
+		return 0;
+
+	return -1;
+}
+
+int wget_with_dns(ulong dst_addr, char *uri)
+{
+	eth_set_current();
+
+	return wget_loop(eth_get_dev(), dst_addr, uri);
+}
+
+int do_wget(struct cmd_tbl *cmdtp, int flag, int argc, char * const argv[])
+{
+	char *end;
+	char *url;
+	ulong dst_addr;
+
+	if (argc < 2 || argc > 3)
+		return CMD_RET_USAGE;
+
+	dst_addr = hextoul(argv[1], &end);
+        if (end == (argv[1] + strlen(argv[1]))) {
+		if (argc < 3)
+			return CMD_RET_USAGE;
+		url = argv[2];
+	} else {
+		dst_addr = image_load_addr;
+		url = argv[1];
+	}
+
+	if (wget_with_dns(dst_addr, url))
+		return CMD_RET_FAILURE;
+
+	return CMD_RET_SUCCESS;
+}
+
+/**
+ * wget_validate_uri() - validate the uri for wget
+ *
+ * @uri:	uri string
+ *
+ * This function follows the current U-Boot wget implementation.
+ * scheme: only "http:" is supported
+ * authority:
+ *   - user information: not supported
+ *   - host: supported
+ *   - port: not supported(always use the default port)
+ *
+ * Uri is expected to be correctly percent encoded.
+ * This is the minimum check, control codes(0x1-0x19, 0x7F, except '\0')
+ * and space character(0x20) are not allowed.
+ *
+ * TODO: stricter uri conformance check
+ *
+ * Return:	true on success, false on failure
+ */
+bool wget_validate_uri(char *uri)
+{
+	char c;
+	bool ret = true;
+	char *str_copy, *s, *authority;
+
+	for (c = 0x1; c < 0x21; c++) {
+		if (strchr(uri, c)) {
+			log_err("invalid character is used\n");
+			return false;
+		}
+	}
+	if (strchr(uri, 0x7f)) {
+		log_err("invalid character is used\n");
+		return false;
+	}
+
+	if (strncmp(uri, "http://", 7)) {
+		log_err("only http:// is supported\n");
+		return false;
+	}
+	str_copy = strdup(uri);
+	if (!str_copy)
+		return false;
+
+	s = str_copy + strlen("http://");
+	authority = strsep(&s, "/");
+	if (!s) {
+		log_err("invalid uri, no file path\n");
+		ret = false;
+		goto out;
+	}
+	s = strchr(authority, '@');
+	if (s) {
+		log_err("user information is not supported\n");
+		ret = false;
+		goto out;
+	}
+	s = strchr(authority, ':');
+	if (s) {
+		log_err("user defined port is not supported\n");
+		ret = false;
+		goto out;
+	}
+
+out:
+	free(str_copy);
+
+	return ret;
+}
-- 
2.40.1

