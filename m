Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C26DC677C4
	for <u-boot@archiver.kernel.org>; Wed, 11 Jun 2025 06:18:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CCFF382B18;
	Wed, 11 Jun 2025 08:18:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=mt.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=mt.com header.i=@mt.com header.b="bARTDkeS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E1DE582B20; Wed, 11 Jun 2025 08:18:36 +0200 (CEST)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AE59582A4B
 for <u-boot@lists.denx.de>; Wed, 11 Jun 2025 08:18:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=mt.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=Wojciech.Dubowik@mt.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hx7+MfrACT3QoYuzD1fDwxXyaPqZf7tLBy/LzZo5uJdzeUChFwTR3feJHEg03XXceZv0TiOOB3SdkyBBgxnT+tAoPPWKNy08CPubMUGw84smPnR+lzBH4FgyO5xRCRIOWwfuhYsgXC9N5UMfSOY9L39LRzejVKCJxCbnZMCTUckucquNL3PZpxSCW4TCi0kDsMrMA4tEooi2AQDWoqraVAIP6xQ3RlRw2xX2vLStfh7jNoXSAIDCkit6aLnp2RSFBFvpy0xzVfBzrFp94BvQbSPM/9H8yC3zsGjrTzm6dnsKWUIr+5PsZVfmprwRUfFLkQ6+z71kte3LyFXaGm2y2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q8CTlRi3gkeNYeahUzA+UO3Yt06wHCtUC0MYlj356ik=;
 b=IXbOHFkp0EghMUaMG6sxLC+x+EE2fsPL5aJRYhkhflNE1QTmCKFh5tvPKQLUrf2D4Q6nelmddnQfgSJ9IgKW3Wi+nlk2Qhcy//AC9QyuuA8nvP2A2aTj0UpPFQtoppLCj+nP4+2EQXN2U9xSxrWYlRjHv2UOTjEwNNpzE2BnT9oV+Ps8afk+z5ViPmliJ8IrJoOoU0dFSdyBnw0zxaVlRvpqTb06OVkIWtr/J0tV58mhdWiK/V3wWrca2KMoHoovq2Yq98wiXmO5Hr+WQ3SbJGsf0U8oRyi9qlVjp73aoGbytCZqBWkEEhNRBWdE9GfKtzyNZGm0UZ9hUQHSctMcsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mt.com; dmarc=pass action=none header.from=mt.com; dkim=pass
 header.d=mt.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mt.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q8CTlRi3gkeNYeahUzA+UO3Yt06wHCtUC0MYlj356ik=;
 b=bARTDkeS5Vg+Ftp3i9zfWsZeMgxiYUl/xf+ODVOGq4j1GIoBUYIhQCcIib96wrr4ngswLy6aPIBV7MX6EyCgIOpJj37a2WcklEc4JJsJ7FnZyuG/+T74+QmAEwwjUSwBJTB3ROhTzR5E3/TfZvPiTmH4lGdmXUL0yxUOV36QRbyXzzpNikwrn+s+63g+uDVTw9708PV9DHW2OY6wRjFMetVPDpPYcU9Z8R5ICHKvg4MbSoEUiyVYhA4j5xDbmOtyxZkspHT5zqoptjSMH51QvW9oOh4itoTU2DI+aYKWh0pbGky/SZKuR2Zs7vS1wv7t814xFR8Te1zQKdI0hJxcJw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mt.com;
