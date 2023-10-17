Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 933D8CDB474
	for <u-boot@archiver.kernel.org>; Tue, 17 Oct 2023 19:29:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9CD0E86F4C;
	Tue, 17 Oct 2023 21:29:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=salutedevices.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=salutedevices.com header.i=@salutedevices.com header.b="KOMDV+l2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D192D86F46; Tue, 17 Oct 2023 21:29:39 +0200 (CEST)
Received: from mx1.sberdevices.ru (mx2.sberdevices.ru [45.89.224.132])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D2B7086F20
 for <u-boot@lists.denx.de>; Tue, 17 Oct 2023 21:29:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=salutedevices.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ivprusov@salutedevices.com
Received: from p-infra-ksmg-sc-msk02 (localhost [127.0.0.1])
 by mx1.sberdevices.ru (Postfix) with ESMTP id 47D85120004;
 Tue, 17 Oct 2023 22:29:37 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 47D85120004
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
 s=mail; t=1697570977;
 bh=CXf7OrsoOq8yADF0vswt+gPR10Ha7FCARkOQibmE51M=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
 b=KOMDV+l29evlwD7O94g7pGUeew7TBMTfcGUYRhcgEpHqCTubwpYgo2I1HwdutmRFe
 ulynusnfEsN71mt39zKjhE/LX/Utd27VoVMT3RYKVByZgWmsv7MzpGfHF1fOOCOQSA
 WV8UCDcgvi0kzoC0YSMBQIhnINMBKwD3uzPMF3Hr8QgNZvw+a9erz2pi+4o54cobWj
 76qaT1Be/GidhsUwiGopTaQHUN3OgQ81/ARhnvca+E+vAoud2i/uUC/u3Cmju/mzqz
 q3XCXSNHalNXMANBhb4sSv9FktbehXivj5rtBmj+72AjSeGmro19VI5KTi17NTbgFp
 eY/z0HFIgijgQ==
Received: from p-i-exch-sc-m01.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru
 [172.16.192.107])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mx1.sberdevices.ru (Postfix) with ESMTPS;
 Tue, 17 Oct 2023 22:29:37 +0300 (MSK)
Received: from localhost.localdomain (100.64.160.123) by
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.37; Tue, 17 Oct 2023 22:29:36 +0300
From: Igor Prusov <ivprusov@salutedevices.com>
To: Dario Binacchi <dario.binacchi@amarulasolutions.com>, Michael Trimarchi
 <michael@amarulasolutions.com>
CC: <prusovigor@gmail.com>, <kernel@sberdevices.ru>, Igor Prusov
 <ivprusov@salutedevices.com>, Frieder Schrempf <frieder.schrempf@kontron.de>, 
 <u-boot@lists.denx.de>
Subject: [PATCH v2 0/1] mtd: spinand: add support for ESMT F50x1G41LB
Date: Tue, 17 Oct 2023 22:29:25 +0300
Message-ID: <20231017192926.54397-1-ivprusov@salutedevices.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [100.64.160.123]
X-ClientProxiedBy: p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) To
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 180688 [Oct 17 2023]
X-KSMG-AntiSpam-Version: 6.0.0.2
X-KSMG-AntiSpam-Envelope-From: ivprusov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 540 540
 2509a3fe0f7fdc802e7154a32be7c2dd394ab987,
 {Tracking_from_domain_doesnt_match_to}, 100.64.160.123:7.1.2;
 d41d8cd98f00b204e9800998ecf8427e.com:7.1.1; salutedevices.com:7.1.1;
 127.0.0.199:7.1.2;
 p-i-exch-sc-m01.sberdevices.ru:7.1.1,5.0.1, FromAlignment: s,
 ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960,
 bases: 2023/10/17 18:30:00 #22213411
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

This series ports ESMT NAND support from Linux.

Changes in v2:
	- Dropped detect procedure rework patch, since similar one was
	  already applied to u-boot in commit b20913e3cb.
	- Updated NAND_MEMORG values, so that they are correct after
	  mbb parameter was added in 8acaec923b.

Igor Prusov (1):
  mtd: spinand: add support for ESMT F50x1G41LB

 drivers/mtd/nand/spi/Makefile |   3 +-
 drivers/mtd/nand/spi/core.c   |   1 +
 drivers/mtd/nand/spi/esmt.c   | 137 ++++++++++++++++++++++++++++++++++
 include/linux/mtd/spinand.h   |   1 +
 4 files changed, 141 insertions(+), 1 deletion(-)
 create mode 100644 drivers/mtd/nand/spi/esmt.c

-- 
2.34.1

