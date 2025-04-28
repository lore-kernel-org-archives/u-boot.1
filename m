Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F482C369D3
	for <u-boot@archiver.kernel.org>; Mon, 28 Apr 2025 10:40:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 67036826F3;
	Mon, 28 Apr 2025 12:39:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="ofWrC/sN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1D0308295C; Mon, 28 Apr 2025 12:39:20 +0200 (CEST)
Received: from EUR02-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur02on20627.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2608::627])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 80E5282917
 for <u-boot@lists.denx.de>; Mon, 28 Apr 2025 12:39:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sRzwk2O66Uj83T4BYoXG9Nj2vV9WTmyAz7Uoni4gXZNAnOZFEUIbnjAG7NHPG6uKaE4pK/XAWHYeeHo2oa6GagStRpB9ftKEOWNX0W9nc6DorUmjbBf1SzOmZH7rhl+6dTze1YxqZvru9FgXapdSf+HpyRYEJWj9IcePq1PbAkrxF3JMu0PLqMK0LAcub0WLwTQKDqobrPmIChCMeDLwLvQYPnqyx5cBn1H0v//vx5X9xRnf9jZXlCRFh+gv2gHie27qh3EMP3Ib+X13mcg5pbA7Ok16F2r5Wg96b4Tlw0bKMuaZW95MMl8jVGikPmBj9dH5IuyhZ0kgPgPhJJc+0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7zfK9EdTagTGkt2JU7wimI8dKrGiI0F7TX+Yjdexn0w=;
 b=ar38JQgs5y0d972qOlBlzy7r1TqU+GhyrkD/2jLA00vyLb8yGPBHZ5PO2XMft4STVo8SgakrLVUM6wF19P0XxGCz5EIS0KB2wLE7B9/y2wpTYr4bh7l3cSzDXmojQmnSdszc5gk3V3DCUbUDqZ0zCLyPgFWThN4xx4YdMByMdT30ewFUuXzJ39KcMiXK+mcB/717wpSDNgFer7Pegfc3q30mPhix81cA7LJ+739o9+P0aYa+Wniv5PKvo4uRaVCmmKN+EBMB5I4vjNnXGeIEM6fE+CoxSNEt2mQodEjvpHzKYji6HGShBAWfPwN7hFAdRDtoiFBEuGja5Y1ueggrpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7zfK9EdTagTGkt2JU7wimI8dKrGiI0F7TX+Yjdexn0w=;
 b=ofWrC/sN3XLl5ECSiLGns9Us9dZYvB3dex9KgUttCbDooS7dUvhk6VoTKNx0Sxcrp5sgoatEW7Ms2rGcUIoKdntqsXsTTU46gHkmoJfnfTo/ayFYWRl+syIwYrrb1lcDhM0voEdD140GHS76I8i49DU4d3Zr6zKHC9p6zMvPr0WFIf774jluV0qER4zldoMZflZFnRCSOd0h4I4MBc89PCKB4Nt8DNnt1eOwfoG4zj9l0wsRXa3LxfvFzvlxxavUE9me0boe3qykhJcJnwt6RnJL25Oe2zFKBJvUJmHvKnr5gNoUbULWvps1Ar7nvaW0o2ufn+S0sQj6gsWhh4aG2w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by AM9PR04MB8940.eurprd04.prod.outlook.com (2603:10a6:20b:40b::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.33; Mon, 28 Apr
 2025 10:39:15 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%6]) with mapi id 15.20.8678.028; Mon, 28 Apr 2025
 10:39:15 +0000
From: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
Date: Mon, 28 Apr 2025 18:37:35 +0800
Subject: [PATCH v11 12/21] cpu: imx95: add i.MX95 support
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250428-imx95-v1-12-a3df9c340ace@oss.nxp.com>
References: <20250428-imx95-v1-0-a3df9c340ace@oss.nxp.com>
In-Reply-To: <20250428-imx95-v1-0-a3df9c340ace@oss.nxp.com>
To: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>, Jaehoon Chung <jh80.chung@samsung.com>, 
 Simon Glass <sjg@chromium.org>, Stefano Babic <sbabic@denx.de>, 
 Fabio Estevam <festevam@gmail.com>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Alice Guo <alice.guo@nxp.com>
Cc: u-boot@lists.denx.de, 
 =?utf-8?q?Lothar_Wa=C3=9Fmann?= <LW@KARO-electronics.de>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: SI2PR02CA0001.apcprd02.prod.outlook.com
 (2603:1096:4:194::10) To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|AM9PR04MB8940:EE_
