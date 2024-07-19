Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B44E5C3DA61
	for <u-boot@archiver.kernel.org>; Fri, 19 Jul 2024 01:38:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2261788B69;
	Fri, 19 Jul 2024 03:38:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id C618988B3D; Fri, 19 Jul 2024 03:38:41 +0200 (CEST)
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn
 (mail-bjschn02on20709.outbound.protection.partner.outlook.cn
 [IPv6:2406:e500:4440:2::709])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 06AE288B3F
 for <u-boot@lists.denx.de>; Fri, 19 Jul 2024 03:38:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=starfivetech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=minda.chen@starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GYRXe3e/9pF8DWjzRg6DoeuijVFJ8MnkvUyZpodLwXg4TZHO7aZGK9nKD2yuuMTIkhUme/4NPPSyfxhJ0+M1YwHunJKy3KApf1fVTLBc39wDvXQvkN1FtPOLF+tkjiqgKiHIM6ZcwCsD6IxtxvV+B5wdsnMoQMgGIXYtccBwyrCOJ6ZDsZFSnwamIxS05CoYnEX/ngtzAGQdiKuo1aOtpPQM3XQ1k4EgUWrP2K0zdWkQrk1Hgk3gDy3EORKSr7dXEqc8d0MUoA9o/edCI3SV/fp1l2DINVneuTQlpomLchy1j8HQQO7itvr9voFNGZ6ijvxYUBmE0Xyusdc9F2pBcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LDZ4j+h7uR2b5Nnj3PrAHWen7gzNZDHPmpjKp5cAKdQ=;
 b=M4gJ0AXe1AbBEKF+WHbS/Yg8IoHvvv543ONoxm4DAU1xuVL34jLUcN76KUiAAwm4+pudoF02HyPrHE3zUngXY+6CpCWqF5AjXFEiPkDBD8eIRtxuHmOSJm+jsCOSwDn7tiElcIqM0LRSnJrdMn6Om65JVNLlgvdp13zkdv64pNB2mSrXeIcvfSR/pYzaJPJKbQNU3YkxaX3ro0nwY8JLphspQp4UvdlgaCSEC4TufAXUHAYD2iuOx7C/S/FMSuH5JU/6ssKxlqYSCLvtKUVfcxdqzb6VKr+6RXitURrU0xJb+lSq+wyB/+6WdrvU3vacjU+GVSswoCXuG6qVQWKh8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::15) by SHXPR01MB0623.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:1d::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.46; Fri, 19 Jul
 2024 01:38:33 +0000
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 ([fe80::bd9e:fb57:ebf7:9d71]) by
 SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn ([fe80::bd9e:fb57:ebf7:9d71%4])
 with mapi id 15.20.7741.046; Fri, 19 Jul 2024 01:38:33 +0000
From: Minda Chen <minda.chen@starfivetech.com>
To: Marek Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>,
 Roger Quadros <rogerq@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Alexey Romanov <avromanov@salutedevices.com>,
 Sumit Garg <sumit.garg@linaro.org>, Mark Kettenis <kettenis@openbsd.org>,
 Nishanth Menon <nm@ti.com>, Rick Chen <rick@andestech.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>
Cc: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Simon Glass <sjg@chromium.org>, E Shattow <lucent@gmail.com>,
 Minda Chen <minda.chen@starfivetech.com>
