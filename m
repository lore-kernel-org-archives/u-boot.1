Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41AB9D3B7F2
	for <u-boot@archiver.kernel.org>; Mon, 25 Nov 2024 08:29:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A2DE588F48;
	Mon, 25 Nov 2024 09:29:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="bnaiZ0RL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6BA9A899DF; Mon, 25 Nov 2024 09:29:19 +0100 (CET)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1D71888901
 for <u-boot@lists.denx.de>; Mon, 25 Nov 2024 09:29:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4316f3d3c21so36351465e9.3
 for <u-boot@lists.denx.de>; Mon, 25 Nov 2024 00:29:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732523356; x=1733128156; darn=lists.denx.de;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=/sqF38zlGC8+sRMP7paaXBJ7NCEQAX5IN9qThkiBqsA=;
 b=bnaiZ0RLmxD92UpEYNL3cwgBS7RRrYJIOc5O/7g0REUReQ+4g2G0coOjrkWsl6gjRt
 MKYHKYeWkJP3/61CYKW5JWgZ2WDnlvXRZdCJgMUk5Ix1LiiUTpZ2SWKa3o1udY97Tmth
 GKDyTfT0A65rAmz58KjUuT0aa7AUBCsS4cluMMJlH1hKve/sJIVdxoZb+4lKHPcLyVk7
 JiNU2OoiRhCfmHGBTMnc58JG5el3Yu+tLjsBxMj9wq9yZ2ZseYwio/IKqriwLZ4f4H8L
 UnerTyxIcek/SZ7vWsccGfZyhUCx54sIEP3NwyXPDSBSOis8jL4OlMK8YJaiNDQ/kht8
 +NdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732523356; x=1733128156;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/sqF38zlGC8+sRMP7paaXBJ7NCEQAX5IN9qThkiBqsA=;
 b=p4SKpqCYJ0JSdCfqwmfoaN/xZWhGNsvp1L9ebN1L1n31LL7RXPW3+hMsxcyF6RXfOn
 lnV8Wffn7ISf/P7qd6qzPO0qjO+fFomN5DdychDT+h4HJV8aAwXY8GVmaamZ7ygoCn7u
 yMByBGAMB1fpvrKV/WAmSXnHUXAkrmISYb3ngC6qaf8twkv970j4hzQOzRB6lCVtDUG0
 2ibDU8AnCXzsaFcv1JBjF/7qxJkGP+pdldrmqqljNXqQEreTWXs6z1XP5VKxaYnq0ahR
 6gFe3RL7/7Hp39hhOHxaHDYd8u/wbfe1f7yde/he/aNBioGtTlSGdvxWryceOA+yvXcG
 LGow==
X-Forwarded-Encrypted: i=1;
 AJvYcCUzlKSxuR7nO2u7LSTKNjnO46Qzu/gU2saDU90r65rI69T90jDngc/a48+Z2SIa+7P8mNYdO3g=@lists.denx.de
X-Gm-Message-State: AOJu0YzZmO40lmNAdMNrdkvcF0EaW1jGPOfvya1mcBRfFrJcOT+DYn2i
 SCQlfpKMVrQC3/Abi56f0dph1EHyWR1SxP4Ic2AkU+F2seelCPNPgTvOS+VVcEY=
X-Gm-Gg: ASbGncuwQFxjf8Heq+QV+F4kedq7VkNvRjhKSG9B+IeP/R2Tg3Wq3elY3miFDRmCNDL
 ZjyCDR3qAaQkpAy/3WDe0PeS5QgatR3VIu1fguoot535ouuj8wATBePqPOp0h1Od7WVuPO/+Hfb
 7TfZ+bGi6S1QjKhIqS7fdUSkfqPMjhdvn86ITIB0tzkp8LYtsqZjpwl0qWe8MVxs4u4xi6/GhWc
 nbwgK8nHKuBK2Tb4BpMuhNX8ViLKR2WXhcycUBcalxCaqHcAiP/htzYHchSKbavckqx5y0=