X-MS-Office365-Filtering-Correlation-Id: 161e0be2-5fc0-4122-be43-08dd8640ec11
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|7416014|52116014|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WGF5clF5YXVHaWF0L1VBMStmUUhhbmduaGRYRjBKRmU1V0dUdDV3MEt0UGpp?=
 =?utf-8?B?dk56dit1a3VCVUJnaVlUSUI5SmpPdHkwOHVsNFZNdmtIVmlyZGR4Z1FyZWIw?=
 =?utf-8?B?WnkweXc0bWpQc0k5MThFRXYxSTl3SmtxZlB0cEdzbitiN0pSVzhUQW9PWmdZ?=
 =?utf-8?B?RzBlNEZOaUNKSS9vYktYbitiNWlaQ1h1YzIzWENlbE1lVVQ2TWU1NEdTMTl3?=
 =?utf-8?B?YURWZmRLcFM4M3FaeGwzUXdJR1ltR3dmWm5vNXdoOE1lQlA2U1lQK2thS2xL?=
 =?utf-8?B?N2pYY0IxTlRoSmZBQmZDY2dmVVdCQTNuVUlLWG5hWnNhemtGcVZmaVNna3Nz?=
 =?utf-8?B?clFGQ2hLL0xIVE1QYmlxTThQYlVoNUd3QXM0eHc0OVZvQzVhN29QaEFzZDZk?=
 =?utf-8?B?THZHc0c5bEtpY2lLYi9JdE9pTGMvNzhHSkRWRGRMd0JpS0t3bFI4NkdXMkY4?=
 =?utf-8?B?bzF4WU9mQmFoeXlXcndaUnRtMVY0MnpwS2Z0VGJ6a0kybWwvUmZiT3I3VE5i?=
 =?utf-8?B?d1pXUDB2eFJVMTBtVG1UVXFGSFlNd3hYNnBqVEM3UXlFMEU5NkJ0WmpIUHF5?=
 =?utf-8?B?ZWdQclJGeTJ2ck9leHdzVU5KdVl2czJiSWFTSmVkNFhoTm5Nd21hMWhhL010?=
 =?utf-8?B?aXpHbmNvaGJjUDlZOU01QlJGcXRsMFdTWFBuNERXWkR5VkRhd0xZTG51bEF0?=
 =?utf-8?B?N1F5RWpLVlkrMUdyM0FHaDJRUzI5S2VjeXJUWXlYKzlaLzMyZlhGSXRZVU93?=
 =?utf-8?B?cWM1cHZpNGh4OWhNOS8yTTN0QnBCUE1aWHYxM2MvdU56N2hjTjJZaC9pZks5?=
 =?utf-8?B?bUREVE80d2FiLy9tSGFSMXZxbVJSbnNaa0d5K3hKLzFpQnJGUnBFc0pQZFlj?=
 =?utf-8?B?Yi9WamU2MmtoeXNqVVAweXpyTDJaOWxNY0NuWFdVYmsxUmNoN1M1c0VncUFm?=
 =?utf-8?B?cHZLMHZ2bHJrSGw2cy9vOEtTNDlxRkZyVmJ1THNkUGR2OHA5dWVBTmMyR3N0?=
 =?utf-8?B?SkNZbVdGUGtTUUJuYk9qQXhpekFmTFlabit5Wmtob3NhN05tdjYvU1VCOE1P?=
 =?utf-8?B?eU9Qa292QkN1Ui9ETHZ4SG5sYWFTdjNJS2l2SVUvejdkWFVwYlNpcFJWSGlj?=
 =?utf-8?B?RTlmM2ZKanhtc2hQaFROalFtVmxsTjRRU3FvcTJSekdTQ3c1Vzc1YkppR2xZ?=
 =?utf-8?B?OWwzcGtIVXdvV21lTG8rWGZPMzJnS1BXRVdoVTBTdTBvclJwczk4R1JnMGFo?=
 =?utf-8?B?WU50VFJzOGpSS1FiQ0IxUUJ0a2tHRnBzcjF2ZGZRU3lRZHBQOG5mYW1rVnRp?=
 =?utf-8?B?Y1BzNXpaQm5XQXp5UUxQeElmYnpzTms3Z2haRGFyUHcyU0ZMd0kvSXlFczc1?=
 =?utf-8?B?b3lWNUZHdXQ0YjZ4VE5meHArcVdvamlLNzR5T1U4bU1aall5bUQ1WVk4dkha?=
 =?utf-8?B?Rk05aHFYMjhrajlTQjZnZExXUEUvM1Y2SERFaEUvSUlndzcvUlQrQVcyN1d0?=
 =?utf-8?B?TmZKUUFmUFV1Y2NNYmt2clJzTVArRThxcjYvVnVJdmJvV1dEb2xRMkxwWWxu?=
 =?utf-8?B?M0ZZdGVrVGhyQlFFM1pHcUY0Snp6UTFxa3ZLYVNkQVBwRkxwcjVDck9pTXFN?=
 =?utf-8?B?Vk5tSjVUbzN1Y0dqVjhBTllacXFxU1AzVHNqSGNVZGhjMVJvSzhyV3pFb2J5?=
 =?utf-8?B?aTFaKzR2OFYraGl2YmNBMzczK1FTMWF6MnBPQ1BzeXF1UCtiWWRpMytUWEhR?=
 =?utf-8?B?cUNFLzhXbmJNZDQ5cmhLMDZUOWhyWURHZlo4cXJKN0gzMGR3REIrR2xZTFlH?=
 =?utf-8?B?eUlVUUVCbG83TTJjMTZxQk45cFp5QjFmTUVNTXdXTnF6Q1BpTnJ3a0lXdkQ5?=
 =?utf-8?B?Y3BUc2ZYanFOOHpid2RXQ0ZPaWRiZWZid1RWUTZBWUNqL3ZsaUQvSHNIUTA1?=
 =?utf-8?B?U01HTlJGMExlQ09RSlZNZWdZQUhrd0plUGs4UzdZdWpvUjdzQngyaXVpYWk0?=
 =?utf-8?B?RlIyY3kyU2hRPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(7416014)(52116014)(1800799024)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YndjdjRhaXlZOUw0OGsrc0I3THhHOTVwWUdNZy93Smt4bFRpQnNYc3lPVmFQ?=
 =?utf-8?B?OERXWlI1RHVSc28xMlNDajdtTmV6SHZKU2hzNFB1MGwzL0UxSitPMVlUQVcr?=
 =?utf-8?B?eG81eTVhMWpZUTF0b3FhZmllQnQ4eU00MVB4OENvVk9rLythVXBwcjdwa0pG?=
 =?utf-8?B?VGJNaGFhOE8vdENEencvVXBwUHdNNTdodGd1TnM3MXRWQkVDRzdVNkpDRlN3?=
 =?utf-8?B?Vkd0NTZLZjNlSEwwSzExNXVyT3hVUG54amhSd0szZmN5SG1ta2YrTW1IZFNH?=
 =?utf-8?B?K1pWb0dERUdUaFBEcWVvZ0RzdHBuMGs5c25ibDhtZWd5azcyRVhrK0ZRaFd4?=
 =?utf-8?B?b2VHQlc2aTJSdldZWWpjNm4xaERCbTNzMlJWT3hMazQ5UWt2TnFqRGl2TnM5?=
 =?utf-8?B?Z1BuL21zMHBhSEh1NWRjVVUzQzlFelRHQXhxMHRkdU9CM0FTMTVXN2dXWDBB?=
 =?utf-8?B?TVlGelVzRGcwQVNtZW5rSjZBWGhKam9KRVN3T0VHZkJBL21wQzEyemkrL2lX?=
 =?utf-8?B?Y3lYckFjYjM3MmgxaTdYUERSdjR3Wm1QOGtaemxjTDgySnVXZlRjaFg5eS8v?=
 =?utf-8?B?OU1LUGhjTFk3QlRLQmRhRm1EVkMxSTR3ckdGa3k4V1BlUHhYbmxoUTRwekFr?=
 =?utf-8?B?bVlILzNmVFFnSmlZa2NCOEdnY0pXbHFaODd1SVk5dlozVThWdDZ4dGI3aGNz?=
 =?utf-8?B?TURnR1ZTMXdIR2Nka0UrTDJBR1FYVGNPeEZMbkhlUVlFaGpjOFJXVlkzUDFo?=
 =?utf-8?B?WGZ5c3J2bDVhUEJRNmY5Qm5KaVArTVRZZDl2NGtLSVJGZnNUQ2dNa3Z6YTRm?=
 =?utf-8?B?bVdrb3UyS1d2di9jNnlVaXBiVzVIUXI4dTUyM2JNWjJZZVZNRmRQWVhBRlRo?=
 =?utf-8?B?Wi8zd254bTFGNWhVVS9IMWZ3Qnd2ekNsODhKSzFDb09oUnY2MFZ0NzFpYXVI?=
 =?utf-8?B?K3ZFV0x4Y20wUldDd0JCZGl5Ri91WDNXVXRWV0ozcWFHNnVWUTBWNEo5U2xq?=
 =?utf-8?B?b25HOVRrSlo2ZkgvU0dLRm1wRGtQdlRUZWZjK3FxS1ZWMVcxNThSdXJSalRv?=
 =?utf-8?B?RDlzYXQvRDM3azhKeGJwQVU3K1I1bHZKdXVFd2l0aFV1cUFBQ2o4d0lydU9O?=
 =?utf-8?B?QUQrcW1Xa1BMRnNMTjZvbjJzam5WZEhma3hVNTZPZVlXbmhZc3NYb1BoYlov?=
 =?utf-8?B?SmhyV2x6ckgzVFljTmJwdnE5UGtUby84OVdsNjI2dDJKUUdPbzNhSDZ6VGVG?=
 =?utf-8?B?K2FYMWhsTml4RHJxdUhmSjlYYnJzMm5HeXNKczdMei81dm5vdzl1eGVPOFRy?=
 =?utf-8?B?YzdISi9VdnkwWk5sVHdtT2c0STVwK0U3T1Rta2JUOTlYcGVwTzAyOFZaM0Rn?=
 =?utf-8?B?Y0JXVlFDRzBBM24vN3RWRitJc2ljT2FkR2ZDMnpXT1NnVmdBak1nc09jNyt5?=
 =?utf-8?B?MjNVazYvbzlENjkzSEdLZEZmR2d2MGJkSTBrYm15NVJndFI4RmN5WmtFS3d6?=
 =?utf-8?B?eFNkbnd0R3VhTi9lTjMwMlk4enlCb3hYUFlyYmk1TDhJNXZVaTltbEJ1QUZE?=
 =?utf-8?B?M0dkTThmdFNhT2dUMFRaMHpJSTg1b2paenM5ZDh6bHRYMHRrZ2lUSmJycTF0?=
 =?utf-8?B?b0xCZkcvMjRSVDJMSFgrMHI5M3lySml1aVBmQWI0RmN5azFkYmZCUTcrKzg5?=
 =?utf-8?B?N1Z1QkViRXZnNG44ZkxIOHExS0xZdkMyT1hXS0tNc0lxZi9WdloveGcrMFpL?=
 =?utf-8?B?S25RUUVTYW43UWhFNnZDaElmUHI2WUNHVDhKcDU0QlRmeEtGNmc2N3RiWnph?=
 =?utf-8?B?a1VsTjl1MGQwejd1UzZzUXVQWUFwS2hVWFdmTUJuVEVtVUZWdmthWGxUL0NQ?=
 =?utf-8?B?Z1d0T1IwSWJqY2dVSXdzMWhFT2VXVnFRa2hlbEhXMUpLd2IrMm9lblNFM1Bl?=
 =?utf-8?B?ampuOXNOS043SHRkaW5zVVlFeXVpU3cyc2dTL0Nob25rVVpYNEhldmJteUVD?=
 =?utf-8?B?UGpCbGFJNEI5QmphYlhtVnR4WjZVT2F0cUFtZWN2ZTRjREtwM0w3Z3RPTVFu?=
 =?utf-8?B?YW5FUTBIS2c4ZHN4aXc1akJBZGo0eXlyNkxhS0IrL0lIRGh3aDFUam56SnRT?=
 =?utf-8?Q?kULDCl61ul9b0Wk22rdWUyEcC?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 161e0be2-5fc0-4122-be43-08dd8640ec11
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2025 10:39:15.4529 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wVqOqXp7O5QAI3Z2gclZaN5NBw9gWEj8vNqPbkWKOT0QvyzXcGF5OEKX3dREGEB7sZxcBS/qyacmXxLk4MOFWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8940
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

From: Alice Guo <alice.guo@nxp.com>

This patch is used to add the imx type string of i.MX95 ao that the
i.MX95 CPU info can be printed.

Signed-off-by: Alice Guo <alice.guo@nxp.com>
---
 drivers/cpu/imx8_cpu.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/cpu/imx8_cpu.c b/drivers/cpu/imx8_cpu.c
index 4e1eccaa5b0..4836bddd93b 100644
--- a/drivers/cpu/imx8_cpu.c
+++ b/drivers/cpu/imx8_cpu.c
@@ -111,6 +111,8 @@ static const char *get_imx_type_str(u32 imxtype)
 		return "91(11)";/* iMX91 9x9 Reduced feature */
 	case MXC_CPU_IMX9101:
 		return "91(01)";/* iMX91 9x9 Specific feature */
+	case MXC_CPU_IMX95:
+		return "95";
 	default:
 		return "??";
 	}

-- 
2.43.0

