Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69622CAC5B0
	for <u-boot@archiver.kernel.org>; Fri, 26 Sep 2025 00:51:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6263882AE1;
	Fri, 26 Sep 2025 02:51:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="V5bSY69p";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B22FE8206E; Fri, 26 Sep 2025 02:46:00 +0200 (CEST)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2E5CC8004F
 for <u-boot@lists.denx.de>; Fri, 26 Sep 2025 02:45:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xDIjNsDF8ysrowl0JFp/b3z71LP6BGe34xS1ep8SJWV3vhA6F/d0msh2SLcghn1LOYRG1exGTmIgRz8Aa2pVayi6vTvUngUFCudNyBemJeq7xez2wWx0qip40swo98Q2h87YbDSKrCVUj0geWoolsEV2YPjXMN0zNDqVf6RNyU2ojltoJ4jBjZ8YhC3wzWpvWv0vOJojnbAUcIFd6bfdJwF+xB3qEkdkjk4ubeGxuDA90hlNEeFrgmBt3k5PpohkXGFbG7DWYyirZL5KJDpfJdyVDd0x/H//0NQohjd3Dz7lsu6EHz9dvsAk8wgTslzkzv82/XOvoM+4pSZh0rKbMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ig7+WOWvyY1mH4ZgVWcNGiUX13MYPPROUz7TenAbS40=;
 b=LmmZvlmv0cvRymwtQAWxECiFYJp9k1+HGg3Sj3EM8nT4hWPJ739U2zgO3znkMnv0wRZbNM9ORKivsVMeV5AyUVpqzriF2b+3e4DtlEZeYKDh6V5/UleMq5dtF20H6czKQ7fl5N2aWGBuPmCnwosTUGHAOSqfcQhvwV19vMoFVz6FStkrrXHQnu26QUrr/nwfhLIM/2QZGNooKmjZCc+wNDCHpB5pToEeI3k50r5DDRWg/eEDJaHqbUg9WVCIl+fCc9O6G/5MR2dgiBuT/q8puUKrp+pQgWQU77GDdiEurNZnrgy1IQG+5I+D8IsXcgxBflYWSkQaKxzJo0jZxuedcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ig7+WOWvyY1mH4ZgVWcNGiUX13MYPPROUz7TenAbS40=;
 b=V5bSY69p5gq8/Bgx5j69vmKaBckyIuct3mWL1a8WwfEmEc42/iI/Ufc8lsNR0ag5bWWv4P5MWeWTEdc3OvzvBGSO0MwRoiTYfoRcG2+9bsu/6APZi1D3oxyZ1/WKfSUtKBjkF0DayovBesVnV0/kdhtwg0lVXI2r/MfwT9BoY9R4J2PIPiy6WlvCnHCD83T+fFBEpdxczX+kjv4lRpq/ZjH9YlDVVjx95rljhyxZCQnu8jYQs6grpjPXJEi+CBPbloYpFylm2YgpsAV4sPxFWQIstnlCBkl+MgUot+gRnGeltQvwgNoUQJdDH08MpX/v9GAdHcjQcMsRhqzpaG4E0Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by PAXPR04MB9327.eurprd04.prod.outlook.com (2603:10a6:102:2b7::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.11; Fri, 26 Sep
 2025 00:45:55 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.9160.010; Fri, 26 Sep 2025
 00:45:54 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Fri, 26 Sep 2025 09:57:47 +0800
Subject: [PATCH] MAINTAINERS: Update MMC/POWER/FREESCALE QORIQ
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250926-maintainer-v1-1-3967fbd79dca@nxp.com>
X-B4-Tracking: v=1; b=H4sIABrz1WgC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDSyMz3dzEzLwSIE4t0jU2NjEzNUwySk1NM1ACaigoSk3LrAAbFh1bWws
 AOD2QzFwAAAA=
X-Change-ID: 20250926-maintainer-334651b2eef0
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.2
X-ClientProxiedBy: SI2P153CA0005.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::11) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|PAXPR04MB9327:EE_
X-MS-Office365-Filtering-Correlation-Id: 64d224a3-4d6c-4ffa-b472-08ddfc960ca3
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|52116014|376014|19092799006|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZjlUUFM1RkZ0NWV6MURRaDBCazk1b0o5RG91R2tJMmN2THpPTE05QVJkNys4?=
 =?utf-8?B?Q25hdUpsSzNOcDZNbE1BUGNYMWtzOTVocjdHb1htOHhOL3FUOVdWaGUzVGJh?=
 =?utf-8?B?NDVLdzl1YktqRmlDUGlhdjJzKytoL1ZzK0RHQjVPOEZTT3NZaDhHQWdtem56?=
 =?utf-8?B?aEhYVGVvdWdNMG5yUUpmMHIvTFpRQVNxT3RROEx6WFY0d1BCZm0wK25nYXRJ?=
 =?utf-8?B?NDNya2twOGN5WEFQL3JyUWhGUW5vdXhkWDFQRzdjeVM2c29LTzVBQUxxR2JE?=
 =?utf-8?B?dUN6aVRLb2g3THcyOThlb3FrVStSR24wSFZJOUxrOHgrR3NzQkRYNWFQT0ZT?=
 =?utf-8?B?TkEzNE1NWjBEZldBY2VTTTF4MDBXTkluQ091NUt5WDBXUGw1RkNaRlFhVjNJ?=
 =?utf-8?B?c25JVStSWmZaWmM4M3lmWmlMSWtSdmtqRi9NTHJoODNvVThqRmdTNW9laVAr?=
 =?utf-8?B?UFVqa1BQUUo4cDdjRlM2ZS83YmRWM1Joa3JRRVN2KytlYXFPUHdYTWtPdElL?=
 =?utf-8?B?ZUVSNk5HU2c3Rm5iSEdUZmx6bFI0TVhJMVB4TUxxNFhjNXF6YWRiWm5rZ1JH?=
 =?utf-8?B?eXl4VUJjdHhkcGVKbkFueHlWblJDcE9VQWEvWFpqZzU0K3A2bWlnSGhRL0Mr?=
 =?utf-8?B?WXNhWlpOUDYrSHBuT2V5Z21NeFVvOXo2YkhubWUzSlQyeG1sdmdodnFjamFO?=
 =?utf-8?B?UllaSWJvN09NVmlqcitzanNVWmltWDJhU092NElOWUtYL1FBTUw4dTBXdUkr?=
 =?utf-8?B?eTVXd0U5VWFJRG1SQ2NiRlN0Qks3ejZhODBpTWpvN0FIOGtWSis5UUQvU0c0?=
 =?utf-8?B?MGFwbFFBZjFNckNRTU50UEdqRkFQeWYyeHdncWgxalhsNFFkSkZtOGxTWEkx?=
 =?utf-8?B?amJsNHhaMEsyOGlyUXIwN3FsbWJsN3g4Sk12anRNNGxUT2RKYUFETWgrOUs1?=
 =?utf-8?B?ZU8yY0pYeC9Eb3lyZzllZC81WjRjQWxoVEFYYnRZSExyL214R0lEN2I0ekFR?=
 =?utf-8?B?UDRGU0NsekpneXp2WldwQ1J2MzVoK1BhRnVTRjVEQ3NZWUI4N0NpY0dka2dK?=
 =?utf-8?B?UmZVTFNKYm9KYyt0ZTNGcUJwcnlTdkszd0tnS0VJckRDNWVSTVFGdzF6RDlx?=
 =?utf-8?B?Uk9NOHdkeGhqMlgyR05GR2pQVFdsa3Q3ajhKdGhTUUVzaWhWQkwyY29iaEFB?=
 =?utf-8?B?aGM3a3JJRXRtcHptYngxOS9lNnM4Q2NvVTd0MVBqZlA2dzlMLzVndlVyb3BS?=
 =?utf-8?B?RkZRK1UrK2dYSnJPR1JOcnJtWU0xK0E0NnI0UVNjVHV6OTdyTzBMVzV0TGFP?=
 =?utf-8?B?TmpENmVvSlQweG55RmZsRmx2TjQyRGtaUlc4bVNZVGgyQ2FqdXZFNWhKYzFG?=
 =?utf-8?B?WGd4ZURRQUl4RnVUa2dSUHdnY2lpa2h4cWJxL2JKb010bnpNRDJDb2lRWFp0?=
 =?utf-8?B?UnBvdWxTNUtId1E1RllpV3k4aXJVaEUxMHZ2YjVzV3RmSjRVeUxZNFhrb3lo?=
 =?utf-8?B?S2RuaUtjN1BtY0ZNc0RubHRLRVpXK2liZkJ2MmM5bkh1ZkQyLzRLRmVaV05G?=
 =?utf-8?B?b0lrTFNSL21rbUFOODJIWlh5MSs3RXhwMGRMeXVZa0d6dUQ3NmFiY1ZkQU5P?=
 =?utf-8?B?SU01M2dKcXoyUk9aMkRVdmpnUThMbVNIdnhLaWIveldqdGlkdi9tMnpFcGJm?=
 =?utf-8?B?M2RTTVBKY3JRUk1CTDMrTytxaHJ1RkxvUk0rNU5vYnR1ejhYKzZ1N1pKTURz?=
 =?utf-8?B?UW1wdlMwNmpRODhqQ2xidFRGOHZnak9lTmpqSGswOVpOaHhqRkMvTk1sWlhz?=
 =?utf-8?B?Ti9nWUZtVkdtVjRRbDJkUnM2WjhNczJLQ05oUTNTWWV3NklYdE1Ock1vSlpi?=
 =?utf-8?B?dEQrRk1pRHNaZTdoeDIzRFhjYlFNWXRKRkdYQU4zWmxuUlRhdUFmaUFWRFJ0?=
 =?utf-8?B?c1ZybzJEUzdoNTVVMmVCWXBKU0Y1UEFLRlFNR3BETE9RYlNWVUFJakRZVjRh?=
 =?utf-8?B?aGVxeWJMN09RPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(52116014)(376014)(19092799006)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cEJiWWlRM0xvc01PSWZVU0R0L3VjV3ZwejFycTVZbHJzWDVnVDRBNFNaSWh0?=
 =?utf-8?B?YW9EQnk5K2xtdTVhQXlOSXNHdUkweVhVTFBOQmhLQWVuQkRqa2tnZkcvcTl2?=
 =?utf-8?B?b0lBeEZNb2xESEdjK2lvVHVUbllyUUpKWHdjRzlyMjJIUStMWjh3K1U5empR?=
 =?utf-8?B?VmhNVW9SenlnendKV2VzOUx5M1dOdlBMM2FLWVpmam9nUWtsYnIyMFlkeElr?=
 =?utf-8?B?d0JCK2dwUGprb2ZYWEI5WG9LN2lVRE55aHdJYmpjdWFQS2JxVDV0WWdWS3dE?=
 =?utf-8?B?WnMwcHN0bGpXSFlLTXVmelJwQnV6SHZsR2FFQ1ByWUVZVUg0YXhHZGhUZ3I0?=
 =?utf-8?B?Y0JSYnVEVUwyY1QzR1I4Vjc3ZWZWSUlZRmU0dXlGeVlrQXRnb0JnQ3VrUE95?=
 =?utf-8?B?VW9kelNjTlBiNWZDWlFTQ3B1TnZhUmpNL0ZQY2p4QlJoUXVpcVI5dUp2bENj?=
 =?utf-8?B?c29BUHM2RmF2UTVyZ21CeW93QjVKSmROamkrbzVwSVNJdjUyaC9xd0dWYVBM?=
 =?utf-8?B?eU0yOWU4ZjhUM1B1ZTZvWnVKdEJyYUJ4REJ2T0xkMmU4ejJmVFlPdTBhWnNI?=
 =?utf-8?B?Z29WRUorVTg2SXZucElUQ2VFNDk5U3k3VDBqMkxPQkUvYkpJTjlYRU5Tc0FH?=
 =?utf-8?B?RnVWbDJyc3V5VGsvcHRXeDlVbVdoUU5hejB5Tno1Mk1NcW5ZUjdMMnpBVkhp?=
 =?utf-8?B?OUFNVGNNU3loOGJkRUZKMzhtNC83REpob2ViajlVaTk3cGo4bmZlb1RrNEZM?=
 =?utf-8?B?WEtxaUJTVC90MWpsRHNCSENsUDAvSW0vTW14MWVwanNqRy9MTUNndGJ6Wkxm?=
 =?utf-8?B?N3d4bGFSaUtmK2ZnbHdrWVoxY0tGbDlJKytvL1RndCsvTElFVTJ3dUFaZ2Rt?=
 =?utf-8?B?RTdCTEFrQXA0V0xOSXRxYUd3RTE5RWt3TS9xYXVPSlovdXhNSm5FSUFkeTZS?=
 =?utf-8?B?LzJPSTVxSjkyeE9haExoRzZ5TlY1Mjc4NXh0UjM3WUFFRk5LWmtNVkNSWDUx?=
 =?utf-8?B?NW5jMVV1bjcyY1BMQXRFQTBwY2xLSkJjMFFkVmpxeWY3RWtaNkJDdnBEb3dG?=
 =?utf-8?B?WjRVZHBDVUhXdEtUWHNFWC9YemY5SHdnTzVMa05LZFdOVnNLeXgxVDNnQnpR?=
 =?utf-8?B?MEpkUDBuUHZVRDhxQnBNZEp4aUEwNko3N0Z5UG9JakpyS1R2Z1g4dnJEb0pH?=
 =?utf-8?B?WHRhYWlObnBBcFZUR2g0K21VbnkySWxPd1dpMUNUSUZSQ1BIbEkxbnQrSnc5?=
 =?utf-8?B?NnpJQ005RFYvM1F1cjRJVmhxMjBwem1ibkMxWnZzSkMwbE9pcXByOTZOTUEw?=
 =?utf-8?B?akFiSkZnZFY4S0F4V1hjMmFSWGQ4U0VYY0JtdThPRks2RzdHYS9raEYwOWlP?=
 =?utf-8?B?R21vV2RqSlFPUlN3NUdQOHpWOFcxQytNakVsYVNBV256ZzNjY01RbjNaeHQ4?=
 =?utf-8?B?VWIxQ2FCYTkrbHIvTThxSlVLQjZmak12UTkzQmpTcGh3dCtCbTVaVUU0TVcy?=
 =?utf-8?B?QW1vUFBSUkxZMG50bWRxZnZ0dldMdkZKWGU1NUJyaHBGR1o0cXBJSGZXbXlo?=
 =?utf-8?B?ZzUreVJWSGRicmgxc1F4ZmVaZWc0eXdHcHFjbVlRSnNLNTRwcUVSeEg4Qzgx?=
 =?utf-8?B?dUpWcDQydFM1Tm55ajR1SU1UM2ErSGZrd0ZlZkNzcG1KYWRkY3dwbzE2Z0d5?=
 =?utf-8?B?QUxtay94TTNJb0ZyWUtTMDJOdVUrVHdXYmxMTmU5WUZ1SWNNU1NWYXI1dGZq?=
 =?utf-8?B?RTRkeEpOZmdLLzFlKzdKOVFjaUFqZ1BSdXVGdFNiZTlGSVk0d0xVN0VtZ0Nl?=
 =?utf-8?B?UFpoUG9Ec3FVSlc2YTFkWlJrV3dIdW4yWVpWeTJ3dERrMVB2QWpSN2ttTE5V?=
 =?utf-8?B?TmthaWUrZDVod2Z4RllEcTVRRzdNVDB0UUgwMXFHWWVBckNETzgwVHhyWE5U?=
 =?utf-8?B?WmMxVDNWU2pGOG5tbFBSQ1FFa094WXJ1dEE5RHBCVDd6bjV3ZU9EeWZxaVpi?=
 =?utf-8?B?cGdkTmdYNWZ6Ym5JOUowWWVrYmU1UlgvV2RlVVBFeFMxY2hBVlJLTU52VENB?=
 =?utf-8?B?K25lS2RFV0RZOWxXUmVLMW9oazdXbk45cGtHc05YTHlGK2pPaHhOWUZ2ZjJw?=
 =?utf-8?Q?Mj/rV3jSHkq8BXHnjClBUfkpr?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64d224a3-4d6c-4ffa-b472-08ddfc960ca3
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2025 00:45:54.7259 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6ge4Q43h4B2+Q/MoraS1kd9QQZJTm6kz9Tt1iyqUdL5HJv6Q4vrq3KKS78DetNQJ1oppqfZR5xxsT2mkcP8jnA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9327
X-Mailman-Approved-At: Fri, 26 Sep 2025 02:51:26 +0200
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

