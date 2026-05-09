Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5570CD3445
	for <u-boot@archiver.kernel.org>; Sat,  9 May 2026 17:36:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0D591846DB;
	Sat,  9 May 2026 19:36:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="oit5TgFO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9DE2084704; Sat,  9 May 2026 19:36:45 +0200 (CEST)
Received: from mail-oo1-xc30.google.com (mail-oo1-xc30.google.com
 [IPv6:2607:f8b0:4864:20::c30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D49D5846A1
 for <u-boot@lists.denx.de>; Sat,  9 May 2026 19:36:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-oo1-xc30.google.com with SMTP id
 006d021491bc7-6948fb494a0so1645401eaf.2
 for <u-boot@lists.denx.de>; Sat, 09 May 2026 10:36:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1778348201; x=1778953001;
 darn=lists.denx.de; 
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=TBNoMXVj46NlC0Oq0D46knfW2WqhL5eqCDqOyrkJGrM=;
 b=oit5TgFO0MT5c7vB+A23sxVStEQQ82/+j49TpPDehzpJZQ9jDDlYhk90K4hQWu8ZJZ
 8aqIAtuAvarKIwiBqtEoLebFGh0BbqORvXUonU5a+rbzQHymXp5ES/AirjEu9+mv/l3A
 HkmGNPgE8wH5P7C5QKD/4gAqijxLqznOi7x/8Y718x32AA9ipKzdPm25j6/5ozujmHIB
 ZS9zkRr4HIG0wTAVkH/BrxcNk5vBRPlWjvlro+Tm8SkXS4al/3bTux4IoVA0GZ8gH4Bs
 tmPBA/WYwyMP5UAIFnQh+BRm1PSR4uM5Nd8omBkyUaXoJo0jGPMQZVqol7MwmRtz3egX
 Jy5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778348201; x=1778953001;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TBNoMXVj46NlC0Oq0D46knfW2WqhL5eqCDqOyrkJGrM=;
 b=Mtfsr0gZJaVKydccILiIT7wc1lWi+y2o7X9S+ENPoj2aY4yWO9YLrmJgqpBUNVpgyd
 9kbkMgnNDEh5iGGtkxDeBoAEY5S3IIpIbE9FSpmqv74hV2uTvm8z9k3LPW4EjiJEPYcp
 m8PEtpVsUxxf1WIKOqu6KVveW05AC23XGPm2XK2eUqyjg2dDF+dLl1dW9+fsTHZibc1E
 6PdxphzctMGzYLVxw/0M9fRW/PTpWvwx3eokfg4ATbTjfk0CjxBhSDjAgwF/HM4KTRbP
 CHjF75uugYsrMcaHu83T551WRw1yl4K54hRce8kYtltx/lV09LQxpFo5IFN/KwfSL/SG
 G9DA==
X-Forwarded-Encrypted: i=1;
 AFNElJ/YnqmzTg5GwFp+oJXaixSzhqyZ7CEgwZE5dhLWTjghDktXthaoFHRKyS7FLILvdTdYXFkbCw4=@lists.denx.de
X-Gm-Message-State: AOJu0Yzbc+i9/Qxi316ihi8dd/2ITlQaVIXN7Yj2U6EVb+4j04xEoizb
 s3YbqPXHwygWJ47iWz7Jawfur9UC4Sdtv+lJ++b4kgP8KsNV2XF7D+j/jxrv+Z0sqZVA3ZfUG7E
 WV1X+
X-Gm-Gg: Acq92OEcdWPsZXOaj5h5PlVeIlBWLlPvzp4L+CQunkby5Xsc1FDU8op6aitidKl+wVn
 wCUQHC3l419qG+TCFApk1pkmhqDtiBuHQZi0G+QUKwsCjU92SIWJ+4e9hk/a1gMgjtqN4o92N5s
 GSY2CY8KZnTsF/WcV9SYiDHWPP1vpfZue/L3Mx+o1wptIxXRz93hSnlqgeN8NhW49y3zGl7TIu2
 AoANiQC04/DLznwShoK/ex9sWG4tYUhN0etUAA5Xqk6HisLfv6OfAXs9NmDqGm65o29Q84lbH23
 RCAkzf849eHqYVNdxEXgSUvT0DnRxCbmUTe5BhoUfcz9Yz8UfFLNVIsfmHq7Kye0DLwhuS2B+Ae
 Icetqi/3rNtdsqGZTC9TzasuWtG4nGwz2q/OG3LcudBBK+uv9MSGnt/K8jB/v6wkkEnhcbk1cWt
 TCgnXy72G3hbF6ThEhIfsMQPYdUYHK
X-Received: by 2002:a05:6820:1c92:b0:696:1450:ff24 with SMTP id
 006d021491bc7-69998d1e302mr9483971eaf.36.1778348201250; 
 Sat, 09 May 2026 10:36:41 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:3548:c22e:ea52:dbc7])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-435573e7254sm4774002fac.14.2026.05.09.10.36.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 09 May 2026 10:36:39 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Sat, 09 May 2026 12:36:26 -0500
