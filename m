Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27553C3DA6E
	for <u-boot@archiver.kernel.org>; Thu, 28 Dec 2023 15:41:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BF68287ACD;
	Thu, 28 Dec 2023 16:40:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=salutedevices.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=salutedevices.com header.i=@salutedevices.com header.b="U2IPSJP0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5329887AC9; Thu, 28 Dec 2023 16:39:36 +0100 (CET)
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [37.18.73.165])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7411C87A89
 for <u-boot@lists.denx.de>; Thu, 28 Dec 2023 16:39:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=salutedevices.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=avromanov@salutedevices.com
Received: from p-infra-ksmg-sc-msk01 (localhost [127.0.0.1])
 by mx1.sberdevices.ru (Postfix) with ESMTP id 852F7100039;
 Thu, 28 Dec 2023 18:39:31 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 852F7100039
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
 s=mail; t=1703777971;
 bh=7dI5gW74+C4VDUZR6O4C0Yjm2/4KRRlX2/ZMGdnERzQ=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
 b=U2IPSJP0fJ8yC+KEeK25a8m/RZgdTxoqaoco/N/6qZq+xrGawniYZgKyFBUPOvS1f
 B7LCA2y8NZ0K+ffZ4ij+rLZkOKQRoxgrm4QSjgYXHlmTEgmgzLwhTVmBdwP16qcpcb
 VV1BlqC8O8JnbPMF24XvShQ9mZ/vLt/XAdC9RAVSHPmoTjw2Bleh8hGkFcikWxKMBq
 aDWasPHtC+/TJI15o360zQuOWJms+HR7KYAO3H1DcXF9nzYBoTkaYZbNHK4RO/sp4/
 eSaV5FMGIkbY958+kofGmFTtp4NU9y4CrcI89rCM++BKGzqEQN5xJRCQJQftVX09kp
 XKPuOIfRcm6IQ==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru
 [172.16.192.107])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mx1.sberdevices.ru (Postfix) with ESMTPS;
 Thu, 28 Dec 2023 18:39:29 +0300 (MSK)
Received: from cab-wsm-0029881.sberdevices.ru (100.64.160.123) by
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 28 Dec 2023 18:39:29 +0300
From: Alexey Romanov <avromanov@salutedevices.com>
To: <michal.simek@amd.com>, <marex@denx.de>, <michael@walle.cc>,
 <stcarlso@linux.microsoft.com>, <tobias@waldekranz.com>,
 <seanedmond@microsoft.com>, <abdellatif.elkhlifi@arm.com>,
 <neil.armstrong@linaro.org>, <n-jain1@ti.com>, <xypron.glpk@gmx.de>,
 <dario.binacchi@amarulasolutions.com>, <michael@amarulasolutions.com>,
 <frieder.schrempf@kontron.de>, <sjg@chromium.org>, <hs@denx.de>,
 <sean.anderson@seco.com>, <dimorinny@google.com>,
 <mkorpershoek@baylibre.com>, <patrick.delaunay@foss.st.com>
CC: <u-boot@lists.denx.de>, <kernel@salutedevices.com>, Alexey Romanov
 <avromanov@salutedevices.com>
Subject: [PATCH v1 00/12] Support SPI NAND in fastboot protocol
Date: Thu, 28 Dec 2023 18:39:03 +0300
Message-ID: <20231228153922.84323-1-avromanov@salutedevices.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [100.64.160.123]
X-ClientProxiedBy: p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) To
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 182415 [Dec 28 2023]
X-KSMG-AntiSpam-Version: 6.1.0.3
X-KSMG-AntiSpam-Envelope-From: avromanov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 7 0.3.7
 6d6bf5bd8eea7373134f756a2fd73e9456bb7d1a,
 {Tracking_from_domain_doesnt_match_to}, smtp.sberdevices.ru:5.0.1,7.1.1;
 d41d8cd98f00b204e9800998ecf8427e.com:7.1.1; salutedevices.com:7.1.1;
 127.0.0.199:7.1.2;
 100.64.160.123:7.1.2, FromAlignment: s, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960,
 bases: 2023/12/28 11:18:00 #22863388
X-KSMG-AntiVirus-Status: Clean, skipped
X-Mailman-Approved-At: Thu, 28 Dec 2023 16:40:43 +0100
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

Currently, fastboot in U-Boot doens't support SPI NAND
devices. This patchset adds support for SPI NAND in fastboot
nand subsystem.

Alexey Romanov (12):
  nand: move NAND initialization API to nand/core.c
  nand: don't overwrite mtd name in nand_register()
  nand: move nand_util.c to NAND core folder
  nand: move nand_erase_opts() to core NAND folder
  spi: add board_nand_init() function
  spi: use nand_register() instead of add_mtd_device()
  mtdparts: use negative error codes
  jffs2: use negative error codes
  cmd: allow to enable CMD_NAND for SPI NAND devices
  fastboot: check device type for SPI NAND too
  fastboot: enable FASTBOOT_FLASH option for SPI NAND devices
  fastboot: fb_nand: add missing newlines in pr_err() macro

 cmd/Kconfig                      |   2 +-
 cmd/jffs2.c                      |  45 +-
 cmd/mtdparts.c                   | 154 +++----
 drivers/fastboot/Kconfig         |   4 +-
 drivers/fastboot/fb_nand.c       |  12 +-
 drivers/mtd/Kconfig              |   2 +-
 drivers/mtd/nand/Kconfig         |  10 +
 drivers/mtd/nand/Makefile        |   2 +-
 drivers/mtd/nand/core.c          | 140 ++++++
 drivers/mtd/nand/raw/Kconfig     |  10 -
 drivers/mtd/nand/raw/nand.c      | 134 ------
 drivers/mtd/nand/raw/nand_util.c | 664 -----------------------------
 drivers/mtd/nand/spi/Kconfig     |   1 +
 drivers/mtd/nand/spi/core.c      |  17 +-
 drivers/mtd/nand/util.c          | 709 +++++++++++++++++++++++++++++++
 include/nand.h                   |   2 +
 16 files changed, 989 insertions(+), 919 deletions(-)
 create mode 100644 drivers/mtd/nand/util.c

-- 
2.30.1