X-Google-Smtp-Source: AGHT+IEhRtx5Jg2u3KYxbJt2qHHLQO/aQ8N88diZvvFTKfdy22Jomy9dAsRQlpo07ZbvpkIV7ekosQ==
X-Received: by 2002:a05:600c:1da6:b0:434:9e17:18e5 with SMTP id
 5b1f17b1804b1-4349e171d04mr30805145e9.0.1732523356545; 
 Mon, 25 Nov 2024 00:29:16 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-433cde1107csm121423545e9.15.2024.11.25.00.29.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Nov 2024 00:29:15 -0800 (PST)
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: [PATCH 0/3] pinctrl: qcom: add clk_req functions
Date: Mon, 25 Nov 2024 09:29:09 +0100
Message-Id: <20241125-topic-pcie-pinctrl-v1-0-4df323d90397@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFU1RGcC/x3MMQqAMAxA0atIZgOmVipeRRwkphqQWloRQby7x
 fEN/z+QJalkGKoHklya9QgFVFfA2xxWQV2KwTTGEpkOzyMqY2QVjBr4TDs654mpt+JaDyWMSbz
 e/3Sc3vcD/IbVtGQAAAA=
X-Change-ID: 20241125-topic-pcie-pinctrl-77f1c184e73f
To: Caleb Connolly <caleb.connolly@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>, Tom Rini <trini@konsulko.com>
Cc: u-boot-qcom@groups.io, u-boot@lists.denx.de, 
 Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=827;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=gxOpP7nxJexIQVkxGwTECLQAoAG0u9zwKFiL3VVi6KE=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBnRDVYs5I0K/mAvp61AaNc1wfSTEzTALWYC/e6ENWe
 +rCLwBqJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZ0Q1WAAKCRB33NvayMhJ0Ui5D/
 9vqNwWnpVAqJdLAqQl+Vn0bFMw6FuxtH74lkc7N2j25zEm4Kq2acSemq3+V/E/ZFbGLmB66jMjNMeT
 CrnJzB2P8zeNbUozA9x+t6H5XAFB76HMXNJ5I2W0P88mE7QnShU9euDa9oFobeRQWR5+t42HyfIlHF
 Pb/IcExXKObB+S+h72uPQYhs6/nYTP33oNfuyFoG8fwsf3dviOY1V7lyd3VThbtwX+A+ya2x9wEJAq
 w3MJLkwnZfLtlDxkAeJ3ngQVNry3sUA/39nmlkAdxqOiKPNIVKQ+7PHNsGUicYP6K4vi1gmlVpdVn4
 AqIjPCTBJ6Ps1jlBAkoyxHyBK0mF7p2T6VmZzC9SjYdFLj1UPmrtr0/tpHCQ4N40E3KN1FXEqY124x
 GeS06Vy6U4E0YqG1FUsBhaOX11fHYZBxMrGF552s7tifqqDkFgU7Lv/AgYtOxgGv/9sSfgMg+JELNl
 tnnQ9FjQC4c8iEUq6F9mRiIRz7AwRyuC71OZ0hC1kNBxSFt6Z4nktNcCRry4ULl/lauTY6JHtp4HQs
 lvkPmNMmvlyAx41ACwKpfAGbCDHm32fjzdFgWxOFgrL5jicxoDBKh/orirnv/AfYyPIG1s/RlJZiPY
 M1wLVvyRskTeUBBVOFy0L69DPqRDe9WziEh5UXxbb6C/Bca3CL1cqqLceW7g==
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

Add the missing PCIe clk_req functions for the SM8550, SM8650
and X1E80100 TLMM.

Depends on:
- https://lore.kernel.org/all/20241115-topic-x1e80100-pinctrl-v1-0-35f984226e47@linaro.org/

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
Neil Armstrong (3):
      pinctrl: qcom: sm8550: add pcie1_clk_req_n function
      pinctrl: qcom: sm8650: add pcie[01]_clk_req_n function
      pinctrl: qcom: x1e80100: add pcie[3456ab]_clk functions

 drivers/pinctrl/qcom/pinctrl-sm8550.c   | 1 +
 drivers/pinctrl/qcom/pinctrl-sm8650.c   | 2 ++
 drivers/pinctrl/qcom/pinctrl-x1e80100.c | 5 +++++
 3 files changed, 8 insertions(+)
---
base-commit: 7a36c84ff57177ccd3107f62c8d14fa0093e0e76
change-id: 20241125-topic-pcie-pinctrl-77f1c184e73f

Best regards,
-- 
Neil Armstrong <neil.armstrong@linaro.org>

