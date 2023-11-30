Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4114C4167B
	for <u-boot@archiver.kernel.org>; Thu, 30 Nov 2023 20:15:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 86555876CB;
	Thu, 30 Nov 2023 21:14:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="XBkJNYgt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5D544876C7; Thu, 30 Nov 2023 21:14:00 +0100 (CET)
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com
 [IPv6:2607:f8b0:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 360E087656
 for <u-boot@lists.denx.de>; Thu, 30 Nov 2023 21:13:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-ot1-x334.google.com with SMTP id
 46e09a7af769-6d7e6df999fso824565a34.1
 for <u-boot@lists.denx.de>; Thu, 30 Nov 2023 12:13:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701375237; x=1701980037; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KnQmLgNJ4/6SJdzPvK8EpKxvwTmjdjJNqopvwcJ4JYM=;
 b=XBkJNYgtn1YzRCOKQpFSo3QgUm/6dLK7pMygMVUXdF0CKfmsNB+zJLMiERmFufN2Y0
 4JD677AI/GK/zzSftKv/+HD62OryRtmR2O3Oa9u3ZweRGtrjuZMNIB06wt6ZQUWWFzT3
 Ob+LcZjxMYGueS5CTAQrskfyufOXr/WpFOczV1++20C088bcnEbPUVT+sXKM/zikbDpx
 k9vSgMQpbY5hoM2lUE6UrgYIz/UrkMWRF/a+OGeQirpHh6eak8VF1pW+/tCnqEC0UfrK
 NFzj8pBxrm+RhHuxgpWR50+Eee1vHhtUeBTGey33ndLcxEi+4roP1zXJwT9V9xbi7fOG
 7/5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701375237; x=1701980037;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KnQmLgNJ4/6SJdzPvK8EpKxvwTmjdjJNqopvwcJ4JYM=;
 b=AjNuEhrW6YE0sGM/yQOJ430izYbWercrog/rWefQJ1qWg0OyjOmmaxj5NcrhM+sn0I
 xSvlhJxj8kFXrkWpGy2koVKxovYbH0V6PoZ4HLhYPDSMBPiBDor2mBhORpc693s7Ogqv
 yIK03bVqknlcai8XKw98EJkvsbi3XhWOs+QlH09dmoIg7v5VCvDiPB35Ro3Hxcw5K8Sh
 jLSQ91+TSL6IqTnfBWl7IBoeNGy+C7oowouv96SafJZhm5oI4KgTWr1cFlWZelQKdM5y
 N7vy8X5Z+h2ujIi8BLLkQ2YSNsH6nbGI6qXkw0zr8bhiYu6Ss7ByHktF8XSDUw45s2f4
 zRAg==
X-Gm-Message-State: AOJu0Yw90z3xEnuIi9LAavRKGUlasl8naSBsXv7RHlDamJpBe6ZTGJSX
 khsFGQywKXTLVPeMRibwUqAp60oiG0UWWsM3MN4=
X-Google-Smtp-Source: AGHT+IEwziqPaKh9zQ+lJEGyHhDvedRh7MB1D4kvp/F0vFXnAlni5tTPAP4Q/Ij3CypRufDHdK8Mxw==
X-Received: by 2002:a9d:6c02:0:b0:6d8:16ab:2b10 with SMTP id
 f2-20020a9d6c02000000b006d816ab2b10mr812179otq.10.1701375236936; 
 Thu, 30 Nov 2023 12:13:56 -0800 (PST)
Received: from localhost ([136.62.192.75]) by smtp.gmail.com with ESMTPSA id
 l1-20020a05683004a100b006d84b790e3bsm263880otd.49.2023.11.30.12.13.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Nov 2023 12:13:56 -0800 (PST)
From: Sam Protsenko <semen.protsenko@linaro.org>
To: Minkyu Kang <promsoft@gmail.com>,
	Tom Rini <trini@konsulko.com>
Cc: Andre Przywara <andre.przywara@arm.com>, Simon Glass <sjg@chromium.org>,
 u-boot@lists.denx.de
Subject: [PATCH 5/7] pinctrl: exynos: Refactor handling the pin related dt
 properties
Date: Thu, 30 Nov 2023 14:13:50 -0600
Message-Id: <20231130201352.6379-6-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231130201352.6379-1-semen.protsenko@linaro.org>
References: <20231130201352.6379-1-semen.protsenko@linaro.org>
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

All pin related dt properties (pin-function, pin-pud and pin-drv) are
handled in a very similar way. Get rid of that code duplication by
extracting the corresponding data knowledge into an actual data
structure (array), and then just iterating over it.

No functional change, it's a refactoring commit.

Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
---
 drivers/pinctrl/exynos/pinctrl-exynos.c | 35 ++++++++++++++-----------
 1 file changed, 19 insertions(+), 16 deletions(-)

diff --git a/drivers/pinctrl/exynos/pinctrl-exynos.c b/drivers/pinctrl/exynos/pinctrl-exynos.c
index 9a51653be864..e79ce5113d84 100644
--- a/drivers/pinctrl/exynos/pinctrl-exynos.c
+++ b/drivers/pinctrl/exynos/pinctrl-exynos.c
@@ -21,6 +21,13 @@ const struct samsung_pin_bank_type bank_type_alive = {
 	.reg_offset = { 0x00, 0x04, 0x08, 0x0c, },
 };
 
+static const char * const exynos_pinctrl_props[PINCFG_TYPE_NUM] = {
+	[PINCFG_TYPE_FUNC]	= "samsung,pin-function",
+	[PINCFG_TYPE_DAT]	= "samsung,pin-val",
+	[PINCFG_TYPE_PUD]	= "samsung,pin-pud",
+	[PINCFG_TYPE_DRV]	= "samsung,pin-drv",
+};
+
 /**
  * exynos_pinctrl_setup_peri: setup pinctrl for a peripheral.
  * conf: soc specific pin configuration data array
@@ -114,7 +121,7 @@ int exynos_pinctrl_set_state(struct udevice *dev, struct udevice *config)
 	const void *fdt = gd->fdt_blob;
 	int node = dev_of_offset(config);
 	unsigned int count, idx, pin_num;
-	unsigned int pinfunc, pinpud, pindrv;
+	unsigned int pinvals[PINCFG_TYPE_NUM];
 	unsigned long reg;
 	const char *name;
 
@@ -126,13 +133,16 @@ int exynos_pinctrl_set_state(struct udevice *dev, struct udevice *config)
 	if (count <= 0)
 		return -EINVAL;
 
-	pinfunc = fdtdec_get_int(fdt, node, "samsung,pin-function", -1);
-	pinpud = fdtdec_get_int(fdt, node, "samsung,pin-pud", -1);
-	pindrv = fdtdec_get_int(fdt, node, "samsung,pin-drv", -1);
+	for (idx = 0; idx < PINCFG_TYPE_NUM; ++idx) {
+		pinvals[idx] = fdtdec_get_int(fdt, node,
+					      exynos_pinctrl_props[idx], -1);
+	}
+	pinvals[PINCFG_TYPE_DAT] = -1; /* ignore GPIO data register */
 
 	for (idx = 0; idx < count; idx++) {
 		const struct samsung_pin_bank_data *bank;
 		char bank_name[10];
+		int pincfg;
 
 		name = fdt_stringlist_get(fdt, node, "samsung,pins", idx, NULL);
 		if (!name)
@@ -141,19 +151,12 @@ int exynos_pinctrl_set_state(struct udevice *dev, struct udevice *config)
 		bank = get_bank(dev, bank_name);
 		reg = priv->base + bank->offset;
 
-		if (pinfunc != -1) {
-			exynos_pinctrl_set_pincfg(reg, pin_num, pinfunc,
-						  PINCFG_TYPE_FUNC, bank->type);
-		}
-
-		if (pinpud != -1) {
-			exynos_pinctrl_set_pincfg(reg, pin_num, pinpud,
-						  PINCFG_TYPE_PUD, bank->type);
-		}
+		for (pincfg = 0; pincfg < PINCFG_TYPE_NUM; ++pincfg) {
+			unsigned int val = pinvals[pincfg];
 
-		if (pindrv != -1) {
-			exynos_pinctrl_set_pincfg(reg, pin_num, pindrv,
-						  PINCFG_TYPE_DRV, bank->type);
+			if (val != -1)
+				exynos_pinctrl_set_pincfg(reg, pin_num, val,
+							  pincfg, bank->type);
 		}
 	}
 
-- 
2.39.2

