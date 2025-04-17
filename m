Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0E04C369B2
	for <u-boot@archiver.kernel.org>; Thu, 17 Apr 2025 13:27:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B51F583061;
	Thu, 17 Apr 2025 15:27:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="dOSrk6fb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 76F6482CA8; Thu, 17 Apr 2025 15:27:34 +0200 (CEST)
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com
 [IPv6:2a00:1450:4864:20::42f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 74AB283013
 for <u-boot@lists.denx.de>; Thu, 17 Apr 2025 15:27:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-39149bccb69so781530f8f.2
 for <u-boot@lists.denx.de>; Thu, 17 Apr 2025 06:27:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744896451; x=1745501251; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eZOQjJFalRgpPeuxaB4yi+NuMS9a1y2RFiAI5YGeXrE=;
 b=dOSrk6fb2soE3N0ie1NrTFpLGhpW7RJNm5ecRF6MjwEPVOaDzlSvI1GF9BrGZ9gDPU
 iuRn3oKuL8kqJ2cKMvuWP51xdzSqYlMQE2B2r+gBM0uiVxfWiUVO/SbAm9HKVS8cSpsI
 ic7Jm1G/jo+2lfqoU3KKcZ6AZwYRKd1l6+JK2p83kN7+qYoHYGYcAQJRgVxRchTH8wMx
 KTHdkUjm8vocYh0SFt9ekCqcM0YBGjq8J6YEmeLIqFoA4/6oy1rL/Zxt2tKQ4wVh2em3
 t4hWkpoWfX4xO8EDjnGt1nwvdwF5k7yTctdAb7EZJuXxusjRbiMXvNS1ju6RI8dKcDpc
 PMNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744896451; x=1745501251;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eZOQjJFalRgpPeuxaB4yi+NuMS9a1y2RFiAI5YGeXrE=;
 b=iTUtQW7yCuvxpAmv+QOS68i+ar6LnmJLZuqT89FpWYlESt7CKip+x9Q208icI7gQ6X
 IUhh14lG1Y+NdtJe95vho5DCrP0SGCF74bcOW5KcGZFsxk2KwOFUqodHQLPFH+b6IeJI
 I82XCcGh7zNqhGld59QtVwYgQ++bYMQy/xW8tVLSbDFq94ytK8ZAiMxrT9nvBn01DfJe
 qR/u5qqWz/8GPKRaHtZ3GCSwiLBQORRPENUTvBwA674g0z1MYSEI8l3ZxF8c736M0JBj
 ESmF7wlSBSK2xoGevxVWtffAA4vdXBagErJNMucBWJnzMK+XuW3w7gOJ4Y/rloCKXy4M
 0uhQ==
X-Gm-Message-State: AOJu0Yxkb+LdXNYGd1Y8OG0gbUYLp/SRnUcaCl13PhrnChI0hczxsD7p
 /hXe0XJDOUr3rMXj3kHWPneDSUTg/2YDrvVMwb+ZhMggn9pIWhMKbxkXISe3WITDi8cungdWpnd
 JP4w=
X-Gm-Gg: ASbGncuuSEjHCzmYovdYygHqD56KCPeLK/kBluWEP7GfmI/9KL4H1rtXFj8tj28kX3l
 r/ge+q97f/fezf8ZZo7nAqLyRbQXJTGSXm1xklCxyt+ibYIEtShmKtu+esxxiBKUE8O23g6Lnaa
 r3erfp0vCgROE1oBhwfLsgaOVo2gdx61S/DyQjmRAr9e2Zm1kClM5mnzfZBwCWzzl0qDZroy28Y
 Qi05iMKBDNN+eO78RBOyQdsWizyM1UZrnyEk+4rqmfkudb4DnAh/6HCcltvhb2IHJavasf1Z51v
 zMK0yypqMB70G23Irugc34ypkwa1NMAvxAzmuNcl0yKMxhdHJA==
X-Google-Smtp-Source: AGHT+IGxv1XjDwYiZm5j6jxQ0lUPnt2Hzt/omgrtm6RzxeXJXAyT9ms4dGySzoifOT8+O2QZLNlC7w==
X-Received: by 2002:a5d:5f82:0:b0:39c:1404:3748 with SMTP id
 ffacd0b85a97d-39ee5b14a71mr5222860f8f.16.1744896450652; 
 Thu, 17 Apr 2025 06:27:30 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:a07e:3f08:7eef:b036])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39eae977513sm19951605f8f.42.2025.04.17.06.27.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Apr 2025 06:27:30 -0700 (PDT)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: U-Boot mailing list <u-boot@lists.denx.de>
