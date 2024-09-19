Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1E5CCDD561
	for <u-boot@archiver.kernel.org>; Thu, 19 Sep 2024 00:14:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6EC9F8904D;
	Thu, 19 Sep 2024 02:14:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="fiyWW5QF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9BBFB8904D; Thu, 19 Sep 2024 02:14:47 +0200 (CEST)
Received: from EUR03-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur03on2060c.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260c::60c])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6BA3989042
 for <u-boot@lists.denx.de>; Thu, 19 Sep 2024 02:14:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x51pbshVwn9pbytzSnM45Cx5mJ2drnTdvmjNw38huuJsDtSV/lgAFCTaEwDOFIcAGiQI3LBm2zYBiG52iCRZfh3c5Hhj8rWbZl2XSPSj4Mah8N6JC5ji0QHtZz5yWWBvVneamOSlO7V2mNjYuasPEjHYEyiBR3R5reNXeXBZET/GoDzrR7BprKJPyomi9XnAToZvw83S2Z1S73+If0QWp398O/gKzXQ8ZzULBMHoHWDVjU8iwkpDLudJ+JP0+nJnCqDHZOSQYEnmL8ucp9qIBYQy1MM6cdRmiGmC06Bp6hxYpKZ249LPPQlIJpT907dlT8tzHqyNO88K1IH4qGIYmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fk0xNHQWlpXoYgEPtnvwccwF74IvfgshhIa/YiU4zDs=;
 b=HuwztAuLpi27U2QD9gB3Ur2KBQNBRu9LUYVs8JoAyPuTW64tvc28War2gL48Kyn+w429IpJhsqaZCX8PDM5nendS87MVjVPfVI6o4zE/WOSvWxGXLPmFnS6XlIP/sbe5b/PCT7hM4JulmrnnL9cnLXF55HxbZtM+GGwjIQ6FFYJzG3TsC0T7VXaoG+2NNAyK4OgRN0r7Eipp3oi8XCBrkKSHmv5FYyezK2nHgo1fsnaw/sNTj51muAo37aFp9fQCLWJ2+G8ywRhpAAoe2a6o0uNGqD/wGAa1ile+WkUIrbmAHxlB38Gj9PhySFlAQ4gmd2CXaIT1Cbp5f35FClED3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fk0xNHQWlpXoYgEPtnvwccwF74IvfgshhIa/YiU4zDs=;
 b=fiyWW5QFlGb/B/JhHGJprcuTYidxOhfjCkVoNJC8YFX11t5Dr0L/DaZ5MuId57USLswBuxs+bRriMIlvtTRn/6gjX35eLl62NX7MNhHz85fq4nGyh3rfb3yOk7xnkocxoy8747ORVJiLt8Wqys9ADm9C9sbu9U94pUYLyM4m1KW3h33R/gE6JKO4oIROAIaZz9pce6F8oaJBApzglYWAtz2JaAjZQYChVFLmYO3dLEERt3nn9cxDk8aFYCSDPRD/Aii8q43EW+nqWB86G6q1p3v8EyEMxjvvGFBO6oBZNZrBWUN7zH7bfQCCPieLCeKYDS2FWtL8se0CeC21EPSwqQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by DU2PR04MB9066.eurprd04.prod.outlook.com (2603:10a6:10:2f1::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.16; Thu, 19 Sep
 2024 00:14:43 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%6]) with mapi id 15.20.7982.018; Thu, 19 Sep 2024
 00:14:43 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Thu, 19 Sep 2024 09:18:00 +0800
Subject: [PATCH v2 01/21] imx9: soc: wait ssar when power on power domain
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240919-imx9-update-v2-1-0d798d9e08ad@nxp.com>
References: <20240919-imx9-update-v2-0-0d798d9e08ad@nxp.com>
In-Reply-To: <20240919-imx9-update-v2-0-0d798d9e08ad@nxp.com>
To: Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
Cc: u-boot@lists.denx.de, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.1
X-ClientProxiedBy: SG2PR03CA0130.apcprd03.prod.outlook.com
 (2603:1096:4:91::34) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|DU2PR04MB9066:EE_
