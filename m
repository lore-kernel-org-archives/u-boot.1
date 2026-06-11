Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B4B2CD98C7
	for <u-boot@archiver.kernel.org>; Thu, 11 Jun 2026 23:37:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 212AA84895;
	Fri, 12 Jun 2026 01:37:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=baylibre.com header.i=@baylibre.com header.b="TqYjPjAF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 75AB784717; Fri, 12 Jun 2026 01:36:58 +0200 (CEST)
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com
 [IPv6:2607:f8b0:4864:20::235])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 259CB8056B
 for <u-boot@lists.denx.de>; Fri, 12 Jun 2026 01:36:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-oi1-x235.google.com with SMTP id
 5614622812f47-486852c7b68so308129b6e.2
 for <u-boot@lists.denx.de>; Thu, 11 Jun 2026 16:36:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1781221015; x=1781825815; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=F+Fsufhuqx1SjDusP8LkiAfMSyv9ZUXLaDr0/tg4SEY=;
 b=TqYjPjAFJByUksWpBYPOv2rF4kpU/f+YwiXnmeNTGuCnFFkK4LDQBWaaWgJBFTG235
 Zsj5zr6FJQV94AQIybS2/mDTfbUj1ln9HUclkZll1u4z2R3RIQ72J2ocJ0lKdDI+Afwa
 +SVw4yYdteH0G83GG86R4HLETR6GVH6Xcs4SH3/1EN63lb3yrgx9biW6BfppPFNhXE8Z
 qF3cHgrY/Gcs6ILeR0ky0EkdSkDVzkTI6fh/yxwYkdTeHFQGRET+EaB6/h8cy+aCzXv2
 WJdgPC7VFG95ZnBk8+ut0NIShFDKSKlibD6DyvQ0gbIKP0E6oFkQRkta+CqkJRDUFKTj
 NDOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781221015; x=1781825815;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=F+Fsufhuqx1SjDusP8LkiAfMSyv9ZUXLaDr0/tg4SEY=;
 b=Sx456RbWXpq0UNqiW6RSjAocHY3MyZhOiPOz//G1CWGHdANBARI51ylNiUsqXTZrNP
 jLANh/gtl/fiViVrFo0jzhzLKXcAVl12ECCkb+3cvmrglG5Q8BkW4wZYRHvauQ7d0Sxa
 3R9F7+s8kBiL1ij64IyIfiJMN6e1SzX+gcD6jVolpxKBt4fIbxNUhd7I+l+vYHatVIiW
 E9IzNTa6uPRt/Lb6y96wC+VvBJxWz628x3rhABqsp5WoyvUxno8sGuc0vHidc+i4u5MF
 vmpQAqMSJOJ4i6D3A/GMeuyWZ6YqRyXa4IgVcbF73a4x6osvYZep+bEGI7WGeWshPiUb
 2Srw==
X-Forwarded-Encrypted: i=1;
 AFNElJ+bgL64GVeQnI89FRLQlerN4OE0vnlRDPi5PGXA1uL7C1Wi2HdXayXw2lq4i1fg2e2ddEno46I=@lists.denx.de
X-Gm-Message-State: AOJu0YyHZkyC55/4q6EQ4wTLmy9dcgc4zM978aU+5iWFSsitmlXnSUzg
 tYYzmwPQxszq4N6dm+eEzA8mNScWSTmgy5KyYMyyqn7g1PJYfUZ1TI5pu7gkUJyYO6o=
X-Gm-Gg: Acq92OFnnpU1O6YIsY8ZYNFHxpQ7Vojh3mRFBhiqQN1Zu9WtYce9spTrD2EUURrt/21
 p2y8jDukvAeDE0a5GJRnxA2gpZxqSKvsTty+d+LsH2N3Y3U8Roblgxs5jmb9lJ69BD+eMwN1TAX
 9NaPGxfrvwPKKqrtgNr6nHhqh2PoTQzheRy3/Lte94PL7brBIMeRiSzg9Oct1TUD9aqVdMzOroi
 FVv8QgKvs0sf4zjdNvWGK3f2DF03aTv5GImnYioWN0fnRzhWXCZGpBFFKuSxecx6NcS7ehME2/R
 W3LmiBu98JWQqbPPZMQsDGtwfLbld40BiAQibuYdUiCmLBw9y0amG1XoG95AfEoSL90M+4740Td
 i31D44Z6XmOI7i24RyRsiToP/OvEj3KFcWOJBg1ZSjrzCX3dve0LcsvZny96gwbvdTIm9+9IMsj
 zJDGu2l7Jrvth4aJi7ddNRdo3jHRo=
