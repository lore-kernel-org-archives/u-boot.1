Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62E4EC4345F
	for <u-boot@archiver.kernel.org>; Mon, 22 Apr 2024 09:34:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DC71788359;
	Mon, 22 Apr 2024 11:34:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="O8UVEUeK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 852A988349; Mon, 22 Apr 2024 11:34:00 +0200 (CEST)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 633EB883A5
 for <u-boot@lists.denx.de>; Mon, 22 Apr 2024 11:33:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-41a7ae25d53so2549355e9.1
 for <u-boot@lists.denx.de>; Mon, 22 Apr 2024 02:33:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713778436; x=1714383236; darn=lists.denx.de;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=/RIv16n8XfyNbNmjQaRndPKdMOoD4BNUgCQBpXTPCCg=;
 b=O8UVEUeKElozwDFbqJ0pRsxvxJXNNpccMywRGwYesiVQO/kok7dE6FC1JMum5ENWDd
 1OU/erl8acZP184nTrW4YhwXbzDUEgcAUysqlZe3dbV3Ej+Fesvzmneg8w+fqeyTMsMi
 b4WFhINuKmm/mbGCHpo4p3/r/Rb19hzGG5oqigIHCnZCnk47CJKqA2WJrDbUQjabjFvv
 W2oXKALZG3XexQbEYCIamYMIR2qLfYSIoROfFcWPYo1Mk/f1R8MaYNxkdJ/x98/Q8pSo
 grTV89/sV0QJDcpv96XOZIEMWDq8YD5eucXzuSb5FhFkGkuhtYl5QW12APJhtMZNq53p
 pegg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713778436; x=1714383236;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/RIv16n8XfyNbNmjQaRndPKdMOoD4BNUgCQBpXTPCCg=;
 b=OZsExR3B1pIKqXQzHyLFelZDAzc25KGMF2jqs9b9JeSZLHyJ7LkwSEgat230jjbvRQ
 ZRgjpGdugeewm/YRE0c+jPTwOCexv8YkvpH52gxSlqzgLNK3mGA+ERzRmD0mCGVsaQ+h
 +5SV35cwPgVZK3lJ9UUt2K04w5FzwPL39d9xNWiqYNxG7usN9Q6zFnE7svhzVW7N0hwQ
 50qVtN3rr8zriEvO+p3IvM+hQQRT0OUce9+XYtUtakYk1e+A1ccyK9E1mBh7fnQg/eyQ
 Uakl4Lh6R3I8IsHfyEMTaq2I6U3YuXI1KscY71qL6/IKRpQZGIkU5bsnRqoJr+mGNHJZ
 PGTA==
X-Gm-Message-State: AOJu0YxWjN/y8co+IhWIzSd1TpkgB9vdUGRPhA0ja8fwCD5h04HSVj+u
 S/eWEpDia6xXXPbsvHKFUknUPPKWhOmG05u5LexfjUwx2hBgEDGLpR0NgSf6gY8=
X-Google-Smtp-Source: AGHT+IGr8PXXmHWMhbnNuHksvkgyBi4KzXU5WrmC70LjXB/OOyKnJrngcETG69F4WWx2bA+2TlqLOw==
X-Received: by 2002:a05:600c:1c27:b0:419:f9ae:e50 with SMTP id
 j39-20020a05600c1c2700b00419f9ae0e50mr3746960wms.37.1713778435386; 
 Mon, 22 Apr 2024 02:33:55 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
 by smtp.gmail.com with ESMTPSA id
 o12-20020a05600c4fcc00b00418a6d62ad0sm19755138wmq.34.2024.04.22.02.33.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Apr 2024 02:33:55 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: [PATCH v2 0/2] i2c: Add support for Qualcomm Generic Interface
 (GENI) I2C controller
