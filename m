Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9368DCD80B7
	for <u-boot@archiver.kernel.org>; Tue, 10 Oct 2023 11:53:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 075A886D3D;
	Tue, 10 Oct 2023 13:53:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=salutedevices.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=salutedevices.com header.i=@salutedevices.com header.b="tubTqHpx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CF32F867F6; Tue, 10 Oct 2023 12:06:48 +0200 (CEST)
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [37.18.73.165])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8465B86D3E
 for <u-boot@lists.denx.de>; Tue, 10 Oct 2023 12:06:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=salutedevices.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=avromanov@salutedevices.com
Received: from p-infra-ksmg-sc-msk01 (localhost [127.0.0.1])
 by mx1.sberdevices.ru (Postfix) with ESMTP id B60AA100003;
 Tue, 10 Oct 2023 13:06:31 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru B60AA100003
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
 s=mail; t=1696932391;
 bh=FhJSx0xE7uw3byqpH5VR1ZRAtlK+et3fJ8T6QwjavNQ=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
 b=tubTqHpxV40yG0Gxnah++piMAL9PLJ12g5hsdpbwzAl2chIZ7KKfqG3aKoli2fjRF
 /XpYIjbf/MgTTlKqiHbhAKPw6ax9aLB0LEiii3Cnfwjrpdo3SSqRM6DRSbIwkaUzmK
 aujB8upAJMftpNWdQdsDKeGFQV3J7VcyI+sUI93pHwLziMXTHvxuigPPj/AHZj1qxX
 4FTcGxGUAnOIndPPbqmrT8qnF5GwIBTeXhiinlxWIQSRzzsNqvJwrI3jblivnaBe/t
 RxU6H7jdrZeMSTauHjg96PNAoxyew7w6BctpDiinzbTc2VQiSL7wSDfW9/nkji0x58
 L6seDsc7yylUA==
Received: from p-i-exch-sc-m01.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru
 [172.16.192.107])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mx1.sberdevices.ru (Postfix) with ESMTPS;
 Tue, 10 Oct 2023 13:06:30 +0300 (MSK)
Received: from localhost.localdomain (100.64.160.123) by
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Tue, 10 Oct 2023 13:06:30 +0300
From: Alexey Romanov <avromanov@salutedevices.com>
To: <neil.armstrong@linaro.org>, <narmstrong@baylibre.com>
CC: <u-boot-amlogic@groups.io>, <u-boot@lists.denx.de>,
 <kernel@sberdevices.ru>, Alexey Romanov <avromanov@salutedevices.com>
Subject: [PATCH v2 0/2] Meson A1: add HW RNG and AO Secure nodes
Date: Tue, 10 Oct 2023 13:06:15 +0300
Message-ID: <20231010100623.74475-1-avromanov@salutedevices.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [100.64.160.123]
X-ClientProxiedBy: p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) To
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 180496 [Oct 10 2023]
X-KSMG-AntiSpam-Version: 6.0.0.2
X-KSMG-AntiSpam-Envelope-From: avromanov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 536 536
 1ae19c7800f69da91432b5e67ed4a00b9ade0d03,
 {Tracking_from_domain_doesnt_match_to}, salutedevices.com:7.1.1;
 d41d8cd98f00b204e9800998ecf8427e.com:7.1.1; 127.0.0.199:7.1.2;
 p-i-exch-sc-m01.sberdevices.ru:5.0.1,7.1.1;
 100.64.160.123:7.1.2, FromAlignment: s, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960,
 bases: 2023/10/10 08:07:00 #22138887
X-KSMG-AntiVirus-Status: Clean, skipped
X-Mailman-Approved-At: Tue, 10 Oct 2023 13:53:11 +0200
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

This patchest adds HW RNG and AO Secure definition
in device tree for Amlogic A1-series.

V2:

- Rebased over latest amlogic U-Boot branch.

Alexey Romanov (2):
  meson-a1: dts: add hw rng node
  meson-a1: dts: add ao secure node

 arch/arm/dts/meson-a1.dtsi | 11 +++++++++++
 1 file changed, 11 insertions(+)

-- 
2.25.1

