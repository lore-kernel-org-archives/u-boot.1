Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A38A5FF885C
	for <u-boot@archiver.kernel.org>; Sun, 26 Apr 2026 12:58:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1FEA484236;
	Sun, 26 Apr 2026 14:57:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Y2eU4Q/l";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 40AD183FDB; Sun, 26 Apr 2026 09:43:49 +0200 (CEST)
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com
 [IPv6:2a00:1450:4864:20::436])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4A12084099
 for <u-boot@lists.denx.de>; Sun, 26 Apr 2026 09:43:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=micbis.openwrt@gmail.com
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-43cff5dafc3so7422246f8f.1
 for <u-boot@lists.denx.de>; Sun, 26 Apr 2026 00:43:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777189426; x=1777794226; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Vii78QSacJV1ZxRs54cdKTErvvE80c9Ic7dmrVel/eA=;
 b=Y2eU4Q/lOKpkANoNQWrMNEr4iIFErLQgQhKYVH/clbxdQN/QkWqdVN9vZR3M0kgbQU
 Kxe6u7kHcwuKXrZ9s6Dso220JFi+EBzeN2UuXKvncjJwxeOdCftX3zOdlEATLiiPBY7V
 YqmOAzjm+lCEHM0teeblf1tryOCxBYiSDoKhsV1Im02SuD0WTIbLy/duNItAdHcA0ymp
 nWOjB4sU3lI/Q0r5U9SKr1GFJhEhhdDTVzmV8OqLwV74OCR8ypPcO6J1UTAnasPKrnsb
 xf0ZI3uwdpgMf5ZAL3RfV71K4tmCm88kSiW4WKOD0zOEvW9XvZdzno7myWJ+IwkcsKh8
 IuJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777189426; x=1777794226;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Vii78QSacJV1ZxRs54cdKTErvvE80c9Ic7dmrVel/eA=;
 b=ZOlvb16xsgO0naEIfboRjm0NTaX+FlQkS3wmVCNAnvwuZ4sCD6qovkJO7wAi+g1Mv2
 dv98I9f5hmu1e/HQxKU5ER6cyvzeVZGtFFbptIRtGCiiKsDUdCFA151kYyskZ7jVzyKa
 d7QppF65/VeXHVq9tjhF8zLJe57cAb328HWgDcamOIOXJszpAj5+/8ZjiyZmMQxlmkhd
 pufrd3gd5iam5y9sA5qVZ/b3BEkzQDGnHhB0V+ympxBK7WTIHQIcqxv2AUG6Kcg4GrYB
 5brjkwmKgaW//EyKrECfSJ12bEbN/62gFGTG0QIs0PKlKeldvEe8IC9k31bLE4+xo/3X
 S9JQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ8OL85ITOaveP06A45RbS9Vdj0vr9JrrYZniiS784rAgmJz3svzmdS/TpS4GTLjKsuxdCgDV2Q=@lists.denx.de
X-Gm-Message-State: AOJu0Yyek1PbT1f+eWN24cE/9n1V4apf6NWCiGvWDmSTp0/kMT0ByTEz
 P6oG8A7a7rVTnZ+rgrXqKeCwGqK6tFs3w0cYUtbMstb7dTgtrRuNtHs9
X-Gm-Gg: AeBDieum/UcstqlrlnjO2XW4JpBgPRY/Zn3+z3chCc8YVw8TQbwngaPQDiBo2caoZbl
 tzWCX5qmbzMVzYgg+DnPuwBIUuCKVYJoPzpDtBt8kAaPGQeRXxXi4jy8tSzxDfbt82hm964BXyZ
 OjXxWFJCQJrdv7fMwS3CyF4LLscoMZEp4E2vn6vEIVVj7RTzbveQolQdEYylVz3K8IRfQ6I5dzp
 yqLFMse8aF961pdbFqdFsTWLV05c9MJodURBr7n+hywz6MeYUBfMmrhoXridoceYEAbSu4Gv2Rm
 LUOUBWSz05/pu8tUjbcjEyHC9wmCCp1CelxYt5vsznr5lGSoWECwtRr+DAHhBcNG9pgMBRfNOWa
 CEFBk6xbtjaW90w0LuCdhvMNecIeewgnXwTGks/G+yvm3JzslJqMQZ7nfND91ktanW33bhNRqg7
 YcReFe5vx9U8ixJxdm4a+lnqxCjHu7ox/srsXzux5iAw0kvCiugWWZBAuhur8caw==
X-Received: by 2002:a05:6000:4283:b0:43d:7ea1:fb53 with SMTP id
 ffacd0b85a97d-43fe3e15f7emr59527822f8f.33.1777189425603; 
 Sun, 26 Apr 2026 00:43:45 -0700 (PDT)
Received: from localhost.localdomain ([151.70.144.55])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43fe4cb1365sm76748031f8f.7.2026.04.26.00.43.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 26 Apr 2026 00:43:45 -0700 (PDT)
From: Michele Bisogno <micbis.openwrt@gmail.com>
To: Marek Vasut <marex@denx.de>, Lukasz Majewski <lukma@denx.de>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de, Michele Bisogno <micbis.openwrt@gmail.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: [PATCH v7 3/3] usb: gadget: rcar: Add support for RZ/G2L (R9A07G044)
Date: Sun, 26 Apr 2026 09:43:19 +0200
Message-Id: <20260426074319.5819-4-micbis.openwrt@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260426074319.5819-1-micbis.openwrt@gmail.com>
References: <20260426074319.5819-1-micbis.openwrt@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sun, 26 Apr 2026 14:57:25 +0200
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

Reviewed-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
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

