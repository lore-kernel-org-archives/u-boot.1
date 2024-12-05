Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B8EBE7716E
	for <u-boot@archiver.kernel.org>; Thu,  5 Dec 2024 19:17:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 946EE8951F;
	Thu,  5 Dec 2024 20:17:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="d3zh9KTk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A705089512; Thu,  5 Dec 2024 20:17:44 +0100 (CET)
Received: from smtp-relay-canonical-1.canonical.com
 (smtp-relay-canonical-1.canonical.com [185.125.188.121])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C7AF68952A
 for <u-boot@lists.denx.de>; Thu,  5 Dec 2024 20:17:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.fritz.box (ip-005-147-080-091.um06.pools.vodafone-ip.de
 [5.147.80.91])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 1A27A41221; 
 Thu,  5 Dec 2024 19:17:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1733426259;
 bh=XT0+ZhLiOaNaMFzOCkX4ZQmH7dp82XUSIVp5XuNomik=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=d3zh9KTkCo4IvNh1T0FctDoocjiEvcaWW2gOK5e4+zQeVOw6nroFtgsxTsfv1maja
 Xm5iAt6lHkVB4zZSL/licWP+uws6+ZDLbIISIZ5IezfGRK93hY7vEuadXqrEDkCCmA
 LxmUhYFIT1fTNqwZOzQTq715MH2Fmd6M0Kokzl6f6mKHXSSlH4FQQDZ9FR6m4IsY78
 mLcUt0Da0AUGCkb8fUI0SyVPpdxmnmXFxm4PX77XdKqdmnC9AzvOkqYPn9jIPEmLgF
 fbtp2a1BVSG6kSyivj/NZ1Q2Eb9mNZPh++8/35Ux+46yH4hrUtRLm1P31QQ9j6K5Yi
 4CAuUEgk/Fx6g==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Jerome Forissier <jerome.forissier@linaro.org>
Cc: Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] net: lwip: check if network device is available in do_dhcp
Date: Thu,  5 Dec 2024 20:17:36 +0100
Message-ID: <20241205191736.21503-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.45.2
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

eth_get_dev() returns NULL if no network device is available.
Not checking the return value leads to a crash when the device
pointer is dereferenced.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 net/lwip/dhcp.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/net/lwip/dhcp.c b/net/lwip/dhcp.c
index 9b882cf5b87..e7d9147455c 100644
--- a/net/lwip/dhcp.c
+++ b/net/lwip/dhcp.c
@@ -3,6 +3,7 @@
 
 #include <command.h>
 #include <console.h>
+#include <log.h>
 #include <dm/device.h>
 #include <linux/delay.h>
 #include <linux/errno.h>
@@ -112,10 +113,17 @@ static int dhcp_loop(struct udevice *udev)
 int do_dhcp(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 {
 	int ret;
+	struct udevice *dev;
 
 	eth_set_current();
 
-	ret = dhcp_loop(eth_get_dev());
+	dev = eth_get_dev();
+	if (!dev) {
+		log_err("No network device\n");
+		return CMD_RET_FAILURE;
+	}
+
+	ret = dhcp_loop(dev);
 	if (ret)
 		return ret;
 
-- 
2.45.2

