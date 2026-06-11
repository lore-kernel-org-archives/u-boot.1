Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24E4ECD98CC
	for <u-boot@archiver.kernel.org>; Thu, 11 Jun 2026 23:37:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D4154838BB;
	Fri, 12 Jun 2026 01:36:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=baylibre.com header.i=@baylibre.com header.b="iHTUPihD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 529078485F; Fri, 12 Jun 2026 01:36:57 +0200 (CEST)
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com
 [IPv6:2607:f8b0:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ED11F84717
 for <u-boot@lists.denx.de>; Fri, 12 Jun 2026 01:36:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-ot1-x32b.google.com with SMTP id
 46e09a7af769-7e6cfdc92bfso172216a34.2
 for <u-boot@lists.denx.de>; Thu, 11 Jun 2026 16:36:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1781221014; x=1781825814; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=jqdAffyfDZdgSpCAQAQCzhdVzCTDq6xVSUVhY5bs7i0=;
 b=iHTUPihDGk5hBEGQfiA574Oa1UZzb0YnrnDb0816qFbdiPPhbR6ttr3aCOfVTP0pe6
 3sGDQZ+L78mjbibiZ1p+Noqk7xY5M8TPNhmC12tmQkqCn8OcPRH0OrvF5TCK44OUoGLE
 z3SLVaRnCRy8qrIqQSO7db2RIXVqIFp6BIwf+Ma+mzsygmrc8lU/gX1syPDS2No4gGXF
 Vp8t2UTgEQ+d3qEg6IJbXdjcuGchO4UXPE138x13jhhsbnNt8sstAnIA+G2FdD0RYrkm
 P89YC7UCDxyTonalpmu+o10BJUCUpeEbEcjfLNbnb2qwbEmXi0v7BrD1IiP7BMaIl9CR
 UDtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781221014; x=1781825814;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=jqdAffyfDZdgSpCAQAQCzhdVzCTDq6xVSUVhY5bs7i0=;
 b=FULczslyVPViE0FZEqTw1wUpxRvfAYGC61Og4/ZLbhwZGO1xwa+iIujGDXkDoJdYj1
 fyHaiLeyvE079msJvLfySv0ijg3JOogNIvjstwx5iqNo7ea+ci0M1ECoAlvGiLuGzvlJ
 59bIt5hwRpW7P9bF9xcwSWi+HeYCCo3XDfuP1I5s3tT3/9FM/0EuapKWJOLp1b++vWK3
 1RBQ50R+4cHn4L2x1uEfv9izgW/y2o/YNHkl0SY/wi1ztEz3oQCO75+nye+QSf7rT3Bc
 IIlAssxnuiT/dVoR8r2giqZ5jy396bhDwkvbqAP4AcjOvVF0mwxp5Zr8uXvYcCWR+WGH
 uMmA==
X-Forwarded-Encrypted: i=1;
 AFNElJ/wVaA3tq3XscZ2uuOh0YO0t6brRlX3pFsHlApE22Q9+L7TMqFtnKAy4AsEdNsi67+K2WYF3v8=@lists.denx.de
X-Gm-Message-State: AOJu0YwwL9UJ7t9WEU6faZMW6R6hqpjCnwzNNVkWTGYXrIsF2yc+TbCO
 zvBQntjDNkY7Z9CIC0ahbyN+wFd0EpbrD1ccfAz90z8/JgyafSOfr1Hy1CbdU8x0Mzw=
X-Gm-Gg: Acq92OF4tDVk9NzPaat5Kr+fjLDIlCqccQdSP6Z++NKgN4p60z7IW2SWCWBj40wsNWf
 M7wHg11lEEEedSrjpvjGw+qBzeMrUHhSB/nO9s7uCDL4xwZQ0Do86GmowDn5rsDOgIVNPWvGE5q
 ryyAveHit8t4whmV6JIL2yS779w0E3LvCp0zoLLqSp1zdHGWG8xod/xWT5OGJiHHHvcKDQvli7l
 e7JQby5kt3oX0ByZkXpAtYdSFLWyxojQS5C6nf4S7D01K+WYbdzq+w9dCcxShgzJX/XfEniSSyz
 9SLJppolXnF/pLFAjGyxQaJtQN7SEUbHGkSSsRfEwX66BDarOmpxTJYjG+BL2QO0S4Oz/W3kvuj
 efe5irOP594533ojjNvrGr2aJJI+3in57br/4uPiOdXUbFg+gbrWiIUKg5JeX5uCDK0ifbnWn83
 A2QHClhULjwlGCGVZjsNX8SLt+9HwubsOXsPQPkQ==
X-Received: by 2002:a05:6830:43ac:b0:7e6:cec2:a4a5 with SMTP id
 46e09a7af769-7e7847c509bmr164713a34.20.1781221013662; 
 Thu, 11 Jun 2026 16:36:53 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:cba0:23d4:353:6048])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e78144822dsm660346a34.2.2026.06.11.16.36.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jun 2026 16:36:53 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Thu, 11 Jun 2026 18:36:09 -0500
Subject: [PATCH v3 2/3] net: lwip: wget: return errno codes from
 wget_do_request()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260611-net-lwip-add-stop-function-v3-2-8849948fd9c3@baylibre.com>
