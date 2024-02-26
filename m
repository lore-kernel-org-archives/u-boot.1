Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C311C5478C
	for <u-boot@archiver.kernel.org>; Mon, 26 Feb 2024 17:28:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 05CD887F8F;
	Mon, 26 Feb 2024 18:26:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="lHYQPm+d";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C7FCE87F95; Mon, 26 Feb 2024 18:26:36 +0100 (CET)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F30B787F66
 for <u-boot@lists.denx.de>; Mon, 26 Feb 2024 18:26:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-412a9a3dba2so3152565e9.2
 for <u-boot@lists.denx.de>; Mon, 26 Feb 2024 09:26:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708968390; x=1709573190; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=KW+sKSQf/6E9mwui6XfMXS2kZcKZgg2x/BDTjJepLUk=;
 b=lHYQPm+dEcujGY7qI/yhwr3tSwTO+h6GV4E3lDtacG6rK/ClEHtIzYYpvBTIoU8HsO
 8C3bLFCch6f5Gq3nkaO3UF9MRbfk28Shpv7frNSnQ8PVmr+gBJNIrhZXh6I+c423f+zm
 57x/ggJ1r3++v3gpKnBmu7wtH8vfJgQhqeYEjYJh5FBjEJ2H1oDf7QtdcUzxkoQiAzzt
 C7tLKg45EmumpDccPd6WJO2X71mu3NjVHtW9hFLPi9yKqBaAj/R1CWWJRpUaYgpIRxcs
 U+gzehtGBpeGW0JHM+VCX/90QsoaWqeK14kFxZuL7Pm6eonK4C4eEbIPAAgsv6Q2o3e+
 nVfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708968390; x=1709573190;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KW+sKSQf/6E9mwui6XfMXS2kZcKZgg2x/BDTjJepLUk=;
 b=q1VUqGbJp97zEmjWTy+op6DHHudhC93sc0ebFBDY8wOXc7cVig3TKdEVQN7E7JRQUu
 lOMUZkTACh2MGNfPOe0/XK7gXZbWMOBwCJ06qS/5VdfEsWyUM3qR0pRO2UV+Pl/UPnpb
 a56nl71ajhwXd+BHGCLPB/IxDMEOo+yGLyFGPZLzM5XKj5LXeDLZ6O6M5GqCgpypJzaK
 KWSDGsonq1N1yxrHxzp6V3p6i+e/qHq9OrHntiPjupa9w94K+c0UszzjyQMr43o2S+jb
 LvZBJSD40ZMGv5R0EflW8dSSWPZDwMyKtYART6dsiv+FP0TSHvWNlH6uEs7G3TImM/SW
 r1gQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVBlw3ZgfspRbksUFgSI5zy55PXXkFtrQSlXuBcYrWgENLmEqGyuzNQvGLuDiXTGKkrj/4PMu+qQ9mCSZ1p0dILxEOIlQ==
X-Gm-Message-State: AOJu0Yy8BvxD9/+F6rx2TKTDHZrJ/yh8BpLySsQxDDmkx45G1yhh7qjt
 WzYNI5emUMApnSrwMHxIC7+nR3M5OZ7tqrAYanqXI+9j4pWkZjlzyuXNbptstF8=
X-Google-Smtp-Source: AGHT+IHqdo9yOWxE1M4HJ8dsaDULMzDyc4ZQp/j8oTA/KR9Jjb7I/QAb9xC46WQkzD+MSMxx7rlLTA==
X-Received: by 2002:adf:da45:0:b0:33d:d251:9761 with SMTP id
 r5-20020adfda45000000b0033dd2519761mr2976657wrl.49.1708968390515; 
 Mon, 26 Feb 2024 09:26:30 -0800 (PST)
Received: from lion.localdomain (host-92-17-96-232.as13285.net. [92.17.96.232])
 by smtp.gmail.com with ESMTPSA id
 bt1-20020a056000080100b0033d9c7eb63csm9142256wrb.84.2024.02.26.09.26.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Feb 2024 09:26:30 -0800 (PST)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Mon, 26 Feb 2024 17:26:13 +0000
Subject: [PATCH v5 09/39] gpio: qcom_pmic: 1-based GPIOs
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240226-b4-qcom-common-target-v5-9-10c8e078befb@linaro.org>
References: <20240226-b4-qcom-common-target-v5-0-10c8e078befb@linaro.org>
In-Reply-To: <20240226-b4-qcom-common-target-v5-0-10c8e078befb@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1693;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=4MHOR1VQtji61FmN94QIE5xA1OBam1yPKJk1BdMZ/0I=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhtQ7J3dydy6SkzmwkKdX6uzinfd88l5WfmXYFql4a9PPi
 qBX71f/7ChlYRDkYJAVU2QRP7HMsmntZXuN7QsuwMxhZQIZwsDFKQATebmB4X90kPtpt8chWQeW
 XDseKSy/6dyj3HKfZQaV7n57jN+ELvFn+Kfx7VeI7H7WFWlC8yd+n+hlkbF4Z8V0K/MvuT1xDxo
 0W+oA
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
Reviewed-by: Sumit Garg <sumit.garg@linaro.org>
Tested-by: Sumit Garg <sumit.garg@linaro.org> #qcs404
Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 drivers/gpio/qcom_pmic_gpio.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/gpio/qcom_pmic_gpio.c b/drivers/gpio/qcom_pmic_gpio.c
index 6167c8411678..2a4fef8d28cb 100644
--- a/drivers/gpio/qcom_pmic_gpio.c
+++ b/drivers/gpio/qcom_pmic_gpio.c
@@ -208,14 +208,36 @@ static int qcom_gpio_set_value(struct udevice *dev, unsigned offset,
 		return pmic_clrsetbits(dev->parent, gpio_base + REG_CTL,
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
 {

-- 
2.43.1

