Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AC69E7717F
	for <u-boot@archiver.kernel.org>; Tue, 10 Dec 2024 22:40:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2470C8021F;
	Tue, 10 Dec 2024 23:40:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=salutedevices.com header.i=@salutedevices.com header.b="bH77E+qf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 542948020B; Tue, 10 Dec 2024 23:40:18 +0100 (CET)
Received: from mx1.sberdevices.ru (mx2.sberdevices.ru [45.89.224.132])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3D50E80216
 for <u-boot@lists.denx.de>; Tue, 10 Dec 2024 23:40:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=salutedevices.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=eabachinin@salutedevices.com
Received: from p-infra-ksmg-sc-msk02.sberdevices.ru (localhost [127.0.0.1])
 by mx1.sberdevices.ru (Postfix) with ESMTP id B629D120010;
 Wed, 11 Dec 2024 01:40:14 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru B629D120010
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
 s=mail; t=1733870414;
 bh=kFnIfWTDelKkMXC0v80T8Qld3y84a6cCYxNeNJFriIU=;
 h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:From;
 b=bH77E+qfeW3T6SlrZC2gz1/ji+5o2tP+7SSL2SWpESYACstBx01OMo1ovARlvyDUc
 /rBZvph4wsJJCoioiiYy1gUAe4XOijrNUcm8ODKBTC24W1NJMLRdEjKm8yLw6HUt5p
 gsDEf1JdEZxcr2vQqjY1bAEpUP1VuM9WEohFTwhXCKGY/jhfzAVzWumeDVNOAlsAII
 pM4/nNDkCg2JVAyMbfUs+Jg0YNNjILiTafW9XjXvJ9VXEFA4W7myWUr9qtbCPE/wYN
 rLXNFZnVVif6L2IE/vEhEiOVCbq7Sr5xKDMmMPdaSQP3xwR72y33ev5+pjHSmiMQKO
 naybV7jMHhNNQ==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m02.sberdevices.ru
 [172.16.192.103])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mx1.sberdevices.ru (Postfix) with ESMTPS;
 Wed, 11 Dec 2024 01:40:14 +0300 (MSK)
From: Evgeny Bachinin <EABachinin@salutedevices.com>
Date: Wed, 11 Dec 2024 01:39:58 +0300
Subject: [PATCH 2/2] fdtdec: dtb_dt_embedded: replace ifdefs by
 IS_ENABLED()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20241211-dtb_dt_embedded_within_fdtdec-v1-2-7840469f0084@salutedevices.com>
References: <20241211-dtb_dt_embedded_within_fdtdec-v1-0-7840469f0084@salutedevices.com>
In-Reply-To: <20241211-dtb_dt_embedded_within_fdtdec-v1-0-7840469f0084@salutedevices.com>
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, "Rasmus
 Villemoes" <rasmus.villemoes@prevas.dk>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, Raymond Mao <raymond.mao@linaro.org>, "Marek
 Vasut" <marek.vasut+renesas@mailbox.org>, Sughosh Ganu
 <sughosh.ganu@linaro.org>, Christian Marangi <ansuelsmth@gmail.com>, "Lad
 Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>, Evgeny Bachinin
 <EABachinin@salutedevices.com>
CC: <kernel@salutedevices.com>, <evgen89bachinin@gmail.com>,
 <u-boot@lists.denx.de>
X-Mailer: b4 0.14.2
X-Originating-IP: [172.28.224.238]
X-ClientProxiedBy: p-i-exch-a-m2.sberdevices.ru (172.24.196.120) To
 p-i-exch-a-m1.sberdevices.ru (172.24.196.116)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 189752 [Dec 10 2024]
X-KSMG-AntiSpam-Version: 6.1.1.7
X-KSMG-AntiSpam-Envelope-From: eabachinin@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 44 0.3.44
 5149b91aab9eaefa5f6630aab0c7a7210c633ab6,
 {Tracking_from_domain_doesnt_match_to}, smtp.sberdevices.ru:7.1.1,5.0.1;
 d41d8cd98f00b204e9800998ecf8427e.com:7.1.1; salutedevices.com:7.1.1;
 127.0.0.199:7.1.2, FromAlignment: s
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960,
 bases: 2024/12/10 16:39:00 #26956987
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

Patch fixes the checkpatch warnings like:
```
  WARNING: Use 'if (IS_ENABLED(CONFIG...))' instead of '#if or #ifdef'
  #94: FILE: lib/fdtdec.c:102:
  +#ifdef CONFIG_OF_EMBED
```

Signed-off-by: Evgeny Bachinin <EABachinin@salutedevices.com>
---
 lib/fdtdec.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/lib/fdtdec.c b/lib/fdtdec.c
index 9cb94a158441cfd291a0f173c321a722e896bcb2..7f1418890860a759efcf2b84551d24a3697e4a4b 100644
--- a/lib/fdtdec.c
+++ b/lib/fdtdec.c
@@ -99,15 +99,15 @@ extern u8 __dtb_dt_spl_begin[];	/* embedded device tree blob for SPL/TPL */
 /* Get a pointer to the embedded devicetree, if there is one, else NULL */
 static u8 *dtb_dt_embedded(void)
 {
-#ifdef CONFIG_OF_EMBED
-# ifdef CONFIG_XPL_BUILD
-	return __dtb_dt_spl_begin;
-# else
-	return __dtb_dt_begin;
-# endif
-#else
-	return NULL;
-#endif
+	u8 *addr = NULL;
+
+	if (IS_ENABLED(CONFIG_OF_EMBED)) {
+		addr = __dtb_dt_begin;
+
+		if (IS_ENABLED(CONFIG_XPL_BUILD))
+			addr = __dtb_dt_spl_begin;
+	}
+	return addr;
 }
 
 const char *fdtdec_get_srcname(void)

-- 
2.34.1

