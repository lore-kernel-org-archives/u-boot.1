Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12B71E92FE1
	for <u-boot@archiver.kernel.org>; Fri,  6 Oct 2023 04:47:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D080D86DB4;
	Fri,  6 Oct 2023 06:46:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="j+2rMPyk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BAAD686D30; Fri,  6 Oct 2023 06:46:22 +0200 (CEST)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0727186DC8
 for <u-boot@lists.denx.de>; Fri,  6 Oct 2023 06:46:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=none smtp.mailfrom=m-chawdhry@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3964kDuH102773;
 Thu, 5 Oct 2023 23:46:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1696567573;
 bh=MOpGUV7qbL+eYmbtbafh9Brb11ANNiwp0Sv2OYc0Jnc=;
 h=From:Date:Subject:References:In-Reply-To:To:CC;
 b=j+2rMPykedUTAy0p/KbTzdyK8sAJLeSoz270DP6O6o95rq0gBgbbdSumk9wg0eKyX
 OjJF1iDzyIJGUNZkKQmohbSBR1UlCNrWp+TFXf/a5IghnF7dNhj0L2CAVtvHyrg8Ov
 t6QqRRO8X7b8GioZoG/7MzsHsF1WvEZCTV3i4ems=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3964kDhl003766
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 5 Oct 2023 23:46:13 -0500
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 5
 Oct 2023 23:46:12 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 5 Oct 2023 23:46:12 -0500
Received: from [127.0.1.1] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
 by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3964jxUj030710;
 Thu, 5 Oct 2023 23:46:10 -0500
From: Manorit Chawdhry <m-chawdhry@ti.com>
Date: Fri, 6 Oct 2023 10:15:57 +0530
Subject: [PATCH v7 3/7] arm: mach-k3: j721s2: Add mcu_timer0 id to the dev list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20231006-b4-upstream-j721s2-r5-pinmux-v7-3-5d31f765dd2c@ti.com>
References: <20231006-b4-upstream-j721s2-r5-pinmux-v7-0-5d31f765dd2c@ti.com>
In-Reply-To: <20231006-b4-upstream-j721s2-r5-pinmux-v7-0-5d31f765dd2c@ti.com>
To: Tom Rini <trini@konsulko.com>
CC: <u-boot@lists.denx.de>, Nishanth Menon <nm@ti.com>, Vignesh Raghavendra
 <vigneshr@ti.com>, Neha Malcom Francis <n-francis@ti.com>, Udit Kumar
 <u-kumar1@ti.com>, Reid Tonking <reidt@ti.com>, Apurva Nandan
 <a-nandan@ti.com>, Andrew Davis <afd@ti.com>, Manorit Chawdhry
 <m-chawdhry@ti.com>
X-Mailer: b4 0.13-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1696567559; l=842;
 i=m-chawdhry@ti.com; s=20230324; h=from:subject:message-id;
 bh=6MeLZyJqU8lB+gfBJlD+NNTyUFV3FQVoNJXyOkd8nhI=;
 b=YEcgFa3adC0xO1C8sqI4/e3DXhnhfmrQtepX2V/6KKyu0VcdFNswRe4Xb+1s4+VQxH5hfKkH7
 qh+x3QHwdrEA/K0Yrc8MvY56KeARYtL+Hk9VOc7r0MYuGovX6CP26fC
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

