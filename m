Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3157CE64A8A
	for <u-boot@archiver.kernel.org>; Tue,  3 Dec 2024 12:55:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A3EED893AE;
	Tue,  3 Dec 2024 13:55:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="kRL3nxpb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 520D5893A9; Tue,  3 Dec 2024 13:55:43 +0100 (CET)
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com
 [IPv6:2607:f8b0:4864:20::436])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 09BA9893AE
 for <u-boot@lists.denx.de>; Tue,  3 Dec 2024 13:55:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=adrianox@gmail.com
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-724f0f6300aso6093705b3a.2
 for <u-boot@lists.denx.de>; Tue, 03 Dec 2024 04:55:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1733230539; x=1733835339; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=TbXr7szp6IEr2WIJwA7TzRYFJPW40UtO5THuG2yv9YM=;
 b=kRL3nxpb+VbUpEyffIwld3JZ1du/EAn8aJgmnbjRbP416epI0XmNeyUV9ljSJTK42Q
 s0mLWjvKtk6yNxt7ir+7TCupjQK8PDXxNpN5NVLgrEk/YjOtBYBjSgrXSN4ifwxroFHJ
 ymU5SzTowd0ZCNstfVYfYKOWnDXKq5OsacpTFltGGiP5L21IhcpVobZqZskc4tEiQtVL
 Ynq2kCAo3d4LRHaa59DO1BxXIF8ISmF3oGQTmzf3YQuo+oGQz+itWwiL6z7lBAzNeDCW
 eq74JnvHlS0V+qzmSSQW7e9A7qC4y5MH+SFLHHi09ccvun1WZk3FXYyId9f2FKAbsyR8
 cLIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733230539; x=1733835339;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=TbXr7szp6IEr2WIJwA7TzRYFJPW40UtO5THuG2yv9YM=;
 b=R9PqewTMlSFrnM5J431AffB0HmqNBjQw1zO/uheP+U6rfg0PrbLxdeCPXNWrlA0peO
 kmm5GDX+c/0vcaSIYiZSq91mMeYMs8/Sdz2aWR+xvm5sVGsgEfjFySbxO7bh2ourpAnw
 W36fGgvaB9RDDugkQLoFfluOAG28q2ZbNwkNJfpuvJo4iClVguOeePxQcPB4DdAdCns1
 635CM6mpMkCO0bYDed/kv7Tna859NnIqW33y4iWn5vF/+CqfnySjGVcGTVh7xiliYgFW
 s01PlLIBqNSz5WnHI/n+uPA6RnByHJQ9jSZGRTuPrPOvFdDbpMf19CocGsM4Ns5D3vgM
 MzWg==
X-Gm-Message-State: AOJu0Yw1xIOETeFbA74fI2R2pqQ8gCcRXTXC3pArX5cTa8gq0wvnpUj6
 PteMDHhLk7YziZggfF26LL+yWCe1yJRYdNdH1CeqhjEI+JCr2L7nuEkpMGyjzcg=
X-Gm-Gg: ASbGncvJVHSHtMh3bivwGPkP/IYfbkwASggH/a6rV76rB70w1m24kEzupnqqqrj6rFn
 6TVlEGzq+YRHNF9rlmzrF6anmhCgOpvxmXsTFROxXEppmQWmyL8o1wKwsHO3GGG+dHhx+cyZAw6
 wk+l5Trs02c/0pU0rNL1ks0dc2WfKa33frmWECuIz2E3MHO8EKtQgRT6yB51JwVKIZbotb1fxhU
 KO3qGDyQO4FMpiVu6Z5/a391TzxkfUqJWpLg6aEt+s=
X-Google-Smtp-Source: AGHT+IH52EQgPDZMD0yv+Vz4xl/CTUzLUMxQ3AFFbyOcT/EOlOXSFm8AN2mVjkYNZlzuYaj7cBdC7Q==
X-Received: by 2002:a05:6a00:4fca:b0:71e:6b8:2f4a with SMTP id
 d2e1a72fcca58-7257fa77515mr2484737b3a.12.1733230539337; 
 Tue, 03 Dec 2024 04:55:39 -0800 (PST)
Received: from adriano.. ([191.119.55.5]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72541761474sm10327467b3a.32.2024.12.03.04.55.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Dec 2024 04:55:39 -0800 (PST)
From: Adriano Cordova <adrianox@gmail.com>
To: u-boot@lists.denx.de
Cc: joe.hershberger@ni.com, rfried.dev@gmail.com, jerome.forissier@linaro.org,
 xypron.glpk@gmx.de, ilias.apalodimas@linaro.org, trini@konsulko.com,
 Adriano Cordova <adrianox@gmail.com>
Subject: [PATCH v3] lwip: wget: pass port and server_name via wget_ctx
Date: Tue,  3 Dec 2024 09:55:34 -0300
Message-ID: <20241203125534.1582903-1-adrianox@gmail.com>
X-Mailer: git-send-email 2.43.0
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

  Commit 5907c81 ("net: lwip: Enable https:// support for wget") was not
  correctly rebased on top of the changes introduced by Commit 6cc4d04
  ("net/lwip: wget: put server_name and port into wget_ctx") in next.
  This commit re-applies a  couple of lines from 6cc4d04.

  Fixes: Commit 5907c81 ("net: lwip: Enable https:// support for wget")

Signed-off-by: Adriano Cordova <adrianox@gmail.com>
---
Changes in v3: there was still another server_name to be replaced by ctx.server_name
Changes in v2: changed commit name
 net/lwip/wget.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/net/lwip/wget.c b/net/lwip/wget.c
index af48d741a4..3d02f26c09 100644
--- a/net/lwip/wget.c
+++ b/net/lwip/wget.c
@@ -288,7 +288,6 @@ static err_t httpc_headers_done_cb(httpc_state_t *connection, void *arg, struct
 
 static int wget_loop(struct udevice *udev, ulong dst_addr, char *uri)
 {
-	char server_name[SERVER_NAME_SIZE];
 #if defined CONFIG_WGET_HTTPS
 	altcp_allocator_t tls_allocator;
 #endif
@@ -297,7 +296,6 @@ static int wget_loop(struct udevice *udev, ulong dst_addr, char *uri)
 	struct netif *netif;
 	struct wget_ctx ctx;
 	char *path;
-	u16 port;
 	bool is_https;
 
 	ctx.daddr = dst_addr;
@@ -307,7 +305,7 @@ static int wget_loop(struct udevice *udev, ulong dst_addr, char *uri)
 	ctx.prevsize = 0;
 	ctx.start_time = 0;
 
-	if (parse_url(uri, server_name, &port, &path, &is_https))
+	if (parse_url(uri, ctx.server_name, &ctx.port, &path, &is_https))
 		return CMD_RET_USAGE;
 
 	netif = net_lwip_new_netif(udev);
@@ -319,7 +317,7 @@ static int wget_loop(struct udevice *udev, ulong dst_addr, char *uri)
 	if (is_https) {
 		tls_allocator.alloc = &altcp_tls_alloc;
 		tls_allocator.arg =
-			altcp_tls_create_config_client(NULL, 0, server_name);
+			altcp_tls_create_config_client(NULL, 0, ctx.server_name);
 
 		if (!tls_allocator.arg) {
 			log_err("error: Cannot create a TLS connection\n");
-- 
2.43.0

