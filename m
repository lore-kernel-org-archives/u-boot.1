Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D28E606A335
	for <u-boot@archiver.kernel.org>; Sat, 28 Nov 2026 13:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=EtVoN0Sr;
	dkim=pass (1024-bit key, unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.a=rsa-sha256 header.s=google header.b=ZPGXp4yU
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 69BEB80E17;
	Sat, 28 Nov 2026 13:11:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jJOgeDR9PKDw; Sat, 28 Nov 2026 13:11:39 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 52CE880DEA
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795871499;
	b=OtR8a725n+NcPIBf8C9R+0vZt3vS9+2qokwLzSMzApnI8+sgy8dAnL3/CuBON1UtnSMB
	 d6MT4SwyB6v/UCYDRpx/2Y0g8GMtRZg/7FMnivEoFjTlsun0bI4b/PxpqmCIDVgcGQ3AI
	 twtdk38PL3flyFmYxyvxqubYazm95u/uotO4PNwOYstBHXQ5qN5D6ue9Iax0OPg90wbpy
	 5nno3OpBzaEMKJYNCBnWvSXKcfD/Ig1kn8Zpfyi0xGEHxEbTa9b4d9rwCVTIMmsGYNXgv
	 3R4tHhRzZXx5l5psv5wVPDOOOEA4qRJj0NH2H4kbvhdONWfIw7CtPVrZyQxz3ud3Luw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795871499;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=jue0Epq7AxSC2nlKXsiUBNojp93Ytixe6k/GJ+Q0NJs=;
	b=beTRgqueEAAeL+oY+I+xAvpQv2Nwhi4NpU6B5yMtCd/9P33my5gMsF9h0Wf4/4unT+3T
	 qF1dt5I4YwABIOWPimHorFdWBxbQp+hn5xBQYddC9Ika7zXLTfQlGw25VRd03oI27posp
	 yt/Lw4My1Sfe3twZgwwbYRqOQPUxUT98S+H5vrpMQITzZLAdRmnr8JR50ezzZqiICCr63
	 W6oq3BPE91+B/+oWzWsmqCio6QWTkZtfA9/AuF+jHD82mE3c4PU9VWn//e8FYTEBXBi7o
	 9db5ME5x0HA3xkeMHQoW6xxtyx12i5zmnWR8bn7JZZXpKzR40sprxPaO2+aSSDm9iqg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	dmarc=pass header.from=amarulasolutions.com;
	dkim=pass header.d=amarulasolutions.com header.i=@amarulasolutions.com header.a=rsa-sha256 header.s=google header.b=ZPGXp4yU;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795871499;
	bh=jue0Epq7AxSC2nlKXsiUBNojp93Ytixe6k/GJ+Q0NJs=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=EtVoN0SrqAtsd7R+pClexgHoYM0GIxeP0FSnKrkG90cdfht1gqqzXqBDvyf6PTxHe
	 DXSLHEPf0E6BseYLzrIhqiG/Uk1KKK2k6621eJ+UpMYhuA6icrFgWOX8z6F7crYk5P
	 HcYlK/Yy0Y1Ua9cfSF3aSCpErdZNYRQregdv6MNVj5315mHRhd5J0iwh0+8t3ExVgR
	 LSovr/04Uw5D25CRL+U3qfw4tAoucMf8ZRh10T5B/VIPyE2AOuAJJTUbI06l54RlnB
	 IegFSxrjuYXZAeUDY4rZOxYeByk/4pXNaTubtjewVMhOB0z6t3keGF7w0OoUmmMaSo
	 hYKZ21dlumZIQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 52CE880DEA;
	Sat, 28 Nov 2026 13:11:39 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 63DD83C0
 for <u-boot@lists.u-boot-project.org>; Sat, 28 Nov 2026 13:11:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 551E680DEC
 for <u-boot@lists.u-boot-project.org>; Sat, 28 Nov 2026 13:11:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id eotI2aYluwyt for <u-boot@lists.u-boot-project.org>;
 Sat, 28 Nov 2026 13:11:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org DA79380DE8
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::331"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::331; helo=mail-wm1-x331.google.com;
 envelope-from=dario.binacchi@amarulasolutions.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com
 header.a=rsa-sha256 header.s=google header.b=ZPGXp4yU
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 by smtp1.osuosl.org (Postfix) with ESMTPS id DA79380DE8
 for <u-boot@lists.u-boot-project.org>; Sat, 28 Nov 2026 13:11:35 +0000 (UTC)
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4a5177d78c7so91413985e9.2
 for <u-boot@lists.u-boot-project.org>; Sat, 28 Nov 2026 05:11:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1795871493; x=1796476293;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=jue0Epq7AxSC2nlKXsiUBNojp93Ytixe6k/GJ+Q0NJs=;
 b=ZPGXp4yUiTI+oQGE8eNJdB3iBT5sFUud/rMsrMAE+Tzld/3nUzTyB5rjSsIIfxrLQd
 LLlIM/jBmMd2kL44LxYsm22gooEB+TsJbzPTbj95xHUAeoVdEpVuNCbK44DhguHFB4+/
 VwkV7KPc1jqGIK65LW0DVxcW6tAjIgUBM7OyI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795871493; x=1796476293;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=jue0Epq7AxSC2nlKXsiUBNojp93Ytixe6k/GJ+Q0NJs=;
 b=lB/SpqiUN36kYOBt2Vv1jm/HTyhVVwazKSDTzj2vWpWRc/DhaYUQOrJ0poGf2m31lK
 +jkkssomrxLdkiVR2eMGlT9+XS0FJVExnJl0bEJP7ut3n8mPNJL68FD7bxaAxKw8bfy9
 GTjoGXdz6DMPOzz/QTGQe3DUrjvnP0gdKn9x0Ybl3HHST9uh81ikbZI/cKHA9dRYlKV5
 4MNg9o1Yv/5fpTOkhrWZFW1K2CNq5ScEeUeLzMX3K5l44V+9kkkKEh0dlPqinPKEElxy
 9LfrXc0AtuLc9/QjW4B19eRMcpo42u+CjFRR2/LyGUM2U56xqhZHHaIAfknHQeZEAuBd
 6uCQ==
X-Forwarded-Encrypted: i=1;
 AL+hErHQltW4jnKjcbaxRH9eLiXqXb9/8eCro8dndE0ErJ/Ksodimsw55Ei4k56AaaczOSI8lCSkYbU=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z/4XFewNDoMgwqKePQ1SfE/M4fuH6BhH49tsK2nwyuvoWpXqEco
 ArkaumCPJ308DnUFwgpVsNNQ0J0dlEseg9akjHkWU4GuCV8VthfCoBqtWtK07k57Tpo=
X-Gm-Gg: AZFdTZcfRujKiYe4X4mc242PzoaFrUqEPRekPRQ1cZi6tX9KWrEeOlr11cYF475fJ2e
 rJRmXyN2Cj8PjIAhQmfM+Z68WBrbOLvCyuhdtGADDsU3yYTnm4+EomMthjRRRfpL8ez0ch3Ca6R
 1w07JhDFYeKPo+CbQf/oy8VDohpAeBAhL+Ea5ZCCIhgwABxmvwS2vuqY27CXwtXbyVfJ2p3fKHP
 UXCq4tOwLYnFe1CSxvfiGJZpTKIkeV5dEjT4H8BF4R8LP95i0wO1qAzZkyXiQ3lWBV3LJZ/Rw3R
 xwYwB9IxLDcdqhwyvzC8K9PZdMAIECEROBKQSaAauQQeCNRZ/4g+ux7gWIFXjiH1Cq8qrPOsfYC
 1VuUzKHeAr5yhYioSqjfz+5C2BARZA21P1g+tz2H4NaY99yIBNv0LGaDRHH9ucZfaK2Uul7L0EF
 aEv/s8WsZy1alJeMPpPSLJEFY9d/cOKi8T2LOidNwdG/Dimd1tsVo2vkhLibpGuYIKOx4mq7JA4
 o4hnlvUsCT8aE5b7xneq/6ESLRb2Udy+FzFkfPZ5WX9Zk3JFEuDAgt2SnDW0eP0oXkcndLYJ5Tw
 WUPbL9RtIzjk2Ck2Ndv6pEsz2r+BGVwYDusMyOSZyXWi5JMmBoLGLDiCyJZwHsBul3LVCuC1hIc
 S/CWhdBRO2JskwWUAjLU8bTteMzYXv2hZfT8JvLe0G3onmnzCLZjYT0DNlmfI3ceYWc6PMAepM/
 cPAkEh/lcPJF5+p0cOu+LuojV99stlZlpcVaRzoceAtiFnU/I=
X-Received: by 2002:a05:600c:8210:b0:4a2:1a:a116 with SMTP id
 5b1f17b1804b1-4bb887865b5mr557966635e9.0.1795871492837; 
 Sat, 28 Nov 2026 05:11:32 -0800 (PST)
Received: from dario-ThinkPad-P14s-Gen-5.homenet.telecomitalia.it
 (host-79-14-29-58.business.telecomitalia.it. [79.14.29.58])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb853b2437sm1076382015e9.13.2026.11.28.05.11.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 28 Nov 2026 05:11:32 -0800 (PST)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>
Cc: Yannick Fertre <yannick.fertre@foss.st.com>,
 linux-amarula@amarulasolutions.com, michael@amarulasolutions.com,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Anatolij Gustschin <ag.dev.uboot@gmail.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Casey Connolly <casey.connolly@linaro.org>,
 David Lechner <dlechner@baylibre.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Johan Jonker <jbx6244@gmail.com>,
 Kory Maincent <kory.maincent@bootlin.com>,
 Sumit Garg <sumit.garg@kernel.org>, Tom Rini <trini@konsulko.com>,
 Yao Zi <me@ziyao.cc>, u-boot@lists.u-boot-project.org
Subject: [PATCH v3 00/29] Add Engicam MicroGEA-STM32MP257D-RMM board support
Date: Sat, 28 Nov 2026 14:10:17 +0100
Message-ID: <20261128131125.2141352-1-dario.binacchi@amarulasolutions.com>
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
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This series adds support for the Engicam MicroGEA-STM32MP257D-RMM
board, with its RGB and LVDS displays and the FWU A/B update.

The first patches pick the board devicetrees, merged for Linux v7.4,
from devicetree-rebasing. Then come the refactors moving the STM32MP2
environment and FWU support to the SoC code, and the board support.
The displays are described by the upstream overlays, which a new
option applies to the U-Boot devicetree at build time. The bootph-all
properties of the board have been sent to Linux [1].

Tested on the board, booting from the SD card and from the eMMC.

[1] https://lore.kernel.org/all/20261107141353.2228391-1-dario.binacchi@amarulasolutions.com/

Changes in v3:
- Add Reviewed-by tag
- Add Reviewed-by tag
- Add Reviewed-by tag
- Add Reviewed-by tag
- Select the pixel clock source only on st,stm32mp255-ltdc
- Add Reviewed-by tag
- Add Reviewed-by tag
- Add Reviewed-by tag
- Add Reviewed-by tag
- Add Reviewed-by tag
- Drop the patches applied to u-boot/main

Changes in v2:
- Add Reviewed-by tag
- Add Reviewed-by tag
- New patch
- Simplify the comments
- Apply the upstream display overlays to the U-Boot devicetree instead
  of describing the displays in the -u-boot.dtsi file
- Do not leave the LTDC RGB pins configured with the LVDS display
- Drop a redundant comment

Dario Binacchi (29):
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
 drivers/video/simple_panel.c                  |  19 +
 drivers/video/stm32/stm32_ltdc.c              |  55 +++
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
 33 files changed, 1614 insertions(+), 90 deletions(-)
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
base-commit: 40bafcab3bea0511eb3925da2f0fdc1df9758e3d
branch: engicam-microgea-stm32mp257-rmm

-- 
2.43.0

