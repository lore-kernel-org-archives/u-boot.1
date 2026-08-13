Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5F23C5CFCF
	for <u-boot@archiver.kernel.org>; Thu, 13 Aug 2026 17:59:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A77EA81335;
	Thu, 13 Aug 2026 17:59:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9aQkyr3CHYxg; Thu, 13 Aug 2026 17:59:33 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 978068132D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786643972;
	bh=grdKRrTmBaxwDXw2hzmcNanLpTfdamMKFGg6LCXIAcc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=YR9Wq4FptjHkyZfZI0n0vdQlV/864CUiEqA9gzrgYBdoT1Gs/9Tm+q+tnUadKgadk
	 cNfkUpB40VQy61PMLh31rk+vzkBxDwf2t17JNNNJNXzDCSlWfS+OdzckaHTAmDBQE6
	 Lnz7bogsfF3biFnYbNnZaSs4pEbwCAFlaM6ac7BqszYIa3T6XuUQPGVptutSFnB80B
	 RCuyBGmanIocqeHgegR2FdJ0rcn/tRyYZmyGUmPI7UAld1Q57+T3V/itKKw/C2wFCU
	 /kM/H5TLuTVY7gIfuGjHPdyEonXeymN6GP36SaD6GoTnWF3b8wR2TrNz1FOUlMocfZ
	 A6+PIh/X7o/mg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 978068132D;
	Thu, 13 Aug 2026 17:59:32 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 58134EC
 for <u-boot@lists.u-boot-project.org>; Thu, 13 Aug 2026 16:28:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 3E14F40158
 for <u-boot@lists.u-boot-project.org>; Thu, 13 Aug 2026 16:28:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5jjqgTZuJ9HZ for <u-boot@lists.u-boot-project.org>;
 Thu, 13 Aug 2026 16:28:40 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::52e; helo=mail-ed1-x52e.google.com;
 envelope-from=shahriyar@byteray.co.uk; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 3A2D64016A
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 3A2D64016A
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com
 [IPv6:2a00:1450:4864:20::52e])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 3A2D64016A
 for <u-boot@lists.u-boot-project.org>; Thu, 13 Aug 2026 16:28:40 +0000 (UTC)
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-6983d3dae7aso1874920a12.0
 for <u-boot@lists.u-boot-project.org>; Thu, 13 Aug 2026 09:28:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786638518; x=1787243318;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=grdKRrTmBaxwDXw2hzmcNanLpTfdamMKFGg6LCXIAcc=;
 b=UfQqXUfg0CJQNgARUdcs15Ms+FDMqZEgR/WAwhJJ7e/pVhxlIBR2X8hRSZM4eA9Ha9
 h4qN4LsV8FVLEudAFJeyM0AljyyLEWeySe6leXj1f7t7js5/XrYQLCJ3lO7TxvmxRZcB
 Rp/5SoItvWK3atRXRVSmeRI33992nzualo2dKadOl3birF55iSskRPJanZykbbbjO6ud
 3DjrHS68XF22R+u/ryXRUSjJF2gMnofzZIHEM0D6+wV0qkWpIQ40YohYZqsFqBkMrWGY
 uzRuQ8UqMjAsoXtLu4AonRKuyI+p9ppdP6sg0ieu+nfdwAycXUfhc7fWa24Dc9adOUrd
 CZjg==
X-Gm-Message-State: AOJu0YyTVtedHlKyh60mO0bLuh1xWY1m3uZxXU6FKW3eE6CiCxUCQo9X
 KEeQvsnsaAoVW2Qw0V+eYLjQC5gJpc25iqa0XUtx5z3CBy6540XaHBdE+/QtzKi6wEw=
