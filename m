Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88E57CD343F
	for <u-boot@archiver.kernel.org>; Tue, 12 May 2026 21:49:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F2AA983CD3;
	Tue, 12 May 2026 23:48:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="DUjWXVjS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5F22784198; Tue, 12 May 2026 23:48:52 +0200 (CEST)
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com
 [IPv6:2607:f8b0:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2E2A08341A
 for <u-boot@lists.denx.de>; Tue, 12 May 2026 23:48:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-ot1-x32d.google.com with SMTP id
 46e09a7af769-7dcdd1b492eso5449902a34.1
 for <u-boot@lists.denx.de>; Tue, 12 May 2026 14:48:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1778622529; x=1779227329;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=l5iECCM5/RqRVtanpFtzKINnPczpEGeDJo3/S5Zuy9M=;
 b=DUjWXVjSB6MfZFfUCNxT6uA4m7id8ykTNu+CftZ2yhZ+aLZmv5BXUpd8clEtMPuJxL
 6+QcOBjLkGZzFMFbTxVrj1pXleiKRSaY4mEZDgqCsjLgz1wiJvSw1Sf213C50tAzv7qN
 Wp/KKoRAuT1G+UBhcyw0jYH9QkRcl45/ECkdXa/HMZcJ0ncI1BapM0xH5El4TAk+TaLf
 0Kewz7Bho8UMxjx+Ki/H0YMvnk3EwSbsp2CYz4bqafeoCPJTpsb7OaVQEahy/9SlviDQ
 tkhT4x4hFVx6kSEfBybnu0Ev3Axh76d+hUQLfUHPjA/1DraItdR8t0DUWURE3Pxrl11k
 ANdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778622529; x=1779227329;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=l5iECCM5/RqRVtanpFtzKINnPczpEGeDJo3/S5Zuy9M=;
 b=oo+na11spzz+dKXmNdDN8FLspB8XBSmOUs5zuBCUOqNAp8zTAG467uR15AtwShKXyk
 wygmpN8Ivo/hF6mZXOp/4JmCh2D3fcePm/ijyEzhG/XZI2dTAjFags76YMehYyI3gCaO
 xboc4CvQ8sfRrMta9kJl0oSrWP96V8hFc8RLsZSwsNbJJqVr4qCrtH3QLLsFUYtUBipr
 sbjtWQQNWGUAAPRIeuQ4c3mBMgo7uV4faCAugXxa/p+6Jg7DonqYk/MtWOhzTlNmjt73
 pQ1iUyXGO4GSctqOvFyYfgWavk4r8dfh0nHVhpCNaPzC9xSCRS2yVyfSm2aCRz+vlO9e
 YuDA==
X-Forwarded-Encrypted: i=1;
 AFNElJ/0ygRVNVHJ4MTQEqb1z0CIx+m8aPLu+RAH2XntOJDp8FXSBEUU4XYXbAwgkkuFgHWpv+tvxZA=@lists.denx.de
X-Gm-Message-State: AOJu0YwAK+XjmTIuyM7KKYu4vF1BgkTk+GrH5o8QjOTWDeEqvnLd+skl
 BKF2CcK+kGK3o8b1gATYfZGyhCci5oqLSCOjZUS+tRShxenmNXzYqWY4F0/6VQ8q8VI=
X-Gm-Gg: Acq92OGHkKOS3SPUYwFQKH7IvE1HOP5+BsfcZOVit/0YBFUvielG/K5jY5yBKY2jbWV
 5fI9ABMwnXBJ3qCBj0g5ZTMPXWnSMuM7fJqmH4yzPNjL2eIn8VFUdHpUgkwRkgcefjEDBHrdZZq
 Z9KDAXX496amog30GKqverkL9NudiRmLrI8gkv4O1LZoclr/7tSFb6qnKgNuQxoWVWoM3AV9toZ
 ARkenG3vc3rmDAYebcQbqt2JcvK0J+W2Kx7lT/XM0dcx4qnIpIn097s+gJYKcAvf4QNKAZwZ64T
 pvkuPOZICqgLmwVpvDYL45hVHu+r+/RwPUJEFqT4ROdfTXf58wcOVRd/M+d276XbimCzzq0cxtd
 5c+99fdISxUoPEIM44gghkKI8aULkmMiPx04uqbS/QSHS7XjVJeV+lW2GTeL5V6ZtFb3Srm9ZjN
 QEoo8hbmDFizx0BIw0HJoWy4foz8QEmWdOO1rAfwg=
X-Received: by 2002:a9d:73d4:0:b0:7dc:c501:afbd with SMTP id
 46e09a7af769-7e3bd2cd7b9mr2140854a34.10.1778622528885; 
 Tue, 12 May 2026 14:48:48 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:baa4:f7fb:528a:2457])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e367c04e66sm9671795a34.8.2026.05.12.14.48.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 May 2026 14:48:47 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Tue, 12 May 2026 16:48:13 -0500
