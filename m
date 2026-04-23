Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 712E4FF885C
	for <u-boot@archiver.kernel.org>; Sat, 25 Apr 2026 20:36:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 83CC18445D;
	Sat, 25 Apr 2026 22:36:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="SnMzWLY4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3E8298448C; Sat, 25 Apr 2026 20:31:19 +0200 (CEST)
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com
 [IPv6:2a00:1450:4864:20::130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 36DC184445
 for <u-boot@lists.denx.de>; Sat, 25 Apr 2026 20:31:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=micbis.openwrt@gmail.com
Received: by mail-lf1-x130.google.com with SMTP id
 2adb3069b0e04-5a0faa0d15cso8713243e87.0
 for <u-boot@lists.denx.de>; Sat, 25 Apr 2026 11:31:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777141876; x=1777746676; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NjMV4plsEVdtD/IjRw5vFgk17+txSXm8V6nD6TA2L9o=;
 b=SnMzWLY4h4TqOq8wxcgvVDYWG3Ue0/Vb4pzVetZTsp04QbbdeEi7wWjnOLVoumKuHG
 45s2gbYcAOjeWPZpgj5QlqttLzTpOAZ88A1QiOjfWh8HDWfRZim/zLiNWwZAe9yGeFK3
 UyuiCX0iSE990KQ/kOOvtvJy7dIvqkyUlU5x4SW5/9Tk5CLgl9ywvHwCiBRlvbvjLs8T
 gcWri4NZRYsruUH/r0K0MPHWhdHfoBbdZaH88awyBNDQj9kL6bu523v4PIizq8cLcBHi
 U0SEltORHph4RNAowAp7W0lz8qClgb89T2VQwXio458zXAVWOjRpjCWDgSNLFkpe8Yyg
 sjOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777141876; x=1777746676;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=NjMV4plsEVdtD/IjRw5vFgk17+txSXm8V6nD6TA2L9o=;
 b=TbkNCyTRldK8ZQ8uUlpa3Zez/kTG99gIhx0XhtgpkQoDTPlyrnKk8S8XHmHErtD5zH
 mVrMtCuNj+ye2Tbg4T3G59XKYfBPcrkwy222cJaBehrcxdNY4NuakXYdb/6yGxXgnLuV
 q/5CcVdPhWpvbfHRalPW+fkK+XXtCt5Cfd86wl+KCj/ukr40DmFIIayVfpMwip37oDn2
 LcpX29jtywlcO/R1mumxy9LUYGx/sZNOO/BhmeQyaMyhY4bu8DXuq3vb/toQh12CTX2F
 YjMyUb+SBvECPclzF2b7gDr481ieL4z7iJo68STguz8r9+HN1p9IjN9fAdoXewdhBEbl
 pyBQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ/bdyEtucRcbL0ptD/ucTJlMOCfVbt3Q4g9KaM+GREqWpBDIHaj2mPYuSTFSlMNpR5ALHNoWBo=@lists.denx.de
X-Gm-Message-State: AOJu0YwtJGP7Ou+GnYQZ5MOFU5QhIg3XiWaMqXY93VUuXOcDBwnVwgFL
 8+7J9gQRWrTppHdltcgmr27KSMcW7ISCux6Y/q7coBDvpmAnxBl2DH7uuSrJdw==
X-Gm-Gg: AeBDieuZ1k0YfEF5UcjbBjDZFPyOU7k0TqLdr9KwQFaBqhJMnFGboobk5SPsZE98f8U
 Bbq9wkhPmvWAHQuvX7L0dWxRF4trBmo58EeoilRVTVQJLMgUjsyJgvHKEQ078o9tbszuylwl+E3
 XRDKYjjqpwQFUCDryH4GzyBpycOtQaSpTMAN009nGQMJB/FgItGJdjLHW2B0hs/xJ+B5qTOwYUz
 Hx4/9wMF/PiUy8nypLjhneMQgSVsM8dsoY8ApjFQl1MwYwPcdOdK8KleV/YNhmvdbkcQde5+Vtm
 vqOm+TQ69AMkFRAV4XDJHer0Rtb1jfMzVJTT/iBukmlQDvwolXYAyr4jgaWldPzC4g0OsZ5WR68
 mbbEqDiSw7rVIdiWG2/hCf6Q88CqfOio4NNl8QvOfvKqHfE+sch7qt764etJ+bbubDOkf6EoM7A
 ExRwPRYnBwRSEgbBiSj7aSl2CX4gprFIRzk4cAn6gp37skqcS525Q=
X-Received: by 2002:a05:600c:8b38:b0:485:39b2:a47c with SMTP id
 5b1f17b1804b1-488fb796fa0mr370060265e9.25.1776949428260; 
 Thu, 23 Apr 2026 06:03:48 -0700 (PDT)
Received: from localhost.localdomain ([151.70.144.55])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488fc0f8188sm549381425e9.2.2026.04.23.06.03.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Apr 2026 06:03:47 -0700 (PDT)
From: Michele Bisogno <micbis.openwrt@gmail.com>
To: Marek Vasut <marex@denx.de>, Lukasz Majewski <lukma@denx.de>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de, Michele Bisogno <micbis.openwrt@gmail.com>
Subject: [PATCH v5 3/3] usb: gadget: rcar: Add support for RZ/G2L (R9A07G044)
Date: Thu, 23 Apr 2026 15:03:23 +0200
Message-Id: <20260423130323.32533-4-micbis.openwrt@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260423130323.32533-1-micbis.openwrt@gmail.com>
References: <20260423130323.32533-1-micbis.openwrt@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 25 Apr 2026 22:36:28 +0200
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

The Renesas RZ/G2L (and RZ/G2LC) USBHS controller requires the
CNEN bit in the SYSCFG register to be set for function operation.
Additionally, its CFIFO is byte-addressable.

Introduce a new renesas_usbhs_driver_param structure for the
RZ/G2L SoC and link it via the udevice_id data pointer. Update
usbhs_probe() to accept the udevice pointer to retrieve these
parameters during initialization.

This alignment follows the logic used in the Linux kernel
renesas_usbhs driver.

Signed-off-by: Michele Bisogno <micbis.openwrt@gmail.com>
---
 drivers/usb/gadget/rcar/common.c      | 20 ++++++++++++++++++++
 drivers/usb/gadget/rcar/renesas_usb.h |  1 +
 2 files changed, 21 insertions(+)

diff --git a/drivers/usb/gadget/rcar/common.c b/drivers/usb/gadget/rcar/common.c
index 32c4f1fadb1..580a0fbf090 100644
--- a/drivers/usb/gadget/rcar/common.c
+++ b/drivers/usb/gadget/rcar/common.c
@@ -92,6 +92,12 @@ void usbhs_sys_function_ctrl(struct usbhs_priv *priv, int enable)
 	u16 mask = DCFM | DRPD | DPRPU | HSE | USBE;
 	u16 val  = HSE | USBE;
 
+	/* CNEN bit is required for function operation */
+	if (usbhs_get_dparam(priv, has_cnen)) {
+		mask |= CNEN;
+		val  |= CNEN;
+	}
+
 	/*
 	 * if enable
 	 *
@@ -363,13 +369,21 @@ static int usbhs_probe(struct udevice *dev)
 {
 	struct usbhs_priv_otg_data *otg_priv = dev_get_priv(dev);
 	struct usbhs_priv *priv = &otg_priv->usbhs_priv;
+	struct renesas_usbhs_driver_param *plat_param;
 	int ret;
 
+	plat_param = (struct renesas_usbhs_driver_param *)dev_get_driver_data(dev);
+
 	priv->dparam.type = USBHS_TYPE_RCAR_GEN3;
 	priv->dparam.pio_dma_border = 64;
 	priv->dparam.pipe_configs = usbhsc_new_pipe;
 	priv->dparam.pipe_size = ARRAY_SIZE(usbhsc_new_pipe);
 
+	if (plat_param) {
+		priv->dparam.has_cnen		= plat_param->has_cnen;
+		priv->dparam.cfifo_byte_addr	= plat_param->cfifo_byte_addr;
+	}
+
 	/* call pipe and module init */
 	ret = usbhs_pipe_probe(priv);
 	if (ret < 0)
@@ -482,8 +496,14 @@ static int usbhs_udc_otg_remove(struct udevice *dev)
 	return dm_scan_fdt_dev(dev);
 }
 
