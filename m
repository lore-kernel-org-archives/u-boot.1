Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B82B2E92FCB
	for <u-boot@archiver.kernel.org>; Mon, 29 Dec 2025 18:15:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BB3EE83EA9;
	Mon, 29 Dec 2025 19:15:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="hLruJ8KJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 968C583EAF; Mon, 29 Dec 2025 19:15:31 +0100 (CET)
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com
 [IPv6:2607:f8b0:4864:20::429])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F14BA8393F
 for <u-boot@lists.denx.de>; Mon, 29 Dec 2025 19:15:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-7fc0c1d45a4so8221077b3a.0
 for <u-boot@lists.denx.de>; Mon, 29 Dec 2025 10:15:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1767032127; x=1767636927; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=2DFNAlmHeRVVC9KMz1/A9/CRYPDJtLHge2RSHK5jkzo=;
 b=hLruJ8KJmsiXmlgFnDdgtFVYk2lAngaTPT+gqRhF9pEpYPgAKEwlRHqitp7NGsNukx
 D1srQxhREKptX1SsiSBxH6t71ulHGSdgkprDe0HbLtR7K0KJ46GCy6qySlnVGt6pjBgu
 KgPMM+ZRyZ+SlAAG+FfCVNceXKwwetUqRGb01SIayozQKKxziUPDlIzpPrwq3IHvsFO3
 15lU86diWyNBuxavKnV90DPM5JI7Vs0wQtxlak2CuvUUxypb/LdfHXh9p0q96QW7M/YQ
 03vdv9E5TeiXIHOq5BG6BulxcRaVX409XPbYphFY98baBN27xbiBRsLdUtkm4fIESsn9
 779g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767032127; x=1767636927;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2DFNAlmHeRVVC9KMz1/A9/CRYPDJtLHge2RSHK5jkzo=;
 b=ax7UNheGcLQeF00Pe5F+Q7tEfWaMh2yCgwbKgzpHSSLXqD6M7jUJzi7DzpFVJ9b5rC
 KYrroiNLraeBpK+6X0LA2T5YJI4CAp4sgwaPTDCkzDPCUmLs9lawDv00jxJEs/B8cZXK
 xNhzBRmACuC5uY6TLMe+xEn7yYoh5LLpOKTDaXewPG/X9nWtv8RLUDnhuLaQ6LjP0RGn
 MlPFDEPyUwtzm+HGjj3ElUJYfN5r2+XOpOQv310v99hiuqXlcrpWMadVQDCAAbxY8nWi
 PCnbTpo6ztxTKUkvEH8MR0S6bx/5dLR8sQFlWnDZnw9+Y9ks5aj11o5m8joUqsu023Qu
 PO2w==
X-Gm-Message-State: AOJu0Ywr0qXpU8BpaK5oC22qUrkwRoZ5JwRo8lueR4Rf+fJGUFL26Are
 avdw1XSniBZNROKlHE1GaVYjXodFgPKsAFvgEzDAkuZG6b9yMNDhx9Fn
X-Gm-Gg: AY/fxX7UzihFpB9YtXktqWOlnz7fzhZjM6tJ3uWBnnSf5FcfM7iDb2RZ96L0ctGqu/x
 ALaQwe3hRKXnMR1fBjkRXN7pRvEn6C3HeObG37Svp/9sYPfzF/ZuGPwGgf88hwxoBMQ2RFtWXP3
 AhD5dGzNzcnjl8dUtOqjCxLTLsp8vbryDUh/+K0dHyyrDtxVDE5Y7OrtttbK2Pj2U0Hjmp4YDnl
 lEnIQBXMnfLuSYeMuiiqzv/vTQcNGsFHWLp7qS1NdwR787qGZA+vVzIiXkq3JQ8SsrMIw9iY0fA
 jd7DnM8s4CNA1JaQcdfybEhvUVllAzRuR3dOnXyi7c4vVsVn22xosc5n47hFZRDDbN1ZBhfELnJ
 KhPQ5BZpNGqC/V8ld7TGF+sNzsbEZJs7TGKadZZlWTU/Rpz05rzN59xUxerul2dtlFMSXZHHKAY
 Jd/Bnp+howc4Kn9UqjSAVuDw==
