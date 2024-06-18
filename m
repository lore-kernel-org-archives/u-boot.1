Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E8A8C2BA15
	for <u-boot@archiver.kernel.org>; Tue, 18 Jun 2024 07:56:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8479B8851D;
	Tue, 18 Jun 2024 09:55:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="PASuGFRk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D4DB48851D; Tue, 18 Jun 2024 09:55:37 +0200 (CEST)
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com
 [IPv6:2a00:1450:4864:20::435])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8129688519
 for <u-boot@lists.denx.de>; Tue, 18 Jun 2024 09:55:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-35f1bc2ab37so4606464f8f.1
 for <u-boot@lists.denx.de>; Tue, 18 Jun 2024 00:55:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718697334; x=1719302134; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=tQPN6Jt2rsPTvACxaljaQFZ6kE1AmkZWw/yLHFwcX74=;
 b=PASuGFRkclPjIhIZyb90vl3IJCNB+q+EpfYNWjCede8woDedCNJDfjYK8sHxkOcFgD
 B1X+nIWxJaAoy90BvRQwhd5/r1LNsuc0y5utWUVgOtrgbVh9A9THhJYDxSamOp7edAQE
 4ATs36tPEdgUP5kdjUisI58ZIpoND1KtdhF0PAIZxpeUO9bTcdzCbayG4XuHfaoATrCw
 ofTOrG48DA8jo9D3WHTP1VK+dlAJ6wtRSz4TAQbQmgnEkNAsbzAWbql9NY+F9kk5fMTK
 wdQpWnslal5Y3/VAtDaoKGq8sDUXw+ws1m8sC4696SUx59YH77VXLFhAzKtwu8iKs3LR
 mnqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718697334; x=1719302134;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tQPN6Jt2rsPTvACxaljaQFZ6kE1AmkZWw/yLHFwcX74=;
 b=pMShqqR0IMu9PGTLPE8MTY41LmblQSrv+WuAgDdNWP9amGuuMw/s2YwnUXOIOayxL0
 gfzymyu3A0LaY3XEXZwh3VTWUw1PjnDsBe4jXuglB+CG4QeuIpAK2xmQBPid3lGoJHXD
 iSEmUvy8EaxYxQh1PjGZwVmP87wqxCLn8Trbs7lBIXx9DzBMdh5txzujfxkruEIdVMTL
 afLJasR5lsIT7UB+s0iLOQ0llOGYs0tJ1i4b0VXMIWoMvqBKysYH+WQWG93NFFCO1soB
 RBTgFwsYqlG587QzdeAPqSHQ9AXbGDWljP8kqFEoAZgGmrP9NtPJtEHqqSP9iQ1rmLWU
 K5hw==
X-Forwarded-Encrypted: i=1;
 AJvYcCW+eV0YhCjFIqdn2YXhJJp5xfC6DmODNBVhpL2Vu8aBtHsyFC50GhMg7/B7ty0SvWdg4MQmzYyz3j0gf1eBcOC7dH3tRw==
X-Gm-Message-State: AOJu0YwfVsZpcZ/VA4HCPZW+3BgsrsKqRNsS5uFc47wql4wrU3kcGK3S
 HTtBp14SilGp6TY5FGctBE8eLn0hcVHpOO/2zZRBrTQ1cZB3sDN7G5V8ivAIM9E=
X-Google-Smtp-Source: AGHT+IEPDN6PjtSLqP42iWo+gUwiVk87IO2cKo2eOVXodr9s5Ut0Z72WFXpjZRcoJSvMvMQoAoHlEg==
X-Received: by 2002:a5d:58d3:0:b0:362:6cb3:c428 with SMTP id
 ffacd0b85a97d-3626cb3c4cdmr288295f8f.68.1718697334004; 
 Tue, 18 Jun 2024 00:55:34 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-360750934a4sm13523173f8f.10.2024.06.18.00.55.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Jun 2024 00:55:33 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Tue, 18 Jun 2024 09:55:28 +0200
