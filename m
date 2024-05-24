Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9F0BC25B7A
	for <u-boot@archiver.kernel.org>; Fri, 24 May 2024 12:29:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9F96588552;
	Fri, 24 May 2024 14:28:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=salutedevices.com header.i=@salutedevices.com header.b="A2rdW1ZT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 13FAA87E3F; Fri, 24 May 2024 12:29:40 +0200 (CEST)
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [37.18.73.165])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6F8AE87D4A
 for <u-boot@lists.denx.de>; Fri, 24 May 2024 12:29:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=salutedevices.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=avromanov@salutedevices.com
Received: from p-infra-ksmg-sc-msk01 (localhost [127.0.0.1])
 by mx1.sberdevices.ru (Postfix) with ESMTP id A4641100005;
 Fri, 24 May 2024 13:29:35 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru A4641100005
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
 s=mail; t=1716546575;
 bh=bzZkg6Ozi97XqgiZgA7wL2ZubqGaMWCGJRd8AGfFGBs=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
 b=A2rdW1ZTfW1vhSLZkT1GP4dv27phoafoAla0IimbnnI36ohjAa2FkRK6zU/pW8eew
 m8L9Km3TVRTPJuBV9vMczv0vxAQYy4GiZAGUcVhw/354SmzcTt/drm+MmD8aHfzQ0r
 1Hg1QEhAcA4sDo1vAKeezytsVgE8ES4I/6AhiA16N6fiDK8ts4ZYoIuhffU2zGXVhh
 a778e1iYEv44EH1ENqxZeoRFq1PSiXVpljDkcAk91vMK+PCPuXXC9lbdqM+3F5eZEm
 9YdhBhEWuLqzOrMGYJSd2+NtPrEra53XDy6emh7qHmH/bZbaocfD2X/0AI05+EopM3
 J95RfH7ScEEjw==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m02.sberdevices.ru
 [172.16.192.103])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mx1.sberdevices.ru (Postfix) with ESMTPS;
 Fri, 24 May 2024 13:29:35 +0300 (MSK)
Received: from user-A520M-DS3H.sberdevices.ru (100.64.160.123) by
 p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Fri, 24 May 2024 13:29:33 +0300
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
Subject: [PATCH v4 0/3] Introduce mtdblock device
Date: Fri, 24 May 2024 13:29:17 +0300
Message-ID: <20240524102920.2631731-1-avromanov@salutedevices.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [100.64.160.123]
X-ClientProxiedBy: p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) To
 p-i-exch-sc-m02.sberdevices.ru (172.16.192.103)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 185462 [May 24 2024]
X-KSMG-AntiSpam-Version: 6.1.0.4
X-KSMG-AntiSpam-Envelope-From: avromanov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 20 0.3.20
 743589a8af6ec90b529f2124c2bbfc3ce1d2f20f, {Tracking_uf_ne_domains},
 {Tracking_from_domain_doesnt_match_to}, smtp.sberdevices.ru:5.0.1,7.1.1;
 d41d8cd98f00b204e9800998ecf8427e.com:7.1.1; lore.kernel.org:7.1.1;
 100.64.160.123:7.1.2; salutedevices.com:7.1.1;
 127.0.0.199:7.1.2, FromAlignment: s, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean, bases: 2024/05/24 09:04:00
X-KSMG-LinksScanning: Clean, bases: 2024/05/24 09:04:00
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960,
 bases: 2024/05/24 05:57:00 #25251437
X-KSMG-AntiVirus-Status: Clean, skipped
X-Mailman-Approved-At: Fri, 24 May 2024 14:28:51 +0200
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

Changes V3 -> V4 [4]:

  - Fix build warnings: use LBAF printf format string for lbaint_t types.

Links:

  - [1] https://lore.kernel.org/all/20240227100441.1811047-1-avromanov@salutedevices.com/
  - [2] https://lore.kernel.org/all/20240227100441.1811047-5-avromanov@salutedevices.com/
  - [3] https://lore.kernel.org/u-boot/20240403114047.84030-1-heinrich.schuchardt@canonical.com/T/#u
  - [4] https://lore.kernel.org/all/20240404105813.1520732-1-avromanov@salutedevices.com/


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

