Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F226BC25B79
	for <u-boot@archiver.kernel.org>; Tue, 28 May 2024 08:32:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 182638845D;
	Tue, 28 May 2024 10:32:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="CXrWUglu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5491A88440; Tue, 28 May 2024 10:32:05 +0200 (CEST)
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com
 [IPv6:2a00:1450:4864:20::12d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4EAED88402
 for <u-boot@lists.denx.de>; Tue, 28 May 2024 10:32:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-lf1-x12d.google.com with SMTP id
 2adb3069b0e04-52965199234so607576e87.2
 for <u-boot@lists.denx.de>; Tue, 28 May 2024 01:32:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716885122; x=1717489922; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=KCIP0Gs6++BTUw1xvrVqee19gMALZn3da7WEmnh7Zeg=;
 b=CXrWUgluAM8EhxEQiynek0uA6FwViGjy6iD3ZKpRRfEBeH86nFKrwqYFYIbB16TGYW
 olrd+aVknKno5blbV6QbsMPaoXoCXWhmVix/QxsnbWxPZ8g0pgMzkxusal+bfzudbxU4
 sbhkwg47nbmnzygimy+2P0R3HM1D+VMLJVHmYhx5DhnzteLZcHal9apVOhtlCTlEeu+o
 juzTqyGGMDw4XhqqBQDeMMfDbTlWZuAwQ14ihJnRAzjK7PNWuILbm98Tuwe0bgACxKhA
 wkSThLD7Ep4tuAkgXPdNVoFfJ2kPbx2cCAWcfE6bdelX12z0bj+alq12rt+nNPefRgMt
 L5zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716885122; x=1717489922;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KCIP0Gs6++BTUw1xvrVqee19gMALZn3da7WEmnh7Zeg=;
 b=PHPdBibTRHa1fsUz2ln5MaXpkjQE1PDDdzVX+URWxWwDhKdz9GZwYFnx0yEeDnwo3q
 pRoe1rl30fmwQ7z0e0CiS30OoDijVdamiLwFEgOFPaGjlBS/BB5Prkvs9Ilz8hg70OJQ
 0MwT7dG/+NkXhVWjmLeM0ev/D0QxR0shzq9Ah4SPoFBWC6wJW4Xvo82q4Mpg4XWYr2tp
 jx0csFmsKWyXdULI3oGVDaRFdww3bcWKnaQB4PHp+DzA7qhvlyHorWJVyHLjdD80LvUI
 FVqHmUxbV/mp+HH8s0Lu1eSuSPPFbV1k/MWaHZiwoeibVGX77srCRr4JzFxBKteNuy4G
 7+ZA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU6dhMq5u4NZ0eiqyqAZyfRb5PybLnkvbYP9Cx9KxKhPS6OCjL+mcWDKw5dswYxuj04bJJ2ZamsEoAL34x9rluT6bHbDQ==
X-Gm-Message-State: AOJu0Ywp5y3tKr1YnQ8eBfR1U4aDJewYsQrCJtjLRTOxHWa4tb+G7g7g
 Xs9aAASSpymcUxVq4ulkKbM61+tWjBqwUdBWwJ46FS+nZqfhmlYssCKQCRuyX8E=
X-Google-Smtp-Source: AGHT+IE3HKU6d+CIcrK1L0lgBSxdWDCmup75OdYHC9rTzVXcBNfiANrISkMA915IbM74uPdATL/3Fw==
X-Received: by 2002:ac2:4206:0:b0:520:f419:272b with SMTP id
 2adb3069b0e04-529644ebeadmr7044692e87.5.1716885122423; 
 Tue, 28 May 2024 01:32:02 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42100ee7f1dsm167122035e9.7.2024.05.28.01.32.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 May 2024 01:32:02 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Tue, 28 May 2024 10:31:55 +0200
Subject: [PATCH 3/5] pinctrl: qcom: add support setting pin configuration
 for special pins
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240528-topic-sm8x50-pinctrl-pinconf-v1-3-54d1e9ad7dfa@linaro.org>
References: <20240528-topic-sm8x50-pinctrl-pinconf-v1-0-54d1e9ad7dfa@linaro.org>
In-Reply-To: <20240528-topic-sm8x50-pinctrl-pinconf-v1-0-54d1e9ad7dfa@linaro.org>
To: Caleb Connolly <caleb.connolly@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>, Tom Rini <trini@konsulko.com>
Cc: u-boot-qcom@groups.io, u-boot@lists.denx.de, 
 Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2105;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=t0JY5Z1xwZbceiy2/eEC28IVIyPnjXNY/kQlrmTeXbQ=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBmVZZ+vXHqOVZLfbntpN7NpF7jZMAIcetO9i5z66vw
 3iDo8VCJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZlWWfgAKCRB33NvayMhJ0eA4D/
 9dFIsy2BbMi7GocpP3u31+c963Fpk/TrCO0qmiN6iYd3VfRWtxUzRcfP2fTQMQD+M6JHf09/2XwwEA
 W4szTSIV/BbwfugypheOsOk5b5aBoDhnzTN+60WxpYFAKB/Ql+PC54E7MKnml58PdixNN6EtczmKRy
 TJEBdgTN42zvO/ptgjdP5I4VlYATCdml8iRhnNmN/QfcO04h6WteMkZwI+sf9L9LLHZcBYPr21e0UM
 xj/D/3h1i9hPG4Pxge3JOESqTa7NgrEcR1LrUEktmhdkftdOhDlordHwAkcNrtXI+EZz1guwepGYhc
 rOhJGpyZhqizTshKSFtXnz+g/FqSSZXCr1fgqrXuYgxwGDniexRSFK+rnYLx+tgVEWtYjkXVVOMmOr
 +YkswnU2oL/G2xeX6QZX+i5xX9zZUxHm6ZFgYZglgBGuHa7UqMHod9psMzhUEW+al6c128IMP/CoXT
 VrI9Htk32dKTiD6OVUAXjmhxH1tfvCH0dpVZVLoPqpXnuA+yF9HrmUt35qFQTTMdlTBwQP4DGaFYiO
 CO7YbVHZY5kzyZvDjVXQyZOIVILYLnSMsk76eSU8YfFZ/3SQ2Rl+tDgQpHhbBwUhL9YtpWjkydKlnk
 Ak97lKss90gIZHw9QLY6uzLbOPlS14nw3nYbj2w17QiifBIKBXUHmDXUa7+A==
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

Use the previously introduced msm_special_pin_data to setup the special
pins configuration if the SoC driver have them specified.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 drivers/pinctrl/qcom/pinctrl-qcom.c | 37 +++++++++++++++++++++++++++++++++++--
 1 file changed, 35 insertions(+), 2 deletions(-)

diff --git a/drivers/pinctrl/qcom/pinctrl-qcom.c b/drivers/pinctrl/qcom/pinctrl-qcom.c
index 4f4e9a83949..26a3fba194a 100644
--- a/drivers/pinctrl/qcom/pinctrl-qcom.c
+++ b/drivers/pinctrl/qcom/pinctrl-qcom.c
@@ -103,14 +103,47 @@ static int msm_pinmux_set(struct udevice *dev, unsigned int pin_selector,
 	return 0;
 }
 
+static int msm_pinconf_set_special(struct msm_pinctrl_priv *priv, unsigned int pin_selector,
+				   unsigned int param, unsigned int argument)
+{
+	unsigned int offset = pin_selector - priv->data->pin_data.special_pins_start;
+	const struct msm_special_pin_data *data;
+
+	if (!priv->data->pin_data.special_pins_data)
+		return 0;
+
+	data = &priv->data->pin_data.special_pins_data[offset];
+
+	switch (param) {
+	case PIN_CONFIG_DRIVE_STRENGTH:
+		argument = (argument / 2) - 1;
+		clrsetbits_le32(priv->base + data->ctl_reg,
+				GENMASK(2, 0) << data->drv_bit,
+				argument << data->drv_bit);
+		break;
+	case PIN_CONFIG_BIAS_DISABLE:
+		clrbits_le32(priv->base + data->ctl_reg,
+			     TLMM_GPIO_PULL_MASK << data->pull_bit);
+		break;
+	case PIN_CONFIG_BIAS_PULL_UP:
+		clrsetbits_le32(priv->base + data->ctl_reg,
+				TLMM_GPIO_PULL_MASK << data->pull_bit,
+				argument << data->pull_bit);
+		break;
+	default:
+		return 0;
+	}
+
+	return 0;
+}
+
 static int msm_pinconf_set(struct udevice *dev, unsigned int pin_selector,
 			   unsigned int param, unsigned int argument)
 {
 	struct msm_pinctrl_priv *priv = dev_get_priv(dev);
 
-	/* Always NOP for special pins */
 	if (qcom_is_special_pin(&priv->data->pin_data, pin_selector))
-		return 0;
+		return msm_pinconf_set_special(priv, pin_selector, param, argument);
 
 	switch (param) {
 	case PIN_CONFIG_DRIVE_STRENGTH:

-- 
2.34.1

