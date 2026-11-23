Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB0A8606A31A
	for <u-boot@archiver.kernel.org>; Mon, 23 Nov 2026 04:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=E5POsCXs;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=G5gNmCGY
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 829A74065C;
	Mon, 23 Nov 2026 04:03:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id cIjg4r7sgMJ1; Mon, 23 Nov 2026 04:03:43 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 1B86A40650
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795406623;
	b=Dyu8xVLuqoWaZy346HUqbvd9uDudYbkAYLR6il6iuqBDYiNguoEwwmJDquHxX6uvVm7p
	 wFye8EmtqFAXXCjvwenVZWJw8iBuZK6SWTn/GSh9CtQ/zt6mu2O1rM7KNnBw8uQUKrn1J
	 KI9iwPomzjuyfgbslN1XIg4La1+2Sg7jCoWMrhNSmKmVn/1aWCQFR+g07kaWg3Ex6UcM+
	 R47zHD/c7t/au5cAQ5DrEGbRSH1Y0AIh0/ghPcmynu0qLfSLEs4/9uusN5yhkt3JYHTcC
	 9Fcjw9LK5vhz9ie4cfTIjPwjCbEndD2XrpDXB/W+Hzm/e+q5GfrjOizy59rrx8cd1nA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795406623;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Content-Transfer-Encoding:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Reply-To:Errors-To;
	bh=+0NmZVtrPprMz8To8hY3apum/cyYHW4BP9y0WfN7i/k=;
	b=ZAMtDS7aNJHCMutxEON0qKm1mrGTpfZYsMX9mbajvZcRAMAEltoNn9/9jX33HnduTNU3
	 2JXw2LmkNASHzfRDlPrFbeiKyXhftVPNE4CWUJLNF8gmHKyyUeCiwkGoejhO6Rmmpv4F6
	 wKouzh7GVW/K8jZPIvK2gpq3YIdA2U3uih9sIklbkaygV75Ch8TxiKvj9eHy9YSUBIOI6
	 +t5OIt7sp5ZVC+BpyzysH6HbyVAhBdLeNPyKEQKMkUIbqjZkHuZwrYiydgQgFC6sklnux
	 HSUv6/smKJ49dGkNmyXd8u8tZ4kzCJHuFCykSajGbHUAU8HVKOgaQSoaZObLUTXVCrw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795406623;
	bh=+0NmZVtrPprMz8To8hY3apum/cyYHW4BP9y0WfN7i/k=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=E5POsCXsFLbUHnCTGkrWPidyLJksumLMBZ88QUyNGRmuTQjSOJ0PVYaiDr/x6YQOo
	 8n/BwBRyg+WVYyGuVt2350NbtYh2dxMPrFr3F0AeQ2KCfyQLag9/O8MWpqRBtAMOav
	 CE/RYFJUeZMlh73n66EafJdjfQaIWS8HlmgqHYlByKfJ5T5EnYY64Qy2ksuOryZl6o
	 KuC1URh7sFCLzY6N1ZiVA65qjenDdr23Fokc4Se43wb0Yxiimd7ZTHvNJMCZXUvPid
	 uGwX1rTfJg+sFrO3aZBfUFga5SPgDrRvu1eDET2zG+0vlCcL4p4a0mrpo/xQdd0Z90
	 /wwRRsFAhXZPQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1B86A40650;
	Mon, 23 Nov 2026 04:03:43 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 5759C392
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 04:03:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 35EAD606AE
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 04:03:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4m9lfciYxFeQ for <u-boot@lists.u-boot-project.org>;
 Mon, 23 Nov 2026 04:03:39 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org C12B76068D
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org;
 envelope-from=devnull+iav.iav.lv@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=G5gNmCGY
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 by smtp3.osuosl.org (Postfix) with ESMTPS id C12B76068D
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 04:03:38 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id F1D3644462;
 Mon, 23 Nov 2026 04:03:37 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by smtp.kernel.org (Postfix) with ESMTPS id 183571F000D1;
 Mon, 23 Nov 2026 04:03:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795406617;
 bh=+0NmZVtrPprMz8To8hY3apum/cyYHW4BP9y0WfN7i/k=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
 b=G5gNmCGYxmnPsVzH5Omi7TjdUaENe+NS8KkVPqjoEt/uOosGM8i0vMmf7K+MZculr
 lM+aEV76TAx3C2ExK4iijplqE0/LdO97HN+pozAyrq+vuf/FOke0oAkAnJsRMmjlR8
 gour5d5W3vFD1zicastps8COZTZ+H5P0PO5DO3c0Ts2IAtMRqCbBlF14US2Mo2SMt/
 o/tOzKXaFW6uUhuP6TLhXu3idfmnCr/pn5dBW/3wz+jgN1Opl1UkljZoSocBT6i3OA
 OYB9VMAlqmZbERDdkRKHF9/d1jyXdM7v+9ta4EQ6nNSjQg9PzXgPvaoaOx5oOPkbYq
 0p1nUXKZyeheQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
 by lkml.kernel.org (Postfix) with ESMTP id 9E7DD4C32D;
 Mon, 23 Nov 2026 04:03:22 +0000 (UTC)
