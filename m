Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8672FC36018
	for <u-boot@archiver.kernel.org>; Tue,  1 Apr 2025 09:47:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AF75281F4D;
	Tue,  1 Apr 2025 11:47:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="rc5ltKeC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BF36582033; Tue,  1 Apr 2025 11:47:52 +0200 (CEST)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1E71880584
 for <u-boot@lists.denx.de>; Tue,  1 Apr 2025 11:47:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-43cfa7e7f54so32404665e9.1
 for <u-boot@lists.denx.de>; Tue, 01 Apr 2025 02:47:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743500869; x=1744105669; darn=lists.denx.de;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=iuO1CXriIWhBx1Ox75Y6Mvg8rsGahrDjExhB/QnUUDc=;
 b=rc5ltKeCW8EH1GvHxUoHhUOr/Tk6QNABMjbZ3FPby50Xy5eNAIhO1C81js6/S+cJJ1
 nPJLPZiL5K8Be0Kkk1+BfSbLK0GGuTN89L6kCETp4FihfAFLHPkBTDY90whZPRVzeVdw
 eNSBO1vZT/kVBPpAZ3NItigIq6UvMP8IGUCjbS+A8j3Gbl0PLUs5mjpM4vZ7ATQhfqCE
 IWeMT9OF/wJjoh0jfZglFxYHVyNycLx49F55VpaxVCTy93X6IgCkyldSouGQum6va68z
 SuFRppPBKAvv1GhDmQQCNTUj6FwXt3qMd0NMp2haCGcfXs+P0LScwcaMh1ob02lYYGYb
 JXnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743500869; x=1744105669;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=iuO1CXriIWhBx1Ox75Y6Mvg8rsGahrDjExhB/QnUUDc=;
 b=oU1KUvymjuW8kBY6YyYuC8KkrPbAd9lzYy5nhnKG2s/PtU3woIXfCVthg3IAR8lMIy
 NxuigxGgb2H5N2szehH7x+dIeo3QsPktuDU99Sce4NMkVxsd+Q0O9Sy05yQNnozuWUk/
 XMCj28L0MaNpqGZ40Mqcmx5IcVrS+qWvdS/ZyFz1g987Xwkep8ru5jmjijQWGUhpoIyt
 iJRbAoAVHjEr54jtW76ue6fAzJ/D/nlOC+VUxZr+lIdD/cog+toQIKfeycJSYQF8ZF2h
 EWAb1toVM63EO+8ocHXMJOiylR7+vj7EKm/Snf1SsMnViI2GcH99D+TZ06Lx6SkUZR37
 MV9Q==
X-Gm-Message-State: AOJu0Yy2NemvFpthnTC0xbzzOztr1UG/UlndY0/GhnnHIVRzsuEyQKdt
 nCM6EdFf6l7H+AJHi/fHMcQJzMAcHfe4fsEpGiCSN6iCT9xVucBpxS4VraarhkRc+HHAy4JAnAa
 K
X-Gm-Gg: ASbGnctLBkCVjIJhH/uAOB9RTxcn7tS+OTQwQcjq9cjjf0RCuCba1YgZssby5u5IUw5
 sfTCQMn3++II+W800I/9HDU6WfIcfzuL/gNOZPBtPsBerOqwVlIX+GGAsmCiGQITinYKuO0sTdF
 mVNNVzSmAhwpz7r5y1KjYliL1WNP6xBQIOYyUVa07AswF27aFCH4X/nFae3UUeCeqyuKHC2FkSY
 Bj4LLom4GuaBwg3GF6khcWVtjIdO7Z+Pyd4SM/GCnTasThQkAcP/zyjMizuD6G9MyGphay01Dgn
 1Z0PWdfTSzmXYf0oTCFIJzA4d/ed8N83JI+LpdvCohKgu3blXn9mnYIp27m220ik7A==
X-Google-Smtp-Source: AGHT+IEVSGnf/uStKJzhvJQZDi0umHV8TKvUCv0B3UnHLAWOWJp5KfEMvK8/2zOszqH0xp9zMuPBcQ==
X-Received: by 2002:a05:600c:6dca:b0:43c:f509:2bbf with SMTP id
 5b1f17b1804b1-43d911902efmr133690805e9.15.1743500869531; 
 Tue, 01 Apr 2025 02:47:49 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:3d9:2080:52eb:f6ff:feb3:451a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39c0b6656a0sm13733581f8f.37.2025.04.01.02.47.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Apr 2025 02:47:49 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: [PATCH RFC/RFT 0/2] gpio: qcom: rewritte SPMI gpio driver from
 Linux driver