References: <20260611-net-lwip-add-stop-function-v3-0-8849948fd9c3@baylibre.com>
In-Reply-To: <20260611-net-lwip-add-stop-function-v3-0-8849948fd9c3@baylibre.com>
To: Jerome Forissier <jerome.forissier@arm.com>, 
 Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Julien Stephan <jstephan@baylibre.com>, u-boot@lists.denx.de, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=3840; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=Viwf1QusuY668yKlJ2zdj7i2W5VcxqBh3j6JK9KDVbE=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBqK0aD0hqEKZfbCSfuwPvO6fVgsPEjuYdKFeSfm
 IgZDLoeD/yJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaitGgxYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AdXkH/2aPpwaG2lEu1qVyvEJKTs/3I5ykDVOUys78Bj8
 GMpB0H1X3xOO9K/UZ2ABAXHMsRwrj7P7GUF27n9Ddugz9HGtwH6MUD3DvYGYaUUU5GClDUIGXLp
 BlJ4isIXMo1PunaO3Ov/gjhvjak5zFS4mIBKXZufbsxImtt94CabiOOAkXB2BbjdYgtEIcWl9ez
 Lq2FzW6Kh8Z542Oj2smD6lT4D7z+szdXT/vhka7zNX76Lf3OaWweBN1L1Jl8rUOejuyyI/q6kVJ
 4d8ZAuVYLRGK899M6g18HuAkAJPRWw0B+Ss/rffeM3Wn295th4jt6H+MJxXzANWHPxZRBxAqy38
 uAcQ=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
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

Change the return values of the lwip implementation of wget_do_request()
to be errno codes instead of command return codes.

wget_do_request() is not a command, so it does not make sense to return
command return codes from it. Also, the legacy network implementation of
wget_do_request() already returns errno codes so it is logical for the
lwip implementation to do the same.

This fixes a bug in try_load_from_uri_path() in efi_manager.c where it
checks that the return value of wget_do_request() is < 0. Before this
change, CMD_RET_FAILURE would not be considered an error since it has a
value of 1.

The value of ENODEV is used in places where there could actually be a
number of different causes of failure and it isn't possible to
discriminate (i.e. failing function returns NULL for all errors). Since
all callers of wget_do_request() don't propagate the error code, it
doesn't matter so much that this is not ideal, at least at this point in
time.

Fixes: 3c656c928bd7 ("net: lwip: add wget command")
Reviewed-by: Jerome Forissier <jerome.forissier@arm.com>
Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 net/lwip/wget.c | 28 +++++++++++++++++-----------
 1 file changed, 17 insertions(+), 11 deletions(-)

diff --git a/net/lwip/wget.c b/net/lwip/wget.c
index f89a6580b41..3a0b0dca145 100644
--- a/net/lwip/wget.c
+++ b/net/lwip/wget.c
@@ -300,10 +300,14 @@ static int wget_handle_request(struct wget_ctx *ctx, bool is_https,
 #endif
 	httpc_connection_t conn;
 	httpc_state_t *state;
+	int ret;
 
 	/* if URL with hostname init dns */
-	if (!ipaddr_aton(ctx->server_name, NULL) && net_lwip_dns_init())
-		return CMD_RET_FAILURE;
+	if (!ipaddr_aton(ctx->server_name, NULL)) {
+		ret = net_lwip_dns_init();
+		if (ret)
+			return ret;
+	}
 
 	memset(&conn, 0, sizeof(conn));
 #if CONFIG_IS_ENABLED(WGET_HTTPS)
@@ -325,7 +329,7 @@ static int wget_handle_request(struct wget_ctx *ctx, bool is_https,
 					printf("Error: cacert authentication "
 					       "mode is 'required' but no CA "
 					       "certificates given\n");
-				return CMD_RET_FAILURE;
+				return -EINVAL;
 		       }
 		} else if (cacert_auth_mode == AUTH_NONE) {
 			ca = NULL;
@@ -350,7 +354,7 @@ static int wget_handle_request(struct wget_ctx *ctx, bool is_https,
 
 		if (!tls_allocator.arg) {
 			log_err("error: Cannot create a TLS connection\n");
-			return -1;
+			return -ENODEV;
 		}
 
 		conn.altcp_allocator = &tls_allocator;
@@ -361,7 +365,7 @@ static int wget_handle_request(struct wget_ctx *ctx, bool is_https,
 	conn.headers_done_fn = httpc_headers_done_cb;
 	if (httpc_get_file_dns(ctx->server_name, ctx->port, ctx->path, &conn,
 			       httpc_recv_cb, ctx, &state)) {
-		return CMD_RET_FAILURE;
+		return -ENODEV;
 	}
 
 	errno = 0;
@@ -378,7 +382,7 @@ static int wget_handle_request(struct wget_ctx *ctx, bool is_https,
 	if (errno == EPERM && !wget_info->silent)
 		printf("Certificate verification failed\n");
 
-	return -1;
+	return -errno ?: -EIO;
 }
 
 int wget_do_request(ulong dst_addr, char *uri)
@@ -398,11 +402,13 @@ int wget_do_request(ulong dst_addr, char *uri)
 	ctx.content_len = 0;
 	ctx.hash_count = 0;
 
-	if (parse_url(uri, ctx.server_name, &ctx.port, &ctx.path, &is_https))
-		return CMD_RET_USAGE;
+	ret = parse_url(uri, ctx.server_name, &ctx.port, &ctx.path, &is_https);
+	if (ret)
+		return ret;
 
-	if (net_lwip_eth_start() < 0)
-		return CMD_RET_FAILURE;
+	ret = net_lwip_eth_start();
+	if (ret)
+		return ret;
 
 	if (!wget_info)
 		wget_info = &default_wget_info;
@@ -411,7 +417,7 @@ int wget_do_request(ulong dst_addr, char *uri)
 
 	netif = net_lwip_new_netif(udev);
 	if (!netif)
-		return -1;
+		return -ENODEV;
 
 	ret = wget_handle_request(&ctx, is_https, udev, netif);
 

-- 
2.43.0

