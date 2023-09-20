Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B262DCE79CE
	for <u-boot@archiver.kernel.org>; Wed, 20 Sep 2023 12:44:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CDFB486BE0;
	Wed, 20 Sep 2023 14:43:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id D3D71803AC; Wed, 20 Sep 2023 14:42:59 +0200 (CEST)
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com
 [210.160.252.172])
 by phobos.denx.de (Postfix) with ESMTP id 9676486AB9
 for <u-boot@lists.denx.de>; Wed, 20 Sep 2023 14:42:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=bp.renesas.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=paul.barker.ct@bp.renesas.com
X-IronPort-AV: E=Sophos;i="6.03,162,1694703600"; d="scan'208";a="180389780"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
 by relmlie6.idc.renesas.com with ESMTP; 20 Sep 2023 21:42:57 +0900
Received: from GBR-5CG2373LKG.adwin.renesas.com (unknown [10.226.92.83])
 by relmlir6.idc.renesas.com (Postfix) with ESMTP id 82967433CFB9;
 Wed, 20 Sep 2023 21:42:54 +0900 (JST)
From: Paul Barker <paul.barker.ct@bp.renesas.com>
To: u-boot@lists.denx.de, Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Hai Pham <hai.pham.ud@renesas.com>
Cc: Paul Barker <paul.barker.ct@bp.renesas.com>,
 Biju Das <biju.das.jz@bp.renesas.com>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 08/16] arm: rmobile: Restrict PINCTRL_PFC selection to R-Car
 gen3/gen4
Date: Wed, 20 Sep 2023 13:42:04 +0100
Message-Id: <20230920124212.63535-9-paul.barker.ct@bp.renesas.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230920124212.63535-1-paul.barker.ct@bp.renesas.com>
References: <20230920124212.63535-1-paul.barker.ct@bp.renesas.com>
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

The RZ/G2L family uses CONFIG_RCAR_64 but does not share a common PFC
driver with the R-Car gen3 & gen4 boards.

Signed-off-by: Paul Barker <paul.barker.ct@bp.renesas.com>
Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 arch/arm/mach-rmobile/Kconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-rmobile/Kconfig b/arch/arm/mach-rmobile/Kconfig
index fc37f6c79e50..91f544c78337 100644
--- a/arch/arm/mach-rmobile/Kconfig
+++ b/arch/arm/mach-rmobile/Kconfig
@@ -9,7 +9,6 @@ config RCAR_64
 	select PHY
 	select PINCONF
 	select PINCTRL
-	select PINCTRL_PFC
 	select POSITION_INDEPENDENT
 	imply CMD_FS_UUID
 	imply CMD_GPT
@@ -29,6 +28,7 @@ config RCAR_GEN3
 	bool "Renesas ARM SoCs R-Car Gen3 (64bit)"
 	select RCAR_64
 	select SUPPORT_SPL
+	select PINCTRL_PFC
 	imply SPL
 	imply SPL_BOARD_INIT
 	imply SPL_GZIP
@@ -43,6 +43,7 @@ config RCAR_GEN3
 config RCAR_GEN4
 	bool "Renesas ARM SoCs R-Car Gen4 (64bit)"
 	select RCAR_64
+	select PINCTRL_PFC
 
 config RZA1
 	prompt "Renesas ARM SoCs RZ/A1 (32bit)"
-- 
2.34.1

