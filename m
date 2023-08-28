Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1190C83F11
	for <u-boot@archiver.kernel.org>; Mon, 28 Aug 2023 11:31:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DF3AC864B7;
	Mon, 28 Aug 2023 13:31:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="qZCAkCff";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3521886496; Mon, 28 Aug 2023 13:31:36 +0200 (CEST)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8BE3786421
 for <u-boot@lists.denx.de>; Mon, 28 Aug 2023 13:31:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=n-francis@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 37SBVSkb120274;
 Mon, 28 Aug 2023 06:31:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1693222288;
 bh=Q8FYRYlxkY8fwIEeVkHQcgaUrfuzMX9aObLMliqbL8c=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=qZCAkCffbleoe+e33DeKYxP9qarEuEr7Xf2XY/mUo/cXCRDXI1k0xPUyyjsxtRuCD
 z3L/SdIIzSZKnzSS1jJMXrZ3cXx5TFlbwZ6d8GNdAHuGc7ZTBDbcalCzjTvekNjUr8
 ArIzBV3qOq6dNEPG6L8ylGfPWzQioC/1RjrWmOKc=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 37SBVRqQ116482
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 28 Aug 2023 06:31:28 -0500
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 28
 Aug 2023 06:31:27 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 28 Aug 2023 06:31:27 -0500
Received: from a0497641-HP-Z2-Tower-G9-Workstation-Desktop-PC.dhcp.ti.com
 (ileaxei01-snat2.itg.ti.com [10.180.69.6])
 by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 37SBVAlJ090695;
 Mon, 28 Aug 2023 06:31:23 -0500
From: Neha Malcom Francis <n-francis@ti.com>
To: <trini@konsulko.com>, <sjg@chromium.org>, <nm@ti.com>
CC: <u-boot@lists.denx.de>, <vigneshr@ti.com>, <u-kumar1@ti.com>,
 <reidt@ti.com>, <m-chawdhry@ti.com>, <afd@ti.com>,
 <sinthu.raja@ti.com>, <gadiyar@ti.com>, <a-nandan@ti.com>,
 <vaishnav.a@ti.com>, <n-francis@ti.com>
Subject: [PATCH v1 3/4] drivers: misc: k3_avs: Add linux compatible to
 maintain sync
Date: Mon, 28 Aug 2023 17:01:08 +0530
Message-ID: <20230828113109.2533045-4-n-francis@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230828113109.2533045-1-n-francis@ti.com>
References: <20230828113109.2533045-1-n-francis@ti.com>
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

The U-Boot AVS driver works on the VTM (Voltage and Thermal Management)
module, also used by the Linux TI Bandgap temperature sensor driver
(drivers/thermal/k3_j72xx_bandgap.c). Although the purpose and
functionalities that these two implement are different, the hardware is
the same, so ensure that their compatibles are in sync. Thus, add
ti,j721e-vtm compatible to the AVS driver.

Signed-off-by: Neha Malcom Francis <n-francis@ti.com>
---
 drivers/misc/k3_avs.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/misc/k3_avs.c b/drivers/misc/k3_avs.c
index 840148d090..3008cf9810 100644
--- a/drivers/misc/k3_avs.c
+++ b/drivers/misc/k3_avs.c
@@ -382,6 +382,7 @@ static struct vd_config am654_vd_config = {
 static const struct udevice_id k3_avs_ids[] = {
 	{ .compatible = "ti,am654-avs", .data = (ulong)&am654_vd_config },
 	{ .compatible = "ti,j721e-avs", .data = (ulong)&j721e_vd_config },
+	{ .compatible = "ti,j721e-vtm", .data = (ulong)&j721e_vd_config },
 	{}
 };
 
-- 
2.34.1

