Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0308FC54798
	for <u-boot@archiver.kernel.org>; Thu,  7 Mar 2024 14:56:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2D6B487FC2;
	Thu,  7 Mar 2024 15:56:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=salutedevices.com header.i=@salutedevices.com header.b="QVg/WMpS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4B99387E85; Thu,  7 Mar 2024 14:07:43 +0100 (CET)
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [37.18.73.165])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A00FF87F07
 for <u-boot@lists.denx.de>; Thu,  7 Mar 2024 14:07:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=salutedevices.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=avromanov@salutedevices.com
Received: from p-infra-ksmg-sc-msk01 (localhost [127.0.0.1])
 by mx1.sberdevices.ru (Postfix) with ESMTP id EA34A100025;
 Thu,  7 Mar 2024 16:07:37 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru EA34A100025
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
 s=mail; t=1709816857;
 bh=bHbCrkIs9klDw7bMSzPXeNuoK2f8tmo4sUOuV2A3+RQ=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
 b=QVg/WMpSSh8/PCp7JVKLCL1l60/uQHRg0xKYclN3+iiCdwY6KhNWWyY/zXCqU4oIS
 t+criQ641i7wxW658ALL60JhaxfkGjLYybEPyY+w4i/48K8Qo3XZTCJ/lsnj4ypgqv
 qvda5JeOBQawK41d/RxVhRkNWhhyaHlR9PfF/l46VSY04svmTktUxSyGNbMbVqYka4
 jvdYLi1U2OJGaJDtmCwO3moVhBlcATmda8qkqxs+smhX2HjyciMdDUkftanHtLicXL
 wp65fNX5blJ4oT4dvjxbEgh3ShCfuJI9YDHgxOpf8vHdeA2cP7LgZ+46EmgLFZGnpN
 3zpjX0USATtVQ==
Received: from smtp.sberdevices.ru (p-i-exch-a-m1.sberdevices.ru
 [172.24.196.116])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mx1.sberdevices.ru (Postfix) with ESMTPS;
 Thu,  7 Mar 2024 16:07:37 +0300 (MSK)
Received: from user-A520M-DS3H.sberdevices.ru (100.64.160.123) by
 p-i-exch-a-m1.sberdevices.ru (172.24.196.116) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Thu, 7 Mar 2024 16:07:35 +0300
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
Subject: [PATCH v2 0/3] Introduce mtdblock device
Date: Thu, 7 Mar 2024 16:07:23 +0300
Message-ID: <20240307130726.1582487-1-avromanov@salutedevices.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [100.64.160.123]
X-ClientProxiedBy: p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) To
 p-i-exch-a-m1.sberdevices.ru (172.24.196.116)
X-KSMG-Rule-ID: 1
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 183875 [Feb 29 2024]
X-KSMG-AntiSpam-Version: 6.1.0.3
X-KSMG-AntiSpam-Envelope-From: avromanov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 7 0.3.7
 6d6bf5bd8eea7373134f756a2fd73e9456bb7d1a, {Tracking_uf_ne_domains},
 {Tracking_from_domain_doesnt_match_to}, FromAlignment: s,
 ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean, bases: 2024/02/29 16:52:00
X-KSMG-LinksScanning: Clean, bases: 2024/02/29 16:52:00
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960,
 bases: 2024/02/29 19:21:00 #23899999
X-KSMG-AntiVirus-Status: Clean, skipped
X-Mailman-Approved-At: Thu, 07 Mar 2024 15:55:57 +0100
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

Links:

  - [1] https://lore.kernel.org/all/20240227100441.1811047-1-avromanov@salutedevices.com/
  - [2] https://lore.kernel.org/all/20240227100441.1811047-5-avromanov@salutedevices.com/

Alexey Romanov (3):
  disk: support MTD partitions
  drivers: introduce mtdblock abstraction
  spinand: bind mtdblock

 disk/part.c                 |   5 +-
 drivers/block/blk-uclass.c  |   1 +
 drivers/mtd/Kconfig         |   1 +
 drivers/mtd/Makefile        |   1 +
 drivers/mtd/mtdblock.c      | 227 ++++++++++++++++++++++++++++++++++++
 drivers/mtd/mtdpart.c       |  69 +++++++++++
 drivers/mtd/nand/spi/core.c |  20 ++++
 include/linux/mtd/mtd.h     |  12 ++
 include/part.h              |   2 +
 9 files changed, 337 insertions(+), 1 deletion(-)
 create mode 100644 drivers/mtd/mtdblock.c

-- 
2.34.1

