Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FA4BC4345F
	for <u-boot@archiver.kernel.org>; Thu, 18 Apr 2024 22:48:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3D4BF880A1;
	Fri, 19 Apr 2024 00:48:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="k4OxrWT6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8E8A88869D; Fri, 19 Apr 2024 00:48:02 +0200 (CEST)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8EA5A87FCD
 for <u-boot@lists.denx.de>; Fri, 19 Apr 2024 00:47:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-41907443759so980295e9.3
 for <u-boot@lists.denx.de>; Thu, 18 Apr 2024 15:47:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713480478; x=1714085278; darn=lists.denx.de;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=aGGbvWdPd/GCZTuGuZZsJ5QPLrqO+XJV5qfEz5h3ZxI=;
 b=k4OxrWT6h8/Hy+/kSc72VJwGoapGDo09GDlVZb/KGdjR0HlAEzpRy2glWJvfx+kTMw
 rvlgF9Eu1oOWh+kMEF5M/7UA4LGv/LMd0mb4dBgFw1q+wpIpMm1y7cjvvov8g6OWV8s1
 5JBV65r2I3p6eLW9Z+HlxszETH3Ub4LmGcT1fZhGV0pGwF37WyJ7AdE7I4X4BLXdMRt5
 HIy7Nb206ReugSTKzd6jD9JXMt4pcEjquLyvPrYDn3DGahleg2vkIoYZy3nOg196lGco
 AXkT3AYrI2HCHkVkfn44SR4V0DmLwyvGgbHG0lH44/5wp5Hx3gRoosRXWSCGqK0LSGLB
 AO+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713480478; x=1714085278;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=aGGbvWdPd/GCZTuGuZZsJ5QPLrqO+XJV5qfEz5h3ZxI=;
 b=xKDuB91WzoEaaulv5MpWoFoshN17FvqKsf/LafiyrtV39nXZRyteXh7uhWDiGqS6PJ
 WOMUrc2Mjr/S5vDweuSEAARsG/LauHACLPj+yqLH7fsFUOPirdjvRTXnxeVO/RlmO0nP
 S6i6D4n2+w66jIn3EmYxcc6Pm5/8OrUiJBXDNX0vZEO0Vp2aBi54qE1076J5LV+S/6h7
 YT4GmMYX1U4HpYBHJP9fVMGgIDMVAFh0bPauzCM41NGZXXhBrDl9g5UXA9VS7Wn7Duay
 ngy+9Q0RlgjsM5VJjMpGTJ2fMTqMq5ZNg6CWJDj9Tyt0/fBhHjl/CupucpfqMT4qK4XX
 N6BA==
X-Gm-Message-State: AOJu0Yx7n1TbPTvsJHIKUg8QG203h8y+KSP5fliqG6Mt+lR9M+oy5n/q
 ZI+AMf92YPW4DOnuA+YbFS2a4jxzMg06IpYJcKHV3ggetLWSnnwUTW1XWy9Ies0=
X-Google-Smtp-Source: AGHT+IGs2UM3d1NJ0wQTfvkWPekBv9rxqVs/SC6YAnRfxE2+0P78rwF8DZW5C6d76J4kj0KYFJ5hWQ==
X-Received: by 2002:a05:600c:4fd1:b0:418:d626:30e4 with SMTP id
 o17-20020a05600c4fd100b00418d62630e4mr197941wmq.3.1713480477741; 
 Thu, 18 Apr 2024 15:47:57 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
 by smtp.gmail.com with ESMTPSA id
 hg12-20020a05600c538c00b00415dfa709dasm4155131wmb.15.2024.04.18.15.47.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Apr 2024 15:47:57 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: [PATCH 0/2] i2c: Add support for Qualcomm Generic Interface (GENI)
 I2C controller
