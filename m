Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB28DCD54A8
	for <u-boot@archiver.kernel.org>; Tue, 19 Sep 2023 08:40:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E991586B26;
	Tue, 19 Sep 2023 10:39:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="Z1YDRQuG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0564386B23; Tue, 19 Sep 2023 10:39:53 +0200 (CEST)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D7C7686A26
 for <u-boot@lists.denx.de>; Tue, 19 Sep 2023 10:39:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=m-chawdhry@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 38J8dm3C110858;
 Tue, 19 Sep 2023 03:39:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1695112788;
 bh=MOpGUV7qbL+eYmbtbafh9Brb11ANNiwp0Sv2OYc0Jnc=;
 h=From:Date:Subject:References:In-Reply-To:To:CC;
 b=Z1YDRQuGLPQw2jXIDPeyf2QDuaMxILqJF3/45h7XHscZJyKjpo9Y77cnNmd1ZsI+5
 1XTmIco8ecMGShppkfwtTHCMiFnjJUDa4ZmiTty5IlPatxjc0LglfVKkLr2eC8sOjS
 0tptXDtbs1ZGh61hU/CgbcwO4/YlPBCKAKRzNGvM=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 38J8dmYp018742
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 19 Sep 2023 03:39:48 -0500
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 19
 Sep 2023 03:39:48 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 19 Sep 2023 03:39:48 -0500
Received: from [127.0.1.1] (ileaxei01-snat.itg.ti.com [10.180.69.5])
 by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 38J8dYu8001331;
 Tue, 19 Sep 2023 03:39:45 -0500
From: Manorit Chawdhry <m-chawdhry@ti.com>
Date: Tue, 19 Sep 2023 14:09:33 +0530
Subject: [PATCH] arm: mach-k3: j721s2: Add mcu_timer0 id to the dev list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20230919-b4-upstream-j721s2-r5-pinmux-v5-3-a54d6ee26310@ti.com>
References: <20230919-b4-upstream-j721s2-r5-pinmux-v5-0-a54d6ee26310@ti.com>
In-Reply-To: <20230919-b4-upstream-j721s2-r5-pinmux-v5-0-a54d6ee26310@ti.com>
To: Tom Rini <trini@konsulko.com>
CC: <u-boot@lists.denx.de>, Nishanth Menon <nm@ti.com>, Vignesh Raghavendra
 <vigneshr@ti.com>, Neha Malcom Francis <n-francis@ti.com>, Udit Kumar
 <u-kumar1@ti.com>, Reid Tonking <reidt@ti.com>, Apurva Nandan
 <a-nandan@ti.com>, Andrew Davis <afd@ti.com>, Manorit Chawdhry
 <m-chawdhry@ti.com>
X-Mailer: b4 0.13-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1695112774; l=842;
 i=m-chawdhry@ti.com; s=20230324; h=from:subject:message-id;
 bh=6MeLZyJqU8lB+gfBJlD+NNTyUFV3FQVoNJXyOkd8nhI=;
 b=qI6cKn2rgmFivTnuGY4C5H7s8Da4ZnjwHu7wSurTQQ0Ngrp7nyQH2nQO1Ga0r0kV2VJ3QfRCT
 lPSgCPGOM/iAyT7bKKLrOz+mTAcIg4wU6IWcddHhGyrBIQnkJBE5o6L
X-Developer-Key: i=m-chawdhry@ti.com; a=ed25519;
 pk=Z51yAzxWCcDqKRLHiDBrUxIdXbB21R89ms8xgECdiak=
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

mcu_timer0 is used by u-boot as the tick-timer. Add it to the soc
devices lsit so it an be enabled via the k3 power controller.

Reviewed-by: Neha Malcom Francis <n-francis@ti.com>
Reviewed-by: Nishanth Menon <nm@ti.com>
Signed-off-by: Manorit Chawdhry <m-chawdhry@ti.com>
---
 arch/arm/mach-k3/j721s2/dev-data.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-k3/j721s2/dev-data.c b/arch/arm/mach-k3/j721s2/dev-data.c
index 8c999a3c5a8b..df70c5e5d7c0 100644
--- a/arch/arm/mach-k3/j721s2/dev-data.c
+++ b/arch/arm/mach-k3/j721s2/dev-data.c
@@ -47,6 +47,7 @@ static struct ti_lpsc soc_lpsc_list[] = {
 };
 
 static struct ti_dev soc_dev_list[] = {
+	PSC_DEV(35, &soc_lpsc_list[0]),
 	PSC_DEV(108, &soc_lpsc_list[0]),
 	PSC_DEV(109, &soc_lpsc_list[0]),
 	PSC_DEV(110, &soc_lpsc_list[0]),

-- 
2.41.0

