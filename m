Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D94FC36010
	for <u-boot@archiver.kernel.org>; Fri, 11 Apr 2025 14:55:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C7597840F8;
	Fri, 11 Apr 2025 16:55:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="JJFFCtMg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4F3F784127; Fri, 11 Apr 2025 16:55:36 +0200 (CEST)
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com
 [IPv6:2a00:1450:4864:20::42f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C63248410C
 for <u-boot@lists.denx.de>; Fri, 11 Apr 2025 16:55:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-39c0dfba946so1227771f8f.3
 for <u-boot@lists.denx.de>; Fri, 11 Apr 2025 07:55:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744383333; x=1744988133; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=NsNgx6w9Y8XSGBfjyutbVSS9ReV242t00p5t2z2vj5Y=;
 b=JJFFCtMgG88qtdTNdSp/VEsKuZY6fMOKnovAW77Owwj0aDMMx1C9fb6uNDBllU0O3x
 GlSvfZgbgi2mpel/T53ZputZ9egWzb3EtDGulX9iee3vEVLLXQDzxxvH2OmRGNgpr0mW
 ncWeoLOLfqfncjsg9IOQKIzQPwSy8PHbmYcTmMJRlY1njHvDj73AvGMohsn3l2RK8ZBq
 2Xaw5g+QYc2i8tOOh0aK50zK2qabG/T4pdeAK1ZUypqQnrr0s4fNfE2zb+Ebv02f+pZG
 5YxtpPXnoKrrXV5JMJvKzXGaZ5F6joqGjP1eo/Rl61DOvj8s0H5fF1jNPY4opopUWEqn
 ZQ8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744383333; x=1744988133;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NsNgx6w9Y8XSGBfjyutbVSS9ReV242t00p5t2z2vj5Y=;
 b=Kwn5WhTddXg5dp/5km3+oQO3os0CG3Fpvs/qEDhX7+un+5CGwL4HBeWuOYJaTNoV9s
 +k2fwrYAt0kQA8vWJxu0ZDdT9buqcrb3BPqJYS02zqN1Hfg9cIVFQX8IWhcu70vgjHS0
 S5AylhV+kQnTC8YtI/lTl9llnX/fMzAMYhFL9bXmmuEi2usENx14a3ZnsEb734PCSzne
 FdmWkE85pfu8N+/t7pn/Ria01R8EZl1LIosJ0K+1lqfCn4ZD8mmnXzOtXI5XMQ8IewVM
 jC6SzEbDXY40yi3Q+jaO2+1l+OahKA6jn75EGNO01lJEJFtKhbvFyUiKgJYuOBuasSHs
 61Pg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXCtGyODHULA3kSeytr8XYUHF/Q964Y604RdKNG816HP0kipHwJGSW1c825VVrLAF24zgh3e04=@lists.denx.de
X-Gm-Message-State: AOJu0YwaG+NwfzsQR7cN6NfVCbZ+zCCoVCj2TzhIjvF1zCS9eqYkAEFL
 Xl+FFeQRFPEcZgUV3osdPvxvRKGaHnmB1hbJgSZI73ffcxqKE4kL4jPMMPHsldEWlzfAqxhz3D9
 N
X-Gm-Gg: ASbGncuKGle8xDh9GmSFLg7FQlXs0BA5jSykq5cYi7UnAsFt9B2wp/kYY20SoUF3jff
 9rCFiEe0El6WjVqSIbHgqV57u+jhBEFcnvBG6ip+fuUQn33hCVt3e7PyBqH7rT3of5d7c7PU4kE
 vrXncNc80xIAf+AlxRaGb2cABX6t5eDNs7LToZwzF3gob/AwnlGqV4R9Y8waA9yEaU54mKg+khv
 aRliBky1h1m5hJcX+ODitlzYIGFN3hKxIKXID32o3+bQQoOux2XT1fUSu4x3wRLJ1h8nIJCdsI+
 Y0pgWGM1upbZ1FGcR5Dy45o6wftwWYK8rgDEQKEjf/iXmX2S8rSDEO8cLblzSg==
X-Google-Smtp-Source: AGHT+IFZpwyl7wugZBzdjRWD1NP0HnwgDVZsj+Bd9rLCl8fa2aXVarZEmUlZ7tF8iAVZBNAUlXMSkg==
X-Received: by 2002:a05:6000:4205:b0:391:40bd:6222 with SMTP id
 ffacd0b85a97d-39ea5200a8emr2024168f8f.22.1744383333257; 
 Fri, 11 Apr 2025 07:55:33 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:3d9:2080:52eb:f6ff:feb3:451a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39eadda64ecsm2279119f8f.0.2025.04.11.07.55.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Apr 2025 07:55:32 -0700 (PDT)
From: neil.armstrong@linaro.org
Date: Fri, 11 Apr 2025 16:55:30 +0200
Subject: [PATCH 1/2] pinctrl: meson: convert to livetree
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250411-u-boot-meson-livetree-v1-1-ebe31909cba5@linaro.org>
References: <20250411-u-boot-meson-livetree-v1-0-ebe31909cba5@linaro.org>
In-Reply-To: <20250411-u-boot-meson-livetree-v1-0-ebe31909cba5@linaro.org>
To: Tom Rini <trini@konsulko.com>
Cc: u-boot-amlogic@groups.io, u-boot@lists.denx.de, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Beniamino Galvani <b.galvani@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4864;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=P6dTiCTGOxNhdQB0+tiXTIyW5a6Up5qyg/k1RIKMCHw=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBn+S1jOhkbFRFihRzEtKDQsQqgt4qzbeB+io/YrnkQ
 gcNOdAmJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZ/ktYwAKCRB33NvayMhJ0RPOEA
 COJnOv5OF54jIzetmIdVGkN/0chpQaSFfsCCPK/kmNW42sbGlmLMetspbjep5xOWSCzI65F7pyX9j7
 EBNIRKXwYbi2kbb+6Q2zDR12oHPzduc7nARUvssB5z832uuYLxujs/Q3TZBNUOs7jml0YhoQVJv831
 C6iCMqW6BaoTHkAgi0JuO9y1FKOJ2txWh6HETd3nouH3rhZxp1N949b1TYCXWe3/kkEnL4fybeZ+Gr
 h2T8d+c5TuAyPTVjAT57vbrnOMYT3os+84+QyuG3KF6fH6vhVLsUGI3+xbE+w227UloDGv2koq4CA7
 g1EmuClHRTMWQrBzqRlqlqZXkgfvot+k5y3l7nHvbUq45d64esqhKVkvlCrWvqYgsUcxVn6UgXuPIz
 q1ocIrWV3IUJI2muJFiz2IFS9AVrta7MRpDK2lBP5NM8KTR3buiN5T16I6zabjtwbVvnHmtMMToPjP
 8Z390MnPoBKYZINSN8t/Y9KoVxz0hBkVq6Fhjxxnt8xf8lrE4lNv/5oxLNII6hPT0DEA8W2wwn2CDv
 7lL33GmAO4pEQXPK3J7Z0FI3mFAdQWIpYqhnxW3ISbARWX+BF3efZcrLSBmB9VctY1YlOPBpEuHUOp
 eN/wQGG9fekZIvBudPEOrea00NAlW240LTUTnodMIOzr8gDeEj8MY9qptuDA==
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

From: Beniamino Galvani <b.galvani@gmail.com>

Update the Meson pinctrl/gpio driver to support a live device tree.

Signed-off-by: Beniamino Galvani <b.galvani@gmail.com>
Link: https://lore.kernel.org/r/20170709223006.3998-5-b.galvani@gmail.com
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 drivers/pinctrl/meson/pinctrl-meson.c | 73 +++++++++++++++++++----------------
 1 file changed, 39 insertions(+), 34 deletions(-)

diff --git a/drivers/pinctrl/meson/pinctrl-meson.c b/drivers/pinctrl/meson/pinctrl-meson.c
index babf1bccc9697596522dc93d8906ff0454cfebf5..21409063ee89cd2f8aa3d511f3fed6b64f800e51 100644
--- a/drivers/pinctrl/meson/pinctrl-meson.c
+++ b/drivers/pinctrl/meson/pinctrl-meson.c
@@ -10,6 +10,8 @@
 #include <dm/device-internal.h>
 #include <dm/device_compat.h>
 #include <dm/lists.h>
+#include <dm/of_addr.h>
+#include <linux/ioport.h>
 #include <dm/pinctrl.h>
 #include <fdt_support.h>
 #include <linux/bitops.h>
@@ -319,88 +321,91 @@ int meson_gpio_probe(struct udevice *dev)
 	return 0;
 }
 
