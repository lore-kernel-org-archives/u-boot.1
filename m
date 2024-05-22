Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EDB4C25B7A
	for <u-boot@archiver.kernel.org>; Wed, 22 May 2024 14:23:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BCF3088846;
	Wed, 22 May 2024 16:23:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="e/u63MS4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8DB2388464; Wed, 22 May 2024 16:23:43 +0200 (CEST)
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com
 [IPv6:2607:f8b0:4864:20::42f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7D3088885E
 for <u-boot@lists.denx.de>; Wed, 22 May 2024 16:23:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seashell11234455@gmail.com
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-6f4521ad6c0so1388595b3a.0
 for <u-boot@lists.denx.de>; Wed, 22 May 2024 07:23:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1716387817; x=1716992617; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3c8TDdK5kLVm8rYDeUKOorDl25X1OCICEijYEX1ELGs=;
 b=e/u63MS4bHNj6n6HOY6Vb/3sDjwRodafFi1IKvNEbzcNYys4PJBCq3URG0iCEyOWjl
 Lm1roQ43ThQzZ5hAAuJLNy5SJVmVrFRl3c0KfyssAEs3AxbBJ65u1xkNtwC04t7PcaDm
 pa8srIy0ONefFFXCRuz7V1yBnH3irnSi0BCh0gOny85hPzP2TLZUnnNrB+9r5Ysj/JI+
 o1x+uKjLPOxRXgN5xQNJqlkTKRa9rYZmSdWpDpHHwmW4UiBRnNDZz0ufaftmGxcudnnT
 Rdc/QtZaC2NIfPTWlplwd+h/5aev4TKvrYy4QqxA5r+vl8W+TJlKkmMz3m4aMVK3I/ed
 A9Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716387817; x=1716992617;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3c8TDdK5kLVm8rYDeUKOorDl25X1OCICEijYEX1ELGs=;
 b=nbQvivAJdUh0CUw4JsqiBAQDfnAxcAfPjdeaEsnwls459R2bMGKVAjm/m05J+z674B
 L7Xk1gFbnVfGuHbgHBGLlhISLm5xZiQZUlKMQKTiKNCnolk7NYJRKLTlQPucQJiXTUxs
 aBe9BBRsZO7KgF1PW4XCkOPuRUsYXUQMiXE5B38JFZSLY5kPcTW8+8JGNIaeSdMFqEDs
 DnxFWDE+HHEsrWTtc0QbtCDdawzyDdVX06MXYa7sch7iNth79OYXnJCPHRQjMbuCCw44
 vAxZKynrBETQEX0dft1BEzMYgg1fTozoVjW3Uk8O9P7h6o8CDFPt43ZLGtF1EjCbTLo3
 8cJg==
X-Gm-Message-State: AOJu0Yy4dTRquYDPfPet4OQH+bYgDJrPaHqncLPuXKXzAOMg+WtKQGTI
 7fuHHInRUTYyp5/D5WxMtl1vRyYYe6w6ZjXbQghAKaLLSDhS2QCPn8Vk0kdwAEw=
X-Google-Smtp-Source: AGHT+IGnmEIwZUzwgfg2tbWGB4Wz4YpqYt3UpKpF32Cej80aojv1tjZaAA7snRlynXqrM3HCXTlKqA==
X-Received: by 2002:a05:6a00:2344:b0:6ee:1508:edc8 with SMTP id
 d2e1a72fcca58-6f6d61b398bmr2085980b3a.23.1716387817137; 
 Wed, 22 May 2024 07:23:37 -0700 (PDT)
Received: from localhost.localdomain ([117.135.90.188])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-6596fde8fa7sm9410942a12.13.2024.05.22.07.23.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 May 2024 07:23:36 -0700 (PDT)
From: Kongyang Liu <seashell11234455@gmail.com>
To: u-boot@lists.denx.de
Cc: Jonas Karlman <jonas@kwiboo.se>, Lukasz Majewski <lukma@denx.de>,
 Marek Vasut <marex@denx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Simon Glass <sjg@chromium.org>,
 Teik Heng Chong <teik.heng.chong@intel.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 2/2] usb: dwc2: Update reset method for host and device mode