+static struct renesas_usbhs_driver_param rzg2l_param = {
+	.has_cnen = 1,
+	.cfifo_byte_addr = 1,
+};
+
 static const struct udevice_id usbhs_udc_otg_ids[] = {
 	{ .compatible = "renesas,rcar-gen3-usbhs" },
+	{ .compatible = "renesas,rzg2l-usbhs", .data = (unsigned long)&rzg2l_param },
 	{},
 };
 
diff --git a/drivers/usb/gadget/rcar/renesas_usb.h b/drivers/usb/gadget/rcar/renesas_usb.h
index 8155e3dcaf6..140a70251cf 100644
--- a/drivers/usb/gadget/rcar/renesas_usb.h
+++ b/drivers/usb/gadget/rcar/renesas_usb.h
@@ -111,6 +111,7 @@ struct renesas_usbhs_driver_param {
 	u32 has_otg:1; /* for controlling PWEN/EXTLP */
 	u32 has_sudmac:1; /* for SUDMAC */
 	u32 has_usb_dmac:1; /* for USB-DMAC */
+	u32 has_cnen:1;
 	u32 cfifo_byte_addr:1; /* CFIFO is byte addressable */
 #define USBHS_USB_DMAC_XFER_SIZE	32	/* hardcode the xfer size */
 	u32 multi_clks:1;
-- 
2.34.1

