Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CFCBD7494E
	for <u-boot@archiver.kernel.org>; Wed, 30 Oct 2024 00:08:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 01FB8891AC;
	Wed, 30 Oct 2024 01:08:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="IQAcs9dH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2A224891AF; Wed, 30 Oct 2024 01:08:50 +0100 (CET)
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com
 [IPv6:2607:f8b0:4864:20::102c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DB228891A0
 for <u-boot@lists.denx.de>; Wed, 30 Oct 2024 01:08:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-2e2dc61bc41so4382919a91.1
 for <u-boot@lists.denx.de>; Tue, 29 Oct 2024 17:08:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1730246925; x=1730851725; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=mOnZtDYhLGrL1mrVIY6T//aItRq33UYumLLLv4jpFp0=;
 b=IQAcs9dHyxpGaI4kCHXXtdeTK8weXBGaoO2giH4s6rje+mXJET92F20uZaDIn1R1Z/
 fWvZBc7FMSanTjUuQZt5P9twFwvorh5hjGlhuN2lLQOwY2Ef+73Szi2+P51PdPfvzcBH
 1R0oYCK/zff9Zv+1zQGG2Jff1ZtZpmMFvirb/AEgod56QICA4GSNergn6r0Fsxw1sFLV
 P+tsh4dVyzHeOKYblgHEvq5DRc6afCA4cDYyiE5i7QcC0IBtyy820ipMqJW9VSlWFyRa
 2Fh5CuMx+bkS5tIuVGzgRXH//WDac5mRlXPa3oZ7io7QBgsRH7hXHcVIgyob3/xaZli+
 PAzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730246925; x=1730851725;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=mOnZtDYhLGrL1mrVIY6T//aItRq33UYumLLLv4jpFp0=;
 b=ZlxbE+L/6M3r8uYiX6cUkF1xMJl3173DVWQizX8Xp0VUJOMws2yu13A8TUDVfRZaJB
 gclFL5dZHHV0cyZp1Sg+JUD0+G23XrF1zIUxVUNd7WXV7PCEjmPj7qOLFSFalOreg15K
 b6tKxH6sOhm6bllRQbJ3+8iIJY/1EVav0dBpTL7ma99dVDUClJGGvgHgESTSafN/v9Hr
 JHj209nj1HCXg122vco5oM4yDPbWbZJrY85IXr1/hQR6bfDUVthamo4yzVZevWoEDZ5u
 DT6ECNuVQ6Wegu57Tnsqp/auY6693hfa5KiEbnQsK2a8KE3y/Wz0xExqjXpL9fyVeOks
 W2Pg==
X-Gm-Message-State: AOJu0Yx1qlmpTqxUX5z9ebBkr8ZiM/mTgquX422L+qaVcpnz+zVqDhkO
 F75gc0/DfSXKY2z5Y/7oPg6p1Nj8VL66X+e3Y04J4R3HvmiQnIhlkm6OLA==
X-Google-Smtp-Source: AGHT+IHZck7rtFgtgr+FQBlBEA4AhsjJZNGiezPjCD6EGBMb2RYKS1T3EbyV0ruIP6uJtnUwxdfgHA==
X-Received: by 2002:a17:90b:1c07:b0:2e2:e136:a931 with SMTP id
 98e67ed59e1d1-2e8f0f5062fmr13764880a91.6.1730246925308; 
 Tue, 29 Oct 2024 17:08:45 -0700 (PDT)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:190a:1425:254d:1e7a])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2e92fa89940sm283637a91.40.2024.10.29.17.08.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Oct 2024 17:08:44 -0700 (PDT)
From: Fabio Estevam <festevam@gmail.com>
To: trini@konsulko.com
Cc: u-boot@lists.denx.de
Subject: [GIT PULL] Please pull u-boot-imx-master-20241029
Date: Tue, 29 Oct 2024 21:08:41 -0300
Message-Id: <20241030000841.436660-1-festevam@gmail.com>
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

The following changes since commit dfe9e29f8381213c377bfa1de4d1ba7587c3b1c3:

  Merge https://source.denx.de/u-boot/custodians/u-boot-sh (2024-10-29 10:05:30 -0600)

