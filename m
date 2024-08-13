Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32A5EC52D7C
	for <u-boot@archiver.kernel.org>; Tue, 13 Aug 2024 06:11:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B06D9889A2;
	Tue, 13 Aug 2024 08:10:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="R4it8Fvv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3BE088899A; Tue, 13 Aug 2024 08:10:57 +0200 (CEST)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2147C88980
 for <u-boot@lists.denx.de>; Tue, 13 Aug 2024 08:10:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=m-chawdhry@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 47D6ArT4129180;
 Tue, 13 Aug 2024 01:10:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1723529453;
 bh=1Cexl+ylkp4q+M0OsAqIjSIeSj1F4Vv7tcNhzUWtyI0=;
 h=From:Date:Subject:References:In-Reply-To:To:CC;
 b=R4it8FvvBVpxSm0SIWI5z62kc573S/HcGtsDh36bUZBJxI43pEVppdeJCNMhqRv4X
 uw7YdHuiDOWS5JCQQFrdPDqrrJHoT0eUC30a9GJwS16hS/L3Pv3XSjdwo7PUfOPesu
 WKBz9bsAuqj+O9q9NcquaaAZ1xoBzaRrrSb3QhbA=
Received: from DLEE106.ent.ti.com (dlee106.ent.ti.com [157.170.170.36])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 47D6ArTn121345
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 13 Aug 2024 01:10:53 -0500
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 13
 Aug 2024 01:10:52 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 13 Aug 2024 01:10:53 -0500
Received: from [127.0.1.1] (uda0497581.dhcp.ti.com [10.24.68.185])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 47D6AgHi016562;
 Tue, 13 Aug 2024 01:10:50 -0500
From: Manorit Chawdhry <m-chawdhry@ti.com>
Date: Tue, 13 Aug 2024 11:40:42 +0530
Subject: [PATCH v3 2/7] drivers: misc: k3_avs: Check return code while
 programming AVS
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240813-b4-upstream-j721s2-avs-v3-2-5115d93cdeb2@ti.com>
References: <20240813-b4-upstream-j721s2-avs-v3-0-5115d93cdeb2@ti.com>
In-Reply-To: <20240813-b4-upstream-j721s2-avs-v3-0-5115d93cdeb2@ti.com>
To: Jaehoon Chung <jh80.chung@samsung.com>
CC: <u-boot@lists.denx.de>, Neha Malcom Francis <n-francis@ti.com>, Keerthy J
 <j-keerthy@ti.com>, Udit Kumar <u-kumar1@ti.com>, Aniket Limaye
 <a-limaye@ti.com>, Tom Rini <trini@konsulko.com>, Vignesh Raghavendra
 <vigneshr@ti.com>, Andrew Davis <afd@ti.com>,
 Nishanth Menon <nm@ti.com>, Manorit Chawdhry <m-chawdhry@ti.com>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1723529443; l=849;
 i=m-chawdhry@ti.com; s=20231127; h=from:subject:message-id;
 bh=qzCOAFkW+UwZBYvuKJ8mEaDam77nh45sDPvS9UmWA+U=;
 b=ujdIyuCSJZUBTHJnsyr18lfMixvw5yW9mNVb+xN+bMlZ+V2k+axHQvaP2Osw/JHg2mZZiL5Ob
 gPKIHlLaEqUCARKmpG21BsKc2IdhbRJ2Cl/PO95VuYBymqj95H7s83w
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

Check if AVS could not be programmed and print a warning.

Fixes: 9d233b4e3ed6 ("misc: k3_avs: add driver for K3 Adaptive Voltage Scaling Class 0")
Signed-off-by: Manorit Chawdhry <m-chawdhry@ti.com>
---
 drivers/misc/k3_avs.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/misc/k3_avs.c b/drivers/misc/k3_avs.c
index 87471cc3b16a..568cf5b20d51 100644
--- a/drivers/misc/k3_avs.c
+++ b/drivers/misc/k3_avs.c
@@ -391,7 +391,10 @@ static int k3_avs_probe(struct udevice *dev)
 		if (vd->flags & VD_FLAG_INIT_DONE)
 			continue;
 
-		k3_avs_program_voltage(priv, vd, vd->opp);
+		ret = k3_avs_program_voltage(priv, vd, vd->opp);
+		if (ret)
+			dev_warn(dev, "Could not program AVS voltage for VD%d\n",
+				 vd->id);
 	}
 
 	if (!device_is_compatible(priv->dev, "ti,am654-avs"))

-- 
2.46.0

