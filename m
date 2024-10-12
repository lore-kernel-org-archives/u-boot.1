Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CCA2D1A427
	for <u-boot@archiver.kernel.org>; Sat, 12 Oct 2024 03:13:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8CE4388A47;
	Sat, 12 Oct 2024 05:13:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id DC9B088A3C; Sat, 12 Oct 2024 05:13:54 +0200 (CEST)
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn
 (mail-sh0chn02on2072d.outbound.protection.partner.outlook.cn
 [IPv6:2406:e500:4420:2::72d])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A0B4788A47
 for <u-boot@lists.denx.de>; Sat, 12 Oct 2024 05:13:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=starfivetech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=minda.chen@starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WSE2nLmwES0BSg1BF49TOJIXFiaCipGGAd15TGylFA1vwmdRRKoVcxfS35wMk59/kzLPDsTdL6NUp6ePakLPfYqTWtLfrhacr17hWL9McRXdAKKaogvlBstD+VxKwe9EHrsZaNwV0cFEvOvmq1/inlPwer3sHZoyw5KzcHtragwhKZvegpZGJkz48vPuPwvIAeHjjHR5oJupsJ1WHgHspXeXLx47yZpjk37rOj9JBnA4V5CZNHzbup6wu4y72PM8FoE5rQ1ElrtmZ5dUW9FwxA2fg3EexS2fkVQVwGPWxVReG0DMkIi1HfH7B1879smyb1POAWwG12jE5ix2gR8ZgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gyl3NbSkB+9G8rmD5hvrNfIv5u86y1+SOdHIgUcBQwQ=;
 b=YxkogTTSMFh1lBrkIB0vUwvzTYcflynizlCj5p4KgYAjD9kgG1kPvz3TYuHT5izKl5G6JZjPFmaEZ1l72MZcm9SPMU1YSLgVaLTy1CctYTYsNLvow6VJJkisbV03oaoZCqPrU6mBLSIK4TI/aZ3/BmZRS7Ktlf0nN7IupxCyRMUa1DPbmqFgrLvwjmtCtskI80O7cxUqPPae/VdSY+dY5eSE483coLtnuT2SdAAVFvwxMwdNb4+x4dLUrScJeLh7Sa0HzzMduxAnSSl9XYjIWkGHpsl9szZx8OPwc26cQBX+wQ3LVtmZvDC2rC44KiypguuVflA+2cuLKcb43qSUBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from BJSPR01MB0850.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:1d::17) by BJSPR01MB0850.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:1d::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.18; Sat, 12 Oct
 2024 03:13:44 +0000
