Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96ADEC5AD49
	for <u-boot@archiver.kernel.org>; Fri, 30 May 2025 15:39:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C60B18334A;
	Fri, 30 May 2025 17:38:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 79FCE8331C; Fri, 30 May 2025 17:38:35 +0200 (CEST)
Received: from finn.localdomain (finn.gateworks.com [108.161.129.64])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CF89883327
 for <u-boot@lists.denx.de>; Fri, 30 May 2025 17:38:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tharvey@gateworks.com
Received: from syn-068-189-091-139.biz.spectrum.com ([68.189.91.139]
 helo=tharvey.pdc.gateworks.com)
 by finn.localdomain with esmtp (Exim 4.95)
 (envelope-from <tharvey@gateworks.com>) id 1uL1oU-007QGb-Qa;
 Fri, 30 May 2025 15:38:30 +0000
From: Tim Harvey <tharvey@gateworks.com>
To: u-boot@lists.denx.de
Cc: Jerome Forissier <jerome.forissier@linaro.org>,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, Tim Harvey <tharvey@gateworks.com>
Subject: [PATCH v2 4/5] net: lwip: move dns init to common function
Date: Fri, 30 May 2025 08:38:25 -0700
Message-Id: <20250530153826.1057407-4-tharvey@gateworks.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250530153826.1057407-1-tharvey@gateworks.com>
References: <20250530153826.1057407-1-tharvey@gateworks.com>
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

move the dns init including setting the dns servers from env vars to a
common function as other commands that support hostname lookups will
need this.

Signed-off-by: Tim Harvey <tharvey@gateworks.com>
Reviewed-by: Jerome Forissier <jerome.forissier@linaro.org>
---
v2:
 - added tags
---
 include/net-lwip.h  |  1 +
 net/lwip/dns.c      | 20 +-------------------
 net/lwip/net-lwip.c | 30 ++++++++++++++++++++++++++++++
 3 files changed, 32 insertions(+), 19 deletions(-)

diff --git a/include/net-lwip.h b/include/net-lwip.h
index b762956e8fda..6b5eb1990fbf 100644
--- a/include/net-lwip.h
+++ b/include/net-lwip.h
@@ -17,6 +17,7 @@ static inline int eth_is_on_demand_init(void)
 
 int eth_init_state_only(void); /* Set active state */
 
+int net_lwip_dns_init(void);
 int net_lwip_eth_start(void);
 struct netif *net_lwip_new_netif(struct udevice *udev);
 struct netif *net_lwip_new_netif_noip(struct udevice *udev);
diff --git a/net/lwip/dns.c b/net/lwip/dns.c
index 738f8bf3196b..744040f26d29 100644
--- a/net/lwip/dns.c
+++ b/net/lwip/dns.c
@@ -44,12 +44,9 @@ static void dns_cb(const char *name, const ip_addr_t *ipaddr, void *arg)
 static int dns_loop(struct udevice *udev, const char *name, const char *var)
 {
 	struct dns_cb_arg dns_cb_arg = { };
-	bool has_server = false;
 	struct netif *netif;
 	ip_addr_t ipaddr;
-	ip_addr_t ns;
 	ulong start;
-	char *nsenv;
 	int ret;
 
 	dns_cb_arg.var = var;
@@ -58,22 +55,7 @@ static int dns_loop(struct udevice *udev, const char *name, const char *var)
 	if (!netif)
 		return CMD_RET_FAILURE;
 
-	dns_init();
-
-	nsenv = env_get("dnsip");
-	if (nsenv && ipaddr_aton(nsenv, &ns)) {
-		dns_setserver(0, &ns);
-		has_server = true;
-	}
-
-	nsenv = env_get("dnsip2");
-	if (nsenv && ipaddr_aton(nsenv, &ns)) {
-		dns_setserver(1, &ns);
-		has_server = true;
-	}
-
-	if (!has_server) {
-		log_err("No valid name server (dnsip/dnsip2)\n");
+	if (net_lwip_dns_init()) {
 		net_lwip_remove_netif(netif);
 		return CMD_RET_FAILURE;
 	}
diff --git a/net/lwip/net-lwip.c b/net/lwip/net-lwip.c
index e8d4cc542ed8..23dccfef8993 100644
--- a/net/lwip/net-lwip.c
+++ b/net/lwip/net-lwip.c
@@ -7,6 +7,7 @@
 #include <dm/uclass.h>
 #include <hexdump.h>
 #include <lwip/ip4_addr.h>
+#include <lwip/dns.h>
 #include <lwip/err.h>
 #include <lwip/netif.h>
 #include <lwip/pbuf.h>
@@ -139,6 +140,35 @@ static int get_udev_ipv4_info(struct udevice *dev, ip4_addr_t *ip,
 	return 0;
 }
 
+/*
+ * Initialize DNS via env
+ */
+int net_lwip_dns_init(void)
+{
+	bool has_server = false;
+	ip_addr_t ns;
+	char *nsenv;
+
+	nsenv = env_get("dnsip");
+	if (nsenv && ipaddr_aton(nsenv, &ns)) {
+		dns_setserver(0, &ns);
+		has_server = true;
+	}
+
+	nsenv = env_get("dnsip2");
+	if (nsenv && ipaddr_aton(nsenv, &ns)) {
+		dns_setserver(1, &ns);
+		has_server = true;
+	}
+
+	if (!has_server) {
+		log_err("No valid name server (dnsip/dnsip2)\n");
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 /*
  * Initialize the network stack if needed and start the current device if valid
  */
-- 
2.25.1

