Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D3ACC4707B
	for <u-boot@archiver.kernel.org>; Thu, 11 Jan 2024 07:11:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 42AA087A61;
	Thu, 11 Jan 2024 08:11:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="PVaCBWea";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 117C4876EA; Thu, 11 Jan 2024 08:11:15 +0100 (CET)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2416::601])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DFC8287738
 for <u-boot@lists.denx.de>; Thu, 11 Jan 2024 08:11:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=venkatesh.abbarapu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iSIqLRW+0iVWiBtEFKh8h4Mc6r7I16oEVUZ0iw+0L185bq9KypWIKpS2mmYhlFSMWJDY0On0NobSbWFfTF+g3NtlhWts55Iv8okJpa4C+EyOJvxUlDk6M0v2ET1IE9AjT53gsxq3prwFkvC7fT/XRm++cMEbU10dqV7mIJUh0w4H326TEnAVQg5TWktgVktW2SIv+Aw2hMKZxZO+JwxZ0jnobPmyAHePeL+nhdh1tumdy/rG8hNmMK0OX1+OPQe174rjjV1GHBfk1itl/zzyTrXQmd2mgLx7Vnl2Qe29UrkMWQGBqnIB7kHNMuLu1v9QMki19p2kwuUR+EFjErNSWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ilJdqSgm7KfqjPxmZ+6W1lQm+PA/gQCryL4mSmwwTr8=;
 b=F2PL5WfjV/02JKBZx1V5xQTE0Svt1vEmJ+EG0apCZSWYhfyQELcjLwxqG35Fb9fZ5LTSmzBKTjKchbW92ZPLcpnaBMBfBOag7GKxeaFNyhrj16EEaxPhdiVUBWEpxBTOLYYJkN4KEKAGmkzAJyAG/kypaIZbdMMfEfqFk5LVYrLjr52++ZYHIcAZf2B6GtWGglILowDGlL+H9hr4ZVU+uq0viTsnCVF2yIu5U3zzaPlbm8ReJQGpsj+XoLduBUUH9NJz/EEneKcv2si4pNtvURh5eZQKC8aMFQ7IRE3BOYutKF0CKFbJ4mN5BdEDnROVNW3VzU0WpXtwnyp0O0RQmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ilJdqSgm7KfqjPxmZ+6W1lQm+PA/gQCryL4mSmwwTr8=;
 b=PVaCBWeaBMp+dNItipLe/4JZfG1FzMoVbjvzuyhkj9fy2tQq/p6VMFk3RlMfFDyzxR0O2vN8X4NKINtZaqOUeAIjkS1Y2vhg+5ZG6HCnPlc67YcGdkrXhIEwAbq9/9LXNs81sSFzZtVpCiKDqxwYnWDxFwA+eyng3ci2Y+rQNjo=
