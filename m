Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2640C369B8
	for <u-boot@archiver.kernel.org>; Tue, 15 Apr 2025 21:18:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 32B7482B7E;
	Tue, 15 Apr 2025 23:18:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="hk1M+gzp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2E41682A27; Tue, 15 Apr 2025 23:18:33 +0200 (CEST)
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com
 [IPv6:2a00:1450:4864:20::436])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0E7DD81F0D
 for <u-boot@lists.denx.de>; Tue, 15 Apr 2025 23:18:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-391342fc1f6so5213563f8f.1
 for <u-boot@lists.denx.de>; Tue, 15 Apr 2025 14:18:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744751910; x=1745356710; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=N/dxSILVFVpJWcH0rtldlJyOod0yJDJ8NWl9T9tlmrE=;
 b=hk1M+gzpaBq/hJv1T29BQlTT5GuRbElM/Fiu1Qe0qaTi9EKh9I3TT4+8rYVe19s2yy
 aRp0bZYG8bgOVaZq9mwLjXrCg2cs9PHhjZbF7LCxqm4fX9gDlcV2KAEFrA9hOGWEUWyC
 2ICUXyFwywuD8cd/Xh6EQMGjDa+++Q8wvgnlAstHA5py0W1IBiMGp/W7oTy7lh2Cj9jC
 b22eRsFOhuAcE4Ktff8DArc2NLtWOpybaxpMDxRG0YWC+1MEKhPu9aZtZkxjiHyCaOrd
 OrHqYxQScAf/6tJ783v9bLVuBHnNJXBDXQD/w6F7Rrew1VMESi0En/HRZTh/C90wfruv
 XFJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744751910; x=1745356710;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=N/dxSILVFVpJWcH0rtldlJyOod0yJDJ8NWl9T9tlmrE=;
 b=uzvZlnjj34VkJ9F3CZq/LsWNmMrUt1TEMkPDpK7+BkV4GHDRP/KaBi2kEMPANVaxFg
 evqMff4Xx64h2sU6ZNsODVL6mIERSGsrgUybbdSJLh/2mf7yJwrgEhqItORGlAtNLo5n
 8ODEcDfpaH0NeHCZtLV4iZVlQ+lSxdMuM/6vsPqdP1YYOLFgDn+LvdeP3KqZ1JbxsQPG
 d0p1gGsDgz9IOsQZo1HmnF+/V1v6V+9wgv39eHhxw+GvHM5RL3Oj9fDp0MBqNVtCzUJk
 URpwq2f89QiPgUebZxtznWeUAuelkyG0v8+AKiwTWKhz9KYmZtc8YtuvOjD6yQdNXQnG
 EymA==
X-Gm-Message-State: AOJu0YzZ7bEyXV9GBFmDmkkZ+V0WSCtpUxu10CXdPPW7vNQAaLb7aWUk
 mPfThOKOHroY0LU7kfjAONv23SCREmm0AAIPfV0hvGMzVJBLdTOqSIT0wRtaDUc3agHTrI5SDv4
 wkw4=
X-Gm-Gg: ASbGncut8vQGIK05KqOFXUXsW6vMPHA6JoVQ1Cnicmja+EXTjr1aFCj/Mtb7hc8mFrl
 d7KRZDoyplIJezGb91/7gWK8e0YNRLP6aCMKi2iXXWKuLmP35FeO1OntCbQVlCW0HhVFemF5nR4
 xMweG06DQ67QpI1WiQ2yJJrI+KblEKfJ0MfreKZ5xsHBKeTCpNB2hp80fUl8LAPf5SY4r4LUTBG
 nBEj+1GaptI1kDN1EFsKRDsCmilh+G39MLZzu2ABnIKv99RV4CILuMwyHaDw4HSrQwB/PC1Da8O
 nf0LYoNI81RpH7FMufGBPrCZ3RPq27F5duOWNBFXxWefu0eQuDSQoKSkeNY=
X-Google-Smtp-Source: AGHT+IEkEU42nyGG8MjK2aI8poMRMgtGyF1hT1EHDT4MhujXy76zuCv2TkcUpH1BJ23JHbTTsYJCmA==
X-Received: by 2002:a5d:5985:0:b0:39e:cbd2:986b with SMTP id
 ffacd0b85a97d-39ee2729edcmr716674f8f.7.1744751910300; 
 Tue, 15 Apr 2025 14:18:30 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:6ebc:6ce:770e:95f9])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39eaf43cce3sm15530917f8f.74.2025.04.15.14.18.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Apr 2025 14:18:30 -0700 (PDT)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: U-Boot mailing list <u-boot@lists.denx.de>
Cc: Jerome Forissier <jerome.forissier@linaro.org>,
 Simon Glass <sjg@chromium.org>, Adriano Cordova <adrianox@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 01/11] net: lwip: fix initialization sequence before a
 command
Date: Tue, 15 Apr 2025 23:17:36 +0200
Message-ID: <20250415211819.1254435-2-jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250415211819.1254435-1-jerome.forissier@linaro.org>
References: <20250415211819.1254435-1-jerome.forissier@linaro.org>
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
Reviewed-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

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
index 6b7b696dbf0..6748008736b 100644
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

