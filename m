Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61994CE7A96
	for <u-boot@archiver.kernel.org>; Mon, 25 Sep 2023 15:52:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 96FF386D4E;
	Mon, 25 Sep 2023 17:52:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=salutedevices.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=salutedevices.com header.i=@salutedevices.com header.b="rUsw83rQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4620886BE7; Mon, 25 Sep 2023 17:52:29 +0200 (CEST)
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [37.18.73.165])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A95D986B82
 for <u-boot@lists.denx.de>; Mon, 25 Sep 2023 17:52:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=salutedevices.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ivprusov@salutedevices.com
Received: from p-infra-ksmg-sc-msk01 (localhost [127.0.0.1])
 by mx1.sberdevices.ru (Postfix) with ESMTP id CB2EF100003;
 Mon, 25 Sep 2023 18:52:25 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru CB2EF100003
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
 s=mail; t=1695657145;
 bh=2ZwGbKmZIK+fveFyEWFzFRJ0ThWqr+rdOlUFJviTCpM=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
 b=rUsw83rQtP3VEZgfO+aoz3ZhLcJyIi+CdTyES4gXjBQPbwv4jzed67Tcvc5ONR48T
 lsNfV3CeHGV7k9CMb2Az1wJj4JeHf4ibGR+ck7P0Ftgql3q0XwnCasg5TouNgsli4a
 NkYewRdzNQ05kr9Kp8iboSk4JH6ugAnGY78f1kviHfT2Z4CsbpdkMfjpu8ZdWEzifE
 3VRSf+Iio6gyOA4V3dr7LaZKWn7MRCiMCKHFY/P5udQkjYJxnel5a/umowaF++TpUV
 z1POYC9ojEN7Si01C5apbnVzeOjyHQkKQYeLdxAojk9SXCYbyxuibyjnksBToP0A/4
 YhwSBzQwIUNPQ==
Received: from p-i-exch-sc-m01.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru
 [172.16.192.107])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mx1.sberdevices.ru (Postfix) with ESMTPS;
 Mon, 25 Sep 2023 18:52:24 +0300 (MSK)
Received: from localhost.localdomain (100.64.160.123) by
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Mon, 25 Sep 2023 18:52:23 +0300
From: Igor Prusov <ivprusov@salutedevices.com>
To: Neil Armstrong <neil.armstrong@linaro.org>, Lukasz Majewski
 <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, Igor Prusov
 <ivprusov@salutedevices.com>, Simon Glass <sjg@chromium.org>
CC: <prusovigor@gmail.com>, <kernel@sberdevices.ru>,
 <u-boot-amlogic@groups.io>, <u-boot@lists.denx.de>
Subject: [PATCH v2 0/2] clk: amlogic: a1: Add Amlogic A1 clock driver
Date: Mon, 25 Sep 2023 18:52:07 +0300
Message-ID: <20230925155209.130671-1-ivprusov@salutedevices.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [100.64.160.123]
X-ClientProxiedBy: p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) To
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 180107 [Sep 25 2023]
X-KSMG-AntiSpam-Version: 5.9.59.0
X-KSMG-AntiSpam-Envelope-From: ivprusov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 534 534
 808c2ea49f7195c68d40844e073217da4fa0d1e3, {Tracking_uf_ne_domains},
 {Tracking_from_domain_doesnt_match_to}, salutedevices.com:7.1.1;
 lore.kernel.org:7.1.1; p-i-exch-sc-m01.sberdevices.ru:5.0.1,7.1.1;
 d41d8cd98f00b204e9800998ecf8427e.com:7.1.1; 100.64.160.123:7.1.2;
 127.0.0.199:7.1.2, FromAlignment: s, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean, bases: 2023/09/25 14:33:00
X-KSMG-LinksScanning: Clean, bases: 2023/09/25 14:33:00
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960,
 bases: 2023/09/25 14:08:00 #21978535
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

This series adds dt-bindings and driver implementation for Amlogic A1
PLL and Peripherals clock controllers.

V1: https://lore.kernel.org/all/20230917101308.1250-1-ivprusov@salutedevices.com/

V1 -> V2:
 - Add more verbose comments for driver

Igor Prusov (2):
  dt-bindings: clock: Add Amlogic A1 clock bindings
  clk: Add clock driver for Amlogic A1

 arch/arm/include/asm/arch-meson/clock-a1.h    |  23 +
 drivers/clk/meson/Kconfig                     |   8 +
 drivers/clk/meson/Makefile                    |   1 +
 drivers/clk/meson/a1.c                        | 723 ++++++++++++++++++
 .../clock/amlogic,a1-peripherals-clkc.h       | 168 ++++
 .../dt-bindings/clock/amlogic,a1-pll-clkc.h   |  25 +
 6 files changed, 948 insertions(+)
 create mode 100644 arch/arm/include/asm/arch-meson/clock-a1.h
 create mode 100644 drivers/clk/meson/a1.c
 create mode 100644 include/dt-bindings/clock/amlogic,a1-peripherals-clkc.h
 create mode 100644 include/dt-bindings/clock/amlogic,a1-pll-clkc.h

-- 
2.34.1

