Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BE2ED41D44
	for <u-boot@archiver.kernel.org>; Tue, 12 Nov 2024 02:48:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EAADC893C6;
	Tue, 12 Nov 2024 03:47:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="TOzI9HzF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0108889395; Mon, 11 Nov 2024 22:09:22 +0100 (CET)
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com
 [IPv6:2607:f8b0:4864:20::636])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CE55E89390
 for <u-boot@lists.denx.de>; Mon, 11 Nov 2024 22:09:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=adrianox@gmail.com
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-20c77459558so44941195ad.0
 for <u-boot@lists.denx.de>; Mon, 11 Nov 2024 13:09:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1731359358; x=1731964158; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UBa2GkXLuIYJ65Jon+bpKA9Vxhlr8kT8576a43XST8c=;
 b=TOzI9HzFuEz9jtRG1mERFUeiJA1IyRhEJAsdEJCNPUTCXLrrrPjDVtYDC/xCRBuwJ8
 CY1utoJk+RsfIrwaXJgIEzuCdXrzMIvEj9UDtI40xyQ/rB89qm86Hy+3I8VH7IWbwk2l
 HUAcC4eLPBAb/+dRTaYPrxAvELEu5zj2PS1/0cRK77O/2sCfxpdmI6mQ8Vw2F0sFKVXw
 wgKoPUbI7qNo/SehNWhrTzzXjhvhTJN6ywvdQYQm5Mo5e1oGTrL4ktFMhLdeCI7mMFc5
 TJRruemWiw6r4v40Wg77Mit5ZrFMDaADoqyt7i+Vf2krEWjzuNOw/SyCA+92zoGkP77J
 AttA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731359358; x=1731964158;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UBa2GkXLuIYJ65Jon+bpKA9Vxhlr8kT8576a43XST8c=;
 b=NmztYYGBf8SYN2UcGEBj67GTCcU9qeVSqONAWaxHEGQ9n6ptLmRxiZ1RqtUu6cYsTd
 apguBKtJfXeZDDSqbF3WkKugHdNOM57p81orhFifJyRqiew8xM6H4LJPiLtKQ9VjZqrm
 6IuwA5szr0vZxMwCOxxzC3/ohtDThSJjoxmHeLg+xAEBsWqLX5OUSPsE37WgUucEQniT
 lP82K10KyriL6JmwMZZFLJQ/mdt8rvsjzmH+crB28xy/K8ooqNUGONmcyUzmiTImlv+4
 HkiuhlN6PkKGmaa1SGNbR+bpMOAgZmiTXbK0sJVPYy2+zG14/xSii2u3DH1sOfQMvDJB
 JYAA==
X-Gm-Message-State: AOJu0Yy6pXGcbHBA/tbV9Gn0MXRAGDXsVYsAK1JACyodw4QtFOCv6LHb
 0nkkMs0rDyNPYNOfSYqHkuW6AGhtA9VNULKqAGKcNUbMkbjJ0TVAXaqpAl87
X-Google-Smtp-Source: AGHT+IFwRmTUPlVOCR4RiCrLVEJE5bzqWn48hvZZe1eSCEOlvYlGF2BitSs9NmByFeMMmKG85MlWMQ==
X-Received: by 2002:a17:902:e951:b0:20c:5bdc:c228 with SMTP id
 d9443c01a7336-211ab92969cmr2198355ad.13.1731359358355; 
 Mon, 11 Nov 2024 13:09:18 -0800 (PST)
Received: from adriano.. ([191.119.55.5]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21177dc9068sm79807415ad.2.2024.11.11.13.09.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Nov 2024 13:09:18 -0800 (PST)
From: Adriano Cordova <adrianox@gmail.com>
To: u-boot@lists.denx.de
Cc: joe.hershberger@ni.com, rfried.dev@gmail.com, jerome.forissier@linaro.org,
 xypron.glpk@gmx.de, ilias.apalodimas@linaro.org,
 Adriano Cordova <adrianox@gmail.com>
Subject: [PATCH v2 6/7] net/lwip: wget: put server_name and port into wget_ctx
Date: Mon, 11 Nov 2024 18:09:00 -0300
Message-ID: <20241111210901.560691-7-adrianox@gmail.com>
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

Currently server_name and port are local variables in wget_loop.
This commit puts them inside ctx, so that they are accessible
from the http callbacks.

Signed-off-by: Adriano Cordova <adrianox@gmail.com>
---

(no changes since v1)

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

