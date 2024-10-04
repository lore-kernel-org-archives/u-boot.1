Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AAA4CFA74A
	for <u-boot@archiver.kernel.org>; Fri,  4 Oct 2024 06:25:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 740EF8843A;
	Fri,  4 Oct 2024 08:24:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="kvaM8nPn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CB5F988FFD; Fri,  4 Oct 2024 08:24:45 +0200 (CEST)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 77EA38843A
 for <u-boot@lists.denx.de>; Fri,  4 Oct 2024 08:24:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=m-chawdhry@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4946Of84010092;
 Fri, 4 Oct 2024 01:24:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1728023082;
 bh=igcQZyyjk8fjpUVoTrx6rks75SJB1AxXU/RAmuYfj9w=;
 h=From:Date:Subject:References:In-Reply-To:To:CC;
 b=kvaM8nPnbG7PwbQr8H6ZnUuo0HxCYSjq/Hz/M770bAo/NsJSCrLYH3Xu2hdLjdTra
 qkp7klwaVwoXDlj5ycSf5xXEhXj5NwQAvrAfzSY3NU91HbF7VmYo0T7RV1cT9bX2pz
 jkCk4sMTkZFoqNpeAVFmfBz5cCKGEg5btZbJ5sew=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4946Of9c116796
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 4 Oct 2024 01:24:41 -0500
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 4
 Oct 2024 01:24:41 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 4 Oct 2024 01:24:41 -0500
Received: from [127.0.1.1] (uda0497581.dhcp.ti.com [10.24.68.185])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4946OVYx100112;
 Fri, 4 Oct 2024 01:24:38 -0500
From: Manorit Chawdhry <m-chawdhry@ti.com>
Date: Fri, 4 Oct 2024 11:54:30 +0530
Subject: [PATCH v4 2/7] drivers: misc: k3_avs: Check return code while
 programming AVS
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20241004-b4-upstream-j721s2-avs-v4-2-6d71c6bab9f4@ti.com>
References: <20241004-b4-upstream-j721s2-avs-v4-0-6d71c6bab9f4@ti.com>
In-Reply-To: <20241004-b4-upstream-j721s2-avs-v4-0-6d71c6bab9f4@ti.com>
To: Jaehoon Chung <jh80.chung@samsung.com>
CC: <u-boot@lists.denx.de>, Neha Malcom Francis <n-francis@ti.com>, Keerthy J
 <j-keerthy@ti.com>, Udit Kumar <u-kumar1@ti.com>, Aniket Limaye
 <a-limaye@ti.com>, Tom Rini <trini@konsulko.com>, Vignesh Raghavendra
 <vigneshr@ti.com>, Andrew Davis <afd@ti.com>,
 Nishanth Menon <nm@ti.com>, Manorit Chawdhry <m-chawdhry@ti.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1728023071; l=1084;
 i=m-chawdhry@ti.com; s=20231127; h=from:subject:message-id;
 bh=50E6mxx0l7vf+7zeJSMH3MgWSr40YJqF8dLumfby6yQ=;
 b=9UGkdAmhyOoMkEZZQRA3t5Qr0rtZKdib5dqyC/9/OB3K82drKPS/yQIGVGxleQcC0OK7i7l/4
 YuJJ9nmY8+dDHeL4lHw0waVjNOLgiPsCrX+X14bLgSpn6lWHxe6AXR0
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

Notes:
    v4:
    Pick the following change from v2, had gotten missed.
    https://lore.kernel.org/all/fa14fd9c-2b6f-4a09-ab2f-01d90106cd2b@ti.com/

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

