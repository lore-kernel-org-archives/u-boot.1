Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0B41C4332F
	for <u-boot@archiver.kernel.org>; Mon, 30 Oct 2023 22:23:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D7CFA87A23;
	Mon, 30 Oct 2023 23:23:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="StufK5eo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BAA4487476; Mon, 30 Oct 2023 23:23:32 +0100 (CET)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6CCCF8751B
 for <u-boot@lists.denx.de>; Mon, 30 Oct 2023 23:23:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-40806e4106dso29822995e9.1
 for <u-boot@lists.denx.de>; Mon, 30 Oct 2023 15:23:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698704609; x=1699309409; darn=lists.denx.de;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=zTVwKBe5NqKL3w7V20aa7UJzJ165mzuA9MDczMW+ORw=;
 b=StufK5eoLrKcNMDUaPJ6yi7ifAHAJ87jJ5nJ0PKmLOIrTywjqwXS+WSUgROsTkCMRw
 qgYGTkSgs16GpIl2qSmHV+rTfWkBGmGZXyOtmKoZCAeGo0ELhHSfpCc5hxvfl1vpGVgC
 lu1GbEqLZphmZvJ0AW1Erbvp1nUnLZCcHBbDJ9iByJP/vxHkVvkvk4Bry5xIr3yCAyVo
 3Cz6vv6jhbN7EKdQIOO1bapbF93YYqNCMuiDD+j0dlwc37AfsjMenfm9QePe8n+xF/JT
 c7LJ+3f5wwWVOLokDp7TodgGVGFLy4ZZEpfnS1bgFpDo9MlzkMXTLrbnH/ix7zIAh0f2
 G4xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698704609; x=1699309409;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=zTVwKBe5NqKL3w7V20aa7UJzJ165mzuA9MDczMW+ORw=;
 b=uNMtgKDupTje1fmnNDsigMcaPTQhXVb35pAPP7+X6KnG/7Jef2Q9TWjXZJT0O73JPl
 iLDCvw7vLj6T5oyjIhf+pwN1LO7VO+omw6Z0/rtGddatZn7RM9MgSL0LM75c6WlmR3+9
 0722knGONPTm4jB7TFkWVN/7827UvDXz87SDCcB3ACbeORSnLZ20uOSIk04s52KtjSPD
 I5o+N65FKSnPMZJRHVX8UOxHFhDmL/3GDPQKKVZk1HVUVtOtlj/KfhvG6GV7tZLGwXQ9
 pPtpvahxV00GDrmNPSnLh7UvKUNXB7e4w+9KXm0/FGqNA/LNYKdbCdRGgsmgoqWz2ShL
 vdEw==
X-Gm-Message-State: AOJu0Yzarpyd5tphrG4zhFDDxqupsFdPKWrQuaSPrApuJpFPThrwQN/y
 +gsTyZ5JyS/J+DDoxE1/vOhRWg==
X-Google-Smtp-Source: AGHT+IEgVUHxyVrDA+B0p7mxPtCWC9PO0lYKWsWKRr5FHjeKW8+K/CH1KLHSxIj3d9+9/thDLhDoIw==
X-Received: by 2002:a1c:7405:0:b0:405:29ba:9b5c with SMTP id
 p5-20020a1c7405000000b0040529ba9b5cmr995254wmc.16.1698704608448; 
 Mon, 30 Oct 2023 15:23:28 -0700 (PDT)
Received: from lion.localdomain (host-92-25-138-185.as13285.net.
 [92.25.138.185]) by smtp.gmail.com with ESMTPSA id
 n20-20020a05600c465400b0040588d85b3asm6651wmo.15.2023.10.30.15.23.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Oct 2023 15:23:28 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Subject: [PATCH v2 0/7] arm: mach-snapdragon: Qualcomm clock driver cleanup
Date: Mon, 30 Oct 2023 22:23:22 +0000
Message-Id: <20231024-b4-qcom-clk-v2-0-6572bc2be690@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANosQGUC/22NwQ6CMBAFf4X07GpbEKkn/8NwaEuBjdDilhAN4
 d8tnD3Oe5nMyqIjdJHds5WRWzBi8AnkKWO2175zgE1iJrnMBZcFmALeNoxghxe04tZWRSkrxUu
 WDKOjA0Pa2353AmGH/jLqODva/4lci5+j9qwT9xjnQN8jvoh9/d9ZBHBQjSrzqzJKV/IxoNcUz
 oE6Vm/b9gPuQrTpxwAAAA==
To: Ramon Fried <rfried.dev@gmail.com>, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>, 
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>, 
 Robert Marko <robert.marko@sartura.hr>, 
 Bhupesh Sharma <bhupesh.linux@gmail.com>, 
 Luka Perkov <luka.perkov@sartura.hr>, 
 Dzmitry Sankouski <dsankouski@gmail.com>, 
 Jorge Ramirez-Ortiz <jorge.ramirez.ortiz@gmail.com>
Cc: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>, 
 u-boot@lists.denx.de, Caleb Connolly <caleb.connolly@linaro.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>
X-Mailer: b4 0.13-dev-46309
X-Developer-Signature: v=1; a=openpgp-sha256; l=4690;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=rPWPaTxjNG51NTTF3qiOrgbIj+3mLQ37lpe2GpwkCMs=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhlQHnXuPa09Idh+btXKHx4yTwSfMHPVWiF1aJBvBVKVVV
 JR+eDdLRykLgyAHg6yYIov4iWWWTWsv22tsX3ABZg4rE8gQBi5OAZiIYTPDXzHlB3oGktnmqiFi
 S2uTJ6QetLn9b5e0X362XlDCv4D6PEaGjefcljNer5Vt2TpD1/A4O/uywNUfhTeEHBS9IelQ+Xi
 zPwA=
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

