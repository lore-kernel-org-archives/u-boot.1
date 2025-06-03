Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B22D4C5AD49
	for <u-boot@archiver.kernel.org>; Tue,  3 Jun 2025 14:59:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2F8CA80F9C;
	Tue,  3 Jun 2025 16:59:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Xg7WNyMf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 23D1182145; Tue,  3 Jun 2025 16:59:42 +0200 (CEST)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 49C118091A
 for <u-boot@lists.denx.de>; Tue,  3 Jun 2025 16:59:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-451d6ade159so23837035e9.1
 for <u-boot@lists.denx.de>; Tue, 03 Jun 2025 07:59:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1748962779; x=1749567579; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ghbq20KWg/2fiOO7u2YgPXi2yIDX9kvPYsxOddFF9Gg=;
 b=Xg7WNyMfPj3dn3FyTjzcrs9SHb351/w45ocucXAEjhlsy/4oc4NeQ7ll+ubwdXr33i
 9xorNLbw0SmnYEZeqlIQxVGlIZ4drIzk4OA01CQ9vsBFOQMaH/idDfTWZJLHpLQvJoLj
 pySgiAx2/yLn+thVmcEHoMV1w/VwNTTMDoCJxwg9mzMBgM5KWq66P7tmjEMvIZbiNiOO
 y43DUoa/vTmIRg3Q86Bu9e/etBnvHH3C1ZgyYzSJuZvUdwC6eg9dhDSCqVIQEDCT4Xxd
 JI5D3Ek161ItLZE2KQEFCG75WDez4P1b+ojwAL3jKqJ2B8+3IGInsG/fQp2pZxMINbh/
 H7GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748962779; x=1749567579;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ghbq20KWg/2fiOO7u2YgPXi2yIDX9kvPYsxOddFF9Gg=;
 b=JJjxyj+BXR2G7HA4XadR0Ro36nhuhZG7bUh+FxfmnNDzYsqRmfKdwmPg1wTll88jX4
 Rn0sDEPk2KaviKsLJa55lEnfN/ZtSicDLAUw734LdkShGcw7LoT5kYcD3Hg1BANVaVag
 gUuwMqgXZlQe461Wb9SNc/QNB8XeSgCwl2lNcNNmw3xfDC4zaJSfp1L2IxEhleJzno83
 i3FlhPOTj0yMRJ4DXwxOvKBTGaI35CDKN38kfEkiOY6gacBhrHIL5im9ga8UaYH8PtVU
 U7gI5tJ4UQpaPcRBZl2YgkfHI6YvudRz/k9yH865WQQ6p/oJKeFK6s+ywsZOh4v2bBPb
 xrEg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVY0ETWRX7NJLsYHofvDw52qFRtblhoJnX/kSJ/hC1qbshj1KyfxaKkmbc5LDl8+tZwdRpWuoA=@lists.denx.de
X-Gm-Message-State: AOJu0Yyr09iUORwhhogK767L3pddxxxMnh6a0OPMYLA2S1mhPicsS76r
 ioj3g+65mvTCxsTi7+c2AK196Aw93kuHOP4OQbDZNDTLDYmMWQ/bQLtoaW0W09ZHtj0=
X-Gm-Gg: ASbGnctzH2GsWw/UA1g1Nq88pgVVVZm0Jx2adQdA5ybHaFKg3QI8JCgIATaK1I4YZxt
 l0pgJL4QqG0NaQX+RRUQ3WfjttENLB/zTJK65mZuGHm+YnEhSH9FvoNV5tQXnxT/bMNdPjTfDlv
 3qSmTTff5ongQF5xjrfOD5W+g77ZFYtMTEs1eqRh8Dp7Pg35ic0i5F+PlBvHr1GEc3H4duM4IUv
 x6WFnwCRYAa2ccpsO0StDRjSXHFTYn8DgkUTaIaPgdZVNlID2XpwAiNfy8aYPUhgiWQEQR9MSsC
 sMIrEPx+ai2Sirv4dXMAdCI2z08UYqB5CNF/LTnZ/lszOey2+0TnRfNykAGHVfyt+RYRKD8+DWr
 b
