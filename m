Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 342FBE748FE
	for <u-boot@archiver.kernel.org>; Mon,  2 Oct 2023 17:34:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6F2D686D1C;
	Mon,  2 Oct 2023 19:34:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=salutedevices.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=salutedevices.com header.i=@salutedevices.com header.b="VmaOZAyf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0056786DCA; Mon,  2 Oct 2023 18:59:09 +0200 (CEST)
Received: from mx1.sberdevices.ru (mx2.sberdevices.ru [45.89.224.132])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3898B86940
 for <u-boot@lists.denx.de>; Mon,  2 Oct 2023 18:59:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=salutedevices.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=avromanov@salutedevices.com
Received: from p-infra-ksmg-sc-msk02 (localhost [127.0.0.1])
 by mx1.sberdevices.ru (Postfix) with ESMTP id 8AAD2120007;
 Mon,  2 Oct 2023 19:59:04 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 8AAD2120007
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
 s=mail; t=1696265944;
 bh=a05rhRH6lRb/b8LFTBK4OtmGi5eSDSw0jUUnpNO1BUQ=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
 b=VmaOZAyfMaQ8VlAX9b9xtqsjp1GSoCBmtKV50vSjOD8m0kxELmPjzbao5YWOPviwZ
 5IqO9WsD5bQWTaRHrRPsNJX0gTwJH1J/Sa4cZlyWH0zrvaNzYyoYbOnLnrHCRYOJFI
 hE+fZDOyxVE1hQvOilgGcowuUIstQY1DTNBWcY3alX8gonQUlilgDV6EPx3ZHAZmpB
 Pj4WpHPjsl4mKsj78QoMKLEuuJKT4+TVqqjSwXO0bPra8mwTzyCVkBXRP/xOX4xv9q
 aQ2HHEiy0LELXkMI1TSfLFY3sgin1Pbt0hrm4Yfddhds1Aow4JSyhZsWfEbSI+utLQ
 Hjg8JVjpp3V6w==
Received: from p-i-exch-sc-m01.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru
 [172.16.192.107])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mx1.sberdevices.ru (Postfix) with ESMTPS;
 Mon,  2 Oct 2023 19:59:04 +0300 (MSK)
Received: from localhost.localdomain (100.64.160.123) by
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Mon, 2 Oct 2023 19:59:04 +0300
From: Alexey Romanov <avromanov@salutedevices.com>
To: <neil.armstrong@linaro.org>, <narmstrong@baylibre.com>, <sjg@google.com>, 
 <lukma@denx.de>, <seanga2@gmail.com>, <marex@denx.de>
CC: <u-boot-amlogic@groups.io>, <u-boot@lists.denx.de>,
 <kernel@sberdevices.ru>, Alexey Romanov <avromanov@salutedevices.com>
Subject: [PATCH v1 0/8] Support USB for Meson A1
Date: Mon, 2 Oct 2023 19:58:44 +0300
Message-ID: <20231002165857.19512-1-avromanov@salutedevices.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [100.64.160.123]
X-ClientProxiedBy: p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) To
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 180290 [Oct 02 2023]
X-KSMG-AntiSpam-Version: 5.9.59.0
X-KSMG-AntiSpam-Envelope-From: avromanov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 535 535
 da804c0ea8918f802fc60e7a20ba49783d957ba2,
 {Tracking_from_domain_doesnt_match_to}, salutedevices.com:7.1.1;
 d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;
 p-i-exch-sc-m01.sberdevices.ru:5.0.1,7.1.1; 100.64.160.123:7.1.2;
 127.0.0.199:7.1.2, FromAlignment: s, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960,
 bases: 2023/10/02 12:04:00 #22024008
X-KSMG-AntiVirus-Status: Clean, skipped
X-Mailman-Approved-At: Mon, 02 Oct 2023 19:34:08 +0200
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

This patchset adds USB stack support for Amlogic A1 SoC's
series. Made reset / phy / dwc3 drivers more flexible and
added support for A1 board.

Alexey Romanov (7):
  dt-bindings: reset: add Meson A1 reset bindings
  reset: add support for Amlogic A1 family
  phy: get rid of raw hex values
  phy: move clk enable/disable in init/exit
  phy: support Amlogic A1 family
  dwc3: add support for Amlogic A1 family
  arch: a1: introduce USB initialization functionality

Igor Prusov (1):
  a1: clk: Add missing CLKID_USB_PHY_IN gate

 arch/arm/mach-meson/board-a1.c                |  89 +++++++
 drivers/clk/meson/a1.c                        |   3 +
 drivers/phy/Kconfig                           |   2 +-
 drivers/phy/meson-g12a-usb2.c                 | 233 ++++++++++++++++--
 drivers/reset/reset-meson.c                   |  42 +++-
 drivers/usb/dwc3/dwc3-meson-g12a.c            |  73 +++++-
 .../reset/amlogic,meson-a1-reset.h            |  76 ++++++
 7 files changed, 484 insertions(+), 34 deletions(-)
 create mode 100644 include/dt-bindings/reset/amlogic,meson-a1-reset.h

-- 
2.25.1