This series begins making some headway towards cleaning up Qualcomm
platform support in u-boot. The following is a rough overview of the
changes:

* Move the Qualcomm clock drivers out of mach-snapdragon and into clk/qcom
* Introduce per-platform clock driver configs to decouple Qualcomm platform
  support from mach-snapdragon targets.
* Add the IPQ4019 clock driver, removing it from mach-ipq40xx and introducing
  the reset map.
* Merge the qcom reset driver is into clk/qcom and rework it to be
  compatible with upstream devicetrees.
* A callback model is added so that multiple clock drivers can be
  compiled in at once.
* SDM845 gains support for enabling/disabling all gate clocks (CBC's) by
  way of a new "gate_clk" abstraction.
* Preperatory cleanup work is done to simplify the bringup process for
  new platforms.

Further details are included in each commit.

The primary goal of this series is to prepare for enabling several new
Qualcomm platforms in u-boot as well as additional peripherals, while
minimising the amount of copy/pasted board-specific code.

This series conflicts with a previous series introducing support for the
Qualcomm RB2 board [1], I plan to resend this initial support pending
acceptance of this series and several other cleanups.

[1]: https://lore.kernel.org/u-boot/20230324080418.3856409-1-bhupesh.sharma@linaro.org/

---
Changes in v2:
* Added missing headers in clock-qcom.c for "fix rcg divider value"
  patch
* Use writel() instead of setbits_le32() in "fix rcg divider value"
  patch to ensure that writes are propagated to hardware.
* Adjust RCG configuration to be more similar to Linux
* Remove sysmap headers and define macros directly in platform clock
  code.
* avoid renaming msm_* to qcom_* for now
* only add relevant gate_clks for sdm845
* Link to v1: https://lore.kernel.org/r/20231024-b4-qcom-clk-v1-0-9d96359b9a82@linaro.org

---
Caleb Connolly (6):
      clk/qcom: move from mach-snapdragon
      clk/qcom: move ipq4019 driver from mach-ipq40xx
      clk/qcom: sdm845: add register map for simple gate clocks
      clk/qcom: use function pointers for enable and set_rate
      clk/qcom: add mnd_width to clk_rcg_set_rate_mnd()
      clk/qcom: fix rcg divider value

Konrad Dybcio (1):
      clk/qcom: handle resets and clocks in one device

 arch/arm/Kconfig                                   |   2 +
 arch/arm/dts/qcom-ipq4019.dtsi                     |  14 +-
 arch/arm/dts/qcs404-evb.dts                        |  19 +-
 arch/arm/mach-ipq40xx/Makefile                     |   1 -
 arch/arm/mach-ipq40xx/clock-ipq4019.c              |  88 ------
 arch/arm/mach-snapdragon/Kconfig                   |   4 +
 arch/arm/mach-snapdragon/Makefile                  |   5 -
 arch/arm/mach-snapdragon/clock-sdm845.c            |  98 -------
 arch/arm/mach-snapdragon/clock-snapdragon.c        | 181 ------------
 arch/arm/mach-snapdragon/clock-snapdragon.h        |  48 ----
 .../mach-snapdragon/include/mach/sysmap-apq8016.h  |  39 ---
 .../mach-snapdragon/include/mach/sysmap-apq8096.h  |  37 ---
 .../mach-snapdragon/include/mach/sysmap-qcs404.h   |  88 ------
 .../mach-snapdragon/include/mach/sysmap-sdm845.h   |  42 ---
 board/qualcomm/dragonboard820c/dragonboard820c.c   |   6 +-
 drivers/clk/Kconfig                                |   1 +
 drivers/clk/Makefile                               |   1 +
 drivers/clk/qcom/Kconfig                           |  52 ++++
 drivers/clk/qcom/Makefile                          |  10 +
 .../clk/qcom}/clock-apq8016.c                      |  60 +++-
 .../clk/qcom}/clock-apq8096.c                      |  56 +++-
 .../reset-qcom.c => clk/qcom/clock-ipq4019.c}      | 160 ++++-------
 drivers/clk/qcom/clock-qcom.c                      | 309 +++++++++++++++++++++
 drivers/clk/qcom/clock-qcom.h                      | 100 +++++++
 .../clk/qcom}/clock-qcs404.c                       | 167 +++++++++--
 drivers/clk/qcom/clock-sdm845.c                    | 190 +++++++++++++
 drivers/reset/Kconfig                              |   7 -
 drivers/reset/Makefile                             |   1 -
 include/configs/dragonboard410c.h                  |   1 -
 include/configs/dragonboard820c.h                  |   1 -
 include/configs/dragonboard845c.h                  |   1 -
 include/configs/qcs404-evb.h                       |   1 -
 .../{qcom,ipq4019-gcc.h => qcom,gcc-ipq4019.h}     |  73 +++++
 include/dt-bindings/reset/qcom,ipq4019-reset.h     |  92 ------
 34 files changed, 1057 insertions(+), 898 deletions(-)
---
base-commit: 30d01b582f2274eb8c808026c5fb4c33e9f2210d

// Caleb (they/them)

