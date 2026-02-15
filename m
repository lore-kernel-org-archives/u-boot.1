Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1AC0EF587B
	for <u-boot@archiver.kernel.org>; Sun, 15 Feb 2026 12:33:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EB51980B98;
	Sun, 15 Feb 2026 13:33:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="OvmicrwI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EE3858309A; Sun, 15 Feb 2026 13:33:55 +0100 (CET)
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c110::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2039280325
 for <u-boot@lists.denx.de>; Sun, 15 Feb 2026 13:33:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=s-vadapalli@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UtRvRodvqvsRK64y2DUdbMW2udSBbRHdLDkFNUONQVTGA1I/oVYJqHOPSfvSKrPB4EekA5RzETmEkWq/gGuiCN1vC5TI9w9S3S2LM8IYR4J1z89fWY5CBJgbkyp62S6It3DcnJ+X3My0Eu9BJLiHiKWVhh83/yBfKa1aWIQNq0H6PYR0l7eN/+M5aKIpWqpN3TQEcEM3JSMzIhsus3b44gB92XYs/5/1AMnbPCL80XQ/X6hUnDKDmUEFNPbexpePHHH3wG7DdjAfte5f1hxh3k5vz45SZyDrfOchX/8WYRvFNemKcHk1Ny9Pp/fzhiGWrC6FGw+n7tVCplySwvtQDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WyOlW1E3GkGOpz46GB+zms1StPE1FZuiRFDeDEKg7t0=;
 b=xT+ewOoGEiT73NUEZwJqdKWsPyahs2QAY5zI5/Z2tJ2V5kAAK6C+yahDF6qa6qFQbj+QUD0PCPni+CeDjcexIBmNMV8K2+jUqjIb6cXwzT5WLo7lrsU7UmbEbKioK/LugKE5AR5PyV95R+8aOTzWesQ/yQaTy7rqasBugzh2DCfg37NkDrytJ1zu4Y4DP4hF3P9s5WuIFJEGxbuaOgoKyYfiaB1ijZEBNVxUwK9b9e6vxAv/yUntocGKAFU/9kpPFlX13tYdcpiwNgawEkcNOLT2d1UAbqi6YT8PoSe0K5HI2LhbpJ2px9hZwlnUhitfObmqRY7Jv5WczfHS31qvlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WyOlW1E3GkGOpz46GB+zms1StPE1FZuiRFDeDEKg7t0=;
 b=OvmicrwI6QP3ALZbmmN8kYribmyCWg6JWPTxGJWKbkkChZGwah+b0zLNIigdmDCKpmK0h/yOTUBkNlEkJDXcIOKbGSfVdZXautlZ0CVzL3epNIkuIek3dlUMmyj6KS46KeHlxcPCIPMb505d1xoUbhEsrB2GAS+7zjgGVq9KxPk=
