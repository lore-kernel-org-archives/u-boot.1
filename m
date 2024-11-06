Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6D18D44D77
	for <u-boot@archiver.kernel.org>; Wed,  6 Nov 2024 14:14:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 33B7189218;
	Wed,  6 Nov 2024 15:13:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="FiVamSDq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 644BD891CF; Wed,  6 Nov 2024 14:04:37 +0100 (CET)
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com
 [IPv6:2607:f8b0:4864:20::102b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3BC8C88E5C
 for <u-boot@lists.denx.de>; Wed,  6 Nov 2024 14:04:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=adrianox@gmail.com
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-2e2e23f2931so5075942a91.0
 for <u-boot@lists.denx.de>; Wed, 06 Nov 2024 05:04:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1730898274; x=1731503074; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=mlAUx/Sg1Pgrp45uD0MJl22B+NV7fG9Ab8N3G+2s8tQ=;
 b=FiVamSDqyIGtIWIBw5eAjsxsS+j+i7AWDgpUIFgtCDp7j/0zeNRNGWr8a/n47D92Ux
 gi3Y1iBoJt8uy2+kxJoB1fUVDItP7TsxJJ6S/FgIXpVx8ABtiM5b2l9qz6Bx3qrAG4U2
 S2LVsb6hmZZQdT4dLTbCbq4xHF5mE46XheDTBlis7rYPGCYfqQJQ/ohRI/5RNi8Xa87w
 fdu91G3nta7iLE68bKuBH8kT+ThGBwXqno8UUxnIpW5VhXO1QBF321HxddeiBq7n4iuQ
 8JsliMpdqF6+GhaBFEQdwks3d7VqvPEwRbyLKbzs+052yJ4xzgZDI+DPgCck+yftQwQH
 CW2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730898274; x=1731503074;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=mlAUx/Sg1Pgrp45uD0MJl22B+NV7fG9Ab8N3G+2s8tQ=;
 b=rxSZphI5G8Ko7lVSGPGQTgH6Wxm3DOv/cAzDOuEZc2Cdhrm7yOfmQA6jBBaWH8VsEZ
 QrFGp93stp1SL5nuWE011ldLHhrU1D9q2kbu5nEI63Jmt8BH7ZGhap/BeqXGZghcPJRS
 YsJHBal3VeMOnzIltbSXU1Yi6Xx7sZxOCTZ6vv7bPeq75x40gheWMoJqJD0OoNhMDIbB
 jI0H4WFrziCbIZ95RQnBtQnFnUULU70yu4NObuRqnLiGzZhZm78l85rPRmaMHFQDNfU3
 4qnWfVaN/TEK2+a2xlRm27324gwf/fauISDbBDmNhkgz8Iu9zlcUm50QU9qTTgAUYg5L
 pfqQ==
X-Gm-Message-State: AOJu0YwWiwQ8nLWR62bA2sCSdOCdy684/H8DeJLGdEd9InkrXg9hbFmb
 Dku5fXw9PqwEDby0HjoVftCTOVjAD4kuKPNYT3cAOz1POrf9wolkW4cUGeP26/c=
X-Google-Smtp-Source: AGHT+IEBNwyjMjEKpwA1vAYgJBlCbqiUwmy2itEBTkoM8nd5WH8ogUsN/+dgqHCGYUNIpmsanktYlw==
X-Received: by 2002:a17:90b:2781:b0:2e5:5e55:7f18 with SMTP id
 98e67ed59e1d1-2e94c2e77f5mr27974470a91.24.1730898273715; 
 Wed, 06 Nov 2024 05:04:33 -0800 (PST)
Received: from adriano.. ([191.119.55.5]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2e99a4f6c96sm1555903a91.2.2024.11.06.05.04.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 Nov 2024 05:04:33 -0800 (PST)
From: Adriano Cordova <adrianox@gmail.com>
To: u-boot@lists.denx.de
Cc: joe.hershberger@ni.com, rfried.dev@gmail.com, jerome.forissier@linaro.org,
 xypron.glpk@gmx.de, Adriano Cordova <adrianox@gmail.com>
Subject: [PATCH 6/7] net/lwip: wget: put server_name and port into wget_ctx
Date: Wed,  6 Nov 2024 10:04:28 -0300
Message-ID: <20241106130428.211190-1-adrianox@gmail.com>
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

Currently server_name and port are local variables in wget_loop.
This commit puts them inside ctx, so that they are accessible
from the http callbacks.

Signed-off-by: Adriano Cordova <adrianox@gmail.com>
---
 net/lwip/wget.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/lwip/wget.c b/net/lwip/wget.c
index b495ebd1aa..4add520045 100644
--- a/net/lwip/wget.c
+++ b/net/lwip/wget.c
@@ -23,6 +23,8 @@ enum done_state {
 };
 
 struct wget_ctx {
+	char server_name[SERVER_NAME_SIZE];
+	u16 port;
 	char *path;
 	ulong daddr;
 	ulong saved_daddr;
@@ -209,13 +211,11 @@ static void httpc_result_cb(void *arg, httpc_result_t httpc_result,
 
 static int wget_loop(struct udevice *udev, ulong dst_addr, char *uri)
 {
-	char server_name[SERVER_NAME_SIZE];
 	httpc_connection_t conn;
 	httpc_state_t *state;
 	struct netif *netif;
 	struct wget_ctx ctx;
 	char *path;
-	u16 port;
 
 	ctx.daddr = dst_addr;
 	ctx.saved_daddr = dst_addr;
@@ -224,7 +224,7 @@ static int wget_loop(struct udevice *udev, ulong dst_addr, char *uri)
 	ctx.prevsize = 0;
 	ctx.start_time = 0;
 
-	if (parse_url(uri, server_name, &port, &path))
+	if (parse_url(uri, ctx.server_name, &ctx.port, &path))
 		return CMD_RET_USAGE;
 
 	netif = net_lwip_new_netif(udev);
@@ -234,7 +234,7 @@ static int wget_loop(struct udevice *udev, ulong dst_addr, char *uri)
 	memset(&conn, 0, sizeof(conn));
 	conn.result_fn = httpc_result_cb;
 	ctx.path = path;
-	if (httpc_get_file_dns(server_name, port, path, &conn, httpc_recv_cb,
+	if (httpc_get_file_dns(ctx.server_name, ctx.port, path, &conn, httpc_recv_cb,
 			       &ctx, &state)) {
 		net_lwip_remove_netif(netif);
 		return CMD_RET_FAILURE;
-- 
2.43.0

