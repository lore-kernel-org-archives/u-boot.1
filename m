Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAB1BEE49B2
	for <u-boot@archiver.kernel.org>; Wed, 23 Aug 2023 12:00:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EA29F833DE;
	Wed, 23 Aug 2023 14:00:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foundries.io
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foundries.io header.i=@foundries.io header.b="E92h7WJz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 15C5D80812; Wed, 23 Aug 2023 14:00:29 +0200 (CEST)
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com
 [IPv6:2a00:1450:4864:20::133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6ED11846DF
 for <u-boot@lists.denx.de>; Wed, 23 Aug 2023 14:00:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foundries.io
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=oleksandr.suvorov@foundries.io
Received: by mail-lf1-x133.google.com with SMTP id
 2adb3069b0e04-4ffa01fc987so6757155e87.1
 for <u-boot@lists.denx.de>; Wed, 23 Aug 2023 05:00:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=foundries.io; s=google; t=1692792025; x=1693396825;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=P+b4/09sc9FNiK90QnaP2FexWSKddzBnrCjkwo1kGjU=;
 b=E92h7WJzkRYCpqpGRZAM5+AhQi4UoiamAZcNcqZ+Pdr28eRnwna46oHfibhd2KFAoi
 HRK4SqbCspyF7iEN/WRmfIe++/ni4sx/XDjUw1dNvMOQ8NJXWlDvlXXpGgQgdQjdW0O9
 /zF0jVWbOoD7Kc1AhfwXhieJnhOLU7sOrv4W76ZiKk7JW/hdPYWdrwVQbCIxnALoslS6
 b8nL3Qo94l6StoJ/IP7Lf/fi8SqX0IVSMWjIudpagjmTPDTxiRZr+jh2APO/wjPiyAbw
 qbe9Z4w7t9uOWmfLwthfE5mwaI5koE+mR5odszOe8LhA5KxNEQGWSAz+qucNTOXxccKx
 c45w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692792025; x=1693396825;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=P+b4/09sc9FNiK90QnaP2FexWSKddzBnrCjkwo1kGjU=;
 b=lDUXyGP6Um2GVZ31tGnIU69K5r1tU8ZdrRjt4sEHlQQ4hwgJBlDTmnvzsXx5FpWQ5U
 nTRRh6Eg1JOu/ZaN3I22T2nWtJZKlCNU0cxGJPC+5LNmCVUaPMy+JqiX/Hewt0tpTn3h
 AvvhQfK5BWMvM1OCKbTbLzA4W3OX4RLHb3/QCcMjSYsZpNMG26w9G7ZwYG+gAM2FmB1Q
 rECxMwDVnHbnRSeNhQepWJwnCa4EA8z1+V8FkLXgW3f2AfgAXSqm5gE/LsIlGF4MPgDR
 vkU9l6Tw17jQoLJuy3UyOjgPamwONqYtnA7BMhkjsHbvV5cjLaBrPZZlrmCE6v9DmX98
 2c9Q==
X-Gm-Message-State: AOJu0YxN8xEKdzMMdFkrYucZXwrpbEaV8xyrmy/R6OxSF6cTNUjPPXHf
 nu7qGpBQhqq5ptdXNKuAbS3uYAgOp1UOx1q93JFRdA==
X-Google-Smtp-Source: AGHT+IGW0VG9FmULx2SDDsTuGDNUmnQsSCzt8OwBp0c7ms38G27ZSA+6Av1pU1TAxJrTvRRpTvEi8Q==
X-Received: by 2002:a05:6512:282c:b0:4fb:8ff3:1f74 with SMTP id
 cf44-20020a056512282c00b004fb8ff31f74mr5075069lfb.20.1692792025242; 
 Wed, 23 Aug 2023 05:00:25 -0700 (PDT)
Received: from cryobook.. ([93.188.34.55]) by smtp.gmail.com with ESMTPSA id
 f16-20020ac251b0000000b004ff71ecaebcsm2623665lfk.268.2023.08.23.05.00.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Aug 2023 05:00:24 -0700 (PDT)
From: Oleksandr Suvorov <oleksandr.suvorov@foundries.io>
To: u-boot@lists.denx.de
Cc: Oleksandr Suvorov <oleksandr.suvorov@foundries.io>,
 Igor Opaniuk <igor.opaniuk@foundries.io>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Andre Przywara <andre.przywara@arm.com>,
 Balamanikandan Gunasundar <balamanikandan.gunasundar@microchip.com>,
 Bin Meng <bmeng.cn@gmail.com>,
 Claudiu Beznea <claudiu.beznea@microchip.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Leo Yu-Chi Liang <ycliang@andestech.com>, Marek Vasut <marex@denx.de>,
 Mayuresh Chitale <mchitale@ventanamicro.com>,
 Michal Simek <michal.simek@amd.com>, Nikhil M Jain <n-jain1@ti.com>,
 Paul Barker <paul.barker@sancloud.com>, Roger Quadros <rogerq@kernel.org>,
 Simon Glass <sjg@chromium.org>, Stefan Roese <sr@denx.de>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Svyatoslav Ryhel <clamor95@gmail.com>
Subject: [PATCH v2] spl: watchdog: introduce SPL_HW_WATCHDOG
Date: Wed, 23 Aug 2023 15:00:14 +0300
Message-ID: <20230823120021.50146-1-oleksandr.suvorov@foundries.io>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Add SPL_HW_WATCHDOG Kconfig symbol which can be used to enable
non-WDT hardware watchdog in SPL.

Co-developed-by: Igor Opaniuk <igor.opaniuk@foundries.io>
Signed-off-by: Igor Opaniuk <igor.opaniuk@foundries.io>
Signed-off-by: Oleksandr Suvorov <oleksandr.suvorov@foundries.io>
---

Changes in v2:
- remove mistakenly included unwanted changes

 common/spl/Kconfig        | 1 -
 drivers/Makefile          | 1 +
 drivers/sysreset/Kconfig  | 6 ++++++
 drivers/sysreset/Makefile | 2 +-
 drivers/watchdog/Kconfig  | 4 ++++
 5 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/common/spl/Kconfig b/common/spl/Kconfig
index c5dd476db58..07d9dac29bd 100644
--- a/common/spl/Kconfig
+++ b/common/spl/Kconfig
@@ -1351,7 +1351,6 @@ config SPL_THERMAL
 
 config SPL_WATCHDOG
 	bool "Support watchdog drivers"
-	imply SPL_WDT if !HW_WATCHDOG
 	help
 	  Enable support for watchdog drivers in SPL. A watchdog is
 	  typically a hardware peripheral which can reset the system when it
diff --git a/drivers/Makefile b/drivers/Makefile
index efc2a4afb24..2eb8ec0a894 100644
--- a/drivers/Makefile
+++ b/drivers/Makefile
@@ -62,6 +62,7 @@ obj-$(CONFIG_SPL_USB_GADGET) += usb/gadget/
 obj-$(CONFIG_SPL_USB_GADGET) += usb/common/
 obj-$(CONFIG_SPL_USB_GADGET) += usb/gadget/udc/
 obj-$(CONFIG_SPL_WATCHDOG) += watchdog/
+obj-$(CONFIG_SPL_HW_WATCHDOG) += watchdog/
 obj-$(CONFIG_SPL_USB_HOST) += usb/host/
 obj-$(CONFIG_SPL_SATA) += ata/ scsi/
 obj-$(CONFIG_SPL_LEGACY_BLOCK) += block/
diff --git a/drivers/sysreset/Kconfig b/drivers/sysreset/Kconfig
index bdbe2a95364..0d21673e402 100644
--- a/drivers/sysreset/Kconfig
+++ b/drivers/sysreset/Kconfig
@@ -157,6 +157,12 @@ config SYSRESET_WATCHDOG
 	help
 	  Reboot support for generic watchdog reset.
 
+config SPL_SYSRESET_WATCHDOG
+	bool "Enable support for watchdog reboot driver in SPL mode"
+	select SPL_WDT
+	help
+	  Reboot support for generic watchdog reset in SPL mode.
+
 config SYSRESET_WATCHDOG_AUTO
 	bool "Automatically register first watchdog with sysreset"
 	depends on SYSRESET_WATCHDOG
diff --git a/drivers/sysreset/Makefile b/drivers/sysreset/Makefile
index 40c876764af..e5a7fc07a81 100644
--- a/drivers/sysreset/Makefile
+++ b/drivers/sysreset/Makefile
@@ -18,7 +18,7 @@ obj-$(CONFIG_SYSRESET_SOCFPGA) += sysreset_socfpga.o
 obj-$(CONFIG_SYSRESET_SOCFPGA_SOC64) += sysreset_socfpga_soc64.o
 obj-$(CONFIG_SYSRESET_TI_SCI) += sysreset-ti-sci.o
 obj-$(CONFIG_SYSRESET_SYSCON) += sysreset_syscon.o
-obj-$(CONFIG_SYSRESET_WATCHDOG) += sysreset_watchdog.o
+obj-$(CONFIG_$(SPL_)SYSRESET_WATCHDOG) += sysreset_watchdog.o
 obj-$(CONFIG_SYSRESET_RESETCTL) += sysreset_resetctl.o
 obj-$(CONFIG_$(SPL_TPL_)SYSRESET_AT91) += sysreset_at91.o
 obj-$(CONFIG_$(SPL_TPL_)SYSRESET_X86) += sysreset_x86.o
diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
index 07fc4940e91..d696a04fc18 100644
--- a/drivers/watchdog/Kconfig
+++ b/drivers/watchdog/Kconfig
@@ -39,9 +39,13 @@ config WATCHDOG_TIMEOUT_MSECS
 config HW_WATCHDOG
 	bool
 
+config SPL_HW_WATCHDOG
+	bool
+
 config IMX_WATCHDOG
 	bool "Enable Watchdog Timer support for IMX and LSCH2 of NXP"
 	select HW_WATCHDOG if !WDT
+	select SPL_HW_WATCHDOG if !SPL_WDT
 	help
 	  Select this to enable the IMX and LSCH2 of Layerscape watchdog
 	  driver.
-- 
2.41.0

