Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 557CFC0218A
	for <u-boot@archiver.kernel.org>; Thu, 30 Jan 2025 08:22:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 94B6B80B9B;
	Thu, 30 Jan 2025 09:22:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="YKJrnrcL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C68BE80C99; Thu, 30 Jan 2025 09:22:47 +0100 (CET)
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com
 [IPv6:2a00:1450:4864:20::442])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5F7CD80AE4
 for <u-boot@lists.denx.de>; Thu, 30 Jan 2025 09:22:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wr1-x442.google.com with SMTP id
 ffacd0b85a97d-385dece873cso213593f8f.0
 for <u-boot@lists.denx.de>; Thu, 30 Jan 2025 00:22:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738225364; x=1738830164; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=nXrL+DNHXHbua5950sEuZlyBYY/SjpPfctmF8aNQCjI=;
 b=YKJrnrcL/EyJREVRaVi6kQk4DyP6JXARdfGDPExGnxrYY93yd8mkRSzkywgrB7TUx7
 wRm5iL2QZyMJHbog8qPoFWuCJDrY+OgToVPouJb1dQxqF4wNExHhN22IxKVZEKB81zBW
 9GKams8SWJkDeYd9zBoWdfauPHmsTCHhgd121GBqef/9rPyjrvA1oZDOsFQeIsJmm2we
 UNCb7zz5fsFmTjglXKUTrcPp7pjMy2GziWkNKdVKO8bW8YoHUbf1F/tSjN66JJQwqdAT
 vMVaDo5uTpJoYEr8MK3diRpKeR7NLVMkNvW1sLRKJx5cFH5O1eSrF1Pw2JyYux+S9379
 FGVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738225364; x=1738830164;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=nXrL+DNHXHbua5950sEuZlyBYY/SjpPfctmF8aNQCjI=;
 b=vhIlPUJz8Esbth375FSpwFkqlEO/00gAL/5MMabEFgFIxCeSs8DL+52mSY0TfygXj+
 Ll6lzK+9YPEJI+PqFxoOsyqZMcoN4U5hlAmKp8UeBN5m00fzDpZq+eIGJQa0S1mV2AgP
 x6/W2mnNkZLn/7APko7JqrnJ+rfmM0e1sFqbb6qg+oFlQTc8E/Vdf5cNAAfW0A36as2n
 yoE/5ZCm5r5MFU6cyzya84VVAClMaa/SDNP6IdlA93H4DNWTgLhITFuNKFk5/iDlDwzx
 AtHmsPJVa/AugaR7utDge42pggsAL9bNVkgCcfOZGzPxqq8bzS95/KPEK35YVZcuy71e
 7FVA==
X-Gm-Message-State: AOJu0YwZB94XMEqVBIZ85Jke/hs+Yv7xeoCKhhl6PjLptvxVdcYSA0Vr
 Lgo1kYo+of0l4Cu6GhU88bfNxufF02Ep7nioSXb+RsBO+FpHjRSUupHiW5j1/2sOvjydA/A75dP
 eYh5vT1JHluQ=
X-Gm-Gg: ASbGncsmI+/JemAdJapW2KDm85KpNzUhFjtPqAgD+0ISCZzY6jQFo00G57JqUX3l7ix
 S44TgIKOb9lhmBHBmNcSsMbSVAbg8us9gO1tykUmOBVWPOCrawVf6guSnQQFCHBuBPsZcLiLmgL
 peoOtpcgcSOFSXchcvlp1i1k58xPrjSM9oOp21B538QVIGpoevaZ9Zwq1N/93tiyDdO6XXP9jgh
 xiu5LlD/UFI/2wkE6hJh5TjNpiQ+k1rTrZZNLAlKggZhwvvh7BDJb0AVRKMwUzZEoGHOo+suCvb
 yNHUn/dn5Eg9Dcw3hubtsreY
X-Google-Smtp-Source: AGHT+IGnWbSjaL0xdcBV1WYCX/riy+aaqzhL8W3cSkJe4Zv6b5FISwcT3xAj7KNmJIETAIso+6HlZQ==
X-Received: by 2002:a5d:4527:0:b0:385:e17a:ce61 with SMTP id
 ffacd0b85a97d-38c520b0990mr3753213f8f.53.1738225364544; 
 Thu, 30 Jan 2025 00:22:44 -0800 (PST)
Received: from builder.. ([2a01:e0a:3cb:7bb0:623b:514b:a76b:ed40])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38c5c1cfccasm1231091f8f.92.2025.01.30.00.22.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Jan 2025 00:22:44 -0800 (PST)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>, E Shattow <e@freeshell.de>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Tom Rini <trini@konsulko.com>, Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Adriano Cordova <adrianox@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>
Subject: [PATCH] net: lwip: move eth_init() out of new_netif()
Date: Thu, 30 Jan 2025 09:22:20 +0100
Message-ID: <20250130082226.1572302-1-jerome.forissier@linaro.org>
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

Move the initialization of the ethernet devices out of the new_netif()
function. Indeed, new_netif() accepts a struct device argument, which
is expected to be valid and active. The activation and selection of
this device are achieved by eth_init() (on first time the network
stack is used) and eth_set_current(). This is what takes care of the
ethrotate and ethact environment variables. Therefore, move these calls
to a new function: net_lwip_set_current(), and use it whenever a
net-lwip command is run.

