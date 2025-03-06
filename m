Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C15ECC282D1
	for <u-boot@archiver.kernel.org>; Thu,  6 Mar 2025 14:26:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C528E81545;
	Thu,  6 Mar 2025 15:26:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Oul8sdQ9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C4DC681417; Thu,  6 Mar 2025 15:26:06 +0100 (CET)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 47A9481253
 for <u-boot@lists.denx.de>; Thu,  6 Mar 2025 15:26:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-43bcb1a9890so13345705e9.0
 for <u-boot@lists.denx.de>; Thu, 06 Mar 2025 06:26:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741271159; x=1741875959; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cPEAqZz4+ggwqAu6Rb0BkaEQPcAjk26CnDMWYXLY6Cw=;
 b=Oul8sdQ9pJf8wvq82BxVtw1idgR36WPlcvZQQp7XxbwIVXO80gdsqyUmNlRSxt+P4v
 iYWcFV12/E/YL/PlxcaQ6KNFE5MK1mpTnS1aRonWs+oZiUJ79EpPkG9SUZ65407WE07O
 nqKohlK1AgPgM3112dNNzgn7h+jqkxjSEEtf2dDAAFsVYxtEY+9T0XRnzVVu0WTLTtB5
 M9fx6GD5iwrFk1U0Mz4s9rtZ6Q3t5SdjXV5tT5L8iGg0Ns40IZVDF4ysa2pE6fobWV8Q
 iVT/YizDkmW9+uGenrfVSYltYcrMKwonHssYVYM71ERbn+xyz2iBrjZjNoBgDheaQs+j
 Kecg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741271159; x=1741875959;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cPEAqZz4+ggwqAu6Rb0BkaEQPcAjk26CnDMWYXLY6Cw=;
 b=jI2soNEIu1OxdBGvEeaiQmJ7D8PVC/uSSyLf82p3fqu50ZF7MjgB06ljBc2X7cyoPo
 sIVB971/awjW0d3lzndNUzxQXgiVL/oEK/l7kqTrEQVj3Jr6Lqm2qMoUvJ3g1ZGbthxR
 j5VzBZZajFc30qsv2ZQxGpsywq4algl8MWKksemyA9hT2qv5yIIyaZ7hHjLHFKAPAOzy
 kHU9f3nqUIr6ByZ9wSQEPyz0FhNwk7nnio5IFhx+cGCiJQ7dhZB1qh/Re9OoGxX+iPDZ
 vRcuWlCsaT8xJs+C6D7FzuzpbepAHqV/YuYVe1CrBWgZbrC6f2NY+VhTcZ0B4vcQSuWi
 CkXg==
X-Gm-Message-State: AOJu0YxxWC/IKVdTS5nNzJwhGam6svNa/Av6TJYrRehAc6ODemZ/53eq
 oyUmnLFlNI1YhqVvu+TgOQ4Zt9054l7F2aXs1MFH2xendpQC3sZTRLdU4axD5nuPoPhd+5T7yf8
 x
X-Gm-Gg: ASbGnctaGv8j6PKnHrySZKZmMbyulCRBYRF/8LvRbFW9CKa7xX/ImH3hVqiuSEhihKE
 NesQMuiX+mt+7KPOsBXOZV4KO89fm6bzMc1jBV7izbOO072BEuFfzyt0uIjrlGdb/VRxzPIwVcQ
 eMV1qlAfaJ41ee+8LiXVwOyEw42v0af+ZZUhZ8x9c0p3oWHmM/PfiTYU8Rjy9sXpc+n5Zm3tMZ7
 0YD1mF158Ydua0yD/XWoEcqOv3Eq0lEdORhAPIJyM6TiU8b6dPxZUf9ZSUYfIxi4KRceHxlOV51
 W05ZT5wm2k4+1MMcFEfgz3oaJ0moCSdQvPUXVnRekAXAcoptz8uytg==
X-Google-Smtp-Source: AGHT+IE5LZjmBTCJKLD8lsNelEzc8/FHD764JLLOERe+uL5YyCHsc41N9Oc8D6FM5dItJohRAh1vWg==
X-Received: by 2002:a5d:5f8c:0:b0:391:3156:6be with SMTP id
 ffacd0b85a97d-39131560a4emr53120f8f.7.1741271159408; 
 Thu, 06 Mar 2025 06:25:59 -0800 (PST)
Received: from builder.. ([2a01:e0a:3cb:7bb0:af71:dfb2:66ef:80c3])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3912bfdfad7sm2181543f8f.26.2025.03.06.06.25.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Mar 2025 06:25:59 -0800 (PST)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Tom Rini <trini@konsulko.com>, Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Adriano Cordova <adrianox@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>
Subject: [PATCH 2/3] net: lwip: save struct netif in struct udevice
Date: Thu,  6 Mar 2025 15:25:20 +0100
Message-ID: <20250306142525.3079189-3-jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250306142525.3079189-1-jerome.forissier@linaro.org>
References: <20250306142525.3079189-1-jerome.forissier@linaro.org>
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

Save the struct netif pointer in the corresponding struct udevice when
the netif is created. This avoids needlessly re-creating devices each
time the lwIP stack is entered.

