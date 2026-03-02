Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91D99E9B37C
	for <u-boot@archiver.kernel.org>; Mon,  2 Mar 2026 13:23:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B1A0283F61;
	Mon,  2 Mar 2026 14:22:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="fblNLDIv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7ECEA83F14; Mon,  2 Mar 2026 07:40:49 +0100 (CET)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2FC4083D17
 for <u-boot@lists.denx.de>; Mon,  2 Mar 2026 07:40:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hDSF00y2ZFyOoo3pQZa4p1AXNft4+00R4MK1RfNPyA6GwUz0Uk5hnWQNkaP9UAs0jzWv7Wj+lDKXCfAMmC0gPaa2tzC73wc+aa0DZpaLA7OWPjVUKZ92EY7viDJVOalkjCK9N5K+OrwRTm5uuFzzoQv1RzCEAFylAdKPWWPcUN+YhKpuu0i2xEA/e1vn1zHzl/BSHxNcVJc9wf6bjOaYhILK2enJga3ijYR4TtpTqt1hBH/vOdcnZtnU2A9pqxpqWQPUi8avNqFSBQfUyZ7hrdPnBX6vDvh59KLP4T1oYEWcp/+ZhC2ZJZiEtbKu5UgjrmLkOV0Ue892WyQq+XVLSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XOyinlz+nsccGb8HFUaIJkYePUqPurQn41jBhrJ+a8g=;
 b=IQRlYapwi0DDDQfzIhtML9Vfh4aVd6wl6GmQbqN5P1upXqtjpru95+Rz1dSfQISxCOyvPEzyH4lCM+DseIefQrTnJP4rzP+tpF1ts20CW7r9vDRNymjKLYe6bQe/IEr1OjkOdSORHucDIcgngp80PnijvgxQg/3LEMMluVyHDi8hwCMTU07n3UrkcnI3H49fiW1ZUbs42DrdDAkR1VBvYlVzhs5Baf/AJzBnvwoC1tJPc3xZDCzT5UjWPrxSPiGygL4J3q0IHWdzTBx7B6fp7PFXyJBU2MF0jxNbvZPe0XXEgpETApT7WgtCNREbRnAVxUf/YpOk/kvVczvW3hiQRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XOyinlz+nsccGb8HFUaIJkYePUqPurQn41jBhrJ+a8g=;
 b=fblNLDIvKlHsBMB8DYOUBIaekrzJwnKhkGh3QusmStcsr05fRPtZe8oIFcQelQ6sPY5XlTLZ8pEKc3Siw2lBHOB4SQyMukw/8OvhJDR/uOI5vkWfCCAk/wRGYnpM2fViDnCxKzF2MiVwYhkWhP0vv3t06fvsctKSLJXDntpHCjuyzh1j8palUt+ngnEy4n2wCyOSHWNzvB/y1OYkUz5BX2G/npBZUgWtZ+ekVodJjidpy72HOZ3gWk49QwGVgCRPi7aqG0n/9dP0uzr5blTpntecyjjVIe3CMRNtBuYGi2VuOKVSIRsuBdpFBJF2KUCwkgmZ7IVYDpzJbrrgRwB1vA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by DU4PR04MB11728.eurprd04.prod.outlook.com (2603:10a6:10:624::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.18; Mon, 2 Mar
 2026 06:40:45 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::cf3:c5b0:7a0c:d11b]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::cf3:c5b0:7a0c:d11b%5]) with mapi id 15.20.9654.015; Mon, 2 Mar 2026
 06:40:44 +0000
