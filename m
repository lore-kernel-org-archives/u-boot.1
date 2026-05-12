Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8287CD4F21
	for <u-boot@archiver.kernel.org>; Tue, 12 May 2026 21:49:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3C2A284374;
	Tue, 12 May 2026 23:48:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="MdEENsnR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8C833836AC; Tue, 12 May 2026 23:48:53 +0200 (CEST)
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com
 [IPv6:2607:f8b0:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EBCAB83CD3
 for <u-boot@lists.denx.de>; Tue, 12 May 2026 23:48:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-ot1-x332.google.com with SMTP id
 46e09a7af769-7dccb8644c4so3112229a34.0
 for <u-boot@lists.denx.de>; Tue, 12 May 2026 14:48:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1778622530; x=1779227330;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=U4VDD3LDKvJ+svKQpyDSXI6c9W0dgAAgIVjh4m8Hok0=;
 b=MdEENsnRO7VoHDgUAtS/aaMc/Tz1NnLc43ACwSBeq7oj9AW2GTX21T4b/3sK5depuL
 Z4Jx+sVGH9UkGJ4NwuEWJ6cEpL3+D1MhVMnCW/DyREbJ+dqNzMJW7+cvXqCVLhSLEDzL
 5ClQMa8IOwVcoXmvH/dajg8E4vXRCf6sGZEj0AiBAnCC+wIaodfqM1LWz77PDSyXT/w4
 PuCRRQnk+JWTHT298uOWIHavRfMss3BLviAQXVZ1gOyPU2CC8HLQndePxVhKEBzZTr8M
 Be62H/y+l9RVD+um2UwkENopgw6Qay97NWBQhGYL0TKr8SB1as7lmH/e7/VD6c8KNNNx
 Il5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778622530; x=1779227330;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=U4VDD3LDKvJ+svKQpyDSXI6c9W0dgAAgIVjh4m8Hok0=;
 b=I43YBhyZqBRDriV2ZIPhORYJ/jFdywt0cLShj382397dM8z5sak1ADK9s+TYZCFh26
 qpbqQbHPuFaAc3bO4a7Y+mj9o92R5KPLR4slppht1Fr5hx23RNYt6a/NPZftEFxcwuzX
 nMtdCkRRyNTfeS1yqRYMZ032iH6kdFk8ACXYJdopYaB2Lf5frbw70gHR9MvzI2lXSYg2
 H7xDk69INoBn1B9yCVp+XnjMu1M8GWDhwPwx7jZFSDHWyH/OPTPpN7QNI0WAT72wxoGg
 0rHHY/tJisOzd0AmuGnkzzXJnGSYTIV8zSEyC37L3UGRnhq5Dqnh6xP8baOzXf+RKlY4
 u23Q==
X-Forwarded-Encrypted: i=1;
 AFNElJ+PReXHzkpYoJHvoiRV72P164eS/VhweyjNLiAkGCTcd7OapdcODAuM34FhmvMx7DnBoRYBfGU=@lists.denx.de
X-Gm-Message-State: AOJu0Yy91SxA7J85pzxWXhtnrfR+SslYNMnGeoZc2u0f8onwVbDwSYD1
 jKGitFu+vdFTTM6DzaZg991remv5JRHZgSoYlxjsdoyWU7FHweN+VjhUIUhlwoqkoXE=
X-Gm-Gg: Acq92OGJ/CWwPwQQg+hSCFPhwqNnkeDm3m8eYlPkJ4uzvsqAQ9hDWIqniDIka6pNXKG
 TF+4tDhzOulBPILGKNH74mAum+GL7XVR2iDfODRuALvy5F0OmbJuaBPWqQqWNaaWCaHK1KeRxfl
 3xgY6DUgQ8ruHjYUQ+eTgjvfT1FtBk1dTbNB2jOhuiu/90o8UnoTxrTR/qCUIVfQ4GP37sCzqYG
 JfFApL9WF4wRiMmQs974HY9KdjOUipRxE+J6vuELUYLsO8w8ngSFqWINxhPnHuz+8rUCNXGfLc0
 6uT8/7Dl5hSRygD3QUBJzReTovKuf4zccrITqUKDF9OBZBTke2NiMB02g769wNtDBlEFQhTkBdP
 78UovPd1LVSbsCyseiccMhRKjt2+jSvd+AY/By9Fh0xppDUmodLiYuLrZq7+tpcvsK4QC4jWDbL
 +35dGwqseSIWlm9pbiGpMWEUsk5Ys9
X-Received: by 2002:a05:6830:81cd:b0:7d7:e142:2ead with SMTP id
 46e09a7af769-7e3dc91ca26mr14526a34.20.1778622529666; 
 Tue, 12 May 2026 14:48:49 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:baa4:f7fb:528a:2457])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e367c04e66sm9671795a34.8.2026.05.12.14.48.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 May 2026 14:48:49 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Tue, 12 May 2026 16:48:14 -0500
Subject: [PATCH v2 2/3] net: lwip: wget: return errno codes from
 wget_do_request()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260512-net-lwip-add-stop-function-v2-2-85146da317dd@baylibre.com>
References: <20260512-net-lwip-add-stop-function-v2-0-85146da317dd@baylibre.com>
In-Reply-To: <20260512-net-lwip-add-stop-function-v2-0-85146da317dd@baylibre.com>
To: Jerome Forissier <jerome.forissier@arm.com>, 
 Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Julien Stephan <jstephan@baylibre.com>, u-boot@lists.denx.de, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=3782; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=uFVZrTfIRkVcARky4G5lK6zzGX2Z1O5UKepHKXsOjco=; 
 b=kA0DAAoBwswgAf8Bj8AByyZiAGoDoC+jQBwOVhIqkEL25dpLt+v3pDTW6Pc6cyi9u52MjIwKQ
 YkBSgQAAQoANBYhBOwY2Z5iDoPWnNhomMLMIAH/AY/ABQJqA6AvFhxkbGVjaG5lckBiYXlsaWJy
 ZS5jb20ACgkQwswgAf8Bj8A6Hgf+Pt88zN+IvnjAwwSfI6ihqd7cYCwqwXzPlvpqaYjrrFqqOYI
 z3qfiLqqPOEgoBT9rwpMfoF84UV2AgMJRBHL9kWBr95Yrc2nYCbC+5AWFS1QkjpwjUawgphHd4A
 h3ImF6EGiSkaMLDlCTvopEryAmMQ2e9FovXd0QewQPmIl2H1LgV0YPCUQLZMHMcS+6bganlTmFP
 quYIcO6k62t4DzMHzxKcik7dwTcBq5ehJxou9W6nR4wpQ/Ngda16DIotKxhNf4TMvqkL0NUG2V3
 yF5oQf3HT7G/L/DUUSnTFJpxY3HgLSqbqnZ8bNUaFpLOC91+o/RN9oWooz8rvn9K/pMTQw==
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

