Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CE92C4167B
	for <u-boot@archiver.kernel.org>; Tue,  5 Dec 2023 23:24:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 25D6887494;
	Wed,  6 Dec 2023 00:24:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=salutedevices.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=salutedevices.com header.i=@salutedevices.com header.b="e/sFNpHE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DE0DA870EA; Wed,  6 Dec 2023 00:24:05 +0100 (CET)
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [37.18.73.165])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9C7F987447
 for <u-boot@lists.denx.de>; Wed,  6 Dec 2023 00:23:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=salutedevices.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ivprusov@salutedevices.com
Received: from p-infra-ksmg-sc-msk01 (localhost [127.0.0.1])
 by mx1.sberdevices.ru (Postfix) with ESMTP id EDFB2100063;
 Wed,  6 Dec 2023 02:23:57 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru EDFB2100063
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
 s=mail; t=1701818637;
 bh=S+j1EAhJWx6yUd/iIxB6zWR1GvXmV9XtmckQo7UN5e4=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
 b=e/sFNpHEEzcFy/FJxIIWouei/01WcqF8FVkebDYZWtPL0WYJtrzgHQmeAR09Wk7UN
 asvZ4JyVz8Di7twTBbw3BGTODC8AdrRgThc0lf+xeK2bSDEZyx5kQENv1EAu4eT2dB
 zCk2hE0iQ7ONvb/5L+eu4T+Gw/SGqf7l+yGDbU33EKiP0MfHz5GmxURNCar1PuENWD
 Zv+ZvWfmhMKkw6gToSjkspWI8qG0NFjGPK9lbrMbeIcEuUW1bZQbzb8BvkgBO/3cKj
 ANY8VB8Yvq2XnSirwPk8KGZuoqhTbX4xVmWF8erukVreOglVDJmzCBXpLSrPMBmXcM
 T4orcsG796kzA==
Received: from p-i-exch-sc-m01.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru
 [172.16.192.107])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mx1.sberdevices.ru (Postfix) with ESMTPS;
 Wed,  6 Dec 2023 02:23:57 +0300 (MSK)
Received: from localhost.localdomain (100.64.160.123) by
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 6 Dec 2023 02:23:57 +0300
From: Igor Prusov <ivprusov@salutedevices.com>
To: <u-boot@lists.denx.de>
CC: <kernel@salutedevices.com>, <prusovigor@gmail.com>, Igor Prusov
 <ivprusov@salutedevices.com>, Lukasz Majewski <lukma@denx.de>, Sean Anderson
 <seanga2@gmail.com>
Subject: [PATCH 1/2] clk: Check that composite clock's div has set_rate()
Date: Wed, 6 Dec 2023 02:23:33 +0300
Message-ID: <20231205232334.2931-2-ivprusov@salutedevices.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231205232334.2931-1-ivprusov@salutedevices.com>
References: <20231205232334.2931-1-ivprusov@salutedevices.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [100.64.160.123]
X-ClientProxiedBy: p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) To
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 181880 [Dec 06 2023]
X-KSMG-AntiSpam-Version: 6.0.0.2
X-KSMG-AntiSpam-Envelope-From: ivprusov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 5 0.3.5
 98d108ddd984cca1d7e65e595eac546a62b0144b,
 {Tracking_from_domain_doesnt_match_to},
 p-i-exch-sc-m01.sberdevices.ru:7.1.1,5.0.1; 100.64.160.123:7.1.2;
 d41d8cd98f00b204e9800998ecf8427e.com:7.1.1; 127.0.0.199:7.1.2;
 salutedevices.com:7.1.1, FromAlignment: s, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960,
 bases: 2023/12/05 19:23:00 #22612647
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

It's possible for composite clocks to have a divider that does not
implement set_rate() operation. For example, sandbox_clk_composite()
registers composite clock with a divider that only has get_rate().
Currently clk_composite_set_rate() only checks thate rate_ops are
present, so for sandbox it will cause NULL dereference during
clk_set_rate().

This patch adds rate_ops->set_rate check tp clk_composite_set_rate().

Signed-off-by: Igor Prusov <ivprusov@salutedevices.com>
---

 drivers/clk/clk-composite.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/clk-composite.c b/drivers/clk/clk-composite.c
index 6eb2b8133a..d2e5a1ae40 100644
--- a/drivers/clk/clk-composite.c
+++ b/drivers/clk/clk-composite.c
@@ -66,7 +66,7 @@ static ulong clk_composite_set_rate(struct clk *clk, unsigned long rate)
 	const struct clk_ops *rate_ops = composite->rate_ops;
 	struct clk *clk_rate = composite->rate;
 
-	if (rate && rate_ops)
+	if (rate && rate_ops && rate_ops->set_rate)
 		return rate_ops->set_rate(clk_rate, rate);
 	else
 		return clk_get_rate(clk);
-- 
2.34.1

