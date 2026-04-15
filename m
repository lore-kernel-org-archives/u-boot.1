Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94007FA0C57
	for <u-boot@archiver.kernel.org>; Wed, 15 Apr 2026 08:54:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5596E84129;
	Wed, 15 Apr 2026 10:54:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="FGc+sghP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6D2A78419C; Wed, 15 Apr 2026 10:54:25 +0200 (CEST)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 75F0C83C51
 for <u-boot@lists.denx.de>; Wed, 15 Apr 2026 10:54:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x3TJi4aaeaKoMCnB/JnhwOGu3/Rih9RneG+d/J5a1jco30D0I5lT5KThFd1FmzNz/wj4gchld49vC789RKYIAmcETV6cMn1AnGf9xwF1u5lRiICDrWYl/aJKDr5L/5xB0hsdwv5joC4jK5PRpHs+Ef7oNPOQBr/dMyG5+895BlLXUWtfI53eXDMZ+9g215Zko6MtHXFDqYhvxVXIBJRX8rkVyXdAlcZ3KWZieHB5NrBKvlLX/RUgtAz6Tp+F0+9yje9rr9Grsvqc6mcnjq2NGOsrcqqUB1lTjUt38fHPfEdKdkil+l6zG8IV2lwl7MFVbTYnyrwFzweYuVi1nKJBCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yKlibF2QVia3QZGuuP4Vpqp3VzggAu31fgePzM0laj4=;
 b=tMPZo5DW+B5QRwF/5JCo2IobUGihK7MUFDadyCAeZ5JqmRvlA8Xf2td75EUeuq7fJ5qvF8Ru4jKxaERk/JkNIwbCAv9VnyL/MS0YN8u3foCBzft5StHMkEFfHL5Wx2ZLGzQ/Ie+3K7admj3PIEQcSCNS6Dj2Vwf09trqlWoxTfxnz3sw4OTB+hjL9wv249EZZgLmboTI4hgAeYuAXIclEOtPfEV2vAgEccg3UqpYwUJgvEoJWnAIly1VsPod0efUcRtOmpjU0YB9nxepeLrMjfXrILzESAozdjvkTU8TPY0y9V9Gz2kguBwT8zV0rsh8VmAWisoJa6ehfZ8YfguT4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yKlibF2QVia3QZGuuP4Vpqp3VzggAu31fgePzM0laj4=;
 b=FGc+sghPmi63fbB9yPazwFGNKDDuq8FlOAIfkSVRjoO8y/iz0c6NThpf3X8tYQxBZYciQvkIB7nnZGw6x7szODhLlVR3HY92q+k0AoMuuXvkEAOiPYrcBr5BVjD9vCACSvjA6ydlAA6B1+qOpK4nVnxApZMD3QKpHmpclI5m2gb3VSbnN3F9ErejNJL62P58jBY+81x0if9xBmbbycGVMYkW309pqVpUKQBxJmD2Z9kPtWLlFOEXnPgSg6VbyrXpokQTyxfPZXR6L3/zrOkecVoBLTIwy8ko3MxdnfKRSjYTKhNe5VYM5LUP843YCjVED94Q+7DNMdFyKSf7KmEpnw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by FRZPR04MB12431.eurprd04.prod.outlook.com (2603:10a6:d10:1c8::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.48; Wed, 15 Apr
 2026 08:54:19 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::cf3:c5b0:7a0c:d11b]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::cf3:c5b0:7a0c:d11b%5]) with mapi id 15.20.9769.046; Wed, 15 Apr 2026
 08:54:19 +0000
From: alice.guo@oss.nxp.com
Date: Wed, 15 Apr 2026 16:56:27 +0800
Subject: [PATCH v1 2/2] net: fsl_enetc: Add iMX95 enetc4 10Gbps port
 support
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260415-10g-v1-2-f6809a31c2b2@nxp.com>
References: <20260415-10g-v1-0-f6809a31c2b2@nxp.com>
In-Reply-To: <20260415-10g-v1-0-f6809a31c2b2@nxp.com>
To: u-boot@lists.denx.de, Marek Vasut <marex@nabladev.com>
Cc: Jerome Forissier <jerome.forissier@arm.com>, 
 Tom Rini <trini@konsulko.com>, Beiyan Yun <root@infi.wang>, 
 Bo-Cun Chen <bc-bocun.chen@mediatek.com>, 
 Siddharth Vadapalli <s-vadapalli@ti.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, Ye Li <ye.li@nxp.com>, 
 Vladimir Oltean <vladimir.oltean@nxp.com>, 
 Michael Walle <mwalle@kernel.org>, 
 Thomas Schaefer <thomas.schaefer@kontron.com>, Marek Vasut <marex@denx.de>, 
 Alice Guo <alice.guo@nxp.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: SG2P153CA0018.APCP153.PROD.OUTLOOK.COM (2603:1096::28) To
 PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|FRZPR04MB12431:EE_
X-MS-Office365-Filtering-Correlation-Id: 40823625-110c-4128-3b1a-08de9acc94c8
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|19092799006|52116014|7416014|376014|366016|38350700014|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: XY4f2+c3CwUEEMiZQAISKYD0qIBxJI5is7jE0FbjMqek79/Y5UkPEE9Hkfmm0JHEPpIWrsSg1gJyvkvCnillnFeXlUM01mrkf/tk+ZERT4USwXABXGSe39s5JrFj5dBaCObSWBMd9KEreKmCPjusQeUlz4nEOpsI5FVPffHmp3ltuf0m730pP4VZG5YE955d/h7nqOKvlBM/GpFm1xLhqokwLm0KIOm5Tc8YJDRTNsTKmsAglFy+zpfJ0xcHBE0qvFc1EmZ6GuT/WocAcGViPrrunibxrS4+V0/cwNCD+u3UZPWOWb/qzneRnsnDpUMiODgWiE00+yvqxo7ThgJeB6YmMbb1x0xVx1Ya4uKl9lBdTVcI27+tSqRr2wr149Dj/p8wwIEsKmloSkfqCNQfig8WU5tZ8W2AggBXo17pJF4L/Z18/WNdZByZyyMEZtIv3vXYtkQdpmIjCpxRNNrN8l4yaZUkVC07IyifE7GpOVHg0fGM5FIbTt2rACV6qhsUUDhsbKNMf7s0ac1BCm3bYopeFN8fDnLw9FOiNjhN/4IyTMhlJsuLeFOAr0htZmnH//Xhb8WHshOqP2ojKGAaOoNduI14dldPtxFCEjS84jmP09RCR1czSDOv6A0+WMFq/HawU0HYiWYIccIS1r2DasUNittrNPAVGnjxPxxWWhw0iJM3Big74rap2BPj9p0W5/vPZCKsYNNUA3gHQU3kNWLDpaeDCwvcWMe/Zsj5YQCg/+b5kczjawT90DoBbQQBaKDTkNYCy4B3KPcW59BAWP/jfQWw0VkBIjUXSro0Pdw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(19092799006)(52116014)(7416014)(376014)(366016)(38350700014)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b1MwSWRQdC9BU1RJdUgxYmdQMkg4TTdqWFVuY3NTdVlYQ3pUQW9vbTBVZ1U5?=
 =?utf-8?B?SWZUT1I2Z3ZsWko2a0F1NFlrTEE2Q1d4M0ZoQklVcVgrY0t5dXZRNFFxN3hx?=
 =?utf-8?B?eXEzbE1MM0hDQlo4SzNxMis2c2V5SndxMmNBR2x4YTc4a1hNSW5NSFFFcjZJ?=
 =?utf-8?B?YlgwZWZKTjZyeXdyNFYyci9aa0hrcHJPN2ZlcTY1STEvTGJoWlRvM0V1U0xN?=
 =?utf-8?B?andBWDErQTlkR3FsZ1lqRXRCME1CVkxMVzB2dDlvQXlWQjdVS0RodWZsMitV?=
 =?utf-8?B?ajNOUW1hSVY5YnhNRThKcE04YWVkWnQrSkRxQUJoRmEwNkhPWFNwYXNHTThx?=
 =?utf-8?B?azRWS20wYjhlSTJvQVBTbkVIMDEvQjh0bDI5Rm5uNy80ZTdpUGUvNXpvYW1q?=
 =?utf-8?B?SXlVdUloRGhXSGFoMjlNczVDUGNFUEpXT2NCRVA3T1BKbHRicGVZT1B0aDN6?=
 =?utf-8?B?SDRZL25jYk5QQzRFaG1HQzB3QlRGVlpGSXNDOEhjMjVTYzBJSHE0d1F4Nzhs?=
 =?utf-8?B?aDhORjhjQmFXUVdQOGh3MWxOSnpRMk9MTDhSOEloT3BOWGRQaXQrcE9UYUVG?=
 =?utf-8?B?ZS9iVDBiQnNBUDdEUzZ5REdVNGp3V1pYUzFwSks5aWtvbjY3S1ppcHJyNXpT?=
 =?utf-8?B?SW11Q2dXWmV6d0xYYWEzMTNPaWV3VlVhbWJNSHhvdmNEcm1RSUJrb1JkRldt?=
 =?utf-8?B?YytBWE1LUFprL3V1QXUwblZTRU9hMnZ1ZlA3VWk1d2czZFhwYW1vbk12MlBm?=
 =?utf-8?B?dkdGN1ZLNlZVVkplVlZiWVlMMXA4NjZGSTk5bEpZZzFtcjBaQ0dMMHV2Tmd4?=
 =?utf-8?B?cWtSbU10eitHazhkQlI3MlA2MlRqWmlRenlPU2VPVytLRjdQT1l5VmpIUW9R?=
 =?utf-8?B?bXdGVmQrY2NOQjQ0R3JIMmhYV3hQZFY4WGdoeFJsS3ZhUy9TZm9PSWVxbW9N?=
 =?utf-8?B?Q1dGNVg1SFZST1VZZTRZUHJYSVRUZUFzWEFNSlZaNk9mSjYwc3o1N3RSYTVL?=
 =?utf-8?B?aXowOGMzU0ZDQlhRem4rUlUwUis3SUdxQVNZbEc3dkVsVGRyeGtaNWRycFlC?=
 =?utf-8?B?b2xCMzVYOTNabjl5Q1hrRGZZUGQ4anRWQzBEUW5TMTRrZFRWSklpU0xPOFYr?=
 =?utf-8?B?OEJWUHJjcW5COUFCV3ZqNHZWOHJMQzNraGJHMWxYY3g5ZzYyVVB2MXplVG9C?=
 =?utf-8?B?SmJGdGUraDhPWlR2U3BrRHllNUhSeHl6NkpnTmhmRXQyUFdaeXZwYjVFRUNx?=
 =?utf-8?B?NEdLbXcyZWFORU5kNmJMS0wzY0Y2L3pTUVE4dWJKRHEwb3BIQ0h2bGZ4cisz?=
 =?utf-8?B?ZnNPRXI2ZnpzN0liSlVuWGd4SHlaV2VqU0F1dFdqSCt1ZXFJZlJlcHdxWm1w?=
 =?utf-8?B?Nm9vVXJSZEZTMDg4b0Zrak83QTF1OEhpQ2V4dEpTQUgvYUdBMW1pZU1pSG4z?=
 =?utf-8?B?WUNoYjdRY2Juemg5NEkzZUV0d0xHWU1KNDVieVF0Q0JEdmxSdGo0MGRqaStD?=
 =?utf-8?B?cVJPOWVMOGxrS2lMK2w5NE9mMlhJcTZlaXJNQzNMa3BTNVl3L0pjdkkwUnFu?=
 =?utf-8?B?aXpqQnJibk1HRWE2ZEVLdUxWWVFLejJlYzdkYlkwN21Pa21JZGc2NXl2WkFO?=
 =?utf-8?B?eXRsZERWSUZvOHZxNHVuOGFsdXVnSktkemdjRUdvQWpoYTUyVTY0ZlROYVlT?=
 =?utf-8?B?Z3dMclBLLy9sUXpDWkZrdldIZjVROVJobW5sVlIva2VUVzhzdklkelVzS2xh?=
 =?utf-8?B?UENaV1lldHlEb2tEdWl0RlM5Ui9yd2g0QkwrUWZTNGNRL1hteCt6RXR1TnFM?=
 =?utf-8?B?WmozTDlJbG5NZzBjLzR0bEhJU2hIUURwSlBDU1d6ZUt5OEdYRWlnUDEzblZk?=
 =?utf-8?B?MS9CT2ljNFp4R1hLV2Rpdi9IMDJhSzFZdElFR1l3QlgrWWc0bTJTa1gvaXlB?=
 =?utf-8?B?eENWaXlnTXZzc3hMSUFVOUllNnhxb1ZnblF6blF0My9IalFaQ2EvSmxHR3B6?=
 =?utf-8?B?c2c1VktIcmdYdmlCbVE3RGVHK3RYYVJTSnE1L1hxQ0llbml6TnBqOENUaXR1?=
 =?utf-8?B?aWxSYnVhYXJ2WFljWkZYQ3RjOUNNaDkzVmJ0OXBFdCtHRDdRbSsxWElFcUZG?=
 =?utf-8?B?emp2R094V0hKUzBRNWJtZ2ZEcGRaSmtRV0psUlhXSG9HLzI5dVoxck1TWHlL?=
 =?utf-8?B?azFvQVczS29FUGdnVlBhQkxTY3RZK3JwS1drOXRLb0dtODYvYmdNMHNnTk1D?=
 =?utf-8?B?c3ZnSXBJbTA0L1ZkcEF2bXRtVDdIOUxoTmF5Ly9VMXJLUmEwRU01a1I4QVlm?=
 =?utf-8?B?bkMzY1VOYXZkZ1REQlpBOWlTa3RoWUtvbW1KMG8rcnVidmtNRGxRQT09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40823625-110c-4128-3b1a-08de9acc94c8
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2026 08:54:19.7649 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mzITSlDthaEes4zprbq01i1F1hve1rkQUIW+u0Cn4UZBjVY/YpgJpTj1DTjaGtx103htHA3+d3RwCVEDSIPDpQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FRZPR04MB12431
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

