Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A090AC43458
	for <u-boot@archiver.kernel.org>; Sun,  5 Jul 2026 13:07:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0575C847C8;
	Sun,  5 Jul 2026 15:07:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=riscstar.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b="ClHwMBLh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DA8F384832; Sun,  5 Jul 2026 15:07:01 +0200 (CEST)
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com
 [IPv6:2607:f8b0:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 35008846F8
 for <u-boot@lists.denx.de>; Sun,  5 Jul 2026 15:06:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=riscstar.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=eric.chung@riscstar.com
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-2c9bd2f8bf7so30923135ad.1
 for <u-boot@lists.denx.de>; Sun, 05 Jul 2026 06:06:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1783256818; x=1783861618;
 darn=lists.denx.de; 
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=piralszM/zQEb8KPM1OWz5NeJqmpIJM7aB8B8reuk8g=;
 b=ClHwMBLhihz7a2Ca1guTk0opeXhcAis/xo/TwpMJJhEJ0xktPc3qiBosc27zJ+ikAd
 bekpxWDvYAVFl7P6ocJvx/XoCrrRPw4SOLYhWzPd1X3f9TGEBYlsRqzSmOoC1Cyh7upX
 wQvshVip/GORMG8sLJJGzMkPxzUtGuHQtbjruRxCAWhc3wDI8hnISmNPdf5qBJJa1iAK
 rEsYO2r8FHkAn0usK7yIHzmHjJDoXQbVSOnVpfxR2eaqNIDwFmnO75pQ1iIAefR+bDcA
 ieAtAR82U8maoybtxOPmcVSk9K5mIcHiLwrNCi/hY5gr+5SCQ8joKzAYUUxfvlLe8Qyw
 gT/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783256818; x=1783861618;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=piralszM/zQEb8KPM1OWz5NeJqmpIJM7aB8B8reuk8g=;
 b=LCek884JjSlIocwB/4q0TtKPDqorRC7R6VgV7E0ChFHCrwdC4F6J9kk52L6IsqneoU
 F0v+8guWwJKNxlY/UjzynEKRFlLltKk7Mw3h9Nkv8+lNJrv3YeSVWB8YKJOWtnWVKI92
 pHTPe9jpWT8souRU7wuyRKf1x5zdqOP0KGcIgJVtWnkTXFngkZ6bUuP906+y8z5juODc
 89ZUySMAICE5Syba77cLg5vcgD7wNRaPeTqNaSiis6bvreXyHZ3HQCA9k1pkkWmi4dwK
 rRJTqRE02EprEEnU9XvLqcSUFSFpUMmxDmeXae1LhhbQKiH6+1t/dlsvVeud+3p0UOEr
 GZoQ==
X-Gm-Message-State: AOJu0YxoUNHz5I38jAkZvWZs9MpjwFTWDyb1Rn3DDb/XQHwzdIh3XJrf
 lCld1tP/BQFMSwX/QwXhTV4lyrkLRgSlsTDVCa/jJobJMnTztBfea+WU697bClqPtrE=
X-Gm-Gg: AfdE7cmpnKxrqormsFbh3TBGRBwFgOdnx3hBPW0egvHx3QJ14jalpeolWRgL4mr/1A3
 /6vADNXKTBch2NFg7nOC0ryz1kffbCb779TQr3sSGNJJfKZZOdRQkyZS27PG7t6tMWSh2n4JbUP
 JjpImiDVBBXT9q6ZRrUJUqhjw26UABQ0Q6Hcp6XVAlnqkFRiUWdWJX1axPWkD70a94QyNzc8xc1
 9uAKFce4yuGZ2kWQuQ1S5tTR29aepAQ5RYbixUpTXQaQeV4taCiXN8XQRPG1OfKdCH6oz9u/a7R
 29HdYKnSjFzROVRSZuU17vCR9QQEZgL1xGH2rP47K0d3arAoBqV9OOKW8hyssoRTqABy1vnXBiq
 hy++lcSPZ9JID2qVeHj5cOVedf5ZUY1+rq4iAdZhpI0duqoCkpk477SC+xrjk8/qwqDCl5KRUGC
 va2xqkvTMzPuM6tRqpwJRZP5DdSXoQt1lwPpAoJzSmD1D7nZK2VvD6WRj2dy2j62vZahOr+clv3
 Skc1XTMc+fDEzwN83Hier8+A5mFww1KTtl2LRtR8QIyP5ZL7Trm
X-Received: by 2002:a17:902:e5c2:b0:2ca:2390:ff13 with SMTP id
 d9443c01a7336-2cbea1a28bfmr56640445ad.5.1783256817656; 
 Sun, 05 Jul 2026 06:06:57 -0700 (PDT)
Received: from [127.0.1.1] ([120.204.57.249]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2cad71458f6sm34272305ad.32.2026.07.05.06.06.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Jul 2026 06:06:57 -0700 (PDT)
From: Eric Chung <eric.chung@riscstar.com>
Subject: [PATCH 0/3] pci: enable designware pci and phy on spacemit k1 SoC
Date: Sun, 05 Jul 2026 21:06:26 +0800
Message-Id: <20260705-pci-v1-0-beca83440a27@riscstar.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANJWSmoC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDcwNT3YLkTF1jC2NTiyRTc4MUA2MloMqCotS0zAqwKdGxEH5xaVJWanI
 JSKtSbS0Awx2ls2cAAAA=
X-Change-ID: 20260705-pci-38358b570d03
To: u-boot@lists.denx.de, u-boot-spacemit@groups.io
Cc: Tom Rini <trini@konsulko.com>, Tim Ouyang <tim609@andestech.com>, 
 Leo Liang <leo.liang@sifive.com>, Minkyu Kang <mk7.kang@samsung.com>, 
 David Lechner <dlechner@baylibre.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Alice Guo <alice.guo@nxp.com>, 
 Michael Trimarchi <michael@amarulasolutions.com>, 
 Sam Protsenko <semen.protsenko@linaro.org>, 
 Johan Jonker <jbx6244@gmail.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 Tim Harvey <tharvey@gateworks.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 "Lucien.Jheng" <lucienzx159@gmail.com>, Michal Simek <michal.simek@amd.com>, 
 Pranav Sanwal <pranav.sanwal@amd.com>, Ye Li <ye.li@nxp.com>, 
 Huan Zhou <pericycle.cc@gmail.com>, Guodong Xu <guodong.xu@riscstar.com>, 
 Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>, 
 Raymond Mao <raymond.mao@riscstar.com>, Peng Fan <peng.fan@nxp.com>, 
 Eric Chung <eric.chung@riscstar.com>
X-Mailer: b4 0.15.2
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

This series sits on top of three series still under review, and must be
applied after them, in this order:

  1. K1 clock/reset/dts migration [1]    (8 patches)
  2. K1 SPL bring-up v4 [2]              (14 patches)
  3. K1 pinctrl/GPIO and SPI NOR v2 [3]   (9 patches)
  4. K1 MMC v3 [4]                        (9 patches)
  Then this series                        (3 patches)

For each series:

  b4 am <cover-msgid>
  git am ./*.mbx

Link: https://lore.kernel.org/u-boot/20260526-b4-k1-clk-reset-upstream-dts-v2-0-af815e362b0c@riscstar.com/ [1]
Link: https://lore.kernel.org/u-boot/20260630-m1-v1-0-83f13347b3ba@riscstar.com/T/#m2aba875a2696a7bb9b704618d22ae2fd7f7f5acc [2]
Link: https://lore.kernel.org/u-boot/20260520-b4-k1-spl-pinctrl-spinor-v2-0-8d25db98ac8e@riscstar.com/ [3]
Link: https://lore.kernel.org/u-boot/20260705-m4-v3-0-5a9bc7f25fc5@riscstar.com/T/#t [4]

Signed-off-by: Eric Chung <eric.chung@riscstar.com>
---
Eric Chung (3):
      phy: spacemit: add K1 PCIe/USB3 combo PHY driver
      pci: spacemit: add DesignWare PCIe host controller driver
      dts: spacemit: add PCIe nodes and enable in defconfig

 arch/riscv/dts/k1-bananapi-f3-u-boot.dtsi | 151 +++++++++
 arch/riscv/dts/k1-musepi-pro-u-boot.dtsi  | 153 ++++++++++
 configs/spacemit_k1_defconfig             |   8 +
 drivers/pci/Kconfig                       |   7 +
 drivers/pci/Makefile                      |   1 +
 drivers/pci/pcie_dw_spacemit.c            | 383 +++++++++++++++++++++++
 drivers/pci/pcie_dw_spacemit.h            |  78 +++++
 drivers/phy/Kconfig                       |   1 +
 drivers/phy/Makefile                      |   1 +
 drivers/phy/spacemit/Kconfig              |  11 +
 drivers/phy/spacemit/Makefile             |   1 +
 drivers/phy/spacemit/phy-k1-pcie.c        | 492 ++++++++++++++++++++++++++++++
 12 files changed, 1287 insertions(+)
---
base-commit: 96e0c567aa6e85595b98dcf52d649c838f3d6ba3
change-id: 20260705-pci-38358b570d03

Best regards,
--  
Eric Chung <eric.chung@riscstar.com>