Date: Wed, 22 May 2024 22:22:49 +0800
Message-ID: <20240522142311.17351-3-seashell11234455@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240522142311.17351-1-seashell11234455@gmail.com>
References: <20240522142311.17351-1-seashell11234455@gmail.com>
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

Starting from version 4.20a, there has been a change in the reset method.
A new bit, GRSTCTL_CSFTRST_DONE, has been introduced in the GRSTCTL
register to indicate whether the reset has been completed.

This patch mainly refers to the patch in the kernel.
Link: https://lore.kernel.org/all/9be2bb0c728da3dabf634c894f77e0e9709edeaa.1590040892.git.hminas@synopsys.com/

Signed-off-by: Kongyang Liu <seashell11234455@gmail.com>
---

 drivers/usb/common/dwc2_core.c    | 50 +++++++++++++++++++++++++++++++
 drivers/usb/common/dwc2_core.h    |  1 +
 drivers/usb/gadget/dwc2_udc_otg.c |  2 +-
 drivers/usb/host/dwc2.c           | 36 ++--------------------
 4 files changed, 55 insertions(+), 34 deletions(-)

diff --git a/drivers/usb/common/dwc2_core.c b/drivers/usb/common/dwc2_core.c
index 2fa11fd59d..323326e05d 100644
--- a/drivers/usb/common/dwc2_core.c
+++ b/drivers/usb/common/dwc2_core.c
@@ -10,6 +10,56 @@
 
 #include "dwc2_core.h"
 
+int dwc2_core_reset(struct dwc2_core_regs *regs)
+{
+	u32 snpsid;
+	int ret;
+	bool host_mode = false;
+
+	if (!(readl(&regs->global_regs.gotgctl) & GOTGCTL_CONID_B) ||
+	    (readl(&regs->global_regs.gusbcfg) & GUSBCFG_FORCEDEVMODE))
+		host_mode = true;
+
+	/* Core Soft Reset */
+	snpsid = readl(&regs->global_regs.gsnpsid);
+	writel(GRSTCTL_CSFTRST, &regs->global_regs.grstctl);
+	if (FIELD_GET(GSNPSID_VER_MASK, snpsid) < 0x420a) {
+		ret = wait_for_bit_le32(&regs->global_regs.grstctl, GRSTCTL_CSFTRST,
+					false, 1000, false);
+		if (ret) {
+			log_warning("%s: Waiting for GRSTCTL_CSFTRST timeout\n", __func__);
+			return -EBUSY;
+		}
+	} else {
+		ret = wait_for_bit_le32(&regs->global_regs.grstctl, GRSTCTL_CSFTRST_DONE,
+					true, 1000, false);
+		if (ret) {
+			log_warning("%s: Waiting for GRSTCTL_CSFTRST_DONE timeout\n", __func__);
+			return -EBUSY;
+		}
+		clrsetbits_le32(&regs->global_regs.grstctl, GRSTCTL_CSFTRST, GRSTCTL_CSFTRST_DONE);
+	}
+
+	/* Wait for AHB master IDLE state. */
+	ret = wait_for_bit_le32(&regs->global_regs.grstctl, GRSTCTL_AHBIDLE,
+				true, 1000, false);
+	if (ret) {
+		log_warning("%s: Waiting for GRSTCTL_AHBIDLE timeout\n", __func__);
+		return -EBUSY;
+	}
+
+	if (host_mode) {
+		ret = wait_for_bit_le32(&regs->global_regs.gintsts, GINTSTS_CURMODE_HOST,
+					host_mode, 1000, false);
+		if (ret) {
+			log_warning("%s: Waiting for GINTSTS_CURMODE_HOST timeout\n", __func__);
+			return -EBUSY;
+		}
+	}
+
+	return 0;
+}
+
 void dwc2_flush_tx_fifo(struct dwc2_core_regs *regs, const int num)
 {
 	int ret;
diff --git a/drivers/usb/common/dwc2_core.h b/drivers/usb/common/dwc2_core.h
index 8303153446..dd6937dd30 100644
--- a/drivers/usb/common/dwc2_core.h
+++ b/drivers/usb/common/dwc2_core.h
@@ -123,6 +123,7 @@ struct dwc2_core_regs {
 	u8  ep_fifo[16][0x1000];
 };
 
+int dwc2_core_reset(struct dwc2_core_regs *regs);
 void dwc2_flush_tx_fifo(struct dwc2_core_regs *regs, const int num);
 void dwc2_flush_rx_fifo(struct dwc2_core_regs *regs);
 
diff --git a/drivers/usb/gadget/dwc2_udc_otg.c b/drivers/usb/gadget/dwc2_udc_otg.c
index ac902b325a..727832e859 100644
--- a/drivers/usb/gadget/dwc2_udc_otg.c
+++ b/drivers/usb/gadget/dwc2_udc_otg.c
@@ -469,7 +469,7 @@ static void reconfig_usbd(struct dwc2_udc *dev)
 	u32 max_hw_ep;
 	int pdata_hw_ep;
 
-	writel(GRSTCTL_CSFTRST, &reg->global_regs.grstctl);
+	dwc2_core_reset(reg);
 
 	debug("Resetting OTG controller\n");
 
diff --git a/drivers/usb/host/dwc2.c b/drivers/usb/host/dwc2.c
index 93ed9604c2..6e73a3d90d 100644
--- a/drivers/usb/host/dwc2.c
+++ b/drivers/usb/host/dwc2.c
@@ -109,36 +109,6 @@ static void init_fslspclksel(struct dwc2_core_regs *regs)
 			FIELD_PREP(HCFG_FSLSPCLKSEL_MASK, phyclk));
 }
 
