Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56ACEC02183
	for <u-boot@archiver.kernel.org>; Wed, 15 Jan 2025 13:32:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D9BBD807DC;
	Wed, 15 Jan 2025 14:30:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="mY47dpMl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 96735807DC; Wed, 15 Jan 2025 14:30:34 +0100 (CET)
Received: from EUR02-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur02on20611.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2607::611])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B341C80753
 for <u-boot@lists.denx.de>; Wed, 15 Jan 2025 14:30:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Cvw2CzVrjue66Uyb24+9B4jG+7LoTP9nTKUv13teYFPn5M1MGmCNVh3El3JARLs8t177TX0ao8el0KfvykyyBOHqjZ6yxZTevXuqKWHR8jYTCVU86TdyV5SuO5LksiBcyG6j+UQPcyVZNa/jT+77pLYqYOSVpiIxIwhVDHLHRxdOVc8StrP7xBGxGk6IXIqUWhf5NP8xy9OZA4qcijywKjpkepsUstIvYir1la4zTe2bb3YJdA4oLBOOf3yxM3koRTkbdBFaYrmq0ovwUoX1bQnoE41p+PUhG1sQXiON6SUFLluaYosWanDHKz3Z6hI2hUmCxkY7GwGhOHvRGlzRHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v3TIkznGYKL5eDa+9IrI8+XYiziqYiTxI3HGyBJf1RE=;
 b=Rfwiovlej6grqC0Ir4eIXE9oLzXeJX6OW+P1P1UlOUpgtyU6EN1cf1ui9mpM1f2hUNJbI3a+bpAVxWakUSmxv73d9Pk2OTzxFzcf1KWqlTooyOwHz8i5i/0sCSZRw/Kxlx+ctMiD8xMl+bvz6m2Hci8uxvSKP+uEfRgj+4BZ9TT1Edrd46RHVmS2B4AzEj5QEObZMqVlTLMd9HRqBsquycLHXrMAvxvqjhK2Fq4KOrxPS1ip452xUQSxffsi54oAoqmR3H6hRgfAdiYejbO+xSgxfo1Yy+IZ81B6wkfqQ2LQt2181IGaYLuf6DFfxfMdXNslcpS6p50t116LBRzxEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v3TIkznGYKL5eDa+9IrI8+XYiziqYiTxI3HGyBJf1RE=;
 b=mY47dpMlVopGNwup3NuiZA0pJKsT1+YejopGC6e8sZNQ7HfffObN7W6rhAuVhDM4aBbRpN7u0dGburzbqAKtcZyXbepvNapReMQ7qAncdBajdojkDxb2LUVe6crW0bC03wbEV9X0kU2AQOVfHiT9Kuwg2d8badBbVG1vGJiVPjp/DO29wAFFq9KZCZMIinEgV9wBVfQ13HtgInVivl1xfYuguSObdQRnds7UHHY1D2uAduVn6zGiRFzeQFfM+kFMetYXeHHOkMwFmnW+4WziNZMg7WjtEE2OL2V55lrhjQhOkqL78Rt/92km3EqpxrpkB1RQcF/WXx/n86GWqRmsiQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by AS8PR04MB8593.eurprd04.prod.outlook.com (2603:10a6:20b:424::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.13; Wed, 15 Jan
 2025 13:30:29 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%5]) with mapi id 15.20.8335.017; Wed, 15 Jan 2025
 13:30:29 +0000
From: Alice Guo <alice.guo@oss.nxp.com>
Date: Wed, 15 Jan 2025 21:29:07 +0800
Subject: [PATCH v4 20/20] imx95_evk: add i.MX95 19x19 EVK board basic support
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250115-imx95-v1-20-93b28a514dea@oss.nxp.com>
References: <20250115-imx95-v1-0-93b28a514dea@oss.nxp.com>
In-Reply-To: <20250115-imx95-v1-0-93b28a514dea@oss.nxp.com>
To: Tom Rini <trini@konsulko.com>, Stefano Babic <sbabic@denx.de>, 
 Fabio Estevam <festevam@gmail.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, marex@denx.de
Cc: u-boot@lists.denx.de, tharvey@gateworks.com, 
 Alice Guo <alice.guo@nxp.com>, Ye Li <ye.li@nxp.com>, 
 Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1736947742; l=24351;
 i=alice.guo@oss.nxp.com; s=20250115; h=from:subject:message-id;
 bh=wJlc/ApFs8KcBZFQNPmDcIg3fXOi35jRiz0iQxLyx2w=;
 b=oYY9ITZvSVYBgBT6tmbdgH7/h2sd11EK+RytVWv6W1sCUP0muF91NlwL1hmNQX8Pu6J/43JE8
 sU+VEhFqvglDSVzb1gji+QrkrwwQP77zgIWwzFXB1O5LUb2wMaia5Wm
X-Developer-Key: i=alice.guo@oss.nxp.com; a=ed25519;
 pk=MQFotjdbgvdbpnpHmN/PUzfJXX0wchusR4L7yfs2VZQ=
X-ClientProxiedBy: SG3P274CA0022.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::34)
 To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|AS8PR04MB8593:EE_
