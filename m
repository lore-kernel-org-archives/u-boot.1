Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B69CC02181
	for <u-boot@archiver.kernel.org>; Thu, 23 Jan 2025 01:01:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8BC3B80763;
	Thu, 23 Jan 2025 02:01:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 139E780137; Thu, 23 Jan 2025 02:01:32 +0100 (CET)
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn
 (mail-sh0chn02on20715.outbound.protection.partner.outlook.cn
 [IPv6:2406:e500:4420:2::715])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 826D980137
 for <u-boot@lists.denx.de>; Thu, 23 Jan 2025 02:01:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=starfivetech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=minda.chen@starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hm7WY47sQJbpZ0qZPl+0nxZRVrl8UGFYEQjXm27aVdVvGuBtFQfT4wQaZMVc0P831yXgXCIxnirbkpGJAr7+yA8KfG5n8oFXMQT6imYU68/4pMVJM8mrbeOIBVAD7yaSfUrmSbHZFxKmPoFjucR0rTUCxKtuFOJJVOsQvuVptbM1ryhiTCSpgFJwgwSI8lv3mVSYeivhsEbd5QDqMYubAtZ4xzQSBDKPuGSvvRcr069OS5t7s85vUmM4C9FQqno72U+DXTFzxwRkSthrCM0pMq8js73ITFB+Rs5pUc/TGLpIprO4Eno29u/RHx+69KJpyeCeCa+MWcKq3pYWER3hHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gyl3NbSkB+9G8rmD5hvrNfIv5u86y1+SOdHIgUcBQwQ=;
 b=kTARNGvkArmXGJE6YDYCXig0g1TsrtO6wnRL2jo0FVj69JjYfGxUneLb5QZEcXhcVVICTPZ9oXtqB+A8HiuO0ljF0bMdni2X98WI5XWIi/Si2URdcAUJNvsy4bvmvzNGjtefxlKxNbq0UQtheLKeR3B5Qr5ySFb73lnBilxiA41VvRJxgvH1ldCxoLQO8x2NSnZHKuQ51klYeYWMi/vcx/P/SOB5RJNEds0O8ZCFtnNk6Vx2l3Cj1zKNIg6MZ6tT84l3K+hUBo5XtIPVBNT+XGFEpz4zlYLTXwxMwVDU/KAjxGdtTKbbw3mAL7MLIPbyp9w+eQDSmmos2gg0lWzVJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::15) by SHXPR01MB0813.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.8; Thu, 23 Jan
 2025 01:01:22 +0000
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 ([fe80::3f35:8db2:7fdf:9ffb]) by
 SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn ([fe80::3f35:8db2:7fdf:9ffb%4])
 with mapi id 15.20.8377.007; Thu, 23 Jan 2025 01:01:22 +0000
From: Minda Chen <minda.chen@starfivetech.com>
To: Marek Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>,
 Roger Quadros <rogerq@kernel.org>, Rick Chen <rick@andestech.com>,
 Leo <ycliang@andestech.com>, Neil Armstrong <neil.armstrong@linaro.org>,
 Alexey Romanov <avromanov@salutedevices.com>,
 Sumit Garg <sumit.garg@linaro.org>, Mark Kettenis <kettenis@openbsd.org>,
 Nishanth Menon <nm@ti.com>
Cc: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Simon Glass <sjg@chromium.org>, E Shattow <lucent@gmail.com>,
 Minda Chen <minda.chen@starfivetech.com>
