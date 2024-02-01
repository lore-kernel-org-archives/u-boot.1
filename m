Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34CD1C47DDF
	for <u-boot@archiver.kernel.org>; Thu,  1 Feb 2024 12:26:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9886E87C8F;
	Thu,  1 Feb 2024 13:26:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=salutedevices.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=salutedevices.com header.i=@salutedevices.com header.b="FGNpSo54";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8871B87BDC; Thu,  1 Feb 2024 10:20:39 +0100 (CET)
Received: from mx1.sberdevices.ru (mx2.sberdevices.ru [45.89.224.132])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EA14087BEE
 for <u-boot@lists.denx.de>; Thu,  1 Feb 2024 10:20:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=salutedevices.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=avromanov@salutedevices.com
Received: from p-infra-ksmg-sc-msk02 (localhost [127.0.0.1])
 by mx1.sberdevices.ru (Postfix) with ESMTP id A950B120006;
 Thu,  1 Feb 2024 12:20:35 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru A950B120006
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
 s=mail; t=1706779235;
 bh=uAni31/GI0/EES3lCyW6SJzJ6ArEuUtAMBgHcIx9cwA=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
 b=FGNpSo54HSbnm1/Fo8DnD+OQfEiDp0StzFWdz/MNp6vfG+UZjeWnK3dkvvcMrUjqf
 oCr6gnDgSbF84prQDWlpOZuTyiI1uZtP3URkFGCFCyq1rzhNdkPEAakM47m4b1AGU/
 NeMK6Eirh3hbKjuGa3lXwQz7ox+7JR2OgT2AvHggjGV2CNZ2/1oQIqAMcWkT7jjCp6
 sCKsfyD0t1ho2FAZVhcNxc6X8xfgw8q4m+Ww4l8s2iRgl5Vpxuai9iOBpKI9w+S1RE
 FyrNhEcbUJt6DVcbIamve/1GzgvRnne8MKs1jgL97Y916q8RHZzn+Nmr2LOZf5aCjr
 /7SiNtx9KOEzA==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru
 [172.16.192.107])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mx1.sberdevices.ru (Postfix) with ESMTPS;
 Thu,  1 Feb 2024 12:20:35 +0300 (MSK)
Received: from localhost.localdomain (100.64.160.123) by
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 1 Feb 2024 12:20:35 +0300
From: Alexey Romanov <avromanov@salutedevices.com>
To: <sjg@chromium.org>, <hs@denx.de>, <sean.anderson@seco.com>,
 <dimorinny@google.com>, <mkorpershoek@baylibre.com>,
 <patrick.delaunay@foss.st.com>
CC: <kernel@salutedevices.com>, <u-boot@lists.denx.de>, Alexey Romanov
 <avromanov@salutedevices.com>
Subject: [RFC PATCH v2 0/2] Introduce fastboot oem board command
Date: Thu, 1 Feb 2024 12:20:25 +0300
Message-ID: <20240201092027.6258-1-avromanov@salutedevices.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [100.64.160.123]
X-ClientProxiedBy: p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) To
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 183104 [Feb 01 2024]
X-KSMG-AntiSpam-Version: 6.1.0.3
X-KSMG-AntiSpam-Envelope-From: avromanov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 7 0.3.7
 6d6bf5bd8eea7373134f756a2fd73e9456bb7d1a, {Tracking_uf_ne_domains},
 {Tracking_from_domain_doesnt_match_to},
 d41d8cd98f00b204e9800998ecf8427e.com:7.1.1; lore.kernel.org:7.1.1;
 100.64.160.123:7.1.2; 127.0.0.199:7.1.2; smtp.sberdevices.ru:5.0.1,7.1.1;
 salutedevices.com:7.1.1, FromAlignment: s, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean, bases: 2024/02/01 08:01:00
X-KSMG-LinksScanning: Clean, bases: 2024/02/01 08:01:00
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960,
 bases: 2024/02/01 05:28:00 #23344271
X-KSMG-AntiVirus-Status: Clean, skipped
X-Mailman-Approved-At: Thu, 01 Feb 2024 13:25:59 +0100
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

Changes v2 since v1 at [1]:
    - Added an example of using the command as requsted
      by Sean Anderson [2].

Links:
    [1] https://lore.kernel.org/all/20231228152522.83291-1-avromanov@salutedevices.com/
    [2] https://lore.kernel.org/all/72ac233d-c18d-4f57-bc66-451fe0bd2997@seco.com/

Alexey Romanov (2):
  fastboot: introduce 'oem board' subcommand
  board: ad401: example of fastboot oem board realization

 board/amlogic/ad401/fastboot.c | 222 +++++++++++++++++++++++++++++++++
 drivers/fastboot/Kconfig       |   7 ++
 drivers/fastboot/fb_command.c  |  15 +++
 include/fastboot.h             |   1 +
 4 files changed, 245 insertions(+)
 create mode 100644 board/amlogic/ad401/fastboot.c

-- 
2.30.1

