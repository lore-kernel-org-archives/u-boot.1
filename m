Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53200CD1284
	for <u-boot@archiver.kernel.org>; Thu,  4 Apr 2024 12:22:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 88003881AE;
	Thu,  4 Apr 2024 14:22:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=salutedevices.com header.i=@salutedevices.com header.b="Tz1yeoXd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 88E1F88415; Thu,  4 Apr 2024 12:58:29 +0200 (CEST)
Received: from mx1.sberdevices.ru (mx2.sberdevices.ru [45.89.224.132])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 21E7B88428
 for <u-boot@lists.denx.de>; Thu,  4 Apr 2024 12:58:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=salutedevices.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=avromanov@salutedevices.com
Received: from p-infra-ksmg-sc-msk02 (localhost [127.0.0.1])
 by mx1.sberdevices.ru (Postfix) with ESMTP id 8078C120017;
 Thu,  4 Apr 2024 13:58:26 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 8078C120017
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
 s=mail; t=1712228306;
 bh=XaZ1/Inqf9UnNv/0dRrxZURrMeHv484+aTu1FAWc1r0=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
 b=Tz1yeoXd9HjOxG0AWrrmV9ZUkvn2Lz3P8qur8ksN4Cm5Z6L2nawwyRfFCwEdZ/de+
 hjb4Ja0yOLykbshGw45ZXE6rAbt1Mzf4dEZ6eeP+WZ7G5hRATCh9gaztNPbEd8TMvY
 6RzUIGef/bVKL7zkMvtIGWwO5/sBsOrreJA+gdV/LGPhnSa5cld2eR4Z2asJk5Znfh
 J42o8YADj50kPTEotdZ9mPSpkn6GKH3eMV/N5g9PrI50xS+BVWf2b8xVv43ygSzrUb
 bnFx28oe5zbNYV7zT24rucEaiPWjZB+N6XZKVBjlfmHSTjlpPV4cUq6dqYJvS+s6Zp
 7osZ8uP84u/sQ==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m02.sberdevices.ru
 [172.16.192.103])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mx1.sberdevices.ru (Postfix) with ESMTPS;
 Thu,  4 Apr 2024 13:58:26 +0300 (MSK)
Received: from user-A520M-DS3H.sigma.sbrf.ru (100.64.160.123) by
 p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 4 Apr 2024 13:58:24 +0300
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
Subject: [PATCH v3 0/3] Introduce mtdblock device
Date: Thu, 4 Apr 2024 13:58:10 +0300
Message-ID: <20240404105813.1520732-1-avromanov@salutedevices.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [100.64.160.123]
X-ClientProxiedBy: p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) To
 p-i-exch-sc-m02.sberdevices.ru (172.16.192.103)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 184578 [Apr 04 2024]
X-KSMG-AntiSpam-Version: 6.1.0.4
X-KSMG-AntiSpam-Envelope-From: avromanov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 14 0.3.14
 5a0c43d8a1c3c0e5b0916cc02a90d4b950c01f96, {Tracking_uf_ne_domains},
 {Tracking_from_domain_doesnt_match_to}, lore.kernel.org:7.1.1;
 smtp.sberdevices.ru:7.1.1,5.0.1; d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;
 salutedevices.com:7.1.1; 127.0.0.199:7.1.2;
 100.64.160.123:7.1.2, FromAlignment: s, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean, bases: 2024/04/04 09:20:00
X-KSMG-LinksScanning: Clean, bases: 2024/04/04 09:20:00
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960,
 bases: 2024/04/04 07:34:00 #24651931
X-KSMG-AntiVirus-Status: Clean, skipped
X-Mailman-Approved-At: Thu, 04 Apr 2024 14:22:35 +0200
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

---

Changes V1 -> V2 [1]:

  - Drop patch [2].
  - Add warning if bind NAND mtdblock device.
  - Move documentation of mtdblock implementation
    from commit message to the source code.
  - Remove __maybe_unused from mtd partition functions
    description.
  - Use blk_enabled() instead of #ifdefs.

Changes V2 -> V3 [2]:

  - Rebased over [3].
  - Rename mtd_bread/bwrite -> mtd_blk_read/write.
  - Fix GPL-2.0 license short name definiton in headers.
  - Add empty line after MTD_ENTRY_NUMBERS define.

Links:

  - [1] https://lore.kernel.org/all/20240227100441.1811047-1-avromanov@salutedevices.com/
  - [2] https://lore.kernel.org/all/20240227100441.1811047-5-avromanov@salutedevices.com/
  - [3] https://lore.kernel.org/u-boot/20240403114047.84030-1-heinrich.schuchardt@canonical.com/T/#u

Alexey Romanov (3):
  disk: support MTD partitions
  drivers: introduce mtdblock abstraction
  spinand: bind mtdblock

 disk/part.c                 |   3 +-
 drivers/block/blk-uclass.c  |   1 +
 drivers/mtd/Kconfig         |   1 +
 drivers/mtd/Makefile        |   1 +
 drivers/mtd/mtdblock.c      | 227 ++++++++++++++++++++++++++++++++++++
 drivers/mtd/mtdpart.c       |  69 +++++++++++
 drivers/mtd/nand/spi/core.c |  20 ++++
 include/linux/mtd/mtd.h     |  12 ++
 include/part.h              |   3 +
 9 files changed, 336 insertions(+), 1 deletion(-)
 create mode 100644 drivers/mtd/mtdblock.c

-- 
2.34.1