X-Received: by 2002:a05:6808:30aa:b0:485:7c5a:63aa with SMTP id
 5614622812f47-4872f391019mr428003b6e.5.1781221014871; 
 Thu, 11 Jun 2026 16:36:54 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:cba0:23d4:353:6048])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e78144822dsm660346a34.2.2026.06.11.16.36.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jun 2026 16:36:54 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Thu, 11 Jun 2026 18:36:10 -0500
Subject: [PATCH v3 3/3] net: lwip: introduce net_lwip_eth_stop() function
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260611-net-lwip-add-stop-function-v3-3-8849948fd9c3@baylibre.com>
References: <20260611-net-lwip-add-stop-function-v3-0-8849948fd9c3@baylibre.com>
In-Reply-To: <20260611-net-lwip-add-stop-function-v3-0-8849948fd9c3@baylibre.com>
To: Jerome Forissier <jerome.forissier@arm.com>, 
 Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Julien Stephan <jstephan@baylibre.com>, u-boot@lists.denx.de, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=7675; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=xpRHzMSLOOP5yURr/xIbKlXUmUAij5HfAlM+uDV12oY=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBqK0aKQlMtAsIedgEr1wimu5Fx3arBGP5LL6n5Y
 2508yTph82JAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaitGihYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/ABpwH/14Kfclkm5nsSN/6wQwWaXLMMHvu+W1JBnQt+iy
 gQ3HmhhO7BXnRv2Jzjh/cdZV1Wk3j90G/vLygSuQ/o0Ug2MnjmAjUARW3hqtmS0b+wgi4STL9mq
 c+khyuph5ERf8xQHNtdiTzpKUvD6uIMKANh5qA/FS8gNZDG1GdOytzRMKlN4gJ3/TkdjH9upD6n
 sG6wYgTmCayYA1k+rVh2PTh0nJayZhVofxTvYXZ8Won8vdf7iT/FAc6RM2Bmto+oAP9VGIzTIF+
 3C0U8v2p/iwOCh00Omt3GDNYzjeSCqEVug7SYZfqg/QBqt2Oz2sAFGXWA1muBvhjfEgiNUxYvQm
 8IoE=
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

Add a introduce net_lwip_eth_stop() function and use that to stop the
network interface after each command that uses the network.

This makes the behavior the same as the legacy net code and avoids
potential issues with the network interface being left in an active
state after a command finishes.

The start/stop is reference-counted since there is at least one command
(dhcp) that calls another command (tftp) to avoid starting and stopping
the network interface multiple times in a single command.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 cmd/lwip/ping.c     | 19 +++++++++++--------
 cmd/lwip/sntp.c     | 10 ++++++++--
 include/net-lwip.h  |  1 +
 net/lwip/dhcp.c     | 15 +++++++++++----
 net/lwip/dns.c      |  7 ++++++-
 net/lwip/net-lwip.c | 16 ++++++++++++++++
 net/lwip/nfs.c      |  4 ++++
 net/lwip/tftp.c     |  4 ++++
 net/lwip/wget.c     |  5 ++++-
 9 files changed, 65 insertions(+), 16 deletions(-)

