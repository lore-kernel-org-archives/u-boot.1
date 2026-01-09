Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9609ED16818
	for <u-boot@archiver.kernel.org>; Fri,  9 Jan 2026 11:39:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 278E98433B;
	Fri,  9 Jan 2026 12:39:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="KY3ga8Wm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B537284332; Fri,  9 Jan 2026 12:39:06 +0100 (CET)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 79B4384248
 for <u-boot@lists.denx.de>; Fri,  9 Jan 2026 12:39:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wuhlwQQ2IXNRd7g3n9VEx1TpDRGoizTwUDDMAIaUBaRgm0n9iu1VmDpve1YumaQA/IkMxoiSAC+yioLa/ydX3MsiVxWbkKojwTHM1mUtelu+S8WKcRP/Tmp+BpwbK+xZnT7AOP0AZMiak8/4qBi351BlNavIC5gkaF13yrI00dq9mmcoK8+aFilwj7K04kxja2flcu3iuZra868HfSBiOtCbztTKu608rP0OkWAqi7ORok9XwvVMD1roKVyd26Ya9dh+y33Il8+wpdHxIE/ryrtVscDtDwKPQztkybERrGgMpUzT1IRBRXiCdeNeUpJbNfk1hQLX+DGQWv0xTuQGSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Swfyue8U2pt/hSNCE/XiZ/IWQlSOhB8ubxU/sMH1yY0=;
 b=fFWJTfJ3ccV8xtTm4J48/jUcrZ8uJ/DVro+nVbwbhNOu6OFLJHnhlqujWcBlByyfc7q7CqzClPrCfscP3uw9+14IVoHh0XVmOPKIH3ys4OH/RoQ40P+VFNQxLU+fjojcQJpLHTVrugAQgOvBOBDWIKSr01mOXFOUtJoV/2hDH0+EltYr/TdkTJh2zCt7hUXGMtumhCnNLaEqPZ3HqoihVK9GWW6yix2BK6+tE5gYb6GwEc8G6oYjGhxJYYMf8/doZbplmOphwxzIFwZNjIRWqwmkEL0kzVLuXWK5rLv67s8M6UlYCbXxKrjBi9ISP99iV53C/AU1bpCKvD5QTqWfxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Swfyue8U2pt/hSNCE/XiZ/IWQlSOhB8ubxU/sMH1yY0=;
 b=KY3ga8WmTo71MLCZRmwKn17bCIx3o0VQSBpIG366Uw+CKKm2pCI5zp49+AKMv2kkuKj3npYENthghI5Uvu0ftWCICXrUw4a4wR0hBNLcUkspYBTt1R7YvkYf1LDJ7dkTsAGlj0SjoV9JMDThXBw4N1KnNePs7vUbz4z/EPxQBI4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com (2603:10a6:150:2be::5)
 by DB8PR04MB6841.eurprd04.prod.outlook.com (2603:10a6:10:116::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.4; Fri, 9 Jan
 2026 11:39:02 +0000
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::1033:5a9a:dc18:dad]) by GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::1033:5a9a:dc18:dad%4]) with mapi id 15.20.9499.004; Fri, 9 Jan 2026
 11:39:02 +0000
Message-ID: <cc2e746e-9864-4fbe-aec3-2419667dab38@cherry.de>
Date: Fri, 9 Jan 2026 12:37:56 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH next v2 4/4] boot/fit: print all configuration node
 compatibles
To: Simon Glass <sjg@chromium.org>, Quentin Schulz <foss+uboot@0leil.net>
Cc: Tom Rini <trini@konsulko.com>, Jonas Karlman <jonas@kwiboo.se>,
 u-boot@lists.denx.de, Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Wolfgang Wallner <wolfgang.wallner@br-automation.com>,
 Paul HENRYS <paul.henrys_ext@softathome.com>,
 Shiji Yang <yangshiji66@outlook.com>,
 Anton Moryakov <ant.v.moryakov@gmail.com>,
 Mayuresh Chitale <mchitale@ventanamicro.com>
