Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C64AD30017
	for <u-boot@archiver.kernel.org>; Fri, 18 Oct 2024 14:55:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 94B0E89186;
	Fri, 18 Oct 2024 16:55:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="EYC7a8z1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D896988C4D; Fri, 18 Oct 2024 16:54:59 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 41165891B1
 for <u-boot@lists.denx.de>; Fri, 18 Oct 2024 16:54:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=conor@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 6C1725C60D8;
 Fri, 18 Oct 2024 14:54:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60BBEC4CED1;
 Fri, 18 Oct 2024 14:54:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1729263294;
 bh=ufFYFW6P+Tka174EbDeIN7p2RCenc/oeO8asRY+Gm/Q=;
 h=From:To:Cc:Subject:Date:From;
 b=EYC7a8z15qqTbhST+q7DN1LQt76DlxcVYtdb2MsR7FQA2dWaz4Yrs6c1TL6tm8uU8
 N+rnJZJzzs+ZJ31B3Zl6GFejN4hQR7uF07jrQU3MGTRkaLvV6bs3vaVmSR/NN9+ikR
 HWO5i+tsV9EiV2vah7zyXD1CSncowm9y4aTiWMNT8Q6kH8NOr5KstpnBK2hwv4H6eo
 Vn0BFaPa7GuOZgB9Uzoc6Bkst1LaPwFs89pRPUwLkWNd9nLKWifjKHhbN3xOw1vRWg
 HXYy6tFUVqjzuaKkhTL2RPU+jTuAyMjUhNpUvC6B0r/nYwgMToIB+1XZ7gHYpXob8Q
 jc9WKvuWSsGBQ==
From: Conor Dooley <conor@kernel.org>
To: u-boot@lists.denx.de
Cc: conor@kernel.org, Conor Dooley <conor.dooley@microchip.com>,
 Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>,
 Tom Rini <trini@konsulko.com>, Cyril Jean <cyril.jean@microchip.com>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Sumit Garg <sumit.garg@linaro.org>
Subject: [PATCH v1 0/3] PolarFire SoC clock devicetree rework
Date: Fri, 18 Oct 2024 15:54:41 +0100
Message-ID: <20241018145444.1660219-1-conor@kernel.org>
X-Mailer: git-send-email 2.45.2
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

From: Conor Dooley <conor.dooley@microchip.com>

Here's a U-Boot implementation of the changes I'm trying to make in
https://lore.kernel.org/all/20241002-private-unequal-33cfa6101338@spud/
that affect how the clocks are described in devicetree for PolarFire
SoC. There's been no complaints about the only part that impacts U-Boot,
so I figured it was time to send patches here.

I've implemented things here in a backwards compatible manner, so that
these changes can be applied now without the relevant devicetree
patches (since the dust has not settled on all aspects of the rework)
and the revised devicetree can make its way into U-Boot via a regular
OF_UPSTREAM update once merged "upstream".

There's minor duplication with Hal's work in patch 3, but I think that's
not particularly important, given it is the addition of a trivial
Makefile we both require:
https://lore.kernel.org/all/20240930155919.111738-1-hal.feng@starfivetech.com

Cheers,
Conor.

CC: Rick Chen <rick@andestech.com>
CC: Leo <ycliang@andestech.com>
CC: Tom Rini <trini@konsulko.com>
CC: Conor Dooley <conor.dooley@microchip.com>
CC: Cyril Jean <cyril.jean@microchip.com>
CC: Lukasz Majewski <lukma@denx.de>
CC: Sean Anderson <seanga2@gmail.com>
CC: Sumit Garg <sumit.garg@linaro.org>
CC: u-boot@lists.denx.de (open list)

Conor Dooley (3):
  clk: microchip: mpfs: support new syscon based devicetree
    configuration
  board: mpfs_icicle: imply new clk driver dependencies
  riscv: dts: mpfs: migrate to OF_UPSTREAM

 arch/riscv/dts/Makefile                    |   1 -
 arch/riscv/dts/mpfs-icicle-kit-fabric.dtsi |  71 ---
 arch/riscv/dts/mpfs-icicle-kit-u-boot.dtsi |  14 -
 arch/riscv/dts/mpfs-icicle-kit.dts         | 208 ---------
 arch/riscv/dts/mpfs.dtsi                   | 511 ---------------------
 board/microchip/mpfs_icicle/Kconfig        |   2 +
 configs/microchip_mpfs_icicle_defconfig    |   3 +-
 drivers/clk/microchip/Kconfig              |   2 +
 drivers/clk/microchip/mpfs_clk.c           |  63 ++-
 drivers/clk/microchip/mpfs_clk.h           |   5 +-
 drivers/clk/microchip/mpfs_clk_cfg.c       |  16 +-
 drivers/clk/microchip/mpfs_clk_periph.c    |  37 +-
 dts/upstream/src/riscv/Makefile            |  13 +
 13 files changed, 98 insertions(+), 848 deletions(-)
 delete mode 100644 arch/riscv/dts/mpfs-icicle-kit-fabric.dtsi
 delete mode 100644 arch/riscv/dts/mpfs-icicle-kit-u-boot.dtsi
 delete mode 100644 arch/riscv/dts/mpfs-icicle-kit.dts
 delete mode 100644 arch/riscv/dts/mpfs.dtsi
 create mode 100644 dts/upstream/src/riscv/Makefile

-- 
2.45.2

