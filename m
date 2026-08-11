Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A73CBC5CFC1
	for <u-boot@archiver.kernel.org>; Tue, 11 Aug 2026 23:05:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2805F40799;
	Tue, 11 Aug 2026 23:05:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HgBamzp3ojVl; Tue, 11 Aug 2026 23:05:05 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 4C2204078E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786489505;
	bh=OAXQ1NALlOaYjY26BPptNiiUW+lSLwsngOtulfqFl88=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=kz1RhcY804xqVRHREqlrFBww1cenpPn/Bb7QOFbnAJuLkNfSxI5D/Q3621DkhkpX6
	 rLwfxXtZepOcuPBwtrPeh/fCE+nRP9v1FXrmrqlVA2FDCENxf2NW6S6eRd6/pB64Ef
	 SlcP0Bl/ExyxJ6FQslFNMId2lSWOV/BZKYqxrR2KE/kElyF3qyNKZPQ9s43xvP+TBK
	 p0SB7/HoSwuvYMCjJwR4kHcJFPi7RTJPrcYIyHgybGSLsGL/cmig4On6fHvy3SZzLa
	 DFCpLvwpQJPcjsgMFBmE4joloHAtin+R3nHrA4VrzKOUUTZs8sog9+vtOkUgwzDjHF
	 qsbyoKQXmYHKQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4C2204078E;
	Tue, 11 Aug 2026 23:05:05 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 132F0138E
 for <u-boot@lists.u-boot-project.org>; Tue, 11 Aug 2026 19:04:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 30E08810CA
 for <u-boot@lists.u-boot-project.org>; Tue, 11 Aug 2026 18:54:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id byGlBD02cIch for <u-boot@lists.u-boot-project.org>;
 Tue, 11 Aug 2026 18:54:52 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::334; helo=mail-wm1-x334.google.com;
 envelope-from=shahriyar@byteray.co.uk; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 34706810BD
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 34706810BD
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 34706810BD
 for <u-boot@lists.u-boot-project.org>; Tue, 11 Aug 2026 18:54:52 +0000 (UTC)
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4954a2e73a9so157445e9.3
 for <u-boot@lists.u-boot-project.org>; Tue, 11 Aug 2026 11:54:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786474489; x=1787079289;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=OAXQ1NALlOaYjY26BPptNiiUW+lSLwsngOtulfqFl88=;
 b=ClRhBVvsEUN5v+flrrNEpMW1SQOJumwWxJV7zxETYVSdNKTcj/8WtJJDScWspFdl2O
 0d0xKh1VIyPQHo9EjfYNDmcvMa5UMy6R6wkOsAHE2Yfad3PJMhurPEyQLE2yivIxPEgk
 3SSvht+2cs/fKe2qqqfq57uQYObpaalc8bg7GAjs+A4M90AhqGqC9+Hj+khFZ3SppQKa
 K3QR+VwBxAS1GuWsVjdcooZ5uJZtipbZyd1AtFMB3S16LbzblE5mMXRgtEcOnaUPtHnm
 TRRFoJCZLQt7T85m3o9NAUJanK3URB9rgtzCXYDvVJnqyXFdTtwv57ujinir4OsqcWTz
 YsmQ==
X-Gm-Message-State: AOJu0YxTuQFhquqdBtRgzwB8o0SrIfiUaNGNaCie1ayNwJbr8x4yyp3C
 AtsH41lDv2DSSEaLYCnvUDGgZSepQxKC6S8YG4iEHBs4ZthJyvcXspv+uRv0NQxcCfgayF2QHyf
 qum3yQ2o=
X-Gm-Gg: AR+sD12isqmBibdefgC6PSmWfYUHSvtH3U4/oCRMRHfQ+Xaodff7P2tV5uLGsKWp0sK
 g4mmHK5NcYJBv3Goma2caAeTy+sTufKISuL5+7y33EJeQhQkZDzGLPBrYo7sarKhb3AmCWZnsGo
 wOdMtUNjfO4DxqoP6RNffVROWOMxAS3Nahytjt5mXKuyIaGHntcWcp9/6m85fO2q+mlWnlDVArb
 HbRhr4qkcGvB9u0PDallEHl0KcR1pSJUL7Adbak4cEL937TuosN8M1sPYR5seLBKjTxI7u83iG/
 ZMndyJEQwqoQOQ0svVGPsVseoSkkMY3Lzpdm08k3rBd/zxOe4nrO3RzXNjkJniJGRT25zcGfnGd
 yZWsjLRTs7DASWcYVtxdEUoNESnMNbBV6PVXCt4TarTB5O1hr6/pAo/+R69LMdvlZHOU47pCN1e
 nPfFlf+EZjUh9KzFOSZydSIPJYDoGl+IjxsJAd8epBYim/UKBHtHd1aQ6oQ78dEOUoqnw3A3gp1
 RqIA/I64aeCHKvP/wyOhVl4CtXLcYzFHUGWD1ERshkuTuoEjRY77A==
