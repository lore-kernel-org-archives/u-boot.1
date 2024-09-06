Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CE28CE7AA3
	for <u-boot@archiver.kernel.org>; Fri,  6 Sep 2024 12:36:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C3F1988D14;
	Fri,  6 Sep 2024 14:35:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="VbMK5VOy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D02CE88C5C; Fri,  6 Sep 2024 14:35:17 +0200 (CEST)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A675B88D01
 for <u-boot@lists.denx.de>; Fri,  6 Sep 2024 14:35:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-42c828c8863so15820375e9.3
 for <u-boot@lists.denx.de>; Fri, 06 Sep 2024 05:35:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725626115; x=1726230915; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Dk1E6bbPmuHVmDWi+bXNHdS05tNkUb9LID8rauCyscc=;
 b=VbMK5VOyykPOvHs5js9bWfoGYk15c9unHK0sjSya+FdWXgYkQEHorGF/Q62u9VSN2w
 ev+t518ERwtBmwnBj5PpEecM83n1kmHmrEaa5QyOzFb6jLEoEeIkoMzJ7kul7kOcbg8j
 218AHgaBVsuzEMb84lZ/62aHM+3JLp7IWvMkafL6f7fqZLk/Y8uZknowRP41bFpnmxpi
 zWSGoeloeQ3WapPSXe5Y/kKtEDLD6ZazqDDoFTnzmdUT/T6IjU+++iUEtiidF39Z0sek
 eQXU3d4apIjX7pukt9jd1NjtRtDuatk58NQbO07zB6o2WWIA3NX6+fEmwZhrrcDWKzNT
 sxOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725626115; x=1726230915;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Dk1E6bbPmuHVmDWi+bXNHdS05tNkUb9LID8rauCyscc=;
 b=uNYFUs0rgj+YTw94xBzKGvqQr5SiciqCgqk+3kfDWhCvdbyQPf+CkIU5xew1CUAcvG
 kYo+TqIRmE9DjKTQYk9ckNBGUz+EtzepSl2gziffPFouRB/y6msQXyxNDViDYX1gJQoO
 EOvYFwoaulyNcsuPbiZXXo3+DeAKvSdrX4b3Q9xVUGxMT1xuUKJMuozik2h005FeZJLy
 +dGTDmNFvIevbmQcPUCrkVb+oEAssX6Yw6uY2jIDrYX1X2DLVvaTXQWM7uFdJfNoSR7d
 gLOQf8rnngQUFNdJK5ycXj+5CzmEz6at9phzT7B3d8YMSo+AKN6rmSZTbIQMk7MRDNmW
 kGIQ==
X-Gm-Message-State: AOJu0YxSVZIoE2KCVaTFGA/HKjrib5uLL9B8Ajsn5oat4RuELOVPcWlu
 MXrOklRUVlcBTRKbBjcoqM+/rJj7mcfIATgRdezV3NgzJ6LRqDq6Vo0k/XW6co/L08IufiGnnMX
 jehEdMFYK
X-Google-Smtp-Source: AGHT+IGJqewCWqpJyCQix4VTaBb8768YU0Etq2ZKZJDRB4aAkBl5pk9Z2YZh2OEX1/qz1Sakhtdyaw==
X-Received: by 2002:a05:600c:1385:b0:426:66a2:b200 with SMTP id
 5b1f17b1804b1-42c9f8eeed8mr17689175e9.0.1725626114778; 
 Fri, 06 Sep 2024 05:35:14 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:1ff1:215c:d8a4:9f99])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42ca05cf0e8sm19640125e9.27.2024.09.06.05.35.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Sep 2024 05:35:14 -0700 (PDT)
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
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Jonathan Humphreys <j-humphreys@ti.com>
Subject: [PATCH v10 13/25] net-lwip: add wget command
Date: Fri,  6 Sep 2024 14:33:29 +0200
Message-Id: <fb9cb527b8c2922b37ff27e839128d0facfcf095.1725625913.git.jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1725625913.git.jerome.forissier@linaro.org>
References: <cover.1725625913.git.jerome.forissier@linaro.org>
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

Add support for the wget command with NET_LWIP. The command normally
expects a URL: wget [loadaddr] url, but it also accepts the legacy
syntax: wget [loadaddr] [server:]file.
The server IP may alternatively be supplied via ${httpserverip} which
has higher priority than ${serverip}.

Based on code initially developed by Maxim U.

Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
Co-developed-by: Maxim Uvarov <muvarov@gmail.com>
Cc: Maxim Uvarov <muvarov@gmail.com>
Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
---
 cmd/Kconfig        |  18 ++-
 cmd/net-lwip.c     |   8 +
 include/net-lwip.h |  18 +++
 net/lwip/Makefile  |   1 +
 net/lwip/wget.c    | 363 +++++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 400 insertions(+), 8 deletions(-)
 create mode 100644 net/lwip/wget.c

