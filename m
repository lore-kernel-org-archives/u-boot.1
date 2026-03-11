Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80DAB1125839
	for <u-boot@archiver.kernel.org>; Wed, 11 Mar 2026 14:23:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0187784013;
	Wed, 11 Mar 2026 15:23:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=flipper.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=flipper.net header.i=@flipper.net header.b="Y8whNhMe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 213818404A; Wed, 11 Mar 2026 14:31:20 +0100 (CET)
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com
 [IPv6:2a00:1450:4864:20::42c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 95B1884013
 for <u-boot@lists.denx.de>; Wed, 11 Mar 2026 14:31:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=flipper.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alchark@flipper.net
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-439ce3605ecso4748865f8f.0
 for <u-boot@lists.denx.de>; Wed, 11 Mar 2026 06:31:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=flipper.net; s=google; t=1773235877; x=1773840677; darn=lists.denx.de;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=0bmAHx0VBRpP4GAvOmADyL4bD3CHbVp257Y3EEbychM=;
 b=Y8whNhMeL95FQzcrtkhsoVq1XPaPHFf9Dr+FYeAg+kflsb/6tzLSV58BFKDNOT4z9a
 Ree7BtAAq6n+2oOJGz8Xt09R5jhGiX8J3JQLF0KO6zqZbhX8p28D/a7DMdAvUUt6P/i8
 qDCrvDAAzpG8Qc/iYxqlRxoJhYSYaOxtU0STjQDfyUgHK2eeO+Pv/CyKEYqIE4V6UFwQ
 nYq1riv1wKHC2lotRFul/Qet/hb6hsB1E7fKZa3Oy+Rl3KcRpp8lFPAXPAxt729pXnIg
 /3FuTcz/FxFLUilAfwuMjImLTt0RzTU0l5EszwOi7uufN8UKRwXSJuB71eHgQ1PocPj9
 gIbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773235877; x=1773840677;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0bmAHx0VBRpP4GAvOmADyL4bD3CHbVp257Y3EEbychM=;
 b=pl35lyCojD+ZHgFYflLWLDXtgqPK7xeTPQKQmVpwnKx1t/qN4NRIzl5OZk5EDPuWmy
 jTv+xBK2aHFsqHF8bLPzt6Ke/5Efkwe1yvhMRUkhaMLsTjb8OlqDfjs0HSYARP4CZX7f
 vEpSt/oCGQA9AJp/Nn4FvRMbjsSM6rrBwyWC6hvbmW7Ey/TOJHl4YM6GtLE4FpVsFs18
 4BrnaxGwxrwBWxZ4tb0JTRjrENJMd1zxLMeU1tH9BUgItIJoE25BngQFFEGfDoZUGvy+
 1ELNaXT9tPpihBs2/wKpcVfe0FlO4ny1D5xA3oYctEK9/ZlUu836jl5kp4c+rgU0jeiN
 PkRw==
X-Gm-Message-State: AOJu0YwFZzxj8O3xWN01cnwioGvX1FaO9rs/Jm6dBLVuvGrCY6xr9mjM
 yFsOSFKAfpwNTnO1jFsMD2LRXuExrlh0k/lQEdjAE0L5vip18lgLTgD4jBMQLSNaGTM=
X-Gm-Gg: ATEYQzwF64i1gLuN9xEJri6Z43wSZpUYDnpcBJj6lcpAUVABWiXXj+vJ48PhywPNykN
 HQPnM069pUn2bV8BP3XMmIRJIGxfhtOIiounV6OGCbqt+ISTvHJdibJs5yjCJwO1RjJwAxj5B1/
 pOzxT1T+PdcmbqqR9WjQpAZN1190Ntengmm+9UL6QiOIwuPYq3cNoiNyCejzsfnICi7mopAhULt
 2kPF8xZnTK1DPnB8KijEyCF1GBc8tappC5naDenR1SqH2+stl43OgiOR8kA47BaLAUUNJBt9tff
 oI5F+WL46yQfYoTTIRERQiu6SWE9a3qv5tWPdLH69J8n/MpsKWnPHWfs4iY7/4rfx+/0TvHme3p
 I6BEjaKCt1+Eb5mQChTiCouENADCAVy0FjanvRL0ckrHS2R8FF0qDMfTa8IDE/84vfoSJjvebSL
 sEw9HgIJrobRK576/GFbAiYz8N/4lPMet/xiHXbIlGXhvuXBUt648ycwgZni3YB5POY5FDYfX+A
 C9BTA==
X-Received: by 2002:a05:6000:1acc:b0:439:ef03:e0b7 with SMTP id
 ffacd0b85a97d-439f821ba49mr5312532f8f.27.1773235876834; 
 Wed, 11 Mar 2026 06:31:16 -0700 (PDT)
Received: from alchark-surface.localdomain (bba-86-98-192-109.alshamil.net.ae.
 [86.98.192.109]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-439f81a9e25sm5903038f8f.15.2026.03.11.06.31.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Mar 2026 06:31:16 -0700 (PDT)
From: Alexey Charkov <alchark@flipper.net>
Subject: [PATCH v6 0/6] Enable full UFS boot on Rockchip RK3576
Date: Wed, 11 Mar 2026 17:30:55 +0400
Message-Id: <20260311-rk3576-ufs-v6-0-c7c353739242@flipper.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAI9usWkC/23RQW7DIBAF0KtErEvFgBlMVrlH1AWYIUFt4hYSq
 1Xku5ekrWSsLv9I76MZbqxQTlTYdnNjmaZU0niuAZ82bDi684F4CjUzKaQGCYLnV6UN8mss3A3
 Kx456AxpZBe+ZYvp8lO1faj6mchnz16N7gvv035oJuOBORUsGySPS7nBy6e15GE/sXjPJP4oCh
 G6orHRw3lljnQjo11QtKTZUVeojSW1jwABmTbsl7RvaVUo9ocHORhX7NdULKttddaWCgkfwSoB
 vXp1/bpjp41r/4fJ7yHn+BsmFqBKlAQAA
X-Change-ID: 20251210-rk3576-ufs-ac3bf4e87156
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Kever Yang <kever.yang@rock-chips.com>, 
 Heiko Stuebner <heiko@sntech.de>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@kernel.org>, Simon Glass <sjg@chromium.org>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Paul Barker <paul.barker.ct@bp.renesas.com>, 
 Christian Marangi <ansuelsmth@gmail.com>, 
 Gabriel Fernandez <gabriel.fernandez@foss.st.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Finley Xiao <finley.xiao@rock-chips.com>, 
 Elaine Zhang <zhangqing@rock-chips.com>, 
 Joseph Chen <chenjh@rock-chips.com>, Xuhui Lin <xuhui.lin@rock-chips.com>, 
 Dhruva Gole <d-gole@ti.com>, Anshul Dalal <anshuld@ti.com>, 
 Alexey Charkov <alchark@flipper.net>, Alexey Charkov <alchark@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=6592; i=alchark@flipper.net;
 h=from:subject:message-id; bh=WcbIOQicnFvf2Gtv0eaH4H1CTQTuC83GcTj72tjKvpk=;
 b=owGbwMvMwCW2adGNfoHIK0sZT6slMWRuzFsQkOvziZfdaNev3uvpf2ezp9xc3VW6NS90mkRuz
 Izazql9HRNZGMS4GCzFFFnmfltiO9WIb9YuD4+vMHNYmUCGSIs0MAABCwNfbmJeqZGOkZ6ptqGe
 oaGOsY4RAxenAEx1ph/DP8XGGE6HMxbtildZSv6x8txoyd/rMKd7m8XCeRM3qfkvF2ZkWCVqaZ+
 xuEhmVkuM+RlrvX11LHMYJVqzHddU35X+k3KCHQA=
X-Developer-Key: i=alchark@flipper.net; a=openpgp;
 fpr=9DF6A43D95320E9ABA4848F5B2A2D88F1059D4A5
X-Mailman-Approved-At: Wed, 11 Mar 2026 15:23:27 +0100
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

Rockchip RK3576 can load its bootloader from UFS among other options,
so this series adds the necessary bits and pieces to enable an end-to-end
boot from UFS (boot ROM -> SPL -> U-boot proper -> kernel).

This series contains the Rockchip-specific code to enable UFS boot in SPL,
and relies on the architecture-independent bits [1], [2] already applied
by Neil Armstrong to the u-boot-ufs custodian tree.

It also depends on the recent addition of Rockchip-specific code to allow
DMA writes to PMU SRAM by Jonas Karlman [3] already applied by Kever Yang
to the u-boot-rockchip custodian tree.

To achieve the above, this series goes through the following:
 - Patches 1-2 cherry-pick recent additions to the upstream DTS files
   required to properly configure the pin mode for the UFS device reset
   pin on RK3576, as well as enable the UFSHC node on the NanoPi M5 board
 - Patch 3 adds an option to build the Rockchip reset driver for SPL
 - Patch 4 ties it all together for Rockchip RK3576
 - Patches 5-6 update defconfigs for two example boards to enable UFS boot

This has been tested on a FriendlyElec NanoPi M5 board with a Biwin
BWU3AKC46C256G UFS module.

Note that in my experience none of the RK3576 boards actually boot current
mainline U-boot versions without a single-word SRAM write before jumping
to DDR initialization, as done in Kwiboo's commit at [4]. Therefore, to
test this series I additionally applied commits 117cd97627fd..04e6417226f5
from Kwiboo's rk3576 branch [5] (including 117cd97627fd), so any testers
might want to:

git cherry-pick 117cd97627fd^..04e6417226f5

from there before or after applying this series

[1] https://source.denx.de/u-boot/custodians/u-boot-ufs/-/commit/8ce3df3ebe6b8c0022a0c79780a2e1ce3e1c792a
[2] https://source.denx.de/u-boot/custodians/u-boot-ufs/-/commit/42dd7a5ae1b166127766ce7e39f98badb311e56d
[3] https://source.denx.de/u-boot/custodians/u-boot-rockchip/-/commit/4015faa32342fd9c494c318c21de106f98dd4674
[4] https://source.denx.de/u-boot/contributors/kwiboo/u-boot/-/commit/04e6417226f50e4e3cb04272280922eb425c18ab
[5] https://source.denx.de/u-boot/contributors/kwiboo/u-boot/-/commits/rk3576?ref_type=heads

Signed-off-by: Alexey Charkov <alchark@flipper.net>
---
Changes in v6:
- Dropped patches already applied by Neil to the u-boot-ufs custodian tree (thanks Neil)
- Rebased to current next (thanks Jonas)
- Fixed the dependency on SPL_CLK instead of CLK for the SPL reset driver (thanks Jonas)
- Included newly required DT nodes into bootph-* filters for the u-boot-spl.dtb (thanks Jonas)
- Cherry-picked the relevant DTS additions from devicetree-rebasing (thanks Jonas)
- Added a preprocessor conditional around the GPIO4 bootph-* node to avoid its inclusion
  without CONFIG_SPL_UFS_SUPPORT (thanks Jonas)
- Added relevant defconfig changes for Rock 4D and NanoPi M5 (thanks Jonas)
- Link to v5: https://lore.kernel.org/r/20260120-rk3576-ufs-v5-0-0edb61b301b7@gmail.com

Changes in v5:
- Reverse X-mas tree in spl_ufs:spl_ufs_load_image (thanks Quentin)
- Explicit "depends on UFS" from CONFIG_SPL_UFS_SUPPORT (thanks Quentin).
  This also pulls in SCSI to avoid compilation errors.
- Split out the patch enabling the Rockchip reset driver for SPL builds
  (thanks Quentin)
- Reworded the error message when requesting the UFS reset GPIO fails
  (thanks Quentin)
- Added a note in the commit message about reset-gpios being required by
  the DT binding (thanks Quentin)
- Dropped the redundant check of GPIO validity in the reset function
  (thanks Quentin)
- Added a note about GPIO4_D0 being the only GPIO usable for UFS reset
  on RK3576 (thanks Shawn)
- Dropped "imply" symbols from the arch Kconfig, now that both GPIO
  and RESET drivers are explicitly depended on from the UFS driver
  (thanks Quentinq)
- Link to v4: https://lore.kernel.org/r/20260108-rk3576-ufs-v4-0-e8e67649f3f8@gmail.com

Changes in v4:
- Added a dependency in b4 metadata on Jonas' new series enabling DMA
  writes to PMU SRAM (thanks Jonas)
- Dropped the bounce buffer quirk altogether, as it now works as-is
- Link to v3: https://lore.kernel.org/r/20260106-rk3576-ufs-v3-0-bfe259fd6d17@gmail.com

Changes in v3:
- Added a UFSHC quirk to use the SCSI bounce buffer for addresses outside
  SDRAM, and enabled it on Rockchip (thanks Neil and Tom)
- Dropped the open-coded bounce buffer from spl_ufs.c, now unneeded
- Link to v2: https://lore.kernel.org/r/20260105-rk3576-ufs-v2-0-caba979a0d6b@gmail.com

Changes in v2:
- Rename the SPL UFS read helper function more self-descriptively (thanks Neil)
- Add an option to configure the UFS LUN used to look for the U-boot image
  in raw offset mode - or rather the SCSI device number, which most of the
  time coincides with the UFS LUN as long as the UFS device is the only
  SCSI block device the SPL sees (thanks Neil)
- Add an option to use a bounce buffer in RAM while loading U-boot from UFS,
  which helps avoid changes to common spl_fit.c code which in v1 achieved a
  similar result at a performance cost to unrelated platforms (thanks Jonas)
- Link to v1: https://lore.kernel.org/r/20251210-rk3576-ufs-v1-0-a3f9e76eb66e@gmail.com

---
Alexey Charkov (5):
      arm64: dts: rockchip: Explicitly request UFS reset pin on RK3576
      arm64: dts: rockchip: enable UFS controller on FriendlyElec NanoPi M5
      reset: rockchip: make device resets available in SPL
      rockchip: spl: Add support for booting from UFS
      rockchip: rk3576-nanopi-m5: Enable UFS support

Jonas Karlman (1):
      rockchip: rk3576-rock-4d: Enable UFS support

 arch/arm/dts/rk3576-u-boot.dtsi                    | 33 +++++++++++++++++++++-
 arch/arm/include/asm/arch-rockchip/bootrom.h       |  1 +
 arch/arm/mach-rockchip/rk3576/rk3576.c             |  1 +
 arch/arm/mach-rockchip/spl-boot-order.c            | 14 +++++++++
 configs/nanopi-m5-rk3576_defconfig                 |  7 +++++
 configs/rock-4d-rk3576_defconfig                   |  7 +++++
 drivers/reset/Kconfig                              |  9 ++++++
 drivers/reset/Makefile                             |  2 +-
 .../src/arm64/rockchip/rk3576-nanopi-m5.dts        | 24 ++++++++++++++++
 .../src/arm64/rockchip/rk3576-pinctrl.dtsi         |  7 +++++
 dts/upstream/src/arm64/rockchip/rk3576.dtsi        |  2 +-
 11 files changed, 104 insertions(+), 3 deletions(-)
---
base-commit: 8bc2a5196c1c0bb5dbdaca073323da0015a0de37
change-id: 20251210-rk3576-ufs-ac3bf4e87156

Best regards,
-- 
Alexey Charkov <alchark@flipper.net>

