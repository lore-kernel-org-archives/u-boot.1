Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2103C9830C
	for <u-boot@archiver.kernel.org>; Sat, 17 Jan 2026 00:25:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 22BD383981;
	Sat, 17 Jan 2026 01:25:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="ofrpvk2G";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C3CC183015; Sat, 17 Jan 2026 01:25:20 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6AE9083980
 for <u-boot@lists.denx.de>; Sat, 17 Jan 2026 01:25:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=f646=7W=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1768609517; bh=7cs07EjYAQhVl6mEup4AZJ20Irxr1yO/+Yh4AUwOU04=;
 b=ofrpvk2GFRlyjwjUeNx+ZW9MvgrZAS/dVYsh1L3A5OgMQV68v8HB8yTyXDSbPxidMtzT+SRvS
 x1wOkurFrV6ST9wVc3lvhsA4DL/AozmNl4FupXmce10qQaGNwoz4D0FJlUGKHaQy0EFGkcmZWsT
 WPijXjRb22dJF1LbXBY07oaJbcYJ+u5pcSVDSxMvzOnYGvRyIsHNLqNYgJs1Zid04cDdwmG5VC1
 Rpheo9wrQpfewkTvDuCltX7CvtJdaucV4aCsF4vq32dZisaBM8DKlcM1GEqRtQMcSGN5uvGQwaH
 WFDD76cSt6r9DQn2Q05cwQcQaLvDNJ2dezUR8ackyDBw==
X-Forward-Email-ID: 696ad6ea75104fdab5e8c399
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.73
X-Forward-Email-Version: 2.2.8
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Jerome Forissier <jerome@forissier.org>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de,
	Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH 4/6] net: lwip: Use ipaddr helpers
Date: Sat, 17 Jan 2026 00:24:40 +0000
Message-ID: <20260117002452.1026310-5-jonas@kwiboo.se>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260117002452.1026310-1-jonas@kwiboo.se>
References: <20260117002452.1026310-1-jonas@kwiboo.se>
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

The ip_addr_t of lwIP has support for both IPv6 and IPv4 addresses.
Some lwIP commans is directly accessing the internal addr field of the
ip_addr_t instead of using ipaddr helper functions.

Change to use ipaddr helper functions where appropriate to remove direct
access of the internal addr field. Also change a few instances from ip4
to the version less ipaddr helpers.

There is no intended functional change, besides the change from using
ip4 addr helper to using version less ipaddr helper.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 cmd/lwip/ping.c | 2 +-
 net/lwip/dhcp.c | 4 ++--
 net/lwip/dns.c  | 9 +++------
 net/lwip/nfs.c  | 6 +++---
 net/lwip/tftp.c | 2 +-
 5 files changed, 10 insertions(+), 13 deletions(-)

diff --git a/cmd/lwip/ping.c b/cmd/lwip/ping.c
index 6d090fc530d6..fc4cf7bde5f9 100644
--- a/cmd/lwip/ping.c
+++ b/cmd/lwip/ping.c
@@ -35,7 +35,7 @@ static u8_t ping_recv(void *arg, struct raw_pcb *pcb, struct pbuf *p,
 	struct ping_ctx *ctx = arg;
 	struct icmp_echo_hdr *iecho = ctx->iecho;
 
-	if (addr->addr != ctx->target.addr)
+	if (!ip_addr_eq(addr, &ctx->target))
 		return 0;
 
 	if ((p->tot_len >= (IP_HLEN + sizeof(struct icmp_echo_hdr))) &&
diff --git a/net/lwip/dhcp.c b/net/lwip/dhcp.c
index 731b57de3ba4..4cd4184c42bb 100644
--- a/net/lwip/dhcp.c
+++ b/net/lwip/dhcp.c
@@ -93,13 +93,13 @@ static int dhcp_loop(struct udevice *udev)
 		sprintf(maskstr, "netmask%d", idx);
 		sprintf(gwstr, "gatewayip%d", idx);
 	} else {
-		net_ip.s_addr = dhcp->offered_ip_addr.addr;
+		net_ip.s_addr = ip_addr_get_ip4_u32(&dhcp->offered_ip_addr);
 	}
 
 	env_set(ipstr, ip4addr_ntoa(&dhcp->offered_ip_addr));
 	env_set(maskstr, ip4addr_ntoa(&dhcp->offered_sn_mask));
 	env_set("serverip", ip4addr_ntoa(&dhcp->server_ip_addr));
-	if (dhcp->offered_gw_addr.addr != 0)
+	if (!ip4_addr_isany(&dhcp->offered_gw_addr))
 		env_set(gwstr, ip4addr_ntoa(&dhcp->offered_gw_addr));
 
 #ifdef CONFIG_PROT_DNS_LWIP
diff --git a/net/lwip/dns.c b/net/lwip/dns.c
index 2222e2b0b045..8b7b3b7f970f 100644
--- a/net/lwip/dns.c
+++ b/net/lwip/dns.c
@@ -28,13 +28,10 @@ static void dns_cb(const char *name, const ip_addr_t *ipaddr, void *arg)
 
 	dns_cb_arg->done = true;
 
-	if (!ipaddr) {
+	if (!ipaddr)
 		printf("DNS: host not found\n");
-		dns_cb_arg->host_ipaddr.addr = 0;
-		return;
-	}
 
-	dns_cb_arg->host_ipaddr.addr = ipaddr->addr;
+	ip_addr_set(&dns_cb_arg->host_ipaddr, ipaddr);
 }
 
 static int dns_loop(struct udevice *udev, const char *name, const char *var)
