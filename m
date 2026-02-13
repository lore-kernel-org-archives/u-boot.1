Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 403DEEF48D1
	for <u-boot@archiver.kernel.org>; Fri, 13 Feb 2026 05:14:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 72F9983015;
	Fri, 13 Feb 2026 06:14:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="uhaAcBpw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CC86483936; Fri, 13 Feb 2026 06:14:39 +0100 (CET)
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazlp170110009.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c111::9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2E52180FA1
 for <u-boot@lists.denx.de>; Fri, 13 Feb 2026 06:14:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=s-vadapalli@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QPq5ERFZcghn4XaFo2mde7jlHJD1kol8mcMVnttz+CDZPjoVTiKUy3USxWl9JIWzP0s3FrmlwOHq2Fshu9kLDF7oLd1+nT6ESe2ZXMmWRFtjrDFmUuZLHASZxQPLQvjNH90GTNkt2DPvW4yclIz2wpD32qD0rRGZGktOWkxbEUeaR46mFl2DWzMvJ2Ld9P6V4nPeXxbmMfQ+7RUpbqnQqLAHLyW21qfPcjivvrnwNbExnLkMjnHC6M0oBRDG6uBDFSnwGis3anUN5eav4P0worl6KRfsdrmHthueKbP+ASc4HwNvWk0oVoKzPCdsA1Yf87znDf9imXqbV0R0vsc3UA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R5q6P7/PhEtvNTjTr0sVDgSD9aAgmZ8kiPOKsrCSLGs=;
 b=yGlZXdaizv/Vtvmy3DlLVFEtpmgTWqa2QLIaqCsMa1dp8U5rpPsARxylaUYiwASi0hbtjIPTqD6Rwdl+0BJjCr2Q+mKyX0g5zxvrN7khdvjB4t0btsVgSCVEpAuUCooFhsdrUPYiPBZiQmgZXwya5wf1rzQ56XrLVfy+hQO/ZwDqFO3Vg9El3ZEkOQ7qQNQ0Px/VYr4Bg98Fy9sbAhd3pES9oElzkOUPphyxEYm5l7FUJoKHh//PcOmnLc5eOa4SOix+PZLHI/CBWnHIpuA2E3WerPoqRI+t5itD1j0GHKUr3/ceYkdVlToWZ7So9UGsqGPetpn5vRf9Od/BlNAIlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R5q6P7/PhEtvNTjTr0sVDgSD9aAgmZ8kiPOKsrCSLGs=;
 b=uhaAcBpwVcGOUaEpHHr6FWY6F9Y8EZfDL69fM1kUV42dUJ77Y8CGTVhcIhlptGPQd7LigAchoJBOEiKtxSMFrNHKtQBe91WZVxs4R8JfzIvEOp+J/xC8Yq1icQ/eLHhANedFU36xmh10YVgpJGLGew9gwCcP7MeiZHNZ5XHZviE=
