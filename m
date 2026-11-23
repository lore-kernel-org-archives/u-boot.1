Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02C99606A31A
	for <u-boot@archiver.kernel.org>; Mon, 23 Nov 2026 04:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=diVF4w3S;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Rmbye7t3
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id D0C58606B1;
	Mon, 23 Nov 2026 04:03:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0I2x12-Ot0_r; Mon, 23 Nov 2026 04:03:49 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 70BBB606EB
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795406629;
	b=X8ZlbJYgzPNr/Ip2Ke1BigtnMXHTjzVCr6OLK2n8udruHVm2s+devlRWP/GAIAhgw9iR
	 3mvPUt9KZfZwglnqZhWM2LXKUj0H7OO2bFO2eZnnZpleCkl77pqjco7wysYCyejz09AR7
	 V+tD2Z78n1TkyxQxVrfYwhNt6+S7lSnRDhD+BRHovR7J6gCRsJF/PfcxpGbsbkj+ujyVr
	 oxWT6H7GVJHDyRGRwmGSuYJHv/3M90a+Gzmd7muYCGyJrYxSJi46xBwJCWqiTdxT8sYsR
	 3Hl16eWxiiTKlcb7jBT5Wt/GoKS4gJEjcitf81xGiWgcTubYWa9efAF7QqMTZ7SBS0Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795406629;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Content-Transfer-Encoding:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Reply-To:Errors-To;
	bh=BF5DnHZlIJCoeGcygK4XCiCdLAfZ4CJfiuwvnJR2Svo=;
	b=i69Wa2oJe9veJXJ6VKZZwZ2yvdAmbNzGcvzmhAwpNsyiYtSmiQeowpN0qY9Y05dD/tzd
	 07u5dZfrCiK01a73qLCYlf/wlBMVKB0A8qZ6pc59yBZWACJLcLcMn7nNxIY8uHXFfb3H6
	 ZUqwS2WoqnH4SANfFbhHFgo/BNbnUqkFH8643iUWmuct7B0BC/amvTk+YBkj2l4TjBLaN
	 TO7BX+A0wmkrX5Cgj2iX32PmZKegLjf15NIrSxOIZZJdcXJnurCXU4gA0ofjf6XrFr90+
	 lDFjjkQyaprzSWg3iHaZWvnI7xgY5uV7KluX54wybFzymWStS6FoD2bh5GMxW0ynuFg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795406629;
	bh=BF5DnHZlIJCoeGcygK4XCiCdLAfZ4CJfiuwvnJR2Svo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=diVF4w3SQj39TDFtF0aX1pKvpFEfqkuTZeXuNSEPgIYvSdJwzkpDgW4AGjKMaeJc4
	 X+zBggzJAhDx5d7US1nlS4KKk7C6p026tSPTVWzGOGJmlJxn+4JAFmV927KeFNRV1Y
	 dJ7yhdILGfsSqrHRxFHWuFNicqDaZvvNjD7x+rUc6BJ4YrVooHZ6+xj4pa+TsFtHLh
	 fC2hJYE7SbmN0n9auHGGChn9ttXvefcW/Eve4SkZ2giVGC/78CEUdRB949bJw4DVs5
	 e+n9cMxQpL1i5HNSlK5/Q55JijrpZjtYxQ2TYt9mmwkjNS//JjEmChIlINNMoboExi
	 GB/6fLvgDpEbw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 70BBB606EB;
	Mon, 23 Nov 2026 04:03:49 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 19F1F392
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 04:03:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 0BDA280DA1
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 04:03:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ByBZIbzmxN4D for <u-boot@lists.u-boot-project.org>;
 Mon, 23 Nov 2026 04:03:43 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org C98A880D93
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org;
 envelope-from=devnull+iav.iav.lv@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=Rmbye7t3
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 by smtp1.osuosl.org (Postfix) with ESMTPS id C98A880D93
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 04:03:42 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id DBD0060F04;
 Mon, 23 Nov 2026 04:03:41 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by smtp.kernel.org (Postfix) with ESMTPS id 836211F000D3;
 Mon, 23 Nov 2026 04:03:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795406621;
 bh=BF5DnHZlIJCoeGcygK4XCiCdLAfZ4CJfiuwvnJR2Svo=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
 b=Rmbye7t3nM6WAhMxzWdYjI8LSDrXo0XuxPm+Fw+21JJvFexXzUQ5sQglCgY/6XSfy
 5go7jGQEeldY2TlIuoVU/UabPmMnnmoi+85ZEGCmETMrRPwB9Kv8ky+wrRqUsH0wpK
 fB/T0Psxalt7MkP7qQEkUwavVJpIsxHpn2m/0kgpSYf3uNNhq6ZAlVGtfdCXyjQQHD
 xJOjmQcH7gU/pngJG2nQnl7bAaxjoT4oWDdVAxV3ph8cLI+pnprbpLvtj9FW3xG5Ls
 ujg3gK1RUN+9sR76CvzptrAGtxvpHv6P3+hjGKE2mL/j6V0JCsQMA1cdNZJYiao3oX
 uIfeY3g92PPNQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
 by lkml.kernel.org (Postfix) with ESMTP id D8C264C335;
 Mon, 23 Nov 2026 04:03:22 +0000 (UTC)