Subject: [PATCH 4/5] usb: dwc3: meson-gxl: drop usb-gx.h and make
 dwc3_meson_gxl_force_mode static
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240618-u-boot-usb-gxl-phy-set-mode-v1-4-6b41efa46e35@linaro.org>
References: <20240618-u-boot-usb-gxl-phy-set-mode-v1-0-6b41efa46e35@linaro.org>
In-Reply-To: <20240618-u-boot-usb-gxl-phy-set-mode-v1-0-6b41efa46e35@linaro.org>
To: Tom Rini <trini@konsulko.com>, Marek Vasut <marex@denx.de>
Cc: Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 u-boot-amlogic@groups.io, u-boot@lists.denx.de, 
 Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1663;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=DpgZRKTgku+ys6NjVBIfERJR/6XmLyfT3EDY9DcHj8U=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBmcT1xoNuGVCdBygwOmAF3sQEiV3hiSjCtFJyNz7hp
 gQabkZqJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZnE9cQAKCRB33NvayMhJ0SaHEA
 CnPOY27LW8x/hL8/uPEsdYxaLJB5WcD8JkrAVNWR6/RiI6djALcfx51kRwyHMlWFVPslA6Yl0M6WKY
 mZQuOUX84uBbV5kTw9qhXd/FxApnvblZTawlmwl1gEQslSRYF9gexakvFDEPzsFpEheL1fqJhzL7Lg
 q5euNrgfd96JTLoHX5TXR6vWnmIjIKSm7KvKfjD6TJMDdMb/aNs1lrAeasldhJtwahBU39atx6i2d4
 7JU6Q+TpgTQDvhjhHh2wKsDG7HhKB3vbFmSJ/78h+HaQ3op6eC4RQTF1pyEgTDfhaGaxGcMN7JwzGh
 kzZS7M5i6WdikOe+PQ6Gq9/a0ze5a5DJrubNLtDId8uxWHv/NzWPnLQhxoRYHUjqO3ZV3FrA5ZOHdC
 03PW1in3jXDksmuZvyeE5lFkXDwKusL8Hpky/cDTFaXdBy4Byt00VkLIi7Msun4SLBW/xNT1bN4moW
 x/PP9FQ4XR36t88ZLDSHQgISbLuZsw7vTfAV1Tfqey09m6WHWd08rnRVe5B3eIQcotQ9dDXsO+oNPS
 fHNCPMBHK3xwrqZ0fnPBpbbCS2lh0Q2RC40TLQ8LMM2gAM0wQbM1h6p884NZKdFuuNRJNxq1sa689B
 b6xTAqXKRk4ijoQYalNEH7uIzQQUXhm9qaocINWg6g1NCjIQXSB+BdxLbgkA==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
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

Drop this useless usb-gx.h and now make dwc3_meson_gxl_force_mode
static since only used in the dwc3-meson-gxl.c file.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 arch/arm/include/asm/arch-meson/usb-gx.h | 14 --------------
 drivers/usb/dwc3/dwc3-meson-gxl.c        |  3 +--
 2 files changed, 1 insertion(+), 16 deletions(-)

diff --git a/arch/arm/include/asm/arch-meson/usb-gx.h b/arch/arm/include/asm/arch-meson/usb-gx.h
deleted file mode 100644
index 966d401730..0000000000
--- a/arch/arm/include/asm/arch-meson/usb-gx.h
+++ /dev/null
@@ -1,14 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0+ */
-/*
- * Copyright 2019 BayLibre SAS
- * Author: Neil Armstrong <narmstrong@baylibre.com>
- */
-#ifndef _ARCH_MESON_USB_GX_H_
-#define _ARCH_MESON_USB_GX_H_
-
-#include <generic-phy.h>
-#include <linux/usb/otg.h>
-
-int dwc3_meson_gxl_force_mode(struct udevice *dev, enum usb_dr_mode mode);
-
-#endif
diff --git a/drivers/usb/dwc3/dwc3-meson-gxl.c b/drivers/usb/dwc3/dwc3-meson-gxl.c
index 290ac03a37..5fb9b477ad 100644
--- a/drivers/usb/dwc3/dwc3-meson-gxl.c
+++ b/drivers/usb/dwc3/dwc3-meson-gxl.c
@@ -26,7 +26,6 @@
 #include <linux/bitfield.h>
 #include <linux/bitops.h>
 #include <linux/compat.h>
-#include <asm/arch/usb-gx.h>
 
 /* USB Glue Control Registers */
 
@@ -193,7 +192,7 @@ static int dwc3_meson_gxl_usb_init(struct dwc3_meson_gxl *priv)
 	return 0;
 }
 
-int dwc3_meson_gxl_force_mode(struct udevice *dev, enum usb_dr_mode mode)
+static int dwc3_meson_gxl_force_mode(struct udevice *dev, enum usb_dr_mode mode)
 {
 	struct dwc3_meson_gxl *priv = dev_get_plat(dev);
 

-- 
2.34.1

