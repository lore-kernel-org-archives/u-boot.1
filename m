Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0879C3ABCB
	for <u-boot@archiver.kernel.org>; Mon, 12 May 2025 21:49:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0ABFD80C83;
	Mon, 12 May 2025 23:49:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="RBNYIQfs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9F0E482162; Mon, 12 May 2025 23:49:35 +0200 (CEST)
Received: from mail-vk1-xa35.google.com (mail-vk1-xa35.google.com
 [IPv6:2607:f8b0:4864:20::a35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 43EB080584
 for <u-boot@lists.denx.de>; Mon, 12 May 2025 23:49:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-vk1-xa35.google.com with SMTP id
 71dfb90a1353d-52c6f67c6c5so687767e0c.2
 for <u-boot@lists.denx.de>; Mon, 12 May 2025 14:49:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1747086572; x=1747691372; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Ggx/wW3H0Da60JN4C1oletGt1e26W6Kj649xm35qPpY=;
 b=RBNYIQfssVacFriBQOIMSRl/dFgWD2/T7GfjcoLdpHxa81DUvm7kOzT0CcKW2CgtqU
 gD3cK7vtxXDnXMTSfuZeDAPEdmLFnFwVPJ4n3x0hpZT9A9IbzbyKPoWQGXaZerMLBUz6
 2YfIXOL/30mQueYb3LERpuYfIqrrlxxAX2mpsAOdzpeUrHtvrK1Bh0puqSZFDQRN8guW
 0jmZ2fcAzNjX5pDARxMKopcP6uuOD4+H1ab035J/o3+YcoRLhzbxDP9U1xL7vHj/301Q
 zyhl6n7S1JUgSHSWPkj2a7asXEwtwerodjJ1/OaCFF3xHUNMos2loudYrEOWA0KeTcQb
 7SbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747086572; x=1747691372;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Ggx/wW3H0Da60JN4C1oletGt1e26W6Kj649xm35qPpY=;
 b=X+7j5qDcGEz9M2foniSEkZqws4K3TwJwvmFCGxyjPXHOcrlE93gGyNHT/MZc62SyjG
 amkxoGKRfkLxthLuKHKCvFWxjHFFp9CCOTegQq9ja5nnYVGnBHAeWe6owtzCam5Md10f
 Nn9CCDT2c85EHrSYB3noKkEGvcG4MQauW5GSW2N78bZDg+ZyrmJ4lhCzun/uEMl5ro7n
 /NikJrfyj6jETAdjjRongjFul3N034LUlBZy+ICg0ebtoodku9ljWo0UVrhd98fS2utL
 bzvJplTTk1P2A8KQrdCKGUiJkjlVPsCaqSaqUuGKjIai+gcGmTXttqOIrnwtzeMnXYnB
 Hmew==
X-Gm-Message-State: AOJu0YxbFugk7l+UwhOg4ZtZIoT62/pGh4YRGfbm7Pbi9IZ0v/uypZPk
 DFC9gLhFMx9IFj3N5zcN+E/3abIZRmXIBOzUNZHshHrm3LuXfiWp
X-Gm-Gg: ASbGnctjLgIdDYwiMkq4P7hd//1Yx1oBvi9CIOeb8zwJldJFoRnTLvkMBRV5/awSQaq
 tVxR5RFOaVBDNcGutaLZOz1y1N3y75yqpSLIAUN3vW3lPJWEnrsf1Q7THEakBUIp3yyCBbiUCHA
 YwlfrHiTYHc5q4wk5sk7xuW5nrWlsJ9FlG6dTy3npcHnpCaZW0e5zJZfhrYn4VJQNRnLb07LDwS
 vluwHJoRBIA10pqLmfWOqkeX5Nwbtsw4pw+oQ7YvJxjSDSqHbD+fDQ0D+ZTxnv1twtF9Qa86hzR
 l+TQWta9s7n4gdIx/555K54p5K5dXjTDfV0YpyhsEv7J5K5qUxmR4UGUW+w1kDrO2Q==
X-Google-Smtp-Source: AGHT+IEPdJQoyXEgShaefecCT/jMU8diCM72Bv9dgc8Fkgo2ke6XhLg1kiuj+osZaT1X42DbtzN+IQ==
X-Received: by 2002:a05:6122:17aa:b0:52b:789:2d0 with SMTP id
 71dfb90a1353d-52c53b8963amr10909071e0c.5.1747086572021; 
 Mon, 12 May 2025 14:49:32 -0700 (PDT)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:72fa:8f88:cd0e:432f])
 by smtp.gmail.com with ESMTPSA id
 71dfb90a1353d-52c63b717c5sm4723636e0c.9.2025.05.12.14.49.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 May 2025 14:49:31 -0700 (PDT)
From: Fabio Estevam <festevam@gmail.com>
To: trini@konsulko.com
Cc: u-boot@lists.denx.de
Subject: [GIT PULL] Please pull u-boot-imx-master-20250512
Date: Mon, 12 May 2025 18:49:27 -0300
Message-Id: <20250512214927.3839357-1-festevam@gmail.com>
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

The following changes since commit cf37480bc8335494cf88b7180dc3f1eb8cf63a9d:

  Prepare v2025.07-rc2 (2025-05-12 14:33:38 -0600)

are available in the Git repository at:

  https://gitlab.denx.de/u-boot/custodians/u-boot-imx.git tags/u-boot-imx-master-20250512

for you to fetch changes up to b3525ecd4908b6c7cdf2c9e4cd028c8d80d3d958:

  imx95_evk: enable PCI early (2025-05-12 18:43:34 -0300)

u-boot-imx-master-20250512
--------------------------

CI: https://source.denx.de/u-boot/custodians/u-boot-imx/-/pipelines/26116

- Add imxrt1170 support to the fspi SPI driver.
- Enable PCI early on imx95_evk.
- Fix fsl_enetc imdio register calculation.
----------------------------------------------------------------
Jonathan Currier (5):
      spi: fspi: involve lut_num for struct nxp_fspi_devtype_data
      spi: fspi: Add imxrt1170 device data
      ARM: dts: imx: Add flexspi (fspi) to imxrt1170 and it's evk.
      spi: fspi: dev_dbg() call assumes fdt_addr_t always a long long
      configs: imxrt1170-evk_defconfig: include FlexSPI driver and flash chip support

Thomas Schaefer (1):
      net: fsl_enetc: fix imdio register calculation

Tim Harvey (1):
      imx95_evk: enable PCI early

 arch/arm/dts/imxrt1170-evk.dts              | 28 +++++++++++++++
 arch/arm/dts/imxrt1170.dtsi                 | 13 +++++++
 configs/imx95_19x19_evk_defconfig           |  1 +
 configs/imxrt1170-evk_defconfig             | 15 ++++++++
 drivers/clk/imx/clk-imxrt1170.c             |  9 +++++
 drivers/net/fsl_enetc.c                     |  4 ++-
 drivers/spi/nxp_fspi.c                      | 55 ++++++++++++++++++-----------
 include/dt-bindings/clock/imxrt1170-clock.h |  4 ++-
 8 files changed, 107 insertions(+), 22 deletions(-)