From: alice.guo@oss.nxp.com
Date: Mon, 02 Mar 2026 13:20:04 +0800
Subject: [PATCH v3 03/13] pinctrl: nxp: Add i.MX952 support
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260302-imx952-v1-3-069d6167c0cb@nxp.com>
References: <20260302-imx952-v1-0-069d6167c0cb@nxp.com>
In-Reply-To: <20260302-imx952-v1-0-069d6167c0cb@nxp.com>
To: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.denx.de
Cc: Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>, 
 Tom Rini <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>, 
 Ye Li <ye.li@nxp.com>, Ji Luo <ji.luo@nxp.com>, 
 Ranjani Vaidyanathan <ranjani.vaidyanathan@nxp.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Rasmus Villemoes <ravi@prevas.dk>, 
 =?utf-8?q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?= <joao.goncalves@toradex.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Valentin Caron <valentin.caron@foss.st.com>, 
 Vinh Nguyen <vinh.nguyen.xz@renesas.com>, Jacky Bai <ping.bai@nxp.com>, 
 Sam Protsenko <semen.protsenko@linaro.org>, Frank Li <Frank.Li@nxp.com>, 
 Niko Mauno <niko.mauno@vaisala.com>, Adam Ford <aford173@gmail.com>, 
 Joseph Guo <qijian.guo@nxp.com>, 
 Frieder Schrempf <frieder.schrempf@kontron.de>, 
 David Zang <davidzangcs@gmail.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Fedor Ross <fedor.ross@ifm.com>, Sumit Garg <sumit.garg@kernel.org>, 
 Shawn Guo <shawnguo@kernel.org>, Marek Vasut <marex@nabladev.com>, 
 Sumit Garg <sumit.garg@oss.qualcomm.com>, 
 Primoz Fiser <primoz.fiser@norik.com>, Simon Glass <sjg@chromium.org>, 
 Alice Guo <alice.guo@nxp.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: SI2PR01CA0052.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::11) To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|DU4PR04MB11728:EE_
