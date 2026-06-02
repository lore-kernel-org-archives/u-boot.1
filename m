Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0E21CD6E4A
	for <u-boot@archiver.kernel.org>; Tue,  2 Jun 2026 10:05:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 233E084935;
	Tue,  2 Jun 2026 12:05:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="hnpjud0J";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F296B848F0; Tue,  2 Jun 2026 12:05:11 +0200 (CEST)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 19F5B84940
 for <u-boot@lists.denx.de>; Tue,  2 Jun 2026 12:05:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GYcjkhVq7fYdM5v7c0Jmcp+XJCqGu9Ut1R2364Vi7lWXurtiGEKpVodID4vBLbXH+xHyXQfJOjkngR7ocazmid2/uXByg2Oe2F7uJNY/kyqvJxxACFT0kWOhVWErvmASNgtU/JRWWjhy8OaXBYQY5xGB12//OSk1JT9M4OY81d7T5+OwSOMWZdgrCeGkeYgQUutXX/7UbcEgMExzgd7yA6aaV+dTVA3deb3P4YKc2Yb/TLrFST6tJPvJzpujOTKSQkqUVhAj70CXD6ro0aqmk5HeVGbfTu+YOYyl8inKMVAyONKIxDKyLU6Hhqtx4zn8T6sZbCqlWfHe/3TkmJQd7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v3j8Jn92SsRSLcU9t7bdaVbCsJrAhNA6kx8wmdHB+0s=;
 b=jZ/OLnqQU+6+CEciEAjEOAwbN/1HC+uWl3lC+fFpEYT2l10FAjHGttQJImFXvYltBp8eC61kbiYDt36HR5/frTOzgCqEpJlFC1koMP6yeNcqS6bBsc6jKG1qDzgACvkX3Y0Efd5tiGfPgRUIkd/YlcXVdJPBiKxuYd0OwliWUfDEQt0aqqsmSAwFrf5P/2JrOs13hwr6EcNGbHmsZYRQtZjc2ldf3VTTTHd86Sv13rDpn12lY4FtazfHf3eISelzY6nY5bao3q7aZbvOVIBFP8PMAQLwxJ0xF/0NNHfB5t6xeAqIwxAla6PPNH3m2P9wbm66qkNAS3oqULl2blMOPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v3j8Jn92SsRSLcU9t7bdaVbCsJrAhNA6kx8wmdHB+0s=;
 b=hnpjud0JT3rcTHyXd6lmRK0R372HAiF3JDls8WU44WzDZkhrXbJ8TgsnL9k5nD4xndoSdUlJx5remuFjuGFoArYwV7jKKNUYwwDYtOv+o0jh4mgo+/zCkGBPIliI0lJZwti+i+K0PrWHxRlj94yDI6ObzPuFHTJncTBE7jr9xOMBtQNwDKlmlJU1/6WBWyss27uD91TjfPbi4g6POL2EKrglkwzDrx/F+w7ITb3HFpKKkUP4qTeWRhEFpBRUyFMStepl0GlIXEA9QAqyuFH1NOxjQIg2jfC3ax9TMr8eXRqIejAQTH95XpTqilYVjnnX5SNsRa59+grrmf5J11e4oA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MRWPR04MB12330.eurprd04.prod.outlook.com (2603:10a6:501:7f::23)
 by VI1PR04MB7118.eurprd04.prod.outlook.com (2603:10a6:800:127::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.16; Tue, 2 Jun 2026
 10:05:07 +0000
Received: from MRWPR04MB12330.eurprd04.prod.outlook.com
 ([fe80::ca22:f8c8:6aca:7889]) by MRWPR04MB12330.eurprd04.prod.outlook.com
 ([fe80::ca22:f8c8:6aca:7889%6]) with mapi id 15.21.0071.011; Tue, 2 Jun 2026
 10:05:07 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Tue, 02 Jun 2026 19:21:43 +0800
Subject: [PATCH v2 4/6] usb: host: xhci: Use dev_remap_addr_name()
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260602-devfdt-usb-v2-4-a587ab36b906@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: ac891064-6eba-40b0-2013-08dec08e6c86
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|19092799006|52116014|376014|7416014|1800799024|38350700014|18002099003|22082099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: 2eRP3CuUghJSmnlhMdH+9Unm9p7yuZpzkwwxia6TLdHW0/vLktvZROGM85mRVkKU5Cv4J/KXIUs5dd8e0PBtfnJZL2oy+bb+kIcY5pUOwM31+Y4jTAODhHH+bd65Yg5ThQQhEfrCnekM0q9uPz3smcTZHXyapZKVEuWfLfqDoyVwCd7KCc4UJrVtqbcwTVbRpyqvhzYlFcSWZeI5wqI2+qnr16VRZRi5gugI8JaLC8UyKqW7OQIpD2y+NugBSPwWP7Wh7dCpRM3CBRvbM4pECnty7jIsaUXHVfDgcKVk5v5dp0JOuMXmgXpInFPOGPAYF9lS+iW9QMbjEaK7QxgQte1LBzHO+6ZKqssMWre7tWkaViCjyIQam8K07leIikix1dRsbiDJ83Oxtjhuh7AAQj6UbX/2RGbsYNJkQDAXT7y7cQowOCgzYydS52T/1fiaP0Uo8pVyQ/yGHIIrjRmvADePMg640r5my5kx+RBue3Hd2XfJHdEfvVyqRgVqkv6ApgAs/D2E4x8ZKt6FMpF20mQIh/Q1FL3ebVRbOwzvY93e3tCaalUz3zoTzyJm4mnaXyTfo2eEwGApO8FzwDxgkvylDFEOKIXYsuLR8E/lUcC4QpsHZCnCOKZLdClJPWH4MeC14C6Dp3TshgHFjFAYbVE2gAbfDup28n5+UyW2kR9Gqk5/Z/JFhS+JFjmahGEl0VgKaghSbz3l56Y4B0CuV2MGFaCxIi74L0g9A962+HjF15xj5h3NGFxV+Cji6GDK
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MRWPR04MB12330.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(19092799006)(52116014)(376014)(7416014)(1800799024)(38350700014)(18002099003)(22082099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S2VlWFF6Y0NTTnE3VTlPQThpd1QwNG1KSXB2Ky9zbm4yYnhCNUZETWtYdWpv?=
 =?utf-8?B?RWhYa20zL3lkcjRjOGxoNVptQzhxaFR0UXRnSjE3T1dlcjBjcTg0ZGV1MDBy?=
 =?utf-8?B?NHcxQVE0dVJEUE53N1dGeU5Kb29PdnNYck9kQ2dJOEhJY255Q2tlM2twb3hp?=
 =?utf-8?B?YmtFdjltWHJndTllTEJtSDdJUVM1ZHdlN1hDT2FObVNKSlhRb0JSeUQwTGlS?=
 =?utf-8?B?aWV3K1cxNDljU3hhbGhsSlhHeG80NjlPVGwzcDUxU0wraEIxNG5KNUhXZXZr?=
 =?utf-8?B?cHFCWWFISHlTZVhuakUvR1RnZUJ6MzNJZE1jTWUvc0RjWTJ6V2FSSDRvNjZj?=
 =?utf-8?B?d1QybXc4bDdIY1gwVm1qeWZrNjRPbCtsVXVNeFJzVkh6cEJOdWdGODRuL1V5?=
 =?utf-8?B?amtYTVFUNnpWcklVenlFSlQ5NkdIVWFhaWNGa0tTUlJrdG9hS2FRNHlhcHp4?=
 =?utf-8?B?TXFBanhlOXhwRkFZOTJYZ3VnOE5PYnh4cEVKZzg0dnZ6TnY3WEw3dCtLbVpq?=
 =?utf-8?B?d0U4Tnk2ZnV1ZTBucEFpTHE4QmpnRUF1MllpMW5YcFJhbUdicmFuV2FYdGhR?=
 =?utf-8?B?TCs3SGhMRkxsWHovZFB0VjdwdnF4Q0NMSE1DWjgxT25LRWRTbjlGVWJQVkxm?=
 =?utf-8?B?M2ZvbXV5M3BlajBuMThBNnk1Q3dHUC9PQ2JJWnorNjBGc2NJMndTcE1kMkx3?=
 =?utf-8?B?MjY1K0F1c1RwREswck1WemUzUDBjV2hBYmdmS0dpSWdmeEptUTJmNVB1OG5V?=
 =?utf-8?B?T0c4RTd4V2J3NytxZWFVanpmTWtWcXl2aXFDSVBUckNCc09jWkVsOUkyUmpo?=
 =?utf-8?B?eHR5aGxXaVhpN2hSaUxpcGdoL3IzbVJFcFk5a3FpblpGMDBMV1g3SkJaSlN4?=
 =?utf-8?B?SkdhMmtjNXc1dzJLbG03UEtZTlNxMlNzeHN1bHVpYUtKN0dNNmd5TW96ZlpI?=
 =?utf-8?B?MmdDanFkWkhkTmE1K0pFU1NGZFZxZWtwOWRhWCtrbUNnNG5FcHhURC9qM2l3?=
 =?utf-8?B?cWdSN3Z0WkdSRmZxVm9LRFNrZEVBWmJTYklSeHVVMWY5UmlTYkxETzdkZTFI?=
 =?utf-8?B?Q0ZoUEhqbS9OREFGUEFYN0prUHJjSjk2NVhOV3AvS3lteG5xc3FBT3dVSEFq?=
 =?utf-8?B?c3pERUo3cWpvcHhQZlVMWjQzYkEwQkRYR1FWUDRtclR2UktLcG5wNjZ3M1l6?=
 =?utf-8?B?RWtxMVdEZ0RaN0c1d2lyY0cxRDFIczZ0M3NjQlJpc0N4YjFlN05nUDhxditk?=
 =?utf-8?B?bFN1ZUw2VGlrU2hqVGQ1NzhLcFRFVnJScjVhU2J6UlNFSkZTZHZTcHVkcUY0?=
 =?utf-8?B?TEhKRHFpM3E3QytzZEU4b2JKM0xIWmFic0JRcXZJRWdIZFNTdEVDcGhiUFpE?=
 =?utf-8?B?dTdwUGM0Q1prS0ZWVlJuZ0NybkJxVlFFcnlRaEFUYThWV2U3dnM2WjhUY1dr?=
 =?utf-8?B?TEs3NlAxWTJMQlBOUElHZm55bUV6OWZka0RQYUZNaHVqY004UFJnTk1qcVNP?=
 =?utf-8?B?Y3NyYk1adHFnbVM4T05yNmNXTWFoZklvbWQxZkVvOFN1TW5FVkl3eWhXdzkx?=
 =?utf-8?B?Z3NCNjhzL29QRHhVamJ3a1dGNlB6R2hqMDduaTdrOE1WejRuUUlqUHpkYjRF?=
 =?utf-8?B?S3JENTdRSk1WQnZVREZIU3NDN1hLSm5Wdm01eGFJZHU5QStTVHg4ZzZ0NlhE?=
 =?utf-8?B?aUNxOHpyV2pEWnlHS0ZUVFNSeUpmdExaUDE0UTBXMDlscUFXVEkrY2pXbVQ1?=
 =?utf-8?B?YjBGbWg4ZE9RQjhiN2dmMklhUzVNWXhMZkhNTGtoVWlYNDlqSHFOSDdOWXZm?=
 =?utf-8?B?UFJaejNlSzA5RjZvUmd1cDlxRXloS2doM0d1NUNyRUM1OURFSEw2TjJCYVpq?=
 =?utf-8?B?eTBXWHd0Nk5ldUwzTks2V04xNm03U1NEWWtlZ2x1MWUzNktibkZ4NnlFems0?=
 =?utf-8?B?VGdOdklXMHp5ZEdPSFdkaFdWQUd0QUh4cENqYTQ1a2R1b2QzOEFmZjhPUkJ6?=
 =?utf-8?B?UDhZT3ZBT3dWWExSMWxTNmY0b3laaEkwN2YwS2xmNkFOUFdscUs2SkRTbkQ4?=
 =?utf-8?B?OHpGYVpaOUNlVFBGb3dMbFlJWXF5UXZ6K0ZzMHdaNUVVejRiTTFwQ2VzNnBB?=
 =?utf-8?B?NmhxaUNQckdFWitSK1Vud2twdUNmM0NSb3ZVRGdFaW5zRGhIclFMRktHeEN3?=
 =?utf-8?B?RGRVKy9oa2t0QU5GcThxUVIxeHRFbXUyck5WZzQ0Sk5ESGdoN1FjSVByZEFs?=
 =?utf-8?B?SUFuVzVQbDJQYjhZZnJBSG4wVW5nM1B5d2t3VzVHdWpncFkwQ3VPdC9YUW1D?=
 =?utf-8?B?QWdxYWVCVW40dk9BMmxFYWI1TnczdGV1Vjg2NnZQb3VpdmJYcWFEQT09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac891064-6eba-40b0-2013-08dec08e6c86
X-MS-Exchange-CrossTenant-AuthSource: MRWPR04MB12330.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2026 10:05:07.3073 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 87jAlpprTT+OQNB/VM9I+hYegT3LiQp3f70TjsHgJy1a5KxFnmg8tTRaY+o/Tux66VyqhQSXti37jRic6Nt9QA==
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

Use dev_remap_addr_name() which supports both live device tree and flat DT
backends, avoiding direct dependency on devfdt_* helpers.

No functional changes

Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/usb/host/xhci-mtk.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/host/xhci-mtk.c b/drivers/usb/host/xhci-mtk.c
index ffe80c0bbdc..27caa3ebf86 100644
--- a/drivers/usb/host/xhci-mtk.c
+++ b/drivers/usb/host/xhci-mtk.c
@@ -202,13 +202,13 @@ static int xhci_mtk_ofdata_get(struct mtk_xhci *mtk)
 	struct udevice *dev = mtk->dev;
 	int ret = 0;
 
-	mtk->hcd = devfdt_remap_addr_name(dev, "mac");
+	mtk->hcd = dev_remap_addr_name(dev, "mac");
 	if (!mtk->hcd) {
 		dev_err(dev, "failed to get xHCI base address\n");
 		return -ENXIO;
 	}
 
-	mtk->ippc = devfdt_remap_addr_name(dev, "ippc");
+	mtk->ippc = dev_remap_addr_name(dev, "ippc");
 	if (!mtk->ippc) {
 		dev_err(dev, "failed to get IPPC base address\n");
 		return -ENXIO;

-- 
2.51.0

