Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB1BFC4332F
	for <u-boot@archiver.kernel.org>; Tue,  7 Nov 2023 12:41:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3EB9B8720A;
	Tue,  7 Nov 2023 13:41:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="HLrQ3BQ7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 60D3E871E7; Tue,  7 Nov 2023 13:41:15 +0100 (CET)
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com
 [IPv6:2a00:1450:4864:20::433])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EB84E80844
 for <u-boot@lists.denx.de>; Tue,  7 Nov 2023 13:41:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-32fa7d15f4eso3795099f8f.3
 for <u-boot@lists.denx.de>; Tue, 07 Nov 2023 04:41:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699360872; x=1699965672; darn=lists.denx.de;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=VX32gmvZaCsCG1pV+BhUv0nUrQ2zZ+/hc+u1j1PoWvM=;
 b=HLrQ3BQ7lLusmMm/4dKJu4GCctFmWv2UxLrQR+Trxk12VKJyjsQ6oNOXZpLgTSuKHT
 POcwp9CE1W2Ckq7SHVzVY5f7J67Wx3R43/AbMv9KLsXCVjziH+kvCokUDkNkCGg+A0Vx
 YSGCTcB2isxpqg1RAkHweqXWxosTiqkI8WRy4J1yq9jCnbIQ5+b7FAOWj2ze3hbyA4ML
 jdSNV/qLZy07V0GZEC0FhULeNbMW/I38ZU4NO/TykKzVe5oldhJh/UpOMDfERSkbA0Qw
 DHBdtwcROVDgsf4zr16JXs0DFPkccC2t3OCULu6uSH5xQih/ZyeqdU6D/K+7dgN2hkKH
 zo5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699360872; x=1699965672;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=VX32gmvZaCsCG1pV+BhUv0nUrQ2zZ+/hc+u1j1PoWvM=;
 b=lSZzt66q21wKPQQXz7dJxgoWK3jqw2ybKmrIiYTIw8WBU0mwPWGWFs/RVdqHM2y+V1
 cNPciaS0WAWfFCkzE47goX8/BCkbvpUXV7Q38d3Y/SWehX6fayksUXYdQR5TuIiQ6/wr
 eRrtWTZTV9YcxYO//S6I251/46mqSnqMWSGBWpNJOxVuhj7OFyoZXwbb6SZqXF8BDYMg
 BDFUTSb0Eqtuof+aoq1i8yxEiWkhq5zV6tbFU8xk9PExHo2Qo2AORqn6P8e8W6k98i2I
 R0mr1gGsCCMDyBiTf88UOaWeGP7KtvynVlYdTWIiJL6b0mx5QTc0RWm4++FFZNLKtJhT
 DtTg==
X-Gm-Message-State: AOJu0YwX891CSWcWBtDfiWqnZqWJI0SAbTYAgHSHyjq6u25ffG+Bhlox
 htan0wdOJY3QSiLTCZNudnFiVw==
X-Google-Smtp-Source: AGHT+IG6UvqNkiG+nTCKla0abu/nywhQZ55lz2CT43JxH5E0rgV8Vhs+gGMFlvGthvM91+c3NFgS9A==
X-Received: by 2002:a5d:59af:0:b0:32f:7bb6:9695 with SMTP id
 p15-20020a5d59af000000b0032f7bb69695mr29389449wrr.44.1699360872297; 
 Tue, 07 Nov 2023 04:41:12 -0800 (PST)
Received: from lion.localdomain (host-92-25-138-185.as13285.net.
 [92.25.138.185]) by smtp.gmail.com with ESMTPSA id
 v11-20020a5d610b000000b0032d09f7a713sm2285333wrt.18.2023.11.07.04.41.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Nov 2023 04:41:11 -0800 (PST)
