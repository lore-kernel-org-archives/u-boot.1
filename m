Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A086ACCD1AB
	for <u-boot@archiver.kernel.org>; Tue, 21 Oct 2025 23:11:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8D5D5800B6;
	Wed, 22 Oct 2025 01:11:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=freeshell.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id A7E1F82B20; Wed, 22 Oct 2025 01:11:35 +0200 (CEST)
Received: from freeshell.de (freeshell.de [IPv6:2a01:4f8:231:482b::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8332C80077
 for <u-boot@lists.denx.de>; Wed, 22 Oct 2025 01:11:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=freeshell.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=e@freeshell.de
Received: from hay.lan (unknown [IPv6:2605:59c0:2078:cf00:6ecf:39ff:fe00:8375])
 (Authenticated sender: e)
 by freeshell.de (Postfix) with ESMTPSA id 69943B2200FE;
 Wed, 22 Oct 2025 01:11:32 +0200 (CEST)
From: E Shattow <e@freeshell.de>
To: 
Cc: u-boot@lists.denx.de,
	E Shattow <e@freeshell.de>
Subject: [PATCH v2 0/3] Add upstream boards Milk-V Mars CM and Mars CM Lite
Date: Tue, 21 Oct 2025 16:09:57 -0700
Message-ID: <20251021231021.196336-1-e@freeshell.de>
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
visionfive2 multi-board support. Upstream patches are in for Linux
v6.18-rc1 and available through devicetree-rebasing so let's re-introduce
support for these boards.

Sorting of OF_LIST is kept consistent with `LANG=C sort`, and callbacks in
SPL for dts selection are ordered the same. Logic for setting fdtfile env
variable corresponds with the sorting of OF_LIST and not the representative
EEPROM value comparisons.

This series depends on:
"dts: starfive: cherry-pick jh7110 updates from v6.18-rc1-dts"
https://lore.kernel.org/u-boot/20251015102253.48276-1-e@freeshell.de/

Changes since RFC v1:
- Drop patch 1/4 "riscv: dts: starfive: Add Milk-V Mars CM and Mars CM
Lite from upstream Linux for-next"
- Drop patch 3/4 "riscv: dts: Add placeholder files for pending upstream
Milk-V Mars CM and Mars CM Lite"
- Add patch for basic documentation stub. This should be expanded in
future with a refresh of all the starfive boards' user docs.

E Shattow (3):
  board: starfive: visionfive2: Add Milk-V Mars CM and Mars CM Lite
    selection by product_id
  configs: starfive: Add Milk-V Mars CM and Mars CM Lite to visionfive2
  board: starfive: Add initial Milk-V Mars CM and Mars CM Lite user
    documentation

 board/starfive/visionfive2/spl.c              |  8 +++++++
 .../visionfive2/starfive_visionfive2.c        |  6 +++++
 configs/starfive_visionfive2_defconfig        |  2 +-
 doc/board/starfive/index.rst                  |  2 ++
 doc/board/starfive/milkv_marscm_emmc.rst      | 24 +++++++++++++++++++
 doc/board/starfive/milkv_marscm_lite.rst      | 24 +++++++++++++++++++
 6 files changed, 65 insertions(+), 1 deletion(-)
 create mode 100644 doc/board/starfive/milkv_marscm_emmc.rst
 create mode 100644 doc/board/starfive/milkv_marscm_lite.rst

-- 
2.50.0