Cc: Jerome Forissier <jerome.forissier@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Adriano Cordova <adrianox@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Javier Tia <javier.tia@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Ramon Fried <rfried.dev@gmail.com>, Simon Glass <sjg@chromium.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v5 2/4] net,
 net-lwip: wget: suppress console output when called by EFI
Date: Thu, 17 Apr 2025 15:26:58 +0200
Message-ID: <20250417132718.2023555-3-jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250417132718.2023555-1-jerome.forissier@linaro.org>
References: <20250417132718.2023555-1-jerome.forissier@linaro.org>
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

Functions called from EFI applications should not do console output.
Refactor the wget code to implement this requirement. The wget_http_info
struct is used to hold the boolean that signifies whether the output is
allowed or not.

Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
Reported-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
---

Changes in v5:
- Remove extra hunk in wget_do_request() already added by "net-lwip:
change static function wget_loop() to be wget_do_request():
- Do not forget to silence the printf's that were added inside lwIP
by commit 7a15ccb66217 ("lwip: tls: warn when no CA exists amd log
certificate validation errors"). The "no CA certificates" and
"verification failed" messages are moved outside of lwIP into wget.c,
with the help of errno for the certificate verification case.

Changes in v4:
- Patch renamed, deals with NET in addition to NET_LWIP

Changes in v3:
- New patch

 doc/usage/cmd/wget.rst                        |  2 +-
 include/net-common.h                          |  2 +
 lib/efi_loader/efi_net.c                      |  2 +-
 .../src/apps/altcp_tls/altcp_tls_mbedtls.c    |  8 ++--
 net/lwip/wget.c                               | 37 ++++++++++++++-----
 net/wget.c                                    | 23 +++++++++---
 6 files changed, 52 insertions(+), 22 deletions(-)

diff --git a/doc/usage/cmd/wget.rst b/doc/usage/cmd/wget.rst
index cc82e495a29..44033aaff39 100644
--- a/doc/usage/cmd/wget.rst
+++ b/doc/usage/cmd/wget.rst
@@ -141,9 +141,9 @@ https://cacerts.digicert.com/DigiCertTLSRSA4096RootG5.crt.
    Bytes transferred = 1864 (748 hex)
    # Another server not signed against Digicert will fail
    => wget https://www.google.com/
-   Certificate verification failed
 
    HTTP client error 4
+   Certificate verification failed
    # Disable authentication to allow the command to proceed anyways
    => wget cacert none
    => wget https://www.google.com/
diff --git a/include/net-common.h b/include/net-common.h
index 30860f5975a..1043b24d0b9 100644
--- a/include/net-common.h
+++ b/include/net-common.h
@@ -555,6 +555,7 @@ enum wget_http_method {
  *			Filled by client.
  * @hdr_cont_len:	content length according to headers. Filled by wget
  * @headers:		buffer for headers. Filled by wget.
+ * @silent:		do not print anything to the console. Filled by client.
  */
 struct wget_http_info {
 	enum wget_http_method method;
@@ -565,6 +566,7 @@ struct wget_http_info {
 	bool check_buffer_size;
 	u32 hdr_cont_len;
 	char *headers;
+	bool silent;
 };
 
 extern struct wget_http_info default_wget_info;
diff --git a/lib/efi_loader/efi_net.c b/lib/efi_loader/efi_net.c
index b3291b4f1d5..9ff0b691ee1 100644
--- a/lib/efi_loader/efi_net.c
+++ b/lib/efi_loader/efi_net.c
@@ -51,7 +51,7 @@ static int next_dp_entry;
 static struct wget_http_info efi_wget_info = {
 	.set_bootdev = false,
 	.check_buffer_size = true,
-
+	.silent = true,
 };
 #endif
 
diff --git a/lib/lwip/lwip/src/apps/altcp_tls/altcp_tls_mbedtls.c b/lib/lwip/lwip/src/apps/altcp_tls/altcp_tls_mbedtls.c
index ef51a5ac168..7459bfa468f 100644
--- a/lib/lwip/lwip/src/apps/altcp_tls/altcp_tls_mbedtls.c
+++ b/lib/lwip/lwip/src/apps/altcp_tls/altcp_tls_mbedtls.c
@@ -60,6 +60,8 @@
 
 #if LWIP_ALTCP_TLS && LWIP_ALTCP_TLS_MBEDTLS
 
+#include "lwip/errno.h"
+
 #include "lwip/altcp.h"
 #include "lwip/altcp_tls.h"
 #include "lwip/priv/altcp_priv.h"
@@ -299,7 +301,8 @@ altcp_mbedtls_lower_recv_process(struct altcp_pcb *conn, altcp_mbedtls_state_t *
       LWIP_DEBUGF(ALTCP_MBEDTLS_DEBUG, ("mbedtls_ssl_handshake failed: %d\n", ret));
       /* handshake failed, connection has to be closed */
       if (ret == MBEDTLS_ERR_X509_CERT_VERIFY_FAILED) {
-        printf("Certificate verification failed\n");
+	/* provide a cause for why the connection is closed to the called */
+        errno = EPERM;
       }
       if (conn->err) {
         conn->err(conn->arg, ERR_CLSD);
@@ -844,9 +847,6 @@ altcp_tls_create_config(int is_server, u8_t cert_count, u8_t pkey_count, int hav
     altcp_mbedtls_free_config(conf);
     return NULL;
   }
-  if (authmode == MBEDTLS_SSL_VERIFY_NONE) {
-     printf("WARNING: no CA certificates, HTTPS connections not authenticated\n");
-  }
   mbedtls_ssl_conf_authmode(&conf->conf, authmode);
 
   mbedtls_ssl_conf_rng(&conf->conf, mbedtls_ctr_drbg_random, &altcp_tls_entropy_rng->ctr_drbg);
diff --git a/net/lwip/wget.c b/net/lwip/wget.c
index 2b512a1bc84..63583e4c6e7 100644
--- a/net/lwip/wget.c
+++ b/net/lwip/wget.c
@@ -8,6 +8,7 @@
 #include <image.h>
 #include <lwip/apps/http_client.h>
 #include "lwip/altcp_tls.h"
+#include <lwip/errno.h>
 #include <lwip/timeouts.h>
 #include <rng.h>
 #include <mapmem.h>
@@ -217,7 +218,8 @@ static err_t httpc_recv_cb(void *arg, struct altcp_pcb *pcb, struct pbuf *pbuf,
 		memcpy((void *)ctx->daddr, buf->payload, buf->len);
 		ctx->daddr += buf->len;
 		ctx->size += buf->len;
-		if (ctx->size - ctx->prevsize > PROGRESS_PRINT_STEP_BYTES) {
+		if (!wget_info->silent &&
+		    ctx->size - ctx->prevsize > PROGRESS_PRINT_STEP_BYTES) {
 			printf("#");
 			ctx->prevsize = ctx->size;
 		}
@@ -255,11 +257,15 @@ static void httpc_result_cb(void *arg, httpc_result_t httpc_result,
 	elapsed = get_timer(ctx->start_time);
 	if (!elapsed)
 		elapsed = 1;
-	if (rx_content_len > PROGRESS_PRINT_STEP_BYTES)
-		printf("\n");
-	printf("%u bytes transferred in %lu ms (", rx_content_len, elapsed);
-	print_size(rx_content_len / elapsed * 1000, "/s)\n");
-	printf("Bytes transferred = %lu (%lx hex)\n", ctx->size, ctx->size);
+	if (!wget_info->silent) {
+		if (rx_content_len > PROGRESS_PRINT_STEP_BYTES)
+			printf("\n");
+		printf("%u bytes transferred in %lu ms (", rx_content_len,
+		       elapsed);
+		print_size(rx_content_len / elapsed * 1000, "/s)\n");
+		printf("Bytes transferred = %lu (%lx hex)\n", ctx->size,
+		       ctx->size);
+	}
 	if (wget_info->set_bootdev)
 		efi_set_bootdev("Http", ctx->server_name, ctx->path, map_sysmem(ctx->saved_daddr, 0),
 				rx_content_len);
@@ -339,7 +345,8 @@ static int _set_cacert(const void *addr, size_t sz)
 	mbedtls_x509_crt_init(&crt);
 	ret = mbedtls_x509_crt_parse(&crt, cacert, cacert_size);
 	if (ret) {
-		printf("Could not parse certificates (%d)\n", ret);
+		if (!wget_info->silent)
+			printf("Could not parse certificates (%d)\n", ret);
 		free(cacert);
 		cacert = NULL;
 		cacert_size = 0;
@@ -421,9 +428,10 @@ int wget_do_request(ulong dst_addr, char *uri)
 
 		if (cacert_auth_mode == AUTH_REQUIRED) {
 			if (!ca || !ca_sz) {
-				printf("Error: cacert authentication mode is "
-				       "'required' but no CA certificates "
-				       "given\n");
+				if (!wget_info->silent)
+					printf("Error: cacert authentication "
+					       "mode is 'required' but no CA "
+					       "certificates given\n");
 				return CMD_RET_FAILURE;
 		       }
 		} else if (cacert_auth_mode == AUTH_NONE) {
@@ -438,6 +446,10 @@ int wget_do_request(ulong dst_addr, char *uri)
 			 */
 		}
 
+		if (!ca && !wget_info->silent) {
+			printf("WARNING: no CA certificates, ");
+			printf("HTTPS connections not authenticated\n");
+		}
 		tls_allocator.alloc = &altcp_tls_alloc;
 		tls_allocator.arg =
 			altcp_tls_create_config_client(ca, ca_sz,
@@ -462,6 +474,8 @@ int wget_do_request(ulong dst_addr, char *uri)
 		return CMD_RET_FAILURE;
 	}
 
+	errno = 0;
+
 	while (!ctx.done) {
 		net_lwip_rx(udev, netif);
 		sys_check_timeouts();
@@ -474,6 +488,9 @@ int wget_do_request(ulong dst_addr, char *uri)
 	if (ctx.done == SUCCESS)
 		return 0;
 
+	if (errno == EPERM && !wget_info->silent)
+		printf("Certificate verification failed\n");
+
 	return -1;
 }
 
diff --git a/net/wget.c b/net/wget.c
index c73836cbc9d..3c0fff488eb 100644
--- a/net/wget.c
+++ b/net/wget.c
@@ -59,8 +59,10 @@ static inline int store_block(uchar *src, unsigned int offset, unsigned int len)
 	if (CONFIG_IS_ENABLED(LMB) && wget_info->set_bootdev) {
 		if (store_addr < image_load_addr ||
 		    lmb_read_check(store_addr, len)) {
-			printf("\nwget error: ");
-			printf("trying to overwrite reserved memory...\n");
+			if (!wget_info->silent) {
+				printf("\nwget error: ");
+				printf("trying to overwrite reserved memory\n");
+			}
 			return -1;
 		}
 	}
@@ -76,6 +78,9 @@ static void show_block_marker(u32 packets)
 {
 	int cnt;
 
+	if (wget_info->silent)
+		return;
+
 	if (content_length != -1) {
 		if (net_boot_file_size > content_length)
 			content_length = net_boot_file_size;
@@ -101,11 +106,15 @@ static void tcp_stream_on_closed(struct tcp_stream *tcp)
 	net_set_state(wget_loop_state);
 	if (wget_loop_state != NETLOOP_SUCCESS) {
 		net_boot_file_size = 0;
-		printf("\nwget: Transfer Fail, TCP status - %d\n", tcp->status);
+		if (!wget_info->silent)
+			printf("\nwget: Transfer Fail, TCP status - %d\n",
+			       tcp->status);
 		return;
 	}
 
-	printf("\nPackets received %d, Transfer Successful\n", tcp->rx_packets);
+	if (!wget_info->silent)
+		printf("\nPackets received %d, Transfer Successful\n",
+		       tcp->rx_packets);
 	wget_info->file_size = net_boot_file_size;
 	if (wget_info->method == WGET_HTTP_METHOD_GET && wget_info->set_bootdev) {
 		efi_set_bootdev("Http", NULL, image_url,
@@ -139,7 +148,8 @@ static void tcp_stream_on_rcv_nxt_update(struct tcp_stream *tcp, u32 rx_bytes)
 		    tcp->state == TCP_ESTABLISHED)
 			goto end;
 
-		printf("ERROR: misssed HTTP header\n");
+		if (!wget_info->silent)
+			printf("ERROR: misssed HTTP header\n");
 		tcp_stream_close(tcp);
 		goto end;
 	}
@@ -346,7 +356,8 @@ void wget_start(void)
 	tcp_stream_set_on_create_handler(tcp_stream_on_create);
 	tcp = tcp_stream_connect(web_server_ip, server_port);
 	if (!tcp) {
-		printf("No free tcp streams\n");
+		if (!wget_info->silent)
+			printf("No free tcp streams\n");
 		net_set_state(NETLOOP_FAIL);
 		return;
 	}
-- 
2.43.0

