Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FE11C7115A
	for <u-boot@archiver.kernel.org>; Thu, 19 Jun 2025 16:41:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3AA2E82CBB;
	Thu, 19 Jun 2025 18:41:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="BVJS9K3k";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7912C82CD5; Thu, 19 Jun 2025 18:41:23 +0200 (CEST)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5A26182C65
 for <u-boot@lists.denx.de>; Thu, 19 Jun 2025 18:41:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M2gfJFSQBt++uWj3f08rNU8AEAGz5FOW5Vb/RV+UahBsigflHodWKu6YPtPkSmvV/t/3srHZqCiHH25nbT4NzZzmGrCGl4EevaLD+SHd5OHf9Wt02NMcBs276dgmoM8tQSLPoVStkJ2EzUUVSx3dt7gmTTyXU8rTy/HY4/qrs/gX3GgB277OFFJbV8FndWbj9PsjGCwtbwQxjXBmItagLVGsgLRrnPDr/nGGF9NLYbxyD0R9CKelv7dfnVRz6InigsCN8OkTqnLlFLB726x9JZbCXch9TgFPu/rp5mxz7zT48MmANuTUKrYv5yLyP5ajSpLPJH5P7QlRcUcg54h6mA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uZbPTSKxk9sgD1Pdf1W+ZLHxd49c/mgi9mQvkGPKoMM=;
 b=SfyZPq7FHum4OX1M33vqPOmNsVTx3jBxd1SQm6ruS9dBDTyk8apVDD6Ed+Mbhvop3imTFyZSqlZFOpRIkyCUNUJdcGCqm+m8Fn7rtIeksUuv6+zojNR5yAYpKy68eS5Z/WG6diX/AI/xrAHQ0a1lPXFIogp0SsYkiYqIUKCg9mzRu1xdHkSjkhMpWV2hNeloUSMduqTA+dQuCiexcqnHCbYxI8HeU2mAJrz8dRYv2BSVutWYio2M/pgUXf8riwWReM8iVqSzDPof94EXU//4fJe/JGhBLXSoXw9GRX0mN+VH7lch28XIgD1YBI3pHh5hgGZhKzbzOA1PswhWdGmlrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uZbPTSKxk9sgD1Pdf1W+ZLHxd49c/mgi9mQvkGPKoMM=;
 b=BVJS9K3kE7Hp2LScilDqkJRcKSVEMflc1Fio2qFwxOpmc6Qpi23MqNLTGw2b7w44sgOGm8pl2gf2iPw/gc4lFLOb3FtIOCYliEGwia1FLeAYomEdEDpCKYj9QRZwMLbDVY9nEAQY8GpgFgY9nD5HaZJsYdNiqCB08KD0ls4Box8ZAcg97iKut75G1Z5yDuXr2t+Ji/avN20Z5FUE6z7oAOjuks8PEo+ou3G1OijFInpLZd3qZqT0/G4zCEBPUBJlDD/FD9vZ8D81Wjxa/lJcrHPszOG60/yOT1IZaXGJ97CL48agZrSauWSOzgcqPMfF0qkkZq76WIoz5Impjp8bCQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by PAXPR08MB6432.eurprd08.prod.outlook.com (2603:10a6:102:154::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.21; Thu, 19 Jun
 2025 16:41:20 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%3]) with mapi id 15.20.8835.023; Thu, 19 Jun 2025
 16:41:20 +0000
Message-ID: <46222eaf-5368-4abd-96b6-243a912b60cf@iopsys.eu>
Date: Thu, 19 Jun 2025 19:41:18 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/3] common/spl fixes
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Sam Edwards <cfsworks@gmail.com>,
 Anshul Dalal <anshuld@ti.com>, u-boot@lists.denx.de,
 Jonas Karlman <jonas@kwiboo.se>
