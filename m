Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3747C4345F
	for <u-boot@archiver.kernel.org>; Sat, 20 Apr 2024 18:33:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B284C8878B;
	Sat, 20 Apr 2024 20:33:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="LWdbEKC0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8DD2A88790; Sat, 20 Apr 2024 20:33:30 +0200 (CEST)
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com
 [IPv6:2607:f8b0:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 12E058878B
 for <u-boot@lists.denx.de>; Sat, 20 Apr 2024 20:33:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-1e825c6c110so5554045ad.2
 for <u-boot@lists.denx.de>; Sat, 20 Apr 2024 11:33:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1713638006; x=1714242806; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Rh0IqvVh2VbTl/g+mSi3tP3ukN9QfcnC/gUdnl39Iak=;
 b=LWdbEKC0FUwzmws2Nv1ts2NT1Gj4NvKey0lNrexya2HnFvP6Nomh2cmVlALsYrxetb
 NY6YsdqhRy59WWEogWdE+zda+gUYuRQhOCxIi2aTPsHOG0QHCcLxz6yC4EGpz4SvH3CJ
 EAsyZI8EIXfwZL5HF4uAoMrEseS1Y4+lKkJByRvreN7BWjvRUL2i0jMEfFSd7txGqh8q
 5OgEyORs0Zix5xMYKuNb0bQY8cAFF/2NJxxnjA22dAWhEgVaIHS7vS+3XXLGf9Z0BUOH
 2OtOF2YX/6k+JpmDoeLlTnFDGXDXARcq9Pohi/F7qTtczyon1osXobMZz9xHGKlX5V8J
 x3RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713638006; x=1714242806;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Rh0IqvVh2VbTl/g+mSi3tP3ukN9QfcnC/gUdnl39Iak=;
 b=ap+fdQdlxdcTw/zmo9qPhGNvX8uZ+iUWkamm0v50Ay8rYHE/wwxZ2A6h+td1OA+wVQ
 vHi6TfQxbVRqelznFtD41IbqqUTiZXGpkejTffeWwjGBWw+NN6b2Hi/vdTBL88YVX3Dy
 RRfFSSRuWVzlQGdYGM1/ykOg3EFoJU/VsrGQy1MQEwOmTKqcQ5m9uysmd08lg14jpbLD
 8zUN04t6X+XHrv097apI7IHtWowMZpCx2PHHW+B1IPQry5vomPgARh65nq2ua+BL+rUV
 Uir9RGvbL7vyNsWssQLJ0eLnCVArROBLKYlbTUtMNBtBEfgHzPnif71T0KPftK0mM+/r
 fZ/g==
X-Gm-Message-State: AOJu0Yz6KO4ncqEqAdfbhmjSNFYBsE7OsKqTCON8xe6IaFuNRFeT9kBZ
 wW7vfVGsGXgQApo4NxfFU0kXPkx5RykxHwt5LZy/Klr0jp7S0YJdMvC/Zg==
X-Google-Smtp-Source: AGHT+IGUgo77o0jS773pffWYI7GaRI7oYBMWA54mE5yUPTvYrmZH90N1ka1DEfUQ4QV2CtM4n72+EA==
X-Received: by 2002:a17:90b:286:b0:2a6:d054:3214 with SMTP id
 az6-20020a17090b028600b002a6d0543214mr5555190pjb.0.1713638006403; 
 Sat, 20 Apr 2024 11:33:26 -0700 (PDT)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:6998:dfc1:c27d:ad17])
 by smtp.gmail.com with ESMTPSA id
 gf13-20020a17090ac7cd00b0029fbfb620cdsm4997350pjb.28.2024.04.20.11.33.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 20 Apr 2024 11:33:25 -0700 (PDT)
From: Fabio Estevam <festevam@gmail.com>
To: trini@konsulko.com
Cc: u-boot@lists.denx.de
Subject: [GIT PULL] Please pull u-boot-imx-master-20240420
Date: Sat, 20 Apr 2024 15:33:22 -0300
Message-Id: <20240420183322.1041895-1-festevam@gmail.com>
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

Please pull from u-boot-imx/master, thanks.

The following changes since commit af04f37a78c7e61597fb9ed6db2c8f8d7f8b0f92:

  Merge tag 'u-boot-stm32-20240419' of https://source.denx.de/u-boot/custodians/u-boot-stm (2024-04-19 14:25:04 -0600)

are available in the Git repository at:

  https://gitlab.denx.de/u-boot/custodians/u-boot-imx.git tags/u-boot-imx-master-20240420

for you to fetch changes up to 8b8c699d88171b0d40f072e114f32cce93cb2987:

  imx8mm_venice_defconfig: Enable PCIe/NVMe support (2024-04-20 00:37:51 -0300)

u-boot-imx-master-20240420
--------------------------

CI: https://source.denx.de/u-boot/custodians/u-boot-imx/-/pipelines/20444

- Make i.MX93 boot less verbose.
- Remove unneedd environment variables from Toradex i.MX boards.
- Use gpio-hog on verdin-imx8mm/imx8mp.
- Add PCIe support for i.MX8MM.
- Add TPM support for imx8m*-venice.
----------------------------------------------------------------
Fabio Estevam (1):
      imx93: Move SoC and lifeclycle information to debug level

Francesco Dolcini (1):
      board: toradex: imx: Remove not needed env variables

Stefan Eichenberger (1):
      arm: dts: verdin-imx8mm/imx8mp: use gpio-hog for sleep moci

Tim Harvey (6):
      imx8m*-venice: enable TPM support
      board: gateworks: venice: fix dt adjustment for gw73xx baseboard for imx8mp
      imx8m*_venice_defconfig: enable ipv6, wget and tftpput
      clk: imx8mm: Add support for PCIe clocks
      pci: dw_imx: add support for IMX8MM
      imx8mm_venice_defconfig: Enable PCIe/NVMe support

 arch/arm/dts/imx8mm-verdin-wifi-dev-u-boot.dtsi |  5 +++++
 arch/arm/dts/imx8mp-verdin-wifi-dev-u-boot.dtsi |  4 ++++
 board/freescale/imx93_evk/spl.c                 |  4 ++--
 board/gateworks/venice/venice.c                 |  7 ++++---
 board/phytec/phycore_imx93/spl.c                |  4 ++--
 board/variscite/imx93_var_som/spl.c             |  4 ++--
 configs/imx8mm_venice_defconfig                 | 21 +++++++++++++++++++
 configs/imx8mn_venice_defconfig                 | 15 ++++++++++++++
 configs/imx8mp_venice_defconfig                 | 15 ++++++++++++++
 drivers/clk/imx/clk-imx8mm.c                    | 27 +++++++++++++++++++++++++
 drivers/pci/pcie_dw_imx.c                       | 18 +++++++++++++++--
 include/configs/apalis-imx8.h                   |  2 --
 include/configs/apalis_imx6.h                   |  9 +--------
 include/configs/colibri-imx6ull.h               | 10 +++------
 include/configs/colibri-imx8x.h                 |  2 --
 include/configs/colibri_imx6.h                  |  9 +--------
 include/configs/colibri_imx7.h                  | 11 +++-------
 include/configs/verdin-imx8mm.h                 |  3 ---
 include/configs/verdin-imx8mp.h                 |  5 -----
 19 files changed, 121 insertions(+), 54 deletions(-)
