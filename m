Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F95FCD1284
	for <u-boot@archiver.kernel.org>; Thu, 28 Mar 2024 13:22:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C2E4788126;
	Thu, 28 Mar 2024 14:22:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="jXkMlZmJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 68B938811D; Thu, 28 Mar 2024 14:18:31 +0100 (CET)
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com
 [IPv6:2607:f8b0:4864:20::429])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 35F5288150
 for <u-boot@lists.denx.de>; Thu, 28 Mar 2024 14:18:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seashell11234455@gmail.com
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-6e74bd85f26so836914b3a.1
 for <u-boot@lists.denx.de>; Thu, 28 Mar 2024 06:18:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1711631907; x=1712236707; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=kgh4X624ZbUbs210xWPI/kio/prhXZarEdsDAZ0R/V0=;
 b=jXkMlZmJgj8qZoN+l5iiUPKTzYaHPGYmmajPt5sBVPT/7/FHOWOA+rZMOmrbB6tK/z
 ubomZNXOLTcSh4WCIo24bbkyzJxlUTAMQpTERKGWw9B7Uj51nT1QOXAGxua1IjYdeboM
 W4TOao+f4wJaKGCiBroXyCygMHuu9ikJadBCtn4ObWKXq1QA799axiNhE8dfGrLqAbKR
 aoRZztLpmESWHznr309x/JZe7BKzZZxMXzZC5fTMHl9SQBO1l+7kQD6qoGri6C9f3P59
 ikhMXquVC7CwCYkH/6OXt+BBIgcA3AEL1E9f7WkoxhqlVIshqlnz58EMUOZdTstO+BnK
 ADqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711631907; x=1712236707;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=kgh4X624ZbUbs210xWPI/kio/prhXZarEdsDAZ0R/V0=;
 b=RQ2UMpom8U48He345423sHJCGcmJT7jeRnNFTqAXMfoKXpmFmaBXAGCzaVNhFz9J73
 wVgssTMQG+aE+paYa8a7dsjJTEtYPXp/71f/grQlx9nii06byFPdRCr9EPmtmHyhwLFS
 qtvpFJo7Pk6XbSVd35zSNjUWwqsaHeiPfJ0FZBs6vcpWZ2yoyCwlEAd56MecV5Q4oiEk
 sQl8A5ddFLgQT6mhrNY9bRLVH0ACJYf/87vqdClvUhp70PYncUQ3ZgPTTiscJUcmkKoF
 VAdUZYRGr4sfdX+PEwPXjW71h2Xr86m4qXtkpB/QaBO+wXZX3wWb0RsxqY1+19o9BwHU
 fX8w==
X-Gm-Message-State: AOJu0YxKZs/iejR7W84aoLb464KUYOiGU1PiblQ8I7YJf5zJpSfDn1nQ
 Zg1FaDFQBboWfB8S0/UjAAnUqjSbHNkAE9bifuQM272CgGwsgu3D3CVZTd8860M=
X-Google-Smtp-Source: AGHT+IE3W7Mt8JaZzmHZyBVpNmkJuQcVHR8IFg7q2oFvtBCxAqCOeRVRA0xodXtQ0N8CiaYCzpSezw==
X-Received: by 2002:a05:6a20:3d06:b0:1a5:6a09:623d with SMTP id
 y6-20020a056a203d0600b001a56a09623dmr2747226pzi.7.1711631906193; 
 Thu, 28 Mar 2024 06:18:26 -0700 (PDT)
Received: from localhost.localdomain ([117.135.88.116])
 by smtp.gmail.com with ESMTPSA id
 w4-20020a17090aaf8400b002a1f596c1c6sm1308541pjq.48.2024.03.28.06.18.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Mar 2024 06:18:25 -0700 (PDT)
From: Kongyang Liu <seashell11234455@gmail.com>
To: u-boot@lists.denx.de
Cc: Jonas Karlman <jonas@kwiboo.se>, Lukasz Majewski <lukma@denx.de>,
 Marek Vasut <marex@denx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Simon Glass <sjg@chromium.org>,
 Teik Heng Chong <teik.heng.chong@intel.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH] usb: dwc2: update reset method for host and device mode
Date: Thu, 28 Mar 2024 21:14:03 +0800
Message-ID: <20240328131811.94559-1-seashell11234455@gmail.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 28 Mar 2024 14:22:29 +0100
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

Signed-off-by: Kongyang Liu <seashell11234455@gmail.com>
---

 drivers/usb/gadget/dwc2_udc_otg.c      | 18 ++++++++++++++++--
 drivers/usb/gadget/dwc2_udc_otg_regs.h | 19 +++++++++++++------
 drivers/usb/host/dwc2.c                | 19 ++++++++++++++++---
 drivers/usb/host/dwc2.h                |  6 ++++++
 4 files changed, 51 insertions(+), 11 deletions(-)

