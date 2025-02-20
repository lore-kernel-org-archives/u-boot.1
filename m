Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6D97C021AA
	for <u-boot@archiver.kernel.org>; Thu, 20 Feb 2025 03:17:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EB6B780A46;
	Thu, 20 Feb 2025 04:17:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="JNlVEnFe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4773880A46; Thu, 20 Feb 2025 04:17:16 +0100 (CET)
Received: from mail-m19731105.qiye.163.com (mail-m19731105.qiye.163.com
 [220.197.31.105])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 60D6C80F32
 for <u-boot@lists.denx.de>; Thu, 20 Feb 2025 04:17:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
Received: from localhost.localdomain (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTP id b9ba9549;
 Thu, 20 Feb 2025 11:17:06 +0800 (GMT+08:00)
From: Kever Yang <kever.yang@rock-chips.com>
To: trini@konsulko.com
Cc: u-boot@lists.denx.de
Subject: Pull request: u-boot-rockchip-20250220
Date: Thu, 20 Feb 2025 11:17:06 +0800
Message-Id: <20250220031706.1196038-1-kever.yang@rock-chips.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGktLQ1ZISU8fSUJKTUtLSUhWFRQJFh
 oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
 hVSktLVUpCS0tZBg++
X-HM-Tid: 0a95215be8f903afkunmb9ba9549
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6PyI6HAw*PTIWES06GgwCOTcN
 SxUKCRJVSlVKTE9LS0lKT0lMSkpLVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFISEhKNwY+
DKIM-Signature: a=rsa-sha256;
 b=JNlVEnFeJ7sMdkEaNTpdZJvZaqVkO+GzLPId96RntiyXCzxrZ8JYesVJZvtniwduOzSmQeqfSJQURSUaSZQPIqqaxejA5MrdC5qP1/3liKiqkVz1yNi3+FNtE8dmG/tnssfmnrHQjULlsTVzggJwlePzb3yTZACq6GaC22WEtKg=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1; 
 bh=iEqa7NaYHbd1h7fJa36WmvmUEqm/0UiN/p35P2wjWF0=;
 h=date:mime-version:subject:message-id:from;
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

Please pull the fixes for rockchip platform:
- Fix for rk3399 bob and kevin
- Fix for sdram more than 4GB
- Fix for dwc_eth on rk356x/rk3588
- Fix for sdmmc access on rk33080rock-s9

CI:
https://source.denx.de/u-boot/custodians/u-boot-rockchip/-/pipelines/24690

Thanks,
- Kever

The following changes since commit 7a45cb4ffeff034304789954bb222ddd7d02104a:

  fs/erofs: fix an integer overflow in symlink resolution (2025-02-18 12:32:07 -0600)

are available in the Git repository at:

  https://source.denx.de/u-boot/custodians/u-boot-rockchip.git tags/u-boot-rockchip-20250220

for you to fetch changes up to d69097683d65652554639e9ff8cdb53e6e3ee63b:

  arm64: dts: rockchip: Fix sdmmc access on rk3308-rock-s0 v1.1 boards (2025-02-19 23:26:40 +0800)

----------------------------------------------------------------
Chen-Yu Tsai (1):
      rockchip: rk3399: grf: Fix enum typos for UART2

Johan Jonker (1):
      rockchip: use OF_UPSTREAM for rk3036

Jonas Karlman (11):
      Revert "rockchip: rk3399: Drop unneeded bob and kevin board specific code"
      rockchip: rk3399-gru: Enable TPL_GPIO for bob and kevin
      Revert "rockchip: rk3399: Fix TPL build of bob and kevin"
      rockchip: sdram: Allow the first bank to extend beyond 4 GiB
      rockchip: sdram: Limit usable ram_top to max 4G
      rockchip: sdram: Ensure ram_base is correct in SPL
      rockchip: rk3288: Use rk3288-cru.h from dts/upstream
      pinctrl: rockchip: rk3328: Fix pinmux for GPIO2-B and GPIO3-B pins
      net: dwc_eth_qos_rockchip: Fix disable of RX/TX delay for RK356x
      net: dwc_eth_qos_rockchip: Fix disable of RX/TX delay for RK3588
      arm64: dts: rockchip: Fix sdmmc access on rk3308-rock-s0 v1.1 boards

 arch/arm/dts/Makefile                              |   3 -
 ...3036-sdk-u-boot.dtsi => rk3036-evb-u-boot.dtsi} |   6 +-
 arch/arm/dts/rk3036-kylin-u-boot.dtsi              |  13 +
 arch/arm/dts/rk3036-sdk.dts                        |  74 ----
 arch/arm/dts/rk3036.dtsi                           | 439 ---------------------
 arch/arm/include/asm/arch-rockchip/grf_rk3399.h    |   6 +-
 arch/arm/mach-rockchip/Kconfig                     |   1 +
 arch/arm/mach-rockchip/rk3399/rk3399.c             |  25 +-
 arch/arm/mach-rockchip/sdram.c                     |   6 +-
 configs/chromebook_bob_defconfig                   |   1 +
 configs/chromebook_kevin_defconfig                 |   1 +
 configs/evb-rk3036_defconfig                       |   4 +-
 configs/kylin-rk3036_defconfig                     |   4 +-
 drivers/net/dwc_eth_qos_rockchip.c                 |  14 +-
 drivers/pinctrl/rockchip/pinctrl-rk3328.c          |  59 ++-
 dts/upstream/src/arm64/rockchip/rk3308-rock-s0.dts |  25 +-
 include/dt-bindings/clock/rk3036-cru.h             | 185 ---------
 include/dt-bindings/clock/rk3288-cru.h             | 381 ------------------
 18 files changed, 140 insertions(+), 1107 deletions(-)
 rename arch/arm/dts/{rk3036-sdk-u-boot.dtsi => rk3036-evb-u-boot.dtsi} (100%)
 create mode 100644 arch/arm/dts/rk3036-kylin-u-boot.dtsi
 delete mode 100644 arch/arm/dts/rk3036-sdk.dts
 delete mode 100644 arch/arm/dts/rk3036.dtsi
 delete mode 100644 include/dt-bindings/clock/rk3036-cru.h
 delete mode 100644 include/dt-bindings/clock/rk3288-cru.h
