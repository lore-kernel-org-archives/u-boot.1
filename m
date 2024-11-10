Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08532D5E39B
	for <u-boot@archiver.kernel.org>; Sun, 10 Nov 2024 08:32:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8F65C89357;
	Sun, 10 Nov 2024 09:32:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="o+xllEF2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BA2CC89363; Sun, 10 Nov 2024 09:32:05 +0100 (CET)
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com
 [IPv6:2a00:1450:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ADF8488FBF
 for <u-boot@lists.denx.de>; Sun, 10 Nov 2024 09:32:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-a9f1d76dab1so6136166b.0
 for <u-boot@lists.denx.de>; Sun, 10 Nov 2024 00:32:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731227523; x=1731832323; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=admDE4/bizsiymrBJH4OfpWSL1b72cHZuDI39oj7fMs=;
 b=o+xllEF2OhmGnsZz0e5lfiCeCkflEI9MxomDVRuNjFaIe/Z5BODqJ2lWbOgbQw844j
 jcgVxcNExO/j1KAKLNFeU7DF1UvZBy3bt32l8osCdzAVdtYc5O8cU/rmZUKbI5qWymCt
 yCa2q9/gtwn3heBvoN/lNkWloPBifn4N9KKFKpZQd++lSg8nga0qh9DOb/hbw9nI2EKY
 ZpswiQHysv5HZaSTB3QpJJ+zK+R9AhTKY1DAmitJo5r0ABgHFDlBOKmAP/l/6IygcMDb
 oz1dkJKYY/HOEhF8knRcTuU+v6OIoYVJrvtsm3GdwZyQ3ulni3NsU+OHc8frRtoSfJRS
 HsBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731227523; x=1731832323;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=admDE4/bizsiymrBJH4OfpWSL1b72cHZuDI39oj7fMs=;
 b=F9ywKH3h4QETyNZ5/gN8HSnt0LbBESDJKn5L9mlpj6kNId0IRNlJ3FDW5hO4dhhYa2
 7pAQbvv4l9MheZOj9fQ+8sm6wFeyr8Iw1FIc5E6q8TT252Swdxf+lCQcZODtbZojJ5pw
 tM8A6hzLI7mMkj341DuMfB96J7eaAIfUmeoL+u1Kw6PEqb0UfCrndTiG9dBI9HgKId4T
 PWlKijRBQHTPbuKaJMcTlNm3Ijpk/d0nNbXkvvlhk1cUD6oQrcI+zX6PXQG/TgVL+NoO
 Ch9ZFdjj40xcj6Xhv49P3ovk5+6di1+3b7ouBcQV1uVR1+F+m/CXX4ooV9jt5bLUjfyX
 ouiw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUOO1/TKLGEVsN0tAGCAonpumOVACgrqI9yuttMTA1d6GM+CR92mS4Ddlqad0VDRZzHmNlxiDE=@lists.denx.de
X-Gm-Message-State: AOJu0YwRwZ5kKJ8z6rJlDiw5iqIjEhRdKTl9267twPCcZiT0LE3D7cB2
 Ef5lGhDdj5V+9c7A7soh8byUbU6gs1AZ7xZ3piF0uBS1mewafaKj2q9KHfG9klg=
X-Google-Smtp-Source: AGHT+IF5Ucp8YuJhrmKQe2jbiOBqN4cdpn+F1ePwdXIFe1saPorXpQfuDv7jLJzRMWZAOVMXDigV5g==
X-Received: by 2002:a17:907:2d0c:b0:a9a:7f87:904b with SMTP id
 a640c23a62f3a-a9eeff44762mr907096566b.29.1731227523108; 
 Sun, 10 Nov 2024 00:32:03 -0800 (PST)
Received: from hades.. (ppp176092143132.access.hol.gr. [176.92.143.132])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9ee0a17b3csm451909166b.19.2024.11.10.00.32.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 10 Nov 2024 00:32:02 -0800 (PST)
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: jerome.forissier@linaro.org
Cc: Anton.Antonov@arm.com, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Simon Glass <sjg@chromium.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Dmitry Rokosov <ddrokosov@salutedevices.com>,
 Peter Robinson <pbrobinson@gmail.com>,
 Jonathan Humphreys <j-humphreys@ti.com>,
 Wei Ming Chen <jj251510319013@gmail.com>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Javier Tia <javier.tia@linaro.org>, Raymond Mao <raymond.mao@linaro.org>,
 u-boot@lists.denx.de
Subject: [PATCH v3 4/6] net: lwip: Enable https:// support for wget
Date: Sun, 10 Nov 2024 10:28:40 +0200
Message-ID: <20241110083017.367565-5-ilias.apalodimas@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241110083017.367565-1-ilias.apalodimas@linaro.org>
References: <20241110083017.367565-1-ilias.apalodimas@linaro.org>
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
require at least 16384

Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
 cmd/Kconfig      | 19 +++++++++++
 net/lwip/Kconfig |  2 +-
 net/lwip/wget.c  | 86 +++++++++++++++++++++++++++++++++++++++++++-----
 3 files changed, 97 insertions(+), 10 deletions(-)

diff --git a/cmd/Kconfig b/cmd/Kconfig
index 636833646f6e..b2d0348fe309 100644
--- a/cmd/Kconfig
+++ b/cmd/Kconfig
@@ -2124,6 +2124,25 @@ config CMD_WGET
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
index b495ebd1aa96..ba8579899002 100644
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
@@ -32,18 +36,56 @@ struct wget_ctx {
 	enum done_state done;
 };
 
-static int parse_url(char *url, char *host, u16 *port, char **path)
+bool wget_validate_uri(char *uri);
+
+int mbedtls_hardware_poll(void *data, unsigned char *output, size_t len,
+			  size_t *olen)
+{
+	struct udevice *dev;
+	u64 rng = 0;
+	int ret;
+
+	*olen = 0;
+
+	ret = uclass_get_device(UCLASS_RNG, 0, &dev);
+	if (ret) {
+		log_err("Failed to get an rng: %d\n", ret);
+		return ret;
+	}
+	ret = dm_rng_read(dev, &rng, sizeof(rng));
+	if (ret)
+		return ret;
+
+	memcpy(output, &rng, len);
+	*olen = sizeof(rng);
+
+	return 0;
+}
+
+static int parse_url(char *url, char *host, u16 *port, char **path,
+		     bool *is_https)
 {
 	char *p, *pp;
 	long lport;
+	size_t prefix_len = 0;
+
+	if (!wget_validate_uri(url)) {
+		log_err("Invalid URL. Use http(s)://\n");
+		return -EINVAL;
+	}
 
+	*is_https = false;
+	*port = HTTP_PORT_DEFAULT;
+	prefix_len = strlen("http://");
 	p = strstr(url, "http://");
 	if (!p) {
-		log_err("only http:// is supported\n");
-		return -EINVAL;
+		p = strstr(url, "https://");
+		prefix_len = strlen("https://");
+		*port = HTTPS_PORT_DEFAULT;
+		*is_https = true;
 	}
 
-	p += strlen("http://");
+	p += prefix_len;
 
 	/* Parse hostname */
 	pp = strchr(p, ':');
@@ -67,9 +109,8 @@ static int parse_url(char *url, char *host, u16 *port, char **path)
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
@@ -210,12 +251,16 @@ static void httpc_result_cb(void *arg, httpc_result_t httpc_result,
 static int wget_loop(struct udevice *udev, ulong dst_addr, char *uri)
 {
 	char server_name[SERVER_NAME_SIZE];
+#if defined CONFIG_WGET_HTTPS
+	altcp_allocator_t tls_allocator;
+#endif
 	httpc_connection_t conn;
 	httpc_state_t *state;
 	struct netif *netif;
 	struct wget_ctx ctx;
 	char *path;
 	u16 port;
+	bool is_https;
 
 	ctx.daddr = dst_addr;
 	ctx.saved_daddr = dst_addr;
@@ -224,7 +269,7 @@ static int wget_loop(struct udevice *udev, ulong dst_addr, char *uri)
 	ctx.prevsize = 0;
 	ctx.start_time = 0;
 
-	if (parse_url(uri, server_name, &port, &path))
+	if (parse_url(uri, server_name, &port, &path, &is_https))
 		return CMD_RET_USAGE;
 
 	netif = net_lwip_new_netif(udev);
@@ -232,6 +277,22 @@ static int wget_loop(struct udevice *udev, ulong dst_addr, char *uri)
 		return -1;
 
 	memset(&conn, 0, sizeof(conn));
+#if defined CONFIG_WGET_HTTPS
+	if (is_https) {
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
@@ -316,6 +377,7 @@ bool wget_validate_uri(char *uri)
 	char c;
 	bool ret = true;
 	char *str_copy, *s, *authority;
+	size_t prefix_len = 0;
 
 	for (c = 0x1; c < 0x21; c++) {
 		if (strchr(uri, c)) {
@@ -323,15 +385,21 @@ bool wget_validate_uri(char *uri)
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
2.43.0

