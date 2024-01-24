Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E50BEC46CD2
	for <u-boot@archiver.kernel.org>; Wed, 24 Jan 2024 07:26:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5E5A487BF0;
	Wed, 24 Jan 2024 08:26:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="DD1kYeS2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6C54587613; Wed, 24 Jan 2024 08:26:39 +0100 (CET)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6503887BBA
 for <u-boot@lists.denx.de>; Wed, 24 Jan 2024 08:26:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=m-chawdhry@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 40O7QZs1035752
 for <u-boot@lists.denx.de>; Wed, 24 Jan 2024 01:26:35 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1706081195;
 bh=HzWtKdcVXBC1Y7UM5bvWG04LIixHubqWnXa/gZrQPp8=;
 h=From:Date:Subject:References:In-Reply-To:To:CC;
 b=DD1kYeS28NOLJyl8VVhcya5vGhOmC6g5ODooXLvpvmo7tbTNJrKnSF0ZMAlzzpjjq
 EARuYIlR2ePSUC7CNZJj3TyTemSope6w9tR46NiLfGue2wCvYO/p6O40DtmxZb2Pgv
 fJZbofVONULYyd44NGmQxU/XoodylLGcc0eV/1Ek=
Received: from DFLE107.ent.ti.com (dfle107.ent.ti.com [10.64.6.28])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 40O7QZk4010943
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL)
 for <u-boot@lists.denx.de>; Wed, 24 Jan 2024 01:26:35 -0600
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 24
 Jan 2024 01:26:34 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 24 Jan 2024 01:26:35 -0600
Received: from [127.0.1.1] (uda0497581.dhcp.ti.com [10.24.68.185])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 40O7QTGi015268;
 Wed, 24 Jan 2024 01:26:32 -0600
From: Manorit Chawdhry <m-chawdhry@ti.com>
Date: Wed, 24 Jan 2024 12:56:25 +0530
Subject: [PATCH 1/2] env: ti: mmc: add save_uenv command
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240124-b4-upstream-save_uenv-v1-1-4a4dfbd3eca9@ti.com>
References: <20240124-b4-upstream-save_uenv-v1-0-4a4dfbd3eca9@ti.com>
In-Reply-To: <20240124-b4-upstream-save_uenv-v1-0-4a4dfbd3eca9@ti.com>
To: Udit Kumar <u-kumar1@ti.com>, Neha Malcom Francis <n-francis@ti.com>,
 Andrew Davis <afd@ti.com>, Nishanth Menon <nm@ti.com>
CC: <u-boot@lists.denx.de>, Vignesh Raghavendra <vigneshr@ti.com>, Keerthy J
 <j-keerthy@ti.com>, Aniket Limaye <a-limaye@ti.com>, Manorit Chawdhry
 <m-chawdhry@ti.com>
X-Mailer: b4 0.13-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1706081189; l=737;
 i=m-chawdhry@ti.com; s=20231127; h=from:subject:message-id;
 bh=9HrQWhIVrTlnEVJ73RpS9KsroLBIVJ9NINusFpCtmNc=;
 b=60Fe1Lz1ZPhxaCed/ODotTAP8cyJgxlWWoGfOTLng9M1zZXi5WuZc7DmWRUWGOn2VWGxdtTZi
 IndvZ6H6E/ZBxcHVyoGl8GOlty6chi3JyZHYF6ruRbQ4EB416uKKstB
X-Developer-Key: i=m-chawdhry@ti.com; a=ed25519;
 pk=fsr6Tm39TvsTgfyfFQLk+nnqIz2sBA1PthfqqfiiYSs=
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
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

This is to make easier development with uEnv.txt to update from the
board on the fly from u-boot to MMC boot media.

Signed-off-by: Manorit Chawdhry <m-chawdhry@ti.com>
---
 include/env/ti/mmc.env | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/env/ti/mmc.env b/include/env/ti/mmc.env
index 0256a2d2aaca..886e4cab36fe 100644
--- a/include/env/ti/mmc.env
+++ b/include/env/ti/mmc.env
@@ -34,6 +34,9 @@ envboot=if mmc dev ${mmcdev}; then
 		fi;
 	fi;
   fi;
+save_uenv=
+	env export -t $loadaddr $save_to_env save_to_env;
+	fatwrite mmc ${mmcdev} ${loadaddr} ${bootenvfile} ${filesize};
 mmcloados=
 	if test ${boot_fdt} = yes || test ${boot_fdt} = try; then
 		if run get_fdt_mmc; then

-- 
2.43.0

