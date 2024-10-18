Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 311C7D30011
	for <u-boot@archiver.kernel.org>; Fri, 18 Oct 2024 14:23:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7A60D88995;
	Fri, 18 Oct 2024 16:23:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="zyWsYDlr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 48EB1890A9; Fri, 18 Oct 2024 16:23:21 +0200 (CEST)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C29AA89214
 for <u-boot@lists.denx.de>; Fri, 18 Oct 2024 16:23:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-43161e7bb25so6992615e9.2
 for <u-boot@lists.denx.de>; Fri, 18 Oct 2024 07:23:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729261388; x=1729866188; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pCU7nA8SvaZ2L8wUys7hUgWu2VDwSSg5urQxqoVo4kA=;
 b=zyWsYDlrMKUPhSude3UPI3iw9l0FVcTtmP12/WVjSgLeAkOL5IM1qowmRbwqHGxpLu
 05rP3k7m4mFKv1JmtRFsqFjaLOaAAdLqT2X6zkqLD+67QUYJFO/QY2+Nsf9bt6CVePR/
 c2D/yaJRkQySdUeospAy9+OyQ+D0xCNExgCkDJxk0Pov9wDMN4uC/ezOPRSeA1jyiCx+
 puoyq0LQIogbvWydrj/4r8iWZ9+ti6w75Mgn8B7tHt7EcU87s4PSln8xyFHIfR3mzCB0
 /YnpBjjEcujVs8l6lmIv8g1axERQr9QfDF0xgpkvkDxMcK+fmX9ZN1GAZWQYjYOHj8/o
 8EGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729261388; x=1729866188;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pCU7nA8SvaZ2L8wUys7hUgWu2VDwSSg5urQxqoVo4kA=;
 b=IkrLB7OU4vE8BAcffeDT02PnARgvGuzjgkpOW94Ljk8QeqwV713BQnS2CipHzOrLZE
 rMsLiTtN2mV+bKq8vilwK9XKDkrUMfZxoEV55GSxGKS7blj9upjFK42BFaZiLfXaGh8D
 aVt8Qzzx+N/28uDaOpllvObKaWoeaiM+slMDVBc+PSanA5iiaKTo0N/ycuU43UcF6t1Q
 gsBvNmsF1tr1c/+e3Cw7hKuW34tFafOSG28e/uXA95eXMvztWB+St+TiHavGEp578iMX
 IwAYTkCc5rf+n3yfzYXqJI+9j8oKPxzecvSh+EgayGTkir9DaNueuZ8czOOAJKGux6dV
 zJhg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUKaVUcl5OKVy9sU7q1HyBVB+0K2Yzv9AZJ06it5lle8GDbYsvyzmhGfUiQL/QvK963ZDo8sfA=@lists.denx.de
X-Gm-Message-State: AOJu0YwcVDnVIgj56XQgFGXQwLkbymIZ4JVypVdlxds7K/30pJSK/ZeU
 mNIgbH2AE/Kwao4CLz+JfP5PIl8x4ocSLLfjtV05sQwrabBzRSLKEX8emY/r6A4=
X-Google-Smtp-Source: AGHT+IGVoh3rU9fu91LubKzflzY608eEuTNf03aSBA9+brTcfbVFnLcNYKC3FB4yGC6iPuXrc2D4+Q==
X-Received: by 2002:a05:600c:3b05:b0:431:5e53:2dc4 with SMTP id
 5b1f17b1804b1-4316163612bmr22730135e9.6.1729261388126; 
 Fri, 18 Oct 2024 07:23:08 -0700 (PDT)
