Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FBB3C87FCB
	for <u-boot@archiver.kernel.org>; Wed,  6 Aug 2025 14:55:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BE0638383F;
	Wed,  6 Aug 2025 16:55:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="lciqtsq2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D9B9A83A56; Wed,  6 Aug 2025 16:55:15 +0200 (CEST)
Received: from mail-oo1-xc2e.google.com (mail-oo1-xc2e.google.com
 [IPv6:2607:f8b0:4864:20::c2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1B67283721
 for <u-boot@lists.denx.de>; Wed,  6 Aug 2025 16:55:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc2e.google.com with SMTP id
 006d021491bc7-619b164c0b9so4756eaf.0
 for <u-boot@lists.denx.de>; Wed, 06 Aug 2025 07:55:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1754492106; x=1755096906; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=mweGu9kbTsUu/HWNx2QXm8mUaLQQuObJ6y7GY39kCDA=;
 b=lciqtsq2Y+ulvSCY7GhHcKAK+2kT2NXWnOlHjsL/LbF9gC5ZZm3JdqMqMAVbeWizHh
 1aaPEF1ITiiNiC4eHBhA0suSl6yv9ggcWnQ3wp+J9YS54pNHuLO9NKwUTu/CdvGlYKkn
 77qs2kzb80QU2dBPFnnr/oxs/iqq7mzXL/Rfo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754492106; x=1755096906;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=mweGu9kbTsUu/HWNx2QXm8mUaLQQuObJ6y7GY39kCDA=;
 b=FukAp9iy1DJ5q5hRjik/ChhuIN1onfpWAYXNZ7wOKEYnvxOBjN5xAr5bi7d/bvNLLn
 mrrW7Bx0dMDVM8L/iwRZVnlUABMSlEAbGROSVnTKveNiUzbXK3K9ZTrANRqYSDaDxYOx
 j9tp7JloAZBp5As87hT1jMIgj2M2NVdv0dLHxtmbR/Ldd3xwON23PXrvWQeZFn0Rxivq
 N8NLYeaCqIT7JJ0+3O8n2qei6GEVLmBcagTQFl+i7C/k7a5c0BI4VZ1Dy6g6mOUSK9+w
 qnTkytYe4v9T5i1V5EcCsgCLqYoVAzz9J1O/1Blpql7k2SYJFRwXX1BlAEPZOe//SCtI
 41nA==
X-Gm-Message-State: AOJu0YwZrq15sBV1exdZCEjfHO9N1T3zaaPBe94nqaNEgvhM7tomFaNi
 McjU+Nay5BPUAV0lxUREpKIu+zk6u+TL8YFdMJny/fpBG/2bWkUhPQKyzfWXhvBMXz+A0YJopYT
 /0lYGIPc=
X-Gm-Gg: ASbGncvueWVNbgwliNXAKXY1cR3DmlDnRXoQsW390TuYRepDyL9/X/VY48VyHFc6Nc0
 +0/MWcKOj2FFrduXWJGGl7559YxZGScchqBixzBlkfhdgztBJI2ShcktzAL/EeEOxLe2w5Dauiu
 tmMfgiLPZP24jfmSU0qo/PMKBtpCHi2nR3wNmXQEZblWbDtT2oeSPOUX9QVr7x6hkx/+7MdBBfS
 qtIqOPgtzBScYEkJkfVbmybzAdEl7MIXQSAaUS8Fx+VPdQ2ZtPQKiE7IPQgZYTje5ni/Pl9jIGn
 Lu9i7A0shHTZTgDHcTogcl5TD1Ad8KMOheLhYtCISguiXjBD2hye7Gx6xCWNypPfqEFcXqlJwBQ
 e0NiphBlDoMZSdBWNr3pQRaIq0I8yqaYVfkZxltqqaWmozzJO8SssX8q+vfw=
X-Google-Smtp-Source: AGHT+IERvsd3cywOXZGMkICq/n7Moz5Zz45l88OFlhbgtgs/8MwfeilLaNYBBtmzKu0tyw9v5+Su+A==
X-Received: by 2002:a05:6820:1991:b0:619:2ee:6378 with SMTP id
 006d021491bc7-61b5f7e1c6dmr2071727eaf.3.1754492105675; 
 Wed, 06 Aug 2025 07:55:05 -0700 (PDT)
Received: from bill-the-cat.. (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-61970528732sm2491311eaf.13.2025.08.06.07.55.04
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 Aug 2025 07:55:04 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH 1/2] timer: fttmr010_timer: Remove unused driver
Date: Wed,  6 Aug 2025 08:55:02 -0600
Message-ID: <20250806145503.1664386-1-trini@konsulko.com>
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

This driver is unused. Remove it.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 drivers/timer/Kconfig          |  7 ---
 drivers/timer/Makefile         |  1 -
 drivers/timer/fttmr010_timer.c | 91 ----------------------------------
 include/faraday/fttmr010.h     | 61 -----------------------
 4 files changed, 160 deletions(-)
 delete mode 100644 drivers/timer/fttmr010_timer.c
 delete mode 100644 include/faraday/fttmr010.h

diff --git a/drivers/timer/Kconfig b/drivers/timer/Kconfig
index cb6fc0e7fda8..d3231441b13e 100644
--- a/drivers/timer/Kconfig
+++ b/drivers/timer/Kconfig
@@ -166,13 +166,6 @@ config DESIGNWARE_APB_TIMER
 	  Enables support for the Designware APB Timer driver. This timer is
 	  present on Altera SoCFPGA SoCs.
 
-config FTTMR010_TIMER
-	bool "Faraday Technology timer support"
-	depends on TIMER
-	help
-	  Select this to enable support for the timer found on
-	  devices using Faraday Technology's IP.
-
 config GXP_TIMER
 	bool "HPE GXP Timer"
 	depends on TIMER
diff --git a/drivers/timer/Makefile b/drivers/timer/Makefile
index 21db0d317fed..a72e411fb2ff 100644
--- a/drivers/timer/Makefile
+++ b/drivers/timer/Makefile
@@ -15,7 +15,6 @@ obj-$(CONFIG_$(PHASE_)ATMEL_PIT_TIMER) += atmel_pit_timer.o
 obj-$(CONFIG_$(PHASE_)ATMEL_TCB_TIMER) += atmel_tcb_timer.o
 obj-$(CONFIG_CADENCE_TTC_TIMER)	+= cadence-ttc.o
 obj-$(CONFIG_DESIGNWARE_APB_TIMER)	+= dw-apb-timer.o
-obj-$(CONFIG_FTTMR010_TIMER)	+= fttmr010_timer.o
 obj-$(CONFIG_GXP_TIMER)		+= gxp-timer.o
 obj-$(CONFIG_MPC83XX_TIMER) += mpc83xx_timer.o
 obj-$(CONFIG_NOMADIK_MTU_TIMER)	+= nomadik-mtu-timer.o
diff --git a/drivers/timer/fttmr010_timer.c b/drivers/timer/fttmr010_timer.c
deleted file mode 100644
index c41bbfc1d576..000000000000
--- a/drivers/timer/fttmr010_timer.c
+++ /dev/null
@@ -1,91 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0+
-/*
- * (C) Copyright 2009 Faraday Technology
- * Po-Yu Chuang <ratbert@faraday-tech.com>
- *
- * 23/08/2022 Port to DM
- */
-#include <dm.h>
-#include <log.h>
-#include <timer.h>
-#include <asm/io.h>
-#include <dm/ofnode.h>
-#include <faraday/fttmr010.h>
-#include <asm/global_data.h>
-
-#define TIMER_LOAD_VAL	0xffffffff
-
-struct fttmr010_timer_priv {
-	struct fttmr010 __iomem *regs;
-};
-
-static u64 fttmr010_timer_get_count(struct udevice *dev)
-{
-	struct fttmr010_timer_priv *priv = dev_get_priv(dev);
-	struct fttmr010 *tmr = priv->regs;
-	u32 now = TIMER_LOAD_VAL - readl(&tmr->timer3_counter);
-
-	/* increment tbu if tbl has rolled over */
-	if (now < gd->arch.tbl)
-		gd->arch.tbu++;
-	gd->arch.tbl = now;
-
-	return ((u64)gd->arch.tbu << 32) | gd->arch.tbl;
-}
-
-static int fttmr010_timer_probe(struct udevice *dev)
-{
-	struct fttmr010_timer_priv *priv = dev_get_priv(dev);
-	struct fttmr010 *tmr;
-	unsigned int cr;
-
-	priv->regs = dev_read_addr_ptr(dev);
-	if (!priv->regs)
-		return -EINVAL;
-	tmr = priv->regs;
-
-	debug("Faraday FTTMR010 timer revision 0x%08X\n", readl(&tmr->revision));
-
-	/* disable timers */
-	writel(0, &tmr->cr);
-
-	/* setup timer */
-	writel(TIMER_LOAD_VAL, &tmr->timer3_load);
-	writel(TIMER_LOAD_VAL, &tmr->timer3_counter);
-	writel(0, &tmr->timer3_match1);
-	writel(0, &tmr->timer3_match2);
-
-	/* we don't want timer to issue interrupts */
-	writel(FTTMR010_TM3_MATCH1 |
-	       FTTMR010_TM3_MATCH2 |
-	       FTTMR010_TM3_OVERFLOW,
-	       &tmr->interrupt_mask);
-
-	cr = readl(&tmr->cr);
-	cr |= FTTMR010_TM3_CLOCK;	/* use external clock */
-	cr |= FTTMR010_TM3_ENABLE;
-	writel(cr, &tmr->cr);
-
-	gd->arch.tbl = 0;
-	gd->arch.tbu = 0;
-
-	return 0;
-}
-
-static const struct timer_ops fttmr010_timer_ops = {
-	.get_count = fttmr010_timer_get_count,
-};
-
-static const struct udevice_id fttmr010_timer_ids[] = {
-	{ .compatible = "faraday,fttmr010-timer" },
-	{}
-};
-
-U_BOOT_DRIVER(fttmr010_timer) = {
-	.name = "fttmr010_timer",
-	.id = UCLASS_TIMER,
-	.of_match = fttmr010_timer_ids,
-	.priv_auto = sizeof(struct fttmr010_timer_priv),
-	.probe = fttmr010_timer_probe,
-	.ops = &fttmr010_timer_ops,
-};
diff --git a/include/faraday/fttmr010.h b/include/faraday/fttmr010.h
deleted file mode 100644
index 5b1bef38c77d..000000000000
--- a/include/faraday/fttmr010.h
+++ /dev/null
@@ -1,61 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0+ */
-/*
- * (C) Copyright 2009 Faraday Technology
- * Po-Yu Chuang <ratbert@faraday-tech.com>
- */
-
-/*
- * Timer
- */
-#ifndef __FTTMR010_H
-#define __FTTMR010_H
-
-struct fttmr010 {
-	unsigned int	timer1_counter;		/* 0x00 */
-	unsigned int	timer1_load;		/* 0x04 */
-	unsigned int	timer1_match1;		/* 0x08 */
-	unsigned int	timer1_match2;		/* 0x0c */
-	unsigned int	timer2_counter;		/* 0x10 */
-	unsigned int	timer2_load;		/* 0x14 */
-	unsigned int	timer2_match1;		/* 0x18 */
-	unsigned int	timer2_match2;		/* 0x1c */
-	unsigned int	timer3_counter;		/* 0x20 */
-	unsigned int	timer3_load;		/* 0x24 */
-	unsigned int	timer3_match1;		/* 0x28 */
-	unsigned int	timer3_match2;		/* 0x2c */
-	unsigned int	cr;			/* 0x30 */
-	unsigned int	interrupt_state;	/* 0x34 */
-	unsigned int	interrupt_mask;		/* 0x38 */
-	unsigned int	revision;		/* 0x3c */
-};
-
-/*
- * Timer Control Register
- */
-#define FTTMR010_TM3_UPDOWN	(1 << 11)
-#define FTTMR010_TM2_UPDOWN	(1 << 10)
-#define FTTMR010_TM1_UPDOWN	(1 << 9)
-#define FTTMR010_TM3_OFENABLE	(1 << 8)
-#define FTTMR010_TM3_CLOCK	(1 << 7)
-#define FTTMR010_TM3_ENABLE	(1 << 6)
-#define FTTMR010_TM2_OFENABLE	(1 << 5)
-#define FTTMR010_TM2_CLOCK	(1 << 4)
-#define FTTMR010_TM2_ENABLE	(1 << 3)
-#define FTTMR010_TM1_OFENABLE	(1 << 2)
-#define FTTMR010_TM1_CLOCK	(1 << 1)
-#define FTTMR010_TM1_ENABLE	(1 << 0)
-
-/*
- * Timer Interrupt State & Mask Registers
- */
-#define FTTMR010_TM3_OVERFLOW	(1 << 8)
-#define FTTMR010_TM3_MATCH2	(1 << 7)
-#define FTTMR010_TM3_MATCH1	(1 << 6)
-#define FTTMR010_TM2_OVERFLOW	(1 << 5)
-#define FTTMR010_TM2_MATCH2	(1 << 4)
-#define FTTMR010_TM2_MATCH1	(1 << 3)
-#define FTTMR010_TM1_OVERFLOW	(1 << 2)
-#define FTTMR010_TM1_MATCH2	(1 << 1)
-#define FTTMR010_TM1_MATCH1	(1 << 0)
-
-#endif	/* __FTTMR010_H */
-- 
2.43.0

