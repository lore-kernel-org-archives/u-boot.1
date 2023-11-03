Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88E89C4332F
	for <u-boot@archiver.kernel.org>; Fri,  3 Nov 2023 15:39:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7E8D3871F3;
	Fri,  3 Nov 2023 16:39:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="j3UOkChv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B5C7287037; Fri,  3 Nov 2023 16:39:36 +0100 (CET)
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com
 [IPv6:2a00:1450:4864:20::133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7414087037
 for <u-boot@lists.denx.de>; Fri,  3 Nov 2023 16:39:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-lf1-x133.google.com with SMTP id
 2adb3069b0e04-507c8316abcso2890182e87.1
 for <u-boot@lists.denx.de>; Fri, 03 Nov 2023 08:39:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699025971; x=1699630771; darn=lists.denx.de;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=kXf+6v1EhgsiRIP/cBxm1fQIr2rY8OIv4e/Alk3FPpo=;
 b=j3UOkChvELcu9cCAXkRwUN8dksIu/5eWKmHh8CpIJtfaVscIG5ZEWYfdJOsCx0fNpU
 LyvAKw+8H0P15RjUiX5LltO6KAmJEfCLP3gMcg9ppv9aV9D5xsohq9oI3vhUmwj9XqNL
 iUVysEMfQQAxLveIv/MXGj4AQ/Gjj6ue+ZPGwTTu0iGQWVzF9sx6LCrqpE1YI5tikud5
 ScrNxmTfegmwQa4KtX1MEGC/1OsuFiDIqmEFqs5rfUvKVEzf3qVLIwaIDBaCtP+pm0ew
 lwTBcWVMyo56DvV0Z/vOxMo5Tvib3Mj57yIqGDIjeFsTHkrkCChonG6x70QVN0Mu0uTI
 8P4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699025971; x=1699630771;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=kXf+6v1EhgsiRIP/cBxm1fQIr2rY8OIv4e/Alk3FPpo=;
 b=Dt5z4JeuD84gpSqPoBp9vGjKJjlpH/Tyw3LEamDk4pKDRej9NFID3Ax2if7mXcTV/k
 IFn/h76hPHT1/hdmZG4o0DPcJAOZA/tcLGBHCtTK0oE2IfHz+85OxheaRmF0Jv/jb7Kj
 SWrgiwWkwwlFKPMEJKfa/qzeCQLHTUlenxwV+W8EAzgV4TpbhgmBzhDjj5SzpGRiKMz5
 oN/hilfakI1Eo/KYkn8kzBZQCi8QeojFPhaxWrvP2fP/CkjOyXh0GyH9hnGSLtZ3+SnF
 7FoukQIwSkU+m0TqOu/k1AJJeDXCl1jKVYmhGkLpa6JIp9z0tdMQHXpkFBkKbXfsF2Vb
 zlEw==
X-Gm-Message-State: AOJu0YyfNN3BW0FnJMVYD/I7pVZKmWyCLfPdSfWq522ibLRPhVe73nc7
 Hzar37al+eHaSYxHnkvF6659hw==
X-Google-Smtp-Source: AGHT+IFbQTt5S3feVN3ZweDHyyQyx6/NpsMHEWetVW9ceD8Nv6za/Vb6M7zyhQr2BUaCz1E/lcIt8g==
X-Received: by 2002:ac2:4435:0:b0:500:a378:db71 with SMTP id
 w21-20020ac24435000000b00500a378db71mr15964251lfl.57.1699025970597; 
 Fri, 03 Nov 2023 08:39:30 -0700 (PDT)
Received: from lion.localdomain (host-92-25-138-185.as13285.net.
 [92.25.138.185]) by smtp.gmail.com with ESMTPSA id
 fm15-20020a05600c0c0f00b00405391f485fsm2928334wmb.41.2023.11.03.08.39.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Nov 2023 08:39:30 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Subject: [PATCH v3 0/7] arm: mach-snapdragon: Qualcomm clock driver cleanup
Date: Fri, 03 Nov 2023 15:39:24 +0000
Message-Id: <20231103-b4-qcom-clk-v3-0-8d2d460ece84@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACwURWUC/32NQQ6CMBBFr0K6tloGrNSV9zAu2lJgIrQ6JURDu
 LuFnYlx+Wby/ptZdIQusnM2M3ITRgw+QbHLmO20bx3HOjEDAUUuoOSm5E8bBm77O2/yU1OVEio
 lJEuG0dFxQ9rbbnUCYYv+MOg4Olr/D3INvrba9Za4wzgGem/xKV+vvztTzgVXtZLFURmlK7j06
 DWFfaCWrUMT/JEhyfJ4AmPBOKnEl7wsyweQVjg8BAEAAA==
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5032;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=pgpWtvvBQ0F3ff6gQR1dh21JOJrn2n8Q7FZAMgQAEPk=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhlRXEQN5k7bU1Q5M2u1r2O4Hnnspcc8g/qLrGw5trlPm5
 xLu+rV2lLIwCHIwyIopsoifWGbZtPayvcb2BRdg5rAygQxh4OIUgImI6TMytDHunD9T9DD/f+0T
 iSInt2eWvj6TIbrQYUvCrT15X92XzWH4p7G8mX2rj5Bsx4n2oqU9ChtKfyRYmExrPbj/06p962K
 D3wAA
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

