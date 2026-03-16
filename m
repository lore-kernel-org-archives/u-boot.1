Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8AB3F53D85
	for <u-boot@archiver.kernel.org>; Mon, 16 Mar 2026 18:24:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7F00284179;
	Mon, 16 Mar 2026 19:24:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=wolfssl.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=wolfssl-com.20230601.gappssmtp.com header.i=@wolfssl-com.20230601.gappssmtp.com header.b="CT7Tkhos";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8011E84181; Mon, 16 Mar 2026 19:15:00 +0100 (CET)
Received: from mail-oo1-xc33.google.com (mail-oo1-xc33.google.com
 [IPv6:2607:f8b0:4864:20::c33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4070884179
 for <u-boot@lists.denx.de>; Mon, 16 Mar 2026 19:14:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=wolfssl.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=david@wolfssl.com
Received: by mail-oo1-xc33.google.com with SMTP id
 006d021491bc7-66f3e7d9eccso3010821eaf.1
 for <u-boot@lists.denx.de>; Mon, 16 Mar 2026 11:14:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wolfssl-com.20230601.gappssmtp.com; s=20230601; t=1773684896; x=1774289696;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=/vkSHVWMpveeeOwrsevuWvacDCT7BzvGZ7WExT+VRMo=;
 b=CT7TkhosnIfyK4nSX+u53l966SmfxkRh6LhsZGbvHgbvAVrCEg6UeRmdLApmyPqru8
 ScZ6/bXSC7qIk0zJ86wG8iAMcrdwq/dRV8Yi0XtReNz5xpxiXqvnquv+ob//rLmTaPq+
 X6BIjD50EI97EJWOG+ME24jJUkw3alr/6yd3hz+fhePizPX00L8R6O4uwTKHkWln0zoc
 CewJNRp2f18NqXLvOFM4eyxjnpcYP1nPCQ0BiVZSnlSUrYjjYBSChFXGjftstPuJg9Mp
 lons2CdhKMTKhpUUCsti4NNKb5TBCIPus6/ZpyDsjqdPZJfl59Ih/d73mCSCVsDDAaBM
 ntaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773684896; x=1774289696;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/vkSHVWMpveeeOwrsevuWvacDCT7BzvGZ7WExT+VRMo=;
 b=GbquN0PwGBFwxiIBCnwBADYUldmLBlwudKOD/GF1qzxu3Eo4CKuy5/0P0bCWES9BIl
 vsDanYL9RE0lyzeKni6oyL3OeKKXVu6/LRuyHuwWyL7Vn9LcPTLUz4T9cHG5pFzLDqna
 bQkZiM1x4cGLnWVjFUGk3uEpc6rGrDvhFovFj2BOuAYPi5BcDCg9f5RhayplqauLraqI
 9J08HHFJyap3XyOZCd3QiSUdHB9i7KzLCbGsdEZyARynkOeqHWNQ6TzXEsmXNwGkHT8Z
 nnmOZjjZLEjuR9S7LstdBW6FP1fCdn4lAtRv7Zr01j2MffB4q3rbF0GU9gKQZ/VW7U+s
 DHsw==
X-Gm-Message-State: AOJu0YyAigHBdd+ljX2TgvrE8mdkWlq85c3HhasuvRGJb78PPDFh+73d
 3Ekc2hk/W50jK+C3+sNaEBk1j9gwJb0bzSarWD0O0qdQBNgK/4uZ24irJaJ2FV3blgnx3KH+Rte
 RcR47unI=
X-Gm-Gg: ATEYQzxd08uMrO16jfE6zkCRrWMjbS30CxNYjQUYZ/gn0rjMjQVaUW9R+y4GIYnmUXU
 GKAdg/pq/Z0garnAl58Rzup9zgkV0mrsO0FLqt3smS+YWIb9lu50qwFPDmTXt4yTqAzpO2+XO+B
 wvr2OKyM/zUQ7UrLamoFmZNf/8Mjv7ucRKhCttTfEj0r24eUtUZ2N+N7RYExDowWWDmtJztUL+f
 D13eOHmY21yAdCcLhmCEz7F6Lp+xX2vWlXIm1PwiazH1OXl16Fix5f2Eqzz2wEgiU8P+hcnjI/g
 ThbdNugmGDPBZlugi55Yf+GgJCPPivsijNIqS1kNQc4zYxmPPFSNwFfzIVuCWW5hJDFvIS7AoeS
 ulFoajL/ZPUWXb/aw5OX/KciIk85bELHvjvKnB7ap58LzbuIa9BUkIIZYodaM+Yu7kyGtNLAu8Y
 tqMUIr+5YFbP1yjY1tSA/hjhjkfjSK554h
X-Received: by 2002:a05:6820:4df3:b0:67b:caff:b7f0 with SMTP id
 006d021491bc7-67bda9d8688mr8921267eaf.30.1773684896114; 
 Mon, 16 Mar 2026 11:14:56 -0700 (PDT)
Received: from localhost ([2605:59c0:2082:bc08:ab40:208e:38fb:2546])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-67bc9332686sm10403374eaf.13.2026.03.16.11.14.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Mar 2026 11:14:55 -0700 (PDT)
From: David Garske <david@wolfssl.com>
To: u-boot@lists.denx.de
Cc: David Garske <david@wolfssl.com>
Subject: [[PATCH v2] tpm: Add wolfTPM library support for TPM 2.0 00/12] ***
 SUBJECT HERE ***
Date: Mon, 16 Mar 2026 11:14:29 -0700
Message-ID: <20260316181447.2986278-1-david@wolfssl.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 16 Mar 2026 19:24:09 +0100
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

*** BLURB HERE ***

Aidan (12):
  tpm: export tpm_show_device, tpm_set_device, and get_tpm
  include: add byteorder macro guards and SHA384 hash wrapper
  spi: add BCM2835/BCM2711 hardware SPI controller driver
  dts: add TPM device tree nodes for RPi4, QEMU, and sandbox
  tpm: add wolfTPM library as git submodule
  tpm: add wolfTPM headers and SHA384 glue code
  tpm: add wolfTPM driver helpers and Kconfig options
  cmd: refactor tpm2 command into frontend/backend architecture
  tpm: add sandbox TPM SPI emulator
  test: add wolfTPM C unit tests and Python integration tests
  doc: add wolfTPM documentation
  configs: enable wolfTPM in rpi_4_defconfig

 .gitmodules                              |    3 +
 README                                   |    3 +
 README.wolftpm.md                        |  154 +++
 arch/arm/dts/bcm2711-rpi-4-b-u-boot.dtsi |   54 +
 arch/arm/dts/bcm2711-rpi-4-b.dts         |   20 +
 arch/arm/dts/qemu-arm64.dts              |    4 +
 arch/sandbox/dts/sandbox.dtsi            |   11 +
 cmd/Kconfig                              |   11 +
 cmd/Makefile                             |   10 +-
 cmd/native_tpm2.c                        |  516 ++++++++++
 cmd/tpm-common.c                         |    4 +-
 cmd/tpm-v2.c                             |  559 ++---------
 cmd/tpm2-backend.h                       |   66 ++
 cmd/wolftpm.c                            | 1170 ++++++++++++++++++++++
 configs/rpi_4_defconfig                  |   29 +-
 doc/usage/cmd/wolftpm.rst                |  635 ++++++++++++
 drivers/mtd/spi/sandbox.c                |   30 +-
 drivers/spi/Kconfig                      |    9 +
 drivers/spi/Makefile                     |    1 +
 drivers/spi/bcm2835_spi.c                |  431 ++++++++
 drivers/tpm/Kconfig                      |   44 +
 drivers/tpm/Makefile                     |    9 +
 drivers/tpm/tpm_spi_sandbox.c            |  410 ++++++++
 drivers/tpm/wolftpm_common.c             |  137 +++
 include/configs/user_settings.h          |  118 +++
 include/hash.h                           |   18 +
 include/linux/byteorder/generic.h        |   31 +-
 include/tpm-common.h                     |   22 +
 include/wolftpm.h                        |   34 +
 lib/Kconfig                              |   13 +
 lib/Makefile                             |   18 +
 lib/wolftpm                              |    1 +
 lib/wolftpm.c                            |   56 ++
 test/cmd/Makefile                        |    1 +
 test/cmd/wolftpm.c                       |  364 +++++++
 test/py/tests/test_wolftpm.py            |  375 +++++++
 36 files changed, 4861 insertions(+), 510 deletions(-)
 create mode 100644 .gitmodules
 create mode 100644 README.wolftpm.md
 create mode 100644 arch/arm/dts/bcm2711-rpi-4-b-u-boot.dtsi
 create mode 100644 cmd/native_tpm2.c
 create mode 100644 cmd/tpm2-backend.h
 create mode 100644 cmd/wolftpm.c
 create mode 100644 doc/usage/cmd/wolftpm.rst
 create mode 100644 drivers/spi/bcm2835_spi.c
 create mode 100644 drivers/tpm/tpm_spi_sandbox.c
 create mode 100644 drivers/tpm/wolftpm_common.c
 create mode 100644 include/configs/user_settings.h
 create mode 100644 include/wolftpm.h
 create mode 160000 lib/wolftpm
 create mode 100644 lib/wolftpm.c
 create mode 100644 test/cmd/wolftpm.c
 create mode 100644 test/py/tests/test_wolftpm.py

-- 
2.43.0

