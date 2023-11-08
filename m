Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F275FC4332F
	for <u-boot@archiver.kernel.org>; Wed,  8 Nov 2023 16:21:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E03C3875EA;
	Wed,  8 Nov 2023 17:21:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="KPcGeHbb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B0D6B875A7; Wed,  8 Nov 2023 17:21:07 +0100 (CET)
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com
 [IPv6:2a00:1450:4864:20::42c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4480587576
 for <u-boot@lists.denx.de>; Wed,  8 Nov 2023 17:21:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-32f87b1c725so4870202f8f.3
 for <u-boot@lists.denx.de>; Wed, 08 Nov 2023 08:21:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699460464; x=1700065264; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=g/BcRvYVxyQIqQqsUqqxR3SK7hKJpNeVaw561kxI/4c=;
 b=KPcGeHbbzxoyDniY0uIburWepP1upfILA1bxJvdFAyI2s4UcyZmiYR7hopEhcQpGVs
 6Tfy81P4T7Wc+cMjtMDvD8zQcd0iYQeXplUAsIW5i5rvXD1aAQwS3NlLYrHdPLGXgJJS
 0tTdbiEHIn9i0kh0onuqGnutEdAVTG1+ouDtgGrk+DUwW7blJCi4vMFMEghdEpdgZOw/
 9ykRYTHjWasKIc6pIhu79bOflEM8zC4DEIsuxP5+YaMKEDrVQgcRTyRUwXjbWIMTtEdV
 LarfQSaToXNlFItH5WjlXFiXhooGWZMcjCR4zUqAWmMMUhbZXdLNIpuVoaUULYwgLGZj
 qTGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699460464; x=1700065264;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=g/BcRvYVxyQIqQqsUqqxR3SK7hKJpNeVaw561kxI/4c=;
 b=SuUKkz17saQ/stdH6QxciQNyXeICOg8HKFIaU3mEJVHYUfIf1J+mudZbVkkhg38E6q
 KAjmHTMPgdhunLIlwmmp8k/qW4IUPnzS/Hw4O+41D6PuApyTviTlByAilWepv+9M5zQj
 7RHgwNtnDz6c3jPhS7mBFUsxEVil/b5ry9+VDe3g/Ot5kKxB6SKYyQuS85Lhoq6x7PQW
 K3ru8EENYwMXhjYWGa0G1lzjmys/OK+h4Zlx7Kg6Zs4G8/IqTvEmwCo7/YaZc1mXE3qq
 h7SDQQk4xVElTN4Pr2BJEbUkBtzNrNHD8JFLjHjLI6kHinyHemepWxi3yYWF9+LPT7G1
 BrnA==
X-Gm-Message-State: AOJu0YyhAVEWI3OswgeUAsznSS6rH0AhA3xj3lTg4CTQAAjKeOHZOSWI
 JjBABhHsnThAc2vUTPkrt97lOg==
X-Google-Smtp-Source: AGHT+IGr1ryoLcd7c5ndL6/xyunll/gUq+5wkzJRlO9XKoiIoP2Ls5ntnsHEvTAO5SO98EBmFzvquA==
X-Received: by 2002:a05:6000:1acc:b0:32f:9ad3:860f with SMTP id
 i12-20020a0560001acc00b0032f9ad3860fmr1884413wry.52.1699460464686; 
 Wed, 08 Nov 2023 08:21:04 -0800 (PST)
Received: from lion.localdomain (host-92-25-138-185.as13285.net.
 [92.25.138.185]) by smtp.gmail.com with ESMTPSA id
 n7-20020a5d6607000000b0032db1d741a6sm5273660wru.99.2023.11.08.08.21.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Nov 2023 08:21:04 -0800 (PST)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Wed, 08 Nov 2023 16:20:55 +0000
Subject: [PATCH v2 3/5] gpio: qcom_pmic: fix support for upstream DT
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231108-b4-qcom-dt-compat-v2-3-713233c72948@linaro.org>
References: <20231108-b4-qcom-dt-compat-v2-0-713233c72948@linaro.org>
In-Reply-To: <20231108-b4-qcom-dt-compat-v2-0-713233c72948@linaro.org>
To: Ramon Fried <rfried.dev@gmail.com>, 
 Jorge Ramirez-Ortiz <jorge.ramirez.ortiz@gmail.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>, 
 Mateusz Kulikowski <mateusz.kulikowski@gmail.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, 
 Dzmitry Sankouski <dsankouski@gmail.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>
Cc: u-boot@lists.denx.de
X-Mailer: b4 0.13-dev-4bd13
X-Developer-Signature: v=1; a=openpgp-sha256; l=1610;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=D5lrsqOiSzTZifF0ax83OPPwYm3Gu9vuJkk8F0Sfkcc=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhlTvrTkNeQ2exvN/7/5VNtPC77Jq89pTy1Y+f3WieV6+3
 Xne69x8HaUsDIIcDLJiiiziJ5ZZNq29bK+xfcEFmDmsTCBDGLg4BWAiM+IZ/rtUrxbOrZt0ceEv
 Fa/LKjO/7VwUFy+is3IJQ8LqbzZ2P64x/E8UTfaTWHerLXBjr7Bxj9uazWfWr/Q/uH7hnA93Py9
 OEdgJAA==
X-Developer-Key: i=caleb.connolly@linaro.org; a=openpgp;
 fpr=83B24DA7FE145076BC38BB250CD904EB673A7C47
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

Linux devicetrees use the "gpio-ranges" property, add support for
parsing it instead of "gpio-count" so that upstream DTs can be used with
U-Boot.

Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 drivers/gpio/qcom_pmic_gpio.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/drivers/gpio/qcom_pmic_gpio.c b/drivers/gpio/qcom_pmic_gpio.c
index 7b83c67fa464..647d4143ce14 100644
--- a/drivers/gpio/qcom_pmic_gpio.c
+++ b/drivers/gpio/qcom_pmic_gpio.c
@@ -245,11 +245,37 @@ static int qcom_gpio_probe(struct udevice *dev)
 	return 0;
 }
 
+/*
+ * Parse basic GPIO count specified via the gpio-ranges property
+ * as specified in Linux devicetrees
+ * Returns < 0 on error, otherwise gpio count
+ */
+static int qcom_gpio_of_parse_ranges(struct udevice *dev)
+{
+	int ret;
+	struct ofnode_phandle_args args;
+
+	ret = ofnode_parse_phandle_with_args(dev_ofnode(dev), "gpio-ranges",
+					     NULL, 3, 0, &args);
+	if (ret)
+		return log_msg_ret("gpio-ranges", ret);
+
+	return args.args[2];
+}
+
 static int qcom_gpio_of_to_plat(struct udevice *dev)
 {
 	struct gpio_dev_priv *uc_priv = dev_get_uclass_priv(dev);
+	int ret;
 
 	uc_priv->gpio_count = dev_read_u32_default(dev, "gpio-count", 0);
+	if (!uc_priv->gpio_count) {
+		ret = qcom_gpio_of_parse_ranges(dev);
+		if (ret > 0)
+			uc_priv->gpio_count = ret;
+		else
+			printf("gpio-ranges error: %d\n", ret);
+	}
 	uc_priv->bank_name = dev_read_string(dev, "gpio-bank-name");
 	if (uc_priv->bank_name == NULL)
 		uc_priv->bank_name = "qcom_pmic";

-- 
2.42.0

