Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6854FCDD56E
	for <u-boot@archiver.kernel.org>; Thu, 19 Sep 2024 03:00:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 312558905D;
	Thu, 19 Sep 2024 04:58:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="HMeLWON1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3E10E89060; Thu, 19 Sep 2024 04:58:45 +0200 (CEST)
Received: from EUR03-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur03on20612.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260c::612])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BFCBA89070
 for <u-boot@lists.denx.de>; Thu, 19 Sep 2024 04:58:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yDQf3XbsrUZKdTr1sjTiJb6j8HvKDfqsWVRYgqbhJnAX+U/3/jHTUl+lZHTMg5T5+zyhGiHt+Igp/DBwaqjMSiEeYXcxxGt2NjTbiNvaZXnIq0ppxDH92ImW8ca9gZDUqnAsfTC2bc6TzbYhSrQJU1MLeqi4Y3WaU0mH9kCWC9aEkU5nI5e74811/4xRYxfBR04M2fcGx3s96yB+l7P8pn1ughvQyUXdsjboJVVPjcltMpDL2alseb0Ks2s4Z/vMJkQmQo5vUToETXtlzltuUHre/NUMnJoVV34eWl9NnZwzNI/lojewZBF64Bx2MiOhhljkV7S9p3viffRdNCkMFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TYLU9TkriZv8PtK2vjaKH5sk78Q/yWWCHBnt6kSUlPU=;
 b=tBqfmA8z8uBBfhp52nRdQ6y6I38gwhjdIiieI/pxOx4USR9xhtkajXFFiyMNkzCd4OXvg23GuldJCVuyVQ+kAsC+YXu8B0rwxFaLVYmEcySp08lsu4EkfglhjjTiBSLKe8KfyMJ/vX/LzGrgpTdJtWlBOEkFJ9MyMCJt2yG2yOKfPDr47r3WvcA0Gna0nOTNlHQpTKW8Tur/HUP2XAjnHDWJVanWl/M+vBa9p3cUTykVO3j8AbumGx9ufpqoabGvXgW6W5Z1eyuzA1H5Q/KdOrWz2DFy4JEbAquM8ydqzbOxwUBwPMzU2elJiwZ07ijxwLe5zscZ4h7hihTOdXV2sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TYLU9TkriZv8PtK2vjaKH5sk78Q/yWWCHBnt6kSUlPU=;
 b=HMeLWON1VBDpVKmak6qlg56E7WQLrJ1ER1HIU7y+Qf8GdePthkxrqT3F/G57PtxjNm4poCFyceCzjW+GMPhHFVaMAkMPyZBcUroe89+HvKkM0I59Q/sj6tRQA29bzq/vruYrnbks9k8zOhjbLArOjfCDFwRuYiGal/+mSRbwQJNPr5GkLukk8bEyi6YJs68wqR0muhe0HWdPEq15D5Xb1NvZxnDswYo/ljec/eR/wOSXABG21QPCl2y+w3dFJv4se0GFpBCq9yP1+MnfOx1lV7r6XlNjPDeqynSb8dXlyGMUjarOt1pIjJBbNgg0lfrQ/oIOUjRl+UosWgaHVjo7rQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AS8PR04MB8867.eurprd04.prod.outlook.com (2603:10a6:20b:42e::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27; Thu, 19 Sep
 2024 02:58:40 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%6]) with mapi id 15.20.7982.018; Thu, 19 Sep 2024
 02:58:40 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Thu, 19 Sep 2024 12:01:32 +0800
