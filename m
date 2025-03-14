Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BA69C282EC
	for <u-boot@archiver.kernel.org>; Fri, 14 Mar 2025 21:56:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3B3D58206E;
	Fri, 14 Mar 2025 22:55:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="mn9Pz3+J";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2209881F7E; Fri, 14 Mar 2025 22:55:53 +0100 (CET)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0C1508201E
 for <u-boot@lists.denx.de>; Fri, 14 Mar 2025 22:55:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-43d0a5cfd7dso1299115e9.1
 for <u-boot@lists.denx.de>; Fri, 14 Mar 2025 14:55:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741989350; x=1742594150; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rM8yyD7hLE0F63l8d+wL/RERC0XiFCUSmruDbI8tQhs=;
 b=mn9Pz3+Jb2CzNRvVom5vGsMpYyTjCQvnmd0wHY6iawoe92oSAaGOytVE4Gd3XbAd/2
 L65oP6GN+hJwZYSigdyLn/Ya/ZzqEZ4CJat140fInBjjFgOMTF0QVdBoVMWwU0GmsDN8
 33LYECfstBUbKu8Skj8kcSNjb8Nmk8+lgtH3GNQ8XNsqednhWqG6zqc3qvSr6w1YX+mj
 fySFj0yJXOykHjsc5o6VcU9RXRwGcdgr2va9wJUeieRyl7NJtc25rwPYsm5+VPn4gejO
 Ly+nvnAr+fkWa+zGJK0KPlBdYAdQCErtUAPJxlx3PUN7frWpzm/El92YeSDJjEyVYc/O
 np2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741989350; x=1742594150;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rM8yyD7hLE0F63l8d+wL/RERC0XiFCUSmruDbI8tQhs=;
 b=OeYyMNUmbIo7pr4XRUIyIfOhHNa0o3vDcAs3UbU/fs97bEcUCgddaxBTL/cRBpmHgE
 9Q7yxNKo0lBBtLyIykkvHiTadF/UN0uoUnychf7QZQY7dyqgdFl78LJmW0pJhwlb8RBX
 j+bHtRPJOuI/vxVn2QMfrfxcIT/o7jCxZ54PC9ZgC5QpPpdI831iFGo32QKySoyHNCwQ
 Am+V6blz/KUHkZED3Ti/f2t1LNFfRkkCkRlqJaT4+Aj5VaWvnJk0DwIJQaJurCQSVQJY
 HE1u+xpgMPDXeUWsPx/Z7bV68rdyPu6nYnz3kxksyb1C3ReEhfnWNrpZfsdMyuYhUu82
 K/Iw==
X-Gm-Message-State: AOJu0Yz3kK1dqd3baOmWQuPx5JjHCno0U7Dlq+6ElhwtdZjCleUJuOOy
 EBCqUbD1FDi9wtHIzJKTBk1MkRjOOfjTK/93fWXzXsNJfrrCdSjgUoMMVXidzFpm9dYByw/QHDn
 VrCs=
X-Gm-Gg: ASbGnctkfNoH43LTpzw7c0e92iOozOf3sN7IjqI3VyZVcp3t5vB7ugIdn0MImx2SZrZ
 rUy64XcrIfnn8+OIqrQ44SWTUsW7Mdds74+VnvN+6kk81hr4l2aNCMUCtzO+g8iTw6WSbwCT7mC
 railqHW4HcWuIIOI15m6qEdLSGUdvQmqqus0E9PUJn1QY8iKS0/l6tcvWLin7lm4HcvhNi5PCAw
 iDJ8mAQSKpTOnN8bteXq6MPNAJF8TvoQ2/9zhapHZY+ThoYmvBwBCMsr7wS34pLgqNCPuUEtXft
 K+vuy985s2lE4htueXAHlfE5N8grAkZfguo0yFEcmaHGcnnWrw9Azw==
X-Google-Smtp-Source: AGHT+IHg4WVuuKU3sUbrhRJIC640YCSFOK56P+OdoWjGR/ZY+wY57us3IoGjx1LUa8m8FjlLrHoS2g==
X-Received: by 2002:a05:600c:4fcc:b0:43c:fab3:4fad with SMTP id
 5b1f17b1804b1-43d1ec80ebcmr61793435e9.16.1741989350298; 
 Fri, 14 Mar 2025 14:55:50 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:5485:bb38:c353:6b0c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d1fe05ff4sm29064395e9.10.2025.03.14.14.55.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Mar 2025 14:55:49 -0700 (PDT)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Tom Rini <trini@konsulko.com>, Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Adriano Cordova <adrianox@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>
Subject: [PATCH 02/12] net: lwip: fix initialization sequence before a command
Date: Fri, 14 Mar 2025 22:55:04 +0100
Message-ID: <20250314215525.579655-3-jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250314215525.579655-1-jerome.forissier@linaro.org>
References: <20250314215525.579655-1-jerome.forissier@linaro.org>
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

The things that are done prior to executing a network command with
NET_LWIP are not consistent with what is done with NET. It impacts the
selection of the current device, and more precisely if the active device
is invalid NET would return an error while NET_LWIP would try to pick a
new device. This incorrect behavior was detected thanks to the eth_rotate
sandbox test (dm_test_eth_rotate()).

Fix it by re-using a sequence similar to what NET has in net_loop().
This piece of code is inserted in a function called net_lwip_eth_start()
renamed from net_lwip_eth_set_current().

Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
---
 include/net-lwip.h  |  9 ++++++++-
 net/lwip/dhcp.c     |  3 ++-
 net/lwip/dns.c      |  3 ++-
 net/lwip/net-lwip.c | 40 +++++++++++++++++++++++++++++-----------
 net/lwip/ping.c     |  3 ++-
 net/lwip/tftp.c     |  5 ++++-
 net/lwip/wget.c     |  6 +++++-
 7 files changed, 52 insertions(+), 17 deletions(-)

