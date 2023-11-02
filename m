Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C87BC4332F
	for <u-boot@archiver.kernel.org>; Thu,  2 Nov 2023 12:57:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9E9028771C;
	Thu,  2 Nov 2023 13:57:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=salutedevices.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=salutedevices.com header.i=@salutedevices.com header.b="KyHhOIjK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A536F8757D; Thu,  2 Nov 2023 10:17:06 +0100 (CET)
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [37.18.73.165])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 59EB2875B8
 for <u-boot@lists.denx.de>; Thu,  2 Nov 2023 10:17:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=salutedevices.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=avromanov@salutedevices.com
Received: from p-infra-ksmg-sc-msk01 (localhost [127.0.0.1])
 by mx1.sberdevices.ru (Postfix) with ESMTP id 4806910002F;
 Thu,  2 Nov 2023 12:17:01 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 4806910002F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
 s=mail; t=1698916621;
 bh=ynEdvJGkKZvyTcN0cl3AMvqagD3hQRTTUYD5kCYSBdc=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
 b=KyHhOIjK9KzRu0EqwvVvNUxOEGdy8J9CYNDXXVJc0juYCEMEFteA4ar3EHee/hTPO
 N7WGYftHCj0FL6acQEAueTZWIm4fXXK3GyA5/GbnwEUQ5Z49HNM7Kku6q3G2kCp49Y
 dOPiJAetqcac07TbqJ4LlWfXHi97+kbst+3T+ZJqBike4Pd4sblc5xImbhGSwll/GT
 p2GmCPGNiHXmOh6vGX70vmwnJnmBtD4t9HNcEMRScV5cH6t7XMPOGZmDrhmW0Amaek
 49sPRsTBnAuBreJMUS1p32AgKyZTcL9dvdCysTIb2298bPn9q222kKxEU6k/xe7NXn
 EXivBrfDjx0gA==
Received: from p-i-exch-sc-m01.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru
 [172.16.192.107])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mx1.sberdevices.ru (Postfix) with ESMTPS;
 Thu,  2 Nov 2023 12:17:01 +0300 (MSK)
Received: from localhost.localdomain (100.64.160.123) by
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.37; Thu, 2 Nov 2023 12:17:00 +0300
From: Alexey Romanov <avromanov@salutedevices.com>
To: <sughosh.ganu@linaro.org>, <xypron.glpk@gmx.de>,
 <ilias.apalodimas@linaro.org>, <trini@konsulko.com>
CC: <u-boot@lists.denx.de>, <kernel@sberdevices.ru>, Alexey Romanov
 <avromanov@salutedevices.com>
Subject: [PATCH v2 0/2] Add dm_rng_read_default() helper
Date: Thu, 2 Nov 2023 12:16:43 +0300
Message-ID: <20231102091648.40520-1-avromanov@salutedevices.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [100.64.160.123]
X-ClientProxiedBy: p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) To
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 181068 [Nov 02 2023]
X-KSMG-AntiSpam-Version: 6.0.0.2
X-KSMG-AntiSpam-Envelope-From: avromanov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 543 543
 1e3516af5cdd92079dfeb0e292c8747a62cb1ee4,
 {Tracking_from_domain_doesnt_match_to}, 100.64.160.123:7.1.2;
 p-i-exch-sc-m01.sberdevices.ru:5.0.1,7.1.1; salutedevices.com:7.1.1;
 d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;
 127.0.0.199:7.1.2, FromAlignment: s, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960,
 bases: 2023/11/02 06:57:00 #22385341
X-KSMG-AntiVirus-Status: Clean, skipped
X-Mailman-Approved-At: Thu, 02 Nov 2023 13:57:39 +0100
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

Hello!

This patchset adds dm_rng_read_default() helper function, 
that selects the first rng device and uses it to obtain
random bytes.

V2:

- Move platform_get_rng_device() to rng-uclass.c. 
- Re-implement it to get first successfully probed device.
- Use it in dm_rng_read_default().

Alexey Romanov (2):
  rng: move platform_get_rng_device() to rng-uclass.c
  rng: add dm_rng_read_default() helper

 drivers/rng/rng-uclass.c | 34 ++++++++++++++++++++++++++++++++++
 include/efi_rng.h        |  2 --
 include/rng.h            | 21 +++++++++++++++++++++
 lib/efi_loader/efi_rng.c | 27 ---------------------------
 4 files changed, 55 insertions(+), 29 deletions(-)

-- 
2.30.1

