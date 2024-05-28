Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3E93C25B79
	for <u-boot@archiver.kernel.org>; Tue, 28 May 2024 08:32:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B20E988445;
	Tue, 28 May 2024 10:32:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="u5H6rRdE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E8D8A8845C; Tue, 28 May 2024 10:32:04 +0200 (CEST)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7337788440
 for <u-boot@lists.denx.de>; Tue, 28 May 2024 10:32:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4211a86f124so4320255e9.0
 for <u-boot@lists.denx.de>; Tue, 28 May 2024 01:32:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716885122; x=1717489922; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ls49B4+5tvTEi6VVvn1gKRbdfX9kUtVC689eYq/FhUM=;
 b=u5H6rRdEg2B/v45Dk+1ze0y1oTUPvyN6Aizku9EdMo5eWi6Pkixa/bn4WVFGBRl8t0
 3rjRx095ByuZKaW0wFjGAkaXddnQuf+bZ/f6xNolpNvb3Mj7KEgp5/x/ea5YdIX0+n1y
 lVcnjubRCwWDN56UwRXCSXRzP8PeNz0EVNBtJVTzqiiVhXY58wC4SsEW/GWr85WlQGzw
 vcF2ZgViKWuekxASUNeCAKHb/vEhPT1jr0e075DaNqXBW1T9M9NFtUl/qIR4RwAhveAD
 p8PFYNohdEzG7MHE6EGUZ34RoYN4vb5lt56ad/HASKF0RBMrPiWjWf4BVcfpmkO/9faS
 iLBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716885122; x=1717489922;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ls49B4+5tvTEi6VVvn1gKRbdfX9kUtVC689eYq/FhUM=;
 b=ha/5f+6jwaVGlKcr5mwkFKBRtNyL9BJuhvtWUJaJAQCfRtnfn2s3sVoaMJLyvh5K3+
 fV+5YEvYA7N8vw8jPuwHIFN7fHHqabIzX6xOGtJxJ719D3tMfMOVkjUUVbjJX3CkbULy
 vNeJ4JmA2Q37sxcrDDPXL9Ds9R2xeKi6mD5UGUxVcOV4giBzQJf5CJmUg5FwVnH/rs2Q
 g9DzbHi1ZqC0kUN0jbq9OHQyM3YvN8kQ6hBrahNyLoYWeRKKaSCCFLGE5Tg/42bfi5QQ
 NNcXcCKF+tX6eQINpfGypQFTz2HviYy36gRYe27LgUPulsfxIil5ZjQhM5z+miNGJg2U
 LC6g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXZxGHuAJ3RXmvrr6kjUR5UYIzUsXfBMZ3OvvfCOukzBJvL0aX3Et7kLf258SJ9wqavhZDOs//fUIXtSn7XTxN3XoiOEw==
X-Gm-Message-State: AOJu0Yz/edoHeRrPThnDcfkTpRAangY17o49WoMUCyaxvYcXwqOMX9Sa
 tuf4EC4OAB6x/T7/KzEdTwp9pK1XrE7ouwApWb2gt5ByzPGk4vUMe2KHcu71lDs=
X-Google-Smtp-Source: AGHT+IEsYKNw30n91W5amD3QZsY6OvlyGf3GTaBL+xhcgYmXeU47l4AwQm0u1QGiD8R7k6/tUES7nw==
X-Received: by 2002:a05:600c:3145:b0:419:f9ae:e50 with SMTP id
 5b1f17b1804b1-42108a2145bmr86154985e9.37.1716885121705; 
 Tue, 28 May 2024 01:32:01 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42100ee7f1dsm167122035e9.7.2024.05.28.01.32.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 May 2024 01:32:01 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Tue, 28 May 2024 10:31:54 +0200
