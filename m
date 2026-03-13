Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42794107BCE8
	for <u-boot@archiver.kernel.org>; Fri, 13 Mar 2026 21:56:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0697184348;
	Fri, 13 Mar 2026 22:56:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="WgYhLzsG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D673B8423D; Fri, 13 Mar 2026 22:56:17 +0100 (CET)
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com
 [IPv6:2607:f8b0:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 96039843D0
 for <u-boot@lists.denx.de>; Fri, 13 Mar 2026 22:56:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-ot1-x32a.google.com with SMTP id
 46e09a7af769-7d77b179b52so2124832a34.2
 for <u-boot@lists.denx.de>; Fri, 13 Mar 2026 14:56:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1773438974; x=1774043774;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Pq2NvF2ZIpD0rpJOFr6o6taNBWaYY2Gs3R732ogu6qI=;
 b=WgYhLzsGDk3JwJp65v8RDCNdESDaokQ3Tqa0LYl/fsZUN+5Y0BOKkE/pdVyNaHj5m+
 mI74XoAMPIT0Bu/CX/86vU6DSfHu5vq6Vp/d+J3+2t8XOLMAV1TyRMGuC/4xDridBj3l
 IjQQRskqcBsnQpJCHwdpJVLcJfru3FcrK9DhKeJQFHX5UYQ5pcK/yv/JnSveOuytjoke
 wHxcJjeoykRvzjWoGYX81PjjiJ9nelCIAzLr9EqxawgRvs2znho7Jc31h5I8/1tIugN2
 /LDbAUweaPspnklfQFViMbzYD/nWtPTEhKxhDrC0JHZr33vgc7HxUJ+firtoEDPS1GHb
 bK0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773438974; x=1774043774;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Pq2NvF2ZIpD0rpJOFr6o6taNBWaYY2Gs3R732ogu6qI=;
 b=LhyLYMSjNKG1rH1erCOLHGPvBsickrDZ0C9Mj1Emh+zlj5dJI2w1m2e6hIjaE3zgLg
 8GIohblZLhQCPp4bpK1MyiaEORFbaqAqgX8BKNhKEecX8mVGtMf+s0W1cDB4kRPIHSnP
 oIDYChNCBTNwg7/QLjpN8PovdM+M9u5RoAwmuf/imLAUxxU8BoOen7nvhB1sdmvfUYMk
 j8xVS+WAeSeZCmf1Tt1C7yf9zIfdWr8lr+x9uGtg9pI9GCdn/BcRqabrQ9NcQuagAS+d
 IPgeWy4Cy3b/lnaguShXziAc9gHxAxKTnImb6JR/9EoJgEWUWmXODh6lVpP0sKtlkEEf
 QLbw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXmEW7dEeAHQrDHSvoeH1YrS8TrrbL3qIdPjeLppTeYwIgpZPtQXVjl6oFfoRZdrZPSr+bXxB4=@lists.denx.de
X-Gm-Message-State: AOJu0Yx131VgQDVTnR7m2vNrl27w1x/IEvPYpXn3Ir0QQSFKof21n3PC
 5KgKehUG0+IAJFCEzQMzWRdIqHdkvLX5vkNxK/g904dg16ZK152YvB59T4+6BsjxUGY=
X-Gm-Gg: ATEYQzxgfjEHhEc6WfXu0groIPWFTSwPIVp+fg3mL0oaoMeaAwgqA5LSeJhPqlkRDTI
 RYIJojzHxugLtrYC2VA3Mvigupjmv3pBT8z50EsZk3lgCGQCI3ZDBbAt3q8L27/rBggRCF032/f
 3gW+ufiXEwVGWTymoHsSsPLTel9y3DFTQ4AcpoSgSHzT4e9MUpD2DfErzXPMvS8vdtGWCnhtrja
 50HXc/fzdFWNhmPCeTQhgnrMPrPyM0kvVZ6uyOG1KKBO7q2K0sngrauW2z8G0NQaw7EyP8eLKle
 5p158054M/sOrJ+PIQnRQQV26ZB5NZ6ZDUWPD+7OVa9bozI4qFnPrh1zh5sPSMKvusVbLhSjtXN
 Qi2K6zojhnHRCo+ummL8q1at+ajrnFk8QHlI/ZcYcpAu4nR/QGiWmXJHL5Y3aXxKvhKauAlY6UZ
 kLaWlGf5VjyN0zSakjh3wQxVzW
X-Received: by 2002:a05:6830:3c86:b0:7d7:4dbd:6dc with SMTP id
 46e09a7af769-7d78249af46mr3236085a34.8.1773438974276; 
 Fri, 13 Mar 2026 14:56:14 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:bf:9982:ff59:466])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d76ac8e5b4sm7432196a34.12.2026.03.13.14.56.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Mar 2026 14:56:13 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Fri, 13 Mar 2026 16:55:35 -0500
