Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D53E5EB8FAA
	for <u-boot@archiver.kernel.org>; Wed,  6 Sep 2023 02:41:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 943B386545;
	Wed,  6 Sep 2023 04:40:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ylNbtlYm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DA0B28655F; Wed,  6 Sep 2023 04:40:57 +0200 (CEST)
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com
 [IPv6:2607:f8b0:4864:20::433])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8716A833DE
 for <u-boot@lists.denx.de>; Wed,  6 Sep 2023 04:40:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=takahiro.akashi@linaro.org
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-68a32506e90so700495b3a.1
 for <u-boot@lists.denx.de>; Tue, 05 Sep 2023 19:40:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693968053; x=1694572853; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=t809fTd3EOxJoNQ8GEMXImLrJ4uzXg+LWteqfm4I3hU=;
 b=ylNbtlYmCDTjbFMZ+O1O3cPjSjX3hCAa939tT/igwcSA/SU5h2uScmbBmH6J8dU0rO
 LIN0IBxWgmQvvfWtAg2JtIacHygPEEiwyHurzY29+hOjPTKclKXVCw04ZtfjCiv0OibD
 BxYD8M84EJGPCMGuBdicoWtnxam7ntjgXmp7hSCsF/XZzWEwjxgqvTDVEKmdfYB0dO9a
 4BYBmAAnOMldaL3YasmGd/5lYUPRmfgO4jZddayLks62Dv3WJ0No1lFuTBCJc7WpJ1t3
 aDx8xvL+GZSYKmijmQBuD8lmZ3ul0xIdDiDUOZSaWMIKBDqmxf3pzwftz0qMwhvVK0Zd
 e8iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693968053; x=1694572853;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=t809fTd3EOxJoNQ8GEMXImLrJ4uzXg+LWteqfm4I3hU=;
 b=aXaWX6cYAgT3eZktib26/v6W4eLTY6uhDxd/V9RWSSNCGxv1fUL6mA3bVpZwI/PnUf
 J97qH+4TmHUO53KOIqDKssSLlemKn8c6+dufcq0/MJEySDh6X2C8kBYWuX+Qep6+j1Tr
 55vUHF2+9WdrEyxhvOfuWHT3yU4dINJE7c6LrgeBNKjPJkO1nxyZ0ABkwuN1RoO33Vjr
 9NqKmQuRJDr1sxZ/zCf52Jx+kZ7r+or3QK8/9puvEUP9meYiO7YczUwQNC6SJs+wlzD/
 0b4MwW5GvROoCq1+M2sHy7vVQAXYZvjAWRl97rJwMt2qnuE2T1qBb06C1bKrw7s9ZeUP
 Yf7w==
X-Gm-Message-State: AOJu0Yz1KxwzjlO7OdDGmhELCzI0IVnBoaXFOLCd+EQScxJe7e1VK0la
 fJAn1iW33Y8RZsdzDCZAjWbCGVr8KFAMkME10AbafQ==
X-Google-Smtp-Source: AGHT+IE8LnKDr4U9NvdKmxNs/sm13u2JduZkcq7A77mROA5FCYaMN+R6YHHvkr3ge47I9yGocWibsg==
X-Received: by 2002:a05:6a20:440b:b0:134:d4d3:f0a5 with SMTP id
 ce11-20020a056a20440b00b00134d4d3f0a5mr20840767pzb.2.1693968052751; 
 Tue, 05 Sep 2023 19:40:52 -0700 (PDT)
Received: from octopus.. ([2400:4050:c3e1:100:8294:a07d:b7e9:4033])
 by smtp.gmail.com with ESMTPSA id
 c5-20020a6566c5000000b0056428865aadsm9145378pgw.82.2023.09.05.19.40.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Sep 2023 19:40:52 -0700 (PDT)
From: AKASHI Takahiro <takahiro.akashi@linaro.org>
To: u-boot@lists.denx.de
Cc: etienne.carriere@st.com, michal.simek@amd.com, sjg@chromium.org,
 linus.walleij@linaro.org, Oleksii_Moisieiev@epam.com,
 AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: [RFC 0/6] firmware: scmi: add SCMI pinctrl protocol support
Date: Wed,  6 Sep 2023 11:40:05 +0900
Message-Id: <20230906024011.17488-1-takahiro.akashi@linaro.org>
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

This is an RFC and meant to get feedback from other developers as
- the specification (pinctrl part) is still in a draft
- the upstream patch for linux, including dt bindings, is still WIP
- I'm not confident the drivers are generic enough to cover most HWs
- The tests ("ut") doesn't cover all the features yet


This patch series allows users to access SCMI pin control protocol provided
by SCMI server (platform). See SCMI specification document v3.2 beta 2[1]
for more details about SCMI pin control protocol.

