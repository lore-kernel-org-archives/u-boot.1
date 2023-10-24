Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1DC3C25B47
	for <u-boot@archiver.kernel.org>; Tue, 24 Oct 2023 20:24:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B9903879BE;
	Tue, 24 Oct 2023 22:24:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ggVztX66";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DAC3F8716E; Tue, 24 Oct 2023 22:23:58 +0200 (CEST)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8123A874A9
 for <u-boot@lists.denx.de>; Tue, 24 Oct 2023 22:23:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-40842752c6eso38925705e9.1
 for <u-boot@lists.denx.de>; Tue, 24 Oct 2023 13:23:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698179036; x=1698783836; darn=lists.denx.de;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=TCx6NtzmhP/eTO4TNNF0Blgk0MWpoVcnedzdp1BHsAg=;
 b=ggVztX662UTYYwCUwS/HC4F2+8it3fdAZ+J0ESMbsOxBUF0t+AJ+Z9NCFmC8lyk1z3
 BN3+KY82Y1p7+1TKe6zO20zmZwgGR/5Swj61pQ6G7nmLOeNOWFBNDnVMpafDeHfAcxI+
 A/O295HTP4Zz6Okht/NsavTNuejywYWH1IPPXdbqKBfDspEZm4/F9Sb9svVElhTD6W0i
 J7wS6W7+NKKvjHp5CR+TOtwacZUBmv0XjKEps4H7TfejZAae3u1S/b+AYeeSJhd5zkl7
 Cm0X6XjM+27LeolQW5QY2P5hsY3qm0QqenUdy0iu3sDV/SVj6doSh3c0tF+FJqGSHOlY
 mLmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698179036; x=1698783836;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=TCx6NtzmhP/eTO4TNNF0Blgk0MWpoVcnedzdp1BHsAg=;
 b=YTi0aCuLuyINHbL5OIi4Ju6CtsNF6dozBIJEXFialLhzZfax7EsvK0/pKpV3otK5NR
 Id4HkZSsHl1x3lV2pJHiUieVujjMMHoaIVQOGKp3KU/Cj3mwiuxJw71Nrm723mThDvQ9
 myuMPgyBIoFwBp29jIRDyZ/jM3wbGbFPjBlvbxcQUe9m06UFZxI0a+N5TjaO2fJdSf+F
 oK63blHLrQx54NDTy7UdacrtdMwqbPZVNfVVxupORq3jJa5RQCvT2tOqTCMP7h2zk4DW
 UeaW4E4Ot2KXWTgz6R5L+efipF9goLifiiZ2BfT5VN2WStjmXMzlO9nJHphzDoXUAJXw
 Z/BA==
X-Gm-Message-State: AOJu0YyChEH1Iwfd421D36lNibY0if5Lbws7ZlsZ2VwoIbqz7tyiW2Wz
 6YhDxw9V2LB/o56QPILkeT4+Ug==
X-Google-Smtp-Source: AGHT+IGLhBiJxjvnIU772+YPye5UIXq8YJ2IKp+LFNc8pPbTSTos/odplApf1wfNp6LTmmkvsR+dRQ==
X-Received: by 2002:a5d:518f:0:b0:32d:ad4a:bced with SMTP id
 k15-20020a5d518f000000b0032dad4abcedmr9418576wrv.23.1698179035865; 
 Tue, 24 Oct 2023 13:23:55 -0700 (PDT)
Received: from lion.localdomain (host-2-99-112-229.as13285.net. [2.99.112.229])
 by smtp.gmail.com with ESMTPSA id
 l21-20020a056000023500b003198a9d758dsm10682342wrz.78.2023.10.24.13.23.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Oct 2023 13:23:55 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Subject: [PATCH 0/8] arm: mach-snapdragon: Qualcomm clock driver cleanup
Date: Tue, 24 Oct 2023 21:23:51 +0100
Message-Id: <20231024-b4-qcom-clk-v1-0-9d96359b9a82@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANcnOGUC/x2NQQrCMBAAv1L27GISQ61+RTwkcdMu2kR3RYTSv
 5t6HIZhFlASJoVzt4DQh5VraWB3HaQplJGQb43BGXewxnmMHl+pzpged8z2mAffu+FkemhFDEo
 YJZQ0bU0VHrns56Bvks0/hTJ//7fLdV1/EmzzW30AAAA=
To: Ramon Fried <rfried.dev@gmail.com>, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>, Bharat Gooty <bharat.gooty@broadcom.com>, 
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>, 
 Robert Marko <robert.marko@sartura.hr>, 
 Bhupesh Sharma <bhupesh.linux@gmail.com>, 
 Luka Kovacic <luka.kovacic@sartura.hr>, 
 Luka Perkov <luka.perkov@sartura.hr>
Cc: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>, 
 u-boot@lists.denx.de, Caleb Connolly <caleb.connolly@linaro.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.13-dev-46309
X-Developer-Signature: v=1; a=openpgp-sha256; l=3560;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=f7R0n3TGEem50i/dIlpSVjvmIzmu2lc2qcjDhmhkecU=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhlQL9ZvZHPN+TH0b9fG+7uJfV5Z/j5q95v3tcNerrD9XV
 BZ/tj6zs6OUhUGQg0FWTJFF/MQyy6a1l+01ti+4ADOHlQlkCAMXpwBMhP8Mwz+jwLSlh+Z57y7Y
 rZs1//+RzfEZaTc2OR+QEXzSddVERuoUw/9w3YcRB2YzpSaI/9u1fc3D9L+vXt6YIeXmEm+2c2o
 zm2gaAA==
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
Caleb Connolly (7):
      clk/qcom: move from mach-snapdragon
      clk/qcom: add per-platform configs
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
 .../mach-snapdragon/include/mach/sysmap-sdm845.h   |   3 +
 drivers/clk/Kconfig                                |   1 +
 drivers/clk/Makefile                               |   1 +
 drivers/clk/qcom/Kconfig                           |  52 ++++
 drivers/clk/qcom/Makefile                          |  10 +
 .../clk/qcom}/clock-apq8016.c                      |  41 ++-
 .../clk/qcom}/clock-apq8096.c                      |  41 ++-
 .../reset-qcom.c => clk/qcom/clock-ipq4019.c}      | 165 ++++-------
 drivers/clk/qcom/clock-qcom.c                      | 303 +++++++++++++++++++++
 drivers/clk/qcom/clock-qcom.h                      |  96 +++++++
 .../clk/qcom}/clock-qcs404.c                       |  97 +++++--
 drivers/clk/qcom/clock-sdm845.c                    | 265 ++++++++++++++++++
 drivers/reset/Kconfig                              |   7 -
 drivers/reset/Makefile                             |   1 -
 24 files changed, 938 insertions(+), 605 deletions(-)
---
base-commit: 30d01b582f2274eb8c808026c5fb4c33e9f2210d

// Caleb (they/them)

