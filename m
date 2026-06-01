Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4C32CD5BD1
	for <u-boot@archiver.kernel.org>; Mon,  1 Jun 2026 12:07:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1DB7084895;
	Mon,  1 Jun 2026 14:07:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=samcday.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=samcday.com header.i=@samcday.com header.b="fkusCror";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1D0D784701; Mon,  1 Jun 2026 10:03:42 +0200 (CEST)
Received: from mail-4320.protonmail.ch (mail-4320.protonmail.ch [185.70.43.20])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E4BE9846F8
 for <u-boot@lists.denx.de>; Mon,  1 Jun 2026 10:03:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=samcday.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=me@samcday.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samcday.com;
 s=protonmail3; t=1780301018; x=1780560218;
 bh=vBR5dEbmxUFkeej6FK4N0LKTNtjkq/ibzxupdv2OPHQ=;
 h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
 b=fkusCrorgUP1diLpmEcdcBOBUcZhOI65cyFvk0QF6uqGiurGUM4sWvziYvdzduchP
 z2arjSo9ARtcK2F9OUe5NMfss7Jb2kI8RXfQ7hS9Tek2+xJ57fWfbauld3z2ZETKNM
 0ggbkzf+Osui8scg+piZsdB1zLtJggQs9EXN2BZAIuqG7DQGrOf2rkUyPIrjT24J+A
 t3fSZFHqhItigsDsCc9HoG8rSNdLWAx9iMe9GBhNqj5qRuO8/ccxSJwzdyIFA8f8OH
 tTy2zjpg2RedB4LipRuIs19OLT451cuIMGIU7wpnVa+z3Xs9/wb2ScZtIkMggiMGlK
 QF+m+5eYD9JFw==
Date: Mon, 01 Jun 2026 08:03:30 +0000
To: Sumit Garg <sumit.garg@kernel.org>, u-boot-qcom@groups.io,
 u-boot@lists.denx.de
From: Sam Day <me@samcday.com>
Cc: Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini <trini@konsulko.com>,
 Stephan Gerhold <stephan.gerhold@linaro.org>,
 Michal Simek <michal.simek@amd.com>,
 Angelo Dureghello <angelo@kernel-space.org>,
 Eugen Hristev <ehristev@kernel.org>, Kuan-Wei Chiu <visitorckw@gmail.com>,
 Yao Zi <me@ziyao.cc>, Simon Glass <sjg@chromium.org>,
 Sughosh Ganu <sughosh.ganu@arm.com>, George Chan <gchan9527@gmail.com>,
 Antony Kurniawan Soemardi <linux@smankusors.com>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>, Peng Fan <peng.fan@nxp.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Anshul Dalal <anshuld@ti.com>, Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Tingting Meng <tingting.meng@altera.com>, Alice Guo <alice.guo@nxp.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Luca Weiss <luca.weiss@fairphone.com>, Aswin Murugan
 <aswin.murugan@oss.qualcomm.com>, David Wronek <david.wronek@mainlining.org>,
 Danila Tikhonov <danila@jiaxyga.com>,
 Varadarajan Narayanan <quic_varada@quicinc.com>,
 Lukasz Majewski <lukma@denx.de>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 Jens Reidel <adrian@mainlining.org>, Sam Day <me@samcday.com>
Subject: [PATCH 00/16] MSM8960 / mach-snapdragon ARMv7 support
Message-ID: <20260601-qcom-armv7-v1-0-c4b7f7aae1eb@samcday.com>
Feedback-ID: 25366008:user:proton
X-Pm-Message-ID: 19382a124316028d8f014b8ef83f0556fc4988c9
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Mon, 01 Jun 2026 14:07:04 +0200
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

This patch series introduces support for ARMv7 Qualcomm SoCs, starting
with MSM8960/MSM8930/MSM8227.

