Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF928105A59E
	for <u-boot@archiver.kernel.org>; Thu, 12 Mar 2026 13:33:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 29A948420C;
	Thu, 12 Mar 2026 14:33:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="YWguSgE0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 617A484214; Thu, 12 Mar 2026 14:33:28 +0100 (CET)
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azlp170100005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c005::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 875D58407F
 for <u-boot@lists.denx.de>; Thu, 12 Mar 2026 14:33:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=p-mantena@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CqmD4xK5wb45V1mMwgn9CdSorYdJlj7h0wG62Ta1eA/mMsNfs7EC11qwFznLzVF1zUJf72r/kfNtC41R4cRwhi8FEZgUMuH9Jh1gNCmmSDu6YCibDVxGKCdF9xYowi37ebnMyr74lon5ML1/Ol/9w9d1xghAjV7Bi2zdrKb1bX4Yby6KNePFtX3cIL0u+cpKhxaDo3PXCAXfYBa3lWgjMOq/dm1Tdt5K4RwgD3fTjcCGIpdEfb4+TkF+OepwtcvpNAZWN7psDkJW0Rjhlw/Blo4++ZmMSdhMPiFmpCiAaxAzrZSc1cBlKD0FQnApdsZJb5RYZU9OLVcQUZX3YiZmPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=loKgPn51fX7XmGxrsW/RUgRhE9D5KIunberG6syVZdM=;
 b=wfoTjO6SheK12VMMAKS4yiBZVsqA+bsrale/zI+PdP7ISUVjh0GXclXcAVw7CxN9x5PLEu0K0ggSKsqYUFuwmBY6QsiLyU4mwHXsty6eJKpWp0WWI/1+wWOFiUQCMDO6ov2cmja+4jpNFRdSGI0JRqRck2ggZFc2DA3SH5YZFxMnW+z+jBAtXcKEHpHyIiA21Oo72jottB4SumJoXHCEI8BqBKOo9ighdnz17lrn39CbKlwBSllvWmR7nCXd6x6IiWvn3RZbw8JDrNh3ETMD4uhI61gsegfcvBX3VameFd/ZC4O8wQ3d+8CWuMFosyOrQEFLEpba82Hv48xyjuUxOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=konsulko.com smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=loKgPn51fX7XmGxrsW/RUgRhE9D5KIunberG6syVZdM=;
 b=YWguSgE0JtmmkeCBY9xt8R69NMHH/I7JfKsttt+673S/6GtXlHtDhctTZM3bIaE+/Z8UHZ28Ostd/6leskV7J9iRYAREMMlka+I6WC0XYayvHmUEl5watfL4FT2bqFmGNmOZVi2MNnIIcx9HxZLk/DR8AHZ7BoB533tFRFEI8dM=