X-Google-Smtp-Source: AGHT+IFrUdCtFxw4GCtERAS2E8vEq7tJBNINecShYRX/MBnyYqJN/4Y24DBQ6hpeHPNUZzReSIX1PQ==
X-Received: by 2002:a05:7022:e80d:b0:11b:ceee:b797 with SMTP id
 a92af1059eb24-121722ebc95mr34687922c88.25.1767032127065; 
 Mon, 29 Dec 2025 10:15:27 -0800 (PST)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:ea:c045:42b5:9a03])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1217254ce49sm116833683c88.15.2025.12.29.10.15.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Dec 2025 10:15:26 -0800 (PST)
From: Fabio Estevam <festevam@gmail.com>
To: trini@konsulko.com
Cc: u-boot@lists.denx.de
Subject: [GIT PULL] Please pull u-boot-imx-next-20251229
Date: Mon, 29 Dec 2025 15:15:23 -0300
Message-Id: <20251229181523.3450679-1-festevam@gmail.com>
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

The following changes since commit f24a2124d26eb6b1aab3b20923359ede80105a8b:

  Merge tag 'efi-next-20251225' of https://source.denx.de/u-boot/custodians/u-boot-efi into next (2025-12-25 11:31:11 -0600)

are available in the Git repository at:

  https://gitlab.denx.de/u-boot/custodians/u-boot-imx.git tags/u-boot-imx-next-20251229

for you to fetch changes up to 253a96ffb66a931f72a3e8ace0fcb5ec87e0e4e5:

  Makefile: Make flash.bin target available on i.MX9 (2025-12-29 10:17:01 -0300)

u-boot-imx-next-20251229
------------------------

CI: https://source.denx.de/u-boot/custodians/u-boot-imx/-/pipelines/28866

- Swicth imx8ulp-evk to standard boot and OF_UPSTREAM.
- Cleanup of the IPUv3 video driver.
- Add support for the NXP FRDM-IMX91 board.
- Make flash.bin target available on i.MX9
- Fix mxsfb pixel clock polarity .
----------------------------------------------------------------
Alice Guo (3):
      imx8ulp_evk: Convert to standard boot
      imx8ulp_evk: Move environment variables to .env file
      imx8ulp_evk: Switch to use devicetree imported from Linux kernel release

Brian Ruley (7):
      video: imx: ipuv3: remove undefined function declarations
      video: imx: ipuv3: apply clang-format
      video: imx: ipuv3: prefer kernel types
      video: imx: ipuv3: fix camel cases
      video: imx: ipuv3: add names to clk function identifiers
      video: imx: ipuv3: use CONFIG_IS_ENABLED
      video: imx: ipuv3: refactor to use dm-managed state

Joseph Guo (2):
      arm64: dts: add NXP FRDM-IMX91 device tree
      imx: Support i.MX91 11x11 FRDM board

Marek Vasut (1):
      Makefile: Make flash.bin target available on i.MX9