Subject: [PATCH v3 14/21] imx9: soc: Disable cpu1 for variants that only
 has one A55 core
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240919-imx9-update-v3-14-80f9786cd1f0@nxp.com>
References: <20240919-imx9-update-v3-0-80f9786cd1f0@nxp.com>
In-Reply-To: <20240919-imx9-update-v3-0-80f9786cd1f0@nxp.com>
To: Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
Cc: u-boot@lists.denx.de, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.1
X-ClientProxiedBy: SI2P153CA0013.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::12) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|AS8PR04MB8867:EE_
X-MS-Office365-Filtering-Correlation-Id: 195625aa-eaba-4cf6-2497-08dcd856f6cd
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|52116014|366016|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?K01mMDE0aWdXTTZVT09LeGs4ZTVHOHBZQ2JrZUVMeXJBQVY4THc5dUNBN053?=
 =?utf-8?B?cThCRU1KMlVEc0RJZS9zS0lJczRhUnhFYzVHUlFOaWd5SGZaYkVQUkR4Tkxl?=
 =?utf-8?B?WDdiRWQzeHNCMTFHMUJLU3dFRjhETXJDOUtGMTRsdDR0VzJ0dGlwR2I3MWxP?=
 =?utf-8?B?akl0QTdKMyttWmk3bmVGRWZjV2NyRjB2bENwcTBYbDNKOVJFK1BxTDI5NUtP?=
 =?utf-8?B?Rk1YTHRZeVcvOTVYOHV4UXA0SHd6czVQa2tSL0pkb0dGU05OSzFPcGxYTE5E?=
 =?utf-8?B?OGtTR2J0SnlsbE03K01yRHAxdThjdGlXekhoWFdzZy9XZUNFQjR1UVVxNkRo?=
 =?utf-8?B?MkRZZDM2WHNqTVo3bGhhL1FDSHJ1WWN4Y05CWDE0ZU9DTVRBcGxKMEZ6bmhv?=
 =?utf-8?B?WTN6M0hNdzFjS0IrZXorTWRMWDNNREtYUHE1cUczcXRBTzRuODVIank4Tjcr?=
 =?utf-8?B?T2FoLzlDUFk4THErRXMzbHNnSFVNa09LUFQ5VC9VU3BjUnM0RW00WTNkT2J2?=
 =?utf-8?B?UEh1RU4vQ1pQLzdrUzZBSENYTTRhUXpRZTJjN1k5czJoVFl5Y05xbnZLcVk2?=
 =?utf-8?B?RFBmakZ0bHVzYWN5SGIyZm5LaEZuQjVPMEp6RXNKTnN2MlB5cXZzbmlLV2M1?=
 =?utf-8?B?ODZkZ1lya0t3Z21VakRSRnU0N3RaNHlmZTFOR1FNVTdFUDQzTmNzdllseXlz?=
 =?utf-8?B?ZTR6UmtZTHE5aXRUVUNDcXNjZHgwQ2U5VzhlUmVBejZUcE44M0ZsQ3hGUjd5?=
 =?utf-8?B?ZlJIOVBOdWpCQ0dlNVpHbnJOc2hXUWRYQmxIcU10M0hPemJFSWtnRVIwMWNa?=
 =?utf-8?B?SkIyQTJZWVFxYlBCSDNLQ3I2T0x2UXZlb2lVWUc0OEE5NnJXMkdoWjhQTXhr?=
 =?utf-8?B?bFpFZC9CRFpMYTlJZU41dEs2VHBUOTdHbzJWWmdsZUQvUHdWSFE0Ky9jT0M3?=
 =?utf-8?B?clJ1bWVpNFpFdlBYejBSRWNjL0orcVhDd2JCbjUrMUswSkJtMCt6RGxLbWFu?=
 =?utf-8?B?TDYzQU94MC85Sk56b0R4U1ZIa2loVkZzeW9TWVRCaTlzQm9nZS9QUi9NM3Bh?=
 =?utf-8?B?K0xjazdLY3U5cjJxODMrVm05MkxBUmFDejNSWmgwaG9pdFhxL2I2UVdtQ2lh?=
 =?utf-8?B?VWVDOXhjOUF1RGR6U1B4bGlqMTdSeXl4RHR6WXNMTEZRanhPTkRKcUVMQ3hm?=
 =?utf-8?B?RTY0UFJyaVg5cndSZ3ZOTk54U0hrS3E4UHg1YmlCcDFYNWJ4U1NWTG1IMjl5?=
 =?utf-8?B?cm9UKzIyQURac0QzWWg4cXdFTHFORTRDcElyUWRNZjdZMHJPMzdWUkRZaklX?=
 =?utf-8?B?eGtUb1F0b3ZnWUtvdkFmS2dtUlFpZkJFZUJTUWFkMjYzbldLZ0dqbzd0L0Nm?=
 =?utf-8?B?V21pbFE3LzlBelVWcEkwUDVBWWdCVU51TVB6K2gvenloajNPWWhDOG1tS0M1?=
 =?utf-8?B?NTkwZERzdUIwMjVtbUZyTU83M010VEJ4YjRuRFJFWlgrbHpwR0V3U1BYUURU?=
 =?utf-8?B?OXB1UTBDaWRDaUdqZ21COXNQTnpjTUl5a1c0NmF2dkpqSHBkMDhwbm1EbnRh?=
 =?utf-8?B?WTY2WFFESlVQbXhZdzl2dVpJOWtwTGZDdVp1WDRvbGo1eG04SUVJVXkvb0ds?=
 =?utf-8?B?dUZiSXkzek1OMmM4RFF4OWlucFdpWXZ0YjZwaHIzYjJyWDhtUmxBdCtsYjQv?=
 =?utf-8?B?WHhyZzFPbWZlZHVZZVJzM1REZk1oNzV1SC8yVExqV0VYZC9OOHNyZzMrbUZ4?=
 =?utf-8?B?VmRTZE5ScHBZZVcvckEwaWkzelhNM2ZwRGswTllBc3lYRzN4MVZOTmt6MWdH?=
 =?utf-8?B?d2V1U0xtWmtDeFR5RVBnMzZGcEY3ZWVRS095enpRanpNYXRrRVZEWnpueDVr?=
 =?utf-8?B?clNJdS9VZnkwT1JLWlVVNVQyMHVsdDZxWmM5ZjdhcFJRVVE9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(52116014)(366016)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NklZbUppOTN4SEMrU1QvZ293djRXbkp6Z1htSldyZlVReUlFKzlLUGhoWUVs?=
 =?utf-8?B?Vkcwc0pNQkJ6S1h3STBTTkVkb1RETi9jMk12QllvZ3dCOEtsR2NOMzc0V0Zo?=
 =?utf-8?B?Qk5XcEF6TllKUUpvWTMxZGo1UjlmOXF2SFV6ZUJlYi9qdDFPcmZjWUhlbmRZ?=
 =?utf-8?B?cngwcnhIR0RJMWZIQk5Ka0JBSUs5bytTb0NnS0dIUE45YUlFRzNxTy9lVUhp?=
 =?utf-8?B?R1JXdUJrVVc3bWpydzdQZWo4aTkwSTgzVStBQk5GWldlWWpGNFlMUDd6K0R5?=
 =?utf-8?B?ZHlBZHByL0g4NVo5ODVQanJsUXpLK1BvVlRQSTIrSlFLR2FBYlRRWXBUUFd1?=
 =?utf-8?B?eTFBMzg4bGNYQ1gvaTlWaUFrQXVjSi9kcWlzNFBMS256WHVIWEw0OVpRM094?=
 =?utf-8?B?ZDJTUGRKUVlGNUJzOGZxY2Y2YlRWRXhYQXpJdzU4cGMzdGpVNEEvS21odVF2?=
 =?utf-8?B?YTNjaDhQN3BxY1g0Rkp3cHJmZDdac2lJWjdhUFpHSTYrYW9jSHc1V1NCeURl?=
 =?utf-8?B?L0FoSVZScGF1UVVnby91VGFpQmhVcUNUYnhKZ0xVWkpqMktJUHZlL20yRFI1?=
 =?utf-8?B?S1ZLcHgxTmRZN1I4YVcyVDAzUmdFMUxCZTRNSlY4dURmTXQrbXZxM2Y1MS9p?=
 =?utf-8?B?bTZIcytBYUEzQ3I1SnR0S2VCa0JGd0VkVTlIRUhnVXhkQ1JYblBYbWw5TFhM?=
 =?utf-8?B?bTl1V2tkckhuUzZ1UjJJbGNicFFHaWZFL1VaV043b2lNSzZxN3FJV1NJMUMr?=
 =?utf-8?B?Z0JSYUg1WGhOMHVTcG9mOUE0eHhFTTlmZkh6YXlCRGlvWkNpbGYxY2ljMmRh?=
 =?utf-8?B?R3NnVERiRER1YjlkQnltMS81dVp4V3ZYeEZNY09tZjBkSjhxZVg5dVRyeHRR?=
 =?utf-8?B?Ti84OS9jczBlSDQvYmJrZzdaSWFOY2lqSndvWThab2xzTVMxVmI1bDhVQ1Er?=
 =?utf-8?B?WFAzanQrbVJSU1Byd0w2RWppV2VXdGdDTFUyY1FkVjlIbVBPbEc1MHI4eXJI?=
 =?utf-8?B?MHJTTW1iNWs2U1BxN1FFYlhVaWRuWHRjWitUeEFoUGNINE9qVGNmbW9NSnJH?=
 =?utf-8?B?ajJXL0VoMjRzUDZkZyt2QVRRNDlnWll3MW5ibHBhbG5zUGNESkt5UGhOZktP?=
 =?utf-8?B?QWJ5b1FzY1dIUUpQU3Z4QmtvZ0hMVXp2Mkw1Q1dTSDJmYkJzUTJWdHNQRzhv?=
 =?utf-8?B?cVlmTmJvTTR1RGNXNWFIdFBOYlo5T1Jkd2FSR0FZenFiYTBmZ0RxM1dlZWV1?=
 =?utf-8?B?bWErNnFHSTJFRFVtR1JOQm8zNlZZV0loWkZHL25KL0xNQmdCeEdmaDNDNWFL?=
 =?utf-8?B?d0pNWi9MaFFEVy8xK3lvTXl6dXFLWENhZnJmS3JrNEVabG9PcGxNL1BXdERn?=
 =?utf-8?B?N0xLYVBNM1FJN1N0VkdYZDRvQTBobWpvWU5WNnlpK3R3czVVY0FBV1hjZDBi?=
 =?utf-8?B?RzdXOE5yKzFSUXZ2ekYyell1WnFJMHJrZWZrWE4zdlVMSHJINU9vODBFd2xN?=
 =?utf-8?B?N1g0SncwUGcrNFMzSTg0NVpmQlIxV3VDSlU4R2p3djdSUUFyTEJialBwbXkr?=
 =?utf-8?B?WlNoWXRLVjNpNVJaSnNYamhOVlorVHZEeFl4QmtyZkxvZStJWWlDWGNZSm11?=
 =?utf-8?B?OXV4dnY0bzFVUEJXcXZ5dUdCMjB3dWpkSVRRSC9JRjRSLzE4NXc1MXA0Y08v?=
 =?utf-8?B?QzgxVzBKcTNUUWRqa0pwVXFqeDlqRFhxZUxVaU80akFTVnVjWHdIeUpLbXho?=
 =?utf-8?B?b25YTTZsd2c4d3hRN3dEUEhKWlliQkpDSmxORmljeHplQ3gwcm8wdWt6Qkhp?=
 =?utf-8?B?SHk1QkFrZ0hMRy9LQWtRUk5ENzQ2TVEyTHNZemlNVEZlWUhmdEJqS3hodkZs?=
 =?utf-8?B?MndvdnRLUEdrcUlGS2ZoSkZCQktFQU9JUFh1RkxlZHQrQmx2dmR2Nmo1VjBD?=
 =?utf-8?B?Y0NKR05KVGRsVEFrTUdialdaMmlHYzcrRVVxUkxSODhIUnFDc3NLRXNaTnFG?=
 =?utf-8?B?dTBvaU1YVFREa00vQmxmNS9RTGtOUFVvWFgyOHZ1Z3gxZkp2ZW1DSmh0ZUEw?=
 =?utf-8?B?VUcwdm11c1pIMlczcW1vZkcrMjJiU2pxRVBWNkVJMEtVWXRWcVFJZUNSWS9M?=
 =?utf-8?Q?aewaSGHUfJLbHuyR2SMTXyqVK?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 195625aa-eaba-4cf6-2497-08dcd856f6cd
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2024 02:58:40.0483 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L0GrYADpBqMkz2wdsEmK7ezhN5swbsnQekR9dpIGlkjdDda3xfS1PThWsvo6sQHrIiBE6rxvBH1HDqcqdu+J/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8867
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

