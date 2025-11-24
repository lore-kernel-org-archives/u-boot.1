Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0107CFA466
	for <u-boot@archiver.kernel.org>; Mon, 24 Nov 2025 12:35:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1B6C083D8B;
	Mon, 24 Nov 2025 13:35:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="bWOtjaDC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0B86383D90; Mon, 24 Nov 2025 13:34:58 +0100 (CET)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C025F83BEF
 for <U-Boot@lists.denx.de>; Mon, 24 Nov 2025 13:34:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=buf0M5Mn/gXyo9/0iOHpRF1baC45KAa99ffZjlW63XPYPQHPFuSkP56hWSiSejKxHkAWkTt8j9kq1lea1wajVUSQgBQjQR33t7hb5AKsxMHX+NTKSDoGD124thxt1u+pfd/mTHu9hHjD8EDjOQCNA/FvKPKtHTLZHjhGbFg+9Gtb2PBtY2HMJl69Oiiyq/FXZJN+rLgETjZbZQhy0GoOLda9/64takYF1hp2heOohYZTOMYO9qBLoM99XaS8RnhvDUPWbxOEadLNeJ9dnr5StFWSMEQBJ/6lRxb0AXRtiDazxy2GCPwu4H7fNH5iT7EmfefPHsSpIt4RdEbiK+TM1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=odid1JGO9vwVi8JJw5Ag3NPTCORJyagaM3XqVB3XDlA=;
 b=EF/KDCPSoVJMEKWlRd9XKW5HEpZcGhLQyVZfof2UnnUS9ueRYXr1XOYovn+94vmKvnZTHiIpUX0aNj5dzawH59jLAhMa2yS12OBh33yqJK0b9pMFNYQtU4fPAbYP5hA6CNV234PcL55R/eBnw9NCxkWBjXf9YVQjXxN0pC5rg7Oni9tut4UEM/cGeswwKBI5cqSfGBzV+AcUAXF3BW6wOKdtHmAyX2hJ0f4KwdYtxQXrjiTYGhOm2sukzBTFs6XcgbhWdR0qEcDGju5+Chf+be/SJ+Oh1TIUjqSKTWv37RDcvdaUZ5c5oMFsPMOr1jqBYq8lVX5JYOt7JqAa07R6ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=odid1JGO9vwVi8JJw5Ag3NPTCORJyagaM3XqVB3XDlA=;
 b=bWOtjaDCUxJ4tT6jwYhFdrySEEvWD+0XfYREXDYhSHksPMeOy4Rs+QdH9If4JdCu0foIBdplPVh+ZDAFObAJxPQccgEtmwzC5JO+64Gg4512B761VXtDrTmHF3eEy4Aew9n2YzYrLGNNY652iP6GhDkA0qOy8g3wXEl9CTnw1w0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com (2603:10a6:150:2be::5)
 by PAXPR04MB9569.eurprd04.prod.outlook.com (2603:10a6:102:24c::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.17; Mon, 24 Nov
 2025 12:34:53 +0000
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::1033:5a9a:dc18:dad]) by GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::1033:5a9a:dc18:dad%4]) with mapi id 15.20.9343.016; Mon, 24 Nov 2025
 12:34:53 +0000
Message-ID: <1277cc7d-2031-4337-bde3-cc42742da040@cherry.de>
Date: Mon, 24 Nov 2025 13:34:52 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: v2025.10 env Kconfig rename (fb5235239aad) removed backward
 compatibility
From: Quentin Schulz <quentin.schulz@cherry.de>
To: Ozan Durgut <ozandurgut.2001@hotmail.com>, U-Boot@lists.denx.de
References: <DU2PPFBA6D4FC4D0E86306717E76599508AFDD2A@DU2PPFBA6D4FC4D.EURP189.PROD.OUTLOOK.COM>
 <f8fd3d39-9fb7-46f2-973d-7e0b595e1ad6@cherry.de>
