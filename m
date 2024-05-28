Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92F6BC25B78
	for <u-boot@archiver.kernel.org>; Tue, 28 May 2024 22:21:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C801E88543;
	Wed, 29 May 2024 00:21:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="IW3C3iRO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8BA408844E; Tue, 28 May 2024 19:05:04 +0200 (CEST)
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com
 [IPv6:2607:f8b0:4864:20::636])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 620CF8846C
 for <u-boot@lists.denx.de>; Tue, 28 May 2024 19:05:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=liujianfeng1994@gmail.com
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-1f48b825d8cso7660295ad.2
 for <u-boot@lists.denx.de>; Tue, 28 May 2024 10:05:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1716915900; x=1717520700; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=IoZOv0zgDmq/P8GC+hzYCDvDdLh+kfJAEIlXV6/ldbw=;
 b=IW3C3iROCtrwvta7e49rsLlifXrsRm2IjKDUJcV3T6Aq+a+W5k07vWcXiCvD7S3vKc
 Nxw8K72tKayrGtgENTvtHpVkhtf2q682YavnzKIJ4QhcbTqJrJ3GpAbFi9rvST9tJHk7
 4+reKRmp0oMrjP06vowjimSPhfF6S5P1YGkk8h4TGn5F4M4T5wVzsFXsxYdwdfstElsI
 MCcDO9yk5B+KjDT6/rWHI2hiA4aE5llo1OysUlGwyliI0Ibiqb/0nO69XOQJ4lJhwYwL
 F+Yh6iaSabqEAVKdnBw8GGkGAYz1fDl1ikl0n4fm5lPs6YzKCufoBC6M0kQpeZ4EjlcC
 UGBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716915900; x=1717520700;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=IoZOv0zgDmq/P8GC+hzYCDvDdLh+kfJAEIlXV6/ldbw=;
 b=Mcbak9vHoDh+GpRfgGO9vy7VAjZo5dXlug9ucRN1QNGpnMAdN4jzCTWoL2ZWlriQk4
 UKHZMcNmsasncohtN/kumBa9rDasb+y2Kq5rwzaDH06JlTLYFSBAQDPhmWVsQ2EhTJ//
 Xwu9tDJrJv4N8jUYAPLD8AvpqNL/7t+uJVY242yffSNd7HDoB7jBFx88O9IjGYOxARYi
 pFkoXy9WeNo55fbLMyebuba02HP4fKs043XdZ2Kk/mF7DYZVfy191vL0B0uOiaNUIILS
 u2rvN0os09CAxWnLSseUmhCwhi6iyk1TcjTdToZLDKYW5X14oKlsi8h8Tdl3F4ITKObC
 +cXw==
X-Gm-Message-State: AOJu0YxoDYUPqJ7N+5VGdMh4uOT0lCiDOwJ6Tydk+s8dfge3tG76lvBz
 L0g3F04VWRmyhLIaEO0p1vrWhaiy3NeYNHNwACl3WxgslBfPByvRVT2Y6yh43Irh+Q==
X-Google-Smtp-Source: AGHT+IEQDRaDDcCbrmLxELL2OmZrDlvs+5ZI2tBOycShrTRKxs5fXI1lsm1+vUY64Ye0+BRqwPWFqA==
X-Received: by 2002:a17:902:e74c:b0:1f4:6252:db95 with SMTP id
 d9443c01a7336-1f46252ddbbmr135914685ad.5.1716915900323; 
 Tue, 28 May 2024 10:05:00 -0700 (PDT)
Received: from localhost.localdomain ([221.220.133.99])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f47efff203sm53037705ad.241.2024.05.28.10.04.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 May 2024 10:04:59 -0700 (PDT)
From: Jianfeng Liu <liujianfeng1994@gmail.com>
To: u-boot@lists.denx.de
Cc: Jianfeng Liu <liujianfeng1994@gmail.com>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Boris Brezillon <boris.brezillon@collabora.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Christopher Obbard <chris.obbard@collabora.com>,
 Diederik de Haas <didi.debian@cknow.org>,
 Elon Zhang <zhangzj@rock-chips.com>,
 Eugen Hristev <eugen.hristev@collabora.com>,
 FUKAUMI Naoki <naoki@radxa.com>, Heiko Stuebner <heiko@sntech.de>,
 Jagan Teki <jagan@edgeble.ai>, John Clark <inindev@gmail.com>,
 Jonas Karlman <jonas@kwiboo.se>, Joseph Chen <chenjh@rock-chips.com>,
 Joshua Riek <jjriek@verizon.net>, Kever Yang <kever.yang@rock-chips.com>,
 Marek Vasut <marex@denx.de>,
 Massimo Pegorer <massimo.pegorer+oss@gmail.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Michal Simek <michal.simek@amd.com>,
 Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
 Niklas Cassel <cassel@kernel.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Quentin Schulz <quentin.schulz@theobroma-systems.com>,
 Sam Edwards <cfsworks@gmail.com>,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 Simon Glass <sjg@chromium.org>, Sumit Garg <sumit.garg@linaro.org>,
 Tom Fitzhenry <tom@tom-fitzhenry.me.uk>, Tom Rini <trini@konsulko.com>,
 Weizhao Ouyang <weizhao.ouyang@arm.com>
