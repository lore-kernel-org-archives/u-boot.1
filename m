Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C405AEE0206
	for <u-boot@archiver.kernel.org>; Wed, 11 Sep 2024 18:07:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 80BBB8930A;
	Wed, 11 Sep 2024 20:07:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="VkddneD+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F151E89306; Wed, 11 Sep 2024 20:07:22 +0200 (CEST)
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com
 [IPv6:2a00:1450:4864:20::431])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 146F289303
 for <u-boot@lists.denx.de>; Wed, 11 Sep 2024 20:07:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-374c3400367so119117f8f.2
 for <u-boot@lists.denx.de>; Wed, 11 Sep 2024 11:07:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726078039; x=1726682839; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Cmf/fbNVJaJLRb9lKxkY6Si07zCgMRRrId512VSL/bE=;
 b=VkddneD+Sy0EEcbRMFHW3n1hk8gMGOO1CEzzg9YL4G5d24HtqbBSxupJHdj6eG/vST
 Ifmehodc7eP4J0MQNiSU58CC/Acz90oTSFlKYqfwh4JUPEK1Ybn60ffNTTbot/DOwsv4
 ILuQW5EsuuE6W6/FCyfUf7yQrvFpNOYl4pddzY0NYFCvq0yDzHUC8MAwv7Vf6N2l8xBq
 rHypu3gh6eDV9gs+Mx1fmoYFZb8YIeEfTAH+6Y9JNRextZggBQ8043CVABMGgKywPMiW
 yOjaIsKvBoL670/Oj2GyLxotpAIBOGygCTNB5zqYzh+J0cN/YHgGILfMaMM7AFTZUx2W
 UghQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726078039; x=1726682839;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Cmf/fbNVJaJLRb9lKxkY6Si07zCgMRRrId512VSL/bE=;
 b=mgtlK54JfgwOM39myk0FemPqtLhDOH1MPrLSbSMtyKHYSj2/HSWqcLw/FxxlCM5nlI
 Ok/tlW1xtm0InTmRRFvjIasCZN+BZtsV6COQitAYJrStNtcMADi7KwbtStdSSk5bJfVF
 PXz7m4gFJliwJKXl2mjgG8xLYZ1fkZ/ETh5B+o8XG6Mt7f+VTsAXVsoM1DnYsAcWWO/0
 nEhJZssmU59dOX4zy/rC3yz8wHQ8kRyp2ZHzJtqUcugpj19xxlBAxukqTex9CH11wHJV
 y/ArOaqg4+SFm1U67WGLu85M8x5785a1BdbfM8h9a/RnMgfCF36p7Nem89XdYo3Pnq96
 /ymA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWxHUTPcBAOGtNNI17R2nySdHWoMeSPVcqAAFXjWtBkwPrb+WLTfPWagELD9XCw7lRiv3z3IL4=@lists.denx.de
X-Gm-Message-State: AOJu0Yyj2DrucHjsqgXEa4QmOb7vQ3u03WA3QoO6n3p6rkq0VPyWU/6f
 lfk+2VNzTVd5HH/cwaFaHMQjK69Zj8f0p8PMb9F1S61uzqbiLQOalPSEhkWwMhfqJQIViXs1m5d
 P
X-Google-Smtp-Source: AGHT+IHZIRPBZNjOFpv5tZypM7l1GWocrOO9ENFzxaZJhpakLdMar35o/uZUixTs4XTQxaPT2EsIow==
X-Received: by 2002:a05:6000:87:b0:374:c3e4:d6b1 with SMTP id
 ffacd0b85a97d-378c2d4d177mr60248f8f.44.1726078039363; 
 Wed, 11 Sep 2024 11:07:19 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37895675b8bsm12192404f8f.54.2024.09.11.11.07.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Sep 2024 11:07:19 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Wed, 11 Sep 2024 20:07:15 +0200
