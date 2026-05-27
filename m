Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 236EACD5BB1
	for <u-boot@archiver.kernel.org>; Tue, 26 May 2026 14:46:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8B6AE846A5;
	Tue, 26 May 2026 16:46:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=riscstar.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b="XUZ24+m0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B8DA4846E2; Tue, 26 May 2026 16:46:44 +0200 (CEST)
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com
 [IPv6:2607:f8b0:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E985D84671
 for <u-boot@lists.denx.de>; Tue, 26 May 2026 16:46:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=riscstar.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=guodong@riscstar.com
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-2be1dd4af34so94880855ad.1
 for <u-boot@lists.denx.de>; Tue, 26 May 2026 07:46:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1779806800; x=1780411600;
 darn=lists.denx.de; 
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=njflVo6BOrHaMR1w2ZOL9YGmJxJx5jo6gQj0Ra0L6GU=;
 b=XUZ24+m0h34rzog9pEKcp8XF/MDR9v8VN0Xv3+iJCpF2ivxWkh2sja/omiN4fWdJRD
 mV3So6rXah1BSSgl34teXq+PLP2D+T0w+5e7L/NCytLEvNEChZlQjoJc9ZxEs67TVDb9
 0LUvUxG7KK+f5EV56NFAJImWSX7lTEDzQQCaH8m0vTLXaqkWzTgts/chpzGem+1D5x9h
 NpfKWMpaJgm2jyGcruLyri87l26aiSwE2twM1qV3JRzXk4S0lSTwkSGBf3s7DUo7DEgJ
 hNKxjUVQCyFb17c3w+Yxz6zYXhFV7Ej1IBkYbpvx95NWalsCq7fNlCNg9zd3nvUlCw8G
 eliQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779806800; x=1780411600;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=njflVo6BOrHaMR1w2ZOL9YGmJxJx5jo6gQj0Ra0L6GU=;
 b=MWhYd4SAIgXCGs9J9fwrpYwri1RnihHYDgZGpF39MaKzsnweM3Ag0iRr3cXsHXLJYX
 50FX8exQwFYfiPZnPqmi3IoLVSNClbuI9y5CuMwQkqE/R07894Fs9Eg3vyjRqwtKRYVE
 XweBZ/0NaurKNnK+r0sXf8NWwqiryR366DJsNMq8nEPDbmOIcLFA84uXKIehCwBWpcyZ
 Kx+7+OVy+SDroTaNDfVFjPYCT7dgQsZ6T+Hfkm7kOJGQ6puzCFT8oClYTKzOxS37pc/Y
 BR1hvcKboyQ9rsSxThawO61eBIpSJR5K2Jq2Wf5IQqirVoCRP7/dHLmbZn6fH9zq7jtR
 hTwg==
X-Gm-Message-State: AOJu0YzUBg1m/spXHLVczbDhW561rej5F4CDVnm5xCFtLO26kQcKJ+Ro
 HtkEnh3KQTyJgzt90WYT6n5OjAM3aUbhatdsg3KSE4AMFF6IVLpw3xn3AznJZtEsD90=
X-Gm-Gg: Acq92OHS6idLGA7Y5tPnUmtjvPRzceRJ+UA7sV54OBEo6iCQrRiGNbe8hVpo4sHylya
 gBID0+gfvDGwDkctoyCoBGb+EUaIb7JmD+aI3M8hykxcg9uRKPsdlrmcESCu+Q9grFlVQJ5Ny3g
 a0EHRzVn4wl48qQx8vUip64ReWH/gsP/F+ry+XN+hHHX3b30z3fVJnD6Ldw3g8XshxsPxX1G5R6
 vZDA+xVACEZKSYU+vlGeiizVPtjHuu8c+i/5471xhAuRXr8ObnN9Qec/3t+UeJeHN2EjO+DmgDk
 hwI0dV4qO5Z+bz4YHzQpBR3C04Rhnjb1h+LZz93Z2jpiktBy6i+NpIsSLwgMo+f3FZdLytBrnR+
 sBDRFmUpXtHfS+r/fV6py0AzGkqAex6W9vTzE8jMI3/z5jl8qMLRNEa47vL7K6FrP6/o5L8sfoL
 4w9sxzNHjOhiUFsnvlU0tjbtmj1jgoCQyz8y0OBhx7cVE=
X-Received: by 2002:a17:903:388c:b0:2bc:a577:70c2 with SMTP id
 d9443c01a7336-2beb06292f1mr212940705ad.31.1779806800245; 
 Tue, 26 May 2026 07:46:40 -0700 (PDT)
Received: from [127.0.1.1] ([2a12:a305:4::40e3])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2beb56f4343sm169559915ad.36.2026.05.26.07.46.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 May 2026 07:46:39 -0700 (PDT)
From: Guodong Xu <guodong@riscstar.com>
Subject: [PATCH v2 0/8] riscv: spacemit: k1: add clock and reset drivers,
 switch to upstream DT
Date: Tue, 26 May 2026 22:45:40 -0400
Message-Id: <20260526-b4-k1-clk-reset-upstream-dts-v2-0-af815e362b0c@riscstar.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANRaFmoC/42NSw6CMBBAr0K6dkzLR6Mr72FYtGUqI/LJTCEaw
 t0FvIDLl7y8NytBJhR1TWbFOJFQ362QHhLla9s9EKhaWaU6PenCaHA5NAb8qwFGwQjjIJHRtlB
 FAe+CCZk9X3xwak0MjIHee/5e/lhG90Qft+Zm1CSx58/+n8zm/bmaDGionHa60Blint+YxEu0f
 PR9q8plWb53COo83QAAAA==
X-Change-ID: 20260510-b4-k1-clk-reset-upstream-dts-cbf1f3a79cfb
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>, 
 Michal Simek <michal.simek@amd.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Yao Zi <me@ziyao.cc>, 
 Junhui Liu <junhui.liu@pigmoral.tech>, 
 Peter Korsgaard <peter@korsgaard.com>, 
 Leo Yu-Chi Liang <ycliang@andestech.com>, 
 Raymond Mao <raymond.mao@riscstar.com>, 
 Gabriel Fernandez <gabriel.fernandez@foss.st.com>, 
 Kever Yang <kever.yang@rock-chips.com>, 
 Finley Xiao <finley.xiao@rock-chips.com>, Rick Chen <rick@andestech.com>, 
 Conor Dooley <conor.dooley@microchip.com>, u-boot-spacemit@groups.io, 
 Vincent Legoll <legoll@online.fr>, Guodong Xu <docularxu@outlook.com>, 
 Guodong Xu <guodong@riscstar.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>
X-Mailer: b4 0.15.1
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

Currently U-Boot's SpacemiT K1 ships its own arch/riscv/dts/k1.dtsi and a
spacemit,k1-reset binding that has no node in the upstream
(kernel-mainline) K1 dts. After list discussion [1], this series
moves U-Boot to the upstream DT before further K1 work lands.

In the upstream DT, each K1 syscon provides both clocks and resets.
The kernel's clock driver spawns the reset child via the auxiliary
bus. This patchset does the same in U-Boot: each clock driver
spawns a UCLASS_RESET sibling on the same ofnode.

The four K1 clock controllers (PLL, MPMU, APMU, APBC) live in separate
syscon nodes, with clock parent dependency chain between them as below:

    MPMU <- PLL
    APMU <- PLL, MPMU
    APBC <- PLL, MPMU, APMU

The following is cover letter from v1:

Patch 1/8 adds the K1 clock driver.
Patch 2/8 adds a new syscon-bound reset driver with no DT of_match. At this
          point, the legacy reset driver and local dts are still there.
Patch 3/8 has each per-syscon clock driver spawn the reset child on the
          same ofnode, the way the kernel uses auxiliary devices.
Patch 4/8 enables the clock driver.
Patch 5/8 switches BPI-F3 to dts/upstream/.
Patch 6/8, 7/8 and 8/8 clean up the legacy reset driver and local dts files.

Old and new reset drivers coexist from 2/8 through 6/8 so the series
is bisectable.

The K1 SPL bring-up [2] and PIN/SPI [3] series will be rebased on
this and resent once it lands.

Link: https://lore.kernel.org/u-boot/20260507140558.GU1614990@bill-the-cat/ # [1]
Link: https://lore.kernel.org/u-boot/20260325223232.1553212-1-raymondmaoca@gmail.com/ # [2]
Link: https://lore.kernel.org/u-boot/20260422143112.1329478-1-raymondmaoca@gmail.com/ # [3]

Changes in v2:
- 1/8 (clk: spacemit: Add support for K1 SoC):
  - Force parent controllers to probe by driver (uclass_get_device_by_driver
    + DM_DRIVER_GET) instead of clk_get_by_index() with magic indices 4/5/6;
    (Yao Zi)
  - Drop the dead k1_clk_retry_register() loop; retry_list was never
    populated (Yao Zi)
  - Kconfig: depends on CLK || COMPILE_TEST to allow build-test coverage
    (Yao Zi)
  - Kconfig: select LIB_RATIONAL from CLK_SPACEMIT, not CLK_SPACEMIT_K1,
    (Yao Zi)
  - Reword the commit body with the explicit controller dependency graph
    above (Yao Zi)
- 5/8 (dts: k1: switch BPI-F3 build to upstream DT):
  - As a benefit from changes in patch 1/8, drop the helper clocks/clock-names
    from &syscon_mpmu and &syscon_apbc. uboot overlay dtsi simplified;

Link to v1: https://patch.msgid.link/20260510-b4-k1-clk-reset-upstream-dts-v1-0-db0b0503ee44@riscstar.com

BR,
Guodong Xu / docularxu

Signed-off-by: Guodong Xu <guodong@riscstar.com>
---
---
Guodong Xu (7):
      reset: spacemit: k1: introduce syscon-bound reset driver
      clk: spacemit: k1: spawn reset device from per-syscon clock drivers
      configs: bananapi-f3: enable Spacemit K1 clock driver
      dts: k1: switch BPI-F3 build to upstream DT
      dts: k1: drop legacy local DT files
      reset: spacemit: k1: drop legacy spacemit,k1-reset driver
      dt-bindings: reset: drop spacemit-k1-reset.h

Junhui Liu (1):
      clk: spacemit: Add support for K1 SoC

 arch/riscv/dts/Makefile                       |    1 -
 arch/riscv/dts/k1-bananapi-f3-u-boot.dtsi     |   13 +
 arch/riscv/dts/k1-bananapi-f3.dts             |   28 -
 arch/riscv/dts/k1-pinctrl.dtsi                |   19 -
 arch/riscv/dts/k1.dtsi                        |  480 -------
 configs/bananapi-f3_defconfig                 |    6 +-
 drivers/clk/Kconfig                           |    5 +-
 drivers/clk/Makefile                          |    1 +
 drivers/clk/spacemit/Kconfig                  |   23 +
 drivers/clk/spacemit/Makefile                 |    7 +
 drivers/clk/spacemit/clk-k1.c                 | 1750 +++++++++++++++++++++++++
 drivers/clk/spacemit/clk_common.h             |   79 ++
 drivers/clk/spacemit/clk_ddn.c                |   93 ++
 drivers/clk/spacemit/clk_ddn.h                |   53 +
 drivers/clk/spacemit/clk_mix.c                |  403 ++++++
 drivers/clk/spacemit/clk_mix.h                |  224 ++++
 drivers/clk/spacemit/clk_pll.c                |  157 +++
 drivers/clk/spacemit/clk_pll.h                |   81 ++
 drivers/reset/Kconfig                         |    7 -
 drivers/reset/Makefile                        |    2 +-
 drivers/reset/reset-spacemit-k1.c             |  548 --------
 drivers/reset/spacemit/Makefile               |    5 +
 drivers/reset/spacemit/reset-spacemit-k1.c    |  289 ++++
 include/dt-bindings/reset/spacemit-k1-reset.h |  118 --
 include/soc/spacemit/k1-reset.h               |   23 +
 include/soc/spacemit/k1-syscon.h              |  149 +++
 26 files changed, 3358 insertions(+), 1206 deletions(-)
---
base-commit: 215496fec59b3fa09256b4fb62f92af46e2ec7f9
change-id: 20260510-b4-k1-clk-reset-upstream-dts-cbf1f3a79cfb

Best regards,
--  
Guodong Xu <guodong@riscstar.com>

