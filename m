Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2E46CFC287
	for <u-boot@archiver.kernel.org>; Tue, 15 Oct 2024 10:52:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DC15E89192;
	Tue, 15 Oct 2024 12:52:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="wT9ZitET";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C538C89189; Tue, 15 Oct 2024 12:52:37 +0200 (CEST)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 277FD890F2
 for <u-boot@lists.denx.de>; Tue, 15 Oct 2024 12:52:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=m-chawdhry@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 49FAqUAD128009;
 Tue, 15 Oct 2024 05:52:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1728989550;
 bh=yOZCLrBWBVHSS4mYwF5S5uKpd/juRbntBcIHcicBUp0=;
 h=From:Date:Subject:References:In-Reply-To:To:CC;
 b=wT9ZitETIEzn0Mf3r4L7w+WOoodFT+KK74ye7p6MDSdCZengNRoyprIBCPg65UI9p
 gv9O1q52L+o3eZi5WiqNS6drt+c3K/Hg4Twz3OR7fZAzcE+UKGCdZXY0lSgtjUm8bz
 CrXNxbt/wFCb7oR2g56bs9hg814lfOpH3MB4Zeh4=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 49FAqUjt095927
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 15 Oct 2024 05:52:30 -0500
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 15
 Oct 2024 05:52:30 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 15 Oct 2024 05:52:30 -0500
Received: from [127.0.1.1] (uda0497581.dhcp.ti.com [10.24.68.185])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 49FAqJbg044559;
 Tue, 15 Oct 2024 05:52:27 -0500
From: Manorit Chawdhry <m-chawdhry@ti.com>
Date: Tue, 15 Oct 2024 16:22:18 +0530
Subject: [PATCH v5 2/7] drivers: misc: k3_avs: Check return code while
 programming AVS
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20241015-b4-upstream-j721s2-avs-v5-2-5c8087387dc5@ti.com>
References: <20241015-b4-upstream-j721s2-avs-v5-0-5c8087387dc5@ti.com>
In-Reply-To: <20241015-b4-upstream-j721s2-avs-v5-0-5c8087387dc5@ti.com>
To: Jaehoon Chung <jh80.chung@samsung.com>
CC: <u-boot@lists.denx.de>, Neha Malcom Francis <n-francis@ti.com>, Keerthy J
 <j-keerthy@ti.com>, Udit Kumar <u-kumar1@ti.com>, Aniket Limaye
 <a-limaye@ti.com>, Tom Rini <trini@konsulko.com>, Vignesh Raghavendra
 <vigneshr@ti.com>, Andrew Davis <afd@ti.com>,
 Nishanth Menon <nm@ti.com>, Simon Glass <sjg@chromium.org>,
 Manorit Chawdhry <m-chawdhry@ti.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1728989539; l=926;
 i=m-chawdhry@ti.com; s=20231127; h=from:subject:message-id;
 bh=hwFi7Y4a8k47VeO7v1OmrvYPp5WdMPVaY1GtTAYPyq8=;
 b=WzGIvjIo3g+uxc0q/Miwv5ad/P+j71/EyX/m5MW9/6DfFZjyYV9KXQXjhQxjmbD12mmQGS/6h
 VQLMF0SkDwGCRTS+OO3DYAR+Hr25MUgWYOiSYectL59O8/xFg3bStw5
X-Developer-Key: i=m-chawdhry@ti.com; a=ed25519;
 pk=fsr6Tm39TvsTgfyfFQLk+nnqIz2sBA1PthfqqfiiYSs=
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
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
Reviewed-by: Udit Kumar <u-kumar1@ti.com>
Signed-off-by: Manorit Chawdhry <m-chawdhry@ti.com>
---
 drivers/misc/k3_avs.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/misc/k3_avs.c b/drivers/misc/k3_avs.c
index 87471cc3b16a..66ad747f2dd8 100644
--- a/drivers/misc/k3_avs.c
+++ b/drivers/misc/k3_avs.c
@@ -391,7 +391,10 @@ static int k3_avs_probe(struct udevice *dev)
 		if (vd->flags & VD_FLAG_INIT_DONE)
 			continue;
 
-		k3_avs_program_voltage(priv, vd, vd->opp);
+		ret = k3_avs_program_voltage(priv, vd, vd->opp);
+		if (ret)
+			dev_warn(dev, "Could not program AVS voltage for VD%d, vd->opp=%d, ret=%d\n",
+				 vd->id, vd->opp, ret);
 	}
 
 	if (!device_is_compatible(priv->dev, "ti,am654-avs"))

-- 
2.46.0