Replace functions net_lwip_new_netif() and net_lwip_new_netif_noip()
with net_lwip_netif() and net_lwip_netif_noip() respectively since they
return a new structure only the first time.

Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
---
 include/net-lwip.h  |  4 ++--
 net/lwip/dhcp.c     |  7 ++-----
 net/lwip/dns.c      |  5 +----
 net/lwip/net-lwip.c | 19 +++++++++++--------
 net/lwip/ping.c     |  8 ++------
 net/lwip/tftp.c     |  5 +----
 net/lwip/wget.c     |  9 ++-------
 7 files changed, 21 insertions(+), 36 deletions(-)

diff --git a/include/net-lwip.h b/include/net-lwip.h
index 64e5c720560..58ff2bb2d43 100644
--- a/include/net-lwip.h
+++ b/include/net-lwip.h
@@ -11,8 +11,8 @@ enum proto_t {
 };
 
 void net_lwip_set_current(void);
-struct netif *net_lwip_new_netif(struct udevice *udev);
-struct netif *net_lwip_new_netif_noip(struct udevice *udev);
+struct netif *net_lwip_netif(struct udevice *udev);
+struct netif *net_lwip_netif_noip(struct udevice *udev);
 void net_lwip_remove_netif(struct netif *netif);
 struct netif *net_lwip_get_netif(void);
 int net_lwip_rx(struct udevice *udev, struct netif *netif);
diff --git a/net/lwip/dhcp.c b/net/lwip/dhcp.c
index 3b7e4700c6e..4c621e52337 100644
--- a/net/lwip/dhcp.c
+++ b/net/lwip/dhcp.c
@@ -43,7 +43,7 @@ static int dhcp_loop(struct udevice *udev)
 		return CMD_RET_FAILURE;
 	}
 
-	netif = net_lwip_new_netif_noip(udev);
+	netif = net_lwip_netif_noip(udev);
 	if (!netif)
 		return CMD_RET_FAILURE;
 
@@ -70,10 +70,8 @@ static int dhcp_loop(struct udevice *udev)
 
 	sys_untimeout(call_lwip_dhcp_fine_tmr, NULL);
 
-	if (!bound) {
-		net_lwip_remove_netif(netif);
+	if (!bound)
 		return CMD_RET_FAILURE;
-	}
 
 	dhcp = netif_dhcp_data(netif);
 
@@ -106,7 +104,6 @@ static int dhcp_loop(struct udevice *udev)
 	printf("DHCP client bound to address %pI4 (%lu ms)\n",
 	       &dhcp->offered_ip_addr, get_timer(start));
 
-	net_lwip_remove_netif(netif);
 	return CMD_RET_SUCCESS;
 }
 
diff --git a/net/lwip/dns.c b/net/lwip/dns.c
index 149bdb784dc..65474055cff 100644
--- a/net/lwip/dns.c
+++ b/net/lwip/dns.c
@@ -54,7 +54,7 @@ static int dns_loop(struct udevice *udev, const char *name, const char *var)
 
 	dns_cb_arg.var = var;
 
-	netif = net_lwip_new_netif(udev);
+	netif = net_lwip_netif(udev);
 	if (!netif)
 		return CMD_RET_FAILURE;
 
@@ -74,7 +74,6 @@ static int dns_loop(struct udevice *udev, const char *name, const char *var)
 
 	if (!has_server) {
 		log_err("No valid name server (dnsip/dnsip2)\n");
-		net_lwip_remove_netif(netif);
 		return CMD_RET_FAILURE;
 	}
 
@@ -100,8 +99,6 @@ static int dns_loop(struct udevice *udev, const char *name, const char *var)
 		sys_untimeout(do_dns_tmr, NULL);
 	}
 
-	net_lwip_remove_netif(netif);
-
 	if (dns_cb_arg.done && dns_cb_arg.host_ipaddr.addr != 0)
 		return CMD_RET_SUCCESS;
 
diff --git a/net/lwip/net-lwip.c b/net/lwip/net-lwip.c
index cab1dd7d483..77f16f8af9c 100644
--- a/net/lwip/net-lwip.c
+++ b/net/lwip/net-lwip.c
@@ -141,7 +141,7 @@ void net_lwip_set_current(void)
 	eth_set_current();
 }
 
-static struct netif *new_netif(struct udevice *udev, bool with_ip)
+static struct netif *get_or_create_netif(struct udevice *udev, bool with_ip)
 {
 	unsigned char enetaddr[ARP_HLEN];
 	char hwstr[MAC_ADDR_STRLEN];
@@ -152,13 +152,14 @@ static struct netif *new_netif(struct udevice *udev, bool with_ip)
 	if (!udev)
 		return NULL;
 
+	if (udev->netif)
+		return udev->netif;
+
 	if (eth_start_udev(udev) < 0) {
 		log_err("Could not start %s\n", udev->name);
 		return NULL;
 	}
 
-	netif_remove(net_lwip_get_netif());
-
 	ip4_addr_set_zero(&ip);
 	ip4_addr_set_zero(&mask);
 	ip4_addr_set_zero(&gw);
@@ -198,17 +199,19 @@ static struct netif *new_netif(struct udevice *udev, bool with_ip)
 	/* Routing: use this interface to reach the default gateway */
 	netif_set_default(netif);
 
+	udev->netif = netif;
+
 	return netif;
 }
 
