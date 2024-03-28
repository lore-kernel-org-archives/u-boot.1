Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11863C54E64
	for <u-boot@archiver.kernel.org>; Thu, 28 Mar 2024 04:06:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4DBCE880F4;
	Thu, 28 Mar 2024 05:06:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="P8j28CuR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F03F7880DB; Thu, 28 Mar 2024 05:06:17 +0100 (CET)
Received: from EUR04-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur04on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260f::600])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2993D87BE0
 for <u-boot@lists.denx.de>; Thu, 28 Mar 2024 05:06:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cloGyBNbOyPQ0rV2RGes7TJh1BvF/VQFnPI6WSXK6TgEf7c22LUrXhY8UL5HlaejUCNJoAIqtJzEmZDYlXTJg5rPPWK3V2deb3QoA8fph2R+ETz8AEzf64fns25oUfidpwd1Fe6r5B7RXHfItEP4o99KTSACKUx+0BqdYvVUpGz7x1ubnVUNNGGc5HtG7zH38GN/Cdkj6jd/3AlopAVKm2EziVFkSvAFmrl83w8LNXsgv01Ss0HOJP5JEcogf1JvP87x2dLAG6Br7LKAcK8kZmB5PD7sxVyeMqhsPtkcCil7b0A/pGn0FWfERIgQ3ZvSPPnB1tY9E9Ozb3hR/kHQXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KGHKDlu7iTW2jC9AZauBYtxtmV0PjeCY5piYfD0f3VE=;
 b=O9dJKKV+/A1RZBElgW5bjLRZkiwkETQ2xdDnR0JHYpFqb2wRNWsoMbbzfx6pXat2XgGZBW0QLnJDo3xdbXTYx2IOfb08A0HuvRNbDmFnAnUueg8AGtqfKKHLlXdxZTL/0fCnXNIJQsYTIBnAvrKjl5EsomyJhPOd/xZAhHV8ZA+ySeaTAqVuPt3f66mxC3mm62m/Q46uUOiUswYFoEPZ61ZKme/hJ9gG7EewahqGkSiLbTK5URq6V2FQ1PzyafD0bwaOHJbueSsA9szYvTtsP6JmQdvHPaUyJDvFbxWwUz9l5bm/8YPQzYfkIvl+rU/TEu4NmeX+pokXivyAGTODOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KGHKDlu7iTW2jC9AZauBYtxtmV0PjeCY5piYfD0f3VE=;
 b=P8j28CuR4gQne6vmclXXptb7jfWtiUFbeKmvHlPZxeiIZGjuDgfiZPz5NQ+tt/EB9LRPEpoekPEQVlsYju896jwggIRVYsCWJsWpRHY8EticEB790Ya/M/Z9SdFykJHHoOwPwamqiOo61Ixy8XAl0A4v3h7gA4tDHiJpil7tjJw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by PA4PR04MB9488.eurprd04.prod.outlook.com (2603:10a6:102:2af::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.31; Thu, 28 Mar
 2024 04:06:14 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d%4]) with mapi id 15.20.7386.037; Thu, 28 Mar 2024
 04:06:14 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Thu, 28 Mar 2024 13:05:46 +0800
Subject: [PATCH v4 2/5] serial: lpuart: use ipg clk for i.MX7ULP
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240328-imx93-of-v2-v4-2-338d15a65c36@nxp.com>
References: <20240328-imx93-of-v2-v4-0-338d15a65c36@nxp.com>
In-Reply-To: <20240328-imx93-of-v2-v4-0-338d15a65c36@nxp.com>
To: =?utf-8?q?S=C3=A9bastien_Szymanski?= <sebastien.szymanski@armadeus.com>, 
 Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, 
 Mathieu Othacehe <m.othacehe@gmail.com>
