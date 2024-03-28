Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC9D6C54E67
	for <u-boot@archiver.kernel.org>; Wed, 27 Mar 2024 23:54:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4149788151;
	Thu, 28 Mar 2024 00:53:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="XCjQzG2o";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CF4E68801A; Thu, 28 Mar 2024 00:53:38 +0100 (CET)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on2062b.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e1a::62b])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1604688073
 for <u-boot@lists.denx.de>; Thu, 28 Mar 2024 00:53:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q/i5/0IMVkE28IAotaVM1Ex8Z3uQMsR5mFwusKZed7SjLmLLL2L2KviQ9C+3hGD3xgyAtdAEU/7tKJ+vE6qhKVPv4j8HenI0ReXq5ro5hmuZ5nsWq4a5kXd6RqKHD+jYC2Dn5EmV9W7LbCg0EDFcX60IzTkzhBs4bXPHKBW49o3cnHkJSBDDeHpJR0iZ5ba3QqZt6Rx5+R1nV77/o/gXeqgnfbAIGTPSSaviqM63Rv3foYuOwaup1ZwE26KZiqk7lLOM3TuoUP/WkTLo+fv29wP6/v7D/aAzj58jV88kQPyQYtcJwarN24Oh5M4UxR+gDe+LAGtqglClgVNUZmZq3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q963tqxCiP1QtC7vOggi3JGMW7E6Sov67BJrkj3hvUY=;
 b=iQu3+pHxMUZq8gt1oSUia1hcZa/AwCn7ryORPCI8aAWBfMdCPvICRJYsL72slyoJtocS1iUeJEMSqDy15Q6opKv5293CSBans517MvI2P09BW3pqM8vOT2pVIztec/Eqh05cme/CysaoAgC5GH2TEdkfh5onAT7hCCtb3PVaYOPahABDyesZ1iR845fANkBeJMH4E4VZB0lbmogL9TFS6sVmPSHLOqWRdK/Tt2B61X4YU7Ae+n+bCysO87BulzfZ632ccC+4I/u248y3+tY4O8mWnfM0Gv1zwJnFXhOxjQTFnKOYIeTR7cbu33jJCpOb9pWoW+QY2+zVHzSI12yr6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q963tqxCiP1QtC7vOggi3JGMW7E6Sov67BJrkj3hvUY=;
 b=XCjQzG2oP4QjFOkaRGVsb8SHA+hgHdyO0j8A8spPBL4Y4FlC/vLtKUjy8r9EskLBUVFXzNpQPBwS7SmKbWPfRdVrSIJvX/kmrDVU0l/KNlfVABf8tZEvKjMdW5G7CUum9BYYdyGu79TgZIVYW+x7tT1R81oq6OFhR4+3diKAFM8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DUZPR04MB10064.eurprd04.prod.outlook.com (2603:10a6:10:4d3::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.32; Wed, 27 Mar
 2024 23:53:35 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d%4]) with mapi id 15.20.7386.037; Wed, 27 Mar 2024
 23:53:35 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Thu, 28 Mar 2024 08:53:02 +0800
Subject: [PATCH v3 5/6] dt-bindings: imx93: sync clock header
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240328-imx93-of-v3-5-4e7f341ed7ea@nxp.com>
References: <20240328-imx93-of-v3-0-4e7f341ed7ea@nxp.com>
In-Reply-To: <20240328-imx93-of-v3-0-4e7f341ed7ea@nxp.com>
To: Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
Cc: Sumit Garg <sumit.garg@linaro.org>, Tom Rini <trini@konsulko.com>, 
 u-boot@lists.denx.de, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.12.3
X-ClientProxiedBy: SG3P274CA0021.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::33)
 To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|DUZPR04MB10064:EE_
