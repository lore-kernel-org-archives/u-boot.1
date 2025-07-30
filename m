Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 373EDC87FC9
	for <u-boot@archiver.kernel.org>; Wed, 30 Jul 2025 05:13:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8EDAC83327;
	Wed, 30 Jul 2025 07:10:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="DLo2ZsGt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CF77882B07; Wed, 30 Jul 2025 04:19:15 +0200 (CEST)
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com
 [IPv6:2607:f8b0:4864:20::72b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 88D2881FEE
 for <u-boot@lists.denx.de>; Wed, 30 Jul 2025 04:19:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=chalianis1@gmail.com
Received: by mail-qk1-x72b.google.com with SMTP id
 af79cd13be357-7dfc604107eso562642185a.2
 for <u-boot@lists.denx.de>; Tue, 29 Jul 2025 19:19:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1753841952; x=1754446752; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=TM6VStVA419HaGA/XMYEvjKW1ilGPkiqxC8O9R2j5CE=;
 b=DLo2ZsGt0Z43ckhn+8h5l7nYMX0FwWnpZT7p0XlhMhhmenIqKqFHHaHx+/ZBN0CyN0
 21HaFCSiWJekQRB574hYC+1XkQHusAgVIGOvJPrvsraOlTp3HHQ8lH6NacDd9EzyR3fT
 qhAEbT3P2gimsg+EsGU+USgVLamVGedr2HSyICK7N0C5HoUvSsmZVdhzPtT1EU9EYCVa
 bhkkNffQgVvczcO85vWJhIrGqScjzKzbQQBSy3eaggmfPIg8K7y0rKG0Gg6vjLk3hK1r
 1nYl3xZfnnTAZvsGJ1LDSc3Hhdik6/xIzuAmaJeWt3CfKboU8EmIszNerlKlGRFsrOio
 ISVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753841952; x=1754446752;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=TM6VStVA419HaGA/XMYEvjKW1ilGPkiqxC8O9R2j5CE=;
 b=dK8u4Z2pnA1y6vHbL853ghV6NjSsLew1Jnyu3W2JyX1I1Q3TXR3IMSPzyso882LoXr
 2Vb3BhVOC56d8QImgvn/ccAfx9RaMcXqohm5xSMLuesQ3rpRoJgpCAO6QyESPX1h9wnM
 PgglvJPE7fUei3T24UmNBMhl4V7Gu8o/wsiLUoiyUH8G3gMlx432XXDh/zXJxnNqeqgJ
 Z6lJKerQRZ8a1od7gE6FwPuyZoU19g4ejtKCVoreYl6/A5WB8ac/2J1u5AxQkZmTGtyk
 JmvqYzC40acuLVkyz/jVPU5zqvWkYNbOscZLezrd1PF03N6udDZ422F8nXIt6bmf60ml
 Shvg==
X-Gm-Message-State: AOJu0YxxqmhfICgW3ErrtEzA1DNgRzvUiYf85/x1cvABaCU1ckESOHw7
 JJ4ghHnrIBYpieNIKXJMkBlVYkvaBOMvFvIDiO0dPhM8J/ykVHVBIq1g
X-Gm-Gg: ASbGncvRgb4Rl0OL39ip5SFMw43ll2qJw1zylAKWmRZGCgRJAqN5+9ab1dYl6mPlnCB
 ZNjcMDlfB7z99z3+pxbIsZeHsmHrcbH5X0TT8CVG4wQfdNxJ1K0xdI55ws34dkUa96xQu7OxyrA
 LKPS6WQRvNAEWlooZNAmB0g+FlJfjxbd829Foqmgk1LNmcvYHTLle6btKXvxjoJYi8d8kdzPt/A
 5BG7MexSXzBwn38gwol9Ldg4L9gR4L8Tsj31JzM/37E6QSClBzHBeCZLuoTlWzdVY7BuXXnF6Yq
 rDdJ4SowIA2rHej0TVyWwmDwCzT4My8bQObpwhQIYCbCVzKNTgJx6DNF4PfP+zk67AEVf8HJ9cv
 rQxOtsZzXsLB/lP490bnxkvNxVHGJniTOwBQqTIF6
X-Google-Smtp-Source: AGHT+IG5cU7RYUrVRHSbIGJekfFcwpEatl51qSSErcArsKhBwysTKmCzAECXSN3TKcuRVFa85QnhDw==
X-Received: by 2002:a05:620a:190a:b0:7e0:2c05:6ba1 with SMTP id
 af79cd13be357-7e66eece2b1mr298265085a.0.1753841952242; 
 Tue, 29 Jul 2025 19:19:12 -0700 (PDT)
Received: from Latitude-7490.ht.home
 ([2607:fa49:8c41:2600:c720:4b12:12bb:8a7a])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7e643879157sm503951285a.59.2025.07.29.19.19.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Jul 2025 19:19:11 -0700 (PDT)
From: chalianis1@gmail.com
To: trini@konsulko.com
Cc: u-boot@lists.denx.de,
	Chali Anis <chalianis1@gmail.com>
Subject: [PATCH] pinctrl: gpio: sx150x: fix compilation warnings.
Date: Tue, 29 Jul 2025 22:19:08 -0400
Message-Id: <20250730021908.3268071-1-chalianis1@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 30 Jul 2025 07:10:08 +0200
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

From: Chali Anis <chalianis1@gmail.com>

Fixes: 5451504256d3 ("pinctrl: gpio: sx150x: add Semtech SX150x I2C GPIO expander and pinctrl driver")

Signed-off-by: Chali Anis <chalianis1@gmail.com>
---
 drivers/pinctrl/pinctrl-sx150x.c | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-sx150x.c b/drivers/pinctrl/pinctrl-sx150x.c
index 324d7af8fcd0..cddde8822edb 100644
--- a/drivers/pinctrl/pinctrl-sx150x.c
+++ b/drivers/pinctrl/pinctrl-sx150x.c
@@ -7,7 +7,6 @@
  * <gbean@codeaurora.org>
  */
 
-#include <asm/gpio.h>
 #include <dm.h>
 #include <dm/device-internal.h>
 #include <dm/device.h>
@@ -22,6 +21,8 @@
 #include <log.h>
 #include <power/regulator.h>
 #include <regmap.h>
+#include <linux/bug.h>
+#include <asm/gpio.h>
 
 #define err(format, arg...) printf("ERR:" format "\n", ##arg)
 #define dbg(format, arg...) printf("DBG:" format "\n", ##arg)
@@ -413,7 +414,7 @@ static int sx150x_reg_read(struct sx150x_pinctrl_priv *pctl, unsigned int reg,
 {
 	int ret, n;
 	const int width = sx150x_reg_width(pctl, reg);
-	unsigned int idx, val;
+	unsigned int val, idx;
 
 	/*
 	 * There are four potential cases covered by this function:
@@ -444,8 +445,9 @@ static int sx150x_reg_read(struct sx150x_pinctrl_priv *pctl, unsigned int reg,
 	 *		reg  3 [ 3 3 2 2 1 1 0 0 ]
 	 */
 
-	for (n = width, val = 0, idx = reg; n > 0; n -= 8, idx) {
+	for (n = width, val = 0; n > 0; n -= 8) {
 		val <<= 8;
+		idx = reg;
 
 		ret = dm_i2c_reg_read(pctl->i2c, idx);
 		if (ret < 0)
@@ -475,7 +477,6 @@ static int sx150x_reg_write(struct sx150x_pinctrl_priv *pctl, unsigned int reg,
 		if (ret < 0)
 			return ret;
 
-		reg;
 		n -= 8;
 	} while (n >= 0);
 
@@ -724,7 +725,7 @@ static const struct udevice_id sx150x_pinctrl_of_match[] = {
 	{},
 };
 
-static const struct pinconf_param sx150x_conf_params[] = {
+static const struct pinconf_param __maybe_unused sx150x_conf_params[] = {
 	{ "bias-disable", PIN_CONFIG_BIAS_DISABLE, 0 },
 	{ "bias-pull-up", PIN_CONFIG_BIAS_PULL_UP, 1 },
 	{ "bias-pull-down", PIN_CONFIG_BIAS_PULL_DOWN, 1 },
@@ -750,7 +751,7 @@ static const char *sx150x_pinctrl_get_pin_name(struct udevice *dev,
 	return pin_name;
 }
 
-static int sx150x_pinctrl_conf_set(struct udevice *dev, unsigned int pin,
+static int __maybe_unused sx150x_pinctrl_conf_set(struct udevice *dev, unsigned int pin,
 				   unsigned int param, unsigned int arg)
 {
 	int ret;
@@ -834,13 +835,11 @@ static int sx150x_pinctrl_conf_set(struct udevice *dev, unsigned int pin,
 static int sx150x_pinctrl_bind(struct udevice *dev)
 {
 	struct sx150x_pinctrl_priv *pctl = dev_get_plat(dev);
-	int ret, reg;
+	int ret;
 
 	if (!dev_read_bool(dev, "gpio-controller"))
 		return 0;
 
-	reg = (int)dev_read_addr_ptr(dev);
-
 	ret = device_bind(dev, &sx150x_gpio_driver, dev_read_name(dev), NULL,
 			  dev_ofnode(dev), &pctl->gpio);
 	if (ret)
@@ -861,7 +860,10 @@ static int sx150x_pinctrl_probe(struct udevice *dev)
 
 	pctl->data = drv_data;
 
-	reg = (int)dev_read_addr_ptr(dev);
+	reg = dev_read_u32_default(dev, "reg", -ENODEV);
+	if (reg < 0)
+		return -ENODEV;
+
 	ret = dm_i2c_probe(dev->parent, reg, 0, &pctl->i2c);
 	if (ret) {
 		err("Cannot find I2C chip %02x (%d)", reg, ret);
-- 
2.34.1

