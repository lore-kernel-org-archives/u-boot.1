Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A1B6E64AB3
	for <u-boot@archiver.kernel.org>; Tue,  3 Dec 2024 14:38:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 20605896A3;
	Tue,  3 Dec 2024 15:38:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="sgGlzcU5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BC78D896A3; Tue,  3 Dec 2024 15:38:05 +0100 (CET)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CA6F089669
 for <u-boot@lists.denx.de>; Tue,  3 Dec 2024 15:38:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r5FzyjUm9VamSvJs7Zkr7gC3gHDuP9SXQxO4OhIop9eRezmENar/Qp5eDHHtGnjaTXTq2KbQreZJdbqFw9FsusQDxIOrxsdHx7dyRXiVeh+9vbF9UNrBRIwDKy9MlgpGif8+crMOcLTWmvo4erDChmCk9tlDlW43dadoRkzAls6/YhlShITj6m+lXlOgLs9QgNOiUlwfKqlJkxRo+b2U0aMvqLLt3yru55AaANyvooaNbR6xG5IurlLqCVT/Cy4er1CznuO1QbAtYPlwqZN4GOR7+9lLrvg623HQ14loTVw7v+iVWp+iNIEhqMxckAIzq0DUz7AS94Eo77DHv5DqlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mrAkPOf9YXupGdaDOlLh5ecR5Biue9tcZ486GAPBFgE=;
 b=HPCvDSy8e1CI3Vhk+HUJA7EPHeDWpvKgwJRXzS9ykej5GdbEczsbAbyYYkDG+QQgNnfzltdEazANf8+8WSdgEjJDV6CO9G6Gj/HdgEF2DYnAAVTf4T0pr97ij5iCp4J6l4++ovjmfJJhyJiz00diJuid7oF7/2KvDJJxP0EVQcYqR9zVPpXFsVBFxkTIW6xtfumoRDv38TDnKBeHayDVsKZluj5dAr9D8BSXHaYMQXSsoViKc/Gt2GmIomcTZr7ZIM/N0Hf6NsDPvzs1X+73e+GF/Q+3GxrPR1dCQ44SzMkSF48ptTBXk0P0DiHxJUAyDId1QKmiq0YuSVy7ccM71w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mrAkPOf9YXupGdaDOlLh5ecR5Biue9tcZ486GAPBFgE=;
 b=sgGlzcU5BgLjNGipGbpeQkGxk4cwgtD4ZHDQaGhDXayZ10BDzK4/bW52CrX5E6kO1/V9bCHitkzCxZl+/SPwx4QUDxl1WPMggHf68uZREX/5SyBbJBSPf3C9o1H1Fz6NIKEtpRi2xntw+Q8momtirsvSPHMvZOLIRArRfL56TIPYZu3ReVNj1IhQsHUZkarpuHuXFOjiynBrv/ivYdg2JJH+Q5xH/N2Ds08CVdmNb8JCE5DmY+LNJScrsLxj2e9J9iIkDQd2u1KblMJ+ixhM2C+W0vjf6mROaJ03qW+fWB+WlylG03LkxuZFUJpJCqUgMgP+VypYv6x70HTAQOH/ng==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AS8PR04MB7541.eurprd04.prod.outlook.com (2603:10a6:20b:29a::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.19; Tue, 3 Dec
 2024 14:37:59 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%5]) with mapi id 15.20.8207.017; Tue, 3 Dec 2024
 14:37:59 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Tue, 03 Dec 2024 23:42:49 +0800
Subject: [PATCH 06/11] clk: imx93: support i.MX91
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241203-imx91-v1-6-48d2eaa4519e@nxp.com>
References: <20241203-imx91-v1-0-48d2eaa4519e@nxp.com>
In-Reply-To: <20241203-imx91-v1-0-48d2eaa4519e@nxp.com>
To: Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
Cc: u-boot@lists.denx.de, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.2
X-ClientProxiedBy: JH0PR01CA0025.apcprd01.prod.exchangelabs.com
 (2603:1096:990:5a::19) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|AS8PR04MB7541:EE_