X-MS-Office365-Filtering-Correlation-Id: ac4b7c54-a783-4499-478f-08de7826a174
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|52116014|19092799006|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info: Jb4AiGDaGjx24Oqell6WBBa1tdfmkDrWaKgpim6HzixvendWJzWqsb+o9ReY6UkT3D6MU6Sa8KIsITDp6SnJpkTVHapA+ZRsAmDTXNqYA6eFma5Y9A14YvUBIGpfsKDt8sxLYWVcvJPndgHiAIO18ex+Hm/fFthXjug68Ceg1JzXhd9oj9VgQLgCTrnsSS37j1jRfV1T1nMe6pbOqsTl4arp++B7NExS/yBuqh8Fnpaz0JXy8Zi6QSMQAizDEbRj9No94SZo0wsvoTdvi+SaAy6E04XGt9TkjCHNK6TbbZ9fbXnpKLvNzatIQKK0WFeNDaU+JoIFQFj+Y0KERtoFcX4OZ6MuP1dwzZdicGU9EYgMnBgdnxUQ1z55hamIAymAweUxdd0DefRNRZpClj08HSOh/gUeOv89SpWAf4hRGwaI+rGdf4WlI0iAF013YlGHixeokeCL5tQlC/1Myhf3JTtuSzA3XMXKcyknQHHMLRSoXZP3frCHD7YavQsMr7/vdl17dQdW5NZY8mm1rTLJ4uSjNr2Nvd7/omBaxq5a+FHhFq6u7pOvHsoRMXRromfx0hluWNtmwlQIoLoj79bwKrSMPyMYGcPDyCnEEkN3rG7BuZRosmlREptYa92xad5uwZ72AX8OtfQ+HuJHETD6HKW5OCNwcMBpkSxS6dcABWqypnk6Jc5FlJ1e+j7kZCze/F/ITcTq9A1I3dQSZiNIMLpbsDXwZ4OOD56rxjqh1QkV/gndJ8mpdrnawxtwKKgJdfJ2vkr199gc3bQ629jcSBLSqn4qBrvjjXsF+J+w2gs=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(52116014)(19092799006)(1800799024)(366016)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R09UQWU3dGVqZEZxa0lwZStwMFdkcUlnK2lIZUpDQUFnY05ENFF6empDQUlW?=
 =?utf-8?B?NkkzcG5PVk1VZVBleXBSZlNzeGgzUFNZZWE5SG9NZWtwekpTcFFBaGphY3Y3?=
 =?utf-8?B?OHJrM3oyUTZpU2ZLNnFxZHpWZDFPeEhJYU5KY0kyUzI3cmJuYU9YS1ZHQTJn?=
 =?utf-8?B?VW5YK0FPa3NNOEMwdmloRE9WZEN6OFFKVk9udGhSaEFySkJ0NWVqQnVaWjRG?=
 =?utf-8?B?Y0I3MnQ3clRIKzRCTFMwRFdwSGphYnU2UU1uZlgwUjF3Uk85OVBYS01nZkFw?=
 =?utf-8?B?SjZBcFkxWWtiQ1NBdUsxWnJhQWRiQzJzWkJDMnB0dkVpejJPOHpiT1J5Qk9y?=
 =?utf-8?B?bTRQdWhPaEdlY21iUUUxaWJMSkZQRE8rVXBXTDZtMTFNS2NaUnpqTHFxZWlC?=
 =?utf-8?B?ZjJBNGMwcEpFbmJSN0EvVDY0VEQ1Y1QzbDFPUFNDdkN0SWxXSVJmdHlVZ2ly?=
 =?utf-8?B?em04RVR1bHhMYnVPakRvY2JiWWxqa1gzN2FTM2U2dUIrVjBqTjB4K2Era0lH?=
 =?utf-8?B?U09OMlZTaS9uYnJjZUt3NGZXREJyZExSdGpSb2pVZ1pFRGhtSGdxeTQzUGpC?=
 =?utf-8?B?L2praDYrU2QwTFRKTDk3c2hJZisybE1vSFRXSUg2d2t4UzBsODNZR09WYm4z?=
 =?utf-8?B?R2I1bWZ5UnNCNVUxTzRKWktBcHNrYkxVblVhTGE4THlOYS9KUVE4M0dDbUxL?=
 =?utf-8?B?OTJGV25Tam5LK3VMeEdUSmZld2ZPVytVTTFwNnBIVjNqVU4wZFU3RW1xZlZi?=
 =?utf-8?B?UzRlMXhxdFFMaWZOeTdFa2laWnhZQXBmWFBod1ZRTkxDczdpY0pLY1ZPMDQ4?=
 =?utf-8?B?U2RpUnF1bjFlcjRybFdKMFQ2NzJ2azVkUnZuZ1pqSnBKUHpzQ2w4eXc3ZFZN?=
 =?utf-8?B?TGhnZGpxOTM3TUtZMGlXTHlrNUs1NHJ6ZDNUZVp0aDJlcFRKMFR3U013Yzlz?=
 =?utf-8?B?U0tOUVowcGc3QW1qMU9SSEhvT3BLOUlvQ3RZWldmL1hKWGpmTFZRbExXaW5X?=
 =?utf-8?B?S3BXVnB6aVdIaWZCZDlUQ3FnR2NQbEVOdmIrK09rNW5QQ3drdW0vWHJjdjdv?=
 =?utf-8?B?NUhJSVl3N3M5dmJWdkl6VGh5RnZnNjBybCtETk41a21ZSy9XRERHZHRoVFls?=
 =?utf-8?B?Ykw2K3FUSzVYSkFUVlYrNDdaT1hMVGpHMVBSMFVNa2xnejNyaW4yLzJDQTYy?=
 =?utf-8?B?aTBPOVNjSFlzVmdPUFZYMHZidjJyRUpuZ2tldXpWVGFBZStCOGpzbkpkaWRM?=
 =?utf-8?B?aW9mK08zTzd5VkptdHo1R3pEYzFOSTRNSlpjVEoxVjNHdHdVZnpyMGUxNk1I?=
 =?utf-8?B?WkJMazRJZ3FiU2pkdVFIVWpuTTlJOGtqZk53M2NQdi9WRFB6b0NGcTg5L3Vm?=
 =?utf-8?B?bWRFMHNuMnZ4TGFCL1A1NmNmRGljYktYWlJDbCtVS2ozYitrS2ozVWJpUEJr?=
 =?utf-8?B?Y1BZV2hQa21JclQ0ZDFLVXJtRUtZMkg5aEtCVUw0UEc1WDdmWG0wOFU1Y1RH?=
 =?utf-8?B?UEp1cmdlZXYzZ3hHVWRmSEM4QUxORXB5SEJMQjR4SUxVTjZXUWZCdkdCMnBh?=
 =?utf-8?B?c3hYQVRtZXQrczZKdENrbCtvL0xBbXlyOThseGJhZDlSSHoxd1BybVAxNm55?=
 =?utf-8?B?ZG5BSzFYd2N5SFl6SDdwRm5oWDZJSC8rTU9xSEt6NVlXbmRWM2lZemR1bGZm?=
 =?utf-8?B?NG1WWlY1cVRtMi9JM1hSdndzMFRZbjlJV2JnQ21YK3BmZmNBNE1tS01CVm1o?=
 =?utf-8?B?a016VWZHZjdiZnRMbGtvejN0N281MWVwbnFWd09nRlJUZ2lLK0c4cmVZTnpE?=
 =?utf-8?B?ZENnN3lUaEcvUlN0Y3cvNHIxa2xNcTIrRFVUbitsODViWWhUVXNFbTF2VjRV?=
 =?utf-8?B?YTVhL1V0bHhwd2h3OUcveGF3QmJFbytCY2l0djJBbHY5UHNIYldKeFdHVE9P?=
 =?utf-8?B?S1paMGI4ekgzZFQvZUlHaUVsdXZoT2c5Nmt6SVJ3QlFhWGVqMFFmUDZnMEpu?=
 =?utf-8?B?SjVtNEJlOGg1UXNiZnE3QlR4YUgwakp3V0JBdTRjUS95TzB0WWh3UkF3MmtI?=
 =?utf-8?B?QmxHRVRTbDVaV3orOUNtMFdnNzgzRk9rcStsbDBmVnpMNlNNN0V5WTNLenNQ?=
 =?utf-8?B?Q1A4bW5kUVZFSDJjYlNEaHBiVDVQbTRLNVh3Wmd1bUNtYWxmeEhDbkxwZEU1?=
 =?utf-8?B?YjcyaXRWWUQ3N2lXSVh0eUxnMzV2Y091MVZZbFhCbjBnWFo3TWplNnIxMTZB?=
 =?utf-8?B?b3ZUV3VJT1QzTG1zelpSZWZDMU5rY3RKZDJ5TjVGNWlmTFRXaWErejZSMHl0?=
 =?utf-8?B?QU0zZ0k2dS9BNDJHM0xZV0c2czJ0UkZPc2RlUEx5bEM2ZGN3L0F6dz09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac4b7c54-a783-4499-478f-08de7826a174
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2026 06:40:44.8127 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OrZFloIRFAFdGokdWlwHnL1K8hb/Vw4REMUpq+TE4OMXHDqLikswmylBUMpVlhlIB9wngnNyBJyDymoG0454Dg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB11728
X-Mailman-Approved-At: Mon, 02 Mar 2026 14:22:38 +0100
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

