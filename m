Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 934C4E70717
	for <u-boot@archiver.kernel.org>; Thu, 21 Sep 2023 11:27:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 43EA086C1A;
	Thu, 21 Sep 2023 13:25:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=salutedevices.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=salutedevices.com header.i=@salutedevices.com header.b="WD3ovFl5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 02515803AC; Thu, 21 Sep 2023 10:14:13 +0200 (CEST)
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [37.18.73.165])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CC96486AA8
 for <u-boot@lists.denx.de>; Thu, 21 Sep 2023 10:14:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=salutedevices.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=avromanov@salutedevices.com
Received: from p-infra-ksmg-sc-msk01 (localhost [127.0.0.1])
 by mx1.sberdevices.ru (Postfix) with ESMTP id 62B4F10000F;
 Thu, 21 Sep 2023 11:14:10 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 62B4F10000F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
 s=mail; t=1695284050;
 bh=/iKr9+SjPmi8MKmMUo82/iBJSB1S5w++vVzaB5Z4u3A=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
 b=WD3ovFl5PyBOzx+1uCgQJ3Nl4rWOsNLnyjG8i424SI+UmgI0c6NwO2zc18XnCkoKy
 sZZuhlvmH/li81d449UJ9QXKt/qXeQs6eqy6rSHAqWDIfU9udWTjcmvvIFAA2ga6xp
 702wNAEuTz9O/FaIdQzBA/diQbB/SEBw6Epc545um9lStdj7TYEfP48yBgpDc0wUCe
 n9mz1J3GzLGaMxzYsICJEWWlGeMP+oXUmjXLQN7sO6POVemXbcJ1Q3jG+OgfFvAMHy
 XxsUNGd09IhU2RR457taSPrkmCXKtbVYuRRqRUY39NYtQr9+fRPB/pdN5lPkNEvaQn
 ScPbEjY1h6sMA==
Received: from p-i-exch-sc-m01.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru
 [172.16.192.107])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mx1.sberdevices.ru (Postfix) with ESMTPS;
 Thu, 21 Sep 2023 11:14:10 +0300 (MSK)
Received: from localhost.localdomain (100.64.160.123) by
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Thu, 21 Sep 2023 11:14:09 +0300
From: Alexey Romanov <avromanov@salutedevices.com>
To: <neil.armstrong@linaro.org>, <narmstrong@baylibre.com>, <sjg@google.com>, 
 <takahiro.akashi@linaro.org>, <ilias.apalodimas@linaro.org>,
 <post@lespocky.de>, <marex@denx.de>, <msuchanek@suse.de>,
 <sughosh.ganu@linaro.org>, <jh80.chung@samsung.com>,
 <paul.barker@sancloud.com>
CC: <u-boot-amlogic@groups.io>, <u-boot@lists.denx.de>,
 <kernel@sberdevices.ru>, Alexey Romanov <avromanov@salutedevices.com>, Simon
 Glass <sjg@chromium.org>
Subject: [PATCH v3 7/8] arch: meson: sm: set correct order of the includes
Date: Thu, 21 Sep 2023 11:13:40 +0300
Message-ID: <20230921081346.22157-8-avromanov@salutedevices.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230921081346.22157-1-avromanov@salutedevices.com>
References: <20230921081346.22157-1-avromanov@salutedevices.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [100.64.160.123]
X-ClientProxiedBy: p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) To
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 180016 [Sep 21 2023]
X-KSMG-AntiSpam-Version: 5.9.59.0
X-KSMG-AntiSpam-Envelope-From: avromanov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 534 534
 808c2ea49f7195c68d40844e073217da4fa0d1e3,
 {Tracking_from_domain_doesnt_match_to}, 127.0.0.199:7.1.2;
 d41d8cd98f00b204e9800998ecf8427e.com:7.1.1; 100.64.160.123:7.1.2;
 salutedevices.com:7.1.1;
 p-i-exch-sc-m01.sberdevices.ru:5.0.1,7.1.1, FromAlignment: s,
 ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960,
 bases: 2023/09/21 07:22:00 #21937862
X-KSMG-AntiVirus-Status: Clean, skipped
X-Mailman-Approved-At: Thu, 21 Sep 2023 13:25:12 +0200
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

The common.h header should always be first, followed
by other headers in order, then headers with directories,
then local files.

Signed-off-by: Alexey Romanov <avromanov@salutedevices.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
---
 arch/arm/mach-meson/sm.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-meson/sm.c b/arch/arm/mach-meson/sm.c
index d600c64d0b..b5dd6c6d39 100644
--- a/arch/arm/mach-meson/sm.c
+++ b/arch/arm/mach-meson/sm.c
@@ -6,7 +6,10 @@
  */
 
 #include <common.h>
+#include <dm.h>
 #include <log.h>
+#include <regmap.h>
+#include <syscon.h>
 #include <asm/arch/sm.h>
 #include <asm/cache.h>
 #include <asm/global_data.h>
@@ -14,10 +17,7 @@
 #include <linux/bitops.h>
 #include <linux/err.h>
 #include <linux/kernel.h>
-#include <dm.h>
 #include <linux/bitfield.h>
-#include <regmap.h>
-#include <syscon.h>
 
 #define FN_GET_SHARE_MEM_INPUT_BASE	0x82000020
 #define FN_GET_SHARE_MEM_OUTPUT_BASE	0x82000021
-- 
2.25.1