X-Gm-Gg: AR+sD12uFbI8vx90ufIVSJVAwhN/ykXIrm85PCENNW77steCHQGEobjsn4HXSBG5TW8
 sTUa+9SYDoU95xvD34PGnEywZQZYpmPiErnoW1XcK+ygC42swDWaIsv7GCRl8ZUAT/PGAS3s27A
 kkkz1Olwn37TPuYgB21nduzVMXPEJDEHHn9t9X/LgF/QAqRq92lrI2qHp0k1mV4aBJPBXk0J7fm
 tosnqlpkjm7PCpY19MlYF/U+QHGQ3jBHeK8RCQ36BeqKu/Gsb5I6cOYn6j2raSGz7HM1o+e8e4P
 S7ZrV22eJqgZ3ykTNrdrcsRecvyB5mr0ySrQF1sHyONhwBfzbhKkxdWSlPsJmRL+l3i8o9jN+6n
 8MwbIMzE7VqizKJnW5LFB241UPrTS0oDTrkzc2bTdSc0UNCMC98krP/vDSsXJgisxAyDil9Z6QX
 bdqDIGN0Pj3rOaasgbfWD60ilioKD8N0oYtdJa85tCBi2Pagr0bYQk/AFBkEZGuJIZOVXJ7icSN
 gfm/s+hc6/2z8mjGLMbF31rnFzzLSK1/3oMBV/SBazWzPmzG53J
X-Received: by 2002:a17:907:97d1:b0:c1c:4c72:e6df with SMTP id
 a640c23a62f3a-c2109c5fbbamr308994666b.0.1786638518255; 
 Thu, 13 Aug 2026 09:28:38 -0700 (PDT)
Received: from [127.0.1.1]
 (p200300ff0f038f00b49b9d175e416b42.dip0.t-ipconnect.de.
 [2003:ff:f03:8f00:b49b:9d17:5e41:6b42])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6a37f7f59afsm1139188a12.11.2026.08.13.09.28.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Aug 2026 09:28:37 -0700 (PDT)
From: Shahriyar Jalayeri <shahriyar@byteray.co.uk>
Date: Thu, 13 Aug 2026 18:28:18 +0200
Subject: [PATCH v2 2/3] net: lwip: wget: free the transfer context after an
 aborted request
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260813-lwip-httpc-uaf-v2-2-1c3f0b3aa1eb@byteray.co.uk>
References: <20260813-lwip-httpc-uaf-v2-0-1c3f0b3aa1eb@byteray.co.uk>
In-Reply-To: <20260813-lwip-httpc-uaf-v2-0-1c3f0b3aa1eb@byteray.co.uk>
To: u-boot@lists.u-boot-project.org, 
 Jerome Forissier <jerome.forissier@arm.com>
Cc: Tom Rini <trini@konsulko.com>, David Lechner <dlechner@baylibre.com>, 
 Argus <argus@byteray.co.uk>, Shahriyar Jalayeri <shahriyar@byteray.co.uk>
X-Mailer: b4 0.15.2
X-Mailman-Approved-At: Thu, 13 Aug 2026 17:59:28 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=byteray-co-uk.20251104.gappssmtp.com; s=20251104; t=1786638518; x=1787243318;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=grdKRrTmBaxwDXw2hzmcNanLpTfdamMKFGg6LCXIAcc=;
 b=Osbw6oWRkPuaDbUs27zAbdDIMQ/tPW+gX//omMxjTBU4+ZfqoDTz5PJ2AYfvviXmI1
 H8KdX2WFNlKPjfXmoTU7jGSK8RGRfw7PFR/7b/HTMzo4XDUACPSTFaYzW1RVceHk16dm
 NOl5pAYECVgXLm2FHwzWhl4ePz4xE3fVWp2rS5IB3h1bQo+wvuflW5Z70gJk/ZsoWz3u
 qrDkdmcZ6QkMwq/SNKBf7CrMbVmgtulEJYlnIdTjttZ9Y+61aIstPeYVg6+jYwoQ/Y+1
 jPmCATkT6f7vO03GrtlMfNPhtenUlXcRVXTU+Gky1PSMg7zi2yhZ3SpHuviayLmfrHTm
 OcEA==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=byteray.co.uk
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=byteray-co-uk.20251104.gappssmtp.com
 header.i=@byteray-co-uk.20251104.gappssmtp.com header.a=rsa-sha256
 header.s=20251104 header.b=Osbw6oWR
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

wget_do_request() keeps the transfer context on the stack and passes its
address to the lwIP httpc callbacks. If the user interrupts the transfer
with Ctrl-C while the host name is still resolving, wget_handle_request()
leaves its receive loop without tearing the connection down. The pending
DNS lookup (which lwIP cannot cancel) later resolves, the connection is
established, and httpc_recv_cb() runs against a stack frame that no longer
exists. It writes attacker-controlled TCP data through store_block() to
map_sysmem(ctx->daddr), with ctx read from reused stack.

