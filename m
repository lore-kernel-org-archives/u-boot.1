Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A0FEC4332F
	for <u-boot@archiver.kernel.org>; Tue, 14 Nov 2023 11:04:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 42E378745E;
	Tue, 14 Nov 2023 12:03:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=salutedevices.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=salutedevices.com header.i=@salutedevices.com header.b="p0oQYw44";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 152A487440; Tue, 14 Nov 2023 12:03:28 +0100 (CET)
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [37.18.73.165])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 25947870F5
 for <u-boot@lists.denx.de>; Tue, 14 Nov 2023 12:03:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=salutedevices.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ivprusov@salutedevices.com
Received: from p-infra-ksmg-sc-msk01 (localhost [127.0.0.1])
 by mx1.sberdevices.ru (Postfix) with ESMTP id 9DDAD100023;
 Tue, 14 Nov 2023 14:03:25 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 9DDAD100023
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
 s=mail; t=1699959805;
 bh=cpoJ4sKxSEdgC49E7XahbNLBTNDWjmg7ajegLoKHO9M=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
 b=p0oQYw44a+TYDgiH4sn3uthWBU0O2oH6JwA40Dpoisch2jP2bvITieRlgA1YHeka2
 oMNlNQmLzglPPtYh0ZpySZLNajqFSy279/MyIqGjha2meFPCR6XFwiHmnOWyScXfij
 5kGV5HZm2Wyci2RkW9v6+6DiXMwLEjJuCnYUomWasgACIO/u1ZUjBZ5EiF4ecbryst
 6U8764W1SxtzDLjoGppTzoyyOLqpOop6WJ2zoeiVQl1DYkr3YctQbaUUoE5TT9WYHG
 7lBesUaEbBcVTDdqTRiXtjHvxuLa40Y2bPAoTibLXHy8/7CgPVe6uscWGMT1PKWlA2
 0n7CjyL0dfVnQ==
Received: from p-i-exch-sc-m01.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru
 [172.16.192.107])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mx1.sberdevices.ru (Postfix) with ESMTPS;
 Tue, 14 Nov 2023 14:03:25 +0300 (MSK)
Received: from localhost.localdomain (100.64.160.123) by
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.37; Tue, 14 Nov 2023 14:03:25 +0300
From: Igor Prusov <ivprusov@salutedevices.com>
To: <u-boot@lists.denx.de>
CC: <prusovigor@gmail.com>, Simon Glass <sjg@chromium.org>,
 <kernel@sberdevices.ru>, Igor Prusov <ivprusov@salutedevices.com>, Daniel
 Schwierzeck <daniel.schwierzeck@gmail.com>
Subject: [PATCH 04/13] mips: io.h: Add defines for read/write/in/out functions
Date: Tue, 14 Nov 2023 14:02:48 +0300
Message-ID: <20231114110257.2488-5-ivprusov@salutedevices.com>
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
 {Tracking_from_domain_doesnt_match_to},
 d41d8cd98f00b204e9800998ecf8427e.com:7.1.1; salutedevices.com:7.1.1;
 127.0.0.199:7.1.2; p-i-exch-sc-m01.sberdevices.ru:7.1.1,5.0.1;
 100.64.160.123:7.1.2, FromAlignment: s, ApMailHostAddress: 100.64.160.123
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

Add defines for {read,write}{b,w,l,q}(), {read,write}s{b,w,l,q}() and
{in,out}s{b,w,l,q}() functions to make asm-generic/io.h aware of them.

Signed-off-by: Igor Prusov <ivprusov@salutedevices.com>
---

 arch/mips/include/asm/io.h | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/arch/mips/include/asm/io.h b/arch/mips/include/asm/io.h
index 12595c4334..3774acaadc 100644
--- a/arch/mips/include/asm/io.h
+++ b/arch/mips/include/asm/io.h
@@ -336,6 +336,22 @@ BUILDIO_MEM(b, u8)
 BUILDIO_MEM(w, u16)
 BUILDIO_MEM(l, u32)
 BUILDIO_MEM(q, u64)
+#define __raw_readb __raw_readb
+#define __raw_readw __raw_readw
+#define __raw_readl __raw_readl
+#define __raw_readq __raw_readq
+#define __raw_writeb __raw_writeb
+#define __raw_writew __raw_writew
+#define __raw_writel __raw_writel
+#define __raw_writeq __raw_writeq
+#define readb readb
+#define readw readw
+#define readl readl
+#define readq readq
+#define writeb writeb
+#define writew writew
+#define writel writel
+#define writeq writeq
 
 #define __BUILD_IOPORT_PFX(bus, bwlq, type)				\
 	__BUILD_IOPORT_SINGLE(bus, bwlq, type, )			\
@@ -449,8 +465,24 @@ __BUILD_IOPORT_STRING(bwlq, type)
 BUILDSTRING(b, u8)
 BUILDSTRING(w, u16)
 BUILDSTRING(l, u32)
+#define readsb readsb
+#define readsw readsw
+#define readsl readsl
+#define writesb writesb
+#define writesw writesw
+#define writesl writesl
+#define outsb outsb
+#define outsw outsw
+#define outsl outsl
+#define insb insb
+#define insw insw
+#define insl insl
 #ifdef CONFIG_64BIT
 BUILDSTRING(q, u64)
+#define readsq readsq
+#define writesq writesq
+#define insq insq
+#define outsq outsq
 #endif
 
 
-- 
2.34.1

