Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A485BC369AB
	for <u-boot@archiver.kernel.org>; Tue, 15 Apr 2025 19:35:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 29DE282B45;
	Tue, 15 Apr 2025 21:34:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="sHsAxVlf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AFCA782B54; Tue, 15 Apr 2025 21:34:54 +0200 (CEST)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8512482A27
 for <u-boot@lists.denx.de>; Tue, 15 Apr 2025 21:34:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-43cf680d351so69065e9.0
 for <u-boot@lists.denx.de>; Tue, 15 Apr 2025 12:34:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744745692; x=1745350492; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1olj/4/0QjVfT/SCqMEBitoG5ohCI4M4SdcbZFvqcio=;
 b=sHsAxVlfqsHhyK+5Rl1jMYHNgbQIXICujUE3FRm9x+Ht+mr4IpxSUrbhSWeQZ1Q6K+
 1fWjQB3w7u960OACPkndFXZy5OyW+Yf2/UKPBlvG9uHFFboCFFv0fTCKq3kVku6LRMcG
 XiovlAJb5gzIpq4Sojz4K+1uBF5a25nWfcynGwHb1Q5VpXYxvzvaofsnhEAXDSkWLyq6
 F/qqmgk/hWCgqdUT6pYKxnkQxGK20KD53uPUBNlMWnYQcXnJkeFzHrmOgcaViNXvYMNw
 jr8VyAG2RB9LMMso+jFF+451Z/8p5ZEY4tMnE/jAzAJLZYdUkNvTVAsNilVlK10HN3SH
 fwAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744745692; x=1745350492;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1olj/4/0QjVfT/SCqMEBitoG5ohCI4M4SdcbZFvqcio=;
 b=iAJ2OBTDfFagbtOI3PTT9X7Oq6yAj4pB0grmVXIGWVxN8CIcunIe69TWccPhGX4sSq
 FVXyeJl6V8hLIKyX/sckdjWaOiscvPdlSaM4AAdmmu2+5qT7dTXrFPwiZa1jSkZUK3X3
 o5MC5p9TeWiMsHZCozgMqy9YwlQj5vbfglTnpcfUTJoAUnaQ6IrdpX71oHQwzU68J+WA
 rtjJ8wsaihxk3jyvs/OsoLaDwbw9bAFLkPDZCTqav3LXDMTAiT6cvSH7QZR+brQeoFA8
 6nJ+R64Re/i4jCcO1I54/ATpbaWxzx/41UOAnTgkuN9n/1wqErlNw2VDjj3KNHUBr6xZ
 T7Jg==
X-Gm-Message-State: AOJu0Ywl52oUF1BOm9kiWJu6/18NjJZPz7+weD7U0obb3fsQt73SaoPR
 bXYK/ZIXI8D3m6XiP44DGfcddt1B6BpPpK63/e0i/Ak8Q3GIbrwG3Ic70XBcRxaxd+nFfBvPDBI
 AsXA=
X-Gm-Gg: ASbGncsm1RurrTCNM6yDiq3EJ0OMg5SQZNeJkeQvn3eFwe1UJ/B1o47UXaVcOeeYYSA
 HkKyYQyYZXb8nA2n0xndXHQa6Bg3/hqIel6ppm+Yjkmlo60DVzSERRZ4kPDnIqiaye5bKwlyoI6
 c+wabHd52jTe6cW24jVFit7DitQfPU1QkLAEpW7ZYtlCux58jim6GC1ERvf4cxKCOzomnRObBrj
 MrewWSfUOGOwOkQIL2vWulOtj2Po4eGbRvViPel0c550B6dSnoF402S6IamDQV1r+9Pvh03Lka9
 ShMV2rUvZwLt7fub48gx6vEIImWN5SFhr08WBQ7HvrI5yLn9zhk6mrCx3qw=
X-Google-Smtp-Source: AGHT+IHZ55tpbtzFbF6WYP4xoHNLEtSX1U6EDPlhs7Nt4RdqrgiFo5pEwykMG8Hvv10zUvg0dM+QgQ==
X-Received: by 2002:a5d:6d88:0:b0:390:e9ee:f27a with SMTP id
 ffacd0b85a97d-39ee27738f9mr662809f8f.28.1744745691703; 
 Tue, 15 Apr 2025 12:34:51 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:6ebc:6ce:770e:95f9])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39eaf43d046sm15520484f8f.63.2025.04.15.12.34.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Apr 2025 12:34:51 -0700 (PDT)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: U-Boot mailing list <u-boot@lists.denx.de>
Cc: Jerome Forissier <jerome.forissier@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Adriano Cordova <adrianox@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Ramon Fried <rfried.dev@gmail.com>, Simon Glass <sjg@chromium.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v4 2/4] net,
 net-lwip: wget: suppress console output when called by EFI
Date: Tue, 15 Apr 2025 21:34:27 +0200
Message-ID: <20250415193436.1240804-3-jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250415193436.1240804-1-jerome.forissier@linaro.org>
References: <20250415193436.1240804-1-jerome.forissier@linaro.org>
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

Changes in v4:
- Patch renamed, deals with NET in addition to NET_LWIP

Changes in v3:
- New patch

 include/net-common.h     |  2 ++
 lib/efi_loader/efi_net.c |  2 +-
 net/lwip/wget.c          | 33 +++++++++++++++++++++++----------
 net/wget.c               | 23 +++++++++++++++++------
 4 files changed, 43 insertions(+), 17 deletions(-)

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
 
diff --git a/net/lwip/wget.c b/net/lwip/wget.c
index 2b512a1bc84..3529768eb06 100644
--- a/net/lwip/wget.c
+++ b/net/lwip/wget.c
@@ -217,7 +217,8 @@ static err_t httpc_recv_cb(void *arg, struct altcp_pcb *pcb, struct pbuf *pbuf,
 		memcpy((void *)ctx->daddr, buf->payload, buf->len);
 		ctx->daddr += buf->len;
 		ctx->size += buf->len;
-		if (ctx->size - ctx->prevsize > PROGRESS_PRINT_STEP_BYTES) {
+		if (!wget_info->silent &&
+		    ctx->size - ctx->prevsize > PROGRESS_PRINT_STEP_BYTES) {
 			printf("#");
 			ctx->prevsize = ctx->size;
 		}
@@ -255,11 +256,15 @@ static void httpc_result_cb(void *arg, httpc_result_t httpc_result,
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
@@ -339,7 +344,8 @@ static int _set_cacert(const void *addr, size_t sz)
 	mbedtls_x509_crt_init(&crt);
 	ret = mbedtls_x509_crt_parse(&crt, cacert, cacert_size);
 	if (ret) {
-		printf("Could not parse certificates (%d)\n", ret);
+		if (!wget_info->silent)
+			printf("Could not parse certificates (%d)\n", ret);
 		free(cacert);
 		cacert = NULL;
 		cacert_size = 0;
@@ -392,6 +398,12 @@ int wget_do_request(ulong dst_addr, char *uri)
 	ctx.prevsize = 0;
 	ctx.start_time = 0;
 
+	if (!wget_info)
+		wget_info = &default_wget_info;
+
+	net_lwip_set_current();
+	udev = eth_get_dev();
+
 	if (parse_url(uri, ctx.server_name, &ctx.port, &path, &is_https))
 		return CMD_RET_USAGE;
 
@@ -421,9 +433,10 @@ int wget_do_request(ulong dst_addr, char *uri)
 
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