Disale CPU1 for i.MX93 variants that only has one A55 core and update
cooling maps.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm/mach-imx/Makefile   | 7 ++++++-
 arch/arm/mach-imx/imx9/soc.c | 8 ++++++++
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-imx/Makefile b/arch/arm/mach-imx/Makefile
index 47e2cb8d943..f8903afc92e 100644
--- a/arch/arm/mach-imx/Makefile
+++ b/arch/arm/mach-imx/Makefile
@@ -12,7 +12,6 @@ endif
 ifeq ($(SOC),$(filter $(SOC),imx8m))
 ifneq ($(CONFIG_SPL_BUILD),y)
 obj-$(CONFIG_IMX_BOOTAUX) += imx_bootaux.o
-obj-y += fdt.o
 endif
 obj-$(CONFIG_ENV_IS_IN_MMC) += mmc_env.o
 obj-$(CONFIG_FEC_MXC) += mac.o
@@ -22,6 +21,12 @@ obj-$(CONFIG_IMX_HAB) += hab.o
 obj-y += cpu.o
 endif
 
+ifeq ($(SOC),$(filter $(SOC),imx8m imx9))
+ifneq ($(CONFIG_SPL_BUILD),y)
+obj-y += fdt.o
+endif
+endif
+
 ifeq ($(SOC),$(filter $(SOC),mx5 mx6))
 obj-y	+= cpu.o speed.o
 ifneq ($(CONFIG_MX51),y)
diff --git a/arch/arm/mach-imx/imx9/soc.c b/arch/arm/mach-imx/imx9/soc.c
index 0d909c3e853..e3bfc8d51c5 100644
--- a/arch/arm/mach-imx/imx9/soc.c
+++ b/arch/arm/mach-imx/imx9/soc.c
@@ -696,9 +696,17 @@ int board_fix_fdt(void *fdt)
 
 int ft_system_setup(void *blob, struct bd_info *bd)
 {
+	static const char * const nodes_path[] = {
+		"/cpus/cpu@0",
+		"/cpus/cpu@100",
+	};
+
 	if (fixup_thermal_trips(blob, "cpu-thermal"))
 		printf("Failed to update cpu-thermal trip(s)");
 
+	if (is_imx9351() || is_imx9331() || is_imx9321() || is_imx9311())
+		disable_cpu_nodes(blob, nodes_path, 1, 2);
+
 	if (is_voltage_mode(VOLT_LOW_DRIVE))
 		low_drive_freq_update(blob);
 

-- 
2.35.3

