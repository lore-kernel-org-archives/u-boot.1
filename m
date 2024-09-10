Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50EACECE582
	for <u-boot@archiver.kernel.org>; Tue, 10 Sep 2024 08:58:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0C74988F45;
	Tue, 10 Sep 2024 10:58:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="KpbdBtB5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1228D88F4D; Tue, 10 Sep 2024 10:58:24 +0200 (CEST)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 58AA188F44
 for <u-boot@lists.denx.de>; Tue, 10 Sep 2024 10:58:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-42cc43454d5so1573675e9.3
 for <u-boot@lists.denx.de>; Tue, 10 Sep 2024 01:58:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725958694; x=1726563494; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=gPZWPtvJ9C5F6c4zaPRHfI/0I5S5iUkcV7tAc+zevEw=;
 b=KpbdBtB5F98pnqZFhlvb2ywGaxwtcc3ocje3kK5RXuaAhn4/cQWruIxcoqExfP3Y57
 FcqSceiAWX4jvpACTt0eK1rk8KLdh+sTmgFrUCX+GnGeRtkmg3Z1a+T2XpE2xVuAI3iE
 I8lJvm7XztvSEr1AnePypEJjwLR8upD0acLJd2jYyD/phui2zm6ptrtOj/qOWCM666cj
 OZ90uZH8l0+Wz43JmCFjun76HYnd+/DLsaFToZUkExS+lS5v5VxP6pgWntC1puFdZcuY
 NKMUpw+8+daAokGaklx+KaP3WGkjU+2CyO8ZctL7/M3VyKxPhYATrnPkbmlb8njfz3VJ
 q/1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725958694; x=1726563494;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gPZWPtvJ9C5F6c4zaPRHfI/0I5S5iUkcV7tAc+zevEw=;
 b=aqLya0pMmlthqSwrKqNJT+GhlaNjJ505o8jsYfu1wj7pt8EqZIQe3+W47kPMQRfV1f
 /Bm/o/4MJGOCLHIZWHvEWTvvThBCJ/ecK+m+FNV8L7j6KC4FgLjOSMA1/hSLwfC+KFvR
 8ZseyoTnvDF2VlJvEW1y+Zcwxl5ApvwhmvYmQ7jaHQIGLE1e06nC6Co5pjhBckdu58np
 f9FACVuWWBLtS1+JOMpqOu7dYYZSPea4Tu/WrEOb2DOjmoDn/XaGIY4CpZX9nKGViiBD
 8Tcj05p3EXKKnFzU4LY4B4oOCp3M/0RU3D9F1Lj8Lytx/dg/1aGkMbmsFMq7hj6ym4Tw
 xWYA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU36UF8soRD2/I+YAtWObGWc2+3oHtFdatdH8DFGxNWXROqzUbRRq9o1EjrkaqFEiuU9xTIdio=@lists.denx.de
X-Gm-Message-State: AOJu0YxOkxwWJItvptKmGAn4gZH774o542ED5SEAVUzoG7jjwI5+weef
 RPWeKHuh4bwNLlnLgvzjuiu1IJiNhELFPMQyGoEuOwF2Iv4SIVzvf/DMOKQeAxI=
X-Google-Smtp-Source: AGHT+IFdsmCA77dms3T9jTmzQCdZrerqsQTEC+aUJepZUZ8YeglJbZJSK9MMV6y6u6hyYWfpxYfjsA==
X-Received: by 2002:a05:600c:46ce:b0:42b:ac94:6929 with SMTP id
 5b1f17b1804b1-42cae79c465mr72284575e9.32.1725958694062; 
 Tue, 10 Sep 2024 01:58:14 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42cc01d4617sm12905325e9.0.2024.09.10.01.58.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Sep 2024 01:58:13 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Tue, 10 Sep 2024 10:58:07 +0200