Subject: [PATCH 3/4] pinctrl: mediatek: print bias info along with pinmux
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260313-pinctrl-mtk-fix-mt8189-v1-3-607dd37fde37@baylibre.com>
References: <20260313-pinctrl-mtk-fix-mt8189-v1-0-607dd37fde37@baylibre.com>
In-Reply-To: <20260313-pinctrl-mtk-fix-mt8189-v1-0-607dd37fde37@baylibre.com>
To: Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Tom Rini <trini@konsulko.com>
Cc: Julien Stephan <jstephan@baylibre.com>, u-boot@lists.denx.de, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=4940; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=8rnMhMqJdJpWxF0Ve4+wrsXdkh1hjpQvX3qdn7Jw4+U=; 
 b=owEBgwF8/pANAwAKAcLMIAH/AY/AAcsmYgBptIfs5jym9KmP7fXLcTPWUvtrVOSDlAvaXMR/D
 TIJmDU8w0KJAUkEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCabSH7BYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AeBoH+LZUIa75Ry46uISFqkDVGY4xXm23A4bLiAcd0qq
 +rp5tGqtryEKflxbugvwNxkMADefITc/W4Yez0JjS26c7K1fBQlXRw1rcyfEAgZg2oMwVtT/RX4
 1qynrayb4FvcW+9P1Anb2iHGuzryA7Y+TdjgbIuuT4xQMLkHGEYN0JUz0Giz6rTA0zM253jRJnR
 Hud3R6lT8avbhr02LMUfHdkYUxuYAAJ7jkZMEZYJKbO3lcByrCARj90Vp+d2RAyTqUht2AzU+Rh
 hxUKyX8bAlcSnbDfZHJ1yvMxssQkqsU/hmSDHQ9ihU5ShHm2okGvRK35d2Xer5WRn4qa4LDB6H8
 pew==
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
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

Add functionality to be able to print pin bias settings along with the
pinmux setting.

This can be useful to debug why pins might not be working correctly.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/pinctrl/mediatek/pinctrl-mtk-common.c | 96 ++++++++++++++++++++++++++-
 drivers/pinctrl/mediatek/pinctrl-mtk-common.h |  4 ++
 2 files changed, 98 insertions(+), 2 deletions(-)

diff --git a/drivers/pinctrl/mediatek/pinctrl-mtk-common.c b/drivers/pinctrl/mediatek/pinctrl-mtk-common.c
index 1028b8a93f5..ef4acc946a8 100644
--- a/drivers/pinctrl/mediatek/pinctrl-mtk-common.c
+++ b/drivers/pinctrl/mediatek/pinctrl-mtk-common.c
@@ -237,9 +237,39 @@ static int mtk_get_pin_io_type(struct udevice *dev, int pin,
 	io_type->bias_set = priv->soc->io_type[io_n].bias_set;
 	io_type->drive_set = priv->soc->io_type[io_n].drive_set;
 	io_type->input_enable = priv->soc->io_type[io_n].input_enable;
+	io_type->get_pinconf = priv->soc->io_type[io_n].get_pinconf;
 
 	return 0;
 }
+
+static int mtk_pinconf_get(struct udevice *dev, u32 pin, char *buf, size_t size)
+{
+	struct mtk_io_type_desc io_type;
+	int err, pos = 0;
+
+	if (!mtk_get_pin_io_type(dev, pin, &io_type)) {
+		pos += snprintf(buf + pos, size - pos, " (%s)", io_type.name);
+		if (pos >= size)
+			return pos;
+
+		if (io_type.get_pinconf) {
+			err = io_type.get_pinconf(dev, pin, buf + pos, size - pos);
+			if (err < 0)
+				return err;
+
+			pos += err;
+			if (pos >= size)
+				return pos;
+		}
+	}
+
+	return pos;
+}
+#else
+static int mtk_pinconf_get(struct udevice *dev, u32 pin, char *buf, size_t size)
+{
+	return 0;
+}
 #endif
 
 static int mtk_get_groups_count(struct udevice *dev)