diff --git a/cmd/lwip/ping.c b/cmd/lwip/ping.c
index fc4cf7bde5f..98fa8e22bce 100644
--- a/cmd/lwip/ping.c
+++ b/cmd/lwip/ping.c
@@ -163,6 +163,7 @@ static int ping_loop(struct udevice *udev, const ip_addr_t *addr)
 int do_ping(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 {
 	ip_addr_t addr;
+	int ret;
 
 	if (argc < 2)
 		return CMD_RET_USAGE;
@@ -171,13 +172,15 @@ int do_ping(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 		return CMD_RET_USAGE;
 
 	net_try_count = 1;
-restart:
-	if (net_lwip_eth_start() < 0 || ping_loop(eth_get_dev(), &addr) < 0) {
-		if (net_start_again() == 0)
-			goto restart;
-		else
-			return CMD_RET_FAILURE;
-	}
 
-	return CMD_RET_SUCCESS;
+	do {
+		if (net_lwip_eth_start() == 0) {
+			ret = ping_loop(eth_get_dev(), &addr);
+			net_lwip_eth_stop();
+			if (ret == 0)
+				return CMD_RET_SUCCESS;
+		}
+	} while (net_start_again() == 0);
+
+	return CMD_RET_FAILURE;
 }
diff --git a/cmd/lwip/sntp.c b/cmd/lwip/sntp.c
index 608345c873b..5fa400b104a 100644
--- a/cmd/lwip/sntp.c
+++ b/cmd/lwip/sntp.c
@@ -101,6 +101,7 @@ int do_sntp(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 	ip_addr_t *srvip;
 	char *server;
 	ip_addr_t ipaddr;
+	int ret = CMD_RET_FAILURE;
 
 	switch (argc) {
 	case 1:
@@ -127,7 +128,12 @@ int do_sntp(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 		return CMD_RET_FAILURE;
 
 	if (sntp_loop(eth_get_dev(), srvip) < 0)
-		return CMD_RET_FAILURE;
+		goto out;
+
+	ret = CMD_RET_SUCCESS;
+
+out:
+	net_lwip_eth_stop();
 
-	return CMD_RET_SUCCESS;
+	return ret;
 }
diff --git a/include/net-lwip.h b/include/net-lwip.h
index 20cb0992cce..5d0627eb271 100644
--- a/include/net-lwip.h
+++ b/include/net-lwip.h
@@ -35,6 +35,7 @@ int eth_init_state_only(void); /* Set active state */
 
 int net_lwip_dns_init(void);
 int net_lwip_eth_start(void);
+void net_lwip_eth_stop(void);
 struct netif *net_lwip_new_netif(struct udevice *udev);
 struct netif *net_lwip_new_netif_noip(struct udevice *udev);
 void net_lwip_remove_netif(struct netif *netif);
diff --git a/net/lwip/dhcp.c b/net/lwip/dhcp.c
index acdf601d7eb..18dc36ae7ca 100644
--- a/net/lwip/dhcp.c
+++ b/net/lwip/dhcp.c
@@ -138,18 +138,25 @@ int do_dhcp(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 	dev = eth_get_dev();
 	if (!dev) {
 		log_err("No network device\n");
-		return CMD_RET_FAILURE;
+		ret = CMD_RET_FAILURE;
+		goto out;
 	}
 
 	ret = dhcp_loop(dev);
 	if (ret)
-		return ret;
+		goto out;
 
 	if (argc > 1) {
 		struct cmd_tbl cmdtp = {};
 
-		return do_tftpb(&cmdtp, 0, argc, argv);
+		ret = do_tftpb(&cmdtp, 0, argc, argv);
+		goto out;
 	}
 
-	return CMD_RET_SUCCESS;
+	ret = CMD_RET_SUCCESS;
+
+out:
+	net_lwip_eth_stop();
+
+	return ret;
 }
diff --git a/net/lwip/dns.c b/net/lwip/dns.c
index 8b7b3b7f970..b620b0611d6 100644
--- a/net/lwip/dns.c
+++ b/net/lwip/dns.c
@@ -91,6 +91,7 @@ int do_dns(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 {
 	char *name;
 	char *var = NULL;
+	int ret;
 
 	if (argc == 1 || argc > 3)
 		return CMD_RET_USAGE;
@@ -103,5 +104,9 @@ int do_dns(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 	if (net_lwip_eth_start() < 0)
 		return CMD_RET_FAILURE;
 
-	return dns_loop(eth_get_dev(), name, var);
+	ret = dns_loop(eth_get_dev(), name, var);
+
+	net_lwip_eth_stop();
+
+	return ret;
 }
diff --git a/net/lwip/net-lwip.c b/net/lwip/net-lwip.c
index 0c83c004cab..cfe5a6a640d 100644
--- a/net/lwip/net-lwip.c
+++ b/net/lwip/net-lwip.c
@@ -31,6 +31,7 @@ void (*push_packet)(void *, int len) = 0;
 int net_try_count;
 static int net_restarted;
 int net_restart_wrap;
+static int net_lwip_eth_started;
 static uchar net_pkt_buf[(PKTBUFSRX) * PKTSIZE_ALIGN + PKTALIGN]
 	__aligned(PKTALIGN);
 const u8 net_bcast_ethaddr[6] = { 0xff, 0xff, 0xff, 0xff, 0xff, 0xff };
@@ -180,11 +181,15 @@ int net_lwip_eth_start(void)
 {
 	int ret;
 
+	if (net_lwip_eth_started++ > 0)
+		return 0;
+
 	net_init();
 	eth_halt();
 	eth_set_current();
 	ret = eth_init();
 	if (ret < 0) {
+		net_lwip_eth_started--;
 		eth_halt();
 		return ret;
 	}
@@ -192,6 +197,17 @@ int net_lwip_eth_start(void)
 	return 0;
 }
 
+void net_lwip_eth_stop(void)
+{
+	if (!net_lwip_eth_started)
+		return;
+
+	if (--net_lwip_eth_started)
+		return;
+
+	eth_halt();
+}
+
 static struct netif *new_netif(struct udevice *udev, bool with_ip)
 {
 	unsigned char enetaddr[ARP_HLEN];
diff --git a/net/lwip/nfs.c b/net/lwip/nfs.c
index 9e6b801e465..4cc36373fdd 100644
--- a/net/lwip/nfs.c
+++ b/net/lwip/nfs.c
@@ -187,6 +187,7 @@ static int nfs_loop(struct udevice *udev, ulong addr, char *fname,
 int do_nfs(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 {
 	int ret = CMD_RET_SUCCESS;
+	bool started = false;
 	char *arg = NULL;
 	char *words[2] = { };
 	char *fname = NULL;
@@ -281,10 +282,13 @@ int do_nfs(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 		ret = CMD_RET_FAILURE;
 		goto out;
 	}
+	started = true;
 
 	if (nfs_loop(eth_get_dev(), laddr, fname, srvip) < 0)
 		ret = CMD_RET_FAILURE;
 out:
+	if (started)
+		net_lwip_eth_stop();
 	if (arg != net_boot_file_name)
 		free(arg);
 	return ret;
diff --git a/net/lwip/tftp.c b/net/lwip/tftp.c
index 7f3b28b8507..571c38172f9 100644
--- a/net/lwip/tftp.c
+++ b/net/lwip/tftp.c
@@ -261,6 +261,7 @@ static int tftp_loop(struct udevice *udev, ulong addr, char *fname,
 int do_tftpb(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 {
 	int ret = CMD_RET_SUCCESS;
+	bool started = false;
 	char *arg = NULL;
 	char *words[3] = { };
 	char *fname = NULL;
@@ -365,12 +366,15 @@ int do_tftpb(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 		ret = CMD_RET_FAILURE;
 		goto out;
 	}
+	started = true;
 
 	if (tftp_loop(eth_get_dev(), laddr, fname, srvip, port) < 0)
 		ret = CMD_RET_FAILURE;
 	else
 		image_load_addr = laddr;
 out:
+	if (started)
+		net_lwip_eth_stop();
 	if (arg != net_boot_file_name)
 		free(arg);
 	return ret;
diff --git a/net/lwip/wget.c b/net/lwip/wget.c
index 3a0b0dca145..247ece18e2b 100644
--- a/net/lwip/wget.c
+++ b/net/lwip/wget.c
@@ -416,12 +416,15 @@ int wget_do_request(ulong dst_addr, char *uri)
 	udev = eth_get_dev();
 
 	netif = net_lwip_new_netif(udev);
-	if (!netif)
+	if (!netif) {
+		net_lwip_eth_stop();
 		return -ENODEV;
+	}
 
 	ret = wget_handle_request(&ctx, is_https, udev, netif);
 
 	net_lwip_remove_netif(netif);
+	net_lwip_eth_stop();
 
 	return ret;
 }

-- 
2.43.0

