Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6ACC2C44521
	for <u-boot@archiver.kernel.org>; Sun, 19 Jul 2026 01:49:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C3CC1842FC;
	Sun, 19 Jul 2026 03:49:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id D85C980398; Sun, 19 Jul 2026 03:49:37 +0200 (CEST)
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org
 [IPv6:2a07:2ec0:3002::65])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0D5E1844F6
 for <u-boot@lists.denx.de>; Sun, 19 Jul 2026 03:49:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=makrotopia.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=daniel@makrotopia.org
Received: from local
 by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
 (Exim 4.99) (envelope-from <daniel@makrotopia.org>)
 id 1wlGet-000000001m6-0xL0; Sun, 19 Jul 2026 01:49:35 +0000
Date: Sun, 19 Jul 2026 02:49:33 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: Tom Rini <trini@konsulko.com>, Daniel Golle <daniel@makrotopia.org>,
 u-boot@lists.denx.de
Subject: [PATCH 2/2] rtc: pcf8563: return -EINVAL when the voltage-low flag
 is set
Message-ID: <af8573bc083ef60af5a890236e71c42d97fab9fb.1784423738.git.daniel@makrotopia.org>
References: <cover.1784423738.git.daniel@makrotopia.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1784423738.git.daniel@makrotopia.org>
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

Return a proper error code instead of a bare -1 (-EPERM) when VL
indicates the time is not reliable, matching rv3032 and the Linux
driver behaviour.

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
 drivers/rtc/pcf8563.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/rtc/pcf8563.c b/drivers/rtc/pcf8563.c
index 83d60dc9b55..b20666e8b4a 100644
--- a/drivers/rtc/pcf8563.c
+++ b/drivers/rtc/pcf8563.c
@@ -16,6 +16,7 @@
 #include <log.h>
 #include <rtc.h>
 #include <i2c.h>
+#include <linux/errno.h>
 
 #if !CONFIG_IS_ENABLED(DM_RTC)
 static uchar rtc_read  (uchar reg);
@@ -144,7 +145,7 @@ static int pcf8563_rtc_get(struct udevice *dev, struct rtc_time *tmp)
 
 	if (sec & 0x80) {
 		puts("### Warning: RTC Low Voltage - date/time not reliable\n");
-		rel = -1;
+		rel = -EINVAL;
 	}
 
 	tmp->tm_sec = bcd2bin(sec & 0x7F);
-- 
2.55.0
