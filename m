Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5D84D41D46
	for <u-boot@archiver.kernel.org>; Tue, 12 Nov 2024 02:48:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 54BD98936C;
	Tue, 12 Nov 2024 03:47:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="LMhYdXea";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 053E389390; Mon, 11 Nov 2024 22:09:24 +0100 (CET)
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com
 [IPv6:2607:f8b0:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C373489308
 for <u-boot@lists.denx.de>; Mon, 11 Nov 2024 22:09:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=adrianox@gmail.com
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-20ca1b6a80aso52896325ad.2
 for <u-boot@lists.denx.de>; Mon, 11 Nov 2024 13:09:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1731359360; x=1731964160; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kEWp96VSHpRvpYgoXgS9nEZCB6a4+/TUWxB68SOPSzQ=;
 b=LMhYdXeafkyredmYmQoAeSxAarLcA5ekhggsk+2R62PeF1iwyBFjTZPlO8w65WTaLR
 Fv1s53lYa02Vu1cfoNJ2ZhqZCNPbpMtnEOdTwArfQyclJ5j+g2uxZV0qebcu86E0uwW+
 zKd+pwDgizJjKmCfeIDGmtyCFKrKuH3xgcOPZvZ8luSbompZ3kAPESrHzT46fgjgTANI
 Nnv4OdSA9B9zLYH7WPwIbB9aGCYcniTNyYxaRgOPquo8jrpW6vxka2kUxGx2jrTudOFC
 atqr/OgQsX/O7MlYpDXHaFFfVHlt85fD+36zunLaeV7a7cARMQO55wjm7XqyL2dg4OSU
 H1Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731359360; x=1731964160;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kEWp96VSHpRvpYgoXgS9nEZCB6a4+/TUWxB68SOPSzQ=;
 b=H/11O6qem5XUidmiFZNHHNQgt2gJBKik0/ni35E038lQisvUmg5v33tlISp1XgTnht
 t0dpvZSqUz0J0rwUrSDrF0caGqMAnOX3qgMSO274FBpZkriwjqV9aPXu6caYqUoZHEcI
 /eH5kL0hFVoQK0bnyeVZJUSbPrDrJnsnIJMErCXj/BZ5Xc0uCWmaeCLKEaxZkoNso/JQ
 0Meiwm1VnySUgV63U43Vns+aZqiH8Sux+XgvVuDpLbfSWwefkeDDMy4ym0yX/DWnfpNM
 2d54ILt1Gk+bsVNowJCZqLGCJ6vhDFfJCa7ABGLSFJ4THsWg84rSMXyhcMqGSa6iLewI
 oPVw==
X-Gm-Message-State: AOJu0Ywwkdg1kWNBX0JB6M7aj0miDEBKmeyZMjhopobctXAo9Z0TIY+H
 H/HHCxCU8E5YEBY3wUp4l+Dy/7CnclqZ9b9ue+EABztMWzrGapjqsmde09TZ
X-Google-Smtp-Source: AGHT+IGlVieiAHmMpGVyyQEayb8VHovO10Lyt8BEC+g2fVHCMn+lNc51S91HXcudF3RG7ocJwgCZIA==
X-Received: by 2002:a17:902:cecf:b0:20c:93c2:9175 with SMTP id
 d9443c01a7336-21183d191bbmr164773385ad.30.1731359360215; 
 Mon, 11 Nov 2024 13:09:20 -0800 (PST)
Received: from adriano.. ([191.119.55.5]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21177dc9068sm79807415ad.2.2024.11.11.13.09.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Nov 2024 13:09:19 -0800 (PST)
From: Adriano Cordova <adrianox@gmail.com>
To: u-boot@lists.denx.de
Cc: joe.hershberger@ni.com, rfried.dev@gmail.com, jerome.forissier@linaro.org,
 xypron.glpk@gmx.de, ilias.apalodimas@linaro.org,
 Adriano Cordova <adrianox@gmail.com>
Subject: [PATCH v2 7/7] net/lwip: wget: integrate struct wget_info into wget
 code
Date: Mon, 11 Nov 2024 18:09:01 -0300
Message-ID: <20241111210901.560691-8-adrianox@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241111210901.560691-1-adrianox@gmail.com>
References: <20241111210901.560691-1-adrianox@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 12 Nov 2024 03:47:02 +0100
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

Each wget request now fills the struct wget_info. Also, the
efi bootdevice is now set conditionally to the set_bootdevice
variable in wget_info and a buffer size check is performed if
check_buffer_size is set.

Signed-off-by: Adriano Cordova <adrianox@gmail.com>
---

Changes in v2:
- wget_info is now a pointer
- wget_lwip_fill_info now directly uses wget_info instead of receiving a pointer to it
  as an argument.
- Set default_wget_info as the default wget_http_info.

 net/lwip/wget.c | 42 ++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 40 insertions(+), 2 deletions(-)

diff --git a/net/lwip/wget.c b/net/lwip/wget.c
index 4add520045..53c3b169e0 100644
--- a/net/lwip/wget.c
+++ b/net/lwip/wget.c
@@ -34,6 +34,18 @@ struct wget_ctx {
 	enum done_state done;
 };
 
+static void wget_lwip_fill_info(struct pbuf *hdr, u16_t hdr_len, u32_t hdr_cont_len)
+{
+	if (wget_info->headers && hdr_len < MAX_HTTP_HEADERS_SIZE)
+		pbuf_copy_partial(hdr, (void *)wget_info->headers, hdr_len, 0);
+	wget_info->hdr_cont_len = (u32)hdr_cont_len;
+}
+
+static void wget_lwip_set_file_size(u32_t rx_content_len)
+{
+	wget_info->file_size = (ulong)rx_content_len;
+}
+
 static int parse_url(char *url, char *host, u16 *port, char **path)
 {
 	char *p, *pp;
@@ -178,6 +190,13 @@ static void httpc_result_cb(void *arg, httpc_result_t httpc_result,
 	struct wget_ctx *ctx = arg;
 	ulong elapsed;
 
+	wget_info->status_code = (u32)srv_res;
+
+	if (err == ERR_BUF) {
+		ctx->done = FAILURE;
+		return;
+	}
+
 	if (httpc_result != HTTPC_RESULT_OK) {
 		log_err("\nHTTP client error %d\n", httpc_result);
 		ctx->done = FAILURE;
@@ -197,8 +216,11 @@ static void httpc_result_cb(void *arg, httpc_result_t httpc_result,
 	printf("%u bytes transferred in %lu ms (", rx_content_len, elapsed);
 	print_size(rx_content_len / elapsed * 1000, "/s)\n");
 	printf("Bytes transferred = %lu (%lx hex)\n", ctx->size, ctx->size);
-	efi_set_bootdev("Net", "", ctx->path, map_sysmem(ctx->saved_daddr, 0),
-			rx_content_len);
+	if (wget_info->set_bootdev) {
+		efi_set_bootdev("Net", "", ctx->path, map_sysmem(ctx->saved_daddr, 0),
+				rx_content_len);
+	}
+	wget_lwip_set_file_size(rx_content_len);
 	if (env_set_hex("filesize", rx_content_len) ||
 	    env_set_hex("fileaddr", ctx->saved_daddr)) {
 		log_err("Could not set filesize or fileaddr\n");
@@ -209,6 +231,17 @@ static void httpc_result_cb(void *arg, httpc_result_t httpc_result,
 	ctx->done = SUCCESS;
 }
 
+static err_t httpc_headers_done_cb(httpc_state_t *connection, void *arg, struct pbuf *hdr,
+				   u16_t hdr_len, u32_t content_len)
+{
+	wget_lwip_fill_info(hdr, hdr_len, content_len);
+
+	if (wget_info->check_buffer_size && (ulong)content_len > wget_info->buffer_size)
+		return ERR_BUF;
+
+	return ERR_OK;
+}
+
 static int wget_loop(struct udevice *udev, ulong dst_addr, char *uri)
 {
 	httpc_connection_t conn;
@@ -233,6 +266,7 @@ static int wget_loop(struct udevice *udev, ulong dst_addr, char *uri)
 
 	memset(&conn, 0, sizeof(conn));
 	conn.result_fn = httpc_result_cb;
+	conn.headers_done_fn = httpc_headers_done_cb;
 	ctx.path = path;
 	if (httpc_get_file_dns(ctx.server_name, ctx.port, path, &conn, httpc_recv_cb,
 			       &ctx, &state)) {
@@ -259,6 +293,9 @@ int wget_with_dns(ulong dst_addr, char *uri)
 {
 	eth_set_current();
 
+	if (!wget_info)
+		wget_info = &default_wget_info;
+
 	return wget_loop(eth_get_dev(), dst_addr, uri);
 }
 
@@ -285,6 +322,7 @@ int do_wget(struct cmd_tbl *cmdtp, int flag, int argc, char * const argv[])
 	if (parse_legacy_arg(url, nurl, sizeof(nurl)))
 	    return CMD_RET_FAILURE;
 
+	wget_info = &default_wget_info;
 	if (wget_with_dns(dst_addr, nurl))
 		return CMD_RET_FAILURE;
 
-- 
2.43.0