X-Received: by 2002:a05:6402:324b:b0:6a1:7718:ad44 with SMTP id
 4fb4d7f45d1cf-6a36c393acfmr1167123a12.21.1786474113098; 
 Tue, 11 Aug 2026 11:48:33 -0700 (PDT)
Received: from [127.0.1.1]
 (p200300ff0f038f001cf8ed71865ce089.dip0.t-ipconnect.de.
 [2003:ff:f03:8f00:1cf8:ed71:865c:e089])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6a362ec88f5sm950529a12.19.2026.08.11.11.48.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Aug 2026 11:48:32 -0700 (PDT)
From: Shahriyar Jalayeri <shahriyar@byteray.co.uk>
Date: Tue, 11 Aug 2026 20:48:13 +0200
Subject: [PATCH 2/3] net: lwip: wget: free the transfer context after an
 aborted request
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260811-lwip-httpc-uaf-v1-2-9f0ba7331dea@byteray.co.uk>
References: <20260811-lwip-httpc-uaf-v1-0-9f0ba7331dea@byteray.co.uk>
In-Reply-To: <20260811-lwip-httpc-uaf-v1-0-9f0ba7331dea@byteray.co.uk>
To: u-boot@lists.u-boot-project.org, 
 Jerome Forissier <jerome.forissier@arm.com>
Cc: Tom Rini <trini@konsulko.com>, David Lechner <dlechner@baylibre.com>, 
 Argus <argus@byteray.co.uk>, Shahriyar Jalayeri <shahriyar@byteray.co.uk>
X-Mailer: b4 0.15.2
X-Mailman-Approved-At: Tue, 11 Aug 2026 23:05:00 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=byteray-co-uk.20251104.gappssmtp.com; s=20251104; t=1786474489; x=1787079289;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=OAXQ1NALlOaYjY26BPptNiiUW+lSLwsngOtulfqFl88=;
 b=glDvyn3vIKjPv7o8TFpGpqNiMmimIc55VAL8xIBYzn++l60mwxTzXF5pD3gNPtFXO+
 XBD45IIWaLKEe1r/M1sW+CIBS93OrdHspPvHGG/FEmxmoTxgkD8aJ5W7RJ8j4gzNBenT
 CDscxCvyMnk9JmSWSX6mVBs9Geelcnk9JvrqA03nRe44Z3oG5vMtyoUF7XAib/1dbvq8
 cqCm3nnWYjyZDKQ2mmTUQiAQb3KbruVBW08Y0+p1F2/aFCF0qbPWO3znDcMwVZtOiiRk
 nq4thWISc4c5Ebh9a5tN40BRLOCPhqi+RVYAwFNqGHXVvzMr+hbKu8UQS8+t0OTB3LR5
 ytaA==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=byteray.co.uk
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=byteray-co-uk.20251104.gappssmtp.com
 header.i=@byteray-co-uk.20251104.gappssmtp.com header.a=rsa-sha256
 header.s=20251104 header.b=glDvyn3v
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

Allocate the context on the heap and add an 'abandoned' flag. On Ctrl-C
with a request still in flight, mark it abandoned and hand ownership to
the lwIP callback, which frees the context when the connection finally
tears down; the receive, headers-done and result callbacks return early
so a stale callback neither stores data nor touches wget_info.

Fixes: 3c656c928bd7 ("net: lwip: add wget command")
Signed-off-by: Shahriyar Jalayeri <shahriyar@byteray.co.uk>
---
 net/lwip/wget.c | 71 ++++++++++++++++++++++++++++++++++++++++++++-------------
 1 file changed, 55 insertions(+), 16 deletions(-)

diff --git a/net/lwip/wget.c b/net/lwip/wget.c
index 9e93765926d..b81509dff3f 100644
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
@@ -39,6 +40,7 @@ struct wget_ctx {
 	ulong content_len;
 	ulong hash_count;
 	enum done_state done;
+	bool abandoned;
 };
 
 static void wget_lwip_fill_info(struct pbuf *hdr, u16_t hdr_len, u32_t hdr_cont_len)
@@ -200,6 +202,13 @@ static err_t httpc_recv_cb(void *arg, struct altcp_pcb *pcb, struct pbuf *pbuf,
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
 
@@ -227,6 +236,12 @@ static void httpc_result_cb(void *arg, httpc_result_t httpc_result,
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
@@ -282,6 +297,9 @@ static err_t httpc_headers_done_cb(httpc_state_t *connection, void *arg, struct
 {
 	struct wget_ctx *ctx = arg;
 
+	if (ctx->abandoned)
+		return ERR_BUF;
+
 	wget_lwip_fill_info(hdr, hdr_len, content_len);
 
 	if (wget_info->check_buffer_size && (ulong)content_len > wget_info->buffer_size)
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