Subject: [PATCH v6 1/8] usb: cdns3: Set USB PHY mode in cdns3_drd_update_mode()
Date: Thu, 23 Jan 2025 09:01:05 +0800
Message-Id: <20250123010112.78924-2-minda.chen@starfivetech.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250123010112.78924-1-minda.chen@starfivetech.com>
References: <20250123010112.78924-1-minda.chen@starfivetech.com>
Content-Type: text/plain
X-ClientProxiedBy: ZQ0PR01CA0029.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:2::10) To SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SHXPR01MB0863:EE_|SHXPR01MB0813:EE_
X-MS-Office365-Filtering-Correlation-Id: deb57ae9-4ec6-4ec3-3ccf-08dd3b4973fc
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|52116014|1800799024|41320700013|366016|921020|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info: Yk873ruMlcNhdv95RXMsbeuE9WfXtRrpgu8shDQRQsjJXzeVAwleKyAPVQfBk/isS18WfCyBstJkhLEruf4G3XFadA6c54l0/80PnLSWTHDRfQhXmZU9+3mNClNVjitK4DXPNEAQXiwTIhrO4Zns3EwUG5+wRgyQrfMeAseY3JMXD+YWfZ5xVZf0Tlt3gbyrvShm4HW4k3eSon/bhKf652R6EEpGOGBoSIwXlITpr5tQzmKGgj7/bqQwYtA/jeNVASfhhLUu3oSuu9CvyZK+wzU498zuQPuBuvViWrcdERzCu6zmAuBKT/flD28x5Cd1uKIXXsfkHVdIWuoi3dGVIFuqLAxLNoL641GPC4BC7NYgIFjv7fURbT2UA8Lb7hfzqJ5Thmzvd+obqX7F1KY8uv4+BNLCV306Zu9Cu7HzsYB9X3t5AzkVoPemJWspXipv95teZzXCB4cURZg6PO3Rf9e/5GC9/qcpQgxMoE8a844Ib1UBad5XWZhiHwJRhbxAq22H3SIKlY7DXNR3tvJTK3t7RVgRe0N239ZvxgNZXe5a38vxBKriGFfxIVp6rJgWbS9qq3qofLQuzHg5nlNxjkyN+nLgtul3aI4YQkTmIkQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn; PTR:;
 CAT:NONE;
 SFS:(13230040)(7416014)(52116014)(1800799024)(41320700013)(366016)(921020)(7053199007)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9rsy7HQJZ+DjWIYaxoerwHAsTRIwk3hRML4jjZ4g6HKPi0+iZ+HOeWcqfn1G?=
 =?us-ascii?Q?dU/BSMDqDnraRmzMJ35706ZyBtUcunk2yuS54UgKv6lRLKPInpIIoBBJf5fM?=
 =?us-ascii?Q?1TVNJjNPIPboMcRwBG1OV1EtJwnqOpyy8pumpiyAXfSKzvfTvNrdPMEspTWr?=
 =?us-ascii?Q?/2AFp5rFMw0aWmnnvvx7cG9q/Wx6P3B8xurMalKzbXYiWqalwcsgnyAzf+On?=
 =?us-ascii?Q?xRFYpUytUxd7f94zGrGBM2fPBSDq+cH4i6oBMsJom/DVZwQeyFAefxaG+yho?=
 =?us-ascii?Q?n4++vTRKdB4pR5sCIq4eJ6tJFKEr2+SewL9SuuV52VeBpeIZhOQsMm2s55wd?=
 =?us-ascii?Q?nRsrKfbneS0zNYl3xdLVTIp6RbnYjl+OgJyPDBnKCUSPp07GLxgkHVMKauni?=
 =?us-ascii?Q?O/6MWJACvgOd0ZfFvTSmvo6XbIqCCPxOFsh5xmp9crNXsW+hpWzCP7BuwVDe?=
 =?us-ascii?Q?9CONniEtPkMYzaqvHW29or5eSclQ0xglG0uiZmfzqPLjWc9afFCJkSaKIebZ?=
 =?us-ascii?Q?4n786m74KKRVcBT0JjeHBSQlXTQ3Ntaev68XwxHHB+E7hSADse3QQfpGeoC1?=
 =?us-ascii?Q?pU+TDazQkI7BIvi5KLecOfWY9K4YAGnaurN0WDh6fxCqnNDPuuR+hsStnu9i?=
 =?us-ascii?Q?fHBijWz1qLYlSG1acgpqvL0dfIi6zWE2K38hMmd4+ljQ/Biao0gvQZF2ToG1?=
 =?us-ascii?Q?Gwi83+PvIvQ6gFZjINhv08EgasaQXRl4+ANLXj1IOp9J67Fzzb/8W2Q+KdAb?=
 =?us-ascii?Q?i5W+PNkK5W+CTBmhdXZ8+3gODiM1g7HvDDcQ7OaoHoit9inJaexOGUlEJ5Jo?=
 =?us-ascii?Q?6riuD12OW+b/fJxp2jyUiUDBV8RkMYMd+f7kRpmFb6pLQRCr+DBVfLVJYR5b?=
 =?us-ascii?Q?3CFybNZlUWR137Gj8w0j8HOXyG24M03y0Ix6AF3tOTTqF9Zyq9MLC+/y52dC?=
 =?us-ascii?Q?GkFSdYrhoX9FZCrjNyCyQScmgMdvXdmwnupEisiZFJ4qDScF+pTl5Yj31KFp?=
 =?us-ascii?Q?dP9IAHKFFt1CqEaiSebl2fOYGVqBbEifoU7fH75DDQS/HCg9xP2RaVUZjzbQ?=
 =?us-ascii?Q?lPOGR1FLmmor6rci2l1G82R1VpT3o2tNpC3ZsFOtSOhwvL31mKPZNXvAQpLN?=
 =?us-ascii?Q?l5M2QS6YGQRBhm1lrxvw9h9ZMPEzLgNg+fKNuiZNtFZ89uuhuoESv5dnGofa?=
 =?us-ascii?Q?Volkc8pymPmop0fHX3flgRmjnNaUHSelConDJCBxx6+at9h8AEvxRhQTRWv0?=
 =?us-ascii?Q?Zi21XksCvLP1YVDWJMsfmabM7QXYL7jih9azzIILH9j5myWIcNt6kCBB1kOV?=
 =?us-ascii?Q?ys5xVdiKaMhVKaeDoGX19817YfGCYEQI8+bZhb0ggKiYfNIft/13guZmOF+2?=
 =?us-ascii?Q?WiWHIFwhSmZW1Gs181Z2wuFq9CkvCwggKJJ5ZwQ6rCJ+W0hYcOu95/Mr1SRA?=
 =?us-ascii?Q?5RsHB1rhcjtE3O+KcZXF71LkAIm1I0ap77qF/tvmmbJSw6J//p01lVQRznee?=
 =?us-ascii?Q?xuFVIPyHe1ZlcJwmjAdr2oaBVdNDNTd7PyjXQkkgYkXElgkqQ3r6ihXMd2qU?=
 =?us-ascii?Q?KZX7WX0DRxzKI5XLYQ1FAV59qY+NRhj6fFZWNkPARniv4rH5VN/paUQVcwM8?=
 =?us-ascii?Q?1w=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: deb57ae9-4ec6-4ec3-3ccf-08dd3b4973fc
