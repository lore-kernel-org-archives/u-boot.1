Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EAB0C5321D
	for <u-boot@archiver.kernel.org>; Fri, 23 Aug 2024 20:49:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1A8E188CC9;
	Fri, 23 Aug 2024 22:48:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Jma/JkE8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BBD3688C73; Fri, 23 Aug 2024 22:48:44 +0200 (CEST)
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com
 [IPv6:2607:f8b0:4864:20::12f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6451488C13
 for <u-boot@lists.denx.de>; Fri, 23 Aug 2024 22:48:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12f.google.com with SMTP id
 e9e14a558f8ab-39d26a8f9dbso8240335ab.1
 for <u-boot@lists.denx.de>; Fri, 23 Aug 2024 13:48:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1724446121; x=1725050921; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=787ngcmRvCP5UuNtCXgeAyEI77RCaBcMsJAtZ9GljkU=;
 b=Jma/JkE8XMo3Ga8ev684FncxXlCneqp3PJVB+5EpWmLLVlb7Zpu9y1ulWAYBb2jb9/
 k20BlQid6RUkIZo/Zvs7PMpFpiWT2ydIHec17DvRrtXUGF4f4/ziEbKOHcIuF3SZ+gvC
 9FytGlSQHf6O6Tr21bzpmH36jpp/JY87my/rA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724446121; x=1725050921;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=787ngcmRvCP5UuNtCXgeAyEI77RCaBcMsJAtZ9GljkU=;
 b=P2gN4H6C85BkoK6cImhTohajKvB6SQeX62OCy/icBx6risWrFgmWPzHbqasMn9TQu5
 eTheAct+setYEksODvSSNMsJqKGcXoXMMbt+1L2YWYciYlUgH1EmkYTZm0S+CxUkjC3q
 75BsrxQDJJzHG+RjkZdaSLMEwVNfamUMWz/BADuEprQAFX1fb5cle/oRhuneKVeWna6B
 l4hP9N7Lcd07OsUlqx5XZxJfVZTt28SFQytxzxF1Zv9ez1sMvD+CKA9oLphsv7VA7wEa
 kYr6RGCboA2ZN8ocI5150V6BFgTBmDUDg/xc69jmPlHnSfct/YD/rHLC/ZGeH6M8wBZt
 A3rw==
X-Gm-Message-State: AOJu0YyfHXJjQk3PEQ1qfld2nuJMhgl/YqUDa3zQC3ubs+61UCQwik14
 iaGxI9XLOOz18NSFJGsCODfpuG0Vj0lfS8K0lhYbiwqPRSHemlbTjDaekdVlY8R2H4RLB328MyE
 =
X-Google-Smtp-Source: AGHT+IFiv/msZmLG9O0yiTCIooYkOLhbar5cRAAlfYz5fxFYQ3u0rmKzZ7d45tB9cnU/1OHP4tMUqw==
X-Received: by 2002:a05:6e02:1a81:b0:39e:3952:6dd4 with SMTP id
 e9e14a558f8ab-39e3c9c03c2mr43999085ab.20.1724446120934; 
 Fri, 23 Aug 2024 13:48:40 -0700 (PDT)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-39d73e67addsm15698375ab.4.2024.08.23.13.48.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Aug 2024 13:48:40 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Jagan Teki <jagan@amarulasolutions.com>,
 Andre Przywara <andre.przywara@arm.com>, Simon Glass <sjg@chromium.org>,
 Eddie James <eajames@linux.ibm.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, Stefan Roese <sr@denx.de>
Subject: [PATCH v2 3/8] bootstd: Avoid depending on BLK
Date: Fri, 23 Aug 2024 14:48:19 -0600
Message-Id: <20240823204824.443631-4-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240823204824.443631-1-sjg@chromium.org>
References: <20240823204824.443631-1-sjg@chromium.org>
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

In principle bootstd can work without block devices, even if it does
require driver model to be enabled in that case.

The use of a 'depends on BLK' for BOOTSTD conflicts with the way 'BLK'
is now defined, producing recursive errors through multiple different
paths, one of which is this (with Linksprite_pcDuino3 and
BOOTSTD_DEFAULTS enabled):

  arch/arm/Kconfig:7:error: recursive dependency detected!
  arch/arm/Kconfig:7: symbol ARM64 is selected by ARCH_UNIPHIER_V8_MULTI
  arch/arm/mach-uniphier/Kconfig:17: symbol ARCH_UNIPHIER_V8_MULTI is
     part of choice <choice>
  arch/arm/mach-uniphier/Kconfig:6: choice <choice> contains symbol
     ARCH_UNIPHIER_V8_MULTI
  arch/arm/mach-uniphier/Kconfig:17: symbol ARCH_UNIPHIER_V8_MULTI is
     part of choice SPL
  arch/arm/mach-stm32mp/Kconfig:3: symbol SPL depends on SUPPORT_SPL
  common/spl/Kconfig:1: symbol SUPPORT_SPL is selected by ASPEED_AST2600
  arch/arm/mach-aspeed/Kconfig:26: symbol ASPEED_AST2600 is part of
     choice <choice>
  arch/arm/mach-aspeed/Kconfig:12: choice <choice> contains symbol
     ASPEED_AST2500
  arch/arm/mach-aspeed/Kconfig:17: symbol ASPEED_AST2500 is part of
     choice DM_RESET
  arch/arm/mach-renesas/Kconfig.rcar3:197: symbol DM_RESET is selected
     by CLK_RCAR_GEN3
  drivers/clk/renesas/Kconfig:53: symbol CLK_RCAR_GEN3 depends on
     CLK_RENESAS
  drivers/clk/renesas/Kconfig:1: symbol CLK_RENESAS depends on CLK
  drivers/clk/Kconfig:3: symbol CLK is selected by IMX8M_POWER_DOMAIN
  drivers/power/domain/Kconfig:35: symbol IMX8M_POWER_DOMAIN depends on
     POWER_DOMAIN
  drivers/power/domain/Kconfig:3: symbol POWER_DOMAIN is selected by
     BCM6318_USBH_PHY
  drivers/phy/Kconfig:83: symbol BCM6318_USBH_PHY depends on PHY
  drivers/phy/Kconfig:4: symbol PHY is selected by USB_EHCI_MX7
  drivers/usb/host/Kconfig:211: symbol USB_EHCI_MX7 depends on USB
  drivers/usb/Kconfig:1: symbol USB is selected by BOOTSTD_DEFAULTS
  boot/Kconfig:455: symbol BOOTSTD_DEFAULTS depends on BOOTSTD
  boot/Kconfig:398: symbol BOOTSTD depends on BLK
  drivers/block/Kconfig:1: symbol BLK is selected by PVBLOCK
  drivers/xen/Kconfig:1: symbol PVBLOCK depends on XEN
  Kconfig:176: symbol XEN depends on ARM64

We don't want to revert the change to BLK, which has been in place for
a year now. We don't want to select BLK in BOOTSTD since it should
support booting without block devices. The only realistic option is to
remove BOOTSTD's dependency on BLK.

Disable standard boot on the one board which fails.

Signed-off-by: Simon Glass <sjg@chromium.org>

wip

---

Changes in v2:
- Add new patch to resolve BOOTSTD->BLK recursion with Kconfig

 boot/Kconfig                                   | 2 +-
 configs/gardena-smart-gateway-mt7688_defconfig | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/boot/Kconfig b/boot/Kconfig
index 7ac34574079..291919ea1ef 100644
--- a/boot/Kconfig
+++ b/boot/Kconfig
@@ -398,7 +398,7 @@ config BOOT_DEFAULTS
 menuconfig BOOTSTD
 	bool "Standard boot"
 	default y
-	depends on DM && OF_CONTROL && BLK
+	depends on DM && OF_CONTROL
 	help
 	  U-Boot supports a standard way of locating something to boot,
 	  typically an Operating System such as Linux, provided by a distro such
diff --git a/configs/gardena-smart-gateway-mt7688_defconfig b/configs/gardena-smart-gateway-mt7688_defconfig
index f4642e3fcff..36bf5f11d9a 100644
--- a/configs/gardena-smart-gateway-mt7688_defconfig
+++ b/configs/gardena-smart-gateway-mt7688_defconfig
@@ -30,6 +30,7 @@ CONFIG_HAS_BOARD_SIZE_LIMIT=y
 CONFIG_BOARD_SIZE_LIMIT=655360
 CONFIG_FIT=y
 CONFIG_FIT_SIGNATURE=y
+# CONFIG_BOOTSTD is not set
 CONFIG_LEGACY_IMAGE_FORMAT=y
 CONFIG_AUTOBOOT_KEYED=y
 CONFIG_AUTOBOOT_STOP_STR="x"
-- 
2.34.1

