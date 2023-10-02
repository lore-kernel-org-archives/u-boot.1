Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5770CE784AF
	for <u-boot@archiver.kernel.org>; Mon,  2 Oct 2023 10:48:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 771C7870DC;
	Mon,  2 Oct 2023 12:48:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="lqhbRtya";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="AtwNLv7x";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 453AE870DF; Mon,  2 Oct 2023 12:48:10 +0200 (CEST)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org
 [IPv6:2001:67c:2050:0:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 92B58870D3
 for <u-boot@lists.denx.de>; Mon,  2 Oct 2023 12:48:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4Rzd2v3L7Gz9sT1;
 Mon,  2 Oct 2023 12:48:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1696243687;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=oT07T54AlEN9nLho8KlfPmOGqqbJRx1B/RfoGAbKXok=;
 b=lqhbRtyaz5Ff3dNaxqSUBIW1NSSXF1hJ3KwhoFOwGBsHGKoQyv1djwKEr1AbkhUzIpznVX
 EBZgO7yRcIaTs3di/ZUrdp2hrcdGKVq7ArKlOj3amqUBxxoCHSO5fSO+P0ogRO/yv731zi
 gbwg0chEbQLkaZbNCH0gMPtJf1++XMq06WcYj794tjjdiv2wpLGzH7JGQnt3Ysr8M7yWO8
 N/cvUIHJEB6HxXJ7tE4xp5VfIfWM4nhpWzeWtLABll+kDCe4mgjqQut/UpbslAmo+IoPUg
 Di0/vgRK9ewuwvtDPYWIk5bwR49uWub+I+rBZqJDdb9M5rRV+QCk09fjeQzfSA==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1696243685;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=oT07T54AlEN9nLho8KlfPmOGqqbJRx1B/RfoGAbKXok=;
 b=AtwNLv7xXrqmi6jnezyx6Z6iwJ+X6kpegpspiTF9xVJuCdXxGvdC52m+9Ia0YHZ07QgB80
 f7O8YHsni6BDiUSA1mf1JkaxkInU8p/gq6S8+bC2Vg8wkGQiaqQKPQ4wVTo1grq/2cUPvv
 ry2UaDk53xfXGxYsLiXxjm1kbq0IxzVC4bF1xENFcGRa8BUYgDbcBwQeC16JOnG2+UV/fr
 ERrPRtbVP+TibeZAEKJQCpNtTz12VlzUP3bKkrJqqChSz/xOutUcaKMl4unT8Lb2jeSFXM
 SAvoCFb58ze5mXVhmD7TbDet0K9lDzkZDHgEQ6eY/Xx0jI38+fKknRkcl0hDNQ==
To: u-boot@lists.denx.de,
	Tom Rini <trini@konsulko.com>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: [PULL] u-boot-sh/next_pinctrl_sync
Date: Mon,  2 Oct 2023 12:47:56 +0200
Message-Id: <20231002104756.6132-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: d8d9f9fb0ee3f624aad
X-MBO-RS-META: u69md5mtp45ojd9pi48qn344aq5gpzd5
X-Rspamd-Queue-Id: 4Rzd2v3L7Gz9sT1
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

The following changes since commit 90c81f407dd4a7747385b10f9b8f732202c45cde:

  Merge tag 'dm-next-23sep23' of https://source.denx.de/u-boot/custodians/u-boot-dm into next (2023-09-24 12:43:00 -0400)

are available in the Git repository at:

  https://source.denx.de/u-boot/custodians/u-boot-sh.git next_pinctrl_sync

for you to fetch changes up to 30c210b9bee474d3ca5803f866ed07a6bac56fd4:

  ARM: renesas: Align env eMMC device number with Linux 6.5.3 DT changes on R-Car Gen3 Salvator-X (2023-10-01 00:08:29 +0200)

----------------------------------------------------------------
Marek Vasut (60):
      ARM: dts: renesas: Add compatible properties to KSZ9031 Ethernet PHYs on Salvator-X boards
      ARM: renesas: Enable DM_ETH_PHY on 64-bit R-Car boards
      pinctrl: renesas: Rename R8A7795 H3 PFC tables file name to R8A77951
      pinctrl: renesas: Rename RZ/A1 R7S72100 PFC tables to RZ/A1
      pinctrl: renesas: Drop R8A77950 H3 ES1.x PFC table entry
      pinctrl: renesas: Add support for 1.8V/2.5V I/O voltage levels
      pinctrl: renesas: Synchronize R8A7790 H2 PFC tables with Linux 6.5.3
      pinctrl: renesas: Synchronize R8A7791 M2-W and R8A7793 M2-N PFC tables with Linux 6.5.3
      pinctrl: renesas: Synchronize R8A7792 V2H PFC tables with Linux 6.5.3
      pinctrl: renesas: Synchronize R8A7794 E2 PFC tables with Linux 6.5.3
      pinctrl: renesas: Synchronize R8A77951 H3 PFC tables with Linux 6.5.3
      pinctrl: renesas: Synchronize R8A77960 M3-W and R8A77961 M3-W+ PFC tables with Linux 6.5.3
      pinctrl: renesas: Synchronize R8A77965 M3-N PFC tables with Linux 6.5.3
      pinctrl: renesas: Synchronize R8A77970 V3M PFC tables with Linux 6.5.3
      pinctrl: renesas: Synchronize R8A77980 V3H PFC tables with Linux 6.5.3
      pinctrl: renesas: Synchronize R8A77990 E3 PFC tables with Linux 6.5.3
      pinctrl: renesas: Synchronize R8A77995 D3 PFC tables with Linux 6.5.3
      pinctrl: renesas: Synchronize R8A779A0 V3U PFC tables with Linux 6.5.3
      pinctrl: renesas: Synchronize R8A779F0 S4 PFC tables with Linux 6.5.3
      pinctrl: renesas: Synchronize R8A779G0 V4H PFC tables with Linux 6.5.3
      linux/compat.h: Define empty __initconst and __initdata
      clk: renesas: Synchronize R8A77951 H3 DT headers with Linux 6.5.3
      clk: renesas: Synchronize R8A779F0 S4 DT headers with Linux 6.5.3
      clk: renesas: Synchronize R8A7790 H2 clock tables with Linux 6.5.3
      clk: renesas: Synchronize R8A7791 M2-W and R8A7793 M2-N clock tables with Linux 6.5.3
      clk: renesas: Synchronize R8A7792 V2H clock tables with Linux 6.5.3
      clk: renesas: Synchronize R8A7794 E2 clock tables with Linux 6.5.3
      clk: renesas: Synchronize R8A77951 H3 clock tables with Linux 6.5.3
      clk: renesas: Synchronize R8A77960 M3-W and R8A77961 M3-W+ clock tables with Linux 6.5.3
      clk: renesas: Synchronize R8A77965 M3-N clock tables with Linux 6.5.3
      clk: renesas: Synchronize R8A77970 V3M clock tables with Linux 6.5.3
      clk: renesas: Synchronize R8A77980 V3H clock tables with Linux 6.5.3
      clk: renesas: Synchronize R8A77990 E3 clock tables with Linux 6.5.3
      clk: renesas: Synchronize R8A77995 D3 clock tables with Linux 6.5.3
      clk: renesas: Synchronize R8A779A0 V3U clock tables with Linux 6.5.3
      clk: renesas: Synchronize R8A779F0 S4 clock tables with Linux 6.5.3
      clk: renesas: Synchronize R8A779G0 V4H clock tables with Linux 6.5.3
      clk: renesas: Synchronize R8A774A1 RZ/G2M clock tables with Linux 6.5.3
      clk: renesas: Synchronize R8A774B1 RZ/G2N clock tables with Linux 6.5.3
      clk: renesas: Synchronize R8A774C0 RZ/G2E clock tables with Linux 6.5.3
      clk: renesas: Synchronize R8A774E1 RZ/G2H clock tables with Linux 6.5.3
      ARM: dts: renesas: Synchronize R-Car R8A7790 H2 DTs with Linux 6.5.3
      ARM: dts: renesas: Synchronize R-Car R8A7791 M2-W and R8A7793 M2-N DTs with Linux 6.5.3
      ARM: dts: renesas: Synchronize R-Car R8A7794 E2 DTs with Linux 6.5.3
      ARM: dts: renesas: Synchronize R-Car R8A77951 H3 DTs with Linux 6.5.3
      ARM: dts: renesas: Synchronize R-Car R8A77960 M3-W and R8A77961 M3-W+ DTs with Linux 6.5.3
      ARM: dts: renesas: Synchronize R-Car R8A77965 M3-N DTs with Linux 6.5.3
      ARM: dts: renesas: Synchronize R-Car R8A77970 V3M DTs with Linux 6.5.3
      ARM: dts: renesas: Synchronize R-Car R8A77980 V3H DTs with Linux 6.5.3
      ARM: dts: renesas: Synchronize R-Car R8A77990 E3 DTs with Linux 6.5.3
      ARM: dts: renesas: Synchronize R-Car R8A77995 D3 DTs with Linux 6.5.3
      ARM: dts: renesas: Synchronize R-Car R8A779A0 E3 DTs with Linux 6.5.3
      ARM: dts: renesas: Synchronize R-Car R8A779F0 S4 DTs with Linux 6.5.3
      ARM: dts: renesas: Synchronize R-Car R8A779G0 V4H DTs with Linux 6.5.3
      ARM: dts: renesas: Synchronize RZ R7S72100 RZ/A1 DTs with Linux 6.5.3
      ARM: dts: renesas: Synchronize RZ R8A774A1 RZ/G2M DTs with Linux 6.5.3
      ARM: dts: renesas: Synchronize RZ R8A774B1 RZ/G2N DTs with Linux 6.5.3
      ARM: dts: renesas: Synchronize RZ R8A774C0 RZ/G2E DTs with Linux 6.5.3
      ARM: dts: renesas: Synchronize RZ R8A774E1 RZ/G2H DTs with Linux 6.5.3
      ARM: renesas: Align env eMMC device number with Linux 6.5.3 DT changes on R-Car Gen3 Salvator-X

 arch/arm/dts/beacon-renesom-baseboard.dtsi         |   45 +-
 arch/arm/dts/beacon-renesom-som.dtsi               |    2 +-
 arch/arm/dts/condor-common.dtsi                    |    1 +
 arch/arm/dts/hihope-common.dtsi                    |   21 +-
 arch/arm/dts/r7s72100-gr-peach.dts                 |    3 +
 arch/arm/dts/r7s72100.dtsi                         |   56 +-
 arch/arm/dts/r8a774a1-beacon-rzg2m-kit.dts         |   21 -
 arch/arm/dts/r8a774a1-u-boot.dtsi                  |    1 -
 arch/arm/dts/r8a774a1.dtsi                         |   14 +-
 arch/arm/dts/r8a774b1-beacon-rzg2n-kit.dts         |   29 +-
 arch/arm/dts/r8a774b1-u-boot.dtsi                  |    1 -
 arch/arm/dts/r8a774b1.dtsi                         |   14 +-
 arch/arm/dts/r8a774c0.dtsi                         |   11 +-
 arch/arm/dts/r8a774e1-beacon-rzg2h-kit.dts         |   29 +-
 arch/arm/dts/r8a774e1-u-boot.dtsi                  |    1 -
 arch/arm/dts/r8a774e1.dtsi                         |   14 +-
 arch/arm/dts/r8a7790.dtsi                          |   85 +-
 arch/arm/dts/r8a7791.dtsi                          |    4 +-
 arch/arm/dts/r8a7793.dtsi                          |    4 +-
 arch/arm/dts/r8a7794.dtsi                          |    2 +-
 arch/arm/dts/r8a77951.dtsi                         |   15 +-
 arch/arm/dts/r8a77960.dtsi                         |   16 +-
 arch/arm/dts/r8a77965.dtsi                         |   16 +-
 arch/arm/dts/r8a77970-eagle.dts                    |   12 +
 arch/arm/dts/r8a77980-condor.dts                   |    8 +
 arch/arm/dts/r8a77980-v3hsk.dts                    |    1 +
 arch/arm/dts/r8a77980.dtsi                         |    5 +-
 arch/arm/dts/r8a77990.dtsi                         |   11 +-
 arch/arm/dts/r8a77995.dtsi                         |    2 +-
 arch/arm/dts/r8a779a0-falcon-csi-dsi.dtsi          |    5 +
 arch/arm/dts/r8a779a0-falcon.dts                   |   11 +-
 arch/arm/dts/r8a779a0.dtsi                         |  110 +-
 arch/arm/dts/r8a779f0.dtsi                         |   25 +-
 arch/arm/dts/r8a779g0-white-hawk-csi-dsi.dtsi      |  172 +++
 arch/arm/dts/r8a779g0-white-hawk.dts               |   44 +
 arch/arm/dts/r8a779g0.dtsi                         | 1006 +++++++++++++++++-
 arch/arm/dts/salvator-common.dtsi                  |  255 ++++-
 arch/arm/dts/salvator-xs.dtsi                      |   56 +
 arch/arm/dts/ulcb-audio-graph-card.dtsi            |   85 ++
 arch/arm/dts/ulcb-audio-graph-card2.dtsi           |   26 +
 arch/arm/dts/ulcb.dtsi                             |   74 +-
 configs/r8a77970_eagle_defconfig                   |    1 +
 configs/r8a77970_v3msk_defconfig                   |    1 +
 configs/r8a77980_condor_defconfig                  |    1 +
 configs/r8a77980_v3hsk_defconfig                   |    1 +
 configs/r8a77990_ebisu_defconfig                   |    1 +
 configs/r8a77995_draak_defconfig                   |    1 +
 configs/r8a779a0_falcon_defconfig                  |    1 +
 configs/r8a779g0_whitehawk_defconfig               |    1 +
 configs/rcar3_salvator-x_defconfig                 |    2 +-
 configs/rcar3_ulcb_defconfig                       |    1 +
 drivers/clk/renesas/r8a774a1-cpg-mssr.c            |    6 +-
 drivers/clk/renesas/r8a774b1-cpg-mssr.c            |    6 +-
 drivers/clk/renesas/r8a774c0-cpg-mssr.c            |    6 +-
 drivers/clk/renesas/r8a774e1-cpg-mssr.c            |    6 +-
 drivers/clk/renesas/r8a7790-cpg-mssr.c             |    6 +-
 drivers/clk/renesas/r8a7791-cpg-mssr.c             |   11 +-
 drivers/clk/renesas/r8a7792-cpg-mssr.c             |    6 +-
 drivers/clk/renesas/r8a7794-cpg-mssr.c             |    6 +-
 drivers/clk/renesas/r8a7795-cpg-mssr.c             |   16 +-
 drivers/clk/renesas/r8a7796-cpg-mssr.c             |    6 +-
 drivers/clk/renesas/r8a77965-cpg-mssr.c            |    6 +-
 drivers/clk/renesas/r8a77970-cpg-mssr.c            |   18 +-
 drivers/clk/renesas/r8a77980-cpg-mssr.c            |   24 +-
 drivers/clk/renesas/r8a77990-cpg-mssr.c            |    6 +-
 drivers/clk/renesas/r8a77995-cpg-mssr.c            |    8 +-
 drivers/clk/renesas/r8a779a0-cpg-mssr.c            |    9 +-
 drivers/clk/renesas/r8a779f0-cpg-mssr.c            |    4 +-
 drivers/clk/renesas/r8a779g0-cpg-mssr.c            |   28 +-
 drivers/pinctrl/renesas/Kconfig                    |    2 +-
 drivers/pinctrl/renesas/Makefile                   |    6 +-
 drivers/pinctrl/renesas/pfc-r8a7790.c              |    4 +-
 drivers/pinctrl/renesas/pfc-r8a7791.c              |    6 +-
 drivers/pinctrl/renesas/pfc-r8a7792.c              |    2 +-
 drivers/pinctrl/renesas/pfc-r8a7794.c              |   50 +-
 .../renesas/{pfc-r8a7795.c => pfc-r8a77951.c}      |   12 +-
 drivers/pinctrl/renesas/pfc-r8a7796.c              |   12 +-
 drivers/pinctrl/renesas/pfc-r8a77965.c             |   12 +-
 drivers/pinctrl/renesas/pfc-r8a77970.c             |   40 +-
 drivers/pinctrl/renesas/pfc-r8a77980.c             |   55 +-
 drivers/pinctrl/renesas/pfc-r8a77990.c             |   41 +-
 drivers/pinctrl/renesas/pfc-r8a77995.c             |   46 +-
 drivers/pinctrl/renesas/pfc-r8a779a0.c             |    8 +-
 drivers/pinctrl/renesas/pfc-r8a779f0.c             |   10 +-
 drivers/pinctrl/renesas/pfc-r8a779g0.c             | 1095 +++++++++++---------
 drivers/pinctrl/renesas/pfc.c                      |    9 +-
 .../renesas/{pfc-r7s72100.c => pinctrl-rza1.c}     |    0
 drivers/pinctrl/renesas/sh_pfc.h                   |   17 +-
 include/dt-bindings/clock/r8a779f0-cpg-mssr.h      |    2 +-
 include/dt-bindings/power/r8a7795-sysc.h           |    1 -
 include/dt-bindings/power/r8a779f0-sysc.h          |    2 +-
 include/linux/compat.h                             |    2 +
 92 files changed, 2914 insertions(+), 1022 deletions(-)
 create mode 100644 arch/arm/dts/ulcb-audio-graph-card.dtsi
 create mode 100644 arch/arm/dts/ulcb-audio-graph-card2.dtsi
 rename drivers/pinctrl/renesas/{pfc-r8a7795.c => pfc-r8a77951.c} (99%)
 rename drivers/pinctrl/renesas/{pfc-r7s72100.c => pinctrl-rza1.c} (100%)
