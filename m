Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60952C83F3E
	for <u-boot@archiver.kernel.org>; Tue,  5 Sep 2023 18:13:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7935D869AC;
	Tue,  5 Sep 2023 20:13:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="tC8aFvZd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 140B686961; Tue,  5 Sep 2023 20:13:41 +0200 (CEST)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 70A3286989
 for <u-boot@lists.denx.de>; Tue,  5 Sep 2023 20:13:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=reidt@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 385IDaTL079064;
 Tue, 5 Sep 2023 13:13:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1693937616;
 bh=ediswSCivZ1UFoyt9jMgswqr/Gjiy3Y6qK3pgO4r7Mk=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=tC8aFvZdvhcY3LS6kkUAdb6h32HveS7dfRbFWyUr+71x3dgKi76dYIY+5WHugeEBO
 nwU0jzam49RfiKY8u+QhbCwk9B9b0QJJyCWonlmHUhmHlUWyuY8gUesYTPyXkExzJ3
 y+DI6AciCCgroZMBew+Tv9iNcyaNI9eBTbkOmZ0Y=
Received: from DLEE101.ent.ti.com (dlee101.ent.ti.com [157.170.170.31])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 385IDaDQ104208
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 5 Sep 2023 13:13:36 -0500
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 5
 Sep 2023 13:13:36 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 5 Sep 2023 13:13:36 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
 by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 385IDav5017335;
 Tue, 5 Sep 2023 13:13:36 -0500
From: Reid Tonking <reidt@ti.com>
To: <trini@konsulko.com>
CC: <u-boot@lists.denx.de>, <n-francis@ti.com>, <u-kumar1@ti.com>,
 <afd@ti.com>, <nm@ti.com>, <vigneshr@ti.com>, <m-chawdhry@ti.com>, Reid
 Tonking <reidt@ti.com>
Subject: [PATCH 2/3] arm: mach-k3: j7200: Add mcu_timer0 id to the dev list
Date: Tue, 5 Sep 2023 13:13:08 -0500
Message-ID: <20230905181309.61666-3-reidt@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230905181309.61666-1-reidt@ti.com>
References: <20230905181309.61666-1-reidt@ti.com>
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

mcu_timer0 is now used as the tick timer in u-boot, so this adds the
timer to the soc device list so it can be enabled via the k3 power 
controller.

Signed-off-by: Reid Tonking <reidt@ti.com>
---
 arch/arm/mach-k3/j7200/dev-data.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-k3/j7200/dev-data.c b/arch/arm/mach-k3/j7200/dev-data.c
index 4ddc34210e..8ce6796fd0 100644
--- a/arch/arm/mach-k3/j7200/dev-data.c
+++ b/arch/arm/mach-k3/j7200/dev-data.c
@@ -46,6 +46,7 @@ static struct ti_lpsc soc_lpsc_list[] = {
 
 static struct ti_dev soc_dev_list[] = {
 	PSC_DEV(30, &soc_lpsc_list[0]),
+	PSC_DEV(35, &soc_lpsc_list[0]),
 	PSC_DEV(61, &soc_lpsc_list[1]),
 	PSC_DEV(90, &soc_lpsc_list[2]),
 	PSC_DEV(8, &soc_lpsc_list[3]),
-- 
2.34.1

