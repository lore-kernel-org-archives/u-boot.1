Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E955DC7113C
	for <u-boot@archiver.kernel.org>; Fri, 18 Aug 2023 13:17:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 43C0586E06;
	Fri, 18 Aug 2023 15:17:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8F55986E07; Fri, 18 Aug 2023 15:17:46 +0200 (CEST)
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com
 [210.160.252.171])
 by phobos.denx.de (Postfix) with ESMTP id 69C7E86E00
 for <u-boot@lists.denx.de>; Fri, 18 Aug 2023 15:17:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=bp.renesas.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=paul.barker.ct@bp.renesas.com
X-IronPort-AV: E=Sophos;i="6.01,183,1684767600"; d="scan'208";a="173282690"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
 by relmlie5.idc.renesas.com with ESMTP; 18 Aug 2023 22:17:34 +0900
Received: from GBR-5CG2373LKG.adwin.renesas.com (unknown [10.226.92.88])
 by relmlir5.idc.renesas.com (Postfix) with ESMTP id 4F65C40065AB;
 Fri, 18 Aug 2023 22:17:32 +0900 (JST)
From: Paul Barker <paul.barker.ct@bp.renesas.com>
To: u-boot@lists.denx.de, Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: Paul Barker <paul.barker.ct@bp.renesas.com>,
 Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH] arm: rmobile: Fix off-by-one error in cpuinfo
Date: Fri, 18 Aug 2023 14:17:21 +0100
Message-Id: <20230818131721.25262-1-paul.barker.ct@bp.renesas.com>
X-Mailer: git-send-email 2.34.1
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

In rmobile_cpuinfo_idx() there is an off-by-one error in accessing the
rmobile_cpuinfo array.

At the end of the loop, i is equal to the array size, i.e.
rmobile_cpuinfo[i] accesses one entry past the end of the array. The
last entry in the array is a fallback value so the loop should count to
ARRAY_SIZE(rmobile_cpuinfo) - 1 instead, this will leave i equal to the
index of the fallback value if no match is found.

Signed-off-by: Paul Barker <paul.barker.ct@bp.renesas.com>
Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 arch/arm/mach-rmobile/cpu_info.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-rmobile/cpu_info.c b/arch/arm/mach-rmobile/cpu_info.c
index 1d33e2aa9da3..7651e43bd0fc 100644
--- a/arch/arm/mach-rmobile/cpu_info.c
+++ b/arch/arm/mach-rmobile/cpu_info.c
@@ -86,7 +86,7 @@ static int rmobile_cpuinfo_idx(void)
 	int i = 0;
 	u32 cpu_type = rmobile_get_cpu_type();
 
-	for (; i < ARRAY_SIZE(rmobile_cpuinfo); i++)
+	for (; i < ARRAY_SIZE(rmobile_cpuinfo) - 1; i++)
 		if (rmobile_cpuinfo[i].cpu_type == cpu_type)
 			break;
 
-- 
2.34.1

