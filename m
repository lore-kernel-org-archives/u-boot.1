Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0F34C282EC
	for <u-boot@archiver.kernel.org>; Sat, 15 Mar 2025 01:27:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0119981F7E;
	Sat, 15 Mar 2025 02:27:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="XzQb5jtA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D3CDC8209F; Sat, 15 Mar 2025 02:27:43 +0100 (CET)
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com
 [IPv6:2607:f8b0:4864:20::833])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4BB3081F59
 for <u-boot@lists.denx.de>; Sat, 15 Mar 2025 02:27:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x833.google.com with SMTP id
 d75a77b69052e-476a57a9379so37220951cf.1
 for <u-boot@lists.denx.de>; Fri, 14 Mar 2025 18:27:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1742002060; x=1742606860; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=e02qKBqYFeYtWUgPbmR+yJwhz19citSUhGwT0D2u3jk=;
 b=XzQb5jtAnNrZH2G0ledsyEde3Yqq0JLf0yVvZwr7O//VVzYPHr9UDxesG3RZ8N60kR
 6qq7rMDtFChzCl9Yml2xdhY1SuE6hTJ7LJ0038aecZFULEQVL8EHVvmKJcIYWye3hijH
 3wVGV0zK13NGT028Fe7ZDdga4Q2jgECbjGVeQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742002060; x=1742606860;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=e02qKBqYFeYtWUgPbmR+yJwhz19citSUhGwT0D2u3jk=;
 b=h1LwR7jswW1YQJksVwpI+BQt7khfmWWBz1PDvdXyrihDBgPZs4hmtbh6nf7a7s/WxG
 5hdUwVOg55GsWjZ/x3IGLD1ecCP7meKQYYuqLI8f56Uumg66FDGryVG8NBUgQ+N1tBb0
 rrxZs4CAI/ZPPWYZJzgvRBaRvd909t6Po7z7U9Sr4s0tAnGr9h3iA19uo8jl/zig36Wn
 IrOIoYG015tH4r1+RQSxSxMb/k0SfXslrQ9GZa4NkIA4vvw07ziBtAmlnDmquvAVQ7Oq
 qUu3Kdi3/bnCUUUlVH5i6GvpxLGneNm8O8RFoQWuihXupSAq33RuxUCjb9JABNDJRwUh
 KWdg==
X-Gm-Message-State: AOJu0YxuwapGnVpE98QeD/owAFJpEgiyjJfCwv0nYj5bvRjzYngrMl9h
 lXB+9HWkgXEv+2uHEUtZYKi4ni59cFnG4i4c/qAAyTRv5MZPsuwDBEgkwXLGRKCfshYsMXFb93Y
 D
X-Gm-Gg: ASbGnct/FOwKOv9t66c+j5J8osIbHBDOvZ5mlqiSTUIJcmxiKRvXAaVR3GcbYiX3aFG
 CiD84EmbGN6pDnnDHv5Q4DjAmnalDV/eJ8Vy9ykY05fvmdBV66NK2kG4enS6d7+mZo9x8VPaVVz
 vslaRorNpfRo0Zm6jo8BdPP11ctkGYUuUrEjmjtotK6CdLLitLAdcCOhixXA7Gn2ENIlV+XH8ND
 0uR5CQBrAABN35fkqio4tKPrIZID0jchrM+SfG3Jsm410bD+IQph6gr1GyIMihS+hGj20J8cmlC
 vV30ABpMGhi7us/nPU8h82K59btCWHpq0acgeNK6cx+WY9rr
X-Google-Smtp-Source: AGHT+IEpCMwoCRQsU9xCbiEJDPPCulX8PLqLCE/hV0AKP6ba05M9u2ECPyRVabF5aChz44k2SLQK8Q==
X-Received: by 2002:a05:622a:5e8b:b0:472:6aa:d6be with SMTP id
 d75a77b69052e-476c8142d12mr62461521cf.17.1742002060054; 
 Fri, 14 Mar 2025 18:27:40 -0700 (PDT)
Received: from bill-the-cat.. ([187.192.142.234])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-476bb82c1b7sm29263711cf.74.2025.03.14.18.27.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Mar 2025 18:27:39 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>
Subject: [PATCH 1/2] usb: ulpi: Remove unused omap-ulpi-viewport driver
Date: Fri, 14 Mar 2025 19:27:35 -0600
Message-ID: <20250315012736.399197-1-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
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

The last platform to enable this driver was removed in 2019. Remove this
unused code and documentation now.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
Cc: Marek Vasut <marex@denx.de>
---
 doc/README.omap-ulpi-viewport         | 27 ----------
 drivers/usb/ulpi/Kconfig              |  5 --
 drivers/usb/ulpi/Makefile             |  1 -
 drivers/usb/ulpi/omap-ulpi-viewport.c | 71 ---------------------------
 4 files changed, 104 deletions(-)
 delete mode 100644 doc/README.omap-ulpi-viewport
 delete mode 100644 drivers/usb/ulpi/omap-ulpi-viewport.c

