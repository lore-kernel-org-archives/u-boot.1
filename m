Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4026C61DBD
	for <u-boot@archiver.kernel.org>; Wed, 26 Aug 2026 05:30:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6B74280C44;
	Wed, 26 Aug 2026 05:30:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nQVMDx7v2h9q; Wed, 26 Aug 2026 05:30:45 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787722245;
	bh=+1AB7P8KGCGtakjgUeNojqcorEE3tdU7M2xZNZOeRdM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=X+RGDL9k4Wd7L4wzg1gM4uapGwspRWkouGSGbUucQ9LzDqk6zAlpC5S2m7AEXlPu0
	 C6idOjIPjfc8QWwAJImJaJXk947+Iu/4LSgbjzG1/0HzQYapCKBAAX25J/pejhDxtl
	 fQCinHLih1nXepMpospSsCCUNzok3wDPGQqNUt9k4cgdq8ftkbGFMO4RQGZqVqV1OM
	 tYvcc2/EDhoL8ylpKU3cdiuJ2kRWN2MqxUf/yfFmvjZHMKhDP/dK0CNDasB+GSs2FO
	 taCWR0sujmxDlWA6mGlmHMmucJeIRe4zRFzlQlUk1UwWfGQVa+ES2AVb6O1+hrivZ0
	 FLhSgbnLDl9ug==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 21E5880C36;
	Wed, 26 Aug 2026 05:30:45 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 180DA2FD
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 05:30:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 0A31640073
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 05:30:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id syQkyzq5XjTh for <u-boot@lists.u-boot-project.org>;
 Wed, 26 Aug 2026 05:30:32 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:4860:4864:20::36; helo=mail-oa1-x36.google.com;
 envelope-from=james.hilliard1@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=Yo2mndMp
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com
 [IPv6:2001:4860:4864:20::36])
 by smtp2.osuosl.org (Postfix) with ESMTPS id D91464000B
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 05:30:31 +0000 (UTC)
Received: by mail-oa1-x36.google.com with SMTP id
 586e51a60fabf-4518ad44e83so661287fac.0
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 22:30:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787722230; x=1788327030;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=+1AB7P8KGCGtakjgUeNojqcorEE3tdU7M2xZNZOeRdM=;
 b=Yo2mndMpTngxu4mtX8wXM/MJp3q2olMhH69Y1pPYVINkQ14rKgjiXmO4akFyGPpN4w
 vAydIZcZKO4lF6KR7gkfiuFQuASc7J8g9LPOJtNBoVTMc32pNYUCuvZQZR+XvM0PfwM4
 qXsunAW5se4qHnYR0IZ8zWplfQcUD06QvN/7rG6rqwxR4BO1eMT2SX5qHTB5NMeUbXij
 pcM3XUTNCkWwOEwWiYI348XfeMUqrpEjGRCX1zLUCt3hVA5Jrvkye4lq7OU+0K8eBuKq
 PQJfdyaxR45cf1q9BKkkKhAHulxlSMNb+HY3fhS9Cd2WKF5rV6IJtwlHVQwAje9ikz96
 ZMNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787722230; x=1788327030;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=+1AB7P8KGCGtakjgUeNojqcorEE3tdU7M2xZNZOeRdM=;
 b=h6OkiaCjrgjj69lubt62oKOmCyjUlfn36U9y2mhisGl+Hb97akoJvWzbZuEDXFTczQ
 jxNdqR7uC8yzYMv6GPVwQoVfHXseSRGIFtqBuNzQaX0PbLHU1+RN3RtBue/vv/MS1j09
 Kr0rfHWTjsF133Njc37JM+1Zj50TG+sd+PHrauteUpcRRKUllxX3C7y4he2fGoB30n/2
 THIkNftKRXCl3UpAaZcHZVkKUG9A9CisUkcbioKfZIRa8/+Pi6vV/34avjJ3x7Pi6rHb
 GVUA/ZAMoZKu7OLQ3vJB20gxclrqchaqlR4SxOY3nkdpv+7PcKS+SQIeTr7Apc0rbUd2
 TRtA==
X-Gm-Message-State: AFuF++mdjsGicUJokoSten/KmZibVhihg7namDeIeexX137O5GibugO+
 bjwQuayrMWUue3QNNPSzUXfj+Z/uzk8qhPhshmqxsZBchfyITifg2GMR
X-Gm-Gg: AR+sD12Rz2wfggZdu1+Mx1hX4ZeLMVmZuL0SmQEiMaIGlRp9LH0ZAfPwjRh8NJj47D+
 1nW2znbksD9igG83vd8/M3MRlrUwbaAjioEtFPRwtBwY1n1qmyWCfl1NfglXgxy7gI5jWyHlrvs
 nV0zwgvJGb6DjotptdoS595UItnWeTs+ZpKu1zt5ZmD8/RDNDqMDQNopyQLsu1bx1theW7TMiNB
 uEfY/CRREeSDaL4UMYpPsVY9TxgJjeT1kP8WSPhb+xvH6HEMuZPn7qG3LzMRvYTET2oIOGf7zAA
 vrF3ruyGyKrRTmNyhrSf0E7NoAW+KSqr3JSq27ObkvI8I86cwhY7nBXJrP2xXR3yHvbBnGJCW97
 rV8VIXACzsmsOT/TZKefOeUxbI0bpRK6lZQXnEvkyznkCu7QeXRHdGba+skR5TiXrTnPndImJMr
 zFSxUt8JyTiG/ZTW/cioz0C9YUkGZH1m04oCO24wgDNZoIq4M6wOuJZQW/9KI9Adj06ZkDckZ5u
 dHFHpGHGeBtq4gVVjMGpjmAte4SnGQ7RXcwiWXgnLAjWLUaUr9BbqohtJkptofv8H6PcJQoliJI
 rmve9Xx2xmqm+WKgNbzoVvwPcso32X+2Kpql0Srw2A+OL8Zx2jlgjPWlgtOLgDQbP9rEW4drMf7
 I232nF/foN9zGhA==
X-Received: by 2002:a05:6870:fb9f:b0:448:9d5b:6393 with SMTP id
 586e51a60fabf-46599f6067dmr4984932fac.14.1787722230263; 
 Tue, 25 Aug 2026 22:30:30 -0700 (PDT)
