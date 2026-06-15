Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E36E8CD98CE
	for <u-boot@archiver.kernel.org>; Mon, 15 Jun 2026 21:08:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2532784884;
	Mon, 15 Jun 2026 23:08:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="RtxJJ6w/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 33AB5848DC; Mon, 15 Jun 2026 23:08:31 +0200 (CEST)
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com
 [IPv6:2a00:1450:4864:20::52d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0E2418484C
 for <u-boot@lists.denx.de>; Mon, 15 Jun 2026 23:08:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jbx6244@gmail.com
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-6903b3e997eso696035a12.1
 for <u-boot@lists.denx.de>; Mon, 15 Jun 2026 14:08:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781557708; x=1782162508; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=mS0AD/E4qsOakOpEpwAd3LCb6jb6D/WGCRt846Uul00=;
 b=RtxJJ6w/01W79LMhRGgfwrE2TFFhUUqmBu20k6SghVonx1vIMZ6bLHziX17DvuWpTV
 lr85T8gLmlLcU8AlUZajA8I9kB07OLKz1FrrI6mpaDlDG0NF2DmQOXtmhJbLC9gwshJK
 qQFYDZIcmpiVOarPLVOYcixkvUOKFY0zkSC3p+F67X6sj3uQCZKaMv39KGQ8nMAXJSXn
 hQdvbBVpC83131SXkuzNRgby1vj7Uj5JckjMypdgRy6sC+yIQ8MNO7EwrirIW38xOydq
 iyJOM4YaucWqUV+iQzgvA5upt1465YK9CC1VWcXgW64V+hnhRzoJ0Karys9Tz70JJd5Z
 NT+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781557708; x=1782162508;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:subject:from:user-agent:mime-version:date:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=mS0AD/E4qsOakOpEpwAd3LCb6jb6D/WGCRt846Uul00=;
 b=PvmQR+KVCDkG/X3gkAc+RlZUo1sFTVlGpIUJ8u4T3dR2phK0ta8c7Qd3J37mSBqXWE
 ATBc6ecdhPGnEvWjseBHq4xVHGnD1sR/Px4zSZhrkbNNSKU/RijtpvCwjgTM7mnR4cU5
 yW09nOqvyF5BO8L05/swyxpYEEPPOQqcuD1D0UaESMjg2YG57KEtZnR1Ei2FsNeyp7q0
 XksQYewQrOgFS8O9cCQD0fv4tKyQASX5TNDFzpmc7RFQ4hg/dax4L0kPjvDHnfUbnCbw
 LNPmDgGRNRFBJTlmMj4+XqSGRD60hn2FWGOwaiwBXKrQtifLavy7B9SPn5RZC9fPpgvt
 Q5Yg==
X-Forwarded-Encrypted: i=1;
 AFNElJ86mGoa0nuHSh/aDsJdJiUFWPNuVmhCqp+JkI/lMWSABT38+jFEuAG9v77D8JvRtGU8TXaipRM=@lists.denx.de
X-Gm-Message-State: AOJu0YxLTK9Eei3Or0fiAAKaxrUMKKLaJgtv4v3HXuX18yK1zB/rqTkL
 Grzi4SCwrXLtjP6K9gdayXCqFINf1SJBVsXX/lftwl3g6L4+ZT0FXqEO
X-Gm-Gg: Acq92OEMCJi+KsFj7/hH68eFX5/kZNbMRaZ75qh9J02W8QNbB4krrO17KR6dJ8eB5Y/
 namx4sy2sGae+Who2HMEJDttmzdg9TecJbZnT+aJy/agpynUqlmxPu8+7MJ7aeuzeK+UrusC1lT
 zmzsojsR8r+pWODWsHCzz/aQd6j7FSEFGNa5oE8GmFH1g9PxHxl9NaoQH0AaV8TR9SELreh/5wt
 W+m5AJ72l9dRhnKXukbxIqkg+eoWgMCdnGVkvgY2cmOVkz5l/v26FhI+xPTpY7tw7mAM8hYgRaJ
 mn9cKArwJi17EwEseOhRzMsc1QWc5yGtnjItXQY/bt2s45lJQ9S0+DO7UYJDix0XZLNRvVeReZL
 vdRmLn5UkOZwrYqWZKztHenclpqo6naOWOLA0PjWHNZ41093QOTrhVFAE1pKZwPAt+OJK27enG0
 vmbPbaCCZnO4VqJ8cwJjmwPd0H0DAG0hZxse8D/67Z0wO4AXJWVdanuXtUVTI3hdRkcsQ+q58s
X-Received: by 2002:a17:907:9624:b0:beb:967f:1ca8 with SMTP id
 a640c23a62f3a-bfe27e0acf4mr343665366b.2.1781557708297; 
 Mon, 15 Jun 2026 14:08:28 -0700 (PDT)
Received: from ?IPV6:2a02:a449:4071:0:32d0:42ff:fe10:6983?
 ([2a02:a449:4071:0:32d0:42ff:fe10:6983])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-bfdb8d1de1fsm536153566b.55.2026.06.15.14.08.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 15 Jun 2026 14:08:27 -0700 (PDT)
Message-ID: <527782d6-db31-4f41-aa64-c3b426de9049@gmail.com>
Date: Mon, 15 Jun 2026 23:08:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Johan Jonker <jbx6244@gmail.com>
Subject: [PATCH v5 07/10] usb: phy: remove rockchip_usb2_phy.c
To: kever.yang@rock-chips.com
Cc: sjg@chromium.org, philipp.tomsich@vrull.eu, trini@konsulko.com,
 hl@rock-chips.com, jernej.skrabec@gmail.com, w.egorov@phytec.de,
 jagan@amarulasolutions.com, heiko@sntech.de, jonas@kwiboo.se,
 michael@amarulasolutions.com, marex@denx.de, u-boot@lists.denx.de,
 upstream@lists.phytec.de
References: <9e688aba-c88f-404a-adc7-cf9472699d66@gmail.com>
Content-Language: en-US, ar-EG
In-Reply-To: <9e688aba-c88f-404a-adc7-cf9472699d66@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

The new phy-rockchip-usb2 DM driver is now available,
so remove rockchip_usb2_phy related code. Also remove a
variable no longer needed from an include file.

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---

Changed V4:
(Jonas)
split patch
---
 arch/arm/mach-rockchip/board.c      |  28 -------
 drivers/usb/phy/Kconfig             |   3 -
 drivers/usb/phy/Makefile            |   1 -
 drivers/usb/phy/rockchip_usb2_phy.c | 113 ----------------------------
 include/usb/dwc2_udc.h              |   1 -
 5 files changed, 146 deletions(-)
 delete mode 100644 drivers/usb/phy/rockchip_usb2_phy.c

diff --git a/arch/arm/mach-rockchip/board.c b/arch/arm/mach-rockchip/board.c
index 2e6bb38b9235..1538f4fef081 100644
--- a/arch/arm/mach-rockchip/board.c
+++ b/arch/arm/mach-rockchip/board.c
@@ -269,34 +269,6 @@ int board_usb_init(int index, enum usb_init_type init)
 	}
 	otg_data.regs_otg = ofnode_get_addr(node);

