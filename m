Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 215D8C27C44
	for <u-boot@archiver.kernel.org>; Sun,  2 Jun 2024 20:20:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2153787FEE;
	Sun,  2 Jun 2024 22:20:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=salutedevices.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="key not found in DNS" (0-bit key; unprotected) header.d=salutedevices.com header.i=@salutedevices.com header.b="NKe1FOAS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7267587ED0; Sun,  2 Jun 2024 22:20:22 +0200 (CEST)
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [37.18.73.165])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B4F7587D8E
 for <u-boot@lists.denx.de>; Sun,  2 Jun 2024 22:20:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=salutedevices.com
Authentication-Results: phobos.denx.de;
 spf=none smtp.mailfrom=avkrasnov@salutedevices.com
Received: from p-infra-ksmg-sc-msk01.sberdevices.ru (localhost [127.0.0.1])
 by mx1.sberdevices.ru (Postfix) with ESMTP id BEB58100004;
 Sun,  2 Jun 2024 23:20:18 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru BEB58100004
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
 s=mail; t=1717359618;
 bh=r7QvMfKbefmu8qAaRcUJwWLCG12UtM5jsOxB2kEmOfE=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
 b=NKe1FOASPyAk8iqo1OC6ZmcgUcYiHk84n3Jl6TZe0Wl8DCZ2+c+EG4bz9yvdrNi/u
 pFcHYlyT5YiO8fBgq58Ion1XXUJxd4VOq06m1yfmzgn/s4xtcbJ+FQSl1Xxqi0UbKf
 7dFRna1zxGZ9o9cigiNyF+3knFdrPpWPES9t/k2IMxQlRHheQA/XL3GhJBweYkZjrZ
 CZ66+ALBainkDnTfJq53ClLHkU01+CJ+XzgcJ6K3HxAy38ZU02zE3Q7JHdF3828huJ
 eC5+hqvfZS/U8Vdfa+7FvTx6cvolYqEul6lB7Ive0pAErcHP93eW0wXIaYG5Eg7Jbq
 qtnTQQlPKJyTw==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m02.sberdevices.ru
 [172.16.192.103])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mx1.sberdevices.ru (Postfix) with ESMTPS;
 Sun,  2 Jun 2024 23:20:18 +0300 (MSK)
Received: from localhost.localdomain (100.64.160.123) by
 p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Sun, 2 Jun 2024 23:20:18 +0300
From: Arseniy Krasnov <avkrasnov@salutedevices.com>
To: Dario Binacchi <dario.binacchi@amarulasolutions.com>, Michael Trimarchi
 <michael@amarulasolutions.com>, Neil Armstrong <neil.armstrong@linaro.org>,
 Miquel Raynal <miquel.raynal@bootlin.com>, Tom Rini <trini@konsulko.com>,
 Sean Anderson <seanga2@gmail.com>
CC: <u-boot@lists.denx.de>, <u-boot-amlogic@groups.io>,
 <kernel@sberdevices.ru>, <oxffffaa@gmail.com>, <avkrasnov@salutedevices.com>
Subject: [PATCH v1 0/3] Meson: R/W support for pages used by boot ROM
Date: Sun, 2 Jun 2024 23:08:33 +0300
Message-ID: <20240602200836.3949773-1-avkrasnov@salutedevices.com>
X-Mailer: git-send-email 2.35.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [100.64.160.123]
X-ClientProxiedBy: p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) To
 p-i-exch-sc-m02.sberdevices.ru (172.16.192.103)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 185677 [Jun 02 2024]
X-KSMG-AntiSpam-Version: 6.1.0.4
X-KSMG-AntiSpam-Envelope-From: avkrasnov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 20 0.3.20
 743589a8af6ec90b529f2124c2bbfc3ce1d2f20f, {Tracking_uf_ne_domains},
 {Tracking_from_domain_doesnt_match_to},
 d41d8cd98f00b204e9800998ecf8427e.com:7.1.1; 100.64.160.123:7.1.2;
 smtp.sberdevices.ru:5.0.1,7.1.1; lore.kernel.org:7.1.1; 127.0.0.199:7.1.2;
 salutedevices.com:7.1.1, FromAlignment: s, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean, bases: 2024/06/02 18:51:00
X-KSMG-LinksScanning: Clean, bases: 2024/06/02 18:52:00
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960,
 bases: 2024/06/02 16:26:00 #25411153
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

Patchset is based on patchset for Linux (today merged to nand-next):
https://lore.kernel.org/linux-mtd/20240507230903.3399594-1-avkrasnov@salutedevices.com/

Here is description from it:

 >  Amlogic's boot ROM code needs that some pages on NAND must be written
 >  in special "short" ECC mode with scrambling enabled. Such pages:
 >  1) Contain some metadata about hardware.
 >  2) Located with some interval starting from 0 offset, until some
 >     specified offset. Interval and second offset are set in the
 >     device tree.
 >  
 >  This patchset adds R/W support for such pages. To enable it we can setup
 >  it in dts:
 >  
 >      nand-is-boot-medium;
 >      amlogic,boot-pages = <1024>;
 >      amlogic,boot-page-step = <128>;
 >  
 >  It means that each 128th page in range 0 to 1024 pages will be accessed
 >  in special mode ("short" ECC + scrambling). In practice this feature is
 >  needed when we want to update first block of NAND - driver will enable
 >  required mode by itself using value from device tree.

The only difference is that patchset for Linux updates DT bindings, while
this adds NAND_IS_BOOT_MEDIUM flag support.

Arseniy Krasnov (3):
  mtd: rawnand: nand_base: support for 'NAND_IS_BOOT_MEDIUM' flag
  mtd: rawnand: meson: refactor use of 'meson_nfc_cmd_access()'
  mtd: rawnand: meson: read/write access for boot ROM pages

 drivers/mtd/nand/raw/meson_nand.c | 84 +++++++++++++++++++++----------
 drivers/mtd/nand/raw/nand_base.c  |  3 ++
 include/linux/mtd/rawnand.h       |  6 +++
 3 files changed, 66 insertions(+), 27 deletions(-)

-- 
2.35.0

