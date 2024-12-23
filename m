Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F308E7718B
	for <u-boot@archiver.kernel.org>; Mon, 23 Dec 2024 13:16:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EF8C480655;
	Mon, 23 Dec 2024 14:16:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="l02LeJL5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 77FB9806FB; Mon, 23 Dec 2024 14:16:40 +0100 (CET)
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com
 [IPv6:2607:f8b0:4864:20::52d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D37108062B
 for <u-boot@lists.denx.de>; Mon, 23 Dec 2024 14:16:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pg1-x52d.google.com with SMTP id
 41be03b00d2f7-7fbbe0fb0b8so2626956a12.0
 for <u-boot@lists.denx.de>; Mon, 23 Dec 2024 05:16:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1734959796; x=1735564596; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=G/xiTL3IX7ThrBxQl0EC3HDji+Vpcki6PvBVhkfHN0I=;
 b=l02LeJL5ORLSufPFu7Bu5rM+lL1/gbe0eZBBVQVC6R+yxrun+zGRlXCKejU4+oy46V
 2nRctOK20Pch8D8wh9Hl/BdvyzEQIgpTthEn8o1Zv9kFQayC6kJhhOlBjozLGCVqv//u
 4MEvhi8Y/qe2XJsny6L1RG98ERai3J3wSh3bLcCc3LOBpc0AvCMNpWg+XbreJHiFORpZ
 XiCgx/4A++rtoeueKmhWgg6RJV/t/C3nHLUPI3nOhF//Vpt+qJgc70uc7pTcP2CwMVz1
 wXzqHRYC5i/5gxTEMDG3mCTflM0a8FPZAJKnYpJXxM8/dKA73gUrLX6fisHkGSTGyWB8
 CD+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734959796; x=1735564596;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=G/xiTL3IX7ThrBxQl0EC3HDji+Vpcki6PvBVhkfHN0I=;
 b=CDpSvytEfKGNn4gkycr6/H0oNq1rxBNPMyNh/acPdogRbLAf1+OUmayeaMr4G8EGdt
 772jtEf0sB1NE9DZs+ekFuF9JTvs42mT+OeVRJNN9p/Az0WZEzkIOizzFwI5IzfSW312
 ihkS1bWbe87d0m9duydJri/z2qFaqa7JqDM23MNTgpFPD8i6sCXRpLY/6wTgjhSZAtM5
 TAT2X3Jtpbbw01o4seoQ8xDQALC9n3sCsC82fK7Wob/ppdJMlC+ID+mMUU1fF55+Cy/n
 olN1BEHBUWILdHohTmZk1qXjmfb35XfnA6Uvphr0yyYJTJmw7uUuDLttT4WxDfb5fmb2
 +YPQ==
X-Gm-Message-State: AOJu0Yzd9YrfxTHFqyCwjhjMUYN14LXmOHJ5Uavs5P/ch5Z/0SHAkFJ7
 pu0mASjhg+9xjpoZ83N2OoebZQ7jSdbCwgOjwPMz5iKOcoYQp71R
X-Gm-Gg: ASbGnctvYmZAZHdaq+GTvBU26CB6RnWuRBWFcbZsKAsLIwgjzcxH0FUFtiiwIUo5EuU
 dX/D3yB3YKLuhM2WP+3QogWBYSZ2ZOcQYb8j9GkQ5GRLOsojayhq3cFkpJMLVXYimuRJygTZOJE
 zA2N1coP6zinbEwxR3knejsiuNh084WYzARX+17yFBpzO4zPi23laBrYHLVoxcXuURM+KwjguIY
 qKNVdIMeP8rKb3NiTulvmXzbEvVBq2iGYW851TMTsd8iRG90OOCLbgZmLr/KHC9LG2omg==
X-Google-Smtp-Source: AGHT+IHQDZHmOXb+Ak0pEZbz1WH8l/WAHzVxqB1uJfKF0fQjZr5VSVeJHyECrszeBc6xxykQNGwsog==
X-Received: by 2002:a17:90a:c2c7:b0:2ef:19d0:2261 with SMTP id
 98e67ed59e1d1-2f452e1c111mr20536864a91.16.1734959796124; 
 Mon, 23 Dec 2024 05:16:36 -0800 (PST)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:81e:be66:fdf1:bf79])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-219dc9cde5bsm73148585ad.116.2024.12.23.05.16.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Dec 2024 05:16:35 -0800 (PST)
From: Fabio Estevam <festevam@gmail.com>
To: trini@konsulko.com
Cc: u-boot@lists.denx.de
Subject: [GIT PULL] Please pull u-boot-imx-next-20241223
Date: Mon, 23 Dec 2024 10:16:32 -0300
Message-Id: <20241223131632.1507487-1-festevam@gmail.com>
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

The following changes since commit 5947cd76acdd65f48f0748af01241cb6c0756fba:

  Merge branch '2024-12-21-add-arm64-CI-host-support' into next (2024-12-21 12:27:55 -0600)

are available in the Git repository at:

  https://gitlab.denx.de/u-boot/custodians/u-boot-imx.git tags/u-boot-imx-next-20241223

for you to fetch changes up to 6016960ceb9d3fda591cda94df3841748fb65596:

  imx: Use per board ddrphy_trained_csr (2024-12-23 08:10:15 -0300)

u-boot-imx-next-20241223
------------------------

CI: https://source.denx.de/u-boot/custodians/u-boot-imx/-/pipelines/23987

- imx8m: Remove global ddrphy_trained_csr as it is a per board configuration.
- Add DM_FLAG_ACTIVE_DMA flag for FEC network driver to avoid potential
kernel crash.
- Miscellaneous improvements for i.MX8M Venice Gateworks platforms.
----------------------------------------------------------------
Meng Li (1):
      net: fec_mxc: add DM_FLAG_ACTIVE_DMA flag for FEC network driver

Peng Fan (1):
      imx: Use per board ddrphy_trained_csr

Tim Harvey (5):
      spi: mxc_spi: use proper clock for SPI bus
      drivers: misc: gsc: add support for fan controller
      drivers: misc: gsc: add support for prescaled
      imx8m*-venice: define suitable address for SPL_LOAD_FIT_ADDRESS
      arm: dts: imx8mp-venice-gw7*xx: fix TPM reset

 arch/arm/dts/imx8mp-venice-gw71xx-2x-u-boot.dtsi |  16 +-
 arch/arm/dts/imx8mp-venice-gw72xx-2x-u-boot.dtsi |  16 +-
 arch/arm/dts/imx8mp-venice-gw73xx-2x-u-boot.dtsi |  16 +-
 arch/arm/include/asm/arch-imx8m/ddr.h            |   3 -
 arch/arm/include/asm/arch-imx9/ddr.h             |   3 -
 configs/imx8mm_venice_defconfig                  |   1 +
 configs/imx8mn_venice_defconfig                  |   1 +
 configs/imx8mp_venice_defconfig                  |   1 +
 drivers/ddr/imx/phy/Makefile                     |   2 +-
 drivers/ddr/imx/phy/ddrphy_csr.c                 | 732 -----------------------
 drivers/ddr/imx/phy/ddrphy_train.c               |   3 +-
 drivers/ddr/imx/phy/helper.c                     |   8 +-
 drivers/misc/gsc.c                               |   4 +
 drivers/net/fec_mxc.c                            |   1 +
 drivers/spi/mxc_spi.c                            |  14 +-
 15 files changed, 46 insertions(+), 775 deletions(-)
 delete mode 100644 drivers/ddr/imx/phy/ddrphy_csr.c
