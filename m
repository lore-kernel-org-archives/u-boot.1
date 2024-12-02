Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BD41D78322
	for <u-boot@archiver.kernel.org>; Mon,  2 Dec 2024 13:46:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 76E8C8937F;
	Mon,  2 Dec 2024 14:46:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=salutedevices.com header.i=@salutedevices.com header.b="kdftPWdT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3BF4E890BC; Mon,  2 Dec 2024 14:46:09 +0100 (CET)
Received: from mx1.sberdevices.ru (mx2.sberdevices.ru [45.89.224.132])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0C34A891A9
 for <u-boot@lists.denx.de>; Mon,  2 Dec 2024 14:46:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=salutedevices.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=eabachinin@salutedevices.com
Received: from p-infra-ksmg-sc-msk02.sberdevices.ru (localhost [127.0.0.1])
 by mx1.sberdevices.ru (Postfix) with ESMTP id 091DD12000F;
 Mon,  2 Dec 2024 16:46:03 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 091DD12000F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
 s=mail; t=1733147163;
 bh=Tb2/omIxRC/fI+NCGPE2Ql8+kCfSPT1U4nGcNvCel00=;
 h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:From;
 b=kdftPWdTWlYZdmf2htOdouvXCg8juzK8W1Oy4KfhGblmZWozJUAFcxxLVjOIlIimn
 yTXOcLcIbgBphdlh0Wg1smrpwVT+gixqJj1jVEDVdeqhbnnamlLC3Vl58t85aYnwAo
 cd3oRS+ra7KUj0jsksYlBi/afztadQpi2ebWAF//1dW5n8nd30p94TVHV5MyBxBLt5
 NUH1m1h+Rg2MkrdhrNxMftnkpAjAbJlffwu2wW89P57VBRJ9/irTnTz9wLuWp9+kLO
 uft9hkZOxeG6dKFQstZfH8yL8i79X/QKmYzVurlS6wQHvml6YnCM/6Z9Ff7mGcYvkI
 yWO3fdUVAoEFA==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m02.sberdevices.ru
 [172.16.192.103])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mx1.sberdevices.ru (Postfix) with ESMTPS;
 Mon,  2 Dec 2024 16:46:02 +0300 (MSK)
From: Evgeny Bachinin <EABachinin@salutedevices.com>
Date: Mon, 2 Dec 2024 16:45:24 +0300
Subject: [PATCH 3/5] test: sandbox: fix link error with do_ut_bloblist if
 BLOBLIST=n
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20241202-sandbox_repair_of_embed-v1-3-05aff4b0ccf7@salutedevices.com>
References: <20241202-sandbox_repair_of_embed-v1-0-05aff4b0ccf7@salutedevices.com>
In-Reply-To: <20241202-sandbox_repair_of_embed-v1-0-05aff4b0ccf7@salutedevices.com>
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, "Heinrich
 Schuchardt" <xypron.glpk@gmx.de>, Raymond Mao <raymond.mao@linaro.org>,
 "Ilias Apalodimas" <ilias.apalodimas@linaro.org>, Patrick Rudolph
 <patrick.rudolph@9elements.com>, Levi Yun <yeoreum.yun@arm.com>, "Francis
 Laniel" <francis.laniel@amarulasolutions.com>
CC: <kernel@salutedevices.com>, <evgen89bachinin@gmail.com>,
 <u-boot@lists.denx.de>, Evgeny Bachinin <EABachinin@salutedevices.com>
X-Mailer: b4 0.14.2
X-Originating-IP: [172.28.132.49]
X-ClientProxiedBy: p-i-exch-a-m2.sberdevices.ru (172.24.196.120) To
 p-i-exch-a-m1.sberdevices.ru (172.24.196.116)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 189547 [Dec 02 2024]
X-KSMG-AntiSpam-Version: 6.1.1.7
X-KSMG-AntiSpam-Envelope-From: eabachinin@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 44 0.3.44
 5149b91aab9eaefa5f6630aab0c7a7210c633ab6,
 {Tracking_from_domain_doesnt_match_to}, smtp.sberdevices.ru:5.0.1,7.1.1;
 127.0.0.199:7.1.2; d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;
 salutedevices.com:7.1.1, FromAlignment: s
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960,
 bases: 2024/12/02 11:33:00 #26927957
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

Having CONFIG_OF_EMBED=y && CONFIG_BLOBLIST=n leads to the link
error:
```
ld: /tmp/ccwtRVty.ltrans28.ltrans.o:(.data.rel+0x4b0): undefined \
                                         reference to `do_ut_bloblist'
```

Fixes: 6ea5df39e8d ("test: Only enable bloblist test when supported")
Signed-off-by: Evgeny Bachinin <EABachinin@salutedevices.com>
---
 test/cmd_ut.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/test/cmd_ut.c b/test/cmd_ut.c
index 195b7ea50accde470a739771e058c1d664df3f0b..842c2c3e7f65eb9fe017fa1949eb2390be171487 100644
--- a/test/cmd_ut.c
+++ b/test/cmd_ut.c
@@ -104,8 +104,10 @@ static struct cmd_tbl cmd_ut_sub[] = {
 			 "", ""),
 #endif
 #ifdef CONFIG_SANDBOX
+#if CONFIG_IS_ENABLED(BLOBLIST)
 	U_BOOT_CMD_MKENT(bloblist, CONFIG_SYS_MAXARGS, 1, do_ut_bloblist,
 			 "", ""),
+#endif
 	U_BOOT_CMD_MKENT(bootm, CONFIG_SYS_MAXARGS, 1, do_ut_bootm, "", ""),
 #endif
 #ifdef CONFIG_CMD_ADDRMAP

-- 
2.34.1

