Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48CF2C5475B
	for <u-boot@archiver.kernel.org>; Mon, 11 Mar 2024 11:10:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BAED987F04;
	Mon, 11 Mar 2024 12:10:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="iLBv3/rv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8517187DD3; Mon, 11 Mar 2024 12:10:56 +0100 (CET)
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com
 [IPv6:2607:f8b0:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 354A487EFF
 for <u-boot@lists.denx.de>; Mon, 11 Mar 2024 12:10:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-1dc75972f25so29055265ad.1
 for <u-boot@lists.denx.de>; Mon, 11 Mar 2024 04:10:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710155450; x=1710760250; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=TCuCHA6BEvcYBPSIcG8GNQw5aP1zpEnkwDcVvUJNh+s=;
 b=iLBv3/rvzuzR2ozwin0HF/+4bPIGZTf6sR3nFtP3vAvRyS/2tba45QNGX3pfxHNvm5
 Wxho7RT3fXWa9qKsYANGigwG1dIebUQzaylzeSnC0JgF5Y7ZGTIhErCJ5hnGYduYWvic
 JCwQ/Lvyww9cVOBg+Y6vzhp1g1nI+CBuh4616eBZuncJcM6ke6iYXRYcF5hjNlRcQt59
 m7/YeHXwRN/mraafH5KQnY+v7cjZgrKVLV9n0jBBkFPkJ/VoKapifdoSN6sTmAAl0p0G
 QVXyBfCTvwGtssCEYFpjg0VhF8zQ7+tlVmx87I4IXlUhi+D5dMBdQPcBP3OX8ZeRM7Co
 NJjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710155450; x=1710760250;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=TCuCHA6BEvcYBPSIcG8GNQw5aP1zpEnkwDcVvUJNh+s=;
 b=ROLe6D3XCtK6pjZuV994arPz7WVOSTTCFHWCsZiXEVkKnp60Myavcd4SLnKPtBCQvQ
 qUQi7mFU+fey4nQ0GPuzsfPGPg4r8KsxSwBpATx67Uh+wnmlFyBQhgugLDCwdzys5mNy
 CBtG0PwPrn5mmRzq3YLG5p9G9CGfwGR4xMbqC1Scvdf/6ydALpaczLjMTwGAIn84fGi+
 Vjierkl7V+VrEUhPXANGebwlg1I8O85at2xoE9S5IbLwXRNFQQYEno6D2+dqVSxoECN8
 EDNEjgEqIpXOGG5gz195ZxWMClBcrn4yvn0cZm4poQyp5H+qZ9jQawxL4AOP/9bzF5eL
 XxRw==
X-Gm-Message-State: AOJu0Yy/gSZbW2KPVd/IxwThszn9696F1qIP1+839QJceRlZagsdtJwh
 mg3tIA6Byr0Mze3v5BS7i+K3v9BFsyouehb18WR+lG/8g20Wl0wuIWctiH6hpw4qB1M1b3DNwz2
 4
X-Google-Smtp-Source: AGHT+IEsM/qJift0IpmRnBkMMjSlSpYeEuk/iF0jLe7dTf7VyqvkU+TqebulD45PWXhFJ6UqzjdbMQ==
X-Received: by 2002:a17:902:eb8c:b0:1db:4746:5fdd with SMTP id
 q12-20020a170902eb8c00b001db47465fddmr96742plg.43.1710155450231; 
 Mon, 11 Mar 2024 04:10:50 -0700 (PDT)
Received: from sumit-X1.. ([223.178.211.249]) by smtp.gmail.com with ESMTPSA id
 o13-20020a170902d4cd00b001dd8ce888aasm2877895plg.74.2024.03.11.04.10.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Mar 2024 04:10:49 -0700 (PDT)
From: Sumit Garg <sumit.garg@linaro.org>
To: u-boot@lists.denx.de
Cc: caleb.connolly@linaro.org, neil.armstrong@linaro.org, trini@konsulko.com,
 lukma@denx.de, seanga2@gmail.com, sjg@chromium.org,
 laetitia.mariottini@se.com, pascal.eberhard@se.com, abdou.saker@se.com,
 jimmy.lalande@se.com, benjamin.missey@non.se.com,
 daniel.thompson@linaro.org, stephan@gerhold.net,
 Sumit Garg <sumit.garg@linaro.org>
Subject: [PATCH v2 0/5] Add SE HMBSC board support
Date: Mon, 11 Mar 2024 16:40:21 +0530
Message-Id: <20240311111027.44577-1-sumit.garg@linaro.org>
X-Mailer: git-send-email 2.34.1
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

SE HMIBSC board is based on Qcom APQ8016 SoC. One of the major
difference from db410c is serial port where HMIBSC board uses UART1 as
the debug console with an RS232 port, patch #2 - #4 adds corresponding
driver support.

Patch #5 adds main HMIBSC board specific bits, features:
- Qualcomm Snapdragon 410C SoC - APQ8016 (4xCortex A53, Adreno 306)
- 2GiB RAM
- 64GiB eMMC, SD slot
- WiFi and Bluetooth
- 2x Host, 1x Device USB port
- HDMI
- Discrete TPM2 chip over SPI

Features enabled in U-Boot:
- RAUC updates (refer [2] for more details)
- Environment protection
- USB based ethernet adaptors

Feedback is very much welcome.

Changes in v2:
- Rebased on top on qcom-next [1]
- Added patch#1 as a fix for generic qcom board support.
- Added patch#4 to enable driving GPIO pins based on pinctrl
  configuration. This replaces the custom GPIO configuration.
- Added proper DTS file for HMIBSC board based on Linux DT pattern.
- Merged board support patches into a single patch#5.

[1] https://source.denx.de/u-boot/custodians/u-boot-snapdragon/-/commits/qcom-next?ref_type=heads
[2] https://rauc.readthedocs.io/en/latest/

Sumit Garg (5):
  qcom: Don't enable LINUX_KERNEL_IMAGE_HEADER by default
  apq8016: Add support for UART1 clocks and pinmux
  serial_msm: Enable RS232 flow control
  pinctrl: qcom: Add support for driving GPIO pins output
  board: add support for Schneider HMIBSC board

 arch/arm/Kconfig                       |   2 +-
 arch/arm/dts/apq8016-hmibsc.dts        | 496 +++++++++++++++++++++++++
 board/schneider/hmibsc/MAINTAINERS     |   6 +
 configs/hmibsc_defconfig               |  87 +++++
 doc/board/index.rst                    |   1 +
 doc/board/schneider/hmibsc.rst         |  45 +++
 doc/board/schneider/index.rst          |   9 +
 drivers/clk/qcom/clock-apq8016.c       |  50 ++-
 drivers/pinctrl/qcom/pinctrl-apq8016.c |   2 +
 drivers/pinctrl/qcom/pinctrl-qcom.c    |  26 +-
 drivers/serial/serial_msm.c            |  19 +-
 include/configs/hmibsc.h               |  57 +++
 12 files changed, 779 insertions(+), 21 deletions(-)
 create mode 100644 arch/arm/dts/apq8016-hmibsc.dts
 create mode 100644 board/schneider/hmibsc/MAINTAINERS
 create mode 100644 configs/hmibsc_defconfig
 create mode 100644 doc/board/schneider/hmibsc.rst
 create mode 100644 doc/board/schneider/index.rst
 create mode 100644 include/configs/hmibsc.h

-- 
2.34.1