Received: from [127.0.1.1] (71-218-10-81.hlrn.qwest.net. [71.218.10.81])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-465b0243574sm1346401fac.15.2026.08.25.22.30.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Aug 2026 22:30:29 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Tue, 25 Aug 2026 23:29:47 -0600
Subject: [PATCH 08/10] net: lwip: share one network runtime between clients
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260825-submit-lwip-runtime-netconsole-v1-v1-8-0892966aa758@gmail.com>
References: <20260825-submit-lwip-runtime-netconsole-v1-v1-0-0892966aa758@gmail.com>
In-Reply-To: <20260825-submit-lwip-runtime-netconsole-v1-v1-0-0892966aa758@gmail.com>
To: u-boot@lists.u-boot-project.org, 
 Jerome Forissier <jerome.forissier@arm.com>, 
 Sughosh Ganu <sughosh.ganu@arm.com>
Cc: James Hilliard <james.hilliard1@gmail.com>, 
 Tom Rini <trini@konsulko.com>, David Lechner <dlechner@baylibre.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Julien Stephan <jstephan@baylibre.com>, 
 Naveen Kumar Chaudhary <naveen.osdev@gmail.com>, 
 Luca Jones <ljones@t0.technology>, Weijie Gao <weijie.gao@mediatek.com>, 
 Pranav Tilak <pranav.vinaytilak@amd.com>, Simon Glass <sjg@chromium.org>, 
 Vincent Jardin <vjardin@free.fr>, Quentin Schulz <quentin.schulz@cherry.de>, 
 "Lucien.Jheng" <lucienzx159@gmail.com>
X-Mailer: b4 0.15.2
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

Each lwIP command currently creates the only netif and removes it when
the command exits. A second client therefore replaces the first client's
interface, and the first exit can stop Ethernet while the second is active.

Add a reference-counted runtime attachment which owns one Ethernet
device and netif. All attached clients use the global poll function, so
lwIP dispatches packets to every registered PCB. A DHCP attachment may
temporarily own interface addressing; the environment configuration is
restored when it leaves.

Migrate the existing commands and clean up their PCBs, callbacks and
timeouts before detaching. Wget now aborts an interrupted request and
releases its TLS configuration, while DHCP leaves its acquired address
configured.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 cmd/lwip/ping.c     |  41 ++++-----
 cmd/lwip/sntp.c     |  19 ++--
 include/net-lwip.h  |  42 +++++++--
 net/lwip/dhcp.c     |  57 ++++--------
 net/lwip/dns.c      |  24 ++---
 net/lwip/net-lwip.c | 248 ++++++++++++++++++++++++++++++++++++++++++++--------
 net/lwip/nfs.c      |  25 ++----
 net/lwip/tftp.c     |  54 +++++-------
 net/lwip/wget.c     |  70 ++++++++-------
 9 files changed, 372 insertions(+), 208 deletions(-)

diff --git a/cmd/lwip/ping.c b/cmd/lwip/ping.c
index 98fa8e22bce..9e159106f62 100644
--- a/cmd/lwip/ping.c
+++ b/cmd/lwip/ping.c
@@ -116,30 +116,23 @@ static void ping_send(void *arg)
 	}
 }
 