Received: from VI1PR03MB3856.eurprd03.prod.outlook.com (2603:10a6:803:66::33)
 by AS8PR03MB7046.eurprd03.prod.outlook.com (2603:10a6:20b:23e::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.31; Wed, 11 Jun
 2025 06:18:30 +0000
Received: from VI1PR03MB3856.eurprd03.prod.outlook.com
 ([fe80::e9fe:470f:27e0:b265]) by VI1PR03MB3856.eurprd03.prod.outlook.com
 ([fe80::e9fe:470f:27e0:b265%5]) with mapi id 15.20.8813.022; Wed, 11 Jun 2025
 06:18:30 +0000
Date: Wed, 11 Jun 2025 08:18:06 +0200
From: Wojciech Dubowik <Wojciech.Dubowik@mt.com>
To: Fabio Estevam <festevam@gmail.com>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de,
 Stefano Babic <sbabic@nabladev.com>, Manuel Traut <manuel.traut@mt.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Frieder Schrempf <frieder.schrempf@kontron.de>
Subject: Re: EXTERNAL - [PATCH v7] arm: imx: Add support for Mettler-Toledo
 snowflake board
Message-ID: <aEkfnrj5zy3bxlHP@mt.com>
References: <20250604112507.11358-2-Wojciech.Dubowik@mt.com>
 <20250604140949.GO1382132@bill-the-cat>
 <CAOMZO5Dw4s9+omhVR-FHp2Z1boRioyrPStYEeft9ThycMr2tHQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOMZO5Dw4s9+omhVR-FHp2Z1boRioyrPStYEeft9ThycMr2tHQ@mail.gmail.com>
X-ClientProxiedBy: JN3P275CA0039.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:ca::12)
 To VI1PR03MB3856.eurprd03.prod.outlook.com
 (2603:10a6:803:66::33)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR03MB3856:EE_|AS8PR03MB7046:EE_