Subject: [PATCH 2/5] arm: mach-snapdragon: gpio: introduce msm_special_pin_data
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240528-topic-sm8x50-pinctrl-pinconf-v1-2-54d1e9ad7dfa@linaro.org>
References: <20240528-topic-sm8x50-pinctrl-pinconf-v1-0-54d1e9ad7dfa@linaro.org>
In-Reply-To: <20240528-topic-sm8x50-pinctrl-pinconf-v1-0-54d1e9ad7dfa@linaro.org>
To: Caleb Connolly <caleb.connolly@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>, Tom Rini <trini@konsulko.com>
Cc: u-boot-qcom@groups.io, u-boot@lists.denx.de, 
 Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1356;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=peCV0h8P6z0PbDEmT1d31btpJwWRLaTftm13hTAtKBc=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBmVZZ94yuS1jPMOKsy3dcWoKZhC16CLRzt6YL+LlZh
 xsDVLneJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZlWWfQAKCRB33NvayMhJ0aTREA
 CBGrzeOpeqyGxzpN3Y4JG7tVj9yBPxO/xNFTRSpfomTUy1YAEnvKK1nPXtizMuwuXaq9YHkYB9CTQG
 xDVz/vbwV6GnWhl576R9tV0r75LDAtFhLK2vO2Mo9IyHoBpcGJD7/pEUwqsw8IeOhKZ1LdsNisnuHb
 3yyOGm0fLe2jFzAgphjyI9p5BbsMENJR3YYCBAdY73e6pZzRr8Oi0dzXPc/QO8PU7oNVVZfDzb72gf
 81I0TmgwnJrbfpmsl/lX549jNowNPu6res6e7pqfkm21Q43aWx11AxbtccqlFr/qxi+DYUCheNIAzm
 sdaYxpUcFH8BdrfroCJQlOPXk10kzEWOZamm7QQRl7n2jeZ4w3SKlMMu8tCl842gCTCIzglYCm7PVJ
 N6jWoGyHiPUaMJXdubxTOPJSYEuJ4t7qWZ20ntY68tdlAP5PC7QJsXBj20uOQM/k/RwNigl2NLZEo4
 EmCkFPQMdk4l0KlYSAUG6/OAseukVc/OTMZu63ogdV0TimTTazFTnBZleeVspQ3QCVmzQgftSu8Cmf
 t9Z/DlUR5JgWEEb2upjYx0Bqd6upYIASU66pCmmIaShc6XD0LecgBPQUUqF1yH2fneA1y5MG4xeIB0
 hQm3pGjfA6BXjqJCIn2SZK6hL9l9ZaHwVN64N77TzYl7mVtkmwK/6ZJbWTNQ==
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

In order to help setup pin configuration for special pins (UFS, SDCard),
introduce the msm_special_pin_data struct largely inspired from the
Linux conterpart but with only U-Boot required fields.

This struct is added to the pins_data to allow specifying the special
pins data for each SoC.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 arch/arm/mach-snapdragon/include/mach/gpio.h | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-snapdragon/include/mach/gpio.h b/arch/arm/mach-snapdragon/include/mach/gpio.h
index 53c6ae06490..cc8f405e20b 100644
--- a/arch/arm/mach-snapdragon/include/mach/gpio.h
+++ b/arch/arm/mach-snapdragon/include/mach/gpio.h
@@ -10,11 +10,25 @@
 #include <asm/types.h>
 #include <stdbool.h>
 
+struct msm_special_pin_data {
+	char *name;
+
+	u32 ctl_reg;
+	u32 io_reg;
+
+	unsigned pull_bit:5;
+	unsigned drv_bit:5;
+
+	unsigned oe_bit:5;
+	unsigned in_bit:5;
+	unsigned out_bit:5;
+};
+
 struct msm_pin_data {
 	int pin_count;
 	const unsigned int *pin_offsets;
-	/* Index of first special pin, these are ignored for now */
 	unsigned int special_pins_start;
+	const struct msm_special_pin_data *special_pins_data;
 };
 
 static inline u32 qcom_pin_offset(const unsigned int *offs, unsigned int selector)

-- 
2.34.1

