Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FE68FA1FED
	for <u-boot@archiver.kernel.org>; Wed, 22 Apr 2026 20:21:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2BA54843F3;
	Wed, 22 Apr 2026 22:21:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="a6d+P+Jk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8B57E8426E; Wed, 22 Apr 2026 19:00:43 +0200 (CEST)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 86DBD8432A
 for <u-boot@lists.denx.de>; Wed, 22 Apr 2026 19:00:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=micbis.openwrt@gmail.com
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4890098abbaso41174265e9.0
 for <u-boot@lists.denx.de>; Wed, 22 Apr 2026 10:00:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776877237; x=1777482037; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CIDlrSCi8FMo3wuC+u/3xV/rhNgAd01XIMZlq0t4/K0=;
 b=a6d+P+JkHgu8dugiaHTErAtXH6rIixiosZhn6zy2fs+F1NSVIAOJcLQCx/d2MDTFQD
 kXmtwucirVLUYC6qIKsSKNerxMI0mFJnYskJTxd6FJVHrrwodqGVutfuftBcotOW3MZX
 FDV/olNRQkz2r2i38qRibK/JRGEm+vobrnt6If5fdEXPvUFR/4DJH8NutnbwvVQBYAxY
 YMd0AjSynZDQFlX5hXRr+5xAMOPO+HyXFswz98Gxc3YGaFgyHquDKzVldY2KHVUsscjV
 cq8Q6B2PUQhWoxe0dbcaTVFMChhJnDm5YHSagYtmh537h4o5QPJKhCcf0hpDfRFpjpIN
 etqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776877237; x=1777482037;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=CIDlrSCi8FMo3wuC+u/3xV/rhNgAd01XIMZlq0t4/K0=;
 b=jTRajbTvohdO8YaaavZLpDQUG6MXhmWWtepBlkAQJZBestKdbGOtCWUnVbmZPyO5qR
 hy6bK3uOnBtEjUkEP6vPFV6FFzCaZsw+dpYM6+V2wOYpyZSlj7AvPvxleQECozbUYarh
 4Tn7ECYTA6HVx7oFC6rwNq43edLFaxA+biW0GmVLDzK+nmfYPaWnPDnCeKatok+XHFnx
 ygudbw2eLRmg1c9KNj0U6nd8DNNuBX48UtudeEsNhwsph7EV7qmC8Ppqr8wPKxQ6BdNo
 VFpJ4zbwQvfgLu29nw4TX1UBc/BPtuKhfNbMaRaz+x5f/keJ8bN3U9GMRlEAQmPHOv4K
 ItIw==
X-Forwarded-Encrypted: i=1;
 AFNElJ+OGR5vGVq/PMI5dImrJhf1e/NzVWltOsH7Y8oanvnk0ySgHStYSwrhivmaM1Y/KpAGba2TICQ=@lists.denx.de
X-Gm-Message-State: AOJu0Yz52v39nePJo0IA+UR1ciL+JFXBhhEKBrAx+1nr08NYyCPzjQVq
 2Rn4AeuAw1cRrwQmWkbsPwfsbs5L/I7V/UXCBvtUQslrAoG8pOQ8/Smt
X-Gm-Gg: AeBDiesYgk6QCfikM3jhI5524YtlULabPP91qHhEZu6SbfoncUlu+qA4MsWlTdNklQf
 U6EedpRfQ2Kd/qovYaBmdzKIR/0nwEScx8NKthLICz+ptiFNL+7yw4ujhaVrM3Baulo4bnG3sY+
 h94lCimbKDGI7cfUIrkrFuCKhgIubdvlKpiPjaeAHn6Fd/ZiFbrMTkacKRkqj0lk3xYGGw+OBfk
 49D3udEk7XXoMCRMxM70b8Qr3VTLtUh2+1uo9fSNL9GkVt8f/SNy2h5x19thNsZx/jsDYVXPGd1
 z7Z3Qofpl0mv10zfsBMSPgXvJucLNlBVOkzVD454avkajCZts+PUKMENFmOZTyBgfxnU8b9HLKZ
 m+jPZ/gE9oDG87pUEcBnqmKKjL1KMOHmc4Eu20xxkHti9FiPqhWH8Ytw1lsdHBjWyxoQnPYX+jm
 b8YZj3dbIOF5TQDn4QUsTbq+Nz9rlVY+kLKAAsEsu6BwS3A6Ly+jDjREMx3JegTA==
X-Received: by 2002:a05:600c:2d09:b0:489:c57:7836 with SMTP id
 5b1f17b1804b1-4890c5778ffmr132582975e9.27.1776877236543; 
 Wed, 22 Apr 2026 10:00:36 -0700 (PDT)
Received: from localhost.localdomain ([151.70.144.55])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4891c08faffsm453725165e9.1.2026.04.22.10.00.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Apr 2026 10:00:35 -0700 (PDT)
From: Michele Bisogno <micbis.openwrt@gmail.com>
To: Marek Vasut <marex@denx.de>, Lukasz Majewski <lukma@denx.de>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de, Michele Bisogno <micbis.openwrt@gmail.com>
Subject: [PATCH v4 3/3] usb: gadget: rcar: Add support for RZ/G2L (R9A07G044)
Date: Wed, 22 Apr 2026 18:59:38 +0200
Message-Id: <20260422165938.35925-4-micbis.openwrt@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260422165938.35925-1-micbis.openwrt@gmail.com>
References: <20260422165938.35925-1-micbis.openwrt@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 22 Apr 2026 22:21:26 +0200
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
index a5d56f8dbe4..051cab8a422 100644
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
@@ -361,13 +367,21 @@ static int usbhs_udc_otg_gadget_handle_interrupts(struct udevice *dev)
 
 static int usbhs_probe(struct usbhs_priv *priv, struct udevice *dev)
 {
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
@@ -479,8 +493,14 @@ static int usbhs_udc_otg_remove(struct udevice *dev)
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

