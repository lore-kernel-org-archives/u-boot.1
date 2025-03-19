Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDFF7C35FFA
	for <u-boot@archiver.kernel.org>; Wed, 19 Mar 2025 12:04:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4B1A881A04;
	Wed, 19 Mar 2025 13:04:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 43FCA810F2; Wed, 19 Mar 2025 13:04:24 +0100 (CET)
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com
 [210.160.252.171])
 by phobos.denx.de (Postfix) with ESMTP id 240E9810F2
 for <u-boot@lists.denx.de>; Wed, 19 Mar 2025 13:04:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=bp.renesas.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=paul.barker.ct@bp.renesas.com
X-CSE-ConnectionGUID: XzWH7r7jSnWuJe9RlK1NzQ==
X-CSE-MsgGUID: 44l5iOc3Te29ZdGWm3Sd5w==
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
 by relmlie5.idc.renesas.com with ESMTP; 19 Mar 2025 21:04:17 +0900
Received: from rz-ub2404.betafive.net (unknown [10.24.1.74])
 by relmlir5.idc.renesas.com (Postfix) with ESMTP id 7E3A14016D69;
 Wed, 19 Mar 2025 21:04:06 +0900 (JST)
From: Paul Barker <paul.barker.ct@bp.renesas.com>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Tom Rini <trini@konsulko.com>
Cc: Paul Barker <paul.barker.ct@bp.renesas.com>,
	u-boot@lists.denx.de
Subject: [PATCH v2 0/4] Add support for Ethernet interfaces on RZ/G2L
Date: Wed, 19 Mar 2025 12:03:56 +0000
Message-ID: <20250319120401.8297-1-paul.barker.ct@bp.renesas.com>
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

This patch series enables the usage of both Ethernet interfaces on the
Renesas RZ/G2L SMARC EVK board. It can be applied on top of commit
95d10669c0bd ("net: phy: ksz90x1: Simplify ksz9131_config_rgmii_delay")
on the u-boot-sh next branch.

Changes v1->v2:
  - Split out from the original 14 patch series [1] now that all other
    dependencies have been merged to the u-boot-sh 'next' branch.
  - Rebased on top of recent ravb driver fixes.
  - Split changes to the ravb driver into three patches to ease review.
  - Use a has_reset boolean instead of reset_assert & reset_deassert
    methods to simplify the code.
  - Keep the code sorted alphabetically in various places (rcar before
    rzg).

[1]: https://lore.kernel.org/all/20241024152448.102-1-paul.barker.ct@bp.renesas.com/

Paul Barker (4):
  net: ravb: Refactor out R-Car specific code
  net: ravb: Add optional reset deassertion
  net: ravb: Add RZ/G2L Support
  renesas_rzg2l_smarc_defconfig: Enable networking support

 arch/arm/mach-renesas/Kconfig         |   1 +
 configs/renesas_rzg2l_smarc_defconfig |   6 +
 drivers/net/Kconfig                   |   2 +-
 drivers/net/ravb.c                    | 164 +++++++++++++++++++++++---
 4 files changed, 154 insertions(+), 19 deletions(-)

-- 
2.43.0