Sam Meredith (1):
      video: mxsfb: fix pixel clock polarity

 Makefile                                           |    9 +-
 arch/arm/dts/Makefile                              |    3 -
 arch/arm/dts/imx8ulp-evk-u-boot.dtsi               |    8 +
 arch/arm/dts/imx8ulp-evk.dts                       |  125 --
 arch/arm/dts/imx8ulp.dtsi                          |  476 -----
 arch/arm/dts/imx91-11x11-frdm-u-boot.dtsi          |   34 +
 arch/arm/dts/imx91-11x11-frdm.dts                  |  773 ++++++++
 arch/arm/mach-imx/Makefile                         |    3 +
 arch/arm/mach-imx/cpu.c                            |   10 +-
 arch/arm/mach-imx/imx8ulp/Kconfig                  |    1 +
 arch/arm/mach-imx/imx9/Kconfig                     |    9 +
 board/freescale/imx8ulp_evk/imx8ulp_evk.env        |   97 +
 board/freescale/imx91_frdm/Kconfig                 |   12 +
 board/freescale/imx91_frdm/MAINTAINERS             |    7 +
 board/freescale/imx91_frdm/Makefile                |   16 +
 board/freescale/imx91_frdm/imx91_frdm.c            |   84 +
 board/freescale/imx91_frdm/imx91_frdm.env          |   89 +
 .../imx91_frdm/lpddr4_2400mts_1gb_timing.c         | 1996 ++++++++++++++++++++
 .../imx91_frdm/lpddr4_2400mts_2gb_timing.c         | 1996 ++++++++++++++++++++
 .../imx91_frdm/lpddr4_2400mts_ecc_1gb_timing.c     | 1996 ++++++++++++++++++++
 .../imx91_frdm/lpddr4_2400mts_ecc_2gb_timing.c     | 1996 ++++++++++++++++++++
 board/freescale/imx91_frdm/lpddr4_timing.h         |   12 +
 board/freescale/imx91_frdm/spl.c                   |  193 ++
 configs/imx8ulp_evk_defconfig                      |    8 +-
 configs/imx91_11x11_frdm_defconfig                 |  138 ++
 configs/imx91_11x11_frdm_inline_ecc_defconfig      |    3 +
 doc/board/nxp/imx91_11x11_frdm.rst                 |  100 +
 doc/board/nxp/index.rst                            |    1 +
 drivers/video/imx/ipu.h                            |  222 ++-
 drivers/video/imx/ipu_common.c                     |  841 +++++----
 drivers/video/imx/ipu_disp.c                       |  752 ++++----
 drivers/video/imx/ipu_regs.h                       |  270 ++-
 drivers/video/imx/mxc_ipuv3_fb.c                   |  277 ++-
 drivers/video/mxsfb.c                              |    2 +-
 include/configs/imx8ulp_evk.h                      |   24 -
 include/configs/imx91_frdm.h                       |   25 +
 include/ipu_pixfmt.h                               |    3 +-
 37 files changed, 10800 insertions(+), 1811 deletions(-)
 delete mode 100644 arch/arm/dts/imx8ulp-evk.dts
 delete mode 100644 arch/arm/dts/imx8ulp.dtsi
 create mode 100644 arch/arm/dts/imx91-11x11-frdm-u-boot.dtsi
 create mode 100644 arch/arm/dts/imx91-11x11-frdm.dts
 create mode 100644 board/freescale/imx8ulp_evk/imx8ulp_evk.env
 create mode 100644 board/freescale/imx91_frdm/Kconfig
 create mode 100644 board/freescale/imx91_frdm/MAINTAINERS
 create mode 100644 board/freescale/imx91_frdm/Makefile
 create mode 100644 board/freescale/imx91_frdm/imx91_frdm.c
 create mode 100644 board/freescale/imx91_frdm/imx91_frdm.env
 create mode 100644 board/freescale/imx91_frdm/lpddr4_2400mts_1gb_timing.c
 create mode 100644 board/freescale/imx91_frdm/lpddr4_2400mts_2gb_timing.c
 create mode 100644 board/freescale/imx91_frdm/lpddr4_2400mts_ecc_1gb_timing.c
 create mode 100644 board/freescale/imx91_frdm/lpddr4_2400mts_ecc_2gb_timing.c
 create mode 100644 board/freescale/imx91_frdm/lpddr4_timing.h
 create mode 100644 board/freescale/imx91_frdm/spl.c
 create mode 100644 configs/imx91_11x11_frdm_defconfig
 create mode 100644 configs/imx91_11x11_frdm_inline_ecc_defconfig
 create mode 100644 doc/board/nxp/imx91_11x11_frdm.rst
 create mode 100644 include/configs/imx91_frdm.h
