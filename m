Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A508D358E4
	for <u-boot@archiver.kernel.org>; Thu, 29 Jan 2026 09:10:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BB2B883D1A;
	Thu, 29 Jan 2026 10:10:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="MJJgo1GG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2827E83D17; Thu, 29 Jan 2026 10:10:37 +0100 (CET)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0F76583D1A
 for <u-boot@lists.denx.de>; Thu, 29 Jan 2026 10:10:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cK+EC8eZJyXUCm+0v/h+FAIiHSIvxq5Yh00GYZINXC5+3IPTie7PRw9YuQSL8TYJDBiW1nQ0mSuWuoE5kU/hGdoYsGiesBzXi3iIgABjWbusUAjlAuFYxN4CPFeWb1+wRYjOghqby4waWxup8Vlz72lrZblDjSP+DP9mABMNCU5kKwUBoFNvWtcl4/IQQ6ERD16G7SFvmgU7Wzmd4cuGtPmyA5QJFJBTD0T6NryLj854dAuVbXcZ7h2J//eZr2OHUGNEpdlsqIQ2FZIbNhD8m/0+8K8eRAK+fzgD8M3n3JN0Mt59ssJn2eHfh9Qse6s+ya3C/bOT9aaiHmQUTWeI8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=67yw0M3adjSaGape+FP2jRnX8zwZcm8JRTkLegu/Sns=;
 b=BKbB973dSBO8lfPgh7j5BH1EZzKAb5IooEHBqps3DGlLNWjL7hOWpDS+uj+KcEHj0C1uZ7dNcskAhiQY87a7MM80AEJwwfjR09NpDrdnbcldp3PYxXa/GGPtXRQhDyYCXeRihaIwdVytI0+OuQ+OxS/Hv6tBuUFYvac8tWJI46ILwfjn4JrgyIsJPirzl05G/5Tx9xEb4rViz9BLPFAjUNRlL5rPhHtQgRsnIWlmjAYaPSem8it9lVAFxyzZxFGFruio4zHetqv7updaHfrwFhg+FkrLSmKTvNg1GZGUQBk/qMRBBuefB2UGfvCDJ5Vt3crduJn504lXF7lUjHak8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=67yw0M3adjSaGape+FP2jRnX8zwZcm8JRTkLegu/Sns=;
 b=MJJgo1GGyD3zmtjOPgvwyKyw0zBqXU02zplPMW9xRSUZwPkIPl97/kQguVnhmcKzFt5H8LCwLVl2Wyr8K4tNSreNlDGRuBM016japE24k9tkvTXIC+dMpgP2GCFV6gHxEqmmYeo9mmrHrDRdEOhIqUdNXAwjVOO2ypomaEdrL6TVo7MEkFRX+DKe4MTtBzfBw5LGYYeq+16EWIRUQhuqn9ss/PTHEdmgsM9qSwTev/5YvYSY4WIUbAEentu6jmH0nAobWcJsdTg3WShqQgmk7p/dTWXHCWI8Zar9tGqKEWiSqC9OzmX1XzaNA+8mwFypeaVkfzoq/BY30VIWs4uZFQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by PR3PR04MB7484.eurprd04.prod.outlook.com (2603:10a6:102:8d::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.11; Thu, 29 Jan
 2026 09:10:33 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e%5]) with mapi id 15.20.9564.006; Thu, 29 Jan 2026
 09:10:33 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Thu, 29 Jan 2026 18:24:59 +0800
Subject: [PATCH 3/4] arm: dts: imx95: Add cm7 node
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260129-imx95-rproc-v1-3-035b2dbf3e57@nxp.com>
References: <20260129-imx95-rproc-v1-0-035b2dbf3e57@nxp.com>
In-Reply-To: <20260129-imx95-rproc-v1-0-035b2dbf3e57@nxp.com>
To: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.denx.de, 
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>
Cc: Ye Li <ye.li@nxp.com>, Alice Guo <alice.guo@nxp.com>, 
 Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.3
X-ClientProxiedBy: SI2PR02CA0005.apcprd02.prod.outlook.com
 (2603:1096:4:194::6) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|PR3PR04MB7484:EE_