X-MS-Office365-Filtering-Correlation-Id: f7047aa5-f130-49ef-d854-08dc4eb91dd4
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5zU5s3GSKQHJ2vSp6baIfIm9Zr2OQWNai0MIO7fDcc7NO2F0ds7e8n5CYmK+1ox2FGzg7AdUQweNvJ11gx76MkwVgyN6Sqsbu5Fc7KRuWDnlp9EsmmiEk2J6LloTi5qD9UONnMHuLH5C5jwJvq+mYQtIgx1Nc5ncAyeFP4oUl4HYFY//JEH8UF8G20O+xt8yxjPOWRgcbVHk+qSWnPClWssXZGBfrfvfpG+YxGkQ3Y3I14sNhUkQzkTfnYRSzd/FhXKFELWbV+QMBeaqSPPXEoylsxen8bbIbhRnoQnLeAD1zUlBpyS+sOIUTJsjAiGPSogSIMfigUA4P16VqWFfYlAIWT0F2Egu1UbcCm5rPNljJBsHuMNe1JIFo5blCeXAkPbuRT40AcP2XBA0vTnWBVSJ/DXY+4AEodLxMJpw3sRsSw5yuw41ZkXzKKRA9+Q1oWSvuQIv422sWK4uwk3GLtJYcPn9VaTZH5Jb0FtsDGEeHrp23yo02Xahdl0OGahh97NGRj8bZngh0opR+9ImCzaCA4vLdXAVIKY1GpxoGsD+RIwguwILpWIxwxwYefYz93yoLwoVtGcjD7KNN1U+MKA6WfarCgGl+gi5Sub1GyuKNFmxMSqUNiCU7RnufGrLED3c5ibcUHs8RwV8oI5SQD/tzuyj3bJZ0sbENrOeH1xMT7rGQQKP+8msWv5KnSGt5BemcLp1Ga7+Hl47YesXlVfGae7EH7wxzqTSK9rnD9U=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU0PR04MB9417.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(376005)(52116005)(1800799015)(38350700005); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b2dOQ3ZpK1FsSkJZbmhKcFFGNWt2K051TXRwa3Y2KytURHVSMnloY0U2VzA4?=
 =?utf-8?B?L2daSTJLaVRjN2xBQlA3NUNqeU1Qcy9pdkt1bzdXdXpvaGM3dGRkY1dtWjdO?=
 =?utf-8?B?YlIrTFd6UjFSbzhUL3Q5a0h2dmVERGN3dG4vTElwN25jdk5BNmdIbXpqTDZY?=
 =?utf-8?B?bnpjbmFXYWw2VGJWTjJXNXNzSStIYjFwc0xwWHJ5YnQzbnVHUHRBcmxNTW5w?=
 =?utf-8?B?d0VHTlFGS2NScTJCVFNXTkk4Q1pEbVBEa1pGVWdvb1NDcUxZVUo5OWx3Z3pl?=
 =?utf-8?B?Ry85cHZuVVZZOXRKZURKaFBjY3RpRzE3b1RnLzQvS0g3YTc3R1RUNHFZSDgr?=
 =?utf-8?B?bUdxOXdsMVE0WVVXRjdtZGtXWUpSWnJCMnBtVGhSV3BsNmM1WENHV2VTU3ZR?=
 =?utf-8?B?b3pEWHhPeUlKTXNiRUdrSVZlbjNBaHlVcTBrNFNoa2cwR1NpZjVxMEkwdDlC?=
 =?utf-8?B?WFVWREpWSklWbE1qUmVWV0RDVlhBZmJEVjRXTTRuQ1hDZk5hN3hWenhlUThR?=
 =?utf-8?B?cjFBcjF1b0dHZ0NaVWF4TXVZTU9FWU4yYVp2bFgrTys3TXovdmdQTEM1UlhE?=
 =?utf-8?B?NHY1UkNYSXVRQmQvSmJxQTZPbWw2VXoydXFMUHNSU09pRnZBd0x2NXJCU0RL?=
 =?utf-8?B?dWpNeWdoay8yOVlNd3dpcUNMQlh5Nks0UVFCVHNVdWYwV0pUY3Z6K2RmSnNM?=
 =?utf-8?B?US96aUxiU3lET0E4WmZUSnk0dW9oQzlPNU5EMWJJVU84ZmIweWpqYVlTOEtz?=
 =?utf-8?B?amQ3RmNPQ3Y4MUV6ODVwZ1JCMlRxT2hjS2hzVm10aDlYYzdFenB2NFhzRVhP?=
 =?utf-8?B?VGNwZXBhUjA5WTFOVDJkWWttb211K0ZyVGZ5emFBSW50b0RwK0dhUGk2UTFS?=
 =?utf-8?B?SkEwVHBYUmk5YVlVSXZyMlVxY1RFckdCYmcrKzdqSkRRNXJ0U1RqSzVKbEF0?=
 =?utf-8?B?V0ZCSWZMMWhmOXNiaU9EekVncWVBWnBtUldaNHowd0hPcXEySUpURDNkVmNG?=
 =?utf-8?B?bkNlWkRUZTgrYmxONE1RSXJORGNJcUg3RmcyVS9NT05JWkFFM3UyQXIyZVNG?=
 =?utf-8?B?YjVnNHZqTUplNUV5Ykdya1JrS08wd0FmOTVoLzRCYnBsUVY2bXZKMk8zaStq?=
 =?utf-8?B?Q3RCNHJTWm04NUZJYTBPTmRaNkJ2UTJZMFRFcjVxcUNmKzdleDV2a2F4OWVN?=
 =?utf-8?B?VERHVXM5SnN5RlREMEJHRzlxMG1GVXJydVQrODMxN3REaEZSZlptNW1zbWxu?=
 =?utf-8?B?VkJJYjYranJCK0pqSVpxeHlqTTVTenhYcUhkd3VLbWxtelAySjB6cDBGZkE1?=
 =?utf-8?B?UWowVnVJcDArdkhydjZDQUx6RlNEcXluYjhYTDY5RlVDWEZNT0lQaFJlenNM?=
 =?utf-8?B?UVNmamp0YmpCc1hTOVk1OHpxblliVkwvNE9scDdHS0ZyYlVyaWJzbktsNE02?=
 =?utf-8?B?T0ZtMjltT05VdmtObHk2cFpwTGhwWjJVU0c4ZkhObEdHRGl0V1M1QW14bTlu?=
 =?utf-8?B?TkFFR29YU1BDN0Nsc0NoVTVFVEVIZDJlNHl2RU1iWFFHTXVKczRwMWhRT1lR?=
 =?utf-8?B?eU9MQ1E1QmYzQWxKVUhTMEZWNjVlRC9PY2crb0h5MWppUGVqbllhT1IyUmMx?=
 =?utf-8?B?SmcrbHlKNzMvZEgyVzF2a01GSHdrWGFsNGVjdHI2dkhFTnVRY2ZCcHQ5eWpv?=
 =?utf-8?B?Mi9mTk8rQUNzQ2V1Ym9DelRObzNUdWRGZUtaS2ZZZmJPcGJYcmJ2NFlZRmxG?=
 =?utf-8?B?VXJNd3ZkbFVvN2ZDN1hFQWN1blFmcGxIK0h4cTdnd25tSisrZGJ5YmtwZC9L?=
 =?utf-8?B?NDRzeDZjMGJ3V0pxWTRSZ2JyZ1VIRUx4aEVKVndySXA2U0Y3Q3l1ZlQyYUNK?=
 =?utf-8?B?MjRGTEorWUJ1VmdWQmRTejRHRklzZGZYeVJvYTVTN1Ezc2x4cXFVS2FJSzZH?=
 =?utf-8?B?SGxYdkhqL3VOVDkyTjhVMElyeCtQRG9jTG5JSTFxUUc2UjRGdXhvZXFLazdH?=
 =?utf-8?B?SzlQOTRVd3RaY0ZWU2NmU1RFNmV0Vm93NEgzc29hd0pYQjUzaHpyMW1ORXVQ?=
 =?utf-8?B?K0xsbnFaLzBaSGh1S1pYWm1NOFpwQ3JUZDJkbDUxck5LKzFsQnU0OGEya3Nh?=
 =?utf-8?Q?W+dTMnE/vw1eAKHAMJnzZ+nkT?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7047aa5-f130-49ef-d854-08dc4eb91dd4
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2024 23:53:35.7234 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ldo1MXXifDWC/gNRZeLe0+75SYBrQwvsj+xpWQrW5dI6gbaLPwgu4aypghJekN6l5vlVDDJWE26gzZNqTooq7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DUZPR04MB10064
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

Sync clock header with kernel 6.8

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 include/dt-bindings/clock/imx93-clock.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/dt-bindings/clock/imx93-clock.h b/include/dt-bindings/clock/imx93-clock.h
index 35a1f62053a..787c9e74dc9 100644
--- a/include/dt-bindings/clock/imx93-clock.h
+++ b/include/dt-bindings/clock/imx93-clock.h
@@ -203,6 +203,7 @@
 #define IMX93_CLK_ARM_PLL		198
 #define IMX93_CLK_A55_SEL		199
 #define IMX93_CLK_A55_CORE		200
-#define IMX93_CLK_END			201
+#define IMX93_CLK_PDM_IPG		201
+#define IMX93_CLK_END			202
 
 #endif

-- 
2.35.3

