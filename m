Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 884FDC4332F
	for <u-boot@archiver.kernel.org>; Tue, 14 Nov 2023 11:04:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 48BEC87479;
	Tue, 14 Nov 2023 12:03:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=salutedevices.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=salutedevices.com header.i=@salutedevices.com header.b="jjSylyRL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 906008723C; Tue, 14 Nov 2023 12:03:29 +0100 (CET)
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [37.18.73.165])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A6CA98727A
 for <u-boot@lists.denx.de>; Tue, 14 Nov 2023 12:03:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=salutedevices.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ivprusov@salutedevices.com
Received: from p-infra-ksmg-sc-msk01 (localhost [127.0.0.1])
 by mx1.sberdevices.ru (Postfix) with ESMTP id 2F589100023;
 Tue, 14 Nov 2023 14:03:27 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 2F589100023
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
 s=mail; t=1699959807;
 bh=Az7rySAnw4kwZ4aVxArn5e/9umtOK4eV53fp2DTBuBw=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
 b=jjSylyRLD+yjq0s88lqUrOPhkSIxBygK14Ym5m/MUU97omX8/Iv7VUxuXQDvq2NQd
 s0/uIr3/Rb3UxrVXQcmBsl4633kjM7bDcaoalF8vuzs2HwxaPc6+YjfD1KLltXP8WS
 LEeiAizLmqunOQLi6nZDHJu461HT1UQYFa8uK7KJ6nAClCkbZ6MSf4rSGmr+cThSZj
 u85pSJJ6e+kYyCuSOFUjr7j8qhaCVoXDaWERU/AmSyTXqe19y+klbE0XS87sXRl7hn
 sR0HM+8wh0M80lvjT79l+wfpH1DONaV9gzz4ciMSU0rrdN/bp0SZkjQZuesdfn/Mgm
 vT+HKvs6kl1NA==
Received: from p-i-exch-sc-m01.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru
 [172.16.192.107])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mx1.sberdevices.ru (Postfix) with ESMTPS;
 Tue, 14 Nov 2023 14:03:27 +0300 (MSK)
Received: from localhost.localdomain (100.64.160.123) by
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.37; Tue, 14 Nov 2023 14:03:26 +0300
From: Igor Prusov <ivprusov@salutedevices.com>
To: <u-boot@lists.denx.de>
CC: <prusovigor@gmail.com>, Simon Glass <sjg@chromium.org>,
 <kernel@sberdevices.ru>, Igor Prusov <ivprusov@salutedevices.com>, Bin Meng
 <bmeng@tinylab.org>, Chanho Park <chanho61.park@samsung.com>, Leo
 <ycliang@andestech.com>, Rick Chen <rick@andestech.com>
Subject: [PATCH 06/13] riscv: io.h: Fix signatures of reads/writes functions
Date: Tue, 14 Nov 2023 14:02:50 +0300
Message-ID: <20231114110257.2488-7-ivprusov@salutedevices.com>
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

Change type of address parameter from int* to volatile void* for
{read,write}s{b,w,l}() functions and add const qualifier for reads. This
is done to keep function signatures in sync with asm-generic/io.h and
other platforms.

Signed-off-by: Igor Prusov <ivprusov@salutedevices.com>
---

 arch/riscv/include/asm/io.h | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/arch/riscv/include/asm/io.h b/arch/riscv/include/asm/io.h
index cedd5375d6..da16585803 100644
--- a/arch/riscv/include/asm/io.h
+++ b/arch/riscv/include/asm/io.h
@@ -218,7 +218,8 @@ static inline u64 readq(const volatile void __iomem *addr)
 #define insw(p, d, l)			readsw(__io(p), d, l)
 #define insl(p, d, l)			readsl(__io(p), d, l)
 
-static inline void readsb(unsigned int *addr, void *data, int bytelen)
+static inline void readsb(const volatile void __iomem *addr, void *data,
+			  unsigned int bytelen)
 {
 	unsigned char *ptr;
 	unsigned char *ptr2;
@@ -233,7 +234,8 @@ static inline void readsb(unsigned int *addr, void *data, int bytelen)
 	}
 }
 
-static inline void readsw(unsigned int *addr, void *data, int wordlen)
+static inline void readsw(const volatile void __iomem *addr, void *data,
+			  unsigned int wordlen)
 {
 	unsigned short *ptr;
 	unsigned short *ptr2;
@@ -248,7 +250,8 @@ static inline void readsw(unsigned int *addr, void *data, int wordlen)
 	}
 }
 
-static inline void readsl(unsigned int *addr, void *data, int longlen)
+static inline void readsl(const volatile void __iomem *addr, void *data,
+			  unsigned int longlen)
 {
 	unsigned int *ptr;
 	unsigned int *ptr2;
@@ -263,7 +266,8 @@ static inline void readsl(unsigned int *addr, void *data, int longlen)
 	}
 }
 
-static inline void writesb(unsigned int *addr, const void *data, int bytelen)
+static inline void writesb(volatile void __iomem *addr, const void *data,
+			   unsigned int bytelen)
 {
 	unsigned char *ptr;
 	unsigned char *ptr2;
@@ -278,7 +282,8 @@ static inline void writesb(unsigned int *addr, const void *data, int bytelen)
 	}
 }
 
-static inline void writesw(unsigned int *addr, const void *data, int wordlen)
+static inline void writesw(volatile void __iomem *addr, const void *data,
+			   unsigned int wordlen)
 {
 	unsigned short *ptr;
 	unsigned short *ptr2;
@@ -293,7 +298,8 @@ static inline void writesw(unsigned int *addr, const void *data, int wordlen)
 	}
 }
 
-static inline void writesl(unsigned int *addr, const void *data, int longlen)
+static inline void writesl(volatile void __iomem *addr, const void *data,
+			   unsigned int longlen)
 {
 	unsigned int *ptr;
 	unsigned int *ptr2;
-- 
2.34.1

