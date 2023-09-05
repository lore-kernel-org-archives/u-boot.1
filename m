Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C023BCA0FFC
	for <u-boot@archiver.kernel.org>; Tue,  5 Sep 2023 18:13:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3367B869B1;
	Tue,  5 Sep 2023 20:13:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="lmoiKXYu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 19F6786989; Tue,  5 Sep 2023 20:13:38 +0200 (CEST)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7764E869A3
 for <u-boot@lists.denx.de>; Tue,  5 Sep 2023 20:13:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=reidt@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 385IDXwG079058;
 Tue, 5 Sep 2023 13:13:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1693937613;
 bh=pJdT+XHjF3OuIutF4OeZYPJ/B7edMjt5MQJDmopZf9w=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=lmoiKXYuqFMIOirOr+6oijVnZAivRBhs+TYkVR3DnCI8QKa6YP960+QsKeUJD7o57
 Yo0Ux/2h07MEdId2jowbpqgWrhv5qOMZk+2Fa5TseNdMpQnhTV2I8vx9UnHkExG6Vo
 AWHiKHPI2EZKgmq1v8pe4wCZujkG0ACKHR2kUKL8=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 385IDXGe005067
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 5 Sep 2023 13:13:33 -0500
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 5
 Sep 2023 13:13:32 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 5 Sep 2023 13:13:32 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
 by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 385IDW4p017313;
 Tue, 5 Sep 2023 13:13:32 -0500
From: Reid Tonking <reidt@ti.com>
To: <trini@konsulko.com>
CC: <u-boot@lists.denx.de>, <n-francis@ti.com>, <u-kumar1@ti.com>,
 <afd@ti.com>, <nm@ti.com>, <vigneshr@ti.com>, <m-chawdhry@ti.com>, Reid
 Tonking <reidt@ti.com>
Subject: [PATCH 1/3] drivers: misc: k3_avs: Add Linux compatible to enable avs
 in u-boot
Date: Tue, 5 Sep 2023 13:13:07 -0500
Message-ID: <20230905181309.61666-2-reidt@ti.com>
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

The ti,j7200-vtm compatible is used for voltage and thermal monitoring 
(VTM) by (drivers/thermal/k3_j72xx_bandgap.c) in Linux, but the same 
hardware is used for adaptive voltage scaling (AVS) in u-boot, This brings
both drivers in line with the same compatible. Since the j7200 uses the 
config as the j721e, the data is inherited from j721e vs creating a 
duplicate in all but name.

Signed-off-by: Reid Tonking <reidt@ti.com>
---
 drivers/misc/k3_avs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/misc/k3_avs.c b/drivers/misc/k3_avs.c
index 840148d090..f7936017ba 100644
--- a/drivers/misc/k3_avs.c
+++ b/drivers/misc/k3_avs.c
@@ -382,7 +382,7 @@ static struct vd_config am654_vd_config = {
 static const struct udevice_id k3_avs_ids[] = {
 	{ .compatible = "ti,am654-avs", .data = (ulong)&am654_vd_config },
 	{ .compatible = "ti,j721e-avs", .data = (ulong)&j721e_vd_config },
-	{}
+	{ .compatible = "ti,j7200-vtm", .data = (ulong)&j721e_vd_config }
 };
 
 U_BOOT_DRIVER(k3_avs) = {
-- 
2.34.1

