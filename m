Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02F65C87FCF
	for <u-boot@archiver.kernel.org>; Thu,  7 Aug 2025 08:26:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F4077843E2;
	Thu,  7 Aug 2025 10:26:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="b/DE1WX1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E8F9F83AD5; Thu,  7 Aug 2025 09:45:09 +0200 (CEST)
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com
 [IPv6:2607:f8b0:4864:20::52a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5160C83A43
 for <u-boot@lists.denx.de>; Thu,  7 Aug 2025 09:45:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=cn.liweihao@gmail.com
Received: by mail-pg1-x52a.google.com with SMTP id
 41be03b00d2f7-b4209a0d426so642726a12.1
 for <u-boot@lists.denx.de>; Thu, 07 Aug 2025 00:45:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1754552704; x=1755157504; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=5XoqMYmVFxOlnVy5JpNMTKGjGpWYqd4pEU9oTTTUkkc=;
 b=b/DE1WX1hdCMHft40EAogLRcLqiOOrvOXu/7BmlpgFeLd1HYIK8MwU3ZHuwMEtvRzp
 Z5n4B8vX5X+j+XVUaSML1VVmXr07ywWjoml17H12S3TBc4hbi31RW4YNA31TT7LGvgAu
 uHslM7Sxm4SBeszGqrjgzoeOx1ND08+CQoqUpr4OKMwxdGqaZbCdCRlxeddDhsp/pl06
 5bfmexBTssNIlfdqPdJ7I+CkOv3y6N0oEU4Xp38dKYMp4kVFZ55lz9pcdv/UK1iF9YVO
 Z+XPjmdQ9N460gnssHTrWA+yrFEUkJV5jHK7ThYhWo/EJsCL0KViWKGzNHYGBTgqn34j
 Tmcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754552704; x=1755157504;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5XoqMYmVFxOlnVy5JpNMTKGjGpWYqd4pEU9oTTTUkkc=;
 b=luP9gs0Ws4Q/bbII8rukQC+m5PYFzJ2gX6JJkSjHrm/U70fC2imhwyNYG/aHW1c41d
 DipcUpJ1htmcsgL8vGzX+hkO7lQYbd31wqc5VAOscUndp627EKfQV8j1JbZht6YXabM1
 bCarZ5+n9/CQDKrTN4/xz6FmirQs8s4bNeYYk/9IcT6SWH2P91518SDmOrxBv0+v7mKh
 6vfMufMPK/1J7G2SmfeGywG2g+NjMk3Ygsp4JEPFJ8Q61xaxJI34XPLlpUO6N3FUOTiC
 05cAk5pqHFS2DKg2jIh01Dgm2uN//iEgLTSnzl6plNgq/V7+U+aU4SPVfpungHIEDjur
 /wxg==
X-Gm-Message-State: AOJu0YxlyrV1wXb6R+QiTew7kFjhLgjWA/KnsSsqsNIlRwN/TwZEm2Rl
 M8AL76p3BJQwcCrdj5MO3Er5NPA/n/QJQ7OGaknOXtIrTgJ5YetwTei23f3QLKXnQ+U=
X-Gm-Gg: ASbGncvvUO5vR7X3Q6vPTwSxHOitQkoncQgVDZO1ZhunH2gYt/P9JcrL0RiELDlVsgo
 QOEegLh1nFRH/YJ+8u/fHFbFUgGMBsafFKAK0V05lex5veYu9tMvNaF37JJYLLwYc6XIQfMDuzo
 Z9uhUvijXn4IMsTY+qvIUk/Q2ldvGQzvFKiUAgZiac7aCPYz70iw8YfIPm5MILlGjaWhE9dw0fk
 SgW6hDJGx+5INEday5XFJOkiS/UH98hE0wCIRaJ1QzemGZf9gVPitoKLW8XCMhrPNyUwqKmvlgo
 UPK1XiYlab53FKa3ZdIxEclDR05hmTcMk2dOZQ6FOwBOKxhT+Mz1A071UycDjRYMo2Ao1p+ZKIB
 K/6zOlWAuM+bX3l+6hDDNjEVL+hl/eWinneHc
X-Google-Smtp-Source: AGHT+IEMnUdWK+3qkbEwV4gk3OfjkSm6YuEAlvzRwJTC0DLPo74zTgOmw/LwJSH0+9wLcZDVyGuxgw==
X-Received: by 2002:a17:902:fc8f:b0:240:6d9b:59ff with SMTP id
 d9443c01a7336-2429f5339b5mr79328595ad.33.1754552704052; 
 Thu, 07 Aug 2025 00:45:04 -0700 (PDT)
Received: from localhost.localdomain ([218.90.41.167])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-320f4909b8bsm16809202a91.16.2025.08.07.00.44.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Aug 2025 00:45:03 -0700 (PDT)
From: WeiHao Li <cn.liweihao@gmail.com>
To: u-boot@lists.denx.de
Cc: antonio.borneo@foss.st.com, mk7.kang@samsung.com,
 gregkh@linuxfoundation.org, semen.protsenko@linaro.org,
 mikhail.kshevetskiy@iopsys.eu, bb@ti.com, justin.swartz@risingedge.co.za,
 lukasz.czechowski@thaumatec.com, robh@kernel.org, tharvey@gateworks.com,
 clement.legoffic@foss.st.com, marek.vasut@mailbox.org,
 dinesh.maniyam@altera.com, patrice.chotard@foss.st.com, festevam@gmail.com,
 jerome.forissier@linaro.org, quentin.schulz@cherry.de,
 andrew.goodbody@linaro.org, sumit.garg@kernel.org, ag.dev.uboot@gmail.com,
 rfried.dev@gmail.com, joe.hershberger@ni.com, jh80.chung@samsung.com,
 peng.fan@nxp.com, seanga2@gmail.com, lukma@denx.de,
 kever.yang@rock-chips.com, philipp.tomsich@vrull.eu, sjg@chromium.org,
 trini@konsulko.com, WeiHao Li <cn.liweihao@gmail.com>
Subject: [PATCH 00/10] Add RK3368 YMD8_MB board support
Date: Thu,  7 Aug 2025 15:44:08 +0800
Message-Id: <20250807074419.336752-1-cn.liweihao@gmail.com>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 07 Aug 2025 10:26:22 +0200
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

YMD8_MB is an RK3368-based board purchased from Xianyu, a Chinese secondhand
marketplace. It comes with 1GB RAM, 8GB eMMC, and an 8-inch MIPI display.
Detailed information about this board is documented on the following link.

https://ieiao.github.io/wiki/embedded-dev/rockchip/rk3368

This series of patches aims to add missing drivers for the RK3368 and enable
VOP driver support, making U-Boot initially usable on this board.

The VOP driver modifications are based on the following repository.

https://github.com/muratdemirtas/rockchip-rk3399-uboot-mipi-dsi

The original repository for this series of patches can be found at

https://github.com/ieiao/u-boot/tree/ymd8_mb

WeiHao Li (10):
  clk: rockchip: rk3368: fix gmac clock error
  mmc: rockchip: fix clock get wrong index
  net: rockchip: rk3368: add set_to_rmii
  clk: rockchip: rk3368: Add bus clk get/set
  clk: rockchip: rk3368: Adjust pll clk get
  clk: rockchip: rk3368: Add vop clk get/set
  video: rockchip: vop add bridge support
  video: rockchip: add rk3368 vop support
  video: panel: add rm72014 panel support
  board: rockchip: add rk3368 ymd8_mb support

 arch/arm/dts/Makefile                         |   1 +
 arch/arm/dts/rk3368-ymd8-mb-u-boot.dtsi       |  44 +++
 arch/arm/dts/rk3368-ymd8-mb.dts               | 326 +++++++++++++++++
 arch/arm/dts/rk3368.dtsi                      | 258 +++++++++++++
 .../include/asm/arch-rockchip/cru_rk3368.h    |  65 ++++
 .../include/asm/arch-rockchip/grf_rk3368.h    | 111 +++++-
 arch/arm/mach-rockchip/rk3368/Kconfig         |   6 +
 board/rockchip/ymd8_mb/Kconfig                |  12 +
 board/rockchip/ymd8_mb/MAINTAINERS            |   6 +
 board/rockchip/ymd8_mb/Makefile               |   7 +
 board/rockchip/ymd8_mb/README                 |   1 +
 board/rockchip/ymd8_mb/ymd8_mb_rk3368.c       |  19 +
 configs/ymd8-mb_defconfig                     |  72 ++++
 drivers/clk/rockchip/clk_rk3368.c             | 338 +++++++++++++++++-
 drivers/mmc/rockchip_dw_mmc.c                 |   2 +-
 drivers/net/gmac_rockchip.c                   |  17 +
 drivers/video/Kconfig                         |   7 +
 drivers/video/Makefile                        |   1 +
 drivers/video/rm72014.c                       | 199 +++++++++++
 drivers/video/rockchip/Makefile               |   1 +
 drivers/video/rockchip/dw_mipi_dsi_rockchip.c |  20 ++
 drivers/video/rockchip/rk3368_vop.c           |  81 +++++
 drivers/video/rockchip/rk_vop.c               |  92 +++--
 .../include/dt-bindings/clock/rk3368-cru.h    |   1 +
 include/configs/ymd8_mb.h                     |  11 +
 25 files changed, 1668 insertions(+), 30 deletions(-)
 create mode 100644 arch/arm/dts/rk3368-ymd8-mb-u-boot.dtsi
 create mode 100644 arch/arm/dts/rk3368-ymd8-mb.dts
 create mode 100644 board/rockchip/ymd8_mb/Kconfig
 create mode 100644 board/rockchip/ymd8_mb/MAINTAINERS
 create mode 100644 board/rockchip/ymd8_mb/Makefile
 create mode 100644 board/rockchip/ymd8_mb/README
 create mode 100644 board/rockchip/ymd8_mb/ymd8_mb_rk3368.c
 create mode 100644 configs/ymd8-mb_defconfig
 create mode 100644 drivers/video/rm72014.c
 create mode 100644 drivers/video/rockchip/rk3368_vop.c
 create mode 100644 include/configs/ymd8_mb.h

-- 
2.39.5

