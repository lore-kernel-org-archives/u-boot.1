Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E670CD4F5E
	for <u-boot@archiver.kernel.org>; Wed, 20 May 2026 06:05:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3205B8467A;
	Wed, 20 May 2026 08:05:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none) header.from=superkali.me
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=superkali.me header.i=@superkali.me header.b="Qtgz43Cx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 563C38469D; Wed, 20 May 2026 08:05:34 +0200 (CEST)
Received: from fr5000-r.dnsiaas.com (fr5000-r.dnsiaas.com [92.42.104.18])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B1221843B6
 for <u-boot@lists.denx.de>; Wed, 20 May 2026 08:05:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=superkali.me
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=hello@superkali.me
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=superkali.me; s=default; h=Cc:To:Content-Transfer-Encoding:Content-Type:
 MIME-Version:Message-Id:Date:Subject:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=+aMEcEmSYyRjK8WoS1tW02cCUIP7bYOYmCzCAEXydzM=; b=Qtgz43CxWb1Pfp8UL7hmu1cYeU
 q+CSVQ/FAF6aD2LRVfazoIANUcf+6mVhMX0Zsrn+4isOmoCOwpFGGoguVXaUU0NjNGYKi/YSroJNU
 C7LRoWEMgYWnxnWBnxtrm9cJzX8hekvVxoGhXySMYzZRdTzrjjmzd7OvAYEEUJuvKSU6wKHOl/L/y
 rx4CLJHIlXcDPwKP4w46QmZ18G0t56a6mFZEOTrpJnLouI/GvF68XpCgy/wiwEjcJiDgkg7Ysr4Yu
 wSMv+mKSfuxKMLEFXXZTSDGSqZDoo3spLOpm63b+T8gKkzvinG8VRMccz2VqJB+8m0rR6KNqgkYtQ
 fFgRE9Pw==;
Received: from [81.57.40.39] (port=50682 helo=vscode.iliadbox.lan)
 by fr5000-r.dnsiaas.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.99.2) (envelope-from <hello@superkali.me>)
 id 1wPa3f-0000000DuY3-2rlQ; Wed, 20 May 2026 08:05:29 +0200
From: Daniele Briguglio <hello@superkali.me>
Subject: [PATCH v3 0/4] rockchip: PCIe gated reference clock support
Date: Wed, 20 May 2026 08:05:26 +0200
Message-Id: <20260520-rock-5-itx-pcie-refclk-dtsi-v3-0-58f2cea72030@superkali.me>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACZPDWoC/32Nyw6CMBBFf4V07RhahKIr/8OwKO0gI8+0hWAI/
 27BuHV5cm/OWZlDS+jYLVqZxZkcDX2A5BQxXav+iUAmMBOxyOKU52AH3UAK5BcYNSFYrHTbgPG
 OgEtlLqXgpuKGBcMYRloO+6P4spvKF2q/K/dHTc4P9n3kZ7H/fqXr39IsIAaZ5GUm81Rqpe9uG
 tE2qqVzh6zYtu0DPUTIsNsAAAA=
X-Change-ID: 20260518-rock-5-itx-pcie-refclk-dtsi-17ad4b21df1d
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>, 
 David Lechner <dlechner@baylibre.com>, 
 Julien Stephan <jstephan@baylibre.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Peng Fan <peng.fan@nxp.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Philip Molloy <philip.molloy@analog.com>, 
 Sean Anderson <sean.anderson@linux.dev>, 
 Richard Genoud <richard.genoud@bootlin.com>, Simon Glass <sjg@chromium.org>, 
 Peter Korsgaard <peter@korsgaard.com>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 Kever Yang <kever.yang@rock-chips.com>, 
 Daniele Briguglio <hello@superkali.me>, Jonas Karlman <jonas@kwiboo.se>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779257127; l=4265;
 i=hello@superkali.me; h=from:subject:message-id;
 bh=ogJ/c9KCbQHmDEYvc9oKyVVNsPsSDCwV0gqK8lHR/xE=;
 b=JHnDu/2A7xWc5+x/2vRwankaaAwmm2iAV4MJrJhQ0PyBxg4LEQPc87UHkqro09Bz/0fyxn7/l
 X+qdigMjmcYALSNwheVfqa4uyS0QEuLqNydSXXztLJYVwOouVmO0xOn
X-Developer-Key: i=hello@superkali.me; a=ed25519;
 pk=5tynRWQdL93CDcapJ73FkcCRY2PeBOJOIAoIhRig53U=
X-AntiAbuse: This header was added to track abuse,
 please include it with any abuse report
X-AntiAbuse: Primary Hostname - fr5000-r.dnsiaas.com
X-AntiAbuse: Original Domain - lists.denx.de
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - superkali.me
X-Get-Message-Sender-Via: fr5000-r.dnsiaas.com: authenticated_id:
 hello@superkali.me
