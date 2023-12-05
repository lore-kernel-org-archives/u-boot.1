Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1D16C4167B
	for <u-boot@archiver.kernel.org>; Tue,  5 Dec 2023 23:24:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B65B1870EA;
	Wed,  6 Dec 2023 00:24:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=salutedevices.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=salutedevices.com header.i=@salutedevices.com header.b="P5VImus5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B038D86F64; Wed,  6 Dec 2023 00:24:04 +0100 (CET)
Received: from mx1.sberdevices.ru (mx2.sberdevices.ru [45.89.224.132])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DD63F870EA
 for <u-boot@lists.denx.de>; Wed,  6 Dec 2023 00:23:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=salutedevices.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ivprusov@salutedevices.com
Received: from p-infra-ksmg-sc-msk02 (localhost [127.0.0.1])
 by mx1.sberdevices.ru (Postfix) with ESMTP id 6078B12005B;
 Wed,  6 Dec 2023 02:23:59 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 6078B12005B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
 s=mail; t=1701818639;
 bh=nd4FkQgypQTqOCD4+zgeFtXUSEum8soJP4JgIyFBnNc=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
 b=P5VImus57bx020bjF2/wGI9/9Xob/Sld0QeKRPBXdzTawo0YwxzRI0OhJfu26uPv9
 WojuvWZRdIuZD81CN8mwCeR2Wku3l158xeIDfufraCR+6a/TVcQTX42b2bMjUmOldG
 IvUmMFgp5b2nAbnXC4deJLYsb7gjYviuykwG7KaFREdXcij2WfcmEgH3aJn6IBigEE
 HG+ksbgkzfsmCHMo9EPsqC6nbiDid13vvdFAolJPqzS2BTX65P8WHn7uokrBHu+USw
 /pNunGDzG8Mndz3iEuGI5tAHh52grEEauONyr5Rj5iYAsQlBU/rtxRtr00gCSxdaOW
 4Mh0TPhDYW3ug==
Received: from p-i-exch-sc-m01.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru
 [172.16.192.107])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mx1.sberdevices.ru (Postfix) with ESMTPS;
 Wed,  6 Dec 2023 02:23:59 +0300 (MSK)
Received: from localhost.localdomain (100.64.160.123) by
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 6 Dec 2023 02:23:59 +0300
From: Igor Prusov <ivprusov@salutedevices.com>
To: <u-boot@lists.denx.de>
CC: <kernel@salutedevices.com>, <prusovigor@gmail.com>, Igor Prusov
 <ivprusov@salutedevices.com>, Simon Glass <sjg@chromium.org>
Subject: [PATCH 2/2] dm: test: clk: Add test for ccf clk_set_rate()
Date: Wed, 6 Dec 2023 02:23:34 +0300
Message-ID: <20231205232334.2931-3-ivprusov@salutedevices.com>
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
 p-i-exch-sc-m01.sberdevices.ru:7.1.1,5.0.1;
 d41d8cd98f00b204e9800998ecf8427e.com:7.1.1; 127.0.0.199:7.1.2;
 100.64.160.123:7.1.2;
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

Add a simple test case which sets clock rate to its current value.

Signed-off-by: Igor Prusov <ivprusov@salutedevices.com>
---

 test/dm/clk_ccf.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/test/dm/clk_ccf.c b/test/dm/clk_ccf.c
index e4ebb93cda..3b23982541 100644
--- a/test/dm/clk_ccf.c
+++ b/test/dm/clk_ccf.c
@@ -63,6 +63,9 @@ static int dm_test_clk_ccf(struct unit_test_state *uts)
 	rate = clk_get_parent_rate(clk);
 	ut_asserteq(rate, 60000000);
 
+	rate = clk_set_rate(clk, 60000000);
+	ut_asserteq(rate, -ENOSYS);
+
 	rate = clk_get_rate(clk);
 	ut_asserteq(rate, 60000000);
 
@@ -87,6 +90,9 @@ static int dm_test_clk_ccf(struct unit_test_state *uts)
 	ut_asserteq_str("pll3_80m", pclk->dev->name);
 	ut_asserteq(CLK_SET_RATE_PARENT, pclk->flags);
 
+	rate = clk_set_rate(clk, 80000000);
+	ut_asserteq(rate, -ENOSYS);
+
 	rate = clk_get_rate(clk);
 	ut_asserteq(rate, 80000000);
 
@@ -108,6 +114,9 @@ static int dm_test_clk_ccf(struct unit_test_state *uts)
 	rate = clk_get_rate(clk);
 	ut_asserteq(rate, 60000000);
 
+	rate = clk_set_rate(clk, 60000000);
+	ut_asserteq(rate, 60000000);
+
 #if CONFIG_IS_ENABLED(CLK_CCF)
 	/* Test clk tree enable/disable */
 	ret = clk_get_by_id(SANDBOX_CLK_I2C_ROOT, &clk);
-- 
2.34.1