Received: from MN0P220CA0012.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:52e::35)
 by LV3PR10MB8034.namprd10.prod.outlook.com (2603:10b6:408:28e::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.13; Fri, 13 Feb
 2026 05:14:33 +0000
Received: from BN2PEPF000055DD.namprd21.prod.outlook.com
 (2603:10b6:208:52e:cafe::cc) by MN0P220CA0012.outlook.office365.com
 (2603:10b6:208:52e::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9611.12 via Frontend Transport; Fri,
 13 Feb 2026 05:14:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 BN2PEPF000055DD.mail.protection.outlook.com (10.167.245.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.0 via Frontend Transport; Fri, 13 Feb 2026 05:14:32 +0000
Received: from DLEE205.ent.ti.com (157.170.170.85) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 12 Feb
 2026 23:14:32 -0600
Received: from DLEE206.ent.ti.com (157.170.170.90) by DLEE205.ent.ti.com
 (157.170.170.85) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 12 Feb
 2026 23:14:32 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE206.ent.ti.com
 (157.170.170.90) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 12 Feb 2026 23:14:32 -0600
Received: from toolbox.dhcp.ti.com (uda0492258.dhcp.ti.com [10.24.73.74])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 61D5ETKC587663;
 Thu, 12 Feb 2026 23:14:30 -0600
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: <marex@denx.de>, <trini@konsulko.com>, <minda.chen@starfivetech.com>
CC: <marek.vasut@mailbox.org>, <u-boot@lists.denx.de>, <srk@ti.com>,
 <s-vadapalli@ti.com>
Subject: [PATCH v2] usb: cdns3: use VBUS Valid to determine role for dr_mode
 OTG
Date: Fri, 13 Feb 2026 10:45:55 +0530
Message-ID: <20260213051556.1247716-1-s-vadapalli@ti.com>
X-Mailer: git-send-email 2.51.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000055DD:EE_|LV3PR10MB8034:EE_
X-MS-Office365-Filtering-Correlation-Id: 9bd28665-3dd8-464f-da50-08de6abec5f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Qk3+W9UHIGwDEJuIU2sviUEziVZrOS3wF10q1FlNFnA2O192i9I4Nt2cwFZ1?=
 =?us-ascii?Q?Pmct7lQDflw2vBrM5/qxDzj6wyMpTN46XzGCam0OG0DR9gjx6tlhmPHuvr0x?=
 =?us-ascii?Q?uGEw/9YYzBYpujBCh4t/+aI3cqzyCbDTYwDQHu8PxO9KGPZTwoYdtaRo/NAl?=
 =?us-ascii?Q?wsnLv7AC0ZlDh9Gw3rpHyJsmHMdr8Ts/RBvbu/xgL1gX0nkbbxO5cSoFFz5k?=
 =?us-ascii?Q?lyAFCTkhfKAB2LdKwQctMjKr+M5R3bimBPnzicDUJh4nuVCpsjhNYOfqGOvx?=
 =?us-ascii?Q?JQyicnpwD3482PBmKsXQH2yBbza1MBEE5NXLwLFa52jpQ0cP5fieNpQ06Gcx?=
 =?us-ascii?Q?A+E74ofAlPDhJZeO720uf1JhCzB4j+qnV1K7gZqPl8aWmK3qANNXXHAgtA5D?=
 =?us-ascii?Q?J72gN7Gu5ok5dyin640QdUYGwCsgZ4vQQbY+wfDLvCQefpDWjSCrVN2VrtRb?=
 =?us-ascii?Q?b2FsVfT4pq4+zyQaL0fd9Jkb+gMXoWYy4KD26Vw8CaaSi76EbAw+plJbBXoI?=
 =?us-ascii?Q?oHXtbIGqAgKRCHg/MnyrEoFjM2tJOuCBEqGYUYqhdsQX4xEO29Y7mYE465Wl?=
 =?us-ascii?Q?+dmEUx6FW3Q2w0C9HGXni76EfP9Vz/SoseN20FMavsqAObN/D1Ty8eCDPO4b?=
 =?us-ascii?Q?HtIfrE1IvT1bkkxK+laC5oPKohlcIKc/XPqvbPIckYvIgXICSaK/If/m5o5d?=
 =?us-ascii?Q?qd7IFKyMztnrMnamh877qMxpqv/cGkPlSAGh2VsM4U/EaQYygWFbzoSpPVHa?=
 =?us-ascii?Q?fKwm8/Q6CmL4L/hiTCW5kaCMy93IFtfigYjOmG++yIqlSwVp2NmeDFunDGLY?=
 =?us-ascii?Q?xZas5pw0EcNWT/nzv3LWwIlQo8+5EOq/JIEFVWKhyli6jE8ogaItcHTpj6S/?=
 =?us-ascii?Q?yvtIU0DfXR6rGcyefBkeZmvk9j5VxHodoys8PWkHC72mm4udx/2cG5xnJIfh?=
 =?us-ascii?Q?ROhr4GWkP3NLV3x5pHPTgEPwxwQxL+FXiOEMIbzVwZVNaSm0KHbqWefKjfZ1?=
 =?us-ascii?Q?zpgAshPMRnS1KnWN807P4C/Kf9aRmSs90ITFXosQUjXHwcCp93hQmiJYnq7F?=
 =?us-ascii?Q?U1WYJC1tKtYc72V00FVv2zgGGTwP36Cq6IbZMeADpFSNySNwF5+vw7MJiTmd?=
 =?us-ascii?Q?oFPF4XdT6WwrpwF6ZfV1HqaPINIR986lk2A305USoK+lmUvKl2iWFRQeQi78?=
 =?us-ascii?Q?KFWjJdJgpVYz1NiaDPHh2qGC2fpzj80+6HWDm+KRYVQ7mhgBm5/NXDvWoYq0?=
 =?us-ascii?Q?G1sF3yOBE/9X9Ow1VJPuOvUHZLHawvUQBVA5oPGryk18bpsu+ly88bDUPE6U?=
 =?us-ascii?Q?vF0/v5O4zRhC+eRITzLIyQkeL8aWHFbLkXj2jTNcXu9zSqEJiO501I8oWEwK?=
 =?us-ascii?Q?uikQYXRpDs7T9OGCxfdbsnbF2I4uUn/Fd1Z/XNMtLET4ssPJiaz2o4FDQ+tQ?=
 =?us-ascii?Q?SoMD7iuiMtcN3NCVB94rTCpvm9cDVDeObDKX/UvD3ITjTFh+gNOq96H/39MF?=
 =?us-ascii?Q?eAH3LAtcoR9ECCCpWH1ZWO5GojtX6ES1HsETFyQgm/qSn0SR57e3857A2gco?=
 =?us-ascii?Q?MdMfb7k8qiZdPUKWiM67R+pqfwUyYmfpwdmY5/1v3Mw4lQRTUutNnsJNt4a7?=
 =?us-ascii?Q?sQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:198.47.23.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet200.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: u5dn5lGa170DL7K9zneeRjGN7Kdw1Ko+ZvznnKoh3A4EoX+iJt0lsQN4LbuMeifs3EnqIwEztxOeotVmnVlh3dSrfxgDt/eXZbDN4C9YsNaFJr18t4SdEtZ7ZyAShjhX3lggILUMknWSL4OhgcdxHxyyzk5+H89k2QHKQu4DHTRGvFVIzvuKR0MKmf8/g1f0IShTObjAY4heoqIDFlu01LDycTWVD5XKjTpOelD41NZxoLx5WLfLQ8IGuPQ/13NY4k708GpY1+K7EtC0rlS1aWrJhcGZcRsfM1JcSsxpjYxtOoRXFFEW9oN6gLqGpCD9QF+bFRC69gpnYirGeRmzNjqTRELwu6iOKRcv2k4FMzd0ByPUlmBOfYx0bvwKtLZlFH+QThe8fZxeYuKLlIaqbtoK0h6HhNbAwEvuEt2a4tP1XUnT6JJxxuSzhHQf49a+
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2026 05:14:32.9324 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9bd28665-3dd8-464f-da50-08de6abec5f2
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.194];
 Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000055DD.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR10MB8034
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

v1 of this patch is at:
https://patchwork.ozlabs.org/project/uboot/patch/20260204121245.2105523-1-s-vadapalli@ti.com/
Changes since v1:
- Addressed feedback from Marek by updating cdns3_get_otg_mode() to:
  i) Return an error code (or zero in case of success) instead of returning dr_mode
  ii) Fill in the mode in a parameter passed to the function
  and updating cdns3_bind() to return an error when cdns3_get_otg_mode()
  fails, instead of continuing.