Subject: [PATCH v2 2/2] pinctr: qcom: sm8250: add special pins pins
 configuration data
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240911-topic-sm8x50-msm-gpio-special-pins-sm8250-v2-2-c49834055128@linaro.org>
References: <20240911-topic-sm8x50-msm-gpio-special-pins-sm8250-v2-0-c49834055128@linaro.org>
In-Reply-To: <20240911-topic-sm8x50-msm-gpio-special-pins-sm8250-v2-0-c49834055128@linaro.org>
To: Caleb Connolly <caleb.connolly@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>, Tom Rini <trini@konsulko.com>
Cc: u-boot-qcom@groups.io, u-boot@lists.denx.de, 
 Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=3125;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=9nqmucjOd8nAPp4aFInlnm94wqsPYUREu9/EeJ+2/JY=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBm4dxU6Z44LkBSin8Eg9JU0TGCL6JRtKJKcbZQGIKN
 KuhxGx+JAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZuHcVAAKCRB33NvayMhJ0YrJD/
 wKtuUZtoqqdhL8WEaPCLtANYu0Ji8KWEjV8p8BfZPJke8NGqS1SMKBEa7FOrwpVjBn7DfG2a5wOkge
 2jiMhRfh+THJbcEnkgHjWgzRG69eih2pQ3Kn43EJOGUS94xSuXrXWAZh8xHvyI1qxOkkia35bQmUKY
 jkz6gMdNGLlc4xgSFih8ZSWT/NbfVxsmD2/Ai48osWPg1/K6SGbngX/wboajGNdj1H7G9IcuppZvZb
 4pcFERTb/YcifGdSZAk0mAUqVu/Wv+K8GUaU+mdKyTf9HVgndDIM+Y6YdZmuYlGOo/l0OBc3hB85AS
 sk5/RalOQoWUdmk/AjtnsMRikaMucF7EKECMTr2Mx1ghc2medxDhnUT0x5fZqufWUFXvFtmr2MxFxT
 CHOHxw01PLtD3xfRqxobPwIdSBvq9qqHcmVvYFpYcbeKqymfBssxV+GuAktFfG76ERJsyb6ygmKkDw
 ovEStiieo49lfKzdYe32yUQx4ur+IYM+xNVrM+XiQbqN2P/9DYmLIda9nPa5DA9KtoN5nyQXqYyQz6
 F7iHP65K21nvpOWGCfUX1tSoWiaZ023vjx5D/C+9LFssCT0lVNYnQ1NvRSUrYAw/XfylZhCfloHX5X
 Q3rHBgqb+WF4FoGLVCP1CDzbS3ZjryxbVctCFv8X6LR5xCwF9wgzdCuRdmKg==
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
 drivers/pinctrl/qcom/pinctrl-sm8250.c | 42 +++++++++++++++++++++++++++++++----
 1 file changed, 38 insertions(+), 4 deletions(-)

diff --git a/drivers/pinctrl/qcom/pinctrl-sm8250.c b/drivers/pinctrl/qcom/pinctrl-sm8250.c
index dac24f11bc2..cab42fa64ed 100644
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
@@ -52,7 +81,6 @@ static const unsigned int sm8250_pin_offsets[] = {
 	[162] = WEST,  [163] = WEST,  [164] = WEST,  [165] = WEST,  [166] = WEST,  [167] = WEST,
 	[168] = WEST,  [169] = WEST,  [170] = WEST,  [171] = WEST,  [172] = WEST,  [173] = WEST,
 	[174] = WEST,  [175] = WEST,  [176] = WEST,  [177] = WEST,  [178] = WEST,  [179] = WEST,
-	[180] = 0,     [181] = 0,     [182] = 0,     [183] = 0,
 };
 
 static const char *sm8250_get_function_name(struct udevice *dev, unsigned int selector)
@@ -62,7 +90,12 @@ static const char *sm8250_get_function_name(struct udevice *dev, unsigned int se
 
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
 
@@ -76,6 +109,7 @@ static struct msm_pinctrl_data sm8250_data = {
 		.pin_offsets = sm8250_pin_offsets,
 		.pin_count = ARRAY_SIZE(sm8250_pin_offsets),
 		.special_pins_start = 180,
+		.special_pins_data = sm8250_special_pins_data,
 	},
 	.functions_count = ARRAY_SIZE(msm_pinctrl_functions),
 	.get_function_name = sm8250_get_function_name,

-- 
2.34.1

