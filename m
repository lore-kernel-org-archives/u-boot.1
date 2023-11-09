Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38342C4332F
	for <u-boot@archiver.kernel.org>; Thu,  9 Nov 2023 10:57:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4995C87489;
	Thu,  9 Nov 2023 11:55:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=sberdevices.ru
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=sberdevices.ru header.i=@sberdevices.ru header.b="Q8c7i4re";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7F84487211; Thu,  9 Nov 2023 11:55:41 +0100 (CET)
Received: from mx1.sberdevices.ru (mx2.sberdevices.ru [45.89.224.132])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8CCD087483
 for <u-boot@lists.denx.de>; Thu,  9 Nov 2023 11:55:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=sberdevices.ru
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ivprusov@salutedevices.com
Received: from p-infra-ksmg-sc-msk02 (localhost [127.0.0.1])
 by mx1.sberdevices.ru (Postfix) with ESMTP id 226E612003E;
 Thu,  9 Nov 2023 13:55:39 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 226E612003E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
 s=mail; t=1699527339;
 bh=pJ1HDr4UOKtiLvrnO17XjY4Kd9Yvxi0SkSRyuOcYCpw=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
 b=Q8c7i4reLFonXl36eOVTQBx6Peq9bL6qJTvM75NYstHKinsp0utO6hwAUZEYYFbsi
 uAqDeCULtki9ODzMlwlCNpQD7+dbUzv0+tp1SnhEk4vbFoCJ30gF/fJD3IKWWpflf8
 1Hz+vaLcJ2C8BSlHMXWZL/QObFeUTA0kAhT0zqaToEMG+k35THZHYwCy+sugcgDFPw
 O0jCWhY/nU9be/nOr6I7sRIXiYIYZaHaHfABdhMHuRlJT7XT0HiRcKa+9gKVX/dypA
 qEU5gxjK4aTwJ7jsaKFRRR1hXUMCOyy/7MmoeoKUYiVNqNbya7960xYMEYXh7cwG68
 WhrIV6nyg8JSg==
Received: from p-i-exch-sc-m01.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru
 [172.16.192.107])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mx1.sberdevices.ru (Postfix) with ESMTPS;
 Thu,  9 Nov 2023 13:55:38 +0300 (MSK)
Received: from localhost.localdomain (100.64.160.123) by
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.37; Thu, 9 Nov 2023 13:55:38 +0300
From: Igor Prusov <ivprusov@sberdevices.ru>
To: <u-boot@lists.denx.de>, Michal Simek <michal.simek@amd.com>, Daniel
 Schwierzeck <daniel.schwierzeck@gmail.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, Ryan Chen <ryan_chen@aspeedtech.com>,
 Chia-Wei Wang <chiawei_wang@aspeedtech.com>, Neil Armstrong
 <neil.armstrong@linaro.org>, Stefan Roese <sr@denx.de>, Patrick Delaunay
 <patrick.delaunay@foss.st.com>, Patrice Chotard <patrice.chotard@foss.st.com>
CC: <prusovigor@gmail.com>, <kernel@sberdevices.ru>, Igor Prusov
 <ivprusov@sberdevices.ru>, Aspeed BMC SW team <BMC-SW@aspeedtech.com>, Joel
 Stanley <joel@jms.id.au>, <u-boot-amlogic@groups.io>,
 <uboot-stm32@st-md-mailman.stormreply.com>
Subject: [PATCH v7 8/8] cmd: clk: Make soc_clk_dump static
Date: Thu, 9 Nov 2023 13:55:16 +0300
Message-ID: <20231109105516.24892-9-ivprusov@sberdevices.ru>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231109105516.24892-1-ivprusov@sberdevices.ru>
References: <20231109105516.24892-1-ivprusov@sberdevices.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [100.64.160.123]
X-ClientProxiedBy: p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) To
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 181238 [Nov 09 2023]
X-KSMG-AntiSpam-Version: 6.0.0.2
X-KSMG-AntiSpam-Envelope-From: ivprusov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 543 543
 1e3516af5cdd92079dfeb0e292c8747a62cb1ee4, {Tracking_smtp_not_equal_from},
 {Tracking_from_domain_doesnt_match_to}, salutedevices.com:7.1.1;
 sberdevices.ru:5.0.1,7.1.1; 100.64.160.123:7.1.2;
 d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;
 p-i-exch-sc-m01.sberdevices.ru:5.0.1,7.1.1;
 127.0.0.199:7.1.2, FromAlignment: n, {Tracking_smtp_domain_mismatch},
 {Tracking_smtp_domain_2level_mismatch}, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960,
 bases: 2023/11/09 07:10:00 #22435383
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

After introducing dump to clk_ops there is no need to override or expose
this symbol anymore.

Reviewed-by: Patrice Chotard <patrice.chotard@foss.st.com>
Tested-by: Patrice Chotard <patrice.chotard@foss.st.com>
Reviewed-by: Sean Anderson <seanga2@gmail.com>
Signed-off-by: Igor Prusov <ivprusov@sberdevices.ru>
---
 cmd/clk.c     | 4 ++--
 include/clk.h | 2 --
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/cmd/clk.c b/cmd/clk.c
index 4b9709d3ff..7bbcbfeda3 100644
--- a/cmd/clk.c
+++ b/cmd/clk.c
@@ -59,7 +59,7 @@ static void show_clks(struct udevice *dev, int depth, int last_flag)
 	}
 }
 
-int __weak soc_clk_dump(void)
+static int soc_clk_dump(void)
 {
 	struct udevice *dev;
 	const struct clk_ops *ops;
@@ -81,7 +81,7 @@ int __weak soc_clk_dump(void)
 	return 0;
 }
 #else
-int __weak soc_clk_dump(void)
+static int soc_clk_dump(void)
 {
 	puts("Not implemented\n");
 	return 1;
diff --git a/include/clk.h b/include/clk.h
index 249c0e0ab4..3d6394477b 100644
--- a/include/clk.h
+++ b/include/clk.h
@@ -676,8 +676,6 @@ static inline bool clk_valid(struct clk *clk)
 	return clk && !!clk->dev;
 }
 
-int soc_clk_dump(void);
-
 #endif
 
 #define clk_prepare_enable(clk) clk_enable(clk)
-- 
2.34.1

