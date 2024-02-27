Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA8E0C5478C
	for <u-boot@archiver.kernel.org>; Tue, 27 Feb 2024 16:25:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4E20B88003;
	Tue, 27 Feb 2024 17:25:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=salutedevices.com header.i=@salutedevices.com header.b="uUKpLsXS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C833987F9B; Tue, 27 Feb 2024 11:04:58 +0100 (CET)
Received: from mx1.sberdevices.ru (mx2.sberdevices.ru [45.89.224.132])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8815A87E62
 for <u-boot@lists.denx.de>; Tue, 27 Feb 2024 11:04:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=salutedevices.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=avromanov@salutedevices.com
Received: from p-infra-ksmg-sc-msk02 (localhost [127.0.0.1])
 by mx1.sberdevices.ru (Postfix) with ESMTP id C413112054F;
 Tue, 27 Feb 2024 13:04:53 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru C413112054F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
 s=mail; t=1709028293;
 bh=jgAWHKRZLCDrxeZeNiZGCRHyN3cu/qn9haSaHDBCrCY=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
 b=uUKpLsXSL6qlqlmEKpyDPm3Fr6ormLsGh+A36CkB/Q7e9Fq+Bb1Rlr7j1BarEG9VH
 S6GDlzQFDFLK97AGjJKpW/f8AAF4oGo6xIN9l7i7nzFpciY4J6knZrHCvwIdpX6yAo
 aFDKi35iMoMT2TDXCy5WPN1pirBjamTMXE49mBU81bbEqXkwmWbIzqpdaTDnffA4ep
 K5CyqDuP9xz4UWGbeHASbWwGDnSRcVFj/LBOesx7aarswg220BNaiQYiD0JjIT1eAo
 fhP6G97rh58Nd+mqz0oRGjCMZ0qqlMphrQ+Z3whO/zUZLs7gie30uss3wUEwoEtR5v
 swQpqzVnH09oA==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru
 [172.16.192.107])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mx1.sberdevices.ru (Postfix) with ESMTPS;
 Tue, 27 Feb 2024 13:04:53 +0300 (MSK)
Received: from user-A520M-DS3H.sigma.sbrf.ru (100.64.160.123) by
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 27 Feb 2024 13:04:52 +0300
From: Alexey Romanov <avromanov@salutedevices.com>
To: <dario.binacchi@amarulasolutions.com>, <michael@amarulasolutions.com>,
 <frieder.schrempf@kontron.de>, <xypron.glpk@gmx.de>,
 <ilias.apalodimas@linaro.org>, <sjg@chromium.org>, <bmeng@tinylab.org>,
 <tobias@waldekranz.com>, <jpewhacker@gmail.com>,
 <marek.vasut+renesas@mailbox.org>, <kever.yang@rock-chips.com>,
 <jbx6244@gmail.com>, <abdellatif.elkhlifi@arm.com>, <michal.simek@amd.com>,
 <mikhail.kshevetskiy@iopsys.eu>, <patrice.chotard@foss.st.com>
CC: <kernel@salutedevices.com>, <u-boot@lists.denx.de>, Alexey Romanov
 <avromanov@salutedevices.com>
Subject: [PATCH v1 0/4] Introduce mtdblock device
Date: Tue, 27 Feb 2024 13:04:37 +0300
Message-ID: <20240227100441.1811047-1-avromanov@salutedevices.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [100.64.160.123]
X-ClientProxiedBy: p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) To
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 183764 [Feb 27 2024]
X-KSMG-AntiSpam-Version: 6.1.0.3
X-KSMG-AntiSpam-Envelope-From: avromanov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 7 0.3.7
 6d6bf5bd8eea7373134f756a2fd73e9456bb7d1a,
 {Tracking_from_domain_doesnt_match_to}, 100.64.160.123:7.1.2;
 smtp.sberdevices.ru:7.1.1,5.0.1; 127.0.0.199:7.1.2; salutedevices.com:7.1.1;
 d41d8cd98f00b204e9800998ecf8427e.com:7.1.1, FromAlignment: s,
 ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960,
 bases: 2024/02/27 05:19:00 #23841006
X-KSMG-AntiVirus-Status: Clean, skipped
X-Mailman-Approved-At: Tue, 27 Feb 2024 17:25:20 +0100
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

Hello!

This series adds support for the mtdblock device, which
allows to read/write data block by block. For example,
it can now be used for BCB or Android AB command:

  $ bcb load mtd 0 part_name

Tested only on SPI NAND, so bind is made only for
SPI NAND drivers.

Alexey Romanov (4):
  drivers: introduce mtdblock abstraction
  disk: support MTD partitions
  spinand: bind mtdblock
  efi: block: compile only if CONFIG_EFI_PARTITION enabled

 disk/part.c                 |   5 +-
 drivers/block/blk-uclass.c  |   1 +
 drivers/mtd/Kconfig         |   1 +
 drivers/mtd/Makefile        |   1 +
 drivers/mtd/mtdblock.c      | 170 ++++++++++++++++++++++++++++++++++++
 drivers/mtd/mtdpart.c       |  69 +++++++++++++++
 drivers/mtd/nand/spi/core.c |  20 +++++
 include/linux/mtd/mtd.h     |  12 +++
 include/part.h              |   2 +
 lib/efi_driver/Makefile     |   2 +-
 10 files changed, 281 insertions(+), 2 deletions(-)
 create mode 100644 drivers/mtd/mtdblock.c

-- 
2.34.1