The implementation consists of two layers:
- basic helper functions for SCMI pin control protocol
  in drivers/firmware/scmi/pinctrl.c (patch#2)
- DM-compliant pinctrl/gpio drivers, which utilizes the helper functions,
  in drivers/pinctrl/pinctrl-scmi.c (patch#3,#4)

[1] https://developer.arm.com/documentation/den0056/e/?lang=en

DT bindings
===========
Upstream pinctrl patch for linux defines the bindings in [2] though
it doesn't say much.
I expect that my implementation basically complies with U-Boot's generic
bindings described in [3], but not all the features are verified.

As for gpio, unless you hard-code pin assignments directly in a device
driver, my implementation allows the following alternatives in DT.
Either way, we may need an additional binding description for gpio.

(A)
    scmi {
        ... // other protocols
        scmi_pinctrl: protocol@19 { // Pin control protocol
            ...
            {pinmux definitions}... // if any, including GPIO?
        }
    }
    scmi_gpio: scmi_gpio {
        compatible = "arm,scmi-gpio-generic";
        gpio-controller;
        #gpio-cells = <2>;
        gpio-ranges = <&scmi_pinctrl 0 5 4>,
                      <&scmi_pinctrl 4 0 0>;
        gpio-ranges-group-names = "",
                                  "ANOTHER_GPIO_GROUP";
    }
    some_device {
        ...
        reset-gpios = <&scmi_gpio 0 GPIO_ACTIVE_HIGH>;
    }
(B)
    scmi {
        ... // other protocols
        scmi_pinctrl: protocol@19 { // Pin control protocol
            ...
            {pinmux definitions}... // if any, including GPIO?

            scmi_gpio: scmi_gpio {
		// no need for "compatible"
                gpio-controller;
                #gpio-cells = <2>;
                gpio-ranges = <&scmi_pinctrl 0 5 4>,
                              <&scmi_pinctrl 4 0 0>;
                gpio-ranges-group-names = "",
                                          "ANOTHER_GPIO_GROUP";
            }
        }
    }
    some_device {
        ...
        reset-gpios = <&scmi_gpio 0 GPIO_ACTIVE_HIGH>;
    }
(C)
    if "gpio-ranges" is missing in gpio definition, assume 1:1 mapping,
    i.e. use a native pinctrl pin number (5).
    some_device {
        ...
        reset-gpios = <&scmi_gpio 5 GPIO_ACTIVE_HIGH>;
    }


[2] https://lkml.iu.edu/hypermail/linux/kernel/2308.1/01084.html
[3] <u-boot>/doc/device-tree-bindings/pinctrl/pinctrl-bindings.txt
    <u-boot>/doc/device-tree-bindings/gpio/gpio.txt

Test
====
The patch series was tested on the following platforms:
* sandbox ("ut dm pinmux" and manually using gpio command)


Prerequisite:
=============
* This patch series is based on my WIP "Base protocol support" patches
  on v2023.10-rc3. You can fetch the whole code from [4].

[4] https://git.linaro.org/people/takahiro.akashi/u-boot.git
    branch:scmi/pinctrl


Patches:
========
Patch#1: Add SCMI base protocol driver
Patch#2-#4: Add drivers
Patch#5-#6: Test related


Change history:
===============
RFC (Sep 6, 2023)
* initial release as RFC

AKASHI Takahiro (6):
  firmware: scmi: fix protocol enumeration logic
  firmware: scmi: add pinctrl protocol support
  pinctrl: add scmi driver
  gpio: add scmi driver based on pinctrl
  firmware: scmi: add pseudo pinctrl protocol support on sandbox
  test: dm: add SCMI pinctrl test

 arch/sandbox/dts/test.dts                  |  115 +++
 cmd/scmi.c                                 |    1 +
 drivers/firmware/scmi/Kconfig              |    3 +
 drivers/firmware/scmi/Makefile             |    1 +
 drivers/firmware/scmi/pinctrl.c            |  412 ++++++++
 drivers/firmware/scmi/sandbox-scmi_agent.c |  722 +++++++++++++
 drivers/firmware/scmi/scmi_agent-uclass.c  |   18 +-
 drivers/pinctrl/Kconfig                    |   11 +
 drivers/pinctrl/Makefile                   |    1 +
 drivers/pinctrl/pinctrl-scmi.c             | 1071 ++++++++++++++++++++
 include/scmi_agent-uclass.h                |    2 +
 include/scmi_protocols.h                   |  435 ++++++++
 test/dm/scmi.c                             |   62 ++
 13 files changed, 2852 insertions(+), 2 deletions(-)
 create mode 100644 drivers/firmware/scmi/pinctrl.c
 create mode 100644 drivers/pinctrl/pinctrl-scmi.c

-- 
2.34.1

