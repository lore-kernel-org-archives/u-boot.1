Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F291CA0EFA
	for <u-boot@archiver.kernel.org>; Mon, 25 Aug 2025 15:23:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 58B3D83020;
	Mon, 25 Aug 2025 17:23:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="V9c7X2L/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2680D82FC7; Mon, 25 Aug 2025 17:23:16 +0200 (CEST)
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BBCFE82FC7
 for <u-boot@lists.denx.de>; Mon, 25 Aug 2025 17:23:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=jm@ti.com
Received: from lelvem-sh02.itg.ti.com ([10.180.78.226])
 by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTP id 57PFNAfO1321578;
 Mon, 25 Aug 2025 10:23:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1756135390;
 bh=iDWsWCR4mMaQu4HNVLIGxPnrmb4zdmd+ObUqYnltuno=;
 h=From:To:CC:Subject:Date;
 b=V9c7X2L/LA9pJj8Ig6vsA4UwP23JHh61z2mv36DKXKAG2ChV+XVZECyAJ+LjyFoAR
 oOH8KjIAd6DeBldN+1Gac3sjf4tyPLi5RBkSRILEwyMWiHecyCRLTKV/zUcIaIDD/x
 A94kRygrefK2qd/3KCSQfs9nsSwTMVZCYFd9lA5U=
Received: from DFLE110.ent.ti.com (dfle110.ent.ti.com [10.64.6.31])
 by lelvem-sh02.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 57PFNANj1266170
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Mon, 25 Aug 2025 10:23:10 -0500
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Mon, 25
 Aug 2025 10:23:10 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Mon, 25 Aug 2025 10:23:10 -0500
Received: from judy-hp.dhcp.ti.com (judy-hp.dhcp.ti.com [128.247.81.105])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 57PFNAFd3822315;
 Mon, 25 Aug 2025 10:23:10 -0500
From: Judith Mendez <jm@ti.com>
To: Judith Mendez <jm@ti.com>, Tom Rini <trini@konsulko.com>
CC: Bryan Brattlof <bb@ti.com>, <u-boot@lists.denx.de>
Subject: [PATCH] board: ti: am65x: Overwrite get_overlay_mmc
Date: Mon, 25 Aug 2025 10:23:10 -0500
Message-ID: <20250825152310.1847708-1-jm@ti.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
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

Unlike other K3 SoC's, am65 SoC has the capability to detect daughter
cards and automatically generate a list of white-space separated overlays
in name_overlays environment variable.

When applied during boot with get_overlay_mmc, the path to overlays with
default distribution is incorrect where path is currently: boot/dtb and
the overlays exist in boot/dtb/ti.

Fix the path in get_overlay_mmc so that overlays are automatically applied
correctly during boot time.

Signed-off-by: Judith Mendez <jm@ti.com>
---
 board/ti/am65x/am65x.env | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/board/ti/am65x/am65x.env b/board/ti/am65x/am65x.env
index 631997e4c97..b6cdfc9bd96 100644
--- a/board/ti/am65x/am65x.env
+++ b/board/ti/am65x/am65x.env
@@ -17,6 +17,15 @@ bootpart=1:2
 bootdir=/boot
 rd_spec=-
 
+get_overlay_mmc=
+	fdt address ${fdtaddr};
+	fdt resize 0x100000;
+	for overlay in $name_overlays;
+	do;
+	load mmc ${bootpart} ${dtboaddr} ${bootdir}/dtb/ti/${overlay} &&
+	fdt apply ${dtboaddr};
+	done;
+
 init_ubi=
     run args_all args_ubi;
     sf probe;
-- 
2.49.0

