Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8264FE6780A
	for <u-boot@archiver.kernel.org>; Sun, 24 Nov 2024 20:27:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C9D588959E;
	Sun, 24 Nov 2024 21:27:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="dcjBTy9x";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C020289507; Sun, 24 Nov 2024 21:27:34 +0100 (CET)
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com
 [IPv6:2a00:1450:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A9D4F8951A
 for <u-boot@lists.denx.de>; Sun, 24 Nov 2024 21:27:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-a9a0ef5179dso568221066b.1
 for <u-boot@lists.denx.de>; Sun, 24 Nov 2024 12:27:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732480052; x=1733084852; darn=lists.denx.de;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=8DAlXh7qf1NVrcxcZA3CmY2xPBwmg8zh3/X/JroY58g=;
 b=dcjBTy9xqloNGM8s395AzlLucXUmgeo1TNkbO16N+1L4bQm8EMSwz/2lvz8k7P8rlp
 Zr/LNQ/X5N6GLiaNR/YRSQ7pjceFqqeeCGNLj1WYXlJNrlIgaG6Mc8u0MKA1i7ZBSxPn
 KUeKYyZq4EEI30tMrTZKmo5hhThZ7alycl9iFKhD9RDAhmAhRSu4C2P66KbROb5isDSj
 ISJeYhjazj2p9QUpIBr5raxlnwNE7ePjOMn3H6KmUJFhXFDpK/mpEkhCXluiZl8tpDG3
 CUc58fdvG8zP62spNSiT+slcNcjYFW7XfDxSCsLJCXax13dbT11UB1g3OqQH90sULLaw
 9Pug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732480052; x=1733084852;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8DAlXh7qf1NVrcxcZA3CmY2xPBwmg8zh3/X/JroY58g=;
 b=CxqQ2B3RJ9uCXZZsdZG0nW0sbp9KdwM925jNUzPja+PlTDGsotsCLJTmz+b8Fa1Efi
 Kpwvn1bSFK92SxV6BAQjxY02EJ1JpHRA3BZC8u8667uHvy8OyEnxwF1l+PGpLkf90IKs
 JBozZjUPFYezO8wxo5xxDNKahObAb3uZnugVV48y+7xrLACd8+Gi3lol5Hh7KfzT5jNk
 Z6Q6oyBA4Tf9jY6O0XbMC7NIsEdhDb+AN4QbLaGN4bbkn7IXMwKlO4MIgn5fDaaF7FmD
 N62vHPn9KJQcpEiUAfkk7syMXrf8daabz6T6xCFMiAjHUajEU9w4HhMU8eJ/u2t/gL3+
 dTpw==
X-Gm-Message-State: AOJu0YxgFSxwCebN5pL8IsY2o2UQcW2r3+Ibir2ScDLj6X4QIgkbH10s
 qIQP//xTLKlbV5FnqfKVNj/BcwPjrxAM9+1WMHk5lKVOs4LroANPw4vJc29ylss=
X-Gm-Gg: ASbGncs5O6wfd6DjCaC1dgJj+jbqfDF9TnZUDUTguconyOVSL2E1DyBAZmvUbdgUO/0
 oDS/7/pVRj8tWh1JrlMqDXrQpLysKvTYbbaQms9VkxKGcw9KAzysZWzuySk9ConPQWBEHxE56Di
 Nhd0ohH5K8sokUEgAYFNtLaKhjw+56YHGiLmCcp3P2dlVOyetQKhqfH0XAbuwsYiOOevlOs3IXH
 deta/tPCz4mgBF3cV1PhkYw3k7bf5Dsx66mGztmHw+/+FN8lQxMBpgGvA58oLv+mLlL
X-Google-Smtp-Source: AGHT+IG06N99hlg9Fj1ZEoZzXguRZN99s+EpjhiusJYYILL1luMNM6ch3Tv9o0L0+6rBt0Yk7vVQhg==
X-Received: by 2002:a17:906:3108:b0:aa1:e51d:cf83 with SMTP id
 a640c23a62f3a-aa50996620cmr993328166b.11.1732480052072; 
 Sun, 24 Nov 2024 12:27:32 -0800 (PST)
Received: from lion.localdomain ([2a02:8109:888d:ff00:ca7f:54ff:fe52:4519])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aa50b28cda1sm378720666b.9.2024.11.24.12.27.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 24 Nov 2024 12:27:31 -0800 (PST)
From: Caleb Connolly <caleb.connolly@linaro.org>
Subject: [PATCH RFC 00/14] efi: implement EFISTUB support for ARM64 and
 Qualcomm
Date: Sun, 24 Nov 2024 21:26:56 +0100
Message-Id: <20241124-b4-efistub-arm64-v1-0-3e33f0340071@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABCMQ2cC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxNDQyMT3SQT3dS0zOKS0iTdxKJcMxNdCwPzRCOjxFRLi2QTJaC2giKgfAX
 YyGilIDdnpViIYFFqYSnQ+BKITGxtLQDZv03lfAAAAA==
To: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Simon Glass <sjg@chromium.org>, Bin Meng <bmeng.cn@gmail.com>, 
 Anatolij Gustschin <agust@denx.de>, 
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=3940;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=hfH3PHJRTYdEsN8ae234Gp1GRHhBBqpsDsuGn4JW6S8=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhnTnHsPlRyLacn/K7yvcGF7/Z5ZOtO7qG469M/hfJZx/f
 eLh+W8pHaUsDIIcDLJiiiziJ5ZZNq29bK+xfcEFmDmsTCBDGLg4BWAi558zMizcaeRxnu/yvDU5
 P9g3u3Wnnv1Qs5npq8ATE+u/4f7JBX8Y/seHSAY6V6nY1QR6rdCaVDsvY9rDHbKzlz9z4PdxYGa
 PlgYA
X-Developer-Key: i=caleb.connolly@linaro.org; a=openpgp;
 fpr=83B24DA7FE145076BC38BB250CD904EB673A7C47
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

This series implements support for launching U-Boot as an EFI payload on
ARM64 devices that already have an EFI capable bootloader.

Patches 9 through 14 in tandem with another series [1] provide all the
pieces necessary to build and run U-Boot on Snapdragon X Elite laptops.
They're only here to demonstrate the usecase and either already have or
will be sent separately, they should not be reviewed as part of this
RFC.

Initial support is provided for:
* Building U-Boot with an EFI stub on ARM64
* Inheriting DRAM banks from the EFI memory map
* Creating a framebuffer node in the OF tree based on EFI GOP info

This allows for booting Linux on top of U-Boot's EFI implementation on
Qualcomm Snapdragon X Elite platforms.

The primary motivation for this is to provide a more standard EFI
interface on devices like Qualcomm powered Windows laptops. While these
devices ship an EFI capable bootloader, it has no understanding of
devicetree, requiring distros (or more often, users) to handle
devicetree selection and applying necessary fixups.

Additionally, the EFI implementation on these devices is often very far
from being systemready compliant, with a variety of bugs like broken
keyboards, crashes in OS loaders like systemd-boot, and other small
idiosyncrocies.

As a result, simply running U-Boot as an EFI app isn't a suitable
solution.

[1]: 20241124-b4-modernise-smem-v1-0-b7852c11b67c@linaro.org

---
Caleb Connolly (10):
      cmd: efi: avoid unitialized read
      efi: stub: support running U-Boot as an EFI payload on ARM64
      efi: move efi_info_get() to a new header file
      efi: stub: add helpers to populate memory map and framebuffer
      efi: stub: add additional types of memory
      efi: stub: log EFI memory banks
      efi: stub: add known memory to U-Boot's EFI memory map
      mach-snapdragon: support booting with EFISTUB
      common/board_f: init malloc earlier
      configs: add x1e_defconfig

Neil Armstrong (4):
      clk: qcom: Add X1E80100 clock driver
      qcom_defconfig: enable X1E80100 clock driver
      pinctrl: qcom: Add X1E80100 pinctrl driver
      qcom_defconfig: enable X1E80100 pinctrl driver

 Makefile                                |  15 +-
 arch/arm/cpu/armv8/config.mk            |  11 +
 arch/arm/include/asm/global_data.h      |   3 +
 arch/arm/lib/Makefile                   |   2 +
 arch/arm/mach-snapdragon/board.c        |  15 ++
 arch/arm/mach-snapdragon/dram.c         |  15 +-
 arch/arm/mach-snapdragon/qcom-priv.h    |   2 +
 arch/x86/cpu/efi/payload.c              |  32 +--
 board/qualcomm/efistub.env              |  11 +
 cmd/efi.c                               |   3 +-
 common/board_f.c                        |   2 +-
 configs/qcom_defconfig                  |   2 +
 configs/x1e_defconfig                   |  17 ++
 drivers/clk/qcom/Kconfig                |   8 +
 drivers/clk/qcom/Makefile               |   1 +
 drivers/clk/qcom/clock-x1e80100.c       | 348 ++++++++++++++++++++++++++++++++
 drivers/pinctrl/qcom/Kconfig            |   7 +
 drivers/pinctrl/qcom/Makefile           |   1 +
 drivers/pinctrl/qcom/pinctrl-x1e80100.c | 100 +++++++++
 drivers/video/efi.c                     |   1 +
 include/efi.h                           |  27 +--
 include/efi_stub.h                      |  67 ++++++
 lib/efi/Kconfig                         |   9 +-
 lib/efi/Makefile                        |  28 ++-
 lib/efi/efi_app.c                       |   1 +
 lib/efi/efi_info.c                      | 165 +++++++++++++++
 lib/efi/efi_stub_arm64.c                | 237 ++++++++++++++++++++++
 lib/efi/{efi_stub.c => efi_stub_x86.c}  |   1 +
 lib/efi_loader/efi_memory.c             |   5 +
 lib/of_live.c                           |   9 +
 30 files changed, 1072 insertions(+), 73 deletions(-)
---
base-commit: 1e327ec30e48902fff65fb58337b8f80cc526f08

// Caleb (they/them)