Subject: [PATCH 2/2] pinctr: qcom: sm8250: add special pins pins
 configuration data
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240910-topic-sm8x50-msm-gpio-special-pins-sm8250-v1-2-50623a7e4931@linaro.org>
References: <20240910-topic-sm8x50-msm-gpio-special-pins-sm8250-v1-0-50623a7e4931@linaro.org>
In-Reply-To: <20240910-topic-sm8x50-msm-gpio-special-pins-sm8250-v1-0-50623a7e4931@linaro.org>
To: Caleb Connolly <caleb.connolly@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>, Tom Rini <trini@konsulko.com>
Cc: u-boot-qcom@groups.io, u-boot@lists.denx.de, 
 Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=2622;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=cWamk3BaNR7zDwiQskXuBiLuOQYcDKjaVh4Dia/789E=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBm4AojoGO9FiD7hBUx0LQiqg217DyPR3dm97W9oHXg
 9onjwcGJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZuAKIwAKCRB33NvayMhJ0ZTmD/
 9B7bPjsBS7TV6CnnkSX/X8bnmOyYK/zXDH4ImQfn7tRYPtYlI/S3g0+UHFOsGIfJTUlW+Qt2leVWDL
 ErSebkxy/IuUQPsZm7KY6dBHgypSa1KIeT8E8FBm78pa75BhCpN0sKFLqN3bpteW+MY71Rxe6+Al9F
 Ujzjh9GrS4LAWChQ++4z1Mzd3pNAKqaXwTHwGnsvEAevcNV73Qewsd+K612wUdnVLB6hRwOUPDlsol
 CkDYlKPKLtTLZg13nZcvnyCtIHect+cwu2aZqcHgjtncNZ0OVLP6lFfutrB9hllNcb4KbxE/G6pXk3
 ZbcMxfZh9q8ey4EDnq2JN5nAX0kArkMpVD9CQa4eTbxQiGhlIzu2E7b0xTVJozpbqUephSiUPtBlU/
 VQTyVqfgVR+7aqNq9AcG2diwmHN6R6yC26S/P4jVbzyKkr8EAQUD9f0D3ucSYIYGmMtFu445Nfn7ti
 7yDm2LBinv7z904nO6OvmwZ8Ko3/uuD9vSzhYHE3C6xzIZ8njhZNSue1wRsCuLEPuuXGPl7yc5Mh8t
 pNwiy2C0I227/M+9KdncRBhd/ZTaRHL8XojfgN0rZZFRc7m2xcrTc0X9moaGL3JD1nb98j9idbIBEn
 3/TNxJR3vT4bTOiulGGJmbhFu8bXpFkzl+F+C2Sz8fjK06Cu+QCGwCiZfFhA==
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

Add the special pins configuration data to allow setup the bias
of the UFS and SDCard pins on the SM8250 SoC.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 drivers/pinctrl/qcom/pinctrl-sm8250.c | 41 ++++++++++++++++++++++++++++++++---
 1 file changed, 38 insertions(+), 3 deletions(-)

diff --git a/drivers/pinctrl/qcom/pinctrl-sm8250.c b/drivers/pinctrl/qcom/pinctrl-sm8250.c
index dac24f11bc2..69c907e3868 100644
--- a/drivers/pinctrl/qcom/pinctrl-sm8250.c
+++ b/drivers/pinctrl/qcom/pinctrl-sm8250.c
@@ -18,8 +18,37 @@
 static char pin_name[MAX_PIN_NAME_LEN] __section(".data");
 
 static const struct pinctrl_function msm_pinctrl_functions[] = { { "qup12", 1 },
-								 { "gpio", 0 },
-								 { "sdc2_clk", 0 } };
+								 { "gpio", 0 }, };
+#define SDC_PINGROUP(pg_name, ctl, pull, drv)		\
+	{						\
+		.name = pg_name,			\
+		.ctl_reg = ctl,				\
+		.io_reg = 0,				\
+		.pull_bit = pull,			\
+		.drv_bit = drv,				\
+		.oe_bit = -1,				\
+		.in_bit = -1,				\
+		.out_bit = -1,				\
+	}
+
+#define UFS_RESET(pg_name, offset)			\
+	{						\
+		.name = pg_name,			\
+		.ctl_reg = offset,			\
+		.io_reg = offset + 0x4,			\
+		.pull_bit = 3,				\
+		.drv_bit = 0,				\
+		.oe_bit = -1,				\
+		.in_bit = -1,				\
+		.out_bit = 0,				\
+	}
+
+static const struct msm_special_pin_data sm8250_special_pins_data[] = {
+	[0] = UFS_RESET("ufs_reset", SOUTH + 0xb8000),
+	[1] = SDC_PINGROUP("sdc2_clk", NORTH + 0xb7000, 14, 6),
+	[2] = SDC_PINGROUP("sdc2_cmd", NORTH + 0xb7000, 11, 3),
+	[3] = SDC_PINGROUP("sdc2_data", NORTH + 0xb7000, 9, 0),
+};
 
 static const unsigned int sm8250_pin_offsets[] = {
 	[0] = SOUTH,   [1] = SOUTH,   [2] = SOUTH,   [3] = SOUTH,   [4] = NORTH,   [5] = NORTH,
@@ -62,7 +91,12 @@ static const char *sm8250_get_function_name(struct udevice *dev, unsigned int se
 
 static const char *sm8250_get_pin_name(struct udevice *dev, unsigned int selector)
 {
-	snprintf(pin_name, MAX_PIN_NAME_LEN, "gpio%u", selector);
+	if (selector >= 180 && selector <= 183)
+		snprintf(pin_name, MAX_PIN_NAME_LEN,
+			 sm8250_special_pins_data[selector - 180].name);
+	else
+		snprintf(pin_name, MAX_PIN_NAME_LEN, "gpio%u", selector);
+
 	return pin_name;
 }
 
@@ -76,6 +110,7 @@ static struct msm_pinctrl_data sm8250_data = {
 		.pin_offsets = sm8250_pin_offsets,
 		.pin_count = ARRAY_SIZE(sm8250_pin_offsets),
 		.special_pins_start = 180,
+		.special_pins_data = sm8250_special_pins_data,
 	},
 	.functions_count = ARRAY_SIZE(msm_pinctrl_functions),
 	.get_function_name = sm8250_get_function_name,

-- 
2.34.1

