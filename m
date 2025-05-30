Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FD18C5AD49
	for <u-boot@archiver.kernel.org>; Fri, 30 May 2025 15:38:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2D5668334D;
	Fri, 30 May 2025 17:38:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 91F9082991; Fri, 30 May 2025 17:38:33 +0200 (CEST)
Received: from finn.localdomain (finn.gateworks.com [108.161.129.64])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1EEE5801BE
 for <u-boot@lists.denx.de>; Fri, 30 May 2025 17:38:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tharvey@gateworks.com
Received: from syn-068-189-091-139.biz.spectrum.com ([68.189.91.139]
 helo=tharvey.pdc.gateworks.com)
 by finn.localdomain with esmtp (Exim 4.95)
 (envelope-from <tharvey@gateworks.com>) id 1uL1oS-007QGb-GK;
 Fri, 30 May 2025 15:38:28 +0000
From: Tim Harvey <tharvey@gateworks.com>
To: u-boot@lists.denx.de
Cc: Jerome Forissier <jerome.forissier@linaro.org>,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, Tim Harvey <tharvey@gateworks.com>
Subject: [PATCH v2 1/5] net: lwip: call sys_check_timeouts and schedule on rx
Date: Fri, 30 May 2025 08:38:22 -0700
Message-Id: <20250530153826.1057407-1-tharvey@gateworks.com>
X-Mailer: git-send-email 2.25.1
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

Call schedule() in net_lwip_rx() to service U-Boot tasks and
actions during packet rx.

As a cleanup also move sys_check_timeouts() here and remove it from the
functions that call net_lwip_rx().

This resolves the issue of an active watchdog resetting the board on
long network activities.

Suggested-by: Jerome Forissier <jerome.forissier@linaro.org>
Signed-off-by: Tim Harvey <tharvey@gateworks.com>
---
v2:
 - remove duplication of sys_check_timeouts() from functions that call
   net_lwip_rx()
---
 net/lwip/dhcp.c     | 1 -
 net/lwip/dns.c      | 1 -
 net/lwip/net-lwip.c | 7 +++++++
 net/lwip/ping.c     | 1 -
 net/lwip/tftp.c     | 1 -
 net/lwip/wget.c     | 1 -
 6 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/net/lwip/dhcp.c b/net/lwip/dhcp.c
index 92bd7067a7fb..b79b746db390 100644
--- a/net/lwip/dhcp.c
+++ b/net/lwip/dhcp.c
@@ -57,7 +57,6 @@ static int dhcp_loop(struct udevice *udev)
 	/* Wait for DHCP to complete */
 	do {
 		net_lwip_rx(udev, netif);
-		sys_check_timeouts();
 		bound = dhcp_supplied_address(netif);
 		if (bound)
 			break;
diff --git a/net/lwip/dns.c b/net/lwip/dns.c
index 19172ac959ac..738f8bf3196b 100644
--- a/net/lwip/dns.c
+++ b/net/lwip/dns.c
@@ -91,7 +91,6 @@ static int dns_loop(struct udevice *udev, const char *name, const char *var)
 			net_lwip_rx(udev, netif);
 			if (dns_cb_arg.done)
 				break;
-			sys_check_timeouts();
 			if (ctrlc()) {
 				printf("\nAbort\n");
 				break;
diff --git a/net/lwip/net-lwip.c b/net/lwip/net-lwip.c
index f05c4cd3f64f..e8d4cc542ed8 100644
--- a/net/lwip/net-lwip.c
+++ b/net/lwip/net-lwip.c
@@ -13,8 +13,10 @@
 #include <lwip/etharp.h>
 #include <lwip/init.h>
 #include <lwip/prot/etharp.h>
+#include <lwip/timeouts.h>
 #include <net.h>
 #include <timer.h>
+#include <u-boot/schedule.h>
 
 /* xx:xx:xx:xx:xx:xx\0 */
 #define MAC_ADDR_STRLEN 18
@@ -284,6 +286,11 @@ int net_lwip_rx(struct udevice *udev, struct netif *netif)
 	int len;
 	int i;
 
+	/* lwIP timers */
+	sys_check_timeouts();
+	/* Other tasks and actions */
+	schedule();
+
 	if (!eth_is_active(udev))
 		return -EINVAL;
 
diff --git a/net/lwip/ping.c b/net/lwip/ping.c
index d8042ceecf99..1390b914f7d8 100644
--- a/net/lwip/ping.c
+++ b/net/lwip/ping.c
@@ -136,7 +136,6 @@ static int ping_loop(struct udevice *udev, const ip_addr_t *addr)
 	ping_send(&ctx);
 
 	do {
-		sys_check_timeouts();
 		net_lwip_rx(udev, netif);
 		if (ctx.alive)
 			break;
diff --git a/net/lwip/tftp.c b/net/lwip/tftp.c
index fae701bad2eb..7495dc077ba5 100644
--- a/net/lwip/tftp.c
+++ b/net/lwip/tftp.c
@@ -200,7 +200,6 @@ static int tftp_loop(struct udevice *udev, ulong addr, char *fname,
 	sys_timeout(NO_RSP_TIMEOUT_MS, no_response, &ctx);
 	while (!ctx.done) {
 		net_lwip_rx(udev, netif);
-		sys_check_timeouts();
 		if (ctrlc()) {
 			printf("\nAbort\n");
 			ctx.done = ABORTED;
diff --git a/net/lwip/wget.c b/net/lwip/wget.c
index ea1113e18b11..fcaf684e61da 100644
--- a/net/lwip/wget.c
+++ b/net/lwip/wget.c
@@ -525,7 +525,6 @@ int wget_do_request(ulong dst_addr, char *uri)
 
 	while (!ctx.done) {
 		net_lwip_rx(udev, netif);
-		sys_check_timeouts();
 		if (ctrlc())
 			break;
 	}
-- 
2.25.1