- Update MMC entry to match 'mmc' using 'N'
- Add myself as POWER maintainer for regulator and pmic patches. I have
  started to handle relevant patches.
- Update QORIQ maintainer. Priyanka has moved to work on other stuff, I
  have been handling this for quite some time.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 MAINTAINERS | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index b030242a2d894863e477c8fa0f4e83d640225569..9d050fade8b2feff003c5ece2e4022d9530bb5d7 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1226,7 +1226,7 @@ S:	Maintained
 T:	git https://source.denx.de/u-boot/custodians/u-boot-freebsd.git
 
 FREESCALE QORIQ
-M:	Priyanka Jain <priyanka.jain@nxp.com>
+M:	Peng Fan <peng.fan@nxp.com>
 S:	Maintained
 T:	git https://source.denx.de/u-boot/custodians/u-boot-fsl-qoriq.git
 F:	drivers/watchdog/sp805_wdt.c
@@ -1408,6 +1408,7 @@ M:	Jaehoon Chung <jh80.chung@samsung.com>
 S:	Maintained
 T:	git https://source.denx.de/u-boot/custodians/u-boot-mmc.git
 F:	drivers/mmc/
+N:	mmc
 
 NETWORK
 M:	Joe Hershberger <joe.hershberger@ni.com>
@@ -1513,6 +1514,7 @@ F:	test/cmd/pci_mps.c
 
 POWER
 M:	Jaehoon Chung <jh80.chung@samsung.com>
+M:	Peng Fan <peng.fan@nxp.com>
 S:	Maintained
 T:	git https://source.denx.de/u-boot/custodians/u-boot-pmic.git
 F:	drivers/power/

---
base-commit: 44c4919e9dd6c162b237633ba689441eca9a149c
change-id: 20250926-maintainer-334651b2eef0

Best regards,
-- 
Peng Fan <peng.fan@nxp.com>