Subject: [PATCH v3 1/8] usb: cdns3: Set USB PHY mode in cdns3_drd_update_mode()
Date: Fri, 19 Jul 2024 09:38:15 +0800
Message-Id: <20240719013822.101374-2-minda.chen@starfivetech.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240719013822.101374-1-minda.chen@starfivetech.com>
References: <20240719013822.101374-1-minda.chen@starfivetech.com>
Content-Type: text/plain
X-ClientProxiedBy: NT0PR01CA0003.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510::15) To SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SHXPR01MB0863:EE_|SHXPR01MB0623:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ed4dff0-cccb-4c51-2686-08dca7938020
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|1800799024|52116014|41320700013|366016|38350700014|921020;
X-Microsoft-Antispam-Message-Info: 0c1DYGJl9Ud08GUTfdq8nEUWaNGwDslurXRtn6UepuhsgLdXRQmmrEkMwAEY08AdWmX4/AnRCgcF8TdgcOqUpofYEQwJ/phUHJ6ns6Z3pWYwC47gJdDJO4HUHhBNorySRik8AXljxH9AbNueyTVwUYt+NjbXgSCfAyvELUONGoO2fYI7GV/JhhXu9q9aTdhS/o1mgt2MvuYaoNPdWv5smSJqtliIoePokCVTti2N+fEU+/EfWw3D9DVABFWpvugn+jNPxrOCODhTEiRYjU6YC25AaqWmaEyGpCfG7XKmoI3X7inKJIT0nphVjRSO+0t6C2joVxF+7drX/YzERcKT5mzmiDFpu4W3fNsa+gpb42TxboN+thGpU5UZIqXXlbp400P0IRSSXP6MQofRThagcoIwDmnEVu/pQCdH54CYu0TE1R92GRp0e2MqHFPauWLCi5o9FWLhFDAuyaE5zjHwOgr3zvbj5ayzU6e3kr7bhPoa7YPoBHRseEi3SUJyU/UuzWv1hUHRkl7alj6YBXJaRaUagUvu5HhKTLe4PgRGoaxrMh7Wr45unV+6f9yVNax41KWbgxx626df0uiCPvcRQ6eqPgaPumhvs+Mim2OXeIbfCFXI5Igxu90FKriS3otXT1Ll7UOMq+KGAqlJqASsJQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn; PTR:;
 CAT:NONE;
 SFS:(13230040)(7416014)(1800799024)(52116014)(41320700013)(366016)(38350700014)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?WRPCKniNnaTvp8VqCsP1L7tmz2dSTFasMXbAvOz4nRXZkEbw1PYmoIrZnms+?=
 =?us-ascii?Q?D3QINDErnrpumm5qJfORqQSnUJX/sCIXvTL4qucpyTETquyzQY4v7tMaDuYz?=
 =?us-ascii?Q?TeOWnwpJnj1gOoWSR7wO6+ppBFXfZRmcCZif04z+ULkAmBfh/qr3MQaehB2c?=
 =?us-ascii?Q?hL0WsIuwJ4e7ZbQC7/F+xoMkl9QqJMjaVE9EQaVTOvOuI1UvCT315Fsxgjjz?=
 =?us-ascii?Q?qrrhoQXktIMyiVMqnp2K8T+dwCrT9KYsun0mKn7SqkBWE+GBt+gcdtNbn+9C?=
 =?us-ascii?Q?LWAE55S3e8OaqLYxI5lzSfUHOjCK87KGi8AsRzaIDDAZe7kiNEwEwNqL9Y1+?=
 =?us-ascii?Q?QC4vZyWtj0dPYOg0h57zdjPq3WrgDfA1vG8U2K9VnO2Qc/b0yMlp7n8mGGfQ?=
 =?us-ascii?Q?h789aHM2YR9tnAbz569LehCnBuR4PBPei8q0DqLHZShvBeoGTcvdzW6nQl0l?=
 =?us-ascii?Q?4TNpFg0xue99EHN1o/MglxavfRvxUj0KyM6ucpjx9KeTx9xKmr/+wnQj+Xea?=
 =?us-ascii?Q?ycUHo4tx2xuQLe75C0nredxafSFmr+MKLkJ/lS/0VB+d+R/qJ0RMGnm746M2?=
 =?us-ascii?Q?l8FboWYcWY91l+rKav+ZLTRRME+/CIRwIcMXsJzNsp2NPI7Jr8KA7gWFrZds?=
 =?us-ascii?Q?9aL3nTwfwHfnkLLrwlmFyeYy9JaQfDSHGWd6OOIxs1FhFkCi57qW48Hep+tw?=
 =?us-ascii?Q?2HvLqNv5/GLM6KW46vIrN3izUN6YTFeSFliEl7W2AgjmKVl8x8WMIySj0xf5?=
 =?us-ascii?Q?1B6a8g4Jd5Iostx0KeAmYqJcy2pL5pkB8VbSWOEVV2ye56+WS7Tm/YVlCo8c?=
 =?us-ascii?Q?NCkyK62Ac0Tyn922vuLUfUHWEYczH6prZBfXuqRDyg1J2ODbXozKjbFKUd+l?=
 =?us-ascii?Q?4zm1P53co3S6+wEUhoJStrETV2z/lR+78RDoTN1NlZvTDq3vSyyRvAx3eSWb?=
 =?us-ascii?Q?nmdhWPyRX7/jHp/DDmcMAVjXcAPPdYM1ywavyRR0WnOSarnVvutMoh6mSg7X?=
 =?us-ascii?Q?7dfTsIRwU/Yoj3lt8z00s3ZaELscyJGvFsbMLaecNxZN+wwuwdxqsh+yT1N8?=
 =?us-ascii?Q?c1GMIq2YDf3oJy3oTbdMrsR17neO1sfZSEvgHCQ96kdTOlAc78Ik8doEXcxe?=
 =?us-ascii?Q?bGPT7h1wD6YACJW5BsOc5941+nIc/OCF5hQnO0uXA8ymu/ho2K/OXRLQJtRx?=
 =?us-ascii?Q?UQuGKw01it69YTmRPg3k7j/uf1zeHaFzPAqUqJxVBUgoaqzztSXSfxcb2Bja?=
 =?us-ascii?Q?jvYVU+CbkVt+nlFy3WFyFT3lwLf2Evg0qzsBqRb7o98E1tybLhi9lFl7739O?=
 =?us-ascii?Q?+kQNfbLZQ33FZItn/ZdQEsowjy5vhA6gLqDTQRKiCDiRv7VexT0KuvjwLuMc?=
 =?us-ascii?Q?5aHQ1vsv6rsgf+kHV3KbAPKQOTD4pDXwRab1tX6/cW0jMh2CcUTF2INO59uj?=
 =?us-ascii?Q?9aYwF5IHkTO+hC/L6IFlJ9AhtAQijgyvw0d98EAa8HwfFqNs5a7qPahtnc6K?=
 =?us-ascii?Q?4sVBWsnHwpDnACe34blC8OC4qjfzXf2hVv5jqq519JetvFfP1j00tBsgNXdx?=
 =?us-ascii?Q?Mdw+UlVIXKWTB8jpw5L+gqOkJHh4uTPePZtPmTQTkeqhtSVxvuvgPgBHPngS?=
 =?us-ascii?Q?Yg=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ed4dff0-cccb-4c51-2686-08dca7938020
X-MS-Exchange-CrossTenant-AuthSource: SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2024 01:38:33.2405 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WjpBI5FLMyuh2yYOZJvOR/vuajt+aOWgMmkdgsCU+14aEkMRutpU3Mb91lk/Cfq5Dai8KpNPf7bvb8GbSYWOGqsze8Pri8koalAhihJBEh8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SHXPR01MB0623
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
---
 drivers/usb/cdns3/drd.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/usb/cdns3/drd.c b/drivers/usb/cdns3/drd.c
index 47874fec29..cbb1334234 100644
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

