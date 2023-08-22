Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 118B4EE49AA
	for <u-boot@archiver.kernel.org>; Tue, 22 Aug 2023 15:53:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DC9B18647D;
	Tue, 22 Aug 2023 17:53:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foundries.io
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foundries.io header.i=@foundries.io header.b="jTT6Ut6Q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B0BA38646F; Tue, 22 Aug 2023 17:53:28 +0200 (CEST)
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com
 [IPv6:2a00:1450:4864:20::22c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F1CE2864B6
 for <u-boot@lists.denx.de>; Tue, 22 Aug 2023 17:53:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foundries.io
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=oleksandr.suvorov@foundries.io
Received: by mail-lj1-x22c.google.com with SMTP id
 38308e7fff4ca-2b9b904bb04so73584141fa.1
 for <u-boot@lists.denx.de>; Tue, 22 Aug 2023 08:53:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=foundries.io; s=google; t=1692719605; x=1693324405;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ozTSu2WsWuM8FpT9qnwYG/auFrbi3M9s6E78m3rtOGc=;
 b=jTT6Ut6QBCMAEYUu2BKoGiYCFAXgzJ+xUBj0MwKwpSpgt9VCNbmzj2/qM6MfaidMWh
 6zISHPjM1MbpU4PJflZakF/11ONqHcG+2FcKIjg8DkAYABV3Hoe5lKv+J89q6inO+Vhq
 b/NwL5TYDhrQ0DAcJTLtNTdxeFyvCTsZSOIMoey6nrsVcnsNlSlLtW/QiPfmyjLxhcCw
 KujPwrUxpxHqYN01YzTeLVmUelS8zfpsVq0n/ORsVfWjAEN8kXKz3LDRXjIEKKJo7P/i
 zciX4H/pP+61QWbXxab6ffqRqlbhm3DomVRM39MVWMfFemDjgClqifagDGA2UmBc4HBQ
 B6vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692719605; x=1693324405;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ozTSu2WsWuM8FpT9qnwYG/auFrbi3M9s6E78m3rtOGc=;
 b=JWsgF38v8sVtQC9/sVovH99TqqBK27d5+O0exLbQ+Hi7kIAyhJj3D+JyxC0KuYSe66
 0bqTjXUlCASH8QaBJI/XDeoMn+d/mKHP+/pCgC500ZOeNrKZ2UzmfYIUws9wt/ZPNFzR
 b0fa+SxYxzZZbYxv0nUlDz1HWRuxjXbp4FiN4ZCaBIQQR9PDy2wYyFKfr9YP7sFXeyt1
 ysm4F7xBiHar6G/CgnZpQs4sclgle9UtkXgSoTgAopFxWNXro9U3GINfrUjWqc8qVTIU
 AAC2q6QFu0Ly7U1y3KzTPFTMeXtGCZC9G3MnTCsMxxpVnEzXE2wNlNkInpvLUolXWixc
 isRA==
X-Gm-Message-State: AOJu0YxcGStqUV5pEeWaQ6SwGZS0EyL0aOARlu2Cwcis/sjJWmpt4bEZ
 NavYgybTbw0aBBfVmuR/GYBYKD43ZHeSbz654/wCtg==
X-Google-Smtp-Source: AGHT+IGVBsNPjW042PFqXHdmgh8movemO1r5cdOM4p5Ky5zp7WuTDCFpUcRBAlj6wtFPhNrIEK9SfA==
X-Received: by 2002:a05:6512:313b:b0:500:81fa:46f1 with SMTP id
 p27-20020a056512313b00b0050081fa46f1mr3946644lfd.67.1692719604915; 
 Tue, 22 Aug 2023 08:53:24 -0700 (PDT)
Received: from localhost.localdomain ([194.104.22.162])
 by smtp.gmail.com with ESMTPSA id
 b4-20020aa7d484000000b0052a1c0c859asm1062929edr.59.2023.08.22.08.53.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Aug 2023 08:53:24 -0700 (PDT)
From: Oleksandr Suvorov <oleksandr.suvorov@foundries.io>
To: u-boot@lists.denx.de
Cc: Oleksandr Suvorov <oleksandr.suvorov@foundries.io>,
 Igor Opaniuk <igor.opaniuk@foundries.io>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Andre Przywara <andre.przywara@arm.com>, Bin Meng <bmeng.cn@gmail.com>,
 Claudiu Beznea <claudiu.beznea@microchip.com>,
 Fabio Estevam <festevam@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Leo Yu-Chi Liang <ycliang@andestech.com>, Marek Vasut <marex@denx.de>,
 Mayuresh Chitale <mchitale@ventanamicro.com>,
 Michal Simek <michal.simek@amd.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Nikhil M Jain <n-jain1@ti.com>,
 Paul Barker <paul.barker@sancloud.com>, Roger Quadros <rogerq@kernel.org>,
 Simon Glass <sjg@chromium.org>, Stefan Roese <sr@denx.de>,
 Stefano Babic <sbabic@denx.de>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 Svyatoslav Ryhel <clamor95@gmail.com>
Subject: [PATCH] spl: watchdog: introduce SPL_HW_WATCHDOG
Date: Tue, 22 Aug 2023 18:52:58 +0300
Message-ID: <20230822155312.53131-1-oleksandr.suvorov@foundries.io>
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

 arch/arm/dts/imx8mp-u-boot.dtsi | 8 ++++----
 common/spl/Kconfig              | 1 -
 drivers/Makefile                | 1 +
 drivers/sysreset/Kconfig        | 6 ++++++
 drivers/sysreset/Makefile       | 2 +-
 drivers/watchdog/Kconfig        | 4 ++++
 6 files changed, 16 insertions(+), 6 deletions(-)

diff --git a/arch/arm/dts/imx8mp-u-boot.dtsi b/arch/arm/dts/imx8mp-u-boot.dtsi
index 36e7444a627..c8ab3916862 100644
--- a/arch/arm/dts/imx8mp-u-boot.dtsi
+++ b/arch/arm/dts/imx8mp-u-boot.dtsi
@@ -65,25 +65,25 @@
 		};
 
 		ddr-1d-imem-fw {
-			filename = "lpddr4_pmu_train_1d_imem_202006.bin";
+			filename = "lpddr4_pmu_train_1d_imem.bin";
 			type = "blob-ext";
 			align-end = <4>;
 		};
 
 		ddr-1d-dmem-fw {
-			filename = "lpddr4_pmu_train_1d_dmem_202006.bin";
+			filename = "lpddr4_pmu_train_1d_dmem.bin";
 			type = "blob-ext";
 			align-end = <4>;
 		};
 
 		ddr-2d-imem-fw {
-			filename = "lpddr4_pmu_train_2d_imem_202006.bin";
+			filename = "lpddr4_pmu_train_2d_imem.bin";
 			type = "blob-ext";
 			align-end = <4>;
 		};
 
 		ddr-2d-dmem-fw {
-			filename = "lpddr4_pmu_train_2d_dmem_202006.bin";
+			filename = "lpddr4_pmu_train_2d_dmem.bin";
 			type = "blob-ext";
 			align-end = <4>;
 		};
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

