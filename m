Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D5B5C369DC
	for <u-boot@archiver.kernel.org>; Tue, 29 Apr 2025 17:15:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E56B882A64;
	Tue, 29 Apr 2025 19:15:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="C+i2wm9d";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A2AC882A65; Tue, 29 Apr 2025 19:15:01 +0200 (CEST)
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 43D8D829A1
 for <u-boot@lists.denx.de>; Tue, 29 Apr 2025 19:14:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-kumar1@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 53THEtFv3727760
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 29 Apr 2025 12:14:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1745946895;
 bh=UFJ/3GwyN1s0RaDLrh8gM88mdmngNei5ew3ZA7DuGWY=;
 h=From:To:CC:Subject:Date;
 b=C+i2wm9dY2ththhWHwOGPZxraD+e84cOOVaZVJA3XEFFpYb46Hj5Nh4WdVkP9L4N0
 0qaOtQQ5jsjUDjPwHLYBz+9r8C2dlZ5yLhY2amS4LvKcECRuS6wnIZ7ARBqVYC7fwT
 1Ep6JqWPQGPz38PViPDDvkNHLURP8w1KaKBWAzYw=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 53THEtqv010339
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 29 Apr 2025 12:14:55 -0500
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 29
 Apr 2025 12:14:55 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 29 Apr 2025 12:14:55 -0500
Received: from udit-HP-Z2-Tower-G9-Workstation-Desktop-PC.dhcp.ti.com
 (udit-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [10.24.69.198])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 53THEp6Q032766;
 Tue, 29 Apr 2025 12:14:52 -0500
From: Udit Kumar <u-kumar1@ti.com>
To: <trini@konsulko.com>, <u-boot@lists.denx.de>
CC: <nm@ti.com>, <d-gole@ti.com>, <n-francis@ti.com>, <vigneshr@ti.com>,
 <m-chawdhry@ti.com>, <ilias.apalodimas@linaro.org>, <c-vankar@ti.com>, Udit
 Kumar <u-kumar1@ti.com>
Subject: [PATCH v2] firmware: ti_sci: Add Initialization of dev_info head node
Date: Tue, 29 Apr 2025 22:44:40 +0530
Message-ID: <20250429171440.2524557-1-u-kumar1@ti.com>
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
While at this, move init of list before usages in both functions.

Fixes: 5d5a699855a7("firmware: ti_sci: Add support for Resoure Management at R5 SPL stage")
Reviewed-by: Neha Malcom Francis <n-francis@ti.com>
Signed-off-by: Udit Kumar <u-kumar1@ti.com>
---
Changes in v2:
1) moved init of list before adding node
2) collected R/B of v1
Link to v1 https://lore.kernel.org/all/20250429074950.2262104-1-u-kumar1@ti.com/

 drivers/firmware/ti_sci.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/firmware/ti_sci.c b/drivers/firmware/ti_sci.c
index 54d6689ce78..344df9454b3 100644
--- a/drivers/firmware/ti_sci.c
+++ b/drivers/firmware/ti_sci.c
@@ -2845,11 +2845,11 @@ static int ti_sci_probe(struct udevice *dev)
 	info->dev = dev;
 	info->seq = 0xA;
 
+	INIT_LIST_HEAD(&info->dev_list);
+
 	list_add_tail(&info->list, &ti_sci_list);
 	ti_sci_setup_ops(info);
 
-	INIT_LIST_HEAD(&info->dev_list);
-
 	if (IS_ENABLED(CONFIG_SYSRESET_TI_SCI)) {
 		ret = device_bind_driver(dev, "ti-sci-sysreset", "sysreset", NULL);
 		if (ret)
@@ -2889,6 +2889,8 @@ static __maybe_unused int ti_sci_dm_probe(struct udevice *dev)
 	info->dev = dev;
 	info->seq = 0xA;
 
+	INIT_LIST_HEAD(&info->dev_list);
+
 	list_add_tail(&info->list, &ti_sci_list);
 
 	ops = &info->handle.ops;
-- 
2.34.1

