Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD15FCD1284
	for <u-boot@archiver.kernel.org>; Thu,  4 Apr 2024 16:46:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 32AD78840D;
	Thu,  4 Apr 2024 18:46:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="G+CswkDQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AF9808840B; Thu,  4 Apr 2024 18:46:52 +0200 (CEST)
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com
 [IPv6:2a00:1450:4864:20::433])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B7C10883D0
 for <u-boot@lists.denx.de>; Thu,  4 Apr 2024 18:46:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-343cfa6faf0so365255f8f.0
 for <u-boot@lists.denx.de>; Thu, 04 Apr 2024 09:46:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712249210; x=1712854010; darn=lists.denx.de;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=aza8cbhF3FRhggAGUdtv78065ZY+agvKY7Ok1btBDoI=;
 b=G+CswkDQXNxVodSEcucPva789NQ0nEL3Y6yLPVh9OK4qszI6SVm6i/FIwPQMZ4CWc1
 SFugHbWyWAGmoS5SwS2LAD5lP9gmtjpTU2Vvxh48ZaKb4IZ8iXUi3zUCaInFfD+zvTvu
 bVglvaLuXzbQK3b/HLkgRUydwnRaXjlNWTg9SxZSpa/PUbmNG1dSlVBnkK6RDsKItUmC
 FG8IAIeP/uWMcfCMmWoSjgPSuet4m2svXgPmou9Y8bscyx1jaKZ4Q+xfAWVpjY4/GN/l
 j7OlRb5ghgT6MRfRD9lJ4wRHaUSKrUnhbvX6bON4KV0LjEvkjXc7XbqTye+U60xJrf+O
 /dBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712249210; x=1712854010;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=aza8cbhF3FRhggAGUdtv78065ZY+agvKY7Ok1btBDoI=;
 b=lkQaMqDR33LDcvnsyX+sIHJwKLUAUojEvGmd5u9Q0jwi5bJ1ZeNcVF3MXCnMjWieBZ
 DXK0yMgvYik8/u9yDfXiMnGa1YXrWmfEykrWxTQF5OjqxaAo/5bIpjulXjtol8eH1UKv
 f0BB/Emu6P7lNdW5OgK4AErMoaREVRaoh96Z0/YtFcS3vWkK5Hm+st2SHLjtEtGIUJ6l
 mLSEQRak97mjNVYcdGE/91Qqc36zZNdnTKGDN3e7PIsAfeHw/X+n7oF9OmCcwfvo4ZZU
 KisE55yXTSy5fV9NQx3EBEcwMW/aWstB4ugxsEPd3XYx1dYf7GypF27/u4tEArvdm0EL
 qkCg==
X-Gm-Message-State: AOJu0YyjUMz/qg1w4OCHHL0LVdGGcv2Z3n1DHa2b7JcELmC+cY0VDpkY
 dzZgb+qPxA6cZ6qivwZgylGCigAQwGXwigXkdgKaMYRq5wWcGL0tqd3M4+lmgW4=
X-Google-Smtp-Source: AGHT+IFdxvBJBDv5Iy1yKStNja2/IauUDhjoNoDHWam+eTf6h+30turKsizXR/k77COlb2QhdbMlzA==
X-Received: by 2002:adf:e4c8:0:b0:33e:72be:43ab with SMTP id
 v8-20020adfe4c8000000b0033e72be43abmr3047080wrm.24.1712249210005; 
 Thu, 04 Apr 2024 09:46:50 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
 by smtp.gmail.com with ESMTPSA id
 a1-20020a5d4561000000b00343c0c24a65sm2152930wrc.89.2024.04.04.09.46.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Apr 2024 09:46:49 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: [PATCH 0/3] qcom: add clock driver support for SM8550 and SM8650 SoCc
Date: Thu, 04 Apr 2024 18:46:37 +0200
Message-Id: <20240404-topic-sm8x50-clock-v1-0-0c8ea7fad003@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAG3ZDmYC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDINQtyS/ITNYtzrWoMDXQTc7JT87WTTQ3S7MwNrVMMk1LUgJqLChKTcu
 sABsaHVtbCwAPB+uQZAAAAA==
To: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>
Cc: u-boot@lists.denx.de, Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=1277;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=mPcma/bZJ/vYCf444XQz32p8st1k2jhUNOlFe4EcSlk=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBmDtl39jI5qiOn2jLanTVJ3B8uootexoGOhSJmgfW2
 wM0HKYKJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZg7ZdwAKCRB33NvayMhJ0e29D/
 4pWFHmi2baxDFf/1Nh5moKevFaL0MKTYi/SaEFkZYamtLMXrayMFLfO+qvAcdiOocwyMJFRsv2Tog1
 8p5udKtDP3P/eQ5dj5s+2fW9bBZrLRtvOQ3e+Ciq4rOwudty/XBBR3er3DDhVzVttU4z9dJk7dvUb0
 n8mqGxkhTjyqCVHt2Medy7DwEseSrksBcytsPVlQNgUkuZDY0ysNeyTcSy0ygv5W7pkoMuA7BXNqn/
 8YKxJZyqE32062biw94gE/fkKCsvMbJ/lw0zM2wiH6i9f34EB+bGPf0vqX3his4zBO54dbw6RUzRWX
 Mbw1ehJWf3QfIO+g/P/P4+mSY8rEK9BkWHHiwI0VZyV70l5KK/0nrXWlciEDMm0B3B8xarvh0wBLRB
 uAb2LNoZ6efzt1fRbuIE7VThY3djHSgd69tTcX4DoY+RHBgbjosmFtmIKQsQyL1/kA0a4Ls/6gHp6h
 aV8Y3m1hu80X1AAMnK07mBtwo/MfkLNjNtzGtoWp+0kCEHf0OEaHVK2PMKWki8j3I0TuBmdwww4mIA
 p5qRJX4DUG79QkZIZrsBa7Jy2MWz0ERIuhNSAfDEa/k9Nkg2VFtKKwOEp6j1Ue70KIydDel/bZc46i
 rKF2GN/IyryxT4EspDKjw2QWDeOsI74gxQtoIi6kJ0UxBbpnMbo/PvQyDJsg==
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

Add the GCC and TCSRCC clock driver for the SM8550 & SM8650 SoCs.

The GCC driver uses the clk-qcom infrastructure to support GDSCs,
Resets and gates. While the TCSRCC is a simpler clock driver which
only supports gates.

The GCC enable and set_rate callbacks contains some tweaks to
setup clocks for Debug UART, SDCard controller and USB.

The TCSRCC gates returns the XO frequency, which is used by the
Synopsys eUSB2 driver to determine the PHY configuration.

In addition, the drivers are enabled in the Qualcomm defconfig.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
Neil Armstrong (3):
      clk: qcom: Add SM8550 clock driver
      clk: qcom: Add SM8650 clock driver
      qcom_defconfig: enable SM8550 & SM8650 clock driver

 configs/qcom_defconfig          |   2 +
 drivers/clk/qcom/Kconfig        |  16 ++
 drivers/clk/qcom/Makefile       |   2 +
 drivers/clk/qcom/clock-sm8550.c | 335 ++++++++++++++++++++++++++++++++++++++++
 drivers/clk/qcom/clock-sm8650.c | 332 +++++++++++++++++++++++++++++++++++++++
 5 files changed, 687 insertions(+)
---
base-commit: f0e6aba1218bca578605697eed8aa94582bf57bb
change-id: 20240404-topic-sm8x50-clock-a76f8359b5fb

Best regards,
-- 
Neil Armstrong <neil.armstrong@linaro.org>

