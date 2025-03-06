Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14EA6C282D1
	for <u-boot@archiver.kernel.org>; Thu,  6 Mar 2025 06:21:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 98BAB80BAA;
	Thu,  6 Mar 2025 07:20:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id BA78D81298; Thu,  6 Mar 2025 07:20:53 +0100 (CET)
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn
 (mail-bjschn02on20731.outbound.protection.partner.outlook.cn
 [IPv6:2406:e500:4440:2::731])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A9C5D808A2
 for <u-boot@lists.denx.de>; Thu,  6 Mar 2025 07:20:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=starfivetech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=minda.chen@starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ocJBRsZyNzHWZIQz/EWwL3CyeQFVjlcDmaKt1k2N73AqaWlywgMzxnVu/H2/ZS+V1HrNybxPdy90BIv6zIITX9mdI8x6lDfkB7E8Ffmt+CsK4wV+jCUne2X2sbch9LtqmtI7MPUTn40Ux67TwRuucVbBCvXY0eFth/bAF4g1vEGQ1uMkPcBrqAzNi/48kBOz7wfohvAhkDD0l8jMoavK5MscX7N4NqzLwg8/x5OFV2Xfx5GBCCbVOj3t5BaMdoYfUEeQcDuJCjVjPPtnoIzTEu+yk0dXYCd9xORQi52bW5nvODqv6XTvPclqit3W/Iz0/tdTGBUy8vPbUspGmw1gUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gyl3NbSkB+9G8rmD5hvrNfIv5u86y1+SOdHIgUcBQwQ=;
 b=OLqPFpQ/ZC0uctW2HPqgV6vxmkHoymDqATrbMHGGdhFS/QG88xcyS/OjrLTYEna+zgWVO1WXSS/IKCX3QUY1l2FkwGisCEUl972+heZvfRTzhjRLW9P9zIGq3fEeSArYWKExHJfHfN506D0LcevhJ90sVWBZw/K9OF1MAWfVlyx3MrUzlhrnLMToH66CwCIJ3ZOeHXg3/MwhLc1IJsnM38FjtIbi9tNjw6tOzmayui1+iFtAIRiVLU79GPt2dnPPZrV/uDNUBRGXfmXt6PjxhlK9Pnkbx513keq6zSKnJPA/Y470lPGX0vucOOQV2iAu1TX4N4t/CVIakSQXx2mMwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::15) by SHXPR01MB0496.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:1f::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.30; Thu, 6 Mar
 2025 06:20:42 +0000
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 ([fe80::3f35:8db2:7fdf:9ffb]) by
 SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn ([fe80::3f35:8db2:7fdf:9ffb%4])
 with mapi id 15.20.8377.007; Thu, 6 Mar 2025 06:20:42 +0000
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
Subject: [PATCH v7 1/8] usb: cdns3: Set USB PHY mode in cdns3_drd_update_mode()
Date: Thu,  6 Mar 2025 14:20:25 +0800
Message-Id: <20250306062032.50314-2-minda.chen@starfivetech.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250306062032.50314-1-minda.chen@starfivetech.com>
References: <20250306062032.50314-1-minda.chen@starfivetech.com>
Content-Type: text/plain
X-ClientProxiedBy: BJSPR01CA0023.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:c::35) To SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SHXPR01MB0863:EE_|SHXPR01MB0496:EE_
X-MS-Office365-Filtering-Correlation-Id: ef57997a-861f-4a18-19ea-08dd5c7705c8
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|41320700013|7416014|52116014|38350700014|7053199007|921020;
X-Microsoft-Antispam-Message-Info: mP2eHOm7Z9kr/+hNEv+ldgc93BfOYEcy7wh4sHC5eHSZ0JTWJ+Gl9SZ0x1eXMczGBuT4CgQfXFANH2KNINZmxnu9djmBjSy5MlSpTUA0fPN8uU7xzPNa3RJdH/fpqb7pfIXTorUGxGewMuDSJnnEA7+cNR1D3khrZ9V8gaw1Ivky+E65kV8qKqXdBBYIF0dKO/kFtyGVSPJwgaoudN0ohD0xhHXeo1WF2lR9G5/gzIkHl7q5jlCwibm9HOMGGi9CnwWChcYEob8Mx0NswzMBAezIVNRmqNDdLLFcCZ6a1JdzTtbLcKR13FnOlsnKiy8KM2WWpQge/qOrdDStG3kh5KfM5HNnjZgJJVrObL0SaQQFN+p3KBRdDnmM7wCiWcCnbbGtLMgqRjdQsIgWJypCU7xEL46rTc2FGeHPj3YNiV102X1Lqm5+ih3/TQuf05677CyZd1vZtojGEPtuDnrDnzq33V/w4Pb8gQ5rph4uv+Lo6PoRgDZyj/mydlal5Bh2s684zgWfPDkpmlIniHjrZAM3aa8YytLw0oaQMj2KrEEmxPnvA3MkkflKid7IwBlsD3pCm+SQNl8flSyoQ77lAaTWeluH1COUEl/7siJbA/A=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn; PTR:;
 CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(41320700013)(7416014)(52116014)(38350700014)(7053199007)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?o1y0oMBNTXdHSBr6GfRSxqNM/F1e/sEvTbbJBvj69Mwee/uhdIPxHwxt8zqE?=
 =?us-ascii?Q?+Rp6a1WHZs3zAG1Lm48e7i4fWJhlXEnwPTqGjZMvKZWN+fnlmM3KyJO/Obfi?=
 =?us-ascii?Q?NsQnDgB3TMWAaEDiot+Lbhx3CZI6YBhoVlficucUfgBH2Fvb+uXGIzlX22de?=
 =?us-ascii?Q?/tPUtxjzgerhCF8ZYBsrCycVI+bRLUzwXX/Izi1opmwBkOo16AfeaeGwBSsE?=
 =?us-ascii?Q?GN/E2BURUEi1x6/krWn5wP0W7GydAOPbP8Qo3le+pJQYaqg2fLurXe1hZxce?=
 =?us-ascii?Q?TwZvwZWVuZ5H4cCbZanAQ6FrpWFjRTAWUBtbAB2LmoiIRBZB5P804ael8fGK?=
 =?us-ascii?Q?rPU7uHq2uun+V3yDBidRF2ISXqaObKP3QzkdimTm2OMNl0iQ+t9v5PFIZDi+?=
 =?us-ascii?Q?sVJg2Uw7Gj1NrB2JH3DON1mqPQ7zblMBaVTRUK7uUA+npxlmGJJRIrMHK0C4?=
 =?us-ascii?Q?STom3YCJ2IQpkeC4wUrXXY4CMTq0gp4nshJRYeRTLFNNX65oA+iVrcsSfISv?=
 =?us-ascii?Q?yZn5GL/gU/t/EZq/L0fSyBdwzGyR1tI7xm/dRLKgTwGyMj0eL8nLy8hLHdad?=
 =?us-ascii?Q?Fvp51lq5xNNAb994Zozpr2lQY/rG6ZuJ7aB8q07uWA6MmVm+RiMFeq5vKFHk?=
 =?us-ascii?Q?uA3x6wmLrEyXqJJeCyEPrEKyBgTdE4ZEsi9Wii+TIQJ+uXM9k7Bk4lpzD2TU?=
 =?us-ascii?Q?NMVHfCVEhfTrd75M8ww2fqt0YJb0WoiO9PlxMXTFu4H7mMIWZm+AGgVKakhW?=
 =?us-ascii?Q?9o1D7YSzFdIhyK3VM3isnAATiqLNlaA+4myQ1cPzfmEfV+JlFrXGqHDo+R06?=
 =?us-ascii?Q?Rtt57JwcFUcfytptn69AvmY80T5wtGlPwET4gQxv6PrXe0Sxb774MXvwSqCH?=
 =?us-ascii?Q?loBqADoYYpeVnxRA4ZgoVHBT3Bn0cgwGRKUWbUC0ftD2i4lvfvJ3QS8PQd9b?=
 =?us-ascii?Q?jadcqGhKm/kBcdAiA3rBBv6e0NuTXlhlkEGQXrqAeZxmmHIN0wkz4q0Ou9fZ?=
 =?us-ascii?Q?1/LpdQVG0ZyBj+3V+Gzf8ISPPueugNo6+rQnYxT0uScwvs+b1rAnIp309hrb?=
 =?us-ascii?Q?t+w5PRDQDvxwsbUY1sT0tIBsDcwECd+aFd7Wp/4IlffvpHB3mPCDAfbiPO9I?=
 =?us-ascii?Q?JP80m0gaPujFlWQgI07WLKnq/u1HOyKKAB5Fmv25y7EIkn+hLEGJhu+VvAGA?=
 =?us-ascii?Q?Jn+lIGpYTk/deRvxMapCSRLMPdaq34xdSlR7sNQCwzaDwXe3z5BbnFjYSqlw?=
 =?us-ascii?Q?7+uyEbrHl1s8X5NI4gG5Q6HOPXVt/D2OsBPpAMfRG1fDIhFrvaMt0gAQ8LXS?=
 =?us-ascii?Q?bZR+7qXqWw7WuVJbdHThr5DoWdF5NjMb3hO4eLbXdp2QkECm5rfHX/wzOXPN?=
 =?us-ascii?Q?z32Y9nc3Ggc60G0uyhwOGa1c6WgWrgiVPBmyaav5vxIXEEJX28oVFvdjw1Nk?=
 =?us-ascii?Q?9pCS+gyIrWePy3Z7JLd2z97AXOhaIk8wK5W72FgGYyZDRA4WoR21BVMqR622?=
 =?us-ascii?Q?YpSLXTVsWkFOnP7u0OJyau3tS/6Dyq7tMLkz5EAb5lAdElEU1P8U5gGxkEN9?=
 =?us-ascii?Q?WZOMch26CtTZ5p78eG0T9y6N1Pdl7EvXWLFaKgSDKv2LqliLrYucCYyasyOl?=
 =?us-ascii?Q?CA=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef57997a-861f-4a18-19ea-08dd5c7705c8
X-MS-Exchange-CrossTenant-AuthSource: SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2025 06:20:42.5284 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z8t5N179nG1mVcgkw0fDIlFmDNWeSNuskJZgufMj5zyhzEOMk2lJlcJOsoigfC45ct/7C8JwupxmwqHfq/AlCTN0MaMpf5dBfR/3WxUMFzs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SHXPR01MB0496
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

