Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8836C4332F
	for <u-boot@archiver.kernel.org>; Tue, 14 Nov 2023 11:04:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 548B4874A1;
	Tue, 14 Nov 2023 12:03:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=salutedevices.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=salutedevices.com header.i=@salutedevices.com header.b="hRF4o4BQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 772FC8747B; Tue, 14 Nov 2023 12:03:31 +0100 (CET)
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [37.18.73.165])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9052F871F8
 for <u-boot@lists.denx.de>; Tue, 14 Nov 2023 12:03:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=salutedevices.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ivprusov@salutedevices.com
Received: from p-infra-ksmg-sc-msk01 (localhost [127.0.0.1])
 by mx1.sberdevices.ru (Postfix) with ESMTP id 104A2100026;
 Tue, 14 Nov 2023 14:03:29 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 104A2100026
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
 s=mail; t=1699959809;
 bh=VGwD1yMuI3B5EMlUs0MxVQF31WIQZcpM9gcXe95sf7Q=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
 b=hRF4o4BQRkVW2gM1COVVhWM2m0T9OJyDAFChy+exImDbiT5JsaX8oQS7esbtI0gLB
 cfJ7k/4OGGN4RJCzOShACIxvHkX8yx/zDFv2G+CsXD6oMEFQZFNCK7DFjdc+eqeyCE
 Cb4gfc54dBU+3Xdph4qtXzUTu7xvbSkUEY8gQX38eXelihuvQgdt4pCYuuGdlBpqE5
 g+sGjzlfiDUEjZPpe7v9o7zmJ5sWb9Sjw0SWTk4JErCvmsHdKxW0LJSdRE2ik6MHv9
 KRUxaiRXCk28BDDSIr5Fb9mwjH34CMctcIJKYZUndTZSyjH6AyMMzwQXR9csMg9Rkr
 y8BcYdiva6BoA==
Received: from p-i-exch-sc-m01.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru
 [172.16.192.107])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mx1.sberdevices.ru (Postfix) with ESMTPS;
 Tue, 14 Nov 2023 14:03:28 +0300 (MSK)
Received: from localhost.localdomain (100.64.160.123) by
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.37; Tue, 14 Nov 2023 14:03:28 +0300
From: Igor Prusov <ivprusov@salutedevices.com>
To: <u-boot@lists.denx.de>
CC: <prusovigor@gmail.com>, Simon Glass <sjg@chromium.org>,
 <kernel@sberdevices.ru>, Igor Prusov <ivprusov@salutedevices.com>, Andy
 Fleming <afleming@gmail.com>, Christophe Leroy <christophe.leroy@csgroup.eu>, 
 Mario Six <mario.six@gdsys.cc>, Priyanka Jain <priyanka.jain@nxp.com>, Stefan
 Roese <sr@denx.de>, Wolfgang Denk <wd@denx.de>
Subject: [PATCH 08/13] powerpc: io.h: Add defines for __raw_{read,
 write} functions
Date: Tue, 14 Nov 2023 14:02:52 +0300
Message-ID: <20231114110257.2488-9-ivprusov@salutedevices.com>
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

Add defines for __raw_{read,write}{b,w,l}() functions to make
make asm-generic/io.h aware of them.

Signed-off-by: Igor Prusov <ivprusov@salutedevices.com>
---

 arch/powerpc/include/asm/io.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/powerpc/include/asm/io.h b/arch/powerpc/include/asm/io.h
index f63cae0bc8..2412bb9d7c 100644
--- a/arch/powerpc/include/asm/io.h
+++ b/arch/powerpc/include/asm/io.h
@@ -138,26 +138,37 @@ static inline unsigned char __raw_readb(const volatile void __iomem *addr)
 {
 	return *(volatile unsigned char *)PCI_FIX_ADDR(addr);
 }
+#define __raw_readb __raw_readb
+
 static inline unsigned short __raw_readw(const volatile void __iomem *addr)
 {
 	return *(volatile unsigned short *)PCI_FIX_ADDR(addr);
 }
+#define __raw_readw __raw_readw
+
 static inline unsigned int __raw_readl(const volatile void __iomem *addr)
 {
 	return *(volatile unsigned int *)PCI_FIX_ADDR(addr);
 }
+#define __raw_readl __raw_readl
+
 static inline void __raw_writeb(unsigned char v, volatile void __iomem *addr)
 {
 	*(volatile unsigned char *)PCI_FIX_ADDR(addr) = v;
 }
+#define __raw_writeb __raw_writeb
+
 static inline void __raw_writew(unsigned short v, volatile void __iomem *addr)
 {
 	*(volatile unsigned short *)PCI_FIX_ADDR(addr) = v;
 }
+#define __raw_writew __raw_writew
+
 static inline void __raw_writel(unsigned int v, volatile void __iomem *addr)
 {
 	*(volatile unsigned int *)PCI_FIX_ADDR(addr) = v;
 }
+#define __raw_writel __raw_writel
 
 /*
  * 8, 16 and 32 bit, big and little endian I/O operations, with barrier.
-- 
2.34.1

