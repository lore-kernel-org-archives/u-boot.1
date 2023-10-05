Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7AAAE9370C
	for <u-boot@archiver.kernel.org>; Thu,  5 Oct 2023 12:08:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ABD7B86BD5;
	Thu,  5 Oct 2023 14:07:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=salutedevices.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=salutedevices.com header.i=@salutedevices.com header.b="HnKYOatv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 00AC186EAF; Thu,  5 Oct 2023 10:19:49 +0200 (CEST)
Received: from mx1.sberdevices.ru (mx2.sberdevices.ru [45.89.224.132])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 64BF586DA7
 for <u-boot@lists.denx.de>; Thu,  5 Oct 2023 10:19:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=salutedevices.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=avromanov@salutedevices.com
Received: from p-infra-ksmg-sc-msk02 (localhost [127.0.0.1])
 by mx1.sberdevices.ru (Postfix) with ESMTP id F3D7D12000A;
 Thu,  5 Oct 2023 11:19:44 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru F3D7D12000A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
 s=mail; t=1696493984;
 bh=Z9XL3+1PdnER1Fprpyh+GaxkA703vjBwsuCAjl1c4NI=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
 b=HnKYOatvIM5CipLwrDxDlxOcKXpj/TZmmgpI/trzCekmbU5sbZUW7douOpXZD/Zvt
 HBgSVayYpVqsW4+g6aYabtoGQJ96pmILtNaWMkS4pYFjALxkUmdzKkiYZu6EAW3xOO
 1h5Sp9Bu0vkyGXi+GOY3rfKZ9pviBW0LeD9UiE0fEzpGj+3ey1yG8d8YQPp3P/0euT
 CFAPMzPmRffhZPsVySwjqUfaUhytQKM0vPSXhv2uXUqBK0AoGD25P7wYxHz7udiXBt
 xY5ATswo+rM3N2sW10SPBr3SCpistJiEKw00F/OBewnu06VoqDNk3MKqqOck45eon2
 o+hBWWFAMg+Kg==
Received: from p-i-exch-sc-m01.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru
 [172.16.192.107])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mx1.sberdevices.ru (Postfix) with ESMTPS;
 Thu,  5 Oct 2023 11:19:43 +0300 (MSK)
Received: from localhost.localdomain (100.64.160.123) by
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Thu, 5 Oct 2023 11:19:43 +0300
From: Alexey Romanov <avromanov@salutedevices.com>
To: <neil.armstrong@linaro.org>, <narmstrong@baylibre.com>
CC: <u-boot-amlogic@groups.io>, <u-boot@lists.denx.de>,
 <kernel@sberdevices.ru>, Alexey Romanov <avromanov@salutedevices.com>, Igor
 Prusov <ivprusov@salutedevices.com>
Subject: [PATCH v1] drivers: sm: fix build warning
Date: Thu, 5 Oct 2023 11:19:30 +0300
Message-ID: <20231005081936.72178-1-avromanov@salutedevices.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [100.64.160.123]
X-ClientProxiedBy: p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) To
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 180368 [Oct 05 2023]
X-KSMG-AntiSpam-Version: 6.0.0.2
X-KSMG-AntiSpam-Envelope-From: avromanov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 535 535
 da804c0ea8918f802fc60e7a20ba49783d957ba2,
 {Tracking_from_domain_doesnt_match_to},
 p-i-exch-sc-m01.sberdevices.ru:7.1.1,5.0.1; salutedevices.com:7.1.1;
 127.0.0.199:7.1.2; d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;
 100.64.160.123:7.1.2, FromAlignment: s, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960,
 bases: 2023/10/05 04:23:00 #22061551
X-KSMG-AntiVirus-Status: Clean, skipped
X-Mailman-Approved-At: Thu, 05 Oct 2023 14:07:47 +0200
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

This fixes following warning during u-boot build:
WARNING: unmet direct dependencies detected for MESON_SM
  Depends on [n]: SM [=n]
  Selected by [y]:
  - MESON64_COMMON [=y] && ARM [=y] && ARCH_MESON [=y]

Fixes: 9849712e7655 ("drivers: introduce Meson Secure Monitor driver")

Signed-off-by: Alexey Romanov <avromanov@salutedevices.com>
Signed-off-by: Igor Prusov <ivprusov@salutedevices.com>
---
 drivers/sm/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/sm/Kconfig b/drivers/sm/Kconfig
index b4cc3f768e..f0987275d2 100644
--- a/drivers/sm/Kconfig
+++ b/drivers/sm/Kconfig
@@ -3,7 +3,7 @@ config SM
 
 config MESON_SM
 	bool "Amlogic Secure Monitor driver"
-	depends on SM
+	select SM
 	default n
 	help
 	  Say y here to enable the Amlogic secure monitor driver.
-- 
2.25.1

