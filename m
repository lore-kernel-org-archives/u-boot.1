Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EB65C4829E
	for <u-boot@archiver.kernel.org>; Thu, 15 Feb 2024 20:54:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9DECF87F35;
	Thu, 15 Feb 2024 21:53:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="GViDxwR8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 31D1A87F27; Thu, 15 Feb 2024 21:53:05 +0100 (CET)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D2C4D87E29
 for <u-boot@lists.denx.de>; Thu, 15 Feb 2024 21:52:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-411d715c401so10605005e9.1
 for <u-boot@lists.denx.de>; Thu, 15 Feb 2024 12:52:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708030354; x=1708635154; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=e0os/9yFdpHIAkKAumeZWSsYNTXNlbIBO0NQGDV4dvw=;
 b=GViDxwR8pFJ14r/FYvL7ijM269qXvve7qAXJSWnsjsSAGhP+uatAuvMv3M8w5WJ94b
 4SBcpAlvOc4s5wKaMqwuHAYZDO3sy/PH1gP3Twt6TsS18gFDRVYoFDNx1MFQgAnnbzAi
 JeNy40t5SeyUJmNbSHv0xdB99RvX/Ye5RUJpeR2AygnsflGKCYnKZMxARXSizGaACtLm
 FUJJOyAd9bGO+Cj70wraadh8w//sGqiD5cDNBeWl1yk26nEpfyBOrdMuRHzDQk4HH3m3
 F5jzXaTW1bWZuwQmE526n51kZ6L49kzt1YQCp0FJF/tUQaC5jedGF8dqLvjZjj9fXk8D
 ahmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708030354; x=1708635154;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=e0os/9yFdpHIAkKAumeZWSsYNTXNlbIBO0NQGDV4dvw=;
 b=syCeBNDDj0gtW3eUpx2PJutYOiPhOwkmD1erYwLSg+Rt5aD3Sx0fc2DIg14D4MyZEe
 DqeyPj9b1UU214AFU9W2r7LKQVPAOtYQTJ2wi1XR2s9xRA6DkekD4Y8hmZM0VJcWd6dG
 95MRqmmzIqzlaolEFDtIS+vP+o3zC1riKX/yblkcqPDXf3bkmDiw325IdQTelc6ee8w+
 qNNgi+d+PJkgFXHXTkwKrFkKHegJp5o882yqdDaOyJLL+7w75TLI5XYL64wzh9W4TtdS
 25MbbmXicCdJMb58YHaQY5tBh5OAeFDggWsXckkxRLqrlZdfDlD/zNhp7TTUzgc0bom7
 nEJA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWhD+O3f+xs1R3DdzLkKGb4VY1tAFSjcPx89v2/ax278XQgkmoCvQ1q/O8tpEzSoRd4ADqAY5/IH3vCT3aoA6woRRkShg==
X-Gm-Message-State: AOJu0YwygviBzpx3SHV0JCYOn/EVMCgdorjg3yLbYGHbQMC9iEn46t1m
 PHaDuSdZ6W5HY8V3sB/rBNzwFzR1X6oknji0GGW/DOVNf/lw9OkIE70aoYd2wSi3+sT+7LgAwlv
 H
X-Google-Smtp-Source: AGHT+IG3nkcTU33t4IS6BBhlo+z1DEplhYBUo8CKdnluZTdpg3oVhHyp0Bdh3HlQKJIvWODO4QFRGw==
X-Received: by 2002:a05:600c:602a:b0:411:b66a:5bf6 with SMTP id
 az42-20020a05600c602a00b00411b66a5bf6mr2222195wmb.5.1708030354199; 
 Thu, 15 Feb 2024 12:52:34 -0800 (PST)
Received: from lion.localdomain (host-92-17-96-232.as13285.net. [92.17.96.232])
 by smtp.gmail.com with ESMTPSA id
 e4-20020adfe384000000b0033cfa00e497sm194025wrm.64.2024.02.15.12.52.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Feb 2024 12:52:33 -0800 (PST)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Thu, 15 Feb 2024 20:52:27 +0000
Subject: [PATCH v4 09/39] gpio: qcom_pmic: 1-based GPIOs
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240215-b4-qcom-common-target-v4-9-ed06355c634a@linaro.org>
References: <20240215-b4-qcom-common-target-v4-0-ed06355c634a@linaro.org>
In-Reply-To: <20240215-b4-qcom-common-target-v4-0-ed06355c634a@linaro.org>
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>, Ramon Fried <rfried.dev@gmail.com>, 
 Dzmitry Sankouski <dsankouski@gmail.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, Peng Fan <peng.fan@nxp.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, 
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>, 
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, 
 Jorge Ramirez-Ortiz <jorge.ramirez.ortiz@gmail.com>, 
 Stephan Gerhold <stephan@gerhold.net>
Cc: Marek Vasut <marex@denx.de>, u-boot@lists.denx.de
X-Mailer: b4 0.13-dev-4bd13
X-Developer-Signature: v=1; a=openpgp-sha256; l=1524;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=0Cpoq4aK9px2MmgAZstpzaLCFy/v8Vx4qmVc23MI294=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhtRzlS02HicUMtxLBG/o/zE8dffFo6y25wcMHsbfmaEre
 IXzKO/8jlIWBkEOBlkxRRbxE8ssm9ZettfYvuACzBxWJpAhDFycAjCRDwsZ/kp1FgSxHv91e73V
 j4MaD6Xn9CzvWPHXxXDqk3+V8+Ufb1nG8M+s8v0OY49V/Oaz0hwLD33LZX0xcdqLl09uzb3w033
 PHY1dAA==
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

Qualcomm PMICs number their GPIOs starting from 1, implement a custom
.xlate method to handle this.

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 drivers/gpio/qcom_pmic_gpio.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/gpio/qcom_pmic_gpio.c b/drivers/gpio/qcom_pmic_gpio.c
index 6167c8411678..2a4fef8d28cb 100644
--- a/drivers/gpio/qcom_pmic_gpio.c
+++ b/drivers/gpio/qcom_pmic_gpio.c
@@ -209,12 +209,34 @@ static int qcom_gpio_set_value(struct udevice *dev, unsigned offset,
 				       REG_CTL_OUTPUT_MASK, !!value);
 }
 
+static int qcom_gpio_xlate(struct udevice *dev, struct gpio_desc *desc,
+			   struct ofnode_phandle_args *args)
+{
+	struct gpio_dev_priv *uc_priv = dev_get_uclass_priv(dev);
+
+	if (args->args_count < 1)
+		return -EINVAL;
+
+	/* GPIOs in DT are 1-based */
+	desc->offset = args->args[0] - 1;
+	if (desc->offset >= uc_priv->gpio_count)
+		return -EINVAL;
+
+	if (args->args_count < 2)
+		return 0;
+
+	desc->flags = gpio_flags_xlate(args->args[1]);
+
+	return 0;
+}
+
 static const struct dm_gpio_ops qcom_gpio_ops = {
 	.direction_input	= qcom_gpio_direction_input,
 	.direction_output	= qcom_gpio_direction_output,
 	.get_value		= qcom_gpio_get_value,
 	.set_value		= qcom_gpio_set_value,
 	.get_function		= qcom_gpio_get_function,
+	.xlate			= qcom_gpio_xlate,
 };
 
 static int qcom_gpio_probe(struct udevice *dev)

-- 
2.43.1

