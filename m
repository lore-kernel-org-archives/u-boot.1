Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10E49606A335
	for <u-boot@archiver.kernel.org>; Sat,  7 Nov 2026 14:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=UYxLnka1;
	dkim=pass (1024-bit key, unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.a=rsa-sha256 header.s=google header.b=mIEAjgCU
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id DC27F8129C;
	Sat,  7 Nov 2026 14:32:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id iob7Olckw-bb; Sat,  7 Nov 2026 14:32:51 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org B12FF80E98
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794061971;
	b=S5cLKmbqoIcnNFExILUmnNgVxAsWg4MK4Bt6itYABs8cixJaKOXrBRfRodjxdTMcMUW/
	 xVOw/r2OWP33ZqTzhSeUxACqPTvlGm6TiPDwQH2Cbaon63XBbxXRtiVatJARiGp51vKLE
	 84tiYKEwWV3y7shb4sduhpQXqBo8bmBkwmkT2ECEIgC80KtewGmrxTjxgCA0h2funORPu
	 FBnGxwOKrJXrpJJ2Yiw5wcGptG6JHZwna7pnvQopBkcQ2curf3XLXfaJybOnhTdKGt9VH
	 BBkaZ9wEjgKYzjC2FHVXNzAjULNNOuDrcqdR762QWrq9C9/T6MtNa6GBM4r/Gia6w7w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794061971;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=Stz1p4Mhx4al5SCBaaUrJIpdN3MTbQZMZWfjWkCMFN0=;
	b=oXYZ9v/RXvx2LEk7zbfqy5CEuYT8Xtox/0uOhbaA+QlXGkWlJtHOkIOowDrWGDK4Ces8
	 RbKJKDbd5WgkvRbQXAB/+nE6ktfqjMFh2yqIcP3raCQjKoooieciefQg/4T7BSFKItO9M
	 DaXPMOW6qZxG4HDOq4limlElz3GbiFtekCnJS1Odh/cH/r/NVO1QfiWpQW/cymqAOGpO7
	 gHn0w+4uSzD9ZrqTzZSI+9BJa2GRZ9KWx7XcXi//fKulbUMEXmXZKGFYeFkzhT/3PtDwl
	 Tj4T5ambJSPwWCTBJuFRbUtVoGTEJ+jJuQNeYH/7ssmY/s8v672F4DVYwfGMAxIMXXg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794061971;
	bh=Stz1p4Mhx4al5SCBaaUrJIpdN3MTbQZMZWfjWkCMFN0=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=UYxLnka1LxLFRLIKf8csYwT0g7z4Y/aF0H5zEyCbKyWXs+ZWv2ujO6/I1vsKyLV2U
	 GVUSHlC61IK5wQDeVoG9c8tb9d2LOBHGxiF21PSPVNkj3LAOk+bvF2A9UQgqjR3/u1
	 gS3u+jcUYYYUZSTF4qIucprj+/q/93BVXEB9WD/1y2hp3uRrOSnq5ChQIlQ4W4EPPq
	 8Vy7S3muCL6N9jH38rA9hfyBHqucoFHpQTcjT6+HB6k+SbDz0SWMo6tCX6IrzMaVUa
	 gwISyjq80I4SgoGd7+F9sphzaeZjFBPQnlwj4ZywqIXuVf+r/azh0jT4GIuQ0QlIuT
	 iyylM5UM2vFbA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id B12FF80E98;
	Sat,  7 Nov 2026 14:32:51 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 09EDB34D
 for <u-boot@lists.u-boot-project.org>; Sat,  7 Nov 2026 14:32:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 06DB960744
 for <u-boot@lists.u-boot-project.org>; Sat,  7 Nov 2026 14:32:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6AlKmKy7i0I3 for <u-boot@lists.u-boot-project.org>;
 Sat,  7 Nov 2026 14:32:49 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org A2CF3606AA
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::329"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::329; helo=mail-wm1-x329.google.com;
 envelope-from=dario.binacchi@amarulasolutions.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com
 header.a=rsa-sha256 header.s=google header.b=mIEAjgCU
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 by smtp3.osuosl.org (Postfix) with ESMTPS id A2CF3606AA
 for <u-boot@lists.u-boot-project.org>; Sat,  7 Nov 2026 14:32:48 +0000 (UTC)
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-4a2167bd087so13977945e9.3
 for <u-boot@lists.u-boot-project.org>; Sat, 07 Nov 2026 06:32:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1794061966; x=1794666766;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Stz1p4Mhx4al5SCBaaUrJIpdN3MTbQZMZWfjWkCMFN0=;
 b=mIEAjgCUIO/1NTELKtFd6wpTxKvv5QBfDpAFXmzqROx7UgqnNGI622ehUOWEu+KDfm
 0ImfBD2973mlsoeRgeKFfDHERNoXfroJfjYM871bExyXX04brKujhepWZ1V22CvEUF55
 Ynm2CQ6jvhwcJvmQZy3l8/dnAM83ahSY5l210=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794061966; x=1794666766;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Stz1p4Mhx4al5SCBaaUrJIpdN3MTbQZMZWfjWkCMFN0=;
 b=Hmw5wLpDKPvYhE2xKfzCZXPajRvv91XM3PaylUFZGg4S+Bv3R29WrXUCu+HuUcgxUH
 9D44V5fyqbHNlejCPwSTyLBcOHdnvkDKYVGOAHE4p0dzVOO+lmq8V1vltJDkBP5/b1l4
 JSx0ZMIznAn4fhfXPYKjHLOyGxy8H9Hh1Vs7d/pvv4xw7e4t5G+FGbr637eOnor8r2MJ
 yO5g4TyyCl4bY7NzFpCSJisa/AvUhgOLPRALe9C8YF61v+BPVumRxSTddN5tdEvuAHBj
 44pK30BqO8hes9fQV6oj6bvdUpRCfmSzF9SF7eSD7yr7XMkASuCtftCHQFOFzmqBup6A
 XmEQ==
X-Forwarded-Encrypted: i=1;
 AL+hErFXY5Q0NBhfzC3UKvIRmcPmt/fWBxj9kWmrfOvti73nwMKNNxXw+JE2Dw2eJR2aPxWmJWtYkGs=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z+apVIerCs0brMNaaGCyAcxAYJXfFOw4QKr/j1qY+CCGB3Z2MzU
 oDtYYO4QxKOcRutC9Acg1eliScsd7VigQV28gbKTL+Fb6uIwJ4W8tY/idZF3aHYsOPw=
X-Gm-Gg: AYBFou1WOKeLco4N8izRqapjSxZUjgrpCtrlipBkVACLYRbnTLlv5k8F6zfabyXkYEG
 iSwNUwEZnqBDnqGcfHVFrAqGA2lFGPYgOI8XWTE363k4zZ6hpIGf0xiD32vwm77NGNdOdqm5Z/G
 aY7DM8QSqDm4D0EFqJd5I4ytg4HD57hKSKfcJsy33OfUucoPc4fmi3DkntQfPTQchC86XB0sCBl
 X4jF16H02c1RTWXWkSlYfu0PfaiMMaa234xRbJ7ZL3O7u5JDFNvoHlybgNzvnXhnQbTt+EhSxAM
 bciSTh8dzzAZEwcbMTmwIdXNBUpwIzyxSfahhHZL6olv7SY1SBHwDDx5TknO65G7+GkF1Dw2JHw
 d1yQdFGFKyk23I95dF6DJCCJT6r0Hfs67tJYhdG7uvbRQD0jK4Aq8EonqH4H8rxHa2Qq5/Pv/kb
 4GR1+sWq1VcYRuh4iOYnirwTooXgINu4xmN8IDG6Yp+1SUX5eIOoXZkgaTsLIRGsYKgCPuTaUmg
 oEfVUXiOtXlf9oFM9xfwM5T2H6XIyHQwG1+qlUACCuwBLdk20GP4lPlb8Rrqe+HNbEcraaiJO5k
 yL+RFYJXOR6hMwkoekXYaA392HjWVdHDWQn4Jp8+/K31WyMw2ob8KVNKbO8dbJGZFYeesf+s/TN
 HO6K8Rv96jrkd82NSoj8HmF62twpMJvI0M5g3OEpMuVxWLIB/KtACk1eehXZQMMI+JPShjnE32N
 pK9zEPcXUCTAmX6rVaGKpOASmm/g==
X-Received: by 2002:a05:6000:230b:b0:492:dddc:64c3 with SMTP id
 ffacd0b85a97d-492ddeba90cmr9785117f8f.41.1794061965558; 
 Sat, 07 Nov 2026 06:32:45 -0800 (PST)
Received: from dario-ThinkPad-P14s-Gen-5.homenet.telecomitalia.it
 (host-79-14-29-58.business.telecomitalia.it. [79.14.29.58])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-492d7cc6187sm10027247f8f.46.2026.11.07.06.32.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 07 Nov 2026 06:32:44 -0800 (PST)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>
Cc: michael@amarulasolutions.com, linux-amarula@amarulasolutions.com,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Anatolij Gustschin <ag.dev.uboot@gmail.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Casey Connolly <casey.connolly@linaro.org>,
 Conor Dooley <conor.dooley@microchip.com>,
 David Lechner <dlechner@baylibre.com>,
 Gabriel Fernandez <gabriel.fernandez@foss.st.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jagan Teki <jagan@amarulasolutions.com>, Johan Jonker <jbx6244@gmail.com>,
 Kory Maincent <kory.maincent@bootlin.com>,
 Lukasz Majewski <lukma@nabladev.com>,
 Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>,
 Simon Glass <sjg@chromium.org>, Sumit Garg <sumit.garg@kernel.org>,
 Tom Rini <trini@konsulko.com>, Yannick Fertre <yannick.fertre@foss.st.com>,
 Yao Zi <me@ziyao.cc>, u-boot@lists.denx.de,
 u-boot@lists.u-boot-project.org, uboot-stm32@st-md-mailman.stormreply.com
Subject: [PATCH v2 00/35] Add Engicam MicroGEA-STM32MP257D-RMM board support
Date: Sat,  7 Nov 2026 15:31:50 +0100
Message-ID: <20261107143241.2236511-1-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This series adds support for the Engicam MicroGEA-STM32MP257D-RMM
board, with its RGB and LVDS displays and the FWU A/B update.

The first patches pick the board devicetrees, merged for Linux v7.4,
from devicetree-rebasing. They can be dropped if dts/upstream is synced
with v7.4-dts first. Then come the fixes, the refactors moving the
STM32MP2 environment and FWU support to the SoC code, and the board
support. The displays are described by the upstream overlays, which a
new option applies to the U-Boot devicetree at build time. The
bootph-all properties of the board have been sent to Linux [1].

Tested on the board, booting from the SD card and from the eMMC.

[1] https://lore.kernel.org/all/20261107141353.2228391-1-dario.binacchi@amarulasolutions.com/

Changes in v2:
- Take the original patch from the ST downstream tree, keeping
  Gabriel's authorship
- New patch
- Add Reviewed-by tag
- Add Reviewed-by tag
- New patch
- Simplify the comments
- Apply the upstream display overlays to the U-Boot devicetree instead
  of describing the displays in the -u-boot.dtsi file
- Do not leave the LTDC RGB pins configured with the LVDS display
- Drop a redundant comment

Dario Binacchi (34):
  dt-bindings: arm: stm32: support Engicam MicroGEA-STM32MP257D-RMM
    board
  arm64: dts: st: add power-domains to sdmmc1 on stm32mp231
  arm64: dts: st: add power-domains to sdmmc1 on stm32mp251
  arm64: dts: st: add SDMMC2 support on stm32mp25
  arm64: dts: st: add CAN1 support on stm32mp25
  arm64: dts: st: add i2c1 pins for stm32mp25
  arm64: dts: st: add ltdc pins for stm32mp25
  arm64: dts: st: add can1 pins for stm32mp25
  arm64: dts: st: add pwm2/pwm4 pins for stm32mp25
  arm64: dts: st: add sai1 pins for stm32mp25
  arm64: dts: st: add sdmmc2 pins for stm32mp25
  arm64: dts: st: add spi1 pins for stm32mp25
  arm64: dts: st: add usart1 pins for stm32mp25
  arm64: dts: st: support Engicam MicroGEA-STM32MP257 SoM
  arm64: dts: st: support Engicam MicroGEA-STM32MP257D-RMM board
  arm64: dts: st: move Engicam MicroGEA-STM32MP257D-RMM display to an
    overlay
  arm64: dts: st: add Engicam MicroGEA-STM32MP257D-RMM LVDS display
    overlay
  arm: stm32mp: stm32mp2: fix off by one in mmc_get_boot()
  video: stm32: lvds: fix NULL pointer dereference on missing
    data-mapping
  spi: stm32: ignore the cs-gpios polarity flags
  video: stm32: ltdc: fall back to a panel when no bridge is connected
  video: stm32: ltdc: stop looking for the panel once found
  arm: stm32mp: stm32mp2: move boot device environment helpers to SoC
    code
  splash: make splash_video_logo_load() available to boards
  arm: stm32mp: move FWU multi-bank support to SoC code
  configs: stm32mp25: move FWU A/B boot environment to common settings
  video: simple_panel: add Ampire AM-1280800W8TZQW-T00H panel
  video: stm32: ltdc: select the pixel clock source on STM32MP25
  boot: extension: allow longer overlay file names
  dts: support applying DT overlays to the control DT with OF_UPSTREAM
  board: engicam: stm32mp2: add MicroGEA-STM32MP257D-RMM board
  board: engicam: stm32mp2: add splash screen
  board: engicam: stm32mp2: support FWU A/B bank bootup
  board: engicam: stm32mp2: enable simple framebuffer for the splash
    screen

Gabriel Fernandez (1):
  clk: stm32: fix set_rate propagation for parent clocks

 ...m32mp257d-engicam-microgea-rmm-u-boot.dtsi |  38 ++
 arch/arm/mach-stm32mp/Kconfig.25x             |  17 +
 arch/arm/mach-stm32mp/Makefile                |   1 +
 .../arm/mach-stm32mp/fwu.c                    |   0
 arch/arm/mach-stm32mp/stm32mp2/Makefile       |   1 +
 arch/arm/mach-stm32mp/stm32mp2/env.c          |  82 +++++
 board/engicam/stm32mp2/Kconfig                |  12 +
 board/engicam/stm32mp2/MAINTAINERS            |   7 +
 board/engicam/stm32mp2/Makefile               |   7 +
 board/engicam/stm32mp2/microgea-stm32mp2.env  |  13 +
 board/engicam/stm32mp2/stm32mp2.c             | 340 ++++++++++++++++++
 board/st/common/Makefile                      |   1 -
 board/st/stm32mp2/stm32mp2.c                  |  71 +---
 common/splash.c                               |   4 +-
 configs/stm32mp25-microgea-rmm_defconfig      | 129 +++++++
 drivers/clk/stm32/clk-stm32-core.c            |  11 +-
 drivers/spi/stm32_spi.c                       |   9 +-
 drivers/video/simple_panel.c                  |  19 +
 drivers/video/stm32/stm32_ltdc.c              |  71 +++-
 drivers/video/stm32/stm32_lvds.c              |   4 +-
 dts/Kconfig                                   |  10 +
 dts/Makefile                                  |   2 +
 dts/upstream/Bindings/arm/stm32/stm32.yaml    |   7 +
 dts/upstream/src/arm64/st/stm32mp231.dtsi     |   1 +
 .../src/arm64/st/stm32mp25-pinctrl.dtsi       | 328 +++++++++++++++++
 dts/upstream/src/arm64/st/stm32mp251.dtsi     |  17 +
 dts/upstream/src/arm64/st/stm32mp253.dtsi     |  16 +
 .../arm64/st/stm32mp257-engicam-microgea.dtsi |  63 ++++
 ...gea-rmm-overlay-am-1280800w8tzqw-t00h.dtso |  67 ++++
 ...icrogea-rmm-overlay-rk050hr345-ct106a.dtso |  68 ++++
 .../st/stm32mp257d-engicam-microgea-rmm.dts   | 275 ++++++++++++++
 include/configs/stm32mp25_common.h            |  20 ++
 include/configs/stm32mp25_st_common.h         |  15 -
 include/extension_board.h                     |   2 +-
 include/splash.h                              |   9 +
 scripts/Makefile.dts                          |   7 +
 36 files changed, 1637 insertions(+), 107 deletions(-)
 create mode 100644 arch/arm/dts/stm32mp257d-engicam-microgea-rmm-u-boot.dtsi
 rename board/st/common/stm32mp_fwu.c => arch/arm/mach-stm32mp/fwu.c (100%)
 create mode 100644 arch/arm/mach-stm32mp/stm32mp2/env.c
 create mode 100644 board/engicam/stm32mp2/Kconfig
 create mode 100644 board/engicam/stm32mp2/MAINTAINERS
 create mode 100644 board/engicam/stm32mp2/Makefile
 create mode 100644 board/engicam/stm32mp2/microgea-stm32mp2.env
 create mode 100644 board/engicam/stm32mp2/stm32mp2.c
 create mode 100644 configs/stm32mp25-microgea-rmm_defconfig
 create mode 100644 dts/upstream/src/arm64/st/stm32mp257-engicam-microgea.dtsi
 create mode 100644 dts/upstream/src/arm64/st/stm32mp257d-engicam-microgea-rmm-overlay-am-1280800w8tzqw-t00h.dtso
 create mode 100644 dts/upstream/src/arm64/st/stm32mp257d-engicam-microgea-rmm-overlay-rk050hr345-ct106a.dtso
 create mode 100644 dts/upstream/src/arm64/st/stm32mp257d-engicam-microgea-rmm.dts

---
base-commit: feb8913982e4462c01fd914271f92254a25dc101
branch: engicam-microgea-stm32mp257-rmm

-- 
2.43.0

