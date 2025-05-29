Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23EB2C5AD49
	for <u-boot@archiver.kernel.org>; Thu, 29 May 2025 21:49:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BBCFF8312E;
	Thu, 29 May 2025 23:49:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1F4C482B19; Thu, 29 May 2025 23:49:27 +0200 (CEST)
Received: from finn.localdomain (finn.gateworks.com [108.161.129.64])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B708E82AFC
 for <u-boot@lists.denx.de>; Thu, 29 May 2025 23:49:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tharvey@gateworks.com
Received: from syn-068-189-091-139.biz.spectrum.com ([68.189.91.139]
 helo=tharvey.pdc.gateworks.com)
 by finn.localdomain with esmtp (Exim 4.95)
 (envelope-from <tharvey@gateworks.com>) id 1uKl7q-007IAa-4l;
 Thu, 29 May 2025 21:49:22 +0000
From: Tim Harvey <tharvey@gateworks.com>
To: u-boot@lists.denx.de
Cc: Jerome Forissier <jerome.forissier@linaro.org>,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, Tim Harvey <tharvey@gateworks.com>
Subject: [PATCH 1/6] net: lwip: call sys_check_timeouts and schedule on rx
Date: Thu, 29 May 2025 14:49:05 -0700
Message-Id: <20250529214910.984024-1-tharvey@gateworks.com>
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

Call sys_check_timeouts to service lwIP timers and schedule to service
U-Boot tasks and actions during packet rx.

This resolves the issue of an active watchdog resetting the board on
long network activities.

Suggested-by: Jerome Forissier <jerome.forissier@linaro.org>
Signed-off-by: Tim Harvey <tharvey@gateworks.com>
---
 net/lwip/net-lwip.c | 7 +++++++
 1 file changed, 7 insertions(+)

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
 
-- 
2.25.1