Received: from CY5PR19CA0082.namprd19.prod.outlook.com (2603:10b6:930:69::28)
 by LV3PR12MB9260.namprd12.prod.outlook.com (2603:10b6:408:1b4::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.18; Thu, 11 Jan
 2024 07:11:08 +0000
Received: from CY4PEPF0000FCC5.namprd03.prod.outlook.com
 (2603:10b6:930:69:cafe::b9) by CY5PR19CA0082.outlook.office365.com
 (2603:10b6:930:69::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.19 via Frontend
 Transport; Thu, 11 Jan 2024 07:11:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CY4PEPF0000FCC5.mail.protection.outlook.com (10.167.242.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7181.13 via Frontend Transport; Thu, 11 Jan 2024 07:11:08 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Thu, 11 Jan
 2024 01:11:06 -0600
Received: from xhdlovek40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34 via Frontend
 Transport; Thu, 11 Jan 2024 01:11:04 -0600
From: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
To: <u-boot@lists.denx.de>
CC: <michal.simek@amd.com>, <marex@denx.de>, <git@xilinx.com>, T Karthik Reddy
 <t.karthik.reddy@xilinx.com>
Subject: [PATCH] usb: dwc3: Integrate usb5744 & usb2244 driver support
Date: Thu, 11 Jan 2024 12:40:57 +0530
Message-ID: <20240111071057.2771902-1-venkatesh.abbarapu@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC5:EE_|LV3PR12MB9260:EE_
X-MS-Office365-Filtering-Correlation-Id: 15a4f814-f73e-4867-1d07-08dc12747bc3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0cB2BiIzuFNgrkkblnWyJMnHJ9XJFnyXnO7DzLU2eLVcdsBkyRNkhZyY89w5/k6M2Df5f/c7lU/9yEANFFZTKaLOqPQaJsEaCtlS+kzp593wv/Ko40vJ+hKxXtGXXIShJMXpB0k/PpqT37sU2GOCsiQojmTUffPzzLl6NO8aTJI5vS46MZy8S5lV92GDIlT7a3H9gAt00kcXSpk9S1naUR5ZdZaDvejZZ/HuEjPD+fnKlvakPX8E2r07rbOcprMp0iqpIOxpV4W40P2sZcDVhrHRO5TsQGgngXjdMyvbuqGVw638X6FusD5fBzlww/M6o3pI0+JFeRiMXYzMYm90DOgMHixu3bC9RLoijR3+kOTR9WhH3tIb0udI3X3/Bw/k2thtb2VNeNHYn9idZZHvkww/VRXU2dLEYjx7eIrvxgaHjL+QuWDiCdz9a+SDLRUMYA8lvMnT4YhP25Z8+dCOsXSEmdB1SZzRBQ/kWFZT80NzhI9IWRj7IT33oIB7Hg+H2bfxS164kZ11wlVMLKFa3aCBhh4Y6m0K0cGb1YWSWlg97Gm/MOjGe7EDJKNKh+1okvJbVIe7ItZ3QEGX4YYG4W9Rpmb8+ue8EVo6jfEUdXMi9Tm5g0fIR4RKJjN/E/kQvpJ8dth6UtSAoNAAHFebuZfI9kvuLvSCY0qrH8y60K+wEfpIbVonfw6fFv2tAWzHA2Z92wPgk8WzL0DXJTnDDFXWM5/LAj/bFAbl0tRQ4ZdAFvuR0V0YBeRFEUFXHF2RkMKDrq+ZQ2Wiqi/jBSIWFQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(376002)(136003)(346002)(396003)(230922051799003)(64100799003)(82310400011)(186009)(451199024)(1800799012)(46966006)(40470700004)(36840700001)(40460700003)(40480700001)(36756003)(478600001)(86362001)(36860700001)(82740400003)(356005)(2616005)(47076005)(1076003)(336012)(426003)(26005)(81166007)(83380400001)(5660300002)(8676002)(4326008)(2906002)(316002)(70586007)(6916009)(70206006)(6666004)(8936002)(41300700001)(54906003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2024 07:11:08.0564 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 15a4f814-f73e-4867-1d07-08dc12747bc3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000FCC5.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9260
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

Usb5744 & usb2244 are Microchip based usbhub and usb-2.0 based SD
controller devices. Integrate these devices into dwc3 driver to bind and
probe the respective drivers to get detected by usb controller.

Signed-off-by: T Karthik Reddy <t.karthik.reddy@xilinx.com>
Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
---
 drivers/usb/dwc3/dwc3-generic.c | 67 ++++++++++++++++++++++++---------
 1 file changed, 49 insertions(+), 18 deletions(-)

diff --git a/drivers/usb/dwc3/dwc3-generic.c b/drivers/usb/dwc3/dwc3-generic.c
index 6fb2de8a5a..a2eb2c8e24 100644
--- a/drivers/usb/dwc3/dwc3-generic.c
+++ b/drivers/usb/dwc3/dwc3-generic.c
@@ -430,29 +430,49 @@ static int dwc3_glue_bind_common(struct udevice *parent, ofnode node)
 
 	debug("%s: subnode name: %s\n", __func__, name);
 
+	if (!ofnode_device_is_compatible(node, "snps,dwc3")) {
+		if (ofnode_device_is_compatible(node,
+						"microchip,usb5744"))
+				driver = "usb5744";
+		else if (ofnode_device_is_compatible
+			(node, "microchip,usb2244"))
+				driver = "usb2244";
+
+			ret = device_bind_driver_to_node(parent, driver, name,
+							 node, &dev);
+			if (ret) {
+				printf("Failed to bind: %s, err: %d\n",
+				       driver, ret);
+				return ret;
+			}
+	}
+
 	/* if the parent node doesn't have a mode check the leaf */
 	dr_mode = usb_get_dr_mode(dev_ofnode(parent));
 	if (!dr_mode)
 		dr_mode = usb_get_dr_mode(node);
 
-	if (CONFIG_IS_ENABLED(DM_USB_GADGET) &&
-	    (dr_mode == USB_DR_MODE_PERIPHERAL || dr_mode == USB_DR_MODE_OTG)) {
-		debug("%s: dr_mode: OTG or Peripheral\n", __func__);
-		driver = "dwc3-generic-peripheral";
-	} else if (CONFIG_IS_ENABLED(USB_HOST) && dr_mode == USB_DR_MODE_HOST) {
-		debug("%s: dr_mode: HOST\n", __func__);
-		driver = "dwc3-generic-host";
-	} else {
-		debug("%s: unsupported dr_mode %d\n", __func__, dr_mode);
-		return -ENODEV;
-	}
+	if (ofnode_device_is_compatible(node, "snps,dwc3")) {
+		if (CONFIG_IS_ENABLED(DM_USB_GADGET) &&
+		    (dr_mode == USB_DR_MODE_PERIPHERAL || dr_mode == USB_DR_MODE_OTG)) {
+			debug("%s: dr_mode: OTG or Peripheral\n", __func__);
+			driver = "dwc3-generic-peripheral";
+		} else if (CONFIG_IS_ENABLED(USB_HOST) && dr_mode == USB_DR_MODE_HOST) {
+			debug("%s: dr_mode: HOST\n", __func__);
+			driver = "dwc3-generic-host";
+		} else {
+			debug("%s: unsupported dr_mode %d\n", __func__, dr_mode);
+			return -ENODEV;
+		}
 
-	ret = device_bind_driver_to_node(parent, driver, name,
-					 node, &dev);
-	if (ret) {
-		debug("%s: not able to bind usb device mode\n",
-		      __func__);
-		return ret;
+		ret = device_bind_driver_to_node(parent, driver, name,
+						 node, &dev);
+
+		if (ret) {
+			debug("%s: not able to bind usb device mode\n",
+			      __func__);
+			return ret;
+		}
 	}
 
 	return 0;
@@ -479,7 +499,6 @@ int dwc3_glue_bind(struct udevice *parent)
 		if (ret)
 			return ret;
 	}
-
 	return 0;
 }
 
@@ -530,6 +549,7 @@ int dwc3_glue_probe(struct udevice *dev)
 	struct dwc3_glue_ops *ops = (struct dwc3_glue_ops *)dev_get_driver_data(dev);
 	struct dwc3_glue_data *glue = dev_get_plat(dev);
 	struct udevice *child = NULL;
+	ofnode node;
 	int index = 0;
 	int ret;
 	struct phy phy;
@@ -560,6 +580,17 @@ int dwc3_glue_probe(struct udevice *dev)
 			return ret;
 	}
 
+	ofnode_for_each_subnode(node, dev_ofnode(dev)) {
+		if (!ofnode_device_is_compatible(node, "snps,dwc3")) {
+			ret = uclass_get_device_by_ofnode(UCLASS_MISC, node, &child);
+			if (ret) {
+				printf("could not get device %s, err = %d\n",
+				       node.np->name, ret);
+				return ret;
+			}
+		}
+	}
+
 	device_find_first_child(dev, &child);
 	if (!child)
 		return 0;
-- 
2.25.1

