Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49482EE57DB
	for <u-boot@archiver.kernel.org>; Wed, 11 Sep 2024 21:50:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3C82288C6D;
	Wed, 11 Sep 2024 23:50:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=salutedevices.com header.i=@salutedevices.com header.b="UCYW7hX9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 456B188A74; Wed, 11 Sep 2024 23:50:04 +0200 (CEST)
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [37.18.73.165])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F25ED88744
 for <u-boot@lists.denx.de>; Wed, 11 Sep 2024 23:49:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=salutedevices.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ddrokosov@salutedevices.com
Received: from p-infra-ksmg-sc-msk01.sberdevices.ru (localhost [127.0.0.1])
 by mx1.sberdevices.ru (Postfix) with ESMTP id 9F61F10001E;
 Thu, 12 Sep 2024 00:49:54 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 9F61F10001E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
 s=mail; t=1726091394;
 bh=bthAxrht2wEOs4sG9WNf64jqArX0viGUSdmkBJEanzI=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
 b=UCYW7hX9IRLVGlFp4bLDWJ7h7Kwb+8FBo1ED10rft43ybhJpQYmGYtoo2LaJzoh2K
 GRWukEU6ivW15Y5TFrYU4oua6gy0mUvdCgIGtwzs/XeF/aiXpbCA6Sl7ISuwjVhP3B
 Mf57GeUJ+f+DKCFO/f2uJM8SsxcA/2LyKlZ9uQKvdf030UYyUWCqms8Zx7d4txWBrf
 tF1a5Cm/jq9N3qOUkUQPaZkDTeRa6x6h8gKqS9sKH3U16gxh4k5VExLNPyilKDW6pE
 asVJo+FADShDGcd1Ovds0hY9OY9OrLfbRJmasCsuor+xQGY7z45ts7H3yiJjuaFXgs
 TMAd2zidbhMeg==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m02.sberdevices.ru
 [172.16.192.103])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mx1.sberdevices.ru (Postfix) with ESMTPS;
 Thu, 12 Sep 2024 00:49:54 +0300 (MSK)
From: Dmitry Rokosov <ddrokosov@salutedevices.com>
To: <igor.opaniuk@gmail.com>, <mkorpershoek@baylibre.com>, <sjg@chromium.org>, 
 <semen.protsenko@linaro.org>, <trini@konsulko.com>,
 <colin.mcallister@garmin.com>, <4.shket@gmail.com>,
 <avromanov@salutedevices.com>
CC: <u-boot@lists.denx.de>, <kernel@salutedevices.com>, <rockosov@gmail.com>, 
 Dmitry Rokosov <ddrokosov@salutedevices.com>
Subject: [PATCH v2 0/6] android_ab: introduce bcb ab_dump command and provide
 several bcb fixes
Date: Thu, 12 Sep 2024 00:49:08 +0300
Message-ID: <20240911214945.15873-1-ddrokosov@salutedevices.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.28.192.196]
X-ClientProxiedBy: p-i-exch-a-m1.sberdevices.ru (172.24.196.116) To
 p-i-exch-a-m1.sberdevices.ru (172.24.196.116)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 187695 [Sep 12 2024]
X-KSMG-AntiSpam-Version: 6.1.1.5
X-KSMG-AntiSpam-Envelope-From: ddrokosov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 32 0.3.32
 766319f57b3d5e49f2c79a76e7d7087b621090df, {Tracking_uf_ne_domains},
 {Tracking_from_domain_doesnt_match_to},
 d41d8cd98f00b204e9800998ecf8427e.com:7.1.1; salutedevices.com:7.1.1;
 lore.kernel.org:7.1.1; smtp.sberdevices.ru:7.1.1,5.0.1;
 127.0.0.199:7.1.2, FromAlignment: s
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean, bases: 2024/09/11 19:53:00
X-KSMG-LinksScanning: Clean, bases: 2024/09/11 21:01:00
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960,
 bases: 2024/09/11 19:25:00 #26555689
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

The patch series include changes:
    - move ab_select_slot() documentation to @ notation
    - move ab_select command to bcb subcommands
    - introduce the ab_dump command to print the content of the BCB
      block; it's useful for debugging A/B logic on supported boards
    - fix the slot suffix format in the ABC block to align with official
      Android BCB specifications
    - add a test for the ab_dump command to verify the accuracy of each
      field within the ABC data displayed, it's also useful for testing
      slot_suffix problem code paths

Changes v2 since v1 at [1]:
    - move ab_select_slot() documentation to @ notation
    - move ab_select command to bcb subcommands per Simon and Mattijs
      suggestions
    - redesign ab_dump as bcb subcommand
    - use spaces instead of tabs in the ab_dump command output
    - print hex values in the lowercase
    - add RvB tags

Links:
    [1] https://lore.kernel.org/all/20240725194716.32232-1-ddrokosov@salutedevices.com/

Signed-off-by: Dmitry Rokosov <ddrokosov@salutedevices.com>

Dmitry Rokosov (6):
  include/android_ab: move ab_select_slot() documentation to @ notation
  treewide: bcb: move ab_select command to bcb subcommands
  cmd: bcb: change strcmp() usage style in the do_bcb_ab_select()
  cmd: bcb: introduce 'ab_dump' command to print BCB block content
  common: android_ab: fix slot suffix for abc block
  test/py: introduce test for ab_dump command

 MAINTAINERS                               |   1 -
 boot/android_ab.c                         | 116 ++++++++++++++++++----
 cmd/Kconfig                               |  15 +--
 cmd/Makefile                              |   1 -
 cmd/ab_select.c                           |  66 ------------
 cmd/bcb.c                                 | 108 ++++++++++++++++++--
 configs/am57xx_hs_evm_usb_defconfig       |   1 -
 configs/khadas-vim3_android_ab_defconfig  |   1 -
 configs/khadas-vim3l_android_ab_defconfig |   1 -
 configs/sandbox64_defconfig               |   4 +-
 configs/sandbox_defconfig                 |   4 +-
 doc/android/ab.rst                        |  12 +--
 include/android_ab.h                      |  17 +++-
 include/configs/khadas-vim3_android.h     |   2 +-
 include/configs/khadas-vim3l_android.h    |   2 +-
 include/configs/meson64_android.h         |   4 +-
 include/configs/ti_omap5_common.h         |   4 +-
 test/py/tests/test_android/test_ab.py     |  31 +++++-
 18 files changed, 251 insertions(+), 139 deletions(-)
 delete mode 100644 cmd/ab_select.c

-- 
2.43.0

