Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E65CE63F2A
	for <u-boot@archiver.kernel.org>; Mon, 16 Feb 2026 04:33:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2E56180FA1;
	Mon, 16 Feb 2026 05:33:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="sADmLD1x";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E26E183AA9; Mon, 16 Feb 2026 05:33:42 +0100 (CET)
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c105::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9AE018063E
 for <u-boot@lists.denx.de>; Mon, 16 Feb 2026 05:33:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=s-vadapalli@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YniFTpNkSMai1ARusUxawgNMaAtL8Q/k5TCUDx1jn28+4bnYX3Kx+0QdhyAwmNxKi4HgA+FnDkTivLJKQ5Luu9OVkZwG6JKhyh5ifuDFPurVCw0LxgL9o2P2+5kLU4ODl3es8N4FzRzYd9jnVST7tAII8eYLQ8K947X1/Agz+jI3Mk8TNCgDjaMqFK9IqmibTAtsC0a6UY+0eCB9uGRoRk3rNDcIScHU0dTkFW1H9NUq2J84zYQKUrMRmxQV954/7HB1xQ04PFIKLqcz5XhVPvWG1928dISzDxiZQ2y3gZLEXDXjRuDyjsXnhnhNVF+AW2Vym2ojcu8raCOXq/thow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a+92VHbYAMI5Lo6E0GDlA0InwDJHim1iq16EkBp3tIU=;
 b=oZoxtJNj4XNM9y5KDP/6TwIeqGxze9+ialJwKFGAOW6VSH5TrNktLpwf8EG5WvP7lgcvPwk03RLL8JXlxNNvPATep8nE1cJeQChUnLIT5xB6PZeUQwq8wpNod4MFPGNhIggWX7bdgI/KtZjgQkxr4SeGgYKBWSxHEjngx6xGGHN7TAmiX3rUG1HGqJc8E+r0YYSI05Up9qwndSBDM700bbtEe/XzyfYy2+UpoZzghTaoFdcnR9r3eyelWravbHsE79EMAwQlEuHI2VXCgwGi5nIrQr0PUm9DrLGwiTzbj+CQXvxCS+D0sz6T8JUwFkeXkyo7IOkqv4Lqhu8KS5R2Ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a+92VHbYAMI5Lo6E0GDlA0InwDJHim1iq16EkBp3tIU=;
 b=sADmLD1xszEnliXW13Or5SbZ0Z6wZwWVytgCA852/MoE2XoaDZxkTVTjADc0SFho1y9eGvw8FyAJ7Twscrzy8yG/IvfMmFGoU6j8WJ6XW0NFLKPptThtOkL9CbR+jfaFTXiQT7HvAsXmB6iouNw6yDIsmzpYhiFtBbFS+MDzZqA=
Received: from BLAPR03CA0168.namprd03.prod.outlook.com (2603:10b6:208:32f::6)
 by SJ5PPF2BB505D96.namprd10.prod.outlook.com
 (2603:10b6:a0f:fc02::796) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.16; Mon, 16 Feb
 2026 04:33:36 +0000
