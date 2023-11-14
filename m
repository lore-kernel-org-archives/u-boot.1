Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B287DC4332F
	for <u-boot@archiver.kernel.org>; Tue, 14 Nov 2023 11:05:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7B43D874A8;
	Tue, 14 Nov 2023 12:03:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=salutedevices.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=salutedevices.com header.i=@salutedevices.com header.b="PwUpBH/6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DEEC08727A; Tue, 14 Nov 2023 12:03:37 +0100 (CET)
Received: from mx1.sberdevices.ru (mx2.sberdevices.ru [45.89.224.132])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 01C5587468
 for <u-boot@lists.denx.de>; Tue, 14 Nov 2023 12:03:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=salutedevices.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ivprusov@salutedevices.com
Received: from p-infra-ksmg-sc-msk02 (localhost [127.0.0.1])
 by mx1.sberdevices.ru (Postfix) with ESMTP id 82CD212001B;
 Tue, 14 Nov 2023 14:03:33 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 82CD212001B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
 s=mail; t=1699959813;
 bh=pPYwaJMiDN+dzMmwJCLHo5gQfujLd4HHWxv+F68wlco=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
 b=PwUpBH/6QRViCOWEv/4mCRFe3dDpoFpzDlTxJspyL0kp3lh/O5jL54Kl5XxN+Yapp
 gQfvDbEwuXSC5JX3DxTIozI6MiTwHj56PlUSHtr7qc1yxOGv22XCx28FtlOCpOkAfX
 wbEj+BYom+tTaH7+iYxqWdWnr9lCKOSidRJdN5fCXhUSwCkNLSufMH2LDfjvao5Quy
 QYJU6G5aOJWk5fZGgqRtOgnoy4SfEhxW0WX/apegVevpzjp31S/i3pjISZh36ghWNG
 rBDbul+IrgkQDyPsieqvo/I2uHbax9voFnSbXqSSokdURbZWEwE3zv6wRBx1ZuQnwb
 VZF5miXl6mx8g==
Received: from p-i-exch-sc-m01.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru
 [172.16.192.107])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mx1.sberdevices.ru (Postfix) with ESMTPS;
 Tue, 14 Nov 2023 14:03:33 +0300 (MSK)
Received: from localhost.localdomain (100.64.160.123) by
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.37; Tue, 14 Nov 2023 14:03:33 +0300
From: Igor Prusov <ivprusov@salutedevices.com>
To: <u-boot@lists.denx.de>
CC: <prusovigor@gmail.com>, Simon Glass <sjg@chromium.org>,
 <kernel@sberdevices.ru>, Igor Prusov <ivprusov@salutedevices.com>, Marek
 Vasut <marex@denx.de>
Subject: [PATCH 13/13] musb-new: Remove implementation of io.h functions
Date: Tue, 14 Nov 2023 14:02:57 +0300
Message-ID: <20231114110257.2488-14-ivprusov@salutedevices.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231114110257.2488-1-ivprusov@salutedevices.com>
References: <20231114110257.2488-1-ivprusov@salutedevices.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [100.64.160.123]
X-ClientProxiedBy: p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) To
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 181340 [Nov 14 2023]
X-KSMG-AntiSpam-Version: 6.0.0.2
X-KSMG-AntiSpam-Envelope-From: ivprusov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 543 543
 1e3516af5cdd92079dfeb0e292c8747a62cb1ee4,
 {Tracking_from_domain_doesnt_match_to}, 127.0.0.199:7.1.2;
 salutedevices.com:7.1.1; 100.64.160.123:7.1.2;
 p-i-exch-sc-m01.sberdevices.ru:5.0.1,7.1.1;
 d41d8cd98f00b204e9800998ecf8427e.com:7.1.1, FromAlignment: s,
 ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960,
 bases: 2023/11/14 07:58:00 #22462416
X-KSMG-AntiVirus-Status: Clean, skipped
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

Since {read,write}s{l, w, b}() functions are now supported in linux/io.h
there is no need to add custom implementation to driver.

Signed-off-by: Igor Prusov <ivprusov@salutedevices.com>
---

 drivers/usb/musb-new/musb_io.h | 24 ------------------------
 1 file changed, 24 deletions(-)

diff --git a/drivers/usb/musb-new/musb_io.h b/drivers/usb/musb-new/musb_io.h
index 72a5365632..19b12f36a5 100644
--- a/drivers/usb/musb-new/musb_io.h
+++ b/drivers/usb/musb-new/musb_io.h
@@ -14,31 +14,7 @@
 #ifndef __MUSB_LINUX_PLATFORM_ARCH_H__
 #define __MUSB_LINUX_PLATFORM_ARCH_H__
 
-#ifndef __UBOOT__
 #include <linux/io.h>
-#else
-#include <asm/io.h>
-#endif
-
-#if !defined(CONFIG_ARM) && !defined(CONFIG_SUPERH) \
-	&& !defined(CONFIG_PPC32) \
-	&& !defined(CONFIG_PPC64) && !defined(CONFIG_MIPS) \
-	&& !defined(CONFIG_M68K)
-static inline void readsl(const void __iomem *addr, void *buf, int len)
-	{ insl((unsigned long)addr, buf, len); }
-static inline void readsw(const void __iomem *addr, void *buf, int len)
-	{ insw((unsigned long)addr, buf, len); }
-static inline void readsb(const void __iomem *addr, void *buf, int len)
-	{ insb((unsigned long)addr, buf, len); }
-
-static inline void writesl(const void __iomem *addr, const void *buf, int len)
-	{ outsl((unsigned long)addr, buf, len); }
-static inline void writesw(const void __iomem *addr, const void *buf, int len)
-	{ outsw((unsigned long)addr, buf, len); }
-static inline void writesb(const void __iomem *addr, const void *buf, int len)
-	{ outsb((unsigned long)addr, buf, len); }
-
-#endif
 
 /* NOTE:  these offsets are all in bytes */
 
-- 
2.34.1

