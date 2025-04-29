Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26CECC369CB
	for <u-boot@archiver.kernel.org>; Tue, 29 Apr 2025 07:50:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4426980EFB;
	Tue, 29 Apr 2025 09:50:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="bibjHGHW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9050581E0F; Tue, 29 Apr 2025 09:50:03 +0200 (CEST)
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DA4AB80BAD
 for <u-boot@lists.denx.de>; Tue, 29 Apr 2025 09:50:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-kumar1@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 53T7nwE63789930
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 29 Apr 2025 02:49:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1745912998;
 bh=xVHj4+zILYC1YLH0GkaFbvDuqmLe/rb9P0kdM4nuXOA=;
 h=From:To:CC:Subject:Date;
 b=bibjHGHWGIv+oxX3u6lElzYQYFhY1Q6Qeffe3OF5G+qYla1eiYdzsIdHBIYCWKuXR
 zk2B58R6LFMlcEHHbQRMPVpOItadfznTlQvP1HhIaSIVzF892DZowGkEJavYZMM6j1
 Uy38NQmaLdjBvji22T2m5WpoEFMJtUlwbAXp21co=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 53T7nwTf009414
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 29 Apr 2025 02:49:58 -0500
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 29
 Apr 2025 02:49:57 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 29 Apr 2025 02:49:57 -0500
Received: from udit-HP-Z2-Tower-G9-Workstation-Desktop-PC.dhcp.ti.com
 (udit-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [10.24.69.198])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 53T7nsrX113631;
 Tue, 29 Apr 2025 02:49:54 -0500
From: Udit Kumar <u-kumar1@ti.com>
To: <trini@konsulko.com>, <u-boot@lists.denx.de>
CC: <nm@ti.com>, <d-gole@ti.com>, <n-francis@ti.com>, <vigneshr@ti.com>,
 <m-chawdhry@ti.com>, <ilias.apalodimas@linaro.org>, <c-vankar@ti.com>, Udit
 Kumar <u-kumar1@ti.com>
Subject: [PATCH] firmware: ti_sci: Add Initialization of dev_info head node
Date: Tue, 29 Apr 2025 13:19:50 +0530
Message-ID: <20250429074950.2262104-1-u-kumar1@ti.com>
X-Mailer: git-send-email 2.34.1
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

On K3 devices two drivers ti_sci and ti_sci_dm are supporting firmware
functions. At run time one of driver is used.

Driver ti_sci already initializing head for dev_list in its probe
function, but it was missed in ti_sci_dm driver.

So add head list init support for ti_sci_dm driver.

Fixes: 5d5a699855a7("firmware: ti_sci: Add support for Resoure Management at R5 SPL stage")

Signed-off-by: Udit Kumar <u-kumar1@ti.com>
---
 drivers/firmware/ti_sci.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/firmware/ti_sci.c b/drivers/firmware/ti_sci.c
index 54d6689ce78..a599de9e013 100644
--- a/drivers/firmware/ti_sci.c
+++ b/drivers/firmware/ti_sci.c
@@ -2891,6 +2891,8 @@ static __maybe_unused int ti_sci_dm_probe(struct udevice *dev)
 
 	list_add_tail(&info->list, &ti_sci_list);
 
+	INIT_LIST_HEAD(&info->dev_list);
+
 	ops = &info->handle.ops;
 
 	rm_core_ops = &ops->rm_core_ops;
-- 
2.34.1

