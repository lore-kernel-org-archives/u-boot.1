Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5132C46CA2
	for <u-boot@archiver.kernel.org>; Mon, 18 Dec 2023 07:24:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F364787DCA;
	Mon, 18 Dec 2023 08:24:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="OvhLb104";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3207E87DC7; Mon, 18 Dec 2023 08:24:54 +0100 (CET)
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com
 [IPv6:2607:f8b0:4864:20::436])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A411887D6C
 for <u-boot@lists.denx.de>; Mon, 18 Dec 2023 08:24:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-6d7750e2265so162613b3a.3
 for <u-boot@lists.denx.de>; Sun, 17 Dec 2023 23:24:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1702884287; x=1703489087; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=w/HINKxIMvGWAJbWWviwZdhPBcTtd4IbKCdKur7cKck=;
 b=OvhLb104PioxDjS1PR+ufzgS0FNF4jv5luKVOtP0g4xd/d9pyjFrzL94Ox3I1xCjUc
 Wdb6Y+1mYkvMD5g69rJqkzPoqVprf9YQyhki4tSIa/obtI+XMm8VVXLWIUsVeDfoD9rr
 3+G9CkYxBluCOcwGcZft0kaiF+/FtlvKllvsv4yaTMzdIYw27lyEG0YTEzIqoXjr6sxx
 oVecwTnRYhMVnVkCMOZWwFB5EWLmiLASnHbsQA+YeA6p9kHDbjauUZyfzte622fkvJKp
 FRbRGSzRaSMCnEql8bUIROGaapZ+ojtGri4evGH/Ghx62dOxDgrcZBSxkre5GVRYlcCO
 h00w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702884287; x=1703489087;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=w/HINKxIMvGWAJbWWviwZdhPBcTtd4IbKCdKur7cKck=;
 b=tI4ilLt9qAW1uvzToNb1/GPQKCu19wLhkw4eP3zxhvI4ATgF0OUos+VAtx+kFDbPjz
 EqMi3xtVnFWW2bv296PhD7R3XVhGuXwUq6eVAkex72qTd6jHXAqzK+Vxw73kIX/z+oXM
 DzSO1MHHQt6b2iEBmXb7X4wvKCmOUvChBlL1WWih6KqUyQWy7bSb2ArmR38wmQsY3xRW
 DroEC4K0aPA7XAQGzxHWhFJtpt3Q/HWMz9dn9EwMxYyzozrPdm9GTRsHJLfHhGdLJz79
 68sG1qa1zTwHqXzqiI3igeHdoE2n6MNWrRLArX0YPugTQUeKSm1qYN2jS3Oov9YQsQnU
 em6A==
X-Gm-Message-State: AOJu0YyI/Adzq5IL2MPkthovwJl/Iy2WmmWLSX6Tayo4yQ9tJFVDeIUc
 nWSWBvAPcy+9FnhkL7dFuEmxBKD+iBBQMW9qyfBK7Q==
X-Google-Smtp-Source: AGHT+IFCxc9MpjPYRG63rYVADRRZg6rwE4JJzNhj98P0qcE/BZCDqQG1kYxXYnbkcHMV4l2UU7/95A==
X-Received: by 2002:a05:6a20:1445:b0:194:7a99:2791 with SMTP id
 a5-20020a056a20144500b001947a992791mr99759pzi.72.1702884287585; 
 Sun, 17 Dec 2023 23:24:47 -0800 (PST)
Received: from sumit-X1.. ([223.178.213.6]) by smtp.gmail.com with ESMTPSA id
 nr21-20020a17090b241500b0028b8b269aedsm1038997pjb.57.2023.12.17.23.24.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 17 Dec 2023 23:24:46 -0800 (PST)
From: Sumit Garg <sumit.garg@linaro.org>
To: u-boot@lists.denx.de
Cc: caleb.connolly@linaro.org, neil.armstrong@linaro.org, lukma@denx.de,
 seanga2@gmail.com, marex@denx.de, laetitia.mariottini@se.com,
 pascal.eberhard@se.com, abdou.saker@se.com, jimmy.lalande@se.com,
 benjamin.missey@non.se.com, daniel.thompson@linaro.org,
 Sumit Garg <sumit.garg@linaro.org>
Subject: [PATCH 0/7] Add SE HMBSC board support
Date: Mon, 18 Dec 2023 12:54:21 +0530
Message-Id: <20231218072428.1802969-1-sumit.garg@linaro.org>
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
the debug console with an RS232 port, patch #1 - #3 adds corresponding
driver support.

Patch #4 adds main HMIBSC board specific bits, features:
- Qualcomm Snapdragon 410C SoC - APQ8016 (4xCortex A53, Adreno 306)
- 2GiB RAM
- 64GiB eMMC, SD slot
- WiFi and Bluetooth
- 2x Host, 1x Device USB port
- HDMI
- Discrete TPM2 chip over SPI

Patch #5 - #7 enables specific board features like RAUC support,
environment protection and USB networking support.

This patch series is based on top of Qcom maintainer tree [1] + the latest
PMIC patch-set [2]. Feedback is very much welcome.

[1] https://source.denx.de/u-boot/custodians/u-boot-snapdragon/-/commits/u-boot-qcom-next?ref_type=heads
[2] https://patchwork.ozlabs.org/project/uboot/list/?series=385322

Sumit Garg (7):
  clk: apq8016: Add support for UART1 clocks
  serial_msm: Add support for RS232 GPIOs
  serial_msm: Enable RS232 flow control
  board: Add SE HMIBSC board support
  hmibsc: Enable RAUC support
  hmibsc: enable U-Boot Environment variables protection
  hmibsc: Enable LAN75XX USB ethernet driver

 arch/arm/dts/Makefile              |   1 +
 arch/arm/dts/hmibsc-uboot.dtsi     |  43 +++++++
 arch/arm/dts/hmibsc.dts            | 188 +++++++++++++++++++++++++++++
 arch/arm/mach-snapdragon/Kconfig   |  18 +++
 arch/arm/mach-snapdragon/Makefile  |   1 +
 board/schneider/hmibsc/Kconfig     |  15 +++
 board/schneider/hmibsc/MAINTAINERS |   6 +
 board/schneider/hmibsc/Makefile    |   5 +
 board/schneider/hmibsc/hmibsc.c    | 179 +++++++++++++++++++++++++++
 board/schneider/hmibsc/hmibsc.env  |  11 ++
 configs/hmibsc_defconfig           |  79 ++++++++++++
 drivers/clk/qcom/clock-apq8016.c   |  44 ++++++-
 drivers/serial/serial_msm.c        |  23 +++-
 drivers/usb/host/Kconfig           |   1 +
 include/configs/hmibsc.h           |  59 +++++++++
 15 files changed, 665 insertions(+), 8 deletions(-)
 create mode 100644 arch/arm/dts/hmibsc-uboot.dtsi
 create mode 100644 arch/arm/dts/hmibsc.dts
 create mode 100644 board/schneider/hmibsc/Kconfig
 create mode 100644 board/schneider/hmibsc/MAINTAINERS
 create mode 100644 board/schneider/hmibsc/Makefile
 create mode 100644 board/schneider/hmibsc/hmibsc.c
 create mode 100644 board/schneider/hmibsc/hmibsc.env
 create mode 100644 configs/hmibsc_defconfig
 create mode 100644 include/configs/hmibsc.h

-- 
2.34.1

