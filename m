Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31B67E7544F
	for <u-boot@archiver.kernel.org>; Tue,  3 Oct 2023 12:12:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1E157871FE;
	Tue,  3 Oct 2023 14:12:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=salutedevices.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=salutedevices.com header.i=@salutedevices.com header.b="rYoVvvnx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E17DF8719F; Tue,  3 Oct 2023 13:28:49 +0200 (CEST)
Received: from mx1.sberdevices.ru (mx2.sberdevices.ru [45.89.224.132])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7AE488707E
 for <u-boot@lists.denx.de>; Tue,  3 Oct 2023 13:28:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=salutedevices.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=avromanov@salutedevices.com
Received: from p-infra-ksmg-sc-msk02 (localhost [127.0.0.1])
 by mx1.sberdevices.ru (Postfix) with ESMTP id C96A1120006;
 Tue,  3 Oct 2023 14:28:45 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru C96A1120006
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
 s=mail; t=1696332525;
 bh=Yvd+CKPMs6O6ncjOg65VrHCqjzGUyCaE29/EZthVP2M=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
 b=rYoVvvnxdHy3PThHH8hvX9jQlIgW77WFRQqoXXhMkWxLdlFzuy4Br/VNNI139zULQ
 UIRbWWnytyx+siMJYstUlyJw5bUNfwRioMqc4Z+RETCl+1Z7FU2lYwq+mdYnCj+RKl
 DVa34nz2g/Q/HvoXcG+MAARhejvJFwPXpki6qc94afw1ddHEJVrGT1RXDDBdbr/AD5
 lFT3+AGX/96PL0DbGbo9W+PTmQIz4JKt0LMNoajyOj0Svn+95hB74CDtJnL+ye4haf
 VIQXHAuAm1pqxnEmeVcJFlTb/trsXThNSLqQTKv0KiU4ujKGIejGs3pOA2V8YdA6cQ
 lgY+UcahmTQmg==
Received: from p-i-exch-sc-m01.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru
 [172.16.192.107])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mx1.sberdevices.ru (Postfix) with ESMTPS;
 Tue,  3 Oct 2023 14:28:45 +0300 (MSK)
Received: from localhost.localdomain (100.64.160.123) by
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Tue, 3 Oct 2023 14:28:45 +0300
From: Alexey Romanov <avromanov@salutedevices.com>
To: <neil.armstrong@linaro.org>, <narmstrong@baylibre.com>, <sjg@google.com>, 
 <lukma@denx.de>, <seanga2@gmail.com>, <marex@denx.de>
CC: <u-boot-amlogic@groups.io>, <u-boot@lists.denx.de>,
 <kernel@sberdevices.ru>, Alexey Romanov <avromanov@salutedevices.com>
Subject: [PATCH v2 0/8] Support USB for Meson A1
Date: Tue, 3 Oct 2023 14:28:26 +0300
Message-ID: <20231003112838.41503-1-avromanov@salutedevices.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [100.64.160.123]
X-ClientProxiedBy: p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) To
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 180316 [Oct 03 2023]
X-KSMG-AntiSpam-Version: 5.9.59.0
X-KSMG-AntiSpam-Envelope-From: avromanov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 535 535
 da804c0ea8918f802fc60e7a20ba49783d957ba2,
 {Tracking_from_domain_doesnt_match_to}, 100.64.160.123:7.1.2;
 d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;
 p-i-exch-sc-m01.sberdevices.ru:5.0.1,7.1.1; 127.0.0.199:7.1.2;
 salutedevices.com:7.1.1, FromAlignment: s, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960,
 bases: 2023/10/03 10:12:00 #22029534
X-KSMG-AntiVirus-Status: Clean, skipped
X-Mailman-Approved-At: Tue, 03 Oct 2023 14:12:00 +0200
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

V2:

- Made power domain for PHY optional.
- Add missing CLKID_USB_PHY gate.
- Drop patch with USB stack initialization in board-a1.c.
Instead of, enable CONFIG_DM_USB_GADGET for AD401 board.
- Support A1 in g12a_child_pre_probe/post_remove functions
in dwc3 driver.


Alexey Romanov (7):
  dt-bindings: reset: add Meson A1 reset bindings
  reset: add support for Amlogic A1 family
  phy: get rid of raw hex values
  phy: move clk enable/disable in init/exit
  phy: support Amlogic A1 family
  dwc3: add support for Amlogic A1 family
  ad401: enable USB stack

Igor Prusov (1):
  a1: clk: Add missing USB_PHY_IN and USB_PHY gates

 configs/ad401_defconfig                       |   3 +
 drivers/clk/meson/a1.c                        |   6 +
 drivers/phy/Kconfig                           |   2 +-
 drivers/phy/meson-g12a-usb2.c                 | 235 ++++++++++++++++--
 drivers/reset/reset-meson.c                   |  42 +++-
 drivers/usb/dwc3/dwc3-meson-g12a.c            |  73 +++++-
 .../reset/amlogic,meson-a1-reset.h            |  76 ++++++
 7 files changed, 403 insertions(+), 34 deletions(-)
 create mode 100644 include/dt-bindings/reset/amlogic,meson-a1-reset.h

-- 
2.25.1

