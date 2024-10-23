Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6CE2CDDE49
	for <u-boot@archiver.kernel.org>; Wed, 23 Oct 2024 10:18:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C706F8929F;
	Wed, 23 Oct 2024 12:18:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="CLiKRbfd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B41608929F; Wed, 23 Oct 2024 12:18:12 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 989388924B
 for <u-boot@lists.denx.de>; Wed, 23 Oct 2024 12:18:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=conor@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 732AC5C5DF0;
 Wed, 23 Oct 2024 10:18:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FD6BC4CEC6;
 Wed, 23 Oct 2024 10:18:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1729678686;
 bh=EVtgIRZMyijL4sjdvag03HiinNQxiSkPO0WJjA0/T+Q=;
 h=From:To:Cc:Subject:Date:From;
 b=CLiKRbfdsGKNUz85Jm8MA484rJyNH0ne6oqR2KPLdvWuzT0fwzF+rwRENyBvBl3jz
 cfrpAmvh3kGNuiRuTpEsQsV3i7MGZS9kv8/LAMSUJck6TSJu4o9s4XBo62g5Tou/86
 Kt/poCsK0t/6ebDqkR4xzHpfSF9P/uQmiD806ZvUlN4kpJIgpTlUd3i9oNslwai1Xv
 9l6KuqYU2T9OLTmHUcv3TNRcre25ZuZds9axNtY/wXtIK/rQjPuxXYfcIxTLYIQZ3p
 rQDACYCTXIsvega0EjJaWOl6siLuOLGCsUZ+ANSkNEwZt5750TVtXRt+Bokwm8juo+
 vz48d5N6fJkYA==
From: Conor Dooley <conor@kernel.org>
To: u-boot@lists.denx.de
Cc: conor@kernel.org, Conor Dooley <conor.dooley@microchip.com>,
 Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>,
 Tom Rini <trini@konsulko.com>, Cyril Jean <cyril.jean@microchip.com>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Sumit Garg <sumit.garg@linaro.org>
Subject: [PATCH v2 0/3] PolarFire SoC clock devicetree rework
Date: Wed, 23 Oct 2024 11:17:51 +0100
Message-ID: <20241023101754.4021948-1-conor@kernel.org>
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

~There's minor duplication with Hal's work in patch 3, but I think that's~
~not particularly important, given it is the addition of a trivial~
~Makefile we both require:~
~https://lore.kernel.org/all/20240930155919.111738-1-hal.feng@starfivetech.com~

In v2, I rebased on top of master as Sumit suggested to pick up the
movement of some dts Makefile, so while there's still a bit of
duplication, what's here is "better" than what's linked above.

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
CC: u-boot@lists.denx.de

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
 configs/microchip_mpfs_icicle_defconfig    |   4 +-
 drivers/clk/microchip/Kconfig              |   2 +
 drivers/clk/microchip/mpfs_clk.c           |  63 ++-
 drivers/clk/microchip/mpfs_clk.h           |   5 +-
 drivers/clk/microchip/mpfs_clk_cfg.c       |  16 +-
 drivers/clk/microchip/mpfs_clk_periph.c    |  37 +-
 dts/upstream/src/riscv/Makefile            |   6 +
 13 files changed, 91 insertions(+), 849 deletions(-)
 delete mode 100644 arch/riscv/dts/mpfs-icicle-kit-fabric.dtsi
 delete mode 100644 arch/riscv/dts/mpfs-icicle-kit-u-boot.dtsi
 delete mode 100644 arch/riscv/dts/mpfs-icicle-kit.dts
 delete mode 100644 arch/riscv/dts/mpfs.dtsi
 create mode 100644 dts/upstream/src/riscv/Makefile

-- 
2.45.2