From: Caleb Connolly <caleb.connolly@linaro.org>
Subject: [PATCH v4 0/7] arm: mach-snapdragon: Qualcomm clock driver cleanup
Date: Tue, 07 Nov 2023 12:40:58 +0000
Message-Id: <20231107-b4-qcom-clk-v4-0-82bbaf1a796d@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFowSmUC/33NwU4DIRAG4FdpOIvCQCl48j2MB2Bndye2UIdmo
 2n23WV7MY3G4z+T7/+voiETNvG8uwrGhRrV0oN92Ik8xzKhpKFnAQqMVmBlsvIj15PMx3c56sP
 orQMflBNdpNhQJo4lz5upTBOVp1NsF+Ttf2Yc6fO29vrW80ztUvnrNr7o7fr3zqKlkmEIzuxDC
 tHDy5FK5PpYeRJb0QL/YOjY7Q+QMiR0Qf3C5gdrZe6x6dgPMFinMKO3d3hd128Gj2VPQQEAAA=
 =
To: Ramon Fried <rfried.dev@gmail.com>, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>, 
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>, 
 Robert Marko <robert.marko@sartura.hr>, 
 Bhupesh Sharma <bhupesh.linux@gmail.com>, 
 Luka Perkov <luka.perkov@sartura.hr>, 
 Dzmitry Sankouski <dsankouski@gmail.com>, 
 Jorge Ramirez-Ortiz <jorge.ramirez.ortiz@gmail.com>
Cc: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>, 
 u-boot@lists.denx.de, Sumit Garg <sumit.garg@linaro.org>, 
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.13-dev-4bd13
X-Developer-Signature: v=1; a=openpgp-sha256; l=5207;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=d0lR1Py6VfQgLunP79yIasDMEwvr4A7Hpo0q3m5Ol+8=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhlQvg7TCpUf77/cWT+KTmlfH43piTpfHI/uPrFv33jb1T
 rt+Nlm8o5SFQZCDQVZMkUX8xDLLprWX7TW2L7gAM4eVCWQIAxenAExEcAUjww6uEBXDs+vdDRZz
 ndsQefThk7PyPVYCqsaP1bkYj/wq+AtU0b6U+8qDx+zvw3rv/Xx5vr+gb5XkzdQXpuXyfYw71hq
 /BgA=
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
Changes in v4:
* Fixed mnd_width for UART clock on apq8016, apq8096, and qcs404
* Link to v3: https://lore.kernel.org/r/20231103-b4-qcom-clk-v3-0-8d2d460ece84@linaro.org

Changes in v3:
* Rebased on qcom-next [1]
* Dropped erroneous LOG_DEBUG define
* Add drivers/clk/qcom to MAINTAINERS
* Link to v2: https://lore.kernel.org/r/20231024-b4-qcom-clk-v2-0-6572bc2be690@linaro.org

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

[1]: https://source.denx.de/u-boot/custodians/u-boot-snapdragon

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

 MAINTAINERS                                        |   1 +
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
 drivers/clk/qcom/clock-qcom.c                      | 307 +++++++++++++++++++++
 drivers/clk/qcom/clock-qcom.h                      | 100 +++++++
 .../clk/qcom}/clock-qcs404.c                       | 167 +++++++++--
 drivers/clk/qcom/clock-sdm845.c                    | 187 +++++++++++++
 drivers/reset/Kconfig                              |   7 -
 drivers/reset/Makefile                             |   1 -
 include/configs/dragonboard410c.h                  |   1 -
 include/configs/dragonboard820c.h                  |   1 -
 include/configs/dragonboard845c.h                  |   1 -
 include/configs/qcs404-evb.h                       |   1 -
 .../{qcom,ipq4019-gcc.h => qcom,gcc-ipq4019.h}     |  73 +++++
 include/dt-bindings/reset/qcom,ipq4019-reset.h     |  92 ------
 35 files changed, 1053 insertions(+), 898 deletions(-)
---
base-commit: b9221f7d86f9511ad2a816f589d41bc02dbcd6f8

// Caleb (they/them)

