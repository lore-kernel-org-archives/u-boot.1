Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60A75CAC5AA
	for <u-boot@archiver.kernel.org>; Thu, 25 Sep 2025 05:33:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9814D8362C;
	Thu, 25 Sep 2025 07:33:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=freeshell.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id CB4A1836A3; Thu, 25 Sep 2025 07:33:17 +0200 (CEST)
Received: from freeshell.de (freeshell.de [116.202.128.144])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D2DFD835C9
 for <u-boot@lists.denx.de>; Thu, 25 Sep 2025 07:33:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=freeshell.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=e@freeshell.de
Received: from hay.lan (unknown [IPv6:2605:59c0:2078:cf00:6ecf:39ff:fe00:8375])
 (Authenticated sender: e)
 by freeshell.de (Postfix) with ESMTPSA id 47126B220123;
 Thu, 25 Sep 2025 07:33:14 +0200 (CEST)
From: E Shattow <e@freeshell.de>
To: Minda Chen <minda.chen@starfivetech.com>,
 Hal Feng <hal.feng@starfivetech.com>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de,
	E Shattow <e@freeshell.de>
Subject: [RFC v1 0/4] Add upstream boards Milk-V Mars CM and Mars CM Lite
Date: Wed, 24 Sep 2025 22:32:04 -0700
Message-ID: <20250925053233.1874027-1-e@freeshell.de>
X-Mailer: git-send-email 2.50.0
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

Milk-V Mars CM and Mars CM Lite SoM's were formerly supported v2024.07 to
v2025.01 and then absent since the OF_UPSTREAM transition of starfive
visionfive2 multi-board support. Upstream patches are now queued up for the
next merge window to Linux v6.18, so let's re-introduce support for these
boards.

Sorting of OF_LIST is kept consistent with `LANG=C sort`, and callbacks in
SPL for dts selection are ordered the same. Logic for setting fdtfile env
variable corresponds with the sorting of OF_LIST and not the representative
EEPROM value comparisons.

This series does violate some norms as it modifies the dts/upstream tree,
and generally is introducing as upstream something which is not quite yet
stable or release candidate in upstream devicetree-rebasing. RFC patches
sent this way for review would benefit from not modifying dts/upstream
tree at all but here it is done with empty files to pacify the build
system. Actual dts content is simply copied to arch/$ARCH/dts as automatic
inclusion dtsi. This pretends that if merged, then when upstream changes
appear in devicetree-rebasing it would be only this updated content which
can easily be reverted and empty placeholder files in dts/upstream be
merged with less tedious conflict resolution.

For development with a local Linux source tree, the dtsi files for
automatic inclusion may simply have a 1-liner include to the location of
the corresponding dts file from that Linux source tree.

Open to comments about how best to encourage early review of series like
this (notable is StarFive VisionFive2 Lite new product recently posted)
when there is a hard dependency on both the OF_LIST of a multi-board
target as starfive visionfive2 is and the dts which may not yet be
available from dts/upstream devicetree-rebasing.

E Shattow (4):
  riscv: dts: starfive: Add Milk-V Mars CM and Mars CM Lite from
    upstream Linux for-next
  board: starfive: visionfive2: Add Milk-V Mars CM and Mars CM Lite
    selection by product_id
  riscv: dts: Add placeholder files for pending upstream Milk-V Mars CM
    and Mars CM Lite
  configs: starfive: Add Milk-V Mars CM and Mars CM Lite to visionfive2

 .../dts/jh7110-milkv-marscm-emmc-u-boot.dtsi  |  12 ++
 .../dts/jh7110-milkv-marscm-lite-u-boot.dtsi  |  25 +++
 arch/riscv/dts/jh7110-milkv-marscm.dtsi       | 159 ++++++++++++++++++
 board/starfive/visionfive2/spl.c              |   8 +
 .../visionfive2/starfive_visionfive2.c        |   6 +
 configs/starfive_visionfive2_defconfig        |   2 +-
 .../starfive/jh7110-milkv-marscm-emmc.dts     |   0
 .../starfive/jh7110-milkv-marscm-lite.dts     |   0
 8 files changed, 211 insertions(+), 1 deletion(-)
 create mode 100644 arch/riscv/dts/jh7110-milkv-marscm-emmc-u-boot.dtsi
 create mode 100644 arch/riscv/dts/jh7110-milkv-marscm-lite-u-boot.dtsi
 create mode 100644 arch/riscv/dts/jh7110-milkv-marscm.dtsi
 create mode 100644 dts/upstream/src/riscv/starfive/jh7110-milkv-marscm-emmc.dts
 create mode 100644 dts/upstream/src/riscv/starfive/jh7110-milkv-marscm-lite.dts


base-commit: e482fdbbca935de32400054eb532de45b1cc01cb
-- 
2.50.0

