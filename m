Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7667CCCD195
	for <u-boot@archiver.kernel.org>; Sun, 19 Oct 2025 20:59:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B579082991;
	Sun, 19 Oct 2025 22:59:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="yuhc7zqF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6F11B82B20; Sun, 19 Oct 2025 22:59:01 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B980A807C0
 for <u-boot@lists.denx.de>; Sun, 19 Oct 2025 22:58:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=ad34=45=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: Message-ID: Date: Subject: Cc:
 To: From; q=dns/txt; s=fe-e1b5cab7be; t=1760907537;
 bh=YMs77t6+tw+cSak4Sk+fbIC2sQrv0SNjGN41VmVCTVM=;
 b=yuhc7zqFUIWFJwfTN7041gY6Bs0qJD0NO6kX9e8UeSlmOB+QEavNReRgyI5UzwNIu8iGBF6sG
 xkpXaYla7kezyZhOQSg9B5lk1oVjSRFiBhLvr1uFvKvobPq/UEz+YNZg9P7oV7pdLBFqgIMAN3d
 Xif6u/2R3xXXLmfes6eUpFrOya3VkxpEFa7vKUmuiBfFmtJH428vxKgA/ud42SAVK1zquZA3nfl
 JuCrjy+aOsUdJYjY5xZDBi9iHIUKknNIGPHrixILso3abi9jzh2UdnDGyzUcD6Qr0X7Z2RSuG8W
 XabOUNLEMIIAxcAG5HFTsq+tlLT7MmfGDjiUS6S3/YDw==
X-Forward-Email-ID: 68f5510e762a7c0ff99ef01f
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-Forward-Email-Version: 1.3.0
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: Yao Zi <ziyao@disroot.org>, Chukun Pan <amadeus@jmu.edu.cn>,
 u-boot@lists.denx.de, Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH 0/4] board: rockchip: Add Radxa ROCK 2A/2F and ArmSoM Sige1
Date: Sun, 19 Oct 2025 20:58:35 +0000
Message-ID: <20251019205849.954736-1-jonas@kwiboo.se>
X-Mailer: git-send-email 2.51.0
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

This series add support for the Radxa ROCK 2A/2F and ArmSoM Sige1 RK3528
boards. Initial DTs for these boards was merged in Linux v6.18-rc1.

Some Kconfig options has been enabled to support future features, e.g.
USB, once pending DT changes finally lands in dts/upstream.

Features tested on a ROCK 2A v1.202:
- SD-card boot
- Ethernet
- USB host (with pending DT changes)

Features tested on a ROCK 2F v1.016:
- SD-card boot
- eMMC boot
- USB host (with pending DT changes)

Features tested on a ArmSoM Sige1 v1.1:
- SD-card boot
- eMMC boot
- Ethernet
- USB host (with pending DT changes)

For fully working eMMC write support the patch "mmc: rockchip_sdhci: Set
xx_TAP_VALUE for RK3528" [1] should be applied.

This series depends on the patch "rockchip: rk3528-radxa-e20c: Drop eMMC
HS200 prop from board u-boot.dtsi" [2] for a clean apply.

[1] https://patchwork.ozlabs.org/patch/2111059/
[2] https://patchwork.ozlabs.org/patch/2152778/

Jonas Karlman (4):
  arm64: dts: rockchip: Add Radxa ROCK 2A/2F
  board: rockchip: Add Radxa ROCK 2A/2F
  arm64: dts: rockchip: Add ArmSoM Sige1
  board: rockchip: Add ArmSoM Sige1

 arch/arm/dts/rk3528-armsom-sige1-u-boot.dtsi  |  11 +
 arch/arm/dts/rk3528-radxa-e20c-u-boot.dtsi    |   5 +
 arch/arm/dts/rk3528-rock-2-u-boot.dtsi        |  16 +
 arch/arm/dts/rk3528-rock-2a-u-boot.dtsi       |   3 +
 arch/arm/dts/rk3528-rock-2f-u-boot.dtsi       |   3 +
 arch/arm/mach-rockchip/rk3528/Kconfig         |   7 +
 arch/arm/mach-rockchip/rk3528/MAINTAINERS     |   6 +
 board/radxa/rock-2-rk3528/Kconfig             |  14 +
 board/radxa/rock-2-rk3528/MAINTAINERS         |   6 +
 board/radxa/rock-2-rk3528/Makefile            |   3 +
 board/radxa/rock-2-rk3528/rock-2-rk3528.c     |  60 +++
 configs/radxa-e20c-rk3528_defconfig           |   3 +
 configs/rock-2-rk3528_defconfig               |  68 +++
 configs/sige1-rk3528_defconfig                |  64 +++
 doc/board/rockchip/rockchip.rst               |   2 +
 .../arm64/rockchip/rk3528-armsom-sige1.dts    | 464 ++++++++++++++++++
 .../src/arm64/rockchip/rk3528-rock-2.dtsi     | 293 +++++++++++
 .../src/arm64/rockchip/rk3528-rock-2a.dts     |  82 ++++
 .../src/arm64/rockchip/rk3528-rock-2f.dts     |  10 +
 19 files changed, 1120 insertions(+)
 create mode 100644 arch/arm/dts/rk3528-armsom-sige1-u-boot.dtsi
 create mode 100644 arch/arm/dts/rk3528-rock-2-u-boot.dtsi
 create mode 100644 arch/arm/dts/rk3528-rock-2a-u-boot.dtsi
 create mode 100644 arch/arm/dts/rk3528-rock-2f-u-boot.dtsi
 create mode 100644 board/radxa/rock-2-rk3528/Kconfig
 create mode 100644 board/radxa/rock-2-rk3528/MAINTAINERS
 create mode 100644 board/radxa/rock-2-rk3528/Makefile
 create mode 100644 board/radxa/rock-2-rk3528/rock-2-rk3528.c
 create mode 100644 configs/rock-2-rk3528_defconfig
 create mode 100644 configs/sige1-rk3528_defconfig
 create mode 100644 dts/upstream/src/arm64/rockchip/rk3528-armsom-sige1.dts
 create mode 100644 dts/upstream/src/arm64/rockchip/rk3528-rock-2.dtsi
 create mode 100644 dts/upstream/src/arm64/rockchip/rk3528-rock-2a.dts
 create mode 100644 dts/upstream/src/arm64/rockchip/rk3528-rock-2f.dts

-- 
2.51.0

