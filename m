Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8110AC4332F
	for <u-boot@archiver.kernel.org>; Mon, 13 Nov 2023 14:52:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8C51587135;
	Mon, 13 Nov 2023 15:52:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="yBAsMexR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D94CA87135; Mon, 13 Nov 2023 15:51:59 +0100 (CET)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6431586689
 for <u-boot@lists.denx.de>; Mon, 13 Nov 2023 15:51:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=nm@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3ADEppqW018984;
 Mon, 13 Nov 2023 08:51:51 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1699887111;
 bh=UXQFMZYCJDvVLRCmC/cutSFt8QVCGoHAzPQgybJzZrU=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=yBAsMexRqyeo84MqUMpTuFbGefsTnc31/RihTqiwvyjwo+KfLWGP6IuDgkeLvbxZw
 hU6rN4QAF8JQOtA1ntPbm/OvzZiEQR2G0r5Hsu+SM4qZ6xaVpuT7bYeAtoAW5LG2r4
 oHD45WrnQ+lI+40o10rddkCOsbciwspNnmdpnd1A=
Received: from DFLE110.ent.ti.com (dfle110.ent.ti.com [10.64.6.31])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3ADEppsf025888
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 13 Nov 2023 08:51:51 -0600
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 13
 Nov 2023 08:51:50 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 13 Nov 2023 08:51:50 -0600
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
 by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3ADEpoUX053369;
 Mon, 13 Nov 2023 08:51:50 -0600
From: Nishanth Menon <nm@ti.com>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>
CC: Siddharth Vadapalli <s-vadapalli@ti.com>, Andrew Davis <afd@ti.com>, Neha
 Malcom Francis <n-francis@ti.com>, Roger Quadros <rogerq@kernel.org>, Bryan
 Brattlof <bb@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>, Jai Luthra
 <j-luthra@ti.com>, <u-boot@lists.denx.de>, Nishanth Menon <nm@ti.com>
Subject: [PATCH 1/8] arm: mach-k3: am62a: Add main_timer0 id to the dev list
Date: Mon, 13 Nov 2023 08:51:42 -0600
Message-ID: <20231113145149.1926732-2-nm@ti.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20231113145149.1926732-1-nm@ti.com>
References: <20231113145149.1926732-1-nm@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
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

main_timer0 is used by u-boot as the tick-timer. Add it to the soc
devices list so it an be enabled via the k3 power controller.

Signed-off-by: Nishanth Menon <nm@ti.com>
---
 arch/arm/mach-k3/am62ax/dev-data.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-k3/am62ax/dev-data.c b/arch/arm/mach-k3/am62ax/dev-data.c
index abf5d8e91aa2..6cced9efd08a 100644
--- a/arch/arm/mach-k3/am62ax/dev-data.c
+++ b/arch/arm/mach-k3/am62ax/dev-data.c
@@ -52,6 +52,7 @@ static struct ti_dev soc_dev_list[] = {
 	PSC_DEV(161, &soc_lpsc_list[5]),
 	PSC_DEV(162, &soc_lpsc_list[6]),
 	PSC_DEV(75, &soc_lpsc_list[7]),
+	PSC_DEV(36, &soc_lpsc_list[8]),
 	PSC_DEV(102, &soc_lpsc_list[8]),
 	PSC_DEV(146, &soc_lpsc_list[8]),
 	PSC_DEV(166, &soc_lpsc_list[9]),
-- 
2.40.0

