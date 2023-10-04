Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F01B1E7C4D0
	for <u-boot@archiver.kernel.org>; Wed,  4 Oct 2023 15:07:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BF69D874EA;
	Wed,  4 Oct 2023 17:07:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=salutedevices.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=salutedevices.com header.i=@salutedevices.com header.b="Gy/BNVmu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9E450874F8; Wed,  4 Oct 2023 17:07:43 +0200 (CEST)
Received: from mx1.sberdevices.ru (mx2.sberdevices.ru [45.89.224.132])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E4C1086EE6
 for <u-boot@lists.denx.de>; Wed,  4 Oct 2023 17:07:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=salutedevices.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ivprusov@salutedevices.com
Received: from p-infra-ksmg-sc-msk02 (localhost [127.0.0.1])
 by mx1.sberdevices.ru (Postfix) with ESMTP id 89F5112000A;
 Wed,  4 Oct 2023 18:07:36 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 89F5112000A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
 s=mail; t=1696432056;
 bh=9t4hN7TvOB3oFgcfRHVVnIIgxMXKJwu77QsowXVb03Y=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
 b=Gy/BNVmuIFl+DIJDguYxmWKXdZuw+cRaPm/iEoLdWNatyOj9JMw3PkfPAIOHeKRFz
 UYKDKrrWBeuBo5RQcSjScNMia/6l+NkvOx3QnOlO1LD1p64D7gbuvGlw3BdQi9W831
 /hL5b5uwnUZzxd8YDsUpt4dLm+5GBkk5GNA0j/1lb1A48peGawIMff1aDZYjtVNvbq
 y0aeVp9CnmBz3/vYy2ehyiMOhhOdyKC7liEMelTJclphqy5B+USIa6lbbISlRoqXT/
 wrQznGnSysU5Juby9YlxXzvVGll+saCSmpKetY7YxUXLIIwLsrdA1H4JyDQ/9GVSDl
 Pe3A5UrX6FjAw==
Received: from p-i-exch-sc-m01.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru
 [172.16.192.107])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mx1.sberdevices.ru (Postfix) with ESMTPS;
 Wed,  4 Oct 2023 18:07:36 +0300 (MSK)
Received: from localhost.localdomain (100.64.160.123) by
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Wed, 4 Oct 2023 18:07:36 +0300
From: Igor Prusov <ivprusov@salutedevices.com>
To: Dario Binacchi <dario.binacchi@amarulasolutions.com>, Michael Trimarchi
 <michael@amarulasolutions.com>, Frieder Schrempf
 <frieder.schrempf@kontron.de>, Martin Kurbanov <mmkurbanov@sberdevices.ru>,
 Chuanhong Guo <gch981213@gmail.com>, Dmitry Rokosov
 <ddrokosov@sberdevices.ru>, Igor Prusov <ivprusov@salutedevices.com>, Simon
 Glass <sjg@chromium.org>, Patrice Chotard <patrice.chotard@foss.st.com>
CC: <prusovigor@gmail.com>, <kernel@sberdevices.ru>, <u-boot@lists.denx.de>
Subject: [PATCH v1 0/2] mtd: spinand: add support for ESMT F50x1G41LB
Date: Wed, 4 Oct 2023 18:07:02 +0300
Message-ID: <20231004150704.49945-1-ivprusov@salutedevices.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [100.64.160.123]
X-ClientProxiedBy: p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) To
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 180354 [Oct 04 2023]
X-KSMG-AntiSpam-Version: 6.0.0.2
X-KSMG-AntiSpam-Envelope-From: ivprusov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 535 535
 da804c0ea8918f802fc60e7a20ba49783d957ba2,
 {Tracking_from_domain_doesnt_match_to},
 d41d8cd98f00b204e9800998ecf8427e.com:7.1.1; salutedevices.com:7.1.1;
 100.64.160.123:7.1.2; p-i-exch-sc-m01.sberdevices.ru:7.1.1,5.0.1;
 127.0.0.199:7.1.2, FromAlignment: s, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960,
 bases: 2023/10/04 12:58:00 #22056622
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

This series ports ESMT NAND support from Linux. Since both ESMT and
Gigadevice use the same manufacturer ID, core part of SPI NAND framework
should be updated as well to allow for such chips detection. Currently
all detect() ops return an error code when chip's manufacturer ID
matches, but device ID does not. This forces spinand_manufacturer_detect
function to stop and report an error. Porting a rework from Linux allows
us to fix this issue and keep u-boot and kernel in sync.

Igor Prusov (2):
  mtd: spinand: rework detect procedure for different READ_ID operation
  mtd: spinand: add support for ESMT F50x1G41LB

 drivers/mtd/nand/spi/Makefile     |   2 +-
 drivers/mtd/nand/spi/core.c       |  86 ++++++++++++++-----
 drivers/mtd/nand/spi/esmt.c       | 137 ++++++++++++++++++++++++++++++
 drivers/mtd/nand/spi/gigadevice.c |  30 ++-----
 drivers/mtd/nand/spi/macronix.c   |  45 ++++------
 drivers/mtd/nand/spi/micron.c     |  50 +++++------
 drivers/mtd/nand/spi/toshiba.c    |  66 +++++++-------
 drivers/mtd/nand/spi/winbond.c    |  34 ++------
 include/linux/mtd/spinand.h       |  67 ++++++++++-----
 9 files changed, 325 insertions(+), 192 deletions(-)
 create mode 100644 drivers/mtd/nand/spi/esmt.c

-- 
2.34.1