X-MS-Office365-Filtering-Correlation-Id: d10e4a86-8e4a-4852-535b-08dd3568c756
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|7416014|376014|1800799024|366016|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?b3RMVXd1bS8wUFM1dnBtTE1QQTY1TWFsVSt0Ty94QW5kZzE3WjE2MzQ1YjFx?=
 =?utf-8?B?dWhMM3RkUFdYVDBxSjdPWjUvUUFQMTIwL0x2K3RXS3lKalM4SG8wdXQ3R3V4?=
 =?utf-8?B?N0RYQ09kQWF4dTdrNVRaZUNVTG1TT1U2OEFvZFkvd0Vtd3lJdFc0eW8vV2tj?=
 =?utf-8?B?bTdKYWVVdlZaUll6aVF5QzBrVlBESVBQNmNCUlp2akhlMzRUVnFtbmd1bzZ1?=
 =?utf-8?B?dkZGV2tqRFNobE00VSs5UUlsVzkwRDU0dTV6M2g5Q2Y3dUdESHRqb2ZvcjBH?=
 =?utf-8?B?S21xbEhrRVdHY2t4KzBmSmFvZmFYeDRSNFZpRDk2WURPT3lRSUI3bCtpUWtP?=
 =?utf-8?B?YmlsYnJBbDlOV2lpRFhHUTZSSE1VZ05zMm1FQnI0WVl3S2R4NXBJWW1zVnJk?=
 =?utf-8?B?OFVaTlExTnVueVVTRmpCZyt0K3hmRTc1emY2dE45bHNnR1ZSRXpxcy93YklR?=
 =?utf-8?B?dGQ5Qm1COVdYRUxRVDVxdXJ5c1V2SXFaMGJkUFBkL1IrVTBiK2o5OXVNcXVt?=
 =?utf-8?B?cGZPUGhubmFDZ0UySVBVc0RzaEJ4R2lmdWorUUY1dnBSaFhCZXIrOGxTZW00?=
 =?utf-8?B?YXE1SmFVell6Y1NjRGhpSVhlSXZxL3ViQWZwdHAzWk9jN1JzRy9mMjF3K1B0?=
 =?utf-8?B?OE9wYUpzUUtCa3RxREF3c0hOWU11VTlWWEUwMmpKTWsrU2FRUk9SOG56NGJy?=
 =?utf-8?B?NGRSVXRlMktYZythK0dkYUxreWs1cmRnRFRPayt1VUdxZ0gvVDVkQkVrK3pY?=
 =?utf-8?B?VkNvTGxSWG9MVHFiU2MxUm5hVjMrSTBxQkN4NHhBbFgzbmVVdVZWckdoQXJn?=
 =?utf-8?B?cWV2TUM2OGZQWFY5Y1YvM1hXcEt5SlRBcklzNEFFYnpxRmNWQitkWUU4QzY1?=
 =?utf-8?B?MjNDdTRFZGFkYWJaejZRaUQ0RjdwOWVuRUttSEhKVVo1SEE0U08wM3lkNlJh?=
 =?utf-8?B?V1NZV1ozSUJPMVAvYTlZTDlLUERzOXdMTW5NdU1oSEhOTVF3MmxWSkJQWDF4?=
 =?utf-8?B?TXc3UUI4cmErRTUrSWM5Mkltb1BiZXJYbExteUErQUtEa0VzS0gwUkJGQ0h0?=
 =?utf-8?B?N3dmR1VnamljbWtpcFJrYTZZT1crcFVneHNZTEt5bFRxODJJdE9jenRYdXpr?=
 =?utf-8?B?SkhrSVNSa0NqWUtWK0ZDZCszeTMwL3R0aGVtQzV3M1VRRnNBdm1JZTJKRXVW?=
 =?utf-8?B?WjBBOXZQUW9BaC94UXNaa3Y3RHNrVFl6ZG5xUUsrRjl6WlRNV3pPRWZXOXpa?=
 =?utf-8?B?dHo2RjgvcTBZWmNyM1RVUW82bTR1OHloclhGdmNpUXBVb2NVN2lHYmlKZGRi?=
 =?utf-8?B?cW9idkFrLzFnSkJBSm5EUENPZ1lRb2JlYkhMcUg2MmNsUFY5OE1xYnFCVE1J?=
 =?utf-8?B?K1VMQ0xTcDUwc3Q1UWV6YWdLaUJScmNFaDVUSDBXRHZtWGRHMVZyM3lXWlI3?=
 =?utf-8?B?V1N5WkFhR3BsbXhjWWVJSmxrRmdCSzNYa09Cb1FqdFRyUWhMRThmTG5namJo?=
 =?utf-8?B?U1ZFaHpHUEpUK1lhSjUxeGVUSTZtcmxhSVQybGxDWUEzaG1vQTJKc3ZVdS9x?=
 =?utf-8?B?ejNQekV4T0hkN3d3UWF1U2FSRVFIaUVybnpSVkRjOFM3NjYwcG95T1dQK09Y?=
 =?utf-8?B?WXM4clpEbmMrM3lBclRMdDJja1ZudVh1Qm9WdWRwVHJTWndRcUN4dmVmNVEz?=
 =?utf-8?B?TlVHR0gyL3ovQy94V1JXUTlaWVlOZ0ZSTEw1eDI1N3l1NEx4SUU2SkZNTVVv?=
 =?utf-8?B?dm5ZSTQzbkhKQkhnTEpmdWl1dUtxVk5DREF4S2VDdldGSmQ1V3Q5ZndzclJM?=
 =?utf-8?B?dkVQeU5VeUF3ZWZjVEFEME5MRGs1N0c2TFYzK1Z5cXlDaDE4WjArcFBDOEtL?=
 =?utf-8?B?UitBREJJUVRWdU1WOEIyTWtnTE1ZQ0IxZlZLZWZZVXptZWc9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(7416014)(376014)(1800799024)(366016)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MDliU2RKN205KzdwZ0h3R1o5UURnNjZiNFlZUldEWVpjRWUzVkNIZlhmWjRU?=
 =?utf-8?B?eHpOYlNoZC9SWmlWMklnSTRGdkN0cEdsT3N3RXlRbHFSQzdHM3hQdVU4bW0z?=
 =?utf-8?B?cE9DN2IwbmxKTFhJTXFSbHAxMUZHR2dNN0lQOUNadjAvakZVRTBTajBqbzVP?=
 =?utf-8?B?VXZWOFhGbmNyQmh2cHlaZGFyM01ibkh6THg4QWhwbWxDa0JCK0hXUHVZMWZM?=
 =?utf-8?B?SnNkZ1l3ZnZ2UHh4SnZQU0FKN0locGpXN2U5UjREd1RPN2pqUU9UNUZIOCtn?=
 =?utf-8?B?akprRVpwNkNEUEtPVytNNHM5Z0dMTmxnYk44MFd4NC9Gd1cvSjNsSDFNMTlK?=
 =?utf-8?B?Yk5LY3BNOEFnRWJCdEw4UXhJQ2l5TXlIbmdqbXJJbC82NXMwYXhab3NWZWZi?=
 =?utf-8?B?dzZrRENyZnBHdVoxdDRUN28zekt5SmV5RGNoaE1JUll3RkgrWWpFQnFreWlL?=
 =?utf-8?B?cFJMZzBGRjJFNGEybE51NXpETW1XVi9YREpkQTc1Ri9TYkxwZ2N2WlU4OUND?=
 =?utf-8?B?T0hBb2tqeitxUkJaSC92VFpFclVpdXZ6Z2ZuK0RpdHBWSzBCZm0ybnFGQVl6?=
 =?utf-8?B?Ym5wSWt6bUp3ek1mVWFSbEtLM3Fla1dqTWt2OFQ5NVJ6TUdOcko5Vy93SFpl?=
 =?utf-8?B?Uk5LQ09WeE4wTmJJZFROQWN0ZkhJN0VmK1BIcmlQVjVtWTB3TU1qUDdFczFK?=
 =?utf-8?B?bm9yaXlwY3gzZjBlZHdHV1hFb3BNbXdNdUNhbFJHam96cmYvS0JTY0dwTk96?=
 =?utf-8?B?clFFYldML0JRQ0daekZicWNXeDkrY2l2aEIzUUt1VXg5RnJJWitjbXBFUGxj?=
 =?utf-8?B?UFJHOUpEQ21raCtROVBHd0gzWFF3RVNvR0FxZVVJQ1hGMHQraEd2VFpXVmdv?=
 =?utf-8?B?dWFoNnlDREw4Q2RjeStWVmk0NWRKMnVRNDRMdm9URUU1bFphQS9rbzNmMUNI?=
 =?utf-8?B?N0xCYkswdEhjSERnNlpjWXN5NTVKTlBkSjU2SUVlN012bXFVbkdWNE0zNDhF?=
 =?utf-8?B?Ni95bHZBMmk5cCtIT0lzUUpucjU1OHlHQzc0a1VqOGcxVm1BNDBnN0R3bXNx?=
 =?utf-8?B?ODJaaW5UMnRxY0ZUTEhKb3RxRnZhazNyamhmUjBoTUZ5NmtHbHc5a2hpRWky?=
 =?utf-8?B?YjM5TGlnYUIyYzBqZXhrcjJUMGdONDVoOHlwcm4zNXpZOFNYaHpSVk8rRHB1?=
 =?utf-8?B?SThlejk2S09nQkRLNGFKTUdDMWdFcDEzRXYyN3Fubit5Y1BzbGxncHV5VnFn?=
 =?utf-8?B?c3NSUG1zNEZVYTNIejhGSCtUTlozdVhvcVJRYTdQNFlNMlB2eXBZaW15NUN5?=
 =?utf-8?B?MGRjc2p5ejlmMWhENDJ3MVBNZEVyc0tZZnJJMFYzQkxwYndZVUplbmNsdm9a?=
 =?utf-8?B?YzV4MGxKVDNwU3dLOCtNNTBVZDlJdnZBdFlHNlRKaUxyNHI2Sy9ueDBFV3dk?=
 =?utf-8?B?QUdvbER3akVJOElCck1HMXAxd2gvTFA2dFl2SkVsN0YyUzZEUlJ4aGh6Zzc2?=
 =?utf-8?B?ZjBaVFhhT2ViYVBIN2JuRks3SlBxQmZiOTlSa3Nvc3dLRVhUYWdwTGpWSmlR?=
 =?utf-8?B?Y0diMjh1UXMvL05Ubm83Ulg1dkhxaGJiNUNuWWdxZmsrZFBvN3RPZzdsTEZt?=
 =?utf-8?B?dDN5VEVvaGlMcnYyOU5xMWJ5SlZzT1J2V1dGOS9PaVJHR0t6d3hGVzhTRW9a?=
 =?utf-8?B?SzB5Zi84QVlPeDA4SW5IckExZVg3S2RlcjJTTTVHK3paRVY2ckE0NnI0OEli?=
 =?utf-8?B?SUJJT3B1SXR4c1JRZXM1MGFUdFdTWld0USt5MVJkWGNJaTJwSmVNR2c2N1J2?=
 =?utf-8?B?OFpaVXc4K051MW5adVMwb2pFWHNDK3JEOVh2YUJmWDYzVXZuQnNhK1RDTHlX?=
 =?utf-8?B?SGZZc1VaZ2dKK1Jvd1YwcDRLUTNGSzB2UnlDY1EweFJpUUh2WklrOXFSRW51?=
 =?utf-8?B?bnZTbGc1akhUT29HZ2xvemdZN3NVRnBMQ3pJR1RPMGxiS2JGc1ExdFdpT3lJ?=
 =?utf-8?B?ZTErMDN4R2RQenZoRVdqRGozWGJEampkQVhvMW0zZzk1MHFLQndYNmhZcU51?=
 =?utf-8?B?aUxpUGlwYW93WmdPT0pGbEdYMndIRnZtcGFwL3RPam1kSExhdk1OUjZMSngr?=
 =?utf-8?Q?XAwwBvQVxLpcy3F+o9SZAetgc?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d10e4a86-8e4a-4852-535b-08dd3568c756
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2025 13:30:29.5136 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: chW+XDWWxhHJNK185dUW8GaRVpMr/Bmhp51IMqF87sSb+Xt8CtRpyEg/w2wzKngysiH8cB/Kyi6B5fT9eKWqCw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8593
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