Subject: [PATCH v4 00/10] add ArmSoM Sige7 Rk3588 board
Date: Wed, 29 May 2024 01:03:56 +0800
Message-Id: <20240528170406.353616-1-liujianfeng1994@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 29 May 2024 00:21:20 +0200
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

This series also introduces dts commits of rk3588s.dtsi and rk3588.dtsi
from v6.10-rc1-dts.
Then dts of ArmSoM Sige7 is picked from upstream.
I also remove obsolete usb3 nodes of rk3588-u-boot.dtsi and
rk3588-u-boot.dtsi.

Changes in v4:
- Pick all commits of rk3588s.dtsi and rk3588.dtsi from v6.10-rc1-dts
- Remove obsolete USB3 DRD nodes in u-boot.dtsi of rk3588s/rk3588
- Remove sdhci and usb nodes from rk3588-armsom-sige7-u-boot.dtsi

Changes in v3:
- Use update-dts-subtree.sh to pick upstream dts

Changes in v2:
- Fix alphabetical order of MAINTAINERS
- Use arch/arm/dts/rk3588-armsom-sige7* in board MAINTAINERS
- Remove spi flash related config
- Move kernel dts to dts/upstream/src/arm64/rockchip/

Boris Brezillon (1):
  arm64: dts: rockchip: Add rk3588 GPU node

Diederik de Haas (1):
  arm64: dts: rockchip: Fix ordering of nodes on rk3588s

Jianfeng Liu (3):
  arm64: dts: rockchip: Add ArmSom Sige7 board
  rockchip: rk3588: Remove USB3 DRD nodes in u-boot.dtsi
  board: rockchip: add ArmSoM Sige7 Rk3588 board

Niklas Cassel (1):
  arm64: dts: rockchip: add rk3588 pcie and php IOMMUs

Sebastian Reichel (4):
  arm64: dts: rockchip: fix usb2phy nodename for rk3588
  arm64: dts: rockchip: reorder usb2phy properties for rk3588
  arm64: dts: rockchip: add USBDP phys on rk3588
  arm64: dts: rockchip: add USB3 DRD controllers on rk3588

 MAINTAINERS                                   |   1 +
 arch/arm/dts/rk3588-armsom-sige7-u-boot.dtsi  |   6 +
 arch/arm/dts/rk3588-u-boot.dtsi               |  74 --
 arch/arm/dts/rk3588s-u-boot.dtsi              |  85 ---
 arch/arm/mach-rockchip/rk3588/Kconfig         |  26 +
 board/armsom/sige7-rk3588/Kconfig             |  12 +
 board/armsom/sige7-rk3588/MAINTAINERS         |   7 +
 configs/sige7-rk3588_defconfig                |  93 +++
 doc/board/rockchip/rockchip.rst               |   1 +
 .../arm64/rockchip/rk3588-armsom-sige7.dts    | 721 ++++++++++++++++++
 dts/upstream/src/arm64/rockchip/rk3588.dtsi   |  72 ++
 dts/upstream/src/arm64/rockchip/rk3588s.dtsi  | 377 ++++++---
 include/configs/sige7-rk3588.h                |  15 +
 13 files changed, 1225 insertions(+), 265 deletions(-)
 create mode 100644 arch/arm/dts/rk3588-armsom-sige7-u-boot.dtsi
 create mode 100644 board/armsom/sige7-rk3588/Kconfig
 create mode 100644 board/armsom/sige7-rk3588/MAINTAINERS
 create mode 100644 configs/sige7-rk3588_defconfig
 create mode 100644 dts/upstream/src/arm64/rockchip/rk3588-armsom-sige7.dts
 create mode 100644 include/configs/sige7-rk3588.h

-- 
2.34.1

