Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72133C30653
	for <u-boot@archiver.kernel.org>; Wed, 26 Jun 2024 12:31:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D764A8857F;
	Wed, 26 Jun 2024 14:29:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=salutedevices.com header.i=@salutedevices.com header.b="SQOoR9aw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C0E338844F; Wed, 26 Jun 2024 12:45:49 +0200 (CEST)
Received: from mx1.sberdevices.ru (mx2.sberdevices.ru [45.89.224.132])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CA544880A5
 for <u-boot@lists.denx.de>; Wed, 26 Jun 2024 12:45:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=salutedevices.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=avromanov@salutedevices.com
Received: from p-infra-ksmg-sc-msk02.sberdevices.ru (localhost [127.0.0.1])
 by mx1.sberdevices.ru (Postfix) with ESMTP id 5D0B6120011;
 Wed, 26 Jun 2024 13:45:47 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 5D0B6120011
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
 s=mail; t=1719398747;
 bh=626RGJ/DvnTdGE7pSF4ZUJgIp+13W+z2fonGcIEK8bc=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
 b=SQOoR9awRcDi9P31EotR7MYloV7y/OO7nKX5b1FySFaCyoICxo7JUi+SKjUJuXWkd
 50qLgvXhppY0S3YncOovZp3F5AEBJWpdzNkO3qM+Jb+NjUyK7ypWH/Z70wzE3YWKbJ
 CGVvuIVoLH1Udc4Lrix0ilovPGeqYsdEzuN2RUXmHZRA2QoNUwsm/z4MgeERKuFEHW
 uWdCytFpQ6J7l1B1OEMcScsRPmYrZhA23fscBt2E7HV6LSJ6LyuTysDqLspmMgpql+
 uRyJhzS4LPZFvcVw4pffN0WIRVhVtjc61z9oa4szI5Kvj3K0tP/AlWIcj4ocTQwBj5
 50Zi92VPHVDdQ==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m02.sberdevices.ru
 [172.16.192.103])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mx1.sberdevices.ru (Postfix) with ESMTPS;
 Wed, 26 Jun 2024 13:45:47 +0300 (MSK)
Received: from user-A520M-DS3H.sigma.sbrf.ru (100.64.160.123) by
 p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 26 Jun 2024 13:45:45 +0300
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
Subject: [PATCH v5 4/6] disk: don't try search for partition type if already
 set
Date: Wed, 26 Jun 2024 13:45:25 +0300
Message-ID: <20240626104527.2811828-5-avromanov@salutedevices.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240626104527.2811828-1-avromanov@salutedevices.com>
References: <20240626104527.2811828-1-avromanov@salutedevices.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [100.64.160.123]
X-ClientProxiedBy: p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) To
 p-i-exch-sc-m02.sberdevices.ru (172.16.192.103)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 186156 [Jun 26 2024]
X-KSMG-AntiSpam-Version: 6.1.0.4
X-KSMG-AntiSpam-Envelope-From: avromanov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 20 0.3.20
 743589a8af6ec90b529f2124c2bbfc3ce1d2f20f,
 {Tracking_from_domain_doesnt_match_to}, salutedevices.com:7.1.1;
 smtp.sberdevices.ru:5.0.1,7.1.1; 127.0.0.199:7.1.2; 100.64.160.123:7.1.2;
 d41d8cd98f00b204e9800998ecf8427e.com:7.1.1, FromAlignment: s,
 ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960,
 bases: 2024/06/26 09:49:00 #25717626
X-KSMG-AntiVirus-Status: Clean, skipped
X-Mailman-Approved-At: Wed, 26 Jun 2024 14:29:28 +0200
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
index 3f0fce5cfa..0aced6eb72 100644
--- a/disk/part.c
+++ b/disk/part.c
@@ -286,6 +286,13 @@ void part_init(struct blk_desc *desc)
 
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

