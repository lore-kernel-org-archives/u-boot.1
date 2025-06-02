Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 673E9C5AD49
	for <u-boot@archiver.kernel.org>; Mon,  2 Jun 2025 14:50:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DD24F80BAE;
	Mon,  2 Jun 2025 16:50:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="r4i1vTFq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EBB4D82A76; Mon,  2 Jun 2025 16:50:32 +0200 (CEST)
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D7E5B8006D
 for <u-boot@lists.denx.de>; Mon,  2 Jun 2025 16:50:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=b-padhi@ti.com
Received: from fllvem-sh04.itg.ti.com ([10.64.41.54])
 by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTP id 552EoTuc271687;
 Mon, 2 Jun 2025 09:50:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1748875829;
 bh=o4FfYjXOpWqjkfnN0JC0422DajmRMYkBn3lM8cfMPPA=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=r4i1vTFqO2oMi29vtSXQ1if1MY1e7EVbja2xEbE8kLuWFGnJjRP7m4thCEpVRK0Pd
 tFjejdE6CN+Mo7CWdIzc9+4Guc3t19eM9pBe4XSkNTjDpe8ZcP3/Rp7PdNCPBDgrWN
 VnYNUtP6pb/ZBgaGQoiBAiPnkteOk1Z2Ui7/srNA=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
 by fllvem-sh04.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 552EoTqA2942472
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Mon, 2 Jun 2025 09:50:29 -0500
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 2
 Jun 2025 09:50:29 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 2 Jun 2025 09:50:29 -0500
Received: from uda0510294.dhcp.ti.com (uda0510294.dhcp.ti.com [172.24.227.151])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 552EoGpM3118869;
 Mon, 2 Jun 2025 09:50:26 -0500
From: Beleswar Padhi <b-padhi@ti.com>
To: <trini@konsulko.com>
CC: <afd@ti.com>, <nm@ti.com>, <hnagalla@ti.com>, <n-francis@ti.com>,
 <jm@ti.com>, <u-kumar1@ti.com>, <m-shah@ti.com>, <b-padhi@ti.com>,
 <u-boot@lists.denx.de>
Subject: [PATCH v2 3/4] remoteproc: k3-r5: Acquire processor control before
 reset ops
Date: Mon, 2 Jun 2025 20:20:14 +0530
Message-ID: <20250602145015.1274726-4-b-padhi@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250602145015.1274726-1-b-padhi@ti.com>
References: <20250602145015.1274726-1-b-padhi@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
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

Acquire processor control before doing core reset operations in probe
routine. Release the control afterwards, so that it can be acquired
during core loading operations.

Signed-off-by: Beleswar Padhi <b-padhi@ti.com>
---
 drivers/remoteproc/ti_k3_r5f_rproc.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/remoteproc/ti_k3_r5f_rproc.c b/drivers/remoteproc/ti_k3_r5f_rproc.c
index 57268e7f8ff..f4bab6868ee 100644
--- a/drivers/remoteproc/ti_k3_r5f_rproc.c
+++ b/drivers/remoteproc/ti_k3_r5f_rproc.c
@@ -834,8 +834,14 @@ static int k3_r5f_probe(struct udevice *dev)
 			return 0;
 		}
 
+		ret = k3_r5f_proc_request(core);
+		if (ret)
+			return ret;
+
 		/* Make sure Local reset is asserted. Redundant? */
 		reset_assert(&core->reset);
+
+		ti_sci_proc_release(&core->tsp);
 	}
 
 	ret = k3_r5f_rproc_configure(core);
-- 
2.34.1

