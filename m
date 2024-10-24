Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE2CFCE8E62
	for <u-boot@archiver.kernel.org>; Thu, 24 Oct 2024 11:26:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8CFFE88F55;
	Thu, 24 Oct 2024 13:25:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="TGqh+dfz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AF1C688F47; Thu, 24 Oct 2024 13:25:43 +0200 (CEST)
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com
 [IPv6:2a00:1450:4864:20::236])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CADB688F7B
 for <u-boot@lists.denx.de>; Thu, 24 Oct 2024 13:25:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lj1-x236.google.com with SMTP id
 38308e7fff4ca-2fabb837ddbso11927611fa.1
 for <u-boot@lists.denx.de>; Thu, 24 Oct 2024 04:25:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729769139; x=1730373939; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MtlHHgZ03dQdRkQG9XQdATB0IN61C4W/Z9C+ygjSaG0=;
 b=TGqh+dfzErm1L2kDRaNVNyLBq5qajnW+dmJ071WcZbrU5X8zcCcwIXL0xfSCz3nbyA
 eiGUsNKXUjl90dUuuiKcjm4r6LigpboDGWGDA399sqe3cl1QtV9fByIqZcBlXClBNwZH
 p2Zln2lyfaAQwZqFx4iKhvrBO7/4zCwVClX3eDKVLU2uHgybdRr4Z0gsurQCdSeYgeBS
 96qLZFTNVTLRouTHHFYdOSAkDAzXGD9YF0MopoTv5WOlp7SMuxsC9WDbcC8q51B1+iwP
 Qu4a3OCmazXtcDtsUkF3s5d8f5d4mOuBjXXsCaq0YTTI4UAFJlTkar6nfyto+ki1emfc
 wIxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729769139; x=1730373939;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MtlHHgZ03dQdRkQG9XQdATB0IN61C4W/Z9C+ygjSaG0=;
 b=FBaKWnVf1QxHboasBYfhwbjduJKXPVTsYe+hTdNLKB0Qn53UdRHUh3nmsm4Xz34Hri
 6hKPs1K/wELqPwmPrKDyFud0jxJfZGnlxfrd8qoq3387YpvKpF14PaVPm2hqM/2cirF5
 YsnnNi0RGAHmOHhjcO6krsc2x9ooSsUL8m9sVYibb0bYN8Np486VM/F4r+4fpPxEG3Ao
 R4mKCxnHx3qTz+HhXefe9hwpPiUVP7PVeyVnxoeuz9YSt17vLiWhXZhprGmT1Gi3KgAz
 /lLATPdh945PqeH8+HM0HUgGO46o0gsS7SQdTflZEQ4T+qM2v+R68MJlPey9FMXGRS0j
 Hl3g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUv0LcxXH7v/ImJpZL18GAum5BEjomDsGFMp5gS2b+m2P+ejY6F25RU3xK3pBEy4rORywFOhH8=@lists.denx.de
X-Gm-Message-State: AOJu0Yw4RiTsi6CODcM93PKuPzaletmhuCn++U7eYvz8KCuDTO9YEQva
 BVJ4/Hl19WYxp8n0GizurpEeXXrjkSgek0YKNYv57zMCquar391xJMPMLK4o2IA=
X-Google-Smtp-Source: AGHT+IEAoi3m0oQ7kczoO601fTlkiDjrtnEjOX7xJuO8TPo9OTP1LCg4oTvG6Dtc9vfs+PwfH+MHWg==
X-Received: by 2002:a05:651c:1508:b0:2f0:27da:6864 with SMTP id
 38308e7fff4ca-2fc9d3252a9mr45495181fa.17.1729769139015; 
 Thu, 24 Oct 2024 04:25:39 -0700 (PDT)
Received: from localhost.localdomain (ppp176092143132.access.hol.gr.
 [176.92.143.132]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9a91572c0dsm611534466b.177.2024.10.24.04.25.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Oct 2024 04:25:37 -0700 (PDT)
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: jerome.forissier@linaro.org,
	raymond.mao@linaro.org
Cc: xypron.glpk@gmx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Simon Glass <sjg@chromium.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Peter Robinson <pbrobinson@gmail.com>,
 Wei Ming Chen <jj251510319013@gmail.com>,
 Jonathan Humphreys <j-humphreys@ti.com>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Javier Tia <javier.tia@linaro.org>, u-boot@lists.denx.de
Subject: [PATCH v2 4/6] net: lwip: Enable https:// support for wget
Date: Thu, 24 Oct 2024 14:24:11 +0300
Message-ID: <20241024112449.1362319-5-ilias.apalodimas@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241024112449.1362319-1-ilias.apalodimas@linaro.org>
References: <20241024112449.1362319-1-ilias.apalodimas@linaro.org>
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
 cmd/Kconfig      | 19 ++++++++++++
 net/lwip/Kconfig |  2 +-
 net/lwip/wget.c  | 78 +++++++++++++++++++++++++++++++++++++++++++-----
 3 files changed, 91 insertions(+), 8 deletions(-)

diff --git a/cmd/Kconfig b/cmd/Kconfig
index 3ee70f31b142..1d90a884e2c1 100644
--- a/cmd/Kconfig
+++ b/cmd/Kconfig
@@ -2126,6 +2126,25 @@ config CMD_WGET
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
index b495ebd1aa96..1a2ecdcddf34 100644
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