From: Igor Velkov via B4 Relay <devnull+iav.iav.lv@kernel.org>
Date: Mon, 23 Nov 2026 04:03:21 +0000
Subject: [PATCH v2 6/8] net: lwip: wget: hand the payload to an optional sink
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261123-b4-wget-blk-r4-v2-6-073d800a5aaa@iav.lv>
References: <20261123-b4-wget-blk-r4-v2-0-073d800a5aaa@iav.lv>
In-Reply-To: <20261123-b4-wget-blk-r4-v2-0-073d800a5aaa@iav.lv>
To: Jerome Forissier <jerome.forissier@arm.com>, Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Adriano Cordova <adrianox@gmail.com>, u-boot@lists.u-boot-project.org, 
 Igor Velkov <iav@iav.lv>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=9081; i=iav@iav.lv;
 h=from:subject:message-id;
 bh=iN/+r7dWA9RQhEkznfmihv2leqWlkq7f4VQonSjNE6k=;
 b=owGbwMvMwCVmNH1q96v4SmbG02pJDNnMu9m5Ts2Pm/16YleHdazU1rm274P83RObftgarhK+d
 2eZZNvxjlIWBjEuBlkxRZYJhzRuZSy5+tffw/wBzBxWJpAhDFycAjCRG6sZGc79D/X62rAuKDVJ
 8vz//v0Tf249ybuB0yrxZfVziaCEcl9GhmmF7v3nn8lLX87akib24qbTd4kKo2m6/Fca8udZGCe
 E8QAA
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

wget copies every received block to memory, so a download cannot be
larger than the free RAM. Writing a disk image to a block device while
it arrives needs the blocks one by one instead.

Add a sink callback to struct wget_http_info. When a client sets it,
store_block() passes each block to the sink and copies nothing, and
wget sets neither fileaddr, filesize nor the boot device.
altcp_recved() follows the sink, so the TCP window reopens only after
the sink has taken the data.

lwIP hands the body to the receive callback whatever the HTTP status.
With a sink, wget checks the status in the headers callback and refuses
the body of any reply other than 200, then reports the server error.

lwIP does not decode a transfer coding either, so the chunk framing
would reach the sink as data. With a sink, wget refuses a reply that
has a Transfer-Encoding header.

lwIP also passes on whatever the server sends past the Content-Length
and fails the transfer only when the connection closes. With a sink,
wget fails the transfer before such data reaches the sink.

Signed-off-by: Igor Velkov <iav@iav.lv>
---
 include/net-common.h |  12 ++++-
 net/lwip/wget.c      | 122 +++++++++++++++++++++++++++++++++++++++++++++------
 2 files changed, 120 insertions(+), 14 deletions(-)

