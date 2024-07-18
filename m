Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 022A2C3DA60
	for <u-boot@archiver.kernel.org>; Thu, 18 Jul 2024 08:35:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7E13288A3A;
	Thu, 18 Jul 2024 10:35:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=salutedevices.com header.i=@salutedevices.com header.b="QFwCNYbd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CE88E88AFF; Thu, 18 Jul 2024 07:45:44 +0200 (CEST)
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [37.18.73.165])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0C84B884AC
 for <u-boot@lists.denx.de>; Thu, 18 Jul 2024 07:45:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=salutedevices.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=avromanov@salutedevices.com
Received: from p-infra-ksmg-sc-msk01.sberdevices.ru (localhost [127.0.0.1])
 by mx1.sberdevices.ru (Postfix) with ESMTP id 4E1A410000D;
 Thu, 18 Jul 2024 08:45:40 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 4E1A410000D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
 s=mail; t=1721281540;
 bh=xCAWD8M2KWc/55yZBtgwNwnhNJTswSuVXuBjuUIJp/o=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
 b=QFwCNYbd4O1Yk8NpNUBdQSmdHi7SPfpt61DUG9cL4Idjy5ClvVrvy9OpkazePPVNi
 /FSyKPvQoMeWziGYZtg7WDbbFPpzASEfLcKeMMny96eHOizxtIq5cgBsLgIt4dN4Xy
 egrz8kjDy7BU2aHLBsaQRSv2gvZw4QkbCHMEWWCLlj5gAD1pPe2WVGZFUWOA8fLQoZ
 bh0RtxNcITQv39r3/tieEP6UbZzC39oIPzCIg/f1WH8cBMXKe7CM+IV/pjY7NBhQ8a
 2oAl4NbfyNwe++CfKIi2pOvoZpUJRncRYbjV/XDDaAtK2BytMsPiiUzyF6hqOl0ZTC
 qo3M61C5YIWPQ==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m02.sberdevices.ru
 [172.16.192.103])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mx1.sberdevices.ru (Postfix) with ESMTPS;
 Thu, 18 Jul 2024 08:45:40 +0300 (MSK)
Received: from user-A520M-DS3H.sberdevices.ru (100.64.160.123) by
 p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 18 Jul 2024 08:45:38 +0300
From: Alexey Romanov <avromanov@salutedevices.com>
To: <dario.binacchi@amarulasolutions.com>, <michael@amarulasolutions.com>,
 <frieder.schrempf@kontron.de>, <kmpark@infradead.org>, <hs@denx.de>,
 <joe.hershberger@ni.com>, <dunaev@tecon.ru>, <sjg@chromium.org>,
 <bmeng@tinylab.org>, <xypron.glpk@gmx.de>, <tobias@waldekranz.com>,
 <jpewhacker@gmail.com>, <marek.vasut+renesas@mailbox.org>,
 <kever.yang@rock-chips.com>, <jbx6244@gmail.com>,
 <abdellatif.elkhlifi@arm.com>, <mikhail.kshevetskiy@iopsys.eu>,
 <jagan@amarulasolutions.com>
CC: <kernel@salutedevices.com>, <u-boot@lists.denx.de>, Alexey Romanov
 <avromanov@salutedevices.com>
Subject: [PATCH v6 0/6] Introduce UBI block device
Date: Thu, 18 Jul 2024 08:45:22 +0300
Message-ID: <20240718054528.799539-1-avromanov@salutedevices.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [100.64.160.123]
X-ClientProxiedBy: p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) To
 p-i-exch-sc-m02.sberdevices.ru (172.16.192.103)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 186573 [Jul 18 2024]
