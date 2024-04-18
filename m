Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CEFEC4345F
	for <u-boot@archiver.kernel.org>; Thu, 18 Apr 2024 12:50:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6DB5288638;
	Thu, 18 Apr 2024 14:50:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=salutedevices.com header.i=@salutedevices.com header.b="OUORI1Ln";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 51A23885BE; Thu, 18 Apr 2024 12:01:48 +0200 (CEST)
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [37.18.73.165])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 54F32885B8
 for <u-boot@lists.denx.de>; Thu, 18 Apr 2024 12:01:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=salutedevices.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=avromanov@salutedevices.com
Received: from p-infra-ksmg-sc-msk01 (localhost [127.0.0.1])
 by mx1.sberdevices.ru (Postfix) with ESMTP id B5EA610000E;
 Thu, 18 Apr 2024 13:01:42 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru B5EA610000E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
 s=mail; t=1713434502;
 bh=J7I+ZVQ6me/4/Tx7q1azoXNt8RLOEe6B85ntZPK2RIc=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
 b=OUORI1Lng0dMd8wrifEQWXaR3CDtinfKjKzygDfp6uWmWaNFJh9wrnnLAXh1ScUBg
 FjRQzKZmHDG4n2Zu1U7VxG95rvfopniDfv//ukStIedScadYSU+mGQq35BjgZq6xti
 dbcJerrdaEwi2hg0kULE+QnVdLCK0Ai1USZk+vv5x8wjZy4Ob+I21R7lVLsuFTd1ic
 QF3iIAhJkSwPXcFEjSdmgiQwFbgZAyVufcoUJdibVPfMidqeLHl8CVY7j1DgUpIJqR
 AOec52E6EBL9P8b4w99Db34fccohzNiVVuHNJFFtjNGhW+x+15fZeaneSqUleKJSmi
 CeRtYwIsGKLRQ==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m02.sberdevices.ru
 [172.16.192.103])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mx1.sberdevices.ru (Postfix) with ESMTPS;
 Thu, 18 Apr 2024 13:01:42 +0300 (MSK)
Received: from user-A520M-DS3H.sberdevices.ru (100.64.160.123) by
 p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 18 Apr 2024 13:01:41 +0300
From: Alexey Romanov <avromanov@salutedevices.com>
To: <sjg@chromium.org>, <hs@denx.de>, <sean.anderson@seco.com>,
 <dimorinny@google.com>, <mkorpershoek@baylibre.com>,
 <patrick.delaunay@foss.st.com>, <quentin.schulz@theobroma-systems.com>
CC: <kernel@salutedevices.com>, <u-boot@lists.denx.de>, Alexey Romanov
 <avromanov@salutedevices.com>
Subject: [PATCH v5 0/1] Introduce fastboot oem board command 
Date: Thu, 18 Apr 2024 13:01:28 +0300
Message-ID: <20240418100129.1691822-1-avromanov@salutedevices.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [100.64.160.123]
X-ClientProxiedBy: p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) To
 p-i-exch-sc-m02.sberdevices.ru (172.16.192.103)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 184778 [Apr 18 2024]
X-KSMG-AntiSpam-Version: 6.1.0.4
X-KSMG-AntiSpam-Envelope-From: avromanov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 17 0.3.17
 f2153f38d75b12894d9cf445f96cd15c9ef63a9d, {Tracking_uf_ne_domains},
 {Tracking_from_domain_doesnt_match_to}, 127.0.0.199:7.1.2;
 d41d8cd98f00b204e9800998ecf8427e.com:7.1.1; smtp.sberdevices.ru:7.1.1,5.0.1;
 lore.kernel.org:7.1.1; salutedevices.com:7.1.1;
 100.64.160.123:7.1.2, FromAlignment: s, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean, bases: 2024/04/18 09:33:00
X-KSMG-LinksScanning: Clean, bases: 2024/04/18 09:33:00
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960,
 bases: 2024/04/18 03:27:00 #24847765
X-KSMG-AntiVirus-Status: Clean, skipped
X-Mailman-Approved-At: Thu, 18 Apr 2024 14:50:43 +0200
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

Changes V1 -> V2 [1]:
  - Added an example of using the command as requested
    by Sean Anderson [2].

Changes V2 -> V3 [3]:
  - Rebase over uboot/master.
  - Add documentation.
  - Remove example added in V2 [1].

Changes V3 -> V4 [4]:
  - Corrected documentation accroding to Quentin Schulz comments [5].

Changes V4 -> V5 [6]:
  - Fix compiler warning reported by CI [7].

Links:
    [1] https://lore.kernel.org/all/20231228152522.83291-1-avromanov@salutedevices.com/
    [2] https://lore.kernel.org/all/72ac233d-c18d-4f57-bc66-451fe0bd2997@seco.com/
    [3] https://lore.kernel.org/all/20240201092027.6258-1-avromanov@salutedevices.com/
    [4] https://lore.kernel.org/all/20240408101552.539037-1-avromanov@salutedevices.com/
    [5] https://lore.kernel.org/all/9efdf140-8da3-4b5e-b1c4-2f106067afd3@theobroma-systems.com/
    [6] https://lore.kernel.org/all/20240410105804.22757-1-avromanov@salutedevices.com/
    [7] https://lore.kernel.org/all/877cgv3ur6.fsf@baylibre.com/

Alexey Romanov (1):
  fastboot: introduce 'oem board' subcommand

 doc/android/fastboot.rst      | 18 ++++++++++++++++++
 drivers/fastboot/Kconfig      |  7 +++++++
 drivers/fastboot/fb_command.c | 30 ++++++++++++++++++++++++++++++
 include/fastboot.h            |  1 +
 4 files changed, 56 insertions(+)

-- 
2.34.1

