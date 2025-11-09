Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCAF0CCFA13
	for <u-boot@archiver.kernel.org>; Sun,  9 Nov 2025 07:08:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9537B83EE8;
	Sun,  9 Nov 2025 08:07:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="NvE21hoy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E33A583F1F; Sun,  9 Nov 2025 08:07:19 +0100 (CET)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0C9E583F00
 for <u-boot@lists.denx.de>; Sun,  9 Nov 2025 08:07:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x3DTcj96IYL8UJn1lyd8BMMuRPK/FvH7+CydeyAE1Y8BnK07o8avn4w2U0v/xRiOC9Hs+qL1OSD4xh9DFmhkUEvWeWBU2rn1wQiuB1ijJXpQ0WG5p4tBRYdP5qNMXQbkVDogfnNmK+CkyhTyUEM+IyC/BbmX13GDWCDWY6I6Q77ZPBl9R6PjrdB62QhEa0rMfUZFurWBPcuhnPiCB6F0ED3S+2v7JiuMYrRKtfDJ+5xWC0BSxxc038oX4g5UolCrM+HpJ+LDDDHWXxz0FboSGDopDwltAZEcL+Zj/LjpSbDZrtElg0HcLul49X3a/8ulsof6cYQKVfFbDEttCT3dpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wlLcSV+nZlMTU0fqKBqQCqQXYuA2P0nLJ/v/BvP6lGY=;
 b=uJAkdFC3UJbVAXRy4FByoBipzGuZHDi9aDhWeQUGGwxtomb5ZgR9G6ZZhMHu+26QeRhXIf+mt/n4Gis5IA0b0tNqYauD6C1EuDEBRDgSwucFJVTTzVU9KR3Xr9xgk2OkRTvoHU2tjuGeasI2Bk8o8XZgMkV8HHUHfrbfpMTxYonPV18ZMcGOhPxHsrEwqfLnjqwO4Fh0sFBr6/Azd2weXU2AQQPF+xZ+UD6//pqlgPeK+CfAP1URKRIfbuIme2CJagddudXDH4sJ3HoL+kDeAJo2T9N+1DudH4TXV/DuCzKYhjeqaXzdfS27mP61eFUbRVDcaKbHG8ECH6aYs35DvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wlLcSV+nZlMTU0fqKBqQCqQXYuA2P0nLJ/v/BvP6lGY=;
 b=NvE21hoyUOLMrv7wVjjiQeLr26LdUoxpefYcmfeQGKZ/yQCbGQWRl89TwmPzqbgAXUmMPbosDBYnQUpPbzn/6i58X09aGOpKkKfudKaY26WT0IOiraKz383sY3+S2iOGk1qD/LYvbD7QTCNt2F/FSBpmuxE+w6w2/3SdCkK9/nVdvaKqhX7iCHr1DY2T3iEMyt0dYX+mC34z2m9PiVEFcPS3DYyh57zJiWmja7QNX5aFL2d0tjeRf13wU659Pc/+fVBXvVv2K0AgjLljTZPkp1rn7mfFJ1wvqZJR8rpPIn569ug0+/NJyWFqIPG835RpnyARV1YKmdEOAbhrj6Ru8w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by DBBPR08MB5945.eurprd08.prod.outlook.com (2603:10a6:10:1f7::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Sun, 9 Nov
 2025 07:07:16 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%3]) with mapi id 15.20.9298.015; Sun, 9 Nov 2025
 07:07:16 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>, Jagan Teki <jagan@amarulasolutions.com>,
 Christian Marangi <ansuelsmth@gmail.com>, u-boot@lists.denx.de
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Andreas Gnau <andreas.gnau@iopsys.eu>
Subject: [PATCH v4 07/12] dts: airoha: en7523: enable double speed flash
 reading
