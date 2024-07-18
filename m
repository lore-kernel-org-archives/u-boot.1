Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F699C3DA60
	for <u-boot@archiver.kernel.org>; Thu, 18 Jul 2024 08:35:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C094C88B22;
	Thu, 18 Jul 2024 10:35:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=salutedevices.com header.i=@salutedevices.com header.b="awsAs/aW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1F05688354; Thu, 18 Jul 2024 07:45:49 +0200 (CEST)
Received: from mx1.sberdevices.ru (mx2.sberdevices.ru [45.89.224.132])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2814088AF8
 for <u-boot@lists.denx.de>; Thu, 18 Jul 2024 07:45:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=salutedevices.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=avromanov@salutedevices.com
Received: from p-infra-ksmg-sc-msk02.sberdevices.ru (localhost [127.0.0.1])
 by mx1.sberdevices.ru (Postfix) with ESMTP id AC2A4120012;
 Thu, 18 Jul 2024 08:45:46 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru AC2A4120012
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
 s=mail; t=1721281546;
 bh=YyfUeKJN0PWFOP1vACkPGb+J97fjgLJeDtXlmjHo0oo=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
 b=awsAs/aWV/Bi4q2amXFjlL2umLeUTCrdzgGZ6bn7BzagkW4zW2CBMdeGvqokqS6xY
 nomFKoUZT0Or1TmlSE1Q9BGU277LSn+qlGdLIUVX1rRmafgakzWc3RsEgWcd6Bao5Q
 Bhj2y1y7TOmD7h1hqL0VvfThOEAcbkiHIKMkPtp9sgUITAsCRPGSU9/0MEhtNztNBf
 D0pYlCT8CMm2JDeseKDj6s1VcVS9aNPPz0XrDMgrtfrC40LRFwKU45/Hwi88VhhTn8
 F+lhloJJm/vrK6Clq07xnlwquGbzA/RUe8z0c9D3qllmqfZ0v5K90A6obP6GQqgcj6
 Kc/Qcd7yC57Qw==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m02.sberdevices.ru
 [172.16.192.103])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mx1.sberdevices.ru (Postfix) with ESMTPS;
 Thu, 18 Jul 2024 08:45:46 +0300 (MSK)
Received: from user-A520M-DS3H.sberdevices.ru (100.64.160.123) by
 p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 18 Jul 2024 08:45:46 +0300
From: Alexey Romanov <avromanov@salutedevices.com>
To: <dario.binacchi@amarulasolutions.com>, <michael@amarulasolutions.com>,
 <frieder.schrempf@kontron.de>, <kmpark@infradead.org>, <hs@denx.de>,
 <joe.hershberger@ni.com>, <dunaev@tecon.ru>, <sjg@chromium.org>,
 <bmeng@tinylab.org>, <xypron.glpk@gmx.de>, <tobias@waldekranz.com>,
 <jpewhacker@gmail.com>, <marek.vasut+renesas@mailbox.org>,
 <kever.yang@rock-chips.com>, <jbx6244@gmail.com>,
 <abdellatif.elkhlifi@arm.com>, <mikhail.kshevetskiy@iopsys.eu>,
 <jagan@amarulasolutions.com>
CC: <kernel@salutedevices.com>, <u-boot@lists.denx.de>, Alexey Romanov
 <avromanov@salutedevices.com>
Subject: [PATCH v6 4/6] disk: don't try search for partition type if already
 set
Date: Thu, 18 Jul 2024 08:45:26 +0300
Message-ID: <20240718054528.799539-5-avromanov@salutedevices.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240718054528.799539-1-avromanov@salutedevices.com>
References: <20240718054528.799539-1-avromanov@salutedevices.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [100.64.160.123]
X-ClientProxiedBy: p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) To
 p-i-exch-sc-m02.sberdevices.ru (172.16.192.103)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 186573 [Jul 18 2024]
X-KSMG-AntiSpam-Version: 6.1.0.4
X-KSMG-AntiSpam-Envelope-From: avromanov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 24 0.3.24
 186c4d603b899ccfd4883d230c53f273b80e467f,
 {Tracking_from_domain_doesnt_match_to}, salutedevices.com:7.1.1;
 smtp.sberdevices.ru:7.1.1,5.0.1; 100.64.160.123:7.1.2; 127.0.0.199:7.1.2;
 d41d8cd98f00b204e9800998ecf8427e.com:7.1.1, FromAlignment: s,
 ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960,
 bases: 2024/07/18 03:46:00 #26059015
X-KSMG-AntiVirus-Status: Clean, skipped
X-Mailman-Approved-At: Thu, 18 Jul 2024 10:35:04 +0200
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

Block devices can already set partition type at initialization
stage, so, in this case is no point in searching for partition type.

Signed-off-by: Alexey Romanov <avromanov@salutedevices.com>
Reviewed-by: Heiko Schocher <hs@denx.de>
---
 disk/part.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/disk/part.c b/disk/part.c
index 86f669926e..706d77b319 100644
--- a/disk/part.c
+++ b/disk/part.c
@@ -285,6 +285,13 @@ void part_init(struct blk_desc *desc)
 
 	blkcache_invalidate(desc->uclass_id, desc->devnum);
 
+	if (desc->part_type != PART_TYPE_UNKNOWN) {
+		for (entry = drv; entry != drv + n_ents; entry++) {
+			if (entry->part_type == desc->part_type && !entry->test(desc))
+				return;
+		}
+	}
+
 	desc->part_type = PART_TYPE_UNKNOWN;
 	for (entry = drv; entry != drv + n_ents; entry++) {
 		int ret;
-- 
2.34.1

