Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E210ECD610D
	for <u-boot@archiver.kernel.org>; Mon,  9 Oct 2023 16:48:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D7AB986DD3;
	Mon,  9 Oct 2023 18:47:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5D0B586DC4; Mon,  9 Oct 2023 18:47:21 +0200 (CEST)
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com
 [210.160.252.172])
 by phobos.denx.de (Postfix) with ESMTP id 13A9386B3C
 for <u-boot@lists.denx.de>; Mon,  9 Oct 2023 18:47:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=bp.renesas.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=paul.barker.ct@bp.renesas.com
X-IronPort-AV: E=Sophos;i="6.03,210,1694703600"; d="scan'208";a="182438614"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
 by relmlie6.idc.renesas.com with ESMTP; 10 Oct 2023 01:47:18 +0900
Received: from GBR-5CG2373LKG.adwin.renesas.com (unknown [10.226.92.229])
 by relmlir6.idc.renesas.com (Postfix) with ESMTP id F293D402A8D6;
 Tue, 10 Oct 2023 01:47:15 +0900 (JST)
From: Paul Barker <paul.barker.ct@bp.renesas.com>
To: u-boot@lists.denx.de, Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Hai Pham <hai.pham.ud@renesas.com>
Cc: Paul Barker <paul.barker.ct@bp.renesas.com>,
 Biju Das <biju.das.jz@bp.renesas.com>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH v2 06/19] arm: rmobile: Add basic R9A07G044L SoC support
Date: Mon,  9 Oct 2023 17:46:32 +0100
Message-Id: <20231009164645.164464-7-paul.barker.ct@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231009164645.164464-1-paul.barker.ct@bp.renesas.com>
References: <20231009164645.164464-1-paul.barker.ct@bp.renesas.com>
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

Add a config option for the R9A07G044L SoC used in the RZ/G2L so that we
can make use of this in the subsequent driver patches.

Signed-off-by: Paul Barker <paul.barker.ct@bp.renesas.com>
Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
v1->v2:
  * Reword config R9A07G044L description to improve clarity.

 arch/arm/mach-rmobile/Kconfig.rzg2l | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/mach-rmobile/Kconfig.rzg2l b/arch/arm/mach-rmobile/Kconfig.rzg2l
index 37ff6cd34160..eda04df5c619 100644
--- a/arch/arm/mach-rmobile/Kconfig.rzg2l
+++ b/arch/arm/mach-rmobile/Kconfig.rzg2l
@@ -3,6 +3,11 @@
 
 if RZG2L
 
+config R9A07G044L
+	bool "Renesas R9A07G044L SoC"
+	help
+	  Enable support for the Renesas R9A07G044L (RZ/G2L) SoC.
+
 config MULTI_DTB_FIT_UNCOMPRESS_SZ
 	default 0x80000 if TARGET_RZG2L_SMARC_EVK
 
-- 
2.39.2