@@ -270,12 +300,22 @@ static int mtk_get_pins_count(struct udevice *dev)
 static int mtk_get_pin_muxing(struct udevice *dev, unsigned int selector,
 			      char *buf, int size)
 {
-	int val, err;
+	int val, err, pos;
+
 	err = mtk_hw_get_value(dev, selector, PINCTRL_PIN_REG_MODE, &val);
 	if (err)
 		return err;
 
-	snprintf(buf, size, "Aux Func.%d", val);
+	pos = snprintf(buf, size, "Aux Func.%d", val);
+	if (pos >= size)
+		return 0;
+
+	if (CONFIG_IS_ENABLED(PINCONF)) {
+		err = mtk_pinconf_get(dev, selector, buf + pos, size - pos);
+		if (err < 0)
+			return err;
+	}
+
 	return 0;
 }
 
@@ -670,6 +710,58 @@ static int mtk_pinconf_group_set(struct udevice *dev,
 
 	return 0;
 }
+
+int mtk_pinconf_get_pu_pd(struct udevice *dev, u32 pin, char *buf, size_t size)
+{
+	int err, pu, pd;
+
+	err = mtk_hw_get_value(dev, pin, PINCTRL_PIN_REG_PU, &pu);
+	if (err)
+		return err;
+
+	err = mtk_hw_get_value(dev, pin, PINCTRL_PIN_REG_PD, &pd);
+	if (err)
+		return err;
+
+	return snprintf(buf, size, " PU:%d PD:%d", pu, pd);
+}
+
+int mtk_pinconf_get_pupd_r1_r0(struct udevice *dev, u32 pin, char *buf, size_t size)
+{
+	int err, r0, r1, pupd;
+
+	err = mtk_hw_get_value(dev, pin, PINCTRL_PIN_REG_PUPD, &pupd);
+	if (err)
+		return err;
+
+	err = mtk_hw_get_value(dev, pin, PINCTRL_PIN_REG_R1, &r1);
+	if (err)
+		return err;
+
+	err = mtk_hw_get_value(dev, pin, PINCTRL_PIN_REG_R0, &r0);
+	if (err)
+		return err;
+
+	return snprintf(buf, size, " PUPD:%d R1:%d R0:%d", pupd, r1, r0);
+}
+
+int mtk_pinconf_get_pu_pd_rsel(struct udevice *dev, u32 pin, char *buf, size_t size)
+{
+	int pos, err, rsel;
+
+	pos = mtk_pinconf_get_pu_pd(dev, pin, buf, size);
+	if (pos < 0)
+		return pos;
+
+	if (pos >= size)
+		return pos;
+
+	err = mtk_hw_get_value(dev, pin, PINCTRL_PIN_REG_RSEL, &rsel);
+	if (err)
+		return err;
+
+	return pos + snprintf(buf + pos, size - pos, " RSEL:%d", rsel);
+}
 #endif
 
 static int mtk_pinctrl_pinmux_property_set(struct udevice *dev, u32 pinmux_group)
diff --git a/drivers/pinctrl/mediatek/pinctrl-mtk-common.h b/drivers/pinctrl/mediatek/pinctrl-mtk-common.h
index 1215fb7094b..bd17964090a 100644
--- a/drivers/pinctrl/mediatek/pinctrl-mtk-common.h
+++ b/drivers/pinctrl/mediatek/pinctrl-mtk-common.h
@@ -204,6 +204,7 @@ struct mtk_io_type_desc {
 			bool pullup, u32 val);
 	int (*drive_set)(struct udevice *dev, u32 pin, u32 arg);
 	int (*input_enable)(struct udevice *dev, u32 pin, u32 arg);
+	int (*get_pinconf)(struct udevice *dev, u32 pin, char *buf, size_t size);
 #endif
 };
 
@@ -263,6 +264,9 @@ int mtk_pinconf_bias_set_v1(struct udevice *dev, u32 pin, bool disable,
 int mtk_pinconf_input_enable_v1(struct udevice *dev, u32 pin, u32 arg);
 int mtk_pinconf_drive_set_v0(struct udevice *dev, u32 pin, u32 arg);
 int mtk_pinconf_drive_set_v1(struct udevice *dev, u32 pin, u32 arg);
+int mtk_pinconf_get_pu_pd(struct udevice *dev, u32 pin, char *buf, size_t size);
+int mtk_pinconf_get_pupd_r1_r0(struct udevice *dev, u32 pin, char *buf, size_t size);
+int mtk_pinconf_get_pu_pd_rsel(struct udevice *dev, u32 pin, char *buf, size_t size);
 
 #endif
 

-- 
2.43.0

