Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A95BDC46CD2
	for <u-boot@archiver.kernel.org>; Tue,  9 Jan 2024 17:43:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7E66287AC2;
	Tue,  9 Jan 2024 18:40:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=salutedevices.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=salutedevices.com header.i=@salutedevices.com header.b="G7XpYQCM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5615F8785D; Tue,  9 Jan 2024 18:32:59 +0100 (CET)
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [37.18.73.165])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6D3B98786E
 for <u-boot@lists.denx.de>; Tue,  9 Jan 2024 18:32:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=salutedevices.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=avromanov@salutedevices.com
Received: from p-infra-ksmg-sc-msk01 (localhost [127.0.0.1])
 by mx1.sberdevices.ru (Postfix) with ESMTP id DBC76100014;
 Tue,  9 Jan 2024 20:32:54 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru DBC76100014
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
 s=mail; t=1704821574;
 bh=0z/Ri1a1sALnmEXK9ZXLjOwHFvmjLs8Qfera1gcVU00=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
 b=G7XpYQCM8OYsyq2kCi8Rg1ajSTqzOriUa/5En/MoTnGXA3JZgK6I1JjayQ+ilvtrE
 R4hXkSM7fpD4ctpSq0uj4TargGwOhRIrW4SIErvnXXXy1zuFyjkZloZusNBob3qalo
 JQseYRKNNfDJ9t0VY3o7tYPkk98NyoGePSKwCGi8hs4X16ju9FSXZYLZ/HfSCmmfyx
 cpH/VVYeqANUfOKTTM+ApRIpoPIhfzFz0LNfkTkVKe+bdDp9uc7dNfSDhXYbNU0XNs
 g8cW0v/EvvkC/YcI19ZLhFAD+Mr7U5JaXoM1fht7FN+svdi9Xh4/2PygxA9YRhPkEm
 KGF/5P09nHlPQ==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru
 [172.16.192.107])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mx1.sberdevices.ru (Postfix) with ESMTPS;
 Tue,  9 Jan 2024 20:32:54 +0300 (MSK)
Received: from localhost.localdomain (100.64.160.123) by
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 9 Jan 2024 20:32:54 +0300
From: Alexey Romanov <avromanov@salutedevices.com>
To: <michal.simek@amd.com>, <marex@denx.de>, <michael@walle.cc>,
 <stcarlso@linux.microsoft.com>, <tobias@waldekranz.com>,
 <seanedmond@microsoft.com>, <abdellatif.elkhlifi@arm.com>,
 <neil.armstrong@linaro.org>, <n-jain1@ti.com>, <xypron.glpk@gmx.de>,
 <dario.binacchi@amarulasolutions.com>, <michael@amarulasolutions.com>,
 <frieder.schrempf@kontron.de>, <sjg@chromium.org>, <hs@denx.de>,
 <sean.anderson@seco.com>, <dimorinny@google.com>,
 <mkorpershoek@baylibre.com>, <patrick.delaunay@foss.st.com>
CC: <u-boot@lists.denx.de>, <kernel@salutedevices.com>, Alexey Romanov
 <avromanov@salutedevices.com>
Subject: [PATCH v2 13/14] fastboot: enable FASTBOOT_FLASH option for SPI NAND
 devices
Date: Tue, 9 Jan 2024 20:32:25 +0300
Message-ID: <20240109173231.78920-14-avromanov@salutedevices.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240109173231.78920-1-avromanov@salutedevices.com>
References: <20240109173231.78920-1-avromanov@salutedevices.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [100.64.160.123]
X-ClientProxiedBy: p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) To
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 182518 [Jan 09 2024]
X-KSMG-AntiSpam-Version: 6.1.0.3
X-KSMG-AntiSpam-Envelope-From: avromanov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 7 0.3.7
 6d6bf5bd8eea7373134f756a2fd73e9456bb7d1a,
 {Tracking_from_domain_doesnt_match_to}, smtp.sberdevices.ru:5.0.1,7.1.1;
 salutedevices.com:7.1.1; 100.64.160.123:7.1.2; 127.0.0.199:7.1.2;
 d41d8cd98f00b204e9800998ecf8427e.com:7.1.1, FromAlignment: s,
 ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960,
 bases: 2024/01/09 15:14:00 #23039571
X-KSMG-AntiVirus-Status: Clean, skipped
X-Mailman-Approved-At: Tue, 09 Jan 2024 18:40:45 +0100
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

From now we can use FASTBOOT_FLASH_NAND option for SPI NAND.

Signed-off-by: Alexey Romanov <avromanov@salutedevices.com>
Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
---
 drivers/fastboot/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/fastboot/Kconfig b/drivers/fastboot/Kconfig
index 11fc0fe1c8..733dedb30d 100644
--- a/drivers/fastboot/Kconfig
+++ b/drivers/fastboot/Kconfig
@@ -87,7 +87,7 @@ config FASTBOOT_USB_DEV
 config FASTBOOT_FLASH
 	bool "Enable FASTBOOT FLASH command"
 	default y if ARCH_SUNXI || ARCH_ROCKCHIP
-	depends on MMC || (MTD_RAW_NAND && CMD_MTDPARTS)
+	depends on MMC || ((MTD_RAW_NAND || MTD_SPI_NAND) && CMD_MTDPARTS)
 	select IMAGE_SPARSE
 	help
 	  The fastboot protocol includes a "flash" command for writing
@@ -113,7 +113,7 @@ config FASTBOOT_FLASH_MMC
 
 config FASTBOOT_FLASH_NAND
 	bool "FASTBOOT on NAND"
-	depends on MTD_RAW_NAND && CMD_MTDPARTS
+	depends on (MTD_RAW_NAND || MTD_SPI_NAND) && CMD_MTDPARTS
 
 endchoice
 
-- 
2.30.1