X-Google-Smtp-Source: AGHT+IE8NF36+ggdk8Efpg5QEJEujVgjyV0rf5f0zgU4mTOs15Nk+hXkFOJXG290VUsAW5FL4ts11g==
X-Received: by 2002:a05:6000:4012:b0:3a4:f435:5801 with SMTP id
 ffacd0b85a97d-3a4fe17b831mr10110860f8f.17.1748962778536; 
 Tue, 03 Jun 2025 07:59:38 -0700 (PDT)
Received: from toyger.tail248178.ts.net
 ([2a01:170:117e:fc:e089:f4a9:4c4d:e359])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a4f009f865sm18489369f8f.81.2025.06.03.07.59.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Jun 2025 07:59:37 -0700 (PDT)
From: Casey Connolly <casey.connolly@linaro.org>
To: Tom Rini <trini@konsulko.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, u-boot-qcom@groups.io,
 u-boot@lists.denx.de, Alexey Minnekhanov <alexeymin@postmarketos.org>,
 Rui Miguel Silva <rui.silva@linaro.org>,
 Stephan Gerhold <stephan.gerhold@linaro.org>,
 Sumit Garg <sumit.garg@oss.qualcomm.com>,
 Casey Connolly <casey.connolly@linaro.org>
Subject: [PULL] Please pull qcom-more-for-2025.07
Date: Tue,  3 Jun 2025 16:58:11 +0200
Message-ID: <20250603145933.1019742-1-casey.connolly@linaro.org>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Hi Tom,

Some late fixes for 2025.07.

CI run is here (just has vexpress_fvp disabled)

https://source.denx.de/u-boot/custodians/u-boot-snapdragon/-/pipelines/26489

The following changes since commit b22a276f039f818d5564bec6637071cfc8a7e432:

  image: android: fix ramdisk default address (2025-05-30 13:44:05 -0600)

are available in the Git repository at:

  https://source.denx.de/u-boot/custodians/u-boot-snapdragon.git tags/qcom-more-for-2025.07

for you to fetch changes up to 14315b73a8e7aef9125c7c1aa28ebe3f0725a202:

  mach-snapdragon: Update fdtfile logic to work for RB1 and RB2 (2025-06-02 18:20:40 +0200)

----------------------------------------------------------------
More Qualcomm fixes for 2025.07

* Adjust fdtfile logic to support more boards
* Support linux,code variable in qcom-pmic button driver
* Minor CLK API adjustments and apq8096/msm8916 fixes
* vbus regulator register fixes
* dragonboard410c KASLR support and other fixes

----------------------------------------------------------------
Alexey Minnekhanov (1):
      button: qcom-pmic: allow to specify code in devicetree

Rui Miguel Silva (1):
      power: qcom_vbus_regulator: add and fix support for pmic variants

Stephan Gerhold (9):
      board: dragonboard410c: Fix button cmd name
      board: dragonboard410c: Drop custom reduced malloc size
      board: dragonboard410c: Enable support for KASLR in Linux
      clk: qcom: apq8016: Fix SDCC clock addresses
      clk: qcom: Move qcom_gate_clk_en() to C file
      clk: qcom: Use setbits_le32() for qcom_gate_clk_en()
      clk: qcom: Allow polling for clock status in qcom_gate_clk_en()
      clk: qcom: apq8016: Convert GATE_CLK() to GATE_CLK_POLLED()
      clk: qcom: apq8016: Fix SDCC clock warnings

Sumit Garg (1):
      mach-snapdragon: Update fdtfile logic to work for RB1 and RB2

 arch/arm/mach-snapdragon/board.c                   | 63 ++++++++++++----------
 board/qualcomm/dragonboard410c/dragonboard410c.env |  2 +-
 configs/dragonboard410c_defconfig                  |  3 +-
 drivers/button/button-qcom-pmic.c                  | 15 ++++++
 drivers/clk/qcom/clock-apq8016.c                   | 17 +++---
 drivers/clk/qcom/clock-qcom.c                      | 27 ++++++++++
 drivers/clk/qcom/clock-qcom.h                      | 26 ++++-----
 drivers/power/regulator/qcom_usb_vbus_regulator.c  | 37 ++++++++++---
 8 files changed, 129 insertions(+), 61 deletions(-)