X-MS-Office365-Filtering-Correlation-Id: 25324c20-5981-4c31-0a22-08dcd8400fcc
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|52116014|376014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MUtjZFBJMDAzcXY5ZEhpQkJhNFptbkx3YU14RklUb25GMW8zUTdRNGxCMHZo?=
 =?utf-8?B?WUpGamdXWHdEUTBRTlEwWnkrUjVvdWcyazA4akcyaEV0ZVNia3FwQ3k2MEg4?=
 =?utf-8?B?L1g2WmRkbUpQYWtxOXJONnRaakxoY2pGUnBMRVl5bWlVWDlYUThpZ1FzVElL?=
 =?utf-8?B?aUVzWnRDelpQRXc3Nys4M1NFeTdMekdKMjczTzFjSXA1MEhvKzl5UEg2b25M?=
 =?utf-8?B?Ynh3ZWcvbUxDWjREakMzZVhoYklNNzRvZzJIdU9NV3J3YWxhYW1ZRDNRK1V3?=
 =?utf-8?B?QlhMejlMbDFacnBxT28raDdkWGQ4c3hEbEFOYXJnVlo4SUFwNEJ4NWZjK0hV?=
 =?utf-8?B?TGxHY3FYUW1TTlpCK1Y0VkZWcmxocWN4NDlpQUVEeTQwMVEvalFMckdNZVhx?=
 =?utf-8?B?b1lhQ2p5bUxOSkpOc09WU3pGbnpwUkVwMkI3aTR0WmRtNXRGOSs5eDE2VnlL?=
 =?utf-8?B?RDl4Z1N3bFBuZ2ZTK0xRd1BkL1JqWTlRYmo5NUJ0VHI3Z0pMUTN4cXlUZEVs?=
 =?utf-8?B?SW5zUHBjTmJ3VlFmdXpRa0hWU3ZGb2lPQ3JLSmFiUmt0djJHUU9FSWl2NGhh?=
 =?utf-8?B?Ym9GNUhsNmt3ZXcrdTBFeUtrR3AvanpweUF4RDFPMGxjMGtKVjBqK05QMWVm?=
 =?utf-8?B?ZzhRbHN6eGFjYko3OVhqcm15YlVSeU1IVkJzLzI1QkMrNitSek1HVUxBNUN0?=
 =?utf-8?B?S2xhT1BURHp3QXhGb0R5ZHBSVXZ1Z1hEbzQ3UTVIRzFiRExkSytscUJCUEJE?=
 =?utf-8?B?eHNCaFplNGlHZWJiUWhEM0FCWmhwQ2J1ZWtRcnZvd2toYmh4YlR0NFV4djhp?=
 =?utf-8?B?MnZKc3Mrd1krem9DNWNDOVhUTzdYaEhidWYrcnV6Y3pCWW1qTjNPN2xBNnJn?=
 =?utf-8?B?MExDYkdvakJJa0NWNXZZKzR4NFFpR3hhZVJBZVlhZ3VrMkZSTGdJUHVpUVE3?=
 =?utf-8?B?YVI2UnJYZUNQNjB5S3pqbzBvaEZRbndiL3JJL2dKWGtwZVdvTTVkTUVITEFU?=
 =?utf-8?B?ckVRMjBmNmFTRDRHUmdJUkNQVXR1ZVpoWEdjd2lnQjRIT2F3ay9hcEpKNkdt?=
 =?utf-8?B?eVRmaFlwZ1ZwU0tGZ1FNdDhOUDBkVHpYbE9CUTE1cURSVFExYWhSODJydHd4?=
 =?utf-8?B?RTNtTnY2eTZ1ZWlScGFTWVZpc3BCejRERGhNZnpmdks3UEsyVEFQRmZ5YktG?=
 =?utf-8?B?bnkwOVpYUmtENlZ5ZEdqTDVzUW43Rk9Ua1dlYk9PUU5XV2s1bEpjU1QzMllq?=
 =?utf-8?B?RjE2cTBGVHJaSWdUMmltenpPRlZaWi9tOXlkMEpxamZXeERMT2lhdVRzYk5E?=
 =?utf-8?B?b0xaeUQ2V3ZUTGRsSllybGp0L1NLL0JZWmtXWVI1SUJwUm95T0NtQ3FCeldH?=
 =?utf-8?B?QkxmbThKVVFHODI3OVRqSThUdVVJM21aek1MeDhXTi96WTgyRmVlSlcwcGdW?=
 =?utf-8?B?U0NQQWdYcXNqRldFMVhUa0NCdFVpdTJ6bUFpRlpySkhmbndPVUFTY2pFWHYz?=
 =?utf-8?B?TkNVaTRjSm5xdzhhWUNYT1FTUTJHK0dXRHZqcFArVmV6dlMzN01NektRK0xs?=
 =?utf-8?B?OGpuYmRVTm5DaXJFNDJwbTZzWjg4eW0xejB5ZjBVYlN1dzlCM1ZwRnlNTkF3?=
 =?utf-8?B?K3JXWW1yU3hRMHVNZHRzOXRjVC92RGMyRU5HWmFVMVlReDBqR1l2VVZyU25q?=
 =?utf-8?B?RkY5ejM2ckRocDVvUDgrZXg1L1ZaSERuWGlYQ25JWllGOFZmNzA4QjlOKytW?=
 =?utf-8?B?OUVHMDRUMHJOTEpPdXN6Q3AwOUdEb1ZrbVkyMWVkTGpPMUROL2JpcGNrTitt?=
 =?utf-8?B?Q1Y0R1JZT1JTK3UvYmJyT1Q0NWpiUWladmpYRHRxbVIyc1NCWWNRK0ZnYjhQ?=
 =?utf-8?B?S1ZNYTNTcnp2SWR2S3Bqbm4zc2ZqRkwzalVPa2dXMTY5WGc9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(52116014)(376014)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UU1BK094RlZJRkptQ0ZvaE5Ka1dER3IrN3FDdENGUFJPWmRHb2xKWndBT01T?=
 =?utf-8?B?b3dFQStYVCtZWnB0ODg4SFY3UHU3MEdUamNQOWF1clZDUkZyQjc2S3ltRVVL?=
 =?utf-8?B?TmhwRjdrNERDandBSzFFczRhTmdJMFlTelFDNnZYNUdHWldYdVczbTU1eXFr?=
 =?utf-8?B?V0tnblNWSzJabXU2ZTVQdCtZSHpjQnpTQzgxdlh1QmFMbWo2d1RuaWRYbXJ3?=
 =?utf-8?B?Lys2cU84MjBKODk2MkFtWlBOOUpSK2pId0pWemgxZHlnVDJOUlp5U2p6bXhy?=
 =?utf-8?B?T0t5SVhuL0lqaGFTVTZPVVhvMnB1eDVsYkNqUDdmRHJ4TjJNSlZxTXVHeFhM?=
 =?utf-8?B?c1F3RVhZODlYZGFCY1N4Qm5URVowOVVKTzRnZys5ZGkwTGtMNUp4bEkvbi93?=
 =?utf-8?B?WXJMVnVwd21nRjlrbUczQkdGaHR4YWFnL3k5dTdncitNTS81S25KT3RvYzl6?=
 =?utf-8?B?Q2dZSDF0RWlQNkc1NHhwUFl4MTJVQmF2UWg5NFNjTldYeXRNU09mcjdNNnhz?=
 =?utf-8?B?VHZCL3lMWHB6RnJMT1M3WGoxdDF1MXVHS3owMkhEY1gyWXlOU0x1NzE0VUR4?=
 =?utf-8?B?ck9BYnlSUDZUaEY0Vm1xOW9FTTRoM0VLbjJ6eTVRNzNHaEd5V1BDSjZsMFZ0?=
 =?utf-8?B?bHFkeWV6L3lKblRWTE8zRjNobmVWdm1sdUJnZUdhbnErUWxEYzhGcFRNVmU0?=
 =?utf-8?B?QWdQTFFQM1Q5RFI2MWEvUHFUTGZEWHMwejRxRSs4amNBclBheHRucXJNL0xG?=
 =?utf-8?B?a1greDZGOEF2UmxBQ0pQM0dmSUdEbko4QmNkUlVISzRWbENxdnpEU1gvdGZl?=
 =?utf-8?B?VkVJUEtQK3BHQnJKaHNpeVRKOVZKRGpNVmhqRmlZOFFhQlJxU2pucXNDOHBP?=
 =?utf-8?B?Unp6MDd5bm93NDE0SzYxOUw5NGNXcG9iVWlTZVZLSUUwQ1UyTDIrVzA2YjM0?=
 =?utf-8?B?V0lxYmFrbFV2c216QzRVdE45bjRNWkdhWUlPRzRvZ2Y0bENoY1BFWGJmSWNZ?=
 =?utf-8?B?a1gvUmZmOUpMMGhyUDdyOXUvY3poODh4S3VPN2k5dW5uTDBIeWNFcUphR3NE?=
 =?utf-8?B?WjRqYlVlUDNmWFA1a2NET3h4aHU0ZFRPWk5Xbk9CT3lmTDlrY2Q5d2gzMGJu?=
 =?utf-8?B?b2N6MEd5K0NHU2dXb3U3NTRpOFlUQTBUMll0TC83UlVSLzNQRUVZd0JhTFlr?=
 =?utf-8?B?QmpHT2kyS1pnOCtwMnIxUWpEODFieXpYY3J1S21JcmlpRUlOdmhZUmg4SEg3?=
 =?utf-8?B?Z1NlbXUvc0NwOUFDQnlSVXU0NFFhSlBiK0Y1eWhLbGx1b1hxMlg1a00xQmpT?=
 =?utf-8?B?SDRrc1ZhWDl4NUVJWXNTZTQ1Wk1nL2JENEdNMm1DRXhsVFpsR2xpMUUrWFhM?=
 =?utf-8?B?NFFxTERuV0VFZFgwc3NUMVJOZk1GNGczSG9YMmR3Wnk1Y1k2bE1WK1R6S3FM?=
 =?utf-8?B?eGtXTXNyZS84VnBBQ2NZajN5dVlIZERkNGhud2s0R0JXY0kwTTFrYU1naVlU?=
 =?utf-8?B?aHFXa1RrL1hRTEl1R2VUR21Ga0syNURDT0FmNndFS2xUQjQ5dkwyc09Bd2dL?=
 =?utf-8?B?NG9TYklnbVRxZXg4YVIwUGpPSGhQMHlvWndleFgrWm5EMU5sRWNuWkJCcW9p?=
 =?utf-8?B?c2c0MVdTRkhKMHRYMXlNV1U1Smh1ZE5jTjl1M1NZRk9zek85eHlnN05RaGx2?=
 =?utf-8?B?WHVYbUE5NUM4cWFmMjl0TER1QlNBakhWQVlZVWFZRVNPYThSeGxqVEplaVBW?=
 =?utf-8?B?am1ZQkR5Q0k0bHdMZ2FYZVppelg2cW4yNFg0cnA1YWZzQWt4TVE5TkdLa21S?=
 =?utf-8?B?QU9DWVhvbnVnR1Y0ZHd6MjJrc0JjTVVVZDNEbTh4TEYvY2x0c2UvbkVUUnpY?=
 =?utf-8?B?aWExZzdma1hXVGlwdnlXQy9MN2hDbGNNRXhmNy9XS3ZFZUpEY0MvWlVtY0pP?=
 =?utf-8?B?WWxXcjVXN0paQnlyaFlQeW1GT2ZNanpwQVpyNUxJNHhUUGt3WE1RbGFSYUY1?=
 =?utf-8?B?b1VEWmpBYVdDS0F0MDVKRzhZTVh3S1YzWVlhM2dtVnl0VGVFcUM3d1RFekVC?=
 =?utf-8?B?ZzFUeVVLTFJmV0U1V2xXS3BTQUZyMjFUQmk3a3E5VG5LMnZOT2ZsckJwZHYz?=
 =?utf-8?Q?+sUYDbUNtamuw1RU1/sgcYX/d?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25324c20-5981-4c31-0a22-08dcd8400fcc
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2024 00:14:43.5451 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /D8pU9ED+7bxLIotQtHHy+pGQsMDn7uVAtwCgNz5CARpx/TLpXKVbIilGqdmUAraN3tvKZQDdHiYZl5uMzmBIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB9066
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