Multiple pads can drive the same module input pin, and a daisy chain
register is used to select the active input path. This patch defines
DAISY_OFFSET_IMX952 (0x460) and allows binding on i.MX952.

Signed-off-by: Ye Li <ye.li@nxp.com>
Signed-off-by: Alice Guo <alice.guo@nxp.com>
Reviewed-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/pinctrl/nxp/pinctrl-imx-scmi.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/pinctrl/nxp/pinctrl-imx-scmi.c b/drivers/pinctrl/nxp/pinctrl-imx-scmi.c
index 781835c6852..3cc2b85e151 100644
--- a/drivers/pinctrl/nxp/pinctrl-imx-scmi.c
+++ b/drivers/pinctrl/nxp/pinctrl-imx-scmi.c
@@ -17,6 +17,7 @@
 
 #define DAISY_OFFSET_IMX95      0x408
 #define DAISY_OFFSET_IMX94      0x608
+#define DAISY_OFFSET_IMX952     0x460
 
 /* SCMI pin control types */
 #define PINCTRL_TYPE_MUX        192
@@ -136,6 +137,8 @@ static int imx_scmi_pinctrl_probe(struct udevice *dev)
 		priv->daisy_offset = DAISY_OFFSET_IMX95;
 	else if (IS_ENABLED(CONFIG_IMX94))
 		priv->daisy_offset = DAISY_OFFSET_IMX94;
+	else if (IS_ENABLED(CONFIG_IMX952))
+		priv->daisy_offset = DAISY_OFFSET_IMX952;
 	else
 		return -EINVAL;
 
@@ -144,7 +147,8 @@ static int imx_scmi_pinctrl_probe(struct udevice *dev)
 
 static int imx_scmi_pinctrl_bind(struct udevice *dev)
 {
-	if (IS_ENABLED(CONFIG_IMX95) || IS_ENABLED(CONFIG_IMX94))
+	if (IS_ENABLED(CONFIG_IMX95) || IS_ENABLED(CONFIG_IMX94) ||
+	    IS_ENABLED(CONFIG_IMX952))
 		return 0;
 
 	return -ENODEV;

-- 
2.43.0