Date: Sun,  9 Nov 2025 10:06:53 +0300
Message-ID: <20251109070659.801344-8-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251109070659.801344-1-mikhail.kshevetskiy@iopsys.eu>
References: <20251109070659.801344-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0053.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:60::17) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|DBBPR08MB5945:EE_
X-MS-Office365-Filtering-Correlation-Id: 2afe301e-49e1-4ba5-1760-08de1f5e9da4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|52116014|366016|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?fBj2iIQXKm3BqyutxfRcRaJ9iN0VdX5wtCKCaJGOY4r1yK8hdh2QDjDYa7re?=
 =?us-ascii?Q?jFDWpdkQKP7jrS5AP3ztLqG1FnySMzSJLZnMm/lUTijZqwQghx7nbVrpsdyt?=
 =?us-ascii?Q?6nCrFEWpEDoXf1mURVF5jm1Y5ODqwj+l0pw7UtIoP47nOp7N5qCIuA9iWC5V?=
 =?us-ascii?Q?J/2Jk1JmaIhSqAdL126bBlrfer8h5e88F/4MQJatYF13PjOnnfEMAfiB/35K?=
 =?us-ascii?Q?q+vlOfKQJE9QJWEksqUUNvCo/W31LyzAu9K+45GCLoMRPhyUask/RjDN5qG+?=
 =?us-ascii?Q?/FcWscBjjC6QAxbI/JWXQMO2hctmlgIFbKPQuZZUWRwaT6QrHdDoUzRLj2LZ?=
 =?us-ascii?Q?lTVyVDxf4+CAwJtHqeewROApJdhpzoyC2vwKEcYFKzMl2G/iQF2XP0VHKw9p?=
 =?us-ascii?Q?h4bW4jeWEM9M3Y023Fc6kgD7Z39drsegDTeyMwXQkCh4tgmtv+UIG345+Yxd?=
 =?us-ascii?Q?vIkwCCy7bYwK1ZoGHRYMkZfbvfTPW0ZEwnOwG4ymBaFAaGifkMzj3LqXIPba?=
 =?us-ascii?Q?LrL8KR4taHp2chWcbuqSNuoqTj3wu3rNiY0x4fnk/ROVKpNFSORsaf1tQQn+?=
 =?us-ascii?Q?nzHRcqDTGLsl58gT9x8Z1tYK4wDJHpr6boLhlbtH+2b12VZkreFTbDQYN1eq?=
 =?us-ascii?Q?1RFWVr2sUxOWeXLyQeMgEJYO7r5PfCT2hELmayVmOf5yKZYH4B3nyVy27ZdT?=
 =?us-ascii?Q?bgrz5+wC+D8x4QuD/c3dCx+Eu8y0dJJuL37AqysW4uc7Z/YIRBiPfkgE+jRS?=
 =?us-ascii?Q?bEqPddHlgD4hz+RBi+uPvCzAdWQxZo9upsxjym6G1V5LinSrVSEc5RJdAVzW?=
 =?us-ascii?Q?Ve0hun7wncQyLFIa1KXIBcMLL499ouiz9bDGptzfBPBT55Q+wLy9xUcq3gpd?=
 =?us-ascii?Q?jLenn94Gnb64x3H6pWt6jtkEnmReqCx7NgXqtgM3tY7hVHqMkrgaCUwVQ3fg?=
 =?us-ascii?Q?qeDg4KJZF1AhKDy3oDzwkN5R2Ohm/PkqNPSrnX7r8UgmhxtaBqUPrbsbLhBR?=
 =?us-ascii?Q?JKrB4ccb7CkqnJck5ANQNBnoA1oTP7zxl8U6ZBrPtmcmacP+NhTPZHgsUREj?=
 =?us-ascii?Q?GCQ7dDcHW61crteb3z9j80lDeIzXSJLeCs/RqucTFb5q9UvR+mQ1+NdW/XYm?=
 =?us-ascii?Q?vLjnKr/BQR4Zt9jSig9e8lu1qm5XxKwywmDAx6mMv3RZIyBfN5y3WGP1kOEt?=
 =?us-ascii?Q?JiE95gAk3+eoQJv+BU9hLQABI5kXKzRpxJfB720Dts7XOLG66uDGebBZpby3?=
 =?us-ascii?Q?zVQZyFCoJ164NGLDXyNezJuMQH0Va36/p/L8yxmPv74cINUiwb+pmeyjphXO?=
 =?us-ascii?Q?IPI0gQLs+y9Bv1+lLh7DZfp6QwLGpOTP9EBVGKCYz2ICypBQxYsPJhKEte2w?=
 =?us-ascii?Q?YhqX7faF6v8tMpNa1IL4HYQSiDzLjcxaLNSnQhQWRoPO4QRxGeFsKbT6qVAP?=
 =?us-ascii?Q?Xi2v2o1UHkxXGWQZxfBVV2jwTA+50GFMnItcVCDqUOQlZ4RtBXZivnp0CybR?=
 =?us-ascii?Q?OEve5A0jAM6LxjRmLKLUnE6nbAhS5H1ZrOHM?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(52116014)(366016)(1800799024)(38350700014); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+DoLqeajCd6+a3ftpfWUwv9+ziEvbpwUtT5P+9b5vWQtuYYSlq6CJBpQj95O?=
 =?us-ascii?Q?ONbd4y4wQNXe9C4kQ/VePTh7kt+NdXJwQ4vqHh4ouLvfKityXlvOW9QrGuUX?=
 =?us-ascii?Q?7HkuuM9opdnLTzMqyeoLX2bYqGv3qYtTDOMW85HvejWgE5JLSJ3A64ADsLnn?=
 =?us-ascii?Q?+y+uRJTjWMXEPZ97ZLAnFnM90whKtHLGGXnbVtLSpMa/LEhL4qoFktXMXLp/?=
 =?us-ascii?Q?FOAuK8sd3lmFNz54JCoOOx3Cf9LWLk5BSs8//SKL6nLnsz8+6iKuYa2GtI4j?=
 =?us-ascii?Q?52g8KBRZMGmTPXB0Hc/nBooHfNlZGa2n+8z37QIsmxlYchnecLwPloxXqaAR?=
 =?us-ascii?Q?zT1ALClq5p+Xmv2tnxOdvdK4J7DQ1DARePCLeNZYbgOirLF5yuAIFS57UHys?=
 =?us-ascii?Q?Gxu9twSCrYNHiJCeqN/rhkdRbh3msbQiIDG2EULLqMhM9PvGoScR5viGNGHA?=
 =?us-ascii?Q?wgyp4pb8gcPbbMkDw64WaK6vu8e0KytznYf2/xpVK4Mu2Hx3B3OznaTmopRL?=
 =?us-ascii?Q?5U9WV68GcyLbA5A1CLQ/qQbRfj0wa6pj9MxAv5cHMdCtZAtwpiqEH8d/H0P6?=
 =?us-ascii?Q?No8gQd6YmI7wVC8xgBTSyzaHKuoH8QBxgIBH0qEd0yB/6hCeL8yP9L6KHHBp?=
 =?us-ascii?Q?c+5J2+M/Rf++eGHqpBUWaob3bTllZF0I3gXgUCBI9n52MTef5GuS7GRNrC6h?=
 =?us-ascii?Q?WEqBlVFGhkmJzhQoAIx6R8W3nwzKoB0Ptmx9FsJoppqRzd+iqix0TFZ/sXUt?=
 =?us-ascii?Q?kMicGPO9IR+Qadyic5uOQ9O9ZrhlGc4W4uw4d8NLw27z8RtFuc0RNsAJcYYA?=
 =?us-ascii?Q?TQe2oCt4U95FrUWr7Z9yZ+2Q33VbTsRkI7qB40KD9gy0rS/MP5mkZw2DAMee?=
 =?us-ascii?Q?M9nZp7uE5kNjsAWyjEuXM7MYb3CxrpvPT6WIkPMC9mQcqNtJ6UNx4M63h3eY?=
 =?us-ascii?Q?6bz9lNCa2da3qJGgiCYQIr3EYL6hsWUdl6mOIR9l7OFyH/f3Vk+IKTzrngfY?=
 =?us-ascii?Q?JTw7MSu91fEAKY3M1+bNz5E+qsNwvjxiiKcVE9F24b2Ve8lVtMkFNal0nVOR?=
 =?us-ascii?Q?ARB+7r8CnOtk1DfWKrL0AY+vIFMzwE88dyXGEM4xNaseLIY/UQa54LBy+leH?=
 =?us-ascii?Q?3oXSvEquxpWYCWIPSyIRShCQlJ1b1XVgcdtL6R3YpBH4xRuCEGbuFcvJbRqQ?=
 =?us-ascii?Q?6y+eIV+sDM2YgxWeVt/kaYwNQuM/sdhu64Bcyo9Yscj3De/yna9nTnbakrkJ?=
 =?us-ascii?Q?wJKrs+kDyFNYTHUgovDULVH0bkVlymQ8/6fJA3fO6H2WMH1XUlSM+r0pHMsk?=
 =?us-ascii?Q?n/rvzOvE6G+YtTwOTIUyqZkuzO8UL0Ts9hRw86nxMq6FF0MaYOT1QyLUfd+g?=
 =?us-ascii?Q?hCrJtj8rWObNgQNC3y1p19xQdfVeduea0BuWahHcp+AL6Xva24UYV9MtqNSb?=
 =?us-ascii?Q?SLXs+1DMhVUQiiDN+M//WkLv/UTyJPyyxXFk6VMeUGP0HA+0oN1Zp4LCfOTB?=
 =?us-ascii?Q?qBRlo15S64DEo3SUTgxBSv7agH8a50hXe17EoG+9wHak8Xl4FIodPSEnLADv?=
 =?us-ascii?Q?049IPujIvEWlxAqN/NV+GCgsBngk9nFdUQ8KDjhJqxc/kDOdIeDugQnRHzj0?=
 =?us-ascii?Q?IA=3D=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 2afe301e-49e1-4ba5-1760-08de1f5e9da4
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2025 07:07:16.8228 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8CyuF5ytRnrSbZFl4ORfRX4cpMVwhg6AntMy9KSWE/iln9p7DD87tZiB0VjTBcOm6nsRW1GuqnLWYHLIpbe3YArDhB10+ND07TXEM1oKSsc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR08MB5945
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

it should work properly after the airoha-snfi driver patches

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 arch/arm/dts/en7523-u-boot.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/dts/en7523-u-boot.dtsi b/arch/arm/dts/en7523-u-boot.dtsi
index 90838c00a85..f031f81515a 100644
--- a/arch/arm/dts/en7523-u-boot.dtsi
+++ b/arch/arm/dts/en7523-u-boot.dtsi
@@ -60,7 +60,7 @@
 			reg = <0>;
 			spi-max-frequency = <50000000>;
 			spi-tx-bus-width = <1>;
-			spi-rx-bus-width = <1>;
+			spi-rx-bus-width = <2>;
 		};
 	};
 };
-- 
2.51.0