An overview of the changes:
 * serial_msm reintroduces the previous packed RX/TX software mode
   operation, as this is compatible with all UARTDM versions (1.4 and
   older). It's added alongside the newer single-char mode for 1.4.
 * A timer driver is introduced for KPSS. I don't know if *all* ARMv7
   qcom SoCs lack generic ARM CP15 debug timer support, but at least
   MSM8960/MSM8930 do.
 * mach-snapdragon board code is shuffled around a bit to build cleanly
   on ARM64.
 * prev_bl_data support is extended to ARM32 (which uses r2 for passing
   FDT/ATAGS pointers, rather than r0)
 * qcom_parse_memory is revised to support arm32 memory nodes (which are
   1-cell rather than 2-cell).
 * Basic ATAGS support is introduced, so that the memory info can be
   used from previous bootloaders that do not understand FDTs at all.
 * PS_HOLD sysreset and pinctrl-qcom needed some minor tweaks to handle
   some nuances that challenge the current assumptions.
 * A pinctrl driver is introduced for MSM8960.
 * Initial MSM8960 GCC infra is introduced.

I tested this series on:
 * Nokia Lumia 520 (msm8227). No working buttons yet as these are
   exposed as GPIO-over-PMIC-over-SSBI (drivers will be proposed at a
   later date).
 * Samsung Galaxy Express GT-I8730 (msm8930). Volume rockers + home
   button are working via the new pinctrl-msm8960 driver. Power
   button not working yet (needs PMIC driver infra).
 * I have no msm8960/apq8064 devices, looking for folks to test those.

To confirm there was no regressions with ARM64 and/or newer devices, I
also tested on:
 * db410c (msm8916)
 * google-sargo (sdm670)

Signed-off-by: Sam Day <me@samcday.com>
---
Sam Day (16):
      serial: msm: UARTDM <1.4 support
      timer: Qualcomm KPSS timer support
      arm: save_prev_bl_data: ARM32 support
      mach-snapdragon: qcom_parse_memory 32-bit support
      mach-snapdragon: gate ARM64 features
      mach-snapdragon: introduce ARCH_SNAPDRAGON_ARM32
      configs: introduce qcom_armv7_defconfig
      board: qualcomm: add MSM8960 debug UART config
      sysreset: qcom-pshold: offset support
      pinctrl: qcom: configurable GPIO offset/stride
      pinctrl: qcom: introduce MSM8960 driver
      mach-snapdragon: parse incoming ARM32 ATAGS
      clk: qcom: MSM8960 GCC driver
      clk: qcom: arch-agnostic pointer fmtstrings
      serial: msm: wait for TX empty before reinit
      button: remap phone HOMEPAGE button

 arch/arm/Kconfig                             |  11 +-
 arch/arm/lib/save_prev_bl_data.c             |  49 ++++---
 arch/arm/mach-snapdragon/Kconfig             |   6 +
 arch/arm/mach-snapdragon/board.c             | 188 ++++++++++++++++++-----=
---
 arch/arm/mach-snapdragon/include/mach/gpio.h |  12 +-
 board/qualcomm/debug-msm8960.config          |   5 +
 configs/qcom_armv7_defconfig                 |  61 +++++++++
 drivers/button/Kconfig                       |   2 +-
 drivers/button/button-uclass.c               |   1 +
 drivers/clk/qcom/Kconfig                     |   8 ++
 drivers/clk/qcom/Makefile                    |   1 +
 drivers/clk/qcom/clock-msm8960.c             | 189 +++++++++++++++++++++++=
++++
 drivers/clk/qcom/clock-qcom.c                |   8 +-
 drivers/gpio/msm_gpio.c                      |   2 +-
 drivers/pinctrl/qcom/Kconfig                 |   9 ++
 drivers/pinctrl/qcom/Makefile                |   1 +
 drivers/pinctrl/qcom/pinctrl-msm8960.c       | 135 +++++++++++++++++++
 drivers/pinctrl/qcom/pinctrl-qcom.c          |   2 +-
 drivers/serial/serial_msm.c                  | 142 +++++++++++++++++---
 drivers/sysreset/sysreset_qcom-pshold.c      |   9 +-
 drivers/timer/Kconfig                        |   7 +
 drivers/timer/Makefile                       |   1 +
 drivers/timer/qcom-kpss-timer.c              |  98 ++++++++++++++
 23 files changed, 843 insertions(+), 104 deletions(-)
---
base-commit: 8d3ba3753bdb5068884196ff696cc48177bfdda5
change-id: 20260530-qcom-armv7-1486308a835c

Best regards,
--=20
Sam Day <me@samcday.com>