This patch adds i.MX95 19x19 EVK board basic support.

Messaging unit for EdgeLock Secure Enclave, messaging unit for System
Manager, uSDHC for SD Card, gpio, lpuart are supported now.

Signed-off-by: Ye Li <ye.li@nxp.com>
Signed-off-by: Alice Guo <alice.guo@nxp.com>
Reviewed-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm/dts/imx95-19x19-evk-u-boot.dtsi      |  68 ++++++++++
 arch/arm/dts/imx95-u-boot.dtsi                | 157 +++++++++++++++++++++++
 arch/arm/mach-imx/imx9/Kconfig                |   6 +
 arch/arm/mach-imx/imx9/scmi/container.cfg     |  10 ++
 arch/arm/mach-imx/imx9/scmi/imximage.cfg      |  15 +++
 board/freescale/imx95_evk/Kconfig             |  12 ++
 board/freescale/imx95_evk/MAINTAINERS         |   6 +
 board/freescale/imx95_evk/Makefile            |  11 ++
 board/freescale/imx95_evk/imx95_19x19_evk.env |  90 +++++++++++++
 board/freescale/imx95_evk/imx95_evk.c         |  54 ++++++++
 board/freescale/imx95_evk/spl.c               |  72 +++++++++++
 configs/imx95_19x19_evk_defconfig             | 177 ++++++++++++++++++++++++++
 doc/board/nxp/imx95_evk.rst                   | 114 +++++++++++++++++
 doc/board/nxp/index.rst                       |   1 +
 include/configs/imx95_evk.h                   |  27 ++++
 15 files changed, 820 insertions(+)