Cc: u-boot@lists.denx.de, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.12.3
X-ClientProxiedBy: SI2PR01CA0045.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::19) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|PA4PR04MB9488:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f97c744-904b-4c3a-f309-08dc4edc691a
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aSv9sABMfSSxGrQWjqN3Kbw9+zGuGDLj405wYu/jnGTMH0AZ0ispUUam26OdEKpLoEWcAU+V6ienNCD9vH5s5VNnddiMShObsc3U1GsFtmHsVrCpown5s7ZTVIa9+QiLOck8FSgB26YLXjLn0gpRTXYu5Iftre1UbynrnUT+91kZnDbDsGvbJSHCoQ2SgjAa0st7VYefLc7yx9l9aT7Iv5aOwwdIU8w1TUqb+C4qvFj8gY1wVLWDtgxW/JrT42HJQl5Ymcl8k8D/chnKZWlZH2TVsoPIXaAKFOwnpQgJsGU/usmW6CHYyyUxMNck5LjWWXItaDP/tvqQeRRoywlqs00uDD8VVXKaU56XBBWuQ7pbatAOirq3ZCrc+luNN6vP3paFmjJUc5r0g+Vl+ES6dd/NUtZpzoZTtBK3gxtr+xTChpbWz/Tcmrh3F37zrc2gcXshzUcPG7uthi6ynrdtB38jiFVaLMwcnC+g8QBy+TQrki3dHWHIYl0Qug+jqTfGALE6ovhKit5ul0MGUz0kQHhAllDWIwyzKaCB2uEH4H6hmywIaB8bH4ChS7e+xNK7+Xy7swWx5xekzQ0242okVO5wWfHrO4mFkoySBelI/gwhV68aAdi03CiZ61QCP65Mc47A+/W1JLHS5OIjoY8knUwVwM6jhwwfTLyBd5X1keM/QftwoCJ8ApIm53zLqv6QVr9ANxkOkzXj2UntXsLFPUW0X232WL/Z/q8FqERk43M=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU0PR04MB9417.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(52116005)(376005)(1800799015)(38350700005); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K3AzSEJnbTJpMG5oT1V0M2x6OVdBR3BmMzRzN2tGaGlmamJlbVAwRmpYNTh0?=
 =?utf-8?B?akhjbStLc3dybE5aSTg5MSttVUlkUkhwTjViMDhuSTA4ZURFYXdDMXFLblpQ?=
 =?utf-8?B?OE9QaVVURW1pSXI0anNlVGZxNEtrcjRmV09YR1VsUkZMZHREL0FyeHJZMHpB?=
 =?utf-8?B?NzhOK1NrcVJlWDg4YUdQNCtlcjVoZGNKanc3NDZLamFzQ2RDRUVVU09VbERw?=
 =?utf-8?B?N21obGJoQUVNS3ZSeHRyRDRKaC80aVFrVS85OE9lTEc0WVdBZ3JtNXluRmZW?=
 =?utf-8?B?SjJzU1BpZUF4YlVlSTkxeXVkSTQzcDhqMHZFNDdTajIvbnpLM1FEZ1QvdE5N?=
 =?utf-8?B?U1lPWjdiUzNUUTZwMWhOQTlUODV3U2xNS0x5TW95UmxNdW9zelErVThxVkVu?=
 =?utf-8?B?SVByeitaOFQzS2xGYjhJNi9uTHpRcUxYWUpVc0UzR2cwaUVuQWREb2x5VjQv?=
 =?utf-8?B?WFkzc3NReGNRU00yYWVNR29oR1JxdEtlVVpaTGNTYjNvd3R2V1p6U0hPSXJs?=
 =?utf-8?B?T2V4TzJhVGQxU3dMckpwYjdlMGEyTkg5VjhXbjZINVdPc3V1N0Q3QVYydHNF?=
 =?utf-8?B?SVFvRTFsQi91a24zS1gwTTcvaEVrb2l0anNtQThBQzdFZ2xRT2xQZjh3STA4?=
 =?utf-8?B?L0ZORm1uOE00Smpjc2hqdVdTTEF3eFVCZm1nU0hodUN5Qzc3cXAwcjBzRzVt?=
 =?utf-8?B?VHAzQzIyZFlkQ0JDWmJXVWNueGtBUzcvWHJ1ZHI0V3hBaUZzWS9YVWlnTHdz?=
 =?utf-8?B?QkEwcFk5THhvZWQ0ZTIzV05OYkpOaGsxdHpvOXg0QlpjS2l3YVErTURSbHdP?=
 =?utf-8?B?QW41c0NEZEIxa3F5WUFVUE5uRGdzY1pzQWFwNllHeXYzWHhDQ3M2ZFh2a0Vz?=
 =?utf-8?B?WEdJZVpSTTlQNGNLTjNwNW9pQWZqMkJab3BlcDQ1UG9GNEoyakR4ZjhjK1d4?=
 =?utf-8?B?UFJrN2ZFV1V3Zk9wN0lSZHFqV1A3RGJocTZvNlEwclJZWnpFeXlnMXhyRVVy?=
 =?utf-8?B?Rk83Qzk0bktuSlVwMUd1bzMzS3VhMXVXdTU1OUVCajhKbk05TytVZjNhOG9K?=
 =?utf-8?B?eWRFRmFLcURWOE5Mc0xkOEIxK0ROOURNcXRVdVoyWjk1cE04RWdvb2dzaXVO?=
 =?utf-8?B?MVRGYW80dTIxWjhxNFdIZnQwYk9nTUxTY1RZMFBMWVlieTkreWlkeHhkdnNx?=
 =?utf-8?B?bkVNdjdGUENZVFc0NXhVMWM0UmxuRHhHdGQzc2RMZTJsVnRqL0RFY2VBMjhO?=
 =?utf-8?B?aHB3VjVDY011TklOenpSOGxoOFFocXlZTUxEaVphQzllaHlKUmNna293SVlQ?=
 =?utf-8?B?UU1ObnZoVCsxN1VrS2xBM1pkZFRDLzJMOWlGMnhMdzF0WlBlaHZyamE3Z09v?=
 =?utf-8?B?UDljcFYwQVdUcysxenYyN0FVelJ4UWNKMWlzUzB1UUpFakszK3kzUTArVlRK?=
 =?utf-8?B?MmhtWG5kNFc2K2QvNUFPU0hvMERMOVUzZm1rZWxwSCtSUFJXSVA4TzlIUC9t?=
 =?utf-8?B?clViYTdUQVc0S0J0VDB3VG9XRUZ4YnA5Wkg1RDRNVHRBYmJwL0NERGJ2Qk5U?=
 =?utf-8?B?WWc5REdqenA3M1k5dEV6NDFDS0Q3bVdDbXZ2UmZLQXlpM2RMclJveFp3bmtx?=
 =?utf-8?B?YmdxSFBJYUZBTzZPMFdaZTVKSEZaM1ppUzlzcWkzTDdUMXd5VTM4bG5nZG1P?=
 =?utf-8?B?VjROK293UUltcUN5UHdWdVlqVDQ2UEJsUStzUnNId2tJQXc5eTFNNVcyclZX?=
 =?utf-8?B?SWlqblR5RFhseGJNWjE2TnVYdjgrUjg1VFlQUVR3T2JyV1pyQUl3Tm9RMXdL?=
 =?utf-8?B?cnl5V1dacmVHaTg4cENVSHhnTFJiS3dNY0EwUDNZOTFNNExlOUVhV0UvMmZ3?=
 =?utf-8?B?a3VhSjFnSmdOckFQQS9qUUx3aXQwd2kxeGduTmpBRXFUOEl5TTY4YjI4VFdY?=
 =?utf-8?B?K25IMzJtMVdLbmx3S0NiVGNxSFhMRUhGcWlFRG00cSszOEV0U2J1OC9hNVh0?=
 =?utf-8?B?KzM5emV0VFJabllFd2lpZlN5blh2TG1tV0k4UCtpRDVKNUMwUEhGN3JVNEpm?=
 =?utf-8?B?Qk93SWd6MkxLOEpsWHlZa0dDVmR3UUNxdjFNSHIxd3FUY3dDdnVkTmlLbkJZ?=
 =?utf-8?Q?fQLuXgj9M9wJu/RROO9hRXwR/?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f97c744-904b-4c3a-f309-08dc4edc691a
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2024 04:06:14.3850 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /Z2McvUZQdkpSgDqXUeLN7+g1+eERGFgAujMXbJc+RoLIMLlopHdU8yGrytSIxb3DFzYJvviNqg/nEDp2UfbLQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9488
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