diff --git a/drivers/usb/gadget/dwc2_udc_otg.c b/drivers/usb/gadget/dwc2_udc_otg.c
index 27082f5152..d1dd469a0f 100644
--- a/drivers/usb/gadget/dwc2_udc_otg.c
+++ b/drivers/usb/gadget/dwc2_udc_otg.c
@@ -42,7 +42,7 @@
 #include <asm/unaligned.h>
 #include <asm/io.h>
 
-#include <asm/mach-types.h>
+#include <wait_bit.h>
 
 #include <power/regulator.h>
 
@@ -464,12 +464,26 @@ static void reconfig_usbd(struct dwc2_udc *dev)
 {
 	/* 2. Soft-reset OTG Core and then unreset again. */
 	int i;
-	unsigned int uTemp = writel(CORE_SOFT_RESET, &reg->grstctl);
+	unsigned int uTemp;
 	uint32_t dflt_gusbcfg;
 	uint32_t rx_fifo_sz, tx_fifo_sz, np_tx_fifo_sz;
 	u32 max_hw_ep;
 	int pdata_hw_ep;
 
+	u32 snpsid, greset;
+
+	snpsid = readl(&reg->gsnpsid);
+	writel(CORE_SOFT_RESET, &reg->grstctl);
+	if ((snpsid & SNPSID_VER_MASK) < (SNPSID_VER_420a & SNPSID_VER_MASK)) {
+		wait_for_bit_le32(&reg->grstctl, CORE_SOFT_RESET, false, 1000, false);
+	} else {
+		wait_for_bit_le32(&reg->grstctl, CORE_SOFT_RESET_DONE, true, 1000, false);
+		greset = readl(&reg->grstctl);
+		greset &= ~CORE_SOFT_RESET;
+		greset |= CORE_SOFT_RESET_DONE;
+		writel(greset, &reg->grstctl);
+	}
+
 	debug("Resetting OTG controller\n");
 
 	dflt_gusbcfg =
diff --git a/drivers/usb/gadget/dwc2_udc_otg_regs.h b/drivers/usb/gadget/dwc2_udc_otg_regs.h
index 9ca6f42375..b3d9117033 100644
--- a/drivers/usb/gadget/dwc2_udc_otg_regs.h
+++ b/drivers/usb/gadget/dwc2_udc_otg_regs.h
@@ -63,24 +63,26 @@ struct dwc2_usbotg_reg {
 	u32 gnptxfsiz; /* Non-Periodic Transmit FIFO Size */
 	u8  res0[12];
 	u32 ggpio;     /* 0x038 */
-	u8  res1[20];
+	u8  res1[4];
+	u32 gsnpsid;
+	u8  res2[12];
 	u32 ghwcfg4; /* User HW Config4 */
-	u8  res2[176];
+	u8  res3[176];
 	u32 dieptxf[15]; /* Device Periodic Transmit FIFO size register */
-	u8  res3[1728];
+	u8  res4[1728];
 	/* Device Configuration */
 	u32 dcfg; /* Device Configuration Register */
 	u32 dctl; /* Device Control */
 	u32 dsts; /* Device Status */
-	u8  res4[4];
+	u8  res5[4];
 	u32 diepmsk; /* Device IN Endpoint Common Interrupt Mask */
 	u32 doepmsk; /* Device OUT Endpoint Common Interrupt Mask */
 	u32 daint; /* Device All Endpoints Interrupt */
 	u32 daintmsk; /* Device All Endpoints Interrupt Mask */
-	u8  res5[224];
+	u8  res6[224];
 	struct dwc2_dev_in_endp in_endp[16];
 	struct dwc2_dev_out_endp out_endp[16];
-	u8  res6[768];
+	u8  res7[768];
 	struct ep_fifo ep[16];
 };
 
@@ -118,6 +120,7 @@ struct dwc2_usbotg_reg {
 /* DWC2_UDC_OTG_GRSTCTL */
 #define AHB_MASTER_IDLE		(1u<<31)
 #define CORE_SOFT_RESET		(0x1<<0)
+#define CORE_SOFT_RESET_DONE		(0x1<<29)
 
 /* DWC2_UDC_OTG_GINTSTS/DWC2_UDC_OTG_GINTMSK core interrupt register */
 #define INT_RESUME			(1u<<31)
@@ -285,6 +288,10 @@ struct dwc2_usbotg_reg {
 #define DAINT_IN_EP_INT(x)                        (x << 0)
 #define DAINT_OUT_EP_INT(x)                       (x << 16)
 
+/* DWC2_UDC_OTG_GSNPSID */
+#define SNPSID_VER_420a					0x4f54420a
+#define SNPSID_VER_MASK					0xffff
+
 /* User HW Config4 */
 #define GHWCFG4_NUM_IN_EPS_MASK		(0xf << 26)
 #define GHWCFG4_NUM_IN_EPS_SHIFT	26
diff --git a/drivers/usb/host/dwc2.c b/drivers/usb/host/dwc2.c
index 637eb2dd06..1baeff96ee 100644
--- a/drivers/usb/host/dwc2.c
+++ b/drivers/usb/host/dwc2.c
@@ -159,6 +159,7 @@ static void dwc_otg_core_reset(struct udevice *dev,
 			       struct dwc2_core_regs *regs)
 {
 	int ret;
+	u32 snpsid, greset;
 
 	/* Wait for AHB master IDLE state. */
 	ret = wait_for_bit_le32(&regs->grstctl, DWC2_GRSTCTL_AHBIDLE,
@@ -167,9 +168,20 @@ static void dwc_otg_core_reset(struct udevice *dev,
 		dev_info(dev, "%s: Timeout!\n", __func__);
 
 	/* Core Soft Reset */
+	snpsid = readl(&regs->gsnpsid);
 	writel(DWC2_GRSTCTL_CSFTRST, &regs->grstctl);
-	ret = wait_for_bit_le32(&regs->grstctl, DWC2_GRSTCTL_CSFTRST,
-				false, 1000, false);
+	if ((snpsid & DWC2_SNPSID_VER_MASK) < (DWC2_SNPSID_DEVID_VER_420a & DWC2_SNPSID_VER_MASK)) {
+		ret = wait_for_bit_le32(&regs->grstctl, DWC2_GRSTCTL_CSFTRST,
+					false, 1000, false);
+	} else {
+		ret = wait_for_bit_le32(&regs->grstctl, DWC2_GRSTCTL_GSFTRST_DONE,
+					true, 1000, false);
+		greset = readl(&regs->grstctl);
+		greset &= ~DWC2_GRSTCTL_CSFTRST;
+		greset |= DWC2_GRSTCTL_GSFTRST_DONE;
+		writel(greset, &regs->grstctl);
+	}
+
 	if (ret)
 		dev_info(dev, "%s: Timeout!\n", __func__);
 
@@ -1180,7 +1192,8 @@ static int dwc2_init_common(struct udevice *dev, struct dwc2_priv *priv)
 		 snpsid >> 12 & 0xf, snpsid & 0xfff);
 
 	if ((snpsid & DWC2_SNPSID_DEVID_MASK) != DWC2_SNPSID_DEVID_VER_2xx &&
-	    (snpsid & DWC2_SNPSID_DEVID_MASK) != DWC2_SNPSID_DEVID_VER_3xx) {
+		(snpsid & DWC2_SNPSID_DEVID_MASK) != DWC2_SNPSID_DEVID_VER_3xx &&
+	    (snpsid & DWC2_SNPSID_DEVID_MASK) != DWC2_SNPSID_DEVID_VER_4xx) {
 		dev_info(dev, "SNPSID invalid (not DWC2 OTG device): %08x\n",
 			 snpsid);
 		return -ENODEV;
diff --git a/drivers/usb/host/dwc2.h b/drivers/usb/host/dwc2.h
index 6f022e33a1..e1f0f59b82 100644
--- a/drivers/usb/host/dwc2.h
+++ b/drivers/usb/host/dwc2.h
@@ -207,6 +207,8 @@ struct dwc2_core_regs {
 #define DWC2_GRSTCTL_TXFFLSH_OFFSET			5
 #define DWC2_GRSTCTL_TXFNUM_MASK			(0x1F << 6)
 #define DWC2_GRSTCTL_TXFNUM_OFFSET			6
+#define DWC2_GRSTCTL_GSFTRST_DONE			(1 << 29)
+#define DWC2_GRSTCTL_GSFTRST_DONE_OFFSET	29
 #define DWC2_GRSTCTL_DMAREQ				(1 << 30)
 #define DWC2_GRSTCTL_DMAREQ_OFFSET			30
 #define DWC2_GRSTCTL_AHBIDLE				(1 << 31)
@@ -739,8 +741,12 @@ struct dwc2_core_regs {
 #define DWC2_PCGCCTL_DEEP_SLEEP_OFFSET			7
 #define DWC2_SNPSID_DEVID_VER_2xx			(0x4f542 << 12)
 #define DWC2_SNPSID_DEVID_VER_3xx			(0x4f543 << 12)
+#define DWC2_SNPSID_DEVID_VER_4xx			(0x4f544 << 12)
+#define DWC2_SNPSID_DEVID_VER_420a			0x4f54420a
 #define DWC2_SNPSID_DEVID_MASK				(0xfffff << 12)
 #define DWC2_SNPSID_DEVID_OFFSET			12
+#define DWC2_SNPSID_VER_MASK				0xffff
+#define DWC2_SNPSID_VER_OFFSET				0
 
 /* Host controller specific */
 #define DWC2_HC_PID_DATA0		0
-- 
2.41.0