X-MS-Office365-Filtering-Correlation-Id: 852bd194-dd94-4e90-5dfa-08de5f1640eb
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|52116014|376014|1800799024|19092799006|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MXlsMGJpT3hJR2Q1ZzlrUGh0K09zMFNFZ1lxKzYrVWJ4S29MSStsTk5mOXZY?=
 =?utf-8?B?bk1RZG9vZnFwcG5DaitiTmhJMlNMZ3ZUVm5QUGVpMC85ZFBkM05GazJBTVg5?=
 =?utf-8?B?SXh2Z3lDYm5TWCs3SklSYmNoR0l1SEdzYzBGckJsVGpsVnprSU16SlZhUjVV?=
 =?utf-8?B?eW9iZC95OFVFUnBybGlCT1RZdWpqa0JMb2x2Z0hEMjUwbTcxYm5RY0RoWmxs?=
 =?utf-8?B?Z3hRc3hhV0pwdGdaOUZpRUtYRUhlRFRGaHRFSWVwYWZaWlRkd0IxMVlLdnVB?=
 =?utf-8?B?b3VYZ1pnVVhGMDk0OENXVGdsNHNNMjlsU05UUUdYY0IzRDdVdWZ5K3hEWkFW?=
 =?utf-8?B?ODYyVXFFWUNKNHJBYUYxWkIyR1MvdWU1dWpFcFpvU2Q1Y3JoNDdabVYxN0Qz?=
 =?utf-8?B?VzZQK01uVzlGaUM4NUxKNDlZZjJXeC9yc0wzUGk5K01LZS8yc3gyRkgxWlRU?=
 =?utf-8?B?UFBXK1RxVEpCeGZMZmxybjBUMmxSZ28vK3ErVFMxSFpWQXkvcUMvVkJLMlpI?=
 =?utf-8?B?Q2ZseEczRC9xTjd1T2kwSnNHQlUxRFMzQnY0Rkc3UG1oUlNud1MwMWtVek5p?=
 =?utf-8?B?TGE3aFFkUUhvNWhPTXZBR0JXUURvVW9FT3pIckRwemdhUlpGMzQzTEtZL2N3?=
 =?utf-8?B?aUlRcWE1QVl4S09jTWNqR2YrNUZxK2lwWlZ6WkJpVE1senF2V2J6VHBzVVdX?=
 =?utf-8?B?ekE5RVVoWExTTXNsTWxkdHRQVE9odWVSUmRBVVNOMkJZTWFtUzkvQTBDd3g4?=
 =?utf-8?B?TE1hNUJVczh3cTlveE8zWGNWSG40U0I0WFhRa3R1dnVhQ0ZPemJmaG1Pdk5P?=
 =?utf-8?B?VE5YWGs1RXBpUzZNN2dGMFVDVGorV0p5TmNtRDVyUnBXbVhCS2JPQVlDalFT?=
 =?utf-8?B?aFBET2huSEFJOHJJeDl3NEJqMkpsRnUxeW9zUHhid1dPUjFleHQzbUpGSEgv?=
 =?utf-8?B?eE92UWFxQlR1RmQwT1hwTkQwSEZoNCs3Ny81bG9SVGRaQUhBRzdzTXA5WkNP?=
 =?utf-8?B?TXlMNjdEVjlpMStJREMvc2MzbjJVRkNPY09ZczhnNlI0dWs0ZFJZY1N3NGZB?=
 =?utf-8?B?OStSbjdJUEpUbzgxRHN3RXFtY0FOTFU4cEpPZ0RiTk94U0hZWGE5Vnd1TklC?=
 =?utf-8?B?QXp1djJPTENJRGpnTVFWRVl1YnFGSVF4OTVFektVVlVsTVlZMkIrUG5nQWYy?=
 =?utf-8?B?enRQTzlFT25jOHlPRms0dkFjRXdkNFUyVVM2Q1RVUTlxTURpUHBQWURkWlV6?=
 =?utf-8?B?U3JONWVEL0JhUDIzTlpHTnNKblNVZDc2ZmVLYXQ3Skd1L1VNQXU1L1doektk?=
 =?utf-8?B?NmY1ODNrWVJEZDRmbUVoSFBEQkhVYXJjalFsOWJ6TlJ4clJiclRST3Uzdkp5?=
 =?utf-8?B?SDlIbDNQWG5ZdEVQMzA4SVc3MXNiTlBPNE85dFdJRytmcGpPTjRUSGlYZHJj?=
 =?utf-8?B?VUMvendVSmx3WW1BVEVtMGJZOWFnUHRUVDVmWkJ5UmQ5K0s0MEYwMzRLU2ZO?=
 =?utf-8?B?dVhaU3VORncxcWtXY0NxakxFbTVPRHF3RkZpb0lrNjFhS0FUK1pvTnd1UzI0?=
 =?utf-8?B?QkRLODR5U0lpek94NU9zVkRxZzR0RjhQdkZkN29qemlwUWJiQ1ZlKzRuckJm?=
 =?utf-8?B?MWZOWWhKNWpIeEUyTlkrNlZZa04zaE5ZK25Nblpkc3V6MDdCcTlON1l4RnQy?=
 =?utf-8?B?SmlFTmtKUFJEemNxNWxYK2txM1Z1VzV6anVZSUlLaVdiajRyWmVZUXVCeVBq?=
 =?utf-8?B?cjBWQ21XNlZaM2wvKzlyK3dpSU8xU3ZmQlVTQkx0LzRJOUJMZUJJUzFndkl1?=
 =?utf-8?B?WXZSU1FDS0hiRnpRb1g4SGluRzFXNVVVT1BtTWFuNFlNUlROK1B2Z0R3OStE?=
 =?utf-8?B?ajlPTUdubW5QZDdzWEdLcTFETURxeTN1VERTRlJlRGdIZDREWVNEdFd2NlBr?=
 =?utf-8?B?MlhsYUIxaWdld2I0eTVHRlM3QVlPYkxBZGlEKzUzR3U2RWpxaHdjVmtjRHFu?=
 =?utf-8?B?UnRoQkxkYmlHZ3ZlZzBlRHVsV0xVd09KcDJHWmdNMFJMK0pVRGZWM3ZsZE5h?=
 =?utf-8?B?bGcyR1dBeis5eFpETEUvTkRsMzVvbzVKU3R4NiswODVxb1E5SU9DY3pBZzdi?=
 =?utf-8?B?ZXUrS1A1YVNWK1NFOUdlN0xBbEVDeS8vR0d4VzVQOC9vZkVKZ2c3UGNDZXZW?=
 =?utf-8?Q?qaKw/kQqAhhNR7cIspGJluw=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(52116014)(376014)(1800799024)(19092799006)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dWhMeDVYTmZOeCs2eFNmYXYzQU9sSm1wTGNCNWNtNlZiZUdYTHBaRlJyZmtu?=
 =?utf-8?B?QTR0Rlo4S2FWdDZydDVkaTVJMC9OemYrclJ4Y1M2UFpzR1VGYk1adGJpT1ZZ?=
 =?utf-8?B?RVhKTXRURDZwejZYL3V1eGY4K2xMVWVFaEVNNzdIemhKejZLNDF3Wmx0NXAy?=
 =?utf-8?B?a2V6MC8xTmxPbnF6d3hpMkxCd1g1dlMvNTlpQXZNeU5aenlxRzk2cVdMNmtT?=
 =?utf-8?B?Rm9SRWVxM3ZMZUpqWkNsb2J6Z0Izb1FwemJkbkdITEp3Rkl2Q1IwYndpTWVh?=
 =?utf-8?B?TkFscDZBTUlIQUt0MTZQeUpoNnpwVzcraW1lUjBZQll6NXl2OU5iVWJRME4z?=
 =?utf-8?B?VzZ5aDJseEVldS9rcUJ2N2pZeExiVWRkbWhKL1BpUTJCR0k4ZVNhbFc2Rmpq?=
 =?utf-8?B?ck5zYVpsZlFZTFVBWU8xb3NCV1MxL2dXaCsvUkJtcWZzZEFUdmJPYXpiWUQy?=
 =?utf-8?B?ejhJa2c4aG9XS0s0OG4zU1BPdXAxdHdBNEZFTVFEU0s5L0Q1bWlTVWRmVits?=
 =?utf-8?B?amF3Vm9VZmtnSHp3RGFYWFBhOXJ0MFZnQmUwNS9ZZDlaSHhtaUhrRTRST29P?=
 =?utf-8?B?SEoyUTVQTDZIdU9yQ3ZNUzZZb2MxSi9lWjFLanZwWXdtMFE4ZXh0ZzVGaWJ0?=
 =?utf-8?B?elRSTVF3aExSU1diYm0rNXVUajkzQzU4c2JqUFUxYnZWUjVFR0VRWXRzWlVa?=
 =?utf-8?B?dHFrWE1YMkFkS250T2FhNlM1WTZLUDJSWWhlRGZ6WnloTWp4cGc5MmZmbkIy?=
 =?utf-8?B?OXJnS1I5L24ycVI1R05PeFN6THdNdjd4M2RleXhEKzEwMHFFWDhrY1p2bHho?=
 =?utf-8?B?NWRxcjk2TUNtMjRFamxZNkEzcER3bDk5QldEanJzdkU2b3l3ZU9yODNsQktR?=
 =?utf-8?B?eTV0N082N2Rjays5Ky9LSWFzNkRaV1p5UjRHb2YzbVZQdVgyR2VqN3BQTDBS?=
 =?utf-8?B?a2UwTThCSktDM0hSTmpaclZWVFF2bXE3RDQ5eFZiK1ZCM3NWUEt2bHlsNnVW?=
 =?utf-8?B?eGpRVFFtQzNRbUVvZGdvbWh2dkNHSGVQTVJFeGtOM3JnMHdCa0RJZUxmRXRp?=
 =?utf-8?B?SWlmSm5VQmlRZE4zVHlkOEV6MFV0M0czWkh4MWNZNzNseEowcENGYnl0U0Vv?=
 =?utf-8?B?cGJpVkwyOU5ha01PbVRFV3NPa2RYbTJhc0N2MXIxbXZFbUFCRlNaV3JmV285?=
 =?utf-8?B?Ny8xNkc2TVNxbzFoL3NrT2Q1NHY3T3Izc000Y3gwSXZRQVVkWmFiemR2Qkht?=
 =?utf-8?B?VTI0OXZvSjNkSWdnSERqYXFPbGYwaXBuK3QzWmF5ajdxK2N2RG44blpDYVVT?=
 =?utf-8?B?STV2NW9ET2ZPV0dpaGFPVExJOGlzQ2pleFFnaHdhS1piM1lzQkZBVisvWlpF?=
 =?utf-8?B?bUZiem5hWmZqdm5idDlESWY2ekhpM2JlUmtQLy85ZGFJSW82Zkgwa3B0R3Jx?=
 =?utf-8?B?Z0VTYlI0N1pNN1pWQTJ1ek9VQlFaQlFLdkNYWlBZQ3V6Q1RjZDZhT1FndVAr?=
 =?utf-8?B?OWRNaEVXSjhEamFmRktFbjVBYlNiUmFtR25sWS9zNFlGUnNUWFlrUGNZeS9H?=
 =?utf-8?B?OCtEVSs4UkYxYUcycXRQdnE1all0SzdHMEpTcngxcHN4THNES3c1ajZyWVdo?=
 =?utf-8?B?WE05V3dvNmVSRy8vVmpsUzMrNzVoUTZRR3NNWEdVVkJQNUJiSDcwZk00K1pH?=
 =?utf-8?B?bzFwSFQ0bWc4UVdrZVNOblJFLzRPTWZSUzBxSU04Zm1qbTV2N01jVEtsY2dJ?=
 =?utf-8?B?OUZ5Z3pyK1JzMVlHL2MreU96Q1Vpcy93ZWFRTlQ2SlBPVjdERUIxRlJMZXlD?=
 =?utf-8?B?NFQ1WEEzVDRCZlRFUDBaSjdXQUFjZndyNVVkMVdiMUNRclJrbmFyOVdMemFa?=
 =?utf-8?B?SVZhNlhuT0s0Y0lWck5ienUrZFpFbEs2OTRDUUQ0OFZHZFhoSXcvQURhRTQr?=
 =?utf-8?B?S2swa1lLK0JsemRRb1NqMFB5MkZubVNwOXBpbXoxVU94QlJHSmM5bFlWSjZw?=
 =?utf-8?B?Y21uK0Y0dk51MlpTSVlHY0t4ZGV3NzNyRi80WkhNSHFLNHdrb0NxaU9EcVdn?=
 =?utf-8?B?TERha0dpaUlLWmVNTnVjMElrRXBadGl2UkFpTzBEak5RcDIvZDNXMDlUUW5a?=
 =?utf-8?B?SXl4OEtDOGt1RkVxVnd2dVBjeVRJM2txMDI1d1JqZDM4MDFlc01nMThrR3pt?=
 =?utf-8?B?NXNZQzY2Nnp0YjE3bW1MOVV3OXZYMlJpdXR0YWxYWVYvNGJCUUYySmNOTC9v?=
 =?utf-8?B?L0wxS1IrK0ZXV2RKZEZDbkhhVVl1U3NqV3FWWmcwd29tdnM4ZGxkTytrRzJW?=
 =?utf-8?B?NTZvcjhkQm1tWFFTVmpLRzBZZ1ozQXU4SElMNUI2YW9tQXpMU3RVQT09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 852bd194-dd94-4e90-5dfa-08de5f1640eb
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2026 09:10:31.8010 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vtqo6QCT97c5YaiZjZcEBq55D6UPTdGuSztePSN/HcHx0z7k8p7+3HBFRcG5zI2a6JGJaM2S/Q78MM8Eca6RVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7484
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

Add i.MX95 CM7 node for remoteproc usage.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm/dts/imx95-u-boot.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/dts/imx95-u-boot.dtsi b/arch/arm/dts/imx95-u-boot.dtsi
index 591cb317508..6dec159752b 100644
--- a/arch/arm/dts/imx95-u-boot.dtsi
+++ b/arch/arm/dts/imx95-u-boot.dtsi
@@ -96,6 +96,10 @@
 			};
 		};
 	};
+
+	imx95-cm7 {
+		compatible = "fsl,imx95-cm7";
+	};
 };
 
 &A55_0 {

-- 
2.51.0