-static int ping_loop(struct udevice *udev, const ip_addr_t *addr)
+static int ping_loop(struct net_lwip_ctx *net, const ip_addr_t *addr)
 {
 	struct ping_ctx ctx = {};
-	struct netif *netif;
 	int ret;
 
-	netif = net_lwip_new_netif(udev);
-	if (!netif)
-		return -ENODEV;
-
-	printf("Using %s device\n", udev->name);
+	printf("Using %s device\n", net->dev->name);
 
 	ret = ping_raw_init(&ctx);
-	if (ret < 0) {
-		net_lwip_remove_netif(netif);
+	if (ret < 0)
 		return ret;
-	}
 
 	ctx.target = *addr;
 
 	ping_send(&ctx);
 
 	do {
-		net_lwip_rx(udev, netif);
+		net_lwip_poll();
 		if (ctx.alive)
 			break;
 		if (ctrlc()) {
@@ -151,8 +144,6 @@ static int ping_loop(struct udevice *udev, const ip_addr_t *addr)
 	sys_untimeout(ping_send, &ctx);
 	ping_raw_stop(&ctx);
 
-	net_lwip_remove_netif(netif);
-
 	if (ctx.alive)
 		return 0;
 
@@ -162,6 +153,7 @@ static int ping_loop(struct udevice *udev, const ip_addr_t *addr)
 
 int do_ping(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 {
+	struct net_lwip_ctx net = {};
 	ip_addr_t addr;
 	int ret;
 
@@ -174,13 +166,22 @@ int do_ping(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 	net_try_count = 1;
 
 	do {
-		if (net_lwip_eth_start() == 0) {
-			ret = ping_loop(eth_get_dev(), &addr);
-			net_lwip_eth_stop();
-			if (ret == 0)
-				return CMD_RET_SUCCESS;
-		}
-	} while (net_start_again() == 0);
+		ret = net_lwip_start(&net, NET_LWIP_ADDR_ENV);
+		if (!ret)
+			break;
+	} while (!net_start_again());
+	if (ret)
+		return CMD_RET_FAILURE;
+
+	do {
+		ret = ping_loop(&net, &addr);
+		if (!ret)
+			break;
+	} while (!net_lwip_restart(&net));
+
+	net_lwip_stop(&net);
+	if (!ret)
+		return CMD_RET_SUCCESS;
 
 	return CMD_RET_FAILURE;
 }
diff --git a/cmd/lwip/sntp.c b/cmd/lwip/sntp.c
index 584151ba7d1..2801f66866a 100644
--- a/cmd/lwip/sntp.c
+++ b/cmd/lwip/sntp.c
@@ -54,14 +54,8 @@ static bool ntp_server_known(void)
 	return false;
 }
 
-static int sntp_loop(struct udevice *udev, ip_addr_t *srvip)
+static int sntp_loop(struct net_lwip_ctx *net, ip_addr_t *srvip)
 {
-	struct netif *netif;
-
-	netif = net_lwip_new_netif(udev);
-	if (!netif)
-		return -1;
-
 	sntp_state = NOT_DONE;
 
 	sntp_setoperatingmode(SNTP_OPMODE_POLL);
@@ -71,7 +65,6 @@ static int sntp_loop(struct udevice *udev, ip_addr_t *srvip)
 	} else {
 		if (!ntp_server_known()) {
 			log_err("error: ntpserverip not set\n");
-			net_lwip_remove_netif(netif);
 			return -1;
 		}
 	}
@@ -79,7 +72,7 @@ static int sntp_loop(struct udevice *udev, ip_addr_t *srvip)
 
 	sys_timeout(SNTP_TIMEOUT, no_response, NULL);
 	while (sntp_state == NOT_DONE) {
-		net_lwip_rx(udev, netif);
+		net_lwip_poll();
 		if (ctrlc()) {
 			printf("\nAbort\n");
 			sntp_state = ABORTED;
@@ -89,7 +82,6 @@ static int sntp_loop(struct udevice *udev, ip_addr_t *srvip)
 	sys_untimeout(no_response, NULL);
 
 	sntp_stop();
-	net_lwip_remove_netif(netif);
 
 	if (sntp_state == SUCCESS)
 		return 0;
@@ -99,6 +91,7 @@ static int sntp_loop(struct udevice *udev, ip_addr_t *srvip)
 
 int do_sntp(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 {
+	struct net_lwip_ctx net = {};
 	ip_addr_t *srvip;
 	char *server;
 	ip_addr_t ipaddr;
@@ -125,16 +118,16 @@ int do_sntp(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 		return CMD_RET_USAGE;
 	}
 
-	if (net_lwip_eth_start() < 0)
+	if (net_lwip_start(&net, NET_LWIP_ADDR_ENV))
 		return CMD_RET_FAILURE;
 
-	if (sntp_loop(eth_get_dev(), srvip) < 0)
+	if (sntp_loop(&net, srvip) < 0)
 		goto out;
 
 	ret = CMD_RET_SUCCESS;
 
 out:
-	net_lwip_eth_stop();
+	net_lwip_stop(&net);
 
 	return ret;
 }
diff --git a/include/net-lwip.h b/include/net-lwip.h
index 8e59a2299e0..0d0394fce14 100644
--- a/include/net-lwip.h
+++ b/include/net-lwip.h
@@ -6,6 +6,35 @@
 #include <lwip/ip4.h>
 #include <lwip/netif.h>
 
+struct udevice;
+
+/**
+ * enum net_lwip_addr_mode - Initial address configuration for a client
+ * @NET_LWIP_ADDR_ENV: Configure the interface from the environment
+ * @NET_LWIP_ADDR_NONE: Start with an unconfigured IPv4 interface
+ */
+enum net_lwip_addr_mode {
+	NET_LWIP_ADDR_ENV,
+	NET_LWIP_ADDR_NONE,
+};
+
+/**
+ * struct net_lwip_ctx - Attachment to the shared lwIP runtime
+ * @dev: Ethernet device used by the runtime
+ * @netif: Shared lwIP network interface
+ * @addr_mode: Address mode requested by this client
+ *
+ * Clients must zero-initialize this structure before passing it to
+ * net_lwip_start(). Multiple active clients share @dev and @netif. A client
+ * must remove its callbacks and protocol control blocks before calling
+ * net_lwip_stop().
+ */
+struct net_lwip_ctx {
+	struct udevice *dev;
+	struct netif *netif;
+	enum net_lwip_addr_mode addr_mode;
+};
+
 /* HTTPS authentication mode */
 enum auth_mode {
 	AUTH_NONE,
@@ -34,13 +63,12 @@ static inline int eth_is_on_demand_init(void)
 int eth_init_state_only(void); /* Set active state */
 
 int net_lwip_dns_init(void);
-int net_lwip_eth_start(void);
-void net_lwip_eth_stop(void);
-struct netif *net_lwip_new_netif(struct udevice *udev);
-struct netif *net_lwip_new_netif_noip(struct udevice *udev);
-void net_lwip_remove_netif(struct netif *netif);
-struct netif *net_lwip_get_netif(void);
-int net_lwip_rx(struct udevice *udev, struct netif *netif);
+int net_lwip_start(struct net_lwip_ctx *ctx,
+		   enum net_lwip_addr_mode addr_mode);
+void net_lwip_stop(struct net_lwip_ctx *ctx);
+int net_lwip_restart(struct net_lwip_ctx *ctx);
+int net_lwip_refresh(struct net_lwip_ctx *ctx);
+int net_lwip_poll(void);
 int net_lwip_dns_resolve(char *name_or_ip, ip_addr_t *ip);
 
 /**
diff --git a/net/lwip/dhcp.c b/net/lwip/dhcp.c
index a5e2e7d4da0..0494e3981d5 100644
--- a/net/lwip/dhcp.c
+++ b/net/lwip/dhcp.c
@@ -11,7 +11,6 @@
 #include <lwip/apps/sntp.h>
 #include <lwip/dhcp.h>
 #include <lwip/dns.h>
-#include <lwip/timeouts.h>
 #include <net.h>
 #include <time.h>
 
@@ -22,34 +21,23 @@
 static char boot_file_name[DHCP_BOOT_FILE_LEN];
 #endif
 
-static void call_lwip_dhcp_fine_tmr(void *ctx)
-{
-	dhcp_fine_tmr();
-	sys_timeout(DHCP_FINE_TIMER_MSECS, call_lwip_dhcp_fine_tmr, NULL);
-}
-
-static int dhcp_loop(struct udevice *udev)
+static int dhcp_loop(struct net_lwip_ctx *net)
 {
 	char ipstr[] = "ipaddr\0\0\0";
 	char maskstr[] = "netmask\0\0\0";
 	char gwstr[] = "gatewayip\0\0\0";
 	const ip_addr_t *ntpserverip;
 	unsigned long start;
-	struct netif *netif;
 	struct dhcp *dhcp;
-	bool bound;
+	bool bound = false;
 	int idx;
 
-	idx = dev_seq(udev);
+	idx = dev_seq(net->dev);
 	if (idx < 0 || idx > 99) {
 		log_err("unexpected idx %d\n", idx);
 		return CMD_RET_FAILURE;
 	}
 
-	netif = net_lwip_new_netif_noip(udev);
-	if (!netif)
-		return CMD_RET_FAILURE;
-
 	/*
 	 * Request the DHCP stack to parse and store the NTP servers for
 	 * eventual use by the SNTP command
@@ -59,15 +47,13 @@ static int dhcp_loop(struct udevice *udev)
 
 	start = get_timer(0);
 
-	if (dhcp_start(netif))
+	if (dhcp_start(net->netif))
 		return CMD_RET_FAILURE;
 
-	call_lwip_dhcp_fine_tmr(NULL);
-
 	/* Wait for DHCP to complete */
 	do {
-		net_lwip_rx(udev, netif);
-		bound = dhcp_supplied_address(netif);
+		net_lwip_poll();
+		bound = dhcp_supplied_address(net->netif);
 		if (bound)
 			break;
 		if (ctrlc()) {
@@ -77,14 +63,10 @@ static int dhcp_loop(struct udevice *udev)
 		mdelay(1);
 	} while (get_timer(start) < DHCP_TIMEOUT_MS);
 
-	sys_untimeout(call_lwip_dhcp_fine_tmr, NULL);
-
-	if (!bound) {
-		net_lwip_remove_netif(netif);
+	if (!bound)
 		return CMD_RET_FAILURE;
-	}
 
-	dhcp = netif_dhcp_data(netif);
+	dhcp = netif_dhcp_data(net->netif);
 
 	env_set("bootfile", dhcp->boot_file_name);
 
@@ -123,26 +105,18 @@ static int dhcp_loop(struct udevice *udev)
 	printf("DHCP client bound to address %pI4 (%lu ms)\n",
 	       &dhcp->offered_ip_addr, get_timer(start));
 
-	net_lwip_remove_netif(netif);
 	return CMD_RET_SUCCESS;
 }
 
 int do_dhcp(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 {
+	struct net_lwip_ctx net = {};
 	int ret;
-	struct udevice *dev;
 
-	if (net_lwip_eth_start() < 0)
+	if (net_lwip_start(&net, NET_LWIP_ADDR_NONE))
 		return CMD_RET_FAILURE;
 
-	dev = eth_get_dev();
-	if (!dev) {
-		log_err("No network device\n");
-		ret = CMD_RET_FAILURE;
-		goto out;
-	}
-
-	ret = dhcp_loop(dev);
+	ret = dhcp_loop(&net);
 	if (ret)
 		goto out;
 
@@ -156,7 +130,14 @@ int do_dhcp(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 	ret = CMD_RET_SUCCESS;
 
 out:
-	net_lwip_eth_stop();
+	if (net.netif) {
+		if (dhcp_supplied_address(net.netif))
+			dhcp_stop_without_release(net.netif);
+		else
+			dhcp_release_and_stop(net.netif);
+		dhcp_cleanup(net.netif);
+	}
+	net_lwip_stop(&net);
 
 	return ret;
 }
diff --git a/net/lwip/dns.c b/net/lwip/dns.c
index b620b0611d6..15bc06797c2 100644
--- a/net/lwip/dns.c
+++ b/net/lwip/dns.c
@@ -34,24 +34,18 @@ static void dns_cb(const char *name, const ip_addr_t *ipaddr, void *arg)
 	ip_addr_set(&dns_cb_arg->host_ipaddr, ipaddr);
 }
 
-static int dns_loop(struct udevice *udev, const char *name, const char *var)
+static int dns_loop(struct net_lwip_ctx *net, const char *name,
+		    const char *var)
 {
 	struct dns_cb_arg dns_cb_arg = { };
-	struct netif *netif;
 	const char *ipstr;
 	ip_addr_t ipaddr;
 	ulong start;
 	int ret;
 
-	netif = net_lwip_new_netif(udev);
-	if (!netif)
+	if (net_lwip_dns_init())
 		return CMD_RET_FAILURE;
 
-	if (net_lwip_dns_init()) {
-		net_lwip_remove_netif(netif);
-		return CMD_RET_FAILURE;
-	}
-
 	dns_cb_arg.done = false;
 
 	ret = dns_gethostbyname(name, &ipaddr, dns_cb, &dns_cb_arg);
@@ -62,7 +56,7 @@ static int dns_loop(struct udevice *udev, const char *name, const char *var)
 		start = get_timer(0);
 		sys_timeout(DNS_RESEND_MS, do_dns_tmr, NULL);
 		do {
-			net_lwip_rx(udev, netif);
+			net_lwip_poll();
 			if (dns_cb_arg.done)
 				break;
 			if (ctrlc()) {
@@ -71,10 +65,9 @@ static int dns_loop(struct udevice *udev, const char *name, const char *var)
 			}
 		} while (get_timer(start) < DNS_TIMEOUT_MS);
 		sys_untimeout(do_dns_tmr, NULL);
+		dns_cancel(dns_cb, &dns_cb_arg);
 	}
 
-	net_lwip_remove_netif(netif);
-
 	if (dns_cb_arg.done && !ip_addr_isany(&dns_cb_arg.host_ipaddr)) {
 		ipstr = ipaddr_ntoa(&dns_cb_arg.host_ipaddr);
 		if (var)
@@ -89,6 +82,7 @@ static int dns_loop(struct udevice *udev, const char *name, const char *var)
 
 int do_dns(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 {
+	struct net_lwip_ctx net = {};
 	char *name;
 	char *var = NULL;
 	int ret;
@@ -101,12 +95,12 @@ int do_dns(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 	if (argc == 3)
 		var = argv[2];
 
-	if (net_lwip_eth_start() < 0)
+	if (net_lwip_start(&net, NET_LWIP_ADDR_ENV))
 		return CMD_RET_FAILURE;
 
-	ret = dns_loop(eth_get_dev(), name, var);
+	ret = dns_loop(&net, name, var);
 
-	net_lwip_eth_stop();
+	net_lwip_stop(&net);
 
 	return ret;
 }
diff --git a/net/lwip/net-lwip.c b/net/lwip/net-lwip.c
index 8f8f9d69020..4c012bfb1e3 100644
--- a/net/lwip/net-lwip.c
+++ b/net/lwip/net-lwip.c
@@ -31,7 +31,14 @@ void (*push_packet)(void *, int len) = 0;
 int net_try_count;
 static int net_restarted;
 int net_restart_wrap;
-static int net_lwip_eth_started;
+static struct {
+	struct udevice *dev;
+	struct netif *netif;
+	unsigned int users;
+	unsigned int env_users;
+	unsigned int no_addr_users;
+	bool polling;
+} net_lwip_runtime;
 static uchar net_pkt_buf[(PKTBUFSRX) * PKTSIZE_ALIGN + PKTALIGN]
 	__aligned(PKTALIGN);
 const u8 net_bcast_ethaddr[6] = { 0xff, 0xff, 0xff, 0xff, 0xff, 0xff };
@@ -107,19 +114,6 @@ static void eth_init_rings(void)
 		net_rx_packets[i] = net_pkt_buf + i  * PKTSIZE_ALIGN;
 }
 
-struct netif *net_lwip_get_netif(void)
-{
-	struct netif *netif, *found = NULL;
-
-	NETIF_FOREACH(netif) {
-		if (!found)
-			found = netif;
-		else
-			printf("Error: more than one netif in lwIP\n");
-	}
-	return found;
-}
-
 static int get_udev_ipv4_info(struct udevice *dev, ip4_addr_t *ip,
 			      ip4_addr_t *mask, ip4_addr_t *gw)
 {
@@ -196,19 +190,15 @@ int net_lwip_dns_init(void)
 /*
  * Initialize the network stack if needed and start the current device if valid
  */
-int net_lwip_eth_start(void)
+static int net_lwip_eth_start(void)
 {
 	int ret;
 
-	if (net_lwip_eth_started++ > 0)
-		return 0;
-
 	net_init();
 	eth_halt();
 	eth_set_current();
 	ret = eth_init();
 	if (ret < 0) {
-		net_lwip_eth_started--;
 		eth_halt();
 		return ret;
 	}
@@ -216,14 +206,8 @@ int net_lwip_eth_start(void)
 	return 0;
 }
 
-void net_lwip_eth_stop(void)
+static void net_lwip_eth_stop(void)
 {
-	if (!net_lwip_eth_started)
-		return;
-
-	if (--net_lwip_eth_started)
-		return;
-
 	eth_halt();
 }
 
@@ -243,8 +227,6 @@ static struct netif *new_netif(struct udevice *udev, bool with_ip)
 		return NULL;
 	}
 
-	netif_remove(net_lwip_get_netif());
-
 	ip4_addr_set_zero(&ip);
 	ip4_addr_set_zero(&mask);
 	ip4_addr_set_zero(&gw);
@@ -287,20 +269,188 @@ static struct netif *new_netif(struct udevice *udev, bool with_ip)
 	return netif;
 }
 
-struct netif *net_lwip_new_netif(struct udevice *udev)
+static void net_lwip_remove_netif(struct netif *netif)
 {
-	return new_netif(udev, true);
+	netif_remove(netif);
+	free(netif);
 }
 
-struct netif *net_lwip_new_netif_noip(struct udevice *udev)
+static int net_lwip_configure(enum net_lwip_addr_mode addr_mode)
 {
-	return new_netif(udev, false);
+	ip4_addr_t ip, mask, gw;
+
+	if (addr_mode == NET_LWIP_ADDR_ENV) {
+		if (get_udev_ipv4_info(net_lwip_runtime.dev, &ip, &mask, &gw))
+			return -EINVAL;
+	} else {
+		ip4_addr_set_zero(&ip);
+		ip4_addr_set_zero(&mask);
+		ip4_addr_set_zero(&gw);
+	}
+
+	if (!ip4_addr_cmp(netif_ip4_addr(net_lwip_runtime.netif), &ip) ||
+	    !ip4_addr_cmp(netif_ip4_netmask(net_lwip_runtime.netif), &mask) ||
+	    !ip4_addr_cmp(netif_ip4_gw(net_lwip_runtime.netif), &gw))
+		netif_set_addr(net_lwip_runtime.netif, &ip, &mask, &gw);
+
+	return 0;
 }
 
-void net_lwip_remove_netif(struct netif *netif)
+/**
+ * net_lwip_start - Attach a client to the shared lwIP runtime
+ * @ctx: Zero-initialized client attachment
+ * @addr_mode: Initial IPv4 address configuration requested by the client
+ *
+ * The first client starts the selected Ethernet device and creates the lwIP
+ * network interface. Later clients share both resources. Address-less clients
+ * take priority while active so DHCP can configure the shared interface.
+ *
+ * Return: 0 on success, or a negative error code.
+ */
+int net_lwip_start(struct net_lwip_ctx *ctx,
+		   enum net_lwip_addr_mode addr_mode)
 {
-	netif_remove(netif);
-	free(netif);
+	struct netif *netif;
+	int ret;
+
+	if (!ctx)
+		return -EINVAL;
+	if (ctx->netif || ctx->dev)
+		return -EBUSY;
+	if (addr_mode != NET_LWIP_ADDR_ENV &&
+	    addr_mode != NET_LWIP_ADDR_NONE)
+		return -EINVAL;
+
+	if (!net_lwip_runtime.users) {
+		ret = net_lwip_eth_start();
+		if (ret)
+			return ret;
+
+		net_lwip_runtime.dev = eth_get_dev();
+		netif = new_netif(net_lwip_runtime.dev,
+				  addr_mode == NET_LWIP_ADDR_ENV);
+		if (!netif) {
+			net_lwip_runtime.dev = NULL;
+			net_lwip_eth_stop();
+			return -ENODEV;
+		}
+		net_lwip_runtime.netif = netif;
+	} else if (addr_mode == NET_LWIP_ADDR_NONE &&
+		   !net_lwip_runtime.no_addr_users) {
+		ret = net_lwip_configure(NET_LWIP_ADDR_NONE);
+		if (ret)
+			return ret;
+	} else if (addr_mode == NET_LWIP_ADDR_ENV &&
+		   !net_lwip_runtime.no_addr_users) {
+		ret = net_lwip_configure(NET_LWIP_ADDR_ENV);
+		if (ret)
+			return ret;
+	}
+
+	net_lwip_runtime.users++;
+	if (addr_mode == NET_LWIP_ADDR_ENV)
+		net_lwip_runtime.env_users++;
+	else
+		net_lwip_runtime.no_addr_users++;
+
+	ctx->dev = net_lwip_runtime.dev;
+	ctx->netif = net_lwip_runtime.netif;
+	ctx->addr_mode = addr_mode;
+
+	return 0;
+}
+
+/**
+ * net_lwip_stop - Detach a client from the shared lwIP runtime
+ * @ctx: Active client attachment
+ *
+ * The final client removes the lwIP interface and stops Ethernet. When the
+ * last address-less client leaves, environment addressing is restored for
+ * any clients which remain attached. Callers must first remove every lwIP
+ * callback and protocol control block owned by @ctx. This function must not
+ * be called from a callback dispatched by net_lwip_poll().
+ */
+void net_lwip_stop(struct net_lwip_ctx *ctx)
+{
+	if (!ctx || ctx->netif != net_lwip_runtime.netif ||
+	    ctx->dev != net_lwip_runtime.dev || !net_lwip_runtime.users)
+		return;
+
+	if (ctx->addr_mode == NET_LWIP_ADDR_ENV)
+		net_lwip_runtime.env_users--;
+	else
+		net_lwip_runtime.no_addr_users--;
+	net_lwip_runtime.users--;
+
+	ctx->dev = NULL;
+	ctx->netif = NULL;
+
+	if (!net_lwip_runtime.users) {
+		net_lwip_remove_netif(net_lwip_runtime.netif);
+		net_lwip_runtime.netif = NULL;
+		net_lwip_runtime.dev = NULL;
+		net_lwip_eth_stop();
+		return;
+	}
+
+	if (!net_lwip_runtime.no_addr_users &&
+	    net_lwip_runtime.env_users &&
+	    net_lwip_configure(NET_LWIP_ADDR_ENV))
+		log_err("Failed to restore lwIP interface addressing\n");
+}
+
+/**
+ * net_lwip_restart - Restart an exclusively held lwIP runtime
+ * @ctx: Active client attachment
+ *
+ * Stop the current interface, select the next interface according to the
+ * normal network retry policy and attach @ctx to the replacement interface.
+ * A shared runtime cannot be restarted without disrupting other clients.
+ *
+ * Return: 0 on success, -EBUSY if other clients are attached, or another
+ * negative error code.
+ */
+int net_lwip_restart(struct net_lwip_ctx *ctx)
+{
+	enum net_lwip_addr_mode addr_mode;
+	int ret;
+
+	if (!ctx || ctx->netif != net_lwip_runtime.netif ||
+	    ctx->dev != net_lwip_runtime.dev || !net_lwip_runtime.users)
+		return -EINVAL;
+	if (net_lwip_runtime.users != 1)
+		return -EBUSY;
+
+	addr_mode = ctx->addr_mode;
+	net_lwip_stop(ctx);
+
+	ret = net_start_again();
+	if (ret)
+		return ret;
+
+	return net_lwip_start(ctx, addr_mode);
+}
+
+/**
+ * net_lwip_refresh - Refresh environment addressing for the shared interface
+ * @ctx: Active environment-addressed client attachment
+ *
+ * Address-less clients take priority, so refreshes are deferred until the
+ * last such client detaches.
+ *
+ * Return: 0 on success, or a negative error code.
+ */
+int net_lwip_refresh(struct net_lwip_ctx *ctx)
+{
+	if (!ctx || ctx->netif != net_lwip_runtime.netif ||
+	    ctx->dev != net_lwip_runtime.dev ||
+	    ctx->addr_mode != NET_LWIP_ADDR_ENV)
+		return -EINVAL;
+
+	if (net_lwip_runtime.no_addr_users)
+		return 0;
+
+	return net_lwip_configure(NET_LWIP_ADDR_ENV);
 }
 
 /*
@@ -343,7 +493,7 @@ static struct pbuf *alloc_pbuf_and_copy(uchar *data, int len)
 	return p;
 }
 
-int net_lwip_rx(struct udevice *udev, struct netif *netif)
+static int net_lwip_rx(struct udevice *udev, struct netif *netif)
 {
 	struct pbuf *pbuf;
 	uchar *packet;
@@ -387,6 +537,32 @@ int net_lwip_rx(struct udevice *udev, struct netif *netif)
 	return len;
 }
 
+/**
+ * net_lwip_poll - Service the shared lwIP runtime
+ *
+ * Run lwIP timers, schedule other U-Boot work and dispatch received packets
+ * to all registered lwIP protocol control blocks. Reentrant calls are rejected
+ * so protocol callbacks may safely invoke code which attempts to poll.
+ *
+ * Return: Receive status, -ENODEV with no active clients, or -EBUSY when a
+ * poll is already in progress.
+ */
+int net_lwip_poll(void)
+{
+	int ret;
+
+	if (!net_lwip_runtime.users)
+		return -ENODEV;
+	if (net_lwip_runtime.polling)
+		return -EBUSY;
+
+	net_lwip_runtime.polling = true;
+	ret = net_lwip_rx(net_lwip_runtime.dev, net_lwip_runtime.netif);
+	net_lwip_runtime.polling = false;
+
+	return ret;
+}
+
 /**
  * net_lwip_dns_resolve() - find IP address from name or IP
  *
diff --git a/net/lwip/nfs.c b/net/lwip/nfs.c
index 4cc36373fdd..2b7ee22ccc5 100644
--- a/net/lwip/nfs.c
+++ b/net/lwip/nfs.c
@@ -98,10 +98,9 @@ static int nfs_timeout_check(void)
 	return 1;
 }
 
-static int nfs_loop(struct udevice *udev, ulong addr, char *fname,
+static int nfs_loop(struct net_lwip_ctx *net, ulong addr, char *fname,
 		    ip_addr_t srvip)
 {
-	struct netif *netif;
 	int ret;
 
 	nfs_download_state = NETLOOP_FAIL;
@@ -110,16 +109,12 @@ static int nfs_loop(struct udevice *udev, ulong addr, char *fname,
 	if (!fname || addr == 0)
 		return -1;
 
-	netif = net_lwip_new_netif(udev);
-	if (!netif)
-		return -1;
-
 	strlcpy(nfs_path_buff, fname, sizeof(nfs_path_buff));
 
 	nfs_filename = nfs_basename(nfs_path_buff);
 	nfs_path     = nfs_dirname(nfs_path_buff);
 
-	printf("Using %s device\n", udev->name);
+	printf("Using %s device\n", net->dev->name);
 
 	printf("File transfer via NFS from server %s; our IP address is %s\n",
 	       ipaddr_ntoa(&srvip), env_get("ipaddr"));
@@ -139,7 +134,6 @@ static int nfs_loop(struct udevice *udev, ulong addr, char *fname,
 
 	ret = nfs_udp_init(&sess_ctx);
 	if (ret < 0) {
-		net_lwip_remove_netif(netif);
 		debug("Failed to init network interface, aborting for error = %d\n", ret);
 		return ret;
 	}
@@ -152,7 +146,7 @@ static int nfs_loop(struct udevice *udev, ulong addr, char *fname,
 
 	timer_start = get_timer(0);
 	do {
-		net_lwip_rx(udev, netif);
+		net_lwip_poll();
 		if (net_state != NETLOOP_CONTINUE)
 			break;
 		if (ctrlc()) {
@@ -165,7 +159,8 @@ static int nfs_loop(struct udevice *udev, ulong addr, char *fname,
 	} while (true);
 	debug("%s: Loop exit at %lu\n", __func__, get_timer(0));
 
-	net_lwip_remove_netif(netif);
+	udp_remove(sess_ctx.pcb);
+	sess_ctx.pcb = NULL;
 
 	if (net_state == NETLOOP_SUCCESS) {
 		ret = 0;
@@ -186,8 +181,8 @@ static int nfs_loop(struct udevice *udev, ulong addr, char *fname,
 
 int do_nfs(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 {
+	struct net_lwip_ctx net = {};
 	int ret = CMD_RET_SUCCESS;
-	bool started = false;
 	char *arg = NULL;
 	char *words[2] = { };
 	char *fname = NULL;
@@ -278,17 +273,15 @@ int do_nfs(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 		goto out;
 	}
 
-	if (net_lwip_eth_start() < 0) {
+	if (net_lwip_start(&net, NET_LWIP_ADDR_ENV)) {
 		ret = CMD_RET_FAILURE;
 		goto out;
 	}
-	started = true;
 
-	if (nfs_loop(eth_get_dev(), laddr, fname, srvip) < 0)
+	if (nfs_loop(&net, laddr, fname, srvip) < 0)
 		ret = CMD_RET_FAILURE;
 out:
-	if (started)
-		net_lwip_eth_stop();
+	net_lwip_stop(&net);
 	if (arg != net_boot_file_name)
 		free(arg);
 	return ret;
diff --git a/net/lwip/tftp.c b/net/lwip/tftp.c
index d6a9f29a260..59bae93ab35 100644
--- a/net/lwip/tftp.c
+++ b/net/lwip/tftp.c
@@ -226,11 +226,10 @@ static void no_response(void *arg)
 	ctx->done = FAILURE;
 }
 
-static int tftp_loop(struct udevice *udev, ulong addr, char *fname,
+static int tftp_loop(struct net_lwip_ctx *net, ulong addr, char *fname,
 		     ip_addr_t srvip, uint16_t srvport)
 {
 	int blksize = CONFIG_TFTP_BLOCKSIZE;
-	struct netif *netif;
 	struct tftp_ctx ctx;
 	const char *ep;
 	err_t err;
@@ -241,10 +240,6 @@ static int tftp_loop(struct udevice *udev, ulong addr, char *fname,
 	if (!srvport)
 		srvport = TFTP_PORT;
 
-	netif = net_lwip_new_netif(udev);
-	if (!netif)
-		return -1;
-
 	ctx.done = NOT_DONE;
 	ctx.size = 0;
 	ctx.block_count = 0;
@@ -254,7 +249,7 @@ static int tftp_loop(struct udevice *udev, ulong addr, char *fname,
 	ctx.wrq_accepted = false;
 	ctx.fname[0] = '\0';
 
-	printf("Using %s device\n", udev->name);
+	printf("Using %s device\n", net->dev->name);
 	printf("TFTP from server %s; our IP address is %s\n",
 	       ipaddr_ntoa(&srvip), env_get("ipaddr"));
 	printf("Filename '%s'.\n", fname);
@@ -262,8 +257,10 @@ static int tftp_loop(struct udevice *udev, ulong addr, char *fname,
 	printf("Loading: ");
 
 	err = tftp_init_client(&tftp_context);
-	if (!(err == ERR_OK || err == ERR_USE))
+	if (err != ERR_OK) {
 		log_err("tftp_init_client err: %d\n", err);
+		return -1;
+	}
 
 	ep = env_get("tftpblocksize");
 	if (ep)
@@ -275,13 +272,13 @@ static int tftp_loop(struct udevice *udev, ulong addr, char *fname,
 	/* might return different errors, like routing problems */
 	if (err != ERR_OK) {
 		printf("tftp_get() error %d\n", err);
-		net_lwip_remove_netif(netif);
+		tftp_cleanup();
 		return -1;
 	}
 
 	sys_timeout(NO_RSP_TIMEOUT_MS, no_response, &ctx);
 	while (!ctx.done) {
-		net_lwip_rx(udev, netif);
+		net_lwip_poll();
 		if (ctrlc()) {
 			printf("\nAbort\n");
 			ctx.done = ABORTED;
@@ -292,8 +289,6 @@ static int tftp_loop(struct udevice *udev, ulong addr, char *fname,
 
 	tftp_cleanup();
 
-	net_lwip_remove_netif(netif);
-
 	if (ctx.done == SUCCESS) {
 		if (env_set_hex("fileaddr", addr)) {
 			log_err("fileaddr not updated\n");
@@ -318,9 +313,8 @@ static void no_request(void *arg)
 	ctx->done = FAILURE;
 }
 
-static int tftpsrv_loop(struct udevice *udev, ulong addr)
+static int tftpsrv_loop(struct net_lwip_ctx *net, ulong addr)
 {
-	struct netif *netif;
 	struct tftp_ctx ctx;
 	const char *ipaddr;
 	int ret = -1;
@@ -335,16 +329,12 @@ static int tftpsrv_loop(struct udevice *udev, ulong addr)
 		return -1;
 	}
 
-	netif = net_lwip_new_netif(udev);
-	if (!netif)
-		return -1;
-
 	memset(&ctx, 0, sizeof(ctx));
 	ctx.done = NOT_DONE;
 	ctx.daddr = addr;
 	ctx.is_server = true;
 
-	printf("Using %s device\n", udev->name);
+	printf("Using %s device\n", net->dev->name);
 	printf("Listening for TFTP transfer on %s\n", ipaddr);
 	printf("Load address: 0x%lx\n", ctx.daddr);
 
@@ -352,13 +342,13 @@ static int tftpsrv_loop(struct udevice *udev, ulong addr)
 	err = tftp_init_server(&tftp_context);
 	if (err != ERR_OK) {
 		log_err("tftp_init_server err: %d\n", err);
-		goto out_remove_netif;
+		goto out;
 	}
 
 	ctx.start_time = get_timer(0);
 	sys_timeout(TFTPSRV_LISTEN_TIMEOUT_MS, no_request, &ctx);
 	while (!ctx.done) {
-		net_lwip_rx(udev, netif);
+		net_lwip_poll();
 		if (ctrlc()) {
 			printf("\nAbort\n");
 			ctx.done = ABORTED;
@@ -373,22 +363,22 @@ static int tftpsrv_loop(struct udevice *udev, ulong addr)
 	if (ctx.done == SUCCESS) {
 		if (env_set_hex("fileaddr", addr)) {
 			log_err("fileaddr not updated\n");
-			goto out_remove_netif;
+			goto out;
 		}
 		efi_set_bootdev("Net", "", ctx.fname, map_sysmem(addr, 0),
 				ctx.size);
 		ret = 0;
 	}
 
-out_remove_netif:
+out:
 	tftpsrv_active_ctx = NULL;
-	net_lwip_remove_netif(netif);
 
 	return ret;
 }
 
 int do_tftpsrv(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 {
+	struct net_lwip_ctx net = {};
 	int ret = CMD_RET_SUCCESS;
 	char *end;
 	ulong laddr;
@@ -421,25 +411,25 @@ int do_tftpsrv(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 		goto out;
 	}
 
-	if (net_lwip_eth_start() < 0) {
+	if (net_lwip_start(&net, NET_LWIP_ADDR_ENV)) {
 		ret = CMD_RET_FAILURE;
 		goto out;
 	}
 
-	if (tftpsrv_loop(eth_get_dev(), laddr) < 0)
+	if (tftpsrv_loop(&net, laddr) < 0)
 		ret = CMD_RET_FAILURE;
 	else
 		image_load_addr = laddr;
-	net_lwip_eth_stop();
 
 out:
+	net_lwip_stop(&net);
 	return ret;
 }
 
 int do_tftpb(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 {
+	struct net_lwip_ctx net = {};
 	int ret = CMD_RET_SUCCESS;
-	bool started = false;
 	char *arg = NULL;
 	char *words[3] = { };
 	char *fname = NULL;
@@ -540,19 +530,17 @@ int do_tftpb(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 		goto out;
 	}
 
-	if (net_lwip_eth_start() < 0) {
+	if (net_lwip_start(&net, NET_LWIP_ADDR_ENV)) {
 		ret = CMD_RET_FAILURE;
 		goto out;
 	}
-	started = true;
 
-	if (tftp_loop(eth_get_dev(), laddr, fname, srvip, port) < 0)
+	if (tftp_loop(&net, laddr, fname, srvip, port) < 0)
 		ret = CMD_RET_FAILURE;
 	else
 		image_load_addr = laddr;
 out:
-	if (started)
-		net_lwip_eth_stop();
+	net_lwip_stop(&net);
 	if (arg != net_boot_file_name)
 		free(arg);
 	return ret;
diff --git a/net/lwip/wget.c b/net/lwip/wget.c
index e8930da410b..c9af3c7420f 100644
--- a/net/lwip/wget.c
+++ b/net/lwip/wget.c
@@ -39,6 +39,7 @@ struct wget_ctx {
 	ulong content_len;
 	ulong hash_count;
 	enum done_state done;
+	bool aborted;
 };
 
 static void wget_lwip_fill_info(struct pbuf *hdr, u16_t hdr_len, u32_t hdr_cont_len)
@@ -229,6 +230,10 @@ static void httpc_result_cb(void *arg, httpc_result_t httpc_result,
 		ctx->done = FAILURE;
 		return;
 	}
+	if (httpc_result == HTTPC_RESULT_LOCAL_ABORT && ctx->aborted) {
+		ctx->done = FAILURE;
+		return;
+	}
 
 	if (httpc_result != HTTPC_RESULT_OK) {
 		log_err("\nHTTP client error %d\n", httpc_result);
@@ -293,13 +298,15 @@ static err_t httpc_headers_done_cb(httpc_state_t *connection, void *arg, struct
 #endif
 
 static int wget_handle_request(struct wget_ctx *ctx, bool is_https,
-			       struct udevice *udev, struct netif *netif)
+			       struct net_lwip_ctx *net)
 {
 #if CONFIG_IS_ENABLED(WGET_HTTPS)
+	struct altcp_tls_config *tls_config = NULL;
 	altcp_allocator_t tls_allocator;
 #endif
 	httpc_connection_t conn;
 	httpc_state_t *state;
+	err_t err;
 	int ret;
 
 	/* if URL with hostname init dns */
@@ -348,11 +355,11 @@ static int wget_handle_request(struct wget_ctx *ctx, bool is_https,
 			printf("HTTPS connections not authenticated\n");
 		}
 		tls_allocator.alloc = &altcp_tls_alloc;
-		tls_allocator.arg =
-			altcp_tls_create_config_client(ca, ca_sz,
-						       ctx->server_name);
+		tls_config = altcp_tls_create_config_client(ca, ca_sz,
+							    ctx->server_name);
+		tls_allocator.arg = tls_config;
 
-		if (!tls_allocator.arg) {
+		if (!tls_config) {
 			log_err("error: Cannot create a TLS connection\n");
 			return -ENODEV;
 		}
@@ -363,33 +370,44 @@ static int wget_handle_request(struct wget_ctx *ctx, bool is_https,
 
 	conn.result_fn = httpc_result_cb;
 	conn.headers_done_fn = httpc_headers_done_cb;
-	if (httpc_get_file_dns(ctx->server_name, ctx->port, ctx->path, &conn,
-			       httpc_recv_cb, ctx, &state)) {
-		return -ENODEV;
+	err = httpc_get_file_dns(ctx->server_name, ctx->port, ctx->path, &conn,
+				 httpc_recv_cb, ctx, &state);
+	if (err) {
+		ret = -ENODEV;
+		goto out;
 	}
 
 	errno = 0;
 
 	while (!ctx->done) {
-		net_lwip_rx(udev, netif);
-		if (ctrlc())
+		net_lwip_poll();
+		if (!ctx->done && ctrlc()) {
+			ctx->aborted = true;
+			httpc_abort(state);
 			break;
+		}
 	}
 
-	if (ctx->done == SUCCESS)
-		return 0;
-
-	if (errno == EPERM && !wget_info->silent)
-		printf("Certificate verification failed\n");
+	if (ctx->done == SUCCESS) {
+		ret = 0;
+	} else {
+		if (errno == EPERM && !wget_info->silent)
+			printf("Certificate verification failed\n");
+		ret = -errno ?: -EIO;
+	}
 
-	return -errno ?: -EIO;
+out:
+#if CONFIG_IS_ENABLED(WGET_HTTPS)
+	if (tls_config)
+		altcp_tls_free_config(tls_config);
+#endif
+	return ret;
 }
 
 int wget_do_request(ulong dst_addr, char *uri)
 {
-	struct udevice *udev;
+	struct net_lwip_ctx net = {};
 	struct wget_ctx ctx;
-	struct netif *netif;
 	bool is_https;
 	int ret;
 
@@ -401,30 +419,22 @@ int wget_do_request(ulong dst_addr, char *uri)
 	ctx.start_time = 0;
 	ctx.content_len = 0;
 	ctx.hash_count = 0;
+	ctx.aborted = false;
 
 	ret = parse_url(uri, ctx.server_name, &ctx.port, &ctx.path, &is_https);
 	if (ret)
 		return ret;
 
-	ret = net_lwip_eth_start();
+	ret = net_lwip_start(&net, NET_LWIP_ADDR_ENV);
 	if (ret)
 		return ret;
 
 	if (!wget_info)
 		wget_info = &default_wget_info;
 
-	udev = eth_get_dev();
-
-	netif = net_lwip_new_netif(udev);
-	if (!netif) {
-		net_lwip_eth_stop();
-		return -ENODEV;
-	}
-
-	ret = wget_handle_request(&ctx, is_https, udev, netif);
+	ret = wget_handle_request(&ctx, is_https, &net);
 
-	net_lwip_remove_netif(netif);
-	net_lwip_eth_stop();
+	net_lwip_stop(&net);
 
 	return ret;
 }

-- 
2.53.0

