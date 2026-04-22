Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E58CF9EDE0
	for <u-boot@archiver.kernel.org>; Wed, 22 Apr 2026 14:45:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2D16F843C1;
	Wed, 22 Apr 2026 16:45:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="najfCk+m";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BF6778423E; Wed, 22 Apr 2026 16:05:49 +0200 (CEST)
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com
 [IPv6:2607:f8b0:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CA59F83BC8
 for <u-boot@lists.denx.de>; Wed, 22 Apr 2026 16:05:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=happycpu@gmail.com
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-2b24fede2acso35182425ad.3
 for <u-boot@lists.denx.de>; Wed, 22 Apr 2026 07:05:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776866743; x=1777471543; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ml/bsnAFQ5Lz4giXYNMqlsd69NRZTKmQ2CDHoyiM1vA=;
 b=najfCk+mdVpVh7CcsUK1u2+UuYj2YqGVRIiX+D8eUGNABq7vMuJ4Pp7ypMXIqSfylF
 v9J/5if5lmtlS3XWcGBwokuk2Or6k6B2DW9hggo8oxxgHR5s30BnnKzpeXOKn3HJdRp6
 4W5ttk7NfRf0H6RIgYEug/kMBjrQmHUfG03alR3LNVStgum3RThOncSWGWAyefQnLicI
 ZdA6fTR2pYGyhVl/oZ+3H2zBS8bQHwSCMQq6WXVvwhVqbCUiU2vVmBGkHYu10pMvo2W7
 3eUsirOJdfPIFJsMpfygC3aWixk5crfgAUA4Ty4hLY1PNRUBoazF7e+S8i7ld8KFMNBj
 5fvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776866743; x=1777471543;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ml/bsnAFQ5Lz4giXYNMqlsd69NRZTKmQ2CDHoyiM1vA=;
 b=fT/8/oQKKmhx51/aoq9sjIXzz2EPWZxihH6cqHOcDcIslb9+EpxGCSHGQGaEOy3AU3
 oFYWNKO17Igqh91WmXr1FXxIVmPN824ROvN4J+KDyJOmnySbWe5PkUd+iXtH1LvHVO53
 1c4DTYNMizhdWXsDqPDHKJrHD6sLRJQSltrqnJ7cu7t7MazbN24eoEZFNiKZpZbRmPai
 3rVv51fIvhw5+QNKPKIY9jYTPXJ6tw3CiPTHWNfIDfc1x2iyd7mJEjZhrN2Y7GgliHD4
 NhLENgYPATO9fy8MBfnoQqgVDCEMMMNSAB1UY+4zWnqxUZVGR39QnGiX4QgSweUkWmVV
 b7sg==
X-Gm-Message-State: AOJu0YydUkHRBYp45EduCcs3/jmu37rhHY9DXiN0NpCBLbY/WNzz67Gx
 2jOtyTrYoesF08G5SqCkFDHjsNnwP83OZDWURspHX2GBQ8Jrzd6jSoYcU8N4Tw==
X-Gm-Gg: AeBDieugIf+aRqVa+ZczokUBvFmTYMoHXxk7MJpBWNyzBJ7wu4f4FdcEAxShq+6J8/1
 prm+zDyiFyejRSefDH6ydMfjdybKBOxZjn9LHDaySOgfP05ctPsvrn4aVLK2c+Fdhc5lu3dMYfC
 fC6F6eToetOZ5fwGTRrEdeI+63gFNcx/tW6Myr39ysjrOPTeCwu/olmahjTXTjDyhJTsFjEXohH
 uw6jsvkokuSKL7bTAm2i7EAjdo/zNqUDD8QKgEt8VUXauEhD298j9DZS7buWQU39m4xzDmyBGIV
 BidTBAs6rPNEvJiHYSHELOrs2G+iKE3uvnIwaQ90cJsDcrIR9IuvPcRyRLk48QXmNvrpjyITDw4
 fHISqXn4RlgAc9RErDkNqlgmlV011NGPh96bP/aHCADRlv6TVbmCOof3rKst12KKg6cP9s7PVjN
 je7OJPwQonpzagePxz0Snm3vKL43+WrXMxxFKSgqf1a4/hBe1Hz+CdD2ctx6/z0aRw
X-Received: by 2002:a17:903:1103:b0:2b0:6b98:59ec with SMTP id
 d9443c01a7336-2b5f9f7abacmr230550145ad.34.1776866742808; 
 Wed, 22 Apr 2026 07:05:42 -0700 (PDT)
Received: from happycpu-p1.. ([121.160.151.7])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b5faa2e5cesm200037215ad.25.2026.04.22.07.05.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Apr 2026 07:05:42 -0700 (PDT)
From: Chanhong Jung <happycpu@gmail.com>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Peng Fan <peng.fan@nxp.com>
Subject: [PATCH v2] gpio: 74x164: use dev_read_* APIs for live-tree
 compatibility
Date: Wed, 22 Apr 2026 23:05:38 +0900
Message-Id: <20260422140538.1730608-1-happycpu@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260421080847.235789-1-happycpu@gmail.com>
References: <20260421080847.235789-1-happycpu@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 22 Apr 2026 16:44:59 +0200
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

With CONFIG_OF_LIVE=y, dev_of_offset(dev) does not return a valid
flat-FDT offset, so fdtdec_get_int(gd->fdt_blob, offset, ...) inside
gen_74x164_probe() fails to locate the "registers-number" property and
always falls back to the default value of 1. This results in a 4-chip
74HC595 daisy chain being exposed as only 8 GPIOs instead of 32, and
any consumer referencing offsets >= 8 fails to bind with -ENOENT
("GPIO ... not found" / Error -22).

The "registers-default" property is ignored for the same reason, so
any configured power-on output pattern is silently discarded.

Replace the flat-FDT helpers with dev_read_u32_default() and
dev_read_u8_array_ptr(), which correctly walk both live and flat
trees. This matches how other DM GPIO drivers (e.g. pca953x_gpio.c)
read their per-device properties.

With gd->fdt_blob no longer referenced, also drop the now-unused
DECLARE_GLOBAL_DATA_PTR and <asm/global_data.h> include.

Tested on stm32mp153d-ssonic (CONFIG_OF_LIVE=y) with a 4-chip 74HC595
chain: all 32 GPIOs are now exposed, and 16 consumer LED nodes at
offsets 0..31 bind successfully.

Fixes: 9300f711baac ("dm: gpio: introduce 74x164 driver")
Signed-off-by: Chanhong Jung <happycpu@gmail.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
---
 drivers/gpio/74x164_gpio.c | 17 ++++++-----------
 1 file changed, 6 insertions(+), 11 deletions(-)

diff --git a/drivers/gpio/74x164_gpio.c b/drivers/gpio/74x164_gpio.c
index 331428ccd..de2926894 100644
--- a/drivers/gpio/74x164_gpio.c
+++ b/drivers/gpio/74x164_gpio.c
@@ -10,17 +10,13 @@
 
 #include <errno.h>
 #include <dm.h>
-#include <fdtdec.h>
 #include <malloc.h>
-#include <asm/global_data.h>
 #include <asm/gpio.h>
 #include <asm/io.h>
 #include <dm/device_compat.h>
 #include <dt-bindings/gpio/gpio.h>
 #include <spi.h>
 
-DECLARE_GLOBAL_DATA_PTR;
-
 /*
  * struct gen_74x164_chip - Data for 74Hx164
  *
@@ -127,11 +123,9 @@ static int gen_74x164_probe(struct udevice *dev)
 {
 	struct gen_74x164_priv *priv = dev_get_priv(dev);
 	struct gpio_dev_priv *uc_priv = dev_get_uclass_priv(dev);
+	const u8 *defaults;
 	char *str, name[32];
 	int ret;
-	const void *fdt = gd->fdt_blob;
-	int node = dev_of_offset(dev);
-
 	snprintf(name, sizeof(name), "%s_", dev->name);
 	str = strdup(name);
 	if (!str)
@@ -141,16 +135,17 @@ static int gen_74x164_probe(struct udevice *dev)
 	 * See Linux kernel:
 	 * Documentation/devicetree/bindings/gpio/gpio-74x164.txt
 	 */
-	priv->nregs = fdtdec_get_int(fdt, node, "registers-number", 1);
+	priv->nregs = dev_read_u32_default(dev, "registers-number", 1);
 	priv->buffer = calloc(priv->nregs, sizeof(u8));
 	if (!priv->buffer) {
 		ret = -ENOMEM;
 		goto free_str;
 	}
 
-	ret = fdtdec_get_byte_array(fdt, node, "registers-default",
-				    priv->buffer, priv->nregs);
-	if (ret)
+	defaults = dev_read_u8_array_ptr(dev, "registers-default", priv->nregs);
+	if (defaults)
+		memcpy(priv->buffer, defaults, priv->nregs);
+	else
 		dev_dbg(dev, "No registers-default property\n");
 
 	ret = gpio_request_by_name(dev, "oe-gpios", 0, &priv->oe,
-- 
2.34.1