Subject: [PATCH] net: lwip: introduce net_lwip_eth_stop() function
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260509-net-lwip-add-stop-function-v1-1-62d854bfa66a@baylibre.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/y2NQQ6CMBBFr0Jm7cRKqhWuYliUMuAYabEd1IRwd
 6u4fMn77y+QKDIlqIsFIj05cfAZDrsC3NX6gZC7zFCq8qSOqkJPgvcXT2i7DpOECfvZO8kzNL0
 xlVZGn7WGHJgi9fz+xS/Nxmlub+TkW/wbkR5zfpVNg9YmQhfGkaUuQuSB/X60SShCs64f1rE3Y
 a8AAAA=
X-Change-ID: 20260509-net-lwip-add-stop-function-7f7794074844
To: Jerome Forissier <jerome.forissier@arm.com>, Tom Rini <trini@konsulko.com>
Cc: Julien Stephan <jstephan@baylibre.com>, u-boot@lists.denx.de, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=10309;
 i=dlechner@baylibre.com; h=from:subject:message-id;
 bh=9SAM286MUkYkUMWHuM4DYSPSABvb42R7gaMJNYDmj3Y=;
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBp/3CdI9nWZ46FHu+uUIsdehyI5Tu30gSbrB4Rb
 mdaFNTO+qKJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaf9wnRYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/APO8H/RHSoaSaBpBqzsiOdVXGGskUk/Ki3C04KVQ1YIz
 eQ/YL7o9LGuPO5S1n5M1QCImgs3qGg6vlroocuLMXRgfHxEpmEGVdGRm+PUs4N8lF+qKFasEVwd
 G6HAgvtoy4i/Kuz92RArMLLIvsYvVwIogeZy65XHKLXRkPR5fIGjJAVH2UZgk+frIpT3giNwCv9
 wMYpYBRFkm1pVGQZY5VloAdFCXsjWr/1Dm4N09yUiNfkpBOb+DChIe20KXQj+Mhg115SDR8EJgh
 p7FozPpGJwV5+S5JHcW8zBGZk7jQ37q+3mIe0NpQym4xcbeGI/PskvHdycq/Pk01N59flWaP0Br
 n9K0=
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

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
Background:

While testing [1], I found that it would take down my local network if
I left the command prompt open for more than 30 seconds after running
any network command. The network activity light on the board running
U-Boot would go crazy and other network adapters on the network would
start getting watchdog timeouts. So apparently, it is doing something
quite low-level and I don't have any hardware to sniff that (Wireshark
on another computer was no help since all network adapters on the
network stopped working.) So I took a logical approach of looking at
the code to see if I could find anything that would cause this. This
seemed to only happen after I switched from the legacy network
implementation to the lwIP implementation, so I looked for differences
between the two implementations.

After some investigation, I found that the lwIP implementation was
different from the legacy implementation in that it does not call
eth_halt() after a network command. Since the problem happened only
when at the command prompt with no command running, this seemed like a
likely culprit. And indeed, it does seem to fix the issue for me.

For reference, the legacy implementation does something like this
as documented in doc/develop/driver-model/ethernet.rst:

	(some net operation (ping / tftp / whatever...))
	eth_init()
		ops->start()
	eth_send()
		ops->send()
	eth_rx()
		ops->recv()
		(process packet)
		if (ops->free_pkt)
			ops->free_pkt()
	eth_halt()
		ops->stop()

After this patch, the lwIP implementation will do the same thing for
all ethernet commands.

[1]: https://lore.kernel.org/u-boot/20260429-add-ethernet-support-for-genio-520-720-v4-0-be54e17239b7@baylibre.com/
---
 cmd/lwip/ping.c     | 10 ++++++++--
 cmd/lwip/sntp.c     | 10 ++++++++--
 include/net-lwip.h  |  1 +
 net/lwip/dhcp.c     | 15 +++++++++++----
 net/lwip/dns.c      |  6 +++++-
 net/lwip/net-lwip.c |  6 +++++-
 net/lwip/nfs.c      |  4 ++++
 net/lwip/tftp.c     |  4 ++++
 net/lwip/wget.c     | 34 ++++++++++++++++++++++------------
 9 files changed, 68 insertions(+), 22 deletions(-)