diff --git a/arch/arm/dts/imx95-19x19-evk-u-boot.dtsi b/arch/arm/dts/imx95-19x19-evk-u-boot.dtsi
new file mode 100644
index 0000000000000000000000000000000000000000..2902e8f711c3ef705df27ca4fc7a89d1bd7ffc71
--- /dev/null
+++ b/arch/arm/dts/imx95-19x19-evk-u-boot.dtsi
@@ -0,0 +1,68 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright 2025 NXP
+ */
+
+#include "imx95-u-boot.dtsi"
+
+&gpio1 {
+	reg = <0 0x47400000 0 0x1000>, <0 0x47400040 0 0x40>;
+};
+
+&lpuart1 {
+	clocks = <&scmi_clk IMX95_CLK_LPUART1>, <&scmi_clk IMX95_CLK_LPUART1>;
+	clock-names = "ipg", "per";
+	bootph-pre-ram;
+};
+
+&reg_usdhc2_vmmc {
+	bootph-pre-ram;
+};
+
+&usdhc1 {
+	bootph-pre-ram;
+};
+
+&usdhc2 {
+	bootph-pre-ram;
+};
+
+&wdog3 {
+	status = "disabled";
+};
+
+&pinctrl_uart1 {
+	bootph-pre-ram;
+};
+
+&pinctrl_usdhc1 {
+	bootph-pre-ram;
+};
+
+&pinctrl_usdhc1_100mhz {
+	bootph-pre-ram;
+};
+
+&pinctrl_usdhc1_200mhz {
+	bootph-pre-ram;
+};
+
+&pinctrl_usdhc2 {
+	bootph-pre-ram;
+};
+
+&pinctrl_usdhc2_100mhz {
+	bootph-pre-ram;
+};
+
+&pinctrl_usdhc2_200mhz {
+	bootph-pre-ram;
+};
+
+&pinctrl_usdhc2_gpio {
+	bootph-pre-ram;
+};
+
+&pinctrl_reg_usdhc2_vmmc {
+	bootph-pre-ram;
+};
diff --git a/arch/arm/dts/imx95-u-boot.dtsi b/arch/arm/dts/imx95-u-boot.dtsi
new file mode 100644
index 0000000000000000000000000000000000000000..b0dcf765a779e5cbf63911c12f089370fc886dbf
--- /dev/null
+++ b/arch/arm/dts/imx95-u-boot.dtsi
@@ -0,0 +1,157 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright 2025 NXP
+ */
+
+/ {
+	binman {
+		multiple-images;
+
+		m33-oei-ddrfw {
+			pad-byte = <0x00>;
+			align-size = <0x8>;
+			filename = "m33-oei-ddrfw.bin";
+
+			oei-m33-ddr {
+				align-size = <0x4>;
+				filename = "oei-m33-ddr.bin";
+				type = "blob-ext";
+			};
+
+			imx-lpddr {
+				type = "nxp-header-ddrfw";
+
+				imx-lpddr-imem {
+					filename = "lpddr5_imem_v202311.bin";
+					type = "blob-ext";
+				};
+
+				imx-lpddr-dmem {
+					filename = "lpddr5_dmem_v202311.bin";
+					type = "blob-ext";
+				};
+			};
+
+			imx-lpddr-qb {
+				type = "nxp-header-ddrfw";
+
+				imx-lpddr-imem-qb {
+					filename = "lpddr5_imem_qb_v202311.bin";
+					type = "blob-ext";
+				};
+
+				imx-lpddr-dmem-qb {
+					filename = "lpddr5_dmem_qb_v202311.bin";
+					type = "blob-ext";
+				};
+			};
+		};
+
+		imx-boot {
+			filename = "flash.bin";
+			pad-byte = <0x00>;
+
+			spl {
+				align = <0x400>;
+				align-size = <0x400>;
+				type = "mkimage";
+				args = "-n spl/u-boot-spl.cfgout -T imx8image";
+			};
+
+			u-boot {
+				type = "mkimage";
+				args = "-n u-boot-container.cfgout -T imx8image";
+			};
+		};
+	};
+};
+
+&aips1 {
+	bootph-all;
+};
+
+&aips2 {
+	bootph-all;
+};
+
+&aips3 {
+	bootph-pre-ram;
+};
+
+&clk_ext1 {
+	bootph-all;
+};
+
+&elemu3 {
+	compatible = "fsl,imx93-mu-s4";
+	status = "okay";
+	bootph-all;
+};
+
+&{/firmware} {
+	bootph-all;
+};
+
+&{/firmware/scmi} {
+	bootph-all;
+};
+
+&{/firmware/scmi/protocol@11} {
+	bootph-all;
+};
+
+&{/firmware/scmi/protocol@13} {
+	bootph-all;
+};
+
+&{/firmware/scmi/protocol@14} {
+	bootph-all;
+};
+
+&{/firmware/scmi/protocol@19} {
+	bootph-all;
+};
+
+&gpio2 {
+	reg = <0 0x43810000 0 0x1000>, <0 0x43810040 0 0x40>;
+	bootph-pre-ram;
+};
+
+&gpio3 {
+	reg = <0 0x43820000 0 0x1000>, <0 0x43820040 0 0x40>;
+	bootph-pre-ram;
+};
+
+&gpio4 {
+	reg = <0 0x43840000 0 0x1000>, <0 0x43840040 0 0x40>;
+	bootph-pre-ram;
+};
+
+&gpio5 {
+	reg = <0 0x43850000 0 0x1000>, <0 0x43850040 0 0x40>;
+	bootph-pre-ram;
+};
+
+&mu2 {
+	bootph-all;
+};
+
+&osc_24m {
+	bootph-all;
+};
+
+&{/soc} {
+	bootph-all;
+};
+
+&sram0 {
+	bootph-all;
+};
+
+&scmi_buf0 {
+	bootph-all;
+};
+
+&scmi_buf1 {
+	bootph-all;
+};
diff --git a/arch/arm/mach-imx/imx9/Kconfig b/arch/arm/mach-imx/imx9/Kconfig
index 660529555e9b3d38a6fb70c77858bd9de7473461..4dd73f0a9e525ebbb8559639f914504ec53f15dd 100644
--- a/arch/arm/mach-imx/imx9/Kconfig
+++ b/arch/arm/mach-imx/imx9/Kconfig
@@ -68,6 +68,11 @@ config TARGET_PHYCORE_IMX93
 	select OF_BOARD_FIXUP
 	select OF_BOARD_SETUP
 
+config TARGET_IMX95_19X19_EVK
+	bool "imx95_19x19_evk"
+	select IMX95
+	imply OF_UPSTREAM
+
 endchoice
 
 source "board/freescale/imx91_evk/Kconfig"
@@ -75,6 +80,7 @@ source "board/freescale/imx93_evk/Kconfig"
 source "board/freescale/imx93_qsb/Kconfig"
 source "board/phytec/phycore_imx93/Kconfig"
 source "board/variscite/imx93_var_som/Kconfig"
+source "board/freescale/imx95_evk/Kconfig"
 
 endif
 