Received: from BN3PEPF0000B06C.namprd21.prod.outlook.com
 (2603:10b6:208:32f:cafe::24) by BLAPR03CA0168.outlook.office365.com
 (2603:10b6:208:32f::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9611.16 via Frontend Transport; Mon,
 16 Feb 2026 04:33:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 BN3PEPF0000B06C.mail.protection.outlook.com (10.167.243.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9654.0 via Frontend Transport; Mon, 16 Feb 2026 04:33:35 +0000
Received: from DLEE202.ent.ti.com (157.170.170.77) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 15 Feb
 2026 22:33:34 -0600
Received: from DLEE208.ent.ti.com (157.170.170.97) by DLEE202.ent.ti.com
 (157.170.170.77) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 15 Feb
 2026 22:33:34 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE208.ent.ti.com
 (157.170.170.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Sun, 15 Feb 2026 22:33:34 -0600
Received: from toolbox.dhcp.ti.com (uda0492258.dhcp.ti.com [10.24.73.74])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 61G4XV2F1173978;
 Sun, 15 Feb 2026 22:33:32 -0600
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: <marex@denx.de>, <trini@konsulko.com>, <minda.chen@starfivetech.com>
CC: <marek.vasut@mailbox.org>, <u-boot@lists.denx.de>, <srk@ti.com>,
 <s-vadapalli@ti.com>
Subject: [PATCH v4] usb: cdns3: use VBUS Valid to determine role for dr_mode
 OTG
Date: Mon, 16 Feb 2026 10:04:58 +0530
Message-ID: <20260216043459.2467850-1-s-vadapalli@ti.com>
X-Mailer: git-send-email 2.51.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B06C:EE_|SJ5PPF2BB505D96:EE_
X-MS-Office365-Filtering-Correlation-Id: ccdd96cb-9184-4aa3-d469-08de6d148c9a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?1YmWfpoH5xzIW36CvLVGYFatGJlsC9H7SU5ZQ4cIQs8BIEg/7meii3zukoJy?=
 =?us-ascii?Q?GJz9gTLWSA9mdrXDxaX8r5MkP0r3lPoNSHPwtMbhzRxQjlACgfUlmCHBVeR9?=
 =?us-ascii?Q?ATXaZSw0JacMkWonZjQgsQVbr2bWZwpdyk1rAlBPWRa5sMaQq1pkv/OrBuBe?=
 =?us-ascii?Q?an8FFUPH5/hzabmBaTQgk6WrXu+kDCj+rWbIjlS/a+s2+BJbPNdy6CFrg+Tu?=
 =?us-ascii?Q?Ij9Yq30HCCEFFIPV3CIE8ra952mTqb8hjITe3/nj9MOAL1ORjpNFlaN7W0nZ?=
 =?us-ascii?Q?H7d9rpd2IDOBz+f0UVQOCUBpCzYxWmArcMwwWG9qvI6iHDdlViS69/rLFqSB?=
 =?us-ascii?Q?AOVkziz6N9Gfi6Dvq6HI8P/0uo/BDdauEsoyJ1eqgaVD2nGv/eDYM8LR+/Ps?=
 =?us-ascii?Q?6c8ZT8oKtQ3T5+YwkLmCkBarR0+rB7jwOv/HuWa3iOwzoIU7KUlymyfUvAYM?=
 =?us-ascii?Q?c6V8jz9xrThhWQF5vPHD7hBIV6cpbW/GR42o5AGeAm9Ob2YYm52MjcbB4Pqs?=
 =?us-ascii?Q?P425lLUii77oEBMbJZ650eMO+6oprWdi316imPaXeTOXToobXgxsYw6Mlvi/?=
 =?us-ascii?Q?AdC4ERgyVuuO+7LvILZ8PNywE6u76RGiiCq94EhDT/G6iNfEZnF/L+FXnO8y?=
 =?us-ascii?Q?/MSl8V3FhYG5F4CuSI7kIQLeI7ALeQZfqZJL7jN1OV+4H+ym7AN25WHrTSkU?=
 =?us-ascii?Q?Xu/ZjmDKHu4L5QQ/yeolPfmq89/l5+hoH1Q260xUci+30fi33tJCQELIENeh?=
 =?us-ascii?Q?ZhPqeP3Sdd70LoyIqCpenQkktM4VVpxrZgp4mo2o7tExBWiOBZ33vNtUp2FM?=
 =?us-ascii?Q?9xtW4ESPRyp5xhVJ5dc0vBjyZ8IKwgoM5U48FeZ7152qSrVnSEA1lXCfqRI+?=
 =?us-ascii?Q?Hq1J4s622fGeEqOj5Er4r89BaHkgd5GUG9p/nuCynPLuLfntqYXAeuEVoeM/?=
 =?us-ascii?Q?+ijeIzb/q0SII9sNx7hna/tFSQHocUz3ThOPSjjdRthW1MiH8rlnBxtZkqc1?=
 =?us-ascii?Q?9LdErAUgwgc6zrcZGkaBEL7Rcq0RrE5TZcsjDbLatW3mHPiuoDc9J4kNEYud?=
 =?us-ascii?Q?/W8GjqrWVxiV1vj2Gkeyan4SiRx9OnDfZxWkfoW9ZcDA/hcGWF+/rAyy0Q5a?=
 =?us-ascii?Q?WzZHJYRlNueeSF+GVAeiM35XdN2L+2ekpvByApLHoXf8sw2UhFovucJRej3r?=
 =?us-ascii?Q?ru97LTdYbHAPaCATTANmcSsDU10SnZpzNcLjO10x+pfb+GbQi/xboLUZ2Pfm?=
 =?us-ascii?Q?gd+glXvHe22GLo87aGT23DEmW3zWb31V901aT3WMK1y29YUkKni9MDryRA3U?=
 =?us-ascii?Q?Hnmo/Q+KgazX95st6z7PjA5gefYnPDuCILZkL5e/ZBj8Hm+EOQYrzvVSIh9t?=
 =?us-ascii?Q?LuXBtQDLSImxHAV5G/5KaK7ous6FLXupyhb6sESYYwJydAASMQgSfrLyRDXR?=
 =?us-ascii?Q?R0wWBTclUd0qmskXGR/DWKvIywi7rMnCd8wdr4o7ITHxOqkgT/acrhBGisjw?=
 =?us-ascii?Q?Y1jds4ue53zYkBfkvqYRkAwyv5hdwcZxdSTBKjZ3mGYmzSo9/tgbgEoHobQQ?=
 =?us-ascii?Q?hgb/leBYaF7LJAcbZobabrVALjHXAbzFFP3ySon5oIXkBQbiA0e9yvbNDPt4?=
 =?us-ascii?Q?EHGXyLpUtGoSmJpyylxJCgI=3D?=
X-Forefront-Antispam-Report: CIP:198.47.23.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet201.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ilH/DDPZE3yTj5tHVvZiAwu9BECpTvFnHLBjoFkdoT84VGASCS7030gDc230nR9l041hJczujbhezwpaK1iO8+jzFMDwRKJFIe2qV5+KcKb1R8nVAO0SDZU+wrmKjCUz/27BYFNhhSvSUWa4PZ11ibc5o5bFveZ++eUrKxgqMSq3k6FZIzqJ9Oc4q1NSX7eUYfzTryFbahTj001bzNHGOaJdCmQuQjGDNwryRWc2VmVn3DUBJ3TThH+/PgW/+EIc3l1344d8tsjz7m7SOOSsEBwSz8vI0mMuc50Qn1mZu6c+KyrHZM95nqbcR927w1DXR00BwyZe9qRjZxXRtDHVOkcAdMLGBG6+x+xyNMz3th4JnA6C8BboPf+/TuC8rfQYPMqveXMpLakaL7kpBemTMiW/+ndhrQ1n6bdk/B7C0gC1AzasYMwva/4oxd0v/8Ya
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2026 04:33:35.7674 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ccdd96cb-9184-4aa3-d469-08de6d148c9a
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.195];
 Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B06C.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF2BB505D96
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

of the master branch of U-Boot.

v3 of this patch is at:
https://lore.kernel.org/r/20260215123514.2288422-1-s-vadapalli@ti.com/
Changes since v3:
- Based on Marek's feedback, 'vbus' variable has been removed and the
  following:
  	vbus = !!(readl(&cdnsp->otg_regs->sts) & OTGSTS_VBUS_VALID);
  	if (vbus)
  has been replaced by:
  	if (readl(&cdnsp->otg_regs->sts) & OTGSTS_VBUS_VALID)

Test logs on J784S4 EVM:
https://gist.github.com/Siddharth-Vadapalli-at-TI/eb74c281fadfd73c16ced208adb35478

Regards,
Siddharth.

 drivers/usb/cdns3/core.c | 53 ++++++++++++++++++++++++++++++++++++++++
 drivers/usb/cdns3/drd.c  | 11 +++++++++
 2 files changed, 64 insertions(+)

diff --git a/drivers/usb/cdns3/core.c b/drivers/usb/cdns3/core.c
index 4434dc15bec..10bc4cabed4 100644
--- a/drivers/usb/cdns3/core.c
+++ b/drivers/usb/cdns3/core.c
@@ -392,6 +392,52 @@ static const struct udevice_id cdns3_ids[] = {
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
+	if (readl(&cdnsp->otg_regs->sts) & OTGSTS_VBUS_VALID)
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
@@ -413,6 +459,13 @@ int cdns3_bind(struct udevice *parent)
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