Received: from BJSPR01MB0850.CHNPR01.prod.partner.outlook.cn
 ([fe80::480b:a135:6e33:10ff]) by
 BJSPR01MB0850.CHNPR01.prod.partner.outlook.cn ([fe80::480b:a135:6e33:10ff%5])
 with mapi id 15.20.8048.017; Sat, 12 Oct 2024 03:13:43 +0000
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
Subject: [PATCH v5 1/8] usb: cdns3: Set USB PHY mode in cdns3_drd_update_mode()
Date: Sat, 12 Oct 2024 11:13:21 +0800
Message-Id: <20241012031328.4268-2-minda.chen@starfivetech.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20241012031328.4268-1-minda.chen@starfivetech.com>
References: <20241012031328.4268-1-minda.chen@starfivetech.com>
Content-Type: text/plain
X-ClientProxiedBy: SHXPR01CA0017.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:1b::26) To BJSPR01MB0850.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:1d::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BJSPR01MB0850:EE_
X-MS-Office365-Filtering-Correlation-Id: 67351af7-1020-44d6-8d43-08dcea6be111
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|41320700013|366016|1800799024|52116014|7416014|921020|38350700014;
X-Microsoft-Antispam-Message-Info: esQOyZQ1cnaca4Rby77NWSY0hnlDVlqEWizrKoOoEKNF9Rgw89GuA4zx/NgeSX+38PWFoXrkyOelgZJjR6HOeNpSn728yILOBhQIFIjl+FV2BK6ekanaBH2JY5VMvC7lAXICV8QOW4b88edAhIOtGRSBXOBKbgdohk0LT0Q1WktkWFb7ezkVc1xqgxeECC14JZpcxScDtAxUYQtXze4Rsa7EXHPPyhr48BS3Mff4gv7/vfJb+F7F/vlTw85WAek/ytqZp5e7lvJjA4m+4UoK68PoJYVZMLgp5GZUodewjWp+Wclc0nOG8p7zVtzgyqqsnySTGxEBJFcr9mzh94w1QhjYyln+RLrC3dpSQGHDfnaQZeafHXS3P74qse/qDt82FJccZg4CHKPlUR1IfjkzHZ2pGpY3XGRa+SFiMOnS7ddEIc16HofHUoAOiT/y3ynNAHJy1WalQWbXdlywoQtVQUuCgpSPK9eTab+Ily71XTAI1We0uJmuIM7ALyDY5aN6be+24xNZ/eXfGs8ig4nv3wmi05XI95vR4IP7QOXJTw3yqe1gx0nIc7FZobINmQk+FvKFZh1vg2ToNpOIC6O8S2ZlVqrh0FGd9Y6TYH1oeyMsrfatX4s+uRlGSaqGALGjty0IZ+8cG9FsnniYA3XjFw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BJSPR01MB0850.CHNPR01.prod.partner.outlook.cn; PTR:;
 CAT:NONE;
 SFS:(13230040)(41320700013)(366016)(1800799024)(52116014)(7416014)(921020)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qxru6IdwWmsOXeGPcTFP/zW12LHX29Dx72HsHyxBHh+WsjG+Fw8Ed+Ng2R4J?=
 =?us-ascii?Q?T/3j3HSsNZz187TaBG131i0jEIpXRgVv2zMKOU66mGK83GqrofYHdIoArEOW?=
 =?us-ascii?Q?wVFttFjPKUrcACF3yAbzrv8uUS5iNQKO/EuNAwhOcl4xekQJg3bXb2la1hxQ?=
 =?us-ascii?Q?jBVXyDs5qItfQxRhmHzxYrEeJzAPiZ75DEbCVs0RgneZVttcVXWTN3c3HiIX?=
 =?us-ascii?Q?sjQOrbVuMgHqFL04QlHPhYbrn5b+NVbwKiIIKyik1nyYqHOb5gd9ZOTi1qz3?=
 =?us-ascii?Q?2VYodTrqEM3Pzf0dnP4CJTj6mwovmlRj8crjvaIxPKGdHnTZINTZcDUEgpnk?=
 =?us-ascii?Q?fNP5D4VQ2DtmncBwFI7RmZv2RA71HowZUPoQSYAJX4VLlMzOUT46grYYHd1J?=
 =?us-ascii?Q?0KWpT4GTJuBq6cyym9Cy8q0m7zHP/EuBsawUjnNen5zoQRie3e9chl++sD2X?=
 =?us-ascii?Q?1w+s+ZVGs9kyZqxSB69EfDD+jimnsZlwG54yjYo38G+/4CUcYUDtLi2kxp/N?=
 =?us-ascii?Q?Y1nzjOlh9z5jJ5gzWJVijVrF0c+8qrSohmXCpv3SRupncfNmQGBeE4s+KnqD?=
 =?us-ascii?Q?EHMCxn/AedXSMSxYr0HmMhkJYt2a8KYeGQtz6gd281fLyhwfGqxtpeYkyAdF?=
 =?us-ascii?Q?6/8GYPCwL1F321bVekqv/GJxeziqvezY/DP1ArD1mm/fJPHcs35BtJGVU7Lb?=
 =?us-ascii?Q?IZYUcw45D6V7JHWlbNKiQQ8h8LnJGMHd+8my02IIbM8Qu4aUg15+ggpC7h6x?=
 =?us-ascii?Q?9qW7FBj+YXrLdtNz/dX3Gw++dLYXK4BqHXic7lhb6AADUbDjeR9KNqfRLIvu?=
 =?us-ascii?Q?qobCVODsk83TN8CMmOQIY0QrtU9PVfnZjwUCfjvmmF3niympOFFCUsQqGreZ?=
 =?us-ascii?Q?jRixrcEFWrj1oKJ71RASUhgv1b0TWdkOlLtrMFhhoUwY4riEN0m55cXhoYwo?=
 =?us-ascii?Q?vTixy5+U2YUutLYK2N3a2poNunpgy0Cptz101WaBOvwuEXOTgotgUk+NmeRO?=
 =?us-ascii?Q?dhQuL8J9lTBAY4fip7owxFcWv+vSJw6BHVhNp+TiruWpHDPpi0RzvV8GB6bS?=
 =?us-ascii?Q?+9rFDu+HRcttKQK2/Jgs+1tjm+V+ZfTXIkdPmmCGcE6j7ZZk+dK8WyZQubxS?=
 =?us-ascii?Q?2i+XlUXYHlPdx+Bs4UAVNa00OJZyqzrs52wjpLmE6sai5oo+S1fSDoRFwXp7?=
 =?us-ascii?Q?5fsox9Z7hAp1INAZg1EDPPmhb7mJnI4yipkh960mWRVFAylu3cqTXHrr2+xE?=
 =?us-ascii?Q?YTENRe1R9FE1Q7zc7ZWjrJyivXyE9l6m2gxSd6LMaRuy2qQ0zZ9vqASUirYR?=
 =?us-ascii?Q?2kzwk2dv2/fUoV2i8uyq97u3p7bKlaiT6Ks09P0tDmFI7+jdi10uNBNyiEJl?=
 =?us-ascii?Q?rkQuvpZUuR9gpG8ajAJlosAFejuterhIhI/V5OSHanIep0xwaPNDKsvFF/1o?=
 =?us-ascii?Q?Zo618jeSjO4vN51H7eVEVW0woGCb6YXSAV4gWEwn8PRuS19tp1jCmZybDIPd?=
 =?us-ascii?Q?z2p3aPOfKrDk97abLc1/GM+ZPt4MTIa576zNfQGyKjHml1TEb9BfjO2ZnLid?=
 =?us-ascii?Q?mnO0F/RjDpMEAytgYX1IVqIq3nLJ/x9hPWYNvyQLBTkWwAbfCL35N2AB/udA?=
 =?us-ascii?Q?/g=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67351af7-1020-44d6-8d43-08dcea6be111
X-MS-Exchange-CrossTenant-AuthSource: BJSPR01MB0850.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2024 03:13:43.9170 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gIWcyocUWi/YJgQ3gStbTdvQhOSWbel9AtKbzrPUNCadj4a2Nr674fMhgLTfIUZq8e5Pgq7uhFDxUuQkoldEQhqn5lzeFGZh0I2yo+gSPZA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BJSPR01MB0850
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