Subject: [PATCH v2 1/3] net: lwip: wget: fix error handling in
 wget_do_request()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260512-net-lwip-add-stop-function-v2-1-85146da317dd@baylibre.com>
References: <20260512-net-lwip-add-stop-function-v2-0-85146da317dd@baylibre.com>
In-Reply-To: <20260512-net-lwip-add-stop-function-v2-0-85146da317dd@baylibre.com>
To: Jerome Forissier <jerome.forissier@arm.com>, 
 Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Julien Stephan <jstephan@baylibre.com>, u-boot@lists.denx.de, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=4501; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=1NiWLdaV6hC/HJjYV3nVbf6TStIh6DMv7WBWfOAXg3U=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBqA6AoNvPjMgAcKdxoQw49Kj0IGgb3aalYMXOOF
 eK+R4qQ6h+JAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCagOgKBYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AkuEH/0eZSPfSSBw6vC8PipN9/ZujPuM68JLPZ2G+Usi
 QKkiBpb+40pehoFtMe4aeBw4/2S9IGBwHXy94fa25ms23LY24EpX4wPIEL2DwaubpRgg5cLnR8H
 j1OBV49ecNl6aNmsMI1reegIChfOSWE3dfmLK1u9iNLQCms84GvbeA6KPXo+nMrkrxbVGUP95NM
 MFxSzdIrZArMM3z0gBFK25Et0eiiCspYUnKP62IaeISko0ufyVN7Ikh+A8wf118DKhK9R7k5K58
 56NwXhReXWK1i908XSUmY8opgtiGzR6ZvNstOkInRYi04n3hASW2jb5kYErLVeHwJLyM+CBFQr6
 irg4=
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

Split wget_do_request() into two functions to make error handling less
error-prone.

After a successful call to net_lwip_new_netif(), net_lwip_remove_netif()
must always be called to leaks. This was missed in the HTTPS section of
the code where we returned on error without cleaning up.

Instead of adding more calls to net_lwip_remove_netif(), refactor the
code into two functions. The outer function handles managing the netif
lifecycle. The inner function no longer has to worry about cleaning up
before returning on error.

To keep things simple, the `path` local variable is removed during the
refactoring. Instead, ctx.path is used directly everywhere.

Fixes: 3c656c928bd7 ("net: lwip: add wget command")
Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 net/lwip/wget.c | 88 ++++++++++++++++++++++++++++++---------------------------
 1 file changed, 47 insertions(+), 41 deletions(-)