diff --git a/arch/arm/mach-imx/imx9/scmi/container.cfg b/arch/arm/mach-imx/imx9/scmi/container.cfg
new file mode 100644
index 0000000000000000000000000000000000000000..ac5a0a281812faf9edff53b49cc19ed769352d71
--- /dev/null
+++ b/arch/arm/mach-imx/imx9/scmi/container.cfg
@@ -0,0 +1,10 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Copyright 2025 NXP
+ */
+
+BOOT_FROM SD
+SOC_TYPE IMX9
+CONTAINER
+IMAGE A55 bl31.bin 0x8a200000
+IMAGE A55 u-boot.bin CONFIG_TEXT_BASE
\ No newline at end of file
diff --git a/arch/arm/mach-imx/imx9/scmi/imximage.cfg b/arch/arm/mach-imx/imx9/scmi/imximage.cfg
new file mode 100644
index 0000000000000000000000000000000000000000..678d15c99be78598ff8dd7a4218530e43e9db2c0
--- /dev/null
+++ b/arch/arm/mach-imx/imx9/scmi/imximage.cfg
@@ -0,0 +1,15 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Copyright 2025 NXP
+ */
+
+BOOT_FROM SD
+SOC_TYPE IMX9
+APPEND mx95a0-ahab-container.img
+CONTAINER
+IMAGE OEI m33-oei-ddrfw.bin 0x1ffc0000
+HOLD 0x10000
+IMAGE OEI oei-m33-tcm.bin 0x1ffc0000
+IMAGE M33 m33_image.bin 0x1ffc0000
+IMAGE A55 spl/u-boot-spl.bin 0x20480000
+DUMMY_V2X 0x8b000000
\ No newline at end of file
diff --git a/board/freescale/imx95_evk/Kconfig b/board/freescale/imx95_evk/Kconfig
new file mode 100644
index 0000000000000000000000000000000000000000..f9a67353e5db6d3ec94784cf091e45d8817d541c
--- /dev/null
+++ b/board/freescale/imx95_evk/Kconfig
@@ -0,0 +1,12 @@
+if TARGET_IMX95_19X19_EVK
+
+config SYS_BOARD
+	default "imx95_evk"
+
+config SYS_VENDOR
+	default "freescale"
+
+config SYS_CONFIG_NAME
+	default "imx95_evk"
+
+endif
diff --git a/board/freescale/imx95_evk/MAINTAINERS b/board/freescale/imx95_evk/MAINTAINERS
new file mode 100644
index 0000000000000000000000000000000000000000..5caf763e0cc390c46fc54ee627bc966b2b110958
--- /dev/null
+++ b/board/freescale/imx95_evk/MAINTAINERS
@@ -0,0 +1,6 @@
+i.MX95 EVK BOARD
+M:	Alice Guo <alice.guo@nxp.com>
+S:	Maintained
+F:	board/freescale/imx95_evk/
+F:	include/configs/imx95_evk.h
+F:	configs/imx95_19x19_evk_defconfig
diff --git a/board/freescale/imx95_evk/Makefile b/board/freescale/imx95_evk/Makefile
new file mode 100644
index 0000000000000000000000000000000000000000..0f5cec385c35059ac5bbcf31868855c10a6c2fe4
--- /dev/null
+++ b/board/freescale/imx95_evk/Makefile
@@ -0,0 +1,11 @@
+#
+# Copyright 2025 NXP
+#
+# SPDX-License-Identifier:      GPL-2.0+
+#
+
+obj-y += imx95_evk.o
+
+ifdef CONFIG_SPL_BUILD
+obj-y += spl.o
+endif
diff --git a/board/freescale/imx95_evk/imx95_19x19_evk.env b/board/freescale/imx95_evk/imx95_19x19_evk.env
new file mode 100644
index 0000000000000000000000000000000000000000..8d2b5dfcf07d251c77440bae44d62bff6253dfc7
--- /dev/null
+++ b/board/freescale/imx95_evk/imx95_19x19_evk.env
@@ -0,0 +1,90 @@
+sec_boot=no
+initrd_addr=0x93800000
+emmc_dev=0
+sd_dev=1
+scriptaddr=0x93500000
+kernel_addr_r=CONFIG_SYS_LOAD_ADDR
+image=Image
+splashimage=0xA0000000
+console=ttyLP0,115200 earlycon
+fdt_addr_r=0x93000000
+fdt_addr=0x93000000
+cntr_addr=0xA8000000
+cntr_file=os_cntr_signed.bin
+boot_fit=no
+fdtfile=CONFIG_DEFAULT_FDT_FILE
+bootm_size=0x10000000
+mmcautodetect=yes
+mmcargs=setenv bootargs console=${console} root=${mmcroot}
+loadbootscript=fatload mmc ${mmcdev}:${mmcpart} ${loadaddr} ${script};
+bootscript=echo Running bootscript from mmc ...; source
+loadimage=fatload mmc ${mmcdev}:${mmcpart} ${loadaddr} ${image}
+loadfdt=fatload mmc ${mmcdev}:${mmcpart} ${fdt_addr_r} ${fdtfile}
+loadcntr=fatload mmc ${mmcdev}:${mmcpart} ${cntr_addr} ${cntr_file}
+auth_os=auth_cntr ${cntr_addr}
+boot_os=booti ${loadaddr} - ${fdt_addr_r};
+mmcboot=echo Booting from mmc ...;
+		run mmcargs;
+		if test ${sec_boot} = yes; then
+			if run auth_os; then
+				run boot_os;
+			else
+				echo ERR: failed to authenticate;
+			fi;
+		else
+			if test ${boot_fit} = yes || test ${boot_fit} = try; then
+				bootm ${loadaddr};
+			else
+				if run loadfdt; then
+					run boot_os;
+				else
+					echo WARN: Cannot load the DT;
+				fi;
+			fi;
+		fi;
+netargs=setenv bootargs console=${console} root=/dev/nfs
+		ip=dhcp nfsroot=${serverip}:${nfsroot},v3,tcp
+netboot=echo Booting from net ...;
+		run netargs;
+		if test ${ip_dyn} = yes; then
+			setenv get_cmd dhcp;
+		else
+			setenv get_cmd tftp;
+		fi;
+		if test ${sec_boot} = yes; then
+			${get_cmd} ${cntr_addr} ${cntr_file};
+			if run auth_os; then
+				run boot_os;
+			else
+				echo ERR: failed to authenticate;
+			fi;
+		else
+			${get_cmd} ${loadaddr} ${image};
+			if test ${boot_fit} = yes || test ${boot_fit} = try; then
+				bootm ${loadaddr};
+			else
+				if ${get_cmd} ${fdt_addr_r} ${fdtfile}; then
+					run boot_os;
+				else
+					echo WARN: Cannot load the DT;
+				fi;
+			fi;
+		fi;
+bsp_bootcmd=echo Running BSP bootcmd ...;
+			mmc dev ${mmcdev}; if mmc rescan; then
+			if run loadbootscript; then
+				run bootscript;
+			else
+				if test ${sec_boot} = yes; then
+					if run loadcntr; then
+						run mmcboot;
+					else run netboot;
+					fi;
+				else
+					if run loadimage; then
+						run mmcboot;
+					else run netboot;
+					fi;
+				fi;
+			fi;
+		fi;
\ No newline at end of file
diff --git a/board/freescale/imx95_evk/imx95_evk.c b/board/freescale/imx95_evk/imx95_evk.c
new file mode 100644
index 0000000000000000000000000000000000000000..1ed15ca47b157067a7376b0b32101dc7f9899f4f
--- /dev/null
+++ b/board/freescale/imx95_evk/imx95_evk.c
@@ -0,0 +1,54 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright 2025 NXP
+ */
+
+#include <env.h>
+#include <init.h>
+#include <asm/global_data.h>
+#include <asm/arch-imx9/ccm_regs.h>
+#include <asm/arch/clock.h>
+#include <fdt_support.h>
+#include <asm/io.h>
+#include <linux/bitfield.h>
+#include <linux/bitops.h>
+#include <linux/delay.h>
+#include <miiphy.h>
+#include <netdev.h>
+#include <asm/gpio.h>
+#include <asm/mach-imx/sys_proto.h>
+#include <scmi_agent.h>
+#include <scmi_protocols.h>
+#include "../../../dts/upstream/src/arm64/freescale/imx95-clock.h"
+#include "../../../dts/upstream/src/arm64/freescale/imx95-power.h"
+
+DECLARE_GLOBAL_DATA_PTR;
+
+int board_early_init_f(void)
+{
+	/* UART1: A55, UART2: M33, UART3: M7 */
+	init_uart_clk(0);
+
+	return 0;
+}
+
+int board_init(void)
+{
+	return 0;
+}
+
+int board_late_init(void)
+{
+#ifdef CONFIG_ENV_IS_IN_MMC
+	board_late_mmc_env_init();
+#endif
+
+	return 0;
+}
+
+int board_phys_sdram_size(phys_size_t *size)
+{
+	*size = PHYS_SDRAM_SIZE + PHYS_SDRAM_2_SIZE;
+
+	return 0;
+}
diff --git a/board/freescale/imx95_evk/spl.c b/board/freescale/imx95_evk/spl.c
new file mode 100644
index 0000000000000000000000000000000000000000..63050379237d7204dd38ba87e50229e5339dccea
--- /dev/null
+++ b/board/freescale/imx95_evk/spl.c
@@ -0,0 +1,72 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright 2025 NXP
+ */
+
+#include <asm/arch/clock.h>
+#include <asm/arch/mu.h>
+#include <asm/mach-imx/boot_mode.h>
+#include <asm/sections.h>
+#include <hang.h>
+#include <init.h>
+#include <spl.h>
+
+DECLARE_GLOBAL_DATA_PTR;
+
+int spl_board_boot_device(enum boot_device boot_dev_spl)
+{
+	switch (boot_dev_spl) {
+	case SD1_BOOT:
+	case MMC1_BOOT:
+		return BOOT_DEVICE_MMC1;
+	case SD2_BOOT:
+	case MMC2_BOOT:
+		return BOOT_DEVICE_MMC2;
+	case USB_BOOT:
+		return BOOT_DEVICE_BOARD;
+	default:
+		return BOOT_DEVICE_NONE;
+	}
+}
+
+void spl_board_init(void)
+{
+	puts("Normal Boot\n");
+}
+
+void board_init_f(ulong dummy)
+{
+	int ret;
+
+	/* Clear the BSS. */
+	memset(__bss_start, 0, __bss_end - __bss_start);
+
+#ifdef CONFIG_SPL_RECOVER_DATA_SECTION
+	if (IS_ENABLED(CONFIG_SPL_BUILD))
+		spl_save_restore_data();
+#endif
+
+	timer_init();
+
+	/* Need dm_init() to run before any SCMI calls can be made. */
+	spl_early_init();
+
+	/* Need enable SCMI drivers and ELE driver before enabling console */
+	ret = imx9_probe_mu();
+	if (ret)
+		hang(); /* if MU not probed, nothing can output, just hang here */
+
+	arch_cpu_init();
+
+	board_early_init_f();
+
+	preloader_console_init();
+
+	debug("SOC: 0x%x\n", gd->arch.soc_rev);
+	debug("LC: 0x%x\n", gd->arch.lifecycle);
+
+	/* Will set ARM freq to max rate */
+	clock_init_late();
+
+	board_init_r(NULL, 0);
+}
diff --git a/configs/imx95_19x19_evk_defconfig b/configs/imx95_19x19_evk_defconfig
new file mode 100644
index 0000000000000000000000000000000000000000..4d6b194528e7f3124e6626b28be0d6344758f6e5
--- /dev/null
+++ b/configs/imx95_19x19_evk_defconfig
@@ -0,0 +1,177 @@
+CONFIG_ARM=y
+CONFIG_ARCH_IMX9=y
+CONFIG_TEXT_BASE=0x90200000
+CONFIG_SYS_MALLOC_LEN=0x2000000
+CONFIG_SYS_MALLOC_F_LEN=0x10000
+CONFIG_SPL_LIBCOMMON_SUPPORT=y
+CONFIG_SPL_LIBGENERIC_SUPPORT=y
+CONFIG_NR_DRAM_BANKS=3
+CONFIG_ENV_SIZE=0x4000
+CONFIG_ENV_OFFSET=0x700000
+CONFIG_ENV_SECT_SIZE=0x10000
+CONFIG_DM_GPIO=y
+CONFIG_DEFAULT_DEVICE_TREE="freescale/imx95-19x19-evk"
+CONFIG_SPL_TEXT_BASE=0x20480000
+CONFIG_TARGET_IMX95_19X19_EVK=y
+CONFIG_SYS_PROMPT="u-boot=> "
+CONFIG_SPL_SERIAL=y
+CONFIG_SPL_DRIVERS_MISC=y
+CONFIG_SPL_STACK=0x204d6000
+CONFIG_SPL=y
+CONFIG_SPL_LOAD_IMX_CONTAINER=y
+CONFIG_IMX_CONFIG="arch/arm/mach-imx/imx9/scmi/imximage.cfg"
+CONFIG_IMX_CONTAINER_CFG="arch/arm/mach-imx/imx9/scmi/container.cfg"
+CONFIG_SYS_LOAD_ADDR=0x90400000
+CONFIG_SYS_MEMTEST_START=0x90000000
+CONFIG_SYS_MEMTEST_END=0xA0000000
+CONFIG_REMAKE_ELF=y
+CONFIG_SYS_MONITOR_LEN=524288
+CONFIG_DEFAULT_FDT_FILE="imx95-19x19-evk.dtb"
+CONFIG_ARCH_MISC_INIT=y
+CONFIG_BOARD_EARLY_INIT_F=y
+CONFIG_BOARD_LATE_INIT=y
+CONFIG_SPL_MAX_SIZE=0x20000
+CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
+CONFIG_SPL_BSS_START_ADDR=0x204d6000
+CONFIG_SPL_BSS_MAX_SIZE=0x2000
+CONFIG_SPL_BOARD_INIT=y
+CONFIG_SPL_MMC=y
+CONFIG_SPL_GPIO=y
+# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
+CONFIG_SPL_SYS_MALLOC=y
+CONFIG_SPL_HAS_CUSTOM_MALLOC_START=y
+CONFIG_SPL_CUSTOM_SYS_MALLOC_ADDR=0x93200000
+CONFIG_SPL_SYS_MALLOC_SIZE=0x80000
+CONFIG_SPL_SYS_MMCSD_RAW_MODE=y
+CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_SECTOR=y
+CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR=0x1040
+CONFIG_SPL_POWER=y
+CONFIG_SDP_LOADADDR=0x90400000
+CONFIG_SPL_WATCHDOG=y
+CONFIG_SYS_MAXARGS=64
+CONFIG_SYS_CBSIZE=2048
+CONFIG_SYS_PBSIZE=2074
+CONFIG_CMD_ERASEENV=y
+CONFIG_CMD_NVEDIT_EFI=y
+CONFIG_CMD_CRC32=y
+CONFIG_CRC32_VERIFY=y
+CONFIG_CMD_MEMTEST=y
+CONFIG_CMD_CLK=y
+CONFIG_CMD_DFU=y
+CONFIG_CMD_FUSE=y
+CONFIG_CMD_GPIO=y
+CONFIG_CMD_GPT=y
+CONFIG_CMD_I2C=y
+CONFIG_CMD_MMC=y
+CONFIG_CMD_PART=y
+CONFIG_CMD_POWEROFF=y
+CONFIG_CMD_DHCP=y
+CONFIG_CMD_MII=y
+CONFIG_CMD_PING=y
+CONFIG_CMD_SNTP=y
+CONFIG_CMD_CACHE=y
+CONFIG_CMD_EFIDEBUG=y
+CONFIG_CMD_RTC=y
+CONFIG_CMD_TIME=y
+CONFIG_CMD_GETTIME=y
+CONFIG_CMD_TIMER=y
+CONFIG_CMD_REGULATOR=y
+CONFIG_CMD_HASH=y
+CONFIG_CMD_EXT2=y
+CONFIG_CMD_EXT4=y
+CONFIG_CMD_EXT4_WRITE=y
+CONFIG_CMD_FAT=y
+CONFIG_CMD_FS_GENERIC=y
+CONFIG_OF_CONTROL=y
+CONFIG_SPL_OF_CONTROL=y
+CONFIG_ENV_OVERWRITE=y
+CONFIG_ENV_IS_NOWHERE=y
+CONFIG_ENV_IS_IN_MMC=y
+CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_SYS_MMC_ENV_DEV=1
+CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
+CONFIG_USE_ETHPRIME=y
+CONFIG_ETHPRIME="eth0"
+CONFIG_NET_RANDOM_ETHADDR=y
+CONFIG_SPL_DM=y
+CONFIG_REGMAP=y
+CONFIG_SYSCON=y
+CONFIG_DFU_MMC=y
+CONFIG_DFU_RAM=y
+CONFIG_IMX_RGPIO2P=y
+CONFIG_MTD=y
+CONFIG_DM_SPI_FLASH=y
+CONFIG_DM_SPI=y
+CONFIG_NXP_FSPI=y
+CONFIG_SPI=y
+CONFIG_SPI_FLASH_STMICRO=y
+CONFIG_SPI_FLASH_MT35XU=y
+CONFIG_SF_DEFAULT_BUS=0
+CONFIG_SF_DEFAULT_SPEED=40000000
+CONFIG_DM_PCA953X=y
+CONFIG_DM_I2C=y
+CONFIG_SYS_I2C_IMX_LPI2C=y
+CONFIG_SUPPORT_EMMC_BOOT=y
+CONFIG_MMC_IO_VOLTAGE=y
+CONFIG_MMC_UHS_SUPPORT=y
+CONFIG_MMC_HS400_ES_SUPPORT=y
+CONFIG_MMC_HS400_SUPPORT=y
+CONFIG_FSL_USDHC=y
+CONFIG_PHY=y
+CONFIG_MII=y
+CONFIG_PINCTRL=y
+CONFIG_SPL_PINCTRL=y
+CONFIG_SPL_DM_REGULATOR=y
+CONFIG_SPL_DM_REGULATOR_FIXED=y
+CONFIG_DM_REGULATOR=y
+CONFIG_DM_REGULATOR_FIXED=y
+CONFIG_DM_REGULATOR_GPIO=y
+CONFIG_DM_RTC=y
+CONFIG_DM_SERIAL=y
+CONFIG_FSL_LPUART=y
+CONFIG_ULP_WATCHDOG=y
+CONFIG_LZO=y
+CONFIG_BZIP2=y
+CONFIG_HUSH_PARSER=y
+CONFIG_OF_LIBFDT_OVERLAY=y
+CONFIG_OF_SYSTEM_SETUP=y
+CONFIG_ADP5585_GPIO=y
+CONFIG_SPL_I2C=y
+CONFIG_POWER_DOMAIN=y
+# SCMI options
+CONFIG_DM_MAILBOX=y
+CONFIG_SCMI_FIRMWARE=y
+CONFIG_SCMI_AGENT_SMCCC=n
+CONFIG_CLK_SCMI=y
+CONFIG_CLK=y
+CONFIG_SPL_CLK_SCMI=y
+CONFIG_SPL_CLK=y
+CONFIG_PINCTRL_IMX_SCMI=y
+CONFIG_SCMI_POWER_DOMAIN=y
+CONFIG_SPL_DM_MAILBOX=y
+CONFIG_SPL_FIRMWARE=y
+#CONFIG_SPL_POWER_DOMAIN=y
+CONFIG_SPL_IMX_MU_MBOX=y
+CONFIG_IMX_MU_MBOX=y
+#CONFIG_REMOTEPROC_SCMI_LMM=y
+#CONFIG_CMD_REMOTEPROC=y
+# CONFIG_RESET_SCMI=y
+# CONFIG_DM_REGULATOR_SCMI=y
+CONFIG_SPL_OF_TRANSLATE=y
+CONFIG_PCI=y
+CONFIG_PCIE_ECAM_GENERIC=y
+CONFIG_PCI_SCAN_SHOW=y
+CONFIG_CMD_PCI=y
+CONFIG_DM_ETH=y
+CONFIG_DM_MDIO=y
+CONFIG_PHYLIB=y
+CONFIG_PHYLIB_10G=y
+CONFIG_PHY_AQUANTIA=y
+CONFIG_PHY_REALTEK=y
+CONFIG_FSL_ENETC=y
+CONFIG_SYS_RX_ETH_BUFFER=8
+CONFIG_IMX8_ROMAPI=n
+CONFIG_CLK_CCF=y
+CONFIG_SPL_CLK_CCF=y
+CONFIG_SPL_RECOVER_DATA_SECTION=y
+CONFIG_ENV_SOURCE_FILE="imx95_19x19_evk"
diff --git a/doc/board/nxp/imx95_evk.rst b/doc/board/nxp/imx95_evk.rst
new file mode 100644
index 0000000000000000000000000000000000000000..5554e96f999240638819b556c082f9bb968c7a0e
--- /dev/null
+++ b/doc/board/nxp/imx95_evk.rst
@@ -0,0 +1,114 @@
+.. SPDX-License-Identifier: GPL-2.0+
+
+imx95_evk
+=======================
+
+U-Boot for the NXP i.MX95 19x19 EVK board
+
+Quick Start
+-----------
+
+- Get ahab-container.img
+- Get DDR PHY Firmware Images
+- Get and Build OEI Images
+- Get and Build System Manager Image
+- Get and Build the ARM Trusted Firmware
+- Build the Bootloader Image
+- Boot
+
+Get ahab-container.img
+--------------------------------------
+
+Note: srctree is U-Boot source directory
+
+.. code-block:: bash
+
+   $ wget https://www.nxp.com/lgfiles/NMG/MAD/YOCTO/firmware-ele-imx-1.3.0-17945fc.bin
+   $ sh firmware-ele-imx-1.3.0-17945fc.bin --auto-accept
+   $ cp firmware-ele-imx-1.3.0-17945fc/mx95a0-ahab-container.img $(srctree)
+
+Get DDR PHY Firmware Images
+--------------------------------------
+
+Note: srctree is U-Boot source directory
+
+.. code-block:: bash
+
+   $ wget https://www.nxp.com/lgfiles/NMG/MAD/YOCTO/firmware-imx-8.26-d4c33ab.bin
+   $ sh firmware-imx-8.26-d4c33ab.bin --auto-accept
+   $ cp firmware-imx-8.26-d4c33ab/firmware/ddr/synopsys/lpddr5*v202311.bin $(srctree)
+
+Get and Build OEI Images
+--------------------------------------
+
+Note: srctree is U-Boot source directory
+Get OEI from: https://github.com/nxp-imx/imx-oei
+branch: master
+
+.. code-block:: bash
+
+   $ sudo apt -y install make gcc g++-multilib srecord
+   $ wget https://developer.arm.com/-/media/Files/downloads/gnu/13.3.rel1/binrel/arm-gnu-toolchain-13.3.rel1-x86_64-arm-none-eabi.tar.xz
+   $ tar xvf arm-gnu-toolchain-13.3.rel1-x86_64-arm-none-eabi.tar.xz
+   $ export TOOLS=$PWD
+   $ git clone -b master https://github.com/nxp-imx/imx-oei.git
+   $ cd imx-oei
+   $ make board=mx95lp5 oei=ddr DEBUG=1
+   $ cp build/mx95lp5/ddr/oei-m33-ddr.bin $(srctree)
+
+   $ make board=mx95lp5 oei=tcm DEBUG=1
+   $ cp build/mx95lp5/tcm/oei-m33-tcm.bin $(srctree)
+
+Get and Build System Manager Image
+--------------------------------------
+
+Note: srctree is U-Boot source directory
+Get System Manager from: https://github.com/nxp-imx/imx-sm
+branch: master
+
+.. code-block:: bash
+
+   $ sudo apt -y install make gcc g++-multilib srecord
+   $ wget https://developer.arm.com/-/media/Files/downloads/gnu/13.3.rel1/binrel/arm-gnu-toolchain-13.3.rel1-x86_64-arm-none-eabi.tar.xz
+   $ tar xvf arm-gnu-toolchain-13.3.rel1-x86_64-arm-none-eabi.tar.xz
+   $ export TOOLS=$PWD
+   $ git clone -b master https://github.com/nxp-imx/imx-sm.git
+   $ cd imx-sm
+   $ make config=mx95evk all
+   $ cp build/mx95evk/m33_image.bin $(srctree)
+
+Get and Build the ARM Trusted Firmware
+--------------------------------------
+
+Note: srctree is U-Boot source directory
+Get ATF from: https://github.com/nxp-imx/imx-atf/
+branch: lf_v2.10
+
+.. code-block:: bash
+
+   $ export CROSS_COMPILE=aarch64-poky-linux-
+   $ unset LDFLAGS
+   $ git clone -b lf_v2.10 https://github.com/nxp-imx/imx-atf.git
+   $ cd imx-atf
+   $ make PLAT=imx95 bl31
+   $ cp build/imx95/release/bl31.bin $(srctree)
+
+Build the Bootloader Image
+------------
+
+.. code-block:: bash
+
+   $ export CROSS_COMPILE=aarch64-poky-linux-
+   $ make imx95_19x19_evk_defconfig
+   $ make
+
+Copy imx-boot-imx95.bin to the MicroSD card:
+
+.. code-block:: bash
+
+   $ sudo dd if=flash.bin of=/dev/sd[x] bs=1k seek=32 conv=fsync
+
+Boot
+----
+
+Set i.MX95 boot device to MicroSD card
diff --git a/doc/board/nxp/index.rst b/doc/board/nxp/index.rst
index 8ca4b5619863f616dbedc7eb0ff8a286a3fbbf48..e7ec725cc04e9755ba3dac37561c26ebc3f1c716 100644
--- a/doc/board/nxp/index.rst
+++ b/doc/board/nxp/index.rst
@@ -15,6 +15,7 @@ NXP Semiconductors
    imx91_11x11_evk
    imx93_9x9_qsb
    imx93_11x11_evk
