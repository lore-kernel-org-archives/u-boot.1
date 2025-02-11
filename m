Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20122C021A1
	for <u-boot@archiver.kernel.org>; Tue, 11 Feb 2025 06:14:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 486A080BAD;
	Tue, 11 Feb 2025 07:13:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=radxa.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 73F0E80BAA; Tue, 11 Feb 2025 07:13:56 +0100 (CET)
Received: from mail.naobsd.org (sakura.naobsd.org [160.16.200.221])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8CC54807C0
 for <u-boot@lists.denx.de>; Tue, 11 Feb 2025 07:13:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=radxa.com
Authentication-Results: phobos.denx.de; spf=fail smtp.mailfrom=naoki@radxa.com
Received: from secure.fukaumi.org ([10.0.0.2])
 by mail.naobsd.org (8.14.4/8.14.4/Debian-4.1ubuntu1.1) with ESMTP id
 51B6DR7X024871; Tue, 11 Feb 2025 15:13:27 +0900
From: FUKAUMI Naoki <naoki@radxa.com>
To: u-boot@lists.denx.de
Cc: sjg@chromium.org, philipp.tomsich@vrull.eu, kever.yang@rock-chips.com,
 banglang.huang@foxmail.com, jonas@kwiboo.se, trini@konsulko.com,
 gajjar04akash@gmail.com, eugen.hristev@linaro.org,
 quentin.schulz@cherry.de, macromorgan@hotmail.com,
 maximmosk4@gmail.com, dsimic@manjaro.org,
 christopher.obbard@linaro.org, wens@csie.org,
 sebastian.reichel@collabora.com, FUKAUMI Naoki <naoki@radxa.com>
Subject: [PATCH 0/6] rockchip: Add DFU to boot from USB for Radxa boards
Date: Tue, 11 Feb 2025 06:13:16 +0000
Message-ID: <20250211061322.94186-1-naoki@radxa.com>
X-Mailer: git-send-email 2.43.0
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

This patch series adds the ability to boot from the USB OTG port
(dr_mode = "otg") to the Radxa boards.

Use rkflashtool[1] or rkusbboot[2] to download TPL and SPL from
MASKROM mode, and dfu-util to download U-Boot from DFU mode.

This patch series depends on patches[3] that add DFU to SPL.

[1] https://github.com/linux-rockchip/rkflashtool
[2] https://github.com/RadxaNaoki/rkusbboot
[3] https://patchwork.ozlabs.org/project/uboot/cover/20250211053340.92919-1-naoki@radxa.com/

FUKAUMI Naoki (6):
  rockchip: Add DFU to boot from USB for Radxa ROCK 5B
  rockchip: Add DFU to boot from USB for Radxa ROCK 3A
  rockchip: Add DFU to boot from USB for Radxa ROCK 3B
  rockchip: Add DFU to boot from USB for Radxa ZERO 3E/3W
  rockchip: Add DFU to boot from USB for Radxa ROCK Pi E v1/v3
  rockchip: Add DFU to boot from USB for Radxa ROCK Pi S

 arch/arm/dts/rk3328-rock-pi-e-base-u-boot.dtsi |  8 ++++++++
 configs/radxa-zero-3-rk3566_defconfig          |  9 +++++++++
 configs/rock-3a-rk3568_defconfig               | 12 ++++++++++++
 configs/rock-3b-rk3568_defconfig               |  9 +++++++++
 configs/rock-pi-e-rk3328_defconfig             | 12 ++++++++++++
 configs/rock-pi-e-v3-rk3328_defconfig          | 12 ++++++++++++
 configs/rock-pi-s-rk3308_defconfig             |  8 ++++++++
 configs/rock5b-rk3588_defconfig                |  8 ++++++++
 8 files changed, 78 insertions(+)

-- 
2.43.0