diff --git a/include/net-lwip.h b/include/net-lwip.h
index 64e5c720560..0d3bb8a8bd8 100644
--- a/include/net-lwip.h
+++ b/include/net-lwip.h
@@ -10,7 +10,14 @@ enum proto_t {
 	TFTPGET
 };
 
-void net_lwip_set_current(void);
+static inline int eth_is_on_demand_init(void)
+{
+	return 1;
+}
+
+int eth_init_state_only(void); /* Set active state */
+
+int net_lwip_eth_start(void);
 struct netif *net_lwip_new_netif(struct udevice *udev);
 struct netif *net_lwip_new_netif_noip(struct udevice *udev);
 void net_lwip_remove_netif(struct netif *netif);
diff --git a/net/lwip/dhcp.c b/net/lwip/dhcp.c
index 3b7e4700c6e..92bd7067a7f 100644
--- a/net/lwip/dhcp.c
+++ b/net/lwip/dhcp.c
@@ -115,7 +115,8 @@ int do_dhcp(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 	int ret;
 	struct udevice *dev;
 
-	net_lwip_set_current();
+	if (net_lwip_eth_start() < 0)
+		return CMD_RET_FAILURE;
 
 	dev = eth_get_dev();
 	if (!dev) {
diff --git a/net/lwip/dns.c b/net/lwip/dns.c
index 149bdb784dc..19172ac959a 100644
--- a/net/lwip/dns.c
+++ b/net/lwip/dns.c
@@ -121,7 +121,8 @@ int do_dns(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 	if (argc == 3)
 		var = argv[2];
 
-	net_lwip_set_current();
+	if (net_lwip_eth_start() < 0)
+		return CMD_RET_FAILURE;
 
 	return dns_loop(eth_get_dev(), name, var);
 }
diff --git a/net/lwip/net-lwip.c b/net/lwip/net-lwip.c
index c00a7fe97cd..1e60fa31bfb 100644
--- a/net/lwip/net-lwip.c
+++ b/net/lwip/net-lwip.c
@@ -134,18 +134,27 @@ static int get_udev_ipv4_info(struct udevice *dev, ip4_addr_t *ip,
 	return 0;
 }
 
-/* Initialize the lwIP stack and the ethernet devices and set current device  */
-void net_lwip_set_current(void)
+/*
+ * Initialize the network stack if needed and start the current device if valid
+ */
+int net_lwip_eth_start(void)
 {
-	static bool init_done;
+	int ret;
 
-	if (!init_done) {
-		eth_init_rings();
-		eth_init();
-		lwip_init();
-		init_done = true;
+	net_init();
+	if (eth_is_on_demand_init()) {
+		eth_halt();
+		eth_set_current();
+		ret = eth_init();
+		if (ret < 0) {
+			eth_halt();
+			return ret;
+		}
+	} else {
+		eth_init_state_only();
 	}
-	eth_set_current();
+
+	return 0;
 }
 
 static struct netif *new_netif(struct udevice *udev, bool with_ip)
@@ -224,11 +233,20 @@ void net_lwip_remove_netif(struct netif *netif)
 	free(netif);
 }
 
+/*
+ * Initialize the network buffers, an ethernet device, and the lwIP stack
+ * (once).
+ */
 int net_init(void)
 {
-	eth_set_current();
+	static bool init_done;
 
-	net_lwip_new_netif(eth_get_dev());
+	if (!init_done) {
+		eth_init_rings();
+		eth_init();
+		lwip_init();
+		init_done = true;
+	}
 
 	return 0;
 }
diff --git a/net/lwip/ping.c b/net/lwip/ping.c
index c586a96806d..542ef2cb148 100644
--- a/net/lwip/ping.c
+++ b/net/lwip/ping.c
@@ -168,7 +168,8 @@ int do_ping(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 	if (!ipaddr_aton(argv[1], &addr))
 		return CMD_RET_USAGE;
 
-	net_lwip_set_current();
+	if (net_lwip_eth_start() < 0)
+		return CMD_RET_FAILURE;
 
 	if (ping_loop(eth_get_dev(), &addr) < 0)
 		return CMD_RET_FAILURE;
diff --git a/net/lwip/tftp.c b/net/lwip/tftp.c
index 123d66b5dba..4f9b2049187 100644
--- a/net/lwip/tftp.c
+++ b/net/lwip/tftp.c
@@ -280,7 +280,10 @@ int do_tftpb(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 		goto out;
 	}
 
-	net_lwip_set_current();
+	if (net_lwip_eth_start() < 0) {
+		ret = CMD_RET_FAILURE;
+		goto out;
+	}
 
 	if (tftp_loop(eth_get_dev(), laddr, fname, srvip, port) < 0)
 		ret = CMD_RET_FAILURE;
diff --git a/net/lwip/wget.c b/net/lwip/wget.c
index ec098148835..a3b82908877 100644
--- a/net/lwip/wget.c
+++ b/net/lwip/wget.c
@@ -471,7 +471,11 @@ static int wget_loop(struct udevice *udev, ulong dst_addr, char *uri)
 
 int wget_do_request(ulong dst_addr, char *uri)
 {
-	net_lwip_set_current();
+	int ret;
+
+	ret = net_lwip_eth_start();
+	if (ret < 0)
+		return ret;
 
 	if (!wget_info)
 		wget_info = &default_wget_info;
-- 
2.43.0