From: Ye Li <ye.li@nxp.com>

1. Add optional serdes-supply regulator property support.
2. Enable 10Gbps feature for the controller, configure netc blkctrl
   CFG_LINK_PCS_PROT_2 to 10G SXGMII.
3. Add internal xpcs phy initialization to 10G XGMII Mode without
   auto-negotiation interface.

Signed-off-by: Ye Li <ye.li@nxp.com>
Signed-off-by: Alice Guo <alice.guo@nxp.com>
---
 drivers/net/fsl_enetc.c          |  57 ++-
 drivers/net/fsl_enetc.h          |   1 +
 drivers/net/fsl_enetc_xpcs_phy.c | 970 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 1017 insertions(+), 11 deletions(-)

diff --git a/drivers/net/fsl_enetc.c b/drivers/net/fsl_enetc.c
index a4ba27904bc..206f1a381bb 100644
--- a/drivers/net/fsl_enetc.c
+++ b/drivers/net/fsl_enetc.c
@@ -8,6 +8,7 @@
 #include <clk.h>
 #include <cpu_func.h>
 #include <dm.h>
+#include <dm/device_compat.h>
 #include <errno.h>
 #include <fdt_support.h>
 #include <malloc.h>
@@ -20,14 +21,21 @@
 #include <linux/bug.h>
 #include <linux/delay.h>
 #include <linux/build_bug.h>
+#include <linux/bitfield.h>
+#include <power/regulator.h>
+#include "fsl_enetc.h"
 
 #ifdef CONFIG_ARCH_IMX9
 #include <asm/mach-imx/sys_proto.h>
 #include <cpu_func.h>
+#include "fsl_enetc_xpcs_phy.c"
+#else
+static inline int xpcs_phy_usxgmii_pma_config(struct udevice *dev)
+{
+	return 0;
+}
 #endif
 
-#include "fsl_enetc.h"
-
 #define ENETC_DRIVER_NAME	"enetc_eth"
 
 /*
@@ -454,19 +462,23 @@ static void enetc_setup_mac_iface(struct udevice *dev,
 /* set up serdes for SXGMII */
 static int enetc_init_sxgmii(struct udevice *dev)
 {
-	struct enetc_priv *priv = dev_get_priv(dev);
-
 	if (!enetc_has_imdio(dev))
 		return 0;
 
-	/* Dev ability - SXGMII */
-	enetc_mdio_write(&priv->imdio, ENETC_PCS_PHY_ADDR, ENETC_PCS_DEVAD_REPL,
-			 ENETC_PCS_DEV_ABILITY, ENETC_PCS_DEV_ABILITY_SXGMII);
+	if (enetc_is_imx95(dev)) {
+		xpcs_phy_usxgmii_pma_config(dev);
+	} else {
+		struct enetc_priv *priv = dev_get_priv(dev);
+
+		/* Dev ability - SXGMII */
+		enetc_mdio_write(&priv->imdio, ENETC_PCS_PHY_ADDR, ENETC_PCS_DEVAD_REPL,
+				 ENETC_PCS_DEV_ABILITY, ENETC_PCS_DEV_ABILITY_SXGMII);
 
-	/* Restart PCS AN */
-	enetc_mdio_write(&priv->imdio, ENETC_PCS_PHY_ADDR, ENETC_PCS_DEVAD_REPL,
-			 ENETC_PCS_CR,
-			 ENETC_PCS_CR_RST | ENETC_PCS_CR_RESET_AN);
+		/* Restart PCS AN */
+		enetc_mdio_write(&priv->imdio, ENETC_PCS_PHY_ADDR, ENETC_PCS_DEVAD_REPL,
+				 ENETC_PCS_CR,
+				 ENETC_PCS_CR_RST | ENETC_PCS_CR_RESET_AN);
+	}
 
 	return 0;
 }
@@ -523,6 +535,10 @@ static int enetc_config_phy(struct udevice *dev)
 		return -ENODEV;
 
 	supported = PHY_GBIT_FEATURES | SUPPORTED_2500baseX_Full;
+
+	if (enetc_is_imx95(dev))
+		supported |= PHY_10G_FEATURES;
+
 	priv->phy->supported &= supported;
 	priv->phy->advertising &= supported;
 
