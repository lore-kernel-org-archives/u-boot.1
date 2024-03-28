Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DB36C54E67
	for <u-boot@archiver.kernel.org>; Wed, 27 Mar 2024 23:47:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0EA4D8810E;
	Thu, 28 Mar 2024 00:47:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="C3w3mxCG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 05F77880DE; Thu, 28 Mar 2024 00:47:23 +0100 (CET)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on2060c.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e1a::60c])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0E0F9880DD
 for <u-boot@lists.denx.de>; Thu, 28 Mar 2024 00:47:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eVARnr2wQ9l/x9ZuvMIAO6cBsXUrkqVQZxMpYROATfYd4dLIkSb/qdGHaVFpF8rvJhp39EuiH+1sh8zR/UygkdUYWRTIT2GhDuIhedaQ+nVhUGFr0KowQYF1QkhG70xH0Sfkf7i5yVwOIo1kpgt5FWV0gSavoM4MKxWhlchXd3kgiPCwJ1tHy+eb3BdjO6g9lZXPzlv3i6eZYe8LcI5sstCb6qYCY/AoN0Do2ZO8lrHNR5wvNPMbpxvMQBOuXiSTbvyEq6sLd/XI6kyoq0nuQhxWE5HdvLbfRWW63xxcLB0gnmb/MvgYJzS0EoF1EZgYQ/dlD2+H4PDFutxiL0nt3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KGHKDlu7iTW2jC9AZauBYtxtmV0PjeCY5piYfD0f3VE=;
 b=IZvqhRklO72Cr5ocNR7u8tZXm5tApsR5/KASE2cUDJuU1+k985+8+NOo7AfmhCvhddGULcP1c8KEptn6WFRo0jy8Y99V6TEBNH1xhC2/u4m8yoEwVN0qWHGsKtbIpRr8Oll39lL2lRdmspvR4d2tzD4eB3wMVcTZhyZTkrtftPftW6TgXyjD1HdSr4OCGNU2GK+jhkj5VdM9JVFy3kRjGx7ScKZ7m7aLoyqtRhYZi/9kAmjy3fF+v8I/YuAPJhv82Ej2gr03LKeBPyL6xbaVBrxX8Cd6Sz9//292uaeSiogcTdwVTYXEtkNfY+T5VXF8lHxpUIzJso7c58z4/VlcgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KGHKDlu7iTW2jC9AZauBYtxtmV0PjeCY5piYfD0f3VE=;
 b=C3w3mxCGFSg0ECuHcVcc5cHsZ+6sGYUKs6HEZAjOpaZjgPkc5s5TUMuKIQNVjpjki1EYwzHRWxuoSoMeQNGDxEOrx32dzoZCKZQZqmYInNWhbFq32yd4E9X6MI/YYhEi6wUGgTBlFsxkMp9kIUaw85QVaSm3jU9Zm9K/MttX+Uk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AS5PR04MB9999.eurprd04.prod.outlook.com (2603:10a6:20b:67f::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.35; Wed, 27 Mar
 2024 23:47:19 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d%4]) with mapi id 15.20.7386.037; Wed, 27 Mar 2024
 23:47:19 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Thu, 28 Mar 2024 08:46:48 +0800
Subject: [PATCH v2 2/6] serial: lpuart: use ipg clk for i.MX7ULP
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240328-imx93-of-v2-2-909f5d37da87@nxp.com>
References: <20240328-imx93-of-v2-0-909f5d37da87@nxp.com>
In-Reply-To: <20240328-imx93-of-v2-0-909f5d37da87@nxp.com>
To: Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
Cc: Sumit Garg <sumit.garg@linaro.org>, Tom Rini <trini@konsulko.com>, 
 u-boot@lists.denx.de, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.12.3
