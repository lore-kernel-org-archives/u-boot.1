Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E595CD11C2
	for <u-boot@archiver.kernel.org>; Fri,  5 Apr 2024 09:08:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E5CD888466;
	Fri,  5 Apr 2024 11:07:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Q+U0pUNE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BA0AD882B4; Fri,  5 Apr 2024 11:07:57 +0200 (CEST)
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com
 [IPv6:2607:f8b0:4864:20::52d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5240E88466
 for <u-boot@lists.denx.de>; Fri,  5 Apr 2024 11:07:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-pg1-x52d.google.com with SMTP id
 41be03b00d2f7-5d3907ff128so1592024a12.3
 for <u-boot@lists.denx.de>; Fri, 05 Apr 2024 02:07:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712308073; x=1712912873; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=A25UYW8teuZITUrJaL+w3wnWdJGuA82A1WKnWynzOY8=;
 b=Q+U0pUNEOxxz0EKrFbte1Y2AyyS83qiSi2PgbkbzghbEOA5wH9UdlaDc7oQprRZZa9
 OSPxQL95lyuC9X98Gp+f8Kj0Xj1wPYYuhfG5OAxD7BVJMs6WxOF4WMhDUhOtQiF5aEi7
 U2GnYEHdjGVE1pT87XawfF2MP2TdWf5UejarVD+Vzb+rILS3fd8kPaq6/NxFXuO7tBId
 V7xo2eicrrZZarCdZr5s5fAGaNKWHg0G/XnAXS7bql553o+6dwICZ+swqcwA42YG1hUo
 dJoBfYFUa+ILnUsm1qI7HgHeCCubex4t2cFfFc9U22QMaQEdqBh7CL95L5ffg5f2fG8v
 BXnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712308073; x=1712912873;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=A25UYW8teuZITUrJaL+w3wnWdJGuA82A1WKnWynzOY8=;
 b=Grdn8mowUbn2GBvm2LRV0ty9qcMQTAIgoaT3mPf2iXPB/R56vuK97a2vtDK4mt6OWn
 SIH8yT/HzBZix/gQBz5Bl1ZJaiO1r7Zu4+nDsbYjUlHX7T0WcGjuNAaDBK0t+Td8dO8D
 bzQybyasZyVoVIHbDf6dssneyZ+rczsT8qnJST0R6CoWbKDkHbFqd2Zz8NCdGcNNIS4D
 Mwj6bU6s593g85XixtSgGxFDn6kXa8ARBdUFIdJYrh5DQQWcwio4+OXAfGvDf00GZRMa
 4O3PUcYqFDBPfFEr167sEjLAhpAYuPKlSXx411ZMCRB1PPOWAazZRS+42y95478f+RfI
 2w5g==
X-Gm-Message-State: AOJu0YxE6Gex/klr+9/S2lHQX+26zHEkJNRBuCJi6HjIs/b+kzGim+OJ
 cpBZq4G2epa4Kzl7yR+7aFi6LICuVt5iPpouf4vmARsyzEV8l1i+MWzz/quL5DVBgfpRkjaB0Ct
 6
X-Google-Smtp-Source: AGHT+IFAzVaXzQCq6zE/dD8JmVFp2nGV4NNfi6AG6ZZvspJdiku9H2YsCOEWHPDYKmMMY39huU1BIw==
X-Received: by 2002:a17:903:487:b0:1e3:1542:91e2 with SMTP id
 jj7-20020a170903048700b001e3154291e2mr754584plb.46.1712308073471; 
 Fri, 05 Apr 2024 02:07:53 -0700 (PDT)
Received: from sumit-X1.. ([223.178.208.62]) by smtp.gmail.com with ESMTPSA id
 k9-20020a170902c40900b001e2c0b77b53sm1055959plk.255.2024.04.05.02.07.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Apr 2024 02:07:53 -0700 (PDT)
From: Sumit Garg <sumit.garg@linaro.org>
To: u-boot@lists.denx.de
Cc: caleb.connolly@linaro.org, neil.armstrong@linaro.org, trini@konsulko.com,
 lukma@denx.de, seanga2@gmail.com, sjg@chromium.org,
 laetitia.mariottini@se.com, pascal.eberhard@se.com, abdou.saker@se.com,
 jimmy.lalande@se.com, benjamin.missey@non.se.com,
 daniel.thompson@linaro.org, stephan@gerhold.net,
 Sumit Garg <sumit.garg@linaro.org>
Subject: [PATCH v3 0/6] Add SE HMBSC board support
Date: Fri,  5 Apr 2024 14:37:36 +0530
Message-Id: <20240405090742.4148304-1-sumit.garg@linaro.org>
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
the debug console with an RS232 port, patch #2 - #5 adds corresponding
driver support.

Patch #6 adds main HMIBSC board specific bits, features:
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

Changes in v3:
- Rebased on top of qcom-next [1].
- Collected some review tags.
- Incorporated misc. comments from Caleb and Stephen.
- Split patch#4 as requested.
- Linux HMIBSC board DTS has already been reviewed here [3], I have
  incorporated that for U-Boot too.

Changes in v2:
- Rebased on top on qcom-next [1].
- Added patch#1 as a fix for generic qcom board support.
- Added patch#4 to enable driving GPIO pins based on pinctrl
  configuration. This replaces the custom GPIO configuration.
- Added proper DTS file for HMIBSC board based on Linux DT pattern.
- Merged board support patches into a single patch#5.

[1] https://source.denx.de/u-boot/custodians/u-boot-snapdragon/-/commits/qcom-next?ref_type=heads
[2] https://rauc.readthedocs.io/en/latest/
[3] https://lore.kernel.org/linux-kernel/20240403043416.3800259-4-sumit.garg@linaro.org/

Sumit Garg (6):
  qcom: Don't enable LINUX_KERNEL_IMAGE_HEADER by default
  apq8016: Add support for UART1 clocks and pinmux
  serial_msm: Enable RS232 flow control
  pinctrl: qcom: Add support for driving GPIO pins output
  pinctrl: qcom: apq8016: Add GPIO pinctrl function
  board: add support for Schneider HMIBSC board

 arch/arm/Kconfig                          |   2 +-
 arch/arm/dts/apq8016-schneider-hmibsc.dts | 491 ++++++++++++++++++++++
 board/schneider/hmibsc/MAINTAINERS        |   6 +
 configs/hmibsc_defconfig                  |  86 ++++
 doc/board/index.rst                       |   1 +
 doc/board/schneider/hmibsc.rst            |  45 ++
 doc/board/schneider/index.rst             |   9 +
 drivers/clk/qcom/clock-apq8016.c          |  38 +-
 drivers/pinctrl/qcom/pinctrl-apq8016.c    |   2 +
 drivers/pinctrl/qcom/pinctrl-qcom.c       |  25 +-
 drivers/serial/serial_msm.c               |  24 +-
 include/configs/hmibsc.h                  |  57 +++
 12 files changed, 760 insertions(+), 26 deletions(-)
 create mode 100644 arch/arm/dts/apq8016-schneider-hmibsc.dts
 create mode 100644 board/schneider/hmibsc/MAINTAINERS
 create mode 100644 configs/hmibsc_defconfig
 create mode 100644 doc/board/schneider/hmibsc.rst
 create mode 100644 doc/board/schneider/index.rst
 create mode 100644 include/configs/hmibsc.h

-- 
2.34.1