@@ -537,12 +553,31 @@ static int enetc_probe(struct udevice *dev)
 {
 	struct enetc_priv *priv = dev_get_priv(dev);
 	int res;
+	struct udevice *supply = NULL;
 
 	if (ofnode_valid(dev_ofnode(dev)) && !ofnode_is_enabled(dev_ofnode(dev))) {
 		enetc_dbg(dev, "interface disabled\n");
 		return -ENODEV;
 	}
 
+	if (CONFIG_IS_ENABLED(DM_REGULATOR)) {
+		res = device_get_supply_regulator(dev, "serdes-supply",
+						  &supply);
+		if (res  && res  != -ENOENT) {
+			printf("%s: device_get_supply_regulator failed: %d\n",
+			       __func__, res);
+			return res;
+		}
+
+		if (supply) {
+			res = regulator_set_enable_if_allowed(supply, true);
+			if (res) {
+				printf("%s: Error enabling phy supply\n", dev->name);
+				return res;
+			}
+		}
+	}
+
 	priv->enetc_txbd = memalign(ENETC_BD_ALIGN,
 				    sizeof(struct enetc_tx_bd) * ENETC_BD_CNT);
 	priv->enetc_rxbd = memalign(ENETC_BD_ALIGN,
diff --git a/drivers/net/fsl_enetc.h b/drivers/net/fsl_enetc.h
index 804df853bf5..6d868e82f8c 100644
--- a/drivers/net/fsl_enetc.h
+++ b/drivers/net/fsl_enetc.h
@@ -205,6 +205,7 @@ struct enetc_data {
 
 /* PCS / internal SoC PHY ID, it defaults to 0 on all interfaces */
 #define ENETC_PCS_PHY_ADDR	0
+#define ENETC_NON_PCS_PHY_ADDR      16
 
 /* PCS registers */
 #define ENETC_PCS_CR			0x00
diff --git a/drivers/net/fsl_enetc_xpcs_phy.c b/drivers/net/fsl_enetc_xpcs_phy.c
new file mode 100644
index 00000000000..4039690223d
--- /dev/null
+++ b/drivers/net/fsl_enetc_xpcs_phy.c
@@ -0,0 +1,970 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright 2024 NXP
+ */
+
+#define XPCS_PHY_GLOBAL		0x0
+#define XPCS_PHY_MPLLA		0x1
+#define XPCS_PHY_MPLLB		0x2
+#define XPCS_PHY_LANE		0x3
+#define XPCS_PHY_MAC_ADAPTER	0x1f
+
+#define XPCS_PHY_REG(x) (((x) & 0x1fffe) >> 1)
+
+/* MAC ADAPTER */
+#define MAC_ADAPTER_LOCK_PHY	0x200
+#define MAC_ADAPTER_LOCK_MPLLA	0x204
+#define MAC_ADAPTER_LOCK_MPLLB	0x208
+#define MAC_ADAPTER_LOCK_ROM	0x20c
+#define MAC_ADAPTER_LOCK_RAM	0x210
+#define MAC_ADAPTER_LOCK_EVENT	0x214
+
+#define MAC_ADAPTER_LOCK_LOCK	BIT(7)
+
+/* PMA */
+#define PMA_RX_LSTS					0x10040
+#define PMA_RX_LSTS_RX_VALID_0			BIT(12)
+#define PMA_MP_12G_16G_25G_TX_GENCTRL0			0x10060
+#define PMA_TX_GENCTRL0_TX_RST_0		BIT(8)
+#define PMA_TX_GENCTRL0_TX_DT_EN_0		BIT(12)
+#define PMA_MP_12G_16G_25G_TX_GENCTRL1			0x10062
+#define PMA_TX_GENCTRL1_VBOOST_EN_0		BIT(4)
+#define PMA_TX_GENCTRL1_VBOOST_LVL_MASK		GENMASK(10, 8)
+#define PMA_TX_GENCTRL1_VBOOST_LVL(x)		(((x) << 8) & GENMASK(10, 8))
+#define PMA_TX_GENCTRL1_TX_CLK_RDY_0		BIT(12)
+#define PMA_MP_12G_16G_TX_GENCTRL2			0x10064
+#define PMA_TX_GENCTRL2_TX_REQ_0		BIT(0)
+#define PMA_TX_GENCTRL2_TX0_WIDTH_MASK		GENMASK(9, 8)
+#define PMA_TX_GENCTRL2_TX0_WIDTH(x)		(((x) << 8) & GENMASK(9, 8))
+#define PMA_MP_12G_16G_25G_TX_BOOST_CTRL		0x10066
+#define PMA_TX_BOOST_CTRL_TX0_IBOOST_MASK	GENMASK(3, 0)
+#define PMA_TX_BOOST_CTRL_TX0_IBOOST(x)		((x) & GENMASK(3, 0))
+#define PMA_MP_12G_16G_25G_TX_RATE_CTRL			0x10068
+#define PMA_TX_RATE_CTRL_TX0_RATE_MASK		GENMASK(2, 0)
+#define PMA_TX_RATE_CTRL_TX0_RATE(x)		((x) & GENMASK(2, 0))
+#define PMA_MP_12G_16G_25G_TX_POWER_STATE_CTRL		0x1006A
+#define PMA_POWER_STATE_CTRL_TX0_PSTATE_MASK	GENMASK(1, 0)
+#define PMA_POWER_STATE_CTRL_TX0_PSTATE(x)	((x) & GENMASK(1, 0))
+#define PMA_POWER_STATE_CTRL_TX_DISABLE_0	BIT(8)
+#define PMA_MP_12G_16G_25G_TX_EQ_CTRL0			0x1006C
+#define PMA_TX_EQ_CTRL0_TX_EQ_PRE_MASK		GENMASK(5, 0)
+#define PMA_TX_EQ_CTRL0_TX_EQ_PRE(x)		((x) & GENMASK(5, 0))
+#define PMA_TX_EQ_CTRL0_TX_EQ_MAIN_MASK		GENMASK(13, 8)
+#define PMA_TX_EQ_CTRL0_TX_EQ_MAIN(x)		(((x) << 8) & GENMASK(13, 8))
+#define PMA_MP_12G_16G_25G_TX_EQ_CTRL1			0x1006E
+#define PMA_TX_EQ_CTRL1_TX_EQ_POST_MASK		GENMASK(5, 0)
+#define PMA_TX_EQ_CTRL1_TX_EQ_POST(x)		((x) & GENMASK(5, 0))
+#define PMA_MP_16G_25G_TX_MISC_CTRL0			0x1007C
+#define PMA_TX_MISC_CTRL0_TX0_MISC_MASK		GENMASK(7, 0)
+#define PMA_TX_MISC_CTRL0_TX0_MISC(x)		((x) & GENMASK(7, 0))
+#define PMA_MP_12G_16G_25G_RX_GENCTRL0			0x100A0
+#define PMA_RX_GENCTRL0_RX_DT_EN_0		BIT(8)
+#define PMA_MP_12G_16G_25G_RX_GENCTRL1			0x100A2
+#define PMA_RX_GENCTRL1_RX_RST_0		BIT(4)
+#define PMA_RX_GENCTRL1_RX_TERM_ACDC_0		BIT(8)
+#define PMA_RX_GENCTRL1_RX_DIV16P5_CLK_EN_0	BIT(12)
+#define PMA_MP_12G_16G_RX_GENCTRL2			0x100A4
+#define PMA_RX_GENCTRL2_RX_REQ_0		BIT(0)
+#define PMA_RX_GENCTRL2_RX0_WIDTH_MASK		GENMASK(9, 8)
+#define PMA_RX_GENCTRL2_RX0_WIDTH(x)		(((x) << 8) & GENMASK(9, 8))
+#define PMA_MP_12G_16G_RX_GENCTRL3			0x100A6
+#define PMA_RX_GENCTRL3_LOS_TRSHLD_0_MASK	GENMASK(2, 0)
+#define PMA_RX_GENCTRL3_LOS_TRSHLD_0(x)		((x) & GENMASK(2, 0))
+#define PMA_RX_GENCTRL3_LOS_LFPS_EN_0		BIT(12)
+#define PMA_MP_12G_16G_25G_RX_RATE_CTRL			0x100A8
+#define PMA_RX_RATE_CTRL_RX0_RATE_MASK		GENMASK(1, 0)
+#define PMA_RX_RATE_CTRL_RX0_RATE(x)		((x) & GENMASK(1, 0))
+#define PMA_MP_12G_16G_25G_RX_POWER_STATE_CTRL		0x100AA
+#define PMA_RX_POWER_STATE_CTRL_RX0_PSTATE_MASK	GENMASK(1, 0)
+#define PMA_RX_POWER_STATE_CTRL_RX0_PSTATE(x)	((x) & GENMASK(1, 0))
+#define PMA_RX_POWER_STATE_CTRL_RX_DISABLE_0	BIT(8)
+#define PMA_MP_12G_16G_25G_RX_CDR_CTRL			0x100AC
+#define PMA_RX_CDR_CTRL_CDR_SSC_EN_0		BIT(4)
+#define PMA_MP_12G_16G_25G_RX_ATTN_CTRL			0x100AE
+#define PMA_RX_ATTN_CTRL_RX0_EQ_ATT_LVL_MASK	GENMASK(2, 0)
+#define PMA_RX_ATTN_CTRL_RX0_EQ_ATT_LVL(x)	((x) & GENMASK(2, 0))
+#define PMA_MP_16G_25G_RX_EQ_CTRL0			0x100B0
+#define PMA_RX_EQ_CTRL0_CTLE_BOOST_0_MASK	GENMASK(4, 0)
+#define PMA_RX_EQ_CTRL0_CTLE_BOOST_0(x)		((x) & GENMASK(4, 0))
+#define PMA_RX_EQ_CTRL0_CTLE_POLE_0_MASK	GENMASK(6, 5)
+#define PMA_RX_EQ_CTRL0_CTLE_POLE_0(x)		(((x) << 5) & GENMASK(6, 5))
+#define PMA_RX_EQ_CTRL0_VGA2_GAIN_0_MASK	GENMASK(10, 8)
+#define PMA_RX_EQ_CTRL0_VGA2_GAIN_0(x)		(((x) << 8) & GENMASK(10, 8))
+#define PMA_RX_EQ_CTRL0_VGA1_GAIN_0_MASK	GENMASK(14, 12)
+#define PMA_RX_EQ_CTRL0_VGA1_GAIN_0(x)		(((x) << 12) & GENMASK(14, 12))
+#define PMA_MP_12G_16G_25G_RX_EQ_CTRL4			0x100B8
+#define PMA_RX_EQ_CTRL4_CONT_ADAPT_0		BIT(0)
+#define PMA_RX_EQ_CTRL4_RX_AD_REQ		BIT(12)
+#define PMA_MP_16G_25G_RX_EQ_CTRL5			0x100BA
+#define PMA_RX_EQ_CTRL5_RX_ADPT_SEL_0		BIT(0)
+#define PMA_RX_EQ_CTRL5_RX0_ADPT_MODE_MASK	GENMASK(5, 4)
+#define PMA_RX_EQ_CTRL5_RX0_ADPT_MODE(x)	(((x) << 4) & GENMASK(5, 4))
+#define PMA_MP_12G_16G_25G_DFE_TAP_CTRL0		0x100BC
+#define PMA_DFE_TAP_CTRL0_DFE_TAP1_0_MASK	GENMASK(7, 0)
+#define PMA_DFE_TAP_CTRL0_DFE_TAP1_0(x)		((x) & GENMASK(7, 0))
+#define PMA_MP_16G_RX_CDR_CTRL1				0x100C8
+#define PMA_RX_CDR_CTRL1_VCO_TEMP_COMP_EN_0	BIT(0)
+#define PMA_RX_CDR_CTRL1_VCO_STEP_CTRL_0	BIT(4)
+#define PMA_RX_CDR_CTRL1_VCO_FRQBAND_0_MASK	GENMASK(9, 8)
+#define PMA_RX_CDR_CTRL1_VCO_FRQBAND_0(x)	(((x) << 8) & GENMASK(9, 8))
+#define PMA_MP_16G_25G_RX_PPM_CTRL0			0x100CA
+#define PMA_RX_PPM_CTRL0_RX0_CDR_PPM_MAX_MASK	GENMASK(4, 0)
+#define PMA_RX_PPM_CTRL0_RX0_CDR_PPM_MAX(x)	((x) & GENMASK(4, 0))
+#define PMA_MP_16G_25G_RX_GENCTRL4			0x100D0
+#define PMA_RX_GENCTRL4_RX_DFE_BYP_0		BIT(8)
+#define PMA_MP_16G_25G_RX_MISC_CTRL0			0x100D2
+#define PMA_RX_MISC_CTRL0_RX0_MISC_MASK		GENMASK(7, 0)
+#define PMA_RX_MISC_CTRL0_RX0_MISC(x)		((x) & GENMASK(7, 0))
+#define PMA_MP_16G_25G_RX_IQ_CTRL0			0x100D6
+#define PMA_RX_IQ_CTRL0_RX0_MARGIN_IQ_MASK	GENMASK(6, 0)
+#define PMA_RX_IQ_CTRL0_RX0_MARGIN_IQ(x)	((x) & GENMASK(6, 0))
+#define PMA_RX_IQ_CTRL0_RX0_DELTA_IQ_MASK	GENMASK(11, 8)
+#define PMA_RX_IQ_CTRL0_RX0_DELTA_IQ(x)		(((x) << 8) & GENMASK(11, 8))
+#define PMA_MP_12G_16G_25G_MPLL_CMN_CTRL		0x100E0
+#define PMA_MPLL_CMN_CTRL_MPLL_EN_0		BIT(0)
+#define PMA_MPLL_CMN_CTRL_MPLLB_SEL_0		BIT(4)
+#define PMA_MP_12G_16G_MPLLA_CTRL0			0x100E2
+#define PMA_MPLLA_CTRL0_MPLLA_MULTIPLIER_MASK	GENMASK(7, 0)
+#define PMA_MPLLA_CTRL0_MPLLA_MULTIPLIER(x)	((x) & GENMASK(7, 0))
+#define PMA_MP_16G_MPLLA_CTRL1				0x100E4
+#define PMA_MPLLA_CTRL1_MPLLA_SSC_EN		BIT(0)
+#define PMA_MPLLA_CTRL1_MPLLA_SSC_CLK_SEL	BIT(4)
+#define PMA_MPLLA_CTRL1_MPLLA_FRACN_CTRL_MASK	GENMASK(15, 5)
+#define PMA_MPLLA_CTRL1_MPLLA_FRACN_CTRL(x)	(((x) << 5) & GENMASK(15, 5))
+#define PMA_MP_12G_16G_MPLLA_CTRL2			0x100E6
+#define PMA_MPLLA_CTRL2_MPLLA_DIV_MULT_MASK	GENMASK(6, 0)
+#define PMA_MPLLA_CTRL2_MPLLA_DIV_MULT(x)	((x) & GENMASK(6, 0))
+#define PMA_MPLLA_CTRL2_MPLLA_DIV_CLK_EN	BIT(7)
+#define PMA_MPLLA_CTRL2_MPLLA_DIV8_CLK_EN	BIT(8)
+#define PMA_MPLLA_CTRL2_MPLLA_DIV10_CLK_EN	BIT(9)
+#define PMA_MPLLA_CTRL2_MPLLA_DIV16P5_CLK_EN	BIT(10)
+#define PMA_MPLLA_CTRL2_MPLLA_TX_CLK_DIV_MASK	GENMASK(12, 11)
+#define PMA_MPLLA_CTRL2_MPLLA_TX_CLK_DIV(x)	(((x) << 11) & GENMASK(12, 11))
+#define PMA_MP_16G_MPLLA_CTRL3				0x100EE
+#define PMA_MPLLA_CTRL3_MPLLA_BANDWIDTH_MASK	GENMASK(15, 0)
+#define PMA_MPLLA_CTRL3_MPLLA_BANDWIDTH(x)	((x) & GENMASK(15, 0))
+#define PMA_MP_16G_MPLLA_CTRL4				0x100F2
+#define PMA_MPLLA_CTRL4_MPLLA_SSC_FRQ_CNT_INT_MASK GENMASK(11, 0)
+#define PMA_MPLLA_CTRL4_MPLLA_SSC_FRQ_CNT_INT(x) ((x) & GENMASK(11, 0))
+#define PMA_MP_16G_MPLLA_CTRL5				0x100F4
+#define PMA_MPLLA_CTRL5_MPLLA_SSC_FRQ_CNT_PK_MASK GENMASK(7, 0)
+#define PMA_MPLLA_CTRL5_MPLLA_SSC_FRQ_CNT_PK(x)	((x) & GENMASK(7, 0))
+#define PMA_MPLLA_CTRL5_MPLLA_SSC_SPD_EN	BIT(8)
+#define PMA_MP_12G_16G_25G_MISC_CTRL0			0x10120
+#define PMA_MISC_CTRL0_RX_VREF_CTRL_MASK	GENMASK(12, 8)
+#define PMA_MISC_CTRL0_RX_VREF_CTRL(x)		(((x) << 8) & GENMASK(12, 8))
+#define PMA_MP_12G_16G_25G_REF_CLK_CTRL			0x10122
+#define PMA_REF_CLK_CTRL_REF_CLK_DIV2		BIT(2)
+#define PMA_REF_CLK_CTRL_REF_RANGE_MASK		GENMASK(5, 3)
+#define PMA_REF_CLK_CTRL_REF_RANGE(x)		(((x) << 3) & GENMASK(5, 3))
+#define PMA_REF_CLK_CTRL_REF_MPLLA_DIV2		BIT(6)
+#define PMA_MP_12G_16G_25G_VCO_CAL_LD0			0x10124
+#define PMA_VCO_CAL_LD0_VCO_LD_VAL_0_MASK	GENMASK(12, 0)
+#define PMA_VCO_CAL_LD0_VCO_LD_VAL_0(x)		((x) & GENMASK(12, 0))
+#define PMA_MP_16G_25G_VCO_CAL_REF0			0x1012C
+#define PMA_VCO_CAL_REF0_VCO_REF_LD_0_MASK	GENMASK(6, 0)
+#define PMA_VCO_CAL_REF0_VCO_REF_LD_0(x)	((x) & GENMASK(6, 0))
+#define PMA_MP_12G_16G_25G_MISC_STS			0x10130
+#define PMA_MISC_STS_RX_ADPT_ACK		BIT(12)
+#define PMA_MP_12G_16G_25G_SRAM				0x10136
+#define PMA_SRAM_INIT_DN			BIT(0)
+#define PMA_SRAM_EXT_LD_DN			BIT(1)
+#define PMA_MP_16G_25G_MISC_CTRL2			0x10138
+#define PMA_MISC_CTRL2_SUP_MISC_MASK		GENMASK(7, 0)
+#define PMA_MISC_CTRL2_SUP_MISC(x)		((x) & GENMASK(7, 0))
+
+/* PCS */
+#define PCS_CTRL1				0x0
+#define PCS_CTRL1_RESET			BIT(15)
+#define PCS_CTRL2				0xE
+#define PCS_CTRL2_PCS_TYPE_SEL_MASK	GENMASK(3, 0)
+#define PCS_CTRL2_PCS_TYPE_SEL(x)	((x) & GENMASK(3, 0))
+#define PCS_DIG_CTRL1				0x10000
+#define PCS_DIG_CTRL1_USXG_EN		BIT(9)
+#define PCS_DIG_CTRL1_USRA_RST		BIT(10)
+#define PCS_DIG_CTRL1_VR_RST		BIT(15)
+#define PCS_DEBUG_CTRL				0x1000A
+#define PCS_DEBUG_CTRL_SUPRESS_LOS_DET	BIT(4)
+#define PCS_DEBUG_CTRL_RX_DT_EN_CTL	BIT(6)
+#define PCS_DEBUG_CTRL_TX_PMBL_CTL	BIT(8)
+#define PCS_KR_CTRL1				0x1000E
+#define PCS_KR_CTRL1_USXG_MODE_MASK	GENMASK(12, 10)
+#define PCS_KR_CTRL1_USXG_MODE(x)	(((x) << 10) & GENMASK(12, 10))
+
+/* VS MII MMD */
+#define MII_CTRL					0x0
+#define MII_CTRL_SS5				BIT(5)
+#define MII_CTRL_SS6				BIT(6)
+#define MII_CTRL_AN_ENABLE			BIT(12)
+#define MII_CTRL_SS13				BIT(13)
+#define MII_DIG_CTRL1					0x10000
+#define MII_DIG_CTRL1_CL37_TMR_OVR_RIDE		BIT(3)
+#define MII_AN_CTRL					0x10002
+#define MII_AN_CTRL_MII_AN_INTR_EN		BIT(0)
+#define MII_AN_CTRL_TX_CONFIG			BIT(3)
+#define MII_AN_INTR_STS					0x10004
+#define MII_AN_INTR_STS_CL37_ANCMPLT_INTR	BIT(0)
+#define MII_LINK_TIMER_CTRL				0x10014
+#define MII_LINK_TIMER_CTRL_CL37_LINK_TIME_MASK		GENMASK(15, 0)
+#define MII_LINK_TIMER_CTRL_CL37_LINK_TIME(x)		((x) & GENMASK(15, 0))
+
+/* E16 MEM MAP */
+#define IDCODE_LO						0x0
+#define IDCODE_HI						0x4
+#define GLOBAL_CTRL_EX_0					0x114
+#define GLOBAL_CTRL_EX_0_PHY_SRAM_BYPASS		BIT(0)
+#define L0_RX_VCO_OVRD_OUT_0					0x20c
+#define L0_RX_VCO_OVRD_OUT_0_RX_ANA_CDR_FREQ_TUNE_MASK	GENMASK(12, 3)
+#define L0_RX_VCO_OVRD_OUT_0_RX_ANA_CDR_FREQ_TUNE(x)	(((x) << 3) & GENMASK(12, 3))
+#define L0_RX_VCO_OVRD_OUT_0_RX_CDR_FREQ_TUNE_OVRD_EN	BIT(15)
+#define L0_RX_VCO_OVRD_OUT_2					0x214
+#define L0_RX_VCO_OVRD_OUT_2_RX_ANA_CDR_FREQ_TUNE_CLK	BIT(0)
+
+static int enetc_mdio_read(struct mii_dev *bus, int addr, int devad, int reg);
+static int enetc_mdio_write(struct mii_dev *bus, int addr, int devad, int reg, u16 val);
+
+int xpcs_read(struct udevice *dev, int devaddr, u32 reg)
+{
+	struct enetc_priv *priv = dev_get_priv(dev);
+
+	return enetc_mdio_read(&priv->imdio, ENETC_PCS_PHY_ADDR, devaddr, reg);
+}
+
+int xpcs_write(struct udevice *dev, int devaddr, u32 reg, u16 val)
+{
+	struct enetc_priv *priv = dev_get_priv(dev);
+
+	return enetc_mdio_write(&priv->imdio, ENETC_PCS_PHY_ADDR, devaddr, reg, val);
+}
+
+int xpcs_phy_read(struct udevice *dev, int devaddr, u32 reg)
+{
+	struct enetc_priv *priv = dev_get_priv(dev);
+
+	return enetc_mdio_read(&priv->imdio, ENETC_NON_PCS_PHY_ADDR, devaddr, reg);
+}
+
+int xpcs_phy_write(struct udevice *dev, int devaddr, u32 reg, u16 val)
+{
+	struct enetc_priv *priv = dev_get_priv(dev);
+
+	return enetc_mdio_write(&priv->imdio, ENETC_NON_PCS_PHY_ADDR, devaddr, reg, val);
+}
+
+int xpcs_phy_read_pma(struct udevice *dev, u32 reg)
+{
+	return xpcs_read(dev, MDIO_MMD_PMAPMD, XPCS_PHY_REG(reg));
+}
+
+int xpcs_phy_write_pma(struct udevice *dev, int reg, u16 val)
+{
+	return xpcs_write(dev, MDIO_MMD_PMAPMD, XPCS_PHY_REG(reg), val);
+}
+
+int xpcs_phy_usxgmii_init_seq_2(struct udevice *dev)
+{
+	ulong begin;
+	u16 val;
+
+	/* Seq 2.1 Keep preamble data */
+	val = xpcs_read(dev, MDIO_MMD_PCS, XPCS_PHY_REG(PCS_DEBUG_CTRL));
+	val |= PCS_DEBUG_CTRL_TX_PMBL_CTL;
+	xpcs_write(dev, MDIO_MMD_PCS, XPCS_PHY_REG(PCS_DEBUG_CTRL), val);
+
+	/* Seq 2.2 Power up MPLLA to P1 state */
+	val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_25G_TX_POWER_STATE_CTRL);
+	val = u16_replace_bits(val, 2, PMA_POWER_STATE_CTRL_TX0_PSTATE_MASK);
+	xpcs_phy_write_pma(dev, PMA_MP_12G_16G_25G_TX_POWER_STATE_CTRL, val);
+
+	val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_25G_MPLL_CMN_CTRL);
+	val |= PMA_MPLL_CMN_CTRL_MPLL_EN_0;
+	xpcs_phy_write_pma(dev, PMA_MP_12G_16G_25G_MPLL_CMN_CTRL, val);
+
+	/* Seq 2.3 Assert request of transmitand receive */
+	val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_TX_GENCTRL2);
+	val |= PMA_TX_GENCTRL2_TX_REQ_0;
+	xpcs_phy_write_pma(dev, PMA_MP_12G_16G_TX_GENCTRL2, val);
+
+	val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_RX_GENCTRL2);
+	val |= PMA_RX_GENCTRL2_RX_REQ_0;
+	xpcs_phy_write_pma(dev, PMA_MP_12G_16G_RX_GENCTRL2, val);
+
+	/* Seq 2.4 Poll for acknowledge */
+	begin = get_timer(0);
+	do {
+		val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_TX_GENCTRL2);
+		if (get_timer(begin) > 500) {
+			dev_err(dev, "Polling timeout, line: %d\n", __LINE__);
+			goto timeout;
+		}
+		mdelay(10);
+	} while (val & PMA_TX_GENCTRL2_TX_REQ_0);
+
+	begin = get_timer(0);
+	do {
+		val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_RX_GENCTRL2);
+		if (get_timer(begin) > 500) {
+			dev_err(dev, "Polling timeout, line: %d\n", __LINE__);
+			goto timeout;
+		}
+		mdelay(10);
+	} while (val & PMA_RX_GENCTRL2_RX_REQ_0);
+
+	/* Seq 2.5 Turn transmit to P0 state */
+	val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_25G_TX_POWER_STATE_CTRL);
+	val = u16_replace_bits(val, 0, PMA_POWER_STATE_CTRL_TX0_PSTATE_MASK);
+	xpcs_phy_write_pma(dev, PMA_MP_12G_16G_25G_TX_POWER_STATE_CTRL, val);
+
+	val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_25G_TX_GENCTRL0);
+	val &= ~PMA_TX_GENCTRL0_TX_RST_0;
+	xpcs_phy_write_pma(dev, PMA_MP_12G_16G_25G_TX_GENCTRL0, val);
+
+	val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_25G_TX_POWER_STATE_CTRL);
+	val &= ~PMA_POWER_STATE_CTRL_TX_DISABLE_0;
+	xpcs_phy_write_pma(dev, PMA_MP_12G_16G_25G_TX_POWER_STATE_CTRL, val);
+
+	val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_25G_MPLL_CMN_CTRL);
+	val |= PMA_MPLL_CMN_CTRL_MPLL_EN_0;
+	xpcs_phy_write_pma(dev, PMA_MP_12G_16G_25G_MPLL_CMN_CTRL, val);
+
+	/* Seq 2.6 Turn receive to P0 state */
+	val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_25G_RX_GENCTRL1);
+	val &= ~PMA_RX_GENCTRL1_RX_RST_0;
+	xpcs_phy_write_pma(dev, PMA_MP_12G_16G_25G_RX_GENCTRL1, val);
+
+	val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_25G_RX_POWER_STATE_CTRL);
+	val &= ~PMA_RX_POWER_STATE_CTRL_RX0_PSTATE_MASK;
+	val &= ~PMA_RX_POWER_STATE_CTRL_RX_DISABLE_0;
+	xpcs_phy_write_pma(dev, PMA_MP_12G_16G_25G_RX_POWER_STATE_CTRL, val);
+
+	val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_25G_RX_POWER_STATE_CTRL);
+	val &= ~PMA_RX_POWER_STATE_CTRL_RX0_PSTATE_MASK;
+	val &= ~PMA_RX_POWER_STATE_CTRL_RX_DISABLE_0;
+	xpcs_phy_write_pma(dev, PMA_MP_12G_16G_25G_RX_POWER_STATE_CTRL, val);
+
+	/* Seq 2.7 Enable transmitter output driver in the PHY */
+	val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_25G_TX_GENCTRL0);
+	val |= PMA_TX_GENCTRL0_TX_DT_EN_0;
+	xpcs_phy_write_pma(dev, PMA_MP_12G_16G_25G_TX_GENCTRL0, val);
+
+	/* Seq 2.8 Enable receiver data output from PHY */
+	val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_25G_RX_GENCTRL0);
+	val |= PMA_RX_GENCTRL0_RX_DT_EN_0;
+	xpcs_phy_write_pma(dev, PMA_MP_12G_16G_25G_RX_GENCTRL0, val);
+
+	/* Seq 2.9 Assert request of transmit and receive */
+	val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_TX_GENCTRL2);
+	val |= PMA_TX_GENCTRL2_TX_REQ_0;
+	xpcs_phy_write_pma(dev, PMA_MP_12G_16G_TX_GENCTRL2, val);
+
+	val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_RX_GENCTRL2);
+	val |= PMA_RX_GENCTRL2_RX_REQ_0;
+	xpcs_phy_write_pma(dev, PMA_MP_12G_16G_RX_GENCTRL2, val);
+
+	/* Seq 2.10 Poll for acknowledge */
+	begin = get_timer(0);
+	do {
+		val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_TX_GENCTRL2);
+		if (get_timer(begin) > 500) {
+			dev_err(dev, "Polling timeout, line: %d\n", __LINE__);
+			goto timeout;
+		}
+		mdelay(10);
+		schedule();
+	} while (val & PMA_TX_GENCTRL2_TX_REQ_0);
+
+	begin = get_timer(0);
+	do {
+		val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_RX_GENCTRL2);
+		if (get_timer(begin) > 500) {
+			dev_err(dev, "Polling timeout, line: %d\n", __LINE__);
+			goto timeout;
+		}
+		mdelay(10);
+		schedule();
+	} while (val & PMA_RX_GENCTRL2_RX_REQ_0);
+
+	return 0;
+
+timeout:
+	return -ETIMEDOUT;
+}
+
+void xpcs_phy_reg_lock(struct udevice *dev)
+{
+	u16 val;
+	ulong begin;
+
+	if (xpcs_phy_read(dev, XPCS_PHY_MAC_ADAPTER, XPCS_PHY_REG(MAC_ADAPTER_LOCK_PHY)) & MAC_ADAPTER_LOCK_LOCK)
+		return;
+
+	xpcs_phy_write(dev, XPCS_PHY_MAC_ADAPTER, XPCS_PHY_REG(MAC_ADAPTER_LOCK_PHY), MAC_ADAPTER_LOCK_LOCK);
+	xpcs_phy_write(dev, XPCS_PHY_MAC_ADAPTER, XPCS_PHY_REG(MAC_ADAPTER_LOCK_MPLLA), MAC_ADAPTER_LOCK_LOCK);
+	xpcs_phy_write(dev, XPCS_PHY_MAC_ADAPTER, XPCS_PHY_REG(MAC_ADAPTER_LOCK_MPLLB), MAC_ADAPTER_LOCK_LOCK);
+	xpcs_phy_write(dev, XPCS_PHY_MAC_ADAPTER, XPCS_PHY_REG(MAC_ADAPTER_LOCK_ROM), MAC_ADAPTER_LOCK_LOCK);
+	xpcs_phy_write(dev, XPCS_PHY_MAC_ADAPTER, XPCS_PHY_REG(MAC_ADAPTER_LOCK_RAM), MAC_ADAPTER_LOCK_LOCK);
+
+	begin = get_timer(0);
+	do {
+		val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_25G_SRAM);
+		if (get_timer(begin) > 500) {
+			dev_err(dev, "Polling timeout, line: %d\n", __LINE__);
+			goto timeout;
+		}
+		mdelay(10);
+	} while (!(val & PMA_SRAM_INIT_DN));
+
+	/* Work around */
+	// xpcs_phy_write_pma(dev, PMA_MP_12G_16G_25G_SRAM, PMA_SRAM_EXT_LD_DN);
+	xpcs_phy_write(dev, XPCS_PHY_GLOBAL, XPCS_PHY_REG(GLOBAL_CTRL_EX_0), GLOBAL_CTRL_EX_0_PHY_SRAM_BYPASS);
+
+	begin = get_timer(0);
+	do {
+		val = xpcs_read(dev, MDIO_MMD_PCS, XPCS_PHY_REG(PCS_CTRL1));
+		if (get_timer(begin) > 500) {
+			dev_err(dev, "Polling timeout, line: %d\n", __LINE__);
+			goto timeout;
+		}
+		mdelay(10);
+	} while (val & PCS_CTRL1_RESET);
+
+	mdelay(1);
+
+timeout:
+	return;
+}
+
+int xpcs_phy_usxgmii_pma_config(struct udevice *dev)
+{
+	ulong begin;
+	u16 val;
+
+	xpcs_phy_reg_lock(dev);
+
+	/* 1.6 Turn off C37 auto-negotiation */
+	val = xpcs_read(dev, MDIO_MMD_VEND2, XPCS_PHY_REG(MII_CTRL));
+	val &= ~MII_CTRL_AN_ENABLE;
+	xpcs_write(dev, MDIO_MMD_VEND2, XPCS_PHY_REG(MII_CTRL), val);
+
+	/* 1.7 Assert tx_reset and rx_reset*/
+	val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_25G_TX_GENCTRL0);
+	val |= PMA_TX_GENCTRL0_TX_RST_0;
+	xpcs_phy_write_pma(dev, PMA_MP_12G_16G_25G_TX_GENCTRL0, val);
+
+	val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_25G_RX_GENCTRL1);
+	val |= PMA_RX_GENCTRL1_RX_RST_0;
+	xpcs_phy_write_pma(dev, PMA_MP_12G_16G_25G_RX_GENCTRL1, val);
+
+	/* 1.8 Wait for more than 1us */
+	udelay(5);
+
+	/* 1.9 Deassert tx_reset and rx_reset*/
+	val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_25G_TX_GENCTRL0);
+	val &= ~PMA_TX_GENCTRL0_TX_RST_0;
+	xpcs_phy_write_pma(dev, PMA_MP_12G_16G_25G_TX_GENCTRL0, val);
+
+	val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_25G_RX_GENCTRL1);
+	val &= ~PMA_RX_GENCTRL1_RX_RST_0;
+	xpcs_phy_write_pma(dev, PMA_MP_12G_16G_25G_RX_GENCTRL1, val);
+
+	/* 1.10 Power down MPLLA */
+	val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_25G_TX_POWER_STATE_CTRL);
+	val = u16_replace_bits(val, 3, PMA_POWER_STATE_CTRL_TX0_PSTATE_MASK);
+	xpcs_phy_write_pma(dev, PMA_MP_12G_16G_25G_TX_POWER_STATE_CTRL, val);
+
+	val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_25G_MPLL_CMN_CTRL);
+	val &= ~PMA_MPLL_CMN_CTRL_MPLL_EN_0;
+	xpcs_phy_write_pma(dev, PMA_MP_12G_16G_25G_MPLL_CMN_CTRL, val);
+
+	val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_25G_TX_GENCTRL0);
+	val &= ~PMA_TX_GENCTRL0_TX_DT_EN_0;
+	xpcs_phy_write_pma(dev, PMA_MP_12G_16G_25G_TX_GENCTRL0, val);
+
+	/* 1.11 Change RX0 power state to P2 */
+	val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_25G_RX_GENCTRL0);
+	val &= ~PMA_RX_GENCTRL0_RX_DT_EN_0;
+	xpcs_phy_write_pma(dev, PMA_MP_12G_16G_25G_RX_GENCTRL0, val);
+
+	/* TODO: check if it is needed */
+	val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_25G_RX_POWER_STATE_CTRL);
+	val = u16_replace_bits(val, 1, PMA_RX_POWER_STATE_CTRL_RX0_PSTATE_MASK);
+	xpcs_phy_write_pma(dev, PMA_MP_12G_16G_25G_RX_POWER_STATE_CTRL, val);
+
+	val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_25G_RX_POWER_STATE_CTRL);
+	val = u16_replace_bits(val, 3, PMA_RX_POWER_STATE_CTRL_RX0_PSTATE_MASK);
+	xpcs_phy_write_pma(dev, PMA_MP_12G_16G_25G_RX_POWER_STATE_CTRL, val);
+
+	/* 1.12 Assert request of transmit and receive */
+	val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_TX_GENCTRL2);
+	val |= PMA_TX_GENCTRL2_TX_REQ_0;
+	xpcs_phy_write_pma(dev, PMA_MP_12G_16G_TX_GENCTRL2, val);
+
+	val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_RX_GENCTRL2);
+	val |= PMA_RX_GENCTRL2_RX_REQ_0;
+	xpcs_phy_write_pma(dev, PMA_MP_12G_16G_RX_GENCTRL2, val);
+
+	/* 1.13 Poll for acknlowledge */
+	begin = get_timer(0);
+	do {
+		val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_TX_GENCTRL2);
+		if (get_timer(begin) > 500) {
+			dev_err(dev, "Polling timeout, line: %d\n", __LINE__);
+			goto timeout;
+		}
+		mdelay(10);
+	} while (val & PMA_TX_GENCTRL2_TX_REQ_0);
+
+	begin = get_timer(0);
+	do {
+		val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_RX_GENCTRL2);
+		if (get_timer(begin) > 500) {
+			dev_err(dev, "Polling timeout, line: %d\n", __LINE__);
+			goto timeout;
+		}
+		mdelay(10);
+	} while (val & PMA_RX_GENCTRL2_RX_REQ_0);
+
+	/* 2 Config MPLL for 10G XGMII */
+	val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_25G_REF_CLK_CTRL);
+	val = u16_replace_bits(val, 6, PMA_REF_CLK_CTRL_REF_RANGE_MASK);
+	xpcs_phy_write_pma(dev, PMA_MP_12G_16G_25G_REF_CLK_CTRL, val);
+
+	val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_25G_REF_CLK_CTRL);
+	val &= ~PMA_REF_CLK_CTRL_REF_CLK_DIV2;
+	xpcs_phy_write_pma(dev, PMA_MP_12G_16G_25G_REF_CLK_CTRL, val);
+
+	val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_25G_REF_CLK_CTRL);
+	val |= PMA_REF_CLK_CTRL_REF_MPLLA_DIV2;
+	xpcs_phy_write_pma(dev, PMA_MP_12G_16G_25G_REF_CLK_CTRL, val);
+
+	val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_MPLLA_CTRL2);
+	val &= ~PMA_MPLLA_CTRL2_MPLLA_DIV8_CLK_EN;
+	xpcs_phy_write_pma(dev, PMA_MP_12G_16G_MPLLA_CTRL2, val);
+
+	val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_MPLLA_CTRL2);
+	val |= PMA_MPLLA_CTRL2_MPLLA_DIV10_CLK_EN;
+	xpcs_phy_write_pma(dev, PMA_MP_12G_16G_MPLLA_CTRL2, val);
+
+	val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_MPLLA_CTRL2);
+	val |= PMA_MPLLA_CTRL2_MPLLA_DIV16P5_CLK_EN;
+	xpcs_phy_write_pma(dev, PMA_MP_12G_16G_MPLLA_CTRL2, val);
+
+	val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_MPLLA_CTRL2);
+	val &= ~PMA_MPLLA_CTRL2_MPLLA_TX_CLK_DIV_MASK;
+	xpcs_phy_write_pma(dev, PMA_MP_12G_16G_MPLLA_CTRL2, val);
+
+	val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_MPLLA_CTRL2);
+	val |= PMA_MPLLA_CTRL2_MPLLA_DIV_CLK_EN;
+	xpcs_phy_write_pma(dev, PMA_MP_12G_16G_MPLLA_CTRL2, val);
+
+	val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_MPLLA_CTRL2);
+	val = u16_replace_bits(val, 5, PMA_MPLLA_CTRL2_MPLLA_DIV_MULT_MASK);
+	xpcs_phy_write_pma(dev, PMA_MP_12G_16G_MPLLA_CTRL2, val);
+
+	val = xpcs_phy_read_pma(dev, PMA_MP_16G_MPLLA_CTRL1);
+	val &= ~PMA_MPLLA_CTRL1_MPLLA_SSC_EN;
+	xpcs_phy_write_pma(dev, PMA_MP_16G_MPLLA_CTRL1, val);
+
+	val = xpcs_phy_read_pma(dev, PMA_MP_16G_MPLLA_CTRL1);
+	val &= ~PMA_MPLLA_CTRL1_MPLLA_SSC_CLK_SEL;
+	xpcs_phy_write_pma(dev, PMA_MP_16G_MPLLA_CTRL1, val);
+
+	val = xpcs_phy_read_pma(dev, PMA_MP_16G_MPLLA_CTRL5);
+	val &= ~PMA_MPLLA_CTRL5_MPLLA_SSC_FRQ_CNT_PK_MASK;
+	xpcs_phy_write_pma(dev, PMA_MP_16G_MPLLA_CTRL5, val);
+
+	xpcs_phy_write_pma(dev, PMA_MP_16G_MPLLA_CTRL4, 0);
+
+	val = xpcs_phy_read_pma(dev, PMA_MP_16G_MPLLA_CTRL5);
+	val &= ~PMA_MPLLA_CTRL5_MPLLA_SSC_SPD_EN;
+	xpcs_phy_write_pma(dev, PMA_MP_16G_MPLLA_CTRL5, val);
+
+	val = xpcs_phy_read_pma(dev, PMA_MP_16G_MPLLA_CTRL1);
+	val &= ~PMA_MPLLA_CTRL1_MPLLA_FRACN_CTRL_MASK;
+	xpcs_phy_write_pma(dev, PMA_MP_16G_MPLLA_CTRL1, val);
+
+	val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_MPLLA_CTRL0);
+	val = u16_replace_bits(val, 33, PMA_MPLLA_CTRL0_MPLLA_MULTIPLIER_MASK);
+	xpcs_phy_write_pma(dev, PMA_MP_12G_16G_MPLLA_CTRL0, val);
+
+	val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_25G_TX_GENCTRL1);
+	val = u16_replace_bits(val, 5, PMA_TX_GENCTRL1_VBOOST_LVL_MASK);
+	xpcs_phy_write_pma(dev, PMA_MP_12G_16G_25G_TX_GENCTRL1, val);
+
+	val = PMA_MPLLA_CTRL3_MPLLA_BANDWIDTH(0xA016);
+	xpcs_phy_write_pma(dev, PMA_MP_16G_MPLLA_CTRL3, val);
+
+	val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_25G_MISC_CTRL0);
+	val = u16_replace_bits(val, 0x11, PMA_MISC_CTRL0_RX_VREF_CTRL_MASK);
+	xpcs_phy_write_pma(dev, PMA_MP_12G_16G_25G_MISC_CTRL0, val);
+
+	val = PMA_MISC_CTRL2_SUP_MISC(1);
+	xpcs_phy_write_pma(dev, PMA_MP_16G_25G_MISC_CTRL2, val);
+
+	val = PMA_VCO_CAL_REF0_VCO_REF_LD_0(0x29);
+	xpcs_phy_write_pma(dev, PMA_MP_16G_25G_VCO_CAL_REF0, val);
+
+	val = PMA_VCO_CAL_LD0_VCO_LD_VAL_0(0x549);
+	xpcs_phy_write_pma(dev, PMA_MP_12G_16G_25G_VCO_CAL_LD0, val);
+
+	val = PMA_RX_PPM_CTRL0_RX0_CDR_PPM_MAX(0x12);
+	xpcs_phy_write_pma(dev, PMA_MP_16G_25G_RX_PPM_CTRL0, val);
+
+	/* 3 Configure LANE0 for 10G XGMII */
+	xpcs_phy_write_pma(dev, PMA_MP_16G_25G_TX_MISC_CTRL0, 0x0);
+	xpcs_phy_write_pma(dev, PMA_MP_12G_16G_25G_TX_RATE_CTRL, 0x0);
+
+	val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_25G_MPLL_CMN_CTRL);
+	val &= ~PMA_MPLL_CMN_CTRL_MPLLB_SEL_0;
+	xpcs_phy_write_pma(dev, PMA_MP_12G_16G_25G_MPLL_CMN_CTRL, val);
+
+	val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_TX_GENCTRL2);
+	val = u16_replace_bits(val, 3, PMA_TX_GENCTRL2_TX0_WIDTH_MASK);
+	xpcs_phy_write_pma(dev, PMA_MP_12G_16G_TX_GENCTRL2, val);
+
+	val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_25G_TX_GENCTRL1);
+	val |= PMA_TX_GENCTRL1_VBOOST_EN_0;
+	xpcs_phy_write_pma(dev, PMA_MP_12G_16G_25G_TX_GENCTRL1, val);
+
+	val = PMA_TX_BOOST_CTRL_TX0_IBOOST(0xf);
+	xpcs_phy_write_pma(dev, PMA_MP_12G_16G_25G_TX_BOOST_CTRL, val);
+
+	val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_25G_TX_EQ_CTRL0);
+	val = u16_replace_bits(val, 0, PMA_TX_EQ_CTRL0_TX_EQ_PRE_MASK);
+	xpcs_phy_write_pma(dev, PMA_MP_12G_16G_25G_TX_EQ_CTRL0, val);
+
+	val = PMA_TX_EQ_CTRL1_TX_EQ_POST(0x20);
+	xpcs_phy_write_pma(dev, PMA_MP_12G_16G_25G_TX_EQ_CTRL1, val);
+
+	val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_25G_TX_EQ_CTRL0);
+	val = u16_replace_bits(val, 0x20, PMA_TX_EQ_CTRL0_TX_EQ_MAIN_MASK);
+	xpcs_phy_write_pma(dev, PMA_MP_12G_16G_25G_TX_EQ_CTRL0, val);
+
+	xpcs_phy_write_pma(dev, PMA_MP_12G_16G_25G_RX_RATE_CTRL, 0x0);
+
+	val = xpcs_phy_read_pma(dev, PMA_MP_16G_25G_RX_EQ_CTRL0);
+	val = u16_replace_bits(val, 0x2, PMA_RX_EQ_CTRL0_CTLE_POLE_0_MASK);
+	xpcs_phy_write_pma(dev, PMA_MP_16G_25G_RX_EQ_CTRL0, val);
+
+	val = xpcs_phy_read_pma(dev, PMA_MP_16G_25G_RX_EQ_CTRL0);
+	val = u16_replace_bits(val, 0x10, PMA_RX_EQ_CTRL0_CTLE_BOOST_0_MASK);
+	xpcs_phy_write_pma(dev, PMA_MP_16G_25G_RX_EQ_CTRL0, val);
+
+	val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_RX_GENCTRL3);
+	val = u16_replace_bits(val, 0x7, PMA_RX_GENCTRL3_LOS_TRSHLD_0_MASK);
+	xpcs_phy_write_pma(dev, PMA_MP_12G_16G_RX_GENCTRL3, val);
+
+	val = xpcs_phy_read_pma(dev, PMA_MP_16G_RX_CDR_CTRL1);
+	val |= PMA_RX_CDR_CTRL1_VCO_STEP_CTRL_0;
+	xpcs_phy_write_pma(dev, PMA_MP_16G_RX_CDR_CTRL1, val);
+
+	val = xpcs_phy_read_pma(dev, PMA_MP_16G_RX_CDR_CTRL1);
+	val |= PMA_RX_CDR_CTRL1_VCO_TEMP_COMP_EN_0;
+	xpcs_phy_write_pma(dev, PMA_MP_16G_RX_CDR_CTRL1, val);
+
+	val = PMA_RX_MISC_CTRL0_RX0_MISC(0x12);
+	xpcs_phy_write_pma(dev, PMA_MP_16G_25G_RX_MISC_CTRL0, val);
+
+	val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_RX_GENCTRL2);
+	val = u16_replace_bits(val, 0x3, PMA_RX_GENCTRL2_RX0_WIDTH_MASK);
+	xpcs_phy_write_pma(dev, PMA_MP_12G_16G_RX_GENCTRL2, val);
+
+	val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_25G_RX_GENCTRL1);
+	val |= PMA_RX_GENCTRL1_RX_DIV16P5_CLK_EN_0;
+	xpcs_phy_write_pma(dev, PMA_MP_12G_16G_25G_RX_GENCTRL1, val);
+
+	xpcs_phy_write_pma(dev, PMA_MP_12G_16G_25G_RX_CDR_CTRL, 0x0);
+
+	val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_RX_GENCTRL3);
+	val &= ~PMA_RX_GENCTRL3_LOS_LFPS_EN_0;
+	xpcs_phy_write_pma(dev, PMA_MP_12G_16G_RX_GENCTRL3, val);
+
+	val = xpcs_phy_read_pma(dev, PMA_MP_16G_25G_RX_GENCTRL4);
+	val &= ~PMA_RX_GENCTRL4_RX_DFE_BYP_0;
+	xpcs_phy_write_pma(dev, PMA_MP_16G_25G_RX_GENCTRL4, val);
+
+	xpcs_phy_write_pma(dev, PMA_MP_12G_16G_25G_RX_ATTN_CTRL, 0x0);
+
+	val = xpcs_phy_read_pma(dev, PMA_MP_16G_25G_RX_EQ_CTRL0);
+	val = u16_replace_bits(val, 0x5, PMA_RX_EQ_CTRL0_VGA1_GAIN_0_MASK);
+	xpcs_phy_write_pma(dev, PMA_MP_16G_25G_RX_EQ_CTRL0, val);
+
+	val = xpcs_phy_read_pma(dev, PMA_MP_16G_25G_RX_EQ_CTRL0);
+	val = u16_replace_bits(val, 0x5, PMA_RX_EQ_CTRL0_VGA2_GAIN_0_MASK);
+	xpcs_phy_write_pma(dev, PMA_MP_16G_25G_RX_EQ_CTRL0, val);
+
+	xpcs_phy_write_pma(dev, PMA_MP_12G_16G_25G_DFE_TAP_CTRL0, 0x0);
+
+	val = xpcs_phy_read_pma(dev, PMA_MP_16G_RX_CDR_CTRL1);
+	val = u16_replace_bits(val, 0x1, PMA_RX_CDR_CTRL1_VCO_FRQBAND_0_MASK);
+	xpcs_phy_write_pma(dev, PMA_MP_16G_RX_CDR_CTRL1, val);
+
+	val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_25G_RX_GENCTRL1);
+	val |= PMA_RX_GENCTRL1_RX_TERM_ACDC_0;
+	xpcs_phy_write_pma(dev, PMA_MP_12G_16G_25G_RX_GENCTRL1, val);
+
+	val = xpcs_phy_read_pma(dev, PMA_MP_16G_25G_RX_IQ_CTRL0);
+	val = u16_replace_bits(val, 0x0, PMA_RX_IQ_CTRL0_RX0_DELTA_IQ_MASK);
+	xpcs_phy_write_pma(dev, PMA_MP_16G_25G_RX_IQ_CTRL0, val);
+
+	val = xpcs_phy_read_pma(dev, PMA_MP_16G_25G_RX_EQ_CTRL5);
+	val &= ~PMA_RX_EQ_CTRL5_RX_ADPT_SEL_0;
+	xpcs_phy_write_pma(dev, PMA_MP_16G_25G_RX_EQ_CTRL5, val);
+
+	val = xpcs_phy_read_pma(dev, PMA_MP_16G_25G_RX_EQ_CTRL5);
+	val = u16_replace_bits(val, 0x3, PMA_RX_EQ_CTRL5_RX0_ADPT_MODE_MASK);
+	xpcs_phy_write_pma(dev, PMA_MP_16G_25G_RX_EQ_CTRL5, val);
+
+	/* 4 Configure XPCS for 10G XGMII */
+	xpcs_write(dev, MDIO_MMD_PCS, XPCS_PHY_REG(PCS_CTRL2), 0x0);
+
+	val = xpcs_read(dev, MDIO_MMD_PCS, XPCS_PHY_REG(PCS_DIG_CTRL1));
+	val |= PCS_DIG_CTRL1_USXG_EN;
+	xpcs_write(dev, MDIO_MMD_PCS, XPCS_PHY_REG(PCS_DIG_CTRL1), val);
+
+	val = xpcs_read(dev, MDIO_MMD_PCS, XPCS_PHY_REG(PCS_KR_CTRL1));
+	val = u16_replace_bits(val, 0x0, PCS_KR_CTRL1_USXG_MODE_MASK);
+	xpcs_write(dev, MDIO_MMD_PCS, XPCS_PHY_REG(PCS_KR_CTRL1), val);
+
+	val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_MPLLA_CTRL0);
+	val = u16_replace_bits(val, 0x21, PMA_MPLLA_CTRL0_MPLLA_MULTIPLIER_MASK);
+	xpcs_phy_write_pma(dev, PMA_MP_12G_16G_MPLLA_CTRL0, val);
+
+	val = PMA_MPLLA_CTRL3_MPLLA_BANDWIDTH(0xA016);
+	xpcs_phy_write_pma(dev, PMA_MP_16G_MPLLA_CTRL3, val);
+
+	val = PMA_VCO_CAL_LD0_VCO_LD_VAL_0(0x549);
+	xpcs_phy_write_pma(dev, PMA_MP_12G_16G_25G_VCO_CAL_LD0, val);
+
+	val = PMA_VCO_CAL_REF0_VCO_REF_LD_0(0x29);
+	xpcs_phy_write_pma(dev, PMA_MP_16G_25G_VCO_CAL_REF0, val);
+
+	val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_25G_RX_EQ_CTRL4);
+	val |= PMA_RX_EQ_CTRL4_CONT_ADAPT_0;
+	xpcs_phy_write_pma(dev, PMA_MP_12G_16G_25G_RX_EQ_CTRL4, val);
+
+	xpcs_phy_write_pma(dev, PMA_MP_12G_16G_25G_TX_RATE_CTRL, 0x0);
+	xpcs_phy_write_pma(dev, PMA_MP_12G_16G_25G_RX_RATE_CTRL, 0x0);
+
+	val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_TX_GENCTRL2);
+	val = u16_replace_bits(val, 0x3, PMA_TX_GENCTRL2_TX0_WIDTH_MASK);
+	xpcs_phy_write_pma(dev, PMA_MP_12G_16G_TX_GENCTRL2, val);
+
+	val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_RX_GENCTRL2);
+	val = u16_replace_bits(val, 0x3, PMA_RX_GENCTRL2_RX0_WIDTH_MASK);
+	xpcs_phy_write_pma(dev, PMA_MP_12G_16G_RX_GENCTRL2, val);
+
+	val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_MPLLA_CTRL2);
+	val |= PMA_MPLLA_CTRL2_MPLLA_DIV16P5_CLK_EN;
+	xpcs_phy_write_pma(dev, PMA_MP_12G_16G_MPLLA_CTRL2, val);
+
+	val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_MPLLA_CTRL2);
+	val |= PMA_MPLLA_CTRL2_MPLLA_DIV10_CLK_EN;
+	xpcs_phy_write_pma(dev, PMA_MP_12G_16G_MPLLA_CTRL2, val);
+
+	val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_MPLLA_CTRL2);
+	val &= ~PMA_MPLLA_CTRL2_MPLLA_DIV8_CLK_EN;
+	xpcs_phy_write_pma(dev, PMA_MP_12G_16G_MPLLA_CTRL2, val);
+
+	val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_25G_TX_GENCTRL1);
+	val |= PMA_TX_GENCTRL1_VBOOST_EN_0;
+	xpcs_phy_write_pma(dev, PMA_MP_12G_16G_25G_TX_GENCTRL1, val);
+
+	val = xpcs_phy_read_pma(dev, PMA_MP_16G_25G_RX_EQ_CTRL0);
+	val = u16_replace_bits(val, 0x10, PMA_RX_EQ_CTRL0_CTLE_BOOST_0_MASK);
+	xpcs_phy_write_pma(dev, PMA_MP_16G_25G_RX_EQ_CTRL0, val);
+
+	val = xpcs_phy_read_pma(dev, PMA_MP_16G_RX_CDR_CTRL1);
+	val |= PMA_RX_CDR_CTRL1_VCO_STEP_CTRL_0;
+	xpcs_phy_write_pma(dev, PMA_MP_16G_RX_CDR_CTRL1, val);
+
+	val = xpcs_phy_read_pma(dev, PMA_MP_16G_RX_CDR_CTRL1);
+	val |= PMA_RX_CDR_CTRL1_VCO_TEMP_COMP_EN_0;
+	xpcs_phy_write_pma(dev, PMA_MP_16G_RX_CDR_CTRL1, val);
+
+	val = PMA_RX_MISC_CTRL0_RX0_MISC(0x12);
+	xpcs_phy_write_pma(dev, PMA_MP_16G_25G_RX_MISC_CTRL0, val);
+
+	val = xpcs_phy_read_pma(dev, PMA_MP_16G_25G_RX_GENCTRL4);
+	val &= ~PMA_RX_GENCTRL4_RX_DFE_BYP_0;
+	xpcs_phy_write_pma(dev, PMA_MP_16G_25G_RX_GENCTRL4, val);
+
+	val = xpcs_phy_read_pma(dev, PMA_MP_16G_RX_CDR_CTRL1);
+	val = u16_replace_bits(val, 0x1, PMA_RX_CDR_CTRL1_VCO_FRQBAND_0_MASK);
+	xpcs_phy_write_pma(dev, PMA_MP_16G_RX_CDR_CTRL1, val);
+
+	val = xpcs_phy_read_pma(dev, PMA_MP_16G_25G_RX_IQ_CTRL0);
+	val = u16_replace_bits(val, 0x0, PMA_RX_IQ_CTRL0_RX0_DELTA_IQ_MASK);
+	xpcs_phy_write_pma(dev, PMA_MP_16G_25G_RX_IQ_CTRL0, val);
+
+	val = xpcs_phy_read_pma(dev, PMA_MP_16G_25G_RX_EQ_CTRL5);
+	val = u16_replace_bits(val, 0x3, PMA_RX_EQ_CTRL5_RX0_ADPT_MODE_MASK);
+	xpcs_phy_write_pma(dev, PMA_MP_16G_25G_RX_EQ_CTRL5, val);
+
+	val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_25G_TX_GENCTRL1);
+	val &= ~PMA_TX_GENCTRL1_TX_CLK_RDY_0;
+	xpcs_phy_write_pma(dev, PMA_MP_12G_16G_25G_TX_GENCTRL1, val);
+
+	/* 5 Assert soft reset */
+	val = xpcs_read(dev, MDIO_MMD_PCS, XPCS_PHY_REG(PCS_DIG_CTRL1));
+	val |= PCS_DIG_CTRL1_VR_RST;
+	xpcs_write(dev, MDIO_MMD_PCS, XPCS_PHY_REG(PCS_DIG_CTRL1), val);
+
+	/* 6 Poll for SRAM initialization done */
+	begin = get_timer(0);
+	do {
+		val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_25G_SRAM);
+		if (get_timer(begin) > 500) {
+			dev_err(dev, "Polling timeout, line: %d\n", __LINE__);
+			goto timeout;
+		}
+		mdelay(10);
+	} while (!(val & PMA_SRAM_INIT_DN));
+
+	/* 7 Assert SRAM external loading done */
+	/* Workaround */
+	// xpcs_phy_write_pma(dev, PMA_MP_12G_16G_25G_SRAM, PMA_SRAM_EXT_LD_DN);
+	xpcs_phy_write(dev, XPCS_PHY_GLOBAL, XPCS_PHY_REG(GLOBAL_CTRL_EX_0), GLOBAL_CTRL_EX_0_PHY_SRAM_BYPASS);
+
+	/* 8 Poll for vendor-specific soft reset */
+	begin = get_timer(0);
+	do {
+		val = xpcs_read(dev, MDIO_MMD_PCS, XPCS_PHY_REG(PCS_DIG_CTRL1));
+		if (get_timer(begin) > 500) {
+			dev_err(dev, "Polling timeout, line: %d\n", __LINE__);
+			goto timeout;
+		}
+		mdelay(10);
+	} while (val & PCS_DIG_CTRL1_VR_RST);
+
+	/* 9 Turn receive to P0 state */
+	val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_25G_RX_GENCTRL1);
+	val &= ~PMA_RX_GENCTRL1_RX_RST_0;
+	xpcs_phy_write_pma(dev, PMA_MP_12G_16G_25G_RX_GENCTRL1, val);
+
+	val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_25G_RX_POWER_STATE_CTRL);
+	val &= ~PMA_RX_POWER_STATE_CTRL_RX_DISABLE_0;
+	xpcs_phy_write_pma(dev, PMA_MP_12G_16G_25G_RX_POWER_STATE_CTRL, val);
+
+	val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_25G_RX_POWER_STATE_CTRL);
+	val &= ~PMA_RX_POWER_STATE_CTRL_RX0_PSTATE_MASK;
+	xpcs_phy_write_pma(dev, PMA_MP_12G_16G_25G_RX_POWER_STATE_CTRL, val);
+
+	/* 10 Enable receiver data output from PHY */
+	val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_25G_RX_GENCTRL0);
+	val |= PMA_RX_GENCTRL0_RX_DT_EN_0;
+	xpcs_phy_write_pma(dev, PMA_MP_12G_16G_25G_RX_GENCTRL0, val);
+
+	/* 11 Assert request of receive */
+	val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_RX_GENCTRL2);
+	val |= PMA_RX_GENCTRL2_RX_REQ_0;
+	xpcs_phy_write_pma(dev, PMA_MP_12G_16G_RX_GENCTRL2, val);
+
+	/* 11.1 Poll for acknowledge */
+	begin = get_timer(0);
+	do {
+		val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_RX_GENCTRL2);
+		if (get_timer(begin) > 500) {
+			dev_err(dev, "Polling timeout, line: %d\n", __LINE__);
+			goto timeout;
+		}
+		mdelay(10);
+	} while (val & PMA_RX_GENCTRL2_RX_REQ_0);
+
+	/* 12 Assert TX0 clock is active and stable */
+	val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_25G_TX_GENCTRL1);
+	val |= PMA_TX_GENCTRL1_TX_CLK_RDY_0;
+	xpcs_phy_write_pma(dev, PMA_MP_12G_16G_25G_TX_GENCTRL1, val);
+
+	/*
+	 * 13.1 Configure XPCS to consider Loss-of-Signal indicated by the
+	 * PHY while evaluating the receive link status
+	 */
+	val = xpcs_read(dev, MDIO_MMD_PCS, XPCS_PHY_REG(PCS_DEBUG_CTRL));
+	val |= PCS_DEBUG_CTRL_SUPRESS_LOS_DET;
+	xpcs_write(dev, MDIO_MMD_PCS, XPCS_PHY_REG(PCS_DEBUG_CTRL), val);
+	/*
+	 * 13.2 Configure XPCS to deassert "receiver data enable" on
+	 * detecting of Loss-of-Signal
+	 */
+	val = xpcs_read(dev, MDIO_MMD_PCS, XPCS_PHY_REG(PCS_DEBUG_CTRL));
+	val |= PCS_DEBUG_CTRL_RX_DT_EN_CTL;
+	xpcs_write(dev, MDIO_MMD_PCS, XPCS_PHY_REG(PCS_DEBUG_CTRL), val);
+
+	/* 14 Poll for DPLL lock status for Lane 0 */
+	begin = get_timer(0);
+	do {
+		val = xpcs_phy_read_pma(dev, PMA_RX_LSTS);
+		if (get_timer(begin) > 500) {
+			dev_err(dev, "Polling timeout, line: %d\n", __LINE__);
+			goto timeout;
+		}
+		mdelay(10);
+	} while (!(val & PMA_RX_LSTS_RX_VALID_0));
+
+	/* 15 Assert request of receive adaptation */
+	val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_25G_RX_EQ_CTRL4);
+	val |= PMA_RX_EQ_CTRL4_RX_AD_REQ;
+	xpcs_phy_write_pma(dev, PMA_MP_12G_16G_25G_RX_EQ_CTRL4, val);
+
+	/* 16 Poll for acknowledge */
+	begin = get_timer(0);
+	do {
+		val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_25G_MISC_STS);
+		if (get_timer(begin) > 500) {
+			dev_err(dev, "Polling timeout, line: %d\n", __LINE__);
+			goto timeout;
+		}
+		mdelay(10);
+	} while (!(val & PMA_MISC_STS_RX_ADPT_ACK));
+
+	/* 17 Deassert request of receive adaptation */
+	val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_25G_RX_EQ_CTRL4);
+	val &= ~PMA_RX_EQ_CTRL4_RX_AD_REQ;
+	xpcs_phy_write_pma(dev, PMA_MP_12G_16G_25G_RX_EQ_CTRL4, val);
+
+	/* 18 Set the value of Config_Reg to 0 for Clause 37 autonegotiation. */
+	val = xpcs_read(dev, MDIO_MMD_VEND2, XPCS_PHY_REG(MII_AN_CTRL));
+	val &= ~MII_AN_CTRL_TX_CONFIG;
+	xpcs_write(dev, MDIO_MMD_VEND2, XPCS_PHY_REG(MII_AN_CTRL), val);
+
+	/* 19 Select XGMII speed */
+	val = xpcs_read(dev, MDIO_MMD_VEND2, XPCS_PHY_REG(MII_CTRL));
+	val &= ~MII_CTRL_SS5;
+	val |= MII_CTRL_SS6 | MII_CTRL_SS13;
+	xpcs_write(dev, MDIO_MMD_VEND2, XPCS_PHY_REG(MII_CTRL), val);
+
+	val = xpcs_phy_usxgmii_init_seq_2(dev);
+	if (val)
+		return val;
+
+	return 0;
+
+timeout:
+	return -ETIMEDOUT;
+}
+
+u32 xpcs_phy_get_id(struct udevice *dev)
+{
+	int ret;
+	u32 id;
+
+	/* First, search C73 PCS using PCS MMD */
+	ret = xpcs_phy_read(dev, XPCS_PHY_GLOBAL, XPCS_PHY_REG(IDCODE_HI));
+	if (ret < 0)
+		return 0xffffffff;
+
+	id = ret << 16;
+
+	ret = xpcs_phy_read(dev, XPCS_PHY_GLOBAL, XPCS_PHY_REG(IDCODE_LO));
+	if (ret < 0)
+		return 0xffffffff;
+
+	/* If Device IDs are not all zeros or all ones,
+	 * we found C73 AN-type device
+	 */
+	if ((id | ret) && (id | ret) != 0xffffffff)
+		return id | ret;
+
+	return 0xffffffff;
+}

-- 
2.34.1

