Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E846CDB46E
	for <u-boot@archiver.kernel.org>; Thu, 12 Oct 2023 12:26:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B4BE786E1F;
	Thu, 12 Oct 2023 14:26:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=salutedevices.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=salutedevices.com header.i=@salutedevices.com header.b="vj8zpmGN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0048786E07; Thu, 12 Oct 2023 09:58:39 +0200 (CEST)
Received: from mx1.sberdevices.ru (mx2.sberdevices.ru [45.89.224.132])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 35F9186CE5
 for <u-boot@lists.denx.de>; Thu, 12 Oct 2023 09:58:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=salutedevices.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=avromanov@salutedevices.com
Received: from p-infra-ksmg-sc-msk02 (localhost [127.0.0.1])
 by mx1.sberdevices.ru (Postfix) with ESMTP id 6274B120003;
 Thu, 12 Oct 2023 10:58:36 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 6274B120003
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
 s=mail; t=1697097516;
 bh=HSN+h1ZU5OZhniXORnglf8yQPTNAnEyruvEeEPOHI7s=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
 b=vj8zpmGN+D/utNU1eaTyuvdjrD6AC04a+NAhPeAI0bgSTcQUR+Ci7kP3T9IDCjq0+
 TuP1bLzpdM31mghOEkOz5RV5aDrWYHr0gsKfMism/IL5UEEtCv4kgMCDBUC5i5yl50
 Cp3jvHyjHJMU20nE0DT6+HBOliQEbte2rAL0CyLAAZO+H1GcVo65ui4B0w6voelgtV
 ic5SDNcrttRl7DduGcF9/T2L7xFcIZprYQZXJmpSd8BWgflQ2FroIK5faUWqm58yZI
 kOgNW9sjoYHkGbu0JCRIG53G7Bt6Fe8UB4acylRIwmUQ/Q1KCIrTFKEHp2So2kNKch
 fOd6X/qqUq95A==
Received: from p-i-exch-sc-m01.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru
 [172.16.192.107])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mx1.sberdevices.ru (Postfix) with ESMTPS;
 Thu, 12 Oct 2023 10:58:36 +0300 (MSK)
Received: from localhost.localdomain (100.64.160.123) by
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Thu, 12 Oct 2023 10:58:35 +0300
From: Alexey Romanov <avromanov@salutedevices.com>
To: <neil.armstrong@linaro.org>, <narmstrong@baylibre.com>,
 <sughosh.ganu@linaro.org>, <xypron.glpk@gmx.de>
CC: <u-boot-amlogic@groups.io>, <u-boot@lists.denx.de>,
 <kernel@sberdevices.ru>, Alexey Romanov <avromanov@salutedevices.com>
Subject: [PATCH v3 0/1] hwrng: meson - add support for S4 
Date: Thu, 12 Oct 2023 10:58:24 +0300
Message-ID: <20231012075828.22685-1-avromanov@salutedevices.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [100.64.160.123]
X-ClientProxiedBy: p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) To
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 180549 [Oct 12 2023]
X-KSMG-AntiSpam-Version: 6.0.0.2
X-KSMG-AntiSpam-Envelope-From: avromanov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 539 539
 807534d9021bfe9ca369c363d15ac993cd93d4d9,
 {Tracking_from_domain_doesnt_match_to}, 100.64.160.123:7.1.2;
 d41d8cd98f00b204e9800998ecf8427e.com:7.1.1; 127.0.0.199:7.1.2;
 p-i-exch-sc-m01.sberdevices.ru:7.1.1,5.0.1;
 salutedevices.com:7.1.1, FromAlignment: s, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960,
 bases: 2023/10/12 05:52:00 #22170293
X-KSMG-AntiVirus-Status: Clean, skipped
X-Mailman-Approved-At: Thu, 12 Oct 2023 14:26:24 +0200
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

This patch adds support for Meson S4 series
hardware number generator using new algo.

V2:

- Sync with Linux version.

V3:

- Fix compiler warning "makes pointer from integer without a cast"

Alexey Romanov (1):
  drivers: rng: add support for Meson S4

 drivers/rng/meson-rng.c | 72 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 71 insertions(+), 1 deletion(-)

-- 
2.25.1

