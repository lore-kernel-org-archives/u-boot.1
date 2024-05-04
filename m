Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8807C4345F
	for <u-boot@archiver.kernel.org>; Sat,  4 May 2024 15:04:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4BB58885BE;
	Sat,  4 May 2024 17:04:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id C0EB788585; Sat,  4 May 2024 17:04:16 +0200 (CEST)
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn
 (mail-bjschn02on20709.outbound.protection.partner.outlook.cn
 [IPv6:2406:e500:4440:2::709])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2313388585
 for <u-boot@lists.denx.de>; Sat,  4 May 2024 17:04:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=starfivetech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=minda.chen@starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cntEMOVyLEOwHlwZgVDfHGSybxP7oEAvq3ssipG1bSOD3L0Wqcl7nEfd4IOMLgZFyu7ygxn7BRLS98jbWJon9BJrGT+fsNCmP4KN1MXsYp6U+DuMMd/Serv3l9uHPyT9DA25QV+AJQXq8uSt/mrIEhnFPXJHaG0zrfsBGKJx2Bp8DgUCsndwLoHc3x1zS8bplSomw5/ud3zOnYTFWemBjnHry7gKP5PgQ1mTGQZbl3//oXT34mpGqMao/H9uyoREfEn92VQvjTGB6CQAxObd29NWpwAzL7ZOUCF4GcNLY4aSRnoA0eCdNFj8gvESAeftfIj9el1dX2GFwFJEsEWQZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R1DvyoNKjOdMtY+FbKIECMJ7A0Au9+ZD5yjQKxthnAw=;
 b=TJq6Gw6J7qhdCCtICy3K2lAB8W4PnEXHWs1DtQXBDippi/upsWjxqfIfXiIt9CF7SpYAwOO/dJqNh7+G/O9q/ldTLVnDfr6jwn24/8+//C8Q8IT9lJ/hxqBttVO54iw0PmQH00IlAYz77ADgXjfwzZaEVMx2UoIvvoyU4qjq2lr2QvAF+Qj4NxmVy8z208vfGLGWdTII6NzlxEbs+2R/7gQRVtTKoZrJGDFd4vGL/Ya6U9AzxLQNGc5lJ04Ciyx3jExW6n7vFgesKWDOHzrlgVrut8lpqCp/Cr2a6/FaCUKEEwSODjLQXvtmiTAAahZBPzX/D9jW94AKNuslxTsLTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from BJXPR01MB0855.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:18::12) by BJXPR01MB0839.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:1a::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.54; Sat, 4 May
 2024 15:04:08 +0000
Received: from BJXPR01MB0855.CHNPR01.prod.partner.outlook.cn
 ([fe80::3e54:57b5:e3e3:7f09]) by
 BJXPR01MB0855.CHNPR01.prod.partner.outlook.cn ([fe80::3e54:57b5:e3e3:7f09%6])
 with mapi id 15.20.7472.044; Sat, 4 May 2024 15:04:08 +0000
From: Minda Chen <minda.chen@starfivetech.com>
To: Marek Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>,
 Roger Quadros <rogerq@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Alexey Romanov <avromanov@salutedevices.com>,
 Sumit Garg <sumit.garg@linaro.org>, Mark Kettenis <kettenis@openbsd.org>,
 Nishanth Menon <nm@ti.com>, Rick Chen <rick@andestech.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>
