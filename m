Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9F96CD8C9D
	for <u-boot@archiver.kernel.org>; Tue,  9 Jun 2026 01:22:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 95633839A8;
	Tue,  9 Jun 2026 03:22:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="gIv89kYs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4F1D783FEC; Tue,  9 Jun 2026 03:22:50 +0200 (CEST)
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com
 [IPv6:2a00:1450:4864:20::52f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 30C0A8341A
 for <u-boot@lists.denx.de>; Tue,  9 Jun 2026 03:22:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jbx6244@gmail.com
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-68f0fc103easo521630a12.2
 for <u-boot@lists.denx.de>; Mon, 08 Jun 2026 18:22:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780968167; x=1781572967; darn=lists.denx.de;
 h=content-transfer-encoding:content-language:cc:to:subject:from
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mkjG29aVsQaD4e92y0mvZuq0sSsPDhWf8oI/4uFRxyA=;
 b=gIv89kYs1XjalFx0YI/3pl0dEqL1Ek/hKMQCud0lflm0Tyk2Qg18XsmG6Wq4sdbd0h
 OaSptEx+iAkQeqGat2EeupjRgP0veCmD1ucG9BPSBfLv1B2aOi8dA0w8U5Z2yTHmBq+a
 0Wqo3BektewG+uJvv97QSZmqdztHToEyr4nxB05omsSNqZJ6u/cLH2Ux61btYnVNjuhP
 18/YjR7DSLpmL8S4YE+dvefvbz8BcW5m7z7s3M1zkq/FI+AhuH4/po9MIRR+IHwwyQJw
 d84IjoE7+U2Mi7TudWO6YCaySfwWDpM4E6Al+BbWPjp8iXMo77qPJ6nKu6Q6fveHlLA1
 aIqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780968168; x=1781572968;
 h=content-transfer-encoding:content-language:cc:to:subject:from
 :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=mkjG29aVsQaD4e92y0mvZuq0sSsPDhWf8oI/4uFRxyA=;
 b=M1XQeytsay2bx+DEFKutPeqnOPhhvgEROIyV/J9wkmMnpRTQRcZg9HWwlPEmuQWnkM
 4LOIirpnEvo9xi/TqeYr+byFE8nzaph+24oN2JyLyP1gsruv3SrUllW8G+47e2n/kPGg
 RKLAWWPpC746dydbmh8mJNfzQ1wDmXJcOzkONh+v61HpzGmXqMJYIVOISVUewUO1+eAP
 xtrYeI8yBjaYVFEbIe60y9LhimE9iqge0mrYG+5V83Zig5FWzL5vY7xHiEhL2Xs+dJS7
 G/bIbVwPlaKSqrAXJl03VBcOg7MVyWlUlglKBIPywMc1WMu0CQmb8+c8DZhNFSjNRn0c
 n07A==
X-Gm-Message-State: AOJu0YwHUtB+qzi7tPETwFJPAxkcx6hewax5LhPh9bV97EOAwP3pLCkZ
 fhUdVLRjqjA9vWqehtlF15QXkF0tYEl1qUdeHSIfrLAzSFGwvOsxcRjgUGRv3Q==
X-Gm-Gg: Acq92OH38+w6J8ly7ZCcjko/J5EG7o92vR2xbtww/jzLp+TTg1v94pSOds2qvJoJ+/K
 WPw3O7ImYTlQhPdb2D4X1PCMi4NjNUdyA+OiEuwvVoKKId1kzWGHvKG4zFKzUWR5aG79ldhjz74
 B9uH1BDE4Z+BGvT0UKKokiQPzw0IK7HMvYeU2VPH91lrYmr/Gv3MYkadufCzJYX48zbrAYMo0C9
 /YxOMR60Q2vwilxCmQyxAG9WDS2xIIGCYmKXL7GBhskt4jKpTtnp5/keNuDg+8Bf9Kupxx3HRwM
 xUoNsJFqaM/n/dSHpZG4bHA8yBKs8JnFAhy8fa23LOIprVAlWcSUyeO3+ZvRPp06KZ9g3M2jnIB
 fhK3hyWLyVZJwo6FWNcMIvDxqQr3s/hJoESMM79B8iEJXnBs3XJu+2OViF2FfGLw+o2eLx179Tm
 m4wCGY9hy+dW8JTbF2Gyu2/SzAG5O0PNPdRftqsoDnPW+mIPI8Ziy3DosNFlAfChjmN4sdNjb7
X-Received: by 2002:a05:6402:2405:b0:68a:7a6e:cb4a with SMTP id
 4fb4d7f45d1cf-692377482e0mr113597a12.2.1780968167397; 
 Mon, 08 Jun 2026 18:22:47 -0700 (PDT)
Received: from ?IPV6:2a02:a449:4071:0:32d0:42ff:fe10:6983?
 ([2a02:a449:4071:0:32d0:42ff:fe10:6983])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-68e65851786sm7725485a12.17.2026.06.08.18.22.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 08 Jun 2026 18:22:45 -0700 (PDT)
Message-ID: <d1270724-50eb-450d-8847-a3271ea27a2a@gmail.com>
Date: Tue, 9 Jun 2026 03:22:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Johan Jonker <jbx6244@gmail.com>
Subject: [PATCH v1 0/8] Kconfig restyle
To: trini@konsulko.com
Cc: u-boot@lists.denx.de
Content-Language: en-US, ar-EG
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

The Kconfig menu attribute '---help---' is deprecated.
If we change to "help" the text has to indent.
This again has to align with other attributes,
so we have to restyle them as well.
And as there's a script then change all Kconfig
to start with the 'arch' and 'board' directories.

Restyle all Kconfigs:
Menu entries   : no space left
Menu attributes: 1 TAB
Help text      : 1 TAB + 2 spaces
Replace '---help---' by 'help'

Problems:
People creating indents in help texts.
The script doesn't care. It puts everything left aligned.

Help texts with empty lines. It stops aligning as help test.

Other fixes:
While using checkpatch.pl or the script some issues showed up,
so fix them as well.

Johan Jonker (8):
  Kconfig: armv7: fix typo
  Kconfig: powerpc: mpc85xx: fix typo
  Kconfig: power: pmic: fix typo
  Kconfig: themal: fix typo
  Kconfig: misc: add empty line
  Kconfig: arm: restyle
  Kconfig: arch: restyle
  Kconfig: board: restyle

 arch/Kconfig                                |  16 +-
 arch/arm/Kconfig                            |  54 +--
 arch/arm/cpu/armv7/Kconfig                  |  26 +-
 arch/arm/cpu/armv7/ls102xa/Kconfig          |   8 +-
 arch/arm/cpu/armv8/Kconfig                  |  18 +-
 arch/arm/cpu/armv8/fsl-layerscape/Kconfig   |   6 +-
 arch/arm/mach-at91/Kconfig                  |  12 +-
 arch/arm/mach-imx/Kconfig                   |   2 +-
 arch/arm/mach-imx/imx9/Kconfig              |   6 +-
 arch/arm/mach-imx/mx6/Kconfig               |  16 +-
 arch/arm/mach-keystone/Kconfig              |   4 +-
 arch/arm/mach-kirkwood/Kconfig              |  10 +-
 arch/arm/mach-mediatek/Kconfig              |  28 +-
 arch/arm/mach-omap2/omap5/Kconfig           |  10 +-
 arch/arm/mach-owl/Kconfig                   |  12 +-
 arch/arm/mach-rockchip/Kconfig              |  16 +-
 arch/arm/mach-rockchip/px30/Kconfig         |   4 +-
 arch/arm/mach-rockchip/rk322x/Kconfig       |   4 +-
 arch/arm/mach-rockchip/rk3288/Kconfig       |   6 +-
 arch/arm/mach-rockchip/rk3308/Kconfig       |   2 +-
 arch/arm/mach-rockchip/rk3368/Kconfig       |  18 +-
 arch/arm/mach-rockchip/rk3399/Kconfig       |   4 +-
 arch/arm/mach-rockchip/rv1126/Kconfig       |   2 +-
 arch/arm/mach-socfpga/Kconfig               |   4 +-
 arch/arm/mach-sti/Kconfig                   |   2 +-
 arch/arm/mach-stm32mp/Kconfig               |  54 +--
 arch/arm/mach-stm32mp/cmd_stm32prog/Kconfig |  22 +-
 arch/arm/mach-sunxi/Kconfig                 | 450 ++++++++++----------
 arch/arm/mach-uniphier/Kconfig              |   2 +-
 arch/m68k/Kconfig                           |  34 +-
 arch/mips/Kconfig                           |   8 +-
 arch/mips/mach-octeon/Kconfig               |   8 +-
 arch/powerpc/cpu/mpc85xx/Kconfig            |  44 +-
 arch/x86/Kconfig                            |  20 +-
 board/alliedtelesis/SBx81LIFKW/Kconfig      |   2 +-
 board/alliedtelesis/SBx81LIFXCAT/Kconfig    |   2 +-
 board/beagle/beagleboneai64/Kconfig         |   4 +-
 board/beagle/beagleplay/Kconfig             |  12 +-
 board/beagle/beagley-ai/Kconfig             |   2 +-
 board/cortina/common/Kconfig                |  10 +-
 board/cortina/presidio-asic/Kconfig         |   2 +-
 board/firefly/roc-pc-rk3399/Kconfig         |   2 +-
 board/imgtec/boston/Kconfig                 |   2 +-
 board/logicpd/imx6/Kconfig                  |   2 +-
 board/nxp/ls1012ardb/Kconfig                |   2 +-
 board/nxp/mx6memcal/Kconfig                 |  60 +--
 board/out4/o4-imx6ull-nano/Kconfig          |  20 +-
 board/phytec/common/Kconfig                 |  18 +-
 board/phytec/common/k3/Kconfig              |   4 +-
 board/phytec/phycore_am62ax/Kconfig         |   4 +-
 board/phytec/phycore_am62x/Kconfig          |  40 +-
 board/phytec/phycore_am64x/Kconfig          |  34 +-
 board/phytec/phycore_am68x/Kconfig          |   4 +-
 board/samsung/axy17lte/Kconfig              |  12 +-
 board/siemens/draco/Kconfig                 |   4 +-
 board/socionext/developerbox/Kconfig        |   8 +-
 board/sysam/amcore/Kconfig                  |   6 +-
 board/ti/am62ax/Kconfig                     |   2 +-
 board/ti/am62px/Kconfig                     |   2 +-
 board/ti/am62x/Kconfig                      |   4 +-
 board/ti/am64x/Kconfig                      |   4 +-
 board/ti/am65x/Kconfig                      |   4 +-
 board/ti/common/Kconfig                     |   4 +-
 board/ti/j7200/Kconfig                      |   4 +-
 board/ti/j721e/Kconfig                      |   4 +-
 board/ti/j721s2/Kconfig                     |   4 +-
 board/ti/j722s/Kconfig                      |   2 +-
 board/ti/j784s4/Kconfig                     |   8 +-
 board/toradex/apalis_imx6/Kconfig           |  12 +-
 board/toradex/aquila-am69/Kconfig           |   4 +-
 board/toradex/colibri_imx6/Kconfig          |   2 +-
 board/toradex/verdin-am62p/Kconfig          |  28 +-
 board/traverse/common/Kconfig               |   4 +-
 board/xilinx/Kconfig                        |   2 +-
 drivers/misc/Kconfig                        |   1 +
 drivers/power/pmic/Kconfig                  |   2 +-
 drivers/thermal/Kconfig                     |   2 +-
 77 files changed, 644 insertions(+), 643 deletions(-)

--
2.39.5