Date: Tue, 01 Apr 2025 11:47:46 +0200
Message-Id: <20250401-topic-sm8x50-pmic-gpio-pinctrl-new-v1-0-74077ef0b464@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEK262cC/x2NQQrCMBAAv1L27GISGwlehT6geBMPZV3rgk2Wp
 NRC6d8N3mYuMxsUzsIFLs0GmRcpkmIVe2iA3kMcGeVZHZxx3rTG4pxUCMsUVm9Qp8qjSkKVSHP
 +YOQvOh8CnfzQni1BDWnml6z/yR367nrsuxs89v0Hw5d9qH0AAAA=
X-Change-ID: 20250401-topic-sm8x50-pmic-gpio-pinctrl-new-2588c35a461c
To: Tom Rini <trini@konsulko.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Sumit Garg <sumit.garg@kernel.org>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io, 
 Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=990;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=6swntKQNXDe7dCp8OwWArHv4cIo6zRxkQr27IPhEm+I=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBn67ZD4v8F3WnLjtF9PMpY0fQEMjg09n1ni9rSAjT/
 Ywo+HLaJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZ+u2QwAKCRB33NvayMhJ0aGhEA
 Cdmh0Gc3JWZTn1NvowI32Xrhx0PihT6lIz8gut6zFb9tY2seJTg2QSctugTMAOC1VryuS26wqwu5gj
 tdT1K1nC2Ld7pjZm4RfBIZo32u1wypb0NbiLZRL2jqFHdYaVvPEkUMCjE/JIxQAXiVhvn5Xte31Aso
 r48v3U49VZVbIHfK5L6uWTFEm7YZLpxaU6j2dlMgo/91Nz6hufHj8HsJT99nyWWkfn63qRDMOLfhvE
 05IHGFdfHUy6Y3hXeEc4K8GH/Xe9MpMwUHN7ofXyLpMR4HRhqwAUkyBoKhMtkp4BfkkRBoth73vPPZ
 4ejBNOXCWSBO5YBW0Ws9C0P/ToqElmQbBBp/DUSRTLaFQ5LbK/TN5UxMlgjEhY0YJEZWnIOfsQndXv
 2f6v+ifSRZity1BCtRWrao6S/ZFA/xzC+XX13xYbBlHrDVu1ye6H2C9SjdVktOWc0oWWdn6PYHHnBZ
 SUlilisKF1gr1D6JIBjWaHcPErNj2L3Bs6MkMJLaA21Z43Yo58YWD3GafHyJL+bKA+/LfAK9wkrZ77
 C+s4pXc1M3pIAoiVlDhlw5/6LU6uYAweETZ80FnxffbqOUNSSfT2+IcQw1qRPDsR+ClyberjrTHJec
 XhB3fJWP1zyL9B9KFeGWcyeTdodVtWL9fv2h2MLE9+hhuTNxtUFKvm+HzLYA==
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

The current SPMI gpio driver is very old and doesn't support
pin state tracking to fully support the whole pinconf calls.

The simplest is to rewritte the driver using the v6.14 Linux
driver and fully implement pinctrl, pinmux, pinconf and gpio
support using all the newer interfaces.

The goal is to deprecate the old one it has been validated
on currently supported hardware.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
Neil Armstrong (2):
      gpio: qcom: add new driver for SPMI gpios
      gpio: qcom: move pm8550 gpio to new driver

 drivers/gpio/Makefile         |    2 +-
 drivers/gpio/qcom_pmic_gpio.c |   20 +-
 drivers/gpio/qcom_spmi_gpio.c | 1035 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 1037 insertions(+), 20 deletions(-)
---
base-commit: 5ca70325b64f760bf4190f206a0e88dda495e3d2
change-id: 20250401-topic-sm8x50-pmic-gpio-pinctrl-new-2588c35a461c

Best regards,
-- 
Neil Armstrong <neil.armstrong@linaro.org>