X-MS-Office365-Filtering-Correlation-Id: e5eafb2e-4a9b-4d3b-ec00-08dda8afc699
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|52116014|376014|38350700014|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZW55VW5ETUllWW9BS0ZNUFUrTXJLUlpWaHpGNzZEMzZLY05sYkRvK3lHZmpq?=
 =?utf-8?B?WVdINFpOYk1aaDIxMHBQTnpHa0JsQ0FIZHNMY01qWGgramZIRzVlb0NsVm9Q?=
 =?utf-8?B?VmJ2WDNlOG5qVitJNEp0VzZYVlQwSkFGOHZ5Sit0a1Y0N1Y3bms5L3QweXQ0?=
 =?utf-8?B?RTBCRE0xREJsRDM2K3VEOUt5MUZJdXd6blhUQXJ0cHNJSytQdlZFUm9BLzk4?=
 =?utf-8?B?TjZ0YzJuWEhwZTBRNUJwYzd3KzI2ak5UQWhZRlJCdEgyRE9maFhOR1RZT2px?=
 =?utf-8?B?S0pWSzBwcjRSRTRXSjZlVmpsaVFmbVlZNG5wSW80SmVmaE5UR0pDQ1YvQXJ3?=
 =?utf-8?B?ekkwM0llbkhTZ3RSbmpoSm5wQzl5cVk5M2EwWWs1T284cEg3NlM4RFYyS1Jq?=
 =?utf-8?B?WDR6a3VHcGRTYzNBUVJpSlN6V2Q0aFRuWlFDM2ZlOVcvRlREVGR4T3U2eVBU?=
 =?utf-8?B?TldNVnI1a3dzdDZFSmswWTJyZEZUeU54STJST1BtMjFRVzV1alRZdzU0MUta?=
 =?utf-8?B?R0ZjVVo0QzlPYWozQzVZTVNrU3FaMzNhYldvb0R2WU10SGNJcTdpeTRrQ01L?=
 =?utf-8?B?bUphMkdKN0FrTnV1c2YraEVLU2t4eTZQMXQrM0dwYWZFNjV1WjF2a01nRURm?=
 =?utf-8?B?RHBRZ0t6akZWNEM1V2N1MnJ5WFRDQm5heUlVYytLM0RDTFBNOGJwZ0RzbXhJ?=
 =?utf-8?B?dXNBdCtSTjVXa3pSdlZ5LzF3MUJnd0NqN1liUUEvSkF4SEk4SEFjcEduaUxT?=
 =?utf-8?B?ZXNUZ1BMRVZqblo4NHMwRnpKZUl2SDI2L3VZMHlKemMycFdDODBZZncyQmkw?=
 =?utf-8?B?SmhtQUNGQmlXODBpTVFNQzNuTnozUE92Y1lWNHFBYzF6SXljVGUzUW0vVmkw?=
 =?utf-8?B?eTFJeU5rQ1hEZVBQWmkwTXZVdCtFaWhrT2g5Vll6UlNseHBSZXk1UDM4YWZJ?=
 =?utf-8?B?eDZYMWxkY1dBNzhuTFNnSzVUbEFUVGdWazZoYTlVcVFQRWFVcXhRbE56dWln?=
 =?utf-8?B?ZzA2YVl5a3FPRWVOVXRabzZ4c3hmNlRycXlXNXh3TVBoR3pNMll2SjBnRE1v?=
 =?utf-8?B?N0hvdlQ2dkltblpNTkNWaWhtZFlGV2VidGYvb2ZOZjNmNmlOVFdrUFBxYjhR?=
 =?utf-8?B?Tm03aVhnamRoTUczYno3VWtLc0RRTlYvWDYydGxPWjV4OTZkTXJLVXpCelVK?=
 =?utf-8?B?MFRCTlV5M29sOVhmYlF6SmJ1Q1Z2UzJZeWE0SmVLMXpTUWRhRFhwMmx0Um5l?=
 =?utf-8?B?ZEk5RWV6UTZzMjJEVHlhcXJCTjRCSVZOL1U0Wkx6QlBoNUtwVzBrYWd5VG50?=
 =?utf-8?B?SnlrYkpXOXVQTmFBMnFYcEh5VTZ2YXVlN3lIQUFPVUk5OHcrVzlvRE5VNis5?=
 =?utf-8?B?TG5XcDVhTFk0dWM2cmJPM3dQQThuQ0FWQk00RkkzRDlWL2hNVVBVbDVhVGtX?=
 =?utf-8?B?WmMveVUzMjVkRFYwQ0VxdFdqRmJYVGVCUzJZcTBZcCtkUkxoWHJXdXFIUk5C?=
 =?utf-8?B?NjVUTTdrUGI5M2pqbkszaHRicHZaaWViNWNFb05XajMrNkZQd0dBbUZJRlB6?=
 =?utf-8?B?dHlCemZudThOdzF2N0lPK2RiVm9mbytGZk8zMWFZVmYxcS8zMGlVMUZEUnRz?=
 =?utf-8?B?azRvRkF3OTFPQk1pUkVMZlQzUU5BcWh6enZaUUx6eDFaODRNbjNmWXNRaXR0?=
 =?utf-8?B?TGZMbGZabU1XeW00OWpsTzlrRlQrcDJFc2FZVVRacE5oNnRud0Z3UjBWOWx2?=
 =?utf-8?B?T2VoQTl4cTFyNVNtRE9UT2c5cXhGRWw1M0ZCbFpBL2pUYlBDZ0tFVEFVVWtP?=
 =?utf-8?B?VkY0S1VZYUU0YlZTU1RjWVZsRG9QZ2plMVBuNDhxVG8zUTZ1cFFyK1JUQlkr?=
 =?utf-8?B?OUlxaTE2bXBXbHdXcUpXUzFmcklpaVhZMllES3NnN3N1NmtaaDIwMGdkbSta?=
 =?utf-8?B?NzcyNkxzWlVWVWVPRmFJaVlVWUowZE9jNk9UenFDVXMxVUVMN09lakVUSmlw?=
 =?utf-8?Q?r00qXDCd6P0Oybyr4h//vgWFBtYvEI=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI1PR03MB3856.eurprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(52116014)(376014)(38350700014)(7053199007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WkFUSzFwVEtZdWdzdW1GNENKVys0SlpUQWtpa0NxWTJ6cTJlVE5kM2dEVmlx?=
 =?utf-8?B?dUFHU3JucDlSQW5pSUE2QTlCNzZSVDdTVFR0MUhwdDZobjZlQzdKdVR1UTJl?=
 =?utf-8?B?bjBIQndNVVJ2eU0zd01lNU1JZ2hMWHA3NS9FalVYNjVEK2ZuaGpRUStoN2Jy?=
 =?utf-8?B?dG5ETnZ0ZHBWNHFMZjJlVTVlMUNxTFJWMm81S2pyNWhuNkhRZEV5VFJVNmlT?=
 =?utf-8?B?ZFNmTGpxdmN6V1pCUnFWTGJudnY4RHRjL003WCtOa09oRkFKbm94M1pPVWJI?=
 =?utf-8?B?eERudFdTR1JxK3g5Z3ZINzN3OURKVWdnZGZBdU5DNnQySXBnYXgwM2Y1TjA5?=
 =?utf-8?B?YWVPcGdudDVrQ0d6SCtnWkJoVnVweUdZRkNVdEE4OWJaalhlUUF3WXIyMEJS?=
 =?utf-8?B?UGloYVZFTGx0aHdlSkdJVEtreXhXc3J2TzYwQWNiaUUrdTRmUGpoY0preFov?=
 =?utf-8?B?UkUwNklTTnFzd3lTYWg1alllUEl4d2VWUWJQWEVORTk1eVZUaXJMd1dBOFFw?=
 =?utf-8?B?TFNZVHZENFVSQ1RKL3FzcVYxTEo2UGhsL2U5S0ZQODVkbmYzN08zdE5KczNX?=
 =?utf-8?B?dWl5cGd1bVNsM1o5djB6ZmlkTC85dkFmVHFLNW5ETGVkZllpOHIrbWtUR2py?=
 =?utf-8?B?Zi9uT1lDUXNNSnFIWEFvZE1YeTdXSE03MlpzemRZYXhoSXlIZDRSRHhmcDJN?=
 =?utf-8?B?dCtDWmJOcTV0MjE1TE5XeGhIVkFQOEJQYlNRV0x1YmIyaUxyVEt4UXNlcklm?=
 =?utf-8?B?blRLN3RVT1IrZUpaNWNtcWZ3eGFWZVU5UUJreDFGREF4aTUzRUo4NngreFBr?=
 =?utf-8?B?bE9XNHZScHhYaXFMZGc5MzhoYUM0WVNyR3haMjNIa3FVUmVEOEkwZm9ZdExs?=
 =?utf-8?B?clFhc1hUdzFab2d4eUREVW9KNlp3UG43dmhDcWxqM2RjODlJSFgyUzZZYndj?=
 =?utf-8?B?ekdPeWQweGxvLzQ3bmJpZllkNjd2aEpGMmlrZjBKdDNleDhVMEZUQmZXWEMv?=
 =?utf-8?B?ck9UZjVnb1c2MDFvL20raHRzOGJMVzJRYnkrQmpHWFZCQzZTd2tnRElLK2Iz?=
 =?utf-8?B?dzJDSkFMd1MwOGE0Ymd0S3p4Zmtud0k2VVo3d041L3dtWmNrcXgyQk10ekJh?=
 =?utf-8?B?Znh2blVscEErdVQ3bzI4SkNYQUVLMzMzTXlVUmo2S01HT0h3NE5WU1pXUkZ3?=
 =?utf-8?B?MFp2Yk84QjRzR0xuMXJWMm9RM3MrK1RlUXp0VFZOWVpnbXhibWtRZDRWSzA4?=
 =?utf-8?B?anVhaTVjc05Tb3hNZ3I2em10NXdkeUVHUERCSzd0cXJJNU9OVit1Z1pneERB?=
 =?utf-8?B?dXhRckFuL3FvODhzY0piODhDRW1pWi9GY1QrRUxTOGZKUmRvTVRYNnlsQ3or?=
 =?utf-8?B?cDVVRDBvUWpCSTk2SzVDdTFqcEkvV1VtNzlkYm5xWks1VlBHbVAvYUs4WHlC?=
 =?utf-8?B?a0U4M29yVElxblVFeEF1SmRMOFEzT0JiZzNNVHpxbmhIZzRTdEhQKy84OEM5?=
 =?utf-8?B?T2N1dStKbllGYm9EazQvUGRBWmdBOVJ1Vk5FWFpRYnpwUGQ1c3N5Wm9PTFRs?=
 =?utf-8?B?VG5mSFJlS2RuWmgzbUpRQ2x0YXZjaXlsbTVreGxYSVVJa0tJOHJTSG4zZjJS?=
 =?utf-8?B?QWNHY3Q0Smk2VUJJejJna0xacWFWZWcvMHdaWUVHTUE0djRMdlZndmJ0eVkx?=
 =?utf-8?B?N3owK2xZVFpYbTU0cEpReFZ0dlAyWC9Ddlloc0ZOU0l1VlFrY25YVVRqWnV5?=
 =?utf-8?B?a2prcVNwNlJ5eDlzWGlWcysyTFN3Y2RON2NMWmR1cHZyUlpsaWlNQzgyQWxs?=
 =?utf-8?B?V0FNb2lPNGtpWkpXSTVWcVRkbXlldks2OGdBSVZjVnRoZFYwMFBVNUMvemMy?=
 =?utf-8?B?RFc1QTFLTHZiRXBxaTJqM0JETk9zdjY5SjFmNStNUHFsSno5cS9uclR0alpD?=
 =?utf-8?B?VzY5aFZjR3YxUTRpL0FVSzlXaVc4eHNmR3ZwbkxuWWJuZ3dMdytqdW1Ha21I?=
 =?utf-8?B?c29vVVdpb1ZOOGVxbDZGci9selg4SkhwSGJkeCtRRUVDZWxkUm1YcjIwVTFz?=
 =?utf-8?B?Mm5HYmI0VE1sL0VqRHM5OHR2SlFYVm92QTBzc2c3WVZuN1ZZSVVYUGFsdXZM?=
 =?utf-8?Q?jbs0khfLSw3DdEPCqnogb/s5D?=
