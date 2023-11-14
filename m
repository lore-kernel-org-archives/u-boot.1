Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC333C4332F
	for <u-boot@archiver.kernel.org>; Tue, 14 Nov 2023 11:04:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C39E587471;
	Tue, 14 Nov 2023 12:03:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=salutedevices.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=salutedevices.com header.i=@salutedevices.com header.b="BLgfbdO2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9DF5A8744F; Tue, 14 Nov 2023 12:03:28 +0100 (CET)
Received: from mx1.sberdevices.ru (mx2.sberdevices.ru [45.89.224.132])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D4325871F8
 for <u-boot@lists.denx.de>; Tue, 14 Nov 2023 12:03:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=salutedevices.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ivprusov@salutedevices.com
Received: from p-infra-ksmg-sc-msk02 (localhost [127.0.0.1])
 by mx1.sberdevices.ru (Postfix) with ESMTP id 6829E12000D;
 Tue, 14 Nov 2023 14:03:26 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 6829E12000D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
 s=mail; t=1699959806;
 bh=0jojS1xcmjgVVn8d6ZQyrP6A51kS6VyHINN7yX9gAQM=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
 b=BLgfbdO2NJFSB+ehqvSOXv38PNBS0og1NUcDci0PmDkrajI8M/Z+tpiqHnEq8IHEt
 zuCvyhMsMOFSrJW6oaRwVwK0M4nUWrLpSPR2mheqIVIHfsHoFrpRq+vLOL7doA+iVe
 OlKmaL1joFlWcq6ChNT44kW91/gZIw6jpiT7+6MYxBj/5Xg0jMPKHx6Tj05EARamOq
 X7nmupzzmcHX37l43h/P4QEaIT1c8p14luMQ8w1YfMjY5XcixhKi2S0C+PYq3T6H8m
 1tZ6yfStNMPba/V67fcPt9r1eAzkKujlrvMR04ai/lj6rqQawP9E0WVtgkTS924lHs
 +x8MZaB08nodA==
Received: from p-i-exch-sc-m01.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru
 [172.16.192.107])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mx1.sberdevices.ru (Postfix) with ESMTPS;
 Tue, 14 Nov 2023 14:03:26 +0300 (MSK)
Received: from localhost.localdomain (100.64.160.123) by
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.37; Tue, 14 Nov 2023 14:03:25 +0300
From: Igor Prusov <ivprusov@salutedevices.com>
To: <u-boot@lists.denx.de>
CC: <prusovigor@gmail.com>, Simon Glass <sjg@chromium.org>,
 <kernel@sberdevices.ru>, Igor Prusov <ivprusov@salutedevices.com>, Bin Meng
 <bmeng@tinylab.org>, Chanho Park <chanho61.park@samsung.com>, Leo
 <ycliang@andestech.com>, Rick Chen <rick@andestech.com>
Subject: [PATCH 05/13] riscv: io.h: Add defines for reads/writes functions
Date: Tue, 14 Nov 2023 14:02:49 +0300
Message-ID: <20231114110257.2488-6-ivprusov@salutedevices.com>
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

Add defines for {read,write}s{b,w,l} functions to make asm-generic/io.h
aware of them.

Signed-off-by: Igor Prusov <ivprusov@salutedevices.com>
---

 arch/riscv/include/asm/io.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/riscv/include/asm/io.h b/arch/riscv/include/asm/io.h
index 4170877a1a..cedd5375d6 100644
--- a/arch/riscv/include/asm/io.h
+++ b/arch/riscv/include/asm/io.h
@@ -307,6 +307,14 @@ static inline void writesl(unsigned int *addr, const void *data, int longlen)
 		longlen--;
 	}
 }
+
+#define readsb readsb
+#define readsw readsw
+#define readsl readsl
+#define writesb writesb
+#define writesw writesw
+#define writesl writesl
+
 #endif
 
 #define outb_p(val, port)		outb((val), (port))
-- 
2.34.1