-/*
- * Do core a soft reset of the core.  Be careful with this because it
- * resets all the internal state machines of the core.
- */
-static void dwc_otg_core_reset(struct udevice *dev,
-			       struct dwc2_core_regs *regs)
-{
-	int ret;
-
-	/* Wait for AHB master IDLE state. */
-	ret = wait_for_bit_le32(&regs->global_regs.grstctl, GRSTCTL_AHBIDLE,
-				true, 1000, false);
-	if (ret)
-		dev_info(dev, "%s: Timeout!\n", __func__);
-
-	/* Core Soft Reset */
-	writel(GRSTCTL_CSFTRST, &regs->global_regs.grstctl);
-	ret = wait_for_bit_le32(&regs->global_regs.grstctl, GRSTCTL_CSFTRST,
-				false, 1000, false);
-	if (ret)
-		dev_info(dev, "%s: Timeout!\n", __func__);
-
-	/*
-	 * Wait for core to come out of reset.
-	 * NOTE: This long sleep is _very_ important, otherwise the core will
-	 *       not stay in host mode after a connector ID change!
-	 */
-	mdelay(100);
-}
-
 #if CONFIG_IS_ENABLED(DM_USB) && defined(CONFIG_DM_REGULATOR)
 static int dwc_vbus_supply_init(struct udevice *dev)
 {
@@ -311,7 +281,7 @@ static void dwc_otg_core_init(struct udevice *dev)
 	writel(usbcfg, &regs->global_regs.gusbcfg);
 
 	/* Reset the Controller */
-	dwc_otg_core_reset(dev, regs);
+	dwc2_core_reset(regs);
 
 	/*
 	 * This programming sequence needs to happen in FS mode before
@@ -323,7 +293,7 @@ static void dwc_otg_core_init(struct udevice *dev)
 	setbits_le32(&regs->global_regs.gusbcfg, GUSBCFG_PHYSEL);
 
 	/* Reset after a PHY select */
-	dwc_otg_core_reset(dev, regs);
+	dwc2_core_reset(regs);
 
 	/*
 	 * Program DCFG.DevSpd or HCFG.FSLSPclkSel to 48Mhz in FS.
@@ -369,7 +339,7 @@ static void dwc_otg_core_init(struct udevice *dev)
 	writel(usbcfg, &regs->global_regs.gusbcfg);
 
 	/* Reset after setting the PHY parameters */
-	dwc_otg_core_reset(dev, regs);
+	dwc2_core_reset(regs);
 #endif
 
 	usbcfg = readl(&regs->global_regs.gusbcfg);
-- 
2.41.0