-#ifdef CONFIG_ROCKCHIP_USB2_PHY
-	int ret;
-	u32 phandle, offset;
-	ofnode phy_node;
-
-	ret = ofnode_read_u32(node, "phys", &phandle);
-	if (ret)
-		return ret;
-
-	node = ofnode_get_by_phandle(phandle);
-	if (!ofnode_valid(node)) {
-		debug("Not found usb phy device\n");
-		return -ENODEV;
-	}
-
-	phy_node = ofnode_get_parent(node);
-	if (!ofnode_valid(node)) {
-		debug("Not found usb phy device\n");
-		return -ENODEV;
-	}
-
-	otg_data.phy_of_node = phy_node;
-	ret = ofnode_read_u32(node, "reg", &offset);
-	if (ret)
-		return ret;
-	otg_data.regs_phy =  offset +
-		(u32)syscon_get_first_range(ROCKCHIP_SYSCON_GRF);
-#endif
 	return dwc2_udc_probe(&otg_data);
 }

diff --git a/drivers/usb/phy/Kconfig b/drivers/usb/phy/Kconfig
index c505862f1e15..9c91f63786ac 100644
--- a/drivers/usb/phy/Kconfig
+++ b/drivers/usb/phy/Kconfig
@@ -7,6 +7,3 @@ comment "USB Phy"

 config TWL4030_USB
 	bool "TWL4030 PHY"
-
-config ROCKCHIP_USB2_PHY
-	bool "Rockchip USB2 PHY"
diff --git a/drivers/usb/phy/Makefile b/drivers/usb/phy/Makefile
index b67a70bbe8ed..cf6109dee610 100644
--- a/drivers/usb/phy/Makefile
+++ b/drivers/usb/phy/Makefile
@@ -4,4 +4,3 @@
 # Tom Rix <Tom.Rix@windriver.com>

 obj-$(CONFIG_TWL4030_USB) += twl4030.o