The httpc_connection_t passed to httpc_get_file_dns() has the same lifetime
problem. lwIP stores a pointer to it in httpc_state_t.conn_settings rather
than a copy, and dereferences that pointer later for the result and
headers-done callbacks, so an abandoned request reads its result_fn and
headers_done_fn from a stack frame that is gone.

Allocate the context on the heap, move the connection settings into it
(along with the TLS allocator the settings point at, so nothing lwIP
retains points back at the stack), and add an 'abandoned' flag. On Ctrl-C
with a request still in flight, mark it abandoned and hand ownership to the
lwIP callback, which frees the context when the connection finally tears
down; the receive, headers-done and result callbacks return early so a
stale callback neither stores data nor touches wget_info.

Fixes: 3c656c928bd7 ("net: lwip: add wget command")
Signed-off-by: Shahriyar Jalayeri <shahriyar@byteray.co.uk>
---
 net/lwip/wget.c | 95 ++++++++++++++++++++++++++++++++++++++++-----------------
 1 file changed, 67 insertions(+), 28 deletions(-)

diff --git a/net/lwip/wget.c b/net/lwip/wget.c
index 9e93765926d..7359094f6be 100644
--- a/net/lwip/wget.c
+++ b/net/lwip/wget.c
@@ -12,6 +12,7 @@
 #include <lwip/errno.h>
 #include <lwip/timeouts.h>
 #include <rng.h>
+#include <malloc.h>
 #include <mapmem.h>
 #include <net.h>
 #include <time.h>
@@ -39,6 +40,11 @@ struct wget_ctx {
 	ulong content_len;
 	ulong hash_count;
 	enum done_state done;
+	bool abandoned;
+	httpc_connection_t conn;
+#if CONFIG_IS_ENABLED(WGET_HTTPS)
+	altcp_allocator_t tls_allocator;
+#endif
 };
 
 static void wget_lwip_fill_info(struct pbuf *hdr, u16_t hdr_len, u32_t hdr_cont_len)
