Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8CF6C3DA7F
	for <u-boot@archiver.kernel.org>; Fri,  2 Aug 2024 22:13:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 91C5388C61;
	Sat,  3 Aug 2024 00:13:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="QHXGxk2s";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1666488C61; Sat,  3 Aug 2024 00:13:10 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7A45287EED
 for <u-boot@lists.denx.de>; Sat,  3 Aug 2024 00:13:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=5651=PC=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1722636781; bh=UiK2iDAvxy95c12/MSVpP4GaOQCxtiCMzqBbGtVGmx0=;
 b=QHXGxk2sSA9YR0JNb5gXgz3mKU4Uzrsg94jWM0+VRxe5JdHBlAV4AnYlo/pEZO0vhz6ofyTJ9
 AXYBcJk/FZGgOdGTU96AdKo86h8J4tSRgvfPR76mFiUuyb2z1/NiWpUPMWHF9TijaBApjfyvhTX
 XxhHZk8BRhDLv0qFOrrmo6stX/3VMk39pc7EHgwE2vUtePZJ4Ql9qvqGF0JYOLpI01ohicloh84
 jAIX3hXR6wj3b1eedRgRUa6CkecF5pwDhUxjlKA6ntGh/LEUQ13ScX71AYF8AA2GVfD2OwsLEXp
 KRUJ8DsWNX1atY0os1XJzpec7/qAPMmrupbNDfYXApSw==
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: FUKAUMI Naoki <naoki@radxa.com>, u-boot@lists.denx.de, Jonas Karlman
 <jonas@kwiboo.se>
Subject: [PATCH v2 4/5] dm: adc: Add SPL_ADC Kconfig symbol for use of ADC in
 SPL
Date: Fri,  2 Aug 2024 22:12:22 +0000
Message-ID: <20240802221231.2629416-5-jonas@kwiboo.se>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240802221231.2629416-1-jonas@kwiboo.se>
References: <20240802221231.2629416-1-jonas@kwiboo.se>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 66ad59e9b3fb002aec6e7214
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

What model of Radxa ZERO 3W/3E board can be identified using ADC at
runtime, add a Kconfig symbol to allow use of ADC in SPL.

This will be used to identify board model in SPL to allow loading
correct FIT configuration and FDT for U-Boot proper at SPL phase.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
v2:
- Drop depends on ADC and instead use $(SPL_TPL_) for adc-uclass.o
- Add depends on DM/SPL_DM to ADC/SPL_ADC
---
 drivers/Makefile     | 2 +-
 drivers/adc/Kconfig  | 5 +++++
 drivers/adc/Makefile | 2 +-
 3 files changed, 7 insertions(+), 2 deletions(-)

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
index c9cdbe6942de..37235f557a3c 100644
--- a/drivers/adc/Kconfig
+++ b/drivers/adc/Kconfig
@@ -1,5 +1,6 @@
 config ADC
 	bool "Enable ADC drivers using Driver Model"
+	depends on DM
 	help
 	  This enables ADC API for drivers, which allows driving ADC features
 	  by single and multi-channel methods for:
@@ -11,6 +12,10 @@ config ADC
 	  - support supply's phandle with auto-enable
 	  - supply polarity setting in fdt
 
+config SPL_ADC
+	bool "Enable ADC drivers using Driver Model in SPL"
+	depends on SPL_DM
+
 config ADC_EXYNOS
 	bool "Enable Exynos 54xx ADC driver"
 	depends on ADC
diff --git a/drivers/adc/Makefile b/drivers/adc/Makefile
index 5336c820973a..dca0b39c2e27 100644
--- a/drivers/adc/Makefile
+++ b/drivers/adc/Makefile
@@ -4,7 +4,7 @@
 # Przemyslaw Marczak <p.marczak@samsung.com>
 #
 
-obj-$(CONFIG_ADC) += adc-uclass.o
+obj-$(CONFIG_$(SPL_TPL_)ADC) += adc-uclass.o
 obj-$(CONFIG_ADC_EXYNOS) += exynos-adc.o
 obj-$(CONFIG_ADC_SANDBOX) += sandbox.o
 obj-$(CONFIG_SARADC_ROCKCHIP) += rockchip-saradc.o
-- 
2.45.2

