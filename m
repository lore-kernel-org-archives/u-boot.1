Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78FDCC87FCF
	for <u-boot@archiver.kernel.org>; Wed, 13 Aug 2025 14:07:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 86BC98362A;
	Wed, 13 Aug 2025 16:07:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id E83B283623; Wed, 13 Aug 2025 16:07:54 +0200 (CEST)
Received: from smtp-1908.mail.infomaniak.ch (smtp-1908.mail.infomaniak.ch
 [185.125.25.8])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 34D1C829F5
 for <u-boot@lists.denx.de>; Wed, 13 Aug 2025 16:07:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=foss+uboot@0leil.net
Received: from smtp-3-0001.mail.infomaniak.ch (unknown
 [IPv6:2001:1600:4:17::246c])
 by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4c29F35Qh5zvkh;
 Wed, 13 Aug 2025 16:07:51 +0200 (CEST)
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4c29F21TT0zKcP; Wed, 13 Aug 2025 16:07:50 +0200 (CEST)
From: Quentin Schulz <foss+uboot@0leil.net>
Subject: [PATCH v2 0/5] power: rk8xx: allow to customize RK806 reset mode
 -- cover
Date: Wed, 13 Aug 2025 16:07:38 +0200
Message-Id: <20250813-rk8xx-rst-fun-v2-0-a2223e17cb2c@cherry.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACqcnGgC/13MQQ6CMBCF4auQWTuGVuyAK+9hWNQytY0JmCkSC
 OHuVty5/F/yvhUSS+QEl2IF4SmmOPQ59KEAF2z/YIxdbtClPpdGE8qznmeUNKJ/9+jrE5M11la
 Vhfx5Cfs4796tzR1iGgdZdn5S3/UnkTJ/0qRQoTaNJnJ3ooavLrDIcuwY2m3bPumsh/2qAAAA
X-Change-ID: 20250627-rk8xx-rst-fun-f83e7a6aa44a
To: Jaehoon Chung <jh80.chung@samsung.com>, Tom Rini <trini@konsulko.com>, 
 Sumit Garg <sumit.garg@kernel.org>, Simon Glass <sjg@chromium.org>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 Kever Yang <kever.yang@rock-chips.com>, 
 Sebastian Reichel <sebastian.reichel@collabora.com>
Cc: u-boot@lists.denx.de, Quentin Schulz <quentin.schulz@cherry.de>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 "Rob Herring (Arm)" <robh@kernel.org>, Lee Jones <lee@kernel.org>, 
 Heiko Stuebner <heiko@sntech.de>
X-Mailer: b4 0.14.2
X-Infomaniak-Routing: alpha
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

The RK3588 Theobroma boards (Tiger and Jaguar) need a different reset
mode for the PMIC to work properly, c.f. DT patches in this series.

While the kernel just recently (v6.17-rc1) gained support for setting
this appropriately, all upstream kernels before that release will simply
not behave appropriately for those boards. While it is typically much
easier to update the Linux kernel than U-Boot, let's cover all possible
scenario by adding support for setting this reset mode properly from
U-Boot so that there isn't a need for patching or updating the kernel.

Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
Changes in v2:
- added DT patches from v6.17-rc1
- Link to v1: https://lore.kernel.org/r/20250716-rk8xx-rst-fun-v1-1-269277cb779e@cherry.de

---
Quentin Schulz (5):
      dt-bindings: mfd: rk806: Allow to customize PMIC reset mode
      arm64: dts: rockchip: add header for RK8XX PMIC constants
      arm64: dts: rockchip: force PMIC reset behavior to restart PMU on RK3588 Jaguar
      arm64: dts: rockchip: force PMIC reset behavior to restart PMU on RK3588 Tiger
      power: rk8xx: allow to customize RK806 reset mode

 drivers/power/pmic/rk8xx.c                        | 21 ++++++++++++---------
 dts/upstream/Bindings/mfd/rockchip,rk806.yaml     | 21 +++++++++++++++++++++
 dts/upstream/src/arm64/rockchip/rk3588-jaguar.dts |  2 ++
 dts/upstream/src/arm64/rockchip/rk3588-tiger.dtsi |  2 ++
 dts/upstream/src/arm64/rockchip/rk8xx.h           | 18 ++++++++++++++++++
 include/power/rk8xx_pmic.h                        |  2 ++
 6 files changed, 57 insertions(+), 9 deletions(-)
---
base-commit: 83ce0b483c1680cb39565a9d91c6ef113a309c38
change-id: 20250627-rk8xx-rst-fun-f83e7a6aa44a

Best regards,
-- 
Quentin Schulz <quentin.schulz@cherry.de>