References: <20250610045054.1038235-1-mikhail.kshevetskiy@iopsys.eu>
 <20250610095632.1085431-1-mikhail.kshevetskiy@iopsys.eu>
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Content-Language: en-US, ru-RU
In-Reply-To: <20250610095632.1085431-1-mikhail.kshevetskiy@iopsys.eu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0249.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f5::19) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|PAXPR08MB6432:EE_
X-MS-Office365-Filtering-Correlation-Id: 844a1910-e1e4-4f9f-33ec-08ddaf501e9e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UktYeU9QUkxqV3VWb2krc3MvUXc4aWkxaEZVa2pDbG5GN1UzWTlWN092VU9x?=
 =?utf-8?B?TFFNNjEzOFhtblFpcmdMbjBkU1Njck1Ob0pPcE9XYTVJeWZGeDcrMVhSTFRs?=
 =?utf-8?B?UWNJTlBPTWF2Qk9jMjVtTk9FTUtBMm9VeTUyMWp4WDJCTnpuUEkyVkY0RVFq?=
 =?utf-8?B?L1JOK2NRWHJma1JZK1VkamwxbCtvN1hlazhYZWhpL21vUk9CMEZxL3hLR2Vw?=
 =?utf-8?B?NXpmR1o2OFowZ1NPTWRUaGFvZUpBT1RHVnpKRWhGN3dNQjlvSy9MR1JVUjA3?=
 =?utf-8?B?K2dTSDl5TFlVSnpOTEMyRzFzOHF1OExieGQwMkFsamgyNHRGSjBGaUFBYXcz?=
 =?utf-8?B?dXByckpTbTdYSDVSZHlKOHZ4TXNhVWt2UXZUaGJYc1lua0h0a1NGZFdDQmlt?=
 =?utf-8?B?ZngxSUM5MWNRUThwa2JXMUdnU2x1RzJzV2dkSXRaMWk0L1dzeHVJMGIvL2J1?=
 =?utf-8?B?SG91MENkZWhLZ1VGOTd3eGtKUzllaHpRVW1pQUZ5TUcwaUVremFPc29DU0l2?=
 =?utf-8?B?U215TGk4TEtIU3laYkkySXA1NFF5QnNEYVl6dDlkMG54YTFFQnpNRjQ2ZEd1?=
 =?utf-8?B?b3hyQVFETnd2VTVoQkZTV2lST2lnYmxsSUZhYWhqNUVLWXdZald6NnVZRDYz?=
 =?utf-8?B?MnhXUU9QNkFUSUszZG1Fa21xOEdnL2V6TnhZMHI5Z1AySkNSOHNVT2wwYnFZ?=
 =?utf-8?B?aU9Hai8vcXNrYThtQ1pSQ2NpU0ZRaTF5ZnVJcUwzUVpzaWQ2L1ZWQVQ1eTlo?=
 =?utf-8?B?VU9pVDg5aFhnRVkxNkxuV0ZNdjZuSG9XVytubEUrdVo1QUhCWk5pamNRTnJY?=
 =?utf-8?B?NnNMR0lKVGRaa09yVlRBeDMzc0tEL0ZzVG4xdlJlOHhodjg4ZXV1RHhXeGZ4?=
 =?utf-8?B?NUZQQVovemZBM2VCRGZKckt5aVJwQ05RUnZnZ2NqY3l6cGp3Uk8wWEZCRlhY?=
 =?utf-8?B?eHNwNENNcVlZSTB2aXNmdi9WK2pqa2JxQUwrUkEvd2FGK1JSOW5KbkxIeDcv?=
 =?utf-8?B?SGltL3A2WnlCNjJSbzdSOVdwRDExdlVRS3N1QWhMa1dpc0Q3RzM1djNMck5v?=
 =?utf-8?B?N05yRFRxUWJtdzV2am5jV3ZVRXNtU2RGT3B2NUVtdzFRK0tYYlBLZk55UjFq?=
 =?utf-8?B?SHJRTXpmV0luN2NCejlwdElqMkxXNE1HU21VbU8vS2VrOVJndUUvaFg0Vy9q?=
 =?utf-8?B?RWhWTG1qSy9VaE9XeGplMW9uNUVVajdvMDIwTU9UVjhBVWl6Q1VUWnRCTndU?=
 =?utf-8?B?STI0eEUyOE01WGJQMHNaOStxbnlaaTE0WXV1Tnd0aHk5Z25rWGN6K3MzWFBy?=
 =?utf-8?B?cDFCSjJLVXB3Z2FBaTVnZ3ppalNoSXIwT3MrK25wRTZzbjlDNXBOMm1pYlpn?=
 =?utf-8?B?RzJvVi9CS09Fd0FNblpFL3BBSFN6YjdSL21oLzEyMlVyZjVJKytxWmc3UTNH?=
 =?utf-8?B?c3A3OGRGVDU0czlLRCtwNENzeGdCMTlYaVcyOHp6RnBjUW9VSzhheDFtY1gz?=
 =?utf-8?B?S3dlN2l3b0tnZUpCTlRyNTVyaFFXenVpTkhNbk1CSmtHdFZ6cWZ1WTFmbFhh?=
 =?utf-8?B?QlBFdURYWC9TUWl6a0N4YkppMDcyVWR1MDRpQ0NDYS8xQit2V0JRQmxGZjVC?=
 =?utf-8?B?MGdNWlFJNktTQ0JaNFVGMzJZMFEzc0JQNlp3eWgwTGYyNnA3WHUwdUUwb2hY?=
 =?utf-8?B?RGRwN250MkVhUGJKMmxIYTBMYXBpODE0YnVWVVM3Z1BJajhZVzFHckY0eEVi?=
 =?utf-8?B?V3NveGpwVGNGYUltYW0zbElCUWdlcVVaRVVLMHFFUDgvUjUvTmJnSEhaNmto?=
 =?utf-8?B?RVRwSnovTmV4QzRkNlZjeTNOQXRhY2tMak5jMkZpbjRiSlN3dlR5RGg1WHB3?=
 =?utf-8?B?VVloNzNidnZwa2JtanNIT1daTzVRUllZRS9tTitwYTdRT3pWN1AxMUtHRTYr?=
 =?utf-8?Q?7SAe2N7kgdU=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y05oWmhrb1JUdVBERHZ3RGpIejhMMEtEeURNb096VXl5MEdjS2NXeVg0RmJB?=
 =?utf-8?B?OXlCaS9IS1loVVN2Y091SWEvN3hackw4Q2JCRjhEeXN1MWhTbzYzWmQ5azFG?=
 =?utf-8?B?QmtCTWNFb1FBaGlQNFFlRW9tK1FOQkI5MHJRd2V0L3kyVDRTSDk1emRMNEla?=
 =?utf-8?B?aUI5Q0crd215USs4SlF3L3VJMzgydzFOUUo3b1h2NzVXWExVOGEvOGFQUkor?=
 =?utf-8?B?d2tIb0ZjWUlHdGVDam93Z3lYdGJETDZlLzBnMnY1KzQ1Z3ZFVjVlRkZRcjEz?=
 =?utf-8?B?SFhza1o2T1plTVdJTksxWXRIUEkrd0pyTzZkN08vK1h0d1NNOUlZRkdYZVV5?=
 =?utf-8?B?TXJiVW05bENMNWltaGFYL0xwMC8wd0lBaGIrQjFRUDFZQ3JFZjgvK1FGNXFY?=
 =?utf-8?B?TDFwOGthckRDSnJOMk9KYVNLczZNWXdPWG9PVHg5VmtYMkQ2ZXlDSGk3UVZa?=
 =?utf-8?B?dzlKS0kzQzN5YnVGU01BUjBaZDlPNHFnTm9KWUg3aXN1V0xlTFV5T3M1bkRV?=
 =?utf-8?B?M1pjVXoxdHJqSVNUb29wRElHbEcrUjJORTlOVGxvSklSVVJ6WnhZa1VTMUlK?=
 =?utf-8?B?RElBOHBaazRzMG1lRmhCaTQ3RzllLzJGL0hnM1R2ZEZtcFVoa0craTNuZy9m?=
 =?utf-8?B?TytGOG1maGFYVnVzd3dzb1lxaFVrWFRTZXhZQlROWm4yYmpxdWc5K3BSRHBk?=
 =?utf-8?B?R29XclZFQUJpT0tYOWNzcno3K2gySzF0dVRRVkFYUXlUdmhGU0UwMHFQSnNW?=
 =?utf-8?B?R24raGhqWFhtUC8vQnZ5RmIycWRiQXcxNTU5aGtMNUJvdVhiOHdpaWpSM010?=
 =?utf-8?B?Tk4rRTM1WWhaWnU3cXZzVkpEaHcxamVUNTRBaWNucy9mYzFBdjdhYXZGS3BQ?=
 =?utf-8?B?b1R4aU9FWXQ0ZnMxU2RCQnAyd1h2K0lyT1AxU1FRaTFmNENON3NkQmtjMnpv?=
 =?utf-8?B?QnJyeEdpNWpFTUR0Vy9Vbnk4M2xFQWxoaktsWlB3R2wyaERGRVhNNDl5aDVE?=
 =?utf-8?B?UlF6dEFUbGFhYVg4V1UzNWYvVFkweGtvNWh1OSt6Q0lHSzdNaG83T1d0cWQx?=
 =?utf-8?B?WENzMVZ4QXZVbUVra2hJZExDVUZWVUxTWWtOZS9WM2RlMGIvSXQxdGFuNDZz?=
 =?utf-8?B?dG1lS200UjFTZkNNVTVvUlV4bHluV21salprYVFGWkk1amI1WW9UR2VuWFJv?=
 =?utf-8?B?K1dPNWo4U2pweEJFVTB2dDhTWlY3TEM0WnJpMHNabGlwWUZFMEcxalYzWnJX?=
 =?utf-8?B?ZDJ3NExJcUNQWXhoSVF1RHV1SmhuYlJUU0ZQZUhCYXRwTkY4ZWZyQkw0MmV6?=
 =?utf-8?B?VXlRZGZ1SEhpbERzdSsxMW1lMnU4WXdYRlhzZEtINTdCMWpueUhsVHgxRmpx?=
 =?utf-8?B?Y1lxdXJBSTlSbldKK2hNV1VEWEJEMllWZlBXMzlCK0M5dmRpdDY5NklpYlp6?=
 =?utf-8?B?TGhnNzB2M3RXSlhYNTR2SWljR2xUK2gzWXI5Tm42U282SXg1ZTFMNzRhTXJ6?=
 =?utf-8?B?K3dIc0trc2JDWTF2RmdaU0VIKzFUY3RIa0xjY3dsQWtMTnVTekdQcUM5YktI?=
 =?utf-8?B?UVUyR2wzZFNyVmE1bWoxRSs3OUVta3dyNVljM3JUb0ozNHNOMUtIQTVEcm41?=
 =?utf-8?B?M0NOaEZVSkRabkdkZmJwSFhJTEY0bFdRTDUzbzFlTVhBYVc4VVpUbkZFL2RI?=
 =?utf-8?B?RVJ2NkVhV0R1RnkzaTY2d084ZlJJTzRzM3ZCZE1Kc3pNVVVBWHM3QjJ3TXFk?=
 =?utf-8?B?cGFUemtwZXgvai9pYWEvanF3dnlTelZyM0ExNGJjRDZ0Q0s1M0RZelZ0YVQw?=
 =?utf-8?B?alIwS0xnWGtTQ1NlTndpMU1sUDZKbUpTb3lBcmNINW42SW9VM0dqWDlUbDhV?=
 =?utf-8?B?SjRqWmY2dlhiV2xWLzRFcVd1TjhwakF2OGRMSGtoZHkwWVZVaDlJN2l6Z0xS?=
 =?utf-8?B?S0FtT0lGNTBjQkptSlBmTzdhbjR4YmpRUWJzbmk3bFBrd0t1VnNFU29tRm84?=
 =?utf-8?B?a2E5eFZoOUFOVW9kZ0lTWll3TTZGRHpMSk1aTXA3UDJuQkNieEZGYmI4UXUw?=
 =?utf-8?B?cUtKRDFTZjVLTzQ3aXZ6aHoxeE5iZy9kTEtUV1I3aTNZN0FXUlBlS2FTQmVk?=
 =?utf-8?B?b3YrTTZPR0Y4dER2dTNkVkpIWGNxdEU3R1lpK05nWWNDM0FidmIxVGxGdlQ3?=
 =?utf-8?Q?dvVsmsS1qKOUm/YYPKxtlqU=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 844a1910-e1e4-4f9f-33ec-08ddaf501e9e
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2025 16:41:20.4259 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FH+ejENUvsFWTFDVRFum+zrilsD6/e28yhPV9L94JnZ1sqHTZqKLvA6Fx7Hyn36Ai7Ht7DZx1960PlgVum0EkRImKhsYwPuJySnLMu+iFrA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR08MB6432
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

is there any news?

On 10.06.2025 12:56, Mikhail Kshevetskiy wrote:
> Changes v2:
>  * added more details to the patch descriptions.
>
> Changes v3:
>  * fix commit 873112db9ce68c38984ff25808dde726f8dd5573
>    ("spl: Support selecting images based on phase in simple FIT")
>    instead of fixing loading of image with bad checksums
>  * add more comments about memory usage by board_spl_fit_buffer_addr().
>
> Changes v4:
>  * spelling was fixed
>
> Changes v5:
>  * improve description of regular malloc() case
>
> Mikhail Kshevetskiy (3):
>   common/spl: fix potential out of buffer access in
>     spl_fit_get_image_name function
>   common/spl: handle properly images with bad checksum
>   common/spl: improve error handling in spl_fit
>
>  common/spl/spl_fit.c | 53 ++++++++++++++++++++++++++++++++++++++------
>  1 file changed, 46 insertions(+), 7 deletions(-)
>
