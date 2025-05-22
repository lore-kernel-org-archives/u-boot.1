Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36D44C54E90
	for <u-boot@archiver.kernel.org>; Thu, 22 May 2025 16:40:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8B6F88313B;
	Thu, 22 May 2025 18:40:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="Aby3UAzp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3087E83145; Thu, 22 May 2025 18:40:19 +0200 (CEST)
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E96A58312A
 for <u-boot@lists.denx.de>; Thu, 22 May 2025 18:40:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=afd@ti.com
Received: from fllvem-sh04.itg.ti.com ([10.64.41.54])
 by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTP id 54MGeFBW659804;
 Thu, 22 May 2025 11:40:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1747932015;
 bh=Oo2Qg3n9RFxTtNvSIDfczx0xhSokOieO4Hfv1FM4ZIU=;
 h=From:To:CC:Subject:Date;
 b=Aby3UAzpH3VW5hmyD/maZ/K8RJXrh8xexXQ+nCyxtia8sapme05AapRyW1JnZ5y4H
 11t0WxQ/pPKkWj8BDNl5o8hbrqLaFvSvYl2EodfhfCsCHC01pmfjED9ewvPXHKu/pw
 DGf99UQ1cXKaVkQeBxWlGVt0A7FHgDU101VuDXI8=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
 by fllvem-sh04.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 54MGeFeY3634153
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Thu, 22 May 2025 11:40:15 -0500
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 22
 May 2025 11:40:15 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 22 May 2025 11:40:14 -0500
Received: from fllvsmtp8.itg.ti.com ([10.249.42.149])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 54MGeE2O006402;
 Thu, 22 May 2025 11:40:14 -0500
From: Andrew Davis <afd@ti.com>
To: Neha Malcom Francis <n-francis@ti.com>, Vignesh Raghavendra
 <vigneshr@ti.com>, Chirag Shilwant <c-shilwant@ti.com>, Tom Rini
 <trini@konsulko.com>
CC: <u-boot@lists.denx.de>, Andrew Davis <afd@ti.com>
Subject: [PATCH] board: ti: am62ax: env: Use default MMC related args
Date: Thu, 22 May 2025 11:40:13 -0500
Message-ID: <20250522164013.125496-1-afd@ti.com>
X-Mailer: git-send-email 2.39.2
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

There are common MMC args for TI plats in include/environment/ti/mmc.env.
Since we already include this, there is no need to redefine these
MMC vars. Use the defaults.

This seems like something that could have been done while refactoring
these vars in the first place as it happened after this AM62A file
was available hence the fixes tag.

Reported-by: Chirag Shilwant <c-shilwant@ti.com>
Fixes: 3709b529156e ("env: ti: mmc.env: Move mmc related args to common place")
Signed-off-by: Andrew Davis <afd@ti.com>
---
 board/ti/am62ax/am62ax.env | 15 +--------------
 1 file changed, 1 insertion(+), 14 deletions(-)

diff --git a/board/ti/am62ax/am62ax.env b/board/ti/am62ax/am62ax.env
index 96d9e1e2797..dc7af56a6f7 100644
--- a/board/ti/am62ax/am62ax.env
+++ b/board/ti/am62ax/am62ax.env
@@ -17,18 +17,5 @@ mmcdev=1
 bootpart=1:2
 bootdir=/boot
 rd_spec=-
-init_mmc=run args_all args_mmc
-get_overlay_mmc=
-	fdt address ${fdtaddr};
-	fdt resize 0x100000;
-	for overlay in $name_overlays;
-	do;
-	load mmc ${bootpart} ${dtboaddr} ${bootdir}/${overlay} &&
-	fdt apply ${dtboaddr};
-	done;
-get_kern_mmc=load mmc ${bootpart} ${loadaddr}
-	${bootdir}/${name_kern}
-get_fit_mmc=load mmc ${bootpart} ${addr_fit}
-	${bootdir}/${name_fit}
-partitions=name=rootfs,start=0,size=-,uuid=${uuid_gpt_rootfs}
+
 rproc_fw_binaries= 0 /lib/firmware/am62a-mcu-r5f0_0-fw 1 /lib/firmware/am62a-c71_0-fw
-- 
2.39.2