Received: from localhost.localdomain (ppp176092143132.access.hol.gr.
 [176.92.143.132]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4316067dc70sm28781665e9.10.2024.10.18.07.23.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Oct 2024 07:23:07 -0700 (PDT)
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: jerome.forissier@linaro.org,
	raymond.mao@linaro.org
Cc: xypron.glpk@gmx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Simon Glass <sjg@chromium.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Jonathan Humphreys <j-humphreys@ti.com>,
 Wei Ming Chen <jj251510319013@gmail.com>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Javier Tia <javier.tia@linaro.org>, u-boot@lists.denx.de
Subject: [PATCH 4/6] net: lwip: Enable https:// support for wget
Date: Fri, 18 Oct 2024 17:21:58 +0300
Message-ID: <20241018142235.715571-5-ilias.apalodimas@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241018142235.715571-1-ilias.apalodimas@linaro.org>
References: <20241018142235.715571-1-ilias.apalodimas@linaro.org>
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

With the recent changes of lwip & mbedTLS we can now download from
https:// urls instead of just http://.
Adjust our wget lwip version parsing to support both URLs.
While at it adjust the default TCP window for QEMU since https seems to
requite at least 16384

Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
 cmd/Kconfig      | 19 ++++++++++++
 net/lwip/Kconfig |  2 +-
 net/lwip/wget.c  | 78 +++++++++++++++++++++++++++++++++++++++++++-----
 3 files changed, 91 insertions(+), 8 deletions(-)

diff --git a/cmd/Kconfig b/cmd/Kconfig
index 8c677b1e4864..e58566a9ba34 100644
--- a/cmd/Kconfig
+++ b/cmd/Kconfig
@@ -2118,6 +2118,25 @@ config CMD_WGET
 	  wget is a simple command to download kernel, or other files,
 	  from a http server over TCP.
 
+config WGET_HTTPS
+	bool "wget https"
+	depends on CMD_WGET
+	depends on PROT_TCP_LWIP
+	depends on MBEDTLS_LIB
+        select SHA256
+        select RSA
+        select ASYMMETRIC_KEY_TYPE
+        select ASYMMETRIC_PUBLIC_KEY_SUBTYPE
+        select X509_CERTIFICATE_PARSER
+        select PKCS7_MESSAGE_PARSER
+	select MBEDTLS_LIB_CRYPTO
+	select MBEDTLS_LIB_TLS
+	select RSA_VERIFY_WITH_PKEY
+	select X509_CERTIFICATE_PARSER
+	select PKCS7_MESSAGE_PARSER
+	help
+	  Enable TLS over http for wget.
+
 endif  # if CMD_NET
 
 config CMD_PXE
diff --git a/net/lwip/Kconfig b/net/lwip/Kconfig
index 8a67de4cf335..a9ae9bf7fa2a 100644
--- a/net/lwip/Kconfig
+++ b/net/lwip/Kconfig
@@ -37,7 +37,7 @@ config PROT_UDP_LWIP
 
 config LWIP_TCP_WND
 	int "Value of TCP_WND"
-	default 8000 if ARCH_QEMU
+	default 32768 if ARCH_QEMU
 	default 3000000
 	help
 	  Default value for TCP_WND in the lwIP configuration
diff --git a/net/lwip/wget.c b/net/lwip/wget.c
index b495ebd1aa96..b4f039d38962 100644
--- a/net/lwip/wget.c
+++ b/net/lwip/wget.c
@@ -7,13 +7,17 @@
 #include <efi_loader.h>
 #include <image.h>
 #include <lwip/apps/http_client.h>
+#include "lwip/altcp_tls.h"
 #include <lwip/timeouts.h>
+#include <rng.h>
 #include <mapmem.h>
 #include <net.h>
 #include <time.h>
+#include <dm/uclass.h>
 
 #define SERVER_NAME_SIZE 200
 #define HTTP_PORT_DEFAULT 80
+#define HTTPS_PORT_DEFAULT 443
 #define PROGRESS_PRINT_STEP_BYTES (100 * 1024)
 
 enum done_state {
@@ -32,18 +36,53 @@ struct wget_ctx {
 	enum done_state done;
 };
 
+bool wget_validate_uri(char *uri);
+
+int mbedtls_hardware_poll(void *data, unsigned char *output, size_t len,
+			  size_t *olen)
+{
+	struct udevice *dev;
+	u64 rng = 0;
+	int err;
+
+	*olen = 0;
+
+	err = uclass_get_device(UCLASS_RNG, 0, &dev);
+	if (err)
+		return err;
+	err = dm_rng_read(dev, &rng, sizeof(rng));
+	if (err) {
+		log_err("Failed to get an rng: %d\n", err);
+		return err;
+	}
+
+	memcpy(output, &rng, len);
+	*olen = sizeof(rng);
+
+	return 0;
+}
+
 static int parse_url(char *url, char *host, u16 *port, char **path)
 {
 	char *p, *pp;
 	long lport;
+	size_t prefix_len = 0;
+
+	if (!wget_validate_uri(url)) {
+		log_err("Invalid URL. Use http(s)://\n");
+		return -EINVAL;
+	}
 
+	*port = HTTP_PORT_DEFAULT;
+	prefix_len = strlen("http://");
 	p = strstr(url, "http://");
 	if (!p) {
-		log_err("only http:// is supported\n");
-		return -EINVAL;
+		p = strstr(url, "https://");
+		prefix_len = strlen("https://");
+		*port = HTTPS_PORT_DEFAULT;
 	}
 
-	p += strlen("http://");
+	p += prefix_len;
 
 	/* Parse hostname */
 	pp = strchr(p, ':');
@@ -67,9 +106,8 @@ static int parse_url(char *url, char *host, u16 *port, char **path)
 		if (lport > 65535)
 			return -EINVAL;
 		*port = (u16)lport;
-	} else {
-		*port = HTTP_PORT_DEFAULT;
 	}
+
 	if (*pp != '/')
 		return -EINVAL;
 	*path = pp;
@@ -210,6 +248,9 @@ static void httpc_result_cb(void *arg, httpc_result_t httpc_result,
 static int wget_loop(struct udevice *udev, ulong dst_addr, char *uri)
 {
 	char server_name[SERVER_NAME_SIZE];
+#if defined CONFIG_WGET_HTTPS
+	altcp_allocator_t tls_allocator;
+#endif
 	httpc_connection_t conn;
 	httpc_state_t *state;
 	struct netif *netif;
@@ -232,6 +273,22 @@ static int wget_loop(struct udevice *udev, ulong dst_addr, char *uri)
 		return -1;
 
 	memset(&conn, 0, sizeof(conn));
+#if defined CONFIG_WGET_HTTPS
+	if (port == HTTPS_PORT_DEFAULT) {
+		tls_allocator.alloc = &altcp_tls_alloc;
+		tls_allocator.arg =
+			altcp_tls_create_config_client(NULL, 0, server_name);
+
+		if (!tls_allocator.arg) {
+			log_err("error: Cannot create a TLS connection\n");
+			net_lwip_remove_netif(netif);
+			return -1;
+		}
+
+		conn.altcp_allocator = &tls_allocator;
+	}
+#endif
+
 	conn.result_fn = httpc_result_cb;
 	ctx.path = path;
 	if (httpc_get_file_dns(server_name, port, path, &conn, httpc_recv_cb,
@@ -316,6 +373,7 @@ bool wget_validate_uri(char *uri)
 	char c;
 	bool ret = true;
 	char *str_copy, *s, *authority;
+	size_t prefix_len = 0;
 
 	for (c = 0x1; c < 0x21; c++) {
 		if (strchr(uri, c)) {
@@ -323,15 +381,21 @@ bool wget_validate_uri(char *uri)
 			return false;
 		}
 	}
+
 	if (strchr(uri, 0x7f)) {
 		log_err("invalid character is used\n");
 		return false;
 	}
 
-	if (strncmp(uri, "http://", 7)) {
-		log_err("only http:// is supported\n");
+	if (!strncmp(uri, "http://", strlen("http://"))) {
+		prefix_len = strlen("http://");
+	} else if (!strncmp(uri, "https://", strlen("https://"))) {
+		prefix_len = strlen("https://");
+	} else {
+		log_err("only http(s):// is supported\n");
 		return false;
 	}
+
 	str_copy = strdup(uri);
 	if (!str_copy)
 		return false;
-- 
2.45.2