Received: from SA1PR03CA0005.namprd03.prod.outlook.com (2603:10b6:806:2d3::6)
 by BN0PR10MB4933.namprd10.prod.outlook.com (2603:10b6:408:125::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.15; Thu, 12 Mar
 2026 13:33:20 +0000
Received: from SN1PEPF0002BA4B.namprd03.prod.outlook.com
 (2603:10b6:806:2d3:cafe::91) by SA1PR03CA0005.outlook.office365.com
 (2603:10b6:806:2d3::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.27 via Frontend Transport; Thu,
 12 Mar 2026 13:33:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 SN1PEPF0002BA4B.mail.protection.outlook.com (10.167.242.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Thu, 12 Mar 2026 13:33:18 +0000
Received: from DFLE203.ent.ti.com (10.64.6.61) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 12 Mar
 2026 08:32:54 -0500
Received: from DFLE205.ent.ti.com (10.64.6.63) by DFLE203.ent.ti.com
 (10.64.6.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 12 Mar
 2026 08:32:54 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE205.ent.ti.com
 (10.64.6.63) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 12 Mar 2026 08:32:54 -0500
Received: from prasanth-server.dhcp.ti.com (prasanth-server.dhcp.ti.com
 [10.24.53.104])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 62CDWpvH2897488;
 Thu, 12 Mar 2026 08:32:52 -0500
From: Prasanth Babu Mantena <p-mantena@ti.com>
To: <u-boot@lists.denx.de>, <trini@konsulko.com>, <n-francis@ti.com>
CC: <u-kumar1@ti.com>, <vigneshr@ti.com>, <s-vadapalli@ti.com>
Subject: [PATCH] Revert "usb: cdns3: use VBUS Valid to determine role for
 dr_mode OTG"
Date: Thu, 12 Mar 2026 19:02:47 +0530
Message-ID: <20260312133247.2192335-1-p-mantena@ti.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA4B:EE_|BN0PR10MB4933:EE_
X-MS-Office365-Filtering-Correlation-Id: 390c73bd-31f8-4ebc-eefb-08de803bec09
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|376014|1800799024|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: yp/uyV5KYXM81mWy0HxUH+s06paKfw9BoUSVu0XTAlF5dqbFSepLLVeruwjeHWiyZ1kk80TqG7tcVCVOU4QYn4ovbOmcut3PFASa1TL/DSR2iItsX5Tce7/U936k84uMJP5oniRtyusHj3G/VJo+NCX9gc/3CtVsq/LvMkPwxb/6XZxbjyUkh9mDWu+yfBWpYiFPkrmZHoDIapfMAPikfCRA4g9X3chxOBh3Sc7DXN4NGr2ro+Lriel4SE0FmrRx2tUKonyC5hoVPb4GlqnPRF+iyGUOmZWtGpRh10SneIlcE8igdzSqehmz4nzPr6VtvspcHxTPr363djWnG4ScQzdqkIUwxqaCn25v3IDEt6HfMIGNjVoNHqTKhvHs+KXilN0BAcqpYa47NDHBUVTN23rhuxgP2tk4b3Wi6byxJcIC0bUf1L7M2CYze6MsqAtP7T1FSN57LjKeU+zMSjWE53F2EhW7Dh/Mm45ScEGR3KvY4fzaG8S9eyn3AeQm21I90huMJPLD/bziojdKyT9ORL7PRaRqE6m2CEJgNfPFhE5SkB+X4l48FXDihOt2U2MyjUUm/U12lAB8TTCHC0InqGM2EK6bWCNrRwtzM8NxvT3na+yiID3k/SRNpyVSlY/76q4bv+8K9bZS/o9s7LXuvm9+wFZQ3qn4abhqJsLVDLyv66DRu3gkT8G055QXuCIVOPL/lngbQ69W7qMlg+CCjJqKvYBnz9jorkU/PjXuoa4y2/uDk/Pz8dwjRijYxPnMJ/7DW62w9HdusiHU02s4vg==
X-Forefront-Antispam-Report: CIP:198.47.21.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet201.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(376014)(1800799024)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Ce2i/oVIKGJxENbHoBiaAOxb+l9c2cnB+YTONuzY+RFPD681DbLaoiEXIKXZW0pbNXPoEaTn+4jI10yUflXCzGzyI6NEPUmUBfzkeZZ5pvRM1gWsRWJc7HJ7oDiBJKMHnzYRQ7VSA1Jn7btl45Rf6Xe3OXodcdYHGwukniet3OXL3rjwbnnpsfci+8Om7GC1aenqybc69codXdIpP/4de8my7u58Z89BKPW+bGMHxzeJCgMbgLjdZW/Rmx2GSn5HIw9gWDw5mAkzICOf0ijSi5aiuu8WWENf3eKvOsjjqSGJumD3dpG9A6p+W0Sl3OwShUxbvdKhPY+v6QYPyDcXyZrxXNps/wKTVoT/GdJYOE1iBGySErEa+kXd9ekKF4Al+Xod5OZBA/D2NpzmUqRvuD0/oCoUoFPXkVZfzxq9EiGuRC8jJAACuI/d3B/vuzH1
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2026 13:33:18.4032 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 390c73bd-31f8-4ebc-eefb-08de803bec09
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.195];
 Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002BA4B.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB4933
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

While USB DFU boot works with this patch, but the non USB boot modes like
SD Boot and flash boot fails for J784S4 EVM device.

So, Reverting this patch.

This reverts commit bfb530e06ca6c19f66c079601e568c761a001993.

Signed-off-by: Prasanth Babu Mantena <p-mantena@ti.com>
---
 drivers/usb/cdns3/core.c | 53 ----------------------------------------
 drivers/usb/cdns3/drd.c  | 11 ---------
 2 files changed, 64 deletions(-)

diff --git a/drivers/usb/cdns3/core.c b/drivers/usb/cdns3/core.c
index 10bc4cabed4..4434dc15bec 100644
--- a/drivers/usb/cdns3/core.c
+++ b/drivers/usb/cdns3/core.c
@@ -392,52 +392,6 @@ static const struct udevice_id cdns3_ids[] = {
 	{ },
 };
 
-/*
- * The VBUS Valid Bit in the OTG Status register can be used to determine
- * the role. When VBUS Valid is set, it indicates that a USB Host is supplying
- * power, so the Controller should assume the PERIPHERAL role. If it isn't set,
- * it indicates the absence of a USB Host, so the Controller should assume the
- * HOST role. If the OTG Status register is inaccessible, return an error.
- */
-static int cdns3_get_otg_mode(struct udevice *parent, enum usb_dr_mode *mode)
-{
-	/* Create a temporary child device for using devfdt_remap_addr_name() */
-	struct udevice child = {
-		.parent = parent,
-	};
-	struct cdns3 cdns, *cdnsp;
-	void __iomem *otg_regs;
-
-	dev_set_ofnode(&child, ofnode_first_subnode(dev_ofnode(parent)));
-	otg_regs = devfdt_remap_addr_name(&child, "otg");
-	if (!otg_regs) {
-		dev_err(parent, "failed to get otg registers for child node\n");
-		return -ENXIO;
-	}
-
-	/*
-	 * As mentioned in drivers/usb/cdns3/drd.c, there are two versions
-	 * of the Controller. The following logic detects the version of the
-	 * Controller and interprets the register layout accordingly.
-	 */
-	cdnsp = &cdns;
-	cdnsp->otg_v0_regs = otg_regs;
-	if (!readl(&cdnsp->otg_v0_regs->cmd)) {
-		cdnsp->otg_regs = otg_regs;
-	} else {
-		cdnsp->otg_v1_regs = otg_regs;
-		cdnsp->otg_regs = (void *)&cdnsp->otg_v1_regs->cmd;
-	}
-
-	/* Use VBUS Valid to determine role */
-	if (readl(&cdnsp->otg_regs->sts) & OTGSTS_VBUS_VALID)
-		*mode = USB_DR_MODE_PERIPHERAL;
-	else
-		*mode = USB_DR_MODE_HOST;
-
-	return 0;
-}
-
 int cdns3_bind(struct udevice *parent)
 {
 	enum usb_dr_mode dr_mode;
@@ -459,13 +413,6 @@ int cdns3_bind(struct udevice *parent)
 	if (dr_mode == USB_DR_MODE_UNKNOWN)
 		dr_mode = usb_get_dr_mode(dev_ofnode(parent));
 
-	/* Use VBUS Valid to determine role */
-	if (dr_mode == USB_DR_MODE_OTG) {
-		ret = cdns3_get_otg_mode(parent, &dr_mode);
-		if (ret < 0)
-			return ret;
-	}
-
 	switch (dr_mode) {
 #if defined(CONFIG_SPL_USB_HOST) || \
 	(!defined(CONFIG_XPL_BUILD) && defined(CONFIG_USB_HOST))
diff --git a/drivers/usb/cdns3/drd.c b/drivers/usb/cdns3/drd.c
index 0ca40a5cc8d..cbb13342343 100644
--- a/drivers/usb/cdns3/drd.c
+++ b/drivers/usb/cdns3/drd.c
@@ -301,17 +301,6 @@ int cdns3_drd_init(struct cdns3 *cdns)
 		cdns->dr_mode = USB_DR_MODE_PERIPHERAL;
 	}
 
-	/*
-	 * In the absence of STRAP configuration, use VBUS Valid to
-	 * determine the appropriate role to be assigned to dr_mode.
-	 */
-	if (cdns->dr_mode == USB_DR_MODE_OTG) {
-		if (cdns3_get_vbus(cdns))
-			cdns->dr_mode = USB_DR_MODE_PERIPHERAL;
-		else
-			cdns->dr_mode = USB_DR_MODE_HOST;
-	}
-
 	state = readl(&cdns->otg_regs->sts);
 	if (OTGSTS_OTG_NRDY(state) != 0) {
 		dev_err(cdns->dev, "Cadence USB3 OTG device not ready\n");
-- 
2.34.1

