Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26CA5CD98CC
	for <u-boot@archiver.kernel.org>; Thu, 11 Jun 2026 23:37:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 95D0684717;
	Fri, 12 Jun 2026 01:36:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=baylibre.com header.i=@baylibre.com header.b="bFsaDLwr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 556298484C; Fri, 12 Jun 2026 01:36:56 +0200 (CEST)
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com
 [IPv6:2607:f8b0:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1A604839A8
 for <u-boot@lists.denx.de>; Fri, 12 Jun 2026 01:36:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-ot1-x336.google.com with SMTP id
 46e09a7af769-7e6b5dfde3cso281456a34.3
 for <u-boot@lists.denx.de>; Thu, 11 Jun 2026 16:36:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1781221013; x=1781825813; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Z/iJNaV7gVsduB53tm0KvaMGmmPVI7FCrwdP05cdoAE=;
 b=bFsaDLwrj19A/S293wT3Or2dKNRnjEk3f1ffoiJvGZpkzxOuqRLqB1ujyD2U1XMyR4
 YfZfwfd2XmmYck5rq9KdyLTZBj1fHsJrGGo7b4XGhBTRCq1AvXd5mxLAMEr7eG8J1FXM
 G6AmpjqxY2bA7MOOnTOD7qWzDwKhZ+32f/hogZXssEtzJ3ZwOTzFkA4luUU5+bXnP2wQ
 CEPIv6IAkA+xcxzE+UysvT4aqpxm5+rXodgGK/vNkGBpX2GTjBwvx8IgAqrIf0pYBO8P
 W3WELsKoq74gcL2+Nd2dSm7BRioKQ8LYK3xdXgkS6xjFOR+5Fyb4pOBtA669khl2lPoo
 Nbfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781221013; x=1781825813;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Z/iJNaV7gVsduB53tm0KvaMGmmPVI7FCrwdP05cdoAE=;
 b=LUzB4tmXeq+IlglHL241KvCs9NddFRGJSgc5bpAe5No3lXQXgPZgr6UhnLtd1Y7H/Z
 BnpAabSPJ+dsNIZpDhiPKTYyLi5XtjKLzFoSScTflj/B4K0X5mIfKvUceBRj2M/xqEV+
 Y0mfNr/i/rSNYPwIv82t0Z+bfZXBaOvlTaMsHRXA8UZVtmtH2sNIDt6ipLnEVfKrtr/B
 2ikhDWQPtTFR9Q6Gly10fweTUjL5UGDhCzR3LxdkvUDbM/XZsgZkVIfDrKPhkqlG+kfM
 qjgwEeFAEArrVQJElQwj7Q8+BjMz/+aaYU7u3ivrojp39bDZj7PRqgATg0m6Y+q0Jufj
 cmKQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ84fEcbs832ybX7V+smwV6j2eHrpffD8B54MG94oYLdPvIMbwwi5EOPTHqltv+oTNX7lYXP9rM=@lists.denx.de
X-Gm-Message-State: AOJu0YzmsWvsVQgU12SX1f+mlqJEjo9JTQfiNJLQF/e/hIOOjIyvWA+K
 pmzlvcmqCtP2VavHZCEhob/hFXzAKSl4S2Vb82ZALN20qOGRn1pyrjOhKKthoH/Rcjc=
X-Gm-Gg: Acq92OE63uQx+LFUESwSToDleQNFMeIGPzSlpsL7/c7wR63mESMPyzmPHTcaVyx2XBw
 5GGwHNCZTE1DRkgtrbp9Sr9mT/ML28TrgvPx+E0dZFx0OrS5mXPSDA8zNPmr+mGVD1CTSfBn2qK
 p0aHuQeQFOg0fbkn+HJY9ZkxDi8zJgZDPVveMOsOFKbz6m30h9LuiRPIK3RsE4Fx49Ldzp6w+FQ
 wgIneMPidcPP3pFez9WhL8l0JDaLwiEb5/Ynu0O7i2aCyAvrnDRDuxe2KFSSWFlANimTshFRH/O
 ncc0XELOJ/iw3rKe+2pIc+Ewv9E5rIAXVa51xonioCquVQ4kpKmSmA26LLiV8XY9KRzvooyANRj
 iM1uawLPPSjSnEeHBgpQLEJ3STvvZ9kHq46dAwe6clXiXubu272/6OHrArbd6ivUDZjvMjrG7HD
 w+0T2sK0Kdk6ugRLE7fMDQcHgPJMs=
X-Received: by 2002:a05:6830:4998:b0:7e7:76f:3ec0 with SMTP id
 46e09a7af769-7e7847720a2mr177124a34.15.1781221012792; 
 Thu, 11 Jun 2026 16:36:52 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:cba0:23d4:353:6048])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e78144822dsm660346a34.2.2026.06.11.16.36.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jun 2026 16:36:52 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Thu, 11 Jun 2026 18:36:08 -0500
Subject: [PATCH v3 1/3] net: lwip: wget: fix error handling in
 wget_do_request()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260611-net-lwip-add-stop-function-v3-1-8849948fd9c3@baylibre.com>
References: <20260611-net-lwip-add-stop-function-v3-0-8849948fd9c3@baylibre.com>
In-Reply-To: <20260611-net-lwip-add-stop-function-v3-0-8849948fd9c3@baylibre.com>
To: Jerome Forissier <jerome.forissier@arm.com>, 
 Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Julien Stephan <jstephan@baylibre.com>, u-boot@lists.denx.de, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=4626; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=/6dY2uApat21gerJohQW4PPqDnPCsnnnBesBeTdeO+M=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBqK0Z8F9H1gNrm5KUoN3YCrZaegnAt8YFrGaUYs
 WMiauzxvJuJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaitGfBYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/ACNoH/i3WUTRCSoNtq3XZszGGpjcUMG4HU0faDsDYFRI
 IFuifRKTWlNJQPv/ZBBjRppNlJQp6FSJ874dAhVCOwBLSvGiBUcMhL33jwUF/5wLbtQlSLU1AUf
 vz26vDnDX6K3g4/BDbWk8Qa9z+rvVsKd61DK+AdXtzY2j0FAEF/LoY0HGSUZLmd4A1fXtrVB3eq
 B3qVess7NpPnT+RRBtegji763nYXv+3eL8GBoOZnLJBFo8/k1tn0VGyfioBgCbdo4iLLqFTUnMg
 oQMKBJAEe/oNod4kgwwsMbnBadx8tutcqdsuAeekGOH0IpOy/w+gfnFpWwWGzqoFZmNrGom3cpl
 AcA4=
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
must always be called to prevent leaks. This was missed in the CACERT
section of the code where we returned on error without cleaning up.

Instead of adding more calls to net_lwip_remove_netif(), refactor the
code into two functions. The outer function handles managing the netif
lifecycle. The inner function no longer has to worry about cleaning up
before returning on error.

To keep things simple, the `path` local variable is removed during the
refactoring. Instead, ctx.path is used directly everywhere.

Fixes: 3c656c928bd7 ("net: lwip: add wget command")
Reviewed-by: Jerome Forissier <jerome.forissier@arm.com>
Acked-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
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

