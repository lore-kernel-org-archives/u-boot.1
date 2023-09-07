Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C18DEC8730
	for <u-boot@archiver.kernel.org>; Thu,  7 Sep 2023 14:15:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AE56D869D3;
	Thu,  7 Sep 2023 16:14:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="KAAywkzS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4010C869F7; Thu,  7 Sep 2023 16:14:36 +0200 (CEST)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6E3D7863F9
 for <u-boot@lists.denx.de>; Thu,  7 Sep 2023 16:14:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=n-francis@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 387EEVHj008719;
 Thu, 7 Sep 2023 09:14:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1694096071;
 bh=wbu1SWQ+7ltQJAuKD9GMMaWGqk/6bWYxUItHHn6boJg=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=KAAywkzSkgSGoCEMjLF9ebCOqjS7R2IhhmCy+2+rKonZ4BvH/WtMkj4rn8nf3rhj1
 3Gi6UMnLmtUnKU0JIvUb/yGa3hqWCb5Gi8s1DF0Bv9YU6M2T5F1iQ5FUgr7ubtP6ir
 jOYAqhBHam2HnTCbSUpb+ZpyHHsFOSqmyu7fCq9w=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 387EEV4v051517
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 7 Sep 2023 09:14:31 -0500
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 7
 Sep 2023 09:14:28 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 7 Sep 2023 09:14:28 -0500
Received: from a0497641-HP-Z2-Tower-G9-Workstation-Desktop-PC.dhcp.ti.com
 (ileaxei01-snat2.itg.ti.com [10.180.69.6])
 by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 387EE70i046139;
 Thu, 7 Sep 2023 09:14:24 -0500
From: Neha Malcom Francis <n-francis@ti.com>
To: <trini@konsulko.com>, <sjg@chromium.org>, <nm@ti.com>
CC: <u-boot@lists.denx.de>, <vigneshr@ti.com>, <u-kumar1@ti.com>,
 <reidt@ti.com>, <m-chawdhry@ti.com>, <afd@ti.com>,
 <sinthu.raja@ti.com>, <gadiyar@ti.com>, <a-nandan@ti.com>,
 <vaishnav.a@ti.com>, <n-francis@ti.com>
Subject: [PATCH v2 4/7] drivers: firmware: ti_sci: Get SCI revision only if
 TIFS/SYSFW is up
Date: Thu, 7 Sep 2023 19:44:04 +0530
Message-ID: <20230907141407.382215-5-n-francis@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230907141407.382215-1-n-francis@ti.com>
References: <20230907141407.382215-1-n-francis@ti.com>
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

While setting up necessary dependent clocks and power domains, we end up
probing the ti_sci driver before TIFS/SYSFW has been loaded in the case
of legacy boot flow devices. This leads to panic when getting the SCI
revision. Return the revision only if it is combined boot flow. Also
ensure that after TIFS/SYSFW comes up we run ti_sci_cmd_get_revision
again so we print the revision right.

Signed-off-by: Neha Malcom Francis <n-francis@ti.com>
---
 drivers/firmware/ti_sci.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/firmware/ti_sci.c b/drivers/firmware/ti_sci.c
index 72f572d824..6a85d202f2 100644
--- a/drivers/firmware/ti_sci.c
+++ b/drivers/firmware/ti_sci.c
@@ -2703,6 +2703,9 @@ struct ti_sci_handle *ti_sci_get_handle_from_sysfw(struct udevice *sci_dev)
 	if (!handle)
 		return ERR_PTR(-EINVAL);
 
+	/* May have been skipped in case TIFS/SYSFW had come up later */
+	ti_sci_cmd_get_revision(handle);
+
 	return handle;
 }
 
@@ -2825,7 +2828,11 @@ static int ti_sci_probe(struct udevice *dev)
 	list_add_tail(&info->list, &ti_sci_list);
 	ti_sci_setup_ops(info);
 
-	ret = ti_sci_cmd_get_revision(&info->handle);
+	/* Get SCI revision ONLY if we are real */
+	if (!IS_ENABLED(CONFIG_K3_DM_FW))
+		ret = ti_sci_cmd_get_revision(&info->handle);
+	else
+		ret = 0;
 
 	INIT_LIST_HEAD(&info->dev_list);
 
-- 
2.34.1

