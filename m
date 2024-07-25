Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B062C3DA49
	for <u-boot@archiver.kernel.org>; Thu, 25 Jul 2024 20:55:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 71D70885EC;
	Thu, 25 Jul 2024 22:55:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=salutedevices.com header.i=@salutedevices.com header.b="FW/AvNC/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 696C88692C; Thu, 25 Jul 2024 21:47:31 +0200 (CEST)
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [37.18.73.165])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B66EC88286
 for <u-boot@lists.denx.de>; Thu, 25 Jul 2024 21:47:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=salutedevices.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ddrokosov@salutedevices.com
Received: from p-infra-ksmg-sc-msk01.sberdevices.ru (localhost [127.0.0.1])
 by mx1.sberdevices.ru (Postfix) with ESMTP id 1595F100006;
 Thu, 25 Jul 2024 22:47:25 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 1595F100006
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
 s=mail; t=1721936845;
 bh=m8Eb46pgDZNBk+N9GLBoY0oOgg9U7qCFGjERvsdrM4Y=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
 b=FW/AvNC/Lzk8iy2rNs24R/Su6GJckgXwiMgs96w7KpY5dnuIA7XBn+q8BDf0wXMTa
 CuN9r+6pKT4dq/3Dm6/5V0hneqInidhoTxI4B2f4ldW2QjRgmOcHJgE+1QXXWfjBGn
 fAya6LjCR6ZSpzXrI8yRXE8/CIitWF8cIvBLNsgdFphcqIXCYoRSZ2iNgGCiz9IbIz
 YzWFdG2YS606mLFC3X69xY4fUuCEKcq+uBzoLNVxgZeCdPdMoORneVsFzxaQ4hYc0e
 3Nzsx9zNMsbXoWM55W0I046aWUVLELmvFEQlK5901m2+YQah/FOdWCcxzspcFfzLqu
 w79LeiXIJghww==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m02.sberdevices.ru
 [172.16.192.103])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mx1.sberdevices.ru (Postfix) with ESMTPS;
 Thu, 25 Jul 2024 22:47:24 +0300 (MSK)
Received: from CAB-WSD-L081021.sberdevices.ru (100.64.160.123) by
 p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 25 Jul 2024 22:47:24 +0300
From: Dmitry Rokosov <ddrokosov@salutedevices.com>
To: <igor.opaniuk@gmail.com>, <mkorpershoek@baylibre.com>,
 <semen.protsenko@linaro.org>, <trini@konsulko.com>,
 <colin.mcallister@garmin.com>, <4.shket@gmail.com>,
 <avromanov@salutedevices.com>
CC: <u-boot@lists.denx.de>, <kernel@salutedevices.com>, <rockosov@gmail.com>, 
 Dmitry Rokosov <ddrokosov@salutedevices.com>
Subject: [PATCH v1 1/4] cmd: ab_select: fix indentation problems for --no-dec
 parameter
Date: Thu, 25 Jul 2024 22:47:01 +0300
Message-ID: <20240725194716.32232-2-ddrokosov@salutedevices.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240725194716.32232-1-ddrokosov@salutedevices.com>
References: <20240725194716.32232-1-ddrokosov@salutedevices.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [100.64.160.123]
X-ClientProxiedBy: p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) To
 p-i-exch-sc-m02.sberdevices.ru (172.16.192.103)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 186723 [Jul 25 2024]
X-KSMG-AntiSpam-Version: 6.1.0.4
X-KSMG-AntiSpam-Envelope-From: ddrokosov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 24 0.3.24
 186c4d603b899ccfd4883d230c53f273b80e467f,
 {Tracking_from_domain_doesnt_match_to}, 100.64.160.123:7.1.2;
 salutedevices.com:7.1.1; smtp.sberdevices.ru:5.0.1,7.1.1;
 d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;
 127.0.0.199:7.1.2, FromAlignment: s, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960,
 bases: 2024/07/25 17:13:00 #26148857
X-KSMG-AntiVirus-Status: Clean, skipped
X-Mailman-Approved-At: Thu, 25 Jul 2024 22:55:09 +0200
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

Command ab_select has wrong help description from indentation
perspective.

Signed-off-by: Dmitry Rokosov <ddrokosov@salutedevices.com>
---
 cmd/ab_select.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/cmd/ab_select.c b/cmd/ab_select.c
index bfb67b8236b6..9e2f74573c22 100644
--- a/cmd/ab_select.c
+++ b/cmd/ab_select.c
@@ -63,6 +63,6 @@ U_BOOT_CMD(ab_select, 5, 0, do_ab_select,
 	   "    - If 'part_name' is passed, preceded with a # instead of :, the\n"
 	   "      partition name whose label is 'part_name' will be looked up in\n"
 	   "      the partition table. This is commonly the \"misc\" partition.\n"
-           "    - If '--no-dec' is set, the number of tries remaining will not\n"
-           "      decremented for the selected boot slot\n"
+	   "    - If '--no-dec' is set, the number of tries remaining will not\n"
+	   "      decremented for the selected boot slot\n"
 );
-- 
2.43.0