-static fdt_addr_t parse_address(int offset, const char *name, int na, int ns)
+static phys_addr_t parse_address(struct udevice *dev, ofnode node,
+				 const char *name)
 {
-	int index, len = 0;
-	const fdt32_t *reg;
+	struct resource r;
+	fdt_size_t sz;
+	int na, ns, index;
 
-	index = fdt_stringlist_search(gd->fdt_blob, offset, "reg-names", name);
+	index = ofnode_stringlist_search(node, "reg-names", name);
 	if (index < 0)
 		return FDT_ADDR_T_NONE;
 
-	reg = fdt_getprop(gd->fdt_blob, offset, "reg", &len);
-	if (!reg || (len <= (index * sizeof(fdt32_t) * (na + ns))))
+	if (of_live_active()) {
+		if (of_address_to_resource(ofnode_to_np(node), index, &r))
+			return FDT_ADDR_T_NONE;
+		else
+			return r.start;
+	}
+
+	na = dev_read_addr_cells(dev->parent);
+	if (na < 1) {
+		debug("bad #address-cells\n");
 		return FDT_ADDR_T_NONE;
+	}
 
-	reg += index * (na + ns);
+	ns = dev_read_size_cells(dev->parent);
+	if (ns < 1) {
+		debug("bad #size-cells\n");
+		return FDT_ADDR_T_NONE;
+	}
 
-	return fdt_translate_address((void *)gd->fdt_blob, offset, reg);
+	return fdtdec_get_addr_size_fixed(gd->fdt_blob, ofnode_to_offset(node),
+					  "reg", index, na, ns, &sz, true);
 }
 
 int meson_pinctrl_probe(struct udevice *dev)
 {
 	struct meson_pinctrl *priv = dev_get_priv(dev);
+	ofnode node, gpio = ofnode_null();
 	struct uclass_driver *drv;
 	struct udevice *gpio_dev;
-	fdt_addr_t addr;
-	int node, gpio = -1, len;
-	int na, ns;
+	phys_addr_t addr;
 	char *name;
+	int len;
 
-	/* FIXME: Should use livetree */
-	na = fdt_address_cells(gd->fdt_blob, dev_of_offset(dev->parent));
-	if (na < 1) {
-		debug("bad #address-cells\n");
-		return -EINVAL;
-	}
-
-	ns = fdt_size_cells(gd->fdt_blob, dev_of_offset(dev->parent));
-	if (ns < 1) {
-		debug("bad #size-cells\n");
-		return -EINVAL;
-	}
-
-	fdt_for_each_subnode(node, gd->fdt_blob, dev_of_offset(dev)) {
-		if (fdt_getprop(gd->fdt_blob, node, "gpio-controller", &len)) {
+	dev_for_each_subnode(node, dev) {
+		if (ofnode_read_prop(node, "gpio-controller", &len)) {
 			gpio = node;
 			break;
 		}
 	}
 
-	if (!gpio) {
+	if (!ofnode_valid(gpio)) {
 		debug("gpio node not found\n");
 		return -EINVAL;
 	}
 
-	addr = parse_address(gpio, "mux", na, ns);
+	addr = parse_address(dev, gpio, "mux");
 	if (addr == FDT_ADDR_T_NONE) {
 		debug("mux address not found\n");
 		return -EINVAL;
 	}
 	priv->reg_mux = (void __iomem *)addr;
 
-	addr = parse_address(gpio, "gpio", na, ns);
+	addr = parse_address(dev, gpio, "gpio");
 	if (addr == FDT_ADDR_T_NONE) {
 		debug("gpio address not found\n");
 		return -EINVAL;
 	}
 	priv->reg_gpio = (void __iomem *)addr;
 
-	addr = parse_address(gpio, "pull", na, ns);
+	addr = parse_address(dev, gpio, "pull");
 	/* Use gpio region if pull one is not present */
 	if (addr == FDT_ADDR_T_NONE)
 		priv->reg_pull = priv->reg_gpio;
 	else
 		priv->reg_pull = (void __iomem *)addr;
 
-	addr = parse_address(gpio, "pull-enable", na, ns);
+	addr = parse_address(dev, gpio, "pull-enable");
 	/* Use pull region if pull-enable one is not present */
 	if (addr == FDT_ADDR_T_NONE)
 		priv->reg_pullen = priv->reg_pull;
 	else
 		priv->reg_pullen = (void __iomem *)addr;
 
-	addr = parse_address(gpio, "ds", na, ns);
+	addr = parse_address(dev, gpio, "ds");
 	/* Drive strength region is optional */
 	if (addr == FDT_ADDR_T_NONE)
 		priv->reg_ds = NULL;
@@ -420,8 +425,8 @@ int meson_pinctrl_probe(struct udevice *dev)
 	sprintf(name, "meson-gpio");
 
 	/* Create child device UCLASS_GPIO and bind it */
-	device_bind(dev, priv->data->gpio_driver, name, NULL,
-		    offset_to_ofnode(gpio), &gpio_dev);
+	device_bind_with_driver_data(dev, priv->data->gpio_driver, name, 0,
+				     gpio, &gpio_dev);
 
 	return 0;
 }

-- 
2.34.1

