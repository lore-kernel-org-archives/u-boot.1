Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75B69C25B6C
	for <u-boot@archiver.kernel.org>; Tue, 24 Oct 2023 22:52:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A8B30879E1;
	Wed, 25 Oct 2023 00:52:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=sberdevices.ru
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=sberdevices.ru header.i=@sberdevices.ru header.b="r3UI8JEE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7489B879E1; Wed, 25 Oct 2023 00:52:00 +0200 (CEST)
Received: from mx1.sberdevices.ru (mx2.sberdevices.ru [45.89.224.132])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3389D86FB1
 for <u-boot@lists.denx.de>; Wed, 25 Oct 2023 00:51:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=sberdevices.ru
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ivprusov@salutedevices.com
Received: from p-infra-ksmg-sc-msk02 (localhost [127.0.0.1])
 by mx1.sberdevices.ru (Postfix) with ESMTP id 43A5B12003A;
 Wed, 25 Oct 2023 01:51:55 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 43A5B12003A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
 s=mail; t=1698187915;
 bh=bmR1XHM8cuES4u3h0+dQ3zmtoQWrRPJ3hHvNvbVVwcU=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
 b=r3UI8JEE9fDt+846QwyXxY+wz7TwTePfMmRtMTdnIl9nigUhr3IyiHtX687yJhrnX
 Tt6txpflY9aSVxnv/zGdAa6jt07VK/mIxqrJh01/od0pS5P6gwxljOO4TWoC+mIZpg
 4jtdcTuuBPHiXOmq/xS2Pjg9OuB9JB+n7Bs92VwxC8iUUMan9Zf21ac9gb5M5Xg4H3
 kC0+RQxis0Xagsyd/I8Pb1KLSpi1DGdNHBXcaFXgRjlOpkKVq6PAwl5ASx8K1hG1yB
 LCBIz/CBQMmVPIyMYBa1t7Ca9vgbzg7gdq0WU77ce5Thx7E80bPXfNkjS2pjzsIDWI
 rKLEYMy4A7HXQ==
Received: from p-i-exch-sc-m01.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru
 [172.16.192.107])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mx1.sberdevices.ru (Postfix) with ESMTPS;
 Wed, 25 Oct 2023 01:51:54 +0300 (MSK)
Received: from localhost.localdomain (100.64.160.123) by
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.37; Wed, 25 Oct 2023 01:51:54 +0300
From: Igor Prusov <ivprusov@sberdevices.ru>
To: Neil Armstrong <neil.armstrong@linaro.org>, Jagan Teki
 <jagan@amarulasolutions.com>
CC: <prusovigor@gmail.com>, <kernel@sberdevices.ru>, Igor Prusov
 <ivprusov@sberdevices.ru>, <u-boot-amlogic@groups.io>,
 <u-boot@lists.denx.de>, <sjg@chromium.org>
Subject: [PATCH v2 0/2] ARM: amlogic: Add A1 SPIFC support
Date: Wed, 25 Oct 2023 01:51:38 +0300
Message-ID: <20231024225140.366571-1-ivprusov@sberdevices.ru>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [100.64.160.123]
X-ClientProxiedBy: p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) To
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 180852 [Oct 25 2023]
X-KSMG-AntiSpam-Version: 6.0.0.2
X-KSMG-AntiSpam-Envelope-From: ivprusov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 543 543
 1e3516af5cdd92079dfeb0e292c8747a62cb1ee4, {Tracking_smtp_not_equal_from},
 {Tracking_from_domain_doesnt_match_to},
 p-i-exch-sc-m01.sberdevices.ru:5.0.1,7.1.1; sberdevices.ru:5.0.1,7.1.1;
 d41d8cd98f00b204e9800998ecf8427e.com:7.1.1; salutedevices.com:7.1.1;
 127.0.0.199:7.1.2;
 100.64.160.123:7.1.2, FromAlignment: n, {Tracking_smtp_domain_mismatch},
 {Tracking_smtp_domain_2level_mismatch}, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960,
 bases: 2023/10/24 20:53:00 #22289793
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

A1 family boards have new version of SPIFC controller, that is
incompatible with meson_spifc driver. This series ports A1 SPIFC driver
from Linux and enables it for ad401 board.

Changes in V2:
 - more details in Kconfig help message
 - removed unused field of struct amlogic_spifc_a1
 - add missed check for NULL during probe

Igor Prusov (2):
  spi: add support for Amlogic A1 SPI Flash Controller
  ARM: amlogic: ad401: enable SPIFC

 configs/ad401_defconfig      |   1 +
 drivers/spi/Kconfig          |   9 +
 drivers/spi/Makefile         |   1 +
 drivers/spi/meson_spifc_a1.c | 384 +++++++++++++++++++++++++++++++++++
 4 files changed, 395 insertions(+)
 create mode 100644 drivers/spi/meson_spifc_a1.c

-- 
2.34.1

