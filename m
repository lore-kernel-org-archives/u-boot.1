Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B16CC87FD3
	for <u-boot@archiver.kernel.org>; Wed,  6 Aug 2025 14:56:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9CE0483A6A;
	Wed,  6 Aug 2025 16:56:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="nUmH1Uob";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 99AEA83A71; Wed,  6 Aug 2025 16:56:13 +0200 (CEST)
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com
 [IPv6:2607:f8b0:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1DD7083A99
 for <u-boot@lists.denx.de>; Wed,  6 Aug 2025 16:56:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x333.google.com with SMTP id
 46e09a7af769-741a1ee9366so1089a34.2
 for <u-boot@lists.denx.de>; Wed, 06 Aug 2025 07:56:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1754492167; x=1755096967; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=53v7QH9N3GBGFhreBNDI8Ywtvo2JWgqCfU8yhkXUXXo=;
 b=nUmH1UobPijBv51zs8bUaY+iADWGwr0x6Kk/0eynU+WjgUSMTS37sULGXzhzO+hRel
 /DgVcTKeSPeK22NXvyiZ20XHomKhKwQrpsByppwIEdvDxCk61ueXfZ73B7dik/5fG9Vf
 WNS4VW0Sxx47fi23QpBCbC/hDwQ35lyXmqrDE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754492167; x=1755096967;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=53v7QH9N3GBGFhreBNDI8Ywtvo2JWgqCfU8yhkXUXXo=;
 b=rt1p3PYzvVaorbU1pq/7myF6VuI9CxM8XHcgUMvnMH0HIkpjR+s1DsDEmNBShJ/Tjz
 BKfVsrWTt9psU9WUwQxDwERSr9TEVXCqcjbvyBzVxvw0T6W2Pv5Xm/QbiLRSYpIrTkWD
 oXHuAfBKvP5DsWV2wpqNr69bYIKOfFz8KwYP2WfjQkvX3+yi+kqfziyZ+rnpysEDBT0a
 rehAir6liH/hTyAJPSPfVR3mSXgANq9wK4jMY2s7tRYDkgZ30qReg/8mHnKcvWFJ8emI
 ZmIP2JJ0dtg0/65jJKnf6A/YK7+VDdEGXKHASjqTeFoGp2dwadP7zEeKk+ENxJEHHAOn
 BPgw==
X-Gm-Message-State: AOJu0YyfFiE5lWstbBqNKPd1g7oooPvTeKH7khTfqKMDmWyvPPdnOTef
 dtfYpL6PMcln+rqTGs2sfPD+BL4H+T5tHKQug20B68XPMlse4CiAqaw2dkCTKk4NyGNi+0eeFYI
 Ow5chv7A=
X-Gm-Gg: ASbGncuLU5QFEFmju7pHYs3rOel34NiN8kYAxaaykoFL/XKQ4wXVkJ5UhRZX19LlExK
 gh9lqPYyEw2xx5UawCcHZNpB79XIMCAT+wOADATReXmHnPaK5TYtUoHFSZl37VXy8+GJgehfxzK
 cFZQ/w8kxOTEsgG/JgIUmfJ1BUXgKxm4CKdUPrCltdPK5N/nJ0iFke1mPu9p6i9q6fsLRLstdhG
 v7pNTARDUOdXQ4JMA46ISD43cERE5VStcFUjf105gawkrR8y59qlHjDGBtJKMtfEr/uNGKALa72
 lQ2dd5WijtsGHPIxxBAYDer7RQEH503C2pdtqTdNoJ0tM9SCHju5jWteQ8dzne/NgpnqdfCcKmK
 X8FRBw8gNjq+lQuId+DlhNsJUZtdDUMAg7jtOIhPB55R3RJguHVq7JHOGu20=
X-Google-Smtp-Source: AGHT+IH6niWA2TbYBKrLwB0FMQdA+gOq2St6+JIPMBm9kaVqm2u80WDOWu0knI3Jb77nqssVXdNewA==
X-Received: by 2002:a05:6808:1306:b0:434:d39:63af with SMTP id
 5614622812f47-4357c38d959mr1177297b6e.15.1754492166965; 
 Wed, 06 Aug 2025 07:56:06 -0700 (PDT)
Received: from bill-the-cat.. (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-30ba8228a79sm1925391fac.35.2025.08.06.07.56.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 Aug 2025 07:56:06 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut@mailbox.org>, Lukasz Majewski <lukma@denx.de>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>
Subject: [PATCH 3/7] usb: gadget: bcm_udc_otg: Remove unused driver
Date: Wed,  6 Aug 2025 08:55:57 -0600
Message-ID: <20250806145601.1664563-3-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250806145601.1664563-1-trini@konsulko.com>
References: <20250806145601.1664563-1-trini@konsulko.com>
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

This driver is unused. Remove it.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
Cc: Marek Vasut <marek.vasut@mailbox.org>
Cc: Lukasz Majewski <lukma@denx.de>
Cc: Mattijs Korpershoek <mkorpershoek@kernel.org>
---
 drivers/usb/gadget/Kconfig           |  5 ---
 drivers/usb/gadget/Makefile          |  1 -
 drivers/usb/gadget/bcm_udc_otg.h     | 19 ----------
 drivers/usb/gadget/bcm_udc_otg_phy.c | 54 ----------------------------
 4 files changed, 79 deletions(-)
 delete mode 100644 drivers/usb/gadget/bcm_udc_otg.h
 delete mode 100644 drivers/usb/gadget/bcm_udc_otg_phy.c

diff --git a/drivers/usb/gadget/Kconfig b/drivers/usb/gadget/Kconfig
index bc6ce6ec8776..37c516abcd5a 100644
--- a/drivers/usb/gadget/Kconfig
+++ b/drivers/usb/gadget/Kconfig
@@ -98,11 +98,6 @@ config USB_GADGET_ATMEL_USBA
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

