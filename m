Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49A18C4345F
	for <u-boot@archiver.kernel.org>; Fri, 12 Apr 2024 09:54:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B425A88011;
	Fri, 12 Apr 2024 11:54:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="LCc1GNzr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2C27287E01; Fri, 12 Apr 2024 11:54:54 +0200 (CEST)
Received: from mail-oo1-xc30.google.com (mail-oo1-xc30.google.com
 [IPv6:2607:f8b0:4864:20::c30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F0CFA87ED9
 for <u-boot@lists.denx.de>; Fri, 12 Apr 2024 11:54:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-oo1-xc30.google.com with SMTP id
 006d021491bc7-5aa20adda1dso474925eaf.1
 for <u-boot@lists.denx.de>; Fri, 12 Apr 2024 02:54:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712915688; x=1713520488; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=1b6Tc7p5N0Ulc6rqStNQCpxLVVvtqZM4ItbCMDsu1MI=;
 b=LCc1GNzrkBX0yBXsgcXDH0f2+Lk/X9INFqZMWgn1VbBY4dEhwdvuz81lBK+ZqFYgCD
 VerwUmh8d5As5y50QuIhjiBqPbtDF0pm1EKeEugXizah1/QqZ9Q8cXa0gEqdQevJhdN7
 hD1bWpM/zWMeipbVuGmF5uy/yvP6XuxmyQzUAoUIv5s//6jxOPzWnqR8EmA5z1k05aIt
 d7v6bBfc/rKBmR1zglTtdoyr2/RVNFpQR0YXZGN3ZGVSHeaeDt4F2djeEHU1SSkeDm8e
 e0VtpGUJkiyd5R+GtOh2hxMFWpoD35ddLPZ0/PJD5OECE8UZ8S6vzNNdBQcYSIxwc4wL
 qxkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712915688; x=1713520488;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=1b6Tc7p5N0Ulc6rqStNQCpxLVVvtqZM4ItbCMDsu1MI=;
 b=AHRS1mSit86J5rVyapbrKQGmMokD/tLuPbWiSBDPvGfUW17yLYsZIyjKkNgU5xJqWw
 TIfKGTWM4tUlgGtRHjINZMslorhrxX3QOEj6cAAQb+pVgh68YPkaYhy3U3u5BLyr6/RJ
 4Zbfqm9vOVfdMU4gRARjCewtpqesTKWQWTLQ9SOt8V0l7OOZqueMJaQJUbrJJXw6obuN
 UlTZzG4Fe7D1NZ1TjkIoKI+BThXuEWpMVDTwhZ9ULK5bMSCIPdkfMu1a/mbFGc8a8odr
 YVW+UBtnsaIF+0U52Vd6s0N8lb81A/8gi0tZfFgj+qf+il5AR6Q4DQ3lb7mmV6TURCJS
 6NbA==
X-Gm-Message-State: AOJu0YxfquAmjdbjHo8K7UaM81fntlZ8vdPRKZnDd34dy0sbzlBcLX+k
 tQJ035HD8LoSY1li0QPe65U3NBWSGg7qlAgAHu3bfDg6qd+LG/dNSb8nphps9SwCpGYbKZiiPx4
 F
X-Google-Smtp-Source: AGHT+IH5vJurbJHLczOGnZXcF46lH3LIh0DdmT2YGV1c916/T2AgyqLyDZetymj8G36yvLmudislkQ==
X-Received: by 2002:a05:6870:8326:b0:221:bcde:29cc with SMTP id
 p38-20020a056870832600b00221bcde29ccmr1971966oae.21.1712915688389; 
 Fri, 12 Apr 2024 02:54:48 -0700 (PDT)
Received: from sumit-X1.. ([223.178.210.92]) by smtp.gmail.com with ESMTPSA id
 bn19-20020a056a00325300b006ed0b798f1fsm2534839pfb.119.2024.04.12.02.54.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Apr 2024 02:54:48 -0700 (PDT)
From: Sumit Garg <sumit.garg@linaro.org>
To: u-boot@lists.denx.de
Cc: caleb.connolly@linaro.org, neil.armstrong@linaro.org, trini@konsulko.com,
 lukma@denx.de, seanga2@gmail.com, sjg@chromium.org,
 laetitia.mariottini@se.com, pascal.eberhard@se.com, abdou.saker@se.com,
 jimmy.lalande@se.com, benjamin.missey@non.se.com,
 daniel.thompson@linaro.org, stephan@gerhold.net,
 Sumit Garg <sumit.garg@linaro.org>
Subject: [PATCH v4 0/7] Add SE HMBSC board support
Date: Fri, 12 Apr 2024 15:24:31 +0530
Message-Id: <20240412095438.410570-1-sumit.garg@linaro.org>
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

Changes in v4:
- Rebased on top of qcom-main [4].
- Split out board DTS patch as #6.
- Convert to text based environment as hmibsc.env.
- MMC regression has been reported for qcom-main branch here [5].
- Collected further review tag.

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
[4] https://source.denx.de/u-boot/custodians/u-boot-snapdragon/-/commits/qcom-main/?ref_type=heads
[5] https://lore.kernel.org/all/CAFA6WYO+3VroUdFUVH390taViQX8pMQrOQDTSn0yU6BD5YY53A@mail.gmail.com/

Sumit Garg (7):
  qcom: Don't enable LINUX_KERNEL_IMAGE_HEADER by default
  apq8016: Add support for UART1 clocks and pinmux
  serial_msm: Enable RS232 flow control
  pinctrl: qcom: Add support for driving GPIO pins output
  pinctrl: qcom: apq8016: Add GPIO pinctrl function
  arm: dts: qcom: Add Schneider HMIBSC board dts
  board: add support for Schneider HMIBSC board

 arch/arm/Kconfig                          |   2 +-
 arch/arm/dts/apq8016-schneider-hmibsc.dts | 491 ++++++++++++++++++++++
 board/schneider/hmibsc/MAINTAINERS        |   6 +
 board/schneider/hmibsc/hmibsc.env         |  40 ++
 configs/hmibsc_defconfig                  |  87 ++++
 doc/board/index.rst                       |   1 +
 doc/board/schneider/hmibsc.rst            |  45 ++
 doc/board/schneider/index.rst             |   9 +
 drivers/clk/qcom/clock-apq8016.c          |  38 +-
 drivers/pinctrl/qcom/pinctrl-apq8016.c    |   2 +
 drivers/pinctrl/qcom/pinctrl-qcom.c       |  25 +-
 drivers/serial/serial_msm.c               |  24 +-
 include/configs/hmibsc.h                  |  16 +
 13 files changed, 760 insertions(+), 26 deletions(-)
 create mode 100644 arch/arm/dts/apq8016-schneider-hmibsc.dts
 create mode 100644 board/schneider/hmibsc/MAINTAINERS
 create mode 100644 board/schneider/hmibsc/hmibsc.env
 create mode 100644 configs/hmibsc_defconfig
 create mode 100644 doc/board/schneider/hmibsc.rst
 create mode 100644 doc/board/schneider/index.rst
 create mode 100644 include/configs/hmibsc.h

-- 
2.34.1