-struct netif *net_lwip_new_netif(struct udevice *udev)
+struct netif *net_lwip_netif(struct udevice *udev)
 {
-	return new_netif(udev, true);
+	return get_or_create_netif(udev, true);
 }
 
-struct netif *net_lwip_new_netif_noip(struct udevice *udev)
+struct netif *net_lwip_netif_noip(struct udevice *udev)
 {
-	return new_netif(udev, false);
+	return get_or_create_netif(udev, false);
 }
 
 void net_lwip_remove_netif(struct netif *netif)
@@ -221,7 +224,7 @@ int net_init(void)
 {
 	eth_set_current();
 
-	net_lwip_new_netif(eth_get_dev());
+	net_lwip_netif(eth_get_dev());
 
 	return 0;
 }
diff --git a/net/lwip/ping.c b/net/lwip/ping.c
index 200a702bbb5..6dc8f88782b 100644
--- a/net/lwip/ping.c
+++ b/net/lwip/ping.c
@@ -119,17 +119,15 @@ static int ping_loop(struct udevice *udev, const ip_addr_t *addr)
 	struct netif *netif;
 	int ret;
 
-	netif = net_lwip_new_netif(udev);
+	netif = net_lwip_netif(udev);
 	if (!netif)
 		return CMD_RET_FAILURE;
 
 	printf("Using %s device\n", udev->name);
 
 	ret = ping_raw_init(&ctx);
-	if (ret < 0) {
-		net_lwip_remove_netif(netif);
+	if (ret < 0)
 		return ret;
-	}
 
 	ctx.target = *addr;
 
@@ -149,8 +147,6 @@ static int ping_loop(struct udevice *udev, const ip_addr_t *addr)
 	sys_untimeout(ping_send, &ctx);
 	ping_raw_stop(&ctx);
 
-	net_lwip_remove_netif(netif);
-
 	if (ctx.alive)
 		return 0;
 
diff --git a/net/lwip/tftp.c b/net/lwip/tftp.c
index 123d66b5dba..aae1b3bbad3 100644
--- a/net/lwip/tftp.c
+++ b/net/lwip/tftp.c
@@ -119,7 +119,7 @@ static int tftp_loop(struct udevice *udev, ulong addr, char *fname,
 	if (!srvport)
 		srvport = TFTP_PORT;
 
-	netif = net_lwip_new_netif(udev);
+	netif = net_lwip_netif(udev);
 	if (!netif)
 		return -1;
 
@@ -146,7 +146,6 @@ static int tftp_loop(struct udevice *udev, ulong addr, char *fname,
 	/* might return different errors, like routing problems */
 	if (err != ERR_OK) {
 		printf("tftp_get() error %d\n", err);
-		net_lwip_remove_netif(netif);
 		return -1;
 	}
 
@@ -162,8 +161,6 @@ static int tftp_loop(struct udevice *udev, ulong addr, char *fname,
 
 	tftp_cleanup();
 
-	net_lwip_remove_netif(netif);
-
 	if (ctx.done == SUCCESS) {
 		if (env_set_hex("fileaddr", addr)) {
 			log_err("fileaddr not updated\n");
diff --git a/net/lwip/wget.c b/net/lwip/wget.c
index 14f27d42998..b191c95e251 100644
--- a/net/lwip/wget.c
+++ b/net/lwip/wget.c
@@ -307,7 +307,7 @@ static int wget_loop(struct udevice *udev, ulong dst_addr, char *uri)
 	if (parse_url(uri, ctx.server_name, &ctx.port, &path, &is_https))
 		return CMD_RET_USAGE;
 
-	netif = net_lwip_new_netif(udev);
+	netif = net_lwip_netif(udev);
 	if (!netif)
 		return -1;
 
@@ -320,7 +320,6 @@ static int wget_loop(struct udevice *udev, ulong dst_addr, char *uri)
 
 		if (!tls_allocator.arg) {
 			log_err("error: Cannot create a TLS connection\n");
-			net_lwip_remove_netif(netif);
 			return -1;
 		}
 
@@ -332,10 +331,8 @@ static int wget_loop(struct udevice *udev, ulong dst_addr, char *uri)
 	conn.headers_done_fn = httpc_headers_done_cb;
 	ctx.path = path;
 	if (httpc_get_file_dns(ctx.server_name, ctx.port, path, &conn, httpc_recv_cb,
-			       &ctx, &state)) {
-		net_lwip_remove_netif(netif);
+			       &ctx, &state))
 		return CMD_RET_FAILURE;
-	}
 
 	while (!ctx.done) {
 		net_lwip_rx(udev, netif);
@@ -344,8 +341,6 @@ static int wget_loop(struct udevice *udev, ulong dst_addr, char *uri)
 			break;
 	}
 
-	net_lwip_remove_netif(netif);
-
 	if (ctx.done == SUCCESS)
 		return 0;
 
-- 
2.43.0

