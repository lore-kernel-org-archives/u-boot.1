Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED356D78322
	for <u-boot@archiver.kernel.org>; Mon,  2 Dec 2024 13:46:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1033489339;
	Mon,  2 Dec 2024 14:46:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=salutedevices.com header.i=@salutedevices.com header.b="o8ubwi57";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2FA1788DDA; Mon,  2 Dec 2024 14:46:09 +0100 (CET)
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [37.18.73.165])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BD4E58914C
 for <u-boot@lists.denx.de>; Mon,  2 Dec 2024 14:46:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=salutedevices.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=eabachinin@salutedevices.com
Received: from p-infra-ksmg-sc-msk01.sberdevices.ru (localhost [127.0.0.1])
 by mx1.sberdevices.ru (Postfix) with ESMTP id 9849B100009;
 Mon,  2 Dec 2024 16:46:02 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 9849B100009
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
 s=mail; t=1733147162;
 bh=l2gBDhfYzm69/rEklllwT8WmspVJSadjJzHvsS/q4dQ=;
 h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:From;
 b=o8ubwi57C2lLOJBpBP64NmjszIylqRNwjIA9Z6ui//PaswG1R+bIlPAwEfuBOSsH3
 1Cb9R/7CX+ODbnJpzXdvZ4edqQlGY7lnkPBvraikEUUgAKyDVrEpf+QgFQuQL/kgvw
 pka9ckDWuGsJ+N4WuNjSszJXoH+CCHMVdZ46uu6IjP7YTV+6ZwRldgiDdlAtVel8Yq
 WrWIATKjeLvJuazeUWq1lPlJZyNf92JekMR7+2UUBYe3yhdrRNz9kMi0n5Hqxvy6F/
 xkBxJbidgj8+sHhTmVGvK4SPbAg64sRuS+W7YHkyRGIcgzkp0HZyq4gDpyvcdCV7dp
 1jhA4aeaHDTgg==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru
 [172.16.192.107])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mx1.sberdevices.ru (Postfix) with ESMTPS;
 Mon,  2 Dec 2024 16:46:02 +0300 (MSK)
From: Evgeny Bachinin <EABachinin@salutedevices.com>
Date: Mon, 2 Dec 2024 16:45:22 +0300
Subject: [PATCH 1/5] sandbox: fix bloblist_finish() linker error if BLOBLIST=n
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20241202-sandbox_repair_of_embed-v1-1-05aff4b0ccf7@salutedevices.com>
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
 {Tracking_from_domain_doesnt_match_to}, smtp.sberdevices.ru:7.1.1,5.0.1;
 d41d8cd98f00b204e9800998ecf8427e.com:7.1.1; 127.0.0.199:7.1.2;
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
ld: /tmp/ccwtRVty.ltrans0.ltrans.o: in function `state_uninit':
arch/sandbox/cpu/state.c:508: undefined reference to `bloblist_finish'
```

Fixes: 1c52fcca72b ("sandbox: Write out bloblist when exiting")
Signed-off-by: Evgeny Bachinin <EABachinin@salutedevices.com>
---
 include/bloblist.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/include/bloblist.h b/include/bloblist.h
index ff32d3fecfd4e0474aa4047d1ae6421536570ec6..f999391f74bfd21098198bdd24dbb898a17320fd 100644
--- a/include/bloblist.h
+++ b/include/bloblist.h
@@ -357,6 +357,7 @@ int bloblist_new(ulong addr, uint size, uint flags, uint align_log2);
  */
 int bloblist_check(ulong addr, uint size);
 
+#if CONFIG_IS_ENABLED(BLOBLIST)
 /**
  * bloblist_finish() - Set up the bloblist for the next U-Boot part
  *
@@ -366,6 +367,12 @@ int bloblist_check(ulong addr, uint size);
  * Return: 0
  */
 int bloblist_finish(void);
+#else
+static inline int bloblist_finish(void)
+{
+	return 0;
+}
+#endif /* BLOBLIST */
 
 /**
  * bloblist_get_stats() - Get information about the bloblist

-- 
2.34.1