From: Igor Velkov via B4 Relay <devnull+iav.iav.lv@kernel.org>
Date: Mon, 23 Nov 2026 04:03:19 +0000
Subject: [PATCH v2 4/8] net: lwip: count the HTTP content length in 64 bits
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261123-b4-wget-blk-r4-v2-4-073d800a5aaa@iav.lv>
References: <20261123-b4-wget-blk-r4-v2-0-073d800a5aaa@iav.lv>
In-Reply-To: <20261123-b4-wget-blk-r4-v2-0-073d800a5aaa@iav.lv>
To: Jerome Forissier <jerome.forissier@arm.com>, Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Adriano Cordova <adrianox@gmail.com>, u-boot@lists.u-boot-project.org, 
 Igor Velkov <iav@iav.lv>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=8918; i=iav@iav.lv;
 h=from:subject:message-id;
 bh=5CTUJBOcYauqHQ1uWGo/mVkfDBDMCrBXuZBD782x8tQ=;
 b=owGbwMvMwCVmNH1q96v4SmbG02pJDNnMu9lqNwS8Oj6zctHiJVq5Kjk5Rx347mS+LnlY4sq4c
 P7GW2k7O0pZGMS4GGTFFFkmHNK4lbHk6l9/D/MHMHNYmUCGMHBxCsBE7jxm+MXkevpxvJHspev2
 uy//mLlht5aYqM7aS7N+NC+QruHjWM7CyHDqaP2jS+2H/gW67hOQ3FEfJ7PL6d2/O7FLI9cV7Jh
 wdT8fAA==
X-Developer-Key: i=iav@iav.lv; a=openpgp;
 fpr=90C228DA68A4D5FD4F4837E03297958BEA5F7903
X-Endpoint-Received: by B4 Relay for iav@iav.lv/default with auth_id=1060
X-Original-From: Igor Velkov <iav@iav.lv>
Content-Transfer-Encoding: 7bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Reply-To: iav@iav.lv
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Igor Velkov <iav@iav.lv>

The HTTP client reads Content-Length with atoi(), here (int)dectoul(),
and keeps the length and the count of received bytes in u32_t. A length
of 2 GiB or more reads as unknown, or, from 4 GiB on, as its low 32
bits when those are below 2 GiB. With an unknown length a download that
the server cuts short ends with HTTPC_RESULT_OK instead of
HTTPC_RESULT_ERR_CONTENT_LEN, and from 4 GiB on the count of received
bytes wraps. Disk images for boards easily exceed 2 GiB now.

Parse the length, of up to 15 digits, into a 64-bit number, keep both
values in u64_t and pass them to the callbacks as u64_t;
HTTPC_CONTENT_LEN_INVALID becomes the largest u64_t. The callbacks of
wget and of the lwIP test change with the callback types.

wget scales its hash marks to the length, so an unknown length, now
the largest u64_t, would leave the bar empty until the end. With the
length unknown, wget prints a mark every 10 received blocks and a new
line every 65 marks, as the legacy wget does per packet.

Signed-off-by: Igor Velkov <iav@iav.lv>
---
 lib/lwip/lwip/src/apps/http/http_client.c         | 24 +++++++++++++----------
 lib/lwip/lwip/src/include/lwip/apps/http_client.h |  6 +++---
 net/lwip/wget.c                                   | 22 +++++++++++++++++----
 test/dm/lwip.c                                    |  2 +-
 4 files changed, 36 insertions(+), 18 deletions(-)

diff --git a/lib/lwip/lwip/src/apps/http/http_client.c b/lib/lwip/lwip/src/apps/http/http_client.c
index 06533c55c22..29afa8bf655 100644
--- a/lib/lwip/lwip/src/apps/http/http_client.c
+++ b/lib/lwip/lwip/src/apps/http/http_client.c
@@ -141,8 +141,8 @@ typedef struct _httpc_state
   altcp_recv_fn recv_fn;
   const httpc_connection_t *conn_settings;
   void* callback_arg;