Date: Mon, 22 Apr 2024 11:33:51 +0200
Message-Id: <20240422-topic-sm8x50-i2c-v2-0-f9ad61c33b07@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAP8uJmYC/32NQQ7CIBBFr9LM2jGABbQr72G6QArtJFoaaEhNw
 93FHsDle8l/f4fkIrkEXbNDdJkShbmCODVgJzOPDmmoDIKJlrX8hmtYyGJ6XzfJkITFp+ROajV
 ILzXU2RKdp+1IPvrKE6U1xM/xkPnP/olljgyVVrUptBcXc3/RbGI4hzhCX0r5Ard4pBaxAAAA
To: Tom Rini <trini@konsulko.com>, Heiko Schocher <hs@denx.de>, 
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>
Cc: u-boot@lists.denx.de, Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=1699;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=Tp8EcxkIciy0JJBvekvw8T2WDSkAoHVyQPqDGu0GkRI=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBmJi8Bidx09NpGo2PT3PFAFMc8ILiV65Ltgh+1Y1rN
 kCF+osiJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZiYvAQAKCRB33NvayMhJ0Vc+D/
 97wJRvRRZcRuMgdoGEPtW5UM047L8U7dAfWIca5j1sK4Xq5/ghOYDVfloC60YhWChq0UgUxLO+XZwa
 s0hlMmvX068zxTRPnnsIGUmLbMY8lcuXUry3ImHv6HgE1bndxnVZ4kvPsYqkwEqB/Oc7M+20QrnUdA
 lSLZrZjUJS3HBYp0lZKbztiVyY9XlfFKHqppaGie18In/ehALLJtx0I1x0Tbx3fhi9gfIQ60hTpcn9
 FI2ddspdHRiliqfnvTsTXF9fqRI869IYgPNsprZEyDpSGOT2IK7uCLWWwUb/ZvjQ79FIVM26N4s7/O
 vXBC0voYD1q+Tn2hSDKw8cllJ4nxY33XJ+cLrkcF41/bZC0MIzrUMBNWU05t6vhbM4eUMoFmEDNGIu
 /l7zqO9lUsuM4NYOanL5vUE2+JidJYUs3mO/F5BSWI8z5n45XLpewqZH4hFoeE8k9/cuwPTZCCNqbB
 AF5ir+xptcK1P1ywuRN5zyfkskftZwPtoabELI0Uir3M+KwjwFnZrKW7l1eJxysB8fLcVElXHQBTKJ
 XtwIE2A8bS1CxANg6Bpepo9cBtRzujGGc6FmLvrgTH0a0LAt9UoPrMr2RV2zZjgUSYWFcUGRoOQNfb
 ulow0fsenJFdwRU7mTFUlt+LQG6rlGDP8GOrq0Y4rShSbM+sNlRA1Eo/3kEQ==
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

Only FIFO mode is implemented, neither SE DMA nor GPI DMA are implemented.

Finally enable the driver in the default Qualcomm defconfig.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
Changes in v2:
- Fixed commit msg, removed useless debug, switched to dev_err() in probe
- Fixed some possible issues & typos and W=1 build warning
- Link to v1: https://lore.kernel.org/r/20240419-topic-sm8x50-i2c-v1-0-67651e27f23a@linaro.org

---
Neil Armstrong (2):
      i2c: Add support for Qualcomm Generic Interface (GENI) I2C controller
      configs: qcom_defconfig: enable GENI I2C Driver

 configs/qcom_defconfig     |   1 +
 drivers/i2c/Kconfig        |  10 +
 drivers/i2c/Makefile       |   1 +
 drivers/i2c/geni_i2c.c     | 575 +++++++++++++++++++++++++++++++++++++++++++++
 include/soc/qcom/geni-se.h | 265 +++++++++++++++++++++
 5 files changed, 852 insertions(+)
---
base-commit: b2511143fba4c0631446c968fb4c0d962b01d850
change-id: 20240419-topic-sm8x50-i2c-b51e576d5f57

Best regards,
-- 
Neil Armstrong <neil.armstrong@linaro.org>