X-ClientProxiedBy: SG2PR01CA0177.apcprd01.prod.exchangelabs.com
 (2603:1096:4:28::33) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|AS5PR04MB9999:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b75cb00-6a31-4e97-d488-08dc4eb83daa
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yAWYpEHcLqMzSR/0He77MPxaQVgZDBxDLvyzUVQ9i58kDMk9f8gO2wqhRwGNjpirN9kDHhub8jgSMdSzOUA4827aiV6YXkVvZkio+a51HsBlmq18bbB87IwxoeIXaPhZCQZ08PXFCKnPH4W9JQIgxTzQz098evEzQJcKEseDhHI/9wwrVJlRRjhHlDC6LOOj+lGXTNg3pj5TEWMRuEQfP0vTIiqMPeDxaTr7S32T1CLzkoNUjEIS3u0T22S/GklrvUVv0Ig5uEm1B9QuMt+uPwJqf9MMWwl4fhoWrPGxHFYsBoUTr1JsCcMtYlR+fD96Yc2a5PxScSWwjxzNBA3xS4PqVYDVp7PYZrP/CqB7dz5k3+9AAVHnA46AI+WctrZBzusKw2uiko20OVNL6keFTzNMGesSZ2v9SdB3XIWu3JXCuvbxgbhgQqzdqvUM+vQY4LLqiY8e2o7Nv+rc+/VZCXR8zSzRuDc8ymVnYdQOH8dNLHh8q8zrdIh524cV8xQ7hLx8JksAj/WJMaSR0xF3ECcwUnvxTimTWV03xZiNHkCT7c8ODMQZz4qevP5IEIo/SI+Vo15aRTpG7AWoqcTKxslZL8Bb5b9ntX/cZGWpRgeU/T9YzVW2Cy9YImw8fnIOwkWoQXoe3LWZ0x+sAZ7bvduQVij8h+AhKFm6tldaDhCug0kK6NQ1fglG0GLEVaMc1NX34t7Xpl4Mpk6cNAmf9sZS1fzyt4AhH4n5fyt9B+k=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU0PR04MB9417.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(52116005)(366007)(376005)(38350700005); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?djRlZ2NSTjl6TC8vTStTMGRNVjQ0anExNm5jTEY0VXJpajhzTmRGT2ZsVCtj?=
 =?utf-8?B?VUROeVc3RGpLMTdya3JVK1czNkZId3B3ZkVKN1lNUmpiek1MY1Q3YlVDNSth?=
 =?utf-8?B?bGtEbVpjRlBLWXhJdFdTUjBVSFg3OUdsVnNneEZoRGt2YWJXNDlWdjN5dTFs?=
 =?utf-8?B?cEg0eEpQYnFFd2tZVng5amY5ZFBRSyt4WDFrL2JnVG84RXFaUStqODJGU01v?=
 =?utf-8?B?MmIzOVhncGMzZnc4aEFZdWd6eW8wZnc4dGY4MTZoeEZFUUh6eWVtazBGTVg0?=
 =?utf-8?B?bzFhRDBqd2xteWxwK0gvdnNia3NCMTlERURzZVlGN1RVNmEzRXdET0hjaW9E?=
 =?utf-8?B?ODR5SCtNb2VqYWdUZFdndFVWR3BJa2RzRzFia0dBRkQwaXR2VUF3ckhVVWo0?=
 =?utf-8?B?Wm9qNDlHQmF4bmllY0F4VGxzelJIanpoNHlnZXZTS0J4VHRXZWVtTTBETkR1?=
 =?utf-8?B?YWsxOVJKSUEwcUw5N1FNYlpGN1pnSFNUajc4ZkNuZ2E2QzdFOVVKRUo1N2x5?=
 =?utf-8?B?V2pFcEIrZWFxOTNHU0NBWkdxQkxadENGa3Z2S3V5dlg2UFNiSnBoREdpV1F4?=
 =?utf-8?B?a0UvYm1DV2QzaTJSOWkrTHJrMWQ3ZitMU0tQMUR4ZTV3ZlVBSVhJZHMvNXR4?=
 =?utf-8?B?Mkp4cThPaWFpc2xPaGRLTVNsZHVYYWVGazlBNE9TYW1CcXB2Vzl6OXZkSW1V?=
 =?utf-8?B?dFVIOFVxUU15U2hxQjBxQStMRWFGZjJaRkl2aEdHa0FEMEVhNkZsN2lrWHh5?=
 =?utf-8?B?cHNJMno1Y0NWWTlsTDZyQ0tQZlpGdytBbnRUSnRoUG5rVFVXWG5lTDFrYUNB?=
 =?utf-8?B?NFdaME5xait5d0MrbnQ2SnByVldIQzZYQUI3ejJvR3NrMndVdVFBQi9GT1VN?=
 =?utf-8?B?aHJwcXFDQlhqTngrVGJjQXRVbTJ1ZTA1UzJPdUpwMkt6aFpiT1lUNm5hVTB6?=
 =?utf-8?B?K01YYnVDTVNRL2UxNmc4ZzZHRzk3ckFUUW43bXJXTkQzZHp5c3ppbzQ1OEJP?=
 =?utf-8?B?eXFMRUdmbUVoSENUTXdIM2wxTU5zQ1BlYkxFajNPZkNCZmh4NllMWUVNRFdW?=
 =?utf-8?B?ODQ4N0ZXei9HNXNXaSt1YlVVWXhTMnBQdU84eDlZSXVEOFlJNzBEdGlrYjM0?=
 =?utf-8?B?b09aY0F2WDFobDJtcTJvMzBwWUhFeXpzZU4xSTYwUks0NG1iaStPZEdOL3Ur?=
 =?utf-8?B?WmovWlRrSzRxSFdvT3RzSXI1a0cxVXRuK1k0dnJzRDdpajFIU0N5VkhTZENU?=
 =?utf-8?B?TFl1MmQ2aEcwaW5mYlVPNUk1TFFoMkhlTzVnZU5ibXlkOWFpeDgvd2NLR2Fi?=
 =?utf-8?B?a214MWI5V3QxMmVpY2tuMWtVM2VPQzJrQnpvWnJHMDlNU21rbXBlaWEwcUxr?=
 =?utf-8?B?Q2s5SnNhZWtybmRNalhrYXVxbjJTdGtqOFNtK2g2L3ZQYzFvRWg5Y09hTEt4?=
 =?utf-8?B?UXc0ZWtsdTVqL0FzMHl3S2ZVV2QvZTMyRjdMaHA0Q0FreVBDVHV4aGh6dTY3?=
 =?utf-8?B?alMyNHEzQSszdk0zS0grb0N2ZTcrVVlNWjkvNjU4SGtyRXc5RGFIMytCVWN3?=
 =?utf-8?B?aVFVYk1Ba1FqenVINjFYMEwrcGlvNmRzOXdFcXdwcjFZYjZBN25HMEJxRUFh?=
 =?utf-8?B?ZDJtQW5VWGxFRkY4RGIrZTgrclMxKzFrM3NPM0QrenFWdWltVlllY1I3Z2l1?=
 =?utf-8?B?cytMMVc4TVRZU3h0bmtLSVRJTEpoTTdYR3VWVk9BYkg2Y0hORHhtWnh4SzE4?=
 =?utf-8?B?aWNZZjlBbFAvM2ZJaHN3YURsK0hTVGFkRXNGeVY1bGpIUzVIOTMxa05PVHVV?=
 =?utf-8?B?Wk0vRzVPL0RqZGpaVjA1Z2UzYXZmVUNmMGc3T0RMbTdVN1FrZ3NoOUplSUEx?=
 =?utf-8?B?alBiT1FEcXNUMUdXaU56dGdyN1ZOZi9IaHpWRnlxanp1a1l3U3ZoMjcveUgr?=
 =?utf-8?B?OTJKWTVGU0dWdEErMjBTV2l1Z1BUYUU0aXU2Y3hrSFVSRUJhQUdsTEF0aGd5?=
 =?utf-8?B?SndCZk1jY2Npelc0NVZCSTREaEUvRDZqeHpnZ0o0NE1WUnY1YXFaRGlrV254?=
 =?utf-8?B?eloxcUFwN0VPL2ZSUWVDQmZXZ2l6eXArOTREd2QrNzZrdnBoOGp0aHZ4c1ZQ?=
 =?utf-8?Q?daSeKIoUMvapOsKz497FrujcU?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b75cb00-6a31-4e97-d488-08dc4eb83daa
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2024 23:47:19.6125 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LXizeGmIUV853Te0TFG/Vzk0UzYekgJgSVrakGtZmpsLFQ17HRTgjj/DgUqiooXQibfb/qFzz4Pjh0BvUbF/Sg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB9999
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

To i.MX7ULP compatible lpuart, there is only ipg clk, no per clk.
So add a devtype check for i.MX7ULP.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/serial/serial_lpuart.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/serial/serial_lpuart.c b/drivers/serial/serial_lpuart.c
index ce08a6b4486..653ff99e67b 100644
--- a/drivers/serial/serial_lpuart.c
+++ b/drivers/serial/serial_lpuart.c
@@ -111,11 +111,18 @@ u32 __weak get_lpuart_clk(void)
 #if CONFIG_IS_ENABLED(CLK)
 static int get_lpuart_clk_rate(struct udevice *dev, u32 *clk)
 {
+	struct lpuart_serial_plat *plat = dev_get_plat(dev);
 	struct clk per_clk;
 	ulong rate;
 	int ret;
+	char *name;
 
-	ret = clk_get_by_name(dev, "per", &per_clk);
+	if (plat->devtype == DEV_MX7ULP)
+		name = "ipg";
+	else
+		name = "per";
+
+	ret = clk_get_by_name(dev, name, &per_clk);
 	if (ret) {
 		dev_err(dev, "Failed to get per clk: %d\n", ret);
 		return ret;

-- 
2.35.3

