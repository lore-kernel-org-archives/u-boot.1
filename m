Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAC61C25B75
	for <u-boot@archiver.kernel.org>; Mon,  3 Jun 2024 16:43:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3AAC8881B8;
	Mon,  3 Jun 2024 18:43:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="jQV0Vbfr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D935F88180; Mon,  3 Jun 2024 18:43:11 +0200 (CEST)
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com
 [IPv6:2607:f8b0:4864:20::430])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 55B4B88353
 for <u-boot@lists.denx.de>; Mon,  3 Jun 2024 18:43:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-702762a76f0so23757b3a.1
 for <u-boot@lists.denx.de>; Mon, 03 Jun 2024 09:43:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1717432988; x=1718037788; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=UDRM8wC4bTU9P7M7Pw48nRy4vG96uw0kBKQ2Tdob3BE=;
 b=jQV0VbfrcRSamw1xd9nbo8Hh4PF3hw1i0W0ki4LpoLQKbReM+jHfEK3OmGcq/w3yrB
 l4dPtIApt1LsvQM0zU6RE/F/BDIM3V54yPAoP3LLgCn8OqO78HKvXll2Ha+ZVvuIt/F4
 R/Hf8DAJfbw+9hbZgdUEWzOMHS/wS/AtOQT09jsnrfEGgs1l0Uhff7P7V6QPXr6Tvu56
 YJJCGK+ZaTjjT9VTWOg+os2ACbfzzH7Acfi7hPGPuR9YxHfySfPAAh4KnCemPqzjrEDK
 zjDv1X7WIpdcA9u7qtZyGmxXDQTsreXSSSjLzyiJBbV/fxcu8Gx0fw2q2QJXGMp114jo
 6VlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717432988; x=1718037788;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=UDRM8wC4bTU9P7M7Pw48nRy4vG96uw0kBKQ2Tdob3BE=;
 b=kMxVr2mCDOdeeBRRv6v8jBMjMe9RkP0xh56v2L7E86447fgxGO0tdetxf1/evwXYVT
 A2A8A4GOlkvzln8d/Whp8+R6jTlOu9eS47S8rKlsGQC9nQXiMZyMwkaHU33Bd9JPrIVO
 mQJK505Nrn6LTswY0W3GTmquqnqv+GT06bSo9Mj5ylmTz1KZfTFMcFkfIWAprQ4E28Nq
 g897kENGwVu/NSKHvmZIQF9yZS+Peso5oiVreTDq6T5Iq5KpW7t26Kh0aV0ULgKzkCKz
 Hh8rT4AfWTjx7Zua9baDppP54tLh1QOfUwV4PPPyPEuVWW4OCl5Q6ToVgn1U6uU1MRpX
 Saqg==
X-Gm-Message-State: AOJu0Yx08SF5WEpEf95cp8nFwWg32FaAMuzPTOdGhvHGDln1SiBktO1J
 JbRefkCnKTyyndTM+dckqmFe+Q+K5EyIlAXiu9hkCkNPnKH++4oYi2urnxZ6
X-Google-Smtp-Source: AGHT+IFkFNhD/H3im8THkt28HmQaqovqhU6jJf5tUtvSJLQyBROuky8G5HHoE/TVxEr8Z2XWKa95sA==
X-Received: by 2002:a05:6a21:6d9f:b0:1af:5385:3aff with SMTP id
 adf61e73a8af0-1b26f2cc29bmr10205821637.3.1717432987538; 
 Mon, 03 Jun 2024 09:43:07 -0700 (PDT)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:592e:cdd9:67e3:7255])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-70245aa1982sm5374954b3a.163.2024.06.03.09.43.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Jun 2024 09:43:07 -0700 (PDT)
From: Fabio Estevam <festevam@gmail.com>
To: trini@konsulko.com
Cc: u-boot@lists.denx.de
Subject: [GIT PULL] Please pull u-boot-imx-next-20240603
Date: Mon,  3 Jun 2024 13:43:03 -0300
Message-Id: <20240603164303.2659176-1-festevam@gmail.com>
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

Hi Tom,

Please pull from u-boot-imx/next, thanks.

The following changes since commit 7e52d6ccfb76e2afc2d183b357abe2a2e2f948cf:

  Merge patch series "FWU: Add support for FWU metadata version 2" (2024-05-24 13:42:07 -0600)

are available in the Git repository at:

  https://gitlab.denx.de/u-boot/custodians/u-boot-imx.git tags/u-boot-imx-next-20240603