X-MS-Office365-Filtering-Correlation-Id: c61ad2ee-909d-448b-42b7-08dd13a8157d
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|52116014|1800799024|366016|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eXFsRW0wemhSSTltYWNmQ1ZlTjYxOGFDRUQvWGt0amVUQnVTK2tIT24zSTdU?=
 =?utf-8?B?VjliODNQTXdFVjhUbmhKNlJtSnF3TUZFR29OUkg1TlAvWGFZT0puTUVMTTdq?=
 =?utf-8?B?ZkhqVVU5NG1hbUJkL3Vwa3phTzRGRmVyZERkczN3Z2lHdnpMOU0yb3BwOWtE?=
 =?utf-8?B?VHhkdnFLTWpjRHErb0FpOXZlazVUNkQrSUFyOVF6dmNxMVlFTDlWNGlTdFdy?=
 =?utf-8?B?NlBKSGN3dElEMlFJOFZEN0lObFdCTTh2c3pUUldlRitOZmsweE9DVDJXSnlk?=
 =?utf-8?B?NGZEbk9JOWI0Z1p5Y29iNVVPOEZQWTRSRlEzZzI2QTVkNEg1R3FVYkhzY1Bx?=
 =?utf-8?B?MlRnQW02dy9OYlNpdVVTZ0tHR3BoelRRM0JiR0ZkbUFkRCtQcElBUjEzd0hX?=
 =?utf-8?B?SmNBdjRHRDVTQUFNY3UwQlVmN2xVcWg0QXdTTlN1MmpSWVVzdXdNcHVsL0JE?=
 =?utf-8?B?bDY3RzY2em0yQTlvaUtlYW1ISDBvSWJNQ1ZUOVlNa2JxRlpvVms2cWRRbkdj?=
 =?utf-8?B?dENPNERyWlpiV0hxa2dnVzZHQmJ6Nk85RkJPV2VKcFFkTjJsT2hTcVpIQ0Fq?=
 =?utf-8?B?MnVZYkdIUVFyQjY0RFVRQXE4MWxmOXp6RGJiMmdEWFdNMVlVc2FUdzJGOVNa?=
 =?utf-8?B?NnYzUUhUa1BkQWxiZlNLM1JFRjZ3eU1ORDhYVlo3cEdCRUloS0t1bHdXMkIv?=
 =?utf-8?B?Ynh5UkxXc3VJS3Y0SzNScHBvS2Y5eUhWYTVDMEF6U0VBSkFLU29QdTdzNytz?=
 =?utf-8?B?RjFUTGZsUGhOVUdPV1duVUplYnZudG12VTNRcmhDTUMrdlpHWUx4MzJrQ3Rj?=
 =?utf-8?B?engzRXFrZW13WldaVWh4WHRSTjk0aUcvUVJ0WnVHeXg2WFVNQXlOZ3FRM0RW?=
 =?utf-8?B?eS9peUZSM3pKaXJMYkZKZk5XTFVmd2VhUlRBckZreEsxMVhOdTJMMEhRY0M4?=
 =?utf-8?B?TmlUU3ZrZmNMK254a0lTTmdaMTY3RFJscks5LytnYkN1Y1AxTGRGcHlhYnRG?=
 =?utf-8?B?TGlDNkoxc20vQVpidnhFY0ttdGNCZzhTU3c1dk0ycjRSbjdiK3krelpQMDF3?=
 =?utf-8?B?SG02cHZmb24rYTUxeU1ueER3YkJwSU1tSlFUd0VZNWY5MU9TQ001NUxwY1B5?=
 =?utf-8?B?NE90TnlpY0hHYTNBSlF6dy9EMFpGNDJienp0aE1xWVNBdkEvUXVZcm44ZS85?=
 =?utf-8?B?ZGpSaGdlVlplNzNrVE9KOTlzUDN4ZHlJeE5xV3czVzBUWkJkMWxWRnY5d2Z4?=
 =?utf-8?B?SnMzaDQxc0RSa085ekJDMlVxaUt3NzFBNEpkM0h3K1JpMDV2MjlKMkRrY2pm?=
 =?utf-8?B?SmlxTGRkeG9CU3RnamphQldBOU0xQ3orRW91bHVkZTQrZmY3M002Q0xMWlJa?=
 =?utf-8?B?bzZYeGZsR1JhdnVWZTkwT1ZNN2ZhUlVUSE9YUHJxT2NmRUlXR3I5YnA5MVhv?=
 =?utf-8?B?VGU5Z3RRaS8zME56WkwwVjRSUnZydWFKWFZ5RnBYNzk5b3ZBRTNrc1RWYzB5?=
 =?utf-8?B?bFdWaXVRTWErTDRXUjlDTVJZWERrelRnL3lNc2pPUnFOOTBySGhOc0pLd2s0?=
 =?utf-8?B?RStKekZvRHdWZks4RU11eHRPVGRPRDB3eHFoMmxUa1VGVS9OR2RqTHpCS2s3?=
 =?utf-8?B?UnZXNVg2Qm1VRi9DU2lpdXloeTRFRng0cjFRcVV1diszK240MFBpTXZGZUI1?=
 =?utf-8?B?bXV2N01xWE9WNElzT2g1YWtNd2Yyc2g0MUhMOWZLTXc2T2RUc2x3YklTSW5l?=
 =?utf-8?B?V0lTZVM3UkRwa1JzdkxpeGF1TTBUcWxLcHNhV2diOUJOOTRpai9zOWNtbWc5?=
 =?utf-8?B?YkVFVjNGZVRBK1piRTNSVFhtS0RTeFRyRExqSXZVOGZac2Y5eG9NWWNuVHQ0?=
 =?utf-8?B?OFg5Wjc2cjdnOGl4VFRxYUV5Q2xRTTJkRDlnUWhNd2FTSEE9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(52116014)(1800799024)(366016)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WGJteEd3MkpoRWxTT2xiK2I1VzFSd1BRb1BkeEtGMGt6bVJmR010OHNoUHdI?=
 =?utf-8?B?QmxqY2J4NEZUa1UybXJpYkFDcFZvYkg0R3ExWFZWdElIM1QvMjZYUEtzZy90?=
 =?utf-8?B?bFNxTlFtZE5MY1VZeG9HNkgybGdPYkNYWXgxeXI2bUZWckZZbUNvUU5iTmM5?=
 =?utf-8?B?aitGaGFrMDVJdVAvTHFJSk5aTFJNY2VPQTN1eGhBVnNEQ1pVT2FNdWFWaTVR?=
 =?utf-8?B?aUFCamRySUl5azVrRzJLWmppMU0wMlY3dlRCQWZqZzBoT0c3WVdLbzZzUzcx?=
 =?utf-8?B?YkM4c0pyTUJuZG1aQUtMK1J6RFVLTkltR1N3TUdpNFhpNjlncG9Cb1puT2V6?=
 =?utf-8?B?ZGFxWGticUtXVXJ5b1YydlBHTHNkQjZLSkRuNGNqalNTempZVGZNYzBqcGdT?=
 =?utf-8?B?dWszeU1HK1kyQkU0RzlUdG00RnlTZXNnM3RDZmIzdzcwbU10Lzd1UkdQL0tZ?=
 =?utf-8?B?bkk5UUl3RVg1VWVTVldhSGtzbWMwR1RLaUJmRVFxV3hrc1V3R0JKS1AzUUow?=
 =?utf-8?B?QjBPZ0dzTytyTUROYUt4UFNaYXQvQ2NHRTdEQ2NnVTQ3NlFQTk5pOTlWMHFQ?=
 =?utf-8?B?c0dkd2VZWkdoeUtQZmtzS0ZzYlAveDlZY093UUFsZ2hYSVdQMnpLb3FIdDJw?=
 =?utf-8?B?NUVNVUZFUkNtVW5GSWV6RjJHS1I3Qnk2ZkZLYXErM0pFNXNROU5zSktCMk9D?=
 =?utf-8?B?ZWNEaXRzTGtzWXVpOE5OZzBLQ3pHN3pCNU9DeEZ4WkRxdmUwU1Z5NDVncVVY?=
 =?utf-8?B?d3RzYnZXTzhqK1RpR1d6TGFZZDNtNnlrQUhTUXJwaDdEV1BBMURYdU5hUGU0?=
 =?utf-8?B?VXNiS05GOTVhOE84Zzd3MmVUZlluMWFBd3k1b2VNQkxEekwrV1hseVlKY1JG?=
 =?utf-8?B?ZUg4cG8vSmV6c0tCbmZKU2pLcDdaZm4yN3M0WlQ4elNmcHVYeVU0UkRaVUdU?=
 =?utf-8?B?aFBMN0ZTTU04VlBISWJDWGN5V1VEMkxxdGtoc0ZaTDl0aTBJWkZWQ0tPRTZ0?=
 =?utf-8?B?cWxXSGxNb2FjSXkrMGNkWG9zRGMvNnlzajFyUWRaRzNCL2VQU0JQMWhoSTRa?=
 =?utf-8?B?QUZEaHZac1pnRzhXdUREcDFBSGtEb0JYbytaN25lSENJa1lvZ0hyZyt0OGsv?=
 =?utf-8?B?ZEt3dkdUZ2tQcnJQcDBUeWszRVhqVlI0UnY3T0pyQXJBWGhNNXQ2aWZtZ2hm?=
 =?utf-8?B?aWdLUWFsdDZ2UWJjZUlzNVFMZnlhKytUOVFRSmNtaURCYXlxV252ZVBGdzRk?=
 =?utf-8?B?NTk5c2lQTnRPNnR6eGRNTlFDcEdlVFdYbklidVVNZVN0dklocWpudjhUdk1U?=
 =?utf-8?B?azcvRUJQMTBRWXNJNGhpUWE2V2tPMnRWRVFWc2FhN1ZTdTAxNHNMNXB1Yjdv?=
 =?utf-8?B?dDJxUUR3UjFBWndhOHB6cEI4MlVPaFcwbkNpNXZRZ244bG5NMUdXMkt0bDVJ?=
 =?utf-8?B?QS9UYlFUOVhRN0hmWXpnRlRpR1dQSXkwdmovaFl4YlZmMUFtaDNpR2FoNTdh?=
 =?utf-8?B?YUQvbityT0NscUNWY2VCbml4eEFFZkVrN0RrdFU0Wnc3U2FTSGtZVmdCVDVW?=
 =?utf-8?B?Rjl2SC84Y085WitpbGZHMkE2VG9BMEo5N1V1dTV4R1p0OWZZRjl5eml1bU9j?=
 =?utf-8?B?ZVdJQjZjaWN3UnFaM09wUjlOd0Jtd0s1V1E5blZaYkF3bHRIQW1TY3VKbmwx?=
 =?utf-8?B?clQ3SWdLcnd1Q3lMKzgxdUprQkkxYnVrTWJvdS8vUXg1anMrYkpPS2RYL1ZP?=
 =?utf-8?B?WXpQazB5RzkzUkF6d1IrL2xScWpQblFZQkJOaGt5RGVYcnB2aEk5QkJETkFi?=
 =?utf-8?B?ak5VREtKakVnTHhQYlJKZitKODhyM0tHZjRJQmhMVS9GejRNekF4QjZ5S1ly?=
 =?utf-8?B?Q3A0cTNhYzR3WmwrdXBaVjZ6ZVFlR05RZXlmYkRhUzJqb3hzQk1ub3J3QUZm?=
 =?utf-8?B?UW9WaFg2SWRJZWRtS1NZa0FnSnJKT1ZKRUVDVVYwOW4yVjN0QVp6TloxQ0hH?=
 =?utf-8?B?SHBLY1JqWXREblIxS3dLcDk1MUx1MG5Yek9qY3pkY0dNZUFqUFBsR3NCWng1?=
 =?utf-8?B?OGFKUWh5NXlYekNobVFWclFteHdUL3ZzZzZjNlYxNDBLOUsyWVBRNmNUTWFW?=
 =?utf-8?Q?jZ2D+ZNdyysRtXIr7aUNWrP1P?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c61ad2ee-909d-448b-42b7-08dd13a8157d
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2024 14:37:59.3751 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tyXSpynugDQQWfa18BwifhNoPn9VaWjGHc3pWA0F6kB7zkTYntODyTb4GxcCf5Esmw7QUe8g/5tXcze9oqVuRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7541
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

