Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA8CBFF8860
	for <u-boot@archiver.kernel.org>; Sat, 25 Apr 2026 18:07:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8B867844FF;
	Sat, 25 Apr 2026 20:03:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="s/1b4pa1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E7C838435B; Sat, 25 Apr 2026 19:51:21 +0200 (CEST)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com
 [IPv6:2a00:1450:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C818184308
 for <u-boot@lists.denx.de>; Sat, 25 Apr 2026 19:51:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=micbis.openwrt@gmail.com
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-b9c9d03524cso1233940766b.3
 for <u-boot@lists.denx.de>; Sat, 25 Apr 2026 10:51:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777139479; x=1777744279; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZoydWEKnN0EEChvkfKpSzrThS6WCboZ434hrmvxtqvU=;
 b=s/1b4pa16MHWxiuy2ZPB3Ml++iNlmAREr1lrXjnuTqxrhYoN95rJCVl9hwykjduHMW
 mwgmaPn2VB9NY364CfeZhmeOeLiwAqSdpavOONlBFTOxHtPqLhVwigga1pux4fONZAYk
 gg+y9bq5C1rSbg7vbXIu+M6VGFejELGIDDTrNxWp3bXhnJoZjipCHpB4V1uNalwTeDWC
 lpBOWa7Vw/tqo6X6tn0NXSTazZdexQLV3wVqaPLnHSxwmc6hdEQxjgdsCWopL6x46Nvl
 dvajSCP6VkFz8HBKIZnlwG0i57BHmIyc+opJSrT/p1F5FsYdZ7wsKYwKaDTBo9g/NHYX
 7Wcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777139479; x=1777744279;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ZoydWEKnN0EEChvkfKpSzrThS6WCboZ434hrmvxtqvU=;
 b=SmvhR4sEpFmLQ30Ju0J+Q9oW/ZvM8hPmLIL5pcRbw5LSjdLczwRmzul+mX3Um3eTY1
 YI9ADwkhN2A8nxDLYRoRLdbEWOpCLlL0UsfMiSqwJ8TRVfWUHCgYdXgBn39nrrOyCwrV
 n1R7FfMa/Aw3J5BObBWM8kzJtJmE11uEf19jnFPJ5gQahBMcc1AhJfJ8dRBQOCvJGmpe
 29G9LVvZRZq5jf8oOuuLE9mO+Ah3yxIdRKTIhcZH1AKK6bVy+P8EgQfMX7oAlXMkWc/J
 LmY2go+5KE2lvxQca0IPzS7Ps0CYO9CeJdAJou05ytz9Pmgr6by1K34l9q1+J02NUQoZ
 wvAg==
X-Forwarded-Encrypted: i=1;
 AFNElJ+2vnk9oneKhuajXB4UkeiWkeOK0e52YOqI6f0uCoG4ZTAa8RXVINBsMHoRYzldXIDYg4NA7xE=@lists.denx.de
X-Gm-Message-State: AOJu0Yw9MNLnxnUENvMo6PtsOdgHqnzaw9tr+wPLjiNIQ4AfhXzL1X5b
 c7ihTfqN0CahSJ1CWdJNlNERKrGZv21D69+qqh4KCst/plvNRdRw3MFQdOHI6g==
X-Gm-Gg: AeBDieudy1ewYVcxzatQIp/Y5PosKhQKDM1O3CJapvie0A/LuSmdUvlS25T7dBeaecW
 6573FF2UKRV+FEGurbPCBMImZ9fZWDaO31BkdmL2cWqNfxIPMqz1gyQvouWHuwl1SOvNhsFPmhC
 2m7DK84pcX2j1qn2rYIQcbCf27eInKLC6puKr2V+cqHNEKsPTdCzPYpUBraJ4Gm5xaFKP6nNbll
 +b7ACLcldl8vhmRBm7ABMdBxc/dpuT/I9zEiYkds7xkEqYTpskozmkIi8xRlvleJMX3J8D3gg8G
 ML8TK2RDTv5x/IcWktIxteIx4LVnsh0Tm5Fb8o1ewGuguF9XyrrfvLQuoIrEIFlZ17NBcwzA8+N
 n2tTqGWlImzhJj2mBq0oPjlcvdfNuLIQAhC5LC4OI5CmJYdhUydA6GO19bbhan9cT4LOzvGc1Op
 HG9jFmW+NGlYRxDB/7ryiaiUQzK+o79TvQ55LNx/la7u9fmeLs7C8=
X-Received: by 2002:a05:600c:a40a:b0:489:1ba8:5bf0 with SMTP id
 5b1f17b1804b1-4891ba85dc1mr289191445e9.21.1777046648285; 
 Fri, 24 Apr 2026 09:04:08 -0700 (PDT)
Received: from localhost.localdomain ([151.70.144.55])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488fc10777csm678783845e9.8.2026.04.24.09.04.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Apr 2026 09:04:07 -0700 (PDT)
From: Michele Bisogno <micbis.openwrt@gmail.com>
To: Marek Vasut <marex@denx.de>, Lukasz Majewski <lukma@denx.de>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de, Michele Bisogno <micbis.openwrt@gmail.com>
Subject: [PATCH v6 3/3] usb: gadget: rcar: Add support for RZ/G2L (R9A07G044)
Date: Fri, 24 Apr 2026 18:03:16 +0200
Message-Id: <20260424160316.157380-4-micbis.openwrt@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260424160316.157380-1-micbis.openwrt@gmail.com>
References: <20260424160316.157380-1-micbis.openwrt@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 25 Apr 2026 20:03:18 +0200
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

Reviewed-by: Marek Vasut <marex@denx.de>
Signed-off-by: Michele Bisogno <micbis.openwrt@gmail.com>
---
 drivers/usb/gadget/rcar/common.c      | 20 ++++++++++++++++++++
 drivers/usb/gadget/rcar/renesas_usb.h |  1 +
 2 files changed, 21 insertions(+)

diff --git a/drivers/usb/gadget/rcar/common.c b/drivers/usb/gadget/rcar/common.c
index 2bf0dcff393..10548f7a20c 100644
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
@@ -487,8 +501,14 @@ static int usbhs_udc_otg_remove(struct udevice *dev)
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