for you to fetch changes up to fb95661116fb4269883721afd80578e6d88ce043:

  imx8mm-cl-iot-gate: Add support for the Realtek RTL8211E PHY (2024-06-03 12:14:29 -0300)

u-boot-imx-next-20240603
--------------------------

CI: https://source.denx.de/u-boot/custodians/u-boot-imx/-/pipelines/20956

- Support different RAM sizes on imx8m phycoce boards.
- Support new toradex variants.
- Support Samsung 4GB DDR and Realtek RTL8211E PHY on imx8mm-cl-iot-gate.
- Convert imx8mm-phycore and imx8mp-phycore boards to use OF_UPSTREAM.

----------------------------------------------------------------
Benjamin Hahn (1):
      board: phycore_imx8mp: enable setting 2GHz timings without RAM size

Emanuele Ghidoli (5):
      board: toradex: verdin-imx8mm: add 4 GB lpddr4 memory support
      board: toradex: verdin-imx8mm: increase maximum addressable ram to 4GB
      toradex: tdx-cfg-block: add aquila am69 sku 0088 pid4
      toradex: tdx-cfg-block: add verdin imx95 sku 0089 pid4
      toradex: tdx-cfg-block: add verdin i.mx8m mini 0090 pid4

Fabio Estevam (2):
      imx8mm-cl-iot-gate: Add support for Samsung 4GB DDR
      imx8mm-cl-iot-gate: Add support for the Realtek RTL8211E PHY

Teresa Remmet (3):
      board: phytec: phycore-imx8mp: spl: Fix syle issue
      board: phytec: phycore_imx8mp: Add support for different RAM sizes
      board: phytec: phycore_imx8mp: Make RAM size configuration fix

Yannic Moog (2):
      arm: imx8mm-phycore: move to OF_UPSTREAM
      arm: imx8mp-phycore: move to OF_UPSTREAM

 arch/arm/dts/Makefile                              |   3 -
 arch/arm/dts/imx8mm-phyboard-polis-rdk.dts         | 460 -------------------
 arch/arm/dts/imx8mm-phycore-som.dtsi               | 440 ------------------
 arch/arm/dts/imx8mm-phygate-tauri-l.dts            | 489 ---------------------
 arch/arm/dts/imx8mp-phyboard-pollux-rdk.dts        | 361 ---------------
 arch/arm/dts/imx8mp-phycore-som.dtsi               | 323 --------------
 arch/arm/mach-imx/imx8m/Kconfig                    |   2 +
 board/compulab/imx8mm-cl-iot-gate/ddr/ddr.c        |   4 +-
 .../imx8mm-cl-iot-gate/imx8mm-cl-iot-gate.c        | 106 ++++-
 board/phytec/phycore_imx8mm/MAINTAINERS            |   3 -
 board/phytec/phycore_imx8mp/Kconfig                |  67 +++
 board/phytec/phycore_imx8mp/MAINTAINERS            |   1 -
 board/phytec/phycore_imx8mp/lpddr4_timing.c        | 153 +++++++
 board/phytec/phycore_imx8mp/lpddr4_timing.h        |  16 +
 board/phytec/phycore_imx8mp/phycore-imx8mp.c       |  11 +
 board/phytec/phycore_imx8mp/spl.c                  | 136 +++---
 board/toradex/common/tdx-cfg-block.c               |   3 +
 board/toradex/common/tdx-cfg-block.h               |   3 +
 board/toradex/verdin-imx8mm/lpddr4_timing.c        |  14 +-
 board/toradex/verdin-imx8mm/verdin-imx8mm.c        |   5 +-
 configs/imx8mm-phygate-tauri-l_defconfig           |   2 +-
 configs/phycore-imx8mm_defconfig                   |   2 +-
 configs/phycore-imx8mp_defconfig                   |   2 +-
 include/configs/imx8mm-cl-iot-gate.h               |   2 +-
 include/configs/phycore_imx8mp.h                   |   4 +-
 include/configs/verdin-imx8mm.h                    |   6 +-
 26 files changed, 454 insertions(+), 2164 deletions(-)
 delete mode 100644 arch/arm/dts/imx8mm-phyboard-polis-rdk.dts
 delete mode 100644 arch/arm/dts/imx8mm-phycore-som.dtsi
 delete mode 100644 arch/arm/dts/imx8mm-phygate-tauri-l.dts
 delete mode 100644 arch/arm/dts/imx8mp-phyboard-pollux-rdk.dts
 delete mode 100644 arch/arm/dts/imx8mp-phycore-som.dtsi
 create mode 100644 board/phytec/phycore_imx8mp/lpddr4_timing.h