Content-Language: en-US
In-Reply-To: <f8fd3d39-9fb7-46f2-973d-7e0b595e1ad6@cherry.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0257.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e8::11) To GVXPR04MB12038.eurprd04.prod.outlook.com
 (2603:10a6:150:2be::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GVXPR04MB12038:EE_|PAXPR04MB9569:EE_
X-MS-Office365-Filtering-Correlation-Id: f0128534-17ce-4c31-1658-08de2b55de3a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|1800799024|366016|376014|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cUFRYW9xSlMxbEZVUHc0WWRJb2pIdnQxeit5ZytCWDQ5cGZwT25PV0kxYXdx?=
 =?utf-8?B?OGd1eElVTXh6bmNNcDBJaUx1anpMTVZJY1RRRnE5QkUwR0dlUkx1Yjc1R1JF?=
 =?utf-8?B?dmFHOXowZGZvYmJ0MEQ0Q2NidytDMWlZeE0wSE5vZ0IyVFZCZzRWbENUZC9t?=
 =?utf-8?B?WDVwaHkxa1BJaEk2N3RBYlFIYmpVRi9Nd1lnNEY1YnhIUkE4VmtpYlVUN2Fq?=
 =?utf-8?B?QnVHbEtYZnk5SE96SDFkQUtOc2N6SnBIU2lCbXBkeEx1NFdmN2pmSWtOaFR5?=
 =?utf-8?B?bG9mMmVqQXNjQXJQNmpFYWhYQVcyVGJ5ZUxTc1kvZkJ4QUxVL2laOEkzakRq?=
 =?utf-8?B?Ym1WQVJNd29ETTV1MGVpZUF0YzVIODEyc2ZUM2ZjZzROUmNvWXZVeUFEWkxq?=
 =?utf-8?B?STVEWnpHTUN3Mmh6SVFBelNJTXV5VXZoQ0NyWm56ZTZuZEJGUlAwcEp4Yy9y?=
 =?utf-8?B?MzdUUWpIc0hvSE9kMHcySlJwMlhhVGRoRG1QS3ZrOVFFSHBqT1E2NjdOVW8z?=
 =?utf-8?B?NG12QU5wNmRqTit6bGRyMm9Wa20wYVQyenlxZTJucituSDJtNEpWclRaWXJ0?=
 =?utf-8?B?bksyWFdNbVU2SFI1MjRxUkxDTHlRNjYvYjVpamUweDhvUm1GdGRkZXo3bGtM?=
 =?utf-8?B?MnVvTHFHc0xJL3BnZ05Od3hyNGNLRnNrUmduR1hraWFBbjM4MTI4blJDTTlx?=
 =?utf-8?B?TXhCVkdxaFRYUUFtbXAycEI3MzJzTEYzWmR4Y1lTVmZXZU9rOUduNWlEZUNZ?=
 =?utf-8?B?NWNjNUxrdWc1dzluajd4U3I4QlRvN2pRY3NyVFNLUXk1T3JNalB4TG5mcDZj?=
 =?utf-8?B?b3Q3bG1OTDVuNXNTak1XcVZuRWVBQWdyazBXNktUbldxTzhTVkVnMUFES3k1?=
 =?utf-8?B?ZTZmcWJpWGpHbXB5am9kUjhCaFQvSU9WWVdrTTFSeVRWaUYyaC9rSmVoRkQ0?=
 =?utf-8?B?T1VTeXNEQUpBdGlmcXBrNUluWFB4dzZuRjJhdnNHSWFpOHEwZ3BaRTV5RlV5?=
 =?utf-8?B?NjhiVHJacVRsYXVWZFpVNUU1M0E5dGdLM3hEdHpva0I3TE5EL054ZzZCTGFu?=
 =?utf-8?B?akt0ODhpTkJ0MWV4ZUJXWjQ4UjFKNmNXcWZaUWJnQ1BEajVLN2hidlNlZm0r?=
 =?utf-8?B?cVZUdlpHOGYvME51bFRpaVh1Q0ZValphVGNGaU5nY082RXE0RVJxVDlrL05K?=
 =?utf-8?B?Vkx5aE5TRzIrVmt0WEJnNmZmYlJYTEJqWFYyODhMUTJONVpKcG1zSHlDZTJB?=
 =?utf-8?B?NnRhY0hJc1dUbThmYkhmOENMWTd1ak9mOTZ3U0IvS0VWdWJYWEFhcGFPeDY1?=
 =?utf-8?B?aHBVNnlXZ1c0TU9EWFZvNHBOY2RBM3BwOWx3Tk5sMTFIc3doWEJDNmVyUHVY?=
 =?utf-8?B?SE9DZjl3cmN4Q1ExWEJubnYzS2YwRjNLbmtOZzlFZmJoY2dkcEQwYWMrNUd1?=
 =?utf-8?B?TU91SUtGbUxDV2hkK3h3WVhGWENUdyswZkdYZ3g5WFo5SWtuWTdYOEhjc2Vh?=
 =?utf-8?B?SlJLSWl5T1FBUDlGZklrR0g3NDdCdHVYVzZMTGtHYWdjNkhNZHY1dFBySW56?=
 =?utf-8?B?NzBkVjdIakJWam9yR0JMMDd4clAxR1FmRXdnL1lRVmhaMkpaNE5IckZVZkFq?=
 =?utf-8?B?OVFGRjVXYnJhQitTZ1ErRSswWXh4aVZ6N09pdUV1S1NMUGt1QWw1WkhQa1l5?=
 =?utf-8?B?UXI2NnVIOUErUElVbHJ5YXMyZmNxNzVLTjU5QzI3TXNZUXlIdTdyd2w4TWN2?=
 =?utf-8?B?ZUZRbTQ0Z0ViMUZ6dHZuWjJGODBUdHJISXVzT3pCbFM0dlhwN1oySWQwaUNh?=
 =?utf-8?B?Z0d4NUdjQlRmUXUwcnJBSmI2VG9iTVhhMDhqa3d5WUJGOTMxUEd4K2NkNXVo?=
 =?utf-8?B?eUdmR1U2WEhXd2h0OVJ5S0hxejc2bUxlMDF5QUtUd0pKNkE9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GVXPR04MB12038.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(1800799024)(366016)(376014)(7053199007); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ME91eHBST0lBUkdlTWR2eWhDYkRCb20vMU5LVEtSZjhvL085M0h5RTFqbGUv?=
 =?utf-8?B?MkFDZmQ5NFBYOE0yM1JhSWpqUnNRN3RFQUxoN2NJdWlGanppRmdGR2p6SHB0?=
 =?utf-8?B?dmpLY0N4UDNmWTZCWDBHU21wd01MUzIxbkpBaTBXRE9qN3ozendtS1FuQ3E0?=
 =?utf-8?B?WWVDaExwZnFFMU1SK0RzNjV5Z1FzSWhaMHpMZXlTTkN0bDhRS0x2WFA3WTZR?=
 =?utf-8?B?V3JpT0JmRmNISnVIZXlKMmk0dktkMVdXbTRUcTEvQ3Y1SWdQczN2bERmM3l5?=
 =?utf-8?B?YjkrTGxxT0JMc3hJd3RyYUs0dms4cU0xQ0J4STRDR2cxaGRqYmJWRytLN1FD?=
 =?utf-8?B?d2pVNmZEMGtJZjJvQkdZay93b243czFDUXY4Yld4bzNQTGsrUjE1VHpzWCts?=
 =?utf-8?B?RjhBeE1wcDQ2cWxRczhnRXI4aVFTOWE2bUU3Mi9xMUNnanZlaWJMb1FjeGJX?=
 =?utf-8?B?QlZwU0RwbjhtUE00blNJK2pDdXZRcEFYK1BMTlJqak91YVF2UXdOYTlicTU3?=
 =?utf-8?B?UTNFU0dqalNtQjBwd3d1c0hzd1luWXRnMkJGTVJ4U1lyaVJ3VUYvNXMxbUp1?=
 =?utf-8?B?SzVENWVET0o1WEMyOVpkVUJsZUlTK3ZFbUZZbmxDZVNkclYwN0pmM0swNzBo?=
 =?utf-8?B?a3liSHAxMTQwV2FwUUd1M3J6RmIvN0Fvdk5iMUROb0E3Z0F1cXhHZk15RkhY?=
 =?utf-8?B?SEFMQ1ZzSFE3WTEzOU1jelp3eTh0V1U2QWFkSWZ5TTNUVTF0UkJVTVlWU29R?=
 =?utf-8?B?SjNBeHRIWjMzOGNIdmMyblFBM2tFdUVhK2dOZms4YmtaSUthNWhPZjJTM1JW?=
 =?utf-8?B?VjI0ejZZZkpLdlRjVWxPbHROUUlNK2t2Ym9ZSnV1VVQrNkVTUzQzSUpKUGxO?=
 =?utf-8?B?YkEyRTd5UmxjN0tpMGkzRjlPQVRjdVR5eXNYaHBEVlBTQXRzNmQ1aytrdUVE?=
 =?utf-8?B?MlRxNGgxT3V3UTZXMHV5cWVLNUJsTU5YWDZ2Q1dCc2dxdVp2QkhWRjRtS1pE?=
 =?utf-8?B?Q0szL2cyeU9UdjdNeTY0RmJ4dmhJVWRaUFJtQWtpSkUzOWNha0I4cG1PYUpj?=
 =?utf-8?B?T3IzQ1VoSytlR3NvOHpOcytnaVJvQWNxVmhkY1ZwWkZkVTVRenpiOWdiZlhZ?=
 =?utf-8?B?THgySDNxRXdETm9aV3BFUVh0WDVucnhZeTBVWTArNFFPOXNlajlWS3JrQjd5?=
 =?utf-8?B?YkJMSGlxd0w4UDFVdDVNSlFZQUl5V1RibFdtMUJYelpJdVYzdDBJNGVTVGI0?=
 =?utf-8?B?VWtabnVZa0ZYV2NFRC9FNk5WT3JKWWw3eGFrRysxckVJTnBldjdhOTVydnRN?=
 =?utf-8?B?VE94cEY2T1FQUmw5ZHROb0xheHgzSS9rcWt1ODlDc0l0VXhBR084dWtsbHI3?=
 =?utf-8?B?NjA2aXp4cW41WTFqdWdaellHZHV2V1loeW5rYm82UnFxL1E3MloxWFRwTGk2?=
 =?utf-8?B?UEh2TWxTcWpPek5sZkhrNFpyMmhuSDFEYjF0WFNuZSt2S2tWT0doRnJuclJ1?=
 =?utf-8?B?eC9JSW1Rc0cvQlFaVWVJYndQY3BodHJWMlg5MktGUlZkRWhZdUpWbnNrZ0xt?=
 =?utf-8?B?TVZoZnRPS01xVkdLdkM2MXNKdC9xUnRBdWNQaTV5c3BuMU15TXdUOFlVODI4?=
 =?utf-8?B?TVFVMjhsZXVlUHZGbHNzWHdwWVBmRVl2L2FVZWFXQXlVTlRsT1BFUis3RXpO?=
 =?utf-8?B?ZHE1bkx3Tnl1L3MxL0k3NUdhRm1YeDZLTUt1bVAyeFEwUDNJdXB0d3E1K2xW?=
 =?utf-8?B?V0p5bVl5d1RMUDQxTGtvS1ZKZHlTSldEK0RnQkdKeVNoeHlhaGJOaTdscjFo?=
 =?utf-8?B?UEQvNmZGYkx1c0hMRUNsOVh2SDhHTnFaL0pGbGMvKzRFOGdwR3JJWlU2cnNY?=
 =?utf-8?B?QjUycHhuZnhaWGVJd2FnUzB4WWtVOUdEWkNVd3haZXAvZ1BDUUl6NVpQVzE3?=
 =?utf-8?B?NENrTWhSYmFtazZTWjNGM2pxRk1QVUM3UVJFWUFaZmpicGl1anNzeEtqUEFi?=
 =?utf-8?B?UE5kUlNqNFQvNjBHZUVBUXNydnp1citVTm1XU2R4V0tWZWlVRGNSL1BTejl3?=
 =?utf-8?B?dGFVRGFjUWtoWFBiSzZGbVo0ZTFnbEhFcmlwRDY2dUVYNXVBS01Lb2FXVkpD?=
 =?utf-8?B?OTQ0bXUyalRCVDZnSVV4UEYrSkJCaG53UCtqU01zZ3lUakFiZFNBMFFEL1BV?=
 =?utf-8?Q?OWU0EcxqQfUEqYs2mF3H/ao=3D?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: f0128534-17ce-4c31-1658-08de2b55de3a
X-MS-Exchange-CrossTenant-AuthSource: GVXPR04MB12038.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2025 12:34:53.4636 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ngjMATfNq+2Z3sHf61oGSxkO5YIyOFIbQQ5fmU7SwPh/rucUp5RTtArJ/luPCKvcaKNoyaDxQ+y+IGxxveb1sXDVmRVHy1oWp0dVE7shgXs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9569
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

On 11/24/25 1:32 PM, Quentin Schulz wrote:
> Hi Ozan,
> 
> On 11/22/25 2:18 PM, Ozan Durgut wrote:
>> [You don't often get email from ozandurgut.2001@hotmail.com. Learn why 
>> this is important at https://aka.ms/LearnAboutSenderIdentification ]
>>
>> Dear U-Boot maintainers,
>>
>> I hope you're doing well.
>>
>> I would like to raise a backward compatibility concern regarding commit
>> fb5235239aad ("env: Rename DEFAULT_ENV_FILE to
>> ENV_DEFAULT_ENV_TEXT_FILE"), which landed in the v2025.10 release.
>>
> 
> I don't think we ever advertised backward compatibility for Kconfig 
> symbols/defconfig.
> 
>> Previously used Kconfig symbols CONFIG_USE_DEFAULT_ENV_FILE and
>> CONFIG_DEFAULT_ENV_FILE have been replaced with
>> CONFIG_ENV_USE_DEFAULT_ENV_TEXT_FILE and
>> CONFIG_ENV_DEFAULT_ENV_TEXT_FILE. However, the old symbols were removed
>> outright, without a compatibility shim or deprecation period.
>>
>> This change causes breakage when integrating U-Boot with Buildroot, as
>> Buildroot currently lacks a mechanism to handle such changes
>> conditionally based on U-Boot's version. As a result, downstream users
>> are forced to choose between breaking support for older or newer U-Boot
>> versions.
>>
> 
> Currently yes, but that's an issue in Buildroot you can fix. This was 
> already asked on #u-boot and I already answered "just enable the new 
> option as well?" (https://libera.catirclogs.org/u- 
> boot/2025-11-20#39059950;). I've sent a patch to the Buildroot ML with a 
> tentative patch (though it doesn't seem to appear on the ML archive just 
> yet for some reason):

https://lore.kernel.org/all/20251124-uboot-env-rename-v1-1-7ac5a21da6e2@cherry.de/

Cheers,
Quentin
