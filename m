Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2441EC2BA15
	for <u-boot@archiver.kernel.org>; Tue, 18 Jun 2024 18:47:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0A3C4883B3;
	Tue, 18 Jun 2024 20:46:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="ZUbUHZ4N";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 030ED8834B; Tue, 18 Jun 2024 20:46:53 +0200 (CEST)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 81C1D88352
 for <u-boot@lists.denx.de>; Tue, 18 Jun 2024 20:46:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=hnagalla@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 45IIkm8v108152;
 Tue, 18 Jun 2024 13:46:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1718736408;
 bh=c2edeP9t3nrYllb7ZmCNQZoYAlndpq39UUEzPIVX3xY=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=ZUbUHZ4NKu+7fuekXeqOe2J9/vUNsSP0CAJ0pBCfg5CXnCd4uLYHx9B/QhZGDxFWK
 B+u9pshOTKeL9JAti1YbsYRTJqWUODDGTkdN8CVpPK+HsdF9uLv6swr2iPpFqBEmsn
 zKczKA/MDe9ZC4tOwgaC3EksECfZMQOXu5JARuGM=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 45IIkmbZ002813
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 18 Jun 2024 13:46:48 -0500
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 18
 Jun 2024 13:46:48 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 18 Jun 2024 13:46:47 -0500
Received: from localhost ([10.249.48.175])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 45IIklom046734;
 Tue, 18 Jun 2024 13:46:47 -0500
From: Hari Nagalla <hnagalla@ti.com>
To: <trini@konsulko.com>, <nm@ti.com>, <devarsht@ti.com>, <afd@ti.com>,
 <b-padhi@ti.com>, <u-boot@lists.denx.de>
CC: <u-kumar1@ti.com>, <praneeth@ti.com>
Subject: [PATCH 3/3] board: ti: am62x: Add remote proc env variables
Date: Tue, 18 Jun 2024 13:46:36 -0500
Message-ID: <20240618184636.30642-4-hnagalla@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240618184636.30642-1-hnagalla@ti.com>
References: <20240618184636.30642-1-hnagalla@ti.com>
MIME-Version: 1.0
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

Add remote proc support environment variables.

Signed-off-by: Hari Nagalla <hnagalla@ti.com>
---
 board/ti/am62x/am62x.env | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/board/ti/am62x/am62x.env b/board/ti/am62x/am62x.env
index 9cb186c2a0..f8a73d4c47 100644
--- a/board/ti/am62x/am62x.env
+++ b/board/ti/am62x/am62x.env
@@ -1,5 +1,8 @@
 #include <env/ti/ti_common.env>
 #include <env/ti/mmc.env>
+#if CONFIG_CMD_REMOTEPROC
+#include <env/ti/k3_rproc.env>
+#endif
 
 name_kern=Image
 console=ttyS2,115200n8
@@ -18,3 +21,4 @@ splashfile=ti_logo_414x97_32bpp.bmp.gz
 splashimage=0x80200000
 splashpos=m,m
 splashsource=sf
+rproc_fw_binaries= 0 /lib/firmware/am62-mcu-m4f0_0-fw
-- 
2.34.1

