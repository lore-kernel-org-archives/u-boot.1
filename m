Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E24EC677C4
	for <u-boot@archiver.kernel.org>; Wed, 11 Jun 2025 08:59:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9BB2D82B63;
	Wed, 11 Jun 2025 10:59:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id EC3D382BAA; Wed, 11 Jun 2025 10:59:45 +0200 (CEST)
Received: from smtp-190b.mail.infomaniak.ch (smtp-190b.mail.infomaniak.ch
 [IPv6:2001:1600:7:10::190b])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8275C828A2
 for <u-boot@lists.denx.de>; Wed, 11 Jun 2025 10:59:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=foss+uboot@0leil.net
Received: from smtp-4-0000.mail.infomaniak.ch (unknown
 [IPv6:2001:1600:7:10::a6b])
 by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4bHKNZ70RXzt65;
 Wed, 11 Jun 2025 10:59:42 +0200 (CEST)
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4bHKNY4vZGzrBd; Wed, 11 Jun 2025 10:59:41 +0200 (CEST)
From: Quentin Schulz <foss+uboot@0leil.net>
Subject: [PATCH 0/3] rockchip: ringneck-px30: anticipate breakage with
 v6.16-rc1 DT
Date: Wed, 11 Jun 2025 10:59:30 +0200
Message-Id: <20250611-ringneck-mdio-v1-0-529a40a0f966@cherry.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHJFSWgC/x3MQQqAIBBA0avIrBNGs8CuEi1CJxsiDYUIpLsnL
 d/i/wqFMlOBSVTIdHPhFBtUJ8Dtawwk2TeDRj3gqFBmjiGSO+TpOUnrLPbGIRmP0Jor08bP/5u
 X9/0Ant1kNV8AAAA=
X-Change-ID: 20250610-ringneck-mdio-9c9034c0e4d0
To: Sumit Garg <sumit.garg@kernel.org>, Simon Glass <sjg@chromium.org>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 Kever Yang <kever.yang@rock-chips.com>, Tom Rini <trini@konsulko.com>, 
 Klaus Goger <klaus.goger@cherry.de>
Cc: Heiko Stuebner <heiko@sntech.de>, u-boot@lists.denx.de, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Heiko Stuebner <heiko.stuebner@cherry.de>
X-Mailer: b4 0.14.2
X-Infomaniak-Routing: alpha
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

v6.16-rc1 will bring an incompatible change to the Device Tree of PX30
Ringneck which will break Ethernet support.

Unfortunately, the designware net driver's logic doesn't seem to allow
having the old Device Tree (without MDIO bus and Ethernet PHY nodes)
with DM_MDIO and DM_ETH_PHY enabled so there cannot be a smooth
transition.

Since this is going to bite me in a few months time, let's just break
and fix it now in a couple of commits so I don't have to think about it
later :)

This can be cleanly applied on master or next, I have absolutely zero
preference on the branch this should be merged in (my opinion is that
it's too late in the 2024.07 cycle to bring this in :) ).

Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
Heiko Stuebner (2):
      arm64: dts: rockchip: add basic mdio node to px30
      arm64: dts: rockchip: move reset to dedicated eth-phy node on ringneck

Quentin Schulz (1):
      configs: ringneck-px30: fix Ethernet

 configs/ringneck-px30_defconfig                    |  2 ++
 dts/upstream/src/arm64/rockchip/px30-ringneck.dtsi | 22 +++++++++++++++++++---
 dts/upstream/src/arm64/rockchip/px30.dtsi          |  6 ++++++
 3 files changed, 27 insertions(+), 3 deletions(-)
---
base-commit: d7c449c3d83a986d61e38d1762433c0607caf5c5
change-id: 20250610-ringneck-mdio-9c9034c0e4d0

Best regards,
-- 
Quentin Schulz <quentin.schulz@cherry.de>