diff --git a/cmd/lwip/ping.c b/cmd/lwip/ping.c
index fc4cf7bde5f..836d1d8287f 100644
--- a/cmd/lwip/ping.c
+++ b/cmd/lwip/ping.c
@@ -163,6 +163,7 @@ static int ping_loop(struct udevice *udev, const ip_addr_t *addr)
 int do_ping(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 {
 	ip_addr_t addr;
+	int ret = CMD_RET_FAILURE;
 
 	if (argc < 2)
 		return CMD_RET_USAGE;
@@ -176,8 +177,13 @@ restart:
 		if (net_start_again() == 0)
 			goto restart;
 		else
-			return CMD_RET_FAILURE;
+			goto out;
 	}
 
-	return CMD_RET_SUCCESS;
+	ret = CMD_RET_SUCCESS;
+
+out:
+	net_lwip_eth_stop();
+
+	return ret;
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
index 8b7b3b7f970..b92feb1081c 100644
--- a/net/lwip/dns.c
+++ b/net/lwip/dns.c
@@ -91,6 +91,7 @@ int do_dns(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 {
 	char *name;
 	char *var = NULL;
+	int ret;
 
 	if (argc == 1 || argc > 3)
 		return CMD_RET_USAGE;
@@ -103,5 +104,8 @@ int do_dns(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 	if (net_lwip_eth_start() < 0)
 		return CMD_RET_FAILURE;
 
-	return dns_loop(eth_get_dev(), name, var);
+	ret = dns_loop(eth_get_dev(), name, var);
+	net_lwip_eth_stop();
+
+	return ret;
 }
diff --git a/net/lwip/net-lwip.c b/net/lwip/net-lwip.c
index 0c83c004cab..773113b8c9c 100644
--- a/net/lwip/net-lwip.c
+++ b/net/lwip/net-lwip.c
@@ -181,7 +181,6 @@ int net_lwip_eth_start(void)
 	int ret;
 
 	net_init();
-	eth_halt();
 	eth_set_current();
 	ret = eth_init();
 	if (ret < 0) {
@@ -192,6 +191,11 @@ int net_lwip_eth_start(void)
 	return 0;
 }
 
+void net_lwip_eth_stop(void)
+{
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
index 502c0faebb2..7a0348c87f9 100644
--- a/net/lwip/wget.c
+++ b/net/lwip/wget.c
@@ -302,6 +302,7 @@ int wget_do_request(ulong dst_addr, char *uri)
 	struct udevice *udev;
 	struct netif *netif;
 	struct wget_ctx ctx;
+	int ret = CMD_RET_USAGE;
 	char *path;
 	bool is_https;
 
@@ -327,11 +328,13 @@ int wget_do_request(ulong dst_addr, char *uri)
 
 	netif = net_lwip_new_netif(udev);
 	if (!netif)
-		return -1;
+		goto out_stop;
 
 	/* if URL with hostname init dns */
-	if (!ipaddr_aton(ctx.server_name, NULL) && net_lwip_dns_init())
-		return CMD_RET_FAILURE;
+	if (!ipaddr_aton(ctx.server_name, NULL) && net_lwip_dns_init()) {
+		ret = CMD_RET_FAILURE;
+		goto out_remove_netif;
+	}
 
 	memset(&conn, 0, sizeof(conn));
 #if CONFIG_IS_ENABLED(WGET_HTTPS)
@@ -353,8 +356,9 @@ int wget_do_request(ulong dst_addr, char *uri)
 					printf("Error: cacert authentication "
 					       "mode is 'required' but no CA "
 					       "certificates given\n");
-				return CMD_RET_FAILURE;
-		       }
+				ret = CMD_RET_FAILURE;
+				goto out_remove_netif;
+			}
 		} else if (cacert_auth_mode == AUTH_NONE) {
 			ca = NULL;
 			ca_sz = 0;
@@ -378,8 +382,7 @@ int wget_do_request(ulong dst_addr, char *uri)
 
 		if (!tls_allocator.arg) {
 			log_err("error: Cannot create a TLS connection\n");
-			net_lwip_remove_netif(netif);
-			return -1;
+			goto out_remove_netif;
 		}
 
 		conn.altcp_allocator = &tls_allocator;
@@ -391,8 +394,8 @@ int wget_do_request(ulong dst_addr, char *uri)
 	ctx.path = path;
 	if (httpc_get_file_dns(ctx.server_name, ctx.port, path, &conn, httpc_recv_cb,
 			       &ctx, &state)) {
-		net_lwip_remove_netif(netif);
-		return CMD_RET_FAILURE;
+		ret = CMD_RET_FAILURE;
+		goto out_remove_netif;
 	}
 
 	errno = 0;
@@ -405,13 +408,20 @@ int wget_do_request(ulong dst_addr, char *uri)
 
 	net_lwip_remove_netif(netif);
 
-	if (ctx.done == SUCCESS)
-		return 0;
+	if (ctx.done == SUCCESS) {
+		ret = 0;
+		goto out_stop;
+	}
 
 	if (errno == EPERM && !wget_info->silent)
 		printf("Certificate verification failed\n");
 
-	return -1;
+out_remove_netif:
+	net_lwip_remove_netif(netif);
+out_stop:
+	net_lwip_eth_stop();
+
+	return ret;
 }
 
 /**

---
base-commit: 22a285380e35a31d0a882af66278bc1edc1b917e
change-id: 20260509-net-lwip-add-stop-function-7f7794074844

Best regards,
--  
David Lechner <dlechner@baylibre.com>