X-Authenticated-Sender: fr5000-r.dnsiaas.com: hello@superkali.me
X-Source: 
X-Source-Args: 
X-Source-Dir: 
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

The rk3588-rock-5-itx u-boot dtsi describes the PCIe reference
clocks (pcie30x4_refclk, pcie30x2_refclk on the M.2 M-key slots)
as "gated-fixed-clock" instances supplied by regulators.  Drive
those refclks from u-boot so the PCIe PHY can lock its PLL.

v1 [1] worked around the lack of a "gated-fixed-clock" driver in
u-boot by dropping the refclk references from pcie3x4/pcie3x2 in
a board-local dtsi override.  Jonas pointed out that the u-boot
dtsi is propagated to the OS via EFI handoff, making the dtsi
override approach brittle.

v2 [2] added a proper UCLASS_CLK driver for "gated-fixed-clock"
and enabled it in the rock-5-itx defconfig.  Jonas tested v2 on a
radxa rock-3b (RK3568) and surfaced:

  - an ordering bug in pcie_dw_rockchip: clk_enable_bulk() runs
    after generic_phy_init() and generic_phy_power_on(), so the
    PHY tries to lock its PLL before the gated refclk is
    enabled.  On boards where the refclk supply is
    regulator-always-on (the universal pattern in the in-tree
    DTs) this is masked; on rock-3b the PI6C supply is gated and
    the PHY init times out.
  - two stray clk_release_bulk() calls.  clk_release_bulk() is
    not a memory release (the bulk array is devm-allocated); it
    loops clk_disable() over the bulk.  In parse_dt() the clocks
    are acquired but never enabled, so the call disables clocks
    that are off.  In probe() after init_port() failure the
    inner err_disable_clks path balances the enable, so the
    outer call is a double-disable.  With the new gated-fixed-
    clock driver both cases desync the regulator enable_count,
    which on rock-5-itx with one M.2 populated would pull power
    from the populated slot when the empty one fails.

v3 keeps the v2 driver (plus the MAINTAINERS entry I forgot in
v2), fixes pcie_dw_rockchip, and switches the per-board defconfig
knob to a Kconfig imply so other boards pick up the driver
automatically as their DTs move to the binding.

Changes since v2:
  - patch 1: add MAINTAINERS entry for drivers/clk/clk-gated-fixed.c
  - new patch 2: pci: pcie_dw_rockchip: enable clocks before PHY init
  - new patch 3: pci: pcie_dw_rockchip: drop clk_release_bulk calls
  - new patch 4: pci: pcie_dw_rockchip: imply CLK_GATED_FIXED and
    switch PHY to imply
  - dropped the rock-5-itx defconfig patch (Kconfig imply pulls
    CLK_GATED_FIXED in automatically)

Testing:
  - patch 1 validated end-to-end on a NanoPC T6 LTS via the
    synthetic-DT approach Jonas suggested: a fake
    "gated-fixed-clock" node with a fake "regulator-fixed" supply
    injected into the board's u-boot dtsi and wired as an
    additional "ref" clock of pcie3x4.  Probe and enable trigger
    when pcie_dw_rockchip runs clk_enable_bulk, and NVMe
    enumerates through the synthetic refclk path.
  - patches 2 and 3 reported and validated by Jonas on radxa
    rock-3b (RK3568) where the PI6C refclk supply is gated and
    the regulator enable_count must stay balanced.
  - I don't have free access to a rock-5-itx at the moment (the
    one I maintain serves a production mirror), so v3 has been
    build-tested only on the real target.

[1] https://lore.kernel.org/u-boot/20260518-rock-5-itx-pcie-refclk-dtsi-v1-1-faf8626039fc@superkali.me/
[2] https://lore.kernel.org/u-boot/20260519-rock-5-itx-pcie-refclk-dtsi-v2-0-738b67857cac@superkali.me/

Signed-off-by: Daniele Briguglio <hello@superkali.me>
---
Daniele Briguglio (4):
      clk: add gated-fixed-clock driver
      pci: pcie_dw_rockchip: enable clocks before PHY init
      pci: pcie_dw_rockchip: drop clk_release_bulk calls
      pci: pcie_dw_rockchip: imply CLK_GATED_FIXED and switch PHY to imply

 MAINTAINERS                    |  5 +++
 drivers/clk/Kconfig            |  9 +++++
 drivers/clk/Makefile           |  1 +
 drivers/clk/clk-gated-fixed.c  | 84 ++++++++++++++++++++++++++++++++++++++++++
 drivers/pci/Kconfig            |  3 +-
 drivers/pci/pcie_dw_rockchip.c | 23 ++++++------
 6 files changed, 112 insertions(+), 13 deletions(-)
---
base-commit: 38dbe637c9dfcadbd1bc201bfbb27f96b2ad525a
change-id: 20260518-rock-5-itx-pcie-refclk-dtsi-17ad4b21df1d

Best regards,
--  
Daniele Briguglio <hello@superkali.me>