References: <20251203-fit-compat-v2-0-0fea56f23809@cherry.de>
 <20251203-fit-compat-v2-4-0fea56f23809@cherry.de>
 <CAFLszTjqZhQVP0m8QUUKsJbJLZo4VZmH3+3sdVYn267EthAKzg@mail.gmail.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <CAFLszTjqZhQVP0m8QUUKsJbJLZo4VZmH3+3sdVYn267EthAKzg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR10CA0110.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:803:28::39) To GVXPR04MB12038.eurprd04.prod.outlook.com
 (2603:10a6:150:2be::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GVXPR04MB12038:EE_|DB8PR04MB6841:EE_
X-MS-Office365-Filtering-Correlation-Id: 91cdffe7-ee22-48e1-ec51-08de4f73afa8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VTdDSTdyQnozWm1IN09oOElPZFlpZnNEZTFGcUNwSTJxN2hCQkVNaEJ4YjFp?=
 =?utf-8?B?NldRSURDLzU4UXErMTdPMmp4SmRvM1lqaTdJN0pRb0dNOU5tQy8zNHZXb3ZO?=
 =?utf-8?B?d0J1NWg2ZlErZklPUUpUbkpnZmREd29Kc040WDVHM1laMnJKZFkzQ1MyN2Q0?=
 =?utf-8?B?RG4wWXpKQW9QRDI4d05wWTlXWStzSDJPSldXTUh4K0sxNGZjU3hLc3JPMHk0?=
 =?utf-8?B?SmxiMStTQzhYVCtzbmNsNDA3VnJDQmZNYmU0WXNTREtoaUFnU1pYOUhNZGFj?=
 =?utf-8?B?MUpMSmNxQnJrVTJqaStNS2sxdyt5K09aRS9Ja2FMOXRha2JZN3VLU3ZjclVp?=
 =?utf-8?B?eXhJaCtuNE5HZWE1Y1ZrVVV4S2V0ZTJ6STRva21CYkNFYkt4QVZ6R25sQmts?=
 =?utf-8?B?anhuMDdUaExDR3dJZWtXbStjL0lDVFN3MFVRWkEyb2c4T1E3UTB2ZWx5amM1?=
 =?utf-8?B?QVRJUUt3c1N3TzhlbjA5c2tnZ1NkOTdhcjkzekt3ekRIQW9ZYlZVNHpoc0lR?=
 =?utf-8?B?OWxpaVk3bldNT2xNUFF0a09vTENuVTFvU1paTkNUQ3JQTml0RzRMakxxU09T?=
 =?utf-8?B?OU4yc3huVkJwZitMOWM0cjZ1TjJNejFwR1RITWZjc3NHTVprbG80UzkvUy9l?=
 =?utf-8?B?VTM0Y0c5dWZvYTZMWGxlVTVWdldWZjVjR3ZPZ2UvaExIUk9sbUduZGV3VURI?=
 =?utf-8?B?cTg1S0NEaXVuVVRSS1h5a2hRcFFlZFFhNnIxL3Rlb3dmRmFsSTVBMU5YTFZS?=
 =?utf-8?B?QUhtTUZNTzBENjYzbGVBc1pQRWl4Wm94RFFraVp2dHJEVUhHaCswcDFEeWhp?=
 =?utf-8?B?L1U0ck1YN2V1M1VmVDFvMHgzUXBOazB1Tmplc1VBYXp2SnRwb3M4UHk1WTFl?=
 =?utf-8?B?cnhyaGRFbGZxM01IYlV0U05GRkEwUk5RQ2dPUkE5YWJqYTl6Z2hjSXpKR29o?=
 =?utf-8?B?UkdDSUVGYjUyY1RYS1NNeTdLVnNjb1N5cjJ4VXNsMW1zSThBQkhtbTFPNzFn?=
 =?utf-8?B?UmdQTzlwRFNJSlFTYWJmOG9kN0syUWprUEtTR3hmdDJ6SUQ2MGNYUXZGZEla?=
 =?utf-8?B?SndjTDVDV2Z1cU0wOUgrTmtBK2pqOVFVNTkyWUNCb0h2b1UyUDhoWDc0NGN1?=
 =?utf-8?B?THdkN2Q5MjdYU0gzUXNZTTFwTmhmZEdXSDFIbktyckhXOXVrMVhOWHd3Tzdm?=
 =?utf-8?B?Z05QYitQTi9iNW5rMGZPaW1UOFozVURjZnVMTHdQTjdjSkhMZHJZRExQQXdp?=
 =?utf-8?B?cWtUV2tJSGNSWEt1WTM5bHNuTzh3ajlCYWdscWczRVR5Rzg4ZFJNM3FNWXBZ?=
 =?utf-8?B?azg5R1JlYTJHRHNMQWxINTIrbjZNZFpJWldiNGU4aEZNTm9DT2o1b1hjZkU0?=
 =?utf-8?B?a2ZKczBqdHFsc081bnZpY3l2UWUydHpqVFpKR2VpYkhkeXMvZ0FQTjFFZDFw?=
 =?utf-8?B?OWRNMCtoeExBUnZsaXhXUXVld1pYd1lUbCtGVFFHcnVsSTNjVmZ6cTZDOVVp?=
 =?utf-8?B?Wk1mUVlxNTZRZWw4UWZXV0htVWhhK0NUMXh5MEpobDZTaVRvTHhndGVrRUhO?=
 =?utf-8?B?OFpBNm54Zk11WnJINEV0Z1FsT3NUdE9oVFlvWStjRENjUEp5TnZCQml4QVJE?=
 =?utf-8?B?dGVhVGZnRS9SVFdCZ2JpUlI4QVVjb0pUNjNNTFUvV0dUK3I2NnEzYVh2Vnh3?=
 =?utf-8?B?K1U3d3VPRXlOYW16ZHhkaXpaY2hHelNnZnZjMTk1V1NnU3poOUhVMitkNXVS?=
 =?utf-8?B?dEw1ak5DMzhkSDQySkxpRHpmNnZBTmlpcVBGWmROVDd4SnVVR09kWjRqU3hv?=
 =?utf-8?B?VXArckRJQXVpb1FUcG5PMXFXN2xEV2ZsL2ZBbzFMeVRJaEZkaUdlZEg4d2VS?=
 =?utf-8?B?N2lyYzNqVFFyd01qL1htN1JWc1cyZVdvVTkvMG1ZU1FQVkFMTWl5M1lnem5j?=
 =?utf-8?Q?hubuKapUVfdokhSE5oJHUc256zjX8HEP?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GVXPR04MB12038.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(7416014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V0gyODNHRm5mTFdqTGU2T2xGRHM2NU1NWEt6ZlJLZ1NUNGpGVDhmK0Qxam94?=
 =?utf-8?B?NjRVSXY0R0RxTGdnend0TERWWi9FKzEwUkZ0eUhJZWhhZ3BSaUpoU1Q1YVF2?=
 =?utf-8?B?Vi80U3Z6dThWS0tVTW1TR0FtUVYwMzFhbVBmeG1RYlVKL3ZIZkM5YjNJVUsw?=
 =?utf-8?B?SjhEWnZtcHRHSlZZR1JQdFFNbzNQMk1RYXRwOG1QWnFOVWtvNlk0RC92MkJN?=
 =?utf-8?B?cUtvSkU0bk1PMGl5bk1SMUVMZnN0dzdOb20waXBtQzhpbks3bVN4SkZoZCtY?=
 =?utf-8?B?Zi9IakpnUEVFNUNyWktCNFFuMUxoemFBb28vcGE4cXdudnpkZkRzb05IdGdR?=
 =?utf-8?B?elBNZHNWQUpzZTR5NnVrQVdvbmFqTXgvVFVBT0xFQ2ZUMEsrbWoxQWFiWVRo?=
 =?utf-8?B?amdRVnJMTnY5bzJkV0x3UVc2bWRLR3VDcFUwRSs4U2xGWVdEQWxmTmV2Njd4?=
 =?utf-8?B?SVE2UldZZThoWjV6VXNyeE83MjFMc3hrN2x0NXhNQmlaTkkyQzc0MFo0eXZj?=
 =?utf-8?B?RzRvZFhOTlhBNW9tejJaNkVTZXg2RXlVQmlscXFudFhsQ0h4dlBQdTJ1YkNs?=
 =?utf-8?B?SmwxbmFlL3NQS0xBYlFHeStHREd3Z3ZKQ1VGWUl0MEJWemZsNVFxNFNPeTl1?=
 =?utf-8?B?elVocWY5MklleExkdGVJYkJ5dkR2TldYUVFtSmZUNWdzVEkrc2JsenVVMGpw?=
 =?utf-8?B?NjVLNkp5S0h6MnN1VUdCaEtFYzBhcGlrWjhnMGdtZmVWS0ZjeFQ0WUNtOUI1?=
 =?utf-8?B?b1Z6UHY1WWNhOVhFdWtaYzBXU3A5ZXB2RC80N1BZSjZVK0x0bUttcmFnd3Nk?=
 =?utf-8?B?QUROcUp6UWZsY3ZQeVZ2WFNBNXRSVVhOTW9QZU9EZmhaclJiY0JIY2p2NENZ?=
 =?utf-8?B?MDF6a3dTQmhuN0hSeUd5Ui9IcGNIbytRVG0wKy9LazlrRVp3NTNuU2ZuS1FO?=
 =?utf-8?B?QXFGc3g2S1ZYcXh3UUQyS2xkYjZ5Z3I4d0J0cXNLZGxxcnp1SGtJNHVQNVhx?=
 =?utf-8?B?eVRtNXM2cjkwRUx1MSt5UE9jcll4Q09ZM3NROFhrYkxBV1FHb0hqSzk0Q2Uy?=
 =?utf-8?B?am1zYkMzZ2Jpa1lCMlgzamVUMzI2MTVBVzZlTW5jeGFWYnhmQmwxY3QxQVEr?=
 =?utf-8?B?MTdDRW42U1IxSUUwVEdCZXd1aFVTUjF2MDBiOW5rVmJnNm5FMTNVM3ZSbVlH?=
 =?utf-8?B?elNsWTlhT2tzbFhZbFpqVTlEQ1JReG1LUTVCZ0FETTBWMDJzOEZUTGw5ckdr?=
 =?utf-8?B?Mklaay9XakFabjYvOE92Y0RZMVc1RlNHU3hZalc4SjRVZUpVNHROK0p1Qyt5?=
 =?utf-8?B?TzdKVEFIV2JGZmR6cGpjb1AxOS9aUFNtRmdiSCtiQmtJeFRjZE91OWp3dVpU?=
 =?utf-8?B?dXIyaW9IZ2VlekFvOWNXUzk2cWJIZUlwYnJsRkRjb2xmOFlMWTNkVjBXUnZz?=
 =?utf-8?B?TGhhTityK2c3dmFTNG85eUhySWMxaUdtQ3FsNkxuOThWVHhmVXFiSFh1SzBL?=
 =?utf-8?B?VUkzelE1OWFpcEhYa0hNRDNTOXczekxVQWJ3SXY4SE5tS3JFa1NjcjZ5TFFN?=
 =?utf-8?B?N3BwRHQ4TXhBSE9DUDMvaXhHTGhDTHQ4WWc0aHFKY3VPVm5oQVdNVmR2Rmt1?=
 =?utf-8?B?aVFVYTllNXlOZEt3U3lHcVFCenhHSVBtWlVsbG81UFBqbTBNaUFjTFpjWUhq?=
 =?utf-8?B?RHBHQWlrOEhxTDJ4YUFxOWtkdGlwR29URWNwU0pMbldOemZOR0taT1lYckhI?=
 =?utf-8?B?U04rVk5ScGI0aGlmVWxEdlRrTFlLR3NpY0hhVjRGaG5jUFg1UllOWjU0YUlN?=
 =?utf-8?B?K0tVYkhlNlB6czl3ME55ZXVrSEFHY25tVFJYb3NXeDJ1VEplcmg4ZVVEcWZl?=
 =?utf-8?B?UlF4TEJ5em9Ec0RHQTBMdFJEY01yL2VJSzYzTTUycXB2NWsydU53djkyQlVT?=
 =?utf-8?B?ZWtIb0oxU3VSUkxQWDd1Y1ZLZWNwWHU0WkwweUlwU1h1UXloZkR0WmtzSUlS?=
 =?utf-8?B?Z2x6c2ZtQ2RkaHJJT3ZzaUE3aXFNWUwxbldPZWhXVGlsSDQ2TDB1WnZQZkEx?=
 =?utf-8?B?aFRRQ2ZRQ3FTSlpRUzZDSlpoZUN5b3JFS3QxbWFscmVQNkluWHd6Vm5sQVhO?=
 =?utf-8?B?QVZ5cVVhWUVCR0ZTTTAvK2pqYzl3R1lGc0tSTlpBaGhnVWN0c1phdXBxQW5G?=
 =?utf-8?B?RHNHTURmS1BYRUZLSFZXVm14RkRpUStWNXduQUVocmVRSnp4blBvZUc5ZlFw?=
 =?utf-8?B?ajMvY3FHdlJpNnFQWFp3ZXNOMmhsMjZoNnVXK2QwcHE5MkVCQTQwVk11WEdp?=
 =?utf-8?B?aGQvdkd4NFRBdFF2MW16YnMvZTBFRzBoWk51bEtGSlJKWG1sTEo2a3RXOW50?=
 =?utf-8?Q?LyYwU8+Pm+yoRAPg=3D?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 91cdffe7-ee22-48e1-ec51-08de4f73afa8
X-MS-Exchange-CrossTenant-AuthSource: GVXPR04MB12038.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2026 11:39:02.3916 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eIDHzquU2v+lUz8M121kexjaiTtXfBQ6Noq4kPvT1UMADZi9vNhlOmx/al0b+LhfqTodFgI7UVUL7orLHpdxFVbm33kGdt2W2My4hpQwZHw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6841
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

Hi Simon,

On 1/9/26 12:35 PM, Simon Glass wrote:
> On Wed, 3 Dec 2025 at 09:19, Quentin Schulz <foss+uboot@0leil.net> wrote:
[...]
> 
> Reviewed-by: Simon Glass <simon.glass@canonical.com>
> 

Thanks!

> Concept has:
> 
> 40fd6b04b9f boot: Show compatible strings with FIT information

? I don't understand what you mean?

Cheers,
Quentin