X-OriginatorOrg: mt.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5eafb2e-4a9b-4d3b-ec00-08dda8afc699
X-MS-Exchange-CrossTenant-AuthSource: VI1PR03MB3856.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2025 06:18:29.8969 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fb4c0aee-6cd2-482f-a1a5-717e7c02496b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tFeffcbUWTq1n9ZSasApcOXzBNa6wmpGboPKXjjmr458ZeXBWuAViPeGTxUWdPgEQ233AK77RwoqerOw/l4p0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR03MB7046
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

On Wed, Jun 04, 2025 at 02:07:01PM -0300, Fabio Estevam wrote:
> Hi Wojciech,
> 
> On Wed, Jun 4, 2025 at 11:09 AM Tom Rini <trini@konsulko.com> wrote:
> >
> > On Wed, Jun 04, 2025 at 01:25:05PM +0200, Wojciech Dubowik wrote:
> >
> > > From: Manuel Traut <manuel.traut@mt.com>
> > >
> > > The board is similar to "Kontron SL i.MX 8M Mini" SoM.
> 
> I think you meant that the snowflake board is a carrier board that
> uses the "Kontron SL i.MX 8M Mini" SoM, right?

Yes. I will reword it.

> 
> > > There are two variants. Snowflake_v2 has an external SDCard Interface.
> > > LEIG is the same but without display and with emmc card only.
> > > Both variants support 1GiB of main memory.
> > >
> > > [ bigeasy: porting and a bit of cleanup ]
> > >
> > > Signed-off-by: Manuel Traut <manuel.traut@mt.com>
> > > Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> > > Reviewed-by: Frieder Schrempf <frieder.schrempf@kontron.de>
> > > Reviewed-by: Fabio Estevam <festevam@gmail.com>
> > > Signed-off-by: Wojciech Dubowik <Wojciech.Dubowik@mt.com>
> > [snip]
> > >  arch/arm/dts/imx8mm-mt-snowflake-v2.dts       |  127 ++
> >
> > What's the upstream status of this dts?
> 
> To expand on this, in U-Boot, we are migrating to OF_UPSTREAM, which
> means that U-Boot will utilize an upstream version of the device tree.
> 
> It is OK to use a temporary dts in U-Boot while the dts is still not in Linux.
> 
> When the dts is accepted in Linux, and U-Boot dts repo syncs with
> upstream kernel, then the board can migrate to OF_UPSTREAM.
> 
> Please submit the imx8mm-mt-snowflake-v2.dts to Linux, wait for some
> feedback, and then resend this U-Boot patch with a reference to the
> Linux dts submission.
> 
> As Tom mentioned, the bootph-* properties are valid upstream, so you
> can submit the dts with these nodes and get rid of the -u-boot.dtsi.

Ok. So I will send dts to LKML and wait with sending v8 based on Tom's
comments.
