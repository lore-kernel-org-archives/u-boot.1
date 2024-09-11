Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C592EE57D7
	for <u-boot@archiver.kernel.org>; Wed, 11 Sep 2024 21:50:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 88D0C88A74;
	Wed, 11 Sep 2024 23:50:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=salutedevices.com header.i=@salutedevices.com header.b="Ws4x0oM/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DE24F88C30; Wed, 11 Sep 2024 23:50:03 +0200 (CEST)
Received: from mx1.sberdevices.ru (mx2.sberdevices.ru [45.89.224.132])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A873388B89
 for <u-boot@lists.denx.de>; Wed, 11 Sep 2024 23:49:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=salutedevices.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ddrokosov@salutedevices.com
Received: from p-infra-ksmg-sc-msk02.sberdevices.ru (localhost [127.0.0.1])
 by mx1.sberdevices.ru (Postfix) with ESMTP id 399F112000D;
 Thu, 12 Sep 2024 00:49:59 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 399F112000D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
 s=mail; t=1726091399;
 bh=E6U87MBjHv4EZRuPYP+lw22qMmIloW6u5Sv4VQwD7sQ=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
 b=Ws4x0oM/tEdUKHKr65EZgMRkfaXOJSswXb7aEsR7Vx2DxNcwlepsoUvXGp3j7OZd/
 aN0vlJFamzGc0UYmgNrgoppYwS0vm8GS0wVhW5+zJNxQR/lXrY9q6Ja6+uDPN+hNRw
 rjzqxmlKOwsSMsxhYz93mFa3b9eGLD8Y2MpPOHt6jWGajwDan3QVEWTHzvnfx7XAFN
 THUXySaYEM2GZBbgkAtZU4yTChc52NYaBtbkt2UsxGjGZsQ2mMxp5PaD/eQjXG3lbP
 Ve6T0CSBf6rGaGb0a69iX7S14f8OdtCZKBC9/XQOIdkaQoR1xyuAkYFDELQcCtmRfS
 RlWyONKpbor7w==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru
 [172.16.192.107])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mx1.sberdevices.ru (Postfix) with ESMTPS;
 Thu, 12 Sep 2024 00:49:57 +0300 (MSK)
From: Dmitry Rokosov <ddrokosov@salutedevices.com>
To: <igor.opaniuk@gmail.com>, <mkorpershoek@baylibre.com>, <sjg@chromium.org>, 
 <semen.protsenko@linaro.org>, <trini@konsulko.com>,
 <colin.mcallister@garmin.com>, <4.shket@gmail.com>,
 <avromanov@salutedevices.com>
CC: <u-boot@lists.denx.de>, <kernel@salutedevices.com>, <rockosov@gmail.com>, 
 Dmitry Rokosov <ddrokosov@salutedevices.com>
Subject: [PATCH v2 3/6] cmd: bcb: change strcmp() usage style in the
 do_bcb_ab_select()
Date: Thu, 12 Sep 2024 00:49:11 +0300
Message-ID: <20240911214945.15873-4-ddrokosov@salutedevices.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240911214945.15873-1-ddrokosov@salutedevices.com>
References: <20240911214945.15873-1-ddrokosov@salutedevices.com>
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
 766319f57b3d5e49f2c79a76e7d7087b621090df,
 {Tracking_from_domain_doesnt_match_to}, salutedevices.com:7.1.1;
 smtp.sberdevices.ru:7.1.1,5.0.1; d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;
 127.0.0.199:7.1.2, FromAlignment: s
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
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

In the entire cmd/bcb.c file, the return value of strcmp() is not
directly compared to 0. Therefore, it would be better to maintain this
style in the new do_bcb_ab_select() function as well.

Signed-off-by: Dmitry Rokosov <ddrokosov@salutedevices.com>
---
 cmd/bcb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/cmd/bcb.c b/cmd/bcb.c
index a56535a743c0..a888549eed3a 100644
--- a/cmd/bcb.c
+++ b/cmd/bcb.c
@@ -432,7 +432,7 @@ static int do_bcb_ab_select(struct cmd_tbl *cmdtp, int flag, int argc,
 	bool dec_tries = true;
 
 	for (int i = 4; i < argc; i++) {
-		if (strcmp(argv[i], "--no-dec") == 0)
+		if (!strcmp(argv[i], "--no-dec"))
 			dec_tries = false;
 		else
 			return CMD_RET_USAGE;
-- 
2.43.0