+   imx95_evk
    imxrt1020-evk
    imxrt1050-evk
    imxrt1170-evk
diff --git a/include/configs/imx95_evk.h b/include/configs/imx95_evk.h
new file mode 100644
index 0000000000000000000000000000000000000000..b077fa7af7d1e56a00278d0f3feb9fd7b0c55f42
--- /dev/null
+++ b/include/configs/imx95_evk.h
@@ -0,0 +1,27 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Copyright 2025 NXP
+ */
+
+#ifndef __IMX95_EVK_H
+#define __IMX95_EVK_H
+
+#include <linux/sizes.h>
+#include <linux/stringify.h>
+#include <asm/arch/imx-regs.h>
+
+#define CFG_SYS_UBOOT_BASE	\
+	(QSPI0_AMBA_BASE + CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR * 512)
+
+#define CFG_SYS_INIT_RAM_ADDR	0x90000000
+#define CFG_SYS_INIT_RAM_SIZE	0x200000
+
+#define CFG_SYS_SDRAM_BASE		0x90000000
+#define PHYS_SDRAM				0x90000000
+/* Totally 16GB */
+#define PHYS_SDRAM_SIZE			0x70000000 /* 2GB - 256MB DDR */
+#define PHYS_SDRAM_2_SIZE		0x380000000 /* 14GB */
+
+#define WDOG_BASE_ADDR			WDG3_BASE_ADDR
+
+#endif

-- 
2.34.1

