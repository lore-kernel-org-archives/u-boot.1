Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAE57C83F14
	for <u-boot@archiver.kernel.org>; Mon, 28 Aug 2023 19:49:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B8F698645F;
	Mon, 28 Aug 2023 21:49:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=salutedevices.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=salutedevices.com header.i=@salutedevices.com header.b="R4cJT/Dt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9C76A8651E; Mon, 28 Aug 2023 15:37:52 +0200 (CEST)
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [37.18.73.165])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A2B8386423
 for <u-boot@lists.denx.de>; Mon, 28 Aug 2023 15:37:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=salutedevices.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ivprusov@salutedevices.com
Received: from p-infra-ksmg-sc-msk01 (localhost [127.0.0.1])
 by mx1.sberdevices.ru (Postfix) with ESMTP id E17A4100005;
 Mon, 28 Aug 2023 16:37:48 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru E17A4100005
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
 s=mail; t=1693229868;
 bh=YmcM9Dbiz/zRbrcg9OnrMXpZHb2+JZuH4zc0AcT2RTg=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
 b=R4cJT/DttMDmNOyMsqfDeK8xRBF4hAmloSJQ8QNtjBpskVRE6LwO2WDlM1wGvwTNa
 qSrnjVoDcvYLoxdFu53PnjYqsPKISkqqEo5wIMAsZjE+SucWIgJuUik6GHCgjXs/0F
 r34JD4hnFshdG4GDd4bdI0YtOUdTCJnZgseo5r1CCf45eXutOdTOiZ3c2+eqnO7dvg
 3nC3nHbpfH6/6Wix5LYo7U7IS9zF9U1WSEkWqJHvcgrTWWCjoYrJ160St+N+p3DIVh
 EhpeGtK9aL19tZ84H01mrLNfwFQKJ8cSbE7nYqDsEIFDXHHKxvbq7EqrUpUCPOa6a5
 Dhn5zJ46w/4eQ==
Received: from p-i-exch-sc-m01.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru
 [172.16.192.107])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mx1.sberdevices.ru (Postfix) with ESMTPS;
 Mon, 28 Aug 2023 16:37:48 +0300 (MSK)
Received: from localhost.localdomain (100.64.160.123) by
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Mon, 28 Aug 2023 16:37:42 +0300
From: Igor Prusov <ivprusov@salutedevices.com>
To: Neil Armstrong <neil.armstrong@linaro.org>, Lukasz Majewski
 <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>
CC: <prusovigor@gmail.com>, <kernel@sberdevices.ru>, Igor Prusov
 <ivprusov@salutedevices.com>, <u-boot-amlogic@groups.io>,
 <u-boot@lists.denx.de>
Subject: [PATCH v1 0/2] clk: amlogic: a1: Add Amlogic A1 clock driver
Date: Mon, 28 Aug 2023 16:37:22 +0300
Message-ID: <20230828133724.2637-1-ivprusov@salutedevices.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [100.64.160.123]
X-ClientProxiedBy: p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) To
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 179481 [Aug 28 2023]
X-KSMG-AntiSpam-Version: 5.9.59.0
X-KSMG-AntiSpam-Envelope-From: ivprusov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 528 528
 4b912e27f7408903f04ab5d0a88bd271cc7c0a60,
 {Tracking_from_domain_doesnt_match_to}, 127.0.0.199:7.1.2;
 salutedevices.com:7.1.1; p-i-exch-sc-m01.sberdevices.ru:7.1.1,5.0.1;
 100.64.160.123:7.1.2;
 d41d8cd98f00b204e9800998ecf8427e.com:7.1.1, FromAlignment: s,
 ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960,
 bases: 2023/08/28 11:35:00 #21756980
X-KSMG-AntiVirus-Status: Clean, skipped
X-Mailman-Approved-At: Mon, 28 Aug 2023 21:49:14 +0200
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

This series adds dt-bindings and driver implementation for Amlogic A1
PLL and Peripherals clock controllers.

Igor Prusov (2):
  dt-bindings: clock: Add Amlogic A1 clock bindings
  clk: Add clock driver for Amlogic A1

 arch/arm/include/asm/arch-meson/clock-a1.h    |  23 +
 drivers/clk/meson/Kconfig                     |   8 +
 drivers/clk/meson/Makefile                    |   1 +
 drivers/clk/meson/a1.c                        | 681 ++++++++++++++++++
 .../clock/amlogic,a1-peripherals-clkc.h       | 168 +++++
 .../dt-bindings/clock/amlogic,a1-pll-clkc.h   |  25 +
 6 files changed, 906 insertions(+)
 create mode 100644 arch/arm/include/asm/arch-meson/clock-a1.h
 create mode 100644 drivers/clk/meson/a1.c
 create mode 100644 include/dt-bindings/clock/amlogic,a1-peripherals-clkc.h
 create mode 100644 include/dt-bindings/clock/amlogic,a1-pll-clkc.h

-- 
2.34.1

