Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87190CDB474
	for <u-boot@archiver.kernel.org>; Mon, 16 Oct 2023 05:40:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 516AE86BA4;
	Mon, 16 Oct 2023 07:40:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="U42qox8s";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4EA7B86B43; Mon, 16 Oct 2023 07:40:09 +0200 (CEST)
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com
 [IPv6:2607:f8b0:4864:20::102c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 588D586958
 for <u-boot@lists.denx.de>; Mon, 16 Oct 2023 07:40:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=takahiro.akashi@linaro.org
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-27d51a57062so242326a91.0
 for <u-boot@lists.denx.de>; Sun, 15 Oct 2023 22:40:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697434801; x=1698039601; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=FRQEuXX7ivKCVYN5xxBpNzRwVSKSsqbFHY8lkMn2sYY=;
 b=U42qox8sCP/FCw6yWuqG3DzfowEMAlLyQ6hlk0T7zmd3hO9/QfEzJx8InK6tA9v8uU
 k/GB3gI3N2BXArJ0kapcGggAdJntC3EyzUDll18x8U7iHf52ldx3LArSV+TCSf7StIU/
 kwmqYu5WBXUnMCulGSwAPAeB3+g7IJ6sxNgiyFhkuvBbgjtbX0NsZsVXOtrUuQTwxTHY
 7BlJmkGx1Ez2EfkkwGuoxpmYLJab0pfapejNieMwPk9qPW/EkqNxllqm+WkO5h1ZgJyw
 ZtfeC8BJnrkrzncA4YqraSQmJn0BCt6rU1yqPPU3pjx/1S13eh5qo4CZyobNgTXnGy0H
 uPRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697434801; x=1698039601;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=FRQEuXX7ivKCVYN5xxBpNzRwVSKSsqbFHY8lkMn2sYY=;
 b=qX6WwjjImP3xoVt8LsEWSbYwxmM2cA8K344mR/vA3G1JfWT4MECg/jD585wY4RQ0Vu
 DCH4XgUHCQpbV7BKEC+09CeYD5mpu75iMXTmZqZeX2Gj4BFnkRd0Vk3pdNSOTJbwam1i
 Yk79L7UVn4YUigRAsKgMU62s7w/Zn2LGYKQn5Xw8PkbI7DEf0OodJ+6ZJDV8tM+ugvvt
 G/zN0N4Fa7enm5WhS7MkyEeqPk5Wqa4GNaOu86+nwBk5rhcIQE9/IqcTHSIFNu9ZgWQB
 g94C+wRKHbwZP+Pvf/4glEYzOuR2tyR9bJkoBqgmfpI4wEws98/g2BEgRDjGHwkT51Mp
 WZIA==
X-Gm-Message-State: AOJu0YzDCzYdF32rQNhhHUDksqkytRYy4olellGBoHEL089fgQKDPkTR
 oA/MxZvEV3VBP9xQSo7HZHMtZQ==
X-Google-Smtp-Source: AGHT+IH1TlabGkkbd9tbfM/Gloqxp2UTgTl5WmXi9jKhn+zTkLxzpq3iGZ0/Oba+h/4SnBARYWNlBA==
X-Received: by 2002:a17:90b:4f4d:b0:27d:9b6:ec1b with SMTP id
 pj13-20020a17090b4f4d00b0027d09b6ec1bmr13699121pjb.4.1697434800797; 
 Sun, 15 Oct 2023 22:40:00 -0700 (PDT)
Received: from octopus.. ([2400:4050:c3e1:100:4c30:a6e6:b316:7d31])
 by smtp.gmail.com with ESMTPSA id
 lb18-20020a17090b4a5200b002636dfcc6f5sm3878134pjb.3.2023.10.15.22.39.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Oct 2023 22:40:00 -0700 (PDT)
From: AKASHI Takahiro <takahiro.akashi@linaro.org>
To: trini@konsulko.com,
	sjg@chromium.org
Cc: etienne.carriere@st.com, u-boot@lists.denx.de,
 AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: [PATCH v2 0/4] firmware: scmi: add SCMI power domain protocol support
Date: Mon, 16 Oct 2023 14:39:42 +0900
Message-Id: <20231016053946.470458-1-takahiro.akashi@linaro.org>
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

This patch series allows users to access SCMI power domain protocol
provided by SCMI server (platform). See SCMI specification document
v3.2 beta 2[1] for more details about SCMI power domain protocol.

The implementation consists of two layers:
- basic helper functions for SCMI power domain protocol
  in drivers/firmware/scmi/pwdom.c (patch#1)
- DM-compliant power domain driver, which utilizes the helper functions,
  in drivers/power/domain/scmi-power-domain.c (patch#2)

[1] https://developer.arm.com/documentation/den0056/e/?lang=en

DT bindings
===========
Standard bindings are applied, i.e.

scmi {
    ...
    pwrdom_scmi: protocol@11 {
        regs = <0x11>;
        #power-domain-cells = <1>;
    }
    ...
}

som-device {
    ...
    power-domains = <&pwrdom_scmi 2>;
}

Test
====
The patch series was tested on the following platform:
* sandbox ("ut dm scmi_power_domains")


Prerequisite:
=============
* This patch series is based on the master which now includes my "Base
  protocol support" patches v6[2]

[2] https://lists.denx.de/pipermail/u-boot/2023-September/531623.html

Patches:
========
Patch#1: Add SCMI power domain protocol helpers
Patch#2: Add power domain driver
Patch#3-#4: Test related


Change history:
===============
v2 (Oct 16, 2023)
* remove a change on "test_scmi_cmd" because "scmi" command is no longer
  provided with base protocol v6
* some cleanup
v1 (Sep 26, 2023)
* initial release

AKASHI Takahiro (4):
  firmware: scmi: add power domain protocol support
  power: domain: add SCMI driver
  sandbox: add SCMI power domain protocol support for testing
  test: dm: add SCMI power domain protocol test

 arch/sandbox/dts/test.dts                    |   6 +
 arch/sandbox/include/asm/scmi_test.h         |  21 ++
 configs/sandbox_defconfig                    |   1 +
 drivers/firmware/scmi/Makefile               |   1 +
 drivers/firmware/scmi/pwdom.c                | 189 +++++++++++++
 drivers/firmware/scmi/sandbox-scmi_agent.c   | 265 ++++++++++++++++++-
 drivers/firmware/scmi/sandbox-scmi_devices.c |  10 +
 drivers/firmware/scmi/scmi_agent-uclass.c    |  11 +
 drivers/power/domain/Kconfig                 |   7 +
 drivers/power/domain/Makefile                |   1 +
 drivers/power/domain/scmi-power-domain.c     | 193 ++++++++++++++
 include/scmi_agent-uclass.h                  |   2 +
 include/scmi_protocols.h                     | 178 +++++++++++++
 test/dm/scmi.c                               | 103 +++++++
 14 files changed, 987 insertions(+), 1 deletion(-)
 create mode 100644 drivers/firmware/scmi/pwdom.c
 create mode 100644 drivers/power/domain/scmi-power-domain.c

-- 
2.34.1