i.MX91 is a derived from i.MX93, and most clocks could be reused from
i.MX93. Also Update imx93-clock.h to sync with linux next.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/clk/imx/clk-imx93.c                        | 52 +++++++++++++++-------
 .../include/dt-bindings/clock/imx93-clock.h        |  6 ++-
 2 files changed, 40 insertions(+), 18 deletions(-)

diff --git a/drivers/clk/imx/clk-imx93.c b/drivers/clk/imx/clk-imx93.c
index ede36c412bffd3861a0c50a639e9261eda3b0fc9..b31e57a4a016527e6f0eafd1705fba62832d7d21 100644
--- a/drivers/clk/imx/clk-imx93.c
+++ b/drivers/clk/imx/clk-imx93.c
@@ -13,6 +13,11 @@
 
 #include "clk.h"
 
+#define IMX93_CLK_END 207
+
+#define PLAT_IMX93 BIT(0)
+#define PLAT_IMX91 BIT(1)
+
 enum clk_sel {
 	LOW_SPEED_IO_SEL,
 	NON_IO_SEL,
@@ -50,6 +55,7 @@ static const struct imx93_clk_root {
 	u32 off;
 	enum clk_sel sel;
 	unsigned long flags;
+	unsigned long plat;
 } root_array[] = {
 	/* a55/m33/bus critical clk for system run */
 	{ IMX93_CLK_A55_PERIPH,		"a55_periph_root",	0x0000,	FAST_SEL, CLK_IS_CRITICAL },
@@ -60,7 +66,7 @@ static const struct imx93_clk_root {
 	{ IMX93_CLK_BUS_AON,		"bus_aon_root",		0x0300,	LOW_SPEED_IO_SEL, CLK_IS_CRITICAL },
 	{ IMX93_CLK_WAKEUP_AXI,		"wakeup_axi_root",	0x0380,	FAST_SEL, CLK_IS_CRITICAL },
 	{ IMX93_CLK_SWO_TRACE,		"swo_trace_root",	0x0400,	LOW_SPEED_IO_SEL, },
-	{ IMX93_CLK_M33_SYSTICK,	"m33_systick_root",	0x0480,	LOW_SPEED_IO_SEL, },
+	{ IMX93_CLK_M33_SYSTICK,	"m33_systick_root",	0x0480,	LOW_SPEED_IO_SEL, 0, PLAT_IMX93, },
 	{ IMX93_CLK_FLEXIO1,		"flexio1_root",		0x0500,	LOW_SPEED_IO_SEL, },
 	{ IMX93_CLK_FLEXIO2,		"flexio2_root",		0x0580,	LOW_SPEED_IO_SEL, },
 	{ IMX93_CLK_LPTMR1,		"lptmr1_root",		0x0700,	LOW_SPEED_IO_SEL, },
@@ -117,15 +123,15 @@ static const struct imx93_clk_root {
 	{ IMX93_CLK_HSIO_ACSCAN_80M,	"hsio_acscan_80m_root",	0x1f80,	LOW_SPEED_IO_SEL, },
 	{ IMX93_CLK_HSIO_ACSCAN_480M,	"hsio_acscan_480m_root", 0x2000, MISC_SEL, },
 	{ IMX93_CLK_NIC_AXI,		"nic_axi_root",		0x2080, FAST_SEL, CLK_IS_CRITICAL, },
-	{ IMX93_CLK_ML_APB,		"ml_apb_root",		0x2180,	LOW_SPEED_IO_SEL, },
-	{ IMX93_CLK_ML,			"ml_root",		0x2200,	FAST_SEL, },
+	{ IMX93_CLK_ML_APB,		"ml_apb_root",		0x2180,	LOW_SPEED_IO_SEL, 0, PLAT_IMX93, },
+	{ IMX93_CLK_ML,			"ml_root",		0x2200,	FAST_SEL, 0, PLAT_IMX93, },
 	{ IMX93_CLK_MEDIA_AXI,		"media_axi_root",	0x2280,	FAST_SEL, },
 	{ IMX93_CLK_MEDIA_APB,		"media_apb_root",	0x2300,	LOW_SPEED_IO_SEL, },
-	{ IMX93_CLK_MEDIA_LDB,		"media_ldb_root",	0x2380,	VIDEO_SEL, },
+	{ IMX93_CLK_MEDIA_LDB,		"media_ldb_root",	0x2380,	VIDEO_SEL, 0, PLAT_IMX93, },
 	{ IMX93_CLK_MEDIA_DISP_PIX,	"media_disp_pix_root",	0x2400,	VIDEO_SEL, },
 	{ IMX93_CLK_CAM_PIX,		"cam_pix_root",		0x2480,	VIDEO_SEL, },
-	{ IMX93_CLK_MIPI_TEST_BYTE,	"mipi_test_byte_root",	0x2500,	VIDEO_SEL, },
-	{ IMX93_CLK_MIPI_PHY_CFG,	"mipi_phy_cfg_root",	0x2580,	VIDEO_SEL, },
+	{ IMX93_CLK_MIPI_TEST_BYTE,	"mipi_test_byte_root",	0x2500,	VIDEO_SEL, 0, PLAT_IMX93, },
+	{ IMX93_CLK_MIPI_PHY_CFG,	"mipi_phy_cfg_root",	0x2580,	VIDEO_SEL, 0, PLAT_IMX93, },
 	{ IMX93_CLK_ADC,		"adc_root",		0x2700,	LOW_SPEED_IO_SEL, },
 	{ IMX93_CLK_PDM,		"pdm_root",		0x2780,	AUDIO_SEL, },
 	{ IMX93_CLK_TSTMR1,		"tstmr1_root",		0x2800,	LOW_SPEED_IO_SEL, },
@@ -134,13 +140,16 @@ static const struct imx93_clk_root {
 	{ IMX93_CLK_MQS2,		"mqs2_root",		0x2980,	AUDIO_SEL, },
 	{ IMX93_CLK_AUDIO_XCVR,		"audio_xcvr_root",	0x2a00,	NON_IO_SEL, },
 	{ IMX93_CLK_SPDIF,		"spdif_root",		0x2a80,	AUDIO_SEL, },
-	{ IMX93_CLK_ENET,		"enet_root",		0x2b00,	NON_IO_SEL, },
-	{ IMX93_CLK_ENET_TIMER1,	"enet_timer1_root",	0x2b80,	LOW_SPEED_IO_SEL, },
-	{ IMX93_CLK_ENET_TIMER2,	"enet_timer2_root",	0x2c00,	LOW_SPEED_IO_SEL, },
-	{ IMX93_CLK_ENET_REF,		"enet_ref_root",	0x2c80,	NON_IO_SEL, },
-	{ IMX93_CLK_ENET_REF_PHY,	"enet_ref_phy_root",	0x2d00,	LOW_SPEED_IO_SEL, },
-	{ IMX93_CLK_I3C1_SLOW,		"i3c1_slow_root",	0x2d80,	LOW_SPEED_IO_SEL, },
-	{ IMX93_CLK_I3C2_SLOW,		"i3c2_slow_root",	0x2e00,	LOW_SPEED_IO_SEL, },
+	{ IMX93_CLK_ENET,		"enet_root",		0x2b00,	NON_IO_SEL, 0, PLAT_IMX93, },
+	{ IMX93_CLK_ENET_TIMER1,	"enet_timer1_root",	0x2b80,	LOW_SPEED_IO_SEL, 0, PLAT_IMX93, },
+	{ IMX93_CLK_ENET_TIMER2,	"enet_timer2_root",	0x2c00,	LOW_SPEED_IO_SEL, 0, PLAT_IMX93, },
+	{ IMX93_CLK_ENET_REF,		"enet_ref_root",	0x2c80,	NON_IO_SEL, 0, PLAT_IMX93, },
+	{ IMX93_CLK_ENET_REF_PHY,	"enet_ref_phy_root",	0x2d00,	LOW_SPEED_IO_SEL, 0, PLAT_IMX93, },
+	{ IMX91_CLK_ENET1_QOS_TSN,	"enet1_qos_tsn_root",   0x2b00, NON_IO_SEL, 0, PLAT_IMX91, },
+	{ IMX91_CLK_ENET_TIMER,		"enet_timer_root",      0x2b80, LOW_SPEED_IO_SEL, 0, PLAT_IMX91, },
+	{ IMX91_CLK_ENET2_REGULAR,	"enet2_regular_root",   0x2c80, NON_IO_SEL, 0, PLAT_IMX91, },
+	{ IMX93_CLK_I3C1_SLOW,		"i3c1_slow_root",	0x2d80,	LOW_SPEED_IO_SEL, 0, PLAT_IMX93, },
+	{ IMX93_CLK_I3C2_SLOW,		"i3c2_slow_root",	0x2e00,	LOW_SPEED_IO_SEL, 0, PLAT_IMX93, },
 	{ IMX93_CLK_USB_PHY_BURUNIN,	"usb_phy_root",		0x2e80,	LOW_SPEED_IO_SEL, },
 	{ IMX93_CLK_PAL_CAME_SCAN,	"pal_came_scan_root",	0x2f00,	MISC_SEL, }
 };
@@ -152,6 +161,7 @@ static const struct imx93_clk_ccgr {
 	u32 off;
 	unsigned long flags;
 	u32 *shared_count;
+	unsigned long plat;
 } ccgr_array[] = {
 	{ IMX93_CLK_A55_GATE,		"a55_alt",	"a55_alt_root",		0x8000, },
 	/* M33 critical clk for system run */
@@ -226,7 +236,7 @@ static const struct imx93_clk_ccgr {
 	{ IMX93_CLK_SAI3_IPG,		"sai3_ipg_clk", "bus_wakeup_root",	0x94c0, 0, &share_count_sai3},
 	{ IMX93_CLK_MIPI_CSI_GATE,	"mipi_csi",	"media_apb_root",	0x9580, },
 	{ IMX93_CLK_MIPI_DSI_GATE,	"mipi_dsi",	"media_apb_root",	0x95c0, },
-	{ IMX93_CLK_LVDS_GATE,		"lvds",		"media_ldb_root",	0x9600, },
+	{ IMX93_CLK_LVDS_GATE,		"lvds",		"media_ldb_root",	0x9600, 0, NULL, PLAT_IMX93, },
 	{ IMX93_CLK_LCDIF_GATE,		"lcdif",	"media_apb_root",	0x9640, },
 	{ IMX93_CLK_PXP_GATE,		"pxp",		"media_apb_root",	0x9680, },
 	{ IMX93_CLK_ISI_GATE,		"isi",		"media_apb_root",	0x96c0, },
@@ -240,8 +250,10 @@ static const struct imx93_clk_ccgr {
 	{ IMX93_CLK_AUD_XCVR_GATE,	"aud_xcvr",	"audio_xcvr_root",	0x9b80, },
 	{ IMX93_CLK_SPDIF_GATE,		"spdif",	"spdif_root",		0x9c00, },
 	{ IMX93_CLK_HSIO_32K_GATE,	"hsio_32k",	"clock-osc-24m",	0x9dc0, },
-	{ IMX93_CLK_ENET1_GATE,		"enet1",	"wakeup_axi_root",	0x9e00, },
-	{ IMX93_CLK_ENET_QOS_GATE,	"enet_qos",	"wakeup_axi_root",	0x9e40, },
+	{ IMX93_CLK_ENET1_GATE,		"enet1",	"wakeup_axi_root",	0x9e00, 0, NULL, PLAT_IMX93, },
+	{ IMX93_CLK_ENET_QOS_GATE,	"enet_qos",	"wakeup_axi_root",	0x9e40, 0, NULL, PLAT_IMX93, },
+	{ IMX91_CLK_ENET2_REGULAR_GATE, "enet2_regular",        "wakeup_axi_root",      0x9e00, 0, NULL, PLAT_IMX91, },
+	{ IMX91_CLK_ENET1_QOS_TSN_GATE,     "enet1_qos_tsn",        "wakeup_axi_root",      0x9e40, 0, NULL, PLAT_IMX91, },
 	/* Critical because clk accessed during CPU idle */
 	{ IMX93_CLK_SYS_CNT_GATE,	"sys_cnt",	"clock-osc-24m",	0x9e80, CLK_IS_CRITICAL},
 	{ IMX93_CLK_TSTMR1_GATE,	"tstmr1",	"bus_aon_root",		0x9ec0, },
@@ -257,6 +269,7 @@ static int imx93_clk_probe(struct udevice *dev)
 	struct clk osc_24m_clk, osc_32k_clk, ext1_clk;
 	void __iomem *base, *anatop_base;
 	int i, ret;
+	const unsigned long plat = (unsigned long)dev_get_driver_data(dev);
 
 	clk_dm(IMX93_CLK_DUMMY, clk_register_fixed_rate(NULL, "dummy", 0UL));
 
@@ -307,6 +320,8 @@ static int imx93_clk_probe(struct udevice *dev)
 
 	for (i = 0; i < ARRAY_SIZE(root_array); i++) {
 		root = &root_array[i];
+		if (root->plat && !(root->plat & plat))
+			continue;
 		clk_dm(root->clk, imx93_clk_composite_flags(root->name,
 							    parent_names[root->sel],
 							    4, base + root->off, 3,
@@ -315,6 +330,8 @@ static int imx93_clk_probe(struct udevice *dev)
 
 	for (i = 0; i < ARRAY_SIZE(ccgr_array); i++) {
 		ccgr = &ccgr_array[i];
+		if (ccgr->plat && !(ccgr->plat & plat))
+			continue;
 		clk_dm(ccgr->clk, imx93_clk_gate(NULL, ccgr->name, ccgr->parent_name,
 						 ccgr->flags, base + ccgr->off, 0, 1, 1, 3,
 						 ccgr->shared_count));
@@ -328,7 +345,8 @@ static int imx93_clk_probe(struct udevice *dev)
 }
 
 static const struct udevice_id imx93_clk_ids[] = {
-	{ .compatible = "fsl,imx93-ccm" },
+	{ .compatible = "fsl,imx93-ccm", .data = (unsigned long)PLAT_IMX93 },
+	{ .compatible = "fsl,imx91-ccm", .data = (unsigned long)PLAT_IMX91 },
 	{ /* Sentinel */ },
 };
 
diff --git a/dts/upstream/include/dt-bindings/clock/imx93-clock.h b/dts/upstream/include/dt-bindings/clock/imx93-clock.h
index 787c9e74dc96db2ab1081ac1fc4bd3eb9bfebd8b..6c685067288b54acabc52c3443473db84d1d992b 100644
--- a/dts/upstream/include/dt-bindings/clock/imx93-clock.h
+++ b/dts/upstream/include/dt-bindings/clock/imx93-clock.h
@@ -204,6 +204,10 @@
 #define IMX93_CLK_A55_SEL		199
 #define IMX93_CLK_A55_CORE		200
 #define IMX93_CLK_PDM_IPG		201
-#define IMX93_CLK_END			202
+#define IMX91_CLK_ENET1_QOS_TSN     202
+#define IMX91_CLK_ENET_TIMER        203
+#define IMX91_CLK_ENET2_REGULAR     204
+#define IMX91_CLK_ENET2_REGULAR_GATE		205
+#define IMX91_CLK_ENET1_QOS_TSN_GATE		206
 
 #endif

-- 
2.35.3