are available in the Git repository at:

  https://gitlab.denx.de/u-boot/custodians/u-boot-imx.git tags/u-boot-imx-master-20241029

for you to fetch changes up to d88bcd6d247a2b5d1683e393d8c9dc0259cd29f0:

  net: dwc_eth_qos: Remove obsolete imx8 includes (2024-10-29 16:25:53 -0300)

u-boot-imx-master-20241029
--------------------------

CI: https://source.denx.de/u-boot/custodians/u-boot-imx/-/pipelines/23092

- Implement i.MX93 erratum fix on the dwc_eth_qos driver to fix RMII.
- Add support for Emcraft Systems NavQ+.
- Fix the size of IVT + CSF blob tacked on to u-boot.itb.
----------------------------------------------------------------
Erik Schumacher (3):
      net: dwc_eth_qos: Add support for platform specific reset
      net: dwc_eth_qos_imx: Add platform specific reset for i.MX93
      net: dwc_eth_qos: Remove obsolete imx8 includes

Gilles Talis (1):
      board: emcraft: Add support for Emcraft Systems NavQ+

Marek Vasut (1):
      arm64: imx: Fix 0Xnn to 0xnn

Rasmus Villemoes (1):
      imx: hab: fix size of IVT+CSF blob tacked on to u-boot.itb

 arch/arm/dts/imx8mp-navqp-u-boot.dtsi              |  110 ++
 arch/arm/include/asm/arch-imx8m/imx-regs.h         |    2 +-
 arch/arm/mach-imx/imx8m/Kconfig                    |    8 +
 board/emcraft/imx8mp_navqp/Kconfig                 |   15 +
 board/emcraft/imx8mp_navqp/MAINTAINERS             |    8 +
 board/emcraft/imx8mp_navqp/Makefile                |   13 +
 board/emcraft/imx8mp_navqp/imx8mp_navqp.c          |   10 +
 board/emcraft/imx8mp_navqp/imx8mp_navqp.env        |   18 +
 board/emcraft/imx8mp_navqp/imximage-8mp-lpddr4.cfg |    8 +
 board/emcraft/imx8mp_navqp/lpddr4_timing.c         | 1842 ++++++++++++++++++++
 board/emcraft/imx8mp_navqp/spl.c                   |  132 ++
 configs/imx8mp_navqp_defconfig                     |  104 ++
 doc/board/emcraft/imx8mp-navqp.rst                 |   65 +
 doc/board/emcraft/index.rst                        |    9 +
 doc/board/index.rst                                |    1 +
 drivers/net/dwc_eth_qos.c                          |    7 +-
 drivers/net/dwc_eth_qos.h                          |    1 +
 drivers/net/dwc_eth_qos_imx.c                      |   22 +
 include/configs/imx8mp_navqp.h                     |   37 +
 tools/binman/etype/nxp_imx8mcst.py                 |    2 +
 20 files changed, 2409 insertions(+), 5 deletions(-)
 create mode 100644 arch/arm/dts/imx8mp-navqp-u-boot.dtsi
 create mode 100644 board/emcraft/imx8mp_navqp/Kconfig
 create mode 100644 board/emcraft/imx8mp_navqp/MAINTAINERS
 create mode 100644 board/emcraft/imx8mp_navqp/Makefile
 create mode 100644 board/emcraft/imx8mp_navqp/imx8mp_navqp.c
 create mode 100644 board/emcraft/imx8mp_navqp/imx8mp_navqp.env
 create mode 100644 board/emcraft/imx8mp_navqp/imximage-8mp-lpddr4.cfg
 create mode 100644 board/emcraft/imx8mp_navqp/lpddr4_timing.c
 create mode 100644 board/emcraft/imx8mp_navqp/spl.c
 create mode 100644 configs/imx8mp_navqp_defconfig
 create mode 100644 doc/board/emcraft/imx8mp-navqp.rst
 create mode 100644 doc/board/emcraft/index.rst
 create mode 100644 include/configs/imx8mp_navqp.h