X-KSMG-AntiSpam-Version: 6.1.0.4
X-KSMG-AntiSpam-Envelope-From: avromanov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 24 0.3.24
 186c4d603b899ccfd4883d230c53f273b80e467f, {Tracking_uf_ne_domains},
 {Tracking_from_domain_doesnt_match_to}, smtp.sberdevices.ru:5.0.1,7.1.1;
 lore.kernel.org:7.1.1; 127.0.0.199:7.1.2; salutedevices.com:7.1.1;
 100.64.160.123:7.1.2;
 d41d8cd98f00b204e9800998ecf8427e.com:7.1.1, FromAlignment: s,
 ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean, bases: 2024/07/18 05:26:00
X-KSMG-LinksScanning: Clean, bases: 2024/07/18 05:26:00
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960,
 bases: 2024/07/18 03:46:00 #26059015
X-KSMG-AntiVirus-Status: Clean, skipped
X-Mailman-Approved-At: Thu, 18 Jul 2024 10:35:04 +0200
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

This series adds support for the UBI block device, which
allows to read/write data block by block. For example,
it can now be used for BCB or Android AB command:

  $ bcb load ubi 0 part_name

Tested only on SPI NAND, so bind is made only for
SPI NAND drivers. Can be used with mtdblock device [1].

---

Changes V1 -> V2 [2]:

 - Rebased over mtdblock v2 patchset [3].
 - Compile UBI partitions support only if CONFIG_BLK option
   is enabled.

Changes V2 -> V3 [4]:

 - Fix build warnings: use LBAF printf format string for lbaint_t types.

Changes V3 -> V4 [5]:

 - Rebased over u-boot/master.
 - Fix build errors and warnings if CONFIG_BLK isn't enabled.
 - Fix failed tests in cases is ubiblock device isn't binded.

Changes V4 -> V5 [6]:

  - Rebased over u-boot/master.
  - Fix build errors when CONFIG_MTD and CONFIG_MTD_UBI isn't enabled.
  - Use auto blk device devnum generation when call
    blk_create_devicef (pass -1 parameter instead of dev_seq(dev)).

Changes V5 -> V6 [7]:

  - Rebased over u-boot/master.
  - Introduce CONFIG_UBI_BLOCK which is disabled by default.
  - Fix undefined reference to `__aeabi_ldivmod' compiler error for 32-bit ARM targets.

Links:

  [1] https://lore.kernel.org/all/20240227100441.1811047-1-avromanov@salutedevices.com/
  [2] https://lore.kernel.org/all/20240306134906.1179285-1-avromanov@salutedevices.com/
  [3] https://lore.kernel.org/all/20240307130726.1582487-1-avromanov@salutedevices.com/
  [4] https://lore.kernel.org/all/20240325144148.3738195-1-avromanov@salutedevices.com/
  [5] https://lore.kernel.org/all/20240524111319.3512009-1-avromanov@salutedevices.com/
  [6] https://lore.kernel.org/all/20240603155740.1840571-1-avromanov@salutedevices.com/
  [7] https://lore.kernel.org/all/20240626104527.2811828-1-avromanov@salutedevices.com/

Alexey Romanov (6):
  ubi: allow to read from volume with offset
  ubi: allow to write to volume with offset
  drivers: introduce UBI block abstraction
  disk: don't try search for partition type if already set
  disk: support UBI partitions
  spinand: bind UBI block

 cmd/ubi.c                   |  78 ++++++++++++++++++++--
 disk/part.c                 |   7 ++
 drivers/block/blk-uclass.c  |   1 +
 drivers/mtd/nand/spi/core.c |  12 +++-
 drivers/mtd/ubi/Kconfig     |   7 ++
 drivers/mtd/ubi/Makefile    |   1 +
 drivers/mtd/ubi/block.c     | 130 ++++++++++++++++++++++++++++++++++++
 drivers/mtd/ubi/part.c      |  99 +++++++++++++++++++++++++++
 env/ubi.c                   |  16 ++---
 include/part.h              |   2 +
 include/ubi_uboot.h         |  13 +++-
 11 files changed, 348 insertions(+), 18 deletions(-)
 create mode 100644 drivers/mtd/ubi/block.c
 create mode 100644 drivers/mtd/ubi/part.c

-- 
2.34.1

