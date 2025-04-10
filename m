Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F01F2C369A2
	for <u-boot@archiver.kernel.org>; Thu, 10 Apr 2025 15:16:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 72D8683D4A;
	Thu, 10 Apr 2025 17:16:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="bBClSTF3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5D10F83D3D; Thu, 10 Apr 2025 17:16:17 +0200 (CEST)
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com
 [IPv6:2a00:1450:4864:20::429])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4ABE683D28
 for <u-boot@lists.denx.de>; Thu, 10 Apr 2025 17:16:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-3913b539aabso562269f8f.2
 for <u-boot@lists.denx.de>; Thu, 10 Apr 2025 08:16:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744298174; x=1744902974; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9a6sEajqBCa5JgFq0Elu50yxgHZt9DmBTjUOxmODvvA=;
 b=bBClSTF3+6CEUEBbnjP2Nkk9EpqiI9m7B7fdEJfK8z5kEW/jVUSY43g+Ub4d2ITLpP
 5c7zSqfXmqqB2qzd5kAo08lQd2RLuQRTxpp5ACaJGeOXiCft7LNhPpvDG8kq40b2anIs
 8eD5y7LQCwPZZr2tNRrVbp1kFHXcH0w5mDJmfMuw87K0YzW15PLjsOJPI0/smY3k6C7P
 y4mNP4USkCGfcuJu0TGSaeT9J0yDToaQlw0jFt8U0MVRYZBFoH4qGjKPVahDv6uvBHs2
 m7QOIZ5njR2pr2XdpNGRFmQbvYpNEo04HSCm+vEqFBe4gd77LescdljrNlzlbpuIZLWo
 kCMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744298174; x=1744902974;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9a6sEajqBCa5JgFq0Elu50yxgHZt9DmBTjUOxmODvvA=;
 b=jLIXTdsUlP7kicNfxATJnLVcMPF8KKzd9HeAUft7yb8K+N3XbACff6wycQzTLuax1c
 XzOvh15T15kDfUCCCXm3CdxhspGSvSfn8euDIdl6GkdWnsVZ7bnSUK4Z7mUGVUJc5L01
 XfEocipFuHvOdNBNViUHzXaNC0xGSxVgTymnFxhpxyIUvY1BMvNYxRvWi25PIcbTUjG6
 ble3hBkoEtZwKI8ngh0qtdnzTnAQXCG+Rkb5duAZr7UsovF0G830a4UgXd0d8BjOy1AT
 DiUTTKCP5dGuo83J7+1+wqfs5khv+qb0iHkY4zPhJuUwKri4qto/DnEWn3lpnIdjQ/PA
 Mlew==
X-Gm-Message-State: AOJu0YywCXd/ACmFNW6da+pvlTBQqRtDZKeyKchlA5oYWkVcAYjIhZFC
 0qr+c8lKDokAS4Jz2Spd1QhIH8/2D5QVxqV7qi9aqOeZoMI+rVcRBiu834PdBhUL4WT7F7R4yjk
 4sqs=
X-Gm-Gg: ASbGnctsDyrDTrf6vFxZWU+8HuZw/rzZR4XMgNfHrfbWluHeB57BkPC6f3H0pnvFuVe
 3sncUL36aXD/kX0HyDsH9UDDLN4ZIuicP+k01xqw8/EmwdcXtmRVyJbla0/8rsAi/9vY6uwRBcN
 FscLPqpYjtn7+svDPq+hUN6Kt/yIaNsUuZEGC2RszMIba4AFOgpP1XkGv+80Pb55RW5uD1M/+up
 DZ083yt601TbKJpqlMRwDpk1WfhcE7O2ytKWxCCMWeJkPPF3sj2nqiOQrgETZ7nZG62GzuoQkmT
 jBszeRCIAadbWnNuTkh8B6gQoZFdTPaKC7he3S6PoEVwfaFYeQ==
X-Google-Smtp-Source: AGHT+IF8dtndPFMtJY7sEe/v9Z3gnDb/elQl1ZKORs9PBDtScyJYC3hf23/BELS0pedbL1xrcficoA==
X-Received: by 2002:a05:6000:420b:b0:391:3915:cfea with SMTP id
 ffacd0b85a97d-39d8f4e63demr2646083f8f.38.1744298174404; 
 Thu, 10 Apr 2025 08:16:14 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:7edb:df05:a425:37cd])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43f233c824bsm54873225e9.24.2025.04.10.08.16.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Apr 2025 08:16:14 -0700 (PDT)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: U-Boot mailing list <u-boot@lists.denx.de>
