Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4ED89CAC58E
	for <u-boot@archiver.kernel.org>; Thu, 11 Sep 2025 21:54:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 986A4833EC;
	Thu, 11 Sep 2025 23:54:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="tuUv7KO3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E629883423; Thu, 11 Sep 2025 23:54:19 +0200 (CEST)
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com
 [IPv6:2607:f8b0:4864:20::d2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7295E833E9
 for <u-boot@lists.denx.de>; Thu, 11 Sep 2025 23:54:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-io1-xd2a.google.com with SMTP id
 ca18e2360f4ac-88c3944558bso24950839f.1
 for <u-boot@lists.denx.de>; Thu, 11 Sep 2025 14:54:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1757627656; x=1758232456; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7phJYLz2V/KaRuhyz08nz25Bbbe4RYr4yOVYrBeEu2k=;
 b=tuUv7KO3WWjgtSsTEY5H/VePxD3IQ2iYXAXDtTK6yL6afKzSWUrAr5v6r/l3xiKH1K
 Fj+1mLJEw9gzhFUuZZHAS5jfqpMIELLbHbHpQisLdTi9ZATXMlxUqflgopvrz4TM9qtQ
 s8qo4wPvr716P2/iQsaGtKYiKBKN2kPo80/aA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757627656; x=1758232456;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7phJYLz2V/KaRuhyz08nz25Bbbe4RYr4yOVYrBeEu2k=;
 b=m1MEPjosWbONO4l59uU+6qUIjkEPosA/eWwpxBieD8Nwf/0XT1b1p1eDcUgzFE6RI7
 SlWbtDDsviFb6wuPOqMUL+Bp4LhI6KzELAwCP8Agnxl8/87skF2M/2vL8RaPMpX9/fjc
 b55brohp/JTyfjBTnvhChkCeNb70jOU/Wzyh2RTLvr16F1xmsg/ut3EqAsWHgjHqMr3u
 ULCLW27DfmDo4szigp6f4+k3YwSzmY38gCt9ZO7UwCibRWtBT3RtJ/nFngUI22tulJiL
 IjGB9yChvNZzmDBvN6WjPza+hJCqVQMJtKZuyvG9CGCXe5tFOJZiOsjJ4rmXb0R0qOXv
 l6rQ==
X-Gm-Message-State: AOJu0YxRZcjkxTVWRzJ3TycInsq+Ok6IOGKDCCJ/s63Z1PyUI8F+tOoZ
 2Q2urCaemdWzd01rcXqAkasqLe59LuFtV2pDD1vKA5N7BbmawlZaK83O54VrHBHL9XKGYyUwdYD
 VjCNw2lE=
X-Gm-Gg: ASbGncuMit4C0ZpDXO53tVnsDI9eQ40qyv7cCfBeVoZ6BVlUecb5nSrc1xui4fzq4aU
 jHgjwTjHO4mSxBnK+LP2oqwbU08cvciffkwpyReDBUBJwkn86H2eKJPUr3Szje4ClQnoM24H42p
 PVbTvy5cJmkG4rpTrxSmqDhheTKPPXXNNrKmD5YtsXs/WyTzhwhagI/ePaAC/XRA/j2oSp1+VzX
 RyKTOwhEczjOAeN9WlqbwgeXbpeMJ/U2XRU1p0oYT674jR92Kwgx/jCSFQQazk3J1akMuDzwE6n
 BKzkqHqWfRWFF/ZHfVswavHCNZTsXe2O/1lTkq+2MWkhh8BDx1zfORqwXV/rsVw4uzK00x4Yfok
 Uc29Wt+rrxSxJT7vT3W947+Kuzq/Mcd/ayAk78kre/Z93M4lIBYSu8uFVsopyWI9w+P9cqg==
X-Google-Smtp-Source: AGHT+IGNBymjusPKjLkvby+0uojW1ZsKaCgd2yE8v+wEQ0aR9xIMZZz0X2pH0+dj5Va4uI7VIOrHXQ==
X-Received: by 2002:a05:6602:1510:b0:890:46b6:b258 with SMTP id
 ca18e2360f4ac-89046b6b48cmr87473439f.6.1757627656075; 
 Thu, 11 Sep 2025 14:54:16 -0700 (PDT)
Received: from bill-the-cat.. (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-88f2a7db2f1sm101517639f.0.2025.09.11.14.54.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Sep 2025 14:54:15 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut@mailbox.org>
Subject: [PATCH v2 3/6] usb: gadget: bcm_udc_otg: Remove unused driver
Date: Thu, 11 Sep 2025 15:50:20 -0600
Message-ID: <20250911215404.3955132-4-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250911215404.3955132-1-trini@konsulko.com>
References: <20250911215404.3955132-1-trini@konsulko.com>
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

This driver is unused since the removal of the bcm28155_ap board in
commit 0f6807e77b07 ("arm: Remove bcm28155_ap board"). Remove it.

Fixes: 0f6807e77b07 ("arm: Remove bcm28155_ap board")
Signed-off-by: Tom Rini <trini@konsulko.com>
---
Changes in v2:
- Reword commit message per Marek, and add Fixes tag (as this should
  have been deleted then).
---
 drivers/usb/gadget/Kconfig           |  5 ---
 drivers/usb/gadget/Makefile          |  1 -
 drivers/usb/gadget/bcm_udc_otg.h     | 19 ----------
 drivers/usb/gadget/bcm_udc_otg_phy.c | 54 ----------------------------
 4 files changed, 79 deletions(-)
 delete mode 100644 drivers/usb/gadget/bcm_udc_otg.h
 delete mode 100644 drivers/usb/gadget/bcm_udc_otg_phy.c

diff --git a/drivers/usb/gadget/Kconfig b/drivers/usb/gadget/Kconfig
index 29c2f27fa05f..c59d1d6252c3 100644
--- a/drivers/usb/gadget/Kconfig
+++ b/drivers/usb/gadget/Kconfig
@@ -99,11 +99,6 @@ config USB_GADGET_ATMEL_USBA
 	  USBA is the integrated high-speed USB Device controller on
 	  the AT32AP700x, some AT91SAM9 and AT91CAP9 processors from Atmel.
 
-config USB_GADGET_BCM_UDC_OTG_PHY
-	bool "Broadcom UDC OTG PHY"
-	help
-	  Enable the Broadcom UDC OTG physical device interface.
-
 config USB_GADGET_AT91
 	bool "Atmel AT91 USB Gadget Controller"
 	depends on ARCH_AT91
diff --git a/drivers/usb/gadget/Makefile b/drivers/usb/gadget/Makefile
index db5f8895a33a..7af5f6e6d634 100644
--- a/drivers/usb/gadget/Makefile
+++ b/drivers/usb/gadget/Makefile
@@ -17,7 +17,6 @@ endif
 ifdef CONFIG_USB_GADGET
 obj-$(CONFIG_USB_GADGET_AT91) += at91_udc.o
 obj-$(CONFIG_USB_GADGET_ATMEL_USBA) += atmel_usba_udc.o
-obj-$(CONFIG_USB_GADGET_BCM_UDC_OTG_PHY) += bcm_udc_otg_phy.o
 obj-$(CONFIG_USB_GADGET_DWC2_OTG) += dwc2_udc_otg.o
 obj-$(CONFIG_USB_GADGET_DWC2_OTG_PHY) += dwc2_udc_otg_phy.o
 obj-$(CONFIG_USB_GADGET_MAX3420) += max3420_udc.o
diff --git a/drivers/usb/gadget/bcm_udc_otg.h b/drivers/usb/gadget/bcm_udc_otg.h
deleted file mode 100644
index 48370f37d8a2..000000000000
--- a/drivers/usb/gadget/bcm_udc_otg.h
+++ /dev/null
@@ -1,19 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0+ */
-/*
- * Copyright 2015 Broadcom Corporation.
- */
-
-#ifndef __BCM_UDC_OTG_H
-#define __BCM_UDC_OTG_H
-
-static inline void wfld_set(uintptr_t addr, uint32_t fld_val, uint32_t fld_mask)
-{
-	writel(((readl(addr) & ~(fld_mask)) | (fld_val)), (addr));
-}
-
-static inline void wfld_clear(uintptr_t addr, uint32_t fld_mask)
-{
-	writel((readl(addr) & ~(fld_mask)), (addr));
-}
-
-#endif
diff --git a/drivers/usb/gadget/bcm_udc_otg_phy.c b/drivers/usb/gadget/bcm_udc_otg_phy.c
deleted file mode 100644
index 9875191091cc..000000000000
--- a/drivers/usb/gadget/bcm_udc_otg_phy.c
+++ /dev/null
@@ -1,54 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0+
-/*
- * Copyright 2015 Broadcom Corporation.
- */
-
-#include <config.h>
-#include <asm/io.h>
-#include <asm/arch/sysmap.h>
-#include <asm/kona-common/clk.h>
-#include <linux/delay.h>
-
-#include "dwc2_udc_otg_priv.h"
-#include "bcm_udc_otg.h"
-
-void otg_phy_init(struct dwc2_udc *dev)
-{
-	/* turn on the USB OTG clocks */
-	clk_usb_otg_enable((void *)HSOTG_BASE_ADDR);
-
-	/* set Phy to driving mode */
-	wfld_clear(HSOTG_CTRL_BASE_ADDR + HSOTG_CTRL_PHY_P1CTL_OFFSET,
-		   HSOTG_CTRL_PHY_P1CTL_NON_DRIVING_MASK);
-
-	udelay(100);
-
-	/* clear Soft Disconnect */
-	wfld_clear(HSOTG_BASE_ADDR + HSOTG_DCTL_OFFSET,
-		   HSOTG_DCTL_SFTDISCON_MASK);
-
-	/* invoke Reset (active low) */
-	wfld_clear(HSOTG_CTRL_BASE_ADDR + HSOTG_CTRL_PHY_P1CTL_OFFSET,
-		   HSOTG_CTRL_PHY_P1CTL_SOFT_RESET_MASK);
-
-	/* Reset needs to be asserted for 2ms */
-	udelay(2000);
-
-	/* release Reset */
-	wfld_set(HSOTG_CTRL_BASE_ADDR + HSOTG_CTRL_PHY_P1CTL_OFFSET,
-		 HSOTG_CTRL_PHY_P1CTL_SOFT_RESET_MASK,
-		 HSOTG_CTRL_PHY_P1CTL_SOFT_RESET_MASK);
-}
-
-void otg_phy_off(struct dwc2_udc *dev)
-{
-	/* Soft Disconnect */
-	wfld_set(HSOTG_BASE_ADDR + HSOTG_DCTL_OFFSET,
-		 HSOTG_DCTL_SFTDISCON_MASK,
-		 HSOTG_DCTL_SFTDISCON_MASK);
-
-	/* set Phy to non-driving (reset) mode */
-	wfld_set(HSOTG_CTRL_BASE_ADDR + HSOTG_CTRL_PHY_P1CTL_OFFSET,
-		 HSOTG_CTRL_PHY_P1CTL_NON_DRIVING_MASK,
-		 HSOTG_CTRL_PHY_P1CTL_NON_DRIVING_MASK);
-}
-- 
2.43.0