diff --git a/net/lwip/wget.c b/net/lwip/wget.c
index 502c0faebb2..f89a6580b41 100644
--- a/net/lwip/wget.c
+++ b/net/lwip/wget.c
@@ -292,45 +292,17 @@ static err_t httpc_headers_done_cb(httpc_state_t *connection, void *arg, struct
 #if CONFIG_IS_ENABLED(WGET_CACERT)
 #endif
 
-int wget_do_request(ulong dst_addr, char *uri)
+static int wget_handle_request(struct wget_ctx *ctx, bool is_https,
+			       struct udevice *udev, struct netif *netif)
 {
 #if CONFIG_IS_ENABLED(WGET_HTTPS)
 	altcp_allocator_t tls_allocator;
 #endif
 	httpc_connection_t conn;
 	httpc_state_t *state;
-	struct udevice *udev;
-	struct netif *netif;
-	struct wget_ctx ctx;
-	char *path;
-	bool is_https;
-
-	ctx.daddr = dst_addr;
-	ctx.saved_daddr = dst_addr;
-	ctx.done = NOT_DONE;
-	ctx.size = 0;
-	ctx.prevsize = 0;
-	ctx.start_time = 0;
-	ctx.content_len = 0;
-	ctx.hash_count = 0;
-
-	if (parse_url(uri, ctx.server_name, &ctx.port, &path, &is_https))
-		return CMD_RET_USAGE;
-
-	if (net_lwip_eth_start() < 0)
-		return CMD_RET_FAILURE;
-
-	if (!wget_info)
-		wget_info = &default_wget_info;
-
-	udev = eth_get_dev();
-
-	netif = net_lwip_new_netif(udev);
-	if (!netif)
-		return -1;
 
 	/* if URL with hostname init dns */
-	if (!ipaddr_aton(ctx.server_name, NULL) && net_lwip_dns_init())
+	if (!ipaddr_aton(ctx->server_name, NULL) && net_lwip_dns_init())
 		return CMD_RET_FAILURE;
 
 	memset(&conn, 0, sizeof(conn));
@@ -374,11 +346,10 @@ int wget_do_request(ulong dst_addr, char *uri)
 		tls_allocator.alloc = &altcp_tls_alloc;
 		tls_allocator.arg =
 			altcp_tls_create_config_client(ca, ca_sz,
-						       ctx.server_name);
+						       ctx->server_name);
 
 		if (!tls_allocator.arg) {
 			log_err("error: Cannot create a TLS connection\n");
-			net_lwip_remove_netif(netif);
 			return -1;
 		}
 
@@ -388,24 +359,20 @@ int wget_do_request(ulong dst_addr, char *uri)
 
 	conn.result_fn = httpc_result_cb;
 	conn.headers_done_fn = httpc_headers_done_cb;
-	ctx.path = path;
-	if (httpc_get_file_dns(ctx.server_name, ctx.port, path, &conn, httpc_recv_cb,
-			       &ctx, &state)) {
-		net_lwip_remove_netif(netif);
+	if (httpc_get_file_dns(ctx->server_name, ctx->port, ctx->path, &conn,
+			       httpc_recv_cb, ctx, &state)) {
 		return CMD_RET_FAILURE;
 	}
 
 	errno = 0;
 
-	while (!ctx.done) {
+	while (!ctx->done) {
 		net_lwip_rx(udev, netif);
 		if (ctrlc())
 			break;
 	}
 
-	net_lwip_remove_netif(netif);
-
-	if (ctx.done == SUCCESS)
+	if (ctx->done == SUCCESS)
 		return 0;
 
 	if (errno == EPERM && !wget_info->silent)
@@ -414,6 +381,45 @@ int wget_do_request(ulong dst_addr, char *uri)
 	return -1;
 }
 
+int wget_do_request(ulong dst_addr, char *uri)
+{
+	struct udevice *udev;
+	struct wget_ctx ctx;
+	struct netif *netif;
+	bool is_https;
+	int ret;
+
+	ctx.daddr = dst_addr;
+	ctx.saved_daddr = dst_addr;
+	ctx.done = NOT_DONE;
+	ctx.size = 0;
+	ctx.prevsize = 0;
+	ctx.start_time = 0;
+	ctx.content_len = 0;
+	ctx.hash_count = 0;
+
+	if (parse_url(uri, ctx.server_name, &ctx.port, &ctx.path, &is_https))
+		return CMD_RET_USAGE;
+
+	if (net_lwip_eth_start() < 0)
+		return CMD_RET_FAILURE;
+
+	if (!wget_info)
+		wget_info = &default_wget_info;
+
+	udev = eth_get_dev();
+
+	netif = net_lwip_new_netif(udev);
+	if (!netif)
+		return -1;
+
+	ret = wget_handle_request(&ctx, is_https, udev, netif);
+
+	net_lwip_remove_netif(netif);
+
+	return ret;
+}
+
 /**
  * wget_validate_uri() - validate the uri for wget
  *

-- 
2.43.0