This patch hopefully fixes the incorrect net-lwip behavior observed on
boards with multiple ethernet interfaces [1].

Tested on an i.MX8MPlus EVK equipped wih two ethernet ports. The dhcp
command succeeds whether the cable is plugged into the first or second
port.

[1] https://lists.denx.de/pipermail/u-boot/2025-January/576326.html

Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
CC: E Shattow <e@freeshell.de>
---
 include/net-lwip.h  |  1 +
 net/lwip/dhcp.c     |  2 +-
 net/lwip/dns.c      |  2 +-
 net/lwip/net-lwip.c | 23 ++++++++++++++---------
 net/lwip/ping.c     |  2 +-
 net/lwip/tftp.c     |  2 +-
 net/lwip/wget.c     |  2 +-
 7 files changed, 20 insertions(+), 14 deletions(-)

diff --git a/include/net-lwip.h b/include/net-lwip.h
index 4d7f9387d1d..64e5c720560 100644
--- a/include/net-lwip.h
+++ b/include/net-lwip.h
@@ -10,6 +10,7 @@ enum proto_t {
 	TFTPGET
 };
 
+void net_lwip_set_current(void);
 struct netif *net_lwip_new_netif(struct udevice *udev);
 struct netif *net_lwip_new_netif_noip(struct udevice *udev);
 void net_lwip_remove_netif(struct netif *netif);
diff --git a/net/lwip/dhcp.c b/net/lwip/dhcp.c
index e7d9147455c..3b7e4700c6e 100644
--- a/net/lwip/dhcp.c
+++ b/net/lwip/dhcp.c
@@ -115,7 +115,7 @@ int do_dhcp(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 	int ret;
 	struct udevice *dev;
 
-	eth_set_current();
+	net_lwip_set_current();
 
 	dev = eth_get_dev();
 	if (!dev) {
diff --git a/net/lwip/dns.c b/net/lwip/dns.c
index 1de63c9998b..149bdb784dc 100644
--- a/net/lwip/dns.c
+++ b/net/lwip/dns.c
@@ -121,7 +121,7 @@ int do_dns(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 	if (argc == 3)
 		var = argv[2];
 
-	eth_set_current();
+	net_lwip_set_current();
 
 	return dns_loop(eth_get_dev(), name, var);
 }
diff --git a/net/lwip/net-lwip.c b/net/lwip/net-lwip.c
index b863047f598..cab1dd7d483 100644
--- a/net/lwip/net-lwip.c
+++ b/net/lwip/net-lwip.c
@@ -127,6 +127,20 @@ static int get_udev_ipv4_info(struct udevice *dev, ip4_addr_t *ip,
 	return 0;
 }
 
+/* Initialize the lwIP stack and the ethernet devices and set current device  */
+void net_lwip_set_current(void)
+{
+	static bool init_done;
+
+	if (!init_done) {
+		eth_init_rings();
+		eth_init();
+		lwip_init();
+		init_done = true;
+	}
+	eth_set_current();
+}
+
 static struct netif *new_netif(struct udevice *udev, bool with_ip)
 {
 	unsigned char enetaddr[ARP_HLEN];
@@ -134,19 +148,10 @@ static struct netif *new_netif(struct udevice *udev, bool with_ip)
 	ip4_addr_t ip, mask, gw;
 	struct netif *netif;
 	int ret = 0;
-	static bool first_call = true;
 
 	if (!udev)
 		return NULL;
 
-	if (first_call) {
-		eth_init_rings();
-		/* Pick a valid active device, if any */
-		eth_init();
-		lwip_init();
-		first_call = false;
-	}
-
 	if (eth_start_udev(udev) < 0) {
 		log_err("Could not start %s\n", udev->name);
 		return NULL;
diff --git a/net/lwip/ping.c b/net/lwip/ping.c
index aa617530749..200a702bbb5 100644
--- a/net/lwip/ping.c
+++ b/net/lwip/ping.c
@@ -168,7 +168,7 @@ int do_ping(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 	if (!ipaddr_aton(argv[1], &addr))
 		return CMD_RET_USAGE;
 
-	eth_set_current();
+	net_lwip_set_current();
 
 	if (ping_loop(eth_get_dev(), &addr) < 0)
 		return CMD_RET_FAILURE;
diff --git a/net/lwip/tftp.c b/net/lwip/tftp.c
index fc4aff5f2ba..123d66b5dba 100644
--- a/net/lwip/tftp.c
+++ b/net/lwip/tftp.c
@@ -280,7 +280,7 @@ int do_tftpb(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 		goto out;
 	}
 
-	eth_set_current();
+	net_lwip_set_current();
 
 	if (tftp_loop(eth_get_dev(), laddr, fname, srvip, port) < 0)
 		ret = CMD_RET_FAILURE;
diff --git a/net/lwip/wget.c b/net/lwip/wget.c
index b76f6c0f1d9..9aec75f9bed 100644
--- a/net/lwip/wget.c
+++ b/net/lwip/wget.c
@@ -354,7 +354,7 @@ static int wget_loop(struct udevice *udev, ulong dst_addr, char *uri)
 
 int wget_do_request(ulong dst_addr, char *uri)
 {
-	eth_set_current();
+	net_lwip_set_current();
 
 	if (!wget_info)
 		wget_info = &default_wget_info;
-- 
2.43.0

