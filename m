Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E95C4E9538F
	for <u-boot@archiver.kernel.org>; Wed,  4 Feb 2026 12:11:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5963983A47;
	Wed,  4 Feb 2026 13:11:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="pmAvVFbN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AD01E83A47; Wed,  4 Feb 2026 13:11:31 +0100 (CET)
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c000::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0A4C6839D5
 for <u-boot@lists.denx.de>; Wed,  4 Feb 2026 13:11:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=s-vadapalli@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q2BfCZRNvkHEDmeO6FT4fhV4UgK5rkWC0A9vozdvIBnRKwAA8j/yl0M2m6+iqF0RBlEKLoAXg62/KAbSlyg8gkAmc7gf7uXp1aKC/d4MY+eSTH4njKSt6Q5Q7SjA1phMHajN9yotU8jwMdPc416IBB4BkCXBLZk7Uim9GAe6CokZsM/zlJkCdLywFGYBlxaDIcSthx8y3L3X3bWmNkwiqYac46koCg8VjjDngt9Q4OO8EyGiNvtFdzbG9iQO91IUQxjFOiaWTQGoHOyn7ZjnMLzTMwCVVcUVogSAGwGcAwumeDcfkXo9AaxzIJDUPpXKh1Ba8/PtWBI/llB5gnjEHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jcz/brSF/ZWLSIVDg6McGO7MUdHyUI+gIhV9j35m0Hs=;
 b=rvW9XGiQrEYvK+m+4N9yihZQluYNvXUO0loLNmxS5NRwGqDNI8YMRq/fqT2ffWgURxeJF+aifuVAEDP0fPseQg/jfj9dzRhf8hKRQAKxr2m4vH89+Q+e5qznkjl3DIQNBKm/hSDG+odyIkU1FoXXDAeiVcWXPMd0OnuXqd0tyk2jB32jYO00/KBpgPWXQmlmX8Wkef9r564MPVF34zE/uO8aDMEDmsHIUwWG+LxrC8MIdLYkKrXPmOEuq/w7GpX73yHfPqSakJWADT9YS27CnRiFq8CXyxWDx/ykKy7NFbPhwpDOvGzXpGh05FoYOYImQzwVU2rceYe9eD74hojuFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jcz/brSF/ZWLSIVDg6McGO7MUdHyUI+gIhV9j35m0Hs=;
 b=pmAvVFbNEY7cP9leEH4GBz3MfUqdmxWn/JO0fQyVlVoVfbRc3r8E40FOjXGKoef6Oiftkq1c2R2qaEHJo2qiU0P9S/a6ycBR+95FRk8TkS5CD3XUOc78EHxm/iyR5dcAVRa5+7p9dJaCTuxWDY1syL6Z3F9BSQTBt5pEWNrH2Rk=
