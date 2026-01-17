Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D6ABC9830D
	for <u-boot@archiver.kernel.org>; Sat, 17 Jan 2026 00:25:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9C1D18389A;
	Sat, 17 Jan 2026 01:25:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="OloKcJMi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5564B83015; Sat, 17 Jan 2026 01:25:16 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6CBA18397D
 for <u-boot@lists.denx.de>; Sat, 17 Jan 2026 01:25:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=f646=7W=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1768609512; bh=psFrlP7U74HdJ0ajS4EUpkjMeG3qpR3bLCfsl5hWkuA=;
 b=OloKcJMiw/6VdNaF1dAIy/I8sLFetwePQFFNHbdmqtchtMTXYit7TCMNz9O8piHHR6vwSFR2t
 SOxsNv6tYZ28tFaVppA221rYUujDWAyGiDMPB2OhpWZIh8jk091eUzea3QTGKERBzxNyEnUGluM
 6sjjP2Lk9YVsOW6N5er9a8eoUTEn9YaF/OVr0n0Tym12nP9gJx2aqO/C3XtlGw2qJzE8S7f8CE3
 SxHNxQJwbHz+u4C2BkxnQhz68wbp4O80krGw3XSc5CJEVmmTI7U7712AIgnSFN5kYzb21ApBHZa
 4iYBD6g3ZwM1BpDdZR0bhwMpobFchVBxZgOtkD5TnhSA==
X-Forward-Email-ID: 696ad6e675104fdab5e8c37a
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
Subject: [PATCH 3/6] net: lwip: dns: Call env_set() from dns loop instead of
 found callback
Date: Sat, 17 Jan 2026 00:24:39 +0000
Message-ID: <20260117002452.1026310-4-jonas@kwiboo.se>
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

The lwIP dns command handle env_set() calls from the found callback and
printf() to console in the dns loop. Making it more complex than it
needs to be.

Simplify and ensure any environment variable that is being set is the
same value that would have been printed on console.

There should not be any intended change in behavior, besides the change
from using ip4addr helper to using version less ipaddr helper.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 net/lwip/dns.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/net/lwip/dns.c b/net/lwip/dns.c
index 2b2a5947a2b8..2222e2b0b045 100644
--- a/net/lwip/dns.c
+++ b/net/lwip/dns.c
@@ -14,7 +14,6 @@
 
 struct dns_cb_arg {
 	ip_addr_t host_ipaddr;
-	const char *var;
 	bool done;
 };
 
@@ -26,7 +25,6 @@ static void do_dns_tmr(void *arg)
 static void dns_cb(const char *name, const ip_addr_t *ipaddr, void *arg)
 {
 	struct dns_cb_arg *dns_cb_arg = arg;
-	char *ipstr = ip4addr_ntoa(ipaddr);
 
 	dns_cb_arg->done = true;
 
@@ -37,21 +35,17 @@ static void dns_cb(const char *name, const ip_addr_t *ipaddr, void *arg)
 	}
 
 	dns_cb_arg->host_ipaddr.addr = ipaddr->addr;
-
-	if (dns_cb_arg->var)
-		env_set(dns_cb_arg->var, ipstr);
 }
 
 static int dns_loop(struct udevice *udev, const char *name, const char *var)
 {
 	struct dns_cb_arg dns_cb_arg = { };
 	struct netif *netif;
+	const char *ipstr;
 	ip_addr_t ipaddr;
 	ulong start;
 	int ret;
 
-	dns_cb_arg.var = var;
-
 	netif = net_lwip_new_netif(udev);
 	if (!netif)
 		return CMD_RET_FAILURE;
@@ -85,8 +79,11 @@ static int dns_loop(struct udevice *udev, const char *name, const char *var)
 	net_lwip_remove_netif(netif);
 
 	if (dns_cb_arg.done && dns_cb_arg.host_ipaddr.addr != 0) {
-		if (!var)
-			printf("%s\n", ipaddr_ntoa(&dns_cb_arg.host_ipaddr));
+		ipstr = ipaddr_ntoa(&dns_cb_arg.host_ipaddr);
+		if (var)
+			env_set(var, ipstr);
+		else
+			printf("%s\n", ipstr);
 		return CMD_RET_SUCCESS;
 	}
 
-- 
2.52.0

