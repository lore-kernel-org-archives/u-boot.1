Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0C74D41C00
	for <u-boot@archiver.kernel.org>; Wed, 13 Nov 2024 04:51:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6128089537;
	Wed, 13 Nov 2024 05:51:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Xs9E+THl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3C3A489515; Wed, 13 Nov 2024 05:51:24 +0100 (CET)
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com
 [IPv6:2a00:1450:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 577AB89539
 for <u-boot@lists.denx.de>; Wed, 13 Nov 2024 05:51:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-a9a0ef5179dso1088777066b.1
 for <u-boot@lists.denx.de>; Tue, 12 Nov 2024 20:51:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731473482; x=1732078282; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Q+d27EHy4nK6DJLg2swyyaE+M9hsP0XLhsXn2iIUys8=;
 b=Xs9E+THlRAvS0uMAYiBqyaoiLWPnhDN7viON2SKc8s1z3RV8b7dvC6ZfN0OFgUXYQs
 q6/n9ryvUTNqmZ930QzyhbrzR9NrUnFV67M21TYQiqzctXXaYt0Cm/KY984zzhwggnRt
 hf418Uh3TpyOA5GKBiYW0a5+11wLozjcrR4QrC4U3ecQmHfRRolBlCuV/XZn+Zr0JMmm
 jOMBpP4hoLNEup0K22PE4WyRIUeCHAJHKnOKXZYp80UV3/IFlYCaJDW+EQ9Hwzhoihji
 2FnOFlzlGHgKAyraIoGutxmwxB2XLX5GmKFsoNaLPm25VjhUa8Hx0exDu3JLpvw2DFrS
 sP2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731473482; x=1732078282;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Q+d27EHy4nK6DJLg2swyyaE+M9hsP0XLhsXn2iIUys8=;
 b=iUOu2atKCkOQlTqIm3pusF+iTJPUuZ8XkXB+ktObLKSsYwY/F4WkJLVfsejh4jF9UJ
 3/rNRvi0xl1vaaASjVbsvN9NfUu3lveGufDoTI/blCoZplC1HP6RJhQGs6CIe6oQcy4i
 rXtYQzjVb99Grt0P0WTpgbMD2uVj47emAkZJmVdc3DPO+Looi0UEhT7hngCAzcODI+ii
 S5aq9JCK1UAoePeCGm6ACWLo7Ymk8ldof5YpVmtcAUITeILsA1uMN3/tN92ieOmKgfAZ
 oVkV7oHg8tNLpnGrvTyBg0SMb/yJETO0AdehdTevwzq4sfI8es4VhgPsJ3rCHIY6MqeA
 Sg5w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVGmryXIbid1ZxFlpbphMzB0wHN/7udXvvxlgrn+kGipWGVdhCDBNYshUzgpeL0QsUEQ+eR+7M=@lists.denx.de
X-Gm-Message-State: AOJu0YxLIutKlbWz6DS5+u28kudzMiHOVj1sakWVKcP7lS0QBncE2eG+
 rpLYLf1GPX1CVdO6FFs7AwnQOAwk2QMBNxudDKM/DsOnhPXtnP9Q34Ub22xReNw=
X-Google-Smtp-Source: AGHT+IEhv9Sp2HVexzAl5OkJQSJ52oUqBxUGk5Pf9bHTVNffF/tmbzKlstV/uYkX3daCT1GN650cLw==
X-Received: by 2002:a17:907:7b86:b0:a9d:e01e:ffa9 with SMTP id
 a640c23a62f3a-a9eeff449femr1836855366b.33.1731473481695; 
 Tue, 12 Nov 2024 20:51:21 -0800 (PST)
Received: from lion.caleb.rex.connolly.tech
 ([2a02:8109:888d:ff00:ca7f:54ff:fe52:4519])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9ee0a17651sm809267666b.38.2024.11.12.20.51.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Nov 2024 20:51:21 -0800 (PST)
From: Caleb Connolly <caleb.connolly@linaro.org>
To: Caleb Connolly <caleb.connolly@linaro.org>,
 Dan Carpenter <dan.carpenter@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, Simon Glass <sjg@chromium.org>,
 Sumit Garg <sumit.garg@linaro.org>, Tom Rini <trini@konsulko.com>
Cc: u-boot-qcom@groups.io,
	u-boot@lists.denx.de
Subject: [PATCH] button: qcom-pmic: add software debounce
Date: Wed, 13 Nov 2024 05:51:03 +0100
Message-ID: <20241113045109.1838241-1-caleb.connolly@linaro.org>
X-Mailer: git-send-email 2.47.0
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

This helps with reliability on some platforms. We should probably also
configure the hardware debounce timer eventually.

Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 drivers/button/button-qcom-pmic.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/button/button-qcom-pmic.c b/drivers/button/button-qcom-pmic.c
index ad7fed3ddaaa..f9f0948ae095 100644
--- a/drivers/button/button-qcom-pmic.c
+++ b/drivers/button/button-qcom-pmic.c
@@ -14,8 +14,9 @@
 #include <log.h>
 #include <power/pmic.h>
 #include <spmi/spmi.h>
 #include <linux/bitops.h>
+#include <time.h>
 
 #define REG_TYPE		0x4
 #define REG_SUBTYPE		0x5
 
@@ -30,8 +31,9 @@ struct qcom_pmic_btn_priv {
 	u32 base;
 	u32 status_bit;
 	int code;
 	struct udevice *pmic;
+	ulong last_release_time;
 };
 
 #define PON_INT_RT_STS                        0x10
 #define  PON_KPDPWR_N_SET		0
@@ -41,15 +43,23 @@ struct qcom_pmic_btn_priv {
 
 static enum button_state_t qcom_pwrkey_get_state(struct udevice *dev)
 {
 	struct qcom_pmic_btn_priv *priv = dev_get_priv(dev);
+	bool pressed;
+	int reg;
 
-	int reg = pmic_reg_read(priv->pmic, priv->base + PON_INT_RT_STS);
+	if (get_timer_us(0) - priv->last_release_time < 25000)
+		return BUTTON_OFF;
 
+	reg = pmic_reg_read(priv->pmic, priv->base + PON_INT_RT_STS);
 	if (reg < 0)
 		return 0;
 
-	return (reg & BIT(priv->status_bit)) != 0;
+	pressed = !!(reg & BIT(priv->status_bit));
+	if (!pressed)
+		priv->last_release_time = get_timer_us(0);
+
+	return pressed;
 }
 
 static int qcom_pwrkey_get_code(struct udevice *dev)
 {
-- 
2.47.0