-  u32_t rx_content_len;
-  u32_t hdr_content_len;
+  u64_t rx_content_len;
+  u64_t hdr_content_len;
   httpc_parse_state_t parse_state;
 #if LWIP_DNS
   u8_t dns_pending;
@@ -296,7 +296,7 @@ http_parse_response_status(struct pbuf *p, u16_t *http_version, u16_t *http_stat
 
 /** Wait for all headers to be received, return its length and content-length (if available) */
 static err_t
-http_wait_headers(struct pbuf *p, u32_t *content_length, u16_t *total_header_len)
+http_wait_headers(struct pbuf *p, u64_t *content_length, u16_t *total_header_len)
 {
   u16_t end1 = pbuf_memfind(p, "\r\n\r\n", 4, 0);
   if (end1 < (0xFFFF - 2)) {
@@ -314,11 +314,15 @@ http_wait_headers(struct pbuf *p, u32_t *content_length, u16_t *total_header_len
         u16_t content_len_num_len = (u16_t)(content_len_line_end - content_len_hdr - 16);
         if (content_len_num_len < sizeof(content_len_num)) {
           if (pbuf_copy_partial(p, content_len_num, content_len_num_len, content_len_hdr + 16) == content_len_num_len) {
-            int len;
-            content_len_num[content_len_num_len] = 0;
-            len = atoi(content_len_num);
-            if ((len >= 0) && ((u32_t)len < HTTPC_CONTENT_LEN_INVALID)) {
-              *content_length = (u32_t)len;
+            u64_t len = 0;
+            u16_t i;
+            /* at most 15 digits fit in content_len_num: no overflow */
+            for (i = 0; (i < content_len_num_len) &&
+                 (content_len_num[i] >= '0') && (content_len_num[i] <= '9'); i++) {
+              len = len * 10 + (u64_t)(content_len_num[i] - '0');
+            }
+            if (i > 0) {
+              *content_length = len;
             }
           }
         }
@@ -777,7 +781,7 @@ typedef struct _httpc_filestate
   void *callback_arg;
 } httpc_filestate_t;
 
-static void httpc_fs_result(void *arg, httpc_result_t httpc_result, u32_t rx_content_len,
+static void httpc_fs_result(void *arg, httpc_result_t httpc_result, u64_t rx_content_len,
   u32_t srv_res, err_t err);
 
 /** Initialize http client state for download to file system */
@@ -837,7 +841,7 @@ httpc_fs_free(httpc_filestate_t *filestate)
 
 /** Connection closed (success or error) */
 static void
-httpc_fs_result(void *arg, httpc_result_t httpc_result, u32_t rx_content_len,
+httpc_fs_result(void *arg, httpc_result_t httpc_result, u64_t rx_content_len,
                 u32_t srv_res, err_t err)
 {
   httpc_filestate_t *filestate = (httpc_filestate_t *)arg;
diff --git a/lib/lwip/lwip/src/include/lwip/apps/http_client.h b/lib/lwip/lwip/src/include/lwip/apps/http_client.h
index 322e51cc852..79bb090d9d3 100644
--- a/lib/lwip/lwip/src/include/lwip/apps/http_client.h
+++ b/lib/lwip/lwip/src/include/lwip/apps/http_client.h
@@ -72,7 +72,7 @@ extern "C" {
  * Content length that the headers callback gets when the client read none
  * from the reply
  */
-#define HTTPC_CONTENT_LEN_INVALID 0xFFFFFFFF
+#define HTTPC_CONTENT_LEN_INVALID 0xFFFFFFFFFFFFFFFFULL
 
 /**
  * @ingroup httpc
@@ -114,7 +114,7 @@ typedef struct _httpc_state httpc_state_t;
  * @param err an error returned by internal lwip functions, can help to specify
  *            the source of the error but must not necessarily be != ERR_OK
  */
-typedef void (*httpc_result_fn)(void *arg, httpc_result_t httpc_result, u32_t rx_content_len, u32_t srv_res, err_t err);
+typedef void (*httpc_result_fn)(void *arg, httpc_result_t httpc_result, u64_t rx_content_len, u32_t srv_res, err_t err);
 
 /**
  * @ingroup httpc
@@ -128,7 +128,7 @@ typedef void (*httpc_result_fn)(void *arg, httpc_result_t httpc_result, u32_t rx
  *                    (HTTPC_CONTENT_LEN_INVALID if not received)
  * @return if != ERR_OK is returned, the connection is aborted
  */
-typedef err_t (*httpc_headers_done_fn)(httpc_state_t *connection, void *arg, struct pbuf *hdr, u16_t hdr_len, u32_t content_len);
+typedef err_t (*httpc_headers_done_fn)(httpc_state_t *connection, void *arg, struct pbuf *hdr, u16_t hdr_len, u64_t content_len);
 
 typedef struct _httpc_connection {
   ip_addr_t proxy_addr;
diff --git a/net/lwip/wget.c b/net/lwip/wget.c
index 54c8bc612fd..cb31dfd0190 100644
--- a/net/lwip/wget.c
+++ b/net/lwip/wget.c
@@ -21,6 +21,7 @@
 #define SERVER_NAME_SIZE 254
 #define HTTP_PORT_DEFAULT 80
 #define HTTPS_PORT_DEFAULT 443
+#define HASHES_PER_LINE 65
 
 enum done_state {
 	NOT_DONE = 0,
@@ -39,6 +40,7 @@ struct wget_ctx {
 	ulong start_time;
 	u64 content_len;
 	ulong hash_count;
+	ulong blocks;
 	enum done_state done;
 	bool aborted;
 };
@@ -183,6 +185,16 @@ static int store_block(struct wget_ctx *ctx, void *src, u16_t len)
 	if (wget_info->silent)
 		return 0;
 
+	if (ctx->content_len == HTTPC_CONTENT_LEN_INVALID) {
+		/* no length to scale to: a mark every 10 blocks */
+		if (++ctx->blocks % 10)
+			return 0;
+		putc('#');
+		if (++ctx->hash_count % HASHES_PER_LINE == 0)
+			putc('\n');
+		return 0;
+	}
+
 	pos = min(ctx->size, ctx->content_len);
 
 	while (ctx->content_len &&
@@ -222,7 +234,7 @@ out:
 }
 
 static void httpc_result_cb(void *arg, httpc_result_t httpc_result,
-			    u32_t rx_content_len, u32_t srv_res, err_t err)
+			    u64_t rx_content_len, u32_t srv_res, err_t err)
 {
 	struct wget_ctx *ctx = arg;
 	ulong elapsed;
@@ -250,7 +262,8 @@ static void httpc_result_cb(void *arg, httpc_result_t httpc_result,
 	}
 
 	/* Print hash marks for the last packet received */
-	if (!wget_info->silent) {
+	if (!wget_info->silent &&
+	    ctx->content_len != HTTPC_CONTENT_LEN_INVALID) {
 		while (ctx->hash_count < 49) {
 			putc('#');
 			ctx->hash_count++;
@@ -261,7 +274,7 @@ static void httpc_result_cb(void *arg, httpc_result_t httpc_result,
 	if (!elapsed)
 		elapsed = 1;
 	if (!wget_info->silent) {
-		printf("\n%u bytes transferred in %lu ms (", rx_content_len,
+		printf("\n%llu bytes transferred in %lu ms (", rx_content_len,
 		       elapsed);
 		print_size(div_u64(rx_content_len, elapsed) * 1000, "/s)\n");
 		printf("Bytes transferred = %llu (%llx hex)\n", ctx->size,
@@ -282,7 +295,7 @@ static void httpc_result_cb(void *arg, httpc_result_t httpc_result,
 }
 
 static err_t httpc_headers_done_cb(httpc_state_t *connection, void *arg, struct pbuf *hdr,
-				   u16_t hdr_len, u32_t content_len)
+				   u16_t hdr_len, u64_t content_len)
 {
 	struct wget_ctx *ctx = arg;
 
@@ -424,6 +437,7 @@ int wget_do_request(ulong dst_addr, char *uri)
 	ctx.start_time = 0;
 	ctx.content_len = 0;
 	ctx.hash_count = 0;
+	ctx.blocks = 0;
 	ctx.aborted = false;
 
 	ret = parse_url(uri, ctx.server_name, &ctx.port, &ctx.path, &is_https);
diff --git a/test/dm/lwip.c b/test/dm/lwip.c
index 4dd4a562434..acece5a65af 100644
--- a/test/dm/lwip.c
+++ b/test/dm/lwip.c
@@ -60,7 +60,7 @@ struct lwip_test_http_ctx {
 };
 
 static void lwip_test_http_result(void *arg, httpc_result_t result,
-				  u32_t rx_content_len, u32_t server_response,
+				  u64_t rx_content_len, u32_t server_response,
 				  err_t err)
 {
 	struct lwip_test_http_ctx *ctx = arg;

-- 
2.43.0