Received: from SJ0PR13CA0003.namprd13.prod.outlook.com (2603:10b6:a03:2c0::8)
 by MW4PR10MB6485.namprd10.prod.outlook.com (2603:10b6:303:221::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.7; Wed, 4 Feb
 2026 12:11:25 +0000
Received: from SJ5PEPF000001D0.namprd05.prod.outlook.com
 (2603:10b6:a03:2c0:cafe::67) by SJ0PR13CA0003.outlook.office365.com
 (2603:10b6:a03:2c0::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.13 via Frontend Transport; Wed,
 4 Feb 2026 12:11:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 SJ5PEPF000001D0.mail.protection.outlook.com (10.167.242.52) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Wed, 4 Feb 2026 12:11:25 +0000
Received: from DLEE201.ent.ti.com (157.170.170.76) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 4 Feb
 2026 06:11:23 -0600
Received: from DLEE212.ent.ti.com (157.170.170.114) by DLEE201.ent.ti.com
 (157.170.170.76) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 4 Feb
 2026 06:11:23 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE212.ent.ti.com
 (157.170.170.114) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 4 Feb 2026 06:11:23 -0600
Received: from toolbox.dhcp.ti.com (uda0492258.dhcp.ti.com [10.24.73.74])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 614CBKYB1075687;
 Wed, 4 Feb 2026 06:11:21 -0600
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: <marex@denx.de>, <trini@konsulko.com>, <minda.chen@starfivetech.com>
CC: <u-boot@lists.denx.de>, <srk@ti.com>, <s-vadapalli@ti.com>
Subject: [PATCH] usb: cdns3: use VBUS Valid to determine role for dr_mode OTG
Date: Wed, 4 Feb 2026 17:42:42 +0530
Message-ID: <20260204121245.2105523-1-s-vadapalli@ti.com>
X-Mailer: git-send-email 2.51.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D0:EE_|MW4PR10MB6485:EE_
X-MS-Office365-Filtering-Correlation-Id: 06bdc036-e1a7-4cff-a857-08de63e684d3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?QlYP9MLSwnDUcTEZ720Q4smNi5ublzymqVraA3xyiJA430FmTVwRDrFtzC58?=
 =?us-ascii?Q?vKr9kGJ9bC25Nq06zRL2FfJNNIftW1eP+V5jzAC5/zbxFE4jQKe16Jo0NYuW?=
 =?us-ascii?Q?K/1pL6ASHN3T3Rok/iFb/RVoLJsa1LcEHMkbowDUvIDgO7l5zN8G2FUB1kTF?=
 =?us-ascii?Q?vD6dvy1NV/0QCYs93WPQWbkI+CAgjAIgKKeRm7D50lcq9uxRCiyXBd4EgNtP?=
 =?us-ascii?Q?Bt8RLVwrIkCCqiyD5XvJJzdn/yYXZjVMpBvJsa936eb8qFd1aEB7y1hjSQTT?=
 =?us-ascii?Q?pe7SzNhwRSNcTOvIkWgPHwwegZleelZfo50JxQTELxYH6Z0jOA5ikiX0VekN?=
 =?us-ascii?Q?PLo2k2OMkw5LVpe/1KxcDaPO1ijWQ39BY3XgyL2FSajunftsXzN3sZIciiyl?=
 =?us-ascii?Q?lvAaMP+calzbq1EK47xE+I528SevogcedQm1Vvasx1CKggRg8tnr9LgHzoMb?=
 =?us-ascii?Q?D8AWaAQypNOQkPVzKPHgHDdfdAZhJOFL+GhbnOOfblM1rPAKGaYOG9r3VOMl?=
 =?us-ascii?Q?bY5tihb583BiGwpUxIweq5R8BscEoY3b9MF2hkPcweQADAmp9um6XA961rtP?=
 =?us-ascii?Q?691dQw2BZ5eDFiN9Ty6uuygC81emYJBETgcK39KY9jj/4dQS9+FMruJXx8N4?=
 =?us-ascii?Q?Fc76r6kYwfyto0MnH5mwlgHq7bgXfX94rz4WvNhZCYVtwGaZ+thQFu2I6NJs?=
 =?us-ascii?Q?pB8zPdM7w2an/b2sbLn1mE5iq+gVlQChJEfNxdGpLswSZ42n924PBrCuvJ0Z?=
 =?us-ascii?Q?G5sGuWUkiggQB509fDXOH9B2fhe+QaNj+rCzXselIdGOgXYwvRJbC1aqkk2s?=
 =?us-ascii?Q?xlNlyzP/U9p4juc6i2C5RkVo42d2prymgU2UIcRdgaF0EW7p2yYaLbRNkpXL?=
 =?us-ascii?Q?9ZV/gqhKDdHKri089u5qYAz67DGDrpySP6DGZRJ24l/Of+8lA0D12Ty2W2om?=
 =?us-ascii?Q?UTTrYXEeca4r2A79IRJpRCkWfESBtfSrnmCCRFVeJiWBw6AO7qeR5vKgDG+f?=
 =?us-ascii?Q?IDQgq89CrZpHbMo2lhbwWUJEvnHprOFEhdULxvEnEIlQ2oyyq5v9XKWgrMVR?=
 =?us-ascii?Q?5+vlTpPA9oE2hN8cITAcuevt3qiwzcwVvJpS3Y6C6rzWgN03q10BO1DyfSmX?=
 =?us-ascii?Q?Acs5GBa4StjmOc0TPSUqUwsaD/Q4VNGT57p5FMOK9OCrCMWNYr8Y0li2YoHI?=
 =?us-ascii?Q?vojDidkNTe2jY5KLpUEQjSUWLqADPOmMK9qPyEMDc34A7SdQboKYUM5590w8?=
 =?us-ascii?Q?AN7avxqFvbc0qV1/Q7C7CkYoAVWajsfw8+OErD6xDTlZRkCoZWEP3aqxkVEP?=
 =?us-ascii?Q?wk15RKIAuyip3QGolJr7scKakgSpmyJzbyVz+y1Y8IihzJ5dTqPp4QFySW38?=
 =?us-ascii?Q?+wOTL1ITcDAb8+fyn/Ju1CFI4EDzEXKoVGZ28VrPdRtV6fFe13rMQihJyELO?=
 =?us-ascii?Q?sfOysicPAMih9iBzJwOqV64QLp5yNZcghZ+5uVkDkqDg4UghAbEvdcSn/pm2?=
 =?us-ascii?Q?tG1mK9Kk/66RtLHaVYD0mJmVm7fECmANNHRUQ6rOIQ3GUgtwTvICwDjicx4Q?=
 =?us-ascii?Q?LjnO+TUUCWbMB1WhMQw6rfaBYJaFy33Y4xo7MoQGI18nMfdvlbqvB8ruHZFm?=
 =?us-ascii?Q?Yn5kRHj+JtqrprLuNKHD59A=3D?=
X-Forefront-Antispam-Report: CIP:198.47.23.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet200.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: lLkWttAk5X/alHeEFL1/MUGS73INn/qg042t1CtEyeM5laPuK43w8WPl0XVISIhGKV6uqzE2BwoJaOPD3+HBHquDSrINO3zAI0T2HKqa1sOb8BHZ6zysAsyxLoUMRxVewS/zN5j23gF3hLgEylBJ2z53SFkbqbqRDhHSTXsSCQpohuV92NjlbKULS2INOUjlvu+t/AE/QlQ8RoyBJQKlrPGsV/sFgXDYipwbmQ8P+GJy4EwYy9P0glXgzYm9P2x39sjdH9SQ6K+Pf83Qp2+T4NnOdHtPVV68kQfSu2KSzC+BPqoetBAVQNIMmNlC4xIBIcpOzxoZA59Cz/DGwYdA34q2aNvwP59Tq+t2j2xKQCMkFleP5ueJU/mMVwIa6pOIcprW9TeRXEUii+7II1S4NRfnjtTe40gAvFMfP03QwI5h+rQdQ1UGE4xlEtLjCV3z
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2026 12:11:25.4005 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 06bdc036-e1a7-4cff-a857-08de63e684d3
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.194];
 Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001D0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6485
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
a8d982e1f17 x86: cpu: Fix crash on FTRACE enabled builds
of the master branch of U-Boot.

Patch has been tested in the context of USB DFU boot on the J784S4 SoC
with a Cadence USB 3.0 Controller. Since the Linux device-tree for the
J784S4-EVM specifies the 'dr_mode' as OTG, due to reuse of Linux
device-tree by U-Boot, the 'dr_mode' of 'otg' causes USB DFU Boot to fail.
While one approach to fix it is to update 'dr_mode' to 'peripheral' in
the 'k3-j784s4-u-boot.dtsi' file as a HACK, it doesn't scale to other
SoCs and all of their 'u-boot.dtsi' files will have to be udpated as well.
While I am providing Texas Instruments SoCs as an example, I presume that
SoCs from other vendors are also affected by the 'dr_mode' being 'otg'.
This patch addresses the issue by using the VBUS Valid bit of the OTG
status register to override 'dr_mode' from 'otg' to a deterministic role
to enable functionality.

The USB DFU Boot Logs for the R5 SPL stage on J784S4 SoC with the current
U-Boot master as of commit
a8d982e1f17 x86: cpu: Fix crash on FTRACE enabled builds
are:
https://gist.github.com/Siddharth-Vadapalli-at-TI/b910f326b6c9fad760190bd299ae3ff3
and the logs indicate that USB DFU Boot fails. The failure is specifically
due to 'dr_mode' being 'otg' and the cdns3_bind() function failing to bind
the device-tree node to the peripheral driver required for DFU Boot.

The USB DFU Boot Logs for the R5 SPL stage with just this patch applied
while leaving 'dr_mode' at its existing value of 'otg' are:
https://gist.github.com/Siddharth-Vadapalli-at-TI/033b9772b6ab105b96806adf890848fe

Regards,
Siddharth.

 drivers/usb/cdns3/core.c | 53 ++++++++++++++++++++++++++++++++++++++++
 drivers/usb/cdns3/drd.c  | 11 +++++++++
 2 files changed, 64 insertions(+)

diff --git a/drivers/usb/cdns3/core.c b/drivers/usb/cdns3/core.c
index 4434dc15bec..b7be5c48fc9 100644
--- a/drivers/usb/cdns3/core.c
+++ b/drivers/usb/cdns3/core.c
@@ -392,6 +392,55 @@ static const struct udevice_id cdns3_ids[] = {
 	{ },
 };
 
+/*
+ * The VBUS Valid Bit in the OTG Status register can be used to determine
+ * the role. When VBUS Valid is set, it indicates that a USB Host is supplying
+ * power, so the Controller should assume the PERIPHERAL role. If it isn't set,
+ * it indicates the absence of a USB Host, so the Controller should assume the
+ * HOST role. If the OTG Status register is inaccessible, return OTG role.
+ */
+static enum usb_dr_mode cdns3_get_otg_mode(ofnode node)
+{
+	struct cdns3 cdns, *cdnsp;
+	void __iomem *otg_regs;
+	fdt_addr_t otg_addr;
+	int otg_reg_index;
+	int vbus;
+
+	otg_reg_index = ofnode_stringlist_search(node, "reg-names", "otg");
+	if (otg_reg_index < 0)
+		return USB_DR_MODE_OTG;
+
+	otg_addr = ofnode_get_addr_index(node, otg_reg_index);
+	if (otg_addr == FDT_ADDR_T_NONE)
+		return USB_DR_MODE_OTG;
+
+	otg_regs = map_physmem(otg_addr, 0, MAP_NOCACHE);
+	if (!otg_regs)
+		return USB_DR_MODE_OTG;
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
+		return USB_DR_MODE_PERIPHERAL;
+	else
+		return USB_DR_MODE_HOST;
+}
+
 int cdns3_bind(struct udevice *parent)
 {
 	enum usb_dr_mode dr_mode;
@@ -413,6 +462,10 @@ int cdns3_bind(struct udevice *parent)
 	if (dr_mode == USB_DR_MODE_UNKNOWN)
 		dr_mode = usb_get_dr_mode(dev_ofnode(parent));
 
+	/* Use VBUS Valid to determine role */
+	if (dr_mode == USB_DR_MODE_OTG)
+		dr_mode = cdns3_get_otg_mode(node);
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

