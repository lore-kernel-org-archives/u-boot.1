Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E089CCD18E
	for <u-boot@archiver.kernel.org>; Wed, 15 Oct 2025 10:23:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4CE0E8313B;
	Wed, 15 Oct 2025 12:23:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=freeshell.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6E26E8323A; Wed, 15 Oct 2025 12:23:46 +0200 (CEST)
Received: from freeshell.de (freeshell.de [IPv6:2a01:4f8:231:482b::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 41A2780107
 for <u-boot@lists.denx.de>; Wed, 15 Oct 2025 12:23:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=freeshell.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=e@freeshell.de
Received: from hay.lan (unknown [IPv6:2605:59c0:2078:cf00:6ecf:39ff:fe00:8375])
 (Authenticated sender: e)
 by freeshell.de (Postfix) with ESMTPSA id 03CBDB220341;
 Wed, 15 Oct 2025 12:23:42 +0200 (CEST)
From: E Shattow <e@freeshell.de>
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de,
	E Shattow <e@freeshell.de>
Subject: [PATCH v2 00/10] dts: starfive: cherry-pick jh7110 updates from
 v6.18-rc1-dts
Date: Wed, 15 Oct 2025 03:22:43 -0700
Message-ID: <20251015102253.48276-1-e@freeshell.de>
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

Prepare for Milk-V Mars CM support re-add and for drop of duplicate
overrides in U-Boot jh7110.dtsi by taking upstream updates from v6.18-rc1.

This series supersedes "Merge cherry-pick tag 'riscv-dt-for-v6.18' of
https://git.kernel.org/pub/scm/linux/kernel/git/conor/linux into soc/dt":

https://lore.kernel.org/u-boot/f9931130-96cb-41bf-9be2-6a390085bcad@freeshell.de

That (above) patch is for a merge commit and touched more platforms than I
am able to test for. It is better to just take the JH-7110 commits here.

E Shattow (10):
  riscv: dts: starfive: jh7110-common: drop no-sdio property from mmc1
  riscv: dts: starfive: jh7110: add DMC memory controller
  riscv: dts: starfive: jh7110: bootph-pre-ram hinting needed by boot
    loader
  riscv: dts: starfive: jh7110-common: drop no-mmc property from mmc1
  riscv: dts: starfive: jh7110-common: drop mmc post-power-on-delay-ms
  riscv: dts: starfive: add common board dtsi for Milk-V Mars CM
    variants
  dt-bindings: riscv: starfive: add milkv,marscm-emmc
  riscv: dts: starfive: add Milk-V Mars CM system-on-module
  dt-bindings: riscv: starfive: add milkv,marscm-lite
  riscv: dts: starfive: add Milk-V Mars CM Lite system-on-module

 dts/upstream/Bindings/riscv/starfive.yaml     |   2 +
 .../src/riscv/starfive/jh7110-common.dtsi     |   4 -
 .../starfive/jh7110-milkv-marscm-emmc.dts     |  12 ++
 .../starfive/jh7110-milkv-marscm-lite.dts     |  25 +++
 .../riscv/starfive/jh7110-milkv-marscm.dtsi   | 159 ++++++++++++++++++
 dts/upstream/src/riscv/starfive/jh7110.dtsi   |  24 +++
 6 files changed, 222 insertions(+), 4 deletions(-)
 create mode 100644 dts/upstream/src/riscv/starfive/jh7110-milkv-marscm-emmc.dts
 create mode 100644 dts/upstream/src/riscv/starfive/jh7110-milkv-marscm-lite.dts
 create mode 100644 dts/upstream/src/riscv/starfive/jh7110-milkv-marscm.dtsi


base-commit: b1cc9a53d7ba8b85e77980417242420889273e86
-- 
2.50.0