diff --git a/include/net-common.h b/include/net-common.h
index 6d671afd4a2..d77a0b13b54 100644
--- a/include/net-common.h
+++ b/include/net-common.h
@@ -653,13 +653,21 @@ enum wget_http_method {
  * @method:		HTTP Method. Filled by client.
  * @status_code:	HTTP status code. Filled by wget.
  * @file_size:		download size. Filled by wget.
- * @buffer_size:	size of client-provided buffer. Filled by client.
+ * @buffer_size:	size of client-provided buffer, or the most that @sink
+ *			takes. Filled by client.
  * @set_bootdev:	set boot device with download. Filled by client.
  * @check_buffer_size:	check download does not exceed buffer size.
  *			Filled by client.
  * @hdr_cont_len:	content length according to headers. Filled by wget
  * @headers:		buffer for headers. Filled by wget.
  * @silent:		do not print anything to the console. Filled by client.
+ * @sink:		if set, receives the payload piece by piece, and wget
+ *			writes nothing to the destination address and sets
+ *			neither fileaddr, filesize nor the boot device; a
+ *			negative return aborts the transfer. wget then refuses
+ *			a reply with a status other than 200 or with a
+ *			Transfer-Encoding header. lwIP only. Filled by client.
+ * @sink_priv:		first argument of @sink. Filled by client.
  */
 struct wget_http_info {
 	enum wget_http_method method;
@@ -671,6 +679,8 @@ struct wget_http_info {
 	u32 hdr_cont_len;
 	char *headers;
 	bool silent;
+	int (*sink)(void *priv, const void *buf, size_t len);
+	void *sink_priv;
 };
 
 extern struct wget_http_info default_wget_info;
diff --git a/net/lwip/wget.c b/net/lwip/wget.c
index cb31dfd0190..4aeacb35ad7 100644
--- a/net/lwip/wget.c
+++ b/net/lwip/wget.c
@@ -6,6 +6,7 @@
 #include <display_options.h>
 #include <efi_loader.h>
 #include <env.h>
+#include <linux/ctype.h>
 #include <linux/kconfig.h>
 #include <linux/math64.h>
 #include <lwip/apps/http_client.h>
@@ -43,6 +44,9 @@ struct wget_ctx {
 	ulong blocks;
 	enum done_state done;
 	bool aborted;
+	/* why headers_done refused the body, for the message */
+	u32 bad_status;
+	bool coded;
 };
 
 static void wget_lwip_fill_info(struct pbuf *hdr, u16_t hdr_len, u64_t hdr_cont_len)
@@ -144,25 +148,19 @@ static int parse_url(char *url, char *host, u16 *port, char **path,
 }
 
 /**
- * store_block() - copy received data
+ * copy_block() - copy received data to memory
  *
- * This function is called by the receive callback to copy a block of data
- * into its final location (ctx->daddr). Before doing so, it checks if the copy
- * is allowed.
+ * This function copies a block of data into its final location (ctx->daddr).
+ * Before doing so, it checks if the copy is allowed.
  *
  * @ctx: the context for the current transfer
  * @src: the data received from the TCP stack
  * @len: the length of the data
  */
-static int store_block(struct wget_ctx *ctx, void *src, u16_t len)
+static int copy_block(struct wget_ctx *ctx, void *src, u16_t len)
 {
 	ulong store_addr = ctx->daddr;
 	uchar *ptr;
-	u64 pos;
-
-	/* Avoid overflow */
-	if (wget_info->buffer_size && wget_info->buffer_size < ctx->size + len)
-		return -1;
 
 	if (CONFIG_IS_ENABLED(LMB) && wget_info->set_bootdev) {
 		if (store_addr + len < store_addr ||
@@ -179,6 +177,43 @@ static int store_block(struct wget_ctx *ctx, void *src, u16_t len)
 	memcpy(ptr, src, len);
 	unmap_sysmem(ptr);
 
+	return 0;
+}
+
+/**
+ * store_block() - store received data
+ *
+ * The receive callback calls this function to pass a block of data to the
+ * client's sink or, without one, to copy it to memory.
+ *
+ * @ctx: the context for the current transfer
+ * @src: the data received from the TCP stack
+ * @len: the length of the data
+ */
+static int store_block(struct wget_ctx *ctx, void *src, u16_t len)
+{
+	u64 pos;
+	int ret;
+
+	/* Avoid overflow */
+	if (wget_info->buffer_size && wget_info->buffer_size < ctx->size + len)
+		return -1;
+
+	/* data past the Content-Length is no part of the file */
+	if (wget_info->sink && ctx->content_len != HTTPC_CONTENT_LEN_INVALID &&
+	    ctx->size + len > ctx->content_len) {
+		if (!wget_info->silent)
+			log_err("\nwget: the server sent more than its Content-Length\n");
+		return -1;
+	}
+
+	if (wget_info->sink)
+		ret = wget_info->sink(wget_info->sink_priv, src, len);
+	else
+		ret = copy_block(ctx, src, len);
+	if (ret < 0)
+		return -1;
+
 	ctx->daddr += len;
 	ctx->size += len;
 
@@ -249,6 +284,16 @@ static void httpc_result_cb(void *arg, httpc_result_t httpc_result,
 		ctx->done = FAILURE;
 		return;
 	}
+	if (ctx->bad_status) {
+		log_err("\nHTTP server error %d\n", ctx->bad_status);
+		ctx->done = FAILURE;
+		return;
+	}
+	if (ctx->coded) {
+		log_err("\nwget: the server sent a Transfer-Encoding, which wget does not decode\n");
+		ctx->done = FAILURE;
+		return;
+	}
 
 	if (httpc_result != HTTPC_RESULT_OK) {
 		log_err("\nHTTP client error %d\n", httpc_result);
@@ -280,12 +325,14 @@ static void httpc_result_cb(void *arg, httpc_result_t httpc_result,
 		printf("Bytes transferred = %llu (%llx hex)\n", ctx->size,
 		       ctx->size);
 	}
-	if (wget_info->set_bootdev)
+	if (wget_info->set_bootdev && !wget_info->sink)
 		efi_set_bootdev("Http", ctx->server_name, ctx->path, map_sysmem(ctx->saved_daddr, 0),
 				rx_content_len);
 	wget_lwip_set_file_size(rx_content_len);
-	if (env_set_hex("filesize", rx_content_len) ||
-	    env_set_hex("fileaddr", ctx->saved_daddr)) {
+	/* the client of a sink sets filesize once its output is complete */
+	if (!wget_info->sink &&
+	    (env_set_hex("filesize", rx_content_len) ||
+	     env_set_hex("fileaddr", ctx->saved_daddr))) {
 		log_err("Could not set filesize or fileaddr\n");
 		ctx->done = FAILURE;
 		return;
@@ -294,13 +341,60 @@ static void httpc_result_cb(void *arg, httpc_result_t httpc_result,
 	ctx->done = SUCCESS;
 }
 
+/* Status code from the "HTTP/1.x NNN ..." line, or 0 if there is none */
+static u32 http_status(struct pbuf *hdr)
+{
+	char line[16];
+	u16_t n;
+
+	n = pbuf_copy_partial(hdr, line, sizeof(line) - 1, 0);
+	line[n] = '\0';
+	if (n < 12 || strncmp(line, "HTTP/", 5))
+		return 0;
+
+	return simple_strtoul(line + 9, NULL, 10);
+}
+
+/* True if the reply has a Transfer-Encoding header: lwIP decodes none */
+static bool http_transfer_coded(struct pbuf *hdr, u16_t hdr_len)
+{
+	static const char name[] = "\ntransfer-encoding:";
+	u16_t i, n = 0;
+	char c;
+
+	for (i = 0; i < hdr_len; i++) {
+		c = tolower(pbuf_get_at(hdr, i));
+		if (c == name[n]) {
+			if (!name[++n])
+				return true;
+		} else {
+			n = c == name[0];
+		}
+	}
+
+	return false;
+}
+
 static err_t httpc_headers_done_cb(httpc_state_t *connection, void *arg, struct pbuf *hdr,
 				   u16_t hdr_len, u64_t content_len)
 {
 	struct wget_ctx *ctx = arg;
+	u32 status;
 
 	wget_lwip_fill_info(hdr, hdr_len, content_len);
 
+	/* the body of an error page must not reach a sink */
+	status = http_status(hdr);
+	if (wget_info->sink && status != 200) {
+		ctx->bad_status = status;
+		return ERR_VAL;
+	}
+	/* nor must the framing of a transfer coding */
+	if (wget_info->sink && http_transfer_coded(hdr, hdr_len)) {
+		ctx->coded = true;
+		return ERR_VAL;
+	}
+
 	if (wget_info->check_buffer_size &&
 	    content_len != HTTPC_CONTENT_LEN_INVALID &&
 	    content_len > wget_info->buffer_size)
@@ -439,6 +533,8 @@ int wget_do_request(ulong dst_addr, char *uri)
 	ctx.hash_count = 0;
 	ctx.blocks = 0;
 	ctx.aborted = false;
+	ctx.bad_status = 0;
+	ctx.coded = false;
 
 	ret = parse_url(uri, ctx.server_name, &ctx.port, &ctx.path, &is_https);
 	if (ret)

-- 
2.43.0


