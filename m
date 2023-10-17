Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74B9ACDB474
	for <u-boot@archiver.kernel.org>; Tue, 17 Oct 2023 21:32:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A536786F5E;
	Tue, 17 Oct 2023 23:32:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=salutedevices.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=salutedevices.com header.i=@salutedevices.com header.b="o9X8PUZh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7A76886F54; Tue, 17 Oct 2023 23:32:32 +0200 (CEST)
Received: from mx1.sberdevices.ru (mx2.sberdevices.ru [45.89.224.132])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3921C86EE0
 for <u-boot@lists.denx.de>; Tue, 17 Oct 2023 23:32:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=salutedevices.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ivprusov@salutedevices.com
Received: from p-infra-ksmg-sc-msk02 (localhost [127.0.0.1])
 by mx1.sberdevices.ru (Postfix) with ESMTP id 98679120004;
 Wed, 18 Oct 2023 00:32:29 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 98679120004
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
 s=mail; t=1697578349;
 bh=QvvuoObD08tSB10o8Mandr3+sBAY7inI5UEsDsmkRoE=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
 b=o9X8PUZheCn1P1JGcF3a7vvLvMJ4IzNZHRzMXYcg5dxoRhdvTKxttP+5HdGJ82/97
 /PSGqayVX/8sw5+ta4hKlEEXLtFGSjwtzA0OkWbq2gP9J6gQ4TMLQttq3KytwYHGwF
 55pQnZZobSXWnS/V0XgXQu1HFDifLeLE8HNLd3foMFY0pE4ZCW4Ync95rt0j4Exac7
 KzuvXem0dstdJC9+wUroaew2n8MjZN02TcymxO0pC8Mf7ffmriLWhdrSQJ46+1E/bs
 Qw30FDJ1p9haj+L4k5yAMWaqAJD5qtdAvQq5VptAaABqWzFY8B87NB3rjFWsBcojab
 4X8G4mUqO95Xg==
Received: from p-i-exch-sc-m01.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru
 [172.16.192.107])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mx1.sberdevices.ru (Postfix) with ESMTPS;
 Wed, 18 Oct 2023 00:32:29 +0300 (MSK)
Received: from localhost.localdomain (100.64.160.123) by
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.37; Wed, 18 Oct 2023 00:32:29 +0300
From: Igor Prusov <ivprusov@salutedevices.com>
To: Neil Armstrong <neil.armstrong@linaro.org>
CC: <prusovigor@gmail.com>, <kernel@sberdevices.ru>, Igor Prusov
 <ivprusov@salutedevices.com>, <u-boot-amlogic@groups.io>,
 <u-boot@lists.denx.de>
Subject: [PATCH v1 1/2] serial: amlogic: Add UART compatible for A1 board
Date: Wed, 18 Oct 2023 00:32:10 +0300
Message-ID: <20231017213211.121550-2-ivprusov@salutedevices.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231017213211.121550-1-ivprusov@salutedevices.com>
References: <20231017213211.121550-1-ivprusov@salutedevices.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [100.64.160.123]
X-ClientProxiedBy: p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) To
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 180688 [Oct 17 2023]
X-KSMG-AntiSpam-Version: 6.0.0.2
X-KSMG-AntiSpam-Envelope-From: ivprusov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 540 540
 2509a3fe0f7fdc802e7154a32be7c2dd394ab987, {Tracking_uf_ne_domains},
 {Tracking_from_domain_doesnt_match_to}, salutedevices.com:7.1.1;
 d41d8cd98f00b204e9800998ecf8427e.com:7.1.1; 100.64.160.123:7.1.2;
 127.0.0.199:7.1.2; p-i-exch-sc-m01.sberdevices.ru:7.1.1,5.0.1;
 lore.kernel.org:7.1.1, FromAlignment: s, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean, bases: 2023/10/17 20:40:00
X-KSMG-LinksScanning: Clean, bases: 2023/10/17 20:40:00
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960,
 bases: 2023/10/17 19:51:00 #22214563
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

Add additional compatible to allow using serial driver with A1 board.
After compatible change in DTS [1], serial_meson driver should still be
able to work with console device.

[1] https://lore.kernel.org/all/20230705181833.16137-8-ddrokosov@sberdevices.ru/

Signed-off-by: Igor Prusov <ivprusov@salutedevices.com>
---
 drivers/serial/serial_meson.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/serial/serial_meson.c b/drivers/serial/serial_meson.c
index 934de2ab23..be5f380f85 100644
--- a/drivers/serial/serial_meson.c
+++ b/drivers/serial/serial_meson.c
@@ -232,6 +232,7 @@ static const struct dm_serial_ops meson_serial_ops = {
 static const struct udevice_id meson_serial_ids[] = {
 	{ .compatible = "amlogic,meson-uart" },
 	{ .compatible = "amlogic,meson-gx-uart" },
+	{ .compatible = "amlogic,meson-a1-uart" },
 	{ }
 };
 
-- 
2.34.1

