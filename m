Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8880CC25B78
	for <u-boot@archiver.kernel.org>; Tue,  4 Jun 2024 13:19:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 40211884BD;
	Tue,  4 Jun 2024 15:18:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=salutedevices.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="key not found in DNS" (0-bit key; unprotected) header.d=salutedevices.com header.i=@salutedevices.com header.b="qitRKDdx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1E33A88363; Mon,  3 Jun 2024 17:57:54 +0200 (CEST)
Received: from mx1.sberdevices.ru (mx2.sberdevices.ru [45.89.224.132])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D8A0488260
 for <u-boot@lists.denx.de>; Mon,  3 Jun 2024 17:57:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=salutedevices.com
Authentication-Results: phobos.denx.de;
 spf=none smtp.mailfrom=avromanov@salutedevices.com
Received: from p-infra-ksmg-sc-msk02.sberdevices.ru (localhost [127.0.0.1])
 by mx1.sberdevices.ru (Postfix) with ESMTP id 6B700120006;
 Mon,  3 Jun 2024 18:57:51 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 6B700120006
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
 s=mail; t=1717430271;
 bh=B1zpB8uJwaht3eBxfq9WCO/M/QyAFuOlYpbimjgzPXw=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
 b=qitRKDdx9dLcfID2dZfpFGFLU1Fd0yr1XMXn1bkpvb4IHLf4EyaF+N7PSKcBZZJ1k
 fnjbZ+eJS7V7O7cuNmhKn3hwwKx1CNGXQZbyFtxIA9TSKLJtNsl2EM/rpEFFKIqo9e
 2KRgLb16KKhsGOOWZjtDHFpItC+XSlN98HWaDBE3L68S1ePAYguI1Pw/13a8sQ7Dq5
 kS8rkfjf0UvOVF2Vda2WmrlsCFuKtpKdleM9/RqbBHealPtf/VmRkIS39Ojsrmt2WC
 KjbcsKCT8T+40/mtopCKcSSnoPeO3z4jCKsq/lmlMgGdwK37jboa2o3I//KW9pxF9i
 KFPnJvZumHgHw==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m02.sberdevices.ru
 [172.16.192.103])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mx1.sberdevices.ru (Postfix) with ESMTPS;
 Mon,  3 Jun 2024 18:57:51 +0300 (MSK)
Received: from user-A520M-DS3H.sigma.sbrf.ru (100.64.160.123) by
 p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 3 Jun 2024 18:57:50 +0300
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
Subject: [PATCH v4 0/6] Introduce UBI block device
Date: Mon, 3 Jun 2024 18:57:34 +0300
Message-ID: <20240603155740.1840571-1-avromanov@salutedevices.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [100.64.160.123]
X-ClientProxiedBy: p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) To
 p-i-exch-sc-m02.sberdevices.ru (172.16.192.103)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 185690 [Jun 03 2024]
X-KSMG-AntiSpam-Version: 6.1.0.4
X-KSMG-AntiSpam-Envelope-From: avromanov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 20 0.3.20
 743589a8af6ec90b529f2124c2bbfc3ce1d2f20f, {Tracking_uf_ne_domains},
 {Tracking_from_domain_doesnt_match_to}, salutedevices.com:7.1.1;
 127.0.0.199:7.1.2; d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;
 smtp.sberdevices.ru:7.1.1,5.0.1; lore.kernel.org:7.1.1;
 100.64.160.123:7.1.2, FromAlignment: s, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean, bases: 2024/06/03 09:40:00
X-KSMG-LinksScanning: Clean, bases: 2024/06/03 09:40:00
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960,
 bases: 2024/06/03 09:35:00 #25420383
X-KSMG-AntiVirus-Status: Clean, skipped
X-Mailman-Approved-At: Tue, 04 Jun 2024 15:18:43 +0200
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

Links:

  [1] https://lore.kernel.org/all/20240227100441.1811047-1-avromanov@salutedevices.com/
  [2] https://lore.kernel.org/all/20240306134906.1179285-1-avromanov@salutedevices.com/
  [3] https://lore.kernel.org/all/20240307130726.1582487-1-avromanov@salutedevices.com/
  [4] https://lore.kernel.org/all/20240325144148.3738195-1-avromanov@salutedevices.com/
  [5] https://lore.kernel.org/all/20240524111319.3512009-1-avromanov@salutedevices.com/

Alexey Romanov (6):
  ubi: allow to read from volume with offset
  ubi: allow to write to volume with offset
  drivers: introduce UBI block abstraction
  disk: don't try search for partition type if already set
  disk: support UBI partitions
  spinand: bind UBI block

 cmd/ubi.c                   |  77 +++++++++++++++++++--
 disk/part.c                 |   7 ++
 drivers/block/blk-uclass.c  |   1 +
 drivers/mtd/nand/spi/core.c |   8 ++-
 drivers/mtd/ubi/Makefile    |   1 +
 drivers/mtd/ubi/block.c     | 130 ++++++++++++++++++++++++++++++++++++
 drivers/mtd/ubi/part.c      |  99 +++++++++++++++++++++++++++
 env/ubi.c                   |  16 ++---
 include/part.h              |   2 +
 include/ubi_uboot.h         |   8 ++-
 10 files changed, 332 insertions(+), 17 deletions(-)
 create mode 100644 drivers/mtd/ubi/block.c
 create mode 100644 drivers/mtd/ubi/part.c

-- 
2.34.1