@@ -78,7 +75,7 @@ static int dns_loop(struct udevice *udev, const char *name, const char *var)
 
 	net_lwip_remove_netif(netif);
 
-	if (dns_cb_arg.done && dns_cb_arg.host_ipaddr.addr != 0) {
+	if (dns_cb_arg.done && !ip_addr_isany(&dns_cb_arg.host_ipaddr)) {
 		ipstr = ipaddr_ntoa(&dns_cb_arg.host_ipaddr);
 		if (var)
 			env_set(var, ipstr);
diff --git a/net/lwip/nfs.c b/net/lwip/nfs.c
index 5fc2d3bd8736..1812bbda68e5 100644
--- a/net/lwip/nfs.c
+++ b/net/lwip/nfs.c
@@ -59,7 +59,7 @@ static void nfs_recv(void *arg, struct udp_pcb *pcb, struct pbuf *p,
 	int plen;
 	struct rpc_t rpc_pkt;
 
-	if (addr->addr != ctx->nfs_server.addr)
+	if (!ip_addr_eq(addr, &ctx->nfs_server))
 		goto exitfree;
 
 	if (p->tot_len > sizeof(struct rpc_t))
@@ -120,7 +120,7 @@ static int nfs_loop(struct udevice *udev, ulong addr, char *fname,
 	printf("Using %s device\n", udev->name);
 
 	printf("File transfer via NFS from server %s; our IP address is %s\n",
-	       ip4addr_ntoa(&srvip), env_get("ipaddr"));
+	       ipaddr_ntoa(&srvip), env_get("ipaddr"));
 
 	printf("\nFilename '%s/%s'.", nfs_path, nfs_filename);
 
@@ -144,7 +144,7 @@ static int nfs_loop(struct udevice *udev, ulong addr, char *fname,
 
 	net_set_state(NETLOOP_CONTINUE);
 
-	sess_ctx.nfs_server.addr = srvip.addr;
+	ip_addr_set(&sess_ctx.nfs_server, &srvip);
 
 	nfs_send();
 
diff --git a/net/lwip/tftp.c b/net/lwip/tftp.c
index 6c7ffba661e5..86516e662732 100644
--- a/net/lwip/tftp.c
+++ b/net/lwip/tftp.c
@@ -180,7 +180,7 @@ static int tftp_loop(struct udevice *udev, ulong addr, char *fname,
 
 	printf("Using %s device\n", udev->name);
 	printf("TFTP from server %s; our IP address is %s\n",
-	       ip4addr_ntoa(&srvip), env_get("ipaddr"));
+	       ipaddr_ntoa(&srvip), env_get("ipaddr"));
 	printf("Filename '%s'.\n", fname);
 	printf("Load address: 0x%lx\n", ctx.daddr);
 	printf("Loading: ");
-- 
2.52.0

