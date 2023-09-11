Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FC1BEE7FF4
	for <u-boot@archiver.kernel.org>; Mon, 11 Sep 2023 16:42:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2FB9C86DD0;
	Mon, 11 Sep 2023 18:42:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=salutedevices.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=salutedevices.com header.i=@salutedevices.com header.b="A7Gdjpw+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 107CE86E6B; Mon, 11 Sep 2023 18:35:49 +0200 (CEST)
Received: from mx1.sberdevices.ru (mx2.sberdevices.ru [45.89.224.132])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AEA8786D06
 for <u-boot@lists.denx.de>; Mon, 11 Sep 2023 18:35:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=salutedevices.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=avromanov@salutedevices.com
Received: from p-infra-ksmg-sc-msk02 (localhost [127.0.0.1])
 by mx1.sberdevices.ru (Postfix) with ESMTP id DD58E12000A;
 Mon, 11 Sep 2023 19:35:44 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru DD58E12000A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
 s=mail; t=1694450144;
 bh=gWbIUMdo9E/+pKZGxPMncm/IxjsK0hfAgEpz7F24aOU=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
 b=A7Gdjpw+0jd1lIIwQQ3Zl87Wz1AARh/2HPeqRGPBm2KcJujRckZhnoppW/2Vhlig4
 qWPNM2UvvaZhTgt33lL4HUqtIkr5/nojaNbCe2qbLKpHOR7V4Uuj58+1VfPAwT8rI3
 /etA70/XAVbAjbw82zwSf0ctJ3/LUbcoTonx2LFyDbOpUC7CpJrpq0wXqvWh2CoKr+
 DJhVJRI5JJO7a/TFSJyGSrLNh5UdrQYxnGhZXp9fFV3aTumQ3q/yHaMVnMFROKyWrl
 WZZ68AAXboaR9/aiinp1QGl9MD1FMqhbbPSZyC8Gvhqj8Wfuw7KplZ4ZFCgxRGZwRq
 goI7OgRWqf+AA==
Received: from p-i-exch-sc-m01.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru
 [172.16.192.107])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mx1.sberdevices.ru (Postfix) with ESMTPS;
 Mon, 11 Sep 2023 19:35:44 +0300 (MSK)
Received: from localhost.localdomain (100.64.160.123) by
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Mon, 11 Sep 2023 19:35:44 +0300
From: Alexey Romanov <avromanov@salutedevices.com>
To: <neil.armstrong@linaro.org>, <narmstrong@baylibre.com>, <sjg@google.com>, 
 <takahiro.akashi@linaro.org>, <ilias.apalodimas@linaro.org>,
 <post@lespocky.de>, <marex@denx.de>, <msuchanek@suse.de>,
 <sughosh.ganu@linaro.org>, <jh80.chung@samsung.com>,
 <paul.barker@sancloud.com>
CC: <u-boot-amlogic@groups.io>, <u-boot@lists.denx.de>,
 <kernel@sberdevices.ru>, Alexey Romanov <avromanov@salutedevices.com>
Subject: [PATCH v2 0/8] Add SM uclass and Meson SM driver
Date: Mon, 11 Sep 2023 19:35:28 +0300
Message-ID: <20230911163536.20735-1-avromanov@salutedevices.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [100.64.160.123]
X-ClientProxiedBy: p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) To
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 179783 [Sep 11 2023]
X-KSMG-AntiSpam-Version: 5.9.59.0
X-KSMG-AntiSpam-Envelope-From: avromanov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 530 530
 ecb1547b3f72d1df4c71c0b60e67ba6b4aea5432,
 {Tracking_from_domain_doesnt_match_to},
 p-i-exch-sc-m01.sberdevices.ru:5.0.1,7.1.1; salutedevices.com:7.1.1;
 d41d8cd98f00b204e9800998ecf8427e.com:7.1.1; 127.0.0.199:7.1.2;
 100.64.160.123:7.1.2, FromAlignment: s, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960,
 bases: 2023/09/11 06:02:00 #21866861
X-KSMG-AntiVirus-Status: Clean, skipped
X-Mailman-Approved-At: Mon, 11 Sep 2023 18:42:19 +0200
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

At the moment, there is no single general approach to using
secure monitor in U-Boot, there is only the smc_call() function,
over which everyone builds their own add-ons. This patchset
is designed to solve this problem by adding a new uclass -
SM_UCLASS. This UCLASS export following generic API:

1. sm_call() - generic SMC call to the secure-monitor
2. sm_call_read() - retrieve data from secure-monitor
3. sm_call_write() - send data to secure-monitor

In the future, it is necessary to completely get rid of raw
smc_call() calls, replacing them with the use of SM_UCLASS
based drivers.

V2:

- Add SM UCLASS
- Add SM sandbox driver
- Add test for sandbox driver
- Meson Secure Monitor driver now based on SM_UCLASS
- Fix include order in arch/arm/mach-meson/sm.c

Also, during the discussion in V1 of this patchset, it was
discussed to create MESON_SM_UCLASS, but I considered such
a uclass to be too arch-specific. That's why I suggest
SM_UCLASS, which is not so arch-specific: secure monitor can
used for whole ARM devices, not only for Amlogic SoC's.

Alexey Romanov (8):
  drivers: introduce Secure Monitor uclass
  sandbox: add sandobx sm uclass driver
  sandbox: dts: add meson secure monitor node
  sandbox: add tests for UCLASS_SM
  sandbox: defconfig: enable CONFIG_SM option
  drivers: introduce Meson Secure Monitor driver
  arch: meson: sm: set correct order of the includes
  arch: meson: use secure monitor driver

 MAINTAINERS                 |   1 +
 arch/arm/mach-meson/Kconfig |   1 +
 arch/arm/mach-meson/sm.c    | 116 +++++++++++----------
 arch/sandbox/dts/test.dts   |   4 +
 configs/sandbox_defconfig   |   1 +
 drivers/Kconfig             |   2 +
 drivers/Makefile            |   1 +
 drivers/sm/Kconfig          |   9 ++
 drivers/sm/Makefile         |   5 +
 drivers/sm/meson-sm.c       | 198 ++++++++++++++++++++++++++++++++++++
 drivers/sm/sandbox-sm.c     |  76 ++++++++++++++
 drivers/sm/sm-uclass.c      |  55 ++++++++++
 include/dm/uclass-id.h      |   1 +
 include/meson/sm.h          |  19 ++++
 include/sandbox-sm.h        |  18 ++++
 include/sm-uclass.h         |  72 +++++++++++++
 include/sm.h                |  67 ++++++++++++
 test/dm/Makefile            |   1 +
 test/dm/sm.c                |  65 ++++++++++++
 19 files changed, 656 insertions(+), 56 deletions(-)
 create mode 100644 drivers/sm/Kconfig
 create mode 100644 drivers/sm/Makefile
 create mode 100644 drivers/sm/meson-sm.c
 create mode 100644 drivers/sm/sandbox-sm.c
 create mode 100644 drivers/sm/sm-uclass.c
 create mode 100644 include/meson/sm.h
 create mode 100644 include/sandbox-sm.h
 create mode 100644 include/sm-uclass.h
 create mode 100644 include/sm.h
 create mode 100644 test/dm/sm.c

-- 
2.25.1

