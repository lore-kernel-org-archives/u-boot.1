Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C026DC4828F
	for <u-boot@archiver.kernel.org>; Sun,  4 Feb 2024 20:53:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C980A879BB;
	Sun,  4 Feb 2024 21:53:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="z4ln+z9V";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9EE3B879BB; Sun,  4 Feb 2024 21:53:31 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 872398796B
 for <u-boot@lists.denx.de>; Sun,  4 Feb 2024 21:53:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=cbd4=JO=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: Message-ID: Date: Subject: Cc:
 To: From; q=dns/txt; s=fe-e1b5cab7be; t=1707079997;
 bh=RUyB3lFhX4tA0xpgN7UlUwXb8EgKo/dHFZZ54qH6z0M=;
 b=z4ln+z9VkCcsJtI4H3x1+L7hytBzZ2W5W5/Hv/DNNI+Jsd3LrAALCHr3T+8EEHxqKSkyXynuQ
 1R71wxwb2X6HgwItzXHQzUhV5lsKe4/ZxkYHvjtZMijCOCadkScGp+WoOJ5wMff8rpVW3ydwDOM
 6fN2jQTHlirHMRombnIjJDZcEKy/8GjYrui0Qf3Cm9x+hNHHL3MQT8DyoflvlJUfucrdi07tbp3
 fy1Dy44IMqov6NUhY/rp/sXiDiz2PGRHbpCigA5VtGbTBTELiBy23+MyOzUe49KjmO4yOUPGSDi
 W8LllXo5LYDr5GVmF83m2HFTrh4c8IDaY0uz3BfnEpyw==
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>
Cc: Eugen Hristev <eugen.hristev@collabora.com>, Quentin Schulz
 <quentin.schulz@theobroma-systems.com>, Weizhao Ouyang
 <o451686892@gmail.com>, u-boot@lists.denx.de, Jonas Karlman
 <jonas@kwiboo.se>
Subject: [PATCH v2 0/3] rockchip: rk35xx: Fix writing to eMMC
Date: Sun,  4 Feb 2024 20:53:04 +0000
Message-ID: <20240204205312.2342868-1-jonas@kwiboo.se>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 65bff93d6f7b756870de38e5
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

Testing has shown that writing to eMMC using DDR52 mode does not seem to
work on RK356x and RK3588 boards.

This series fixes this issue by changing RK356x and RK3588 boards to
prefer use of the more reliably HS200 mode.

Changes in v2:
- Update commit messages
- Imply MMC_HS200_SUPPORT and SPL_MMC_HS200_SUPPORT in arch Kconfig
  instead of adding to each boards defconfig
- Combine changes for rk356x and rk3588 in one patch
- New patch to fix HS400 mode write on RK3568

Link to v1: https://patchwork.ozlabs.org/cover/1891692/

This series depend on the series "rockchip: rk35xx: Sync device tree
with linux v6.8-rc1" [1].

[1] https://patchwork.ozlabs.org/cover/1891669/

Jonas Karlman (3):
  rockchip: rk35xx: Remove use of eMMC DDR52 mode
  rockchip: rk35xx: Enable eMMC HS200 mode by default
  rockchip: sdhci: Fix eMMC HS400 modes for RK3568

 arch/arm/dts/rk3566-quartz64-a-u-boot.dtsi   | 1 -
 arch/arm/dts/rk3566-quartz64-b-u-boot.dtsi   | 1 -
 arch/arm/dts/rk3566-radxa-cm3-io-u-boot.dtsi | 1 -
 arch/arm/dts/rk3566-soquartz-u-boot.dtsi     | 1 -
 arch/arm/dts/rk3568-lubancat-2-u-boot.dtsi   | 1 -
 arch/arm/dts/rk3568-nanopi-r5s-u-boot.dtsi   | 1 -
 arch/arm/dts/rk3568-odroid-m1-u-boot.dtsi    | 1 -
 arch/arm/dts/rk3568-radxa-e25-u-boot.dtsi    | 1 -
 arch/arm/dts/rk3568-rock-3a-u-boot.dtsi      | 1 -
 arch/arm/dts/rk3588-rock-5b-u-boot.dtsi      | 1 -
 arch/arm/dts/rk3588-turing-rk1-u-boot.dtsi   | 1 -
 arch/arm/dts/rk3588s-rock-5a-u-boot.dtsi     | 1 -
 arch/arm/mach-rockchip/Kconfig               | 4 ++++
 configs/nanopi-r5c-rk3568_defconfig          | 2 --
 configs/nanopi-r5s-rk3568_defconfig          | 2 --
 configs/radxa-e25-rk3568_defconfig           | 2 --
 drivers/mmc/rockchip_sdhci.c                 | 9 +++++----
 17 files changed, 9 insertions(+), 22 deletions(-)

-- 
2.43.0