SSAR handshake done means power on finished, not ISO done. so correct
the waiting mask.

Fixes: 0256577a83b ("imx: imx9: Add MIX power init")
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm/include/asm/arch-imx9/imx-regs.h | 1 +
 arch/arm/mach-imx/imx9/soc.c              | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/include/asm/arch-imx9/imx-regs.h b/arch/arm/include/asm/arch-imx9/imx-regs.h
index 76d241eab09..9953c33b73b 100644
--- a/arch/arm/include/asm/arch-imx9/imx-regs.h
+++ b/arch/arm/include/asm/arch-imx9/imx-regs.h
@@ -38,6 +38,7 @@
 #define SRC_MIX_SLICE_FUNC_STAT_PSW_STAT BIT(0)
 #define SRC_MIX_SLICE_FUNC_STAT_RST_STAT BIT(2)
 #define SRC_MIX_SLICE_FUNC_STAT_ISO_STAT BIT(4)
+#define SRC_MIX_SLICE_FUNC_STAT_SSAR_STAT BIT(8)
 #define SRC_MIX_SLICE_FUNC_STAT_MEM_STAT BIT(12)
 
 #define IMG_CONTAINER_BASE             (0x80000000UL)
diff --git a/arch/arm/mach-imx/imx9/soc.c b/arch/arm/mach-imx/imx9/soc.c
index 32208220b20..9b6ba5609d2 100644
--- a/arch/arm/mach-imx/imx9/soc.c
+++ b/arch/arm/mach-imx/imx9/soc.c
@@ -752,7 +752,7 @@ static int mix_power_init(enum mix_power_domain pd)
 	/* power on */
 	clrbits_le32(&mix_regs->slice_sw_ctrl, BIT(31));
 	val = readl(&mix_regs->func_stat);
-	while (val & SRC_MIX_SLICE_FUNC_STAT_ISO_STAT)
+	while (val & SRC_MIX_SLICE_FUNC_STAT_SSAR_STAT)
 		val = readl(&mix_regs->func_stat);
 
 	return 0;

-- 
2.35.3

