Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 080E5D46C01
	for <u-boot@archiver.kernel.org>; Thu, 29 Jan 2026 00:23:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6FDF883B91;
	Thu, 29 Jan 2026 01:23:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="O6O3d5U7";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="ISflETZ6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A26C383BC7; Thu, 29 Jan 2026 01:23:57 +0100 (CET)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C12B283B30
 for <u-boot@lists.denx.de>; Thu, 29 Jan 2026 01:23:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4f1fyL3Jxrz9tVh;
 Thu, 29 Jan 2026 01:23:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1769646234;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=5Lfv5FmYZR8nAq8UbjcgqccjPx7wiTnIFKn0m6oNKAo=;
 b=O6O3d5U7BbOqnlkkKwS19v5k/jJiYna13KNy7BpH3T96mc9VbUjRnP9nV6m7QQwL5foB8p
 Z+Oz4TJe2MTNH/g0l1vA4w1nUK/F1akpLsq3RAl6/aVI5j5zrUleYGG9G/XWdrH8gw3fWC
 +oy47G+qMm2qyRcDza1K0MtpNQGJDKGplNqZm7zG+vudD0mgRWlIk++PzYZDimehq6vvir
 5+4pNNFV8BONmk15QZS71wTbFLPbPN51+gxGWBYjYn0mdJMIjBGouPLSnzLxEw00h1ORjX
 lW7YFaWSvSi1wg4OiYMc1jbEci17KB4KNDl5VbFrZ4M1E9lpqOy24cao25cHeg==
Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=ISflETZ6;
 spf=pass (outgoing_mbo_mout: domain of marek.vasut+renesas@mailbox.org
 designates 2001:67c:2050:b231:465::102 as permitted sender)
 smtp.mailfrom=marek.vasut+renesas@mailbox.org
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1769646232;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=5Lfv5FmYZR8nAq8UbjcgqccjPx7wiTnIFKn0m6oNKAo=;
 b=ISflETZ6TxVo9PzekwlWa9CxzUbizGGDj99Nv5JrkgIrNSJOwW0cUMMHDlA4hTTRayMR/D
 QZx+AVREHh4rQD38oqTpeLudmGUROiCqwqyMOqAoMroi+MVqGXnY9IiTLV8YOKqhf7mQe7
 G7Yl8W7cRg3jTzCyA91U1OaEpqC/6nlYvP7w8CM5YR3csEWZDlb9Lo5zuLrWuYidcJe5DV
 KT9I6Us0Ashb6XLuj1yZg9appQSA3yDOPhHdjHdQG6eC/AfTbjEcGCbcpcwpYihj2V8McB
 qLzffwsyGguzqefgLg75ZFDta2ebwrskK+l6SfxgZzyd9SehiWmdjlCtNomOMA==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome@forissier.org>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 Tim Harvey <tharvey@gateworks.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH] net: lwip: wget: rework the '#' printing
Date: Thu, 29 Jan 2026 01:23:29 +0100
Message-ID: <20260129002348.433050-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 68754a196ce3a504186
X-MBO-RS-META: 5k3xifwmdwscpjjqk8o14xts7zmi64ts
X-Rspamd-Queue-Id: 4f1fyL3Jxrz9tVh
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

Currently, the LWIP wget command prints excessive amount of progress
indicator '#' for very long file downloads, limit this to one line
that scales according to transfer size.

The HTTP server does report the size of the entire file in protocol
headers, which are received before the actual data transfer. Cache
this information and use it to adaptively print progress indicator
'#' until it fills one entire line worth of '#', which indicates the
transfer has completed. This way, long transfers don't print pages of
'#', but every transfer will print exactly one line worth of '#'. The
algorithm for '#' printing is the same as TFTP tsize one.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Jerome Forissier <jerome@forissier.org>
Cc: Joe Hershberger <joe.hershberger@ni.com>
Cc: Ramon Fried <rfried.dev@gmail.com>
Cc: Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: Tim Harvey <tharvey@gateworks.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
 net/lwip/wget.c | 27 +++++++++++++++++++++++----
 1 file changed, 23 insertions(+), 4 deletions(-)

diff --git a/net/lwip/wget.c b/net/lwip/wget.c
index 55bd2b72e26..008f3b395e7 100644
--- a/net/lwip/wget.c
+++ b/net/lwip/wget.c
@@ -37,6 +37,8 @@ struct wget_ctx {
 	ulong size;
 	ulong prevsize;
 	ulong start_time;
+	ulong content_len;
+	ulong hash_count;
 	enum done_state done;
 };
 
@@ -152,6 +154,7 @@ static int store_block(struct wget_ctx *ctx, void *src, u16_t len)
 {
 	ulong store_addr = ctx->daddr;
 	uchar *ptr;
+	ulong pos;
 
 	/* Avoid overflow */
 	if (wget_info->buffer_size && wget_info->buffer_size < ctx->size + len)
@@ -174,10 +177,12 @@ static int store_block(struct wget_ctx *ctx, void *src, u16_t len)
 
 	ctx->daddr += len;
 	ctx->size += len;
-	if (ctx->size - ctx->prevsize > PROGRESS_PRINT_STEP_BYTES) {
-		if (!wget_info->silent)
-			printf("#");
-		ctx->prevsize = ctx->size;
+
+	pos = clamp(ctx->size, 0UL, ctx->content_len);
+
+	while (ctx->hash_count < pos * 50 / ctx->content_len) {
+		putc('#');
+		ctx->hash_count++;
 	}
 
 	return 0;
@@ -234,6 +239,14 @@ static void httpc_result_cb(void *arg, httpc_result_t httpc_result,
 		return;
 	}
 
+	/* Print hash marks for the last packet received */
+	while (ctx->hash_count < 49) {
+		putc('#');
+		ctx->hash_count++;
+	}
+	puts("  ");
+	print_size(ctx->content_len, "");
+
 	elapsed = get_timer(ctx->start_time);
 	if (!elapsed)
 		elapsed = 1;
@@ -263,11 +276,15 @@ static void httpc_result_cb(void *arg, httpc_result_t httpc_result,
 static err_t httpc_headers_done_cb(httpc_state_t *connection, void *arg, struct pbuf *hdr,
 				   u16_t hdr_len, u32_t content_len)
 {
+	struct wget_ctx *ctx = arg;
+
 	wget_lwip_fill_info(hdr, hdr_len, content_len);
 
 	if (wget_info->check_buffer_size && (ulong)content_len > wget_info->buffer_size)
 		return ERR_BUF;
 
+	ctx->content_len = content_len;
+
 	return ERR_OK;
 }
 
@@ -294,6 +311,8 @@ int wget_do_request(ulong dst_addr, char *uri)
 	ctx.size = 0;
 	ctx.prevsize = 0;
 	ctx.start_time = 0;
+	ctx.content_len = 0;
+	ctx.hash_count = 0;
 
 	if (parse_url(uri, ctx.server_name, &ctx.port, &path, &is_https))
 		return CMD_RET_USAGE;
-- 
2.51.0