Received: from BL1PR13CA0248.namprd13.prod.outlook.com (2603:10b6:208:2ba::13)
 by BN0PR10MB4823.namprd10.prod.outlook.com (2603:10b6:408:12d::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.16; Sun, 15 Feb
 2026 12:33:50 +0000
Received: from BL6PEPF0001AB58.namprd02.prod.outlook.com
 (2603:10b6:208:2ba:cafe::5c) by BL1PR13CA0248.outlook.office365.com
 (2603:10b6:208:2ba::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.12 via Frontend Transport; Sun,
 15 Feb 2026 12:33:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 BL6PEPF0001AB58.mail.protection.outlook.com (10.167.241.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9611.8 via Frontend Transport; Sun, 15 Feb 2026 12:33:50 +0000
Received: from DLEE202.ent.ti.com (157.170.170.77) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 15 Feb
 2026 06:33:49 -0600
Received: from DLEE200.ent.ti.com (157.170.170.75) by DLEE202.ent.ti.com
 (157.170.170.77) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 15 Feb
 2026 06:33:49 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE200.ent.ti.com
 (157.170.170.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Sun, 15 Feb 2026 06:33:49 -0600
Received: from toolbox.dhcp.ti.com (uda0492258.dhcp.ti.com [10.24.73.74])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 61FCXk6P3916028;
 Sun, 15 Feb 2026 06:33:47 -0600
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: <marex@denx.de>, <trini@konsulko.com>, <minda.chen@starfivetech.com>
CC: <marek.vasut@mailbox.org>, <u-boot@lists.denx.de>, <srk@ti.com>,
 <s-vadapalli@ti.com>
Subject: [PATCH v3] usb: cdns3: use VBUS Valid to determine role for dr_mode
 OTG
Date: Sun, 15 Feb 2026 18:05:12 +0530
Message-ID: <20260215123514.2288422-1-s-vadapalli@ti.com>
X-Mailer: git-send-email 2.51.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB58:EE_|BN0PR10MB4823:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a426906-491c-4775-320e-08de6c8e78e9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?RZsK0l5s0yXSjSKx3GJpwSdYUC3TD9duwNqkVQabfl+CXjlDndfmTIGJk3WV?=
 =?us-ascii?Q?lWrJJ/Apm6oeoTtQHKz+kg71yZCNP329ffZT5c82cZ5Mh58z8q8ySf0ob+fR?=
 =?us-ascii?Q?BqR/0LMCk2tQwCBjdMtD7kVaCbS0O/rjESSYy61/aUXE0HDkLd9cvZs+/A0o?=
 =?us-ascii?Q?r/Wn8gxmgFbEYuxcyaQ164wv1gqazhMbMYUCvLQ/lRx1gw7CM0gEn1d5S+Te?=
 =?us-ascii?Q?zIWEl1EgJH+bacgqo2Wv0H5bqpx87FowI+Cxs44M24TsHIcCMsD8LeE4Hs8S?=
 =?us-ascii?Q?7xfFY9dXM68c47cdEQ1xGz7Yg/2VZQ+NwXG4b0WvUeqilgOtTLjF3ZNs478k?=
 =?us-ascii?Q?ytdObewFOsVDjONdRpJiFVtsW7SnuKCHUUSYekrYV9mXGkqssNcNhDrg+Bhr?=
 =?us-ascii?Q?inCtJMe2okP7E8/DAXxkmirVz5oTukVK9+hc7/kBX5rRJfpnyBH4qv5exg59?=
 =?us-ascii?Q?7WzOr3zpOe94KwhFXneJMQnRgliiENHf9dtYXGcqEE80hu7306x0hHH3rNTx?=
 =?us-ascii?Q?qzFeSTHtb4Nov2yqj9QIIpvqmmgCx6HZ/5pOZS2wMAeIcxWvq+iyPtRfOm0D?=
 =?us-ascii?Q?XZMa5ahTEYHKkjtJK4zd9G16DM7o7fbzkS2Yp3+RFWmV2WtWPLZ9ml2uJu5W?=
 =?us-ascii?Q?6KEqZssTnkKiZxoEfotj/dAbusk0Eg1/UiSTxehBDitxXJujzDdVZ0mv9o5v?=
 =?us-ascii?Q?Vao0rQAVQDiJXlVXSZXvzmNNJRrz86zrXvK75LkUqbYup26Gv+Gs3FC4ct8o?=
 =?us-ascii?Q?PFNqkLigqfUmrtw/Bm2KGBDODC/fRbMvCHmxG+kQ0eMSAr1TyTYgP26+Xoyw?=
 =?us-ascii?Q?DJGqlNYAPTw723LI1LA5FlCzyVI1ys77jDp5bzs5YETaWeBoPEkwDUi6WE2E?=
 =?us-ascii?Q?ZfZPo+H6GU/FJs2d7kR6z2CWlX/bMp9pUYsaqFKsbFkSiyQzs3PXRnX6AIHg?=
 =?us-ascii?Q?U12xV1T86CmvHykX87pZSgbO5S6S5uv+YZLfAQOpWZwzaqVX+X2/y4YoFKS7?=
 =?us-ascii?Q?5B5qUuIK5XJPwMsYRWPt0Y0rz2TyH+3zHNa69ChhFM3i1xDhKiQcA34NJQpc?=
 =?us-ascii?Q?KW1ZCXw52I2DZcZSX5LeYAJmpUaWSI1j9A/qkwrvalLpcY0bBy9IKK3awYh2?=
 =?us-ascii?Q?S2mEOFON2kCvvIncqruwt0Lw/yb1CcQgIcx+9g6l/cMIayALnSbUIH44346H?=
 =?us-ascii?Q?hH11P7xJc3E4/6N75Y+8GD2IP7toG3a94RujzM40KTVRmkk8y/vn5xHlf5Xw?=
 =?us-ascii?Q?d6eT7G4tPOLFwcek7qXvXx/ITd0SW3eB4rlpIPyzGcnSgsTbKoDg7L1aqcm0?=
 =?us-ascii?Q?sQica+SUXFqpnP8rxiRQZMHHFWNgd7l83Q/MKtSSfWXdZsAyg+b7RnNo96p8?=
 =?us-ascii?Q?hDPznedBCPQPFDFwBKyC1p2I4es9TIjIqU4BCpj8MEzh8YPyVf508PqSM2Xg?=
 =?us-ascii?Q?kG55OUpuUkmz59bAcKHhmQY86YQnTe0RmXNRDUc4bwiaUgimCdC+KcTLkgml?=
 =?us-ascii?Q?jQEFOCeYDFTCDquNJy6AqHSDULLB1VVuaSIb2/5S4ulL9pQOC4k761Hp9GO3?=
 =?us-ascii?Q?+50Y5CQlennNGhUy965TduAAa6J1x+cXAw6aA67G2E8jngURKX3AZmLLzi1b?=
 =?us-ascii?Q?UCDNgpYtAXp3at7uIrEAZqc=3D?=
X-Forefront-Antispam-Report: CIP:198.47.23.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet200.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: +EhC4i0Jp88YxIs+0lTAKr8B8Jcn5LBi3M4j7TexQOSyyFpUSRPZk/ixLCgsBleESOV1TSbx0RB1WPKTNVinMZwJ7oRhlodxnYDWtbE7dQRa81WmrWW/NRd38cHb80oBipETHnUmO5fgG1bU0LxnncKOlKjKCRGwqzKRLX5RXTiDk0AgOIYlqNEvKZQI93QOdcv4Z4OnPz87ZaXWkEkL16MSOyrSMymsDJLbRvSgzXJ1/4sGIrS8z4Wo/NXE+VlRzh7uamlEJ0NIhHhyjKGfm08gii5gUQaUPuWe5RqcFS4W4OdmWNrCGO5uK6CUlNhJKZTJ1D9DdaMBh0OBkfJq2ZpVkfazdY8zbNnmy/vxRaAia75BvTks4diruenVVqqoAwgbUla9YQgso5aEJgSyT9/rdzquMWVocgKhBUF2G/HKV+Z+Wi+/QaKzQEHGmSpV
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2026 12:33:50.1609 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a426906-491c-4775-320e-08de6c8e78e9
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.194];
 Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB58.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB4823
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

The cdns3_bind() function is responsible for identifying the appropriate
driver to bind to the USB Controller's device-tree node. If the device-tree
node has the 'dr_mode' property set to 'otg', the existing approach fails
to bind a driver, leading to loss of functionality.

To address this, use the VBUS Valid field of the OTG Status register to
determine the role as follows:
- If VBUS Valid field is set, it indicates that a USB Host is supplying
  power and the Controller should assume the Peripheral role.
- If VBUS Valid field is clear, it indicates the absence of a USB Host and
  the Controller should assume the Host role.

Additionally, when 'dr_mode' happens to be 'otg' and the STRAP settings
are not specified, use VBUS Valid to determine the role in cdns3_drd_init()
and assign it to cdns->dr_mode.

Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
---

Hello,

This patch is based on commit
f9ffeec4bdc board: toradex: Make A53 get RAM size from DT in K3 boards
of the master branch of U-Boot.

v2 of this patch is at:
https://lore.kernel.org/r/20260213051556.1247716-1-s-vadapalli@ti.com/
Changes since v2:
- Based on feedback from Marek, a temporary child udevice has been
  created in cdns3_get_otg_mode() to use devfdt_remap_addr_name(),
  instead of implementing custom equivalent of devfdt_remap_addr_name().

Test logs on J784S4 EVM:
https://gist.github.com/Siddharth-Vadapalli-at-TI/5f55c14a061a797e266f086ea18ef3e0

Regards,
Siddharth.

 drivers/usb/cdns3/core.c | 55 ++++++++++++++++++++++++++++++++++++++++
 drivers/usb/cdns3/drd.c  | 11 ++++++++
 2 files changed, 66 insertions(+)

diff --git a/drivers/usb/cdns3/core.c b/drivers/usb/cdns3/core.c
index 4434dc15bec..6eacbce7714 100644
--- a/drivers/usb/cdns3/core.c
+++ b/drivers/usb/cdns3/core.c
@@ -392,6 +392,54 @@ static const struct udevice_id cdns3_ids[] = {
 	{ },
 };
 
+/*
+ * The VBUS Valid Bit in the OTG Status register can be used to determine
+ * the role. When VBUS Valid is set, it indicates that a USB Host is supplying
+ * power, so the Controller should assume the PERIPHERAL role. If it isn't set,
+ * it indicates the absence of a USB Host, so the Controller should assume the
+ * HOST role. If the OTG Status register is inaccessible, return an error.
+ */
+static int cdns3_get_otg_mode(struct udevice *parent, enum usb_dr_mode *mode)
+{
+	/* Create a temporary child device for using devfdt_remap_addr_name() */
+	struct udevice child = {
+		.parent = parent,
+	};
+	struct cdns3 cdns, *cdnsp;
+	void __iomem *otg_regs;
+	int vbus;
+
+	dev_set_ofnode(&child, ofnode_first_subnode(dev_ofnode(parent)));
+	otg_regs = devfdt_remap_addr_name(&child, "otg");
+	if (!otg_regs) {
+		dev_err(parent, "failed to get otg registers for child node\n");
+		return -ENXIO;
+	}
+
+	/*
+	 * As mentioned in drivers/usb/cdns3/drd.c, there are two versions
+	 * of the Controller. The following logic detects the version of the
+	 * Controller and interprets the register layout accordingly.
+	 */
+	cdnsp = &cdns;
+	cdnsp->otg_v0_regs = otg_regs;
+	if (!readl(&cdnsp->otg_v0_regs->cmd)) {
+		cdnsp->otg_regs = otg_regs;
+	} else {
+		cdnsp->otg_v1_regs = otg_regs;
+		cdnsp->otg_regs = (void *)&cdnsp->otg_v1_regs->cmd;
+	}
+
+	/* Use VBUS Valid to determine role */
+	vbus = !!(readl(&cdnsp->otg_regs->sts) & OTGSTS_VBUS_VALID);
+	if (vbus)
+		*mode = USB_DR_MODE_PERIPHERAL;
+	else
+		*mode = USB_DR_MODE_HOST;
+
+	return 0;
+}
+
 int cdns3_bind(struct udevice *parent)
 {
 	enum usb_dr_mode dr_mode;
@@ -413,6 +461,13 @@ int cdns3_bind(struct udevice *parent)
 	if (dr_mode == USB_DR_MODE_UNKNOWN)
 		dr_mode = usb_get_dr_mode(dev_ofnode(parent));
 
+	/* Use VBUS Valid to determine role */
+	if (dr_mode == USB_DR_MODE_OTG) {
+		ret = cdns3_get_otg_mode(parent, &dr_mode);
+		if (ret < 0)
+			return ret;
+	}
+
 	switch (dr_mode) {
 #if defined(CONFIG_SPL_USB_HOST) || \
 	(!defined(CONFIG_XPL_BUILD) && defined(CONFIG_USB_HOST))
diff --git a/drivers/usb/cdns3/drd.c b/drivers/usb/cdns3/drd.c
index cbb13342343..0ca40a5cc8d 100644
--- a/drivers/usb/cdns3/drd.c
+++ b/drivers/usb/cdns3/drd.c
@@ -301,6 +301,17 @@ int cdns3_drd_init(struct cdns3 *cdns)
 		cdns->dr_mode = USB_DR_MODE_PERIPHERAL;
 	}
 
+	/*
+	 * In the absence of STRAP configuration, use VBUS Valid to
+	 * determine the appropriate role to be assigned to dr_mode.
+	 */
+	if (cdns->dr_mode == USB_DR_MODE_OTG) {
+		if (cdns3_get_vbus(cdns))
+			cdns->dr_mode = USB_DR_MODE_PERIPHERAL;
+		else
+			cdns->dr_mode = USB_DR_MODE_HOST;
+	}
+
 	state = readl(&cdns->otg_regs->sts);
 	if (OTGSTS_OTG_NRDY(state) != 0) {
 		dev_err(cdns->dev, "Cadence USB3 OTG device not ready\n");
-- 
2.51.1

