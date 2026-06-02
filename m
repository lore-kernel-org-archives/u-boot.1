Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1525BCD6E57
	for <u-boot@archiver.kernel.org>; Tue,  2 Jun 2026 10:05:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3ADF58491C;
	Tue,  2 Jun 2026 12:05:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="ioMnO5fQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7AF5A84928; Tue,  2 Jun 2026 12:05:00 +0200 (CEST)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9CBD584932
 for <u-boot@lists.denx.de>; Tue,  2 Jun 2026 12:04:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Nn5Co+hiFHuj9mrwpUACnxn/e0sU5f8ZS4oxB/nawFiM+LspjquuHEmoxEtiTk5cHeVjMBWvK3oDM2uXO70wWG03itLcRu+9xvW9HtssXX5Vb+ULt/OWrJmVN90MwpI4mdPukicmBnETNzMDytm2f7Fu6Eo1G4fOmiNfSQQFKD60yu+9GBpe/vx89vC9Eokc3ekiQwSrzlkF9K2e5xRoj3ZJ7O4W9Pmq8CvfwHNR1mQfIU3jPoGH3RjhxULrQGELIFZ+3CualakPk6OkdufTATftbIxE5pdcG91ruPg3KysgWot2qf1EIVSgMyhLDDO0JGjFrqrSBT5dWhyvJXqDug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RZehm4Lc5V5wqh3gc5MRdtHQe+exf5c7+T0iF5QVC6Q=;
 b=P4cL9MGav7hAtFHYtPAjJKWEb8d3hCQYorTA88kN9Ya4PkpHPuYwINdAe1KaenJ3Y55u0rKG7RXwVH0wdnF90abdj8aSJVFPEoTPyr26R6pM+qPt0Zz9xSf+aMx5eZQxeDjU/Vrk0xLQ8x0/87celdJ1Uidt1KPMX7Iu++DC1LqaTVwrLm+Ro3bGZOL+8giIXp7WT/hIBdA+/XKQfDgKQRhIv8rTWQ8Pc8NA0Wxwbk29c/DWY4fpIANUEUHwN2YE27ST9yAkWEda6YqqoZp6xenlrqH9VqqHv+RDmbJU0iPacor0V5GcM3sKG2ctJ7DgF9KF94Zz4PVM7pyC8ER43g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RZehm4Lc5V5wqh3gc5MRdtHQe+exf5c7+T0iF5QVC6Q=;
 b=ioMnO5fQTP82aktL4USkjPESOpPMpYmK/ev3Hfda3qwGnGIrKPOC2C014wxG3gPFmD0i1sSjMT37ARms3emjVIRKWD+1Pc66/IXUnKwtfuUsQ6NxksPBKn0lysFVEgPP5tpkveRdMvatUo9lL+mMZap1XzfPeaOT9mI2uZzF4pS4uXBEu1O24z0Bp6eJyy7CEnH18/0skJXv6Na5yQ2V1XCgEu2xO46VapXP10cKkxxIB9UpsXg48s0NpTGndLzmwuNst8auCsxFKpzVcn+us2Jy/kB/9jvWiWeyAQN4SNYzb00eZuG0lvMy4eOLwtBLr/QIkguY4BnvQ9WhfNuAyg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MRWPR04MB12330.eurprd04.prod.outlook.com (2603:10a6:501:7f::23)
 by VI1PR04MB7118.eurprd04.prod.outlook.com (2603:10a6:800:127::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.16; Tue, 2 Jun 2026
 10:04:53 +0000
Received: from MRWPR04MB12330.eurprd04.prod.outlook.com
 ([fe80::ca22:f8c8:6aca:7889]) by MRWPR04MB12330.eurprd04.prod.outlook.com
 ([fe80::ca22:f8c8:6aca:7889%6]) with mapi id 15.21.0071.011; Tue, 2 Jun 2026
 10:04:53 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Tue, 02 Jun 2026 19:21:40 +0800
Subject: [PATCH v2 1/6] usb: musb-new: Drop unused variables
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260602-devfdt-usb-v2-1-a587ab36b906@nxp.com>
References: <20260602-devfdt-usb-v2-0-a587ab36b906@nxp.com>
In-Reply-To: <20260602-devfdt-usb-v2-0-a587ab36b906@nxp.com>
To: u-boot@lists.denx.de, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Marek Vasut <marek.vasut@mailbox.org>, Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>, 
 Kory Maincent <kory.maincent@bootlin.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 David Lechner <dlechner@baylibre.com>, 
 Julien Stephan <jstephan@baylibre.com>, Bin Meng <bmeng.cn@gmail.com>, 
 Peter Robinson <pbrobinson@gmail.com>, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.3
X-ClientProxiedBy: SI2PR02CA0046.apcprd02.prod.outlook.com
 (2603:1096:4:196::15) To MRWPR04MB12330.eurprd04.prod.outlook.com
 (2603:10a6:501:7f::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MRWPR04MB12330:EE_|VI1PR04MB7118:EE_
X-MS-Office365-Filtering-Correlation-Id: 6370d757-4272-47fb-10e0-08dec08e63fc
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|19092799006|52116014|376014|7416014|1800799024|38350700014|18002099003|22082099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: M7upL4oFUSYCBsNSwosc9/dkggPpCYQ2ehEa+nMVrASy62Jo/I1R3xII6G9FUxEr5Xar6/m1jXOivnHPJM6wFd2SYhq956F3QFwoKZl0CGHIlckA0k39QtrlxjFJrrtc3HlSAFr9+iTxB2wKRhGgmJADPJK53j7Vra/8M5cTrB59mFvPHFfneRUKb3GXBWV++VBIc01xS0cVROgdyVMttAHD0Pag+KhRqOafF5D1bv1pw+IZohyK7P9qV+EIG1ZU4fq2N55G2CwMHRyf3FNbMJu5QtbdVsWqen1akUFnwGffoe1nEjHwSqnLHAsT/89OVAIZZmo3e78K/K3ddz2kr9f1z0X97oD2EEbFV0CUc/y3XGB8sf+yJ9QC7CwMpafSu/pDu722zexwKW/tTpm9tjzs9wCJwO7sSMq13rAuNXxQeVgTHMycehp5dLPvmw83mzVHitJRO+gS3IpUePvgdqB+gNreIyfDzT0ZKR4AXfUI2PI5z3dLvK3L2D1lD2dblj/o01ezeANMGsbplTDs0nAs5AaQqVWM9ZVwS9P0sKgWnhvNSqGxCbG1HRhtAOdJHcnKLD4DvjPoNFZtc/JebH1o75engK9PAOSMRObiZLwRTx8oGNlWw9LhS5a4eSo35XDxule+P2BiOpgK1U8nPsOC8gEPd0SlMa5WT91UkefDEwSzG+GkdJdGnS4UddHnMFCRGyTcEu359gs6OaOqCU3QSnabjOU+Cc0ldsffDoBlQelICqxJbATxiaC3a8Tm
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MRWPR04MB12330.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(19092799006)(52116014)(376014)(7416014)(1800799024)(38350700014)(18002099003)(22082099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K250blg0T28wRTNaYVAwd0VBLzJhOXd6Q1JJc3lVcVJzdTJwSHZ0NndFUDFP?=
 =?utf-8?B?ajByajZQWERRWndzdFMzdzBwSkEyaE03ajVxdTdId0FwRFF6NHRhVGFtRVNC?=
 =?utf-8?B?SmF0cWlYOGVCNmF0VEFyWC8vdUgrc244MVJ5SUgveTNZOTdyVTkzK3RMSjZP?=
 =?utf-8?B?c0JFdm1taDR4UXp3ckU2Tk9NMVNvVkd0NlJaeUM3bXA1NVoxMFVvZlpPRDF0?=
 =?utf-8?B?b0NFbU5yMzZYbCtkVVQ4ZFBuRUJQWHlMb0pOOWVjbC9tNFNpS3VteGRCOGts?=
 =?utf-8?B?cmNNbzlhb3JCZWpibXU4YXdNc1Q1R24xdXhMUlFsRDQ4NWtrQ1cxczlxMnBz?=
 =?utf-8?B?T05RcmhkMDMxaHBPOUVaTWZYOFJPSmd1OFJKblh5alZubWNtbWxKM3hxNHRG?=
 =?utf-8?B?azBRQjlEREFGemVsS2p6ZmRQYmNvYUNJVHo2NFhSVXlBVlVRM3puZmZjOS9K?=
 =?utf-8?B?dEl4eTVDYmpMcTAyeU9rMkxlZWExUlJTOWduZ3EwenlQYlZSWGJzT041Q1lm?=
 =?utf-8?B?THlZZFB3cjZXWDdkUXdxZFQ4Q1p2VlBwaUJ1T3lMV21jUE1OK2lnK240N2xt?=
 =?utf-8?B?QlRNeVM2dDJrcUJPeHhOZWtVUTZBMzQ5ZU1jWitMOGl5YTJUNWdNT2szTWhi?=
 =?utf-8?B?QzQ0SWJtZ0dxNTFzemYrS0dRSW5BQkZGZG9TOTVyN2hRWENjSXZkRVlnTzNm?=
 =?utf-8?B?Q3QzeE9vM0xlYXRybmk1OG1PWGVSbXlBckkzejA0VUs3UVFXSzVNV0NUd1F4?=
 =?utf-8?B?U2hVTzkrVTArOWF4Y0pZbDdROGd5enBUMWF2ZENrbmNPbE5MbmZJU1NqQUJh?=
 =?utf-8?B?Z1BsRWZSNVlLV1hyL1VQaUxvOTZqTWxHbjNJME9PeHJQeDJIeVJVUlNlb3hE?=
 =?utf-8?B?UmZWK0dlU1ZHaXlOYXVWQ3E5a01iaHpzUDhIdFJnTkJqZkozcG1ya2VOUnB4?=
 =?utf-8?B?QVNTOC9qOTE3MmxlL3pLT0tSWGFGeEJOZGd0bTFzNnRtdnFhMXRuTzZ5MDJU?=
 =?utf-8?B?TW02Zk1jYVBINjdPb1ZqQmRPeDJ3WHZoZW9heXhwR2Q2eVoxSk5Hd3U0bW96?=
 =?utf-8?B?bGltT0RuRWJFR05ucElPclRsODhjTW5DQ2c3QUxxZHMxbWU5ajVEL0ZrOFVT?=
 =?utf-8?B?YTNuYy9oUXJVWHJOKzc0anBCa0ZDVHhERlp3RUZYQXh1Qk5kWnFibUM3NG9P?=
 =?utf-8?B?TjFNMzdjQ296R2RIT3ViRGNNdjhvM3lKc0Q1bzAzcVVzRlcvd0txT3c4cnpG?=
 =?utf-8?B?K0M5K2crUVI4ZkpGeGwxVTJTVWRsQW53eWhFTFVTYUNVdEVaZTdaWGNRS2ZK?=
 =?utf-8?B?M2xwMk84eS9KQStjckp2VDQzQUhFM3pYY1dUcTJ4TFlvNll5WWdETDhYWXR6?=
 =?utf-8?B?Qnc4RUN6T0JFbkZ4dmU3NXBQT0NQd0tLYWhXNFpsSVJtOWpnVEpMTGlxa2Z0?=
 =?utf-8?B?V0dWcTlXT25ydXJCOG1mTjh2bWZaU0h6RGJWVFVKbjd3WVZ4MDQ5ZWdrWDZw?=
 =?utf-8?B?WEFTSTBCbEx2d3NoMEhFcVZHQ3BRbVNiUHhiYjREY1g2bmhiWXdLbitXYUxO?=
 =?utf-8?B?ekJmbWU2MTVqR0lRaXZhcjR2bTRjUzJjdXQzeHlOMDhyUitCZjBQVndHVjcx?=
 =?utf-8?B?VkJNOEQ5UXpqdlY1cGY1R2gzTUpsajRWTEhocmNaQ3FEYmp0UEJhckdVRER5?=
 =?utf-8?B?Y2JvVXZxWVJPL3hLaDRqRGRRNXdiSmZ6NTZleE1MdkdDeUovWW45NDNYOEgy?=
 =?utf-8?B?WDhnMWVYVFhuaXBaUUFpSTJ2VDBpN3F3dWtPdjhUekQwUkdUZytZcE9wMGxk?=
 =?utf-8?B?dDJPS3FLdGpZdklvRGxhN0V2QzV0d0hBeFNOZGdyREQyWXNyTzFDMWg1K0RK?=
 =?utf-8?B?SStEVVp4QkZwYjI5VURTRGp1K2VJMW1ITjlrelo0QnFhcjhhTThlWitkditk?=
 =?utf-8?B?LzN0VytiUG1lYXJ0ajN1U2Jkdmc0VDBLZzJZeVpWVTdQeXRiWVdmaHFSeXow?=
 =?utf-8?B?bE9EVnE3MmFDY2xFM0ZUNlNhUGdseHA3NGI4VUM0cWU4WjVFakRZbnhScjlu?=
 =?utf-8?B?d25kV1g0U0Y5akhDQkRWSFJoZklkTjdpTXNKU1lsa2RwTUdtL0VGcXM4bmpm?=
 =?utf-8?B?WFhpVmRabW12cjBiU0Z2UVpZRWpqV1lSaFNOZ2xZdUk0R3d5UFpjekVLaXNT?=
 =?utf-8?B?Qms2WmxUc0dyeWVSU0UxdWVwQTlhWW9CSGxNMXhGdVBIVC9tN3NIRm1ycXZz?=
 =?utf-8?B?elNFLy9OR2laMDBDVk5QdWVlUkNQTTVkbll6WlRwbXpiaTVJQXRTTDEwTFZT?=
 =?utf-8?B?N1lCdUdMYW5VQ1Nzd1RQWkQ5Z0tSenRWa1JvZnRLWkNOYkNoa2p2UT09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6370d757-4272-47fb-10e0-08dec08e63fc
X-MS-Exchange-CrossTenant-AuthSource: MRWPR04MB12330.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2026 10:04:52.9428 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UcZ3KpWHSxkyJXi7J7Jh0nTHSPZV3OHbsSn9+aqGUwfO7F4oO3KZAuhXuHGtFCX6AJynn03X8qXkfE0C51sEjA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB7118
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

From: Peng Fan <peng.fan@nxp.com>

'node' and 'fdt' are not used, remove them.

Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/usb/musb-new/ti-musb.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/usb/musb-new/ti-musb.c b/drivers/usb/musb-new/ti-musb.c
index cc6c3b94a65..e083cb7d0ff 100644
--- a/drivers/usb/musb-new/ti-musb.c
+++ b/drivers/usb/musb-new/ti-musb.c
@@ -201,8 +201,6 @@ static int ti_musb_host_bind(struct udevice *dev)
 static int ti_musb_host_of_to_plat(struct udevice *dev)
 {
 	struct ti_musb_plat *plat = dev_get_plat(dev);
-	const void *fdt = gd->fdt_blob;
-	int node = dev_of_offset(dev);
 	int ret;
 
 	ret = ti_musb_of_to_plat(dev);
@@ -251,8 +249,6 @@ static int ti_musb_peripheral_bind(struct udevice *dev)
 static int ti_musb_peripheral_of_to_plat(struct udevice *dev)
 {
 	struct ti_musb_plat *plat = dev_get_plat(dev);
-	const void *fdt = gd->fdt_blob;
-	int node = dev_of_offset(dev);
 	int ret;
 
 	ret = ti_musb_of_to_plat(dev);

-- 
2.51.0

