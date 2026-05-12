Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BBBFCD343F
	for <u-boot@archiver.kernel.org>; Tue, 12 May 2026 21:49:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 76B1B836AC;
	Tue, 12 May 2026 23:48:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="T2/9qITj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 98F008460C; Tue, 12 May 2026 23:48:54 +0200 (CEST)
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com
 [IPv6:2607:f8b0:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B31DE83EF9
 for <u-boot@lists.denx.de>; Tue, 12 May 2026 23:48:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-ot1-x335.google.com with SMTP id
 46e09a7af769-7de44ed7a11so4888534a34.1
 for <u-boot@lists.denx.de>; Tue, 12 May 2026 14:48:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1778622530; x=1779227330;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ly5r8Lh5KPW5j1Pj88jJI1oJnRV5W8udBIoURQ3w5+c=;
 b=T2/9qITj0/vcDN94OAjzh9amuGYfAzDzq3QlgnT85q3PF6RzVGl3nGud5oN6Pqi8JQ
 ZiVAYp6+MNrdImtlR1+BXdihBlro8DlnjKC7CR0TgPmXWiB+Rk0WCtMX4HcDM/Rj5ZEb
 D9+8ZlTdIdUbr4EvxwAfEdW3IA4Ifs7DswwO6I5ZYWHXbtT8KXHeRUYHuSgNj0IFfSQA
 TfNDqO7IKWHZemZ+4CaTZY9B7N/hgdo5uExsWey6qVLOjqCTKXpkMspVPMnDy6gBXSSz
 Ho0M7BpnX6VK6iL914/PU58owgsoJ+oNVF7zL2Q9nA1oxlgDc/Wic7R6bV0cyZFAnOr5
 eeyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778622530; x=1779227330;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=ly5r8Lh5KPW5j1Pj88jJI1oJnRV5W8udBIoURQ3w5+c=;
 b=DMR/inJ+zPapnRCUF8cmoRXPKUfb905Vm3dIN3/tbJyTwsWmvQvDzqnatmbF7f8P9l
 jN7n2fSTE/w2pQdaNpXuMBRZjModeLXMdBaiJs9767QwWMoh3yiWV3Y9zGwCvl+UIx/P
 zaEQCVLfInV7iS31J+EXsdi6u4RevIj4c2dWy+2DPaP95m09PFb0EGUsMzt/YtqrpP+n
 VJeGKnhB7jZwq5n5vGJOniMPPN/AwEoGKM2kwOrjk4Gb9Nv8ClFzzm9cjCgJNjijqUi2
 3bsTeba2Gh6iWxmsDIeEl66cAg/+DvzmTM7wA5g+NtFxsWuKJvj0ETLsGU5+2xSDRm0A
 V6Vg==
X-Forwarded-Encrypted: i=1;
 AFNElJ/s2MNML8aHdya23GyAqmZ8n8cZlD9+VPe0YTXmeG7pUPdt6bKUIw6fOn1XNkUrS2lJrF4a6Cw=@lists.denx.de
X-Gm-Message-State: AOJu0YyRX8D1/KgJfx4rih0NA8JRzLKAyQPy8FyZSeBb0skVXkXo4pgZ
 we4nmEtCjCWUB1WvPmC06ZHI53nhkwOjrqP8GROj/yYQy82/LF01eU26EWZ2yGU3wtA=
X-Gm-Gg: Acq92OFF8z3KHf2tvmCQRPby8iubupnaZCPwhi02xcnBLdGEe6KxCMNpA1RTC6knsb0
 fCPXP/s+BO0ST7jSXgxEzMY+UuDsMhnG4tHJ/fTX0tCrgrLYZ3r1BMc+BW4PvrEMlaFPz38GAkd
 qnvRFkBja3Yq4cvK6U8RK/b/aXuRKHT97qkxQSTY0B2Nu/45mIpQOyPZyJWea8hw1Sv0MOx3L1R
 JC8osPJFGFwP42i5llBcPmcXhbPsGH+UnuORavqafQMz7Mcq1maIMj90Z3PqRiUdwNroRPLvbKs
 NZbpZHf6O+7KJrf4mVNN5qAtw65n7cKtR8++bYSiXDuSwtZHNUwdhwJcRUitJeMOW+t+aigxepe
 hXDjjOnUMN4KmD8EPtsHZGS8722tJbScvyIAughtLeWthDpx3uitSibwrZ6NhQrc+aIvsXc4cjM
 ApuFS6g5BbNDQllrGzE3HvmKIIn18g
X-Received: by 2002:a05:6830:6ae9:b0:7dc:c4ae:a66f with SMTP id
 46e09a7af769-7e3da2bfd78mr333409a34.7.1778622530457; 
 Tue, 12 May 2026 14:48:50 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:baa4:f7fb:528a:2457])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e367c04e66sm9671795a34.8.2026.05.12.14.48.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 May 2026 14:48:50 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Tue, 12 May 2026 16:48:15 -0500
Subject: [PATCH v2 3/3] net: lwip: introduce net_lwip_eth_stop() function
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260512-net-lwip-add-stop-function-v2-3-85146da317dd@baylibre.com>
References: <20260512-net-lwip-add-stop-function-v2-0-85146da317dd@baylibre.com>
In-Reply-To: <20260512-net-lwip-add-stop-function-v2-0-85146da317dd@baylibre.com>
To: Jerome Forissier <jerome.forissier@arm.com>, 
 Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Julien Stephan <jstephan@baylibre.com>, u-boot@lists.denx.de, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=6415; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=P8qz161ZZHR1QuQYpD0hBpwhDaFDWzSeBR+vp0bFubQ=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBqA6A1QMQA/TfWIr9yoJwj5Jquy65uqiRVXGGmq
 JAD0wib8hSJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCagOgNRYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AB7kIAJKheAAfY02xpbhKBeyPXJEWfsTGnx8gDOD82pN
 WDvPjvbfYu9ER9sPctywPGV9d1r97zdz+7wQROZteN8sEMoi46YpWorumyfx4UWde2mBobq75Jz
 T0cWeA14y/pv9foeMibFRLmalWl8KhvXr5uWRkQqY8a8NZHF27v8s5JY+k8ixygMnS6x8VFt/QM
 wdZ9j3YD/L68o+raehOZB2daexo+SKNJN49kf1ELUl05z2XBWoEwkoxk9lF0STCfN6uzHIO1StN
 bgunU3IvrktlyoQ19sIHPwKKfKQPI17lxyPDUDk/fgz4qndZY+kNo1DX6s/IysATDhopSgF4Cez
 AmQA=
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
 cmd/lwip/ping.c     | 10 ++++++++--
 cmd/lwip/sntp.c     | 10 ++++++++--
 include/net-lwip.h  |  1 +
 net/lwip/dhcp.c     | 15 +++++++++++----
 net/lwip/dns.c      |  7 ++++++-
 net/lwip/net-lwip.c |  5 +++++
 net/lwip/nfs.c      |  4 ++++
 net/lwip/tftp.c     |  4 ++++
 net/lwip/wget.c     |  5 ++++-
 9 files changed, 51 insertions(+), 10 deletions(-)

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
index 0c83c004cab..be63531c2a2 100644
--- a/net/lwip/net-lwip.c
+++ b/net/lwip/net-lwip.c
@@ -192,6 +192,11 @@ int net_lwip_eth_start(void)
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