Cc: Jerome Forissier <jerome.forissier@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Adriano Cordova <adrianox@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v3 1/3] net-lwip: wget_do_request(): do not print anything to
 the console
Date: Thu, 10 Apr 2025 17:14:52 +0200
Message-ID: <20250410151600.3370247-2-jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250410151600.3370247-1-jerome.forissier@linaro.org>
References: <20250410151600.3370247-1-jerome.forissier@linaro.org>
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

Functions called from EFI applications should not call printf().
Refactor wget_do_request() to implement this requirement.

Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
Reported-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
---

Changes in v3:
- New patch: net-lwip: wget_do_request(): do not print anything to the
  console

 net/lwip/wget.c | 37 +++++++++++++++++++++++--------------
 1 file changed, 23 insertions(+), 14 deletions(-)

diff --git a/net/lwip/wget.c b/net/lwip/wget.c
index ec098148835..d3628cf72de 100644
--- a/net/lwip/wget.c
+++ b/net/lwip/wget.c
@@ -36,6 +36,7 @@ struct wget_ctx {
 	ulong prevsize;
 	ulong start_time;
 	enum done_state done;
+	bool silent;
 };
 
 static void wget_lwip_fill_info(struct pbuf *hdr, u16_t hdr_len, u32_t hdr_cont_len)
@@ -217,7 +218,8 @@ static err_t httpc_recv_cb(void *arg, struct altcp_pcb *pcb, struct pbuf *pbuf,
 		memcpy((void *)ctx->daddr, buf->payload, buf->len);
 		ctx->daddr += buf->len;
 		ctx->size += buf->len;
-		if (ctx->size - ctx->prevsize > PROGRESS_PRINT_STEP_BYTES) {
+		if (!ctx->silent &&
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
+	if (!ctx->silent) {
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
@@ -372,13 +378,14 @@ static int set_cacert(char * const saddr, char * const ssz)
 #endif
 #endif  /* CONFIG_WGET_CACERT || CONFIG_WGET_BUILTIN_CACERT */
 
-static int wget_loop(struct udevice *udev, ulong dst_addr, char *uri)
+static int wget_loop(ulong dst_addr, char *uri, bool silent)
 {
 #if CONFIG_IS_ENABLED(WGET_HTTPS)
 	altcp_allocator_t tls_allocator;
 #endif
 	httpc_connection_t conn;
 	httpc_state_t *state;
+	struct udevice *udev;
 	struct netif *netif;
 	struct wget_ctx ctx;
 	char *path;
@@ -390,6 +397,13 @@ static int wget_loop(struct udevice *udev, ulong dst_addr, char *uri)
 	ctx.size = 0;
 	ctx.prevsize = 0;
 	ctx.start_time = 0;
+	ctx.silent = silent;
+
+	if (!wget_info)
+		wget_info = &default_wget_info;
+
+	net_lwip_set_current();
+	udev = eth_get_dev();
 
 	if (parse_url(uri, ctx.server_name, &ctx.port, &path, &is_https))
 		return CMD_RET_USAGE;
@@ -471,12 +485,7 @@ static int wget_loop(struct udevice *udev, ulong dst_addr, char *uri)
 
 int wget_do_request(ulong dst_addr, char *uri)
 {
-	net_lwip_set_current();
-
-	if (!wget_info)
-		wget_info = &default_wget_info;
-
-	return wget_loop(eth_get_dev(), dst_addr, uri);
+	return wget_loop(dst_addr, uri, true);
 }
 
 int do_wget(struct cmd_tbl *cmdtp, int flag, int argc, char * const argv[])
@@ -521,7 +530,7 @@ int do_wget(struct cmd_tbl *cmdtp, int flag, int argc, char * const argv[])
 		return CMD_RET_FAILURE;
 
 	wget_info = &default_wget_info;
-	if (wget_do_request(dst_addr, nurl))
+	if (wget_loop(dst_addr, nurl, false))
 		return CMD_RET_FAILURE;
 
 	return CMD_RET_SUCCESS;
-- 
2.43.0

