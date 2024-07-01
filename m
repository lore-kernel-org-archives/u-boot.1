Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AC31C3065A
	for <u-boot@archiver.kernel.org>; Mon,  1 Jul 2024 05:19:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 72A2D8865F;
	Mon,  1 Jul 2024 07:19:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="eK7Sf6bi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D8889886A0; Mon,  1 Jul 2024 07:19:16 +0200 (CEST)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C670D8867C
 for <u-boot@lists.denx.de>; Mon,  1 Jul 2024 07:19:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=m-chawdhry@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4615JAcQ095270;
 Mon, 1 Jul 2024 00:19:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1719811150;
 bh=DiKNYdnDiATOtKZrL/HaRMFq4ePKNwM/GzJaCdYTQHQ=;
 h=From:Date:Subject:References:In-Reply-To:To:CC;
 b=eK7Sf6bisx7A5aS/7FEFv0HIWGt0fwLCes2l+OjGfis54JxO84GWJll6KwKDb30aU
 V4gpeyxN3atLP0dSbcxIyF4HbsqJBwGnXNbXtr6kecKXIhdE7uCBXzFBn21UY67oyl
 Ghlj9T2vuJ3fBtl3U0JhQ4BV6Y4Iq1nfyI8oI/Bo=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4615JAoE029977
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 1 Jul 2024 00:19:10 -0500
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 1
 Jul 2024 00:19:10 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 1 Jul 2024 00:19:10 -0500
Received: from [127.0.1.1] (uda0497581.dhcp.ti.com [10.24.68.185])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4615IpvZ059517;
 Mon, 1 Jul 2024 00:19:07 -0500
From: Manorit Chawdhry <m-chawdhry@ti.com>
Date: Mon, 1 Jul 2024 10:48:52 +0530
Subject: [PATCH v2 4/4] include: env: ti_common: Remove findfdt
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240701-b4-upstream-streamline-platform-v2-4-7539ff066b58@ti.com>
References: <20240701-b4-upstream-streamline-platform-v2-0-7539ff066b58@ti.com>
In-Reply-To: <20240701-b4-upstream-streamline-platform-v2-0-7539ff066b58@ti.com>
To: Vignesh Raghavendra <vigneshr@ti.com>, Bryan Brattlof <bb@ti.com>, Tom
 Rini <trini@konsulko.com>, Vaishnav Achath <vaishnav.a@ti.com>, Jayesh
 Choudhary <j-choudhary@ti.com>, Joe Hershberger <joe.hershberger@ni.com>
CC: <u-boot@lists.denx.de>, Neha Malcom Francis <n-francis@ti.com>, Nishanth
 Menon <nm@ti.com>, Udit Kumar <u-kumar1@ti.com>,
 Dhruva Gole <d-gole@ti.com>, Manorit Chawdhry <m-chawdhry@ti.com>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1719811131; l=1031;
 i=m-chawdhry@ti.com; s=20231127; h=from:subject:message-id;
 bh=yy1yFsTeDTHYO9EO63Y+XzVML+qlLsJE4tVJsvGvZyU=;
 b=rDhHLQgP3EJn/oMWL1mDCkQFBEJcODm2NEppmUZwAw6lSu7SiZyao/x+U4D/tvZfY+t0wvfFc
 VQ5Ixz0d26ABrDoIhe5xBFMDqzsktcVJ+k787RgPpmb52w82rwnZKPO
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

From: Dhruva Gole <d-gole@ti.com>

findfdt is the legacy approach to find fdt and platforms have moved away
from this and don't define this anymore. This causes an error that may
seem alarming but is harmless. Remove it from the bootcmd_ti_mmc to
avoid any panic and confusion.

Signed-off-by: Dhruva Gole <d-gole@ti.com>
Signed-off-by: Manorit Chawdhry <m-chawdhry@ti.com>
---
 include/env/ti/ti_common.env | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/env/ti/ti_common.env b/include/env/ti/ti_common.env
index c5c36421770c..7029d12bf203 100644
--- a/include/env/ti/ti_common.env
+++ b/include/env/ti/ti_common.env
@@ -25,7 +25,7 @@ get_fit_config=setexpr name_fit_config gsub / _ conf-${fdtfile}
 run_fit=run get_fit_config; bootm ${addr_fit}#${name_fit_config}${overlaystring}
 do_main_cpsw0_qsgmii_phyinit=0
 bootcmd_ti_mmc=
-	run findfdt; run init_${boot};
+	run init_${boot};
 #if CONFIG_CMD_REMOTEPROC
 	if test ${do_main_cpsw0_qsgmii_phyinit} -eq 1;
 		then run main_cpsw0_qsgmii_phyinit;

-- 
2.45.1