@@ -200,6 +206,13 @@ static err_t httpc_recv_cb(void *arg, struct altcp_pcb *pcb, struct pbuf *pbuf,
 	if (!pbuf)
 		return ERR_BUF;
 
+	/* The caller gave up on this request; drop the connection. */
+	if (ctx->abandoned) {
+		altcp_abort(pcb);
+		pbuf_free(pbuf);
+		return ERR_ABRT;
+	}
+
 	if (!ctx->start_time)
 		ctx->start_time = get_timer(0);
 
@@ -227,6 +240,12 @@ static void httpc_result_cb(void *arg, httpc_result_t httpc_result,
 	struct wget_ctx *ctx = arg;
 	ulong elapsed;
 
+	/* Last callback for an abandoned request: reclaim ctx and stop. */
+	if (ctx->abandoned) {
+		free(ctx);
+		return;
+	}
+
 	wget_info->status_code = (u32)srv_res;
 
 	if (err == ERR_BUF) {
@@ -282,6 +301,9 @@ static err_t httpc_headers_done_cb(httpc_state_t *connection, void *arg, struct
 {
 	struct wget_ctx *ctx = arg;
 
+	if (ctx->abandoned)
+		return ERR_BUF;
+
 	wget_lwip_fill_info(hdr, hdr_len, content_len);
 
 	if (wget_info->check_buffer_size && (ulong)content_len > wget_info->buffer_size)
@@ -299,10 +321,6 @@ static err_t httpc_headers_done_cb(httpc_state_t *connection, void *arg, struct
 static int wget_handle_request(struct wget_ctx *ctx, bool is_https,
 			       struct udevice *udev, struct netif *netif)
 {
-#if CONFIG_IS_ENABLED(WGET_HTTPS)
-	altcp_allocator_t tls_allocator;
-#endif
-	httpc_connection_t conn;
 	httpc_state_t *state;
 	int ret;
 
@@ -313,7 +331,7 @@ static int wget_handle_request(struct wget_ctx *ctx, bool is_https,
 			return ret;
 	}
 
-	memset(&conn, 0, sizeof(conn));
+	memset(&ctx->conn, 0, sizeof(ctx->conn));
 #if CONFIG_IS_ENABLED(WGET_HTTPS)
 	if (is_https) {
 		char *ca;
@@ -351,23 +369,23 @@ static int wget_handle_request(struct wget_ctx *ctx, bool is_https,
 			printf("WARNING: no CA certificates, ");
 			printf("HTTPS connections not authenticated\n");
 		}
-		tls_allocator.alloc = &altcp_tls_alloc;
-		tls_allocator.arg =
+		ctx->tls_allocator.alloc = &altcp_tls_alloc;
+		ctx->tls_allocator.arg =
 			altcp_tls_create_config_client(ca, ca_sz,
 						       ctx->server_name);
 
-		if (!tls_allocator.arg) {
+		if (!ctx->tls_allocator.arg) {
 			log_err("error: Cannot create a TLS connection\n");
 			return -ENODEV;
 		}
 
-		conn.altcp_allocator = &tls_allocator;
+		ctx->conn.altcp_allocator = &ctx->tls_allocator;
 	}
 #endif
 
-	conn.result_fn = httpc_result_cb;
-	conn.headers_done_fn = httpc_headers_done_cb;
-	if (httpc_get_file_dns(ctx->server_name, ctx->port, ctx->path, &conn,
+	ctx->conn.result_fn = httpc_result_cb;
+	ctx->conn.headers_done_fn = httpc_headers_done_cb;
+	if (httpc_get_file_dns(ctx->server_name, ctx->port, ctx->path, &ctx->conn,
 			       httpc_recv_cb, ctx, &state)) {
 		return -ENODEV;
 	}
@@ -376,8 +394,17 @@ static int wget_handle_request(struct wget_ctx *ctx, bool is_https,
 
 	while (!ctx->done) {
 		net_lwip_rx(udev, netif);
-		if (ctrlc())
+		if (ctrlc()) {
+			/*
+			 * A request may still be in flight (e.g. the name is
+			 * still resolving). Hand ctx to the lwIP callback, which
+			 * frees it once the connection tears down, instead of
+			 * freeing it here under a live callback.
+			 */
+			if (!ctx->done)
+				ctx->abandoned = true;
 			break;
+		}
 	}
 
 	if (ctx->done == SUCCESS)
@@ -392,27 +419,26 @@ static int wget_handle_request(struct wget_ctx *ctx, bool is_https,
 int wget_do_request(ulong dst_addr, char *uri)
 {
 	struct udevice *udev;
-	struct wget_ctx ctx;
+	struct wget_ctx *ctx;
 	struct netif *netif;
-	bool is_https;
+	bool is_https, abandoned;
 	int ret;
 
-	ctx.daddr = dst_addr;
-	ctx.saved_daddr = dst_addr;
-	ctx.done = NOT_DONE;
-	ctx.size = 0;
-	ctx.prevsize = 0;
-	ctx.start_time = 0;
-	ctx.content_len = 0;
-	ctx.hash_count = 0;
+	ctx = calloc(1, sizeof(*ctx));
+	if (!ctx)
+		return -ENOMEM;
+
+	ctx->daddr = dst_addr;
+	ctx->saved_daddr = dst_addr;
+	ctx->done = NOT_DONE;
 
-	ret = parse_url(uri, ctx.server_name, &ctx.port, &ctx.path, &is_https);
+	ret = parse_url(uri, ctx->server_name, &ctx->port, &ctx->path, &is_https);
 	if (ret)
-		return ret;
+		goto out;
 
 	ret = net_lwip_eth_start();
 	if (ret)
-		return ret;
+		goto out;
 
 	if (!wget_info)
 		wget_info = &default_wget_info;
@@ -422,14 +448,27 @@ int wget_do_request(ulong dst_addr, char *uri)
 	netif = net_lwip_new_netif(udev);
 	if (!netif) {
 		net_lwip_eth_stop();
-		return -ENODEV;
+		ret = -ENODEV;
+		goto out;
 	}
 
-	ret = wget_handle_request(&ctx, is_https, udev, netif);
+	ret = wget_handle_request(ctx, is_https, udev, netif);
+
+	/*
+	 * If the request was abandoned the lwIP callback still owns ctx and
+	 * frees it when the connection tears down; do not free it here.
+	 */
+	abandoned = ctx->abandoned;
 
 	net_lwip_remove_netif(netif);
 	net_lwip_eth_stop();
 
+	if (!abandoned)
+		free(ctx);
+
+	return ret;
+out:
+	free(ctx);
 	return ret;
 }
 

-- 
2.43.0