diff --git a/cmd/Kconfig b/cmd/Kconfig
index 3a92e18996c..7a49042b4b8 100644
--- a/cmd/Kconfig
+++ b/cmd/Kconfig
@@ -2000,14 +2000,6 @@ config SYS_DISABLE_AUTOLOAD
 	  is complete.  Enable this option to disable this behavior and instead
 	  require files to be loaded over the network by subsequent commands.
 
-config CMD_WGET
-	bool "wget"
-	select PROT_TCP
-	default y if SANDBOX
-	help
-	  wget is a simple command to download kernel, or other files,
-	  from a http server over TCP.
-
 config CMD_PING6
 	bool "ping6"
 	depends on IPV6
@@ -2122,6 +2114,16 @@ config CMD_TFTPBOOT
 	help
 	  tftpboot - load file via network using TFTP protocol
 
+config CMD_WGET
+	bool "wget"
+	default y if SANDBOX
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
index ff9d03b23e8..1c3583f82a1 100644
--- a/include/net-lwip.h
+++ b/include/net-lwip.h
@@ -16,8 +16,26 @@ void net_lwip_remove_netif(struct netif *netif);
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
index 00000000000..e8768fc2acd
--- /dev/null
+++ b/net/lwip/wget.c
@@ -0,0 +1,363 @@
+// SPDX-License-Identifier: GPL-2.0+
+/* Copyright (C) 2024 Linaro Ltd. */
+
+#include <command.h>
+#include <console.h>
+#include <display_options.h>
+#include <efi_loader.h>
+#include <image.h>
+#include <lwip/apps/http_client.h>
+#include <lwip/timeouts.h>
+#include <mapmem.h>
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
+	char *path;
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
+/*
+ * Legacy syntax support
+ * Convert [<server_name_or_ip>:]filename into a URL if needed
+ */
+static int parse_legacy_arg(char *arg, char *nurl, size_t rem)
+{
+	char *p = nurl;
+	size_t n;
+	char *col = strchr(arg, ':');
+	char *env;
+	char *server;
+	char *path;
+
+	if (strstr(arg, "http") == arg) {
+		n = snprintf(nurl, rem, "%s", arg);
+		if (n < 0 || n > rem)
+			return -1;
+		return 0;
+	}
+
+	n = snprintf(p, rem, "%s", "http://");
+	if (n < 0 || n > rem)
+		return -1;
+	p += n;
+	rem -= n;
+
+	if (col) {
+		n = col - arg;
+		server = arg;
+		path = col + 1;
+	} else {
+		env = env_get("httpserverip");
+		if (!env)
+			env = env_get("serverip");
+		if (!env) {
+			log_err("error: httpserver/serverip has to be set\n");
+			return -1;
+		}
+		n = strlen(env);
+		server = env;
+		path = arg;
+	}
+
+	if (rem < n)
+		return -1;
+	strncpy(p, server, n);
+	p += n;
+	rem -= n;
+	if (rem < 1)
+		return -1;
+	*p = '/';
+	p++;
+	rem--;
+	n = strlen(path);
+	if (rem < n)
+		return -1;
+	strncpy(p, path, n);
+	p += n;
+	rem -= n;
+	if (rem < 1)
+		return -1;
+	*p = '\0';
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
+	if (!ctx->start_time)
+		ctx->start_time = get_timer(0);
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
+	if (srv_res != 200) {
+		log_err("\nHTTP server error %d\n", srv_res);
+		ctx->done = FAILURE;
+		return;
+	}
+
+	elapsed = get_timer(ctx->start_time);
+	if (!elapsed)
+		elapsed = 1;
+	if (rx_content_len > PROGRESS_PRINT_STEP_BYTES)
+		printf("\n");
+	printf("%u bytes transferred in %lu ms (", rx_content_len, elapsed);
+	print_size(rx_content_len / elapsed * 1000, "/s)\n");
+	printf("Bytes transferred = %lu (%lx hex)\n", ctx->size, ctx->size);
+	efi_set_bootdev("Net", "", ctx->path, map_sysmem(ctx->saved_daddr, 0),
+			rx_content_len);
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
+	ctx.start_time = 0;
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
+	ctx.path = path;
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
+	char nurl[1024];
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
+	if (parse_legacy_arg(url, nurl, sizeof(nurl)))
+	    return CMD_RET_FAILURE;
+
+	if (wget_with_dns(dst_addr, nurl))
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

