Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE7FBD44D75
	for <u-boot@archiver.kernel.org>; Wed,  6 Nov 2024 14:14:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8544E8921E;
	Wed,  6 Nov 2024 15:13:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="mKq1ihtz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 22E47891CF; Wed,  6 Nov 2024 14:04:55 +0100 (CET)
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com
 [IPv6:2607:f8b0:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DC63888E5C
 for <u-boot@lists.denx.de>; Wed,  6 Nov 2024 14:04:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=adrianox@gmail.com
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-20cbcd71012so76116295ad.3
 for <u-boot@lists.denx.de>; Wed, 06 Nov 2024 05:04:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1730898291; x=1731503091; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=WQXUQ87baf6VUD4sk+fZshBlW38IUXZZNKLreXcrq7Y=;
 b=mKq1ihtzAz+kzVTj8c7k3OCQiHWwsj5um6TfLRjyw/n+Qyg/jOZyl/AIbprVllU1sn
 RthH1mDZI4HaZ7SmUVIbrnlOErJ7U6U4wUfUhpRRekr6NHWojrrAqOkO1eeDPNeKHS3z
 MmgQwoJE0Xbpd9DyOviQj8kjl8k3/tsUUaLYEBoGRC7wHAV1gf8Syg0NOuKCjrmwok02
 BAcdc19BBsxVtnwfc4e739eD8NU4l8P+dFtymqG4nJyhTsO2w3d6hEenDiGUOlUN+54/
 F4DCrcekdiDWYKhsoejuxgu9M7LF9ZM9tlftCCz01fCRDffLrv4xUuAiPz1w3lgGb6iO
 pqow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730898291; x=1731503091;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=WQXUQ87baf6VUD4sk+fZshBlW38IUXZZNKLreXcrq7Y=;
 b=WHkblHbEfsl+yjDj/GXaAzaxsmhEGrhPNv89VG0h88j+D/t/6Q51Vq6/7lNT6FIJVI
 Z8sk/r68ZhJ7de1nzi8haH4vckjFImPbcIdYQ32QZo47mPdmlV7PdXB8miwfPxy2EVUA
 v1f2UY6xIOL2xCFDXbzBgnKa7sFpED3ugxdIOZrbAGFLlEe0N5aHoH35TrT6ZTrkdsAW
 iu0lYd4QIOJVhuCqC7OZT5ZxuFAjzMm3Qk1IYGI4mckGkY0UUr2/2FNRkGDQc4dl3IcP
 24IYKvZQUdKJfvW4RxCMlLmLCHa9eYBjXa1zW1DVbwnFLa8YVIHTQZ+nDf6twyqr1Ze7
 +FDA==
X-Gm-Message-State: AOJu0Yz2ZnG925mmLLEMZCi0n0+AAxmZcRA6LebKNGElC/uQ5adEsslQ
 KKiQBqMGuNLaU+Q7KiDqVf9SDsLKeavVUYAeMRhq1qRbkMFC8UbXpMaZHrwnvLk=
X-Google-Smtp-Source: AGHT+IFp/xRbUi/UhKHOtvS+W6xA+4Q4d3jzKuuIiu838F2TfRENV/ZHrJLePe9vvbiYAnOxIPI6Sw==
X-Received: by 2002:a17:902:db11:b0:20b:b238:9d02 with SMTP id
 d9443c01a7336-2111af31802mr294573175ad.33.1730898291340; 
 Wed, 06 Nov 2024 05:04:51 -0800 (PST)
Received: from adriano.. ([191.119.55.5]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-211057a2a8asm95603295ad.180.2024.11.06.05.04.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 Nov 2024 05:04:50 -0800 (PST)
From: Adriano Cordova <adrianox@gmail.com>
To: u-boot@lists.denx.de
Cc: joe.hershberger@ni.com, rfried.dev@gmail.com, jerome.forissier@linaro.org,
 xypron.glpk@gmx.de, Adriano Cordova <adrianox@gmail.com>
Subject: [PATCH 7/7] net/lwip: wget: integrate struct wget_info into wget code
Date: Wed,  6 Nov 2024 10:04:46 -0300
Message-ID: <20241106130446.211222-1-adrianox@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 06 Nov 2024 15:13:43 +0100
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
 net/lwip/wget.c | 39 +++++++++++++++++++++++++++++++++++++--
 1 file changed, 37 insertions(+), 2 deletions(-)

diff --git a/net/lwip/wget.c b/net/lwip/wget.c
index 4add520045..bc0ecfe5b7 100644
--- a/net/lwip/wget.c
+++ b/net/lwip/wget.c
@@ -34,6 +34,19 @@ struct wget_ctx {
 	enum done_state done;
 };
 
+static void wget_lwip_fill_info(struct pbuf *hdr, u16_t hdr_len,
+				struct wget_http_info *info, u32_t hdr_cont_len)
+{
+	if (info->headers && hdr_len < MAX_HTTP_HEADERS_SIZE)
+		pbuf_copy_partial(hdr, (void *)info->headers, hdr_len, 0);
+	info->hdr_cont_len = (u32)hdr_cont_len;
+}
+
+static void wget_lwip_set_file_size(u32_t rx_content_len, struct wget_http_info *info)
+{
+	info->file_size = (ulong)rx_content_len;
+}
+
 static int parse_url(char *url, char *host, u16 *port, char **path)
 {
 	char *p, *pp;
@@ -178,6 +191,13 @@ static void httpc_result_cb(void *arg, httpc_result_t httpc_result,
 	struct wget_ctx *ctx = arg;
 	ulong elapsed;
 
+	wget_info.status_code = (ulong)srv_res;
+
+	if (err == ERR_BUF) {
+		ctx->done = FAILURE;
+		return;
+	}
+
 	if (httpc_result != HTTPC_RESULT_OK) {
 		log_err("\nHTTP client error %d\n", httpc_result);
 		ctx->done = FAILURE;
@@ -197,8 +217,11 @@ static void httpc_result_cb(void *arg, httpc_result_t httpc_result,
 	printf("%u bytes transferred in %lu ms (", rx_content_len, elapsed);
 	print_size(rx_content_len / elapsed * 1000, "/s)\n");
 	printf("Bytes transferred = %lu (%lx hex)\n", ctx->size, ctx->size);
-	efi_set_bootdev("Net", "", ctx->path, map_sysmem(ctx->saved_daddr, 0),
-			rx_content_len);
+	if (wget_info.set_bootdev) {
+		efi_set_bootdev("Net", "", ctx->path, map_sysmem(ctx->saved_daddr, 0),
+				rx_content_len);
+	}
+	wget_lwip_set_file_size(rx_content_len, &wget_info);
 	if (env_set_hex("filesize", rx_content_len) ||
 	    env_set_hex("fileaddr", ctx->saved_daddr)) {
 		log_err("Could not set filesize or fileaddr\n");
@@ -209,6 +232,17 @@ static void httpc_result_cb(void *arg, httpc_result_t httpc_result,
 	ctx->done = SUCCESS;
 }
 
+static err_t httpc_headers_done_cb(httpc_state_t *connection, void *arg, struct pbuf *hdr,
+				   u16_t hdr_len, u32_t content_len)
+{
+	wget_lwip_fill_info(hdr, hdr_len, &wget_info, content_len);
+
+	if (wget_info.check_buffer_size && (ulong)content_len > wget_info.buffer_size)
+		return ERR_BUF;
+
+	return ERR_OK;
+}
+
 static int wget_loop(struct udevice *udev, ulong dst_addr, char *uri)
 {
 	httpc_connection_t conn;
@@ -233,6 +267,7 @@ static int wget_loop(struct udevice *udev, ulong dst_addr, char *uri)
 
 	memset(&conn, 0, sizeof(conn));
 	conn.result_fn = httpc_result_cb;
+	conn.headers_done_fn = httpc_headers_done_cb;
 	ctx.path = path;
 	if (httpc_get_file_dns(ctx.server_name, ctx.port, path, &conn, httpc_recv_cb,
 			       &ctx, &state)) {
-- 
2.43.0

