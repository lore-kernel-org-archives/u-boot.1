Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FF22CD610D
	for <u-boot@archiver.kernel.org>; Mon,  9 Oct 2023 16:50:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2C01686E1F;
	Mon,  9 Oct 2023 18:47:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id B39E386E13; Mon,  9 Oct 2023 18:47:49 +0200 (CEST)
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com
 [210.160.252.172])
 by phobos.denx.de (Postfix) with ESMTP id 4661886DD8
 for <u-boot@lists.denx.de>; Mon,  9 Oct 2023 18:47:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=bp.renesas.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=paul.barker.ct@bp.renesas.com
X-IronPort-AV: E=Sophos;i="6.03,210,1694703600"; d="scan'208";a="182438642"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
 by relmlie6.idc.renesas.com with ESMTP; 10 Oct 2023 01:47:46 +0900
Received: from GBR-5CG2373LKG.adwin.renesas.com (unknown [10.226.92.229])
 by relmlir6.idc.renesas.com (Postfix) with ESMTP id D3952402A8DA;
 Tue, 10 Oct 2023 01:47:43 +0900 (JST)
From: Paul Barker <paul.barker.ct@bp.renesas.com>
To: u-boot@lists.denx.de, Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Hai Pham <hai.pham.ud@renesas.com>
Cc: Paul Barker <paul.barker.ct@bp.renesas.com>,
 Biju Das <biju.das.jz@bp.renesas.com>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH v2 15/19] arm: rmobile: Include <asm/types.h> in header
Date: Mon,  9 Oct 2023 17:46:41 +0100
Message-Id: <20231009164645.164464-16-paul.barker.ct@bp.renesas.com>
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

We don't want to rely on source files including <asm/types.h> before
<asm/arch/rmobile.h>.

Signed-off-by: Paul Barker <paul.barker.ct@bp.renesas.com>
Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
v1->v2:
  * Added Marek's Reviewed-by.

 arch/arm/mach-rmobile/include/mach/rmobile.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/mach-rmobile/include/mach/rmobile.h b/arch/arm/mach-rmobile/include/mach/rmobile.h
index d326d5545a6f..053ad08add00 100644
--- a/arch/arm/mach-rmobile/include/mach/rmobile.h
+++ b/arch/arm/mach-rmobile/include/mach/rmobile.h
@@ -45,6 +45,8 @@
 #define RMOBILE_CPU_TYPE_R8A779G0	0x5C
 
 #ifndef __ASSEMBLY__
+#include <asm/types.h>
+
 const u8 *rzg_get_cpu_name(void);
 u32 rmobile_get_cpu_type(void);
 u32 rmobile_get_cpu_rev_integer(void);
-- 
2.39.2

