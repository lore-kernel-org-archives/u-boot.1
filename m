Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C576EC874B
	for <u-boot@archiver.kernel.org>; Thu,  7 Sep 2023 18:06:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 578F8863F9;
	Thu,  7 Sep 2023 20:06:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="oNLN77yk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 10675869D7; Thu,  7 Sep 2023 20:06:43 +0200 (CEST)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8709785C98
 for <u-boot@lists.denx.de>; Thu,  7 Sep 2023 20:06:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=reidt@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 387I6btf123683;
 Thu, 7 Sep 2023 13:06:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1694109997;
 bh=n/EPmQ2yHg3pdBYHplX9pM9X4UMLpmjkpS3F5q22ibs=;
 h=From:To:CC:Subject:Date;
 b=oNLN77ykD+uKv4Gml4lXFc4DkBTlRCWms+gzxkBMHf0Yje724zdlWmGK2uLAGSQq5
 PAXcx6EY8oDEpiWU3x/cqAvtjggoDdaiSa4rAey3fiecRWmk3n0W9Wj92HkL3cB7FN
 iOM9+M4txbyztmbK31+/yTt1JbpyTRRIAxgSiIbQ=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 387I6bI0106405
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 7 Sep 2023 13:06:37 -0500
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 7
 Sep 2023 13:06:37 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 7 Sep 2023 13:06:37 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
 by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 387I6bPP064237;
 Thu, 7 Sep 2023 13:06:37 -0500
From: Reid Tonking <reidt@ti.com>
To: <trini@konsulko.com>
CC: <u-boot@lists.denx.de>, <nm@ti.com>, <u-kumar1@ti.com>, <vigneshr@ti.com>, 
 <m-chawdhry@ti.com>, Reid Tonking <reidt@ti.com>, Neha Francis
 <n-francis@ti.com>
Subject: [PATCH] drivers: misc: k3_avs: Add Linux compatibles to maintain sync
Date: Thu, 7 Sep 2023 13:06:35 -0500
Message-ID: <20230907180635.89011-1-reidt@ti.com>
X-Mailer: git-send-email 2.34.1
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

The ti,j7200-vtm and ti,j721e-vtm compatibles are used for voltage
and thermal monitoring (VTM) by (drivers/thermal/k3_j72xx_bandgap.c)
in Linux, but the same hardware is used for adaptive voltage scaling
(AVS) in u-boot, This brings both drivers in line with the same
compatibles.

Since the j7200 uses the config as the j721e, the data is inherited
from j721e vs creating a duplicate

Signed-off-by: Neha Francis <n-francis@ti.com>
Signed-off-by: Reid Tonking <reidt@ti.com>
---
In preparation for syncing k3 socs j721e & j7200, a single patch is
being submitted to avoid having dependency complications [0]. This
patch will be a dependency for the following series [1] [2], each
with another version to follow.

[0] https://lore.kernel.org/u-boot/20230907150858.3l6q2yxyfgdx3jvn@mulled/T/#mf52d9105756329549871144fe93c1149d1c26ef3
[1] https://lore.kernel.org/u-boot/20230907150858.3l6q2yxyfgdx3jvn@mulled/T/#m878091acccecbf29e27e400b3acbfd35c025e396
[2] https://lore.kernel.org/u-boot/20230905181309.61666-1-reidt@ti.com/T/#m8d254c1d912aae3b636fadb23a0c8aacdd9ea484


 drivers/misc/k3_avs.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/misc/k3_avs.c b/drivers/misc/k3_avs.c
index 840148d090..acfc731845 100644
--- a/drivers/misc/k3_avs.c
+++ b/drivers/misc/k3_avs.c
@@ -382,6 +382,8 @@ static struct vd_config am654_vd_config = {
 static const struct udevice_id k3_avs_ids[] = {
 	{ .compatible = "ti,am654-avs", .data = (ulong)&am654_vd_config },
 	{ .compatible = "ti,j721e-avs", .data = (ulong)&j721e_vd_config },
+	{ .compatible = "ti,j721e-vtm", .data = (ulong)&j721e_vd_config },
+	{ .compatible = "ti,j7200-vtm", .data = (ulong)&j721e_vd_config },
 	{}
 };
 
-- 
2.34.1

