Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5A38C3DA64
	for <u-boot@archiver.kernel.org>; Wed, 31 Jul 2024 06:51:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AA5798894E;
	Wed, 31 Jul 2024 08:51:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="COvjz69F";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3EDBF8897A; Wed, 31 Jul 2024 08:51:15 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B39D688955
 for <u-boot@lists.denx.de>; Wed, 31 Jul 2024 08:51:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=18d8=O7=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1722408668; bh=RCnwYQ5zu83mUjt6ksBNZdi7aPXjBeCOnHwh8HBgm1s=;
 b=COvjz69FWUWkVro1s7clis1Xc4JfPGJaj6T1MQMWkYbrS5NYf18XekKRYRydAh9QvUAfPbOtm
 0/C+5x2FTocAuZL4qJUe0CjLOJG4oeIZKHRtWEy8sw9IHKSo49IKJ8JQLLESmRSBeUIlgVCu7g+
 NQk2F0rBix3F+DEvuHD43Xeg0RfJppuDlI2fqWQZpBrS/fEnvrhgx73JSqqshyVI1s0k3u88Hkg
 fK1TWb3EbYTmg2+8YPvfqG4YbgAYyfoMYG+HQYsVFp/DmqaniMZf3jPjdHVJMaHTFputeUuOLPE
 YxYWxJ7/MeHMYFblTv5AFxIqgtY6eOcyag1RRa8jwL+A==
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: FUKAUMI Naoki <naoki@radxa.com>, u-boot@lists.denx.de, Jonas Karlman
 <jonas@kwiboo.se>
Subject: [PATCH 4/5] dm: adc: Add SPL_ADC Kconfig symbol for use of ADC in SPL
Date: Wed, 31 Jul 2024 06:50:39 +0000
Message-ID: <20240731065048.1199792-5-jonas@kwiboo.se>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240731065048.1199792-1-jonas@kwiboo.se>
References: <20240731065048.1199792-1-jonas@kwiboo.se>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 66a9deda73d983cd0923796c
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

What model of Radxa ZERO 3W/3E boards can be identified using ADC at
runtime, add a Kconfig symbol to allow use of ADC in SPL.

This will be used to identify board model in SPL to allow loading
correct FIT configuration and FDT for U-Boot proper at SPL phase.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 drivers/Makefile    | 2 +-
 drivers/adc/Kconfig | 4 ++++
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/Makefile b/drivers/Makefile
index 9195dafd37e0..1acd94f3c17e 100644
--- a/drivers/Makefile
+++ b/drivers/Makefile
@@ -1,5 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0+
 
+obj-$(CONFIG_$(SPL_TPL_)ADC) += adc/
 obj-$(CONFIG_$(SPL_TPL_)BIOSEMU) += bios_emulator/
 obj-$(CONFIG_$(SPL_TPL_)BLK) += block/
 obj-$(CONFIG_$(SPL_TPL_)BOOTCOUNT_LIMIT) += bootcount/
@@ -81,7 +82,6 @@ endif
 
 ifeq ($(CONFIG_SPL_BUILD)$(CONFIG_TPL_BUILD),)
 
-obj-y += adc/
 obj-y += ata/
 obj-$(CONFIG_DM_DEMO) += demo/
 obj-y += block/
diff --git a/drivers/adc/Kconfig b/drivers/adc/Kconfig
index c9cdbe6942de..eb705f9e0fb8 100644
--- a/drivers/adc/Kconfig
+++ b/drivers/adc/Kconfig
@@ -11,6 +11,10 @@ config ADC
 	  - support supply's phandle with auto-enable
 	  - supply polarity setting in fdt
 
+config SPL_ADC
+	bool "Enable ADC drivers using Driver Model in SPL"
+	depends on ADC
+
 config ADC_EXYNOS
 	bool "Enable Exynos 54xx ADC driver"
 	depends on ADC
-- 
2.45.2

