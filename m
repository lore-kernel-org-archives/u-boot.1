Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1496C4332F
	for <u-boot@archiver.kernel.org>; Tue, 14 Nov 2023 11:03:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A7AB28727E;
	Tue, 14 Nov 2023 12:03:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=salutedevices.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=salutedevices.com header.i=@salutedevices.com header.b="SBmVXwqe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6829B87438; Tue, 14 Nov 2023 12:03:26 +0100 (CET)
Received: from mx1.sberdevices.ru (mx2.sberdevices.ru [45.89.224.132])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9CD6E871F8
 for <u-boot@lists.denx.de>; Tue, 14 Nov 2023 12:03:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=salutedevices.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ivprusov@salutedevices.com
Received: from p-infra-ksmg-sc-msk02 (localhost [127.0.0.1])
 by mx1.sberdevices.ru (Postfix) with ESMTP id 20266120004;
 Tue, 14 Nov 2023 14:03:23 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 20266120004
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
 s=mail; t=1699959803;
 bh=xeYuC0ut1PNx/LZWm6YaaZEaZ9GvxHbShWxJOm1499A=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
 b=SBmVXwqem9zqU7op749gs20z/HotlBNssiFnm4ciyTuwe28nCGTmirnzgPe3A4XVq
 0cWFcdqfbCycjQkZ0jPshqLFprlTpbFhfLEL2DDhjPWqj4SQYXyLBlr0RBNjX8zQFD
 U19/mEztVa8tr+LsZGBj0tHNpqFgZus1oYUuXMqqKXj+QPilbjY+Aah9abwFqacjog
 B7PM1IlIVbysjNvKRA3A36De07pM0OlyMFV04AmaHmYN4EbS4Q6IenJT+DSFEXtU32
 Gu6a9IU13ghpiFX8G/PplPYeyG2O4tsIDSa7vKgB1XtAtIaBTe/yA0W39sNKvPrcX3
 xVbptdlbwI1wQ==
Received: from p-i-exch-sc-m01.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru
 [172.16.192.107])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mx1.sberdevices.ru (Postfix) with ESMTPS;
 Tue, 14 Nov 2023 14:03:22 +0300 (MSK)
Received: from localhost.localdomain (100.64.160.123) by
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.37; Tue, 14 Nov 2023 14:03:22 +0300
From: Igor Prusov <ivprusov@salutedevices.com>
To: <u-boot@lists.denx.de>
CC: <prusovigor@gmail.com>, Simon Glass <sjg@chromium.org>,
 <kernel@sberdevices.ru>, Igor Prusov <ivprusov@salutedevices.com>, Abdellatif
 El Khlifi <abdellatif.elkhlifi@arm.com>
Subject: [PATCH 01/13] sandbox: move asm-generic include to the end of file
Date: Tue, 14 Nov 2023 14:02:45 +0300
Message-ID: <20231114110257.2488-2-ivprusov@salutedevices.com>
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

Generic version of io.h should be included at the end of
architecture-specific ones to make sure that arch implementations are
used and to avoid redefinitions.

Signed-off-by: Igor Prusov <ivprusov@salutedevices.com>
---

 arch/sandbox/include/asm/io.h | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/arch/sandbox/include/asm/io.h b/arch/sandbox/include/asm/io.h
index 31ab7289b4..77a02e5f52 100644
--- a/arch/sandbox/include/asm/io.h
+++ b/arch/sandbox/include/asm/io.h
@@ -28,20 +28,6 @@ void *map_physmem(phys_addr_t paddr, unsigned long len, unsigned long flags);
 void unmap_physmem(const void *vaddr, unsigned long flags);
 #define unmap_physmem unmap_physmem
 
-#include <asm-generic/io.h>
-
-/* For sandbox, we want addresses to point into our RAM buffer */
-static inline void *map_sysmem(phys_addr_t paddr, unsigned long len)
-{
-	return map_physmem(paddr, len, MAP_WRBACK);
-}
-
-/* Remove a previous mapping */
-static inline void unmap_sysmem(const void *vaddr)
-{
-	unmap_physmem(vaddr, MAP_WRBACK);
-}
-
 /* Map from a pointer to our RAM buffer */
 phys_addr_t map_to_sysmem(const void *ptr);
 
@@ -229,5 +215,19 @@ static inline void memcpy_toio(volatile void *dst, const void *src, int count)
 
 #include <iotrace.h>
 #include <asm/types.h>
+#include <asm-generic/io.h>
+
+/* For sandbox, we want addresses to point into our RAM buffer */
+static inline void *map_sysmem(phys_addr_t paddr, unsigned long len)
+{
+	return map_physmem(paddr, len, MAP_WRBACK);
+}
+
+/* Remove a previous mapping */
+static inline void unmap_sysmem(const void *vaddr)
+{
+	unmap_physmem(vaddr, MAP_WRBACK);
+}
+
 
 #endif
-- 
2.34.1