Cc: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Simon Glass <sjg@chromium.org>, Minda Chen <minda.chen@starfivetech.com>
Subject: [PATCH v1 1/7] usb: cdns3: Set USB PHY mode in cdns3_probe()
Date: Sat,  4 May 2024 23:03:52 +0800
Message-Id: <20240504150358.19600-2-minda.chen@starfivetech.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240504150358.19600-1-minda.chen@starfivetech.com>
References: <20240504150358.19600-1-minda.chen@starfivetech.com>
Content-Type: text/plain
X-ClientProxiedBy: ZQ0PR01CA0005.CHNPR01.prod.partner.outlook.cn (10.2.0.75)
 To BJXPR01MB0855.CHNPR01.prod.partner.outlook.cn (10.43.36.12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BJXPR01MB0855:EE_|BJXPR01MB0839:EE_
X-MS-Office365-Filtering-Correlation-Id: 49762bb9-b9c8-42f1-75a6-08dc6c4b729f
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JYEM331AmWfPyp4YzywWQyzhy8Dha3whX0Gg0nO5anGEoHyHtCd5SQQJnU07Zn3sJBTXPO/fZVXheKNz07JbHA6qba/Y3NSZIppXgJ+O3L7u17A4Jp0BIo8GQa1hpZlmilUk8+lITdRCPvIQxxXgb3ey/t+kAOT/5RFrohmnf7cb62BqhKXwIUpFkTM+J0/7Ar04DZDeyl6Lnoej1p0IiDL8icW1DJ9nM5PyTjy62Ejluuk0qQle/LsMAfuy3bkIQZoetDwe9sG0HJgUulNqTyv7SvJTM1+NaghJ1vj2hziXuIuaD/ro18l3MWiJ4kbr07+Wv2Z0BRJgMthJ+g+jMKa2Gabv5IzVJjrVIRIaTo5V3D3kz+MN4MxWnzb8rsP8TouuGiwciTGjvCtsOQ5yCFsQo2OLgDao4xP8pvthwfmHlt3amYsBMYQrIbEN+I98bDx4WdPMHfAWafzO8Fp3PBKvtfYLonR0WNkqQTyIvN5J0h8o4uot5oFsYVbZRynlvTdLelwbK+Jv301xv24Ai2QtOOvmD/v6v8mW8b1QfTuzUiox1oGzte01MQbdkv2gC2FUXCw4VEi1eE2AlUa8CC028hHZGcm4Uhi0zkfYXlAd7AamUipF7L3oWHzblf6UvSaH82PxoJLOlcFGPZLRRw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BJXPR01MB0855.CHNPR01.prod.partner.outlook.cn; PTR:;
 CAT:NONE;
 SFS:(13230031)(1800799015)(52116005)(366007)(41320700004)(7416005)(38350700005)(921011);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?u2ZKPj3wb93/+PZw9s+MuX4614F4qjtHnVHi4x9A3vjDBSLfLSLCPI6C582p?=
 =?us-ascii?Q?7DUE1P3KIKKE5TAwumAzIQnm69ZBduGck8+L1apvWtUONTaxdyiYXM+iJYqK?=
 =?us-ascii?Q?xzWeGzkVt+03e+qZ1XmpmHICau29P0Fh0QjAq9G537a5wtld5tO7NRoox/WF?=
 =?us-ascii?Q?pphvmRWucWUV+chqOs4vnBaquc0ZA0k5WMGn6nN2PRcPAmeVrNx654RuCUOX?=
 =?us-ascii?Q?m7fsH8HZKgRsBCFlyiiFsA+i2PGO4ArZaEt+HjrzbdvIIvtnmT3uYWXXtViA?=
 =?us-ascii?Q?oNQatNbGsDveEQMSoeKr4jbDA8EUri5i+KK9WRTpeNLNrQkk4JFr1S6FBVfW?=
 =?us-ascii?Q?UowG6h4SeesxnxeAc/Y2QoiVdy0Niq1eESUk4q5t9TXMJ/Q38SAlhJRtM/xj?=
 =?us-ascii?Q?gO+IxmJKxJHXgBzllRdJ0pmN8WN5mdlWyiQmGZSsLFlV1fCCXfr6f3upbBb5?=
 =?us-ascii?Q?nyYqt0Mbbw3XArFES6Fu9dJgylO95X7+SLLwUBE5dPcHE8kpir/LJmfXIDMv?=
 =?us-ascii?Q?ZBpzJg0ozZv3itUFSRD4HN/XM5vxRixolAUaogJpwBFYRDRvOPxO/1CIEKLb?=
 =?us-ascii?Q?NVH8trNwdIwO4rP8zzxhY1xjHOZ/4DDE5m6Vkz7/qFb4u8mWi6xp8QBuQHst?=
 =?us-ascii?Q?uMJpi3G0auVVaZQtbo9L0R1toGswdMxGqTKMhx2PeeQ631y9VYrJRhrrodgj?=
 =?us-ascii?Q?4CDpYJbH0j2pZ9jVfIb7Vd/dekcJM7eOIx22qBRLwKV2MRUR1VKHNoA2rzef?=
 =?us-ascii?Q?PoXyzKmuGqIH7lScggmDNCGBUH0+5Fe35aKqimIvNNpeyWtmGb0wE7L/3f5z?=
 =?us-ascii?Q?B/tCz0JaAaxBDIRvEACu1Jgw5E4V95V2+d5IM0p7x1+7BuNcjpOK+6FCSpCH?=
 =?us-ascii?Q?OQ1+DT0+aFYS2WuMEw1BZU1kFu7KSNilA24eAZjoGsleQR0Fm9Ib/r8MEEiR?=
 =?us-ascii?Q?qIZ6vlYG1v8JSsWEq0sevmdS28edz8KmrLn3gS1Y42dgAbYhh8kx0KlV+zpy?=
 =?us-ascii?Q?kwI79wssuR/oWPTKEBT1leKatL4Ex6IBTOkiiJJKJmELNeaZwGZIQRjwJhWj?=
 =?us-ascii?Q?vt3ln9YT/0iGj3AO9Vmp2UOcJm7S/waCUMAZff3ryDZPduzqyymdnxCNqhc4?=
 =?us-ascii?Q?xtVpPZNiMmUzBWUdDE3z+Wme5IgO8cvGapx7Oc1QoyD7uXAukZiLl+XFgYrr?=
 =?us-ascii?Q?+75kObJ0X/zKmxA9vpl9FfcYEk+dj6HSlRs/+TtzV6HQoNSXp1K7rLLvbaTy?=
 =?us-ascii?Q?e5EDucrOVq4jAnqrTma45EP0WM0Q+2FGHz6euexSaR+xuffI762tGsLhrEwV?=
 =?us-ascii?Q?3XZtQfk8vWlZVBhyB4a+o8Cfknv5o08DRZu2pYCWTKdYTSfN6H9ukubIi6NE?=
 =?us-ascii?Q?bpb+3FiPmRHGf+IAy2l3TEVyJhKW+x3A+kfpkbJyaGgp3leqmnXg78lUZO2w?=
 =?us-ascii?Q?rdfavvfgfIs18iH70sf4W/fRZev+Ny3TVXwkXkkowUkgHq/IhHkSEKwo3DTy?=
 =?us-ascii?Q?ctIK8XUz7VUr7OTIxXJUtf59BuziAzYZNAfHs2iJNEpkPNL8PkgP/N7QHj6j?=
 =?us-ascii?Q?wFC+FC8/+pLKwHSjlgtmbHDQMZSi8oeLDEEFN6qpETFu+1MggAbPn6e6VH6n?=
 =?us-ascii?Q?tA=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49762bb9-b9c8-42f1-75a6-08dc6c4b729f
X-MS-Exchange-CrossTenant-AuthSource: BJXPR01MB0855.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2024 15:04:08.1769 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UQiS043DmCMz/Xw0lddaiViCP1g55/vZYAJvKMJlwYm/wI+NjIdoIs0RsInzMKaX49CfxFSbDDgyHiZHVtKGPM9aQjttz7hP/F7EtSCTj5k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BJXPR01MB0839
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
dr mode. So translate to generic PHY mode and call
generic_phy_set_mode().

Signed-off-by: Minda Chen <minda.chen@starfivetech.com>
---
 drivers/usb/cdns3/core.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/usb/cdns3/core.c b/drivers/usb/cdns3/core.c
index 12a741c6ea..c1a61471f9 100644
--- a/drivers/usb/cdns3/core.c
+++ b/drivers/usb/cdns3/core.c
@@ -321,6 +321,7 @@ static int cdns3_probe(struct cdns3 *cdns)
 {
 	struct udevice *dev = cdns->dev;
 	int ret;
+	int mode = PHY_MODE_INVALID;
 
 	cdns->xhci_regs = dev_remap_addr_name(dev, "xhci");
 	if (!cdns->xhci_regs)
@@ -372,6 +373,22 @@ static int cdns3_probe(struct cdns3 *cdns)
 	if (ret)
 		return ret;
 
+	if (cdns->dr_mode == USB_DR_MODE_HOST)
+		mode = PHY_MODE_USB_HOST;
+	else if (cdns->dr_mode == USB_DR_MODE_PERIPHERAL)
+		mode = PHY_MODE_USB_DEVICE;
+	else if (cdns->dr_mode == USB_DR_MODE_OTG)
+		mode = PHY_MODE_USB_OTG;
+
+	if (mode != PHY_MODE_INVALID) {
+		ret = generic_phy_set_mode(&cdns->usb2_phy, mode, 0);
+		if (ret)
+			return ret;
+		ret = generic_phy_set_mode(&cdns->usb3_phy, mode, 0);
+		if (ret)
+			return ret;
+	}
+
 	dev_dbg(dev, "Cadence USB3 core: probe succeed\n");
 
 	return 0;
-- 
2.17.1