-obj-$(CONFIG_ROCKCHIP_USB2_PHY) += rockchip_usb2_phy.o
diff --git a/drivers/usb/phy/rockchip_usb2_phy.c b/drivers/usb/phy/rockchip_usb2_phy.c
deleted file mode 100644
index bdbd0d44813a..000000000000
--- a/drivers/usb/phy/rockchip_usb2_phy.c
+++ /dev/null
@@ -1,113 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0+
-/*
- * Copyright 2016 Rockchip Electronics Co., Ltd
- */
-
-#include <hang.h>
-#include <log.h>
-#include <asm/io.h>
-#include <linux/bitops.h>
-#include <linux/delay.h>
-
-#include "../gadget/dwc2_udc_otg_priv.h"
-
-#define BIT_WRITEABLE_SHIFT	16
-
-struct usb2phy_reg {
-	unsigned int offset;
-	unsigned int bitend;
-	unsigned int bitstart;
-	unsigned int disable;
-	unsigned int enable;
-};
-
-/**
- * struct rockchip_usb2_phy_cfg: usb-phy port configuration
- * @port_reset: usb otg per-port reset register
- * @soft_con: software control usb otg register
- * @suspend: phy suspend register
- */
-struct rockchip_usb2_phy_cfg {
-	struct usb2phy_reg port_reset;
-	struct usb2phy_reg soft_con;
-	struct usb2phy_reg suspend;
-};
-
-struct rockchip_usb2_phy_dt_id {
-	char		compatible[128];
-	const void	*data;
-};
-
-static const struct rockchip_usb2_phy_cfg rk3066a_pdata = {
-	.port_reset	= {0x00, 12, 12, 0, 1},
-	.soft_con	= {0x08, 2, 2, 0, 1},
-	.suspend	= {0x08, 8, 3, (0x01 << 3), (0x2A << 3)},
-};
-
-static const struct rockchip_usb2_phy_cfg rk3288_pdata = {
-	.port_reset     = {0x00, 12, 12, 0, 1},
-	.soft_con       = {0x08, 2, 2, 0, 1},
-	.suspend	= {0x0c, 5, 0, 0x01, 0x2A},
-};
-
-static struct rockchip_usb2_phy_dt_id rockchip_usb2_phy_dt_ids[] = {
-	{ .compatible = "rockchip,rk3066a-usb-phy", .data = &rk3066a_pdata },
-	{ .compatible = "rockchip,rk3188-usb-phy", .data = &rk3288_pdata },
-	{ .compatible = "rockchip,rk3288-usb-phy", .data = &rk3288_pdata },
-	{}
-};
-
-static void property_enable(struct dwc2_plat_otg_data *pdata,
-				  const struct usb2phy_reg *reg, bool en)
-{
-	unsigned int val, mask, tmp;
-
-	tmp = en ? reg->enable : reg->disable;
-	mask = GENMASK(reg->bitend, reg->bitstart);
-	val = (tmp << reg->bitstart) | (mask << BIT_WRITEABLE_SHIFT);
-
-	writel(val, pdata->regs_phy + reg->offset);
-}
-
-void otg_phy_init(struct dwc2_udc *dev)
-{
-	struct dwc2_plat_otg_data *pdata = dev->pdata;
-	struct rockchip_usb2_phy_cfg *phy_cfg = NULL;
-	struct rockchip_usb2_phy_dt_id *of_id;
-	int i;
-
-	for (i = 0; i < ARRAY_SIZE(rockchip_usb2_phy_dt_ids); i++) {
-		of_id = &rockchip_usb2_phy_dt_ids[i];
-		if (ofnode_device_is_compatible(pdata->phy_of_node,
-						of_id->compatible)){
-			phy_cfg = (struct rockchip_usb2_phy_cfg *)of_id->data;
-			break;
-		}
-	}
-	if (!phy_cfg) {
-		debug("Can't find device platform data\n");
-
-		hang();
-		return;
-	}
-	pdata->priv = phy_cfg;
-	/* disable software control */
-	property_enable(pdata, &phy_cfg->soft_con, false);
-
-	/* reset otg port */
-	property_enable(pdata, &phy_cfg->port_reset, true);
-	mdelay(1);
-	property_enable(pdata, &phy_cfg->port_reset, false);
-	udelay(1);
-}
-
-void otg_phy_off(struct dwc2_udc *dev)
-{
-	struct dwc2_plat_otg_data *pdata = dev->pdata;
-	struct rockchip_usb2_phy_cfg *phy_cfg = pdata->priv;
-
-	/* enable software control */
-	property_enable(pdata, &phy_cfg->soft_con, true);
-	/* enter suspend */
-	property_enable(pdata, &phy_cfg->suspend, true);
-}
diff --git a/include/usb/dwc2_udc.h b/include/usb/dwc2_udc.h
index aa37e957b47c..c8610ef8c98a 100644
--- a/include/usb/dwc2_udc.h
+++ b/include/usb/dwc2_udc.h
@@ -15,7 +15,6 @@

 struct dwc2_plat_otg_data {
 	void		*priv;
-	ofnode		phy_of_node;
 	int		(*phy_control)(int on);
 	uintptr_t	regs_phy;
 	uintptr_t	regs_otg;
--
2.39.5