Patch has been tested on the J784S4 EVM in the context of USB DFU Boot
with dr_mode set to 'otg' in the device-tree. Logs:
https://gist.github.com/Siddharth-Vadapalli-at-TI/7a696ba0a4871317361c54003ab75360

Regards,
Siddharth.

 drivers/usb/cdns3/core.c | 64 ++++++++++++++++++++++++++++++++++++++++
 drivers/usb/cdns3/drd.c  | 11 +++++++
 2 files changed, 75 insertions(+)

diff --git a/drivers/usb/cdns3/core.c b/drivers/usb/cdns3/core.c
index 4434dc15bec..801c4f1091f 100644
--- a/drivers/usb/cdns3/core.c
+++ b/drivers/usb/cdns3/core.c
@@ -392,6 +392,63 @@ static const struct udevice_id cdns3_ids[] = {
 	{ },
 };
 
+/*
+ * The VBUS Valid Bit in the OTG Status register can be used to determine
+ * the role. When VBUS Valid is set, it indicates that a USB Host is supplying
+ * power, so the Controller should assume the PERIPHERAL role. If it isn't set,
+ * it indicates the absence of a USB Host, so the Controller should assume the
+ * HOST role. If the OTG Status register is inaccessible, return an error.
+ */
+static int cdns3_get_otg_mode(ofnode node, enum usb_dr_mode *mode)
+{
+	struct cdns3 cdns, *cdnsp;
+	void __iomem *otg_regs;
+	fdt_addr_t otg_addr;
+	int otg_reg_index;
+	int vbus;
+
+	otg_reg_index = ofnode_stringlist_search(node, "reg-names", "otg");
+	if (otg_reg_index < 0) {
+		printf("%s: dr_mode is otg but otg register name is missing\n", __func__);
+		return -ENOENT;
+	}
+
+	otg_addr = ofnode_get_addr_index(node, otg_reg_index);
+	if (otg_addr == FDT_ADDR_T_NONE) {
+		printf("%s: address of otg registers is unspecified\n", __func__);
+		return -ENOENT;
+	}
+
+	otg_regs = map_physmem(otg_addr, 0, MAP_NOCACHE);
+	if (!otg_regs) {
+		printf("%s: failed to map otg registers\n", __func__);
+		return -EINVAL;
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
@@ -413,6 +470,13 @@ int cdns3_bind(struct udevice *parent)
 	if (dr_mode == USB_DR_MODE_UNKNOWN)
 		dr_mode = usb_get_dr_mode(dev_ofnode(parent));
 
+	/* Use VBUS Valid to determine role */
+	if (dr_mode == USB_DR_MODE_OTG) {
+		ret = cdns3_get_otg_mode(node, &dr_mode);
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