X-MS-Exchange-CrossTenant-AuthSource: SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2025 01:01:22.2463 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XmNNXmJ4mVIBTMG0hYeQJwrV2DyRPDn72sQUX3DGeg2INJNpw5lfuKlMuQn54SYIe6/RBQPMzS1+2tsoz5c17IC9mUIF2rIbv83kLx3jp5E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SHXPR01MB0813
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

USB PHY maybe need to set PHY mode in different USB
dr mode. So translate USB PHY mode to generic PHY mode
and call generic_phy_set_mode().

Signed-off-by: Minda Chen <minda.chen@starfivetech.com>
Reviewed-by: Marek Vasut <marex@denx.de>
---
 drivers/usb/cdns3/drd.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/usb/cdns3/drd.c b/drivers/usb/cdns3/drd.c
index 47874fec29e..cbb13342343 100644
--- a/drivers/usb/cdns3/drd.c
+++ b/drivers/usb/cdns3/drd.c
@@ -217,15 +217,19 @@ static int cdns3_init_otg_mode(struct cdns3 *cdns)
 int cdns3_drd_update_mode(struct cdns3 *cdns)
 {
 	int ret = 0;
+	int mode;
 
 	switch (cdns->dr_mode) {
 	case USB_DR_MODE_PERIPHERAL:
+		mode = PHY_MODE_USB_DEVICE;
 		ret = cdns3_set_mode(cdns, USB_DR_MODE_PERIPHERAL);
 		break;
 	case USB_DR_MODE_HOST:
+		mode = PHY_MODE_USB_HOST;
 		ret = cdns3_set_mode(cdns, USB_DR_MODE_HOST);
 		break;
 	case USB_DR_MODE_OTG:
+		mode = PHY_MODE_USB_OTG;
 		ret = cdns3_init_otg_mode(cdns);
 		break;
 	default:
@@ -234,6 +238,16 @@ int cdns3_drd_update_mode(struct cdns3 *cdns)
 		return -EINVAL;
 	}
 
+	ret = generic_phy_set_mode(&cdns->usb2_phy, mode, 0);
+	if (ret) {
+		dev_err(cdns->dev, "Set usb 2.0 PHY mode failed %d\n", ret);
+		return ret;
+	}
+
+	ret = generic_phy_set_mode(&cdns->usb3_phy, mode, 0);
+	if (ret)
+		dev_err(cdns->dev, "Set usb 3.0 PHY mode failed %d\n", ret);
+
 	return ret;
 }
 
-- 
2.17.1