Date: Fri, 19 Apr 2024 00:47:52 +0200
Message-Id: <20240419-topic-sm8x50-i2c-v1-0-67651e27f23a@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABijIWYC/x3MSQqAMAxA0atI1gbaYpyuIi60TTULB1qRgnh3i
 8u3+P+ByEE4Ql88EPiWKMeeocsC7DrtC6O4bDDKVKrSHV7HKRbj1iZSKMbiTJqpqR15aiBnZ2A
 v6V8O4/t+6ZkFm2IAAAA=
To: Tom Rini <trini@konsulko.com>, Heiko Schocher <hs@denx.de>, 
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>
Cc: u-boot@lists.denx.de, Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=1440;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=UcQolJ1uQ744UdZuai8EmgtlZT+cyxFLy2l7ScqKdn8=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBmIaMbg02g8hu5EHZkzwEoARlQJJJ1MsDE4haz5kZW
 zb3/VdqJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZiGjGwAKCRB33NvayMhJ0Xt6D/
 0RBK9uV7/Z7QYCOfetDUXY/mL00auJS0/73oSyVCLWpC5oHPqs/s+a7267h7qFZKSdWhkqPbcqxCTi
 LwnPqAOz17II2dK7IUTBlcYQSWLulTemOjMz1v0tqJY9FNJHtfau9qH9v141HYx6U51P1uYYya6U+T
 G+CtE0ReFvjamG3p1JVE4yNOLGK3iJm0AQw0vcLwAACSYv/hbj5uF3sehsetcb/npedARQzo3/z8Uu
 844BgJSGyK+OriCHRSsmQ2Az2uhjfTBZ1o14p32gzWralmpLtRWC6QRUJ7ld/itm81dx/RC3ht9RH0
 c5Gq1XwTddee6IqgdshPye1qB6/P71M+aaJnm0ke0t+Z5e1O61gug9qIeDTtJTKbH29VMtn3TSmkd8
 uq50jf84O3hfvAu1fUvhpzD9fvKkv69yHNIb22FRV4L2yiyPDoee4RqtsCf5Xt0fyLg+mWMlBCCsUn
 HieiLCEiF/tv47pbLFKmFTld6R/cz/pYXW9u0iHS5xhJKSTL1VFDMXutLZH2zr17js1hhwO1eCgpSJ
 MG5Zs7AGd89CTwts2mfCSR4sT3Cw6w+DVFairT9dhV2vOVERac5hS7j213vXOsPbySUuAJR23ecW4I
 s1rThoY8llJ25DxOPSkx8AjGWIGEHEcdC29r0Jmk1Qi8WtL9T84eCZQmf0zQ==
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

Add Support for the Qualcomm Generic Interface (GENI) I2C interface
found on newer Qualcomm SoCs.

The Generic Interface (GENI) is a firmware based Qualcomm Universal
Peripherals (QUP) Serial Engine (SE) Wrapper which can support multiple
bus protocols depending on the firmware type loaded at early boot time
based on system configuration.

It also supports the "I2C Master Hub" which is a single function Wrapper
that only FIFO mode I2C.

It replaces the fixed-function QUP Wrapper found on older SoCs.

The geni-se.h containing the generic GENI Serial Engine registers defines
is imported from Linux.

Only FIFO mode is implemented, nor SE DMA nor GPI DMA is implemented.

Finally enable the driver in the default Qualcomm defconfig.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
Neil Armstrong (2):
      i2c: Add support for Qualcomm Generic Interface (GENI) I2C controller
      configs: qcom_defconfig: enable GENI I2C Driver

 configs/qcom_defconfig     |   1 +
 drivers/i2c/Kconfig        |  10 +
 drivers/i2c/Makefile       |   1 +
 drivers/i2c/geni_i2c.c     | 576 +++++++++++++++++++++++++++++++++++++++++++++
 include/soc/qcom/geni-se.h | 265 +++++++++++++++++++++
 5 files changed, 853 insertions(+)
---
base-commit: b2511143fba4c0631446c968fb4c0d962b01d850
change-id: 20240419-topic-sm8x50-i2c-b51e576d5f57

Best regards,
-- 
Neil Armstrong <neil.armstrong@linaro.org>