diff --git a/doc/README.omap-ulpi-viewport b/doc/README.omap-ulpi-viewport
deleted file mode 100644
index a5240b9e2951..000000000000
--- a/doc/README.omap-ulpi-viewport
+++ /dev/null
@@ -1,27 +0,0 @@
-Reference code ""drivers/usb/ulpi/omap-ulpi-viewport.c"
-
-Contains the ulpi read write api's to perform
-any ulpi phy port access on omap platform.
-
-On omap ehci reg map contains INSNREG05_ULPI
-register which offers the ulpi phy access so
-any ulpi phy commands should be passsed using this
-register.
-
-omap-ulpi-viewport.c is a low level function
-implementation of "drivers/usb/ulpi/ulpi.c"
-
-To enable and use omap-ulpi-viewport.c
-we require CONFIG_USB_ULPI_VIEWPORT_OMAP and
-CONFIG_USB_ULPI be enabled in config file.
-
-Any ulpi ops request can be done with ulpi.c
-and soc specific binding and usage is done with
-omap-ulpi-viewport implementation.
-
-Ex: scenario:
-omap-ehci driver code requests for ulpi phy reset if
-ehci is used in phy mode, which will call ulpi phy reset
-the ulpi phy reset does ulpi_read/write from viewport
-implementation which will do ulpi reset using the
-INSNREG05_ULPI register.
diff --git a/drivers/usb/ulpi/Kconfig b/drivers/usb/ulpi/Kconfig
index 001564d40c63..482114d6c11d 100644
--- a/drivers/usb/ulpi/Kconfig
+++ b/drivers/usb/ulpi/Kconfig
@@ -14,11 +14,6 @@ config USB_ULPI_VIEWPORT
 	  Support generic ULPI Viewport implementation that is used on
 	  some Tegra and Snapdragon devices.
 
-config USB_ULPI_VIEWPORT_OMAP
-	bool "OMAP ULPI Viewport"
-	help
-	  Support ULPI Viewport implementation that is used on OMAP devices.
-
 endchoice
 
 config USB_ULPI
diff --git a/drivers/usb/ulpi/Makefile b/drivers/usb/ulpi/Makefile
index f05b7743531e..5565948bc12d 100644
--- a/drivers/usb/ulpi/Makefile
+++ b/drivers/usb/ulpi/Makefile
@@ -4,4 +4,3 @@
 
 obj-$(CONFIG_USB_ULPI)		+= ulpi.o
 obj-$(CONFIG_USB_ULPI_VIEWPORT)	+= ulpi-viewport.o
-obj-$(CONFIG_USB_ULPI_VIEWPORT_OMAP)	+= omap-ulpi-viewport.o
diff --git a/drivers/usb/ulpi/omap-ulpi-viewport.c b/drivers/usb/ulpi/omap-ulpi-viewport.c
deleted file mode 100644
index 6f0c3eb154ee..000000000000
--- a/drivers/usb/ulpi/omap-ulpi-viewport.c
+++ /dev/null
@@ -1,71 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * OMAP ulpi viewport support
- * Based on drivers/usb/ulpi/ulpi-viewport.c
- *
- * Copyright (C) 2011 Texas Instruments Incorporated - https://www.ti.com
- * Author: Govindraj R <govindraj.raja@ti.com>
- */
-
-#include <log.h>
-#include <asm/io.h>
-#include <linux/delay.h>
-#include <usb/ulpi.h>
-
-#define OMAP_ULPI_WR_OPSEL	(2 << 22)
-#define OMAP_ULPI_RD_OPSEL	(3 << 22)
-#define OMAP_ULPI_START		(1 << 31)
-
-/*
- * Wait for having ulpi in done state
- */
-static int ulpi_wait(struct ulpi_viewport *ulpi_vp, u32 mask)
-{
-	int timeout = CFG_USB_ULPI_TIMEOUT;
-
-	while (--timeout) {
-		if (!(readl(ulpi_vp->viewport_addr) & mask))
-			return 0;
-
-		udelay(1);
-	}
-
-	return ULPI_ERROR;
-}
-
-/*
- * Issue a ULPI read/write request
- */
-static int ulpi_request(struct ulpi_viewport *ulpi_vp, u32 value)
-{
-	int err;
-
-	writel(value, ulpi_vp->viewport_addr);
-
-	err = ulpi_wait(ulpi_vp, OMAP_ULPI_START);
-	if (err)
-		debug("ULPI request timed out\n");
-
-	return err;
-}
-
-int ulpi_write(struct ulpi_viewport *ulpi_vp, u8 *reg, u32 value)
-{
-	u32 val = OMAP_ULPI_START | (((ulpi_vp->port_num + 1) & 0xf) << 24) |
-			OMAP_ULPI_WR_OPSEL | ((u32)reg << 16) | (value & 0xff);
-
-	return ulpi_request(ulpi_vp, val);
-}
-
-u32 ulpi_read(struct ulpi_viewport *ulpi_vp, u8 *reg)
-{
-	int err;
-	u32 val = OMAP_ULPI_START | (((ulpi_vp->port_num + 1) & 0xf) << 24) |
-			 OMAP_ULPI_RD_OPSEL | ((u32)reg << 16);
-
-	err = ulpi_request(ulpi_vp, val);
-	if (err)
-		return err;
-
-	return readl(ulpi_vp->viewport_addr) & 0xff;
-}
-- 
2.43.0

